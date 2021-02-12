module windows.xmlhttpextendedrequest;

public import windows.automation;
public import windows.com;
public import windows.structuredstorage;
public import windows.windowsprogramming;

extern(Windows):

const GUID CLSID_DOMDocument60 = {0x88D96A05, 0xF192, 0x11D4, [0xA6, 0x5F, 0x00, 0x40, 0x96, 0x32, 0x51, 0xE5]};
@GUID(0x88D96A05, 0xF192, 0x11D4, [0xA6, 0x5F, 0x00, 0x40, 0x96, 0x32, 0x51, 0xE5]);
struct DOMDocument60;

const GUID CLSID_FreeThreadedDOMDocument60 = {0x88D96A06, 0xF192, 0x11D4, [0xA6, 0x5F, 0x00, 0x40, 0x96, 0x32, 0x51, 0xE5]};
@GUID(0x88D96A06, 0xF192, 0x11D4, [0xA6, 0x5F, 0x00, 0x40, 0x96, 0x32, 0x51, 0xE5]);
struct FreeThreadedDOMDocument60;

const GUID CLSID_XMLSchemaCache60 = {0x88D96A07, 0xF192, 0x11D4, [0xA6, 0x5F, 0x00, 0x40, 0x96, 0x32, 0x51, 0xE5]};
@GUID(0x88D96A07, 0xF192, 0x11D4, [0xA6, 0x5F, 0x00, 0x40, 0x96, 0x32, 0x51, 0xE5]);
struct XMLSchemaCache60;

const GUID CLSID_XSLTemplate60 = {0x88D96A08, 0xF192, 0x11D4, [0xA6, 0x5F, 0x00, 0x40, 0x96, 0x32, 0x51, 0xE5]};
@GUID(0x88D96A08, 0xF192, 0x11D4, [0xA6, 0x5F, 0x00, 0x40, 0x96, 0x32, 0x51, 0xE5]);
struct XSLTemplate60;

const GUID CLSID_XMLHTTP60 = {0x88D96A0A, 0xF192, 0x11D4, [0xA6, 0x5F, 0x00, 0x40, 0x96, 0x32, 0x51, 0xE5]};
@GUID(0x88D96A0A, 0xF192, 0x11D4, [0xA6, 0x5F, 0x00, 0x40, 0x96, 0x32, 0x51, 0xE5]);
struct XMLHTTP60;

const GUID CLSID_FreeThreadedXMLHTTP60 = {0x88D96A09, 0xF192, 0x11D4, [0xA6, 0x5F, 0x00, 0x40, 0x96, 0x32, 0x51, 0xE5]};
@GUID(0x88D96A09, 0xF192, 0x11D4, [0xA6, 0x5F, 0x00, 0x40, 0x96, 0x32, 0x51, 0xE5]);
struct FreeThreadedXMLHTTP60;

const GUID CLSID_ServerXMLHTTP60 = {0x88D96A0B, 0xF192, 0x11D4, [0xA6, 0x5F, 0x00, 0x40, 0x96, 0x32, 0x51, 0xE5]};
@GUID(0x88D96A0B, 0xF192, 0x11D4, [0xA6, 0x5F, 0x00, 0x40, 0x96, 0x32, 0x51, 0xE5]);
struct ServerXMLHTTP60;

const GUID CLSID_SAXXMLReader60 = {0x88D96A0C, 0xF192, 0x11D4, [0xA6, 0x5F, 0x00, 0x40, 0x96, 0x32, 0x51, 0xE5]};
@GUID(0x88D96A0C, 0xF192, 0x11D4, [0xA6, 0x5F, 0x00, 0x40, 0x96, 0x32, 0x51, 0xE5]);
struct SAXXMLReader60;

const GUID CLSID_MXXMLWriter60 = {0x88D96A0F, 0xF192, 0x11D4, [0xA6, 0x5F, 0x00, 0x40, 0x96, 0x32, 0x51, 0xE5]};
@GUID(0x88D96A0F, 0xF192, 0x11D4, [0xA6, 0x5F, 0x00, 0x40, 0x96, 0x32, 0x51, 0xE5]);
struct MXXMLWriter60;

const GUID CLSID_MXHTMLWriter60 = {0x88D96A10, 0xF192, 0x11D4, [0xA6, 0x5F, 0x00, 0x40, 0x96, 0x32, 0x51, 0xE5]};
@GUID(0x88D96A10, 0xF192, 0x11D4, [0xA6, 0x5F, 0x00, 0x40, 0x96, 0x32, 0x51, 0xE5]);
struct MXHTMLWriter60;

const GUID CLSID_SAXAttributes60 = {0x88D96A0E, 0xF192, 0x11D4, [0xA6, 0x5F, 0x00, 0x40, 0x96, 0x32, 0x51, 0xE5]};
@GUID(0x88D96A0E, 0xF192, 0x11D4, [0xA6, 0x5F, 0x00, 0x40, 0x96, 0x32, 0x51, 0xE5]);
struct SAXAttributes60;

const GUID CLSID_MXNamespaceManager60 = {0x88D96A11, 0xF192, 0x11D4, [0xA6, 0x5F, 0x00, 0x40, 0x96, 0x32, 0x51, 0xE5]};
@GUID(0x88D96A11, 0xF192, 0x11D4, [0xA6, 0x5F, 0x00, 0x40, 0x96, 0x32, 0x51, 0xE5]);
struct MXNamespaceManager60;

const GUID IID_IXMLDOMDocument2 = {0x2933BF95, 0x7B36, 0x11D2, [0xB2, 0x0E, 0x00, 0xC0, 0x4F, 0x98, 0x3E, 0x60]};
@GUID(0x2933BF95, 0x7B36, 0x11D2, [0xB2, 0x0E, 0x00, 0xC0, 0x4F, 0x98, 0x3E, 0x60]);
interface IXMLDOMDocument2 : IXMLDOMDocument
{
    HRESULT get_namespaces(IXMLDOMSchemaCollection* namespaceCollection);
    HRESULT get_schemas(VARIANT* otherCollection);
    HRESULT putref_schemas(VARIANT otherCollection);
    HRESULT validate(IXMLDOMParseError* errorObj);
    HRESULT setProperty(BSTR name, VARIANT value);
    HRESULT getProperty(BSTR name, VARIANT* value);
}

const GUID IID_IXMLDOMDocument3 = {0x2933BF96, 0x7B36, 0x11D2, [0xB2, 0x0E, 0x00, 0xC0, 0x4F, 0x98, 0x3E, 0x60]};
@GUID(0x2933BF96, 0x7B36, 0x11D2, [0xB2, 0x0E, 0x00, 0xC0, 0x4F, 0x98, 0x3E, 0x60]);
interface IXMLDOMDocument3 : IXMLDOMDocument2
{
    HRESULT validateNode(IXMLDOMNode node, IXMLDOMParseError* errorObj);
    HRESULT importNode(IXMLDOMNode node, short deep, IXMLDOMNode* clone);
}

const GUID IID_IXMLDOMSchemaCollection = {0x373984C8, 0xB845, 0x449B, [0x91, 0xE7, 0x45, 0xAC, 0x83, 0x03, 0x6A, 0xDE]};
@GUID(0x373984C8, 0xB845, 0x449B, [0x91, 0xE7, 0x45, 0xAC, 0x83, 0x03, 0x6A, 0xDE]);
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

const GUID IID_IXMLDOMSelection = {0xAA634FC7, 0x5888, 0x44A7, [0xA2, 0x57, 0x3A, 0x47, 0x15, 0x0D, 0x3A, 0x0E]};
@GUID(0xAA634FC7, 0x5888, 0x44A7, [0xA2, 0x57, 0x3A, 0x47, 0x15, 0x0D, 0x3A, 0x0E]);
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

