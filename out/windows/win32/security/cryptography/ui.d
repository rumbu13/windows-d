// Written in the D programming language.

module windows.win32.security.cryptography.ui;

public import windows.core;
public import windows.win32.foundation : BOOL, HANDLE, HINSTANCE, HRESULT, HWND,
                                         LPARAM, PSTR, PWSTR, WPARAM;
public import windows.win32.security.cryptography : CERT_CHAIN_CONTEXT, CERT_CONTEXT, CRL_CONTEXT,
                                                    CRYPT_ATTRIBUTES, CRYPT_INTEGER_BLOB,
                                                    CRYPT_KEY_FLAGS, CRYPT_KEY_PROV_INFO,
                                                    CTL_CONTEXT, HCERTSTORE;
public import windows.win32.security.wintrust : CRYPT_PROVIDER_DATA;
public import windows.win32.ui.controls : PROPSHEETPAGEA, PROPSHEETPAGEW;

extern(Windows) @nogc nothrow:


// Enums


alias CRYPTUI_WIZ_FLAGS = uint;
enum : uint
{
    CRYPTUI_WIZ_NO_UI                        = 0x00000001U,
    CRYPTUI_WIZ_IGNORE_NO_UI_FLAG_FOR_CSPS   = 0x00000002U,
    CRYPTUI_WIZ_NO_UI_EXCEPT_CSP             = 0x00000003U,
    CRYPTUI_WIZ_IMPORT_ALLOW_CERT            = 0x00020000U,
    CRYPTUI_WIZ_IMPORT_ALLOW_CRL             = 0x00040000U,
    CRYPTUI_WIZ_IMPORT_ALLOW_CTL             = 0x00080000U,
    CRYPTUI_WIZ_IMPORT_NO_CHANGE_DEST_STORE  = 0x00010000U,
    CRYPTUI_WIZ_IMPORT_TO_LOCALMACHINE       = 0x00100000U,
    CRYPTUI_WIZ_IMPORT_TO_CURRENTUSER        = 0x00200000U,
    CRYPTUI_WIZ_IMPORT_REMOTE_DEST_STORE     = 0x00400000U,
    CRYPTUI_WIZ_EXPORT_PRIVATE_KEY           = 0x00000100U,
    CRYPTUI_WIZ_EXPORT_NO_DELETE_PRIVATE_KEY = 0x00000200U,
}

alias CRYPTUI_VIEWCERTIFICATE_FLAGS = uint;
enum : uint
{
    CRYPTUI_HIDE_HIERARCHYPAGE                         = 0x00000001U,
    CRYPTUI_HIDE_DETAILPAGE                            = 0x00000002U,
    CRYPTUI_DISABLE_EDITPROPERTIES                     = 0x00000004U,
    CRYPTUI_ENABLE_EDITPROPERTIES                      = 0x00000008U,
    CRYPTUI_DISABLE_ADDTOSTORE                         = 0x00000010U,
    CRYPTUI_ENABLE_ADDTOSTORE                          = 0x00000020U,
    CRYPTUI_ACCEPT_DECLINE_STYLE                       = 0x00000040U,
    CRYPTUI_IGNORE_UNTRUSTED_ROOT                      = 0x00000080U,
    CRYPTUI_DONT_OPEN_STORES                           = 0x00000100U,
    CRYPTUI_ONLY_OPEN_ROOT_STORE                       = 0x00000200U,
    CRYPTUI_WARN_UNTRUSTED_ROOT                        = 0x00000400U,
    CRYPTUI_ENABLE_REVOCATION_CHECKING                 = 0x00000800U,
    CRYPTUI_WARN_REMOTE_TRUST                          = 0x00001000U,
    CRYPTUI_DISABLE_EXPORT                             = 0x00002000U,
    CRYPTUI_ENABLE_REVOCATION_CHECK_END_CERT           = 0x00004000U,
    CRYPTUI_ENABLE_REVOCATION_CHECK_CHAIN              = 0x00008000U,
    CRYPTUI_ENABLE_REVOCATION_CHECK_CHAIN_EXCLUDE_ROOT = 0x00000800U,
    CRYPTUI_DISABLE_HTMLLINK                           = 0x00010000U,
    CRYPTUI_DISABLE_ISSUERSTATEMENT                    = 0x00020000U,
    CRYPTUI_CACHE_ONLY_URL_RETRIEVAL                   = 0x00040000U,
}

