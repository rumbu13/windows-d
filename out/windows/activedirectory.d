module windows.activedirectory;

public import system;
public import windows.automation;
public import windows.com;
public import windows.controls;
public import windows.gdi;
public import windows.security;
public import windows.systemservices;
public import windows.winsock;
public import windows.windowsandmessaging;
public import windows.windowsprogramming;

extern(Windows):

struct CQFORM
{
    uint cbStruct;
    uint dwFlags;
    Guid clsid;
    HICON hIcon;
    const(wchar)* pszTitle;
}

alias LPCQADDFORMSPROC = extern(Windows) HRESULT function(LPARAM lParam, CQFORM* pForm);
alias LPCQADDPAGESPROC = extern(Windows) HRESULT function(LPARAM lParam, const(Guid)* clsidForm, CQPAGE* pPage);
alias LPCQPAGEPROC = extern(Windows) HRESULT function(CQPAGE* pPage, HWND hwnd, uint uMsg, WPARAM wParam, LPARAM lParam);
struct CQPAGE
{
    uint cbStruct;
    uint dwFlags;
    LPCQPAGEPROC pPageProc;
    HINSTANCE hInstance;
    int idPageName;
    int idPageTemplate;
    DLGPROC pDlgProc;
    LPARAM lParam;
}

const GUID IID_IQueryForm = {0x8CFCEE30, 0x39BD, 0x11D0, [0xB8, 0xD1, 0x00, 0xA0, 0x24, 0xAB, 0x2D, 0xBB]};
@GUID(0x8CFCEE30, 0x39BD, 0x11D0, [0xB8, 0xD1, 0x00, 0xA0, 0x24, 0xAB, 0x2D, 0xBB]);
interface IQueryForm : IUnknown
{
    HRESULT Initialize(HKEY hkForm);
    HRESULT AddForms(LPCQADDFORMSPROC pAddFormsProc, LPARAM lParam);
    HRESULT AddPages(LPCQADDPAGESPROC pAddPagesProc, LPARAM lParam);
}

const GUID IID_IPersistQuery = {0x1A3114B8, 0xA62E, 0x11D0, [0xA6, 0xC5, 0x00, 0xA0, 0xC9, 0x06, 0xAF, 0x45]};
@GUID(0x1A3114B8, 0xA62E, 0x11D0, [0xA6, 0xC5, 0x00, 0xA0, 0xC9, 0x06, 0xAF, 0x45]);
interface IPersistQuery : IPersist
{
    HRESULT WriteString(const(wchar)* pSection, const(wchar)* pValueName, const(wchar)* pValue);
    HRESULT ReadString(const(wchar)* pSection, const(wchar)* pValueName, const(wchar)* pBuffer, int cchBuffer);
    HRESULT WriteInt(const(wchar)* pSection, const(wchar)* pValueName, int value);
    HRESULT ReadInt(const(wchar)* pSection, const(wchar)* pValueName, int* pValue);
    HRESULT WriteStruct(const(wchar)* pSection, const(wchar)* pValueName, void* pStruct, uint cbStruct);
    HRESULT ReadStruct(const(wchar)* pSection, const(wchar)* pValueName, void* pStruct, uint cbStruct);
    HRESULT Clear();
}

struct OPENQUERYWINDOW
{
    uint cbStruct;
    uint dwFlags;
    Guid clsidHandler;
    void* pHandlerParameters;
    Guid clsidDefaultForm;
    IPersistQuery pPersistQuery;
    _Anonymous_e__Union Anonymous;
}

const GUID IID_ICommonQuery = {0xAB50DEC0, 0x6F1D, 0x11D0, [0xA1, 0xC4, 0x00, 0xAA, 0x00, 0xC1, 0x6E, 0x65]};
@GUID(0xAB50DEC0, 0x6F1D, 0x11D0, [0xA1, 0xC4, 0x00, 0xAA, 0x00, 0xC1, 0x6E, 0x65]);
interface ICommonQuery : IUnknown
{
    HRESULT OpenQueryWindow(HWND hwndParent, OPENQUERYWINDOW* pQueryWnd, IDataObject* ppDataObject);
}

const GUID CLSID_PropertyEntry = {0x72D3EDC2, 0xA4C4, 0x11D0, [0x85, 0x33, 0x00, 0xC0, 0x4F, 0xD8, 0xD5, 0x03]};
@GUID(0x72D3EDC2, 0xA4C4, 0x11D0, [0x85, 0x33, 0x00, 0xC0, 0x4F, 0xD8, 0xD5, 0x03]);
struct PropertyEntry;

const GUID CLSID_PropertyValue = {0x7B9E38B0, 0xA97C, 0x11D0, [0x85, 0x34, 0x00, 0xC0, 0x4F, 0xD8, 0xD5, 0x03]};
@GUID(0x7B9E38B0, 0xA97C, 0x11D0, [0x85, 0x34, 0x00, 0xC0, 0x4F, 0xD8, 0xD5, 0x03]);
struct PropertyValue;

const GUID CLSID_AccessControlEntry = {0xB75AC000, 0x9BDD, 0x11D0, [0x85, 0x2C, 0x00, 0xC0, 0x4F, 0xD8, 0xD5, 0x03]};
@GUID(0xB75AC000, 0x9BDD, 0x11D0, [0x85, 0x2C, 0x00, 0xC0, 0x4F, 0xD8, 0xD5, 0x03]);
struct AccessControlEntry;

const GUID CLSID_AccessControlList = {0xB85EA052, 0x9BDD, 0x11D0, [0x85, 0x2C, 0x00, 0xC0, 0x4F, 0xD8, 0xD5, 0x03]};
@GUID(0xB85EA052, 0x9BDD, 0x11D0, [0x85, 0x2C, 0x00, 0xC0, 0x4F, 0xD8, 0xD5, 0x03]);
struct AccessControlList;

const GUID CLSID_SecurityDescriptor = {0xB958F73C, 0x9BDD, 0x11D0, [0x85, 0x2C, 0x00, 0xC0, 0x4F, 0xD8, 0xD5, 0x03]};
@GUID(0xB958F73C, 0x9BDD, 0x11D0, [0x85, 0x2C, 0x00, 0xC0, 0x4F, 0xD8, 0xD5, 0x03]);
struct SecurityDescriptor;

const GUID CLSID_LargeInteger = {0x927971F5, 0x0939, 0x11D1, [0x8B, 0xE1, 0x00, 0xC0, 0x4F, 0xD8, 0xD5, 0x03]};
@GUID(0x927971F5, 0x0939, 0x11D1, [0x8B, 0xE1, 0x00, 0xC0, 0x4F, 0xD8, 0xD5, 0x03]);
struct LargeInteger;

const GUID CLSID_NameTranslate = {0x274FAE1F, 0x3626, 0x11D1, [0xA3, 0xA4, 0x00, 0xC0, 0x4F, 0xB9, 0x50, 0xDC]};
@GUID(0x274FAE1F, 0x3626, 0x11D1, [0xA3, 0xA4, 0x00, 0xC0, 0x4F, 0xB9, 0x50, 0xDC]);
struct NameTranslate;

const GUID CLSID_CaseIgnoreList = {0x15F88A55, 0x4680, 0x11D1, [0xA3, 0xB4, 0x00, 0xC0, 0x4F, 0xB9, 0x50, 0xDC]};
@GUID(0x15F88A55, 0x4680, 0x11D1, [0xA3, 0xB4, 0x00, 0xC0, 0x4F, 0xB9, 0x50, 0xDC]);
struct CaseIgnoreList;

const GUID CLSID_FaxNumber = {0xA5062215, 0x4681, 0x11D1, [0xA3, 0xB4, 0x00, 0xC0, 0x4F, 0xB9, 0x50, 0xDC]};
@GUID(0xA5062215, 0x4681, 0x11D1, [0xA3, 0xB4, 0x00, 0xC0, 0x4F, 0xB9, 0x50, 0xDC]);
struct FaxNumber;

const GUID CLSID_NetAddress = {0xB0B71247, 0x4080, 0x11D1, [0xA3, 0xAC, 0x00, 0xC0, 0x4F, 0xB9, 0x50, 0xDC]};
@GUID(0xB0B71247, 0x4080, 0x11D1, [0xA3, 0xAC, 0x00, 0xC0, 0x4F, 0xB9, 0x50, 0xDC]);
struct NetAddress;

const GUID CLSID_OctetList = {0x1241400F, 0x4680, 0x11D1, [0xA3, 0xB4, 0x00, 0xC0, 0x4F, 0xB9, 0x50, 0xDC]};
@GUID(0x1241400F, 0x4680, 0x11D1, [0xA3, 0xB4, 0x00, 0xC0, 0x4F, 0xB9, 0x50, 0xDC]);
struct OctetList;

const GUID CLSID_Email = {0x8F92A857, 0x478E, 0x11D1, [0xA3, 0xB4, 0x00, 0xC0, 0x4F, 0xB9, 0x50, 0xDC]};
@GUID(0x8F92A857, 0x478E, 0x11D1, [0xA3, 0xB4, 0x00, 0xC0, 0x4F, 0xB9, 0x50, 0xDC]);
struct Email;

const GUID CLSID_Path = {0xB2538919, 0x4080, 0x11D1, [0xA3, 0xAC, 0x00, 0xC0, 0x4F, 0xB9, 0x50, 0xDC]};
@GUID(0xB2538919, 0x4080, 0x11D1, [0xA3, 0xAC, 0x00, 0xC0, 0x4F, 0xB9, 0x50, 0xDC]);
struct Path;

const GUID CLSID_ReplicaPointer = {0xF5D1BADF, 0x4080, 0x11D1, [0xA3, 0xAC, 0x00, 0xC0, 0x4F, 0xB9, 0x50, 0xDC]};
@GUID(0xF5D1BADF, 0x4080, 0x11D1, [0xA3, 0xAC, 0x00, 0xC0, 0x4F, 0xB9, 0x50, 0xDC]);
struct ReplicaPointer;

const GUID CLSID_Timestamp = {0xB2BED2EB, 0x4080, 0x11D1, [0xA3, 0xAC, 0x00, 0xC0, 0x4F, 0xB9, 0x50, 0xDC]};
@GUID(0xB2BED2EB, 0x4080, 0x11D1, [0xA3, 0xAC, 0x00, 0xC0, 0x4F, 0xB9, 0x50, 0xDC]);
struct Timestamp;

const GUID CLSID_PostalAddress = {0x0A75AFCD, 0x4680, 0x11D1, [0xA3, 0xB4, 0x00, 0xC0, 0x4F, 0xB9, 0x50, 0xDC]};
@GUID(0x0A75AFCD, 0x4680, 0x11D1, [0xA3, 0xB4, 0x00, 0xC0, 0x4F, 0xB9, 0x50, 0xDC]);
struct PostalAddress;

const GUID CLSID_BackLink = {0xFCBF906F, 0x4080, 0x11D1, [0xA3, 0xAC, 0x00, 0xC0, 0x4F, 0xB9, 0x50, 0xDC]};
@GUID(0xFCBF906F, 0x4080, 0x11D1, [0xA3, 0xAC, 0x00, 0xC0, 0x4F, 0xB9, 0x50, 0xDC]);
struct BackLink;

const GUID CLSID_TypedName = {0xB33143CB, 0x4080, 0x11D1, [0xA3, 0xAC, 0x00, 0xC0, 0x4F, 0xB9, 0x50, 0xDC]};
@GUID(0xB33143CB, 0x4080, 0x11D1, [0xA3, 0xAC, 0x00, 0xC0, 0x4F, 0xB9, 0x50, 0xDC]);
struct TypedName;

const GUID CLSID_Hold = {0xB3AD3E13, 0x4080, 0x11D1, [0xA3, 0xAC, 0x00, 0xC0, 0x4F, 0xB9, 0x50, 0xDC]};
@GUID(0xB3AD3E13, 0x4080, 0x11D1, [0xA3, 0xAC, 0x00, 0xC0, 0x4F, 0xB9, 0x50, 0xDC]);
struct Hold;

const GUID CLSID_Pathname = {0x080D0D78, 0xF421, 0x11D0, [0xA3, 0x6E, 0x00, 0xC0, 0x4F, 0xB9, 0x50, 0xDC]};
@GUID(0x080D0D78, 0xF421, 0x11D0, [0xA3, 0x6E, 0x00, 0xC0, 0x4F, 0xB9, 0x50, 0xDC]);
struct Pathname;

const GUID CLSID_ADSystemInfo = {0x50B6327F, 0xAFD1, 0x11D2, [0x9C, 0xB9, 0x00, 0x00, 0xF8, 0x7A, 0x36, 0x9E]};
@GUID(0x50B6327F, 0xAFD1, 0x11D2, [0x9C, 0xB9, 0x00, 0x00, 0xF8, 0x7A, 0x36, 0x9E]);
struct ADSystemInfo;

const GUID CLSID_WinNTSystemInfo = {0x66182EC4, 0xAFD1, 0x11D2, [0x9C, 0xB9, 0x00, 0x00, 0xF8, 0x7A, 0x36, 0x9E]};
@GUID(0x66182EC4, 0xAFD1, 0x11D2, [0x9C, 0xB9, 0x00, 0x00, 0xF8, 0x7A, 0x36, 0x9E]);
struct WinNTSystemInfo;

const GUID CLSID_DNWithBinary = {0x7E99C0A3, 0xF935, 0x11D2, [0xBA, 0x96, 0x00, 0xC0, 0x4F, 0xB6, 0xD0, 0xD1]};
@GUID(0x7E99C0A3, 0xF935, 0x11D2, [0xBA, 0x96, 0x00, 0xC0, 0x4F, 0xB6, 0xD0, 0xD1]);
struct DNWithBinary;

const GUID CLSID_DNWithString = {0x334857CC, 0xF934, 0x11D2, [0xBA, 0x96, 0x00, 0xC0, 0x4F, 0xB6, 0xD0, 0xD1]};
@GUID(0x334857CC, 0xF934, 0x11D2, [0xBA, 0x96, 0x00, 0xC0, 0x4F, 0xB6, 0xD0, 0xD1]);
struct DNWithString;

const GUID CLSID_ADsSecurityUtility = {0xF270C64A, 0xFFB8, 0x4AE4, [0x85, 0xFE, 0x3A, 0x75, 0xE5, 0x34, 0x79, 0x66]};
@GUID(0xF270C64A, 0xFFB8, 0x4AE4, [0x85, 0xFE, 0x3A, 0x75, 0xE5, 0x34, 0x79, 0x66]);
struct ADsSecurityUtility;

enum ADSTYPEENUM
{
    ADSTYPE_INVALID = 0,
    ADSTYPE_DN_STRING = 1,
    ADSTYPE_CASE_EXACT_STRING = 2,
    ADSTYPE_CASE_IGNORE_STRING = 3,
    ADSTYPE_PRINTABLE_STRING = 4,
    ADSTYPE_NUMERIC_STRING = 5,
    ADSTYPE_BOOLEAN = 6,
    ADSTYPE_INTEGER = 7,
    ADSTYPE_OCTET_STRING = 8,
    ADSTYPE_UTC_TIME = 9,
    ADSTYPE_LARGE_INTEGER = 10,
    ADSTYPE_PROV_SPECIFIC = 11,
    ADSTYPE_OBJECT_CLASS = 12,
    ADSTYPE_CASEIGNORE_LIST = 13,
    ADSTYPE_OCTET_LIST = 14,
    ADSTYPE_PATH = 15,
    ADSTYPE_POSTALADDRESS = 16,
    ADSTYPE_TIMESTAMP = 17,
    ADSTYPE_BACKLINK = 18,
    ADSTYPE_TYPEDNAME = 19,
    ADSTYPE_HOLD = 20,
    ADSTYPE_NETADDRESS = 21,
    ADSTYPE_REPLICAPOINTER = 22,
    ADSTYPE_FAXNUMBER = 23,
    ADSTYPE_EMAIL = 24,
    ADSTYPE_NT_SECURITY_DESCRIPTOR = 25,
    ADSTYPE_UNKNOWN = 26,
    ADSTYPE_DN_WITH_BINARY = 27,
    ADSTYPE_DN_WITH_STRING = 28,
}

struct ADS_OCTET_STRING
{
    uint dwLength;
    ubyte* lpValue;
}

struct ADS_NT_SECURITY_DESCRIPTOR
{
    uint dwLength;
    ubyte* lpValue;
}

struct ADS_PROV_SPECIFIC
{
    uint dwLength;
    ubyte* lpValue;
}

struct ADS_CASEIGNORE_LIST
{
    ADS_CASEIGNORE_LIST* Next;
    const(wchar)* String;
}

struct ADS_OCTET_LIST
{
    ADS_OCTET_LIST* Next;
    uint Length;
    ubyte* Data;
}

struct ADS_PATH
{
    uint Type;
    const(wchar)* VolumeName;
    const(wchar)* Path;
}

struct ADS_POSTALADDRESS
{
    ushort* PostalAddress;
}

struct ADS_TIMESTAMP
{
    uint WholeSeconds;
    uint EventID;
}

struct ADS_BACKLINK
{
    uint RemoteID;
    const(wchar)* ObjectName;
}

struct ADS_TYPEDNAME
{
    const(wchar)* ObjectName;
    uint Level;
    uint Interval;
}

struct ADS_HOLD
{
    const(wchar)* ObjectName;
    uint Amount;
}

struct ADS_NETADDRESS
{
    uint AddressType;
    uint AddressLength;
    ubyte* Address;
}

struct ADS_REPLICAPOINTER
{
    const(wchar)* ServerName;
    uint ReplicaType;
    uint ReplicaNumber;
    uint Count;
    ADS_NETADDRESS* ReplicaAddressHints;
}

struct ADS_FAXNUMBER
{
    const(wchar)* TelephoneNumber;
    uint NumberOfBits;
    ubyte* Parameters;
}

struct ADS_EMAIL
{
    const(wchar)* Address;
    uint Type;
}

struct ADS_DN_WITH_BINARY
{
    uint dwLength;
    ubyte* lpBinaryValue;
    const(wchar)* pszDNString;
}

struct ADS_DN_WITH_STRING
{
    const(wchar)* pszStringValue;
    const(wchar)* pszDNString;
}

struct ADSVALUE
{
    ADSTYPEENUM dwType;
    _Anonymous_e__Union Anonymous;
}

struct ADS_ATTR_INFO
{
    const(wchar)* pszAttrName;
    uint dwControlCode;
    ADSTYPEENUM dwADsType;
    ADSVALUE* pADsValues;
    uint dwNumValues;
}

enum ADS_AUTHENTICATION_ENUM
{
    ADS_SECURE_AUTHENTICATION = 1,
    ADS_USE_ENCRYPTION = 2,
    ADS_USE_SSL = 2,
    ADS_READONLY_SERVER = 4,
    ADS_PROMPT_CREDENTIALS = 8,
    ADS_NO_AUTHENTICATION = 16,
    ADS_FAST_BIND = 32,
    ADS_USE_SIGNING = 64,
    ADS_USE_SEALING = 128,
    ADS_USE_DELEGATION = 256,
    ADS_SERVER_BIND = 512,
    ADS_NO_REFERRAL_CHASING = 1024,
    ADS_AUTH_RESERVED = -2147483648,
}

struct ADS_OBJECT_INFO
{
    const(wchar)* pszRDN;
    const(wchar)* pszObjectDN;
    const(wchar)* pszParentDN;
    const(wchar)* pszSchemaDN;
    const(wchar)* pszClassName;
}

enum ADS_STATUSENUM
{
    ADS_STATUS_S_OK = 0,
    ADS_STATUS_INVALID_SEARCHPREF = 1,
    ADS_STATUS_INVALID_SEARCHPREFVALUE = 2,
}

enum ADS_DEREFENUM
{
    ADS_DEREF_NEVER = 0,
    ADS_DEREF_SEARCHING = 1,
    ADS_DEREF_FINDING = 2,
    ADS_DEREF_ALWAYS = 3,
}

enum ADS_SCOPEENUM
{
    ADS_SCOPE_BASE = 0,
    ADS_SCOPE_ONELEVEL = 1,
    ADS_SCOPE_SUBTREE = 2,
}

enum ADS_PREFERENCES_ENUM
{
    ADSIPROP_ASYNCHRONOUS = 0,
    ADSIPROP_DEREF_ALIASES = 1,
    ADSIPROP_SIZE_LIMIT = 2,
    ADSIPROP_TIME_LIMIT = 3,
    ADSIPROP_ATTRIBTYPES_ONLY = 4,
    ADSIPROP_SEARCH_SCOPE = 5,
    ADSIPROP_TIMEOUT = 6,
    ADSIPROP_PAGESIZE = 7,
    ADSIPROP_PAGED_TIME_LIMIT = 8,
    ADSIPROP_CHASE_REFERRALS = 9,
    ADSIPROP_SORT_ON = 10,
    ADSIPROP_CACHE_RESULTS = 11,
    ADSIPROP_ADSIFLAG = 12,
}

enum ADSI_DIALECT_ENUM
{
    ADSI_DIALECT_LDAP = 0,
    ADSI_DIALECT_SQL = 1,
}

