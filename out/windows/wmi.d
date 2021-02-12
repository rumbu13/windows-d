module windows.wmi;

public import windows.automation;
public import windows.com;
public import windows.systemservices;

extern(Windows):

const GUID CLSID_WbemDefPath = {0xCF4CC405, 0xE2C5, 0x4DDD, [0xB3, 0xCE, 0x5E, 0x75, 0x82, 0xD8, 0xC9, 0xFA]};
@GUID(0xCF4CC405, 0xE2C5, 0x4DDD, [0xB3, 0xCE, 0x5E, 0x75, 0x82, 0xD8, 0xC9, 0xFA]);
struct WbemDefPath;

const GUID CLSID_WbemQuery = {0xEAC8A024, 0x21E2, 0x4523, [0xAD, 0x73, 0xA7, 0x1A, 0x0A, 0xA2, 0xF5, 0x6A]};
@GUID(0xEAC8A024, 0x21E2, 0x4523, [0xAD, 0x73, 0xA7, 0x1A, 0x0A, 0xA2, 0xF5, 0x6A]);
struct WbemQuery;

enum tag_WBEM_PATH_STATUS_FLAG
{
    WBEMPATH_INFO_ANON_LOCAL_MACHINE = 1,
    WBEMPATH_INFO_HAS_MACHINE_NAME = 2,
    WBEMPATH_INFO_IS_CLASS_REF = 4,
    WBEMPATH_INFO_IS_INST_REF = 8,
    WBEMPATH_INFO_HAS_SUBSCOPES = 16,
    WBEMPATH_INFO_IS_COMPOUND = 32,
    WBEMPATH_INFO_HAS_V2_REF_PATHS = 64,
    WBEMPATH_INFO_HAS_IMPLIED_KEY = 128,
    WBEMPATH_INFO_CONTAINS_SINGLETON = 256,
    WBEMPATH_INFO_V1_COMPLIANT = 512,
    WBEMPATH_INFO_V2_COMPLIANT = 1024,
    WBEMPATH_INFO_CIM_COMPLIANT = 2048,
    WBEMPATH_INFO_IS_SINGLETON = 4096,
    WBEMPATH_INFO_IS_PARENT = 8192,
    WBEMPATH_INFO_SERVER_NAMESPACE_ONLY = 16384,
    WBEMPATH_INFO_NATIVE_PATH = 32768,
    WBEMPATH_INFO_WMI_PATH = 65536,
    WBEMPATH_INFO_PATH_HAD_SERVER = 131072,
}

enum tag_WBEM_PATH_CREATE_FLAG
{
    WBEMPATH_CREATE_ACCEPT_RELATIVE = 1,
    WBEMPATH_CREATE_ACCEPT_ABSOLUTE = 2,
    WBEMPATH_CREATE_ACCEPT_ALL = 4,
    WBEMPATH_TREAT_SINGLE_IDENT_AS_NS = 8,
}

enum tag_WBEM_GET_TEXT_FLAGS
{
    WBEMPATH_COMPRESSED = 1,
    WBEMPATH_GET_RELATIVE_ONLY = 2,
    WBEMPATH_GET_SERVER_TOO = 4,
    WBEMPATH_GET_SERVER_AND_NAMESPACE_ONLY = 8,
    WBEMPATH_GET_NAMESPACE_ONLY = 16,
    WBEMPATH_GET_ORIGINAL = 32,
}

enum tag_WBEM_GET_KEY_FLAGS
{
    WBEMPATH_TEXT = 1,
    WBEMPATH_QUOTEDTEXT = 2,
}

const GUID IID_IWbemPathKeyList = {0x9AE62877, 0x7544, 0x4BB0, [0xAA, 0x26, 0xA1, 0x38, 0x24, 0x65, 0x9E, 0xD6]};
@GUID(0x9AE62877, 0x7544, 0x4BB0, [0xAA, 0x26, 0xA1, 0x38, 0x24, 0x65, 0x9E, 0xD6]);
interface IWbemPathKeyList : IUnknown
{
    HRESULT GetCount(uint* puKeyCount);
    HRESULT SetKey(const(wchar)* wszName, uint uFlags, uint uCimType, void* pKeyVal);
    HRESULT SetKey2(const(wchar)* wszName, uint uFlags, uint uCimType, VARIANT* pKeyVal);
    HRESULT GetKey(uint uKeyIx, uint uFlags, uint* puNameBufSize, const(wchar)* pszKeyName, uint* puKeyValBufSize, void* pKeyVal, uint* puApparentCimType);
    HRESULT GetKey2(uint uKeyIx, uint uFlags, uint* puNameBufSize, const(wchar)* pszKeyName, VARIANT* pKeyValue, uint* puApparentCimType);
    HRESULT RemoveKey(const(wchar)* wszName, uint uFlags);
    HRESULT RemoveAllKeys(uint uFlags);
    HRESULT MakeSingleton(ubyte bSet);
    HRESULT GetInfo(uint uRequestedInfo, ulong* puResponse);
    HRESULT GetText(int lFlags, uint* puBuffLength, const(wchar)* pszText);
}

const GUID IID_IWbemPath = {0x3BC15AF2, 0x736C, 0x477E, [0x9E, 0x51, 0x23, 0x8A, 0xF8, 0x66, 0x7D, 0xCC]};
@GUID(0x3BC15AF2, 0x736C, 0x477E, [0x9E, 0x51, 0x23, 0x8A, 0xF8, 0x66, 0x7D, 0xCC]);
interface IWbemPath : IUnknown
{
    HRESULT SetText(uint uMode, const(wchar)* pszPath);
    HRESULT GetText(int lFlags, uint* puBuffLength, const(wchar)* pszText);
    HRESULT GetInfo(uint uRequestedInfo, ulong* puResponse);
    HRESULT SetServer(const(wchar)* Name);
    HRESULT GetServer(uint* puNameBufLength, const(wchar)* pName);
    HRESULT GetNamespaceCount(uint* puCount);
    HRESULT SetNamespaceAt(uint uIndex, const(wchar)* pszName);
    HRESULT GetNamespaceAt(uint uIndex, uint* puNameBufLength, const(wchar)* pName);
    HRESULT RemoveNamespaceAt(uint uIndex);
    HRESULT RemoveAllNamespaces();
    HRESULT GetScopeCount(uint* puCount);
    HRESULT SetScope(uint uIndex, const(wchar)* pszClass);
    HRESULT SetScopeFromText(uint uIndex, const(wchar)* pszText);
    HRESULT GetScope(uint uIndex, uint* puClassNameBufSize, const(wchar)* pszClass, IWbemPathKeyList* pKeyList);
    HRESULT GetScopeAsText(uint uIndex, uint* puTextBufSize, const(wchar)* pszText);
    HRESULT RemoveScope(uint uIndex);
    HRESULT RemoveAllScopes();
    HRESULT SetClassName(const(wchar)* Name);
    HRESULT GetClassNameA(uint* puBuffLength, const(wchar)* pszName);
    HRESULT GetKeyList(IWbemPathKeyList* pOut);
    HRESULT CreateClassPart(int lFlags, const(wchar)* Name);
    HRESULT DeleteClassPart(int lFlags);
    BOOL IsRelative(const(wchar)* wszMachine, const(wchar)* wszNamespace);
    BOOL IsRelativeOrChild(const(wchar)* wszMachine, const(wchar)* wszNamespace, int lFlags);
    BOOL IsLocal(const(wchar)* wszMachine);
    BOOL IsSameClassName(const(wchar)* wszClass);
}

const GUID IID_IWbemQuery = {0x81166F58, 0xDD98, 0x11D3, [0xA1, 0x20, 0x00, 0x10, 0x5A, 0x1F, 0x51, 0x5A]};
@GUID(0x81166F58, 0xDD98, 0x11D3, [0xA1, 0x20, 0x00, 0x10, 0x5A, 0x1F, 0x51, 0x5A]);
interface IWbemQuery : IUnknown
{
    HRESULT Empty();
    HRESULT SetLanguageFeatures(uint uFlags, uint uArraySize, uint* puFeatures);
    HRESULT TestLanguageFeatures(uint uFlags, uint* uArraySize, uint* puFeatures);
    HRESULT Parse(const(wchar)* pszLang, const(wchar)* pszQuery, uint uFlags);
    HRESULT GetAnalysis(uint uAnalysisType, uint uFlags, void** pAnalysis);
    HRESULT FreeMemory(void* pMem);
    HRESULT GetQueryInfo(uint uAnalysisType, uint uInfoId, uint uBufSize, void* pDestBuf);
}

enum WMIQ_ANALYSIS_TYPE
{
    WMIQ_ANALYSIS_RPN_SEQUENCE = 1,
    WMIQ_ANALYSIS_ASSOC_QUERY = 2,
    WMIQ_ANALYSIS_PROP_ANALYSIS_MATRIX = 3,
    WMIQ_ANALYSIS_QUERY_TEXT = 4,
    WMIQ_ANALYSIS_RESERVED = 134217728,
}

enum WMIQ_RPN_TOKEN_FLAGS
{
    WMIQ_RPN_TOKEN_EXPRESSION = 1,
    WMIQ_RPN_TOKEN_AND = 2,
    WMIQ_RPN_TOKEN_OR = 3,
    WMIQ_RPN_TOKEN_NOT = 4,
    WMIQ_RPN_OP_UNDEFINED = 0,
    WMIQ_RPN_OP_EQ = 1,
    WMIQ_RPN_OP_NE = 2,
    WMIQ_RPN_OP_GE = 3,
    WMIQ_RPN_OP_LE = 4,
    WMIQ_RPN_OP_LT = 5,
    WMIQ_RPN_OP_GT = 6,
    WMIQ_RPN_OP_LIKE = 7,
    WMIQ_RPN_OP_ISA = 8,
    WMIQ_RPN_OP_ISNOTA = 9,
    WMIQ_RPN_OP_ISNULL = 10,
    WMIQ_RPN_OP_ISNOTNULL = 11,
    WMIQ_RPN_LEFT_PROPERTY_NAME = 1,
    WMIQ_RPN_RIGHT_PROPERTY_NAME = 2,
    WMIQ_RPN_CONST2 = 4,
    WMIQ_RPN_CONST = 8,
    WMIQ_RPN_RELOP = 16,
    WMIQ_RPN_LEFT_FUNCTION = 32,
    WMIQ_RPN_RIGHT_FUNCTION = 64,
    WMIQ_RPN_GET_TOKEN_TYPE = 1,
    WMIQ_RPN_GET_EXPR_SHAPE = 2,
    WMIQ_RPN_GET_LEFT_FUNCTION = 3,
    WMIQ_RPN_GET_RIGHT_FUNCTION = 4,
    WMIQ_RPN_GET_RELOP = 5,
    WMIQ_RPN_NEXT_TOKEN = 1,
    WMIQ_RPN_FROM_UNARY = 1,
    WMIQ_RPN_FROM_PATH = 2,
    WMIQ_RPN_FROM_CLASS_LIST = 4,
    WMIQ_RPN_FROM_MULTIPLE = 8,
}

enum WMIQ_ASSOCQ_FLAGS
{
    WMIQ_ASSOCQ_ASSOCIATORS = 1,
    WMIQ_ASSOCQ_REFERENCES = 2,
    WMIQ_ASSOCQ_RESULTCLASS = 4,
    WMIQ_ASSOCQ_ASSOCCLASS = 8,
    WMIQ_ASSOCQ_ROLE = 16,
    WMIQ_ASSOCQ_RESULTROLE = 32,
    WMIQ_ASSOCQ_REQUIREDQUALIFIER = 64,
    WMIQ_ASSOCQ_REQUIREDASSOCQUALIFIER = 128,
    WMIQ_ASSOCQ_CLASSDEFSONLY = 256,
    WMIQ_ASSOCQ_KEYSONLY = 512,
    WMIQ_ASSOCQ_SCHEMAONLY = 1024,
    WMIQ_ASSOCQ_CLASSREFSONLY = 2048,
}

struct SWbemQueryQualifiedName
{
    uint m_uVersion;
    uint m_uTokenType;
    uint m_uNameListSize;
    ushort** m_ppszNameList;
    BOOL m_bArraysUsed;
    int* m_pbArrayElUsed;
    uint* m_puArrayIndex;
}

struct tag_SWbemRpnConst
{
    const(wchar)* m_pszStrVal;
    BOOL m_bBoolVal;
    int m_lLongVal;
    uint m_uLongVal;
    double m_dblVal;
    long m_lVal64;
    long m_uVal64;
}

struct SWbemRpnQueryToken
{
    uint m_uVersion;
    uint m_uTokenType;
    uint m_uSubexpressionShape;
    uint m_uOperator;
    SWbemQueryQualifiedName* m_pRightIdent;
    SWbemQueryQualifiedName* m_pLeftIdent;
    uint m_uConstApparentType;
    tag_SWbemRpnConst m_Const;
    uint m_uConst2ApparentType;
    tag_SWbemRpnConst m_Const2;
    const(wchar)* m_pszRightFunc;
    const(wchar)* m_pszLeftFunc;
}

struct tag_SWbemRpnTokenList
{
    uint m_uVersion;
    uint m_uTokenType;
    uint m_uNumTokens;
}

enum tag_WMIQ_LANGUAGE_FEATURES
{
    WMIQ_LF1_BASIC_SELECT = 1,
    WMIQ_LF2_CLASS_NAME_IN_QUERY = 2,
    WMIQ_LF3_STRING_CASE_FUNCTIONS = 3,
    WMIQ_LF4_PROP_TO_PROP_TESTS = 4,
    WMIQ_LF5_COUNT_STAR = 5,
    WMIQ_LF6_ORDER_BY = 6,
    WMIQ_LF7_DISTINCT = 7,
    WMIQ_LF8_ISA = 8,
    WMIQ_LF9_THIS = 9,
    WMIQ_LF10_COMPEX_SUBEXPRESSIONS = 10,
    WMIQ_LF11_ALIASING = 11,
    WMIQ_LF12_GROUP_BY_HAVING = 12,
    WMIQ_LF13_WMI_WITHIN = 13,
    WMIQ_LF14_SQL_WRITE_OPERATIONS = 14,
    WMIQ_LF15_GO = 15,
    WMIQ_LF16_SINGLE_LEVEL_TRANSACTIONS = 16,
    WMIQ_LF17_QUALIFIED_NAMES = 17,
    WMIQ_LF18_ASSOCIATONS = 18,
    WMIQ_LF19_SYSTEM_PROPERTIES = 19,
    WMIQ_LF20_EXTENDED_SYSTEM_PROPERTIES = 20,
    WMIQ_LF21_SQL89_JOINS = 21,
    WMIQ_LF22_SQL92_JOINS = 22,
    WMIQ_LF23_SUBSELECTS = 23,
    WMIQ_LF24_UMI_EXTENSIONS = 24,
    WMIQ_LF25_DATEPART = 25,
    WMIQ_LF26_LIKE = 26,
    WMIQ_LF27_CIM_TEMPORAL_CONSTRUCTS = 27,
    WMIQ_LF28_STANDARD_AGGREGATES = 28,
    WMIQ_LF29_MULTI_LEVEL_ORDER_BY = 29,
    WMIQ_LF30_WMI_PRAGMAS = 30,
    WMIQ_LF31_QUALIFIER_TESTS = 31,
    WMIQ_LF32_SP_EXECUTE = 32,
    WMIQ_LF33_ARRAY_ACCESS = 33,
    WMIQ_LF34_UNION = 34,
    WMIQ_LF35_COMPLEX_SELECT_TARGET = 35,
    WMIQ_LF36_REFERENCE_TESTS = 36,
    WMIQ_LF37_SELECT_INTO = 37,
    WMIQ_LF38_BASIC_DATETIME_TESTS = 38,
    WMIQ_LF39_COUNT_COLUMN = 39,
    WMIQ_LF40_BETWEEN = 40,
    WMIQ_LF_LAST = 40,
}

enum tag_WMIQ_RPNQ_FEATURE
{
    WMIQ_RPNF_WHERE_CLAUSE_PRESENT = 1,
    WMIQ_RPNF_QUERY_IS_CONJUNCTIVE = 2,
    WMIQ_RPNF_QUERY_IS_DISJUNCTIVE = 4,
    WMIQ_RPNF_PROJECTION = 8,
    WMIQ_RPNF_FEATURE_SELECT_STAR = 16,
    WMIQ_RPNF_EQUALITY_TESTS_ONLY = 32,
    WMIQ_RPNF_COUNT_STAR = 64,
    WMIQ_RPNF_QUALIFIED_NAMES_USED = 128,
    WMIQ_RPNF_SYSPROP_CLASS_USED = 256,
    WMIQ_RPNF_PROP_TO_PROP_TESTS = 512,
    WMIQ_RPNF_ORDER_BY = 1024,
    WMIQ_RPNF_ISA_USED = 2048,
    WMIQ_RPNF_GROUP_BY_HAVING = 4096,
    WMIQ_RPNF_ARRAY_ACCESS_USED = 8192,
}

