module windows.search;

public import system;
public import windows.automation;
public import windows.com;
public import windows.componentservices;
public import windows.indexserver;
public import windows.security;
public import windows.shell;
public import windows.structuredstorage;
public import windows.systemservices;
public import windows.winsock;
public import windows.windowsandmessaging;
public import windows.windowsprogramming;
public import windows.windowspropertiessystem;

extern(Windows):

const GUID IID_IWordSink = {0xCC907054, 0xC058, 0x101A, [0xB5, 0x54, 0x08, 0x00, 0x2B, 0x33, 0xB0, 0xE6]};
@GUID(0xCC907054, 0xC058, 0x101A, [0xB5, 0x54, 0x08, 0x00, 0x2B, 0x33, 0xB0, 0xE6]);
interface IWordSink : IUnknown
{
    HRESULT PutWord(uint cwc, const(wchar)* pwcInBuf, uint cwcSrcLen, uint cwcSrcPos);
    HRESULT PutAltWord(uint cwc, const(wchar)* pwcInBuf, uint cwcSrcLen, uint cwcSrcPos);
    HRESULT StartAltPhrase();
    HRESULT EndAltPhrase();
    HRESULT PutBreak(WORDREP_BREAK_TYPE breakType);
}

alias PFNFILLTEXTBUFFER = extern(Windows) HRESULT function(TEXT_SOURCE* pTextSource);
struct TEXT_SOURCE
{
    PFNFILLTEXTBUFFER pfnFillTextBuffer;
    const(wchar)* awcBuffer;
    uint iEnd;
    uint iCur;
}

const GUID IID_IWordBreaker = {0xD53552C8, 0x77E3, 0x101A, [0xB5, 0x52, 0x08, 0x00, 0x2B, 0x33, 0xB0, 0xE6]};
@GUID(0xD53552C8, 0x77E3, 0x101A, [0xB5, 0x52, 0x08, 0x00, 0x2B, 0x33, 0xB0, 0xE6]);
interface IWordBreaker : IUnknown
{
    HRESULT Init(BOOL fQuery, uint ulMaxTokenSize, int* pfLicense);
    HRESULT BreakText(TEXT_SOURCE* pTextSource, IWordSink pWordSink, IPhraseSink pPhraseSink);
    HRESULT ComposePhrase(const(wchar)* pwcNoun, uint cwcNoun, const(wchar)* pwcModifier, uint cwcModifier, uint ulAttachmentType, ushort* pwcPhrase, uint* pcwcPhrase);
    HRESULT GetLicenseToUse(const(ushort)** ppwcsLicense);
}

const GUID IID_IWordFormSink = {0xFE77C330, 0x7F42, 0x11CE, [0xBE, 0x57, 0x00, 0xAA, 0x00, 0x51, 0xFE, 0x20]};
@GUID(0xFE77C330, 0x7F42, 0x11CE, [0xBE, 0x57, 0x00, 0xAA, 0x00, 0x51, 0xFE, 0x20]);
interface IWordFormSink : IUnknown
{
    HRESULT PutAltWord(const(wchar)* pwcInBuf, uint cwc);
    HRESULT PutWord(const(wchar)* pwcInBuf, uint cwc);
}

const GUID IID_IStemmer = {0xEFBAF140, 0x7F42, 0x11CE, [0xBE, 0x57, 0x00, 0xAA, 0x00, 0x51, 0xFE, 0x20]};
@GUID(0xEFBAF140, 0x7F42, 0x11CE, [0xBE, 0x57, 0x00, 0xAA, 0x00, 0x51, 0xFE, 0x20]);
interface IStemmer : IUnknown
{
    HRESULT Init(uint ulMaxTokenSize, int* pfLicense);
    HRESULT GenerateWordForms(const(wchar)* pwcInBuf, uint cwc, IWordFormSink pStemSink);
    HRESULT GetLicenseToUse(const(ushort)** ppwcsLicense);
}

const GUID IID_ISimpleCommandCreator = {0x5E341AB7, 0x02D0, 0x11D1, [0x90, 0x0C, 0x00, 0xA0, 0xC9, 0x06, 0x37, 0x96]};
@GUID(0x5E341AB7, 0x02D0, 0x11D1, [0x90, 0x0C, 0x00, 0xA0, 0xC9, 0x06, 0x37, 0x96]);
interface ISimpleCommandCreator : IUnknown
{
    HRESULT CreateICommand(IUnknown* ppIUnknown, IUnknown pOuterUnk);
    HRESULT VerifyCatalog(const(wchar)* pwszMachine, const(wchar)* pwszCatalogName);
    HRESULT GetDefaultCatalog(ushort* pwszCatalogName, uint cwcIn, uint* pcwcOut);
}

const GUID IID_IColumnMapper = {0x0B63E37A, 0x9CCC, 0x11D0, [0xBC, 0xDB, 0x00, 0x80, 0x5F, 0xCC, 0xCE, 0x04]};
@GUID(0x0B63E37A, 0x9CCC, 0x11D0, [0xBC, 0xDB, 0x00, 0x80, 0x5F, 0xCC, 0xCE, 0x04]);
interface IColumnMapper : IUnknown
{
    HRESULT GetPropInfoFromName(const(wchar)* wcsPropName, DBID** ppPropId, ushort* pPropType, uint* puiWidth);
    HRESULT GetPropInfoFromId(const(DBID)* pPropId, ushort** pwcsName, ushort* pPropType, uint* puiWidth);
    HRESULT EnumPropInfo(uint iEntry, const(ushort)** pwcsName, DBID** ppPropId, ushort* pPropType, uint* puiWidth);
    HRESULT IsMapUpToDate();
}

const GUID IID_IColumnMapperCreator = {0x0B63E37B, 0x9CCC, 0x11D0, [0xBC, 0xDB, 0x00, 0x80, 0x5F, 0xCC, 0xCE, 0x04]};
@GUID(0x0B63E37B, 0x9CCC, 0x11D0, [0xBC, 0xDB, 0x00, 0x80, 0x5F, 0xCC, 0xCE, 0x04]);
interface IColumnMapperCreator : IUnknown
{
    HRESULT GetColumnMapper(const(wchar)* wcsMachineName, const(wchar)* wcsCatalogName, IColumnMapper* ppColumnMapper);
}

const GUID CLSID_CSearchManager = {0x7D096C5F, 0xAC08, 0x4F1F, [0xBE, 0xB7, 0x5C, 0x22, 0xC5, 0x17, 0xCE, 0x39]};
@GUID(0x7D096C5F, 0xAC08, 0x4F1F, [0xBE, 0xB7, 0x5C, 0x22, 0xC5, 0x17, 0xCE, 0x39]);
struct CSearchManager;

const GUID CLSID_CSearchRoot = {0x30766BD2, 0xEA1C, 0x4F28, [0xBF, 0x27, 0x0B, 0x44, 0xE2, 0xF6, 0x8D, 0xB7]};
@GUID(0x30766BD2, 0xEA1C, 0x4F28, [0xBF, 0x27, 0x0B, 0x44, 0xE2, 0xF6, 0x8D, 0xB7]);
struct CSearchRoot;

const GUID CLSID_CSearchScopeRule = {0xE63DE750, 0x3BD7, 0x4BE5, [0x9C, 0x84, 0x6B, 0x42, 0x81, 0x98, 0x8C, 0x44]};
@GUID(0xE63DE750, 0x3BD7, 0x4BE5, [0x9C, 0x84, 0x6B, 0x42, 0x81, 0x98, 0x8C, 0x44]);
struct CSearchScopeRule;

const GUID CLSID_FilterRegistration = {0x9E175B8D, 0xF52A, 0x11D8, [0xB9, 0xA5, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]};
@GUID(0x9E175B8D, 0xF52A, 0x11D8, [0xB9, 0xA5, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]);
struct FilterRegistration;

struct FILTERED_DATA_SOURCES
{
    const(wchar)* pwcsExtension;
    const(wchar)* pwcsMime;
    const(Guid)* pClsid;
    const(wchar)* pwcsOverride;
}

const GUID IID_ILoadFilter = {0xC7310722, 0xAC80, 0x11D1, [0x8D, 0xF3, 0x00, 0xC0, 0x4F, 0xB6, 0xEF, 0x4F]};
@GUID(0xC7310722, 0xAC80, 0x11D1, [0x8D, 0xF3, 0x00, 0xC0, 0x4F, 0xB6, 0xEF, 0x4F]);
interface ILoadFilter : IUnknown
{
    HRESULT LoadIFilter(const(wchar)* pwcsPath, FILTERED_DATA_SOURCES* pFilteredSources, IUnknown pUnkOuter, BOOL fUseDefault, Guid* pFilterClsid, int* SearchDecSize, char* pwcsSearchDesc, IFilter* ppIFilt);
    HRESULT LoadIFilterFromStorage(IStorage pStg, IUnknown pUnkOuter, const(wchar)* pwcsOverride, BOOL fUseDefault, Guid* pFilterClsid, int* SearchDecSize, char* pwcsSearchDesc, IFilter* ppIFilt);
    HRESULT LoadIFilterFromStream(IStream pStm, FILTERED_DATA_SOURCES* pFilteredSources, IUnknown pUnkOuter, BOOL fUseDefault, Guid* pFilterClsid, int* SearchDecSize, char* pwcsSearchDesc, IFilter* ppIFilt);
}

const GUID IID_ILoadFilterWithPrivateComActivation = {0x40BDBD34, 0x780B, 0x48D3, [0x9B, 0xB6, 0x12, 0xEB, 0xD4, 0xAD, 0x2E, 0x75]};
@GUID(0x40BDBD34, 0x780B, 0x48D3, [0x9B, 0xB6, 0x12, 0xEB, 0xD4, 0xAD, 0x2E, 0x75]);
interface ILoadFilterWithPrivateComActivation : ILoadFilter
{
    HRESULT LoadIFilterWithPrivateComActivation(FILTERED_DATA_SOURCES* filteredSources, BOOL useDefault, Guid* filterClsid, int* isFilterPrivateComActivated, IFilter* filterObj);
}

enum CONDITION_TYPE
{
    CT_AND_CONDITION = 0,
    CT_OR_CONDITION = 1,
    CT_NOT_CONDITION = 2,
    CT_LEAF_CONDITION = 3,
}

enum CONDITION_OPERATION
{
    COP_IMPLICIT = 0,
    COP_EQUAL = 1,
    COP_NOTEQUAL = 2,
    COP_LESSTHAN = 3,
    COP_GREATERTHAN = 4,
    COP_LESSTHANOREQUAL = 5,
    COP_GREATERTHANOREQUAL = 6,
    COP_VALUE_STARTSWITH = 7,
    COP_VALUE_ENDSWITH = 8,
    COP_VALUE_CONTAINS = 9,
    COP_VALUE_NOTCONTAINS = 10,
    COP_DOSWILDCARDS = 11,
    COP_WORD_EQUAL = 12,
    COP_WORD_STARTSWITH = 13,
    COP_APPLICATION_SPECIFIC = 14,
}

const GUID IID_IRichChunk = {0x4FDEF69C, 0xDBC9, 0x454E, [0x99, 0x10, 0xB3, 0x4F, 0x3C, 0x64, 0xB5, 0x10]};
@GUID(0x4FDEF69C, 0xDBC9, 0x454E, [0x99, 0x10, 0xB3, 0x4F, 0x3C, 0x64, 0xB5, 0x10]);
interface IRichChunk : IUnknown
{
    HRESULT GetData(uint* pFirstPos, uint* pLength, ushort** ppsz, PROPVARIANT* pValue);
}

const GUID IID_ICondition = {0x0FC988D4, 0xC935, 0x4B97, [0xA9, 0x73, 0x46, 0x28, 0x2E, 0xA1, 0x75, 0xC8]};
@GUID(0x0FC988D4, 0xC935, 0x4B97, [0xA9, 0x73, 0x46, 0x28, 0x2E, 0xA1, 0x75, 0xC8]);
interface ICondition : IPersistStream
{
    HRESULT GetConditionType(CONDITION_TYPE* pNodeType);
    HRESULT GetSubConditions(const(Guid)* riid, void** ppv);
    HRESULT GetComparisonInfo(ushort** ppszPropertyName, CONDITION_OPERATION* pcop, PROPVARIANT* ppropvar);
    HRESULT GetValueType(ushort** ppszValueTypeName);
    HRESULT GetValueNormalization(ushort** ppszNormalization);
    HRESULT GetInputTerms(IRichChunk* ppPropertyTerm, IRichChunk* ppOperationTerm, IRichChunk* ppValueTerm);
    HRESULT Clone(ICondition* ppc);
}

const GUID IID_ICondition2 = {0x0DB8851D, 0x2E5B, 0x47EB, [0x92, 0x08, 0xD2, 0x8C, 0x32, 0x5A, 0x01, 0xD7]};
@GUID(0x0DB8851D, 0x2E5B, 0x47EB, [0x92, 0x08, 0xD2, 0x8C, 0x32, 0x5A, 0x01, 0xD7]);
interface ICondition2 : ICondition
{
    HRESULT GetLocale(ushort** ppszLocaleName);
    HRESULT GetLeafConditionInfo(PROPERTYKEY* ppropkey, CONDITION_OPERATION* pcop, PROPVARIANT* ppropvar);
}

struct IRowsetExactScroll
{
}

struct DB_NUMERIC
{
    ubyte precision;
    ubyte scale;
    ubyte sign;
    ubyte val;
}

struct DBVECTOR
{
    uint size;
    void* ptr;
}

struct DBDATE
{
    short year;
    ushort month;
    ushort day;
}

struct DBTIME
{
    ushort hour;
    ushort minute;
    ushort second;
}

struct DBTIMESTAMP
{
    short year;
    ushort month;
    ushort day;
    ushort hour;
    ushort minute;
    ushort second;
    uint fraction;
}

struct DB_VARNUMERIC
{
    ubyte precision;
    byte scale;
    ubyte sign;
    ubyte val;
}

struct SEC_OBJECT_ELEMENT
{
    Guid guidObjectType;
    DBID ObjectID;
}

struct SEC_OBJECT
{
    uint cObjects;
    SEC_OBJECT_ELEMENT* prgObjects;
}

struct DBIMPLICITSESSION
{
    IUnknown pUnkOuter;
    Guid* piid;
    IUnknown pSession;
}

enum DBTYPEENUM
{
    DBTYPE_EMPTY = 0,
    DBTYPE_NULL = 1,
    DBTYPE_I2 = 2,
    DBTYPE_I4 = 3,
    DBTYPE_R4 = 4,
    DBTYPE_R8 = 5,
    DBTYPE_CY = 6,
    DBTYPE_DATE = 7,
    DBTYPE_BSTR = 8,
    DBTYPE_IDISPATCH = 9,
    DBTYPE_ERROR = 10,
    DBTYPE_BOOL = 11,
    DBTYPE_VARIANT = 12,
    DBTYPE_IUNKNOWN = 13,
    DBTYPE_DECIMAL = 14,
    DBTYPE_UI1 = 17,
    DBTYPE_ARRAY = 8192,
    DBTYPE_BYREF = 16384,
    DBTYPE_I1 = 16,
    DBTYPE_UI2 = 18,
    DBTYPE_UI4 = 19,
    DBTYPE_I8 = 20,
    DBTYPE_UI8 = 21,
    DBTYPE_GUID = 72,
    DBTYPE_VECTOR = 4096,
    DBTYPE_RESERVED = 32768,
    DBTYPE_BYTES = 128,
    DBTYPE_STR = 129,
    DBTYPE_WSTR = 130,
    DBTYPE_NUMERIC = 131,
    DBTYPE_UDT = 132,
    DBTYPE_DBDATE = 133,
    DBTYPE_DBTIME = 134,
    DBTYPE_DBTIMESTAMP = 135,
}

enum DBTYPEENUM15
{
    DBTYPE_HCHAPTER = 136,
}

enum DBTYPEENUM20
{
    DBTYPE_FILETIME = 64,
    DBTYPE_PROPVARIANT = 138,
    DBTYPE_VARNUMERIC = 139,
}

enum DBPARTENUM
{
    DBPART_INVALID = 0,
    DBPART_VALUE = 1,
    DBPART_LENGTH = 2,
    DBPART_STATUS = 4,
}

enum DBPARAMIOENUM
{
    DBPARAMIO_NOTPARAM = 0,
    DBPARAMIO_INPUT = 1,
    DBPARAMIO_OUTPUT = 2,
}

enum DBBINDFLAGENUM
{
    DBBINDFLAG_HTML = 1,
}

enum DBMEMOWNERENUM
{
    DBMEMOWNER_CLIENTOWNED = 0,
    DBMEMOWNER_PROVIDEROWNED = 1,
}

struct DBOBJECT
{
    uint dwFlags;
    Guid iid;
}

enum DBSTATUSENUM
{
    DBSTATUS_S_OK = 0,
    DBSTATUS_E_BADACCESSOR = 1,
    DBSTATUS_E_CANTCONVERTVALUE = 2,
    DBSTATUS_S_ISNULL = 3,
    DBSTATUS_S_TRUNCATED = 4,
    DBSTATUS_E_SIGNMISMATCH = 5,
    DBSTATUS_E_DATAOVERFLOW = 6,
    DBSTATUS_E_CANTCREATE = 7,
    DBSTATUS_E_UNAVAILABLE = 8,
    DBSTATUS_E_PERMISSIONDENIED = 9,
    DBSTATUS_E_INTEGRITYVIOLATION = 10,
    DBSTATUS_E_SCHEMAVIOLATION = 11,
    DBSTATUS_E_BADSTATUS = 12,
    DBSTATUS_S_DEFAULT = 13,
}

enum DBSTATUSENUM20
{
    MDSTATUS_S_CELLEMPTY = 14,
    DBSTATUS_S_IGNORE = 15,
}

enum DBSTATUSENUM21
{
    DBSTATUS_E_DOESNOTEXIST = 16,
    DBSTATUS_E_INVALIDURL = 17,
    DBSTATUS_E_RESOURCELOCKED = 18,
    DBSTATUS_E_RESOURCEEXISTS = 19,
    DBSTATUS_E_CANNOTCOMPLETE = 20,
    DBSTATUS_E_VOLUMENOTFOUND = 21,
    DBSTATUS_E_OUTOFSPACE = 22,
    DBSTATUS_S_CANNOTDELETESOURCE = 23,
    DBSTATUS_E_READONLY = 24,
    DBSTATUS_E_RESOURCEOUTOFSCOPE = 25,
    DBSTATUS_S_ALREADYEXISTS = 26,
}

enum DBBINDURLFLAGENUM
{
    DBBINDURLFLAG_READ = 1,
    DBBINDURLFLAG_WRITE = 2,
    DBBINDURLFLAG_READWRITE = 3,
    DBBINDURLFLAG_SHARE_DENY_READ = 4,
    DBBINDURLFLAG_SHARE_DENY_WRITE = 8,
    DBBINDURLFLAG_SHARE_EXCLUSIVE = 12,
    DBBINDURLFLAG_SHARE_DENY_NONE = 16,
    DBBINDURLFLAG_ASYNCHRONOUS = 4096,
    DBBINDURLFLAG_COLLECTION = 8192,
    DBBINDURLFLAG_DELAYFETCHSTREAM = 16384,
    DBBINDURLFLAG_DELAYFETCHCOLUMNS = 32768,
    DBBINDURLFLAG_RECURSIVE = 4194304,
    DBBINDURLFLAG_OUTPUT = 8388608,
    DBBINDURLFLAG_WAITFORINIT = 16777216,
    DBBINDURLFLAG_OPENIFEXISTS = 33554432,
    DBBINDURLFLAG_OVERWRITE = 67108864,
    DBBINDURLFLAG_ISSTRUCTUREDDOCUMENT = 134217728,
}