enum ADS_CHASE_REFERRALS_ENUM
{
    ADS_CHASE_REFERRALS_NEVER = 0,
    ADS_CHASE_REFERRALS_SUBORDINATE = 32,
    ADS_CHASE_REFERRALS_EXTERNAL = 64,
    ADS_CHASE_REFERRALS_ALWAYS = 96,
}

enum ADS_SEARCHPREF_ENUM
{
    ADS_SEARCHPREF_ASYNCHRONOUS = 0,
    ADS_SEARCHPREF_DEREF_ALIASES = 1,
    ADS_SEARCHPREF_SIZE_LIMIT = 2,
    ADS_SEARCHPREF_TIME_LIMIT = 3,
    ADS_SEARCHPREF_ATTRIBTYPES_ONLY = 4,
    ADS_SEARCHPREF_SEARCH_SCOPE = 5,
    ADS_SEARCHPREF_TIMEOUT = 6,
    ADS_SEARCHPREF_PAGESIZE = 7,
    ADS_SEARCHPREF_PAGED_TIME_LIMIT = 8,
    ADS_SEARCHPREF_CHASE_REFERRALS = 9,
    ADS_SEARCHPREF_SORT_ON = 10,
    ADS_SEARCHPREF_CACHE_RESULTS = 11,
    ADS_SEARCHPREF_DIRSYNC = 12,
    ADS_SEARCHPREF_TOMBSTONE = 13,
    ADS_SEARCHPREF_VLV = 14,
    ADS_SEARCHPREF_ATTRIBUTE_QUERY = 15,
    ADS_SEARCHPREF_SECURITY_MASK = 16,
    ADS_SEARCHPREF_DIRSYNC_FLAG = 17,
    ADS_SEARCHPREF_EXTENDED_DN = 18,
}

enum ADS_PASSWORD_ENCODING_ENUM
{
    ADS_PASSWORD_ENCODE_REQUIRE_SSL = 0,
    ADS_PASSWORD_ENCODE_CLEAR = 1,
}

struct ads_searchpref_info
{
    ADS_SEARCHPREF_ENUM dwSearchPref;
    ADSVALUE vValue;
    ADS_STATUSENUM dwStatus;
}

struct ads_search_column
{
    const(wchar)* pszAttrName;
    ADSTYPEENUM dwADsType;
    ADSVALUE* pADsValues;
    uint dwNumValues;
    HANDLE hReserved;
}

struct ADS_ATTR_DEF
{
    const(wchar)* pszAttrName;
    ADSTYPEENUM dwADsType;
    uint dwMinRange;
    uint dwMaxRange;
    BOOL fMultiValued;
}

struct ADS_CLASS_DEF
{
    const(wchar)* pszClassName;
    uint dwMandatoryAttrs;
    ushort** ppszMandatoryAttrs;
    uint optionalAttrs;
    ushort*** ppszOptionalAttrs;
    uint dwNamingAttrs;
    ushort*** ppszNamingAttrs;
    uint dwSuperClasses;
    ushort*** ppszSuperClasses;
    BOOL fIsContainer;
}

struct ADS_SORTKEY
{
    const(wchar)* pszAttrType;
    const(wchar)* pszReserved;
    ubyte fReverseorder;
}

struct ADS_VLV
{
    uint dwBeforeCount;
    uint dwAfterCount;
    uint dwOffset;
    uint dwContentCount;
    const(wchar)* pszTarget;
    uint dwContextIDLength;
    ubyte* lpContextID;
}

enum ADS_PROPERTY_OPERATION_ENUM
{
    ADS_PROPERTY_CLEAR = 1,
    ADS_PROPERTY_UPDATE = 2,
    ADS_PROPERTY_APPEND = 3,
    ADS_PROPERTY_DELETE = 4,
}

enum ADS_SYSTEMFLAG_ENUM
{
    ADS_SYSTEMFLAG_DISALLOW_DELETE = -2147483648,
    ADS_SYSTEMFLAG_CONFIG_ALLOW_RENAME = 1073741824,
    ADS_SYSTEMFLAG_CONFIG_ALLOW_MOVE = 536870912,
    ADS_SYSTEMFLAG_CONFIG_ALLOW_LIMITED_MOVE = 268435456,
    ADS_SYSTEMFLAG_DOMAIN_DISALLOW_RENAME = 134217728,
    ADS_SYSTEMFLAG_DOMAIN_DISALLOW_MOVE = 67108864,
    ADS_SYSTEMFLAG_CR_NTDS_NC = 1,
    ADS_SYSTEMFLAG_CR_NTDS_DOMAIN = 2,
    ADS_SYSTEMFLAG_ATTR_NOT_REPLICATED = 1,
    ADS_SYSTEMFLAG_ATTR_IS_CONSTRUCTED = 4,
}

enum ADS_GROUP_TYPE_ENUM
{
    ADS_GROUP_TYPE_GLOBAL_GROUP = 2,
    ADS_GROUP_TYPE_DOMAIN_LOCAL_GROUP = 4,
    ADS_GROUP_TYPE_LOCAL_GROUP = 4,
    ADS_GROUP_TYPE_UNIVERSAL_GROUP = 8,
    ADS_GROUP_TYPE_SECURITY_ENABLED = -2147483648,
}

enum ADS_USER_FLAG_ENUM
{
    ADS_UF_SCRIPT = 1,
    ADS_UF_ACCOUNTDISABLE = 2,
    ADS_UF_HOMEDIR_REQUIRED = 8,
    ADS_UF_LOCKOUT = 16,
    ADS_UF_PASSWD_NOTREQD = 32,
    ADS_UF_PASSWD_CANT_CHANGE = 64,
    ADS_UF_ENCRYPTED_TEXT_PASSWORD_ALLOWED = 128,
    ADS_UF_TEMP_DUPLICATE_ACCOUNT = 256,
    ADS_UF_NORMAL_ACCOUNT = 512,
    ADS_UF_INTERDOMAIN_TRUST_ACCOUNT = 2048,
    ADS_UF_WORKSTATION_TRUST_ACCOUNT = 4096,
    ADS_UF_SERVER_TRUST_ACCOUNT = 8192,
    ADS_UF_DONT_EXPIRE_PASSWD = 65536,
    ADS_UF_MNS_LOGON_ACCOUNT = 131072,
    ADS_UF_SMARTCARD_REQUIRED = 262144,
    ADS_UF_TRUSTED_FOR_DELEGATION = 524288,
    ADS_UF_NOT_DELEGATED = 1048576,
    ADS_UF_USE_DES_KEY_ONLY = 2097152,
    ADS_UF_DONT_REQUIRE_PREAUTH = 4194304,
    ADS_UF_PASSWORD_EXPIRED = 8388608,
    ADS_UF_TRUSTED_TO_AUTHENTICATE_FOR_DELEGATION = 16777216,
}

enum ADS_RIGHTS_ENUM
{
    ADS_RIGHT_DELETE = 65536,
    ADS_RIGHT_READ_CONTROL = 131072,
    ADS_RIGHT_WRITE_DAC = 262144,
    ADS_RIGHT_WRITE_OWNER = 524288,
    ADS_RIGHT_SYNCHRONIZE = 1048576,
    ADS_RIGHT_ACCESS_SYSTEM_SECURITY = 16777216,
    ADS_RIGHT_GENERIC_READ = -2147483648,
    ADS_RIGHT_GENERIC_WRITE = 1073741824,
    ADS_RIGHT_GENERIC_EXECUTE = 536870912,
    ADS_RIGHT_GENERIC_ALL = 268435456,
    ADS_RIGHT_DS_CREATE_CHILD = 1,
    ADS_RIGHT_DS_DELETE_CHILD = 2,
    ADS_RIGHT_ACTRL_DS_LIST = 4,
    ADS_RIGHT_DS_SELF = 8,
    ADS_RIGHT_DS_READ_PROP = 16,
    ADS_RIGHT_DS_WRITE_PROP = 32,
    ADS_RIGHT_DS_DELETE_TREE = 64,
    ADS_RIGHT_DS_LIST_OBJECT = 128,
    ADS_RIGHT_DS_CONTROL_ACCESS = 256,
}

enum ADS_ACETYPE_ENUM
{
    ADS_ACETYPE_ACCESS_ALLOWED = 0,
    ADS_ACETYPE_ACCESS_DENIED = 1,
    ADS_ACETYPE_SYSTEM_AUDIT = 2,
    ADS_ACETYPE_ACCESS_ALLOWED_OBJECT = 5,
    ADS_ACETYPE_ACCESS_DENIED_OBJECT = 6,
    ADS_ACETYPE_SYSTEM_AUDIT_OBJECT = 7,
    ADS_ACETYPE_SYSTEM_ALARM_OBJECT = 8,
    ADS_ACETYPE_ACCESS_ALLOWED_CALLBACK = 9,
    ADS_ACETYPE_ACCESS_DENIED_CALLBACK = 10,
    ADS_ACETYPE_ACCESS_ALLOWED_CALLBACK_OBJECT = 11,
    ADS_ACETYPE_ACCESS_DENIED_CALLBACK_OBJECT = 12,
    ADS_ACETYPE_SYSTEM_AUDIT_CALLBACK = 13,
    ADS_ACETYPE_SYSTEM_ALARM_CALLBACK = 14,
    ADS_ACETYPE_SYSTEM_AUDIT_CALLBACK_OBJECT = 15,
    ADS_ACETYPE_SYSTEM_ALARM_CALLBACK_OBJECT = 16,
}

enum ADS_ACEFLAG_ENUM
{
    ADS_ACEFLAG_INHERIT_ACE = 2,
    ADS_ACEFLAG_NO_PROPAGATE_INHERIT_ACE = 4,
    ADS_ACEFLAG_INHERIT_ONLY_ACE = 8,
    ADS_ACEFLAG_INHERITED_ACE = 16,
    ADS_ACEFLAG_VALID_INHERIT_FLAGS = 31,
    ADS_ACEFLAG_SUCCESSFUL_ACCESS = 64,
    ADS_ACEFLAG_FAILED_ACCESS = 128,
}

enum ADS_FLAGTYPE_ENUM
{
    ADS_FLAG_OBJECT_TYPE_PRESENT = 1,
    ADS_FLAG_INHERITED_OBJECT_TYPE_PRESENT = 2,
}

enum ADS_SD_CONTROL_ENUM
{
    ADS_SD_CONTROL_SE_OWNER_DEFAULTED = 1,
    ADS_SD_CONTROL_SE_GROUP_DEFAULTED = 2,
    ADS_SD_CONTROL_SE_DACL_PRESENT = 4,
    ADS_SD_CONTROL_SE_DACL_DEFAULTED = 8,
    ADS_SD_CONTROL_SE_SACL_PRESENT = 16,
    ADS_SD_CONTROL_SE_SACL_DEFAULTED = 32,
    ADS_SD_CONTROL_SE_DACL_AUTO_INHERIT_REQ = 256,
    ADS_SD_CONTROL_SE_SACL_AUTO_INHERIT_REQ = 512,
    ADS_SD_CONTROL_SE_DACL_AUTO_INHERITED = 1024,
    ADS_SD_CONTROL_SE_SACL_AUTO_INHERITED = 2048,
    ADS_SD_CONTROL_SE_DACL_PROTECTED = 4096,
    ADS_SD_CONTROL_SE_SACL_PROTECTED = 8192,
    ADS_SD_CONTROL_SE_SELF_RELATIVE = 32768,
}

enum ADS_SD_REVISION_ENUM
{
    ADS_SD_REVISION_DS = 4,
}

enum ADS_NAME_TYPE_ENUM
{
    ADS_NAME_TYPE_1779 = 1,
    ADS_NAME_TYPE_CANONICAL = 2,
    ADS_NAME_TYPE_NT4 = 3,
    ADS_NAME_TYPE_DISPLAY = 4,
    ADS_NAME_TYPE_DOMAIN_SIMPLE = 5,
    ADS_NAME_TYPE_ENTERPRISE_SIMPLE = 6,
    ADS_NAME_TYPE_GUID = 7,
    ADS_NAME_TYPE_UNKNOWN = 8,
    ADS_NAME_TYPE_USER_PRINCIPAL_NAME = 9,
    ADS_NAME_TYPE_CANONICAL_EX = 10,
    ADS_NAME_TYPE_SERVICE_PRINCIPAL_NAME = 11,
    ADS_NAME_TYPE_SID_OR_SID_HISTORY_NAME = 12,
}

enum ADS_NAME_INITTYPE_ENUM
{
    ADS_NAME_INITTYPE_DOMAIN = 1,
    ADS_NAME_INITTYPE_SERVER = 2,
    ADS_NAME_INITTYPE_GC = 3,
}

enum ADS_OPTION_ENUM
{
    ADS_OPTION_SERVERNAME = 0,
    ADS_OPTION_REFERRALS = 1,
    ADS_OPTION_PAGE_SIZE = 2,
    ADS_OPTION_SECURITY_MASK = 3,
    ADS_OPTION_MUTUAL_AUTH_STATUS = 4,
    ADS_OPTION_QUOTA = 5,
    ADS_OPTION_PASSWORD_PORTNUMBER = 6,
    ADS_OPTION_PASSWORD_METHOD = 7,
    ADS_OPTION_ACCUMULATIVE_MODIFICATION = 8,
    ADS_OPTION_SKIP_SID_LOOKUP = 9,
}

enum ADS_SECURITY_INFO_ENUM
{
    ADS_SECURITY_INFO_OWNER = 1,
    ADS_SECURITY_INFO_GROUP = 2,
    ADS_SECURITY_INFO_DACL = 4,
    ADS_SECURITY_INFO_SACL = 8,
}

enum ADS_SETTYPE_ENUM
{
    ADS_SETTYPE_FULL = 1,
    ADS_SETTYPE_PROVIDER = 2,
    ADS_SETTYPE_SERVER = 3,
    ADS_SETTYPE_DN = 4,
}

enum ADS_FORMAT_ENUM
{
    ADS_FORMAT_WINDOWS = 1,
    ADS_FORMAT_WINDOWS_NO_SERVER = 2,
    ADS_FORMAT_WINDOWS_DN = 3,
    ADS_FORMAT_WINDOWS_PARENT = 4,
    ADS_FORMAT_X500 = 5,
    ADS_FORMAT_X500_NO_SERVER = 6,
    ADS_FORMAT_X500_DN = 7,
    ADS_FORMAT_X500_PARENT = 8,
    ADS_FORMAT_SERVER = 9,
    ADS_FORMAT_PROVIDER = 10,
    ADS_FORMAT_LEAF = 11,
}

enum ADS_DISPLAY_ENUM
{
    ADS_DISPLAY_FULL = 1,
    ADS_DISPLAY_VALUE_ONLY = 2,
}

enum ADS_ESCAPE_MODE_ENUM
{
    ADS_ESCAPEDMODE_DEFAULT = 1,
    ADS_ESCAPEDMODE_ON = 2,
    ADS_ESCAPEDMODE_OFF = 3,
    ADS_ESCAPEDMODE_OFF_EX = 4,
}

enum ADS_PATHTYPE_ENUM
{
    ADS_PATH_FILE = 1,
    ADS_PATH_FILESHARE = 2,
    ADS_PATH_REGISTRY = 3,
}

enum ADS_SD_FORMAT_ENUM
{
    ADS_SD_FORMAT_IID = 1,
    ADS_SD_FORMAT_RAW = 2,
    ADS_SD_FORMAT_HEXSTRING = 3,
}

const GUID IID_IADs = {0xFD8256D0, 0xFD15, 0x11CE, [0xAB, 0xC4, 0x02, 0x60, 0x8C, 0x9E, 0x75, 0x53]};
@GUID(0xFD8256D0, 0xFD15, 0x11CE, [0xAB, 0xC4, 0x02, 0x60, 0x8C, 0x9E, 0x75, 0x53]);
interface IADs : IDispatch
{
    HRESULT get_Name(BSTR* retval);
    HRESULT get_Class(BSTR* retval);
    HRESULT get_GUID(BSTR* retval);
    HRESULT get_ADsPath(BSTR* retval);
    HRESULT get_Parent(BSTR* retval);
    HRESULT get_Schema(BSTR* retval);
    HRESULT GetInfo();
    HRESULT SetInfo();
    HRESULT Get(BSTR bstrName, VARIANT* pvProp);
    HRESULT Put(BSTR bstrName, VARIANT vProp);
    HRESULT GetEx(BSTR bstrName, VARIANT* pvProp);
    HRESULT PutEx(int lnControlCode, BSTR bstrName, VARIANT vProp);
    HRESULT GetInfoEx(VARIANT vProperties, int lnReserved);
}

const GUID IID_IADsContainer = {0x001677D0, 0xFD16, 0x11CE, [0xAB, 0xC4, 0x02, 0x60, 0x8C, 0x9E, 0x75, 0x53]};
@GUID(0x001677D0, 0xFD16, 0x11CE, [0xAB, 0xC4, 0x02, 0x60, 0x8C, 0x9E, 0x75, 0x53]);
interface IADsContainer : IDispatch
{
    HRESULT get_Count(int* retval);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT get_Filter(VARIANT* pVar);
    HRESULT put_Filter(VARIANT Var);
    HRESULT get_Hints(VARIANT* pvFilter);
    HRESULT put_Hints(VARIANT vHints);
    HRESULT GetObjectA(BSTR ClassName, BSTR RelativeName, IDispatch* ppObject);
    HRESULT Create(BSTR ClassName, BSTR RelativeName, IDispatch* ppObject);
    HRESULT Delete(BSTR bstrClassName, BSTR bstrRelativeName);
    HRESULT CopyHere(BSTR SourceName, BSTR NewName, IDispatch* ppObject);
    HRESULT MoveHere(BSTR SourceName, BSTR NewName, IDispatch* ppObject);
}

const GUID IID_IADsCollection = {0x72B945E0, 0x253B, 0x11CF, [0xA9, 0x88, 0x00, 0xAA, 0x00, 0x6B, 0xC1, 0x49]};
@GUID(0x72B945E0, 0x253B, 0x11CF, [0xA9, 0x88, 0x00, 0xAA, 0x00, 0x6B, 0xC1, 0x49]);
interface IADsCollection : IDispatch
{
    HRESULT get__NewEnum(IUnknown* ppEnumerator);
    HRESULT Add(BSTR bstrName, VARIANT vItem);
    HRESULT Remove(BSTR bstrItemToBeRemoved);
    HRESULT GetObjectA(BSTR bstrName, VARIANT* pvItem);
}

const GUID IID_IADsMembers = {0x451A0030, 0x72EC, 0x11CF, [0xB0, 0x3B, 0x00, 0xAA, 0x00, 0x6E, 0x09, 0x75]};
@GUID(0x451A0030, 0x72EC, 0x11CF, [0xB0, 0x3B, 0x00, 0xAA, 0x00, 0x6E, 0x09, 0x75]);
interface IADsMembers : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* ppEnumerator);
    HRESULT get_Filter(VARIANT* pvFilter);
    HRESULT put_Filter(VARIANT pvFilter);
}

const GUID IID_IADsPropertyList = {0xC6F602B6, 0x8F69, 0x11D0, [0x85, 0x28, 0x00, 0xC0, 0x4F, 0xD8, 0xD5, 0x03]};
@GUID(0xC6F602B6, 0x8F69, 0x11D0, [0x85, 0x28, 0x00, 0xC0, 0x4F, 0xD8, 0xD5, 0x03]);
interface IADsPropertyList : IDispatch
{
    HRESULT get_PropertyCount(int* plCount);
    HRESULT Next(VARIANT* pVariant);
    HRESULT Skip(int cElements);
    HRESULT Reset();
    HRESULT Item(VARIANT varIndex, VARIANT* pVariant);
    HRESULT GetPropertyItem(BSTR bstrName, int lnADsType, VARIANT* pVariant);
    HRESULT PutPropertyItem(VARIANT varData);
    HRESULT ResetPropertyItem(VARIANT varEntry);
    HRESULT PurgePropertyList();
}

const GUID IID_IADsPropertyEntry = {0x05792C8E, 0x941F, 0x11D0, [0x85, 0x29, 0x00, 0xC0, 0x4F, 0xD8, 0xD5, 0x03]};
@GUID(0x05792C8E, 0x941F, 0x11D0, [0x85, 0x29, 0x00, 0xC0, 0x4F, 0xD8, 0xD5, 0x03]);
interface IADsPropertyEntry : IDispatch
{
    HRESULT Clear();
    HRESULT get_Name(BSTR* retval);
    HRESULT put_Name(BSTR bstrName);
    HRESULT get_ADsType(int* retval);
    HRESULT put_ADsType(int lnADsType);
    HRESULT get_ControlCode(int* retval);
    HRESULT put_ControlCode(int lnControlCode);
    HRESULT get_Values(VARIANT* retval);
    HRESULT put_Values(VARIANT vValues);
}