struct SWbemRpnEncodedQuery
{
    uint m_uVersion;
    uint m_uTokenType;
    ulong m_uParsedFeatureMask;
    uint m_uDetectedArraySize;
    uint* m_puDetectedFeatures;
    uint m_uSelectListSize;
    SWbemQueryQualifiedName** m_ppSelectList;
    uint m_uFromTargetType;
    const(wchar)* m_pszOptionalFromPath;
    uint m_uFromListSize;
    ushort** m_ppszFromList;
    uint m_uWhereClauseSize;
    SWbemRpnQueryToken** m_ppRpnWhereClause;
    double m_dblWithinPolling;
    double m_dblWithinWindow;
    uint m_uOrderByListSize;
    ushort** m_ppszOrderByList;
    uint* m_uOrderDirectionEl;
}

struct tag_SWbemAnalysisMatrix
{
    uint m_uVersion;
    uint m_uMatrixType;
    const(wchar)* m_pszProperty;
    uint m_uPropertyType;
    uint m_uEntries;
    void** m_pValues;
    int* m_pbTruthTable;
}

struct tag_SWbemAnalysisMatrixList
{
    uint m_uVersion;
    uint m_uMatrixType;
    uint m_uNumMatrices;
    tag_SWbemAnalysisMatrix* m_pMatrices;
}

struct SWbemAssocQueryInf
{
    uint m_uVersion;
    uint m_uAnalysisType;
    uint m_uFeatureMask;
    IWbemPath m_pPath;
    const(wchar)* m_pszPath;
    const(wchar)* m_pszQueryText;
    const(wchar)* m_pszResultClass;
    const(wchar)* m_pszAssocClass;
    const(wchar)* m_pszRole;
    const(wchar)* m_pszResultRole;
    const(wchar)* m_pszRequiredQualifier;
    const(wchar)* m_pszRequiredAssocQualifier;
}

const GUID CLSID_WbemLocator = {0x4590F811, 0x1D3A, 0x11D0, [0x89, 0x1F, 0x00, 0xAA, 0x00, 0x4B, 0x2E, 0x24]};
@GUID(0x4590F811, 0x1D3A, 0x11D0, [0x89, 0x1F, 0x00, 0xAA, 0x00, 0x4B, 0x2E, 0x24]);
struct WbemLocator;

const GUID CLSID_WbemContext = {0x674B6698, 0xEE92, 0x11D0, [0xAD, 0x71, 0x00, 0xC0, 0x4F, 0xD8, 0xFD, 0xFF]};
@GUID(0x674B6698, 0xEE92, 0x11D0, [0xAD, 0x71, 0x00, 0xC0, 0x4F, 0xD8, 0xFD, 0xFF]);
struct WbemContext;

const GUID CLSID_UnsecuredApartment = {0x49BD2028, 0x1523, 0x11D1, [0xAD, 0x79, 0x00, 0xC0, 0x4F, 0xD8, 0xFD, 0xFF]};
@GUID(0x49BD2028, 0x1523, 0x11D1, [0xAD, 0x79, 0x00, 0xC0, 0x4F, 0xD8, 0xFD, 0xFF]);
struct UnsecuredApartment;

const GUID CLSID_WbemClassObject = {0x9A653086, 0x174F, 0x11D2, [0xB5, 0xF9, 0x00, 0x10, 0x4B, 0x70, 0x3E, 0xFD]};
@GUID(0x9A653086, 0x174F, 0x11D2, [0xB5, 0xF9, 0x00, 0x10, 0x4B, 0x70, 0x3E, 0xFD]);
struct WbemClassObject;

const GUID CLSID_MofCompiler = {0x6DAF9757, 0x2E37, 0x11D2, [0xAE, 0xC9, 0x00, 0xC0, 0x4F, 0xB6, 0x88, 0x20]};
@GUID(0x6DAF9757, 0x2E37, 0x11D2, [0xAE, 0xC9, 0x00, 0xC0, 0x4F, 0xB6, 0x88, 0x20]);
struct MofCompiler;

const GUID CLSID_WbemStatusCodeText = {0xEB87E1BD, 0x3233, 0x11D2, [0xAE, 0xC9, 0x00, 0xC0, 0x4F, 0xB6, 0x88, 0x20]};
@GUID(0xEB87E1BD, 0x3233, 0x11D2, [0xAE, 0xC9, 0x00, 0xC0, 0x4F, 0xB6, 0x88, 0x20]);
struct WbemStatusCodeText;

const GUID CLSID_WbemBackupRestore = {0xC49E32C6, 0xBC8B, 0x11D2, [0x85, 0xD4, 0x00, 0x10, 0x5A, 0x1F, 0x83, 0x04]};
@GUID(0xC49E32C6, 0xBC8B, 0x11D2, [0x85, 0xD4, 0x00, 0x10, 0x5A, 0x1F, 0x83, 0x04]);
struct WbemBackupRestore;

const GUID CLSID_WbemRefresher = {0xC71566F2, 0x561E, 0x11D1, [0xAD, 0x87, 0x00, 0xC0, 0x4F, 0xD8, 0xFD, 0xFF]};
@GUID(0xC71566F2, 0x561E, 0x11D1, [0xAD, 0x87, 0x00, 0xC0, 0x4F, 0xD8, 0xFD, 0xFF]);
struct WbemRefresher;

const GUID CLSID_WbemObjectTextSrc = {0x8D1C559D, 0x84F0, 0x4BB3, [0xA7, 0xD5, 0x56, 0xA7, 0x43, 0x5A, 0x9B, 0xA6]};
@GUID(0x8D1C559D, 0x84F0, 0x4BB3, [0xA7, 0xD5, 0x56, 0xA7, 0x43, 0x5A, 0x9B, 0xA6]);
struct WbemObjectTextSrc;

enum WBEM_GENUS_TYPE
{
    WBEM_GENUS_CLASS = 1,
    WBEM_GENUS_INSTANCE = 2,
}

enum WBEM_CHANGE_FLAG_TYPE
{
    WBEM_FLAG_CREATE_OR_UPDATE = 0,
    WBEM_FLAG_UPDATE_ONLY = 1,
    WBEM_FLAG_CREATE_ONLY = 2,
    WBEM_FLAG_UPDATE_COMPATIBLE = 0,
    WBEM_FLAG_UPDATE_SAFE_MODE = 32,
    WBEM_FLAG_UPDATE_FORCE_MODE = 64,
    WBEM_MASK_UPDATE_MODE = 96,
    WBEM_FLAG_ADVISORY = 65536,
}

enum WBEM_GENERIC_FLAG_TYPE
{
    WBEM_FLAG_RETURN_IMMEDIATELY = 16,
    WBEM_FLAG_RETURN_WBEM_COMPLETE = 0,
    WBEM_FLAG_BIDIRECTIONAL = 0,
    WBEM_FLAG_FORWARD_ONLY = 32,
    WBEM_FLAG_NO_ERROR_OBJECT = 64,
    WBEM_FLAG_RETURN_ERROR_OBJECT = 0,
    WBEM_FLAG_SEND_STATUS = 128,
    WBEM_FLAG_DONT_SEND_STATUS = 0,
    WBEM_FLAG_ENSURE_LOCATABLE = 256,
    WBEM_FLAG_DIRECT_READ = 512,
    WBEM_FLAG_SEND_ONLY_SELECTED = 0,
    WBEM_RETURN_WHEN_COMPLETE = 0,
    WBEM_RETURN_IMMEDIATELY = 16,
    WBEM_MASK_RESERVED_FLAGS = 126976,
    WBEM_FLAG_USE_AMENDED_QUALIFIERS = 131072,
    WBEM_FLAG_STRONG_VALIDATION = 1048576,
}

enum WBEM_STATUS_TYPE
{
    WBEM_STATUS_COMPLETE = 0,
    WBEM_STATUS_REQUIREMENTS = 1,
    WBEM_STATUS_PROGRESS = 2,
    WBEM_STATUS_LOGGING_INFORMATION = 256,
    WBEM_STATUS_LOGGING_INFORMATION_PROVIDER = 512,
    WBEM_STATUS_LOGGING_INFORMATION_HOST = 1024,
    WBEM_STATUS_LOGGING_INFORMATION_REPOSITORY = 2048,
    WBEM_STATUS_LOGGING_INFORMATION_ESS = 4096,
}

enum WBEM_TIMEOUT_TYPE
{
    WBEM_NO_WAIT = 0,
    WBEM_INFINITE = -1,
}

enum WBEM_CONDITION_FLAG_TYPE
{
    WBEM_FLAG_ALWAYS = 0,
    WBEM_FLAG_ONLY_IF_TRUE = 1,
    WBEM_FLAG_ONLY_IF_FALSE = 2,
    WBEM_FLAG_ONLY_IF_IDENTICAL = 3,
    WBEM_MASK_PRIMARY_CONDITION = 3,
    WBEM_FLAG_KEYS_ONLY = 4,
    WBEM_FLAG_REFS_ONLY = 8,
    WBEM_FLAG_LOCAL_ONLY = 16,
    WBEM_FLAG_PROPAGATED_ONLY = 32,
    WBEM_FLAG_SYSTEM_ONLY = 48,
    WBEM_FLAG_NONSYSTEM_ONLY = 64,
    WBEM_MASK_CONDITION_ORIGIN = 112,
    WBEM_FLAG_CLASS_OVERRIDES_ONLY = 256,
    WBEM_FLAG_CLASS_LOCAL_AND_OVERRIDES = 512,
    WBEM_MASK_CLASS_CONDITION = 768,
}

enum WBEM_FLAVOR_TYPE
{
    WBEM_FLAVOR_DONT_PROPAGATE = 0,
    WBEM_FLAVOR_FLAG_PROPAGATE_TO_INSTANCE = 1,
    WBEM_FLAVOR_FLAG_PROPAGATE_TO_DERIVED_CLASS = 2,
    WBEM_FLAVOR_MASK_PROPAGATION = 15,
    WBEM_FLAVOR_OVERRIDABLE = 0,
    WBEM_FLAVOR_NOT_OVERRIDABLE = 16,
    WBEM_FLAVOR_MASK_PERMISSIONS = 16,
    WBEM_FLAVOR_ORIGIN_LOCAL = 0,
    WBEM_FLAVOR_ORIGIN_PROPAGATED = 32,
    WBEM_FLAVOR_ORIGIN_SYSTEM = 64,
    WBEM_FLAVOR_MASK_ORIGIN = 96,
    WBEM_FLAVOR_NOT_AMENDED = 0,
    WBEM_FLAVOR_AMENDED = 128,
    WBEM_FLAVOR_MASK_AMENDED = 128,
}

enum WBEM_QUERY_FLAG_TYPE
{
    WBEM_FLAG_DEEP = 0,
    WBEM_FLAG_SHALLOW = 1,
    WBEM_FLAG_PROTOTYPE = 2,
}

enum WBEM_SECURITY_FLAGS
{
    WBEM_ENABLE = 1,
    WBEM_METHOD_EXECUTE = 2,
    WBEM_FULL_WRITE_REP = 4,
    WBEM_PARTIAL_WRITE_REP = 8,
    WBEM_WRITE_PROVIDER = 16,
    WBEM_REMOTE_ACCESS = 32,
    WBEM_RIGHT_SUBSCRIBE = 64,
    WBEM_RIGHT_PUBLISH = 128,
}

enum tag_WBEM_LIMITATION_FLAG_TYPE
{
    WBEM_FLAG_EXCLUDE_OBJECT_QUALIFIERS = 16,
    WBEM_FLAG_EXCLUDE_PROPERTY_QUALIFIERS = 32,
}

enum WBEM_TEXT_FLAG_TYPE
{
    WBEM_FLAG_NO_FLAVORS = 1,
}

enum WBEM_COMPARISON_FLAG
{
    WBEM_COMPARISON_INCLUDE_ALL = 0,
    WBEM_FLAG_IGNORE_QUALIFIERS = 1,
    WBEM_FLAG_IGNORE_OBJECT_SOURCE = 2,
    WBEM_FLAG_IGNORE_DEFAULT_VALUES = 4,
    WBEM_FLAG_IGNORE_CLASS = 8,
    WBEM_FLAG_IGNORE_CASE = 16,
    WBEM_FLAG_IGNORE_FLAVOR = 32,
}

enum tag_WBEM_LOCKING
{
    WBEM_FLAG_ALLOW_READ = 1,
}

enum CIMTYPE_ENUMERATION
{
    CIM_ILLEGAL = 4095,
    CIM_EMPTY = 0,
    CIM_SINT8 = 16,
    CIM_UINT8 = 17,
    CIM_SINT16 = 2,
    CIM_UINT16 = 18,
    CIM_SINT32 = 3,
    CIM_UINT32 = 19,
    CIM_SINT64 = 20,
    CIM_UINT64 = 21,
    CIM_REAL32 = 4,
    CIM_REAL64 = 5,
    CIM_BOOLEAN = 11,
    CIM_STRING = 8,
    CIM_DATETIME = 101,
    CIM_REFERENCE = 102,
    CIM_CHAR16 = 103,
    CIM_OBJECT = 13,
    CIM_FLAG_ARRAY = 8192,
}

enum WBEM_BACKUP_RESTORE_FLAGS
{
    WBEM_FLAG_BACKUP_RESTORE_DEFAULT = 0,
    WBEM_FLAG_BACKUP_RESTORE_FORCE_SHUTDOWN = 1,
}

enum WBEM_REFRESHER_FLAGS
{
    WBEM_FLAG_REFRESH_AUTO_RECONNECT = 0,
    WBEM_FLAG_REFRESH_NO_AUTO_RECONNECT = 1,
}

enum tag_WBEM_SHUTDOWN_FLAGS
{
    WBEM_SHUTDOWN_UNLOAD_COMPONENT = 1,
    WBEM_SHUTDOWN_WMI = 2,
    WBEM_SHUTDOWN_OS = 3,
}

enum tag_WBEMSTATUS_FORMAT
{
    WBEMSTATUS_FORMAT_NEWLINE = 0,
    WBEMSTATUS_FORMAT_NO_NEWLINE = 1,
}

enum WBEM_LIMITS
{
    WBEM_MAX_IDENTIFIER = 4096,
    WBEM_MAX_QUERY = 16384,
    WBEM_MAX_PATH = 8192,
    WBEM_MAX_OBJECT_NESTING = 64,
    WBEM_MAX_USER_PROPERTIES = 1024,
}

