// Written in the D programming language.

module windows.indexserver;

public import windows.core;
public import windows.com : HRESULT, IUnknown;
public import windows.structuredstorage : IStorage, IStream, PROPSPEC, PROPVARIANT;
public import windows.systemservices : PWSTR;

extern(Windows) @nogc nothrow:


// Enums


///> [!Note] > Indexing Service is no longer supported as of Windows XP and is unavailable for use as of Windows 8.
///Instead, use [Windows Search](/windows/desktop/search/-search-3x-wds-overview) for client side search and [Microsoft
///Search Server Express](https://www.microsoft.com/download/details.aspx?id=18914) for server side search. Describes
///the type of break that separates the current word from the previous word.
alias WORDREP_BREAK_TYPE = int;
enum : int
{
    ///A word break is placed between this word and the previous word that was placed in the <b>WordSink</b>. This break
    ///is the default used by the PutWord method.
    WORDREP_BREAK_EOW = 0x00000000,
    ///A sentence break is placed between this word and the previous word.
    WORDREP_BREAK_EOS = 0x00000001,
    ///A paragraph break is placed between this word and the previous word.
    WORDREP_BREAK_EOP = 0x00000002,
    ///A chapter break is placed between this word and the previous word.
    WORDREP_BREAK_EOC = 0x00000003,
}

///> [!Note] > Indexing Service is no longer supported as of Windows XP and is unavailable for use as of Windows 8.
///Instead, use [Windows Search](/windows/desktop/search/-search-3x-wds-overview) for client side search and [Microsoft
///Search Server Express](https://www.microsoft.com/download/details.aspx?id=18914) for server side search. The
///<b>DBKINDENUM</b> enumerated type specifies the combination of GUID, property number, or property name to use to
///identify a database object.
alias DBKINDENUM = int;
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

///<p class="CCE_Message">[Indexing Service is no longer supported as of Windows XP and is unavailable for use as of
///Windows 8. Instead, use Windows Search for client side search and Microsoft Search Server Express for server side
///search.] Flags that control the filtering process.
alias IFILTER_INIT = int;
enum : int
{
    ///Paragraph breaks should be marked with the Unicode PARAGRAPH SEPARATOR (0x2029).
    IFILTER_INIT_CANON_PARAGRAPHS        = 0x00000001,
    ///Soft returns, such as the newline character in Word, should be replaced by hard returns?LINE SEPARATOR (0x2028).
    ///Existing hard returns can be doubled. A carriage return (0x000D), line feed (0x000A), or the carriage return and
    ///line feed in combination should be considered a hard return. The intent is to enable pattern-expression matches
    ///that match against observed line breaks.
    IFILTER_INIT_HARD_LINE_BREAKS        = 0x00000002,
    ///Various word-processing programs have forms of hyphens that are not represented in the host character set, such
    ///as optional hyphens (appearing only at the end of a line) and nonbreaking hyphens. This flag indicates that
    ///optional hyphens are to be converted to nulls, and non-breaking hyphens are to be converted to normal hyphens
    ///(0x2010), or HYPHEN-MINUSES (0x002D).
    IFILTER_INIT_CANON_HYPHENS           = 0x00000004,
    ///Just as the IFILTER_INIT_CANON_HYPHENS flag standardizes hyphens, this one standardizes spaces. All special space
    ///characters, such as nonbreaking spaces, are converted to the standard space character (0x0020).
    IFILTER_INIT_CANON_SPACES            = 0x00000008,
    ///Indicates that the client wants text split into chunks representing internal value-type properties.
    IFILTER_INIT_APPLY_INDEX_ATTRIBUTES  = 0x00000010,
    ///Any properties not covered by the IFILTER_INIT_APPLY_INDEX_ATTRIBUTES and IFILTER_INIT_APPLY_CRAWL_ATTRIBUTES
    ///flags should be emitted.
    IFILTER_INIT_APPLY_OTHER_ATTRIBUTES  = 0x00000020,
    ///Indicates that the client wants text split into chunks representing properties determined during the indexing
    ///process.
    IFILTER_INIT_APPLY_CRAWL_ATTRIBUTES  = 0x00000100,
    ///Optimizes IFilter for indexing because the client calls the IFilter::Init method only once and does not call
    ///IFilter::BindRegion. This eliminates the possibility of accessing a chunk both before and after accessing another
    ///chunk.
    IFILTER_INIT_INDEXING_ONLY           = 0x00000040,
    ///The text extraction process must recursively search all linked objects within the document. If a link is
    ///unavailable, the IFilter::GetChunk call that would have obtained the first chunk of the link should return
    ///FILTER_E_LINK_UNAVAILABLE.
    IFILTER_INIT_SEARCH_LINKS            = 0x00000080,
    ///The content indexing process can return property values set by the filter.
    IFILTER_INIT_FILTER_OWNED_VALUE_OK   = 0x00000200,
    ///TBD
    IFILTER_INIT_FILTER_AGGRESSIVE_BREAK = 0x00000400,
    ///TBD
    IFILTER_INIT_DISABLE_EMBEDDED        = 0x00000800,
    ///TBD
    IFILTER_INIT_EMIT_FORMATTING         = 0x00001000,
}

