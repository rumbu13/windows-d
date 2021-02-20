// Written in the D programming language.

module windows.search;

public import windows.core;
public import windows.automation : BSTR, DISPPARAMS, IDispatch, IErrorInfo,
                                   ITypeInfo, VARIANT;
public import windows.com : HRESULT, IAuthenticate, IEnumString, IEnumUnknown,
                            IPersistStream, IUnknown;
public import windows.componentservices : ITransaction, ITransactionOptions;
public import windows.indexserver : DBID, IFilter, IPhraseSink, WORDREP_BREAK_TYPE;
public import windows.security : EXPLICIT_ACCESS_W, TRUSTEE_W;
public import windows.shell : IObjectArray;
public import windows.structuredstorage : ISequentialStream, IStorage, IStream, PROPSPEC,
                                          PROPVARIANT;
public import windows.systemservices : BOOL, HANDLE, PWSTR;
public import windows.winsock : BLOB;
public import windows.windowsandmessaging : HWND;
public import windows.windowsprogramming : FILETIME, SYSTEMTIME;
public import windows.windowspropertiessystem : PROPERTYKEY;

extern(Windows) @nogc nothrow:


// Enums


///Provides a set of flags to be used with the following methods to indicate the type of condition tree node:
///ICondition::GetConditionType, IConditionFactory::MakeAndOr, IConditionFactory2::CreateCompoundFromArray, and
///IConditionFactory2::CreateCompoundFromObjectArray.
alias CONDITION_TYPE = int;
enum : int
{
    ///Indicates that the values of the subterms are combined by "AND".
    CT_AND_CONDITION  = 0x00000000,
    ///Indicates that the values of the subterms are combined by "OR".
    CT_OR_CONDITION   = 0x00000001,
    ///Indicates a "NOT" comparison of subterms.
    CT_NOT_CONDITION  = 0x00000002,
    ///Indicates that the node is a comparison between a property and a constant value using a CONDITION_OPERATION.
    CT_LEAF_CONDITION = 0x00000003,
}

///Provides a set of flags to be used with following methods to indicate the operation in ICondition::GetComparisonInfo,
///ICondition2::GetLeafConditionInfo, IConditionFactory::MakeLeaf, IConditionFactory2::CreateBooleanLeaf,
///IConditionFactory2::CreateIntegerLeaf, IConditionFactory2::MakeLeaf, IConditionFactory2::CreateStringLeaf, and
///IConditionGenerator::GenerateForLeaf.
alias CONDITION_OPERATION = int;
enum : int
{
    ///An implicit comparison between the value of the property and the value of the constant. For an unresolved
    ///condition, COP_IMPLICIT means that a user did not type an operation. In contrast, a resolved condition will
    ///always have a condition other than the <b>COP_IMPLICIT</b> operation.
    COP_IMPLICIT             = 0x00000000,
    ///The value of the property and the value of the constant must be equal.
    COP_EQUAL                = 0x00000001,
    ///The value of the property and the value of the constant must not be equal.
    COP_NOTEQUAL             = 0x00000002,
    ///The value of the property must be less than the value of the constant.
    COP_LESSTHAN             = 0x00000003,
    ///The value of the property must be greater than the value of the constant.
    COP_GREATERTHAN          = 0x00000004,
    ///The value of the property must be less than or equal to the value of the constant.
    COP_LESSTHANOREQUAL      = 0x00000005,
    ///The value of the property must be greater than or equal to the value of the constant.
    COP_GREATERTHANOREQUAL   = 0x00000006,
    ///The value of the property must begin with the value of the constant.
    COP_VALUE_STARTSWITH     = 0x00000007,
    ///The value of the property must end with the value of the constant.
    COP_VALUE_ENDSWITH       = 0x00000008,
    ///The value of the property must contain the value of the constant.
    COP_VALUE_CONTAINS       = 0x00000009,
    ///The value of the property must not contain the value of the constant.
    COP_VALUE_NOTCONTAINS    = 0x0000000a,
    ///The value of the property must match the value of the constant, where '?' matches any single character and '*'
    ///matches any sequence of characters.
    COP_DOSWILDCARDS         = 0x0000000b,
    ///The value of the property must contain a word that is the value of the constant.
    COP_WORD_EQUAL           = 0x0000000c,
    ///The value of the property must contain a word that begins with the value of the constant.
    COP_WORD_STARTSWITH      = 0x0000000d,
    ///The application is free to interpret this in any suitable way.
    COP_APPLICATION_SPECIFIC = 0x0000000e,
}

alias DBTYPEENUM = int;
enum : int
{
    DBTYPE_EMPTY       = 0x00000000,
    DBTYPE_NULL        = 0x00000001,
    DBTYPE_I2          = 0x00000002,
    DBTYPE_I4          = 0x00000003,
    DBTYPE_R4          = 0x00000004,
    DBTYPE_R8          = 0x00000005,
    DBTYPE_CY          = 0x00000006,
    DBTYPE_DATE        = 0x00000007,
    DBTYPE_BSTR        = 0x00000008,
    DBTYPE_IDISPATCH   = 0x00000009,
    DBTYPE_ERROR       = 0x0000000a,
    DBTYPE_BOOL        = 0x0000000b,
    DBTYPE_VARIANT     = 0x0000000c,
    DBTYPE_IUNKNOWN    = 0x0000000d,
    DBTYPE_DECIMAL     = 0x0000000e,
    DBTYPE_UI1         = 0x00000011,
    DBTYPE_ARRAY       = 0x00002000,
    DBTYPE_BYREF       = 0x00004000,
    DBTYPE_I1          = 0x00000010,
    DBTYPE_UI2         = 0x00000012,
    DBTYPE_UI4         = 0x00000013,
    DBTYPE_I8          = 0x00000014,
    DBTYPE_UI8         = 0x00000015,
    DBTYPE_GUID        = 0x00000048,
    DBTYPE_VECTOR      = 0x00001000,
    DBTYPE_RESERVED    = 0x00008000,
    DBTYPE_BYTES       = 0x00000080,
    DBTYPE_STR         = 0x00000081,
    DBTYPE_WSTR        = 0x00000082,
    DBTYPE_NUMERIC     = 0x00000083,
    DBTYPE_UDT         = 0x00000084,
    DBTYPE_DBDATE      = 0x00000085,
    DBTYPE_DBTIME      = 0x00000086,
    DBTYPE_DBTIMESTAMP = 0x00000087,
}

alias DBTYPEENUM15 = int;
enum : int
{
    DBTYPE_HCHAPTER = 0x00000088,
}

alias DBTYPEENUM20 = int;
enum : int
{
    DBTYPE_FILETIME    = 0x00000040,
    DBTYPE_PROPVARIANT = 0x0000008a,
    DBTYPE_VARNUMERIC  = 0x0000008b,
}

alias DBPARTENUM = int;
enum : int
{
    DBPART_INVALID = 0x00000000,
    DBPART_VALUE   = 0x00000001,
    DBPART_LENGTH  = 0x00000002,
    DBPART_STATUS  = 0x00000004,
}

alias DBPARAMIOENUM = int;
enum : int
{
    DBPARAMIO_NOTPARAM = 0x00000000,
    DBPARAMIO_INPUT    = 0x00000001,
    DBPARAMIO_OUTPUT   = 0x00000002,
}

alias DBBINDFLAGENUM = int;
enum : int
{
    DBBINDFLAG_HTML = 0x00000001,
}

alias DBMEMOWNERENUM = int;
enum : int
{
    DBMEMOWNER_CLIENTOWNED   = 0x00000000,
    DBMEMOWNER_PROVIDEROWNED = 0x00000001,
}

alias DBSTATUSENUM = int;
enum : int
{
    DBSTATUS_S_OK                 = 0x00000000,
    DBSTATUS_E_BADACCESSOR        = 0x00000001,
    DBSTATUS_E_CANTCONVERTVALUE   = 0x00000002,
    DBSTATUS_S_ISNULL             = 0x00000003,
    DBSTATUS_S_TRUNCATED          = 0x00000004,
    DBSTATUS_E_SIGNMISMATCH       = 0x00000005,
    DBSTATUS_E_DATAOVERFLOW       = 0x00000006,
    DBSTATUS_E_CANTCREATE         = 0x00000007,
    DBSTATUS_E_UNAVAILABLE        = 0x00000008,
    DBSTATUS_E_PERMISSIONDENIED   = 0x00000009,
    DBSTATUS_E_INTEGRITYVIOLATION = 0x0000000a,
    DBSTATUS_E_SCHEMAVIOLATION    = 0x0000000b,
    DBSTATUS_E_BADSTATUS          = 0x0000000c,
    DBSTATUS_S_DEFAULT            = 0x0000000d,
}

alias DBSTATUSENUM20 = int;
enum : int
{
    MDSTATUS_S_CELLEMPTY = 0x0000000e,
    DBSTATUS_S_IGNORE    = 0x0000000f,
}

alias DBSTATUSENUM21 = int;
enum : int
{
    DBSTATUS_E_DOESNOTEXIST       = 0x00000010,
    DBSTATUS_E_INVALIDURL         = 0x00000011,
    DBSTATUS_E_RESOURCELOCKED     = 0x00000012,
    DBSTATUS_E_RESOURCEEXISTS     = 0x00000013,
    DBSTATUS_E_CANNOTCOMPLETE     = 0x00000014,
    DBSTATUS_E_VOLUMENOTFOUND     = 0x00000015,
    DBSTATUS_E_OUTOFSPACE         = 0x00000016,
    DBSTATUS_S_CANNOTDELETESOURCE = 0x00000017,
    DBSTATUS_E_READONLY           = 0x00000018,
    DBSTATUS_E_RESOURCEOUTOFSCOPE = 0x00000019,
    DBSTATUS_S_ALREADYEXISTS      = 0x0000001a,
}

alias DBBINDURLFLAGENUM = int;
enum : int
{
    DBBINDURLFLAG_READ                 = 0x00000001,
    DBBINDURLFLAG_WRITE                = 0x00000002,
    DBBINDURLFLAG_READWRITE            = 0x00000003,
    DBBINDURLFLAG_SHARE_DENY_READ      = 0x00000004,
    DBBINDURLFLAG_SHARE_DENY_WRITE     = 0x00000008,
    DBBINDURLFLAG_SHARE_EXCLUSIVE      = 0x0000000c,
    DBBINDURLFLAG_SHARE_DENY_NONE      = 0x00000010,
    DBBINDURLFLAG_ASYNCHRONOUS         = 0x00001000,
    DBBINDURLFLAG_COLLECTION           = 0x00002000,
    DBBINDURLFLAG_DELAYFETCHSTREAM     = 0x00004000,
    DBBINDURLFLAG_DELAYFETCHCOLUMNS    = 0x00008000,
    DBBINDURLFLAG_RECURSIVE            = 0x00400000,
    DBBINDURLFLAG_OUTPUT               = 0x00800000,
    DBBINDURLFLAG_WAITFORINIT          = 0x01000000,
    DBBINDURLFLAG_OPENIFEXISTS         = 0x02000000,
    DBBINDURLFLAG_OVERWRITE            = 0x04000000,
    DBBINDURLFLAG_ISSTRUCTUREDDOCUMENT = 0x08000000,
}

alias DBBINDURLSTATUSENUM = int;
enum : int
{
    DBBINDURLSTATUS_S_OK                   = 0x00000000,
    DBBINDURLSTATUS_S_DENYNOTSUPPORTED     = 0x00000001,
    DBBINDURLSTATUS_S_DENYTYPENOTSUPPORTED = 0x00000004,
    DBBINDURLSTATUS_S_REDIRECTED           = 0x00000008,
}

alias DBSTATUSENUM25 = int;
enum : int
{
    DBSTATUS_E_CANCELED      = 0x0000001b,
    DBSTATUS_E_NOTCOLLECTION = 0x0000001c,
}

alias DBROWSTATUSENUM = int;
enum : int
{
    DBROWSTATUS_S_OK                     = 0x00000000,
    DBROWSTATUS_S_MULTIPLECHANGES        = 0x00000002,
    DBROWSTATUS_S_PENDINGCHANGES         = 0x00000003,
    DBROWSTATUS_E_CANCELED               = 0x00000004,
    DBROWSTATUS_E_CANTRELEASE            = 0x00000006,
    DBROWSTATUS_E_CONCURRENCYVIOLATION   = 0x00000007,
    DBROWSTATUS_E_DELETED                = 0x00000008,
    DBROWSTATUS_E_PENDINGINSERT          = 0x00000009,
    DBROWSTATUS_E_NEWLYINSERTED          = 0x0000000a,
    DBROWSTATUS_E_INTEGRITYVIOLATION     = 0x0000000b,
    DBROWSTATUS_E_INVALID                = 0x0000000c,
    DBROWSTATUS_E_MAXPENDCHANGESEXCEEDED = 0x0000000d,
    DBROWSTATUS_E_OBJECTOPEN             = 0x0000000e,
    DBROWSTATUS_E_OUTOFMEMORY            = 0x0000000f,
    DBROWSTATUS_E_PERMISSIONDENIED       = 0x00000010,
    DBROWSTATUS_E_LIMITREACHED           = 0x00000011,
    DBROWSTATUS_E_SCHEMAVIOLATION        = 0x00000012,
    DBROWSTATUS_E_FAIL                   = 0x00000013,
}

alias DBROWSTATUSENUM20 = int;
enum : int
{
    DBROWSTATUS_S_NOCHANGE = 0x00000014,
}

alias DBSTATUSENUM26 = int;
enum : int
{
    DBSTATUS_S_ROWSETCOLUMN = 0x0000001d,
}

alias DBCOLUMNFLAGSENUM = int;
enum : int
{
    DBCOLUMNFLAGS_ISBOOKMARK    = 0x00000001,
    DBCOLUMNFLAGS_MAYDEFER      = 0x00000002,
    DBCOLUMNFLAGS_WRITE         = 0x00000004,
    DBCOLUMNFLAGS_WRITEUNKNOWN  = 0x00000008,
    DBCOLUMNFLAGS_ISFIXEDLENGTH = 0x00000010,
    DBCOLUMNFLAGS_ISNULLABLE    = 0x00000020,
    DBCOLUMNFLAGS_MAYBENULL     = 0x00000040,
    DBCOLUMNFLAGS_ISLONG        = 0x00000080,
    DBCOLUMNFLAGS_ISROWID       = 0x00000100,
    DBCOLUMNFLAGS_ISROWVER      = 0x00000200,
    DBCOLUMNFLAGS_CACHEDEFERRED = 0x00001000,
}

alias DBCOLUMNFLAGSENUM20 = int;
enum : int
{
    DBCOLUMNFLAGS_SCALEISNEGATIVE = 0x00004000,
    DBCOLUMNFLAGS_RESERVED        = 0x00008000,
}

alias DBCOLUMNFLAGS15ENUM = int;
enum : int
{
    DBCOLUMNFLAGS_ISCHAPTER = 0x00002000,
}

alias DBCOLUMNFLAGSENUM21 = int;
enum : int
{
    DBCOLUMNFLAGS_ISROWURL        = 0x00010000,
    DBCOLUMNFLAGS_ISDEFAULTSTREAM = 0x00020000,
    DBCOLUMNFLAGS_ISCOLLECTION    = 0x00040000,
}

alias DBCOLUMNFLAGSENUM26 = int;
enum : int
{
    DBCOLUMNFLAGS_ISSTREAM          = 0x00080000,
    DBCOLUMNFLAGS_ISROWSET          = 0x00100000,
    DBCOLUMNFLAGS_ISROW             = 0x00200000,
    DBCOLUMNFLAGS_ROWSPECIFICCOLUMN = 0x00400000,
}

alias DBTABLESTATISTICSTYPE26 = int;
enum : int
{
    DBSTAT_HISTOGRAM          = 0x00000001,
    DBSTAT_COLUMN_CARDINALITY = 0x00000002,
    DBSTAT_TUPLE_CARDINALITY  = 0x00000004,
}

alias DBBOOKMARK = int;
enum : int
{
    DBBMK_INVALID = 0x00000000,
    DBBMK_FIRST   = 0x00000001,
    DBBMK_LAST    = 0x00000002,
}

alias DBPROPENUM = int;
enum : int
{
    DBPROP_ABORTPRESERVE                   = 0x00000002,
    DBPROP_ACTIVESESSIONS                  = 0x00000003,
    DBPROP_APPENDONLY                      = 0x000000bb,
    DBPROP_ASYNCTXNABORT                   = 0x000000a8,
    DBPROP_ASYNCTXNCOMMIT                  = 0x00000004,
    DBPROP_AUTH_CACHE_AUTHINFO             = 0x00000005,
    DBPROP_AUTH_ENCRYPT_PASSWORD           = 0x00000006,
    DBPROP_AUTH_INTEGRATED                 = 0x00000007,
    DBPROP_AUTH_MASK_PASSWORD              = 0x00000008,
    DBPROP_AUTH_PASSWORD                   = 0x00000009,
    DBPROP_AUTH_PERSIST_ENCRYPTED          = 0x0000000a,
    DBPROP_AUTH_PERSIST_SENSITIVE_AUTHINFO = 0x0000000b,
    DBPROP_AUTH_USERID                     = 0x0000000c,
    DBPROP_BLOCKINGSTORAGEOBJECTS          = 0x0000000d,
    DBPROP_BOOKMARKS                       = 0x0000000e,
    DBPROP_BOOKMARKSKIPPED                 = 0x0000000f,
    DBPROP_BOOKMARKTYPE                    = 0x00000010,
    DBPROP_BYREFACCESSORS                  = 0x00000078,
    DBPROP_CACHEDEFERRED                   = 0x00000011,
    DBPROP_CANFETCHBACKWARDS               = 0x00000012,
    DBPROP_CANHOLDROWS                     = 0x00000013,
    DBPROP_CANSCROLLBACKWARDS              = 0x00000015,
    DBPROP_CATALOGLOCATION                 = 0x00000016,
    DBPROP_CATALOGTERM                     = 0x00000017,
    DBPROP_CATALOGUSAGE                    = 0x00000018,
    DBPROP_CHANGEINSERTEDROWS              = 0x000000bc,
    DBPROP_COL_AUTOINCREMENT               = 0x0000001a,
    DBPROP_COL_DEFAULT                     = 0x0000001b,
    DBPROP_COL_DESCRIPTION                 = 0x0000001c,
    DBPROP_COL_FIXEDLENGTH                 = 0x000000a7,
    DBPROP_COL_NULLABLE                    = 0x0000001d,
    DBPROP_COL_PRIMARYKEY                  = 0x0000001e,
    DBPROP_COL_UNIQUE                      = 0x0000001f,
    DBPROP_COLUMNDEFINITION                = 0x00000020,
    DBPROP_COLUMNRESTRICT                  = 0x00000021,
    DBPROP_COMMANDTIMEOUT                  = 0x00000022,
    DBPROP_COMMITPRESERVE                  = 0x00000023,
    DBPROP_CONCATNULLBEHAVIOR              = 0x00000024,
    DBPROP_CURRENTCATALOG                  = 0x00000025,
    DBPROP_DATASOURCENAME                  = 0x00000026,
    DBPROP_DATASOURCEREADONLY              = 0x00000027,
    DBPROP_DBMSNAME                        = 0x00000028,
    DBPROP_DBMSVER                         = 0x00000029,
    DBPROP_DEFERRED                        = 0x0000002a,
    DBPROP_DELAYSTORAGEOBJECTS             = 0x0000002b,
    DBPROP_DSOTHREADMODEL                  = 0x000000a9,
    DBPROP_GROUPBY                         = 0x0000002c,
    DBPROP_HETEROGENEOUSTABLES             = 0x0000002d,
    DBPROP_IAccessor                       = 0x00000079,
    DBPROP_IColumnsInfo                    = 0x0000007a,
    DBPROP_IColumnsRowset                  = 0x0000007b,
    DBPROP_IConnectionPointContainer       = 0x0000007c,
    DBPROP_IConvertType                    = 0x000000c2,
    DBPROP_IRowset                         = 0x0000007e,
    DBPROP_IRowsetChange                   = 0x0000007f,
    DBPROP_IRowsetIdentity                 = 0x00000080,
    DBPROP_IRowsetIndex                    = 0x0000009f,
    DBPROP_IRowsetInfo                     = 0x00000081,
    DBPROP_IRowsetLocate                   = 0x00000082,
    DBPROP_IRowsetResynch                  = 0x00000084,
    DBPROP_IRowsetScroll                   = 0x00000085,
    DBPROP_IRowsetUpdate                   = 0x00000086,
    DBPROP_ISupportErrorInfo               = 0x00000087,
    DBPROP_ILockBytes                      = 0x00000088,
    DBPROP_ISequentialStream               = 0x00000089,
    DBPROP_IStorage                        = 0x0000008a,
    DBPROP_IStream                         = 0x0000008b,
    DBPROP_IDENTIFIERCASE                  = 0x0000002e,
    DBPROP_IMMOBILEROWS                    = 0x0000002f,
    DBPROP_INDEX_AUTOUPDATE                = 0x00000030,
    DBPROP_INDEX_CLUSTERED                 = 0x00000031,
    DBPROP_INDEX_FILLFACTOR                = 0x00000032,
    DBPROP_INDEX_INITIALSIZE               = 0x00000033,
    DBPROP_INDEX_NULLCOLLATION             = 0x00000034,
    DBPROP_INDEX_NULLS                     = 0x00000035,
    DBPROP_INDEX_PRIMARYKEY                = 0x00000036,
    DBPROP_INDEX_SORTBOOKMARKS             = 0x00000037,
    DBPROP_INDEX_TEMPINDEX                 = 0x000000a3,
    DBPROP_INDEX_TYPE                      = 0x00000038,
    DBPROP_INDEX_UNIQUE                    = 0x00000039,
    DBPROP_INIT_DATASOURCE                 = 0x0000003b,
    DBPROP_INIT_HWND                       = 0x0000003c,
    DBPROP_INIT_IMPERSONATION_LEVEL        = 0x0000003d,
    DBPROP_INIT_LCID                       = 0x000000ba,
    DBPROP_INIT_LOCATION                   = 0x0000003e,
    DBPROP_INIT_MODE                       = 0x0000003f,
    DBPROP_INIT_PROMPT                     = 0x00000040,
    DBPROP_INIT_PROTECTION_LEVEL           = 0x00000041,
    DBPROP_INIT_PROVIDERSTRING             = 0x000000a0,
    DBPROP_INIT_TIMEOUT                    = 0x00000042,
    DBPROP_LITERALBOOKMARKS                = 0x00000043,
    DBPROP_LITERALIDENTITY                 = 0x00000044,
    DBPROP_MAXINDEXSIZE                    = 0x00000046,
    DBPROP_MAXOPENROWS                     = 0x00000047,
    DBPROP_MAXPENDINGROWS                  = 0x00000048,
    DBPROP_MAXROWS                         = 0x00000049,
    DBPROP_MAXROWSIZE                      = 0x0000004a,
    DBPROP_MAXROWSIZEINCLUDESBLOB          = 0x0000004b,
    DBPROP_MAXTABLESINSELECT               = 0x0000004c,
    DBPROP_MAYWRITECOLUMN                  = 0x0000004d,
    DBPROP_MEMORYUSAGE                     = 0x0000004e,
    DBPROP_MULTIPLEPARAMSETS               = 0x000000bf,
    DBPROP_MULTIPLERESULTS                 = 0x000000c4,
    DBPROP_MULTIPLESTORAGEOBJECTS          = 0x00000050,
    DBPROP_MULTITABLEUPDATE                = 0x00000051,
    DBPROP_NOTIFICATIONGRANULARITY         = 0x000000c6,
    DBPROP_NOTIFICATIONPHASES              = 0x00000052,
    DBPROP_NOTIFYCOLUMNSET                 = 0x000000ab,
    DBPROP_NOTIFYROWDELETE                 = 0x000000ad,
    DBPROP_NOTIFYROWFIRSTCHANGE            = 0x000000ae,
    DBPROP_NOTIFYROWINSERT                 = 0x000000af,
    DBPROP_NOTIFYROWRESYNCH                = 0x000000b1,
    DBPROP_NOTIFYROWSETCHANGED             = 0x000000d3,
    DBPROP_NOTIFYROWSETRELEASE             = 0x000000b2,
    DBPROP_NOTIFYROWSETFETCHPOSITIONCHANGE = 0x000000b3,
    DBPROP_NOTIFYROWUNDOCHANGE             = 0x000000b4,
    DBPROP_NOTIFYROWUNDODELETE             = 0x000000b5,
    DBPROP_NOTIFYROWUNDOINSERT             = 0x000000b6,
    DBPROP_NOTIFYROWUPDATE                 = 0x000000b7,
    DBPROP_NULLCOLLATION                   = 0x00000053,
    DBPROP_OLEOBJECTS                      = 0x00000054,
    DBPROP_ORDERBYCOLUMNSINSELECT          = 0x00000055,
    DBPROP_ORDEREDBOOKMARKS                = 0x00000056,
    DBPROP_OTHERINSERT                     = 0x00000057,
    DBPROP_OTHERUPDATEDELETE               = 0x00000058,
    DBPROP_OUTPUTPARAMETERAVAILABILITY     = 0x000000b8,
    DBPROP_OWNINSERT                       = 0x00000059,
    DBPROP_OWNUPDATEDELETE                 = 0x0000005a,
    DBPROP_PERSISTENTIDTYPE                = 0x000000b9,
    DBPROP_PREPAREABORTBEHAVIOR            = 0x0000005b,
    DBPROP_PREPARECOMMITBEHAVIOR           = 0x0000005c,
    DBPROP_PROCEDURETERM                   = 0x0000005d,
    DBPROP_PROVIDERNAME                    = 0x00000060,
    DBPROP_PROVIDEROLEDBVER                = 0x00000061,
    DBPROP_PROVIDERVER                     = 0x00000062,
    DBPROP_QUICKRESTART                    = 0x00000063,
    DBPROP_QUOTEDIDENTIFIERCASE            = 0x00000064,
    DBPROP_REENTRANTEVENTS                 = 0x00000065,
    DBPROP_REMOVEDELETED                   = 0x00000066,
    DBPROP_REPORTMULTIPLECHANGES           = 0x00000067,
    DBPROP_RETURNPENDINGINSERTS            = 0x000000bd,
    DBPROP_ROWRESTRICT                     = 0x00000068,
    DBPROP_ROWSETCONVERSIONSONCOMMAND      = 0x000000c0,
    DBPROP_ROWTHREADMODEL                  = 0x00000069,
    DBPROP_SCHEMATERM                      = 0x0000006a,
    DBPROP_SCHEMAUSAGE                     = 0x0000006b,
    DBPROP_SERVERCURSOR                    = 0x0000006c,
    DBPROP_SESS_AUTOCOMMITISOLEVELS        = 0x000000be,
    DBPROP_SQLSUPPORT                      = 0x0000006d,
    DBPROP_STRONGIDENTITY                  = 0x00000077,
    DBPROP_STRUCTUREDSTORAGE               = 0x0000006f,
    DBPROP_SUBQUERIES                      = 0x00000070,
    DBPROP_SUPPORTEDTXNDDL                 = 0x000000a1,
    DBPROP_SUPPORTEDTXNISOLEVELS           = 0x00000071,
    DBPROP_SUPPORTEDTXNISORETAIN           = 0x00000072,
    DBPROP_TABLETERM                       = 0x00000073,
    DBPROP_TBL_TEMPTABLE                   = 0x0000008c,
    DBPROP_TRANSACTEDOBJECT                = 0x00000074,
    DBPROP_UPDATABILITY                    = 0x00000075,
    DBPROP_USERNAME                        = 0x00000076,
}

alias DBPROPENUM15 = int;
enum : int
{
    DBPROP_FILTERCOMPAREOPS = 0x000000d1,
    DBPROP_FINDCOMPAREOPS   = 0x000000d2,
    DBPROP_IChapteredRowset = 0x000000ca,
    DBPROP_IDBAsynchStatus  = 0x000000cb,
    DBPROP_IRowsetFind      = 0x000000cc,
    DBPROP_IRowsetView      = 0x000000d4,
    DBPROP_IViewChapter     = 0x000000d5,
    DBPROP_IViewFilter      = 0x000000d6,
    DBPROP_IViewRowset      = 0x000000d7,
    DBPROP_IViewSort        = 0x000000d8,
    DBPROP_INIT_ASYNCH      = 0x000000c8,
    DBPROP_MAXOPENCHAPTERS  = 0x000000c7,
    DBPROP_MAXORSINFILTER   = 0x000000cd,
    DBPROP_MAXSORTCOLUMNS   = 0x000000ce,
    DBPROP_ROWSET_ASYNCH    = 0x000000c9,
    DBPROP_SORTONINDEX      = 0x000000cf,
}

alias DBPROPENUM20 = int;
enum : int
{
    DBPROP_IMultipleResults           = 0x000000d9,
    DBPROP_DATASOURCE_TYPE            = 0x000000fb,
    MDPROP_AXES                       = 0x000000fc,
    MDPROP_FLATTENING_SUPPORT         = 0x000000fd,
    MDPROP_MDX_JOINCUBES              = 0x000000fe,
    MDPROP_NAMED_LEVELS               = 0x000000ff,
    MDPROP_RANGEROWSET                = 0x00000100,
    MDPROP_MDX_SLICER                 = 0x000000da,
    MDPROP_MDX_CUBEQUALIFICATION      = 0x000000db,
    MDPROP_MDX_OUTERREFERENCE         = 0x000000dc,
    MDPROP_MDX_QUERYBYPROPERTY        = 0x000000dd,
    MDPROP_MDX_CASESUPPORT            = 0x000000de,
    MDPROP_MDX_STRING_COMPOP          = 0x000000e0,
    MDPROP_MDX_DESCFLAGS              = 0x000000e1,
    MDPROP_MDX_SET_FUNCTIONS          = 0x000000e2,
    MDPROP_MDX_MEMBER_FUNCTIONS       = 0x000000e3,
    MDPROP_MDX_NUMERIC_FUNCTIONS      = 0x000000e4,
    MDPROP_MDX_FORMULAS               = 0x000000e5,
    MDPROP_AGGREGATECELL_UPDATE       = 0x000000e6,
    MDPROP_MDX_AGGREGATECELL_UPDATE   = 0x000000e6,
    MDPROP_MDX_OBJQUALIFICATION       = 0x00000105,
    MDPROP_MDX_NONMEASURE_EXPRESSIONS = 0x00000106,
    DBPROP_ACCESSORDER                = 0x000000e7,
    DBPROP_BOOKMARKINFO               = 0x000000e8,
    DBPROP_INIT_CATALOG               = 0x000000e9,
    DBPROP_ROW_BULKOPS                = 0x000000ea,
    DBPROP_PROVIDERFRIENDLYNAME       = 0x000000eb,
    DBPROP_LOCKMODE                   = 0x000000ec,
    DBPROP_MULTIPLECONNECTIONS        = 0x000000ed,
    DBPROP_UNIQUEROWS                 = 0x000000ee,
    DBPROP_SERVERDATAONINSERT         = 0x000000ef,
    DBPROP_STORAGEFLAGS               = 0x000000f0,
    DBPROP_CONNECTIONSTATUS           = 0x000000f4,
    DBPROP_ALTERCOLUMN                = 0x000000f5,
    DBPROP_COLUMNLCID                 = 0x000000f6,
    DBPROP_RESETDATASOURCE            = 0x000000f7,
    DBPROP_INIT_OLEDBSERVICES         = 0x000000f8,
    DBPROP_IRowsetRefresh             = 0x000000f9,
    DBPROP_SERVERNAME                 = 0x000000fa,
    DBPROP_IParentRowset              = 0x00000101,
    DBPROP_HIDDENCOLUMNS              = 0x00000102,
    DBPROP_PROVIDERMEMORY             = 0x00000103,
    DBPROP_CLIENTCURSOR               = 0x00000104,
}

alias DBPROPENUM21 = int;
enum : int
{
    DBPROP_TRUSTEE_USERNAME          = 0x000000f1,
    DBPROP_TRUSTEE_AUTHENTICATION    = 0x000000f2,
    DBPROP_TRUSTEE_NEWAUTHENTICATION = 0x000000f3,
    DBPROP_IRow                      = 0x00000107,
    DBPROP_IRowChange                = 0x00000108,
    DBPROP_IRowSchemaChange          = 0x00000109,
    DBPROP_IGetRow                   = 0x0000010a,
    DBPROP_IScopedOperations         = 0x0000010b,
    DBPROP_IBindResource             = 0x0000010c,
    DBPROP_ICreateRow                = 0x0000010d,
    DBPROP_INIT_BINDFLAGS            = 0x0000010e,
    DBPROP_INIT_LOCKOWNER            = 0x0000010f,
    DBPROP_GENERATEURL               = 0x00000111,
    DBPROP_IDBBinderProperties       = 0x00000112,
    DBPROP_IColumnsInfo2             = 0x00000113,
    DBPROP_IRegisterProvider         = 0x00000114,
    DBPROP_IGetSession               = 0x00000115,
    DBPROP_IGetSourceRow             = 0x00000116,
    DBPROP_IRowsetCurrentIndex       = 0x00000117,
    DBPROP_OPENROWSETSUPPORT         = 0x00000118,
    DBPROP_COL_ISLONG                = 0x00000119,
}

alias DBPROPENUM25 = int;
enum : int
{
    DBPROP_COL_SEED            = 0x0000011a,
    DBPROP_COL_INCREMENT       = 0x0000011b,
    DBPROP_INIT_GENERALTIMEOUT = 0x0000011c,
    DBPROP_COMSERVICES         = 0x0000011d,
}

alias DBPROPENUM26 = int;
enum : int
{
    DBPROP_OUTPUTSTREAM        = 0x0000011e,
    DBPROP_OUTPUTENCODING      = 0x0000011f,
    DBPROP_TABLESTATISTICS     = 0x00000120,
    DBPROP_SKIPROWCOUNTRESULTS = 0x00000123,
    DBPROP_IRowsetBookmark     = 0x00000124,
    MDPROP_VISUALMODE          = 0x00000125,
}

alias DBPARAMFLAGSENUM = int;
enum : int
{
    DBPARAMFLAGS_ISINPUT    = 0x00000001,
    DBPARAMFLAGS_ISOUTPUT   = 0x00000002,
    DBPARAMFLAGS_ISSIGNED   = 0x00000010,
    DBPARAMFLAGS_ISNULLABLE = 0x00000040,
    DBPARAMFLAGS_ISLONG     = 0x00000080,
}

alias DBPARAMFLAGSENUM20 = int;
enum : int
{
    DBPARAMFLAGS_SCALEISNEGATIVE = 0x00000100,
}

alias DBPROPFLAGSENUM = int;
enum : int
{
    DBPROPFLAGS_NOTSUPPORTED     = 0x00000000,
    DBPROPFLAGS_COLUMN           = 0x00000001,
    DBPROPFLAGS_DATASOURCE       = 0x00000002,
    DBPROPFLAGS_DATASOURCECREATE = 0x00000004,
    DBPROPFLAGS_DATASOURCEINFO   = 0x00000008,
    DBPROPFLAGS_DBINIT           = 0x00000010,
    DBPROPFLAGS_INDEX            = 0x00000020,
    DBPROPFLAGS_ROWSET           = 0x00000040,
    DBPROPFLAGS_TABLE            = 0x00000080,
    DBPROPFLAGS_COLUMNOK         = 0x00000100,
    DBPROPFLAGS_READ             = 0x00000200,
    DBPROPFLAGS_WRITE            = 0x00000400,
    DBPROPFLAGS_REQUIRED         = 0x00000800,
    DBPROPFLAGS_SESSION          = 0x00001000,
}

alias DBPROPFLAGSENUM21 = int;
enum : int
{
    DBPROPFLAGS_TRUSTEE = 0x00002000,
}

alias DBPROPFLAGSENUM25 = int;
enum : int
{
    DBPROPFLAGS_VIEW = 0x00004000,
}

alias DBPROPFLAGSENUM26 = int;
enum : int
{
    DBPROPFLAGS_STREAM = 0x00008000,
}

alias DBPROPOPTIONSENUM = int;
enum : int
{
    DBPROPOPTIONS_REQUIRED   = 0x00000000,
    DBPROPOPTIONS_SETIFCHEAP = 0x00000001,
    DBPROPOPTIONS_OPTIONAL   = 0x00000001,
}

alias DBPROPSTATUSENUM = int;
enum : int
{
    DBPROPSTATUS_OK             = 0x00000000,
    DBPROPSTATUS_NOTSUPPORTED   = 0x00000001,
    DBPROPSTATUS_BADVALUE       = 0x00000002,
    DBPROPSTATUS_BADOPTION      = 0x00000003,
    DBPROPSTATUS_BADCOLUMN      = 0x00000004,
    DBPROPSTATUS_NOTALLSETTABLE = 0x00000005,
    DBPROPSTATUS_NOTSETTABLE    = 0x00000006,
    DBPROPSTATUS_NOTSET         = 0x00000007,
    DBPROPSTATUS_CONFLICTING    = 0x00000008,
}

alias DBPROPSTATUSENUM21 = int;
enum : int
{
    DBPROPSTATUS_NOTAVAILABLE = 0x00000009,
}

alias DBINDEX_COL_ORDERENUM = int;
enum : int
{
    DBINDEX_COL_ORDER_ASC  = 0x00000000,
    DBINDEX_COL_ORDER_DESC = 0x00000001,
}

alias DBCOLUMNDESCFLAGSENUM = int;
enum : int
{
    DBCOLUMNDESCFLAGS_TYPENAME   = 0x00000001,
    DBCOLUMNDESCFLAGS_ITYPEINFO  = 0x00000002,
    DBCOLUMNDESCFLAGS_PROPERTIES = 0x00000004,
    DBCOLUMNDESCFLAGS_CLSID      = 0x00000008,
    DBCOLUMNDESCFLAGS_COLSIZE    = 0x00000010,
    DBCOLUMNDESCFLAGS_DBCID      = 0x00000020,
    DBCOLUMNDESCFLAGS_WTYPE      = 0x00000040,
    DBCOLUMNDESCFLAGS_PRECISION  = 0x00000080,
    DBCOLUMNDESCFLAGS_SCALE      = 0x00000100,
}