const GUID IID_IXMLDOMParseError2 = {0x3EFAA428, 0x272F, 0x11D2, [0x83, 0x6F, 0x00, 0x00, 0xF8, 0x7A, 0x77, 0x82]};
@GUID(0x3EFAA428, 0x272F, 0x11D2, [0x83, 0x6F, 0x00, 0x00, 0xF8, 0x7A, 0x77, 0x82]);
interface IXMLDOMParseError2 : IXMLDOMParseError
{
    HRESULT get_errorXPath(BSTR* xpathexpr);
    HRESULT get_allErrors(IXMLDOMParseErrorCollection* allErrors);
    HRESULT errorParameters(int index, BSTR* param1);
    HRESULT get_errorParametersCount(int* count);
}

const GUID IID_IXMLDOMParseErrorCollection = {0x3EFAA429, 0x272F, 0x11D2, [0x83, 0x6F, 0x00, 0x00, 0xF8, 0x7A, 0x77, 0x82]};
@GUID(0x3EFAA429, 0x272F, 0x11D2, [0x83, 0x6F, 0x00, 0x00, 0xF8, 0x7A, 0x77, 0x82]);
interface IXMLDOMParseErrorCollection : IDispatch
{
    HRESULT get_item(int index, IXMLDOMParseError2* error);
    HRESULT get_length(int* length);
    HRESULT get_next(IXMLDOMParseError2* error);
    HRESULT reset();
    HRESULT get__newEnum(IUnknown* ppunk);
}

const GUID IID_IXSLProcessor = {0x2933BF92, 0x7B36, 0x11D2, [0xB2, 0x0E, 0x00, 0xC0, 0x4F, 0x98, 0x3E, 0x60]};
@GUID(0x2933BF92, 0x7B36, 0x11D2, [0xB2, 0x0E, 0x00, 0xC0, 0x4F, 0x98, 0x3E, 0x60]);
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

const GUID IID_IXSLTemplate = {0x2933BF93, 0x7B36, 0x11D2, [0xB2, 0x0E, 0x00, 0xC0, 0x4F, 0x98, 0x3E, 0x60]};
@GUID(0x2933BF93, 0x7B36, 0x11D2, [0xB2, 0x0E, 0x00, 0xC0, 0x4F, 0x98, 0x3E, 0x60]);
interface IXSLTemplate : IDispatch
{
    HRESULT putref_stylesheet(IXMLDOMNode stylesheet);
    HRESULT get_stylesheet(IXMLDOMNode* stylesheet);
    HRESULT createProcessor(IXSLProcessor* ppProcessor);
}

const GUID IID_IXMLHTTPRequest = {0xED8C108D, 0x4349, 0x11D2, [0x91, 0xA4, 0x00, 0xC0, 0x4F, 0x79, 0x69, 0xE8]};
@GUID(0xED8C108D, 0x4349, 0x11D2, [0x91, 0xA4, 0x00, 0xC0, 0x4F, 0x79, 0x69, 0xE8]);
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

enum SERVERXMLHTTP_OPTION
{
    SXH_OPTION_URL = -1,
    SXH_OPTION_URL_CODEPAGE = 0,
    SXH_OPTION_ESCAPE_PERCENT_IN_URL = 1,
    SXH_OPTION_IGNORE_SERVER_SSL_CERT_ERROR_FLAGS = 2,
    SXH_OPTION_SELECT_CLIENT_SSL_CERT = 3,
}

enum SXH_SERVER_CERT_OPTION
{
    SXH_SERVER_CERT_IGNORE_UNKNOWN_CA = 256,
    SXH_SERVER_CERT_IGNORE_WRONG_USAGE = 512,
    SXH_SERVER_CERT_IGNORE_CERT_CN_INVALID = 4096,
    SXH_SERVER_CERT_IGNORE_CERT_DATE_INVALID = 8192,
    SXH_SERVER_CERT_IGNORE_ALL_SERVER_ERRORS = 13056,
}

enum SXH_PROXY_SETTING
{
    SXH_PROXY_SET_DEFAULT = 0,
    SXH_PROXY_SET_PRECONFIG = 0,
    SXH_PROXY_SET_DIRECT = 1,
    SXH_PROXY_SET_PROXY = 2,
}

const GUID IID_IServerXMLHTTPRequest = {0x2E9196BF, 0x13BA, 0x4DD4, [0x91, 0xCA, 0x6C, 0x57, 0x1F, 0x28, 0x14, 0x95]};
@GUID(0x2E9196BF, 0x13BA, 0x4DD4, [0x91, 0xCA, 0x6C, 0x57, 0x1F, 0x28, 0x14, 0x95]);
interface IServerXMLHTTPRequest : IXMLHTTPRequest
{
    HRESULT setTimeouts(int resolveTimeout, int connectTimeout, int sendTimeout, int receiveTimeout);
    HRESULT waitForResponse(VARIANT timeoutInSeconds, short* isSuccessful);
    HRESULT getOption(SERVERXMLHTTP_OPTION option, VARIANT* value);
    HRESULT setOption(SERVERXMLHTTP_OPTION option, VARIANT value);
}

const GUID IID_IServerXMLHTTPRequest2 = {0x2E01311B, 0xC322, 0x4B0A, [0xBD, 0x77, 0xB9, 0x0C, 0xFD, 0xC8, 0xDC, 0xE7]};
@GUID(0x2E01311B, 0xC322, 0x4B0A, [0xBD, 0x77, 0xB9, 0x0C, 0xFD, 0xC8, 0xDC, 0xE7]);
interface IServerXMLHTTPRequest2 : IServerXMLHTTPRequest
{
    HRESULT setProxy(SXH_PROXY_SETTING proxySetting, VARIANT varProxyServer, VARIANT varBypassList);
    HRESULT setProxyCredentials(BSTR bstrUserName, BSTR bstrPassword);
}

const GUID IID_ISAXXMLReader = {0xA4F96ED0, 0xF829, 0x476E, [0x81, 0xC0, 0xCD, 0xC7, 0xBD, 0x2A, 0x08, 0x02]};
@GUID(0xA4F96ED0, 0xF829, 0x476E, [0x81, 0xC0, 0xCD, 0xC7, 0xBD, 0x2A, 0x08, 0x02]);
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

const GUID IID_ISAXXMLFilter = {0x70409222, 0xCA09, 0x4475, [0xAC, 0xB8, 0x40, 0x31, 0x2F, 0xE8, 0xD1, 0x45]};
@GUID(0x70409222, 0xCA09, 0x4475, [0xAC, 0xB8, 0x40, 0x31, 0x2F, 0xE8, 0xD1, 0x45]);
interface ISAXXMLFilter : ISAXXMLReader
{
    HRESULT getParent(ISAXXMLReader* ppReader);
    HRESULT putParent(ISAXXMLReader pReader);
}

const GUID IID_ISAXLocator = {0x9B7E472A, 0x0DE4, 0x4640, [0xBF, 0xF3, 0x84, 0xD3, 0x8A, 0x05, 0x1C, 0x31]};
@GUID(0x9B7E472A, 0x0DE4, 0x4640, [0xBF, 0xF3, 0x84, 0xD3, 0x8A, 0x05, 0x1C, 0x31]);
interface ISAXLocator : IUnknown
{
    HRESULT getColumnNumber(int* pnColumn);
    HRESULT getLineNumber(int* pnLine);
    HRESULT getPublicId(const(ushort)** ppwchPublicId);
    HRESULT getSystemId(const(ushort)** ppwchSystemId);
}

