module windows.indexserver;

public import system;
public import windows.com;
public import windows.structuredstorage;

extern(Windows):

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
    Guid guidPropSet;
    PROPSPEC psProperty;
}

enum IFILTER_INIT
{
    IFILTER_INIT_CANON_PARAGRAPHS = 1,
    IFILTER_INIT_HARD_LINE_BREAKS = 2,
    IFILTER_INIT_CANON_HYPHENS = 4,
    IFILTER_INIT_CANON_SPACES = 8,
    IFILTER_INIT_APPLY_INDEX_ATTRIBUTES = 16,
    IFILTER_INIT_APPLY_OTHER_ATTRIBUTES = 32,
    IFILTER_INIT_APPLY_CRAWL_ATTRIBUTES = 256,
    IFILTER_INIT_INDEXING_ONLY = 64,
    IFILTER_INIT_SEARCH_LINKS = 128,
    IFILTER_INIT_FILTER_OWNED_VALUE_OK = 512,
    IFILTER_INIT_FILTER_AGGRESSIVE_BREAK = 1024,
    IFILTER_INIT_DISABLE_EMBEDDED = 2048,
    IFILTER_INIT_EMIT_FORMATTING = 4096,
}

enum IFILTER_FLAGS
{
    IFILTER_FLAGS_OLE_PROPERTIES = 1,
}

enum CHUNKSTATE
{
    CHUNK_TEXT = 1,
    CHUNK_VALUE = 2,
    CHUNK_FILTER_OWNED_VALUE = 4,
}

enum CHUNK_BREAKTYPE
{
    CHUNK_NO_BREAK = 0,
    CHUNK_EOW = 1,
    CHUNK_EOS = 2,
    CHUNK_EOP = 3,
    CHUNK_EOC = 4,
}

struct FILTERREGION
{
    uint idChunk;
    uint cwcStart;
    uint cwcExtent;
}

struct STAT_CHUNK
{
    uint idChunk;
    CHUNK_BREAKTYPE breakType;
    CHUNKSTATE flags;
    uint locale;
    FULLPROPSPEC attribute;
    uint idChunkSource;
    uint cwcStartSource;
    uint cwcLenSource;
}

const GUID IID_IFilter = {0x89BCB740, 0x6119, 0x101A, [0xBC, 0xB7, 0x00, 0xDD, 0x01, 0x06, 0x55, 0xAF]};
@GUID(0x89BCB740, 0x6119, 0x101A, [0xBC, 0xB7, 0x00, 0xDD, 0x01, 0x06, 0x55, 0xAF]);
interface IFilter : IUnknown
{
    int Init(uint grfFlags, uint cAttributes, const(FULLPROPSPEC)* aAttributes, uint* pFlags);
    int GetChunk(STAT_CHUNK* pStat);
    int GetText(uint* pcwcBuffer, ushort* awcBuffer);
    int GetValue(PROPVARIANT** ppPropValue);
    int BindRegion(FILTERREGION origPos, const(Guid)* riid, void** ppunk);
}

@DllImport("query.dll")
HRESULT LoadIFilter(const(wchar)* pwcsPath, IUnknown pUnkOuter, void** ppIUnk);

@DllImport("query.dll")
HRESULT LoadIFilterEx(const(wchar)* pwcsPath, uint dwFlags, const(Guid)* riid, void** ppIUnk);

@DllImport("query.dll")
HRESULT BindIFilterFromStorage(IStorage pStg, IUnknown pUnkOuter, void** ppIUnk);

@DllImport("query.dll")
HRESULT BindIFilterFromStream(IStream pStm, IUnknown pUnkOuter, void** ppIUnk);

const GUID IID_IPhraseSink = {0xCC906FF0, 0xC058, 0x101A, [0xB5, 0x54, 0x08, 0x00, 0x2B, 0x33, 0xB0, 0xE6]};
@GUID(0xCC906FF0, 0xC058, 0x101A, [0xB5, 0x54, 0x08, 0x00, 0x2B, 0x33, 0xB0, 0xE6]);
interface IPhraseSink : IUnknown
{
    HRESULT PutSmallPhrase(const(wchar)* pwcNoun, uint cwcNoun, const(wchar)* pwcModifier, uint cwcModifier, uint ulAttachmentType);
    HRESULT PutPhrase(const(wchar)* pwcPhrase, uint cwcPhrase);
}

enum WORDREP_BREAK_TYPE
{
    WORDREP_BREAK_EOW = 0,
    WORDREP_BREAK_EOS = 1,
    WORDREP_BREAK_EOP = 2,
    WORDREP_BREAK_EOC = 3,
}

enum DBKINDENUM
{
    DBKIND_GUID_NAME = 0,
    DBKIND_GUID_PROPID = 1,
    DBKIND_NAME = 2,
    DBKIND_PGUID_NAME = 3,
    DBKIND_PGUID_PROPID = 4,
    DBKIND_PROPID = 5,
    DBKIND_GUID = 6,
}

struct DBID
{
    _uGuid_e__Union uGuid;
    uint eKind;
    _uName_e__Union uName;
}