alias DBEVENTPHASEENUM = int;
enum : int
{
    DBEVENTPHASE_OKTODO     = 0x00000000,
    DBEVENTPHASE_ABOUTTODO  = 0x00000001,
    DBEVENTPHASE_SYNCHAFTER = 0x00000002,
    DBEVENTPHASE_FAILEDTODO = 0x00000003,
    DBEVENTPHASE_DIDEVENT   = 0x00000004,
}

alias DBREASONENUM = int;
enum : int
{
    DBREASON_ROWSET_FETCHPOSITIONCHANGE = 0x00000000,
    DBREASON_ROWSET_RELEASE             = 0x00000001,
    DBREASON_COLUMN_SET                 = 0x00000002,
    DBREASON_COLUMN_RECALCULATED        = 0x00000003,
    DBREASON_ROW_ACTIVATE               = 0x00000004,
    DBREASON_ROW_RELEASE                = 0x00000005,
    DBREASON_ROW_DELETE                 = 0x00000006,
    DBREASON_ROW_FIRSTCHANGE            = 0x00000007,
    DBREASON_ROW_INSERT                 = 0x00000008,
    DBREASON_ROW_RESYNCH                = 0x00000009,
    DBREASON_ROW_UNDOCHANGE             = 0x0000000a,
    DBREASON_ROW_UNDOINSERT             = 0x0000000b,
    DBREASON_ROW_UNDODELETE             = 0x0000000c,
    DBREASON_ROW_UPDATE                 = 0x0000000d,
    DBREASON_ROWSET_CHANGED             = 0x0000000e,
}

alias DBREASONENUM15 = int;
enum : int
{
    DBREASON_ROWPOSITION_CHANGED        = 0x0000000f,
    DBREASON_ROWPOSITION_CHAPTERCHANGED = 0x00000010,
    DBREASON_ROWPOSITION_CLEARED        = 0x00000011,
    DBREASON_ROW_ASYNCHINSERT           = 0x00000012,
}

alias DBCOMPAREOPSENUM = int;
enum : int
{
    DBCOMPAREOPS_LT              = 0x00000000,
    DBCOMPAREOPS_LE              = 0x00000001,
    DBCOMPAREOPS_EQ              = 0x00000002,
    DBCOMPAREOPS_GE              = 0x00000003,
    DBCOMPAREOPS_GT              = 0x00000004,
    DBCOMPAREOPS_BEGINSWITH      = 0x00000005,
    DBCOMPAREOPS_CONTAINS        = 0x00000006,
    DBCOMPAREOPS_NE              = 0x00000007,
    DBCOMPAREOPS_IGNORE          = 0x00000008,
    DBCOMPAREOPS_CASESENSITIVE   = 0x00001000,
    DBCOMPAREOPS_CASEINSENSITIVE = 0x00002000,
}

alias DBCOMPAREOPSENUM20 = int;
enum : int
{
    DBCOMPAREOPS_NOTBEGINSWITH = 0x00000009,
    DBCOMPAREOPS_NOTCONTAINS   = 0x0000000a,
}

alias DBASYNCHOPENUM = int;
enum : int
{
    DBASYNCHOP_OPEN = 0x00000000,
}

alias DBASYNCHPHASEENUM = int;
enum : int
{
    DBASYNCHPHASE_INITIALIZATION = 0x00000000,
    DBASYNCHPHASE_POPULATION     = 0x00000001,
    DBASYNCHPHASE_COMPLETE       = 0x00000002,
    DBASYNCHPHASE_CANCELED       = 0x00000003,
}

alias DBSORTENUM = int;
enum : int
{
    DBSORT_ASCENDING  = 0x00000000,
    DBSORT_DESCENDING = 0x00000001,
}

alias DBCOMMANDPERSISTFLAGENUM = int;
enum : int
{
    DBCOMMANDPERSISTFLAG_NOSAVE = 0x00000001,
}

alias DBCOMMANDPERSISTFLAGENUM21 = int;
enum : int
{
    DBCOMMANDPERSISTFLAG_DEFAULT          = 0x00000000,
    DBCOMMANDPERSISTFLAG_PERSISTVIEW      = 0x00000002,
    DBCOMMANDPERSISTFLAG_PERSISTPROCEDURE = 0x00000004,
}

alias DBCONSTRAINTTYPEENUM = int;
enum : int
{
    DBCONSTRAINTTYPE_UNIQUE     = 0x00000000,
    DBCONSTRAINTTYPE_FOREIGNKEY = 0x00000001,
    DBCONSTRAINTTYPE_PRIMARYKEY = 0x00000002,
    DBCONSTRAINTTYPE_CHECK      = 0x00000003,
}

alias DBUPDELRULEENUM = int;
enum : int
{
    DBUPDELRULE_NOACTION   = 0x00000000,
    DBUPDELRULE_CASCADE    = 0x00000001,
    DBUPDELRULE_SETNULL    = 0x00000002,
    DBUPDELRULE_SETDEFAULT = 0x00000003,
}

alias DBMATCHTYPEENUM = int;
enum : int
{
    DBMATCHTYPE_FULL    = 0x00000000,
    DBMATCHTYPE_NONE    = 0x00000001,
    DBMATCHTYPE_PARTIAL = 0x00000002,
}

alias DBDEFERRABILITYENUM = int;
enum : int
{
    DBDEFERRABILITY_DEFERRED   = 0x00000001,
    DBDEFERRABILITY_DEFERRABLE = 0x00000002,
}

alias DBACCESSORFLAGSENUM = int;
enum : int
{
    DBACCESSOR_INVALID       = 0x00000000,
    DBACCESSOR_PASSBYREF     = 0x00000001,
    DBACCESSOR_ROWDATA       = 0x00000002,
    DBACCESSOR_PARAMETERDATA = 0x00000004,
    DBACCESSOR_OPTIMIZED     = 0x00000008,
    DBACCESSOR_INHERITED     = 0x00000010,
}

alias DBBINDSTATUSENUM = int;
enum : int
{
    DBBINDSTATUS_OK                    = 0x00000000,
    DBBINDSTATUS_BADORDINAL            = 0x00000001,
    DBBINDSTATUS_UNSUPPORTEDCONVERSION = 0x00000002,
    DBBINDSTATUS_BADBINDINFO           = 0x00000003,
    DBBINDSTATUS_BADSTORAGEFLAGS       = 0x00000004,
    DBBINDSTATUS_NOINTERFACE           = 0x00000005,
    DBBINDSTATUS_MULTIPLESTORAGE       = 0x00000006,
}

alias DBCOMPAREENUM = int;
enum : int
{
    DBCOMPARE_LT            = 0x00000000,
    DBCOMPARE_EQ            = 0x00000001,
    DBCOMPARE_GT            = 0x00000002,
    DBCOMPARE_NE            = 0x00000003,
    DBCOMPARE_NOTCOMPARABLE = 0x00000004,
}

alias DBPOSITIONFLAGSENUM = int;
enum : int
{
    DBPOSITION_OK    = 0x00000000,
    DBPOSITION_NOROW = 0x00000001,
    DBPOSITION_BOF   = 0x00000002,
    DBPOSITION_EOF   = 0x00000003,
}

alias DBPENDINGSTATUSENUM = int;
enum : int
{
    DBPENDINGSTATUS_NEW        = 0x00000001,
    DBPENDINGSTATUS_CHANGED    = 0x00000002,
    DBPENDINGSTATUS_DELETED    = 0x00000004,
    DBPENDINGSTATUS_UNCHANGED  = 0x00000008,
    DBPENDINGSTATUS_INVALIDROW = 0x00000010,
}

alias DBSEEKENUM = int;
enum : int
{
    DBSEEK_INVALID  = 0x00000000,
    DBSEEK_FIRSTEQ  = 0x00000001,
    DBSEEK_LASTEQ   = 0x00000002,
    DBSEEK_AFTEREQ  = 0x00000004,
    DBSEEK_AFTER    = 0x00000008,
    DBSEEK_BEFOREEQ = 0x00000010,
    DBSEEK_BEFORE   = 0x00000020,
}

alias DBRANGEENUM = int;
enum : int
{
    DBRANGE_INCLUSIVESTART = 0x00000000,
    DBRANGE_INCLUSIVEEND   = 0x00000000,
    DBRANGE_EXCLUSIVESTART = 0x00000001,
    DBRANGE_EXCLUSIVEEND   = 0x00000002,
    DBRANGE_EXCLUDENULLS   = 0x00000004,
    DBRANGE_PREFIX         = 0x00000008,
    DBRANGE_MATCH          = 0x00000010,
}

alias DBRANGEENUM20 = int;
enum : int
{
    DBRANGE_MATCH_N_SHIFT = 0x00000018,
    DBRANGE_MATCH_N_MASK  = 0x000000ff,
}

alias DBRESULTFLAGENUM = int;
enum : int
{
    DBRESULTFLAG_DEFAULT = 0x00000000,
    DBRESULTFLAG_ROWSET  = 0x00000001,
    DBRESULTFLAG_ROW     = 0x00000002,
}

alias DBCONVERTFLAGSENUM = int;
enum : int
{
    DBCONVERTFLAGS_COLUMN    = 0x00000000,
    DBCONVERTFLAGS_PARAMETER = 0x00000001,
}

alias DBCONVERTFLAGSENUM20 = int;
enum : int
{
    DBCONVERTFLAGS_ISLONG        = 0x00000002,
    DBCONVERTFLAGS_ISFIXEDLENGTH = 0x00000004,
    DBCONVERTFLAGS_FROMVARIANT   = 0x00000008,
}

alias DBSOURCETYPEENUM = int;
enum : int
{
    DBSOURCETYPE_DATASOURCE = 0x00000001,
    DBSOURCETYPE_ENUMERATOR = 0x00000002,
}

alias DBSOURCETYPEENUM20 = int;
enum : int
{
    DBSOURCETYPE_DATASOURCE_TDP = 0x00000001,
    DBSOURCETYPE_DATASOURCE_MDP = 0x00000003,
}

alias DBSOURCETYPEENUM25 = int;
enum : int
{
    DBSOURCETYPE_BINDER = 0x00000004,
}

alias DBLITERALENUM = int;
enum : int
{
    DBLITERAL_INVALID           = 0x00000000,
    DBLITERAL_BINARY_LITERAL    = 0x00000001,
    DBLITERAL_CATALOG_NAME      = 0x00000002,
    DBLITERAL_CATALOG_SEPARATOR = 0x00000003,
    DBLITERAL_CHAR_LITERAL      = 0x00000004,
    DBLITERAL_COLUMN_ALIAS      = 0x00000005,
    DBLITERAL_COLUMN_NAME       = 0x00000006,
    DBLITERAL_CORRELATION_NAME  = 0x00000007,
    DBLITERAL_CURSOR_NAME       = 0x00000008,
    DBLITERAL_ESCAPE_PERCENT    = 0x00000009,
    DBLITERAL_ESCAPE_UNDERSCORE = 0x0000000a,
    DBLITERAL_INDEX_NAME        = 0x0000000b,
    DBLITERAL_LIKE_PERCENT      = 0x0000000c,
    DBLITERAL_LIKE_UNDERSCORE   = 0x0000000d,
    DBLITERAL_PROCEDURE_NAME    = 0x0000000e,
    DBLITERAL_QUOTE             = 0x0000000f,
    DBLITERAL_SCHEMA_NAME       = 0x00000010,
    DBLITERAL_TABLE_NAME        = 0x00000011,
    DBLITERAL_TEXT_COMMAND      = 0x00000012,
    DBLITERAL_USER_NAME         = 0x00000013,
    DBLITERAL_VIEW_NAME         = 0x00000014,
}

alias DBLITERALENUM20 = int;
enum : int
{
    DBLITERAL_CUBE_NAME        = 0x00000015,
    DBLITERAL_DIMENSION_NAME   = 0x00000016,
    DBLITERAL_HIERARCHY_NAME   = 0x00000017,
    DBLITERAL_LEVEL_NAME       = 0x00000018,
    DBLITERAL_MEMBER_NAME      = 0x00000019,
    DBLITERAL_PROPERTY_NAME    = 0x0000001a,
    DBLITERAL_SCHEMA_SEPARATOR = 0x0000001b,
    DBLITERAL_QUOTE_SUFFIX     = 0x0000001c,
}

alias DBLITERALENUM21 = int;
enum : int
{
    DBLITERAL_ESCAPE_PERCENT_SUFFIX    = 0x0000001d,
    DBLITERAL_ESCAPE_UNDERSCORE_SUFFIX = 0x0000001e,
}

alias ACCESS_MASKENUM = int;
enum : int
{
    PERM_EXCLUSIVE        = 0x00000200,
    PERM_READDESIGN       = 0x00000400,
    PERM_WRITEDESIGN      = 0x00000800,
    PERM_WITHGRANT        = 0x00001000,
    PERM_REFERENCE        = 0x00002000,
    PERM_CREATE           = 0x00004000,
    PERM_INSERT           = 0x00008000,
    PERM_DELETE           = 0x00010000,
    PERM_READCONTROL      = 0x00020000,
    PERM_WRITEPERMISSIONS = 0x00040000,
    PERM_WRITEOWNER       = 0x00080000,
    PERM_MAXIMUM_ALLOWED  = 0x02000000,
    PERM_ALL              = 0x10000000,
    PERM_EXECUTE          = 0x20000000,
    PERM_READ             = 0x80000000,
    PERM_UPDATE           = 0x40000000,
    PERM_DROP             = 0x00000100,
}

alias DBCOPYFLAGSENUM = int;
enum : int
{
    DBCOPY_ASYNC            = 0x00000100,
    DBCOPY_REPLACE_EXISTING = 0x00000200,
    DBCOPY_ALLOW_EMULATION  = 0x00000400,
    DBCOPY_NON_RECURSIVE    = 0x00000800,
    DBCOPY_ATOMIC           = 0x00001000,
}

alias DBMOVEFLAGSENUM = int;
enum : int
{
    DBMOVE_REPLACE_EXISTING  = 0x00000001,
    DBMOVE_ASYNC             = 0x00000100,
    DBMOVE_DONT_UPDATE_LINKS = 0x00000200,
    DBMOVE_ALLOW_EMULATION   = 0x00000400,
    DBMOVE_ATOMIC            = 0x00001000,
}

alias DBDELETEFLAGSENUM = int;
enum : int
{
    DBDELETE_ASYNC  = 0x00000100,
    DBDELETE_ATOMIC = 0x00001000,
}

///Specifies the type of query syntax.
alias STRUCTURED_QUERY_SYNTAX = int;
enum : int
{
    ///No syntax.
    SQS_NO_SYNTAX             = 0x00000000,
    ///Specifies the Advanced Query Syntax. For example, "kind:email to:david to:bill".
    SQS_ADVANCED_QUERY_SYNTAX = 0x00000001,
    ///Specifies the Natural Query Syntax. This syntax removes the requirement for a colon between properties and
    ///values, for example, "email from david to bill".
    SQS_NATURAL_QUERY_SYNTAX  = 0x00000002,
}

///A set of flags to be used with IQueryParser::SetOption and IQueryParser::GetOption to indicate individual options.
alias STRUCTURED_QUERY_SINGLE_OPTION = int;
enum : int
{
    ///The option value should be a <b>VT_LPWSTR</b> that is the path to a file containing a schema binary. It is set
    ///automatically when obtaining a query parser through IQueryParserManager::CreateLoadedParser.
    SQSO_SCHEMA               = 0x00000000,
    ///The option value must be <b>VT_EMPTY</b> to use the default word breaker (current keyboard locale) or a
    ///<b>VT_UI4</b> that is a valid LCID. The LCID indicates the expected locale of content words in queries to be
    ///parsed and is used to choose a suitable word breaker for the query. IQueryParser::Parse will return an error
    ///unless you set either this option or SQSO_WORD_BREAKER before calling it.
    SQSO_LOCALE_WORD_BREAKING = 0x00000001,
    ///When setting this option, the value should be a <b>VT_EMPTY</b> for using the default word breaker for the chosen
    ///locale, or a <b>VT_UNKNOWN</b> with an object supporting the IWordBreaker interface. Retrieving the option always
    ///returns a <b>VT_UNKNOWN</b> with an object supporting the <b>IWordBreaker</b> interface, unless there is no
    ///suitable word breaker for the chosen locale, in which case <b>VT_EMPTY</b> is returned.
    SQSO_WORD_BREAKER         = 0x00000002,
    ///The option value should be a <b>VT_EMPTY</b> or a <b>VT_BOOL</b> with <b>VARIANT_TRUE</b> to allow both natural
    ///query syntax and advanced query syntax (the default) or a <b>VT_BOOL</b> with <b>VARIANT_FALSE</b> to allow only
    ///advanced query syntax. Retrieving the option always returns a <b>VT_BOOL</b>.
    SQSO_NATURAL_SYNTAX       = 0x00000003,
    ///The option value should be a <b>VT_BOOL</b> with <b>VARIANT_TRUE</b> to generate query expressions as if each
    ///word in the query had the wildcard character * appended to it (unless followed by punctuation other than a
    ///parenthesis), a <b>VT_BOOL</b> with <b>VARIANT_FALSE</b> to use the words as they are (the default), or a
    ///<b>VT_EMPTY</b>. In most cases, a word-wheeling application should set this option to <b>VARIANT_TRUE</b>.
    ///Retrieving the option always returns a <b>VT_BOOL</b>.
    SQSO_AUTOMATIC_WILDCARD   = 0x00000004,
    ///Reserved. The value should be <b>VT_EMPTY</b> (the default) or a <b>VT_I4</b>. Retrieving the option always
    ///returns a <b>VT_I4</b>.
    SQSO_TRACE_LEVEL          = 0x00000005,
    ///The option value must be a <b>VT_I4</b> that is a valid LANGID. The LANGID indicates the expected language of
    ///Structured Query keywords in queries to be parsed. It is set automatically when obtaining a query parser through
    ///IQueryParserManager::CreateLoadedParser.
    SQSO_LANGUAGE_KEYWORDS    = 0x00000006,
    ///<b>Windows 7 and later.</b> The option value must be a <b>VT_UI4</b> that is a SEARCH_QUERY_SYNTAX value. The
    ///default is SQS_NATURAL_QUERY_SYNTAX.
    SQSO_SYNTAX               = 0x00000007,
    ///<b>Windows 7 and later.</b> The value must be a <b>VT_BLOB</b> that is a copy of a TIME_ZONE_INFORMATION
    ///structure. The default is the current time zone.
    SQSO_TIME_ZONE            = 0x00000008,
    ///<b>Windows 7 and later.</b> This setting decides what connector should be assumed between conditions when none is
    ///specified. The value must be a <b>VT_UI4</b> that is a CONDITION_TYPE. Only CT_AND_CONDITION and CT_OR_CONDITION
    ///are valid. It defaults to CT_AND_CONDITION.
    SQSO_IMPLICIT_CONNECTOR   = 0x00000009,
    ///<b>Windows 7 and later.</b> This setting decides whether there are special requirements on the case of connector
    ///keywords (such as AND or OR). The value must be a <b>VT_UI4</b> that is a CASE_REQUIREMENT value. It defaults to
    ///CASE_REQUIREMENT_UPPER_IF_AQS.
    SQSO_CONNECTOR_CASE       = 0x0000000a,
}

///A set of flags used by IQueryParser::SetMultiOption to indicate individual options.
alias STRUCTURED_QUERY_MULTIOPTION = int;
enum : int
{
    ///To indicate that a leaf node with property name P and constant C should be replaced with a leaf node with
    ///property name Q, operation op, and constant C by IConditionFactory::Resolve, do the following: call
    ///IQueryParser::SetMultiOption with SQMO_VIRTUAL_PROPERTY as <i>option</i>, P as <i>pszOptionKey</i>, and for
    ///<i>pOptionValue</i> provide a <b>VT_UNKNOWN</b> with an IEnumVARIANT interface that enumerates exactly two
    ///values: a <b>VT_BSTR</b> with value Q, and a <b>VT_I4</b> that is a CONDITION_OPERATION operation.
    SQMO_VIRTUAL_PROPERTY   = 0x00000000,
    ///To indicate that a leaf node with no property name and a semantic type T (or one that is a subtype of T) should
    ///be replaced with one having property name P by IConditionFactory::Resolve, do the following: call
    ///IQueryParser::SetMultiOption with SQMO_DEFAULT_PROPERTY as <i>option</i>, T as <i>pszOptionKey</i>, and for
    ///<i>pOptionValue</i> provide a <b>VT_LPWSTR</b> with value P.
    SQMO_DEFAULT_PROPERTY   = 0x00000001,
    ///To indicate that an IConditionGenerator G should be used to recognize named entities of the semantic type named
    ///T, and that IConditionFactory::Resolve should generate condition trees for those named entities, call
    ///IQueryParser::SetMultiOption with SQMO_GENERATOR_FOR_TYPE as <i>option</i>, T as <i>pszOptionKey</i> and for
    ///<i>pOptionValue</i> provide a <b>VT_UNKNOWN</b> with value G.
    SQMO_GENERATOR_FOR_TYPE = 0x00000002,
    SQMO_MAP_PROPERTY       = 0x00000003,
}

///A set of flags to be used with IQuerySolution::GetErrors to indentify parsing error(s). Each parsing error indicates
///that one or more tokens were ignored when parsing a query string.
alias STRUCTURED_QUERY_PARSE_ERROR = int;
enum : int
{
    ///No error.
    SQPE_NONE                      = 0x00000000,
    ///An extraneous <b>(</b>.
    SQPE_EXTRA_OPENING_PARENTHESIS = 0x00000001,
    ///An extraneous <b>)</b>.
    SQPE_EXTRA_CLOSING_PARENTHESIS = 0x00000002,
    ///An extraneous <b>NOT</b>, <b>&lt;</b>, <b>&gt;</b>, <b>=</b>, and so forth.
    SQPE_IGNORED_MODIFIER          = 0x00000003,
    ///An extraneous <b>AND</b> or <b>OR</b>.
    SQPE_IGNORED_CONNECTOR         = 0x00000004,
    ///A property or other keyword used in the wrong context.
    SQPE_IGNORED_KEYWORD           = 0x00000005,
    ///Any other parse error.
    SQPE_UNHANDLED                 = 0x00000006,
}

///Options for resolving data into a condition tree.
alias STRUCTURED_QUERY_RESOLVE_OPTION = int;
enum : int
{
    ///<b>Windows 7 and later.</b> The default flag.
    SQRO_DEFAULT                           = 0x00000000,
    ///Unless this flag is set, any relative date/time expression in <i>pConditionTree</i> is replaced with an absolute
    ///date/time range that has been resolved against the reference date/time pointed to by <i>pstReferenceTime</i>. For
    ///example, if an AQS query contained the relative date/time expression "date:this month" and the reference
    ///date/time was 9/19/2006 10:28:33, the resolved condition tree would contain a date/time range beginning at
    ///9/1/2006 00:00:00 and ending at 10/1/2006 00:00:00 (in the UTC time zone).
    SQRO_DONT_RESOLVE_DATETIME             = 0x00000001,
    ///Unless this flag is set, resolving a relative date/time expression may result in an <b>OR</b> of several
    ///intervals. For example, if an AQS query contained "date:Monday" and the reference date/time was 9/19/2006
    ///10:28:33 (a Tuesday), the resolved condition tree would contain an <b>OR</b> of three 24 hour ranges
    ///corresponding to the Mondays of 9/11/2006, 9/18/2006 and 9/25/2006, because it is not clear which Monday was
    ///referenced. If this flag is set, the result will always be a single date/time range (for this example, it would
    ///be a date/time range beginning at 9/18/2006 00:00:00 and ending at 9/19/2006 00:00:00).
    SQRO_ALWAYS_ONE_INTERVAL               = 0x00000002,
    ///Unless this flag is set, the resulting condition tree will have any possible simplifications applied to it.
    SQRO_DONT_SIMPLIFY_CONDITION_TREES     = 0x00000004,
    ///Unless this flag is true, a leaf node with a virtual property that maps to several properties will be replaced by
    ///an <b>OR</b> of leaf nodes containing the actual properties. For example, the AQS query "to:Bill" may result in a
    ///leaf node where the property named <code>System.StructuredQuery.Virtual.To</code> actually maps to the two
    ///properties <code>System.Message.ToAddress</code> and <code>System.Message.ToName</code>, so the resolved
    ///condition tree would have an <b>OR</b> that looks for "Bill" in those two properties.
    SQRO_DONT_MAP_RELATIONS                = 0x00000008,
    ///A range resulting from a date/time expression, an expression such as "20..40", is first resolved to a leaf node
    ///that has a <b>VT_UNKNOWN</b> value where the punkVal member implements the IInterval interface. Unless this flag
    ///is set, the returned condition tree will have been further resolved to an <b>AND</b> of simple comparisons such
    ///as <i>COP_GREATERTHANOREQUAL</i> and <i>COP_LESSTHAN</i>. For example, for an AQS query "date:this month"
    ///resolved against 9/19/2006 10:28:33, if this flag is not set, the resulting condition tree is an <b>AND</b> of
    ///System.ItemDate <i>COP_GREATERTHANOREQUAL</i> 9/1/2006 00:00:00 and System.ItemDate <i>COP_LESSTHAN</i> 10/1/2006
    ///00:00:00. If this flag is set, the resulting condition tree will relate System.ItemDate to an <b>IInterval</b>
    ///such that its IInterval::GetLimits method returns <i>ILK_EXPLICIT_INCLUDED</i>, 9/1/2006 00:00:00,
    ///<i>ILK_EXPLICIT_EXCLUDED</i> and 10/1/2006 00:00:00.
    SQRO_DONT_RESOLVE_RANGES               = 0x00000010,
    ///An unrestricted keyword is a keyword that is not associated with a value that completes the condition. For
    ///example, in the following AQS query, the property denoted by "From" is considered an unrestricted keyword:
    ///"Kind:email Subject:"My Resume" From:". If this flag is set, such a property will be present in the resulting
    ///condition tree as a leaf node having a <i>COP_IMPLICIT</i> operation, an empty string value, and a semantic type
    ///of System.StructuredQueryType.Value. Otherwise, it will be removed entirely.
    SQRO_DONT_REMOVE_UNRESTRICTED_KEYWORDS = 0x00000020,
    ///If this flag is set, a group of words not separated by white space will be kept together in a single leaf node.
    ///If this flag is not set, the group will be broken up into separate leaf nodes. An application may want to set
    ///this flag when resolving a condition tree if the resulting tree will be further processed by code that should do
    ///any additional word breaking.
    SQRO_DONT_SPLIT_WORDS                  = 0x00000040,
    ///If a phrase in an AQS query is enclosed in double quotes, the words in that phrase go into a single leaf node
    ///(regardless of whether SQRO_DONT_SPLIT_WORDS is set) unless this flag is set, in which case they end up in
    ///separate leaf nodes and their order no longer matters. An application can set this flag if it is not able to
    ///handle leaf nodes with multiple words correctly.
    SQRO_IGNORE_PHRASE_ORDER               = 0x00000080,
    SQRO_ADD_VALUE_TYPE_FOR_PLAIN_VALUES   = 0x00000100,
    ///Work around known issues in word breakers, adding conditions on <i>PKEY_ItemNameDisplay</i> as needed.
    SQRO_ADD_ROBUST_ITEM_NAME              = 0x00000200,
}

///Specifies the case requirements of keywords, if any, for a query.
alias CASE_REQUIREMENT = int;
enum : int
{
    ///Keywords are recognized regardless of case.
    CASE_REQUIREMENT_ANY          = 0x00000000,
    ///Keywords are recognized only if uppercase when AQS is the syntax. When AQS is not the syntax, keywords are
    ///recognized regardless of case.
    CASE_REQUIREMENT_UPPER_IF_AQS = 0x00000001,
}

///These values are returned by IInterval::GetLimits as pairs to specify a range with an upper and lower limit.
///<b>INTERVAL_LIMIT_KIND</b> identifies whether the ranges include or exclude the upper and lower values of the range,
///and whether a range begins or ends in infinity.
alias INTERVAL_LIMIT_KIND = int;
enum : int
{
    ///The value is included in the range. For example, an integer range of numbers that is equal to or greater than 3
    ///and less than or equal to 6 includes both 3 and 6. So the values 3 and 6 would both be returned with
    ///<b>ILK_EXPLICIT_INCLUDED</b>.
    ILK_EXPLICIT_INCLUDED = 0x00000000,
    ///The value bounds the range but is not included in the range. For example, an integer range that is greater than 3
    ///but less than 6 excludes both 3 and 6. So the values would both be returned with <b>ILK_EXPLICIT_EXCLUDED</b>.
    ILK_EXPLICIT_EXCLUDED = 0x00000001,
    ///This is typically used as a lower bound. The specified value is ignored because the range begins (or ends) at
    ///negative infinity. For example, an integer range that includes every value less than 6 would have
    ///<b>ILK_NEGATIVE_INFINITY</b> for the lower bound and 6 and <b>ILK_EXPLICIT_EXCLUDED</b> for the upper bound.
    ILK_NEGATIVE_INFINITY = 0x00000002,
    ILK_POSITIVE_INFINITY = 0x00000003,
}

///Used by IQueryParserManager::SetOption to set parsing options. This can be used to specify schemas and localization
///options.
alias QUERY_PARSER_MANAGER_OPTION = int;
enum : int
{
    ///A <b>VT_LPWSTR</b> containing the name of the file that contains the schema binary. The default value is
    ///<b>StructuredQuerySchema.bin</b> for the SystemIndex catalog and <b>StructuredQuerySchemaTrivial.bin</b> for the
    ///trivial catalog.
    QPMO_SCHEMA_BINARY_NAME              = 0x00000000,
    ///Either a <b>VT_BOOL</b> or a <b>VT_LPWSTR</b>. If the value is a <b>VT_BOOL</b> and is <b>FALSE</b>, a
    ///pre-localized schema will not be used. If the value is a <b>VT_BOOL</b> and is <b>TRUE</b>, IQueryParserManager
    ///will use the pre-localized schema binary in "<code>%ALLUSERSPROFILE%\Microsoft\Windows</code>". If the value is a
    ///<b>VT_LPWSTR</b>, the value should contain the full path of the folder in which the pre-localized schema binary
    ///can be found. The default value is <b>VT_BOOL</b> with <b>TRUE</b>.
    QPMO_PRELOCALIZED_SCHEMA_BINARY_PATH = 0x00000001,
    ///A <b>VT_LPWSTR</b> containing the full path to the folder that contains the unlocalized schema binary. The
    ///default value is "<code>%SYSTEMROOT%\System32</code>".
    QPMO_UNLOCALIZED_SCHEMA_BINARY_PATH  = 0x00000002,
    ///A <b>VT_LPWSTR</b> containing the full path to the folder that contains the localized schema binary that can be
    ///read and written to as needed. The default value is "<code>%LOCALAPPDATA%\Microsoft\Windows</code>".
    QPMO_LOCALIZED_SCHEMA_BINARY_PATH    = 0x00000003,
    ///A <b>VT_BOOL</b>. If <b>TRUE</b>, then the paths for pre-localized and localized binaries have
    ///"<code>\(LCID)</code>" appended to them, where LCID is the decimal locale ID for the localized language. The
    ///default is <b>TRUE</b>.
    QPMO_APPEND_LCID_TO_LOCALIZED_PATH   = 0x00000004,
    QPMO_LOCALIZER_SUPPORT               = 0x00000005,
}

///Provides a set of flags to be used with the following interfaces to indicate the type of condition tree node:
///ICondition, ICondition2, IConditionFactory, IConditionFactory2, and IConditionGenerator.
alias CONDITION_CREATION_OPTIONS = int;
enum : int
{
    ///Indicates that the condition is set to the default value.
    CONDITION_CREATION_DEFAULT            = 0x00000000,
    ///Indicates that the condition is set to <b>NULL</b>.
    CONDITION_CREATION_NONE               = 0x00000000,
    ///Indicates that you should simplify the returned condition as much as possible. In some cases this flag indicates
    ///that the returned condition is not newly created but refers to an existing object.
    CONDITION_CREATION_SIMPLIFY           = 0x00000001,
    ///Indicates that you should create an AND condition of leaves with vector elements as values, instead of attempting
    ///to create a leaf condition with VT_VECTOR set in the PROPVARIANT.
    CONDITION_CREATION_VECTOR_AND         = 0x00000002,
    ///Indicates that you should create an OR condition of leaves with vector elements as values, instead of attempting
    ///to create a leaf condition with VT_VECTOR set in the PROPVARIANT.
    CONDITION_CREATION_VECTOR_OR          = 0x00000004,
    ///Indicates that you should allow the creation of a leaf condition with VT_VECTOR set in the PROPVARIANT.
    CONDITION_CREATION_VECTOR_LEAF        = 0x00000008,
    ///Indicates that you should ignore any specified locale and use the currently selected content locale
    ///IConditionFactory2::CreateStringLeaf and IConditionFactory2::CreateLeaf.
    CONDITION_CREATION_USE_CONTENT_LOCALE = 0x00000010,
}

///Defines the level of certainty for a named entity.
alias NAMED_ENTITY_CERTAINTY = int;
enum : int
{
    ///It could be this named entity but additional evidence is advisable.
    NEC_LOW    = 0x00000000,
    ///It quite likely is this named entity; it is okay to use it.
    NEC_MEDIUM = 0x00000001,
    NEC_HIGH   = 0x00000002,
}

///Used by ISearchManager to state proxy use.
alias PROXY_ACCESS = int;
enum : int
{
    ///Use proxy as set by Internet settings.
    PROXY_ACCESS_PRECONFIG = 0x00000000,
    ///Do not use a proxy.
    PROXY_ACCESS_DIRECT    = 0x00000001,
    PROXY_ACCESS_PROXY     = 0x00000002,
}

///Describes authentication types for content access.
alias AUTH_TYPE = int;
enum : int
{
    ///Anonymous.
    eAUTH_TYPE_ANONYMOUS = 0x00000000,
    ///NTLM challenge/response.
    eAUTH_TYPE_NTLM      = 0x00000001,
    eAUTH_TYPE_BASIC     = 0x00000002,
}

///Used to help define behavior when crawling or indexing. These flags are used by the
///ISearchCrawlScopeManager::AddDefaultScopeRule and ISearchCrawlScopeManager::AddUserScopeRule methods.
alias FOLLOW_FLAGS = int;
enum : int
{
    ///Specifies whether complex URLs (those containing a '?') should be indexed.
    FF_INDEXCOMPLEXURLS = 0x00000001,
    FF_SUPPRESSINDEXING = 0x00000002,
}

///These flags enumerate reasons why URLs are included or excluded from the current crawl scope. The
///ISearchCrawlScopeManager::IncludedInCrawlScopeEx method returns a pointer to this enumeration to explain why a
///specified URL is either included or excluded from the current crawl scope.
alias CLUSION_REASON = int;
enum : int
{
    ///The URL has been excluded because its scope in unknown. There is no scope that would include or exclude this URL
    ///so it is excluded by default.
    CLUSIONREASON_UNKNOWNSCOPE = 0x00000000,
    ///The URL has been included or excluded by a default rule. Default rules are set during setup or first run.
    CLUSIONREASON_DEFAULT      = 0x00000001,
    ///The URL has been included or excluded by a user rule. User rules are set either by the user through Control Panel
    ///or by a calling application through the ISearchCrawlScopeManager interface.
    CLUSIONREASON_USER         = 0x00000002,
    CLUSIONREASON_GROUPPOLICY  = 0x00000003,
}

///Indicates the kind of change affecting an item when a source sink notifies a client that an item has been changed.
alias SEARCH_KIND_OF_CHANGE = int;
enum : int
{
    ///An item was added.
    SEARCH_CHANGE_ADD                       = 0x00000000,
    ///An item was deleted.
    SEARCH_CHANGE_DELETE                    = 0x00000001,
    ///An item was modified.
    SEARCH_CHANGE_MODIFY                    = 0x00000002,
    ///An item was moved or renamed. Not currently supported for use with
    ///ISearchPersistentItemsChangedSink::OnItemsChanged.
    SEARCH_CHANGE_MOVE_RENAME               = 0x00000003,
    ///An item is a directory. The item needs to be crawled rather than just reindexed as a document would be.
    SEARCH_CHANGE_SEMANTICS_DIRECTORY       = 0x00040000,
    ///Index directory properties were changed for an item.
    SEARCH_CHANGE_SEMANTICS_SHALLOW         = 0x00080000,
    ///Security on an item was changed.
    SEARCH_CHANGE_SEMANTICS_UPDATE_SECURITY = 0x00400000,
}

///Indicates the priority of processing an item that has changed.
alias SEARCH_NOTIFICATION_PRIORITY = int;
enum : int
{
    ///The changed item is added to the end of the indexer's queue.
    SEARCH_NORMAL_PRIORITY = 0x00000000,
    ///The changed item is placed ahead of other queued items in the indexer's queue, to be processed as soon as
    ///possible.
    SEARCH_HIGH_PRIORITY   = 0x00000001,
}

///Specifies the status of the current search indexing phase.
alias SEARCH_INDEXING_PHASE = int;
enum : int
{
    ///Sent in the event that an error occurs while a notification is in the gatherer. For instance, if the notification
    ///fails the exclusion-rule tests, a status update will be sent with the error.
    SEARCH_INDEXING_PHASE_GATHERER  = 0x00000000,
    ///The document will be returned in queries. It is currently only in the volatile indexes.
    SEARCH_INDEXING_PHASE_QUERYABLE = 0x00000001,
    SEARCH_INDEXING_PHASE_PERSISTED = 0x00000002,
}

///Used by ISearchCatalogManager::GetCatalogStatus to determine the current state of the catalog.
enum CatalogStatus : int
{
    ///Index is current; no indexing needed. Queries can be processed.
    CATALOG_STATUS_IDLE                     = 0x00000000,
    ///Indexer is paused. This can happen either because the user paused indexing or the indexer back-off criteria have
    ///been met. Queries can be processed.
    CATALOG_STATUS_PAUSED                   = 0x00000001,
    ///Index is recovering; queries and indexing are processed while in this state.
    CATALOG_STATUS_RECOVERING               = 0x00000002,
    ///Indexer is currently executing a full crawl and will index everything it is configured to index. Queries can be
    ///processed while indexing.
    CATALOG_STATUS_FULL_CRAWL               = 0x00000003,
    ///Indexer is preforming a crawl to see if anything has changed or requires indexing. Queries can be processed while
    ///indexing.
    CATALOG_STATUS_INCREMENTAL_CRAWL        = 0x00000004,
    ///Indexer is processing the notification queue. This is done before resuming any crawl.
    CATALOG_STATUS_PROCESSING_NOTIFICATIONS = 0x00000005,
    CATALOG_STATUS_SHUTTING_DOWN            = 0x00000006,
}

