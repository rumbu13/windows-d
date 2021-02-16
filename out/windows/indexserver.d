module windows.indexserver;

public import windows.core;
public import windows.com : HRESULT, IUnknown;
public import windows.structuredstorage : IStorage, IStream, PROPSPEC, PROPVARIANT;

extern(Windows):


// Enums


enum : int
{
    IFILTER_INIT_CANON_PARAGRAPHS        = 0x00000001,
    IFILTER_INIT_HARD_LINE_BREAKS        = 0x00000002,
    IFILTER_INIT_CANON_HYPHENS           = 0x00000004,
    IFILTER_INIT_CANON_SPACES            = 0x00000008,
    IFILTER_INIT_APPLY_INDEX_ATTRIBUTES  = 0x00000010,
    IFILTER_INIT_APPLY_OTHER_ATTRIBUTES  = 0x00000020,
    IFILTER_INIT_APPLY_CRAWL_ATTRIBUTES  = 0x00000100,
    IFILTER_INIT_INDEXING_ONLY           = 0x00000040,
    IFILTER_INIT_SEARCH_LINKS            = 0x00000080,
    IFILTER_INIT_FILTER_OWNED_VALUE_OK   = 0x00000200,
    IFILTER_INIT_FILTER_AGGRESSIVE_BREAK = 0x00000400,
    IFILTER_INIT_DISABLE_EMBEDDED        = 0x00000800,
    IFILTER_INIT_EMIT_FORMATTING         = 0x00001000,
}
alias IFILTER_INIT = int;

enum : int
{
    IFILTER_FLAGS_OLE_PROPERTIES = 0x00000001,
}
alias IFILTER_FLAGS = int;

enum : int
{
    CHUNK_TEXT               = 0x00000001,
    CHUNK_VALUE              = 0x00000002,
    CHUNK_FILTER_OWNED_VALUE = 0x00000004,
}
alias CHUNKSTATE = int;

enum : int
{
    CHUNK_NO_BREAK = 0x00000000,
    CHUNK_EOW      = 0x00000001,
    CHUNK_EOS      = 0x00000002,
    CHUNK_EOP      = 0x00000003,
    CHUNK_EOC      = 0x00000004,
}
alias CHUNK_BREAKTYPE = int;

enum : int
{
    WORDREP_BREAK_EOW = 0x00000000,
    WORDREP_BREAK_EOS = 0x00000001,
    WORDREP_BREAK_EOP = 0x00000002,
    WORDREP_BREAK_EOC = 0x00000003,
}
alias WORDREP_BREAK_TYPE = int;

enum : int
{
    DBKIND_GUID_NAME    = 0x00000000,
    DBKIND_GUID_PROPID  = 0x00000001,
    DBKIND_NAME         = 0x00000002,
    DBKIND_PGUID_NAME   = 0x00000003,
    DBKIND_PGUID_PROPID = 0x00000004,
    DBKIND_PROPID       = 0x00000005,
    DBKIND_GUID         = 0x00000006,
}
alias DBKINDENUM = int;

// Structs


struct CI_STATE
{
    uint cbStruct;
    uint cWordList;
    uint cPersistentIndex;
    uint cQueries;
    uint cDocuments;
    uint cFreshTest;
    uint dwMergeProgress;
    uint eState;
    uint cFilteredDocuments;
    uint cTotalDocuments;
    uint cPendingScans;
    uint dwIndexSize;
    uint cUniqueKeys;
    uint cSecQDocuments;
    uint dwPropCacheSize;
}

struct FULLPROPSPEC
{
    GUID     guidPropSet;
    PROPSPEC psProperty;
}

struct FILTERREGION
{
    uint idChunk;
    uint cwcStart;
    uint cwcExtent;
}

struct STAT_CHUNK
{
    uint            idChunk;
    CHUNK_BREAKTYPE breakType;
    CHUNKSTATE      flags;
    uint            locale;
    FULLPROPSPEC    attribute;
    uint            idChunkSource;
    uint            cwcStartSource;
    uint            cwcLenSource;
}

struct DBID
{
align (2):
    union uGuid
    {
    align (2):
        GUID  guid;
        GUID* pguid;
    }
    uint eKind;
    union uName
    {
    align (2):
        ushort* pwszName;
        uint    ulPropid;
    }
}

// Functions

@DllImport("query")
HRESULT LoadIFilter(const(wchar)* pwcsPath, IUnknown pUnkOuter, void** ppIUnk);

@DllImport("query")
HRESULT LoadIFilterEx(const(wchar)* pwcsPath, uint dwFlags, const(GUID)* riid, void** ppIUnk);

@DllImport("query")
HRESULT BindIFilterFromStorage(IStorage pStg, IUnknown pUnkOuter, void** ppIUnk);

@DllImport("query")
HRESULT BindIFilterFromStream(IStream pStm, IUnknown pUnkOuter, void** ppIUnk);


// Interfaces

@GUID("89BCB740-6119-101A-BCB7-00DD010655AF")
interface IFilter : IUnknown
{
    int Init(uint grfFlags, uint cAttributes, const(FULLPROPSPEC)* aAttributes, uint* pFlags);
    int GetChunk(STAT_CHUNK* pStat);
    int GetText(uint* pcwcBuffer, ushort* awcBuffer);
    int GetValue(PROPVARIANT** ppPropValue);
    int BindRegion(FILTERREGION origPos, const(GUID)* riid, void** ppunk);
}

@GUID("CC906FF0-C058-101A-B554-08002B33B0E6")
interface IPhraseSink : IUnknown
{
    HRESULT PutSmallPhrase(const(wchar)* pwcNoun, uint cwcNoun, const(wchar)* pwcModifier, uint cwcModifier, 
                           uint ulAttachmentType);
    HRESULT PutPhrase(const(wchar)* pwcPhrase, uint cwcPhrase);
}


// GUIDs


const GUID IID_IFilter     = GUIDOF!IFilter;
const GUID IID_IPhraseSink = GUIDOF!IPhraseSink;