///> [!Note] > Indexing Service is no longer supported as of Windows XP and is unavailable for use as of Windows 8.
///Instead, use [Windows Search](/windows/desktop/search/-search-3x-wds-overview) for client side search and [Microsoft
///Search Server Express](https://www.microsoft.com/download/details.aspx?id=18914) for server side search. Indicates
///whether the caller should use the <b>IPropertySetStorage</b> and <b>IPropertyStorage</b> interfaces to locate
///additional properties.
alias IFILTER_FLAGS = int;
enum : int
{
    ///The caller should use the IPropertySetStorage and IPropertyStorage interfaces to locate additional properties.
    ///When this flag is set, properties available through COM enumerators should not be returned from IFilter.
    IFILTER_FLAGS_OLE_PROPERTIES = 0x00000001,
}

///> [!Note] > Indexing Service is no longer supported as of Windows XP and is unavailable for use as of Windows 8.
///Instead, use [Windows Search](/windows/desktop/search/-search-3x-wds-overview) for client side search and [Microsoft
///Search Server Express](https://www.microsoft.com/download/details.aspx?id=18914) for server side search. Specifies
///whether the current chunk is a text-type property or a value-type property.
alias CHUNKSTATE = int;
enum : int
{
    ///The current chunk is a text-type property.
    CHUNK_TEXT               = 0x00000001,
    ///The current chunk is a value-type property.
    CHUNK_VALUE              = 0x00000002,
    ///Reserved.
    CHUNK_FILTER_OWNED_VALUE = 0x00000004,
}

///> [!Note] > Indexing Service is no longer supported as of Windows XP and is unavailable for use as of Windows 8.
///Instead, use [Windows Search](/windows/desktop/search/-search-3x-wds-overview) for client side search and [Microsoft
///Search Server Express](https://www.microsoft.com/download/details.aspx?id=18914) for server side search. Describes
///the type of break that separates the current chunk from the previous chunk.
alias CHUNK_BREAKTYPE = int;
enum : int
{
    ///No break is placed between the current chunk and the previous chunk. The chunks are glued together.
    CHUNK_NO_BREAK = 0x00000000,
    ///A word break is placed between this chunk and the previous chunk that had the same attribute. Use of CHUNK_EOW
    ///should be minimized because the choice of word breaks is language-dependent, so determining word breaks is best
    ///left to the search engine.
    CHUNK_EOW      = 0x00000001,
    ///A sentence break is placed between this chunk and the previous chunk that had the same attribute.
    CHUNK_EOS      = 0x00000002,
    ///A paragraph break is placed between this chunk and the previous chunk that had the same attribute.
    CHUNK_EOP      = 0x00000003,
    ///A chapter break is placed between this chunk and the previous chunk that had the same attribute.
    CHUNK_EOC      = 0x00000004,
}

// Structs


///<p class="CCE_Message">[Indexing Service is no longer supported as of Windows XP and is unavailable for use as of
///Windows 8. Instead, use Windows Search for client side search and Microsoft Search Server Express for server side
///search.] The <b>DBID</b> structure encapsulates various ways of identifying a database object. It is used by nodes
///that must represent a column name, such as column_name, index_name, table_name, schema_name, catalog_name, and so
///forth. (For more information on these nodes, see Catalog of DML Nodes.) This structure is also used to define
///bindings.
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
        PWSTR pwszName;
        uint  ulPropid;
    }
}