enum WBEMSTATUS
{
    WBEM_NO_ERROR = 0,
    WBEM_S_NO_ERROR = 0,
    WBEM_S_SAME = 0,
    WBEM_S_FALSE = 1,
    WBEM_S_ALREADY_EXISTS = 262145,
    WBEM_S_RESET_TO_DEFAULT = 262146,
    WBEM_S_DIFFERENT = 262147,
    WBEM_S_TIMEDOUT = 262148,
    WBEM_S_NO_MORE_DATA = 262149,
    WBEM_S_OPERATION_CANCELLED = 262150,
    WBEM_S_PENDING = 262151,
    WBEM_S_DUPLICATE_OBJECTS = 262152,
    WBEM_S_ACCESS_DENIED = 262153,
    WBEM_S_PARTIAL_RESULTS = 262160,
    WBEM_S_SOURCE_NOT_AVAILABLE = 262167,
    WBEM_E_FAILED = -2147217407,
    WBEM_E_NOT_FOUND = -2147217406,
    WBEM_E_ACCESS_DENIED = -2147217405,
    WBEM_E_PROVIDER_FAILURE = -2147217404,
    WBEM_E_TYPE_MISMATCH = -2147217403,
    WBEM_E_OUT_OF_MEMORY = -2147217402,
    WBEM_E_INVALID_CONTEXT = -2147217401,
    WBEM_E_INVALID_PARAMETER = -2147217400,
    WBEM_E_NOT_AVAILABLE = -2147217399,
    WBEM_E_CRITICAL_ERROR = -2147217398,
    WBEM_E_INVALID_STREAM = -2147217397,
    WBEM_E_NOT_SUPPORTED = -2147217396,
    WBEM_E_INVALID_SUPERCLASS = -2147217395,
    WBEM_E_INVALID_NAMESPACE = -2147217394,
    WBEM_E_INVALID_OBJECT = -2147217393,
    WBEM_E_INVALID_CLASS = -2147217392,
    WBEM_E_PROVIDER_NOT_FOUND = -2147217391,
    WBEM_E_INVALID_PROVIDER_REGISTRATION = -2147217390,
    WBEM_E_PROVIDER_LOAD_FAILURE = -2147217389,
    WBEM_E_INITIALIZATION_FAILURE = -2147217388,
    WBEM_E_TRANSPORT_FAILURE = -2147217387,
    WBEM_E_INVALID_OPERATION = -2147217386,
    WBEM_E_INVALID_QUERY = -2147217385,
    WBEM_E_INVALID_QUERY_TYPE = -2147217384,
    WBEM_E_ALREADY_EXISTS = -2147217383,
    WBEM_E_OVERRIDE_NOT_ALLOWED = -2147217382,
    WBEM_E_PROPAGATED_QUALIFIER = -2147217381,
    WBEM_E_PROPAGATED_PROPERTY = -2147217380,
    WBEM_E_UNEXPECTED = -2147217379,
    WBEM_E_ILLEGAL_OPERATION = -2147217378,
    WBEM_E_CANNOT_BE_KEY = -2147217377,
    WBEM_E_INCOMPLETE_CLASS = -2147217376,
    WBEM_E_INVALID_SYNTAX = -2147217375,
    WBEM_E_NONDECORATED_OBJECT = -2147217374,
    WBEM_E_READ_ONLY = -2147217373,
    WBEM_E_PROVIDER_NOT_CAPABLE = -2147217372,
    WBEM_E_CLASS_HAS_CHILDREN = -2147217371,
    WBEM_E_CLASS_HAS_INSTANCES = -2147217370,
    WBEM_E_QUERY_NOT_IMPLEMENTED = -2147217369,
    WBEM_E_ILLEGAL_NULL = -2147217368,
    WBEM_E_INVALID_QUALIFIER_TYPE = -2147217367,
    WBEM_E_INVALID_PROPERTY_TYPE = -2147217366,
    WBEM_E_VALUE_OUT_OF_RANGE = -2147217365,
    WBEM_E_CANNOT_BE_SINGLETON = -2147217364,
    WBEM_E_INVALID_CIM_TYPE = -2147217363,
    WBEM_E_INVALID_METHOD = -2147217362,
    WBEM_E_INVALID_METHOD_PARAMETERS = -2147217361,
    WBEM_E_SYSTEM_PROPERTY = -2147217360,
    WBEM_E_INVALID_PROPERTY = -2147217359,
    WBEM_E_CALL_CANCELLED = -2147217358,
    WBEM_E_SHUTTING_DOWN = -2147217357,
    WBEM_E_PROPAGATED_METHOD = -2147217356,
    WBEM_E_UNSUPPORTED_PARAMETER = -2147217355,
    WBEM_E_MISSING_PARAMETER_ID = -2147217354,
    WBEM_E_INVALID_PARAMETER_ID = -2147217353,
    WBEM_E_NONCONSECUTIVE_PARAMETER_IDS = -2147217352,
    WBEM_E_PARAMETER_ID_ON_RETVAL = -2147217351,
    WBEM_E_INVALID_OBJECT_PATH = -2147217350,
    WBEM_E_OUT_OF_DISK_SPACE = -2147217349,
    WBEM_E_BUFFER_TOO_SMALL = -2147217348,
    WBEM_E_UNSUPPORTED_PUT_EXTENSION = -2147217347,
    WBEM_E_UNKNOWN_OBJECT_TYPE = -2147217346,
    WBEM_E_UNKNOWN_PACKET_TYPE = -2147217345,
    WBEM_E_MARSHAL_VERSION_MISMATCH = -2147217344,
    WBEM_E_MARSHAL_INVALID_SIGNATURE = -2147217343,
    WBEM_E_INVALID_QUALIFIER = -2147217342,
    WBEM_E_INVALID_DUPLICATE_PARAMETER = -2147217341,
    WBEM_E_TOO_MUCH_DATA = -2147217340,
    WBEM_E_SERVER_TOO_BUSY = -2147217339,
    WBEM_E_INVALID_FLAVOR = -2147217338,
    WBEM_E_CIRCULAR_REFERENCE = -2147217337,
    WBEM_E_UNSUPPORTED_CLASS_UPDATE = -2147217336,
    WBEM_E_CANNOT_CHANGE_KEY_INHERITANCE = -2147217335,
    WBEM_E_CANNOT_CHANGE_INDEX_INHERITANCE = -2147217328,
    WBEM_E_TOO_MANY_PROPERTIES = -2147217327,
    WBEM_E_UPDATE_TYPE_MISMATCH = -2147217326,
    WBEM_E_UPDATE_OVERRIDE_NOT_ALLOWED = -2147217325,
    WBEM_E_UPDATE_PROPAGATED_METHOD = -2147217324,
    WBEM_E_METHOD_NOT_IMPLEMENTED = -2147217323,
    WBEM_E_METHOD_DISABLED = -2147217322,
    WBEM_E_REFRESHER_BUSY = -2147217321,
    WBEM_E_UNPARSABLE_QUERY = -2147217320,
    WBEM_E_NOT_EVENT_CLASS = -2147217319,
    WBEM_E_MISSING_GROUP_WITHIN = -2147217318,
    WBEM_E_MISSING_AGGREGATION_LIST = -2147217317,
    WBEM_E_PROPERTY_NOT_AN_OBJECT = -2147217316,
    WBEM_E_AGGREGATING_BY_OBJECT = -2147217315,
    WBEM_E_UNINTERPRETABLE_PROVIDER_QUERY = -2147217313,
    WBEM_E_BACKUP_RESTORE_WINMGMT_RUNNING = -2147217312,
    WBEM_E_QUEUE_OVERFLOW = -2147217311,
    WBEM_E_PRIVILEGE_NOT_HELD = -2147217310,
    WBEM_E_INVALID_OPERATOR = -2147217309,
    WBEM_E_LOCAL_CREDENTIALS = -2147217308,
    WBEM_E_CANNOT_BE_ABSTRACT = -2147217307,
    WBEM_E_AMENDED_OBJECT = -2147217306,
    WBEM_E_CLIENT_TOO_SLOW = -2147217305,
    WBEM_E_NULL_SECURITY_DESCRIPTOR = -2147217304,
    WBEM_E_TIMED_OUT = -2147217303,
    WBEM_E_INVALID_ASSOCIATION = -2147217302,
    WBEM_E_AMBIGUOUS_OPERATION = -2147217301,
    WBEM_E_QUOTA_VIOLATION = -2147217300,
    WBEM_E_RESERVED_001 = -2147217299,
    WBEM_E_RESERVED_002 = -2147217298,
    WBEM_E_UNSUPPORTED_LOCALE = -2147217297,
    WBEM_E_HANDLE_OUT_OF_DATE = -2147217296,
    WBEM_E_CONNECTION_FAILED = -2147217295,
    WBEM_E_INVALID_HANDLE_REQUEST = -2147217294,
    WBEM_E_PROPERTY_NAME_TOO_WIDE = -2147217293,
    WBEM_E_CLASS_NAME_TOO_WIDE = -2147217292,
    WBEM_E_METHOD_NAME_TOO_WIDE = -2147217291,
    WBEM_E_QUALIFIER_NAME_TOO_WIDE = -2147217290,
    WBEM_E_RERUN_COMMAND = -2147217289,
    WBEM_E_DATABASE_VER_MISMATCH = -2147217288,
    WBEM_E_VETO_DELETE = -2147217287,
    WBEM_E_VETO_PUT = -2147217286,
    WBEM_E_INVALID_LOCALE = -2147217280,
    WBEM_E_PROVIDER_SUSPENDED = -2147217279,
    WBEM_E_SYNCHRONIZATION_REQUIRED = -2147217278,
    WBEM_E_NO_SCHEMA = -2147217277,
    WBEM_E_PROVIDER_ALREADY_REGISTERED = -2147217276,
    WBEM_E_PROVIDER_NOT_REGISTERED = -2147217275,
    WBEM_E_FATAL_TRANSPORT_ERROR = -2147217274,
    WBEM_E_ENCRYPTED_CONNECTION_REQUIRED = -2147217273,
    WBEM_E_PROVIDER_TIMED_OUT = -2147217272,
    WBEM_E_NO_KEY = -2147217271,
    WBEM_E_PROVIDER_DISABLED = -2147217270,
    WBEMESS_E_REGISTRATION_TOO_BROAD = -2147213311,
    WBEMESS_E_REGISTRATION_TOO_PRECISE = -2147213310,
    WBEMESS_E_AUTHZ_NOT_PRIVILEGED = -2147213309,
    WBEMMOF_E_EXPECTED_QUALIFIER_NAME = -2147205119,
    WBEMMOF_E_EXPECTED_SEMI = -2147205118,
    WBEMMOF_E_EXPECTED_OPEN_BRACE = -2147205117,
    WBEMMOF_E_EXPECTED_CLOSE_BRACE = -2147205116,
    WBEMMOF_E_EXPECTED_CLOSE_BRACKET = -2147205115,
    WBEMMOF_E_EXPECTED_CLOSE_PAREN = -2147205114,
    WBEMMOF_E_ILLEGAL_CONSTANT_VALUE = -2147205113,
    WBEMMOF_E_EXPECTED_TYPE_IDENTIFIER = -2147205112,
    WBEMMOF_E_EXPECTED_OPEN_PAREN = -2147205111,
    WBEMMOF_E_UNRECOGNIZED_TOKEN = -2147205110,
    WBEMMOF_E_UNRECOGNIZED_TYPE = -2147205109,
    WBEMMOF_E_EXPECTED_PROPERTY_NAME = -2147205108,
    WBEMMOF_E_TYPEDEF_NOT_SUPPORTED = -2147205107,
    WBEMMOF_E_UNEXPECTED_ALIAS = -2147205106,
    WBEMMOF_E_UNEXPECTED_ARRAY_INIT = -2147205105,
    WBEMMOF_E_INVALID_AMENDMENT_SYNTAX = -2147205104,
    WBEMMOF_E_INVALID_DUPLICATE_AMENDMENT = -2147205103,
    WBEMMOF_E_INVALID_PRAGMA = -2147205102,
    WBEMMOF_E_INVALID_NAMESPACE_SYNTAX = -2147205101,
    WBEMMOF_E_EXPECTED_CLASS_NAME = -2147205100,
    WBEMMOF_E_TYPE_MISMATCH = -2147205099,
    WBEMMOF_E_EXPECTED_ALIAS_NAME = -2147205098,
    WBEMMOF_E_INVALID_CLASS_DECLARATION = -2147205097,
    WBEMMOF_E_INVALID_INSTANCE_DECLARATION = -2147205096,
    WBEMMOF_E_EXPECTED_DOLLAR = -2147205095,
    WBEMMOF_E_CIMTYPE_QUALIFIER = -2147205094,
    WBEMMOF_E_DUPLICATE_PROPERTY = -2147205093,
    WBEMMOF_E_INVALID_NAMESPACE_SPECIFICATION = -2147205092,
    WBEMMOF_E_OUT_OF_RANGE = -2147205091,
    WBEMMOF_E_INVALID_FILE = -2147205090,
    WBEMMOF_E_ALIASES_IN_EMBEDDED = -2147205089,
    WBEMMOF_E_NULL_ARRAY_ELEM = -2147205088,
    WBEMMOF_E_DUPLICATE_QUALIFIER = -2147205087,
    WBEMMOF_E_EXPECTED_FLAVOR_TYPE = -2147205086,
    WBEMMOF_E_INCOMPATIBLE_FLAVOR_TYPES = -2147205085,
    WBEMMOF_E_MULTIPLE_ALIASES = -2147205084,
    WBEMMOF_E_INCOMPATIBLE_FLAVOR_TYPES2 = -2147205083,
    WBEMMOF_E_NO_ARRAYS_RETURNED = -2147205082,
    WBEMMOF_E_MUST_BE_IN_OR_OUT = -2147205081,
    WBEMMOF_E_INVALID_FLAGS_SYNTAX = -2147205080,
    WBEMMOF_E_EXPECTED_BRACE_OR_BAD_TYPE = -2147205079,
    WBEMMOF_E_UNSUPPORTED_CIMV22_QUAL_VALUE = -2147205078,
    WBEMMOF_E_UNSUPPORTED_CIMV22_DATA_TYPE = -2147205077,
    WBEMMOF_E_INVALID_DELETEINSTANCE_SYNTAX = -2147205076,
    WBEMMOF_E_INVALID_QUALIFIER_SYNTAX = -2147205075,
    WBEMMOF_E_QUALIFIER_USED_OUTSIDE_SCOPE = -2147205074,
    WBEMMOF_E_ERROR_CREATING_TEMP_FILE = -2147205073,
    WBEMMOF_E_ERROR_INVALID_INCLUDE_FILE = -2147205072,
    WBEMMOF_E_INVALID_DELETECLASS_SYNTAX = -2147205071,
}

const GUID IID_IWbemClassObject = {0xDC12A681, 0x737F, 0x11CF, [0x88, 0x4D, 0x00, 0xAA, 0x00, 0x4B, 0x2E, 0x24]};
@GUID(0xDC12A681, 0x737F, 0x11CF, [0x88, 0x4D, 0x00, 0xAA, 0x00, 0x4B, 0x2E, 0x24]);
interface IWbemClassObject : IUnknown
{
    HRESULT GetQualifierSet(IWbemQualifierSet* ppQualSet);
    HRESULT Get(const(wchar)* wszName, int lFlags, VARIANT* pVal, int* pType, int* plFlavor);
    HRESULT Put(const(wchar)* wszName, int lFlags, VARIANT* pVal, int Type);
    HRESULT Delete(const(wchar)* wszName);
    HRESULT GetNames(const(wchar)* wszQualifierName, int lFlags, VARIANT* pQualifierVal, SAFEARRAY** pNames);
    HRESULT BeginEnumeration(int lEnumFlags);
    HRESULT Next(int lFlags, BSTR* strName, VARIANT* pVal, int* pType, int* plFlavor);
    HRESULT EndEnumeration();
    HRESULT GetPropertyQualifierSet(const(wchar)* wszProperty, IWbemQualifierSet* ppQualSet);
    HRESULT Clone(IWbemClassObject* ppCopy);
    HRESULT GetObjectText(int lFlags, BSTR* pstrObjectText);
    HRESULT SpawnDerivedClass(int lFlags, IWbemClassObject* ppNewClass);
    HRESULT SpawnInstance(int lFlags, IWbemClassObject* ppNewInstance);
    HRESULT CompareTo(int lFlags, IWbemClassObject pCompareTo);
    HRESULT GetPropertyOrigin(const(wchar)* wszName, BSTR* pstrClassName);
    HRESULT InheritsFrom(const(wchar)* strAncestor);
    HRESULT GetMethod(const(wchar)* wszName, int lFlags, IWbemClassObject* ppInSignature, IWbemClassObject* ppOutSignature);
    HRESULT PutMethod(const(wchar)* wszName, int lFlags, IWbemClassObject pInSignature, IWbemClassObject pOutSignature);
    HRESULT DeleteMethod(const(wchar)* wszName);
    HRESULT BeginMethodEnumeration(int lEnumFlags);
    HRESULT NextMethod(int lFlags, BSTR* pstrName, IWbemClassObject* ppInSignature, IWbemClassObject* ppOutSignature);
    HRESULT EndMethodEnumeration();
    HRESULT GetMethodQualifierSet(const(wchar)* wszMethod, IWbemQualifierSet* ppQualSet);
    HRESULT GetMethodOrigin(const(wchar)* wszMethodName, BSTR* pstrClassName);
}

const GUID IID_IWbemObjectAccess = {0x49353C9A, 0x516B, 0x11D1, [0xAE, 0xA6, 0x00, 0xC0, 0x4F, 0xB6, 0x88, 0x20]};
@GUID(0x49353C9A, 0x516B, 0x11D1, [0xAE, 0xA6, 0x00, 0xC0, 0x4F, 0xB6, 0x88, 0x20]);
interface IWbemObjectAccess : IWbemClassObject
{
    HRESULT GetPropertyHandle(const(wchar)* wszPropertyName, int* pType, int* plHandle);
    HRESULT WritePropertyValue(int lHandle, int lNumBytes, const(ubyte)* aData);
    HRESULT ReadPropertyValue(int lHandle, int lBufferSize, int* plNumBytes, ubyte* aData);
    HRESULT ReadDWORD(int lHandle, uint* pdw);
    HRESULT WriteDWORD(int lHandle, uint dw);
    HRESULT ReadQWORD(int lHandle, ulong* pqw);
    HRESULT WriteQWORD(int lHandle, ulong pw);
    HRESULT GetPropertyInfoByHandle(int lHandle, BSTR* pstrName, int* pType);
    HRESULT Lock(int lFlags);
    HRESULT Unlock(int lFlags);
}

const GUID IID_IWbemQualifierSet = {0xDC12A680, 0x737F, 0x11CF, [0x88, 0x4D, 0x00, 0xAA, 0x00, 0x4B, 0x2E, 0x24]};
@GUID(0xDC12A680, 0x737F, 0x11CF, [0x88, 0x4D, 0x00, 0xAA, 0x00, 0x4B, 0x2E, 0x24]);
interface IWbemQualifierSet : IUnknown
{
    HRESULT Get(const(wchar)* wszName, int lFlags, VARIANT* pVal, int* plFlavor);
    HRESULT Put(const(wchar)* wszName, VARIANT* pVal, int lFlavor);
    HRESULT Delete(const(wchar)* wszName);
    HRESULT GetNames(int lFlags, SAFEARRAY** pNames);
    HRESULT BeginEnumeration(int lFlags);
    HRESULT Next(int lFlags, BSTR* pstrName, VARIANT* pVal, int* plFlavor);
    HRESULT EndEnumeration();
}

