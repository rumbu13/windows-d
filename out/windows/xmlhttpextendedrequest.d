module windows.xmlhttpextendedrequest;

public import windows.core;
public import windows.automation : BSTR, IDispatch, VARIANT;
public import windows.com : HRESULT, IUnknown;
public import windows.structuredstorage : ISequentialStream;
public import windows.windowsprogramming : DOMNodeType, FILETIME, IXMLDOMDocument, IXMLDOMNode, IXMLDOMNodeList,
                                           IXMLDOMParseError;

extern(Windows):


// Enums


enum : int
{
    SXH_OPTION_URL                                = 0xffffffff,
    SXH_OPTION_URL_CODEPAGE                       = 0x00000000,
    SXH_OPTION_ESCAPE_PERCENT_IN_URL              = 0x00000001,
    SXH_OPTION_IGNORE_SERVER_SSL_CERT_ERROR_FLAGS = 0x00000002,
    SXH_OPTION_SELECT_CLIENT_SSL_CERT             = 0x00000003,
}
alias SERVERXMLHTTP_OPTION = int;

enum : int
{
    SXH_SERVER_CERT_IGNORE_UNKNOWN_CA        = 0x00000100,
    SXH_SERVER_CERT_IGNORE_WRONG_USAGE       = 0x00000200,
    SXH_SERVER_CERT_IGNORE_CERT_CN_INVALID   = 0x00001000,
    SXH_SERVER_CERT_IGNORE_CERT_DATE_INVALID = 0x00002000,
    SXH_SERVER_CERT_IGNORE_ALL_SERVER_ERRORS = 0x00003300,
}
alias SXH_SERVER_CERT_OPTION = int;

enum : int
{
    SXH_PROXY_SET_DEFAULT   = 0x00000000,
    SXH_PROXY_SET_PRECONFIG = 0x00000000,
    SXH_PROXY_SET_DIRECT    = 0x00000001,
    SXH_PROXY_SET_PROXY     = 0x00000002,
}
alias SXH_PROXY_SETTING = int;

enum : int
{
    SOMITEM_SCHEMA                      = 0x00001000,
    SOMITEM_ATTRIBUTE                   = 0x00001001,
    SOMITEM_ATTRIBUTEGROUP              = 0x00001002,
    SOMITEM_NOTATION                    = 0x00001003,
    SOMITEM_ANNOTATION                  = 0x00001004,
    SOMITEM_IDENTITYCONSTRAINT          = 0x00001100,
    SOMITEM_KEY                         = 0x00001101,
    SOMITEM_KEYREF                      = 0x00001102,
    SOMITEM_UNIQUE                      = 0x00001103,
    SOMITEM_ANYTYPE                     = 0x00002000,
    SOMITEM_DATATYPE                    = 0x00002100,
    SOMITEM_DATATYPE_ANYTYPE            = 0x00002101,
    SOMITEM_DATATYPE_ANYURI             = 0x00002102,
    SOMITEM_DATATYPE_BASE64BINARY       = 0x00002103,
    SOMITEM_DATATYPE_BOOLEAN            = 0x00002104,
    SOMITEM_DATATYPE_BYTE               = 0x00002105,
    SOMITEM_DATATYPE_DATE               = 0x00002106,
    SOMITEM_DATATYPE_DATETIME           = 0x00002107,
    SOMITEM_DATATYPE_DAY                = 0x00002108,
    SOMITEM_DATATYPE_DECIMAL            = 0x00002109,
    SOMITEM_DATATYPE_DOUBLE             = 0x0000210a,
    SOMITEM_DATATYPE_DURATION           = 0x0000210b,
    SOMITEM_DATATYPE_ENTITIES           = 0x0000210c,
    SOMITEM_DATATYPE_ENTITY             = 0x0000210d,
    SOMITEM_DATATYPE_FLOAT              = 0x0000210e,
    SOMITEM_DATATYPE_HEXBINARY          = 0x0000210f,
    SOMITEM_DATATYPE_ID                 = 0x00002110,
    SOMITEM_DATATYPE_IDREF              = 0x00002111,
    SOMITEM_DATATYPE_IDREFS             = 0x00002112,
    SOMITEM_DATATYPE_INT                = 0x00002113,
    SOMITEM_DATATYPE_INTEGER            = 0x00002114,
    SOMITEM_DATATYPE_LANGUAGE           = 0x00002115,
    SOMITEM_DATATYPE_LONG               = 0x00002116,
    SOMITEM_DATATYPE_MONTH              = 0x00002117,
    SOMITEM_DATATYPE_MONTHDAY           = 0x00002118,
    SOMITEM_DATATYPE_NAME               = 0x00002119,
    SOMITEM_DATATYPE_NCNAME             = 0x0000211a,
    SOMITEM_DATATYPE_NEGATIVEINTEGER    = 0x0000211b,
    SOMITEM_DATATYPE_NMTOKEN            = 0x0000211c,
    SOMITEM_DATATYPE_NMTOKENS           = 0x0000211d,
    SOMITEM_DATATYPE_NONNEGATIVEINTEGER = 0x0000211e,
    SOMITEM_DATATYPE_NONPOSITIVEINTEGER = 0x0000211f,
    SOMITEM_DATATYPE_NORMALIZEDSTRING   = 0x00002120,
    SOMITEM_DATATYPE_NOTATION           = 0x00002121,
    SOMITEM_DATATYPE_POSITIVEINTEGER    = 0x00002122,
    SOMITEM_DATATYPE_QNAME              = 0x00002123,
    SOMITEM_DATATYPE_SHORT              = 0x00002124,
    SOMITEM_DATATYPE_STRING             = 0x00002125,
    SOMITEM_DATATYPE_TIME               = 0x00002126,
    SOMITEM_DATATYPE_TOKEN              = 0x00002127,
    SOMITEM_DATATYPE_UNSIGNEDBYTE       = 0x00002128,
    SOMITEM_DATATYPE_UNSIGNEDINT        = 0x00002129,
    SOMITEM_DATATYPE_UNSIGNEDLONG       = 0x0000212a,
    SOMITEM_DATATYPE_UNSIGNEDSHORT      = 0x0000212b,
    SOMITEM_DATATYPE_YEAR               = 0x0000212c,
    SOMITEM_DATATYPE_YEARMONTH          = 0x0000212d,
    SOMITEM_DATATYPE_ANYSIMPLETYPE      = 0x000021ff,
    SOMITEM_SIMPLETYPE                  = 0x00002200,
    SOMITEM_COMPLEXTYPE                 = 0x00002400,
    SOMITEM_PARTICLE                    = 0x00004000,
    SOMITEM_ANY                         = 0x00004001,
    SOMITEM_ANYATTRIBUTE                = 0x00004002,
    SOMITEM_ELEMENT                     = 0x00004003,
    SOMITEM_GROUP                       = 0x00004100,
    SOMITEM_ALL                         = 0x00004101,
    SOMITEM_CHOICE                      = 0x00004102,
    SOMITEM_SEQUENCE                    = 0x00004103,
    SOMITEM_EMPTYPARTICLE               = 0x00004104,
    SOMITEM_NULL                        = 0x00000800,
    SOMITEM_NULL_TYPE                   = 0x00002800,
    SOMITEM_NULL_ANY                    = 0x00004801,
    SOMITEM_NULL_ANYATTRIBUTE           = 0x00004802,
    SOMITEM_NULL_ELEMENT                = 0x00004803,
}
alias SOMITEMTYPE = int;

enum : int
{
    SCHEMAUSE_OPTIONAL   = 0x00000000,
    SCHEMAUSE_PROHIBITED = 0x00000001,
    SCHEMAUSE_REQUIRED   = 0x00000002,
}
alias SCHEMAUSE = int;