///> [!Note] > Indexing Service is no longer supported as of Windows XP and is unavailable for use as of Windows 8.
///Instead, use [Windows Search](/windows/desktop/search/-search-3x-wds-overview) for client side search and [Microsoft
///Search Server Express](https://www.microsoft.com/download/details.aspx?id=18914) for server side search. Represents
///the current state of an Indexing Service catalog.
struct CI_STATE
{
    ///The size of this structure, in bytes.
    uint cbStruct;
    ///The number of current word lists.
    uint cWordList;
    ///The number of persistent indexes.
    uint cPersistentIndex;
    ///The number of actively running queries.
    uint cQueries;
    ///The number of documents waiting to be filtered.
    uint cDocuments;
    ///The number of unique documents in word lists and shadow indexes.
    uint cFreshTest;
    ///The completion percentage of current merge, if one is running.
    uint dwMergeProgress;
    ///The state of content indexing. This can be one or more of the CI_STATE_* constants.
    uint eState;
    ///The number of documents filtered since content indexing began.
    uint cFilteredDocuments;
    ///The total number of documents in the system.
    uint cTotalDocuments;
    ///The number of pending scans, possibly one for each scope in the directories list. The value is usually zero,
    ///except immediately after content indexing has been started or after a notification queue overflows.
    uint cPendingScans;
    ///The size, in megabytes, of the index (excluding the property cache).
    uint dwIndexSize;
    ///The number of unique keys in the master index.
    uint cUniqueKeys;
    ///The number of documents in the secondary queue, which contains documents that failed filtering due to a sharing
    ///violation.
    uint cSecQDocuments;
    ///The size of the property cache, in megabytes.
    uint dwPropCacheSize;
}

///> [!Note] > Indexing Service is no longer supported as of Windows XP and is unavailable for use as of Windows 8.
///Instead, use [Windows Search](/windows/desktop/search/-search-3x-wds-overview) for client side search and [Microsoft
///Search Server Express](https://www.microsoft.com/download/details.aspx?id=18914) for server side search. Specifies a
///property set and a property within the property set.
struct FULLPROPSPEC
{
    ///The globally unique identifier (GUID) that identifies the property set.
    GUID     guidPropSet;
    ///A pointer to the PROPSPEC structure that specifies a property either by its property identifier (propid) or by
    ///the associated string name (<b>lpwstr</b>).
    PROPSPEC psProperty;
}

///> [!Note] > Indexing Service is no longer supported as of Windows XP and is unavailable for use as of Windows 8.
///Instead, use [Windows Search](/windows/desktop/search/-search-3x-wds-overview) for client side search and [Microsoft
///Search Server Express](https://www.microsoft.com/download/details.aspx?id=18914) for server side search. Describes
///the position and extent of a specified portion of text within an object.
struct FILTERREGION
{
    ///The chunk identifier.
    uint idChunk;
    ///The beginning of the region, specified as an offset from the beginning of the chunk.
    uint cwcStart;
    ///The extent of the region, specified as the number of Unicode characters.
    uint cwcExtent;
}