alias CERT_SELECT_STRUCT_FLAGS = uint;
enum : uint
{
    CSS_HIDE_PROPERTIES      = 0x00000001U,
    CSS_ENABLEHOOK           = 0x00000002U,
    CSS_ALLOWMULTISELECT     = 0x00000004U,
    CSS_SHOW_HELP            = 0x00000010U,
    CSS_ENABLETEMPLATE       = 0x00000020U,
    CSS_ENABLETEMPLATEHANDLE = 0x00000040U,
}

alias CRYPTUI_WIZ_IMPORT_SUBJECT_OPTION = uint;
enum : uint
{
    CRYPTUI_WIZ_IMPORT_SUBJECT_FILE         = 0x00000001U,
    CRYPTUI_WIZ_IMPORT_SUBJECT_CERT_CONTEXT = 0x00000002U,
    CRYPTUI_WIZ_IMPORT_SUBJECT_CTL_CONTEXT  = 0x00000003U,
    CRYPTUI_WIZ_IMPORT_SUBJECT_CRL_CONTEXT  = 0x00000004U,
    CRYPTUI_WIZ_IMPORT_SUBJECT_CERT_STORE   = 0x00000005U,
}

alias CRYPTUI_WIZ_DIGITAL_SIGN_SUBJECT = uint;
enum : uint
{
    CRYPTUI_WIZ_DIGITAL_SIGN_SUBJECT_BLOB = 0x00000002U,
    CRYPTUI_WIZ_DIGITAL_SIGN_SUBJECT_FILE = 0x00000001U,
    CRYPTUI_WIZ_DIGITAL_SIGN_SUBJECT_NONE = 0x00000000U,
}

alias CRYPTUI_WIZ_DIGITAL_SIGN = uint;
enum : uint
{
    CRYPTUI_WIZ_DIGITAL_SIGN_CERT  = 0x00000001U,
    CRYPTUI_WIZ_DIGITAL_SIGN_STORE = 0x00000002U,
    CRYPTUI_WIZ_DIGITAL_SIGN_PVK   = 0x00000003U,
    CRYPTUI_WIZ_DIGITAL_SIGN_NONE  = 0x00000000U,
}

alias CRYPTUI_WIZ_EXPORT_SUBJECT = uint;
enum : uint
{
    CRYPTUI_WIZ_EXPORT_CERT_CONTEXT                 = 0x00000001U,
    CRYPTUI_WIZ_EXPORT_CTL_CONTEXT                  = 0x00000002U,
    CRYPTUI_WIZ_EXPORT_CRL_CONTEXT                  = 0x00000003U,
    CRYPTUI_WIZ_EXPORT_CERT_STORE                   = 0x00000004U,
    CRYPTUI_WIZ_EXPORT_CERT_STORE_CERTIFICATES_ONLY = 0x00000005U,
}

alias CRYPTUI_WIZ_DIGITAL_SIGN_SIG_TYPE = uint;
enum : uint
{
    CRYPTUI_WIZ_DIGITAL_SIGN_COMMERCIAL = 0x00000001U,
    CRYPTUI_WIZ_DIGITAL_SIGN_INDIVIDUAL = 0x00000002U,
}

alias CRYPTUI_WIZ_DIGITAL_SIGN_PVK_OPTION = uint;
enum : uint
{
    CRYPTUI_WIZ_DIGITAL_SIGN_PVK_FILE = 0x00000001U,
    CRYPTUI_WIZ_DIGITAL_SIGN_PVK_PROV = 0x00000002U,
}

alias CERT_VIEWPROPERTIES_STRUCT_FLAGS = uint;
enum : uint
{
    CM_ENABLEHOOK       = 0x00000001U,
    CM_SHOW_HELP        = 0x00000002U,
    CM_SHOW_HELPICON    = 0x00000004U,
    CM_ENABLETEMPLATE   = 0x00000008U,
    CM_HIDE_ADVANCEPAGE = 0x00000010U,
    CM_HIDE_TRUSTPAGE   = 0x00000020U,
    CM_NO_NAMECHANGE    = 0x00000040U,
    CM_NO_EDITTRUST     = 0x00000080U,
    CM_HIDE_DETAILPAGE  = 0x00000100U,
    CM_ADD_CERT_STORES  = 0x00000200U,
}