enum : int
{
    SCHEMADERIVATIONMETHOD_EMPTY        = 0x00000000,
    SCHEMADERIVATIONMETHOD_SUBSTITUTION = 0x00000001,
    SCHEMADERIVATIONMETHOD_EXTENSION    = 0x00000002,
    SCHEMADERIVATIONMETHOD_RESTRICTION  = 0x00000004,
    SCHEMADERIVATIONMETHOD_LIST         = 0x00000008,
    SCHEMADERIVATIONMETHOD_UNION        = 0x00000010,
    SCHEMADERIVATIONMETHOD_ALL          = 0x000000ff,
    SCHEMADERIVATIONMETHOD_NONE         = 0x00000100,
}
alias SCHEMADERIVATIONMETHOD = int;

enum : int
{
    SCHEMACONTENTTYPE_EMPTY       = 0x00000000,
    SCHEMACONTENTTYPE_TEXTONLY    = 0x00000001,
    SCHEMACONTENTTYPE_ELEMENTONLY = 0x00000002,
    SCHEMACONTENTTYPE_MIXED       = 0x00000003,
}
alias SCHEMACONTENTTYPE = int;

enum : int
{
    SCHEMAPROCESSCONTENTS_NONE   = 0x00000000,
    SCHEMAPROCESSCONTENTS_SKIP   = 0x00000001,
    SCHEMAPROCESSCONTENTS_LAX    = 0x00000002,
    SCHEMAPROCESSCONTENTS_STRICT = 0x00000003,
}
alias SCHEMAPROCESSCONTENTS = int;

enum : int
{
    SCHEMAWHITESPACE_NONE     = 0xffffffff,
    SCHEMAWHITESPACE_PRESERVE = 0x00000000,
    SCHEMAWHITESPACE_REPLACE  = 0x00000001,
    SCHEMAWHITESPACE_COLLAPSE = 0x00000002,
}
alias SCHEMAWHITESPACE = int;

enum : int
{
    SCHEMATYPEVARIETY_NONE   = 0xffffffff,
    SCHEMATYPEVARIETY_ATOMIC = 0x00000000,
    SCHEMATYPEVARIETY_LIST   = 0x00000001,
    SCHEMATYPEVARIETY_UNION  = 0x00000002,
}
alias SCHEMATYPEVARIETY = int;

enum : int
{
    XHR_COOKIE_STATE_UNKNOWN   = 0x00000000,
    XHR_COOKIE_STATE_ACCEPT    = 0x00000001,
    XHR_COOKIE_STATE_PROMPT    = 0x00000002,
    XHR_COOKIE_STATE_LEASH     = 0x00000003,
    XHR_COOKIE_STATE_DOWNGRADE = 0x00000004,
    XHR_COOKIE_STATE_REJECT    = 0x00000005,
}
alias XHR_COOKIE_STATE = int;

enum : int
{
    XHR_COOKIE_IS_SECURE       = 0x00000001,
    XHR_COOKIE_IS_SESSION      = 0x00000002,
    XHR_COOKIE_THIRD_PARTY     = 0x00000010,
    XHR_COOKIE_PROMPT_REQUIRED = 0x00000020,
    XHR_COOKIE_EVALUATE_P3P    = 0x00000040,
    XHR_COOKIE_APPLY_P3P       = 0x00000080,
    XHR_COOKIE_P3P_ENABLED     = 0x00000100,
    XHR_COOKIE_IS_RESTRICTED   = 0x00000200,
    XHR_COOKIE_IE6             = 0x00000400,
    XHR_COOKIE_IS_LEGACY       = 0x00000800,
    XHR_COOKIE_NON_SCRIPT      = 0x00001000,
    XHR_COOKIE_HTTPONLY        = 0x00002000,
}
alias XHR_COOKIE_FLAG = int;

enum : int
{
    XHR_CRED_PROMPT_ALL   = 0x00000000,
    XHR_CRED_PROMPT_NONE  = 0x00000001,
    XHR_CRED_PROMPT_PROXY = 0x00000002,
}
alias XHR_CRED_PROMPT = int;

enum : int
{
    XHR_AUTH_ALL   = 0x00000000,
    XHR_AUTH_NONE  = 0x00000001,
    XHR_AUTH_PROXY = 0x00000002,
}
alias XHR_AUTH = int;

enum : int
{
    XHR_PROP_NO_CRED_PROMPT         = 0x00000000,
    XHR_PROP_NO_AUTH                = 0x00000001,
    XHR_PROP_TIMEOUT                = 0x00000002,
    XHR_PROP_NO_DEFAULT_HEADERS     = 0x00000003,
    XHR_PROP_REPORT_REDIRECT_STATUS = 0x00000004,
    XHR_PROP_NO_CACHE               = 0x00000005,
    XHR_PROP_EXTENDED_ERROR         = 0x00000006,
    XHR_PROP_QUERY_STRING_UTF8      = 0x00000007,
    XHR_PROP_IGNORE_CERT_ERRORS     = 0x00000008,
    XHR_PROP_ONDATA_THRESHOLD       = 0x00000009,
    XHR_PROP_SET_ENTERPRISEID       = 0x0000000a,
    XHR_PROP_MAX_CONNECTIONS        = 0x0000000b,
}
alias XHR_PROPERTY = int;

enum : uint
{
    XHR_CERT_IGNORE_REVOCATION_FAILED = 0x00000080,
    XHR_CERT_IGNORE_UNKNOWN_CA        = 0x00000100,
    XHR_CERT_IGNORE_CERT_CN_INVALID   = 0x00001000,
    XHR_CERT_IGNORE_CERT_DATE_INVALID = 0x00002000,
    XHR_CERT_IGNORE_ALL_SERVER_ERRORS = 0x00003180,
}
alias XHR_CERT_IGNORE_FLAG = uint;

enum : uint
{
    XHR_CERT_ERROR_REVOCATION_FAILED = 0x00800000,
    XHR_CERT_ERROR_UNKNOWN_CA        = 0x01000000,
    XHR_CERT_ERROR_CERT_CN_INVALID   = 0x02000000,
    XHR_CERT_ERROR_CERT_DATE_INVALID = 0x04000000,
    XHR_CERT_ERROR_ALL_SERVER_ERRORS = 0x07800000,
}
alias XHR_CERT_ERROR_FLAG = uint;

// Structs


struct __msxml6_ReferenceRemainingTypes__
{
    DOMNodeType          __tagDomNodeType__;
    DOMNodeType          __domNodeType__;
    SERVERXMLHTTP_OPTION __serverXmlHttpOptionEnum__;
    SERVERXMLHTTP_OPTION __serverXmlHttpOption__;
    SXH_SERVER_CERT_OPTION __serverCertOptionEnum__;
    SXH_SERVER_CERT_OPTION __serverCertOption__;
    SXH_PROXY_SETTING    __proxySettingEnum__;
    SXH_PROXY_SETTING    __proxySetting__;
    SOMITEMTYPE          __somItemTypeEnum__;
    SOMITEMTYPE          __somItemType__;
    SCHEMAUSE            __schemaUseEnum__;
    SCHEMAUSE            __schemaUse__;
    SCHEMADERIVATIONMETHOD __schemaDerivationMethodEnum__;
    SCHEMADERIVATIONMETHOD __schemaDerivationMethod__;
    SCHEMACONTENTTYPE    __schemaContentTypeEnum__;
    SCHEMACONTENTTYPE    __schemaContentType__;
    SCHEMAPROCESSCONTENTS __schemaProcessContentsEnum__;
    SCHEMAPROCESSCONTENTS __schemaProcessContents__;
    SCHEMAWHITESPACE     __schemaWhitespaceEnum__;
    SCHEMAWHITESPACE     __schemaWhitespace__;
    SCHEMATYPEVARIETY    __schemaTypeVarietyEnum__;
    SCHEMATYPEVARIETY    __schemaTypeVariety__;
}