const GUID IID_IADsPropertyValue = {0x79FA9AD0, 0xA97C, 0x11D0, [0x85, 0x34, 0x00, 0xC0, 0x4F, 0xD8, 0xD5, 0x03]};
@GUID(0x79FA9AD0, 0xA97C, 0x11D0, [0x85, 0x34, 0x00, 0xC0, 0x4F, 0xD8, 0xD5, 0x03]);
interface IADsPropertyValue : IDispatch
{
    HRESULT Clear();
    HRESULT get_ADsType(int* retval);
    HRESULT put_ADsType(int lnADsType);
    HRESULT get_DNString(BSTR* retval);
    HRESULT put_DNString(BSTR bstrDNString);
    HRESULT get_CaseExactString(BSTR* retval);
    HRESULT put_CaseExactString(BSTR bstrCaseExactString);
    HRESULT get_CaseIgnoreString(BSTR* retval);
    HRESULT put_CaseIgnoreString(BSTR bstrCaseIgnoreString);
    HRESULT get_PrintableString(BSTR* retval);
    HRESULT put_PrintableString(BSTR bstrPrintableString);
    HRESULT get_NumericString(BSTR* retval);
    HRESULT put_NumericString(BSTR bstrNumericString);
    HRESULT get_Boolean(int* retval);
    HRESULT put_Boolean(int lnBoolean);
    HRESULT get_Integer(int* retval);
    HRESULT put_Integer(int lnInteger);
    HRESULT get_OctetString(VARIANT* retval);
    HRESULT put_OctetString(VARIANT vOctetString);
    HRESULT get_SecurityDescriptor(IDispatch* retval);
    HRESULT put_SecurityDescriptor(IDispatch pSecurityDescriptor);
    HRESULT get_LargeInteger(IDispatch* retval);
    HRESULT put_LargeInteger(IDispatch pLargeInteger);
    HRESULT get_UTCTime(double* retval);
    HRESULT put_UTCTime(double daUTCTime);
}

const GUID IID_IADsPropertyValue2 = {0x306E831C, 0x5BC7, 0x11D1, [0xA3, 0xB8, 0x00, 0xC0, 0x4F, 0xB9, 0x50, 0xDC]};
@GUID(0x306E831C, 0x5BC7, 0x11D1, [0xA3, 0xB8, 0x00, 0xC0, 0x4F, 0xB9, 0x50, 0xDC]);
interface IADsPropertyValue2 : IDispatch
{
    HRESULT GetObjectProperty(int* lnADsType, VARIANT* pvProp);
    HRESULT PutObjectProperty(int lnADsType, VARIANT vProp);
}

const GUID IID_IPrivateDispatch = {0x86AB4BBE, 0x65F6, 0x11D1, [0x8C, 0x13, 0x00, 0xC0, 0x4F, 0xD8, 0xD5, 0x03]};
@GUID(0x86AB4BBE, 0x65F6, 0x11D1, [0x8C, 0x13, 0x00, 0xC0, 0x4F, 0xD8, 0xD5, 0x03]);
interface IPrivateDispatch : IUnknown
{
    HRESULT ADSIInitializeDispatchManager(int dwExtensionId);
    HRESULT ADSIGetTypeInfoCount(uint* pctinfo);
    HRESULT ADSIGetTypeInfo(uint itinfo, uint lcid, ITypeInfo* pptinfo);
    HRESULT ADSIGetIDsOfNames(const(Guid)* riid, ushort** rgszNames, uint cNames, uint lcid, int* rgdispid);
    HRESULT ADSIInvoke(int dispidMember, const(Guid)* riid, uint lcid, ushort wFlags, DISPPARAMS* pdispparams, VARIANT* pvarResult, EXCEPINFO* pexcepinfo, uint* puArgErr);
}

const GUID IID_IPrivateUnknown = {0x89126BAB, 0x6EAD, 0x11D1, [0x8C, 0x18, 0x00, 0xC0, 0x4F, 0xD8, 0xD5, 0x03]};
@GUID(0x89126BAB, 0x6EAD, 0x11D1, [0x8C, 0x18, 0x00, 0xC0, 0x4F, 0xD8, 0xD5, 0x03]);
interface IPrivateUnknown : IUnknown
{
    HRESULT ADSIInitializeObject(BSTR lpszUserName, BSTR lpszPassword, int lnReserved);
    HRESULT ADSIReleaseObject();
}

const GUID IID_IADsExtension = {0x3D35553C, 0xD2B0, 0x11D1, [0xB1, 0x7B, 0x00, 0x00, 0xF8, 0x75, 0x93, 0xA0]};
@GUID(0x3D35553C, 0xD2B0, 0x11D1, [0xB1, 0x7B, 0x00, 0x00, 0xF8, 0x75, 0x93, 0xA0]);
interface IADsExtension : IUnknown
{
    HRESULT Operate(uint dwCode, VARIANT varData1, VARIANT varData2, VARIANT varData3);
    HRESULT PrivateGetIDsOfNames(const(Guid)* riid, ushort** rgszNames, uint cNames, uint lcid, int* rgDispid);
    HRESULT PrivateInvoke(int dispidMember, const(Guid)* riid, uint lcid, ushort wFlags, DISPPARAMS* pdispparams, VARIANT* pvarResult, EXCEPINFO* pexcepinfo, uint* puArgErr);
}

const GUID IID_IADsDeleteOps = {0xB2BD0902, 0x8878, 0x11D1, [0x8C, 0x21, 0x00, 0xC0, 0x4F, 0xD8, 0xD5, 0x03]};
@GUID(0xB2BD0902, 0x8878, 0x11D1, [0x8C, 0x21, 0x00, 0xC0, 0x4F, 0xD8, 0xD5, 0x03]);
interface IADsDeleteOps : IDispatch
{
    HRESULT DeleteObject(int lnFlags);
}

const GUID IID_IADsNamespaces = {0x28B96BA0, 0xB330, 0x11CF, [0xA9, 0xAD, 0x00, 0xAA, 0x00, 0x6B, 0xC1, 0x49]};
@GUID(0x28B96BA0, 0xB330, 0x11CF, [0xA9, 0xAD, 0x00, 0xAA, 0x00, 0x6B, 0xC1, 0x49]);
interface IADsNamespaces : IADs
{
    HRESULT get_DefaultContainer(BSTR* retval);
    HRESULT put_DefaultContainer(BSTR bstrDefaultContainer);
}

const GUID IID_IADsClass = {0xC8F93DD0, 0x4AE0, 0x11CF, [0x9E, 0x73, 0x00, 0xAA, 0x00, 0x4A, 0x56, 0x91]};
@GUID(0xC8F93DD0, 0x4AE0, 0x11CF, [0x9E, 0x73, 0x00, 0xAA, 0x00, 0x4A, 0x56, 0x91]);
interface IADsClass : IADs
{
    HRESULT get_PrimaryInterface(BSTR* retval);
    HRESULT get_CLSID(BSTR* retval);
    HRESULT put_CLSID(BSTR bstrCLSID);
    HRESULT get_OID(BSTR* retval);
    HRESULT put_OID(BSTR bstrOID);
    HRESULT get_Abstract(short* retval);
    HRESULT put_Abstract(short fAbstract);
    HRESULT get_Auxiliary(short* retval);
    HRESULT put_Auxiliary(short fAuxiliary);
    HRESULT get_MandatoryProperties(VARIANT* retval);
    HRESULT put_MandatoryProperties(VARIANT vMandatoryProperties);
    HRESULT get_OptionalProperties(VARIANT* retval);
    HRESULT put_OptionalProperties(VARIANT vOptionalProperties);
    HRESULT get_NamingProperties(VARIANT* retval);
    HRESULT put_NamingProperties(VARIANT vNamingProperties);
    HRESULT get_DerivedFrom(VARIANT* retval);
    HRESULT put_DerivedFrom(VARIANT vDerivedFrom);
    HRESULT get_AuxDerivedFrom(VARIANT* retval);
    HRESULT put_AuxDerivedFrom(VARIANT vAuxDerivedFrom);
    HRESULT get_PossibleSuperiors(VARIANT* retval);
    HRESULT put_PossibleSuperiors(VARIANT vPossibleSuperiors);
    HRESULT get_Containment(VARIANT* retval);
    HRESULT put_Containment(VARIANT vContainment);
    HRESULT get_Container(short* retval);
    HRESULT put_Container(short fContainer);
    HRESULT get_HelpFileName(BSTR* retval);
    HRESULT put_HelpFileName(BSTR bstrHelpFileName);
    HRESULT get_HelpFileContext(int* retval);
    HRESULT put_HelpFileContext(int lnHelpFileContext);
    HRESULT Qualifiers(IADsCollection* ppQualifiers);
}

const GUID IID_IADsProperty = {0xC8F93DD3, 0x4AE0, 0x11CF, [0x9E, 0x73, 0x00, 0xAA, 0x00, 0x4A, 0x56, 0x91]};
@GUID(0xC8F93DD3, 0x4AE0, 0x11CF, [0x9E, 0x73, 0x00, 0xAA, 0x00, 0x4A, 0x56, 0x91]);
interface IADsProperty : IADs
{
    HRESULT get_OID(BSTR* retval);
    HRESULT put_OID(BSTR bstrOID);
    HRESULT get_Syntax(BSTR* retval);
    HRESULT put_Syntax(BSTR bstrSyntax);
    HRESULT get_MaxRange(int* retval);
    HRESULT put_MaxRange(int lnMaxRange);
    HRESULT get_MinRange(int* retval);
    HRESULT put_MinRange(int lnMinRange);
    HRESULT get_MultiValued(short* retval);
    HRESULT put_MultiValued(short fMultiValued);
    HRESULT Qualifiers(IADsCollection* ppQualifiers);
}

const GUID IID_IADsSyntax = {0xC8F93DD2, 0x4AE0, 0x11CF, [0x9E, 0x73, 0x00, 0xAA, 0x00, 0x4A, 0x56, 0x91]};
@GUID(0xC8F93DD2, 0x4AE0, 0x11CF, [0x9E, 0x73, 0x00, 0xAA, 0x00, 0x4A, 0x56, 0x91]);
interface IADsSyntax : IADs
{
    HRESULT get_OleAutoDataType(int* retval);
    HRESULT put_OleAutoDataType(int lnOleAutoDataType);
}

const GUID IID_IADsLocality = {0xA05E03A2, 0xEFFE, 0x11CF, [0x8A, 0xBC, 0x00, 0xC0, 0x4F, 0xD8, 0xD5, 0x03]};
@GUID(0xA05E03A2, 0xEFFE, 0x11CF, [0x8A, 0xBC, 0x00, 0xC0, 0x4F, 0xD8, 0xD5, 0x03]);
interface IADsLocality : IADs
{
    HRESULT get_Description(BSTR* retval);
    HRESULT put_Description(BSTR bstrDescription);
    HRESULT get_LocalityName(BSTR* retval);
    HRESULT put_LocalityName(BSTR bstrLocalityName);
    HRESULT get_PostalAddress(BSTR* retval);
    HRESULT put_PostalAddress(BSTR bstrPostalAddress);
    HRESULT get_SeeAlso(VARIANT* retval);
    HRESULT put_SeeAlso(VARIANT vSeeAlso);
}

const GUID IID_IADsO = {0xA1CD2DC6, 0xEFFE, 0x11CF, [0x8A, 0xBC, 0x00, 0xC0, 0x4F, 0xD8, 0xD5, 0x03]};
@GUID(0xA1CD2DC6, 0xEFFE, 0x11CF, [0x8A, 0xBC, 0x00, 0xC0, 0x4F, 0xD8, 0xD5, 0x03]);
interface IADsO : IADs
{
    HRESULT get_Description(BSTR* retval);
    HRESULT put_Description(BSTR bstrDescription);
    HRESULT get_LocalityName(BSTR* retval);
    HRESULT put_LocalityName(BSTR bstrLocalityName);
    HRESULT get_PostalAddress(BSTR* retval);
    HRESULT put_PostalAddress(BSTR bstrPostalAddress);
    HRESULT get_TelephoneNumber(BSTR* retval);
    HRESULT put_TelephoneNumber(BSTR bstrTelephoneNumber);
    HRESULT get_FaxNumber(BSTR* retval);
    HRESULT put_FaxNumber(BSTR bstrFaxNumber);
    HRESULT get_SeeAlso(VARIANT* retval);
    HRESULT put_SeeAlso(VARIANT vSeeAlso);
}

const GUID IID_IADsOU = {0xA2F733B8, 0xEFFE, 0x11CF, [0x8A, 0xBC, 0x00, 0xC0, 0x4F, 0xD8, 0xD5, 0x03]};
@GUID(0xA2F733B8, 0xEFFE, 0x11CF, [0x8A, 0xBC, 0x00, 0xC0, 0x4F, 0xD8, 0xD5, 0x03]);
interface IADsOU : IADs
{
    HRESULT get_Description(BSTR* retval);
    HRESULT put_Description(BSTR bstrDescription);
    HRESULT get_LocalityName(BSTR* retval);
    HRESULT put_LocalityName(BSTR bstrLocalityName);
    HRESULT get_PostalAddress(BSTR* retval);
    HRESULT put_PostalAddress(BSTR bstrPostalAddress);
    HRESULT get_TelephoneNumber(BSTR* retval);
    HRESULT put_TelephoneNumber(BSTR bstrTelephoneNumber);
    HRESULT get_FaxNumber(BSTR* retval);
    HRESULT put_FaxNumber(BSTR bstrFaxNumber);
    HRESULT get_SeeAlso(VARIANT* retval);
    HRESULT put_SeeAlso(VARIANT vSeeAlso);
    HRESULT get_BusinessCategory(BSTR* retval);
    HRESULT put_BusinessCategory(BSTR bstrBusinessCategory);
}

const GUID IID_IADsDomain = {0x00E4C220, 0xFD16, 0x11CE, [0xAB, 0xC4, 0x02, 0x60, 0x8C, 0x9E, 0x75, 0x53]};
@GUID(0x00E4C220, 0xFD16, 0x11CE, [0xAB, 0xC4, 0x02, 0x60, 0x8C, 0x9E, 0x75, 0x53]);
interface IADsDomain : IADs
{
    HRESULT get_IsWorkgroup(short* retval);
    HRESULT get_MinPasswordLength(int* retval);
    HRESULT put_MinPasswordLength(int lnMinPasswordLength);
    HRESULT get_MinPasswordAge(int* retval);
    HRESULT put_MinPasswordAge(int lnMinPasswordAge);
    HRESULT get_MaxPasswordAge(int* retval);
    HRESULT put_MaxPasswordAge(int lnMaxPasswordAge);
    HRESULT get_MaxBadPasswordsAllowed(int* retval);
    HRESULT put_MaxBadPasswordsAllowed(int lnMaxBadPasswordsAllowed);
    HRESULT get_PasswordHistoryLength(int* retval);
    HRESULT put_PasswordHistoryLength(int lnPasswordHistoryLength);
    HRESULT get_PasswordAttributes(int* retval);
    HRESULT put_PasswordAttributes(int lnPasswordAttributes);
    HRESULT get_AutoUnlockInterval(int* retval);
    HRESULT put_AutoUnlockInterval(int lnAutoUnlockInterval);
    HRESULT get_LockoutObservationInterval(int* retval);
    HRESULT put_LockoutObservationInterval(int lnLockoutObservationInterval);
}

const GUID IID_IADsComputer = {0xEFE3CC70, 0x1D9F, 0x11CF, [0xB1, 0xF3, 0x02, 0x60, 0x8C, 0x9E, 0x75, 0x53]};
@GUID(0xEFE3CC70, 0x1D9F, 0x11CF, [0xB1, 0xF3, 0x02, 0x60, 0x8C, 0x9E, 0x75, 0x53]);
interface IADsComputer : IADs
{
    HRESULT get_ComputerID(BSTR* retval);
    HRESULT get_Site(BSTR* retval);
    HRESULT get_Description(BSTR* retval);
    HRESULT put_Description(BSTR bstrDescription);
    HRESULT get_Location(BSTR* retval);
    HRESULT put_Location(BSTR bstrLocation);
    HRESULT get_PrimaryUser(BSTR* retval);
    HRESULT put_PrimaryUser(BSTR bstrPrimaryUser);
    HRESULT get_Owner(BSTR* retval);
    HRESULT put_Owner(BSTR bstrOwner);
    HRESULT get_Division(BSTR* retval);
    HRESULT put_Division(BSTR bstrDivision);
    HRESULT get_Department(BSTR* retval);
    HRESULT put_Department(BSTR bstrDepartment);
    HRESULT get_Role(BSTR* retval);
    HRESULT put_Role(BSTR bstrRole);
    HRESULT get_OperatingSystem(BSTR* retval);
    HRESULT put_OperatingSystem(BSTR bstrOperatingSystem);
    HRESULT get_OperatingSystemVersion(BSTR* retval);
    HRESULT put_OperatingSystemVersion(BSTR bstrOperatingSystemVersion);
    HRESULT get_Model(BSTR* retval);
    HRESULT put_Model(BSTR bstrModel);
    HRESULT get_Processor(BSTR* retval);
    HRESULT put_Processor(BSTR bstrProcessor);
    HRESULT get_ProcessorCount(BSTR* retval);
    HRESULT put_ProcessorCount(BSTR bstrProcessorCount);
    HRESULT get_MemorySize(BSTR* retval);
    HRESULT put_MemorySize(BSTR bstrMemorySize);
    HRESULT get_StorageCapacity(BSTR* retval);
    HRESULT put_StorageCapacity(BSTR bstrStorageCapacity);
    HRESULT get_NetAddresses(VARIANT* retval);
    HRESULT put_NetAddresses(VARIANT vNetAddresses);
}

const GUID IID_IADsComputerOperations = {0xEF497680, 0x1D9F, 0x11CF, [0xB1, 0xF3, 0x02, 0x60, 0x8C, 0x9E, 0x75, 0x53]};
@GUID(0xEF497680, 0x1D9F, 0x11CF, [0xB1, 0xF3, 0x02, 0x60, 0x8C, 0x9E, 0x75, 0x53]);
interface IADsComputerOperations : IADs
{
    HRESULT Status(IDispatch* ppObject);
    HRESULT Shutdown(short bReboot);
}

const GUID IID_IADsGroup = {0x27636B00, 0x410F, 0x11CF, [0xB1, 0xFF, 0x02, 0x60, 0x8C, 0x9E, 0x75, 0x53]};
@GUID(0x27636B00, 0x410F, 0x11CF, [0xB1, 0xFF, 0x02, 0x60, 0x8C, 0x9E, 0x75, 0x53]);
interface IADsGroup : IADs
{
    HRESULT get_Description(BSTR* retval);
    HRESULT put_Description(BSTR bstrDescription);
    HRESULT Members(IADsMembers* ppMembers);
    HRESULT IsMember(BSTR bstrMember, short* bMember);
    HRESULT Add(BSTR bstrNewItem);
    HRESULT Remove(BSTR bstrItemToBeRemoved);
}