enum DBBINDURLSTATUSENUM
{
    DBBINDURLSTATUS_S_OK = 0,
    DBBINDURLSTATUS_S_DENYNOTSUPPORTED = 1,
    DBBINDURLSTATUS_S_DENYTYPENOTSUPPORTED = 4,
    DBBINDURLSTATUS_S_REDIRECTED = 8,
}

enum DBSTATUSENUM25
{
    DBSTATUS_E_CANCELED = 27,
    DBSTATUS_E_NOTCOLLECTION = 28,
}

struct DBBINDEXT
{
    ubyte* pExtension;
    uint ulExtension;
}

struct DBBINDING
{
    uint iOrdinal;
    uint obValue;
    uint obLength;
    uint obStatus;
    ITypeInfo pTypeInfo;
    DBOBJECT* pObject;
    DBBINDEXT* pBindExt;
    uint dwPart;
    uint dwMemOwner;
    uint eParamIO;
    uint cbMaxLen;
    uint dwFlags;
    ushort wType;
    ubyte bPrecision;
    ubyte bScale;
}

enum DBROWSTATUSENUM
{
    DBROWSTATUS_S_OK = 0,
    DBROWSTATUS_S_MULTIPLECHANGES = 2,
    DBROWSTATUS_S_PENDINGCHANGES = 3,
    DBROWSTATUS_E_CANCELED = 4,
    DBROWSTATUS_E_CANTRELEASE = 6,
    DBROWSTATUS_E_CONCURRENCYVIOLATION = 7,
    DBROWSTATUS_E_DELETED = 8,
    DBROWSTATUS_E_PENDINGINSERT = 9,
    DBROWSTATUS_E_NEWLYINSERTED = 10,
    DBROWSTATUS_E_INTEGRITYVIOLATION = 11,
    DBROWSTATUS_E_INVALID = 12,
    DBROWSTATUS_E_MAXPENDCHANGESEXCEEDED = 13,
    DBROWSTATUS_E_OBJECTOPEN = 14,
    DBROWSTATUS_E_OUTOFMEMORY = 15,
    DBROWSTATUS_E_PERMISSIONDENIED = 16,
    DBROWSTATUS_E_LIMITREACHED = 17,
    DBROWSTATUS_E_SCHEMAVIOLATION = 18,
    DBROWSTATUS_E_FAIL = 19,
}

enum DBROWSTATUSENUM20
{
    DBROWSTATUS_S_NOCHANGE = 20,
}

enum DBSTATUSENUM26
{
    DBSTATUS_S_ROWSETCOLUMN = 29,
}

struct DBFAILUREINFO
{
    uint hRow;
    uint iColumn;
    HRESULT failure;
}

enum DBCOLUMNFLAGSENUM
{
    DBCOLUMNFLAGS_ISBOOKMARK = 1,
    DBCOLUMNFLAGS_MAYDEFER = 2,
    DBCOLUMNFLAGS_WRITE = 4,
    DBCOLUMNFLAGS_WRITEUNKNOWN = 8,
    DBCOLUMNFLAGS_ISFIXEDLENGTH = 16,
    DBCOLUMNFLAGS_ISNULLABLE = 32,
    DBCOLUMNFLAGS_MAYBENULL = 64,
    DBCOLUMNFLAGS_ISLONG = 128,
    DBCOLUMNFLAGS_ISROWID = 256,
    DBCOLUMNFLAGS_ISROWVER = 512,
    DBCOLUMNFLAGS_CACHEDEFERRED = 4096,
}

enum DBCOLUMNFLAGSENUM20
{
    DBCOLUMNFLAGS_SCALEISNEGATIVE = 16384,
    DBCOLUMNFLAGS_RESERVED = 32768,
}

enum DBCOLUMNFLAGS15ENUM
{
    DBCOLUMNFLAGS_ISCHAPTER = 8192,
}

enum DBCOLUMNFLAGSENUM21
{
    DBCOLUMNFLAGS_ISROWURL = 65536,
    DBCOLUMNFLAGS_ISDEFAULTSTREAM = 131072,
    DBCOLUMNFLAGS_ISCOLLECTION = 262144,
}

enum DBCOLUMNFLAGSENUM26
{
    DBCOLUMNFLAGS_ISSTREAM = 524288,
    DBCOLUMNFLAGS_ISROWSET = 1048576,
    DBCOLUMNFLAGS_ISROW = 2097152,
    DBCOLUMNFLAGS_ROWSPECIFICCOLUMN = 4194304,
}

enum DBTABLESTATISTICSTYPE26
{
    DBSTAT_HISTOGRAM = 1,
    DBSTAT_COLUMN_CARDINALITY = 2,
    DBSTAT_TUPLE_CARDINALITY = 4,
}

struct DBCOLUMNINFO
{
    ushort* pwszName;
    ITypeInfo pTypeInfo;
    uint iOrdinal;
    uint dwFlags;
    uint ulColumnSize;
    ushort wType;
    ubyte bPrecision;
    ubyte bScale;
    DBID columnid;
}

enum DBBOOKMARK
{
    DBBMK_INVALID = 0,
    DBBMK_FIRST = 1,
    DBBMK_LAST = 2,
}

enum DBPROPENUM
{
    DBPROP_ABORTPRESERVE = 2,
    DBPROP_ACTIVESESSIONS = 3,
    DBPROP_APPENDONLY = 187,
    DBPROP_ASYNCTXNABORT = 168,
    DBPROP_ASYNCTXNCOMMIT = 4,
    DBPROP_AUTH_CACHE_AUTHINFO = 5,
    DBPROP_AUTH_ENCRYPT_PASSWORD = 6,
    DBPROP_AUTH_INTEGRATED = 7,
    DBPROP_AUTH_MASK_PASSWORD = 8,
    DBPROP_AUTH_PASSWORD = 9,
    DBPROP_AUTH_PERSIST_ENCRYPTED = 10,
    DBPROP_AUTH_PERSIST_SENSITIVE_AUTHINFO = 11,
    DBPROP_AUTH_USERID = 12,
    DBPROP_BLOCKINGSTORAGEOBJECTS = 13,
    DBPROP_BOOKMARKS = 14,
    DBPROP_BOOKMARKSKIPPED = 15,
    DBPROP_BOOKMARKTYPE = 16,
    DBPROP_BYREFACCESSORS = 120,
    DBPROP_CACHEDEFERRED = 17,
    DBPROP_CANFETCHBACKWARDS = 18,
    DBPROP_CANHOLDROWS = 19,
    DBPROP_CANSCROLLBACKWARDS = 21,
    DBPROP_CATALOGLOCATION = 22,
    DBPROP_CATALOGTERM = 23,
    DBPROP_CATALOGUSAGE = 24,
    DBPROP_CHANGEINSERTEDROWS = 188,
    DBPROP_COL_AUTOINCREMENT = 26,
    DBPROP_COL_DEFAULT = 27,
    DBPROP_COL_DESCRIPTION = 28,
    DBPROP_COL_FIXEDLENGTH = 167,
    DBPROP_COL_NULLABLE = 29,
    DBPROP_COL_PRIMARYKEY = 30,
    DBPROP_COL_UNIQUE = 31,
    DBPROP_COLUMNDEFINITION = 32,
    DBPROP_COLUMNRESTRICT = 33,
    DBPROP_COMMANDTIMEOUT = 34,
    DBPROP_COMMITPRESERVE = 35,
    DBPROP_CONCATNULLBEHAVIOR = 36,
    DBPROP_CURRENTCATALOG = 37,
    DBPROP_DATASOURCENAME = 38,
    DBPROP_DATASOURCEREADONLY = 39,
    DBPROP_DBMSNAME = 40,
    DBPROP_DBMSVER = 41,
    DBPROP_DEFERRED = 42,
    DBPROP_DELAYSTORAGEOBJECTS = 43,
    DBPROP_DSOTHREADMODEL = 169,
    DBPROP_GROUPBY = 44,
    DBPROP_HETEROGENEOUSTABLES = 45,
    DBPROP_IAccessor = 121,
    DBPROP_IColumnsInfo = 122,
    DBPROP_IColumnsRowset = 123,
    DBPROP_IConnectionPointContainer = 124,
    DBPROP_IConvertType = 194,
    DBPROP_IRowset = 126,
    DBPROP_IRowsetChange = 127,
    DBPROP_IRowsetIdentity = 128,
    DBPROP_IRowsetIndex = 159,
    DBPROP_IRowsetInfo = 129,
    DBPROP_IRowsetLocate = 130,
    DBPROP_IRowsetResynch = 132,
    DBPROP_IRowsetScroll = 133,
    DBPROP_IRowsetUpdate = 134,
    DBPROP_ISupportErrorInfo = 135,
    DBPROP_ILockBytes = 136,
    DBPROP_ISequentialStream = 137,
    DBPROP_IStorage = 138,
    DBPROP_IStream = 139,
    DBPROP_IDENTIFIERCASE = 46,
    DBPROP_IMMOBILEROWS = 47,
    DBPROP_INDEX_AUTOUPDATE = 48,
    DBPROP_INDEX_CLUSTERED = 49,
    DBPROP_INDEX_FILLFACTOR = 50,
    DBPROP_INDEX_INITIALSIZE = 51,
    DBPROP_INDEX_NULLCOLLATION = 52,
    DBPROP_INDEX_NULLS = 53,
    DBPROP_INDEX_PRIMARYKEY = 54,
    DBPROP_INDEX_SORTBOOKMARKS = 55,
    DBPROP_INDEX_TEMPINDEX = 163,
    DBPROP_INDEX_TYPE = 56,
    DBPROP_INDEX_UNIQUE = 57,
    DBPROP_INIT_DATASOURCE = 59,
    DBPROP_INIT_HWND = 60,
    DBPROP_INIT_IMPERSONATION_LEVEL = 61,
    DBPROP_INIT_LCID = 186,
    DBPROP_INIT_LOCATION = 62,
    DBPROP_INIT_MODE = 63,
    DBPROP_INIT_PROMPT = 64,
    DBPROP_INIT_PROTECTION_LEVEL = 65,
    DBPROP_INIT_PROVIDERSTRING = 160,
    DBPROP_INIT_TIMEOUT = 66,
    DBPROP_LITERALBOOKMARKS = 67,
    DBPROP_LITERALIDENTITY = 68,
    DBPROP_MAXINDEXSIZE = 70,
    DBPROP_MAXOPENROWS = 71,
    DBPROP_MAXPENDINGROWS = 72,
    DBPROP_MAXROWS = 73,
    DBPROP_MAXROWSIZE = 74,
    DBPROP_MAXROWSIZEINCLUDESBLOB = 75,
    DBPROP_MAXTABLESINSELECT = 76,
    DBPROP_MAYWRITECOLUMN = 77,
    DBPROP_MEMORYUSAGE = 78,
    DBPROP_MULTIPLEPARAMSETS = 191,
    DBPROP_MULTIPLERESULTS = 196,
    DBPROP_MULTIPLESTORAGEOBJECTS = 80,
    DBPROP_MULTITABLEUPDATE = 81,
    DBPROP_NOTIFICATIONGRANULARITY = 198,
    DBPROP_NOTIFICATIONPHASES = 82,
    DBPROP_NOTIFYCOLUMNSET = 171,
    DBPROP_NOTIFYROWDELETE = 173,
    DBPROP_NOTIFYROWFIRSTCHANGE = 174,
    DBPROP_NOTIFYROWINSERT = 175,
    DBPROP_NOTIFYROWRESYNCH = 177,
    DBPROP_NOTIFYROWSETCHANGED = 211,
    DBPROP_NOTIFYROWSETRELEASE = 178,
    DBPROP_NOTIFYROWSETFETCHPOSITIONCHANGE = 179,
    DBPROP_NOTIFYROWUNDOCHANGE = 180,
    DBPROP_NOTIFYROWUNDODELETE = 181,
    DBPROP_NOTIFYROWUNDOINSERT = 182,
    DBPROP_NOTIFYROWUPDATE = 183,
    DBPROP_NULLCOLLATION = 83,
    DBPROP_OLEOBJECTS = 84,
    DBPROP_ORDERBYCOLUMNSINSELECT = 85,
    DBPROP_ORDEREDBOOKMARKS = 86,
    DBPROP_OTHERINSERT = 87,
    DBPROP_OTHERUPDATEDELETE = 88,
    DBPROP_OUTPUTPARAMETERAVAILABILITY = 184,
    DBPROP_OWNINSERT = 89,
    DBPROP_OWNUPDATEDELETE = 90,
    DBPROP_PERSISTENTIDTYPE = 185,
    DBPROP_PREPAREABORTBEHAVIOR = 91,
    DBPROP_PREPARECOMMITBEHAVIOR = 92,
    DBPROP_PROCEDURETERM = 93,
    DBPROP_PROVIDERNAME = 96,
    DBPROP_PROVIDEROLEDBVER = 97,
    DBPROP_PROVIDERVER = 98,
    DBPROP_QUICKRESTART = 99,
    DBPROP_QUOTEDIDENTIFIERCASE = 100,
    DBPROP_REENTRANTEVENTS = 101,
    DBPROP_REMOVEDELETED = 102,
    DBPROP_REPORTMULTIPLECHANGES = 103,
    DBPROP_RETURNPENDINGINSERTS = 189,
    DBPROP_ROWRESTRICT = 104,
    DBPROP_ROWSETCONVERSIONSONCOMMAND = 192,
    DBPROP_ROWTHREADMODEL = 105,
    DBPROP_SCHEMATERM = 106,
    DBPROP_SCHEMAUSAGE = 107,
    DBPROP_SERVERCURSOR = 108,
    DBPROP_SESS_AUTOCOMMITISOLEVELS = 190,
    DBPROP_SQLSUPPORT = 109,
    DBPROP_STRONGIDENTITY = 119,
    DBPROP_STRUCTUREDSTORAGE = 111,
    DBPROP_SUBQUERIES = 112,
    DBPROP_SUPPORTEDTXNDDL = 161,
    DBPROP_SUPPORTEDTXNISOLEVELS = 113,
    DBPROP_SUPPORTEDTXNISORETAIN = 114,
    DBPROP_TABLETERM = 115,
    DBPROP_TBL_TEMPTABLE = 140,
    DBPROP_TRANSACTEDOBJECT = 116,
    DBPROP_UPDATABILITY = 117,
    DBPROP_USERNAME = 118,
}

enum DBPROPENUM15
{
    DBPROP_FILTERCOMPAREOPS = 209,
    DBPROP_FINDCOMPAREOPS = 210,
    DBPROP_IChapteredRowset = 202,
    DBPROP_IDBAsynchStatus = 203,
    DBPROP_IRowsetFind = 204,
    DBPROP_IRowsetView = 212,
    DBPROP_IViewChapter = 213,
    DBPROP_IViewFilter = 214,
    DBPROP_IViewRowset = 215,
    DBPROP_IViewSort = 216,
    DBPROP_INIT_ASYNCH = 200,
    DBPROP_MAXOPENCHAPTERS = 199,
    DBPROP_MAXORSINFILTER = 205,
    DBPROP_MAXSORTCOLUMNS = 206,
    DBPROP_ROWSET_ASYNCH = 201,
    DBPROP_SORTONINDEX = 207,
}

enum DBPROPENUM20
{
    DBPROP_IMultipleResults = 217,
    DBPROP_DATASOURCE_TYPE = 251,
    MDPROP_AXES = 252,
    MDPROP_FLATTENING_SUPPORT = 253,
    MDPROP_MDX_JOINCUBES = 254,
    MDPROP_NAMED_LEVELS = 255,
    MDPROP_RANGEROWSET = 256,
    MDPROP_MDX_SLICER = 218,
    MDPROP_MDX_CUBEQUALIFICATION = 219,
    MDPROP_MDX_OUTERREFERENCE = 220,
    MDPROP_MDX_QUERYBYPROPERTY = 221,
    MDPROP_MDX_CASESUPPORT = 222,
    MDPROP_MDX_STRING_COMPOP = 224,
    MDPROP_MDX_DESCFLAGS = 225,
    MDPROP_MDX_SET_FUNCTIONS = 226,
    MDPROP_MDX_MEMBER_FUNCTIONS = 227,
    MDPROP_MDX_NUMERIC_FUNCTIONS = 228,
    MDPROP_MDX_FORMULAS = 229,
    MDPROP_AGGREGATECELL_UPDATE = 230,
    MDPROP_MDX_AGGREGATECELL_UPDATE = 230,
    MDPROP_MDX_OBJQUALIFICATION = 261,
    MDPROP_MDX_NONMEASURE_EXPRESSIONS = 262,
    DBPROP_ACCESSORDER = 231,
    DBPROP_BOOKMARKINFO = 232,
    DBPROP_INIT_CATALOG = 233,
    DBPROP_ROW_BULKOPS = 234,
    DBPROP_PROVIDERFRIENDLYNAME = 235,
    DBPROP_LOCKMODE = 236,
    DBPROP_MULTIPLECONNECTIONS = 237,
    DBPROP_UNIQUEROWS = 238,
    DBPROP_SERVERDATAONINSERT = 239,
    DBPROP_STORAGEFLAGS = 240,
    DBPROP_CONNECTIONSTATUS = 244,
    DBPROP_ALTERCOLUMN = 245,
    DBPROP_COLUMNLCID = 246,
    DBPROP_RESETDATASOURCE = 247,
    DBPROP_INIT_OLEDBSERVICES = 248,
    DBPROP_IRowsetRefresh = 249,
    DBPROP_SERVERNAME = 250,
    DBPROP_IParentRowset = 257,
    DBPROP_HIDDENCOLUMNS = 258,
    DBPROP_PROVIDERMEMORY = 259,
    DBPROP_CLIENTCURSOR = 260,
}

enum DBPROPENUM21
{
    DBPROP_TRUSTEE_USERNAME = 241,
    DBPROP_TRUSTEE_AUTHENTICATION = 242,
    DBPROP_TRUSTEE_NEWAUTHENTICATION = 243,
    DBPROP_IRow = 263,
    DBPROP_IRowChange = 264,
    DBPROP_IRowSchemaChange = 265,
    DBPROP_IGetRow = 266,
    DBPROP_IScopedOperations = 267,
    DBPROP_IBindResource = 268,
    DBPROP_ICreateRow = 269,
    DBPROP_INIT_BINDFLAGS = 270,
    DBPROP_INIT_LOCKOWNER = 271,
    DBPROP_GENERATEURL = 273,
    DBPROP_IDBBinderProperties = 274,
    DBPROP_IColumnsInfo2 = 275,
    DBPROP_IRegisterProvider = 276,
    DBPROP_IGetSession = 277,
    DBPROP_IGetSourceRow = 278,
    DBPROP_IRowsetCurrentIndex = 279,
    DBPROP_OPENROWSETSUPPORT = 280,
    DBPROP_COL_ISLONG = 281,
}

enum DBPROPENUM25
{
    DBPROP_COL_SEED = 282,
    DBPROP_COL_INCREMENT = 283,
    DBPROP_INIT_GENERALTIMEOUT = 284,
    DBPROP_COMSERVICES = 285,
}

enum DBPROPENUM26
{
    DBPROP_OUTPUTSTREAM = 286,
    DBPROP_OUTPUTENCODING = 287,
    DBPROP_TABLESTATISTICS = 288,
    DBPROP_SKIPROWCOUNTRESULTS = 291,
    DBPROP_IRowsetBookmark = 292,
    MDPROP_VISUALMODE = 293,
}

struct DBPARAMS
{
    void* pData;
    uint cParamSets;
    uint hAccessor;
}

enum DBPARAMFLAGSENUM
{
    DBPARAMFLAGS_ISINPUT = 1,
    DBPARAMFLAGS_ISOUTPUT = 2,
    DBPARAMFLAGS_ISSIGNED = 16,
    DBPARAMFLAGS_ISNULLABLE = 64,
    DBPARAMFLAGS_ISLONG = 128,
}