///> [!Note] > Indexing Service is no longer supported as of Windows XP and is unavailable for use as of Windows 8.
///Instead, use [Windows Search](/windows/desktop/search/-search-3x-wds-overview) for client side search and [Microsoft
///Search Server Express](https://www.microsoft.com/download/details.aspx?id=18914) for server side search. Describes
///the characteristics of a chunk.
struct STAT_CHUNK
{
    ///The chunk identifier. Chunk identifiers must be unique for the current instance of the IFilter interface. Chunk
    ///identifiers must be in ascending order. The order in which chunks are numbered should correspond to the order in
    ///which they appear in the source document. Some search engines can take advantage of the proximity of chunks of
    ///various properties. If so, the order in which chunks with different properties are emitted will be important to
    ///the search engine.
    uint            idChunk;
    ///The type of break that separates the previous chunk from the current chunk. Values are from the CHUNK_BREAKTYPE
    ///enumeration.
    CHUNK_BREAKTYPE breakType;
    ///Indicates whether this chunk contains a text-type or a value-type property. Flag values are taken from the
    ///CHUNKSTATE enumeration. If the CHUNK_TEXT flag is set, IFilter::GetText should be used to retrieve the contents
    ///of the chunk as a series of words. If the CHUNK_VALUE flag is set, IFilter::GetValue should be used to retrieve
    ///the value and treat it as a single property value. If the filter dictates that the same content be treated as
    ///both text and as a value, the chunk should be emitted twice in two different chunks, each with one flag set.
    CHUNKSTATE      flags;
    ///The language and sublanguage associated with a chunk of text. Chunk locale is used by document indexers to
    ///perform proper word breaking of text. If the chunk is neither text-type nor a value-type with data type
    ///VT_LPWSTR, VT_LPSTR or VT_BSTR, this field is ignored.
    uint            locale;
    ///The property to be applied to the chunk. See FULLPROPSPEC. If a filter requires that the same text have more than
    ///one property, it needs to emit the text once for each property in separate chunks.
    FULLPROPSPEC    attribute;
    ///The ID of the source of a chunk. The value of the <b>idChunkSource</b> member depends on the nature of the chunk:
    ///<ul> <li>If the chunk is a text-type property, the value of the <b>idChunkSource</b> member must be the same as
    ///the value of the <b>idChunk</b> member.</li> <li>If the chunk is an internal value-type property derived from
    ///textual content, the value of the <b>idChunkSource</b> member is the chunk ID for the text-type chunk from which
    ///it is derived.</li> <li>If the filter attributes specify to return only internal value-type properties, there is
    ///no content chunk from which to derive the current internal value-type property. In this case, the value of the
    ///<b>idChunkSource</b> member must be set to zero, which is an invalid chunk.</li> </ul>
    uint            idChunkSource;
    ///The offset from which the source text for a derived chunk starts in the source chunk.
    uint            cwcStartSource;
    ///The length in characters of the source text from which the current chunk was derived. A zero value signifies
    ///character-by-character correspondence between the source text and the derived text. A nonzero value means that no
    ///such direct correspondence exists.
    uint            cwcLenSource;
}

// Functions

///<p class="CCE_Message">[Indexing Service is unsupported as of Windows XP. Instead, use Windows Search for client side
///search and Microsoft Search Server Express for server side search.] Retrieves IFilter from path name for object.
///Params:
///    pwcsPath = A pointer to the full path of an object for which an IFilter interface pointer is to be returned. The path can
///               include a full filename or only the file name extension; for example, ".ext".
///    pUnkOuter = A pointer to the controlling IUnknown interface of the aggregate in which this storage object exists.
///    ppIUnk = A pointer to a variable that receives the IFilter interface pointer.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The operation was completed successfully.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> The function
///    was denied access to the filter file. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_HANDLE</b></dt> </dl> </td>
///    <td width="60%"> The function encountered an invalid handle, probably due to a low-memory situation. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The function received an
///    invalid parameter. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td
///    width="60%"> The function did not have sufficient memory or other resources to complete the operation. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unknown error has
///    occurred. </td> </tr> </table>
///    
@DllImport("query")
HRESULT LoadIFilter(const(PWSTR) pwcsPath, IUnknown pUnkOuter, void** ppIUnk);

@DllImport("query")
HRESULT LoadIFilterEx(const(PWSTR) pwcsPath, uint dwFlags, const(GUID)* riid, void** ppIUnk);

///<p class="CCE_Message">[Indexing Service is unsupported as of Windows XP. Instead, use Windows Search for client side
///search and Microsoft Search Server Express for server side search.] Retrieves the IFilter interface pointer for the
///specified storage object. This is especially useful when filtering the contents of a document and processing embedded
///OLE objects that are accessible through their <b>IStorage</b> interfaces.
///Params:
///    pStg = A pointer to the <b>IStorage</b> interface to be used to access the file.
///    pUnkOuter = A pointer to the controlling IUnknown interface of the aggregate in which this storage object exists.
///    ppIUnk = A pointer to an output variable that receives the IFilter interface pointer.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The operation was completed successfully.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> The function
///    was denied access to the path of the storage object. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_HANDLE</b></dt> </dl> </td> <td width="60%"> The function encountered an invalid handle, probably due to
///    a low-memory situation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
///    width="60%"> The function received an invalid parameter. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The function did not have sufficient memory or other
///    resources to complete the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td>
///    <td width="60%"> An unknown error has occurred. </td> </tr> </table>
///    
@DllImport("query")
HRESULT BindIFilterFromStorage(IStorage pStg, IUnknown pUnkOuter, void** ppIUnk);