const GUID IID_IADsUser = {0x3E37E320, 0x17E2, 0x11CF, [0xAB, 0xC4, 0x02, 0x60, 0x8C, 0x9E, 0x75, 0x53]};
@GUID(0x3E37E320, 0x17E2, 0x11CF, [0xAB, 0xC4, 0x02, 0x60, 0x8C, 0x9E, 0x75, 0x53]);
interface IADsUser : IADs
{
    HRESULT get_BadLoginAddress(BSTR* retval);
    HRESULT get_BadLoginCount(int* retval);
    HRESULT get_LastLogin(double* retval);
    HRESULT get_LastLogoff(double* retval);
    HRESULT get_LastFailedLogin(double* retval);
    HRESULT get_PasswordLastChanged(double* retval);
    HRESULT get_Description(BSTR* retval);
    HRESULT put_Description(BSTR bstrDescription);
    HRESULT get_Division(BSTR* retval);
    HRESULT put_Division(BSTR bstrDivision);
    HRESULT get_Department(BSTR* retval);
    HRESULT put_Department(BSTR bstrDepartment);
    HRESULT get_EmployeeID(BSTR* retval);
    HRESULT put_EmployeeID(BSTR bstrEmployeeID);
    HRESULT get_FullName(BSTR* retval);
    HRESULT put_FullName(BSTR bstrFullName);
    HRESULT get_FirstName(BSTR* retval);
    HRESULT put_FirstName(BSTR bstrFirstName);
    HRESULT get_LastName(BSTR* retval);
    HRESULT put_LastName(BSTR bstrLastName);
    HRESULT get_OtherName(BSTR* retval);
    HRESULT put_OtherName(BSTR bstrOtherName);
    HRESULT get_NamePrefix(BSTR* retval);
    HRESULT put_NamePrefix(BSTR bstrNamePrefix);
    HRESULT get_NameSuffix(BSTR* retval);
    HRESULT put_NameSuffix(BSTR bstrNameSuffix);
    HRESULT get_Title(BSTR* retval);
    HRESULT put_Title(BSTR bstrTitle);
    HRESULT get_Manager(BSTR* retval);
    HRESULT put_Manager(BSTR bstrManager);
    HRESULT get_TelephoneHome(VARIANT* retval);
    HRESULT put_TelephoneHome(VARIANT vTelephoneHome);
    HRESULT get_TelephoneMobile(VARIANT* retval);
    HRESULT put_TelephoneMobile(VARIANT vTelephoneMobile);
    HRESULT get_TelephoneNumber(VARIANT* retval);
    HRESULT put_TelephoneNumber(VARIANT vTelephoneNumber);
    HRESULT get_TelephonePager(VARIANT* retval);
    HRESULT put_TelephonePager(VARIANT vTelephonePager);
    HRESULT get_FaxNumber(VARIANT* retval);
    HRESULT put_FaxNumber(VARIANT vFaxNumber);
    HRESULT get_OfficeLocations(VARIANT* retval);
    HRESULT put_OfficeLocations(VARIANT vOfficeLocations);
    HRESULT get_PostalAddresses(VARIANT* retval);
    HRESULT put_PostalAddresses(VARIANT vPostalAddresses);
    HRESULT get_PostalCodes(VARIANT* retval);
    HRESULT put_PostalCodes(VARIANT vPostalCodes);
    HRESULT get_SeeAlso(VARIANT* retval);
    HRESULT put_SeeAlso(VARIANT vSeeAlso);
    HRESULT get_AccountDisabled(short* retval);
    HRESULT put_AccountDisabled(short fAccountDisabled);
    HRESULT get_AccountExpirationDate(double* retval);
    HRESULT put_AccountExpirationDate(double daAccountExpirationDate);
    HRESULT get_GraceLoginsAllowed(int* retval);
    HRESULT put_GraceLoginsAllowed(int lnGraceLoginsAllowed);
    HRESULT get_GraceLoginsRemaining(int* retval);
    HRESULT put_GraceLoginsRemaining(int lnGraceLoginsRemaining);
    HRESULT get_IsAccountLocked(short* retval);
    HRESULT put_IsAccountLocked(short fIsAccountLocked);
    HRESULT get_LoginHours(VARIANT* retval);
    HRESULT put_LoginHours(VARIANT vLoginHours);
    HRESULT get_LoginWorkstations(VARIANT* retval);
    HRESULT put_LoginWorkstations(VARIANT vLoginWorkstations);
    HRESULT get_MaxLogins(int* retval);
    HRESULT put_MaxLogins(int lnMaxLogins);
    HRESULT get_MaxStorage(int* retval);
    HRESULT put_MaxStorage(int lnMaxStorage);
    HRESULT get_PasswordExpirationDate(double* retval);
    HRESULT put_PasswordExpirationDate(double daPasswordExpirationDate);
    HRESULT get_PasswordMinimumLength(int* retval);
    HRESULT put_PasswordMinimumLength(int lnPasswordMinimumLength);
    HRESULT get_PasswordRequired(short* retval);
    HRESULT put_PasswordRequired(short fPasswordRequired);
    HRESULT get_RequireUniquePassword(short* retval);
    HRESULT put_RequireUniquePassword(short fRequireUniquePassword);
    HRESULT get_EmailAddress(BSTR* retval);
    HRESULT put_EmailAddress(BSTR bstrEmailAddress);
    HRESULT get_HomeDirectory(BSTR* retval);
    HRESULT put_HomeDirectory(BSTR bstrHomeDirectory);
    HRESULT get_Languages(VARIANT* retval);
    HRESULT put_Languages(VARIANT vLanguages);
    HRESULT get_Profile(BSTR* retval);
    HRESULT put_Profile(BSTR bstrProfile);
    HRESULT get_LoginScript(BSTR* retval);
    HRESULT put_LoginScript(BSTR bstrLoginScript);
    HRESULT get_Picture(VARIANT* retval);
    HRESULT put_Picture(VARIANT vPicture);
    HRESULT get_HomePage(BSTR* retval);
    HRESULT put_HomePage(BSTR bstrHomePage);
    HRESULT Groups(IADsMembers* ppGroups);
    HRESULT SetPassword(BSTR NewPassword);
    HRESULT ChangePassword(BSTR bstrOldPassword, BSTR bstrNewPassword);
}

const GUID IID_IADsPrintQueue = {0xB15160D0, 0x1226, 0x11CF, [0xA9, 0x85, 0x00, 0xAA, 0x00, 0x6B, 0xC1, 0x49]};
@GUID(0xB15160D0, 0x1226, 0x11CF, [0xA9, 0x85, 0x00, 0xAA, 0x00, 0x6B, 0xC1, 0x49]);
interface IADsPrintQueue : IADs
{
    HRESULT get_PrinterPath(BSTR* retval);
    HRESULT put_PrinterPath(BSTR bstrPrinterPath);
    HRESULT get_Model(BSTR* retval);
    HRESULT put_Model(BSTR bstrModel);
    HRESULT get_Datatype(BSTR* retval);
    HRESULT put_Datatype(BSTR bstrDatatype);
    HRESULT get_PrintProcessor(BSTR* retval);
    HRESULT put_PrintProcessor(BSTR bstrPrintProcessor);
    HRESULT get_Description(BSTR* retval);
    HRESULT put_Description(BSTR bstrDescription);
    HRESULT get_Location(BSTR* retval);
    HRESULT put_Location(BSTR bstrLocation);
    HRESULT get_StartTime(double* retval);
    HRESULT put_StartTime(double daStartTime);
    HRESULT get_UntilTime(double* retval);
    HRESULT put_UntilTime(double daUntilTime);
    HRESULT get_DefaultJobPriority(int* retval);
    HRESULT put_DefaultJobPriority(int lnDefaultJobPriority);
    HRESULT get_Priority(int* retval);
    HRESULT put_Priority(int lnPriority);
    HRESULT get_BannerPage(BSTR* retval);
    HRESULT put_BannerPage(BSTR bstrBannerPage);
    HRESULT get_PrintDevices(VARIANT* retval);
    HRESULT put_PrintDevices(VARIANT vPrintDevices);
    HRESULT get_NetAddresses(VARIANT* retval);
    HRESULT put_NetAddresses(VARIANT vNetAddresses);
}

const GUID IID_IADsPrintQueueOperations = {0x124BE5C0, 0x156E, 0x11CF, [0xA9, 0x86, 0x00, 0xAA, 0x00, 0x6B, 0xC1, 0x49]};
@GUID(0x124BE5C0, 0x156E, 0x11CF, [0xA9, 0x86, 0x00, 0xAA, 0x00, 0x6B, 0xC1, 0x49]);
interface IADsPrintQueueOperations : IADs
{
    HRESULT get_Status(int* retval);
    HRESULT PrintJobs(IADsCollection* pObject);
    HRESULT Pause();
    HRESULT Resume();
    HRESULT Purge();
}

const GUID IID_IADsPrintJob = {0x32FB6780, 0x1ED0, 0x11CF, [0xA9, 0x88, 0x00, 0xAA, 0x00, 0x6B, 0xC1, 0x49]};
@GUID(0x32FB6780, 0x1ED0, 0x11CF, [0xA9, 0x88, 0x00, 0xAA, 0x00, 0x6B, 0xC1, 0x49]);
interface IADsPrintJob : IADs
{
    HRESULT get_HostPrintQueue(BSTR* retval);
    HRESULT get_User(BSTR* retval);
    HRESULT get_UserPath(BSTR* retval);
    HRESULT get_TimeSubmitted(double* retval);
    HRESULT get_TotalPages(int* retval);
    HRESULT get_Size(int* retval);
    HRESULT get_Description(BSTR* retval);
    HRESULT put_Description(BSTR bstrDescription);
    HRESULT get_Priority(int* retval);
    HRESULT put_Priority(int lnPriority);
    HRESULT get_StartTime(double* retval);
    HRESULT put_StartTime(double daStartTime);
    HRESULT get_UntilTime(double* retval);
    HRESULT put_UntilTime(double daUntilTime);
    HRESULT get_Notify(BSTR* retval);
    HRESULT put_Notify(BSTR bstrNotify);
    HRESULT get_NotifyPath(BSTR* retval);
    HRESULT put_NotifyPath(BSTR bstrNotifyPath);
}

const GUID IID_IADsPrintJobOperations = {0x9A52DB30, 0x1ECF, 0x11CF, [0xA9, 0x88, 0x00, 0xAA, 0x00, 0x6B, 0xC1, 0x49]};
@GUID(0x9A52DB30, 0x1ECF, 0x11CF, [0xA9, 0x88, 0x00, 0xAA, 0x00, 0x6B, 0xC1, 0x49]);
interface IADsPrintJobOperations : IADs
{
    HRESULT get_Status(int* retval);
    HRESULT get_TimeElapsed(int* retval);
    HRESULT get_PagesPrinted(int* retval);
    HRESULT get_Position(int* retval);
    HRESULT put_Position(int lnPosition);
    HRESULT Pause();
    HRESULT Resume();
}

const GUID IID_IADsService = {0x68AF66E0, 0x31CA, 0x11CF, [0xA9, 0x8A, 0x00, 0xAA, 0x00, 0x6B, 0xC1, 0x49]};
@GUID(0x68AF66E0, 0x31CA, 0x11CF, [0xA9, 0x8A, 0x00, 0xAA, 0x00, 0x6B, 0xC1, 0x49]);
interface IADsService : IADs
{
    HRESULT get_HostComputer(BSTR* retval);
    HRESULT put_HostComputer(BSTR bstrHostComputer);
    HRESULT get_DisplayName(BSTR* retval);
    HRESULT put_DisplayName(BSTR bstrDisplayName);
    HRESULT get_Version(BSTR* retval);
    HRESULT put_Version(BSTR bstrVersion);
    HRESULT get_ServiceType(int* retval);
    HRESULT put_ServiceType(int lnServiceType);
    HRESULT get_StartType(int* retval);
    HRESULT put_StartType(int lnStartType);
    HRESULT get_Path(BSTR* retval);
    HRESULT put_Path(BSTR bstrPath);
    HRESULT get_StartupParameters(BSTR* retval);
    HRESULT put_StartupParameters(BSTR bstrStartupParameters);
    HRESULT get_ErrorControl(int* retval);
    HRESULT put_ErrorControl(int lnErrorControl);
    HRESULT get_LoadOrderGroup(BSTR* retval);
    HRESULT put_LoadOrderGroup(BSTR bstrLoadOrderGroup);
    HRESULT get_ServiceAccountName(BSTR* retval);
    HRESULT put_ServiceAccountName(BSTR bstrServiceAccountName);
    HRESULT get_ServiceAccountPath(BSTR* retval);
    HRESULT put_ServiceAccountPath(BSTR bstrServiceAccountPath);
    HRESULT get_Dependencies(VARIANT* retval);
    HRESULT put_Dependencies(VARIANT vDependencies);
}

const GUID IID_IADsServiceOperations = {0x5D7B33F0, 0x31CA, 0x11CF, [0xA9, 0x8A, 0x00, 0xAA, 0x00, 0x6B, 0xC1, 0x49]};
@GUID(0x5D7B33F0, 0x31CA, 0x11CF, [0xA9, 0x8A, 0x00, 0xAA, 0x00, 0x6B, 0xC1, 0x49]);
interface IADsServiceOperations : IADs
{
    HRESULT get_Status(int* retval);
    HRESULT Start();
    HRESULT Stop();
    HRESULT Pause();
    HRESULT Continue();
    HRESULT SetPassword(BSTR bstrNewPassword);
}

const GUID IID_IADsFileService = {0xA89D1900, 0x31CA, 0x11CF, [0xA9, 0x8A, 0x00, 0xAA, 0x00, 0x6B, 0xC1, 0x49]};
@GUID(0xA89D1900, 0x31CA, 0x11CF, [0xA9, 0x8A, 0x00, 0xAA, 0x00, 0x6B, 0xC1, 0x49]);
interface IADsFileService : IADsService
{
    HRESULT get_Description(BSTR* retval);
    HRESULT put_Description(BSTR bstrDescription);
    HRESULT get_MaxUserCount(int* retval);
    HRESULT put_MaxUserCount(int lnMaxUserCount);
}

const GUID IID_IADsFileServiceOperations = {0xA02DED10, 0x31CA, 0x11CF, [0xA9, 0x8A, 0x00, 0xAA, 0x00, 0x6B, 0xC1, 0x49]};
@GUID(0xA02DED10, 0x31CA, 0x11CF, [0xA9, 0x8A, 0x00, 0xAA, 0x00, 0x6B, 0xC1, 0x49]);
interface IADsFileServiceOperations : IADsServiceOperations
{
    HRESULT Sessions(IADsCollection* ppSessions);
    HRESULT Resources(IADsCollection* ppResources);
}

const GUID IID_IADsFileShare = {0xEB6DCAF0, 0x4B83, 0x11CF, [0xA9, 0x95, 0x00, 0xAA, 0x00, 0x6B, 0xC1, 0x49]};
@GUID(0xEB6DCAF0, 0x4B83, 0x11CF, [0xA9, 0x95, 0x00, 0xAA, 0x00, 0x6B, 0xC1, 0x49]);
interface IADsFileShare : IADs
{
    HRESULT get_CurrentUserCount(int* retval);
    HRESULT get_Description(BSTR* retval);
    HRESULT put_Description(BSTR bstrDescription);
    HRESULT get_HostComputer(BSTR* retval);
    HRESULT put_HostComputer(BSTR bstrHostComputer);
    HRESULT get_Path(BSTR* retval);
    HRESULT put_Path(BSTR bstrPath);
    HRESULT get_MaxUserCount(int* retval);
    HRESULT put_MaxUserCount(int lnMaxUserCount);
}

const GUID IID_IADsSession = {0x398B7DA0, 0x4AAB, 0x11CF, [0xAE, 0x2C, 0x00, 0xAA, 0x00, 0x6E, 0xBF, 0xB9]};
@GUID(0x398B7DA0, 0x4AAB, 0x11CF, [0xAE, 0x2C, 0x00, 0xAA, 0x00, 0x6E, 0xBF, 0xB9]);
interface IADsSession : IADs
{
    HRESULT get_User(BSTR* retval);
    HRESULT get_UserPath(BSTR* retval);
    HRESULT get_Computer(BSTR* retval);
    HRESULT get_ComputerPath(BSTR* retval);
    HRESULT get_ConnectTime(int* retval);
    HRESULT get_IdleTime(int* retval);
}

const GUID IID_IADsResource = {0x34A05B20, 0x4AAB, 0x11CF, [0xAE, 0x2C, 0x00, 0xAA, 0x00, 0x6E, 0xBF, 0xB9]};
@GUID(0x34A05B20, 0x4AAB, 0x11CF, [0xAE, 0x2C, 0x00, 0xAA, 0x00, 0x6E, 0xBF, 0xB9]);
interface IADsResource : IADs
{
    HRESULT get_User(BSTR* retval);
    HRESULT get_UserPath(BSTR* retval);
    HRESULT get_Path(BSTR* retval);
    HRESULT get_LockCount(int* retval);
}

const GUID IID_IADsOpenDSObject = {0xDDF2891E, 0x0F9C, 0x11D0, [0x8A, 0xD4, 0x00, 0xC0, 0x4F, 0xD8, 0xD5, 0x03]};
@GUID(0xDDF2891E, 0x0F9C, 0x11D0, [0x8A, 0xD4, 0x00, 0xC0, 0x4F, 0xD8, 0xD5, 0x03]);
interface IADsOpenDSObject : IDispatch
{
    HRESULT OpenDSObject(BSTR lpszDNName, BSTR lpszUserName, BSTR lpszPassword, int lnReserved, IDispatch* ppOleDsObj);
}

const GUID IID_IDirectoryObject = {0xE798DE2C, 0x22E4, 0x11D0, [0x84, 0xFE, 0x00, 0xC0, 0x4F, 0xD8, 0xD5, 0x03]};
@GUID(0xE798DE2C, 0x22E4, 0x11D0, [0x84, 0xFE, 0x00, 0xC0, 0x4F, 0xD8, 0xD5, 0x03]);
interface IDirectoryObject : IUnknown
{
    HRESULT GetObjectInformation(ADS_OBJECT_INFO** ppObjInfo);
    HRESULT GetObjectAttributes(ushort** pAttributeNames, uint dwNumberAttributes, ADS_ATTR_INFO** ppAttributeEntries, uint* pdwNumAttributesReturned);
    HRESULT SetObjectAttributes(ADS_ATTR_INFO* pAttributeEntries, uint dwNumAttributes, uint* pdwNumAttributesModified);
    HRESULT CreateDSObject(const(wchar)* pszRDNName, ADS_ATTR_INFO* pAttributeEntries, uint dwNumAttributes, IDispatch* ppObject);
    HRESULT DeleteDSObject(const(wchar)* pszRDNName);
}

const GUID IID_IDirectorySearch = {0x109BA8EC, 0x92F0, 0x11D0, [0xA7, 0x90, 0x00, 0xC0, 0x4F, 0xD8, 0xD5, 0xA8]};
@GUID(0x109BA8EC, 0x92F0, 0x11D0, [0xA7, 0x90, 0x00, 0xC0, 0x4F, 0xD8, 0xD5, 0xA8]);
interface IDirectorySearch : IUnknown
{
    HRESULT SetSearchPreference(ads_searchpref_info* pSearchPrefs, uint dwNumPrefs);
    HRESULT ExecuteSearch(const(wchar)* pszSearchFilter, ushort** pAttributeNames, uint dwNumberAttributes, int* phSearchResult);
    HRESULT AbandonSearch(int phSearchResult);
    HRESULT GetFirstRow(int hSearchResult);
    HRESULT GetNextRow(int hSearchResult);
    HRESULT GetPreviousRow(int hSearchResult);
    HRESULT GetNextColumnName(int hSearchHandle, ushort** ppszColumnName);
    HRESULT GetColumn(int hSearchResult, const(wchar)* szColumnName, ads_search_column* pSearchColumn);
    HRESULT FreeColumn(ads_search_column* pSearchColumn);
    HRESULT CloseSearchHandle(int hSearchResult);
}

const GUID IID_IDirectorySchemaMgmt = {0x75DB3B9C, 0xA4D8, 0x11D0, [0xA7, 0x9C, 0x00, 0xC0, 0x4F, 0xD8, 0xD5, 0xA8]};
@GUID(0x75DB3B9C, 0xA4D8, 0x11D0, [0xA7, 0x9C, 0x00, 0xC0, 0x4F, 0xD8, 0xD5, 0xA8]);
interface IDirectorySchemaMgmt : IUnknown
{
    HRESULT EnumAttributes(ushort** ppszAttrNames, uint dwNumAttributes, ADS_ATTR_DEF** ppAttrDefinition, uint* pdwNumAttributes);
    HRESULT CreateAttributeDefinition(const(wchar)* pszAttributeName, ADS_ATTR_DEF* pAttributeDefinition);
    HRESULT WriteAttributeDefinition(const(wchar)* pszAttributeName, ADS_ATTR_DEF* pAttributeDefinition);
    HRESULT DeleteAttributeDefinition(const(wchar)* pszAttributeName);
    HRESULT EnumClasses(ushort** ppszClassNames, uint dwNumClasses, ADS_CLASS_DEF** ppClassDefinition, uint* pdwNumClasses);
    HRESULT WriteClassDefinition(const(wchar)* pszClassName, ADS_CLASS_DEF* pClassDefinition);
    HRESULT CreateClassDefinition(const(wchar)* pszClassName, ADS_CLASS_DEF* pClassDefinition);
    HRESULT DeleteClassDefinition(const(wchar)* pszClassName);
}

const GUID IID_IADsAggregatee = {0x1346CE8C, 0x9039, 0x11D0, [0x85, 0x28, 0x00, 0xC0, 0x4F, 0xD8, 0xD5, 0x03]};
@GUID(0x1346CE8C, 0x9039, 0x11D0, [0x85, 0x28, 0x00, 0xC0, 0x4F, 0xD8, 0xD5, 0x03]);
interface IADsAggregatee : IUnknown
{
    HRESULT ConnectAsAggregatee(IUnknown pOuterUnknown);
    HRESULT DisconnectAsAggregatee();
    HRESULT RelinquishInterface(const(Guid)* riid);
    HRESULT RestoreInterface(const(Guid)* riid);
}

const GUID IID_IADsAggregator = {0x52DB5FB0, 0x941F, 0x11D0, [0x85, 0x29, 0x00, 0xC0, 0x4F, 0xD8, 0xD5, 0x03]};
@GUID(0x52DB5FB0, 0x941F, 0x11D0, [0x85, 0x29, 0x00, 0xC0, 0x4F, 0xD8, 0xD5, 0x03]);
interface IADsAggregator : IUnknown
{
    HRESULT ConnectAsAggregator(IUnknown pAggregatee);
    HRESULT DisconnectAsAggregator();
}

const GUID IID_IADsAccessControlEntry = {0xB4F3A14C, 0x9BDD, 0x11D0, [0x85, 0x2C, 0x00, 0xC0, 0x4F, 0xD8, 0xD5, 0x03]};
@GUID(0xB4F3A14C, 0x9BDD, 0x11D0, [0x85, 0x2C, 0x00, 0xC0, 0x4F, 0xD8, 0xD5, 0x03]);
interface IADsAccessControlEntry : IDispatch
{
    HRESULT get_AccessMask(int* retval);
    HRESULT put_AccessMask(int lnAccessMask);
    HRESULT get_AceType(int* retval);
    HRESULT put_AceType(int lnAceType);
    HRESULT get_AceFlags(int* retval);
    HRESULT put_AceFlags(int lnAceFlags);
    HRESULT get_Flags(int* retval);
    HRESULT put_Flags(int lnFlags);
    HRESULT get_ObjectType(BSTR* retval);
    HRESULT put_ObjectType(BSTR bstrObjectType);
    HRESULT get_InheritedObjectType(BSTR* retval);
    HRESULT put_InheritedObjectType(BSTR bstrInheritedObjectType);
    HRESULT get_Trustee(BSTR* retval);
    HRESULT put_Trustee(BSTR bstrTrustee);
}