///Used by ISearchCatalogManager::GetCatalogStatus to determine the reason the catalog is paused.
enum CatalogPausedReason : int
{
    ///Not paused.
    CATALOG_PAUSED_REASON_NONE             = 0x00000000,
    ///Paused due to high I/O.
    CATALOG_PAUSED_REASON_HIGH_IO          = 0x00000001,
    ///Paused due to high CPU usage.
    CATALOG_PAUSED_REASON_HIGH_CPU         = 0x00000002,
    ///Paused due to high NTF rate.
    CATALOG_PAUSED_REASON_HIGH_NTF_RATE    = 0x00000003,
    ///Paused due to low battery.
    CATALOG_PAUSED_REASON_LOW_BATTERY      = 0x00000004,
    ///Paused due to low memory.
    CATALOG_PAUSED_REASON_LOW_MEMORY       = 0x00000005,
    ///Paused due to low disk space.
    CATALOG_PAUSED_REASON_LOW_DISK         = 0x00000006,
    ///Paused due to need for delayed recovery.
    CATALOG_PAUSED_REASON_DELAYED_RECOVERY = 0x00000007,
    ///Paused due to user activity.
    CATALOG_PAUSED_REASON_USER_ACTIVE      = 0x00000008,
    ///Paused by external request.
    CATALOG_PAUSED_REASON_EXTERNAL         = 0x00000009,
    CATALOG_PAUSED_REASON_UPGRADING        = 0x0000000a,
}

///Used by PrioritizeMatchingURLs to specify how to process items the indexer has previously failed to index.
alias tagPRIORITIZE_FLAGS = int;
enum : int
{
    ///Indicates that the indexer should reattempt to index items that it failed to index previously.
    PRIORITIZE_FLAG_RETRYFAILEDITEMS   = 0x00000001,
    ///Indicates that the indexer should continue to reattempt indexing items regardless of the number of times the
    ///indexer has failed to index them previously.
    PRIORITIZE_FLAG_IGNOREFAILURECOUNT = 0x00000002,
}

///Indicates wildcard options on search terms. Used by ISearchQueryHelper::get_QueryTermExpansion and
///ISearchQueryHelper::put_QueryTermExpansion methods.
alias SEARCH_TERM_EXPANSION = int;
enum : int
{
    ///No expansion is applied to search terms.
    SEARCH_TERM_NO_EXPANSION = 0x00000000,
    ///All search terms are expanded.
    SEARCH_TERM_PREFIX_ALL   = 0x00000001,
    ///Stem expansion is applied to all terms.
    SEARCH_TERM_STEM_ALL     = 0x00000002,
}

///Specifies the type of query syntax.
alias SEARCH_QUERY_SYNTAX = int;
enum : int
{
    ///No syntax.
    SEARCH_NO_QUERY_SYNTAX       = 0x00000000,
    ///Specifies the Advanced Query Syntax. For example, "kind:email to:david to:bill".
    SEARCH_ADVANCED_QUERY_SYNTAX = 0x00000001,
    ///Specifies the Natural Query Syntax. This syntax removes the requirement for a colon between properties and
    ///values, for example, "email from david to bill".
    SEARCH_NATURAL_QUERY_SYNTAX  = 0x00000002,
}

///Used by the IRowsetPrioritization interface to set or retrieve the current indexer prioritization level for the scope
///specified by a query.
alias PRIORITY_LEVEL = int;
enum : int
{
    ///Indicates that the indexer should process items as fast as the machine allows.
    PRIORITY_LEVEL_FOREGROUND = 0x00000000,
    ///Indicates that the indexer should process items in this scope first, and as quickly as possible.
    PRIORITY_LEVEL_HIGH       = 0x00000001,
    ///Indicates that the indexer should process items in this scope before those at the normal rate, but after any
    ///other prioritization requests.
    PRIORITY_LEVEL_LOW        = 0x00000002,
    ///Indicates that the indexer should process items at the normal indexer rate.
    PRIORITY_LEVEL_DEFAULT    = 0x00000003,
}

///Describes whether an item that matches the search criteria of a rowset is currently in that rowset.
alias ROWSETEVENT_ITEMSTATE = int;
enum : int
{
    ///The item is definitely not in the rowset.
    ROWSETEVENT_ITEMSTATE_NOTINROWSET = 0x00000000,
    ///The item is definitely contained within the rowset.
    ROWSETEVENT_ITEMSTATE_INROWSET    = 0x00000001,
    ///The item may be in the rowset.
    ROWSETEVENT_ITEMSTATE_UNKNOWN     = 0x00000002,
}

///Describes the type of change to the rowset's data.
alias ROWSETEVENT_TYPE = int;
enum : int
{
    ///Indicates that data backing the rowset has expired, and that a new rowset should be requested.
    ROWSETEVENT_TYPE_DATAEXPIRED     = 0x00000000,
    ///Indicates that an item that did have foreground priority in the prioritization stack has been demoted, because
    ///someone else prioritized themselves ahead of this query.
    ROWSETEVENT_TYPE_FOREGROUNDLOST  = 0x00000001,
    ///Indicates that the scope statistics are to be optained.
    ROWSETEVENT_TYPE_SCOPESTATISTICS = 0x00000002,
}

alias SUBSCRIPTIONTYPE = int;
enum : int
{
    SUBSTYPE_URL            = 0x00000000,
    SUBSTYPE_CHANNEL        = 0x00000001,
    SUBSTYPE_DESKTOPURL     = 0x00000002,
    SUBSTYPE_EXTERNAL       = 0x00000003,
    SUBSTYPE_DESKTOPCHANNEL = 0x00000004,
}

alias SUBSCRIPTIONINFOFLAGS = int;
enum : int
{
    SUBSINFO_SCHEDULE     = 0x00000001,
    SUBSINFO_RECURSE      = 0x00000002,
    SUBSINFO_WEBCRAWL     = 0x00000004,
    SUBSINFO_MAILNOT      = 0x00000008,
    SUBSINFO_MAXSIZEKB    = 0x00000010,
    SUBSINFO_USER         = 0x00000020,
    SUBSINFO_PASSWORD     = 0x00000040,
    SUBSINFO_TASKFLAGS    = 0x00000100,
    SUBSINFO_GLEAM        = 0x00000200,
    SUBSINFO_CHANGESONLY  = 0x00000400,
    SUBSINFO_CHANNELFLAGS = 0x00000800,
    SUBSINFO_FRIENDLYNAME = 0x00002000,
    SUBSINFO_NEEDPASSWORD = 0x00004000,
    SUBSINFO_TYPE         = 0x00008000,
}

alias CREATESUBSCRIPTIONFLAGS = int;
enum : int
{
    CREATESUBS_ADDTOFAVORITES = 0x00000001,
    CREATESUBS_FROMFAVORITES  = 0x00000002,
    CREATESUBS_NOUI           = 0x00000004,
    CREATESUBS_NOSAVE         = 0x00000008,
    CREATESUBS_SOFTWAREUPDATE = 0x00000010,
}

alias SUBSCRIPTIONSCHEDULE = int;
enum : int
{
    SUBSSCHED_AUTO   = 0x00000000,
    SUBSSCHED_DAILY  = 0x00000001,
    SUBSSCHED_WEEKLY = 0x00000002,
    SUBSSCHED_CUSTOM = 0x00000003,
    SUBSSCHED_MANUAL = 0x00000004,
}

alias DELIVERY_AGENT_FLAGS = int;
enum : int
{
    DELIVERY_AGENT_FLAG_NO_BROADCAST    = 0x00000004,
    DELIVERY_AGENT_FLAG_NO_RESTRICTIONS = 0x00000008,
    DELIVERY_AGENT_FLAG_SILENT_DIAL     = 0x00000010,
}

alias WEBCRAWL_RECURSEFLAGS = int;
enum : int
{
    WEBCRAWL_DONT_MAKE_STICKY   = 0x00000001,
    WEBCRAWL_GET_IMAGES         = 0x00000002,
    WEBCRAWL_GET_VIDEOS         = 0x00000004,
    WEBCRAWL_GET_BGSOUNDS       = 0x00000008,
    WEBCRAWL_GET_CONTROLS       = 0x00000010,
    WEBCRAWL_LINKS_ELSEWHERE    = 0x00000020,
    WEBCRAWL_IGNORE_ROBOTSTXT   = 0x00000080,
    WEBCRAWL_ONLY_LINKS_TO_HTML = 0x00000100,
}

alias CHANNEL_AGENT_FLAGS = int;
enum : int
{
    CHANNEL_AGENT_DYNAMIC_SCHEDULE   = 0x00000001,
    CHANNEL_AGENT_PRECACHE_SOME      = 0x00000002,
    CHANNEL_AGENT_PRECACHE_ALL       = 0x00000004,
    CHANNEL_AGENT_PRECACHE_SCRNSAVER = 0x00000008,
}

// Callbacks

alias PFNFILLTEXTBUFFER = HRESULT function(TEXT_SOURCE* pTextSource);

// Structs


///Contains information about text that the word breaker will process.
struct TEXT_SOURCE
{
    ///Type: <b>PFNFILLTEXTBUFFER</b> Pointer to a function, <b>PFNFILLTEXTBUFFER</b> that refills the <b>awcBuffer</b>
    ///with text from the source document.
    PFNFILLTEXTBUFFER pfnFillTextBuffer;
    ///Type: <b>WCHAR*</b> Pointer to a buffer that contains text from the source document for the word breaker to
    ///parse.
    const(PWSTR)      awcBuffer;
    ///Type: <b>ULONG</b> Position of the last character in <b>awcBuffer</b>.
    uint              iEnd;
    ///Type: <b>ULONG</b> Position of the first character in <b>awcBuffer</b>.
    uint              iCur;
}

///Specifies parameters for a Shell data source for which a filter is loaded.
struct FILTERED_DATA_SOURCES
{
    ///Pointer to a buffer that contains a file name extension.
    const(PWSTR) pwcsExtension;
    ///Pointer to a buffer that contains the name of a MIME type.
    const(PWSTR) pwcsMime;
    ///Pointer to a CLSID that identifies the content type.
    const(GUID)* pClsid;
    ///Not implemented.
    const(PWSTR) pwcsOverride;
}

struct IRowsetExactScroll
{
}

struct DB_NUMERIC
{
    ubyte     precision;
    ubyte     scale;
    ubyte     sign;
    ubyte[16] val;
}

struct DBVECTOR
{
align (2):
    uint  size;
    void* ptr;
}

struct DBDATE
{
    short  year;
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
align (2):
    short  year;
    ushort month;
    ushort day;
    ushort hour;
    ushort minute;
    ushort second;
    uint   fraction;
}

struct DB_VARNUMERIC
{
    ubyte    precision;
    byte     scale;
    ubyte    sign;
    ubyte[1] val;
}

struct SEC_OBJECT_ELEMENT
{
align (2):
    GUID guidObjectType;
    DBID ObjectID;
}

struct SEC_OBJECT
{
align (2):
    uint                cObjects;
    SEC_OBJECT_ELEMENT* prgObjects;
}

struct DBIMPLICITSESSION
{
align (2):
    IUnknown pUnkOuter;
    GUID*    piid;
    IUnknown pSession;
}

struct DBOBJECT
{
align (2):
    uint dwFlags;
    GUID iid;
}

struct DBBINDEXT
{
align (2):
    ubyte* pExtension;
    uint   ulExtension;
}

struct DBBINDING
{
align (2):
    uint       iOrdinal;
    uint       obValue;
    uint       obLength;
    uint       obStatus;
    ITypeInfo  pTypeInfo;
    DBOBJECT*  pObject;
    DBBINDEXT* pBindExt;
    uint       dwPart;
    uint       dwMemOwner;
    uint       eParamIO;
    uint       cbMaxLen;
    uint       dwFlags;
    ushort     wType;
    ubyte      bPrecision;
    ubyte      bScale;
}

struct DBFAILUREINFO
{
align (2):
    size_t  hRow;
    uint    iColumn;
    HRESULT failure;
}

struct DBCOLUMNINFO
{
align (2):
    PWSTR     pwszName;
    ITypeInfo pTypeInfo;
    uint      iOrdinal;
    uint      dwFlags;
    uint      ulColumnSize;
    ushort    wType;
    ubyte     bPrecision;
    ubyte     bScale;
    DBID      columnid;
}

struct DBPARAMS
{
align (2):
    void*  pData;
    uint   cParamSets;
    size_t hAccessor;
}

struct DBPARAMINFO
{
align (2):
    uint      dwFlags;
    uint      iOrdinal;
    PWSTR     pwszName;
    ITypeInfo pTypeInfo;
    uint      ulParamSize;
    ushort    wType;
    ubyte     bPrecision;
    ubyte     bScale;
}

struct DBPROPIDSET
{
align (2):
    uint* rgPropertyIDs;
    uint  cPropertyIDs;
    GUID  guidPropertySet;
}

struct DBPROPINFO
{
align (2):
    PWSTR   pwszDescription;
    uint    dwPropertyID;
    uint    dwFlags;
    ushort  vtType;
    VARIANT vValues;
}

struct DBPROPINFOSET
{
align (2):
    DBPROPINFO* rgPropertyInfos;
    uint        cPropertyInfos;
    GUID        guidPropertySet;
}

struct DBPROP
{
align (2):
    uint    dwPropertyID;
    uint    dwOptions;
    uint    dwStatus;
    DBID    colid;
    VARIANT vValue;
}

struct DBPROPSET
{
align (2):
    DBPROP* rgProperties;
    uint    cProperties;
    GUID    guidPropertySet;
}

struct DBINDEXCOLUMNDESC
{
align (2):
    DBID* pColumnID;
    uint  eIndexColOrder;
}

struct DBCOLUMNDESC
{
align (2):
    PWSTR      pwszTypeName;
    ITypeInfo  pTypeInfo;
    DBPROPSET* rgPropertySets;
    GUID*      pclsid;
    uint       cPropertySets;
    uint       ulColumnSize;
    DBID       dbcid;
    ushort     wType;
    ubyte      bPrecision;
    ubyte      bScale;
}

struct DBCOLUMNACCESS
{
align (2):
    void*  pData;
    DBID   columnid;
    uint   cbDataLen;
    uint   dwStatus;
    uint   cbMaxLen;
    uint   dwReserved;
    ushort wType;
    ubyte  bPrecision;
    ubyte  bScale;
}

struct DBCONSTRAINTDESC
{
align (2):
    DBID*      pConstraintID;
    uint       ConstraintType;
    uint       cColumns;
    DBID*      rgColumnList;
    DBID*      pReferencedTableID;
    uint       cForeignKeyColumns;
    DBID*      rgForeignKeyColumnList;
    PWSTR      pwszConstraintText;
    uint       UpdateRule;
    uint       DeleteRule;
    uint       MatchType;
    uint       Deferrability;
    uint       cReserved;
    DBPROPSET* rgReserved;
}

struct MDAXISINFO
{
align (2):
    uint   cbSize;
    uint   iAxis;
    uint   cDimensions;
    uint   cCoordinates;
    uint*  rgcColumns;
    PWSTR* rgpwszDimensionNames;
}

struct RMTPACK
{
align (2):
    ISequentialStream pISeqStream;
    uint              cbData;
    uint              cBSTR;
    BSTR*             rgBSTR;
    uint              cVARIANT;
    VARIANT*          rgVARIANT;
    uint              cIDISPATCH;
    IDispatch*        rgIDISPATCH;
    uint              cIUNKNOWN;
    IUnknown*         rgIUNKNOWN;
    uint              cPROPVARIANT;
    PROPVARIANT*      rgPROPVARIANT;
    uint              cArray;
    VARIANT*          rgArray;
}

struct DBPARAMBINDINFO
{
align (2):
    PWSTR pwszDataSourceType;
    PWSTR pwszName;
    uint  ulParamSize;
    uint  dwFlags;
    ubyte bPrecision;
    ubyte bScale;
}

struct DBLITERALINFO
{
align (2):
    PWSTR pwszLiteralValue;
    PWSTR pwszInvalidChars;
    PWSTR pwszInvalidStartingChars;
    uint  lt;
    BOOL  fSupported;
    uint  cchMaxLen;
}

struct ERRORINFO
{
align (2):
    HRESULT hrError;
    uint    dwMinor;
    GUID    clsid;
    GUID    iid;
    int     dispid;
}

///Identifies the range of matching data when query search conditions match indexed data.
struct HITRANGE
{
    ///Type: <b>ULONG</b> The beginning of the hit range.
    uint iPosition;
    ///Type: <b>ULONG</b> The length of the hit range.
    uint cLength;
}

///Stores time-out values for connections and data.
struct TIMEOUT_INFO
{
    ///Type: <b>DWORD</b> The size of the structure, in bytes.
    uint dwSize;
    ///Type: <b>DWORD</b> The time-out value for a connection, in seconds.
    uint dwConnectTimeout;
    uint dwDataTimeout;
}

///Stores information about a proxy. Used by ISearchProtocol.
struct PROXY_INFO
{
    ///Type: <b>DWORD</b> The size of the structure in bytes.
    uint         dwSize;
    ///Type: <b>LPCWSTR</b> A pointer to a Unicode string buffer containing the user agent string.
    const(PWSTR) pcwszUserAgent;
    ///Type: <b>PROXY_ACCESS</b> The proxy type to use.
    PROXY_ACCESS paUseProxy;
    ///Type: <b>BOOL</b> The bypass proxy for local addresses.
    BOOL         fLocalBypass;
    ///Type: <b>DWORD</b> The port number to use.
    uint         dwPortNumber;
    ///Type: <b>LPCWSTR</b> A pointer to a Unicode string buffer that contains the name of the proxy server.
    const(PWSTR) pcwszProxyName;
    const(PWSTR) pcwszBypassList;
}

///Describes security authentication information for content access.
struct AUTHENTICATION_INFO
{
    ///Type: <b>DWORD</b> Size of the structure, in bytes.
    uint         dwSize;
    ///Type: <b>AUTH_TYPE</b> Flag to describe the type of authentication. For a list of possible values, see the
    ///AUTH_TYPE enumerated type.
    AUTH_TYPE    atAuthenticationType;
    ///Type: <b>LPCWSTR</b> Pointer to a null-terminated Unicode string containing the user name.
    const(PWSTR) pcwszUser;
    const(PWSTR) pcwszPassword;
}

///Contains access information used by an incremental crawl, such as the last access date and modification time.
struct INCREMENTAL_ACCESS_INFO
{
    ///Type: <b>DWORD</b> Size of the file in bytes.
    uint     dwSize;
    FILETIME ftLastModifiedTime;
}

///Contains information passed to the IUrlAccessor object about the current item; for example, the application name and
///catalog name.
struct ITEM_INFO
{
    ///Type: <b>DWORD</b> Size of the structure in bytes.
    uint         dwSize;
    ///Type: <b>LPCWSTR</b> Pointer to a null-terminated Unicode string containing an email address that is notified in
    ///case of error.
    const(PWSTR) pcwszFromEMail;
    ///Type: <b>LPCWSTR</b> Pointer to a null-terminated Unicode string containing the application name.
    const(PWSTR) pcwszApplicationName;
    ///Type: <b>LPCWSTR</b> Pointer to a null-terminated Unicode string containing the workspace name from which the
    ///crawl to this content source was initiated.
    const(PWSTR) pcwszCatalogName;
    const(PWSTR) pcwszContentClass;
}

///Specifies the changes to an indexed item.
struct SEARCH_ITEM_CHANGE
{
    ///Type: <b>SEARCH_KIND_OF_CHANGE</b> Flag that specifies the kind of change as a value from the
    ///SEARCH_KIND_OF_CHANGE enumerated type.
    SEARCH_KIND_OF_CHANGE Change;
    ///Type: <b>SEARCH_NOTIFICATION_PRIORITY</b> Flag that specifies the priority of processing this change as a value
    ///from the SEARCH_NOTIFICATION_PRIORITY enumerated type.
    SEARCH_NOTIFICATION_PRIORITY Priority;
    ///Type: <b>BLOB*</b> Pointer to user information.
    BLOB* pUserData;
    ///Type: <b>LPWSTR</b> Pointer to a null-terminated Unicode string containing the URL of the item in a
    ///SEARCH_CHANGE_MOVE_RENAME, SEARCH_CHANGE_ADD, or SEARCH_CHANGE_MODIFY notification. In the case of a move, this
    ///member contains the new URL of the item.
    PWSTR lpwszURL;
    PWSTR lpwszOldURL;
}

///Contains information about the kind of change that has occurred in an item to be indexed. This structure is used with
///the ISearchPersistentItemsChangedSink::OnItemsChanged method to pass information to the indexer about what has
///changed.
struct SEARCH_ITEM_PERSISTENT_CHANGE
{
    ///Type: <b>SEARCH_KIND_OF_CHANGE</b> A value from the SEARCH_KIND_OF_CHANGE enumerated type that indicates the kind
    ///of change.
    SEARCH_KIND_OF_CHANGE Change;
    ///Type: <b>LPWSTR</b> Pointer to a null-terminated Unicode string containing the URL of the item in a
    ///SEARCH_CHANGE_ADD, SEARCH_CHANGE_MODIFY, or SEARCH_CHANGE_DELETE notification. In the case of a move, this member
    ///contains the new URL of the item.
    PWSTR URL;
    PWSTR OldURL;
    ///Type: <b>SEARCH_NOTIFICATION_PRIORITY</b> A value from the SEARCH_NOTIFICATION_PRIORITY enumerated type that
    ///indicates the priority of the change.
    SEARCH_NOTIFICATION_PRIORITY Priority;
}

///Describes the status of a document to be indexed.
struct SEARCH_ITEM_INDEXING_STATUS
{
    ///Type: <b>DWORD</b> Document identifier.
    uint    dwDocID;
    HRESULT hrIndexingStatus;
}

///This structure is not implemented.
struct SEARCH_COLUMN_PROPERTIES
{
    ///Type: <b>PROPVARIANT</b> The name of the column referenced in the ISearchQueryHelper::WriteProperties methods
    ///pColumns property array.
    PROPVARIANT Value;
    uint        lcid;
}

///<p class="CCE_Message">[<b>ITEMPROP</b> and IItemPropertyBag are supported only on Windows XP and Windows Server
///2003, and should no longer be used.] Stores information about properties in the Windows Property System, and is used
///by the IItemPropertyBag interface.
struct ITEMPROP
{
    VARIANT variantValue;
    PWSTR   pwszName;
}

struct SUBSCRIPTIONITEMINFO
{
    uint cbSize;
    uint dwFlags;
    uint dwPriority;
    GUID ScheduleGroup;
    GUID clsidAgent;
}

struct _tagSubscriptionInfo
{
    uint                 cbSize;
    uint                 fUpdateFlags;
    SUBSCRIPTIONSCHEDULE schedule;
    GUID                 customGroupCookie;
    void*                pTrigger;
    uint                 dwRecurseLevels;
    uint                 fWebcrawlerFlags;
    BOOL                 bMailNotification;
    BOOL                 bGleam;
    BOOL                 bChangesOnly;
    BOOL                 bNeedPassword;
    uint                 fChannelFlags;
    BSTR                 bstrUserName;
    BSTR                 bstrPassword;
    BSTR                 bstrFriendlyName;
    uint                 dwMaxSizeKB;
    SUBSCRIPTIONTYPE     subType;
    uint                 fTaskFlags;
    uint                 dwReserved;
}

// Interfaces

@GUID("7D096C5F-AC08-4F1F-BEB7-5C22C517CE39")
struct CSearchManager;

@GUID("30766BD2-EA1C-4F28-BF27-0B44E2F68DB7")
struct CSearchRoot;

@GUID("E63DE750-3BD7-4BE5-9C84-6B4281988C44")
struct CSearchScopeRule;

@GUID("9E175B8D-F52A-11D8-B9A5-505054503030")
struct FilterRegistration;

@GUID("B72F8FD8-0FAB-4DD9-BDBF-245A6CE1485B")
struct QueryParser;

@GUID("8DE9C74C-605A-4ACD-BEE3-2B222AA2D23D")
struct NegationCondition;

@GUID("116F8D13-101E-4FA5-84D4-FF8279381935")
struct CompoundCondition;

@GUID("52F15C89-5A17-48E1-BBCD-46A3F89C7CC2")
struct LeafCondition;

@GUID("E03E85B0-7BE3-4000-BA98-6C13DE9FA486")
struct ConditionFactory;

@GUID("D957171F-4BF9-4DE2-BCD5-C70A7CA55836")
struct Interval;

@GUID("5088B39A-29B4-4D9D-8245-4EE289222F66")
struct QueryParserManager;

@GUID("6A68CC80-4337-4DBC-BD27-FBFB1053820B")
struct CSearchLanguageSupport;

@GUID("ABBE31D0-6DAE-11D0-BECA-00C04FD940BE")
struct SubscriptionMgr;

@GUID("CC907054-C058-101A-B554-08002B33B0E6")
interface IWordSink : IUnknown
{
    HRESULT PutWord(uint cwc, const(PWSTR) pwcInBuf, uint cwcSrcLen, uint cwcSrcPos);
    HRESULT PutAltWord(uint cwc, const(PWSTR) pwcInBuf, uint cwcSrcLen, uint cwcSrcPos);
    HRESULT StartAltPhrase();
    HRESULT EndAltPhrase();
    HRESULT PutBreak(WORDREP_BREAK_TYPE breakType);
}

///Parses text and identifies individual words and phrases. This interface is a language-specific language resource
///component. It is used in background processes and must be optimized for both throughput and minimal use of resources.
@GUID("D53552C8-77E3-101A-B552-08002B33B0E6")
interface IWordBreaker : IUnknown
{
    ///Initializes the IWordBreaker implementation and indicates the mode in which the component operates.
    ///Params:
    ///    fQuery = Type: <b>BOOL</b> Flag that indicates the mode in which a word breaker operates. <b>TRUE</b> indicates
    ///             query-time word breaking. <b>FALSE</b> indicates index-time word breaking.
    ///    ulMaxTokenSize = Type: <b>ULONG</b> Maximum number of characters in words that are added to the IWordSink. Words that exceed
    ///                     this limit are truncated.
    ///    pfLicense = Type: <b>BOOL*</b> Pointer to a variable that receives a flag indicating whether there are license
    ///                restrictions for this IWordBreaker implementation. <b>TRUE</b> indicates that the stemmer is restricted to
    ///                authorized use only. <b>FALSE</b> indicates that this <b>IWordBreaker</b> implementation can be used freely.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method can return one of these values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Successful completion. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>LANGUAGE_E_DATABASE_NOT_FOUND</b></dt>
    ///    </dl> </td> <td width="60%"> One of the components for word breaking cannot be located. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> Invalid argument. The
    ///    <i>pfLicense</i> parameter is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt>
    ///    </dl> </td> <td width="60%"> Other errors. </td> </tr> </table>
    ///    
    HRESULT Init(BOOL fQuery, uint ulMaxTokenSize, BOOL* pfLicense);
    ///Parses text to identify words and phrases and provides the results to the IWordSink and IPhraseSink objects.
    ///Params:
    ///    pTextSource = Type: <b>TEXT_SOURCE*</b> Pointer to a TEXT_SOURCE structure that contains Unicode text.
    ///    pWordSink = Type: <b>IWordSink*</b> Pointer to the IWordSink object that receives and handles words generated by this
    ///                method. <b>NULL</b> indicates that this method should identify phrases only.
    ///    pPhraseSink = Type: <b>IPhraseSink*</b> Pointer to the IPhraseSink object that receives and handles phrases generated by
    ///                  this method. <b>NULL</b> indicates that this method should identify individual words, not phrases.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method can return one of these values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Operation was successful. No more text is available to refill the <i>pTextSource</i> buffer. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> Invalid argument. The
    ///    <i>pTextSource</i> parameter is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT BreakText(TEXT_SOURCE* pTextSource, IWordSink pWordSink, IPhraseSink pPhraseSink);
    ///Not supported.
    ///Params:
    ///    pwcNoun = TBD
    ///    cwcNoun = TBD
    ///    pwcModifier = TBD
    ///    cwcModifier = TBD
    ///    ulAttachmentType = TBD
    ///    pwcPhrase = TBD
    ///    pcwcPhrase = TBD
    HRESULT ComposePhrase(const(PWSTR) pwcNoun, uint cwcNoun, const(PWSTR) pwcModifier, uint cwcModifier, 
                          uint ulAttachmentType, PWSTR pwcPhrase, uint* pcwcPhrase);
    ///Gets a pointer to the license information for this implementation of the IWordBreaker interface.
    ///Params:
    ///    ppwcsLicense = Type: <b>WCHAR const**</b> Pointer to a variable that receives a pointer to the license information for this
    ///                   IWordBreaker implementation.
    HRESULT GetLicenseToUse(const(ushort)** ppwcsLicense);
}

///Handles the list of alternative word forms that stemmers generate during query time.
@GUID("FE77C330-7F42-11CE-BE57-00AA0051FE20")
interface IWordFormSink : IUnknown
{
    HRESULT PutAltWord(const(PWSTR) pwcInBuf, uint cwc);
    HRESULT PutWord(const(PWSTR) pwcInBuf, uint cwc);
}

///Provides methods for creating a language-specific stemmer. The stemmer generates inflected forms of a specified word.
@GUID("EFBAF140-7F42-11CE-BE57-00AA0051FE20")
interface IStemmer : IUnknown
{
    ///Initializes the stemmer.
    ///Params:
    ///    ulMaxTokenSize = Type: <b>ULONG</b> Maximum number of characters for words that are added to the IWordFormSink object. Words
    ///                     that exceed this limit may be truncated.
    ///    pfLicense = Type: <b>BOOL</b> Pointer to an output variable that receives a flag that indicates whether there are license
    ///                restrictions for this IStemmer implementation. <b>TRUE</b> indicates that the stemmer is restricted to
    ///                authorized use only. <b>FALSE</b> indicates that this <b>IStemmer</b> implementation can be used freely.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method can return one of these values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Successful completion. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>LANGUAGE_E_DATABASE_NOT_FOUND</b></dt>
    ///    </dl> </td> <td width="60%"> One of the components for word breaking cannot be located. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> Invalid argument. The
    ///    <i>pfLicense</i> parameter is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt>
    ///    </dl> </td> <td width="60%"> Unsuccessful completion. </td> </tr> </table>
    ///    
    HRESULT Init(uint ulMaxTokenSize, BOOL* pfLicense);
    ///Generates alternative forms for a word and puts these forms in the IWordFormSink object.
    ///Params:
    ///    pwcInBuf = Type: <b>const WCHAR*</b> Pointer to a buffer that contains the word to stem. The characters in
    ///               <i>pwcInBuf</i> are represented in Unicode.
    ///    cwc = Type: <b>ULONG</b> Number of characters in <i>pwcInBuf</i>.
    ///    pStemSink = Type: <b>IWordFormSink*</b> Pointer to an IWordFormSink object that receives and handles the alternative word
    ///                forms generated by this method.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method can return one of these values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Successful completion. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> Invalid argument. Either <i>pwcInBuf</i> or <i>pWordFormSink</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GenerateWordForms(const(PWSTR) pwcInBuf, uint cwc, IWordFormSink pStemSink);
    ///Gets the license information for this IStemmer implementation.
    ///Params:
    ///    ppwcsLicense = Type: <b>const WCHAR**</b> Pointer to a variable that receives a pointer to the license information for this
    ///                   IStemmer implementation.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetLicenseToUse(const(ushort)** ppwcsLicense);
}

///Contains methods for interacting with the file catalog.
@GUID("5E341AB7-02D0-11D1-900C-00A0C9063796")
interface ISimpleCommandCreator : IUnknown
{
    ///Creates an ICommand.
    ///Params:
    ///    ppIUnknown = Returns the IUnknown for the command.
    ///    pOuterUnk = Optional outer unknown pointer.
    ///Returns:
    ///    If this method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT CreateICommand(IUnknown* ppIUnknown, IUnknown pOuterUnk);
    ///Validates the catalog location.
    ///Params:
    ///    pwszMachine = Machine on which the catalog exists.
    ///    pwszCatalogName = The catalog name.
    ///Returns:
    ///    If the catalog is accessible, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT VerifyCatalog(const(PWSTR) pwszMachine, const(PWSTR) pwszCatalogName);
    ///Determines the default catalog for the system.
    ///Params:
    ///    pwszCatalogName = The catalog name.
    ///    cwcIn = The size in characters of <i>pwszCatalogName</i>.
    ///    pcwcOut = Size of the catalog name.
    ///Returns:
    ///    If this method succeeds, it returns the contents of the IsapiDefaultCatalogDirectory registry value.
    ///    Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetDefaultCatalog(PWSTR pwszCatalogName, uint cwcIn, uint* pcwcOut);
}

///Retrieves property information for file based queries.
@GUID("0B63E37A-9CCC-11D0-BCDB-00805FCCCE04")
interface IColumnMapper : IUnknown
{
    ///Gets property information from a name. This will return a DBID pointer in parameter <i>ppPropId</i> which now has
    ///to be freed by the caller and not by the callee (this class).
    ///Params:
    ///    wcsPropName = The property name to look up.
    ///    ppPropId = The return Id of the property.
    ///    pPropType = The return type of the property.
    ///    puiWidth = The return property width.
    ///Returns:
    ///    If this method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetPropInfoFromName(const(PWSTR) wcsPropName, DBID** ppPropId, ushort* pPropType, uint* puiWidth);
    ///Gets the property information from the DBID.
    ///Params:
    ///    pPropId = Pointer to the property to look up.
    ///    pwcsName = The return property name.
    ///    pPropType = The return type of the property.
    ///    puiWidth = The return property width.
    ///Returns:
    ///    If this method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetPropInfoFromId(const(DBID)* pPropId, ushort** pwcsName, ushort* pPropType, uint* puiWidth);
    ///Gets the i-th entry from the list of properties.
    ///Params:
    ///    iEntry = i-th entry to retrieve. Note that the entries are 0-based.
    ///    pwcsName = The return property name.
    ///    ppPropId = The Id of the property.
    ///    pPropType = The return type of the property.
    ///    puiWidth = The return property width.
    ///Returns:
    ///    If this method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT EnumPropInfo(uint iEntry, const(ushort)** pwcsName, DBID** ppPropId, ushort* pPropType, uint* puiWidth);
    ///Determines if the map is up to date.
    ///Returns:
    ///    If this method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT IsMapUpToDate();
}

///Contains a method to retrieves a column mapper object.
@GUID("0B63E37B-9CCC-11D0-BCDB-00805FCCCE04")
interface IColumnMapperCreator : IUnknown
{
    ///Retrieves a column mapper object.
    ///Params:
    ///    wcsMachineName = Machine on which the catalog exists.
    ///    wcsCatalogName = Catalog for which column mapper is requested.
    ///    ppColumnMapper = Stores the outgoing column mapper pointer.
    ///Returns:
    ///    If this method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetColumnMapper(const(PWSTR) wcsMachineName, const(PWSTR) wcsCatalogName, 
                            IColumnMapper* ppColumnMapper);
}

///Defines methods and properties that are implemented by the FilterRegistration object, which provides methods for
///loading a filter.
@GUID("C7310722-AC80-11D1-8DF3-00C04FB6EF4F")
interface ILoadFilter : IUnknown
{
    ///Retrieves and loads the most appropriate filter that is mapped to a Shell data source.
    ///Params:
    ///    pwcsPath = Pointer to a comma-delimited null-terminated Unicode string buffer that specifies the path of the file to be
    ///               filtered. This parameter can be null.
    ///    pFilteredSources = Pointer to the FILTERED_DATA_SOURCES structure that specifies parameters for a Shell data source for which a
    ///                       filter is loaded. This parameter cannot be null.
    ///    pUnkOuter = If the object is being created as part of an aggregate, specify a pointer to the controlling IUnknown
    ///                interface of the aggregate.
    ///    fUseDefault = If <b>TRUE</b>, use the default filter; if <b>FALSE</b>, proceed with the most appropriate filter that is
    ///                  available.
    ///    pFilterClsid = Pointer to the CLSID (CLSID_FilterRegistration) that receives the class identifier of the returned filter.
    ///    SearchDecSize = Not implemented.
    ///    pwcsSearchDesc = Not implemented.
    ///    ppIFilt = The address of a pointer to an implementation of an IFilter interface that <b>LoadIFilter</b> selects.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT LoadIFilter(const(PWSTR) pwcsPath, FILTERED_DATA_SOURCES* pFilteredSources, IUnknown pUnkOuter, 
                        BOOL fUseDefault, GUID* pFilterClsid, int* SearchDecSize, ushort** pwcsSearchDesc, 
                        IFilter* ppIFilt);
    ///Not implemented. Do not use: this method is not implemented.
    ///Params:
    ///    pStg = 
    ///    pUnkOuter = 
    ///    pwcsOverride = 
    ///    fUseDefault = 
    ///    pFilterClsid = 
    ///    SearchDecSize = 
    ///    pwcsSearchDesc = 
    ///    ppIFilt = 
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT LoadIFilterFromStorage(IStorage pStg, IUnknown pUnkOuter, const(PWSTR) pwcsOverride, BOOL fUseDefault, 
                                   GUID* pFilterClsid, int* SearchDecSize, ushort** pwcsSearchDesc, IFilter* ppIFilt);
    ///Not implemented. Do not use: this method is not implemented.
    ///Params:
    ///    pStm = 
    ///    pFilteredSources = 
    ///    pUnkOuter = 
    ///    fUseDefault = 
    ///    pFilterClsid = 
    ///    SearchDecSize = 
    ///    pwcsSearchDesc = 
    ///    ppIFilt = 
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT LoadIFilterFromStream(IStream pStm, FILTERED_DATA_SOURCES* pFilteredSources, IUnknown pUnkOuter, 
                                  BOOL fUseDefault, GUID* pFilterClsid, int* SearchDecSize, ushort** pwcsSearchDesc, 
                                  IFilter* ppIFilt);
}

@GUID("40BDBD34-780B-48D3-9BB6-12EBD4AD2E75")
interface ILoadFilterWithPrivateComActivation : ILoadFilter
{
    HRESULT LoadIFilterWithPrivateComActivation(FILTERED_DATA_SOURCES* filteredSources, BOOL useDefault, 
                                                GUID* filterClsid, BOOL* isFilterPrivateComActivated, 
                                                IFilter* filterObj);
}