enum DBPARAMFLAGSENUM20
{
    DBPARAMFLAGS_SCALEISNEGATIVE = 256,
}

struct DBPARAMINFO
{
    uint dwFlags;
    uint iOrdinal;
    ushort* pwszName;
    ITypeInfo pTypeInfo;
    uint ulParamSize;
    ushort wType;
    ubyte bPrecision;
    ubyte bScale;
}

struct DBPROPIDSET
{
    uint* rgPropertyIDs;
    uint cPropertyIDs;
    Guid guidPropertySet;
}

enum DBPROPFLAGSENUM
{
    DBPROPFLAGS_NOTSUPPORTED = 0,
    DBPROPFLAGS_COLUMN = 1,
    DBPROPFLAGS_DATASOURCE = 2,
    DBPROPFLAGS_DATASOURCECREATE = 4,
    DBPROPFLAGS_DATASOURCEINFO = 8,
    DBPROPFLAGS_DBINIT = 16,
    DBPROPFLAGS_INDEX = 32,
    DBPROPFLAGS_ROWSET = 64,
    DBPROPFLAGS_TABLE = 128,
    DBPROPFLAGS_COLUMNOK = 256,
    DBPROPFLAGS_READ = 512,
    DBPROPFLAGS_WRITE = 1024,
    DBPROPFLAGS_REQUIRED = 2048,
    DBPROPFLAGS_SESSION = 4096,
}

enum DBPROPFLAGSENUM21
{
    DBPROPFLAGS_TRUSTEE = 8192,
}

enum DBPROPFLAGSENUM25
{
    DBPROPFLAGS_VIEW = 16384,
}

enum DBPROPFLAGSENUM26
{
    DBPROPFLAGS_STREAM = 32768,
}

struct DBPROPINFO
{
    ushort* pwszDescription;
    uint dwPropertyID;
    uint dwFlags;
    ushort vtType;
    VARIANT vValues;
}

struct DBPROPINFOSET
{
    DBPROPINFO* rgPropertyInfos;
    uint cPropertyInfos;
    Guid guidPropertySet;
}

enum DBPROPOPTIONSENUM
{
    DBPROPOPTIONS_REQUIRED = 0,
    DBPROPOPTIONS_SETIFCHEAP = 1,
    DBPROPOPTIONS_OPTIONAL = 1,
}

enum DBPROPSTATUSENUM
{
    DBPROPSTATUS_OK = 0,
    DBPROPSTATUS_NOTSUPPORTED = 1,
    DBPROPSTATUS_BADVALUE = 2,
    DBPROPSTATUS_BADOPTION = 3,
    DBPROPSTATUS_BADCOLUMN = 4,
    DBPROPSTATUS_NOTALLSETTABLE = 5,
    DBPROPSTATUS_NOTSETTABLE = 6,
    DBPROPSTATUS_NOTSET = 7,
    DBPROPSTATUS_CONFLICTING = 8,
}

enum DBPROPSTATUSENUM21
{
    DBPROPSTATUS_NOTAVAILABLE = 9,
}

struct DBPROP
{
    uint dwPropertyID;
    uint dwOptions;
    uint dwStatus;
    DBID colid;
    VARIANT vValue;
}

struct DBPROPSET
{
    DBPROP* rgProperties;
    uint cProperties;
    Guid guidPropertySet;
}

enum DBINDEX_COL_ORDERENUM
{
    DBINDEX_COL_ORDER_ASC = 0,
    DBINDEX_COL_ORDER_DESC = 1,
}

struct DBINDEXCOLUMNDESC
{
    DBID* pColumnID;
    uint eIndexColOrder;
}

struct DBCOLUMNDESC
{
    ushort* pwszTypeName;
    ITypeInfo pTypeInfo;
    DBPROPSET* rgPropertySets;
    Guid* pclsid;
    uint cPropertySets;
    uint ulColumnSize;
    DBID dbcid;
    ushort wType;
    ubyte bPrecision;
    ubyte bScale;
}

struct DBCOLUMNACCESS
{
    void* pData;
    DBID columnid;
    uint cbDataLen;
    uint dwStatus;
    uint cbMaxLen;
    uint dwReserved;
    ushort wType;
    ubyte bPrecision;
    ubyte bScale;
}

enum DBCOLUMNDESCFLAGSENUM
{
    DBCOLUMNDESCFLAGS_TYPENAME = 1,
    DBCOLUMNDESCFLAGS_ITYPEINFO = 2,
    DBCOLUMNDESCFLAGS_PROPERTIES = 4,
    DBCOLUMNDESCFLAGS_CLSID = 8,
    DBCOLUMNDESCFLAGS_COLSIZE = 16,
    DBCOLUMNDESCFLAGS_DBCID = 32,
    DBCOLUMNDESCFLAGS_WTYPE = 64,
    DBCOLUMNDESCFLAGS_PRECISION = 128,
    DBCOLUMNDESCFLAGS_SCALE = 256,
}

enum DBEVENTPHASEENUM
{
    DBEVENTPHASE_OKTODO = 0,
    DBEVENTPHASE_ABOUTTODO = 1,
    DBEVENTPHASE_SYNCHAFTER = 2,
    DBEVENTPHASE_FAILEDTODO = 3,
    DBEVENTPHASE_DIDEVENT = 4,
}

enum DBREASONENUM
{
    DBREASON_ROWSET_FETCHPOSITIONCHANGE = 0,
    DBREASON_ROWSET_RELEASE = 1,
    DBREASON_COLUMN_SET = 2,
    DBREASON_COLUMN_RECALCULATED = 3,
    DBREASON_ROW_ACTIVATE = 4,
    DBREASON_ROW_RELEASE = 5,
    DBREASON_ROW_DELETE = 6,
    DBREASON_ROW_FIRSTCHANGE = 7,
    DBREASON_ROW_INSERT = 8,
    DBREASON_ROW_RESYNCH = 9,
    DBREASON_ROW_UNDOCHANGE = 10,
    DBREASON_ROW_UNDOINSERT = 11,
    DBREASON_ROW_UNDODELETE = 12,
    DBREASON_ROW_UPDATE = 13,
    DBREASON_ROWSET_CHANGED = 14,
}

enum DBREASONENUM15
{
    DBREASON_ROWPOSITION_CHANGED = 15,
    DBREASON_ROWPOSITION_CHAPTERCHANGED = 16,
    DBREASON_ROWPOSITION_CLEARED = 17,
    DBREASON_ROW_ASYNCHINSERT = 18,
}

enum DBCOMPAREOPSENUM
{
    DBCOMPAREOPS_LT = 0,
    DBCOMPAREOPS_LE = 1,
    DBCOMPAREOPS_EQ = 2,
    DBCOMPAREOPS_GE = 3,
    DBCOMPAREOPS_GT = 4,
    DBCOMPAREOPS_BEGINSWITH = 5,
    DBCOMPAREOPS_CONTAINS = 6,
    DBCOMPAREOPS_NE = 7,
    DBCOMPAREOPS_IGNORE = 8,
    DBCOMPAREOPS_CASESENSITIVE = 4096,
    DBCOMPAREOPS_CASEINSENSITIVE = 8192,
}

enum DBCOMPAREOPSENUM20
{
    DBCOMPAREOPS_NOTBEGINSWITH = 9,
    DBCOMPAREOPS_NOTCONTAINS = 10,
}

enum DBASYNCHOPENUM
{
    DBASYNCHOP_OPEN = 0,
}

enum DBASYNCHPHASEENUM
{
    DBASYNCHPHASE_INITIALIZATION = 0,
    DBASYNCHPHASE_POPULATION = 1,
    DBASYNCHPHASE_COMPLETE = 2,
    DBASYNCHPHASE_CANCELED = 3,
}

enum DBSORTENUM
{
    DBSORT_ASCENDING = 0,
    DBSORT_DESCENDING = 1,
}

enum DBCOMMANDPERSISTFLAGENUM
{
    DBCOMMANDPERSISTFLAG_NOSAVE = 1,
}

enum DBCOMMANDPERSISTFLAGENUM21
{
    DBCOMMANDPERSISTFLAG_DEFAULT = 0,
    DBCOMMANDPERSISTFLAG_PERSISTVIEW = 2,
    DBCOMMANDPERSISTFLAG_PERSISTPROCEDURE = 4,
}

enum DBCONSTRAINTTYPEENUM
{
    DBCONSTRAINTTYPE_UNIQUE = 0,
    DBCONSTRAINTTYPE_FOREIGNKEY = 1,
    DBCONSTRAINTTYPE_PRIMARYKEY = 2,
    DBCONSTRAINTTYPE_CHECK = 3,
}

enum DBUPDELRULEENUM
{
    DBUPDELRULE_NOACTION = 0,
    DBUPDELRULE_CASCADE = 1,
    DBUPDELRULE_SETNULL = 2,
    DBUPDELRULE_SETDEFAULT = 3,
}

enum DBMATCHTYPEENUM
{
    DBMATCHTYPE_FULL = 0,
    DBMATCHTYPE_NONE = 1,
    DBMATCHTYPE_PARTIAL = 2,
}

enum DBDEFERRABILITYENUM
{
    DBDEFERRABILITY_DEFERRED = 1,
    DBDEFERRABILITY_DEFERRABLE = 2,
}

struct DBCONSTRAINTDESC
{
    DBID* pConstraintID;
    uint ConstraintType;
    uint cColumns;
    DBID* rgColumnList;
    DBID* pReferencedTableID;
    uint cForeignKeyColumns;
    DBID* rgForeignKeyColumnList;
    ushort* pwszConstraintText;
    uint UpdateRule;
    uint DeleteRule;
    uint MatchType;
    uint Deferrability;
    uint cReserved;
    DBPROPSET* rgReserved;
}

struct MDAXISINFO
{
    uint cbSize;
    uint iAxis;
    uint cDimensions;
    uint cCoordinates;
    uint* rgcColumns;
    ushort** rgpwszDimensionNames;
}

struct RMTPACK
{
    ISequentialStream pISeqStream;
    uint cbData;
    uint cBSTR;
    BSTR* rgBSTR;
    uint cVARIANT;
    VARIANT* rgVARIANT;
    uint cIDISPATCH;
    IDispatch* rgIDISPATCH;
    uint cIUNKNOWN;
    IUnknown* rgIUNKNOWN;
    uint cPROPVARIANT;
    PROPVARIANT* rgPROPVARIANT;
    uint cArray;
    VARIANT* rgArray;
}

enum DBACCESSORFLAGSENUM
{
    DBACCESSOR_INVALID = 0,
    DBACCESSOR_PASSBYREF = 1,
    DBACCESSOR_ROWDATA = 2,
    DBACCESSOR_PARAMETERDATA = 4,
    DBACCESSOR_OPTIMIZED = 8,
    DBACCESSOR_INHERITED = 16,
}

enum DBBINDSTATUSENUM
{
    DBBINDSTATUS_OK = 0,
    DBBINDSTATUS_BADORDINAL = 1,
    DBBINDSTATUS_UNSUPPORTEDCONVERSION = 2,
    DBBINDSTATUS_BADBINDINFO = 3,
    DBBINDSTATUS_BADSTORAGEFLAGS = 4,
    DBBINDSTATUS_NOINTERFACE = 5,
    DBBINDSTATUS_MULTIPLESTORAGE = 6,
}