alias CRYPTUI_WIZ_EXPORT_FORMAT = uint;
enum : uint
{
    CRYPTUI_WIZ_EXPORT_FORMAT_DER    = 0x00000001U,
    CRYPTUI_WIZ_EXPORT_FORMAT_PFX    = 0x00000002U,
    CRYPTUI_WIZ_EXPORT_FORMAT_PKCS7  = 0x00000003U,
    CRYPTUI_WIZ_EXPORT_FORMAT_BASE64 = 0x00000004U,
    CRYPTUI_WIZ_EXPORT_FORMAT_CRL    = 0x00000006U,
    CRYPTUI_WIZ_EXPORT_FORMAT_CTL    = 0x00000007U,
}

alias CRYPTUI_WIZ_DIGITAL_ADDITIONAL_CERT_CHOICE = uint;
enum : uint
{
    CRYPTUI_WIZ_DIGITAL_SIGN_ADD_CHAIN         = 0x00000001U,
    CRYPTUI_WIZ_DIGITAL_SIGN_ADD_CHAIN_NO_ROOT = 0x00000002U,
    CRYPTUI_WIZ_DIGITAL_SIGN_ADD_NONE          = 0x00000000U,
}

alias CTL_MODIFY_REQUEST_OPERATION = uint;
enum : uint
{
    CTL_MODIFY_REQUEST_ADD_TRUSTED     = 0x00000003U,
    CTL_MODIFY_REQUEST_ADD_NOT_TRUSTED = 0x00000001U,
    CTL_MODIFY_REQUEST_REMOVE          = 0x00000002U,
}

// Constants


enum uint CRYTPDLG_FLAGS_MASK = 0xff000000U;

enum : uint
{
    CRYPTDLG_REVOCATION_DEFAULT = 0x00000000U,
    CRYPTDLG_REVOCATION_ONLINE  = 0x80000000U,
    CRYPTDLG_REVOCATION_CACHE   = 0x40000000U,
    CRYPTDLG_REVOCATION_NONE    = 0x20000000U,
}

enum uint CRYPTDLG_CACHE_ONLY_URL_RETRIEVAL = 0x10000000U;

enum : uint
{
    CRYPTDLG_DISABLE_AIA = 0x08000000U,
    CRYPTDLG_POLICY_MASK = 0x0000ffffU,
}

enum uint POLICY_IGNORE_NON_CRITICAL_BC = 0x00000001U;
enum uint CRYPTDLG_ACTION_MASK = 0xffff0000U;

enum : uint
{
    ACTION_REVOCATION_DEFAULT_ONLINE = 0x00010000U,
    ACTION_REVOCATION_DEFAULT_CACHE  = 0x00020000U,
}

enum : uint
{
    CERT_DISPWELL_SELECT                 = 0x00000001U,
    CERT_DISPWELL_TRUST_CA_CERT          = 0x00000002U,
    CERT_DISPWELL_TRUST_LEAF_CERT        = 0x00000003U,
    CERT_DISPWELL_TRUST_ADD_CA_CERT      = 0x00000004U,
    CERT_DISPWELL_TRUST_ADD_LEAF_CERT    = 0x00000005U,
    CERT_DISPWELL_DISTRUST_CA_CERT       = 0x00000006U,
    CERT_DISPWELL_DISTRUST_LEAF_CERT     = 0x00000007U,
    CERT_DISPWELL_DISTRUST_ADD_CA_CERT   = 0x00000008U,
    CERT_DISPWELL_DISTRUST_ADD_LEAF_CERT = 0x00000009U,
}

enum uint CSS_SELECTCERT_MASK = 0x00ffffffU;

enum : uint
{
    SELCERT_PROPERTIES = 0x00000064U,
    SELCERT_FINEPRINT  = 0x00000065U,
    SELCERT_CERTLIST   = 0x00000066U,
    SELCERT_ISSUED_TO  = 0x00000067U,
    SELCERT_VALIDITY   = 0x00000068U,
    SELCERT_ALGORITHM  = 0x00000069U,
    SELCERT_SERIAL_NUM = 0x0000006aU,
    SELCERT_THUMBPRINT = 0x0000006bU,
}

enum uint CM_VIEWFLAGS_MASK = 0x00ffffffU;
enum uint CERTVIEW_CRYPTUI_LPARAM = 0x00800000U;