const GUID IID_IWbemServices = {0x9556DC99, 0x828C, 0x11CF, [0xA3, 0x7E, 0x00, 0xAA, 0x00, 0x32, 0x40, 0xC7]};
@GUID(0x9556DC99, 0x828C, 0x11CF, [0xA3, 0x7E, 0x00, 0xAA, 0x00, 0x32, 0x40, 0xC7]);
interface IWbemServices : IUnknown
{
    HRESULT OpenNamespace(const(ushort)* strNamespace, int lFlags, IWbemContext pCtx, IWbemServices* ppWorkingNamespace, IWbemCallResult* ppResult);
    HRESULT CancelAsyncCall(IWbemObjectSink pSink);
    HRESULT QueryObjectSink(int lFlags, IWbemObjectSink* ppResponseHandler);
    HRESULT GetObjectA(const(ushort)* strObjectPath, int lFlags, IWbemContext pCtx, IWbemClassObject* ppObject, IWbemCallResult* ppCallResult);
    HRESULT GetObjectAsync(const(ushort)* strObjectPath, int lFlags, IWbemContext pCtx, IWbemObjectSink pResponseHandler);
    HRESULT PutClass(IWbemClassObject pObject, int lFlags, IWbemContext pCtx, IWbemCallResult* ppCallResult);
    HRESULT PutClassAsync(IWbemClassObject pObject, int lFlags, IWbemContext pCtx, IWbemObjectSink pResponseHandler);
    HRESULT DeleteClass(const(ushort)* strClass, int lFlags, IWbemContext pCtx, IWbemCallResult* ppCallResult);
    HRESULT DeleteClassAsync(const(ushort)* strClass, int lFlags, IWbemContext pCtx, IWbemObjectSink pResponseHandler);
    HRESULT CreateClassEnum(const(ushort)* strSuperclass, int lFlags, IWbemContext pCtx, IEnumWbemClassObject* ppEnum);
    HRESULT CreateClassEnumAsync(const(ushort)* strSuperclass, int lFlags, IWbemContext pCtx, IWbemObjectSink pResponseHandler);
    HRESULT PutInstance(IWbemClassObject pInst, int lFlags, IWbemContext pCtx, IWbemCallResult* ppCallResult);
    HRESULT PutInstanceAsync(IWbemClassObject pInst, int lFlags, IWbemContext pCtx, IWbemObjectSink pResponseHandler);
    HRESULT DeleteInstance(const(ushort)* strObjectPath, int lFlags, IWbemContext pCtx, IWbemCallResult* ppCallResult);
    HRESULT DeleteInstanceAsync(const(ushort)* strObjectPath, int lFlags, IWbemContext pCtx, IWbemObjectSink pResponseHandler);
    HRESULT CreateInstanceEnum(const(ushort)* strFilter, int lFlags, IWbemContext pCtx, IEnumWbemClassObject* ppEnum);
    HRESULT CreateInstanceEnumAsync(const(ushort)* strFilter, int lFlags, IWbemContext pCtx, IWbemObjectSink pResponseHandler);
    HRESULT ExecQuery(const(ushort)* strQueryLanguage, const(ushort)* strQuery, int lFlags, IWbemContext pCtx, IEnumWbemClassObject* ppEnum);
    HRESULT ExecQueryAsync(const(ushort)* strQueryLanguage, const(ushort)* strQuery, int lFlags, IWbemContext pCtx, IWbemObjectSink pResponseHandler);
    HRESULT ExecNotificationQuery(const(ushort)* strQueryLanguage, const(ushort)* strQuery, int lFlags, IWbemContext pCtx, IEnumWbemClassObject* ppEnum);
    HRESULT ExecNotificationQueryAsync(const(ushort)* strQueryLanguage, const(ushort)* strQuery, int lFlags, IWbemContext pCtx, IWbemObjectSink pResponseHandler);
    HRESULT ExecMethod(const(ushort)* strObjectPath, const(ushort)* strMethodName, int lFlags, IWbemContext pCtx, IWbemClassObject pInParams, IWbemClassObject* ppOutParams, IWbemCallResult* ppCallResult);
    HRESULT ExecMethodAsync(const(ushort)* strObjectPath, const(ushort)* strMethodName, int lFlags, IWbemContext pCtx, IWbemClassObject pInParams, IWbemObjectSink pResponseHandler);
}

const GUID IID_IWbemLocator = {0xDC12A687, 0x737F, 0x11CF, [0x88, 0x4D, 0x00, 0xAA, 0x00, 0x4B, 0x2E, 0x24]};
@GUID(0xDC12A687, 0x737F, 0x11CF, [0x88, 0x4D, 0x00, 0xAA, 0x00, 0x4B, 0x2E, 0x24]);
interface IWbemLocator : IUnknown
{
    HRESULT ConnectServer(const(ushort)* strNetworkResource, const(ushort)* strUser, const(ushort)* strPassword, const(ushort)* strLocale, int lSecurityFlags, const(ushort)* strAuthority, IWbemContext pCtx, IWbemServices* ppNamespace);
}

const GUID IID_IWbemObjectSink = {0x7C857801, 0x7381, 0x11CF, [0x88, 0x4D, 0x00, 0xAA, 0x00, 0x4B, 0x2E, 0x24]};
@GUID(0x7C857801, 0x7381, 0x11CF, [0x88, 0x4D, 0x00, 0xAA, 0x00, 0x4B, 0x2E, 0x24]);
interface IWbemObjectSink : IUnknown
{
    HRESULT Indicate(int lObjectCount, char* apObjArray);
    HRESULT SetStatus(int lFlags, HRESULT hResult, BSTR strParam, IWbemClassObject pObjParam);
}

const GUID IID_IEnumWbemClassObject = {0x027947E1, 0xD731, 0x11CE, [0xA3, 0x57, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01]};
@GUID(0x027947E1, 0xD731, 0x11CE, [0xA3, 0x57, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01]);
interface IEnumWbemClassObject : IUnknown
{
    HRESULT Reset();
    HRESULT Next(int lTimeout, uint uCount, char* apObjects, uint* puReturned);
    HRESULT NextAsync(uint uCount, IWbemObjectSink pSink);
    HRESULT Clone(IEnumWbemClassObject* ppEnum);
    HRESULT Skip(int lTimeout, uint nCount);
}

const GUID IID_IWbemCallResult = {0x44ACA675, 0xE8FC, 0x11D0, [0xA0, 0x7C, 0x00, 0xC0, 0x4F, 0xB6, 0x88, 0x20]};
@GUID(0x44ACA675, 0xE8FC, 0x11D0, [0xA0, 0x7C, 0x00, 0xC0, 0x4F, 0xB6, 0x88, 0x20]);
interface IWbemCallResult : IUnknown
{
    HRESULT GetResultObject(int lTimeout, IWbemClassObject* ppResultObject);
    HRESULT GetResultString(int lTimeout, BSTR* pstrResultString);
    HRESULT GetResultServices(int lTimeout, IWbemServices* ppServices);
    HRESULT GetCallStatus(int lTimeout, int* plStatus);
}

const GUID IID_IWbemContext = {0x44ACA674, 0xE8FC, 0x11D0, [0xA0, 0x7C, 0x00, 0xC0, 0x4F, 0xB6, 0x88, 0x20]};
@GUID(0x44ACA674, 0xE8FC, 0x11D0, [0xA0, 0x7C, 0x00, 0xC0, 0x4F, 0xB6, 0x88, 0x20]);
interface IWbemContext : IUnknown
{
    HRESULT Clone(IWbemContext* ppNewCopy);
    HRESULT GetNames(int lFlags, SAFEARRAY** pNames);
    HRESULT BeginEnumeration(int lFlags);
    HRESULT Next(int lFlags, BSTR* pstrName, VARIANT* pValue);
    HRESULT EndEnumeration();
    HRESULT SetValue(const(wchar)* wszName, int lFlags, VARIANT* pValue);
    HRESULT GetValue(const(wchar)* wszName, int lFlags, VARIANT* pValue);
    HRESULT DeleteValue(const(wchar)* wszName, int lFlags);
    HRESULT DeleteAll();
}

const GUID IID_IUnsecuredApartment = {0x1CFABA8C, 0x1523, 0x11D1, [0xAD, 0x79, 0x00, 0xC0, 0x4F, 0xD8, 0xFD, 0xFF]};
@GUID(0x1CFABA8C, 0x1523, 0x11D1, [0xAD, 0x79, 0x00, 0xC0, 0x4F, 0xD8, 0xFD, 0xFF]);
interface IUnsecuredApartment : IUnknown
{
    HRESULT CreateObjectStub(IUnknown pObject, IUnknown* ppStub);
}

const GUID IID_IWbemUnsecuredApartment = {0x31739D04, 0x3471, 0x4CF4, [0x9A, 0x7C, 0x57, 0xA4, 0x4A, 0xE7, 0x19, 0x56]};
@GUID(0x31739D04, 0x3471, 0x4CF4, [0x9A, 0x7C, 0x57, 0xA4, 0x4A, 0xE7, 0x19, 0x56]);
interface IWbemUnsecuredApartment : IUnsecuredApartment
{
    HRESULT CreateSinkStub(IWbemObjectSink pSink, uint dwFlags, const(wchar)* wszReserved, IWbemObjectSink* ppStub);
}

const GUID IID_IWbemStatusCodeText = {0xEB87E1BC, 0x3233, 0x11D2, [0xAE, 0xC9, 0x00, 0xC0, 0x4F, 0xB6, 0x88, 0x20]};
@GUID(0xEB87E1BC, 0x3233, 0x11D2, [0xAE, 0xC9, 0x00, 0xC0, 0x4F, 0xB6, 0x88, 0x20]);
interface IWbemStatusCodeText : IUnknown
{
    HRESULT GetErrorCodeText(HRESULT hRes, uint LocaleId, int lFlags, BSTR* MessageText);
    HRESULT GetFacilityCodeText(HRESULT hRes, uint LocaleId, int lFlags, BSTR* MessageText);
}

const GUID IID_IWbemBackupRestore = {0xC49E32C7, 0xBC8B, 0x11D2, [0x85, 0xD4, 0x00, 0x10, 0x5A, 0x1F, 0x83, 0x04]};
@GUID(0xC49E32C7, 0xBC8B, 0x11D2, [0x85, 0xD4, 0x00, 0x10, 0x5A, 0x1F, 0x83, 0x04]);
interface IWbemBackupRestore : IUnknown
{
    HRESULT Backup(const(wchar)* strBackupToFile, int lFlags);
    HRESULT Restore(const(wchar)* strRestoreFromFile, int lFlags);
}

const GUID IID_IWbemBackupRestoreEx = {0xA359DEC5, 0xE813, 0x4834, [0x8A, 0x2A, 0xBA, 0x7F, 0x1D, 0x77, 0x7D, 0x76]};
@GUID(0xA359DEC5, 0xE813, 0x4834, [0x8A, 0x2A, 0xBA, 0x7F, 0x1D, 0x77, 0x7D, 0x76]);
interface IWbemBackupRestoreEx : IWbemBackupRestore
{
    HRESULT Pause();
    HRESULT Resume();
}

const GUID IID_IWbemRefresher = {0x49353C99, 0x516B, 0x11D1, [0xAE, 0xA6, 0x00, 0xC0, 0x4F, 0xB6, 0x88, 0x20]};
@GUID(0x49353C99, 0x516B, 0x11D1, [0xAE, 0xA6, 0x00, 0xC0, 0x4F, 0xB6, 0x88, 0x20]);
interface IWbemRefresher : IUnknown
{
    HRESULT Refresh(int lFlags);
}

const GUID IID_IWbemHiPerfEnum = {0x2705C288, 0x79AE, 0x11D2, [0xB3, 0x48, 0x00, 0x10, 0x5A, 0x1F, 0x81, 0x77]};
@GUID(0x2705C288, 0x79AE, 0x11D2, [0xB3, 0x48, 0x00, 0x10, 0x5A, 0x1F, 0x81, 0x77]);
interface IWbemHiPerfEnum : IUnknown
{
    HRESULT AddObjects(int lFlags, uint uNumObjects, int* apIds, IWbemObjectAccess* apObj);
    HRESULT RemoveObjects(int lFlags, uint uNumObjects, int* apIds);
    HRESULT GetObjects(int lFlags, uint uNumObjects, IWbemObjectAccess* apObj, uint* puReturned);
    HRESULT RemoveAll(int lFlags);
}

const GUID IID_IWbemConfigureRefresher = {0x49353C92, 0x516B, 0x11D1, [0xAE, 0xA6, 0x00, 0xC0, 0x4F, 0xB6, 0x88, 0x20]};
@GUID(0x49353C92, 0x516B, 0x11D1, [0xAE, 0xA6, 0x00, 0xC0, 0x4F, 0xB6, 0x88, 0x20]);
interface IWbemConfigureRefresher : IUnknown
{
    HRESULT AddObjectByPath(IWbemServices pNamespace, const(wchar)* wszPath, int lFlags, IWbemContext pContext, IWbemClassObject* ppRefreshable, int* plId);
    HRESULT AddObjectByTemplate(IWbemServices pNamespace, IWbemClassObject pTemplate, int lFlags, IWbemContext pContext, IWbemClassObject* ppRefreshable, int* plId);
    HRESULT AddRefresher(IWbemRefresher pRefresher, int lFlags, int* plId);
    HRESULT Remove(int lId, int lFlags);
    HRESULT AddEnum(IWbemServices pNamespace, const(wchar)* wszClassName, int lFlags, IWbemContext pContext, IWbemHiPerfEnum* ppEnum, int* plId);
}

const GUID IID_IWbemObjectSinkEx = {0xE7D35CFA, 0x348B, 0x485E, [0xB5, 0x24, 0x25, 0x27, 0x25, 0xD6, 0x97, 0xCA]};
@GUID(0xE7D35CFA, 0x348B, 0x485E, [0xB5, 0x24, 0x25, 0x27, 0x25, 0xD6, 0x97, 0xCA]);
interface IWbemObjectSinkEx : IWbemObjectSink
{
    HRESULT WriteMessage(uint uChannel, const(ushort)* strMessage);
    HRESULT WriteError(IWbemClassObject pObjError, ubyte* puReturned);
    HRESULT PromptUser(const(ushort)* strMessage, ubyte uPromptType, ubyte* puReturned);
    HRESULT WriteProgress(const(ushort)* strActivity, const(ushort)* strCurrentOperation, const(ushort)* strStatusDescription, uint uPercentComplete, uint uSecondsRemaining);
    HRESULT WriteStreamParameter(const(ushort)* strName, VARIANT* vtValue, uint ulType, uint ulFlags);
}

const GUID IID_IWbemShutdown = {0xB7B31DF9, 0xD515, 0x11D3, [0xA1, 0x1C, 0x00, 0x10, 0x5A, 0x1F, 0x51, 0x5A]};
@GUID(0xB7B31DF9, 0xD515, 0x11D3, [0xA1, 0x1C, 0x00, 0x10, 0x5A, 0x1F, 0x51, 0x5A]);
interface IWbemShutdown : IUnknown
{
    HRESULT Shutdown(int uReason, uint uMaxMilliseconds, IWbemContext pCtx);
}

enum WMI_OBJ_TEXT
{
    WMI_OBJ_TEXT_CIM_DTD_2_0 = 1,
    WMI_OBJ_TEXT_WMI_DTD_2_0 = 2,
    WMI_OBJ_TEXT_WMI_EXT1 = 3,
    WMI_OBJ_TEXT_WMI_EXT2 = 4,
    WMI_OBJ_TEXT_WMI_EXT3 = 5,
    WMI_OBJ_TEXT_WMI_EXT4 = 6,
    WMI_OBJ_TEXT_WMI_EXT5 = 7,
    WMI_OBJ_TEXT_WMI_EXT6 = 8,
    WMI_OBJ_TEXT_WMI_EXT7 = 9,
    WMI_OBJ_TEXT_WMI_EXT8 = 10,
    WMI_OBJ_TEXT_WMI_EXT9 = 11,
    WMI_OBJ_TEXT_WMI_EXT10 = 12,
    WMI_OBJ_TEXT_LAST = 13,
}

const GUID IID_IWbemObjectTextSrc = {0xBFBF883A, 0xCAD7, 0x11D3, [0xA1, 0x1B, 0x00, 0x10, 0x5A, 0x1F, 0x51, 0x5A]};
@GUID(0xBFBF883A, 0xCAD7, 0x11D3, [0xA1, 0x1B, 0x00, 0x10, 0x5A, 0x1F, 0x51, 0x5A]);
interface IWbemObjectTextSrc : IUnknown
{
    HRESULT GetText(int lFlags, IWbemClassObject pObj, uint uObjTextFormat, IWbemContext pCtx, BSTR* strText);
    HRESULT CreateFromText(int lFlags, BSTR strText, uint uObjTextFormat, IWbemContext pCtx, IWbemClassObject* pNewObj);
}

struct WBEM_COMPILE_STATUS_INFO
{
    int lPhaseError;
    HRESULT hRes;
    int ObjectNum;
    int FirstLine;
    int LastLine;
    uint dwOutFlags;
}