///<p class="CCE_Message">[Indexing Service is unsupported as of Windows XP. Instead, use Windows Search for client side
///search and Microsoft Search Server Express for server side search.] Retrieves the IFilter interface pointer for the
///specified storage object. This is especially useful when filtering the contents of a document and processing embedded
///OLE objects accessible through their <b>IStream</b> interfaces.
///Params:
///    pStm = A pointer to the <b>IStream</b> interface to be used to access the file.
///    pUnkOuter = A pointer to the controlling IUnknown interface of the aggregate in which this stream object exists.
///    ppIUnk = A pointer to an output variable that receives the IFilter interface pointer.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The operation was completed successfully.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> The function
///    was denied access to the path of the storage object. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_HANDLE</b></dt> </dl> </td> <td width="60%"> The function encountered an invalid handle, probably due to
///    a low-memory situation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
///    width="60%"> The function received an invalid parameter. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> The function did not have sufficient memory or other
///    resources to complete the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td>
///    <td width="60%"> An unknown error has occurred. </td> </tr> </table>
///    
@DllImport("query")
HRESULT BindIFilterFromStream(IStream pStm, IUnknown pUnkOuter, void** ppIUnk);


// Interfaces

///> [!Note] > Indexing Service is no longer supported as of Windows XP and is unavailable for use as of Windows 8.
///Instead, use [Windows Search](/windows/desktop/search/-search-3x-wds-overview) for client side search and [Microsoft
///Search Server Express](https://www.microsoft.com/download/details.aspx?id=18914) for server side search. Handles
///phrases that word breakers parse from query text during query time.
@GUID("CC906FF0-C058-101A-B554-08002B33B0E6")
interface IPhraseSink : IUnknown
{
    ///Puts a small query-time phrase in the IPhraseSink object for WordBreaker.
    ///Params:
    ///    pwcNoun = A pointer to a buffer that contains a word being modified.
    ///    cwcNoun = The number of characters in <i>pwcNoun</i>. There is no limit on the size of a query-time phrase.
    ///    pwcModifier = A pointer to the word modifying <i>pwcNoun</i>.
    ///    cwcModifier = The number of characters in <i>pwcModifier</i>. There is no limit on the size of a query-time phrase.
    ///    ulAttachmentType = A wordbreaker-specific value which a wordbreaker can use to store additional information about the method of
    ///                       composition.
    ///Returns:
    ///    If this method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT PutSmallPhrase(const(PWSTR) pwcNoun, uint cwcNoun, const(PWSTR) pwcModifier, uint cwcModifier, 
                           uint ulAttachmentType);
    ///Puts a query-time phrase in the IPhraseSink object.
    ///Params:
    ///    pwcPhrase = A pointer to a buffer that contains a phrase.
    ///    cwcPhrase = The number of characters in <i>pwcPhrase</i>. There is no limit on the size of a query-time phrase.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The operation was completed
    ///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PSINK_E_QUERY_ONLY </b></dt> </dl> </td> <td
    ///    width="60%"> PutPhrase was called at index time instead of query time. </td> </tr> </table>
    ///    
    HRESULT PutPhrase(const(PWSTR) pwcPhrase, uint cwcPhrase);
}