struct XHR_COOKIE
{
    ushort*  pwszUrl;
    ushort*  pwszName;
    ushort*  pwszValue;
    ushort*  pwszP3PPolicy;
    FILETIME ftExpires;
    uint     dwFlags;
}

struct XHR_CERT
{
    uint   cbCert;
    ubyte* pbCert;
}

// Interfaces

@GUID("88D96A05-F192-11D4-A65F-0040963251E5")
struct DOMDocument60;

@GUID("88D96A06-F192-11D4-A65F-0040963251E5")
struct FreeThreadedDOMDocument60;

@GUID("88D96A07-F192-11D4-A65F-0040963251E5")
struct XMLSchemaCache60;

@GUID("88D96A08-F192-11D4-A65F-0040963251E5")
struct XSLTemplate60;

@GUID("88D96A0A-F192-11D4-A65F-0040963251E5")
struct XMLHTTP60;

@GUID("88D96A09-F192-11D4-A65F-0040963251E5")
struct FreeThreadedXMLHTTP60;

@GUID("88D96A0B-F192-11D4-A65F-0040963251E5")
struct ServerXMLHTTP60;

@GUID("88D96A0C-F192-11D4-A65F-0040963251E5")
struct SAXXMLReader60;

@GUID("88D96A0F-F192-11D4-A65F-0040963251E5")
struct MXXMLWriter60;

@GUID("88D96A10-F192-11D4-A65F-0040963251E5")
struct MXHTMLWriter60;

@GUID("88D96A0E-F192-11D4-A65F-0040963251E5")
struct SAXAttributes60;

@GUID("88D96A11-F192-11D4-A65F-0040963251E5")
struct MXNamespaceManager60;

@GUID("2933BF95-7B36-11D2-B20E-00C04F983E60")
interface IXMLDOMDocument2 : IXMLDOMDocument
{
    HRESULT get_namespaces(IXMLDOMSchemaCollection* namespaceCollection);
    HRESULT get_schemas(VARIANT* otherCollection);
    HRESULT putref_schemas(VARIANT otherCollection);
    HRESULT validate(IXMLDOMParseError* errorObj);
    HRESULT setProperty(BSTR name, VARIANT value);
    HRESULT getProperty(BSTR name, VARIANT* value);
}

@GUID("2933BF96-7B36-11D2-B20E-00C04F983E60")
interface IXMLDOMDocument3 : IXMLDOMDocument2
{
    HRESULT validateNode(IXMLDOMNode node, IXMLDOMParseError* errorObj);
    HRESULT importNode(IXMLDOMNode node, short deep, IXMLDOMNode* clone);
}

@GUID("373984C8-B845-449B-91E7-45AC83036ADE")
interface IXMLDOMSchemaCollection : IDispatch
{
    HRESULT add(BSTR namespaceURI, VARIANT var);
    HRESULT get(BSTR namespaceURI, IXMLDOMNode* schemaNode);
    HRESULT remove(BSTR namespaceURI);
    HRESULT get_length(int* length);
    HRESULT get_namespaceURI(int index, BSTR* length);
    HRESULT addCollection(IXMLDOMSchemaCollection otherCollection);
    HRESULT get__newEnum(IUnknown* ppUnk);
}

@GUID("AA634FC7-5888-44A7-A257-3A47150D3A0E")
interface IXMLDOMSelection : IXMLDOMNodeList
{
    HRESULT get_expr(BSTR* expression);
    HRESULT put_expr(BSTR expression);
    HRESULT get_context(IXMLDOMNode* ppNode);
    HRESULT putref_context(IXMLDOMNode pNode);
    HRESULT peekNode(IXMLDOMNode* ppNode);
    HRESULT matches(IXMLDOMNode pNode, IXMLDOMNode* ppNode);
    HRESULT removeNext(IXMLDOMNode* ppNode);
    HRESULT removeAll();
    HRESULT clone(IXMLDOMSelection* ppNode);
    HRESULT getProperty(BSTR name, VARIANT* value);
    HRESULT setProperty(BSTR name, VARIANT value);
}

@GUID("3EFAA428-272F-11D2-836F-0000F87A7782")
interface IXMLDOMParseError2 : IXMLDOMParseError
{
    HRESULT get_errorXPath(BSTR* xpathexpr);
    HRESULT get_allErrors(IXMLDOMParseErrorCollection* allErrors);
    HRESULT errorParameters(int index, BSTR* param1);
    HRESULT get_errorParametersCount(int* count);
}

@GUID("3EFAA429-272F-11D2-836F-0000F87A7782")
interface IXMLDOMParseErrorCollection : IDispatch
{
    HRESULT get_item(int index, IXMLDOMParseError2* error);
    HRESULT get_length(int* length);
    HRESULT get_next(IXMLDOMParseError2* error);
    HRESULT reset();
    HRESULT get__newEnum(IUnknown* ppunk);
}

@GUID("2933BF92-7B36-11D2-B20E-00C04F983E60")
interface IXSLProcessor : IDispatch
{
    HRESULT put_input(VARIANT var);
    HRESULT get_input(VARIANT* pVar);
    HRESULT get_ownerTemplate(IXSLTemplate* ppTemplate);
    HRESULT setStartMode(BSTR mode, BSTR namespaceURI);
    HRESULT get_startMode(BSTR* mode);
    HRESULT get_startModeURI(BSTR* namespaceURI);
    HRESULT put_output(VARIANT output);
    HRESULT get_output(VARIANT* pOutput);
    HRESULT transform(short* pDone);
    HRESULT reset();
    HRESULT get_readyState(int* pReadyState);
    HRESULT addParameter(BSTR baseName, VARIANT parameter, BSTR namespaceURI);
    HRESULT addObject(IDispatch obj, BSTR namespaceURI);
    HRESULT get_stylesheet(IXMLDOMNode* stylesheet);
}

@GUID("2933BF93-7B36-11D2-B20E-00C04F983E60")
interface IXSLTemplate : IDispatch
{
    HRESULT putref_stylesheet(IXMLDOMNode stylesheet);
    HRESULT get_stylesheet(IXMLDOMNode* stylesheet);
    HRESULT createProcessor(IXSLProcessor* ppProcessor);
}

@GUID("ED8C108D-4349-11D2-91A4-00C04F7969E8")
interface IXMLHTTPRequest : IDispatch
{
    HRESULT open(BSTR bstrMethod, BSTR bstrUrl, VARIANT varAsync, VARIANT bstrUser, VARIANT bstrPassword);
    HRESULT setRequestHeader(BSTR bstrHeader, BSTR bstrValue);
    HRESULT getResponseHeader(BSTR bstrHeader, BSTR* pbstrValue);
    HRESULT getAllResponseHeaders(BSTR* pbstrHeaders);
    HRESULT send(VARIANT varBody);
    HRESULT abort();
    HRESULT get_status(int* plStatus);
    HRESULT get_statusText(BSTR* pbstrStatus);
    HRESULT get_responseXML(IDispatch* ppBody);
    HRESULT get_responseText(BSTR* pbstrBody);
    HRESULT get_responseBody(VARIANT* pvarBody);
    HRESULT get_responseStream(VARIANT* pvarBody);
    HRESULT get_readyState(int* plState);
    HRESULT put_onreadystatechange(IDispatch pReadyStateSink);
}