///Represents a chunk of data as a string and a PROPVARIANT value.
@GUID("4FDEF69C-DBC9-454E-9910-B34F3C64B510")
interface IRichChunk : IUnknown
{
    ///Retrieves the PROPVARIANT and input string that represents a chunk of data.
    ///Params:
    ///    pFirstPos = Type: <b>ULONG*</b> Receives the zero-based starting position of the range. This parameter can be
    ///                <b>NULL</b>.
    ///    pLength = Type: <b>ULONG*</b> Receives the length of the range. This parameter can be <b>NULL</b>.
    ///    ppsz = Type: <b>LPWSTR*</b> Receives the associated Unicode string value, or <b>NULL</b> if not available.
    ///    pValue = Type: <b>PROPVARIANT*</b> Receives the associated PROPVARIANT value, or <b>VT_EMPTY</b> if not available.
    ///             This parameter can be <b>NULL</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetData(uint* pFirstPos, uint* pLength, PWSTR* ppsz, PROPVARIANT* pValue);
}

///Provides methods for retrieving information about a search condition. An <b>ICondition</b> object represents the
///result of parsing an input string (using methods such as IQueryParser::Parse or IQuerySolution::GetQuery) into a tree
///of search condition nodes. A node can be a logical AND, OR, or NOT for comparing subnodes, or it can be a leaf node
///comparing a property and a constant value.
@GUID("0FC988D4-C935-4B97-A973-46282EA175C8")
interface ICondition : IPersistStream
{
    ///Retrieves the condition type for this search condition node, identifying it as a logical AND, OR, or NOT, or as a
    ///leaf node.
    ///Params:
    ///    pNodeType = Type: <b>CONDITION_TYPE*</b> Receives the CONDITION_TYPE enumeration for this node.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetConditionType(CONDITION_TYPE* pNodeType);
    ///Retrieves a collection of the subconditions of the search condition node and the IID of the interface for
    ///enumerating the collection.
    ///Params:
    ///    riid = Type: <b>REFIID</b> The desired IID of the enumerating interface: either IID_IEnumUnknown, IID_IEnumVARIANT
    ///           or (for a negation condition) IID_ICondition.
    ///    ppv = Type: <b>void**</b> Receives a collection of zero or more ICondition objects. Each object is a subcondition
    ///          of this condition node. If <i>riid</i> was IID_ICondition and this is a negation condition, this parameter
    ///          receives the single subcondition.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful, E_FAIL if this is a leaf node, or an error value otherwise.
    ///    
    HRESULT GetSubConditions(const(GUID)* riid, void** ppv);
    ///Retrieves the property name, operation, and value from a leaf search condition node.
    ///Params:
    ///    ppszPropertyName = Type: <b>LPWSTR*</b> Receives the name of the property of the leaf condition as a Unicode string.
    ///    pcop = Type: <b>CONDITION_OPERATION*</b> Receives the operation of the leaf condition as a CONDITION_OPERATION
    ///           enumeration.
    ///    ppropvar = Type: <b>PROPVARIANT*</b> Receives the value of the leaf condition as a PROPVARIANT.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful, E_FAIL if this is not a leaf node, or an error value
    ///    otherwise.
    ///    
    HRESULT GetComparisonInfo(PWSTR* ppszPropertyName, CONDITION_OPERATION* pcop, PROPVARIANT* ppropvar);
    ///Retrieves the semantic type of the value of the search condition node.
    ///Params:
    ///    ppszValueTypeName = Type: <b>LPWSTR*</b> Receives either a pointer to the semantic type of the value as a Unicode string or
    ///                        <b>NULL</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful, E_FAIL if this is not a leaf node, or an error value
    ///    otherwise.
    ///    
    HRESULT GetValueType(PWSTR* ppszValueTypeName);
    ///Retrieves the character-normalized value of the search condition node.
    ///Params:
    ///    ppszNormalization = Type: <b>LPWSTR*</b> Receives a pointer to a Unicode string representation of the value.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful, E_FAIL if this is not a leaf node, or an error value
    ///    otherwise.
    ///    
    HRESULT GetValueNormalization(PWSTR* ppszNormalization);
    ///For a leaf node, <b>ICondition::GetInputTerms</b> retrieves information about what parts (or ranges) of the input
    ///string produced the property, the operation, and the value for the search condition node.
    ///Params:
    ///    ppPropertyTerm = Type: <b>IRichChunk**</b> Receives a pointer to an IRichChunk interface that provides information about what
    ///                     part of the input string produced the property of the leaf node, if that can be determined; otherwise, this
    ///                     parameter is set to <b>NULL</b>.
    ///    ppOperationTerm = Type: <b>IRichChunk**</b> Receives a pointer to an IRichChunk interface that provides information about what
    ///                      part of the input string produced the operation of the leaf node, if that can be determined; otherwise, this
    ///                      parameter is set to <b>NULL</b>.
    ///    ppValueTerm = Type: <b>IRichChunk**</b> Receives a pointer to an IRichChunk interface that provides information about what
    ///                  part of the input string produced the value of the leaf node, if that can be determined; otherwise, this
    ///                  parameter is set to <b>NULL</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetInputTerms(IRichChunk* ppPropertyTerm, IRichChunk* ppOperationTerm, IRichChunk* ppValueTerm);
    ///Creates a deep copy of this ICondition object.
    ///Params:
    ///    ppc = Type: <b>ICondition**</b> Receives a pointer to the clone of this ICondition.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Clone(ICondition* ppc);
}

///Extends the functionality of the ICondition interface. <b>ICondition2</b> provides methods for retrieving information
///about a search condition.
@GUID("0DB8851D-2E5B-47EB-9208-D28C325A01D7")
interface ICondition2 : ICondition
{
    ///Retrieves the property name, operation, and value from a leaf search condition node.
    ///Params:
    ///    ppszLocaleName = Type: <b>LPWSTR*</b> Receives the name of the locale of the leaf condition as a Unicode string. This
    ///                     parameter can be <b>NULL</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful, E_FAIL if this is not a leaf node, or an error value
    ///    otherwise.
    ///    
    HRESULT GetLocale(PWSTR* ppszLocaleName);
    ///Retrieves the property name, operation, and value from a leaf search condition node.
    ///Params:
    ///    ppropkey = Type: <b>PROPERTYKEY*</b> Receives the name of the property of the leaf condition as a PROPERTYKEY.
    ///    pcop = Type: <b>CONDITION_OPERATION*</b> Receives the operation of the leaf condition as a CONDITION_OPERATION
    ///           enumeration.
    ///    ppropvar = Type: <b>PROPVARIANT*</b> Receives the property value of the leaf condition as a PROPVARIANT.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful, E_FAIL if this is not a leaf node, or an error value
    ///    otherwise.
    ///    
    HRESULT GetLeafConditionInfo(PROPERTYKEY* ppropkey, CONDITION_OPERATION* pcop, PROPVARIANT* ppropvar);
}

@GUID("0C733A8C-2A1C-11CE-ADE5-00AA0044773D")
interface IAccessor : IUnknown
{
    HRESULT AddRefAccessor(size_t hAccessor, uint* pcRefCount);
    HRESULT CreateAccessor(uint dwAccessorFlags, uint cBindings, const(DBBINDING)* rgBindings, uint cbRowSize, 
                           size_t* phAccessor, uint* rgStatus);
    HRESULT GetBindings(size_t hAccessor, uint* pdwAccessorFlags, uint* pcBindings, DBBINDING** prgBindings);
    HRESULT ReleaseAccessor(size_t hAccessor, uint* pcRefCount);
}

@GUID("0C733A7C-2A1C-11CE-ADE5-00AA0044773D")
interface IRowset : IUnknown
{
    HRESULT AddRefRows(uint cRows, const(size_t)* rghRows, uint* rgRefCounts, uint* rgRowStatus);
    HRESULT GetData(size_t hRow, size_t hAccessor, void* pData);
    HRESULT GetNextRows(size_t hReserved, int lRowsOffset, int cRows, uint* pcRowsObtained, size_t** prghRows);
    HRESULT ReleaseRows(uint cRows, const(size_t)* rghRows, uint* rgRowOptions, uint* rgRefCounts, 
                        uint* rgRowStatus);
    HRESULT RestartPosition(size_t hReserved);
}

@GUID("0C733A55-2A1C-11CE-ADE5-00AA0044773D")
interface IRowsetInfo : IUnknown
{
    HRESULT GetProperties(const(uint) cPropertyIDSets, const(DBPROPIDSET)* rgPropertyIDSets, uint* pcPropertySets, 
                          DBPROPSET** prgPropertySets);
    HRESULT GetReferencedRowset(uint iOrdinal, const(GUID)* riid, IUnknown* ppReferencedRowset);
    HRESULT GetSpecification(const(GUID)* riid, IUnknown* ppSpecification);
}

@GUID("0C733A7D-2A1C-11CE-ADE5-00AA0044773D")
interface IRowsetLocate : IRowset
{
    HRESULT Compare(size_t hReserved, uint cbBookmark1, const(ubyte)* pBookmark1, uint cbBookmark2, 
                    const(ubyte)* pBookmark2, uint* pComparison);
    HRESULT GetRowsAt(size_t hReserved1, size_t hReserved2, uint cbBookmark, const(ubyte)* pBookmark, 
                      int lRowsOffset, int cRows, uint* pcRowsObtained, size_t** prghRows);
    HRESULT GetRowsByBookmark(size_t hReserved, uint cRows, const(uint)* rgcbBookmarks, 
                              const(ubyte)** rgpBookmarks, size_t* rghRows, uint* rgRowStatus);
    HRESULT Hash(size_t hReserved, uint cBookmarks, const(uint)* rgcbBookmarks, const(ubyte)** rgpBookmarks, 
                 uint* rgHashedValues, uint* rgBookmarkStatus);
}

@GUID("0C733A84-2A1C-11CE-ADE5-00AA0044773D")
interface IRowsetResynch : IUnknown
{
    HRESULT GetVisibleData(size_t hRow, size_t hAccessor, void* pData);
    HRESULT ResynchRows(uint cRows, const(size_t)* rghRows, uint* pcRowsResynched, size_t** prghRowsResynched, 
                        uint** prgRowStatus);
}

@GUID("0C733A7E-2A1C-11CE-ADE5-00AA0044773D")
interface IRowsetScroll : IRowsetLocate
{
    HRESULT GetApproximatePosition(size_t hReserved, uint cbBookmark, const(ubyte)* pBookmark, uint* pulPosition, 
                                   uint* pcRows);
    HRESULT GetRowsAtRatio(size_t hReserved1, size_t hReserved2, uint ulNumerator, uint ulDenominator, int cRows, 
                           uint* pcRowsObtained, size_t** prghRows);
}

@GUID("0C733A93-2A1C-11CE-ADE5-00AA0044773D")
interface IChapteredRowset : IUnknown
{
    HRESULT AddRefChapter(size_t hChapter, uint* pcRefCount);
    HRESULT ReleaseChapter(size_t hChapter, uint* pcRefCount);
}

@GUID("0C733A9D-2A1C-11CE-ADE5-00AA0044773D")
interface IRowsetFind : IUnknown
{
    HRESULT FindNextRow(size_t hChapter, size_t hAccessor, void* pFindValue, uint CompareOp, uint cbBookmark, 
                        const(ubyte)* pBookmark, int lRowsOffset, int cRows, uint* pcRowsObtained, size_t** prghRows);
}

@GUID("0C733A94-2A1C-11CE-ADE5-00AA0044773D")
interface IRowPosition : IUnknown
{
    HRESULT ClearRowPosition();
    HRESULT GetRowPosition(size_t* phChapter, size_t* phRow, uint* pdwPositionFlags);
    HRESULT GetRowset(const(GUID)* riid, IUnknown* ppRowset);
    HRESULT Initialize(IUnknown pRowset);
    HRESULT SetRowPosition(size_t hChapter, size_t hRow, uint dwPositionFlags);
}

@GUID("0997A571-126E-11D0-9F8A-00A0C9A0631E")
interface IRowPositionChange : IUnknown
{
    HRESULT OnRowPositionChange(uint eReason, uint ePhase, BOOL fCantDeny);
}

@GUID("0C733A97-2A1C-11CE-ADE5-00AA0044773D")
interface IViewRowset : IUnknown
{
    HRESULT GetSpecification(const(GUID)* riid, IUnknown* ppObject);
    HRESULT OpenViewRowset(IUnknown pUnkOuter, const(GUID)* riid, IUnknown* ppRowset);
}

@GUID("0C733A98-2A1C-11CE-ADE5-00AA0044773D")
interface IViewChapter : IUnknown
{
    HRESULT GetSpecification(const(GUID)* riid, IUnknown* ppRowset);
    HRESULT OpenViewChapter(size_t hSource, size_t* phViewChapter);
}

@GUID("0C733A9A-2A1C-11CE-ADE5-00AA0044773D")
interface IViewSort : IUnknown
{
    HRESULT GetSortOrder(uint* pcValues, uint** prgColumns, uint** prgOrders);
    HRESULT SetSortOrder(uint cValues, const(uint)* rgColumns, const(uint)* rgOrders);
}

@GUID("0C733A9B-2A1C-11CE-ADE5-00AA0044773D")
interface IViewFilter : IUnknown
{
    HRESULT GetFilter(size_t hAccessor, uint* pcRows, uint** pCompareOps, void* pCriteriaData);
    HRESULT GetFilterBindings(uint* pcBindings, DBBINDING** prgBindings);
    HRESULT SetFilter(size_t hAccessor, uint cRows, uint* CompareOps, void* pCriteriaData);
}

@GUID("0C733A99-2A1C-11CE-ADE5-00AA0044773D")
interface IRowsetView : IUnknown
{
    HRESULT CreateView(IUnknown pUnkOuter, const(GUID)* riid, IUnknown* ppView);
    HRESULT GetView(size_t hChapter, const(GUID)* riid, size_t* phChapterSource, IUnknown* ppView);
}

@GUID("0C733A05-2A1C-11CE-ADE5-00AA0044773D")
interface IRowsetChange : IUnknown
{
    HRESULT DeleteRows(size_t hReserved, uint cRows, const(size_t)* rghRows, uint* rgRowStatus);
    HRESULT SetData(size_t hRow, size_t hAccessor, void* pData);
    HRESULT InsertRow(size_t hReserved, size_t hAccessor, void* pData, size_t* phRow);
}

@GUID("0C733A6D-2A1C-11CE-ADE5-00AA0044773D")
interface IRowsetUpdate : IRowsetChange
{
    HRESULT GetOriginalData(size_t hRow, size_t hAccessor, void* pData);
    HRESULT GetPendingRows(size_t hReserved, uint dwRowStatus, uint* pcPendingRows, size_t** prgPendingRows, 
                           uint** prgPendingStatus);
    HRESULT GetRowStatus(size_t hReserved, uint cRows, const(size_t)* rghRows, uint* rgPendingStatus);
    HRESULT Undo(size_t hReserved, uint cRows, const(size_t)* rghRows, uint* pcRowsUndone, size_t** prgRowsUndone, 
                 uint** prgRowStatus);
    HRESULT Update(size_t hReserved, uint cRows, const(size_t)* rghRows, uint* pcRows, size_t** prgRows, 
                   uint** prgRowStatus);
}

@GUID("0C733A09-2A1C-11CE-ADE5-00AA0044773D")
interface IRowsetIdentity : IUnknown
{
    HRESULT IsSameRow(size_t hThisRow, size_t hThatRow);
}

@GUID("0C733A83-2A1C-11CE-ADE5-00AA0044773D")
interface IRowsetNotify : IUnknown
{
    HRESULT OnFieldChange(IRowset pRowset, size_t hRow, uint cColumns, uint* rgColumns, uint eReason, uint ePhase, 
                          BOOL fCantDeny);
    HRESULT OnRowChange(IRowset pRowset, uint cRows, const(size_t)* rghRows, uint eReason, uint ePhase, 
                        BOOL fCantDeny);
    HRESULT OnRowsetChange(IRowset pRowset, uint eReason, uint ePhase, BOOL fCantDeny);
}

@GUID("0C733A82-2A1C-11CE-ADE5-00AA0044773D")
interface IRowsetIndex : IUnknown
{
    HRESULT GetIndexInfo(uint* pcKeyColumns, DBINDEXCOLUMNDESC** prgIndexColumnDesc, uint* pcIndexPropertySets, 
                         DBPROPSET** prgIndexPropertySets);
    HRESULT Seek(size_t hAccessor, uint cKeyValues, void* pData, uint dwSeekOptions);
    HRESULT SetRange(size_t hAccessor, uint cStartKeyColumns, void* pStartData, uint cEndKeyColumns, 
                     void* pEndData, uint dwRangeOptions);
}

@GUID("0C733A63-2A1C-11CE-ADE5-00AA0044773D")
interface ICommand : IUnknown
{
    HRESULT Cancel();
    HRESULT Execute(IUnknown pUnkOuter, const(GUID)* riid, DBPARAMS* pParams, int* pcRowsAffected, 
                    IUnknown* ppRowset);
    HRESULT GetDBSession(const(GUID)* riid, IUnknown* ppSession);
}

@GUID("0C733A90-2A1C-11CE-ADE5-00AA0044773D")
interface IMultipleResults : IUnknown
{
    HRESULT GetResult(IUnknown pUnkOuter, int lResultFlag, const(GUID)* riid, int* pcRowsAffected, 
                      IUnknown* ppRowset);
}

@GUID("0C733A88-2A1C-11CE-ADE5-00AA0044773D")
interface IConvertType : IUnknown
{
    HRESULT CanConvert(ushort wFromType, ushort wToType, uint dwConvertFlags);
}

@GUID("0C733A26-2A1C-11CE-ADE5-00AA0044773D")
interface ICommandPrepare : IUnknown
{
    HRESULT Prepare(uint cExpectedRuns);
    HRESULT Unprepare();
}

@GUID("0C733A79-2A1C-11CE-ADE5-00AA0044773D")
interface ICommandProperties : IUnknown
{
    HRESULT GetProperties(const(uint) cPropertyIDSets, const(DBPROPIDSET)* rgPropertyIDSets, uint* pcPropertySets, 
                          DBPROPSET** prgPropertySets);
    HRESULT SetProperties(uint cPropertySets, DBPROPSET* rgPropertySets);
}

@GUID("0C733A27-2A1C-11CE-ADE5-00AA0044773D")
interface ICommandText : ICommand
{
    HRESULT GetCommandText(GUID* pguidDialect, PWSTR* ppwszCommand);
    HRESULT SetCommandText(const(GUID)* rguidDialect, const(PWSTR) pwszCommand);
}

@GUID("0C733A64-2A1C-11CE-ADE5-00AA0044773D")
interface ICommandWithParameters : IUnknown
{
    HRESULT GetParameterInfo(uint* pcParams, DBPARAMINFO** prgParamInfo, ushort** ppNamesBuffer);
    HRESULT MapParameterNames(uint cParamNames, PWSTR** rgParamNames, int* rgParamOrdinals);
    HRESULT SetParameterInfo(uint cParams, const(uint)* rgParamOrdinals, const(DBPARAMBINDINFO)* rgParamBindInfo);
}

@GUID("0C733A10-2A1C-11CE-ADE5-00AA0044773D")
interface IColumnsRowset : IUnknown
{
    HRESULT GetAvailableColumns(uint* pcOptColumns, DBID** prgOptColumns);
    HRESULT GetColumnsRowset(IUnknown pUnkOuter, uint cOptColumns, const(DBID)* rgOptColumns, const(GUID)* riid, 
                             uint cPropertySets, DBPROPSET* rgPropertySets, IUnknown* ppColRowset);
}

@GUID("0C733A11-2A1C-11CE-ADE5-00AA0044773D")
interface IColumnsInfo : IUnknown
{
    HRESULT GetColumnInfo(uint* pcColumns, DBCOLUMNINFO** prgInfo, ushort** ppStringsBuffer);
    HRESULT MapColumnIDs(uint cColumnIDs, const(DBID)* rgColumnIDs, uint* rgColumns);
}

@GUID("0C733A1D-2A1C-11CE-ADE5-00AA0044773D")
interface IDBCreateCommand : IUnknown
{
    HRESULT CreateCommand(IUnknown pUnkOuter, const(GUID)* riid, IUnknown* ppCommand);
}

@GUID("0C733A5D-2A1C-11CE-ADE5-00AA0044773D")
interface IDBCreateSession : IUnknown
{
    HRESULT CreateSession(IUnknown pUnkOuter, const(GUID)* riid, IUnknown* ppDBSession);
}

@GUID("0C733A1E-2A1C-11CE-ADE5-00AA0044773D")
interface ISourcesRowset : IUnknown
{
    HRESULT GetSourcesRowset(IUnknown pUnkOuter, const(GUID)* riid, uint cPropertySets, DBPROPSET* rgProperties, 
                             IUnknown* ppSourcesRowset);
}

@GUID("0C733A8A-2A1C-11CE-ADE5-00AA0044773D")
interface IDBProperties : IUnknown
{
    HRESULT GetProperties(uint cPropertyIDSets, const(DBPROPIDSET)* rgPropertyIDSets, uint* pcPropertySets, 
                          DBPROPSET** prgPropertySets);
    HRESULT GetPropertyInfo(uint cPropertyIDSets, const(DBPROPIDSET)* rgPropertyIDSets, uint* pcPropertyInfoSets, 
                            DBPROPINFOSET** prgPropertyInfoSets, ushort** ppDescBuffer);
    HRESULT SetProperties(uint cPropertySets, DBPROPSET* rgPropertySets);
}

@GUID("0C733A8B-2A1C-11CE-ADE5-00AA0044773D")
interface IDBInitialize : IUnknown
{
    HRESULT Initialize();
    HRESULT Uninitialize();
}

@GUID("0C733A89-2A1C-11CE-ADE5-00AA0044773D")
interface IDBInfo : IUnknown
{
    HRESULT GetKeywords(PWSTR* ppwszKeywords);
    HRESULT GetLiteralInfo(uint cLiterals, const(uint)* rgLiterals, uint* pcLiteralInfo, 
                           DBLITERALINFO** prgLiteralInfo, ushort** ppCharBuffer);
}

@GUID("0C733A7A-2A1C-11CE-ADE5-00AA0044773D")
interface IDBDataSourceAdmin : IUnknown
{
    HRESULT CreateDataSource(uint cPropertySets, DBPROPSET* rgPropertySets, IUnknown pUnkOuter, const(GUID)* riid, 
                             IUnknown* ppDBSession);
    HRESULT DestroyDataSource();
    HRESULT GetCreationProperties(uint cPropertyIDSets, const(DBPROPIDSET)* rgPropertyIDSets, 
                                  uint* pcPropertyInfoSets, DBPROPINFOSET** prgPropertyInfoSets, 
                                  ushort** ppDescBuffer);
    HRESULT ModifyDataSource(uint cPropertySets, DBPROPSET* rgPropertySets);
}

@GUID("0C733A96-2A1C-11CE-ADE5-00AA0044773D")
interface IDBAsynchNotify : IUnknown
{
    HRESULT OnLowResource(uint dwReserved);
    HRESULT OnProgress(size_t hChapter, uint eOperation, uint ulProgress, uint ulProgressMax, uint eAsynchPhase, 
                       PWSTR pwszStatusText);
    HRESULT OnStop(size_t hChapter, uint eOperation, HRESULT hrStatus, PWSTR pwszStatusText);
}

@GUID("0C733A95-2A1C-11CE-ADE5-00AA0044773D")
interface IDBAsynchStatus : IUnknown
{
    HRESULT Abort(size_t hChapter, uint eOperation);
    HRESULT GetStatus(size_t hChapter, uint eOperation, uint* pulProgress, uint* pulProgressMax, 
                      uint* peAsynchPhase, PWSTR* ppwszStatusText);
}

@GUID("0C733A85-2A1C-11CE-ADE5-00AA0044773D")
interface ISessionProperties : IUnknown
{
    HRESULT GetProperties(uint cPropertyIDSets, const(DBPROPIDSET)* rgPropertyIDSets, uint* pcPropertySets, 
                          DBPROPSET** prgPropertySets);
    HRESULT SetProperties(uint cPropertySets, DBPROPSET* rgPropertySets);
}

@GUID("0C733A68-2A1C-11CE-ADE5-00AA0044773D")
interface IIndexDefinition : IUnknown
{
    HRESULT CreateIndex(DBID* pTableID, DBID* pIndexID, uint cIndexColumnDescs, 
                        const(DBINDEXCOLUMNDESC)* rgIndexColumnDescs, uint cPropertySets, DBPROPSET* rgPropertySets, 
                        DBID** ppIndexID);
    HRESULT DropIndex(DBID* pTableID, DBID* pIndexID);
}

@GUID("0C733A86-2A1C-11CE-ADE5-00AA0044773D")
interface ITableDefinition : IUnknown
{
    HRESULT CreateTable(IUnknown pUnkOuter, DBID* pTableID, uint cColumnDescs, const(DBCOLUMNDESC)* rgColumnDescs, 
                        const(GUID)* riid, uint cPropertySets, DBPROPSET* rgPropertySets, DBID** ppTableID, 
                        IUnknown* ppRowset);
    HRESULT DropTable(DBID* pTableID);
    HRESULT AddColumn(DBID* pTableID, DBCOLUMNDESC* pColumnDesc, DBID** ppColumnID);
    HRESULT DropColumn(DBID* pTableID, DBID* pColumnID);
}

@GUID("0C733A69-2A1C-11CE-ADE5-00AA0044773D")
interface IOpenRowset : IUnknown
{
    HRESULT OpenRowset(IUnknown pUnkOuter, DBID* pTableID, DBID* pIndexID, const(GUID)* riid, uint cPropertySets, 
                       DBPROPSET* rgPropertySets, IUnknown* ppRowset);
}

@GUID("0C733A7B-2A1C-11CE-ADE5-00AA0044773D")
interface IDBSchemaRowset : IUnknown
{
    HRESULT GetRowset(IUnknown pUnkOuter, const(GUID)* rguidSchema, uint cRestrictions, 
                      const(VARIANT)* rgRestrictions, const(GUID)* riid, uint cPropertySets, 
                      DBPROPSET* rgPropertySets, IUnknown* ppRowset);
    HRESULT GetSchemas(uint* pcSchemas, GUID** prgSchemas, uint** prgRestrictionSupport);
}

@GUID("A07CCCD1-8148-11D0-87BB-00C04FC33942")
interface IMDDataset : IUnknown
{
    HRESULT FreeAxisInfo(uint cAxes, MDAXISINFO* rgAxisInfo);
    HRESULT GetAxisInfo(uint* pcAxes, MDAXISINFO** prgAxisInfo);
    HRESULT GetAxisRowset(IUnknown pUnkOuter, uint iAxis, const(GUID)* riid, uint cPropertySets, 
                          DBPROPSET* rgPropertySets, IUnknown* ppRowset);
    HRESULT GetCellData(size_t hAccessor, uint ulStartCell, uint ulEndCell, void* pData);
    HRESULT GetSpecification(const(GUID)* riid, IUnknown* ppSpecification);
}

@GUID("A07CCCD2-8148-11D0-87BB-00C04FC33942")
interface IMDFind : IUnknown
{
    HRESULT FindCell(uint ulStartingOrdinal, uint cMembers, PWSTR* rgpwszMember, uint* pulCellOrdinal);
    HRESULT FindTuple(uint ulAxisIdentifier, uint ulStartingOrdinal, uint cMembers, PWSTR* rgpwszMember, 
                      uint* pulTupleOrdinal);
}

@GUID("0C733AA0-2A1C-11CE-ADE5-00AA0044773D")
interface IMDRangeRowset : IUnknown
{
    HRESULT GetRangeRowset(IUnknown pUnkOuter, uint ulStartCell, uint ulEndCell, const(GUID)* riid, 
                           uint cPropertySets, DBPROPSET* rgPropertySets, IUnknown* ppRowset);
}

@GUID("0C733AA5-2A1C-11CE-ADE5-00AA0044773D")
interface IAlterTable : IUnknown
{
    HRESULT AlterColumn(DBID* pTableId, DBID* pColumnId, uint dwColumnDescFlags, DBCOLUMNDESC* pColumnDesc);
    HRESULT AlterTable(DBID* pTableId, DBID* pNewTableId, uint cPropertySets, DBPROPSET* rgPropertySets);
}

@GUID("0C733AA6-2A1C-11CE-ADE5-00AA0044773D")
interface IAlterIndex : IUnknown
{
    HRESULT AlterIndex(DBID* pTableId, DBID* pIndexId, DBID* pNewIndexId, uint cPropertySets, 
                       DBPROPSET* rgPropertySets);
}

@GUID("0C733AA8-2A1C-11CE-ADE5-00AA0044773D")
interface IRowsetChapterMember : IUnknown
{
    HRESULT IsRowInChapter(size_t hChapter, size_t hRow);
}

@GUID("0C733AA7-2A1C-11CE-ADE5-00AA0044773D")
interface ICommandPersist : IUnknown
{
    HRESULT DeleteCommand(DBID* pCommandID);
    HRESULT GetCurrentCommand(DBID** ppCommandID);
    HRESULT LoadCommand(DBID* pCommandID, uint dwFlags);
    HRESULT SaveCommand(DBID* pCommandID, uint dwFlags);
}

@GUID("0C733AA9-2A1C-11CE-ADE5-00AA0044773D")
interface IRowsetRefresh : IUnknown
{
    HRESULT RefreshVisibleData(size_t hChapter, uint cRows, const(size_t)* rghRows, BOOL fOverWrite, 
                               uint* pcRowsRefreshed, size_t** prghRowsRefreshed, uint** prgRowStatus);
    HRESULT GetLastVisibleData(size_t hRow, size_t hAccessor, void* pData);
}

@GUID("0C733AAA-2A1C-11CE-ADE5-00AA0044773D")
interface IParentRowset : IUnknown
{
    HRESULT GetChildRowset(IUnknown pUnkOuter, uint iOrdinal, const(GUID)* riid, IUnknown* ppRowset);
}

@GUID("0C733A67-2A1C-11CE-ADE5-00AA0044773D")
interface IErrorRecords : IUnknown
{
    HRESULT AddErrorRecord(ERRORINFO* pErrorInfo, uint dwLookupID, DISPPARAMS* pdispparams, 
                           IUnknown punkCustomError, uint dwDynamicErrorID);
    HRESULT GetBasicErrorInfo(uint ulRecordNum, ERRORINFO* pErrorInfo);
    HRESULT GetCustomErrorObject(uint ulRecordNum, const(GUID)* riid, IUnknown* ppObject);
    HRESULT GetErrorInfo(uint ulRecordNum, uint lcid, IErrorInfo* ppErrorInfo);
    HRESULT GetErrorParameters(uint ulRecordNum, DISPPARAMS* pdispparams);
    HRESULT GetRecordCount(uint* pcRecords);
}

@GUID("0C733A66-2A1C-11CE-ADE5-00AA0044773D")
interface IErrorLookup : IUnknown
{
    HRESULT GetErrorDescription(HRESULT hrError, uint dwLookupID, DISPPARAMS* pdispparams, uint lcid, 
                                BSTR* pbstrSource, BSTR* pbstrDescription);
    HRESULT GetHelpInfo(HRESULT hrError, uint dwLookupID, uint lcid, BSTR* pbstrHelpFile, uint* pdwHelpContext);
    HRESULT ReleaseErrors(const(uint) dwDynamicErrorID);
}

@GUID("0C733A74-2A1C-11CE-ADE5-00AA0044773D")
interface ISQLErrorInfo : IUnknown
{
    HRESULT GetSQLInfo(BSTR* pbstrSQLState, int* plNativeError);
}

@GUID("0C733A75-2A1C-11CE-ADE5-00AA0044773D")
interface IGetDataSource : IUnknown
{
    HRESULT GetDataSource(const(GUID)* riid, IUnknown* ppDataSource);
}

@GUID("0C733A5F-2A1C-11CE-ADE5-00AA0044773D")
interface ITransactionLocal : ITransaction
{
    HRESULT GetOptionsObject(ITransactionOptions* ppOptions);
    HRESULT StartTransaction(int isoLevel, uint isoFlags, ITransactionOptions pOtherOptions, 
                             uint* pulTransactionLevel);
}

@GUID("0C733A5E-2A1C-11CE-ADE5-00AA0044773D")
interface ITransactionJoin : IUnknown
{
    HRESULT GetOptionsObject(ITransactionOptions* ppOptions);
    HRESULT JoinTransaction(IUnknown punkTransactionCoord, int isoLevel, uint isoFlags, 
                            ITransactionOptions pOtherOptions);
}

@GUID("0C733A60-2A1C-11CE-ADE5-00AA0044773D")
interface ITransactionObject : IUnknown
{
    HRESULT GetTransactionObject(uint ulTransactionLevel, ITransaction* ppTransactionObject);
}

@GUID("0C733AA1-2A1C-11CE-ADE5-00AA0044773D")
interface ITrusteeAdmin : IUnknown
{
    HRESULT CompareTrustees(TRUSTEE_W* pTrustee1, TRUSTEE_W* pTrustee2);
    HRESULT CreateTrustee(TRUSTEE_W* pTrustee, uint cPropertySets, DBPROPSET* rgPropertySets);
    HRESULT DeleteTrustee(TRUSTEE_W* pTrustee);
    HRESULT SetTrusteeProperties(TRUSTEE_W* pTrustee, uint cPropertySets, DBPROPSET* rgPropertySets);
    HRESULT GetTrusteeProperties(TRUSTEE_W* pTrustee, const(uint) cPropertyIDSets, 
                                 const(DBPROPIDSET)* rgPropertyIDSets, uint* pcPropertySets, 
                                 DBPROPSET** prgPropertySets);
}

@GUID("0C733AA2-2A1C-11CE-ADE5-00AA0044773D")
interface ITrusteeGroupAdmin : IUnknown
{
    HRESULT AddMember(TRUSTEE_W* pMembershipTrustee, TRUSTEE_W* pMemberTrustee);
    HRESULT DeleteMember(TRUSTEE_W* pMembershipTrustee, TRUSTEE_W* pMemberTrustee);
    HRESULT IsMember(TRUSTEE_W* pMembershipTrustee, TRUSTEE_W* pMemberTrustee, BOOL* pfStatus);
    HRESULT GetMembers(TRUSTEE_W* pMembershipTrustee, uint* pcMembers, TRUSTEE_W** prgMembers);
    HRESULT GetMemberships(TRUSTEE_W* pTrustee, uint* pcMemberships, TRUSTEE_W** prgMemberships);
}

@GUID("0C733AA3-2A1C-11CE-ADE5-00AA0044773D")
interface IObjectAccessControl : IUnknown
{
    HRESULT GetObjectAccessRights(SEC_OBJECT* pObject, uint* pcAccessEntries, EXPLICIT_ACCESS_W** prgAccessEntries);
    HRESULT GetObjectOwner(SEC_OBJECT* pObject, TRUSTEE_W** ppOwner);
    HRESULT IsObjectAccessAllowed(SEC_OBJECT* pObject, EXPLICIT_ACCESS_W* pAccessEntry, BOOL* pfResult);
    HRESULT SetObjectAccessRights(SEC_OBJECT* pObject, uint cAccessEntries, EXPLICIT_ACCESS_W* prgAccessEntries);
    HRESULT SetObjectOwner(SEC_OBJECT* pObject, TRUSTEE_W* pOwner);
}

@GUID("0C733AA4-2A1C-11CE-ADE5-00AA0044773D")
interface ISecurityInfo : IUnknown
{
    HRESULT GetCurrentTrustee(TRUSTEE_W** ppTrustee);
    HRESULT GetObjectTypes(uint* cObjectTypes, GUID** rgObjectTypes);
    HRESULT GetPermissions(GUID ObjectType, uint* pPermissions);
}

@GUID("0C733ABC-2A1C-11CE-ADE5-00AA0044773D")
interface ITableCreation : ITableDefinition
{
    HRESULT GetTableDefinition(DBID* pTableID, uint* pcColumnDescs, DBCOLUMNDESC** prgColumnDescs, 
                               uint* pcPropertySets, DBPROPSET** prgPropertySets, uint* pcConstraintDescs, 
                               DBCONSTRAINTDESC** prgConstraintDescs, ushort** ppwszStringBuffer);
}

@GUID("0C733AAB-2A1C-11CE-ADE5-00AA0044773D")
interface ITableDefinitionWithConstraints : ITableCreation
{
    HRESULT AddConstraint(DBID* pTableID, DBCONSTRAINTDESC* pConstraintDesc);
    HRESULT CreateTableWithConstraints(IUnknown pUnkOuter, DBID* pTableID, uint cColumnDescs, 
                                       DBCOLUMNDESC* rgColumnDescs, uint cConstraintDescs, 
                                       DBCONSTRAINTDESC* rgConstraintDescs, const(GUID)* riid, uint cPropertySets, 
                                       DBPROPSET* rgPropertySets, DBID** ppTableID, IUnknown* ppRowset);
    HRESULT DropConstraint(DBID* pTableID, DBID* pConstraintID);
}

@GUID("0C733AB4-2A1C-11CE-ADE5-00AA0044773D")
interface IRow : IUnknown
{
    HRESULT GetColumns(uint cColumns, DBCOLUMNACCESS* rgColumns);
    HRESULT GetSourceRowset(const(GUID)* riid, IUnknown* ppRowset, size_t* phRow);
    HRESULT Open(IUnknown pUnkOuter, DBID* pColumnID, const(GUID)* rguidColumnType, uint dwBindFlags, 
                 const(GUID)* riid, IUnknown* ppUnk);
}

@GUID("0C733AB5-2A1C-11CE-ADE5-00AA0044773D")
interface IRowChange : IUnknown
{
    HRESULT SetColumns(uint cColumns, DBCOLUMNACCESS* rgColumns);
}

@GUID("0C733AAE-2A1C-11CE-ADE5-00AA0044773D")
interface IRowSchemaChange : IRowChange
{
    HRESULT DeleteColumns(uint cColumns, const(DBID)* rgColumnIDs, uint* rgdwStatus);
    HRESULT AddColumns(uint cColumns, const(DBCOLUMNINFO)* rgNewColumnInfo, DBCOLUMNACCESS* rgColumns);
}