///> [!Note] > Indexing Service is no longer supported as of Windows XP and is unavailable for use as of Windows 8.
///Instead, use [Windows Search](/windows/desktop/search/-search-3x-wds-overview) for client side search and [Microsoft
///Search Server Express](https://www.microsoft.com/download/details.aspx?id=18914) for server side search. Scans
///documents for text and properties (also called attributes). It extracts chunks of text from these documents,
///filtering out embedded formatting and retaining information about the position of the text. It also extracts chunks
///of values, which are properties of an entire document or of well-defined parts of a document. <b>IFilter</b> provides
///the foundation for building higher-level applications such as document indexers and application-independent viewers.
///For introductory information about how the <b>IFilter</b> interface works with documents and document properties, see
///Properties of Documents. For a synopsis and an example of how the <b>IFilter</b> interface processes a document, see
///Property Filtering and Property Indexing.
@GUID("89BCB740-6119-101A-BCB7-00DD010655AF")
interface IFilter : IUnknown
{
    ///> [!Note] > Indexing Service is no longer supported as of Windows XP and is unavailable for use as of Windows 8.
    ///Instead, use [Windows Search](/windows/desktop/search/-search-3x-wds-overview) for client side search and
    ///[Microsoft Search Server Express](https://www.microsoft.com/download/details.aspx?id=18914) for server side
    ///search. Initializes a filtering session.
    ///Params:
    ///    grfFlags = Values from the IFILTER_INIT enumeration for controlling text standardization, property output, embedding
    ///               scope, and IFilter access patterns.
    ///    cAttributes = The size of the attributes array. When nonzero, <i>cAttributes</i> takes precedence over attributes specified
    ///                  in <i>grfFlags</i>. If no attribute flags are specified and <i>cAttributes</i> is zero, the default is given
    ///                  by the PSGUID_STORAGE storage property set, which contains the date and time of the last write to the file,
    ///                  size, and so on; and by the PID_STG_CONTENTS 'contents' property, which maps to the main contents of the
    ///                  file. For more information about properties and property sets, see Property Sets.
    ///    aAttributes = Pointer to an array of FULLPROPSPEC structures for the requested properties. When <i>cAttributes</i> is
    ///                  nonzero, only the properties in <i>aAttributes</i> are returned.
    ///    pFlags = Information about additional properties available to the caller; from the IFILTER_FLAGS enumeration.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The operation was completed
    ///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL </b></dt> </dl> </td> <td width="60%">
    ///    File to filter was not previously loaded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG
    ///    </b></dt> </dl> </td> <td width="60%"> Count and contents of attributes do not agree. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>FILTER_E_PASSWORD </b></dt> </dl> </td> <td width="60%"> Access has been denied
    ///    because of password protection or similar security measures. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>FILTER_E_ACCESS </b></dt> </dl> </td> <td width="60%"> General access failures </td> </tr> </table>
    ///    
    int Init(uint grfFlags, uint cAttributes, const(FULLPROPSPEC)* aAttributes, uint* pFlags);
    ///> [!Note] > Indexing Service is no longer supported as of Windows XP and is unavailable for use as of Windows 8.
    ///Instead, use [Windows Search](/windows/desktop/search/-search-3x-wds-overview) for client side search and
    ///[Microsoft Search Server Express](https://www.microsoft.com/download/details.aspx?id=18914) for server side
    ///search. Positions the filter at the beginning of the next chunk, or at the first chunk if this is the first call
    ///to the <b>GetChunk</b> method, and returns a description of the current chunk.
    ///Params:
    ///    pStat = A pointer to a STAT_CHUNK structure containing a description of the current chunk.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The operation was completed
    ///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FILTER_E_END_OF_CHUNKS</b></dt> </dl> </td> <td
    ///    width="60%"> The previous chunk is the last chunk. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>FILTER_E_EMBEDDING_UNAVAILABLE</b></dt> </dl> </td> <td width="60%"> The next chunk is an embedding
    ///    and no content filter is available. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>FILTER_E_LINK_UNAVAILABLE</b></dt> </dl> </td> <td width="60%"> The next chunk is a link and no
    ///    content filter is available. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FILTER_E_PASSWORD</b></dt> </dl>
    ///    </td> <td width="60%"> Password or other security-related access failure. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>FILTER_E_ACCESS </b></dt> </dl> </td> <td width="60%"> General access failure. </td> </tr>
    ///    </table>
    ///    
    int GetChunk(STAT_CHUNK* pStat);
    ///> [!Note] > Indexing Service is no longer supported as of Windows XP and is unavailable for use as of Windows 8.
    ///Instead, use [Windows Search](/windows/desktop/search/-search-3x-wds-overview) for client side search and
    ///[Microsoft Search Server Express](https://www.microsoft.com/download/details.aspx?id=18914) for server side
    ///search. Retrieves text (text-type properties) from the current chunk, which must have a CHUNKSTATE enumeration
    ///value of CHUNK_TEXT.
    ///Params:
    ///    pcwcBuffer = On entry, the size of <i>awcBuffer</i> array in wide/Unicode characters. On exit, the number of Unicode
    ///                 characters written to <i>awcBuffer</i>.
    ///    awcBuffer = Text retrieved from the current chunk. Do not terminate the buffer with a character. Use a null-terminated
    ///                string. The null-terminated string should not exceed the size of the destination buffer.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The operation was completed
    ///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FILTER_E_NO_TEXT </b></dt> </dl> </td> <td
    ///    width="60%"> The <b>flags</b> member of the STAT_CHUNK structure for the current chunk does not have a value
    ///    of CHUNK_TEXT. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FILTER_E_NO_MORE_TEXT </b></dt> </dl> </td> <td
    ///    width="60%"> All the text in the current chunk has been returned. Additional calls to the GetText method
    ///    should return this error until the IFilter::GetChunk method has been called successfully. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>FILTER_S_LAST_TEXT </b></dt> </dl> </td> <td width="60%"> As an optimization,
    ///    the last call that returns text can return FILTER_S_LAST_TEXT, indicating that the next call to the GetText
    ///    method will return FILTER_E_NO_MORE_TEXT. This optimization can save time by eliminating unnecessary calls to
    ///    <b>GetText</b>. </td> </tr> </table>
    ///    
    int GetText(uint* pcwcBuffer, PWSTR awcBuffer);
    ///> [!Note] > Indexing Service is no longer supported as of Windows XP and is unavailable for use as of Windows 8.
    ///Instead, use [Windows Search](/windows/desktop/search/-search-3x-wds-overview) for client side search and
    ///[Microsoft Search Server Express](https://www.microsoft.com/download/details.aspx?id=18914) for server side
    ///search. Retrieves a value (internal value-type property) from a chunk, which must have a CHUNKSTATE enumeration
    ///value of CHUNK_VALUE.
    ///Params:
    ///    ppPropValue = A pointer to an output variable that receives a pointer to the PROPVARIANT structure that contains the
    ///                  value-type property.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The operation was completed
    ///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FILTER_E_NO_MORE_VALUES </b></dt> </dl> </td> <td
    ///    width="60%"> The GetValue method has already been called on this chunk; this value should be returned until
    ///    the IFilter::GetChunk method has been called successfully and has advanced to the next chunk. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>FILTER_E_NO_VALUES</b></dt> </dl> </td> <td width="60%"> The current chunk
    ///    does not have a CHUNKSTATE enumeration value of CHUNK_VALUE. </td> </tr> </table>
    ///    
    int GetValue(PROPVARIANT** ppPropValue);
    ///> [!Note] > Indexing Service is no longer supported as of Windows XP and is unavailable for use as of Windows 8.
    ///Instead, use [Windows Search](/windows/desktop/search/-search-3x-wds-overview) for client side search and
    ///[Microsoft Search Server Express](https://www.microsoft.com/download/details.aspx?id=18914) for server side
    ///search. Retrieves an interface representing the specified portion of object. Currently reserved for future use.
    ///Params:
    ///    origPos = A FILTERREGION structure that contains the position of the text.
    ///    riid = A reference to the requested interface identifier.
    ///    ppunk = A pointer to a variable that receives the interface pointer requested in <i>riid</i>. Upon successful return,
    ///            *<i>ppunk</i> contains the requested interface pointer.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The operation was completed
    ///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%">
    ///    This method is not currently implemented. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>FILTER_W_REGION_CLIPPED</b></dt> </dl> </td> <td width="60%"> The filter could not bind the entire
    ///    region. </td> </tr> </table>
    ///    
    int BindRegion(FILTERREGION origPos, const(GUID)* riid, void** ppunk);
}


// GUIDs


const GUID IID_IFilter     = GUIDOF!IFilter;
const GUID IID_IPhraseSink = GUIDOF!IPhraseSink;