@GUID("2E9196BF-13BA-4DD4-91CA-6C571F281495")
interface IServerXMLHTTPRequest : IXMLHTTPRequest
{
    HRESULT setTimeouts(int resolveTimeout, int connectTimeout, int sendTimeout, int receiveTimeout);
    HRESULT waitForResponse(VARIANT timeoutInSeconds, short* isSuccessful);
    HRESULT getOption(SERVERXMLHTTP_OPTION option, VARIANT* value);
    HRESULT setOption(SERVERXMLHTTP_OPTION option, VARIANT value);
}

@GUID("2E01311B-C322-4B0A-BD77-B90CFDC8DCE7")
interface IServerXMLHTTPRequest2 : IServerXMLHTTPRequest
{
    HRESULT setProxy(SXH_PROXY_SETTING proxySetting, VARIANT varProxyServer, VARIANT varBypassList);
    HRESULT setProxyCredentials(BSTR bstrUserName, BSTR bstrPassword);
}

@GUID("A4F96ED0-F829-476E-81C0-CDC7BD2A0802")
interface ISAXXMLReader : IUnknown
{
    HRESULT getFeature(const(ushort)* pwchName, short* pvfValue);
    HRESULT putFeature(const(ushort)* pwchName, short vfValue);
    HRESULT getProperty(const(ushort)* pwchName, VARIANT* pvarValue);
    HRESULT putProperty(const(ushort)* pwchName, VARIANT varValue);
    HRESULT getEntityResolver(ISAXEntityResolver* ppResolver);
    HRESULT putEntityResolver(ISAXEntityResolver pResolver);
    HRESULT getContentHandler(ISAXContentHandler* ppHandler);
    HRESULT putContentHandler(ISAXContentHandler pHandler);
    HRESULT getDTDHandler(ISAXDTDHandler* ppHandler);
    HRESULT putDTDHandler(ISAXDTDHandler pHandler);
    HRESULT getErrorHandler(ISAXErrorHandler* ppHandler);
    HRESULT putErrorHandler(ISAXErrorHandler pHandler);
    HRESULT getBaseURL(const(ushort)** ppwchBaseUrl);
    HRESULT putBaseURL(const(ushort)* pwchBaseUrl);
    HRESULT getSecureBaseURL(const(ushort)** ppwchSecureBaseUrl);
    HRESULT putSecureBaseURL(const(ushort)* pwchSecureBaseUrl);
    HRESULT parse(VARIANT varInput);
    HRESULT parseURL(const(ushort)* pwchUrl);
}

@GUID("70409222-CA09-4475-ACB8-40312FE8D145")
interface ISAXXMLFilter : ISAXXMLReader
{
    HRESULT getParent(ISAXXMLReader* ppReader);
    HRESULT putParent(ISAXXMLReader pReader);
}

@GUID("9B7E472A-0DE4-4640-BFF3-84D38A051C31")
interface ISAXLocator : IUnknown
{
    HRESULT getColumnNumber(int* pnColumn);
    HRESULT getLineNumber(int* pnLine);
    HRESULT getPublicId(const(ushort)** ppwchPublicId);
    HRESULT getSystemId(const(ushort)** ppwchSystemId);
}

@GUID("99BCA7BD-E8C4-4D5F-A0CF-6D907901FF07")
interface ISAXEntityResolver : IUnknown
{
    HRESULT resolveEntity(const(ushort)* pwchPublicId, const(ushort)* pwchSystemId, VARIANT* pvarInput);
}

@GUID("1545CDFA-9E4E-4497-A8A4-2BF7D0112C44")
interface ISAXContentHandler : IUnknown
{
    HRESULT putDocumentLocator(ISAXLocator pLocator);
    HRESULT startDocument();
    HRESULT endDocument();
    HRESULT startPrefixMapping(const(ushort)* pwchPrefix, int cchPrefix, const(ushort)* pwchUri, int cchUri);
    HRESULT endPrefixMapping(const(ushort)* pwchPrefix, int cchPrefix);
    HRESULT startElement(const(ushort)* pwchNamespaceUri, int cchNamespaceUri, const(ushort)* pwchLocalName, 
                         int cchLocalName, const(ushort)* pwchQName, int cchQName, ISAXAttributes pAttributes);
    HRESULT endElement(const(ushort)* pwchNamespaceUri, int cchNamespaceUri, const(ushort)* pwchLocalName, 
                       int cchLocalName, const(ushort)* pwchQName, int cchQName);
    HRESULT characters(const(ushort)* pwchChars, int cchChars);
    HRESULT ignorableWhitespace(const(ushort)* pwchChars, int cchChars);
    HRESULT processingInstruction(const(ushort)* pwchTarget, int cchTarget, const(ushort)* pwchData, int cchData);
    HRESULT skippedEntity(const(ushort)* pwchName, int cchName);
}

@GUID("E15C1BAF-AFB3-4D60-8C36-19A8C45DEFED")
interface ISAXDTDHandler : IUnknown
{
    HRESULT notationDecl(const(ushort)* pwchName, int cchName, const(ushort)* pwchPublicId, int cchPublicId, 
                         const(ushort)* pwchSystemId, int cchSystemId);
    HRESULT unparsedEntityDecl(const(ushort)* pwchName, int cchName, const(ushort)* pwchPublicId, int cchPublicId, 
                               const(ushort)* pwchSystemId, int cchSystemId, const(ushort)* pwchNotationName, 
                               int cchNotationName);
}

@GUID("A60511C4-CCF5-479E-98A3-DC8DC545B7D0")
interface ISAXErrorHandler : IUnknown
{
    HRESULT error(ISAXLocator pLocator, const(ushort)* pwchErrorMessage, HRESULT hrErrorCode);
    HRESULT fatalError(ISAXLocator pLocator, const(ushort)* pwchErrorMessage, HRESULT hrErrorCode);
    HRESULT ignorableWarning(ISAXLocator pLocator, const(ushort)* pwchErrorMessage, HRESULT hrErrorCode);
}

@GUID("7F85D5F5-47A8-4497-BDA5-84BA04819EA6")
interface ISAXLexicalHandler : IUnknown
{
    HRESULT startDTD(const(ushort)* pwchName, int cchName, const(ushort)* pwchPublicId, int cchPublicId, 
                     const(ushort)* pwchSystemId, int cchSystemId);
    HRESULT endDTD();
    HRESULT startEntity(const(ushort)* pwchName, int cchName);
    HRESULT endEntity(const(ushort)* pwchName, int cchName);
    HRESULT startCDATA();
    HRESULT endCDATA();
    HRESULT comment(const(ushort)* pwchChars, int cchChars);
}

@GUID("862629AC-771A-47B2-8337-4E6843C1BE90")
interface ISAXDeclHandler : IUnknown
{
    HRESULT elementDecl(const(ushort)* pwchName, int cchName, const(ushort)* pwchModel, int cchModel);
    HRESULT attributeDecl(const(ushort)* pwchElementName, int cchElementName, const(ushort)* pwchAttributeName, 
                          int cchAttributeName, const(ushort)* pwchType, int cchType, 
                          const(ushort)* pwchValueDefault, int cchValueDefault, const(ushort)* pwchValue, 
                          int cchValue);
    HRESULT internalEntityDecl(const(ushort)* pwchName, int cchName, const(ushort)* pwchValue, int cchValue);
    HRESULT externalEntityDecl(const(ushort)* pwchName, int cchName, const(ushort)* pwchPublicId, int cchPublicId, 
                               const(ushort)* pwchSystemId, int cchSystemId);
}