enum WBEM_COMPILER_OPTIONS
{
    WBEM_FLAG_CHECK_ONLY = 1,
    WBEM_FLAG_AUTORECOVER = 2,
    WBEM_FLAG_WMI_CHECK = 4,
    WBEM_FLAG_CONSOLE_PRINT = 8,
    WBEM_FLAG_DONT_ADD_TO_LIST = 16,
    WBEM_FLAG_SPLIT_FILES = 32,
    WBEM_FLAG_STORE_FILE = 256,
}

enum WBEM_CONNECT_OPTIONS
{
    WBEM_FLAG_CONNECT_REPOSITORY_ONLY = 64,
    WBEM_FLAG_CONNECT_USE_MAX_WAIT = 128,
    WBEM_FLAG_CONNECT_PROVIDERS = 256,
}

const GUID IID_IMofCompiler = {0x6DAF974E, 0x2E37, 0x11D2, [0xAE, 0xC9, 0x00, 0xC0, 0x4F, 0xB6, 0x88, 0x20]};
@GUID(0x6DAF974E, 0x2E37, 0x11D2, [0xAE, 0xC9, 0x00, 0xC0, 0x4F, 0xB6, 0x88, 0x20]);
interface IMofCompiler : IUnknown
{
    HRESULT CompileFile(const(wchar)* FileName, const(wchar)* ServerAndNamespace, const(wchar)* User, const(wchar)* Authority, const(wchar)* Password, int lOptionFlags, int lClassFlags, int lInstanceFlags, WBEM_COMPILE_STATUS_INFO* pInfo);
    HRESULT CompileBuffer(int BuffSize, char* pBuffer, const(wchar)* ServerAndNamespace, const(wchar)* User, const(wchar)* Authority, const(wchar)* Password, int lOptionFlags, int lClassFlags, int lInstanceFlags, WBEM_COMPILE_STATUS_INFO* pInfo);
    HRESULT CreateBMOF(const(wchar)* TextFileName, const(wchar)* BMOFFileName, const(wchar)* ServerAndNamespace, int lOptionFlags, int lClassFlags, int lInstanceFlags, WBEM_COMPILE_STATUS_INFO* pInfo);
}

enum WBEM_UNSECAPP_FLAG_TYPE
{
    WBEM_FLAG_UNSECAPP_DEFAULT_CHECK_ACCESS = 0,
    WBEM_FLAG_UNSECAPP_CHECK_ACCESS = 1,
    WBEM_FLAG_UNSECAPP_DONT_CHECK_ACCESS = 2,
}

enum tag_WBEM_INFORMATION_FLAG_TYPE
{
    WBEM_FLAG_SHORT_NAME = 1,
    WBEM_FLAG_LONG_NAME = 2,
}

const GUID CLSID_WbemAdministrativeLocator = {0xCB8555CC, 0x9128, 0x11D1, [0xAD, 0x9B, 0x00, 0xC0, 0x4F, 0xD8, 0xFD, 0xFF]};
@GUID(0xCB8555CC, 0x9128, 0x11D1, [0xAD, 0x9B, 0x00, 0xC0, 0x4F, 0xD8, 0xFD, 0xFF]);
struct WbemAdministrativeLocator;

const GUID CLSID_WbemAuthenticatedLocator = {0xCD184336, 0x9128, 0x11D1, [0xAD, 0x9B, 0x00, 0xC0, 0x4F, 0xD8, 0xFD, 0xFF]};
@GUID(0xCD184336, 0x9128, 0x11D1, [0xAD, 0x9B, 0x00, 0xC0, 0x4F, 0xD8, 0xFD, 0xFF]);
struct WbemAuthenticatedLocator;

const GUID CLSID_WbemUnauthenticatedLocator = {0x443E7B79, 0xDE31, 0x11D2, [0xB3, 0x40, 0x00, 0x10, 0x4B, 0xCC, 0x4B, 0x4A]};
@GUID(0x443E7B79, 0xDE31, 0x11D2, [0xB3, 0x40, 0x00, 0x10, 0x4B, 0xCC, 0x4B, 0x4A]);
struct WbemUnauthenticatedLocator;

const GUID CLSID_WbemDecoupledRegistrar = {0x4CFC7932, 0x0F9D, 0x4BEF, [0x9C, 0x32, 0x8E, 0xA2, 0xA6, 0xB5, 0x6F, 0xCB]};
@GUID(0x4CFC7932, 0x0F9D, 0x4BEF, [0x9C, 0x32, 0x8E, 0xA2, 0xA6, 0xB5, 0x6F, 0xCB]);
struct WbemDecoupledRegistrar;

const GUID CLSID_WbemDecoupledBasicEventProvider = {0xF5F75737, 0x2843, 0x4F22, [0x93, 0x3D, 0xC7, 0x6A, 0x97, 0xCD, 0xA6, 0x2F]};
@GUID(0xF5F75737, 0x2843, 0x4F22, [0x93, 0x3D, 0xC7, 0x6A, 0x97, 0xCD, 0xA6, 0x2F]);
struct WbemDecoupledBasicEventProvider;

enum tag_WBEM_PROVIDER_REQUIREMENTS_TYPE
{
    WBEM_REQUIREMENTS_START_POSTFILTER = 0,
    WBEM_REQUIREMENTS_STOP_POSTFILTER = 1,
    WBEM_REQUIREMENTS_RECHECK_SUBSCRIPTIONS = 2,
}

const GUID IID_IWbemPropertyProvider = {0xCE61E841, 0x65BC, 0x11D0, [0xB6, 0xBD, 0x00, 0xAA, 0x00, 0x32, 0x40, 0xC7]};
@GUID(0xCE61E841, 0x65BC, 0x11D0, [0xB6, 0xBD, 0x00, 0xAA, 0x00, 0x32, 0x40, 0xC7]);
interface IWbemPropertyProvider : IUnknown
{
    HRESULT GetProperty(int lFlags, const(ushort)* strLocale, const(ushort)* strClassMapping, const(ushort)* strInstMapping, const(ushort)* strPropMapping, VARIANT* pvValue);
    HRESULT PutProperty(int lFlags, const(ushort)* strLocale, const(ushort)* strClassMapping, const(ushort)* strInstMapping, const(ushort)* strPropMapping, const(VARIANT)* pvValue);
}

const GUID IID_IWbemUnboundObjectSink = {0xE246107B, 0xB06E, 0x11D0, [0xAD, 0x61, 0x00, 0xC0, 0x4F, 0xD8, 0xFD, 0xFF]};
@GUID(0xE246107B, 0xB06E, 0x11D0, [0xAD, 0x61, 0x00, 0xC0, 0x4F, 0xD8, 0xFD, 0xFF]);
interface IWbemUnboundObjectSink : IUnknown
{
    HRESULT IndicateToConsumer(IWbemClassObject pLogicalConsumer, int lNumObjects, char* apObjects);
}

const GUID IID_IWbemEventProvider = {0xE245105B, 0xB06E, 0x11D0, [0xAD, 0x61, 0x00, 0xC0, 0x4F, 0xD8, 0xFD, 0xFF]};
@GUID(0xE245105B, 0xB06E, 0x11D0, [0xAD, 0x61, 0x00, 0xC0, 0x4F, 0xD8, 0xFD, 0xFF]);
interface IWbemEventProvider : IUnknown
{
    HRESULT ProvideEvents(IWbemObjectSink pSink, int lFlags);
}

const GUID IID_IWbemEventProviderQuerySink = {0x580ACAF8, 0xFA1C, 0x11D0, [0xAD, 0x72, 0x00, 0xC0, 0x4F, 0xD8, 0xFD, 0xFF]};
@GUID(0x580ACAF8, 0xFA1C, 0x11D0, [0xAD, 0x72, 0x00, 0xC0, 0x4F, 0xD8, 0xFD, 0xFF]);
interface IWbemEventProviderQuerySink : IUnknown
{
    HRESULT NewQuery(uint dwId, ushort* wszQueryLanguage, ushort* wszQuery);
    HRESULT CancelQuery(uint dwId);
}

const GUID IID_IWbemEventProviderSecurity = {0x631F7D96, 0xD993, 0x11D2, [0xB3, 0x39, 0x00, 0x10, 0x5A, 0x1F, 0x4A, 0xAF]};
@GUID(0x631F7D96, 0xD993, 0x11D2, [0xB3, 0x39, 0x00, 0x10, 0x5A, 0x1F, 0x4A, 0xAF]);
interface IWbemEventProviderSecurity : IUnknown
{
    HRESULT AccessCheck(ushort* wszQueryLanguage, ushort* wszQuery, int lSidLength, char* pSid);
}

const GUID IID_IWbemEventConsumerProvider = {0xE246107A, 0xB06E, 0x11D0, [0xAD, 0x61, 0x00, 0xC0, 0x4F, 0xD8, 0xFD, 0xFF]};
@GUID(0xE246107A, 0xB06E, 0x11D0, [0xAD, 0x61, 0x00, 0xC0, 0x4F, 0xD8, 0xFD, 0xFF]);
interface IWbemEventConsumerProvider : IUnknown
{
    HRESULT FindConsumer(IWbemClassObject pLogicalConsumer, IWbemUnboundObjectSink* ppConsumer);
}

const GUID IID_IWbemProviderInitSink = {0x1BE41571, 0x91DD, 0x11D1, [0xAE, 0xB2, 0x00, 0xC0, 0x4F, 0xB6, 0x88, 0x20]};
@GUID(0x1BE41571, 0x91DD, 0x11D1, [0xAE, 0xB2, 0x00, 0xC0, 0x4F, 0xB6, 0x88, 0x20]);
interface IWbemProviderInitSink : IUnknown
{
    HRESULT SetStatus(int lStatus, int lFlags);
}

const GUID IID_IWbemProviderInit = {0x1BE41572, 0x91DD, 0x11D1, [0xAE, 0xB2, 0x00, 0xC0, 0x4F, 0xB6, 0x88, 0x20]};
@GUID(0x1BE41572, 0x91DD, 0x11D1, [0xAE, 0xB2, 0x00, 0xC0, 0x4F, 0xB6, 0x88, 0x20]);
interface IWbemProviderInit : IUnknown
{
    HRESULT Initialize(const(wchar)* wszUser, int lFlags, const(wchar)* wszNamespace, const(wchar)* wszLocale, IWbemServices pNamespace, IWbemContext pCtx, IWbemProviderInitSink pInitSink);
}

const GUID IID_IWbemHiPerfProvider = {0x49353C93, 0x516B, 0x11D1, [0xAE, 0xA6, 0x00, 0xC0, 0x4F, 0xB6, 0x88, 0x20]};
@GUID(0x49353C93, 0x516B, 0x11D1, [0xAE, 0xA6, 0x00, 0xC0, 0x4F, 0xB6, 0x88, 0x20]);
interface IWbemHiPerfProvider : IUnknown
{
    HRESULT QueryInstances(IWbemServices pNamespace, ushort* wszClass, int lFlags, IWbemContext pCtx, IWbemObjectSink pSink);
    HRESULT CreateRefresher(IWbemServices pNamespace, int lFlags, IWbemRefresher* ppRefresher);
    HRESULT CreateRefreshableObject(IWbemServices pNamespace, IWbemObjectAccess pTemplate, IWbemRefresher pRefresher, int lFlags, IWbemContext pContext, IWbemObjectAccess* ppRefreshable, int* plId);
    HRESULT StopRefreshing(IWbemRefresher pRefresher, int lId, int lFlags);
    HRESULT CreateRefreshableEnum(IWbemServices pNamespace, const(wchar)* wszClass, IWbemRefresher pRefresher, int lFlags, IWbemContext pContext, IWbemHiPerfEnum pHiPerfEnum, int* plId);
    HRESULT GetObjects(IWbemServices pNamespace, int lNumObjects, char* apObj, int lFlags, IWbemContext pContext);
}

const GUID IID_IWbemDecoupledRegistrar = {0x1005CBCF, 0xE64F, 0x4646, [0xBC, 0xD3, 0x3A, 0x08, 0x9D, 0x8A, 0x84, 0xB4]};
@GUID(0x1005CBCF, 0xE64F, 0x4646, [0xBC, 0xD3, 0x3A, 0x08, 0x9D, 0x8A, 0x84, 0xB4]);
interface IWbemDecoupledRegistrar : IUnknown
{
    HRESULT Register(int a_Flags, IWbemContext a_Context, const(wchar)* a_User, const(wchar)* a_Locale, const(wchar)* a_Scope, const(wchar)* a_Registration, IUnknown pIUnknown);
    HRESULT UnRegister();
}

const GUID IID_IWbemProviderIdentity = {0x631F7D97, 0xD993, 0x11D2, [0xB3, 0x39, 0x00, 0x10, 0x5A, 0x1F, 0x4A, 0xAF]};
@GUID(0x631F7D97, 0xD993, 0x11D2, [0xB3, 0x39, 0x00, 0x10, 0x5A, 0x1F, 0x4A, 0xAF]);
interface IWbemProviderIdentity : IUnknown
{
    HRESULT SetRegistrationObject(int lFlags, IWbemClassObject pProvReg);
}

enum tag_WBEM_EXTRA_RETURN_CODES
{
    WBEM_S_INITIALIZED = 0,
    WBEM_S_LIMITED_SERVICE = 274433,
    WBEM_S_INDIRECTLY_UPDATED = 274434,
    WBEM_S_SUBJECT_TO_SDS = 274435,
    WBEM_E_RETRY_LATER = -2147209215,
    WBEM_E_RESOURCE_CONTENTION = -2147209214,
}

enum tag_WBEM_PROVIDER_FLAGS
{
    WBEM_FLAG_OWNER_UPDATE = 65536,
}

const GUID IID_IWbemDecoupledBasicEventProvider = {0x86336D20, 0xCA11, 0x4786, [0x9E, 0xF1, 0xBC, 0x8A, 0x94, 0x6B, 0x42, 0xFC]};
@GUID(0x86336D20, 0xCA11, 0x4786, [0x9E, 0xF1, 0xBC, 0x8A, 0x94, 0x6B, 0x42, 0xFC]);
interface IWbemDecoupledBasicEventProvider : IWbemDecoupledRegistrar
{
    HRESULT GetSink(int a_Flags, IWbemContext a_Context, IWbemObjectSink* a_Sink);
    HRESULT GetService(int a_Flags, IWbemContext a_Context, IWbemServices* a_Service);
}

enum tag_WBEM_BATCH_TYPE
{
    WBEM_FLAG_BATCH_IF_NEEDED = 0,
    WBEM_FLAG_MUST_BATCH = 1,
    WBEM_FLAG_MUST_NOT_BATCH = 2,
}

const GUID IID_IWbemEventSink = {0x3AE0080A, 0x7E3A, 0x4366, [0xBF, 0x89, 0x0F, 0xEE, 0xDC, 0x93, 0x16, 0x59]};
@GUID(0x3AE0080A, 0x7E3A, 0x4366, [0xBF, 0x89, 0x0F, 0xEE, 0xDC, 0x93, 0x16, 0x59]);
interface IWbemEventSink : IWbemObjectSink
{
    HRESULT SetSinkSecurity(int lSDLength, char* pSD);
    HRESULT IsActive();
    HRESULT GetRestrictedSink(int lNumQueries, char* awszQueries, IUnknown pCallback, IWbemEventSink* ppSink);
    HRESULT SetBatchingParameters(int lFlags, uint dwMaxBufferSize, uint dwMaxSendLatency);
}

const GUID CLSID_SWbemLocator = {0x76A64158, 0xCB41, 0x11D1, [0x8B, 0x02, 0x00, 0x60, 0x08, 0x06, 0xD9, 0xB6]};
@GUID(0x76A64158, 0xCB41, 0x11D1, [0x8B, 0x02, 0x00, 0x60, 0x08, 0x06, 0xD9, 0xB6]);
struct SWbemLocator;

const GUID CLSID_SWbemNamedValueSet = {0x9AED384E, 0xCE8B, 0x11D1, [0x8B, 0x05, 0x00, 0x60, 0x08, 0x06, 0xD9, 0xB6]};
@GUID(0x9AED384E, 0xCE8B, 0x11D1, [0x8B, 0x05, 0x00, 0x60, 0x08, 0x06, 0xD9, 0xB6]);
struct SWbemNamedValueSet;

const GUID CLSID_SWbemObjectPath = {0x5791BC26, 0xCE9C, 0x11D1, [0x97, 0xBF, 0x00, 0x00, 0xF8, 0x1E, 0x84, 0x9C]};
@GUID(0x5791BC26, 0xCE9C, 0x11D1, [0x97, 0xBF, 0x00, 0x00, 0xF8, 0x1E, 0x84, 0x9C]);
struct SWbemObjectPath;

const GUID CLSID_SWbemLastError = {0xC2FEEEAC, 0xCFCD, 0x11D1, [0x8B, 0x05, 0x00, 0x60, 0x08, 0x06, 0xD9, 0xB6]};
@GUID(0xC2FEEEAC, 0xCFCD, 0x11D1, [0x8B, 0x05, 0x00, 0x60, 0x08, 0x06, 0xD9, 0xB6]);
struct SWbemLastError;

