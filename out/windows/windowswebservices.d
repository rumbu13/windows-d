// Written in the D programming language.

module windows.windowswebservices;

public import windows.core;
public import windows.com : HRESULT;
public import windows.security : CERT_CONTEXT, SecPkgContext_IssuerListInfoEx;
public import windows.systemservices : BOOL, DECIMAL, PWSTR;
public import windows.winrt : IInspectable;
public import windows.windowsandmessaging : HWND;
public import windows.windowsprogramming : FILETIME;

extern(Windows) @nogc nothrow:


// Enums


///Identifies each XML reader property is and its associated value. This enumeration is used within the
///WS_XML_READER_PROPERTY structure, which is used as a parameter to WsCreateReader, WsSetInput, WsSetInputToBuffer, and
///WsReadXmlBufferFromBytes. It is also used directly as a parameter to WsGetReaderProperty.
alias WS_XML_READER_PROPERTY_ID = int;
enum : int
{
    ///A <b>ULONG</b> that specifies the maximum depth of the document that the reader will permit. Depth is measured at
    ///any point by the number of nested start elements. A depth of 0 prevents any start elements from being read. This
    ///property defaults to 32. See WsCreateReader for security considerations.
    WS_XML_READER_PROPERTY_MAX_DEPTH                          = 0x00000000,
    ///A <b>BOOL</b> that specifies whether the reader will permit multiple elements and non-white space at the top
    ///level of the document. This property may not be set to <b>TRUE</b> with WS_XML_READER_MTOM_ENCODING. This
    ///property defaults to <b>FALSE</b>.
    WS_XML_READER_PROPERTY_ALLOW_FRAGMENT                     = 0x00000001,
    ///A <b>ULONG</b>that specifies the maximum number of attributes the reader will permit on an element. This property
    ///defaults to 128. See WsCreateReader for security considerations.
    WS_XML_READER_PROPERTY_MAX_ATTRIBUTES                     = 0x00000002,
    ///A <b>BOOL</b> that specifies if the reader should permit an xml declaration at the start of the document. This
    ///property defaults to <b>TRUE</b>.
    WS_XML_READER_PROPERTY_READ_DECLARATION                   = 0x00000003,
    ///A WS_CHARSET value that returns the character set of the xml document. This value is only available for text
    ///documents. If the reader was initialized with a WS_CHARSET_AUTO then it will automatically determine this value.
    ///The reader input source is streamed, then the reader must have enough data buffered to be able to inspect initial
    ///byte order marks and the xml declaration. See WsFillReader. If the reader was initialized with any other value,
    ///then this property simply returns that value.
    WS_XML_READER_PROPERTY_CHARSET                            = 0x00000004,
    ///A <b>ULONGLONG</b> that returns the 0 based row number of the node the reader is positioned on for text xml
    ///documents.
    WS_XML_READER_PROPERTY_ROW                                = 0x00000005,
    ///A <b>ULONGLONG</b> that returns the 0 based column number of the node the reader is positioned on for text xml
    ///documents.
    WS_XML_READER_PROPERTY_COLUMN                             = 0x00000006,
    ///A <b>ULONG</b> that specifies the trim size of the internal buffer used by the WS_XML_READER for performing
    ///UTF-16 to UTF-8 conversions. Increasing this value uses more memory, but can reduce allocations when processing
    ///UTF-16 encoded documents. This property defaults to 4096.
    WS_XML_READER_PROPERTY_UTF8_TRIM_SIZE                     = 0x00000007,
    ///A <b>ULONG</b> that specifies the size of the buffer the WS_XML_READER will use when configured to use
    ///WS_XML_READER_STREAM_INPUT. Increasing this value uses more memory, but can reduce the number of times the
    ///WS_READ_CALLBACK is invoked. This property defaults to 4096.
    WS_XML_READER_PROPERTY_STREAM_BUFFER_SIZE                 = 0x00000008,
    ///Indicates that WsReadStartAttribute has been called and the reader is positioned on attribute content.
    WS_XML_READER_PROPERTY_IN_ATTRIBUTE                       = 0x00000009,
    ///A <b>ULONG</b>used with WS_XML_READER_STREAM_INPUT in conjunction with WS_XML_READER_MTOM_ENCODING. This value
    ///specifies the maximum size of the root MIME part, which is the part that contains the xml portion of the
    ///document. It has no effect when used with other encodings, or when used with WS_XML_READER_BUFFER_INPUT. This
    ///property defaults to 65536.
    WS_XML_READER_PROPERTY_STREAM_MAX_ROOT_MIME_PART_SIZE     = 0x0000000a,
    ///A <b>ULONG</b>used with WS_XML_READER_STREAM_INPUT in conjunction with WS_XML_READER_MTOM_ENCODING. This value
    ///specifies the maximum size of any group of MIME headers that may appear in the document. It has no effect when
    ///used with other encodings, or when used with WS_XML_READER_BUFFER_INPUT. This property defaults to 256.
    WS_XML_READER_PROPERTY_STREAM_MAX_MIME_HEADERS_SIZE       = 0x0000000b,
    ///A <b>ULONG</b>used with WS_XML_READER_MTOM_ENCODING. This value specifies the maximum number of MIME parts that
    ///may appear in the document. It has no effect when used with other encodings. This property defaults to 4096.
    WS_XML_READER_PROPERTY_MAX_MIME_PARTS                     = 0x0000000c,
    ///A <b>BOOL</b> used with WS_XML_READER_TEXT_ENCODING. Setting this to <b>TRUE</b> permits character references of
    ///characters considered invalid by XML 1.0 to be accepted. Setting this property to <b>TRUE</b> may affect
    ///interoperability. This property defaults to <b>FALSE</b>.
    WS_XML_READER_PROPERTY_ALLOW_INVALID_CHARACTER_REFERENCES = 0x0000000d,
    WS_XML_READER_PROPERTY_MAX_NAMESPACES                     = 0x0000000e,
}

///The values for the XML canonicalization algorithms.
alias WS_XML_CANONICALIZATION_ALGORITHM = int;
enum : int
{
    ///The exclusive XML canonicalization algorithm represented by the URI 'http://www.w3.org/2001/10/xml-exc-c14n
    WS_EXCLUSIVE_XML_CANONICALIZATION_ALGORITHM               = 0x00000000,
    ///The exclusive XML canonicalization with comments algorithm defined in RFC 3741.
    WS_EXCLUSIVE_WITH_COMMENTS_XML_CANONICALIZATION_ALGORITHM = 0x00000001,
    ///The inclusive XML canonicalization algorithm defined in <a href="https://www.w3.org/TR/xml-c14n">Canonical XML
    ///Version 1.0</a>. Inclusive canonicalization can only be applied to entire xml documents.
    WS_INCLUSIVE_XML_CANONICALIZATION_ALGORITHM               = 0x00000002,
    ///The inclusive XML canonicalization with comments algorithm represented by the URI
    ///'http://www.w3.org/TR/2001/REC-xml-c14n-20010315
    WS_INCLUSIVE_WITH_COMMENTS_XML_CANONICALIZATION_ALGORITHM = 0x00000003,
}

///Identifies each XML canonicalization property and its associated value. This enumeration is used within the
///WS_XML_CANONICALIZATION_PROPERTY structure, which is used as a parameter to WsStartReaderCanonicalization and
///WsStartWriterCanonicalization.
alias WS_XML_CANONICALIZATION_PROPERTY_ID = int;
enum : int
{
    ///A WS_XML_CANONICALIZATION_ALGORITHM value that specifies the algorithm to be used for canonicalization. If this
    ///is not specified, the <b>WS_EXCLUSIVE_XML_CANONICALIZATION_ALGORITHM</b> is used.
    WS_XML_CANONICALIZATION_PROPERTY_ALGORITHM          = 0x00000000,
    ///A WS_XML_CANONICALIZATION_INCLUSIVE_PREFIXES structure that contains the set of prefixes to be treated as
    ///inclusive prefixes when using the exclusive canonicalization algorithm. If this is not specified, no prefix is
    ///treated as an inclusive prefix.
    WS_XML_CANONICALIZATION_PROPERTY_INCLUSIVE_PREFIXES = 0x00000001,
    ///A WS_XML_QNAME structure that contains the elements to be omitted during canonicalization. If one or more
    ///elements in the XML input match the specified name and namespace, then all such elements and the subtrees rooted
    ///at them are omitted from the canonical output. This property can be used to implement enveloped signatures where
    ///canonicalization needs to skip a signature element that is embedded within the XML content being canonicalized
    ///and signed. If this is not specified, no element is omitted from the output.
    WS_XML_CANONICALIZATION_PROPERTY_OMITTED_ELEMENT    = 0x00000002,
    WS_XML_CANONICALIZATION_PROPERTY_OUTPUT_BUFFER_SIZE = 0x00000003,
}

///Each xml writer property is identified by an ID and has an associated value. This enumeration is used within the
///WS_XML_WRITER_PROPERTY structure, which is used as a parameter to WsCreateWriter, WsSetOutput, WsSetOutputToBuffer,
///and WsWriteXmlBufferToBytes. It is also used directly as a parameter to WsGetWriterProperty.
alias WS_XML_WRITER_PROPERTY_ID = int;
enum : int
{
    ///A <b>ULONG</b> that specifies the maximum depth of the document that the writer will permit. Depth is measured at
    ///any point by the number of nested start elements. A depth of 0 prevents any start elements from being written.
    ///This property defaults to 32.
    WS_XML_WRITER_PROPERTY_MAX_DEPTH                          = 0x00000000,
    ///A WS_XML_WRITER_MTOM_ENCODING structure that specifies whether the writer will permit multiple elements and
    ///non-white space at the top level of the document. This property may not be set to <b>TRUE</b> with
    ///<b>WS_XML_WRITER_MTOM_ENCODING</b>. This property defaults to <b>FALSE</b>.
    WS_XML_WRITER_PROPERTY_ALLOW_FRAGMENT                     = 0x00000001,
    ///A <b>ULONG</b> that specifies the maximum number of attributes the writer will permit on an element. This
    ///property defaults to 128.
    WS_XML_WRITER_PROPERTY_MAX_ATTRIBUTES                     = 0x00000002,
    ///A <b>BOOL</b> that specifies if the writer should emit an appropriate xml declaration at the start of the
    ///document. This property defaults to <b>FALSE</b>.
    WS_XML_WRITER_PROPERTY_WRITE_DECLARATION                  = 0x00000003,
    ///A <b>ULONG</b> that specifies the how many spaces of indenting should be used to format the xml. If indent is
    ///zero, no formatting occurs. This property defaults to 0.
    WS_XML_WRITER_PROPERTY_INDENT                             = 0x00000004,
    ///A <b>ULONG</b> that specifies one of the following. If the writer is using WS_XML_WRITER_BUFFER_OUTPUT, then this
    ///property is the maximum number of bytes the writer will retain across calls to WsSetOutput for purposes of
    ///buffering output. If the writer is using WS_XML_WRITER_STREAM_OUTPUT, then this property is the maximum number of
    ///bytes the writer will retain across calls to WsSetOutput and WsFlushWriter for purposes of buffering output. This
    ///property has no effect when specified with WsSetOutputToBuffer. This property defaults to 4096.
    WS_XML_WRITER_PROPERTY_BUFFER_TRIM_SIZE                   = 0x00000005,
    ///A WS_CHARSET value that returns the character set the writer is using to encode the document. This value is only
    ///available for text documents.
    WS_XML_WRITER_PROPERTY_CHARSET                            = 0x00000006,
    ///A WS_BUFFERS structure that returns a set of buffers containing the generated xml bytes. If the writer is using
    ///WS_XML_WRITER_BUFFER_OUTPUT, then the all the generated bytes are returned, and the buffers are valid until
    ///WsSetOutput or WsFreeWriter is called. If the writer is using WS_XML_WRITER_MTOM_ENCODING, then there must be no
    ///open elements. The supporting MIME parts will be generated and included in the returned buffers. Once this
    ///occurs, any API that attempts to write further to the xml document will return <b>WS_E_INVALID_OPERATION</b>.
    ///(See Windows Web Services Return Values.) This property is not available when using WS_XML_WRITER_STREAM_OUTPUT.
    ///This property is not available on a writer that is set to a WS_XML_BUFFER. This may be less convenient but more
    ///efficient than using WS_XML_WRITER_PROPERTY_BYTES because the writer does not have to concatenate the buffers
    ///that comprise the document into a single buffer.
    WS_XML_WRITER_PROPERTY_BUFFERS                            = 0x00000007,
    ///A <b>ULONG</b> that specifies the maximum number of bytes the writer will buffer. If the writer is using
    ///WS_XML_WRITER_BUFFER_OUTPUT, then this is the maximum number of bytes that will buffered for the entire document.
    ///Calls to WsFlushWriter have no effect. If the writer is using WS_XML_WRITER_STREAM_OUTPUT, then this is the
    ///maxmimum amount of data that will be buffered between WsFlushWriter calls. This property has no effect when
    ///specified with WsSetOutputToBuffer.
    WS_XML_WRITER_PROPERTY_BUFFER_MAX_SIZE                    = 0x00000008,
    ///A WS_BUFFERS structure that returns a single buffer containing the generated xml bytes. If the writer is using
    ///WS_XML_WRITER_BUFFER_OUTPUT, then all the generated bytes are returned, and the buffer is valid until WsSetOutput
    ///or WsFreeWriter is called. If the writer is using WS_XML_WRITER_MTOM_ENCODING, then there must be no open
    ///elements. The supporting MIME parts will be generated and included in the returned buffers. Once this occurs, any
    ///API that attempts to write further to the xml document will return <b>WS_E_INVALID_OPERATION</b>. This property
    ///is not available when using WS_XML_WRITER_STREAM_OUTPUT. This property is not available on a writer that is set
    ///to a WS_XML_BUFFER. This may be more convenient but less efficient than using WS_XML_WRITER_PROPERTY_BUFFERS
    ///because the writer may need to concatenate the buffers that comprise the document into a single buffer.
    WS_XML_WRITER_PROPERTY_BYTES                              = 0x00000009,
    ///A <b>BOOL</b> that indicates that WsWriteStartAttribute has been called and the writer is positioned on attribute
    ///content.
    WS_XML_WRITER_PROPERTY_IN_ATTRIBUTE                       = 0x0000000a,
    ///A <b>ULONG</b> used with WS_XML_WRITER_MTOM_ENCODING. This specifies the maximum amount of data that will be
    ///buffered for purposes of writing the MIME parts. WsWriteBytes and WsPullBytes need to buffer data in order to
    ///emit the data as a separate MIME part that follows the document, and this can be used to limit how much is
    ///buffered. This property defaults to 65536.
    WS_XML_WRITER_PROPERTY_MAX_MIME_PARTS_BUFFER_SIZE         = 0x0000000b,
    ///A WS_BYTES structure that contains a buffer that the writer may use for encoding the xml document. This is useful
    ///when an upper bound on the size of the generated xml data is known, or the caller wants to own the buffer in
    ///which the bytes are placed. If the size specified is greater than or equal to
    ///WS_XML_WRITER_PROPERTY_BUFFER_MAX_SIZE, then the writer will not allocate from its internal buffers. This buffer
    ///may appear as one of the buffers returned by the property WS_XML_WRITER_PROPERTY_BUFFERSor
    ///<b>WS_XML_WRITER_PROPERTY_BYTES</b>. The caller must ensure that the buffer specified is valid for the lifetime
    ///of the writer.
    WS_XML_WRITER_PROPERTY_INITIAL_BUFFER                     = 0x0000000c,
    ///A <b>BOOL</b> used with WS_XML_WRITER_TEXT_ENCODING. Setting this to <b>TRUE</b> permits character references of
    ///characters considered invalid by XML 1.0 to be accepted. Setting this property to <b>TRUE</b> may affect
    ///interoperability. This property defaults to <b>FALSE</b>.
    WS_XML_WRITER_PROPERTY_ALLOW_INVALID_CHARACTER_REFERENCES = 0x0000000d,
    ///A <b>ULONG</b> that specifies the maximum number of xmlns unique declarations that may appear in scope at any
    ///point while writing the document. This property defaults to 32.
    WS_XML_WRITER_PROPERTY_MAX_NAMESPACES                     = 0x0000000e,
    ///A <b>ULONG</b> that specifies one of the following. If the writer is using WS_XML_WRITER_BUFFER_OUTPUT, then this
    ///property returns the number of bytes that have been written to the writer. If the writer is using
    ///WS_XML_WRITER_STREAM_OUTPUT, then this property returns the number of bytes that have been written to the writer
    ///since the last call to WsFlushWriter. If the writer is currently writing an element start tag, then the size of
    ///the start tag is not included in the value returned. This property is not available on a writer that was set
    ///using WsSetOutputToBuffer.
    WS_XML_WRITER_PROPERTY_BYTES_WRITTEN                      = 0x0000000f,
    ///A <b>ULONG</b> that returns the maximum number of bytes necessary to close any open elements. An application can
    ///use WS_XML_WRITER_PROPERTY_BYTES_WRITTEN and <b>WS_XML_WRITER_PROPERTY_BYTES_TO_CLOSE</b> to approximate how much
    ///additional data may be written to the document. When doing so, the application should take into account the
    ///encoding of the document being written. This property is not available on a writer that was set using
    ///WsSetOutputToBuffer.
    WS_XML_WRITER_PROPERTY_BYTES_TO_CLOSE                     = 0x00000010,
    ///A <b>BOOL</b>that controls how WsCopyNode copies elements with no content. When this property is set to
    ///<b>FALSE</b>, WsCopyNodepreserves whether each element is represented as a start/end tag pair, or as an empty
    ///element. When this property is set to <b>TRUE</b>, <b>WsCopyNode</b> wlll convert elements with no content to
    ///empty elements. The binary encoding does not support empty elements. When using WsCopyNode with a writer using
    ///the binary encoding this property has no effect either way. All empty elements are converted into elements with
    ///no content. By default, this property is <b>FALSE</b>. For an input XML string like: <pre class="syntax"
    ///xml:space="preserve"><code> &lt;?xml version="1.0" encoding="utf-8"?&gt; &lt;container&gt; &lt;emptyElement /&gt;
    ///&lt;emptyElementWithEndTag&gt;&lt;/emptyElementWithEndTag&gt; &lt;/container&gt;</code></pre> If this property is
    ///<b>FALSE</b>, WsCopyNodewill generate the following xml: <pre class="syntax" xml:space="preserve"><code> &lt;?xml
    ///version="1.0" encoding="utf-8"?&gt; &lt;container&gt; &lt;emptyElement /&gt;
    ///&lt;emptyElementWithEndTag&gt;&lt;/emptyElementWithEndTag&gt; &lt;/container&gt;</code></pre> If this property is
    ///<b>TRUE</b>, WsCopyNode will generate the following xml: <pre class="syntax" xml:space="preserve"><code> &lt;?xml
    ///version="1.0" encoding="utf-8"?&gt; &lt;container&gt; &lt;emptyElement /&gt; &lt;emptyElementWithEndTag /&gt;
    ///&lt;/container&gt;</code></pre>
    WS_XML_WRITER_PROPERTY_COMPRESS_EMPTY_ELEMENTS            = 0x00000011,
    WS_XML_WRITER_PROPERTY_EMIT_UNCOMPRESSED_EMPTY_ELEMENTS   = 0x00000012,
}

///Each XML buffer property is identified by an ID and has an associated value.
alias WS_XML_BUFFER_PROPERTY_ID = int;

///The type of WS_XML_TEXT structure.
alias WS_XML_TEXT_TYPE = int;
enum : int
{
    ///Characters encoded as UTF-8 bytes.
    WS_XML_TEXT_TYPE_UTF8      = 0x00000001,
    ///Characters encoded as UTF-16 bytes.
    WS_XML_TEXT_TYPE_UTF16     = 0x00000002,
    ///Bytes that represent base64 encoded text.
    WS_XML_TEXT_TYPE_BASE64    = 0x00000003,
    ///A Boolean value that represents the text "true" or "false"
    WS_XML_TEXT_TYPE_BOOL      = 0x00000004,
    ///A signed 32 bit integer value that represents the text of the value as base 10 characters.
    WS_XML_TEXT_TYPE_INT32     = 0x00000005,
    ///A signed 64 bit integer value that represents the text of the value as base 10 characters.
    WS_XML_TEXT_TYPE_INT64     = 0x00000006,
    ///An unsigned 64 bit integer value that represents the text of the value as base 10 characters.
    WS_XML_TEXT_TYPE_UINT64    = 0x00000007,
    ///An 4 byte floating point value that represents the text of the value as base 10 characters.
    WS_XML_TEXT_TYPE_FLOAT     = 0x00000008,
    ///An 8 byte floating point value that represents the text of the value as base 10 characters.
    WS_XML_TEXT_TYPE_DOUBLE    = 0x00000009,
    ///A 12 byte fixed point value that represents the text of the value as base 10 characters.
    WS_XML_TEXT_TYPE_DECIMAL   = 0x0000000a,
    ///A GUID that represents the text "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx".
    WS_XML_TEXT_TYPE_GUID      = 0x0000000b,
    ///A GUID that represents the text "urn:uuid:xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx".
    WS_XML_TEXT_TYPE_UNIQUE_ID = 0x0000000c,
    ///A datetime.
    WS_XML_TEXT_TYPE_DATETIME  = 0x0000000d,
    ///A timespan.
    WS_XML_TEXT_TYPE_TIMESPAN  = 0x0000000e,
    ///A qualified name.
    WS_XML_TEXT_TYPE_QNAME     = 0x0000000f,
    WS_XML_TEXT_TYPE_LIST      = 0x00000010,
}

///The type of WS_XML_NODE structure.
alias WS_XML_NODE_TYPE = int;
enum : int
{
    ///A start element. (e.g. &lt;a:purchaseOrder xmlns:a="http://tempuri.org" id="5"&gt;)
    WS_XML_NODE_TYPE_ELEMENT     = 0x00000001,
    ///Element, attribute, or CDATA content.
    WS_XML_NODE_TYPE_TEXT        = 0x00000002,
    ///An end element. (e.g. &lt;/purchaseOrder&gt;)
    WS_XML_NODE_TYPE_END_ELEMENT = 0x00000003,
    ///A comment. (For example, &lt;!--The message follows--&gt;)
    WS_XML_NODE_TYPE_COMMENT     = 0x00000004,
    ///The start of a CDATA section (i.e. &lt;![CDATA[)
    WS_XML_NODE_TYPE_CDATA       = 0x00000006,
    ///The end of a CDATA section (i.e. ]]&gt;)
    WS_XML_NODE_TYPE_END_CDATA   = 0x00000007,
    ///The final node of an xml stream.
    WS_XML_NODE_TYPE_EOF         = 0x00000008,
    ///The first node of an xml stream.
    WS_XML_NODE_TYPE_BOF         = 0x00000009,
}

///This enumeration identifies the various ways to move about an xml document.
alias WS_MOVE_TO = int;
enum : int
{
    ///Moves to the topmost element in the document. If there is no root element, then the position is left unchanged.
    WS_MOVE_TO_ROOT_ELEMENT     = 0x00000000,
    ///Moves to the next element with the same depth and parent as the current node. Text and comments are skipped. If
    ///no element is found, then the position is left unchanged.
    WS_MOVE_TO_NEXT_ELEMENT     = 0x00000001,
    ///Moves to the previous element with the same depth and parent as the current node. Text and comments are skipped.
    ///If no element is found, then the position is left unchanged.
    WS_MOVE_TO_PREVIOUS_ELEMENT = 0x00000002,
    ///Moves to the first child element below the current node. Text and comments are skipped. If no element is found,
    ///then the position is left unchanged.
    WS_MOVE_TO_CHILD_ELEMENT    = 0x00000003,
    ///If the current node is an element, then moves to its corresponding end element. Otherwise, the position is left
    ///unchanged.
    WS_MOVE_TO_END_ELEMENT      = 0x00000004,
    ///Moves to the element node containing the current node. End elements are considered the last child of their
    ///corresponding start element. If the current position is the root element, then the position will be moved to
    ///WS_XML_NODE_TYPE_BOF. If the current position is <b>WS_XML_NODE_TYPE_BOF</b>, then current position is left
    ///unchanged.
    WS_MOVE_TO_PARENT_ELEMENT   = 0x00000005,
    ///Moves to the next sibling of the current node. If the current node is an end element, then the position is left
    ///unchanged.
    WS_MOVE_TO_NEXT_NODE        = 0x00000006,
    ///Moves to the previous sibling of the current node. If the current node is the first child of an element, then the
    ///position is left unchanged.
    WS_MOVE_TO_PREVIOUS_NODE    = 0x00000007,
    ///Moves to the first child of the parent of the current node.
    WS_MOVE_TO_FIRST_NODE       = 0x00000008,
    ///Moves to the position logically before the first node in the document.
    WS_MOVE_TO_BOF              = 0x00000009,
    ///Moves to the position logically after the last node in the document.
    WS_MOVE_TO_EOF              = 0x0000000a,
    WS_MOVE_TO_CHILD_NODE       = 0x0000000b,
}

///The types of fixed-size primitives.
alias WS_VALUE_TYPE = int;
enum : int
{
    ///Used to indicate a BOOL value.
    WS_BOOL_VALUE_TYPE     = 0x00000000,
    ///Used to indicate a signed 8-bit integer.
    WS_INT8_VALUE_TYPE     = 0x00000001,
    ///Used to indicate a signed 16-bit integer.
    WS_INT16_VALUE_TYPE    = 0x00000002,
    ///Used to indicate a signed 32-bit integer.
    WS_INT32_VALUE_TYPE    = 0x00000003,
    ///Used to indicate a signed 64-bit integer.
    WS_INT64_VALUE_TYPE    = 0x00000004,
    ///Used to indicate an unsigned 8-bit integer.
    WS_UINT8_VALUE_TYPE    = 0x00000005,
    ///Used to indicate an unsigned 16-bit integer.
    WS_UINT16_VALUE_TYPE   = 0x00000006,
    ///Used to indicate an unsigned 32-bit integer.
    WS_UINT32_VALUE_TYPE   = 0x00000007,
    ///Used to indicate an unsigned 64-bit integer.
    WS_UINT64_VALUE_TYPE   = 0x00000008,
    ///Used to indicate a 32-bit floating point value.
    WS_FLOAT_VALUE_TYPE    = 0x00000009,
    ///Used to indicate a 64-bit floating point value.
    WS_DOUBLE_VALUE_TYPE   = 0x0000000a,
    ///Used to indicate a 96-bit fixed point value.
    WS_DECIMAL_VALUE_TYPE  = 0x0000000b,
    ///Used to indicate a date and time.
    WS_DATETIME_VALUE_TYPE = 0x0000000c,
    ///Used to indicate a signed 64-bit time period in 100 nanosecond units.
    WS_TIMESPAN_VALUE_TYPE = 0x0000000d,
    ///Used to indicate a GUID.
    WS_GUID_VALUE_TYPE     = 0x0000000e,
    WS_DURATION_VALUE_TYPE = 0x0000000f,
}

///The type of WS_XML_READER_INPUT structure.
alias WS_XML_READER_INPUT_TYPE = int;
enum : int
{
    WS_XML_READER_INPUT_TYPE_BUFFER = 0x00000001,
    WS_XML_READER_INPUT_TYPE_STREAM = 0x00000002,
}

///The type of WS_XML_READER_ENCODING structure.
alias WS_XML_READER_ENCODING_TYPE = int;
enum : int
{
    WS_XML_READER_ENCODING_TYPE_TEXT   = 0x00000001,
    WS_XML_READER_ENCODING_TYPE_BINARY = 0x00000002,
    WS_XML_READER_ENCODING_TYPE_MTOM   = 0x00000003,
    WS_XML_READER_ENCODING_TYPE_RAW    = 0x00000004,
}

///Identifies the character set of a document.
alias WS_CHARSET = int;
enum : int
{
    ///Specifies that the charset of a document should be determined automatically by inspecting the BOM (Byte Order
    ///Marks) of the document and the xml declaration if present.
    WS_CHARSET_AUTO    = 0x00000000,
    ///Specifies that the charset of a document is UTF-8.
    WS_CHARSET_UTF8    = 0x00000001,
    ///Specifies that the charset of a document is UTF-16LE.
    WS_CHARSET_UTF16LE = 0x00000002,
    WS_CHARSET_UTF16BE = 0x00000003,
}

///The type of WS_XML_WRITER_ENCODING structure.
alias WS_XML_WRITER_ENCODING_TYPE = int;
enum : int
{
    WS_XML_WRITER_ENCODING_TYPE_TEXT   = 0x00000001,
    WS_XML_WRITER_ENCODING_TYPE_BINARY = 0x00000002,
    WS_XML_WRITER_ENCODING_TYPE_MTOM   = 0x00000003,
    WS_XML_WRITER_ENCODING_TYPE_RAW    = 0x00000004,
}

///The type of WS_XML_WRITER_OUTPUT structure.
alias WS_XML_WRITER_OUTPUT_TYPE = int;
enum : int
{
    WS_XML_WRITER_OUTPUT_TYPE_BUFFER = 0x00000001,
    WS_XML_WRITER_OUTPUT_TYPE_STREAM = 0x00000002,
}

///Specifies the threading behavior of a callback (for example, a WS_ASYNC_CALLBACK).
alias WS_CALLBACK_MODEL = int;
enum : int
{
    ///This value is used to indicate that a callback is invoked short. When a callback is invoked short, it should
    ///avoid lengthy computation or lengthy blocking calls so that it can return to the caller quickly. During the time
    ///that a callback is executing short, other work items may not be able to be dequeued within the process. This can
    ///lead to starvation deadlock, an unresponsive system, or an underutilized system. If it is necessary to do IO
    ///within a callback that was invoked short, the best practice is to use asynchronous IO (instead of synchronous
    ///IO), to avoid lengthy blocking calls.
    WS_SHORT_CALLBACK = 0x00000000,
    ///This value is used to indicate that a callback is invoked long. A callback invoked long is not required to return
    ///to the caller quickly. However, long callbacks are a limited resource, so it is not always possible to invoke a
    ///callback long. Before invoking a callback long, the caller must ensure that there is another thread available to
    ///dequeue work as necessary. For example, if a caller needs to create a thread but is unable to, then it must
    ///invoke the callback short. All callbacks must be able to deal with being invoked short as well as long: <ul>
    ///<li>A callback that is invoked short but requires long can interpret this as an error condition, likely due to
    ///low resources. For example, calling CreateThread or QueueUserWorkItem in this situation is also likely to fail.
    ///If a callback is required to run long in a low resource situation, then a thread for this purpose must be
    ///reserved prior to initiating the async operation. </li> <li>A callback that is invoked long but expects short can
    ///go about its work normally. </li> </ul>
    WS_LONG_CALLBACK  = 0x00000001,
}

///The different encodings (message formats).
alias WS_ENCODING = int;
enum : int
{
    ///The binary XML encoding. Although the data is still in the XML infoset format, this encoding typically results in
    ///smaller messages that require less CPU to produce and consume. This encoding requires SOAP 1.2
    ///(WS_ENVELOPE_VERSION_SOAP_1_2).
    WS_ENCODING_XML_BINARY_1         = 0x00000000,
    ///The binary XML session encoding. Although the data is still in the XML infoset format, this encoding typically
    ///results in smaller messages that require less CPU to produce and consume. This encoding is like
    ///WS_ENCODING_XML_BINARY_1 but adds the feature of a session dictionary. Because this encoding requires a session,
    ///it may only be used on sessionful channel types (WS_CHANNEL_TYPE_DUPLEX_SESSION). The session dictionary is a
    ///data structure maintained by both the sending and receiving side of a channel. The session dictionary is used to
    ///optimize the transmission of string data. The first time a particular string is written, it is encoded using in
    ///the full string format. If the same string is written again, then it will use a smaller tokenized form, which can
    ///reduce message size. The writer of the string data selects which strings are candidates for the session
    ///dictionary by filling out the dictionary and id fields of the WS_XML_STRING structure. The size of the session
    ///dictionary is configured using WS_CHANNEL_PROPERTY_MAX_SESSION_DICTIONARY_SIZE. This encoding requires SOAP 1.2
    ///(WS_ENVELOPE_VERSION_SOAP_1_2).
    WS_ENCODING_XML_BINARY_SESSION_1 = 0x00000001,
    ///The MTOM encoding. The MTOM encoding optimizes for binary data by avoiding the costs of converting binary data to
    ///base64 format. For messages containing large amounts of binary data, this encoding usually results in smaller
    ///messages that require less CPU to produce and consume than with a text encoding. This encoding is typically not
    ///as efficient as a binary encoding, however. The XML part of the MTOM package is written using WS_CHARSET_UTF8,
    ///but may be in any <b>WS_CHARSET</b>when read.
    WS_ENCODING_XML_MTOM_UTF8        = 0x00000002,
    ///The MTOM encoding. The MTOM encoding optimizes for binary data by avoiding the costs of converting binary data to
    ///base64 format. For messages containing large amounts of binary data, this encoding usually results in smaller
    ///messages that require less CPU to produce and consume than with a text encoding. This encoding is typically not
    ///as efficient as a binary encoding, however. The XML part of the MTOM package is written using WS_CHARSET_UTF16BE,
    ///but may be in any <b>WS_CHARSET</b>when read.
    WS_ENCODING_XML_MTOM_UTF16BE     = 0x00000003,
    ///The MTOM encoding. The MTOM encoding optimizes for binary data by avoiding the costs of converting binary data to
    ///base64 format. For messages containing large amounts of binary data, this encoding usually results in smaller
    ///messages that require less CPU to produce and consume than with a text encoding. This encoding is typically not
    ///as efficient as a binary encoding, however. The XML part of the MTOM package is written using WS_CHARSET_UTF16LE,
    ///but may be in any <b>WS_CHARSET</b>when read.
    WS_ENCODING_XML_MTOM_UTF16LE     = 0x00000004,
    ///The text encoding (XML 1.0 format). Data is written using WS_CHARSET_UTF8, but may be in any <b>WS_CHARSET</b>
    ///when read.
    WS_ENCODING_XML_UTF8             = 0x00000005,
    ///The text encoding (XML 1.0 format). Data is written using WS_CHARSET_UTF16BE, but may be in any <b>WS_CHARSET</b>
    ///when read.
    WS_ENCODING_XML_UTF16BE          = 0x00000006,
    ///The text encoding (XML 1.0 format). Data is written using WS_CHARSET_UTF16LE, but may be in any <b>WS_CHARSET</b>
    ///when read.
    WS_ENCODING_XML_UTF16LE          = 0x00000007,
    WS_ENCODING_RAW                  = 0x00000008,
}

///The different states that a channel can be in.
alias WS_CHANNEL_STATE = int;
enum : int
{
    WS_CHANNEL_STATE_CREATED   = 0x00000000,
    WS_CHANNEL_STATE_OPENING   = 0x00000001,
    WS_CHANNEL_STATE_ACCEPTING = 0x00000002,
    WS_CHANNEL_STATE_OPEN      = 0x00000003,
    WS_CHANNEL_STATE_FAULTED   = 0x00000004,
    WS_CHANNEL_STATE_CLOSING   = 0x00000005,
    WS_CHANNEL_STATE_CLOSED    = 0x00000006,
}

///Specifies whether a message is required when receiving from a channel.
alias WS_RECEIVE_OPTION = int;
enum : int
{
    ///A message is required to be received. If the channel does not have any more messages, then the function will
    ///fail.
    WS_RECEIVE_REQUIRED_MESSAGE = 0x00000001,
    WS_RECEIVE_OPTIONAL_MESSAGE = 0x00000002,
}

///Indicates the protocol stack to use for the channel.
alias WS_CHANNEL_BINDING = int;
enum : int
{
    ///SOAP over HTTP.
    WS_HTTP_CHANNEL_BINDING      = 0x00000000,
    ///SOAP over TCP.
    WS_TCP_CHANNEL_BINDING       = 0x00000001,
    ///SOAP over UDP.
    WS_UDP_CHANNEL_BINDING       = 0x00000002,
    ///A custom channel or listen implementation. For more information, see WS_CUSTOM_CHANNEL_CALLBACKS and
    ///WS_CUSTOM_LISTENER_CALLBACKS.
    WS_CUSTOM_CHANNEL_BINDING    = 0x00000003,
    WS_NAMEDPIPE_CHANNEL_BINDING = 0x00000004,
}

///Indicates the basic characteristics of the channel, such as whether it is sessionful, and what directions of
///communication are supported.
alias WS_CHANNEL_TYPE = int;
enum : int
{
    ///Input channels support Receive operations. They are used on the sender side. The WS_UDP_CHANNEL_BINDING supports
    ///this channel type when used with WsCreateChannelForListener.
    WS_CHANNEL_TYPE_INPUT          = 0x00000001,
    ///Output channels support Send operations. This channel type is not currently supported by any channel bindings.
    WS_CHANNEL_TYPE_OUTPUT         = 0x00000002,
    ///Sessionful channels provide channel-level correlation of all messages sent or received. This is a flag used to
    ///build WS_CHANNEL_TYPE_INPUT_SESSION, <b>WS_CHANNEL_TYPE_OUTPUT_SESSION</b>, and
    ///<b>WS_CHANNEL_TYPE_DUPLEX_SESSION</b>, but cannot be used alone.
    WS_CHANNEL_TYPE_SESSION        = 0x00000004,
    ///An input channel that supports a session. This channel type is not currently supported by any channel bindings.
    WS_CHANNEL_TYPE_INPUT_SESSION  = 0x00000005,
    ///An output channel that supports a session. This channel type is not currently supported by any channel bindings.
    WS_CHANNEL_TYPE_OUTPUT_SESSION = 0x00000006,
    ///An input/output channel. The WS_UDP_CHANNEL_BINDING supports this channel type when used with WsCreateChannel.
    WS_CHANNEL_TYPE_DUPLEX         = 0x00000003,
    ///An input/output channel that supports a session. The WS_TCP_CHANNEL_BINDING supports this channel type when used
    ///with WsCreateChannel or WsCreateChannelForListener.
    WS_CHANNEL_TYPE_DUPLEX_SESSION = 0x00000007,
    ///Request channels support Send followed by Receive. They are used on the client side for channels that support
    ///request-reply operations. The WS_HTTP_CHANNEL_BINDING supports this channel type when used with WsCreateChannel.
    ///Note that request channels provide built-in correlation of request replies. It is possible to do request-reply
    ///correlation on other channel types using the addressing headers (RelatesTo and MessageID).
    WS_CHANNEL_TYPE_REQUEST        = 0x00000008,
    WS_CHANNEL_TYPE_REPLY          = 0x00000010,
}

///Whether messages that are sent or received are streamed or buffered.
alias WS_TRANSFER_MODE = int;
enum : int
{
    ///Setting this flag means messages are delivered in chunks. The start of the message (opening tag, headers, and
    ///opening body tag) will be returned to the application when WsReadMessageStart completes. It is up to the
    ///application to call WsFillBody before reading each chunk of the message body. The end of the message (closing
    ///body and envelope tags) will be read when WsReadMessageEndis called. Not setting this flag means the entire
    ///message is read and buffered in memory before WsReadMessageStart indicates completion.
    WS_STREAMED_INPUT_TRANSFER_MODE  = 0x00000001,
    ///Setting this flag means messages are transmitted in chunks. The start of the message (opening envelope tag,
    ///headers, and opening body tag) will be transmitted when WsWriteMessageStartis called. It is up to the application
    ///to call WsFlushBody after writing each chunk of the message body to cause the chunk to be transmitted. Any
    ///remaining body data will be transmitted when WsWriteMessageEnd is called, along with the end of the message
    ///(closing body and envelope tags). Not setting this flag means the entire message is buffered in memory and is
    ///only transmitted once WsWriteMessageEnd is called.
    WS_STREAMED_OUTPUT_TRANSFER_MODE = 0x00000002,
    ///Messages that are written or read are buffered. This is equivalent to specifying neither
    ///WS_STREAMED_INPUT_TRANSFER_MODE nor <b>WS_STREAMED_OUTPUT_TRANSFER_MODE</b>.
    WS_BUFFERED_TRANSFER_MODE        = 0x00000000,
    ///Messages that are written or read are streamed. This is equivalent to specifying both
    ///WS_STREAMED_INPUT_TRANSFER_MODE and <b>WS_STREAMED_OUTPUT_TRANSFER_MODE</b>.
    WS_STREAMED_TRANSFER_MODE        = 0x00000003,
}

///Proxy setting indicates HTTP proxy setting for the channel with binding WS_HTTP_CHANNEL_BINDING. This is specified as
///part of WS_CHANNEL_PROPERTY_HTTP_PROXY_SETTING_MODE channel property.
alias WS_HTTP_PROXY_SETTING_MODE = int;
enum : int
{
    ///The channel will automatically detect the proxy setting based on the IE configuration for the user at the point
    ///the channel is opened. This is the default setting for the WS_HTTP_CHANNEL_BINDING.
    WS_HTTP_PROXY_SETTING_MODE_AUTO   = 0x00000001,
    ///No proxy will be used to service the request on the channel.
    WS_HTTP_PROXY_SETTING_MODE_NONE   = 0x00000002,
    WS_HTTP_PROXY_SETTING_MODE_CUSTOM = 0x00000003,
}

///Each channel property is identified by an ID and has an associated value. If a property is not specified when the
///channel is created, then its default value is used.
alias WS_CHANNEL_PROPERTY_ID = int;
enum : int
{
    ///A <b>ULONG</b> used with WsCreateChannel, WsCreateChannelForListener or WsGetChannelProperty for
    ///WS_TCP_CHANNEL_BINDING, <b>WS_HTTP_CHANNEL_BINDING</b>, or <b>WS_NAMEDPIPE_CHANNEL_BINDING</b>. This value is a
    ///limit as to how big of a message may be received or sent by the channel. The limit specifies the maximum size of
    ///the envelope in bytes as it appears in its encoded wire form. The minimum value is 1. This property limits the
    ///amount of memory that the channel will allocate in order to receive or send a buffered message. When receiving
    ///with buffered input, the entire message is read into a buffer before the application has access to it. When
    ///sending with buffered output, the entire message is accumulated in a buffer before being sent. This property may
    ///only be specified when buffered input or output has been specified (either WS_STREAMED_INPUT_TRANSFER_MODE or
    ///<b>WS_STREAMED_OUTPUT_TRANSFER_MODE</b> have not been set). The default value is 65536. The
    ///WS_UDP_CHANNEL_BINDING always uses the value 65536.
    WS_CHANNEL_PROPERTY_MAX_BUFFERED_MESSAGE_SIZE            = 0x00000000,
    ///An <b>unsigned __int64</b> used with WsCreateChannel, WsCreateChannelForListener or WsGetChannelProperty
    ///WS_HTTP_CHANNEL_BINDING. This value is a limit as to how big of a streamed message may be received or sent for
    ///the channel. The limit specifies the maximum size of the envelope in bytes as it appears in its encoded wire
    ///form. The minimum value is 1. This property may only be specified when streamed input or output has been selected
    ///(WS_STREAMED_INPUT_TRANSFER_MODE or <b>WS_STREAMED_OUTPUT_TRANSFER_MODE</b>has been set). The default value is
    ///4194304.
    WS_CHANNEL_PROPERTY_MAX_STREAMED_MESSAGE_SIZE            = 0x00000001,
    ///A <b>ULONG</b>used with WsCreateChannel, WsCreateChannelForListener or WsGetChannelProperty for
    ///WS_HTTP_CHANNEL_BINDING. This value is a limit as to how big the start of a message may be. The start of a
    ///message consists of the envelope tag, the headers, and the body tag. The limit specifies the maximum size of the
    ///data in bytes as it appears in its encoded wire form. The minimum value is 1. This property may only be specified
    ///when streamed input has been selected (WS_STREAMED_INPUT_TRANSFER_MODE). This property limits the amount of
    ///memory that the channel will allocate in order to read the start of the message. For streaming input, the entire
    ///start of the message will be read into a buffer before the application is notified that the start of the message
    ///has been read. The default value is 16384.
    WS_CHANNEL_PROPERTY_MAX_STREAMED_START_SIZE              = 0x00000002,
    ///A <b>ULONG</b> used with WsCreateChannel, WsCreateChannelForListener or WsGetChannelProperty for
    ///WS_HTTP_CHANNEL_BINDING. This value is a limit as to how many bytes will be accumulated before WsFlushBody is
    ///called. This property may only be specified when streamed output has been selected
    ///(WS_STREAMED_OUTPUT_TRANSFER_MODE). This property limits the amount of memory that the channel will allocate in
    ///order to accumulated buffered data. For streaming output, the channel will accumulate data in a buffer until
    ///WsFlushBody is called. The default value is 65536.
    WS_CHANNEL_PROPERTY_MAX_STREAMED_FLUSH_SIZE              = 0x00000003,
    ///A WS_ENCODING value used with WsCreateChannel, WsCreateChannelForListener or WsGetChannelPropertyfor
    ///WS_TCP_CHANNEL_BINDING or <b>WS_HTTP_CHANNEL_BINDING</b>. This value specifies what encoding to use for the
    ///channel. The default value depends on the binding: <ul> <li> WS_HTTP_CHANNEL_BINDING uses WS_ENCODING_XML_UTF8.
    ///</li> <li> WS_TCP_CHANNEL_BINDING uses WS_ENCODING_XML_BINARY_SESSION_1. </li> <li> WS_NAMEDPIPE_CHANNEL_BINDING
    ///uses WS_ENCODING_XML_BINARY_SESSION_1. </li> </ul> The WS_UDP_CHANNEL_BINDING always uses the value
    ///WS_ENCODING_XML_UTF8.
    WS_CHANNEL_PROPERTY_ENCODING                             = 0x00000004,
    ///A WS_ENVELOPE_VERSION value used with WsCreateChannel, WsCreateChannelForListener or WsGetChannelProperty. This
    ///value specifies what envelope version to use for the channel. The envelope version of the channel must match that
    ///of the message used with the channel. This property is not supported with the WS_NAMEDPIPE_CHANNEL_BINDING. Named
    ///Pipe channels always use WS_ENVELOPE_VERSION_SOAP_1_2. The default value depends on the binding: <ul> <li>
    ///WS_HTTP_CHANNEL_BINDING uses WS_ENVELOPE_VERSION_NONE when the <b>WS_CHANNEL_PROPERTY_ENCODING</b> is
    ///WS_ENCODING_RAW, and <b>WS_ENVELOPE_VERSION_SOAP_1_2</b> for other encodings. </li> <li> WS_UDP_CHANNEL_BINDING
    ///uses WS_ENVELOPE_VERSION_SOAP_1_2. </li> <li> WS_TCP_CHANNEL_BINDING uses WS_ENVELOPE_VERSION_SOAP_1_2. </li>
    ///</ul>
    WS_CHANNEL_PROPERTY_ENVELOPE_VERSION                     = 0x00000005,
    ///A WS_ADDRESSING_VERSION value used with WsCreateChannel, WsCreateChannelForListener or WsGetChannelProperty. This
    ///value specifies what addressing version to use for the channel. The addressing version of the channel must match
    ///that of the message used with the channel. The default value depends on the binding: <ul> <li>
    ///WS_HTTP_CHANNEL_BINDING uses WS_ADDRESSING_VERSION_TRANSPORT when the <b>WS_CHANNEL_PROPERTY_ENCODING</b> is
    ///WS_ENCODING_RAW, and <b>WS_ADDRESSING_VERSION_1_0</b> for other encodings. </li> <li> WS_UDP_CHANNEL_BINDING uses
    ///WS_ADDRESSING_VERSION_1_0. </li> <li> WS_TCP_CHANNEL_BINDING uses WS_ADDRESSING_VERSION_1_0. </li> <li>
    ///WS_NAMEDPIPE_CHANNEL_BINDING uses WS_ADDRESSING_VERSION_1_0.</li> </ul> The WS_ADDRESSING_VERSION_TRANSPORT is
    ///only supported for WS_HTTP_CHANNEL_BINDING.
    WS_CHANNEL_PROPERTY_ADDRESSING_VERSION                   = 0x00000006,
    ///A <b>ULONG</b>used with WsCreateChannel, WsCreateChannelForListener or WsGetChannelProperty. This property is
    ///only valid for WS_TCP_CHANNEL_BINDING or <b>WS_NAMEDPIPE_CHANNEL_BINDING</b>. This value specifies the quota for
    ///number of bytes of session dictionary strings that will be transmitted or received when using a session-based
    ///encoding. The only session-based encoding supported currently is WS_ENCODING_XML_BINARY_SESSION_1, which is the
    ///default encoding for the WS_TCP_CHANNEL_BINDING. If the quota is reached on the receiving side, then the channel
    ///will fault. If the quota is reached on the sending side, then the channel will simply transmit the string without
    ///using the session dictionary. This value is ignored if not using a session-based encoding. The default value is
    ///2048.
    WS_CHANNEL_PROPERTY_MAX_SESSION_DICTIONARY_SIZE          = 0x00000007,
    ///A WS_CHANNEL_STATE value returned by WsGetChannelProperty. The returned value is a snapshot of the current state,
    ///so it is possible that the state may have changed before the caller has had a chance to examine the value.
    WS_CHANNEL_PROPERTY_STATE                                = 0x00000008,
    ///A WS_CALLBACK_MODEL value used with WsCreateChannel or WsGetChannelProperty. This value indicates the preferred
    ///async callback model when issuing async operations for the channel. If using WsCreateChannelForListener see
    ///WS_LISTENER_PROPERTY_ASYNC_CALLBACK_MODEL. The default is WS_LONG_CALLBACK. Both the WS_SERVICE_HOST and
    ///WS_SERVICE_PROXY only support WS_LONG_CALLBACK as an acceptable value for this property.
    WS_CHANNEL_PROPERTY_ASYNC_CALLBACK_MODEL                 = 0x00000009,
    ///A WS_IP_VERSION value used with WsCreateChannel or WsGetChannelPropertyfor WS_TCP_CHANNEL_BINDING or
    ///<b>WS_UDP_CHANNEL_BINDING</b>. This property specifies which IP version that the channel should use to
    ///communicate with the remote endpoint. To specify the IP version to use for channels that are accepted, use the
    ///WS_LISTENER_PROPERTY_IP_VERSION listener property when creating the listener object. The default value is
    ///WS_IP_VERSION_AUTO.
    WS_CHANNEL_PROPERTY_IP_VERSION                           = 0x0000000a,
    ///A <b>ULONG</b> used with WsCreateChannel, WsSetChannelProperty, or <b>WsSetChannelProperty</b> for
    ///WS_HTTP_CHANNEL_BINDINGand WS_CHANNEL_TYPE_REQUEST. This timeout limits the amount of time that will be spent
    ///resolving the DNS name. The timeout value is in milliseconds, where the value INFINITE indicates no timeout. This
    ///property can be set in any channel state. The default value is INFINITE.
    WS_CHANNEL_PROPERTY_RESOLVE_TIMEOUT                      = 0x0000000b,
    ///A <b>ULONG</b> used with WsCreateChannel, WsSetChannelProperty, or WsGetChannelProperty for
    ///WS_TCP_CHANNEL_BINDING or <b>WS_NAMEDPIPE_CHANNEL_BINDING</b> on the client side. This timeout limits the amount
    ///of time that will be spent to connect to the remote machine and complete the net.tcp or net.pipe handshake. The
    ///timeout value is in milliseconds, where the value INFINITE indicates no timeout. To set or get the corresponding
    ///timeout on the server side, use (WS_LISTENER_PROPERTY_CONNECT_TIMEOUT). Used with WsCreateChannel,
    ///WsSetChannelProperty, or WsGetChannelPropertyfor WS_HTTP_CHANNEL_BINDING and WS_CHANNEL_TYPE_REQUEST. This
    ///timeout limits the amount of time that will be spent to connect to the HTTP server. The timeout value is in
    ///milliseconds, where the value INFINITE indicates no timeout. This property can be set in any channel state. The
    ///default value is 30000 (30 seconds). The WS_SERVICE_PROXY sets this timeout to INFINITE by default.
    WS_CHANNEL_PROPERTY_CONNECT_TIMEOUT                      = 0x0000000c,
    ///A <b>ULONG</b>used with WsCreateChannel, WsCreateChannelForListener, WsSetChannelProperty, or
    ///WsGetChannelProperty for WS_TCP_CHANNEL_BINDING or <b>WS_NAMEDPIPE_CHANNEL_BINDING</b>. This timeout limits the
    ///amount of time that will be spent sending the bytes of the message. The timeout value is in milliseconds, where
    ///the value INFINITE indicates no timeout. Used with WsCreateChannel, WsSetChannelProperty, or WsGetChannelProperty
    ///for WS_HTTP_CHANNEL_BINDING and WS_CHANNEL_TYPE_REQUEST. This timeout limits the amount of time that will be
    ///spent sending the HTTP headers and the bytes of the message. The timeout value is in milliseconds, where the
    ///value INFINITE indicates no timeout. This property can be set in any channel state. The default value is 30000
    ///(30 seconds). Both WS_SERVICE_HOST and WS_SERVICE_PROXY set this timeout to INFINITE by default.
    WS_CHANNEL_PROPERTY_SEND_TIMEOUT                         = 0x0000000d,
    ///A <b>ULONG</b>used with WsCreateChannel, WsSetChannelProperty, or <b>WsSetChannelProperty</b> for
    ///WS_HTTP_CHANNEL_BINDINGand WS_CHANNEL_TYPE_REQUEST. This timeout limits the amount of time that will be spent
    ///waiting for all the response headers to be received from the server. The timeout value is in milliseconds, where
    ///the value INFINITE indicates no timeout. This property can be set in any channel state. The default value is
    ///30000 (30 seconds). The WS_SERVICE_PROXY sets this timeout to INFINITE.
    WS_CHANNEL_PROPERTY_RECEIVE_RESPONSE_TIMEOUT             = 0x0000000e,
    ///A <b>ULONG</b> used with WsCreateChannel, WsCreateChannelForListener, WsSetChannelProperty, or
    ///WsGetChannelProperty, for WS_TCP_CHANNEL_BINDING or <b>WS_NAMEDPIPE_CHANNEL_BINDING</b>. This timeout limits the
    ///amount of time that will be spent receiving the the bytes of the message. The timeout value is in milliseconds,
    ///where the value INFINITE indicates no timeout. Used with WsCreateChannel, WsSetChannelProperty, or
    ///WsGetChannelProperty for WS_HTTP_CHANNEL_BINDINGand WS_CHANNEL_TYPE_REQUEST. This timeout limits the amount of
    ///time that will be spent receiving the bytes of the message. The timeout value is in milliseconds, where the value
    ///INFINITE indicates no timeout. This timeout can be triggered by WsWriteMessageEnd, WsReadMessageStart, and
    ///WsReadMessageEnd. This property can be set in any channel state. The default value is 30000 (30 seconds). Both
    ///WS_SERVICE_HOST and WS_SERVICE_PROXY set this timeout to INFINITE by default.
    WS_CHANNEL_PROPERTY_RECEIVE_TIMEOUT                      = 0x0000000f,
    ///A <b>ULONG</b> used with WsCreateChannel, WsCreateChannelForListener WsSetChannelProperty, or
    ///WsGetChannelProperty for WS_TCP_CHANNEL_BINDING or <b>WS_NAMEDPIPE_CHANNEL_BINDING</b>. This timeout limits the
    ///amount of time that will be spent completing the the close net.tcp or net.pipe handshake. The timeout value is in
    ///milliseconds, where the value INFINITE indicates no timeout. This property can be set in any channel state. The
    ///default value is 30000 (30 seconds). The WS_SERVICE_PROXY sets this timeout to INFINITE by default.
    WS_CHANNEL_PROPERTY_CLOSE_TIMEOUT                        = 0x00000010,
    ///A <b>BOOL</b>used with WsCreateChannel for WS_HTTP_CHANNEL_BINDING, <b>WS_TCP_CHANNEL_BINDING</b>,
    ///<b>WS_NAMEDPIPE_CHANNEL_BINDING</b>, and <b>WS_UDP_CHANNEL_BINDING</b>. Used with WsGetChannelProperty for
    ///<b>WS_CUSTOM_CHANNEL_BINDING</b>. When this property is set to <b>TRUE</b> or not supplied when calling
    ///WsCreateChannel, more specific channel timeout properties (e.g. <b>WS_CHANNEL_PROPERTY_SEND_TIMEOUT</b>) takes
    ///precedence and behaves as documented. When this property is set to <b>FALSE</b>, all specific channel timeout
    ///properties are set to INFINITE unless they are explicitly specified. This property can be queried from a custom
    ///channel using WsGetChannelProperty, see WS_GET_CHANNEL_PROPERTY_CALLBACK for more details. The default value is
    ///<b>TRUE</b>. In order to implement their own timeout logic, WS_SERVICE_PROXY and WS_SERVICE_HOST sets this
    ///property to <b>FALSE</b> for the standard channels bindings and require custom channels to support it by querying
    ///and verifying that it is set to <b>FALSE</b>. More specific timeout properties can still be provided as described
    ///above.
    WS_CHANNEL_PROPERTY_ENABLE_TIMEOUTS                      = 0x00000011,
    ///A WS_TRANSFER_MODE value used with WsCreateChannel for WS_HTTP_CHANNEL_BINDING to control whether messages sent
    ///and received on the channel are buffered or streamed. The client and server may use different transfer modes and
    ///still be able to communicate. All channels support WsGetChannelProperty for this property. For channel bindings
    ///other than WS_HTTP_CHANNEL_BINDINGthe value is always WS_BUFFERED_TRANSFER_MODE. The default property value is
    ///WS_BUFFERED_TRANSFER_MODE. Note, only <b>WS_BUFFERED_TRANSFER_MODE</b> is used by Service Model for both
    ///WS_SERVICE_PROXY and WS_SERVICE_HOST. The only exception is around using message contracts on WS_SERVICE_HOST,
    ///where <b>WS_STREAMED_OUTPUT_TRANSFER_MODE</b> is allowed. WS_STREAMED_OUTPUT_TRANSFER_MODE with
    ///WS_CHANNEL_TYPE_REQUEST requires Windows Vista and above, and supports only
    ///<b>WS_HTTP_HEADER_AUTH_SCHEME_BASIC</b> when used with security.
    WS_CHANNEL_PROPERTY_TRANSFER_MODE                        = 0x00000012,
    ///A <b>ULONG</b>used with WsCreateChannel, WsSetChannelProperty, or WsGetChannelProperty for WS_UDP_CHANNEL_BINDING
    ///with WS_CHANNEL_TYPE_DUPLEX to indicate which adapter should be used when sending to a multicast address. The
    ///value is the interface index of the adapter. If this property is not set, or is 0, then the default adapter for
    ///the machine is used. This may not be appropriate for machines with multiple adapters. This property can be set in
    ///any channel state. The default property value is 0.
    WS_CHANNEL_PROPERTY_MULTICAST_INTERFACE                  = 0x00000013,
    ///A <b>ULONG</b>used with WsCreateChannel or WsGetChannelProperty for WS_UDP_CHANNEL_BINDING with
    ///WS_CHANNEL_TYPE_DUPLEX to specify the max number of hops that a UDP message can travel. The default property
    ///value is 1.
    WS_CHANNEL_PROPERTY_MULTICAST_HOPS                       = 0x00000014,
    ///A WS_ENDPOINT_ADDRESS structure used with WsGetChannelProperty for WS_UDP_CHANNEL_BINDING with
    ///WS_CHANNEL_TYPE_DUPLEX to retrieve the endpoint address of the remote party for the channel. The fields of the
    ///returned WS_ENDPOINT_ADDRESS structure are valid and constant until the channel is reset or freed. The caller
    ///should not modify the values the returned fields of the <b>WS_ENDPOINT_ADDRESS</b> point to. This property cannot
    ///be retrieved until the channel has reached the open state. This property is based on the source IP address that
    ///is received from the network, which may be spoofed or tampered with even if using a secure channel (depending on
    ///the network environment).
    WS_CHANNEL_PROPERTY_REMOTE_ADDRESS                       = 0x00000015,
    ///A SOCKADDR_STORAGEstructure used with WsCreateChannel for the following types of channels to retrieve the IP
    ///address of the remote party: <ul> <li> WS_CHANNEL_TYPE_DUPLEX_SESSION </li> <li> WS_CHANNEL_TYPE_DUPLEX </li>
    ///<li> WS_CHANNEL_TYPE_REPLY </li> </ul> This property cannot be retrieved until the channel has begun reading a
    ///message. This property is based on the source IP address that is received from the network, which may be spoofed
    ///or tampered with even if using a secure channel (depending on the network environment).
    WS_CHANNEL_PROPERTY_REMOTE_IP_ADDRESS                    = 0x00000016,
    ///A pointer to a <b>ULONGLONG</b>used with WsGetChannelProperty for WS_HTTP_CHANNEL_BINDING with
    ///WS_CHANNEL_TYPE_REPLY to retrieve an identifier that uniquely identifies the client connection. This property
    ///cannot be retrieved until the channel has begun reading a message. The connection ID uniquely identifies a
    ///connection while the listener object that the channel was accepted from remains open. A given reply channel
    ///instance is in no way correlated with a connection. Each time the channel is accepted, there may be a different
    ///connection ID (even if the total set of connections has not changed since the last accept). The connection ID can
    ///be used by an application to correlate state with a HTTP connection.
    WS_CHANNEL_PROPERTY_HTTP_CONNECTION_ID                   = 0x00000017,
    ///A WS_CUSTOM_CHANNEL_CALLBACKS structure used with WsCreateChannel or WsCreateChannelForListenerfor
    ///WS_CUSTOM_CHANNEL_BINDING. This property is used to specify callbacks that define the implementation of a custom
    ///channel. This property must be specified when WS_CUSTOM_CHANNEL_BINDING is used.
    WS_CHANNEL_PROPERTY_CUSTOM_CHANNEL_CALLBACKS             = 0x00000018,
    ///A pointer to an arbitrary sized data type used with WsCreateChannel or WsCreateChannelForListenerfor
    ///WS_CUSTOM_CHANNEL_BINDING. This property is used to specify parameters used to create the custom channel
    ///implementation. The size of the property is the size of the data type. The value of this property will be passed
    ///to the WS_CREATE_CHANNEL_CALLBACK. If this property is not specified, it's value is <b>NULL</b> and size is zero.
    WS_CHANNEL_PROPERTY_CUSTOM_CHANNEL_PARAMETERS            = 0x00000019,
    ///A <b>void *</b> used with WsGetChannelPropertyfor WS_CUSTOM_CHANNEL_BINDING. The size of the property is
    ///<b>sizeof(void*)</b>. The value corresponds to the channel instance value returned by the
    ///WS_CREATE_CHANNEL_CALLBACK. This property can be used to obtain the underlying channel instance for a custom
    ///channel. This allows a caller to directly interact with the instance for cases when the existing set of channel
    ///properties or channel functions is insufficient.
    WS_CHANNEL_PROPERTY_CUSTOM_CHANNEL_INSTANCE              = 0x0000001a,
    ///A WS_STRING structure used with WsGetChannelProperty for WS_HTTP_CHANNEL_BINDING or
    ///<b>WS_TCP_CHANNEL_BINDING</b>for channels created with WsCreateChannelForListener. This property is used on the
    ///server to obtain the URL that was passed to WsOpenChannel on the client. This URL may be different than the value
    ///in the WS_TO_HEADER if WsAddressMessage was used. The mapping of the transport URL to the underlying transport
    ///varies by the WS_CHANNEL_BINDING, as follows: <ul> <li> WS_HTTP_CHANNEL_BINDING. The transport URL is the request
    ///URL. </li> <li> WS_TCP_CHANNEL_BINDING. The transport URL is the URL that is present at the .NET framing layer.
    ///</li> </ul> This property is only available once the channel has been accepted using WsAcceptChannel. The caller
    ///should pass the address of a WS_STRING when retrieving this property. The returned string is a fully qualified
    ///URL in encoded form. The returned string is good until the channel is freed or reset.
    WS_CHANNEL_PROPERTY_TRANSPORT_URL                        = 0x0000001b,
    ///A <b>BOOL</b> used with WsCreateChannel, WsCreateChannelForListeneror WsGetChannelProperty or
    ///WsSetChannelPropertyfor WS_TCP_CHANNEL_BINDING. This property controls the TCP_NODELAY socket option value of the
    ///underlying socket. When this value is <b>FALSE</b>, the Nagle algorithm is used which can improve throughput by
    ///coalescing small messages. Setting this value to <b>TRUE</b> may decrease latency at the cost of throughput for
    ///small messages. The default value is <b>FALSE</b>.
    WS_CHANNEL_PROPERTY_NO_DELAY                             = 0x0000001c,
    ///A <b>BOOL</b>used with WsCreateChannel, WsCreateChannelForListenerfor WS_TCP_CHANNEL_BINDING. This property
    ///controls the SO_KEEPALIVE socket option value of the underlying socket. Setting this value to <b>TRUE</b> will
    ///cause keep-alive packets to be sent on the underlying socket, which may help detect when a remote party is no
    ///longer available. The default value is <b>FALSE</b>.
    WS_CHANNEL_PROPERTY_SEND_KEEP_ALIVES                     = 0x0000001d,
    ///A <b>ULONG</b> used with WsCreateChannel or WsCreateChannelForListenerfor WS_TCP_CHANNEL_BINDING. This property
    ///is measured in milliseconds. This property may only be specified when the
    ///<b>WS_CHANNEL_PROPERTY_SEND_KEEP_ALIVES</b>property has the value of <b>TRUE</b>. The value represents the amount
    ///of time before sending keep alive packets if the socket is not in use. The default value is 2 hours.
    WS_CHANNEL_PROPERTY_KEEP_ALIVE_TIME                      = 0x0000001e,
    ///A <b>ULONG</b>used with WsCreateChannel or WsCreateChannelForListenerfor WS_TCP_CHANNEL_BINDING. This property is
    ///measured in milliseconds. This property may only be specified when the
    ///<b>WS_CHANNEL_PROPERTY_SEND_KEEP_ALIVES</b>property has the value of <b>TRUE</b>. After the time specified in
    ///<b>WS_CHANNEL_PROPERTY_KEEP_ALIVE_TIME</b> has expired, the system will begin to send keep alive packets in an
    ///attempt to contact the remote party. This setting controls how often the system will send another packet (as a
    ///retry attempt). The default value is 1 second.
    WS_CHANNEL_PROPERTY_KEEP_ALIVE_INTERVAL                  = 0x0000001f,
    ///A <b>ULONG</b>used with WsCreateChannel for WS_HTTP_CHANNEL_BINDING. This property specifies the maximum number
    ///of connections that a client application may have against a HTTP server. Connections may be cached and re-used by
    ///other components within the same process accessing the same HTTP server. The default value is INFINITE (no
    ///limit).
    WS_CHANNEL_PROPERTY_MAX_HTTP_SERVER_CONNECTIONS          = 0x00000020,
    ///A <b>BOOL</b>used with WsGetChannelProperty for WS_TCP_CHANNEL_BINDING or <b>WS_NAMEDPIPE_CHANNEL_BINDING</b>
    ///with WS_CHANNEL_TYPE_DUPLEX_SESSION. This property indicates whether WsShutdownSessionChannel has been used to
    ///shut down the channel. The channel must be in WS_CHANNEL_STATE_OPEN or <b>WS_CHANNEL_STATE_FAULTED</b> state.
    WS_CHANNEL_PROPERTY_IS_SESSION_SHUT_DOWN                 = 0x00000021,
    ///A WS_CHANNEL_TYPE value used with WsGetChannelProperty for all channel types to query the type of the channel.
    ///The channel can be in any WS_CHANNEL_STATE.
    WS_CHANNEL_PROPERTY_CHANNEL_TYPE                         = 0x00000022,
    ///A <b>ULONG</b>used with WsCreateChannel, WsCreateChannelForListener or WsGetChannelProperty for
    ///WS_TCP_CHANNEL_BINDING, <b>WS_HTTP_CHANNEL_BINDING</b>, or <b>WS_NAMEDPIPE_CHANNEL_BINDING</b> to control the
    ///memory allocation characteristics for the messages on the channel. This property specifies the maximum amount of
    ///memory the channel will keep around after a message is reset. If all the messages a channel sees are all smaller
    ///than this size, then allocations for purposes of buffering the messages will be minimized. This property may only
    ///be specified when buffered input or output has been specified (either WS_STREAMED_INPUT_TRANSFER_MODE or
    ///<b>WS_STREAMED_OUTPUT_TRANSFER_MODE</b> have not been set). The default value is 65536. The
    ///WS_UDP_CHANNEL_BINDING always uses the value 65536.
    WS_CHANNEL_PROPERTY_TRIM_BUFFERED_MESSAGE_SIZE           = 0x00000023,
    ///A WS_CHANNEL_ENCODER structure used with WsCreateChannel or WsCreateChannelForListenerfor WS_TCP_CHANNEL_BINDING,
    ///<b>WS_HTTP_CHANNEL_BINDING</b>, or <b>WS_NAMEDPIPE_CHANNEL_BINDING</b> to provide a custom encoding of messages.
    ///This property cannot be used with WS_UDP_CHANNEL_BINDING.
    WS_CHANNEL_PROPERTY_ENCODER                              = 0x00000024,
    ///A WS_CHANNEL_DECODER structure used with WsCreateChannel or WsCreateChannelForListenerfor WS_TCP_CHANNEL_BINDING,
    ///<b>WS_HTTP_CHANNEL_BINDING</b>, or <b>WS_NAMEDPIPE_CHANNEL_BINDING</b> to provide a custom dencoding of messages.
    ///This property cannot be used with WS_UDP_CHANNEL_BINDING.
    WS_CHANNEL_PROPERTY_DECODER                              = 0x00000025,
    ///A WS_PROTECTION_LEVEL value used with WsGetChannelProperty for any channel type. This property indicates the
    ///security assurances provided by the channel. The value of this property depends on the security requirements
    ///requested for the channel.
    WS_CHANNEL_PROPERTY_PROTECTION_LEVEL                     = 0x00000026,
    ///A WS_COOKIE_MODE value used with WsCreateChannel with WS_HTTP_CHANNEL_BINDINGto control how HTTP cookies are
    ///handled. The default value is WS_AUTO_COOKIE_MODE.
    WS_CHANNEL_PROPERTY_COOKIE_MODE                          = 0x00000027,
    ///A WS_HTTP_PROXY_SETTING_MODE value used with WsCreateChannel with WS_HTTP_CHANNEL_BINDINGto control the HTTP
    ///proxy settings for the channel. The default value is WS_HTTP_PROXY_SETTING_MODE_AUTO.
    WS_CHANNEL_PROPERTY_HTTP_PROXY_SETTING_MODE              = 0x00000028,
    ///A WS_CUSTOM_HTTP_PROXY structure used with WsCreateChannel with WS_HTTP_CHANNEL_BINDINGto specify the custom
    ///custom setting for the HTTP channel. This property must be specified when
    ///<b>WS_CHANNEL_PROPERTY_HTTP_PROXY_SETTING_MODE</b> is set to WS_HTTP_PROXY_SETTING_MODE_CUSTOM. The default value
    ///is <b>NULL</b>.
    WS_CHANNEL_PROPERTY_CUSTOM_HTTP_PROXY                    = 0x00000029,
    ///A WS_HTTP_MESSAGE_MAPPING structure used with WsCreateChannel or WsCreateChannelForListenerfor
    ///WS_HTTP_CHANNEL_BINDING. This property value controls how an HTTP request or response is mapped into a message
    ///object. See WS_HTTP_MESSAGE_MAPPING for more information. The default value for this property is a
    ///WS_HTTP_MESSAGE_MAPPINGstructure is as follows: <ul> <li>requestMappingOptions: 0 </li>
    ///<li>requestHeaderMappings: none </li> <li>responseMappingOptions: 0 </li> <li>responseHeaderMappings: none </li>
    ///</ul> WS_HTTP_MESSAGE_MAPPING fields requestMappingOptions and responseMappingOptions must be 0 unless encoding
    ///is set to WS_ENCODING_RAW using channel property <b>WS_CHANNEL_PROPERTY_ENCODING</b>.
    WS_CHANNEL_PROPERTY_HTTP_MESSAGE_MAPPING                 = 0x0000002a,
    ///A <b>BOOL</b> used with WsCreateChannel for WS_HTTP_CHANNEL_BINDINGwith WS_CHANNEL_TYPE_REQUEST. This property
    ///value controls whether HTTP auto redirection is enabled. Setting this value to <b>TRUE</b> enables HTTP auto
    ///redirection. The default value is <b>FALSE</b>. If the <b>WS_CHANNEL_PROPERTY_HTTP_REDIRECT_CALLBACK_CONTEXT</b>
    ///property is specified, this property is ignored.
    WS_CHANNEL_PROPERTY_ENABLE_HTTP_REDIRECT                 = 0x0000002b,
    ///A WS_HTTP_REDIRECT_CALLBACK_CONTEXT structure used with WsCreateChannel for WS_HTTP_CHANNEL_BINDINGwith
    ///WS_CHANNEL_TYPE_REQUEST. This property value may be specified when more granular control of automatic HTTP
    ///redirection is needed. When this property is set, the specified callback routine will be called with the original
    ///endpoint URL and the new URL that the message is to be forwarded to. Callback return value is used to indicate
    ///whether the redirection should be allowed.
    WS_CHANNEL_PROPERTY_HTTP_REDIRECT_CALLBACK_CONTEXT       = 0x0000002c,
    ///A <b>BOOL</b> used with WsCreateChannel, WsSetChannelProperty, WsGetChannelProperty or WsCreateServiceProxy for
    ///WS_HTTP_CHANNEL_BINDINGand WS_CHANNEL_TYPE_REQUEST, or <b>WS_TCP_CHANNEL_BINDING</b>,
    ///<b>WS_NAMEDPIPE_CHANNEL_BINDING</b>, and <b>WS_UDP_CHANNEL_BINDING</b> on the client. When set to <b>TRUE</b>,
    ///Channel and Service Model functions return an error code when a fault is received. If the fault is recognized by
    ///this runtime, the corresponding error code is returned, otherwise <b>WS_E_ENDPOINT_FAULT_RECEIVED</b> is
    ///returned. (See Windows Web Services Return Values.) When set to <b>FALSE</b>, WsReceiveMessage and WsRequestReply
    ///return <b>WS_E_ENDPOINT_FAULT_RECEIVED</b> when a fault is received. The other channel functions return faults as
    ///regular messages and'WS_MESSAGE_PROPERTY_IS_FAULT can be used to distinguish faults from other messages. When
    ///this property is set to <b>TRUE</b> and used with WsCreateChannel or WsSetChannelProperty, it overrides the
    ///following behavior of <b>WS_CHANNEL_PROPERTY_ALLOW_UNSECURED_FAULTS</b>: if the fault is recognized by the
    ///runtime, an unsecured fault will not cause security verification of the fault message to fail even if
    ///<b>WS_CHANNEL_PROPERTY_ALLOW_UNSECURED_FAULTS</b> is set to <b>FALSE</b>. The status of the security verification
    ///can be determined by inspecting WS_MESSAGE_PROPERTY_PROTECTION_LEVEL. This does not apply to
    ///WS_UDP_CHANNEL_BINDING as it does not support security. When this property is set to <b>FALSE</b> or used with
    ///WsCreateServiceProxy or the fault is not recognized by the runtime, the behavior described in
    ///<b>WS_CHANNEL_PROPERTY_ALLOW_UNSECURED_FAULTS</b> applies without exception. Regardless of this property value,
    ///if an error code is returned as a result of receiving a fault, WsGetFaultErrorProperty may be used to query the
    ///details of the fault from the error object. This property can be set in any channel state. The default value is
    ///<b>TRUE</b>. If used with WsCreateServiceProxy, this property must be set to <b>TRUE</b>. Setting this property
    ///to <b>TRUE</b> can cause message security verification to be disabled for certain faults. Unverified faults may
    ///not be trustworthy.
    WS_CHANNEL_PROPERTY_FAULTS_AS_ERRORS                     = 0x0000002d,
    ///A <b>BOOL</b> used with WsCreateChannel, WsSetChannelProperty, or WsGetChannelProperty for
    ///WS_HTTP_CHANNEL_BINDINGand WS_CHANNEL_TYPE_REQUEST, or <b>WS_TCP_CHANNEL_BINDING</b> and
    ///<b>WS_NAMEDPIPE_CHANNEL_BINDING</b> on the client. When set to <b>TRUE</b>, unsecured faults received on a secure
    ///channel do not cause message security verification to fail. Instead the fault will be treated as if message
    ///security verification succeeded and handled as described in <b>WS_CHANNEL_PROPERTY_FAULTS_AS_ERRORS</b>. The
    ///status of the security verification can be determined by inspecting WS_MESSAGE_PROPERTY_PROTECTION_LEVEL. When
    ///set to <b>FALSE</b>, message security verification of fault messages is handled like the verification of any
    ///other message. <b>WS_CHANNEL_PROPERTY_FAULTS_AS_ERRORS</b> may override this property for faults recognized by
    ///this runtime. This property only applies to message-level security verification and has no impact on transport
    ///security. This property can be set in any channel state. The default value is <b>FALSE</b>. Setting this property
    ///to <b>TRUE</b> causes message security verification for faults to be disabled. Unsecured faults may not be
    ///trustworthy.
    WS_CHANNEL_PROPERTY_ALLOW_UNSECURED_FAULTS               = 0x0000002e,
    ///A <b>WCHAR</b> pointer used with WsGetChannelProperty for WS_HTTP_CHANNEL_BINDINGand WS_CHANNEL_TYPE_REQUEST.
    ///Returns the Server Principal Name of the remote endpoint used for the last failed request. There is no guarantee
    ///that this property is available. The following are the neccessary (but not always sufficient) conditions for this
    ///property to be present: <ul> <li>The channel sent a request. </li> <li>The request failed due to mismatched HTTP
    ///header authentication schemes. See WS_HTTP_HEADER_AUTH_SECURITY_BINDING. </li> <li>The remote endpoint supports
    ///the "Nego2" authentication scheme. </li> </ul> This property is only available on Windows 7 and above.
    WS_CHANNEL_PROPERTY_HTTP_SERVER_SPN                      = 0x0000002f,
    ///A <b>WCHAR</b> pointer used with WsGetChannelProperty for WS_HTTP_CHANNEL_BINDINGand WS_CHANNEL_TYPE_REQUEST.
    ///Returns the Server Principal Name of the HTTP proxy server used for the last failed request. There is no
    ///guarantee that this property is available. The following are the necessary (but not always sufficient) conditions
    ///for this property to be present: <ul> <li>The channel sent a request. </li> <li>The request failed due to
    ///mismatched HTTP header authentication schemes. See WS_HTTP_HEADER_AUTH_SECURITY_BINDING. </li> <li>The HTTP proxy
    ///server supports the "Nego2" authentication scheme. </li> </ul> This property is only available on Windows 7 and
    ///above.
    WS_CHANNEL_PROPERTY_HTTP_PROXY_SPN                       = 0x00000030,
    WS_CHANNEL_PROPERTY_MAX_HTTP_REQUEST_HEADERS_BUFFER_SIZE = 0x00000031,
}

///An enumeration used to specify how to handle HTTP cookies.
alias WS_COOKIE_MODE = int;
enum : int
{
    ///In this mode, cookies are not processed by the client channel. If a server sends a cookie to the client, the
    ///client channel will ignore the cookie (it will not include the cookie value in subsequent requests). An
    ///application can use the WS_HTTP_HEADER_MAPPINGfeature to handle cookies manually, if desired.
    WS_MANUAL_COOKIE_MODE = 0x00000001,
    WS_AUTO_COOKIE_MODE   = 0x00000002,
}

///The properties available on the Context. Not all properties may be available at a given point on a context. All
///context properties are available through WsGetOperationContextProperty.
alias WS_OPERATION_CONTEXT_PROPERTY_ID = int;
enum : int
{
    ///This value is a handle to the underlying channel. This property is available to service operations , to the
    ///WS_SERVICE_MESSAGE_RECEIVE_CALLBACK, WS_SERVICE_ACCEPT_CHANNEL_CALLBACK and WS_SERVICE_CLOSE_CHANNEL_CALLBACK.
    WS_OPERATION_CONTEXT_PROPERTY_CHANNEL              = 0x00000000,
    ///The value represents the contract description. This property is available to service operations , to the
    ///WS_SERVICE_MESSAGE_RECEIVE_CALLBACK, WS_SERVICE_ACCEPT_CHANNEL_CALLBACK and WS_SERVICE_CLOSE_CHANNEL_CALLBACK.
    WS_OPERATION_CONTEXT_PROPERTY_CONTRACT_DESCRIPTION = 0x00000001,
    ///The value is a pointer to the host state specified on the service host as the WS_SERVICE_PROPERTY_HOST_USER_STATE
    ///service property. This property is available to service operations and to the
    ///WS_SERVICE_MESSAGE_RECEIVE_CALLBACK.
    WS_OPERATION_CONTEXT_PROPERTY_HOST_USER_STATE      = 0x00000002,
    ///The value is a pointer to the channel state specified through WS_SERVICE_ACCEPT_CHANNEL_CALLBACK. This property
    ///is available to service operations and to the WS_SERVICE_MESSAGE_RECEIVE_CALLBACK.
    WS_OPERATION_CONTEXT_PROPERTY_CHANNEL_USER_STATE   = 0x00000003,
    ///The value is a pointer to the underlying input message. This property is available to service operations and to
    ///the WS_SERVICE_MESSAGE_RECEIVE_CALLBACK.
    WS_OPERATION_CONTEXT_PROPERTY_INPUT_MESSAGE        = 0x00000004,
    ///The value is a pointer to the underlying output message. This property is available only to service operations.
    WS_OPERATION_CONTEXT_PROPERTY_OUTPUT_MESSAGE       = 0x00000005,
    ///The value is a pointer to the WS_HEAP. This property is available to a service operation. Please see the memory
    ///management section in service operations for usage.
    WS_OPERATION_CONTEXT_PROPERTY_HEAP                 = 0x00000006,
    WS_OPERATION_CONTEXT_PROPERTY_LISTENER             = 0x00000007,
    WS_OPERATION_CONTEXT_PROPERTY_ENDPOINT_ADDRESS     = 0x00000008,
}

///The type of the endpoint IDentity, used as a selector for subtypes of WS_ENDPOINT_IDENTITY.
alias WS_ENDPOINT_IDENTITY_TYPE = int;
enum : int
{
    ///Type ID for WS_DNS_ENDPOINT_IDENTITY.
    WS_DNS_ENDPOINT_IDENTITY_TYPE     = 0x00000001,
    ///Type ID for WS_UPN_ENDPOINT_IDENTITY.
    WS_UPN_ENDPOINT_IDENTITY_TYPE     = 0x00000002,
    ///Type ID for WS_SPN_ENDPOINT_IDENTITY.
    WS_SPN_ENDPOINT_IDENTITY_TYPE     = 0x00000003,
    WS_RSA_ENDPOINT_IDENTITY_TYPE     = 0x00000004,
    WS_CERT_ENDPOINT_IDENTITY_TYPE    = 0x00000005,
    WS_UNKNOWN_ENDPOINT_IDENTITY_TYPE = 0x00000006,
}

///This identifies a type of extension within the extensions field of the WS_ENDPOINT_ADDRESS.
alias WS_ENDPOINT_ADDRESS_EXTENSION_TYPE = int;
enum : int
{
    WS_ENDPOINT_ADDRESS_EXTENSION_METADATA_ADDRESS = 0x00000001,
}

///A set of property values associated with the error. They are set and retrieved using WsGetErrorProperty and
///WsSetErrorProperty.
alias WS_ERROR_PROPERTY_ID = int;
enum : int
{
    ///The number of error strings (ULONG) available in the error object. Error strings might be added using
    ///WsAddErrorString. When WS_ERROR_PROPERTY_ORIGINAL_ERROR_CODEis present in the error object, the corresponding
    ///error text will be counted as an additional string in the returned number of error strings. This property is read
    ///only.
    WS_ERROR_PROPERTY_STRING_COUNT        = 0x00000000,
    ///If the error returned from the function was mapped to one of the standard WS_E_* errors, then this property is
    ///used to store the original implementation specific error code. Note that the original error code is specific to
    ///an particular implementation and version of the underlying libraries used by WWSAPI. It should not be expected to
    ///remain constant, as the libraries may change. The main purpose in exposing this error is for diagnostic purposes,
    ///as the application may take a look at original error code of underlying library that caused this error.
    ///Applications that take specific action based on the implementation specific error code will likely be broken when
    ///the implementation changes. If the error was not mapped from an implementation specific value to a standard
    ///error, then this property will have the value NOERROR. The default value is NOERROR.
    WS_ERROR_PROPERTY_ORIGINAL_ERROR_CODE = 0x00000001,
    WS_ERROR_PROPERTY_LANGID              = 0x00000002,
}

///The structured exception codes thrown by this component. These exceptions are fatal and should not be handled by the
///application.
alias WS_EXCEPTION_CODE = int;
enum : int
{
    ///This exception occurs to indicate that usage of the web services component has violated the API contract.
    WS_EXCEPTION_CODE_USAGE_FAILURE    = 0xc03d0000,
    WS_EXCEPTION_CODE_INTERNAL_FAILURE = 0xc03d0001,
}

///Information about a fault.
alias WS_FAULT_ERROR_PROPERTY_ID = int;
enum : int
{
    ///An optional WS_FAULT value that is the fault representation of the error. If no fault representation is present,
    ///then the value is <b>NULL</b>. To set the WS_FAULT value, pass a WS_FAULT* to WsSetFaultErrorProperty. The error
    ///object will make a copy of the WS_FAULT. The error object will also add the fault string of the fault to the set
    ///of error strings in the error object if the language of the fault string matches that of the error object. To get
    ///the WS_FAULT value, pass a WS_FAULT** to WsGetFaultErrorProperty, which will either return <b>NULL</b>
    ///(indicating no fault has been set), or will return a non-<b>NULL</b> pointer to the WS_FAULT. The non-<b>NULL</b>
    ///pointer is valid until WsResetError or WsFreeError are called for the error object. The default value is
    ///<b>NULL</b>.
    WS_FAULT_ERROR_PROPERTY_FAULT  = 0x00000000,
    ///An optional WS_XML_STRING value representing the action to use for the fault. If the length of the string is
    ///zero, then no action is present. To get the string value, pass a WS_XML_STRING* to WsGetFaultErrorProperty. The
    ///returned string is valid until WsResetError or WsFreeError are called for the error object. To set the string
    ///value, pass a WS_XML_STRING* to WsSetFaultErrorProperty. The error object will make a copy of the string. The
    ///default value is a zero-length string.
    WS_FAULT_ERROR_PROPERTY_ACTION = 0x00000001,
    WS_FAULT_ERROR_PROPERTY_HEADER = 0x00000002,
}

///Controls how much error information is included in a fault. Since the error object may contain sensitive data as part
///of the error string, it is not always appropriate to include the error strings information in all faults.
alias WS_FAULT_DISCLOSURE = int;
enum : int
{
    ///Use a generic fault string for all errors.
    WS_MINIMAL_FAULT_DISCLOSURE = 0x00000000,
    WS_FULL_FAULT_DISCLOSURE    = 0x00000001,
}

///Each heap property is identified by an ID and has an associated value.
alias WS_HEAP_PROPERTY_ID = int;
enum : int
{
    ///Used with WsGetHeapProperty. Returns the total number of bytes that can be allocated from the heap. The total
    ///number of bytes is defined as sum of the sizes passed in all the calls to WsAlloc since the heap was created /
    ///reset.
    WS_HEAP_PROPERTY_MAX_SIZE       = 0x00000000,
    ///Used with WsGetHeapProperty. Returns the maximum number of bytes of memory that the heap will retain after a call
    ///to WsResetHeap call. This should be treated an approximate value due to heap overhead. If the trim size is larger
    ///than the max size, then the size of the heap will not be trimmed.
    WS_HEAP_PROPERTY_TRIM_SIZE      = 0x00000001,
    ///Used with WsGetHeapProperty. Returns the current total number of bytes requested from the heap since the heap was
    ///created/reset.
    WS_HEAP_PROPERTY_REQUESTED_SIZE = 0x00000002,
    WS_HEAP_PROPERTY_ACTUAL_SIZE    = 0x00000003,
}

///The different states that a listener can be in.
alias WS_LISTENER_STATE = int;
enum : int
{
    WS_LISTENER_STATE_CREATED = 0x00000000,
    WS_LISTENER_STATE_OPENING = 0x00000001,
    WS_LISTENER_STATE_OPEN    = 0x00000002,
    WS_LISTENER_STATE_FAULTED = 0x00000003,
    WS_LISTENER_STATE_CLOSING = 0x00000004,
    WS_LISTENER_STATE_CLOSED  = 0x00000005,
}

///Each listener property is of type WS_LISTENER_PROPERTY, is identified by an ID, and has an associated value. If a
///property is not specified when the listener is created, then its default value is used.
alias WS_LISTENER_PROPERTY_ID = int;
enum : int
{
    ///Used with WsCreateListener or WsGetListenerPropertyfor WS_TCP_CHANNEL_BINDING. The accompanying <b>value</b>
    ///member of the WS_LISTENER_PROPERTY structure is a <b>ULONG</b>. This controls the maximum length of the queue of
    ///pending connections. If set to SOMAXCONN, the backlog will be set to a maximum reasonable value.
    WS_LISTENER_PROPERTY_LISTEN_BACKLOG                 = 0x00000000,
    ///Used with WsCreateListener or WsGetListenerPropertyfor WS_TCP_CHANNEL_BINDING or <b>WS_UDP_CHANNEL_BINDING</b>.
    ///The accompanying <b>value</b> member of the WS_LISTENER_PROPERTY structure is an WS_IP_VERSION value. This
    ///property specifies which IP version that the listener should use. The default value is WS_IP_VERSION_AUTO.
    WS_LISTENER_PROPERTY_IP_VERSION                     = 0x00000001,
    ///Used with WsGetListenerProperty for all channel types. The accompanying <b>value</b> member of the
    ///WS_LISTENER_PROPERTY structure is a WS_LISTENER_STATE value. Returns the current WS_LISTENER_STATE of the
    ///listener. The returned value is a snapshot of the current state, so it is possible that the state may have
    ///changed before the caller has had a chance to examine the value.
    WS_LISTENER_PROPERTY_STATE                          = 0x00000002,
    ///Used with WsCreateListener or WsGetListenerProperty for all channel types. The accompanying <b>value</b> member
    ///of the WS_LISTENER_PROPERTY structure is a WS_CALLBACK_MODEL value. This value indicates the preferred async
    ///callback model when issuing async operations for the listener or channels that are created for it using
    ///WsCreateChannelForListener. The default is WS_LONG_CALLBACK. The WS_SERVICE_HOST only supports WS_LONG_CALLBACK
    ///as an acceptable value for this property.
    WS_LISTENER_PROPERTY_ASYNC_CALLBACK_MODEL           = 0x00000003,
    ///Used with WsGetListenerProperty for all channel types. The accompanying <b>value</b> member of the
    ///WS_LISTENER_PROPERTY structure is a WS_CHANNEL_TYPE value. This property specifies the message exchange pattern
    ///of the channel being used.
    WS_LISTENER_PROPERTY_CHANNEL_TYPE                   = 0x00000004,
    ///Used with WsGetListenerProperty for all channel types. The accompanying <b>value</b> member of the
    ///WS_LISTENER_PROPERTY structure is a WS_CHANNEL_BINDING value. This property specifies the binding of the channel
    ///being used.
    WS_LISTENER_PROPERTY_CHANNEL_BINDING                = 0x00000005,
    ///Used with WsCreateListener or WsGetListenerPropertyfor WS_TCP_CHANNEL_BINDING and
    ///<b>WS_NAMEDPIPE_CHANNEL_BINDING</b>. The accompanying <b>value</b> member of the WS_LISTENER_PROPERTY structure
    ///is a <b>ULONG</b>. An accept operation will wait for an infinite amount of time to accept the underlying TCP
    ///socket or named pipe. This timeout corresponds to the amount of time dedicated to the net.tcp or net.pipe
    ///handshake that takes place between the client and service once the client connects. The timeout value is in
    ///milliseconds, where the value INFINITE indicates no timeout. Use the WS_CHANNEL_PROPERTY_CONNECT_TIMEOUT to set
    ///the corresponding value on the client side. The default value is 15000 (15 seconds).
    WS_LISTENER_PROPERTY_CONNECT_TIMEOUT                = 0x00000006,
    ///Used with WsCreateListener or WsGetListenerPropertyfor WS_UDP_CHANNEL_BINDING with WS_CHANNEL_TYPE_DUPLEXto
    ///indicate that the listener is listening on a multicast address. The accompanying <b>value</b> member of the
    ///WS_LISTENER_PROPERTY structure is a <b>BOOL</b>. Note that setting this property is not sufficient when listening
    ///on a multicast address. The set of interfaces must also be specified using the
    ///WS_LISTENER_PROPERTY_MULTICAST_INTERFACESproperty. The channel does not validate that the address is in fact a a
    ///multicast address, but it sets the reuse of the socket such that another process can also open the same port. The
    ///default value is <b>FALSE</b>.
    WS_LISTENER_PROPERTY_IS_MULTICAST                   = 0x00000007,
    ///Used with WsCreateListener or WsSetListenerPropertyfor WS_UDP_CHANNEL_BINDING with WS_CHANNEL_TYPE_DUPLEX. The
    ///accompanying <b>value</b> member of the WS_LISTENER_PROPERTY structure is an array of <b>ULONG</b> values. The
    ///size of the property is sizeof(ULONG) multiplied by the number of values. Each value represents the interface
    ///index of an adapter. The indices of adapters can be obtained using the GetAdaptersAddresses function. This value
    ///of the WS_LISTENER_PROPERTY_IS_MULTICAST property must be <b>TRUE</b> in order to use this property. The default
    ///value is an empty list (no interfaces).
    WS_LISTENER_PROPERTY_MULTICAST_INTERFACES           = 0x00000008,
    ///Used with WsCreateListener for WS_UDP_CHANNEL_BINDING with WS_CHANNEL_TYPE_DUPLEX. The accompanying <b>value</b>
    ///member of the WS_LISTENER_PROPERTY structure is a <b>BOOL</b>. This indicates whether or not messages sent on the
    ///loopback interface are received by this channel. If <b>TRUE</b>, then messages are received (otherwise, they will
    ///not be seen by the channel). This value of the WS_LISTENER_PROPERTY_IS_MULTICAST property must be <b>TRUE</b> in
    ///order to use this property. The default value is <b>TRUE</b>.
    WS_LISTENER_PROPERTY_MULTICAST_LOOPBACK             = 0x00000009,
    ///Used with WsCreateListener or WsGetListenerPropertyfor WS_HTTP_CHANNEL_BINDING with WS_CHANNEL_TYPE_REPLY. The
    ///accompanying <b>value</b> member of the WS_LISTENER_PROPERTY structure is a <b>ULONG</b>. This indicates the
    ///number of milliseconds to wait for clients to receive data from responses when WsCloseListeneris called. The
    ///purpose of this timeout is to allow clients time to continue receiving data from HTTP responses sent by the
    ///server before the HTTP server disconnects the client connections. The calculation of the timeout value used is as
    ///follows: <ul> <li>At the time that WsCloseListener is called, determine the time the last response was sent (the
    ///last response time). For the purposes of this timeout calculation, a response is recorded as sent once
    ///WsWriteMessageEndhas been called for the response. </li> <li>Calculate the difference between the current time
    ///and the last response time. </li> <li>If the difference is more than the timeout value, then the actual timeout
    ///used is zero. </li> <li>If the difference is less than or equal to the timeout value, then the actual timeout
    ///used is the timeout value minus the difference. </li> </ul> The default timeout value is 5000 (5 seconds).
    WS_LISTENER_PROPERTY_CLOSE_TIMEOUT                  = 0x0000000a,
    ///Used with WsCreateListener for WS_TCP_CHANNEL_BINDING, <b>WS_HTTP_CHANNEL_BINDING</b>,
    ///<b>WS_UDP_CHANNEL_BINDING</b>, or <b>WS_NAMEDPIPE_CHANNEL_BINDING</b>. The accompanying <b>value</b> member of
    ///the WS_LISTENER_PROPERTY structure is a <b>ULONG</b>. The property value contains a set of flags (see
    ///WS_URL_MATCHING_OPTIONS) which specify how to match the URL in the WS_TO_HEADER of any received messages. The
    ///default value is: <pre class="syntax" xml:space="preserve"><code> WS_MATCH_URL_THIS_HOST |
    ///WS_MATCH_URL_EXACT_PATH | WS_MATCH_URL_PORT | WS_MATCH_URL_NO_QUERY </code></pre>
    WS_LISTENER_PROPERTY_TO_HEADER_MATCHING_OPTIONS     = 0x0000000b,
    ///Used with WsCreateListener for WS_TCP_CHANNEL_BINDING or <b>WS_HTTP_CHANNEL_BINDING</b>. The accompanying
    ///<b>value</b> member of the WS_LISTENER_PROPERTY structure is a <b>ULONG</b>. The property value contains a set of
    ///flags (see WS_URL_MATCHING_OPTIONS) which specify how to match the transport URL of any accepted channels. See
    ///WS_CHANNEL_PROPERTY_TRANSPORT_URL for more information on the transport URL. The default value is: <pre
    ///class="syntax" xml:space="preserve"><code> WS_MATCH_URL_THIS_HOST | WS_MATCH_URL_EXACT_PATH | WS_MATCH_URL_PORT |
    ///WS_MATCH_URL_NO_QUERY </code></pre> This property only controls the verification of the message once it has been
    ///received by the process, not the routing of the message to the process (which is determined by the URL passed to
    ///WsOpenListener).
    WS_LISTENER_PROPERTY_TRANSPORT_URL_MATCHING_OPTIONS = 0x0000000c,
    ///Used with WsCreateListener for WS_CUSTOM_CHANNEL_BINDING. The accompanying <b>value</b> member of the
    ///WS_LISTENER_PROPERTY structure is a WS_CUSTOM_LISTENER_CALLBACKS structure. This property is used to specify
    ///callbacks that define the implementation of a custom listener. This property must be specified when
    ///WS_CUSTOM_CHANNEL_BINDINGis used.
    WS_LISTENER_PROPERTY_CUSTOM_LISTENER_CALLBACKS      = 0x0000000d,
    ///Used with WsCreateListener for WS_CUSTOM_CHANNEL_BINDING. The accompanying <b>value</b> member of the
    ///WS_LISTENER_PROPERTY structure is a pointer to an arbitrary sized data type. The size of the property is the size
    ///of the data type. This property is used to specify parameters used to create the custom listener implementation.
    ///The value of this property will be passed to the WS_CREATE_LISTENER_CALLBACK. If this property is not specified,
    ///it's value is <b>NULL</b> and size is zero.
    WS_LISTENER_PROPERTY_CUSTOM_LISTENER_PARAMETERS     = 0x0000000e,
    ///Used with WsGetChannelPropertyfor WS_CUSTOM_CHANNEL_BINDING. The accompanying <b>value</b> member of the
    ///WS_LISTENER_PROPERTY structure is a void* and size the property is sizeof(void*). The value corresponds to the
    ///listenerInstance value returned by the WS_CREATE_LISTENER_CALLBACK. This property can be used to obtain the
    ///underlying listener instance for a custom listener. This allows a caller to directly interact with the instance
    ///for cases when the existing set of listener properties or listener functions is insufficient.
    WS_LISTENER_PROPERTY_CUSTOM_LISTENER_INSTANCE       = 0x0000000f,
    WS_LISTENER_PROPERTY_DISALLOWED_USER_AGENT          = 0x00000010,
}

///Specifies an IP version.
alias WS_IP_VERSION = int;
enum : int
{
    ///Use IPv4.
    WS_IP_VERSION_4    = 0x00000001,
    ///Use IPv6.
    WS_IP_VERSION_6    = 0x00000002,
    WS_IP_VERSION_AUTO = 0x00000003,
}

///The different states that a message can be in.
alias WS_MESSAGE_STATE = int;
enum : int
{
    ///The initial state after a message has been created. In this state, there is no content in the message, and
    ///neither the header nor the body can be accessed.
    WS_MESSAGE_STATE_EMPTY       = 0x00000001,
    ///The message headers have been initialized, and can be accessed, but the body cannot be accessed. This state is
    ///used to build up all the headers prior to writing/sending them.
    WS_MESSAGE_STATE_INITIALIZED = 0x00000002,
    ///The body of the message is being read, for example when a message is received. In this state, the headers can be
    ///accessed, and the body can be read (see WsReadBody or WS_MESSAGE_PROPERTY_BODY_READER).
    WS_MESSAGE_STATE_READING     = 0x00000003,
    ///The body of the message is being written, for example when a message is being sent. In this state, the headers
    ///can be accessed, and the body can be written (see WsWriteBody or WS_MESSAGE_PROPERTY_BODY_WRITER).
    WS_MESSAGE_STATE_WRITING     = 0x00000004,
    ///The message body has been read or written (the end of the body has been read or written). The headers can still
    ///be accessed.
    WS_MESSAGE_STATE_DONE        = 0x00000005,
}

///Specifies what headers the WsInitializeMessageshould add to the message.
alias WS_MESSAGE_INITIALIZATION = int;
enum : int
{
    ///The headers of the message are empty.
    WS_BLANK_MESSAGE     = 0x00000000,
    ///The headers are initialized to be the same as the source message's headers.
    WS_DUPLICATE_MESSAGE = 0x00000001,
    ///If using WS_ADDRESSING_VERSION_0_9 or <b>WS_ADDRESSING_VERSION_1_0</b>, then a unique message ID is set as the
    ///MessageID header of the message. No other headers are added in the message.
    WS_REQUEST_MESSAGE   = 0x00000002,
    ///The ReplyTo header of the source message (an WS_ENDPOINT_ADDRESS) is used to address the message. The MessageID
    ///header of the source message is used to add a RelatesTo header to the message. If the message will contain a
    ///fault reply, then WS_FAULT_MESSAGE should be used instead.
    WS_REPLY_MESSAGE     = 0x00000003,
    WS_FAULT_MESSAGE     = 0x00000004,
}

///This enum is used to specify whether a header is expected to appear more than once in a message.
alias WS_REPEATING_HEADER_OPTION = int;
enum : int
{
    ///The header may appear more than once in the message.
    WS_REPEATING_HEADER = 0x00000001,
    WS_SINGLETON_HEADER = 0x00000002,
}

///Identifies a type of header.
alias WS_HEADER_TYPE = int;
enum : int
{
    ///The Action addressing header. This header can be used with the following WS_TYPEs: <ul> <li> WS_STRING_TYPE </li>
    ///<li> WS_XML_STRING_TYPE </li> <li> WS_WSZ_TYPE </li> </ul>
    WS_ACTION_HEADER     = 0x00000001,
    ///The To addressing header. This header can be used with the following WS_TYPEs: <ul> <li> WS_STRING_TYPE </li>
    ///<li> WS_XML_STRING_TYPE </li> <li> WS_WSZ_TYPE </li> </ul>
    WS_TO_HEADER         = 0x00000002,
    ///The MessageID addressing header. This header can be used with the following WS_TYPEs: <ul> <li> WS_UNIQUE_ID_TYPE
    ///</li> <li> WS_STRING_TYPE </li> <li> WS_XML_STRING_TYPE </li> <li> WS_WSZ_TYPE </li> </ul> This header is not
    ///supported for WS_ADDRESSING_VERSION_TRANSPORT.
    WS_MESSAGE_ID_HEADER = 0x00000003,
    ///The RelatesTo addressing header. This header can be used with the following WS_TYPEs: <ul> <li> WS_UNIQUE_ID_TYPE
    ///</li> <li> WS_STRING_TYPE </li> <li> WS_XML_STRING_TYPE </li> <li> WS_WSZ_TYPE </li> </ul> This header is not
    ///supported for WS_ADDRESSING_VERSION_TRANSPORT.
    WS_RELATES_TO_HEADER = 0x00000004,
    ///The From addressing header. This header is used with WS_ENDPOINT_ADDRESS_TYPE. This header is not supported for
    ///WS_ADDRESSING_VERSION_TRANSPORT.
    WS_FROM_HEADER       = 0x00000005,
    ///The ReplyTo addressing header. This header is used with WS_ENDPOINT_ADDRESS_TYPE. This header is not supported
    ///for WS_ADDRESSING_VERSION_TRANSPORT.
    WS_REPLY_TO_HEADER   = 0x00000006,
    WS_FAULT_TO_HEADER   = 0x00000007,
}

///Identifies the version of the specification used for the addressing headers.
alias WS_ADDRESSING_VERSION = int;
enum : int
{
    ///The message addressing headers correspond to version 0.9 (August 2004) of the addressing specification Web
    ///Services Addressing (WS-Addressing).
    WS_ADDRESSING_VERSION_0_9       = 0x00000001,
    ///The message addressing headers correspond to version 1.0 (May 2006) of the addressing specification Web Services
    ///Addressing 1.0 - Core.
    WS_ADDRESSING_VERSION_1_0       = 0x00000002,
    WS_ADDRESSING_VERSION_TRANSPORT = 0x00000003,
}

///The version of the specification used for the envelope structure.
alias WS_ENVELOPE_VERSION = int;
enum : int
{
    ///The XML namespace for this version is: 'http://schemas.xmlsoap.org/soap/envelope/'.
    WS_ENVELOPE_VERSION_SOAP_1_1 = 0x00000001,
    ///The XML namespace for this version is: 'http://www.w3.org/2003/05/soap-envelope'.
    WS_ENVELOPE_VERSION_SOAP_1_2 = 0x00000002,
    WS_ENVELOPE_VERSION_NONE     = 0x00000003,
}

///Each message property is of type WS_MESSAGE_PROPERTY, is identified by an ID, and has an associated value.
alias WS_MESSAGE_PROPERTY_ID = int;
enum : int
{
    ///This property is used with WsGetMessageProperty. The accompanying <b>value</b> member of the WS_MESSAGE_PROPERTY
    ///structure is the current WS_MESSAGE_STATE of the message. This property is available in all message states.
    WS_MESSAGE_PROPERTY_STATE                            = 0x00000000,
    ///This property is used with WsGetMessageProperty. The accompanying <b>value</b> member of the WS_MESSAGE_PROPERTY
    ///structure is the WS_HEAP of the message. The heap is owned by the message. A user of a message is free to make
    ///additional allocations within this heap. Allocations within the heap are free'd when a message is reset/freed.
    ///The user of the returned heap should not call WsResetHeapon the heap. This will result in undefined behavior. The
    ///message object will not use the heap object unless one of the message APIs is invoked. This property is available
    ///in all message states except WS_MESSAGE_STATE_EMPTY. Using the heap of an empty message will result in undefined
    ///behavior.
    WS_MESSAGE_PROPERTY_HEAP                             = 0x00000001,
    ///This property is used with WsGetMessageProperty. The accompanying <b>value</b> member of the WS_MESSAGE_PROPERTY
    ///structure is the WS_ENVELOPE_VERSION of the message. When creating a message using WsCreateMessage, the envelope
    ///version is specified as an explicit parameter (instead of as a property). This property may be specified when
    ///message properties are specified using the WS_MESSAGE_PROPERTIES structure. This property is available in all
    ///message states except WS_MESSAGE_STATE_EMPTY.
    WS_MESSAGE_PROPERTY_ENVELOPE_VERSION                 = 0x00000002,
    ///This property is used with WsGetMessageProperty. The accompanying <b>value</b> member of the WS_MESSAGE_PROPERTY
    ///structure is the WS_ADDRESSING_VERSION of the message. When creating a message using WsCreateMessage, the
    ///addressing version is specified as an explicit parameter (instead of as a property). This property may be
    ///specified when message properties are specified using the WS_MESSAGE_PROPERTIES structure. This property is
    ///available in all message states except WS_MESSAGE_STATE_EMPTY.
    WS_MESSAGE_PROPERTY_ADDRESSING_VERSION               = 0x00000003,
    ///This property is used with WsGetMessageProperty. The accompanying <b>value</b> member of the WS_MESSAGE_PROPERTY
    ///structure is a WS_XML_BUFFER that holds the headers of the message (as well as the envelope and body elements).
    ///This buffer is valid until the message is reset/freed. This property is available in all message states except
    ///WS_MESSAGE_STATE_EMPTY.
    WS_MESSAGE_PROPERTY_HEADER_BUFFER                    = 0x00000004,
    ///This property is used with WsGetMessageProperty. The accompanying <b>value</b> member of the WS_MESSAGE_PROPERTY
    ///structure is the WS_XML_NODE_POSITIONof the header element within the header buffer (the element that contains
    ///all the message headers as children). The header buffer itself can be obtained using
    ///WS_MESSAGE_PROPERTY_HEADER_BUFFER. An application can use the WS_XML_NODE_POSITION returned as a starting point
    ///when reading or writing headers manually (when not using WsSetHeader, WsGetHeader, WsGetCustomHeader or
    ///WsAddCustomHeader). For example, the position can be passed to WsSetWriterPosition or WsSetReaderPosition to
    ///position an XML Reader or XML Writerwithin the WS_XML_BUFFER containining the headers. Additionally, WsMoveReader
    ///or WsMoveWriter can be used to move relative to the position that was set. When the headers of a message are read
    ///(via WsReadMessageStart or WsReadEnvelopeStart, a header element is automatically added to the header buffer if
    ///one is not present in the message being read. When a message is initialized (via WsInitializeMessage), a header
    ///element is added automatically to the message. This property is available in all message states except
    ///WS_MESSAGE_STATE_EMPTY. The header position is valid until the message is reset or freed.
    WS_MESSAGE_PROPERTY_HEADER_POSITION                  = 0x00000005,
    ///This property is used with WsGetMessageProperty. The accompanying <b>value</b> member of the WS_MESSAGE_PROPERTY
    ///structure is a WS_XML_READER that can be used to read the body of the message. The reader is owned by the message
    ///object, and is valid only until either WsFreeMessage or WsResetMessage are called. This property is only
    ///available when the message is in WS_MESSAGE_STATE_READING state.
    WS_MESSAGE_PROPERTY_BODY_READER                      = 0x00000006,
    ///This property is used with WsGetMessageProperty. The accompanying <b>value</b> member of the WS_MESSAGE_PROPERTY
    ///structure is a WS_XML_WRITER that can be used to write the body of the message. This property is only available
    ///when the message is in WS_MESSAGE_STATE_WRITING state. The writer is owned by the message object, and is valid
    ///only until either WsFreeMessage or WsResetMessage are called.
    WS_MESSAGE_PROPERTY_BODY_WRITER                      = 0x00000007,
    ///This property is used with WsGetMessageProperty. The accompanying <b>value</b> member of the WS_MESSAGE_PROPERTY
    ///structure is a <b>BOOL</b> indicating whether the message has been addressed. When a message is created or reset,
    ///this property is set to <b>FALSE</b>. When a message is read (WsReadMessageStart or WsReadEnvelopeStart, then
    ///this property is set to <b>TRUE</b>. This property is available in all message states except
    ///WS_MESSAGE_STATE_EMPTY. See WsAddressMessage for more information.
    WS_MESSAGE_PROPERTY_IS_ADDRESSED                     = 0x00000008,
    ///This property is used with WsCreateMessage to specify the properties of the WS_HEAP associated with the message.
    ///The accompanying <b>value</b> member of the WS_MESSAGE_PROPERTY structure is of type WS_HEAP_PROPERTIES. The heap
    ///is used to buffer the headers of the message. The following heap properties may be specified: <ul> <li>
    ///WS_HEAP_PROPERTY_MAX_SIZE </li> <li> WS_HEAP_PROPERTY_TRIM_SIZE </li> </ul>
    WS_MESSAGE_PROPERTY_HEAP_PROPERTIES                  = 0x00000009,
    ///This property is used with WsCreateMessage to specify properties that apply to XML Readers that are used with the
    ///message. These XML Reader properties are used by the message object when reading headers. In addition, channels
    ///use these properties for the readers that they create to read messages. The accompanying <b>value</b> member of
    ///the WS_MESSAGE_PROPERTY structure is of type WS_XML_READER_PROPERTIES. The following properties may be specified:
    ///<ul> <li> WS_XML_READER_PROPERTY_MAX_DEPTH </li> <li> WS_XML_READER_PROPERTY_MAX_ATTRIBUTES </li> <li>
    ///WS_XML_READER_PROPERTY_READ_DECLARATION </li> <li> WS_XML_READER_PROPERTY_UTF8_TRIM_SIZE </li> <li>
    ///WS_XML_READER_PROPERTY_STREAM_BUFFER_SIZE </li> <li> WS_XML_READER_PROPERTY_STREAM_MAX_ROOT_MIME_PART_SIZE </li>
    ///<li> WS_XML_READER_PROPERTY_STREAM_MAX_MIME_HEADERS_SIZE </li> <li> WS_XML_READER_PROPERTY_MAX_MIME_PARTS </li>
    ///<li> WS_XML_READER_PROPERTY_ALLOW_INVALID_CHARACTER_REFERENCES </li> <li> WS_XML_READER_PROPERTY_MAX_NAMESPACES
    ///</li> </ul>
    WS_MESSAGE_PROPERTY_XML_READER_PROPERTIES            = 0x0000000a,
    ///This property is used with WsCreateMessage to specify the properties of the XML Writers that are used with the
    ///message. These XML Writer properties are used by the message object when writing headers. In addition, channels
    ///use these properties for the wrtiers that they create to write messages. The accompanying <b>value</b> member of
    ///the WS_MESSAGE_PROPERTY structure is of type WS_XML_WRITER_PROPERTIES. The following properties may be specified:
    ///<ul> <li> WS_XML_WRITER_PROPERTY_MAX_DEPTH </li> <li> WS_XML_WRITER_PROPERTY_MAX_ATTRIBUTES </li> <li>
    ///WS_XML_WRITER_PROPERTY_WRITE_DECLARATION </li> <li> WS_XML_WRITER_PROPERTY_BUFFER_TRIM_SIZE </li> <li>
    ///WS_XML_WRITER_PROPERTY_MAX_MIME_PARTS_BUFFER_SIZE </li> <li>
    ///WS_XML_WRITER_PROPERTY_ALLOW_INVALID_CHARACTER_REFERENCES </li> <li> WS_XML_WRITER_PROPERTY_MAX_NAMESPACES </li>
    ///</ul>
    WS_MESSAGE_PROPERTY_XML_WRITER_PROPERTIES            = 0x0000000b,
    ///This property is used with WsGetMessageProperty or WsSetMessagePropertyto indicate whether a message contains a
    ///fault. The accompanying <b>value</b> member of the WS_MESSAGE_PROPERTY structure is a <b>BOOL</b>. When a message
    ///is read (WsReadMessageStart or WsReadEnvelopeStart), this property is set according to whether the first element
    ///of the body is a fault element. An application can test this property as a way of deciding whether to read the
    ///body as a fault. To read the body as a fault, use WsReadBody with WS_FAULT_TYPE to obtain a WS_FAULT. When a
    ///message is written (WsWriteMessageStart or WsWriteEnvelopeStart) this property can be used to indicate whether or
    ///not the application will write a fault in the body. Some channels will use this information in order to determine
    ///how to send the message. For example, HTTP will send a 500 status code for faults instead of 200. When a message
    ///is initialized using WsInitializeMessage with WS_FAULT_MESSAGE, the property is set to <b>TRUE</b>. For other
    ///<b>WS_MESSAGE_INITIALIZATION</b> values, the property is set to <b>FALSE</b>. This property is available in all
    ///message states except WS_MESSAGE_STATE_EMPTY.
    WS_MESSAGE_PROPERTY_IS_FAULT                         = 0x0000000c,
    ///This property is used with WsCreateMessage to specify the maximum number of headers that will be allowed when
    ///processing the message headers. The accompanying <b>value</b> member of the WS_MESSAGE_PROPERTY structure is a
    ///<b>ULONG</b>. The purpose of this limit is to put an upper bound on the number of iterations spent scanning for a
    ///header. Since an application can directly modify the contents of the header buffer, this limit is not enforced in
    ///all cases. It is only enforced when one of the header access APIs are used (WsSetHeader, WsGetHeader,
    ///WsGetCustomHeader, or WsGetMappedHeader). The default value is 64.
    WS_MESSAGE_PROPERTY_MAX_PROCESSED_HEADERS            = 0x0000000d,
    ///This property is used with WsGetMessageProperty to retrieve the sender's username from a received message, if
    ///username/password based security is on, or if a custom channel has set the value. The accompanying <b>value</b>
    ///member of the WS_MESSAGE_PROPERTY structure is a WS_STRING structure. The returned value is good until the
    ///message is freed or reset. A custom channel can use WsSetMessageProperty to set the sender's username from the
    ///message if it supports username/password based security. The function will make a copy of the value specified.
    ///This property is available in all message states except WS_MESSAGE_STATE_EMPTY.
    WS_MESSAGE_PROPERTY_USERNAME                         = 0x0000000e,
    ///This property is used with WsGetMessageProperty to retrieve the sender's certificate from a received message as
    ///encoded bytes, if a certificate-based security mode (such as SSL) is on, or if a custom channel has set the
    ///value. The accompanying <b>value</b> member of the WS_MESSAGE_PROPERTY structure is a WS_BYTES structure. The
    ///returned value is good until the message is freed or reset. A custom channel can use WsSetMessageProperty to set
    ///the sender's certificate from a received message if it supports a certificate-based security mode. The function
    ///will make a copy of the value specified. This property is available in all message states except
    ///WS_MESSAGE_STATE_EMPTY.
    WS_MESSAGE_PROPERTY_ENCODED_CERT                     = 0x0000000f,
    ///This property is used with WsGetMessageProperty to retrieve the Windows token representing the sender from a
    ///received message. This property is available in the following cases: The accompanying <b>value</b> member of the
    ///WS_MESSAGE_PROPERTY structure is a <b>HANDLE</b>. <ul> <li> WS_TCP_SSPI_TRANSPORT_SECURITY_BINDING is being used.
    ///</li> <li> WS_SSL_TRANSPORT_SECURITY_BINDING is being used and the translation from client certificate to Windows
    ///token has been enabled at the http.sys config level. </li> <li>A custom channel implementation has set the value.
    ///</li> </ul> The returned value is good until the message is freed or reset. A custom channel can use
    ///WsSetMessageProperty to set the sender's certificate from a received message if it supports a certificate-based
    ///security mode. The function will duplicate the handle specified. This property is available in all message states
    ///except WS_MESSAGE_STATE_EMPTY.
    WS_MESSAGE_PROPERTY_TRANSPORT_SECURITY_WINDOWS_TOKEN = 0x00000010,
    ///This property is used with WsGetMessageProperty to retrieve the Windows token representing the sender from a
    ///received message, if the WS_HTTP_HEADER_AUTH_SECURITY_BINDING is used, or if a custom channel has set the value.
    ///The accompanying <b>value</b> member of the WS_MESSAGE_PROPERTY structure is a <b>HANDLE</b>. The returned value
    ///is good until the message is freed or reset. A custom channel can use WsSetMessagePropertyto set the windows
    ///token representing the sender from a received message. The function will duplicate the handle specified. This
    ///property is available in all message states except WS_MESSAGE_STATE_EMPTY.
    WS_MESSAGE_PROPERTY_HTTP_HEADER_AUTH_WINDOWS_TOKEN   = 0x00000011,
    ///This property is used with WsGetMessageProperty to retrieve the Windows token representing the sender from a
    ///received message, if a message security binding such as WS_KERBEROS_APREQ_MESSAGE_SECURITY_BINDING is used, or if
    ///a custom channel has set the value. The accompanying <b>value</b> member of the WS_MESSAGE_PROPERTY structure is
    ///a <b>HANDLE</b>. The returned value is good until the message is freed or reset. A custom channel can use
    ///WsSetMessageProperty to set the token representing the sender from a received message. The function will
    ///duplicate the handle specified. This property is available in all message states except WS_MESSAGE_STATE_EMPTY.
    WS_MESSAGE_PROPERTY_MESSAGE_SECURITY_WINDOWS_TOKEN   = 0x00000012,
    ///This property is used with WsGetMessageProperty to retrieve the SAML assertion representing the sender from a
    ///received message, if the WS_SAML_MESSAGE_SECURITY_BINDING is used on the server side, or if a custom channel has
    ///set the value. The accompanying <b>value</b> member of the WS_MESSAGE_PROPERTY structure is a WS_XML_BUFFER. The
    ///returned value is good until the message is freed or reset. A custom channel can use WsSetMessageProperty to set
    ///the SAML assertion representing the sender from a received message. The function will duplicate the buffer
    ///specified. This property is available in all message states except WS_MESSAGE_STATE_EMPTY.
    WS_MESSAGE_PROPERTY_SAML_ASSERTION                   = 0x00000013,
    ///This property is used with WsGetMessageProperty to retrieve the secure conversation handle if the
    ///WS_SECURITY_CONTEXT_MESSAGE_SECURITY_BINDING is used on the server side. The accompanying <b>value</b> member of
    ///the WS_MESSAGE_PROPERTY structure is a WS_SECURITY_CONTEXT. The returned value is good until the message is freed
    ///or reset.
    WS_MESSAGE_PROPERTY_SECURITY_CONTEXT                 = 0x00000014,
    WS_MESSAGE_PROPERTY_PROTECTION_LEVEL                 = 0x00000015,
}

///The type of the security binding, used as a selector for subtypes of WS_SECURITY_BINDING. In general, the type name
///of the security binding (one of the values defined here) specifies how the security token used with that security
///binding is obtained and used.
alias WS_SECURITY_BINDING_TYPE = int;
enum : int
{
    ///Type id for the security binding WS_SSL_TRANSPORT_SECURITY_BINDING.
    WS_SSL_TRANSPORT_SECURITY_BINDING_TYPE            = 0x00000001,
    ///Type id for the security binding WS_TCP_SSPI_TRANSPORT_SECURITY_BINDING.
    WS_TCP_SSPI_TRANSPORT_SECURITY_BINDING_TYPE       = 0x00000002,
    ///Type id for the security binding WS_HTTP_HEADER_AUTH_SECURITY_BINDING.
    WS_HTTP_HEADER_AUTH_SECURITY_BINDING_TYPE         = 0x00000003,
    ///Type id for the security binding WS_USERNAME_MESSAGE_SECURITY_BINDING.
    WS_USERNAME_MESSAGE_SECURITY_BINDING_TYPE         = 0x00000004,
    ///Type id for the security binding WS_KERBEROS_APREQ_MESSAGE_SECURITY_BINDING.
    WS_KERBEROS_APREQ_MESSAGE_SECURITY_BINDING_TYPE   = 0x00000005,
    ///Type id for the security binding WS_XML_TOKEN_MESSAGE_SECURITY_BINDING.
    WS_XML_TOKEN_MESSAGE_SECURITY_BINDING_TYPE        = 0x00000006,
    ///Type id for the security binding WS_SAML_MESSAGE_SECURITY_BINDING.
    WS_SAML_MESSAGE_SECURITY_BINDING_TYPE             = 0x00000007,
    ///Type id for the security binding WS_SECURITY_CONTEXT_MESSAGE_SECURITY_BINDING.
    WS_SECURITY_CONTEXT_MESSAGE_SECURITY_BINDING_TYPE = 0x00000008,
    WS_NAMEDPIPE_SSPI_TRANSPORT_SECURITY_BINDING_TYPE = 0x00000009,
}

///Defines the target for the HTTP header authentication security binding.
alias WS_HTTP_HEADER_AUTH_TARGET = int;
enum : int
{
    ///Indicates that the WS_HTTP_HEADER_AUTH_SECURITY_BINDING containing this setting authenticates to the server.
    WS_HTTP_HEADER_AUTH_TARGET_SERVICE = 0x00000001,
    WS_HTTP_HEADER_AUTH_TARGET_PROXY   = 0x00000002,
}

///Defines the specific SSP package to be used for Windows Integrated Authentication.
alias WS_WINDOWS_INTEGRATED_AUTH_PACKAGE = int;
enum : int
{
    ///The Kerberos package.
    WS_WINDOWS_INTEGRATED_AUTH_PACKAGE_KERBEROS = 0x00000001,
    ///The NTLM package.
    WS_WINDOWS_INTEGRATED_AUTH_PACKAGE_NTLM     = 0x00000002,
    WS_WINDOWS_INTEGRATED_AUTH_PACKAGE_SPNEGO   = 0x00000003,
}

///The WS-Security specification version to be used with message security and mixed-mode security.
alias WS_SECURITY_HEADER_VERSION = int;
enum : int
{
    ///WS-Security 1.0.
    WS_SECURITY_HEADER_VERSION_1_0 = 0x00000001,
    WS_SECURITY_HEADER_VERSION_1_1 = 0x00000002,
}

///Defines the WS-Trust specification version to be used with message security and mixed-mode security.
alias WS_TRUST_VERSION = int;
enum : int
{
    ///WS-Trust with the specification URI of http://schemas.xmlsoap.org/ws/2005/02/trust
    WS_TRUST_VERSION_FEBRUARY_2005 = 0x00000001,
    ///WS-Trust 1.3 with the specification URI of http://docs.oasis-open.org/ws-sx/ws-trust/200512
    WS_TRUST_VERSION_1_3           = 0x00000002,
}

///Defines which set of actions to use when negotiating security tokens using WS-Trust.
alias WS_REQUEST_SECURITY_TOKEN_ACTION = int;
enum : int
{
    ///Use the "request" action defined in WS-Trust.
    WS_REQUEST_SECURITY_TOKEN_ACTION_ISSUE         = 0x00000001,
    ///Use the "request" action defined in WS-SecureConversation.
    WS_REQUEST_SECURITY_TOKEN_ACTION_NEW_CONTEXT   = 0x00000002,
    WS_REQUEST_SECURITY_TOKEN_ACTION_RENEW_CONTEXT = 0x00000003,
}

///Defines the WS-SecureConversation specification version to be used with message security and mixed-mode security.
alias WS_SECURE_CONVERSATION_VERSION = int;
enum : int
{
    ///WS-SecureConversation with the specification URI of http://schemas.xmlsoap.org/ws/2005/02/sc
    WS_SECURE_CONVERSATION_VERSION_FEBRUARY_2005 = 0x00000001,
    WS_SECURE_CONVERSATION_VERSION_1_3           = 0x00000002,
}

alias WS_SECURE_PROTOCOL = int;
enum : int
{
    WS_SECURE_PROTOCOL_SSL2   = 0x00000001,
    WS_SECURE_PROTOCOL_SSL3   = 0x00000002,
    WS_SECURE_PROTOCOL_TLS1_0 = 0x00000004,
    WS_SECURE_PROTOCOL_TLS1_1 = 0x00000008,
    WS_SECURE_PROTOCOL_TLS1_2 = 0x00000010,
}

///With message security and mixed-mode security, this defines when a timestamp element should be generated and demanded
///in the WS-Security header.
alias WS_SECURITY_TIMESTAMP_USAGE = int;
enum : int
{
    ///Always generate a timestamp in each outgoing message and demand a timestamp be present in each incoming message,
    ///whether those messages are requests or replies.
    WS_SECURITY_TIMESTAMP_USAGE_ALWAYS        = 0x00000001,
    ///Do not use timestamps in requests or replies. It is an error to specify this value when a mixed-mode message
    ///signature is required in the WS-Security header.
    WS_SECURITY_TIMESTAMP_USAGE_NEVER         = 0x00000002,
    WS_SECURITY_TIMESTAMP_USAGE_REQUESTS_ONLY = 0x00000003,
}

///The layout rules applied to the elements of the WS-Security security header. This setting is relevant to message
///security bindings and mixed-mode security bindings.
alias WS_SECURITY_HEADER_LAYOUT = int;
enum : int
{
    ///The elements of the security header must follow a 'declare before use' layout. All security tokens must appear
    ///before their usage.
    WS_SECURITY_HEADER_LAYOUT_STRICT                   = 0x00000001,
    ///The elements of the security header can be in arbitrary order, including security tokens appearing after usage.
    WS_SECURITY_HEADER_LAYOUT_LAX                      = 0x00000002,
    ///The elements of the security header can be in arbitrary order as in WS_SECURITY_HEADER_LAYOUT_LAX, but the
    ///timestamp element must be the first element.
    WS_SECURITY_HEADER_LAYOUT_LAX_WITH_TIMESTAMP_FIRST = 0x00000003,
    WS_SECURITY_HEADER_LAYOUT_LAX_WITH_TIMESTAMP_LAST  = 0x00000004,
}

///Identifies the properties representing security algorithm knobs.
alias WS_SECURITY_ALGORITHM_PROPERTY_ID = int;

///Defines the security algorithms to be used with WS-Security. These values are relevant to message security bindings
///and mixed-mode security bindings.
alias WS_SECURITY_ALGORITHM_ID = int;
enum : int
{
    ///Default security algorithm for the particular algorithm type. See WS_SECURITY_ALGORITHM_SUITE for a description
    ///of the specific algorithm used when this value is set.
    WS_SECURITY_ALGORITHM_DEFAULT                                  = 0x00000000,
    ///http://www.w3.org/2001/10/xml-exc-c14n
    WS_SECURITY_ALGORITHM_CANONICALIZATION_EXCLUSIVE               = 0x00000001,
    ///http://www.w3.org/2001/10/xml-exc-c14n
    WS_SECURITY_ALGORITHM_CANONICALIZATION_EXCLUSIVE_WITH_COMMENTS = 0x00000002,
    ///http://www.w3.org/2000/09/xmldsig
    WS_SECURITY_ALGORITHM_DIGEST_SHA1                              = 0x00000003,
    ///http://www.w3.org/2001/04/xmlenc
    WS_SECURITY_ALGORITHM_DIGEST_SHA_256                           = 0x00000004,
    ///http://www.w3.org/2001/04/xmlenc
    WS_SECURITY_ALGORITHM_DIGEST_SHA_384                           = 0x00000005,
    ///http://www.w3.org/2001/04/xmlenc
    WS_SECURITY_ALGORITHM_DIGEST_SHA_512                           = 0x00000006,
    ///http://www.w3.org/2000/09/xmldsig
    WS_SECURITY_ALGORITHM_SYMMETRIC_SIGNATURE_HMAC_SHA1            = 0x00000007,
    ///http://www.w3.org/2001/04/xmldsig-more
    WS_SECURITY_ALGORITHM_SYMMETRIC_SIGNATURE_HMAC_SHA_256         = 0x00000008,
    ///http://www.w3.org/2001/04/xmldsig-more
    WS_SECURITY_ALGORITHM_SYMMETRIC_SIGNATURE_HMAC_SHA_384         = 0x00000009,
    ///http://www.w3.org/2001/04/xmldsig-more
    WS_SECURITY_ALGORITHM_SYMMETRIC_SIGNATURE_HMAC_SHA_512         = 0x0000000a,
    ///http://www.w3.org/2000/09/xmldsig
    WS_SECURITY_ALGORITHM_ASYMMETRIC_SIGNATURE_RSA_SHA1            = 0x0000000b,
    ///http://www.w3.org/2000/09/xmldsig
    WS_SECURITY_ALGORITHM_ASYMMETRIC_SIGNATURE_DSA_SHA1            = 0x0000000c,
    ///http://www.w3.org/2001/04/xmldsig-more
    WS_SECURITY_ALGORITHM_ASYMMETRIC_SIGNATURE_RSA_SHA_256         = 0x0000000d,
    ///http://www.w3.org/2001/04/xmldsig-more
    WS_SECURITY_ALGORITHM_ASYMMETRIC_SIGNATURE_RSA_SHA_384         = 0x0000000e,
    ///http://www.w3.org/2001/04/xmldsig-more
    WS_SECURITY_ALGORITHM_ASYMMETRIC_SIGNATURE_RSA_SHA_512         = 0x0000000f,
    ///http://www.w3.org/2001/04/xmlenc
    WS_SECURITY_ALGORITHM_ASYMMETRIC_KEYWRAP_RSA_1_5               = 0x00000010,
    ///http://www.w3.org/2001/04/xmlenc
    WS_SECURITY_ALGORITHM_ASYMMETRIC_KEYWRAP_RSA_OAEP              = 0x00000011,
    WS_SECURITY_ALGORITHM_KEY_DERIVATION_P_SHA1                    = 0x00000012,
}

///Defines the required integrity and confidentiality levels for sent and received messages. With transport and
///mixed-mode security bindings, this setting applies to each message as a whole. With message security, the protection
///level is specified at the granularity of a message header or body. The default value defined applies only to
///transport and mixed-mode security.
alias WS_PROTECTION_LEVEL = int;
enum : int
{
    ///No signing or encryption.
    WS_PROTECTION_LEVEL_NONE             = 0x00000001,
    ///Only signing.
    WS_PROTECTION_LEVEL_SIGN             = 0x00000002,
    WS_PROTECTION_LEVEL_SIGN_AND_ENCRYPT = 0x00000003,
}

///Identifies the properties representing channel-wide security settings. This enumeration is used within the
///WS_SECURITY_PROPERTY structure, which is in turn used within a WS_SECURITY_DESCRIPTION structure.
alias WS_SECURITY_PROPERTY_ID = int;
enum : int
{
    ///A WS_PROTECTION_LEVEL value that determines whether signing alone or signing plus encryption should be done for
    ///the connection. With at least one transport security binding in the security description, the default is
    ///<b>WS_PROTECTION_LEVEL_SIGN_AND_ENCRYPT</b>.
    WS_SECURITY_PROPERTY_TRANSPORT_PROTECTION_LEVEL   = 0x00000001,
    ///With mixed-mode security, this property is a WS_SECURITY_ALGORITHM_SUITE structure that specifies the algorithm
    ///suite to be used. . This property may not be used in conjunction with WS_SECURITY_PROPERTY_ALGORITHM_SUITE_NAME.
    ///If neither this property nor WS_SECURITY_ALGORITHM_SUITE_NAME is specified, the algorithm suite defaults to
    ///<b>WS_SECURITY_ALGORITHM_SUITE_NAME_BASIC128</b>when WS_KERBEROS_APREQ_MESSAGE_SECURITY_BINDING is used and
    ///<b>WS_SECURITY_ALGORITHM_SUITE_NAME_BASIC256</b> otherwise.
    WS_SECURITY_PROPERTY_ALGORITHM_SUITE              = 0x00000002,
    ///With mixed-mode security, this property is a WS_SECURITY_ALGORITHM structure that specifies the algorithm suite
    ///to be used. The suite names refer to collections of algorithms defined in WS-SecurityPolicy 1.1section 7.1. This
    ///property may not be used in conjunction with WS_SECURITY_PROPERTY_ALGORITHM_SUITE. If neither this property nor
    ///WS_SECURITY_ALGORITHM_SUITE is specified, the algorithm suite defaults to
    ///WS_SECURITY_ALGORITHM_SUITE_NAME_BASIC128when WS_KERBEROS_APREQ_MESSAGE_SECURITY_BINDING is used and
    ///<b>WS_SECURITY_ALGORITHM_SUITE_NAME_BASIC256</b> otherwise.
    WS_SECURITY_PROPERTY_ALGORITHM_SUITE_NAME         = 0x00000003,
    ///With mixed-mode security, this property is a WS_TIMESPAN structure that specifies the maximum allowed staleness
    ///of an incoming timestamp in the security header. The default is 5 minutes.
    WS_SECURITY_PROPERTY_MAX_ALLOWED_LATENCY          = 0x00000004,
    ///With mixed-mode security, this property is a WS_TIMESPAN structure that specifies the timestamp generated by the
    ///sender will remain valid for this duration from the security application instant. This setting is sometimes
    ///called 'time-to-live' or 'TTL'. The default is 5 minutes.
    WS_SECURITY_PROPERTY_TIMESTAMP_VALIDITY_DURATION  = 0x00000005,
    ///With mixed-mode security, this property is a WS_TIMESPAN structure that specifies the maximum skew allowed
    ///between the clocks of the sender and receiver. This quantity serves as a margin of tolerance on the enforcement
    ///of settings such as WS_SECURITY_PROPERTY_MAX_ALLOWED_LATENCY. The default is 5 minutes.
    WS_SECURITY_PROPERTY_MAX_ALLOWED_CLOCK_SKEW       = 0x00000006,
    ///With mixed-mode security, this property is a WS_SECURITY_TIMESTAMP_USAGE value that specifies whether a timestamp
    ///should be generated (at sender) and demanded (at receiver) in the security header. The default is
    ///<b>WS_SECURITY_TIMESTAMP_USAGE_ALWAYS</b>.
    WS_SECURITY_PROPERTY_TIMESTAMP_USAGE              = 0x00000007,
    ///With mixed-mode security, this property is a WS_SECURITY_HEADER_LAYOUT value that specifies the layout of the
    ///security header. The default is <b>WS_SECURITY_HEADER_LAYOUT_STRICT</b>.
    WS_SECURITY_PROPERTY_SECURITY_HEADER_LAYOUT       = 0x00000008,
    ///With mixed-mode security, this property is a WS_SECURITY_HEADER_VERSION value that specifies the WS-Security
    ///version to use for the security header. The default is <b>WS_SECURITY_HEADER_VERSION_1_1</b>.
    WS_SECURITY_PROPERTY_SECURITY_HEADER_VERSION      = 0x00000009,
    ///A WS_EXTENDED_PROTECTION_POLICY value that specfies whether to validate Extended Protection data. Only available
    ///if extended protection is used. The default is WS_EXTENDED_PROTECTION_POLICY_WHEN_SUPPORTED on configurations
    ///that support extended protection. This property is only available on the server and can only be used when
    ///WS_HTTP_CHANNEL_BINDING with either WS_HTTP_HEADER_AUTH_SECURITY_BINDINGor
    ///WS_KERBEROS_APREQ_MESSAGE_SECURITY_BINDING is used. Supported by default on Windows 7 and above. May require an
    ///update on systems running earlier versions of Windows. If the operating system was not updated, this property is
    ///still available but has no effect.
    WS_SECURITY_PROPERTY_EXTENDED_PROTECTION_POLICY   = 0x0000000a,
    ///A WS_EXTENDED_PROTECTION_SCENARIO value that specifes the deployment scenario of the server as it pertains to
    ///Extended Protection. Only available if extended protection is used. This property is only available on the server
    ///and can only be used when WS_HTTP_CHANNEL_BINDING with either WS_HTTP_HEADER_AUTH_SECURITY_BINDINGor
    ///WS_KERBEROS_APREQ_MESSAGE_SECURITY_BINDING is used. The default is WS_EXTENDED_PROTECTION_SCENARIO_BOUND_SERVER.
    ///Supported by default on Windows 7 and above. May require an update on systems running earlier versions of
    ///Windows. If the operating system was not updated, this property is still available but has no effect.
    WS_SECURITY_PROPERTY_EXTENDED_PROTECTION_SCENARIO = 0x0000000b,
    ///A WS_SERVICE_SECURITY_IDENTITIES structure that sets the Server Principal Names (SPNs) the server is willing to
    ///accept as part of validating Extended Protection data. SPNs are validated when a
    ///WS_HTTP_HEADER_AUTH_SECURITY_BINDING is used without a WS_SSL_TRANSPORT_SECURITY_BINDING or when
    ///WS_EXTENDED_PROTECTION_SCENARIO_TERMINATED_SSL is set. This property is only available on the server and can only
    ///be used with WS_HTTP_CHANNEL_BINDING. If all of the above requirements are met, this property must be set for
    ///security verification to succeed. Otherwise, it must not be set. Supported by default on Windows 7 and above.
    ///Requires update to the operating system on other platforms. If the operating system was not updated, this
    ///property is still available but has no effect.
    WS_SECURITY_PROPERTY_SERVICE_IDENTITIES           = 0x0000000c,
}

///The key type of a security token. It is used as the return type when a security token is queried about its key. It is
///also used to specify the required key type when requesting a security token from a security token service.
alias WS_SECURITY_KEY_TYPE = int;
enum : int
{
    ///Has no key -- it may be a bearer token such as a username/password pair.
    WS_SECURITY_KEY_TYPE_NONE       = 0x00000001,
    ///Has a symmetric key.
    WS_SECURITY_KEY_TYPE_SYMMETRIC  = 0x00000002,
    WS_SECURITY_KEY_TYPE_ASYMMETRIC = 0x00000003,
}

///A suite of security algorithms used for tasks such as signing and encryting. The values in this enumeration
///correspond to the suites defined in WS-SecurityPolicy 1.1section 7.1.
alias WS_SECURITY_ALGORITHM_SUITE_NAME = int;
enum : int
{
    ///Identifies the Basic256 algorithm suite. This suite uses the following algorithms: <ul> <li>
    ///WS_SECURITY_ALGORITHM_CANONICALIZATION_EXCLUSIVE </li> <li> WS_SECURITY_ALGORITHM_DIGEST_SHA1 </li> <li>
    ///WS_SECURITY_ALGORITHM_SYMMETRIC_SIGNATURE_HMAC_SHA1 </li> <li>
    ///WS_SECURITY_ALGORITHM_ASYMMETRIC_SIGNATURE_RSA_SHA1 </li> <li> WS_SECURITY_ALGORITHM_KEY_DERIVATION_P_SHA1 </li>
    ///<li> WS_SECURITY_ALGORITHM_ASYMMETRIC_KEYWRAP_RSA_OAEP </li> </ul>The minimum symmetric key length is 256; the
    ///maximum symmetric key length is 256. The minimum asymmetric key length is 1024; the maximum asymmetric key length
    ///is 4096.
    WS_SECURITY_ALGORITHM_SUITE_NAME_BASIC256              = 0x00000001,
    ///Identifies the Basic192 algorithm suite. This suite uses the following algorithms: <ul> <li>
    ///WS_SECURITY_ALGORITHM_CANONICALIZATION_EXCLUSIVE </li> <li> WS_SECURITY_ALGORITHM_DIGEST_SHA1 </li> <li>
    ///WS_SECURITY_ALGORITHM_SYMMETRIC_SIGNATURE_HMAC_SHA1 </li> <li>
    ///WS_SECURITY_ALGORITHM_ASYMMETRIC_SIGNATURE_RSA_SHA1 </li> <li> WS_SECURITY_ALGORITHM_KEY_DERIVATION_P_SHA1 </li>
    ///<li> WS_SECURITY_ALGORITHM_ASYMMETRIC_KEYWRAP_RSA_OAEP </li> </ul>The minimum symmetric key length is 192; the
    ///maximum symmetric key length is 256. The minimum asymmetric key length is 1024; the maximum asymmetric key length
    ///is 4096.
    WS_SECURITY_ALGORITHM_SUITE_NAME_BASIC192              = 0x00000002,
    ///Identifies the Basic128 algorithm suite. This suite uses the following algorithms: <ul> <li>
    ///WS_SECURITY_ALGORITHM_CANONICALIZATION_EXCLUSIVE </li> <li> WS_SECURITY_ALGORITHM_DIGEST_SHA1 </li> <li>
    ///WS_SECURITY_ALGORITHM_SYMMETRIC_SIGNATURE_HMAC_SHA1 </li> <li>
    ///WS_SECURITY_ALGORITHM_ASYMMETRIC_SIGNATURE_RSA_SHA1 </li> <li> WS_SECURITY_ALGORITHM_KEY_DERIVATION_P_SHA1 </li>
    ///<li> WS_SECURITY_ALGORITHM_ASYMMETRIC_KEYWRAP_RSA_OAEP </li> </ul>The minimum symmetric key length is 128; the
    ///maximum symmetric key length is 256. The minimum asymmetric key length is 1024; the maximum asymmetric key length
    ///is 4096.
    WS_SECURITY_ALGORITHM_SUITE_NAME_BASIC128              = 0x00000003,
    ///Identifies the Basic256Rsa15 algorithm suite. This suite uses the following algorithms: <ul> <li>
    ///WS_SECURITY_ALGORITHM_CANONICALIZATION_EXCLUSIVE </li> <li> WS_SECURITY_ALGORITHM_DIGEST_SHA1 </li> <li>
    ///WS_SECURITY_ALGORITHM_SYMMETRIC_SIGNATURE_HMAC_SHA1 </li> <li>
    ///WS_SECURITY_ALGORITHM_ASYMMETRIC_SIGNATURE_RSA_SHA1 </li> <li> WS_SECURITY_ALGORITHM_KEY_DERIVATION_P_SHA1 </li>
    ///<li> WS_SECURITY_ALGORITHM_ASYMMETRIC_KEYWRAP_RSA_1_5 </li> </ul>The minimum symmetric key length is 256; the
    ///maximum symmetric key length is 256. The minimum asymmetric key length is 1024; the maximum asymmetric key length
    ///is 4096.
    WS_SECURITY_ALGORITHM_SUITE_NAME_BASIC256_RSA15        = 0x00000004,
    ///Identifies the Basic192Rsa15 algorithm suite. This suite uses the following algorithms: <ul> <li>
    ///WS_SECURITY_ALGORITHM_CANONICALIZATION_EXCLUSIVE </li> <li> WS_SECURITY_ALGORITHM_DIGEST_SHA1 </li> <li>
    ///WS_SECURITY_ALGORITHM_SYMMETRIC_SIGNATURE_HMAC_SHA1 </li> <li>
    ///WS_SECURITY_ALGORITHM_ASYMMETRIC_SIGNATURE_RSA_SHA1 </li> <li> WS_SECURITY_ALGORITHM_KEY_DERIVATION_P_SHA1 </li>
    ///<li> WS_SECURITY_ALGORITHM_ASYMMETRIC_KEYWRAP_RSA_1_5 </li> </ul>The minimum symmetric key length is 192; the
    ///maximum symmetric key length is 256. The minimum asymmetric key length is 1024; the maximum asymmetric key length
    ///is 4096.
    WS_SECURITY_ALGORITHM_SUITE_NAME_BASIC192_RSA15        = 0x00000005,
    ///Identifies the Basic128RSA15 algorithm suite. This suite uses the following algorithms: <ul> <li>
    ///WS_SECURITY_ALGORITHM_CANONICALIZATION_EXCLUSIVE </li> <li> WS_SECURITY_ALGORITHM_DIGEST_SHA1 </li> <li>
    ///WS_SECURITY_ALGORITHM_SYMMETRIC_SIGNATURE_HMAC_SHA1 </li> <li>
    ///WS_SECURITY_ALGORITHM_ASYMMETRIC_SIGNATURE_RSA_SHA1 </li> <li> WS_SECURITY_ALGORITHM_KEY_DERIVATION_P_SHA1 </li>
    ///<li> WS_SECURITY_ALGORITHM_ASYMMETRIC_KEYWRAP_RSA_1_5 </li> </ul>The minimum symmetric key length is 128; the
    ///maximum symmetric key length is 256. The minimum asymmetric key length is 1024; the maximum asymmetric key length
    ///is 4096.
    WS_SECURITY_ALGORITHM_SUITE_NAME_BASIC128_RSA15        = 0x00000006,
    ///Identifies the Basic256Sha256 algorithm suite. This suite uses the following algorithms: <ul> <li>
    ///WS_SECURITY_ALGORITHM_CANONICALIZATION_EXCLUSIVE </li> <li> WS_SECURITY_ALGORITHM_DIGEST_SHA_256 </li> <li>
    ///WS_SECURITY_ALGORITHM_SYMMETRIC_SIGNATURE_HMAC_SHA1 </li> <li>
    ///WS_SECURITY_ALGORITHM_ASYMMETRIC_SIGNATURE_RSA_SHA1 </li> <li> WS_SECURITY_ALGORITHM_KEY_DERIVATION_P_SHA1 </li>
    ///<li> WS_SECURITY_ALGORITHM_ASYMMETRIC_KEYWRAP_RSA_OAEP </li> </ul>The minimum symmetric key length is 256; the
    ///maximum symmetric key length is 256. The minimum asymmetric key length is 1024; the maximum asymmetric key length
    ///is 4096.
    WS_SECURITY_ALGORITHM_SUITE_NAME_BASIC256_SHA256       = 0x00000007,
    ///Identifies the Basic192Sha256 algorithm suite. This suite uses the following algorithms: <ul> <li>
    ///WS_SECURITY_ALGORITHM_CANONICALIZATION_EXCLUSIVE </li> <li> WS_SECURITY_ALGORITHM_DIGEST_SHA_256 </li> <li>
    ///WS_SECURITY_ALGORITHM_SYMMETRIC_SIGNATURE_HMAC_SHA1 </li> <li>
    ///WS_SECURITY_ALGORITHM_ASYMMETRIC_SIGNATURE_RSA_SHA1 </li> <li> WS_SECURITY_ALGORITHM_KEY_DERIVATION_P_SHA1 </li>
    ///<li> WS_SECURITY_ALGORITHM_ASYMMETRIC_KEYWRAP_RSA_OAEP </li> </ul>The minimum symmetric key length is 192; the
    ///maximum symmetric key length is 256. The minimum asymmetric key length is 1024; the maximum asymmetric key length
    ///is 4096.
    WS_SECURITY_ALGORITHM_SUITE_NAME_BASIC192_SHA256       = 0x00000008,
    ///Identifies the Basic128Sha256 algorithm suite. This suite uses the following algorithms: <ul> <li>
    ///WS_SECURITY_ALGORITHM_CANONICALIZATION_EXCLUSIVE </li> <li> WS_SECURITY_ALGORITHM_DIGEST_SHA_256 </li> <li>
    ///WS_SECURITY_ALGORITHM_SYMMETRIC_SIGNATURE_HMAC_SHA1 </li> <li>
    ///WS_SECURITY_ALGORITHM_ASYMMETRIC_SIGNATURE_RSA_SHA1 </li> <li> WS_SECURITY_ALGORITHM_KEY_DERIVATION_P_SHA1 </li>
    ///<li> WS_SECURITY_ALGORITHM_ASYMMETRIC_KEYWRAP_RSA_OAEP </li> </ul>The minimum symmetric key length is 128; the
    ///maximum symmetric key length is 256. The minimum asymmetric key length is 1024; the maximum asymmetric key length
    ///is 4096.
    WS_SECURITY_ALGORITHM_SUITE_NAME_BASIC128_SHA256       = 0x00000009,
    ///Identifies the Basic256Sha256Rsa15 algorithm suite. This suite uses the following algorithms: <ul> <li>
    ///WS_SECURITY_ALGORITHM_CANONICALIZATION_EXCLUSIVE </li> <li> WS_SECURITY_ALGORITHM_DIGEST_SHA_256 </li> <li>
    ///WS_SECURITY_ALGORITHM_SYMMETRIC_SIGNATURE_HMAC_SHA1 </li> <li>
    ///WS_SECURITY_ALGORITHM_ASYMMETRIC_SIGNATURE_RSA_SHA1 </li> <li> WS_SECURITY_ALGORITHM_KEY_DERIVATION_P_SHA1 </li>
    ///<li> WS_SECURITY_ALGORITHM_ASYMMETRIC_KEYWRAP_RSA_1_5 </li> </ul>The minimum symmetric key length is 256; the
    ///maximum symmetric key length is 256. The minimum asymmetric key length is 1024; the maximum asymmetric key length
    ///is 4096.
    WS_SECURITY_ALGORITHM_SUITE_NAME_BASIC256_SHA256_RSA15 = 0x0000000a,
    ///Identifies the Basic192Sha256Rsa15 algorithm suite. This suite uses the following algorithms: <ul> <li>
    ///WS_SECURITY_ALGORITHM_CANONICALIZATION_EXCLUSIVE </li> <li> WS_SECURITY_ALGORITHM_DIGEST_SHA_256 </li> <li>
    ///WS_SECURITY_ALGORITHM_SYMMETRIC_SIGNATURE_HMAC_SHA1 </li> <li>
    ///WS_SECURITY_ALGORITHM_ASYMMETRIC_SIGNATURE_RSA_SHA1 </li> <li> WS_SECURITY_ALGORITHM_KEY_DERIVATION_P_SHA1 </li>
    ///<li> WS_SECURITY_ALGORITHM_ASYMMETRIC_KEYWRAP_RSA_1_5 </li> </ul>The minimum symmetric key length is 192; the
    ///maximum symmetric key length is 256. The minimum asymmetric key length is 1024; the maximum asymmetric key length
    ///is 4096.
    WS_SECURITY_ALGORITHM_SUITE_NAME_BASIC192_SHA256_RSA15 = 0x0000000b,
    WS_SECURITY_ALGORITHM_SUITE_NAME_BASIC128_SHA256_RSA15 = 0x0000000c,
}

///With message and mixed-mode security bindings, the mechanism to use to refer to a security token from signatures,
///encrypted items and derived tokens. The security runtime can use the right reference on its own most of the time, and
///this needs to be explicitly set only when a specific reference mechanism is required, typically for interop with
///another platform that supports only that reference form.
alias WS_SECURITY_TOKEN_REFERENCE_MODE = int;
enum : int
{
    ///The id of the serialized security token is used to refer to it. This reference mechanism can be used only when
    ///the security token is serialized in the same message as the item (such as a signature) that needs to refer to the
    ///security token.
    WS_SECURITY_TOKEN_REFERENCE_MODE_LOCAL_ID            = 0x00000001,
    ///An opaque XML buffer that is used as a token reference (for example, as in a custom token).
    WS_SECURITY_TOKEN_REFERENCE_MODE_XML_BUFFER          = 0x00000002,
    ///The thumbprint of a certificate is used to refer to it.
    WS_SECURITY_TOKEN_REFERENCE_MODE_CERT_THUMBPRINT     = 0x00000003,
    ///The context-id is used to refer to a security context token.
    WS_SECURITY_TOKEN_REFERENCE_MODE_SECURITY_CONTEXT_ID = 0x00000004,
    WS_SECURITY_TOKEN_REFERENCE_MODE_SAML_ASSERTION_ID   = 0x00000005,
}

///Defines how randomness should be contributed to the issued key during a security token negotiation done with message
///and mixed-mode security.
alias WS_SECURITY_KEY_ENTROPY_MODE = int;
enum : int
{
    ///Only client contributes entropy.
    WS_SECURITY_KEY_ENTROPY_MODE_CLIENT_ONLY = 0x00000001,
    ///Only service contributes entropy.
    WS_SECURITY_KEY_ENTROPY_MODE_SERVER_ONLY = 0x00000002,
    WS_SECURITY_KEY_ENTROPY_MODE_COMBINED    = 0x00000003,
}

///Defines if Extended Protection data should be validated. This property is only available on the server, and can only
///be set when WS_CHANNEL_BINDING with WS_SSL_TRANSPORT_SECURITY_BINDING and either
///WS_KERBEROS_APREQ_MESSAGE_SECURITY_BINDINGor WS_HTTP_HEADER_AUTH_SECURITY_BINDING is used.
alias WS_EXTENDED_PROTECTION_POLICY = int;
enum : int
{
    ///Extended protection data is not validated.
    WS_EXTENDED_PROTECTION_POLICY_NEVER          = 0x00000001,
    ///If the client system supports the extended protection feature, extended protection data is looked for and
    ///validated during authentication. Otherwise it is ignored. A server can detect whether the client's operating
    ///system supports extended protection but chose not to include the extended protection data or whether it does not
    ///support extended protection. The former case is insecure and thus rejected. The latter is allowed when using this
    ///flag. NOTE: If the client supports the extended protection feature, but did not include extended protection data
    ///in the authentication data, this setting will cause requests to fail. This scenario is possible when the
    ///operating system was patched but the client web services implementation does not send the neccessary data. This
    ///is the default.
    WS_EXTENDED_PROTECTION_POLICY_WHEN_SUPPORTED = 0x00000002,
    WS_EXTENDED_PROTECTION_POLICY_ALWAYS         = 0x00000003,
}

///Defines how Extended Protection is validated. For most configurations, the runtime can automatically determine what
///needs to be validated based on the presence of the WS_SSL_TRANSPORT_SECURITY_BINDING. However, if the SSL connection
///is terminated at an intermediary such as a proxy prior to reaching the server then the validation method must change,
///and this scenario cannot be automatically detected. Only available on the server.
alias WS_EXTENDED_PROTECTION_SCENARIO = int;
enum : int
{
    ///There is no SSL connection between the client and the server, or the SSL connection is terminated at the server.
    ///This is the default.
    WS_EXTENDED_PROTECTION_SCENARIO_BOUND_SERVER   = 0x00000001,
    WS_EXTENDED_PROTECTION_SCENARIO_TERMINATED_SSL = 0x00000002,
}

///Identifies the properties used to specify security binding settings. Security binding settings are present in
///security bindingsthat are used, in turn, in a security description. This enumeration is used within the
///WS_SECURITY_BINDING_PROPERTY structure, which in turn is used in a WS_SECURITY_BINDING structure. Not all values are
///applicable to all security bindings. Please see the individual descriptions for a list of security bindings that
///support the respective property. Note that the related enum WS_SECURITY_TOKEN_PROPERTY_IDdefines the keys for
///extracting fields from a security token instance. Thus, WS_SECURITY_BINDING_PROPERTY enables specifying security
///binding settings at channel / listener creation time to influence how a security token is created and used, whereas
///<b>WS_SECURITY_TOKEN_PROPERTY_ID</b>enables extracting fields out of a security token -- typically a security token
///from a received message when the channel and security are 'live'.
alias WS_SECURITY_BINDING_PROPERTY_ID = int;
enum : int
{
    ///A <b>BOOL</b> that specifies whether a client certificate should be demanded when using SSL. The default is
    ///<b>FALSE</b>. This setting may be specified in the security binding properties of a server-side
    ///WS_SSL_TRANSPORT_SECURITY_BINDING.
    WS_SECURITY_BINDING_PROPERTY_REQUIRE_SSL_CLIENT_CERT                 = 0x00000001,
    ///A WS_WINDOWS_INTEGRATED_AUTH_PACKAGE value that specifies the specific SSP package (among Kerberos, NTLM, SPNEGO)
    ///to be used when performing Windows Integrated Authentication. The default is
    ///<b>WS_WINDOWS_INTEGRATED_AUTH_PACKAGE_SPNEGO</b>. This setting may be specified in the security binding
    ///properties of WS_TCP_SSPI_TRANSPORT_SECURITY_BINDING and WS_NAMEDPIPE_SSPI_TRANSPORT_SECURITY_BINDING.
    WS_SECURITY_BINDING_PROPERTY_WINDOWS_INTEGRATED_AUTH_PACKAGE         = 0x00000002,
    ///A <b>BOOL</b> that specifies whether server authentication is mandatory. Currently, this setting is applicable
    ///only when using Windows Integrated Authentication based security. Setting this to <b>FALSE</b> is strongly
    ///discouraged since, without server authentication, a malicious party masquerading as the server cannot be
    ///detected. The default is <b>TRUE</b> when used with WS_TCP_SSPI_TRANSPORT_SECURITY_BINDING and <b>FALSE</b> when
    ///used with WS_NAMEDPIPE_SSPI_TRANSPORT_SECURITY_BINDING If a protocol that does not do server authentication (such
    ///as NTLM) is to be allowed, this property must be set to <b>FALSE</b>. This setting may be specified only in the
    ///security binding properties of a client-side WS_TCP_SSPI_TRANSPORT_SECURITY_BINDING and
    ///WS_NAMEDPIPE_SSPI_TRANSPORT_SECURITY_BINDING.
    WS_SECURITY_BINDING_PROPERTY_REQUIRE_SERVER_AUTH                     = 0x00000003,
    ///A <b>BOOL</b> that specifies whether the server should allow clients authenticated anonymously using Windows
    ///Integrated Authentication based security. The default is <b>FALSE</b>. This setting may be specified only in the
    ///security binding properties of a server-side WS_TCP_SSPI_TRANSPORT_SECURITY_BINDING and
    ///WS_NAMEDPIPE_SSPI_TRANSPORT_SECURITY_BINDING.
    WS_SECURITY_BINDING_PROPERTY_ALLOW_ANONYMOUS_CLIENTS                 = 0x00000004,
    ///A SECURITY_IMPERSONATION_LEVEL value that specifies the impersonation level the client wants to allow when using
    ///Windows Integrated Authentication to communicate with a service. The default impersonation level is
    ///<b>SecurityIdentification</b>. This setting may be specified in the security binding properties of
    ///WS_TCP_SSPI_TRANSPORT_SECURITY_BINDING, WS_NAMEDPIPE_SSPI_TRANSPORT_SECURITY_BINDING, and
    ///WS_KERBEROS_APREQ_MESSAGE_SECURITY_BINDING.
    WS_SECURITY_BINDING_PROPERTY_ALLOWED_IMPERSONATION_LEVEL             = 0x00000005,
    ///A <b>ULONG</b> that specifies the HTTP header authentication mode to use. The value specified must be a
    ///combination of one or more of WS_HTTP_HEADER_AUTH_SCHEME_NONE, <b>WS_HTTP_HEADER_AUTH_SCHEME_BASIC</b>,
    ///<b>WS_HTTP_HEADER_AUTH_SCHEME_DIGEST</b>, <b>WS_HTTP_HEADER_AUTH_SCHEME_NTLM</b> or
    ///<b>WS_HTTP_HEADER_AUTH_SCHEME_NEGOTIATE</b>. When setting this property on a binding used to communicate with an
    ///HTTP proxy server, only one scheme should be set, and <b>WS_HTTP_HEADER_AUTH_SCHEME_NONE</b> may not be used.
    ///Alternatively, this property may be set set to WS_HTTP_HEADER_AUTH_SCHEME_PASSPORT.
    ///<b>WS_HTTP_HEADER_AUTH_SCHEME_PASSPORT</b> must not be combined with any other value and cannot be used to
    ///authenticate to an HTTP proxy server. WS_HTTP_HEADER_AUTH_SCHEME_NONE is only supported on the client. Setting it
    ///by itself disables HTTP header authentication. Setting it in conjunction with other schemes allows the client to
    ///fall back to no header authentication when the server does not require it. Otherwise, if the client specifies
    ///multiple authentication schemes and the server requires no authentication the request will fail. When setting a
    ///single authentication scheme, the client will perform the request with that scheme set. If multiple schemes are
    ///set, the client will first probe the server for the supported schemes by sending an unauthenticated blank
    ///request. Should the client and server share more than one supported scheme, the client will prioritize schemes in
    ///the following order and pick the first mutually supported one: <ul> <li> WS_HTTP_HEADER_AUTH_SCHEME_NEGOTIATE
    ///</li> <li> WS_HTTP_HEADER_AUTH_SCHEME_NTLM </li> <li> WS_HTTP_HEADER_AUTH_SCHEME_DIGEST </li> <li>
    ///WS_HTTP_HEADER_AUTH_SCHEME_BASIC </li> </ul> When the scheme is set to WS_HTTP_HEADER_AUTH_SCHEME_NEGOTIATE and
    ///Kerberos authentication is negotiated, the Server Principal Name (SPN) used is derived from the server's DNS
    ///name. Even when present WS_ENDPOINT_IDENTITY is ignored. In order for authentication to succeed, the server must
    ///be able to decrypt Kerberos tickets for that SPN. When the scheme is set to WS_HTTP_HEADER_AUTH_SCHEME_DIGEST or
    ///<b>WS_HTTP_HEADER_AUTH_SCHEME_BASIC</b>, then the WS_STRING_WINDOWS_INTEGRATED_AUTH_CREDENTIAL must be used as
    ///credential type. Note: Using "localhost", "127.0.0.1" or similar ways to refer to the local machine as server
    ///address may cause failures when using WS_HTTP_HEADER_AUTH_SCHEME_NTLM or
    ///<b>WS_HTTP_HEADER_AUTH_SCHEME_NEGOTIATE</b>. It is recommended to use the machine name instead. This setting may
    ///be specified in the security binding properties of WS_HTTP_HEADER_AUTH_SECURITY_BINDING. The default is
    ///WS_HTTP_HEADER_AUTH_SCHEME_NEGOTIATE.
    WS_SECURITY_BINDING_PROPERTY_HTTP_HEADER_AUTH_SCHEME                 = 0x00000006,
    ///A WS_HTTP_HEADER_AUTH_TARGET value that specifies the HTTP header authentication target to use. This property can
    ///be specified on the client side to indicate whether the http header authentication security binding is for the
    ///target server or the proxy server. Default value is <b>WS_HTTP_HEADER_AUTH_TARGET_SERVICE</b>. This setting may
    ///be specified in the security binding properties of WS_HTTP_HEADER_AUTH_SECURITY_BINDING.
    WS_SECURITY_BINDING_PROPERTY_HTTP_HEADER_AUTH_TARGET                 = 0x00000007,
    ///A WS_STRING s used as the realm with the basic HTTP header authentication scheme. This setting may be specified
    ///in the security binding properties of a server side WS_HTTP_HEADER_AUTH_SECURITY_BINDING.
    WS_SECURITY_BINDING_PROPERTY_HTTP_HEADER_AUTH_BASIC_REALM            = 0x00000008,
    ///A WS_STRING used as the realm with the digest HTTP header authentication scheme. This setting may be specified in
    ///the security binding properties of a server side WS_HTTP_HEADER_AUTH_SECURITY_BINDING.
    WS_SECURITY_BINDING_PROPERTY_HTTP_HEADER_AUTH_DIGEST_REALM           = 0x00000009,
    ///A WS_STRING used as the domain name with the digest HTTP header authentication scheme. This setting may be
    ///specified in the security binding properties of a server side WS_HTTP_HEADER_AUTH_SECURITY_BINDING.
    WS_SECURITY_BINDING_PROPERTY_HTTP_HEADER_AUTH_DIGEST_DOMAIN          = 0x0000000a,
    ///A <b>ULONG</b> that specifies the key size (in bits) of the security token to be requested from an issuer. If
    ///unspecified, the issuer decides the size. May be used with the WS_SECURITY_CONTEXT_MESSAGE_SECURITY_BINDING.
    WS_SECURITY_BINDING_PROPERTY_SECURITY_CONTEXT_KEY_SIZE               = 0x0000000b,
    ///A WS_SECURITY_KEY_ENTROPY_MODE value that specifies how entropy contributes to the key in issued symmetric key
    ///tokens. The default is <b>WS_SECURITY_KEY_ENTROPY_MODE_COMBINED</b>. This setting may be specified in the
    ///security binding properties of the WS_SECURITY_CONTEXT_MESSAGE_SECURITY_BINDING structure.
    WS_SECURITY_BINDING_PROPERTY_SECURITY_CONTEXT_KEY_ENTROPY_MODE       = 0x0000000c,
    ///The set of WS_MESSAGE_PROPERTIES to be specified while creating the two messages to be used for the security
    ///token obtaining exchange. If this property is not specified, the request and reply messages are created with the
    ///default message properties. This setting may be specified in the security binding properties of the
    ///WS_SECURITY_CONTEXT_MESSAGE_SECURITY_BINDING structure.
    WS_SECURITY_BINDING_PROPERTY_MESSAGE_PROPERTIES                      = 0x0000000d,
    ///A <b>ULONG</b> that specifies the maximum number of pending security contexts on the service that have not been
    ///accepted by the application (or service model) as channels. The default is 100. The setting may be specified in
    ///the security binding properties of the WS_SECURITY_CONTEXT_MESSAGE_SECURITY_BINDING structure.
    WS_SECURITY_BINDING_PROPERTY_SECURITY_CONTEXT_MAX_PENDING_CONTEXTS   = 0x0000000e,
    ///A <b>ULONG</b> that specifies the maximum number of active security contexts on the service. The default is 1000.
    ///The setting may be specified in the security binding properties of the
    ///WS_SECURITY_CONTEXT_MESSAGE_SECURITY_BINDING structure.
    WS_SECURITY_BINDING_PROPERTY_SECURITY_CONTEXT_MAX_ACTIVE_CONTEXTS    = 0x0000000f,
    ///A WS_SECURE_CONVERSATION_VERSION value that specifies the version of WS-SecureConversation to use. The default is
    ///<b>WS_SECURE_CONVERSATION_VERSION_FEBRUARY_2005</b>. This setting may be specified in the security binding
    ///properties of the WS_SECURITY_CONTEXT_MESSAGE_SECURITY_BINDING structure.
    WS_SECURITY_BINDING_PROPERTY_SECURE_CONVERSATION_VERSION             = 0x00000010,
    ///A <b>BOOL</b> that specifies whether or not to support the renew operation on established security contexts. On
    ///the client, if this is set to <b>FALSE</b>, instead of renewing the existing security context a new context will
    ///be established. On the server, all incoming renew messages will be rejected. The default is <b>TRUE</b>. This
    ///setting may be specified in the security binding properties of the WS_SECURITY_CONTEXT_MESSAGE_SECURITY_BINDING
    ///structure.
    WS_SECURITY_BINDING_PROPERTY_SECURITY_CONTEXT_SUPPORT_RENEW          = 0x00000011,
    ///A WS_TIMESPAN structure that contains the interval before which a security context must be renewed. On the client
    ///it defaults to 10 hours and denotes the time after which the session is proactively renewed. On the server it
    ///defaults to 15 hours and denotes context lifetime. A server context must be renewed before that limit is reached.
    ///This setting may be specified in the security binding properties of the
    ///WS_SECURITY_CONTEXT_MESSAGE_SECURITY_BINDING structure.
    WS_SECURITY_BINDING_PROPERTY_SECURITY_CONTEXT_RENEWAL_INTERVAL       = 0x00000012,
    ///A WS_TIMESPAN structure that contains the time interval for which an old security context token should be
    ///accepted after a renewal. The default is 5 minutes. This tolerance interval is provided to smoothly handle
    ///application messages during session renewal. This setting may be specified in the security binding properties of
    ///the WS_SECURITY_CONTEXT_MESSAGE_SECURITY_BINDING structure.
    WS_SECURITY_BINDING_PROPERTY_SECURITY_CONTEXT_ROLLOVER_INTERVAL      = 0x00000013,
    ///A <b>ULONG</b> that specifies a set of certificate verification failures that are ignored by the client so that
    ///communication with the remote endpoint will succeed regardless. Any combination of the values defined in
    ///WS_CERT_FAILURE or 0 may be specified. The default is <b>WS_CERT_FAILURE_REVOCATION_OFFLINE</b>. This setting may
    ///be specified in the security binding properties of the WS_SSL_TRANSPORT_SECURITY_BINDING structure on the client.
    ///Ignoring certificate verification failures can expose the application to potential security vulnerabilities. The
    ///use of this property should be carefully evaluated.
    WS_SECURITY_BINDING_PROPERTY_CERT_FAILURES_TO_IGNORE                 = 0x00000014,
    ///A <b>BOOL</b> that specifies the state of certificate revocation checking. When set to <b>TRUE</b>, certificate
    ///revocation checking is disabled. The default is <b>FALSE</b>. This setting may be specified in the security
    ///binding properties of the WS_SSL_TRANSPORT_SECURITY_BINDING structure on the client. Disabling certificate
    ///revocation checking can expose the application to potential security vulnerabilities. The use of this property
    ///should be carefully evaluated.
    WS_SECURITY_BINDING_PROPERTY_DISABLE_CERT_REVOCATION_CHECK           = 0x00000015,
    WS_SECURITY_BINDING_PROPERTY_DISALLOWED_SECURE_PROTOCOLS             = 0x00000016,
    WS_SECURITY_BINDING_PROPERTY_CERTIFICATE_VALIDATION_CALLBACK_CONTEXT = 0x00000017,
}

///The type of the certificate credential, used as a selector for subtypes of WS_CERT_CREDENTIAL.
alias WS_CERT_CREDENTIAL_TYPE = int;
enum : int
{
    ///Type id for the certificate credential WS_SUBJECT_NAME_CERT_CREDENTIAL.
    WS_SUBJECT_NAME_CERT_CREDENTIAL_TYPE = 0x00000001,
    ///Type id for the certificate credential WS_THUMBPRINT_CERT_CREDENTIAL.
    WS_THUMBPRINT_CERT_CREDENTIAL_TYPE   = 0x00000002,
    WS_CUSTOM_CERT_CREDENTIAL_TYPE       = 0x00000003,
}

///The type of the Windows Integrated Authentication credential, used as a selector for subtypes of
///WS_WINDOWS_INTEGRATED_AUTH_CREDENTIAL.
alias WS_WINDOWS_INTEGRATED_AUTH_CREDENTIAL_TYPE = int;
enum : int
{
    ///Type id for the Windows credential WS_STRING_WINDOWS_INTEGRATED_AUTH_CREDENTIAL.
    WS_STRING_WINDOWS_INTEGRATED_AUTH_CREDENTIAL_TYPE  = 0x00000001,
    ///Type id for the Windows credential WS_DEFAULT_WINDOWS_INTEGRATED_AUTH_CREDENTIAL.
    WS_DEFAULT_WINDOWS_INTEGRATED_AUTH_CREDENTIAL_TYPE = 0x00000002,
    WS_OPAQUE_WINDOWS_INTEGRATED_AUTH_CREDENTIAL_TYPE  = 0x00000003,
}

///The type of the username/password credential, used as a selector for subtypes of WS_USERNAME_CREDENTIAL.
alias WS_USERNAME_CREDENTIAL_TYPE = int;
enum : int
{
    WS_STRING_USERNAME_CREDENTIAL_TYPE = 0x00000001,
}

///Defines the keys for the fields and properties that can be extracted from a security token. Not all properties are
///valid for all security token types. The function WsGetSecurityTokenProperty uses the values defined here as keys. See
///also WS_SECURITY_BINDING_PROPERTY.
alias WS_SECURITY_TOKEN_PROPERTY_ID = int;
enum : int
{
    ///The accompanying <b>value</b> parameter of the WsGetSecurityTokenProperty function is a WS_SECURITY_KEY_TYPE
    ///value indicating the type of the proof key of the security token.
    WS_SECURITY_TOKEN_PROPERTY_KEY_TYPE                 = 0x00000001,
    ///The accompanying <b>value</b> parameter of the WsGetSecurityTokenProperty function is a WS_DATETIME structure
    ///containing the time from when the security token is valid. For a security token that does not define an explicit
    ///start time for its validity period, a <b>WS_DATETIME</b> with a tick count of 0 is returned.
    WS_SECURITY_TOKEN_PROPERTY_VALID_FROM_TIME          = 0x00000002,
    ///The accompanying <b>value</b> parameter of the WsGetSecurityTokenProperty function is a WS_DATETIME structure
    ///containing the point in time at which a currently valid security token becomes invalid. For a security token that
    ///does not define an explicit end time for its validity period, a <b>WS_DATETIME</b> with a tick count of 0 is
    ///returned.
    WS_SECURITY_TOKEN_PROPERTY_VALID_TILL_TIME          = 0x00000003,
    ///The accompanying <b>value</b> parameter of the WsGetSecurityTokenProperty function is a pointer to a
    ///WS_XML_BUFFER containing the XML wire form of the security token.
    WS_SECURITY_TOKEN_PROPERTY_SERIALIZED_XML           = 0x00000004,
    ///The accompanying <b>value</b> parameter of the WsGetSecurityTokenProperty function is a pointer to a
    ///WS_XML_BUFFER containing the XML wire form of the attached reference to the security token. Attached references
    ///are used to refer to a security token when the security token and its referring point (such as a signature using
    ///that token) both occur in the same message.
    WS_SECURITY_TOKEN_PROPERTY_ATTACHED_REFERENCE_XML   = 0x00000005,
    ///The accompanying <b>value</b> parameter of the WsGetSecurityTokenProperty function is a pointer to a
    ///WS_XML_BUFFER containing the XML wire form of the unattached reference to the security token. Unattached
    ///references are used to refer to a security token when the security token does not occur in the same message as
    ///its referring point (such as a signature using that token).
    WS_SECURITY_TOKEN_PROPERTY_UNATTACHED_REFERENCE_XML = 0x00000006,
    WS_SECURITY_TOKEN_PROPERTY_SYMMETRIC_KEY            = 0x00000007,
}

///The types of security keys.
alias WS_SECURITY_KEY_HANDLE_TYPE = int;
enum : int
{
    ///Type ID for WS_RAW_SYMMETRIC_SECURITY_KEY_HANDLE.
    WS_RAW_SYMMETRIC_SECURITY_KEY_HANDLE_TYPE     = 0x00000001,
    ///Type ID for WS_NCRYPT_ASYMMETRIC_SECURITY_KEY_HANDLE.
    WS_NCRYPT_ASYMMETRIC_SECURITY_KEY_HANDLE_TYPE = 0x00000002,
    WS_CAPI_ASYMMETRIC_SECURITY_KEY_HANDLE_TYPE   = 0x00000003,
}

///Defines how a message security binding attaches the security token corresponding to it to a message using WS-Security
///mechanisms.
alias WS_MESSAGE_SECURITY_USAGE = int;
enum : int
{
    WS_SUPPORTING_MESSAGE_SECURITY_USAGE = 0x00000001,
}

///Identifies a property of a security context object. This enumeration is used with WsGetSecurityContextProperty.
alias WS_SECURITY_CONTEXT_PROPERTY_ID = int;
enum : int
{
    ///On the wire, a security context is identified by an absolute URI, which is unique to both sender and recipient.
    ///See WS-SecureConversation. This property is a WS_UNIQUE_ID structure that represents that URI.
    WS_SECURITY_CONTEXT_PROPERTY_IDENTIFIER                     = 0x00000001,
    ///If a WS_USERNAME_MESSAGE_SECURITY_BINDING is used as bootstrap security, this property is a WS_STRING that
    ///represents the username that was used during the establishment of the security context.
    WS_SECURITY_CONTEXT_PROPERTY_USERNAME                       = 0x00000002,
    ///If a WS_KERBEROS_APREQ_MESSAGE_SECURITY_BINDING is used as bootstrap security, this property is a <b>HANDLE</b>
    ///that represents the token that was used during the establishment of the security context.
    WS_SECURITY_CONTEXT_PROPERTY_MESSAGE_SECURITY_WINDOWS_TOKEN = 0x00000003,
    WS_SECURITY_CONTEXT_PROPERTY_SAML_ASSERTION                 = 0x00000004,
}

///The keys for the bag of properties for the creation of XML security tokens. This enumeration is used within the
///WS_XML_SECURITY_TOKEN_PROPERTY structure, which is used as parameter for WsCreateXmlSecurityToken.
alias WS_XML_SECURITY_TOKEN_PROPERTY_ID = int;
enum : int
{
    ///A pointer to a WS_XML_BUFFER that contains the XML form of the reference to be used for this token (from a
    ///signature, for example) when the token is attached to (for example, serialized in) a message. This is required if
    ///and only if the token is a proof-of-possession token. If specified, the XML buffer must have exactly one top
    ///level XML element.
    WS_XML_SECURITY_TOKEN_PROPERTY_ATTACHED_REFERENCE   = 0x00000001,
    ///A pointer to a WS_XML_BUFFER that contains the XML form of the reference to be used for this token (from a
    ///signature, for example) when the token is not attached to a message. This should be specified only if the token
    ///is a proof-of-possession token, and is used without being serialized in the message. If specified, the XML buffer
    ///must have exactly one top level XML element.
    WS_XML_SECURITY_TOKEN_PROPERTY_UNATTACHED_REFERENCE = 0x00000002,
    ///A WS_DATETIME structure that contains the time from when the security token is valid.
    WS_XML_SECURITY_TOKEN_PROPERTY_VALID_FROM_TIME      = 0x00000003,
    WS_XML_SECURITY_TOKEN_PROPERTY_VALID_TILL_TIME      = 0x00000004,
}

///The type IDs of the SAML token authenticators used on the server side (For example, relying party) to validate
///incoming SAML tokens.
alias WS_SAML_AUTHENTICATOR_TYPE = int;
enum : int
{
    WS_CERT_SIGNED_SAML_AUTHENTICATOR_TYPE = 0x00000001,
}

///Identifies the properties for requesting a security token from an issuer. It is used with WsRequestSecurityToken as
///part of the WS_REQUEST_SECURITY_TOKEN_PROPERTY* parameter.
alias WS_REQUEST_SECURITY_TOKEN_PROPERTY_ID = int;
enum : int
{
    ///A pointer to a WS_ENDPOINT_ADDRESS structure containing the address of the service ('relying party') to whom the
    ///requested token will be presented. .
    WS_REQUEST_SECURITY_TOKEN_PROPERTY_APPLIES_TO                  = 0x00000001,
    ///A WS_TRUST_VERSION value that specifies the version of WS-Trust to use. If this property is not specified, it
    ///defaults to WS_TRUST_VERSION_FEBRUARY_2005.
    WS_REQUEST_SECURITY_TOKEN_PROPERTY_TRUST_VERSION               = 0x00000002,
    ///A WS_SECURE_CONVERSATION_VERSION value that specifies the version of WS-SecureConversation to use when
    ///WS_REQUEST_SECURITY_TOKEN_ACTION_NEW_CONTEXT or <b>WS_REQUEST_SECURITY_TOKEN_ACTION_RENEW_CONTEXT</b> are
    ///specified. If this property is not specified, it defaults to WS_SECURE_CONVERSATION_VERSION_FEBRUARY_2005.
    WS_REQUEST_SECURITY_TOKEN_PROPERTY_SECURE_CONVERSATION_VERSION = 0x00000003,
    ///A pointer to a WS_XML_STRING structure that specifies the type of the security token to be issued. If this
    ///property is not specified, the corresponding element is not generated in the request security token message, and
    ///the issuer is assumed to know the token type required.
    WS_REQUEST_SECURITY_TOKEN_PROPERTY_ISSUED_TOKEN_TYPE           = 0x00000004,
    ///A WS_REQUEST_SECURITY_TOKEN_ACTION value that specifies the action to be used with the request. The default is
    ///<b>WS_REQUEST_SECURITY_TOKEN_ACTION_ISSUE</b>.
    WS_REQUEST_SECURITY_TOKEN_PROPERTY_REQUEST_ACTION              = 0x00000005,
    ///A pointer to a WS_SECURITY_TOKEN structure that, if specified, instead of requesting a new token, the provided
    ///token is renewed by requesting a new token based on the existing one. The old token becomes invalid if this
    ///operation succeeds. Only supported with WS_REQUEST_SECURITY_TOKEN_ACTION_RENEW_CONTEXT.
    WS_REQUEST_SECURITY_TOKEN_PROPERTY_EXISTING_TOKEN              = 0x00000006,
    ///A WS_SECURITY_KEY_TYPE value that specifies the type of the cryptographic key to be requested for the issued
    ///security token. This must be set to <b>WS_SECURITY_KEY_TYPE_NONE</b> or <b>WS_SECURITY_KEY_TYPE_SYMMETRIC</b>.
    ///The value WS_SECURITY_KEY_TYPE_NONE specifies a bearer token without proof-of-possession keys. Such tokens will
    ///not produce a signature when used to secure a message. If this property is not specified, the corresponding key
    ///type element is not emitted in token requests. Not emitting the key type in token requests results in the implied
    ///default of symmetric keys for the issued token, as defined in the WS-Trust specification.
    WS_REQUEST_SECURITY_TOKEN_PROPERTY_ISSUED_TOKEN_KEY_TYPE       = 0x00000007,
    ///A <b>ULONG</b> that specifies the size (in bits) of the cryptographic key to be requested in the issued security
    ///token. This property may be specified only for issued tokens with symmetric keys. If this property is not
    ///specified, the corresponding key size element is not emitted in token requests.
    WS_REQUEST_SECURITY_TOKEN_PROPERTY_ISSUED_TOKEN_KEY_SIZE       = 0x00000008,
    ///A WS_SECURITY_KEY_ENTROPY_MODE value that specifies how entropy is contributed to the cryptographic key of the
    ///issued token. This property may be specified only for issued tokens with symmetric keys. If this property is not
    ///specified, the mode <b>WS_SECURITY_KEY_ENTROPY_MODE_SERVER_ONLY</b> is used.
    WS_REQUEST_SECURITY_TOKEN_PROPERTY_ISSUED_TOKEN_KEY_ENTROPY    = 0x00000009,
    ///A pointer to a WS_XML_BUFFER that contains the additional primary parameters to be included verbatim in request
    ///security token messages. Each such parameter must be a top-level element in the supplied XML buffer. If this
    ///property is not specified, such parameters are not emitted. The buffer is serialized into the
    ///RequestSecurityToken element when requesting a security token. Unlike
    ///WS_REQUEST_SECURITY_TOKEN_PROPERTY_SERVICE_REQUEST_PARAMETERS, local request parameters are defined by the client
    ///as a means to add parameters to the token request.
    WS_REQUEST_SECURITY_TOKEN_PROPERTY_LOCAL_REQUEST_PARAMETERS    = 0x0000000a,
    ///A pointer to a WS_XML_BUFFER that contains the service parameters to include in request security token messages,
    ///supplied as an XML buffer. Each such parameter must be a top-level element in the supplied XML buffer. If this is
    ///property not specified, such parameters are not emitted. If WS_TRUST_VERSION_FEBRUARY_2005 is specified this
    ///buffer is serialized into the RequestSecurityToken element following the
    ///WS_REQUEST_SECURITY_TOKEN_PROPERTY_LOCAL_REQUEST_PARAMETERS. If WS_TRUST_VERSION_1_3 is specified this buffer is
    ///serialized into the RequestSecurityToken/SecondaryParameters element. Service request parameters are instructions
    ///regarding how to issue a token. They are obtained from the service, usually by means of metadata import. In that
    ///case, this parameter may be obtained from the out.RequestSecurityTokenTemplate field of the
    ///WS_ISSUED_TOKEN_MESSAGE_SECURITY_BINDING_CONSTRAINT.
    WS_REQUEST_SECURITY_TOKEN_PROPERTY_SERVICE_REQUEST_PARAMETERS  = 0x0000000b,
    ///The set of WS_MESSAGE_PROPERTIES to be specified while creating the two messages with WsCreateMessage and are to
    ///be used for the security token obtaining exchange. If this property is not specified, the request and reply
    ///messages are created with the default message properties.
    WS_REQUEST_SECURITY_TOKEN_PROPERTY_MESSAGE_PROPERTIES          = 0x0000000c,
    WS_REQUEST_SECURITY_TOKEN_PROPERTY_BEARER_KEY_TYPE_VERSION     = 0x0000000d,
}

alias WS_SECURITY_BEARER_KEY_TYPE_VERSION = int;
enum : int
{
    WS_SECURITY_BEARER_KEY_TYPE_VERSION_1_3_ORIGINAL_SPECIFICATION = 0x00000001,
    WS_SECURITY_BEARER_KEY_TYPE_VERSION_1_3_ORIGINAL_SCHEMA        = 0x00000002,
    WS_SECURITY_BEARER_KEY_TYPE_VERSION_1_3_ERRATA_01              = 0x00000003,
}

///The types supported for serialization.
alias WS_TYPE = int;
enum : int
{
    ///Used when serializing a <b>BOOL</b> value. The WS_BOOL_DESCRIPTION type description can optionally be specified
    ///for this type in order to constrain the allowed values. This type can be used with the following WS_TYPE_MAPPING
    ///values: <ul> <li> WS_ELEMENT_TYPE_MAPPING </li> <li> WS_ATTRIBUTE_TYPE_MAPPING </li> <li>
    ///WS_ELEMENT_CONTENT_TYPE_MAPPING </li> </ul> This type can be used with the following WS_FIELD_MAPPING values:
    ///<ul> <li> WS_ELEMENT_FIELD_MAPPING </li> <li> WS_REPEATING_ELEMENT_FIELD_MAPPING </li> <li>
    ///WS_ATTRIBUTE_FIELD_MAPPING </li> <li> WS_TEXT_FIELD_MAPPING </li> <li> WS_NO_FIELD_MAPPING </li> </ul> This type
    ///can be used with the following WS_FIELD_OPTIONS values. See the documentation for WS_FIELD_MAPPING for which
    ///options are supported for a given field mapping value: <ul> <li>0 </li> <li> WS_FIELD_OPTIONAL </li> <li>
    ///WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE</b> |
    ///<b>WS_FIELD_OPTIONAL</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_POINTER |
    ///<b>WS_FIELD_NILLABLE</b> | <b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_OPTIONAL</b> |
    ///<b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE</b> | <b>WS_FIELD_OPTIONAL</b> |
    ///<b>WS_FIELD_NILLABLE_ITEM</b></li> </ul> A nil value is represented using a <b>NULL</b> pointer. A
    ///WS_DEFAULT_VALUE may be specified for this type. See the documentation for WS_FIELD_MAPPING to see which field
    ///mapping values allow a default value to be specified.
    WS_BOOL_TYPE             = 0x00000000,
    ///Used when serializing a signed 8-bit integer (<b>char</b>). The WS_INT8_DESCRIPTION type description can
    ///optionally be specified for this type in order to constrain the allowed values. This type can be used with the
    ///following WS_TYPE_MAPPING values: <ul> <li> WS_ELEMENT_TYPE_MAPPING </li> <li> WS_ATTRIBUTE_TYPE_MAPPING </li>
    ///<li> WS_ELEMENT_CONTENT_TYPE_MAPPING </li> </ul> This type can be used with the following WS_FIELD_MAPPING
    ///values: <ul> <li> WS_ELEMENT_FIELD_MAPPING </li> <li> WS_REPEATING_ELEMENT_FIELD_MAPPING </li> <li>
    ///WS_ATTRIBUTE_FIELD_MAPPING </li> <li> WS_TEXT_FIELD_MAPPING </li> <li> WS_NO_FIELD_MAPPING </li> </ul> This type
    ///can be used with the following WS_FIELD_OPTIONS values. See the documentation for WS_FIELD_MAPPING for which
    ///options are supported for a given field mapping value: <ul> <li>0 </li> <li> WS_FIELD_OPTIONAL </li> <li>
    ///WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE</b> |
    ///<b>WS_FIELD_OPTIONAL</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_POINTER |
    ///<b>WS_FIELD_NILLABLE</b> | <b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_OPTIONAL</b> |
    ///<b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE</b> | <b>WS_FIELD_OPTIONAL</b> |
    ///<b>WS_FIELD_NILLABLE_ITEM</b></li> </ul> A nil value is represented using a <b>NULL</b> pointer. A
    ///WS_DEFAULT_VALUE may be specified for this type. See the documentation for WS_FIELD_MAPPING to see which field
    ///mapping values allow a default value to be specified.
    WS_INT8_TYPE             = 0x00000001,
    ///Used when serializing a signed 16-bit integer (<b>short</b>). The WS_INT16_DESCRIPTION type description can
    ///optionally be specified for this type in order to constrain the allowed values. This type can be used with the
    ///following WS_TYPE_MAPPING values: <ul> <li> WS_ELEMENT_TYPE_MAPPING </li> <li> WS_ATTRIBUTE_TYPE_MAPPING </li>
    ///<li> WS_ELEMENT_CONTENT_TYPE_MAPPING </li> </ul> This type can be used with the following WS_FIELD_MAPPING
    ///values: <ul> <li> WS_ELEMENT_FIELD_MAPPING </li> <li> WS_REPEATING_ELEMENT_FIELD_MAPPING </li> <li>
    ///WS_ATTRIBUTE_FIELD_MAPPING </li> <li> WS_TEXT_FIELD_MAPPING </li> <li> WS_NO_FIELD_MAPPING </li> </ul> This type
    ///can be used with the following WS_FIELD_OPTIONS values. See the documentation for WS_FIELD_MAPPING for which
    ///options are supported for a given field mapping value: <ul> <li>0 </li> <li> WS_FIELD_OPTIONAL </li> <li>
    ///WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE</b> |
    ///<b>WS_FIELD_OPTIONAL</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_POINTER |
    ///<b>WS_FIELD_NILLABLE</b> | <b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_OPTIONAL</b> |
    ///<b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE</b> | <b>WS_FIELD_OPTIONAL</b> |
    ///<b>WS_FIELD_NILLABLE_ITEM</b></li> </ul> A nil value is represented using a <b>NULL</b> pointer. A
    ///WS_DEFAULT_VALUE may be specified for this type. See the documentation for WS_FIELD_MAPPING to see which field
    ///mapping values allow a default value to be specified.
    WS_INT16_TYPE            = 0x00000002,
    ///Used when serializing a signed 32-bit integer. The WS_INT32_DESCRIPTION type description can optionally be
    ///specified for this type in order to constrain the allowed values. This type can be used with the following
    ///WS_TYPE_MAPPING values: <ul> <li> WS_ELEMENT_TYPE_MAPPING </li> <li> WS_ATTRIBUTE_TYPE_MAPPING </li> <li>
    ///WS_ELEMENT_CONTENT_TYPE_MAPPING </li> </ul> This type can be used with the following WS_FIELD_MAPPING values:
    ///<ul> <li> WS_ELEMENT_FIELD_MAPPING </li> <li> WS_REPEATING_ELEMENT_FIELD_MAPPING </li> <li>
    ///WS_ATTRIBUTE_FIELD_MAPPING </li> <li> WS_TEXT_FIELD_MAPPING </li> <li> WS_NO_FIELD_MAPPING </li> </ul> This type
    ///can be used with the following WS_FIELD_OPTIONS values. See the documentation for WS_FIELD_MAPPING for which
    ///options are supported for a given field mapping value: <ul> <li>0 </li> <li> WS_FIELD_OPTIONAL </li> <li>
    ///WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE</b> |
    ///<b>WS_FIELD_OPTIONAL</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_POINTER |
    ///<b>WS_FIELD_NILLABLE</b> | <b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_OPTIONAL</b> |
    ///<b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE</b> | <b>WS_FIELD_OPTIONAL</b> |
    ///<b>WS_FIELD_NILLABLE_ITEM</b></li> </ul> A nil value is represented using a <b>NULL</b> pointer. A
    ///WS_DEFAULT_VALUE may be specified for this type. See the documentation for WS_FIELD_MAPPING to see which field
    ///mapping values allow a default value to be specified.
    WS_INT32_TYPE            = 0x00000003,
    ///Used when serializing a signed 64-bit integer. The WS_INT64_DESCRIPTION type description can optionally be
    ///specified for this type in order to constrain the allowed values. This type can be used with the following
    ///WS_TYPE_MAPPING values: <ul> <li> WS_ELEMENT_TYPE_MAPPING </li> <li> WS_ATTRIBUTE_TYPE_MAPPING </li> <li>
    ///WS_ELEMENT_CONTENT_TYPE_MAPPING </li> </ul> This type can be used with the following WS_FIELD_MAPPING values:
    ///<ul> <li> WS_ELEMENT_FIELD_MAPPING </li> <li> WS_REPEATING_ELEMENT_FIELD_MAPPING </li> <li>
    ///WS_ATTRIBUTE_FIELD_MAPPING </li> <li> WS_TEXT_FIELD_MAPPING </li> <li> WS_NO_FIELD_MAPPING </li> </ul> This type
    ///can be used with the following WS_FIELD_OPTIONS values. See the documentation for WS_FIELD_MAPPING for which
    ///options are supported for a given field mapping value: <ul> <li>0 </li> <li> WS_FIELD_OPTIONAL </li> <li>
    ///WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE</b> |
    ///<b>WS_FIELD_OPTIONAL</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_POINTER |
    ///<b>WS_FIELD_NILLABLE</b> | <b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_OPTIONAL</b> |
    ///<b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE</b> | <b>WS_FIELD_OPTIONAL</b> |
    ///<b>WS_FIELD_NILLABLE_ITEM</b></li> </ul> A nil value is represented using a <b>NULL</b> pointer. A
    ///WS_DEFAULT_VALUE may be specified for this type. See the documentation for WS_FIELD_MAPPING to see which field
    ///mapping values allow a default value to be specified.
    WS_INT64_TYPE            = 0x00000004,
    ///Used when serializing an unsigned 8-bit integer (<b>BYTE</b>). The WS_UINT8_DESCRIPTION type description can
    ///optionally be specified for this type in order to constrain the allowed values. This type can be used with the
    ///following WS_TYPE_MAPPING values: <ul> <li> WS_ELEMENT_TYPE_MAPPING </li> <li> WS_ATTRIBUTE_TYPE_MAPPING </li>
    ///<li> WS_ELEMENT_CONTENT_TYPE_MAPPING </li> </ul> This type can be used with the following WS_FIELD_MAPPING
    ///values: <ul> <li> WS_ELEMENT_FIELD_MAPPING </li> <li> WS_REPEATING_ELEMENT_FIELD_MAPPING </li> <li>
    ///WS_ATTRIBUTE_FIELD_MAPPING </li> <li> WS_TEXT_FIELD_MAPPING </li> <li> WS_NO_FIELD_MAPPING </li> </ul> This type
    ///can be used with the following WS_FIELD_OPTIONS values. See the documentation for WS_FIELD_MAPPING for which
    ///options are supported for a given field mapping value: <ul> <li>0 </li> <li> WS_FIELD_OPTIONAL </li> <li>
    ///WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE</b> |
    ///<b>WS_FIELD_OPTIONAL</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_POINTER |
    ///<b>WS_FIELD_NILLABLE</b> | <b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_OPTIONAL</b> |
    ///<b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE</b> | <b>WS_FIELD_OPTIONAL</b> |
    ///<b>WS_FIELD_NILLABLE_ITEM</b></li> </ul> A nil value is represented using a <b>NULL</b> pointer. A
    ///WS_DEFAULT_VALUE may be specified for this type. See the documentation for WS_FIELD_MAPPING to see which field
    ///mapping values allow a default value to be specified.
    WS_UINT8_TYPE            = 0x00000005,
    ///Used when serializing an unsigned 16-bit integer. The WS_UINT16_DESCRIPTION type description can optionally be
    ///specified for this type in order to constrain the allowed values. This type can be used with the following
    ///WS_TYPE_MAPPING values: <ul> <li> WS_ELEMENT_TYPE_MAPPING </li> <li> WS_ATTRIBUTE_TYPE_MAPPING </li> <li>
    ///WS_ELEMENT_CONTENT_TYPE_MAPPING </li> </ul> This type can be used with the following WS_FIELD_MAPPING values:
    ///<ul> <li> WS_ELEMENT_FIELD_MAPPING </li> <li> WS_REPEATING_ELEMENT_FIELD_MAPPING </li> <li>
    ///WS_ATTRIBUTE_FIELD_MAPPING </li> <li> WS_TEXT_FIELD_MAPPING </li> <li> WS_NO_FIELD_MAPPING </li> </ul> This type
    ///can be used with the following WS_FIELD_OPTIONS values. See the documentation for WS_FIELD_MAPPING for which
    ///options are supported for a given field mapping value: <ul> <li>0 </li> <li> WS_FIELD_OPTIONAL </li> <li>
    ///WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE</b> |
    ///<b>WS_FIELD_OPTIONAL</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_POINTER |
    ///<b>WS_FIELD_NILLABLE</b> | <b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_OPTIONAL</b> |
    ///<b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE</b> | <b>WS_FIELD_OPTIONAL</b> |
    ///<b>WS_FIELD_NILLABLE_ITEM</b></li> </ul> A nil value is represented using a <b>NULL</b> pointer. A
    ///WS_DEFAULT_VALUE may be specified for this type. See the documentation for WS_FIELD_MAPPING to see which field
    ///mapping values allow a default value to be specified.
    WS_UINT16_TYPE           = 0x00000006,
    ///Used when serializing an unsigned 32-bit integer. The WS_UINT32_DESCRIPTION type description can optionally be
    ///specified for this type in order to constrain the allowed values. This type can be used with the following
    ///WS_TYPE_MAPPING values: <ul> <li> WS_ELEMENT_TYPE_MAPPING </li> <li> WS_ATTRIBUTE_TYPE_MAPPING </li> <li>
    ///WS_ELEMENT_CONTENT_TYPE_MAPPING </li> </ul> This type can be used with the following WS_FIELD_MAPPING values:
    ///<ul> <li> WS_ELEMENT_FIELD_MAPPING </li> <li> WS_REPEATING_ELEMENT_FIELD_MAPPING </li> <li>
    ///WS_ATTRIBUTE_FIELD_MAPPING </li> <li> WS_TEXT_FIELD_MAPPING </li> <li> WS_NO_FIELD_MAPPING </li> </ul> This type
    ///can be used with the following WS_FIELD_OPTIONS values. See the documentation for WS_FIELD_MAPPING for which
    ///options are supported for a given field mapping value: <ul> <li>0 </li> <li> WS_FIELD_OPTIONAL </li> <li>
    ///WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE</b> |
    ///<b>WS_FIELD_OPTIONAL</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_POINTER |
    ///<b>WS_FIELD_NILLABLE</b> | <b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_OPTIONAL</b> |
    ///<b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE</b> | <b>WS_FIELD_OPTIONAL</b> |
    ///<b>WS_FIELD_NILLABLE_ITEM</b></li> </ul> A nil value is represented using a <b>NULL</b> pointer. A
    ///WS_DEFAULT_VALUE may be specified for this type. See the documentation for WS_FIELD_MAPPING to see which field
    ///mapping values allow a default value to be specified.
    WS_UINT32_TYPE           = 0x00000007,
    ///Used when serializing an unsigned 64-bit integer. The WS_UINT64_DESCRIPTION type description can optionally be
    ///specified for this type in order to constrain the allowed values. This type can be used with the following
    ///WS_TYPE_MAPPING values: <ul> <li> WS_ELEMENT_TYPE_MAPPING </li> <li> WS_ATTRIBUTE_TYPE_MAPPING </li> <li>
    ///WS_ELEMENT_CONTENT_TYPE_MAPPING </li> </ul> This type can be used with the following WS_FIELD_MAPPING values:
    ///<ul> <li> WS_ELEMENT_FIELD_MAPPING </li> <li> WS_REPEATING_ELEMENT_FIELD_MAPPING </li> <li>
    ///WS_ATTRIBUTE_FIELD_MAPPING </li> <li> WS_TEXT_FIELD_MAPPING </li> <li> WS_NO_FIELD_MAPPING </li> </ul> This type
    ///can be used with the following WS_FIELD_OPTIONS values. See the documentation for WS_FIELD_MAPPING for which
    ///options are supported for a given field mapping value: <ul> <li>0 </li> <li> WS_FIELD_OPTIONAL </li> <li>
    ///WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE</b> |
    ///<b>WS_FIELD_OPTIONAL</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_POINTER |
    ///<b>WS_FIELD_NILLABLE</b> | <b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_OPTIONAL</b> |
    ///<b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE</b> | <b>WS_FIELD_OPTIONAL</b> |
    ///<b>WS_FIELD_NILLABLE_ITEM</b></li> </ul> A nil value is represented using a <b>NULL</b> pointer. A
    ///WS_DEFAULT_VALUE may be specified for this type. See the documentation for WS_FIELD_MAPPING to see which field
    ///mapping values allow a default value to be specified.
    WS_UINT64_TYPE           = 0x00000008,
    ///Used when serializing a <b>float</b>. The WS_FLOAT_DESCRIPTION type description can optionally be specified for
    ///this type in order to constrain the allowed values. This type can be used with the following WS_TYPE_MAPPING
    ///values: <ul> <li> WS_ELEMENT_TYPE_MAPPING </li> <li> WS_ATTRIBUTE_TYPE_MAPPING </li> <li>
    ///WS_ELEMENT_CONTENT_TYPE_MAPPING </li> </ul> This type can be used with the following WS_FIELD_MAPPING values:
    ///<ul> <li> WS_ELEMENT_FIELD_MAPPING </li> <li> WS_REPEATING_ELEMENT_FIELD_MAPPING </li> <li>
    ///WS_ATTRIBUTE_FIELD_MAPPING </li> <li> WS_TEXT_FIELD_MAPPING </li> <li> WS_NO_FIELD_MAPPING </li> </ul> This type
    ///can be used with the following WS_FIELD_OPTIONS values. See the documentation for WS_FIELD_MAPPING for which
    ///options are supported for a given field mapping value: <ul> <li>0 </li> <li> WS_FIELD_OPTIONAL </li> <li>
    ///WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE</b> |
    ///<b>WS_FIELD_OPTIONAL</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_POINTER |
    ///<b>WS_FIELD_NILLABLE</b> | <b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_OPTIONAL</b> |
    ///<b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE</b> | <b>WS_FIELD_OPTIONAL</b> |
    ///<b>WS_FIELD_NILLABLE_ITEM</b></li> </ul> A nil value is represented using a <b>NULL</b> pointer. A
    ///WS_DEFAULT_VALUE may be specified for this type. See the documentation for WS_FIELD_MAPPING to see which field
    ///mapping values allow a default value to be specified.
    WS_FLOAT_TYPE            = 0x00000009,
    ///Used when serializing a <b>double</b>. The WS_DOUBLE_DESCRIPTION type description can optionally be specified for
    ///this type in order to constrain the allowed values. This type can be used with the following WS_TYPE_MAPPING
    ///values: <ul> <li> WS_ELEMENT_TYPE_MAPPING </li> <li> WS_ATTRIBUTE_TYPE_MAPPING </li> <li>
    ///WS_ELEMENT_CONTENT_TYPE_MAPPING </li> </ul> This type can be used with the following WS_FIELD_MAPPING values:
    ///<ul> <li> WS_ELEMENT_FIELD_MAPPING </li> <li> WS_REPEATING_ELEMENT_FIELD_MAPPING </li> <li>
    ///WS_ATTRIBUTE_FIELD_MAPPING </li> <li> WS_TEXT_FIELD_MAPPING </li> <li> WS_NO_FIELD_MAPPING </li> </ul> This type
    ///can be used with the following WS_FIELD_OPTIONS values. See the documentation for WS_FIELD_MAPPING for which
    ///options are supported for a given field mapping value: <ul> <li>0 </li> <li> WS_FIELD_OPTIONAL </li> <li>
    ///WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE</b> |
    ///<b>WS_FIELD_OPTIONAL</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_POINTER |
    ///<b>WS_FIELD_NILLABLE</b> | <b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_OPTIONAL</b> |
    ///<b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE</b> | <b>WS_FIELD_OPTIONAL</b> |
    ///<b>WS_FIELD_NILLABLE_ITEM</b></li> </ul> A nil value is represented using a <b>NULL</b> pointer. A
    ///WS_DEFAULT_VALUE may be specified for this type. See the documentation for WS_FIELD_MAPPING to see which field
    ///mapping values allow a default value to be specified.
    WS_DOUBLE_TYPE           = 0x0000000a,
    ///Used when serializing a <b>DECIMAL</b>. The WS_DECIMAL_DESCRIPTION type description can optionally be specified
    ///for this type in order to constrain the allowed values. This type can be used with the following WS_TYPE_MAPPING
    ///values: <ul> <li> WS_ELEMENT_TYPE_MAPPING </li> <li> WS_ATTRIBUTE_TYPE_MAPPING </li> <li>
    ///WS_ELEMENT_CONTENT_TYPE_MAPPING </li> </ul> This type can be used with the following WS_FIELD_MAPPING values:
    ///<ul> <li> WS_ELEMENT_FIELD_MAPPING </li> <li> WS_REPEATING_ELEMENT_FIELD_MAPPING </li> <li>
    ///WS_ATTRIBUTE_FIELD_MAPPING </li> <li> WS_TEXT_FIELD_MAPPING </li> <li> WS_NO_FIELD_MAPPING </li> </ul> This type
    ///can be used with the following WS_FIELD_OPTIONS values. See the documentation for WS_FIELD_MAPPING for which
    ///options are supported for a given field mapping value: <ul> <li>0 </li> <li> WS_FIELD_OPTIONAL </li> <li>
    ///WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE</b> |
    ///<b>WS_FIELD_OPTIONAL</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_POINTER |
    ///<b>WS_FIELD_NILLABLE</b> | <b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_OPTIONAL</b> |
    ///<b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE</b> | <b>WS_FIELD_OPTIONAL</b> |
    ///<b>WS_FIELD_NILLABLE_ITEM</b></li> </ul> A nil value is represented using a <b>NULL</b> pointer. A
    ///WS_DEFAULT_VALUE may be specified for this type. See the documentation for WS_FIELD_MAPPING to see which field
    ///mapping values allow a default value to be specified.
    WS_DECIMAL_TYPE          = 0x0000000b,
    ///Used when serializing a WS_DATETIME. The WS_DATETIME_DESCRIPTION type description can optionally be specified for
    ///this type in order to constrain the allowed values. This type can be used with the following WS_TYPE_MAPPING
    ///values: <ul> <li> WS_ELEMENT_TYPE_MAPPING </li> <li> WS_ATTRIBUTE_TYPE_MAPPING </li> <li>
    ///WS_ELEMENT_CONTENT_TYPE_MAPPING </li> </ul> This type can be used with the following WS_FIELD_MAPPING values:
    ///<ul> <li> WS_ELEMENT_FIELD_MAPPING </li> <li> WS_REPEATING_ELEMENT_FIELD_MAPPING </li> <li>
    ///WS_ATTRIBUTE_FIELD_MAPPING </li> <li> WS_TEXT_FIELD_MAPPING </li> <li> WS_NO_FIELD_MAPPING </li> </ul> This type
    ///can be used with the following WS_FIELD_OPTIONS values. See the documentation for WS_FIELD_MAPPING for which
    ///options are supported for a given field mapping value: <ul> <li>0 </li> <li> WS_FIELD_OPTIONAL </li> <li>
    ///WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE</b> |
    ///<b>WS_FIELD_OPTIONAL</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_POINTER |
    ///<b>WS_FIELD_NILLABLE</b> | <b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_OPTIONAL</b> |
    ///<b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE</b> | <b>WS_FIELD_OPTIONAL</b> |
    ///<b>WS_FIELD_NILLABLE_ITEM</b></li> </ul> A nil value is represented using a <b>NULL</b> pointer. A
    ///WS_DEFAULT_VALUE may be specified for this type. See the documentation for WS_FIELD_MAPPING to see which field
    ///mapping values allow a default value to be specified.
    WS_DATETIME_TYPE         = 0x0000000c,
    ///Used when serializing a WS_TIMESPAN. The WS_TIMESPAN_DESCRIPTION type description can optionally be specified for
    ///this type in order to constrain the allowed values. This type can be used with the following WS_TYPE_MAPPING
    ///values: <ul> <li> WS_ELEMENT_TYPE_MAPPING </li> <li> WS_ATTRIBUTE_TYPE_MAPPING </li> <li>
    ///WS_ELEMENT_CONTENT_TYPE_MAPPING </li> </ul> This type can be used with the following WS_FIELD_MAPPING values:
    ///<ul> <li> WS_ELEMENT_FIELD_MAPPING </li> <li> WS_REPEATING_ELEMENT_FIELD_MAPPING </li> <li>
    ///WS_ATTRIBUTE_FIELD_MAPPING </li> <li> WS_TEXT_FIELD_MAPPING </li> <li> WS_NO_FIELD_MAPPING </li> </ul> This type
    ///can be used with the following WS_FIELD_OPTIONS values. See the documentation for WS_FIELD_MAPPING for which
    ///options are supported for a given field mapping value: <ul> <li>0 </li> <li> WS_FIELD_OPTIONAL </li> <li>
    ///WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE</b> |
    ///<b>WS_FIELD_OPTIONAL</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_POINTER |
    ///<b>WS_FIELD_NILLABLE</b> | <b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_OPTIONAL</b> |
    ///<b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE</b> | <b>WS_FIELD_OPTIONAL</b> |
    ///<b>WS_FIELD_NILLABLE_ITEM</b></li> </ul> A nil value is represented using a <b>NULL</b> pointer. A
    ///WS_DEFAULT_VALUE may be specified for this type. See the documentation for WS_FIELD_MAPPING to see which field
    ///mapping values allow a default value to be specified.
    WS_TIMESPAN_TYPE         = 0x0000000d,
    ///Used when serializing a <b>GUID</b>. The WS_GUID_DESCRIPTION type description can optionally be specified for
    ///this type in order to constrain the allowed values. This type can be used with the following WS_TYPE_MAPPING
    ///values: <ul> <li> WS_ELEMENT_TYPE_MAPPING </li> <li> WS_ATTRIBUTE_TYPE_MAPPING </li> <li>
    ///WS_ELEMENT_CONTENT_TYPE_MAPPING </li> </ul> This type can be used with the following WS_FIELD_MAPPING values:
    ///<ul> <li> WS_ELEMENT_FIELD_MAPPING </li> <li> WS_REPEATING_ELEMENT_FIELD_MAPPING </li> <li>
    ///WS_ATTRIBUTE_FIELD_MAPPING </li> <li> WS_TEXT_FIELD_MAPPING </li> <li> WS_NO_FIELD_MAPPING </li> </ul> This type
    ///can be used with the following WS_FIELD_OPTIONS values. See the documentation for WS_FIELD_MAPPING for which
    ///options are supported for a given field mapping value: <ul> <li>0 </li> <li> WS_FIELD_OPTIONAL </li> <li>
    ///WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE</b> |
    ///<b>WS_FIELD_OPTIONAL</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_POINTER |
    ///<b>WS_FIELD_NILLABLE</b> | <b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_OPTIONAL</b> |
    ///<b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE</b> | <b>WS_FIELD_OPTIONAL</b> |
    ///<b>WS_FIELD_NILLABLE_ITEM</b></li> </ul> A nil value is represented using a <b>NULL</b> pointer. A
    ///WS_DEFAULT_VALUE may be specified for this type. See the documentation for WS_FIELD_MAPPING to see which field
    ///mapping values allow a default value to be specified.
    WS_GUID_TYPE             = 0x0000000e,
    ///Used when serializing a WS_UNIQUE_ID. The WS_UNIQUE_ID_DESCRIPTION type description can optionally be specified
    ///for this type in order to constrain the allowed values. This type can be used with the following WS_TYPE_MAPPING
    ///values: <ul> <li> WS_ELEMENT_TYPE_MAPPING </li> <li> WS_ATTRIBUTE_TYPE_MAPPING </li> <li>
    ///WS_ELEMENT_CONTENT_TYPE_MAPPING </li> </ul> This type can be used with the following WS_FIELD_MAPPING values:
    ///<ul> <li> WS_ELEMENT_FIELD_MAPPING </li> <li> WS_REPEATING_ELEMENT_FIELD_MAPPING </li> <li>
    ///WS_ATTRIBUTE_FIELD_MAPPING </li> <li> WS_TEXT_FIELD_MAPPING </li> <li> WS_NO_FIELD_MAPPING </li> </ul> This type
    ///can be used with the following WS_FIELD_OPTIONS values. See the documentation for WS_FIELD_MAPPING for which
    ///options are supported for a given field mapping value: <ul> <li>0 </li> <li> WS_FIELD_OPTIONAL </li> <li>
    ///WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE</b> |
    ///<b>WS_FIELD_OPTIONAL</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_POINTER |
    ///<b>WS_FIELD_NILLABLE</b> | <b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_OPTIONAL</b> |
    ///<b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE</b> | <b>WS_FIELD_OPTIONAL</b> |
    ///<b>WS_FIELD_NILLABLE_ITEM</b></li> </ul> A nil value is represented using a <b>NULL</b> pointer. A
    ///WS_DEFAULT_VALUE may be specified for this type. See the documentation for WS_FIELD_MAPPING to see which field
    ///mapping values allow a default value to be specified.
    WS_UNIQUE_ID_TYPE        = 0x0000000f,
    ///Used when serializing a WS_STRING. The WS_STRING_DESCRIPTION type description can optionally be specified for
    ///this type in order to constrain the allowed values. This type can be used with the following WS_TYPE_MAPPING
    ///values: <ul> <li> WS_ELEMENT_TYPE_MAPPING </li> <li> WS_ATTRIBUTE_TYPE_MAPPING </li> <li>
    ///WS_ELEMENT_CONTENT_TYPE_MAPPING </li> </ul> This type can be used with the following WS_FIELD_MAPPING values:
    ///<ul> <li> WS_ELEMENT_FIELD_MAPPING </li> <li> WS_REPEATING_ELEMENT_FIELD_MAPPING </li> <li>
    ///WS_ATTRIBUTE_FIELD_MAPPING </li> <li> WS_TEXT_FIELD_MAPPING </li> <li> WS_NO_FIELD_MAPPING </li> <li>
    ///WS_XML_ATTRIBUTE_FIELD_MAPPING </li> </ul> This type can be used with the following WS_FIELD_OPTIONS values. See
    ///the documentation for WS_FIELD_MAPPING for which options are supported for a given field mapping value: <ul>
    ///<li>0 </li> <li> WS_FIELD_OPTIONAL </li> <li> WS_FIELD_NILLABLE </li> <li> WS_FIELD_NILLABLE |
    ///<b>WS_FIELD_OPTIONAL</b></li> <li> WS_FIELD_NILLABLE_ITEM </li> <li> WS_FIELD_NILLABLE |
    ///<b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_OPTIONAL | <b>WS_FIELD_NILLABLE_ITEM</b></li> <li>
    ///WS_FIELD_NILLABLE | <b>WS_FIELD_OPTIONAL</b> | <b>WS_FIELD_NILLABLE_ITEM</b></li> </ul> A nil value is
    ///represented by setting the chars field to <b>NULL</b> and specifying a length of 0. A nil string is distinquished
    ///from an empty string based on whether or not the chars field is <b>NULL</b> or not when the length is zero. A
    ///WS_DEFAULT_VALUE may be specified for this type. See the documentation for WS_FIELD_MAPPING to see which field
    ///mapping values allow a default value to be specified.
    WS_STRING_TYPE           = 0x00000010,
    ///Used when serializing a zero-terminated <b>WCHAR</b>*. The WS_WSZ_DESCRIPTION type description can optionally be
    ///specified for this type in order to constrain the allowed values. Deserialization will return an error if the
    ///wire form of the string contains an embedded zero. This type can be used with the following WS_TYPE_MAPPING
    ///values: <ul> <li> WS_ELEMENT_TYPE_MAPPING </li> <li> WS_ATTRIBUTE_TYPE_MAPPING </li> <li>
    ///WS_ELEMENT_CONTENT_TYPE_MAPPING </li> </ul> This type can be used with the following WS_FIELD_MAPPING values:
    ///<ul> <li> WS_ELEMENT_FIELD_MAPPING </li> <li> WS_REPEATING_ELEMENT_FIELD_MAPPING </li> <li>
    ///WS_ATTRIBUTE_FIELD_MAPPING </li> <li> WS_TEXT_FIELD_MAPPING </li> <li> WS_NO_FIELD_MAPPING </li> <li>
    ///WS_XML_ATTRIBUTE_FIELD_MAPPING </li> </ul> This type can be used with the following WS_FIELD_OPTIONS values. See
    ///the documentation for WS_FIELD_MAPPING for which options are supported for a given field mapping value: <ul>
    ///<li>0 </li> <li> WS_FIELD_OPTIONAL </li> <li> WS_FIELD_NILLABLE </li> <li> WS_FIELD_NILLABLE |
    ///<b>WS_FIELD_OPTIONAL</b></li> <li> WS_FIELD_NILLABLE_ITEM </li> <li> WS_FIELD_NILLABLE |
    ///<b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_OPTIONAL | <b>WS_FIELD_NILLABLE_ITEM</b></li> <li>
    ///WS_FIELD_NILLABLE | <b>WS_FIELD_OPTIONAL</b> | <b>WS_FIELD_NILLABLE_ITEM</b></li> </ul> A nil value is
    ///represented using a <b>NULL</b> pointer. A WS_DEFAULT_VALUE may be specified for this type. See the documentation
    ///for WS_FIELD_MAPPING to see which field mapping values allow a default value to be specified. The default value
    ///should point to the address of a WCHAR*, and the size should be sizeof(WCHAR*).
    WS_WSZ_TYPE              = 0x00000011,
    ///Used when serializing a WS_BYTES. The WS_BYTES_DESCRIPTION type description can optionally be specified for this
    ///type in order to constrain the allowed values. This type can be used with the following WS_TYPE_MAPPING values:
    ///<ul> <li> WS_ELEMENT_TYPE_MAPPING </li> <li> WS_ATTRIBUTE_TYPE_MAPPING </li> <li> WS_ELEMENT_CONTENT_TYPE_MAPPING
    ///</li> </ul> This type can be used with the following WS_FIELD_MAPPING values: <ul> <li> WS_ELEMENT_FIELD_MAPPING
    ///</li> <li> WS_REPEATING_ELEMENT_FIELD_MAPPING </li> <li> WS_ATTRIBUTE_FIELD_MAPPING </li> <li>
    ///WS_TEXT_FIELD_MAPPING </li> <li> WS_NO_FIELD_MAPPING </li> </ul> This type can be used with the following
    ///WS_FIELD_OPTIONS values. See the documentation for WS_FIELD_MAPPING for which options are supported for a given
    ///field mapping value: <ul> <li>0 </li> <li> WS_FIELD_OPTIONAL </li> <li> WS_FIELD_NILLABLE </li> <li>
    ///WS_FIELD_NILLABLE | <b>WS_FIELD_OPTIONAL</b></li> <li> WS_FIELD_NILLABLE_ITEM </li> <li> WS_FIELD_NILLABLE |
    ///<b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_OPTIONAL | <b>WS_FIELD_NILLABLE_ITEM</b></li> <li>
    ///WS_FIELD_NILLABLE | <b>WS_FIELD_OPTIONAL</b> | <b>WS_FIELD_NILLABLE_ITEM</b></li> </ul> A nil value is
    ///represented by setting the bytes field to <b>NULL</b> and specifying a length of 0. A nil array is distinquished
    ///from an empty array based on whether or not the bytes field is <b>NULL</b> or not when the length is zero. A
    ///WS_DEFAULT_VALUE may be specified for this type. See the documentation for WS_FIELD_MAPPING to see which field
    ///mapping values allow a default value to be specified.
    WS_BYTES_TYPE            = 0x00000012,
    ///Used when serializing a WS_XML_STRING. The WS_XML_STRING_DESCRIPTION type description can optionally be specified
    ///for this type in order to constrain the allowed values. Embedded zeros are allowed in the array of utf8 bytes.
    ///This type can be used with the following WS_TYPE_MAPPING values: <ul> <li> WS_ELEMENT_TYPE_MAPPING </li> <li>
    ///WS_ATTRIBUTE_TYPE_MAPPING </li> <li> WS_ELEMENT_CONTENT_TYPE_MAPPING </li> </ul> This type can be used with the
    ///following WS_FIELD_MAPPING values: <ul> <li> WS_ELEMENT_FIELD_MAPPING </li> <li>
    ///WS_REPEATING_ELEMENT_FIELD_MAPPING </li> <li> WS_ATTRIBUTE_FIELD_MAPPING </li> <li> WS_TEXT_FIELD_MAPPING </li>
    ///<li> WS_NO_FIELD_MAPPING </li> </ul> This type can be used with the following WS_FIELD_OPTIONS values. See the
    ///documentation for WS_FIELD_MAPPING for which options are supported for a given field mapping value: <ul> <li>0
    ///</li> <li> WS_FIELD_OPTIONAL </li> <li> WS_FIELD_NILLABLE </li> <li> WS_FIELD_NILLABLE |
    ///<b>WS_FIELD_OPTIONAL</b></li> <li> WS_FIELD_NILLABLE_ITEM </li> <li> WS_FIELD_NILLABLE |
    ///<b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_OPTIONAL | <b>WS_FIELD_NILLABLE_ITEM</b></li> <li>
    ///WS_FIELD_NILLABLE | <b>WS_FIELD_OPTIONAL</b> | <b>WS_FIELD_NILLABLE_ITEM</b></li> </ul> A nil value is
    ///represented by setting the bytes field to <b>NULL</b> and specifying a length of 0. A nil string is distinquished
    ///from an empty string based on whether or not the bytes field is <b>NULL</b> or not when the length is zero. A
    ///WS_DEFAULT_VALUE may be specified for this type. See the documentation for WS_FIELD_MAPPING to see which field
    ///mapping values allow a default value to be specified.
    WS_XML_STRING_TYPE       = 0x00000013,
    ///Used when serializing a WS_XML_QNAME. The WS_XML_QNAME_DESCRIPTION type description can optionally be specified
    ///for this type in order to constrain the allowed values. This type can be used with the following WS_TYPE_MAPPING
    ///values: <ul> <li> WS_ELEMENT_TYPE_MAPPING </li> <li> WS_ATTRIBUTE_TYPE_MAPPING </li> <li>
    ///WS_ELEMENT_CONTENT_TYPE_MAPPING </li> </ul> This type can be used with the following WS_FIELD_MAPPING values:
    ///<ul> <li> WS_ELEMENT_FIELD_MAPPING </li> <li> WS_REPEATING_ELEMENT_FIELD_MAPPING </li> <li>
    ///WS_ATTRIBUTE_FIELD_MAPPING </li> <li> WS_TEXT_FIELD_MAPPING </li> <li> WS_NO_FIELD_MAPPING </li> </ul> This type
    ///can be used with the following WS_FIELD_OPTIONS values. See the documentation for WS_FIELD_MAPPING for which
    ///options are supported for a given field mapping value: <ul> <li>0 </li> <li> WS_FIELD_OPTIONAL </li> <li>
    ///WS_FIELD_NILLABLE | <b>WS_FIELD_POINTER</b>. </li> <li> WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE</b> |
    ///<b>WS_FIELD_OPTIONAL</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_POINTER |
    ///<b>WS_FIELD_NILLABLE</b> | <b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_OPTIONAL</b> |
    ///<b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE</b> | <b>WS_FIELD_OPTIONAL</b> |
    ///<b>WS_FIELD_NILLABLE_ITEM</b></li> </ul> A nil value is represented using a <b>NULL</b> pointer. A
    ///WS_DEFAULT_VALUE may be specified for this type. See the documentation for WS_FIELD_MAPPING to see which field
    ///mapping values allow a default value to be specified.
    WS_XML_QNAME_TYPE        = 0x00000014,
    ///Used when serializing an WS_XML_BUFFER*. This type has no associated type description structure. This type can be
    ///used with the following WS_TYPE_MAPPING values: <ul> <li> WS_ELEMENT_TYPE_MAPPING </li> <li>
    ///WS_ANY_ELEMENT_TYPE_MAPPING </li> </ul> This type can be used with the following WS_FIELD_MAPPING values: <ul>
    ///<li> WS_ELEMENT_FIELD_MAPPING </li> <li> WS_REPEATING_ELEMENT_FIELD_MAPPING </li> <li>
    ///WS_ANY_ELEMENT_FIELD_MAPPING </li> <li> WS_REPEATING_ANY_ELEMENT_FIELD_MAPPING </li> <li>
    ///WS_ANY_CONTENT_FIELD_MAPPING </li> <li> WS_NO_FIELD_MAPPING </li> </ul> This type can be used with the following
    ///WS_FIELD_OPTIONS values. See the documentation for WS_FIELD_MAPPING for which options are supported for a given
    ///field mapping value: <ul> <li>0 </li> <li> WS_FIELD_OPTIONAL </li> <li> WS_FIELD_NILLABLE </li> <li>
    ///WS_FIELD_NILLABLE | <b>WS_FIELD_OPTIONAL</b></li> <li> WS_FIELD_NILLABLE_ITEM </li> <li> WS_FIELD_NILLABLE |
    ///<b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_OPTIONAL | <b>WS_FIELD_NILLABLE_ITEM</b></li> <li>
    ///WS_FIELD_NILLABLE | <b>WS_FIELD_OPTIONAL</b> | <b>WS_FIELD_NILLABLE_ITEM</b></li> </ul> A nil value is
    ///represented using a <b>NULL</b> pointer. This type does not support specifying a WS_DEFAULT_VALUE. The
    ///interpretation of the contents of the WS_XML_BUFFER is as follows: <ul> <li> When used at the top level or with
    ///WS_ELEMENT_FIELD_MAPPING, the WS_XML_BUFFER should contain a single element which represents the attribute and
    ///element content. The local name and namespace of the element in the buffer is ignored; it is replaced with actual
    ///element name and namespace when the buffer is written. For example: <pre class="syntax"
    ///xml:space="preserve"><code> // Element in WS_XML_BUFFER &lt;PrefixInBuffer:LocalNameInBuffer
    ///xmlns:PrefixInBuffer="namespace-in-buffer" other-attributes&gt; text-and-or-element-content
    ///&lt;/PrefixInBuffer:LocalNameInBuffer&gt; // Element that is written &lt;NewPrefix:NewLocalName
    ///xmlns:NewPrefix="new-namespace" other-attributes&gt; text-and-or-element-content
    ///&lt;/NewPrefix:NewLocalName&gt;</code></pre> To avoid problems with namespace collisions, it is a best practice
    ///to follow one of the following rules when selecting a namespace for the element in the buffer: <ul> <li>Use a
    ///namespace other than "" that is not otherwise used in the buffer. </li> <li>Use the same namespace as the element
    ///that will be written. </li> </ul> When the value is deserialized, the element name and namespace will correspond
    ///to the element that was read. </li> <li> When used with WS_ANY_ELEMENT_FIELD_MAPPING, the WS_XML_BUFFER should
    ///contain a single element which represents a single element in the XML content. </li> <li> When used with
    ///WS_REPEATING_ELEMENT_FIELD_MAPPING, each of the WS_XML_BUFFERs that are serialized in the array has the same
    ///convention as with <b>WS_ELEMENT_FIELD_MAPPING</b>described above (each WS_XML_BUFFER represents a single element
    ///in the XML content). </li> <li> When used with WS_REPEATING_ANY_ELEMENT_FIELD_MAPPING, each of the WS_XML_BUFFERs
    ///that are serialized in the array represents a single element in the XML content. </li> <li> When used with
    ///WS_ANY_CONTENT_FIELD_MAPPING, the WS_XML_BUFFER may contain zero or more top level elements or text. This content
    ///corresponds to the remaining XML content of the containing structure. </li> </ul>
    WS_XML_BUFFER_TYPE       = 0x00000015,
    ///Used when serializing two fields of a structure as a unit: a <b>WCHAR</b>* field which points to an array of
    ///WCHARs, and a ULONG field which contains the number of characters in the array. This type may only be used within
    ///a WS_FIELD_DESCRIPTION. <pre class="syntax" xml:space="preserve"><code> struct { ULONG count; // array length, in
    ///characters WCHAR* chars; // array of unicode characters } value;</code></pre> The fields can be anywhere in the
    ///contained structure and in any order, since their offsets within the structure are specified separately as part
    ///of the WS_FIELD_DESCRIPTION. The offset of the count field is specified in the countOffset field, and the offset
    ///of the chars field is specified in the offset field. Embedded zeros are allowed in the array of characters. The
    ///WS_CHAR_ARRAY_DESCRIPTION type description can optionally be specified for this type in order to constrain the
    ///allowed values. This type cannot be used with any WS_TYPE_MAPPING values. This type may only be used within a
    ///WS_FIELD_DESCRIPTION. This type can be used with the following WS_FIELD_MAPPING values: <ul> <li>
    ///WS_ELEMENT_FIELD_MAPPING </li> <li> WS_REPEATING_ELEMENT_FIELD_MAPPING </li> <li> WS_ATTRIBUTE_FIELD_MAPPING
    ///</li> <li> WS_TEXT_FIELD_MAPPING </li> <li> WS_XML_ATTRIBUTE_FIELD_MAPPING </li> <li> WS_NO_FIELD_MAPPING </li>
    ///</ul> This type can be used with the following WS_FIELD_OPTIONS values. See the documentation for
    ///WS_FIELD_MAPPING for which options are supported for a given field mapping value: <ul> <li>0 </li> <li>
    ///WS_FIELD_OPTIONAL </li> <li> WS_FIELD_NILLABLE </li> <li> WS_FIELD_NILLABLE | <b>WS_FIELD_OPTIONAL</b></li> <li>
    ///WS_FIELD_NILLABLE_ITEM </li> <li> WS_FIELD_NILLABLE | <b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_OPTIONAL |
    ///<b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_NILLABLE | <b>WS_FIELD_OPTIONAL</b> |
    ///<b>WS_FIELD_NILLABLE_ITEM</b></li> </ul> A nil string is represented by setting the chars field to <b>NULL</b>
    ///and specifying a length of 0. A nil string is distinquished from an empty string based on whether or not the
    ///chars field is <b>NULL</b> or not (in both cases the length is zero). This type does not support specifying a
    ///WS_DEFAULT_VALUE.
    WS_CHAR_ARRAY_TYPE       = 0x00000016,
    ///Used when serializing two fields of a structure as a unit: a BYTE* field which points to an array of UTF8 bytes,
    ///and a ULONG field which contains the number of bytes in the array. This type may only be used within a
    ///WS_FIELD_DESCRIPTION. <pre class="syntax" xml:space="preserve"><code> struct { ULONG count; // array length, in
    ///bytes BYTE* bytes; // array of utf8 characters } value;</code></pre> The fields can be anywhere in the contained
    ///structure and in any order, since their offsets within the structure are specified separately as part of the
    ///WS_FIELD_DESCRIPTION. The offset of the count field is specified in the countOffset field, and the offset of the
    ///bytes field is specified in the offset field. Embedded zeros are allowed in the array of utf8 bytes. The
    ///WS_UTF8_ARRAY_DESCRIPTION type description can optionally be specified for this type in order to constrain the
    ///allowed values. This type cannot be used with any WS_TYPE_MAPPING values. This type may only be used within a
    ///WS_FIELD_DESCRIPTION. This type can be used with the following WS_FIELD_MAPPING values: <ul> <li>
    ///WS_ELEMENT_FIELD_MAPPING </li> <li> WS_ATTRIBUTE_FIELD_MAPPING </li> <li> WS_TEXT_FIELD_MAPPING </li> <li>
    ///WS_NO_FIELD_MAPPING </li> </ul> This type can be used with the following WS_FIELD_OPTIONS values. See the
    ///documentation for WS_FIELD_MAPPING for which options are supported for a given field mapping value: <ul> <li>0
    ///</li> <li> WS_FIELD_OPTIONAL </li> <li> WS_FIELD_NILLABLE </li> <li> WS_FIELD_NILLABLE |
    ///<b>WS_FIELD_OPTIONAL</b></li> </ul> A nil string is represented by setting the bytes field to <b>NULL</b> and
    ///specifying a length of 0. A nil string is distinquished from an empty string based on whether or not the bytes
    ///field is <b>NULL</b> or not (in both cases the length is zero). This type does not support specifying a
    ///WS_DEFAULT_VALUE.
    WS_UTF8_ARRAY_TYPE       = 0x00000017,
    ///Used when serializing two fields of a structure as a unit: a BYTE* field which points to an array bytes, and a
    ///ULONG field which contains the number of bytes in the array. This type may only be used within a
    ///WS_FIELD_DESCRIPTION. <pre class="syntax" xml:space="preserve"><code> struct { ULONG count; // array length, in
    ///bytes BYTE* bytes; // array of bytes } value;</code></pre> The fields can be anywhere in the contained structure
    ///and in any order, since their offsets within the structure are specified separately as part of the
    ///WS_FIELD_DESCRIPTION. The offset of the count field is specified in the countOffset field, and the offset of the
    ///bytes field is specified in the offset field. The WS_BYTE_ARRAY_DESCRIPTION type description can optionally be
    ///specified for this type in order to constrain the allowed values. This type cannot be used with any
    ///WS_TYPE_MAPPING values. This type may only be used within a WS_FIELD_DESCRIPTION. This type can be used with the
    ///following WS_FIELD_MAPPING values: <ul> <li> WS_ELEMENT_FIELD_MAPPING </li> <li> WS_ATTRIBUTE_FIELD_MAPPING </li>
    ///<li> WS_TEXT_FIELD_MAPPING </li> <li> WS_NO_FIELD_MAPPING </li> </ul> This type can be used with the following
    ///WS_FIELD_OPTIONS values. See the documentation for WS_FIELD_MAPPING for which options are supported for a given
    ///field mapping value: <ul> <li>0 </li> <li> WS_FIELD_OPTIONAL </li> <li> WS_FIELD_NILLABLE </li> <li>
    ///WS_FIELD_NILLABLE | <b>WS_FIELD_OPTIONAL</b></li> </ul> A nil array is represented by setting the array pointer
    ///field to <b>NULL</b> and specifying a length of 0. A nil array is distinquished from an empty array based on
    ///whether or not the array pointer field is <b>NULL</b> or not (in both cases the length is zero). This type does
    ///not support specifying a WS_DEFAULT_VALUE.
    WS_BYTE_ARRAY_TYPE       = 0x00000018,
    ///Used to represent the XML type of the structure being serialized. This can be used to identify sub-types using
    ///the xsi:type attribute from XML Schema. The field of the structure must be of type WS_STRUCT_DESCRIPTION*. This
    ///type does not have an associated type description. This type cannot be used with any WS_TYPE_MAPPING values. This
    ///type may only be used within a WS_FIELD_DESCRIPTION. This type does not support specifying a WS_DEFAULT_VALUE.
    ///This type can be used with the following WS_FIELD_MAPPING values: <ul> <li> WS_TYPE_ATTRIBUTE_FIELD_MAPPING </li>
    ///</ul> This type can be used with the following WS_FIELD_OPTIONS values. See the documentation for
    ///WS_FIELD_MAPPING for which options are supported for a given field mapping value: <ul> <li>0 </li> </ul>
    WS_DESCRIPTION_TYPE      = 0x00000019,
    ///Used when serializing a user-defined structure. The associated type description points to a WS_STRUCT_DESCRIPTION
    ///which provides information about how to serialize the fields of the structure. This type requires a
    ///WS_STRUCT_DESCRIPTION type description to be supplied which provides information about how to serialize the type.
    ///This type can be used with the following WS_TYPE_MAPPING values, as long as the fields defined by the structure
    ///follow the stated restrictions: <ul> <li> WS_ELEMENT_TYPE_MAPPING. All field mappings are supported. </li> <li>
    ///WS_ATTRIBUTE_TYPE_MAPPING. Only the following mappings are supported: <ul> <li> WS_TEXT_FIELD_MAPPING </li> <li>
    ///WS_NO_FIELD_MAPPING </li> </ul> </li> <li> WS_ELEMENT_CONTENT_TYPE_MAPPING. Only the following mappings are
    ///supported: <ul> <li> WS_ELEMENT_FIELD_MAPPING </li> <li> WS_REPEATING_ELEMENT_FIELD_MAPPING </li> <li>
    ///WS_TEXT_FIELD_MAPPING </li> <li> WS_NO_FIELD_MAPPING </li> </ul> </li> <li></li> </ul> This type can be used with
    ///the following WS_FIELD_MAPPING values: <ul> <li> WS_ELEMENT_FIELD_MAPPING </li> <li>
    ///WS_REPEATING_ELEMENT_FIELD_MAPPING </li> <li> WS_TEXT_FIELD_MAPPING </li> <li> WS_NO_FIELD_MAPPING </li> </ul>
    ///This type can be used with the following WS_FIELD_OPTIONS values. See the documentation for WS_FIELD_MAPPING for
    ///which options are supported for a given field mapping value: <ul> <li>0 </li> <li> WS_FIELD_POINTER </li> <li>
    ///WS_FIELD_OPTIONAL | <b>WS_FIELD_POINTER</b></li> <li> WS_FIELD_NILLABLE | <b>WS_FIELD_POINTER</b></li> <li>
    ///WS_FIELD_NILLABLE | <b>WS_FIELD_OPTIONAL</b> | <b>WS_FIELD_POINTER</b></li> <li> WS_FIELD_POINTER |
    ///<b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE</b> |
    ///<b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_OPTIONAL</b> |
    ///<b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE</b> | <b>WS_FIELD_OPTIONAL</b> |
    ///<b>WS_FIELD_NILLABLE_ITEM</b></li> </ul> A nil value is represented using a <b>NULL</b> pointer. This type does
    ///not support specifying a WS_DEFAULT_VALUE.
    WS_STRUCT_TYPE           = 0x0000001a,
    ///Used when serializing a custom type. The associated type description points to a WS_CUSTOM_TYPE_DESCRIPTION which
    ///provides information about how to serialize the type. This type requires a WS_CUSTOM_TYPE_DESCRIPTION type
    ///description to be supplied which provides information about how to serialize the type, including a
    ///WS_READ_TYPE_CALLBACK and WS_WRITE_TYPE_CALLBACK which are used to read and write the type. The callbacks are
    ///passed the WS_TYPE_MAPPING and make the determination as to whether the mapping is supported. The support for
    ///each WS_FIELD_MAPPING value is dependent on the WS_TYPE_MAPPING support determined by the callback. The rules are
    ///as follows: <ul> <li>If WS_ELEMENT_TYPE_MAPPING is supported, then the following field mappings are supported:
    ///<ul> <li> WS_ELEMENT_FIELD_MAPPING </li> <li> WS_REPEATING_ELEMENT_FIELD_MAPPING </li> </ul> </li> <li>If
    ///WS_ATTRIBUTE_TYPE_MAPPING is supported, then the following field mappings are supported: <ul> <li>
    ///WS_ATTRIBUTE_FIELD_MAPPING </li> </ul> </li> <li>If WS_ELEMENT_CONTENT_TYPE_MAPPING is supported, then the
    ///following field mappings are supported: <ul> <li> WS_TEXT_FIELD_MAPPING </li> </ul> </li> <li>If
    ///WS_ANY_ELEMENT_TYPE_MAPPING is supported, then the following field mappings are supported: <ul> <li>
    ///WS_ANY_ELEMENT_FIELD_MAPPING </li> </ul> </li> </ul> Regardless of what WS_TYPE_MAPPING values are supported, the
    ///type can always be used with WS_NO_FIELD_MAPPING. This type can be used with the following WS_FIELD_OPTIONS
    ///values. See the documentation for WS_FIELD_MAPPING for which options are supported for a given field mapping
    ///value: <ul> <li>0 </li> <li> WS_FIELD_OPTIONAL </li> <li> WS_FIELD_NILLABLE | <b>WS_FIELD_POINTER</b></li> <li>
    ///WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE</b> |
    ///<b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_OPTIONAL</b> |
    ///<b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE</b> | <b>WS_FIELD_OPTIONAL</b> |
    ///<b>WS_FIELD_NILLABLE_ITEM</b></li> </ul> A nil value is represented using a <b>NULL</b> pointer. A
    ///WS_DEFAULT_VALUE may be specified for this type. See the documentation for WS_FIELD_MAPPING to see which field
    ///mapping values allow a default value to be specified.
    WS_CUSTOM_TYPE           = 0x0000001b,
    ///Used when serializing WS_ENDPOINT_ADDRESS . The associated type description points to a
    ///WS_ENDPOINT_ADDRESS_DESCRIPTION which provides information about how to serialize the endpoint address. This type
    ///requires a WS_ENDPOINT_ADDRESS_DESCRIPTION type description to be supplied which provides information about the
    ///serialization format. This type can be used with the following WS_TYPE_MAPPING values: <ul> <li>
    ///WS_ELEMENT_TYPE_MAPPING </li> </ul> This type can be used with the following WS_FIELD_MAPPING values: <ul> <li>
    ///WS_ELEMENT_FIELD_MAPPING </li> <li> WS_REPEATING_ELEMENT_FIELD_MAPPING </li> <li> WS_NO_FIELD_MAPPING </li> </ul>
    ///This type can be used with the following WS_FIELD_OPTIONS values. See the documentation for WS_FIELD_MAPPING for
    ///which options are supported for a given field mapping value: <ul> <li>0 </li> <li> WS_FIELD_OPTIONAL |
    ///<b>WS_FIELD_POINTER</b></li> <li> WS_FIELD_NILLABLE | <b>WS_FIELD_POINTER</b></li> <li> WS_FIELD_POINTER |
    ///<b>WS_FIELD_NILLABLE</b> | <b>WS_FIELD_OPTIONAL</b></li> <li> WS_FIELD_POINTER |
    ///<b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE</b> |
    ///<b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_OPTIONAL</b> |
    ///<b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE</b> | <b>WS_FIELD_OPTIONAL</b> |
    ///<b>WS_FIELD_NILLABLE_ITEM</b></li> </ul> A nil value is represented using a <b>NULL</b> pointer. This type does
    ///not support specifying a WS_DEFAULT_VALUE.
    WS_ENDPOINT_ADDRESS_TYPE = 0x0000001c,
    ///Used when serializing a WS_FAULT. The associated type description points to a WS_FAULT_DESCRIPTION which provides
    ///information about how to serialize the fault. This type requires a WS_FAULT_DESCRIPTION type description to be
    ///supplied which provides information about the serialization format. This type can be used with the following
    ///WS_TYPE_MAPPING values: <ul> <li> WS_ELEMENT_TYPE_MAPPING </li> </ul> This type can be used with the following
    ///WS_FIELD_MAPPING values: <ul> <li> WS_ELEMENT_FIELD_MAPPING </li> <li> WS_REPEATING_ELEMENT_FIELD_MAPPING </li>
    ///<li> WS_NO_FIELD_MAPPING </li> </ul> This type can be used with the following WS_FIELD_OPTIONS values. See the
    ///documentation for WS_FIELD_MAPPING for which options are supported for a given field mapping value: <ul> <li>0
    ///</li> <li> WS_FIELD_OPTIONAL | <b>WS_FIELD_POINTER</b></li> <li> WS_FIELD_NILLABLE | <b>WS_FIELD_POINTER</b></li>
    ///<li> WS_FIELD_NILLABLE | <b>WS_FIELD_OPTIONAL</b> | <b>WS_FIELD_POINTER</b></li> <li> WS_FIELD_POINTER |
    ///<b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE</b> |
    ///<b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_OPTIONAL</b> |
    ///<b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE</b> | <b>WS_FIELD_OPTIONAL</b> |
    ///<b>WS_FIELD_NILLABLE_ITEM</b></li> </ul> A nil value is represented using a <b>NULL</b> pointer. This type does
    ///not support specifying a WS_DEFAULT_VALUE.
    WS_FAULT_TYPE            = 0x0000001d,
    ///This type is used to specify an arbitrary size field. A WS_VOID_DESCRIPTION can optionally be supplied in order
    ///to specify the size of the type. This type cannot be used with any WS_TYPE_MAPPING values. This type can only be
    ///used within the WS_FIELD_DESCRIPTION of a WS_STRUCT_DESCRIPTION. This type can be used with the following
    ///WS_FIELD_OPTIONS values. See the documentation for WS_FIELD_MAPPING for which options are supported for a given
    ///field mapping value: <ul> <li>0 </li> <li> WS_FIELD_OPTIONAL </li> <li> WS_FIELD_OPTIONAL |
    ///<b>WS_FIELD_POINTER</b></li> <li> WS_FIELD_POINTER </li> </ul> This type can be used with the following
    ///WS_FIELD_MAPPING values: <ul> <li> WS_NO_FIELD_MAPPING. This is used to initialize a field of a structure to a
    ///default value when deserializing. This is used for the case where the particular field does not have a mapping to
    ///the XML content, and the type is not one of the other WS_TYPEs. The value will be initialized as follows: <ul>
    ///<li>If WS_FIELD_POINTER is specified, then the field will be set to <b>NULL</b>. </li> <li>If WS_FIELD_POINTER is
    ///not specified, then the field will be set to the WS_DEFAULT_VALUE if allowed for the type and specified,
    ///otherwise it will be set to all zeros. The size of the field is specified as part of the WS_VOID_DESCRIPTION. If
    ///a <b>WS_VOID_DESCRIPTION</b>is not specified, the field is interpreted as being size 0. </li> </ul> </li> <li>
    ///WS_ANY_ELEMENT_FIELD_MAPPING, <b>WS_REPEATING_ANY_ELEMENT_FIELD_MAPPING</b>, <b>WS_ELEMENT_FIELD_MAPPING</b>,
    ///<b>WS_ATTRIBUTE_FIELD_MAPPING</b>, <b>WS_ANY_CONTENT_FIELD_MAPPING</b> or <b>WS_ANY_ATTRIBUTES_FIELD_MAPPING</b>.
    ///This is used to discard the XML content when deserializing, or ignore the field when serializing. Since the
    ///values are not stored, a field of the structure is not required. The field offset should be zero and the field
    ///size should be zero (which is the default if a WS_VOID_DESCRIPTION is not specified). The WS_FIELD_POINTER option
    ///should not be used. </li> </ul>
    WS_VOID_TYPE             = 0x0000001e,
    ///Used when serializing a signed 32-bit integer which corresponds to an enumerated value. This type requires a
    ///WS_ENUM_DESCRIPTION type description to be supplied which provides information about the enumeration values and
    ///their corresponding serialized form. This type can be used with the following WS_TYPE_MAPPING values: <ul> <li>
    ///WS_ELEMENT_TYPE_MAPPING </li> <li> WS_ATTRIBUTE_TYPE_MAPPING </li> <li> WS_ELEMENT_CONTENT_TYPE_MAPPING </li>
    ///</ul> This type can be used with the following WS_FIELD_MAPPING values: <ul> <li> WS_ELEMENT_FIELD_MAPPING </li>
    ///<li> WS_REPEATING_ELEMENT_FIELD_MAPPING </li> <li> WS_ATTRIBUTE_FIELD_MAPPING </li> <li> WS_TEXT_FIELD_MAPPING
    ///</li> <li> WS_NO_FIELD_MAPPING </li> </ul> This type can be used with the following WS_FIELD_OPTIONS values. See
    ///the documentation for WS_FIELD_MAPPING for which options are supported for a given field mapping value: <ul>
    ///<li>0 </li> <li> WS_FIELD_OPTIONAL </li> <li> WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE</b></li> <li>
    ///WS_FIELD_NILLABLE | <b>WS_FIELD_OPTIONAL</b> | <b>WS_FIELD_POINTER</b></li> <li> WS_FIELD_POINTER |
    ///<b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE</b> |
    ///<b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_OPTIONAL</b> |
    ///<b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE</b> | <b>WS_FIELD_OPTIONAL</b> |
    ///<b>WS_FIELD_NILLABLE_ITEM</b></li> </ul> A nil value is represented using a <b>NULL</b> pointer. A
    ///WS_DEFAULT_VALUE may be specified for this type. See the documentation for WS_FIELD_MAPPING to see which field
    ///mapping values allow a default value to be specified.
    WS_ENUM_TYPE             = 0x0000001f,
    ///Used when serializing a WS_DURATION. The WS_DURATION_DESCRIPTION type description can optionally be specified for
    ///this type in order to constrain the allowed values. This type can be used with the following WS_TYPE_MAPPING
    ///values: <ul> <li> WS_ELEMENT_TYPE_MAPPING </li> <li> WS_ATTRIBUTE_TYPE_MAPPING </li> <li>
    ///WS_ELEMENT_CONTENT_TYPE_MAPPING </li> </ul> This type can be used with the following WS_FIELD_MAPPING values:
    ///<ul> <li> WS_ELEMENT_FIELD_MAPPING </li> <li> WS_REPEATING_ELEMENT_FIELD_MAPPING </li> <li>
    ///WS_ATTRIBUTE_FIELD_MAPPING </li> <li> WS_TEXT_FIELD_MAPPING </li> <li> WS_NO_FIELD_MAPPING </li> </ul> This type
    ///can be used with the following WS_FIELD_OPTIONS values. See the documentation for WS_FIELD_MAPPING for which
    ///options are supported for a given field mapping value: <ul> <li>0 </li> <li> WS_FIELD_OPTIONAL </li> <li>
    ///WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE</b></li> <li> WS_FIELD_NILLABLE | <b>WS_FIELD_OPTIONAL</b> |
    ///<b>WS_FIELD_POINTER</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_POINTER |
    ///<b>WS_FIELD_NILLABLE</b> | <b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_OPTIONAL</b> |
    ///<b>WS_FIELD_NILLABLE_ITEM</b></li> <li> WS_FIELD_POINTER | <b>WS_FIELD_NILLABLE</b> | <b>WS_FIELD_OPTIONAL</b> |
    ///<b>WS_FIELD_NILLABLE_ITEM</b></li> </ul> A nil value is represented using a <b>NULL</b> pointer. A
    ///WS_DEFAULT_VALUE may be specified for this type. See the documentation for WS_FIELD_MAPPING to see which field
    ///mapping values allow a default value to be specified.
    WS_DURATION_TYPE         = 0x00000020,
    ///Used when serializing a set of choices which correspond to a tagged union. <pre class="syntax"
    ///xml:space="preserve"><code> enum EnumType { // values identifying each choice } value; struct StructType { //
    ///value indicating which choice is set currently EnumType selector; union { // values corresponding to each choice
    ///} value; };</code></pre> This type requires a WS_UNION_DESCRIPTION type description to be supplied which provides
    ///information about the choices and their corresponding serialized form. This type can be used with the following
    ///WS_TYPE_MAPPING values: <ul> <li> WS_ELEMENT_TYPE_MAPPING </li> <li> WS_ELEMENT_CONTENT_TYPE_MAPPING </li> </ul>
    ///This type can be used with the following WS_FIELD_MAPPING values: <ul> <li> WS_ELEMENT_CHOICE_FIELD_MAPPING </li>
    ///<li> WS_REPEATING_ELEMENT_CHOICE_FIELD_MAPPING </li> </ul> This type can be used with the following
    ///WS_FIELD_OPTIONS values. See the documentation for WS_FIELD_MAPPING for which options are supported for a given
    ///field mapping value: <ul> <li>0 </li> <li> WS_FIELD_OPTIONAL </li> </ul> This type does not support nil values.
    ///This type does not support specifying a WS_DEFAULT_VALUE. When used with WS_FIELD_OPTIONAL, the default value in
    ///the union is specified using the nonEnumValue of the WS_UNION_DESCRIPTION.
    WS_UNION_TYPE            = 0x00000021,
    ///Used when serializing a set of attributes that are not mapped to fields using WS_ANY_ATTRIBUTES. This type does
    ///not have an associated type description. This type cannot be used with any WS_TYPE_MAPPING values. This type may
    ///only be used within a WS_FIELD_DESCRIPTION. This type can be used with the following WS_FIELD_MAPPING values:
    ///<ul> <li> WS_ANY_ATTRIBUTES_FIELD_MAPPING </li> </ul> This type can be used with the following WS_FIELD_OPTIONS
    ///values. See the documentation for WS_FIELD_MAPPING for which options are supported for a given field mapping
    ///value: <ul> <li>0 </li> </ul> This type does not support nil values. This type does not support specifying a
    ///WS_DEFAULT_VALUE.
    WS_ANY_ATTRIBUTES_TYPE   = 0x00000022,
}

///Specifies how a field of a structure is represented in XML. This is used within a WS_FIELD_DESCRIPTION.
alias WS_FIELD_MAPPING = int;
enum : int
{
    ///The field corresponds to the XML type attribute (xsi:type). This can only be used with WS_DESCRIPTION_TYPE. <pre
    ///class="syntax" xml:space="preserve"><code> struct Base { WS_STRUCT_DESCRIPTION* type; // ... base fields ... };
    ///struct Derived : Base { // ... derived fields ... }; struct Struct { Base* field; }; Derived derived;
    ///derived.type = &amp;DerivedStructDescription; Struct s; s.field = &amp;derived; &lt;Struct&gt; &lt;field
    ///xsi:type='Derived'&gt; // ... base fields ... // ... derived fields ... &lt;/field&gt; &lt;/Struct&gt;
    ///</code></pre> This mapping does not support specifying a WS_DEFAULT_VALUE.
    WS_TYPE_ATTRIBUTE_FIELD_MAPPING           = 0x00000000,
    ///The field corresponds to a single attribute. The field's localName/ns are used as the XML attribute name and
    ///namespace. Unless specified, the attribute must appear in the XML. If WS_FIELD_OPTIONAL is specified, then the
    ///attribute is not required to appear in the XML. If optional and not present, then the field is set to the
    ///WS_DEFAULT_VALUE, or zero if the default value is not specified. <pre class="syntax" xml:space="preserve"><code>
    ///struct Struct { int field; }; Struct s; s.field = 1; &lt;Struct field='1'/&gt; </code></pre> To discard the
    ///attribute, a WS_VOID_TYPE should be used. In this case, a field is not required in the structure. See
    ///<b>WS_VOID_TYPE</b> for more information.
    WS_ATTRIBUTE_FIELD_MAPPING                = 0x00000001,
    ///The field corresponds to a single element. The field's localName/ns are used as the XML element name and
    ///namespace. Unless specified, the element must appear in the XML. If WS_FIELD_OPTIONAL is specified, then the
    ///element is not required to appear in the XML. If optional and not present, then the field is set to the
    ///WS_DEFAULT_VALUE, or zero if the default value is not specified. <pre class="syntax" xml:space="preserve"><code>
    ///struct Struct { int field; }; Struct s; s.field = 1; &lt;Struct&gt; &lt;field&gt;1&lt;/field&gt; &lt;/Struct&gt;
    ///</code></pre> To discard the element, a WS_VOID_TYPE should be used. In this case, a field is not required in the
    ///structure. See <b>WS_VOID_TYPE</b> for more information.
    WS_ELEMENT_FIELD_MAPPING                  = 0x00000002,
    ///The field corresponds to an repeating set of elements. The field's localName/ns are used as the XML element name
    ///and namespace to use for the wrapper element (the element which is the parent of the repeating elements). If no
    ///wrapper element is desired, then both localName/ns should be <b>NULL</b>. If a wrapper element has been
    ///specified, the wrapper element must appear in the XML if repeating element count is not 0. A WS_DEFAULT_VALUE may
    ///not be specified for this field mapping. The itemLocalName and itemNs are used as the XML element name and
    ///namespace for the repeating element. <pre class="syntax" xml:space="preserve"><code> struct Struct { int* field;
    ///ULONG fieldCount; }; int values[] = { 1, 2 }; Struct s; s.field = values; s.fieldCount = 2; // with wrapper
    ///element specified &lt;Struct&gt; &lt;field&gt; &lt;item&gt;1&lt;/item&gt; &lt;item&gt;2&lt;/item&gt;
    ///&lt;/field&gt; &lt;/Struct&gt; // with no wrapper element specified &lt;Struct&gt; &lt;item&gt;1&lt;/item&gt;
    ///&lt;item&gt;2&lt;/item&gt; &lt;/Struct&gt;</code></pre> The number of elements in the deseralized array can be
    ///constrained by specifying a non-<b>NULL</b>WS_ITEM_RANGE structure that is part of the WS_FIELD_DESCRIPTION.
    WS_REPEATING_ELEMENT_FIELD_MAPPING        = 0x00000003,
    ///The field corresponds to the entire character content of the element. When this mapping is used, child elements
    ///are not allowed. This mapping is commonly used in conjunction with WS_ATTRIBUTE_FIELD_MAPPINGto define a
    ///structure which maps to an element containing some text and attributes (but no child elements). <pre
    ///class="syntax" xml:space="preserve"><code> struct Struct { int field; }; Struct s; s.field = 1;
    ///&lt;Struct&gt;1&lt;/Struct&gt; </code></pre> This mapping does not support specifying a WS_DEFAULT_VALUE.
    WS_TEXT_FIELD_MAPPING                     = 0x00000004,
    ///The field is neither serialized or deserialized. The field is ignored when serializing, and is initialized to the
    ///default value when deserializing. If the field maps to one of the existing types (for example WS_INT32_TYPE),
    ///then the type can be specified. If the type of the field is not one of the existing types, then
    ///<b>WS_VOID_TYPE</b> can be used to specify a field of an arbitrary type and size. A WS_DEFAULT_VALUE may be
    ///specified to provide the value to initialize the field to when deserializing the field. If a default value is not
    ///specified, then the field will be initialized to zero. The field mapping can be used with WS_FIELD_OPTIONS value
    ///of 0 only. <pre class="syntax" xml:space="preserve"><code> struct Struct { int field; }; Struct s; s.field = 1;
    ///&lt;Struct/&gt; </code></pre>
    WS_NO_FIELD_MAPPING                       = 0x00000005,
    ///The field corresponds to a reserved xml attribute (such as xml:lang). The field's localName is used to identify
    ///the XML attribute name. Unless WS_FIELD_OPTIONAL is specified, the attribute must appear in the XML. If
    ///<b>WS_FIELD_OPTIONAL</b> is specified, then the attribute is not required to appear in the XML. If optional and
    ///not present, then the field is set to the WS_DEFAULT_VALUE, or zero if the default value is not specified. <pre
    ///class="syntax" xml:space="preserve"><code> struct Struct { WS_STRING field; }; Struct s; s.field = ...; //
    ///'us-en'; // Example of xml:lang &lt;Struct xml:lang='us-en'/&gt; s.field = ...; // 'true' // Example of xml:space
    ///&lt;Struct xml:space='true'&gt;</code></pre>
    WS_XML_ATTRIBUTE_FIELD_MAPPING            = 0x00000006,
    ///The field corresponds to a choice among a set of possible elements. Each element maps to one of the fields of a
    ///union. Each field of the union has a corresponding enum value, which is used to identify the current choice. <pre
    ///class="syntax" xml:space="preserve"><code> // Enumeration of choices of different values enum Choice { ChoiceA =
    ///10, ChoiceB = 20, None = 0, }; // Struct containing union of values, and enum 'selector' struct Struct { Choice
    ///choice; union { int a; // valid when choice is ChoiceA WS_STRING b; // valid when choice is ChoiceB } value; };
    ///</code></pre> This field mapping must be used with WS_UNION_TYPE. The names and namespaces of the element choices
    ///are specified in the WS_UNION_DESCRIPTION. The field's localName and ns should be <b>NULL</b>. Unless
    ///WS_FIELD_OPTIONAL is specified, one of the elements must appear in the XML. If <b>WS_FIELD_OPTIONAL</b> is
    ///specified, then none of the elements are required to appear in the XML. If optional and none of the elements are
    ///present, then the field's selector value is set to the none value of the enumeration (as specified in the
    ///noneEnumValue field of the WS_UNION_DESCRIPTION). Due to the fact that the nonEnumValue is used as the default
    ///value, this mapping value does not support specifying a WS_DEFAULT_VALUE. <pre class="syntax"
    ///xml:space="preserve"><code> Struct s; s.choice = ChoiceA; s.value.a = 123; &lt;Struct&gt;
    ///&lt;choiceA&gt;123&lt;/choiceA&gt; &lt;/Struct&gt; Struct S; s.choice = ChoiceB; s.value.b = ...; // 'hello'
    ///&lt;Struct&gt; &lt;choiceB&gt;hello&lt;/choiceB&gt; &lt;/Struct&gt; Struct S; s.choice = None; &lt;Struct&gt;
    ///&lt;/Struct&gt; </code></pre> The field corresponds to a choice among a set of possible elements. Each element
    ///maps to one of the fields of a union. Each field of the union has a corresponding enum value, which is used to
    ///identify the current choice. <pre class="syntax" xml:space="preserve"><code> // Enumeration of choices of
    ///different values enum Choice { ChoiceA = 10, ChoiceB = 20, None = 0, }; // Struct containing union of values, and
    ///enum &amp;quot;selector&amp;quot; struct Struct { Choice choice; union { int a; // valid when choice is ChoiceA
    ///WS_STRING b; // valid when choice is ChoiceB } value; };</code></pre> This field mapping must be used with
    ///WS_UNION_TYPE. The names and namespaces of the element choices are specified in the WS_UNION_DESCRIPTION. The
    ///field's localName and ns should be <b>NULL</b>. Unless WS_FIELD_OPTIONAL is specified, one of the elements must
    ///appear in the XML. If <b>WS_FIELD_OPTIONAL</b> is specified, then none of the elements are required to appear in
    ///the XML. If optional and none of the elements are present, then the field's selector value is set to the none
    ///value of the enumeration (as specified in the noneEnumValue field of the WS_UNION_DESCRIPTION). Due to the fact
    ///that the nonEnumValue is used as the default value, this mapping value does not support specifying a
    ///WS_DEFAULT_VALUE. <pre class="syntax" xml:space="preserve"><code> Struct s; s.choice = ChoiceA; s.value.a = 123;
    ///&lt;Struct&gt; &lt;choiceA&gt;123&lt;/choiceA&gt; &lt;/Struct&gt; Struct S; s.choice = ChoiceB; s.value.b = ...;
    ///// &amp;quot;hello&amp;quot; &lt;Struct&gt; &lt;choiceB&gt;hello&lt;/choiceB&gt; &lt;/Struct&gt; Struct S;
    ///s.choice = None; &lt;Struct&gt; &lt;/Struct&gt;</code></pre> The selector value indicates which of the fields of
    ///the union are set. Other fields are left uninitialized when the value is deserialized. An application should
    ///always consult the selector value to verify that a field of the union is accessible.
    WS_ELEMENT_CHOICE_FIELD_MAPPING           = 0x00000007,
    ///The field corresponds to an repeating set of element choices. Each item is represented by a union with selector
    ///value. This mapping must be used with WS_UNION_TYPE. The field's localName/ns are used as the XML element name
    ///and namespace to use for the wrapper element (the element which is the parent of the repeating elements). If no
    ///wrapper element is desired, then both localName/ns should be <b>NULL</b>. If a wrapper element has been
    ///specified, the wrapper element must appear in the XML if repeating element count is not 0. A WS_DEFAULT_VALUE may
    ///not be specified for this field mapping. The itemLocalName and itemNs fields must be <b>NULL</b>. The XML element
    ///name and namespace are defined in the WS_UNION_DESCRIPTION. <pre class="syntax" xml:space="preserve"><code>
    ///struct Struct2 { Struct* field; // see WS_UNION_DESCRIPTION for definition of Struct ULONG fieldCount; };
    ///StructType values[2]; values[0].choice = ChoiceA; values[0].values.a = 123; values[1].choice = ChoiceB;
    ///values[1].values.b = ...; // hello Struct2 s2; s2.field = values; s2.fieldCount = 2; // with wrapper element
    ///specified &lt;Struct2&gt; &lt;field&gt; &lt;item&gt;123&lt;/item&gt; &lt;item&gt;hello&lt;/item&gt;
    ///&lt;/field&gt; &lt;/Struct2&gt; // with no wrapper element specified &lt;Struct2&gt; &lt;item&gt;123&lt;/item&gt;
    ///&lt;item&gt;hello&lt;/item&gt; &lt;/Struct2&gt; </code></pre> The number of elements in the deseralized array can
    ///be constrained by specifying a non-<b>NULL</b>WS_ITEM_RANGE structure that is part of the WS_FIELD_DESCRIPTION.
    WS_REPEATING_ELEMENT_CHOICE_FIELD_MAPPING = 0x00000008,
    WS_ANY_ELEMENT_FIELD_MAPPING              = 0x00000009,
    ///The field is used to discard or store a sequence of elements with any name and namespace. To store the elements,
    ///a WS_XML_BUFFER_TYPE should be used. This corresponds to an array of WS_XML_BUFFERs, as follows: <pre
    ///class="syntax" xml:space="preserve"><code> struct Struct { // ... known fields ... WS_XML_BUFFER** fields; ULONG
    ///fieldCount; // ... known fields ... }; Struct s; s.fields = ...; // { '&lt;unknown1/&gt;', '&lt;unknown2/&gt;'; }
    ///s.fieldCount = 2; &lt;Struct&gt; ... known fields ... &lt;unknown1/&gt; &lt;unknown2/&gt; ... known fields ...
    ///&lt;/Struct&gt; </code></pre> To discard the elements, a WS_VOID_TYPE should be used. In this case, a field is
    ///not required in the structure. See <b>WS_VOID_TYPE</b> for more information. The number of elements allowed
    ///during deserialization can be constrained by specifying a non-<b>NULL</b>WS_ITEM_RANGE structure that is part of
    ///the WS_FIELD_DESCRIPTION. This mapping does not support specifying a WS_DEFAULT_VALUE.
    WS_REPEATING_ANY_ELEMENT_FIELD_MAPPING    = 0x0000000a,
    ///The field is used to discard or store any remaining content (any mixture of text or elements) that occurs before
    ///the end of an element. To store the elements, a WS_XML_BUFFER_TYPE should be used, as follows: <pre
    ///class="syntax" xml:space="preserve"><code> struct Struct { // ... known fields ... WS_XML_BUFFER* field; };
    ///Struct s; s.field = ...; // 'text1&lt;unknown1/&gt;text2&lt;unknown2/&gt;' &lt;Struct&gt; ... known fields ...
    ///text1 &lt;unknown1/&gt; text2 &lt;unknown2/&gt; &lt;/Struct&gt; </code></pre> To discard the elements, a
    ///WS_VOID_TYPE should be used. In this case, a field is not required in the structure. See <b>WS_VOID_TYPE</b> for
    ///more information. This mapping does not support specifying a WS_DEFAULT_VALUE.
    WS_ANY_CONTENT_FIELD_MAPPING              = 0x0000000b,
    ///The field is used to discard or store any attributes which were not mapped using other WS_FIELD_MAPPING values.
    ///If this field mapping is not specified, then unmapped attributes will cause an error when deserializing. The name
    ///field of the WS_FIELD_DESCRIPTION must be <b>NULL</b>. The ns field of the WS_FIELD_DESCRIPTION restricts the
    ///namespace of the attributes allowed as follows: <ul> <li>If the ns field is <b>NULL</b>, then there is no
    ///restriction. The WS_FIELD_OTHER_NAMESPACE field option must be not set in this case. </li> <li>If the ns field is
    ///non-<b>NULL</b>, and the field option WS_FIELD_OTHER_NAMESPACE is not set for the field, then the attribute must
    ///have the same namespace as was specified in the ns field. </li> <li>If the ns field is non-<b>NULL</b>, and the
    ///field option WS_FIELD_OTHER_NAMESPACE is set for the field, then the attribute must have a different namespace
    ///than was specified in the ns field. </li> </ul> To store the attributes, WS_ANY_ATTRIBUTES_TYPE should be used.
    ///This correspond to WS_ANY_ATTRIBUTES as follows: <pre class="syntax" xml:space="preserve"><code> struct Struct {
    ///// ... known attributes ... WS_ANY_ATTRIBUTES field; // ... other content ... }; Struct s; s.field = ...; //
    ///'unknown'/'http://example.com'/'value' &lt;Struct ... known attributes ... xmlns:a='http://example.com'
    ///a:unknown='value'&gt; ... other content ... &lt;/Struct&gt; </code></pre> To discard the unmapped attributes, a
    ///WS_VOID_TYPE should be used. In this case, a field is not required in the structure. See <b>WS_VOID_TYPE</b> for
    ///more information. This mapping does not support specifying a WS_DEFAULT_VALUE.
    WS_ANY_ATTRIBUTES_FIELD_MAPPING           = 0x0000000c,
}

///How a WS_TYPE maps to or from XML when serialized or deserialized.
alias WS_TYPE_MAPPING = int;
enum : int
{
    ///This is used when reading or writing an element where the type corresponds to the type of the element. The
    ///definition of the type may include mappings to attributes, text, or child elements of the element. The following
    ///calling sequence is used when writing an element: <pre class="syntax" xml:space="preserve"><code>
    ///WsWriteStartElement(...) WsWriteType(..., WS_ELEMENT_TYPE_MAPPING, ...) WsWriteEndElement(...)</code></pre> The
    ///following calling sequence is used when reading an element: <pre class="syntax" xml:space="preserve"><code>
    ///WsReadToStartElement(...)? WsReadType(..., WS_ELEMENT_TYPE_MAPPING, ...)</code></pre>
    WS_ELEMENT_TYPE_MAPPING         = 0x00000001,
    ///This is used when reading or writing the value of a single attribute. The definition of the type must not require
    ///any mappings to attributes or child elements. The following calling sequence is used when writing an attribute
    ///value. <pre class="syntax" xml:space="preserve"><code> WsWriteStartAttribute(...) WsWriteType(...,
    ///WS_ATTRIBUTE_TYPE_MAPPING, ...) WsWriteEndAttribute(...)</code></pre> The following calling sequence is used when
    ///reading an attribute value. <pre class="syntax" xml:space="preserve"><code> WsFindAttribute(...)
    ///WsReadStartAttribute(...) WsReadType(..., WS_ATTRIBUTE_TYPE_MAPPING, ...) WsReadEndAttribute(...)</code></pre>
    WS_ATTRIBUTE_TYPE_MAPPING       = 0x00000002,
    ///This is used when when the type corresponds to all or part of the content (text and child elements) of an
    ///element. The definition of the type may include mappings to text or child elements, but must not include any
    ///attributes. The following calling sequence is used when writing the contents of an element: <pre class="syntax"
    ///xml:space="preserve"><code> WsWriteStartElement(...) // Write attributes, if any // Write other element content,
    ///if any WsWriteType(..., WS_ELEMENT_CONTENT_TYPE_MAPPING, ...) // Write other element content, if any
    ///WsWriteEndElement(...)</code></pre> The following calling sequence is used when reading the contents of an
    ///element: <pre class="syntax" xml:space="preserve"><code> WsReadToStartElement(...) // Read attributes, if any
    ///WsReadStartElement(...) // Read other element content, if any WsReadType(..., WS_ELEMENT_CONTENT_TYPE_MAPPING,
    ///...) // Read other element content, if any WsReadEndElement(...)</code></pre>
    WS_ELEMENT_CONTENT_TYPE_MAPPING = 0x00000003,
    ///This is used when when the type corresponds to the complete element, including the name and namespace of the
    ///element. The definition may include attributes and child elements and text. The following calling sequence is
    ///used when writing an element: <pre class="syntax" xml:space="preserve"><code> WsWriteType(...,
    ///WS_ANY_ELEMENT_TYPE_MAPPING, ...)</code></pre> The following calling sequence is used when reading the contents
    ///of an element: <pre class="syntax" xml:space="preserve"><code> WsReadToStartElement(...)? WsReadType(...,
    ///WS_ANY_ELEMENT_TYPE_MAPPING, ...)</code></pre>
    WS_ANY_ELEMENT_TYPE_MAPPING     = 0x00000004,
}

///Specifies whether a value is required, and how the value should be allocated.
alias WS_READ_OPTION = int;
enum : int
{
    ///The option specifies that the value must exist in the XML content. The caller must specify the storage to read
    ///the top-level type into. The size of the storage specified by the caller varies by the type being deserialized,
    ///as follows: <ul> <li>For primitives (such as WS_INT32_TYPE), the storage should be the size of the primitive. In
    ///this case, the heap does not need to be specified. </li> <li>For structures (whether user defined ones that use
    ///WS_STRUCT_TYPE, or predefined ones like WS_STRING), the storage should be the exact size of the structure. Note
    ///that fields of the structure that point to other data is still required to be allocated from the WS_HEAP. If no
    ///fields exist for the specific structure, then the heap does not need to be specified. </li> </ul> Pointer types
    ///(WS_WSZ_TYPE and <b>WS_XML_BUFFER_TYPE</b>), may not be used with WS_READ_REQUIRED_VALUE. The
    ///<b>WS_READ_REQUIRED_POINTER</b> value should be used instead. If the value is not present in the XML being read,
    ///a <b>WS_E_INVALID_FORMAT</b> error will be returned. (See Windows Web Services Return Values.)
    WS_READ_REQUIRED_VALUE   = 0x00000001,
    ///The option specifies that the value must exist in the XML content. The deserialized value is always allocated on
    ///the WS_HEAP, regardless of it's size. The pointer to the deserialized value is returned. When using this option,
    ///the caller should pass the address of a pointer, and size of a pointer, regardless of the type being
    ///deserialized. If the value is not present, then an error will be returned. <b>NULL</b> will never be returned
    ///when this option is used. If the value is optional, use WS_READ_OPTIONAL_POINTER.
    WS_READ_REQUIRED_POINTER = 0x00000002,
    ///The option specifies that the value need not exist in the XML content. The deserialized value is always allocated
    ///on the WS_HEAP, regardless of it's size. The pointer to the deserialized value is returned. When using this
    ///option, the caller should pass the address of a pointer, and size of a pointer, regardless of the type being
    ///deserialized. If the value is not present in the XML being read, the function will succeed and <b>NULL</b> will
    ///be returned for the value. An application that uses this option should be careful to check for <b>NULL</b> before
    ///accessing the value. If a <b>NULL</b> value is never expected, use WS_READ_REQUIRED_POINTER.
    WS_READ_OPTIONAL_POINTER = 0x00000003,
    ///The option specifies that the value may be nil or missing in the XML content. The deserialized value is always
    ///allocated on the WS_HEAP, regardless of it's size. The pointer to the deserialized value is returned. When using
    ///this option, the caller should pass the address of a pointer, and size of a pointer, regardless of the type being
    ///deserialized. If the element is nil or missing in the XML being read, the function will succeed and a <b>NULL</b>
    ///pointer will be returned. If the element is not nil in the XML being read, then the value is returned normally.
    ///An application that uses this option should be careful to check for <b>NULL</b> before accessing the value. If a
    ///<b>NULL</b> value is never expected, use WS_READ_REQUIRED_POINTER. This option is not supported in combination
    ///with WS_TYPE_MAPPING in APIs that read XML, inlcuding WsReadType and WsReadElement calls.
    WS_READ_NILLABLE_POINTER = 0x00000004,
    ///The option specifies that the value may be nil or missing in the XML content. The caller must specify the storage
    ///to read the top-level type into. If the XML element is nil or missing, then a nil value is returned. If the XML
    ///element is non-nil, then the value is deserialized normally. This option is not supported in combination with
    ///WS_TYPE_MAPPING in APIs that read XML, inlcuding WsReadType and WsReadElement calls. This option is only
    ///supported for the following types, listed below, which have a intrinsic way to represent a nil value. See the
    ///documentation for each type for information on how nil is represented. <ul> <li> WS_STRING_TYPE </li> <li>
    ///WS_XML_STRING_TYPE </li> <li> WS_BYTES_TYPE </li> </ul>
    WS_READ_NILLABLE_VALUE   = 0x00000005,
}

///Specifies whether a storage specified contains the value, or a pointer to the value, and whether the value can be
///represented as nil in the XML content.
alias WS_WRITE_OPTION = int;
enum : int
{
    ///The storage specified contains the value. The size of the storage specified should be the size of the value. This
    ///option specifies that the value will always be written to the XML content. <pre class="syntax"
    ///xml:space="preserve"><code>int value; Api(..., &amp;value, sizeof(value), ...);</code></pre> <pre class="syntax"
    ///xml:space="preserve"><code>// always written &lt;element&gt;123&lt;/element&gt;</code></pre> This option is not
    ///supported for pointer types (WS_WSZ_TYPE and <b>WS_XML_BUFFER_TYPE</b>). The WS_WRITE_REQUIRED_POINTER option
    ///should be used for these types.
    WS_WRITE_REQUIRED_VALUE   = 0x00000001,
    ///The storage specified contains a pointer to the value. The size of the storage specified is always the size of a
    ///pointer, regardless of the type being serialized. This option specifies that the value will always be written to
    ///the XML content. <pre class="syntax" xml:space="preserve"><code>int* valuePointer; // may not be NULL Api(...,
    ///&amp;valuePointer, sizeof(valuePointer), ...);</code></pre> <pre class="syntax" xml:space="preserve"><code>//
    ///always written &lt;element&gt;123&lt;/element&gt;</code></pre> If the pointer to the value specified in the
    ///storage is <b>NULL</b>, <b>E_INVALIDARG</b> is returned. (See Windows Web Services Return Values.)
    WS_WRITE_REQUIRED_POINTER = 0x00000002,
    ///The storage specified contains a pointer to the value. The size of the storage specified is always the size of a
    ///pointer, regardless of the type being serialized. If the value is nil, then a nil element is written in the XML
    ///content. If non-nil, then the value is serialized normally. <pre class="syntax"
    ///xml:space="preserve"><code>WS_STRING value; // may contain a nil value (see WS_STRING_TYPE) Api(..., &amp;value,
    ///sizeof(value), ...);</code></pre> <pre class="syntax" xml:space="preserve"><code>// if value is non-nil
    ///&lt;element&gt;hello&lt;/element&gt; // if value is nil &lt;element xsi:nil='true'/&gt;</code></pre> This option
    ///is only supported for the following types, listed below, which have a intrinsic way to represent a nil value. See
    ///the documentation for each type for information on how nil is represented. <ul> <li> WS_STRING_TYPE </li> <li>
    ///WS_XML_STRING_TYPE </li> <li> WS_BYTES_TYPE </li> </ul>
    WS_WRITE_NILLABLE_VALUE   = 0x00000003,
    WS_WRITE_NILLABLE_POINTER = 0x00000004,
}

///The reasons for a cancellation.
alias WS_SERVICE_CANCEL_REASON = int;
enum : int
{
    ///A service host is going through an abort.
    WS_SERVICE_HOST_ABORT      = 0x00000000,
    WS_SERVICE_CHANNEL_FAULTED = 0x00000001,
}

///An enumeration of the different operation styles.
alias WS_OPERATION_STYLE = int;
enum : int
{
    ///document/literal style operation or encoding operations.
    WS_NON_RPC_LITERAL_OPERATION = 0x00000000,
    WS_RPC_LITERAL_OPERATION     = 0x00000001,
}

///The different parameter types.
alias WS_PARAMETER_TYPE = int;
enum : int
{
    ///Not an array type.
    WS_PARAMETER_TYPE_NORMAL      = 0x00000000,
    ///An array type.
    WS_PARAMETER_TYPE_ARRAY       = 0x00000001,
    ///The array count.
    WS_PARAMETER_TYPE_ARRAY_COUNT = 0x00000002,
    WS_PARAMETER_TYPE_MESSAGES    = 0x00000003,
}

///Each property represents optional parameters for configuring the given WS_SERVICE_ENDPOINT structure. This
///enumeration is used within the WS_SERVICE_ENDPOINT_PROPERTY structure that is part of <b>WS_SERVICE_ENDPOINT</b>.
alias WS_SERVICE_ENDPOINT_PROPERTY_ID = int;
enum : int
{
    ///Used with WS_SERVICE_ENDPOINT. The value is a pointer to WS_SERVICE_PROPERTY_ACCEPT_CALLBACK structure.
    WS_SERVICE_ENDPOINT_PROPERTY_ACCEPT_CHANNEL_CALLBACK      = 0x00000000,
    ///Used with WS_SERVICE_ENDPOINT. The value is a pointer to WS_SERVICE_PROPERTY_CLOSE_CALLBACK structure.
    WS_SERVICE_ENDPOINT_PROPERTY_CLOSE_CHANNEL_CALLBACK       = 0x00000001,
    ///Used with WS_SERVICE_ENDPOINT, this specifies the maximum number of concurrent channels service host will have
    ///actively accepting new connections for a given endpoint. When not specified this value is set to 1. If an
    ///endpoint specifies a default message handler (See <b>WS_SERVICE_ENDPOINT</b>) concurrency has to be 1.
    WS_SERVICE_ENDPOINT_PROPERTY_MAX_ACCEPTING_CHANNELS       = 0x00000002,
    ///Used with WS_SERVICE_ENDPOINT, this specifies the maximum number of concurrent calls that would be serviced on a
    ///session based channel. When not specified this value is set to 1. If an endpoint specifies a default message
    ///handler (See <b>WS_SERVICE_ENDPOINT</b> concurrency has to be 1.
    WS_SERVICE_ENDPOINT_PROPERTY_MAX_CONCURRENCY              = 0x00000003,
    ///Maximum heap size for body deserialization. This is the heap available setting used for deserializing the body.
    ///This heap is also available to service operations for allocating out parameters. Default is 65535 bytes.
    WS_SERVICE_ENDPOINT_PROPERTY_BODY_HEAP_MAX_SIZE           = 0x00000004,
    ///Heap trim size for body deserialization. This is the heap available setting used for deserializing the body. This
    ///heap is also available to service operations for allocating out parameters. Default is 4096 bytes.
    WS_SERVICE_ENDPOINT_PROPERTY_BODY_HEAP_TRIM_SIZE          = 0x00000005,
    ///This property allows the user to specify properties of the message objects used by the endpoint to send and
    ///receive messages. This property may be specified when the service host is created. The value specified should be
    ///of type WS_MESSAGE_PROPERTIES. The following message properties may be specified: <ul> <li>
    ///WS_MESSAGE_PROPERTY_HEAP_PROPERTIES </li> <li> WS_MESSAGE_PROPERTY_XML_READER_PROPERTIES </li> <li>
    ///WS_MESSAGE_PROPERTY_XML_WRITER_PROPERTIES </li> <li> WS_MESSAGE_PROPERTY_MAX_PROCESSED_HEADERS </li> </ul>
    WS_SERVICE_ENDPOINT_PROPERTY_MESSAGE_PROPERTIES           = 0x00000006,
    ///The maximum number of call servicing objects that would be pooled to service a message object, on a given
    ///endpoint. Note that in case of session based channels many call objects can be used on a single channel if
    ///WS_SERVICE_ENDPOINT_PROPERTY_MAX_CONCURRENCY is greater than 1. For sessionless channels this property should
    ///ideally be equal to WS_SERVICE_ENDPOINT_PROPERTY_MAX_CHANNEL_POOL_SIZE. Default is 100.
    WS_SERVICE_ENDPOINT_PROPERTY_MAX_CALL_POOL_SIZE           = 0x00000007,
    ///The maximum number of WS_CHANNEL which will be pooled by Service Host on a given endpoint. Default is 100.
    WS_SERVICE_ENDPOINT_PROPERTY_MAX_CHANNEL_POOL_SIZE        = 0x00000008,
    ///Listener properties.
    WS_SERVICE_ENDPOINT_PROPERTY_LISTENER_PROPERTIES          = 0x00000009,
    ///Enables or disables must understand header verification on an endpoint. This is 'TRUE' by default.
    WS_SERVICE_ENDPOINT_PROPERTY_CHECK_MUST_UNDERSTAND        = 0x0000000a,
    ///This property can be set to WS_METADATA_EXCHANGE_TYPE_MEX to enable servicing of WS-MetadataExchange requests on
    ///the endpoint. In case the application wishes to expose metadata through HTTP GET, this property can be set to
    ///<b>WS_METADATA_EXCHANGE_TYPE_HTTP_GET</b> If not specified, the default value of this property is
    ///'WS_METADATA_EXCHANGE_TYPE_NONE'. Note that this property when set to WS_METADATA_EXCHANGE_TYPE_HTTP_GET changes
    ///the WS_LISTENER property WS_LISTENER_PROPERTY_TRANSPORT_URL_MATCHING_OPTIONS and
    ///<b>WS_LISTENER_PROPERTY_TO_HEADER_MATCHING_OPTIONS</b> to WS_MATCH_URL_PREFIX_PATH. When setting this property to
    ///WS_METADATA_EXCHANGE_TYPE_HTTP_GET an application must not specify WS_MATCH_URL_EXACT_PATH for the listener
    ///properties WS_LISTENER_PROPERTY_TRANSPORT_URL_MATCHING_OPTIONS and
    ///<b>WS_LISTENER_PROPERTY_TO_HEADER_MATCHING_OPTIONS</b>for the given WS_SERVICE_ENDPOINT.
    WS_SERVICE_ENDPOINT_PROPERTY_METADATA_EXCHANGE_TYPE       = 0x0000000b,
    ///Specifies the WSDL port name, binding name and binding namespace for the endpoint. This property must be
    ///specified to enable the participation of the WS_SERVICE_ENDPOINT in WS-Metadata Exchange. See
    ///WS_SERVICE_ENDPOINT_METADATA for more details.
    WS_SERVICE_ENDPOINT_PROPERTY_METADATA                     = 0x0000000c,
    ///Specifies the suffix which is concatenated as is to the WS_SERVICE_ENDPOINT URL to generate a URL for
    ///WS-MetadataExchange v1.1 requests servicing. The generated URL is used to compare against the 'to' header of the
    ///message received. Note that if the message does not contain a 'to' header the requests is not serviced. This
    ///property must only be specified if WS_SERVICE_ENDPOINT_PROPERTY_METADATA_EXCHANGE_TYPE is set to
    ///WS_METADATA_EXCHANGE_TYPE_MEX. Specifying this property is useful in cases where an application wishes to handle
    ///WS-Transfer Get requests as well as use the same endpoint to service WS-MetadataExchange v1.1 requests. The
    ///generate URL in this case is used to filter out WS-Transfer Get requests for Ws-MetadataExchange v1.1. By default
    ///no filtering is done for WS-MetadataExchange v1.1 for MEX and all WS-Transfer GET requests will be handled by the
    ///endpoint for Ws-MetadataExchange v1.1, if Ws-MetadataExchange v1.1 is enabled on the endpoint. Note that this
    ///property changes the WS_LISTENER property WS_LISTENER_PROPERTY_TRANSPORT_URL_MATCHING_OPTIONS and
    ///<b>WS_LISTENER_PROPERTY_TO_HEADER_MATCHING_OPTIONS</b> to WS_MATCH_URL_PREFIX_PATH. When setting this property an
    ///application must not specify WS_MATCH_URL_EXACT_PATH for the listener properties
    ///WS_LISTENER_PROPERTY_TRANSPORT_URL_MATCHING_OPTIONS and <b>WS_LISTENER_PROPERTY_TO_HEADER_MATCHING_OPTIONS</b>
    ///for the given WS_SERVICE_ENDPOINT.
    WS_SERVICE_ENDPOINT_PROPERTY_METADATA_EXCHANGE_URL_SUFFIX = 0x0000000d,
    WS_SERVICE_ENDPOINT_PROPERTY_MAX_CHANNELS                 = 0x0000000e,
}

///Information about enabling and disabling types of metadata exchange.
alias WS_METADATA_EXCHANGE_TYPE = int;
enum : int
{
    ///Disables WS-MetadataExchange/HTTP GET servicing on the endpoint. This is the default value of
    ///WS_SERVICE_ENDPOINT_PROPERTY_METADATA_EXCHANGE_TYPE property.
    WS_METADATA_EXCHANGE_TYPE_NONE     = 0x00000000,
    ///Enables servicing of WS-MetadataExchange 1.1 request servicing on the endpoint.
    WS_METADATA_EXCHANGE_TYPE_MEX      = 0x00000001,
    WS_METADATA_EXCHANGE_TYPE_HTTP_GET = 0x00000002,
}

///The optional parameters for configuring the service host. This enumeration is used within the WS_SERVICE_PROPERTY
///structure when calling WsCreateServiceHost or by itself when calling WsGetServiceHostProperty.
alias WS_SERVICE_PROPERTY_ID = int;
enum : int
{
    ///A void pointer used with WsCreateServiceHost. This property is made available to different callbacks and service
    ///operations as part of the WS_OPERATION_CONTEXT structure
    WS_SERVICE_PROPERTY_HOST_USER_STATE  = 0x00000000,
    ///A WS_FAULT_DISCLOSURE value used with WsCreateServiceHost. This property is used to specify the disclosure level
    ///of the error object when its converted into a fault. The default is <b>WS_MINIMAL_FAULT_DISCLOSURE</b>.
    WS_SERVICE_PROPERTY_FAULT_DISCLOSURE = 0x00000001,
    ///A LANGID used with WsGetServiceHostProperty to create a fault. If none is specified, the default user locale will
    ///be used.
    WS_SERVICE_PROPERTY_FAULT_LANGID     = 0x00000002,
    ///A WS_SERVICE_HOST_STATE value used with WsGetServiceHostProperty that specifies the current state of the service
    ///host. The returned value is a snapshot of the current state, so it is possible that the state may have changed
    ///before the caller has had a chance to examine the value.
    WS_SERVICE_PROPERTY_HOST_STATE       = 0x00000003,
    ///A WS_SERVICE_METADATA structure used with WsCreateServiceHost that contains the collection of metadata documents
    ///used for WS-MetadataExchange by the WS_SERVICE_HOST. The service name and namespace are used to create a service
    ///element inside the WSDL document. The document is identified by means of the service namespace provided as part
    ///of WS_SERVICE_METADATA structure. Note that if a service section is already defined in any of the provided WSDL
    ///documents, a service element will not be added on behalf of the application by the runtime.
    WS_SERVICE_PROPERTY_METADATA         = 0x00000004,
    WS_SERVICE_PROPERTY_CLOSE_TIMEOUT    = 0x00000005,
}

///The states that a service host can be in.
alias WS_SERVICE_HOST_STATE = int;
enum : int
{
    WS_SERVICE_HOST_STATE_CREATED = 0x00000000,
    WS_SERVICE_HOST_STATE_OPENING = 0x00000001,
    WS_SERVICE_HOST_STATE_OPEN    = 0x00000002,
    WS_SERVICE_HOST_STATE_CLOSING = 0x00000003,
    WS_SERVICE_HOST_STATE_CLOSED  = 0x00000004,
    WS_SERVICE_HOST_STATE_FAULTED = 0x00000005,
}

///The state of the service proxy.
alias WS_SERVICE_PROXY_STATE = int;
enum : int
{
    WS_SERVICE_PROXY_STATE_CREATED = 0x00000000,
    WS_SERVICE_PROXY_STATE_OPENING = 0x00000001,
    WS_SERVICE_PROXY_STATE_OPEN    = 0x00000002,
    WS_SERVICE_PROXY_STATE_CLOSING = 0x00000003,
    WS_SERVICE_PROXY_STATE_CLOSED  = 0x00000004,
    WS_SERVICE_PROXY_STATE_FAULTED = 0x00000005,
}

///Optional parameters for configuring the service proxy. With an exception of <b>WS_PROXY_PROPERTY_STATE</b> all the
///values are only supported for use with WsCreateServiceProxy as part of the WS_PROXY_PROPERTY* parameter.
alias WS_PROXY_PROPERTY_ID = int;
enum : int
{
    ///The maximum amount of time in milliseconds for a call to remain pending. Default is 30000 milliseconds(30
    ///seconds). It is of type <b>ULONG</b>. If an application wishes to have no timeout associated with a call, it can
    ///set the value to INFINITE. This property is write only.
    WS_PROXY_PROPERTY_CALL_TIMEOUT       = 0x00000000,
    ///This property allows the user to specify properties of the message objects used by the service proxy to send and
    ///receive messages. This property may be specified when the service proxy is created. The value specified should be
    ///of type WS_MESSAGE_PROPERTIES. The following message properties may be specified: <ul> <li>
    ///WS_MESSAGE_PROPERTY_HEAP_PROPERTIES </li> <li> WS_MESSAGE_PROPERTY_XML_READER_PROPERTIES </li> <li>
    ///WS_MESSAGE_PROPERTY_XML_WRITER_PROPERTIES </li> <li> WS_MESSAGE_PROPERTY_MAX_PROCESSED_HEADERS </li> </ul>
    WS_PROXY_PROPERTY_MESSAGE_PROPERTIES = 0x00000001,
    ///Each call in the service proxy is represented by an object internal to the service proxy. A call object is
    ///designed such that after every call it can be reused. This allows applications to scale better in scenarios where
    ///they expect large number of calls over the service proxy. The default value for this property is 5. It is of type
    ///<b>USHORT</b>. This property is write only.
    WS_PROXY_PROPERTY_MAX_CALL_POOL_SIZE = 0x00000002,
    ///The current state of the service proxy. It is of type WS_SERVICE_PROXY_STATE. This property is read only. The
    ///returned value is a snapshot of the current state, so it is possible that the state may have changed before the
    ///caller has had a chance to examine the value.
    WS_PROXY_PROPERTY_STATE              = 0x00000003,
    ///The maximum number of pending calls allowed on the service proxy. If the maximum number of calls pending on the
    ///service proxy reaches this limit, the incoming calls will be rejected with <b>WS_E_QUOTA_EXCEEDED</b> (see
    ///Windows Web Services Return Values). The default value for this property is 100. It is of type <b>ULONG</b>. This
    ///property is write only.
    WS_PROXY_PROPERTY_MAX_PENDING_CALLS  = 0x00000004,
    ///The amount of time in milliseconds the service proxy will wait for the pending calls to complete. Once the
    ///timeout expires, the service proxy will abort itself. The default value for this property is 5000 (5 seconds).
    ///This property is write only. It is of type <b>ULONG</b>.
    WS_PROXY_PROPERTY_MAX_CLOSE_TIMEOUT  = 0x00000005,
    WS_PROXY_FAULT_LANG_ID               = 0x00000006,
}

///Optional parameters for configuring a call on a client side service operation.
alias WS_CALL_PROPERTY_ID = int;
enum : int
{
    ///An application can suppress or enable must understand header processing on the proxy using this setting. This is
    ///<b>TRUE</b> by default.
    WS_CALL_PROPERTY_CHECK_MUST_UNDERSTAND   = 0x00000000,
    ///Enables an application to put headers into the input message for a given call.
    WS_CALL_PROPERTY_SEND_MESSAGE_CONTEXT    = 0x00000001,
    ///Enables an application to extract headers from the output message for a given call.
    WS_CALL_PROPERTY_RECEIVE_MESSAGE_CONTEXT = 0x00000002,
    WS_CALL_PROPERTY_CALL_ID                 = 0x00000003,
}

///WS_TRACE_API enumeration.
alias WS_TRACE_API = int;
enum : int
{
    WS_TRACE_API_NONE                                  = 0xffffffff,
    WS_TRACE_API_START_READER_CANONICALIZATION         = 0x00000000,
    WS_TRACE_API_END_READER_CANONICALIZATION           = 0x00000001,
    WS_TRACE_API_START_WRITER_CANONICALIZATION         = 0x00000002,
    WS_TRACE_API_END_WRITER_CANONICALIZATION           = 0x00000003,
    WS_TRACE_API_CREATE_XML_BUFFER                     = 0x00000004,
    WS_TRACE_API_REMOVE_NODE                           = 0x00000005,
    WS_TRACE_API_CREATE_READER                         = 0x00000006,
    WS_TRACE_API_SET_INPUT                             = 0x00000007,
    WS_TRACE_API_SET_INPUT_TO_BUFFER                   = 0x00000008,
    WS_TRACE_API_FREE_XML_READER                       = 0x00000009,
    WS_TRACE_API_GET_READER_PROPERTY                   = 0x0000000a,
    WS_TRACE_API_GET_READER_NODE                       = 0x0000000b,
    WS_TRACE_API_FILL_READER                           = 0x0000000c,
    WS_TRACE_API_READ_START_ELEMENT                    = 0x0000000d,
    WS_TRACE_API_READ_TO_START_ELEMENT                 = 0x0000000e,
    WS_TRACE_API_READ_START_ATTRIBUTE                  = 0x0000000f,
    WS_TRACE_API_READ_END_ATTRIBUTE                    = 0x00000010,
    WS_TRACE_API_READ_NODE                             = 0x00000011,
    WS_TRACE_API_SKIP_NODE                             = 0x00000012,
    WS_TRACE_API_READ_END_ELEMENT                      = 0x00000013,
    WS_TRACE_API_FIND_ATTRIBUTE                        = 0x00000014,
    WS_TRACE_API_READ_ELEMENT_VALUE                    = 0x00000015,
    WS_TRACE_API_READ_CHARS                            = 0x00000016,
    WS_TRACE_API_READ_CHARS_UTF8                       = 0x00000017,
    WS_TRACE_API_READ_BYTES                            = 0x00000018,
    WS_TRACE_API_READ_ARRAY                            = 0x00000019,
    WS_TRACE_API_GET_READER_POSITION                   = 0x0000001a,
    WS_TRACE_API_SET_READER_POSITION                   = 0x0000001b,
    WS_TRACE_API_MOVE_READER                           = 0x0000001c,
    WS_TRACE_API_CREATE_WRITER                         = 0x0000001d,
    WS_TRACE_API_FREE_XML_WRITER                       = 0x0000001e,
    WS_TRACE_API_SET_OUTPUT                            = 0x0000001f,
    WS_TRACE_API_SET_OUTPUT_TO_BUFFER                  = 0x00000020,
    WS_TRACE_API_GET_WRITER_PROPERTY                   = 0x00000021,
    WS_TRACE_API_FLUSH_WRITER                          = 0x00000022,
    WS_TRACE_API_WRITE_START_ELEMENT                   = 0x00000023,
    WS_TRACE_API_WRITE_END_START_ELEMENT               = 0x00000024,
    WS_TRACE_API_WRITE_XMLNS_ATTRIBUTE                 = 0x00000025,
    WS_TRACE_API_WRITE_START_ATTRIBUTE                 = 0x00000026,
    WS_TRACE_API_WRITE_END_ATTRIBUTE                   = 0x00000027,
    WS_TRACE_API_WRITE_VALUE                           = 0x00000028,
    WS_TRACE_API_WRITE_XML_BUFFER                      = 0x00000029,
    WS_TRACE_API_READ_XML_BUFFER                       = 0x0000002a,
    WS_TRACE_API_WRITE_XML_BUFFER_TO_BYTES             = 0x0000002b,
    WS_TRACE_API_READ_XML_BUFFER_FROM_BYTES            = 0x0000002c,
    WS_TRACE_API_WRITE_ARRAY                           = 0x0000002d,
    WS_TRACE_API_WRITE_QUALIFIED_NAME                  = 0x0000002e,
    WS_TRACE_API_WRITE_CHARS                           = 0x0000002f,
    WS_TRACE_API_WRITE_CHARS_UTF8                      = 0x00000030,
    WS_TRACE_API_WRITE_BYTES                           = 0x00000031,
    WS_TRACE_API_PUSH_BYTES                            = 0x00000032,
    WS_TRACE_API_PULL_BYTES                            = 0x00000033,
    WS_TRACE_API_WRITE_END_ELEMENT                     = 0x00000034,
    WS_TRACE_API_WRITE_TEXT                            = 0x00000035,
    WS_TRACE_API_WRITE_START_CDATA                     = 0x00000036,
    WS_TRACE_API_WRITE_END_CDATA                       = 0x00000037,
    WS_TRACE_API_WRITE_NODE                            = 0x00000038,
    WS_TRACE_API_PREFIX_FROM_NAMESPACE                 = 0x00000039,
    WS_TRACE_API_GET_WRITER_POSITION                   = 0x0000003a,
    WS_TRACE_API_SET_WRITER_POSITION                   = 0x0000003b,
    WS_TRACE_API_MOVE_WRITER                           = 0x0000003c,
    WS_TRACE_API_TRIM_XML_WHITESPACE                   = 0x0000003d,
    WS_TRACE_API_VERIFY_XML_NCNAME                     = 0x0000003e,
    WS_TRACE_API_XML_STRING_EQUALS                     = 0x0000003f,
    WS_TRACE_API_NAMESPACE_FROM_PREFIX                 = 0x00000040,
    WS_TRACE_API_READ_QUALIFIED_NAME                   = 0x00000041,
    WS_TRACE_API_GET_XML_ATTRIBUTE                     = 0x00000042,
    WS_TRACE_API_COPY_NODE                             = 0x00000043,
    WS_TRACE_API_ASYNC_EXECUTE                         = 0x00000044,
    WS_TRACE_API_CREATE_CHANNEL                        = 0x00000045,
    WS_TRACE_API_OPEN_CHANNEL                          = 0x00000046,
    WS_TRACE_API_SEND_MESSAGE                          = 0x00000047,
    WS_TRACE_API_RECEIVE_MESSAGE                       = 0x00000048,
    WS_TRACE_API_REQUEST_REPLY                         = 0x00000049,
    WS_TRACE_API_SEND_REPLY_MESSAGE                    = 0x0000004a,
    WS_TRACE_API_SEND_FAULT_MESSAGE_FOR_ERROR          = 0x0000004b,
    WS_TRACE_API_GET_CHANNEL_PROPERTY                  = 0x0000004c,
    WS_TRACE_API_SET_CHANNEL_PROPERTY                  = 0x0000004d,
    WS_TRACE_API_WRITE_MESSAGE_START                   = 0x0000004e,
    WS_TRACE_API_WRITE_MESSAGE_END                     = 0x0000004f,
    WS_TRACE_API_READ_MESSAGE_START                    = 0x00000050,
    WS_TRACE_API_READ_MESSAGE_END                      = 0x00000051,
    WS_TRACE_API_CLOSE_CHANNEL                         = 0x00000052,
    WS_TRACE_API_ABORT_CHANNEL                         = 0x00000053,
    WS_TRACE_API_FREE_CHANNEL                          = 0x00000054,
    WS_TRACE_API_RESET_CHANNEL                         = 0x00000055,
    WS_TRACE_API_ABANDON_MESSAGE                       = 0x00000056,
    WS_TRACE_API_SHUTDOWN_SESSION_CHANNEL              = 0x00000057,
    WS_TRACE_API_GET_CONTEXT_PROPERTY                  = 0x00000058,
    WS_TRACE_API_GET_DICTIONARY                        = 0x00000059,
    WS_TRACE_API_READ_ENDPOINT_ADDRESS_EXTENSION       = 0x0000005a,
    WS_TRACE_API_CREATE_ERROR                          = 0x0000005b,
    WS_TRACE_API_ADD_ERROR_STRING                      = 0x0000005c,
    WS_TRACE_API_GET_ERROR_STRING                      = 0x0000005d,
    WS_TRACE_API_COPY_ERROR                            = 0x0000005e,
    WS_TRACE_API_GET_ERROR_PROPERTY                    = 0x0000005f,
    WS_TRACE_API_SET_ERROR_PROPERTY                    = 0x00000060,
    WS_TRACE_API_RESET_ERROR                           = 0x00000061,
    WS_TRACE_API_FREE_ERROR                            = 0x00000062,
    WS_TRACE_API_GET_FAULT_ERROR_PROPERTY              = 0x00000063,
    WS_TRACE_API_SET_FAULT_ERROR_PROPERTY              = 0x00000064,
    WS_TRACE_API_CREATE_FAULT_FROM_ERROR               = 0x00000065,
    WS_TRACE_API_SET_FAULT_ERROR_DETAIL                = 0x00000066,
    WS_TRACE_API_GET_FAULT_ERROR_DETAIL                = 0x00000067,
    WS_TRACE_API_CREATE_HEAP                           = 0x00000068,
    WS_TRACE_API_ALLOC                                 = 0x00000069,
    WS_TRACE_API_GET_HEAP_PROPERTY                     = 0x0000006a,
    WS_TRACE_API_RESET_HEAP                            = 0x0000006b,
    WS_TRACE_API_FREE_HEAP                             = 0x0000006c,
    WS_TRACE_API_CREATE_LISTENER                       = 0x0000006d,
    WS_TRACE_API_OPEN_LISTENER                         = 0x0000006e,
    WS_TRACE_API_ACCEPT_CHANNEL                        = 0x0000006f,
    WS_TRACE_API_CLOSE_LISTENER                        = 0x00000070,
    WS_TRACE_API_ABORT_LISTENER                        = 0x00000071,
    WS_TRACE_API_RESET_LISTENER                        = 0x00000072,
    WS_TRACE_API_FREE_LISTENER                         = 0x00000073,
    WS_TRACE_API_GET_LISTENER_PROPERTY                 = 0x00000074,
    WS_TRACE_API_SET_LISTENER_PROPERTY                 = 0x00000075,
    WS_TRACE_API_CREATE_CHANNEL_FOR_LISTENER           = 0x00000076,
    WS_TRACE_API_CREATE_MESSAGE                        = 0x00000077,
    WS_TRACE_API_CREATE_MESSAGE_FOR_CHANNEL            = 0x00000078,
    WS_TRACE_API_INITIALIZE_MESSAGE                    = 0x00000079,
    WS_TRACE_API_RESET_MESSAGE                         = 0x0000007a,
    WS_TRACE_API_FREE_MESSAGE                          = 0x0000007b,
    WS_TRACE_API_GET_HEADER_ATTRIBUTES                 = 0x0000007c,
    WS_TRACE_API_GET_HEADER                            = 0x0000007d,
    WS_TRACE_API_GET_CUSTOM_HEADER                     = 0x0000007e,
    WS_TRACE_API_REMOVE_HEADER                         = 0x0000007f,
    WS_TRACE_API_SET_HEADER                            = 0x00000080,
    WS_TRACE_API_REMOVE_CUSTOM_HEADER                  = 0x00000081,
    WS_TRACE_API_ADD_CUSTOM_HEADER                     = 0x00000082,
    WS_TRACE_API_ADD_MAPPED_HEADER                     = 0x00000083,
    WS_TRACE_API_REMOVE_MAPPED_HEADER                  = 0x00000084,
    WS_TRACE_API_GET_MAPPED_HEADER                     = 0x00000085,
    WS_TRACE_API_WRITE_BODY                            = 0x00000086,
    WS_TRACE_API_READ_BODY                             = 0x00000087,
    WS_TRACE_API_WRITE_ENVELOPE_START                  = 0x00000088,
    WS_TRACE_API_WRITE_ENVELOPE_END                    = 0x00000089,
    WS_TRACE_API_READ_ENVELOPE_START                   = 0x0000008a,
    WS_TRACE_API_READ_ENVELOPE_END                     = 0x0000008b,
    WS_TRACE_API_GET_MESSAGE_PROPERTY                  = 0x0000008c,
    WS_TRACE_API_SET_MESSAGE_PROPERTY                  = 0x0000008d,
    WS_TRACE_API_ADDRESS_MESSAGE                       = 0x0000008e,
    WS_TRACE_API_CHECK_MUST_UNDERSTAND_HEADERS         = 0x0000008f,
    WS_TRACE_API_MARK_HEADER_AS_UNDERSTOOD             = 0x00000090,
    WS_TRACE_API_FILL_BODY                             = 0x00000091,
    WS_TRACE_API_FLUSH_BODY                            = 0x00000092,
    WS_TRACE_API_REQUEST_SECURITY_TOKEN                = 0x00000093,
    WS_TRACE_API_GET_SECURITY_TOKEN_PROPERTY           = 0x00000094,
    WS_TRACE_API_CREATE_XML_SECURITY_TOKEN             = 0x00000095,
    WS_TRACE_API_FREE_SECURITY_TOKEN                   = 0x00000096,
    WS_TRACE_API_REVOKE_SECURITY_CONTEXT               = 0x00000097,
    WS_TRACE_API_GET_SECURITY_CONTEXT_PROPERTY         = 0x00000098,
    WS_TRACE_API_READ_ELEMENT_TYPE                     = 0x00000099,
    WS_TRACE_API_READ_ATTRIBUTE_TYPE                   = 0x0000009a,
    WS_TRACE_API_READ_TYPE                             = 0x0000009b,
    WS_TRACE_API_WRITE_ELEMENT_TYPE                    = 0x0000009c,
    WS_TRACE_API_WRITE_ATTRIBUTE_TYPE                  = 0x0000009d,
    WS_TRACE_API_WRITE_TYPE                            = 0x0000009e,
    WS_TRACE_API_SERVICE_REGISTER_FOR_CANCEL           = 0x0000009f,
    WS_TRACE_API_GET_SERVICE_HOST_PROPERTY             = 0x000000a0,
    WS_TRACE_API_CREATE_SERVICE_HOST                   = 0x000000a1,
    WS_TRACE_API_OPEN_SERVICE_HOST                     = 0x000000a2,
    WS_TRACE_API_CLOSE_SERVICE_HOST                    = 0x000000a3,
    WS_TRACE_API_ABORT_SERVICE_HOST                    = 0x000000a4,
    WS_TRACE_API_FREE_SERVICE_HOST                     = 0x000000a5,
    WS_TRACE_API_RESET_SERVICE_HOST                    = 0x000000a6,
    WS_TRACE_API_GET_SERVICE_PROXY_PROPERTY            = 0x000000a7,
    WS_TRACE_API_CREATE_SERVICE_PROXY                  = 0x000000a8,
    WS_TRACE_API_OPEN_SERVICE_PROXY                    = 0x000000a9,
    WS_TRACE_API_CLOSE_SERVICE_PROXY                   = 0x000000aa,
    WS_TRACE_API_ABORT_SERVICE_PROXY                   = 0x000000ab,
    WS_TRACE_API_FREE_SERVICE_PROXY                    = 0x000000ac,
    WS_TRACE_API_RESET_SERVICE_PROXY                   = 0x000000ad,
    WS_TRACE_API_ABORT_CALL                            = 0x000000ae,
    WS_TRACE_API_CALL                                  = 0x000000af,
    WS_TRACE_API_DECODE_URL                            = 0x000000b0,
    WS_TRACE_API_ENCODE_URL                            = 0x000000b1,
    WS_TRACE_API_COMBINE_URL                           = 0x000000b2,
    WS_TRACE_API_DATETIME_TO_FILETIME                  = 0x000000b3,
    WS_TRACE_API_FILETIME_TO_DATETIME                  = 0x000000b4,
    WS_TRACE_API_DUMP_MEMORY                           = 0x000000b5,
    WS_TRACE_API_SET_AUTOFAIL                          = 0x000000b6,
    WS_TRACE_API_CREATE_METADATA                       = 0x000000b7,
    WS_TRACE_API_READ_METADATA                         = 0x000000b8,
    WS_TRACE_API_FREE_METADATA                         = 0x000000b9,
    WS_TRACE_API_RESET_METADATA                        = 0x000000ba,
    WS_TRACE_API_GET_METADATA_PROPERTY                 = 0x000000bb,
    WS_TRACE_API_GET_MISSING_METADATA_DOCUMENT_ADDRESS = 0x000000bc,
    WS_TRACE_API_GET_METADATA_ENDPOINTS                = 0x000000bd,
    WS_TRACE_API_MATCH_POLICY_ALTERNATIVE              = 0x000000be,
    WS_TRACE_API_GET_POLICY_PROPERTY                   = 0x000000bf,
    WS_TRACE_API_GET_POLICY_ALTERNATIVE_COUNT          = 0x000000c0,
    WS_TRACE_API_WS_CREATE_SERVICE_PROXY_FROM_TEMPLATE = 0x000000c1,
    WS_TRACE_API_WS_CREATE_SERVICE_HOST_FROM_TEMPLATE  = 0x000000c2,
}

///The set of schemes used with WsDecodeUrl, WsEncodeUrl, and WsCombineUrl.
alias WS_URL_SCHEME_TYPE = int;
enum : int
{
    ///Denotes the "http" scheme: WS_HTTP_URL
    WS_URL_HTTP_SCHEME_TYPE    = 0x00000000,
    ///Denotes the "https" scheme: WS_HTTPS_URL
    WS_URL_HTTPS_SCHEME_TYPE   = 0x00000001,
    ///Denotes the "net.tcp" scheme: WS_NETTCP_URL
    WS_URL_NETTCP_SCHEME_TYPE  = 0x00000002,
    ///Denotes the "soap.udp" scheme: WS_SOAPUDP_URL
    WS_URL_SOAPUDP_SCHEME_TYPE = 0x00000003,
    WS_URL_NETPIPE_SCHEME_TYPE = 0x00000004,
}

///Specifies the textual format of a WS_DATETIME.
alias WS_DATETIME_FORMAT = int;
enum : int
{
    ///This format displays a time in the GMT timezone. It is formatted with a "Z" following the time. For example,
    ///September 25, 2007 at 1:30AM in the GMT timezone would be represented as "2007-09-25T01:30:00Z".
    WS_DATETIME_FORMAT_UTC   = 0x00000000,
    ///This format displays a time with a specific timezone. The time is followed by "[+|-]hh:mm" indicating the
    ///relative difference between the local time and UTC in hours and minutes. For example, September 27, 2007 at
    ///10:30AM in the Pacific timezone would be represented as "2007-09-27T10:30:00-07:00". If the system is unable to
    ///convert the time to a local format because timezone information for the time specified it not available, then it
    ///will format the time as WS_DATETIME_FORMAT_UTC.
    WS_DATETIME_FORMAT_LOCAL = 0x00000001,
    WS_DATETIME_FORMAT_NONE  = 0x00000002,
}

///The state of the metadata object.
alias WS_METADATA_STATE = int;
enum : int
{
    ///The initial state of the metadata object.
    WS_METADATA_STATE_CREATED  = 0x00000001,
    ///All references between metadata documents have been resolved and no more metadata documents may be added to the
    ///metadata object. See WsGetMetadataEndpoints for more information.
    WS_METADATA_STATE_RESOLVED = 0x00000002,
    ///The metadata object not usable due to a previous error. See See WsGetMetadataEndpoints and WsReadMetadatafor more
    ///information.
    WS_METADATA_STATE_FAULTED  = 0x00000003,
}

///Each metadata property is of type WS_METADATA_PROPERTY, is identified by an ID, and has an associated value. If a
///property is not specified when the metadata is created, then its default value is used.
alias WS_METADATA_PROPERTY_ID = int;
enum : int
{
    ///This property is used with WsGetMetadataProperty. The accompanying <b>value</b> member of the
    ///WS_METADATA_PROPERTY structure contains the current WS_METADATA_STATE of the metadata object.
    WS_METADATA_PROPERTY_STATE               = 0x00000001,
    ///This property is used with WsCreateMetadata to specify properties of the WS_HEAP object used by the metadata
    ///object to store information about the metadata that was read. The accompanying <b>value</b> member of the
    ///WS_METADATA_PROPERTY structure contains a WS_HEAP_PROPERTIES structure. The following heap properties may be
    ///specified: <ul> <li> WS_HEAP_PROPERTY_MAX_SIZE. If not specified, the default value used is 256k bytes. </li>
    ///<li> WS_HEAP_PROPERTY_TRIM_SIZE. If not specified, the default value used is 32k bytes. </li> </ul>
    WS_METADATA_PROPERTY_HEAP_PROPERTIES     = 0x00000002,
    ///This property is used with WsCreateMetadata to specify properties of the WS_POLICY objects that are associated
    ///with the metadata object. The accompanying <b>value</b> member of the WS_METADATA_PROPERTY structure contains a
    ///WS_POLICY_PROPERTIES structure that specifies the set of policy properties. See WS_POLICY_PROPERTY_ID for more
    ///information on the set of properties that may be specified here.
    WS_METADATA_PROPERTY_POLICY_PROPERTIES   = 0x00000003,
    ///This property is used with WsGetMetadataProperty. The accompanying <b>value</b> member of the
    ///WS_METADATA_PROPERTY is a <b>SIZE_T</b> specifying the number of bytes allocated from the heap associated with
    ///the metadata object.
    WS_METADATA_PROPERTY_HEAP_REQUESTED_SIZE = 0x00000004,
    ///This property is used with WsCreateMetadata. The accompanying <b>value</b> member of the WS_METADATA_PROPERTY is
    ///a <b>ULONG</b> specifying the maximum number of documents that may be added to the metadata object using
    ///WsReadMetadata. The default value is 32.
    WS_METADATA_PROPERTY_MAX_DOCUMENTS       = 0x00000005,
    ///This property is used with WsCreateMetadata. The accompanying <b>value</b> member of the WS_METADATA_PROPERTY is
    ///a WS_HOST_NAMES structure. This property may only be specified if WS_METADATA_PROPERTY_VERIFY_HOST_NAMES is
    ///<b>TRUE</b>. See WsGetMissingMetadataDocumentAddress for more information on verifying host names. If the
    ///property is not specified, then the list of host names is empty.
    WS_METADATA_PROPERTY_HOST_NAMES          = 0x00000006,
    WS_METADATA_PROPERTY_VERIFY_HOST_NAMES   = 0x00000007,
}

///The state of the policy object.
alias WS_POLICY_STATE = int;
enum : int
{
    ///The initial state of the policy object.
    WS_POLICY_STATE_CREATED = 0x00000001,
    ///The policy object is no longer usable due to a previous error.
    WS_POLICY_STATE_FAULTED = 0x00000002,
}

///Identifies each policy property and its associated value.
alias WS_POLICY_PROPERTY_ID = int;
enum : int
{
    ///This property is used with WsGetPolicyProperty. It is of type WS_POLICY_STATE. The current state of the policy
    ///object.
    WS_POLICY_PROPERTY_STATE            = 0x00000001,
    ///This property is used with WsCreateMetadata when specifying WS_METADATA_PROPERTY_POLICY_PROPERTIES as part of the
    ///WS_METADATA_PROPERTY* parameter. It is of type <b>ULONG</b>. This property controls the maximum number of
    ///alternatives allowed for a given WS_POLICY object. When a policy is processed, the amount of memory allocated and
    ///CPU consumed is proportional to the number of policy alternatives present in the policy, not to the actual size
    ///of the policy. Even a small policy may contain a large number of alternatives due to the expansion of different
    ///permutations of assertions. Setting this property to a large value may lead to excessive processing or memory
    ///consumption. The default value is 32.
    WS_POLICY_PROPERTY_MAX_ALTERNATIVES = 0x00000002,
    ///This property is used with WsCreateMetadata when specifying WS_METADATA_PROPERTY_POLICY_PROPERTIES. It is of type
    ///<b>ULONG</b>. This property controls the maximum depth of any policy that is read and processed. The maximum
    ///depth of a policy is defined as the maximum number of levels of nested container elements (<b>Policy</b>,
    ///<b>All</b>, <b>ExactlyOne</b>) when considering the policy and any policies that it references. A small amount of
    ///stack space is consumed for each level of policy that is processed. Setting this value to a large value may lead
    ///to stack overflow for a policy that is deeply nested or contains a cyclic reference. The default value is 32.
    WS_POLICY_PROPERTY_MAX_DEPTH        = 0x00000003,
    WS_POLICY_PROPERTY_MAX_EXTENSIONS   = 0x00000004,
}

///The values in this enumeration are used to identify the sub-types of WS_SECURITY_BINDING_CONSTRAINT.
alias WS_SECURITY_BINDING_CONSTRAINT_TYPE = int;
enum : int
{
    ///This value is used in the type field of WS_SECURITY_BINDING_CONSTRAINTto identify a
    ///WS_SSL_TRANSPORT_SECURITY_BINDING_CONSTRAINT structure.
    WS_SSL_TRANSPORT_SECURITY_BINDING_CONSTRAINT_TYPE            = 0x00000001,
    ///This value is used in the type field of WS_SECURITY_BINDING_CONSTRAINTto identify a
    ///WS_TCP_SSPI_TRANSPORT_SECURITY_BINDING_CONSTRAINT structure.
    WS_TCP_SSPI_TRANSPORT_SECURITY_BINDING_CONSTRAINT_TYPE       = 0x00000002,
    ///This value is used in the type field of WS_SECURITY_BINDING_CONSTRAINTto identify a
    ///WS_HTTP_HEADER_AUTH_SECURITY_BINDING_CONSTRAINT structure.
    WS_HTTP_HEADER_AUTH_SECURITY_BINDING_CONSTRAINT_TYPE         = 0x00000003,
    ///This value is used in the type field of WS_SECURITY_BINDING_CONSTRAINTto identify a
    ///WS_USERNAME_MESSAGE_SECURITY_BINDING_CONSTRAINT structure.
    WS_USERNAME_MESSAGE_SECURITY_BINDING_CONSTRAINT_TYPE         = 0x00000004,
    ///This value is used in the type field of WS_SECURITY_BINDING_CONSTRAINTto identify a
    ///WS_KERBEROS_APREQ_MESSAGE_SECURITY_BINDING_CONSTRAINT structure.
    WS_KERBEROS_APREQ_MESSAGE_SECURITY_BINDING_CONSTRAINT_TYPE   = 0x00000005,
    ///This value is used in the type field of WS_SECURITY_BINDING_CONSTRAINTto identify a
    ///WS_ISSUED_TOKEN_MESSAGE_SECURITY_BINDING_CONSTRAINT structure.
    WS_ISSUED_TOKEN_MESSAGE_SECURITY_BINDING_CONSTRAINT_TYPE     = 0x00000006,
    ///This value is used in the type field of WS_SECURITY_BINDING_CONSTRAINTto identify a
    ///WS_CERT_MESSAGE_SECURITY_BINDING_CONSTRAINT structure.
    WS_CERT_MESSAGE_SECURITY_BINDING_CONSTRAINT_TYPE             = 0x00000007,
    WS_SECURITY_CONTEXT_MESSAGE_SECURITY_BINDING_CONSTRAINT_TYPE = 0x00000008,
}

///The values in this enumeration are used to identify the sub-types of WS_POLICY_EXTENSION.
alias WS_POLICY_EXTENSION_TYPE = int;
enum : int
{
    WS_ENDPOINT_POLICY_EXTENSION_TYPE = 0x00000001,
}

///An enumeration of the different security binding combinations that are supported.
alias WS_BINDING_TEMPLATE_TYPE = int;
enum : int
{
    ///The policy specifies HTTP channel binding.
    WS_HTTP_BINDING_TEMPLATE_TYPE                                     = 0x00000000,
    ///The policy specifies HTTP channel binding with WS_SSL_TRANSPORT_SECURITY_BINDING.
    WS_HTTP_SSL_BINDING_TEMPLATE_TYPE                                 = 0x00000001,
    ///The policy specifies HTTP channel binding with WS_HTTP_HEADER_AUTH_SECURITY_BINDING
    WS_HTTP_HEADER_AUTH_BINDING_TEMPLATE_TYPE                         = 0x00000002,
    ///The policy specifies HTTP channel binding with WS_SSL_TRANSPORT_SECURITY_BINDING and
    ///WS_HTTP_HEADER_AUTH_SECURITY_BINDING.
    WS_HTTP_SSL_HEADER_AUTH_BINDING_TEMPLATE_TYPE                     = 0x00000003,
    ///The policy specifies HTTP channel binding with WS_SSL_TRANSPORT_SECURITY_BINDING and
    ///WS_USERNAME_MESSAGE_SECURITY_BINDING.
    WS_HTTP_SSL_USERNAME_BINDING_TEMPLATE_TYPE                        = 0x00000004,
    ///The policy specifies HTTP channel binding with WS_SSL_TRANSPORT_SECURITY_BINDING and
    ///WS_KERBEROS_APREQ_MESSAGE_SECURITY_BINDING.
    WS_HTTP_SSL_KERBEROS_APREQ_BINDING_TEMPLATE_TYPE                  = 0x00000005,
    ///The policy specifies TCP channel binding.
    WS_TCP_BINDING_TEMPLATE_TYPE                                      = 0x00000006,
    ///The policy specifies TCP channel binding with WS_TCP_SSPI_TRANSPORT_SECURITY_BINDING.
    WS_TCP_SSPI_BINDING_TEMPLATE_TYPE                                 = 0x00000007,
    ///The policy specifies TCP channel binding with WS_TCP_SSPI_TRANSPORT_SECURITY_BINDING and
    ///WS_USERNAME_MESSAGE_SECURITY_BINDING.
    WS_TCP_SSPI_USERNAME_BINDING_TEMPLATE_TYPE                        = 0x00000008,
    ///The policy specifies TCP channel binding with WS_TCP_SSPI_TRANSPORT_SECURITY_BINDING and
    ///WS_KERBEROS_APREQ_MESSAGE_SECURITY_BINDING.
    WS_TCP_SSPI_KERBEROS_APREQ_BINDING_TEMPLATE_TYPE                  = 0x00000009,
    ///The policy specifies HTTP channel binding with WS_SSL_TRANSPORT_SECURITY_BINDING and
    ///WS_SECURITY_CONTEXT_MESSAGE_SECURITY_BINDING, using bootstrap channel with HTTP channel binding,
    ///<b>WS_SSL_TRANSPORT_SECURITY_BINDING</b> and WS_USERNAME_MESSAGE_SECURITY_BINDING.
    WS_HTTP_SSL_USERNAME_SECURITY_CONTEXT_BINDING_TEMPLATE_TYPE       = 0x0000000a,
    ///The policy specifies HTTP channel binding with WS_SSL_TRANSPORT_SECURITY_BINDING and
    ///WS_SECURITY_CONTEXT_MESSAGE_SECURITY_BINDING, using bootstrap channel with HTTP channel binding,
    ///<b>WS_SSL_TRANSPORT_SECURITY_BINDING</b> and WS_KERBEROS_APREQ_MESSAGE_SECURITY_BINDING.
    WS_HTTP_SSL_KERBEROS_APREQ_SECURITY_CONTEXT_BINDING_TEMPLATE_TYPE = 0x0000000b,
    ///The policy specifies TCP channel binding with WS_SSL_TRANSPORT_SECURITY_BINDING and
    ///WS_SECURITY_CONTEXT_MESSAGE_SECURITY_BINDING, using bootstrap channel with TCP channel binding,
    ///<b>WS_SSL_TRANSPORT_SECURITY_BINDING</b> and WS_USERNAME_MESSAGE_SECURITY_BINDING.
    WS_TCP_SSPI_USERNAME_SECURITY_CONTEXT_BINDING_TEMPLATE_TYPE       = 0x0000000c,
    WS_TCP_SSPI_KERBEROS_APREQ_SECURITY_CONTEXT_BINDING_TEMPLATE_TYPE = 0x0000000d,
}

// Constants


enum : int
{
    WS_HTTP_HEADER_MAPPING_COMMA_SEPARATOR     = 0x00000001,
    WS_HTTP_HEADER_MAPPING_SEMICOLON_SEPARATOR = 0x00000002,
    WS_HTTP_HEADER_MAPPING_QUOTED_VALUE        = 0x00000004,
}

enum int WS_HTTP_RESPONSE_MAPPING_STATUS_TEXT = 0x00000002;

enum : int
{
    WS_MATCH_URL_DNS_HOST                 = 0x00000001,
    WS_MATCH_URL_DNS_FULLY_QUALIFIED_HOST = 0x00000002,
}

enum : int
{
    WS_MATCH_URL_LOCAL_HOST     = 0x00000008,
    WS_MATCH_URL_HOST_ADDRESSES = 0x00000010,
    WS_MATCH_URL_THIS_HOST      = 0x0000001f,
    WS_MATCH_URL_PORT           = 0x00000020,
    WS_MATCH_URL_EXACT_PATH     = 0x00000040,
    WS_MATCH_URL_PREFIX_PATH    = 0x00000080,
    WS_MATCH_URL_NO_QUERY       = 0x00000100,
}

enum int WS_RELAY_HEADER_ATTRIBUTE = 0x00000002;

enum : int
{
    WS_HTTP_HEADER_AUTH_SCHEME_BASIC     = 0x00000002,
    WS_HTTP_HEADER_AUTH_SCHEME_DIGEST    = 0x00000004,
    WS_HTTP_HEADER_AUTH_SCHEME_NTLM      = 0x00000008,
    WS_HTTP_HEADER_AUTH_SCHEME_NEGOTIATE = 0x00000010,
    WS_HTTP_HEADER_AUTH_SCHEME_PASSPORT  = 0x00000020,
}

enum : int
{
    WS_CERT_FAILURE_INVALID_DATE       = 0x00000002,
    WS_CERT_FAILURE_UNTRUSTED_ROOT     = 0x00000004,
    WS_CERT_FAILURE_WRONG_USAGE        = 0x00000008,
    WS_CERT_FAILURE_REVOCATION_OFFLINE = 0x00000010,
}

enum : int
{
    WS_STRUCT_IGNORE_TRAILING_ELEMENT_CONTENT = 0x00000002,
    WS_STRUCT_IGNORE_UNHANDLED_ATTRIBUTES     = 0x00000004,
}

enum : int
{
    WS_FIELD_OPTIONAL        = 0x00000002,
    WS_FIELD_NILLABLE        = 0x00000004,
    WS_FIELD_NILLABLE_ITEM   = 0x00000008,
    WS_FIELD_OTHER_NAMESPACE = 0x00000010,
}

enum int WS_URL_FLAGS_ALLOW_HOST_WILDCARDS = 0x00000001;
enum int WS_URL_FLAGS_ZERO_TERMINATE = 0x00000004;

// Callbacks

///Used by the WS_XML_READERto read from some source into a buffer.
///Params:
///    callbackState = A <b>void</b> pointer to the user-defined state value that was passed to the function that accepted this
///                    callback.
///    bytes = A <b>void</b> pointer to the location where the data should be placed.
///    maxSize = The maximum number of bytes that may be read.
///    actualSize = A pointer to a <b>ULONG</b> value that indicates the number of bytes actually read. This may be less than
///                 maxSize. Returning 0 indicates that there is no more data.
///    asyncContext = A pointer to a WS_ASYNC_CONTEXT structure containing information on how to invoke the function asynchronously.
///                   Assigned <b>NULL</b> if invoking synchronously.
///    error = A pointer to WS_ERROR data structure where additional error information should be stored if the function fails.
///Returns:
///    This callback function does not return a value.
///    
alias WS_READ_CALLBACK = HRESULT function(void* callbackState, void* bytes, uint maxSize, uint* actualSize, 
                                          const(WS_ASYNC_CONTEXT)* asyncContext, WS_ERROR* error);
///Used by the WS_XML_WRITER function to write a specified buffer to a user-determined destination.
///Params:
///    callbackState = A <b>void</b> pointer to the user-defined state value that was passed to the function that accepted this
///                    callback.
///    buffers = A pointer to the buffers containing the data to be written.
///    count = The number of buffers to write.
///    asyncContext = A pointer to a WS_ASYNC_CONTEXT structure containing information on how to invoke the function asynchronously.
///                   Assigned <b>NULL</b> if invoking synchronously.
///    error = A pointer to a WS_ERROR data structure where additional error information should be stored if the function fails.
alias WS_WRITE_CALLBACK = HRESULT function(void* callbackState, const(WS_BYTES)* buffers, uint count, 
                                           const(WS_ASYNC_CONTEXT)* asyncContext, WS_ERROR* error);
///Used by the WsPushBytes function to request that data be written.
///Params:
///    callbackState = A void pointer to the user-defined state that was passed to WsPushBytes.
///    writeCallback = The callback function for writing bytes to the document.
///    writeCallbackState = A void pointer to the caller-defined state that should be passed when invoking the WS_WRITE_CALLBACK function.
///    asyncContext = A pointer to a WS_ASYNC_CONTEXT structure containing information on how to invoke the function asynchronously.
///                   Assign <b>NULL</b> if invoking synchronously.
///    error = A pointer to a WS_ERROR data structure where additional error information should be stored if the function fails.
alias WS_PUSH_BYTES_CALLBACK = HRESULT function(void* callbackState, WS_WRITE_CALLBACK writeCallback, 
                                                void* writeCallbackState, const(WS_ASYNC_CONTEXT)* asyncContext, 
                                                WS_ERROR* error);
///Used by the WsPullBytes function to request the data that should be written.
///Params:
///    callbackState = The user-defined state that was passed to WsPullBytes.
///    bytes = Where the data that is read should be placed.
///    maxSize = The maximum number of bytes that may be read.
///    actualSize = The actual number of bytes that were read. This may be less than maxSize. Returning 0 indicates that there is no
///                 more data.
///    asyncContext = Information on how to invoke the function asynchronously, or <b>NULL</b> if invoking synchronously.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_S_ASYNC</b></dt> </dl> </td> <td width="60%"> The asynchronous operation is still pending. </td> </tr>
///    </table>
///    
alias WS_PULL_BYTES_CALLBACK = HRESULT function(void* callbackState, void* bytes, uint maxSize, uint* actualSize, 
                                                const(WS_ASYNC_CONTEXT)* asyncContext, WS_ERROR* error);
///Determines whether the specified string can be written in optimized form. This callback is used in
///WS_XML_WRITER_BINARY_ENCODING
///Params:
///    callbackState = User-defined state that was passed to the function that accepted the <i>WS_DYNAMIC_STRING_CALLBACK</i>.
///    string = The string to look up in the dynamic dictionary.
///    found = Whether or not the string was found in the dynamic dictionary is returned here.
///    id = The id of the string is returned here.
///    error = Specifies where additional error information should be stored if the function fails.
alias WS_DYNAMIC_STRING_CALLBACK = HRESULT function(void* callbackState, const(WS_XML_STRING)* string, BOOL* found, 
                                                    uint* id, WS_ERROR* error);
///The callback function parameter used with the asynchronous model.
///Params:
///    errorCode = The result of the operation. If the operation fails and a WS_ERROR object is supplied, the object is filled with
///                rich error information before the callback is invoked.
///    callbackModel = A WS_CALLBACK_MODEL value that determines whether the callback is being invoked as a long or short term callback.
///    callbackState = A void pointer that corresponds to the value of the <b>callbackState</b> field of the WS_ASYNC_CONTEXT structure.
///                    This parameter is used to pass user-defined data to the callback function if the operation completes
///                    asynchronously.
alias WS_ASYNC_CALLBACK = void function(HRESULT errorCode, WS_CALLBACK_MODEL callbackModel, void* callbackState);
///Used with the WsAsyncExecute to specify the next function to invoke in a series of async operations.
///Params:
///    hr = The result of the previous async operation.
///    callbackModel = Whether the callback is being invoked long or short. For more information, see WS_CALLBACK_MODEL.
///    callbackState = This user supplied value that was passed to WsAsyncExecute/
///    next = Set the function field to the next function to call. It will be called regardless of whether or not the current
///           function succeeds or fails. Set the function field to <b>NULL</b> to indicate that there are no more functions to
///           call. WsAsyncExecute will set the function field to <b>NULL</b> before each function is called.
///    asyncContext = Information on how to invoke the function asynchronously, or <b>NULL</b> if invoking synchronously.
///    error = Specifies where additional error information should be stored if the function fails.
alias WS_ASYNC_FUNCTION = HRESULT function(HRESULT hr, WS_CALLBACK_MODEL callbackModel, void* callbackState, 
                                           WS_ASYNC_OPERATION* next, const(WS_ASYNC_CONTEXT)* asyncContext, 
                                           WS_ERROR* error);
///Handles the WsCreateChannel call for a WS_CUSTOM_CHANNEL_BINDING.
///Params:
///    channelType = The message exchange pattern of the channel. If the type of channel is not supported by the custom channel
///                  implementation, <b>E_INVALIDARG</b> should be returned.
///    channelParameters = The pointer to the value that was specified by the WS_CHANNEL_PROPERTY_CUSTOM_CHANNEL_PARAMETERSproperty when the
///                        custom channel is created using WsCreateChannel. If the WS_CHANNEL_PROPERTY_CUSTOM_CHANNEL_PARAMETERSproperty was
///                        not specified, the value will be <b>NULL</b>.
///    channelParametersSize = The size in bytes of the value pointed to by channelParameters. If the
///                            WS_CHANNEL_PROPERTY_CUSTOM_CHANNEL_PARAMETERSproperty was not specified, the size will be 0.
///    error = Specifies where additional error information should be stored if the function fails.
///    channelInstance = A pointer to an structure allocated by the callback that contains the data specific to this channel instance.
///                      This pointer will be passed to all the other channel callbacks for this particular channel instance. If this
///                      callback is successful, then the WS_FREE_CHANNEL_CALLBACKwill be used to free the channel instance returned in
///                      this parameter.
alias WS_CREATE_CHANNEL_CALLBACK = HRESULT function(WS_CHANNEL_TYPE channelType, const(void)* channelParameters, 
                                                    uint channelParametersSize, void** channelInstance, 
                                                    WS_ERROR* error);
///Handles the WsFreeChannel call for a WS_CUSTOM_CHANNEL_BINDING.
///Params:
///    channelInstance = The pointer to the state specific to this channel instance, as created by the WS_CREATE_CHANNEL_CALLBACK. The
///                      callback should free this pointer.
alias WS_FREE_CHANNEL_CALLBACK = void function(void* channelInstance);
///Handles the WsResetChannel call for a WS_CUSTOM_CHANNEL_BINDING.
///Params:
///    channelInstance = The pointer to the state specific to this channel instance, as created by the WS_CREATE_CHANNEL_CALLBACK.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_INVALID_OPERATION</b></dt> </dl> </td> <td width="60%"> The channel was in an inappropriate state.
///    </td> </tr> </table>
///    
alias WS_RESET_CHANNEL_CALLBACK = HRESULT function(void* channelInstance, WS_ERROR* error);
///Handles the WsAbortChannel call for a WS_CUSTOM_CHANNEL_BINDING.
///Params:
///    channelInstance = The pointer to the state specific to this channel instance, as created by the WS_CREATE_CHANNEL_CALLBACK.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    This callback function does not return a value.
///    
alias WS_ABORT_CHANNEL_CALLBACK = HRESULT function(void* channelInstance, WS_ERROR* error);
///Handles the WsOpenChannel call for a WS_CUSTOM_CHANNEL_BINDING.
///Params:
///    channelInstance = The pointer to the state specific to this channel instance, as created by the WS_CREATE_CHANNEL_CALLBACK.
///    endpointAddress = The address of the endpoint.
///    asyncContext = Information on how to invoke the function asynchronously, or <b>NULL</b> if invoking synchronously.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_S_ASYNC</b></dt> </dl> </td> <td width="60%"> The asynchronous operation is still pending. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>WS_E_OPERATION_ABORTED</b></dt> </dl> </td> <td width="60%"> The operation was
///    aborted. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_OPERATION</b></dt> </dl> </td> <td
///    width="60%"> The operation is not allowed due to the current state of the object. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>WS_E_ENDPOINT_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The remote endpoint does
///    not exist or could not be located. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_ENDPOINT_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access was denied by the remote
///    endpoint. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_ENDPOINT_DISCONNECTED</b></dt> </dl> </td> <td
///    width="60%"> The connection with the remote endpoint was terminated. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_ENDPOINT_FAILURE</b></dt> </dl> </td> <td width="60%"> The remote endpoint could not process the
///    request. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_ENDPOINT_NOT_AVAILABLE</b></dt> </dl> </td> <td
///    width="60%"> The remote endpoint is not currently in service at this location. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>WS_E_ENDPOINT_TOO_BUSY</b></dt> </dl> </td> <td width="60%"> The remote endpoint is unable to process
///    the request due to being overloaded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_ENDPOINT_UNREACHABLE</b></dt> </dl> </td> <td width="60%"> The remote endpoint was not reachable.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_ENDPOINT_URL</b></dt> </dl> </td> <td width="60%"> The
///    endpoint address URL is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl>
///    </td> <td width="60%"> The input data was not in the expected format or did not have the expected value. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_OPERATION_TIMED_OUT</b></dt> </dl> </td> <td width="60%"> The
///    operation did not complete within the time allotted. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_PROXY_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access was denied by the HTTP proxy server.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_PROXY_FAILURE</b></dt> </dl> </td> <td width="60%"> The HTTP
///    proxy server could not process the request. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_QUOTA_EXCEEDED</b></dt> </dl> </td> <td width="60%"> A quota was exceeded. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>WS_E_SECURITY_VERIFICATION_FAILURE</b></dt> </dl> </td> <td width="60%"> Security
///    verification was not successful for the received data. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SECURITY_SYSTEM_FAILURE</b></dt> </dl> </td> <td width="60%"> A security operation failed in the
///    Windows Web Services framework. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_PROXY_REQUIRES_BASIC_AUTH</b></dt> </dl> </td> <td width="60%"> The HTTP proxy server requires HTTP
///    authentication scheme 'basic'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_PROXY_REQUIRES_DIGEST_AUTH</b></dt> </dl> </td> <td width="60%"> The HTTP proxy server requires HTTP
///    authentication scheme 'digest'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_PROXY_REQUIRES_NEGOTIATE_AUTH</b></dt> </dl> </td> <td width="60%"> The HTTP proxy server requires
///    HTTP authentication scheme 'negotiate'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_PROXY_REQUIRES_NTLM_AUTH</b></dt> </dl> </td> <td width="60%"> The HTTP proxy server requires HTTP
///    authentication scheme 'NTLM'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SERVER_REQUIRES_BASIC_AUTH</b></dt> </dl> </td> <td width="60%"> The remote endpoint requires HTTP
///    authentication scheme 'basic'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SERVER_REQUIRES_DIGEST_AUTH</b></dt> </dl> </td> <td width="60%"> The remote endpoint requires HTTP
///    authentication scheme 'digest'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SERVER_REQUIRES_NEGOTIATE_AUTH</b></dt> </dl> </td> <td width="60%"> The remote endpoint requires
///    HTTP authentication scheme 'negotiate'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SERVER_REQUIRES_NTLM_AUTH</b></dt> </dl> </td> <td width="60%"> The remote endpoint requires HTTP
///    authentication scheme 'NTLM'. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td>
///    <td width="60%"> Ran out of memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
///    </td> <td width="60%"> One or more arguments are invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b> Other
///    Errors </b></dt> </dl> </td> <td width="60%"> This function may return other errors not listed above. </td> </tr>
///    </table>
///    
alias WS_OPEN_CHANNEL_CALLBACK = HRESULT function(void* channelInstance, 
                                                  const(WS_ENDPOINT_ADDRESS)* endpointAddress, 
                                                  const(WS_ASYNC_CONTEXT)* asyncContext, WS_ERROR* error);
///Handles the WsCloseChannel call for a WS_CUSTOM_CHANNEL_BINDING.
///Params:
///    channelInstance = The pointer to the state specific to this channel instance, as created by the WS_CREATE_CHANNEL_CALLBACK.
///    asyncContext = Information on how to invoke the function asynchronously, or <b>NULL</b> if invoking synchronously.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_S_ASYNC</b></dt> </dl> </td> <td width="60%"> The asynchronous operation is still pending. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>WS_E_OPERATION_ABORTED</b></dt> </dl> </td> <td width="60%"> The close was
///    aborted by a call to WsAbortChannel as it was closing. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_INVALID_OPERATION</b></dt> </dl> </td> <td width="60%"> The channel was in an inappropriate state.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_OPERATION_ABORTED</b></dt> </dl> </td> <td width="60%"> The
///    operation was aborted. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_OPERATION</b></dt> </dl> </td>
///    <td width="60%"> The operation is not allowed due to the current state of the object. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>WS_E_ENDPOINT_DISCONNECTED</b></dt> </dl> </td> <td width="60%"> The connection with the
///    remote endpoint was terminated. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_ENDPOINT_FAILURE</b></dt>
///    </dl> </td> <td width="60%"> The remote endpoint could not process the request. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl> </td> <td width="60%"> The input data was not in the expected
///    format or did not have the expected value. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_OPERATION_TIMED_OUT</b></dt> </dl> </td> <td width="60%"> The operation did not complete within the
///    time allotted. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_QUOTA_EXCEEDED</b></dt> </dl> </td> <td
///    width="60%"> A quota was exceeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl>
///    </td> <td width="60%"> Ran out of memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt>
///    </dl> </td> <td width="60%"> One or more arguments are invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>
///    Other Errors </b></dt> </dl> </td> <td width="60%"> This function may return other errors not listed above. </td>
///    </tr> </table>
///    
alias WS_CLOSE_CHANNEL_CALLBACK = HRESULT function(void* channelInstance, const(WS_ASYNC_CONTEXT)* asyncContext, 
                                                   WS_ERROR* error);
///Handles the WsSetChannelProperty call for a WS_CUSTOM_CHANNEL_BINDING.
///Params:
///    channelInstance = The pointer to the state specific to this channel instance, as created by the WS_CREATE_CHANNEL_CALLBACK.
///    id = The id of the property to set.
///    value = The pointer to the property value to set. The pointer must have an alignment compatible with the type of the
///            property.
///    valueSize = The size of of the property value.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The property id was not supported for this object. The
///    specified size was not appropriate for the property. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There was not enough space to set the property value.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b> Other Errors </b></dt> </dl> </td> <td width="60%"> This function
///    may return other errors not listed above. </td> </tr> </table>
///    
alias WS_SET_CHANNEL_PROPERTY_CALLBACK = HRESULT function(void* channelInstance, WS_CHANNEL_PROPERTY_ID id, 
                                                          const(void)* value, uint valueSize, WS_ERROR* error);
///Handles the WsGetChannelProperty call for a WS_CUSTOM_CHANNEL_BINDING.
///Params:
///    channelInstance = The pointer to the state specific to this channel instance, as created by the WS_CREATE_CHANNEL_CALLBACK.
///    id = The id of the property to retrieve.
///    value = The location to store the retrieved property. The pointer must have an alignment compatible with the type of the
///            property.
///    valueSize = The number of bytes allocated by the caller to store the retrieved property.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The property id was not supported for this object or
///    the specified buffer was not large enough for the value. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Ran out of memory. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b> Other Errors </b></dt> </dl> </td> <td width="60%"> This function may return other errors not listed
///    above. </td> </tr> </table>
///    
alias WS_GET_CHANNEL_PROPERTY_CALLBACK = HRESULT function(void* channelInstance, WS_CHANNEL_PROPERTY_ID id, 
                                                          void* value, uint valueSize, WS_ERROR* error);
///Handles the WsReadMessageStart call for a WS_CUSTOM_CHANNEL_BINDING.
///Params:
///    channelInstance = The pointer to the state specific to this channel instance, as created by the WS_CREATE_CHANNEL_CALLBACK.
///    message = The message to receive into.
///    asyncContext = Information on how to invoke the function asynchronously, or <b>NULL</b> if invoking synchronously.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt>
///    </dl> </td> <td width="60%"> Start of message was received successfully. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_S_END</b></dt> </dl> </td> <td width="60%"> There are no more messages available on the channel. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>WS_S_ASYNC</b></dt> </dl> </td> <td width="60%"> The asynchronous
///    operation is still pending. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_OPERATION_ABORTED</b></dt> </dl>
///    </td> <td width="60%"> The operation was aborted. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_INVALID_OPERATION</b></dt> </dl> </td> <td width="60%"> The operation is not allowed due to the
///    current state of the object. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_ENDPOINT_NOT_FOUND</b></dt> </dl>
///    </td> <td width="60%"> The remote endpoint does not exist or could not be located. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>WS_E_ENDPOINT_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access was denied by
///    the remote endpoint. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_ENDPOINT_DISCONNECTED</b></dt> </dl>
///    </td> <td width="60%"> The connection with the remote endpoint was terminated. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>WS_E_ENDPOINT_FAILURE</b></dt> </dl> </td> <td width="60%"> The remote endpoint could not process the
///    request. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_ENDPOINT_NOT_AVAILABLE</b></dt> </dl> </td> <td
///    width="60%"> The remote endpoint is not currently in service at this location. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>WS_E_ENDPOINT_TOO_BUSY</b></dt> </dl> </td> <td width="60%"> The remote endpoint is unable to process
///    the request due to being overloaded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_ENDPOINT_UNREACHABLE</b></dt> </dl> </td> <td width="60%"> The remote endpoint was not reachable.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_ENDPOINT_URL</b></dt> </dl> </td> <td width="60%"> The
///    endpoint address URL is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl>
///    </td> <td width="60%"> The input data was not in the expected format or did not have the expected value. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_OPERATION_TIMED_OUT</b></dt> </dl> </td> <td width="60%"> The
///    operation did not complete within the time allotted. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_PROXY_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access was denied by the HTTP proxy server.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_PROXY_FAILURE</b></dt> </dl> </td> <td width="60%"> The HTTP
///    proxy server could not process the request. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_QUOTA_EXCEEDED</b></dt> </dl> </td> <td width="60%"> A quota was exceeded. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>WS_E_SECURITY_VERIFICATION_FAILURE</b></dt> </dl> </td> <td width="60%"> Security
///    verification was not successful for the received data. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SECURITY_SYSTEM_FAILURE</b></dt> </dl> </td> <td width="60%"> A security operation failed in the
///    Windows Web Services framework. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SECURITY_TOKEN_EXPIRED</b></dt> </dl> </td> <td width="60%"> A security token was rejected by the
///    server because it has expired. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_PROXY_REQUIRES_BASIC_AUTH</b></dt> </dl> </td> <td width="60%"> The HTTP proxy server requires HTTP
///    authentication scheme 'basic'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_PROXY_REQUIRES_DIGEST_AUTH</b></dt> </dl> </td> <td width="60%"> The HTTP proxy server requires HTTP
///    authentication scheme 'digest'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_PROXY_REQUIRES_NEGOTIATE_AUTH</b></dt> </dl> </td> <td width="60%"> The HTTP proxy server requires
///    HTTP authentication scheme 'negotiate'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_PROXY_REQUIRES_NTLM_AUTH</b></dt> </dl> </td> <td width="60%"> The HTTP proxy server requires HTTP
///    authentication scheme 'NTLM'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SERVER_REQUIRES_BASIC_AUTH</b></dt> </dl> </td> <td width="60%"> The remote endpoint requires HTTP
///    authentication scheme 'basic'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SERVER_REQUIRES_DIGEST_AUTH</b></dt> </dl> </td> <td width="60%"> The remote endpoint requires HTTP
///    authentication scheme 'digest'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SERVER_REQUIRES_NEGOTIATE_AUTH</b></dt> </dl> </td> <td width="60%"> The remote endpoint requires
///    HTTP authentication scheme 'negotiate'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SERVER_REQUIRES_NTLM_AUTH</b></dt> </dl> </td> <td width="60%"> The remote endpoint requires HTTP
///    authentication scheme 'NTLM'. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>CERT_E_EXPIRED</b></dt> </dl> </td>
///    <td width="60%"> A required certificate is not within its validity period when verifying against the current
///    system clock or the timestamp in the signed file. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>CERT_E_CN_NO_MATCH</b></dt> </dl> </td> <td width="60%"> The certificates CN name does not match the
///    passed value. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>CERT_E_UNTRUSTEDROOT</b></dt> </dl> </td> <td
///    width="60%"> A certificate chain processed, but terminated in a root certificate which is not trusted by the
///    trust provider. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>CERT_E_WRONG_USAGE</b></dt> </dl> </td> <td
///    width="60%"> The certificate is not valid for the requested usage. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>CRYPT_E_REVOCATION_OFFLINE</b></dt> </dl> </td> <td width="60%"> The revocation function was unable to
///    check revocation because the revocation server was offline. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Ran out of memory. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b> Other Errors </b></dt> </dl> </td> <td width="60%"> This function may return
///    other errors not listed above. </td> </tr> </table>
///    
alias WS_READ_MESSAGE_START_CALLBACK = HRESULT function(void* channelInstance, WS_MESSAGE* message, 
                                                        const(WS_ASYNC_CONTEXT)* asyncContext, WS_ERROR* error);
///Handles the WsReadMessageEnd call for a WS_CUSTOM_CHANNEL_BINDING.
///Params:
///    channelInstance = The pointer to the state specific to this channel instance, as created by the WS_CREATE_CHANNEL_CALLBACK.
///    message = The message to read the end of.
///    asyncContext = Information on how to invoke the function asynchronously, or <b>NULL</b> if invoking synchronously.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_S_ASYNC</b></dt> </dl> </td> <td width="60%"> The asynchronous operation is still pending. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>WS_E_OPERATION_ABORTED</b></dt> </dl> </td> <td width="60%"> The operation was
///    aborted. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_OPERATION</b></dt> </dl> </td> <td
///    width="60%"> The operation is not allowed due to the current state of the object. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>WS_E_ENDPOINT_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The remote endpoint does
///    not exist or could not be located. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_ENDPOINT_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access was denied by the remote
///    endpoint. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_ENDPOINT_DISCONNECTED</b></dt> </dl> </td> <td
///    width="60%"> The connection with the remote endpoint was terminated. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_ENDPOINT_FAILURE</b></dt> </dl> </td> <td width="60%"> The remote endpoint could not process the
///    request. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_ENDPOINT_NOT_AVAILABLE</b></dt> </dl> </td> <td
///    width="60%"> The remote endpoint is not currently in service at this location. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>WS_E_ENDPOINT_TOO_BUSY</b></dt> </dl> </td> <td width="60%"> The remote endpoint is unable to process
///    the request due to being overloaded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_ENDPOINT_UNREACHABLE</b></dt> </dl> </td> <td width="60%"> The remote endpoint was not reachable.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_ENDPOINT_URL</b></dt> </dl> </td> <td width="60%"> The
///    endpoint address URL is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl>
///    </td> <td width="60%"> The input data was not in the expected format or did not have the expected value. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_OPERATION_TIMED_OUT</b></dt> </dl> </td> <td width="60%"> The
///    operation did not complete within the time allotted. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_PROXY_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access was denied by the HTTP proxy server.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_PROXY_FAILURE</b></dt> </dl> </td> <td width="60%"> The HTTP
///    proxy server could not process the request. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_QUOTA_EXCEEDED</b></dt> </dl> </td> <td width="60%"> A quota was exceeded. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>WS_E_SECURITY_VERIFICATION_FAILURE</b></dt> </dl> </td> <td width="60%"> Security
///    verification was not successful for the received data. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SECURITY_SYSTEM_FAILURE</b></dt> </dl> </td> <td width="60%"> A security operation failed in the
///    Windows Web Services framework. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SECURITY_TOKEN_EXPIRED</b></dt> </dl> </td> <td width="60%"> A security token was rejected by the
///    server because it has expired. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_PROXY_REQUIRES_BASIC_AUTH</b></dt> </dl> </td> <td width="60%"> The HTTP proxy server requires HTTP
///    authentication scheme 'basic'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_PROXY_REQUIRES_DIGEST_AUTH</b></dt> </dl> </td> <td width="60%"> The HTTP proxy server requires HTTP
///    authentication scheme 'digest'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_PROXY_REQUIRES_NEGOTIATE_AUTH</b></dt> </dl> </td> <td width="60%"> The HTTP proxy server requires
///    HTTP authentication scheme 'negotiate'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_PROXY_REQUIRES_NTLM_AUTH</b></dt> </dl> </td> <td width="60%"> The HTTP proxy server requires HTTP
///    authentication scheme 'NTLM'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SERVER_REQUIRES_BASIC_AUTH</b></dt> </dl> </td> <td width="60%"> The remote endpoint requires HTTP
///    authentication scheme 'basic'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SERVER_REQUIRES_DIGEST_AUTH</b></dt> </dl> </td> <td width="60%"> The remote endpoint requires HTTP
///    authentication scheme 'digest'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SERVER_REQUIRES_NEGOTIATE_AUTH</b></dt> </dl> </td> <td width="60%"> The remote endpoint requires
///    HTTP authentication scheme 'negotiate'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SERVER_REQUIRES_NTLM_AUTH</b></dt> </dl> </td> <td width="60%"> The remote endpoint requires HTTP
///    authentication scheme 'NTLM'. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_SECURITY_SYSTEM_FAILURE</b></dt>
///    </dl> </td> <td width="60%"> A security operation failed in the Windows Web Services framework. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>WS_E_SECURITY_TOKEN_EXPIRED</b></dt> </dl> </td> <td width="60%"> A security token
///    was rejected by the server because it has expired. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Ran out of memory. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b> Other Errors </b></dt> </dl> </td> <td width="60%"> This function may return
///    other errors not listed above. </td> </tr> </table>
///    
alias WS_READ_MESSAGE_END_CALLBACK = HRESULT function(void* channelInstance, WS_MESSAGE* message, 
                                                      const(WS_ASYNC_CONTEXT)* asyncContext, WS_ERROR* error);
///Handles the WsWriteMessageStart call for a WS_CUSTOM_CHANNEL_BINDING.
///Params:
///    channelInstance = The pointer to the state specific to this channel instance, as created by the WS_CREATE_CHANNEL_CALLBACK.
///    message = The message to write.
///    asyncContext = Information on how to invoke the function asynchronously, or <b>NULL</b> if invoking synchronously.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_S_ASYNC</b></dt> </dl> </td> <td width="60%"> The asynchronous operation is still pending. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>WS_E_OPERATION_ABORTED</b></dt> </dl> </td> <td width="60%"> The operation was
///    aborted. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_OPERATION</b></dt> </dl> </td> <td
///    width="60%"> The operation is not allowed due to the current state of the object. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>WS_E_ENDPOINT_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The remote endpoint does
///    not exist or could not be located. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_ENDPOINT_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access was denied by the remote
///    endpoint. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_ENDPOINT_DISCONNECTED</b></dt> </dl> </td> <td
///    width="60%"> The connection with the remote endpoint was terminated. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_ENDPOINT_FAILURE</b></dt> </dl> </td> <td width="60%"> The remote endpoint could not process the
///    request. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_ENDPOINT_NOT_AVAILABLE</b></dt> </dl> </td> <td
///    width="60%"> The remote endpoint is not currently in service at this location. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>WS_E_ENDPOINT_TOO_BUSY</b></dt> </dl> </td> <td width="60%"> The remote endpoint is unable to process
///    the request due to being overloaded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_ENDPOINT_UNREACHABLE</b></dt> </dl> </td> <td width="60%"> The remote endpoint was not reachable.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_ENDPOINT_URL</b></dt> </dl> </td> <td width="60%"> The
///    endpoint address URL is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl>
///    </td> <td width="60%"> The input data was not in the expected format or did not have the expected value. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_OPERATION_TIMED_OUT</b></dt> </dl> </td> <td width="60%"> The
///    operation did not complete within the time allotted. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_PROXY_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access was denied by the HTTP proxy server.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_PROXY_FAILURE</b></dt> </dl> </td> <td width="60%"> The HTTP
///    proxy server could not process the request. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_QUOTA_EXCEEDED</b></dt> </dl> </td> <td width="60%"> A quota was exceeded. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>WS_E_SECURITY_VERIFICATION_FAILURE</b></dt> </dl> </td> <td width="60%"> Security
///    verification was not successful for the received data. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SECURITY_SYSTEM_FAILURE</b></dt> </dl> </td> <td width="60%"> A security operation failed in the
///    Windows Web Services framework. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SECURITY_TOKEN_EXPIRED</b></dt> </dl> </td> <td width="60%"> A security token was rejected by the
///    server because it has expired. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_PROXY_REQUIRES_BASIC_AUTH</b></dt> </dl> </td> <td width="60%"> The HTTP proxy server requires HTTP
///    authentication scheme 'basic'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_PROXY_REQUIRES_DIGEST_AUTH</b></dt> </dl> </td> <td width="60%"> The HTTP proxy server requires HTTP
///    authentication scheme 'digest'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_PROXY_REQUIRES_NEGOTIATE_AUTH</b></dt> </dl> </td> <td width="60%"> The HTTP proxy server requires
///    HTTP authentication scheme 'negotiate'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_PROXY_REQUIRES_NTLM_AUTH</b></dt> </dl> </td> <td width="60%"> The HTTP proxy server requires HTTP
///    authentication scheme 'NTLM'. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>CERT_E_EXPIRED</b></dt> </dl> </td>
///    <td width="60%"> A required certificate is not within its validity period when verifying against the current
///    system clock or the timestamp in the signed file. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>CERT_E_CN_NO_MATCH</b></dt> </dl> </td> <td width="60%"> The certificates CN name does not match the
///    passed value. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>CERT_E_UNTRUSTEDROOT</b></dt> </dl> </td> <td
///    width="60%"> A certificate chain processed, but terminated in a root certificate which is not trusted by the
///    trust provider. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>CERT_E_WRONG_USAGE</b></dt> </dl> </td> <td
///    width="60%"> The certificate is not valid for the requested usage. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>CRYPT_E_REVOCATION_OFFLINE</b></dt> </dl> </td> <td width="60%"> The revocation function was unable to
///    check revocation because the revocation server was offline. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SERVER_REQUIRES_BASIC_AUTH</b></dt> </dl> </td> <td width="60%"> The remote endpoint requires HTTP
///    authentication scheme 'basic'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SERVER_REQUIRES_DIGEST_AUTH</b></dt> </dl> </td> <td width="60%"> The remote endpoint requires HTTP
///    authentication scheme 'digest'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SERVER_REQUIRES_NEGOTIATE_AUTH</b></dt> </dl> </td> <td width="60%"> The remote endpoint requires
///    HTTP authentication scheme 'negotiate'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SERVER_REQUIRES_NTLM_AUTH</b></dt> </dl> </td> <td width="60%"> The remote endpoint requires HTTP
///    authentication scheme 'NTLM'. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td>
///    <td width="60%"> Ran out of memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
///    </td> <td width="60%"> One or more arguments are invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b> Other
///    Errors </b></dt> </dl> </td> <td width="60%"> This function may return other errors not listed above. </td> </tr>
///    </table>
///    
alias WS_WRITE_MESSAGE_START_CALLBACK = HRESULT function(void* channelInstance, WS_MESSAGE* message, 
                                                         const(WS_ASYNC_CONTEXT)* asyncContext, WS_ERROR* error);
///Handles the WsWriteMessageEnd call for a WS_CUSTOM_CHANNEL_BINDING.
///Params:
///    channelInstance = The pointer to the state specific to this channel instance, as created by the WS_CREATE_CHANNEL_CALLBACK.
///    message = The message to write.
///    asyncContext = Information on how to invoke the function asynchronously, or <b>NULL</b> if invoking synchronously.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_S_ASYNC</b></dt> </dl> </td> <td width="60%"> The asynchronous operation is still pending. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>WS_E_OPERATION_ABORTED</b></dt> </dl> </td> <td width="60%"> The operation was
///    aborted. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_OPERATION</b></dt> </dl> </td> <td
///    width="60%"> The operation is not allowed due to the current state of the object. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>WS_E_ENDPOINT_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The remote endpoint does
///    not exist or could not be located. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_ENDPOINT_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access was denied by the remote
///    endpoint. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_ENDPOINT_DISCONNECTED</b></dt> </dl> </td> <td
///    width="60%"> The connection with the remote endpoint was terminated. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_ENDPOINT_FAILURE</b></dt> </dl> </td> <td width="60%"> The remote endpoint could not process the
///    request. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_ENDPOINT_NOT_AVAILABLE</b></dt> </dl> </td> <td
///    width="60%"> The remote endpoint is not currently in service at this location. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>WS_E_ENDPOINT_TOO_BUSY</b></dt> </dl> </td> <td width="60%"> The remote endpoint is unable to process
///    the request due to being overloaded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_ENDPOINT_UNREACHABLE</b></dt> </dl> </td> <td width="60%"> The remote endpoint was not reachable.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_ENDPOINT_URL</b></dt> </dl> </td> <td width="60%"> The
///    endpoint address URL is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl>
///    </td> <td width="60%"> The input data was not in the expected format or did not have the expected value. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_OPERATION_TIMED_OUT</b></dt> </dl> </td> <td width="60%"> The
///    operation did not complete within the time allotted. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_PROXY_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access was denied by the HTTP proxy server.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_PROXY_FAILURE</b></dt> </dl> </td> <td width="60%"> The HTTP
///    proxy server could not process the request. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_QUOTA_EXCEEDED</b></dt> </dl> </td> <td width="60%"> A quota was exceeded. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>WS_E_SECURITY_VERIFICATION_FAILURE</b></dt> </dl> </td> <td width="60%"> Security
///    verification was not successful for the received data. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SECURITY_SYSTEM_FAILURE</b></dt> </dl> </td> <td width="60%"> A security operation failed in the
///    Windows Web Services framework. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SECURITY_TOKEN_EXPIRED</b></dt> </dl> </td> <td width="60%"> A security token was rejected by the
///    server because it has expired. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_PROXY_REQUIRES_BASIC_AUTH</b></dt> </dl> </td> <td width="60%"> The HTTP proxy server requires HTTP
///    authentication scheme 'basic'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_PROXY_REQUIRES_DIGEST_AUTH</b></dt> </dl> </td> <td width="60%"> The HTTP proxy server requires HTTP
///    authentication scheme 'digest'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_PROXY_REQUIRES_NEGOTIATE_AUTH</b></dt> </dl> </td> <td width="60%"> The HTTP proxy server requires
///    HTTP authentication scheme 'negotiate'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_PROXY_REQUIRES_NTLM_AUTH</b></dt> </dl> </td> <td width="60%"> The HTTP proxy server requires HTTP
///    authentication scheme 'NTLM'. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>CERT_E_EXPIRED</b></dt> </dl> </td>
///    <td width="60%"> A required certificate is not within its validity period when verifying against the current
///    system clock or the timestamp in the signed file. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>CERT_E_CN_NO_MATCH</b></dt> </dl> </td> <td width="60%"> The certificates CN name does not match the
///    passed value. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>CERT_E_UNTRUSTEDROOT</b></dt> </dl> </td> <td
///    width="60%"> A certificate chain processed, but terminated in a root certificate which is not trusted by the
///    trust provider. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>CERT_E_WRONG_USAGE</b></dt> </dl> </td> <td
///    width="60%"> The certificate is not valid for the requested usage. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>CRYPT_E_REVOCATION_OFFLINE</b></dt> </dl> </td> <td width="60%"> The revocation function was unable to
///    check revocation because the revocation server was offline. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SERVER_REQUIRES_BASIC_AUTH</b></dt> </dl> </td> <td width="60%"> The remote endpoint requires HTTP
///    authentication scheme 'basic'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SERVER_REQUIRES_DIGEST_AUTH</b></dt> </dl> </td> <td width="60%"> The remote endpoint requires HTTP
///    authentication scheme 'digest'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SERVER_REQUIRES_NEGOTIATE_AUTH</b></dt> </dl> </td> <td width="60%"> The remote endpoint requires
///    HTTP authentication scheme 'negotiate'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SERVER_REQUIRES_NTLM_AUTH</b></dt> </dl> </td> <td width="60%"> The remote endpoint requires HTTP
///    authentication scheme 'NTLM'. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td>
///    <td width="60%"> Ran out of memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
///    </td> <td width="60%"> One or more arguments are invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b> Other
///    Errors </b></dt> </dl> </td> <td width="60%"> This function may return other errors not listed above. </td> </tr>
///    </table>
///    
alias WS_WRITE_MESSAGE_END_CALLBACK = HRESULT function(void* channelInstance, WS_MESSAGE* message, 
                                                       const(WS_ASYNC_CONTEXT)* asyncContext, WS_ERROR* error);
///Handles the WsAbandonMessage call for a WS_CUSTOM_CHANNEL_BINDING.
///Params:
///    channelInstance = Pointer to the state specific to this channel instance, as created by the WS_CREATE_CHANNEL_CALLBACK.
///    message = The message that is current being read or written. This should be the same message as was passed to
///              WsWriteMessageStartor WsReadMessageStart.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_INVALID_OPERATION</b></dt> </dl> </td> <td width="60%"> This is returned if the channel is not in the
///    WS_CHANNEL_STATE_OPENstate or the <b>WS_CHANNEL_STATE_FAULTED</b> state. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The specified message is not currently being read or
///    written using the channel. </td> </tr> </table>
///    
alias WS_ABANDON_MESSAGE_CALLBACK = HRESULT function(void* channelInstance, WS_MESSAGE* message, WS_ERROR* error);
///Handles the WsShutdownSessionChannel call for a WS_CUSTOM_CHANNEL_BINDING.
///Params:
///    channelInstance = The pointer to the state specific to this channel instance, as created by the WS_CREATE_CHANNEL_CALLBACK.
///    asyncContext = Information on how to invoke the function asynchronously, or <b>NULL</b> if invoking synchronously.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_INVALID_OPERATION</b></dt> </dl> </td> <td width="60%"> This is returned if the channel is not in the
///    WS_CHANNEL_STATE_OPEN state. </td> </tr> </table>
///    
alias WS_SHUTDOWN_SESSION_CHANNEL_CALLBACK = HRESULT function(void* channelInstance, 
                                                              const(WS_ASYNC_CONTEXT)* asyncContext, WS_ERROR* error);
///Handles creating an encoder instance.
///Params:
///    createContext = The createContext that was specified in the WS_CHANNEL_ENCODERused during channel creation.
///    writeCallback = The function that should be used to write the message data. This callback should only be used in response to the
///                    WS_ENCODER_START_CALLBACK, WS_ENCODER_ENCODE_CALLBACK and WS_ENCODER_END_CALLBACKcallbacks.
///    writeContext = The write context that should be passed to the provided WS_WRITE_CALLBACK.
///    error = Specifies where additional error information should be stored if the function fails.
///    encoderContext = Returns the encoder instance. This value will be passed to all of the encoder callbacks.
///Returns:
///    This callback function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Ran out of memory.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more
///    arguments are invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b> Other Errors </b></dt> </dl> </td> <td
///    width="60%"> This function may return other errors not listed above. </td> </tr> </table>
///    
alias WS_CREATE_ENCODER_CALLBACK = HRESULT function(void* createContext, WS_WRITE_CALLBACK writeCallback, 
                                                    void* writeContext, void** encoderContext, WS_ERROR* error);
///Gets the content type of the message.
///Params:
///    encoderContext = The encoder instance returned by the WS_CREATE_ENCODER_CALLBACK.
///    contentType = The content type of the encoded message.
///    newContentType = The callback should return the content type for the newly encoded message here.
///    contentEncoding = The callback should return the content encoding for the encoded message here.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Ran out of memory. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b> Other Errors </b></dt> </dl> </td> <td width="60%"> This function may return
///    other errors not listed above. </td> </tr> </table>
///    
alias WS_ENCODER_GET_CONTENT_TYPE_CALLBACK = HRESULT function(void* encoderContext, const(WS_STRING)* contentType, 
                                                              WS_STRING* newContentType, WS_STRING* contentEncoding, 
                                                              WS_ERROR* error);
///Starts encoding a message.
///Params:
///    encoderContext = The encoder instance returned by the WS_CREATE_ENCODER_CALLBACK.
///    asyncContext = Information on how to invoke the function asynchronously, or <b>NULL</b> if invoking synchronously.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Ran out of memory. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b> Other Errors </b></dt> </dl> </td> <td width="60%"> This function may return
///    other errors not listed above. </td> </tr> </table>
///    
alias WS_ENCODER_START_CALLBACK = HRESULT function(void* encoderContext, const(WS_ASYNC_CONTEXT)* asyncContext, 
                                                   WS_ERROR* error);
///Encodes a message.
///Params:
///    encoderContext = The encoder instance returned by the WS_CREATE_ENCODER_CALLBACK.
///    buffers = The buffers of data to write.
///    count = The number of buffers to write.
///    asyncContext = Information on how to invoke the function asynchronously, or NULL if invoking synchronously.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Ran out of memory. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b> Other Errors </b></dt> </dl> </td> <td width="60%"> This function may return
///    other errors not listed above. </td> </tr> </table>
///    
alias WS_ENCODER_ENCODE_CALLBACK = HRESULT function(void* encoderContext, const(WS_BYTES)* buffers, uint count, 
                                                    const(WS_ASYNC_CONTEXT)* asyncContext, WS_ERROR* error);
///Encodes the end of a message.
///Params:
///    encoderContext = The encoder instance returned by the WS_CREATE_ENCODER_CALLBACK.
///    asyncContext = Information on how to invoke the function asynchronously, or <b>NULL</b> if the function is invoked
///                   synchronously.
///    error = Where additional error information should be stored if the function fails.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Ran out of memory. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b> Other Errors </b></dt> </dl> </td> <td width="60%"> This function may return
///    other errors not listed above. </td> </tr> </table>
///    
alias WS_ENCODER_END_CALLBACK = HRESULT function(void* encoderContext, const(WS_ASYNC_CONTEXT)* asyncContext, 
                                                 WS_ERROR* error);
///Handles freeing an encoder instance.
///Params:
///    encoderContext = Frees an instance of an encoder.
alias WS_FREE_ENCODER_CALLBACK = void function(void* encoderContext);
///Handles creating an decoder instance.
///Params:
///    createContext = The createContext that was specified in the WS_CHANNEL_DECODERused during channel creation.
///    readCallback = The function that should be used to read the message data. This callback should only be used in response to the
///                   WS_DECODER_START_CALLBACK, WS_DECODER_DECODE_CALLBACK and WS_DECODER_END_CALLBACK callbacks.
///    readContext = The read context that should be passed to the provided WS_READ_CALLBACK.
///    error = Specifies where additional error information should be stored if the function fails.
///    decoderContext = Returns the decoder instance. This value will be passed to all of the decoder callbacks.
///Returns:
///    This callback function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Ran out of memory.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more
///    arguments are invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b> Other Errors </b></dt> </dl> </td> <td
///    width="60%"> This function may return other errors not listed above. </td> </tr> </table>
///    
alias WS_CREATE_DECODER_CALLBACK = HRESULT function(void* createContext, WS_READ_CALLBACK readCallback, 
                                                    void* readContext, void** decoderContext, WS_ERROR* error);
///Gets the content type of the message.
///Params:
///    decoderContext = The encoder instance returned by the WS_CREATE_DECODER_CALLBACK.
///    contentType = The content type of the encoded message.
///    contentEncoding = The content encoding for the encoded message.
///    newContentType = The callback should return the content type for the newly decoded message here.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Ran out of memory. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b> Other Errors </b></dt> </dl> </td> <td width="60%"> This function may return
///    other errors not listed above. </td> </tr> </table>
///    
alias WS_DECODER_GET_CONTENT_TYPE_CALLBACK = HRESULT function(void* decoderContext, const(WS_STRING)* contentType, 
                                                              const(WS_STRING)* contentEncoding, 
                                                              WS_STRING* newContentType, WS_ERROR* error);
///Starts decoding a message.
///Params:
///    encoderContext = The decoder instance returned by the WS_CREATE_DECODER_CALLBACK.
///    asyncContext = Information on how to invoke the function asynchronously, or <b>NULL</b> if invoking synchronously.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Ran out of memory. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b> Other Errors </b></dt> </dl> </td> <td width="60%"> This function may return
///    other errors not listed above. </td> </tr> </table>
///    
alias WS_DECODER_START_CALLBACK = HRESULT function(void* encoderContext, const(WS_ASYNC_CONTEXT)* asyncContext, 
                                                   WS_ERROR* error);
///Decodes a message.
///Params:
///    encoderContext = The decoder instance returned by the WS_CREATE_DECODER_CALLBACK.
///    buffer = The buffer to read into.
///    maxLength = The maximum number of bytes to read.
///    length = The number of bytes read should be returned here. The number of bytes should be set to 0 when there are no more
///             bytes left. This indicates the end of the decoded message data, and will cause WS_DECODER_END_CALLBACK to be
///             invoked.
///    asyncContext = Information on how to invoke the function asynchronously, or <b>NULL</b> if invoking synchronously.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Ran out of memory. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b> Other Errors </b></dt> </dl> </td> <td width="60%"> This function may return
///    other errors not listed above. </td> </tr> </table>
///    
alias WS_DECODER_DECODE_CALLBACK = HRESULT function(void* encoderContext, void* buffer, uint maxLength, 
                                                    uint* length, const(WS_ASYNC_CONTEXT)* asyncContext, 
                                                    WS_ERROR* error);
///Decodes the end of a message.
///Params:
///    encoderContext = The decoder instance returned by the WS_CREATE_DECODER_CALLBACK.
///    asyncContext = Information on how to invoke the function asynchronously, or <b>NULL</b> if invoking synchronously.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Ran out of memory. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b> Other Errors </b></dt> </dl> </td> <td width="60%"> This function may return
///    other errors not listed above. </td> </tr> </table>
///    
alias WS_DECODER_END_CALLBACK = HRESULT function(void* encoderContext, const(WS_ASYNC_CONTEXT)* asyncContext, 
                                                 WS_ERROR* error);
///Handles freeing a decoder instance.
///Params:
///    decoderContext = Frees an instance of an decoder.
alias WS_FREE_DECODER_CALLBACK = void function(void* decoderContext);
///Invoked when a message is about to be automatically redirected to another service utilizing HTTP auto redirect
///functionality as described in RFC2616. If the redirection should not be allowed, this callback should return S_FALSE
///or an error value. Otherwise the auto HTTP redirection will proceed.
///Params:
///    state = The 'state' as specified as part of WS_HTTP_REDIRECT_CALLBACK_CONTEXT 'state' field.
///    originalUrl = The original endpoint URL that the message was sent to.
///    newUrl = The endpoint URL that the message is about to be forwarded to.
///Returns:
///    This callback function does not return a value.
///    
alias WS_HTTP_REDIRECT_CALLBACK = HRESULT function(void* state, const(WS_STRING)* originalUrl, 
                                                   const(WS_STRING)* newUrl);
///Handles the WsCreateListener call for a WS_CUSTOM_CHANNEL_BINDING.
///Params:
///    channelType = The type of channel the listener listens for.
///    listenerParameters = The pointer to the value that was specified by the WS_LISTENER_PROPERTY_CUSTOM_LISTENER_PARAMETERSproperty when
///                         the custom listener is created using WsCreateListener. If the
///                         WS_LISTENER_PROPERTY_CUSTOM_LISTENER_PARAMETERSproperty was not specified, the value will be <b>NULL</b>.
///    listenerParametersSize = The size in bytes of the value pointed to by listenerParameters. If the
///                             WS_LISTENER_PROPERTY_CUSTOM_LISTENER_PARAMETERSproperty was not specified, the size will be 0.
///    error = Specifies where additional error information should be stored if the function fails.
///    listenerInstance = A pointer to an allocated structure that represents the listener instance. This pointer will be passed to all the
///                       other listener callbacks for this particular listener instance. If this callback is successful, then the
///                       WS_FREE_LISTENER_CALLBACKwill be used to free the listener instance.
alias WS_CREATE_LISTENER_CALLBACK = HRESULT function(WS_CHANNEL_TYPE channelType, const(void)* listenerParameters, 
                                                     uint listenerParametersSize, void** listenerInstance, 
                                                     WS_ERROR* error);
///Handles the WsFreeListener call for a WS_CUSTOM_CHANNEL_BINDING.
///Params:
///    listenerInstance = The pointer to the state specific to this listener instance, as created by the WS_CREATE_LISTENER_CALLBACK. The
///                       callback should free this pointer.
alias WS_FREE_LISTENER_CALLBACK = void function(void* listenerInstance);
///Handles the WsResetListener call for a WS_CUSTOM_CHANNEL_BINDING.
///Params:
///    listenerInstance = The pointer to the state specific to this listener instance, as created by the WS_CREATE_LISTENER_CALLBACK.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_INVALID_OPERATION</b></dt> </dl> </td> <td width="60%"> The listener was in an inappropriate state.
///    </td> </tr> </table>
///    
alias WS_RESET_LISTENER_CALLBACK = HRESULT function(void* listenerInstance, WS_ERROR* error);
///Handles the WsOpenListener call for a WS_CUSTOM_CHANNEL_BINDING.
///Params:
///    listenerInstance = The pointer to the state specific to this listener instance, as created by the WS_CREATE_LISTENER_CALLBACK.
///    url = The URL to listen on. The format and interpretation of the URL is defined by the custom listener.
///    asyncContext = Information on how to invoke the function asynchronously, or <b>NULL</b> if invoking synchronously.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_S_ASYNC</b></dt> </dl> </td> <td width="60%"> The asynchronous operation is still pending. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>WS_E_OPERATION_ABORTED</b></dt> </dl> </td> <td width="60%"> The listener was
///    aborted during the open, or before the open. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_INVALID_OPERATION</b></dt> </dl> </td> <td width="60%"> The listener is in the incorrect state. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_ADDRESS_IN_USE</b></dt> </dl> </td> <td width="60%"> The address is
///    already being used. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_ADDRESS_NOT_AVAILABLE</b></dt> </dl> </td>
///    <td width="60%"> The address is not valid for this context. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_QUOTA_EXCEEDED</b></dt> </dl> </td> <td width="60%"> A quota was exceeded. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>WS_E_OPERATION_ABORTED</b></dt> </dl> </td> <td width="60%"> The operation was aborted.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_OPERATION_TIMED_OUT</b></dt> </dl> </td> <td width="60%"> The
///    operation did not complete within the time allotted. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Ran out of memory. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b> Other Errors </b></dt> </dl> </td> <td width="60%"> This function may return
///    other errors not listed above. </td> </tr> </table>
///    
alias WS_OPEN_LISTENER_CALLBACK = HRESULT function(void* listenerInstance, const(WS_STRING)* url, 
                                                   const(WS_ASYNC_CONTEXT)* asyncContext, WS_ERROR* error);
///Handles the WsCloseListener call for a WS_CUSTOM_CHANNEL_BINDING.
///Params:
///    listenerInstance = The pointer to the state specific to this listener instance, as created by the WS_CREATE_LISTENER_CALLBACK.
///    asyncContext = Information on how to invoke the function asynchronously, or <b>NULL</b> if invoking synchronously.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_S_ASYNC</b></dt> </dl> </td> <td width="60%"> The asynchronous operation is still pending. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>WS_E_OPERATION_ABORTED</b></dt> </dl> </td> <td width="60%"> The close was
///    aborted by a call to WsAbortListener as it was closing. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_INVALID_OPERATION</b></dt> </dl> </td> <td width="60%"> The listener was in an inappropriate state.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_OPERATION_TIMED_OUT</b></dt> </dl> </td> <td width="60%"> The
///    operation did not complete within the time allotted. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are invalid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b> Other Errors </b></dt> </dl> </td> <td width="60%"> This function may return other
///    errors not listed above. </td> </tr> </table>
///    
alias WS_CLOSE_LISTENER_CALLBACK = HRESULT function(void* listenerInstance, const(WS_ASYNC_CONTEXT)* asyncContext, 
                                                    WS_ERROR* error);
///Handles the WsGetListenerProperty call for a WS_CUSTOM_CHANNEL_BINDING.
///Params:
///    listenerInstance = The pointer to the state specific to this listener instance, as created by the WS_CREATE_LISTENER_CALLBACK.
///    id = The id of the property to retrieve. A custom listener can decide which properties to support.
///    value = The location to store the retrieved property. The pointer must have an alignment compatible with the type of the
///            property.
///    valueSize = The number of bytes allocated by the caller to store the retrieved property.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The property id was not supported for this object or
///    the specified buffer was not large enough for the value. </td> </tr> <tr> <td width="40%"> <dl> <dt><b> Other
///    Errors </b></dt> </dl> </td> <td width="60%"> This function may return other errors not listed above. </td> </tr>
///    </table>
///    
alias WS_GET_LISTENER_PROPERTY_CALLBACK = HRESULT function(void* listenerInstance, WS_LISTENER_PROPERTY_ID id, 
                                                           void* value, uint valueSize, WS_ERROR* error);
///Handles the WsSetListenerProperty call for a WS_CUSTOM_CHANNEL_BINDING.
///Params:
///    listenerInstance = The pointer to the state specific to this listener instance, as created by the WS_CREATE_LISTENER_CALLBACK.
///    id = The id of the property to set. A custom listener can decide which properties to support.
///    value = The pointer to the property value to set. The pointer must have an alignment compatible with the type of the
///            property.
///    valueSize = The size of of the property value.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The property id was not supported for this object. The
///    specified size was not appropriate for the property. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There was not enough space to set the property value.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b> Other Errors </b></dt> </dl> </td> <td width="60%"> This function
///    may return other errors not listed above. </td> </tr> </table>
///    
alias WS_SET_LISTENER_PROPERTY_CALLBACK = HRESULT function(void* listenerInstance, WS_LISTENER_PROPERTY_ID id, 
                                                           const(void)* value, uint valueSize, WS_ERROR* error);
///Handles the WsAcceptChannel call for a WS_CUSTOM_CHANNEL_BINDING.
///Params:
///    listenerInstance = The pointer to the state specific to this listener instance, as created by the WS_CREATE_LISTENER_CALLBACK.
///    channelInstance = The pointer to the state specific to the channel instance, as created by the WS_CREATE_CHANNEL_CALLBACKwhen
///                      WsCreateChannelForListener was called.
///    asyncContext = Information on how to invoke the function asynchronously, or NULL if invoking synchronously.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_S_ASYNC</b></dt> </dl> </td> <td width="60%"> The asynchronous operation is still pending. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>WS_E_OPERATION_ABORTED</b></dt> </dl> </td> <td width="60%"> The listener
///    and/or channel was aborted. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_OBJECT_FAULTED</b></dt> </dl>
///    </td> <td width="60%"> The listener has faulted. Once a listener has faulted, then accepts will immediately
///    return this error. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_OPERATION</b></dt> </dl> </td> <td
///    width="60%"> The listener was in an inappropriate state. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_ENDPOINT_DISCONNECTED</b></dt> </dl> </td> <td width="60%"> The connection with the remote endpoint
///    was terminated. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_OPERATION_TIMED_OUT</b></dt> </dl> </td> <td
///    width="60%"> The operation did not complete within the time allotted. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_QUOTA_EXCEEDED</b></dt> </dl> </td> <td width="60%"> A quota was exceeded. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl> </td> <td width="60%"> The input data was not in the
///    expected format or did not have the expected value. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Ran out of memory. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>WS_E_SECURITY_VERIFICATION_FAILURE</b></dt> </dl> </td> <td width="60%">
///    Security verification was not successful for the received data. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SECURITY_SYSTEM_FAILURE</b></dt> </dl> </td> <td width="60%"> A security operation failed in the
///    Windows Web Services framework. </td> </tr> <tr> <td width="40%"> <dl> <dt><b> Other Errors </b></dt> </dl> </td>
///    <td width="60%"> This function may return other errors not listed above. </td> </tr> </table>
///    
alias WS_ACCEPT_CHANNEL_CALLBACK = HRESULT function(void* listenerInstance, void* channelInstance, 
                                                    const(WS_ASYNC_CONTEXT)* asyncContext, WS_ERROR* error);
///Handles the WsAbortListener call for a WS_CUSTOM_CHANNEL_BINDING.
///Params:
///    listenerInstance = The pointer to the state specific to this listener instance, as created by the WS_CREATE_LISTENER_CALLBACK.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_INVALID_OPERATION</b></dt> </dl> </td> <td width="60%"> The listener was in an inappropriate state.
///    </td> </tr> </table>
///    
alias WS_ABORT_LISTENER_CALLBACK = HRESULT function(void* listenerInstance, WS_ERROR* error);
///Handles the WsCreateChannelForListener call for a WS_CUSTOM_CHANNEL_BINDING.
///Params:
///    listenerInstance = The pointer to the state specific to this listener instance, as created by the WS_CREATE_LISTENER_CALLBACK.
///    channelParameters = The pointer to the value that was specified by the WS_CHANNEL_PROPERTY_CUSTOM_CHANNEL_PARAMETERSproperty when the
///                        custom channel is created using WsCreateChannelForListener. If the
///                        WS_CHANNEL_PROPERTY_CUSTOM_CHANNEL_PARAMETERSproperty was not specified, the value will be <b>NULL</b>.
///    channelParametersSize = The size in bytes of the value pointed to by channelParameters. If the
///                            WS_CHANNEL_PROPERTY_CUSTOM_CHANNEL_PARAMETERSproperty was not specified, the size will be 0.
///    error = Specifies where additional error information should be stored if the function fails.
///    channelInstance = A pointer to an structure allocated by the callback that contains the data specific to this channel instance.
///                      This pointer will be passed to all the other channel callbacks for this particular channel instance. If this
///                      callback is successful, then the WS_FREE_CHANNEL_CALLBACKwill be used to free the channel instance returned in
///                      this parameter.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are invalid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Ran out of memory. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b> Other Errors </b></dt> </dl> </td> <td width="60%"> This function may return other
///    errors not listed above. </td> </tr> </table>
///    
alias WS_CREATE_CHANNEL_FOR_LISTENER_CALLBACK = HRESULT function(void* listenerInstance, 
                                                                 const(void)* channelParameters, 
                                                                 uint channelParametersSize, void** channelInstance, 
                                                                 WS_ERROR* error);
///Notifies the caller that the message has completed its use of either the WS_XML_READER structure that was supplied to
///WsReadEnvelopeStartfunction, or of the WS_XML_WRITER structure supplied to the WsWriteEnvelopeStart function.
///Params:
///    doneCallbackState = A pointer to <b>state</b> information passed to the WsReadEnvelopeStart or WsWriteEnvelopeStart function. This
///                        parameter can be used to specify a pointer to user-defined data required by the callback.
alias WS_MESSAGE_DONE_CALLBACK = void function(void* doneCallbackState);
///The <i>WS_CERTIFICATE_VALIDATION_CALLBACK</i> callback is invoked to validate a certificate when a connection to an
///HTTP server has been established and headers sent.
///Params:
///    certContext = A pointer to a CERT_CONTEXT structure that is associated with the connection. Applications must free this
///                  structure using CertFreeCertificateContext.
///    state = A pointer to application specific state information. This parameter corresponds to the <b>state</b> member of the
///            WS_CERTIFICATE_VALIDATION_CALLBACK_CONTEXT structure.
///Returns:
///    This callback function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The certificate validated
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b> Other Errors </b></dt> </dl> </td> <td width="60%">
///    This function may return other errors not listed above. </td> </tr> </table>
///    
alias WS_CERTIFICATE_VALIDATION_CALLBACK = HRESULT function(CERT_CONTEXT* certContext, void* state);
///Provides a certificate to the security runtime. This callback is specified as part of the WS_CUSTOM_CERT_CREDENTIAL,
///which in turn may be specified as part of a security binding that requires a certificate credential. The runtime will
///invoke this callback when the channel (client-side) or the listener (server-side) is opened. Cert ownership: If this
///callback returns a success HRESULT, the caller (namely, the security runtime) will take ownership of the returned
///certificate, and will free it when the containing channel no longer needs it. If this callback returns a failure
///HRESULT, the caller will NOT take ownership of, or even look at, the value returned in the out parameter 'cert'.
///Params:
///    getCertCallbackState = State that was specified along with this callback in the certificate credential.
///    targetAddress = The target address to whom this certificate is to be presented, in case this certificate credential is specified
///                    for a client.
///    viaUri = The via address to whom this certificate is to be presented.
///    error = Specifies where additional error information should be stored if the function fails.
///    cert = The location to return the certificate.
alias WS_GET_CERT_CALLBACK = HRESULT function(void* getCertCallbackState, 
                                              const(WS_ENDPOINT_ADDRESS)* targetAddress, const(WS_STRING)* viaUri, 
                                              const(CERT_CONTEXT)** cert, WS_ERROR* error);
///Notifies the client of the list of certificate issuers that are acceptable to the server. With some protocols such as
///SSL, the server may optionally send such an issuer list to help the client choose a certificate. This callback is an
///optional part of the WS_CUSTOM_CERT_CREDENTIAL. If the (possibly <b>NULL</b>) certificate returned by the
///WS_GET_CERT_CALLBACK is accepted by the server, then this callback is never invoked. If the server rejects it and
///sends back an issuer list, then this callback will be invoked. The client may then choose a certificate based on the
///issuer list and supply that certificate when the channel is opened next and <i>WS_GET_CERT_CALLBACK</i> is invoked
///again. The parameters supplied during this callback are valid only for the duration of the callback.
///Params:
///    certIssuerListNotificationCallbackState = State that was specified along with this callback in the WS_CUSTOM_CERT_CREDENTIAL.
///    issuerList = The list of certificate issuers acceptable to the server.
///    error = Specifies where additional error information should be stored if the function fails.
alias WS_CERT_ISSUER_LIST_NOTIFICATION_CALLBACK = HRESULT function(void* certIssuerListNotificationCallbackState, 
                                                                   const(SecPkgContext_IssuerListInfoEx)* issuerList, 
                                                                   WS_ERROR* error);
///Validates a username/password pair on the receiver side. When a WS_USERNAME_MESSAGE_SECURITY_BINDING containing this
///callback is included in the security description, this callback is invoked for each received message at the server.
///This callback is expected to return S_OKif the username/password pair was successfully validated, S_FALSE when the
///pair could not be validated and an error value if an unexpected error occurred. Returning any result other than S_OK
///from this callback will result in the associated receive message failing with a security error. As with all security
///callbacks, the application should expect to receive this callback any time between channel/listener open and close,
///but it will never be invoked when a channel is not open. In the current drop, this callback is always invoked
///synchronously. In the next drop, this callback will be invoked synchronously for synchronous message receives and
///asynchronously for asynchronous message receives, but it will always be invoked shortwhen it is invoked
///asynchronously.
///Params:
///    passwordValidatorCallbackState = The state to be passed back when invoking this callback.
///    username = Received username.
///    password = Received password.
///    asyncContext = Information on how to invoke the function asynchronously, or <b>NULL</b> if invoking synchronously.
///    error = Specifies where additional error information should be stored if the function fails.
alias WS_VALIDATE_PASSWORD_CALLBACK = HRESULT function(void* passwordValidatorCallbackState, 
                                                       const(WS_STRING)* username, const(WS_STRING)* password, 
                                                       const(WS_ASYNC_CONTEXT)* asyncContext, WS_ERROR* error);
///Validates a SAML assertion. If a received SAML assertion passes the signature verification checks that ensure the
///SAML was issued by a trusted issuer, then this callback is invoked to enable the application to do additional
///validation on the XML form of the SAML assertion. This callback is expected to return S_OK if the SAML assertion was
///successfully validated, S_FALSE when the assertion could not be validated and an error value if an unexpected error
///occurred. Returning any result other than S_OK from this callback will result in the associated receive message
///failing with a security error. As with all security callbacks, the application should expect to receive this callback
///any time between listener open and close, but it will never be invoked when a listener is not open.
///Params:
///    samlValidatorCallbackState = The state to be passed back when invoking this callback.
///    samlAssertion = The received SAML assertion that has undergone a successful signature check.
///    error = Specifies where additional error information should be stored if the function fails.
alias WS_VALIDATE_SAML_CALLBACK = HRESULT function(void* samlValidatorCallbackState, WS_XML_BUFFER* samlAssertion, 
                                                   WS_ERROR* error);
///Compares two durations.A duration represents a unit of time as an eight-dimensional space where the coordinates
///designate the year, month, day, hour, minute, second, millisecond, and CPU tick as represented by the WS_DURATION
///data structure.
///Params:
///    duration1 = A pointer to a WS_DURATION structure representing the first duration to compare.
///    duration2 = A pointer to a WS_DURATION structure representing the second duration.
///    result = The relationship between the durations as one of the following values: <ul> <li>-1 if <i>duration1</i> is less
///             than <i>duration2</i></li> <li> 0 if <i>duration1</i> is equal to <i>duration2</i></li> <li> 1 if
///             <i>duration1</i> is greater than <i>duration2</i></li> </ul>
///    error = A pointer to a WS_ERROR handle where additional error information should be stored if the function fails.
///Returns:
///    This callback function does not return a value.
///    
alias WS_DURATION_COMPARISON_CALLBACK = HRESULT function(const(WS_DURATION)* duration1, 
                                                         const(WS_DURATION)* duration2, int* result, WS_ERROR* error);
///Reads a value when WS_TYPEhas been specified. This allows reading of XML constructs which do not easily map to the
///core serialization model.
///Params:
///    reader = A pointer to a WS_XML_READER handle that contains the type value.
///    typeMapping = Indicates how the XML is being mapped to this type. If a mapping does not make sense for this particular type,
///                  then the callback should return <b>WS_E_INVALID_OPERATION</b>. (See Windows Web Services Return Values.) A
///                  callback implementation should be prepared to be passed new mapping types in future versions and should return
///                  <b>WS_E_INVALID_OPERATION</b> for those cases.
///    descriptionData = A pointer to the value of the <b>descriptionData</b> field of a WS_CUSTOM_TYPE_DESCRIPTION structure. The
///                      callback can use this to gain access to any additional information about the type.
///    heap = A pointer to the heap for use in allocating any additional data associated with this type such as its nested
///           fields. Note that this parameter may be <b>NULL</b>, if the caller did not specify a WS_HEAP object when
///           deserializing the type.
///    value = A pointer to a buffer that holds the value that is being deserialized. The callback is responsible for filling in
///            the value based on the current contents of the reader and the typeMapping. The callback can use the supplied heap
///            if necessary to allocate values associated with the value.
///    valueSize = The buffer size that is being deserialized. The buffer is allocated according to the size specified in the
///                WS_CUSTOM_TYPE_DESCRIPTION.
///    error = A pointer to WS_ERROR data structure where additional error information should be stored if the function fails.
///Returns:
///    This callback function does not return a value.
///    
alias WS_READ_TYPE_CALLBACK = HRESULT function(WS_XML_READER* reader, WS_TYPE_MAPPING typeMapping, 
                                               const(void)* descriptionData, WS_HEAP* heap, void* value, 
                                               uint valueSize, WS_ERROR* error);
///Invoked to write an element when WS_CUSTOM_TYPEhas been specified. This allows writing of XML constructs which do not
///easily map to the core serialization model.
///Params:
///    writer = A <b>WS_XML_WRITER</b> pointer to the writer that the value should be written to.
///    typeMapping = Indicates how the XML is being mapped to this type. See WS_TYPE_MAPPINGfor more information. If a mapping does
///                  not make sense for this particular type, the callback should return <b>WS_E_INVALID_OPERATION</b>. (See Windows
///                  Web Services Return Values.) A callback implementation should be prepared to be passed new mapping types in
///                  future versions and should return <b>WS_E_INVALID_OPERATION</b> for those cases.
///    descriptionData = This is the value of the <b>descriptionData</b> field of the WS_CUSTOM_TYPE_DESCRIPTION structure. The callback
///                      uses this field to access any additional information about the type.
///    value = A <b>void</b> pointer to a value to serialize.
///    valueSize = The size, in bytes, of the value being serialized.
///    error = A pointer to a WS_ERROR data structure where additional error information should be stored if the function fails.
///Returns:
///    This callback function does not return a value.
///    
alias WS_WRITE_TYPE_CALLBACK = HRESULT function(WS_XML_WRITER* writer, WS_TYPE_MAPPING typeMapping, 
                                                const(void)* descriptionData, const(void)* value, uint valueSize, 
                                                WS_ERROR* error);
///Determines if a value is the default value. This callback is used before a value that is handled by a WS_CUSTOM_TYPE
///is serialized. Support for default values is enabled by specifying when WS_FIELD_OPTIONAL in the
///WS_FIELD_DESCRIPTION.
///Params:
///    descriptionData = This is the value of the descriptionData field from WS_CUSTOM_TYPE_DESCRIPTION. The callback can use this to
///                      access any additional information about the type.
///    value = A pointer to the value being serialized.
///    defaultValue = A pointer to the default value. If no default value was specified for the field, this parameter will be
///                   <b>NULL</b>. If the parameter is non-<b>NULL</b>, the callback should compare the two values field-by-field
///                   according to the custom type. If the fields match, then the isDefault parameter should be set to <b>TRUE</b>. If
///                   the parameter is <b>NULL</b>, the callback should compare the fields of the value with zero. If the fields match,
///                   then the isDefault parameter should be set to <b>TRUE</b>.
///    valueSize = The size, in bytes, of the value being serialized.
///    isDefault = Whether or not the value is the default value.
///    error = Specifies where additional error information should be stored if the function fails.
alias WS_IS_DEFAULT_VALUE_CALLBACK = HRESULT function(const(void)* descriptionData, const(void)* value, 
                                                      const(void)* defaultValue, uint valueSize, BOOL* isDefault, 
                                                      WS_ERROR* error);
///Invoked when a WS_MESSAGE is received on an endpoint configured with a WS_SERVICE_CONTRACT which has
///defaultMessageHandlerCallback set. The incoming WS_MESSAGE, the serviceProxy along with other parameters is made
///available to the callback through WS_OPERATION_CONTEXT.
///Params:
///    context = The context within which this callback is being invoked.
///    asyncContext = Specifies whether the callback can run asynchronously.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    This callback function does not return a value.
///    
alias WS_SERVICE_MESSAGE_RECEIVE_CALLBACK = HRESULT function(const(WS_OPERATION_CONTEXT)* context, 
                                                             const(WS_ASYNC_CONTEXT)* asyncContext, WS_ERROR* error);
///Gives notification of the cancellation of an asynchronous service operation call as a result of an aborted shutdown
///of service host. This callback is invoked by service model.
///Params:
///    reason = Specifies the reason for which the call back is called.
///    state = A reference to the application defined state registered with the callback.
alias WS_OPERATION_CANCEL_CALLBACK = void function(const(WS_SERVICE_CANCEL_REASON) reason, void* state);
///Allows an application to cleanup state information that was registered with cancellation callback. This callback is
///invoked by service model.
///Params:
///    state = A reference to the application defined state registered with the callback.
alias WS_OPERATION_FREE_STATE_CALLBACK = void function(void* state);
///Invoked by service model to delegate to the service operation call. This callback is generated by wsutil.exe for
///every service operation. It is defined on the WS_OPERATION_DESCRIPTION for each service operation.
///Params:
///    context = The context within which this callback is being invoked.
///    frame = Pointer to the method frame.
///    callback = Pointer to the callback function to which the stub function corresponds to.
///    asyncContext = Specifies whether the callback can run asynchronously.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    This callback function does not return a value.
///    
alias WS_SERVICE_STUB_CALLBACK = HRESULT function(const(WS_OPERATION_CONTEXT)* context, void* frame, 
                                                  const(void)* callback, const(WS_ASYNC_CONTEXT)* asyncContext, 
                                                  WS_ERROR* error);
///Invoked when a channel is accepted on an endpoint listener by service host. For session-based service contract, this
///notification signifies session initiation. Thus an application state scoped for the session can be created within
///this callback.
///Params:
///    context = The operation context.
///    asyncContext = Information on whether the function is getting invoked asynchornously.
///    error = Specifies where additional error information should be stored if the function fails.
///    channelState = The callback may provide channel state through this parameter. This channel state is made available to the
///                   service operation as part of WS_OPERATION_CONTEXT through the WS_OPERATION_CONTEXT_PROPERTY_CHANNEL_USER_STATE.
///Returns:
///    This callback function does not return a value.
///    
alias WS_SERVICE_ACCEPT_CHANNEL_CALLBACK = HRESULT function(const(WS_OPERATION_CONTEXT)* context, 
                                                            void** channelState, 
                                                            const(WS_ASYNC_CONTEXT)* asyncContext, WS_ERROR* error);
///Invoked when a channel is closed or aborted on an endpoint. This callback is called right before we are about to
///close the channel. For normal operation when service host is running and the client cleanly closed the channel, this
///implies that we have received a session closure from the client and we are about to close the channel. The other
///scenario is when service host is going through an Abort Shutdown or during the processing of the message an
///unrecoverable error condition is met, as a result of this we attempt to abort and then close the channel. In this
///case as well right before the abort we will call upon this callback. For session-based service contract, this
///notification signifies session tear down. Thus an application state scoped for the session can be destroyed within
///this callback.
///Params:
///    context = The operation context.
///    asyncContext = Information on whether the function is getting invoked asynchornously.
///Returns:
///    This callback function does not return a value.
///    
alias WS_SERVICE_CLOSE_CHANNEL_CALLBACK = HRESULT function(const(WS_OPERATION_CONTEXT)* context, 
                                                           const(WS_ASYNC_CONTEXT)* asyncContext);
///Invoked when headers of the incoming message are received and the body is not processed.
///Params:
///    context = The incoming message with headers only.
///    authorized = Set to <b>TRUE</b>, if authorization succeeded, <b>FALSE</b> if authorization failed.
///    error = Specifies where additional error information should be stored if the function fails.
alias WS_SERVICE_SECURITY_CALLBACK = HRESULT function(const(WS_OPERATION_CONTEXT)* context, BOOL* authorized, 
                                                      WS_ERROR* error);
///Invoked when the headers of the input message are about to be sent, or when output message headers are just received.
///Params:
///    message = The input or output message.
///    heap = The heap associated with the call. This is the heap which is passed to call for which this callback is being
///           called.
///    state = The 'state' as specified as part of WS_PROXY_MESSAGE_CALLBACK_CONTEXT 'state' field.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    If this callback function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>.
///    Otherwise, it returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
alias WS_PROXY_MESSAGE_CALLBACK = HRESULT function(WS_MESSAGE* message, WS_HEAP* heap, void* state, 
                                                   WS_ERROR* error);

// Structs


struct WS_XML_READER
{
}

struct WS_XML_WRITER
{
}

struct WS_XML_BUFFER
{
}

struct WS_CHANNEL
{
}

struct WS_OPERATION_CONTEXT
{
}

struct WS_ERROR
{
}

struct WS_HEAP
{
}

struct WS_LISTENER
{
}

struct WS_MESSAGE
{
}

struct WS_SECURITY_TOKEN
{
}

struct WS_SECURITY_CONTEXT
{
}

struct WS_SERVICE_HOST
{
}

struct WS_SERVICE_PROXY
{
}

struct WS_METADATA
{
}

struct WS_POLICY
{
}

///Represents a set of unique strings. This information is used by the binary encoding to write a more compact xml
///document.
struct WS_XML_DICTIONARY
{
    ///A guid that uniquely identifies the set of strings represented by the dictionary. The guid is never transmitted
    ///or persisted, and needs to only be unique for the lifetime of the process.
    GUID           guid;
    ///The set of unique strings that comprise the dictionary.
    WS_XML_STRING* strings;
    ///Specifies the number of strings in the dictionary.
    uint           stringCount;
    ///Indicates if the dictionary and its contents are declared const and that they will be kept valid for the entire
    ///lifetime of any object with which strings in the dictionary are used. If this is <b>TRUE</b>, then the strings
    ///can be manipulated more efficiently.
    BOOL           isConst;
}

///Represents a string that optionally has dictionary information associated with it. The xml APIs use WS_XML_STRINGs to
///identify prefixes, localNames and namespaces.
struct WS_XML_STRING
{
    ///The number of bytes in the UTF-8 encoded representation of the string.
    uint               length;
    ///The string encoded as UTF-8 bytes.
    ubyte*             bytes;
    ///A pointer to the dictionary that contains the string. If the string is not part of a dictionary then the value
    ///may be <b>NULL</b>.
    WS_XML_DICTIONARY* dictionary;
    ///A value that uniquely identifies the string within the specified dictionary. The entry at
    ///dictionary-&gt;strings[id] should identify this string. If the dictionary is <b>NULL</b>, then this value is
    ///unused.
    uint               id;
}

///A structure used to specify an XML name (of an element or an attribute) as a local name, namespace pair.
struct WS_XML_QNAME
{
    ///The local name.
    WS_XML_STRING localName;
    WS_XML_STRING ns;
}

///Represents a position within an XML buffer. The current position within a reader or writer may be obtained by calling
///WsGetReaderPosition or WsGetWriterPosition. The current position within a reader or writer may be set by calling
///WsSetReaderPosition or WsSetWriterPosition. Using WsRemoveNode to remove a node that corresponds to or contains a
///position will cause subsequent use of the position to fail. The position itself remains valid, but operations that
///depend on that position will fail. Positions may be used as long as the containing XML buffer is valid. Using a
///position after its corresponding buffer has been deleted will exhibit undefined behavior.
struct WS_XML_NODE_POSITION
{
    ///The xml buffer to which the position refers.
    WS_XML_BUFFER* buffer;
    void*          node;
}

///Specifies a reader specific setting.
struct WS_XML_READER_PROPERTY
{
    ///Identifies the WS_XML_READER_PROPERTY_ID.
    WS_XML_READER_PROPERTY_ID id;
    ///A pointer to the value to set. The pointer must have an alignment compatible with the type of the property.
    void* value;
    uint  valueSize;
}

///An array of XML prefixes that should be treated as inclusive prefixes during exclusive XML canonicalization. The
///treatment of inclusive prefixes is defined in RFC 3741.
struct WS_XML_CANONICALIZATION_INCLUSIVE_PREFIXES
{
    ///The number of prefixes.
    uint           prefixCount;
    WS_XML_STRING* prefixes;
}

///Specifies a setting that controls how XML canonicalization is done.
struct WS_XML_CANONICALIZATION_PROPERTY
{
    ///Identifies the WS_XML_CANONICALIZATION_PROPERTY_ID.
    WS_XML_CANONICALIZATION_PROPERTY_ID id;
    ///A pointer to the value to set. The pointer must have an alignment compatible with the type of the property.
    void* value;
    uint  valueSize;
}

///Specifies a writer specific setting.
struct WS_XML_WRITER_PROPERTY
{
    ///Identifies the WS_XML_WRITER_PROPERTY_ID.
    WS_XML_WRITER_PROPERTY_ID id;
    ///A pointer to the value to set. The pointer must have an alignment compatible with the type of the property.
    void* value;
    uint  valueSize;
}

///Specifies an XML buffer–specific setting.
struct WS_XML_BUFFER_PROPERTY
{
    ///Identifies the WS_XML_BUFFER_PROPERTY_ID.
    WS_XML_BUFFER_PROPERTY_ID id;
    ///A pointer to the value to set. The pointer must have an alignment compatible with the type of the property.
    void* value;
    uint  valueSize;
}

///Represents a node of text content in xml.
struct WS_XML_TEXT
{
    WS_XML_TEXT_TYPE textType;
}

///Represents text encoded as UTF-8 bytes.
struct WS_XML_UTF8_TEXT
{
    ///The base type for all types that derive from WS_XML_TEXT.
    WS_XML_TEXT   text;
    WS_XML_STRING value;
}

///Represents text encoded as UTF-16 bytes.
struct WS_XML_UTF16_TEXT
{
    ///The base type for all types that derive from WS_XML_TEXT.
    WS_XML_TEXT text;
    ///The bytes that point to UTF-16 encoded data.
    ubyte*      bytes;
    uint        byteCount;
}

///Represents base64 encoded data. (for example, the three bytes { 0, 0, 0 } represent the text "AAAA".)
struct WS_XML_BASE64_TEXT
{
    ///The base type for all types that derive from WS_XML_TEXT.
    WS_XML_TEXT text;
    ///The bytes of data.
    ubyte*      bytes;
    uint        length;
}

///A Boolean value that represents the text "true" or "false".
struct WS_XML_BOOL_TEXT
{
    ///The base type for all types that derive from WS_XML_TEXT.
    WS_XML_TEXT text;
    BOOL        value;
}

///Represents a signed 32 bit integer. (e.g. The value 255 represents the text "255")
struct WS_XML_INT32_TEXT
{
    ///The base type for all types that derive from WS_XML_TEXT.
    WS_XML_TEXT text;
    int         value;
}

///Represents a signed 64 bit integer. (e.g. The value 255 represents the text "255")
struct WS_XML_INT64_TEXT
{
    ///The base type for all types that derive from WS_XML_TEXT.
    WS_XML_TEXT text;
    long        value;
}

///Represents an unsigned 64 bit integer. (e.g. The value 255 represents the text "255")
struct WS_XML_UINT64_TEXT
{
    ///The base type for all types that derive from WS_XML_TEXT.
    WS_XML_TEXT text;
    ulong       value;
}

///Represents a 4 byte floating point value. (e.g. The value 0.0 represents the text "0")
struct WS_XML_FLOAT_TEXT
{
    ///The base type for all types that derive from WS_XML_TEXT.
    WS_XML_TEXT text;
    ///The value.
    float       value;
}

///Represents an 8 byte floating point value. (e.g. The value 0.0 represents the text "0")
struct WS_XML_DOUBLE_TEXT
{
    ///The base type for all types that derive from WS_XML_TEXT.
    WS_XML_TEXT text;
    ///The value.
    double      value;
}

///Represents a 12 byte fixed point value. (e.g. The value 1.23 represents the text "1.23")
struct WS_XML_DECIMAL_TEXT
{
    ///The base type for all types that derive from WS_XML_TEXT.
    WS_XML_TEXT text;
    DECIMAL     value;
}

///Represents a GUID formatted as the text "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx".
struct WS_XML_GUID_TEXT
{
    ///The base type for all types that derive from WS_XML_TEXT.
    WS_XML_TEXT text;
    GUID        value;
}

///Represents a GUID formatted as the text "urn:uuid:xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx".
struct WS_XML_UNIQUE_ID_TEXT
{
    ///The base type for all types that derive from WS_XML_TEXT.
    WS_XML_TEXT text;
    GUID        value;
}

///This structure is used to represent dates and times. Represents dates and times with values ranging from 12:00:00
///midnight, January 1, 0001 Anno Domini (Common Era) through 11:59:59 P.M., December 31, 9999 A.D. (C.E.) to an
///accuracy of 100 nanoseconds. The functions WsDateTimeToFileTime and WsFileTimeToDateTime can be used to convert a
///<b>WS_DATETIME</b> to and from a FILETIME.
struct WS_DATETIME
{
    ///The time in 100 nanosecond units, with 0 representing 12:00:00 midnight January 1, Anno Domini (Common Era). The
    ///largest representable value is 3155378975999999999, which corresponds to 100 nanoseconds prior to 12:00:00
    ///midnight January 1, 10000.
    ulong              ticks;
    WS_DATETIME_FORMAT format;
}

///Represents a datetime formatted as an xsd:dateTime. Negative datetime values are not supported.
struct WS_XML_DATETIME_TEXT
{
    ///The base type for all types that derive from WS_XML_TEXT.
    WS_XML_TEXT text;
    WS_DATETIME value;
}

///Represents a signed 64-bit time interval in 100 nanosecond units.
struct WS_TIMESPAN
{
    long ticks;
}

///Represents a time span formatted as the text "[+|-][d?.]HH:mm:ss[.fffffff]" <ul> <li>d is a series of digits
///representing the day. </li> <li>HH is a two digit number representing the hour of the day, from to 0 to 23. </li>
///<li>mm is a two digit number representing the minute of the hour, from to 0 to 59. </li> <li>ss is a two digit number
///representing the second of the minute, from to 0 to 59. </li> <li>fffffff is up to 7 decimal digits representing the
///fraction of a second. </li> </ul>
struct WS_XML_TIMESPAN_TEXT
{
    ///The base type for all types that derive from WS_XML_TEXT.
    WS_XML_TEXT text;
    WS_TIMESPAN value;
}

///Represents a qname formatted as the text "prefix:localName"
struct WS_XML_QNAME_TEXT
{
    ///The base type for all types that derive from WS_XML_TEXT.
    WS_XML_TEXT    text;
    ///The prefix.
    WS_XML_STRING* prefix;
    ///The local name.
    WS_XML_STRING* localName;
    WS_XML_STRING* ns;
}

///Represents a list of text values separated by a single whitespace character. (e.g. The list { {
///WS_XML_TEXT_TYPE_INT32 }, 123}, { { WS_XML_TEXT_TYPE_BOOL }, 1 } represents the text "123 true")
struct WS_XML_LIST_TEXT
{
    ///The base type for all types that derive from WS_XML_TEXT.
    WS_XML_TEXT   text;
    ///The number of items in the list.
    uint          itemCount;
    WS_XML_TEXT** items;
}

///The base type for all the different kinds of XML nodes. An XML node is unit of data in XML.
struct WS_XML_NODE
{
    WS_XML_NODE_TYPE nodeType;
}

///Represents an attribute (for example, &lt;a:purchaseOrder xmlns:a="http://tempuri.org" id="5"&gt;)
struct WS_XML_ATTRIBUTE
{
    ///Whether to use a single quote or double quote to surround an attribute value. In the example, the value of
    ///singleQuote for attribute "id" would be <b>FALSE</b>.
    ubyte          singleQuote;
    ///Whether or not the attribute is an xmlns attribute. In the example above, this would be <b>TRUE</b> for the
    ///attribute "xmlns:a", but <b>FALSE</b> for the attribute "id".
    ubyte          isXmlNs;
    ///The prefix of the attribute. In the example above, the prefix for attribute "xmlns:a" is "a", while the prefix
    ///for "id" is a zero length string. The prefix for the attribute "xmlns" is a zero length string.
    WS_XML_STRING* prefix;
    ///The localName of the attribute. In the example above, the localName for attribute "xmlns:a" is not used so it is
    ///<b>NULL</b>. The localName for attribute "id" is "id".
    WS_XML_STRING* localName;
    ///The namespace of the attribute. In the example above, the namespace for the attribute "xmlns:a" is
    ///"http://tempuri.org". The namespace for attribute "id" is the empty namespace which is represented by a zero
    ///length string.
    WS_XML_STRING* ns;
    WS_XML_TEXT*   value;
}

///Represents a start element in xml (e.g. &lt;a:purchaseOrder xmlns:a="http://tempuri.org" id="5"&gt;)
struct WS_XML_ELEMENT_NODE
{
    ///The base type for all types that derive from WS_XML_NODE.
    WS_XML_NODE        node;
    ///The prefix of the element. In the example, it refers to "a". Empty prefixes are represented by a zero length
    ///WS_XML_STRING.
    WS_XML_STRING*     prefix;
    ///The localName of the element. In the example, it refers to "purchaseOrder".
    WS_XML_STRING*     localName;
    ///The resolved namespace of the prefix. In the example, it refers to "http://tempuri.org".
    WS_XML_STRING*     ns;
    ///The number of attributes on the element. In the example, it would be 2.
    uint               attributeCount;
    ///The array of attributes for the element.
    WS_XML_ATTRIBUTE** attributes;
    BOOL               isEmpty;
}

///Represents an element, attribute, or CDATA content.
struct WS_XML_TEXT_NODE
{
    ///The base type for all types that derive from WS_XML_NODE.
    WS_XML_NODE  node;
    WS_XML_TEXT* text;
}

///Represents a comment. (For example, &lt;!--The message follows--&gt;)
struct WS_XML_COMMENT_NODE
{
    ///The base type for all types that derive from WS_XML_NODE.
    WS_XML_NODE   node;
    WS_XML_STRING value;
}

///Specifies where the reader should obtain the bytes that comprise the xml document.
struct WS_XML_READER_INPUT
{
    WS_XML_READER_INPUT_TYPE inputType;
}

///Specifies that the source of the xml input is a buffer.
struct WS_XML_READER_BUFFER_INPUT
{
    ///The base type for all types that derive from WS_XML_READER_INPUT.
    WS_XML_READER_INPUT input;
    ///A pointer to the bytes of data that comprise the encoded form of the xml. The reader will not modify any of these
    ///bytes.
    void*               encodedData;
    uint                encodedDataSize;
}

///Specifies that the source of the xml should be obtained from a callback.
struct WS_XML_READER_STREAM_INPUT
{
    ///The base type for all types that derive from WS_XML_READER_INPUT.
    WS_XML_READER_INPUT input;
    ///A callback that is invoked when WsFillReader is called.
    WS_READ_CALLBACK    readCallback;
    void*               readCallbackState;
}

///This structure is the base type for all the different kinds of reader encodings.
struct WS_XML_READER_ENCODING
{
    WS_XML_READER_ENCODING_TYPE encodingType;
}

///Used to indicate that the reader should interpret the bytes it reads as textual xml.
struct WS_XML_READER_TEXT_ENCODING
{
    ///The base type for all types that derive from WS_XML_READER_ENCODING.
    WS_XML_READER_ENCODING encoding;
    WS_CHARSET charSet;
}

///Used to indicate that the reader should interpret the bytes it reads as binary xml.
struct WS_XML_READER_BINARY_ENCODING
{
    ///The base type for all types that derive from WS_XML_READER_ENCODING.
    WS_XML_READER_ENCODING encoding;
    ///Indicates the dictionary that the reader should use for static strings. The binary representation of the xml
    ///document references these strings by id (as opposed to embedding the actual string), and therefore they must
    ///contain the same set of strings used when the document was written.
    WS_XML_DICTIONARY* staticDictionary;
    WS_XML_DICTIONARY* dynamicDictionary;
}

///An array of Unicode characters and a length.
struct WS_STRING
{
    ///The number of characters in the string.
    uint  length;
    ///The array of characters that make up the string.
    PWSTR chars;
}

///Used to indicate that the reader should interpret the bytes it reads as in MTOM format.
struct WS_XML_READER_MTOM_ENCODING
{
    ///The base type for all types that derive from WS_XML_READER_ENCODING.
    WS_XML_READER_ENCODING encoding;
    ///The encoding of the xml document carried by MTOM.
    WS_XML_READER_ENCODING* textEncoding;
    ///Specifies whether or not the reader should read the MIME header.
    BOOL      readMimeHeader;
    ///The type used by the mime part that contains the xml. This corresponds to the "start-info" parameter in the of
    ///the MIME Content-Type. If readMimeHeader is specified as <b>TRUE</b>, then this must be empty as the startInfo
    ///will be read from the mime header.
    WS_STRING startInfo;
    ///The character sequence that should be used to delimit the mime parts. This corresponds to the "boundary"
    ///parameter of the MIME Content-Type. If readMimeHeader is specified as <b>TRUE</b>, then this must be empty as the
    ///boundary will be read from the mime header.
    WS_STRING boundary;
    ///The mime part that contains the xml. This corresponds to the "start" parameter of the MIME Content-Type. If
    ///readMimeHeader is specified as <b>TRUE</b>, then this must be empty as the startUri will be read from the mime
    ///header.
    WS_STRING startUri;
}

///Used to indicate that the reader should surface the bytes of the document as base64 encoded characters.
struct WS_XML_READER_RAW_ENCODING
{
    ///The base type for all types that derive from WS_XML_READER_ENCODING.
    WS_XML_READER_ENCODING encoding;
}

///This structure is the base type for all the different kinds of writer encodings.
struct WS_XML_WRITER_ENCODING
{
    WS_XML_WRITER_ENCODING_TYPE encodingType;
}

///Indicates that the reader should emit bytes as textual xml.
struct WS_XML_WRITER_TEXT_ENCODING
{
    ///The base type for all types that derive from WS_XML_WRITER_ENCODING.
    WS_XML_WRITER_ENCODING encoding;
    WS_CHARSET charSet;
}

///Used to indicate that the writer should emit bytes as binary xml.
struct WS_XML_WRITER_BINARY_ENCODING
{
    ///The base type for all types that derive from WS_XML_WRITER_ENCODING.
    WS_XML_WRITER_ENCODING encoding;
    ///Indicates the dictionary that the writer should use for static strings. WS_XML_STRINGs that are written that
    ///reference this dictionary, will be written in the binary xml document using an id rather than the string itself.
    ///When reading this document, the application must provide a dictionary with the same strings.
    WS_XML_DICTIONARY* staticDictionary;
    ///Specifies an optional callback that the writer will invoke when a WS_XML_STRING that is not found in the
    ///staticDictionary is written for the first time. The callback provides the mapping to an id which the writer will
    ///then use. It is the responsibility of the callback to coordinate with the writer to propagate these strings to
    ///the reader. The string is not added to the dictionary if this callback is not specified.
    WS_DYNAMIC_STRING_CALLBACK dynamicStringCallback;
    void*              dynamicStringCallbackState;
}

///Used to indicate that the reader should emit bytes in MTOM format. The MTOM format will represent bytes written to it
///as binary mime parts rather than embedded base64 encoded text.
struct WS_XML_WRITER_MTOM_ENCODING
{
    ///The base type for all types that derive from WS_XML_WRITER_ENCODING.
    WS_XML_WRITER_ENCODING encoding;
    ///Specifies the encoding of the xml document carried by MTOM.
    WS_XML_WRITER_ENCODING* textEncoding;
    ///Specifies whether or not the writer should emit a MIME header.
    BOOL      writeMimeHeader;
    ///Specifies the character sequence that should be used to delimit the mime parts. This corresponds to the
    ///"boundary" parameter of the MIME Content-Type.
    WS_STRING boundary;
    ///Specifies the type used by the mime part that contains the xml. This correpsonds to the "start-info" parameter in
    ///the of the MIME Content-Type.
    WS_STRING startInfo;
    ///Specifies the mime part that contains the xml. This corresponds to the "start" parameter of the MIME
    ///Content-Type.
    WS_STRING startUri;
    uint      maxInlineByteCount;
}

///Used to indicate that the writer should emit bytes from decoded base64 characters.
struct WS_XML_WRITER_RAW_ENCODING
{
    ///The base type for all types that derive from WS_XML_WRITER_ENCODING.
    WS_XML_WRITER_ENCODING encoding;
}

///Specifies where the writer should emit the bytes that comprise the xml document.
struct WS_XML_WRITER_OUTPUT
{
    WS_XML_WRITER_OUTPUT_TYPE outputType;
}

///Specifies that the generated bytes should be placed in a buffer.
struct WS_XML_WRITER_BUFFER_OUTPUT
{
    WS_XML_WRITER_OUTPUT output;
}

///Specifies that the generated bytes should be sent to callback.
struct WS_XML_WRITER_STREAM_OUTPUT
{
    ///The base type for all types that derive from WS_XML_WRITER_OUTPUT.
    WS_XML_WRITER_OUTPUT output;
    ///A callback that will get invoked when WsFlushWriter is called. This may not be <b>NULL</b>.
    WS_WRITE_CALLBACK    writeCallback;
    void*                writeCallbackState;
}

///A structure that is used to specify a set of WS_XML_WRITER_PROPERTYs.
struct WS_XML_WRITER_PROPERTIES
{
    ///An array of properties. The number of elements in the array is specified using the propertyCount parameter. This
    ///field may be <b>NULL</b> if the propertyCount is 0.
    WS_XML_WRITER_PROPERTY* properties;
    uint propertyCount;
}

///A structure that is used to specify a set of WS_XML_READER_PROPERTYs.
struct WS_XML_READER_PROPERTIES
{
    ///An array of properties. The number of elements in the array is specified using the propertyCount parameter. This
    ///field may be <b>NULL</b> if the propertyCount is 0.
    WS_XML_READER_PROPERTY* properties;
    uint propertyCount;
}

///Used with the Async Model to specify the asynchronous callback and a pointer which will be passed to the asynchronous
///callback.
struct WS_ASYNC_CONTEXT
{
    ///The callback function to call if the operation completes asynchronously. This field may not be <b>NULL</b>.
    WS_ASYNC_CALLBACK callback;
    void*             callbackState;
}

///Used by WsAsyncExecute to manage the state of an asynchronous operation.
struct WS_ASYNC_STATE
{
    ///This field is internal and should not be modified.
    void* internal0;
    ///This field is internal and should not be modified.
    void* internal1;
    ///This field is internal and should not be modified.
    void* internal2;
    ///This field is internal and should not be modified.
    void* internal3;
    void* internal4;
}

///Used with the WsAsyncExecute to specify the next function to invoke in a series of async operations.
struct WS_ASYNC_OPERATION
{
    WS_ASYNC_FUNCTION function_;
}

///Specifies a channel specific setting.
struct WS_CHANNEL_PROPERTY
{
    ///The WS_CHANNEL_PROPERTY_ID.
    WS_CHANNEL_PROPERTY_ID id;
    ///A pointer to the value to set. The pointer must have an alignment compatible with the type of the property.
    void* value;
    uint  valueSize;
}

///A structure that is used to specify the custom proxy for the channel, using the
///WS_CHANNEL_PROPERTY_CUSTOM_HTTP_PROXY.
struct WS_CUSTOM_HTTP_PROXY
{
    ///A semicolon-separated list of the proxy servers to be used by the channel. Each entry must follow the following
    ///EBNF. <pre class="syntax" xml:space="preserve"><code> &lt;server&gt;[":"&lt;port&gt;]</code></pre> <ul>
    ///<li>server=Address of the server </li> <li>port=TCP port number </li> </ul>
    WS_STRING servers;
    WS_STRING bypass;
}

///Specifies a set of WS_CHANNEL_PROPERTY structures.
struct WS_CHANNEL_PROPERTIES
{
    ///An array of properties. The number of elements in the array is specified using the propertyCount parameter. This
    ///field may be <b>NULL</b> if the propertyCount is 0.
    WS_CHANNEL_PROPERTY* properties;
    uint                 propertyCount;
}

///A structure that is used to specify a set of callbacks that form the implementation of a custom channel.
struct WS_CUSTOM_CHANNEL_CALLBACKS
{
    ///The callback that implements WsCreateChannel. See WS_CREATE_CHANNEL_CALLBACK for more information.
    WS_CREATE_CHANNEL_CALLBACK createChannelCallback;
    ///The callback that implements WsFreeChannel. See WS_FREE_CHANNEL_CALLBACK for more information.
    WS_FREE_CHANNEL_CALLBACK freeChannelCallback;
    ///The callback that implements WsResetChannel. See WS_RESET_CHANNEL_CALLBACK for more information.
    WS_RESET_CHANNEL_CALLBACK resetChannelCallback;
    ///The callback that implements WsOpenChannel. See WS_OPEN_CHANNEL_CALLBACK for more information.
    WS_OPEN_CHANNEL_CALLBACK openChannelCallback;
    ///The callback that implements WsCloseChannel. See WS_CLOSE_CHANNEL_CALLBACK for more information.
    WS_CLOSE_CHANNEL_CALLBACK closeChannelCallback;
    ///The callback that implements WsAbortChannel. See WS_ABORT_CHANNEL_CALLBACK for more information.
    WS_ABORT_CHANNEL_CALLBACK abortChannelCallback;
    ///The callback that implements WsGetChannelProperty. See WS_GET_CHANNEL_PROPERTY_CALLBACK for more information.
    WS_GET_CHANNEL_PROPERTY_CALLBACK getChannelPropertyCallback;
    ///The callback that implements WsSetChannelProperty. See WS_SET_CHANNEL_PROPERTY_CALLBACK for more information.
    WS_SET_CHANNEL_PROPERTY_CALLBACK setChannelPropertyCallback;
    ///The callback that implements WsWriteMessageStart. See WS_WRITE_MESSAGE_START_CALLBACK for more information.
    WS_WRITE_MESSAGE_START_CALLBACK writeMessageStartCallback;
    ///The callback that implements WsWriteMessageEnd. See WS_WRITE_MESSAGE_END_CALLBACK for more information.
    WS_WRITE_MESSAGE_END_CALLBACK writeMessageEndCallback;
    ///The callback that implements WsReadMessageStart. See WS_READ_MESSAGE_START_CALLBACK for more information.
    WS_READ_MESSAGE_START_CALLBACK readMessageStartCallback;
    ///The callback that implements WsReadMessageEnd. See WS_READ_MESSAGE_END_CALLBACK for more information.
    WS_READ_MESSAGE_END_CALLBACK readMessageEndCallback;
    ///The callback that implements WsAbandonMessage. See WS_ABANDON_MESSAGE_CALLBACK for more information.
    WS_ABANDON_MESSAGE_CALLBACK abandonMessageCallback;
    ///The callback that implements WsShutdownSessionChannel. See WS_SHUTDOWN_SESSION_CHANNEL_CALLBACK for more
    ///information.
    WS_SHUTDOWN_SESSION_CHANNEL_CALLBACK shutdownSessionChannelCallback;
}

///Specifies an individual header that is mapped as part of WS_HTTP_MESSAGE_MAPPING.
struct WS_HTTP_HEADER_MAPPING
{
    ///The name of the HTTP header.
    WS_XML_STRING headerName;
    uint          headerMappingOptions;
}

///Specifies information about how an HTTP request or response should be represented in a message object.
struct WS_HTTP_MESSAGE_MAPPING
{
    ///Options that control how information in the HTTP request is mapped to the message object.
    uint requestMappingOptions;
    ///Options that control how information in the HTTP response is mapped to the message object.
    uint responseMappingOptions;
    ///An array of pointers to mappings which describe which HTTP headers are mapped to/from headers in the message
    ///object for an HTTP request. The pointers in the array may not be <b>NULL</b>.
    WS_HTTP_HEADER_MAPPING** requestHeaderMappings;
    ///The number of items in the requestHeaderMappings array.
    uint requestHeaderMappingCount;
    ///An array of pointers to mappings which describe which HTTP headers are mapped to/from headers in the message
    ///object for an HTTP response. The pointers in the array may not be <b>NULL</b>.
    WS_HTTP_HEADER_MAPPING** responseHeaderMappings;
    ///The number of items in the responseHeaderMappings array.
    uint responseHeaderMappingCount;
}

///Represents a mapping between a C data type and an XML element.
struct WS_ELEMENT_DESCRIPTION
{
    ///The local name of the XML element.
    WS_XML_STRING* elementLocalName;
    ///The namespace of the XML element.
    WS_XML_STRING* elementNs;
    ///The type that corresponds to this XML element. Not all types support being read and written as an element. If the
    ///documentation for the WS_TYPE indicates it supports WS_ELEMENT_TYPE_MAPPING, then it can be used with this
    ///structure.
    WS_TYPE        type;
    void*          typeDescription;
}

///The schema for the input/output WS_MESSAGE for a given operation description.
struct WS_MESSAGE_DESCRIPTION
{
    ///The action associated with the respective input/output WS_MESSAGE. If the message does not have an action, this
    ///field can be <b>NULL</b>.
    WS_XML_STRING* action;
    WS_ELEMENT_DESCRIPTION* bodyElementDescription;
}

///A structure that is used to specify a set of callbacks that can transform the content type and encoded bytes of a
///sent message.
struct WS_CHANNEL_ENCODER
{
    ///A context that will be passed to the WS_CREATE_ENCODER_CALLBACK.
    void* createContext;
    ///A WS_CREATE_ENCODER_CALLBACK callback that creates an instance of an encoder.
    WS_CREATE_ENCODER_CALLBACK createEncoderCallback;
    ///A WS_ENCODER_GET_CONTENT_TYPE_CALLBACK callback that is invoked when a message is to be encoded.
    WS_ENCODER_GET_CONTENT_TYPE_CALLBACK encoderGetContentTypeCallback;
    ///A WS_ENCODER_START_CALLBACK callback that is invoked to start encoding a message.
    WS_ENCODER_START_CALLBACK encoderStartCallback;
    ///A WS_ENCODER_ENCODE_CALLBACK callback that is invoked to encode a message.
    WS_ENCODER_ENCODE_CALLBACK encoderEncodeCallback;
    ///A WS_ENCODER_END_CALLBACK callback that is invoked to at the end of encoding a message.
    WS_ENCODER_END_CALLBACK encoderEndCallback;
    ///A WS_FREE_ENCODER_CALLBACK callback that frees an instance of an encoder.
    WS_FREE_ENCODER_CALLBACK freeEncoderCallback;
}

///A structure that is used to specify a set of callbacks that can transform the content type and encoded bytes of a
///received message.
struct WS_CHANNEL_DECODER
{
    ///A context that will be passed to the WS_CREATE_DECODER_CALLBACK.
    void* createContext;
    ///A WS_CREATE_DECODER_CALLBACK callback that creates an instance of an decoder.
    WS_CREATE_DECODER_CALLBACK createDecoderCallback;
    ///A WS_DECODER_GET_CONTENT_TYPE_CALLBACK callback that is invoked to get the content type of the message.
    WS_DECODER_GET_CONTENT_TYPE_CALLBACK decoderGetContentTypeCallback;
    ///A WS_DECODER_START_CALLBACK callback that is invoked at the start of decoding a message.
    WS_DECODER_START_CALLBACK decoderStartCallback;
    ///A WS_DECODER_DECODE_CALLBACK callback that is invoked to decode a message.
    WS_DECODER_DECODE_CALLBACK decoderDecodeCallback;
    ///A WS_DECODER_END_CALLBACK callback that is invoked at the end of decoding a message.
    WS_DECODER_END_CALLBACK decoderEndCallback;
    ///A WS_FREE_DECODER_CALLBACK callback that frees an instance of an decoder.
    WS_FREE_DECODER_CALLBACK freeDecoderCallback;
}

///Specifies the callback function and state for controlling the HTTP auto redirection behavior. See also,
///<b>WS_HTTP_REDIRECT_CALLBACK_CONTEXT</b> and WS_CHANNEL_PROPERTY_HTTP_REDIRECT_CALLBACK_CONTEXT.
struct WS_HTTP_REDIRECT_CALLBACK_CONTEXT
{
    ///Application specific callback for controlling HTTP auto redirections.
    WS_HTTP_REDIRECT_CALLBACK callback;
    void* state;
}

///The base type for all endpoint identities.
struct WS_ENDPOINT_IDENTITY
{
    WS_ENDPOINT_IDENTITY_TYPE identityType;
}

///Represents the network address of an endpoint.
struct WS_ENDPOINT_ADDRESS
{
    ///The URL portion of the address. The URL is always in escaped form. If this string is zero-length, then the URL is
    ///assumed to be the anonymous address. The anonymous address string is automatically mapped to/from the zero-length
    ///string when the endpoint address is serialized or deserialized using WS_ENDPOINT_ADDRESS_TYPE. The value of this
    ///field corresponds to the Address element of the WS-Addressing specifications.
    WS_STRING      url;
    ///A WS_XML_BUFFER handle to a set of header elements that represent the reference parameters for the endpoint
    ///address. The headers are required to properly interact with the endpoint. They are used to further qualify the
    ///address (URL). The headers should be treated as opaque values to the user of the endpoint address. See
    ///WsAddressMessage for information on how to add the headers to a message being sent. This field may be <b>NULL</b>
    ///if there are no headers. This value of this field corresponds to the content of the ReferenceParameters element
    ///of the WS-Addressing specifications.
    WS_XML_BUFFER* headers;
    ///A WS_XML_BUFFER handle to a set of extension elements. Extension elements are used to include additional
    ///information within an endpoint address. This field may be <b>NULL</b> if there are no extension elements. This
    ///value of this field corresponds to the other elements defined by WS-Addressing and any extension elements. The
    ///elements must appear in the correct order according to the specification, followed by extension elements. This
    ///field should not contain elements for Address or ReferenceParameters, or Identity, since these values are
    ///represented directly by other fields of this structure. If the ReferenceProperties element is present (as defined
    ///by WS_ADDRESSING_VERSION_0_9), it must be the first element within the WS_XML_BUFFER.
    WS_XML_BUFFER* extensions;
    ///The security identity of the endpoint represented by this endpoint address. This field corresponds to the
    ///Identity element, which is an extension of the base WS-Addressing specifications.
    WS_ENDPOINT_IDENTITY* identity;
}

///Type for specifying an endpoint identity represented by a DNS name.
struct WS_DNS_ENDPOINT_IDENTITY
{
    ///The base type from which this type and all other endpoint identity types derive.
    WS_ENDPOINT_IDENTITY identity;
    WS_STRING            dns;
}

///Type for specifying an endpoint identity represented by a UPN (user principal name).
struct WS_UPN_ENDPOINT_IDENTITY
{
    ///The base type from which this type and all other endpoint identity types derive.
    WS_ENDPOINT_IDENTITY identity;
    WS_STRING            upn;
}

///Type for specifying an endpoint identity represented by an SPN (service principal name).
struct WS_SPN_ENDPOINT_IDENTITY
{
    ///The base type from which this type and all other endpoint identity types derive.
    WS_ENDPOINT_IDENTITY identity;
    WS_STRING            spn;
}

///Used to serialize and deserialize an array of bytes.
struct WS_BYTES
{
    uint   length;
    ubyte* bytes;
}

///Type for RSA endpoint identity.
struct WS_RSA_ENDPOINT_IDENTITY
{
    ///The base type from which this type and all other endpoint identity types derive.
    WS_ENDPOINT_IDENTITY identity;
    ///The RSA key modulus of the endpoint that is represented by this endpoint identity.
    WS_BYTES             modulus;
    WS_BYTES             exponent;
}

///Type for certificate endpoint identity
struct WS_CERT_ENDPOINT_IDENTITY
{
    ///The base type from which this type and all other endpoint identity types derive.
    WS_ENDPOINT_IDENTITY identity;
    WS_BYTES             rawCertificateData;
}

///Type for unknown endpoint identity. This type is only used to represent an endpoint identity type that was
///deserialized but was not understood.
struct WS_UNKNOWN_ENDPOINT_IDENTITY
{
    ///The base type from which this type and all other endpoint identity types derive.
    WS_ENDPOINT_IDENTITY identity;
    WS_XML_BUFFER*       element;
}

///Specifies an error specific setting.
struct WS_ERROR_PROPERTY
{
    ///Identifies the WS_ERROR_PROPERTY_ID.
    WS_ERROR_PROPERTY_ID id;
    ///A pointer to the value to set. The pointer must have an alignment compatible with the type of the property.
    void*                value;
    uint                 valueSize;
}

///Contains an explanation of the fault.
struct WS_FAULT_REASON
{
    ///Text describing the fault.
    WS_STRING text;
    WS_STRING lang;
}

///Represents a fault code.
struct WS_FAULT_CODE
{
    ///The local name and namespace URI that identify the fault code.
    WS_XML_QNAME   value;
    WS_FAULT_CODE* subCode;
}

///A Fault is a value carried in the body of a message which conveys a processing failure. Faults are modeled using the
///<b>WS_FAULT</b> structure.
struct WS_FAULT
{
    ///The head of the list of fault codes which identifies the type of fault. The fault codes are ordered from most
    ///generic to most specific. There must be at least one fault code. The first fault code must correspond to a fault
    ///code defined by SOAP. For WS_ENVELOPE_VERSION_SOAP_1_1, only the most specific fault code is serialized (the
    ///first one in the list). If the namespace URI of the first fault code is the empty string, then the first fault
    ///code will be transformed as follows when the fault is serialized, as follows: <ul> <li>The appropriate SOAP
    ///namespace will be used based on the WS_ENVELOPE_VERSION. </li> <li>If the local name is "Sender" when using
    ///WS_ENVELOPE_VERSION_SOAP_1_1, then "Client" will be used instead. </li> <li>If the local name is "Receiver" when
    ///using WS_ENVELOPE_VERSION_SOAP_1_1, then "Server" will be used instead. </li> </ul> These transformations allow a
    ///SOAP fault code to be specified without having to worry about which SOAP version is used.
    WS_FAULT_CODE*   code;
    ///The text describing the fault. This is an array to allow for different languages.
    WS_FAULT_REASON* reasons;
    ///The number of reasons in the reasons array. This would be more than one if the text was represented in multiple
    ///languages. There must be at least one fault reason. For WS_ENVELOPE_VERSION_SOAP_1_1, only the first reason is
    ///serialized.
    uint             reasonCount;
    ///The name of the processor that caused the fault. If the string is zero length, then it's assumed to be the
    ///endpoint.
    WS_STRING        actor;
    ///The location of the processor that caused the fault. If the string is zero length, then it's assumed to be the
    ///endpoint. For WS_ENVELOPE_VERSION_SOAP_1_1, this value is not serialized.
    WS_STRING        node;
    WS_XML_BUFFER*   detail;
}

///A description of the detail element of a fault message.
struct WS_FAULT_DETAIL_DESCRIPTION
{
    ///The action associated with the fault message. If the message does not have an action, this field can be
    ///<b>NULL</b>.
    WS_XML_STRING* action;
    ///The description of the fault detail of the fault. This field must be specified (it may not be <b>NULL</b>).
    WS_ELEMENT_DESCRIPTION* detailElementDescription;
}

///Specifies a heap specific setting.
struct WS_HEAP_PROPERTY
{
    ///Identifies the WS_HEAP_PROPERTY_ID.
    WS_HEAP_PROPERTY_ID id;
    ///A pointer to the value to set. The pointer must have an alignment compatible with the type of the property.
    void*               value;
    uint                valueSize;
}

///A structure that is used to specify a set of WS_HEAP_PROPERTYs.
struct WS_HEAP_PROPERTIES
{
    ///An array of properties. The number of elements in the array is specified using the propertyCount parameter. This
    ///field may be <b>NULL</b> if the propertyCount is 0.
    WS_HEAP_PROPERTY* properties;
    uint              propertyCount;
}

///Specifies a listener specific setting.
struct WS_LISTENER_PROPERTY
{
    ///Identifies the WS_LISTENER_PROPERTY_ID.
    WS_LISTENER_PROPERTY_ID id;
    ///A pointer to the value to set. The pointer must have an alignment compatible with the type of the property.
    void* value;
    uint  valueSize;
}

///Specifies the list of blocked UserAgent sub-string's. This is used with the
///WS_LISTENER_PROPERTY_DISALLOWED_USER_AGENT listener property.
struct WS_DISALLOWED_USER_AGENT_SUBSTRINGS
{
    ///The number of items in 'prefixes'.
    uint        subStringCount;
    WS_STRING** subStrings;
}

///Specifies a set of WS_LISTENER_PROPERTY structures.
struct WS_LISTENER_PROPERTIES
{
    ///An array of properties. The number of elements in the array is specified using the <b>propertyCount</b> member.
    ///This field may be <b>NULL</b> if the propertyCount is 0.
    WS_LISTENER_PROPERTY* properties;
    uint propertyCount;
}

///A structure containing a list of host names.
struct WS_HOST_NAMES
{
    ///A list of host names. Each host name can be a DNS name or an IPv4 or IPv6 address. IPv6 addresses are enclosed in
    ///brackets ('[' address ']').
    WS_STRING* hostNames;
    uint       hostNameCount;
}

///A structure that is used to specify a set of callbacks that form the implementation of a custom listener.
struct WS_CUSTOM_LISTENER_CALLBACKS
{
    ///The callback that implements WsCreateListener. See WS_CREATE_LISTENER_CALLBACK for more information.
    WS_CREATE_LISTENER_CALLBACK createListenerCallback;
    ///The callback that implements WsFreeListener. See WS_FREE_LISTENER_CALLBACK for more information.
    WS_FREE_LISTENER_CALLBACK freeListenerCallback;
    ///The callback that implements WsResetListener. See WS_RESET_LISTENER_CALLBACK for more information.
    WS_RESET_LISTENER_CALLBACK resetListenerCallback;
    ///The callback that implements WsOpenListener. See WS_OPEN_LISTENER_CALLBACK for more information.
    WS_OPEN_LISTENER_CALLBACK openListenerCallback;
    ///The callback that implements WsCloseListener. See WS_CLOSE_LISTENER_CALLBACK for more information.
    WS_CLOSE_LISTENER_CALLBACK closeListenerCallback;
    ///The callback that implements WsAbortListener. See WS_ABORT_LISTENER_CALLBACK for more information.
    WS_ABORT_LISTENER_CALLBACK abortListenerCallback;
    ///The callback that implements WsGetListenerProperty. See WS_GET_LISTENER_PROPERTY_CALLBACK for more information.
    WS_GET_LISTENER_PROPERTY_CALLBACK getListenerPropertyCallback;
    ///The callback that implements WsSetListenerProperty. See WS_SET_LISTENER_PROPERTY_CALLBACK for more information.
    WS_SET_LISTENER_PROPERTY_CALLBACK setListenerPropertyCallback;
    ///The callback that implements WsCreateChannelForListener. See WS_CREATE_CHANNEL_FOR_LISTENER_CALLBACK for more
    ///information.
    WS_CREATE_CHANNEL_FOR_LISTENER_CALLBACK createChannelForListenerCallback;
    ///The callback that implements WsAcceptChannel. See WS_ACCEPT_CHANNEL_CALLBACK for more information.
    WS_ACCEPT_CHANNEL_CALLBACK acceptChannelCallback;
}

///Specifies a message specific setting.
struct WS_MESSAGE_PROPERTY
{
    ///Identifies the WS_MESSAGE_PROPERTY_ID.
    WS_MESSAGE_PROPERTY_ID id;
    ///A pointer to the value to set. The pointer must have an alignment compatible with the type of the property.
    void* value;
    uint  valueSize;
}

///Specifies a set of WS_MESSAGE_PROPERTY structures.
struct WS_MESSAGE_PROPERTIES
{
    ///An array of properties. The number of elements in the array is specified using the propertyCount parameter. This
    ///field may be <b>NULL</b> if the propertyCount is 0.
    WS_MESSAGE_PROPERTY* properties;
    uint                 propertyCount;
}

///Specifies a cryptographic algorithm setting.
struct WS_SECURITY_ALGORITHM_PROPERTY
{
    ///Identifies the WS_SECURITY_ALGORITHM_PROPERTY_ID.
    WS_SECURITY_ALGORITHM_PROPERTY_ID id;
    ///A pointer to the value to set. The pointer must have an alignment compatible with the type of the property.
    void* value;
    uint  valueSize;
}

///Defines the security algorithms and key lengths to be used with WS-Security. This setting is relevant to message
///security bindings and mixed-mode security bindings.
struct WS_SECURITY_ALGORITHM_SUITE
{
    ///Algorithm to use for XML canonicalization, such as the exclusive XML canonicalization algorithm. Setting this
    ///value to WS_SECURITY_ALGORITHM_DEFAULT will default to <b>WS_SECURITY_ALGORITHM_CANONICALIZATION_EXCLUSIVE</b>.
    WS_SECURITY_ALGORITHM_ID canonicalizationAlgorithm;
    ///Algorithm to use for message part digests, such as SHA-1, SHA-256, SHA-384, or SHA-512. Setting this value to
    ///WS_SECURITY_ALGORITHM_DEFAULT will default to <b>WS_SECURITY_ALGORITHM_DIGEST_SHA1</b>.
    WS_SECURITY_ALGORITHM_ID digestAlgorithm;
    ///Algorithm to use for message authentication codes (also known as MACs or symmetric signatures) such as HMAC-SHA1,
    ///HMAC-SHA256, HMAC-SHA384, or HMAC-SHA512. Setting this value to WS_SECURITY_ALGORITHM_DEFAULT will default to
    ///<b>WS_SECURITY_ALGORITHM_SYMMETRIC_SIGNATURE_HMAC_SHA1</b>.
    WS_SECURITY_ALGORITHM_ID symmetricSignatureAlgorithm;
    ///Algorithm to use for asymmetric signatures. Setting this value to WS_SECURITY_ALGORITHM_DEFAULT will default to
    ///<b>WS_SECURITY_ALGORITHM_ASYMMETRIC_SIGNATURE_RSA_SHA1</b>.
    WS_SECURITY_ALGORITHM_ID asymmetricSignatureAlgorithm;
    ///Algorithm to use for message part encryption. Reserved for future use. Should be set to
    ///WS_SECURITY_ALGORITHM_DEFAULT.
    WS_SECURITY_ALGORITHM_ID encryptionAlgorithm;
    ///Algorithm to use for deriving keys from other symmetric keys. Setting this value to WS_SECURITY_ALGORITHM_DEFAULT
    ///will default to <b>WS_SECURITY_ALGORITHM_KEY_DERIVATION_P_SHA1</b>.
    WS_SECURITY_ALGORITHM_ID keyDerivationAlgorithm;
    ///Algorithm to use for encrypting symmetric keys with other symmetric keys. Reserved for future use. Should be set
    ///to WS_SECURITY_ALGORITHM_DEFAULT.
    WS_SECURITY_ALGORITHM_ID symmetricKeyWrapAlgorithm;
    ///Algorithm to use for encrypting symmetric keys with asymmetric keys. Setting this value to
    ///WS_SECURITY_ALGORITHM_DEFAULT will default to <b>WS_SECURITY_ALGORITHM_ASYMMETRIC_KEYWRAP_RSA_OAEP</b>.
    WS_SECURITY_ALGORITHM_ID asymmetricKeyWrapAlgorithm;
    ///The minimum key length (in bits) of symmetric key security tokens. Setting this value to 0 will default to 128
    ///bits.
    uint minSymmetricKeyLength;
    ///The maximum key length (in bits) of symmetric key security tokens. Setting this value to 0 will default to 512
    ///bits.
    uint maxSymmetricKeyLength;
    ///The minimum key length (in bits) of asymmetric key security tokens. Setting this value to 0 will default to 1024
    ///bits.
    uint minAsymmetricKeyLength;
    ///The maximum key length (in bits) of asymmetric key security tokens. Setting this value to 0 will default to 16384
    ///bits.
    uint maxAsymmetricKeyLength;
    ///Algorithm properties. Reserved for future use. Should be set to <b>NULL</b>.
    WS_SECURITY_ALGORITHM_PROPERTY* properties;
    ///Number of entries in properties array. Reserved for future use. Should be set to 0.
    uint propertyCount;
}

///Specifies a channel-wide security setting.
struct WS_SECURITY_PROPERTY
{
    ///Identifies the WS_SECURITY_PROPERTY_ID.
    WS_SECURITY_PROPERTY_ID id;
    ///A pointer to the value to set. The pointer must have an alignment compatible with the type of the property.
    void* value;
    uint  valueSize;
}

///Specifies an array of channel-wide security settings.
struct WS_SECURITY_PROPERTIES
{
    ///An array of properties. The number of elements in the array is specified using the propertyCount parameter. This
    ///field may be <b>NULL</b> if the propertyCount is 0.
    WS_SECURITY_PROPERTY* properties;
    uint propertyCount;
}

///Specifies a security binding specific setting.
struct WS_SECURITY_BINDING_PROPERTY
{
    ///Identifies the WS_SECURITY_BINDING_PROPERTY_ID.
    WS_SECURITY_BINDING_PROPERTY_ID id;
    ///A pointer to the value to set. The pointer must have an alignment compatible with the type of the property.
    void* value;
    uint  valueSize;
}

///Specifies an array of security binding settings.
struct WS_SECURITY_BINDING_PROPERTIES
{
    ///An array of properties. The number of elements in the array is specified using the propertyCount parameter. This
    ///field may be <b>NULL</b> if the propertyCount is 0.
    WS_SECURITY_BINDING_PROPERTY* properties;
    uint propertyCount;
}

///A list of Server Principal Names (SPNs) that are used to validate Extended Protection. Only available on the server.
struct WS_SERVICE_SECURITY_IDENTITIES
{
    ///A array of strings representing the SPNs accepted by the server. Wildcards are not allowed.
    WS_STRING* serviceIdentities;
    uint       serviceIdentityCount;
}

///The <b>WS_CERTIFICATE_VALIDATION_CALLBACK_CONTEXT</b> structure contains the callback function and state for
///validating the certificate for an HTTP connection.
struct WS_CERTIFICATE_VALIDATION_CALLBACK_CONTEXT
{
    ///A WS_CERTIFICATE_VALIDATION_CALLBACK callback that is an application specific callback for validating HTTP
    ///certificates.
    WS_CERTIFICATE_VALIDATION_CALLBACK callback;
    ///Application specific state that is made available to the callback when invoked.
    void* state;
}

///The abstract base type for all certificate credential types.
struct WS_CERT_CREDENTIAL
{
    WS_CERT_CREDENTIAL_TYPE credentialType;
}

///The type for specifying a certificate credential using the certificate's subject name, store location and store name.
///The specified credential is loaded when the containing channel or listener is opened.
struct WS_SUBJECT_NAME_CERT_CREDENTIAL
{
    ///The base type from which this type and all other certificate credential types derive.
    WS_CERT_CREDENTIAL credential;
    ///The certificate store location (such as CERT_SYSTEM_STORE_CURRENT_USER or CERT_SYSTEM_STORE_LOCAL_MACHINE) that
    ///contains the specified certificate.
    uint               storeLocation;
    ///The certificate store name (such as "My") that contains the specified certificate.
    WS_STRING          storeName;
    WS_STRING          subjectName;
}

///The type for specifying a certificate credential using the certificate's thumbprint, store location and store name.
///The specified credential is loaded when the containing channel or listener is opened. The thumbprint is the best
///option for specifying a certificate when subject name based specification is expected to be ambiguous due to the
///presence of multiple certificates with matching subject names in the cert store being specified.
struct WS_THUMBPRINT_CERT_CREDENTIAL
{
    ///The base type from which this type and all other certificate credential types derive.
    WS_CERT_CREDENTIAL credential;
    ///The certificate store location (such as CERT_SYSTEM_STORE_CURRENT_USER or CERT_SYSTEM_STORE_LOCAL_MACHINE) that
    ///contains the specified certificate.
    uint               storeLocation;
    ///The certificate store name (such as "My") that contains the specified certificate.
    WS_STRING          storeName;
    WS_STRING          thumbprint;
}

///The type for specifying a certificate credential that is to be supplied by a callback to the application. This
///callback is invoked to get the certificate during WsOpenChannel on the client side and during WsOpenListener on the
///server side. It is always invoked short.
struct WS_CUSTOM_CERT_CREDENTIAL
{
    ///The base type from which this type and all other certificate credential types derive.
    WS_CERT_CREDENTIAL   credential;
    ///The Callback to get the certificate.
    WS_GET_CERT_CALLBACK getCertCallback;
    ///The state to be passed when invoking the callback.
    void*                getCertCallbackState;
    WS_CERT_ISSUER_LIST_NOTIFICATION_CALLBACK certIssuerListNotificationCallback;
    void*                certIssuerListNotificationCallbackState;
}

///The abstract base type for all credential types used with Windows Integrated Authentication.
struct WS_WINDOWS_INTEGRATED_AUTH_CREDENTIAL
{
    WS_WINDOWS_INTEGRATED_AUTH_CREDENTIAL_TYPE credentialType;
}

///Type for supplying a Windows credential as username, password, domain strings.
struct WS_STRING_WINDOWS_INTEGRATED_AUTH_CREDENTIAL
{
    ///The base type from which this type and all other Windows Integrated Authentication credential types derive.
    WS_WINDOWS_INTEGRATED_AUTH_CREDENTIAL credential;
    ///The username as a string. This must be a valid user. To specify default credentials, use the
    ///WS_DEFAULT_WINDOWS_INTEGRATED_AUTH_CREDENTIAL instead.
    WS_STRING username;
    ///The password for the username as a string. To specify a blank password, the length field of the string must be
    ///set to 0.
    WS_STRING password;
    WS_STRING domain;
}

///Type for supplying a Windows Integrated Authentication credential based on the current Windows identity. If this
///credential subtype is used for a security binding, the current thread token on the thread that calls WsOpenChannel or
///WsOpenServiceProxy is used as the Windows identity when sending messages or making service calls. WsAcceptChannel and
///WsOpenServiceHost do not support this credential type when called from an impersonating thread. This type derives
///from the base type WS_WINDOWS_INTEGRATED_AUTH_CREDENTIAL. For an instance of this type, the type selector field
///<b>credential.credentialType</b> must have the value <b>WS_DEFAULT_WINDOWS_INTEGRATED_AUTH_CREDENTIAL_TYPE</b>.
struct WS_DEFAULT_WINDOWS_INTEGRATED_AUTH_CREDENTIAL
{
    WS_WINDOWS_INTEGRATED_AUTH_CREDENTIAL credential;
}

///Type for supplying a Windows Integrated Authentication credential as an opaque handle created by
///SspiPromptForCredentials and the related family of APIs. This feature is available only on Windows 7 and later.
struct WS_OPAQUE_WINDOWS_INTEGRATED_AUTH_CREDENTIAL
{
    ///The base type from which this type and all other Windows Integrated Authentication credential types derive.
    WS_WINDOWS_INTEGRATED_AUTH_CREDENTIAL credential;
    void* opaqueAuthIdentity;
}

///The abstract base type for all username/password credentials. Note that <b>WS_USERNAME_CREDENTIAL</b> and its
///concrete subtypes are used with the WS-Security WS_USERNAME_MESSAGE_SECURITY_BINDING. They are best suitable for
///application-level username/password pairs, such as those used for online customer accounts. The usernames and
///passwords specified are not interpreted by the security runtime, and are merely carried client-to-server for
///authentication by the specified server-side username/password validator specified by the application. In contrast,
///the WS_WINDOWS_INTEGRATED_AUTH_CREDENTIAL and its concrete subtypes are used for Windows Integrated Authentication
///and the security bindings that use it.
struct WS_USERNAME_CREDENTIAL
{
    WS_USERNAME_CREDENTIAL_TYPE credentialType;
}

///The type for supplying a username/password pair as strings.
struct WS_STRING_USERNAME_CREDENTIAL
{
    ///The base type from which this type and all other username credential types derive.
    WS_USERNAME_CREDENTIAL credential;
    ///The username.
    WS_STRING username;
    WS_STRING password;
}

///The abstract base type for all types that specify a cryptographic key. Such a key is typically specified for a
///generic XML security token or a custom security token.
struct WS_SECURITY_KEY_HANDLE
{
    WS_SECURITY_KEY_HANDLE_TYPE keyHandleType;
}

///The type for specifying a symmetric cryptographic key as raw bytes.
struct WS_RAW_SYMMETRIC_SECURITY_KEY_HANDLE
{
    ///The base type from which this type and all other key handle types derive.
    WS_SECURITY_KEY_HANDLE keyHandle;
    WS_BYTES rawKeyBytes;
}

///The type for specifying asymmetric cryptographic keys as a CryptoNG NCRYPT_KEY_HANDLE. When this structure is used in
///an API (such as with XML token creation) and subsequent <a
///href="/windows/desktop/api/webservices/ns-webservices-ws_xml_token_message_security_binding">use of that XML
///token</a> for a channel), the application is responsible for making sure that the NCRYPT_KEY_HANDLE remains valid as
///long as the key is in use. The application is also responsible for freeing the handle when it is no longer in use.
///This type is supported only on Windows Vista and later platforms.
struct WS_NCRYPT_ASYMMETRIC_SECURITY_KEY_HANDLE
{
    ///The base type from which this type and all other key handle types derive.
    WS_SECURITY_KEY_HANDLE keyHandle;
    size_t asymmetricKey;
}

///The type for specifying asymmetric cryptographic keys as CAPI 1.0 key handles. When this structure is used in an API
///(such as with XML token creation and subsequent <a
///href="/windows/desktop/api/webservices/ns-webservices-ws_xml_token_message_security_binding">use of that XML
///token</a> for a channel), the application is responsible for making sure that the HCRYPTPROV remains valid as long as
///the key is in use. The application is also responsible for freeing the handle when it is no longer in use. This type
///is supported only on pre-Windows Vista platforms: for Windows Vista and later, please use
///WS_NCRYPT_ASYMMETRIC_SECURITY_KEY_HANDLE.
struct WS_CAPI_ASYMMETRIC_SECURITY_KEY_HANDLE
{
    ///The base type from which this type and all other key handle types derive.
    WS_SECURITY_KEY_HANDLE keyHandle;
    ///The cryptographic provider.
    size_t provider;
    uint   keySpec;
}

///The abstract base type for all security bindings. One or more concrete subtypes of this are specified in the security
///description that is supplied during channel and listener creation. Each concrete subtype of this corresponds to a
///security protocol and a way of using it to provide authentication and/or protection to a channel. Each security
///binding subtype instance in the security description contributes one security token at runtime. Thus, the fields of
///this type can be viewed as specifying a security token, how to obtain it, how to use it for channel security, and how
///to modify its behavior using the optional settings.
struct WS_SECURITY_BINDING
{
    ///The WS_SECURITY_BINDING_TYPE of the security binding being described. The type value indicates how to obtain the
    ///security token corresponding to this security binding.
    WS_SECURITY_BINDING_TYPE bindingType;
    ///The array of properties specifying the optional security binding settings. Each WS_SECURITY_BINDING_PROPERTY in
    ///the array is a key-value pair and must use a key defined in WS_SECURITY_BINDING_PROPERTY_ID. This field can be
    ///<b>NULL</b>, and if it is <b>NULL</b>, the default value will be used for each security token setting.
    WS_SECURITY_BINDING_PROPERTY* properties;
    uint propertyCount;
}

///The security binding subtype for specifying the use of SSL/TLS protocol based transport security. This security
///binding is supported only with the WS_HTTP_CHANNEL_BINDING. With this security binding, the following security
///binding properties may be specified: <ul> <li> WS_SECURITY_BINDING_PROPERTY_CERT_FAILURES_TO_IGNORE (client side
///only) </li> <li> WS_SECURITY_BINDING_PROPERTY_DISABLE_CERT_REVOCATION_CHECK (client side only) </li> <li>
///WS_SECURITY_BINDING_PROPERTY_REQUIRE_SSL_CLIENT_CERT (server side only) </li> </ul>
struct WS_SSL_TRANSPORT_SECURITY_BINDING
{
    ///The base type from which this security binding subtype and all other security binding subtypes derive.
    WS_SECURITY_BINDING binding;
    WS_CERT_CREDENTIAL* localCertCredential;
}

///The security binding subtype for specifying the use of the Windows Integrated Authentication protocol (such as
///Kerberos, NTLM or SPNEGO) with the TCP transport. A specific SSP package may be chosen using the security binding
///property WS_SECURITY_BINDING_PROPERTY_WINDOWS_INTEGRATED_AUTH_PACKAGE; if that property is not specified, SPNEGO is
///used by default. The use of NTLM is strongly discouraged due to its security weakness (specifically, lack of server
///authentication). If NTLM is to be allowed, the security binding property
///<b>WS_SECURITY_BINDING_PROPERTY_REQUIRE_SERVER_AUTH</b> must be set to <b>FALSE</b>. This security binding operates
///at the transport security level and is supported only with the WS_TCP_CHANNEL_BINDING. The TCP/Windows SSPI
///combination uses the wire form defined by the NegotiateStreamprotocol and the .Net Message Framing specification. On
///the client side, the security identity of the target server is specified using the identity field of the
///WS_ENDPOINT_ADDRESS parameter supplied during WsOpenChannel. If the identity is a WS_SPN_ENDPOINT_IDENTITY or a
///WS_UPN_ENDPOINT_IDENTITY, that string identity value is used directly with the SSP. If the identity is a
///WS_DNS_ENDPOINT_IDENTITY and the value of its dns field is 'd1', or if no identity is specified in the
///<b>WS_ENDPOINT_ADDRESS</b> and the host component (according to Section 3.2.2 of RFC2396) the address URI is 'd1',
///then the form 'host/d1' is used as the server SPN. Specifying any other WS_ENDPOINT_IDENTITY subtype in
///<b>WS_ENDPOINT_ADDRESS</b> will cause <b>WsOpenChannel</b> to fail. With this security binding, the following
///security binding properties may be specified: <ul> <li> WS_SECURITY_BINDING_PROPERTY_WINDOWS_INTEGRATED_AUTH_PACKAGE
///</li> <li> WS_SECURITY_BINDING_PROPERTY_REQUIRE_SERVER_AUTH (client side only) </li> <li>
///WS_SECURITY_BINDING_PROPERTY_ALLOW_ANONYMOUS_CLIENTS (server side only) </li> <li>
///WS_SECURITY_BINDING_PROPERTY_ALLOWED_IMPERSONATION_LEVEL (client side only) </li> </ul>
struct WS_TCP_SSPI_TRANSPORT_SECURITY_BINDING
{
    ///The base type from which this security binding subtype and all other security binding subtypes derive.
    WS_SECURITY_BINDING binding;
    WS_WINDOWS_INTEGRATED_AUTH_CREDENTIAL* clientCredential;
}

///The security binding subtype for specifying the use of the Windows Integrated Authentication protocol (such as
///Kerberos, NTLM or SPNEGO) with the named pipe transport. A specific SSP package may be chosen using the security
///binding property WS_SECURITY_BINDING_PROPERTY_WINDOWS_INTEGRATED_AUTH_PACKAGE; if that property is not specified,
///SPNEGO is used by default. This security binding operates at the transport security level and is supported only with
///the WS_NAMEDPIPE_CHANNEL_BINDING. The NamedPipe/Windows SSPI combination uses the wire form defined by the
///NegotiateStream protocol and the .Net Message Framing specification. On the client side, the security identity of the
///target server is specified using the identity field of the WS_ENDPOINT_ADDRESS parameter supplied during
///WsOpenChannel. The named pipe binding supports only this one transport security binding and does not support any
///message security bindings. With this security binding, the following security binding properties may be specified:
///<ul> <li> WS_SECURITY_BINDING_PROPERTY_WINDOWS_INTEGRATED_AUTH_PACKAGE </li> <li>
///WS_SECURITY_BINDING_PROPERTY_REQUIRE_SERVER_AUTH (client side only)</li> <li>
///WS_SECURITY_BINDING_PROPERTY_ALLOW_ANONYMOUS_CLIENTS (server side only)</li> <li>
///WS_SECURITY_BINDING_PROPERTY_ALLOWED_IMPERSONATION_LEVEL (client side only)</li> </ul>This type derives from the base
///type WS_SECURITY_BINDING. For an instance of this type, the type selector field <b>bindingType</b> must have the
///value WS_NAMEDPIPE_SSPI_TRANSPORT_SECURITY_BINDING_TYPE.
struct WS_NAMEDPIPE_SSPI_TRANSPORT_SECURITY_BINDING
{
    ///The base type from which this security binding subtype and all other security binding subtypes derive.
    WS_SECURITY_BINDING binding;
    WS_WINDOWS_INTEGRATED_AUTH_CREDENTIAL* clientCredential;
}

///The security binding subtype for specifying the use of HTTP header authentication against a target service or a HTTP
///proxy server based on the basic, digest (RFC 2617) and the SPNEGO (RFC4559) protocols. Since this security binding
///operates at the HTTP header level, it is supported only with the WS_HTTP_CHANNEL_BINDING. By default, this security
///binding is used for the target service. However WS_SECURITY_BINDING_PROPERTY_HTTP_HEADER_AUTH_TARGET security binding
///property can be specified to use it for a HTTP proxy server. This binding provides client authentication, but not
///message protection since the HTTP body is unaffected by this binding. While this security binding can be used alone,
///such usage is not recommended; more typically, HTTP header authentication is done in conjunction with transport level
///security provided by a security binding such as the WS_SSL_TRANSPORT_SECURITY_BINDING. To use this binding without
///SSL, the security description property <b>WS_SECURITY_PROPERTY_TRANSPORT_PROTECTION_LEVEL</b> must be explicitly set
///to <b>WS_PROTECTION_LEVEL_NONE</b>. With this security binding, the following security binding properties may be
///specified: <ul> <li> WS_SECURITY_BINDING_PROPERTY_HTTP_HEADER_AUTH_SCHEME </li> <li>
///WS_SECURITY_BINDING_PROPERTY_HTTP_HEADER_AUTH_TARGET (client side only)</li> <li>
///WS_SECURITY_BINDING_PROPERTY_HTTP_HEADER_AUTH_BASIC_REALM (server side only)</li> <li>
///WS_SECURITY_BINDING_PROPERTY_HTTP_HEADER_AUTH_DIGEST_REALM (server side only)</li> <li>
///WS_SECURITY_BINDING_PROPERTY_HTTP_HEADER_AUTH_DIGEST_DOMAIN (server side only)</li> </ul>
struct WS_HTTP_HEADER_AUTH_SECURITY_BINDING
{
    ///The base type from which this security binding subtype and all other security binding subtypes derive.
    WS_SECURITY_BINDING binding;
    WS_WINDOWS_INTEGRATED_AUTH_CREDENTIAL* clientCredential;
}

///The security binding subtype for specifying the use of the Kerberos AP_REQ ticket as a direct (i.e., without
///establishing a session) security token with WS-Security. Only one instance of this binding may be present in a
///security description. This security binding is not supported with the WS_NAMEDPIPE_CHANNEL_BINDING. With this
///security binding, the following security binding properties may be specified: <ul> <li>
///WS_SECURITY_BINDING_PROPERTY_ALLOWED_IMPERSONATION_LEVEL (client side only) </li> <li>
///WS_SECURITY_BINDING_PROPERTY_ALLOW_ANONYMOUS_CLIENTS (server side only) </li> </ul> In Windows Vista and above on the
///client side, using this binding with HTTP will result in the message being sent using chunked transfer.
struct WS_KERBEROS_APREQ_MESSAGE_SECURITY_BINDING
{
    ///The base type from which this security binding subtype and all other security binding subtypes derive.
    WS_SECURITY_BINDING binding;
    ///How the security token corresponding to this security binding should be attached to a message. Only
    ///WS_SUPPORTING_MESSAGE_SECURITY_USAGE is supported. With this usage, this security binding provides client
    ///authentication, but not message protection (such as signing, encryption, replay detection). Consequently, this
    ///binding is generally used together with another security binding such as the WS_SSL_TRANSPORT_SECURITY_BINDING
    ///that provides a protected channel. To use this binding on HTTP without SSL, the security description property
    ///<b>WS_SECURITY_PROPERTY_TRANSPORT_PROTECTION_LEVEL</b> must be explicitly set to <b>WS_PROTECTION_LEVEL_NONE</b>.
    ///This is not supported on the client or on TCP.
    WS_MESSAGE_SECURITY_USAGE bindingUsage;
    WS_WINDOWS_INTEGRATED_AUTH_CREDENTIAL* clientCredential;
}

///The security binding subtype for specifying the use of an application supplied username / password pair as a direct
///(i.e., one-shot) security token. This security binding may be used only with message security. It provides client
///authentication, but not traffic signing or encryption. So, it is used in conjunction with another transport security
///or message security binding that provides message protection. Only one instance of this binding may be present in a
///security description. This security binding is not supported with the WS_NAMEDPIPE_CHANNEL_BINDING. With this
///security binding, no security binding properties may be specified.
struct WS_USERNAME_MESSAGE_SECURITY_BINDING
{
    ///The base type from which this security binding subtype and all other security binding subtypes derive.
    WS_SECURITY_BINDING binding;
    ///How the security token corresponding to this security binding should be bound to a message. Only
    ///WS_SUPPORTING_MESSAGE_SECURITY_USAGE is supported. With this usage, this security binding provides client
    ///authentication, but not message protection (such as signing, encryption, replay detection). Thus, this binding
    ///must be used together with another security binding such as the WS_SSL_TRANSPORT_SECURITY_BINDING that provides a
    ///protected channel. To use this binding on HTTP without SSL, the security description property
    ///<b>WS_SECURITY_PROPERTY_TRANSPORT_PROTECTION_LEVEL</b> must be explicitly set to <b>WS_PROTECTION_LEVEL_NONE</b>.
    ///This is not supported on the client or on TCP.
    WS_MESSAGE_SECURITY_USAGE bindingUsage;
    ///The username credential to be used with this security binding. This must be specified when this security binding
    ///is used on the client.
    WS_USERNAME_CREDENTIAL* clientCredential;
    ///The validator to be used to check received username/password pairs. This must be specified when this security
    ///binding is used on the service.
    WS_VALIDATE_PASSWORD_CALLBACK passwordValidator;
    void*               passwordValidatorCallbackState;
}

///The top-level structure used to specify the security requirements for a channel (on the client side) or a listener
///(on the server side).
struct WS_SECURITY_DESCRIPTION
{
    ///The array of pointers to security bindings. The set of security bindings supplies determines the kind of security
    ///applied to the channel. Each security binding specifies one security token.
    WS_SECURITY_BINDING** securityBindings;
    ///The count of elements in the securityBindings array.
    uint securityBindingCount;
    ///The array of properties specifying the optional channel-wide security settings. Each WS_SECURITY_PROPERTY in the
    ///array is a key-value pair and must use a key defined in WS_SECURITY_PROPERTY_ID. This field can be <b>NULL</b>,
    ///and if it is <b>NULL</b>, the default value will be used for each security channel setting.
    WS_SECURITY_PROPERTY* properties;
    ///The count of elements in the properties array.
    uint propertyCount;
}

///The security binding subtype for specifying the use of a security context token negotiated between the client and
///server using WS-SecureConversation. This security binding may be used only with message security. It is used to
///establish a message-level security context. Another set of one or more security bindings, specified in the
///bootstrapSecurityDescription field, is used to the bootstrap the context. Only one instance of this binding may be
///present in a security description. This security binding is not supported with the WS_NAMEDPIPE_CHANNEL_BINDING. When
///this binding is used, the channel must complete the receive of at least one message before it can be used to send
///messages. With this security binding, the following security binding properties may be specified: <ul> <li>
///WS_SECURITY_BINDING_PROPERTY_SECURITY_CONTEXT_KEY_SIZE </li> <li>
///WS_SECURITY_BINDING_PROPERTY_SECURITY_CONTEXT_KEY_ENTROPY_MODE </li> <li>
///WS_SECURITY_BINDING_PROPERTY_MESSAGE_PROPERTIES </li> <li> WS_SECURITY_BINDING_PROPERTY_SECURE_CONVERSATION_VERSION
///</li> <li> WS_SECURITY_BINDING_PROPERTY_SECURITY_CONTEXT_SUPPORT_RENEW </li> <li>
///WS_SECURITY_BINDING_PROPERTY_SECURITY_CONTEXT_RENEWAL_INTERVAL </li> <li>
///WS_SECURITY_BINDING_PROPERTY_SECURITY_CONTEXT_ROLLOVER_INTERVAL </li> </ul>
struct WS_SECURITY_CONTEXT_MESSAGE_SECURITY_BINDING
{
    ///The base type from which this security binding subtype and all other security binding subtypes derive.
    WS_SECURITY_BINDING binding;
    ///How the security token corresponding to this security binding should be attached to a message. Currently, only
    ///WS_SUPPORTING_MESSAGE_SECURITY_USAGE is supported. With this usage, this security binding provides client
    ///authentication, but not message protection (such as signing, encryption, replay detection). Thus, this binding
    ///must be used together with another security binding such as the WS_SSL_TRANSPORT_SECURITY_BINDING that provides a
    ///protected channel. To use this binding on HTTP without SSL, the security description property
    ///<b>WS_SECURITY_PROPERTY_TRANSPORT_PROTECTION_LEVEL</b> must be explicitly set to <b>WS_PROTECTION_LEVEL_NONE</b>.
    ///This is not supported on the client or on TCP.
    WS_MESSAGE_SECURITY_USAGE bindingUsage;
    WS_SECURITY_DESCRIPTION* bootstrapSecurityDescription;
}

///Defines a property of a WS_SECURITY_CONTEXT
struct WS_SECURITY_CONTEXT_PROPERTY
{
    ///The identifier of the property.
    WS_SECURITY_CONTEXT_PROPERTY_ID id;
    ///The property value.
    void* value;
    uint  valueSize;
}

///Specifies a property for an XML security token.
struct WS_XML_SECURITY_TOKEN_PROPERTY
{
    ///Identifies the WS_XML_SECURITY_TOKEN_PROPERTY_ID.
    WS_XML_SECURITY_TOKEN_PROPERTY_ID id;
    ///A pointer to the value. The pointer must have an alignment compatible with the type of the property.
    void* value;
    uint  valueSize;
}

///The security binding subtype for specifying the use of a security token that is already available to the application
///in XML form. The security token that is supplied by the application in this binding is presented to a service in a
///WS-Security header according to the bindingUsage specified. This security binding may be included in a security
///description only on the client side. This security binding is not supported with the WS_NAMEDPIPE_CHANNEL_BINDING.
///Although this binding can be used with any token available in XML form, this is commonly used in <a
///href="/windows/desktop/wsw/federation">federation scenarios</a>. For example, a client side token provider such as
///CardSpace may be used to get a token from a security token service, and that token may then be presented to a Web
///Service using this security binding. Security note: As with other security tokens and credentials, the application is
///in charge of the risk assessment decision to disclose a given XML token (supplied by the application in a security
///description) to a given server (supplied by the application when opening the channel). In particular, the application
///should consider the threat that the server might use the XML token it receives from the client, in turn, to pretend
///to be the client to a 3rd party. For this threat, the following mitigations exist: (A) the server authentication
///process makes sure that the message (and hence the token) is sent only to a server that can speak for the address
///specified by the client application; (B) keyless (bearer) tokens are typically usable only at one server (e.g.,
///contoso.com gains little from passing on a contoso.com username/password token to another site -- the application
///security design should make sure this property holds); (C) symmetric keyed tokens are unusable at any server that
///doesn't share the same symmetric key; (D) asymmetric keyed tokens will sign the timestamp and the 'To' header,
///limiting their applicability to the intended 'To' for a narrow time duration. With this security binding, no security
///binding properties may be specified:
struct WS_XML_TOKEN_MESSAGE_SECURITY_BINDING
{
    ///The base type from which this security binding subtype and all other security binding subtypes derive.
    WS_SECURITY_BINDING binding;
    ///How the security token corresponding to this security binding should be bound to a message. Only
    ///WS_SUPPORTING_MESSAGE_SECURITY_USAGE is supported. With this usage, this security binding provides client
    ///authentication, but not message protection (such as signing, encryption, replay detection). Thus, this binding
    ///must be used together with another security binding such as the WS_SSL_TRANSPORT_SECURITY_BINDING that provides a
    ///protected channel.
    WS_MESSAGE_SECURITY_USAGE bindingUsage;
    WS_SECURITY_TOKEN*  xmlToken;
}

///The abstract base type for all SAML authenticators used on the server side to validate incoming SAML tokens.
struct WS_SAML_AUTHENTICATOR
{
    WS_SAML_AUTHENTICATOR_TYPE authenticatorType;
}

///The type for specifying a SAML token authenticator based on an array of expected issuer certificates. When an
///authenticator of this type is used, an incoming SAML token will be accepted if only if it has a valid XML signature
///created with any one of the specified X.509 certificates. Thus, the specified X.509 certificates represent a 'allow
///list' of trusted SAML issuers. No revocation or chain trust checks are done by the runtime on the specified
///certificates: so, it is up to the application to make sure that the certificates are valid before they are specified
///in this structure. As indicated above, the validation of the received SAML is limited to making sure that it was
///signed correctly by one of the specified certificates. The application may then extract the SAML assertion using
///WsGetMessageProperty with the key WS_MESSAGE_PROPERTY_SAML_ASSERTION and do additional validator or processing.
struct WS_CERT_SIGNED_SAML_AUTHENTICATOR
{
    ///The base type from which this type and all other SAML authenticator types derive.
    WS_SAML_AUTHENTICATOR authenticator;
    ///The array of acceptable SAML issuers, identified by their X.509 certificates. This field is required. The
    ///certificate handles are duplicated and the copies are kept for internal use. The application continues to own the
    ///certificate handles supplied here and is responsible for freeing them anytime after the listener creation call
    ///that uses this structure returns.
    const(CERT_CONTEXT)** trustedIssuerCerts;
    ///The count of X.509 certificates specified in trustedIssuerCerts.
    uint                 trustedIssuerCertCount;
    ///The certificate for decrypting incoming SAML tokens. The certificate handle is duplicated and the copy is kept
    ///for internal use. The application continues to own the certificate handle supplied here and is responsible for
    ///freeing it anytime after the listener creation call that uses this structure returns.
    const(CERT_CONTEXT)* decryptionCert;
    ///An optional callback to enable the application to additional validation on the SAML assertion if the signature
    ///validation passes.
    WS_VALIDATE_SAML_CALLBACK samlValidator;
    void*                samlValidatorCallbackState;
}

///The security binding subtype for specifying the use of a SAML assertion as a message security token. The SAML token
///is expected to be presented to a service in a WS-Security header according to the bindingUsage specified. This
///security binding may be included in a security description only on the server side. Only one instance of this binding
///may be present in a security description. This security binding is not supported with the
///WS_NAMEDPIPE_CHANNEL_BINDING. For a federated security scenario that involves getting a security token from an issuer
///and then presenting it to a service, one may use WsRequestSecurityTokentogether with the
///WS_XML_TOKEN_MESSAGE_SECURITY_BINDING on the client side, and this binding on the server side. The extent of
///validation performed on the received SAML depends on the authenticator specified. If additional validation is
///required, the application may get the received SAML assertion using WsGetMessageProperty with the key
///WS_MESSAGE_PROPERTY_SAML_ASSERTION and do further processing. With this security binding, no security binding
///properties may be specified:
struct WS_SAML_MESSAGE_SECURITY_BINDING
{
    ///The base type from which this security binding subtype and all other security binding subtypes derive.
    WS_SECURITY_BINDING binding;
    ///How the security token corresponding to this security binding should be bound to a message. Only
    ///WS_SUPPORTING_MESSAGE_SECURITY_USAGE is supported. With this usage, this security binding provides client
    ///authentication, but not message protection (such as signing, encryption, replay detection). Thus, this binding
    ///must be used together with another security binding such as the WS_SSL_TRANSPORT_SECURITY_BINDING that provides a
    ///protected channel. To use this binding on HTTP without SSL, the security description property
    ///<b>WS_SECURITY_PROPERTY_TRANSPORT_PROTECTION_LEVEL</b> must be explicitly set to <b>WS_PROTECTION_LEVEL_NONE</b>.
    ///This is not supported on the client or on TCP.
    WS_MESSAGE_SECURITY_USAGE bindingUsage;
    WS_SAML_AUTHENTICATOR* authenticator;
}

///Specifies a property for requesting a security token from an issuer.
struct WS_REQUEST_SECURITY_TOKEN_PROPERTY
{
    ///Identifies the WS_REQUEST_SECURITY_TOKEN_PROPERTY_ID.
    WS_REQUEST_SECURITY_TOKEN_PROPERTY_ID id;
    ///A pointer to the value. The pointer must have an alignment compatible with the type of the property.
    void* value;
    uint  valueSize;
}

///This type is used to store an attribute that has not been directly mapped to a field.
struct WS_ANY_ATTRIBUTE
{
    ///Specifies the localName of the attribute.
    WS_XML_STRING localName;
    ///Specifies the namespace of the attribute.
    WS_XML_STRING ns;
    ///Specifies the value of the attribute. This field may not be <b>NULL</b>.
    WS_XML_TEXT*  value;
}

///This type is used to store a set of attributes that have not been directly mapped to field of a structure.
struct WS_ANY_ATTRIBUTES
{
    ///An array of attributes. This field may be <b>NULL</b> if attributeCount is zero.
    WS_ANY_ATTRIBUTE* attributes;
    ///The number of attributes in the array.
    uint              attributeCount;
}

///Specifies constraints on the set of values which can be deserialized.This type description is used with WS_BOOL_TYPE
///and is optional.
struct WS_BOOL_DESCRIPTION
{
    BOOL value;
}

///An optional type description used with WS_GUID_TYPE to specify constraints on the set of values which can be
///deserialized.
struct WS_GUID_DESCRIPTION
{
    GUID value;
}

///This type description is used with WS_DATETIME_TYPE and is optional. It is used to specify constraints on the set of
///values which can be deserialized. Only the <b>ticks</b> member of the WS_DATETIME is compared.
struct WS_DATETIME_DESCRIPTION
{
    ///The minimum value.
    WS_DATETIME minValue;
    WS_DATETIME maxValue;
}

///Represents a xsd:duration data type.
struct WS_DURATION
{
    ///If <b>TRUE</b>, this represents a negative duration.
    BOOL negative;
    ///The number of years.
    uint years;
    ///The number of months.
    uint months;
    ///The number of days.
    uint days;
    ///The number of hours.
    uint hours;
    ///The number of minutes.
    uint minutes;
    ///The number of seconds.
    uint seconds;
    ///The number of milliseconds. This value must be less than 1000.
    uint milliseconds;
    uint ticks;
}

///An optional type description used with WS_DURATION_TYPE. It is used to specify constraints on the set of values which
///can be deserialized.
struct WS_DURATION_DESCRIPTION
{
    ///The minimum value.
    WS_DURATION minValue;
    ///The maximum value.
    WS_DURATION maxValue;
    WS_DURATION_COMPARISON_CALLBACK comparer;
}

///This type description is used with WS_TIMESPAN_TYPE and is optional. It is used to specify constraints on the set of
///values which can be deserialized.
struct WS_TIMESPAN_DESCRIPTION
{
    ///The minimum value.
    WS_TIMESPAN minValue;
    WS_TIMESPAN maxValue;
}

///An optional type description used with WS_UNIQUE_ID_TYPE to specify constraints on the set of values which can be
///deserialized.
struct WS_UNIQUE_ID_DESCRIPTION
{
    ///The minimum number of characters. This only pertains to the case where the unique ID is represented as a string.
    uint minCharCount;
    uint maxCharCount;
}

///This type description is used with WS_STRING_TYPE and is optional. It is used to specify constraints on the set of
///values which can be deserialized.
struct WS_STRING_DESCRIPTION
{
    ///Specifies the minimum number of characters.
    uint minCharCount;
    uint maxCharCount;
}

///This type description is used with WS_XML_STRING_TYPE and is optional. It is used to specify constraints on the set
///of values which can be deserialized.
struct WS_XML_STRING_DESCRIPTION
{
    ///The minimum number of bytes of UTF8 character data.
    uint minByteCount;
    uint maxByteCount;
}

///This type description is used with WS_XML_QNAME_TYPE and is optional. It is used to specify constraints on the set of
///values which can be deserialized.
struct WS_XML_QNAME_DESCRIPTION
{
    ///The minimum number of bytes of UTF8 character data for the local name string.
    uint minLocalNameByteCount;
    ///The maximum number of bytes of UTF8 character data for the local name string.
    uint maxLocalNameByteCount;
    ///The minimum number of bytes of UTF8 character data for the namespace string.
    uint minNsByteCount;
    uint maxNsByteCount;
}

///Specifies constraints on the set of values which can be deserialized.This type description is used with
///WS_CHAR_ARRAY_TYPE and is optional.
struct WS_CHAR_ARRAY_DESCRIPTION
{
    ///The minimum number of characters.
    uint minCharCount;
    uint maxCharCount;
}

///Specifies constraints on the set of values which can be deserialized.This type description is used with
///WS_BYTE_ARRAY_TYPE and is optional.
struct WS_BYTE_ARRAY_DESCRIPTION
{
    ///Specifies the minimum number of bytes.
    uint minByteCount;
    uint maxByteCount;
}

///This type description is used with WS_UTF8_ARRAY_TYPE and is optional. It is used to specify constraints on the set
///of values which can be deserialized.
struct WS_UTF8_ARRAY_DESCRIPTION
{
    ///Specifies the minimum number of bytes of UTF8 character data.
    uint minByteCount;
    uint maxByteCount;
}

///This type description is used with WS_WSZ_TYPE and is optional. It is used to specify constraints on the set of
///values which can be deserialized.
struct WS_WSZ_DESCRIPTION
{
    ///Specifies the minimum number of characters (not including the terminating '\0' character).
    uint minCharCount;
    uint maxCharCount;
}

///An optional type description used with WS_INT8_TYPE to specify constraints on the set of values which can be
///deserialized.
struct WS_INT8_DESCRIPTION
{
    ///The minimum value.
    byte minValue;
    byte maxValue;
}

///An optional type description used with WS_UINT8_TYPE to specify constraints on the set of values which can be
///deserialized.
struct WS_UINT8_DESCRIPTION
{
    ///The minimum value.
    ubyte minValue;
    ubyte maxValue;
}

///An optional type description used with WS_INT16_TYPE to specify constraints on the set of values which can be
///deserialized.
struct WS_INT16_DESCRIPTION
{
    ///The minimum value.
    short minValue;
    short maxValue;
}

///An optional type description used with WS_UINT16_TYPE to specify constraints on the set of values which can be
///deserialized.
struct WS_UINT16_DESCRIPTION
{
    ///The minimum value.
    ushort minValue;
    ushort maxValue;
}

///An optional type description used with WS_INT32_TYPE to specify constraints on the set of values which can be
///deserialized.
struct WS_INT32_DESCRIPTION
{
    ///The minimum value.
    int minValue;
    int maxValue;
}

///An optional type description used with WS_UINT32_TYPE to specify constraints on the set of values which can be
///deserialized.
struct WS_UINT32_DESCRIPTION
{
    ///The minimum value.
    uint minValue;
    uint maxValue;
}

///An optional type description used with WS_INT64_TYPE to specify constraints on the set of values which can be
///deserialized.
struct WS_INT64_DESCRIPTION
{
    ///The minimum value.
    long minValue;
    long maxValue;
}

///An optional type description used with WS_UINT64_TYPE to specify constraints on the set of values which can be
///deserialized.
struct WS_UINT64_DESCRIPTION
{
    ///The minimum value.
    ulong minValue;
    ulong maxValue;
}

///An optional type description used with WS_FLOAT_TYPE to specify constraints on the set of values which can be
///deserialized.
struct WS_FLOAT_DESCRIPTION
{
    ///The minimum value.
    float minValue;
    float maxValue;
}

///An optional type description used with WS_DOUBLE_TYPE. It is used to specify constraints on the set of values which
///can be deserialized.
struct WS_DOUBLE_DESCRIPTION
{
    ///The minimum value.
    double minValue;
    double maxValue;
}

///An optional type description used with WS_DECIMAL_TYPE. It is used to specify constraints on the set of values which
///can be deserialized.
struct WS_DECIMAL_DESCRIPTION
{
    ///The minimum value.
    DECIMAL minValue;
    DECIMAL maxValue;
}

///Specifies constraints on the set of values which can be deserialized. This type description is used with
///WS_BYTES_TYPE and is optional.
struct WS_BYTES_DESCRIPTION
{
    ///Specifies the minimum number of bytes.
    uint minByteCount;
    uint maxByteCount;
}

///Provides serialization information about a single value that is part of an enumeration (WS_ENUM_DESCRIPTION).
struct WS_ENUM_VALUE
{
    ///The numeric enum value.
    int            value;
    WS_XML_STRING* name;
}

///A type description that is used with WS_ENUM_TYPE and is required. It provides information used in serializing and
///deserializing values of an enumeration.
struct WS_ENUM_DESCRIPTION
{
    ///Points to an array of enumeration values and their corresponding names. There must not be duplicate values or
    ///names in the array.
    WS_ENUM_VALUE* values;
    ///The number of items in the values array.
    uint           valueCount;
    ///The length, in UTF8 bytes, of the longest name in the values array.
    uint           maxByteCount;
    ///An optional array that provides information which can improve the performance of mapping enumeration values to
    ///names and back. This array may <b>NULL</b>, in which case an O(n) lookup is used, which may be sufficient for
    ///small numbers of enumerated values. If non-<b>NULL</b>, the following must be true: <ul> <li>The values array is
    ///required to be sorted by value, in ascending order. </li> <li>The nameIndices array points to an array that has
    ///valueCount items. </li> <li>The nameIndices array provides the indices of the items in the values array as if
    ///they were sorted by name in ascending order. The names should by sorted by performing a byte-wise comparison of
    ///the utf-8 string. </li> </ul>
    uint*          nameIndices;
}

///Defines the minimum and maximum number of items that may appear when using WS_REPEATING_ELEMENT_FIELD_MAPPING,
///<b>WS_REPEATING_ELEMENT_CHOICE_FIELD_MAPPING</b>, or <b>WS_REPEATING_ANY_ELEMENT_FIELD_MAPPING</b> within a
///WS_FIELD_DESCRIPTION. The constraint is only enforced during deserialization.
struct WS_ITEM_RANGE
{
    ///The minimum number of elements that must appear.
    uint minItemCount;
    uint maxItemCount;
}

///Defines a default value for a field. This is used in a WS_FIELD_DESCRIPTION.
struct WS_DEFAULT_VALUE
{
    ///A pointer to the default value.
    void* value;
    uint  valueSize;
}

///Represents serialization information about a field within a structure.
struct WS_FIELD_DESCRIPTION
{
    ///Identifies how the field maps to the XML. See WS_FIELD_MAPPING for the ways that the field can be exposed in the
    ///XML content.
    WS_FIELD_MAPPING  mapping;
    ///The XML local name to use for the field. This field is required, except in the following case, where it may be
    ///<b>NULL</b>. If the mapping field is WS_REPEATING_ELEMENT_FIELD_MAPPING, then this identifies the local name of
    ///the "wrapper" element that is the parent element of the array item elements. Setting this field (and the ns
    ///field) to <b>NULL</b>will omit the wrapper element. The ns and localName fields must be either both specified or
    ///both <b>NULL</b>.
    WS_XML_STRING*    localName;
    ///The XML namespace to use for the field. This field is required, except in the following case, where it may be
    ///<b>NULL</b>. If the mapping field is WS_REPEATING_ELEMENT_FIELD_MAPPING, then this identifies the namespace of
    ///the "wrapper" element that is the parent element of the array item elements. Setting this field (and the
    ///localName field) to <b>NULL</b>will omit the wrapper element. The ns and localName fields must be either both
    ///specified or both <b>NULL</b>.
    WS_XML_STRING*    ns;
    ///The type of the field. See WS_TYPE for a list of supported types.
    WS_TYPE           type;
    ///Additional information about the type. Each type has a different description structure. This may be <b>NULL</b>,
    ///depending on the WS_TYPE.
    void*             typeDescription;
    ///The offset of the field within the containing structure.
    uint              offset;
    ///Additional flags for the field. See WS_FIELD_OPTIONS for a list of flags. If no flags are needed, this may be 0.
    uint              options;
    ///Points to a default value for the field. This is used in the following instances: <ul> <li> WS_FIELD_OPTIONAL was
    ///specified, and the XML did not contain the value. </li> <li> WS_NO_FIELD_MAPPING was specified. </li> </ul> If
    ///defaultValue is <b>NULL</b>, then it is the same as having a default value of all zero's.
    WS_DEFAULT_VALUE* defaultValue;
    ///The structure offset of the ULONG field that represents the number of items in the array. This field is used when
    ///using WS_REPEATING_ELEMENT_FIELD_MAPPING or array types (WS_CHAR_ARRAY_TYPE, <b>WS_UTF8_ARRAY_TYPE</b>,
    ///<b>WS_BYTE_ARRAY_TYPE</b>). In other cases, it does not need to be specified (it can be 0).
    uint              countOffset;
    ///The XML local name to use for the repeating elements when using WS_REPEATING_ELEMENT_FIELD_MAPPING. In other
    ///cases this field does not need to be specified (it can be <b>NULL</b>).
    WS_XML_STRING*    itemLocalName;
    ///The XML namespace to use for the repeating elements when using WS_REPEATING_ELEMENT_FIELD_MAPPING. In other cases
    ///this field does not need to be specified (it can be <b>NULL</b>).
    WS_XML_STRING*    itemNs;
    WS_ITEM_RANGE*    itemRange;
}

///Represents serialization information about a field within a union. See WS_UNION_DESCRIPTION.
struct WS_UNION_FIELD_DESCRIPTION
{
    ///The enumeration value that field of the union corresponds to. See WS_FIELD_DESCRIPTION and WS_UNION_DESCRIPTION.
    int                  value;
    WS_FIELD_DESCRIPTION field;
}

///Information about C struct type, and how it maps to an XML element. This is used with WS_STRUCT_TYPE.
struct WS_STRUCT_DESCRIPTION
{
    ///The size of the structure, in bytes.
    uint           size;
    ///The alignment requirement of the structure. This must be a power of two between 1 and 8.
    uint           alignment;
    ///An array of pointers to the descriptions of the fields of the structure. See the Remarks section for information
    ///about ordering of the fields in this array.
    WS_FIELD_DESCRIPTION** fields;
    ///The number of fields in the fields array. Any part of the structure that is not represented by a field will be
    ///left uninitialized. No two fields descriptions may reference the same offset of the structure.
    uint           fieldCount;
    ///The XML type name of the structure. This is only used when structures derive from other structures, and may be
    ///<b>NULL</b> otherwise.
    WS_XML_STRING* typeLocalName;
    ///The XML type namespace of the structure. This is only used when structures derive from other structures, and may
    ///be <b>NULL</b> otherwise.
    WS_XML_STRING* typeNs;
    ///The type this type is derived from. This is only used when structures derive from other structures, and may be
    ///<b>NULL</b> otherwise.
    WS_STRUCT_DESCRIPTION* parentType;
    ///An array of pointers to derived types. This is only used when structures derive from other structures, and may be
    ///<b>NULL</b> otherwise.
    WS_STRUCT_DESCRIPTION** subTypes;
    ///The number of types in the subTypes array. This is only used when structures derive from other structures, and
    ///may be <b>NULL</b> otherwise.
    uint           subTypeCount;
    uint           structOptions;
}

///Information about the choices within a union type. This is used with WS_UNION_TYPE.
struct WS_UNION_DESCRIPTION
{
    ///The size in bytes of the structure.
    uint  size;
    ///The alignment requirement of the structure. This must be a power of two between 1 and 8.
    uint  alignment;
    ///An array of pointers to the descriptions of the fields of the union. See the Remarks section for information
    ///about ordering of the fields in this array.
    WS_UNION_FIELD_DESCRIPTION** fields;
    ///The number of fields in the fields array. Any part of the structure that is not represented by a field will be
    ///left uninitialized. Fields descriptions may reference the same offset of the structure (for example if they are
    ///all part of a single union).
    uint  fieldCount;
    ///The offset of the enumeration field which controls which choice is selected within the union. The size of the
    ///field is assumed to be the size of an enumeration (32-bit signed integer).
    uint  enumOffset;
    ///This value corresponds to the enum value used when none of the choices are currently set. This field is only used
    ///when the field is optional (WS_FIELD_OPTIONAL was specified).
    int   noneEnumValue;
    ///This optional array provides information which can improve the performance of looking up fields of the union
    ///either by element or by enum value. This array may <b>NULL</b>, in which case an O(n) lookup is used, which may
    ///be sufficient for small numbers of fields. If non-<b>NULL</b>, the following must be true: <ul> <li>The fields
    ///array is required to be sorted by element, in ascending order. When comparing an element the namespace should be
    ///compared first, then the local name. Each of the names should be compared by performing a byte-wide comparison of
    ///the utf-8 string. The field that uses WS_ANY_ELEMENT_FIELD_MAPPING, if present, should always be last in the
    ///fields array. </li> <li>The valueIndices array points to an array that has fieldCount items. The valueIndices
    ///array provides the indices of the items in the fields array as if they were sorted by value in ascending order.
    ///</li> </ul>
    uint* valueIndices;
}

///Information about a mapping between an WS_ENDPOINT_ADDRESSand an XML element.
struct WS_ENDPOINT_ADDRESS_DESCRIPTION
{
    WS_ADDRESSING_VERSION addressingVersion;
}

///Information about a mapping between an WS_FAULT and an XML element.
struct WS_FAULT_DESCRIPTION
{
    WS_ENVELOPE_VERSION envelopeVersion;
}

///Specifies information about a field which is neither serialized nor deserialized. This is used with WS_VOID_TYPE and
///WS_NO_FIELD_MAPPINGwithin a WS_FIELD_DESCRIPTION. This type description is only required when WS_FIELD_POINTER is not
///being used.
struct WS_VOID_DESCRIPTION
{
    uint size;
}

///Represents a custom mapping between a C data type and an XML element.User-defined callbacks are invoked to do the
///actual reading and writing.
struct WS_CUSTOM_TYPE_DESCRIPTION
{
    ///The size of the custom type, in bytes.
    uint  size;
    ///The alignment requirement of the custom type. This must be a power of two between 1 and 8.
    uint  alignment;
    ///A pointer to a callback which is invoked to read the type.
    WS_READ_TYPE_CALLBACK readCallback;
    ///A pointer to a callback which is invoked to write the type.
    WS_WRITE_TYPE_CALLBACK writeCallback;
    ///This can be used to point to additional user-defined data specific to the type. It is optional and may be
    ///<b>NULL</b>. The pointer to this data is passed to the WS_READ_TYPE_CALLBACK and the WS_WRITE_TYPE_CALLBACK. This
    ///allows the callback to access information that is specific to this particular usage of the callback.
    void* descriptionData;
    WS_IS_DEFAULT_VALUE_CALLBACK isDefaultValueCallback;
}

///Represents a mapping between a C data type and an XML attribute.
struct WS_ATTRIBUTE_DESCRIPTION
{
    ///The local name of the XML attribute.
    WS_XML_STRING* attributeLocalName;
    ///The namespace of the XML attribute.
    WS_XML_STRING* attributeNs;
    ///The type that corresponds to the XML attribute. Not all types support being read and written as attributes. If
    ///the documentation for the WS_TYPE indicates it supports WS_ATTRIBUTE_TYPE_MAPPING, then it can be used with this
    ///structure.
    WS_TYPE        type;
    void*          typeDescription;
}

///The index of the parameters in the incoming/outgoing messages field descriptions.
struct WS_PARAMETER_DESCRIPTION
{
    ///The type of the parameter.
    WS_PARAMETER_TYPE parameterType;
    ///A value between 0 and MAX_SHORT - 1 that represents the index of the field in the input WS_MESSAGE. It is
    ///MAX_USHORT if it has not present in the input WS_MESSAGE.
    ushort            inputMessageIndex;
    ushort            outputMessageIndex;
}

///Metadata for the service operation.
struct WS_OPERATION_DESCRIPTION
{
    ///Defines the version information. Currently value is 1.
    uint               versionInfo;
    ///The description of incoming WS_MESSAGE for a given service operation.
    WS_MESSAGE_DESCRIPTION* inputMessageDescription;
    ///The description of outgoing WS_MESSAGE for a given service operation. For one way operations this should be
    ///<b>NULL</b>.
    WS_MESSAGE_DESCRIPTION* outputMessageDescription;
    ///Provides additional flags for the in message of the operation. See WS_SERVICE_OPERATION_MESSAGE_OPTION for a list
    ///of flags. If no flags are needed, this may be 0. WS_SERVICE_OPERATION_MESSAGE_NILLABLE_ELEMENT is not applicable
    ///to WS_RPC_LITERAL_OPERATION style operations. The input parameter must be with type of
    ///WS_PARAMETER_TYPE_MESSAGES.
    uint               inputMessageOptions;
    ///Provides additional flags for the out message of the operation. See WS_SERVICE_OPERATION_MESSAGE_OPTION for a
    ///list of flags. If out message is not available, or no flags are needed, this may be 0.
    ///WS_SERVICE_OPERATION_MESSAGE_NILLABLE_ELEMENT is not applicable to WS_RPC_LITERAL_OPERATION style operations. The
    ///output parameter must be with type of WS_PARAMETER_TYPE_MESSAGES.
    uint               outputMessageOptions;
    ///The number of parameters on the given service operation.
    ushort             parameterCount;
    ///An array defining the individual parameters.
    WS_PARAMETER_DESCRIPTION* parameterDescription;
    ///A pointer to the stub function for the given operation to which the service model will delegate to do the service
    ///operation call. This will be <b>NULL</b> for proxies.
    WS_SERVICE_STUB_CALLBACK stubCallback;
    WS_OPERATION_STYLE style;
}

///The metadata for a service contract for service model.
struct WS_CONTRACT_DESCRIPTION
{
    ///The total number of service operations that are part of the contract.
    uint operationCount;
    WS_OPERATION_DESCRIPTION** operations;
}

///Specifies a service contract on an endpoint.
struct WS_SERVICE_CONTRACT
{
    ///The typed contract metadata. See WS_CONTRACT_DESCRIPTION. Optional, if <b>defaultMessageHandlerCallback</b> is
    ///given.
    const(WS_CONTRACT_DESCRIPTION)* contractDescription;
    ///Callback for processing unhandled messages. Optional if contractDescription is given.
    WS_SERVICE_MESSAGE_RECEIVE_CALLBACK defaultMessageHandlerCallback;
    const(void)* methodTable;
}

///Specifies a service specific setting.
struct WS_SERVICE_PROPERTY
{
    ///Identifies the WS_SERVICE_PROPERTY_ID.
    WS_SERVICE_PROPERTY_ID id;
    ///A pointer to the value to set. The pointer must have an alignment compatible with the type of the property.
    void* value;
    uint  valueSize;
}

///Specifies a service specific setting.
struct WS_SERVICE_ENDPOINT_PROPERTY
{
    ///Identifies the WS_SERVICE_ENDPOINT_PROPERTY_ID.
    WS_SERVICE_ENDPOINT_PROPERTY_ID id;
    ///A pointer to the value to set. The pointer must have an alignment compatible with the type of the property.
    void* value;
    uint  valueSize;
}

///Specifies the callback which is called when a channel is successfully accepted.
struct WS_SERVICE_PROPERTY_ACCEPT_CALLBACK
{
    WS_SERVICE_ACCEPT_CHANNEL_CALLBACK callback;
}

///Specifies the individual documents that make up the service metadata.
struct WS_SERVICE_METADATA_DOCUMENT
{
    ///A WS_XML_STRING* representing the specific XML Schema, WSDL or a Policy document. The service model expects this
    ///to be valid for the lifetime of the WS_SERVICE_HOST.
    WS_XML_STRING* content;
    WS_STRING*     name;
}

///Specifies the service metadata documents array. This can be a collection of WSDL/XSD documents represented as an
///array of WS_STRING.
struct WS_SERVICE_METADATA
{
    ///The count of metadata documents being specified.
    uint           documentCount;
    ///A WS_SERVICE_METADATA_DOCUMENT* array where element represents a WS_SERVICE_METADATA_DOCUMENT for each individual
    ///XML Schema, WSDL or a Policy document. The service model expects this to be valid for the lifetime of the
    ///WS_SERVICE_HOST.
    WS_SERVICE_METADATA_DOCUMENT** documents;
    ///Reference to WS_XML_STRING representing the name of the service in the WSDL document. Note that this field must
    ///be specified along with the serviceNs field. The service model expects this to be valid for the lifetime of the
    ///WS_SERVICE_HOST.
    WS_XML_STRING* serviceName;
    WS_XML_STRING* serviceNs;
}

///Specifies the callback which is called when a channel is about to be closed. See, WS_SERVICE_CLOSE_CHANNEL_CALLBACK
///for details.
struct WS_SERVICE_PROPERTY_CLOSE_CALLBACK
{
    WS_SERVICE_CLOSE_CHANNEL_CALLBACK callback;
}

///Represents the port element for the endpoint. The port element is generated for the service element as specified by
///serviceName and serviceNs for WS_SERVICE_PROPERTY_METADATA property on the WS_SERVICE_HOST. Note, the port type will
///only be generated into the WSDL document if the service element is generated by the runtime.
struct WS_SERVICE_ENDPOINT_METADATA
{
    ///The name of the port. The service model expects this to be valid for the lifetime of the WS_SERVICE_HOST.
    WS_XML_STRING* portName;
    ///Name of the binding associated with the port. The service model expects this to be valid for the lifetime of the
    ///WS_SERVICE_HOST.
    WS_XML_STRING* bindingName;
    WS_XML_STRING* bindingNs;
}

///Represents an individual endpoint on a service host. The properties on the endpoint are used to specify the address,
///binding and contract.
struct WS_SERVICE_ENDPOINT
{
    ///The URL address on which the endpoint is going to listen.
    WS_ENDPOINT_ADDRESS address;
    ///The binding for the channel/listener.
    WS_CHANNEL_BINDING  channelBinding;
    ///The type of channel being hosted by the endpoint.
    WS_CHANNEL_TYPE     channelType;
    ///A description of the security required for this channel. This can be <b>NULL</b> if no security is required.
    const(WS_SECURITY_DESCRIPTION)* securityDescription;
    ///The contract of the endpoint.
    const(WS_SERVICE_CONTRACT)* contract;
    ///Authorization callback for the service endpoint.
    WS_SERVICE_SECURITY_CALLBACK authorizationCallback;
    ///An array of properties to configure the service endpoint.
    const(WS_SERVICE_ENDPOINT_PROPERTY)* properties;
    ///Number of elements in the WS_SERVICE_ENDPOINT_PROPERTY array.
    uint                propertyCount;
    WS_CHANNEL_PROPERTIES channelProperties;
}

///Specifies a proxy property.
struct WS_PROXY_PROPERTY
{
    ///Identifies the WS_PROXY_PROPERTY_ID.
    WS_PROXY_PROPERTY_ID id;
    ///The buffer for the property value.
    void*                value;
    uint                 valueSize;
}

///Specifies the callback function and state for an application that wishes to associate or inspect headers in an input
///or an output message respectively. See also, WS_CALL_PROPERTY_SEND_MESSAGE_CONTEXT and
///<b>WS_CALL_PROPERTY_RECEIVE_MESSAGE_CONTEXT</b>.
struct WS_PROXY_MESSAGE_CALLBACK_CONTEXT
{
    ///application specific callback for handling the message.
    WS_PROXY_MESSAGE_CALLBACK callback;
    void* state;
}

///Specifies a proxy property.
struct WS_CALL_PROPERTY
{
    ///Identifies the WS_CALL_PROPERTY_ID.
    WS_CALL_PROPERTY_ID id;
    ///Pointer to a buffer for the value of the property. The pointer must have an alignment compatible with the type of
    ///the property.
    void*               value;
    uint                valueSize;
}

///The abstract base type for all URL schemes used with WsDecodeUrl and WsEncodeUrl APIs.
struct WS_URL
{
    WS_URL_SCHEME_TYPE scheme;
}

///The URL subtype for specifying an HTTP URL.
struct WS_HTTP_URL
{
    ///The base type from which this URL subtype and all other URL subtypes derive. The WS_URL_SCHEME_TYPE is
    ///<b>WS_URL_HTTP_SCHEME_TYPE</b>.
    WS_URL    url;
    ///The host name.
    WS_STRING host;
    ///The port number.
    ushort    port;
    ///The port number as string.
    WS_STRING portAsString;
    ///The path.
    WS_STRING path;
    ///The query.
    WS_STRING query;
    ///The fragment.
    WS_STRING fragment;
}

///The URL subtype for specifying an HTTPS URL.
struct WS_HTTPS_URL
{
    ///The base type from which this URL subtype and all other URL subtypes derive. The WS_URL_SCHEME_TYPE is
    ///<b>WS_URL_HTTPS_SCHEME_TYPE</b>.
    WS_URL    url;
    ///The host name.
    WS_STRING host;
    ///The port number.
    ushort    port;
    ///The port number as string.
    WS_STRING portAsString;
    ///The path.
    WS_STRING path;
    ///The query.
    WS_STRING query;
    ///The fragment.
    WS_STRING fragment;
}

///The URL subtype for specifying an net.tcp URL.
struct WS_NETTCP_URL
{
    ///The base type from which this URL subtype and all other URL subtypes derive. The WS_URL_SCHEME_TYPE is
    ///<b>WS_URL_NETTCP_SCHEME_TYPE</b>.
    WS_URL    url;
    ///The host name.
    WS_STRING host;
    ///The port number.
    ushort    port;
    ///The port number as string.
    WS_STRING portAsString;
    ///The path.
    WS_STRING path;
    ///The query.
    WS_STRING query;
    ///The fragment.
    WS_STRING fragment;
}

///The URL subtype for specifying an soap.udp URL.
struct WS_SOAPUDP_URL
{
    ///The base type from which this URL subtype and all other URL subtypes derive. The WS_URL_SCHEME_TYPE is
    ///<b>WS_URL_SOAPUDP_SCHEME_TYPE</b>.
    WS_URL    url;
    ///The host name.
    WS_STRING host;
    ///The port number.
    ushort    port;
    ///The port number as string.
    WS_STRING portAsString;
    ///The path.
    WS_STRING path;
    ///The query.
    WS_STRING query;
    ///The fragment.
    WS_STRING fragment;
}

///The URL subtype for specifying an net.pipe URL.
struct WS_NETPIPE_URL
{
    ///The base type from which this URL subtype and all other URL subtypes derive. The WS_URL_SCHEME_TYPE is
    ///<b>WS_URL_NETPIPE_SCHEME_TYPE</b>.
    WS_URL    url;
    ///The host name.
    WS_STRING host;
    ///The port number.
    ushort    port;
    ///The port number as string.
    WS_STRING portAsString;
    ///The path.
    WS_STRING path;
    ///The query.
    WS_STRING query;
    ///The fragment.
    WS_STRING fragment;
}

///Represents a unique ID URI.
struct WS_UNIQUE_ID
{
    ///A string representation of the URI. If length is zero, then the unique ID is a guid, and the value is stored in
    ///the guid field. Otherwise, the URI is a string and the string value is stored in the uri field.
    WS_STRING uri;
    ///If the uri.length field is 0, then this field contains the GUID representation of the unique ID. Otherwise the
    ///value of the field is not defined.
    GUID      guid;
}

///A structure used to represent a discontiguous array of WS_BYTES.
struct WS_BUFFERS
{
    uint      bufferCount;
    WS_BYTES* buffers;
}

///Information about a single endpoint that was read from metadata documents.
struct WS_METADATA_ENDPOINT
{
    ///The address of the endpoint.
    WS_ENDPOINT_ADDRESS endpointAddress;
    ///An opaque handle representing the policy of the endpoint. This handle is good until the metadata object is freed
    ///or reset.
    WS_POLICY*          endpointPolicy;
    ///The WSDL port name of the endpoint, if available.
    WS_XML_STRING*      portName;
    ///The WSDL service name of the endpoint, if available.
    WS_XML_STRING*      serviceName;
    ///The WSDL service namespace of the endpoint, if available.
    WS_XML_STRING*      serviceNs;
    ///The WSDL binding name of the endpoint, if available.
    WS_XML_STRING*      bindingName;
    ///The WSDL binding namespace of the endpoint, if available.
    WS_XML_STRING*      bindingNs;
    ///The WSDL portType name of the endpoint, if available.
    WS_XML_STRING*      portTypeName;
    WS_XML_STRING*      portTypeNs;
}

///Information about all endpoints that were read from metadata documents.
struct WS_METADATA_ENDPOINTS
{
    ///An array of endpoints.
    WS_METADATA_ENDPOINT* endpoints;
    uint endpointCount;
}

///Specifies a metadata object setting.
struct WS_METADATA_PROPERTY
{
    ///Identifies the WS_METADATA_PROPERTY_ID.
    WS_METADATA_PROPERTY_ID id;
    ///A pointer to the value to set. The pointer must have an alignment compatible with the type of the property.
    void* value;
    uint  valueSize;
}

///Specifies a policy object setting.
struct WS_POLICY_PROPERTY
{
    ///Identifies the WS_POLICY_PROPERTY_ID.
    WS_POLICY_PROPERTY_ID id;
    ///A pointer to the value to set. The pointer must have an alignment compatible with the type of the property.
    void* value;
    uint  valueSize;
}

///Specifies a set of WS_POLICY_PROPERTY structures.
struct WS_POLICY_PROPERTIES
{
    ///An array of properties. The number of elements in the array is specified using the propertyCount parameter. This
    ///field may be <b>NULL</b> if the propertyCount is 0.
    WS_POLICY_PROPERTY* properties;
    uint                propertyCount;
}

///This structure is used to specify a set of constraints for a particular security binding property. Any property
///constraints that are not specified will use the default constraints.
struct WS_SECURITY_BINDING_PROPERTY_CONSTRAINT
{
    ///The id of the security binding property. The following security binding property constraints may be specified:
    ///<ul> <li> WS_SECURITY_BINDING_PROPERTY_HTTP_HEADER_AUTH_SCHEME This property constraint may be specified when the
    ///WS_HTTP_HEADER_AUTH_SECURITY_BINDING_CONSTRAINT_TYPEsecurity binding is specified. <ul> <li>
    ///WS_HTTP_HEADER_AUTH_SECURITY_BINDING_CONSTRAINT_TYPE </li> </ul> If this property is not specified, then the
    ///default constraint value of WS_HTTP_HEADER_AUTH_SCHEME_NEGOTIATE will be used. </li> </ul>
    WS_SECURITY_BINDING_PROPERTY_ID id;
    ///An array of values which are acceptable. The type of the values in the array correspond to the type of the values
    ///of the security binding property. See the documentation for a particular security binding property to determine
    ///the type of the property.
    void* allowedValues;
    ///The total size of the allowedValues array, in bytes. This size must be a multiple of the size of the type of the
    ///value of the property.
    uint  allowedValuesSize;
struct out_
    {
        WS_SECURITY_BINDING_PROPERTY securityBindingProperty;
    }
}

///The base class for all security binding constraint structures.
struct WS_SECURITY_BINDING_CONSTRAINT
{
    ///This value depends on which type of security binding constraint that is used.
    WS_SECURITY_BINDING_CONSTRAINT_TYPE type;
    ///A set of binding-specific security property constraints. See WS_SECURITY_BINDING_PROPERTY_CONSTRAINT for more
    ///information.
    WS_SECURITY_BINDING_PROPERTY_CONSTRAINT* propertyConstraints;
    uint propertyConstraintCount;
}

///A security binding constraint that corresponds to the WS_SSL_TRANSPORT_SECURITY_BINDING.
struct WS_SSL_TRANSPORT_SECURITY_BINDING_CONSTRAINT
{
    ///The base binding constraint that this binding constraint derives from. There are no binding-specific properties
    ///are defined for this binding constraint at this time.
    WS_SECURITY_BINDING_CONSTRAINT bindingConstraint;
struct out_
    {
        BOOL clientCertCredentialRequired;
    }
}

///A security binding constraint that corresponds to the WS_USERNAME_MESSAGE_SECURITY_BINDING.
struct WS_USERNAME_MESSAGE_SECURITY_BINDING_CONSTRAINT
{
    ///The base binding constraint that this binding constraint derives from. There are no binding-specific properties
    ///are defined for this binding constraint at this time.
    WS_SECURITY_BINDING_CONSTRAINT bindingConstraint;
    WS_MESSAGE_SECURITY_USAGE bindingUsage;
}

///A security binding constraint that corresponds to the WS_HTTP_HEADER_AUTH_SECURITY_BINDING.
struct WS_HTTP_HEADER_AUTH_SECURITY_BINDING_CONSTRAINT
{
    WS_SECURITY_BINDING_CONSTRAINT bindingConstraint;
}

///A security binding constraint that corresponds to the WS_TCP_SSPI_TRANSPORT_SECURITY_BINDING.
struct WS_TCP_SSPI_TRANSPORT_SECURITY_BINDING_CONSTRAINT
{
    WS_SECURITY_BINDING_CONSTRAINT bindingConstraint;
}

///A security binding constraint that can be used with WS_XML_TOKEN_MESSAGE_SECURITY_BINDING.
struct WS_CERT_MESSAGE_SECURITY_BINDING_CONSTRAINT
{
    ///The base binding constraint that this binding constraint derives from. There are currently no binding-specific
    ///properties defined for this binding constraint.
    WS_SECURITY_BINDING_CONSTRAINT bindingConstraint;
    WS_MESSAGE_SECURITY_USAGE bindingUsage;
}

///A security binding constraint that corresponds to the WS_KERBEROS_APREQ_MESSAGE_SECURITY_BINDING.
struct WS_KERBEROS_APREQ_MESSAGE_SECURITY_BINDING_CONSTRAINT
{
    ///The base binding constraint that this binding constraint derives from. There are no binding-specific properties
    ///are defined for this binding constraint at this time.
    WS_SECURITY_BINDING_CONSTRAINT bindingConstraint;
    WS_MESSAGE_SECURITY_USAGE bindingUsage;
}

///This structure is used to specify a set of constraints for a particular request security token property. Any property
///constraints that are not specified will use the default constraints.
struct WS_REQUEST_SECURITY_TOKEN_PROPERTY_CONSTRAINT
{
    ///The id of the request security token property. The following security property constraint may be specified: <ul>
    ///<li> WS_REQUEST_SECURITY_TOKEN_PROPERTY_TRUST_VERSION This property indicates which WS-Trust versions are
    ///acceptable. If this property is not specified, then the default constraint value of
    ///WS_TRUST_VERSION_FEBRUARY_2005 will be used. Currently only WS_TRUST_VERSION_FEBRUARY_2005is supported in policy,
    ///so a property constraint containing the value <b>WS_TRUST_VERSION_FEBRUARY_2005</b> must be specified in order
    ///for the policy to match. </li> </ul>
    WS_REQUEST_SECURITY_TOKEN_PROPERTY_ID id;
    ///An array of values which are acceptable. The type of the values in the array correspond to the type of the values
    ///of the request security token property. See the documentation for a particular request security token property to
    ///determine the type of the property.
    void* allowedValues;
    ///The total size of the allowedValues array, in bytes. This size must be a multiple of the size of the type of the
    ///value of the property.
    uint  allowedValuesSize;
struct out_
    {
        WS_REQUEST_SECURITY_TOKEN_PROPERTY requestSecurityTokenProperty;
    }
}

///A security binding constraint that can be used to extract information about how to obtain an issued token from an
///issuing party.
struct WS_ISSUED_TOKEN_MESSAGE_SECURITY_BINDING_CONSTRAINT
{
    ///The base binding constraint that this binding constraint derives from. There are currently no binding-specific
    ///properties defined for this binding constraint.
    WS_SECURITY_BINDING_CONSTRAINT bindingConstraint;
    ///This specifies how the issued token should be attached to a message.
    WS_MESSAGE_SECURITY_USAGE bindingUsage;
    ///This field contains a list of claim types that are allowed in the policy. Each claim type is a URI which
    ///identifies the type of claim.
    WS_XML_STRING* claimConstraints;
    ///The number of elements in the claimConstraints array. If this value is 0, then the claimConstraints array may be
    ///<b>NULL</b>, and any claims are allowed to appear in the policy.
    uint           claimConstraintCount;
    ///A set of property constraints relating to how to request a security token. See
    ///WS_REQUEST_SECURITY_TOKEN_PROPERTY_CONSTRAINT for more information.
    WS_REQUEST_SECURITY_TOKEN_PROPERTY_CONSTRAINT* requestSecurityTokenPropertyConstraints;
    ///The number of elements in the requestSecurityTokenPropertyConstraints array. If the array has zero elements, the
    ///requestSecurityTokenPropertyConstraints field may be <b>NULL</b>.
    uint           requestSecurityTokenPropertyConstraintCount;
struct out_
    {
        WS_ENDPOINT_ADDRESS* issuerAddress;
        WS_XML_BUFFER*       requestSecurityTokenTemplate;
    }
}

///This structure is used to specify a set of constraints for a particular security property. Any property constraints
///that are not specified will use the default constraints.
struct WS_SECURITY_PROPERTY_CONSTRAINT
{
    ///The id of the security property. The following security property constraints may be specified: <ul> <li>
    ///WS_SECURITY_PROPERTY_TIMESTAMP_USAGE This property constraint may be specified when any of the following security
    ///bindings are specified: <ul> <li> WS_USERNAME_MESSAGE_SECURITY_BINDING_CONSTRAINT </li> <li>
    ///WS_KERBEROS_APREQ_MESSAGE_SECURITY_BINDING_CONSTRAINT </li> <li> WS_CERT_MESSAGE_SECURITY_BINDING_CONSTRAINT
    ///</li> <li> WS_SECURITY_CONTEXT_MESSAGE_SECURITY_BINDING_CONSTRAINT </li> </ul> If this property is not specified,
    ///then the default constraint value of WS_SECURITY_TIMESTAMP_USAGE_ALWAYS will be used. </li> <li>
    ///WS_SECURITY_PROPERTY_TRANSPORT_PROTECTION_LEVEL This property constraint may be specified when any of the
    ///following security bindings are specified: <ul> <li> WS_SSL_TRANSPORT_SECURITY_BINDING_CONSTRAINT </li> <li>
    ///WS_TCP_SSPI_TRANSPORT_SECURITY_BINDING_CONSTRAINT </li> <li> WS_HTTP_HEADER_AUTH_SECURITY_BINDING_CONSTRAINT
    ///</li> </ul> If this property is not specified, then the default constraint value of
    ///WS_PROTECTION_LEVEL_SIGN_AND_ENCRYPT will be used. <b>WS_SECURITY_PROPERTY_SECURITY_HEADER_LAYOUT</b>This
    ///property constraint may be specified when any of the following security bindings are specified: <ul> <li>
    ///WS_USERNAME_MESSAGE_SECURITY_BINDING_CONSTRAINT </li> <li> WS_KERBEROS_APREQ_MESSAGE_SECURITY_BINDING_CONSTRAINT
    ///</li> <li> WS_CERT_MESSAGE_SECURITY_BINDING_CONSTRAINT </li> <li>
    ///WS_SECURITY_CONTEXT_MESSAGE_SECURITY_BINDING_CONSTRAINT </li> </ul> If this property is not specified, then the
    ///default constraint value of WS_SECURITY_HEADER_LAYOUT_STRICT will be used.
    ///<b>WS_SECURITY_PROPERTY_SECURITY_HEADER_VERSION</b>This property constraint may be specified when any of the
    ///following security bindings are specified: <ul> <li> WS_USERNAME_MESSAGE_SECURITY_BINDING_CONSTRAINT </li> <li>
    ///WS_KERBEROS_APREQ_MESSAGE_SECURITY_BINDING_CONSTRAINT </li> <li> WS_CERT_MESSAGE_SECURITY_BINDING_CONSTRAINT
    ///</li> <li> WS_SECURITY_CONTEXT_MESSAGE_SECURITY_BINDING_CONSTRAINT </li> </ul> If this property is not specified,
    ///then the default constraint value of WS_SECURITY_HEADER_VERSION_1_1 will be used.
    ///<b>WS_SECURITY_PROPERTY_ALGORITHM_SUITE_NAME</b>This property constraint may be specified when any of the
    ///following security bindings are specified: <ul> <li> WS_USERNAME_MESSAGE_SECURITY_BINDING_CONSTRAINT </li> <li>
    ///WS_KERBEROS_APREQ_MESSAGE_SECURITY_BINDING_CONSTRAINT </li> <li> WS_CERT_MESSAGE_SECURITY_BINDING_CONSTRAINT
    ///</li> <li> WS_SECURITY_CONTEXT_MESSAGE_SECURITY_BINDING_CONSTRAINT </li> </ul> If this property is not specified,
    ///then the default constraint value of WS_SECURITY_ALGORITHM_SUITE_NAME_BASIC256 will be used. </li> </ul>
    WS_SECURITY_PROPERTY_ID id;
    ///An array of values which are acceptable. The type of the values in the array correspond to the type of the values
    ///of the security property. See the documentation for a particular security property to determine the type of the
    ///property.
    void* allowedValues;
    ///The total size of the allowedValues array, in bytes. This size must be a multiple of the size of the type of the
    ///value of the property.
    uint  allowedValuesSize;
struct out_
    {
        WS_SECURITY_PROPERTY securityProperty;
    }
}

///This structure specifies the security related constraints as part of WS_POLICY_CONSTRAINTS.
struct WS_SECURITY_CONSTRAINTS
{
    ///An array of security property constraints which override the default set of constraints. The constraints
    ///specified here, combined with the default set of constraints limits the set of policies that will be matched. If
    ///a security property constraint is not specified for a given property, then a default constraint value will be
    ///used. See WS_SECURITY_PROPERTY_CONSTRAINT for the supported set of properties and their default values. Note that
    ///the defaults constraints for WS_SECURITY_PROPERTY_CONSTRAINT are the same as the defaults for
    ///WS_SECURITY_PROPERTY.
    WS_SECURITY_PROPERTY_CONSTRAINT* securityPropertyConstraints;
    ///The number of elements specified in the securityPropertyConstraints array. If this value is 0, then the
    ///securityPropertyConstraints array may be <b>NULL</b>.
    uint securityPropertyConstraintCount;
    ///Any array of security binding constraints which taken as a unit specify the type of security to match in the
    ///policy. The type of each WS_SECURITY_BINDING_CONSTRAINT corresponds to the types of security that is specified
    ///using a WS_SECURITY_BINDINGstructure. Each security binding specifies one security token, and similarly, each
    ///security binding constraint specifies constraints on one security token. Specifying zero constraints indicates no
    ///security.
    WS_SECURITY_BINDING_CONSTRAINT** securityBindingConstraints;
    uint securityBindingConstraintCount;
}

///A security binding constraint that corresponds to the WS_SECURITY_CONTEXT_MESSAGE_SECURITY_BINDING.
struct WS_SECURITY_CONTEXT_MESSAGE_SECURITY_BINDING_CONSTRAINT
{
    ///The base binding constraint that this binding constraint derives from. The following binding constraints are
    ///supported at this point: WS_SECURITY_BINDING_PROPERTY_SECURE_CONVERSATION_VERSION and
    ///<b>WS_SECURITY_BINDING_PROPERTY_SECURITY_CONTEXT_KEY_ENTROPY_MODE</b>. Currently only
    ///WS_SECURE_CONVERSATION_VERSION_FEBRUARY_2005is supported in policy, so a binding constraint containing the value
    ///<b>WS_SECURE_CONVERSATION_VERSION_FEBRUARY_2005</b> must be specified in order for the policy to match.
    WS_SECURITY_BINDING_CONSTRAINT bindingConstraint;
    ///This specifies how the security context token should be attached to a message.
    WS_MESSAGE_SECURITY_USAGE bindingUsage;
    WS_SECURITY_CONSTRAINTS* bootstrapSecurityConstraint;
}

///Specifies constraints for a particular channel property.Any property constraints that are not specified will use the
///default constraints.
struct WS_CHANNEL_PROPERTY_CONSTRAINT
{
    ///The ID of the channel property. The following channel properties constraints may be specified: <ul> <li>
    ///WS_CHANNEL_PROPERTY_ENCODING If this property constraint is not specified when using WS_HTTP_CHANNEL_BINDING the
    ///default constraint value of WS_ENCODING_XML_UTF8 will be used. If this property constraint is not specified not
    ///specified when using WS_TCP_CHANNEL_BINDING the default constraint value of WS_ENCODING_XML_BINARY_SESSION_1 will
    ///be used. </li> <li> WS_CHANNEL_PROPERTY_ADDRESSING_VERSION If this property constraint is not specified, the
    ///default constraint value of WS_ADDRESSING_VERSION_1_0 will be used. </li> <li>
    ///WS_CHANNEL_PROPERTY_ENVELOPE_VERSION If this property constraint is not specified, the default constraint of
    ///value of WS_ENVELOPE_VERSION_SOAP_1_2 will be used. </li> </ul>
    WS_CHANNEL_PROPERTY_ID id;
    ///An array of acceptable values. The type of the values in the array correspond to the type of the values of the
    ///channel property. See the documentation for a particular channel property to determine the type of the property.
    void* allowedValues;
    ///The total size of the <b>allowedValues</b> array, in bytes. This size must be a multiple of the size of the type
    ///of the value of the property.
    uint  allowedValuesSize;
struct out_
    {
        WS_CHANNEL_PROPERTY channelProperty;
    }
}

///The base class for all policy extension structures. Policy extensions are assertions that are directly handled by
///applications such as custom assertions.
struct WS_POLICY_EXTENSION
{
    WS_POLICY_EXTENSION_TYPE type;
}

///This structure is used to specify an endpoint policy extension.
struct WS_ENDPOINT_POLICY_EXTENSION
{
    ///The base policy extension that this policy extension derives from.
    WS_POLICY_EXTENSION policyExtension;
    ///Name of the assertion to be retrieved as an extension.
    WS_XML_STRING*      assertionName;
    ///Namespace of the assertion to be retrieved as an extension.
    WS_XML_STRING*      assertionNs;
struct out_
    {
        WS_XML_BUFFER* assertionValue;
    }
}

///Specifies policy constraints for a channel.
struct WS_POLICY_CONSTRAINTS
{
    ///Which channel binding is required. The following values are supported: <ul> <li> WS_HTTP_CHANNEL_BINDING </li>
    ///<li> WS_TCP_CHANNEL_BINDING </li> </ul>
    WS_CHANNEL_BINDING channelBinding;
    ///An array of channel property constraints which override the default set of constraints. The constraints specified
    ///here, combined with the default set of constraints limits the set of policies that will be matched. If a channel
    ///property constraint is not specified for a given property, then a default constraint value will be used. See
    ///WS_CHANNEL_PROPERTY_CONSTRAINT for the supported set of properties and their default values.
    WS_CHANNEL_PROPERTY_CONSTRAINT* channelPropertyConstraints;
    ///The number of elements specified in the <b>channelPropertyConstraints</b>array. If this value is 0, then the
    ///channelPropertyConstraints array may be <b>NULL</b>.
    uint               channelPropertyConstraintCount;
    ///Constraints on the type of security that may be used. Setting this field to <b>NULL</b> indicates a constraint of
    ///no security.
    WS_SECURITY_CONSTRAINTS* securityConstraints;
    WS_POLICY_EXTENSION** policyExtensions;
    uint               policyExtensionCount;
}

///Describes the policy specifying http channel binding.
struct WS_HTTP_POLICY_DESCRIPTION
{
    WS_CHANNEL_PROPERTIES channelProperties;
}

///This type description is used with template APIs to describe the templates generated accordingly to input policy
///setting. See also, WsCreateServiceProxyFromTemplate, WsCreateServiceEndpointFromTemplate
struct WS_SSL_TRANSPORT_SECURITY_BINDING_POLICY_DESCRIPTION
{
    WS_SECURITY_BINDING_PROPERTIES securityBindingProperties;
}

///Describes the policy specifying http channel binding.
struct WS_HTTP_SSL_POLICY_DESCRIPTION
{
    ///Template description for the channel properties specified in policy.
    WS_CHANNEL_PROPERTIES channelProperties;
    ///Template description for the security properties specified in policy.
    WS_SECURITY_PROPERTIES securityProperties;
    WS_SSL_TRANSPORT_SECURITY_BINDING_POLICY_DESCRIPTION sslTransportSecurityBinding;
}

///This type description is used with template APIs to describe the templates generated accordingly to input policy
///setting. See also, WsCreateServiceProxyFromTemplate, WsCreateServiceEndpointFromTemplate
struct WS_HTTP_HEADER_AUTH_SECURITY_BINDING_POLICY_DESCRIPTION
{
    WS_SECURITY_BINDING_PROPERTIES securityBindingProperties;
}

///Describes the policy specifying http channel binding.
struct WS_HTTP_HEADER_AUTH_POLICY_DESCRIPTION
{
    ///Template description for the channel properties specified in policy.
    WS_CHANNEL_PROPERTIES channelProperties;
    ///Template description for the security properties specified in policy.
    WS_SECURITY_PROPERTIES securityProperties;
    WS_HTTP_HEADER_AUTH_SECURITY_BINDING_POLICY_DESCRIPTION httpHeaderAuthSecurityBinding;
}

///Describes the policy specifying http channel binding with SSL transport security and header authentication.
struct WS_HTTP_SSL_HEADER_AUTH_POLICY_DESCRIPTION
{
    ///Template description for the channel properties specified in policy.
    WS_CHANNEL_PROPERTIES channelProperties;
    ///Template description for the security properties specified in policy.
    WS_SECURITY_PROPERTIES securityProperties;
    ///SSL security binding description.
    WS_SSL_TRANSPORT_SECURITY_BINDING_POLICY_DESCRIPTION sslTransportSecurityBinding;
    WS_HTTP_HEADER_AUTH_SECURITY_BINDING_POLICY_DESCRIPTION httpHeaderAuthSecurityBinding;
}

///This type description is used with template APIs to describe the templates generated accordingly to input policy
///setting. See also, WsCreateServiceProxyFromTemplate, WsCreateServiceEndpointFromTemplate
struct WS_USERNAME_MESSAGE_SECURITY_BINDING_POLICY_DESCRIPTION
{
    ///Specifies the security binding properties according to the specific policy.
    WS_SECURITY_BINDING_PROPERTIES securityBindingProperties;
    WS_MESSAGE_SECURITY_USAGE bindingUsage;
}

///Describes the policy specifying http channel binding with SSL transport security and username/password message
///security.
struct WS_HTTP_SSL_USERNAME_POLICY_DESCRIPTION
{
    ///Template description for the channel properties specified in policy.
    WS_CHANNEL_PROPERTIES channelProperties;
    ///Template description for the security properties specified in policy.
    WS_SECURITY_PROPERTIES securityProperties;
    ///SSL security binding description.
    WS_SSL_TRANSPORT_SECURITY_BINDING_POLICY_DESCRIPTION sslTransportSecurityBinding;
    WS_USERNAME_MESSAGE_SECURITY_BINDING_POLICY_DESCRIPTION usernameMessageSecurityBinding;
}

///This type description is used with template APIs to describe the templates generated accordingly to input policy
///setting. See also, WsCreateServiceProxyFromTemplate, WsCreateServiceEndpointFromTemplate
struct WS_KERBEROS_APREQ_MESSAGE_SECURITY_BINDING_POLICY_DESCRIPTION
{
    ///Specifies the security binding properties according to the specific policy.
    WS_SECURITY_BINDING_PROPERTIES securityBindingProperties;
    WS_MESSAGE_SECURITY_USAGE bindingUsage;
}

///Describes the policy specifying http channel binding with SSL transport security and KERBEROS AP_REQ message
///security.
struct WS_HTTP_SSL_KERBEROS_APREQ_POLICY_DESCRIPTION
{
    ///Template description for the channel properties specified in policy.
    WS_CHANNEL_PROPERTIES channelProperties;
    ///Template description for the security properties specified in policy.
    WS_SECURITY_PROPERTIES securityProperties;
    ///SSL security binding description.
    WS_SSL_TRANSPORT_SECURITY_BINDING_POLICY_DESCRIPTION sslTransportSecurityBinding;
    WS_KERBEROS_APREQ_MESSAGE_SECURITY_BINDING_POLICY_DESCRIPTION kerberosApreqMessageSecurityBinding;
}

///Describes the policy specifying http channel binding.
struct WS_TCP_POLICY_DESCRIPTION
{
    WS_CHANNEL_PROPERTIES channelProperties;
}

///This type description is used with template APIs to describe the templates generated accordingly to input policy
///setting. See also, WsCreateServiceProxyFromTemplate, WsCreateServiceEndpointFromTemplate
struct WS_SSPI_TRANSPORT_SECURITY_BINDING_POLICY_DESCRIPTION
{
    WS_SECURITY_BINDING_PROPERTIES securityBindingProperties;
}

///Describes the policy specifying TCP channel binding with windows SSPI.
struct WS_TCP_SSPI_POLICY_DESCRIPTION
{
    ///Template description for the channel properties specified in policy.
    WS_CHANNEL_PROPERTIES channelProperties;
    ///Template description for the security properties specified in policy.
    WS_SECURITY_PROPERTIES securityProperties;
    WS_SSPI_TRANSPORT_SECURITY_BINDING_POLICY_DESCRIPTION sspiTransportSecurityBinding;
}

///Describes the policy specifying TCP channel binding with windows SSPI transport security and username/password
///message security.
struct WS_TCP_SSPI_USERNAME_POLICY_DESCRIPTION
{
    ///Template description for the channel properties specified in policy.
    WS_CHANNEL_PROPERTIES channelProperties;
    ///Template description for the security properties specified in policy.
    WS_SECURITY_PROPERTIES securityProperties;
    ///Windows SSPI security binding description.
    WS_SSPI_TRANSPORT_SECURITY_BINDING_POLICY_DESCRIPTION sspiTransportSecurityBinding;
    WS_USERNAME_MESSAGE_SECURITY_BINDING_POLICY_DESCRIPTION usernameMessageSecurityBinding;
}

///Describes the policy specifying TCP channel binding with windows SSPI transport security, and kerberos message
///security.
struct WS_TCP_SSPI_KERBEROS_APREQ_POLICY_DESCRIPTION
{
    ///Template description for the channel properties specified in policy.
    WS_CHANNEL_PROPERTIES channelProperties;
    ///Template description for the security properties specified in policy.
    WS_SECURITY_PROPERTIES securityProperties;
    ///Windows SSPI security binding description.
    WS_SSPI_TRANSPORT_SECURITY_BINDING_POLICY_DESCRIPTION sspiTransportSecurityBinding;
    WS_KERBEROS_APREQ_MESSAGE_SECURITY_BINDING_POLICY_DESCRIPTION kerberosApreqMessageSecurityBinding;
}

///This type description is used with template APIs to describe the templates generated accordingly to input policy
///setting.
struct WS_SECURITY_CONTEXT_MESSAGE_SECURITY_BINDING_POLICY_DESCRIPTION
{
    ///Specifies the security binding properties according to the specific policy.
    WS_SECURITY_BINDING_PROPERTIES securityBindingProperties;
    WS_MESSAGE_SECURITY_USAGE bindingUsage;
}

///This type description is used with template APIs to describe the security context related templates generated
///accordingly to input policy setting.
struct WS_SECURITY_CONTEXT_SECURITY_BINDING_POLICY_DESCRIPTION
{
    ///Specifies the message security binding usage.
    WS_SECURITY_CONTEXT_MESSAGE_SECURITY_BINDING_POLICY_DESCRIPTION securityContextMessageSecurityBinding;
    WS_SECURITY_PROPERTIES securityProperties;
}

///Describes the policy specifying security context message binding using TCP channel binding with windows SSPI
///transport security. The bootstrap channel uses TCP channel binding with windows SSPI transport security and kerberos
///message security.
struct WS_TCP_SSPI_KERBEROS_APREQ_SECURITY_CONTEXT_POLICY_DESCRIPTION
{
    ///Template description for the channel properties specified in policy.
    WS_CHANNEL_PROPERTIES channelProperties;
    ///Template description for the security properties specified in policy.
    WS_SECURITY_PROPERTIES securityProperties;
    ///Windows SSPI security binding description.
    WS_SSPI_TRANSPORT_SECURITY_BINDING_POLICY_DESCRIPTION sspiTransportSecurityBinding;
    ///kerberos message security binding description.
    WS_KERBEROS_APREQ_MESSAGE_SECURITY_BINDING_POLICY_DESCRIPTION kerberosApreqMessageSecurityBinding;
    WS_SECURITY_CONTEXT_SECURITY_BINDING_POLICY_DESCRIPTION securityContextSecurityBinding;
}

///Describes the policy specifying security context message binding using TCP channel binding with windows SSPI
///transport security. The bootstrap channel uses TCP channel binding with windows SSPI transport security and
///username/password message security.
struct WS_TCP_SSPI_USERNAME_SECURITY_CONTEXT_POLICY_DESCRIPTION
{
    ///Template description for the channel properties specified in policy.
    WS_CHANNEL_PROPERTIES channelProperties;
    ///Template description for the security properties specified in policy.
    WS_SECURITY_PROPERTIES securityProperties;
    ///Windows SSPI security binding description.
    WS_SSPI_TRANSPORT_SECURITY_BINDING_POLICY_DESCRIPTION sspiTransportSecurityBinding;
    ///Username/password message security binding description.
    WS_USERNAME_MESSAGE_SECURITY_BINDING_POLICY_DESCRIPTION usernameMessageSecurityBinding;
    WS_SECURITY_CONTEXT_SECURITY_BINDING_POLICY_DESCRIPTION securityContextSecurityBinding;
}

///Describes the policy specifying security context message binding over http channel binding, with SSL transport
///security. The bootstrap channel uses http channel binding with SSL transport security and username/password message
///security.
struct WS_HTTP_SSL_USERNAME_SECURITY_CONTEXT_POLICY_DESCRIPTION
{
    ///Template description for the channel properties specified in policy.
    WS_CHANNEL_PROPERTIES channelProperties;
    ///Template description for the security properties specified in policy.
    WS_SECURITY_PROPERTIES securityProperties;
    ///SSL security binding description.
    WS_SSL_TRANSPORT_SECURITY_BINDING_POLICY_DESCRIPTION sslTransportSecurityBinding;
    ///Username/password message security binding description.
    WS_USERNAME_MESSAGE_SECURITY_BINDING_POLICY_DESCRIPTION usernameMessageSecurityBinding;
    WS_SECURITY_CONTEXT_SECURITY_BINDING_POLICY_DESCRIPTION securityContextSecurityBinding;
}

///Describes the policy specifying security context message binding over http channel binding, with SSL transport
///security. The bootstrap channel uses http channel binding with SSL transport security and KERBEROS AP_REQ message
///security.
struct WS_HTTP_SSL_KERBEROS_APREQ_SECURITY_CONTEXT_POLICY_DESCRIPTION
{
    ///Template description for the channel properties specified in policy.
    WS_CHANNEL_PROPERTIES channelProperties;
    ///Template description for the security properties specified in policy.
    WS_SECURITY_PROPERTIES securityProperties;
    ///SSL security binding description.
    WS_SSL_TRANSPORT_SECURITY_BINDING_POLICY_DESCRIPTION sslTransportSecurityBinding;
    ///kerberos message security binding description.
    WS_KERBEROS_APREQ_MESSAGE_SECURITY_BINDING_POLICY_DESCRIPTION kerberosApreqMessageSecurityBinding;
    WS_SECURITY_CONTEXT_SECURITY_BINDING_POLICY_DESCRIPTION securityContextSecurityBinding;
}

///HTTP template structure to be filled in by application for http binding.
struct WS_HTTP_BINDING_TEMPLATE
{
    WS_CHANNEL_PROPERTIES channelProperties;
}

///TCP template structure to be filled in by application for TCP binding.
struct WS_TCP_BINDING_TEMPLATE
{
    WS_CHANNEL_PROPERTIES channelProperties;
}

///The security binding template for specifying the use of SSL/TLS protocol based transport security. See also
///WS_SSL_TRANSPORT_SECURITY_BINDING. This security binding is supported only with the WS_HTTP_CHANNEL_BINDING.
struct WS_SSL_TRANSPORT_SECURITY_BINDING_TEMPLATE
{
    ///Application provided security binding properties that cannot be represented in policy.
    WS_SECURITY_BINDING_PROPERTIES securityBindingProperties;
    WS_CERT_CREDENTIAL* localCertCredential;
}

///SSL security template information to be filled in by application. Associated with WS_HTTP_SSL_BINDING_TEMPLATE_TYPE.
struct WS_HTTP_SSL_BINDING_TEMPLATE
{
    ///Application provided additional channel properties that cannot be represented in policy.
    WS_CHANNEL_PROPERTIES channelProperties;
    ///Application provided additional security properties that cannot be represented in policy.
    WS_SECURITY_PROPERTIES securityProperties;
    WS_SSL_TRANSPORT_SECURITY_BINDING_TEMPLATE sslTransportSecurityBinding;
}

///The security binding template for specifying the use of HTP header authentication protocol based security. See also
///WS_HTTP_HEADER_AUTH_SECURITY_BINDING
struct WS_HTTP_HEADER_AUTH_SECURITY_BINDING_TEMPLATE
{
    ///Application provided security binding properties that cannot be represented in policy.
    WS_SECURITY_BINDING_PROPERTIES securityBindingProperties;
    WS_WINDOWS_INTEGRATED_AUTH_CREDENTIAL* clientCredential;
}

///HTTP header authentication security template information to be filled in by application. Associated with
///WS_HTTP_HEADER_AUTH_BINDING_TEMPLATE_TYPE.
struct WS_HTTP_HEADER_AUTH_BINDING_TEMPLATE
{
    ///Application provided additional channel properties that cannot be represented in policy.
    WS_CHANNEL_PROPERTIES channelProperties;
    ///Application provided additional security properties that cannot be represented in policy.
    WS_SECURITY_PROPERTIES securityProperties;
    WS_HTTP_HEADER_AUTH_SECURITY_BINDING_TEMPLATE httpHeaderAuthSecurityBinding;
}

///The security binding template for specifying the use of Windows SSPI protocol based transport security. See also
///WS_TCP_SSPI_TRANSPORT_SECURITY_BINDING.
struct WS_TCP_SSPI_TRANSPORT_SECURITY_BINDING_TEMPLATE
{
    ///Application provided security binding properties that cannot be represented in policy.
    WS_SECURITY_BINDING_PROPERTIES securityBindingProperties;
    WS_WINDOWS_INTEGRATED_AUTH_CREDENTIAL* clientCredential;
}

///HTTP header authentication security template information to be filled in by application. Associated with
///WS_TCP_SSPI_BINDING_TEMPLATE_TYPE.
struct WS_TCP_SSPI_BINDING_TEMPLATE
{
    ///Application provided additional channel properties that cannot be represented in policy.
    WS_CHANNEL_PROPERTIES channelProperties;
    ///Application provided additional security properties that cannot be represented in policy.
    WS_SECURITY_PROPERTIES securityProperties;
    WS_TCP_SSPI_TRANSPORT_SECURITY_BINDING_TEMPLATE sspiTransportSecurityBinding;
}

///Username/password security template information to be filled in by application. Associated with
///WS_HTTP_SSL_HEADER_AUTH_BINDING_TEMPLATE_TYPE.
struct WS_HTTP_SSL_HEADER_AUTH_BINDING_TEMPLATE
{
    ///Application provided additional channel properties that cannot be represented in policy.
    WS_CHANNEL_PROPERTIES channelProperties;
    ///Application provided additional security properties that cannot be represented in policy.
    WS_SECURITY_PROPERTIES securityProperties;
    ///Application provided SSL transport security binding information that cannot be represented in policy.
    WS_SSL_TRANSPORT_SECURITY_BINDING_TEMPLATE sslTransportSecurityBinding;
    WS_HTTP_HEADER_AUTH_SECURITY_BINDING_TEMPLATE httpHeaderAuthSecurityBinding;
}

///The security binding template for specifying the use of an application supplied username / password pair as a direct
///(i.e., one-shot) security token. This security binding may be used only with message security. It provides client
///authentication, but not traffic signing or encryption. So, it is used in conjunction with another transport security
///or message security binding that provides message protection. See also WS_USERNAME_MESSAGE_SECURITY_BINDING
struct WS_USERNAME_MESSAGE_SECURITY_BINDING_TEMPLATE
{
    ///Application provided security binding properties that cannot be represented in policy.
    WS_SECURITY_BINDING_PROPERTIES securityBindingProperties;
    ///The username credential to be used with this security binding. This needs to be specified when this security
    ///binding is used on the client.
    WS_USERNAME_CREDENTIAL* clientCredential;
    ///The validator to be used to check received username/password pairs. This needs to be specified when this security
    ///binding is used on the service.
    WS_VALIDATE_PASSWORD_CALLBACK passwordValidator;
    void* passwordValidatorCallbackState;
}

///Username/password security template information to be filled in by application. Associated with
///WS_HTTP_SSL_USERNAME_BINDING_TEMPLATE_TYPE.
struct WS_HTTP_SSL_USERNAME_BINDING_TEMPLATE
{
    ///Application provided additional channel properties that cannot be represented in policy.
    WS_CHANNEL_PROPERTIES channelProperties;
    ///Application provided additional security properties that cannot be represented in policy.
    WS_SECURITY_PROPERTIES securityProperties;
    ///Application provided SSL transport security binding information that cannot be represented in policy.
    WS_SSL_TRANSPORT_SECURITY_BINDING_TEMPLATE sslTransportSecurityBinding;
    WS_USERNAME_MESSAGE_SECURITY_BINDING_TEMPLATE usernameMessageSecurityBinding;
}

///The security binding template for specifying the use of the Kerberos AP_REQ ticket as a direct (i.e., without
///establishing a session) security token with WS-Security. See also WS_KERBEROS_APREQ_MESSAGE_SECURITY_BINDING
struct WS_KERBEROS_APREQ_MESSAGE_SECURITY_BINDING_TEMPLATE
{
    ///Application provided security binding properties that cannot be represented in policy.
    WS_SECURITY_BINDING_PROPERTIES securityBindingProperties;
    WS_WINDOWS_INTEGRATED_AUTH_CREDENTIAL* clientCredential;
}

///Username/password security template information to be filled in by application. Associated with
///WS_HTTP_SSL_KERBEROS_APREQ_BINDING_TEMPLATE_TYPE.
struct WS_HTTP_SSL_KERBEROS_APREQ_BINDING_TEMPLATE
{
    ///Application provided additional channel properties that cannot be represented in policy.
    WS_CHANNEL_PROPERTIES channelProperties;
    ///Application provided additional security properties that cannot be represented in policy.
    WS_SECURITY_PROPERTIES securityProperties;
    ///Application provided SSL transport security binding information that cannot be represented in policy.
    WS_SSL_TRANSPORT_SECURITY_BINDING_TEMPLATE sslTransportSecurityBinding;
    WS_KERBEROS_APREQ_MESSAGE_SECURITY_BINDING_TEMPLATE kerberosApreqMessageSecurityBinding;
}

///Username/password security template information to be filled in by application. Associated with
///WS_TCP_SSPI_USERNAME_BINDING_TEMPLATE_TYPE.
struct WS_TCP_SSPI_USERNAME_BINDING_TEMPLATE
{
    ///Application provided additional channel properties that cannot be represented in policy.
    WS_CHANNEL_PROPERTIES channelProperties;
    ///Application provided additional security properties that cannot be represented in policy.
    WS_SECURITY_PROPERTIES securityProperties;
    ///Application provided SSPI transport security information that cannot be represented in policy.
    WS_TCP_SSPI_TRANSPORT_SECURITY_BINDING_TEMPLATE sspiTransportSecurityBinding;
    WS_USERNAME_MESSAGE_SECURITY_BINDING_TEMPLATE usernameMessageSecurityBinding;
}

///Username/password security template information to be filled in by application. Associated with
///WS_TCP_SSPI_KERBEROS_APREQ_BINDING_TEMPLATE_TYPE.
struct WS_TCP_SSPI_KERBEROS_APREQ_BINDING_TEMPLATE
{
    ///Application provided additional channel properties that cannot be represented in policy.
    WS_CHANNEL_PROPERTIES channelProperties;
    ///Application provided additional security properties that cannot be represented in policy.
    WS_SECURITY_PROPERTIES securityProperties;
    ///Application provided SSPI transport security information that cannot be represented in policy.
    WS_TCP_SSPI_TRANSPORT_SECURITY_BINDING_TEMPLATE sspiTransportSecurityBinding;
    WS_KERBEROS_APREQ_MESSAGE_SECURITY_BINDING_TEMPLATE kerberosApreqMessageSecurityBinding;
}

///The security binding template for specifying the use of an application supplied security context security binding.
///This security binding may be used only with message security. So, it is used in conjunction with another transport
///security or message security binding that provides message protection. See also
///WS_SECURITY_CONTEXT_MESSAGE_SECURITY_BINDING
struct WS_SECURITY_CONTEXT_MESSAGE_SECURITY_BINDING_TEMPLATE
{
    WS_SECURITY_BINDING_PROPERTIES securityBindingProperties;
}

///The security binding template for specifying the use of an application supplied security context security binding.
///This security binding may be used only with message security. So, it is used in conjunction with another transport
///security binding that provides message protection. The security properties are used to establish the secure
///conversation. See also WS_SECURITY_CONTEXT_MESSAGE_SECURITY_BINDING
struct WS_SECURITY_CONTEXT_SECURITY_BINDING_TEMPLATE
{
    ///Application provided security binding properties that cannot be represented in policy.
    WS_SECURITY_CONTEXT_MESSAGE_SECURITY_BINDING_TEMPLATE securityContextMessageSecurityBinding;
    WS_SECURITY_PROPERTIES securityProperties;
}

///Security template information to be filled in by application. Associated with
///WS_HTTP_SSL_USERNAME_SECURITY_CONTEXT_BINDING_TEMPLATE_TYPE.
struct WS_HTTP_SSL_USERNAME_SECURITY_CONTEXT_BINDING_TEMPLATE
{
    ///Application provided additional channel properties for both bootstrap channel and service channel that cannot be
    ///represented in policy.
    WS_CHANNEL_PROPERTIES channelProperties;
    ///Application provided additional security properties for the bootstrap channel that cannot be represented in
    ///policy.
    WS_SECURITY_PROPERTIES securityProperties;
    ///Application provided SSL transport security binding information for both bootstrap channel and service channel
    ///that cannot be represented in policy.
    WS_SSL_TRANSPORT_SECURITY_BINDING_TEMPLATE sslTransportSecurityBinding;
    ///Application provided username binding information for the bootstrap channel that cannot be represented in policy.
    WS_USERNAME_MESSAGE_SECURITY_BINDING_TEMPLATE usernameMessageSecurityBinding;
    WS_SECURITY_CONTEXT_SECURITY_BINDING_TEMPLATE securityContextSecurityBinding;
}

///Security template information to be filled in by application. Associated with
///WS_HTTP_SSL_KERBEROS_APREQ_SECURITY_CONTEXT_BINDING_TEMPLATE_TYPE.
struct WS_HTTP_SSL_KERBEROS_APREQ_SECURITY_CONTEXT_BINDING_TEMPLATE
{
    ///Application provided additional channel properties for both bootstrap channel and service channel that cannot be
    ///represented in policy.
    WS_CHANNEL_PROPERTIES channelProperties;
    ///Application provided additional security properties for the bootstrap channel that cannot be represented in
    ///policy.
    WS_SECURITY_PROPERTIES securityProperties;
    ///Application provided SSL transport security binding information for both bootstrap channel and service channel
    ///that cannot be represented in policy.
    WS_SSL_TRANSPORT_SECURITY_BINDING_TEMPLATE sslTransportSecurityBinding;
    ///Application provided username binding information for the bootstrap channel that cannot be represented in policy.
    WS_KERBEROS_APREQ_MESSAGE_SECURITY_BINDING_TEMPLATE kerberosApreqMessageSecurityBinding;
    WS_SECURITY_CONTEXT_SECURITY_BINDING_TEMPLATE securityContextSecurityBinding;
}

///Security template information to be filled in by application. Associated with
///WS_TCP_SSPI_USERNAME_SECURITY_CONTEXT_BINDING_TEMPLATE_TYPE.
struct WS_TCP_SSPI_USERNAME_SECURITY_CONTEXT_BINDING_TEMPLATE
{
    ///Application provided additional channel properties for both bootstrap channel and service channel that cannot be
    ///represented in policy.
    WS_CHANNEL_PROPERTIES channelProperties;
    ///Application provided additional security properties for the bootstrap channel that cannot be represented in
    ///policy.
    WS_SECURITY_PROPERTIES securityProperties;
    ///Application provided SSPI transport security information for both bootstrap channel and service channel that
    ///cannot be represented in policy.
    WS_TCP_SSPI_TRANSPORT_SECURITY_BINDING_TEMPLATE sspiTransportSecurityBinding;
    ///Application provided username binding information for the bootstrap channel that cannot be represented in policy.
    WS_USERNAME_MESSAGE_SECURITY_BINDING_TEMPLATE usernameMessageSecurityBinding;
    WS_SECURITY_CONTEXT_SECURITY_BINDING_TEMPLATE securityContextSecurityBinding;
}

///Security template information to be filled in by application. Associated with
///WS_TCP_SSPI_KERBEROS_APREQ_SECURITY_CONTEXT_BINDING_TEMPLATE_TYPE.
struct WS_TCP_SSPI_KERBEROS_APREQ_SECURITY_CONTEXT_BINDING_TEMPLATE
{
    ///Application provided additional channel properties for both bootstrap channel and service channel that cannot be
    ///represented in policy.
    WS_CHANNEL_PROPERTIES channelProperties;
    ///Application provided additional security properties for the bootstrap channel that cannot be represented in
    ///policy.
    WS_SECURITY_PROPERTIES securityProperties;
    ///Application provided SSPI transport security information for the bootstrap channel and service channel that
    ///cannot be represented in policy.
    WS_TCP_SSPI_TRANSPORT_SECURITY_BINDING_TEMPLATE sspiTransportSecurityBinding;
    ///Application provided kerberos binding information for the bootstrap channel that cannot be represented in policy.
    WS_KERBEROS_APREQ_MESSAGE_SECURITY_BINDING_TEMPLATE kerberosApreqMessageSecurityBinding;
    WS_SECURITY_CONTEXT_SECURITY_BINDING_TEMPLATE securityContextSecurityBinding;
}

struct WEBAUTHN_RP_ENTITY_INFORMATION
{
    uint         dwVersion;
    const(PWSTR) pwszId;
    const(PWSTR) pwszName;
    const(PWSTR) pwszIcon;
}

struct WEBAUTHN_USER_ENTITY_INFORMATION
{
    uint         dwVersion;
    uint         cbId;
    ubyte*       pbId;
    const(PWSTR) pwszName;
    const(PWSTR) pwszIcon;
    const(PWSTR) pwszDisplayName;
}

struct WEBAUTHN_CLIENT_DATA
{
    uint         dwVersion;
    uint         cbClientDataJSON;
    ubyte*       pbClientDataJSON;
    const(PWSTR) pwszHashAlgId;
}

struct WEBAUTHN_COSE_CREDENTIAL_PARAMETER
{
    uint         dwVersion;
    const(PWSTR) pwszCredentialType;
    int          lAlg;
}

struct WEBAUTHN_COSE_CREDENTIAL_PARAMETERS
{
    uint cCredentialParameters;
    WEBAUTHN_COSE_CREDENTIAL_PARAMETER* pCredentialParameters;
}

struct WEBAUTHN_CREDENTIAL
{
    uint         dwVersion;
    uint         cbId;
    ubyte*       pbId;
    const(PWSTR) pwszCredentialType;
}

struct WEBAUTHN_CREDENTIALS
{
    uint                 cCredentials;
    WEBAUTHN_CREDENTIAL* pCredentials;
}

struct WEBAUTHN_CREDENTIAL_EX
{
    uint         dwVersion;
    uint         cbId;
    ubyte*       pbId;
    const(PWSTR) pwszCredentialType;
    uint         dwTransports;
}

struct WEBAUTHN_CREDENTIAL_LIST
{
    uint cCredentials;
    WEBAUTHN_CREDENTIAL_EX** ppCredentials;
}

struct WEBAUTHN_CRED_PROTECT_EXTENSION_IN
{
    uint dwCredProtect;
    BOOL bRequireCredProtect;
}

struct WEBAUTHN_EXTENSION
{
    const(PWSTR) pwszExtensionIdentifier;
    uint         cbExtension;
    void*        pvExtension;
}

struct WEBAUTHN_EXTENSIONS
{
    uint                cExtensions;
    WEBAUTHN_EXTENSION* pExtensions;
}

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
}

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
}

struct WEBAUTHN_X5C
{
    uint   cbData;
    ubyte* pbData;
}

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
}

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
}

// Functions

///This operation begins the process of putting the specified XML Reader in a standard or "canonized" form. The usage
///pattern for canonicalization is: <ul> <li> Move the Reader to the element where canonicalization begins. </li> <li>
///Call <b>WsStartReaderCanonicalization</b>. </li> <li> Move the Reader forward to the end position.</li> <li> Call
///WsEndReaderCanonicalization. </li> </ul>During this process the canonical bytes are written to the specified
///writeCallback. <div class="alert"><b>Note</b> Nodes advanced over are canonicalized including nodes of child elements
///skipped using WsSkipNode. This is beneficial because it means that canonicalization and parsing can be done in one
///pass over the XML content regardless of what functions are used to read the data. </div> <div> </div> In order to use
///the XML Reader solely for canonicalizing an XML element node the application can call
///<b>WsStartReaderCanonicalization</b>, WsSkipNodeand WsEndReaderCanonicalization when the Reader is positioned on the
///element. <b>WsEndReaderCanonicalization</b> must be called in order to ensure that all canonicalized bytes are
///written to the specified callback. <div class="alert"><b>Note</b> <code>WsEndReaderCanonicalization</code> must be
///called at the same depth at which <b>WsStartReaderCanonicalization</b>. Other reader functions return an error if
///moved to a depth lower than where <b>WsStartReaderCanonicalization</b> was called. </div> <div> </div> It is not
///valid to call WsMoveReader or WsSetReaderPosition on a Reader between calls to <b>WsStartReaderCanonicalization</b>
///and WsEndReaderCanonicalization.
///Params:
///    reader = A pointer to the WS_XML_READER object on which canonicalization is started. The pointer must reference a valid
///             <b>XML Reader</b> object.
///    writeCallback = A callback function invoked to write the canonical bytes as they are generated. <div class="alert"><b>Note</b>
///                    This callback is invoked synchronously.</div> <div> </div>
///    writeCallbackState = A pointer to a caller-defined state that is passed when invoking the WS_WRITE_CALLBACK.
///    properties = An "array" reference of optional properties controlling how canonicalization is performed. <div
///                 class="alert"><b>Note</b> See WS_XML_CANONICALIZATION_PROPERTY for details.</div> <div> </div>
///    propertyCount = The number of properties.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_OPERATION</b></dt> </dl> </td> <td
///    width="60%"> The operation is not allowed due to the current state of the object. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl> </td> <td width="60%"> The input data was not in the
///    expected format or did not have the expected value. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsStartReaderCanonicalization(WS_XML_READER* reader, WS_WRITE_CALLBACK writeCallback, 
                                      void* writeCallbackState, const(WS_XML_CANONICALIZATION_PROPERTY)* properties, 
                                      uint propertyCount, WS_ERROR* error);

///This function stops XML canonicalization started by a preceding WsStartReaderCanonicalization function call. Any
///remaining canonical bytes buffered by the reader will be written to the callback function.
///Params:
///    reader = A pointer to the XML reader on which canonicalization should be stopped.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_OPERATION</b></dt> </dl> </td> <td
///    width="60%"> The operation is not allowed due to the current state of the object. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsEndReaderCanonicalization(WS_XML_READER* reader, WS_ERROR* error);

///Starts canonicalization on the specified XML writer.
///Params:
///    writer = The XML writer on which canonicalization should be started.
///    writeCallback = The callback that to be invoked to write the canonical bytes as they are generated. This callback will always be
///                    invoked synchronously.
///    writeCallbackState = Caller-defined state that should be passed when invoking the WS_WRITE_CALLBACK.
///    properties = An array of optional properties controlling how canonicalization is to be performed. See
///                 WS_XML_CANONICALIZATION_PROPERTY.
///    propertyCount = The number of properties.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_OPERATION</b></dt> </dl> </td> <td
///    width="60%"> The operation is not allowed due to the current state of the object. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl> </td> <td width="60%"> The input data was not in the
///    expected format or did not have the expected value. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsStartWriterCanonicalization(WS_XML_WRITER* writer, WS_WRITE_CALLBACK writeCallback, 
                                      void* writeCallbackState, const(WS_XML_CANONICALIZATION_PROPERTY)* properties, 
                                      uint propertyCount, WS_ERROR* error);

///This function stops XML canonicalization started by the preceding WsStartWriterCanonicalization call. Remaining
///canonical bytes buffered by the writer are written to the callback function.
///Params:
///    writer = A pointer to a WS_XML_WRITER object on which canonicalization should be stopped.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_OPERATION</b></dt> </dl> </td> <td
///    width="60%"> The operation is not allowed due to the current state of the object. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsEndWriterCanonicalization(WS_XML_WRITER* writer, WS_ERROR* error);

///Creates an XML Buffer which can be used to process XML data .
///Params:
///    heap = Pointer to the WS_HEAP structure representing the heap from which to allocate memory for the returned XML buffer.
///    properties = An array of WS_XML_BUFFER_PROPERTY structures containing optional properties for the XML buffer. The value of
///                 this parameter may be <b>NULL</b>, in which case, the <i>propertyCount</i> parameter must be 0 (zero).
///    propertyCount = The number of properties in the <i>properties</i> array.
///    buffer = On success, a pointer that receives the address of the WS_XML_BUFFER structure representing the created XML
///             buffer. The memory for this buffer is released when its heap is reset or released. The XML buffer is initially
///             empty.
///    error = Pointer to a WS_ERROR structure that receives additional error information if the function fails.
@DllImport("webservices")
HRESULT WsCreateXmlBuffer(WS_HEAP* heap, const(WS_XML_BUFFER_PROPERTY)* properties, uint propertyCount, 
                          WS_XML_BUFFER** buffer, WS_ERROR* error);

///Removes the node at the specified position from the xml buffer. If positioned on an element it will remove the
///element including all of its children and its corresponding end element, otherwise it will remove a single node. The
///use of any API with a WS_XML_READER or WS_XML_WRITER that currently depends on this position or a child of this
///position will fail. The WS_XML_READER or WS_XML_WRITER must be repositioned before using further. It will return
///<b>WS_E_INVALID_OPERATION</b> if the node is positioned on an end element or the root of the document. (See Windows
///Web Services Return Values.) Calling WsSetReaderPosition or WsSetWriterPosition after calling <b>WsRemoveNode</b>
///will fail.
///Params:
///    nodePosition = The position of the node that should be removed.
///    error = Specifies where additional error information should be stored if the function fails.
@DllImport("webservices")
HRESULT WsRemoveNode(const(WS_XML_NODE_POSITION)* nodePosition, WS_ERROR* error);

///Creates an XML reader with the specified properties.
///Params:
///    properties = An array of WS_XML_READER_PROPERTY structures containing optional properties for the XML reader. The value of
///                 this parameter may be <b>NULL</b>, in which case, the <i>propertyCount</i> parameter must be 0 (zero). For the
///                 properties that tiy can use to configure the XML reader. see the WS_XML_READER_PROPERTY_ID enumeration.
///    propertyCount = The number of properties in the <i>properties</i> array.
///    reader = On success, a pointer that receives the address of the WS_XML_READER structure representing the new XML reader.
///             When you no longer need this structure, you must free it by calling WsFreeReader.
///    error = Pointer to a WS_ERROR structure that receives additional error information if the function fails.
///Returns:
///    If the function succeeds, it returns NO_ERROR; otherwise, it returns an HRESULT error code.
///    
@DllImport("webservices")
HRESULT WsCreateReader(const(WS_XML_READER_PROPERTY)* properties, uint propertyCount, WS_XML_READER** reader, 
                       WS_ERROR* error);

///Sets the encoding and input sources for an XML Reader. These settings override settings made when the Reader was
///created.<div class="alert"><b>Note</b> If both encoding and input are <b>NULL</b> the reader will operate as if it is
///positioned at the end of an empty XML document. </div> <div> </div>
///Params:
///    reader = A pointer to the WS_XML_READER object for which the input will be set.
///    encoding = A to an encoding value that describes the format of the input bytes. This value should be one of:<ul> <li>
///               WS_XML_READER_TEXT_ENCODING </li> <li> WS_XML_READER_BINARY_ENCODING </li> <li> WS_XML_READER_MTOM_ENCODING </li>
///               </ul>
///    input = A pointer to a WS_XML_READER_INPUT structure that indicates the reader type.
///    properties = An array reference of optional Reader properties.
///    propertyCount = The number of properties.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("webservices")
HRESULT WsSetInput(WS_XML_READER* reader, const(WS_XML_READER_ENCODING)* encoding, 
                   const(WS_XML_READER_INPUT)* input, const(WS_XML_READER_PROPERTY)* properties, uint propertyCount, 
                   WS_ERROR* error);

///Sets Reader input to a specified XML buffer. Reader properties specified to <b>WsSetInputToBuffer</b> override
///properties set by WsCreateReader. The reader does not modify WS_XML_BUFFER input data. <div class="alert"><b>Note</b>
///It is permissible for more than one reader to read from the same <b>WS_XML_BUFFER</b>.</div> <div> </div>
///Params:
///    reader = A pointer to the WS_XML_READER object for which the input will be set.
///    buffer = A pointer to the XML buffer to read.
///    properties = A pointer that references an array of optional Reader properties. <div class="alert"><b>Note</b> For more
///                 information see WS_XML_READER_PROPERTY.</div> <div> </div>.
///    propertyCount = The number of properties.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("webservices")
HRESULT WsSetInputToBuffer(WS_XML_READER* reader, WS_XML_BUFFER* buffer, const(WS_XML_READER_PROPERTY)* properties, 
                           uint propertyCount, WS_ERROR* error);

///Releases the memory resource associated with an XML_Reader object.
@DllImport("webservices")
void WsFreeReader(WS_XML_READER* reader);

///This function returns a property of the specified XML Reader. <div class="alert"><b>Note</b> Obtaining the Property
///<b>WS_XML_READER_PROPERTY_CHARSET</b> will require inspecting up to the first four bytes of the XML data.
///Consequently if the Reader is using WS_XML_READER_STREAM_INPUT the WsFillReader function must be called first to
///ensure that this data has been read.</div><div> </div>
///Params:
///    reader = A pointer to a WS_XML_READER object containing the desired property value.
///    id = An enumerator value identifier of the Reader property.
///    value = A pointer to the address for returning the retrieved value. The pointer must have an alignment compatible with
///            the type of the property.
///    valueSize = A byte count of the buffer that the caller has allocated for the retrieved value.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
@DllImport("webservices")
HRESULT WsGetReaderProperty(WS_XML_READER* reader, WS_XML_READER_PROPERTY_ID id, void* value, uint valueSize, 
                            WS_ERROR* error);

///The function returns the XML node at the current position of the XML reader.
///Params:
///    xmlReader = A pointer to the reader for which the current node will be obtained. This must be valid WS_XML_READER object.
///    node = A reference to a WS_XML_NODE structure where the current node is returned.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are
///    invalid. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsGetReaderNode(WS_XML_READER* xmlReader, const(WS_XML_NODE)** node, WS_ERROR* error);

///Ensures that the reader has buffered the minimum byte count of XML data for use by subsequent reader functions. It
///will invoke the callback specified by WS_XML_READER_STREAM_INPUTas many times as necessary to obtain the number of
///bytes specified by the value of the <i>minSize</i> parameter. On completion the buffered data is available to other
///reader functions. If a subsequent reader function requires more data than what has been obtained the function will
///return a <b>WS_E_QUOTA_EXCEEDED</b> exception. (See Windows Web Services Return Values.)
///Params:
///    reader = A pointer to a WS_XML_READER structure used for obtaining the data.
///    minSize = Specifies the minimum number of bytes that the reader should have obtained. If the current byte count buffered is
///              equal to or greater than the value of <i>minSize</i> the function will do nothing and will return immediately.
///    asyncContext = A pointer to a WS_ASYNC_CONTEXT data structure with information about invoking the function asynchronously. A
///                   <b>NULL</b> value indicates a request for synchronous operation.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>WS_S_ASYNC</b></dt> </dl> </td> <td width="60%"> The asynchronous operation is still
///    pending. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsFillReader(WS_XML_READER* reader, uint minSize, const(WS_ASYNC_CONTEXT)* asyncContext, WS_ERROR* error);

///Calling this function advances the reader past a start element skipping any whitespace. After parsing if the Reader
///is not positioned on a start element it will return a<b>WS_E_INVALID_FORMAT</b> exception. (See Windows Web Services
///Return Values.)
///Params:
///    reader = A pointer to the <b>XML Reader</b> object used to read the Start element.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl> </td> <td width="60%"> The input data was not in
///    the expected format or did not have the expected value. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_QUOTA_EXCEEDED</b></dt> </dl> </td> <td width="60%"> A quota was exceeded. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsReadStartElement(WS_XML_READER* reader, WS_ERROR* error);

///Advances the reader to the next start element skipping whitespace and comments if necessary. Optionally, it may also
///verify the localName and namespace of the element.
///Params:
///    reader = The reader which is to read to the start element.
///    localName = The localName name that the element should be. If <b>NULL</b>, any localName is permitted.
///    ns = The namespace that the element should be. If <b>NULL</b>, any namespace is permitted.
///    found = If specified then this will indicate whether an element is found and the localName and namespace, if also
///            specified, match. If not specified, and an element is not found or the localName and namespace don't match, then
///            it will return <b>WS_E_INVALID_FORMAT</b>. (See Windows Web Services Return Values.)
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl> </td> <td width="60%"> The input data was not in
///    the expected format or did not have the expected value. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_QUOTA_EXCEEDED</b></dt> </dl> </td> <td width="60%"> A quota was exceeded. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsReadToStartElement(WS_XML_READER* reader, const(WS_XML_STRING)* localName, const(WS_XML_STRING)* ns, 
                             BOOL* found, WS_ERROR* error);

///Moves the Reader to the specified attribute so that the content may be read using WsReadValue, WsReadChars, or
///WsReadBytes. If the reader is not positioned on a start element then it returns a <b>WS_E_INVALID_FORMAT</b>
///exception. (See Windows Web Services Return Values.)<div class="alert"><b>Note</b> Attributes read do not appear in
///any particular order. WsFindAttribute can be used to locate the index of a particular attribute. </div> <div> </div>
///Params:
///    reader = A pointer to the <b>XML Reader</b> object used to read the Start attribute.
///    attributeIndex = The index of the attribute to read.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl> </td> <td width="60%"> The input data was not in
///    the expected format or did not have the expected value. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsReadStartAttribute(WS_XML_READER* reader, uint attributeIndex, WS_ERROR* error);

///Moves the reader back to the element node containing the attribute that was read.
///Params:
///    reader = A pointer to the <b>XML Reader</b> that reads the <b>End attribute</b>. The pointer must reference a valid
///             WS_XML_READER object.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl> </td> <td width="60%"> The input data was not in
///    the expected format or did not have the expected value. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsReadEndAttribute(WS_XML_READER* reader, WS_ERROR* error);

///This operation advances the Reader to the next node in the input stream. If there is an error parsing the input the
///function will return <b>WS_E_INVALID_FORMAT</b>. (See Windows Web Services Return Values.)
///Params:
///    reader = A pointer to the <b>XML Reader</b> object to advance. The pointer must reference a valid WS_XML_READER and it may
///             not be <b>NULL</b>.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl> </td> <td width="60%"> The input data was not in
///    the expected format, or did not have the expected value, or multiple top-level elements were found and
///    <b>WS_XML_READER_PROPERTY_ALLOW_FRAGMENT</b> is <b>FALSE</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_QUOTA_EXCEEDED</b></dt> </dl> </td> <td width="60%"> An element was read that exceeded some limit
///    such as <b>WS_XML_READER_PROPERTY_MAX_DEPTH</b> or <b>WS_XML_READER_PROPERTY_MAX_ATTRIBUTES</b>. </td> </tr>
///    </table>
///    
@DllImport("webservices")
HRESULT WsReadNode(WS_XML_READER* reader, WS_ERROR* error);

///Advances the reader in the input stream. If the current node is an element, all of the children of that element are
///skipped, and the reader is positioned on the node following its end element. Otherwise, the reader is positioned on
///the next node in the same manner as WsReadNode.
///Params:
///    reader = The reader which is to skip to the next node.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl> </td> <td width="60%"> The input data was not in
///    the expected format or did not have the expected value. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_QUOTA_EXCEEDED</b></dt> </dl> </td> <td width="60%"> A quota was exceeded. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsSkipNode(WS_XML_READER* reader, WS_ERROR* error);

///This function ensures that the current Reader node is an <b>End element</b>and advances the reader to the next
///<b>node</b>. If the Reader is not positioned on an <b>End element</b> when the function is called it will skip
///whitespace attempting to find one. If after skipping whitespace it is not positioned on an <b>End element</b> it
///returns a <b>WS_E_INVALID_FORMAT</b> exception. (See Windows Web Services Return Values.)
///Params:
///    reader = A pointer to the <b>XML Reader</b> that is reads the <b>End element</b>. The pointer must reference a valid
///             WS_XML_READER object.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl> </td> <td width="60%"> The input data was not in
///    the expected format or did not have the expected value. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_QUOTA_EXCEEDED</b></dt> </dl> </td> <td width="60%"> A quota was exceeded. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsReadEndElement(WS_XML_READER* reader, WS_ERROR* error);

///Searches the attributes of the current element for an attribute with the specified name and namespace and returns its
///index which may be passed to WsReadStartAttribute.
///Params:
///    reader = The reader on which to find the attribute.
///    localName = The local name of the attribute to search for.
///    ns = The namespace of the attribute to search for.
///    required = If required is <b>TRUE</b> and the attribute is not found, the function will return <b>WS_E_INVALID_FORMAT</b>.
///               (See Windows Web Services Return Values.) if required is <b>FALSE</b> and the attribute is not found, the
///               function will return S_FALSE.
///    attributeIndex = If the attribute is found, then the index of the attribute, is returned here. This index can then be passed to
///                     WsReadStartAttribute.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl> </td> <td width="60%"> The input data was not in
///    the expected format or did not have the expected value. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsFindAttribute(WS_XML_READER* reader, const(WS_XML_STRING)* localName, const(WS_XML_STRING)* ns, 
                        BOOL required, uint* attributeIndex, WS_ERROR* error);

///Reads text from a Reader and parses it according to the specified value type. The Reader reads from its current
///position up to the next Start or End element and parses them according to the specified value type. If the Reader is
///already positioned on a Start or End element the buffer remains empty. Comments are skipped and CDATA content is
///treated the same as other element content. Leading and trailing whitespaces are ignored. If the value cannot be
///parsed according to the specified value type, the function returns a <b>WS_E_INVALID_FORMAT</b> error code. (See
///Windows Web Services Return Values.)<div class="alert"><b>Note</b> This function can fail for any of the reasons
///listed in WsReadNode.</div> <div> </div>
///Params:
///    reader = A pointer to the <b>XML Reader</b> from which the value is read.
///    valueType = The text interpretation type.
///    value = A pointer to the parsed data if parsing was successful according to the specified value type. The size required
///            is determined by value type. See WS_VALUE_TYPE for more information.
///    valueSize = The byte size of the retrieved value.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl> </td> <td width="60%"> The input data was not in
///    the expected format or did not have the expected value. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_QUOTA_EXCEEDED</b></dt> </dl> </td> <td width="60%"> A quota was exceeded. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsReadValue(WS_XML_READER* reader, WS_VALUE_TYPE valueType, void* value, uint valueSize, WS_ERROR* error);

///Reads a specified number of text characters from the Reader.
///Params:
///    reader = A pointer to the <b>XML Reader</b> from which the character data should be read. The pointer must reference a
///             valid WS_XML_READER object.
///    chars = A pointer to a location for the characters that have been read.
///    maxCharCount = The maximum number of characters that should be read.
///    actualCharCount = A pointer to a ULONG value of the actual number of characters that were read. This may be less than maxCharCount
///                      even when there are more characters remaining. There are no more characters when this returns zero.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl> </td> <td width="60%"> The input data was not in
///    the expected format or did not have the expected value. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_QUOTA_EXCEEDED</b></dt> </dl> </td> <td width="60%"> A quota was exceeded. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsReadChars(WS_XML_READER* reader, PWSTR chars, uint maxCharCount, uint* actualCharCount, WS_ERROR* error);

///Reads a specified number of text characters from the reader and returns them encoded in UTF-8.
///Params:
///    reader = A pointer to the <b>XML Reader</b> from which the character data should be read. The pointer must reference a
///             valid WS_XML_READER object.
///    bytes = A pointer to the buffer to place the encoded bytes that have been read.
///    maxByteCount = The maximum number of bytes that should be read.
///    actualByteCount = A pointer to a ULONG value of the actual number of bytes that were read. This may be less than maxByteCount even
///                      when there are more bytes remaining. There are no more bytes when this returns zero.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl> </td> <td width="60%"> The input data was not in
///    the expected format or did not have the expected value. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_QUOTA_EXCEEDED</b></dt> </dl> </td> <td width="60%"> A quota was exceeded. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsReadCharsUtf8(WS_XML_READER* reader, ubyte* bytes, uint maxByteCount, uint* actualByteCount, 
                        WS_ERROR* error);

///Reads text from the Reader and decodes the characters as bytes according to the base64 specification.
///Params:
///    reader = A pointer to the <b>XML Reader</b> from which the bytes should be read. The pointer must reference a valid
///             WS_XML_READER object.
///    bytes = A pointer to a location to place the decoded bytes.
///    maxByteCount = The maximum number of bytes that should be read.
///    actualByteCount = A pointer to a ULONG value of the actual number of bytes that were read. This may be less than maxByteCount even
///                      when there are more bytes remaining.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl> </td> <td width="60%"> The input data was not in
///    the expected format or did not have the expected value. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_QUOTA_EXCEEDED</b></dt> </dl> </td> <td width="60%"> A quota was exceeded. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsReadBytes(WS_XML_READER* reader, void* bytes, uint maxByteCount, uint* actualByteCount, WS_ERROR* error);

///Reads a series of elements from the reader and interprets their content according to the specified value type.
///Params:
///    reader = The reader from which the array should be read.
///    localName = The localName of the repeating element.
///    ns = The namespace of the repeating element.
///    valueType = The value type to use to parse the content of each element.
///    array = The array to populate with parsed values. The size of the array items is determined by the value type. See
///            WS_VALUE_TYPE for more information.
///    arraySize = The size in bytes (not items) of the array.
///    itemOffset = The item (not byte) offset within the array at which to read.
///    itemCount = The number of items (not bytes) to read into the array.
///    actualItemCount = The actual number of items that were read. This may be less than itemCount even when there are more items
///                      remaining. There are no more elements when this returns zero.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl> </td> <td width="60%"> The input data was not in
///    the expected format or did not have the expected value. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_QUOTA_EXCEEDED</b></dt> </dl> </td> <td width="60%"> A quota was exceeded. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsReadArray(WS_XML_READER* reader, const(WS_XML_STRING)* localName, const(WS_XML_STRING)* ns, 
                    WS_VALUE_TYPE valueType, void* array, uint arraySize, uint itemOffset, uint itemCount, 
                    uint* actualItemCount, WS_ERROR* error);

///Returns the current position of the reader. This can only be used on a reader that is set to an XmlBuffer.
///Params:
///    reader = The reader for which the current position will be obtained.
///    nodePosition = The current position of the reader.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are
///    invalid. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsGetReaderPosition(WS_XML_READER* reader, WS_XML_NODE_POSITION* nodePosition, WS_ERROR* error);

///Sets the current position of the Reader. The position must have been obtained by a call to WsGetReaderPosition or
///WsGetWriterPosition. This function can only be used on a reader that is set to a WS_XML_BUFFER.
///Params:
///    reader = A pointer to the WS_XML_READER object for which the current position is set. The pointer must reference a valid
///             <b>XML Reader</b> object.
///    nodePosition = A pointer to the position to set the Reader.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_OPERATION</b></dt> </dl> </td> <td
///    width="60%"> The operation is not allowed due to the current state of the object. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsSetReaderPosition(WS_XML_READER* reader, const(WS_XML_NODE_POSITION)* nodePosition, WS_ERROR* error);

///Moves the current position of the reader as specified by the <i>moveTo</i> parameter. This function can only be used
///on a reader that is set to an XmlBuffer.
///Params:
///    reader = A pointer to the <b>XML Reader</b> object with the position to move. The pointer must reference a valid
///             WS_XML_READER object and the referenced <b>Reader</b> value may not be <b>NULL</b>.
///    moveTo = This enumerator specifies direction or next position of the Reader relative to the current position.
///    found = Indicates success or failure of the specified move.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl> </td> <td width="60%">
///    The input data was not in the expected format or did not have the expected value. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>WS_E_INVALID_OPERATION</b></dt> </dl> </td> <td width="60%"> The operation is not
///    allowed due to the current state of the object. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsMoveReader(WS_XML_READER* reader, WS_MOVE_TO moveTo, BOOL* found, WS_ERROR* error);

///creates an XML Writer with the specified properties.
///Params:
///    properties = An array of WS_XML_WRITER_PROPERTY structures containing optional properties for the XML writer. The value of
///                 this parameter may be <b>NULL</b>, in which case, the <i>propertyCount</i> parameter must be 0 (zero).
///    propertyCount = The number of properties in the <i>properties</i> array.
///    writer = On success, a pointer that receives the address of the WS_XML_WRITER structure representing the created XML
///             writer. When you no longer need this structure, you must free it by calling WsFreeWriter.
///    error = Pointer to a WS_ERROR structure that receives additional error information if the function fails.
///Returns:
///    If the function succeeds, it returns NO_ERROR; otherwise, it returns an HRESULT error code. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
///    </td> <td width="60%"> One or more arguments are invalid. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsCreateWriter(const(WS_XML_WRITER_PROPERTY)* properties, uint propertyCount, WS_XML_WRITER** writer, 
                       WS_ERROR* error);

///Releases the memory resource associated with an XML Writer object.
///Params:
///    writer = A pointer to the <b>XML Writer</b> object to release. The pointer must reference a valid WS_XML_WRITER object
///             returned by WsCreateWriter and the referenced value may not be <b>NULL</b>.
@DllImport("webservices")
void WsFreeWriter(WS_XML_WRITER* writer);

///Sets the encoding and output callbacks for the writer. The callbacks are used to provides buffers to the writer and
///to perform asynchronous i/o.
///Params:
///    writer = The writer for which the output will be set.
///    encoding = The encoding describes the format of the input bytes. This should be one of WS_XML_WRITER_TEXT_ENCODING,
///               WS_XML_WRITER_BINARY_ENCODING or WS_XML_WRITER_MTOM_ENCODING.
///    output = Specifies where the writer should place its data.
///    properties = An array of optional properties of the writer. See WS_XML_WRITER_PROPERTY.
///    propertyCount = The number of properties.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are
///    invalid. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsSetOutput(WS_XML_WRITER* writer, const(WS_XML_WRITER_ENCODING)* encoding, 
                    const(WS_XML_WRITER_OUTPUT)* output, const(WS_XML_WRITER_PROPERTY)* properties, 
                    uint propertyCount, WS_ERROR* error);

///This operation positions the Writer at the end of the specified buffer. When an XML Writer has an XML Buffer set as
///output the Writer can be used in a "random access" fashion and the functions WsGetWriterPosition, WsSetWriterPosition
///and WsMoveWriter can be used. Properties specified for this function override those specified with the
///<code>WsCreateWriter</code> function. <div class="alert"><b>Note</b> See WsCreateWriter for the default values of the
///properties of the writer. </div> <div> </div>
///Params:
///    writer = A pointer to the WS_XML_WRITER object for which the output is set. The pointer must reference a valid <b>XML
///             Writer</b> object.
///    buffer = A pointer to the buffer where the Writer sends the data.
///    properties = A WS_XML_WRITER_PROPERTY pointer that references an "array" of optional Writer properties.
///    propertyCount = The number of properties.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are
///    invalid. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsSetOutputToBuffer(WS_XML_WRITER* writer, WS_XML_BUFFER* buffer, 
                            const(WS_XML_WRITER_PROPERTY)* properties, uint propertyCount, WS_ERROR* error);

///Retrieves a specified XML Writer property. The property to retrieve is identified by a WS_XML WRITER_PROPERTY_ID
///input parameter.
///Params:
///    writer = A pointer to a WS_XML_WRITER structure that contains the property value to retrieve.
///    id = This is a <b>WS_XML_WRITER_PROPERTY_ID</b> enumerator that identifies the property to retrieve.
///    value = A void pointer to a location for storing the retrieved property value.
///    valueSize = The byte-length buffer size allocated by the caller to store the retrieved property value. The pointer must have
///                an alignment compatible with the type of the property.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
@DllImport("webservices")
HRESULT WsGetWriterProperty(WS_XML_WRITER* writer, WS_XML_WRITER_PROPERTY_ID id, void* value, uint valueSize, 
                            WS_ERROR* error);

///Instructs the writer to invoke the callbackspecified in WS_XML_WRITER_STREAM_OUTPUT if sufficient data has been
///buffered.
///Params:
///    writer = The writer to flush.
///    minSize = Specifies the minimum number of bytes that must be buffered in order for the callback to be invoked. If fewer
///              than this number of bytes are buffered, then the <b>callback</b> will not be invoked. This can be used to
///              minimize the number of i/o's that occur when writing small amounts of data. Zero should be specified to guarantee
///              that the callback is invoked.
///    asyncContext = Information on how to invoke the function asynchronously, or <b>NULL</b> if invoking synchronously.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_S_ASYNC</b></dt> </dl> </td> <td width="60%"> The
///    asynchronous operation is still pending. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsFlushWriter(WS_XML_WRITER* writer, uint minSize, const(WS_ASYNC_CONTEXT)* asyncContext, WS_ERROR* error);

///Writes a start element to the writer. After calling this function WsWriteStartAttribute or WsWriteXmlnsAttributecan
///be called to write additional attributes to the element. The element is not committed to the writer until
///WsWriteEndElement or some other function that writes content is called.
///Params:
///    writer = A pointer to the WS_XML_WRITER object to which the start element is written. The pointer must reference a valid
///             <b>XML Writer</b> object.
///    prefix = A WS_XML_STRING pointer to the prefix to use for the start element. If the value referenced by this parameter is
///             <b>NULL</b> the Writer will choose a attribute.
///    localName = A WS_XML_STRING pointer to the local name used by the start element. It must be at least one character long.
///    ns = A WS_XML_STRING pointer to the namespace to be used for the start element. If no prefix is specified the Writer
///         may use a prefix in scope that is bound to the specified namespace or it may generate a prefix and include an
///         XMLNS attribute. If a prefix is specified the Writer will use that prefix and may include an XMLNS attribute if
///         needed to override an existing prefix in scope.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_OPERATION</b></dt> </dl> </td> <td
///    width="60%"> The operation is not allowed due to the current state of the object. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl> </td> <td width="60%"> The input data was not in the
///    expected format or did not have the expected value. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_QUOTA_EXCEEDED</b></dt> </dl> </td> <td width="60%"> A quota was exceeded. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsWriteStartElement(WS_XML_WRITER* writer, const(WS_XML_STRING)* prefix, const(WS_XML_STRING)* localName, 
                            const(WS_XML_STRING)* ns, WS_ERROR* error);

///Forces the writer to commit the current element and prevent further attributes from being written to the element.
///Params:
///    writer = The writer for which the current element should be committed.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_OPERATION</b></dt> </dl> </td> <td
///    width="60%"> The operation is not allowed due to the current state of the object. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl> </td> <td width="60%"> The input data was not in the
///    expected format or did not have the expected value. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_QUOTA_EXCEEDED</b></dt> </dl> </td> <td width="60%"> A quota was exceeded. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsWriteEndStartElement(WS_XML_WRITER* writer, WS_ERROR* error);

///Writes an Xmlns attribute to the current element. WsWriteStartElement must be called before an attribute can be
///written and if the number of attributes exceeds the maximum number of attributes permitted for the writer the
///function returns <b>WS_E_QUOTA_EXCEEDED</b>. (See Windows Web Services Return Values.)
///Params:
///    writer = A pointer to the WS_XML_WRITER object to which the Xmlns attribute is written. The pointer must reference a valid
///             <b>XML Writer</b> object.
///    prefix = A WS_XML_STRING pointer to the prefix to use for the start element. If the value referenced by this parameter is
///             <b>NULL</b> the Writer will choose a attribute. Specifies the prefix to use for the xmlns attribute.
///    ns = A WS_XML_STRING pointer to the namespace to bind to the prefix.
///    singleQuote = Determines whether to use a single or a double quote for the attribute value. <div class="alert"><b>Note</b> If
///                  WS_XML_WRITER_BINARY_ENCODING is set the quotation character is not preserved and this parameter has have no
///                  effect. </div> <div> </div>
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_OPERATION</b></dt> </dl> </td> <td
///    width="60%"> The operation is not allowed due to the current state of the object. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl> </td> <td width="60%"> The input data was not in the
///    expected format or did not have the expected value. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_QUOTA_EXCEEDED</b></dt> </dl> </td> <td width="60%"> A quota was exceeded. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsWriteXmlnsAttribute(WS_XML_WRITER* writer, const(WS_XML_STRING)* prefix, const(WS_XML_STRING)* ns, 
                              BOOL singleQuote, WS_ERROR* error);

///This operation starts writing an attribute to the current element. WsWriteStartElement must be called before an
///attribute can be written. After the attribute has been started, the attribute value can be written using
///WsWriteChars, WsWriteBytes, or WsWriteValue. The attribute must be completed using using WsWriteEndAttribute.
///Params:
///    writer = A pointer to the WS_XML_WRITER object to which the attribute is written. The pointer must reference a valid
///             <b>XML Writer</b> object.
///    prefix = A WS_XML_STRING pointer to the prefix to use for the attribute. If the value referenced by this parameter is
///             <b>NULL</b> the Writer will choose a attribute.
///    localName = A WS_XML_STRING pointer to the local name used by the attribute. It must be at least one character long.
///    ns = A WS_XML_STRING pointer to the namespace to be used for the attribute. If no prefix is specified the Writer may
///         use a prefix in scope that is bound to the specified namespace or it may generate a prefix and include an XMLNS
///         attribute. If a prefix is specified the Writer will use that prefix and may include an XMLNS attribute if needed
///         to override an existing prefix in scope.
///    singleQuote = Determines whether to use a single or a double quote for the attribute value. <div class="alert"><b>Note</b> With
///                  WS_XML_WRITER_BINARY_ENCODING the quote character is not preserved and this parameter has no effect. </div> <div>
///                  </div>
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_OPERATION</b></dt> </dl> </td> <td
///    width="60%"> The operation is not allowed due to the current state of the object. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl> </td> <td width="60%"> The input data was not in the
///    expected format or did not have the expected value. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_QUOTA_EXCEEDED</b></dt> </dl> </td> <td width="60%"> A quota was exceeded. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsWriteStartAttribute(WS_XML_WRITER* writer, const(WS_XML_STRING)* prefix, const(WS_XML_STRING)* localName, 
                              const(WS_XML_STRING)* ns, BOOL singleQuote, WS_ERROR* error);

///This operation finishes writing an attribute to the current element. If WsWriteStartAttribute is called the Writer
///does not permit another element or attribute to be written until <b>WsWriteEndAttribute</b> is called.
///Params:
///    writer = A pointer to the WS_XML_WRITER object to which the attribute is written. The pointer must reference a valid
///             <b>XML Writer</b> object.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
@DllImport("webservices")
HRESULT WsWriteEndAttribute(WS_XML_WRITER* writer, WS_ERROR* error);

///This operation derives the best representation for a primitive value from the underlying encoding and passes the
///derived value to a Writer object. <div class="alert"><b>Note</b> It is generally more efficient to use this function
///to write out primitive values rather than converting the value to text and subsequently using WsWriteChars.</div>
///<div> </div>
///Params:
///    writer = A pointer to the WS_XML_WRITER object to which the value is written. The pointer must reference a valid <b>XML
///             Writer</b> object.
///    valueType = Indicates the Type of primitive value referenced by the <i>value</i> parameter. I
///    value = A void pointer to the primitive value.
///    valueSize = The size in bytes of the value being written.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_OPERATION</b></dt> </dl> </td> <td
///    width="60%"> The operation is not allowed due to the current state of the object. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsWriteValue(WS_XML_WRITER* writer, WS_VALUE_TYPE valueType, const(void)* value, uint valueSize, 
                     WS_ERROR* error);

///Writes a WS_XML_BUFFER to a writer.
///Params:
///    writer = The writer to which the XML buffer will be written.
///    xmlBuffer = The XML buffer to write.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_OPERATION</b></dt> </dl> </td> <td
///    width="60%"> The operation is not allowed due to the current state of the object. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>WS_E_QUOTA_EXCEEDED</b></dt> </dl> </td> <td width="60%"> A quota was exceeded. </td>
///    </tr> </table>
///    
@DllImport("webservices")
HRESULT WsWriteXmlBuffer(WS_XML_WRITER* writer, WS_XML_BUFFER* xmlBuffer, WS_ERROR* error);

///Reads the current node from a reader into a WS_XML_BUFFER.
///Params:
///    reader = The reader from which to read into the XML buffer.
///    heap = The heap from which to allocate the XML buffer.
///    xmlBuffer = The XML buffer is returned here.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_OPERATION</b></dt> </dl> </td> <td
///    width="60%"> The operation is not allowed due to the current state of the object. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>WS_E_QUOTA_EXCEEDED</b></dt> </dl> </td> <td width="60%"> A quota was exceeded. </td>
///    </tr> </table>
///    
@DllImport("webservices")
HRESULT WsReadXmlBuffer(WS_XML_READER* reader, WS_HEAP* heap, WS_XML_BUFFER** xmlBuffer, WS_ERROR* error);

///Uses a writer to convert a WS_XML_BUFFER to an encoded set of bytes.
///Params:
///    writer = The writer to use to generate the encoded bytes.
///    xmlBuffer = The XML buffer to write.
///    encoding = The encoding to use when generating the bytes. If <b>NULL</b>, the bytes will be encoded in utf8.
///    properties = An array of optional properties of the writer. See WS_XML_WRITER_PROPERTY.
///    propertyCount = The number of properties.
///    heap = The heap from which to allocate the bytes.
///    bytes = The generated bytes are returned here.
///    byteCount = The number of generated bytes are returned here.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_OPERATION</b></dt> </dl> </td> <td
///    width="60%"> The operation is not allowed due to the current state of the object. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>WS_E_QUOTA_EXCEEDED</b></dt> </dl> </td> <td width="60%"> A quota was exceeded. </td>
///    </tr> </table>
///    
@DllImport("webservices")
HRESULT WsWriteXmlBufferToBytes(WS_XML_WRITER* writer, WS_XML_BUFFER* xmlBuffer, 
                                const(WS_XML_WRITER_ENCODING)* encoding, const(WS_XML_WRITER_PROPERTY)* properties, 
                                uint propertyCount, WS_HEAP* heap, void** bytes, uint* byteCount, WS_ERROR* error);

///Uses a reader to convert a set of encoded bytes to a WS_XML_BUFFER.
///Params:
///    reader = The reader to use to parse the encoded bytes.
///    encoding = The encoding to use when parsing the bytes. If <b>NULL</b>, a WS_XML_READER_TEXT_ENCODING with a charset of
///               WS_CHARSET_AUTO will be used.
///    properties = An array of optional properties of the reader. See WS_XML_READER_PROPERTY.
///    propertyCount = The number of properties.
///    bytes = The bytes to parse.
///    byteCount = The number of bytes to parse.
///    heap = The heap from which to allocate the XML buffer.
///    xmlBuffer = The XML buffer into which the bytes were read is returned here.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_OPERATION</b></dt> </dl> </td> <td
///    width="60%"> The operation is not allowed due to the current state of the object. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>WS_E_QUOTA_EXCEEDED</b></dt> </dl> </td> <td width="60%"> A quota was exceeded. </td>
///    </tr> </table>
///    
@DllImport("webservices")
HRESULT WsReadXmlBufferFromBytes(WS_XML_READER* reader, const(WS_XML_READER_ENCODING)* encoding, 
                                 const(WS_XML_READER_PROPERTY)* properties, uint propertyCount, const(void)* bytes, 
                                 uint byteCount, WS_HEAP* heap, WS_XML_BUFFER** xmlBuffer, WS_ERROR* error);

///This operation sends a series of elements to an XML Writer.
///Params:
///    writer = A pointer to the Writer where the elements are written.
///    localName = A pointer to the localName of the repeating element.
///    ns = A pointer to the namespace of the repeating element.
///    valueType = The value type for the elements
///    array = A void pointer to the values written to <i>writer</i>. The size of the items is determined by value type. <div
///            class="alert"><b>Note</b> See WS_VALUE_TYPE for more information. </div> <div> </div>
///    arraySize = The total byte length of the array.
///    itemOffset = The item offset within the array to write.
///    itemCount = The total number of items to write from the array.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("webservices")
HRESULT WsWriteArray(WS_XML_WRITER* writer, const(WS_XML_STRING)* localName, const(WS_XML_STRING)* ns, 
                     WS_VALUE_TYPE valueType, const(void)* array, uint arraySize, uint itemOffset, uint itemCount, 
                     WS_ERROR* error);

///Writes an XML qualified name to the Writer.
///Params:
///    writer = A pointer to the WS_XML_WRITER object to which the qualified name is written. The pointer must reference a valid
///             <b>XML Writer</b> object.
///    prefix = A WS_XML_STRING pointer to the prefix used by the qualified name. If the value referenced by this parameter is
///             <b>NULL</b> the Writer will choose a prefix.
///    localName = A WS_XML_STRING pointer to the local name used by the qualified name. It must be at least one character long.
///    ns = A WS_XML_STRING pointer to the namespace used for the qualified name. If no prefix is specified the Writer may
///         use a prefix in scope that is bound to the specified namespace or it may generate a prefix and include an XMLNS
///         attribute. If a prefix is specified the Writer uses that prefix and may include an XMLNS attribute if needed to
///         override an existing prefix in scope.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl> </td> <td width="60%">
///    The input data was not in the expected format or did not have the expected value. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsWriteQualifiedName(WS_XML_WRITER* writer, const(WS_XML_STRING)* prefix, const(WS_XML_STRING)* localName, 
                             const(WS_XML_STRING)* ns, WS_ERROR* error);

///Writes a series of characters to an element or attribute. To write characters to an attribute value, call
///WsWriteStartAttribute first. Only whitespace characters may be written at the root of an xml document unless the
///<b>WS_XML_WRITER_PROPERTY_ALLOW_FRAGMENT</b> has been set to <b>TRUE</b>.
///Params:
///    writer = A pointer to the WS_XML_WRITER object to which the characters are written. The pointer must reference a valid
///             <b>XML Writer</b> object.
///    chars = A pointer to the characters to write.
///    charCount = The number of characters to write.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_OPERATION</b></dt> </dl> </td> <td
///    width="60%"> The operation is not allowed due to the current state of the object. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsWriteChars(WS_XML_WRITER* writer, const(PWSTR) chars, uint charCount, WS_ERROR* error);

///Writes a series of characters encoded as UTF-8 to an element or attribute. To write characters to an attribute value,
///call WsWriteStartAttribute first. Only whitespace characters may be written at the root of an xml document unless the
///<b>WS_XML_WRITER_PROPERTY_ALLOW_FRAGMENT</b> has been set to <b>TRUE</b>.
///Params:
///    writer = A pointer to the WS_XML_WRITER object to which the characters are written. The pointer must reference a valid
///             <b>XML Writer</b> object.
///    bytes = A pointer to the encoded UTF-8 characters to write.
///    byteCount = The number of bytes to write.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_OPERATION</b></dt> </dl> </td> <td
///    width="60%"> The operation is not allowed due to the current state of the object. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsWriteCharsUtf8(WS_XML_WRITER* writer, const(ubyte)* bytes, uint byteCount, WS_ERROR* error);

///Writes bytes to the writer in a format optimized for the encoding. When writing in a text encoding, it will emit the
///bytes encoded in base64. When writing to a binary format, it will emit the bytes directly.
///Params:
///    writer = The writer to which the bytes will be written.
///    bytes = The bytes to write to the document.
///    byteCount = The number bytes to write to the document.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_OPERATION</b></dt> </dl> </td> <td
///    width="60%"> The operation is not allowed due to the current state of the object. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>WS_E_QUOTA_EXCEEDED</b></dt> </dl> </td> <td width="60%"> A quota was exceeded. </td>
///    </tr> </table>
///    
@DllImport("webservices")
HRESULT WsWriteBytes(WS_XML_WRITER* writer, const(void)* bytes, uint byteCount, WS_ERROR* error);

///Establishes a callback to be invoked to write bytes within an element. In some encodings this can be more efficient
///by eliminating a copy of the data.
///Params:
///    writer = A pointer to the XML Writer object to which the bytes are written. The pointer must reference a valid
///             WS_XML_WRITER and the referenced value may not be <b>NULL</b>.
///    callback = This parameter is the callback to invoke to write the data.
///    callbackState = A pointer to a user-defined state that is passed to the callback function.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_OPERATION</b></dt> </dl> </td> <td
///    width="60%"> The operation is not allowed due to the current state of the object. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsPushBytes(WS_XML_WRITER* writer, WS_PUSH_BYTES_CALLBACK callback, void* callbackState, WS_ERROR* error);

///Sets up a callback to be invoked to obtain the bytes to be written within an element. In some encodings this can be
///more efficient by eliminating a copy of the data.
///Params:
///    writer = The writer to which the bytes will be written.
///    callback = The callback to invoke when its time to write the binary data.
///    callbackState = User-defined state to be passed to the callback.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_OPERATION</b></dt> </dl> </td> <td
///    width="60%"> The operation is not allowed due to the current state of the object. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>WS_E_QUOTA_EXCEEDED</b></dt> </dl> </td> <td width="60%"> A quota was exceeded. </td>
///    </tr> </table>
///    
@DllImport("webservices")
HRESULT WsPullBytes(WS_XML_WRITER* writer, WS_PULL_BYTES_CALLBACK callback, void* callbackState, WS_ERROR* error);

///Writes an end element to a Writer. If the writer has no open elements, the function returns
///<b>WS_E_INVALID_FORMAT</b>. (See Windows Web Services Return Values.) If the encoding supports empty elements, and no
///content was written between the start element and end element, an empty element will be written.
///Params:
///    writer = A pointer to the WS_XML_WRITER object to which the end element is written. The pointer must reference a valid
///             <b>XML Writer</b> object.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
@DllImport("webservices")
HRESULT WsWriteEndElement(WS_XML_WRITER* writer, WS_ERROR* error);

///Writes the specified text to the XML writer. To write characters to an attribute value call WsWriteStartAttribute.
///Only whitespace characters may be written at the root of an xml document unless the
///<b>WS_XML_WRITER_PROPERTY_ALLOW_FRAGMENT</b> has been set to <b>TRUE</b>.
///Params:
///    writer = A pointer to the WS_XML_WRITER object to which the text is written. The pointer must reference a valid <b>XML
///             Writer</b> object.
///    text = A pointer to the text to write. <div class="alert"><b>Note</b> See WS_XML_TEXT and its derived classes for more
///           information on the text object. </div> <div> </div>
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_OPERATION</b></dt> </dl> </td> <td
///    width="60%"> The operation is not allowed due to the current state of the object. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsWriteText(WS_XML_WRITER* writer, const(WS_XML_TEXT)* text, WS_ERROR* error);

///This operation starts a CDATA section in the writer. CDATA sections cannot be nested and cannot appear at the root of
///the document. <div class="alert"><b>Note</b> Some encodings do not support CDATA and will generate text instead.
///</div> <div> </div>The CDATA section is completed by calling WsWriteEndCData.
///Params:
///    writer = A pointer to the WS_XML_WRITER object to which the CDATA section is written. The pointer must reference a valid
///             <b>XML Writer</b> object.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
@DllImport("webservices")
HRESULT WsWriteStartCData(WS_XML_WRITER* writer, WS_ERROR* error);

///Ends a CDATA section in the writer. If <b>WsWriteEndCData</b> is called without a prior call to WsWriteStartCData,
///this function returns <b>WS_E_INVALID_OPERATION</b>. (See Windows Web Services Return Values.)
///Params:
///    writer = A pointer to the WS_XML_WRITER object to which the end CDATA section is written. The pointer must reference a
///             valid <b>XML Writer</b> object.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
@DllImport("webservices")
HRESULT WsWriteEndCData(WS_XML_WRITER* writer, WS_ERROR* error);

///Writes the specified node to the XML Writer.
///Params:
///    writer = A pointer to the WS_XML_WRITER object to which the node is written. The pointer must reference a valid <b>XML
///             Writer</b> object.
///    node = A pointer to the Node object to write to the document.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
@DllImport("webservices")
HRESULT WsWriteNode(WS_XML_WRITER* writer, const(WS_XML_NODE)* node, WS_ERROR* error);

///This function returns the prefix to which a namespace is bound. There may be more than one prefix in scope and this
///function is free to return any one of them. <div class="alert"><b>Note</b> Under no conditions should a caller depend
///upon or expect a particular prefix to be returned when there is more than one prefix that may be returned. </div>
///<div> </div> If the value of the <i>required</i> parameter is set to <b>TRUE</b> and the Namespace is not bound to
///any Prefix a <b>WS_E_INVALID_FORMAT</b> exception will be returned. (See Windows Web Services Return Values.) If the
///<i>required</i> parameter is <b>FALSE</b>, and the Namespace is not bound to any Prefix the <i>prefix</i> parameter
///is <b>NULL</b> and the function returns S_FALSE. If WsWriteStartElement is called but the element is not committed
///the Namespaces and Prefixes referenced by the element and any attributes on the element is not available to this
///function.
///Params:
///    writer = A pointer to a Writer with the namespace to search. This must be a valid <b>WS_XML_WRITER</b> object returned by
///             WsCreateWriter and may not be <b>NULL</b>.
///    ns = The namespace to search for.
///    required = Indicates whether or not an error should be returned if a matching prefix is not found.
///    prefix = A reference to a prefix bound to the namespace or <b>NULL</b> if the value of the <i>required</i> parameter is
///             <b>FALSE</b> and a matching namespace is not found. <div class="alert"><b>Note</b> The value returned is valid
///             only until the writer advances.</div> <div> </div>
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl> </td> <td width="60%"> The input data was not in
///    the expected format or did not have the expected value. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsGetPrefixFromNamespace(WS_XML_WRITER* writer, const(WS_XML_STRING)* ns, BOOL required, 
                                 const(WS_XML_STRING)** prefix, WS_ERROR* error);

///Returns the current position of the writer. This can only be used on a writer that is set to an XmlBuffer. When
///writing to a buffer, the position represents the xml node before which new data will be placed.
///Params:
///    writer = The writer for which the current position will be obtained.
///    nodePosition = The current position of the writer is returned here.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are
///    invalid. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsGetWriterPosition(WS_XML_WRITER* writer, WS_XML_NODE_POSITION* nodePosition, WS_ERROR* error);

///Sets the current position of the writer. The position must have been obtained by a call to WsGetReaderPosition or
///WsGetWriterPosition.
///Params:
///    writer = The writer for which the current position will be set.
///    nodePosition = The position to set the writer to.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_OPERATION</b></dt> </dl> </td> <td
///    width="60%"> The operation is not allowed due to the current state of the object. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsSetWriterPosition(WS_XML_WRITER* writer, const(WS_XML_NODE_POSITION)* nodePosition, WS_ERROR* error);

///Moves the current position of the writer as specified by the moveTo parameter.
///Params:
///    writer = The writer to move.
///    moveTo = The relative position to move the writer.
///    found = If this is non-<b>NULL</b>, then whether or not the new position could be moved to is returned here. If this is
///            <b>NULL</b>, and the position could not be moved to, then the function will return <b>WS_E_INVALID_FORMAT</b>.
///            (See Windows Web Services Return Values.)
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_OPERATION</b></dt> </dl> </td> <td
///    width="60%"> The operation is not allowed due to the current state of the object. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl> </td> <td width="60%"> The input data was not in the
///    expected format or did not have the expected value. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsMoveWriter(WS_XML_WRITER* writer, WS_MOVE_TO moveTo, BOOL* found, WS_ERROR* error);

///Removes leading and trailing whitespace from a sequence of characters.
///Params:
///    chars = The string to be trimmed.
///    charCount = The length of the string to be trimmed.
///    trimmedChars = Returns a pointer into the original string starting at the first non-whitespace character.
///    trimmedCount = Returns the length of the trimmed string.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("webservices")
HRESULT WsTrimXmlWhitespace(PWSTR chars, uint charCount, ushort** trimmedChars, uint* trimmedCount, 
                            WS_ERROR* error);

///Verifies whether the input string is a valid XML NCName.
///Params:
///    ncNameChars = The string to be verified.
///    ncNameCharCount = The length of the <i>ncNameChars</i> string.
///    error = Specifies where additional error information should be stored if the function fails.
@DllImport("webservices")
HRESULT WsVerifyXmlNCName(const(PWSTR) ncNameChars, uint ncNameCharCount, WS_ERROR* error);

///Compares two WS_XML_STRING objects for equality. The operation performs an ordinal comparison of the character values
///contained by the String objects.
///Params:
///    string1 = A pointer to the first string to compare.
///    string2 = A pointer to the second string to compare.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The strings are equal. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The strings are not equal. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more parameters are
///    not correct. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsXmlStringEquals(const(WS_XML_STRING)* string1, const(WS_XML_STRING)* string2, WS_ERROR* error);

///This function returns a namespace from the prefix to which it is bound. If the value of the <i>required</i> parameter
///is set to <b>TRUE</b> and the Prefix is not bound to any namespace a <b>WS_E_INVALID_FORMAT</b> exception will be
///returned. (See Windows Web Services Return Values.) If the <i>required</i> parameter is <b>FALSE</b>, and the Prefix
///is not bound to any namespace the <i>ns</i> parameter will be <b>NULL</b> and the function will return S_FALSE.
///Params:
///    reader = A pointer to the reader for which the prefix should be searched.
///    prefix = A pointer to the Prefix to search for.
///    required = The value of this Boolean parameter determines whether or not an error should be returned if a matching namespace
///               is not found.
///    ns = A reference to a namespace to which the prefix is bound if successful. The value returned is valid only until the
///         writer advances.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl> </td> <td width="60%"> The input data was not in
///    the expected format or did not have the expected value. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsGetNamespaceFromPrefix(WS_XML_READER* reader, const(WS_XML_STRING)* prefix, BOOL required, 
                                 const(WS_XML_STRING)** ns, WS_ERROR* error);

///Reads a qualified name and separates it into its prefix, localName and namespace based on the current namespace scope
///of the XML_READER. If the ns parameter is specified, then the namespace that the prefix is bound to will be returned,
///or <b>WS_E_INVALID_FORMAT</b>will be returned. (See Windows Web Services Return Values.) The strings are placed in
///the specified heap.
///Params:
///    reader = The reader which should read the qualified name.
///    heap = The heap on which the resulting strings should be allocated.
///    prefix = The prefix of the qualified name is returned here.
///    localName = The localName of the qualified name is returned here.
///    ns = The namespace to which the qualified name is bound is returned here.
///    error = If the localName is missing the function will return <b>WS_E_INVALID_FORMAT</b>. If the ns parameter is
///            specified, but the prefix is not bound to a namespace, <b>WS_E_INVALID_FORMAT</b> will be returned.
@DllImport("webservices")
HRESULT WsReadQualifiedName(WS_XML_READER* reader, WS_HEAP* heap, WS_XML_STRING* prefix, WS_XML_STRING* localName, 
                            WS_XML_STRING* ns, WS_ERROR* error);

///Finds the nearest xml attribute in scope with the specified localName and returns its value. The returned value is
///placed on the specified heap.
///Params:
///    reader = The reader for which the xml attribute will be searched.
///    localName = The localName of the xml attribute for which to search.
///    heap = The heap on which the resulting value should be allocated.
///    valueChars = The value of the attribute is stored here.
///    valueCharCount = The length of the valueChars.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The xml
///    attribute was not found. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsGetXmlAttribute(WS_XML_READER* reader, const(WS_XML_STRING)* localName, WS_HEAP* heap, 
                          ushort** valueChars, uint* valueCharCount, WS_ERROR* error);

///Copies the current node from the specified XML reader to the specified XML writer.
///Params:
///    writer = Pointer to the WS_XML_WRITER to which to copy the XML node.
///    reader = Pointer to the WS_XML_READER from which to copy the XML node.
///    error = Pointer to a WS_ERROR structure that receives additional error information if the function fails.
///Returns:
///    If the function succeeds, it returns NO_ERROR; otherwise, it returns an HRESULT error code. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_OPERATION</b></dt>
///    </dl> </td> <td width="60%"> The operation is not allowed due to the current state of the object. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl> </td> <td width="60%"> The input data was
///    not in the expected format or did not have the expected value. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_QUOTA_EXCEEDED</b></dt> </dl> </td> <td width="60%"> A quota was exceeded. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsCopyNode(WS_XML_WRITER* writer, WS_XML_READER* reader, WS_ERROR* error);

///Helper function for implementing an asynchronous operation.
///Params:
///    asyncState = A pointer to the WS_ASYNC_STATE structure used during the asynchronous operation. This is a state maintenance
///                 parameter not intended for direct use. The application must allocate the <b>WS_ASYNC_STATE</b> structure and
///                 ensure that it is kept alive during the entire asynchronous operation. The <b>WS_ASYNC_STATE</b> structure can be
///                 reused after an asynchronous operation has completed.
///    operation = Represents the initial asynchronous operation to be performed.
///    callbackModel = Indicates whether the callback is being invoked long or short. For more information, see WS_CALLBACK_MODEL
///    callbackState = A void pointer to a user-defined value that is passed to each WS_ASYNC_FUNCTION.
///    asyncContext = Pointer to information for invoking the function asynchronously. Pass <b>NULL</b> to invoke the function
///                   synchronously.
///    error = Pointer to a WS_ERROR structure that receives additional error information if the function fails.
///Returns:
///    If the function succeeds, it returns NO_ERROR; otherwise, it returns an HRESULT error code.
///    
@DllImport("webservices")
HRESULT WsAsyncExecute(WS_ASYNC_STATE* asyncState, WS_ASYNC_FUNCTION operation, WS_CALLBACK_MODEL callbackModel, 
                       void* callbackState, const(WS_ASYNC_CONTEXT)* asyncContext, WS_ERROR* error);

///Creates a channel for message exchange with an endpoint.
///Params:
///    channelType = The type of the channel. For channel types, see the WS_CHANNEL_TYPE enumeration. This represents the message
///                  exchange pattern for the channel being created.
///    channelBinding = The channel binding, indicating the protocol stack to use for the new channel. For available channel bindings,
///                     see the WS_CHANNEL_BINDING enumeration.
///    properties = An array of WS_CHANNEL_PROPERTY structures containing optional values for channel initialization. The value of
///                 this parameter may be <b>NULL</b>, in which case, the <i>propertyCount</i> parameter must be 0 (zero). For
///                 information on which channel properties can be specified when you create a channel, see the
///                 WS_CHANNEL_PROPERTY_ID enumeration. For information on creating a custom channel, see the Remarks section.
///    propertyCount = The number of properties in the <i>properties</i> array.
///    securityDescription = Pointer to a WS_SECURITY_DESCRIPTION structure specifying the security for the channel. If you are creating a
///                          custom channel (using the WS_CUSTOM_CHANNEL_BINDING value of the WS_CHANNEL_BINDING enumeration), the security
///                          description must be <b>NULL</b>. See the Remarks section.
///    channel = Pointer that receives the address of the created channel. When the channel is no longer needed, you must free it
///              by calling WsFreeChannel.
///    error = Pointer to a WS_ERROR structure that receives additional error information if the function fails.
///Returns:
///    If the function succeeds, it returns NO_ERROR; otherwise, it returns an HRESULT error code. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
///    </td> <td width="60%"> One or more arguments are invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory to complete the operation. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b> Other Errors </b></dt> </dl> </td> <td width="60%"> This function may
///    return other errors not listed above. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsCreateChannel(WS_CHANNEL_TYPE channelType, WS_CHANNEL_BINDING channelBinding, 
                        const(WS_CHANNEL_PROPERTY)* properties, uint propertyCount, 
                        const(WS_SECURITY_DESCRIPTION)* securityDescription, WS_CHANNEL** channel, WS_ERROR* error);

///Open a channel to an endpoint.
///Params:
///    channel = The channel to open.
///    endpointAddress = The address of the endpoint.
///    asyncContext = Information on how to invoke the function asynchronously, or <b>NULL</b> if invoking synchronously.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>WS_S_ASYNC</b></dt> </dl> </td> <td width="60%"> The asynchronous operation is still
///    pending. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_OPERATION_ABORTED</b></dt> </dl> </td> <td
///    width="60%"> The operation was aborted. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_INVALID_OPERATION</b></dt> </dl> </td> <td width="60%"> The operation is not allowed due to the
///    current state of the object. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_ENDPOINT_NOT_FOUND</b></dt> </dl>
///    </td> <td width="60%"> The remote endpoint does not exist or could not be located. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>WS_E_ENDPOINT_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access was denied by
///    the remote endpoint. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_ENDPOINT_DISCONNECTED</b></dt> </dl>
///    </td> <td width="60%"> The connection with the remote endpoint was terminated. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>WS_E_ENDPOINT_FAILURE</b></dt> </dl> </td> <td width="60%"> The remote endpoint could not process the
///    request. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_ENDPOINT_NOT_AVAILABLE</b></dt> </dl> </td> <td
///    width="60%"> The remote endpoint is not currently in service at this location. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>WS_E_ENDPOINT_TOO_BUSY</b></dt> </dl> </td> <td width="60%"> The remote endpoint is unable to process
///    the request due to being overloaded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_ENDPOINT_UNREACHABLE</b></dt> </dl> </td> <td width="60%"> The remote endpoint was not reachable.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_ENDPOINT_URL</b></dt> </dl> </td> <td width="60%"> The
///    endpoint address URL is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl>
///    </td> <td width="60%"> The input data was not in the expected format or did not have the expected value. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_OPERATION_TIMED_OUT</b></dt> </dl> </td> <td width="60%"> The
///    operation did not complete within the time allotted. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_PROXY_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access was denied by the HTTP proxy server.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_PROXY_FAILURE</b></dt> </dl> </td> <td width="60%"> The HTTP
///    proxy server could not process the request. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_QUOTA_EXCEEDED</b></dt> </dl> </td> <td width="60%"> A quota was exceeded. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>WS_E_SECURITY_VERIFICATION_FAILURE</b></dt> </dl> </td> <td width="60%"> Security
///    verification was not successful for the received data. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SECURITY_SYSTEM_FAILURE</b></dt> </dl> </td> <td width="60%"> A security operation failed in the
///    Windows Web Services framework. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_PROXY_REQUIRES_BASIC_AUTH</b></dt> </dl> </td> <td width="60%"> The HTTP proxy server requires HTTP
///    authentication scheme 'basic'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_PROXY_REQUIRES_DIGEST_AUTH</b></dt> </dl> </td> <td width="60%"> The HTTP proxy server requires HTTP
///    authentication scheme 'digest'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_PROXY_REQUIRES_NEGOTIATE_AUTH</b></dt> </dl> </td> <td width="60%"> The HTTP proxy server requires
///    HTTP authentication scheme 'negotiate'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_PROXY_REQUIRES_NTLM_AUTH</b></dt> </dl> </td> <td width="60%"> The HTTP proxy server requires HTTP
///    authentication scheme 'NTLM'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SERVER_REQUIRES_BASIC_AUTH</b></dt> </dl> </td> <td width="60%"> The remote endpoint requires HTTP
///    authentication scheme 'basic'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SERVER_REQUIRES_DIGEST_AUTH</b></dt> </dl> </td> <td width="60%"> The remote endpoint requires HTTP
///    authentication scheme 'digest'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SERVER_REQUIRES_NEGOTIATE_AUTH</b></dt> </dl> </td> <td width="60%"> The remote endpoint requires
///    HTTP authentication scheme 'negotiate'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SERVER_REQUIRES_NTLM_AUTH</b></dt> </dl> </td> <td width="60%"> The remote endpoint requires HTTP
///    authentication scheme 'NTLM'. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td>
///    <td width="60%"> Ran out of memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
///    </td> <td width="60%"> One or more arguments are invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b> Other
///    Errors </b></dt> </dl> </td> <td width="60%"> This function may return other errors not listed above. </td> </tr>
///    </table>
///    
@DllImport("webservices")
HRESULT WsOpenChannel(WS_CHANNEL* channel, const(WS_ENDPOINT_ADDRESS)* endpointAddress, 
                      const(WS_ASYNC_CONTEXT)* asyncContext, WS_ERROR* error);

///Send a message on a channel using serialization to write the body element.
///Params:
///    channel = The channel to send the message on.
///    message = The message object to use for sending. The message object must be in WS_MESSAGE_STATE_EMPTY or
///              <b>WS_MESSAGE_STATE_INITIALIZED</b>.
///    messageDescription = The action field of the WS_MESSAGE_DESCRIPTION is used as the action header for the message. This field may be
///                         <b>NULL</b> if no action is required. The bodyElementDescription field of the WS_MESSAGE_DESCRIPTIONis used to
///                         serialize the body of the message. This field may be <b>NULL</b> if no body element is desired. See WsWriteBody
///                         for information about how the bodyElementDescription is used to serialize the value.
///    writeOption = Whether the body element is required, and how the value is allocated. This is used only when a body element is
///                  desired. For more information, see WS_WRITE_OPTION and WsWriteBody.
///    bodyValue = The value to serialize in the body of the message.
///    bodyValueSize = The size of the value being serialized, in bytes.
///    asyncContext = Information on how to invoke the function asynchronously, or <b>NULL</b> if invoking synchronously.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>WS_S_ASYNC</b></dt> </dl> </td> <td width="60%"> The asynchronous operation is still
///    pending. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_OPERATION_ABORTED</b></dt> </dl> </td> <td
///    width="60%"> The operation was aborted. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_INVALID_OPERATION</b></dt> </dl> </td> <td width="60%"> The operation is not allowed due to the
///    current state of the object. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_ENDPOINT_NOT_FOUND</b></dt> </dl>
///    </td> <td width="60%"> The remote endpoint does not exist or could not be located. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>WS_E_ENDPOINT_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access was denied by
///    the remote endpoint. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_ENDPOINT_DISCONNECTED</b></dt> </dl>
///    </td> <td width="60%"> The connection with the remote endpoint was terminated. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>WS_E_ENDPOINT_FAILURE</b></dt> </dl> </td> <td width="60%"> The remote endpoint could not process the
///    request. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_ENDPOINT_NOT_AVAILABLE</b></dt> </dl> </td> <td
///    width="60%"> The remote endpoint is not currently in service at this location. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>WS_E_ENDPOINT_TOO_BUSY</b></dt> </dl> </td> <td width="60%"> The remote endpoint is unable to process
///    the request due to being overloaded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_ENDPOINT_UNREACHABLE</b></dt> </dl> </td> <td width="60%"> The remote endpoint was not reachable.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_ENDPOINT_URL</b></dt> </dl> </td> <td width="60%"> The
///    endpoint address URL is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl>
///    </td> <td width="60%"> The input data was not in the expected format or did not have the expected value. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_OPERATION_TIMED_OUT</b></dt> </dl> </td> <td width="60%"> The
///    operation did not complete within the time allotted. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_PROXY_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access was denied by the HTTP proxy server.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_PROXY_FAILURE</b></dt> </dl> </td> <td width="60%"> The HTTP
///    proxy server could not process the request. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_QUOTA_EXCEEDED</b></dt> </dl> </td> <td width="60%"> A quota was exceeded. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>WS_E_SECURITY_VERIFICATION_FAILURE</b></dt> </dl> </td> <td width="60%"> Security
///    verification was not successful for the received data. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SECURITY_SYSTEM_FAILURE</b></dt> </dl> </td> <td width="60%"> A security operation failed in the
///    Windows Web Services framework. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SECURITY_TOKEN_EXPIRED</b></dt> </dl> </td> <td width="60%"> A security token was rejected by the
///    server because it has expired. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_PROXY_REQUIRES_BASIC_AUTH</b></dt> </dl> </td> <td width="60%"> The HTTP proxy server requires HTTP
///    authentication scheme 'basic'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_PROXY_REQUIRES_DIGEST_AUTH</b></dt> </dl> </td> <td width="60%"> The HTTP proxy server requires HTTP
///    authentication scheme 'digest'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_PROXY_REQUIRES_NEGOTIATE_AUTH</b></dt> </dl> </td> <td width="60%"> The HTTP proxy server requires
///    HTTP authentication scheme 'negotiate'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_PROXY_REQUIRES_NTLM_AUTH</b></dt> </dl> </td> <td width="60%"> The HTTP proxy server requires HTTP
///    authentication scheme 'NTLM'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SERVER_REQUIRES_BASIC_AUTH</b></dt> </dl> </td> <td width="60%"> The remote endpoint requires HTTP
///    authentication scheme 'basic'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SERVER_REQUIRES_DIGEST_AUTH</b></dt> </dl> </td> <td width="60%"> The remote endpoint requires HTTP
///    authentication scheme 'digest'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SERVER_REQUIRES_NEGOTIATE_AUTH</b></dt> </dl> </td> <td width="60%"> The remote endpoint requires
///    HTTP authentication scheme 'negotiate'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SERVER_REQUIRES_NTLM_AUTH</b></dt> </dl> </td> <td width="60%"> The remote endpoint requires HTTP
///    authentication scheme 'NTLM'. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>CERT_E_EXPIRED</b></dt> </dl> </td>
///    <td width="60%"> A required certificate is not within its validity period when verifying against the current
///    system clock or the timestamp in the signed file. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>CERT_E_CN_NO_MATCH</b></dt> </dl> </td> <td width="60%"> The certificates CN name does not match the
///    passed value. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>CERT_E_UNTRUSTEDROOT</b></dt> </dl> </td> <td
///    width="60%"> A certificate chain processed, but terminated in a root certificate which is not trusted by the
///    trust provider. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>CERT_E_WRONG_USAGE</b></dt> </dl> </td> <td
///    width="60%"> The certificate is not valid for the requested usage. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>CRYPT_E_REVOCATION_OFFLINE</b></dt> </dl> </td> <td width="60%"> The revocation function was unable to
///    check revocation because the revocation server was offline. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Ran out of memory. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b> Other Errors </b></dt> </dl> </td> <td width="60%"> This function may return
///    other errors not listed above. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsSendMessage(WS_CHANNEL* channel, WS_MESSAGE* message, const(WS_MESSAGE_DESCRIPTION)* messageDescription, 
                      WS_WRITE_OPTION writeOption, const(void)* bodyValue, uint bodyValueSize, 
                      const(WS_ASYNC_CONTEXT)* asyncContext, WS_ERROR* error);

///Receive a message and deserialize the body of the message as a value.
///Params:
///    channel = The channel to receive from.
///    message = The message object used to receive. The message should be in WS_MESSAGE_STATE_EMPTY state.
///    messageDescriptions = An array of pointers to message descriptions that specifies the metadata for the expected types of messages.
///    messageDescriptionCount = The number of items in the messageDescriptions array.
///    receiveOption = Whether the message is required. See WS_RECEIVE_OPTION for more information.
///    readBodyOption = Whether the body element is required, and how to allocate the value. See WS_READ_OPTION for more information.
///    heap = The heap to store the deserialized values in. If the heap is not required for the given type, then this parameter
///           can be <b>NULL</b>.
///    value = The interpretation of this parameter depends on the WS_READ_OPTION. If WS_RECEIVE_OPTIONAL_MESSAGE is specified
///            for the receiveOption parameter, and no more messages are available on the channel, this parameter is not
///            touched. In this case, the function returns <b>WS_S_END</b>. (See Windows Web Services Return Values.) If the
///            bodyElementDescription of the WS_MESSAGE_DESCRIPTION that matched is <b>NULL</b>, then this parameter is not
///            touched. In this case, the parameter does not need to be specified.
///    valueSize = The interpretation of this parameter depends on the WS_READ_OPTION.
///    index = If WS_RECEIVE_OPTIONAL_MESSAGE is specified for the receiveOption parameter, and no more messages are available
///            on the channel, this parameter is untouched. In this case, the function will return <b>WS_S_END</b>. Otherwise,
///            if the function succeeds this will contain the zero-based index into the array of message descriptions indicating
///            which one matched. This parameter may be <b>NULL</b> if the caller is not interested in the value (for example,
///            if there is only one message description).
///    asyncContext = Information on how to invoke the function asynchronously, or <b>NULL</b> if invoking synchronously.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>WS_S_ASYNC</b></dt> </dl> </td> <td width="60%"> The asynchronous operation is still
///    pending. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_S_END</b></dt> </dl> </td> <td width="60%"> The receive
///    option WS_RECEIVE_OPTIONAL_MESSAGE was specified and there are no more messages available for the channel. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_ENDPOINT_FAULT_RECEIVED</b></dt> </dl> </td> <td width="60%"> The
///    received message contained a fault. The fault can be extracted from the WS_ERROR using WsGetErrorProperty. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_OPERATION_ABORTED</b></dt> </dl> </td> <td width="60%"> The
///    operation was aborted. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_OPERATION</b></dt> </dl> </td>
///    <td width="60%"> The operation is not allowed due to the current state of the object. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>WS_E_ENDPOINT_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The remote endpoint does
///    not exist or could not be located. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_ENDPOINT_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access was denied by the remote
///    endpoint. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_ENDPOINT_DISCONNECTED</b></dt> </dl> </td> <td
///    width="60%"> The connection with the remote endpoint was terminated. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_ENDPOINT_FAILURE</b></dt> </dl> </td> <td width="60%"> The remote endpoint could not process the
///    request. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_ENDPOINT_NOT_AVAILABLE</b></dt> </dl> </td> <td
///    width="60%"> The remote endpoint is not currently in service at this location. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>WS_E_ENDPOINT_TOO_BUSY</b></dt> </dl> </td> <td width="60%"> The remote endpoint is unable to process
///    the request due to being overloaded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_ENDPOINT_UNREACHABLE</b></dt> </dl> </td> <td width="60%"> The remote endpoint was not reachable.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_ENDPOINT_URL</b></dt> </dl> </td> <td width="60%"> The
///    endpoint address URL is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl>
///    </td> <td width="60%"> The input data was not in the expected format or did not have the expected value. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_OPERATION_TIMED_OUT</b></dt> </dl> </td> <td width="60%"> The
///    operation did not complete within the time allotted. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_PROXY_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access was denied by the HTTP proxy server.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_PROXY_FAILURE</b></dt> </dl> </td> <td width="60%"> The HTTP
///    proxy server could not process the request. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_QUOTA_EXCEEDED</b></dt> </dl> </td> <td width="60%"> A quota was exceeded. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>WS_E_SECURITY_VERIFICATION_FAILURE</b></dt> </dl> </td> <td width="60%"> Security
///    verification was not successful for the received data. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SECURITY_SYSTEM_FAILURE</b></dt> </dl> </td> <td width="60%"> A security operation failed in the
///    Windows Web Services framework. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SECURITY_TOKEN_EXPIRED</b></dt> </dl> </td> <td width="60%"> A security token was rejected by the
///    server because it has expired. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_PROXY_REQUIRES_BASIC_AUTH</b></dt> </dl> </td> <td width="60%"> The HTTP proxy server requires HTTP
///    authentication scheme 'basic'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_PROXY_REQUIRES_DIGEST_AUTH</b></dt> </dl> </td> <td width="60%"> The HTTP proxy server requires HTTP
///    authentication scheme 'digest'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_PROXY_REQUIRES_NEGOTIATE_AUTH</b></dt> </dl> </td> <td width="60%"> The HTTP proxy server requires
///    HTTP authentication scheme 'negotiate'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_PROXY_REQUIRES_NTLM_AUTH</b></dt> </dl> </td> <td width="60%"> The HTTP proxy server requires HTTP
///    authentication scheme 'NTLM'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SERVER_REQUIRES_BASIC_AUTH</b></dt> </dl> </td> <td width="60%"> The remote endpoint requires HTTP
///    authentication scheme 'basic'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SERVER_REQUIRES_DIGEST_AUTH</b></dt> </dl> </td> <td width="60%"> The remote endpoint requires HTTP
///    authentication scheme 'digest'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SERVER_REQUIRES_NEGOTIATE_AUTH</b></dt> </dl> </td> <td width="60%"> The remote endpoint requires
///    HTTP authentication scheme 'negotiate'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SERVER_REQUIRES_NTLM_AUTH</b></dt> </dl> </td> <td width="60%"> The remote endpoint requires HTTP
///    authentication scheme 'NTLM'. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>CERT_E_EXPIRED</b></dt> </dl> </td>
///    <td width="60%"> A required certificate is not within its validity period when verifying against the current
///    system clock or the timestamp in the signed file. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>CERT_E_CN_NO_MATCH</b></dt> </dl> </td> <td width="60%"> The certificates CN name does not match the
///    passed value. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>CERT_E_UNTRUSTEDROOT</b></dt> </dl> </td> <td
///    width="60%"> A certificate chain processed, but terminated in a root certificate which is not trusted by the
///    trust provider. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>CERT_E_WRONG_USAGE</b></dt> </dl> </td> <td
///    width="60%"> The certificate is not valid for the requested usage. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>CRYPT_E_REVOCATION_OFFLINE</b></dt> </dl> </td> <td width="60%"> The revocation function was unable to
///    check revocation because the revocation server was offline. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Ran out of memory. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b> Other Errors </b></dt> </dl> </td> <td width="60%"> This function may return
///    other errors not listed above. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsReceiveMessage(WS_CHANNEL* channel, WS_MESSAGE* message, 
                         const(WS_MESSAGE_DESCRIPTION)** messageDescriptions, uint messageDescriptionCount, 
                         WS_RECEIVE_OPTION receiveOption, WS_READ_OPTION readBodyOption, WS_HEAP* heap, void* value, 
                         uint valueSize, uint* index, const(WS_ASYNC_CONTEXT)* asyncContext, WS_ERROR* error);

///Used to send a request message and receive a correlated reply message.
///Params:
///    channel = The channel to do the request-reply operation on.
///    requestMessage = The message object to use to send the request. The message object should be in WS_MESSAGE_STATE_EMPTY or
///                     <b>WS_MESSAGE_STATE_INITIALIZED</b>.
///    requestMessageDescription = The action field of the WS_MESSAGE_DESCRIPTION is used as the action header for the request message. This field
///                                may be <b>NULL</b> if no action is required. The bodyElementDescription field of the WS_MESSAGE_DESCRIPTIONis
///                                used to serialize the body of the request message. This field may be <b>NULL</b> if no body element is desired.
///                                See WsWriteBody for information about how the body is serialized according to the bodyElementDescription.
///    writeOption = Whether the body element is required, and how the value is allocated. See WS_WRITE_OPTION for more information.
///    requestBodyValue = A pointer to the value to serialize in the body of the request object.
///    requestBodyValueSize = The size of the request value being serialized, in bytes.
///    replyMessage = The message object to use to receive the reply. The message object should be in WS_MESSAGE_STATE_EMPTY.
///    replyMessageDescription = The action field of the WS_MESSAGE_DESCRIPTION is used to verify the action header of the received reply message.
///                              This field may be <b>NULL</b> if no action is required. If <b>NULL</b>, the action header of the received message
///                              is ignored if present. The bodyElementDescription field of the WS_MESSAGE_DESCRIPTIONis used to deserialize the
///                              body of the reply message. This field may be <b>NULL</b> if no body element is desired. See WsReadBody for
///                              information about how the body is deserialized according to the bodyElementDescription.
///    readOption = Whether the reply body element is required, and how to allocate the value. For more information, see
///                 WS_READ_OPTION and WsReadBody.
///    heap = The heap used to allocate deserialized reply body values. If the heap is not necessary for the given type, then
///           this parameter can be <b>NULL</b>.
///    value = Where to store the deserialized values of the body. The interpretation of this parameter depends on the
///            WS_READ_OPTION. If the bodyElementDescription of the reply WS_MESSAGE_DESCRIPTION is <b>NULL</b>, then this
///            parameter is not touched. In this case, the parameter does not need to be specified.
///    valueSize = The interpretation of this parameter depends on the WS_READ_OPTION.
///    asyncContext = Information on how to invoke the function asynchronously, or <b>NULL</b> if invoking synchronously.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>WS_E_ENDPOINT_FAULT_RECEIVED</b></dt> </dl> </td> <td width="60%"> The reply message
///    contained a fault. The fault can be extracted from the WS_ERROR using WsGetErrorProperty. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>WS_S_ASYNC</b></dt> </dl> </td> <td width="60%"> The asynchronous operation is still
///    pending. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_OPERATION_ABORTED</b></dt> </dl> </td> <td
///    width="60%"> The operation was aborted. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_INVALID_OPERATION</b></dt> </dl> </td> <td width="60%"> The operation is not allowed due to the
///    current state of the object. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_ENDPOINT_NOT_FOUND</b></dt> </dl>
///    </td> <td width="60%"> The remote endpoint does not exist or could not be located. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>WS_E_ENDPOINT_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access was denied by
///    the remote endpoint. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_ENDPOINT_DISCONNECTED</b></dt> </dl>
///    </td> <td width="60%"> The connection with the remote endpoint was terminated. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>WS_E_ENDPOINT_FAILURE</b></dt> </dl> </td> <td width="60%"> The remote endpoint could not process the
///    request. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_ENDPOINT_NOT_AVAILABLE</b></dt> </dl> </td> <td
///    width="60%"> The remote endpoint is not currently in service at this location. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>WS_E_ENDPOINT_TOO_BUSY</b></dt> </dl> </td> <td width="60%"> The remote endpoint is unable to process
///    the request due to being overloaded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_ENDPOINT_UNREACHABLE</b></dt> </dl> </td> <td width="60%"> The remote endpoint was not reachable.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_ENDPOINT_URL</b></dt> </dl> </td> <td width="60%"> The
///    endpoint address URL is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl>
///    </td> <td width="60%"> The input data was not in the expected format or did not have the expected value. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_OPERATION_TIMED_OUT</b></dt> </dl> </td> <td width="60%"> The
///    operation did not complete within the time allotted. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_PROXY_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access was denied by the HTTP proxy server.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_PROXY_FAILURE</b></dt> </dl> </td> <td width="60%"> The HTTP
///    proxy server could not process the request. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_QUOTA_EXCEEDED</b></dt> </dl> </td> <td width="60%"> A quota was exceeded. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>WS_E_SECURITY_VERIFICATION_FAILURE</b></dt> </dl> </td> <td width="60%"> Security
///    verification was not successful for the received data. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SECURITY_SYSTEM_FAILURE</b></dt> </dl> </td> <td width="60%"> A security operation failed in the
///    Windows Web Services framework. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SECURITY_TOKEN_EXPIRED</b></dt> </dl> </td> <td width="60%"> A security token was rejected by the
///    server because it has expired. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_PROXY_REQUIRES_BASIC_AUTH</b></dt> </dl> </td> <td width="60%"> The HTTP proxy server requires HTTP
///    authentication scheme 'basic'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_PROXY_REQUIRES_DIGEST_AUTH</b></dt> </dl> </td> <td width="60%"> The HTTP proxy server requires HTTP
///    authentication scheme 'digest'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_PROXY_REQUIRES_NEGOTIATE_AUTH</b></dt> </dl> </td> <td width="60%"> The HTTP proxy server requires
///    HTTP authentication scheme 'negotiate'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_PROXY_REQUIRES_NTLM_AUTH</b></dt> </dl> </td> <td width="60%"> The HTTP proxy server requires HTTP
///    authentication scheme 'NTLM'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SERVER_REQUIRES_BASIC_AUTH</b></dt> </dl> </td> <td width="60%"> The remote endpoint requires HTTP
///    authentication scheme 'basic'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SERVER_REQUIRES_DIGEST_AUTH</b></dt> </dl> </td> <td width="60%"> The remote endpoint requires HTTP
///    authentication scheme 'digest'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SERVER_REQUIRES_NEGOTIATE_AUTH</b></dt> </dl> </td> <td width="60%"> The remote endpoint requires
///    HTTP authentication scheme 'negotiate'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SERVER_REQUIRES_NTLM_AUTH</b></dt> </dl> </td> <td width="60%"> The remote endpoint requires HTTP
///    authentication scheme 'NTLM'. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>CERT_E_EXPIRED</b></dt> </dl> </td>
///    <td width="60%"> A required certificate is not within its validity period when verifying against the current
///    system clock or the timestamp in the signed file. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>CERT_E_CN_NO_MATCH</b></dt> </dl> </td> <td width="60%"> The certificates CN name does not match the
///    passed value. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>CERT_E_UNTRUSTEDROOT</b></dt> </dl> </td> <td
///    width="60%"> A certificate chain processed, but terminated in a root certificate which is not trusted by the
///    trust provider. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>CERT_E_WRONG_USAGE</b></dt> </dl> </td> <td
///    width="60%"> The certificate is not valid for the requested usage. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>CRYPT_E_REVOCATION_OFFLINE</b></dt> </dl> </td> <td width="60%"> The revocation function was unable to
///    check revocation because the revocation server was offline. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Ran out of memory. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b> Other Errors </b></dt> </dl> </td> <td width="60%"> This function may return
///    other errors not listed above. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsRequestReply(WS_CHANNEL* channel, WS_MESSAGE* requestMessage, 
                       const(WS_MESSAGE_DESCRIPTION)* requestMessageDescription, WS_WRITE_OPTION writeOption, 
                       const(void)* requestBodyValue, uint requestBodyValueSize, WS_MESSAGE* replyMessage, 
                       const(WS_MESSAGE_DESCRIPTION)* replyMessageDescription, WS_READ_OPTION readOption, 
                       WS_HEAP* heap, void* value, uint valueSize, const(WS_ASYNC_CONTEXT)* asyncContext, 
                       WS_ERROR* error);

///Sends a message which is a reply to a received message.
///Params:
///    channel = A pointer to the <b>Channel</b> object on which to send the reply Message. The pointer must reference a valid
///              WS_CHANNEL object.
///    replyMessage = A pointer to the <b>Message</b> object for sending the reply. The pointer must reference a valid WS_MESSAGE
///                   object. Message object state must be set to <b>WS_MESSAGE_STATE_EMPTY</b> or <b>WS_MESSAGE_STATE_INITIALIZED</b>.
///                   <div class="alert"><b>Note</b> If an initialized message is provided it must be initialized using
///                   <b>WS_REPLY_MESSAGE</b> or <b>WS_FAULT_MESSAGE</b>. </div> <div> </div>
///    replyMessageDescription = A pointer to a WS_MESSAGE_DESCRIPTION object. The <b>action</b> field of <b>WS_MESSAGE_DESCRIPTION</b> is used as
///                              the <b>action</b> header for the reply message. This field can be <b>NULL</b> if no action is required. The
///                              <b>bodyElementDescription</b> field of the WS_MESSAGE_DESCRIPTIONis used to serialize the body of the reply
///                              message. This field may be <b>NULL</b> if no body element is desired. See WsWriteBody for information about how
///                              the <b>bodyElementDescription</b> is used to serialize a value.
///    writeOption = Determines whether the body element is required, and how the value is allocated. See WS_WRITE_OPTION for more
///                  information.
///    replyBodyValue = A void pointer to the value to serialize in the reply message.
///    replyBodyValueSize = The size in bytes of the reply value being serialized.
///    requestMessage = A pointer to a WS_MESSAGE object encapsulating the request message text. This is used to obtain correlation
///                     information used in formulating the reply message. <div class="alert"><b>Note</b> The message can be in any state
///                     except <b>WS_MESSAGE_STATE_EMPTY</b>. </div> <div> </div>
///    asyncContext = A pointer to a WS_ASYNC_CONTEXT data structure with information about invoking the function asynchronously. A
///                   <b>NULL</b> value indicates a request for synchronous operation.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>WS_S_ASYNC</b></dt> </dl> </td> <td width="60%"> The asynchronous operation is still
///    pending. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_OPERATION_ABORTED</b></dt> </dl> </td> <td
///    width="60%"> The operation was aborted. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_INVALID_OPERATION</b></dt> </dl> </td> <td width="60%"> The operation is not allowed due to the
///    current state of the object. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_ENDPOINT_DISCONNECTED</b></dt>
///    </dl> </td> <td width="60%"> The connection with the remote endpoint was terminated. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl> </td> <td width="60%"> The input data was not in the
///    expected format or did not have the expected value. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_OPERATION_TIMED_OUT</b></dt> </dl> </td> <td width="60%"> The operation did not complete within the
///    time allotted. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_QUOTA_EXCEEDED</b></dt> </dl> </td> <td
///    width="60%"> A quota was exceeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SECURITY_VERIFICATION_FAILURE</b></dt> </dl> </td> <td width="60%"> Security verification was not
///    successful for the received data. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SECURITY_SYSTEM_FAILURE</b></dt> </dl> </td> <td width="60%"> A security operation failed in the
///    Windows Web Services framework. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SECURITY_TOKEN_EXPIRED</b></dt> </dl> </td> <td width="60%"> A security token was rejected by the
///    server because it has expired. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td>
///    <td width="60%"> Ran out of memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
///    </td> <td width="60%"> One or more arguments are invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b> Other
///    Errors </b></dt> </dl> </td> <td width="60%"> This function may return other errors not listed above. </td> </tr>
///    </table>
///    
@DllImport("webservices")
HRESULT WsSendReplyMessage(WS_CHANNEL* channel, WS_MESSAGE* replyMessage, 
                           const(WS_MESSAGE_DESCRIPTION)* replyMessageDescription, WS_WRITE_OPTION writeOption, 
                           const(void)* replyBodyValue, uint replyBodyValueSize, WS_MESSAGE* requestMessage, 
                           const(WS_ASYNC_CONTEXT)* asyncContext, WS_ERROR* error);

///Sends a fault message given a WS_ERROR object.
///Params:
///    channel = The channel to send the message on.
///    replyMessage = A message object to use to send the reply message. The message object should be in WS_MESSAGE_STATE_EMPTY or
///                   <b>WS_MESSAGE_STATE_INITIALIZED</b>. If an initialized message is provided, it should have been initialized using
///                   WS_FAULT_MESSAGE.
///    faultError = The error object to use to construct the fault.
///    faultErrorCode = The error code associated with the fault. This cannot be a success code. This error code is never included in the
///                     fault message directly, but instead is used as a fallback mechanism for creating an fault string in the case that
///                     the WS_ERROR object does not contain any error strings.
///    faultDisclosure = Controls how much of the error information is included in the fault message.
///    requestMessage = The request message. This is used to obtain correlation information used in formulating the reply message. The
///                     message can be in any state but WS_MESSAGE_STATE_EMPTY.
///    asyncContext = Information on how to invoke the function asynchronously, or <b>NULL</b> if invoking synchronously.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>WS_S_ASYNC</b></dt> </dl> </td> <td width="60%"> The asynchronous operation is still
///    pending. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_OPERATION_ABORTED</b></dt> </dl> </td> <td
///    width="60%"> The operation was aborted. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_INVALID_OPERATION</b></dt> </dl> </td> <td width="60%"> The operation is not allowed due to the
///    current state of the object. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_ENDPOINT_DISCONNECTED</b></dt>
///    </dl> </td> <td width="60%"> The connection with the remote endpoint was terminated. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl> </td> <td width="60%"> The input data was not in the
///    expected format or did not have the expected value. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_OPERATION_TIMED_OUT</b></dt> </dl> </td> <td width="60%"> The operation did not complete within the
///    time allotted. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_QUOTA_EXCEEDED</b></dt> </dl> </td> <td
///    width="60%"> A quota was exceeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SECURITY_VERIFICATION_FAILURE</b></dt> </dl> </td> <td width="60%"> Security verification was not
///    successful for the received data. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SECURITY_SYSTEM_FAILURE</b></dt> </dl> </td> <td width="60%"> A security operation failed in the
///    Windows Web Services framework. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td>
///    <td width="60%"> Ran out of memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
///    </td> <td width="60%"> One or more arguments are invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b> Other
///    Errors </b></dt> </dl> </td> <td width="60%"> This function may return other errors not listed above. </td> </tr>
///    </table>
///    
@DllImport("webservices")
HRESULT WsSendFaultMessageForError(WS_CHANNEL* channel, WS_MESSAGE* replyMessage, WS_ERROR* faultError, 
                                   HRESULT faultErrorCode, WS_FAULT_DISCLOSURE faultDisclosure, 
                                   WS_MESSAGE* requestMessage, const(WS_ASYNC_CONTEXT)* asyncContext, 
                                   WS_ERROR* error);

///Retrieves a property of the Channel referenced by the <i>channel</i> parameter.
///Params:
///    channel = A pointer to the WS_CHANNEL object with the property to retrieve.
///    id = Represents an identifier of the property to retrieve.
///    value = A void pointer referencing the location to store the retrieved property. <div class="alert"><b>Note</b> The
///            pointer must have an alignment compatible with the type of the property. </div> <div> </div>
///    valueSize = The number of bytes allocated by the caller to store the retrieved property.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
@DllImport("webservices")
HRESULT WsGetChannelProperty(WS_CHANNEL* channel, WS_CHANNEL_PROPERTY_ID id, void* value, uint valueSize, 
                             WS_ERROR* error);

///Sets a property of the channel.
///Params:
///    channel = A pointer to the <b>Channel</b> on which to set the property and may not be <b>NULL</b>.
///    id = Identifier of the property to set.
///    value = A void pointer to the property value to set. The pointer must have an alignment compatible with the type of the
///            property.
///    valueSize = The size in bytes of of the property value.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
@DllImport("webservices")
HRESULT WsSetChannelProperty(WS_CHANNEL* channel, WS_CHANNEL_PROPERTY_ID id, const(void)* value, uint valueSize, 
                             WS_ERROR* error);

///Write out all the headers of the message to the channel, and prepare to write the body elements.
///Params:
///    channel = The channel to use to write the message.
///    message = The message to write.
///    asyncContext = Information on how to invoke the function asynchronously, or <b>NULL</b> if invoking synchronously.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>WS_S_ASYNC</b></dt> </dl> </td> <td width="60%"> The asynchronous operation is still
///    pending. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_OPERATION_ABORTED</b></dt> </dl> </td> <td
///    width="60%"> The operation was aborted. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_INVALID_OPERATION</b></dt> </dl> </td> <td width="60%"> The operation is not allowed due to the
///    current state of the object. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_ENDPOINT_NOT_FOUND</b></dt> </dl>
///    </td> <td width="60%"> The remote endpoint does not exist or could not be located. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>WS_E_ENDPOINT_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access was denied by
///    the remote endpoint. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_ENDPOINT_DISCONNECTED</b></dt> </dl>
///    </td> <td width="60%"> The connection with the remote endpoint was terminated. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>WS_E_ENDPOINT_FAILURE</b></dt> </dl> </td> <td width="60%"> The remote endpoint could not process the
///    request. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_ENDPOINT_NOT_AVAILABLE</b></dt> </dl> </td> <td
///    width="60%"> The remote endpoint is not currently in service at this location. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>WS_E_ENDPOINT_TOO_BUSY</b></dt> </dl> </td> <td width="60%"> The remote endpoint is unable to process
///    the request due to being overloaded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_ENDPOINT_UNREACHABLE</b></dt> </dl> </td> <td width="60%"> The remote endpoint was not reachable.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_ENDPOINT_URL</b></dt> </dl> </td> <td width="60%"> The
///    endpoint address URL is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl>
///    </td> <td width="60%"> The input data was not in the expected format or did not have the expected value. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_OPERATION_TIMED_OUT</b></dt> </dl> </td> <td width="60%"> The
///    operation did not complete within the time allotted. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_PROXY_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access was denied by the HTTP proxy server.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_PROXY_FAILURE</b></dt> </dl> </td> <td width="60%"> The HTTP
///    proxy server could not process the request. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_QUOTA_EXCEEDED</b></dt> </dl> </td> <td width="60%"> A quota was exceeded. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>WS_E_SECURITY_VERIFICATION_FAILURE</b></dt> </dl> </td> <td width="60%"> Security
///    verification was not successful for the received data. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SECURITY_SYSTEM_FAILURE</b></dt> </dl> </td> <td width="60%"> A security operation failed in the
///    Windows Web Services framework. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SECURITY_TOKEN_EXPIRED</b></dt> </dl> </td> <td width="60%"> A security token was rejected by the
///    server because it has expired. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_PROXY_REQUIRES_BASIC_AUTH</b></dt> </dl> </td> <td width="60%"> The HTTP proxy server requires HTTP
///    authentication scheme 'basic'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_PROXY_REQUIRES_DIGEST_AUTH</b></dt> </dl> </td> <td width="60%"> The HTTP proxy server requires HTTP
///    authentication scheme 'digest'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_PROXY_REQUIRES_NEGOTIATE_AUTH</b></dt> </dl> </td> <td width="60%"> The HTTP proxy server requires
///    HTTP authentication scheme 'negotiate'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_PROXY_REQUIRES_NTLM_AUTH</b></dt> </dl> </td> <td width="60%"> The HTTP proxy server requires HTTP
///    authentication scheme 'NTLM'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SERVER_REQUIRES_BASIC_AUTH</b></dt> </dl> </td> <td width="60%"> The remote endpoint requires HTTP
///    authentication scheme 'basic'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SERVER_REQUIRES_DIGEST_AUTH</b></dt> </dl> </td> <td width="60%"> The remote endpoint requires HTTP
///    authentication scheme 'digest'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SERVER_REQUIRES_NEGOTIATE_AUTH</b></dt> </dl> </td> <td width="60%"> The remote endpoint requires
///    HTTP authentication scheme 'negotiate'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SERVER_REQUIRES_NTLM_AUTH</b></dt> </dl> </td> <td width="60%"> The remote endpoint requires HTTP
///    authentication scheme 'NTLM'. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>CERT_E_EXPIRED</b></dt> </dl> </td>
///    <td width="60%"> A required certificate is not within its validity period when verifying against the current
///    system clock or the timestamp in the signed file. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>CERT_E_CN_NO_MATCH</b></dt> </dl> </td> <td width="60%"> The certificates CN name does not match the
///    passed value. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>CERT_E_UNTRUSTEDROOT</b></dt> </dl> </td> <td
///    width="60%"> A certificate chain processed, but terminated in a root certificate which is not trusted by the
///    trust provider. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>CERT_E_WRONG_USAGE</b></dt> </dl> </td> <td
///    width="60%"> The certificate is not valid for the requested usage. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>CRYPT_E_REVOCATION_OFFLINE</b></dt> </dl> </td> <td width="60%"> The revocation function was unable to
///    check revocation because the revocation server was offline. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Ran out of memory. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b> Other Errors </b></dt> </dl> </td> <td width="60%"> This function may return
///    other errors not listed above. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsWriteMessageStart(WS_CHANNEL* channel, WS_MESSAGE* message, const(WS_ASYNC_CONTEXT)* asyncContext, 
                            WS_ERROR* error);

///Write the closing elements of the message to the channel.
///Params:
///    channel = The channel to write to.
///    message = The message to write.
///    asyncContext = Information on how to invoke the function asynchronously, or <b>NULL</b> if invoking synchronously.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>WS_S_ASYNC</b></dt> </dl> </td> <td width="60%"> The asynchronous operation is still
///    pending. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_OPERATION_ABORTED</b></dt> </dl> </td> <td
///    width="60%"> The operation was aborted. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_INVALID_OPERATION</b></dt> </dl> </td> <td width="60%"> The operation is not allowed due to the
///    current state of the object. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_ENDPOINT_NOT_FOUND</b></dt> </dl>
///    </td> <td width="60%"> The remote endpoint does not exist or could not be located. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>WS_E_ENDPOINT_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access was denied by
///    the remote endpoint. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_ENDPOINT_DISCONNECTED</b></dt> </dl>
///    </td> <td width="60%"> The connection with the remote endpoint was terminated. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>WS_E_ENDPOINT_FAILURE</b></dt> </dl> </td> <td width="60%"> The remote endpoint could not process the
///    request. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_ENDPOINT_NOT_AVAILABLE</b></dt> </dl> </td> <td
///    width="60%"> The remote endpoint is not currently in service at this location. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>WS_E_ENDPOINT_TOO_BUSY</b></dt> </dl> </td> <td width="60%"> The remote endpoint is unable to process
///    the request due to being overloaded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_ENDPOINT_UNREACHABLE</b></dt> </dl> </td> <td width="60%"> The remote endpoint was not reachable.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_ENDPOINT_URL</b></dt> </dl> </td> <td width="60%"> The
///    endpoint address URL is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl>
///    </td> <td width="60%"> The input data was not in the expected format or did not have the expected value. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_OPERATION_TIMED_OUT</b></dt> </dl> </td> <td width="60%"> The
///    operation did not complete within the time allotted. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_PROXY_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access was denied by the HTTP proxy server.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_PROXY_FAILURE</b></dt> </dl> </td> <td width="60%"> The HTTP
///    proxy server could not process the request. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_QUOTA_EXCEEDED</b></dt> </dl> </td> <td width="60%"> A quota was exceeded. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>WS_E_SECURITY_VERIFICATION_FAILURE</b></dt> </dl> </td> <td width="60%"> Security
///    verification was not successful for the received data. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SECURITY_SYSTEM_FAILURE</b></dt> </dl> </td> <td width="60%"> A security operation failed in the
///    Windows Web Services framework. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SECURITY_TOKEN_EXPIRED</b></dt> </dl> </td> <td width="60%"> A security token was rejected by the
///    server because it has expired. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_PROXY_REQUIRES_BASIC_AUTH</b></dt> </dl> </td> <td width="60%"> The HTTP proxy server requires HTTP
///    authentication scheme 'basic'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_PROXY_REQUIRES_DIGEST_AUTH</b></dt> </dl> </td> <td width="60%"> The HTTP proxy server requires HTTP
///    authentication scheme 'digest'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_PROXY_REQUIRES_NEGOTIATE_AUTH</b></dt> </dl> </td> <td width="60%"> The HTTP proxy server requires
///    HTTP authentication scheme 'negotiate'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_PROXY_REQUIRES_NTLM_AUTH</b></dt> </dl> </td> <td width="60%"> The HTTP proxy server requires HTTP
///    authentication scheme 'NTLM'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SERVER_REQUIRES_BASIC_AUTH</b></dt> </dl> </td> <td width="60%"> The remote endpoint requires HTTP
///    authentication scheme 'basic'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SERVER_REQUIRES_DIGEST_AUTH</b></dt> </dl> </td> <td width="60%"> The remote endpoint requires HTTP
///    authentication scheme 'digest'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SERVER_REQUIRES_NEGOTIATE_AUTH</b></dt> </dl> </td> <td width="60%"> The remote endpoint requires
///    HTTP authentication scheme 'negotiate'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SERVER_REQUIRES_NTLM_AUTH</b></dt> </dl> </td> <td width="60%"> The remote endpoint requires HTTP
///    authentication scheme 'NTLM'. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>CERT_E_EXPIRED</b></dt> </dl> </td>
///    <td width="60%"> A required certificate is not within its validity period when verifying against the current
///    system clock or the timestamp in the signed file. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>CERT_E_CN_NO_MATCH</b></dt> </dl> </td> <td width="60%"> The certificates CN name does not match the
///    passed value. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>CERT_E_UNTRUSTEDROOT</b></dt> </dl> </td> <td
///    width="60%"> A certificate chain processed, but terminated in a root certificate which is not trusted by the
///    trust provider. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>CERT_E_WRONG_USAGE</b></dt> </dl> </td> <td
///    width="60%"> The certificate is not valid for the requested usage. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>CRYPT_E_REVOCATION_OFFLINE</b></dt> </dl> </td> <td width="60%"> The revocation function was unable to
///    check revocation because the revocation server was offline. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Ran out of memory. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b> Other Errors </b></dt> </dl> </td> <td width="60%"> This function may return
///    other errors not listed above. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsWriteMessageEnd(WS_CHANNEL* channel, WS_MESSAGE* message, const(WS_ASYNC_CONTEXT)* asyncContext, 
                          WS_ERROR* error);

///Read the headers of the next message from the channel, and prepare to read the body elements.
///Params:
///    channel = The channel to receive from.
///    message = The message to receive into.
///    asyncContext = Information on how to invoke the function asynchronously, or <b>NULL</b> if invoking synchronously.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Start of message was received
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_S_END</b></dt> </dl> </td> <td width="60%"> There
///    are no more messages available on the channel. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_S_ASYNC</b></dt>
///    </dl> </td> <td width="60%"> The asynchronous operation is still pending. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_OPERATION_ABORTED</b></dt> </dl> </td> <td width="60%"> The operation was aborted. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>WS_E_INVALID_OPERATION</b></dt> </dl> </td> <td width="60%"> The operation is not
///    allowed due to the current state of the object. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_ENDPOINT_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The remote endpoint does not exist or could
///    not be located. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_ENDPOINT_ACCESS_DENIED</b></dt> </dl> </td>
///    <td width="60%"> Access was denied by the remote endpoint. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_ENDPOINT_DISCONNECTED</b></dt> </dl> </td> <td width="60%"> The connection with the remote endpoint
///    was terminated. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_ENDPOINT_FAILURE</b></dt> </dl> </td> <td
///    width="60%"> The remote endpoint could not process the request. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_ENDPOINT_NOT_AVAILABLE</b></dt> </dl> </td> <td width="60%"> The remote endpoint is not currently in
///    service at this location. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_ENDPOINT_TOO_BUSY</b></dt> </dl>
///    </td> <td width="60%"> The remote endpoint is unable to process the request due to being overloaded. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>WS_E_ENDPOINT_UNREACHABLE</b></dt> </dl> </td> <td width="60%"> The remote
///    endpoint was not reachable. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_ENDPOINT_URL</b></dt>
///    </dl> </td> <td width="60%"> The endpoint address URL is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl> </td> <td width="60%"> The input data was not in the expected format or
///    did not have the expected value. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_OPERATION_TIMED_OUT</b></dt>
///    </dl> </td> <td width="60%"> The operation did not complete within the time allotted. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>WS_E_PROXY_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access was denied by the
///    HTTP proxy server. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_PROXY_FAILURE</b></dt> </dl> </td> <td
///    width="60%"> The HTTP proxy server could not process the request. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_QUOTA_EXCEEDED</b></dt> </dl> </td> <td width="60%"> A quota was exceeded. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>WS_E_SECURITY_VERIFICATION_FAILURE</b></dt> </dl> </td> <td width="60%"> Security
///    verification was not successful for the received data. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SECURITY_SYSTEM_FAILURE</b></dt> </dl> </td> <td width="60%"> A security operation failed in the
///    Windows Web Services framework. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SECURITY_TOKEN_EXPIRED</b></dt> </dl> </td> <td width="60%"> A security token was rejected by the
///    server because it has expired. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_PROXY_REQUIRES_BASIC_AUTH</b></dt> </dl> </td> <td width="60%"> The HTTP proxy server requires HTTP
///    authentication scheme 'basic'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_PROXY_REQUIRES_DIGEST_AUTH</b></dt> </dl> </td> <td width="60%"> The HTTP proxy server requires HTTP
///    authentication scheme 'digest'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_PROXY_REQUIRES_NEGOTIATE_AUTH</b></dt> </dl> </td> <td width="60%"> The HTTP proxy server requires
///    HTTP authentication scheme 'negotiate'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_PROXY_REQUIRES_NTLM_AUTH</b></dt> </dl> </td> <td width="60%"> The HTTP proxy server requires HTTP
///    authentication scheme 'NTLM'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SERVER_REQUIRES_BASIC_AUTH</b></dt> </dl> </td> <td width="60%"> The remote endpoint requires HTTP
///    authentication scheme 'basic'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SERVER_REQUIRES_DIGEST_AUTH</b></dt> </dl> </td> <td width="60%"> The remote endpoint requires HTTP
///    authentication scheme 'digest'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SERVER_REQUIRES_NEGOTIATE_AUTH</b></dt> </dl> </td> <td width="60%"> The remote endpoint requires
///    HTTP authentication scheme 'negotiate'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SERVER_REQUIRES_NTLM_AUTH</b></dt> </dl> </td> <td width="60%"> The remote endpoint requires HTTP
///    authentication scheme 'NTLM'. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>CERT_E_EXPIRED</b></dt> </dl> </td>
///    <td width="60%"> A required certificate is not within its validity period when verifying against the current
///    system clock or the timestamp in the signed file. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>CERT_E_CN_NO_MATCH</b></dt> </dl> </td> <td width="60%"> The certificates CN name does not match the
///    passed value. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>CERT_E_UNTRUSTEDROOT</b></dt> </dl> </td> <td
///    width="60%"> A certificate chain processed, but terminated in a root certificate which is not trusted by the
///    trust provider. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>CERT_E_WRONG_USAGE</b></dt> </dl> </td> <td
///    width="60%"> The certificate is not valid for the requested usage. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>CRYPT_E_REVOCATION_OFFLINE</b></dt> </dl> </td> <td width="60%"> The revocation function was unable to
///    check revocation because the revocation server was offline. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Ran out of memory. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b> Other Errors </b></dt> </dl> </td> <td width="60%"> This function may return
///    other errors not listed above. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsReadMessageStart(WS_CHANNEL* channel, WS_MESSAGE* message, const(WS_ASYNC_CONTEXT)* asyncContext, 
                           WS_ERROR* error);

///Read the closing elements of a message from a channel.
///Params:
///    channel = The channel to receive for.
///    message = The message to read the end of.
///    asyncContext = Information on how to invoke the function asynchronously, or <b>NULL</b> if invoking synchronously.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>WS_S_ASYNC</b></dt> </dl> </td> <td width="60%"> The asynchronous operation is still
///    pending. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_OPERATION_ABORTED</b></dt> </dl> </td> <td
///    width="60%"> The operation was aborted. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_INVALID_OPERATION</b></dt> </dl> </td> <td width="60%"> The operation is not allowed due to the
///    current state of the object. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_ENDPOINT_NOT_FOUND</b></dt> </dl>
///    </td> <td width="60%"> The remote endpoint does not exist or could not be located. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>WS_E_ENDPOINT_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access was denied by
///    the remote endpoint. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_ENDPOINT_DISCONNECTED</b></dt> </dl>
///    </td> <td width="60%"> The connection with the remote endpoint was terminated. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>WS_E_ENDPOINT_FAILURE</b></dt> </dl> </td> <td width="60%"> The remote endpoint could not process the
///    request. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_ENDPOINT_NOT_AVAILABLE</b></dt> </dl> </td> <td
///    width="60%"> The remote endpoint is not currently in service at this location. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>WS_E_ENDPOINT_TOO_BUSY</b></dt> </dl> </td> <td width="60%"> The remote endpoint is unable to process
///    the request due to being overloaded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_ENDPOINT_UNREACHABLE</b></dt> </dl> </td> <td width="60%"> The remote endpoint was not reachable.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_ENDPOINT_URL</b></dt> </dl> </td> <td width="60%"> The
///    endpoint address URL is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl>
///    </td> <td width="60%"> The input data was not in the expected format or did not have the expected value. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_OPERATION_TIMED_OUT</b></dt> </dl> </td> <td width="60%"> The
///    operation did not complete within the time allotted. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_PROXY_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access was denied by the HTTP proxy server.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_PROXY_FAILURE</b></dt> </dl> </td> <td width="60%"> The HTTP
///    proxy server could not process the request. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_QUOTA_EXCEEDED</b></dt> </dl> </td> <td width="60%"> A quota was exceeded. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>WS_E_SECURITY_VERIFICATION_FAILURE</b></dt> </dl> </td> <td width="60%"> Security
///    verification was not successful for the received data. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SECURITY_SYSTEM_FAILURE</b></dt> </dl> </td> <td width="60%"> A security operation failed in the
///    Windows Web Services framework. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SECURITY_TOKEN_EXPIRED</b></dt> </dl> </td> <td width="60%"> A security token was rejected by the
///    server because it has expired. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_PROXY_REQUIRES_BASIC_AUTH</b></dt> </dl> </td> <td width="60%"> The HTTP proxy server requires HTTP
///    authentication scheme 'basic'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_PROXY_REQUIRES_DIGEST_AUTH</b></dt> </dl> </td> <td width="60%"> The HTTP proxy server requires HTTP
///    authentication scheme 'digest'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_PROXY_REQUIRES_NEGOTIATE_AUTH</b></dt> </dl> </td> <td width="60%"> The HTTP proxy server requires
///    HTTP authentication scheme 'negotiate'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_PROXY_REQUIRES_NTLM_AUTH</b></dt> </dl> </td> <td width="60%"> The HTTP proxy server requires HTTP
///    authentication scheme 'NTLM'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SERVER_REQUIRES_BASIC_AUTH</b></dt> </dl> </td> <td width="60%"> The remote endpoint requires HTTP
///    authentication scheme 'basic'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SERVER_REQUIRES_DIGEST_AUTH</b></dt> </dl> </td> <td width="60%"> The remote endpoint requires HTTP
///    authentication scheme 'digest'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SERVER_REQUIRES_NEGOTIATE_AUTH</b></dt> </dl> </td> <td width="60%"> The remote endpoint requires
///    HTTP authentication scheme 'negotiate'. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_SERVER_REQUIRES_NTLM_AUTH</b></dt> </dl> </td> <td width="60%"> The remote endpoint requires HTTP
///    authentication scheme 'NTLM'. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>CERT_E_EXPIRED</b></dt> </dl> </td>
///    <td width="60%"> A required certificate is not within its validity period when verifying against the current
///    system clock or the timestamp in the signed file. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>CERT_E_CN_NO_MATCH</b></dt> </dl> </td> <td width="60%"> The certificates CN name does not match the
///    passed value. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>CERT_E_UNTRUSTEDROOT</b></dt> </dl> </td> <td
///    width="60%"> A certificate chain processed, but terminated in a root certificate which is not trusted by the
///    trust provider. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>CERT_E_WRONG_USAGE</b></dt> </dl> </td> <td
///    width="60%"> The certificate is not valid for the requested usage. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>CRYPT_E_REVOCATION_OFFLINE</b></dt> </dl> </td> <td width="60%"> The revocation function was unable to
///    check revocation because the revocation server was offline. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Ran out of memory. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b> Other Errors </b></dt> </dl> </td> <td width="60%"> This function may return
///    other errors not listed above. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsReadMessageEnd(WS_CHANNEL* channel, WS_MESSAGE* message, const(WS_ASYNC_CONTEXT)* asyncContext, 
                         WS_ERROR* error);

///Closes a specified channel.
///Params:
///    channel = Pointer to a WS_CHANNEL structure representing the channel to close.
///    asyncContext = Pointer to a WS_ASYNC_CONTEXT data structure containing information for invoking the function asynchronously.
///                   Pass a <b>NULL</b> value to call the function synchronously.
///    error = Pointer to a WS_ERROR structure where additional error information is stored if the function fails.
///Returns:
///    If the function succeeds, it returns NO_ERROR; otherwise, it returns an HRESULT error code. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_S_ASYNC</b></dt> </dl> </td>
///    <td width="60%"> The asynchronous operation is still pending. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_OPERATION_ABORTED</b></dt> </dl> </td> <td width="60%"> The channel closure was aborted by a call to
///    WsAbortChannel while the channel was closing. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_INVALID_OPERATION</b></dt> </dl> </td> <td width="60%"> The channel was in an inappropriate state
///    (see the Remarks section). </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_ENDPOINT_DISCONNECTED</b></dt>
///    </dl> </td> <td width="60%"> The connection with the remote endpoint was terminated. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>WS_E_ENDPOINT_FAILURE</b></dt> </dl> </td> <td width="60%"> The remote endpoint could
///    not process the request. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl> </td>
///    <td width="60%"> The input data was not in the expected format or did not have the expected value. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>WS_E_OPERATION_TIMED_OUT</b></dt> </dl> </td> <td width="60%"> The operation
///    did not complete within the time allotted. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_QUOTA_EXCEEDED</b></dt> </dl> </td> <td width="60%"> A quota was exceeded. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Insuffiient memory to complete the
///    operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One
///    or more arguments are invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b> Other Errors </b></dt> </dl> </td>
///    <td width="60%"> This function may return other errors not listed above. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsCloseChannel(WS_CHANNEL* channel, const(WS_ASYNC_CONTEXT)* asyncContext, WS_ERROR* error);

///Cancels all pending I/O for a specified channel
///Params:
///    channel = A pointer to a WS_CHANNEL structure representing the channel for which to cancel I/O.
///    error = Pointer to a WS_ERROR structure that receives additional error information if the function fails.
///Returns:
///    If the function succeeds, it returns NO_ERROR; otherwise, it returns an HRESULT error code. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_NOT_SUPPORTED</b></dt>
///    </dl> </td> <td width="60%"> See the Remarks section for platform limitations. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are invalid. </td> </tr>
///    </table>
///    
@DllImport("webservices")
HRESULT WsAbortChannel(WS_CHANNEL* channel, WS_ERROR* error);

///Releases the memory resource associated with a Channel object. The <b>Channel</b> must be in the either the
///WS_CHANNEL_STATE_CREATED or <b>WS_CHANNEL_STATE_CLOSED</b> state to be released. If a Channel has been successfully
///opened it must be closed before it can be released.
///Params:
///    channel = A pointer to the <b>Channel</b> object to release. The pointer must reference a valid WS_CHANNEL object returned
///              by WsCreateChannel or WsCreateChannelForListener. The referenced value may not be <b>NULL</b>.
@DllImport("webservices")
void WsFreeChannel(WS_CHANNEL* channel);

///Reset a channel so it can be reused.
///Params:
///    channel = The channel to reset.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>WS_E_INVALID_OPERATION</b></dt> </dl> </td> <td width="60%"> The channel was in an
///    inappropriate state. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsResetChannel(WS_CHANNEL* channel, WS_ERROR* error);

///Skips the remainder of a specified message on a specified channel.
///Params:
///    channel = Pointer to a WS_CHANNEL structure representing the channel on which the message is being read or written.
///    message = Pointer to a WS_MESSAGE structure representing the message to abandon. This should be the same message that was
///              passed to the WsWriteMessageStart or WsReadMessageStart function.
///    error = Pointer to a WS_ERROR structure that receives additional error information if the function fails.
///Returns:
///    If the function succeeds, it returns NO_ERROR; otherwise, it returns an HRESULT error code. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_OPERATION</b></dt>
///    </dl> </td> <td width="60%"> The channel is not in the WS_CHANNEL_STATE_OPEN or WS_CHANNEL_STATE_FAULTED state.
///    (For channel states, see the WS_CHANNEL_STATE enumeration.) </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The specified message is not currently being read or
///    written on the specified channel. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsAbandonMessage(WS_CHANNEL* channel, WS_MESSAGE* message, WS_ERROR* error);

///Used to signal the end of messages for a session channel.
///Params:
///    channel = The session channel to shut down.
///    asyncContext = Information on how to invoke the function asynchronously, or <b>NULL</b> if invoking synchronously.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>WS_E_INVALID_OPERATION</b></dt> </dl> </td> <td width="60%"> This is returned if the
///    channel is not in the WS_CHANNEL_STATE_OPENstate. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsShutdownSessionChannel(WS_CHANNEL* channel, const(WS_ASYNC_CONTEXT)* asyncContext, WS_ERROR* error);

///Returns a property of the specified operation context. It should be noted that the validity of these property is
///limited to the lifetime of the operation context itself.
///Params:
///    context = The context that the property value is being obtained for.
///    id = The id of the property.
///    value = The address to place the retrieved value. The contents are not modified in case of a failure. The pointer must
///            have an alignment compatible with the type of the property.
///    valueSize = The size of the buffer that the caller has allocated for the retrieved value.
///    error = Specifies where additional error information should be stored if the function fails.
@DllImport("webservices")
HRESULT WsGetOperationContextProperty(const(WS_OPERATION_CONTEXT)* context, 
                                      const(WS_OPERATION_CONTEXT_PROPERTY_ID) id, void* value, uint valueSize, 
                                      WS_ERROR* error);

///Retrieves an XML Dictionary object. The retrieved Dictionary is returned by the <i>dictionary</i> reference
///parameter.
///Params:
///    encoding = Indicates an enumeration of the Dictionary encoding.
///    dictionary = A reference to a WS_XML_DICTIONARY structure for the retrieved <b>Dictionary</b>.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
@DllImport("webservices")
HRESULT WsGetDictionary(WS_ENCODING encoding, WS_XML_DICTIONARY** dictionary, WS_ERROR* error);

///Reads an extension of the WS_ENDPOINT_ADDRESS.
///Params:
///    reader = The XML reader to use to read the extension. The function will automatically set the input of the reader as
///             necessary to read the extensions.
///    endpointAddress = The endpoint address containing the extensions.
///    extensionType = The type of extension to read.
///    readOption = Whether the value is required, and how to allocate the value. See WS_READ_OPTION for more information. This
///                 parameter must have one of the following values: <ul> <li> WS_READ_REQUIRED_VALUE. </li> <li>
///                 WS_READ_REQUIRED_POINTER. </li> <li> WS_READ_OPTIONAL_POINTER. </li> </ul>
///    heap = The heap to use to store the value that is read.
///    value = The address of a buffer to place the value read. If using WS_READ_REQUIRED_VALUE for the readOption parameter,
///            the buffer must be the size of the type of extension being read (which varies by
///            WS_ENDPOINT_ADDRESS_EXTENSION_TYPE). If using WS_READ_REQUIRED_POINTER or <b>WS_READ_OPTIONAL_POINTER</b>, the
///            buffer should be the size of a pointer.
///    valueSize = The size of the buffer that the caller has allocated for the value read. This size should correspond to the size
///                of the buffer passed using the value parameter.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The extension type was not valid.
///    The size of the supplied buffer was not correct. A required parameter was <b>NULL</b>. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl> </td> <td width="60%"> The input data was not in the
///    expected format or did not have the expected value. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Ran out of memory. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b> Other Errors </b></dt> </dl> </td> <td width="60%"> This function may return other errors not listed
///    above. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsReadEndpointAddressExtension(WS_XML_READER* reader, WS_ENDPOINT_ADDRESS* endpointAddress, 
                                       WS_ENDPOINT_ADDRESS_EXTENSION_TYPE extensionType, WS_READ_OPTION readOption, 
                                       WS_HEAP* heap, void* value, uint valueSize, WS_ERROR* error);

///Creates an error object that can passed to functions to record rich error information.
///Params:
///    properties = An array of WS_ERROR_PROPERTY structures containing optional error properties.
///    propertyCount = The number of properties in the <i>properties</i> array.
///    error = On success, a pointer that receives the address of the WS_ERROR structure representing the created error object.
///Returns:
///    If the function succeeds, it returns NO_ERROR; otherwise, it returns an HRESULT error code. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
///    </td> <td width="60%"> One or more arguments are invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory to complete the operation. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b> Other Errors </b></dt> </dl> </td> <td width="60%"> This function may
///    return other errors not listed above. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsCreateError(const(WS_ERROR_PROPERTY)* properties, uint propertyCount, WS_ERROR** error);

///Adds a specified error string to the error object.
///Params:
///    error = Pointer to a WS_ERROR structure representing the error object to which to add the string.
///    string = The string to add. The error object will make a copy of the string.
///Returns:
///    If the function succeeds, it returns NO_ERROR; otherwise, it returns an HRESULT error code. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
///    </td> <td width="60%"> One or more arguments are invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory to complete the operation. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b> Other Errors </b></dt> </dl> </td> <td width="60%"> This function may
///    return other errors not listed above. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsAddErrorString(WS_ERROR* error, const(WS_STRING)* string);

///Retrieves an error string from an error object.
///Params:
///    error = The error object containing the string.
///    index = The zero-based index identifying the string to retrieve. The first error string (index 0) will be the string most
///            recently added to the error object (using WsAddErrorString). When WS_ERROR_PROPERTY_ORIGINAL_ERROR_CODE is
///            presented in the error object, the corresponding error text will be available in the last index. The number of
///            errors can be retrieved using WS_ERROR_PROPERTY_STRING_COUNT.
///    string = The returned string. The string is valid until WsResetErroror WsFreeError is called. The string is not zero
///             terminated.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b> Other Errors </b></dt> </dl> </td> <td width="60%"> This
///    function may return other errors not listed above. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsGetErrorString(WS_ERROR* error, uint index, WS_STRING* string);

///Copies an error object from a specified source to a specifed destination.
///Params:
///    source = Pointer to a WS_ERROR structure representing the error object to copy.
///    destination = Pointer to a WS_ERROR structure that receives the copied error object.
@DllImport("webservices")
HRESULT WsCopyError(WS_ERROR* source, WS_ERROR* destination);

///Retrieves a property of an WS_ERROR object referenced by the <i>error</i> parameter.
///Params:
///    error = A pointer to the WS_ERROR object with the property to retrieve.
///    id = An identifier of the property to retrieve.
///    buffer = A pointer referencing the location to store the retrieved property.
///    bufferSize = The number of bytes allocated by the caller to store the retrieved property.
@DllImport("webservices")
HRESULT WsGetErrorProperty(WS_ERROR* error, WS_ERROR_PROPERTY_ID id, void* buffer, uint bufferSize);

///Sets an WS_ERROR object property.
///Params:
///    error = A pointer to the <b>Error</b> object in which to set the property. The pointer must reference a valid WS_ERROR
///            object.
///    id = Identifier of the property to set.
///    value = A pointer to the property value to set. The pointer must have an alignment compatible with the type of the
///            property.
///    valueSize = The size in bytes of the property value.
@DllImport("webservices")
HRESULT WsSetErrorProperty(WS_ERROR* error, WS_ERROR_PROPERTY_ID id, const(void)* value, uint valueSize);

///Releases the content of the <i>error</i> object parameter but does not release the resource allocated to the
///<i>error</i> object parameter. <div class="alert"><b>Note</b> The "reset" effect of this function returns the
///<i>error</i> object to the state set at instantiation. The object is not released consequently is available for
///reuse. </div> <div> </div>
///Params:
///    error = This parameter is a pointer to the WS_ERROR object to reset.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are
///    invalid. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsResetError(WS_ERROR* error);

///Releases the memory resource associated with an <b>Error</b> object created using WsCreateError. This releases the
///object and its constituent information.
@DllImport("webservices")
void WsFreeError(WS_ERROR* error);

///Retrieves a Fault error property of an WS_ERROR object referenced by the <i>error</i> parameter.
///Params:
///    error = A pointer to the WS_ERROR object with the property to retrieve.
///    id = Represents an identifier of the fault error property to retrieve.
///    buffer = A pointer referencing the location to store the retrieved fault error property. <div class="alert"><b>Note</b>
///             The pointer must have an alignment compatible with the type of the property.</div> <div> </div>
///    bufferSize = The number of bytes allocated by the caller to store the retrieved property.
@DllImport("webservices")
HRESULT WsGetFaultErrorProperty(WS_ERROR* error, WS_FAULT_ERROR_PROPERTY_ID id, void* buffer, uint bufferSize);

///Set a Fault property of a WS_ERROR object.
///Params:
///    error = A pointer to the WS_ERROR object in which to set the property. The pointer must reference a valid WS_ERROR
///            object.
///    id = Identifier of the property to set.
///    value = The property value to set. The pointer must have an alignment compatible with the type of the property.
///    valueSize = The size in bytes of the property value.
@DllImport("webservices")
HRESULT WsSetFaultErrorProperty(WS_ERROR* error, WS_FAULT_ERROR_PROPERTY_ID id, const(void)* value, uint valueSize);

///Constructs a WS_FAULT from a specified error object.
///Params:
///    error = Pointer to a WS_ERROR structure representing the error object from which to construct the fault.
///    faultErrorCode = The HRESULT error code returned from the function that failed. The HRESULT value cannot be a success code. This
///                     error code is never included in the fault directly, but is used as a fallback mechanism for creating a fault
///                     string if the error object does not contain any error strings.
///    faultDisclosure = WS_FAULT_DISCLOSURE enumeration that controls what information is copied from the error object to the fault
///                      object.
///    heap = Pointer to a WS_HEAP structure representing the heap from which to allocate memory for the returned fault object.
///    fault = Pointer to a WS_FAULT structure representing the returned fault object. The fields of the fault object are good
///            until WsFreeHeap or WsResetHeapis called to release the specified heap resources.
///Returns:
///    If the function succeeds, it returns NO_ERROR; otherwise, it returns an HRESULT error code. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
///    </td> <td width="60%"> One or more arguments are invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory to complete the operation. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b> Other Errors </b></dt> </dl> </td> <td width="60%"> This function may
///    return other errors not listed above. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsCreateFaultFromError(WS_ERROR* error, HRESULT faultErrorCode, WS_FAULT_DISCLOSURE faultDisclosure, 
                               WS_HEAP* heap, WS_FAULT* fault);

///Write the fault detail stored in a WS_ERROR object.
///Params:
///    error = The error object that will contain the fault information.
///    faultDetailDescription = A pointer to a description of the fault detail. If the action field of the fault detail description is
///                             non-<b>NULL</b>, then it is set as the WS_FAULT_ERROR_PROPERTY_ACTIONof the WS_ERROR. The element description of
///                             the fault detail description describes the format of the element in the fault detail.
///    writeOption = Information about how the value is allocated. See WS_WRITE_OPTION for more information.
///    value = A pointer to the value to serialize.
///    valueSize = The size of the value being serialized, in bytes. If the value is <b>NULL</b>, then the size should be 0.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl> </td> <td width="60%"> The input data was not in
///    the expected format or did not have the expected value. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are invalid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Ran out of memory. </td> </tr>
///    </table>
///    
@DllImport("webservices")
HRESULT WsSetFaultErrorDetail(WS_ERROR* error, const(WS_FAULT_DETAIL_DESCRIPTION)* faultDetailDescription, 
                              WS_WRITE_OPTION writeOption, const(void)* value, uint valueSize);

///Read the fault detail stored in a WS_ERROR object.
///Params:
///    error = The error object that contains the fault information.
///    faultDetailDescription = A pointer to a description of the fault detail element. The action value of the fault detail description is used
///                             as a filter value to match against the action of the fault. If both action strings are specified (the action
///                             value of the fault detail description is not <b>NULL</b> and the action value WS_FAULT_ERROR_PROPERTY_ACTION in
///                             the WS_ERROR has a length greater than zero), then the action strings are compared to determine a match. If there
///                             is a match, then the function will then try to deserialize the detail element. The element description of the
///                             fault detail description is used to describe the format of the element in the fault detail.
///    readOption = Whether the element is required, and how to allocate the value. See WS_READ_OPTION for more information.
///    heap = The heap to store the deserialized values in.
///    value = The interpretation of this parameter depends on the WS_READ_OPTION.
///    valueSize = The interpretation of this parameter depends on the WS_READ_OPTION.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl> </td> <td width="60%"> The input data was not in
///    the expected format or did not have the expected value. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Ran out of memory. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>WS_E_QUOTA_EXCEEDED</b></dt> </dl> </td> <td width="60%"> The size quota of the heap was exceeded.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more
///    arguments are invalid. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsGetFaultErrorDetail(WS_ERROR* error, const(WS_FAULT_DETAIL_DESCRIPTION)* faultDetailDescription, 
                              WS_READ_OPTION readOption, WS_HEAP* heap, void* value, uint valueSize);

///Creates a heap object.
///Params:
///    maxSize = The total number of bytes that can be allocated from the heap. The total number of bytes is defined as sum of the
///              sizes passed in all the calls to the WsAlloc function since the heap was created or reset.
///    trimSize = The maximum number of bytes of memory that the heap retains after the heap has been reset by a call to the
///               WsResetHeap function. This is an approximation value due to heap overhead. <div class="alert"><b>Note</b> If the
///               value of <i>trimSize</i> is larger than the value of <i>maxSize</i>, the size of the heap will not be adjusted to
///               the desired size.</div> <div> </div>
///    properties = Reserved for future use; set to <b>NULL</b>.
///    propertyCount = Reserved for future use; set to 0 (zero).
///    heap = On success, pointer that receives the address of the WS_HEAP structure representing the new heap object.
///    error = Pointer to a WS_ERROR structure that receives additional error information if the function fails.
///Returns:
///    If the function succeeds, it returns NO_ERROR; otherwise, it returns an HRESULT error code.
///    
@DllImport("webservices")
HRESULT WsCreateHeap(size_t maxSize, size_t trimSize, const(WS_HEAP_PROPERTY)* properties, uint propertyCount, 
                     WS_HEAP** heap, WS_ERROR* error);

///Allocates a segment of memory from the specified heap.
///Params:
///    heap = Pointer to a WS_HEAP structure representing the heap from which to allocate the memory.
///    size = The number of bytes to allocate. This value can be zero.
///    ptr = On success, a pointer that receives the address of the allocated memory. This pointer is valid until WsFreeHeap
///          or WsResetHeap is called on the heap. The returned pointer is aligned on an 8-byte boundary. Zero byte
///          allocations will return a non-NULL pointer.
///    error = Pointer to a WS_ERROR structure that receives additional error information if the function fails.
///Returns:
///    If the function succeeds, it returns NO_ERROR; otherwise, it returns an HRESULT error code. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_QUOTA_EXCEEDED</b></dt>
///    </dl> </td> <td width="60%"> The requested bytes, in addition to already allocated bytes, exceed the size of the
///    heap, as specified by the WS_HEAP_PROPERTY_MAX_SIZE property. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Insufficent memory to complete the operation. </td>
///    </tr> </table>
///    
@DllImport("webservices")
HRESULT WsAlloc(WS_HEAP* heap, size_t size, void** ptr, WS_ERROR* error);

///Retrieves a particular property of a specified Heap.
///Params:
///    heap = A pointer to the <b>Heap</b> object to that contains the desired property data.
///    id = This is a WS_HEAP_PROPERTY_ID enumerator that identifies the desired property.
///    value = A reference to the retrieved property value. The pointer must have an alignment compatible with the type of the
///            property.
///    valueSize = The buffer size allocated by the caller for the retrieved property value.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
@DllImport("webservices")
HRESULT WsGetHeapProperty(WS_HEAP* heap, WS_HEAP_PROPERTY_ID id, void* value, uint valueSize, WS_ERROR* error);

///Releases all Heap allocations. Allocations made on the Heap using WsAlloc are no longer valid. Allocation for the
///Heap object itself is not released.
///Params:
///    heap = A pointer to a Heap instance to reset. If the heap is not required for the given type this parameter can be
///           <b>NULL</b>. The heap object.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("webservices")
HRESULT WsResetHeap(WS_HEAP* heap, WS_ERROR* error);

///This frees the heap object, and the memory associated with any allocations made on it using WsAlloc.
@DllImport("webservices")
void WsFreeHeap(WS_HEAP* heap);

///Creates a listener with the specified properties.
///Params:
///    channelType = The type of channel the listener listens for. For channel types, see the WS_CHANNEL_TYPE enumeration.
///    channelBinding = The channel protocol for the listener. For possible bindings, see the WS_CHANNEL_BINDING enumeration.
///    properties = Pointer to a WS_LISTENER_PROPERTY structure containing optional properties for the listener. For information on
///                 which properties you can specify when creating a listener, see the WS_LISTENER_PROPERTY_ID enumeration. For
///                 information on creating a custom listener, see the Remarks section.
///    propertyCount = The number of properties in the <i>properties</i> array.
///    securityDescription = Pointer to a WS_SECURITY_DESCRIPTION structure specifying the security for the listener. If you are creating a
///                          custom channel (using the WS_CUSTOM_CHANNEL_BINDING value of the WS_CHANNEL_BINDING enumeration), the security
///                          description must be <b>NULL</b>. See the Remarks section.
///    listener = On success, a pointer that receives the address of the WS_LISTENER structure representing the new listener.
///    error = Pointer to a WS_ERROR structure that receives additional error information if the function fails.
///Returns:
///    If the function succeeds, it returns NO_ERROR; otherwise, it returns an HRESULT error code. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_QUOTA_EXCEEDED</b></dt>
///    </dl> </td> <td width="60%"> A quota was exceeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory to complete the operation. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments
///    are invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b> Other Errors </b></dt> </dl> </td> <td width="60%">
///    This function may return other errors not listed above. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsCreateListener(WS_CHANNEL_TYPE channelType, WS_CHANNEL_BINDING channelBinding, 
                         const(WS_LISTENER_PROPERTY)* properties, uint propertyCount, 
                         const(WS_SECURITY_DESCRIPTION)* securityDescription, WS_LISTENER** listener, 
                         WS_ERROR* error);

///Initiates "listening" on a specified address. Once a listener is opened channels can be accepted from it. If the open
///is successful the Listener must be closed using the WsCloseListener function before Listener resources can be
///released.
///Params:
///    listener = A pointer to the <b>Listener</b> object to open. The pointer must reference a valid WS_LISTENER object and the
///               referenced value may not be <b>NULL</b>.
///    url = A pointer to a object containing the URL address string for the Listener. <div class="alert"><b>Note</b> The URL
///          is always in escaped form.. The URL may not contain a query string or fragment. This URL can include the '+' or
///          '*' wildcards in the host name portion, or a host name, or a literal IP address. See Remarks for more information
///          on the URL.</div> <div> </div>
///    asyncContext = A pointer to A WS_ASYNC_CONTEXT object that has information about how to invoke the function asynchronously. The
///                   value is set to <b>NULL</b> if invoking synchronously.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>WS_S_ASYNC</b></dt> </dl> </td> <td width="60%"> The asynchronous operation is still
///    pending. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_OPERATION_ABORTED</b></dt> </dl> </td> <td
///    width="60%"> The listener was aborted during the open, or before the open. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_INVALID_OPERATION</b></dt> </dl> </td> <td width="60%"> The listener is in the incorrect state. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_ADDRESS_IN_USE</b></dt> </dl> </td> <td width="60%"> The address is
///    already being used. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_ADDRESS_NOT_AVAILABLE</b></dt> </dl> </td>
///    <td width="60%"> The address is not valid for this context. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_QUOTA_EXCEEDED</b></dt> </dl> </td> <td width="60%"> A quota was exceeded. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>WS_E_OPERATION_ABORTED</b></dt> </dl> </td> <td width="60%"> The operation was aborted.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_OPERATION_TIMED_OUT</b></dt> </dl> </td> <td width="60%"> The
///    operation did not complete within the time allotted. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Ran out of memory. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b> Other Errors </b></dt> </dl> </td> <td width="60%"> This function may return
///    other errors not listed above. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsOpenListener(WS_LISTENER* listener, const(WS_STRING)* url, const(WS_ASYNC_CONTEXT)* asyncContext, 
                       WS_ERROR* error);

///Accepts the next incoming message from the specified listener.
///Params:
///    listener = Pointer to a WS_LISTENER structure representing the listener. This is the listener passed to
///               WsCreateChannelForListenerwhen the channel was created.
///    channel = Pointer to a WS_CHANNEL structure representing the channel to accept.
///    asyncContext = Pointer to a WS_ASYNC_CONTEXT data structure with information for invoking the function asynchronously. Pass a
///                   <b>NULL</b> value for a synchronous operation.
///    error = Pointer to a WS_ERROR structure that receives additional error information if the function fails.
///Returns:
///    If the function succeeds, it returns NO_ERROR; otherwise, it returns an HRESULT error code. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_S_ASYNC</b></dt> </dl> </td>
///    <td width="60%"> The asynchronous operation is still pending. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_OPERATION_ABORTED</b></dt> </dl> </td> <td width="60%"> The listener or channel was aborted. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_OBJECT_FAULTED</b></dt> </dl> </td> <td width="60%"> The listener
///    has faulted. See the Remarks section. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_INVALID_OPERATION</b></dt> </dl> </td> <td width="60%"> The listener or the channel or both were in
///    an inappropriate state. See the Remarks section. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_ENDPOINT_DISCONNECTED</b></dt> </dl> </td> <td width="60%"> The connection with the remote endpoint
///    was terminated. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_OPERATION_TIMED_OUT</b></dt> </dl> </td> <td
///    width="60%"> The operation did not complete within the time allotted. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_QUOTA_EXCEEDED</b></dt> </dl> </td> <td width="60%"> A quota was exceeded. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl> </td> <td width="60%"> The input data was not in the
///    expected format or did not have the expected value. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory to complete the operation. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments
///    are not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_SECURITY_VERIFICATION_FAILURE</b></dt> </dl>
///    </td> <td width="60%"> Security verification was not successful for the received data. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>WS_E_SECURITY_SYSTEM_FAILURE</b></dt> </dl> </td> <td width="60%"> A security operation
///    failed in the Windows Web Services framework. </td> </tr> <tr> <td width="40%"> <dl> <dt><b> Other Errors
///    </b></dt> </dl> </td> <td width="60%"> This function may return other errors not listed above. </td> </tr>
///    </table>
///    
@DllImport("webservices")
HRESULT WsAcceptChannel(WS_LISTENER* listener, WS_CHANNEL* channel, const(WS_ASYNC_CONTEXT)* asyncContext, 
                        WS_ERROR* error);

///Causes the specified listener to stop listening.
///Params:
///    listener = Pointer to a WS_LISTENER structure representing the listener to close.
///    asyncContext = Pointer to a WS_ASYNC_CONTEXT structure containing information for invoking the function asynchronously. Pass
///                   <b>NULL</b> to invoke the function synchronously.
///    error = Pointer to a WS_ERROR structure that receives additional error information if the function fails.
///Returns:
///    If the function succeeds, it returns NO_ERROR; otherwise, it returns an HRESULT error code. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_S_ASYNC</b></dt> </dl> </td>
///    <td width="60%"> The asynchronous operation is still pending. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_OPERATION_ABORTED</b></dt> </dl> </td> <td width="60%"> The close was aborted by a call to
///    WsAbortListener as the listener was closing. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_INVALID_OPERATION</b></dt> </dl> </td> <td width="60%"> The listener was in an inappropriate state.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_OPERATION_TIMED_OUT</b></dt> </dl> </td> <td width="60%"> The
///    operation did not complete within the time allotted. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are invalid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b> Other Errors </b></dt> </dl> </td> <td width="60%"> This function may return other
///    errors not listed above. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsCloseListener(WS_LISTENER* listener, const(WS_ASYNC_CONTEXT)* asyncContext, WS_ERROR* error);

///Cancels any pending I/O for the specified listener.
///Params:
///    listener = Pointer to a WS_LISTENER structure representing the listener for which to cancel I/O.
///    error = Pointer to a WS_ERROR structure that receives additional error information if the function fails.
///Returns:
///    If the function succeeds, it returns NO_ERROR; otherwise, it returns an HRESULT error code.
///    
@DllImport("webservices")
HRESULT WsAbortListener(WS_LISTENER* listener, WS_ERROR* error);

///Resets a Listener object so it can be reused. Use of this function requires that the Listener state be set to
///<b>WS_LISTENER_STATE_CREATED</b> or <b>WS_LISTENER_STATE_CLOSED</b>.
///Params:
///    listener = A pointer to the <b>Listener</b> object to reset. The pointer must reference a valid WS_LISTENER.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>WS_E_INVALID_OPERATION</b></dt> </dl> </td> <td width="60%"> The listener was in an
///    inappropriate state. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsResetListener(WS_LISTENER* listener, WS_ERROR* error);

///Releases the memory resource associated with a Listener object. The Listener state represented in WS_LISTENER_STATE
///must be set to either <b>WS_LISTENER_STATE_CREATED</b> or <b>WS_LISTENER_STATE_CLOSED</b> to be released. If a
///Listener has been successfully opened, then it must be closed using WsCloseListener before it is released.
@DllImport("webservices")
void WsFreeListener(WS_LISTENER* listener);

///Retrieves a specified Listener object property. The property to retrieve is identified by a WS_LISTENER_PROPERTY_ID
///input parameter.
///Params:
///    listener = A pointer to the Listener object containing the desired property. This must be a valid WS_LISTENER that was
///               returned from WsCreateListener.
///    id = This is a <b>WS_LISTENER_PROPERTY_ID</b> enumerator value that identifies the desired property.
///    value = A reference to a location for storing the retrieved property value. The pointer must have an alignment compatible
///            with the type of the property.
///    valueSize = Represents the byte-length buffer size allocated by the caller to store the retrieved property value.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
@DllImport("webservices")
HRESULT WsGetListenerProperty(WS_LISTENER* listener, WS_LISTENER_PROPERTY_ID id, void* value, uint valueSize, 
                              WS_ERROR* error);

///Sets a Listenerobject property.
///Params:
///    listener = A pointer to the <b>Listener</b> object with the property to set. The pointer must reference a valid WS_LISTENER
///               and may not be <b>NULL</b>.
///    id = Identifier of the property to set.
///    value = A void pointer to the property value to set. The pointer must have an alignment compatible with the type of the
///            property.
///    valueSize = The size in bytes of the property value.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
@DllImport("webservices")
HRESULT WsSetListenerProperty(WS_LISTENER* listener, WS_LISTENER_PROPERTY_ID id, const(void)* value, 
                              uint valueSize, WS_ERROR* error);

///Creates a channel associated with a specified listener.
///Params:
///    listener = Pointer to a WS_LISTENER structure representing the listener for which to create a channel. The listener can be
///               in any state. (For listener states, see the WS_LISTENER_STATE enumeration.)
///    properties = An array of WS_CHANNEL_PROPERTY structures containing optional values for channel initialization. This can be a
///                 <b>NULL</b>, in which case, the <i>propertyCount</i> parameter must be 0 (zero). For information on creating a
///                 custom channel, see the Remarks section.
///    propertyCount = The number of properties in the <i>properties</i> array.
///    channel = On success, a pointer that receives the address of the created channel. When the channel is no longer needed, you
///              must free it by calling WsFreeChannel.
///    error = Pointer to a WS_ERROR structure that receives additional error information if the function fails.
///Returns:
///    If the function succeeds, it returns NO_ERROR; otherwise, it returns an HRESULT error code. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
///    </td> <td width="60%"> One or more arguments are invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory to complete the operation. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b> Other Errors </b></dt> </dl> </td> <td width="60%"> This function may
///    return other errors not listed above. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsCreateChannelForListener(WS_LISTENER* listener, const(WS_CHANNEL_PROPERTY)* properties, 
                                   uint propertyCount, WS_CHANNEL** channel, WS_ERROR* error);

///Creates a message object with the specified properties.
///Params:
///    envelopeVersion = A WS_ENVELOPE_VERSION enumeration value that specifies the version of the envelope for the message.
///    addressingVersion = A WS_ADDRESSING_VERSION that specifies the version of the addressing for the message.
///    properties = An array of optional properties for the message. See WS_MESSAGE_PROPERTY. The value of this parameter may be
///                 <b>NULL</b>, in which case, the <i>propertyCount</i> parameter must be 0 (zero).
///    propertyCount = The number of properties in the <i>properties</i> array.
///    message = On success, a pointer that receives the address of a WS_MESSAGE structure representing the new message. When you
///              no longer need this structure, you must free it by calling WsFreeMessage.
///    error = Pointer to a WS_ERROR structure that receives additional error information if the function fails.
///Returns:
///    If the function succeeds, it returns NO_ERROR; otherwise, it returns an HRESULT error code. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl>
///    </td> <td width="60%"> Insufficient memory to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are invalid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b> Other Errors </b></dt> </dl> </td> <td width="60%"> This function may return other
///    errors not listed above. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsCreateMessage(WS_ENVELOPE_VERSION envelopeVersion, WS_ADDRESSING_VERSION addressingVersion, 
                        const(WS_MESSAGE_PROPERTY)* properties, uint propertyCount, WS_MESSAGE** message, 
                        WS_ERROR* error);

///Creates a message for use with a specified channel.
///Params:
///    channel = Pointer to a WS_CHANNEL structure representing the channel for the message.
///    properties = An array of optional properties for the message. See WS_MESSAGE_PROPERTY. The value of this parameter may be
///                 <b>NULL</b>, in which case, the <i>propertyCount</i> parameter must be 0 (zero).
///    propertyCount = The number of properties in the <i>properties</i> array.
///    message = On success, a pointer that receives the address of the WS_MESSAGE structure representing the new message. When
///              you no longer need this structure, you must free it by calling WsFreeMessage.
///    error = Pointer to a WS_ERROR structure that receives additional error information if the function fails.
///Returns:
///    If the function succeeds, it returns NO_ERROR; otherwise, it returns an HRESULT error code. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl>
///    </td> <td width="60%"> Insufficient memory to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are invalid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b> Other Errors </b></dt> </dl> </td> <td width="60%"> This function may return other
///    errors not listed above. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsCreateMessageForChannel(WS_CHANNEL* channel, const(WS_MESSAGE_PROPERTY)* properties, uint propertyCount, 
                                  WS_MESSAGE** message, WS_ERROR* error);

///This function initializes the headers for the message in preparation for processing. After a message has been
///initialized an application can add additional headers. On success the message is in WS_MESSAGE_STATE_INITIALIZED
///state. If the function fails, then no state transitions occurs.
///Params:
///    message = A pointer to the Message object to initialize. The Message must be a valid WS_MESSAGE object instance returned by
///              WsCreateMessage or WsCreateMessageForChannel and may not be NULL.
///    initialization = Defines the Message initialization. <div class="alert"><b>Note</b> If the <i>initialization</i> value is set to
///                     <b>WS_REPLY_MESSAGE</b> or <b>WS_FAULT_MESSAGE</b> the message is automatically addressed. </div> <div> </div>
///    sourceMessage = A pointer to a message object that is used to initialize the <i>message</i> parameter. This value should be NULL
///                    unless the initialization parameter has the value of <b>WS_DUPLICATE_MESSAGE</b>, <b>WS_REPLY_MESSAGE</b>, or
///                    <b>WS_FAULT_MESSAGE</b>.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Ran out of memory. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b> Other Errors </b></dt> </dl> </td> <td width="60%"> This
///    function may return other errors not listed above. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsInitializeMessage(WS_MESSAGE* message, WS_MESSAGE_INITIALIZATION initialization, 
                            WS_MESSAGE* sourceMessage, WS_ERROR* error);

///Sets the Message state back to <b>WS_MESSAGE_STATE_EMPTY</b>. In this state the Message object can be reused.
///Params:
///    message = A pointer to the Message object to reset.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are
///    invalid. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsResetMessage(WS_MESSAGE* message, WS_ERROR* error);

///Releases the memory resource associated with a Message object.
@DllImport("webservices")
void WsFreeMessage(WS_MESSAGE* message);

///This function populates a ULONG parameter with the WS_HEADER_ATTRIBUTES from the header element on which the reader
///is positioned. The envelope version of the message is used to determine which attributes to return.
///Params:
///    message = A pointer to a WS_MESSAGE structure containing the message to query. This envelope version of the message is used
///              to determine which attributes match. The message can be in any state except WS_MESSAGE_STATE_EMPTY.
///    reader = A pointer to the reader to query. This must be valid WS_XML_READER object returned from WsCreateReader and cannot
///             be <b>NULL</b>.
///    headerAttributes = On success the value referenced by this pointer is set to the header attributes.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Ran out of memory. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl> </td> <td width="60%">
///    The input data was not in the expected format or did not have the expected value. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b> Other Errors </b></dt> </dl> </td> <td width="60%"> This function may return other
///    errors not listed above. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsGetHeaderAttributes(WS_MESSAGE* message, WS_XML_READER* reader, uint* headerAttributes, WS_ERROR* error);

///Finds a particular standard header in the message and deserializes it.
///Params:
///    message = The message containing the header. The message can be in any state but WS_MESSAGE_STATE_EMPTY.
///    headerType = The type of header to deserialize.
///    valueType = The type of value to deserialize. See WS_HEADER_TYPE for the set of types which correspond to each type of
///                header.
///    readOption = Whether the value is required, and how to allocate the value. WS_READ_NILLABLE_VALUE and
///                 <b>WS_READ_NILLABLE_POINTER</b> read options cannot be specified since the header types in WS_HEADER_TYPE are not
///                 allowed to be nillable in the respective standards specifications. See <b>WS_READ_OPTION</b> for more
///                 information.
///    heap = The heap to store the deserialized header data in. If this is <b>NULL</b>, then the message heap will be used.
///    value = The interpretation of this parameter depends on the WS_READ_OPTION.
///    valueSize = The interpretation of this parameter depends on the WS_READ_OPTION.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl> </td> <td width="60%"> The header does not exist,
///    and is required. There are multiple instances of the type of header present in the message. The input data was
///    not in the expected format. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_QUOTA_EXCEEDED</b></dt> </dl>
///    </td> <td width="60%"> There size quota of the heap was exceeded. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There was not enough memory available to deserialize
///    the header. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One
///    or more of the parameters are incorrect. </td> </tr> <tr> <td width="40%"> <dl> <dt><b> Other Errors </b></dt>
///    </dl> </td> <td width="60%"> This function may return other errors not listed above. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsGetHeader(WS_MESSAGE* message, WS_HEADER_TYPE headerType, WS_TYPE valueType, WS_READ_OPTION readOption, 
                    WS_HEAP* heap, void* value, uint valueSize, WS_ERROR* error);

///Finds an application-defined header of the message and deserializes it.
///Params:
///    message = The message containing the header. The message can be in any state but WS_MESSAGE_STATE_EMPTY.
///    customHeaderDescription = A WS_ELEMENT_DESCRIPTION which describes the header element.
///    repeatingOption = Whether the header may appear more than once in the message. If WS_REPEATING_HEADER is used, then the header
///                      index indicates which of the headers with the specified headerName to return. If WS_SINGLETON_HEADER is used,
///                      then the headerIndex must be zero.
///    headerIndex = The zero-based index of the header within the set of headers with the specified headerName.
///    readOption = Whether the value is required, and how to allocate the value. See WS_READ_OPTION for more information.
///    heap = The heap to store the deserialized header data in. If this is <b>NULL</b>, then the message heap will be used as
///           required by the WS_READ_OPTION.
///    value = The interpretation of this parameter depends on the WS_READ_OPTION.
///    valueSize = The interpretation of this parameter depends on the WS_READ_OPTION.
///    headerAttributes = Returns the WS_HEADER_ATTRIBUTES for this header. The pointer may be <b>NULL</b>, in which case no attributes are
///                       returned.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl> </td> <td width="60%"> The header does not exist,
///    and is required. WS_SINGLETON_HEADER was specified, and there are multiple instances of the type of header
///    present in the message. The input data was not in the expected format. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_QUOTA_EXCEEDED</b></dt> </dl> </td> <td width="60%"> There size quota of the heap was exceeded. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There was not enough
///    memory available to deserialize the header. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt>
///    </dl> </td> <td width="60%"> One or more of the parameters are incorrect. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b> Other Errors </b></dt> </dl> </td> <td width="60%"> This function may return other errors not listed
///    above. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsGetCustomHeader(WS_MESSAGE* message, const(WS_ELEMENT_DESCRIPTION)* customHeaderDescription, 
                          WS_REPEATING_HEADER_OPTION repeatingOption, uint headerIndex, WS_READ_OPTION readOption, 
                          WS_HEAP* heap, void* value, uint valueSize, uint* headerAttributes, WS_ERROR* error);

///Removes the standard WS_HEADER_TYPE object from a message. The function is designed to handle types of headers that
///appear once in the message and are targeted at the ultimate receiver. Headers targeted with a role other than
///ultimate receiver are ignored. For application-defined header types use the WsRemoveCustomHeader function.
///Params:
///    message = A pointer to the <b>Message</b> object with the header to be removed. The message can be in any state except
///              <b>WS_MESSAGE_STATE_EMPTY</b>.
///    headerType = Indicates the type of header to be removed.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl> </td> <td width="60%"> There are multiple
///    instances of the type of header present in the message. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more of the parameters are incorrect. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b> Other Errors </b></dt> </dl> </td> <td width="60%"> This function may
///    return other errors not listed above. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsRemoveHeader(WS_MESSAGE* message, WS_HEADER_TYPE headerType, WS_ERROR* error);

///Adds or replaces the specified standard header in the message.
///Params:
///    message = The message to set the header in. The message can be in any state but WS_MESSAGE_STATE_EMPTY.
///    headerType = The type of header to serialize.
///    valueType = The type of the value to serialize. See WS_HEADER_TYPE for the set of types supported for each type of header.
///    writeOption = Whether the header element is required, and how the value is allocated. WS_WRITE_NILLABLE_VALUE and
///                  <b>WS_WRITE_NILLABLE_POINTER</b> write options cannot be specified since the header types in WS_HEADER_TYPE are
///                  not allowed to be nillable in the respective standards specifications. See <b>WS_WRITE_OPTION</b> for more
///                  information.
///    value = The header value to serialize. See WS_WRITE_OPTION for more information.
///    valueSize = The size of the value being serialized, in bytes.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl> </td> <td width="60%"> There are multiple
///    instances of the type of header present in the message. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There was not enough memory available to serialize the
///    header. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or
///    more of the parameters are incorrect. </td> </tr> <tr> <td width="40%"> <dl> <dt><b> Other Errors </b></dt> </dl>
///    </td> <td width="60%"> This function may return other errors not listed above. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsSetHeader(WS_MESSAGE* message, WS_HEADER_TYPE headerType, WS_TYPE valueType, WS_WRITE_OPTION writeOption, 
                    const(void)* value, uint valueSize, WS_ERROR* error);

///Removes a custom header from the message. This function is designed to handle types of headers that appear once in
///the message and are targeted at the ultimate receiver. Headers targeted with a role other than ultimate receiver are
///ignored.
///Params:
///    message = A pointer to the <b>Message</b> object with the header to be removed. The message can be in any state except
///              <b>WS_MESSAGE_STATE_EMPTY</b>.
///    headerName = A pointer to the WS_XML_STRING object that references the "local name" of the header element to be removed.
///    headerNs = A pointer to the WS_XML_STRING object that references the namespace of the header element to be removed.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl> </td> <td width="60%"> There are multiple
///    instances of the type of header present in the message. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There was not enough memory available to serialize the
///    header. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or
///    more of the parameters are incorrect. </td> </tr> <tr> <td width="40%"> <dl> <dt><b> Other Errors </b></dt> </dl>
///    </td> <td width="60%"> This function may return other errors not listed above. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsRemoveCustomHeader(WS_MESSAGE* message, const(WS_XML_STRING)* headerName, const(WS_XML_STRING)* headerNs, 
                             WS_ERROR* error);

///Adds the specified application-defined header to the message.
///Params:
///    message = The message to which to add the header. The message can be in any state except <b>WS_MESSAGE_STATE_EMPTY</b> (see
///              the WS_MESSAGE_STATE enumeration..
///    headerDescription = The WS_ELEMENT_DESCRIPTION structure that describes the header.
///    writeOption = Whether the header element is required, and how the value is allocated. For more information, see the
///                  WS_WRITE_OPTION enumeration.
///    value = The header value to serialize. For more information, see the WS_WRITE_OPTION enumeration.
///    valueSize = The size of the value being serialized, in bytes.
///    headerAttributes = The values of the SOAP attributes for the header.
///    error = Pointer to a WS_ERROR structure that receives additional error information if the function fails.
///Returns:
///    If the function succeeds, it returns NO_ERROR; otherwise, it returns an HRESULT error code. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt>
///    </dl> </td> <td width="60%"> There are multiple instances of the same type of header present in the message.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient
///    memory to complete the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td>
///    <td width="60%"> One or more of the parameters are incorrect. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>
///    Other Errors </b></dt> </dl> </td> <td width="60%"> This function may return other errors not listed above. </td>
///    </tr> </table>
///    
@DllImport("webservices")
HRESULT WsAddCustomHeader(WS_MESSAGE* message, const(WS_ELEMENT_DESCRIPTION)* headerDescription, 
                          WS_WRITE_OPTION writeOption, const(void)* value, uint valueSize, uint headerAttributes, 
                          WS_ERROR* error);

///Adds a specified mapped header to the message.
///Params:
///    message = Pointer to a WS_MESSAGE structure representing the message to to which to add the mapped header. The message can
///              be in any state except <b>WS_MESSAGE_STATE_EMPTY</b> (see the WS_MESSAGE_STATE enumeration.
///    headerName = Pointer to a WS_XML_STRING containing the name of the header.
///    valueType = The type of header value to deserialize. For possible types and the corresponding headers, see the WS_HEADER_TYPE
///    writeOption = Whether the header is required, and how the value is allocated. For more information, see the WS_WRITE_OPTION
///                  enumeration.
///    value = The header value to serialize. For more information, see the WS_WRITE_OPTION enumeration.
///    valueSize = The size of the value being serialized, in bytes.
///    error = Pointer to a WS_ERROR structure that receives additional error information if the function fails.
///Returns:
///    If the function succeeds, it returns NO_ERROR; otherwise, it returns an HRESULT error code. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl>
///    </td> <td width="60%"> Insufficient memory to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more of the parameters are incorrect. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b> Other Errors </b></dt> </dl> </td> <td width="60%"> This function may
///    return other errors not listed above. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsAddMappedHeader(WS_MESSAGE* message, const(WS_XML_STRING)* headerName, WS_TYPE valueType, 
                          WS_WRITE_OPTION writeOption, const(void)* value, uint valueSize, WS_ERROR* error);

///Removes all instances of a mapped header from the message.
///Params:
///    message = The message to set the header in. The message can be in any state but WS_MESSAGE_STATE_EMPTY.
///    headerName = The name of the mapped header to remove.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more of the parameters are
///    incorrect. </td> </tr> <tr> <td width="40%"> <dl> <dt><b> Other Errors </b></dt> </dl> </td> <td width="60%">
///    This function may return other errors not listed above. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsRemoveMappedHeader(WS_MESSAGE* message, const(WS_XML_STRING)* headerName, WS_ERROR* error);

///Finds a mapped header in the message and deserializes it.
///Params:
///    message = The message containing the header. The message can be in any state but WS_MESSAGE_STATE_EMPTY.
///    headerName = The name of the mapped header.
///    repeatingOption = Whether the header may appear more than once in the message. If WS_REPEATING_HEADER is used, then the header
///                      index indicates which of the headers with the specified headerName to return. If WS_SINGLETON_HEADER is used,
///                      then the headerIndex must be zero.
///    headerIndex = The zero-based index of the header within the set of headers with the specified headerName.
///    valueType = The type of value to deserialize.
///    readOption = Whether the value is required, and how to allocate the value. See WS_READ_OPTION for more information. If the
///                 header is optional (may appear zero or one times), then WS_READ_OPTIONAL_POINTER can be used.
///    heap = The heap to store the deserialized header data in. If this is <b>NULL</b>, then the message heap will be used.
///    value = The interpretation of this parameter depends on the WS_READ_OPTION.
///    valueSize = The interpretation of this parameter depends on the WS_READ_OPTION.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl> </td> <td width="60%"> The header does not exist,
///    and is required. The input data was not in the expected format. WS_SINGLETON_HEADER was specified, and there are
///    multiple instances of the header with the specified name in the message. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_QUOTA_EXCEEDED</b></dt> </dl> </td> <td width="60%"> There size quota of the heap was exceeded. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There was not enough
///    memory available to deserialize the header. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt>
///    </dl> </td> <td width="60%"> One or more of the parameters are incorrect. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b> Other Errors </b></dt> </dl> </td> <td width="60%"> This function may return other errors not listed
///    above. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsGetMappedHeader(WS_MESSAGE* message, const(WS_XML_STRING)* headerName, 
                          WS_REPEATING_HEADER_OPTION repeatingOption, uint headerIndex, WS_TYPE valueType, 
                          WS_READ_OPTION readOption, WS_HEAP* heap, void* value, uint valueSize, WS_ERROR* error);

///Writes a value in the body of a message. This is a helper function that serializes a value to the XML Writer of the
///message. The message state must be set to <b>WS_MESSAGE_STATE_WRITING</b>. This function does not cause any state
///transitions.
///Params:
///    message = A pointer to the <b>Message</b> object for writing to. The pointer must reference a valid WS_MESSAGE object.
///    bodyDescription = A pointer to information describing how to write the value.
///    writeOption = Determines whether the value is required and how the value is allocated. <div class="alert"><b>Note</b> See
///                  WS_WRITE_OPTION for more information.</div> <div> </div>
///    value = A void pointer to the value to write.
///    valueSize = The size in bytes of the value to write. If the value is <b>NULL</b> the size should be 0.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl> </td> <td width="60%"> The input data was not in
///    the expected format or did not have the expected value. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Ran out of memory. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b> Other Errors </b></dt> </dl> </td> <td width="60%"> This function may return
///    other errors not listed above. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsWriteBody(WS_MESSAGE* message, const(WS_ELEMENT_DESCRIPTION)* bodyDescription, 
                    WS_WRITE_OPTION writeOption, const(void)* value, uint valueSize, WS_ERROR* error);

///This is a helper function that deserializes a value from the XML Readerof the message. The WS_MESSAGE_STATE must be
///set to <b>WS_MESSAGE_STATE_READING</b>. This function does not cause any state transitions.
///Params:
///    message = A pointer to the <b>Message</b> object to read the body from. The pointer must reference a valid WS_MESSAGE
///              object.
///    bodyDescription = A pointer to the object encapsulating the metadata that describes the mapping of the value to an element.
///    readOption = Determines whether the value is required and how to allocate the value. See WS_READ_OPTION for more information.
///    heap = A pointer to the <b>Heap</b> object to read the element into. The pointer must reference a valid WS_HEAP object.
///    value = The interpretation of the data referenced by this parameter depends on the <b>WS_READ_OPTION</b>.
///    valueSize = The interpretation of the value of this parameter depends on the <b>WS_READ_OPTION</b>.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl> </td> <td width="60%"> The input data was not in
///    the expected format or did not have the expected value. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Ran out of memory. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b> Other Errors </b></dt> </dl> </td> <td width="60%"> This function may return
///    other errors not listed above. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsReadBody(WS_MESSAGE* message, const(WS_ELEMENT_DESCRIPTION)* bodyDescription, WS_READ_OPTION readOption, 
                   WS_HEAP* heap, void* value, uint valueSize, WS_ERROR* error);

///Writes the start of the message including the current set of headers of the message and prepares to write the body
///elementss. This function is designed for writing messages to destinations other than channels. To write a message to
///a channel use WsWriteMessageStart.
///Params:
///    message = A pointer to the <b>Message</b> object to write. The pointer must reference a valid WS_MESSAGE object.
///    writer = A pointer to the <b>XML Writer</b> object to write the Message. The Message object uses the Writer in subsequent
///             calls to write the message. The caller must keep the writer valid until WsResetMessage or WsFreeMessage is
///             called. The WS_MESSAGE_DONE_CALLBACK parameter can be used to determine that the WS_XML_WRITER is no longer in
///             use.
///    doneCallback = The callback function invoked when the Message is released or reset. This callback can be used to indicate that
///                   the WS_XML_WRITER object is no longer in use by this message. If this function fails the callback is not called.
///                   If the function succeeds the callback is invoked one time only.
///    doneCallbackState = A void pointer to a user-defined state that will be passed to the specified callback. This parameter may be
///                        <b>NULL</b>.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl> </td> <td width="60%"> The input data was not in
///    the expected format or did not have the expected value. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Ran out of memory. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b> Other Errors </b></dt> </dl> </td> <td width="60%"> This function may return
///    other errors not listed above. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsWriteEnvelopeStart(WS_MESSAGE* message, WS_XML_WRITER* writer, WS_MESSAGE_DONE_CALLBACK doneCallback, 
                             void* doneCallbackState, WS_ERROR* error);

///Writes the closing elements of a message. This function writes the end of the message including the element that
///closes the body tag and the envelope tag. Use this function when writing messages to destinations other than
///channels. With channels use WsWriteMessageEnd
///Params:
///    message = A pointer to the <b>Message</b> object to write. The pointer must reference a valid WS_MESSAGE object.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl> </td> <td width="60%"> The input data was not in
///    the expected format or did not have the expected value. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Ran out of memory. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b> Other Errors </b></dt> </dl> </td> <td width="60%"> This function may return
///    other errors not listed above. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsWriteEnvelopeEnd(WS_MESSAGE* message, WS_ERROR* error);

///Reads the headers of the message and prepare to read the body elements. The operation reads the start of the next
///message from the Reader including the headers of the message. The process allows for reading of messages from other
///sources than channels. To read a message using a channel, use WsReadMessageStart. <div class="alert"><b>Note</b> On
///success the headers is stored in the message and can be retrieved randomly using functions such as WsGetHeader or
///WsGetCustomHeader.</div> <div> </div>
///Params:
///    message = A pointer to the <b>Message</b> object to read. The pointer must reference a valid WS_MESSAGE object.
///    reader = A pointer to the Reader with the message to read. The Message object uses the Reader in the current and
///             subsequent calls. <div class="alert"><b>Note</b> The function caller must keep the Reader valid until
///             WsResetMessage or WsFreeMessage is called. The WS_MESSAGE_DONE_CALLBACK parameter can be used a way to know that
///             the WS_XML_READER is no longer in use. </div> <div> </div>
///    doneCallback = Identifies the callback function to initiate on success of the current operation once the message has been
///                   released. <div class="alert"><b>Note</b> Messages are released using WsFreeMessage or WsResetMessage </div> <div>
///                   </div> The callback can be used to discover whether the WS_XML_READER instance is in use by this message. If the
///                   current operation fails the callback is not called.
///    doneCallbackState = A pointer to user-defined state that can be passed to the WS_MESSAGE_DONE_CALLBACK. This parameter may be
///                        <b>NULL</b> if the callback is not used.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl> </td> <td width="60%"> The input data was not in
///    the expected format or did not have the expected value. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Ran out of memory. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b> Other Errors </b></dt> </dl> </td> <td width="60%"> This function may return
///    other errors not listed above. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsReadEnvelopeStart(WS_MESSAGE* message, WS_XML_READER* reader, WS_MESSAGE_DONE_CALLBACK doneCallback, 
                            void* doneCallbackState, WS_ERROR* error);

///Reads the closing elements of a message. The operation allows for reading of messages from sources other than
///Channels. If the source is a Channel use WsReadMessageEnd.
///Params:
///    message = A pointer to the <b>Message</b> object read. The pointer must reference a valid WS_MESSAGE.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl> </td> <td width="60%"> The input data was not in
///    the expected format or did not have the expected value. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Ran out of memory. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b> Other Errors </b></dt> </dl> </td> <td width="60%"> This function may return
///    other errors not listed above. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsReadEnvelopeEnd(WS_MESSAGE* message, WS_ERROR* error);

///Retrieves a specified Message object property. The property to retrieve is identified by a WS_MESSAGE_PROPERTY_ID
///input parameter.
///Params:
///    message = A pointer to a <b>Message</b> object containing the desired property. This parameter must be a valid WS_LISTENER
///              object.
///    id = This is a <b>WS_MESSAGE_PROPERTY_ID</b> enumerator value that identifies the desired property.
///    value = A reference to a location for storing the retrieved property value. The pointer must have an alignment compatible
///            with the type of the property.
///    valueSize = The byte-length buffer size allocated by the caller to store the retrieved property value.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
@DllImport("webservices")
HRESULT WsGetMessageProperty(WS_MESSAGE* message, WS_MESSAGE_PROPERTY_ID id, void* value, uint valueSize, 
                             WS_ERROR* error);

///This operation sets a Messageproperty.
///Params:
///    message = A pointer to the <b>Message</b> object with the property to set. The pointer must reference a valid WS_MESSAGE
///              object and the referenced value may not be <b>NULL</b>.
///    id = The identifier of the property to set.
///    value = A pointer to the property value to set. The pointer must have an alignment compatible with the type of the
///            property.
///    valueSize = The size in bytes of the property value.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
@DllImport("webservices")
HRESULT WsSetMessageProperty(WS_MESSAGE* message, WS_MESSAGE_PROPERTY_ID id, const(void)* value, uint valueSize, 
                             WS_ERROR* error);

///Addresses a message to a specified endpoint address.
///Params:
///    message = Pointer to a WS_MESSAGE structure respresenting the message to be addressed.
///    address = Pointer to a WS_ENDPOINT_ADDRESS structure containing the endpoint to which to address the message. <div
///              class="alert"><b>Note</b> Passing <b>NULL</b> to this parameter indicates that no headers are added to the
///              message. This provides a way to set the WS_MESSAGE_PROPERTY_ID to <b>WS_MESSAGE_PROPERTY_IS_ADDRESSED</b> without
///              modifying the set of headers in the message. </div> <div> </div>
///    error = Pointer to a WS_ERROR structure that receives additional error information if the function fails.
///Returns:
///    If the function succeeds, it returns NO_ERROR; otherwise, it returns an HRESULT error code. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_OPERATION</b></dt>
///    </dl> </td> <td width="60%"> The message has already been addressed. (The <b>WS_MESSAGE_PROPERTY_IS_ADDRESSED</b>
///    property indicates whether a message has already been addressed.) </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are not valid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl> </td> <td width="60%"> The input data was not in
///    the expected format or did not have the expected value. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory to complete the operation. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b> Other Errors </b></dt> </dl> </td> <td width="60%"> This function can
///    return other errors not listed above. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsAddressMessage(WS_MESSAGE* message, const(WS_ENDPOINT_ADDRESS)* address, WS_ERROR* error);

///Verifies that the specified headers were understood by the receiver. <div class="alert"><b>Note</b> This function
///should be called after all headers have been read for a received message. </div> <div> </div>
///Params:
///    message = Pointer to the WS_MESSAGE structure containing the headers to be understood.
///    error = Pointer to a WS_ERROR structure where additional error information is stored if the function fails.
///Returns:
///    If the function succeeds, it returns NO_ERROR; otherwise, it returns an HRESULT error code. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_OPERATION</b></dt>
///    </dl> </td> <td width="60%"> The message is not in the correct state. For more information, see the Remarks
///    section. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl> </td> <td width="60%">
///    The validation failed, or the message was not correctly formed. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are invalid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory to complete the
///    operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b> Other Errors </b></dt> </dl> </td> <td width="60%">
///    This function may return other errors not listed above. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsCheckMustUnderstandHeaders(WS_MESSAGE* message, WS_ERROR* error);

///This function marks a header as "understood" by the application. The set of headers is extensible and Message
///assimilation by the receiver is not accessible by the sender. This function is the receiving applications method for
///making it known to the sender that the received header has been read and understood. <div class="alert"><b>Note</b>
///This function should be used only if the application receives a message indicating that the header must be understood
///and it did not acquire the header using WsGetHeaderor WsGetCustomHeader. The WS_MESSAGE_STATE must be in the set to
///<b>WS_MESSAGE_STATE_READING</b>. See .WsCheckMustUnderstandHeaders for more information.</div><div> </div>
///Params:
///    message = A pointer to the Message object with the header to mark.
///    headerPosition = A pointer to the position of the header element within the XML header segment.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>WS_E_INVALID_OPERATION</b></dt> </dl> </td> <td width="60%"> The message is not in
///    the correct state. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
///    width="60%"> One or more arguments are invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Ran out of memory. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b> Other Errors </b></dt> </dl> </td> <td width="60%"> This function may return other errors not listed
///    above. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsMarkHeaderAsUnderstood(WS_MESSAGE* message, const(WS_XML_NODE_POSITION)* headerPosition, WS_ERROR* error);

///Ensures that there are a sufficient number of bytes available in a message for reading. It is up to the application
///to specify the number of bytes sufficient to contain the next XML construct to read. <div class="alert"><b>Note</b>
///This function is called before using WsReadBody or the XML Readerof the message to read the message body. </div>
///<div> </div> This function is a shortcut for calling WsFillReader for the XML Reader being used to write the message.
///Calling <b>WsFillReader</b> directly is equivalent to calling this function.
///Params:
///    message = A pointer to the WS_MESSAGE structure intended for "filling".
///    minSize = The minimum number of bytes that the message should have buffered. If the current byte count buffered is equal to
///              or greater than the value of <i>minSize</i> the function does nothing. <div class="alert"><b>Note</b> The value
///              of <i>minSize</i> represents the size of the encoded form of the XML that is expected. This can vary by encoding
///              and also how the actual XML is structured. Typical use of this function is to select an expected upper bound byte
///              count for encoding or XML structure to ensure that the expected data is read. </div> <div> </div>
///    asyncContext = A pointer to a WS_ASYNC_CONTEXT data structure with information about invoking the function asynchronously. A
///                   <b>NULL</b> value indicates a request for synchronous operation.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Start of message was received
///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_S_ASYNC</b></dt> </dl> </td> <td width="60%"> The
///    asynchronous operation is still pending. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl> </td> <td width="60%"> The input data was not in the expected format or
///    did not have the expected value. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td>
///    <td width="60%"> One or more arguments are invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Ran out of memory. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b> Other Errors </b></dt> </dl> </td> <td width="60%"> This function may return other errors not listed
///    above. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsFillBody(WS_MESSAGE* message, uint minSize, const(WS_ASYNC_CONTEXT)* asyncContext, WS_ERROR* error);

///Flushes all accumulated message body data that has been written. When message uses WsWriteBody or XML Writerthe data
///is accumulated in a buffer. WsFlushBody subsequently performs the actual I/O. WsFlushBody is typically used when
///channel I/O is set to WS_STREAMED_OUTPUT_TRANSFER_MODE, or when using an XML Writer set to use
///WS_XML_WRITER_STREAM_OUTPUT.
///Params:
///    message = A pointer to the WS_MESSAGE structure containing the accumulated message body data.
///    minSize = Specifies the minimum number of bytes that must be present in the message for the function to perform the data
///              flush. <div class="alert"><b>Note</b> If the message contains less than <i>minSize</i> WSFlushBody terminates
///              without doing the I/O flush. A larger value will ensure that no I/O will be done until the larger value has been
///              accumulated. This is useful for ensuring that larger chunks are used when doing I/O. And presuming that there is
///              at least one byte of accumulated data a value of 0 in <i>minSize</i> guarantees that it will be flushed. </div>
///              <div> </div>
///    asyncContext = A pointer to a WS_ASYNC_CONTEXT data structure with information about invoking the function asynchronously. A
///                   <b>NULL</b> value indicates a request for synchronous operation.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>WS_S_ASYNC</b></dt> </dl> </td> <td width="60%"> The asynchronous operation is still
///    pending. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl> </td> <td width="60%">
///    The input data was not in the expected format or did not have the expected value. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are invalid.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Ran out of
///    memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b> Other Errors </b></dt> </dl> </td> <td width="60%"> This
///    function may return other errors not listed above. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsFlushBody(WS_MESSAGE* message, uint minSize, const(WS_ASYNC_CONTEXT)* asyncContext, WS_ERROR* error);

///Get a security token from a security token service (STS) that acts as the token issuer in a federation scenario. This
///function is used on the client side, and performs the WS-Trust based negotiation steps with the STS until the
///security token is obtained or the negotiation process fails.
///Params:
///    channel = The channel on which the negotiation to obtain the security token should take place. The supplied channel should
///              have been created with the appropriate WS_SECURITY_DESCRIPTION to meet the security requirements of the issuer,
///              and then opened to the WS_ENDPOINT_ADDRESS of the issuer. The caller is also responsible for closing and freeing
///              the channel after the completion of this function. Thus, the channel must be in state WS_CHANNEL_STATE_OPENwhen
///              this function is called. After a successful completion of this function, the channel will be in state
///              <b>WS_CHANNEL_STATE_OPEN</b>. After a failed completion, it will either be in state <b>WS_CHANNEL_STATE_OPEN</b>
///              or state <b>WS_CHANNEL_STATE_FAULTED</b>.
///    properties = An optional group of settings to be used in the negotiation process with the issuer.
///    propertyCount = The number of items in the properties array.
///    token = The XML security token obtained. This is set upon successful completion of the function call, and is unmodified
///            if any failure occurs during the execution of the function. The returned security token may be used with
///            WS_XML_TOKEN_MESSAGE_SECURITY_BINDING if it is to be presented to a service. The token must be freed using
///            WsFreeSecurityToken when it is no longer needed.
///    asyncContext = Information on how to invoke the function asynchronously, or <b>NULL</b> if invoking synchronously.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>WS_S_ASYNC</b></dt> </dl> </td> <td width="60%"> The asynchronous operation is still
///    pending. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsRequestSecurityToken(WS_CHANNEL* channel, const(WS_REQUEST_SECURITY_TOKEN_PROPERTY)* properties, 
                               uint propertyCount, WS_SECURITY_TOKEN** token, const(WS_ASYNC_CONTEXT)* asyncContext, 
                               WS_ERROR* error);

///Extracts a field or a property from a security token. If the queried property does not use the <i>heap</i> parameter,
///the returned data is owned by the security token and remains valid as long as the security token itself remains
///valid. Specifically, for security tokens extracted from a received message, the security token and fields extracted
///from it are valid only as long as the message is not reset or freed. If the <i>heap</i> parameter is required by the
///property, then the returned data is stored on the heap, with its lifetime detached from the underlying token.
///Params:
///    securityToken = The security token from which the property should be extracted.
///    id = The id of the property to retrieve.
///    value = The location to store the retrieved property. The pointer must have an alignment compatible with the type of the
///            property.
///    valueSize = The number of bytes allocated by the caller to store the retrieved property.
///    heap = Heap to store additional property data. This parameter must be non-<b>NULL</b> when the queried property is
///           WS_SECURITY_TOKEN_PROPERTY_SYMMETRIC_KEY and must be <b>NULL</b> otherwise.
///    error = Specifies where additional error information should be stored if the function fails.
@DllImport("webservices")
HRESULT WsGetSecurityTokenProperty(WS_SECURITY_TOKEN* securityToken, WS_SECURITY_TOKEN_PROPERTY_ID id, void* value, 
                                   uint valueSize, WS_HEAP* heap, WS_ERROR* error);

///Creates a security token from its specified XML form.
///Params:
///    tokenXml = Pointer to a WS_XML_BUFFER structure containing the security token in its XML form. The referenced buffer must
///               have exactly one top level XML element.
///    tokenKey = Pointer to a <b>SECURITY_KEY_HANDLE</b> structure that may or may not contain a cryptographic proof-of-possession
///               key. If present the key can be used to bind this security token to a message. If the value of the <i>tokenKey</i>
///               parameter is not <b>NULL</b>, the token is assumed to have a proof-of-possession key. If the value is
///               <b>NULL</b>, the structure is assumed to be a "bearer token" as defined below. <ul> <li> A bearer token also
///               called a basic or keyless token is serialized in a message to demonstrate the message's possession of the token,
///               and to indicate the intention to apply the claims from the token to that message. </li> <li> A
///               proof-of-possession token also called a PoP or cryptographic token has an associated cryptographic key which must
///               be used to "sign" a message in order to demonstrate possession of the token and to indicate the intention to
///               apply the claims from the token to that message. An example is an X.509 certificate: the message must be signed
///               with the private key of the certificate in order for a receiving principal to accept the message as carrying the
///               claims present in the certificate. </li> </ul>
///    properties = An array of WS_XML_SECURITY_TOKEN_PROPERTY structures containing optional properties for the XML security token.
///                 The value of this parameter may be <b>NULL</b>, in which case, the <i>propertyCount</i> parameter must be 0
///                 (zero).
///    propertyCount = The number of properties in the <i>properties</i> array.
///    token = On success, a pointer that receives the address of the WS_SECURITY_TOKEN structure representing the created XML
///            security token. When you no longer need this structure, you must free it by calling WsFreeSecurityToken. The
///            returned security token may be used with WS_XML_TOKEN_MESSAGE_SECURITY_BINDING if it is to be presented to a
///            service.
///    error = Pointer to a WS_ERROR structure that receives additional error information if the function fails.
@DllImport("webservices")
HRESULT WsCreateXmlSecurityToken(WS_XML_BUFFER* tokenXml, WS_SECURITY_KEY_HANDLE* tokenKey, 
                                 const(WS_XML_SECURITY_TOKEN_PROPERTY)* properties, uint propertyCount, 
                                 WS_SECURITY_TOKEN** token, WS_ERROR* error);

///Releases the memory resource associated with a <b>Security Token</b> object.
@DllImport("webservices")
void WsFreeSecurityToken(WS_SECURITY_TOKEN* token);

///Revokes a security context. Can only be called on the server side. Further requests using this security context will
///fail and a fault will be sent to the client. This function can be used when the server knows that no more messages
///are coming and does not want to wait for the client or the context timeouts to trigger the reclaiming of resources,
///or when the server wants to engage in active context management.
///Params:
///    securityContext = The security context to be revoked.
///    error = Specifies where additional error information should be stored if the function fails.
@DllImport("webservices")
HRESULT WsRevokeSecurityContext(WS_SECURITY_CONTEXT* securityContext, WS_ERROR* error);

///Gets a property of the specified security context.
///Params:
///    securityContext = The security context that is queried for its property.
///    id = The id of the property (one of WS_SECURITY_CONTEXT_PROPERTY_ID).
///    value = The address to place the retrieved value. The pointer must have an alignment compatible with the type of the
///            property.
///    valueSize = The size of the buffer that the caller has allocated for the retrieved value.
///    error = Specifies where additional error information should be stored if the function fails.
@DllImport("webservices")
HRESULT WsGetSecurityContextProperty(WS_SECURITY_CONTEXT* securityContext, WS_SECURITY_CONTEXT_PROPERTY_ID id, 
                                     void* value, uint valueSize, WS_ERROR* error);

///Read an element producing a value of the specified WS_TYPE.
///Params:
///    reader = The reader that is positioned on the XML to deserialize.
///    elementDescription = A pointer to a description of how to deserialize the element.
///    readOption = Whether the element is required, and how to allocate the value. See WS_READ_OPTION for more information.
///    heap = The heap to store the deserialized values in.
///    value = The interpretation of this parameter depends on the WS_READ_OPTION.
///    valueSize = The interpretation of this parameter depends on the WS_READ_OPTION.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl> </td> <td width="60%"> The input data was not in
///    the expected format or did not have the expected value. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Ran out of memory. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>WS_E_QUOTA_EXCEEDED</b></dt> </dl> </td> <td width="60%"> The size quota of the heap was exceeded.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more
///    arguments are invalid. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsReadElement(WS_XML_READER* reader, const(WS_ELEMENT_DESCRIPTION)* elementDescription, 
                      WS_READ_OPTION readOption, WS_HEAP* heap, void* value, uint valueSize, WS_ERROR* error);

///Read an attribute producing a value of the specified WS_TYPE.
///Params:
///    reader = The reader that is positioned on the element containing the attribute.
///    attributeDescription = A pointer to a description of how to deserialize the attribute.
///    readOption = Whether the attribute is required, and how to allocate the value. See WS_READ_OPTION for more information.
///    heap = The heap to store the deserialized values in.
///    value = The interpretation of this parameter depends on the WS_READ_OPTION.
///    valueSize = The interpretation of this parameter depends on the WS_READ_OPTION.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl> </td> <td width="60%"> The input data was not in
///    the expected format or did not have the expected value. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Ran out of memory. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>WS_E_QUOTA_EXCEEDED</b></dt> </dl> </td> <td width="60%"> The size quota of the heap was exceeded.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more
///    arguments are invalid. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsReadAttribute(WS_XML_READER* reader, const(WS_ATTRIBUTE_DESCRIPTION)* attributeDescription, 
                        WS_READ_OPTION readOption, WS_HEAP* heap, void* value, uint valueSize, WS_ERROR* error);

///Read a value of a given WS_TYPE from XML according to the WS_TYPE_MAPPING.
///Params:
///    reader = The reader that is positioned on the XML to deserialize.
///    typeMapping = Describes how the type maps to the XML that is being read.
///    type = The type of the value to deserialize.
///    typeDescription = Additional information about the type. Each type has a different description structure. This may be <b>NULL</b>,
///                      depending on the WS_TYPE.
///    readOption = Whether the value is required, and how to allocate the value. See WS_READ_OPTION for more information. This
///                 parameter must have one of the following values: <ul> <li> WS_READ_REQUIRED_VALUE. </li> <li>
///                 WS_READ_REQUIRED_POINTER. </li> </ul>
///    heap = The heap to store the deserialized values in.
///    value = The interpretation of this parameter depends on the WS_READ_OPTION.
///    valueSize = The interpretation of this parameter depends on the WS_READ_OPTION.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl> </td> <td width="60%"> The input data was not in
///    the expected format or did not have the expected value. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Ran out of memory. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>WS_E_QUOTA_EXCEEDED</b></dt> </dl> </td> <td width="60%"> The size quota of the heap was exceeded.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more
///    arguments are invalid. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsReadType(WS_XML_READER* reader, WS_TYPE_MAPPING typeMapping, WS_TYPE type, const(void)* typeDescription, 
                   WS_READ_OPTION readOption, WS_HEAP* heap, void* value, uint valueSize, WS_ERROR* error);

///Write a typed value as an XML element.
///Params:
///    writer = The writer to write the element to.
///    elementDescription = A pointer to a description of how to serialize the element.
///    writeOption = Information about how the value is allocated. See WS_WRITE_OPTION for more information.
///    value = A pointer to the value to serialize.
///    valueSize = The size of the value being serialized, in bytes. If the value is <b>NULL</b>, then the size should be 0.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl> </td> <td width="60%"> The input data was not in
///    the expected format or did not have the expected value. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are invalid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Ran out of memory. </td> </tr>
///    </table>
///    
@DllImport("webservices")
HRESULT WsWriteElement(WS_XML_WRITER* writer, const(WS_ELEMENT_DESCRIPTION)* elementDescription, 
                       WS_WRITE_OPTION writeOption, const(void)* value, uint valueSize, WS_ERROR* error);

///Write a typed value as an XML attribute.
///Params:
///    writer = The writer to write the attribute to.
///    attributeDescription = A pointer to a description of how to serialize the attribute.
///    writeOption = Information about how the value is allocated. See WS_WRITE_OPTION for more information.
///    value = A pointer to the value to serialize.
///    valueSize = The size of the value being serialized, in bytes. If the value is <b>NULL</b>, then the size should be 0.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl> </td> <td width="60%"> The input data was not in
///    the expected format or did not have the expected value. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are invalid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Ran out of memory. </td> </tr>
///    </table>
///    
@DllImport("webservices")
HRESULT WsWriteAttribute(WS_XML_WRITER* writer, const(WS_ATTRIBUTE_DESCRIPTION)* attributeDescription, 
                         WS_WRITE_OPTION writeOption, const(void)* value, uint valueSize, WS_ERROR* error);

///Write a value of a given WS_TYPE to XML according to the WS_TYPE_MAPPING.
///Params:
///    writer = The writer to write the value to.
///    typeMapping = Describes how the type maps to the XML that is being written.
///    type = The type of the value to serialize.
///    typeDescription = Additional information about the type. Each type has a different description structure. This may be <b>NULL</b>,
///                      depending on the WS_TYPE.
///    writeOption = Whether the value is required, and how the value is allocated. See WS_WRITE_OPTION for more information. This
///                  parameter must have one of the following values: <ul> <li> WS_WRITE_REQUIRED_VALUE. </li> <li>
///                  WS_WRITE_REQUIRED_POINTER. </li> </ul>
///    value = A pointer to the value to serialize.
///    valueSize = The size of the value being serialized.
///    error = Specifies where additional error information should be stored if the function fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl> </td> <td width="60%"> The input data was not in
///    the expected format or did not have the expected value. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are invalid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Ran out of memory. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b> Other Errors </b></dt> </dl> </td> <td width="60%"> This function may return other
///    errors not listed above. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsWriteType(WS_XML_WRITER* writer, WS_TYPE_MAPPING typeMapping, WS_TYPE type, const(void)* typeDescription, 
                    WS_WRITE_OPTION writeOption, const(void)* value, uint valueSize, WS_ERROR* error);

///A service operation can use this function to register for a cancel notification. It is only valid to call this API
///when the service operation is executing. The behavior for calling it after the completion of Service Operation is not
///supported. While this API is being called and the runtime has determined that the cancellation of the service
///operation is necessary, it can call the callback during the call to this API by the application. The caller should
///therefore assume that the runtime may call on the callback WS_OPERATION_CANCEL_CALLBACK as soon as the
///WsRegisterOperationForCancel is called.
///Params:
///    context = The context that the property value is being obtained for.
///    cancelCallback = Function pointer for cancel notification function.
///    freestateCallback = A optional parameter specifying the function pointer to the free state call.
///    userState = A optional parameter specifying the application specific state which can be used to identify call data.
///    error = Specifies where additional error information should be stored if the function fails.
@DllImport("webservices")
HRESULT WsRegisterOperationForCancel(const(WS_OPERATION_CONTEXT)* context, 
                                     WS_OPERATION_CANCEL_CALLBACK cancelCallback, 
                                     WS_OPERATION_FREE_STATE_CALLBACK freestateCallback, void* userState, 
                                     WS_ERROR* error);

///Retrieves a specified Service Host property. The property to retrieve is identified by a WS_SERVICE_PROPERTY_ID input
///parameter.
///Params:
///    serviceHost = A pointer to the WS_SERVICE_HOST object containing the property to retrieve.
///    id = This is a <b>WS_SERVICE_PROPERTY_ID</b> enumerator value that identifies the property to retrieve.
///    value = A void pointer to a location for storing the retrieved property value. The pointer must have an alignment
///            compatible with the type of the property.
///    valueSize = The byte-length buffer size allocated by the caller to store the retrieved property value.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
@DllImport("webservices")
HRESULT WsGetServiceHostProperty(WS_SERVICE_HOST* serviceHost, const(WS_SERVICE_PROPERTY_ID) id, void* value, 
                                 uint valueSize, WS_ERROR* error);

///Creates a service host for the specified endpoints.
///Params:
///    endpoints = An array of WS_SERVICE_ENDPOINT structures representing the service endpoints for which to create the service
///                host.
///    endpointCount = The number of endpoints in the <i>endpoints</i> array.
///    serviceProperties = An array of WS_SERVICE_PROPERTY structures containing optional properties for the service host. The value of this
///                        parameter may be <b>NULL</b>, in which case, the <i>servicePropertyCount</i> parameter must be 0 (zero).
///    servicePropertyCount = The number of properties in the <i>serviceProperties</i> array.
///    serviceHost = On success, a pointer that receives the address of the WS_SERVICE_HOST structure representing the new service
///                  host. When you no longer need this structure, you must free it by calling WsFreeServiceHost.
///    error = Pointer to a WS_ERROR structure that receives additional error information if the function fails.
@DllImport("webservices")
HRESULT WsCreateServiceHost(const(WS_SERVICE_ENDPOINT)** endpoints, const(ushort) endpointCount, 
                            const(WS_SERVICE_PROPERTY)* serviceProperties, uint servicePropertyCount, 
                            WS_SERVICE_HOST** serviceHost, WS_ERROR* error);

///Opens a Service Host for communication and starts the Listeners on all the endpoints. Client applications cannot
///connect to Service endpoints until <b>WsOpenSerivceHost</b> is called.
///Params:
///    serviceHost = A pointer to the <b>Service Host</b> object to open. The pointer must reference a valid WS_SERVICE_HOST object
///                  returned by WsCreateServiceHost and the referenced <b>Service Host</b> value may not be <b>NULL</b>.
///    asyncContext = A pointer to A WS_ASYNC_CONTEXT object that has information about how to invoke the function asynchronously. The
///                   value is set to <b>NULL</b> if invoking synchronously.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>WS_S_ASYNC</b></dt> </dl> </td> <td width="60%"> The asynchronous operation is still
///    pending. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_OPERATION_ABORTED</b></dt> </dl> </td> <td
///    width="60%"> The service host was aborted before the open, or during the open. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>WS_E_INVALID_OPERATION</b></dt> </dl> </td> <td width="60%"> The current state of the service proxy
///    is not valid for this operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_ADDRESS_IN_USE</b></dt> </dl>
///    </td> <td width="60%"> The address is already being used. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_ADDRESS_NOT_AVAILABLE</b></dt> </dl> </td> <td width="60%"> The address is not valid for this
///    context. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_QUOTA_EXCEEDED</b></dt> </dl> </td> <td width="60%">
///    A quota was exceeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_OPERATION_ABORTED</b></dt> </dl> </td>
///    <td width="60%"> The operation was aborted. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_OPERATION_TIMED_OUT</b></dt> </dl> </td> <td width="60%"> The operation did not complete within the
///    time allotted. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
///    Ran out of memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
///    width="60%"> One or more arguments are invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b> Other Errors
///    </b></dt> </dl> </td> <td width="60%"> This function may return other errors not listed above. </td> </tr>
///    </table>
///    
@DllImport("webservices")
HRESULT WsOpenServiceHost(WS_SERVICE_HOST* serviceHost, const(WS_ASYNC_CONTEXT)* asyncContext, WS_ERROR* error);

///Closes down communication with the specified service host.
///Params:
///    serviceHost = Pointer to a WS_SERVICE_HOST structure that represents the service host to be closed.
///    asyncContext = Pointer to a WS_ASYNC_CONTEXT structure containing information for invoking the function asynchronously. Pass
///                   <b>NULL</b> to invoke the function synchronously.
///    error = Pointer to a WS_ERROR structure that receives additional error information if the function fails.
///Returns:
///    If the function succeeds, it returns NO_ERROR; otherwise, it returns an HRESULT error code. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_S_ASYNC</b></dt> </dl> </td>
///    <td width="60%"> The asynchronous operation is still pending. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_INVALID_OPERATION</b></dt> </dl> </td> <td width="60%"> The current state of the service host is not
///    valid for this operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
///    width="60%"> One or more arguments are invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_OPERATION_TIMED_OUT</b></dt> </dl> </td> <td width="60%"> The operation did not complete within the
///    time allotted. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_OPERATION_ABORTED</b></dt> </dl> </td> <td
///    width="60%"> The operation was aborted. </td> </tr> <tr> <td width="40%"> <dl> <dt><b> Other Errors </b></dt>
///    </dl> </td> <td width="60%"> This function may return other errors not listed above. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsCloseServiceHost(WS_SERVICE_HOST* serviceHost, const(WS_ASYNC_CONTEXT)* asyncContext, WS_ERROR* error);

///Aborts all current operations on the specified service host.
///Params:
///    serviceHost = Pointer to a WS_SERVICE_HOST structure representing the service host on which to abort operations.
///    error = Pointer to a WS_ERROR structure that receives additional error information if the function fails.
///Returns:
///    If the function succeeds, it returns NO_ERROR; otherwise, it returns an HRESULT error code. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
///    </td> <td width="60%"> One or more arguments are invalid. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsAbortServiceHost(WS_SERVICE_HOST* serviceHost, WS_ERROR* error);

///Releases the memory associated with a Service Host object.
@DllImport("webservices")
void WsFreeServiceHost(WS_SERVICE_HOST* serviceHost);

///Resets service host so that it can be opened again. Rather the creating a new service host from scratch
///<b>WsResetServiceHost</b> provides a convenient way to reuse service host. Specifically in a scenario where a service
///host has to go through close and open on a regular basis, this allows for an efficient way for reusing the same
///service host. It resets the underlying channel and listeners for reuse.
///Params:
///    serviceHost = The service host to reset.
///    error = Specifies where additional error information should be stored if the function fails.
@DllImport("webservices")
HRESULT WsResetServiceHost(WS_SERVICE_HOST* serviceHost, WS_ERROR* error);

///This function retrieves a specified Service Proxy property. The property to retrieve is identified by a
///WS_PROXY_PROPERTY_ID input parameter.
///Params:
///    serviceProxy = This parameter is a pointer to the WS_SERVICE_PROXY object containing the property to retrieve.
///    id = The value of this parameter is a <b>WS_PROXY_PROPERTY_ID</b> enumerator value that identifies the property to
///         retrieve.
///    value = This parameter is a reference to a location for storing the retrieved property value. The pointer must have an
///            alignment compatible with the type of the property.
///    valueSize = The value of this ULONG parameter represents the byte-length buffer size allocated by the caller to store the
///                retrieved property value.
///    error = This parameter is a WS_ERROR pointer to where additional information about the error should be stored if the
///            function fails.
@DllImport("webservices")
HRESULT WsGetServiceProxyProperty(WS_SERVICE_PROXY* serviceProxy, const(WS_PROXY_PROPERTY_ID) id, void* value, 
                                  uint valueSize, WS_ERROR* error);

///Creates a service proxy with the specified properties.
///Params:
///    channelType = A WS_CHANNEL_TYPE enumeration value representing the channel type for the service proxy.
///    channelBinding = A WS_CHANNEL_BINDING enumeration value representing the channel binding.
///    securityDescription = A WS_SECURITY_DESCRIPTION structure representing the security description.
///    properties = An array of WS_PROXY_PROPERTY structures containing optional properties for the service proxy. The value of this
///                 parameter may be <b>NULL</b>, in which case, the <i>propertyCount</i> parameter must be 0 (zero).
///    propertyCount = The number of properties in the <i>properties</i> array.
///    channelProperties = An array of WS_CHANNEL_PROPERTY structures containing optional channel properties. The value of this parameter
///                        may be <b>NULL</b>, in which case, the <i>channelPropertyCount</i> parameter must be 0 (zero). <div
///                        class="alert"><b>Note</b> Be very careful about modifying the default values for these properties.</div> <div>
///                        </div>
///    channelPropertyCount = The number of properties in the <i>channelProperties</i> array.
///    serviceProxy = On success, a pointer that receives the address of the WS_SERVICE_PROXY structure representing the new service
///                   proxy. When you no longer need this structure, you must free it by calling WsFreeServiceProxy.
///    error = Pointer to a WS_ERROR structure that receives additional error information if the function fails.
@DllImport("webservices")
HRESULT WsCreateServiceProxy(const(WS_CHANNEL_TYPE) channelType, const(WS_CHANNEL_BINDING) channelBinding, 
                             const(WS_SECURITY_DESCRIPTION)* securityDescription, 
                             const(WS_PROXY_PROPERTY)* properties, const(uint) propertyCount, 
                             const(WS_CHANNEL_PROPERTY)* channelProperties, const(uint) channelPropertyCount, 
                             WS_SERVICE_PROXY** serviceProxy, WS_ERROR* error);

///Opens a Service Proxy to a Service endpoint. On success client applications can make calls using the Service Proxy.
///The behavior of WsOpenServiceProxy is governed by the channel binding used.
///Params:
///    serviceProxy = A pointer to the <b>Service Proxy</b> to open. The pointer must reference a valid WS_SERVICE_PROXY object and the
///                   referenced value may not be <b>NULL</b>.
///    address = A pointer to the address of the endpoint.
///    asyncContext = A pointer to A WS_ASYNC_CONTEXT object that has information about how to invoke the function asynchronously. The
///                   value is set to <b>NULL</b> if invoking synchronously.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
@DllImport("webservices")
HRESULT WsOpenServiceProxy(WS_SERVICE_PROXY* serviceProxy, const(WS_ENDPOINT_ADDRESS)* address, 
                           const(WS_ASYNC_CONTEXT)* asyncContext, WS_ERROR* error);

///Closes down communication with the specified service proxy.
///Params:
///    serviceProxy = Pointer to a WS_SERVICE_PROXY structure representing he service proxy to be closed.
///    asyncContext = Pointer to a WS_ASYNC_CONTEXT structure containing information for invoking the function asynchronously. Pass
///                   <b>NULL</b> to invoke the function synchronously.
///    error = Pointer to a WS_ERROR structure that receives additional error information if the function fails.
///Returns:
///    If the function succeeds, it returns NO_ERROR; otherwise, it returns an HRESULT error code. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_S_ASYNC</b></dt> </dl> </td>
///    <td width="60%"> The asynchronous operation is still pending. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_INVALID_OPERATION</b></dt> </dl> </td> <td width="60%"> The current state of the service proxy is not
///    valid for this operation. This is only error for which close will fail. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_ENDPOINT_DISCONNECTED</b></dt> </dl> </td> <td width="60%"> The underlying WS_CHANNEL was
///    disconnected during the close operation. This error occurs only in cases where the underlying channel is session
///    based. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_OPERATION_ABORTED</b></dt> </dl> </td> <td width="60%">
///    The operation was aborted. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_ENDPOINT_FAILURE</b></dt> </dl>
///    </td> <td width="60%"> The remote endpoint could not process the request. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl> </td> <td width="60%"> The input data was not in the expected format or
///    did not have the expected value. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_OPERATION_TIMED_OUT</b></dt>
///    </dl> </td> <td width="60%"> The operation did not complete within the time allotted. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>WS_E_QUOTA_EXCEEDED</b></dt> </dl> </td> <td width="60%"> A quota was exceeded. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory
///    to complete the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
///    width="60%"> One or more arguments are invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b> Other Errors
///    </b></dt> </dl> </td> <td width="60%"> This function may return other errors not listed above. </td> </tr>
///    </table>
///    
@DllImport("webservices")
HRESULT WsCloseServiceProxy(WS_SERVICE_PROXY* serviceProxy, const(WS_ASYNC_CONTEXT)* asyncContext, WS_ERROR* error);

///Aborts the service proxy, and cancels any pending I/O on the service proxy.
///Params:
///    serviceProxy = Pointer to a WS_SERVICE_PROXY structure representing the service proxy to abort.
///    error = Pointer to a WS_ERROR structure that receives additional error information if the function fails.
///Returns:
///    If the function succeeds, it returns NO_ERROR; otherwise, it returns an HRESULT error code. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
///    </td> <td width="60%"> One or more arguments are invalid. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsAbortServiceProxy(WS_SERVICE_PROXY* serviceProxy, WS_ERROR* error);

///Releases the memory associated with a Service Proxy resource.
///Params:
///    serviceProxy = A pointer to the <b>Service Proxy</b> to release. The pointer must reference a valid WS_SERVICE_PROXY object
///                   returned by WsCreateServiceProxy. The referenced value may not be <b>NULL</b>.
@DllImport("webservices")
void WsFreeServiceProxy(WS_SERVICE_PROXY* serviceProxy);

///Resets service proxy. WsResetServiceProxy provides a convenient way to reuse the service proxy. Once the proxy is
///closed, the application can call WsResetServiceProxy to reuse it. Reusing the service proxy is helpful in scenarios
///where an application connects to the same service time and time again. The cost of initialization is only paid once
///during the initial creation of the service proxy.
///Params:
///    serviceProxy = The service proxy.
///    error = Specifies where additional error information should be stored if the function fails.
@DllImport("webservices")
HRESULT WsResetServiceProxy(WS_SERVICE_PROXY* serviceProxy, WS_ERROR* error);

///Abandons a specified call on the specified service proxy.
///Params:
///    serviceProxy = Pointer to a WS_SERVICE_PROXY structure representing the service proxy on which to abandon the call.
///    callId = ID of the call to abandon. (See the Remarks section.)
///    error = Pointer to a WS_ERROR structure that receives additional error information if the function fails.
///Returns:
///    If the function succeeds, it returns NO_ERROR; otherwise, it returns an HRESULT error code. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_OPERATION</b></dt>
///    </dl> </td> <td width="60%"> The current state of the service proxy is not valid for this operation. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> A <b>NULL</b> service proxy
///    was passed to the function. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsAbandonCall(WS_SERVICE_PROXY* serviceProxy, uint callId, WS_ERROR* error);

///Used internally by the service proxy to format the specified arguments according to the specified metadata and send
///them in a message. The application should never call this function directly.
///Params:
///    serviceProxy = Pointer to a WS_SERVICE_PROXY structure representing the service proxy.
///    operation = Pointer to a WS_OPERATION_DESCRIPTION structure containing the metadata for the call.
///    arguments = An array of pointers to the individual arguments for the service operation being represented by the
///                <i>operation</i> parameter. The number of elements must correspond to the number of parameters specified as part
///                of WS_OPERATION_DESCRIPTION in the operation parameter.
///    heap = Pointer to a WS_HEAP structure representing the heap from which memory is allocated for the call.
///    callProperties = An array of WS_CALL_PROPERTY structures containing the call properties.
///    callPropertyCount = The number of properties in the call properties array.
///    asyncContext = Pointer to information for invoking the function asynchronously. Pass <b>NULL</b> to invoke the function
///                   synchronously.
///    error = Pointer to a WS_ERROR structure that receives additional error information if the function fails.
@DllImport("webservices")
HRESULT WsCall(WS_SERVICE_PROXY* serviceProxy, const(WS_OPERATION_DESCRIPTION)* operation, const(void)** arguments, 
               WS_HEAP* heap, const(WS_CALL_PROPERTY)* callProperties, const(uint) callPropertyCount, 
               const(WS_ASYNC_CONTEXT)* asyncContext, WS_ERROR* error);

///Evaluates the components of an URL to determine its "scheme". A WS_URL_SCHEME_TYPE value is encapsulated in a WS_URL
///structure and a reference to the structure is returned via output parameter. If the scheme is not recognized, the
///function returns WS_E_INVALID_FORMAT. Only scheme types identified in <b>WS_URL_SCHEME_TYPE</b> are supported.
///Params:
///    url = A pointer to a WS_STRING representation of the URL to evaluate.
///    flags = Determines the URL scheme evaluation method. See WS_URL_FLAGS.
///    heap = A pointer to a WS_HEAP in which to allocate the returned URL reference.
///    outUrl = Reference to the WS_URL structure that encapsulates the WS_URL_SCHEME_TYPE value.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Ran
///    out of memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl> </td> <td
///    width="60%"> The input URL was not in the correct format, or the scheme was not recognized. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b> Other Errors </b></dt> </dl> </td> <td width="60%"> This function may return other
///    errors not listed above. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsDecodeUrl(const(WS_STRING)* url, uint flags, WS_HEAP* heap, WS_URL** outUrl, WS_ERROR* error);

///Encodes the specified WS_URL into a URL string given its component parts. Values are escaped as necessary, combined,
///and stored in the specified WS_HEAP, and the result is returned as a WS_STRING.
///Params:
///    url = A reference to the WS_URL to encode.
///    flags = The value of this parameter determines the URL scheme evaluation method. See WS_URL_FLAGS.
///    heap = A pointer to a WS_HEAP in which to allocate URL.
///    outUrl = A pointer to the resulting URL string.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Ran
///    out of memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl> </td> <td
///    width="60%"> The URL data being encoded was not valid according to the URL syntax. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b> Other Errors </b></dt> </dl> </td> <td width="60%"> This function may return other
///    errors not listed above. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsEncodeUrl(const(WS_URL)* url, uint flags, WS_HEAP* heap, WS_STRING* outUrl, WS_ERROR* error);

///Produces an absolute URL from a specified URL reference (absolute or relative URL) and a specified absolute base URL.
///Params:
///    baseUrl = Pointer to a WS_STRING structure containing an absolute URL in encoded format.
///    referenceUrl = Pointer to a WS_STRING structure containing an absolute or relative URL in encoded format.
///    flags = Controls the format of the resulting URL. For more information, see WS_URL_FLAGS.
///    heap = Pointer to the WS_HEAP object from which the memory for the resulting URL is allocated.
///    resultUrl = Pointer to a WS_STRING structure that receives the resulting URL. This is an absolute URL in encoded format.
///    error = Pointer to a WS_ERROR structure that receives additional error information if the function fails.
///Returns:
///    If the function succeeds, it returns NO_ERROR; otherwise, it returns an HRESULT error code. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
///    </td> <td width="60%"> One or more arguments are not valid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory to complete the operation. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl> </td> <td width="60%"> The base URL or
///    reference URL was not in the correct format, or had a scheme that was not recognized. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b> Other Errors </b></dt> </dl> </td> <td width="60%"> This function may return other
///    errors not listed above. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsCombineUrl(const(WS_STRING)* baseUrl, const(WS_STRING)* referenceUrl, uint flags, WS_HEAP* heap, 
                     WS_STRING* resultUrl, WS_ERROR* error);

///Converts a WS_DATETIME object into a FILETIME object. A reference to the FILETIME object is returned by output
///parameter.
///Params:
///    dateTime = A pointer to the WS_DATETIME structure to convert.
///    fileTime = A pointer to the new FILETIME object that contains the converted time.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl> </td> <td width="60%">
///    The input data was not in the expected format or did not have the expected value. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsDateTimeToFileTime(const(WS_DATETIME)* dateTime, FILETIME* fileTime, WS_ERROR* error);

///Takes a reference to a FILETIME object and converts it into a WS_DATETIME object. A reference to the WS_DATETIME
///object is returned by output parameter.
///Params:
///    fileTime = A pointer to the FILETIME structure to convert.
///    dateTime = A pointer to the new WS_DATETIME object that has the newly converted time.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl> </td> <td width="60%">
///    The input data was not in the expected format or did not have the expected value. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsFileTimeToDateTime(const(FILETIME)* fileTime, WS_DATETIME* dateTime, WS_ERROR* error);

///Creates a metadata object that is used to collect and process metadata documents.
///Params:
///    properties = An array of WS_METADATA_PROPERTY structures containing optional properties for the metadata. The value of this
///                 parameter may be <b>NULL</b>, in which case, the <i>propertyCount</i> parameter must be 0 (zero).
///    propertyCount = The number of properties in the <i>properties</i> array.
///    metadata = On success, a pointer that receives the address of the WS_METADATA structure representing the new message. When
///               you no longer need this structure, you must free it by calling WsFreeMetadata.
///    error = Pointer to a WS_ERROR structure that receives additional error information if the function fails.
@DllImport("webservices")
HRESULT WsCreateMetadata(const(WS_METADATA_PROPERTY)* properties, uint propertyCount, WS_METADATA** metadata, 
                         WS_ERROR* error);

///Reads a Metadata element and adds it to the Metadata documents of the Metadata object. The Metadata object state must
///be set to <b>WS_METADATA_STATE_CREATED</b>. On error the Metadata object state is reset to
///<b>WS_METADATA_STATE_FAULTED</b>. <div class="alert"><b>Note</b> The function will consume an element if the element
///contains metadata. If the element is not recognized as containing metadata, or the particular type of metadata is not
///needed, the element it is not read. </div> <div> </div>
///Params:
///    metadata = A pointer to the <b>Metadata</b> object for storing the metadata read. The pointer must reference a valid
///               WS_METADATA object.
///    reader = A pointer to the <b>XML Reader</b> object used to read the metadata. The pointer must reference a valid
///             WS_XML_READER object and the reader must be positioned on the element containing the desired metadata.
///    url = A pointer to a WS_STRING object referencing the retrieved metadata URL. The URL is used to track the metadata
///          documents for resolving URL-based links between documents. <div class="alert"><b>Note</b> The URL MUST be fully
///          qualified. The URL can have a fragment identifier. </div> <div> </div> The following URL schemes are supported:
///          <ul> <li><b>WS_URL_HTTP_SCHEME_TYPE</b></li> <li><b>WS_URL_HTTPS_SCHEME_TYPE</b></li>
///          <li><b>WS_URL_NETTCP_SCHEME_TYPE</b></li> </ul> Each URL specified using this function must have a unique base
///          URL. The base URL is computed by removing any fragment identifier from the URL specified. For example if the
///          following URLs were specified: <pre class="syntax" xml:space="preserve"><code> http://example.com/document1
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl> </td> <td width="60%"> The input data was not in
///    the expected format or did not have the expected value. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>WS_E_INVALID_OPERATION</b></dt> </dl> </td> <td width="60%"> The operation is not allowed due to the
///    current state of the object. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_QUOTA_EXCEEDED</b></dt> </dl>
///    </td> <td width="60%"> A quota was exceeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt>
///    </dl> </td> <td width="60%"> Ran out of memory. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are invalid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The element was not consumed. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b> Other Errors </b></dt> </dl> </td> <td width="60%"> This function may return
///    other errors not listed above. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsReadMetadata(WS_METADATA* metadata, WS_XML_READER* reader, const(WS_STRING)* url, WS_ERROR* error);

///Releases the memory resource associated with a metadata object.
///Params:
///    metadata = A pointer to the metadata object to release. The pointer must reference a valid WS_METADATA object returned by
///               WsCreateMetadata and the referenced value may not be <b>NULL</b>.
@DllImport("webservices")
void WsFreeMetadata(WS_METADATA* metadata);

///Resets a metadata object state to <b>WS_METADATA_STATE_CREATED</b>. In this state the Metadata object can be reused.
///WS_POLICY objects that were retrieved using the Metadata object will be released.
///Params:
///    metadata = A pointer to the <b>Metadata</b> object to reset. The pointer must reference a valid WS_METADATA.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>WS_E_INVALID_OPERATION</b></dt> </dl> </td> <td width="60%"> The metadata was in an
///    inappropriate state. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsResetMetadata(WS_METADATA* metadata, WS_ERROR* error);

///Retrieves a specified WS_METADATA object property. The property to retrieve is identified by a
///WS_METADATA_PROPERTY_ID input parameter. <div class="alert"><b>Note</b> The data returned by this function is valid
///until the metadata object is released or reset. The data should not be modified. </div><div> </div>
///Params:
///    metadata = A pointer to a <b>Metadata</b> object containing the desired property. This parameter must be a valid WS_METADATA
///               object.
///    id = Identifier value of the property to retrieve.
///    value = A reference to a location for storing the retrieved property value. The pointer must have an alignment compatible
///            with the type of the property.
///    valueSize = The byte-length buffer size allocated by the caller to store the retrieved property value.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
@DllImport("webservices")
HRESULT WsGetMetadataProperty(WS_METADATA* metadata, WS_METADATA_PROPERTY_ID id, void* value, uint valueSize, 
                              WS_ERROR* error);

///This function returns the address of a missing document that is referenced by the metadata object. Each document that
///is added to the metadata object may contain references to other documents. After a document has been added back to
///the Metadata the function can be used to find the next missing document. <div class="alert"><b>Note</b> This function
///will fail if the host name of the URL of the missing address being returned cannot be verified as being one of the
///host names expected. The expected host names are a union of the following: <ul> <li>The host name of any URL
///previously passed to WsReadMetadata. </li> <li>The list of host names specified using the
///WS_METADATA_PROPERTY_HOST_NAMES property. </li> </ul> </div><div> </div>
///Params:
///    metadata = This parameter is a pointer to a <b>Metadata</b> object that should have the document.
///    address = On success this parameter is populated with either a pointer to the address of a missing metadata document, or
///              <b>NULL</b> if there are no missing metadata documents. The returned address URL is fully qualified. <div
///              class="alert"><b>Note</b> The data returned by this function is valid until the metadata object is freed or
///              reset. The data should not be modified. </div> <div> </div>
///    error = This parameter is a WS_ERROR pointer to where additional information about the error should be stored if the
///            function fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Ran
///    out of memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b> Other Errors </b></dt> </dl> </td> <td width="60%">
///    This function may return other errors not listed above. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsGetMissingMetadataDocumentAddress(WS_METADATA* metadata, WS_ENDPOINT_ADDRESS** address, WS_ERROR* error);

///Returns the "Endpoints" defined within the metadata object documents. Calling this function with WS_METADATA_STATEset
///to <b>WS_METADATA_STATE_CREATED</b> will cause the metadata object to resolve all references in the metadata
///documents. Any additional document validation will also be done. If this process is successful the metadata object
///will be set to <b>WS_METADATA_STATE_RESOLVED</b> and subsequent document additions to the metadata object are not
///permitted. If there is an error the metadata object will be set to <b>WS_METADATA_STATE_FAULTED</b>. <div
///class="alert"><b>Note</b> The data returned by this function is valid until the metadata object is released or reset.
///The data returned from this function should not be modified. </div><div> </div>
///Params:
///    metadata = A pointer to a <b>Metadata</b> object containing the desired Endpoints. This parameter must be a valid
///               WS_METADATA object.
///    endpoints = On success this pointer parameter is populated with information about the endpoints that were defined in the
///                metadata object.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The property id was not supported
///    for this object or the specified buffer was not large enough for the value. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory resources. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b> Other Errors </b></dt> </dl> </td> <td width="60%"> This function may return other
///    errors not listed above. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsGetMetadataEndpoints(WS_METADATA* metadata, WS_METADATA_ENDPOINTS* endpoints, WS_ERROR* error);

///Verifies that a Policy Alternative is compatible with the specified Policy Constraint. If the alternative is
///compatible the constraint structures are populated with Policy information. <div class="alert"><b>Note</b> See
///Remarks on this page for information on the constraint structures.</div> <div> </div>
///Params:
///    policy = A pointer to a WS_POLICY object containing the alternative. <div class="alert"><b>Note</b> Each
///             WS_METADATA_ENDPOINT that is returned from WsGetMetadataEndpoints contains a policy object. </div> <div> </div>
///    alternativeIndex = Specifies the zero-based index that identifies the alternative to use within the policy object. The number of
///                       alternatives present in the policy object can be obtained using WsGetPolicyAlternativeCount.
///    policyConstraints = A pointer to the constraints that specify policies to match along with the fields to populate if the function
///                        returns NOERROR. <div class="alert"><b>Note</b> If a property constraint is not specified the default constraint
///                        value for that particular property is used. See WS_POLICY_CONSTRAINTS for more information.</div> <div> </div>
///    matchRequired = Indicates whether a match is required or not. <div class="alert"><b>Note</b> If the value is <b>FALSE</b> a match
///                    is not required, and in conjunction with a non-matching policy alternative, the function returns S_FALSE. If the
///                    value of this parameter is <b>TRUE</b> a match is required, and if the policy does not match, the function
///                    returns an error. </div> <div> </div>
///    heap = A pointer to a Heap object used to store any data requiring allocation beyond the specified constraint. <div
///           class="alert"><b>Note</b> For example pointer types within the constraint "out" fields is allocated using this
///           Heap. </div> <div> </div>
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more arguments are
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WS_E_INVALID_FORMAT</b></dt> </dl> </td> <td width="60%">
///    The policy alternative does not meet the specified constraints. and matchRequired was set to <b>TRUE</b>. The
///    policy or other metadata was in an invalid format. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt>
///    </dl> </td> <td width="60%"> The policy alternative does not meet the specified constraints. and matchRequired
///    was set to <b>FALSE</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%">
///    The policy alternative meets the specific constraints. The <b>out</b> fields of the constraints structures have
///    been filled with values from the policy. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsMatchPolicyAlternative(WS_POLICY* policy, uint alternativeIndex, 
                                 WS_POLICY_CONSTRAINTS* policyConstraints, BOOL matchRequired, WS_HEAP* heap, 
                                 WS_ERROR* error);

///Retrieves a property of a policy object.
///Params:
///    policy = A pointer to the WS_POLICY object from which to obtain the property.
///    id = An identifier of the policy property to retrieve.
///    value = A pointer to the address to store the retrieved property value. The pointer must have an alignment compatible
///            with the type of the property.
///    valueSize = The number of bytes allocated by the caller to store the retrieved property.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The property id was not supported
///    for this object or the specified buffer was not large enough for the value. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Ran out of memory. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b> Other Errors </b></dt> </dl> </td> <td width="60%"> This function may return other
///    errors not listed above. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsGetPolicyProperty(WS_POLICY* policy, WS_POLICY_PROPERTY_ID id, void* value, uint valueSize, 
                            WS_ERROR* error);

///Retrieves the number of alternatives available in the policy object. The alternative count can be used to loop
///through each alternative using WsMatchPolicyAlternative. <div class="alert"><b>Note</b> The policy object may delay
///some processing until this function is called. If the processing fails, then the policy object will be set to
///<b>WS_POLICY_STATE_FAULTED</b> state. </div><div> </div>
///Params:
///    policy = A pointer to the WS_POLICY object from which to count alternatives.
///    count = A pointer to the number value of alternatives. This may be 0.
///    error = A pointer to a WS_ERROR object where additional information about the error should be stored if the function
///            fails.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The property id was not supported
///    for this object or the specified buffer was not large enough for the value. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Ran out of memory. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b> Other Errors </b></dt> </dl> </td> <td width="60%"> This function may return other
///    errors not listed above. </td> </tr> </table>
///    
@DllImport("webservices")
HRESULT WsGetPolicyAlternativeCount(WS_POLICY* policy, uint* count, WS_ERROR* error);

///Helper routine for creating a service proxy from policy templates.
///Params:
///    channelType = A WS_CHANNEL_TYPE enumeration value representing the channel type for the service proxy.
///    properties = An array of WS_PROXY_PROPERTY structures containing optional properties for the service proxy. The value of this
///                 parameter may be <b>NULL</b>, in which case, the <i>propertyCount</i> parameter must be 0 (zero).
///    propertyCount = The number of properties in the <i>properties</i> array.
///    templateType = A WS_BINDING_TEMPLATE_TYPE enumeration value representing the type of templates used to create the service proxy.
///                   Please see the <b>Remarks</b> for more information.
///    templateValue = The optional template structure to be created and filled in by an application. This template structure must be
///                    consistent with the input template type (in the <i>templateType</i>). When <i>templateValue</i> parameter is
///                    <b>NULL</b>, it is equivalent to the corresponding template structure initialized to zero. Please see the
///                    <b>Remarks</b> for more information.
///    templateSize = The size, in bytes, of the template structure (in the <i>templateValue</i> parameter).
///    templateDescription = The description of <i>templateValue</i>. This must match <i>templateType</i>. Please see the <b>Remarks</b> for
///                          more information.
///    templateDescriptionSize = The size of the template description.
///    serviceProxy = On success, a pointer that receives the address of the WS_SERVICE_PROXY structure representing the new service
///                   proxy. When you no longer need this structure, you must free it by calling WsFreeServiceProxy.
///    error = Pointer to a WS_ERROR structure that receives additional error information if the function fails.
///Returns:
///    If the function succeeds, it returns NO_ERROR; otherwise, it returns an HRESULT error code.
///    
@DllImport("webservices")
HRESULT WsCreateServiceProxyFromTemplate(WS_CHANNEL_TYPE channelType, const(WS_PROXY_PROPERTY)* properties, 
                                         const(uint) propertyCount, WS_BINDING_TEMPLATE_TYPE templateType, 
                                         void* templateValue, uint templateSize, const(void)* templateDescription, 
                                         uint templateDescriptionSize, WS_SERVICE_PROXY** serviceProxy, 
                                         WS_ERROR* error);

///Helper routine for creating a service endpoint (WS_SERVICE_ENDPOINT) from policy templates.
///Params:
///    channelType = A WS_CHANNEL_TYPE enumeration value representing the type of channel hosted by the endpoint.
///    properties = An array of WS_SERVICE_ENDPOINT_PROPERTY structures containing properties for the service endpoint. (Application
///                 should fill in channel properties in the template structure.)
///    propertyCount = The number of properties in the <i>properties</i> array.
///    addressUrl = The URL address on which the endpoint is to listen.
///    contract = A WS_SERVICE_CONTRACT structure representing the contract of the endpoint.
///    authorizationCallback = A WS_SERVICE_SECURITY_CALLBACK authorization callback for the service endpoint.
///    heap = The heap from which memory for the service endpoint is allocated on successful return.
///    templateType = A WS_BINDING_TEMPLATE_TYPE enumeration value representing the type of templates being used to create the service
///                   endpoint.
///    templateValue = Optional template structure to be created and filled in by application. The template must be consistent with the
///                    input template type (passed in the <i>templateType</i> parameter). When the <i>templateValue</i> parameter is
///                    <b>NULL</b>, it is equivalent to the corresponding template structure initialized to zero.
///    templateSize = The size, in bytes, of the input templateValue structure.
///    templateDescription = The description of template structure (passed in the <i>templateValue</i> parameter). Needs to match
///                          templateType.
///    templateDescriptionSize = The size of the template description.
///    serviceEndpoint = On success, a pointer that receives the address of the WS_SERVICE_ENDPOINT structure representing the new service
///                      endpoint.
///    error = Pointer to a WS_ERROR structure that receives additional error information if the function fails.
///Returns:
///    If the function succeeds, it returns NO_ERROR; otherwise, it returns an HRESULT error code.
///    
@DllImport("webservices")
HRESULT WsCreateServiceEndpointFromTemplate(WS_CHANNEL_TYPE channelType, 
                                            const(WS_SERVICE_ENDPOINT_PROPERTY)* properties, uint propertyCount, 
                                            const(WS_STRING)* addressUrl, const(WS_SERVICE_CONTRACT)* contract, 
                                            WS_SERVICE_SECURITY_CALLBACK authorizationCallback, WS_HEAP* heap, 
                                            WS_BINDING_TEMPLATE_TYPE templateType, void* templateValue, 
                                            uint templateSize, const(void)* templateDescription, 
                                            uint templateDescriptionSize, WS_SERVICE_ENDPOINT** serviceEndpoint, 
                                            WS_ERROR* error);

@DllImport("webauthn")
uint WebAuthNGetApiVersionNumber();

@DllImport("webauthn")
HRESULT WebAuthNIsUserVerifyingPlatformAuthenticatorAvailable(BOOL* pbIsUserVerifyingPlatformAuthenticatorAvailable);

@DllImport("webauthn")
HRESULT WebAuthNAuthenticatorMakeCredential(HWND hWnd, WEBAUTHN_RP_ENTITY_INFORMATION* pRpInformation, 
                                            WEBAUTHN_USER_ENTITY_INFORMATION* pUserInformation, 
                                            WEBAUTHN_COSE_CREDENTIAL_PARAMETERS* pPubKeyCredParams, 
                                            WEBAUTHN_CLIENT_DATA* pWebAuthNClientData, 
                                            WEBAUTHN_AUTHENTICATOR_MAKE_CREDENTIAL_OPTIONS* pWebAuthNMakeCredentialOptions, 
                                            WEBAUTHN_CREDENTIAL_ATTESTATION** ppWebAuthNCredentialAttestation);

@DllImport("webauthn")
HRESULT WebAuthNAuthenticatorGetAssertion(HWND hWnd, const(PWSTR) pwszRpId, 
                                          WEBAUTHN_CLIENT_DATA* pWebAuthNClientData, 
                                          WEBAUTHN_AUTHENTICATOR_GET_ASSERTION_OPTIONS* pWebAuthNGetAssertionOptions, 
                                          WEBAUTHN_ASSERTION** ppWebAuthNAssertion);

@DllImport("webauthn")
void WebAuthNFreeCredentialAttestation(WEBAUTHN_CREDENTIAL_ATTESTATION* pWebAuthNCredentialAttestation);

@DllImport("webauthn")
void WebAuthNFreeAssertion(WEBAUTHN_ASSERTION* pWebAuthNAssertion);

@DllImport("webauthn")
HRESULT WebAuthNGetCancellationId(GUID* pCancellationId);

@DllImport("webauthn")
HRESULT WebAuthNCancelCurrentOperation(const(GUID)* pCancellationId);

@DllImport("webauthn")
PWSTR WebAuthNGetErrorName(HRESULT hr);

@DllImport("webauthn")
HRESULT WebAuthNGetW3CExceptionDOMError(HRESULT hr);


// Interfaces

///The <b>IContentPrefetcherTaskTrigger</b> interface supports content prefetching behavior and performance testing by
///defining methods that allow you to verify that an installed app package is registered for this background task and
///manually trigger its content prefetch operations. <div class="alert"><b>Note</b> Use of this API requires that its
///methods are called at Medium Integrity Level (Medium IL).</div><div> </div>
@GUID("1B35A14A-6094-4799-A60E-E474E15D4DC9")
interface IContentPrefetcherTaskTrigger : IInspectable
{
    ///Triggers a content prefetch background task for the specified app package.
    ///Params:
    ///    packageFullName = The package ID.
    ///Returns:
    ///    Returns S_OK on success. Other possible values include: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> The provided package ID is not an installed package that has registered for the content prefetch
    ///    background task, or the package ID is empty or null. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> The method call was not made at the required
    ///    Medium Integrity Level (Medium IL). </td> </tr> </table>
    ///    
    HRESULT TriggerContentPrefetcherTask(const(PWSTR) packageFullName);
    ///Indicates if an app package has registered for the content prefetch background task.
    ///Params:
    ///    packageFullName = The package ID.
    ///    isRegistered = True if the app package has registered for the content prefetch background task; otherwise, false.
    ///Returns:
    ///    Returns S_OK on success. Other possible values include: <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td
    ///    width="60%"> The method call was not made at the required Medium Integrity Level (Medium IL). </td> </tr>
    ///    </table>
    ///    
    HRESULT IsRegisteredForContentPrefetch(const(PWSTR) packageFullName, ubyte* isRegistered);
}


// GUIDs


const GUID IID_IContentPrefetcherTaskTrigger = GUIDOF!IContentPrefetcherTaskTrigger;