const GUID IID_ISAXEntityResolver = {0x99BCA7BD, 0xE8C4, 0x4D5F, [0xA0, 0xCF, 0x6D, 0x90, 0x79, 0x01, 0xFF, 0x07]};
@GUID(0x99BCA7BD, 0xE8C4, 0x4D5F, [0xA0, 0xCF, 0x6D, 0x90, 0x79, 0x01, 0xFF, 0x07]);
interface ISAXEntityResolver : IUnknown
{
    HRESULT resolveEntity(const(ushort)* pwchPublicId, const(ushort)* pwchSystemId, VARIANT* pvarInput);
}

const GUID IID_ISAXContentHandler = {0x1545CDFA, 0x9E4E, 0x4497, [0xA8, 0xA4, 0x2B, 0xF7, 0xD0, 0x11, 0x2C, 0x44]};
@GUID(0x1545CDFA, 0x9E4E, 0x4497, [0xA8, 0xA4, 0x2B, 0xF7, 0xD0, 0x11, 0x2C, 0x44]);
interface ISAXContentHandler : IUnknown
{
    HRESULT putDocumentLocator(ISAXLocator pLocator);
    HRESULT startDocument();
    HRESULT endDocument();
    HRESULT startPrefixMapping(const(ushort)* pwchPrefix, int cchPrefix, const(ushort)* pwchUri, int cchUri);
    HRESULT endPrefixMapping(const(ushort)* pwchPrefix, int cchPrefix);
    HRESULT startElement(const(ushort)* pwchNamespaceUri, int cchNamespaceUri, const(ushort)* pwchLocalName, int cchLocalName, const(ushort)* pwchQName, int cchQName, ISAXAttributes pAttributes);
    HRESULT endElement(const(ushort)* pwchNamespaceUri, int cchNamespaceUri, const(ushort)* pwchLocalName, int cchLocalName, const(ushort)* pwchQName, int cchQName);
    HRESULT characters(const(ushort)* pwchChars, int cchChars);
    HRESULT ignorableWhitespace(const(ushort)* pwchChars, int cchChars);
    HRESULT processingInstruction(const(ushort)* pwchTarget, int cchTarget, const(ushort)* pwchData, int cchData);
    HRESULT skippedEntity(const(ushort)* pwchName, int cchName);
}

const GUID IID_ISAXDTDHandler = {0xE15C1BAF, 0xAFB3, 0x4D60, [0x8C, 0x36, 0x19, 0xA8, 0xC4, 0x5D, 0xEF, 0xED]};
@GUID(0xE15C1BAF, 0xAFB3, 0x4D60, [0x8C, 0x36, 0x19, 0xA8, 0xC4, 0x5D, 0xEF, 0xED]);
interface ISAXDTDHandler : IUnknown
{
    HRESULT notationDecl(const(ushort)* pwchName, int cchName, const(ushort)* pwchPublicId, int cchPublicId, const(ushort)* pwchSystemId, int cchSystemId);
    HRESULT unparsedEntityDecl(const(ushort)* pwchName, int cchName, const(ushort)* pwchPublicId, int cchPublicId, const(ushort)* pwchSystemId, int cchSystemId, const(ushort)* pwchNotationName, int cchNotationName);
}

const GUID IID_ISAXErrorHandler = {0xA60511C4, 0xCCF5, 0x479E, [0x98, 0xA3, 0xDC, 0x8D, 0xC5, 0x45, 0xB7, 0xD0]};
@GUID(0xA60511C4, 0xCCF5, 0x479E, [0x98, 0xA3, 0xDC, 0x8D, 0xC5, 0x45, 0xB7, 0xD0]);
interface ISAXErrorHandler : IUnknown
{
    HRESULT error(ISAXLocator pLocator, const(ushort)* pwchErrorMessage, HRESULT hrErrorCode);
    HRESULT fatalError(ISAXLocator pLocator, const(ushort)* pwchErrorMessage, HRESULT hrErrorCode);
    HRESULT ignorableWarning(ISAXLocator pLocator, const(ushort)* pwchErrorMessage, HRESULT hrErrorCode);
}

const GUID IID_ISAXLexicalHandler = {0x7F85D5F5, 0x47A8, 0x4497, [0xBD, 0xA5, 0x84, 0xBA, 0x04, 0x81, 0x9E, 0xA6]};
@GUID(0x7F85D5F5, 0x47A8, 0x4497, [0xBD, 0xA5, 0x84, 0xBA, 0x04, 0x81, 0x9E, 0xA6]);
interface ISAXLexicalHandler : IUnknown
{
    HRESULT startDTD(const(ushort)* pwchName, int cchName, const(ushort)* pwchPublicId, int cchPublicId, const(ushort)* pwchSystemId, int cchSystemId);
    HRESULT endDTD();
    HRESULT startEntity(const(ushort)* pwchName, int cchName);
    HRESULT endEntity(const(ushort)* pwchName, int cchName);
    HRESULT startCDATA();
    HRESULT endCDATA();
    HRESULT comment(const(ushort)* pwchChars, int cchChars);
}

const GUID IID_ISAXDeclHandler = {0x862629AC, 0x771A, 0x47B2, [0x83, 0x37, 0x4E, 0x68, 0x43, 0xC1, 0xBE, 0x90]};
@GUID(0x862629AC, 0x771A, 0x47B2, [0x83, 0x37, 0x4E, 0x68, 0x43, 0xC1, 0xBE, 0x90]);
interface ISAXDeclHandler : IUnknown
{
    HRESULT elementDecl(const(ushort)* pwchName, int cchName, const(ushort)* pwchModel, int cchModel);
    HRESULT attributeDecl(const(ushort)* pwchElementName, int cchElementName, const(ushort)* pwchAttributeName, int cchAttributeName, const(ushort)* pwchType, int cchType, const(ushort)* pwchValueDefault, int cchValueDefault, const(ushort)* pwchValue, int cchValue);
    HRESULT internalEntityDecl(const(ushort)* pwchName, int cchName, const(ushort)* pwchValue, int cchValue);
    HRESULT externalEntityDecl(const(ushort)* pwchName, int cchName, const(ushort)* pwchPublicId, int cchPublicId, const(ushort)* pwchSystemId, int cchSystemId);
}

const GUID IID_ISAXAttributes = {0xF078ABE1, 0x45D2, 0x4832, [0x91, 0xEA, 0x44, 0x66, 0xCE, 0x2F, 0x25, 0xC9]};
@GUID(0xF078ABE1, 0x45D2, 0x4832, [0x91, 0xEA, 0x44, 0x66, 0xCE, 0x2F, 0x25, 0xC9]);
interface ISAXAttributes : IUnknown
{
    HRESULT getLength(int* pnLength);
    HRESULT getURI(int nIndex, const(ushort)** ppwchUri, int* pcchUri);
    HRESULT getLocalName(int nIndex, const(ushort)** ppwchLocalName, int* pcchLocalName);
    HRESULT getQName(int nIndex, const(ushort)** ppwchQName, int* pcchQName);
    HRESULT getName(int nIndex, const(ushort)** ppwchUri, int* pcchUri, const(ushort)** ppwchLocalName, int* pcchLocalName, const(ushort)** ppwchQName, int* pcchQName);
    HRESULT getIndexFromName(const(ushort)* pwchUri, int cchUri, const(ushort)* pwchLocalName, int cchLocalName, int* pnIndex);
    HRESULT getIndexFromQName(const(ushort)* pwchQName, int cchQName, int* pnIndex);
    HRESULT getType(int nIndex, const(ushort)** ppwchType, int* pcchType);
    HRESULT getTypeFromName(const(ushort)* pwchUri, int cchUri, const(ushort)* pwchLocalName, int cchLocalName, const(ushort)** ppwchType, int* pcchType);
    HRESULT getTypeFromQName(const(ushort)* pwchQName, int cchQName, const(ushort)** ppwchType, int* pcchType);
    HRESULT getValue(int nIndex, const(ushort)** ppwchValue, int* pcchValue);
    HRESULT getValueFromName(const(ushort)* pwchUri, int cchUri, const(ushort)* pwchLocalName, int cchLocalName, const(ushort)** ppwchValue, int* pcchValue);
    HRESULT getValueFromQName(const(ushort)* pwchQName, int cchQName, const(ushort)** ppwchValue, int* pcchValue);
}