const GUID IID_IADsAccessControlList = {0xB7EE91CC, 0x9BDD, 0x11D0, [0x85, 0x2C, 0x00, 0xC0, 0x4F, 0xD8, 0xD5, 0x03]};
@GUID(0xB7EE91CC, 0x9BDD, 0x11D0, [0x85, 0x2C, 0x00, 0xC0, 0x4F, 0xD8, 0xD5, 0x03]);
interface IADsAccessControlList : IDispatch
{
    HRESULT get_AclRevision(int* retval);
    HRESULT put_AclRevision(int lnAclRevision);
    HRESULT get_AceCount(int* retval);
    HRESULT put_AceCount(int lnAceCount);
    HRESULT AddAce(IDispatch pAccessControlEntry);
    HRESULT RemoveAce(IDispatch pAccessControlEntry);
    HRESULT CopyAccessList(IDispatch* ppAccessControlList);
    HRESULT get__NewEnum(IUnknown* retval);
}

const GUID IID_IADsSecurityDescriptor = {0xB8C787CA, 0x9BDD, 0x11D0, [0x85, 0x2C, 0x00, 0xC0, 0x4F, 0xD8, 0xD5, 0x03]};
@GUID(0xB8C787CA, 0x9BDD, 0x11D0, [0x85, 0x2C, 0x00, 0xC0, 0x4F, 0xD8, 0xD5, 0x03]);
interface IADsSecurityDescriptor : IDispatch
{
    HRESULT get_Revision(int* retval);
    HRESULT put_Revision(int lnRevision);
    HRESULT get_Control(int* retval);
    HRESULT put_Control(int lnControl);
    HRESULT get_Owner(BSTR* retval);
    HRESULT put_Owner(BSTR bstrOwner);
    HRESULT get_OwnerDefaulted(short* retval);
    HRESULT put_OwnerDefaulted(short fOwnerDefaulted);
    HRESULT get_Group(BSTR* retval);
    HRESULT put_Group(BSTR bstrGroup);
    HRESULT get_GroupDefaulted(short* retval);
    HRESULT put_GroupDefaulted(short fGroupDefaulted);
    HRESULT get_DiscretionaryAcl(IDispatch* retval);
    HRESULT put_DiscretionaryAcl(IDispatch pDiscretionaryAcl);
    HRESULT get_DaclDefaulted(short* retval);
    HRESULT put_DaclDefaulted(short fDaclDefaulted);
    HRESULT get_SystemAcl(IDispatch* retval);
    HRESULT put_SystemAcl(IDispatch pSystemAcl);
    HRESULT get_SaclDefaulted(short* retval);
    HRESULT put_SaclDefaulted(short fSaclDefaulted);
    HRESULT CopySecurityDescriptor(IDispatch* ppSecurityDescriptor);
}

const GUID IID_IADsLargeInteger = {0x9068270B, 0x0939, 0x11D1, [0x8B, 0xE1, 0x00, 0xC0, 0x4F, 0xD8, 0xD5, 0x03]};
@GUID(0x9068270B, 0x0939, 0x11D1, [0x8B, 0xE1, 0x00, 0xC0, 0x4F, 0xD8, 0xD5, 0x03]);
interface IADsLargeInteger : IDispatch
{
    HRESULT get_HighPart(int* retval);
    HRESULT put_HighPart(int lnHighPart);
    HRESULT get_LowPart(int* retval);
    HRESULT put_LowPart(int lnLowPart);
}

const GUID IID_IADsNameTranslate = {0xB1B272A3, 0x3625, 0x11D1, [0xA3, 0xA4, 0x00, 0xC0, 0x4F, 0xB9, 0x50, 0xDC]};
@GUID(0xB1B272A3, 0x3625, 0x11D1, [0xA3, 0xA4, 0x00, 0xC0, 0x4F, 0xB9, 0x50, 0xDC]);
interface IADsNameTranslate : IDispatch
{
    HRESULT put_ChaseReferral(int lnChaseReferral);
    HRESULT Init(int lnSetType, BSTR bstrADsPath);
    HRESULT InitEx(int lnSetType, BSTR bstrADsPath, BSTR bstrUserID, BSTR bstrDomain, BSTR bstrPassword);
    HRESULT Set(int lnSetType, BSTR bstrADsPath);
    HRESULT Get(int lnFormatType, BSTR* pbstrADsPath);
    HRESULT SetEx(int lnFormatType, VARIANT pvar);
    HRESULT GetEx(int lnFormatType, VARIANT* pvar);
}

const GUID IID_IADsCaseIgnoreList = {0x7B66B533, 0x4680, 0x11D1, [0xA3, 0xB4, 0x00, 0xC0, 0x4F, 0xB9, 0x50, 0xDC]};
@GUID(0x7B66B533, 0x4680, 0x11D1, [0xA3, 0xB4, 0x00, 0xC0, 0x4F, 0xB9, 0x50, 0xDC]);
interface IADsCaseIgnoreList : IDispatch
{
    HRESULT get_CaseIgnoreList(VARIANT* retval);
    HRESULT put_CaseIgnoreList(VARIANT vCaseIgnoreList);
}

const GUID IID_IADsFaxNumber = {0xA910DEA9, 0x4680, 0x11D1, [0xA3, 0xB4, 0x00, 0xC0, 0x4F, 0xB9, 0x50, 0xDC]};
@GUID(0xA910DEA9, 0x4680, 0x11D1, [0xA3, 0xB4, 0x00, 0xC0, 0x4F, 0xB9, 0x50, 0xDC]);
interface IADsFaxNumber : IDispatch
{
    HRESULT get_TelephoneNumber(BSTR* retval);
    HRESULT put_TelephoneNumber(BSTR bstrTelephoneNumber);
    HRESULT get_Parameters(VARIANT* retval);
    HRESULT put_Parameters(VARIANT vParameters);
}

const GUID IID_IADsNetAddress = {0xB21A50A9, 0x4080, 0x11D1, [0xA3, 0xAC, 0x00, 0xC0, 0x4F, 0xB9, 0x50, 0xDC]};
@GUID(0xB21A50A9, 0x4080, 0x11D1, [0xA3, 0xAC, 0x00, 0xC0, 0x4F, 0xB9, 0x50, 0xDC]);
interface IADsNetAddress : IDispatch
{
    HRESULT get_AddressType(int* retval);
    HRESULT put_AddressType(int lnAddressType);
    HRESULT get_Address(VARIANT* retval);
    HRESULT put_Address(VARIANT vAddress);
}

const GUID IID_IADsOctetList = {0x7B28B80F, 0x4680, 0x11D1, [0xA3, 0xB4, 0x00, 0xC0, 0x4F, 0xB9, 0x50, 0xDC]};
@GUID(0x7B28B80F, 0x4680, 0x11D1, [0xA3, 0xB4, 0x00, 0xC0, 0x4F, 0xB9, 0x50, 0xDC]);
interface IADsOctetList : IDispatch
{
    HRESULT get_OctetList(VARIANT* retval);
    HRESULT put_OctetList(VARIANT vOctetList);
}

const GUID IID_IADsEmail = {0x97AF011A, 0x478E, 0x11D1, [0xA3, 0xB4, 0x00, 0xC0, 0x4F, 0xB9, 0x50, 0xDC]};
@GUID(0x97AF011A, 0x478E, 0x11D1, [0xA3, 0xB4, 0x00, 0xC0, 0x4F, 0xB9, 0x50, 0xDC]);
interface IADsEmail : IDispatch
{
    HRESULT get_Type(int* retval);
    HRESULT put_Type(int lnType);
    HRESULT get_Address(BSTR* retval);
    HRESULT put_Address(BSTR bstrAddress);
}

const GUID IID_IADsPath = {0xB287FCD5, 0x4080, 0x11D1, [0xA3, 0xAC, 0x00, 0xC0, 0x4F, 0xB9, 0x50, 0xDC]};
@GUID(0xB287FCD5, 0x4080, 0x11D1, [0xA3, 0xAC, 0x00, 0xC0, 0x4F, 0xB9, 0x50, 0xDC]);
interface IADsPath : IDispatch
{
    HRESULT get_Type(int* retval);
    HRESULT put_Type(int lnType);
    HRESULT get_VolumeName(BSTR* retval);
    HRESULT put_VolumeName(BSTR bstrVolumeName);
    HRESULT get_Path(BSTR* retval);
    HRESULT put_Path(BSTR bstrPath);
}

const GUID IID_IADsReplicaPointer = {0xF60FB803, 0x4080, 0x11D1, [0xA3, 0xAC, 0x00, 0xC0, 0x4F, 0xB9, 0x50, 0xDC]};
@GUID(0xF60FB803, 0x4080, 0x11D1, [0xA3, 0xAC, 0x00, 0xC0, 0x4F, 0xB9, 0x50, 0xDC]);
interface IADsReplicaPointer : IDispatch
{
    HRESULT get_ServerName(BSTR* retval);
    HRESULT put_ServerName(BSTR bstrServerName);
    HRESULT get_ReplicaType(int* retval);
    HRESULT put_ReplicaType(int lnReplicaType);
    HRESULT get_ReplicaNumber(int* retval);
    HRESULT put_ReplicaNumber(int lnReplicaNumber);
    HRESULT get_Count(int* retval);
    HRESULT put_Count(int lnCount);
    HRESULT get_ReplicaAddressHints(VARIANT* retval);
    HRESULT put_ReplicaAddressHints(VARIANT vReplicaAddressHints);
}

const GUID IID_IADsAcl = {0x8452D3AB, 0x0869, 0x11D1, [0xA3, 0x77, 0x00, 0xC0, 0x4F, 0xB9, 0x50, 0xDC]};
@GUID(0x8452D3AB, 0x0869, 0x11D1, [0xA3, 0x77, 0x00, 0xC0, 0x4F, 0xB9, 0x50, 0xDC]);
interface IADsAcl : IDispatch
{
    HRESULT get_ProtectedAttrName(BSTR* retval);
    HRESULT put_ProtectedAttrName(BSTR bstrProtectedAttrName);
    HRESULT get_SubjectName(BSTR* retval);
    HRESULT put_SubjectName(BSTR bstrSubjectName);
    HRESULT get_Privileges(int* retval);
    HRESULT put_Privileges(int lnPrivileges);
    HRESULT CopyAcl(IDispatch* ppAcl);
}

const GUID IID_IADsTimestamp = {0xB2F5A901, 0x4080, 0x11D1, [0xA3, 0xAC, 0x00, 0xC0, 0x4F, 0xB9, 0x50, 0xDC]};
@GUID(0xB2F5A901, 0x4080, 0x11D1, [0xA3, 0xAC, 0x00, 0xC0, 0x4F, 0xB9, 0x50, 0xDC]);
interface IADsTimestamp : IDispatch
{
    HRESULT get_WholeSeconds(int* retval);
    HRESULT put_WholeSeconds(int lnWholeSeconds);
    HRESULT get_EventID(int* retval);
    HRESULT put_EventID(int lnEventID);
}

const GUID IID_IADsPostalAddress = {0x7ADECF29, 0x4680, 0x11D1, [0xA3, 0xB4, 0x00, 0xC0, 0x4F, 0xB9, 0x50, 0xDC]};
@GUID(0x7ADECF29, 0x4680, 0x11D1, [0xA3, 0xB4, 0x00, 0xC0, 0x4F, 0xB9, 0x50, 0xDC]);
interface IADsPostalAddress : IDispatch
{
    HRESULT get_PostalAddress(VARIANT* retval);
    HRESULT put_PostalAddress(VARIANT vPostalAddress);
}

const GUID IID_IADsBackLink = {0xFD1302BD, 0x4080, 0x11D1, [0xA3, 0xAC, 0x00, 0xC0, 0x4F, 0xB9, 0x50, 0xDC]};
@GUID(0xFD1302BD, 0x4080, 0x11D1, [0xA3, 0xAC, 0x00, 0xC0, 0x4F, 0xB9, 0x50, 0xDC]);
interface IADsBackLink : IDispatch
{
    HRESULT get_RemoteID(int* retval);
    HRESULT put_RemoteID(int lnRemoteID);
    HRESULT get_ObjectName(BSTR* retval);
    HRESULT put_ObjectName(BSTR bstrObjectName);
}

const GUID IID_IADsTypedName = {0xB371A349, 0x4080, 0x11D1, [0xA3, 0xAC, 0x00, 0xC0, 0x4F, 0xB9, 0x50, 0xDC]};
@GUID(0xB371A349, 0x4080, 0x11D1, [0xA3, 0xAC, 0x00, 0xC0, 0x4F, 0xB9, 0x50, 0xDC]);
interface IADsTypedName : IDispatch
{
    HRESULT get_ObjectName(BSTR* retval);
    HRESULT put_ObjectName(BSTR bstrObjectName);
    HRESULT get_Level(int* retval);
    HRESULT put_Level(int lnLevel);
    HRESULT get_Interval(int* retval);
    HRESULT put_Interval(int lnInterval);
}

const GUID IID_IADsHold = {0xB3EB3B37, 0x4080, 0x11D1, [0xA3, 0xAC, 0x00, 0xC0, 0x4F, 0xB9, 0x50, 0xDC]};
@GUID(0xB3EB3B37, 0x4080, 0x11D1, [0xA3, 0xAC, 0x00, 0xC0, 0x4F, 0xB9, 0x50, 0xDC]);
interface IADsHold : IDispatch
{
    HRESULT get_ObjectName(BSTR* retval);
    HRESULT put_ObjectName(BSTR bstrObjectName);
    HRESULT get_Amount(int* retval);
    HRESULT put_Amount(int lnAmount);
}

const GUID IID_IADsObjectOptions = {0x46F14FDA, 0x232B, 0x11D1, [0xA8, 0x08, 0x00, 0xC0, 0x4F, 0xD8, 0xD5, 0xA8]};
@GUID(0x46F14FDA, 0x232B, 0x11D1, [0xA8, 0x08, 0x00, 0xC0, 0x4F, 0xD8, 0xD5, 0xA8]);
interface IADsObjectOptions : IDispatch
{
    HRESULT GetOption(int lnOption, VARIANT* pvValue);
    HRESULT SetOption(int lnOption, VARIANT vValue);
}

const GUID IID_IADsPathname = {0xD592AED4, 0xF420, 0x11D0, [0xA3, 0x6E, 0x00, 0xC0, 0x4F, 0xB9, 0x50, 0xDC]};
@GUID(0xD592AED4, 0xF420, 0x11D0, [0xA3, 0x6E, 0x00, 0xC0, 0x4F, 0xB9, 0x50, 0xDC]);
interface IADsPathname : IDispatch
{
    HRESULT Set(BSTR bstrADsPath, int lnSetType);
    HRESULT SetDisplayType(int lnDisplayType);
    HRESULT Retrieve(int lnFormatType, BSTR* pbstrADsPath);
    HRESULT GetNumElements(int* plnNumPathElements);
    HRESULT GetElement(int lnElementIndex, BSTR* pbstrElement);
    HRESULT AddLeafElement(BSTR bstrLeafElement);
    HRESULT RemoveLeafElement();
    HRESULT CopyPath(IDispatch* ppAdsPath);
    HRESULT GetEscapedElement(int lnReserved, BSTR bstrInStr, BSTR* pbstrOutStr);
    HRESULT get_EscapedMode(int* retval);
    HRESULT put_EscapedMode(int lnEscapedMode);
}

const GUID IID_IADsADSystemInfo = {0x5BB11929, 0xAFD1, 0x11D2, [0x9C, 0xB9, 0x00, 0x00, 0xF8, 0x7A, 0x36, 0x9E]};
@GUID(0x5BB11929, 0xAFD1, 0x11D2, [0x9C, 0xB9, 0x00, 0x00, 0xF8, 0x7A, 0x36, 0x9E]);
interface IADsADSystemInfo : IDispatch
{
    HRESULT get_UserName(BSTR* retval);
    HRESULT get_ComputerName(BSTR* retval);
    HRESULT get_SiteName(BSTR* retval);
    HRESULT get_DomainShortName(BSTR* retval);
    HRESULT get_DomainDNSName(BSTR* retval);
    HRESULT get_ForestDNSName(BSTR* retval);
    HRESULT get_PDCRoleOwner(BSTR* retval);
    HRESULT get_SchemaRoleOwner(BSTR* retval);
    HRESULT get_IsNativeMode(short* retval);
    HRESULT GetAnyDCName(BSTR* pszDCName);
    HRESULT GetDCSiteName(BSTR szServer, BSTR* pszSiteName);
    HRESULT RefreshSchemaCache();
    HRESULT GetTrees(VARIANT* pvTrees);
}

const GUID IID_IADsWinNTSystemInfo = {0x6C6D65DC, 0xAFD1, 0x11D2, [0x9C, 0xB9, 0x00, 0x00, 0xF8, 0x7A, 0x36, 0x9E]};
@GUID(0x6C6D65DC, 0xAFD1, 0x11D2, [0x9C, 0xB9, 0x00, 0x00, 0xF8, 0x7A, 0x36, 0x9E]);
interface IADsWinNTSystemInfo : IDispatch
{
    HRESULT get_UserName(BSTR* retval);
    HRESULT get_ComputerName(BSTR* retval);
    HRESULT get_DomainName(BSTR* retval);
    HRESULT get_PDC(BSTR* retval);
}

const GUID IID_IADsDNWithBinary = {0x7E99C0A2, 0xF935, 0x11D2, [0xBA, 0x96, 0x00, 0xC0, 0x4F, 0xB6, 0xD0, 0xD1]};
@GUID(0x7E99C0A2, 0xF935, 0x11D2, [0xBA, 0x96, 0x00, 0xC0, 0x4F, 0xB6, 0xD0, 0xD1]);
interface IADsDNWithBinary : IDispatch
{
    HRESULT get_BinaryValue(VARIANT* retval);
    HRESULT put_BinaryValue(VARIANT vBinaryValue);
    HRESULT get_DNString(BSTR* retval);
    HRESULT put_DNString(BSTR bstrDNString);
}

const GUID IID_IADsDNWithString = {0x370DF02E, 0xF934, 0x11D2, [0xBA, 0x96, 0x00, 0xC0, 0x4F, 0xB6, 0xD0, 0xD1]};
@GUID(0x370DF02E, 0xF934, 0x11D2, [0xBA, 0x96, 0x00, 0xC0, 0x4F, 0xB6, 0xD0, 0xD1]);
interface IADsDNWithString : IDispatch
{
    HRESULT get_StringValue(BSTR* retval);
    HRESULT put_StringValue(BSTR bstrStringValue);
    HRESULT get_DNString(BSTR* retval);
    HRESULT put_DNString(BSTR bstrDNString);
}

const GUID IID_IADsSecurityUtility = {0xA63251B2, 0x5F21, 0x474B, [0xAB, 0x52, 0x4A, 0x8E, 0xFA, 0xD1, 0x08, 0x95]};
@GUID(0xA63251B2, 0x5F21, 0x474B, [0xAB, 0x52, 0x4A, 0x8E, 0xFA, 0xD1, 0x08, 0x95]);
interface IADsSecurityUtility : IDispatch
{
    HRESULT GetSecurityDescriptor(VARIANT varPath, int lPathFormat, int lFormat, VARIANT* pVariant);
    HRESULT SetSecurityDescriptor(VARIANT varPath, int lPathFormat, VARIANT varData, int lDataFormat);
    HRESULT ConvertSecurityDescriptor(VARIANT varSD, int lDataFormat, int lOutFormat, VARIANT* pResult);
    HRESULT get_SecurityMask(int* retval);
    HRESULT put_SecurityMask(int lnSecurityMask);
}

struct DSOBJECT
{
    uint dwFlags;
    uint dwProviderFlags;
    uint offsetName;
    uint offsetClass;
}

struct DSOBJECTNAMES
{
    Guid clsidNamespace;
    uint cItems;
    DSOBJECT aObjects;
}

struct DSDISPLAYSPECOPTIONS
{
    uint dwSize;
    uint dwFlags;
    uint offsetAttribPrefix;
    uint offsetUserName;
    uint offsetPassword;
    uint offsetServer;
    uint offsetServerConfigPath;
}

struct DSPROPERTYPAGEINFO
{
    uint offsetString;
}

struct DOMAINDESC
{
    const(wchar)* pszName;
    const(wchar)* pszPath;
    const(wchar)* pszNCName;
    const(wchar)* pszTrustParent;
    const(wchar)* pszObjectClass;
    uint ulFlags;
    BOOL fDownLevel;
    DOMAINDESC* pdChildList;
    DOMAINDESC* pdNextSibling;
}

struct DOMAIN_TREE
{
    uint dsSize;
    uint dwCount;
    DOMAINDESC aDomains;
}