@GUID("F078ABE1-45D2-4832-91EA-4466CE2F25C9")
interface ISAXAttributes : IUnknown
{
    HRESULT getLength(int* pnLength);
    HRESULT getURI(int nIndex, const(ushort)** ppwchUri, int* pcchUri);
    HRESULT getLocalName(int nIndex, const(ushort)** ppwchLocalName, int* pcchLocalName);
    HRESULT getQName(int nIndex, const(ushort)** ppwchQName, int* pcchQName);
    HRESULT getName(int nIndex, const(ushort)** ppwchUri, int* pcchUri, const(ushort)** ppwchLocalName, 
                    int* pcchLocalName, const(ushort)** ppwchQName, int* pcchQName);
    HRESULT getIndexFromName(const(ushort)* pwchUri, int cchUri, const(ushort)* pwchLocalName, int cchLocalName, 
                             int* pnIndex);
    HRESULT getIndexFromQName(const(ushort)* pwchQName, int cchQName, int* pnIndex);
    HRESULT getType(int nIndex, const(ushort)** ppwchType, int* pcchType);
    HRESULT getTypeFromName(const(ushort)* pwchUri, int cchUri, const(ushort)* pwchLocalName, int cchLocalName, 
                            const(ushort)** ppwchType, int* pcchType);
    HRESULT getTypeFromQName(const(ushort)* pwchQName, int cchQName, const(ushort)** ppwchType, int* pcchType);
    HRESULT getValue(int nIndex, const(ushort)** ppwchValue, int* pcchValue);
    HRESULT getValueFromName(const(ushort)* pwchUri, int cchUri, const(ushort)* pwchLocalName, int cchLocalName, 
                             const(ushort)** ppwchValue, int* pcchValue);
    HRESULT getValueFromQName(const(ushort)* pwchQName, int cchQName, const(ushort)** ppwchValue, int* pcchValue);
}

@GUID("8C033CAA-6CD6-4F73-B728-4531AF74945F")
interface IVBSAXXMLReader : IDispatch
{
    HRESULT getFeature(BSTR strName, short* fValue);
    HRESULT putFeature(BSTR strName, short fValue);
    HRESULT getProperty(BSTR strName, VARIANT* varValue);
    HRESULT putProperty(BSTR strName, VARIANT varValue);
    HRESULT get_entityResolver(IVBSAXEntityResolver* oResolver);
    HRESULT putref_entityResolver(IVBSAXEntityResolver oResolver);
    HRESULT get_contentHandler(IVBSAXContentHandler* oHandler);
    HRESULT putref_contentHandler(IVBSAXContentHandler oHandler);
    HRESULT get_dtdHandler(IVBSAXDTDHandler* oHandler);
    HRESULT putref_dtdHandler(IVBSAXDTDHandler oHandler);
    HRESULT get_errorHandler(IVBSAXErrorHandler* oHandler);
    HRESULT putref_errorHandler(IVBSAXErrorHandler oHandler);
    HRESULT get_baseURL(BSTR* strBaseURL);
    HRESULT put_baseURL(BSTR strBaseURL);
    HRESULT get_secureBaseURL(BSTR* strSecureBaseURL);
    HRESULT put_secureBaseURL(BSTR strSecureBaseURL);
    HRESULT parse(VARIANT varInput);
    HRESULT parseURL(BSTR strURL);
}

@GUID("1299EB1B-5B88-433E-82DE-82CA75AD4E04")
interface IVBSAXXMLFilter : IDispatch
{
    HRESULT get_parent(IVBSAXXMLReader* oReader);
    HRESULT putref_parent(IVBSAXXMLReader oReader);
}

@GUID("796E7AC5-5AA2-4EFF-ACAD-3FAAF01A3288")
interface IVBSAXLocator : IDispatch
{
    HRESULT get_columnNumber(int* nColumn);
    HRESULT get_lineNumber(int* nLine);
    HRESULT get_publicId(BSTR* strPublicId);
    HRESULT get_systemId(BSTR* strSystemId);
}

@GUID("0C05D096-F45B-4ACA-AD1A-AA0BC25518DC")
interface IVBSAXEntityResolver : IDispatch
{
    HRESULT resolveEntity(BSTR* strPublicId, BSTR* strSystemId, VARIANT* varInput);
}

@GUID("2ED7290A-4DD5-4B46-BB26-4E4155E77FAA")
interface IVBSAXContentHandler : IDispatch
{
    HRESULT putref_documentLocator(IVBSAXLocator oLocator);
    HRESULT startDocument();
    HRESULT endDocument();
    HRESULT startPrefixMapping(BSTR* strPrefix, BSTR* strURI);
    HRESULT endPrefixMapping(BSTR* strPrefix);
    HRESULT startElement(BSTR* strNamespaceURI, BSTR* strLocalName, BSTR* strQName, IVBSAXAttributes oAttributes);
    HRESULT endElement(BSTR* strNamespaceURI, BSTR* strLocalName, BSTR* strQName);
    HRESULT characters(BSTR* strChars);
    HRESULT ignorableWhitespace(BSTR* strChars);
    HRESULT processingInstruction(BSTR* strTarget, BSTR* strData);
    HRESULT skippedEntity(BSTR* strName);
}

@GUID("24FB3297-302D-4620-BA39-3A732D850558")
interface IVBSAXDTDHandler : IDispatch
{
    HRESULT notationDecl(BSTR* strName, BSTR* strPublicId, BSTR* strSystemId);
    HRESULT unparsedEntityDecl(BSTR* strName, BSTR* strPublicId, BSTR* strSystemId, BSTR* strNotationName);
}

@GUID("D963D3FE-173C-4862-9095-B92F66995F52")
interface IVBSAXErrorHandler : IDispatch
{
    HRESULT error(IVBSAXLocator oLocator, BSTR* strErrorMessage, int nErrorCode);
    HRESULT fatalError(IVBSAXLocator oLocator, BSTR* strErrorMessage, int nErrorCode);
    HRESULT ignorableWarning(IVBSAXLocator oLocator, BSTR* strErrorMessage, int nErrorCode);
}

@GUID("032AAC35-8C0E-4D9D-979F-E3B702935576")
interface IVBSAXLexicalHandler : IDispatch
{
    HRESULT startDTD(BSTR* strName, BSTR* strPublicId, BSTR* strSystemId);
    HRESULT endDTD();
    HRESULT startEntity(BSTR* strName);
    HRESULT endEntity(BSTR* strName);
    HRESULT startCDATA();
    HRESULT endCDATA();
    HRESULT comment(BSTR* strChars);
}

@GUID("E8917260-7579-4BE1-B5DD-7AFBFA6F077B")
interface IVBSAXDeclHandler : IDispatch
{
    HRESULT elementDecl(BSTR* strName, BSTR* strModel);
    HRESULT attributeDecl(BSTR* strElementName, BSTR* strAttributeName, BSTR* strType, BSTR* strValueDefault, 
                          BSTR* strValue);
    HRESULT internalEntityDecl(BSTR* strName, BSTR* strValue);
    HRESULT externalEntityDecl(BSTR* strName, BSTR* strPublicId, BSTR* strSystemId);
}

@GUID("10DC0586-132B-4CAC-8BB3-DB00AC8B7EE0")
interface IVBSAXAttributes : IDispatch
{
    HRESULT get_length(int* nLength);
    HRESULT getURI(int nIndex, BSTR* strURI);
    HRESULT getLocalName(int nIndex, BSTR* strLocalName);
    HRESULT getQName(int nIndex, BSTR* strQName);
    HRESULT getIndexFromName(BSTR strURI, BSTR strLocalName, int* nIndex);
    HRESULT getIndexFromQName(BSTR strQName, int* nIndex);
    HRESULT getType(int nIndex, BSTR* strType);
    HRESULT getTypeFromName(BSTR strURI, BSTR strLocalName, BSTR* strType);
    HRESULT getTypeFromQName(BSTR strQName, BSTR* strType);
    HRESULT getValue(int nIndex, BSTR* strValue);
    HRESULT getValueFromName(BSTR strURI, BSTR strLocalName, BSTR* strValue);
    HRESULT getValueFromQName(BSTR strQName, BSTR* strValue);
}