@GUID("0C733AAF-2A1C-11CE-ADE5-00AA0044773D")
interface IGetRow : IUnknown
{
    HRESULT GetRowFromHROW(IUnknown pUnkOuter, size_t hRow, const(GUID)* riid, IUnknown* ppUnk);
    HRESULT GetURLFromHROW(size_t hRow, PWSTR* ppwszURL);
}

@GUID("0C733AB1-2A1C-11CE-ADE5-00AA0044773D")
interface IBindResource : IUnknown
{
    HRESULT Bind(IUnknown pUnkOuter, const(PWSTR) pwszURL, uint dwBindURLFlags, const(GUID)* rguid, 
                 const(GUID)* riid, IAuthenticate pAuthenticate, DBIMPLICITSESSION* pImplSession, 
                 uint* pdwBindStatus, IUnknown* ppUnk);
}

@GUID("0C733AB0-2A1C-11CE-ADE5-00AA0044773D")
interface IScopedOperations : IBindResource
{
    HRESULT Copy(uint cRows, PWSTR** rgpwszSourceURLs, PWSTR** rgpwszDestURLs, uint dwCopyFlags, 
                 IAuthenticate pAuthenticate, uint* rgdwStatus, PWSTR** rgpwszNewURLs, ushort** ppStringsBuffer);
    HRESULT Move(uint cRows, PWSTR** rgpwszSourceURLs, PWSTR** rgpwszDestURLs, uint dwMoveFlags, 
                 IAuthenticate pAuthenticate, uint* rgdwStatus, PWSTR** rgpwszNewURLs, ushort** ppStringsBuffer);
    HRESULT Delete(uint cRows, PWSTR** rgpwszURLs, uint dwDeleteFlags, uint* rgdwStatus);
    HRESULT OpenRowset(IUnknown pUnkOuter, DBID* pTableID, DBID* pIndexID, const(GUID)* riid, uint cPropertySets, 
                       DBPROPSET* rgPropertySets, IUnknown* ppRowset);
}

@GUID("0C733AB2-2A1C-11CE-ADE5-00AA0044773D")
interface ICreateRow : IUnknown
{
    HRESULT CreateRow(IUnknown pUnkOuter, const(PWSTR) pwszURL, uint dwBindURLFlags, const(GUID)* rguid, 
                      const(GUID)* riid, IAuthenticate pAuthenticate, DBIMPLICITSESSION* pImplSession, 
                      uint* pdwBindStatus, PWSTR* ppwszNewURL, IUnknown* ppUnk);
}

@GUID("0C733AB3-2A1C-11CE-ADE5-00AA0044773D")
interface IDBBinderProperties : IDBProperties
{
    HRESULT Reset();
}

@GUID("0C733AB8-2A1C-11CE-ADE5-00AA0044773D")
interface IColumnsInfo2 : IColumnsInfo
{
    HRESULT GetRestrictedColumnInfo(uint cColumnIDMasks, const(DBID)* rgColumnIDMasks, uint dwFlags, 
                                    uint* pcColumns, DBID** prgColumnIDs, DBCOLUMNINFO** prgColumnInfo, 
                                    ushort** ppStringsBuffer);
}

@GUID("0C733AB9-2A1C-11CE-ADE5-00AA0044773D")
interface IRegisterProvider : IUnknown
{
    HRESULT GetURLMapping(const(PWSTR) pwszURL, uint dwReserved, GUID* pclsidProvider);
    HRESULT SetURLMapping(const(PWSTR) pwszURL, uint dwReserved, const(GUID)* rclsidProvider);
    HRESULT UnregisterProvider(const(PWSTR) pwszURL, uint dwReserved, const(GUID)* rclsidProvider);
}

@GUID("0C733ABA-2A1C-11CE-ADE5-00AA0044773D")
interface IGetSession : IUnknown
{
    HRESULT GetSession(const(GUID)* riid, IUnknown* ppSession);
}

@GUID("0C733ABB-2A1C-11CE-ADE5-00AA0044773D")
interface IGetSourceRow : IUnknown
{
    HRESULT GetSourceRow(const(GUID)* riid, IUnknown* ppRow);
}

@GUID("0C733ABD-2A1C-11CE-ADE5-00AA0044773D")
interface IRowsetCurrentIndex : IRowsetIndex
{
    HRESULT GetIndex(DBID** ppIndexID);
    HRESULT SetIndex(DBID* pIndexID);
}

@GUID("0C733ABF-2A1C-11CE-ADE5-00AA0044773D")
interface ICommandStream : IUnknown
{
    HRESULT GetCommandStream(GUID* piid, GUID* pguidDialect, IUnknown* ppCommandStream);
    HRESULT SetCommandStream(const(GUID)* riid, const(GUID)* rguidDialect, IUnknown pCommandStream);
}

@GUID("0C733AC2-2A1C-11CE-ADE5-00AA0044773D")
interface IRowsetBookmark : IUnknown
{
    HRESULT PositionOnBookmark(size_t hChapter, uint cbBookmark, const(ubyte)* pBookmark);
}

///Provides methods to parse an input string into an IQuerySolution object.
@GUID("2EBDEE67-3505-43F8-9946-EA44ABC8E5B0")
interface IQueryParser : IUnknown
{
    ///Parses an input string that contains Structured Query keywords and/or contents to produce an IQuerySolution
    ///object.
    ///Params:
    ///    pszInputString = Type: <b>LPCWSTR</b> A pointer to the Unicode input string to be parsed.
    ///    pCustomProperties = Type: <b>IEnumUnknown*</b> An enumeration of IRichChunk objects, one for each custom property the application
    ///                        has recognized. This parameter can be <b>NULL</b>, which is equivalent to an empty enumeration.
    ///    ppSolution = Type: <b>IQuerySolution**</b> Receives an IQuerySolution object. The caller must release it by calling its
    ///                 IUnknown::Release method.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Parse(const(PWSTR) pszInputString, IEnumUnknown pCustomProperties, IQuerySolution* ppSolution);
    ///Sets a single option, such as a specified wordbreaker, for parsing an input string.
    ///Params:
    ///    option = Type: <b>STRUCTURED_QUERY_SINGLE_OPTION</b> Identifies the type of option to be set.
    ///    pOptionValue = Type: <b>PROPVARIANT*</b> Pointer to a PROPVARIANT specifying the value to set for the <i>option</i>
    ///                   parameter. This value is interpreted differently depending on the value of the <i>option</i> parameter.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetOption(STRUCTURED_QUERY_SINGLE_OPTION option, const(PROPVARIANT)* pOptionValue);
    ///Retrieves a specified simple option value for this query parser.
    ///Params:
    ///    option = Type: <b>STRUCTURED_QUERY_SINGLE_OPTION</b> The STRUCTURED_QUERY_SINGLE_OPTION enumerated type that specifies
    ///             the option to be retrieved.
    ///    pOptionValue = Type: <b>PROPVARIANT*</b> Receives a pointer to the specified option value. For more information, see
    ///                   STRUCTURED_QUERY_SINGLE_OPTION.
    HRESULT GetOption(STRUCTURED_QUERY_SINGLE_OPTION option, PROPVARIANT* pOptionValue);
    ///Sets a complex option, such as a specified condition generator, to use when parsing an input string.
    ///Params:
    ///    option = Type: <b>STRUCTURED_QUERY_MULTIOPTION</b> The complex option to be set.
    ///    pszOptionKey = Type: <b>LPCWSTR</b> A Unicode string that is interpreted differently for each value of the <i>option</i>
    ///                   parameter. For more information, see STRUCTURED_QUERY_MULTIOPTION.
    ///    pOptionValue = Type: <b>PROPVARIANT*</b> Pointer to a PROPVARIANT that is interpreted differently for each value of the
    ///                   <i>option</i> parameter. For more information, see STRUCTURED_QUERY_MULTIOPTION.
    HRESULT SetMultiOption(STRUCTURED_QUERY_MULTIOPTION option, const(PWSTR) pszOptionKey, 
                           const(PROPVARIANT)* pOptionValue);
    ///Retrieves a schema provider for browsing the currently loaded schema.
    ///Params:
    ///    ppSchemaProvider = Type: <b>ISchemaProvider**</b> Receives the address of a pointer to an ISchemaProvider object. The calling
    ///                       application must release it by invoking its IUnknown::Release method.
    HRESULT GetSchemaProvider(ISchemaProvider* ppSchemaProvider);
    ///Restates a condition as a structured query string. If the condition was the result of parsing an original query
    ///string, the keywords of that query string are used to a great extent. If not, default keywords are used.
    ///Params:
    ///    pCondition = Type: <b>ICondition*</b> The condition to be restated.
    ///    fUseEnglish = Type: <b>BOOL</b> Reserved. Must be <b>FALSE</b>.
    ///    ppszQueryString = Type: <b>LPWSTR*</b> Receives the restated query string. The caller must free the string by calling
    ///                      CoTaskMemFree.
    HRESULT RestateToString(ICondition pCondition, BOOL fUseEnglish, PWSTR* ppszQueryString);
    ///Parses a condition for a specified property.
    ///Params:
    ///    pszPropertyName = Type: <b>LPCWSTR</b> Property name.
    ///    pszInputString = Type: <b>LPCWSTR</b> Query string to be parsed, relative to that property.
    ///    ppSolution = Type: <b>IQuerySolution**</b> Receives an IQuerySolution object. The calling application must release it by
    ///                 calling its IUnknown::Release method.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ParsePropertyValue(const(PWSTR) pszPropertyName, const(PWSTR) pszInputString, 
                               IQuerySolution* ppSolution);
    ///Restates a specified property for a condition as a query string.
    ///Params:
    ///    pCondition = Type: <b>ICondition*</b> A condition to be restated as a query string.
    ///    fUseEnglish = Type: <b>BOOL</b> Reserved. Must be <b>FALSE</b>.
    ///    ppszPropertyName = Type: <b>LPWSTR*</b> Receives a pointer to the property name as a Unicode string. The calling application
    ///                       must free the string by calling CoTaskMemFree.
    ///    ppszQueryString = Type: <b>LPWSTR*</b> Receives a pointer to a query string for that property. The calling application must
    ///                      free the string by calling CoTaskMemFree.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT RestatePropertyValueToString(ICondition pCondition, BOOL fUseEnglish, PWSTR* ppszPropertyName, 
                                         PWSTR* ppszQueryString);
}

///Provides methods for creating or resolving a condition tree that was obtained by parsing a query string.
@GUID("A5EFE073-B16F-474F-9F3E-9F8B497A3E08")
interface IConditionFactory : IUnknown
{
    ///Creates a condition node that is a logical negation (NOT) of another condition (a subnode of this node).
    ///Params:
    ///    pcSub = Type: <b>ICondition*</b> Pointer to the ICondition subnode to be negated.
    ///    fSimplify = Type: <b>BOOL</b> <b>TRUE</b> to logically simplify the result if possible; <b>FALSE</b> otherwise. In a
    ///                query builder scenario, <i>fSimplify</i> should typically be set to VARIANT_FALSE.
    ///    ppcResult = Type: <b>ICondition**</b> Receives a pointer to the new ICondition node.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT MakeNot(ICondition pcSub, BOOL fSimplify, ICondition* ppcResult);
    ///Creates a condition node that is a logical conjunction (AND) or disjunction (OR) of a collection of
    ///subconditions.
    ///Params:
    ///    ct = Type: <b>CONDITION_TYPE</b> The CONDITION_TYPE of the condition node. The <b>CONDITION_TYPE</b> must be
    ///         either <b>CT_AND_CONDITION</b> or <b>CT_OR_CONDITION</b>.
    ///    peuSubs = Type: <b>IEnumUnknown*</b> A pointer to an enumeration of ICondition objects, or <b>NULL</b> for an empty
    ///              enumeration.
    ///    fSimplify = Type: <b>BOOL</b> <b>TRUE</b> to logically simplify the result, if possible; then the result will not
    ///                necessarily to be of the specified kind. <b>FALSE</b> if the result should have exactly the prescribed
    ///                structure. An application that plans to execute a query based on the condition tree would typically benefit
    ///                from setting this parameter to <b>TRUE</b>.
    ///    ppcResult = Type: <b>ICondition**</b> Receives the address of a pointer to the new ICondition node.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT MakeAndOr(CONDITION_TYPE ct, IEnumUnknown peuSubs, BOOL fSimplify, ICondition* ppcResult);
    ///Creates a leaf condition node that represents a comparison of property value and constant value.
    ///Params:
    ///    pszPropertyName = Type: <b>LPCWSTR</b> The name of a property to be compared, or <b>NULL</b> for an unspecified property. The
    ///                      locale name of the leaf node is LOCALE_NAME_USER_DEFAULT.
    ///    cop = Type: <b>CONDITION_OPERATION</b> A CONDITION_OPERATION enumeration.
    ///    pszValueType = Type: <b>LPCWSTR</b> The name of a semantic type of the value, or <b>NULL</b> for a plain string.
    ///    ppropvar = Type: <b>PROPVARIANT const*</b> The constant value against which the property value should be compared.
    ///    pPropertyNameTerm = Type: <b>IRichChunk*</b> A pointer to an IRichChunk that identifies the range of the input string that
    ///                        repesents the property. It can be <b>NULL</b>.
    ///    pOperationTerm = Type: <b>IRichChunk*</b> A pointer to an IRichChunk that identifies the range of the input string that
    ///                     repesents the operation. It can be <b>NULL</b>.
    ///    pValueTerm = Type: <b>IRichChunk*</b> A pointer to an IRichChunk that identifies the range of the input string that
    ///                 repesents the value. It can be <b>NULL</b>.
    ///    fExpand = Type: <b>BOOL</b> If <b>TRUE</b> and <i>pszPropertyName</i> identifies a virtual property, the resulting node
    ///              is not a leaf node; instead, it is a disjunction of leaf condition nodes, each of which corresponds to one
    ///              expansion of the virtual property.
    ///    ppcResult = Type: <b>ICondition**</b> Receives a pointer to the new ICondition leaf node.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT MakeLeaf(const(PWSTR) pszPropertyName, CONDITION_OPERATION cop, const(PWSTR) pszValueType, 
                     const(PROPVARIANT)* ppropvar, IRichChunk pPropertyNameTerm, IRichChunk pOperationTerm, 
                     IRichChunk pValueTerm, BOOL fExpand, ICondition* ppcResult);
    ///Performs a variety of transformations on a condition tree, including the following: resolves conditions with
    ///relative date/time expressions to conditions with absolute date/time (as a VT_FILETIME); turns other recognized
    ///named entities into condition trees with actual values; simplifies condition trees; replaces virtual or compound
    ///properties with OR trees of other properties; removes condition trees resulting from queries with property
    ///keywords that had no condition applied.
    ///Params:
    ///    pc = Type: <b>ICondition*</b> A pointer to an ICondition object to be resolved.
    ///    sqro = Type: <b>STRUCTURED_QUERY_RESOLVE_OPTION</b> Specifies zero or more of the STRUCTURED_QUERY_RESOLVE_OPTION
    ///           flags. For <b>Windows 7 and later</b>, the SQRO_ADD_VALUE_TYPE_FOR_PLAIN_VALUES flag is automatically added
    ///           to <i>sqro</i>.
    ///    pstReferenceTime = Type: <b>SYSTEMTIME const*</b> A pointer to a <b>SYSTEMTIME</b> value to use as the reference date and time.
    ///                       A null pointer can be passed if <i>sqro</i> is set to SQRO_DONT_RESOLVE_DATETIME.
    ///    ppcResolved = Type: <b>ICondition**</b> Receives a pointer to the new ICondition in which all time fields have been
    ///                  resolved to have values of type VT_FILETIME. This new condition tree is the resolved version of <i>pc</i>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Resolve(ICondition pc, STRUCTURED_QUERY_RESOLVE_OPTION sqro, const(SYSTEMTIME)* pstReferenceTime, 
                    ICondition* ppcResolved);
}

///Provides methods that retrieve information about the interpretation of a parsed query.
@GUID("D6EBC66B-8921-4193-AFDD-A1789FB7FF57")
interface IQuerySolution : IConditionFactory
{
    ///Retrieves the condition tree and the semantic type of the solution.
    ///Params:
    ///    ppQueryNode = Type: <b>ICondition**</b> Receives a pointer to an ICondition condition tree that is the interpretation of
    ///                  the query string. This parameter can be <b>NULL</b>.
    ///    ppMainType = Type: <b>IEntity**</b> Receives a pointer to an IEntity object that identifies the semantic type of the
    ///                 interpretation. This parameter can be <b>NULL</b>.
    HRESULT GetQuery(ICondition* ppQueryNode, IEntity* ppMainType);
    ///Identifies parts of the input string that the parser did not recognize or did not use when constructing the
    ///IQuerySolution condition tree.
    ///Params:
    ///    riid = Type: <b>REFIID</b> The desired IID of the result, either IID_IEnumUnknown or IID_IEnumVARIANT.
    ///    ppParseErrors = Type: <b>void**</b> Receives a pointer to an enumeration of zero or more IRichChunk objects, each describing
    ///                    one parsing error.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetErrors(const(GUID)* riid, void** ppParseErrors);
    ///Reports the query string, how it was tokenized, and what language code identifier (LCID) and word breaker were
    ///used to parse it.
    ///Params:
    ///    ppszInputString = Type: <b>LPWSTR*</b> Receives the query string. This parameter can be <b>NULL</b>.
    ///    ppTokens = Type: <b>ITokenCollection**</b> Receives a pointer to an ITokenCollection object that describes how the query
    ///               was tokenized. This parameter can be <b>NULL</b>.
    ///    plcid = Type: <b>LCID*</b> Receives a LCID for the word breaker used for this query. This parameter can be
    ///            <b>NULL</b>.
    ///    ppWordBreaker = Type: <b>IUnknown**</b> Receives a pointer to the word breaker used for this query. This parameter can be
    ///                    <b>NULL</b>.
    HRESULT GetLexicalData(PWSTR* ppszInputString, ITokenCollection* ppTokens, uint* plcid, 
                           IUnknown* ppWordBreaker);
}

///Extends the functionality of IConditionFactory. <b>IConditionFactory2</b> provides methods for creating or resolving
///a condition tree that was obtained by parsing a query string.
@GUID("71D222E1-432F-429E-8C13-B6DAFDE5077A")
interface IConditionFactory2 : IConditionFactory
{
    ///Creates a search condition that is either <b>TRUE</b> or <b>FALSE</b>. The returned object supports ICondition
    ///and ICondition2
    ///Params:
    ///    fVal = Type: <b>BOOL</b> The value of the search condition to use. <i>fValue</i> should typically be set to
    ///           VARIANT_FALSE.
    ///    cco = Type: <b>CONDITION_CREATION_OPTIONS</b> The condition creation operation of the leaf condition as the
    ///          CONDITION_CREATION_OPTIONS enumeration.
    ///    riid = Type: <b>REFIID</b> The desired IID of the enumerating interface: either IEnumUnknown, IEnumVARIANT, or (for
    ///           a negation condition) IID_ICondition.
    ///    ppv = Type: <b>void**</b> Receives a pointer to zero or more ICondition and ICondition2 objects.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateTrueFalse(BOOL fVal, CONDITION_CREATION_OPTIONS cco, const(GUID)* riid, void** ppv);
    ///Creates a condition node that is a logical negation (NOT) of another condition (a subnode of this node).
    ///Params:
    ///    pcSub = Type: <b>ICondition*</b> A pointer to the ICondition subnode to be negated. For default options, use the
    ///            <i>CONDITION_CREATION_DEFAULT</i> flag.
    ///    cco = Type: <b>CONDITION_CREATION_OPTIONS</b> The condition creation operation of the leaf condition as the
    ///          CONDITION_CREATION_OPTIONS enumeration.
    ///    riid = Type: <b>REFIID</b> The desired IID of the enumerating interface: either IEnumUnknown, IEnumVARIANT, or (for
    ///           a negation condition) IID_ICondition.
    ///    ppv = Type: <b>void**</b> Receives a pointer to zero or more ICondition and ICondition2 objects.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateNegation(ICondition pcSub, CONDITION_CREATION_OPTIONS cco, const(GUID)* riid, void** ppv);
    ///Creates a leaf condition node that is a conjunction (AND) or a disjunction (OR) of a collection of subconditions.
    ///The returned object supports ICondition and ICondition2.
    ///Params:
    ///    ct = Type: <b>CONDITION_TYPE</b> A CONDITION_TYPE enumeration that must be set to either the
    ///         <i>CT_AND_CONDITION</i> or <i>CT_OR_CONDITION</i> flag.
    ///    poaSubs = Type: <b>IObjectArray*</b> Each element of the <i>poaSubs</i> parameter must implement ICondition. This
    ///              parameter may also be <b>NULL</b>, which is equivalent to being empty.
    ///    cco = Type: <b>CONDITION_CREATION_OPTIONS</b> The condition creation operation of the leaf condition as the
    ///          CONDITION_CREATION_OPTIONS enumeration.
    ///    riid = Type: <b>REFIID</b> The desired IID of the enumerating interface: either IEnumUnknown, IID_IEnumVARIANT, or
    ///           (for a negation condition) IID_ICondition.
    ///    ppv = Type: <b>void**</b> A collection of zero or more ICondition and ICondition2 objects.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateCompoundFromObjectArray(CONDITION_TYPE ct, IObjectArray poaSubs, CONDITION_CREATION_OPTIONS cco, 
                                          const(GUID)* riid, void** ppv);
    ///Creates a leaf condition node that is a conjunction (AND) or a disjunction (OR) from an array of condition nodes.
    ///The returned object supports ICondition and ICondition2.
    ///Params:
    ///    ct = Type: <b>CONDITION_TYPE</b> A CONDITION_TYPE enumeration that must be set to either the
    ///         <i>CT_AND_CONDITION</i> or <i>CT_OR_CONDITION</i> flag.
    ///    ppcondSubs = Type: <b>ICondition**</b> Each element of the <i>ppCondSubs</i> parameter must implement ICondition.
    ///    cSubs = Type: <b>ULONG</b> The leaf subcondition as an unsigned 64-bit integer value.
    ///    cco = Type: <b>CONDITION_CREATION_OPTIONS</b> The condition creation operation of the leaf condition as the
    ///          CONDITION_CREATION_OPTIONS enumeration.
    ///    riid = Type: <b>REFIID</b> The desired IID of the enumerating interface: either IEnumUnknown, IID_IEnumVARIANT, or
    ///           (for a negation condition) IID_ICondition.
    ///    ppv = Type: <b>void**</b> A collection of zero or more ICondition and ICondition2 objects.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateCompoundFromArray(CONDITION_TYPE ct, ICondition* ppcondSubs, uint cSubs, 
                                    CONDITION_CREATION_OPTIONS cco, const(GUID)* riid, void** ppv);
    ///Creates a leaf condition node for a string value that represents a comparison of property value and constant
    ///value. The returned object supports ICondition and ICondition2.
    ///Params:
    ///    propkey = Type: <b>REFPROPERTYKEY</b> The name of the property of the leaf condition as a REFPROPERTYKEY. If the leaf
    ///              has no particular property, use PKEY_Null.
    ///    cop = Type: <b>CONDITION_OPERATION</b> A CONDITION_OPERATION enumeration. If the leaf has no particular operation,
    ///          then use <i>COP_IMPLICIT</i>.
    ///    pszValue = Type: <b>LPCWSTR</b> The value to be compared, or <b>NULL</b> for an unspecified property. The locale name of
    ///               the leaf node is LOCALE_NAME_USER_DEFAULT.
    ///    pszLocaleName = Type: <b>LPCWSTR</b> The name of the locale of the lead condition, or <b>NULL</b> for a plain string. The
    ///                    locale name of the leaf node is LOCALE_NAME_USER_DEFAULT.
    ///    cco = Type: <b>CONDITION_CREATION_OPTIONS</b> The condition creation operation of the leaf condition as the
    ///          CONDITION_CREATION_OPTIONS enumeration.
    ///    riid = Type: <b>REFIID</b> The desired IID of the enumerating interface: either IEnumUnknown, IID_IEnumVARIANT, or
    ///           (for a negation condition) IID_ICondition.
    ///    ppv = Type: <b>void**</b> Receives a pointer to zero or more ICondition and ICondition2 objects.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateStringLeaf(const(PROPERTYKEY)* propkey, CONDITION_OPERATION cop, const(PWSTR) pszValue, 
                             const(PWSTR) pszLocaleName, CONDITION_CREATION_OPTIONS cco, const(GUID)* riid, 
                             void** ppv);
    ///Creates a leaf condition node for an integer value. The returned object supports ICondition and ICondition2.
    ///Params:
    ///    propkey = Type: <b>REFPROPERTYKEY</b> The name of the property of the leaf condition as a REFPROPERTYKEY. If the leaf
    ///              has no particular property, use PKEY_Null.
    ///    cop = Type: <b>CONDITION_OPERATION</b> A CONDITION_OPERATION enumeration. If the leaf has no particular operation,
    ///          then use <i>COP_IMPLICIT</i>.
    ///    lValue = Type: <b>INT32</b> The value of a leaf condition node as a 32-bit integer.
    ///    cco = Type: <b>CONDITION_CREATION_OPTIONS</b> The condition creation operation of the leaf condition as the
    ///          CONDITION_CREATION_OPTIONS enumeration.
    ///    riid = Type: <b>REFIID</b> The desired IID of the enumerating interface: either IEnumUnknown, IID_IEnumVARIANT, or
    ///           (for a negation condition) IID_ICondition.
    ///    ppv = Type: <b>void**</b> Receives a pointer to zero or more ICondition and ICondition2 objects.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateIntegerLeaf(const(PROPERTYKEY)* propkey, CONDITION_OPERATION cop, int lValue, 
                              CONDITION_CREATION_OPTIONS cco, const(GUID)* riid, void** ppv);
    ///Creates a search condition that is either <b>TRUE</b> or <b>FALSE</b>. The returned object supports ICondition
    ///and ICondition2
    ///Params:
    ///    propkey = Type: <b>REFPROPERTYKEY</b> The name of the property of the leaf condition as a REFPROPERTYKEY. If the leaf
    ///              has no particular property, use PKEY_Null.
    ///    cop = Type: <b>CONDITION_OPERATION</b> A CONDITION_OPERATION enumeration. If the leaf has no particular operation,
    ///          then use <i>COP_IMPLICIT</i>.
    ///    fValue = Type: <b>BOOL</b> The value of the search condition to use. <i>fValue</i> should typically be set to
    ///             VARIANT_FALSE.
    ///    cco = Type: <b>CONDITION_CREATION_OPTIONS</b> The condition creation operation of the leaf condition as the
    ///          CONDITION_CREATION_OPTIONS enumeration.
    ///    riid = Type: <b>REFIID</b> The desired IID of the enumerating interface: either IEnumUnknown, IEnumVARIANT, or (for
    ///           a negation condition) IID_ICondition.
    ///    ppv = Type: <b>void**</b> Receives a pointer to zero or more ICondition and ICondition2 objects.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateBooleanLeaf(const(PROPERTYKEY)* propkey, CONDITION_OPERATION cop, BOOL fValue, 
                              CONDITION_CREATION_OPTIONS cco, const(GUID)* riid, void** ppv);
    ///Creates a leaf condition node for any value. The returned object supports ICondition and ICondition2.
    ///Params:
    ///    propkey = Type: <b>REFPROPERTYKEY</b> The name of the property of the leaf condition as a REFPROPERTYKEY. If the leaf
    ///              has no particular property, use PKEY_Null.
    ///    cop = Type: <b>CONDITION_OPERATION</b> A CONDITION_OPERATION enumeration. If the leaf has no particular operation,
    ///          then use <i>COP_IMPLICIT</i>.
    ///    propvar = Type: <b>REFPROPERTYKEY</b> The property value of the leaf condition as a REFPROPERTYKEY.
    ///    pszSemanticType = Type: <b>LPCWSTR</b> The name of a semantic type of the value, or <b>NULL</b> for a plain string. If the
    ///                      newly created leaf is an unresolved named entity, <i>pszSemanticType</i> should be the name of a semantic
    ///                      type, otherwise <b>NULL</b>.
    ///    pszLocaleName = Type: <b>LPCWSTR</b> The name of the locale to be compared, or <b>NULL</b> for an unspecified locale. If
    ///                    <i>propvar</i> does not contain a string value, then <i>pszLocaleName</i> should be LOCALE_NAME_USER_DEFAULT;
    ///                    otherwise, <i>pszLocaleName</i> should reflect the language the string. Alternatively, <i>pszLocaleName</i>
    ///                    could be LOCALE_NAME_INVARIANT.
    ///    pPropertyNameTerm = Type: <b>IRichChunk*</b> A pointer to an IRichChunk that identifies the range of the input string that
    ///                        repesents the property. It can be <b>NULL</b>.
    ///    pOperationTerm = Type: <b>IRichChunk*</b> A pointer to an IRichChunk that identifies the range of the input string that
    ///                     repesents the operation. It can be <b>NULL</b>.
    ///    pValueTerm = Type: <b>IRichChunk*</b> A pointer to an IRichChunk that identifies the range of the input string that
    ///                 repesents the value. It can be <b>NULL</b>.
    ///    cco = Type: <b>CONDITION_CREATION_OPTIONS</b> The condition creation operation of the leaf condition as the
    ///          CONDITION_CREATION_OPTIONS enumeration.
    ///    riid = Type: <b>REFIID</b> The desired IID of the enumerating interface: either IEnumUnknown, IEnumVARIANT, or (for
    ///           a negation condition) IID_ICondition.
    ///    ppv = Type: <b>void**</b> Receives a pointer to zero or more ICondition and ICondition2 objects.
    ///Returns:
    ///    This method does not return a value.
    ///    
    HRESULT CreateLeaf(const(PROPERTYKEY)* propkey, CONDITION_OPERATION cop, const(PROPVARIANT)* propvar, 
                       const(PWSTR) pszSemanticType, const(PWSTR) pszLocaleName, IRichChunk pPropertyNameTerm, 
                       IRichChunk pOperationTerm, IRichChunk pValueTerm, CONDITION_CREATION_OPTIONS cco, 
                       const(GUID)* riid, void** ppv);
    ///Performs a variety of transformations on a condition tree, and thereby the resolved condition for evaluation. The
    ///returned object supports ICondition and ICondition2.
    ///Params:
    ///    pc = Type: <b>ICondition*</b> Pointer to an ICondition object to be resolved.
    ///    sqro = Type: <b>STRUCTURED_QUERY_RESOLVE_OPTION</b> Specifies zero or more of the STRUCTURED_QUERY_RESOLVE_OPTION
    ///           flags. The <i>SQRO_NULL_VALUE_TYPE_FOR_PLAIN_VALUES</i> flag is automatically added to <i>sqro</i>.
    ///    pstReferenceTime = Type: <b>SYSTEMTIME const*</b> Pointer to a <b>SYSTEMTIME</b> value to use as the reference date and time. A
    ///                       null pointer can be passed if <i>sqro</i> is set to the <i>SQRO_DONT_RESOLVE_DATETIME</i> flag.
    ///    riid = Type: <b>REFIID</b> The desired IID of the enumerating interface: either IEnumUnknown, IEnumVARIANT, or (for
    ///           a negation condition) IID_ICondition.
    ///    ppv = Type: <b>void**</b> Receives a pointer to zero or more ICondition and ICondition2 objects.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ResolveCondition(ICondition pc, STRUCTURED_QUERY_RESOLVE_OPTION sqro, 
                             const(SYSTEMTIME)* pstReferenceTime, const(GUID)* riid, void** ppv);
}

///Provides methods for handling named entities and generating special conditions.
@GUID("92D2CC58-4386-45A3-B98C-7E0CE64A4117")
interface IConditionGenerator : IUnknown
{
    ///Resets all states of the interface to default values and retrieves any necessary information from the schema.
    ///Params:
    ///    pSchemaProvider = Type: <b>ISchemaProvider*</b> Pointer to the schema to be used.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Initialize(ISchemaProvider pSchemaProvider);
    ///Identifies named entities in an input string, and creates a collection containing them. The value of each named
    ///entity is expressed as a string, which is then used by IConditionGenerator::GenerateForLeaf. The string can
    ///contain any data and be in any format, because it is not examined by any other components.
    ///Params:
    ///    pszInputString = Type: <b>LPCWSTR</b> The input string to be parsed.
    ///    lcidUserLocale = Type: <b>LCID</b> The LCID against which named entities should be recognized.
    ///    pTokenCollection = Type: <b>ITokenCollection*</b> A pointer to an ITokenCollection object that indicates how the input string
    ///                       was tokenized.
    ///    pNamedEntities = Type: <b>INamedEntityCollector*</b> On input, contains an INamedEntityCollector or <b>NULL</b>. On return,
    ///                     contains an <b>INamedEntityCollector</b> collection of the named entities.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT RecognizeNamedEntities(const(PWSTR) pszInputString, uint lcidUserLocale, 
                                   ITokenCollection pTokenCollection, INamedEntityCollector pNamedEntities);
    ///Generates a special query expression for what would otherwise become a leaf query expression.
    ///Params:
    ///    pConditionFactory = Type: <b>IConditionFactory*</b> An IConditionFactory object that can be used to create the necessary nodes.
    ///    pszPropertyName = Type: <b>LPCWSTR</b> Property name, or <b>NULL</b> if there is no property name.
    ///    cop = Type: <b>CONDITION_OPERATION</b> A CONDITION_OPERATION enumerated type identifying the operation.
    ///    pszValueType = Type: <b>LPCWSTR</b> Semantic type describing the values in <i>pszValue</i> and <i>pszValue2</i>.
    ///    pszValue = Type: <b>LPCWSTR</b> A string generated by IConditionGenerator::RecognizeNamedEntities that represents the
    ///               value. If <i>pszValue2</i> is not <b>NULL</b>, then this represents the beginning of the value's range.
    ///    pszValue2 = Type: <b>LPCWSTR</b> If not <b>NULL</b>, a string generated by IConditionGenerator::RecognizeNamedEntities
    ///                that represents the end of the value's range. If <b>NULL</b>, then <i>pszValue</i> represents a discrete
    ///                value.
    ///    pPropertyNameTerm = Type: <b>IRichChunk*</b> Pointer to an IRichChunk object containing information about what part of an input
    ///                        string produced the property name.
    ///    pOperationTerm = Type: <b>IRichChunk*</b> Pointer to an IRichChunk object containing information about what part of an input
    ///                     string produced the operation.
    ///    pValueTerm = Type: <b>IRichChunk*</b> Pointer to an IRichChunk object containing information about what part of an input
    ///                 string produced the value.
    ///    automaticWildcard = Type: <b>BOOL</b> <b>TRUE</b> if the generated condition should return results that begin with the specified
    ///                        value, if meaningful. <b>FALSE </b> if the generated condition should return results matching the specified
    ///                        value exactly.
    ///    pNoStringQuery = Type: <b>BOOL*</b> <b>VARIANT_TRUE</b> if the condition tree in <i>ppQueryExpression</i> should be the full
    ///                     query, or <b>VARIANT_FALSE</b> if the full query should be a disjunction of the condition tree in
    ///                     <i>ppQueryExpression</i> and the condition tree that would have been used if this method had returned
    ///                     S_FALSE.
    ///    ppQueryExpression = Type: <b>ICondition**</b> Receives a pointer to an ICondition condition tree.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following, or an error value otherwise. <table> <tr> <th>Return
    ///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td
    ///    width="60%"> Successfully generated a condition. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> A condition was not generated, and the query parser must
    ///    produce one in some other way. </td> </tr> </table>
    ///    
    HRESULT GenerateForLeaf(IConditionFactory pConditionFactory, const(PWSTR) pszPropertyName, 
                            CONDITION_OPERATION cop, const(PWSTR) pszValueType, const(PWSTR) pszValue, 
                            const(PWSTR) pszValue2, IRichChunk pPropertyNameTerm, IRichChunk pOperationTerm, 
                            IRichChunk pValueTerm, BOOL automaticWildcard, BOOL* pNoStringQuery, 
                            ICondition* ppQueryExpression);
    ///This method attempts to produce a phrase that, when recognized by this instance of IConditionGenerator,
    ///represents the type and value pair for an entity, relationship, or named entity.
    ///Params:
    ///    pszValueType = Type: <b>LPCWSTR</b> The semantic type of the value in <i>ppropvar</i>.
    ///    ppropvar = Type: <b>PROPVARIANT const*</b> The value to be processed.
    ///    fUseEnglish = Type: <b>BOOL</b> The parameter fUseEnglish is reserved: it should be ignored by implementors, and callers
    ///                  should pass <b>FALSE</b>.
    ///    ppszPhrase = Type: <b>LPWSTR*</b> Receives a pointer to the phrase representing the value. If no phrase can be produced,
    ///                 this parameter is set to <b>NULL</b> and the method returns S_FALSE.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful, S_FALSE if the input arguments are valid but no phrase can
    ///    be produced, and an error value otherwise.
    ///    
    HRESULT DefaultPhrase(const(PWSTR) pszValueType, const(PROPVARIANT)* ppropvar, BOOL fUseEnglish, 
                          PWSTR* ppszPhrase);
}

///Provides a method to get the limits of an interval.
@GUID("6BF0A714-3C18-430B-8B5D-83B1C234D3DB")
interface IInterval : IUnknown
{
    ///Specifies the lower and upper limits of an interval, each of which may be infinite or a specific value. When a
    ///condition tree expresses that the value of a property must fall in a certain range, the property can be expressed
    ///as a leaf node. The node must be a PROPVARIANT containing a <b>vt</b> value type tag of VT_UNKNOWN and an
    ///IUnknown* <b>punkVal</b> that is a pointer to an object that implements IInterval.
    ///Params:
    ///    pilkLower = Type: <b>INTERVAL_LIMIT_KIND*</b> Receives a pointer to a value from the INTERVAL_LIMIT_KIND enumeration that
    ///                indicates whether the lower bound of the interval is inclusive, exclusive, or infinite.
    ///    ppropvarLower = Type: <b>PROPVARIANT*</b> Receives a pointer to the value for the lower limit of the interval. If the
    ///                    <i>pilkLower</i> parameter is set to <i>ILK_NEGATIVE_INFINITY</i> or <i>ILK_POSITIVE_INFINITY</i>, this value
    ///                    is set to <b>VT_EMPTY</b>.
    ///    pilkUpper = Type: <b>INTERVAL_LIMIT_KIND*</b> Receives a pointer to a value from the INTERVAL_LIMIT_KIND enumeration that
    ///                indicates whether the upper bound of the interval is inclusive, exclusive, or infinite.
    ///    ppropvarUpper = Type: <b>PROPVARIANT*</b> Receives a pointer to the value for the upper limit of the interval. If the
    ///                    <i>pilkUpper</i> parameter is set to <i>ILK_NEGATIVE_INFINITY</i> or <i>ILK_POSITIVE_INFINITY</i>, this value
    ///                    will be set to <b>VT_EMPTY</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetLimits(INTERVAL_LIMIT_KIND* pilkLower, PROPVARIANT* ppropvarLower, INTERVAL_LIMIT_KIND* pilkUpper, 
                      PROPVARIANT* ppropvarUpper);
}