const GUID CLSID_SWbemSink = {0x75718C9A, 0xF029, 0x11D1, [0xA1, 0xAC, 0x00, 0xC0, 0x4F, 0xB6, 0xC2, 0x23]};
@GUID(0x75718C9A, 0xF029, 0x11D1, [0xA1, 0xAC, 0x00, 0xC0, 0x4F, 0xB6, 0xC2, 0x23]);
struct SWbemSink;

const GUID CLSID_SWbemDateTime = {0x47DFBE54, 0xCF76, 0x11D3, [0xB3, 0x8F, 0x00, 0x10, 0x5A, 0x1F, 0x47, 0x3A]};
@GUID(0x47DFBE54, 0xCF76, 0x11D3, [0xB3, 0x8F, 0x00, 0x10, 0x5A, 0x1F, 0x47, 0x3A]);
struct SWbemDateTime;

const GUID CLSID_SWbemRefresher = {0xD269BF5C, 0xD9C1, 0x11D3, [0xB3, 0x8F, 0x00, 0x10, 0x5A, 0x1F, 0x47, 0x3A]};
@GUID(0xD269BF5C, 0xD9C1, 0x11D3, [0xB3, 0x8F, 0x00, 0x10, 0x5A, 0x1F, 0x47, 0x3A]);
struct SWbemRefresher;

const GUID CLSID_SWbemServices = {0x04B83D63, 0x21AE, 0x11D2, [0x8B, 0x33, 0x00, 0x60, 0x08, 0x06, 0xD9, 0xB6]};
@GUID(0x04B83D63, 0x21AE, 0x11D2, [0x8B, 0x33, 0x00, 0x60, 0x08, 0x06, 0xD9, 0xB6]);
struct SWbemServices;

const GUID CLSID_SWbemServicesEx = {0x62E522DC, 0x8CF3, 0x40A8, [0x8B, 0x2E, 0x37, 0xD5, 0x95, 0x65, 0x1E, 0x40]};
@GUID(0x62E522DC, 0x8CF3, 0x40A8, [0x8B, 0x2E, 0x37, 0xD5, 0x95, 0x65, 0x1E, 0x40]);
struct SWbemServicesEx;

const GUID CLSID_SWbemObject = {0x04B83D62, 0x21AE, 0x11D2, [0x8B, 0x33, 0x00, 0x60, 0x08, 0x06, 0xD9, 0xB6]};
@GUID(0x04B83D62, 0x21AE, 0x11D2, [0x8B, 0x33, 0x00, 0x60, 0x08, 0x06, 0xD9, 0xB6]);
struct SWbemObject;

const GUID CLSID_SWbemObjectEx = {0xD6BDAFB2, 0x9435, 0x491F, [0xBB, 0x87, 0x6A, 0xA0, 0xF0, 0xBC, 0x31, 0xA2]};
@GUID(0xD6BDAFB2, 0x9435, 0x491F, [0xBB, 0x87, 0x6A, 0xA0, 0xF0, 0xBC, 0x31, 0xA2]);
struct SWbemObjectEx;

const GUID CLSID_SWbemObjectSet = {0x04B83D61, 0x21AE, 0x11D2, [0x8B, 0x33, 0x00, 0x60, 0x08, 0x06, 0xD9, 0xB6]};
@GUID(0x04B83D61, 0x21AE, 0x11D2, [0x8B, 0x33, 0x00, 0x60, 0x08, 0x06, 0xD9, 0xB6]);
struct SWbemObjectSet;

const GUID CLSID_SWbemNamedValue = {0x04B83D60, 0x21AE, 0x11D2, [0x8B, 0x33, 0x00, 0x60, 0x08, 0x06, 0xD9, 0xB6]};
@GUID(0x04B83D60, 0x21AE, 0x11D2, [0x8B, 0x33, 0x00, 0x60, 0x08, 0x06, 0xD9, 0xB6]);
struct SWbemNamedValue;

const GUID CLSID_SWbemQualifier = {0x04B83D5F, 0x21AE, 0x11D2, [0x8B, 0x33, 0x00, 0x60, 0x08, 0x06, 0xD9, 0xB6]};
@GUID(0x04B83D5F, 0x21AE, 0x11D2, [0x8B, 0x33, 0x00, 0x60, 0x08, 0x06, 0xD9, 0xB6]);
struct SWbemQualifier;

const GUID CLSID_SWbemQualifierSet = {0x04B83D5E, 0x21AE, 0x11D2, [0x8B, 0x33, 0x00, 0x60, 0x08, 0x06, 0xD9, 0xB6]};
@GUID(0x04B83D5E, 0x21AE, 0x11D2, [0x8B, 0x33, 0x00, 0x60, 0x08, 0x06, 0xD9, 0xB6]);
struct SWbemQualifierSet;

const GUID CLSID_SWbemProperty = {0x04B83D5D, 0x21AE, 0x11D2, [0x8B, 0x33, 0x00, 0x60, 0x08, 0x06, 0xD9, 0xB6]};
@GUID(0x04B83D5D, 0x21AE, 0x11D2, [0x8B, 0x33, 0x00, 0x60, 0x08, 0x06, 0xD9, 0xB6]);
struct SWbemProperty;

const GUID CLSID_SWbemPropertySet = {0x04B83D5C, 0x21AE, 0x11D2, [0x8B, 0x33, 0x00, 0x60, 0x08, 0x06, 0xD9, 0xB6]};
@GUID(0x04B83D5C, 0x21AE, 0x11D2, [0x8B, 0x33, 0x00, 0x60, 0x08, 0x06, 0xD9, 0xB6]);
struct SWbemPropertySet;

const GUID CLSID_SWbemMethod = {0x04B83D5B, 0x21AE, 0x11D2, [0x8B, 0x33, 0x00, 0x60, 0x08, 0x06, 0xD9, 0xB6]};
@GUID(0x04B83D5B, 0x21AE, 0x11D2, [0x8B, 0x33, 0x00, 0x60, 0x08, 0x06, 0xD9, 0xB6]);
struct SWbemMethod;

const GUID CLSID_SWbemMethodSet = {0x04B83D5A, 0x21AE, 0x11D2, [0x8B, 0x33, 0x00, 0x60, 0x08, 0x06, 0xD9, 0xB6]};
@GUID(0x04B83D5A, 0x21AE, 0x11D2, [0x8B, 0x33, 0x00, 0x60, 0x08, 0x06, 0xD9, 0xB6]);
struct SWbemMethodSet;

const GUID CLSID_SWbemEventSource = {0x04B83D58, 0x21AE, 0x11D2, [0x8B, 0x33, 0x00, 0x60, 0x08, 0x06, 0xD9, 0xB6]};
@GUID(0x04B83D58, 0x21AE, 0x11D2, [0x8B, 0x33, 0x00, 0x60, 0x08, 0x06, 0xD9, 0xB6]);
struct SWbemEventSource;

const GUID CLSID_SWbemSecurity = {0xB54D66E9, 0x2287, 0x11D2, [0x8B, 0x33, 0x00, 0x60, 0x08, 0x06, 0xD9, 0xB6]};
@GUID(0xB54D66E9, 0x2287, 0x11D2, [0x8B, 0x33, 0x00, 0x60, 0x08, 0x06, 0xD9, 0xB6]);
struct SWbemSecurity;

const GUID CLSID_SWbemPrivilege = {0x26EE67BC, 0x5804, 0x11D2, [0x8B, 0x4A, 0x00, 0x60, 0x08, 0x06, 0xD9, 0xB6]};
@GUID(0x26EE67BC, 0x5804, 0x11D2, [0x8B, 0x4A, 0x00, 0x60, 0x08, 0x06, 0xD9, 0xB6]);
struct SWbemPrivilege;

const GUID CLSID_SWbemPrivilegeSet = {0x26EE67BE, 0x5804, 0x11D2, [0x8B, 0x4A, 0x00, 0x60, 0x08, 0x06, 0xD9, 0xB6]};
@GUID(0x26EE67BE, 0x5804, 0x11D2, [0x8B, 0x4A, 0x00, 0x60, 0x08, 0x06, 0xD9, 0xB6]);
struct SWbemPrivilegeSet;

const GUID CLSID_SWbemRefreshableItem = {0x8C6854BC, 0xDE4B, 0x11D3, [0xB3, 0x90, 0x00, 0x10, 0x5A, 0x1F, 0x47, 0x3A]};
@GUID(0x8C6854BC, 0xDE4B, 0x11D3, [0xB3, 0x90, 0x00, 0x10, 0x5A, 0x1F, 0x47, 0x3A]);
struct SWbemRefreshableItem;

enum WbemChangeFlagEnum
{
    wbemChangeFlagCreateOrUpdate = 0,
    wbemChangeFlagUpdateOnly = 1,
    wbemChangeFlagCreateOnly = 2,
    wbemChangeFlagUpdateCompatible = 0,
    wbemChangeFlagUpdateSafeMode = 32,
    wbemChangeFlagUpdateForceMode = 64,
    wbemChangeFlagStrongValidation = 128,
    wbemChangeFlagAdvisory = 65536,
}

enum WbemFlagEnum
{
    wbemFlagReturnImmediately = 16,
    wbemFlagReturnWhenComplete = 0,
    wbemFlagBidirectional = 0,
    wbemFlagForwardOnly = 32,
    wbemFlagNoErrorObject = 64,
    wbemFlagReturnErrorObject = 0,
    wbemFlagSendStatus = 128,
    wbemFlagDontSendStatus = 0,
    wbemFlagEnsureLocatable = 256,
    wbemFlagDirectRead = 512,
    wbemFlagSendOnlySelected = 0,
    wbemFlagUseAmendedQualifiers = 131072,
    wbemFlagGetDefault = 0,
    wbemFlagSpawnInstance = 1,
    wbemFlagUseCurrentTime = 1,
}

enum WbemQueryFlagEnum
{
    wbemQueryFlagDeep = 0,
    wbemQueryFlagShallow = 1,
    wbemQueryFlagPrototype = 2,
}

enum WbemTextFlagEnum
{
    wbemTextFlagNoFlavors = 1,
}

enum WbemTimeout
{
    wbemTimeoutInfinite = -1,
}

enum WbemComparisonFlagEnum
{
    wbemComparisonFlagIncludeAll = 0,
    wbemComparisonFlagIgnoreQualifiers = 1,
    wbemComparisonFlagIgnoreObjectSource = 2,
    wbemComparisonFlagIgnoreDefaultValues = 4,
    wbemComparisonFlagIgnoreClass = 8,
    wbemComparisonFlagIgnoreCase = 16,
    wbemComparisonFlagIgnoreFlavor = 32,
}

enum WbemCimtypeEnum
{
    wbemCimtypeSint8 = 16,
    wbemCimtypeUint8 = 17,
    wbemCimtypeSint16 = 2,
    wbemCimtypeUint16 = 18,
    wbemCimtypeSint32 = 3,
    wbemCimtypeUint32 = 19,
    wbemCimtypeSint64 = 20,
    wbemCimtypeUint64 = 21,
    wbemCimtypeReal32 = 4,
    wbemCimtypeReal64 = 5,
    wbemCimtypeBoolean = 11,
    wbemCimtypeString = 8,
    wbemCimtypeDatetime = 101,
    wbemCimtypeReference = 102,
    wbemCimtypeChar16 = 103,
    wbemCimtypeObject = 13,
}

enum WbemErrorEnum
{
    wbemNoErr = 0,
    wbemErrFailed = -2147217407,
    wbemErrNotFound = -2147217406,
    wbemErrAccessDenied = -2147217405,
    wbemErrProviderFailure = -2147217404,
    wbemErrTypeMismatch = -2147217403,
    wbemErrOutOfMemory = -2147217402,
    wbemErrInvalidContext = -2147217401,
    wbemErrInvalidParameter = -2147217400,
    wbemErrNotAvailable = -2147217399,
    wbemErrCriticalError = -2147217398,
    wbemErrInvalidStream = -2147217397,
    wbemErrNotSupported = -2147217396,
    wbemErrInvalidSuperclass = -2147217395,
    wbemErrInvalidNamespace = -2147217394,
    wbemErrInvalidObject = -2147217393,
    wbemErrInvalidClass = -2147217392,
    wbemErrProviderNotFound = -2147217391,
    wbemErrInvalidProviderRegistration = -2147217390,
    wbemErrProviderLoadFailure = -2147217389,
    wbemErrInitializationFailure = -2147217388,
    wbemErrTransportFailure = -2147217387,
    wbemErrInvalidOperation = -2147217386,
    wbemErrInvalidQuery = -2147217385,
    wbemErrInvalidQueryType = -2147217384,
    wbemErrAlreadyExists = -2147217383,
    wbemErrOverrideNotAllowed = -2147217382,
    wbemErrPropagatedQualifier = -2147217381,
    wbemErrPropagatedProperty = -2147217380,
    wbemErrUnexpected = -2147217379,
    wbemErrIllegalOperation = -2147217378,
    wbemErrCannotBeKey = -2147217377,
    wbemErrIncompleteClass = -2147217376,
    wbemErrInvalidSyntax = -2147217375,
    wbemErrNondecoratedObject = -2147217374,
    wbemErrReadOnly = -2147217373,
    wbemErrProviderNotCapable = -2147217372,
    wbemErrClassHasChildren = -2147217371,
    wbemErrClassHasInstances = -2147217370,
    wbemErrQueryNotImplemented = -2147217369,
    wbemErrIllegalNull = -2147217368,
    wbemErrInvalidQualifierType = -2147217367,
    wbemErrInvalidPropertyType = -2147217366,
    wbemErrValueOutOfRange = -2147217365,
    wbemErrCannotBeSingleton = -2147217364,
    wbemErrInvalidCimType = -2147217363,
    wbemErrInvalidMethod = -2147217362,
    wbemErrInvalidMethodParameters = -2147217361,
    wbemErrSystemProperty = -2147217360,
    wbemErrInvalidProperty = -2147217359,
    wbemErrCallCancelled = -2147217358,
    wbemErrShuttingDown = -2147217357,
    wbemErrPropagatedMethod = -2147217356,
    wbemErrUnsupportedParameter = -2147217355,
    wbemErrMissingParameter = -2147217354,
    wbemErrInvalidParameterId = -2147217353,
    wbemErrNonConsecutiveParameterIds = -2147217352,
    wbemErrParameterIdOnRetval = -2147217351,
    wbemErrInvalidObjectPath = -2147217350,
    wbemErrOutOfDiskSpace = -2147217349,
    wbemErrBufferTooSmall = -2147217348,
    wbemErrUnsupportedPutExtension = -2147217347,
    wbemErrUnknownObjectType = -2147217346,
    wbemErrUnknownPacketType = -2147217345,
    wbemErrMarshalVersionMismatch = -2147217344,
    wbemErrMarshalInvalidSignature = -2147217343,
    wbemErrInvalidQualifier = -2147217342,
    wbemErrInvalidDuplicateParameter = -2147217341,
    wbemErrTooMuchData = -2147217340,
    wbemErrServerTooBusy = -2147217339,
    wbemErrInvalidFlavor = -2147217338,
    wbemErrCircularReference = -2147217337,
    wbemErrUnsupportedClassUpdate = -2147217336,
    wbemErrCannotChangeKeyInheritance = -2147217335,
    wbemErrCannotChangeIndexInheritance = -2147217328,
    wbemErrTooManyProperties = -2147217327,
    wbemErrUpdateTypeMismatch = -2147217326,
    wbemErrUpdateOverrideNotAllowed = -2147217325,
    wbemErrUpdatePropagatedMethod = -2147217324,
    wbemErrMethodNotImplemented = -2147217323,
    wbemErrMethodDisabled = -2147217322,
    wbemErrRefresherBusy = -2147217321,
    wbemErrUnparsableQuery = -2147217320,
    wbemErrNotEventClass = -2147217319,
    wbemErrMissingGroupWithin = -2147217318,
    wbemErrMissingAggregationList = -2147217317,
    wbemErrPropertyNotAnObject = -2147217316,
    wbemErrAggregatingByObject = -2147217315,
    wbemErrUninterpretableProviderQuery = -2147217313,
    wbemErrBackupRestoreWinmgmtRunning = -2147217312,
    wbemErrQueueOverflow = -2147217311,
    wbemErrPrivilegeNotHeld = -2147217310,
    wbemErrInvalidOperator = -2147217309,
    wbemErrLocalCredentials = -2147217308,
    wbemErrCannotBeAbstract = -2147217307,
    wbemErrAmendedObject = -2147217306,
    wbemErrClientTooSlow = -2147217305,
    wbemErrNullSecurityDescriptor = -2147217304,
    wbemErrTimeout = -2147217303,
    wbemErrInvalidAssociation = -2147217302,
    wbemErrAmbiguousOperation = -2147217301,
    wbemErrQuotaViolation = -2147217300,
    wbemErrTransactionConflict = -2147217299,
    wbemErrForcedRollback = -2147217298,
    wbemErrUnsupportedLocale = -2147217297,
    wbemErrHandleOutOfDate = -2147217296,
    wbemErrConnectionFailed = -2147217295,
    wbemErrInvalidHandleRequest = -2147217294,
    wbemErrPropertyNameTooWide = -2147217293,
    wbemErrClassNameTooWide = -2147217292,
    wbemErrMethodNameTooWide = -2147217291,
    wbemErrQualifierNameTooWide = -2147217290,
    wbemErrRerunCommand = -2147217289,
    wbemErrDatabaseVerMismatch = -2147217288,
    wbemErrVetoPut = -2147217287,
    wbemErrVetoDelete = -2147217286,
    wbemErrInvalidLocale = -2147217280,
    wbemErrProviderSuspended = -2147217279,
    wbemErrSynchronizationRequired = -2147217278,
    wbemErrNoSchema = -2147217277,
    wbemErrProviderAlreadyRegistered = -2147217276,
    wbemErrProviderNotRegistered = -2147217275,
    wbemErrFatalTransportError = -2147217274,
    wbemErrEncryptedConnectionRequired = -2147217273,
    wbemErrRegistrationTooBroad = -2147213311,
    wbemErrRegistrationTooPrecise = -2147213310,
    wbemErrTimedout = -2147209215,
    wbemErrResetToDefault = -2147209214,
}