enum : uint
{
    CERT_FILTER_OP_EXISTS         = 0x00000001U,
    CERT_FILTER_OP_NOT_EXISTS     = 0x00000002U,
    CERT_FILTER_OP_EQUALITY       = 0x00000003U,
    CERT_FILTER_INCLUDE_V1_CERTS  = 0x00000001U,
    CERT_FILTER_VALID_TIME_RANGE  = 0x00000002U,
    CERT_FILTER_VALID_SIGNATURE   = 0x00000004U,
    CERT_FILTER_LEAF_CERTS_ONLY   = 0x00000008U,
    CERT_FILTER_ISSUER_CERTS_ONLY = 0x00000010U,
    CERT_FILTER_KEY_EXISTS        = 0x00000020U,
}

enum GUID CERT_CERTIFICATE_ACTION_VERIFY = GUID("7801ebd0-cf4b-11d0-851f-0060979387ea");
// Native encoding: ansi
enum const(wchar)* szCERT_CERTIFICATE_ACTION_VERIFY = "{7801ebd0-cf4b-11d0-851f-0060979387ea}";

enum : uint
{
    CERT_VALIDITY_BEFORE_START          = 0x00000001U,
    CERT_VALIDITY_AFTER_END             = 0x00000002U,
    CERT_VALIDITY_SIGNATURE_FAILS       = 0x00000004U,
    CERT_VALIDITY_CERTIFICATE_REVOKED   = 0x00000008U,
    CERT_VALIDITY_KEY_USAGE_EXT_FAILURE = 0x00000010U,
}

enum uint CERT_VALIDITY_EXTENDED_USAGE_FAILURE = 0x00000020U;
enum uint CERT_VALIDITY_NAME_CONSTRAINTS_FAILURE = 0x00000040U;
enum uint CERT_VALIDITY_UNKNOWN_CRITICAL_EXTENSION = 0x00000080U;

enum : uint
{
    CERT_VALIDITY_ISSUER_INVALID          = 0x00000100U,
    CERT_VALIDITY_OTHER_EXTENSION_FAILURE = 0x00000200U,
}

enum uint CERT_VALIDITY_PERIOD_NESTING_FAILURE = 0x00000400U;

enum : uint
{
    CERT_VALIDITY_OTHER_ERROR           = 0x00000800U,
    CERT_VALIDITY_ISSUER_DISTRUST       = 0x02000000U,
    CERT_VALIDITY_EXPLICITLY_DISTRUSTED = 0x01000000U,
}

enum : uint
{
    CERT_VALIDITY_NO_ISSUER_CERT_FOUND = 0x10000000U,
    CERT_VALIDITY_NO_CRL_FOUND         = 0x20000000U,
    CERT_VALIDITY_CRL_OUT_OF_DATE      = 0x40000000U,
    CERT_VALIDITY_NO_TRUST_DATA        = 0x80000000U,
    CERT_VALIDITY_MASK_TRUST           = 0xffff0000U,
    CERT_VALIDITY_MASK_VALIDITY        = 0x0000ffffU,
}

enum : uint
{
    CERT_TRUST_MASK                = 0x00ffffffU,
    CERT_TRUST_DO_FULL_SEARCH      = 0x00000001U,
    CERT_TRUST_PERMIT_MISSING_CRLS = 0x00000002U,
}

enum uint CERT_TRUST_DO_FULL_TRUST = 0x00000005U;
enum int CERT_CREDENTIAL_PROVIDER_ID = 0xfffffe03;

enum : ulong
{
    CRYPTUI_SELECT_ISSUEDTO_COLUMN     = 0x0000000000000001UL,
    CRYPTUI_SELECT_ISSUEDBY_COLUMN     = 0x0000000000000002UL,
    CRYPTUI_SELECT_INTENDEDUSE_COLUMN  = 0x0000000000000004UL,
    CRYPTUI_SELECT_FRIENDLYNAME_COLUMN = 0x0000000000000008UL,
    CRYPTUI_SELECT_LOCATION_COLUMN     = 0x0000000000000010UL,
    CRYPTUI_SELECT_EXPIRATION_COLUMN   = 0x0000000000000020UL,
}

enum : uint
{
    CRYPTUI_CERT_MGR_TAB_MASK        = 0x0000000fU,
    CRYPTUI_CERT_MGR_PUBLISHER_TAB   = 0x00000004U,
    CRYPTUI_CERT_MGR_SINGLE_TAB_FLAG = 0x00008000U,
}