///Provides a method for retrieving a key/value pair of strings from an IEntity, IRelationship or ISchemaProvider
///object.
@GUID("780102B0-C43B-4876-BC7B-5E9BA5C88794")
interface IMetaData : IUnknown
{
    ///Retrieves one key/value pair from the metadata of an IEntity, IRelationship, or ISchemaProvider object.
    ///Params:
    ///    ppszKey = Type: <b>LPCWSTR*</b> Receives the key of the metadata pair as a Unicode string. The calling application must
    ///              free the returned string by calling CoTaskMemFree.
    ///    ppszValue = Type: <b>LPWSTR*</b> Receives the value of the metadata pair as a Unicode string. The calling application
    ///                must free the returned string by calling CoTaskMemFree.
    HRESULT GetData(PWSTR* ppszKey, PWSTR* ppszValue);
}

///Provides methods for retrieving information about an entity type in the schema.
@GUID("24264891-E80B-4FD3-B7CE-4FF2FAE8931F")
interface IEntity : IUnknown
{
    ///Retrieves the name of this entity.
    ///Params:
    ///    ppszName = Type: <b>LPWSTR*</b> Receives a pointer to the name of this entity as a Unicode string. The calling
    ///               application must free the returned string by calling CoTaskMemFree.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Name(PWSTR* ppszName);
    ///Retrieves the parent entity of this entity.
    ///Params:
    ///    pBaseEntity = Type: <b>IEntity**</b> Receives a pointer to the parent IEntity object, or <b>NULL</b> if there is no parent
    ///                  entity.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns one of the following, or an error value otherwise. <table> <tr> <th>Return
    ///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td
    ///    width="60%"> <i>pBaseEntity</i> successfully set. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The entity has no parent; <i>pBaseEntity</i>
    ///    successfully set to <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT Base(IEntity* pBaseEntity);
    ///Retrieves an enumeration of IRelationship objects, one for each relationship this entity has.
    ///Params:
    ///    riid = Type: <b>REFIID</b> The desired IID of the result, either IID_IEnumUnknown or IID_IEnumVARIANT.
    ///    pRelationships = Type: <b>void**</b> Receives the address of a pointer to the enumeration of the IRelationship objects.
    HRESULT Relationships(const(GUID)* riid, void** pRelationships);
    ///Retrieves the IRelationship object for this entity as requested by name.
    ///Params:
    ///    pszRelationName = Type: <b>LPCWSTR</b> The name of the relationship to find.
    ///    pRelationship = Type: <b>IRelationship**</b> Receives the address of a pointer to the requested IRelationship object, or
    ///                    <b>NULL</b> if this entity has no relationship with the name specified.
    HRESULT GetRelationship(const(PWSTR) pszRelationName, IRelationship* pRelationship);
    ///Retrieves an enumeration of IMetaData objects for this entity.
    ///Params:
    ///    riid = Type: <b>REFIID</b> The desired IID of the result, either IID_IEnumUnknown or IID_IEnumVARIANT.
    ///    pMetaData = Type: <b>void**</b> Receives the address of a pointer to an enumeration of IMetaData objects.
    HRESULT MetaData(const(GUID)* riid, void** pMetaData);
    ///Retrieves an enumeration of INamedEntity objects, one for each known named entity of this type.
    ///Params:
    ///    riid = Type: <b>REFIID</b> The desired IID of the result, either IID_IEnumUnknown or IID_IEnumVARIANT.
    ///    pNamedEntities = Type: <b>void**</b> Receives the address of a pointer to an enumeration of INamedEntity objects, one for each
    ///                     known named entity of this type.
    HRESULT NamedEntities(const(GUID)* riid, void** pNamedEntities);
    ///Retrieves an INamedEntity object based on an entity name.
    ///Params:
    ///    pszValue = Type: <b>LPCWSTR</b> The name of an entity to be found.
    ///    ppNamedEntity = Type: <b>INamedEntity**</b> Receives a pointer to the INamedEntity object that was named in <i>pszValue</i>.
    ///                    <b>NULL</b> if no named entity was found.
    HRESULT GetNamedEntity(const(PWSTR) pszValue, INamedEntity* ppNamedEntity);
    ///Retrieves a default phrase to use for this entity in restatements.
    ///Params:
    ///    ppszPhrase = Type: <b>LPWSTR*</b> Receives a pointer to the default phrase as a Unicode string. The calling application
    ///                 must free the returned string by calling CoTaskMemFree.
    HRESULT DefaultPhrase(PWSTR* ppszPhrase);
}

///Provides methods for retrieving information about a schema property.
@GUID("2769280B-5108-498C-9C7F-A51239B63147")
interface IRelationship : IUnknown
{
    ///Retrieves the name of the relationship.
    ///Params:
    ///    ppszName = Type: <b>LPWSTR*</b> Receives a pointer to the name of the relationship as a Unicode string. The calling
    ///               application must free the returned string by calling CoTaskMemFree.
    HRESULT Name(PWSTR* ppszName);
    ///Reports whether a relationship is real.
    ///Params:
    ///    pIsReal = Type: <b>BOOL*</b> Receives <b>TRUE</b> for a real relationship; otherwise, <b>FALSE</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT IsReal(BOOL* pIsReal);
    ///Retrieves the destination IEntity object of the relationship. The destination of a relationshipo corresponds to
    ///the type of a property.
    ///Params:
    ///    pDestinationEntity = Type: <b>IEntity**</b> Receives the address of a pointer to an IEntity object, or <b>NULL</b> if the
    ///                         relationship is not real. For more information, see IRelationship::IsReal.
    HRESULT Destination(IEntity* pDestinationEntity);
    ///Retrieves an enumeration of IMetaData objects for this relationship.
    ///Params:
    ///    riid = Type: <b>REFIID</b> The desired IID of the result, either IID_IEnumUnknown or IID_IEnumVARIANT.
    ///    pMetaData = Type: <b>void**</b> Receives a pointer to the enumeration of IMetaData objects. There may be multiple pairs
    ///                with the same key (or the same value).
    HRESULT MetaData(const(GUID)* riid, void** pMetaData);
    ///Retrieves the default phrase to use for this relationship in restatements.
    ///Params:
    ///    ppszPhrase = Type: <b>LPWSTR*</b> Receives the default phrase as a Unicode string. The calling application must free the
    ///                 string by calling CoTaskMemFree.
    HRESULT DefaultPhrase(PWSTR* ppszPhrase);
}

///Provides methods to get the value of, or a default phrase for the value of, a named entity.
@GUID("ABDBD0B1-7D54-49FB-AB5C-BFF4130004CD")
interface INamedEntity : IUnknown
{
    ///Retrieves the value of this named entity as a string.
    ///Params:
    ///    ppszValue = Type: <b>LPWSTR*</b> Receives a pointer to the value of the named entity as a Unicode string. The calling
    ///                application must free the returned string by calling CoTaskMemFree.
    HRESULT GetValue(PWSTR* ppszValue);
    ///Retrieves a default phrase to use for this named entity in restatements.
    ///Params:
    ///    ppszPhrase = Type: <b>LPWSTR*</b> Receives a pointer to the default phrase as a Unicode string. The calling application
    ///                 must free the returned string by calling CoTaskMemFree.
    HRESULT DefaultPhrase(PWSTR* ppszPhrase);
}

///Provides a schema repository that can be browsed.
@GUID("8CF89BCB-394C-49B2-AE28-A59DD4ED7F68")
interface ISchemaProvider : IUnknown
{
    ///Retrieves an enumeration of IEntity objects with one entry for each entity in the loaded schema.
    ///Params:
    ///    riid = Type: <b>REFIID</b> The desired IID of the result, either IID_IEnumUnknown or IID_IEnumVARIANT.
    ///    pEntities = Type: <b>void**</b> Receives a pointer to an enumeration of entities. The calling application must release it
    ///                by calling its IUnknown::Release method.
    HRESULT Entities(const(GUID)* riid, void** pEntities);
    ///Retrieves the root entity of the loaded schema.
    ///Params:
    ///    pRootEntity = Type: <b>IEntity**</b> Receives a pointer to the root entity. The calling application must release it by
    ///                  invoking its IUnknown::Release method.
    HRESULT RootEntity(IEntity* pRootEntity);
    ///Retrieves an entity by name from the loaded schema.
    ///Params:
    ///    pszEntityName = Type: <b>LPCWSTR</b> The name of the entity being requested.
    ///    pEntity = Type: <b>IEntity**</b> Receives the address of a pointer to the requested entity. The calling application
    ///              must release the entity by calling its IUnknown::Release method. If there is no entity with the specified
    ///              name, this parameter is set to <b>NULL</b>.
    HRESULT GetEntity(const(PWSTR) pszEntityName, IEntity* pEntity);
    ///Retrieves an enumeration of global IMetaData objects for the loaded schema.
    ///Params:
    ///    riid = Type: <b>REFIID</b> The desired IID of the result, either IID_IEnumUnknown or IID_IEnumVARIANT.
    ///    pMetaData = Type: <b>void**</b> Receives a pointer to an enumeration of the IMetaData objects. The calling application
    ///                must release it by calling its IUnknown::Release method.
    HRESULT MetaData(const(GUID)* riid, void** pMetaData);
    ///Localizes the currently loaded schema for a specified locale.
    ///Params:
    ///    lcid = Type: <b>LCID</b> The locale to localize for.
    ///    pSchemaLocalizerSupport = Type: <b>ISchemaLocalizerSupport*</b> Pointer to an ISchemaLocalizerSupport object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Localize(uint lcid, ISchemaLocalizerSupport pSchemaLocalizerSupport);
    ///Saves the loaded schema as a schema binary at a specified path.
    ///Params:
    ///    pszSchemaBinaryPath = Type: <b>LPCWSTR</b> Pointer to a null-terminated Unicode string that contains the fully qualified path at
    ///                          which to save the schema binary.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SaveBinary(const(PWSTR) pszSchemaBinaryPath);
    ///Finds named entities of a specified type in a tokenized string, and returns the value of the entity and the
    ///number of tokens the entity value occupies.
    ///Params:
    ///    pEntity = Type: <b>IEntity*</b> A pointer to an IEntity object identifying the type of named entity to locate.
    ///    pszInputString = Type: <b>LPCWSTR</b> An input string in which to search for named entity keywords.
    ///    pTokenCollection = Type: <b>ITokenCollection*</b> A pointer to the tokenization of the string in the <i>pszInputString</i>
    ///                       parameter.
    ///    cTokensBegin = Type: <b>ULONG</b> The zero-based position of a token in the <i>pTokenCollection</i> from which to start
    ///                   searching.
    ///    pcTokensLength = Type: <b>ULONG*</b> Receives a pointer to the number of tokens covered by the named entity keyword that was
    ///                     found.
    ///    ppszValue = Type: <b>LPWSTR*</b> Receives a pointer to the value of the named entity that was found, as a Unicode string.
    ///                The caller must free the string by calling CoTaskMemFree. An INamedEntity object can be obtained by calling
    ///                the GetNamedEntity method of <i>pEntity</i> and passing the string that was received in this parameter.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if the token sequence beginning at position <i>cTokensBegin</i> denotes a
    ///    named entity of the specified (entity) type. If there is no such token sequence, returns S_FALSE.
    ///    
    HRESULT LookupAuthoredNamedEntity(IEntity pEntity, const(PWSTR) pszInputString, 
                                      ITokenCollection pTokenCollection, uint cTokensBegin, uint* pcTokensLength, 
                                      PWSTR* ppszValue);
}

///Gets the tokens that result from using a word breaker.
@GUID("22D8B4F2-F577-4ADB-A335-C2AE88416FAB")
interface ITokenCollection : IUnknown
{
    ///Retrieves the number of tokens in the collection.
    ///Params:
    ///    pCount = Type: <b>ULONG*</b> Receives the number of tokens within the collection.
    HRESULT NumberOfTokens(uint* pCount);
    ///Retrieves the position, length, and any overriding string of an individual token.
    ///Params:
    ///    i = Type: <b>ULONG</b> The zero-based index of the desired token within the collection.
    ///    pBegin = Type: <b>ULONG*</b> Receives the zero-based starting position of the specified token, in characters. This
    ///             parameter can be <b>NULL</b>.
    ///    pLength = Type: <b>ULONG*</b> Receives the number of characters spanned by the token. This parameter can be
    ///              <b>NULL</b>.
    ///    ppsz = Type: <b>LPWSTR*</b> Receives the overriding text for this token if available, or <b>NULL</b> if there is
    ///           none.
    HRESULT GetToken(uint i, uint* pBegin, uint* pLength, PWSTR* ppsz);
}

///Provides a method to accumulate named entities as identified by an IConditionGenerator object. When a query parser
///parses an input string into condition nodes, the parser invokes an IConditionGenerator object that, in turn, invokes
///this interface to collect possible named entities in the input string.
@GUID("AF2440F6-8AFC-47D0-9A7F-396A0ACFB43D")
interface INamedEntityCollector : IUnknown
{
    ///Adds a single (potential) named entity to this INamedEntityCollector collection, as identified in a tokenized
    ///span of the input string being parsed.
    ///Params:
    ///    beginSpan = Type: <b>ULONG</b> The beginning of the overall token span, including any leading quotation marks.
    ///    endSpan = Type: <b>ULONG</b> The end of the overall token span including any trailing quotation marks.
    ///    beginActual = Type: <b>ULONG</b> The beginning of the part of the token span that identifies the potential named entity.
    ///    endActual = Type: <b>ULONG</b> The end of the part of the token span that identifies the potential named entity.
    ///    pType = Type: <b>IEntity*</b> The semantic type of the named entity.
    ///    pszValue = Type: <b>LPCWSTR</b> The name of the entity as a string.
    ///    certainty = Type: <b>NAMED_ENTITY_CERTAINTY</b> One of the following values: <table class="clsStd"> <tr> <th>Value</th>
    ///                <th>Information</th> </tr> <tr> <td>NEC_LOW</td> <td>It could be this named entity, but additional evidence
    ///                is advisable.</td> </tr> <tr> <td>NEC_MEDIUM</td> <td>It is likely this named entity; it is okay to use
    ///                it.</td> </tr> <tr> <td>NEC_HIGH</td> <td>It almost certainly is this named entity; it should be okay to
    ///                discard other possibilities.</td> </tr> </table>
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Add(uint beginSpan, uint endSpan, uint beginActual, uint endActual, IEntity pType, 
                const(PWSTR) pszValue, NAMED_ENTITY_CERTAINTY certainty);
}

///Provides a method for localizing keywords in a specified string.
@GUID("CA3FDCA2-BFBE-4EED-90D7-0CAEF0A1BDA1")
interface ISchemaLocalizerSupport : IUnknown
{
    ///Localizes keywords from an input string.
    ///Params:
    ///    pszGlobalString = Type: <b>LPCWSTR</b> Pointer to a null-terminated Unicode string to be localized. It may be in one of two
    ///                      forms: (1) a set of keywords separated by the vertical bar character (Unicode character code 007C) (for
    ///                      example "date modified|modified|modification date"), or (2) a string of the form "@some.dll,-12345". This
    ///                      example refers to resource ID 12345 of the some.dll binary. That resource must be a string of the previous
    ///                      (1) form.
    ///    ppszLocalString = Type: <b>LPWSTR*</b> Returns a null-terminated Unicode string that is the localized string. The calling
    ///                      application must free the returned string by calling CoTaskMemFree. If the method does not succeed, this
    ///                      parameter is set to <b>NULL</b>.
    HRESULT Localize(const(PWSTR) pszGlobalString, PWSTR* ppszLocalString);
}

///Provides methods to create, initialize, and change options for an IQueryParser object.
@GUID("A879E3C4-AF77-44FB-8F37-EBD1487CF920")
interface IQueryParserManager : IUnknown
{
    ///Creates a new instance of a IQueryParser interface implementation. This instance of the query parser is loaded
    ///with the schema for the specified catalog and is localized to a specified language. All other settings are
    ///initialized to default settings.
    ///Params:
    ///    pszCatalog = Type: <b>LPCWSTR</b> The name of the catalog to use. Permitted values are <code>SystemIndex</code> and an
    ///                 empty string (for a trivial schema with no properties).
    ///    langidForKeywords = Type: <b>LANGID</b> The LANGID used to select the localized language for keywords.
    ///    riid = Type: <b>REFIID</b> The IID of the IQueryParser interface implementation.
    ///    ppQueryParser = Type: <b>void**</b> Receives a pointer to the newly created parser. The calling application must release it
    ///                    by calling its IUnknown::Release method.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateLoadedParser(const(PWSTR) pszCatalog, ushort langidForKeywords, const(GUID)* riid, 
                               void** ppQueryParser);
    ///Sets the flags for Natural Query Syntax (NQS) and automatic wildcard characters for the specified query parser.
    ///If the query parser was created for the <code>SystemIndex</code> catalog, this method also sets up standard
    ///condition generators to be used later by the query parser object for recognizing named entities.
    ///Params:
    ///    fUnderstandNQS = Type: <b>BOOL</b> <b>BOOL</b> flag that controls whether NQS is supported by this instance of the query
    ///                     parser.
    ///    fAutoWildCard = Type: <b>BOOL</b> <b>BOOL</b> flag that controls whether a wildcard character (*) is to be assumed after each
    ///                    word in the query (unless followed by punctuation other than a parenthesis).
    ///    pQueryParser = Type: <b>IQueryParser*</b> Pointer to the query parser object.
    HRESULT InitializeOptions(BOOL fUnderstandNQS, BOOL fAutoWildCard, IQueryParser pQueryParser);
    ///Changes a single option in this IQueryParserManager object. For example, this method could change the name of the
    ///schema binary to load or the location of localized schema binaries.
    ///Params:
    ///    option = Type: <b>QUERY_PARSER_MANAGER_OPTION</b> The QUERY_PARSER_MANAGER_OPTION to be changed.
    ///    pOptionValue = Type: <b>PROPVARIANT const*</b> A pointer to the value to use for the option selected.
    HRESULT SetOption(QUERY_PARSER_MANAGER_OPTION option, const(PROPVARIANT)* pOptionValue);
}

///Provides methods for processing an individual item in a content source whose URL is provided by the gatherer to the
///filter host.
@GUID("0B63E318-9CCC-11D0-BCDB-00805FCCCE04")
interface IUrlAccessor : IUnknown
{
    ///Requests a property-value set.
    ///Params:
    ///    pSpec = Type: <b>PROPSPEC*</b> Pointer to a PROPSPEC structure containing the requested property.
    ///    pVar = Type: <b>PROPVARIANT*</b> Pointer to a PROPVARIANT structure containing the value for the property specified
    ///           by <i>pSpec</i>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AddRequestParameter(PROPSPEC* pSpec, PROPVARIANT* pVar);
    ///Gets the document format, represented as a Multipurpose Internet Mail Extensions (MIME) string.
    ///Params:
    ///    wszDocFormat = Type: <b>WCHAR[]</b> Receives a pointer to a null-terminated Unicode string containing the MIME type for the
    ///                   current item.
    ///    dwSize = Type: <b>DWORD</b> Size of <i>wszDocFormat</i>in <b>TCHAR</b><b>s</b>.
    ///    pdwLength = Type: <b>DWORD*</b> Receives a pointer to the number of <b>TCHAR</b><b>s</b> written to <i>wszDocFormat</i>,
    ///                not including the terminating <b>NULL</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetDocFormat(ushort* wszDocFormat, uint dwSize, uint* pdwLength);
    ///Gets the CLSID for the document type of the URL item being processed.
    ///Params:
    ///    pClsid = Type: <b>CLSID*</b> Receives a pointer to the CLSID for the document type of the URL item being processed.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetCLSID(GUID* pClsid);
    ///Gets the host name for the content source, if applicable.
    ///Params:
    ///    wszHost = Type: <b>WCHAR[]</b> Receives the name of the host that the content source file resides on, as a
    ///              null-terminated Unicode string.
    ///    dwSize = Type: <b>DWORD</b> Size in <b>TCHAR</b><b>s</b>of <i>wszHost</i>, not including the terminating <b>NULL</b>.
    ///    pdwLength = Type: <b>DWORD*</b> Receives a pointer to the number of <b>TCHAR</b><b>s</b> written to <i>wszHost</i>, not
    ///                including the terminating <b>NULL</b>.
    HRESULT GetHost(ushort* wszHost, uint dwSize, uint* pdwLength);
    ///Ascertains whether the item URL points to a directory.
    HRESULT IsDirectory();
    ///Gets the size of the content designated by the URL.
    ///Params:
    ///    pllSize = Type: <b>ULONGLONG*</b> Receives a pointer to the number of bytes of data contained in the URL.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetSize(ulong* pllSize);
    ///Gets the time stamp identifying when the URL was last modified.
    ///Params:
    ///    pftLastModified = Type: <b>FILETIME*</b> Receives a pointer to a variable of type FILETIME identifying the time stamp when the
    ///                      URL was last modified.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetLastModified(FILETIME* pftLastModified);
    ///Retrieves the file name of the item, which the filter host uses for indexing. If the item does not exist in a
    ///file system and the IUrlAccessor::BindToStream method is implemented, this method returns the shell's
    ///System.ParsingPath property for the item.
    ///Params:
    ///    wszFileName = Type: <b>WCHAR[]</b> Receives the file name as a null-terminated Unicode string.
    ///    dwSize = Type: <b>DWORD</b> Size in <b>TCHAR</b><b>s</b> of <i>wszFileName</i>, not including the terminating
    ///             <b>NULL</b>.
    ///    pdwLength = Type: <b>DWORD*</b> Receives a pointer to the number of <b>TCHAR</b><b>s</b>written to <b>wszFileName</b>,
    ///                not including <b>NULL</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetFileName(ushort* wszFileName, uint dwSize, uint* pdwLength);
    ///Gets the security descriptor for the URL item. Security is applied at query time, so this descriptor identifies
    ///security for read access.
    ///Params:
    ///    pSD = Type: <b>BYTE*</b> Receives a pointer to the security descriptor.
    ///    dwSize = Type: <b>DWORD</b> Size in <b>TCHAR</b><b>s</b>of the <i>pSD</i> array.
    ///    pdwLength = Type: <b>DWORD*</b> Receives a pointer to the number of <b>TCHAR</b><b>s</b> written to <i>pSD</i>, not
    ///                including the terminating <b>NULL</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetSecurityDescriptor(ubyte* pSD, uint dwSize, uint* pdwLength);
    ///Gets the redirected URL for the current item.
    ///Params:
    ///    wszRedirectedURL = Type: <b>WCHAR[]</b> Receives the redirected URL as a Unicode string, not including the terminating
    ///                       <b>NULL</b>.
    ///    dwSize = Type: <b>DWORD</b> Size in <b>TCHAR</b><b>s</b>of <i>wszRedirectedURL</i>, not including the terminating
    ///             <b>NULL</b>.
    ///    pdwLength = Type: <b>DWORD*</b> Receives a pointer to the number of <b>TCHAR</b><b>s</b> written to
    ///                <i>wszRedirectedURL</i>, not including the terminating <b>NULL</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetRedirectedURL(ushort* wszRedirectedURL, uint dwSize, uint* pdwLength);
    ///Gets the security provider for the URL.
    ///Params:
    ///    pSPClsid = Type: <b>CLSID*</b> Receives a pointer to a security provider's CLSID.
    HRESULT GetSecurityProvider(GUID* pSPClsid);
    ///Binds the item being processed to an IStream interface [Structured Storage] data stream and retrieves a pointer
    ///to that stream.
    ///Params:
    ///    ppStream = Type: <b>IStream**</b> Receives the address of a pointer to the IStream that contains the item represented by
    ///               the URL.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT BindToStream(IStream* ppStream);
    ///Binds the item being processed to the appropriate IFilterand retrieves a pointer to the <b>IFilter</b>.
    ///Params:
    ///    ppFilter = Type: <b>IFilter**</b> Receives the address of a pointer to the IFilter that can return metadata about the
    ///               item being processed.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT BindToFilter(IFilter* ppFilter);
}

///Extends functionality of the IUrlAccessor interface.
@GUID("C7310734-AC80-11D1-8DF3-00C04FB6EF4F")
interface IUrlAccessor2 : IUrlAccessor
{
    ///Gets the user-friendly path for the URL item.
    ///Params:
    ///    wszDocUrl = Type: <b>WCHAR[]</b> Receives the display URL as a null-terminated Unicode string.
    ///    dwSize = Type: <b>DWORD</b> Size in <b>TCHAR</b><b>s</b>of <i>wszDocUrl</i>.
    ///    pdwLength = Type: <b>DWORD*</b> Receives a pointer to the number of <b>TCHAR</b><b>s</b> written to <i>wszDocUrl</i>, not
    ///                including the terminating <b>NULL</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetDisplayUrl(ushort* wszDocUrl, uint dwSize, uint* pdwLength);
    ///Ascertains whether an item URL is a document or directory.
    HRESULT IsDocument();
    ///Gets the code page for properties of the URL item.
    ///Params:
    ///    wszCodePage = Type: <b>WCHAR[]</b> Receives the code page as a null-terminated Unicode string.
    ///    dwSize = Type: <b>DWORD</b> Size of <i>wszCodePage</i> in <b>TCHAR</b><b>s</b>.
    ///    pdwLength = Type: <b>DWORD*</b> Receives a pointer to the number of <b>TCHAR</b><b>s</b> written to <i>wszCodePage</i>,
    ///                not including the terminating <b>NULL</b> character.
    HRESULT GetCodePage(ushort* wszCodePage, uint dwSize, uint* pdwLength);
}

///Extends the functionality of the IUrlAccessor2 interface with the IUrlAccessor3::GetImpersonationSidBlobs method to
///identify user security identifiers (SIDs) for a specified URL.
@GUID("6FBC7005-0455-4874-B8FF-7439450241A3")
interface IUrlAccessor3 : IUrlAccessor2
{
    ///Retrieves an array of user security identifiers (SIDs) for a specified URL. This method enables protocol handlers
    ///to specify which users can access the file and the search protocol host to impersonate a user in order to index
    ///the file.
    ///Params:
    ///    pcwszURL = Type: <b>LPCWSTR</b> The URL to access on behalf of an impersonated user.
    ///    pcSidCount = Type: <b>DWORD*</b> Receives a pointer to the number of user SIDs returned in <i>ppSidBlobs</i>.
    ///    ppSidBlobs = Type: <b>BLOB**</b> Receives the address of a pointer to the array of candidate impersonation user SIDs.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetImpersonationSidBlobs(const(PWSTR) pcwszURL, uint* pcSidCount, BLOB** ppSidBlobs);
}

///Extends the functionality of the IUrlAccessor3 interface with the IUrlAccessor4::ShouldIndexItemContent method that
///identifies whether the content of the item should be indexed.
@GUID("5CC51041-C8D2-41D7-BCA3-9E9E286297DC")
interface IUrlAccessor4 : IUrlAccessor3
{
    ///Identifies whether the item's content should be indexed.
    ///Params:
    ///    pfIndexContent = Type: <b>BOOL*</b> A pointer to a <b>BOOL</b> value that indicates whether the item's content should be
    ///                     indexed.
    HRESULT ShouldIndexItemContent(BOOL* pfIndexContent);
    ///Identifies whether a property should be indexed.
    ///Params:
    ///    key = The property to index.
    ///    pfIndexProperty = A pointer to a value that indicates whether a property should be indexed.
    ///Returns:
    ///    Returns S_FALSE if the property should not be indexed.
    ///    
    HRESULT ShouldIndexProperty(const(PROPERTYKEY)* key, BOOL* pfIndexProperty);
}

///Provides methods to check the opportunistic lock that is used by Microsoft Windows Desktop Search (WDS) on items
///while indexing. If another process locks the file in an incompatible manner, WDS will lose its lock and allow the
///other process to have the file. This mechanism allows WDS to run in the background. Consequently, WDS needs to check
///its locks to ensure another process has not taken precedence while WDS indexes the item. A third-party IUrlAccessor
///object can implement this interface if the underlying data store provides a mechanism to track concurrent access to
///items. If this interface is exposed by <b>IUrlAccessor</b>, WDS will check the <b>IOpLockStatus</b> while indexing
///items from that store.
@GUID("C731065D-AC80-11D1-8DF3-00C04FB6EF4F")
interface IOpLockStatus : IUnknown
{
    ///Checks the status of the opportunistic lock (OpLock) on the item being indexed.
    ///Params:
    ///    pfIsOplockValid = Type: <b>BOOL*</b> Receives a pointer to a <b>BOOL</b> value that indicates whether the OpLock is
    ///                      successfully taken.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT IsOplockValid(BOOL* pfIsOplockValid);
    ///Checks the status of the opportunistic lock (OpLock) on the item being indexed.
    ///Params:
    ///    pfIsOplockBroken = Type: <b>BOOL*</b> Receives a pointer to a <b>BOOL</b> value that indicates whether the OpLock is broken:
    ///                       <b>TRUE</b> if OpLock was taken and then broken, <b>FALSE</b> otherwise (including the case when OpLock was
    ///                       not taken).
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if the OpLock is broken, S_FALSE otherwise.
    ///    
    HRESULT IsOplockBroken(BOOL* pfIsOplockBroken);
    ///Gets the event handle of the opportunistic lock (OpLock). The event object is set to the signaled state when the
    ///OpLock is broken, enabling the indexer to stop all operations on the underlying IUrlAccessor object.
    ///Params:
    ///    phOplockEv = Type: <b>HANDLE*</b> Receives a pointer to the handle of the event associated with the OpLock, or <b>NULL</b>
    ///                 if no OpLock was taken.
    HRESULT GetOplockEventHandle(HANDLE* phOplockEv);
}

///This optional interface enables the protocol handler to perform an action on the thread used for filtering in the
///protocol host. When the protocol host starts, it first initializes all the protocol handlers, and then it creates the
///filtering thread(s). The methods on this interface enable protocol handlers to manage their resources that are used
///by a filtering thread.
@GUID("C73106E1-AC80-11D1-8DF3-00C04FB6EF4F")
interface ISearchProtocolThreadContext : IUnknown
{
    ///Initializes communication between the protocol handler and the protocol host.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ThreadInit();
    ///Notifies the protocol handler that the thread is being shut down.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ThreadShutdown();
    ///Notifies the protocol handler that the filtering thread is idle, so that the protocol handler can clean up any
    ///cache it might have built up.
    ///Params:
    ///    dwTimeElaspedSinceLastCallInMS = Type: <b>DWORD</b> Passes the idle time, in milliseconds, to the protocol handler.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ThreadIdle(uint dwTimeElaspedSinceLastCallInMS);
}

///Provides methods for invoking, initializing, and managing IUrlAccessor objects. Methods in this interface are called
///by the protocol host when processing URLs from the gatherer. The protocol handler implements the protocol for
///accessing a content source in its native format. Use this interface to implement a custom protocol handler to expand
///the data sources that can be indexed.
@GUID("C73106BA-AC80-11D1-8DF3-00C04FB6EF4F")
interface ISearchProtocol : IUnknown
{
    ///Initializes a protocol handler.
    ///Params:
    ///    pTimeoutInfo = Type: <b>TIMEOUT_INFO*</b> Pointer to a TIMEOUT_INFO structure that contains information about connection
    ///                   time-outs.
    ///    pProtocolHandlerSite = Type: <b>IProtocolHandlerSite*</b> Pointer to an IProtocolHandlerSite interface that enables protocol
    ///                           handlers to access IFiltearwithin the filter host.
    ///    pProxyInfo = Type: <b>PROXY_INFO*</b> Pointer to a PROXY_INFO structure that contains information about the proxy settings
    ///                 necessary for accessing items in the content source.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Init(TIMEOUT_INFO* pTimeoutInfo, IProtocolHandlerSite pProtocolHandlerSite, PROXY_INFO* pProxyInfo);
    ///Creates and initializes an IUrlAccessor object.
    ///Params:
    ///    pcwszURL = Type: <b>LPCWSTR</b> Pointer to a null-terminated Unicode string containing the URL of the item being
    ///               accessed.
    ///    pAuthenticationInfo = Type: <b>AUTHENTICATION_INFO*</b> Pointer to an AUTHENTICATION_INFO structure that contains authentication
    ///                          information necessary for accessing this item in the content source.
    ///    pIncrementalAccessInfo = Type: <b>INCREMENTAL_ACCESS_INFO*</b> Pointer to an INCREMENTAL_ACCESS_INFO structure that contains
    ///                             incremental access information, such as the last time the file was accessed by the gatherer.
    ///    pItemInfo = Type: <b>ITEM_INFO*</b> Pointer to an ITEM_INFO structure that contains information about the URL item, such
    ///                as the name of the item's workspace catalog.
    ///    ppAccessor = Type: <b>IUrlAccessor**</b> Receives the address of a pointer to the IUrlAccessor object created by this
    ///                 method. This object contains information about the URL item, such as the item's file name.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateAccessor(const(PWSTR) pcwszURL, AUTHENTICATION_INFO* pAuthenticationInfo, 
                           INCREMENTAL_ACCESS_INFO* pIncrementalAccessInfo, ITEM_INFO* pItemInfo, 
                           IUrlAccessor* ppAccessor);
    ///Closes a previously created IUrlAccessor object.
    ///Params:
    ///    pAccessor = Type: <b>IUrlAccessor*</b> Pointer to the IUrlAccessor object that was used to process the current URL item.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CloseAccessor(IUrlAccessor pAccessor);
    ///Shuts down the protocol handler.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ShutDown();
}

///Provides methods for invoking, initializing, and managing IUrlAccessor objects. Methods in this interface are called
///by the protocol host when processing URLs from the gatherer. The protocol handler implements the protocol for
///accessing a content source in its native format. Use this interface to implement a custom protocol handler to expand
///the data sources that can be indexed.
@GUID("7789F0B2-B5B2-4722-8B65-5DBD150697A9")
interface ISearchProtocol2 : ISearchProtocol
{
    ///Creates and initializes an IUrlAccessor object. This method has the same basic functionality as the
    ///ISearchProtocol::CreateAccessor method, but it includes an additional <b>pUserData</b> parameter to supply
    ///additional data to the protocol handler.
    ///Params:
    ///    pcwszURL = Type: <b>LPCWSTR</b> Pointer to a null-terminated Unicode string containing the URL of the item being
    ///               accessed.
    ///    pAuthenticationInfo = Type: <b>AUTHENTICATION_INFO*</b> Pointer to an AUTHENTICATION_INFO structure that contains authentication
    ///                          information necessary for accessing this item in the content source.
    ///    pIncrementalAccessInfo = Type: <b>INCREMENTAL_ACCESS_INFO*</b> Pointer to an INCREMENTAL_ACCESS_INFO structure that contains
    ///                             incremental access information, such as the last time the file was accessed by the gatherer.
    ///    pItemInfo = Type: <b>ITEM_INFO*</b> Pointer to an ITEM_INFO structure that contains information about the URL item, such
    ///                as the name of the item's workspace catalog.
    ///    pUserData = Type: <b>const BLOB*</b> Pointer to user information. This data can be whatever the notification originator
    ///                decides. If the protocol handler implements this interface, it will receive this data. Not all notifications
    ///                have this blob set.
    ///    ppAccessor = Type: <b>IUrlAccessor**</b> Receives the address of a pointer to the IUrlAccessor object created by this
    ///                 method. This object contains information about the URL item, such as the item's file name.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateAccessorEx(const(PWSTR) pcwszURL, AUTHENTICATION_INFO* pAuthenticationInfo, 
                             INCREMENTAL_ACCESS_INFO* pIncrementalAccessInfo, ITEM_INFO* pItemInfo, 
                             const(BLOB)* pUserData, IUrlAccessor* ppAccessor);
}

///Provides methods for a protocol handler's IUrlAccessor object to query the Filter Daemon for the appropriate filter
///for the URL item.
@GUID("0B63E385-9CCC-11D0-BCDB-00805FCCCE04")
interface IProtocolHandlerSite : IUnknown
{
    ///Retrieves the appropriate IFilteraccording to the supplied parameters.
    ///Params:
    ///    pclsidObj = Type: <b>CLSID*</b> Pointer to the CLSID of the document type from the registry. This is used for items with
    ///                embedded documents to indicate the appropriate IFilterto use for that embedded document.
    ///    pcwszContentType = Type: <b>LPCWSTR</b> Pointer to a null-terminated Unicode string that contains the type of the document. This
    ///                       is used to retrieve IFilter<b>s</b> that are mapped according to MIME type.
    ///    pcwszExtension = Type: <b>LPCWSTR</b> Pointer to a null-terminated Unicode string that contains the file name extension,
    ///                     without the preceding period. This is used to retrieve IFilterobjects that are mapped according to the file
    ///                     name extension.
    ///    ppFilter = Type: <b>IFilter**</b> Receives the address of a pointer to the IFilterthat the protocol handler uses.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetFilter(GUID* pclsidObj, const(PWSTR) pcwszContentType, const(PWSTR) pcwszExtension, 
                      IFilter* ppFilter);
}