enum WbemAuthenticationLevelEnum
{
    wbemAuthenticationLevelDefault = 0,
    wbemAuthenticationLevelNone = 1,
    wbemAuthenticationLevelConnect = 2,
    wbemAuthenticationLevelCall = 3,
    wbemAuthenticationLevelPkt = 4,
    wbemAuthenticationLevelPktIntegrity = 5,
    wbemAuthenticationLevelPktPrivacy = 6,
}

enum WbemImpersonationLevelEnum
{
    wbemImpersonationLevelAnonymous = 1,
    wbemImpersonationLevelIdentify = 2,
    wbemImpersonationLevelImpersonate = 3,
    wbemImpersonationLevelDelegate = 4,
}

enum WbemPrivilegeEnum
{
    wbemPrivilegeCreateToken = 1,
    wbemPrivilegePrimaryToken = 2,
    wbemPrivilegeLockMemory = 3,
    wbemPrivilegeIncreaseQuota = 4,
    wbemPrivilegeMachineAccount = 5,
    wbemPrivilegeTcb = 6,
    wbemPrivilegeSecurity = 7,
    wbemPrivilegeTakeOwnership = 8,
    wbemPrivilegeLoadDriver = 9,
    wbemPrivilegeSystemProfile = 10,
    wbemPrivilegeSystemtime = 11,
    wbemPrivilegeProfileSingleProcess = 12,
    wbemPrivilegeIncreaseBasePriority = 13,
    wbemPrivilegeCreatePagefile = 14,
    wbemPrivilegeCreatePermanent = 15,
    wbemPrivilegeBackup = 16,
    wbemPrivilegeRestore = 17,
    wbemPrivilegeShutdown = 18,
    wbemPrivilegeDebug = 19,
    wbemPrivilegeAudit = 20,
    wbemPrivilegeSystemEnvironment = 21,
    wbemPrivilegeChangeNotify = 22,
    wbemPrivilegeRemoteShutdown = 23,
    wbemPrivilegeUndock = 24,
    wbemPrivilegeSyncAgent = 25,
    wbemPrivilegeEnableDelegation = 26,
    wbemPrivilegeManageVolume = 27,
}

enum WbemObjectTextFormatEnum
{
    wbemObjectTextFormatCIMDTD20 = 1,
    wbemObjectTextFormatWMIDTD20 = 2,
}

enum WbemConnectOptionsEnum
{
    wbemConnectFlagUseMaxWait = 128,
}

const GUID IID_ISWbemServices = {0x76A6415C, 0xCB41, 0x11D1, [0x8B, 0x02, 0x00, 0x60, 0x08, 0x06, 0xD9, 0xB6]};
@GUID(0x76A6415C, 0xCB41, 0x11D1, [0x8B, 0x02, 0x00, 0x60, 0x08, 0x06, 0xD9, 0xB6]);
interface ISWbemServices : IDispatch
{
    HRESULT Get(BSTR strObjectPath, int iFlags, IDispatch objWbemNamedValueSet, ISWbemObject* objWbemObject);
    HRESULT GetAsync(IDispatch objWbemSink, BSTR strObjectPath, int iFlags, IDispatch objWbemNamedValueSet, IDispatch objWbemAsyncContext);
    HRESULT Delete(BSTR strObjectPath, int iFlags, IDispatch objWbemNamedValueSet);
    HRESULT DeleteAsync(IDispatch objWbemSink, BSTR strObjectPath, int iFlags, IDispatch objWbemNamedValueSet, IDispatch objWbemAsyncContext);
    HRESULT InstancesOf(BSTR strClass, int iFlags, IDispatch objWbemNamedValueSet, ISWbemObjectSet* objWbemObjectSet);
    HRESULT InstancesOfAsync(IDispatch objWbemSink, BSTR strClass, int iFlags, IDispatch objWbemNamedValueSet, IDispatch objWbemAsyncContext);
    HRESULT SubclassesOf(BSTR strSuperclass, int iFlags, IDispatch objWbemNamedValueSet, ISWbemObjectSet* objWbemObjectSet);
    HRESULT SubclassesOfAsync(IDispatch objWbemSink, BSTR strSuperclass, int iFlags, IDispatch objWbemNamedValueSet, IDispatch objWbemAsyncContext);
    HRESULT ExecQuery(BSTR strQuery, BSTR strQueryLanguage, int iFlags, IDispatch objWbemNamedValueSet, ISWbemObjectSet* objWbemObjectSet);
    HRESULT ExecQueryAsync(IDispatch objWbemSink, BSTR strQuery, BSTR strQueryLanguage, int lFlags, IDispatch objWbemNamedValueSet, IDispatch objWbemAsyncContext);
    HRESULT AssociatorsOf(BSTR strObjectPath, BSTR strAssocClass, BSTR strResultClass, BSTR strResultRole, BSTR strRole, short bClassesOnly, short bSchemaOnly, BSTR strRequiredAssocQualifier, BSTR strRequiredQualifier, int iFlags, IDispatch objWbemNamedValueSet, ISWbemObjectSet* objWbemObjectSet);
    HRESULT AssociatorsOfAsync(IDispatch objWbemSink, BSTR strObjectPath, BSTR strAssocClass, BSTR strResultClass, BSTR strResultRole, BSTR strRole, short bClassesOnly, short bSchemaOnly, BSTR strRequiredAssocQualifier, BSTR strRequiredQualifier, int iFlags, IDispatch objWbemNamedValueSet, IDispatch objWbemAsyncContext);
    HRESULT ReferencesTo(BSTR strObjectPath, BSTR strResultClass, BSTR strRole, short bClassesOnly, short bSchemaOnly, BSTR strRequiredQualifier, int iFlags, IDispatch objWbemNamedValueSet, ISWbemObjectSet* objWbemObjectSet);
    HRESULT ReferencesToAsync(IDispatch objWbemSink, BSTR strObjectPath, BSTR strResultClass, BSTR strRole, short bClassesOnly, short bSchemaOnly, BSTR strRequiredQualifier, int iFlags, IDispatch objWbemNamedValueSet, IDispatch objWbemAsyncContext);
    HRESULT ExecNotificationQuery(BSTR strQuery, BSTR strQueryLanguage, int iFlags, IDispatch objWbemNamedValueSet, ISWbemEventSource* objWbemEventSource);
    HRESULT ExecNotificationQueryAsync(IDispatch objWbemSink, BSTR strQuery, BSTR strQueryLanguage, int iFlags, IDispatch objWbemNamedValueSet, IDispatch objWbemAsyncContext);
    HRESULT ExecMethod(BSTR strObjectPath, BSTR strMethodName, IDispatch objWbemInParameters, int iFlags, IDispatch objWbemNamedValueSet, ISWbemObject* objWbemOutParameters);
    HRESULT ExecMethodAsync(IDispatch objWbemSink, BSTR strObjectPath, BSTR strMethodName, IDispatch objWbemInParameters, int iFlags, IDispatch objWbemNamedValueSet, IDispatch objWbemAsyncContext);
    HRESULT get_Security_(ISWbemSecurity* objWbemSecurity);
}

const GUID IID_ISWbemLocator = {0x76A6415B, 0xCB41, 0x11D1, [0x8B, 0x02, 0x00, 0x60, 0x08, 0x06, 0xD9, 0xB6]};
@GUID(0x76A6415B, 0xCB41, 0x11D1, [0x8B, 0x02, 0x00, 0x60, 0x08, 0x06, 0xD9, 0xB6]);
interface ISWbemLocator : IDispatch
{
    HRESULT ConnectServer(BSTR strServer, BSTR strNamespace, BSTR strUser, BSTR strPassword, BSTR strLocale, BSTR strAuthority, int iSecurityFlags, IDispatch objWbemNamedValueSet, ISWbemServices* objWbemServices);
    HRESULT get_Security_(ISWbemSecurity* objWbemSecurity);
}

const GUID IID_ISWbemObject = {0x76A6415A, 0xCB41, 0x11D1, [0x8B, 0x02, 0x00, 0x60, 0x08, 0x06, 0xD9, 0xB6]};
@GUID(0x76A6415A, 0xCB41, 0x11D1, [0x8B, 0x02, 0x00, 0x60, 0x08, 0x06, 0xD9, 0xB6]);
interface ISWbemObject : IDispatch
{
    HRESULT Put_(int iFlags, IDispatch objWbemNamedValueSet, ISWbemObjectPath* objWbemObjectPath);
    HRESULT PutAsync_(IDispatch objWbemSink, int iFlags, IDispatch objWbemNamedValueSet, IDispatch objWbemAsyncContext);
    HRESULT Delete_(int iFlags, IDispatch objWbemNamedValueSet);
    HRESULT DeleteAsync_(IDispatch objWbemSink, int iFlags, IDispatch objWbemNamedValueSet, IDispatch objWbemAsyncContext);
    HRESULT Instances_(int iFlags, IDispatch objWbemNamedValueSet, ISWbemObjectSet* objWbemObjectSet);
    HRESULT InstancesAsync_(IDispatch objWbemSink, int iFlags, IDispatch objWbemNamedValueSet, IDispatch objWbemAsyncContext);
    HRESULT Subclasses_(int iFlags, IDispatch objWbemNamedValueSet, ISWbemObjectSet* objWbemObjectSet);
    HRESULT SubclassesAsync_(IDispatch objWbemSink, int iFlags, IDispatch objWbemNamedValueSet, IDispatch objWbemAsyncContext);
    HRESULT Associators_(BSTR strAssocClass, BSTR strResultClass, BSTR strResultRole, BSTR strRole, short bClassesOnly, short bSchemaOnly, BSTR strRequiredAssocQualifier, BSTR strRequiredQualifier, int iFlags, IDispatch objWbemNamedValueSet, ISWbemObjectSet* objWbemObjectSet);
    HRESULT AssociatorsAsync_(IDispatch objWbemSink, BSTR strAssocClass, BSTR strResultClass, BSTR strResultRole, BSTR strRole, short bClassesOnly, short bSchemaOnly, BSTR strRequiredAssocQualifier, BSTR strRequiredQualifier, int iFlags, IDispatch objWbemNamedValueSet, IDispatch objWbemAsyncContext);
    HRESULT References_(BSTR strResultClass, BSTR strRole, short bClassesOnly, short bSchemaOnly, BSTR strRequiredQualifier, int iFlags, IDispatch objWbemNamedValueSet, ISWbemObjectSet* objWbemObjectSet);
    HRESULT ReferencesAsync_(IDispatch objWbemSink, BSTR strResultClass, BSTR strRole, short bClassesOnly, short bSchemaOnly, BSTR strRequiredQualifier, int iFlags, IDispatch objWbemNamedValueSet, IDispatch objWbemAsyncContext);
    HRESULT ExecMethod_(BSTR strMethodName, IDispatch objWbemInParameters, int iFlags, IDispatch objWbemNamedValueSet, ISWbemObject* objWbemOutParameters);
    HRESULT ExecMethodAsync_(IDispatch objWbemSink, BSTR strMethodName, IDispatch objWbemInParameters, int iFlags, IDispatch objWbemNamedValueSet, IDispatch objWbemAsyncContext);
    HRESULT Clone_(ISWbemObject* objWbemObject);
    HRESULT GetObjectText_(int iFlags, BSTR* strObjectText);
    HRESULT SpawnDerivedClass_(int iFlags, ISWbemObject* objWbemObject);
    HRESULT SpawnInstance_(int iFlags, ISWbemObject* objWbemObject);
    HRESULT CompareTo_(IDispatch objWbemObject, int iFlags, short* bResult);
    HRESULT get_Qualifiers_(ISWbemQualifierSet* objWbemQualifierSet);
    HRESULT get_Properties_(ISWbemPropertySet* objWbemPropertySet);
    HRESULT get_Methods_(ISWbemMethodSet* objWbemMethodSet);
    HRESULT get_Derivation_(VARIANT* strClassNameArray);
    HRESULT get_Path_(ISWbemObjectPath* objWbemObjectPath);
    HRESULT get_Security_(ISWbemSecurity* objWbemSecurity);
}

const GUID IID_ISWbemObjectSet = {0x76A6415F, 0xCB41, 0x11D1, [0x8B, 0x02, 0x00, 0x60, 0x08, 0x06, 0xD9, 0xB6]};
@GUID(0x76A6415F, 0xCB41, 0x11D1, [0x8B, 0x02, 0x00, 0x60, 0x08, 0x06, 0xD9, 0xB6]);
interface ISWbemObjectSet : IDispatch
{
    HRESULT get__NewEnum(IUnknown* pUnk);
    HRESULT Item(BSTR strObjectPath, int iFlags, ISWbemObject* objWbemObject);
    HRESULT get_Count(int* iCount);
    HRESULT get_Security_(ISWbemSecurity* objWbemSecurity);
    HRESULT ItemIndex(int lIndex, ISWbemObject* objWbemObject);
}

const GUID IID_ISWbemNamedValue = {0x76A64164, 0xCB41, 0x11D1, [0x8B, 0x02, 0x00, 0x60, 0x08, 0x06, 0xD9, 0xB6]};
@GUID(0x76A64164, 0xCB41, 0x11D1, [0x8B, 0x02, 0x00, 0x60, 0x08, 0x06, 0xD9, 0xB6]);
interface ISWbemNamedValue : IDispatch
{
    HRESULT get_Value(VARIANT* varValue);
    HRESULT put_Value(VARIANT* varValue);
    HRESULT get_Name(BSTR* strName);
}

const GUID IID_ISWbemNamedValueSet = {0xCF2376EA, 0xCE8C, 0x11D1, [0x8B, 0x05, 0x00, 0x60, 0x08, 0x06, 0xD9, 0xB6]};
@GUID(0xCF2376EA, 0xCE8C, 0x11D1, [0x8B, 0x05, 0x00, 0x60, 0x08, 0x06, 0xD9, 0xB6]);
interface ISWbemNamedValueSet : IDispatch
{
    HRESULT get__NewEnum(IUnknown* pUnk);
    HRESULT Item(BSTR strName, int iFlags, ISWbemNamedValue* objWbemNamedValue);
    HRESULT get_Count(int* iCount);
    HRESULT Add(BSTR strName, VARIANT* varValue, int iFlags, ISWbemNamedValue* objWbemNamedValue);
    HRESULT Remove(BSTR strName, int iFlags);
    HRESULT Clone(ISWbemNamedValueSet* objWbemNamedValueSet);
    HRESULT DeleteAll();
}

const GUID IID_ISWbemQualifier = {0x79B05932, 0xD3B7, 0x11D1, [0x8B, 0x06, 0x00, 0x60, 0x08, 0x06, 0xD9, 0xB6]};
@GUID(0x79B05932, 0xD3B7, 0x11D1, [0x8B, 0x06, 0x00, 0x60, 0x08, 0x06, 0xD9, 0xB6]);
interface ISWbemQualifier : IDispatch
{
    HRESULT get_Value(VARIANT* varValue);
    HRESULT put_Value(VARIANT* varValue);
    HRESULT get_Name(BSTR* strName);
    HRESULT get_IsLocal(short* bIsLocal);
    HRESULT get_PropagatesToSubclass(short* bPropagatesToSubclass);
    HRESULT put_PropagatesToSubclass(short bPropagatesToSubclass);
    HRESULT get_PropagatesToInstance(short* bPropagatesToInstance);
    HRESULT put_PropagatesToInstance(short bPropagatesToInstance);
    HRESULT get_IsOverridable(short* bIsOverridable);
    HRESULT put_IsOverridable(short bIsOverridable);
    HRESULT get_IsAmended(short* bIsAmended);
}

const GUID IID_ISWbemQualifierSet = {0x9B16ED16, 0xD3DF, 0x11D1, [0x8B, 0x08, 0x00, 0x60, 0x08, 0x06, 0xD9, 0xB6]};
@GUID(0x9B16ED16, 0xD3DF, 0x11D1, [0x8B, 0x08, 0x00, 0x60, 0x08, 0x06, 0xD9, 0xB6]);
interface ISWbemQualifierSet : IDispatch
{
    HRESULT get__NewEnum(IUnknown* pUnk);
    HRESULT Item(BSTR name, int iFlags, ISWbemQualifier* objWbemQualifier);
    HRESULT get_Count(int* iCount);
    HRESULT Add(BSTR strName, VARIANT* varVal, short bPropagatesToSubclass, short bPropagatesToInstance, short bIsOverridable, int iFlags, ISWbemQualifier* objWbemQualifier);
    HRESULT Remove(BSTR strName, int iFlags);
}