enum : uint
{
    CRYPTUI_WIZ_DIGITAL_SIGN_EXCLUDE_PAGE_HASHES = 0x00000002U,
    CRYPTUI_WIZ_DIGITAL_SIGN_INCLUDE_PAGE_HASHES = 0x00000004U,
}

enum uint CRYPTUI_WIZ_EXPORT_FORMAT_SERIALIZED_CERT_STORE = 0x00000005U;

// Callbacks

alias PFNCMFILTERPROC = BOOL function(const(CERT_CONTEXT)* pCertContext, LPARAM param1, uint param2, uint param3);
alias PFNCMHOOKPROC = uint function(HWND hwndDialog, uint message, WPARAM wParam, LPARAM lParam);
alias PFNTRUSTHELPER = HRESULT function(const(CERT_CONTEXT)* pCertContext, LPARAM lCustData, BOOL fLeafCertificate, 
                                        ubyte* pbTrustBlob);
alias PFNCFILTERPROC = BOOL function(const(CERT_CONTEXT)* pCertContext, BOOL* pfInitialSelectedCert, 
                                     void* pvCallbackData);

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cryptdlg/ns-cryptdlg-cert_select_struct_a
struct CERT_SELECT_STRUCT_A
{
    uint            dwSize;
    HWND            hwndParent;
    HINSTANCE       hInstance;
    const(PSTR)     pTemplateName;
    CERT_SELECT_STRUCT_FLAGS dwFlags;
    const(PSTR)     szTitle;
    uint            cCertStore;
    HCERTSTORE*     arrayCertStore;
    const(PSTR)     szPurposeOid;
    uint            cCertContext;
    CERT_CONTEXT**  arrayCertContext;
    LPARAM          lCustData;
    PFNCMHOOKPROC   pfnHook;
    PFNCMFILTERPROC pfnFilter;
    const(PSTR)     szHelpFileName;
    uint            dwHelpId;
    size_t          hprov;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cryptdlg/ns-cryptdlg-cert_select_struct_w
struct CERT_SELECT_STRUCT_W
{
    uint            dwSize;
    HWND            hwndParent;
    HINSTANCE       hInstance;
    const(PWSTR)    pTemplateName;
    CERT_SELECT_STRUCT_FLAGS dwFlags;
    const(PWSTR)    szTitle;
    uint            cCertStore;
    HCERTSTORE*     arrayCertStore;
    const(PSTR)     szPurposeOid;
    uint            cCertContext;
    CERT_CONTEXT**  arrayCertContext;
    LPARAM          lCustData;
    PFNCMHOOKPROC   pfnHook;
    PFNCMFILTERPROC pfnFilter;
    const(PWSTR)    szHelpFileName;
    uint            dwHelpId;
    size_t          hprov;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cryptdlg/ns-cryptdlg-cert_viewproperties_struct_a
struct CERT_VIEWPROPERTIES_STRUCT_A
{
    uint                 dwSize;
    HWND                 hwndParent;
    HINSTANCE            hInstance;
    CERT_VIEWPROPERTIES_STRUCT_FLAGS dwFlags;
    const(PSTR)          szTitle;
    const(CERT_CONTEXT)* pCertContext;
    PSTR*                arrayPurposes;
    uint                 cArrayPurposes;
    uint                 cRootStores;
    HCERTSTORE*          rghstoreRoots;
    uint                 cStores;
    HCERTSTORE*          rghstoreCAs;
    uint                 cTrustStores;
    HCERTSTORE*          rghstoreTrust;
    size_t               hprov;
    LPARAM               lCustData;
    uint                 dwPad;
    const(PSTR)          szHelpFileName;
    uint                 dwHelpId;
    uint                 nStartPage;
    uint                 cArrayPropSheetPages;
    PROPSHEETPAGEA*      arrayPropSheetPages;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cryptdlg/ns-cryptdlg-cert_viewproperties_struct_w
struct CERT_VIEWPROPERTIES_STRUCT_W
{
    uint                 dwSize;
    HWND                 hwndParent;
    HINSTANCE            hInstance;
    CERT_VIEWPROPERTIES_STRUCT_FLAGS dwFlags;
    const(PWSTR)         szTitle;
    const(CERT_CONTEXT)* pCertContext;
    PSTR*                arrayPurposes;
    uint                 cArrayPurposes;
    uint                 cRootStores;
    HCERTSTORE*          rghstoreRoots;
    uint                 cStores;
    HCERTSTORE*          rghstoreCAs;
    uint                 cTrustStores;
    HCERTSTORE*          rghstoreTrust;
    size_t               hprov;
    LPARAM               lCustData;
    uint                 dwPad;
    const(PWSTR)         szHelpFileName;
    uint                 dwHelpId;
    uint                 nStartPage;
    uint                 cArrayPropSheetPages;
    PROPSHEETPAGEA*      arrayPropSheetPages;
}

struct CERT_FILTER_EXTENSION_MATCH
{
    const(PSTR) szExtensionOID;
    uint        dwTestOperation;
    ubyte*      pbTestData;
    uint        cbTestData;
}

struct CERT_FILTER_DATA
{
    uint dwSize;
    uint cExtensionChecks;
    CERT_FILTER_EXTENSION_MATCH* arrayExtensionChecks;
    uint dwCheckingFlags;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct CERT_VERIFY_CERTIFICATE_TRUST
{
    uint                 cbSize;
    const(CERT_CONTEXT)* pccert;
    uint                 dwFlags;
    uint                 dwIgnoreErr;
    uint*                pdwErrors;
    PSTR                 pszUsageOid;
    size_t               hprov;
    uint                 cRootStores;
    HCERTSTORE*          rghstoreRoots;
    uint                 cStores;
    HCERTSTORE*          rghstoreCAs;
    uint                 cTrustStores;
    HCERTSTORE*          rghstoreTrust;
    LPARAM               lCustData;
    PFNTRUSTHELPER       pfnTrustHelper;
    uint*                pcChain;
    CERT_CONTEXT***      prgChain;
    uint**               prgdwErrors;
    CRYPT_INTEGER_BLOB** prgpbTrustInfo;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cryptdlg/ns-cryptdlg-ctl_modify_request
struct CTL_MODIFY_REQUEST
{
    const(CERT_CONTEXT)* pccert;
    CTL_MODIFY_REQUEST_OPERATION dwOperation;
    uint                 dwError;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cryptuiapi/ns-cryptuiapi-cert_selectui_input
struct CERT_SELECTUI_INPUT
{
    HCERTSTORE           hStore;
    CERT_CHAIN_CONTEXT** prgpChain;
    uint                 cChain;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cryptuiapi/ns-cryptuiapi-cryptui_cert_mgr_struct
struct CRYPTUI_CERT_MGR_STRUCT
{
    uint         dwSize;
    HWND         hwndParent;
    uint         dwFlags;
    const(PWSTR) pwszTitle;
    const(PSTR)  pszInitUsageOID;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cryptuiapi/ns-cryptuiapi-cryptui_wiz_digital_sign_blob_info
struct CRYPTUI_WIZ_DIGITAL_SIGN_BLOB_INFO
{
    uint         dwSize;
    GUID*        pGuidSubject;
    uint         cbBlob;
    ubyte*       pbBlob;
    const(PWSTR) pwszDisplayName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cryptuiapi/ns-cryptuiapi-cryptui_wiz_digital_sign_store_info
struct CRYPTUI_WIZ_DIGITAL_SIGN_STORE_INFO
{
    uint           dwSize;
    uint           cCertStore;
    HCERTSTORE*    rghCertStore;
    PFNCFILTERPROC pFilterCallback;
    void*          pvCallbackData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cryptuiapi/ns-cryptuiapi-cryptui_wiz_digital_sign_pvk_file_info
struct CRYPTUI_WIZ_DIGITAL_SIGN_PVK_FILE_INFO
{
    uint  dwSize;
    PWSTR pwszPvkFileName;
    PWSTR pwszProvName;
    uint  dwProvType;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cryptuiapi/ns-cryptuiapi-cryptui_wiz_digital_sign_cert_pvk_info
struct CRYPTUI_WIZ_DIGITAL_SIGN_CERT_PVK_INFO
{
    uint  dwSize;
    PWSTR pwszSigningCertFileName;
    CRYPTUI_WIZ_DIGITAL_SIGN_PVK_OPTION dwPvkChoice;
    union
    {
        CRYPTUI_WIZ_DIGITAL_SIGN_PVK_FILE_INFO* pPvkFileInfo;
        CRYPT_KEY_PROV_INFO* pPvkProvInfo;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cryptuiapi/ns-cryptuiapi-cryptui_wiz_digital_sign_extended_info
struct CRYPTUI_WIZ_DIGITAL_SIGN_EXTENDED_INFO
{
    uint              dwSize;
    CRYPTUI_WIZ_DIGITAL_SIGN_SIG_TYPE dwAttrFlags;
    const(PWSTR)      pwszDescription;
    const(PWSTR)      pwszMoreInfoLocation;
    const(PSTR)       pszHashAlg;
    const(PWSTR)      pwszSigningCertDisplayString;
    HCERTSTORE        hAdditionalCertStore;
    CRYPT_ATTRIBUTES* psAuthenticated;
    CRYPT_ATTRIBUTES* psUnauthenticated;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cryptuiapi/ns-cryptuiapi-cryptui_wiz_digital_sign_info
struct CRYPTUI_WIZ_DIGITAL_SIGN_INFO
{
    uint         dwSize;
    CRYPTUI_WIZ_DIGITAL_SIGN_SUBJECT dwSubjectChoice;
    union
    {
        const(PWSTR) pwszFileName;
        CRYPTUI_WIZ_DIGITAL_SIGN_BLOB_INFO* pSignBlobInfo;
    }
    CRYPTUI_WIZ_DIGITAL_SIGN dwSigningCertChoice;
    union
    {
        const(CERT_CONTEXT)* pSigningCertContext;
        CRYPTUI_WIZ_DIGITAL_SIGN_STORE_INFO* pSigningCertStore;
        CRYPTUI_WIZ_DIGITAL_SIGN_CERT_PVK_INFO* pSigningCertPvkInfo;
    }
    const(PWSTR) pwszTimestampURL;
    CRYPTUI_WIZ_DIGITAL_ADDITIONAL_CERT_CHOICE dwAdditionalCertChoice;
    CRYPTUI_WIZ_DIGITAL_SIGN_EXTENDED_INFO* pSignExtInfo;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cryptuiapi/ns-cryptuiapi-cryptui_wiz_digital_sign_context
struct CRYPTUI_WIZ_DIGITAL_SIGN_CONTEXT
{
    uint   dwSize;
    uint   cbBlob;
    ubyte* pbBlob;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cryptuiapi/ns-cryptuiapi-cryptui_initdialog_struct
struct CRYPTUI_INITDIALOG_STRUCT
{
    LPARAM               lParam;
    const(CERT_CONTEXT)* pCertContext;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cryptuiapi/ns-cryptuiapi-cryptui_viewcertificate_structw
struct CRYPTUI_VIEWCERTIFICATE_STRUCTW
{
    uint                 dwSize;
    HWND                 hwndParent;
    CRYPTUI_VIEWCERTIFICATE_FLAGS dwFlags;
    const(PWSTR)         szTitle;
    const(CERT_CONTEXT)* pCertContext;
    const(PSTR)*         rgszPurposes;
    uint                 cPurposes;
    union
    {
        const(CRYPT_PROVIDER_DATA)* pCryptProviderData;
        HANDLE hWVTStateData;
    }
    BOOL                 fpCryptProviderDataTrustedUsage;
    uint                 idxSigner;
    uint                 idxCert;
    BOOL                 fCounterSigner;
    uint                 idxCounterSigner;
    uint                 cStores;
    HCERTSTORE*          rghStores;
    uint                 cPropSheetPages;
    PROPSHEETPAGEW*      rgPropSheetPages;
    uint                 nStartPage;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cryptuiapi/ns-cryptuiapi-cryptui_viewcertificate_structa
struct CRYPTUI_VIEWCERTIFICATE_STRUCTA
{
    uint                 dwSize;
    HWND                 hwndParent;
    CRYPTUI_VIEWCERTIFICATE_FLAGS dwFlags;
    const(PSTR)          szTitle;
    const(CERT_CONTEXT)* pCertContext;
    const(PSTR)*         rgszPurposes;
    uint                 cPurposes;
    union
    {
        const(CRYPT_PROVIDER_DATA)* pCryptProviderData;
        HANDLE hWVTStateData;
    }
    BOOL                 fpCryptProviderDataTrustedUsage;
    uint                 idxSigner;
    uint                 idxCert;
    BOOL                 fCounterSigner;
    uint                 idxCounterSigner;
    uint                 cStores;
    HCERTSTORE*          rghStores;
    uint                 cPropSheetPages;
    PROPSHEETPAGEA*      rgPropSheetPages;
    uint                 nStartPage;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cryptuiapi/ns-cryptuiapi-cryptui_wiz_export_info
struct CRYPTUI_WIZ_EXPORT_INFO
{
    uint         dwSize;
    const(PWSTR) pwszExportFileName;
    CRYPTUI_WIZ_EXPORT_SUBJECT dwSubjectChoice;
    union
    {
        const(CERT_CONTEXT)* pCertContext;
        CTL_CONTEXT*         pCTLContext;
        CRL_CONTEXT*         pCRLContext;
        HCERTSTORE           hCertStore;
    }
    uint         cStores;
    HCERTSTORE*  rghStores;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cryptuiapi/ns-cryptuiapi-cryptui_wiz_export_certcontext_info
struct CRYPTUI_WIZ_EXPORT_CERTCONTEXT_INFO
{
    uint         dwSize;
    CRYPTUI_WIZ_EXPORT_FORMAT dwExportFormat;
    BOOL         fExportChain;
    BOOL         fExportPrivateKeys;
    const(PWSTR) pwszPassword;
    BOOL         fStrongEncryption;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cryptuiapi/ns-cryptuiapi-cryptui_wiz_import_src_info
struct CRYPTUI_WIZ_IMPORT_SRC_INFO
{
    uint            dwSize;
    CRYPTUI_WIZ_IMPORT_SUBJECT_OPTION dwSubjectChoice;
    union
    {
        const(PWSTR)         pwszFileName;
        const(CERT_CONTEXT)* pCertContext;
        CTL_CONTEXT*         pCTLContext;
        CRL_CONTEXT*         pCRLContext;
        HCERTSTORE           hCertStore;
    }
    CRYPT_KEY_FLAGS dwFlags;
    const(PWSTR)    pwszPassword;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("CRYPTUI.dll")
BOOL CryptUIDlgViewContext(uint dwContextType, const(void)* pvContext, HWND hwnd, const(PWSTR) pwszTitle, 
                           uint dwFlags, void* pvReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("CRYPTUI.dll")
CERT_CONTEXT* CryptUIDlgSelectCertificateFromStore(HCERTSTORE hCertStore, HWND hwnd, const(PWSTR) pwszTitle, 
                                                   const(PWSTR) pwszDisplayString, uint dwDontUseColumn, 
                                                   uint dwFlags, void* pvReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("CRYPTUI.dll")
HRESULT CertSelectionGetSerializedBlob(CERT_SELECTUI_INPUT* pcsi, void** ppOutBuffer, uint* pulOutBufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("CRYPTUI.dll")
BOOL CryptUIDlgCertMgr(CRYPTUI_CERT_MGR_STRUCT* pCryptUICertMgr);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("CRYPTUI.dll")
BOOL CryptUIWizDigitalSign(uint dwFlags, HWND hwndParent, const(PWSTR) pwszWizardTitle, 
                           CRYPTUI_WIZ_DIGITAL_SIGN_INFO* pDigitalSignInfo, 
                           CRYPTUI_WIZ_DIGITAL_SIGN_CONTEXT** ppSignContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("CRYPTUI.dll")
BOOL CryptUIWizFreeDigitalSignContext(CRYPTUI_WIZ_DIGITAL_SIGN_CONTEXT* pSignContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("CRYPTUI.dll")
BOOL CryptUIDlgViewCertificateW(CRYPTUI_VIEWCERTIFICATE_STRUCTW* pCertViewInfo, BOOL* pfPropertiesChanged);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("CRYPTUI.dll")
BOOL CryptUIDlgViewCertificateA(CRYPTUI_VIEWCERTIFICATE_STRUCTA* pCertViewInfo, BOOL* pfPropertiesChanged);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("CRYPTUI.dll")
BOOL CryptUIWizExport(CRYPTUI_WIZ_FLAGS dwFlags, HWND hwndParent, const(PWSTR) pwszWizardTitle, 
                      CRYPTUI_WIZ_EXPORT_INFO* pExportInfo, void* pvoid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("CRYPTUI.dll")
BOOL CryptUIWizImport(CRYPTUI_WIZ_FLAGS dwFlags, HWND hwndParent, const(PWSTR) pwszWizardTitle, 
                      CRYPTUI_WIZ_IMPORT_SRC_INFO* pImportSrc, HCERTSTORE hDestCertStore);