///Provides methods for manipulating a search root. Changes to property members are applied to any URL that falls under
///the search root. A URL falls under a search root if it matches the search root URL or is a hierarchical child of that
///URL.
@GUID("04C18CCF-1F57-4CBD-88CC-3900F5195CE3")
interface ISearchRoot : IUnknown
{
    ///Not implemented.
    ///Params:
    ///    pszTaskArg = Type: <b>LPCWSTR</b> Pointer to a null-terminated, Unicode buffer that contains the name of the task to be
    ///                 inserted.
    HRESULT put_Schedule(const(PWSTR) pszTaskArg);
    ///Not implemented.
    ///Params:
    ///    ppszTaskArg = Type: <b>LPWSTR*</b> Returns the address of a pointer to a null-terminated, Unicode buffer that contains the
    ///                  name of the task.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT get_Schedule(PWSTR* ppszTaskArg);
    ///Sets the URL of the current search root.
    ///Params:
    ///    pszURL = Type: <b>LPCWSTR</b> Pointer to a null-terminated, Unicode buffer that contains the URL of this search root.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT put_RootURL(const(PWSTR) pszURL);
    ///Gets the URL of the starting point for this search root.
    ///Params:
    ///    ppszURL = Type: <b>LPWSTR*</b> A null-terminated, Unicode buffer that contains the URL.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT get_RootURL(PWSTR* ppszURL);
    ///Sets a value that indicates whether the search is rooted on a hierarchical tree structure.
    ///Params:
    ///    fIsHierarchical = Type: <b>BOOL</b> <b>TRUE</b> for hierarchical tree structures, <b>FALSE</b> for non-hierarchical systems
    ///                      such as websites.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT put_IsHierarchical(BOOL fIsHierarchical);
    ///Gets a value that indicates whether the search is rooted on a hierarchical tree structure.
    ///Params:
    ///    pfIsHierarchical = Type: <b>BOOL*</b> On return, points to <b>TRUE</b> for hierarchical tree structures, and <b>FALSE</b> for
    ///                       other structures such as websites.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT get_IsHierarchical(BOOL* pfIsHierarchical);
    ///Sets a value that indicates whether the search engine is notified (by protocol handlers or other applications)
    ///about changes to the URLs under the search root.
    ///Params:
    ///    fProvidesNotifications = Type: <b>BOOL</b> <b>TRUE</b> if notifications are provided; otherwise, <b>FALSE</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT put_ProvidesNotifications(BOOL fProvidesNotifications);
    ///Gets a value that indicates whether the search engine is notified (by protocol handlers or other applications)
    ///about changes to the URLs under the search root.
    ///Params:
    ///    pfProvidesNotifications = Type: <b>BOOL*</b> On return, points to <b>TRUE</b> if this search root provides notifications; otherwise,
    ///                              <b>FALSE</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT get_ProvidesNotifications(BOOL* pfProvidesNotifications);
    ///Sets a value that indicates whether this search root should be indexed only by notification and not crawled.
    ///Params:
    ///    fUseNotificationsOnly = Type: <b>BOOL</b> <b>TRUE</b> if this search root should be indexed only by notification; otherwise,
    ///                            <b>FALSE</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT put_UseNotificationsOnly(BOOL fUseNotificationsOnly);
    ///Gets a value that indicates whether this search root should be indexed only by notification and not crawled.
    ///Params:
    ///    pfUseNotificationsOnly = Type: <b>BOOL*</b> On return, points to <b>TRUE</b> if this search root should be indexed only by
    ///                             notification; otherwise, <b>FALSE</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT get_UseNotificationsOnly(BOOL* pfUseNotificationsOnly);
    ///Sets the enumeration depth for this search root.
    ///Params:
    ///    dwDepth = Type: <b>DWORD</b> The depth (number of levels) to enumerate.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT put_EnumerationDepth(uint dwDepth);
    ///Gets the enumeration depth for this search root.
    ///Params:
    ///    pdwDepth = Type: <b>DWORD*</b> A pointer to the depth (number of levels) to enumerate.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT get_EnumerationDepth(uint* pdwDepth);
    ///<p class="CCE_Message">[<b>put_HostDepth</b> may be altered or unavailable in subsequent versions of the
    ///operating system or product.] Sets a value that indicates how far into a host tree to crawl when indexing.
    ///Params:
    ///    dwDepth = Type: <b>DWORD</b> The depth (number of levels) to crawl a host tree.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT put_HostDepth(uint dwDepth);
    ///<p class="CCE_Message">[<b>get_HostDepth</b> may be altered or unavailable in subsequent versions of the
    ///operating system or product.] Gets a value that indicates how far into a host tree to crawl when indexing.
    ///Params:
    ///    pdwDepth = Type: <b>DWORD*</b> On return, points to the depth (number of levels) to crawl in the host tree.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT get_HostDepth(uint* pdwDepth);
    ///Sets a <b>BOOL</b> value that indicates whether the search engine should follow subdirectories and hierarchical
    ///scopes for this search root.
    ///Params:
    ///    fFollowDirectories = Type: <b>BOOL</b> <b>TRUE</b> to follow directories or hierarchical scopes, otherwise <b>FALSE</b>. The
    ///                         default for this value is <b>TRUE</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT put_FollowDirectories(BOOL fFollowDirectories);
    ///Gets a <b>BOOL</b> value that indicates whether the search engine follows subdirectories and hierarchical scopes.
    ///Params:
    ///    pfFollowDirectories = Type: <b>BOOL*</b> On return, points to <b>TRUE</b> if the search engine follows subdirectories and
    ///                          hierarchical scopes; otherwise, <b>FALSE</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT get_FollowDirectories(BOOL* pfFollowDirectories);
    ///Sets the type of authentication required to access the URLs under this search root.
    ///Params:
    ///    authType = Type: <b>AUTH_TYPE</b> A value from the AUTH_TYPE enumeration that indicates the authentication type.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT put_AuthenticationType(AUTH_TYPE authType);
    ///Retrieves the type of authentication needed to access the URLs under this this search root.
    ///Params:
    ///    pAuthType = Type: <b>AUTH_TYPE*</b> A pointer to a value from the AUTH_TYPE enumeration that indicates the authentication
    ///                type required to access URLs under this search root.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT get_AuthenticationType(AUTH_TYPE* pAuthType);
    ///Not implemented.
    ///Params:
    ///    pszUser = This parameter is unused.
    HRESULT put_User(const(PWSTR) pszUser);
    ///Not implemented.
    ///Params:
    ///    ppszUser = This parameter is unused.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT get_User(PWSTR* ppszUser);
    ///Not implemented.
    ///Params:
    ///    pszPassword = This parameter is unused.
    HRESULT put_Password(const(PWSTR) pszPassword);
    ///Not implemented.
    ///Params:
    ///    ppszPassword = This parameter is unused.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT get_Password(PWSTR* ppszPassword);
}

///Provides methods to enumerate the search roots of a catalog, for example, SystemIndex.
@GUID("AB310581-AC80-11D1-8DF3-00C04FB6EF52")
interface IEnumSearchRoots : IUnknown
{
    ///Retrieves the specified number of ISearchRoot elements.
    ///Params:
    ///    celt = Type: <b>ULONG</b> The number of elements to retrieve.
    ///    rgelt = Type: <b>ISearchRoot**</b> Retrieves a pointer to an array of ISearchRoot elements.
    ///    pceltFetched = Type: <b>ULONG*</b> Retrieves a pointer to the actual number of elements retrieved. Can be <b>NULL</b> if
    ///                   <i>celt</i> == 1; otherwise it must not be <b>NULL</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful, S_FALSE if there were not enough items left in the
    ///    enumeration to be returned, or an error value otherwise.
    ///    
    HRESULT Next(uint celt, ISearchRoot* rgelt, uint* pceltFetched);
    ///Skips the specified number of elements.
    ///Params:
    ///    celt = Type: <b>ULONG</b> The number of elements to skip.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful, S_FALSE if there were not enough items left in the
    ///    enumeration to skip, or an error value.
    ///    
    HRESULT Skip(uint celt);
    ///Moves the internal counter to the beginning of the list so a subsequent call to IEnumSearchRoots::Next retrieves
    ///from the beginning.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Reset();
    ///Creates a copy of the IEnumSearchRoots object with the same contents and state as the current one.
    ///Params:
    ///    ppenum = Type: <b>IEnumSearchRoots**</b> Returns a pointer to the new IEnumSearchRoots object. The calling application
    ///             must free the new object by calling its IUnknown::Release method.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Clone(IEnumSearchRoots* ppenum);
}

///Provides methods to define scope rules for crawling and indexing.
@GUID("AB310581-AC80-11D1-8DF3-00C04FB6EF53")
interface ISearchScopeRule : IUnknown
{
    ///Gets the pattern or URL for the rule. The scope rules determine what URLs or paths to include or exclude.
    ///Params:
    ///    ppszPatternOrURL = Type: <b>LPWSTR*</b> On return, contains the address of a pointer to a null-terminated, Unicode buffer that
    ///                       contains the pattern or URL string.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT get_PatternOrURL(PWSTR* ppszPatternOrURL);
    ///Gets a value identifying whether this rule is an inclusion rule. Inclusion rules identify scopes that should be
    ///included in the crawl scope.
    ///Params:
    ///    pfIsIncluded = Type: <b>BOOL*</b> On return, points to <b>TRUE</b> if this rule is an inclusion rule, <b>FALSE</b>
    ///                   otherwise.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT get_IsIncluded(BOOL* pfIsIncluded);
    ///Gets a value that identifies whether this is a default rule.
    ///Params:
    ///    pfIsDefault = Type: <b>BOOL*</b> On return, points to the <b>TRUE</b> for default rules and <b>FALSE</b> otherwise.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT get_IsDefault(BOOL* pfIsDefault);
    ///Not supported. This method returns E_InvalidArg when called.
    ///Params:
    ///    pFollowFlags = Type: <b>DWORD*</b> Returns a pointer to a value that contains the follow flags.
    HRESULT get_FollowFlags(uint* pFollowFlags);
}

///Enumerates scope rules.
@GUID("AB310581-AC80-11D1-8DF3-00C04FB6EF54")
interface IEnumSearchScopeRules : IUnknown
{
    ///Retrieves the specified number of ISearchScopeRule elements.
    ///Params:
    ///    celt = Type: <b>ULONG</b> The number of elements to retrieve.
    ///    pprgelt = Type: <b>ISearchScopeRule**</b> On return, contains a pointer to an array of ISearchScopeRule elements.
    ///    pceltFetched = Type: <b>ULONG*</b> On return, contains a pointer to the actual number of elements retrieved. Can be
    ///                   <b>NULL</b> if <i>celt</i> == 1, otherwise it must not be <b>NULL</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful, S_FALSE if there were not enough items left in the
    ///    enumeration to be returned, or an error value.
    ///    
    HRESULT Next(uint celt, ISearchScopeRule* pprgelt, uint* pceltFetched);
    ///Skips the specified number of elements.
    ///Params:
    ///    celt = Type: <b>ULONG</b> The number of elements to skip.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful, S_FALSE if there were not enough items left in the
    ///    enumeration to skip, or an error value.
    ///    
    HRESULT Skip(uint celt);
    ///Moves the internal counter to the beginning of the list so that a subsequent call to IEnumSearchScopeRules::Next
    ///retrieves from the beginning.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Reset();
    ///Creates a copy of this IEnumSearchScopeRules object with the same contents and state as the current one.
    ///Params:
    ///    ppenum = Type: <b>IEnumSearchScopeRules**</b> On return, contains a pointer to the cloned IEnumSearchScopeRules
    ///             object. The calling application must free the new object by calling its IUnknown::Release method.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Clone(IEnumSearchScopeRules* ppenum);
}

///Provides methods that notify the search engine of containers to crawl and/or watch, and items under those containers
///to include or exclude when crawling or watching.
@GUID("AB310581-AC80-11D1-8DF3-00C04FB6EF55")
interface ISearchCrawlScopeManager : IUnknown
{
    ///Adds a URL as the default scope for this rule.
    ///Params:
    ///    pszURL = Type: <b>LPCWSTR</b> Pointer to a null-terminated, Unicode buffer that contains the URL to use as a default
    ///             scope.
    ///    fInclude = Type: <b>BOOL</b> <b>TRUE</b> if <i>pszUrl</i> should be included in indexing; <b>FALSE</b> if it should be
    ///               excluded.
    ///    fFollowFlags = Type: <b>DWORD</b> Sets the FOLLOW_FLAGS to specify whether to follow complex URLs and whether a URL is to be
    ///                   indexed or just followed.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AddDefaultScopeRule(const(PWSTR) pszURL, BOOL fInclude, uint fFollowFlags);
    ///Adds a new search root to the search engine.
    ///Params:
    ///    pSearchRoot = Type: <b>ISearchRoot*</b> An ISearchRoot describing the new search root to add.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AddRoot(ISearchRoot pSearchRoot);
    ///Removes a search root from the search engine.
    ///Params:
    ///    pszURL = Type: <b>LPCWSTR</b> The URL of a search root to be removed.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful; S_FALSE if the root is not found.
    ///    
    HRESULT RemoveRoot(const(PWSTR) pszURL);
    ///Returns an enumeration of all the roots of which this instance of the ISearchCrawlScopeManager is aware.
    ///Params:
    ///    ppSearchRoots = Type: <b>IEnumSearchRoots**</b> Returns a pointer to an IEnumSearchRoots interface.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful, S_FALSE if there are no roots to enumerate, or an error
    ///    value otherwise.
    ///    
    HRESULT EnumerateRoots(IEnumSearchRoots* ppSearchRoots);
    ///Adds a hierarchical scope to the search engine.
    ///Params:
    ///    pszURL = Type: <b>LPCWSTR</b> The URL of the scope to be added.
    ///    fInclude = Type: <b>BOOL</b> <b>TRUE</b> if this is an inclusion scope, <b>FALSE</b> if this is an exclusion scope.
    ///    fDefault = Type: <b>BOOL</b> <b>TRUE</b> if this is to be the default scope, <b>FALSE</b> if this is not a default
    ///               scope.
    ///    fOverrideChildren = Type: <b>BOOL</b> <b>TRUE</b> if this scope overrides all of the child URL rules, <b>FALSE</b> otherwise.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AddHierarchicalScope(const(PWSTR) pszURL, BOOL fInclude, BOOL fDefault, BOOL fOverrideChildren);
    ///Adds a new crawl scope rule when the user creates a new rule or adds a URL to be indexed.
    ///Params:
    ///    pszURL = Type: <b>LPCWSTR</b> The URL to be indexed.
    ///    fInclude = Type: <b>BOOL</b> <b>TRUE</b> if this should be included in all <i>pszUrl</i> searches; otherwise,
    ///               <b>FALSE</b>.
    ///    fOverrideChildren = Type: <b>BOOL</b> A <b>BOOL</b> value specifying whether child rules should be overridden. If set to
    ///                        <b>TRUE</b>, this essentially removes all child rules.
    ///    fFollowFlags = Type: <b>DWORD</b> Sets the FOLLOW_FLAGS to specify whether to follow complex URLs and whether a URL is to be
    ///                   indexed or just followed.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AddUserScopeRule(const(PWSTR) pszURL, BOOL fInclude, BOOL fOverrideChildren, uint fFollowFlags);
    ///Removes a scope rule from the search engine.
    ///Params:
    ///    pszRule = Type: <b>LPCWSTR</b> The URL or pattern of a scope rule to be removed.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful; returns S_FALSE if the scope rule is not found.
    ///    
    HRESULT RemoveScopeRule(const(PWSTR) pszRule);
    ///Returns an enumeration of all the scope rules of which this instance of the ISearchCrawlScopeManager interface is
    ///aware.
    ///Params:
    ///    ppSearchScopeRules = Type: <b>IEnumSearchScopeRules**</b> Returns a pointer to an IEnumSearchScopeRules interface.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful, S_FALSE if there are no rules to enumerate, or an error
    ///    value otherwise.
    ///    
    HRESULT EnumerateScopeRules(IEnumSearchScopeRules* ppSearchScopeRules);
    ///Identifies whether a given URL has a parent rule in scope.
    ///Params:
    ///    pszURL = Type: <b>LPCWSTR</b> A string containing the URL to check for a parent rule. The string can contain wildcard
    ///             characters, such as asterisks (*).
    ///    pfHasParentRule = Type: <b>BOOL*</b> <b>TRUE</b> if <i>pszURL</i> has a parent rule; otherwise, <b>FALSE</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT HasParentScopeRule(const(PWSTR) pszURL, BOOL* pfHasParentRule);
    ///Identifies whether a given URL has a child rule in scope.
    ///Params:
    ///    pszURL = Type: <b>LPCWSTR</b> A string containing the URL to check for a child rule. The string can contain wildcard
    ///             characters, such as asterisks (*).
    ///    pfHasChildRule = Type: <b>BOOL*</b> <b>TRUE</b> if <i>pszURL</i> has a child rule; otherwise, <b>FALSE</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT HasChildScopeRule(const(PWSTR) pszURL, BOOL* pfHasChildRule);
    ///Retrieves an indicator of whether the specified URL is included in the crawl scope.
    ///Params:
    ///    pszURL = Type: <b>LPCWSTR</b> A string containing the URL to check for inclusion in the crawl scope.
    ///    pfIsIncluded = Type: <b>BOOL*</b> A pointer to a <b>BOOL</b> value: <b>TRUE</b> if <i>pszURL</i> is included in the crawl
    ///                   scope; otherwise, <b>FALSE</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT IncludedInCrawlScope(const(PWSTR) pszURL, BOOL* pfIsIncluded);
    ///Retrieves an indicator of whether and why the specified URL is included in the crawl scope.
    ///Params:
    ///    pszURL = Type: <b>LPCWSTR</b> A string value indicating the URL to check for inclusion in the crawl scope.
    ///    pfIsIncluded = Type: <b>BOOL*</b> A pointer to a <b>BOOL</b> value: <b>TRUE</b> if <i>pszURL</i> is included in the crawl
    ///                   scope; otherwise, <b>FALSE</b>.
    ///    pReason = Type: <b>CLUSION_REASON*</b> Retrieves a pointer to a value from the CLUSION_REASON enumeration that
    ///              indicates the reason that the specified URL was included in or excluded from the crawl scope.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT IncludedInCrawlScopeEx(const(PWSTR) pszURL, BOOL* pfIsIncluded, CLUSION_REASON* pReason);
    ///Reverts to the default scopes.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT RevertToDefaultScopes();
    ///Commits all changes to the search engine.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SaveAll();
    ///Gets the version ID of the parent inclusion URL.
    ///Params:
    ///    pszURL = Type: <b>LPCWSTR</b> A string containing the current URL.
    ///    plScopeId = Type: <b>LONG*</b> On return, contains a pointer to the version ID of the parent inclusion URL for
    ///                <b>pszUrl</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetParentScopeVersionId(const(PWSTR) pszURL, int* plScopeId);
    ///Removes a default scope rule from the search engine.
    ///Params:
    ///    pszURL = Type: <b>LPCWSTR</b> A string identifying the URL or pattern of the default rule to be removed.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful, or an error otherwise.
    ///    
    HRESULT RemoveDefaultScopeRule(const(PWSTR) pszURL);
}

///Extends the functionality of the ISearchCrawlScopeManager interface. <b>ISearchCrawlScopeManager2</b> provides
///methods that notify the search engine of containers to crawl and/or watch, and items under those containers to
///include or exclude when crawling or watching.
@GUID("6292F7AD-4E19-4717-A534-8FC22BCD5CCD")
interface ISearchCrawlScopeManager2 : ISearchCrawlScopeManager
{
    ///Causes file mapping to be mapped into the address space of the calling process, and informs clients if the state
    ///of the Crawl Scope Manager (CSM) has changed.
    ///Params:
    ///    plVersion = Type: <b>LONG**</b> Receives a pointer to the address of a memory mapped file that contains the crawl scope
    ///                version.
    ///    phFileMapping = Type: <b>HANDLE*</b> Receives a pointer to the handle of the file mapping object, with read-only access, that
    ///                    was used to create the memory mapped file that contains the crawl scope version.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetVersion(int** plVersion, HANDLE* phFileMapping);
}

///Provides notifications for changes to indexed items. Also provides notification of the hierarchical scope that is
///being monitored for changed items.
@GUID("AB310581-AC80-11D1-8DF3-00C04FB6EF58")
interface ISearchItemsChangedSink : IUnknown
{
    ///Permits an index-managed notification source to add itself to a list of "monitored scopes".
    ///Params:
    ///    pszURL = Type: <b>LPCWSTR</b> A pointer to a null-terminated, Unicode string that is the start address for the scope
    ///             of monitoring.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT StartedMonitoringScope(const(PWSTR) pszURL);
    ///Not implemented.
    ///Params:
    ///    pszURL = Type: <b>LPCWSTR</b> The pointer to a null-terminated, Unicode string containing the start address for the
    ///             scope of monitoring.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT StoppedMonitoringScope(const(PWSTR) pszURL);
    ///Call this method to notify an indexer to re-index some changed items.
    ///Params:
    ///    dwNumberOfChanges = Type: <b>DWORD</b> The number of items that have changed.
    ///    rgDataChangeEntries = Type: <b>SEARCH_ITEM_CHANGE[]</b> An array of SEARCH_ITEM_CHANGE structures, describing the type of changes
    ///                          to and the paths or URLs of each item.
    ///    rgdwDocIds = Type: <b>DWORD[]</b> Receives a pointer to an array of document identifiers for the items that changed.
    ///    rghrCompletionCodes = Type: <b>HRESULT[]</b> Receives a pointer to an array of completion codes for <i>rgdwDocIds</i> indicating
    ///                          whether each item was accepted for indexing.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OnItemsChanged(uint dwNumberOfChanges, SEARCH_ITEM_CHANGE* rgDataChangeEntries, uint* rgdwDocIds, 
                           HRESULT** rghrCompletionCodes);
}

///Provides methods for passing change notifications to alert the indexer that items need to be updated.
@GUID("A2FFDF9B-4758-4F84-B729-DF81A1A0612F")
interface ISearchPersistentItemsChangedSink : IUnknown
{
    ///Called by a notifications provider to notify the indexer to monitor changes to items within a specified
    ///hierarchical scope.
    ///Params:
    ///    pszURL = Type: <b>LPCWSTR</b> Pointer to a null-terminated Unicode string that is the start address for the scope to
    ///             be monitored.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT StartedMonitoringScope(const(PWSTR) pszURL);
    ///Called by a notifications provider to notify the indexer to stop monitoring changes to items within a specified
    ///hierarchical scope.
    ///Params:
    ///    pszURL = Type: <b>LPCWSTR</b> Pointer to a null-terminated Unicode string that is the address for the scope to stop
    ///             monitoring.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT StoppedMonitoringScope(const(PWSTR) pszURL);
    ///Notifies the indexer to index changed items.
    ///Params:
    ///    dwNumberOfChanges = Type: <b>DWORD</b> The number of changes being reported.
    ///    DataChangeEntries = Type: <b>SEARCH_ITEM_PERSISTENT_CHANGE[]</b> An array of structures of type SEARCH_ITEM_PERSISTENT_CHANGE
    ///                        identifying the details for each change.
    ///    hrCompletionCodes = Type: <b>HRESULT[]</b> Indicates whether each URL was accepted for indexing.
    HRESULT OnItemsChanged(uint dwNumberOfChanges, SEARCH_ITEM_PERSISTENT_CHANGE* DataChangeEntries, 
                           HRESULT** hrCompletionCodes);
}

///Not implemented.
@GUID("AB310581-AC80-11D1-8DF3-00C04FB6EF65")
interface ISearchViewChangedSink : IUnknown
{
    ///Not implemented.
    ///Params:
    ///    pdwDocID = This parameter is unused.
    ///    pChange = This parameter is unused.
    ///    pfInView = This parameter is unused.
    HRESULT OnChange(int* pdwDocID, SEARCH_ITEM_CHANGE* pChange, BOOL* pfInView);
}

///Provides methods the Search service uses to send updates on catalog and index status to notification providers.
@GUID("B5702E61-E75C-4B64-82A1-6CB4F832FCCF")
interface ISearchNotifyInlineSite : IUnknown
{
    ///Called by the search service to notify the client when the status of a particular document or item changes.
    ///Params:
    ///    sipStatus = Type: <b>SEARCH_INDEXING_PHASE</b> The SEARCH_INDEXING_PHASE status of each document in the array being sent.
    ///    dwNumEntries = Type: <b>DWORD</b> The number of entries in <i>rgItemStatusEntries</i>.
    ///    rgItemStatusEntries = Type: <b>SEARCH_ITEM_INDEXING_STATUS[]</b> An array of SEARCH_ITEM_INDEXING_STATUS structures containing
    ///                          status update information.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OnItemIndexedStatusChange(SEARCH_INDEXING_PHASE sipStatus, uint dwNumEntries, 
                                      SEARCH_ITEM_INDEXING_STATUS* rgItemStatusEntries);
    ///Called by the search service to notify a client when the status of the catalog changes.
    ///Params:
    ///    guidCatalogResetSignature = Type: <b>REFGUID</b> A GUID representing the catalog reset. If this GUID changes, all notifications must be
    ///                                resent.
    ///    guidCheckPointSignature = Type: <b>REFGUID</b> A GUID representing the last checkpoint restored. If this GUID changes, all
    ///                              notifications accumulated since the last saved checkpoint must be resent.
    ///    dwLastCheckPointNumber = Type: <b>DWORD</b> A number indicating the last checkpoint saved.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OnCatalogStatusChange(const(GUID)* guidCatalogResetSignature, const(GUID)* guidCheckPointSignature, 
                                  uint dwLastCheckPointNumber);
}

///Provides methods to manage a search catalog for purposes such as re-indexing or setting timeouts.
@GUID("AB310581-AC80-11D1-8DF3-00C04FB6EF50")
interface ISearchCatalogManager : IUnknown
{
    ///Gets the name of the current catalog.
    ///Params:
    ///    pszName = Type: <b>LPCWSTR*</b> Receives a pointer to a null-terminated Unicode buffer that contains the name of the
    ///              current catalog.
    HRESULT get_Name(PWSTR* pszName);
    ///Not implemented.
    ///Params:
    ///    pszName = Type: <b>LPCWSTR</b> The name of the parameter to be retrieved.
    ///    ppValue = Type: <b>PROPVARIANT**</b> Receives a pointer to the value of the parameter.
    HRESULT GetParameter(const(PWSTR) pszName, PROPVARIANT** ppValue);
    ///Sets a name/value parameter for the catalog.
    ///Params:
    ///    pszName = Type: <b>LPCWSTR</b> The name of the parameter to change.
    ///    pValue = Type: <b>PROPVARIANT*</b> A pointer to the new value for the parameter.
    HRESULT SetParameter(const(PWSTR) pszName, PROPVARIANT* pValue);
    ///Gets the status of the catalog.
    ///Params:
    ///    pStatus = Type: <b>CatalogStatus*</b> Receives a pointer to a value from the CatalogStatus enumeration. If
    ///              <i>pStatus</i> is <i>CATALOG_STATUS_PAUSED</i>, further information can be obtained from the
    ///              <i>pPausedReason</i> parameter.
    ///    pPausedReason = Type: <b>CatalogPausedReason*</b> Receives a pointer to a value from the CatalogPausedReason enumeration
    ///                    describing why the catalog is paused. If the catalog status is not <i>CATALOG_STATUS_PAUSED</i>, this
    ///                    parameter receives the value <i>CATALOG_PAUSED_REASON_NONE</i>.
    HRESULT GetCatalogStatus(CatalogStatus* pStatus, CatalogPausedReason* pPausedReason);
    ///Resets the underlying catalog by rebuilding the databases and performing a full indexing.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Reset();
    ///Re-indexes all URLs in the catalog.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Reindex();
    ///Reindexes all items that match the provided pattern. This method was not implemented prior to Windows 7.
    ///Params:
    ///    pszPattern = Type: <b>LPCWSTR</b> A pointer to the pattern to be matched for reindexing. The pattern can be a standard
    ///                 pattern such as <code>*.pdf</code> or a pattern in the form of a URL such as
    ///                 <code>file:///c:\MyStuff\*.pdf</code>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ReindexMatchingURLs(const(PWSTR) pszPattern);
    ///Re-indexes all URLs from a specified root.
    ///Params:
    ///    pszRootURL = Type: <b>LPCWSTR</b> Pointer to a null-terminated, Unicode buffer that contains the URL on which the search
    ///                 is rooted. This URL must be a search root previously registered with ISearchCrawlScopeManager::AddRoot.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ReindexSearchRoot(const(PWSTR) pszRootURL);
    ///Sets the connection time-out value in the TIMEOUT_INFO structure, in seconds.
    ///Params:
    ///    dwConnectTimeout = Type: <b>DWORD</b> The number of seconds to wait for a connection response.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT put_ConnectTimeout(uint dwConnectTimeout);
    ///Gets the connection time-out value for connecting to a store for indexing.
    ///Params:
    ///    pdwConnectTimeout = Type: <b>DWORD*</b> Receives a pointer to the time-out value, in seconds, from the TIMEOUT_INFO structure.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT get_ConnectTimeout(uint* pdwConnectTimeout);
    ///Sets the time-out value for data transactions between the indexer and the search filter host. This information is
    ///stored in the TIMEOUT_INFO structure and is measured in seconds.
    ///Params:
    ///    dwDataTimeout = Type: <b>DWORD</b> The number of seconds that the indexer will wait between chunks of data.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT put_DataTimeout(uint dwDataTimeout);
    ///Gets the data time-out value, in seconds, for data transactions between the indexer and the search filter host.
    ///This value is contained in a TIMEOUT_INFO structure.
    ///Params:
    ///    pdwDataTimeout = Type: <b>DWORD*</b> Receives a pointer to the TIMEOUT_INFO value for data transactions (the amount of time to
    ///                     wait for a data transaction).
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT get_DataTimeout(uint* pdwDataTimeout);
    ///Gets the number of items in the catalog.
    ///Params:
    ///    plCount = Type: <b>LONG*</b> Receives a pointer to the number of items in the catalog.
    HRESULT NumberOfItems(int* plCount);
    ///Gets the number of items to be indexed within the catalog.
    ///Params:
    ///    plIncrementalCount = Type: <b>LONG*</b> Receives a pointer to the number of items to be indexed in the next incremental index.
    ///    plNotificationQueue = Type: <b>LONG*</b> Receives a pointer to the number of items in the notification queue.
    ///    plHighPriorityQueue = Type: <b>LONG*</b> Receives a pointer to the number of items in the high-priority queue. Items in the
    ///                          <i>plHighPriorityQueue</i> are indexed first.
    HRESULT NumberOfItemsToIndex(int* plIncrementalCount, int* plNotificationQueue, int* plHighPriorityQueue);
    ///Gets the URL that is currently being indexed. If no indexing is currently in process, <i>pszUrl</i> is set to
    ///<b>NULL</b>.
    ///Params:
    ///    pszUrl = Type: <b>LPWSTR*</b> Receives a pointer to the URL that is currently being indexed.
    HRESULT URLBeingIndexed(PWSTR* pszUrl);
    ///Not implemented.
    ///Params:
    ///    pszURL = Type: <b>LPCWSTR</b>
    ///    pdwState = Type: <b>DWORD*</b>
    HRESULT GetURLIndexingState(const(PWSTR) pszURL, uint* pdwState);
    ///Gets the change notification event sink interface for a client. This method is used by client applications and
    ///protocol handlers to notify the indexer of changes.
    ///Params:
    ///    ppISearchPersistentItemsChangedSink = Type: <b>ISearchPersistentItemsChangedSink**</b> Receives the address of a pointer to a new
    ///                                          ISearchPersistentItemsChangedSink interface for this catalog.
    HRESULT GetPersistentItemsChangedSink(ISearchPersistentItemsChangedSink* ppISearchPersistentItemsChangedSink);
    ///Not implemented.
    ///Params:
    ///    pszView = Type: <b>LPCWSTR</b> A pointer to the name of the view.
    ///    pViewChangedSink = Type: <b>ISearchViewChangedSink*</b> Pointer to the ISearchViewChangedSink object to receive notifications.
    ///    pdwCookie = Type: <b>DWORD*</b>
    HRESULT RegisterViewForNotification(const(PWSTR) pszView, ISearchViewChangedSink pViewChangedSink, 
                                        uint* pdwCookie);
    ///Gets the change notification sink interface.
    ///Params:
    ///    pISearchNotifyInlineSite = Type: <b>ISearchNotifyInlineSite*</b> A pointer to your ISearchNotifyInlineSite interface.
    ///    riid = Type: <b>REFIID</b> The UUID of the ISearchItemsChangedSink interface.
    ///    ppv = Type: <b>void*</b> Receives a pointer to the ISearchItemsChangedSink interface.
    ///    pGUIDCatalogResetSignature = Type: <b>GUID*</b> Receives a pointer to the GUID representing the catalog reset. If this GUID changes, all
    ///                                 notifications must be resent.
    ///    pGUIDCheckPointSignature = Type: <b>GUID*</b> Receives a pointer to the GUID representing a checkpoint.
    ///    pdwLastCheckPointNumber = Type: <b>DWORD*</b> Receives a pointer to the number indicating the last checkpoint to be saved.
    HRESULT GetItemsChangedSink(ISearchNotifyInlineSite pISearchNotifyInlineSite, const(GUID)* riid, void** ppv, 
                                GUID* pGUIDCatalogResetSignature, GUID* pGUIDCheckPointSignature, 
                                uint* pdwLastCheckPointNumber);
    ///Not implemented.
    ///Params:
    ///    dwCookie = Type: <b>DWORD</b>
    HRESULT UnregisterViewForNotification(uint dwCookie);
    ///Not implemented.
    ///Params:
    ///    pszExtension = Type: <b>LPCWSTR</b>
    ///    fExclude = Type: <b>BOOL</b>
    HRESULT SetExtensionClusion(const(PWSTR) pszExtension, BOOL fExclude);
    ///Not implemented.
    ///Params:
    ///    ppExtensions = Type: <b>IEnumString**</b> Returns the address of a pointer to an enumerated list of extensions being
    ///                   excluded.
    HRESULT EnumerateExcludedExtensions(IEnumString* ppExtensions);
    ///Gets the ISearchQueryHelper interface for the current catalog.
    ///Params:
    ///    ppSearchQueryHelper = Type: <b>ISearchQueryHelper**</b> Receives the address of a pointer to a new instance of the
    ///                          ISearchQueryHelper interface with default settings.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetQueryHelper(ISearchQueryHelper* ppSearchQueryHelper);
    ///Sets a value that determines whether the catalog is sensitive to diacritics. A diacritic is a mark added to a
    ///letter to indicate a special phonetic value or pronunciation.
    ///Params:
    ///    fDiacriticSensitive = Type: <b>BOOL</b> A Boolean value that determines whether the catalog is sensitive to diacritics. <b>TRUE</b>
    ///                          if the catalog is sensitive to and recognizes diacritics; otherwise, <b>FALSE</b>.
    HRESULT put_DiacriticSensitivity(BOOL fDiacriticSensitive);
    ///Gets a value that indicates whether the catalog is sensitive to diacritics. A diacritic is a mark added to a
    ///letter to indicate a special phonetic value or pronunciation.
    ///Params:
    ///    pfDiacriticSensitive = Type: <b>BOOL*</b> Receives a pointer to a Boolean value that indicates whether the catalog is sensitive to
    ///                           diacritics. <b>TRUE</b> if the catalog is sensitive to and recognizes diacritics; otherwise, <b>FALSE</b>.
    HRESULT get_DiacriticSensitivity(BOOL* pfDiacriticSensitive);
    ///Gets an ISearchCrawlScopeManager interface for this search catalog.
    ///Params:
    ///    ppCrawlScopeManager = Type: <b>ISearchCrawlScopeManager**</b> Receives a pointer to a new ISearchCrawlScopeManager interface.
    HRESULT GetCrawlScopeManager(ISearchCrawlScopeManager* ppCrawlScopeManager);
}

///Extends the ISearchCatalogManager interface to manage a search catalog, for purposes such as re-indexing or setting
///timeouts. Applications can use this interface to attempt to reindex items that failed to be indexed previously, using
///the PrioritizeMatchingURLs.
@GUID("7AC3286D-4D1D-4817-84FC-C1C85E3AF0D9")
interface ISearchCatalogManager2 : ISearchCatalogManager
{
    ///Instructs the indexer to give a higher priority to indexing items that have URLs that match a specified pattern.
    ///These items will then have a higher priority than other indexing tasks.
    ///Params:
    ///    pszPattern = Type: <b>LPCWSTR</b> A string specifying the URL pattern that defines items that failed indexing and need
    ///                 re-indexing.
    ///    dwPrioritizeFlags = Type: <b>PRIORITIZE_FLAGS</b> A value from the PRIORITIZE_FLAGS enumeration that specifies how to process
    ///                        items that the indexer has failed to index.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful, or an error value otherwise.
    ///    
    HRESULT PrioritizeMatchingURLs(const(PWSTR) pszPattern, int dwPrioritizeFlags);
}