const GUID IID_IDsBrowseDomainTree = {0x7CABCF1E, 0x78F5, 0x11D2, [0x96, 0x0C, 0x00, 0xC0, 0x4F, 0xA3, 0x1A, 0x86]};
@GUID(0x7CABCF1E, 0x78F5, 0x11D2, [0x96, 0x0C, 0x00, 0xC0, 0x4F, 0xA3, 0x1A, 0x86]);
interface IDsBrowseDomainTree : IUnknown
{
    HRESULT BrowseTo(HWND hwndParent, ushort** ppszTargetPath, uint dwFlags);
    HRESULT GetDomains(DOMAIN_TREE** ppDomainTree, uint dwFlags);
    HRESULT FreeDomains(DOMAIN_TREE** ppDomainTree);
    HRESULT FlushCachedDomains();
    HRESULT SetComputer(const(wchar)* pszComputerName, const(wchar)* pszUserName, const(wchar)* pszPassword);
}

alias LPDSENUMATTRIBUTES = extern(Windows) HRESULT function(LPARAM lParam, const(wchar)* pszAttributeName, const(wchar)* pszDisplayName, uint dwFlags);
struct DSCLASSCREATIONINFO
{
    uint dwFlags;
    Guid clsidWizardDialog;
    Guid clsidWizardPrimaryPage;
    uint cWizardExtensions;
    Guid aWizardExtensions;
}

const GUID IID_IDsDisplaySpecifier = {0x1AB4A8C0, 0x6A0B, 0x11D2, [0xAD, 0x49, 0x00, 0xC0, 0x4F, 0xA3, 0x1A, 0x86]};
@GUID(0x1AB4A8C0, 0x6A0B, 0x11D2, [0xAD, 0x49, 0x00, 0xC0, 0x4F, 0xA3, 0x1A, 0x86]);
interface IDsDisplaySpecifier : IUnknown
{
    HRESULT SetServer(const(wchar)* pszServer, const(wchar)* pszUserName, const(wchar)* pszPassword, uint dwFlags);
    HRESULT SetLanguageID(ushort langid);
    HRESULT GetDisplaySpecifier(const(wchar)* pszObjectClass, const(Guid)* riid, void** ppv);
    HRESULT GetIconLocation(const(wchar)* pszObjectClass, uint dwFlags, const(wchar)* pszBuffer, int cchBuffer, int* presid);
    HICON GetIcon(const(wchar)* pszObjectClass, uint dwFlags, int cxIcon, int cyIcon);
    HRESULT GetFriendlyClassName(const(wchar)* pszObjectClass, const(wchar)* pszBuffer, int cchBuffer);
    HRESULT GetFriendlyAttributeName(const(wchar)* pszObjectClass, const(wchar)* pszAttributeName, const(wchar)* pszBuffer, uint cchBuffer);
    BOOL IsClassContainer(const(wchar)* pszObjectClass, const(wchar)* pszADsPath, uint dwFlags);
    HRESULT GetClassCreationInfo(const(wchar)* pszObjectClass, DSCLASSCREATIONINFO** ppdscci);
    HRESULT EnumClassAttributes(const(wchar)* pszObjectClass, LPDSENUMATTRIBUTES pcbEnum, LPARAM lParam);
    ADSTYPEENUM GetAttributeADsType(const(wchar)* pszAttributeName);
}

struct DSBROWSEINFOW
{
    uint cbStruct;
    HWND hwndOwner;
    const(wchar)* pszCaption;
    const(wchar)* pszTitle;
    const(wchar)* pszRoot;
    const(wchar)* pszPath;
    uint cchPath;
    uint dwFlags;
    BFFCALLBACK pfnCallback;
    LPARAM lParam;
    uint dwReturnFormat;
    const(wchar)* pUserName;
    const(wchar)* pPassword;
    const(wchar)* pszObjectClass;
    uint cchObjectClass;
}

struct DSBROWSEINFOA
{
    uint cbStruct;
    HWND hwndOwner;
    const(char)* pszCaption;
    const(char)* pszTitle;
    const(wchar)* pszRoot;
    const(wchar)* pszPath;
    uint cchPath;
    uint dwFlags;
    BFFCALLBACK pfnCallback;
    LPARAM lParam;
    uint dwReturnFormat;
    const(wchar)* pUserName;
    const(wchar)* pPassword;
    const(wchar)* pszObjectClass;
    uint cchObjectClass;
}

struct DSBITEMW
{
    uint cbStruct;
    const(wchar)* pszADsPath;
    const(wchar)* pszClass;
    uint dwMask;
    uint dwState;
    uint dwStateMask;
    ushort szDisplayName;
    ushort szIconLocation;
    int iIconResID;
}

struct DSBITEMA
{
    uint cbStruct;
    const(wchar)* pszADsPath;
    const(wchar)* pszClass;
    uint dwMask;
    uint dwState;
    uint dwStateMask;
    byte szDisplayName;
    byte szIconLocation;
    int iIconResID;
}

struct DSOP_UPLEVEL_FILTER_FLAGS
{
    uint flBothModes;
    uint flMixedModeOnly;
    uint flNativeModeOnly;
}

struct DSOP_FILTER_FLAGS
{
    DSOP_UPLEVEL_FILTER_FLAGS Uplevel;
    uint flDownlevel;
}

struct DSOP_SCOPE_INIT_INFO
{
    uint cbSize;
    uint flType;
    uint flScope;
    DSOP_FILTER_FLAGS FilterFlags;
    const(wchar)* pwzDcName;
    const(wchar)* pwzADsPath;
    HRESULT hr;
}

struct DSOP_INIT_INFO
{
    uint cbSize;
    const(wchar)* pwzTargetComputer;
    uint cDsScopeInfos;
    DSOP_SCOPE_INIT_INFO* aDsScopeInfos;
    uint flOptions;
    uint cAttributesToFetch;
    ushort** apwzAttributeNames;
}

struct DS_SELECTION
{
    const(wchar)* pwzName;
    const(wchar)* pwzADsPath;
    const(wchar)* pwzClass;
    const(wchar)* pwzUPN;
    VARIANT* pvarFetchedAttributes;
    uint flScopeType;
}

struct DS_SELECTION_LIST
{
    uint cItems;
    uint cFetchedAttributes;
    DS_SELECTION aDsSelection;
}

interface IDsObjectPicker : IUnknown
{
    HRESULT Initialize(DSOP_INIT_INFO* pInitInfo);
    HRESULT InvokeDialog(HWND hwndParent, IDataObject* ppdoSelections);
}

interface IDsObjectPickerCredentials : IDsObjectPicker
{
    HRESULT SetCredentials(const(wchar)* szUserName, const(wchar)* szPassword);
}

struct DSQUERYINITPARAMS
{
    uint cbStruct;
    uint dwFlags;
    const(wchar)* pDefaultScope;
    const(wchar)* pDefaultSaveLocation;
    const(wchar)* pUserName;
    const(wchar)* pPassword;
    const(wchar)* pServer;
}

struct DSCOLUMN
{
    uint dwFlags;
    int fmt;
    int cx;
    int idsName;
    int offsetProperty;
    uint dwReserved;
}

struct DSQUERYPARAMS
{
    uint cbStruct;
    uint dwFlags;
    HINSTANCE hInstance;
    int offsetQuery;
    int iColumns;
    uint dwReserved;
    DSCOLUMN aColumns;
}

struct DSQUERYCLASSLIST
{
    uint cbStruct;
    int cClasses;
    uint offsetClass;
}

interface IDsAdminCreateObj : IUnknown
{
    HRESULT Initialize(IADsContainer pADsContainerObj, IADs pADsCopySource, const(wchar)* lpszClassName);
    HRESULT CreateModal(HWND hwndParent, IADs* ppADsObj);
}

interface IDsAdminNewObj : IUnknown
{
    HRESULT SetButtons(uint nCurrIndex, BOOL bValid);
    HRESULT GetPageCounts(int* pnTotal, int* pnStartIndex);
}

interface IDsAdminNewObjPrimarySite : IUnknown
{
    HRESULT CreateNew(const(wchar)* pszName);
    HRESULT Commit();
}

struct DSA_NEWOBJ_DISPINFO
{
    uint dwSize;
    HICON hObjClassIcon;
    const(wchar)* lpszWizTitle;
    const(wchar)* lpszContDisplayName;
}

interface IDsAdminNewObjExt : IUnknown
{
    HRESULT Initialize(IADsContainer pADsContainerObj, IADs pADsCopySource, const(wchar)* lpszClassName, IDsAdminNewObj pDsAdminNewObj, DSA_NEWOBJ_DISPINFO* pDispInfo);
    HRESULT AddPages(LPFNADDPROPSHEETPAGE lpfnAddPage, LPARAM lParam);
    HRESULT SetObject(IADs pADsObj);
    HRESULT WriteData(HWND hWnd, uint uContext);
    HRESULT OnError(HWND hWnd, HRESULT hr, uint uContext);
    HRESULT GetSummaryInfo(BSTR* pBstrText);
}

interface IDsAdminNotifyHandler : IUnknown
{
    HRESULT Initialize(IDataObject pExtraInfo, uint* puEventFlags);
    HRESULT Begin(uint uEvent, IDataObject pArg1, IDataObject pArg2, uint* puFlags, BSTR* pBstr);
    HRESULT Notify(uint nItem, uint uFlags);
    HRESULT End();
}

struct ADSPROPINITPARAMS
{
    uint dwSize;
    uint dwFlags;
    HRESULT hr;
    IDirectoryObject pDsObj;
    const(wchar)* pwzCN;
    ADS_ATTR_INFO* pWritableAttrs;
}

struct ADSPROPERROR
{
    HWND hwndPage;
    const(wchar)* pszPageTitle;
    const(wchar)* pszObjPath;
    const(wchar)* pszObjClass;
    HRESULT hr;
    const(wchar)* pszError;
}

struct SCHEDULE_HEADER
{
    uint Type;
    uint Offset;
}

struct SCHEDULE
{
    uint Size;
    uint Bandwidth;
    uint NumberOfSchedules;
    SCHEDULE_HEADER Schedules;
}

enum DS_MANGLE_FOR
{
    DS_MANGLE_UNKNOWN = 0,
    DS_MANGLE_OBJECT_RDN_FOR_DELETION = 1,
    DS_MANGLE_OBJECT_RDN_FOR_NAME_CONFLICT = 2,
}

enum DS_NAME_FORMAT
{
    DS_UNKNOWN_NAME = 0,
    DS_FQDN_1779_NAME = 1,
    DS_NT4_ACCOUNT_NAME = 2,
    DS_DISPLAY_NAME = 3,
    DS_UNIQUE_ID_NAME = 6,
    DS_CANONICAL_NAME = 7,
    DS_USER_PRINCIPAL_NAME = 8,
    DS_CANONICAL_NAME_EX = 9,
    DS_SERVICE_PRINCIPAL_NAME = 10,
    DS_SID_OR_SID_HISTORY_NAME = 11,
    DS_DNS_DOMAIN_NAME = 12,
}

enum DS_NAME_FLAGS
{
    DS_NAME_NO_FLAGS = 0,
    DS_NAME_FLAG_SYNTACTICAL_ONLY = 1,
    DS_NAME_FLAG_EVAL_AT_DC = 2,
    DS_NAME_FLAG_GCVERIFY = 4,
    DS_NAME_FLAG_TRUST_REFERRAL = 8,
}

enum DS_NAME_ERROR
{
    DS_NAME_NO_ERROR = 0,
    DS_NAME_ERROR_RESOLVING = 1,
    DS_NAME_ERROR_NOT_FOUND = 2,
    DS_NAME_ERROR_NOT_UNIQUE = 3,
    DS_NAME_ERROR_NO_MAPPING = 4,
    DS_NAME_ERROR_DOMAIN_ONLY = 5,
    DS_NAME_ERROR_NO_SYNTACTICAL_MAPPING = 6,
    DS_NAME_ERROR_TRUST_REFERRAL = 7,
}

enum DS_SPN_NAME_TYPE
{
    DS_SPN_DNS_HOST = 0,
    DS_SPN_DN_HOST = 1,
    DS_SPN_NB_HOST = 2,
    DS_SPN_DOMAIN = 3,
    DS_SPN_NB_DOMAIN = 4,
    DS_SPN_SERVICE = 5,
}

enum DS_SPN_WRITE_OP
{
    DS_SPN_ADD_SPN_OP = 0,
    DS_SPN_REPLACE_SPN_OP = 1,
    DS_SPN_DELETE_SPN_OP = 2,
}

struct DS_NAME_RESULT_ITEMA
{
    uint status;
    const(char)* pDomain;
    const(char)* pName;
}

struct DS_NAME_RESULTA
{
    uint cItems;
    DS_NAME_RESULT_ITEMA* rItems;
}

struct DS_NAME_RESULT_ITEMW
{
    uint status;
    const(wchar)* pDomain;
    const(wchar)* pName;
}

struct DS_NAME_RESULTW
{
    uint cItems;
    DS_NAME_RESULT_ITEMW* rItems;
}

enum DS_REPSYNCALL_ERROR
{
    DS_REPSYNCALL_WIN32_ERROR_CONTACTING_SERVER = 0,
    DS_REPSYNCALL_WIN32_ERROR_REPLICATING = 1,
    DS_REPSYNCALL_SERVER_UNREACHABLE = 2,
}

enum DS_REPSYNCALL_EVENT
{
    DS_REPSYNCALL_EVENT_ERROR = 0,
    DS_REPSYNCALL_EVENT_SYNC_STARTED = 1,
    DS_REPSYNCALL_EVENT_SYNC_COMPLETED = 2,
    DS_REPSYNCALL_EVENT_FINISHED = 3,
}

struct DS_REPSYNCALL_SYNCA
{
    const(char)* pszSrcId;
    const(char)* pszDstId;
    const(char)* pszNC;
    Guid* pguidSrc;
    Guid* pguidDst;
}

struct DS_REPSYNCALL_SYNCW
{
    const(wchar)* pszSrcId;
    const(wchar)* pszDstId;
    const(wchar)* pszNC;
    Guid* pguidSrc;
    Guid* pguidDst;
}

struct DS_REPSYNCALL_ERRINFOA
{
    const(char)* pszSvrId;
    DS_REPSYNCALL_ERROR error;
    uint dwWin32Err;
    const(char)* pszSrcId;
}

struct DS_REPSYNCALL_ERRINFOW
{
    const(wchar)* pszSvrId;
    DS_REPSYNCALL_ERROR error;
    uint dwWin32Err;
    const(wchar)* pszSrcId;
}

struct DS_REPSYNCALL_UPDATEA
{
    DS_REPSYNCALL_EVENT event;
    DS_REPSYNCALL_ERRINFOA* pErrInfo;
    DS_REPSYNCALL_SYNCA* pSync;
}

struct DS_REPSYNCALL_UPDATEW
{
    DS_REPSYNCALL_EVENT event;
    DS_REPSYNCALL_ERRINFOW* pErrInfo;
    DS_REPSYNCALL_SYNCW* pSync;
}

struct DS_SITE_COST_INFO
{
    uint errorCode;
    uint cost;
}

struct DS_SCHEMA_GUID_MAPA
{
    Guid guid;
    uint guidType;
    const(char)* pName;
}

struct DS_SCHEMA_GUID_MAPW
{
    Guid guid;
    uint guidType;
    const(wchar)* pName;
}

struct DS_DOMAIN_CONTROLLER_INFO_1A
{
    const(char)* NetbiosName;
    const(char)* DnsHostName;
    const(char)* SiteName;
    const(char)* ComputerObjectName;
    const(char)* ServerObjectName;
    BOOL fIsPdc;
    BOOL fDsEnabled;
}

struct DS_DOMAIN_CONTROLLER_INFO_1W
{
    const(wchar)* NetbiosName;
    const(wchar)* DnsHostName;
    const(wchar)* SiteName;
    const(wchar)* ComputerObjectName;
    const(wchar)* ServerObjectName;
    BOOL fIsPdc;
    BOOL fDsEnabled;
}

struct DS_DOMAIN_CONTROLLER_INFO_2A
{
    const(char)* NetbiosName;
    const(char)* DnsHostName;
    const(char)* SiteName;
    const(char)* SiteObjectName;
    const(char)* ComputerObjectName;
    const(char)* ServerObjectName;
    const(char)* NtdsDsaObjectName;
    BOOL fIsPdc;
    BOOL fDsEnabled;
    BOOL fIsGc;
    Guid SiteObjectGuid;
    Guid ComputerObjectGuid;
    Guid ServerObjectGuid;
    Guid NtdsDsaObjectGuid;
}

struct DS_DOMAIN_CONTROLLER_INFO_2W
{
    const(wchar)* NetbiosName;
    const(wchar)* DnsHostName;
    const(wchar)* SiteName;
    const(wchar)* SiteObjectName;
    const(wchar)* ComputerObjectName;
    const(wchar)* ServerObjectName;
    const(wchar)* NtdsDsaObjectName;
    BOOL fIsPdc;
    BOOL fDsEnabled;
    BOOL fIsGc;
    Guid SiteObjectGuid;
    Guid ComputerObjectGuid;
    Guid ServerObjectGuid;
    Guid NtdsDsaObjectGuid;
}

struct DS_DOMAIN_CONTROLLER_INFO_3A
{
    const(char)* NetbiosName;
    const(char)* DnsHostName;
    const(char)* SiteName;
    const(char)* SiteObjectName;
    const(char)* ComputerObjectName;
    const(char)* ServerObjectName;
    const(char)* NtdsDsaObjectName;
    BOOL fIsPdc;
    BOOL fDsEnabled;
    BOOL fIsGc;
    BOOL fIsRodc;
    Guid SiteObjectGuid;
    Guid ComputerObjectGuid;
    Guid ServerObjectGuid;
    Guid NtdsDsaObjectGuid;
}

struct DS_DOMAIN_CONTROLLER_INFO_3W
{
    const(wchar)* NetbiosName;
    const(wchar)* DnsHostName;
    const(wchar)* SiteName;
    const(wchar)* SiteObjectName;
    const(wchar)* ComputerObjectName;
    const(wchar)* ServerObjectName;
    const(wchar)* NtdsDsaObjectName;
    BOOL fIsPdc;
    BOOL fDsEnabled;
    BOOL fIsGc;
    BOOL fIsRodc;
    Guid SiteObjectGuid;
    Guid ComputerObjectGuid;
    Guid ServerObjectGuid;
    Guid NtdsDsaObjectGuid;
}

enum DS_KCC_TASKID
{
    DS_KCC_TASKID_UPDATE_TOPOLOGY = 0,
}

enum DS_REPL_INFO_TYPE
{
    DS_REPL_INFO_NEIGHBORS = 0,
    DS_REPL_INFO_CURSORS_FOR_NC = 1,
    DS_REPL_INFO_METADATA_FOR_OBJ = 2,
    DS_REPL_INFO_KCC_DSA_CONNECT_FAILURES = 3,
    DS_REPL_INFO_KCC_DSA_LINK_FAILURES = 4,
    DS_REPL_INFO_PENDING_OPS = 5,
    DS_REPL_INFO_METADATA_FOR_ATTR_VALUE = 6,
    DS_REPL_INFO_CURSORS_2_FOR_NC = 7,
    DS_REPL_INFO_CURSORS_3_FOR_NC = 8,
    DS_REPL_INFO_METADATA_2_FOR_OBJ = 9,
    DS_REPL_INFO_METADATA_2_FOR_ATTR_VALUE = 10,
    DS_REPL_INFO_METADATA_EXT_FOR_ATTR_VALUE = 11,
    DS_REPL_INFO_TYPE_MAX = 12,
}

struct DS_REPL_NEIGHBORW
{
    const(wchar)* pszNamingContext;
    const(wchar)* pszSourceDsaDN;
    const(wchar)* pszSourceDsaAddress;
    const(wchar)* pszAsyncIntersiteTransportDN;
    uint dwReplicaFlags;
    uint dwReserved;
    Guid uuidNamingContextObjGuid;
    Guid uuidSourceDsaObjGuid;
    Guid uuidSourceDsaInvocationID;
    Guid uuidAsyncIntersiteTransportObjGuid;
    long usnLastObjChangeSynced;
    long usnAttributeFilter;
    FILETIME ftimeLastSyncSuccess;
    FILETIME ftimeLastSyncAttempt;
    uint dwLastSyncResult;
    uint cNumConsecutiveSyncFailures;
}

struct DS_REPL_NEIGHBORW_BLOB
{
    uint oszNamingContext;
    uint oszSourceDsaDN;
    uint oszSourceDsaAddress;
    uint oszAsyncIntersiteTransportDN;
    uint dwReplicaFlags;
    uint dwReserved;
    Guid uuidNamingContextObjGuid;
    Guid uuidSourceDsaObjGuid;
    Guid uuidSourceDsaInvocationID;
    Guid uuidAsyncIntersiteTransportObjGuid;
    long usnLastObjChangeSynced;
    long usnAttributeFilter;
    FILETIME ftimeLastSyncSuccess;
    FILETIME ftimeLastSyncAttempt;
    uint dwLastSyncResult;
    uint cNumConsecutiveSyncFailures;
}

struct DS_REPL_NEIGHBORSW
{
    uint cNumNeighbors;
    uint dwReserved;
    DS_REPL_NEIGHBORW rgNeighbor;
}

struct DS_REPL_CURSOR
{
    Guid uuidSourceDsaInvocationID;
    long usnAttributeFilter;
}

struct DS_REPL_CURSOR_2
{
    Guid uuidSourceDsaInvocationID;
    long usnAttributeFilter;
    FILETIME ftimeLastSyncSuccess;
}