const GUID IID_IVBSAXXMLReader = {0x8C033CAA, 0x6CD6, 0x4F73, [0xB7, 0x28, 0x45, 0x31, 0xAF, 0x74, 0x94, 0x5F]};
@GUID(0x8C033CAA, 0x6CD6, 0x4F73, [0xB7, 0x28, 0x45, 0x31, 0xAF, 0x74, 0x94, 0x5F]);
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

const GUID IID_IVBSAXXMLFilter = {0x1299EB1B, 0x5B88, 0x433E, [0x82, 0xDE, 0x82, 0xCA, 0x75, 0xAD, 0x4E, 0x04]};
@GUID(0x1299EB1B, 0x5B88, 0x433E, [0x82, 0xDE, 0x82, 0xCA, 0x75, 0xAD, 0x4E, 0x04]);
interface IVBSAXXMLFilter : IDispatch
{
    HRESULT get_parent(IVBSAXXMLReader* oReader);
    HRESULT putref_parent(IVBSAXXMLReader oReader);
}

const GUID IID_IVBSAXLocator = {0x796E7AC5, 0x5AA2, 0x4EFF, [0xAC, 0xAD, 0x3F, 0xAA, 0xF0, 0x1A, 0x32, 0x88]};
@GUID(0x796E7AC5, 0x5AA2, 0x4EFF, [0xAC, 0xAD, 0x3F, 0xAA, 0xF0, 0x1A, 0x32, 0x88]);
interface IVBSAXLocator : IDispatch
{
    HRESULT get_columnNumber(int* nColumn);
    HRESULT get_lineNumber(int* nLine);
    HRESULT get_publicId(BSTR* strPublicId);
    HRESULT get_systemId(BSTR* strSystemId);
}

const GUID IID_IVBSAXEntityResolver = {0x0C05D096, 0xF45B, 0x4ACA, [0xAD, 0x1A, 0xAA, 0x0B, 0xC2, 0x55, 0x18, 0xDC]};
@GUID(0x0C05D096, 0xF45B, 0x4ACA, [0xAD, 0x1A, 0xAA, 0x0B, 0xC2, 0x55, 0x18, 0xDC]);
interface IVBSAXEntityResolver : IDispatch
{
    HRESULT resolveEntity(BSTR* strPublicId, BSTR* strSystemId, VARIANT* varInput);
}

const GUID IID_IVBSAXContentHandler = {0x2ED7290A, 0x4DD5, 0x4B46, [0xBB, 0x26, 0x4E, 0x41, 0x55, 0xE7, 0x7F, 0xAA]};
@GUID(0x2ED7290A, 0x4DD5, 0x4B46, [0xBB, 0x26, 0x4E, 0x41, 0x55, 0xE7, 0x7F, 0xAA]);
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

const GUID IID_IVBSAXDTDHandler = {0x24FB3297, 0x302D, 0x4620, [0xBA, 0x39, 0x3A, 0x73, 0x2D, 0x85, 0x05, 0x58]};
@GUID(0x24FB3297, 0x302D, 0x4620, [0xBA, 0x39, 0x3A, 0x73, 0x2D, 0x85, 0x05, 0x58]);
interface IVBSAXDTDHandler : IDispatch
{
    HRESULT notationDecl(BSTR* strName, BSTR* strPublicId, BSTR* strSystemId);
    HRESULT unparsedEntityDecl(BSTR* strName, BSTR* strPublicId, BSTR* strSystemId, BSTR* strNotationName);
}

const GUID IID_IVBSAXErrorHandler = {0xD963D3FE, 0x173C, 0x4862, [0x90, 0x95, 0xB9, 0x2F, 0x66, 0x99, 0x5F, 0x52]};
@GUID(0xD963D3FE, 0x173C, 0x4862, [0x90, 0x95, 0xB9, 0x2F, 0x66, 0x99, 0x5F, 0x52]);
interface IVBSAXErrorHandler : IDispatch
{
    HRESULT error(IVBSAXLocator oLocator, BSTR* strErrorMessage, int nErrorCode);
    HRESULT fatalError(IVBSAXLocator oLocator, BSTR* strErrorMessage, int nErrorCode);
    HRESULT ignorableWarning(IVBSAXLocator oLocator, BSTR* strErrorMessage, int nErrorCode);
}

const GUID IID_IVBSAXLexicalHandler = {0x032AAC35, 0x8C0E, 0x4D9D, [0x97, 0x9F, 0xE3, 0xB7, 0x02, 0x93, 0x55, 0x76]};
@GUID(0x032AAC35, 0x8C0E, 0x4D9D, [0x97, 0x9F, 0xE3, 0xB7, 0x02, 0x93, 0x55, 0x76]);
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

const GUID IID_IVBSAXDeclHandler = {0xE8917260, 0x7579, 0x4BE1, [0xB5, 0xDD, 0x7A, 0xFB, 0xFA, 0x6F, 0x07, 0x7B]};
@GUID(0xE8917260, 0x7579, 0x4BE1, [0xB5, 0xDD, 0x7A, 0xFB, 0xFA, 0x6F, 0x07, 0x7B]);
interface IVBSAXDeclHandler : IDispatch
{
    HRESULT elementDecl(BSTR* strName, BSTR* strModel);
    HRESULT attributeDecl(BSTR* strElementName, BSTR* strAttributeName, BSTR* strType, BSTR* strValueDefault, BSTR* strValue);
    HRESULT internalEntityDecl(BSTR* strName, BSTR* strValue);
    HRESULT externalEntityDecl(BSTR* strName, BSTR* strPublicId, BSTR* strSystemId);
}

const GUID IID_IVBSAXAttributes = {0x10DC0586, 0x132B, 0x4CAC, [0x8B, 0xB3, 0xDB, 0x00, 0xAC, 0x8B, 0x7E, 0xE0]};
@GUID(0x10DC0586, 0x132B, 0x4CAC, [0x8B, 0xB3, 0xDB, 0x00, 0xAC, 0x8B, 0x7E, 0xE0]);
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

const GUID IID_IMXWriter = {0x4D7FF4BA, 0x1565, 0x4EA8, [0x94, 0xE1, 0x6E, 0x72, 0x4A, 0x46, 0xF9, 0x8D]};
@GUID(0x4D7FF4BA, 0x1565, 0x4EA8, [0x94, 0xE1, 0x6E, 0x72, 0x4A, 0x46, 0xF9, 0x8D]);
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

const GUID IID_IMXAttributes = {0xF10D27CC, 0x3EC0, 0x415C, [0x8E, 0xD8, 0x77, 0xAB, 0x1C, 0x5E, 0x72, 0x62]};
@GUID(0xF10D27CC, 0x3EC0, 0x415C, [0x8E, 0xD8, 0x77, 0xAB, 0x1C, 0x5E, 0x72, 0x62]);
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