///Provides methods for building a query from user input, converting a query to Windows Search SQL, and obtaining a
///connection string to initialize a connection to the Window Search index.
@GUID("AB310581-AC80-11D1-8DF3-00C04FB6EF63")
interface ISearchQueryHelper : IUnknown
{
    ///Returns the OLE DB connection string for the Window Search index.
    ///Params:
    ///    pszConnectionString = Type: <b>LPWSTR*</b> Receives a pointer to a null-terminated Unicode string that is a valid OLE DB connection
    ///                          string. This connection string can be used to initialize a connection to the Windows Search index and submit
    ///                          the SQL query returned by ISearchQueryHelper::GenerateSQLFromUserQuery.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT get_ConnectionString(PWSTR* pszConnectionString);
    ///Sets the language code identifier (LCID) of the query.
    ///Params:
    ///    lcid = Type: <b>LCID</b> Sets the LCID of the query.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT put_QueryContentLocale(uint lcid);
    ///Gets the language code identifier (LCID) for the query.
    ///Params:
    ///    plcid = Type: <b>LCID*</b> Receives a pointer to the locale identifier used.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT get_QueryContentLocale(uint* plcid);
    ///Sets the language code identifier (LCID) for the locale to use when parsing Advanced Query Syntax (AQS) keywords.
    ///Params:
    ///    lcid = Type: <b>LCID</b> Sets the LCID for the locale to use when parsing Advanced Query Syntax (AQS) keywords.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT put_QueryKeywordLocale(uint lcid);
    ///Gets the language code identifier (LCID) for the locale to use when parsing Advanced Query Syntax (AQS) keywords.
    ///Params:
    ///    plcid = Type: <b>LCID*</b> Receives a pointer to the LCID for the locale to use when parsing Advanced Query Syntax
    ///            (AQS) keywords.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT get_QueryKeywordLocale(uint* plcid);
    ///Sets a value that specifies how query terms are to be expanded.
    ///Params:
    ///    expandTerms = Type: <b>SEARCH_TERM_EXPANSION</b> Value from the SEARCH_TERM_EXPANSION enumeration that specifies the search
    ///                  term expansion. If not set, the default value is SEARCH_TERM_PREFIX_ALL.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT put_QueryTermExpansion(SEARCH_TERM_EXPANSION expandTerms);
    ///Gets the value that specifies how query terms are to be expanded.
    ///Params:
    ///    pExpandTerms = Type: <b>SEARCH_TERM_EXPANSION*</b> Receives a pointer to a value from the SEARCH_TERM_EXPANSION enumeration
    ///                   that specifies the query term expansion.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT get_QueryTermExpansion(SEARCH_TERM_EXPANSION* pExpandTerms);
    ///Sets the syntax of the query.
    ///Params:
    ///    querySyntax = Type: <b>SEARCH_QUERY_SYNTAX</b> Flag that specifies the search query syntax. For a list of possible values,
    ///                  see the description of the SEARCH_QUERY_SYNTAX enumerated type.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT put_QuerySyntax(SEARCH_QUERY_SYNTAX querySyntax);
    ///Gets the syntax of the query.
    ///Params:
    ///    pQuerySyntax = Type: <b>SEARCH_QUERY_SYNTAX*</b> Receives a pointer to a value from the SEARCH_QUERY_SYNTAX enumeration.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT get_QuerySyntax(SEARCH_QUERY_SYNTAX* pQuerySyntax);
    ///Sets the properties to include in the query if search terms do not explicitly specify properties.
    ///Params:
    ///    pszContentProperties = Type: <b>LPCWSTR</b> Pointer to a comma-delimited, null-terminated Unicode string of one or more properties.
    ///                           Separate column specifiers with commas: "Content,DocAuthor". Set <i>ppszContentProperties</i> to <b>NULL</b>
    ///                           to use all properties.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT put_QueryContentProperties(const(PWSTR) pszContentProperties);
    ///Gets the list of properties included in the query when search terms do not explicitly specify a property.
    ///Params:
    ///    ppszContentProperties = Type: <b>LPWSTR*</b> Receives a pointer to a comma-delimited, null-terminated Unicode string of content
    ///                            properties to search. If <i>ppszContentProperties</i> is <b>NULL</b>, all properties are searched.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT get_QueryContentProperties(PWSTR* ppszContentProperties);
    ///Sets the columns (or properties) requested in the select statement.
    ///Params:
    ///    pszSelectColumns = Type: <b>LPCWSTR</b> Pointer to a comma-delimited, null-terminated Unicode string that specifies one or more
    ///                       columns in the property store. Separate multiple column specifiers with commas:
    ///                       "System.Document.Author,System.Document.Title".
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT put_QuerySelectColumns(const(PWSTR) pszSelectColumns);
    ///Gets the columns (or properties) requested in the SELECT statement of the query.
    ///Params:
    ///    ppszSelectColumns = Type: <b>LPWSTR*</b> Receives a pointer to a comma-delimited, null-terminated Unicode string that specifies
    ///                        the columns (or properties) to be returned from a query.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT get_QuerySelectColumns(PWSTR* ppszSelectColumns);
    ///Sets the restrictions appended to a query in WHERE clauses.
    ///Params:
    ///    pszRestrictions = Type: <b>LPCWSTR</b> Pointer to a comma-delimited null-terminated Unicode string that specifies one or more
    ///                      query restrictions appended to the query in generated WHERE clause.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT put_QueryWhereRestrictions(const(PWSTR) pszRestrictions);
    ///Gets the restrictions appended to a query in WHERE clauses.
    ///Params:
    ///    ppszRestrictions = Type: <b>LPWSTR*</b> Receives a pointer to a comma-delimited null-terminated Unicode string that specifies
    ///                       one or more restrictions appended to a query by WHERE clauses.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT get_QueryWhereRestrictions(PWSTR* ppszRestrictions);
    ///Sets the sort order for the query result set.
    ///Params:
    ///    pszSorting = Type: <b>LPCWSTR</b> A comma-delimited, null-terminated Unicode string that specifies the sort order.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT put_QuerySorting(const(PWSTR) pszSorting);
    ///Gets the sort order for the query result set.
    ///Params:
    ///    ppszSorting = Type: <b>LPWSTR*</b> Receives a pointer to a comma-delimited, null-terminated Unicode string representing the
    ///                  sort order.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT get_QuerySorting(PWSTR* ppszSorting);
    ///Generates a Structured Query Language (SQL) query based on a client-supplied query string expressed in either
    ///Advanced Query Syntax (AQS) or Natural Query Syntax (NQS).
    ///Params:
    ///    pszQuery = Type: <b>LPCWSTR</b> A pointer to a null-terminated Unicode string containing a query in AQS or NQS.
    ///    ppszSQL = Type: <b>LPWSTR*</b> Receives the address of a pointer to a SQL query string based on the query in the
    ///              <i>pszQuery</i> parameter.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GenerateSQLFromUserQuery(const(PWSTR) pszQuery, PWSTR* ppszSQL);
    ///Not implemented.
    ///Params:
    ///    itemID = Type: <b>int</b> The ItemID that is to be affected. The ItemID is used to store the items unique identifier,
    ///             such as a DocID.
    ///    dwNumberOfColumns = Type: <b>DWORD</b> The number of properties being written.
    ///    pColumns = Type: <b>PROPERTYKEY*</b> Pointer to an array of PROPERTYKEY structures that represent the properties.
    ///    pValues = Type: <b>SEARCH_COLUMN_PROPERTIES*</b> Pointer to an array of SEARCH_COLUMN_PROPERTIES structures that hold
    ///              the property values.
    ///    pftGatherModifiedTime = Type: <b>FILETIME*</b> A pointer to the last modified time for the item being written. This time stamp is
    ///                            used later to see if an item has been changed and requires updating.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT WriteProperties(int itemID, uint dwNumberOfColumns, PROPERTYKEY* pColumns, 
                            SEARCH_COLUMN_PROPERTIES* pValues, FILETIME* pftGatherModifiedTime);
    ///Sets the maximum number of results to be returned by a query.
    ///Params:
    ///    cMaxResults = Type: <b>LONG</b> The maximum number of results to be returned. Negative numbers return all results.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT put_QueryMaxResults(int cMaxResults);
    ///Gets the maximum number of results to be returned by the query.
    ///Params:
    ///    pcMaxResults = Type: <b>LONG*</b> Receives a pointer to the maximum number of results to be returned by the query. Negative
    ///                   numbers return all results.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT get_QueryMaxResults(int* pcMaxResults);
}

///Sets or retrieves the current indexer prioritization level for the scope specified by this query.
@GUID("42811652-079D-481B-87A2-09A69ECC5F44")
interface IRowsetPrioritization : IUnknown
{
    ///Sets the current indexer prioritization level for the scope specified by this query.
    ///Params:
    ///    priority = Type: <b>PRIORITY_LEVEL</b> Specifies the new indexer prioritization level to be set as the PRIORITY_LEVEL
    ///               enumeration.
    ///    scopeStatisticsEventFrequency = Type: <b>DWORD</b> Specifies the occurrence interval of the scope statistics event when there are outstanding
    ///                                    documents to be indexed within the query scopes.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetScopePriority(PRIORITY_LEVEL priority, uint scopeStatisticsEventFrequency);
    ///Retrieves the current indexer prioritization level for the scope specified by this query.
    ///Params:
    ///    priority = Type: <b>PRIORITY_LEVEL*</b> The current indexer prioritization level as the PRIORITY_LEVEL enumeration.
    ///    scopeStatisticsEventFrequency = Type: <b>DWORD*</b> The occurrence interval of the scope statistics event when there are outstanding
    ///                                    documents to be indexed within the query scopes.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetScopePriority(PRIORITY_LEVEL* priority, uint* scopeStatisticsEventFrequency);
    ///Gets information describing the scope specified by this query.
    ///Params:
    ///    indexedDocumentCount = Type: <b>DWORD*</b> The total number of documents currently indexed in the scope.
    ///    oustandingAddCount = Type: <b>DWORD*</b> The total number of documents yet to be indexed in the scope. These documents are not yet
    ///                         included in <i>indexedDocumentCount</i>.
    ///    oustandingModifyCount = Type: <b>DWORD*</b> The total number of documents indexed in the scope that need to be re-indexed. These
    ///                            documents are included in <i>indexedDocumentCount</i>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetScopeStatistics(uint* indexedDocumentCount, uint* oustandingAddCount, uint* oustandingModifyCount);
}

///Exposes methods for receiving event notifications. When clients implement this interface, the indexer can notify the
///clients of changes to items in their rowsets: including the addition of new items, the deletion of items, and the
///modifcation to item data.
@GUID("1551AEA5-5D66-4B11-86F5-D5634CB211B9")
interface IRowsetEvents : IUnknown
{
    ///Called by the indexer to notify clients of a new item that may match some (or all) of the criteria for the client
    ///rowset.
    ///Params:
    ///    itemID = Type: <b>REFPROPVARIANT</b> The new item that may match the original search criteria of the rowset.
    ///    newItemState = Type: <b>ROWSETEVENT_ITEMSTATE</b> Specifies whether the new item matches all or some of the criteria for
    ///                   your rowset, as a ROWSETEVENT_ITEMSTATE enumeration.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OnNewItem(const(PROPVARIANT)* itemID, ROWSETEVENT_ITEMSTATE newItemState);
    ///Called by the indexer to notify clients that an item has been modified. This item may have matched some (or all)
    ///of the criteria for the client rowset.
    ///Params:
    ///    itemID = Type: <b>REFPROPVARIANT</b> Specifies the item in the rowset that has changed.
    ///    rowsetItemState = Type: <b>ROWSETEVENT_ITEMSTATE</b> Specifies whether the changed item was originally in the rowset.
    ///    changedItemState = Type: <b>ROWSETEVENT_ITEMSTATE</b> Specifies whether the changed item is currently in the rowset, as a result
    ///                       of the change.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OnChangedItem(const(PROPVARIANT)* itemID, ROWSETEVENT_ITEMSTATE rowsetItemState, 
                          ROWSETEVENT_ITEMSTATE changedItemState);
    ///Called by the indexer to notify clients that an item has been deleted. This item may have matched some (or all)
    ///of the search criteria for the client rowset.
    ///Params:
    ///    itemID = Type: <b>REFPROPVARIANT</b> Specifies the item in the rowset that has been deleted.
    ///    deletedItemState = Type: <b>ROWSETEVENT_ITEMSTATE</b> Specifies whether the deleted item is currently in the rowset, as a
    ///                       ROWSETEVENT_ITEMSTATE enumeration.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OnDeletedItem(const(PROPVARIANT)* itemID, ROWSETEVENT_ITEMSTATE deletedItemState);
    ///Called by the indexer to notify clients of an event related to the client rowset.
    ///Params:
    ///    eventType = Type: <b>ROWSETEVENT_TYPE</b> The event triggering the notification as the ROWSETEVENT_TYPE enumeration.
    ///    eventData = Type: <b>REFPROPVARIANT</b> The expected value of the event data for the event type.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OnRowsetEvent(ROWSETEVENT_TYPE eventType, const(PROPVARIANT)* eventData);
}

///Provides methods for controlling the Search service. This interface manages settings and objects that affect the
///search engine across catalogs.
@GUID("AB310581-AC80-11D1-8DF3-00C04FB6EF69")
interface ISearchManager : IUnknown
{
    ///Retrieves the version of the current indexer as a single string.
    ///Params:
    ///    ppszVersionString = Type: <b>LPWSTR*</b> Receives the version of the current indexer.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetIndexerVersionStr(PWSTR* ppszVersionString);
    ///Retrieves the version of the current indexer in two chunks: the major version signifier and the minor version
    ///signifier.
    ///Params:
    ///    pdwMajor = Type: <b>DWORD*</b> Receives the major version signifier (the number to the left of the dot).
    ///    pdwMinor = Type: <b>DWORD*</b> Receives the minor version signifier (the number to the right of the dot).
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetIndexerVersion(uint* pdwMajor, uint* pdwMinor);
    ///Not supported. This method returns E_INVALIDARG when called.
    ///Params:
    ///    pszName = Type: <b>LPCWSTR</b> There are currently no valid parameters in this version of search (WDS 3.0).
    ///    ppValue = Type: <b>PROPVARIANT**</b> Returns a value in an undefined state as there are no properties currently defined
    ///              to retrieve values from.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns E_InvalidArg as an error code when called.
    ///    
    HRESULT GetParameter(const(PWSTR) pszName, PROPVARIANT** ppValue);
    ///Not supported. This method returns E_INVALIDARG when called.
    ///Params:
    ///    pszName = Type: <b>LPCWSTR</b> There are currently no valid parameters to pass or retrieve.
    ///    pValue = Type: <b>PROPVARIANT*</b> As there are no valid parameters currently configured, there are no valid
    ///             parameters to pass to this method.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns E_InvalidArg as an error code when called.
    ///    
    HRESULT SetParameter(const(PWSTR) pszName, const(PROPVARIANT)* pValue);
    ///Retrieves the proxy name to be used by the protocol handler.
    ///Params:
    ///    ppszProxyName = Type: <b>LPWSTR*</b> Receives a pointer to a Unicode string that contains the proxy name.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT get_ProxyName(PWSTR* ppszProxyName);
    ///Gets a proxy bypass list from the indexer. This list is used to determine which items or URLs are local and do
    ///not need to go through the proxy server. This list is set by calling ISearchManager::SetProxy.
    ///Params:
    ///    ppszBypassList = Type: <b>LPWSTR*</b> Receives a pointer to the proxy bypass list that is stored in the indexer.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT get_BypassList(PWSTR* ppszBypassList);
    ///Stores information in the indexer that determines how the indexer will work and communicate with a proxy server.
    ///Params:
    ///    sUseProxy = Type: <b>PROXY_ACCESS</b> Sets whether and how to use a proxy, using one of the values enumerated in
    ///                PROXY_ACCESS.
    ///    fLocalByPassProxy = Type: <b>BOOL</b> Sets whether the proxy server should be bypassed for local items and URLs.
    ///    dwPortNumber = Type: <b>DWORD</b> Sets the port number that the index will use to talk to the proxy server.
    ///    pszProxyName = Type: <b>LPCWSTR</b> A null-terminated Unicode string containing the name of the proxy server to use.
    ///    pszByPassList = Type: <b>LPCWSTR</b> A null-terminated Unicode string containing a comma-delimited list of items that are
    ///                    considered local by the indexer and are not to be accessed through a proxy server.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetProxy(PROXY_ACCESS sUseProxy, BOOL fLocalByPassProxy, uint dwPortNumber, const(PWSTR) pszProxyName, 
                     const(PWSTR) pszByPassList);
    ///Retrieves a catalog by name and creates a new ISearchCatalogManager object for that catalog.
    ///Params:
    ///    pszCatalog = Type: <b>LPCWSTR</b> The name of the catalog to be retrieved.
    ///    ppCatalogManager = Type: <b>ISearchCatalogManager**</b> Receives the address of a pointer to the ISearchCatalogManager object
    ///                       that is named in <i>pszCatalog</i>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetCatalog(const(PWSTR) pszCatalog, ISearchCatalogManager* ppCatalogManager);
    ///Retrieves the user agent string.
    ///Params:
    ///    ppszUserAgent = Type: <b>LPWSTR*</b> Receives the address of a pointer to the user agent string.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT get_UserAgent(PWSTR* ppszUserAgent);
    ///Sets the user agent string that a user agent passes to website and services to identify itself.
    ///Params:
    ///    pszUserAgent = Type: <b>LPCWSTR</b> The user agent string identifying the user agent.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT put_UserAgent(const(PWSTR) pszUserAgent);
    ///Retrieves the proxy server to be used.
    ///Params:
    ///    pUseProxy = Type: <b>PROXY_ACCESS*</b> Receives a pointer to the proxy server to be used.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT get_UseProxy(PROXY_ACCESS* pUseProxy);
    ///Retrieves a value that determines whether the proxy server should be bypassed to find the item or URL.
    ///Params:
    ///    pfLocalBypass = Type: <b>BOOL*</b> Receives a pointer to a <b>BOOL</b> value that indicates whether to bypass the proxy
    ///                    server to find an item or URL. <b>TRUE</b> to bypass the proxy (for local items); otherwise, <b>FALSE</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT get_LocalBypass(BOOL* pfLocalBypass);
    ///Retrieves the port number used to communicate with the proxy server. This port number is stored in the indexer
    ///and is set by the ISearchManager::SetProxy method.
    ///Params:
    ///    pdwPortNumber = Type: <b>DWORD*</b> Receives a pointer to the port number.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT get_PortNumber(uint* pdwPortNumber);
}

///Enabled applications to create and delete custom catalogs in the Windows Search indexer
@GUID("DBAB3F73-DB19-4A79-BFC0-A61A93886DDF")
interface ISearchManager2 : ISearchManager
{
    ///Creates a new custom catalog in the Windows Search indexer and returns a reference to it.
    ///Params:
    ///    pszCatalog = Type: <b>LPCWSTR</b> Name of catalog to create. Can be any name selected by the caller, must contain only
    ///                 standard alphanumeric characters and underscore.
    ///    ppCatalogManager = Type: <b>ISearchCatalogManager**</b> On success a reference to the created catalog is returned as an
    ///                       ISearchCatalogManager interface pointer. The Release() must be called on this interface after the calling
    ///                       application has finished using it.
    ///Returns:
    ///    Type: <b>HRESULT</b> HRESULT indicating status of operation: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Catalog did not previously exist and was created. Reference to catalog returned. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> Catalog previously existed, reference
    ///    to catalog returned. </td> </tr> </table> FAILED HRESULT: Failure creating catalog or invalid arguments
    ///    passed.
    ///    
    HRESULT CreateCatalog(const(PWSTR) pszCatalog, ISearchCatalogManager* ppCatalogManager);
    ///Deletes an existing catalog and all associated indexed data from the Windows Search indexer.
    ///Params:
    ///    pszCatalog = Type: <b>LPCWSTR</b> Name of catalog to delete. The catalog must at some prior time have been created with a
    ///                 call to CreateCatalog().
    ///Returns:
    ///    Type: <b>HRESULT</b> HRESULT indicating status of operation: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
    ///    Catalog previously existed and has now been successfully deleted. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> Catalog did not previously existed, no change. </td>
    ///    </tr> </table> FAILED HRESULT: Failure deleting catalog or invalid arguments passed.
    ///    
    HRESULT DeleteCatalog(const(PWSTR) pszCatalog);
}

///Provides methods for accessing thesaurus information.
@GUID("24C3CBAA-EBC1-491A-9EF1-9F6D8DEB1B8F")
interface ISearchLanguageSupport : IUnknown
{
    ///Sets a value that indicates whether an implemented ISearchLanguageSupport interface is sensitive to diacritics. A
    ///diacritic is an accent mark added to a letter to indicate a special phonetic value or pronunciation.
    ///Params:
    ///    fDiacriticSensitive = Type: <b>BOOL</b> A Boolean value that indicates whether the interface is sensitive to diacritics. The
    ///                          default setting is <b>FALSE</b>, indicating that the interface ignores diacritical characters.
    HRESULT SetDiacriticSensitivity(BOOL fDiacriticSensitive);
    ///Gets the sensitivity of an implemented ISearchLanguageSupport interface to diacritics. A diacritic is an accent
    ///mark added to a letter to indicate a special phonetic value or pronunciation.
    ///Params:
    ///    pfDiacriticSensitive = Type: <b>BOOL*</b> On return, contains a pointer to the sensitivity setting. <b>FALSE</b> indicates that the
    ///                           interface ignores diacritics; <b>TRUE</b> indicates the interface recognizes diacritics.
    HRESULT GetDiacriticSensitivity(BOOL* pfDiacriticSensitive);
    ///Retrieves an interface to the word breaker registered for the specified language code identifier (LCID).
    ///Params:
    ///    lcid = Type: <b>LCID</b> The LCID requested.
    ///    riid = Type: <b>REFIID</b> IID of the interface to be queried.
    ///    ppWordBreaker = Type: <b>void**</b> On return, contains the address of a pointer to the interface of the LCID contained in
    ///                    <i>pLcidUsed</i>.
    ///    pLcidUsed = Type: <b>LCID*</b> On return, contains a pointer to the actual LCID used.
    HRESULT LoadWordBreaker(uint lcid, const(GUID)* riid, void** ppWordBreaker, uint* pLcidUsed);
    ///Retrieves an interface to the word stemmer registered for the specified language code identifier (LCID).
    ///Params:
    ///    lcid = Type: <b>LCID</b> The LCID requested.
    ///    riid = Type: <b>REFIID</b> IID of the interface to be queried.
    ///    ppStemmer = Type: <b>void**</b> On return, contains the address of a pointer to the interface of the LCID contained in
    ///                <i>pLcidUsed</i>.
    ///    pLcidUsed = Type: <b>LCID*</b> On return, contains a pointer to the actual LCID used.
    HRESULT LoadStemmer(uint lcid, const(GUID)* riid, void** ppStemmer, uint* pLcidUsed);
    ///Determines whether the query token is a prefix of the document token, disregarding case, width, and (optionally)
    ///diacritics.
    ///Params:
    ///    pwcsQueryToken = Type: <b>LPCWSTR</b> Pointer to the prefix to search for.
    ///    cwcQueryToken = Type: <b>ULONG</b> The size of <i>pwcsQueryToken</i>.
    ///    pwcsDocumentToken = Type: <b>LPCWSTR</b> Pointer to the document to be searched.
    ///    cwcDocumentToken = Type: <b>ULONG</b> The size of <i>pwcsDocumentToken</i>.
    ///    pulPrefixLength = Type: <b>ULONG*</b> Returns a pointer to the number of characters matched in <i>pwcsDocumentToken</i>.
    ///                      Typically, but not necessarily, the number of characters in <i>pwcsQueryToken</i>.
    HRESULT IsPrefixNormalized(const(PWSTR) pwcsQueryToken, uint cwcQueryToken, const(PWSTR) pwcsDocumentToken, 
                               uint cwcDocumentToken, uint* pulPrefixLength);
}

@GUID("F72C8D96-6DBD-11D1-A1E8-00C04FC2FBE1")
interface IEnumItemProperties : IUnknown
{
    HRESULT Next(uint celt, ITEMPROP* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumItemProperties* ppenum);
    HRESULT GetCount(uint* pnCount);
}

@GUID("A97559F8-6C4A-11D1-A1E8-00C04FC2FBE1")
interface ISubscriptionItem : IUnknown
{
    HRESULT GetCookie(GUID* pCookie);
    HRESULT GetSubscriptionItemInfo(SUBSCRIPTIONITEMINFO* pSubscriptionItemInfo);
    HRESULT SetSubscriptionItemInfo(const(SUBSCRIPTIONITEMINFO)* pSubscriptionItemInfo);
    HRESULT ReadProperties(uint nCount, const(PWSTR)** rgwszName, VARIANT* rgValue);
    HRESULT WriteProperties(uint nCount, const(PWSTR)** rgwszName, const(VARIANT)* rgValue);
    HRESULT EnumProperties(IEnumItemProperties* ppEnumItemProperties);
    HRESULT NotifyChanged();
}

@GUID("F72C8D97-6DBD-11D1-A1E8-00C04FC2FBE1")
interface IEnumSubscription : IUnknown
{
    HRESULT Next(uint celt, GUID* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumSubscription* ppenum);
    HRESULT GetCount(uint* pnCount);
}

@GUID("085FB2C0-0DF8-11D1-8F4B-00A0C905413F")
interface ISubscriptionMgr : IUnknown
{
    HRESULT DeleteSubscription(const(PWSTR) pwszURL, HWND hwnd);
    HRESULT UpdateSubscription(const(PWSTR) pwszURL);
    HRESULT UpdateAll();
    HRESULT IsSubscribed(const(PWSTR) pwszURL, BOOL* pfSubscribed);
    HRESULT GetSubscriptionInfo(const(PWSTR) pwszURL, _tagSubscriptionInfo* pInfo);
    HRESULT GetDefaultInfo(SUBSCRIPTIONTYPE subType, _tagSubscriptionInfo* pInfo);
    HRESULT ShowSubscriptionProperties(const(PWSTR) pwszURL, HWND hwnd);
    HRESULT CreateSubscription(HWND hwnd, const(PWSTR) pwszURL, const(PWSTR) pwszFriendlyName, uint dwFlags, 
                               SUBSCRIPTIONTYPE subsType, _tagSubscriptionInfo* pInfo);
}

@GUID("614BC270-AEDF-11D1-A1F9-00C04FC2FBE1")
interface ISubscriptionMgr2 : ISubscriptionMgr
{
    HRESULT GetItemFromURL(const(PWSTR) pwszURL, ISubscriptionItem* ppSubscriptionItem);
    HRESULT GetItemFromCookie(const(GUID)* pSubscriptionCookie, ISubscriptionItem* ppSubscriptionItem);
    HRESULT GetSubscriptionRunState(uint dwNumCookies, const(GUID)* pCookies, uint* pdwRunState);
    HRESULT EnumSubscriptions(uint dwFlags, IEnumSubscription* ppEnumSubscriptions);
    HRESULT UpdateItems(uint dwFlags, uint dwNumCookies, const(GUID)* pCookies);
    HRESULT AbortItems(uint dwNumCookies, const(GUID)* pCookies);
    HRESULT AbortAll();
}


// GUIDs

const GUID CLSID_CSearchLanguageSupport = GUIDOF!CSearchLanguageSupport;
const GUID CLSID_CSearchManager         = GUIDOF!CSearchManager;
const GUID CLSID_CSearchRoot            = GUIDOF!CSearchRoot;
const GUID CLSID_CSearchScopeRule       = GUIDOF!CSearchScopeRule;
const GUID CLSID_CompoundCondition      = GUIDOF!CompoundCondition;
const GUID CLSID_ConditionFactory       = GUIDOF!ConditionFactory;
const GUID CLSID_FilterRegistration     = GUIDOF!FilterRegistration;
const GUID CLSID_Interval               = GUIDOF!Interval;
const GUID CLSID_LeafCondition          = GUIDOF!LeafCondition;
const GUID CLSID_NegationCondition      = GUIDOF!NegationCondition;
const GUID CLSID_QueryParser            = GUIDOF!QueryParser;
const GUID CLSID_QueryParserManager     = GUIDOF!QueryParserManager;
const GUID CLSID_SubscriptionMgr        = GUIDOF!SubscriptionMgr;

const GUID IID_IAccessor                           = GUIDOF!IAccessor;
const GUID IID_IAlterIndex                         = GUIDOF!IAlterIndex;
const GUID IID_IAlterTable                         = GUIDOF!IAlterTable;
const GUID IID_IBindResource                       = GUIDOF!IBindResource;
const GUID IID_IChapteredRowset                    = GUIDOF!IChapteredRowset;
const GUID IID_IColumnMapper                       = GUIDOF!IColumnMapper;
const GUID IID_IColumnMapperCreator                = GUIDOF!IColumnMapperCreator;
const GUID IID_IColumnsInfo                        = GUIDOF!IColumnsInfo;
const GUID IID_IColumnsInfo2                       = GUIDOF!IColumnsInfo2;
const GUID IID_IColumnsRowset                      = GUIDOF!IColumnsRowset;
const GUID IID_ICommand                            = GUIDOF!ICommand;
const GUID IID_ICommandPersist                     = GUIDOF!ICommandPersist;
const GUID IID_ICommandPrepare                     = GUIDOF!ICommandPrepare;
const GUID IID_ICommandProperties                  = GUIDOF!ICommandProperties;
const GUID IID_ICommandStream                      = GUIDOF!ICommandStream;
const GUID IID_ICommandText                        = GUIDOF!ICommandText;
const GUID IID_ICommandWithParameters              = GUIDOF!ICommandWithParameters;
const GUID IID_ICondition                          = GUIDOF!ICondition;
const GUID IID_ICondition2                         = GUIDOF!ICondition2;
const GUID IID_IConditionFactory                   = GUIDOF!IConditionFactory;
const GUID IID_IConditionFactory2                  = GUIDOF!IConditionFactory2;
const GUID IID_IConditionGenerator                 = GUIDOF!IConditionGenerator;
const GUID IID_IConvertType                        = GUIDOF!IConvertType;
const GUID IID_ICreateRow                          = GUIDOF!ICreateRow;
const GUID IID_IDBAsynchNotify                     = GUIDOF!IDBAsynchNotify;
const GUID IID_IDBAsynchStatus                     = GUIDOF!IDBAsynchStatus;
const GUID IID_IDBBinderProperties                 = GUIDOF!IDBBinderProperties;
const GUID IID_IDBCreateCommand                    = GUIDOF!IDBCreateCommand;
const GUID IID_IDBCreateSession                    = GUIDOF!IDBCreateSession;
const GUID IID_IDBDataSourceAdmin                  = GUIDOF!IDBDataSourceAdmin;
const GUID IID_IDBInfo                             = GUIDOF!IDBInfo;
const GUID IID_IDBInitialize                       = GUIDOF!IDBInitialize;
const GUID IID_IDBProperties                       = GUIDOF!IDBProperties;
const GUID IID_IDBSchemaRowset                     = GUIDOF!IDBSchemaRowset;
const GUID IID_IEntity                             = GUIDOF!IEntity;
const GUID IID_IEnumItemProperties                 = GUIDOF!IEnumItemProperties;
const GUID IID_IEnumSearchRoots                    = GUIDOF!IEnumSearchRoots;
const GUID IID_IEnumSearchScopeRules               = GUIDOF!IEnumSearchScopeRules;
const GUID IID_IEnumSubscription                   = GUIDOF!IEnumSubscription;
const GUID IID_IErrorLookup                        = GUIDOF!IErrorLookup;
const GUID IID_IErrorRecords                       = GUIDOF!IErrorRecords;
const GUID IID_IGetDataSource                      = GUIDOF!IGetDataSource;
const GUID IID_IGetRow                             = GUIDOF!IGetRow;
const GUID IID_IGetSession                         = GUIDOF!IGetSession;
const GUID IID_IGetSourceRow                       = GUIDOF!IGetSourceRow;
const GUID IID_IIndexDefinition                    = GUIDOF!IIndexDefinition;
const GUID IID_IInterval                           = GUIDOF!IInterval;
const GUID IID_ILoadFilter                         = GUIDOF!ILoadFilter;
const GUID IID_ILoadFilterWithPrivateComActivation = GUIDOF!ILoadFilterWithPrivateComActivation;
const GUID IID_IMDDataset                          = GUIDOF!IMDDataset;
const GUID IID_IMDFind                             = GUIDOF!IMDFind;
const GUID IID_IMDRangeRowset                      = GUIDOF!IMDRangeRowset;
const GUID IID_IMetaData                           = GUIDOF!IMetaData;
const GUID IID_IMultipleResults                    = GUIDOF!IMultipleResults;
const GUID IID_INamedEntity                        = GUIDOF!INamedEntity;
const GUID IID_INamedEntityCollector               = GUIDOF!INamedEntityCollector;
const GUID IID_IObjectAccessControl                = GUIDOF!IObjectAccessControl;
const GUID IID_IOpLockStatus                       = GUIDOF!IOpLockStatus;
const GUID IID_IOpenRowset                         = GUIDOF!IOpenRowset;
const GUID IID_IParentRowset                       = GUIDOF!IParentRowset;
const GUID IID_IProtocolHandlerSite                = GUIDOF!IProtocolHandlerSite;
const GUID IID_IQueryParser                        = GUIDOF!IQueryParser;
const GUID IID_IQueryParserManager                 = GUIDOF!IQueryParserManager;
const GUID IID_IQuerySolution                      = GUIDOF!IQuerySolution;
const GUID IID_IRegisterProvider                   = GUIDOF!IRegisterProvider;
const GUID IID_IRelationship                       = GUIDOF!IRelationship;
const GUID IID_IRichChunk                          = GUIDOF!IRichChunk;
const GUID IID_IRow                                = GUIDOF!IRow;
const GUID IID_IRowChange                          = GUIDOF!IRowChange;
const GUID IID_IRowPosition                        = GUIDOF!IRowPosition;
const GUID IID_IRowPositionChange                  = GUIDOF!IRowPositionChange;
const GUID IID_IRowSchemaChange                    = GUIDOF!IRowSchemaChange;
const GUID IID_IRowset                             = GUIDOF!IRowset;
const GUID IID_IRowsetBookmark                     = GUIDOF!IRowsetBookmark;
const GUID IID_IRowsetChange                       = GUIDOF!IRowsetChange;
const GUID IID_IRowsetChapterMember                = GUIDOF!IRowsetChapterMember;
const GUID IID_IRowsetCurrentIndex                 = GUIDOF!IRowsetCurrentIndex;
const GUID IID_IRowsetEvents                       = GUIDOF!IRowsetEvents;
const GUID IID_IRowsetFind                         = GUIDOF!IRowsetFind;
const GUID IID_IRowsetIdentity                     = GUIDOF!IRowsetIdentity;
const GUID IID_IRowsetIndex                        = GUIDOF!IRowsetIndex;
const GUID IID_IRowsetInfo                         = GUIDOF!IRowsetInfo;
const GUID IID_IRowsetLocate                       = GUIDOF!IRowsetLocate;
const GUID IID_IRowsetNotify                       = GUIDOF!IRowsetNotify;
const GUID IID_IRowsetPrioritization               = GUIDOF!IRowsetPrioritization;
const GUID IID_IRowsetRefresh                      = GUIDOF!IRowsetRefresh;
const GUID IID_IRowsetResynch                      = GUIDOF!IRowsetResynch;
const GUID IID_IRowsetScroll                       = GUIDOF!IRowsetScroll;
const GUID IID_IRowsetUpdate                       = GUIDOF!IRowsetUpdate;
const GUID IID_IRowsetView                         = GUIDOF!IRowsetView;
const GUID IID_ISQLErrorInfo                       = GUIDOF!ISQLErrorInfo;
const GUID IID_ISchemaLocalizerSupport             = GUIDOF!ISchemaLocalizerSupport;
const GUID IID_ISchemaProvider                     = GUIDOF!ISchemaProvider;
const GUID IID_IScopedOperations                   = GUIDOF!IScopedOperations;
const GUID IID_ISearchCatalogManager               = GUIDOF!ISearchCatalogManager;
const GUID IID_ISearchCatalogManager2              = GUIDOF!ISearchCatalogManager2;
const GUID IID_ISearchCrawlScopeManager            = GUIDOF!ISearchCrawlScopeManager;
const GUID IID_ISearchCrawlScopeManager2           = GUIDOF!ISearchCrawlScopeManager2;
const GUID IID_ISearchItemsChangedSink             = GUIDOF!ISearchItemsChangedSink;
const GUID IID_ISearchLanguageSupport              = GUIDOF!ISearchLanguageSupport;
const GUID IID_ISearchManager                      = GUIDOF!ISearchManager;
const GUID IID_ISearchManager2                     = GUIDOF!ISearchManager2;
const GUID IID_ISearchNotifyInlineSite             = GUIDOF!ISearchNotifyInlineSite;
const GUID IID_ISearchPersistentItemsChangedSink   = GUIDOF!ISearchPersistentItemsChangedSink;
const GUID IID_ISearchProtocol                     = GUIDOF!ISearchProtocol;
const GUID IID_ISearchProtocol2                    = GUIDOF!ISearchProtocol2;
const GUID IID_ISearchProtocolThreadContext        = GUIDOF!ISearchProtocolThreadContext;
const GUID IID_ISearchQueryHelper                  = GUIDOF!ISearchQueryHelper;
const GUID IID_ISearchRoot                         = GUIDOF!ISearchRoot;
const GUID IID_ISearchScopeRule                    = GUIDOF!ISearchScopeRule;
const GUID IID_ISearchViewChangedSink              = GUIDOF!ISearchViewChangedSink;
const GUID IID_ISecurityInfo                       = GUIDOF!ISecurityInfo;
const GUID IID_ISessionProperties                  = GUIDOF!ISessionProperties;
const GUID IID_ISimpleCommandCreator               = GUIDOF!ISimpleCommandCreator;
const GUID IID_ISourcesRowset                      = GUIDOF!ISourcesRowset;
const GUID IID_IStemmer                            = GUIDOF!IStemmer;
const GUID IID_ISubscriptionItem                   = GUIDOF!ISubscriptionItem;
const GUID IID_ISubscriptionMgr                    = GUIDOF!ISubscriptionMgr;
const GUID IID_ISubscriptionMgr2                   = GUIDOF!ISubscriptionMgr2;
const GUID IID_ITableCreation                      = GUIDOF!ITableCreation;
const GUID IID_ITableDefinition                    = GUIDOF!ITableDefinition;
const GUID IID_ITableDefinitionWithConstraints     = GUIDOF!ITableDefinitionWithConstraints;
const GUID IID_ITokenCollection                    = GUIDOF!ITokenCollection;
const GUID IID_ITransactionJoin                    = GUIDOF!ITransactionJoin;
const GUID IID_ITransactionLocal                   = GUIDOF!ITransactionLocal;
const GUID IID_ITransactionObject                  = GUIDOF!ITransactionObject;
const GUID IID_ITrusteeAdmin                       = GUIDOF!ITrusteeAdmin;
const GUID IID_ITrusteeGroupAdmin                  = GUIDOF!ITrusteeGroupAdmin;
const GUID IID_IUrlAccessor                        = GUIDOF!IUrlAccessor;
const GUID IID_IUrlAccessor2                       = GUIDOF!IUrlAccessor2;
const GUID IID_IUrlAccessor3                       = GUIDOF!IUrlAccessor3;
const GUID IID_IUrlAccessor4                       = GUIDOF!IUrlAccessor4;
const GUID IID_IViewChapter                        = GUIDOF!IViewChapter;
const GUID IID_IViewFilter                         = GUIDOF!IViewFilter;
const GUID IID_IViewRowset                         = GUIDOF!IViewRowset;
const GUID IID_IViewSort                           = GUIDOF!IViewSort;
const GUID IID_IWordBreaker                        = GUIDOF!IWordBreaker;
const GUID IID_IWordFormSink                       = GUIDOF!IWordFormSink;
const GUID IID_IWordSink                           = GUIDOF!IWordSink;