const GUID IID_ISWbemProperty = {0x1A388F98, 0xD4BA, 0x11D1, [0x8B, 0x09, 0x00, 0x60, 0x08, 0x06, 0xD9, 0xB6]};
@GUID(0x1A388F98, 0xD4BA, 0x11D1, [0x8B, 0x09, 0x00, 0x60, 0x08, 0x06, 0xD9, 0xB6]);
interface ISWbemProperty : IDispatch
{
    HRESULT get_Value(VARIANT* varValue);
    HRESULT put_Value(VARIANT* varValue);
    HRESULT get_Name(BSTR* strName);
    HRESULT get_IsLocal(short* bIsLocal);
    HRESULT get_Origin(BSTR* strOrigin);
    HRESULT get_CIMType(WbemCimtypeEnum* iCimType);
    HRESULT get_Qualifiers_(ISWbemQualifierSet* objWbemQualifierSet);
    HRESULT get_IsArray(short* bIsArray);
}

const GUID IID_ISWbemPropertySet = {0xDEA0A7B2, 0xD4BA, 0x11D1, [0x8B, 0x09, 0x00, 0x60, 0x08, 0x06, 0xD9, 0xB6]};
@GUID(0xDEA0A7B2, 0xD4BA, 0x11D1, [0x8B, 0x09, 0x00, 0x60, 0x08, 0x06, 0xD9, 0xB6]);
interface ISWbemPropertySet : IDispatch
{
    HRESULT get__NewEnum(IUnknown* pUnk);
    HRESULT Item(BSTR strName, int iFlags, ISWbemProperty* objWbemProperty);
    HRESULT get_Count(int* iCount);
    HRESULT Add(BSTR strName, WbemCimtypeEnum iCIMType, short bIsArray, int iFlags, ISWbemProperty* objWbemProperty);
    HRESULT Remove(BSTR strName, int iFlags);
}

const GUID IID_ISWbemMethod = {0x422E8E90, 0xD955, 0x11D1, [0x8B, 0x09, 0x00, 0x60, 0x08, 0x06, 0xD9, 0xB6]};
@GUID(0x422E8E90, 0xD955, 0x11D1, [0x8B, 0x09, 0x00, 0x60, 0x08, 0x06, 0xD9, 0xB6]);
interface ISWbemMethod : IDispatch
{
    HRESULT get_Name(BSTR* strName);
    HRESULT get_Origin(BSTR* strOrigin);
    HRESULT get_InParameters(ISWbemObject* objWbemInParameters);
    HRESULT get_OutParameters(ISWbemObject* objWbemOutParameters);
    HRESULT get_Qualifiers_(ISWbemQualifierSet* objWbemQualifierSet);
}

const GUID IID_ISWbemMethodSet = {0xC93BA292, 0xD955, 0x11D1, [0x8B, 0x09, 0x00, 0x60, 0x08, 0x06, 0xD9, 0xB6]};
@GUID(0xC93BA292, 0xD955, 0x11D1, [0x8B, 0x09, 0x00, 0x60, 0x08, 0x06, 0xD9, 0xB6]);
interface ISWbemMethodSet : IDispatch
{
    HRESULT get__NewEnum(IUnknown* pUnk);
    HRESULT Item(BSTR strName, int iFlags, ISWbemMethod* objWbemMethod);
    HRESULT get_Count(int* iCount);
}

const GUID IID_ISWbemEventSource = {0x27D54D92, 0x0EBE, 0x11D2, [0x8B, 0x22, 0x00, 0x60, 0x08, 0x06, 0xD9, 0xB6]};
@GUID(0x27D54D92, 0x0EBE, 0x11D2, [0x8B, 0x22, 0x00, 0x60, 0x08, 0x06, 0xD9, 0xB6]);
interface ISWbemEventSource : IDispatch
{
    HRESULT NextEvent(int iTimeoutMs, ISWbemObject* objWbemObject);
    HRESULT get_Security_(ISWbemSecurity* objWbemSecurity);
}

const GUID IID_ISWbemObjectPath = {0x5791BC27, 0xCE9C, 0x11D1, [0x97, 0xBF, 0x00, 0x00, 0xF8, 0x1E, 0x84, 0x9C]};
@GUID(0x5791BC27, 0xCE9C, 0x11D1, [0x97, 0xBF, 0x00, 0x00, 0xF8, 0x1E, 0x84, 0x9C]);
interface ISWbemObjectPath : IDispatch
{
    HRESULT get_Path(BSTR* strPath);
    HRESULT put_Path(BSTR strPath);
    HRESULT get_RelPath(BSTR* strRelPath);
    HRESULT put_RelPath(BSTR strRelPath);
    HRESULT get_Server(BSTR* strServer);
    HRESULT put_Server(BSTR strServer);
    HRESULT get_Namespace(BSTR* strNamespace);
    HRESULT put_Namespace(BSTR strNamespace);
    HRESULT get_ParentNamespace(BSTR* strParentNamespace);
    HRESULT get_DisplayName(BSTR* strDisplayName);
    HRESULT put_DisplayName(BSTR strDisplayName);
    HRESULT get_Class(BSTR* strClass);
    HRESULT put_Class(BSTR strClass);
    HRESULT get_IsClass(short* bIsClass);
    HRESULT SetAsClass();
    HRESULT get_IsSingleton(short* bIsSingleton);
    HRESULT SetAsSingleton();
    HRESULT get_Keys(ISWbemNamedValueSet* objWbemNamedValueSet);
    HRESULT get_Security_(ISWbemSecurity* objWbemSecurity);
    HRESULT get_Locale(BSTR* strLocale);
    HRESULT put_Locale(BSTR strLocale);
    HRESULT get_Authority(BSTR* strAuthority);
    HRESULT put_Authority(BSTR strAuthority);
}

const GUID IID_ISWbemLastError = {0xD962DB84, 0xD4BB, 0x11D1, [0x8B, 0x09, 0x00, 0x60, 0x08, 0x06, 0xD9, 0xB6]};
@GUID(0xD962DB84, 0xD4BB, 0x11D1, [0x8B, 0x09, 0x00, 0x60, 0x08, 0x06, 0xD9, 0xB6]);
interface ISWbemLastError : ISWbemObject
{
}

const GUID IID_ISWbemSinkEvents = {0x75718CA0, 0xF029, 0x11D1, [0xA1, 0xAC, 0x00, 0xC0, 0x4F, 0xB6, 0xC2, 0x23]};
@GUID(0x75718CA0, 0xF029, 0x11D1, [0xA1, 0xAC, 0x00, 0xC0, 0x4F, 0xB6, 0xC2, 0x23]);
interface ISWbemSinkEvents : IDispatch
{
}

const GUID IID_ISWbemSink = {0x75718C9F, 0xF029, 0x11D1, [0xA1, 0xAC, 0x00, 0xC0, 0x4F, 0xB6, 0xC2, 0x23]};
@GUID(0x75718C9F, 0xF029, 0x11D1, [0xA1, 0xAC, 0x00, 0xC0, 0x4F, 0xB6, 0xC2, 0x23]);
interface ISWbemSink : IDispatch
{
    HRESULT Cancel();
}

const GUID IID_ISWbemSecurity = {0xB54D66E6, 0x2287, 0x11D2, [0x8B, 0x33, 0x00, 0x60, 0x08, 0x06, 0xD9, 0xB6]};
@GUID(0xB54D66E6, 0x2287, 0x11D2, [0x8B, 0x33, 0x00, 0x60, 0x08, 0x06, 0xD9, 0xB6]);
interface ISWbemSecurity : IDispatch
{
    HRESULT get_ImpersonationLevel(WbemImpersonationLevelEnum* iImpersonationLevel);
    HRESULT put_ImpersonationLevel(WbemImpersonationLevelEnum iImpersonationLevel);
    HRESULT get_AuthenticationLevel(WbemAuthenticationLevelEnum* iAuthenticationLevel);
    HRESULT put_AuthenticationLevel(WbemAuthenticationLevelEnum iAuthenticationLevel);
    HRESULT get_Privileges(ISWbemPrivilegeSet* objWbemPrivilegeSet);
}

const GUID IID_ISWbemPrivilege = {0x26EE67BD, 0x5804, 0x11D2, [0x8B, 0x4A, 0x00, 0x60, 0x08, 0x06, 0xD9, 0xB6]};
@GUID(0x26EE67BD, 0x5804, 0x11D2, [0x8B, 0x4A, 0x00, 0x60, 0x08, 0x06, 0xD9, 0xB6]);
interface ISWbemPrivilege : IDispatch
{
    HRESULT get_IsEnabled(short* bIsEnabled);
    HRESULT put_IsEnabled(short bIsEnabled);
    HRESULT get_Name(BSTR* strDisplayName);
    HRESULT get_DisplayName(BSTR* strDisplayName);
    HRESULT get_Identifier(WbemPrivilegeEnum* iPrivilege);
}

const GUID IID_ISWbemPrivilegeSet = {0x26EE67BF, 0x5804, 0x11D2, [0x8B, 0x4A, 0x00, 0x60, 0x08, 0x06, 0xD9, 0xB6]};
@GUID(0x26EE67BF, 0x5804, 0x11D2, [0x8B, 0x4A, 0x00, 0x60, 0x08, 0x06, 0xD9, 0xB6]);
interface ISWbemPrivilegeSet : IDispatch
{
    HRESULT get__NewEnum(IUnknown* pUnk);
    HRESULT Item(WbemPrivilegeEnum iPrivilege, ISWbemPrivilege* objWbemPrivilege);
    HRESULT get_Count(int* iCount);
    HRESULT Add(WbemPrivilegeEnum iPrivilege, short bIsEnabled, ISWbemPrivilege* objWbemPrivilege);
    HRESULT Remove(WbemPrivilegeEnum iPrivilege);
    HRESULT DeleteAll();
    HRESULT AddAsString(BSTR strPrivilege, short bIsEnabled, ISWbemPrivilege* objWbemPrivilege);
}

const GUID IID_ISWbemServicesEx = {0xD2F68443, 0x85DC, 0x427E, [0x91, 0xD8, 0x36, 0x65, 0x54, 0xCC, 0x75, 0x4C]};
@GUID(0xD2F68443, 0x85DC, 0x427E, [0x91, 0xD8, 0x36, 0x65, 0x54, 0xCC, 0x75, 0x4C]);
interface ISWbemServicesEx : ISWbemServices
{
    HRESULT Put(ISWbemObjectEx objWbemObject, int iFlags, IDispatch objWbemNamedValueSet, ISWbemObjectPath* objWbemObjectPath);
    HRESULT PutAsync(ISWbemSink objWbemSink, ISWbemObjectEx objWbemObject, int iFlags, IDispatch objWbemNamedValueSet, IDispatch objWbemAsyncContext);
}

const GUID IID_ISWbemObjectEx = {0x269AD56A, 0x8A67, 0x4129, [0xBC, 0x8C, 0x05, 0x06, 0xDC, 0xFE, 0x98, 0x80]};
@GUID(0x269AD56A, 0x8A67, 0x4129, [0xBC, 0x8C, 0x05, 0x06, 0xDC, 0xFE, 0x98, 0x80]);
interface ISWbemObjectEx : ISWbemObject
{
    HRESULT Refresh_(int iFlags, IDispatch objWbemNamedValueSet);
    HRESULT get_SystemProperties_(ISWbemPropertySet* objWbemPropertySet);
    HRESULT GetText_(WbemObjectTextFormatEnum iObjectTextFormat, int iFlags, IDispatch objWbemNamedValueSet, BSTR* bsText);
    HRESULT SetFromText_(BSTR bsText, WbemObjectTextFormatEnum iObjectTextFormat, int iFlags, IDispatch objWbemNamedValueSet);
}

const GUID IID_ISWbemDateTime = {0x5E97458A, 0xCF77, 0x11D3, [0xB3, 0x8F, 0x00, 0x10, 0x5A, 0x1F, 0x47, 0x3A]};
@GUID(0x5E97458A, 0xCF77, 0x11D3, [0xB3, 0x8F, 0x00, 0x10, 0x5A, 0x1F, 0x47, 0x3A]);
interface ISWbemDateTime : IDispatch
{
    HRESULT get_Value(BSTR* strValue);
    HRESULT put_Value(BSTR strValue);
    HRESULT get_Year(int* iYear);
    HRESULT put_Year(int iYear);
    HRESULT get_YearSpecified(short* bYearSpecified);
    HRESULT put_YearSpecified(short bYearSpecified);
    HRESULT get_Month(int* iMonth);
    HRESULT put_Month(int iMonth);
    HRESULT get_MonthSpecified(short* bMonthSpecified);
    HRESULT put_MonthSpecified(short bMonthSpecified);
    HRESULT get_Day(int* iDay);
    HRESULT put_Day(int iDay);
    HRESULT get_DaySpecified(short* bDaySpecified);
    HRESULT put_DaySpecified(short bDaySpecified);
    HRESULT get_Hours(int* iHours);
    HRESULT put_Hours(int iHours);
    HRESULT get_HoursSpecified(short* bHoursSpecified);
    HRESULT put_HoursSpecified(short bHoursSpecified);
    HRESULT get_Minutes(int* iMinutes);
    HRESULT put_Minutes(int iMinutes);
    HRESULT get_MinutesSpecified(short* bMinutesSpecified);
    HRESULT put_MinutesSpecified(short bMinutesSpecified);
    HRESULT get_Seconds(int* iSeconds);
    HRESULT put_Seconds(int iSeconds);
    HRESULT get_SecondsSpecified(short* bSecondsSpecified);
    HRESULT put_SecondsSpecified(short bSecondsSpecified);
    HRESULT get_Microseconds(int* iMicroseconds);
    HRESULT put_Microseconds(int iMicroseconds);
    HRESULT get_MicrosecondsSpecified(short* bMicrosecondsSpecified);
    HRESULT put_MicrosecondsSpecified(short bMicrosecondsSpecified);
    HRESULT get_UTC(int* iUTC);
    HRESULT put_UTC(int iUTC);
    HRESULT get_UTCSpecified(short* bUTCSpecified);
    HRESULT put_UTCSpecified(short bUTCSpecified);
    HRESULT get_IsInterval(short* bIsInterval);
    HRESULT put_IsInterval(short bIsInterval);
    HRESULT GetVarDate(short bIsLocal, double* dVarDate);
    HRESULT SetVarDate(double dVarDate, short bIsLocal);
    HRESULT GetFileTime(short bIsLocal, BSTR* strFileTime);
    HRESULT SetFileTime(BSTR strFileTime, short bIsLocal);
}

const GUID IID_ISWbemRefresher = {0x14D8250E, 0xD9C2, 0x11D3, [0xB3, 0x8F, 0x00, 0x10, 0x5A, 0x1F, 0x47, 0x3A]};
@GUID(0x14D8250E, 0xD9C2, 0x11D3, [0xB3, 0x8F, 0x00, 0x10, 0x5A, 0x1F, 0x47, 0x3A]);
interface ISWbemRefresher : IDispatch
{
    HRESULT get__NewEnum(IUnknown* pUnk);
    HRESULT Item(int iIndex, ISWbemRefreshableItem* objWbemRefreshableItem);
    HRESULT get_Count(int* iCount);
    HRESULT Add(ISWbemServicesEx objWbemServices, BSTR bsInstancePath, int iFlags, IDispatch objWbemNamedValueSet, ISWbemRefreshableItem* objWbemRefreshableItem);
    HRESULT AddEnum(ISWbemServicesEx objWbemServices, BSTR bsClassName, int iFlags, IDispatch objWbemNamedValueSet, ISWbemRefreshableItem* objWbemRefreshableItem);
    HRESULT Remove(int iIndex, int iFlags);
    HRESULT Refresh(int iFlags);
    HRESULT get_AutoReconnect(short* bCount);
    HRESULT put_AutoReconnect(short bCount);
    HRESULT DeleteAll();
}

const GUID IID_ISWbemRefreshableItem = {0x5AD4BF92, 0xDAAB, 0x11D3, [0xB3, 0x8F, 0x00, 0x10, 0x5A, 0x1F, 0x47, 0x3A]};
@GUID(0x5AD4BF92, 0xDAAB, 0x11D3, [0xB3, 0x8F, 0x00, 0x10, 0x5A, 0x1F, 0x47, 0x3A]);
interface ISWbemRefreshableItem : IDispatch
{
    HRESULT get_Index(int* iIndex);
    HRESULT get_Refresher(ISWbemRefresher* objWbemRefresher);
    HRESULT get_IsSet(short* bIsSet);
    HRESULT get_Object(ISWbemObjectEx* objWbemObject);
    HRESULT get_ObjectSet(ISWbemObjectSet* objWbemObjectSet);
    HRESULT Remove(int iFlags);
}