const GUID IID_IAccessor = {0x0C733A8C, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733A8C, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface IAccessor : IUnknown
{
    HRESULT AddRefAccessor(uint hAccessor, uint* pcRefCount);
    HRESULT CreateAccessor(uint dwAccessorFlags, uint cBindings, char* rgBindings, uint cbRowSize, uint* phAccessor, char* rgStatus);
    HRESULT GetBindings(uint hAccessor, uint* pdwAccessorFlags, uint* pcBindings, DBBINDING** prgBindings);
    HRESULT ReleaseAccessor(uint hAccessor, uint* pcRefCount);
}

const GUID IID_IRowset = {0x0C733A7C, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733A7C, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface IRowset : IUnknown
{
    HRESULT AddRefRows(uint cRows, const(uint)* rghRows, uint* rgRefCounts, uint* rgRowStatus);
    HRESULT GetData(uint hRow, uint hAccessor, void* pData);
    HRESULT GetNextRows(uint hReserved, int lRowsOffset, int cRows, uint* pcRowsObtained, uint** prghRows);
    HRESULT ReleaseRows(uint cRows, const(uint)* rghRows, uint* rgRowOptions, uint* rgRefCounts, uint* rgRowStatus);
    HRESULT RestartPosition(uint hReserved);
}

const GUID IID_IRowsetInfo = {0x0C733A55, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733A55, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface IRowsetInfo : IUnknown
{
    HRESULT GetProperties(const(uint) cPropertyIDSets, char* rgPropertyIDSets, uint* pcPropertySets, DBPROPSET** prgPropertySets);
    HRESULT GetReferencedRowset(uint iOrdinal, const(Guid)* riid, IUnknown* ppReferencedRowset);
    HRESULT GetSpecification(const(Guid)* riid, IUnknown* ppSpecification);
}

enum DBCOMPAREENUM
{
    DBCOMPARE_LT = 0,
    DBCOMPARE_EQ = 1,
    DBCOMPARE_GT = 2,
    DBCOMPARE_NE = 3,
    DBCOMPARE_NOTCOMPARABLE = 4,
}

const GUID IID_IRowsetLocate = {0x0C733A7D, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733A7D, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface IRowsetLocate : IRowset
{
    HRESULT Compare(uint hReserved, uint cbBookmark1, const(ubyte)* pBookmark1, uint cbBookmark2, const(ubyte)* pBookmark2, uint* pComparison);
    HRESULT GetRowsAt(uint hReserved1, uint hReserved2, uint cbBookmark, const(ubyte)* pBookmark, int lRowsOffset, int cRows, uint* pcRowsObtained, uint** prghRows);
    HRESULT GetRowsByBookmark(uint hReserved, uint cRows, const(uint)* rgcbBookmarks, const(ubyte)** rgpBookmarks, uint* rghRows, uint* rgRowStatus);
    HRESULT Hash(uint hReserved, uint cBookmarks, const(uint)* rgcbBookmarks, const(ubyte)** rgpBookmarks, uint* rgHashedValues, uint* rgBookmarkStatus);
}

const GUID IID_IRowsetResynch = {0x0C733A84, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733A84, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface IRowsetResynch : IUnknown
{
    HRESULT GetVisibleData(uint hRow, uint hAccessor, void* pData);
    HRESULT ResynchRows(uint cRows, const(uint)* rghRows, uint* pcRowsResynched, uint** prghRowsResynched, uint** prgRowStatus);
}

const GUID IID_IRowsetScroll = {0x0C733A7E, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733A7E, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface IRowsetScroll : IRowsetLocate
{
    HRESULT GetApproximatePosition(uint hReserved, uint cbBookmark, const(ubyte)* pBookmark, uint* pulPosition, uint* pcRows);
    HRESULT GetRowsAtRatio(uint hReserved1, uint hReserved2, uint ulNumerator, uint ulDenominator, int cRows, uint* pcRowsObtained, uint** prghRows);
}

const GUID IID_IChapteredRowset = {0x0C733A93, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733A93, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface IChapteredRowset : IUnknown
{
    HRESULT AddRefChapter(uint hChapter, uint* pcRefCount);
    HRESULT ReleaseChapter(uint hChapter, uint* pcRefCount);
}

const GUID IID_IRowsetFind = {0x0C733A9D, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733A9D, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface IRowsetFind : IUnknown
{
    HRESULT FindNextRow(uint hChapter, uint hAccessor, void* pFindValue, uint CompareOp, uint cbBookmark, const(ubyte)* pBookmark, int lRowsOffset, int cRows, uint* pcRowsObtained, uint** prghRows);
}

enum DBPOSITIONFLAGSENUM
{
    DBPOSITION_OK = 0,
    DBPOSITION_NOROW = 1,
    DBPOSITION_BOF = 2,
    DBPOSITION_EOF = 3,
}

const GUID IID_IRowPosition = {0x0C733A94, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733A94, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface IRowPosition : IUnknown
{
    HRESULT ClearRowPosition();
    HRESULT GetRowPosition(uint* phChapter, uint* phRow, uint* pdwPositionFlags);
    HRESULT GetRowset(const(Guid)* riid, IUnknown* ppRowset);
    HRESULT Initialize(IUnknown pRowset);
    HRESULT SetRowPosition(uint hChapter, uint hRow, uint dwPositionFlags);
}

const GUID IID_IRowPositionChange = {0x0997A571, 0x126E, 0x11D0, [0x9F, 0x8A, 0x00, 0xA0, 0xC9, 0xA0, 0x63, 0x1E]};
@GUID(0x0997A571, 0x126E, 0x11D0, [0x9F, 0x8A, 0x00, 0xA0, 0xC9, 0xA0, 0x63, 0x1E]);
interface IRowPositionChange : IUnknown
{
    HRESULT OnRowPositionChange(uint eReason, uint ePhase, BOOL fCantDeny);
}

const GUID IID_IViewRowset = {0x0C733A97, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733A97, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface IViewRowset : IUnknown
{
    HRESULT GetSpecification(const(Guid)* riid, IUnknown* ppObject);
    HRESULT OpenViewRowset(IUnknown pUnkOuter, const(Guid)* riid, IUnknown* ppRowset);
}

const GUID IID_IViewChapter = {0x0C733A98, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733A98, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface IViewChapter : IUnknown
{
    HRESULT GetSpecification(const(Guid)* riid, IUnknown* ppRowset);
    HRESULT OpenViewChapter(uint hSource, uint* phViewChapter);
}

const GUID IID_IViewSort = {0x0C733A9A, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733A9A, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface IViewSort : IUnknown
{
    HRESULT GetSortOrder(uint* pcValues, uint** prgColumns, uint** prgOrders);
    HRESULT SetSortOrder(uint cValues, char* rgColumns, char* rgOrders);
}

const GUID IID_IViewFilter = {0x0C733A9B, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733A9B, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface IViewFilter : IUnknown
{
    HRESULT GetFilter(uint hAccessor, uint* pcRows, char* pCompareOps, void* pCriteriaData);
    HRESULT GetFilterBindings(uint* pcBindings, DBBINDING** prgBindings);
    HRESULT SetFilter(uint hAccessor, uint cRows, char* CompareOps, void* pCriteriaData);
}

const GUID IID_IRowsetView = {0x0C733A99, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733A99, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface IRowsetView : IUnknown
{
    HRESULT CreateView(IUnknown pUnkOuter, const(Guid)* riid, IUnknown* ppView);
    HRESULT GetView(uint hChapter, const(Guid)* riid, uint* phChapterSource, IUnknown* ppView);
}

const GUID IID_IRowsetChange = {0x0C733A05, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733A05, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface IRowsetChange : IUnknown
{
    HRESULT DeleteRows(uint hReserved, uint cRows, const(uint)* rghRows, uint* rgRowStatus);
    HRESULT SetData(uint hRow, uint hAccessor, void* pData);
    HRESULT InsertRow(uint hReserved, uint hAccessor, void* pData, uint* phRow);
}

enum DBPENDINGSTATUSENUM
{
    DBPENDINGSTATUS_NEW = 1,
    DBPENDINGSTATUS_CHANGED = 2,
    DBPENDINGSTATUS_DELETED = 4,
    DBPENDINGSTATUS_UNCHANGED = 8,
    DBPENDINGSTATUS_INVALIDROW = 16,
}

const GUID IID_IRowsetUpdate = {0x0C733A6D, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733A6D, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface IRowsetUpdate : IRowsetChange
{
    HRESULT GetOriginalData(uint hRow, uint hAccessor, void* pData);
    HRESULT GetPendingRows(uint hReserved, uint dwRowStatus, uint* pcPendingRows, uint** prgPendingRows, uint** prgPendingStatus);
    HRESULT GetRowStatus(uint hReserved, uint cRows, const(uint)* rghRows, uint* rgPendingStatus);
    HRESULT Undo(uint hReserved, uint cRows, const(uint)* rghRows, uint* pcRowsUndone, uint** prgRowsUndone, uint** prgRowStatus);
    HRESULT Update(uint hReserved, uint cRows, const(uint)* rghRows, uint* pcRows, uint** prgRows, uint** prgRowStatus);
}

const GUID IID_IRowsetIdentity = {0x0C733A09, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733A09, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface IRowsetIdentity : IUnknown
{
    HRESULT IsSameRow(uint hThisRow, uint hThatRow);
}

const GUID IID_IRowsetNotify = {0x0C733A83, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733A83, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface IRowsetNotify : IUnknown
{
    HRESULT OnFieldChange(IRowset pRowset, uint hRow, uint cColumns, char* rgColumns, uint eReason, uint ePhase, BOOL fCantDeny);
    HRESULT OnRowChange(IRowset pRowset, uint cRows, char* rghRows, uint eReason, uint ePhase, BOOL fCantDeny);
    HRESULT OnRowsetChange(IRowset pRowset, uint eReason, uint ePhase, BOOL fCantDeny);
}

enum DBSEEKENUM
{
    DBSEEK_INVALID = 0,
    DBSEEK_FIRSTEQ = 1,
    DBSEEK_LASTEQ = 2,
    DBSEEK_AFTEREQ = 4,
    DBSEEK_AFTER = 8,
    DBSEEK_BEFOREEQ = 16,
    DBSEEK_BEFORE = 32,
}

enum DBRANGEENUM
{
    DBRANGE_INCLUSIVESTART = 0,
    DBRANGE_INCLUSIVEEND = 0,
    DBRANGE_EXCLUSIVESTART = 1,
    DBRANGE_EXCLUSIVEEND = 2,
    DBRANGE_EXCLUDENULLS = 4,
    DBRANGE_PREFIX = 8,
    DBRANGE_MATCH = 16,
}

enum DBRANGEENUM20
{
    DBRANGE_MATCH_N_SHIFT = 24,
    DBRANGE_MATCH_N_MASK = 255,
}

const GUID IID_IRowsetIndex = {0x0C733A82, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733A82, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface IRowsetIndex : IUnknown
{
    HRESULT GetIndexInfo(uint* pcKeyColumns, DBINDEXCOLUMNDESC** prgIndexColumnDesc, uint* pcIndexPropertySets, DBPROPSET** prgIndexPropertySets);
    HRESULT Seek(uint hAccessor, uint cKeyValues, void* pData, uint dwSeekOptions);
    HRESULT SetRange(uint hAccessor, uint cStartKeyColumns, void* pStartData, uint cEndKeyColumns, void* pEndData, uint dwRangeOptions);
}

const GUID IID_ICommand = {0x0C733A63, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733A63, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface ICommand : IUnknown
{
    HRESULT Cancel();
    HRESULT Execute(IUnknown pUnkOuter, const(Guid)* riid, DBPARAMS* pParams, int* pcRowsAffected, IUnknown* ppRowset);
    HRESULT GetDBSession(const(Guid)* riid, IUnknown* ppSession);
}

enum DBRESULTFLAGENUM
{
    DBRESULTFLAG_DEFAULT = 0,
    DBRESULTFLAG_ROWSET = 1,
    DBRESULTFLAG_ROW = 2,
}

const GUID IID_IMultipleResults = {0x0C733A90, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733A90, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface IMultipleResults : IUnknown
{
    HRESULT GetResult(IUnknown pUnkOuter, int lResultFlag, const(Guid)* riid, int* pcRowsAffected, IUnknown* ppRowset);
}

enum DBCONVERTFLAGSENUM
{
    DBCONVERTFLAGS_COLUMN = 0,
    DBCONVERTFLAGS_PARAMETER = 1,
}

enum DBCONVERTFLAGSENUM20
{
    DBCONVERTFLAGS_ISLONG = 2,
    DBCONVERTFLAGS_ISFIXEDLENGTH = 4,
    DBCONVERTFLAGS_FROMVARIANT = 8,
}

const GUID IID_IConvertType = {0x0C733A88, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733A88, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface IConvertType : IUnknown
{
    HRESULT CanConvert(ushort wFromType, ushort wToType, uint dwConvertFlags);
}

const GUID IID_ICommandPrepare = {0x0C733A26, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733A26, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface ICommandPrepare : IUnknown
{
    HRESULT Prepare(uint cExpectedRuns);
    HRESULT Unprepare();
}

const GUID IID_ICommandProperties = {0x0C733A79, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733A79, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface ICommandProperties : IUnknown
{
    HRESULT GetProperties(const(uint) cPropertyIDSets, char* rgPropertyIDSets, uint* pcPropertySets, DBPROPSET** prgPropertySets);
    HRESULT SetProperties(uint cPropertySets, char* rgPropertySets);
}

const GUID IID_ICommandText = {0x0C733A27, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733A27, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface ICommandText : ICommand
{
    HRESULT GetCommandText(Guid* pguidDialect, ushort** ppwszCommand);
    HRESULT SetCommandText(const(Guid)* rguidDialect, ushort* pwszCommand);
}

struct DBPARAMBINDINFO
{
    ushort* pwszDataSourceType;
    ushort* pwszName;
    uint ulParamSize;
    uint dwFlags;
    ubyte bPrecision;
    ubyte bScale;
}

const GUID IID_ICommandWithParameters = {0x0C733A64, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733A64, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface ICommandWithParameters : IUnknown
{
    HRESULT GetParameterInfo(uint* pcParams, DBPARAMINFO** prgParamInfo, ushort** ppNamesBuffer);
    HRESULT MapParameterNames(uint cParamNames, char* rgParamNames, char* rgParamOrdinals);
    HRESULT SetParameterInfo(uint cParams, char* rgParamOrdinals, char* rgParamBindInfo);
}

const GUID IID_IColumnsRowset = {0x0C733A10, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733A10, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface IColumnsRowset : IUnknown
{
    HRESULT GetAvailableColumns(uint* pcOptColumns, DBID** prgOptColumns);
    HRESULT GetColumnsRowset(IUnknown pUnkOuter, uint cOptColumns, char* rgOptColumns, const(Guid)* riid, uint cPropertySets, char* rgPropertySets, IUnknown* ppColRowset);
}

const GUID IID_IColumnsInfo = {0x0C733A11, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733A11, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface IColumnsInfo : IUnknown
{
    HRESULT GetColumnInfo(uint* pcColumns, DBCOLUMNINFO** prgInfo, ushort** ppStringsBuffer);
    HRESULT MapColumnIDs(uint cColumnIDs, char* rgColumnIDs, char* rgColumns);
}

const GUID IID_IDBCreateCommand = {0x0C733A1D, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733A1D, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface IDBCreateCommand : IUnknown
{
    HRESULT CreateCommand(IUnknown pUnkOuter, const(Guid)* riid, IUnknown* ppCommand);
}

const GUID IID_IDBCreateSession = {0x0C733A5D, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733A5D, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface IDBCreateSession : IUnknown
{
    HRESULT CreateSession(IUnknown pUnkOuter, const(Guid)* riid, IUnknown* ppDBSession);
}

enum DBSOURCETYPEENUM
{
    DBSOURCETYPE_DATASOURCE = 1,
    DBSOURCETYPE_ENUMERATOR = 2,
}

enum DBSOURCETYPEENUM20
{
    DBSOURCETYPE_DATASOURCE_TDP = 1,
    DBSOURCETYPE_DATASOURCE_MDP = 3,
}

enum DBSOURCETYPEENUM25
{
    DBSOURCETYPE_BINDER = 4,
}

const GUID IID_ISourcesRowset = {0x0C733A1E, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733A1E, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface ISourcesRowset : IUnknown
{
    HRESULT GetSourcesRowset(IUnknown pUnkOuter, const(Guid)* riid, uint cPropertySets, char* rgProperties, IUnknown* ppSourcesRowset);
}

const GUID IID_IDBProperties = {0x0C733A8A, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733A8A, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface IDBProperties : IUnknown
{
    HRESULT GetProperties(uint cPropertyIDSets, char* rgPropertyIDSets, uint* pcPropertySets, DBPROPSET** prgPropertySets);
    HRESULT GetPropertyInfo(uint cPropertyIDSets, char* rgPropertyIDSets, uint* pcPropertyInfoSets, DBPROPINFOSET** prgPropertyInfoSets, ushort** ppDescBuffer);
    HRESULT SetProperties(uint cPropertySets, char* rgPropertySets);
}

const GUID IID_IDBInitialize = {0x0C733A8B, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733A8B, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface IDBInitialize : IUnknown
{
    HRESULT Initialize();
    HRESULT Uninitialize();
}

enum DBLITERALENUM
{
    DBLITERAL_INVALID = 0,
    DBLITERAL_BINARY_LITERAL = 1,
    DBLITERAL_CATALOG_NAME = 2,
    DBLITERAL_CATALOG_SEPARATOR = 3,
    DBLITERAL_CHAR_LITERAL = 4,
    DBLITERAL_COLUMN_ALIAS = 5,
    DBLITERAL_COLUMN_NAME = 6,
    DBLITERAL_CORRELATION_NAME = 7,
    DBLITERAL_CURSOR_NAME = 8,
    DBLITERAL_ESCAPE_PERCENT = 9,
    DBLITERAL_ESCAPE_UNDERSCORE = 10,
    DBLITERAL_INDEX_NAME = 11,
    DBLITERAL_LIKE_PERCENT = 12,
    DBLITERAL_LIKE_UNDERSCORE = 13,
    DBLITERAL_PROCEDURE_NAME = 14,
    DBLITERAL_QUOTE = 15,
    DBLITERAL_SCHEMA_NAME = 16,
    DBLITERAL_TABLE_NAME = 17,
    DBLITERAL_TEXT_COMMAND = 18,
    DBLITERAL_USER_NAME = 19,
    DBLITERAL_VIEW_NAME = 20,
}

enum DBLITERALENUM20
{
    DBLITERAL_CUBE_NAME = 21,
    DBLITERAL_DIMENSION_NAME = 22,
    DBLITERAL_HIERARCHY_NAME = 23,
    DBLITERAL_LEVEL_NAME = 24,
    DBLITERAL_MEMBER_NAME = 25,
    DBLITERAL_PROPERTY_NAME = 26,
    DBLITERAL_SCHEMA_SEPARATOR = 27,
    DBLITERAL_QUOTE_SUFFIX = 28,
}

enum DBLITERALENUM21
{
    DBLITERAL_ESCAPE_PERCENT_SUFFIX = 29,
    DBLITERAL_ESCAPE_UNDERSCORE_SUFFIX = 30,
}

struct DBLITERALINFO
{
    ushort* pwszLiteralValue;
    ushort* pwszInvalidChars;
    ushort* pwszInvalidStartingChars;
    uint lt;
    BOOL fSupported;
    uint cchMaxLen;
}

const GUID IID_IDBInfo = {0x0C733A89, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733A89, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface IDBInfo : IUnknown
{
    HRESULT GetKeywords(ushort** ppwszKeywords);
    HRESULT GetLiteralInfo(uint cLiterals, char* rgLiterals, uint* pcLiteralInfo, DBLITERALINFO** prgLiteralInfo, ushort** ppCharBuffer);
}

const GUID IID_IDBDataSourceAdmin = {0x0C733A7A, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733A7A, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface IDBDataSourceAdmin : IUnknown
{
    HRESULT CreateDataSource(uint cPropertySets, char* rgPropertySets, IUnknown pUnkOuter, const(Guid)* riid, IUnknown* ppDBSession);
    HRESULT DestroyDataSource();
    HRESULT GetCreationProperties(uint cPropertyIDSets, char* rgPropertyIDSets, uint* pcPropertyInfoSets, DBPROPINFOSET** prgPropertyInfoSets, ushort** ppDescBuffer);
    HRESULT ModifyDataSource(uint cPropertySets, char* rgPropertySets);
}

const GUID IID_IDBAsynchNotify = {0x0C733A96, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733A96, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface IDBAsynchNotify : IUnknown
{
    HRESULT OnLowResource(uint dwReserved);
    HRESULT OnProgress(uint hChapter, uint eOperation, uint ulProgress, uint ulProgressMax, uint eAsynchPhase, ushort* pwszStatusText);
    HRESULT OnStop(uint hChapter, uint eOperation, HRESULT hrStatus, ushort* pwszStatusText);
}

const GUID IID_IDBAsynchStatus = {0x0C733A95, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733A95, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface IDBAsynchStatus : IUnknown
{
    HRESULT Abort(uint hChapter, uint eOperation);
    HRESULT GetStatus(uint hChapter, uint eOperation, uint* pulProgress, uint* pulProgressMax, uint* peAsynchPhase, ushort** ppwszStatusText);
}

const GUID IID_ISessionProperties = {0x0C733A85, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733A85, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface ISessionProperties : IUnknown
{
    HRESULT GetProperties(uint cPropertyIDSets, char* rgPropertyIDSets, uint* pcPropertySets, DBPROPSET** prgPropertySets);
    HRESULT SetProperties(uint cPropertySets, char* rgPropertySets);
}

const GUID IID_IIndexDefinition = {0x0C733A68, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733A68, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface IIndexDefinition : IUnknown
{
    HRESULT CreateIndex(DBID* pTableID, DBID* pIndexID, uint cIndexColumnDescs, char* rgIndexColumnDescs, uint cPropertySets, char* rgPropertySets, DBID** ppIndexID);
    HRESULT DropIndex(DBID* pTableID, DBID* pIndexID);
}

const GUID IID_ITableDefinition = {0x0C733A86, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733A86, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface ITableDefinition : IUnknown
{
    HRESULT CreateTable(IUnknown pUnkOuter, DBID* pTableID, uint cColumnDescs, char* rgColumnDescs, const(Guid)* riid, uint cPropertySets, char* rgPropertySets, DBID** ppTableID, IUnknown* ppRowset);
    HRESULT DropTable(DBID* pTableID);
    HRESULT AddColumn(DBID* pTableID, DBCOLUMNDESC* pColumnDesc, DBID** ppColumnID);
    HRESULT DropColumn(DBID* pTableID, DBID* pColumnID);
}

const GUID IID_IOpenRowset = {0x0C733A69, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733A69, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface IOpenRowset : IUnknown
{
    HRESULT OpenRowset(IUnknown pUnkOuter, DBID* pTableID, DBID* pIndexID, const(Guid)* riid, uint cPropertySets, char* rgPropertySets, IUnknown* ppRowset);
}

const GUID IID_IDBSchemaRowset = {0x0C733A7B, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733A7B, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface IDBSchemaRowset : IUnknown
{
    HRESULT GetRowset(IUnknown pUnkOuter, const(Guid)* rguidSchema, uint cRestrictions, char* rgRestrictions, const(Guid)* riid, uint cPropertySets, char* rgPropertySets, IUnknown* ppRowset);
    HRESULT GetSchemas(uint* pcSchemas, Guid** prgSchemas, uint** prgRestrictionSupport);
}

const GUID IID_IMDDataset = {0xA07CCCD1, 0x8148, 0x11D0, [0x87, 0xBB, 0x00, 0xC0, 0x4F, 0xC3, 0x39, 0x42]};
@GUID(0xA07CCCD1, 0x8148, 0x11D0, [0x87, 0xBB, 0x00, 0xC0, 0x4F, 0xC3, 0x39, 0x42]);
interface IMDDataset : IUnknown
{
    HRESULT FreeAxisInfo(uint cAxes, MDAXISINFO* rgAxisInfo);
    HRESULT GetAxisInfo(uint* pcAxes, MDAXISINFO** prgAxisInfo);
    HRESULT GetAxisRowset(IUnknown pUnkOuter, uint iAxis, const(Guid)* riid, uint cPropertySets, DBPROPSET* rgPropertySets, IUnknown* ppRowset);
    HRESULT GetCellData(uint hAccessor, uint ulStartCell, uint ulEndCell, void* pData);
    HRESULT GetSpecification(const(Guid)* riid, IUnknown* ppSpecification);
}

const GUID IID_IMDFind = {0xA07CCCD2, 0x8148, 0x11D0, [0x87, 0xBB, 0x00, 0xC0, 0x4F, 0xC3, 0x39, 0x42]};
@GUID(0xA07CCCD2, 0x8148, 0x11D0, [0x87, 0xBB, 0x00, 0xC0, 0x4F, 0xC3, 0x39, 0x42]);
interface IMDFind : IUnknown
{
    HRESULT FindCell(uint ulStartingOrdinal, uint cMembers, ushort** rgpwszMember, uint* pulCellOrdinal);
    HRESULT FindTuple(uint ulAxisIdentifier, uint ulStartingOrdinal, uint cMembers, ushort** rgpwszMember, uint* pulTupleOrdinal);
}

const GUID IID_IMDRangeRowset = {0x0C733AA0, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733AA0, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface IMDRangeRowset : IUnknown
{
    HRESULT GetRangeRowset(IUnknown pUnkOuter, uint ulStartCell, uint ulEndCell, const(Guid)* riid, uint cPropertySets, DBPROPSET* rgPropertySets, IUnknown* ppRowset);
}

const GUID IID_IAlterTable = {0x0C733AA5, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733AA5, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface IAlterTable : IUnknown
{
    HRESULT AlterColumn(DBID* pTableId, DBID* pColumnId, uint dwColumnDescFlags, DBCOLUMNDESC* pColumnDesc);
    HRESULT AlterTable(DBID* pTableId, DBID* pNewTableId, uint cPropertySets, DBPROPSET* rgPropertySets);
}

const GUID IID_IAlterIndex = {0x0C733AA6, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733AA6, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface IAlterIndex : IUnknown
{
    HRESULT AlterIndex(DBID* pTableId, DBID* pIndexId, DBID* pNewIndexId, uint cPropertySets, DBPROPSET* rgPropertySets);
}

const GUID IID_IRowsetChapterMember = {0x0C733AA8, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733AA8, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface IRowsetChapterMember : IUnknown
{
    HRESULT IsRowInChapter(uint hChapter, uint hRow);
}

const GUID IID_ICommandPersist = {0x0C733AA7, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733AA7, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface ICommandPersist : IUnknown
{
    HRESULT DeleteCommand(DBID* pCommandID);
    HRESULT GetCurrentCommand(DBID** ppCommandID);
    HRESULT LoadCommand(DBID* pCommandID, uint dwFlags);
    HRESULT SaveCommand(DBID* pCommandID, uint dwFlags);
}

const GUID IID_IRowsetRefresh = {0x0C733AA9, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733AA9, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface IRowsetRefresh : IUnknown
{
    HRESULT RefreshVisibleData(uint hChapter, uint cRows, const(uint)* rghRows, BOOL fOverWrite, uint* pcRowsRefreshed, uint** prghRowsRefreshed, uint** prgRowStatus);
    HRESULT GetLastVisibleData(uint hRow, uint hAccessor, void* pData);
}

const GUID IID_IParentRowset = {0x0C733AAA, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733AAA, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface IParentRowset : IUnknown
{
    HRESULT GetChildRowset(IUnknown pUnkOuter, uint iOrdinal, const(Guid)* riid, IUnknown* ppRowset);
}

struct ERRORINFO
{
    HRESULT hrError;
    uint dwMinor;
    Guid clsid;
    Guid iid;
    int dispid;
}

const GUID IID_IErrorRecords = {0x0C733A67, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733A67, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface IErrorRecords : IUnknown
{
    HRESULT AddErrorRecord(ERRORINFO* pErrorInfo, uint dwLookupID, DISPPARAMS* pdispparams, IUnknown punkCustomError, uint dwDynamicErrorID);
    HRESULT GetBasicErrorInfo(uint ulRecordNum, ERRORINFO* pErrorInfo);
    HRESULT GetCustomErrorObject(uint ulRecordNum, const(Guid)* riid, IUnknown* ppObject);
    HRESULT GetErrorInfo(uint ulRecordNum, uint lcid, IErrorInfo* ppErrorInfo);
    HRESULT GetErrorParameters(uint ulRecordNum, DISPPARAMS* pdispparams);
    HRESULT GetRecordCount(uint* pcRecords);
}

const GUID IID_IErrorLookup = {0x0C733A66, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733A66, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface IErrorLookup : IUnknown
{
    HRESULT GetErrorDescription(HRESULT hrError, uint dwLookupID, DISPPARAMS* pdispparams, uint lcid, BSTR* pbstrSource, BSTR* pbstrDescription);
    HRESULT GetHelpInfo(HRESULT hrError, uint dwLookupID, uint lcid, BSTR* pbstrHelpFile, uint* pdwHelpContext);
    HRESULT ReleaseErrors(const(uint) dwDynamicErrorID);
}

const GUID IID_ISQLErrorInfo = {0x0C733A74, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733A74, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface ISQLErrorInfo : IUnknown
{
    HRESULT GetSQLInfo(BSTR* pbstrSQLState, int* plNativeError);
}

const GUID IID_IGetDataSource = {0x0C733A75, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733A75, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface IGetDataSource : IUnknown
{
    HRESULT GetDataSource(const(Guid)* riid, IUnknown* ppDataSource);
}

const GUID IID_ITransactionLocal = {0x0C733A5F, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733A5F, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface ITransactionLocal : ITransaction
{
    HRESULT GetOptionsObject(ITransactionOptions* ppOptions);
    HRESULT StartTransaction(int isoLevel, uint isoFlags, ITransactionOptions pOtherOptions, uint* pulTransactionLevel);
}

const GUID IID_ITransactionJoin = {0x0C733A5E, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733A5E, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface ITransactionJoin : IUnknown
{
    HRESULT GetOptionsObject(ITransactionOptions* ppOptions);
    HRESULT JoinTransaction(IUnknown punkTransactionCoord, int isoLevel, uint isoFlags, ITransactionOptions pOtherOptions);
}

const GUID IID_ITransactionObject = {0x0C733A60, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733A60, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface ITransactionObject : IUnknown
{
    HRESULT GetTransactionObject(uint ulTransactionLevel, ITransaction* ppTransactionObject);
}

const GUID IID_ITrusteeAdmin = {0x0C733AA1, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733AA1, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface ITrusteeAdmin : IUnknown
{
    HRESULT CompareTrustees(TRUSTEE_W* pTrustee1, TRUSTEE_W* pTrustee2);
    HRESULT CreateTrustee(TRUSTEE_W* pTrustee, uint cPropertySets, DBPROPSET* rgPropertySets);
    HRESULT DeleteTrustee(TRUSTEE_W* pTrustee);
    HRESULT SetTrusteeProperties(TRUSTEE_W* pTrustee, uint cPropertySets, DBPROPSET* rgPropertySets);
    HRESULT GetTrusteeProperties(TRUSTEE_W* pTrustee, const(uint) cPropertyIDSets, const(DBPROPIDSET)* rgPropertyIDSets, uint* pcPropertySets, DBPROPSET** prgPropertySets);
}

const GUID IID_ITrusteeGroupAdmin = {0x0C733AA2, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733AA2, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface ITrusteeGroupAdmin : IUnknown
{
    HRESULT AddMember(TRUSTEE_W* pMembershipTrustee, TRUSTEE_W* pMemberTrustee);
    HRESULT DeleteMember(TRUSTEE_W* pMembershipTrustee, TRUSTEE_W* pMemberTrustee);
    HRESULT IsMember(TRUSTEE_W* pMembershipTrustee, TRUSTEE_W* pMemberTrustee, int* pfStatus);
    HRESULT GetMembers(TRUSTEE_W* pMembershipTrustee, uint* pcMembers, TRUSTEE_W** prgMembers);
    HRESULT GetMemberships(TRUSTEE_W* pTrustee, uint* pcMemberships, TRUSTEE_W** prgMemberships);
}

const GUID IID_IObjectAccessControl = {0x0C733AA3, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733AA3, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface IObjectAccessControl : IUnknown
{
    HRESULT GetObjectAccessRights(SEC_OBJECT* pObject, uint* pcAccessEntries, EXPLICIT_ACCESS_W** prgAccessEntries);
    HRESULT GetObjectOwner(SEC_OBJECT* pObject, TRUSTEE_W** ppOwner);
    HRESULT IsObjectAccessAllowed(SEC_OBJECT* pObject, EXPLICIT_ACCESS_W* pAccessEntry, int* pfResult);
    HRESULT SetObjectAccessRights(SEC_OBJECT* pObject, uint cAccessEntries, EXPLICIT_ACCESS_W* prgAccessEntries);
    HRESULT SetObjectOwner(SEC_OBJECT* pObject, TRUSTEE_W* pOwner);
}

enum ACCESS_MASKENUM
{
    PERM_EXCLUSIVE = 512,
    PERM_READDESIGN = 1024,
    PERM_WRITEDESIGN = 2048,
    PERM_WITHGRANT = 4096,
    PERM_REFERENCE = 8192,
    PERM_CREATE = 16384,
    PERM_INSERT = 32768,
    PERM_DELETE = 65536,
    PERM_READCONTROL = 131072,
    PERM_WRITEPERMISSIONS = 262144,
    PERM_WRITEOWNER = 524288,
    PERM_MAXIMUM_ALLOWED = 33554432,
    PERM_ALL = 268435456,
    PERM_EXECUTE = 536870912,
    PERM_READ = -2147483648,
    PERM_UPDATE = 1073741824,
    PERM_DROP = 256,
}

const GUID IID_ISecurityInfo = {0x0C733AA4, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733AA4, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface ISecurityInfo : IUnknown
{
    HRESULT GetCurrentTrustee(TRUSTEE_W** ppTrustee);
    HRESULT GetObjectTypes(uint* cObjectTypes, Guid** rgObjectTypes);
    HRESULT GetPermissions(Guid ObjectType, uint* pPermissions);
}

const GUID IID_ITableCreation = {0x0C733ABC, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733ABC, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface ITableCreation : ITableDefinition
{
    HRESULT GetTableDefinition(DBID* pTableID, uint* pcColumnDescs, char* prgColumnDescs, uint* pcPropertySets, char* prgPropertySets, uint* pcConstraintDescs, char* prgConstraintDescs, ushort** ppwszStringBuffer);
}

const GUID IID_ITableDefinitionWithConstraints = {0x0C733AAB, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733AAB, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface ITableDefinitionWithConstraints : ITableCreation
{
    HRESULT AddConstraint(DBID* pTableID, DBCONSTRAINTDESC* pConstraintDesc);
    HRESULT CreateTableWithConstraints(IUnknown pUnkOuter, DBID* pTableID, uint cColumnDescs, DBCOLUMNDESC* rgColumnDescs, uint cConstraintDescs, DBCONSTRAINTDESC* rgConstraintDescs, const(Guid)* riid, uint cPropertySets, DBPROPSET* rgPropertySets, DBID** ppTableID, IUnknown* ppRowset);
    HRESULT DropConstraint(DBID* pTableID, DBID* pConstraintID);
}

const GUID IID_IRow = {0x0C733AB4, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733AB4, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface IRow : IUnknown
{
    HRESULT GetColumns(uint cColumns, char* rgColumns);
    HRESULT GetSourceRowset(const(Guid)* riid, IUnknown* ppRowset, uint* phRow);
    HRESULT Open(IUnknown pUnkOuter, DBID* pColumnID, const(Guid)* rguidColumnType, uint dwBindFlags, const(Guid)* riid, IUnknown* ppUnk);
}

const GUID IID_IRowChange = {0x0C733AB5, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733AB5, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface IRowChange : IUnknown
{
    HRESULT SetColumns(uint cColumns, char* rgColumns);
}

const GUID IID_IRowSchemaChange = {0x0C733AAE, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733AAE, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface IRowSchemaChange : IRowChange
{
    HRESULT DeleteColumns(uint cColumns, const(DBID)* rgColumnIDs, uint* rgdwStatus);
    HRESULT AddColumns(uint cColumns, const(DBCOLUMNINFO)* rgNewColumnInfo, DBCOLUMNACCESS* rgColumns);
}

const GUID IID_IGetRow = {0x0C733AAF, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733AAF, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface IGetRow : IUnknown
{
    HRESULT GetRowFromHROW(IUnknown pUnkOuter, uint hRow, const(Guid)* riid, IUnknown* ppUnk);
    HRESULT GetURLFromHROW(uint hRow, ushort** ppwszURL);
}

const GUID IID_IBindResource = {0x0C733AB1, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733AB1, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface IBindResource : IUnknown
{
    HRESULT Bind(IUnknown pUnkOuter, ushort* pwszURL, uint dwBindURLFlags, const(Guid)* rguid, const(Guid)* riid, IAuthenticate pAuthenticate, DBIMPLICITSESSION* pImplSession, uint* pdwBindStatus, IUnknown* ppUnk);
}

enum DBCOPYFLAGSENUM
{
    DBCOPY_ASYNC = 256,
    DBCOPY_REPLACE_EXISTING = 512,
    DBCOPY_ALLOW_EMULATION = 1024,
    DBCOPY_NON_RECURSIVE = 2048,
    DBCOPY_ATOMIC = 4096,
}

enum DBMOVEFLAGSENUM
{
    DBMOVE_REPLACE_EXISTING = 1,
    DBMOVE_ASYNC = 256,
    DBMOVE_DONT_UPDATE_LINKS = 512,
    DBMOVE_ALLOW_EMULATION = 1024,
    DBMOVE_ATOMIC = 4096,
}

enum DBDELETEFLAGSENUM
{
    DBDELETE_ASYNC = 256,
    DBDELETE_ATOMIC = 4096,
}

const GUID IID_IScopedOperations = {0x0C733AB0, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733AB0, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface IScopedOperations : IBindResource
{
    HRESULT Copy(uint cRows, char* rgpwszSourceURLs, char* rgpwszDestURLs, uint dwCopyFlags, IAuthenticate pAuthenticate, char* rgdwStatus, char* rgpwszNewURLs, ushort** ppStringsBuffer);
    HRESULT Move(uint cRows, char* rgpwszSourceURLs, char* rgpwszDestURLs, uint dwMoveFlags, IAuthenticate pAuthenticate, char* rgdwStatus, char* rgpwszNewURLs, ushort** ppStringsBuffer);
    HRESULT Delete(uint cRows, char* rgpwszURLs, uint dwDeleteFlags, char* rgdwStatus);
    HRESULT OpenRowset(IUnknown pUnkOuter, DBID* pTableID, DBID* pIndexID, const(Guid)* riid, uint cPropertySets, char* rgPropertySets, IUnknown* ppRowset);
}

const GUID IID_ICreateRow = {0x0C733AB2, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733AB2, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface ICreateRow : IUnknown
{
    HRESULT CreateRow(IUnknown pUnkOuter, ushort* pwszURL, uint dwBindURLFlags, const(Guid)* rguid, const(Guid)* riid, IAuthenticate pAuthenticate, DBIMPLICITSESSION* pImplSession, uint* pdwBindStatus, ushort** ppwszNewURL, IUnknown* ppUnk);
}

const GUID IID_IDBBinderProperties = {0x0C733AB3, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733AB3, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface IDBBinderProperties : IDBProperties
{
    HRESULT Reset();
}

const GUID IID_IColumnsInfo2 = {0x0C733AB8, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733AB8, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface IColumnsInfo2 : IColumnsInfo
{
    HRESULT GetRestrictedColumnInfo(uint cColumnIDMasks, char* rgColumnIDMasks, uint dwFlags, uint* pcColumns, DBID** prgColumnIDs, DBCOLUMNINFO** prgColumnInfo, ushort** ppStringsBuffer);
}

const GUID IID_IRegisterProvider = {0x0C733AB9, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733AB9, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface IRegisterProvider : IUnknown
{
    HRESULT GetURLMapping(ushort* pwszURL, uint dwReserved, Guid* pclsidProvider);
    HRESULT SetURLMapping(ushort* pwszURL, uint dwReserved, const(Guid)* rclsidProvider);
    HRESULT UnregisterProvider(ushort* pwszURL, uint dwReserved, const(Guid)* rclsidProvider);
}

const GUID IID_IGetSession = {0x0C733ABA, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733ABA, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface IGetSession : IUnknown
{
    HRESULT GetSession(const(Guid)* riid, IUnknown* ppSession);
}

const GUID IID_IGetSourceRow = {0x0C733ABB, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733ABB, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface IGetSourceRow : IUnknown
{
    HRESULT GetSourceRow(const(Guid)* riid, IUnknown* ppRow);
}

const GUID IID_IRowsetCurrentIndex = {0x0C733ABD, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733ABD, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface IRowsetCurrentIndex : IRowsetIndex
{
    HRESULT GetIndex(DBID** ppIndexID);
    HRESULT SetIndex(DBID* pIndexID);
}

const GUID IID_ICommandStream = {0x0C733ABF, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733ABF, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface ICommandStream : IUnknown
{
    HRESULT GetCommandStream(Guid* piid, Guid* pguidDialect, IUnknown* ppCommandStream);
    HRESULT SetCommandStream(const(Guid)* riid, const(Guid)* rguidDialect, IUnknown pCommandStream);
}

const GUID IID_IRowsetBookmark = {0x0C733AC2, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]};
@GUID(0x0C733AC2, 0x2A1C, 0x11CE, [0xAD, 0xE5, 0x00, 0xAA, 0x00, 0x44, 0x77, 0x3D]);
interface IRowsetBookmark : IUnknown
{
    HRESULT PositionOnBookmark(uint hChapter, uint cbBookmark, char* pBookmark);
}

const GUID CLSID_QueryParser = {0xB72F8FD8, 0x0FAB, 0x4DD9, [0xBD, 0xBF, 0x24, 0x5A, 0x6C, 0xE1, 0x48, 0x5B]};
@GUID(0xB72F8FD8, 0x0FAB, 0x4DD9, [0xBD, 0xBF, 0x24, 0x5A, 0x6C, 0xE1, 0x48, 0x5B]);
struct QueryParser;

const GUID CLSID_NegationCondition = {0x8DE9C74C, 0x605A, 0x4ACD, [0xBE, 0xE3, 0x2B, 0x22, 0x2A, 0xA2, 0xD2, 0x3D]};
@GUID(0x8DE9C74C, 0x605A, 0x4ACD, [0xBE, 0xE3, 0x2B, 0x22, 0x2A, 0xA2, 0xD2, 0x3D]);
struct NegationCondition;

const GUID CLSID_CompoundCondition = {0x116F8D13, 0x101E, 0x4FA5, [0x84, 0xD4, 0xFF, 0x82, 0x79, 0x38, 0x19, 0x35]};
@GUID(0x116F8D13, 0x101E, 0x4FA5, [0x84, 0xD4, 0xFF, 0x82, 0x79, 0x38, 0x19, 0x35]);
struct CompoundCondition;

const GUID CLSID_LeafCondition = {0x52F15C89, 0x5A17, 0x48E1, [0xBB, 0xCD, 0x46, 0xA3, 0xF8, 0x9C, 0x7C, 0xC2]};
@GUID(0x52F15C89, 0x5A17, 0x48E1, [0xBB, 0xCD, 0x46, 0xA3, 0xF8, 0x9C, 0x7C, 0xC2]);
struct LeafCondition;

const GUID CLSID_ConditionFactory = {0xE03E85B0, 0x7BE3, 0x4000, [0xBA, 0x98, 0x6C, 0x13, 0xDE, 0x9F, 0xA4, 0x86]};
@GUID(0xE03E85B0, 0x7BE3, 0x4000, [0xBA, 0x98, 0x6C, 0x13, 0xDE, 0x9F, 0xA4, 0x86]);
struct ConditionFactory;

const GUID CLSID_Interval = {0xD957171F, 0x4BF9, 0x4DE2, [0xBC, 0xD5, 0xC7, 0x0A, 0x7C, 0xA5, 0x58, 0x36]};
@GUID(0xD957171F, 0x4BF9, 0x4DE2, [0xBC, 0xD5, 0xC7, 0x0A, 0x7C, 0xA5, 0x58, 0x36]);
struct Interval;

const GUID CLSID_QueryParserManager = {0x5088B39A, 0x29B4, 0x4D9D, [0x82, 0x45, 0x4E, 0xE2, 0x89, 0x22, 0x2F, 0x66]};
@GUID(0x5088B39A, 0x29B4, 0x4D9D, [0x82, 0x45, 0x4E, 0xE2, 0x89, 0x22, 0x2F, 0x66]);
struct QueryParserManager;

enum STRUCTURED_QUERY_SYNTAX
{
    SQS_NO_SYNTAX = 0,
    SQS_ADVANCED_QUERY_SYNTAX = 1,
    SQS_NATURAL_QUERY_SYNTAX = 2,
}

enum STRUCTURED_QUERY_SINGLE_OPTION
{
    SQSO_SCHEMA = 0,
    SQSO_LOCALE_WORD_BREAKING = 1,
    SQSO_WORD_BREAKER = 2,
    SQSO_NATURAL_SYNTAX = 3,
    SQSO_AUTOMATIC_WILDCARD = 4,
    SQSO_TRACE_LEVEL = 5,
    SQSO_LANGUAGE_KEYWORDS = 6,
    SQSO_SYNTAX = 7,
    SQSO_TIME_ZONE = 8,
    SQSO_IMPLICIT_CONNECTOR = 9,
    SQSO_CONNECTOR_CASE = 10,
}

enum STRUCTURED_QUERY_MULTIOPTION
{
    SQMO_VIRTUAL_PROPERTY = 0,
    SQMO_DEFAULT_PROPERTY = 1,
    SQMO_GENERATOR_FOR_TYPE = 2,
    SQMO_MAP_PROPERTY = 3,
}

enum STRUCTURED_QUERY_PARSE_ERROR
{
    SQPE_NONE = 0,
    SQPE_EXTRA_OPENING_PARENTHESIS = 1,
    SQPE_EXTRA_CLOSING_PARENTHESIS = 2,
    SQPE_IGNORED_MODIFIER = 3,
    SQPE_IGNORED_CONNECTOR = 4,
    SQPE_IGNORED_KEYWORD = 5,
    SQPE_UNHANDLED = 6,
}

enum STRUCTURED_QUERY_RESOLVE_OPTION
{
    SQRO_DEFAULT = 0,
    SQRO_DONT_RESOLVE_DATETIME = 1,
    SQRO_ALWAYS_ONE_INTERVAL = 2,
    SQRO_DONT_SIMPLIFY_CONDITION_TREES = 4,
    SQRO_DONT_MAP_RELATIONS = 8,
    SQRO_DONT_RESOLVE_RANGES = 16,
    SQRO_DONT_REMOVE_UNRESTRICTED_KEYWORDS = 32,
    SQRO_DONT_SPLIT_WORDS = 64,
    SQRO_IGNORE_PHRASE_ORDER = 128,
    SQRO_ADD_VALUE_TYPE_FOR_PLAIN_VALUES = 256,
    SQRO_ADD_ROBUST_ITEM_NAME = 512,
}

enum CASE_REQUIREMENT
{
    CASE_REQUIREMENT_ANY = 0,
    CASE_REQUIREMENT_UPPER_IF_AQS = 1,
}

enum INTERVAL_LIMIT_KIND
{
    ILK_EXPLICIT_INCLUDED = 0,
    ILK_EXPLICIT_EXCLUDED = 1,
    ILK_NEGATIVE_INFINITY = 2,
    ILK_POSITIVE_INFINITY = 3,
}

enum QUERY_PARSER_MANAGER_OPTION
{
    QPMO_SCHEMA_BINARY_NAME = 0,
    QPMO_PRELOCALIZED_SCHEMA_BINARY_PATH = 1,
    QPMO_UNLOCALIZED_SCHEMA_BINARY_PATH = 2,
    QPMO_LOCALIZED_SCHEMA_BINARY_PATH = 3,
    QPMO_APPEND_LCID_TO_LOCALIZED_PATH = 4,
    QPMO_LOCALIZER_SUPPORT = 5,
}

const GUID IID_IQueryParser = {0x2EBDEE67, 0x3505, 0x43F8, [0x99, 0x46, 0xEA, 0x44, 0xAB, 0xC8, 0xE5, 0xB0]};
@GUID(0x2EBDEE67, 0x3505, 0x43F8, [0x99, 0x46, 0xEA, 0x44, 0xAB, 0xC8, 0xE5, 0xB0]);
interface IQueryParser : IUnknown
{
    HRESULT Parse(const(wchar)* pszInputString, IEnumUnknown pCustomProperties, IQuerySolution* ppSolution);
    HRESULT SetOption(STRUCTURED_QUERY_SINGLE_OPTION option, const(PROPVARIANT)* pOptionValue);
    HRESULT GetOption(STRUCTURED_QUERY_SINGLE_OPTION option, PROPVARIANT* pOptionValue);
    HRESULT SetMultiOption(STRUCTURED_QUERY_MULTIOPTION option, const(wchar)* pszOptionKey, const(PROPVARIANT)* pOptionValue);
    HRESULT GetSchemaProvider(ISchemaProvider* ppSchemaProvider);
    HRESULT RestateToString(ICondition pCondition, BOOL fUseEnglish, ushort** ppszQueryString);
    HRESULT ParsePropertyValue(const(wchar)* pszPropertyName, const(wchar)* pszInputString, IQuerySolution* ppSolution);
    HRESULT RestatePropertyValueToString(ICondition pCondition, BOOL fUseEnglish, ushort** ppszPropertyName, ushort** ppszQueryString);
}

const GUID IID_IConditionFactory = {0xA5EFE073, 0xB16F, 0x474F, [0x9F, 0x3E, 0x9F, 0x8B, 0x49, 0x7A, 0x3E, 0x08]};
@GUID(0xA5EFE073, 0xB16F, 0x474F, [0x9F, 0x3E, 0x9F, 0x8B, 0x49, 0x7A, 0x3E, 0x08]);
interface IConditionFactory : IUnknown
{
    HRESULT MakeNot(ICondition pcSub, BOOL fSimplify, ICondition* ppcResult);
    HRESULT MakeAndOr(CONDITION_TYPE ct, IEnumUnknown peuSubs, BOOL fSimplify, ICondition* ppcResult);
    HRESULT MakeLeaf(const(wchar)* pszPropertyName, CONDITION_OPERATION cop, const(wchar)* pszValueType, const(PROPVARIANT)* ppropvar, IRichChunk pPropertyNameTerm, IRichChunk pOperationTerm, IRichChunk pValueTerm, BOOL fExpand, ICondition* ppcResult);
    HRESULT Resolve(ICondition pc, STRUCTURED_QUERY_RESOLVE_OPTION sqro, const(SYSTEMTIME)* pstReferenceTime, ICondition* ppcResolved);
}

const GUID IID_IQuerySolution = {0xD6EBC66B, 0x8921, 0x4193, [0xAF, 0xDD, 0xA1, 0x78, 0x9F, 0xB7, 0xFF, 0x57]};
@GUID(0xD6EBC66B, 0x8921, 0x4193, [0xAF, 0xDD, 0xA1, 0x78, 0x9F, 0xB7, 0xFF, 0x57]);
interface IQuerySolution : IConditionFactory
{
    HRESULT GetQuery(ICondition* ppQueryNode, IEntity* ppMainType);
    HRESULT GetErrors(const(Guid)* riid, void** ppParseErrors);
    HRESULT GetLexicalData(ushort** ppszInputString, ITokenCollection* ppTokens, uint* plcid, IUnknown* ppWordBreaker);
}

enum CONDITION_CREATION_OPTIONS
{
    CONDITION_CREATION_DEFAULT = 0,
    CONDITION_CREATION_NONE = 0,
    CONDITION_CREATION_SIMPLIFY = 1,
    CONDITION_CREATION_VECTOR_AND = 2,
    CONDITION_CREATION_VECTOR_OR = 4,
    CONDITION_CREATION_VECTOR_LEAF = 8,
    CONDITION_CREATION_USE_CONTENT_LOCALE = 16,
}

const GUID IID_IConditionFactory2 = {0x71D222E1, 0x432F, 0x429E, [0x8C, 0x13, 0xB6, 0xDA, 0xFD, 0xE5, 0x07, 0x7A]};
@GUID(0x71D222E1, 0x432F, 0x429E, [0x8C, 0x13, 0xB6, 0xDA, 0xFD, 0xE5, 0x07, 0x7A]);
interface IConditionFactory2 : IConditionFactory
{
    HRESULT CreateTrueFalse(BOOL fVal, CONDITION_CREATION_OPTIONS cco, const(Guid)* riid, void** ppv);
    HRESULT CreateNegation(ICondition pcSub, CONDITION_CREATION_OPTIONS cco, const(Guid)* riid, void** ppv);
    HRESULT CreateCompoundFromObjectArray(CONDITION_TYPE ct, IObjectArray poaSubs, CONDITION_CREATION_OPTIONS cco, const(Guid)* riid, void** ppv);
    HRESULT CreateCompoundFromArray(CONDITION_TYPE ct, ICondition* ppcondSubs, uint cSubs, CONDITION_CREATION_OPTIONS cco, const(Guid)* riid, void** ppv);
    HRESULT CreateStringLeaf(const(PROPERTYKEY)* propkey, CONDITION_OPERATION cop, const(wchar)* pszValue, const(wchar)* pszLocaleName, CONDITION_CREATION_OPTIONS cco, const(Guid)* riid, void** ppv);
    HRESULT CreateIntegerLeaf(const(PROPERTYKEY)* propkey, CONDITION_OPERATION cop, int lValue, CONDITION_CREATION_OPTIONS cco, const(Guid)* riid, void** ppv);
    HRESULT CreateBooleanLeaf(const(PROPERTYKEY)* propkey, CONDITION_OPERATION cop, BOOL fValue, CONDITION_CREATION_OPTIONS cco, const(Guid)* riid, void** ppv);
    HRESULT CreateLeaf(const(PROPERTYKEY)* propkey, CONDITION_OPERATION cop, const(PROPVARIANT)* propvar, const(wchar)* pszSemanticType, const(wchar)* pszLocaleName, IRichChunk pPropertyNameTerm, IRichChunk pOperationTerm, IRichChunk pValueTerm, CONDITION_CREATION_OPTIONS cco, const(Guid)* riid, void** ppv);
    HRESULT ResolveCondition(ICondition pc, STRUCTURED_QUERY_RESOLVE_OPTION sqro, const(SYSTEMTIME)* pstReferenceTime, const(Guid)* riid, void** ppv);
}

const GUID IID_IConditionGenerator = {0x92D2CC58, 0x4386, 0x45A3, [0xB9, 0x8C, 0x7E, 0x0C, 0xE6, 0x4A, 0x41, 0x17]};
@GUID(0x92D2CC58, 0x4386, 0x45A3, [0xB9, 0x8C, 0x7E, 0x0C, 0xE6, 0x4A, 0x41, 0x17]);
interface IConditionGenerator : IUnknown
{
    HRESULT Initialize(ISchemaProvider pSchemaProvider);
    HRESULT RecognizeNamedEntities(const(wchar)* pszInputString, uint lcidUserLocale, ITokenCollection pTokenCollection, INamedEntityCollector pNamedEntities);
    HRESULT GenerateForLeaf(IConditionFactory pConditionFactory, const(wchar)* pszPropertyName, CONDITION_OPERATION cop, const(wchar)* pszValueType, const(wchar)* pszValue, const(wchar)* pszValue2, IRichChunk pPropertyNameTerm, IRichChunk pOperationTerm, IRichChunk pValueTerm, BOOL automaticWildcard, int* pNoStringQuery, ICondition* ppQueryExpression);
    HRESULT DefaultPhrase(const(wchar)* pszValueType, const(PROPVARIANT)* ppropvar, BOOL fUseEnglish, ushort** ppszPhrase);
}

const GUID IID_IInterval = {0x6BF0A714, 0x3C18, 0x430B, [0x8B, 0x5D, 0x83, 0xB1, 0xC2, 0x34, 0xD3, 0xDB]};
@GUID(0x6BF0A714, 0x3C18, 0x430B, [0x8B, 0x5D, 0x83, 0xB1, 0xC2, 0x34, 0xD3, 0xDB]);
interface IInterval : IUnknown
{
    HRESULT GetLimits(INTERVAL_LIMIT_KIND* pilkLower, PROPVARIANT* ppropvarLower, INTERVAL_LIMIT_KIND* pilkUpper, PROPVARIANT* ppropvarUpper);
}

const GUID IID_IMetaData = {0x780102B0, 0xC43B, 0x4876, [0xBC, 0x7B, 0x5E, 0x9B, 0xA5, 0xC8, 0x87, 0x94]};
@GUID(0x780102B0, 0xC43B, 0x4876, [0xBC, 0x7B, 0x5E, 0x9B, 0xA5, 0xC8, 0x87, 0x94]);
interface IMetaData : IUnknown
{
    HRESULT GetData(ushort** ppszKey, ushort** ppszValue);
}

const GUID IID_IEntity = {0x24264891, 0xE80B, 0x4FD3, [0xB7, 0xCE, 0x4F, 0xF2, 0xFA, 0xE8, 0x93, 0x1F]};
@GUID(0x24264891, 0xE80B, 0x4FD3, [0xB7, 0xCE, 0x4F, 0xF2, 0xFA, 0xE8, 0x93, 0x1F]);
interface IEntity : IUnknown
{
    HRESULT Name(ushort** ppszName);
    HRESULT Base(IEntity* pBaseEntity);
    HRESULT Relationships(const(Guid)* riid, void** pRelationships);
    HRESULT GetRelationship(const(wchar)* pszRelationName, IRelationship* pRelationship);
    HRESULT MetaData(const(Guid)* riid, void** pMetaData);
    HRESULT NamedEntities(const(Guid)* riid, void** pNamedEntities);
    HRESULT GetNamedEntity(const(wchar)* pszValue, INamedEntity* ppNamedEntity);
    HRESULT DefaultPhrase(ushort** ppszPhrase);
}

const GUID IID_IRelationship = {0x2769280B, 0x5108, 0x498C, [0x9C, 0x7F, 0xA5, 0x12, 0x39, 0xB6, 0x31, 0x47]};
@GUID(0x2769280B, 0x5108, 0x498C, [0x9C, 0x7F, 0xA5, 0x12, 0x39, 0xB6, 0x31, 0x47]);
interface IRelationship : IUnknown
{
    HRESULT Name(ushort** ppszName);
    HRESULT IsReal(int* pIsReal);
    HRESULT Destination(IEntity* pDestinationEntity);
    HRESULT MetaData(const(Guid)* riid, void** pMetaData);
    HRESULT DefaultPhrase(ushort** ppszPhrase);
}

const GUID IID_INamedEntity = {0xABDBD0B1, 0x7D54, 0x49FB, [0xAB, 0x5C, 0xBF, 0xF4, 0x13, 0x00, 0x04, 0xCD]};
@GUID(0xABDBD0B1, 0x7D54, 0x49FB, [0xAB, 0x5C, 0xBF, 0xF4, 0x13, 0x00, 0x04, 0xCD]);
interface INamedEntity : IUnknown
{
    HRESULT GetValue(ushort** ppszValue);
    HRESULT DefaultPhrase(ushort** ppszPhrase);
}

const GUID IID_ISchemaProvider = {0x8CF89BCB, 0x394C, 0x49B2, [0xAE, 0x28, 0xA5, 0x9D, 0xD4, 0xED, 0x7F, 0x68]};
@GUID(0x8CF89BCB, 0x394C, 0x49B2, [0xAE, 0x28, 0xA5, 0x9D, 0xD4, 0xED, 0x7F, 0x68]);
interface ISchemaProvider : IUnknown
{
    HRESULT Entities(const(Guid)* riid, void** pEntities);
    HRESULT RootEntity(IEntity* pRootEntity);
    HRESULT GetEntity(const(wchar)* pszEntityName, IEntity* pEntity);
    HRESULT MetaData(const(Guid)* riid, void** pMetaData);
    HRESULT Localize(uint lcid, ISchemaLocalizerSupport pSchemaLocalizerSupport);
    HRESULT SaveBinary(const(wchar)* pszSchemaBinaryPath);
    HRESULT LookupAuthoredNamedEntity(IEntity pEntity, const(wchar)* pszInputString, ITokenCollection pTokenCollection, uint cTokensBegin, uint* pcTokensLength, ushort** ppszValue);
}

const GUID IID_ITokenCollection = {0x22D8B4F2, 0xF577, 0x4ADB, [0xA3, 0x35, 0xC2, 0xAE, 0x88, 0x41, 0x6F, 0xAB]};
@GUID(0x22D8B4F2, 0xF577, 0x4ADB, [0xA3, 0x35, 0xC2, 0xAE, 0x88, 0x41, 0x6F, 0xAB]);
interface ITokenCollection : IUnknown
{
    HRESULT NumberOfTokens(uint* pCount);
    HRESULT GetToken(uint i, uint* pBegin, uint* pLength, ushort** ppsz);
}

enum NAMED_ENTITY_CERTAINTY
{
    NEC_LOW = 0,
    NEC_MEDIUM = 1,
    NEC_HIGH = 2,
}

const GUID IID_INamedEntityCollector = {0xAF2440F6, 0x8AFC, 0x47D0, [0x9A, 0x7F, 0x39, 0x6A, 0x0A, 0xCF, 0xB4, 0x3D]};
@GUID(0xAF2440F6, 0x8AFC, 0x47D0, [0x9A, 0x7F, 0x39, 0x6A, 0x0A, 0xCF, 0xB4, 0x3D]);
interface INamedEntityCollector : IUnknown
{
    HRESULT Add(uint beginSpan, uint endSpan, uint beginActual, uint endActual, IEntity pType, const(wchar)* pszValue, NAMED_ENTITY_CERTAINTY certainty);
}

const GUID IID_ISchemaLocalizerSupport = {0xCA3FDCA2, 0xBFBE, 0x4EED, [0x90, 0xD7, 0x0C, 0xAE, 0xF0, 0xA1, 0xBD, 0xA1]};
@GUID(0xCA3FDCA2, 0xBFBE, 0x4EED, [0x90, 0xD7, 0x0C, 0xAE, 0xF0, 0xA1, 0xBD, 0xA1]);
interface ISchemaLocalizerSupport : IUnknown
{
    HRESULT Localize(const(wchar)* pszGlobalString, ushort** ppszLocalString);
}

const GUID IID_IQueryParserManager = {0xA879E3C4, 0xAF77, 0x44FB, [0x8F, 0x37, 0xEB, 0xD1, 0x48, 0x7C, 0xF9, 0x20]};
@GUID(0xA879E3C4, 0xAF77, 0x44FB, [0x8F, 0x37, 0xEB, 0xD1, 0x48, 0x7C, 0xF9, 0x20]);
interface IQueryParserManager : IUnknown
{
    HRESULT CreateLoadedParser(const(wchar)* pszCatalog, ushort langidForKeywords, const(Guid)* riid, void** ppQueryParser);
    HRESULT InitializeOptions(BOOL fUnderstandNQS, BOOL fAutoWildCard, IQueryParser pQueryParser);
    HRESULT SetOption(QUERY_PARSER_MANAGER_OPTION option, const(PROPVARIANT)* pOptionValue);
}

struct HITRANGE
{
    uint iPosition;
    uint cLength;
}

const GUID IID_IUrlAccessor = {0x0B63E318, 0x9CCC, 0x11D0, [0xBC, 0xDB, 0x00, 0x80, 0x5F, 0xCC, 0xCE, 0x04]};
@GUID(0x0B63E318, 0x9CCC, 0x11D0, [0xBC, 0xDB, 0x00, 0x80, 0x5F, 0xCC, 0xCE, 0x04]);
interface IUrlAccessor : IUnknown
{
    HRESULT AddRequestParameter(PROPSPEC* pSpec, PROPVARIANT* pVar);
    HRESULT GetDocFormat(char* wszDocFormat, uint dwSize, uint* pdwLength);
    HRESULT GetCLSID(Guid* pClsid);
    HRESULT GetHost(char* wszHost, uint dwSize, uint* pdwLength);
    HRESULT IsDirectory();
    HRESULT GetSize(ulong* pllSize);
    HRESULT GetLastModified(FILETIME* pftLastModified);
    HRESULT GetFileName(char* wszFileName, uint dwSize, uint* pdwLength);
    HRESULT GetSecurityDescriptor(char* pSD, uint dwSize, uint* pdwLength);
    HRESULT GetRedirectedURL(char* wszRedirectedURL, uint dwSize, uint* pdwLength);
    HRESULT GetSecurityProvider(Guid* pSPClsid);
    HRESULT BindToStream(IStream* ppStream);
    HRESULT BindToFilter(IFilter* ppFilter);
}

const GUID IID_IUrlAccessor2 = {0xC7310734, 0xAC80, 0x11D1, [0x8D, 0xF3, 0x00, 0xC0, 0x4F, 0xB6, 0xEF, 0x4F]};
@GUID(0xC7310734, 0xAC80, 0x11D1, [0x8D, 0xF3, 0x00, 0xC0, 0x4F, 0xB6, 0xEF, 0x4F]);
interface IUrlAccessor2 : IUrlAccessor
{
    HRESULT GetDisplayUrl(char* wszDocUrl, uint dwSize, uint* pdwLength);
    HRESULT IsDocument();
    HRESULT GetCodePage(char* wszCodePage, uint dwSize, uint* pdwLength);
}

const GUID IID_IUrlAccessor3 = {0x6FBC7005, 0x0455, 0x4874, [0xB8, 0xFF, 0x74, 0x39, 0x45, 0x02, 0x41, 0xA3]};
@GUID(0x6FBC7005, 0x0455, 0x4874, [0xB8, 0xFF, 0x74, 0x39, 0x45, 0x02, 0x41, 0xA3]);
interface IUrlAccessor3 : IUrlAccessor2
{
    HRESULT GetImpersonationSidBlobs(const(wchar)* pcwszURL, uint* pcSidCount, BLOB** ppSidBlobs);
}

const GUID IID_IUrlAccessor4 = {0x5CC51041, 0xC8D2, 0x41D7, [0xBC, 0xA3, 0x9E, 0x9E, 0x28, 0x62, 0x97, 0xDC]};
@GUID(0x5CC51041, 0xC8D2, 0x41D7, [0xBC, 0xA3, 0x9E, 0x9E, 0x28, 0x62, 0x97, 0xDC]);
interface IUrlAccessor4 : IUrlAccessor3
{
    HRESULT ShouldIndexItemContent(int* pfIndexContent);
    HRESULT ShouldIndexProperty(const(PROPERTYKEY)* key, int* pfIndexProperty);
}

const GUID IID_IOpLockStatus = {0xC731065D, 0xAC80, 0x11D1, [0x8D, 0xF3, 0x00, 0xC0, 0x4F, 0xB6, 0xEF, 0x4F]};
@GUID(0xC731065D, 0xAC80, 0x11D1, [0x8D, 0xF3, 0x00, 0xC0, 0x4F, 0xB6, 0xEF, 0x4F]);
interface IOpLockStatus : IUnknown
{
    HRESULT IsOplockValid(int* pfIsOplockValid);
    HRESULT IsOplockBroken(int* pfIsOplockBroken);
    HRESULT GetOplockEventHandle(HANDLE* phOplockEv);
}

const GUID IID_ISearchProtocolThreadContext = {0xC73106E1, 0xAC80, 0x11D1, [0x8D, 0xF3, 0x00, 0xC0, 0x4F, 0xB6, 0xEF, 0x4F]};
@GUID(0xC73106E1, 0xAC80, 0x11D1, [0x8D, 0xF3, 0x00, 0xC0, 0x4F, 0xB6, 0xEF, 0x4F]);
interface ISearchProtocolThreadContext : IUnknown
{
    HRESULT ThreadInit();
    HRESULT ThreadShutdown();
    HRESULT ThreadIdle(uint dwTimeElaspedSinceLastCallInMS);
}

struct TIMEOUT_INFO
{
    uint dwSize;
    uint dwConnectTimeout;
    uint dwDataTimeout;
}

enum PROXY_ACCESS
{
    PROXY_ACCESS_PRECONFIG = 0,
    PROXY_ACCESS_DIRECT = 1,
    PROXY_ACCESS_PROXY = 2,
}

struct PROXY_INFO
{
    uint dwSize;
    const(wchar)* pcwszUserAgent;
    PROXY_ACCESS paUseProxy;
    BOOL fLocalBypass;
    uint dwPortNumber;
    const(wchar)* pcwszProxyName;
    const(wchar)* pcwszBypassList;
}

enum AUTH_TYPE
{
    eAUTH_TYPE_ANONYMOUS = 0,
    eAUTH_TYPE_NTLM = 1,
    eAUTH_TYPE_BASIC = 2,
}

struct AUTHENTICATION_INFO
{
    uint dwSize;
    AUTH_TYPE atAuthenticationType;
    const(wchar)* pcwszUser;
    const(wchar)* pcwszPassword;
}

struct INCREMENTAL_ACCESS_INFO
{
    uint dwSize;
    FILETIME ftLastModifiedTime;
}

struct ITEM_INFO
{
    uint dwSize;
    const(wchar)* pcwszFromEMail;
    const(wchar)* pcwszApplicationName;
    const(wchar)* pcwszCatalogName;
    const(wchar)* pcwszContentClass;
}

const GUID IID_ISearchProtocol = {0xC73106BA, 0xAC80, 0x11D1, [0x8D, 0xF3, 0x00, 0xC0, 0x4F, 0xB6, 0xEF, 0x4F]};
@GUID(0xC73106BA, 0xAC80, 0x11D1, [0x8D, 0xF3, 0x00, 0xC0, 0x4F, 0xB6, 0xEF, 0x4F]);
interface ISearchProtocol : IUnknown
{
    HRESULT Init(TIMEOUT_INFO* pTimeoutInfo, IProtocolHandlerSite pProtocolHandlerSite, PROXY_INFO* pProxyInfo);
    HRESULT CreateAccessor(const(wchar)* pcwszURL, AUTHENTICATION_INFO* pAuthenticationInfo, INCREMENTAL_ACCESS_INFO* pIncrementalAccessInfo, ITEM_INFO* pItemInfo, IUrlAccessor* ppAccessor);
    HRESULT CloseAccessor(IUrlAccessor pAccessor);
    HRESULT ShutDown();
}

const GUID IID_ISearchProtocol2 = {0x7789F0B2, 0xB5B2, 0x4722, [0x8B, 0x65, 0x5D, 0xBD, 0x15, 0x06, 0x97, 0xA9]};
@GUID(0x7789F0B2, 0xB5B2, 0x4722, [0x8B, 0x65, 0x5D, 0xBD, 0x15, 0x06, 0x97, 0xA9]);
interface ISearchProtocol2 : ISearchProtocol
{
    HRESULT CreateAccessorEx(const(wchar)* pcwszURL, AUTHENTICATION_INFO* pAuthenticationInfo, INCREMENTAL_ACCESS_INFO* pIncrementalAccessInfo, ITEM_INFO* pItemInfo, const(BLOB)* pUserData, IUrlAccessor* ppAccessor);
}

const GUID IID_IProtocolHandlerSite = {0x0B63E385, 0x9CCC, 0x11D0, [0xBC, 0xDB, 0x00, 0x80, 0x5F, 0xCC, 0xCE, 0x04]};
@GUID(0x0B63E385, 0x9CCC, 0x11D0, [0xBC, 0xDB, 0x00, 0x80, 0x5F, 0xCC, 0xCE, 0x04]);
interface IProtocolHandlerSite : IUnknown
{
    HRESULT GetFilter(Guid* pclsidObj, const(wchar)* pcwszContentType, const(wchar)* pcwszExtension, IFilter* ppFilter);
}

const GUID IID_ISearchRoot = {0x04C18CCF, 0x1F57, 0x4CBD, [0x88, 0xCC, 0x39, 0x00, 0xF5, 0x19, 0x5C, 0xE3]};
@GUID(0x04C18CCF, 0x1F57, 0x4CBD, [0x88, 0xCC, 0x39, 0x00, 0xF5, 0x19, 0x5C, 0xE3]);
interface ISearchRoot : IUnknown
{
    HRESULT put_Schedule(const(wchar)* pszTaskArg);
    HRESULT get_Schedule(ushort** ppszTaskArg);
    HRESULT put_RootURL(const(wchar)* pszURL);
    HRESULT get_RootURL(ushort** ppszURL);
    HRESULT put_IsHierarchical(BOOL fIsHierarchical);
    HRESULT get_IsHierarchical(int* pfIsHierarchical);
    HRESULT put_ProvidesNotifications(BOOL fProvidesNotifications);
    HRESULT get_ProvidesNotifications(int* pfProvidesNotifications);
    HRESULT put_UseNotificationsOnly(BOOL fUseNotificationsOnly);
    HRESULT get_UseNotificationsOnly(int* pfUseNotificationsOnly);
    HRESULT put_EnumerationDepth(uint dwDepth);
    HRESULT get_EnumerationDepth(uint* pdwDepth);
    HRESULT put_HostDepth(uint dwDepth);
    HRESULT get_HostDepth(uint* pdwDepth);
    HRESULT put_FollowDirectories(BOOL fFollowDirectories);
    HRESULT get_FollowDirectories(int* pfFollowDirectories);
    HRESULT put_AuthenticationType(AUTH_TYPE authType);
    HRESULT get_AuthenticationType(AUTH_TYPE* pAuthType);
    HRESULT put_User(const(wchar)* pszUser);
    HRESULT get_User(ushort** ppszUser);
    HRESULT put_Password(const(wchar)* pszPassword);
    HRESULT get_Password(ushort** ppszPassword);
}

const GUID IID_IEnumSearchRoots = {0xAB310581, 0xAC80, 0x11D1, [0x8D, 0xF3, 0x00, 0xC0, 0x4F, 0xB6, 0xEF, 0x52]};
@GUID(0xAB310581, 0xAC80, 0x11D1, [0x8D, 0xF3, 0x00, 0xC0, 0x4F, 0xB6, 0xEF, 0x52]);
interface IEnumSearchRoots : IUnknown
{
    HRESULT Next(uint celt, char* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumSearchRoots* ppenum);
}

enum FOLLOW_FLAGS
{
    FF_INDEXCOMPLEXURLS = 1,
    FF_SUPPRESSINDEXING = 2,
}

const GUID IID_ISearchScopeRule = {0xAB310581, 0xAC80, 0x11D1, [0x8D, 0xF3, 0x00, 0xC0, 0x4F, 0xB6, 0xEF, 0x53]};
@GUID(0xAB310581, 0xAC80, 0x11D1, [0x8D, 0xF3, 0x00, 0xC0, 0x4F, 0xB6, 0xEF, 0x53]);
interface ISearchScopeRule : IUnknown
{
    HRESULT get_PatternOrURL(ushort** ppszPatternOrURL);
    HRESULT get_IsIncluded(int* pfIsIncluded);
    HRESULT get_IsDefault(int* pfIsDefault);
    HRESULT get_FollowFlags(uint* pFollowFlags);
}

const GUID IID_IEnumSearchScopeRules = {0xAB310581, 0xAC80, 0x11D1, [0x8D, 0xF3, 0x00, 0xC0, 0x4F, 0xB6, 0xEF, 0x54]};
@GUID(0xAB310581, 0xAC80, 0x11D1, [0x8D, 0xF3, 0x00, 0xC0, 0x4F, 0xB6, 0xEF, 0x54]);
interface IEnumSearchScopeRules : IUnknown
{
    HRESULT Next(uint celt, char* pprgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumSearchScopeRules* ppenum);
}

enum CLUSION_REASON
{
    CLUSIONREASON_UNKNOWNSCOPE = 0,
    CLUSIONREASON_DEFAULT = 1,
    CLUSIONREASON_USER = 2,
    CLUSIONREASON_GROUPPOLICY = 3,
}

const GUID IID_ISearchCrawlScopeManager = {0xAB310581, 0xAC80, 0x11D1, [0x8D, 0xF3, 0x00, 0xC0, 0x4F, 0xB6, 0xEF, 0x55]};
@GUID(0xAB310581, 0xAC80, 0x11D1, [0x8D, 0xF3, 0x00, 0xC0, 0x4F, 0xB6, 0xEF, 0x55]);
interface ISearchCrawlScopeManager : IUnknown
{
    HRESULT AddDefaultScopeRule(const(wchar)* pszURL, BOOL fInclude, uint fFollowFlags);
    HRESULT AddRoot(ISearchRoot pSearchRoot);
    HRESULT RemoveRoot(const(wchar)* pszURL);
    HRESULT EnumerateRoots(IEnumSearchRoots* ppSearchRoots);
    HRESULT AddHierarchicalScope(const(wchar)* pszURL, BOOL fInclude, BOOL fDefault, BOOL fOverrideChildren);
    HRESULT AddUserScopeRule(const(wchar)* pszURL, BOOL fInclude, BOOL fOverrideChildren, uint fFollowFlags);
    HRESULT RemoveScopeRule(const(wchar)* pszRule);
    HRESULT EnumerateScopeRules(IEnumSearchScopeRules* ppSearchScopeRules);
    HRESULT HasParentScopeRule(const(wchar)* pszURL, int* pfHasParentRule);
    HRESULT HasChildScopeRule(const(wchar)* pszURL, int* pfHasChildRule);
    HRESULT IncludedInCrawlScope(const(wchar)* pszURL, int* pfIsIncluded);
    HRESULT IncludedInCrawlScopeEx(const(wchar)* pszURL, int* pfIsIncluded, CLUSION_REASON* pReason);
    HRESULT RevertToDefaultScopes();
    HRESULT SaveAll();
    HRESULT GetParentScopeVersionId(const(wchar)* pszURL, int* plScopeId);
    HRESULT RemoveDefaultScopeRule(const(wchar)* pszURL);
}

const GUID IID_ISearchCrawlScopeManager2 = {0x6292F7AD, 0x4E19, 0x4717, [0xA5, 0x34, 0x8F, 0xC2, 0x2B, 0xCD, 0x5C, 0xCD]};
@GUID(0x6292F7AD, 0x4E19, 0x4717, [0xA5, 0x34, 0x8F, 0xC2, 0x2B, 0xCD, 0x5C, 0xCD]);
interface ISearchCrawlScopeManager2 : ISearchCrawlScopeManager
{
    HRESULT GetVersion(int** plVersion, HANDLE* phFileMapping);
}

enum SEARCH_KIND_OF_CHANGE
{
    SEARCH_CHANGE_ADD = 0,
    SEARCH_CHANGE_DELETE = 1,
    SEARCH_CHANGE_MODIFY = 2,
    SEARCH_CHANGE_MOVE_RENAME = 3,
    SEARCH_CHANGE_SEMANTICS_DIRECTORY = 262144,
    SEARCH_CHANGE_SEMANTICS_SHALLOW = 524288,
    SEARCH_CHANGE_SEMANTICS_UPDATE_SECURITY = 4194304,
}

enum SEARCH_NOTIFICATION_PRIORITY
{
    SEARCH_NORMAL_PRIORITY = 0,
    SEARCH_HIGH_PRIORITY = 1,
}

struct SEARCH_ITEM_CHANGE
{
    SEARCH_KIND_OF_CHANGE Change;
    SEARCH_NOTIFICATION_PRIORITY Priority;
    BLOB* pUserData;
    const(wchar)* lpwszURL;
    const(wchar)* lpwszOldURL;
}

const GUID IID_ISearchItemsChangedSink = {0xAB310581, 0xAC80, 0x11D1, [0x8D, 0xF3, 0x00, 0xC0, 0x4F, 0xB6, 0xEF, 0x58]};
@GUID(0xAB310581, 0xAC80, 0x11D1, [0x8D, 0xF3, 0x00, 0xC0, 0x4F, 0xB6, 0xEF, 0x58]);
interface ISearchItemsChangedSink : IUnknown
{
    HRESULT StartedMonitoringScope(const(wchar)* pszURL);
    HRESULT StoppedMonitoringScope(const(wchar)* pszURL);
    HRESULT OnItemsChanged(uint dwNumberOfChanges, char* rgDataChangeEntries, char* rgdwDocIds, char* rghrCompletionCodes);
}

struct SEARCH_ITEM_PERSISTENT_CHANGE
{
    SEARCH_KIND_OF_CHANGE Change;
    const(wchar)* URL;
    const(wchar)* OldURL;
    SEARCH_NOTIFICATION_PRIORITY Priority;
}

const GUID IID_ISearchPersistentItemsChangedSink = {0xA2FFDF9B, 0x4758, 0x4F84, [0xB7, 0x29, 0xDF, 0x81, 0xA1, 0xA0, 0x61, 0x2F]};
@GUID(0xA2FFDF9B, 0x4758, 0x4F84, [0xB7, 0x29, 0xDF, 0x81, 0xA1, 0xA0, 0x61, 0x2F]);
interface ISearchPersistentItemsChangedSink : IUnknown
{
    HRESULT StartedMonitoringScope(const(wchar)* pszURL);
    HRESULT StoppedMonitoringScope(const(wchar)* pszURL);
    HRESULT OnItemsChanged(uint dwNumberOfChanges, char* DataChangeEntries, char* hrCompletionCodes);
}

const GUID IID_ISearchViewChangedSink = {0xAB310581, 0xAC80, 0x11D1, [0x8D, 0xF3, 0x00, 0xC0, 0x4F, 0xB6, 0xEF, 0x65]};
@GUID(0xAB310581, 0xAC80, 0x11D1, [0x8D, 0xF3, 0x00, 0xC0, 0x4F, 0xB6, 0xEF, 0x65]);
interface ISearchViewChangedSink : IUnknown
{
    HRESULT OnChange(int* pdwDocID, SEARCH_ITEM_CHANGE* pChange, int* pfInView);
}

enum SEARCH_INDEXING_PHASE
{
    SEARCH_INDEXING_PHASE_GATHERER = 0,
    SEARCH_INDEXING_PHASE_QUERYABLE = 1,
    SEARCH_INDEXING_PHASE_PERSISTED = 2,
}

struct SEARCH_ITEM_INDEXING_STATUS
{
    uint dwDocID;
    HRESULT hrIndexingStatus;
}

const GUID IID_ISearchNotifyInlineSite = {0xB5702E61, 0xE75C, 0x4B64, [0x82, 0xA1, 0x6C, 0xB4, 0xF8, 0x32, 0xFC, 0xCF]};
@GUID(0xB5702E61, 0xE75C, 0x4B64, [0x82, 0xA1, 0x6C, 0xB4, 0xF8, 0x32, 0xFC, 0xCF]);
interface ISearchNotifyInlineSite : IUnknown
{
    HRESULT OnItemIndexedStatusChange(SEARCH_INDEXING_PHASE sipStatus, uint dwNumEntries, char* rgItemStatusEntries);
    HRESULT OnCatalogStatusChange(const(Guid)* guidCatalogResetSignature, const(Guid)* guidCheckPointSignature, uint dwLastCheckPointNumber);
}

enum CatalogStatus
{
    CATALOG_STATUS_IDLE = 0,
    CATALOG_STATUS_PAUSED = 1,
    CATALOG_STATUS_RECOVERING = 2,
    CATALOG_STATUS_FULL_CRAWL = 3,
    CATALOG_STATUS_INCREMENTAL_CRAWL = 4,
    CATALOG_STATUS_PROCESSING_NOTIFICATIONS = 5,
    CATALOG_STATUS_SHUTTING_DOWN = 6,
}

enum CatalogPausedReason
{
    CATALOG_PAUSED_REASON_NONE = 0,
    CATALOG_PAUSED_REASON_HIGH_IO = 1,
    CATALOG_PAUSED_REASON_HIGH_CPU = 2,
    CATALOG_PAUSED_REASON_HIGH_NTF_RATE = 3,
    CATALOG_PAUSED_REASON_LOW_BATTERY = 4,
    CATALOG_PAUSED_REASON_LOW_MEMORY = 5,
    CATALOG_PAUSED_REASON_LOW_DISK = 6,
    CATALOG_PAUSED_REASON_DELAYED_RECOVERY = 7,
    CATALOG_PAUSED_REASON_USER_ACTIVE = 8,
    CATALOG_PAUSED_REASON_EXTERNAL = 9,
    CATALOG_PAUSED_REASON_UPGRADING = 10,
}

const GUID IID_ISearchCatalogManager = {0xAB310581, 0xAC80, 0x11D1, [0x8D, 0xF3, 0x00, 0xC0, 0x4F, 0xB6, 0xEF, 0x50]};
@GUID(0xAB310581, 0xAC80, 0x11D1, [0x8D, 0xF3, 0x00, 0xC0, 0x4F, 0xB6, 0xEF, 0x50]);
interface ISearchCatalogManager : IUnknown
{
    HRESULT get_Name(ushort** pszName);
    HRESULT GetParameter(const(wchar)* pszName, PROPVARIANT** ppValue);
    HRESULT SetParameter(const(wchar)* pszName, PROPVARIANT* pValue);
    HRESULT GetCatalogStatus(CatalogStatus* pStatus, CatalogPausedReason* pPausedReason);
    HRESULT Reset();
    HRESULT Reindex();
    HRESULT ReindexMatchingURLs(const(wchar)* pszPattern);
    HRESULT ReindexSearchRoot(const(wchar)* pszRootURL);
    HRESULT put_ConnectTimeout(uint dwConnectTimeout);
    HRESULT get_ConnectTimeout(uint* pdwConnectTimeout);
    HRESULT put_DataTimeout(uint dwDataTimeout);
    HRESULT get_DataTimeout(uint* pdwDataTimeout);
    HRESULT NumberOfItems(int* plCount);
    HRESULT NumberOfItemsToIndex(int* plIncrementalCount, int* plNotificationQueue, int* plHighPriorityQueue);
    HRESULT URLBeingIndexed(ushort** pszUrl);
    HRESULT GetURLIndexingState(const(wchar)* pszURL, uint* pdwState);
    HRESULT GetPersistentItemsChangedSink(ISearchPersistentItemsChangedSink* ppISearchPersistentItemsChangedSink);
    HRESULT RegisterViewForNotification(const(wchar)* pszView, ISearchViewChangedSink pViewChangedSink, uint* pdwCookie);
    HRESULT GetItemsChangedSink(ISearchNotifyInlineSite pISearchNotifyInlineSite, const(Guid)* riid, void** ppv, Guid* pGUIDCatalogResetSignature, Guid* pGUIDCheckPointSignature, uint* pdwLastCheckPointNumber);
    HRESULT UnregisterViewForNotification(uint dwCookie);
    HRESULT SetExtensionClusion(const(wchar)* pszExtension, BOOL fExclude);
    HRESULT EnumerateExcludedExtensions(IEnumString* ppExtensions);
    HRESULT GetQueryHelper(ISearchQueryHelper* ppSearchQueryHelper);
    HRESULT put_DiacriticSensitivity(BOOL fDiacriticSensitive);
    HRESULT get_DiacriticSensitivity(int* pfDiacriticSensitive);
    HRESULT GetCrawlScopeManager(ISearchCrawlScopeManager* ppCrawlScopeManager);
}

enum tagPRIORITIZE_FLAGS
{
    PRIORITIZE_FLAG_RETRYFAILEDITEMS = 1,
    PRIORITIZE_FLAG_IGNOREFAILURECOUNT = 2,
}

const GUID IID_ISearchCatalogManager2 = {0x7AC3286D, 0x4D1D, 0x4817, [0x84, 0xFC, 0xC1, 0xC8, 0x5E, 0x3A, 0xF0, 0xD9]};
@GUID(0x7AC3286D, 0x4D1D, 0x4817, [0x84, 0xFC, 0xC1, 0xC8, 0x5E, 0x3A, 0xF0, 0xD9]);
interface ISearchCatalogManager2 : ISearchCatalogManager
{
    HRESULT PrioritizeMatchingURLs(const(wchar)* pszPattern, int dwPrioritizeFlags);
}

enum SEARCH_TERM_EXPANSION
{
    SEARCH_TERM_NO_EXPANSION = 0,
    SEARCH_TERM_PREFIX_ALL = 1,
    SEARCH_TERM_STEM_ALL = 2,
}

enum SEARCH_QUERY_SYNTAX
{
    SEARCH_NO_QUERY_SYNTAX = 0,
    SEARCH_ADVANCED_QUERY_SYNTAX = 1,
    SEARCH_NATURAL_QUERY_SYNTAX = 2,
}

struct SEARCH_COLUMN_PROPERTIES
{
    PROPVARIANT Value;
    uint lcid;
}

const GUID IID_ISearchQueryHelper = {0xAB310581, 0xAC80, 0x11D1, [0x8D, 0xF3, 0x00, 0xC0, 0x4F, 0xB6, 0xEF, 0x63]};
@GUID(0xAB310581, 0xAC80, 0x11D1, [0x8D, 0xF3, 0x00, 0xC0, 0x4F, 0xB6, 0xEF, 0x63]);
interface ISearchQueryHelper : IUnknown
{
    HRESULT get_ConnectionString(ushort** pszConnectionString);
    HRESULT put_QueryContentLocale(uint lcid);
    HRESULT get_QueryContentLocale(uint* plcid);
    HRESULT put_QueryKeywordLocale(uint lcid);
    HRESULT get_QueryKeywordLocale(uint* plcid);
    HRESULT put_QueryTermExpansion(SEARCH_TERM_EXPANSION expandTerms);
    HRESULT get_QueryTermExpansion(SEARCH_TERM_EXPANSION* pExpandTerms);
    HRESULT put_QuerySyntax(SEARCH_QUERY_SYNTAX querySyntax);
    HRESULT get_QuerySyntax(SEARCH_QUERY_SYNTAX* pQuerySyntax);
    HRESULT put_QueryContentProperties(const(wchar)* pszContentProperties);
    HRESULT get_QueryContentProperties(ushort** ppszContentProperties);
    HRESULT put_QuerySelectColumns(const(wchar)* pszSelectColumns);
    HRESULT get_QuerySelectColumns(ushort** ppszSelectColumns);
    HRESULT put_QueryWhereRestrictions(const(wchar)* pszRestrictions);
    HRESULT get_QueryWhereRestrictions(ushort** ppszRestrictions);
    HRESULT put_QuerySorting(const(wchar)* pszSorting);
    HRESULT get_QuerySorting(ushort** ppszSorting);
    HRESULT GenerateSQLFromUserQuery(const(wchar)* pszQuery, ushort** ppszSQL);
    HRESULT WriteProperties(int itemID, uint dwNumberOfColumns, char* pColumns, char* pValues, FILETIME* pftGatherModifiedTime);
    HRESULT put_QueryMaxResults(int cMaxResults);
    HRESULT get_QueryMaxResults(int* pcMaxResults);
}

enum PRIORITY_LEVEL
{
    PRIORITY_LEVEL_FOREGROUND = 0,
    PRIORITY_LEVEL_HIGH = 1,
    PRIORITY_LEVEL_LOW = 2,
    PRIORITY_LEVEL_DEFAULT = 3,
}

const GUID IID_IRowsetPrioritization = {0x42811652, 0x079D, 0x481B, [0x87, 0xA2, 0x09, 0xA6, 0x9E, 0xCC, 0x5F, 0x44]};
@GUID(0x42811652, 0x079D, 0x481B, [0x87, 0xA2, 0x09, 0xA6, 0x9E, 0xCC, 0x5F, 0x44]);
interface IRowsetPrioritization : IUnknown
{
    HRESULT SetScopePriority(PRIORITY_LEVEL priority, uint scopeStatisticsEventFrequency);
    HRESULT GetScopePriority(PRIORITY_LEVEL* priority, uint* scopeStatisticsEventFrequency);
    HRESULT GetScopeStatistics(uint* indexedDocumentCount, uint* oustandingAddCount, uint* oustandingModifyCount);
}

enum ROWSETEVENT_ITEMSTATE
{
    ROWSETEVENT_ITEMSTATE_NOTINROWSET = 0,
    ROWSETEVENT_ITEMSTATE_INROWSET = 1,
    ROWSETEVENT_ITEMSTATE_UNKNOWN = 2,
}

enum ROWSETEVENT_TYPE
{
    ROWSETEVENT_TYPE_DATAEXPIRED = 0,
    ROWSETEVENT_TYPE_FOREGROUNDLOST = 1,
    ROWSETEVENT_TYPE_SCOPESTATISTICS = 2,
}

const GUID IID_IRowsetEvents = {0x1551AEA5, 0x5D66, 0x4B11, [0x86, 0xF5, 0xD5, 0x63, 0x4C, 0xB2, 0x11, 0xB9]};
@GUID(0x1551AEA5, 0x5D66, 0x4B11, [0x86, 0xF5, 0xD5, 0x63, 0x4C, 0xB2, 0x11, 0xB9]);
interface IRowsetEvents : IUnknown
{
    HRESULT OnNewItem(const(PROPVARIANT)* itemID, ROWSETEVENT_ITEMSTATE newItemState);
    HRESULT OnChangedItem(const(PROPVARIANT)* itemID, ROWSETEVENT_ITEMSTATE rowsetItemState, ROWSETEVENT_ITEMSTATE changedItemState);
    HRESULT OnDeletedItem(const(PROPVARIANT)* itemID, ROWSETEVENT_ITEMSTATE deletedItemState);
    HRESULT OnRowsetEvent(ROWSETEVENT_TYPE eventType, const(PROPVARIANT)* eventData);
}

const GUID IID_ISearchManager = {0xAB310581, 0xAC80, 0x11D1, [0x8D, 0xF3, 0x00, 0xC0, 0x4F, 0xB6, 0xEF, 0x69]};
@GUID(0xAB310581, 0xAC80, 0x11D1, [0x8D, 0xF3, 0x00, 0xC0, 0x4F, 0xB6, 0xEF, 0x69]);
interface ISearchManager : IUnknown
{
    HRESULT GetIndexerVersionStr(ushort** ppszVersionString);
    HRESULT GetIndexerVersion(uint* pdwMajor, uint* pdwMinor);
    HRESULT GetParameter(const(wchar)* pszName, PROPVARIANT** ppValue);
    HRESULT SetParameter(const(wchar)* pszName, const(PROPVARIANT)* pValue);
    HRESULT get_ProxyName(ushort** ppszProxyName);
    HRESULT get_BypassList(ushort** ppszBypassList);
    HRESULT SetProxy(PROXY_ACCESS sUseProxy, BOOL fLocalByPassProxy, uint dwPortNumber, const(wchar)* pszProxyName, const(wchar)* pszByPassList);
    HRESULT GetCatalog(const(wchar)* pszCatalog, ISearchCatalogManager* ppCatalogManager);
    HRESULT get_UserAgent(ushort** ppszUserAgent);
    HRESULT put_UserAgent(const(wchar)* pszUserAgent);
    HRESULT get_UseProxy(PROXY_ACCESS* pUseProxy);
    HRESULT get_LocalBypass(int* pfLocalBypass);
    HRESULT get_PortNumber(uint* pdwPortNumber);
}

const GUID IID_ISearchManager2 = {0xDBAB3F73, 0xDB19, 0x4A79, [0xBF, 0xC0, 0xA6, 0x1A, 0x93, 0x88, 0x6D, 0xDF]};
@GUID(0xDBAB3F73, 0xDB19, 0x4A79, [0xBF, 0xC0, 0xA6, 0x1A, 0x93, 0x88, 0x6D, 0xDF]);
interface ISearchManager2 : ISearchManager
{
    HRESULT CreateCatalog(const(wchar)* pszCatalog, ISearchCatalogManager* ppCatalogManager);
    HRESULT DeleteCatalog(const(wchar)* pszCatalog);
}

const GUID CLSID_CSearchLanguageSupport = {0x6A68CC80, 0x4337, 0x4DBC, [0xBD, 0x27, 0xFB, 0xFB, 0x10, 0x53, 0x82, 0x0B]};
@GUID(0x6A68CC80, 0x4337, 0x4DBC, [0xBD, 0x27, 0xFB, 0xFB, 0x10, 0x53, 0x82, 0x0B]);
struct CSearchLanguageSupport;

const GUID IID_ISearchLanguageSupport = {0x24C3CBAA, 0xEBC1, 0x491A, [0x9E, 0xF1, 0x9F, 0x6D, 0x8D, 0xEB, 0x1B, 0x8F]};
@GUID(0x24C3CBAA, 0xEBC1, 0x491A, [0x9E, 0xF1, 0x9F, 0x6D, 0x8D, 0xEB, 0x1B, 0x8F]);
interface ISearchLanguageSupport : IUnknown
{
    HRESULT SetDiacriticSensitivity(BOOL fDiacriticSensitive);
    HRESULT GetDiacriticSensitivity(int* pfDiacriticSensitive);
    HRESULT LoadWordBreaker(uint lcid, const(Guid)* riid, void** ppWordBreaker, uint* pLcidUsed);
    HRESULT LoadStemmer(uint lcid, const(Guid)* riid, void** ppStemmer, uint* pLcidUsed);
    HRESULT IsPrefixNormalized(const(wchar)* pwcsQueryToken, uint cwcQueryToken, const(wchar)* pwcsDocumentToken, uint cwcDocumentToken, uint* pulPrefixLength);
}

const GUID CLSID_SubscriptionMgr = {0xABBE31D0, 0x6DAE, 0x11D0, [0xBE, 0xCA, 0x00, 0xC0, 0x4F, 0xD9, 0x40, 0xBE]};
@GUID(0xABBE31D0, 0x6DAE, 0x11D0, [0xBE, 0xCA, 0x00, 0xC0, 0x4F, 0xD9, 0x40, 0xBE]);
struct SubscriptionMgr;

struct ITEMPROP
{
    VARIANT variantValue;
    const(wchar)* pwszName;
}

const GUID IID_IEnumItemProperties = {0xF72C8D96, 0x6DBD, 0x11D1, [0xA1, 0xE8, 0x00, 0xC0, 0x4F, 0xC2, 0xFB, 0xE1]};
@GUID(0xF72C8D96, 0x6DBD, 0x11D1, [0xA1, 0xE8, 0x00, 0xC0, 0x4F, 0xC2, 0xFB, 0xE1]);
interface IEnumItemProperties : IUnknown
{
    HRESULT Next(uint celt, char* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumItemProperties* ppenum);
    HRESULT GetCount(uint* pnCount);
}

struct SUBSCRIPTIONITEMINFO
{
    uint cbSize;
    uint dwFlags;
    uint dwPriority;
    Guid ScheduleGroup;
    Guid clsidAgent;
}

const GUID IID_ISubscriptionItem = {0xA97559F8, 0x6C4A, 0x11D1, [0xA1, 0xE8, 0x00, 0xC0, 0x4F, 0xC2, 0xFB, 0xE1]};
@GUID(0xA97559F8, 0x6C4A, 0x11D1, [0xA1, 0xE8, 0x00, 0xC0, 0x4F, 0xC2, 0xFB, 0xE1]);
interface ISubscriptionItem : IUnknown
{
    HRESULT GetCookie(Guid* pCookie);
    HRESULT GetSubscriptionItemInfo(SUBSCRIPTIONITEMINFO* pSubscriptionItemInfo);
    HRESULT SetSubscriptionItemInfo(const(SUBSCRIPTIONITEMINFO)* pSubscriptionItemInfo);
    HRESULT ReadProperties(uint nCount, char* rgwszName, char* rgValue);
    HRESULT WriteProperties(uint nCount, char* rgwszName, char* rgValue);
    HRESULT EnumProperties(IEnumItemProperties* ppEnumItemProperties);
    HRESULT NotifyChanged();
}

const GUID IID_IEnumSubscription = {0xF72C8D97, 0x6DBD, 0x11D1, [0xA1, 0xE8, 0x00, 0xC0, 0x4F, 0xC2, 0xFB, 0xE1]};
@GUID(0xF72C8D97, 0x6DBD, 0x11D1, [0xA1, 0xE8, 0x00, 0xC0, 0x4F, 0xC2, 0xFB, 0xE1]);
interface IEnumSubscription : IUnknown
{
    HRESULT Next(uint celt, char* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumSubscription* ppenum);
    HRESULT GetCount(uint* pnCount);
}

enum SUBSCRIPTIONTYPE
{
    SUBSTYPE_URL = 0,
    SUBSTYPE_CHANNEL = 1,
    SUBSTYPE_DESKTOPURL = 2,
    SUBSTYPE_EXTERNAL = 3,
    SUBSTYPE_DESKTOPCHANNEL = 4,
}

enum SUBSCRIPTIONINFOFLAGS
{
    SUBSINFO_SCHEDULE = 1,
    SUBSINFO_RECURSE = 2,
    SUBSINFO_WEBCRAWL = 4,
    SUBSINFO_MAILNOT = 8,
    SUBSINFO_MAXSIZEKB = 16,
    SUBSINFO_USER = 32,
    SUBSINFO_PASSWORD = 64,
    SUBSINFO_TASKFLAGS = 256,
    SUBSINFO_GLEAM = 512,
    SUBSINFO_CHANGESONLY = 1024,
    SUBSINFO_CHANNELFLAGS = 2048,
    SUBSINFO_FRIENDLYNAME = 8192,
    SUBSINFO_NEEDPASSWORD = 16384,
    SUBSINFO_TYPE = 32768,
}

enum CREATESUBSCRIPTIONFLAGS
{
    CREATESUBS_ADDTOFAVORITES = 1,
    CREATESUBS_FROMFAVORITES = 2,
    CREATESUBS_NOUI = 4,
    CREATESUBS_NOSAVE = 8,
    CREATESUBS_SOFTWAREUPDATE = 16,
}

enum SUBSCRIPTIONSCHEDULE
{
    SUBSSCHED_AUTO = 0,
    SUBSSCHED_DAILY = 1,
    SUBSSCHED_WEEKLY = 2,
    SUBSSCHED_CUSTOM = 3,
    SUBSSCHED_MANUAL = 4,
}

struct _tagSubscriptionInfo
{
    uint cbSize;
    uint fUpdateFlags;
    SUBSCRIPTIONSCHEDULE schedule;
    Guid customGroupCookie;
    void* pTrigger;
    uint dwRecurseLevels;
    uint fWebcrawlerFlags;
    BOOL bMailNotification;
    BOOL bGleam;
    BOOL bChangesOnly;
    BOOL bNeedPassword;
    uint fChannelFlags;
    BSTR bstrUserName;
    BSTR bstrPassword;
    BSTR bstrFriendlyName;
    uint dwMaxSizeKB;
    SUBSCRIPTIONTYPE subType;
    uint fTaskFlags;
    uint dwReserved;
}

const GUID IID_ISubscriptionMgr = {0x085FB2C0, 0x0DF8, 0x11D1, [0x8F, 0x4B, 0x00, 0xA0, 0xC9, 0x05, 0x41, 0x3F]};
@GUID(0x085FB2C0, 0x0DF8, 0x11D1, [0x8F, 0x4B, 0x00, 0xA0, 0xC9, 0x05, 0x41, 0x3F]);
interface ISubscriptionMgr : IUnknown
{
    HRESULT DeleteSubscription(const(wchar)* pwszURL, HWND hwnd);
    HRESULT UpdateSubscription(const(wchar)* pwszURL);
    HRESULT UpdateAll();
    HRESULT IsSubscribed(const(wchar)* pwszURL, int* pfSubscribed);
    HRESULT GetSubscriptionInfo(const(wchar)* pwszURL, _tagSubscriptionInfo* pInfo);
    HRESULT GetDefaultInfo(SUBSCRIPTIONTYPE subType, _tagSubscriptionInfo* pInfo);
    HRESULT ShowSubscriptionProperties(const(wchar)* pwszURL, HWND hwnd);
    HRESULT CreateSubscription(HWND hwnd, const(wchar)* pwszURL, const(wchar)* pwszFriendlyName, uint dwFlags, SUBSCRIPTIONTYPE subsType, _tagSubscriptionInfo* pInfo);
}

const GUID IID_ISubscriptionMgr2 = {0x614BC270, 0xAEDF, 0x11D1, [0xA1, 0xF9, 0x00, 0xC0, 0x4F, 0xC2, 0xFB, 0xE1]};
@GUID(0x614BC270, 0xAEDF, 0x11D1, [0xA1, 0xF9, 0x00, 0xC0, 0x4F, 0xC2, 0xFB, 0xE1]);
interface ISubscriptionMgr2 : ISubscriptionMgr
{
    HRESULT GetItemFromURL(const(wchar)* pwszURL, ISubscriptionItem* ppSubscriptionItem);
    HRESULT GetItemFromCookie(const(Guid)* pSubscriptionCookie, ISubscriptionItem* ppSubscriptionItem);
    HRESULT GetSubscriptionRunState(uint dwNumCookies, char* pCookies, char* pdwRunState);
    HRESULT EnumSubscriptions(uint dwFlags, IEnumSubscription* ppEnumSubscriptions);
    HRESULT UpdateItems(uint dwFlags, uint dwNumCookies, char* pCookies);
    HRESULT AbortItems(uint dwNumCookies, char* pCookies);
    HRESULT AbortAll();
}

enum DELIVERY_AGENT_FLAGS
{
    DELIVERY_AGENT_FLAG_NO_BROADCAST = 4,
    DELIVERY_AGENT_FLAG_NO_RESTRICTIONS = 8,
    DELIVERY_AGENT_FLAG_SILENT_DIAL = 16,
}

enum WEBCRAWL_RECURSEFLAGS
{
    WEBCRAWL_DONT_MAKE_STICKY = 1,
    WEBCRAWL_GET_IMAGES = 2,
    WEBCRAWL_GET_VIDEOS = 4,
    WEBCRAWL_GET_BGSOUNDS = 8,
    WEBCRAWL_GET_CONTROLS = 16,
    WEBCRAWL_LINKS_ELSEWHERE = 32,
    WEBCRAWL_IGNORE_ROBOTSTXT = 128,
    WEBCRAWL_ONLY_LINKS_TO_HTML = 256,
}

enum CHANNEL_AGENT_FLAGS
{
    CHANNEL_AGENT_DYNAMIC_SCHEDULE = 1,
    CHANNEL_AGENT_PRECACHE_SOME = 2,
    CHANNEL_AGENT_PRECACHE_ALL = 4,
    CHANNEL_AGENT_PRECACHE_SCRNSAVER = 8,
}