@GUID("4D7FF4BA-1565-4EA8-94E1-6E724A46F98D")
interface IMXWriter : IDispatch
{
    HRESULT put_output(VARIANT varDestination);
    HRESULT get_output(VARIANT* varDestination);
    HRESULT put_encoding(BSTR strEncoding);
    HRESULT get_encoding(BSTR* strEncoding);
    HRESULT put_byteOrderMark(short fWriteByteOrderMark);
    HRESULT get_byteOrderMark(short* fWriteByteOrderMark);
    HRESULT put_indent(short fIndentMode);
    HRESULT get_indent(short* fIndentMode);
    HRESULT put_standalone(short fValue);
    HRESULT get_standalone(short* fValue);
    HRESULT put_omitXMLDeclaration(short fValue);
    HRESULT get_omitXMLDeclaration(short* fValue);
    HRESULT put_version(BSTR strVersion);
    HRESULT get_version(BSTR* strVersion);
    HRESULT put_disableOutputEscaping(short fValue);
    HRESULT get_disableOutputEscaping(short* fValue);
    HRESULT flush();
}

@GUID("F10D27CC-3EC0-415C-8ED8-77AB1C5E7262")
interface IMXAttributes : IDispatch
{
    HRESULT addAttribute(BSTR strURI, BSTR strLocalName, BSTR strQName, BSTR strType, BSTR strValue);
    HRESULT addAttributeFromIndex(VARIANT varAtts, int nIndex);
    HRESULT clear();
    HRESULT removeAttribute(int nIndex);
    HRESULT setAttribute(int nIndex, BSTR strURI, BSTR strLocalName, BSTR strQName, BSTR strType, BSTR strValue);
    HRESULT setAttributes(VARIANT varAtts);
    HRESULT setLocalName(int nIndex, BSTR strLocalName);
    HRESULT setQName(int nIndex, BSTR strQName);
    HRESULT setType(int nIndex, BSTR strType);
    HRESULT setURI(int nIndex, BSTR strURI);
    HRESULT setValue(int nIndex, BSTR strValue);
}

@GUID("808F4E35-8D5A-4FBE-8466-33A41279ED30")
interface IMXReaderControl : IDispatch
{
    HRESULT abort();
    HRESULT resume();
    HRESULT suspend();
}

@GUID("FA4BB38C-FAF9-4CCA-9302-D1DD0FE520DB")
interface IMXSchemaDeclHandler : IDispatch
{
    HRESULT schemaElementDecl(ISchemaElement oSchemaElement);
}

@GUID("C90352F4-643C-4FBC-BB23-E996EB2D51FD")
interface IMXNamespacePrefixes : IDispatch
{
    HRESULT get_item(int index, BSTR* prefix);
    HRESULT get_length(int* length);
    HRESULT get__newEnum(IUnknown* ppUnk);
}

@GUID("C90352F5-643C-4FBC-BB23-E996EB2D51FD")
interface IVBMXNamespaceManager : IDispatch
{
    HRESULT put_allowOverride(short fOverride);
    HRESULT get_allowOverride(short* fOverride);
    HRESULT reset();
    HRESULT pushContext();
    HRESULT pushNodeContext(IXMLDOMNode contextNode, short fDeep);
    HRESULT popContext();
    HRESULT declarePrefix(BSTR prefix, BSTR namespaceURI);
    HRESULT getDeclaredPrefixes(IMXNamespacePrefixes* prefixes);
    HRESULT getPrefixes(BSTR namespaceURI, IMXNamespacePrefixes* prefixes);
    HRESULT getURI(BSTR prefix, VARIANT* uri);
    HRESULT getURIFromNode(BSTR strPrefix, IXMLDOMNode contextNode, VARIANT* uri);
}

@GUID("C90352F6-643C-4FBC-BB23-E996EB2D51FD")
interface IMXNamespaceManager : IUnknown
{
    HRESULT putAllowOverride(short fOverride);
    HRESULT getAllowOverride(short* fOverride);
    HRESULT reset();
    HRESULT pushContext();
    HRESULT pushNodeContext(IXMLDOMNode contextNode, short fDeep);
    HRESULT popContext();
    HRESULT declarePrefix(const(wchar)* prefix, const(wchar)* namespaceURI);
    HRESULT getDeclaredPrefix(int nIndex, char* pwchPrefix, int* pcchPrefix);
    HRESULT getPrefix(const(wchar)* pwszNamespaceURI, int nIndex, char* pwchPrefix, int* pcchPrefix);
    HRESULT getURI(const(wchar)* pwchPrefix, IXMLDOMNode pContextNode, char* pwchUri, int* pcchUri);
}

@GUID("C90352F7-643C-4FBC-BB23-E996EB2D51FD")
interface IMXXMLFilter : IDispatch
{
    HRESULT getFeature(BSTR strName, short* fValue);
    HRESULT putFeature(BSTR strName, short fValue);
    HRESULT getProperty(BSTR strName, VARIANT* varValue);
    HRESULT putProperty(BSTR strName, VARIANT varValue);
    HRESULT get_entityResolver(IUnknown* oResolver);
    HRESULT putref_entityResolver(IUnknown oResolver);
    HRESULT get_contentHandler(IUnknown* oHandler);
    HRESULT putref_contentHandler(IUnknown oHandler);
    HRESULT get_dtdHandler(IUnknown* oHandler);
    HRESULT putref_dtdHandler(IUnknown oHandler);
    HRESULT get_errorHandler(IUnknown* oHandler);
    HRESULT putref_errorHandler(IUnknown oHandler);
}

@GUID("50EA08B0-DD1B-4664-9A50-C2F40F4BD79A")
interface IXMLDOMSchemaCollection2 : IXMLDOMSchemaCollection
{
    HRESULT validate();
    HRESULT put_validateOnLoad(short validateOnLoad);
    HRESULT get_validateOnLoad(short* validateOnLoad);
    HRESULT getSchema(BSTR namespaceURI, ISchema* schema);
    HRESULT getDeclaration(IXMLDOMNode node, ISchemaItem* item);
}

@GUID("50EA08B1-DD1B-4664-9A50-C2F40F4BD79A")
interface ISchemaStringCollection : IDispatch
{
    HRESULT get_item(int index, BSTR* bstr);
    HRESULT get_length(int* length);
    HRESULT get__newEnum(IUnknown* ppunk);
}

@GUID("50EA08B2-DD1B-4664-9A50-C2F40F4BD79A")
interface ISchemaItemCollection : IDispatch
{
    HRESULT get_item(int index, ISchemaItem* item);
    HRESULT itemByName(BSTR name, ISchemaItem* item);
    HRESULT itemByQName(BSTR name, BSTR namespaceURI, ISchemaItem* item);
    HRESULT get_length(int* length);
    HRESULT get__newEnum(IUnknown* ppunk);
}

@GUID("50EA08B3-DD1B-4664-9A50-C2F40F4BD79A")
interface ISchemaItem : IDispatch
{
    HRESULT get_name(BSTR* name);
    HRESULT get_namespaceURI(BSTR* namespaceURI);
    HRESULT get_schema(ISchema* schema);
    HRESULT get_id(BSTR* id);
    HRESULT get_itemType(SOMITEMTYPE* itemType);
    HRESULT get_unhandledAttributes(IVBSAXAttributes* attributes);
    HRESULT writeAnnotation(IUnknown annotationSink, short* isWritten);
}