const GUID IID_IMXReaderControl = {0x808F4E35, 0x8D5A, 0x4FBE, [0x84, 0x66, 0x33, 0xA4, 0x12, 0x79, 0xED, 0x30]};
@GUID(0x808F4E35, 0x8D5A, 0x4FBE, [0x84, 0x66, 0x33, 0xA4, 0x12, 0x79, 0xED, 0x30]);
interface IMXReaderControl : IDispatch
{
    HRESULT abort();
    HRESULT resume();
    HRESULT suspend();
}

const GUID IID_IMXSchemaDeclHandler = {0xFA4BB38C, 0xFAF9, 0x4CCA, [0x93, 0x02, 0xD1, 0xDD, 0x0F, 0xE5, 0x20, 0xDB]};
@GUID(0xFA4BB38C, 0xFAF9, 0x4CCA, [0x93, 0x02, 0xD1, 0xDD, 0x0F, 0xE5, 0x20, 0xDB]);
interface IMXSchemaDeclHandler : IDispatch
{
    HRESULT schemaElementDecl(ISchemaElement oSchemaElement);
}

const GUID IID_IMXNamespacePrefixes = {0xC90352F4, 0x643C, 0x4FBC, [0xBB, 0x23, 0xE9, 0x96, 0xEB, 0x2D, 0x51, 0xFD]};
@GUID(0xC90352F4, 0x643C, 0x4FBC, [0xBB, 0x23, 0xE9, 0x96, 0xEB, 0x2D, 0x51, 0xFD]);
interface IMXNamespacePrefixes : IDispatch
{
    HRESULT get_item(int index, BSTR* prefix);
    HRESULT get_length(int* length);
    HRESULT get__newEnum(IUnknown* ppUnk);
}

const GUID IID_IVBMXNamespaceManager = {0xC90352F5, 0x643C, 0x4FBC, [0xBB, 0x23, 0xE9, 0x96, 0xEB, 0x2D, 0x51, 0xFD]};
@GUID(0xC90352F5, 0x643C, 0x4FBC, [0xBB, 0x23, 0xE9, 0x96, 0xEB, 0x2D, 0x51, 0xFD]);
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

const GUID IID_IMXNamespaceManager = {0xC90352F6, 0x643C, 0x4FBC, [0xBB, 0x23, 0xE9, 0x96, 0xEB, 0x2D, 0x51, 0xFD]};
@GUID(0xC90352F6, 0x643C, 0x4FBC, [0xBB, 0x23, 0xE9, 0x96, 0xEB, 0x2D, 0x51, 0xFD]);
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

const GUID IID_IMXXMLFilter = {0xC90352F7, 0x643C, 0x4FBC, [0xBB, 0x23, 0xE9, 0x96, 0xEB, 0x2D, 0x51, 0xFD]};
@GUID(0xC90352F7, 0x643C, 0x4FBC, [0xBB, 0x23, 0xE9, 0x96, 0xEB, 0x2D, 0x51, 0xFD]);
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

enum SOMITEMTYPE
{
    SOMITEM_SCHEMA = 4096,
    SOMITEM_ATTRIBUTE = 4097,
    SOMITEM_ATTRIBUTEGROUP = 4098,
    SOMITEM_NOTATION = 4099,
    SOMITEM_ANNOTATION = 4100,
    SOMITEM_IDENTITYCONSTRAINT = 4352,
    SOMITEM_KEY = 4353,
    SOMITEM_KEYREF = 4354,
    SOMITEM_UNIQUE = 4355,
    SOMITEM_ANYTYPE = 8192,
    SOMITEM_DATATYPE = 8448,
    SOMITEM_DATATYPE_ANYTYPE = 8449,
    SOMITEM_DATATYPE_ANYURI = 8450,
    SOMITEM_DATATYPE_BASE64BINARY = 8451,
    SOMITEM_DATATYPE_BOOLEAN = 8452,
    SOMITEM_DATATYPE_BYTE = 8453,
    SOMITEM_DATATYPE_DATE = 8454,
    SOMITEM_DATATYPE_DATETIME = 8455,
    SOMITEM_DATATYPE_DAY = 8456,
    SOMITEM_DATATYPE_DECIMAL = 8457,
    SOMITEM_DATATYPE_DOUBLE = 8458,
    SOMITEM_DATATYPE_DURATION = 8459,
    SOMITEM_DATATYPE_ENTITIES = 8460,
    SOMITEM_DATATYPE_ENTITY = 8461,
    SOMITEM_DATATYPE_FLOAT = 8462,
    SOMITEM_DATATYPE_HEXBINARY = 8463,
    SOMITEM_DATATYPE_ID = 8464,
    SOMITEM_DATATYPE_IDREF = 8465,
    SOMITEM_DATATYPE_IDREFS = 8466,
    SOMITEM_DATATYPE_INT = 8467,
    SOMITEM_DATATYPE_INTEGER = 8468,
    SOMITEM_DATATYPE_LANGUAGE = 8469,
    SOMITEM_DATATYPE_LONG = 8470,
    SOMITEM_DATATYPE_MONTH = 8471,
    SOMITEM_DATATYPE_MONTHDAY = 8472,
    SOMITEM_DATATYPE_NAME = 8473,
    SOMITEM_DATATYPE_NCNAME = 8474,
    SOMITEM_DATATYPE_NEGATIVEINTEGER = 8475,
    SOMITEM_DATATYPE_NMTOKEN = 8476,
    SOMITEM_DATATYPE_NMTOKENS = 8477,
    SOMITEM_DATATYPE_NONNEGATIVEINTEGER = 8478,
    SOMITEM_DATATYPE_NONPOSITIVEINTEGER = 8479,
    SOMITEM_DATATYPE_NORMALIZEDSTRING = 8480,
    SOMITEM_DATATYPE_NOTATION = 8481,
    SOMITEM_DATATYPE_POSITIVEINTEGER = 8482,
    SOMITEM_DATATYPE_QNAME = 8483,
    SOMITEM_DATATYPE_SHORT = 8484,
    SOMITEM_DATATYPE_STRING = 8485,
    SOMITEM_DATATYPE_TIME = 8486,
    SOMITEM_DATATYPE_TOKEN = 8487,
    SOMITEM_DATATYPE_UNSIGNEDBYTE = 8488,
    SOMITEM_DATATYPE_UNSIGNEDINT = 8489,
    SOMITEM_DATATYPE_UNSIGNEDLONG = 8490,
    SOMITEM_DATATYPE_UNSIGNEDSHORT = 8491,
    SOMITEM_DATATYPE_YEAR = 8492,
    SOMITEM_DATATYPE_YEARMONTH = 8493,
    SOMITEM_DATATYPE_ANYSIMPLETYPE = 8703,
    SOMITEM_SIMPLETYPE = 8704,
    SOMITEM_COMPLEXTYPE = 9216,
    SOMITEM_PARTICLE = 16384,
    SOMITEM_ANY = 16385,
    SOMITEM_ANYATTRIBUTE = 16386,
    SOMITEM_ELEMENT = 16387,
    SOMITEM_GROUP = 16640,
    SOMITEM_ALL = 16641,
    SOMITEM_CHOICE = 16642,
    SOMITEM_SEQUENCE = 16643,
    SOMITEM_EMPTYPARTICLE = 16644,
    SOMITEM_NULL = 2048,
    SOMITEM_NULL_TYPE = 10240,
    SOMITEM_NULL_ANY = 18433,
    SOMITEM_NULL_ANYATTRIBUTE = 18434,
    SOMITEM_NULL_ELEMENT = 18435,
}