struct DS_REPL_CURSOR_3W
{
    Guid uuidSourceDsaInvocationID;
    long usnAttributeFilter;
    FILETIME ftimeLastSyncSuccess;
    const(wchar)* pszSourceDsaDN;
}

struct DS_REPL_CURSOR_BLOB
{
    Guid uuidSourceDsaInvocationID;
    long usnAttributeFilter;
    FILETIME ftimeLastSyncSuccess;
    uint oszSourceDsaDN;
}

struct DS_REPL_CURSORS
{
    uint cNumCursors;
    uint dwReserved;
    DS_REPL_CURSOR rgCursor;
}

struct DS_REPL_CURSORS_2
{
    uint cNumCursors;
    uint dwEnumerationContext;
    DS_REPL_CURSOR_2 rgCursor;
}

struct DS_REPL_CURSORS_3W
{
    uint cNumCursors;
    uint dwEnumerationContext;
    DS_REPL_CURSOR_3W rgCursor;
}

struct DS_REPL_ATTR_META_DATA
{
    const(wchar)* pszAttributeName;
    uint dwVersion;
    FILETIME ftimeLastOriginatingChange;
    Guid uuidLastOriginatingDsaInvocationID;
    long usnOriginatingChange;
    long usnLocalChange;
}

struct DS_REPL_ATTR_META_DATA_2
{
    const(wchar)* pszAttributeName;
    uint dwVersion;
    FILETIME ftimeLastOriginatingChange;
    Guid uuidLastOriginatingDsaInvocationID;
    long usnOriginatingChange;
    long usnLocalChange;
    const(wchar)* pszLastOriginatingDsaDN;
}

struct DS_REPL_ATTR_META_DATA_BLOB
{
    uint oszAttributeName;
    uint dwVersion;
    FILETIME ftimeLastOriginatingChange;
    Guid uuidLastOriginatingDsaInvocationID;
    long usnOriginatingChange;
    long usnLocalChange;
    uint oszLastOriginatingDsaDN;
}

struct DS_REPL_OBJ_META_DATA
{
    uint cNumEntries;
    uint dwReserved;
    DS_REPL_ATTR_META_DATA rgMetaData;
}

struct DS_REPL_OBJ_META_DATA_2
{
    uint cNumEntries;
    uint dwReserved;
    DS_REPL_ATTR_META_DATA_2 rgMetaData;
}

struct DS_REPL_KCC_DSA_FAILUREW
{
    const(wchar)* pszDsaDN;
    Guid uuidDsaObjGuid;
    FILETIME ftimeFirstFailure;
    uint cNumFailures;
    uint dwLastResult;
}

struct DS_REPL_KCC_DSA_FAILUREW_BLOB
{
    uint oszDsaDN;
    Guid uuidDsaObjGuid;
    FILETIME ftimeFirstFailure;
    uint cNumFailures;
    uint dwLastResult;
}

struct DS_REPL_KCC_DSA_FAILURESW
{
    uint cNumEntries;
    uint dwReserved;
    DS_REPL_KCC_DSA_FAILUREW rgDsaFailure;
}

enum DS_REPL_OP_TYPE
{
    DS_REPL_OP_TYPE_SYNC = 0,
    DS_REPL_OP_TYPE_ADD = 1,
    DS_REPL_OP_TYPE_DELETE = 2,
    DS_REPL_OP_TYPE_MODIFY = 3,
    DS_REPL_OP_TYPE_UPDATE_REFS = 4,
}

struct DS_REPL_OPW
{
    FILETIME ftimeEnqueued;
    uint ulSerialNumber;
    uint ulPriority;
    DS_REPL_OP_TYPE OpType;
    uint ulOptions;
    const(wchar)* pszNamingContext;
    const(wchar)* pszDsaDN;
    const(wchar)* pszDsaAddress;
    Guid uuidNamingContextObjGuid;
    Guid uuidDsaObjGuid;
}

struct DS_REPL_OPW_BLOB
{
    FILETIME ftimeEnqueued;
    uint ulSerialNumber;
    uint ulPriority;
    DS_REPL_OP_TYPE OpType;
    uint ulOptions;
    uint oszNamingContext;
    uint oszDsaDN;
    uint oszDsaAddress;
    Guid uuidNamingContextObjGuid;
    Guid uuidDsaObjGuid;
}

struct DS_REPL_PENDING_OPSW
{
    FILETIME ftimeCurrentOpStarted;
    uint cNumPendingOps;
    DS_REPL_OPW rgPendingOp;
}

struct DS_REPL_VALUE_META_DATA
{
    const(wchar)* pszAttributeName;
    const(wchar)* pszObjectDn;
    uint cbData;
    ubyte* pbData;
    FILETIME ftimeDeleted;
    FILETIME ftimeCreated;
    uint dwVersion;
    FILETIME ftimeLastOriginatingChange;
    Guid uuidLastOriginatingDsaInvocationID;
    long usnOriginatingChange;
    long usnLocalChange;
}

struct DS_REPL_VALUE_META_DATA_2
{
    const(wchar)* pszAttributeName;
    const(wchar)* pszObjectDn;
    uint cbData;
    ubyte* pbData;
    FILETIME ftimeDeleted;
    FILETIME ftimeCreated;
    uint dwVersion;
    FILETIME ftimeLastOriginatingChange;
    Guid uuidLastOriginatingDsaInvocationID;
    long usnOriginatingChange;
    long usnLocalChange;
    const(wchar)* pszLastOriginatingDsaDN;
}

struct DS_REPL_VALUE_META_DATA_EXT
{
    const(wchar)* pszAttributeName;
    const(wchar)* pszObjectDn;
    uint cbData;
    ubyte* pbData;
    FILETIME ftimeDeleted;
    FILETIME ftimeCreated;
    uint dwVersion;
    FILETIME ftimeLastOriginatingChange;
    Guid uuidLastOriginatingDsaInvocationID;
    long usnOriginatingChange;
    long usnLocalChange;
    const(wchar)* pszLastOriginatingDsaDN;
    uint dwUserIdentifier;
    uint dwPriorLinkState;
    uint dwCurrentLinkState;
}

struct DS_REPL_VALUE_META_DATA_BLOB
{
    uint oszAttributeName;
    uint oszObjectDn;
    uint cbData;
    uint obData;
    FILETIME ftimeDeleted;
    FILETIME ftimeCreated;
    uint dwVersion;
    FILETIME ftimeLastOriginatingChange;
    Guid uuidLastOriginatingDsaInvocationID;
    long usnOriginatingChange;
    long usnLocalChange;
    uint oszLastOriginatingDsaDN;
}

struct DS_REPL_VALUE_META_DATA_BLOB_EXT
{
    uint oszAttributeName;
    uint oszObjectDn;
    uint cbData;
    uint obData;
    FILETIME ftimeDeleted;
    FILETIME ftimeCreated;
    uint dwVersion;
    FILETIME ftimeLastOriginatingChange;
    Guid uuidLastOriginatingDsaInvocationID;
    long usnOriginatingChange;
    long usnLocalChange;
    uint oszLastOriginatingDsaDN;
    uint dwUserIdentifier;
    uint dwPriorLinkState;
    uint dwCurrentLinkState;
}

struct DS_REPL_ATTR_VALUE_META_DATA
{
    uint cNumEntries;
    uint dwEnumerationContext;
    DS_REPL_VALUE_META_DATA rgMetaData;
}

struct DS_REPL_ATTR_VALUE_META_DATA_2
{
    uint cNumEntries;
    uint dwEnumerationContext;
    DS_REPL_VALUE_META_DATA_2 rgMetaData;
}

struct DS_REPL_ATTR_VALUE_META_DATA_EXT
{
    uint cNumEntries;
    uint dwEnumerationContext;
    DS_REPL_VALUE_META_DATA_EXT rgMetaData;
}

struct DS_REPL_QUEUE_STATISTICSW
{
    FILETIME ftimeCurrentOpStarted;
    uint cNumPendingOps;
    FILETIME ftimeOldestSync;
    FILETIME ftimeOldestAdd;
    FILETIME ftimeOldestMod;
    FILETIME ftimeOldestDel;
    FILETIME ftimeOldestUpdRefs;
}

enum DSROLE_MACHINE_ROLE
{
    DsRole_RoleStandaloneWorkstation = 0,
    DsRole_RoleMemberWorkstation = 1,
    DsRole_RoleStandaloneServer = 2,
    DsRole_RoleMemberServer = 3,
    DsRole_RoleBackupDomainController = 4,
    DsRole_RolePrimaryDomainController = 5,
}

enum DSROLE_SERVER_STATE
{
    DsRoleServerUnknown = 0,
    DsRoleServerPrimary = 1,
    DsRoleServerBackup = 2,
}

enum DSROLE_PRIMARY_DOMAIN_INFO_LEVEL
{
    DsRolePrimaryDomainInfoBasic = 1,
    DsRoleUpgradeStatus = 2,
    DsRoleOperationState = 3,
}

struct DSROLE_PRIMARY_DOMAIN_INFO_BASIC
{
    DSROLE_MACHINE_ROLE MachineRole;
    uint Flags;
    const(wchar)* DomainNameFlat;
    const(wchar)* DomainNameDns;
    const(wchar)* DomainForestName;
    Guid DomainGuid;
}

struct DSROLE_UPGRADE_STATUS_INFO
{
    uint OperationState;
    DSROLE_SERVER_STATE PreviousServerState;
}

enum DSROLE_OPERATION_STATE
{
    DsRoleOperationIdle = 0,
    DsRoleOperationActive = 1,
    DsRoleOperationNeedReboot = 2,
}

struct DSROLE_OPERATION_STATE_INFO
{
    DSROLE_OPERATION_STATE OperationState;
}

struct DOMAIN_CONTROLLER_INFOA
{
    const(char)* DomainControllerName;
    const(char)* DomainControllerAddress;
    uint DomainControllerAddressType;
    Guid DomainGuid;
    const(char)* DomainName;
    const(char)* DnsForestName;
    uint Flags;
    const(char)* DcSiteName;
    const(char)* ClientSiteName;
}

struct DOMAIN_CONTROLLER_INFOW
{
    const(wchar)* DomainControllerName;
    const(wchar)* DomainControllerAddress;
    uint DomainControllerAddressType;
    Guid DomainGuid;
    const(wchar)* DomainName;
    const(wchar)* DnsForestName;
    uint Flags;
    const(wchar)* DcSiteName;
    const(wchar)* ClientSiteName;
}

struct DS_DOMAIN_TRUSTSW
{
    const(wchar)* NetbiosDomainName;
    const(wchar)* DnsDomainName;
    uint Flags;
    uint ParentIndex;
    uint TrustType;
    uint TrustAttributes;
    void* DomainSid;
    Guid DomainGuid;
}

struct DS_DOMAIN_TRUSTSA
{
    const(char)* NetbiosDomainName;
    const(char)* DnsDomainName;
    uint Flags;
    uint ParentIndex;
    uint TrustType;
    uint TrustAttributes;
    void* DomainSid;
    Guid DomainGuid;
}

@DllImport("ACTIVEDS.dll")
HRESULT ADsGetObject(const(wchar)* lpszPathName, const(Guid)* riid, void** ppObject);

@DllImport("ACTIVEDS.dll")
HRESULT ADsBuildEnumerator(IADsContainer pADsContainer, IEnumVARIANT* ppEnumVariant);

@DllImport("ACTIVEDS.dll")
HRESULT ADsFreeEnumerator(IEnumVARIANT pEnumVariant);

@DllImport("ACTIVEDS.dll")
HRESULT ADsEnumerateNext(IEnumVARIANT pEnumVariant, uint cElements, VARIANT* pvar, uint* pcElementsFetched);

@DllImport("ACTIVEDS.dll")
HRESULT ADsBuildVarArrayStr(char* lppPathNames, uint dwPathNames, VARIANT* pVar);

@DllImport("ACTIVEDS.dll")
HRESULT ADsBuildVarArrayInt(uint* lpdwObjectTypes, uint dwObjectTypes, VARIANT* pVar);

@DllImport("ACTIVEDS.dll")
HRESULT ADsOpenObject(const(wchar)* lpszPathName, const(wchar)* lpszUserName, const(wchar)* lpszPassword, uint dwReserved, const(Guid)* riid, void** ppObject);

@DllImport("ACTIVEDS.dll")
HRESULT ADsGetLastError(uint* lpError, const(wchar)* lpErrorBuf, uint dwErrorBufLen, const(wchar)* lpNameBuf, uint dwNameBufLen);

@DllImport("ACTIVEDS.dll")
void ADsSetLastError(uint dwErr, const(wchar)* pszError, const(wchar)* pszProvider);

@DllImport("ACTIVEDS.dll")
void* AllocADsMem(uint cb);

@DllImport("ACTIVEDS.dll")
BOOL FreeADsMem(void* pMem);

@DllImport("ACTIVEDS.dll")
void* ReallocADsMem(void* pOldMem, uint cbOld, uint cbNew);

@DllImport("ACTIVEDS.dll")
ushort* AllocADsStr(const(wchar)* pStr);

@DllImport("ACTIVEDS.dll")
BOOL FreeADsStr(const(wchar)* pStr);

@DllImport("ACTIVEDS.dll")
BOOL ReallocADsStr(ushort** ppStr, const(wchar)* pStr);

@DllImport("ACTIVEDS.dll")
HRESULT ADsEncodeBinaryData(ubyte* pbSrcData, uint dwSrcLen, ushort** ppszDestData);

@DllImport("ACTIVEDS.dll")
HRESULT ADsDecodeBinaryData(const(wchar)* szSrcData, ubyte** ppbDestData, uint* pdwDestLen);

@DllImport("ACTIVEDS.dll")
HRESULT PropVariantToAdsType(VARIANT* pVariant, uint dwNumVariant, ADSVALUE** ppAdsValues, uint* pdwNumValues);

@DllImport("ACTIVEDS.dll")
HRESULT AdsTypeToPropVariant(ADSVALUE* pAdsValues, uint dwNumValues, VARIANT* pVariant);

@DllImport("ACTIVEDS.dll")
void AdsFreeAdsValues(ADSVALUE* pAdsValues, uint dwNumValues);

@DllImport("ACTIVEDS.dll")
HRESULT BinarySDToSecurityDescriptor(void* pSecurityDescriptor, VARIANT* pVarsec, const(wchar)* pszServerName, const(wchar)* userName, const(wchar)* passWord, uint dwFlags);

@DllImport("ACTIVEDS.dll")
HRESULT SecurityDescriptorToBinarySD(VARIANT vVarSecDes, void** ppSecurityDescriptor, uint* pdwSDLength, const(wchar)* pszServerName, const(wchar)* userName, const(wchar)* passWord, uint dwFlags);

@DllImport("dsuiext.dll")
int DsBrowseForContainerW(DSBROWSEINFOW* pInfo);

@DllImport("dsuiext.dll")
int DsBrowseForContainerA(DSBROWSEINFOA* pInfo);

@DllImport("dsuiext.dll")
HICON DsGetIcon(uint dwFlags, const(wchar)* pszObjectClass, int cxImage, int cyImage);

@DllImport("dsuiext.dll")
HRESULT DsGetFriendlyClassName(const(wchar)* pszObjectClass, const(wchar)* pszBuffer, uint cchBuffer);

@DllImport("dsprop.dll")
HRESULT ADsPropCreateNotifyObj(IDataObject pAppThdDataObj, const(wchar)* pwzADsObjName, HWND* phNotifyObj);

@DllImport("dsprop.dll")
BOOL ADsPropGetInitInfo(HWND hNotifyObj, ADSPROPINITPARAMS* pInitParams);

@DllImport("dsprop.dll")
BOOL ADsPropSetHwndWithTitle(HWND hNotifyObj, HWND hPage, byte* ptzTitle);

@DllImport("dsprop.dll")
BOOL ADsPropSetHwnd(HWND hNotifyObj, HWND hPage);

@DllImport("dsprop.dll")
BOOL ADsPropCheckIfWritable(const(ushort)* pwzAttr, const(ADS_ATTR_INFO)* pWritableAttrs);

@DllImport("dsprop.dll")
BOOL ADsPropSendErrorMessage(HWND hNotifyObj, ADSPROPERROR* pError);

@DllImport("dsprop.dll")
BOOL ADsPropShowErrorDialog(HWND hNotifyObj, HWND hPage);

@DllImport("DSPARSE.dll")
uint DsMakeSpnW(const(wchar)* ServiceClass, const(wchar)* ServiceName, const(wchar)* InstanceName, ushort InstancePort, const(wchar)* Referrer, uint* pcSpnLength, const(wchar)* pszSpn);

@DllImport("DSPARSE.dll")
uint DsMakeSpnA(const(char)* ServiceClass, const(char)* ServiceName, const(char)* InstanceName, ushort InstancePort, const(char)* Referrer, uint* pcSpnLength, const(char)* pszSpn);

@DllImport("DSPARSE.dll")
uint DsCrackSpnA(const(char)* pszSpn, uint* pcServiceClass, const(char)* ServiceClass, uint* pcServiceName, const(char)* ServiceName, uint* pcInstanceName, const(char)* InstanceName, ushort* pInstancePort);

@DllImport("DSPARSE.dll")
uint DsCrackSpnW(const(wchar)* pszSpn, uint* pcServiceClass, const(wchar)* ServiceClass, uint* pcServiceName, const(wchar)* ServiceName, uint* pcInstanceName, const(wchar)* InstanceName, ushort* pInstancePort);

@DllImport("DSPARSE.dll")
uint DsQuoteRdnValueW(uint cUnquotedRdnValueLength, const(wchar)* psUnquotedRdnValue, uint* pcQuotedRdnValueLength, const(wchar)* psQuotedRdnValue);

@DllImport("DSPARSE.dll")
uint DsQuoteRdnValueA(uint cUnquotedRdnValueLength, const(char)* psUnquotedRdnValue, uint* pcQuotedRdnValueLength, const(char)* psQuotedRdnValue);

@DllImport("DSPARSE.dll")
uint DsUnquoteRdnValueW(uint cQuotedRdnValueLength, const(wchar)* psQuotedRdnValue, uint* pcUnquotedRdnValueLength, const(wchar)* psUnquotedRdnValue);

@DllImport("DSPARSE.dll")
uint DsUnquoteRdnValueA(uint cQuotedRdnValueLength, const(char)* psQuotedRdnValue, uint* pcUnquotedRdnValueLength, const(char)* psUnquotedRdnValue);

@DllImport("DSPARSE.dll")
uint DsGetRdnW(char* ppDN, uint* pcDN, ushort** ppKey, uint* pcKey, ushort** ppVal, uint* pcVal);

@DllImport("DSPARSE.dll")
BOOL DsCrackUnquotedMangledRdnW(const(wchar)* pszRDN, uint cchRDN, Guid* pGuid, DS_MANGLE_FOR* peDsMangleFor);

@DllImport("DSPARSE.dll")
BOOL DsCrackUnquotedMangledRdnA(const(char)* pszRDN, uint cchRDN, Guid* pGuid, DS_MANGLE_FOR* peDsMangleFor);

@DllImport("DSPARSE.dll")
BOOL DsIsMangledRdnValueW(const(wchar)* pszRdn, uint cRdn, DS_MANGLE_FOR eDsMangleForDesired);

@DllImport("DSPARSE.dll")
BOOL DsIsMangledRdnValueA(const(char)* pszRdn, uint cRdn, DS_MANGLE_FOR eDsMangleForDesired);

@DllImport("DSPARSE.dll")
BOOL DsIsMangledDnA(const(char)* pszDn, DS_MANGLE_FOR eDsMangleFor);

@DllImport("DSPARSE.dll")
BOOL DsIsMangledDnW(const(wchar)* pszDn, DS_MANGLE_FOR eDsMangleFor);

@DllImport("DSPARSE.dll")
uint DsCrackSpn2A(const(char)* pszSpn, uint cSpn, uint* pcServiceClass, const(char)* ServiceClass, uint* pcServiceName, const(char)* ServiceName, uint* pcInstanceName, const(char)* InstanceName, ushort* pInstancePort);

@DllImport("DSPARSE.dll")
uint DsCrackSpn2W(const(wchar)* pszSpn, uint cSpn, uint* pcServiceClass, const(wchar)* ServiceClass, uint* pcServiceName, const(wchar)* ServiceName, uint* pcInstanceName, const(wchar)* InstanceName, ushort* pInstancePort);

@DllImport("DSPARSE.dll")
uint DsCrackSpn3W(const(wchar)* pszSpn, uint cSpn, uint* pcHostName, const(wchar)* HostName, uint* pcInstanceName, const(wchar)* InstanceName, ushort* pPortNumber, uint* pcDomainName, const(wchar)* DomainName, uint* pcRealmName, const(wchar)* RealmName);

@DllImport("DSPARSE.dll")
uint DsCrackSpn4W(const(wchar)* pszSpn, uint cSpn, uint* pcHostName, const(wchar)* HostName, uint* pcInstanceName, const(wchar)* InstanceName, uint* pcPortName, const(wchar)* PortName, uint* pcDomainName, const(wchar)* DomainName, uint* pcRealmName, const(wchar)* RealmName);

@DllImport("NTDSAPI.dll")
uint DsBindW(const(wchar)* DomainControllerName, const(wchar)* DnsDomainName, HANDLE* phDS);