@GUID("50EA08B4-DD1B-4664-9A50-C2F40F4BD79A")
interface ISchema : ISchemaItem
{
    HRESULT get_targetNamespace(BSTR* targetNamespace);
    HRESULT get_version(BSTR* version_);
    HRESULT get_types(ISchemaItemCollection* types);
    HRESULT get_elements(ISchemaItemCollection* elements);
    HRESULT get_attributes(ISchemaItemCollection* attributes);
    HRESULT get_attributeGroups(ISchemaItemCollection* attributeGroups);
    HRESULT get_modelGroups(ISchemaItemCollection* modelGroups);
    HRESULT get_notations(ISchemaItemCollection* notations);
    HRESULT get_schemaLocations(ISchemaStringCollection* schemaLocations);
}

@GUID("50EA08B5-DD1B-4664-9A50-C2F40F4BD79A")
interface ISchemaParticle : ISchemaItem
{
    HRESULT get_minOccurs(VARIANT* minOccurs);
    HRESULT get_maxOccurs(VARIANT* maxOccurs);
}

@GUID("50EA08B6-DD1B-4664-9A50-C2F40F4BD79A")
interface ISchemaAttribute : ISchemaItem
{
    HRESULT get_type(ISchemaType* type);
    HRESULT get_scope(ISchemaComplexType* scope_);
    HRESULT get_defaultValue(BSTR* defaultValue);
    HRESULT get_fixedValue(BSTR* fixedValue);
    HRESULT get_use(SCHEMAUSE* use);
    HRESULT get_isReference(short* reference);
}

@GUID("50EA08B7-DD1B-4664-9A50-C2F40F4BD79A")
interface ISchemaElement : ISchemaParticle
{
    HRESULT get_type(ISchemaType* type);
    HRESULT get_scope(ISchemaComplexType* scope_);
    HRESULT get_defaultValue(BSTR* defaultValue);
    HRESULT get_fixedValue(BSTR* fixedValue);
    HRESULT get_isNillable(short* nillable);
    HRESULT get_identityConstraints(ISchemaItemCollection* constraints);
    HRESULT get_substitutionGroup(ISchemaElement* element);
    HRESULT get_substitutionGroupExclusions(SCHEMADERIVATIONMETHOD* exclusions);
    HRESULT get_disallowedSubstitutions(SCHEMADERIVATIONMETHOD* disallowed);
    HRESULT get_isAbstract(short* abstract_);
    HRESULT get_isReference(short* reference);
}

@GUID("50EA08B8-DD1B-4664-9A50-C2F40F4BD79A")
interface ISchemaType : ISchemaItem
{
    HRESULT get_baseTypes(ISchemaItemCollection* baseTypes);
    HRESULT get_final(SCHEMADERIVATIONMETHOD* final_);
    HRESULT get_variety(SCHEMATYPEVARIETY* variety);
    HRESULT get_derivedBy(SCHEMADERIVATIONMETHOD* derivedBy);
    HRESULT isValid(BSTR data, short* valid);
    HRESULT get_minExclusive(BSTR* minExclusive);
    HRESULT get_minInclusive(BSTR* minInclusive);
    HRESULT get_maxExclusive(BSTR* maxExclusive);
    HRESULT get_maxInclusive(BSTR* maxInclusive);
    HRESULT get_totalDigits(VARIANT* totalDigits);
    HRESULT get_fractionDigits(VARIANT* fractionDigits);
    HRESULT get_length(VARIANT* length);
    HRESULT get_minLength(VARIANT* minLength);
    HRESULT get_maxLength(VARIANT* maxLength);
    HRESULT get_enumeration(ISchemaStringCollection* enumeration);
    HRESULT get_whitespace(SCHEMAWHITESPACE* whitespace);
    HRESULT get_patterns(ISchemaStringCollection* patterns);
}

@GUID("50EA08B9-DD1B-4664-9A50-C2F40F4BD79A")
interface ISchemaComplexType : ISchemaType
{
    HRESULT get_isAbstract(short* abstract_);
    HRESULT get_anyAttribute(ISchemaAny* anyAttribute);
    HRESULT get_attributes(ISchemaItemCollection* attributes);
    HRESULT get_contentType(SCHEMACONTENTTYPE* contentType);
    HRESULT get_contentModel(ISchemaModelGroup* contentModel);
    HRESULT get_prohibitedSubstitutions(SCHEMADERIVATIONMETHOD* prohibited);
}

@GUID("50EA08BA-DD1B-4664-9A50-C2F40F4BD79A")
interface ISchemaAttributeGroup : ISchemaItem
{
    HRESULT get_anyAttribute(ISchemaAny* anyAttribute);
    HRESULT get_attributes(ISchemaItemCollection* attributes);
}

@GUID("50EA08BB-DD1B-4664-9A50-C2F40F4BD79A")
interface ISchemaModelGroup : ISchemaParticle
{
    HRESULT get_particles(ISchemaItemCollection* particles);
}

@GUID("50EA08BC-DD1B-4664-9A50-C2F40F4BD79A")
interface ISchemaAny : ISchemaParticle
{
    HRESULT get_namespaces(ISchemaStringCollection* namespaces);
    HRESULT get_processContents(SCHEMAPROCESSCONTENTS* processContents);
}

@GUID("50EA08BD-DD1B-4664-9A50-C2F40F4BD79A")
interface ISchemaIdentityConstraint : ISchemaItem
{
    HRESULT get_selector(BSTR* selector);
    HRESULT get_fields(ISchemaStringCollection* fields);
    HRESULT get_referencedKey(ISchemaIdentityConstraint* key);
}

@GUID("50EA08BE-DD1B-4664-9A50-C2F40F4BD79A")
interface ISchemaNotation : ISchemaItem
{
    HRESULT get_systemIdentifier(BSTR* uri);
    HRESULT get_publicIdentifier(BSTR* uri);
}

@GUID("A44A9299-E321-40DE-8866-341B41669162")
interface IXMLHTTPRequest2Callback : IUnknown
{
    HRESULT OnRedirect(IXMLHTTPRequest2 pXHR, const(wchar)* pwszRedirectUrl);
    HRESULT OnHeadersAvailable(IXMLHTTPRequest2 pXHR, uint dwStatus, const(wchar)* pwszStatus);
    HRESULT OnDataAvailable(IXMLHTTPRequest2 pXHR, ISequentialStream pResponseStream);
    HRESULT OnResponseReceived(IXMLHTTPRequest2 pXHR, ISequentialStream pResponseStream);
    HRESULT OnError(IXMLHTTPRequest2 pXHR, HRESULT hrError);
}

@GUID("E5D37DC0-552A-4D52-9CC0-A14D546FBD04")
interface IXMLHTTPRequest2 : IUnknown
{
    HRESULT Open(const(wchar)* pwszMethod, const(wchar)* pwszUrl, IXMLHTTPRequest2Callback pStatusCallback, 
                 const(wchar)* pwszUserName, const(wchar)* pwszPassword, const(wchar)* pwszProxyUserName, 
                 const(wchar)* pwszProxyPassword);
    HRESULT Send(ISequentialStream pBody, ulong cbBody);
    HRESULT Abort();
    HRESULT SetCookie(const(XHR_COOKIE)* pCookie, uint* pdwCookieState);
    HRESULT SetCustomResponseStream(ISequentialStream pSequentialStream);
    HRESULT SetProperty(XHR_PROPERTY eProperty, ulong ullValue);
    HRESULT SetRequestHeader(const(wchar)* pwszHeader, const(wchar)* pwszValue);
    HRESULT GetAllResponseHeaders(ushort** ppwszHeaders);
    HRESULT GetCookie(const(wchar)* pwszUrl, const(wchar)* pwszName, uint dwFlags, uint* pcCookies, 
                      char* ppCookies);
    HRESULT GetResponseHeader(const(wchar)* pwszHeader, ushort** ppwszValue);
}