enum SCHEMAUSE
{
    SCHEMAUSE_OPTIONAL = 0,
    SCHEMAUSE_PROHIBITED = 1,
    SCHEMAUSE_REQUIRED = 2,
}

enum SCHEMADERIVATIONMETHOD
{
    SCHEMADERIVATIONMETHOD_EMPTY = 0,
    SCHEMADERIVATIONMETHOD_SUBSTITUTION = 1,
    SCHEMADERIVATIONMETHOD_EXTENSION = 2,
    SCHEMADERIVATIONMETHOD_RESTRICTION = 4,
    SCHEMADERIVATIONMETHOD_LIST = 8,
    SCHEMADERIVATIONMETHOD_UNION = 16,
    SCHEMADERIVATIONMETHOD_ALL = 255,
    SCHEMADERIVATIONMETHOD_NONE = 256,
}

enum SCHEMACONTENTTYPE
{
    SCHEMACONTENTTYPE_EMPTY = 0,
    SCHEMACONTENTTYPE_TEXTONLY = 1,
    SCHEMACONTENTTYPE_ELEMENTONLY = 2,
    SCHEMACONTENTTYPE_MIXED = 3,
}

enum SCHEMAPROCESSCONTENTS
{
    SCHEMAPROCESSCONTENTS_NONE = 0,
    SCHEMAPROCESSCONTENTS_SKIP = 1,
    SCHEMAPROCESSCONTENTS_LAX = 2,
    SCHEMAPROCESSCONTENTS_STRICT = 3,
}

enum SCHEMAWHITESPACE
{
    SCHEMAWHITESPACE_NONE = -1,
    SCHEMAWHITESPACE_PRESERVE = 0,
    SCHEMAWHITESPACE_REPLACE = 1,
    SCHEMAWHITESPACE_COLLAPSE = 2,
}

enum SCHEMATYPEVARIETY
{
    SCHEMATYPEVARIETY_NONE = -1,
    SCHEMATYPEVARIETY_ATOMIC = 0,
    SCHEMATYPEVARIETY_LIST = 1,
    SCHEMATYPEVARIETY_UNION = 2,
}

const GUID IID_IXMLDOMSchemaCollection2 = {0x50EA08B0, 0xDD1B, 0x4664, [0x9A, 0x50, 0xC2, 0xF4, 0x0F, 0x4B, 0xD7, 0x9A]};
@GUID(0x50EA08B0, 0xDD1B, 0x4664, [0x9A, 0x50, 0xC2, 0xF4, 0x0F, 0x4B, 0xD7, 0x9A]);
interface IXMLDOMSchemaCollection2 : IXMLDOMSchemaCollection
{
    HRESULT validate();
    HRESULT put_validateOnLoad(short validateOnLoad);
    HRESULT get_validateOnLoad(short* validateOnLoad);
    HRESULT getSchema(BSTR namespaceURI, ISchema* schema);
    HRESULT getDeclaration(IXMLDOMNode node, ISchemaItem* item);
}

const GUID IID_ISchemaStringCollection = {0x50EA08B1, 0xDD1B, 0x4664, [0x9A, 0x50, 0xC2, 0xF4, 0x0F, 0x4B, 0xD7, 0x9A]};
@GUID(0x50EA08B1, 0xDD1B, 0x4664, [0x9A, 0x50, 0xC2, 0xF4, 0x0F, 0x4B, 0xD7, 0x9A]);
interface ISchemaStringCollection : IDispatch
{
    HRESULT get_item(int index, BSTR* bstr);
    HRESULT get_length(int* length);
    HRESULT get__newEnum(IUnknown* ppunk);
}

const GUID IID_ISchemaItemCollection = {0x50EA08B2, 0xDD1B, 0x4664, [0x9A, 0x50, 0xC2, 0xF4, 0x0F, 0x4B, 0xD7, 0x9A]};
@GUID(0x50EA08B2, 0xDD1B, 0x4664, [0x9A, 0x50, 0xC2, 0xF4, 0x0F, 0x4B, 0xD7, 0x9A]);
interface ISchemaItemCollection : IDispatch
{
    HRESULT get_item(int index, ISchemaItem* item);
    HRESULT itemByName(BSTR name, ISchemaItem* item);
    HRESULT itemByQName(BSTR name, BSTR namespaceURI, ISchemaItem* item);
    HRESULT get_length(int* length);
    HRESULT get__newEnum(IUnknown* ppunk);
}

const GUID IID_ISchemaItem = {0x50EA08B3, 0xDD1B, 0x4664, [0x9A, 0x50, 0xC2, 0xF4, 0x0F, 0x4B, 0xD7, 0x9A]};
@GUID(0x50EA08B3, 0xDD1B, 0x4664, [0x9A, 0x50, 0xC2, 0xF4, 0x0F, 0x4B, 0xD7, 0x9A]);
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

const GUID IID_ISchema = {0x50EA08B4, 0xDD1B, 0x4664, [0x9A, 0x50, 0xC2, 0xF4, 0x0F, 0x4B, 0xD7, 0x9A]};
@GUID(0x50EA08B4, 0xDD1B, 0x4664, [0x9A, 0x50, 0xC2, 0xF4, 0x0F, 0x4B, 0xD7, 0x9A]);
interface ISchema : ISchemaItem
{
    HRESULT get_targetNamespace(BSTR* targetNamespace);
    HRESULT get_version(BSTR* version);
    HRESULT get_types(ISchemaItemCollection* types);
    HRESULT get_elements(ISchemaItemCollection* elements);
    HRESULT get_attributes(ISchemaItemCollection* attributes);
    HRESULT get_attributeGroups(ISchemaItemCollection* attributeGroups);
    HRESULT get_modelGroups(ISchemaItemCollection* modelGroups);
    HRESULT get_notations(ISchemaItemCollection* notations);
    HRESULT get_schemaLocations(ISchemaStringCollection* schemaLocations);
}

const GUID IID_ISchemaParticle = {0x50EA08B5, 0xDD1B, 0x4664, [0x9A, 0x50, 0xC2, 0xF4, 0x0F, 0x4B, 0xD7, 0x9A]};
@GUID(0x50EA08B5, 0xDD1B, 0x4664, [0x9A, 0x50, 0xC2, 0xF4, 0x0F, 0x4B, 0xD7, 0x9A]);
interface ISchemaParticle : ISchemaItem
{
    HRESULT get_minOccurs(VARIANT* minOccurs);
    HRESULT get_maxOccurs(VARIANT* maxOccurs);
}

const GUID IID_ISchemaAttribute = {0x50EA08B6, 0xDD1B, 0x4664, [0x9A, 0x50, 0xC2, 0xF4, 0x0F, 0x4B, 0xD7, 0x9A]};
@GUID(0x50EA08B6, 0xDD1B, 0x4664, [0x9A, 0x50, 0xC2, 0xF4, 0x0F, 0x4B, 0xD7, 0x9A]);
interface ISchemaAttribute : ISchemaItem
{
    HRESULT get_type(ISchemaType* type);
    HRESULT get_scope(ISchemaComplexType* scope);
    HRESULT get_defaultValue(BSTR* defaultValue);
    HRESULT get_fixedValue(BSTR* fixedValue);
    HRESULT get_use(SCHEMAUSE* use);
    HRESULT get_isReference(short* reference);
}