@DllImport("NTDSAPI.dll")
uint DsBindA(const(char)* DomainControllerName, const(char)* DnsDomainName, HANDLE* phDS);

@DllImport("NTDSAPI.dll")
uint DsBindWithCredW(const(wchar)* DomainControllerName, const(wchar)* DnsDomainName, void* AuthIdentity, HANDLE* phDS);

@DllImport("NTDSAPI.dll")
uint DsBindWithCredA(const(char)* DomainControllerName, const(char)* DnsDomainName, void* AuthIdentity, HANDLE* phDS);

@DllImport("NTDSAPI.dll")
uint DsBindWithSpnW(const(wchar)* DomainControllerName, const(wchar)* DnsDomainName, void* AuthIdentity, const(wchar)* ServicePrincipalName, HANDLE* phDS);

@DllImport("NTDSAPI.dll")
uint DsBindWithSpnA(const(char)* DomainControllerName, const(char)* DnsDomainName, void* AuthIdentity, const(char)* ServicePrincipalName, HANDLE* phDS);

@DllImport("NTDSAPI.dll")
uint DsBindWithSpnExW(const(wchar)* DomainControllerName, const(wchar)* DnsDomainName, void* AuthIdentity, const(wchar)* ServicePrincipalName, uint BindFlags, HANDLE* phDS);

@DllImport("NTDSAPI.dll")
uint DsBindWithSpnExA(const(char)* DomainControllerName, const(char)* DnsDomainName, void* AuthIdentity, const(char)* ServicePrincipalName, uint BindFlags, HANDLE* phDS);

@DllImport("NTDSAPI.dll")
uint DsBindByInstanceW(const(wchar)* ServerName, const(wchar)* Annotation, Guid* InstanceGuid, const(wchar)* DnsDomainName, void* AuthIdentity, const(wchar)* ServicePrincipalName, uint BindFlags, HANDLE* phDS);

@DllImport("NTDSAPI.dll")
uint DsBindByInstanceA(const(char)* ServerName, const(char)* Annotation, Guid* InstanceGuid, const(char)* DnsDomainName, void* AuthIdentity, const(char)* ServicePrincipalName, uint BindFlags, HANDLE* phDS);

@DllImport("NTDSAPI.dll")
uint DsBindToISTGW(const(wchar)* SiteName, HANDLE* phDS);

@DllImport("NTDSAPI.dll")
uint DsBindToISTGA(const(char)* SiteName, HANDLE* phDS);

@DllImport("NTDSAPI.dll")
uint DsBindingSetTimeout(HANDLE hDS, uint cTimeoutSecs);

@DllImport("NTDSAPI.dll")
uint DsUnBindW(HANDLE* phDS);

@DllImport("NTDSAPI.dll")
uint DsUnBindA(HANDLE* phDS);

@DllImport("NTDSAPI.dll")
uint DsMakePasswordCredentialsW(const(wchar)* User, const(wchar)* Domain, const(wchar)* Password, void** pAuthIdentity);

@DllImport("NTDSAPI.dll")
uint DsMakePasswordCredentialsA(const(char)* User, const(char)* Domain, const(char)* Password, void** pAuthIdentity);

@DllImport("NTDSAPI.dll")
void DsFreePasswordCredentials(void* AuthIdentity);

@DllImport("NTDSAPI.dll")
uint DsCrackNamesW(HANDLE hDS, DS_NAME_FLAGS flags, DS_NAME_FORMAT formatOffered, DS_NAME_FORMAT formatDesired, uint cNames, char* rpNames, DS_NAME_RESULTW** ppResult);

@DllImport("NTDSAPI.dll")
uint DsCrackNamesA(HANDLE hDS, DS_NAME_FLAGS flags, DS_NAME_FORMAT formatOffered, DS_NAME_FORMAT formatDesired, uint cNames, char* rpNames, DS_NAME_RESULTA** ppResult);

@DllImport("NTDSAPI.dll")
void DsFreeNameResultW(DS_NAME_RESULTW* pResult);

@DllImport("NTDSAPI.dll")
void DsFreeNameResultA(DS_NAME_RESULTA* pResult);

@DllImport("NTDSAPI.dll")
uint DsGetSpnA(DS_SPN_NAME_TYPE ServiceType, const(char)* ServiceClass, const(char)* ServiceName, ushort InstancePort, ushort cInstanceNames, char* pInstanceNames, char* pInstancePorts, uint* pcSpn, byte*** prpszSpn);

@DllImport("NTDSAPI.dll")
uint DsGetSpnW(DS_SPN_NAME_TYPE ServiceType, const(wchar)* ServiceClass, const(wchar)* ServiceName, ushort InstancePort, ushort cInstanceNames, char* pInstanceNames, char* pInstancePorts, uint* pcSpn, ushort*** prpszSpn);

@DllImport("NTDSAPI.dll")
void DsFreeSpnArrayA(uint cSpn, char* rpszSpn);

@DllImport("NTDSAPI.dll")
void DsFreeSpnArrayW(uint cSpn, char* rpszSpn);

@DllImport("NTDSAPI.dll")
uint DsWriteAccountSpnA(HANDLE hDS, DS_SPN_WRITE_OP Operation, const(char)* pszAccount, uint cSpn, char* rpszSpn);

@DllImport("NTDSAPI.dll")
uint DsWriteAccountSpnW(HANDLE hDS, DS_SPN_WRITE_OP Operation, const(wchar)* pszAccount, uint cSpn, char* rpszSpn);

@DllImport("NTDSAPI.dll")
uint DsClientMakeSpnForTargetServerW(const(wchar)* ServiceClass, const(wchar)* ServiceName, uint* pcSpnLength, const(wchar)* pszSpn);

@DllImport("NTDSAPI.dll")
uint DsClientMakeSpnForTargetServerA(const(char)* ServiceClass, const(char)* ServiceName, uint* pcSpnLength, const(char)* pszSpn);

@DllImport("NTDSAPI.dll")
uint DsServerRegisterSpnA(DS_SPN_WRITE_OP Operation, const(char)* ServiceClass, const(char)* UserObjectDN);

@DllImport("NTDSAPI.dll")
uint DsServerRegisterSpnW(DS_SPN_WRITE_OP Operation, const(wchar)* ServiceClass, const(wchar)* UserObjectDN);

@DllImport("NTDSAPI.dll")
uint DsReplicaSyncA(HANDLE hDS, const(char)* NameContext, const(Guid)* pUuidDsaSrc, uint Options);

@DllImport("NTDSAPI.dll")
uint DsReplicaSyncW(HANDLE hDS, const(wchar)* NameContext, const(Guid)* pUuidDsaSrc, uint Options);

@DllImport("NTDSAPI.dll")
uint DsReplicaAddA(HANDLE hDS, const(char)* NameContext, const(char)* SourceDsaDn, const(char)* TransportDn, const(char)* SourceDsaAddress, const(SCHEDULE)* pSchedule, uint Options);

@DllImport("NTDSAPI.dll")
uint DsReplicaAddW(HANDLE hDS, const(wchar)* NameContext, const(wchar)* SourceDsaDn, const(wchar)* TransportDn, const(wchar)* SourceDsaAddress, const(SCHEDULE)* pSchedule, uint Options);

@DllImport("NTDSAPI.dll")
uint DsReplicaDelA(HANDLE hDS, const(char)* NameContext, const(char)* DsaSrc, uint Options);

@DllImport("NTDSAPI.dll")
uint DsReplicaDelW(HANDLE hDS, const(wchar)* NameContext, const(wchar)* DsaSrc, uint Options);

@DllImport("NTDSAPI.dll")
uint DsReplicaModifyA(HANDLE hDS, const(char)* NameContext, const(Guid)* pUuidSourceDsa, const(char)* TransportDn, const(char)* SourceDsaAddress, const(SCHEDULE)* pSchedule, uint ReplicaFlags, uint ModifyFields, uint Options);

@DllImport("NTDSAPI.dll")
uint DsReplicaModifyW(HANDLE hDS, const(wchar)* NameContext, const(Guid)* pUuidSourceDsa, const(wchar)* TransportDn, const(wchar)* SourceDsaAddress, const(SCHEDULE)* pSchedule, uint ReplicaFlags, uint ModifyFields, uint Options);

@DllImport("NTDSAPI.dll")
uint DsReplicaUpdateRefsA(HANDLE hDS, const(char)* NameContext, const(char)* DsaDest, const(Guid)* pUuidDsaDest, uint Options);

@DllImport("NTDSAPI.dll")
uint DsReplicaUpdateRefsW(HANDLE hDS, const(wchar)* NameContext, const(wchar)* DsaDest, const(Guid)* pUuidDsaDest, uint Options);

@DllImport("NTDSAPI.dll")
uint DsReplicaSyncAllA(HANDLE hDS, const(char)* pszNameContext, uint ulFlags, BOOL*********** pFnCallBack, void* pCallbackData, DS_REPSYNCALL_ERRINFOA*** pErrors);

@DllImport("NTDSAPI.dll")
uint DsReplicaSyncAllW(HANDLE hDS, const(wchar)* pszNameContext, uint ulFlags, BOOL*********** pFnCallBack, void* pCallbackData, DS_REPSYNCALL_ERRINFOW*** pErrors);

@DllImport("NTDSAPI.dll")
uint DsRemoveDsServerW(HANDLE hDs, const(wchar)* ServerDN, const(wchar)* DomainDN, int* fLastDcInDomain, BOOL fCommit);

@DllImport("NTDSAPI.dll")
uint DsRemoveDsServerA(HANDLE hDs, const(char)* ServerDN, const(char)* DomainDN, int* fLastDcInDomain, BOOL fCommit);

@DllImport("NTDSAPI.dll")
uint DsRemoveDsDomainW(HANDLE hDs, const(wchar)* DomainDN);

@DllImport("NTDSAPI.dll")
uint DsRemoveDsDomainA(HANDLE hDs, const(char)* DomainDN);

@DllImport("NTDSAPI.dll")
uint DsListSitesA(HANDLE hDs, DS_NAME_RESULTA** ppSites);

@DllImport("NTDSAPI.dll")
uint DsListSitesW(HANDLE hDs, DS_NAME_RESULTW** ppSites);

@DllImport("NTDSAPI.dll")
uint DsListServersInSiteA(HANDLE hDs, const(char)* site, DS_NAME_RESULTA** ppServers);

@DllImport("NTDSAPI.dll")
uint DsListServersInSiteW(HANDLE hDs, const(wchar)* site, DS_NAME_RESULTW** ppServers);

@DllImport("NTDSAPI.dll")
uint DsListDomainsInSiteA(HANDLE hDs, const(char)* site, DS_NAME_RESULTA** ppDomains);

@DllImport("NTDSAPI.dll")
uint DsListDomainsInSiteW(HANDLE hDs, const(wchar)* site, DS_NAME_RESULTW** ppDomains);

@DllImport("NTDSAPI.dll")
uint DsListServersForDomainInSiteA(HANDLE hDs, const(char)* domain, const(char)* site, DS_NAME_RESULTA** ppServers);

@DllImport("NTDSAPI.dll")
uint DsListServersForDomainInSiteW(HANDLE hDs, const(wchar)* domain, const(wchar)* site, DS_NAME_RESULTW** ppServers);

@DllImport("NTDSAPI.dll")
uint DsListInfoForServerA(HANDLE hDs, const(char)* server, DS_NAME_RESULTA** ppInfo);

@DllImport("NTDSAPI.dll")
uint DsListInfoForServerW(HANDLE hDs, const(wchar)* server, DS_NAME_RESULTW** ppInfo);

@DllImport("NTDSAPI.dll")
uint DsListRolesA(HANDLE hDs, DS_NAME_RESULTA** ppRoles);

@DllImport("NTDSAPI.dll")
uint DsListRolesW(HANDLE hDs, DS_NAME_RESULTW** ppRoles);

@DllImport("NTDSAPI.dll")
uint DsQuerySitesByCostW(HANDLE hDS, const(wchar)* pwszFromSite, char* rgwszToSites, uint cToSites, uint dwFlags, DS_SITE_COST_INFO** prgSiteInfo);

@DllImport("NTDSAPI.dll")
uint DsQuerySitesByCostA(HANDLE hDS, const(char)* pszFromSite, char* rgszToSites, uint cToSites, uint dwFlags, DS_SITE_COST_INFO** prgSiteInfo);

@DllImport("NTDSAPI.dll")
void DsQuerySitesFree(DS_SITE_COST_INFO* rgSiteInfo);

@DllImport("NTDSAPI.dll")
uint DsMapSchemaGuidsA(HANDLE hDs, uint cGuids, char* rGuids, DS_SCHEMA_GUID_MAPA** ppGuidMap);

@DllImport("NTDSAPI.dll")
void DsFreeSchemaGuidMapA(DS_SCHEMA_GUID_MAPA* pGuidMap);

@DllImport("NTDSAPI.dll")
uint DsMapSchemaGuidsW(HANDLE hDs, uint cGuids, char* rGuids, DS_SCHEMA_GUID_MAPW** ppGuidMap);

@DllImport("NTDSAPI.dll")
void DsFreeSchemaGuidMapW(DS_SCHEMA_GUID_MAPW* pGuidMap);

@DllImport("NTDSAPI.dll")
uint DsGetDomainControllerInfoA(HANDLE hDs, const(char)* DomainName, uint InfoLevel, uint* pcOut, void** ppInfo);

@DllImport("NTDSAPI.dll")
uint DsGetDomainControllerInfoW(HANDLE hDs, const(wchar)* DomainName, uint InfoLevel, uint* pcOut, void** ppInfo);

@DllImport("NTDSAPI.dll")
void DsFreeDomainControllerInfoA(uint InfoLevel, uint cInfo, char* pInfo);

@DllImport("NTDSAPI.dll")
void DsFreeDomainControllerInfoW(uint InfoLevel, uint cInfo, char* pInfo);

@DllImport("NTDSAPI.dll")
uint DsReplicaConsistencyCheck(HANDLE hDS, DS_KCC_TASKID TaskID, uint dwFlags);

@DllImport("NTDSAPI.dll")
uint DsReplicaVerifyObjectsW(HANDLE hDS, const(wchar)* NameContext, const(Guid)* pUuidDsaSrc, uint ulOptions);

@DllImport("NTDSAPI.dll")
uint DsReplicaVerifyObjectsA(HANDLE hDS, const(char)* NameContext, const(Guid)* pUuidDsaSrc, uint ulOptions);

@DllImport("NTDSAPI.dll")
uint DsReplicaGetInfoW(HANDLE hDS, DS_REPL_INFO_TYPE InfoType, const(wchar)* pszObject, Guid* puuidForSourceDsaObjGuid, void** ppInfo);

@DllImport("NTDSAPI.dll")
uint DsReplicaGetInfo2W(HANDLE hDS, DS_REPL_INFO_TYPE InfoType, const(wchar)* pszObject, Guid* puuidForSourceDsaObjGuid, const(wchar)* pszAttributeName, const(wchar)* pszValue, uint dwFlags, uint dwEnumerationContext, void** ppInfo);

@DllImport("NTDSAPI.dll")
void DsReplicaFreeInfo(DS_REPL_INFO_TYPE InfoType, void* pInfo);

@DllImport("NTDSAPI.dll")
uint DsAddSidHistoryW(HANDLE hDS, uint Flags, const(wchar)* SrcDomain, const(wchar)* SrcPrincipal, const(wchar)* SrcDomainController, void* SrcDomainCreds, const(wchar)* DstDomain, const(wchar)* DstPrincipal);

@DllImport("NTDSAPI.dll")
uint DsAddSidHistoryA(HANDLE hDS, uint Flags, const(char)* SrcDomain, const(char)* SrcPrincipal, const(char)* SrcDomainController, void* SrcDomainCreds, const(char)* DstDomain, const(char)* DstPrincipal);

@DllImport("NTDSAPI.dll")
uint DsInheritSecurityIdentityW(HANDLE hDS, uint Flags, const(wchar)* SrcPrincipal, const(wchar)* DstPrincipal);

@DllImport("NTDSAPI.dll")
uint DsInheritSecurityIdentityA(HANDLE hDS, uint Flags, const(char)* SrcPrincipal, const(char)* DstPrincipal);

@DllImport("DSROLE.dll")
uint DsRoleGetPrimaryDomainInformation(const(wchar)* lpServer, DSROLE_PRIMARY_DOMAIN_INFO_LEVEL InfoLevel, ubyte** Buffer);

@DllImport("DSROLE.dll")
void DsRoleFreeMemory(void* Buffer);

@DllImport("logoncli.dll")
uint DsGetDcNameA(const(char)* ComputerName, const(char)* DomainName, Guid* DomainGuid, const(char)* SiteName, uint Flags, DOMAIN_CONTROLLER_INFOA** DomainControllerInfo);

@DllImport("logoncli.dll")
uint DsGetDcNameW(const(wchar)* ComputerName, const(wchar)* DomainName, Guid* DomainGuid, const(wchar)* SiteName, uint Flags, DOMAIN_CONTROLLER_INFOW** DomainControllerInfo);

@DllImport("logoncli.dll")
uint DsGetSiteNameA(const(char)* ComputerName, byte** SiteName);

@DllImport("logoncli.dll")
uint DsGetSiteNameW(const(wchar)* ComputerName, ushort** SiteName);

@DllImport("logoncli.dll")
uint DsValidateSubnetNameW(const(wchar)* SubnetName);

@DllImport("logoncli.dll")
uint DsValidateSubnetNameA(const(char)* SubnetName);

@DllImport("logoncli.dll")
uint DsAddressToSiteNamesW(const(wchar)* ComputerName, uint EntryCount, char* SocketAddresses, ushort*** SiteNames);

@DllImport("logoncli.dll")
uint DsAddressToSiteNamesA(const(char)* ComputerName, uint EntryCount, char* SocketAddresses, byte*** SiteNames);

@DllImport("logoncli.dll")
uint DsAddressToSiteNamesExW(const(wchar)* ComputerName, uint EntryCount, char* SocketAddresses, ushort*** SiteNames, ushort*** SubnetNames);

@DllImport("logoncli.dll")
uint DsAddressToSiteNamesExA(const(char)* ComputerName, uint EntryCount, char* SocketAddresses, byte*** SiteNames, byte*** SubnetNames);

@DllImport("logoncli.dll")
uint DsEnumerateDomainTrustsW(const(wchar)* ServerName, uint Flags, DS_DOMAIN_TRUSTSW** Domains, uint* DomainCount);

@DllImport("logoncli.dll")
uint DsEnumerateDomainTrustsA(const(char)* ServerName, uint Flags, DS_DOMAIN_TRUSTSA** Domains, uint* DomainCount);

@DllImport("logoncli.dll")
uint DsGetForestTrustInformationW(const(wchar)* ServerName, const(wchar)* TrustedDomainName, uint Flags, LSA_FOREST_TRUST_INFORMATION** ForestTrustInfo);

@DllImport("logoncli.dll")
uint DsMergeForestTrustInformationW(const(wchar)* DomainName, LSA_FOREST_TRUST_INFORMATION* NewForestTrustInfo, LSA_FOREST_TRUST_INFORMATION* OldForestTrustInfo, LSA_FOREST_TRUST_INFORMATION** MergedForestTrustInfo);

@DllImport("logoncli.dll")
uint DsGetDcSiteCoverageW(const(wchar)* ServerName, uint* EntryCount, ushort*** SiteNames);

@DllImport("logoncli.dll")
uint DsGetDcSiteCoverageA(const(char)* ServerName, uint* EntryCount, byte*** SiteNames);

@DllImport("logoncli.dll")
uint DsDeregisterDnsHostRecordsW(const(wchar)* ServerName, const(wchar)* DnsDomainName, Guid* DomainGuid, Guid* DsaGuid, const(wchar)* DnsHostName);

@DllImport("logoncli.dll")
uint DsDeregisterDnsHostRecordsA(const(char)* ServerName, const(char)* DnsDomainName, Guid* DomainGuid, Guid* DsaGuid, const(char)* DnsHostName);

@DllImport("logoncli.dll")
uint DsGetDcOpenW(const(wchar)* DnsName, uint OptionFlags, const(wchar)* SiteName, Guid* DomainGuid, const(wchar)* DnsForestName, uint DcFlags, GetDcContextHandle* RetGetDcContext);

@DllImport("logoncli.dll")
uint DsGetDcOpenA(const(char)* DnsName, uint OptionFlags, const(char)* SiteName, Guid* DomainGuid, const(char)* DnsForestName, uint DcFlags, GetDcContextHandle* RetGetDcContext);

@DllImport("logoncli.dll")
uint DsGetDcNextW(HANDLE GetDcContextHandle, uint* SockAddressCount, SOCKET_ADDRESS** SockAddresses, ushort** DnsHostName);

@DllImport("logoncli.dll")
uint DsGetDcNextA(HANDLE GetDcContextHandle, uint* SockAddressCount, SOCKET_ADDRESS** SockAddresses, byte** DnsHostName);

@DllImport("logoncli.dll")
void DsGetDcCloseW(HANDLE GetDcContextHandle);

alias GetDcContextHandle = int;
alias BFFCALLBACK = extern(Windows) int function(HWND hwnd, uint uMsg, LPARAM lParam, LPARAM lpData);