@GUID("B9E57830-8C6C-4A6F-9C13-47772BB047BB")
interface IXMLHTTPRequest3Callback : IXMLHTTPRequest2Callback
{
    HRESULT OnServerCertificateReceived(IXMLHTTPRequest3 pXHR, uint dwCertificateErrors, 
                                        uint cServerCertificateChain, char* rgServerCertificateChain);
    HRESULT OnClientCertificateRequested(IXMLHTTPRequest3 pXHR, uint cIssuerList, char* rgpwszIssuerList);
}

@GUID("A1C9FEEE-0617-4F23-9D58-8961EA43567C")
interface IXMLHTTPRequest3 : IXMLHTTPRequest2
{
    HRESULT SetClientCertificate(uint cbClientCertificateHash, char* pbClientCertificateHash, 
                                 const(wchar)* pwszPin);
}


// GUIDs

const GUID CLSID_DOMDocument60             = GUIDOF!DOMDocument60;
const GUID CLSID_FreeThreadedDOMDocument60 = GUIDOF!FreeThreadedDOMDocument60;
const GUID CLSID_FreeThreadedXMLHTTP60     = GUIDOF!FreeThreadedXMLHTTP60;
const GUID CLSID_MXHTMLWriter60            = GUIDOF!MXHTMLWriter60;
const GUID CLSID_MXNamespaceManager60      = GUIDOF!MXNamespaceManager60;
const GUID CLSID_MXXMLWriter60             = GUIDOF!MXXMLWriter60;
const GUID CLSID_SAXAttributes60           = GUIDOF!SAXAttributes60;
const GUID CLSID_SAXXMLReader60            = GUIDOF!SAXXMLReader60;
const GUID CLSID_ServerXMLHTTP60           = GUIDOF!ServerXMLHTTP60;
const GUID CLSID_XMLHTTP60                 = GUIDOF!XMLHTTP60;
const GUID CLSID_XMLSchemaCache60          = GUIDOF!XMLSchemaCache60;
const GUID CLSID_XSLTemplate60             = GUIDOF!XSLTemplate60;

const GUID IID_IMXAttributes               = GUIDOF!IMXAttributes;
const GUID IID_IMXNamespaceManager         = GUIDOF!IMXNamespaceManager;
const GUID IID_IMXNamespacePrefixes        = GUIDOF!IMXNamespacePrefixes;
const GUID IID_IMXReaderControl            = GUIDOF!IMXReaderControl;
const GUID IID_IMXSchemaDeclHandler        = GUIDOF!IMXSchemaDeclHandler;
const GUID IID_IMXWriter                   = GUIDOF!IMXWriter;
const GUID IID_IMXXMLFilter                = GUIDOF!IMXXMLFilter;
const GUID IID_ISAXAttributes              = GUIDOF!ISAXAttributes;
const GUID IID_ISAXContentHandler          = GUIDOF!ISAXContentHandler;
const GUID IID_ISAXDTDHandler              = GUIDOF!ISAXDTDHandler;
const GUID IID_ISAXDeclHandler             = GUIDOF!ISAXDeclHandler;
const GUID IID_ISAXEntityResolver          = GUIDOF!ISAXEntityResolver;
const GUID IID_ISAXErrorHandler            = GUIDOF!ISAXErrorHandler;
const GUID IID_ISAXLexicalHandler          = GUIDOF!ISAXLexicalHandler;
const GUID IID_ISAXLocator                 = GUIDOF!ISAXLocator;
const GUID IID_ISAXXMLFilter               = GUIDOF!ISAXXMLFilter;
const GUID IID_ISAXXMLReader               = GUIDOF!ISAXXMLReader;
const GUID IID_ISchema                     = GUIDOF!ISchema;
const GUID IID_ISchemaAny                  = GUIDOF!ISchemaAny;
const GUID IID_ISchemaAttribute            = GUIDOF!ISchemaAttribute;
const GUID IID_ISchemaAttributeGroup       = GUIDOF!ISchemaAttributeGroup;
const GUID IID_ISchemaComplexType          = GUIDOF!ISchemaComplexType;
const GUID IID_ISchemaElement              = GUIDOF!ISchemaElement;
const GUID IID_ISchemaIdentityConstraint   = GUIDOF!ISchemaIdentityConstraint;
const GUID IID_ISchemaItem                 = GUIDOF!ISchemaItem;
const GUID IID_ISchemaItemCollection       = GUIDOF!ISchemaItemCollection;
const GUID IID_ISchemaModelGroup           = GUIDOF!ISchemaModelGroup;
const GUID IID_ISchemaNotation             = GUIDOF!ISchemaNotation;
const GUID IID_ISchemaParticle             = GUIDOF!ISchemaParticle;
const GUID IID_ISchemaStringCollection     = GUIDOF!ISchemaStringCollection;
const GUID IID_ISchemaType                 = GUIDOF!ISchemaType;
const GUID IID_IServerXMLHTTPRequest       = GUIDOF!IServerXMLHTTPRequest;
const GUID IID_IServerXMLHTTPRequest2      = GUIDOF!IServerXMLHTTPRequest2;
const GUID IID_IVBMXNamespaceManager       = GUIDOF!IVBMXNamespaceManager;
const GUID IID_IVBSAXAttributes            = GUIDOF!IVBSAXAttributes;
const GUID IID_IVBSAXContentHandler        = GUIDOF!IVBSAXContentHandler;
const GUID IID_IVBSAXDTDHandler            = GUIDOF!IVBSAXDTDHandler;
const GUID IID_IVBSAXDeclHandler           = GUIDOF!IVBSAXDeclHandler;
const GUID IID_IVBSAXEntityResolver        = GUIDOF!IVBSAXEntityResolver;
const GUID IID_IVBSAXErrorHandler          = GUIDOF!IVBSAXErrorHandler;
const GUID IID_IVBSAXLexicalHandler        = GUIDOF!IVBSAXLexicalHandler;
const GUID IID_IVBSAXLocator               = GUIDOF!IVBSAXLocator;
const GUID IID_IVBSAXXMLFilter             = GUIDOF!IVBSAXXMLFilter;
const GUID IID_IVBSAXXMLReader             = GUIDOF!IVBSAXXMLReader;
const GUID IID_IXMLDOMDocument2            = GUIDOF!IXMLDOMDocument2;
const GUID IID_IXMLDOMDocument3            = GUIDOF!IXMLDOMDocument3;
const GUID IID_IXMLDOMParseError2          = GUIDOF!IXMLDOMParseError2;
const GUID IID_IXMLDOMParseErrorCollection = GUIDOF!IXMLDOMParseErrorCollection;
const GUID IID_IXMLDOMSchemaCollection     = GUIDOF!IXMLDOMSchemaCollection;
const GUID IID_IXMLDOMSchemaCollection2    = GUIDOF!IXMLDOMSchemaCollection2;
const GUID IID_IXMLDOMSelection            = GUIDOF!IXMLDOMSelection;
const GUID IID_IXMLHTTPRequest             = GUIDOF!IXMLHTTPRequest;
const GUID IID_IXMLHTTPRequest2            = GUIDOF!IXMLHTTPRequest2;
const GUID IID_IXMLHTTPRequest2Callback    = GUIDOF!IXMLHTTPRequest2Callback;
const GUID IID_IXMLHTTPRequest3            = GUIDOF!IXMLHTTPRequest3;
const GUID IID_IXMLHTTPRequest3Callback    = GUIDOF!IXMLHTTPRequest3Callback;
const GUID IID_IXSLProcessor               = GUIDOF!IXSLProcessor;
const GUID IID_IXSLTemplate                = GUIDOF!IXSLTemplate;