const GUID IID_ISchemaElement = {0x50EA08B7, 0xDD1B, 0x4664, [0x9A, 0x50, 0xC2, 0xF4, 0x0F, 0x4B, 0xD7, 0x9A]};
@GUID(0x50EA08B7, 0xDD1B, 0x4664, [0x9A, 0x50, 0xC2, 0xF4, 0x0F, 0x4B, 0xD7, 0x9A]);
interface ISchemaElement : ISchemaParticle
{
    HRESULT get_type(ISchemaType* type);
    HRESULT get_scope(ISchemaComplexType* scope);
    HRESULT get_defaultValue(BSTR* defaultValue);
    HRESULT get_fixedValue(BSTR* fixedValue);
    HRESULT get_isNillable(short* nillable);
    HRESULT get_identityConstraints(ISchemaItemCollection* constraints);
    HRESULT get_substitutionGroup(ISchemaElement* element);
    HRESULT get_substitutionGroupExclusions(SCHEMADERIVATIONMETHOD* exclusions);
    HRESULT get_disallowedSubstitutions(SCHEMADERIVATIONMETHOD* disallowed);
    HRESULT get_isAbstract(short* abstract);
    HRESULT get_isReference(short* reference);
}

const GUID IID_ISchemaType = {0x50EA08B8, 0xDD1B, 0x4664, [0x9A, 0x50, 0xC2, 0xF4, 0x0F, 0x4B, 0xD7, 0x9A]};
@GUID(0x50EA08B8, 0xDD1B, 0x4664, [0x9A, 0x50, 0xC2, 0xF4, 0x0F, 0x4B, 0xD7, 0x9A]);
interface ISchemaType : ISchemaItem
{
    HRESULT get_baseTypes(ISchemaItemCollection* baseTypes);
    HRESULT get_final(SCHEMADERIVATIONMETHOD* final);
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

const GUID IID_ISchemaComplexType = {0x50EA08B9, 0xDD1B, 0x4664, [0x9A, 0x50, 0xC2, 0xF4, 0x0F, 0x4B, 0xD7, 0x9A]};
@GUID(0x50EA08B9, 0xDD1B, 0x4664, [0x9A, 0x50, 0xC2, 0xF4, 0x0F, 0x4B, 0xD7, 0x9A]);
interface ISchemaComplexType : ISchemaType
{
    HRESULT get_isAbstract(short* abstract);
    HRESULT get_anyAttribute(ISchemaAny* anyAttribute);
    HRESULT get_attributes(ISchemaItemCollection* attributes);
    HRESULT get_contentType(SCHEMACONTENTTYPE* contentType);
    HRESULT get_contentModel(ISchemaModelGroup* contentModel);
    HRESULT get_prohibitedSubstitutions(SCHEMADERIVATIONMETHOD* prohibited);
}

const GUID IID_ISchemaAttributeGroup = {0x50EA08BA, 0xDD1B, 0x4664, [0x9A, 0x50, 0xC2, 0xF4, 0x0F, 0x4B, 0xD7, 0x9A]};
@GUID(0x50EA08BA, 0xDD1B, 0x4664, [0x9A, 0x50, 0xC2, 0xF4, 0x0F, 0x4B, 0xD7, 0x9A]);
interface ISchemaAttributeGroup : ISchemaItem
{
    HRESULT get_anyAttribute(ISchemaAny* anyAttribute);
    HRESULT get_attributes(ISchemaItemCollection* attributes);
}

const GUID IID_ISchemaModelGroup = {0x50EA08BB, 0xDD1B, 0x4664, [0x9A, 0x50, 0xC2, 0xF4, 0x0F, 0x4B, 0xD7, 0x9A]};
@GUID(0x50EA08BB, 0xDD1B, 0x4664, [0x9A, 0x50, 0xC2, 0xF4, 0x0F, 0x4B, 0xD7, 0x9A]);
interface ISchemaModelGroup : ISchemaParticle
{
    HRESULT get_particles(ISchemaItemCollection* particles);
}

const GUID IID_ISchemaAny = {0x50EA08BC, 0xDD1B, 0x4664, [0x9A, 0x50, 0xC2, 0xF4, 0x0F, 0x4B, 0xD7, 0x9A]};
@GUID(0x50EA08BC, 0xDD1B, 0x4664, [0x9A, 0x50, 0xC2, 0xF4, 0x0F, 0x4B, 0xD7, 0x9A]);
interface ISchemaAny : ISchemaParticle
{
    HRESULT get_namespaces(ISchemaStringCollection* namespaces);
    HRESULT get_processContents(SCHEMAPROCESSCONTENTS* processContents);
}

const GUID IID_ISchemaIdentityConstraint = {0x50EA08BD, 0xDD1B, 0x4664, [0x9A, 0x50, 0xC2, 0xF4, 0x0F, 0x4B, 0xD7, 0x9A]};
@GUID(0x50EA08BD, 0xDD1B, 0x4664, [0x9A, 0x50, 0xC2, 0xF4, 0x0F, 0x4B, 0xD7, 0x9A]);
interface ISchemaIdentityConstraint : ISchemaItem
{
    HRESULT get_selector(BSTR* selector);
    HRESULT get_fields(ISchemaStringCollection* fields);
    HRESULT get_referencedKey(ISchemaIdentityConstraint* key);
}

const GUID IID_ISchemaNotation = {0x50EA08BE, 0xDD1B, 0x4664, [0x9A, 0x50, 0xC2, 0xF4, 0x0F, 0x4B, 0xD7, 0x9A]};
@GUID(0x50EA08BE, 0xDD1B, 0x4664, [0x9A, 0x50, 0xC2, 0xF4, 0x0F, 0x4B, 0xD7, 0x9A]);
interface ISchemaNotation : ISchemaItem
{
    HRESULT get_systemIdentifier(BSTR* uri);
    HRESULT get_publicIdentifier(BSTR* uri);
}

struct __msxml6_ReferenceRemainingTypes__
{
    DOMNodeType __tagDomNodeType__;
    DOMNodeType __domNodeType__;
    SERVERXMLHTTP_OPTION __serverXmlHttpOptionEnum__;
    SERVERXMLHTTP_OPTION __serverXmlHttpOption__;
    SXH_SERVER_CERT_OPTION __serverCertOptionEnum__;
    SXH_SERVER_CERT_OPTION __serverCertOption__;
    SXH_PROXY_SETTING __proxySettingEnum__;
    SXH_PROXY_SETTING __proxySetting__;
    SOMITEMTYPE __somItemTypeEnum__;
    SOMITEMTYPE __somItemType__;
    SCHEMAUSE __schemaUseEnum__;
    SCHEMAUSE __schemaUse__;
    SCHEMADERIVATIONMETHOD __schemaDerivationMethodEnum__;
    SCHEMADERIVATIONMETHOD __schemaDerivationMethod__;
    SCHEMACONTENTTYPE __schemaContentTypeEnum__;
    SCHEMACONTENTTYPE __schemaContentType__;
    SCHEMAPROCESSCONTENTS __schemaProcessContentsEnum__;
    SCHEMAPROCESSCONTENTS __schemaProcessContents__;
    SCHEMAWHITESPACE __schemaWhitespaceEnum__;
    SCHEMAWHITESPACE __schemaWhitespace__;
    SCHEMATYPEVARIETY __schemaTypeVarietyEnum__;
    SCHEMATYPEVARIETY __schemaTypeVariety__;
}

enum XHR_COOKIE_STATE
{
    XHR_COOKIE_STATE_UNKNOWN = 0,
    XHR_COOKIE_STATE_ACCEPT = 1,
    XHR_COOKIE_STATE_PROMPT = 2,
    XHR_COOKIE_STATE_LEASH = 3,
    XHR_COOKIE_STATE_DOWNGRADE = 4,
    XHR_COOKIE_STATE_REJECT = 5,
}

enum XHR_COOKIE_FLAG
{
    XHR_COOKIE_IS_SECURE = 1,
    XHR_COOKIE_IS_SESSION = 2,
    XHR_COOKIE_THIRD_PARTY = 16,
    XHR_COOKIE_PROMPT_REQUIRED = 32,
    XHR_COOKIE_EVALUATE_P3P = 64,
    XHR_COOKIE_APPLY_P3P = 128,
    XHR_COOKIE_P3P_ENABLED = 256,
    XHR_COOKIE_IS_RESTRICTED = 512,
    XHR_COOKIE_IE6 = 1024,
    XHR_COOKIE_IS_LEGACY = 2048,
    XHR_COOKIE_NON_SCRIPT = 4096,
    XHR_COOKIE_HTTPONLY = 8192,
}

enum XHR_CRED_PROMPT
{
    XHR_CRED_PROMPT_ALL = 0,
    XHR_CRED_PROMPT_NONE = 1,
    XHR_CRED_PROMPT_PROXY = 2,
}

enum XHR_AUTH
{
    XHR_AUTH_ALL = 0,
    XHR_AUTH_NONE = 1,
    XHR_AUTH_PROXY = 2,
}

enum XHR_PROPERTY
{
    XHR_PROP_NO_CRED_PROMPT = 0,
    XHR_PROP_NO_AUTH = 1,
    XHR_PROP_TIMEOUT = 2,
    XHR_PROP_NO_DEFAULT_HEADERS = 3,
    XHR_PROP_REPORT_REDIRECT_STATUS = 4,
    XHR_PROP_NO_CACHE = 5,
    XHR_PROP_EXTENDED_ERROR = 6,
    XHR_PROP_QUERY_STRING_UTF8 = 7,
    XHR_PROP_IGNORE_CERT_ERRORS = 8,
    XHR_PROP_ONDATA_THRESHOLD = 9,
    XHR_PROP_SET_ENTERPRISEID = 10,
    XHR_PROP_MAX_CONNECTIONS = 11,
}

enum XHR_CERT_IGNORE_FLAG
{
    XHR_CERT_IGNORE_REVOCATION_FAILED = 128,
    XHR_CERT_IGNORE_UNKNOWN_CA = 256,
    XHR_CERT_IGNORE_CERT_CN_INVALID = 4096,
    XHR_CERT_IGNORE_CERT_DATE_INVALID = 8192,
    XHR_CERT_IGNORE_ALL_SERVER_ERRORS = 12672,
}

enum XHR_CERT_ERROR_FLAG
{
    XHR_CERT_ERROR_REVOCATION_FAILED = 8388608,
    XHR_CERT_ERROR_UNKNOWN_CA = 16777216,
    XHR_CERT_ERROR_CERT_CN_INVALID = 33554432,
    XHR_CERT_ERROR_CERT_DATE_INVALID = 67108864,
    XHR_CERT_ERROR_ALL_SERVER_ERRORS = 125829120,
}

struct XHR_COOKIE
{
    ushort* pwszUrl;
    ushort* pwszName;
    ushort* pwszValue;
    ushort* pwszP3PPolicy;
    FILETIME ftExpires;
    uint dwFlags;
}

const GUID IID_IXMLHTTPRequest2Callback = {0xA44A9299, 0xE321, 0x40DE, [0x88, 0x66, 0x34, 0x1B, 0x41, 0x66, 0x91, 0x62]};
@GUID(0xA44A9299, 0xE321, 0x40DE, [0x88, 0x66, 0x34, 0x1B, 0x41, 0x66, 0x91, 0x62]);
interface IXMLHTTPRequest2Callback : IUnknown
{
    HRESULT OnRedirect(IXMLHTTPRequest2 pXHR, const(wchar)* pwszRedirectUrl);
    HRESULT OnHeadersAvailable(IXMLHTTPRequest2 pXHR, uint dwStatus, const(wchar)* pwszStatus);
    HRESULT OnDataAvailable(IXMLHTTPRequest2 pXHR, ISequentialStream pResponseStream);
    HRESULT OnResponseReceived(IXMLHTTPRequest2 pXHR, ISequentialStream pResponseStream);
    HRESULT OnError(IXMLHTTPRequest2 pXHR, HRESULT hrError);
}

const GUID IID_IXMLHTTPRequest2 = {0xE5D37DC0, 0x552A, 0x4D52, [0x9C, 0xC0, 0xA1, 0x4D, 0x54, 0x6F, 0xBD, 0x04]};
@GUID(0xE5D37DC0, 0x552A, 0x4D52, [0x9C, 0xC0, 0xA1, 0x4D, 0x54, 0x6F, 0xBD, 0x04]);
interface IXMLHTTPRequest2 : IUnknown
{
    HRESULT Open(const(wchar)* pwszMethod, const(wchar)* pwszUrl, IXMLHTTPRequest2Callback pStatusCallback, const(wchar)* pwszUserName, const(wchar)* pwszPassword, const(wchar)* pwszProxyUserName, const(wchar)* pwszProxyPassword);
    HRESULT Send(ISequentialStream pBody, ulong cbBody);
    HRESULT Abort();
    HRESULT SetCookie(const(XHR_COOKIE)* pCookie, uint* pdwCookieState);
    HRESULT SetCustomResponseStream(ISequentialStream pSequentialStream);
    HRESULT SetProperty(XHR_PROPERTY eProperty, ulong ullValue);
    HRESULT SetRequestHeader(const(wchar)* pwszHeader, const(wchar)* pwszValue);
    HRESULT GetAllResponseHeaders(ushort** ppwszHeaders);
    HRESULT GetCookie(const(wchar)* pwszUrl, const(wchar)* pwszName, uint dwFlags, uint* pcCookies, char* ppCookies);
    HRESULT GetResponseHeader(const(wchar)* pwszHeader, ushort** ppwszValue);
}

struct XHR_CERT
{
    uint cbCert;
    ubyte* pbCert;
}

const GUID IID_IXMLHTTPRequest3Callback = {0xB9E57830, 0x8C6C, 0x4A6F, [0x9C, 0x13, 0x47, 0x77, 0x2B, 0xB0, 0x47, 0xBB]};
@GUID(0xB9E57830, 0x8C6C, 0x4A6F, [0x9C, 0x13, 0x47, 0x77, 0x2B, 0xB0, 0x47, 0xBB]);
interface IXMLHTTPRequest3Callback : IXMLHTTPRequest2Callback
{
    HRESULT OnServerCertificateReceived(IXMLHTTPRequest3 pXHR, uint dwCertificateErrors, uint cServerCertificateChain, char* rgServerCertificateChain);
    HRESULT OnClientCertificateRequested(IXMLHTTPRequest3 pXHR, uint cIssuerList, char* rgpwszIssuerList);
}

const GUID IID_IXMLHTTPRequest3 = {0xA1C9FEEE, 0x0617, 0x4F23, [0x9D, 0x58, 0x89, 0x61, 0xEA, 0x43, 0x56, 0x7C]};
@GUID(0xA1C9FEEE, 0x0617, 0x4F23, [0x9D, 0x58, 0x89, 0x61, 0xEA, 0x43, 0x56, 0x7C]);
interface IXMLHTTPRequest3 : IXMLHTTPRequest2
{
    HRESULT SetClientCertificate(uint cbClientCertificateHash, char* pbClientCertificateHash, const(wchar)* pwszPin);
}

