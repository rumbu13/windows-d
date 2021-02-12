module windows.xps;

public import system;
public import windows.automation;
public import windows.com;
public import windows.displaydevices;
public import windows.gdi;
public import windows.packaging;
public import windows.printdocs;
public import windows.security;
public import windows.structuredstorage;
public import windows.systemservices;
public import windows.windowsandmessaging;
public import windows.windowsprogramming;

extern(Windows):

struct DRAWPATRECT
{
    POINT ptPosition;
    POINT ptSize;
    ushort wStyle;
    ushort wPattern;
}

struct PSINJECTDATA
{
    uint DataBytes;
    ushort InjectionPoint;
    ushort PageNumber;
}

struct PSFEATURE_OUTPUT
{
    BOOL bPageIndependent;
    BOOL bSetPageDevice;
}

struct PSFEATURE_CUSTPAPER
{
    int lOrientation;
    int lWidth;
    int lHeight;
    int lWidthOffset;
    int lHeightOffset;
}

struct DEVMODEA
{
    ubyte dmDeviceName;
    ushort dmSpecVersion;
    ushort dmDriverVersion;
    ushort dmSize;
    ushort dmDriverExtra;
    uint dmFields;
    _Anonymous1_e__Union Anonymous1;
    short dmColor;
    short dmDuplex;
    short dmYResolution;
    short dmTTOption;
    short dmCollate;
    ubyte dmFormName;
    ushort dmLogPixels;
    uint dmBitsPerPel;
    uint dmPelsWidth;
    uint dmPelsHeight;
    _Anonymous2_e__Union Anonymous2;
    uint dmDisplayFrequency;
    uint dmICMMethod;
    uint dmICMIntent;
    uint dmMediaType;
    uint dmDitherType;
    uint dmReserved1;
    uint dmReserved2;
    uint dmPanningWidth;
    uint dmPanningHeight;
}

alias ABORTPROC = extern(Windows) BOOL function(HDC param0, int param1);
struct DOCINFOA
{
    int cbSize;
    const(char)* lpszDocName;
    const(char)* lpszOutput;
    const(char)* lpszDatatype;
    uint fwType;
}

struct DOCINFOW
{
    int cbSize;
    const(wchar)* lpszDocName;
    const(wchar)* lpszOutput;
    const(wchar)* lpszDatatype;
    uint fwType;
}

@DllImport("WINSPOOL.dll")
int DeviceCapabilitiesA(const(char)* pDevice, const(char)* pPort, ushort fwCapability, const(char)* pOutput, const(DEVMODEA)* pDevMode);

@DllImport("WINSPOOL.dll")
int DeviceCapabilitiesW(const(wchar)* pDevice, const(wchar)* pPort, ushort fwCapability, const(wchar)* pOutput, const(DEVMODEW)* pDevMode);

@DllImport("GDI32.dll")
int Escape(HDC hdc, int iEscape, int cjIn, const(char)* pvIn, void* pvOut);

@DllImport("GDI32.dll")
int ExtEscape(HDC hdc, int iEscape, int cjInput, const(char)* lpInData, int cjOutput, const(char)* lpOutData);

@DllImport("GDI32.dll")
int StartDocA(HDC hdc, const(DOCINFOA)* lpdi);

@DllImport("GDI32.dll")
int StartDocW(HDC hdc, const(DOCINFOW)* lpdi);

@DllImport("GDI32.dll")
int EndDoc(HDC hdc);

@DllImport("GDI32.dll")
int StartPage(HDC hdc);

@DllImport("GDI32.dll")
int EndPage(HDC hdc);

@DllImport("GDI32.dll")
int AbortDoc(HDC hdc);

@DllImport("GDI32.dll")
int SetAbortProc(HDC hdc, ABORTPROC proc);

@DllImport("USER32.dll")
BOOL PrintWindow(HWND hwnd, HDC hdcBlt, uint nFlags);

@DllImport("prntvpt.dll")
HRESULT PTQuerySchemaVersionSupport(const(wchar)* pszPrinterName, uint* pMaxVersion);

@DllImport("prntvpt.dll")
HRESULT PTOpenProvider(const(wchar)* pszPrinterName, uint dwVersion, HPTPROVIDER__** phProvider);

@DllImport("prntvpt.dll")
HRESULT PTOpenProviderEx(const(wchar)* pszPrinterName, uint dwMaxVersion, uint dwPrefVersion, HPTPROVIDER__** phProvider, uint* pUsedVersion);

@DllImport("prntvpt.dll")
HRESULT PTCloseProvider(HPTPROVIDER__* hProvider);

@DllImport("prntvpt.dll")
HRESULT PTReleaseMemory(void* pBuffer);

@DllImport("prntvpt.dll")
HRESULT PTGetPrintCapabilities(HPTPROVIDER__* hProvider, IStream pPrintTicket, IStream pCapabilities, BSTR* pbstrErrorMessage);

@DllImport("prntvpt.dll")
HRESULT PTGetPrintDeviceCapabilities(HPTPROVIDER__* hProvider, IStream pPrintTicket, IStream pDeviceCapabilities, BSTR* pbstrErrorMessage);

@DllImport("prntvpt.dll")
HRESULT PTGetPrintDeviceResources(HPTPROVIDER__* hProvider, const(wchar)* pszLocaleName, IStream pPrintTicket, IStream pDeviceResources, BSTR* pbstrErrorMessage);

@DllImport("prntvpt.dll")
HRESULT PTMergeAndValidatePrintTicket(HPTPROVIDER__* hProvider, IStream pBaseTicket, IStream pDeltaTicket, EPrintTicketScope scope, IStream pResultTicket, BSTR* pbstrErrorMessage);

@DllImport("prntvpt.dll")
HRESULT PTConvertPrintTicketToDevMode(HPTPROVIDER__* hProvider, IStream pPrintTicket, EDefaultDevmodeType baseDevmodeType, EPrintTicketScope scope, uint* pcbDevmode, DEVMODEA** ppDevmode, BSTR* pbstrErrorMessage);

@DllImport("prntvpt.dll")
HRESULT PTConvertDevModeToPrintTicket(HPTPROVIDER__* hProvider, uint cbDevmode, DEVMODEA* pDevmode, EPrintTicketScope scope, IStream pPrintTicket);

const GUID CLSID_XpsOMObjectFactory = {0xE974D26D, 0x3D9B, 0x4D47, [0x88, 0xCC, 0x38, 0x72, 0xF2, 0xDC, 0x35, 0x85]};
@GUID(0xE974D26D, 0x3D9B, 0x4D47, [0x88, 0xCC, 0x38, 0x72, 0xF2, 0xDC, 0x35, 0x85]);
struct XpsOMObjectFactory;

const GUID CLSID_XpsOMThumbnailGenerator = {0x7E4A23E2, 0xB969, 0x4761, [0xBE, 0x35, 0x1A, 0x8C, 0xED, 0x58, 0xE3, 0x23]};
@GUID(0x7E4A23E2, 0xB969, 0x4761, [0xBE, 0x35, 0x1A, 0x8C, 0xED, 0x58, 0xE3, 0x23]);
struct XpsOMThumbnailGenerator;

enum XPS_TILE_MODE
{
    XPS_TILE_MODE_NONE = 1,
    XPS_TILE_MODE_TILE = 2,
    XPS_TILE_MODE_FLIPX = 3,
    XPS_TILE_MODE_FLIPY = 4,
    XPS_TILE_MODE_FLIPXY = 5,
}

enum XPS_COLOR_INTERPOLATION
{
    XPS_COLOR_INTERPOLATION_SCRGBLINEAR = 1,
    XPS_COLOR_INTERPOLATION_SRGBLINEAR = 2,
}

enum XPS_SPREAD_METHOD
{
    XPS_SPREAD_METHOD_PAD = 1,
    XPS_SPREAD_METHOD_REFLECT = 2,
    XPS_SPREAD_METHOD_REPEAT = 3,
}

enum XPS_STYLE_SIMULATION
{
    XPS_STYLE_SIMULATION_NONE = 1,
    XPS_STYLE_SIMULATION_ITALIC = 2,
    XPS_STYLE_SIMULATION_BOLD = 3,
    XPS_STYLE_SIMULATION_BOLDITALIC = 4,
}

enum XPS_LINE_CAP
{
    XPS_LINE_CAP_FLAT = 1,
    XPS_LINE_CAP_ROUND = 2,
    XPS_LINE_CAP_SQUARE = 3,
    XPS_LINE_CAP_TRIANGLE = 4,
}

enum XPS_DASH_CAP
{
    XPS_DASH_CAP_FLAT = 1,
    XPS_DASH_CAP_ROUND = 2,
    XPS_DASH_CAP_SQUARE = 3,
    XPS_DASH_CAP_TRIANGLE = 4,
}

enum XPS_LINE_JOIN
{
    XPS_LINE_JOIN_MITER = 1,
    XPS_LINE_JOIN_BEVEL = 2,
    XPS_LINE_JOIN_ROUND = 3,
}

enum XPS_IMAGE_TYPE
{
    XPS_IMAGE_TYPE_JPEG = 1,
    XPS_IMAGE_TYPE_PNG = 2,
    XPS_IMAGE_TYPE_TIFF = 3,
    XPS_IMAGE_TYPE_WDP = 4,
    XPS_IMAGE_TYPE_JXR = 5,
}

enum XPS_COLOR_TYPE
{
    XPS_COLOR_TYPE_SRGB = 1,
    XPS_COLOR_TYPE_SCRGB = 2,
    XPS_COLOR_TYPE_CONTEXT = 3,
}

enum XPS_FILL_RULE
{
    XPS_FILL_RULE_EVENODD = 1,
    XPS_FILL_RULE_NONZERO = 2,
}

enum XPS_SEGMENT_TYPE
{
    XPS_SEGMENT_TYPE_ARC_LARGE_CLOCKWISE = 1,
    XPS_SEGMENT_TYPE_ARC_LARGE_COUNTERCLOCKWISE = 2,
    XPS_SEGMENT_TYPE_ARC_SMALL_CLOCKWISE = 3,
    XPS_SEGMENT_TYPE_ARC_SMALL_COUNTERCLOCKWISE = 4,
    XPS_SEGMENT_TYPE_BEZIER = 5,
    XPS_SEGMENT_TYPE_LINE = 6,
    XPS_SEGMENT_TYPE_QUADRATIC_BEZIER = 7,
}

enum XPS_SEGMENT_STROKE_PATTERN
{
    XPS_SEGMENT_STROKE_PATTERN_ALL = 1,
    XPS_SEGMENT_STROKE_PATTERN_NONE = 2,
    XPS_SEGMENT_STROKE_PATTERN_MIXED = 3,
}

enum XPS_FONT_EMBEDDING
{
    XPS_FONT_EMBEDDING_NORMAL = 1,
    XPS_FONT_EMBEDDING_OBFUSCATED = 2,
    XPS_FONT_EMBEDDING_RESTRICTED = 3,
    XPS_FONT_EMBEDDING_RESTRICTED_UNOBFUSCATED = 4,
}

enum XPS_OBJECT_TYPE
{
    XPS_OBJECT_TYPE_CANVAS = 1,
    XPS_OBJECT_TYPE_GLYPHS = 2,
    XPS_OBJECT_TYPE_PATH = 3,
    XPS_OBJECT_TYPE_MATRIX_TRANSFORM = 4,
    XPS_OBJECT_TYPE_GEOMETRY = 5,
    XPS_OBJECT_TYPE_SOLID_COLOR_BRUSH = 6,
    XPS_OBJECT_TYPE_IMAGE_BRUSH = 7,
    XPS_OBJECT_TYPE_LINEAR_GRADIENT_BRUSH = 8,
    XPS_OBJECT_TYPE_RADIAL_GRADIENT_BRUSH = 9,
    XPS_OBJECT_TYPE_VISUAL_BRUSH = 10,
}

enum XPS_THUMBNAIL_SIZE
{
    XPS_THUMBNAIL_SIZE_VERYSMALL = 1,
    XPS_THUMBNAIL_SIZE_SMALL = 2,
    XPS_THUMBNAIL_SIZE_MEDIUM = 3,
    XPS_THUMBNAIL_SIZE_LARGE = 4,
}

enum XPS_INTERLEAVING
{
    XPS_INTERLEAVING_OFF = 1,
    XPS_INTERLEAVING_ON = 2,
}

struct XPS_POINT
{
    float x;
    float y;
}

struct XPS_SIZE
{
    float width;
    float height;
}

struct XPS_RECT
{
    float x;
    float y;
    float width;
    float height;
}

struct XPS_DASH
{
    float length;
    float gap;
}

struct XPS_GLYPH_MAPPING
{
    uint unicodeStringStart;
    ushort unicodeStringLength;
    uint glyphIndicesStart;
    ushort glyphIndicesLength;
}

struct XPS_MATRIX
{
    float m11;
    float m12;
    float m21;
    float m22;
    float m31;
    float m32;
}

struct XPS_COLOR
{
    XPS_COLOR_TYPE colorType;
    __MIDL___MIDL_itf_xpsobjectmodel_0000_0000_0028 value;
}

const GUID IID_IXpsOMShareable = {0x7137398F, 0x2FC1, 0x454D, [0x8C, 0x6A, 0x2C, 0x31, 0x15, 0xA1, 0x6E, 0xCE]};
@GUID(0x7137398F, 0x2FC1, 0x454D, [0x8C, 0x6A, 0x2C, 0x31, 0x15, 0xA1, 0x6E, 0xCE]);
interface IXpsOMShareable : IUnknown
{
    HRESULT GetOwner(IUnknown* owner);
    HRESULT GetType(XPS_OBJECT_TYPE* type);
}

const GUID IID_IXpsOMVisual = {0xBC3E7333, 0xFB0B, 0x4AF3, [0xA8, 0x19, 0x0B, 0x4E, 0xAA, 0xD0, 0xD2, 0xFD]};
@GUID(0xBC3E7333, 0xFB0B, 0x4AF3, [0xA8, 0x19, 0x0B, 0x4E, 0xAA, 0xD0, 0xD2, 0xFD]);
interface IXpsOMVisual : IXpsOMShareable
{
    HRESULT GetTransform(IXpsOMMatrixTransform* matrixTransform);
    HRESULT GetTransformLocal(IXpsOMMatrixTransform* matrixTransform);
    HRESULT SetTransformLocal(IXpsOMMatrixTransform matrixTransform);
    HRESULT GetTransformLookup(ushort** key);
    HRESULT SetTransformLookup(const(wchar)* key);
    HRESULT GetClipGeometry(IXpsOMGeometry* clipGeometry);
    HRESULT GetClipGeometryLocal(IXpsOMGeometry* clipGeometry);
    HRESULT SetClipGeometryLocal(IXpsOMGeometry clipGeometry);
    HRESULT GetClipGeometryLookup(ushort** key);
    HRESULT SetClipGeometryLookup(const(wchar)* key);
    HRESULT GetOpacity(float* opacity);
    HRESULT SetOpacity(float opacity);
    HRESULT GetOpacityMaskBrush(IXpsOMBrush* opacityMaskBrush);
    HRESULT GetOpacityMaskBrushLocal(IXpsOMBrush* opacityMaskBrush);
    HRESULT SetOpacityMaskBrushLocal(IXpsOMBrush opacityMaskBrush);
    HRESULT GetOpacityMaskBrushLookup(ushort** key);
    HRESULT SetOpacityMaskBrushLookup(const(wchar)* key);
    HRESULT GetName(ushort** name);
    HRESULT SetName(const(wchar)* name);
    HRESULT GetIsHyperlinkTarget(int* isHyperlink);
    HRESULT SetIsHyperlinkTarget(BOOL isHyperlink);
    HRESULT GetHyperlinkNavigateUri(IUri* hyperlinkUri);
    HRESULT SetHyperlinkNavigateUri(IUri hyperlinkUri);
    HRESULT GetLanguage(ushort** language);
    HRESULT SetLanguage(const(wchar)* language);
}

const GUID IID_IXpsOMPart = {0x74EB2F0B, 0xA91E, 0x4486, [0xAF, 0xAC, 0x0F, 0xAB, 0xEC, 0xA3, 0xDF, 0xC6]};
@GUID(0x74EB2F0B, 0xA91E, 0x4486, [0xAF, 0xAC, 0x0F, 0xAB, 0xEC, 0xA3, 0xDF, 0xC6]);
interface IXpsOMPart : IUnknown
{
    HRESULT GetPartName(IOpcPartUri* partUri);
    HRESULT SetPartName(IOpcPartUri partUri);
}

const GUID IID_IXpsOMGlyphsEditor = {0xA5AB8616, 0x5B16, 0x4B9F, [0x96, 0x29, 0x89, 0xB3, 0x23, 0xED, 0x79, 0x09]};
@GUID(0xA5AB8616, 0x5B16, 0x4B9F, [0x96, 0x29, 0x89, 0xB3, 0x23, 0xED, 0x79, 0x09]);
interface IXpsOMGlyphsEditor : IUnknown
{
    HRESULT ApplyEdits();
    HRESULT GetUnicodeString(ushort** unicodeString);
    HRESULT SetUnicodeString(const(wchar)* unicodeString);
    HRESULT GetGlyphIndexCount(uint* indexCount);
    HRESULT GetGlyphIndicesA(uint* indexCount, XPS_GLYPH_INDEX* glyphIndices);
    HRESULT SetGlyphIndices(uint indexCount, const(XPS_GLYPH_INDEX)* glyphIndices);
    HRESULT GetGlyphMappingCount(uint* glyphMappingCount);
    HRESULT GetGlyphMappings(uint* glyphMappingCount, XPS_GLYPH_MAPPING* glyphMappings);
    HRESULT SetGlyphMappings(uint glyphMappingCount, const(XPS_GLYPH_MAPPING)* glyphMappings);
    HRESULT GetProhibitedCaretStopCount(uint* prohibitedCaretStopCount);
    HRESULT GetProhibitedCaretStops(uint* count, uint* prohibitedCaretStops);
    HRESULT SetProhibitedCaretStops(uint count, const(uint)* prohibitedCaretStops);
    HRESULT GetBidiLevel(uint* bidiLevel);
    HRESULT SetBidiLevel(uint bidiLevel);
    HRESULT GetIsSideways(int* isSideways);
    HRESULT SetIsSideways(BOOL isSideways);
    HRESULT GetDeviceFontName(ushort** deviceFontName);
    HRESULT SetDeviceFontName(const(wchar)* deviceFontName);
}

const GUID IID_IXpsOMGlyphs = {0x819B3199, 0x0A5A, 0x4B64, [0xBE, 0xC7, 0xA9, 0xE1, 0x7E, 0x78, 0x0D, 0xE2]};
@GUID(0x819B3199, 0x0A5A, 0x4B64, [0xBE, 0xC7, 0xA9, 0xE1, 0x7E, 0x78, 0x0D, 0xE2]);
interface IXpsOMGlyphs : IXpsOMVisual
{
    HRESULT GetUnicodeString(ushort** unicodeString);
    HRESULT GetGlyphIndexCount(uint* indexCount);
    HRESULT GetGlyphIndicesA(uint* indexCount, XPS_GLYPH_INDEX* glyphIndices);
    HRESULT GetGlyphMappingCount(uint* glyphMappingCount);
    HRESULT GetGlyphMappings(uint* glyphMappingCount, XPS_GLYPH_MAPPING* glyphMappings);
    HRESULT GetProhibitedCaretStopCount(uint* prohibitedCaretStopCount);
    HRESULT GetProhibitedCaretStops(uint* prohibitedCaretStopCount, uint* prohibitedCaretStops);
    HRESULT GetBidiLevel(uint* bidiLevel);
    HRESULT GetIsSideways(int* isSideways);
    HRESULT GetDeviceFontName(ushort** deviceFontName);
    HRESULT GetStyleSimulations(XPS_STYLE_SIMULATION* styleSimulations);
    HRESULT SetStyleSimulations(XPS_STYLE_SIMULATION styleSimulations);
    HRESULT GetOrigin(XPS_POINT* origin);
    HRESULT SetOrigin(const(XPS_POINT)* origin);
    HRESULT GetFontRenderingEmSize(float* fontRenderingEmSize);
    HRESULT SetFontRenderingEmSize(float fontRenderingEmSize);
    HRESULT GetFontResource(IXpsOMFontResource* fontResource);
    HRESULT SetFontResource(IXpsOMFontResource fontResource);
    HRESULT GetFontFaceIndex(short* fontFaceIndex);
    HRESULT SetFontFaceIndex(short fontFaceIndex);
    HRESULT GetFillBrush(IXpsOMBrush* fillBrush);
    HRESULT GetFillBrushLocal(IXpsOMBrush* fillBrush);
    HRESULT SetFillBrushLocal(IXpsOMBrush fillBrush);
    HRESULT GetFillBrushLookup(ushort** key);
    HRESULT SetFillBrushLookup(const(wchar)* key);
    HRESULT GetGlyphsEditor(IXpsOMGlyphsEditor* editor);
    HRESULT Clone(IXpsOMGlyphs* glyphs);
}

const GUID IID_IXpsOMDashCollection = {0x081613F4, 0x74EB, 0x48F2, [0x83, 0xB3, 0x37, 0xA9, 0xCE, 0x2D, 0x7D, 0xC6]};
@GUID(0x081613F4, 0x74EB, 0x48F2, [0x83, 0xB3, 0x37, 0xA9, 0xCE, 0x2D, 0x7D, 0xC6]);
interface IXpsOMDashCollection : IUnknown
{
    HRESULT GetCount(uint* count);
    HRESULT GetAt(uint index, XPS_DASH* dash);
    HRESULT InsertAt(uint index, const(XPS_DASH)* dash);
    HRESULT RemoveAt(uint index);
    HRESULT SetAt(uint index, const(XPS_DASH)* dash);
    HRESULT Append(const(XPS_DASH)* dash);
}

const GUID IID_IXpsOMMatrixTransform = {0xB77330FF, 0xBB37, 0x4501, [0xA9, 0x3E, 0xF1, 0xB1, 0xE5, 0x0B, 0xFC, 0x46]};
@GUID(0xB77330FF, 0xBB37, 0x4501, [0xA9, 0x3E, 0xF1, 0xB1, 0xE5, 0x0B, 0xFC, 0x46]);
interface IXpsOMMatrixTransform : IXpsOMShareable
{
    HRESULT GetMatrix(XPS_MATRIX* matrix);
    HRESULT SetMatrix(const(XPS_MATRIX)* matrix);
    HRESULT Clone(IXpsOMMatrixTransform* matrixTransform);
}

const GUID IID_IXpsOMGeometry = {0x64FCF3D7, 0x4D58, 0x44BA, [0xAD, 0x73, 0xA1, 0x3A, 0xF6, 0x49, 0x20, 0x72]};
@GUID(0x64FCF3D7, 0x4D58, 0x44BA, [0xAD, 0x73, 0xA1, 0x3A, 0xF6, 0x49, 0x20, 0x72]);
interface IXpsOMGeometry : IXpsOMShareable
{
    HRESULT GetFigures(IXpsOMGeometryFigureCollection* figures);
    HRESULT GetFillRule(XPS_FILL_RULE* fillRule);
    HRESULT SetFillRule(XPS_FILL_RULE fillRule);
    HRESULT GetTransform(IXpsOMMatrixTransform* transform);
    HRESULT GetTransformLocal(IXpsOMMatrixTransform* transform);
    HRESULT SetTransformLocal(IXpsOMMatrixTransform transform);
    HRESULT GetTransformLookup(ushort** lookup);
    HRESULT SetTransformLookup(const(wchar)* lookup);
    HRESULT Clone(IXpsOMGeometry* geometry);
}

const GUID IID_IXpsOMGeometryFigure = {0xD410DC83, 0x908C, 0x443E, [0x89, 0x47, 0xB1, 0x79, 0x5D, 0x3C, 0x16, 0x5A]};
@GUID(0xD410DC83, 0x908C, 0x443E, [0x89, 0x47, 0xB1, 0x79, 0x5D, 0x3C, 0x16, 0x5A]);
interface IXpsOMGeometryFigure : IUnknown
{
    HRESULT GetOwner(IXpsOMGeometry* owner);
    HRESULT GetSegmentData(uint* dataCount, float* segmentData);
    HRESULT GetSegmentTypes(uint* segmentCount, XPS_SEGMENT_TYPE* segmentTypes);
    HRESULT GetSegmentStrokes(uint* segmentCount, int* segmentStrokes);
    HRESULT SetSegments(uint segmentCount, uint segmentDataCount, const(XPS_SEGMENT_TYPE)* segmentTypes, const(float)* segmentData, const(int)* segmentStrokes);
    HRESULT GetStartPoint(XPS_POINT* startPoint);
    HRESULT SetStartPoint(const(XPS_POINT)* startPoint);
    HRESULT GetIsClosed(int* isClosed);
    HRESULT SetIsClosed(BOOL isClosed);
    HRESULT GetIsFilled(int* isFilled);
    HRESULT SetIsFilled(BOOL isFilled);
    HRESULT GetSegmentCount(uint* segmentCount);
    HRESULT GetSegmentDataCount(uint* segmentDataCount);
    HRESULT GetSegmentStrokePattern(XPS_SEGMENT_STROKE_PATTERN* segmentStrokePattern);
    HRESULT Clone(IXpsOMGeometryFigure* geometryFigure);
}

const GUID IID_IXpsOMGeometryFigureCollection = {0xFD48C3F3, 0xA58E, 0x4B5A, [0x88, 0x26, 0x1D, 0xE5, 0x4A, 0xBE, 0x72, 0xB2]};
@GUID(0xFD48C3F3, 0xA58E, 0x4B5A, [0x88, 0x26, 0x1D, 0xE5, 0x4A, 0xBE, 0x72, 0xB2]);
interface IXpsOMGeometryFigureCollection : IUnknown
{
    HRESULT GetCount(uint* count);
    HRESULT GetAt(uint index, IXpsOMGeometryFigure* geometryFigure);
    HRESULT InsertAt(uint index, IXpsOMGeometryFigure geometryFigure);
    HRESULT RemoveAt(uint index);
    HRESULT SetAt(uint index, IXpsOMGeometryFigure geometryFigure);
    HRESULT Append(IXpsOMGeometryFigure geometryFigure);
}

const GUID IID_IXpsOMPath = {0x37D38BB6, 0x3EE9, 0x4110, [0x93, 0x12, 0x14, 0xB1, 0x94, 0x16, 0x33, 0x37]};
@GUID(0x37D38BB6, 0x3EE9, 0x4110, [0x93, 0x12, 0x14, 0xB1, 0x94, 0x16, 0x33, 0x37]);
interface IXpsOMPath : IXpsOMVisual
{
    HRESULT GetGeometry(IXpsOMGeometry* geometry);
    HRESULT GetGeometryLocal(IXpsOMGeometry* geometry);
    HRESULT SetGeometryLocal(IXpsOMGeometry geometry);
    HRESULT GetGeometryLookup(ushort** lookup);
    HRESULT SetGeometryLookup(const(wchar)* lookup);
    HRESULT GetAccessibilityShortDescription(ushort** shortDescription);
    HRESULT SetAccessibilityShortDescription(const(wchar)* shortDescription);
    HRESULT GetAccessibilityLongDescription(ushort** longDescription);
    HRESULT SetAccessibilityLongDescription(const(wchar)* longDescription);
    HRESULT GetSnapsToPixels(int* snapsToPixels);
    HRESULT SetSnapsToPixels(BOOL snapsToPixels);
    HRESULT GetStrokeBrush(IXpsOMBrush* brush);
    HRESULT GetStrokeBrushLocal(IXpsOMBrush* brush);
    HRESULT SetStrokeBrushLocal(IXpsOMBrush brush);
    HRESULT GetStrokeBrushLookup(ushort** lookup);
    HRESULT SetStrokeBrushLookup(const(wchar)* lookup);
    HRESULT GetStrokeDashes(IXpsOMDashCollection* strokeDashes);
    HRESULT GetStrokeDashCap(XPS_DASH_CAP* strokeDashCap);
    HRESULT SetStrokeDashCap(XPS_DASH_CAP strokeDashCap);
    HRESULT GetStrokeDashOffset(float* strokeDashOffset);
    HRESULT SetStrokeDashOffset(float strokeDashOffset);
    HRESULT GetStrokeStartLineCap(XPS_LINE_CAP* strokeStartLineCap);
    HRESULT SetStrokeStartLineCap(XPS_LINE_CAP strokeStartLineCap);
    HRESULT GetStrokeEndLineCap(XPS_LINE_CAP* strokeEndLineCap);
    HRESULT SetStrokeEndLineCap(XPS_LINE_CAP strokeEndLineCap);
    HRESULT GetStrokeLineJoin(XPS_LINE_JOIN* strokeLineJoin);
    HRESULT SetStrokeLineJoin(XPS_LINE_JOIN strokeLineJoin);
    HRESULT GetStrokeMiterLimit(float* strokeMiterLimit);
    HRESULT SetStrokeMiterLimit(float strokeMiterLimit);
    HRESULT GetStrokeThickness(float* strokeThickness);
    HRESULT SetStrokeThickness(float strokeThickness);
    HRESULT GetFillBrush(IXpsOMBrush* brush);
    HRESULT GetFillBrushLocal(IXpsOMBrush* brush);
    HRESULT SetFillBrushLocal(IXpsOMBrush brush);
    HRESULT GetFillBrushLookup(ushort** lookup);
    HRESULT SetFillBrushLookup(const(wchar)* lookup);
    HRESULT Clone(IXpsOMPath* path);
}

const GUID IID_IXpsOMBrush = {0x56A3F80C, 0xEA4C, 0x4187, [0xA5, 0x7B, 0xA2, 0xA4, 0x73, 0xB2, 0xB4, 0x2B]};
@GUID(0x56A3F80C, 0xEA4C, 0x4187, [0xA5, 0x7B, 0xA2, 0xA4, 0x73, 0xB2, 0xB4, 0x2B]);
interface IXpsOMBrush : IXpsOMShareable
{
    HRESULT GetOpacity(float* opacity);
    HRESULT SetOpacity(float opacity);
}

const GUID IID_IXpsOMGradientStopCollection = {0xC9174C3A, 0x3CD3, 0x4319, [0xBD, 0xA4, 0x11, 0xA3, 0x93, 0x92, 0xCE, 0xEF]};
@GUID(0xC9174C3A, 0x3CD3, 0x4319, [0xBD, 0xA4, 0x11, 0xA3, 0x93, 0x92, 0xCE, 0xEF]);
interface IXpsOMGradientStopCollection : IUnknown
{
    HRESULT GetCount(uint* count);
    HRESULT GetAt(uint index, IXpsOMGradientStop* stop);
    HRESULT InsertAt(uint index, IXpsOMGradientStop stop);
    HRESULT RemoveAt(uint index);
    HRESULT SetAt(uint index, IXpsOMGradientStop stop);
    HRESULT Append(IXpsOMGradientStop stop);
}

const GUID IID_IXpsOMSolidColorBrush = {0xA06F9F05, 0x3BE9, 0x4763, [0x98, 0xA8, 0x09, 0x4F, 0xC6, 0x72, 0xE4, 0x88]};
@GUID(0xA06F9F05, 0x3BE9, 0x4763, [0x98, 0xA8, 0x09, 0x4F, 0xC6, 0x72, 0xE4, 0x88]);
interface IXpsOMSolidColorBrush : IXpsOMBrush
{
    HRESULT GetColor(XPS_COLOR* color, IXpsOMColorProfileResource* colorProfile);
    HRESULT SetColor(const(XPS_COLOR)* color, IXpsOMColorProfileResource colorProfile);
    HRESULT Clone(IXpsOMSolidColorBrush* solidColorBrush);
}

const GUID IID_IXpsOMTileBrush = {0x0FC2328D, 0xD722, 0x4A54, [0xB2, 0xEC, 0xBE, 0x90, 0x21, 0x8A, 0x78, 0x9E]};
@GUID(0x0FC2328D, 0xD722, 0x4A54, [0xB2, 0xEC, 0xBE, 0x90, 0x21, 0x8A, 0x78, 0x9E]);
interface IXpsOMTileBrush : IXpsOMBrush
{
    HRESULT GetTransform(IXpsOMMatrixTransform* transform);
    HRESULT GetTransformLocal(IXpsOMMatrixTransform* transform);
    HRESULT SetTransformLocal(IXpsOMMatrixTransform transform);
    HRESULT GetTransformLookup(ushort** key);
    HRESULT SetTransformLookup(const(wchar)* key);
    HRESULT GetViewbox(XPS_RECT* viewbox);
    HRESULT SetViewbox(const(XPS_RECT)* viewbox);
    HRESULT GetViewport(XPS_RECT* viewport);
    HRESULT SetViewport(const(XPS_RECT)* viewport);
    HRESULT GetTileMode(XPS_TILE_MODE* tileMode);
    HRESULT SetTileMode(XPS_TILE_MODE tileMode);
}

const GUID IID_IXpsOMVisualBrush = {0x97E294AF, 0x5B37, 0x46B4, [0x80, 0x57, 0x87, 0x4D, 0x2F, 0x64, 0x11, 0x9B]};
@GUID(0x97E294AF, 0x5B37, 0x46B4, [0x80, 0x57, 0x87, 0x4D, 0x2F, 0x64, 0x11, 0x9B]);
interface IXpsOMVisualBrush : IXpsOMTileBrush
{
    HRESULT GetVisual(IXpsOMVisual* visual);
    HRESULT GetVisualLocal(IXpsOMVisual* visual);
    HRESULT SetVisualLocal(IXpsOMVisual visual);
    HRESULT GetVisualLookup(ushort** lookup);
    HRESULT SetVisualLookup(const(wchar)* lookup);
    HRESULT Clone(IXpsOMVisualBrush* visualBrush);
}

const GUID IID_IXpsOMImageBrush = {0x3DF0B466, 0xD382, 0x49EF, [0x85, 0x50, 0xDD, 0x94, 0xC8, 0x02, 0x42, 0xE4]};
@GUID(0x3DF0B466, 0xD382, 0x49EF, [0x85, 0x50, 0xDD, 0x94, 0xC8, 0x02, 0x42, 0xE4]);
interface IXpsOMImageBrush : IXpsOMTileBrush
{
    HRESULT GetImageResource(IXpsOMImageResource* imageResource);
    HRESULT SetImageResource(IXpsOMImageResource imageResource);
    HRESULT GetColorProfileResource(IXpsOMColorProfileResource* colorProfileResource);
    HRESULT SetColorProfileResource(IXpsOMColorProfileResource colorProfileResource);
    HRESULT Clone(IXpsOMImageBrush* imageBrush);
}

const GUID IID_IXpsOMGradientStop = {0x5CF4F5CC, 0x3969, 0x49B5, [0xA7, 0x0A, 0x55, 0x50, 0xB6, 0x18, 0xFE, 0x49]};
@GUID(0x5CF4F5CC, 0x3969, 0x49B5, [0xA7, 0x0A, 0x55, 0x50, 0xB6, 0x18, 0xFE, 0x49]);
interface IXpsOMGradientStop : IUnknown
{
    HRESULT GetOwner(IXpsOMGradientBrush* owner);
    HRESULT GetOffset(float* offset);
    HRESULT SetOffset(float offset);
    HRESULT GetColor(XPS_COLOR* color, IXpsOMColorProfileResource* colorProfile);
    HRESULT SetColor(const(XPS_COLOR)* color, IXpsOMColorProfileResource colorProfile);
    HRESULT Clone(IXpsOMGradientStop* gradientStop);
}

const GUID IID_IXpsOMGradientBrush = {0xEDB59622, 0x61A2, 0x42C3, [0xBA, 0xCE, 0xAC, 0xF2, 0x28, 0x6C, 0x06, 0xBF]};
@GUID(0xEDB59622, 0x61A2, 0x42C3, [0xBA, 0xCE, 0xAC, 0xF2, 0x28, 0x6C, 0x06, 0xBF]);
interface IXpsOMGradientBrush : IXpsOMBrush
{
    HRESULT GetGradientStops(IXpsOMGradientStopCollection* gradientStops);
    HRESULT GetTransform(IXpsOMMatrixTransform* transform);
    HRESULT GetTransformLocal(IXpsOMMatrixTransform* transform);
    HRESULT SetTransformLocal(IXpsOMMatrixTransform transform);
    HRESULT GetTransformLookup(ushort** key);
    HRESULT SetTransformLookup(const(wchar)* key);
    HRESULT GetSpreadMethod(XPS_SPREAD_METHOD* spreadMethod);
    HRESULT SetSpreadMethod(XPS_SPREAD_METHOD spreadMethod);
    HRESULT GetColorInterpolationMode(XPS_COLOR_INTERPOLATION* colorInterpolationMode);
    HRESULT SetColorInterpolationMode(XPS_COLOR_INTERPOLATION colorInterpolationMode);
}

const GUID IID_IXpsOMLinearGradientBrush = {0x005E279F, 0xC30D, 0x40FF, [0x93, 0xEC, 0x19, 0x50, 0xD3, 0xC5, 0x28, 0xDB]};
@GUID(0x005E279F, 0xC30D, 0x40FF, [0x93, 0xEC, 0x19, 0x50, 0xD3, 0xC5, 0x28, 0xDB]);
interface IXpsOMLinearGradientBrush : IXpsOMGradientBrush
{
    HRESULT GetStartPoint(XPS_POINT* startPoint);
    HRESULT SetStartPoint(const(XPS_POINT)* startPoint);
    HRESULT GetEndPoint(XPS_POINT* endPoint);
    HRESULT SetEndPoint(const(XPS_POINT)* endPoint);
    HRESULT Clone(IXpsOMLinearGradientBrush* linearGradientBrush);
}

const GUID IID_IXpsOMRadialGradientBrush = {0x75F207E5, 0x08BF, 0x413C, [0x96, 0xB1, 0xB8, 0x2B, 0x40, 0x64, 0x17, 0x6B]};
@GUID(0x75F207E5, 0x08BF, 0x413C, [0x96, 0xB1, 0xB8, 0x2B, 0x40, 0x64, 0x17, 0x6B]);
interface IXpsOMRadialGradientBrush : IXpsOMGradientBrush
{
    HRESULT GetCenter(XPS_POINT* center);
    HRESULT SetCenter(const(XPS_POINT)* center);
    HRESULT GetRadiiSizes(XPS_SIZE* radiiSizes);
    HRESULT SetRadiiSizes(const(XPS_SIZE)* radiiSizes);
    HRESULT GetGradientOrigin(XPS_POINT* origin);
    HRESULT SetGradientOrigin(const(XPS_POINT)* origin);
    HRESULT Clone(IXpsOMRadialGradientBrush* radialGradientBrush);
}

const GUID IID_IXpsOMResource = {0xDA2AC0A2, 0x73A2, 0x4975, [0xAD, 0x14, 0x74, 0x09, 0x7C, 0x3F, 0xF3, 0xA5]};
@GUID(0xDA2AC0A2, 0x73A2, 0x4975, [0xAD, 0x14, 0x74, 0x09, 0x7C, 0x3F, 0xF3, 0xA5]);
interface IXpsOMResource : IXpsOMPart
{
}

const GUID IID_IXpsOMPartResources = {0xF4CF7729, 0x4864, 0x4275, [0x99, 0xB3, 0xA8, 0x71, 0x71, 0x63, 0xEC, 0xAF]};
@GUID(0xF4CF7729, 0x4864, 0x4275, [0x99, 0xB3, 0xA8, 0x71, 0x71, 0x63, 0xEC, 0xAF]);
interface IXpsOMPartResources : IUnknown
{
    HRESULT GetFontResources(IXpsOMFontResourceCollection* fontResources);
    HRESULT GetImageResources(IXpsOMImageResourceCollection* imageResources);
    HRESULT GetColorProfileResources(IXpsOMColorProfileResourceCollection* colorProfileResources);
    HRESULT GetRemoteDictionaryResources(IXpsOMRemoteDictionaryResourceCollection* dictionaryResources);
}

const GUID IID_IXpsOMDictionary = {0x897C86B8, 0x8EAF, 0x4AE3, [0xBD, 0xDE, 0x56, 0x41, 0x9F, 0xCF, 0x42, 0x36]};
@GUID(0x897C86B8, 0x8EAF, 0x4AE3, [0xBD, 0xDE, 0x56, 0x41, 0x9F, 0xCF, 0x42, 0x36]);
interface IXpsOMDictionary : IUnknown
{
    HRESULT GetOwner(IUnknown* owner);
    HRESULT GetCount(uint* count);
    HRESULT GetAt(uint index, ushort** key, IXpsOMShareable* entry);
    HRESULT GetByKey(const(wchar)* key, IXpsOMShareable beforeEntry, IXpsOMShareable* entry);
    HRESULT GetIndex(IXpsOMShareable entry, uint* index);
    HRESULT Append(const(wchar)* key, IXpsOMShareable entry);
    HRESULT InsertAt(uint index, const(wchar)* key, IXpsOMShareable entry);
    HRESULT RemoveAt(uint index);
    HRESULT SetAt(uint index, const(wchar)* key, IXpsOMShareable entry);
    HRESULT Clone(IXpsOMDictionary* dictionary);
}

const GUID IID_IXpsOMFontResource = {0xA8C45708, 0x47D9, 0x4AF4, [0x8D, 0x20, 0x33, 0xB4, 0x8C, 0x9B, 0x84, 0x85]};
@GUID(0xA8C45708, 0x47D9, 0x4AF4, [0x8D, 0x20, 0x33, 0xB4, 0x8C, 0x9B, 0x84, 0x85]);
interface IXpsOMFontResource : IXpsOMResource
{
    HRESULT GetStream(IStream* readerStream);
    HRESULT SetContent(IStream sourceStream, XPS_FONT_EMBEDDING embeddingOption, IOpcPartUri partName);
    HRESULT GetEmbeddingOption(XPS_FONT_EMBEDDING* embeddingOption);
}

const GUID IID_IXpsOMFontResourceCollection = {0x70B4A6BB, 0x88D4, 0x4FA8, [0xAA, 0xF9, 0x6D, 0x9C, 0x59, 0x6F, 0xDB, 0xAD]};
@GUID(0x70B4A6BB, 0x88D4, 0x4FA8, [0xAA, 0xF9, 0x6D, 0x9C, 0x59, 0x6F, 0xDB, 0xAD]);
interface IXpsOMFontResourceCollection : IUnknown
{
    HRESULT GetCount(uint* count);
    HRESULT GetAt(uint index, IXpsOMFontResource* value);
    HRESULT SetAt(uint index, IXpsOMFontResource value);
    HRESULT InsertAt(uint index, IXpsOMFontResource value);
    HRESULT Append(IXpsOMFontResource value);
    HRESULT RemoveAt(uint index);
    HRESULT GetByPartName(IOpcPartUri partName, IXpsOMFontResource* part);
}

const GUID IID_IXpsOMImageResource = {0x3DB8417D, 0xAE50, 0x485E, [0x9A, 0x44, 0xD7, 0x75, 0x8F, 0x78, 0xA2, 0x3F]};
@GUID(0x3DB8417D, 0xAE50, 0x485E, [0x9A, 0x44, 0xD7, 0x75, 0x8F, 0x78, 0xA2, 0x3F]);
interface IXpsOMImageResource : IXpsOMResource
{
    HRESULT GetStream(IStream* readerStream);
    HRESULT SetContent(IStream sourceStream, XPS_IMAGE_TYPE imageType, IOpcPartUri partName);
    HRESULT GetImageType(XPS_IMAGE_TYPE* imageType);
}

const GUID IID_IXpsOMImageResourceCollection = {0x7A4A1A71, 0x9CDE, 0x4B71, [0xB3, 0x3F, 0x62, 0xDE, 0x84, 0x3E, 0xAB, 0xFE]};
@GUID(0x7A4A1A71, 0x9CDE, 0x4B71, [0xB3, 0x3F, 0x62, 0xDE, 0x84, 0x3E, 0xAB, 0xFE]);
interface IXpsOMImageResourceCollection : IUnknown
{
    HRESULT GetCount(uint* count);
    HRESULT GetAt(uint index, IXpsOMImageResource* object);
    HRESULT InsertAt(uint index, IXpsOMImageResource object);
    HRESULT RemoveAt(uint index);
    HRESULT SetAt(uint index, IXpsOMImageResource object);
    HRESULT Append(IXpsOMImageResource object);
    HRESULT GetByPartName(IOpcPartUri partName, IXpsOMImageResource* part);
}

const GUID IID_IXpsOMColorProfileResource = {0x67BD7D69, 0x1EEF, 0x4BB1, [0xB5, 0xE7, 0x6F, 0x4F, 0x87, 0xBE, 0x8A, 0xBE]};
@GUID(0x67BD7D69, 0x1EEF, 0x4BB1, [0xB5, 0xE7, 0x6F, 0x4F, 0x87, 0xBE, 0x8A, 0xBE]);
interface IXpsOMColorProfileResource : IXpsOMResource
{
    HRESULT GetStream(IStream* stream);
    HRESULT SetContent(IStream sourceStream, IOpcPartUri partName);
}

const GUID IID_IXpsOMColorProfileResourceCollection = {0x12759630, 0x5FBA, 0x4283, [0x8F, 0x7D, 0xCC, 0xA8, 0x49, 0x80, 0x9E, 0xDB]};
@GUID(0x12759630, 0x5FBA, 0x4283, [0x8F, 0x7D, 0xCC, 0xA8, 0x49, 0x80, 0x9E, 0xDB]);
interface IXpsOMColorProfileResourceCollection : IUnknown
{
    HRESULT GetCount(uint* count);
    HRESULT GetAt(uint index, IXpsOMColorProfileResource* object);
    HRESULT InsertAt(uint index, IXpsOMColorProfileResource object);
    HRESULT RemoveAt(uint index);
    HRESULT SetAt(uint index, IXpsOMColorProfileResource object);
    HRESULT Append(IXpsOMColorProfileResource object);
    HRESULT GetByPartName(IOpcPartUri partName, IXpsOMColorProfileResource* part);
}

const GUID IID_IXpsOMPrintTicketResource = {0xE7FF32D2, 0x34AA, 0x499B, [0xBB, 0xE9, 0x9C, 0xD4, 0xEE, 0x6C, 0x59, 0xF7]};
@GUID(0xE7FF32D2, 0x34AA, 0x499B, [0xBB, 0xE9, 0x9C, 0xD4, 0xEE, 0x6C, 0x59, 0xF7]);
interface IXpsOMPrintTicketResource : IXpsOMResource
{
    HRESULT GetStream(IStream* stream);
    HRESULT SetContent(IStream sourceStream, IOpcPartUri partName);
}

const GUID IID_IXpsOMRemoteDictionaryResource = {0xC9BD7CD4, 0xE16A, 0x4BF8, [0x8C, 0x84, 0xC9, 0x50, 0xAF, 0x7A, 0x30, 0x61]};
@GUID(0xC9BD7CD4, 0xE16A, 0x4BF8, [0x8C, 0x84, 0xC9, 0x50, 0xAF, 0x7A, 0x30, 0x61]);
interface IXpsOMRemoteDictionaryResource : IXpsOMResource
{
    HRESULT GetDictionary(IXpsOMDictionary* dictionary);
    HRESULT SetDictionary(IXpsOMDictionary dictionary);
}

const GUID IID_IXpsOMRemoteDictionaryResourceCollection = {0x5C38DB61, 0x7FEC, 0x464A, [0x87, 0xBD, 0x41, 0xE3, 0xBE, 0xF0, 0x18, 0xBE]};
@GUID(0x5C38DB61, 0x7FEC, 0x464A, [0x87, 0xBD, 0x41, 0xE3, 0xBE, 0xF0, 0x18, 0xBE]);
interface IXpsOMRemoteDictionaryResourceCollection : IUnknown
{
    HRESULT GetCount(uint* count);
    HRESULT GetAt(uint index, IXpsOMRemoteDictionaryResource* object);
    HRESULT InsertAt(uint index, IXpsOMRemoteDictionaryResource object);
    HRESULT RemoveAt(uint index);
    HRESULT SetAt(uint index, IXpsOMRemoteDictionaryResource object);
    HRESULT Append(IXpsOMRemoteDictionaryResource object);
    HRESULT GetByPartName(IOpcPartUri partName, IXpsOMRemoteDictionaryResource* remoteDictionaryResource);
}

const GUID IID_IXpsOMSignatureBlockResourceCollection = {0xAB8F5D8E, 0x351B, 0x4D33, [0xAA, 0xED, 0xFA, 0x56, 0xF0, 0x02, 0x29, 0x31]};
@GUID(0xAB8F5D8E, 0x351B, 0x4D33, [0xAA, 0xED, 0xFA, 0x56, 0xF0, 0x02, 0x29, 0x31]);
interface IXpsOMSignatureBlockResourceCollection : IUnknown
{
    HRESULT GetCount(uint* count);
    HRESULT GetAt(uint index, IXpsOMSignatureBlockResource* signatureBlockResource);
    HRESULT InsertAt(uint index, IXpsOMSignatureBlockResource signatureBlockResource);
    HRESULT RemoveAt(uint index);
    HRESULT SetAt(uint index, IXpsOMSignatureBlockResource signatureBlockResource);
    HRESULT Append(IXpsOMSignatureBlockResource signatureBlockResource);
    HRESULT GetByPartName(IOpcPartUri partName, IXpsOMSignatureBlockResource* signatureBlockResource);
}

const GUID IID_IXpsOMDocumentStructureResource = {0x85FEBC8A, 0x6B63, 0x48A9, [0xAF, 0x07, 0x70, 0x64, 0xE4, 0xEC, 0xFF, 0x30]};
@GUID(0x85FEBC8A, 0x6B63, 0x48A9, [0xAF, 0x07, 0x70, 0x64, 0xE4, 0xEC, 0xFF, 0x30]);
interface IXpsOMDocumentStructureResource : IXpsOMResource
{
    HRESULT GetOwner(IXpsOMDocument* owner);
    HRESULT GetStream(IStream* stream);
    HRESULT SetContent(IStream sourceStream, IOpcPartUri partName);
}

const GUID IID_IXpsOMStoryFragmentsResource = {0xC2B3CA09, 0x0473, 0x4282, [0x87, 0xAE, 0x17, 0x80, 0x86, 0x32, 0x23, 0xF0]};
@GUID(0xC2B3CA09, 0x0473, 0x4282, [0x87, 0xAE, 0x17, 0x80, 0x86, 0x32, 0x23, 0xF0]);
interface IXpsOMStoryFragmentsResource : IXpsOMResource
{
    HRESULT GetOwner(IXpsOMPageReference* owner);
    HRESULT GetStream(IStream* stream);
    HRESULT SetContent(IStream sourceStream, IOpcPartUri partName);
}

const GUID IID_IXpsOMSignatureBlockResource = {0x4776AD35, 0x2E04, 0x4357, [0x87, 0x43, 0xEB, 0xF6, 0xC1, 0x71, 0xA9, 0x05]};
@GUID(0x4776AD35, 0x2E04, 0x4357, [0x87, 0x43, 0xEB, 0xF6, 0xC1, 0x71, 0xA9, 0x05]);
interface IXpsOMSignatureBlockResource : IXpsOMResource
{
    HRESULT GetOwner(IXpsOMDocument* owner);
    HRESULT GetStream(IStream* stream);
    HRESULT SetContent(IStream sourceStream, IOpcPartUri partName);
}

const GUID IID_IXpsOMVisualCollection = {0x94D8ABDE, 0xAB91, 0x46A8, [0x82, 0xB7, 0xF5, 0xB0, 0x5E, 0xF0, 0x1A, 0x96]};
@GUID(0x94D8ABDE, 0xAB91, 0x46A8, [0x82, 0xB7, 0xF5, 0xB0, 0x5E, 0xF0, 0x1A, 0x96]);
interface IXpsOMVisualCollection : IUnknown
{
    HRESULT GetCount(uint* count);
    HRESULT GetAt(uint index, IXpsOMVisual* object);
    HRESULT InsertAt(uint index, IXpsOMVisual object);
    HRESULT RemoveAt(uint index);
    HRESULT SetAt(uint index, IXpsOMVisual object);
    HRESULT Append(IXpsOMVisual object);
}

const GUID IID_IXpsOMCanvas = {0x221D1452, 0x331E, 0x47C6, [0x87, 0xE9, 0x6C, 0xCE, 0xFB, 0x9B, 0x5B, 0xA3]};
@GUID(0x221D1452, 0x331E, 0x47C6, [0x87, 0xE9, 0x6C, 0xCE, 0xFB, 0x9B, 0x5B, 0xA3]);
interface IXpsOMCanvas : IXpsOMVisual
{
    HRESULT GetVisuals(IXpsOMVisualCollection* visuals);
    HRESULT GetUseAliasedEdgeMode(int* useAliasedEdgeMode);
    HRESULT SetUseAliasedEdgeMode(BOOL useAliasedEdgeMode);
    HRESULT GetAccessibilityShortDescription(ushort** shortDescription);
    HRESULT SetAccessibilityShortDescription(const(wchar)* shortDescription);
    HRESULT GetAccessibilityLongDescription(ushort** longDescription);
    HRESULT SetAccessibilityLongDescription(const(wchar)* longDescription);
    HRESULT GetDictionary(IXpsOMDictionary* resourceDictionary);
    HRESULT GetDictionaryLocal(IXpsOMDictionary* resourceDictionary);
    HRESULT SetDictionaryLocal(IXpsOMDictionary resourceDictionary);
    HRESULT GetDictionaryResource(IXpsOMRemoteDictionaryResource* remoteDictionaryResource);
    HRESULT SetDictionaryResource(IXpsOMRemoteDictionaryResource remoteDictionaryResource);
    HRESULT Clone(IXpsOMCanvas* canvas);
}

const GUID IID_IXpsOMPage = {0xD3E18888, 0xF120, 0x4FEE, [0x8C, 0x68, 0x35, 0x29, 0x6E, 0xAE, 0x91, 0xD4]};
@GUID(0xD3E18888, 0xF120, 0x4FEE, [0x8C, 0x68, 0x35, 0x29, 0x6E, 0xAE, 0x91, 0xD4]);
interface IXpsOMPage : IXpsOMPart
{
    HRESULT GetOwner(IXpsOMPageReference* pageReference);
    HRESULT GetVisuals(IXpsOMVisualCollection* visuals);
    HRESULT GetPageDimensions(XPS_SIZE* pageDimensions);
    HRESULT SetPageDimensions(const(XPS_SIZE)* pageDimensions);
    HRESULT GetContentBox(XPS_RECT* contentBox);
    HRESULT SetContentBox(const(XPS_RECT)* contentBox);
    HRESULT GetBleedBox(XPS_RECT* bleedBox);
    HRESULT SetBleedBox(const(XPS_RECT)* bleedBox);
    HRESULT GetLanguage(ushort** language);
    HRESULT SetLanguage(const(wchar)* language);
    HRESULT GetName(ushort** name);
    HRESULT SetName(const(wchar)* name);
    HRESULT GetIsHyperlinkTarget(int* isHyperlinkTarget);
    HRESULT SetIsHyperlinkTarget(BOOL isHyperlinkTarget);
    HRESULT GetDictionary(IXpsOMDictionary* resourceDictionary);
    HRESULT GetDictionaryLocal(IXpsOMDictionary* resourceDictionary);
    HRESULT SetDictionaryLocal(IXpsOMDictionary resourceDictionary);
    HRESULT GetDictionaryResource(IXpsOMRemoteDictionaryResource* remoteDictionaryResource);
    HRESULT SetDictionaryResource(IXpsOMRemoteDictionaryResource remoteDictionaryResource);
    HRESULT Write(ISequentialStream stream, BOOL optimizeMarkupSize);
    HRESULT GenerateUnusedLookupKey(XPS_OBJECT_TYPE type, ushort** key);
    HRESULT Clone(IXpsOMPage* page);
}

const GUID IID_IXpsOMPageReference = {0xED360180, 0x6F92, 0x4998, [0x89, 0x0D, 0x2F, 0x20, 0x85, 0x31, 0xA0, 0xA0]};
@GUID(0xED360180, 0x6F92, 0x4998, [0x89, 0x0D, 0x2F, 0x20, 0x85, 0x31, 0xA0, 0xA0]);
interface IXpsOMPageReference : IUnknown
{
    HRESULT GetOwner(IXpsOMDocument* document);
    HRESULT GetPage(IXpsOMPage* page);
    HRESULT SetPage(IXpsOMPage page);
    HRESULT DiscardPage();
    HRESULT IsPageLoaded(int* isPageLoaded);
    HRESULT GetAdvisoryPageDimensions(XPS_SIZE* pageDimensions);
    HRESULT SetAdvisoryPageDimensions(const(XPS_SIZE)* pageDimensions);
    HRESULT GetStoryFragmentsResource(IXpsOMStoryFragmentsResource* storyFragmentsResource);
    HRESULT SetStoryFragmentsResource(IXpsOMStoryFragmentsResource storyFragmentsResource);
    HRESULT GetPrintTicketResource(IXpsOMPrintTicketResource* printTicketResource);
    HRESULT SetPrintTicketResource(IXpsOMPrintTicketResource printTicketResource);
    HRESULT GetThumbnailResource(IXpsOMImageResource* imageResource);
    HRESULT SetThumbnailResource(IXpsOMImageResource imageResource);
    HRESULT CollectLinkTargets(IXpsOMNameCollection* linkTargets);
    HRESULT CollectPartResources(IXpsOMPartResources* partResources);
    HRESULT HasRestrictedFonts(int* restrictedFonts);
    HRESULT Clone(IXpsOMPageReference* pageReference);
}

const GUID IID_IXpsOMPageReferenceCollection = {0xCA16BA4D, 0xE7B9, 0x45C5, [0x95, 0x8B, 0xF9, 0x80, 0x22, 0x47, 0x37, 0x45]};
@GUID(0xCA16BA4D, 0xE7B9, 0x45C5, [0x95, 0x8B, 0xF9, 0x80, 0x22, 0x47, 0x37, 0x45]);
interface IXpsOMPageReferenceCollection : IUnknown
{
    HRESULT GetCount(uint* count);
    HRESULT GetAt(uint index, IXpsOMPageReference* pageReference);
    HRESULT InsertAt(uint index, IXpsOMPageReference pageReference);
    HRESULT RemoveAt(uint index);
    HRESULT SetAt(uint index, IXpsOMPageReference pageReference);
    HRESULT Append(IXpsOMPageReference pageReference);
}

const GUID IID_IXpsOMDocument = {0x2C2C94CB, 0xAC5F, 0x4254, [0x8E, 0xE9, 0x23, 0x94, 0x83, 0x09, 0xD9, 0xF0]};
@GUID(0x2C2C94CB, 0xAC5F, 0x4254, [0x8E, 0xE9, 0x23, 0x94, 0x83, 0x09, 0xD9, 0xF0]);
interface IXpsOMDocument : IXpsOMPart
{
    HRESULT GetOwner(IXpsOMDocumentSequence* documentSequence);
    HRESULT GetPageReferences(IXpsOMPageReferenceCollection* pageReferences);
    HRESULT GetPrintTicketResource(IXpsOMPrintTicketResource* printTicketResource);
    HRESULT SetPrintTicketResource(IXpsOMPrintTicketResource printTicketResource);
    HRESULT GetDocumentStructureResource(IXpsOMDocumentStructureResource* documentStructureResource);
    HRESULT SetDocumentStructureResource(IXpsOMDocumentStructureResource documentStructureResource);
    HRESULT GetSignatureBlockResources(IXpsOMSignatureBlockResourceCollection* signatureBlockResources);
    HRESULT Clone(IXpsOMDocument* document);
}

const GUID IID_IXpsOMDocumentCollection = {0xD1C87F0D, 0xE947, 0x4754, [0x8A, 0x25, 0x97, 0x14, 0x78, 0xF7, 0xE8, 0x3E]};
@GUID(0xD1C87F0D, 0xE947, 0x4754, [0x8A, 0x25, 0x97, 0x14, 0x78, 0xF7, 0xE8, 0x3E]);
interface IXpsOMDocumentCollection : IUnknown
{
    HRESULT GetCount(uint* count);
    HRESULT GetAt(uint index, IXpsOMDocument* document);
    HRESULT InsertAt(uint index, IXpsOMDocument document);
    HRESULT RemoveAt(uint index);
    HRESULT SetAt(uint index, IXpsOMDocument document);
    HRESULT Append(IXpsOMDocument document);
}

const GUID IID_IXpsOMDocumentSequence = {0x56492EB4, 0xD8D5, 0x425E, [0x82, 0x56, 0x4C, 0x2B, 0x64, 0xAD, 0x02, 0x64]};
@GUID(0x56492EB4, 0xD8D5, 0x425E, [0x82, 0x56, 0x4C, 0x2B, 0x64, 0xAD, 0x02, 0x64]);
interface IXpsOMDocumentSequence : IXpsOMPart
{
    HRESULT GetOwner(IXpsOMPackage* package);
    HRESULT GetDocuments(IXpsOMDocumentCollection* documents);
    HRESULT GetPrintTicketResource(IXpsOMPrintTicketResource* printTicketResource);
    HRESULT SetPrintTicketResource(IXpsOMPrintTicketResource printTicketResource);
}

const GUID IID_IXpsOMCoreProperties = {0x3340FE8F, 0x4027, 0x4AA1, [0x8F, 0x5F, 0xD3, 0x5A, 0xE4, 0x5F, 0xE5, 0x97]};
@GUID(0x3340FE8F, 0x4027, 0x4AA1, [0x8F, 0x5F, 0xD3, 0x5A, 0xE4, 0x5F, 0xE5, 0x97]);
interface IXpsOMCoreProperties : IXpsOMPart
{
    HRESULT GetOwner(IXpsOMPackage* package);
    HRESULT GetCategory(ushort** category);
    HRESULT SetCategory(const(wchar)* category);
    HRESULT GetContentStatus(ushort** contentStatus);
    HRESULT SetContentStatus(const(wchar)* contentStatus);
    HRESULT GetContentType(ushort** contentType);
    HRESULT SetContentType(const(wchar)* contentType);
    HRESULT GetCreated(SYSTEMTIME* created);
    HRESULT SetCreated(const(SYSTEMTIME)* created);
    HRESULT GetCreator(ushort** creator);
    HRESULT SetCreator(const(wchar)* creator);
    HRESULT GetDescription(ushort** description);
    HRESULT SetDescription(const(wchar)* description);
    HRESULT GetIdentifier(ushort** identifier);
    HRESULT SetIdentifier(const(wchar)* identifier);
    HRESULT GetKeywords(ushort** keywords);
    HRESULT SetKeywords(const(wchar)* keywords);
    HRESULT GetLanguage(ushort** language);
    HRESULT SetLanguage(const(wchar)* language);
    HRESULT GetLastModifiedBy(ushort** lastModifiedBy);
    HRESULT SetLastModifiedBy(const(wchar)* lastModifiedBy);
    HRESULT GetLastPrinted(SYSTEMTIME* lastPrinted);
    HRESULT SetLastPrinted(const(SYSTEMTIME)* lastPrinted);
    HRESULT GetModified(SYSTEMTIME* modified);
    HRESULT SetModified(const(SYSTEMTIME)* modified);
    HRESULT GetRevision(ushort** revision);
    HRESULT SetRevision(const(wchar)* revision);
    HRESULT GetSubject(ushort** subject);
    HRESULT SetSubject(const(wchar)* subject);
    HRESULT GetTitle(ushort** title);
    HRESULT SetTitle(const(wchar)* title);
    HRESULT GetVersion(ushort** version);
    HRESULT SetVersion(const(wchar)* version);
    HRESULT Clone(IXpsOMCoreProperties* coreProperties);
}

const GUID IID_IXpsOMPackage = {0x18C3DF65, 0x81E1, 0x4674, [0x91, 0xDC, 0xFC, 0x45, 0x2F, 0x5A, 0x41, 0x6F]};
@GUID(0x18C3DF65, 0x81E1, 0x4674, [0x91, 0xDC, 0xFC, 0x45, 0x2F, 0x5A, 0x41, 0x6F]);
interface IXpsOMPackage : IUnknown
{
    HRESULT GetDocumentSequence(IXpsOMDocumentSequence* documentSequence);
    HRESULT SetDocumentSequence(IXpsOMDocumentSequence documentSequence);
    HRESULT GetCoreProperties(IXpsOMCoreProperties* coreProperties);
    HRESULT SetCoreProperties(IXpsOMCoreProperties coreProperties);
    HRESULT GetDiscardControlPartName(IOpcPartUri* discardControlPartUri);
    HRESULT SetDiscardControlPartName(IOpcPartUri discardControlPartUri);
    HRESULT GetThumbnailResource(IXpsOMImageResource* imageResource);
    HRESULT SetThumbnailResource(IXpsOMImageResource imageResource);
    HRESULT WriteToFile(const(wchar)* fileName, SECURITY_ATTRIBUTES* securityAttributes, uint flagsAndAttributes, BOOL optimizeMarkupSize);
    HRESULT WriteToStream(ISequentialStream stream, BOOL optimizeMarkupSize);
}

const GUID IID_IXpsOMObjectFactory = {0xF9B2A685, 0xA50D, 0x4FC2, [0xB7, 0x64, 0xB5, 0x6E, 0x09, 0x3E, 0xA0, 0xCA]};
@GUID(0xF9B2A685, 0xA50D, 0x4FC2, [0xB7, 0x64, 0xB5, 0x6E, 0x09, 0x3E, 0xA0, 0xCA]);
interface IXpsOMObjectFactory : IUnknown
{
    HRESULT CreatePackage(IXpsOMPackage* package);
    HRESULT CreatePackageFromFile(const(wchar)* filename, BOOL reuseObjects, IXpsOMPackage* package);
    HRESULT CreatePackageFromStream(IStream stream, BOOL reuseObjects, IXpsOMPackage* package);
    HRESULT CreateStoryFragmentsResource(IStream acquiredStream, IOpcPartUri partUri, IXpsOMStoryFragmentsResource* storyFragmentsResource);
    HRESULT CreateDocumentStructureResource(IStream acquiredStream, IOpcPartUri partUri, IXpsOMDocumentStructureResource* documentStructureResource);
    HRESULT CreateSignatureBlockResource(IStream acquiredStream, IOpcPartUri partUri, IXpsOMSignatureBlockResource* signatureBlockResource);
    HRESULT CreateRemoteDictionaryResource(IXpsOMDictionary dictionary, IOpcPartUri partUri, IXpsOMRemoteDictionaryResource* remoteDictionaryResource);
    HRESULT CreateRemoteDictionaryResourceFromStream(IStream dictionaryMarkupStream, IOpcPartUri dictionaryPartUri, IXpsOMPartResources resources, IXpsOMRemoteDictionaryResource* dictionaryResource);
    HRESULT CreatePartResources(IXpsOMPartResources* partResources);
    HRESULT CreateDocumentSequence(IOpcPartUri partUri, IXpsOMDocumentSequence* documentSequence);
    HRESULT CreateDocument(IOpcPartUri partUri, IXpsOMDocument* document);
    HRESULT CreatePageReference(const(XPS_SIZE)* advisoryPageDimensions, IXpsOMPageReference* pageReference);
    HRESULT CreatePage(const(XPS_SIZE)* pageDimensions, const(wchar)* language, IOpcPartUri partUri, IXpsOMPage* page);
    HRESULT CreatePageFromStream(IStream pageMarkupStream, IOpcPartUri partUri, IXpsOMPartResources resources, BOOL reuseObjects, IXpsOMPage* page);
    HRESULT CreateCanvas(IXpsOMCanvas* canvas);
    HRESULT CreateGlyphs(IXpsOMFontResource fontResource, IXpsOMGlyphs* glyphs);
    HRESULT CreatePath(IXpsOMPath* path);
    HRESULT CreateGeometry(IXpsOMGeometry* geometry);
    HRESULT CreateGeometryFigure(const(XPS_POINT)* startPoint, IXpsOMGeometryFigure* figure);
    HRESULT CreateMatrixTransform(const(XPS_MATRIX)* matrix, IXpsOMMatrixTransform* transform);
    HRESULT CreateSolidColorBrush(const(XPS_COLOR)* color, IXpsOMColorProfileResource colorProfile, IXpsOMSolidColorBrush* solidColorBrush);
    HRESULT CreateColorProfileResource(IStream acquiredStream, IOpcPartUri partUri, IXpsOMColorProfileResource* colorProfileResource);
    HRESULT CreateImageBrush(IXpsOMImageResource image, const(XPS_RECT)* viewBox, const(XPS_RECT)* viewPort, IXpsOMImageBrush* imageBrush);
    HRESULT CreateVisualBrush(const(XPS_RECT)* viewBox, const(XPS_RECT)* viewPort, IXpsOMVisualBrush* visualBrush);
    HRESULT CreateImageResource(IStream acquiredStream, XPS_IMAGE_TYPE contentType, IOpcPartUri partUri, IXpsOMImageResource* imageResource);
    HRESULT CreatePrintTicketResource(IStream acquiredStream, IOpcPartUri partUri, IXpsOMPrintTicketResource* printTicketResource);
    HRESULT CreateFontResource(IStream acquiredStream, XPS_FONT_EMBEDDING fontEmbedding, IOpcPartUri partUri, BOOL isObfSourceStream, IXpsOMFontResource* fontResource);
    HRESULT CreateGradientStop(const(XPS_COLOR)* color, IXpsOMColorProfileResource colorProfile, float offset, IXpsOMGradientStop* gradientStop);
    HRESULT CreateLinearGradientBrush(IXpsOMGradientStop gradStop1, IXpsOMGradientStop gradStop2, const(XPS_POINT)* startPoint, const(XPS_POINT)* endPoint, IXpsOMLinearGradientBrush* linearGradientBrush);
    HRESULT CreateRadialGradientBrush(IXpsOMGradientStop gradStop1, IXpsOMGradientStop gradStop2, const(XPS_POINT)* centerPoint, const(XPS_POINT)* gradientOrigin, const(XPS_SIZE)* radiiSizes, IXpsOMRadialGradientBrush* radialGradientBrush);
    HRESULT CreateCoreProperties(IOpcPartUri partUri, IXpsOMCoreProperties* coreProperties);
    HRESULT CreateDictionary(IXpsOMDictionary* dictionary);
    HRESULT CreatePartUriCollection(IXpsOMPartUriCollection* partUriCollection);
    HRESULT CreatePackageWriterOnFile(const(wchar)* fileName, SECURITY_ATTRIBUTES* securityAttributes, uint flagsAndAttributes, BOOL optimizeMarkupSize, XPS_INTERLEAVING interleaving, IOpcPartUri documentSequencePartName, IXpsOMCoreProperties coreProperties, IXpsOMImageResource packageThumbnail, IXpsOMPrintTicketResource documentSequencePrintTicket, IOpcPartUri discardControlPartName, IXpsOMPackageWriter* packageWriter);
    HRESULT CreatePackageWriterOnStream(ISequentialStream outputStream, BOOL optimizeMarkupSize, XPS_INTERLEAVING interleaving, IOpcPartUri documentSequencePartName, IXpsOMCoreProperties coreProperties, IXpsOMImageResource packageThumbnail, IXpsOMPrintTicketResource documentSequencePrintTicket, IOpcPartUri discardControlPartName, IXpsOMPackageWriter* packageWriter);
    HRESULT CreatePartUri(const(wchar)* uri, IOpcPartUri* partUri);
    HRESULT CreateReadOnlyStreamOnFile(const(wchar)* filename, IStream* stream);
}

const GUID IID_IXpsOMNameCollection = {0x4BDDF8EC, 0xC915, 0x421B, [0xA1, 0x66, 0xD1, 0x73, 0xD2, 0x56, 0x53, 0xD2]};
@GUID(0x4BDDF8EC, 0xC915, 0x421B, [0xA1, 0x66, 0xD1, 0x73, 0xD2, 0x56, 0x53, 0xD2]);
interface IXpsOMNameCollection : IUnknown
{
    HRESULT GetCount(uint* count);
    HRESULT GetAt(uint index, ushort** name);
}

const GUID IID_IXpsOMPartUriCollection = {0x57C650D4, 0x067C, 0x4893, [0x8C, 0x33, 0xF6, 0x2A, 0x06, 0x33, 0x73, 0x0F]};
@GUID(0x57C650D4, 0x067C, 0x4893, [0x8C, 0x33, 0xF6, 0x2A, 0x06, 0x33, 0x73, 0x0F]);
interface IXpsOMPartUriCollection : IUnknown
{
    HRESULT GetCount(uint* count);
    HRESULT GetAt(uint index, IOpcPartUri* partUri);
    HRESULT InsertAt(uint index, IOpcPartUri partUri);
    HRESULT RemoveAt(uint index);
    HRESULT SetAt(uint index, IOpcPartUri partUri);
    HRESULT Append(IOpcPartUri partUri);
}

const GUID IID_IXpsOMPackageWriter = {0x4E2AA182, 0xA443, 0x42C6, [0xB4, 0x1B, 0x4F, 0x8E, 0x9D, 0xE7, 0x3F, 0xF9]};
@GUID(0x4E2AA182, 0xA443, 0x42C6, [0xB4, 0x1B, 0x4F, 0x8E, 0x9D, 0xE7, 0x3F, 0xF9]);
interface IXpsOMPackageWriter : IUnknown
{
    HRESULT StartNewDocument(IOpcPartUri documentPartName, IXpsOMPrintTicketResource documentPrintTicket, IXpsOMDocumentStructureResource documentStructure, IXpsOMSignatureBlockResourceCollection signatureBlockResources, IXpsOMPartUriCollection restrictedFonts);
    HRESULT AddPage(IXpsOMPage page, const(XPS_SIZE)* advisoryPageDimensions, IXpsOMPartUriCollection discardableResourceParts, IXpsOMStoryFragmentsResource storyFragments, IXpsOMPrintTicketResource pagePrintTicket, IXpsOMImageResource pageThumbnail);
    HRESULT AddResource(IXpsOMResource resource);
    HRESULT Close();
    HRESULT IsClosed(int* isClosed);
}

const GUID IID_IXpsOMPackageTarget = {0x219A9DB0, 0x4959, 0x47D0, [0x80, 0x34, 0xB1, 0xCE, 0x84, 0xF4, 0x1A, 0x4D]};
@GUID(0x219A9DB0, 0x4959, 0x47D0, [0x80, 0x34, 0xB1, 0xCE, 0x84, 0xF4, 0x1A, 0x4D]);
interface IXpsOMPackageTarget : IUnknown
{
    HRESULT CreateXpsOMPackageWriter(IOpcPartUri documentSequencePartName, IXpsOMPrintTicketResource documentSequencePrintTicket, IOpcPartUri discardControlPartName, IXpsOMPackageWriter* packageWriter);
}

const GUID IID_IXpsOMThumbnailGenerator = {0x15B873D5, 0x1971, 0x41E8, [0x83, 0xA3, 0x65, 0x78, 0x40, 0x30, 0x64, 0xC7]};
@GUID(0x15B873D5, 0x1971, 0x41E8, [0x83, 0xA3, 0x65, 0x78, 0x40, 0x30, 0x64, 0xC7]);
interface IXpsOMThumbnailGenerator : IUnknown
{
    HRESULT GenerateThumbnail(IXpsOMPage page, XPS_IMAGE_TYPE thumbnailType, XPS_THUMBNAIL_SIZE thumbnailSize, IOpcPartUri imageResourcePartName, IXpsOMImageResource* imageResource);
}

enum XPS_DOCUMENT_TYPE
{
    XPS_DOCUMENT_TYPE_UNSPECIFIED = 1,
    XPS_DOCUMENT_TYPE_XPS = 2,
    XPS_DOCUMENT_TYPE_OPENXPS = 3,
}

const GUID IID_IXpsOMObjectFactory1 = {0x0A91B617, 0xD612, 0x4181, [0xBF, 0x7C, 0xBE, 0x58, 0x24, 0xE9, 0xCC, 0x8F]};
@GUID(0x0A91B617, 0xD612, 0x4181, [0xBF, 0x7C, 0xBE, 0x58, 0x24, 0xE9, 0xCC, 0x8F]);
interface IXpsOMObjectFactory1 : IXpsOMObjectFactory
{
    HRESULT GetDocumentTypeFromFile(const(wchar)* filename, XPS_DOCUMENT_TYPE* documentType);
    HRESULT GetDocumentTypeFromStream(IStream xpsDocumentStream, XPS_DOCUMENT_TYPE* documentType);
    HRESULT ConvertHDPhotoToJpegXR(IXpsOMImageResource imageResource);
    HRESULT ConvertJpegXRToHDPhoto(IXpsOMImageResource imageResource);
    HRESULT CreatePackageWriterOnFile1(const(wchar)* fileName, SECURITY_ATTRIBUTES* securityAttributes, uint flagsAndAttributes, BOOL optimizeMarkupSize, XPS_INTERLEAVING interleaving, IOpcPartUri documentSequencePartName, IXpsOMCoreProperties coreProperties, IXpsOMImageResource packageThumbnail, IXpsOMPrintTicketResource documentSequencePrintTicket, IOpcPartUri discardControlPartName, XPS_DOCUMENT_TYPE documentType, IXpsOMPackageWriter* packageWriter);
    HRESULT CreatePackageWriterOnStream1(ISequentialStream outputStream, BOOL optimizeMarkupSize, XPS_INTERLEAVING interleaving, IOpcPartUri documentSequencePartName, IXpsOMCoreProperties coreProperties, IXpsOMImageResource packageThumbnail, IXpsOMPrintTicketResource documentSequencePrintTicket, IOpcPartUri discardControlPartName, XPS_DOCUMENT_TYPE documentType, IXpsOMPackageWriter* packageWriter);
    HRESULT CreatePackage1(IXpsOMPackage1* package);
    HRESULT CreatePackageFromStream1(IStream stream, BOOL reuseObjects, IXpsOMPackage1* package);
    HRESULT CreatePackageFromFile1(const(wchar)* filename, BOOL reuseObjects, IXpsOMPackage1* package);
    HRESULT CreatePage1(const(XPS_SIZE)* pageDimensions, const(wchar)* language, IOpcPartUri partUri, IXpsOMPage1* page);
    HRESULT CreatePageFromStream1(IStream pageMarkupStream, IOpcPartUri partUri, IXpsOMPartResources resources, BOOL reuseObjects, IXpsOMPage1* page);
    HRESULT CreateRemoteDictionaryResourceFromStream1(IStream dictionaryMarkupStream, IOpcPartUri partUri, IXpsOMPartResources resources, IXpsOMRemoteDictionaryResource* dictionaryResource);
}

const GUID IID_IXpsOMPackage1 = {0x95A9435E, 0x12BB, 0x461B, [0x8E, 0x7F, 0xC6, 0xAD, 0xB0, 0x4C, 0xD9, 0x6A]};
@GUID(0x95A9435E, 0x12BB, 0x461B, [0x8E, 0x7F, 0xC6, 0xAD, 0xB0, 0x4C, 0xD9, 0x6A]);
interface IXpsOMPackage1 : IXpsOMPackage
{
    HRESULT GetDocumentType(XPS_DOCUMENT_TYPE* documentType);
    HRESULT WriteToFile1(const(wchar)* fileName, SECURITY_ATTRIBUTES* securityAttributes, uint flagsAndAttributes, BOOL optimizeMarkupSize, XPS_DOCUMENT_TYPE documentType);
    HRESULT WriteToStream1(ISequentialStream outputStream, BOOL optimizeMarkupSize, XPS_DOCUMENT_TYPE documentType);
}

const GUID IID_IXpsOMPage1 = {0x305B60EF, 0x6892, 0x4DDA, [0x9C, 0xBB, 0x3A, 0xA6, 0x59, 0x74, 0x50, 0x8A]};
@GUID(0x305B60EF, 0x6892, 0x4DDA, [0x9C, 0xBB, 0x3A, 0xA6, 0x59, 0x74, 0x50, 0x8A]);
interface IXpsOMPage1 : IXpsOMPage
{
    HRESULT GetDocumentType(XPS_DOCUMENT_TYPE* documentType);
    HRESULT Write1(ISequentialStream stream, BOOL optimizeMarkupSize, XPS_DOCUMENT_TYPE documentType);
}

const GUID IID_IXpsDocumentPackageTarget = {0x3B0B6D38, 0x53AD, 0x41DA, [0xB2, 0x12, 0xD3, 0x76, 0x37, 0xA6, 0x71, 0x4E]};
@GUID(0x3B0B6D38, 0x53AD, 0x41DA, [0xB2, 0x12, 0xD3, 0x76, 0x37, 0xA6, 0x71, 0x4E]);
interface IXpsDocumentPackageTarget : IUnknown
{
    HRESULT GetXpsOMPackageWriter(IOpcPartUri documentSequencePartName, IOpcPartUri discardControlPartName, IXpsOMPackageWriter* packageWriter);
    HRESULT GetXpsOMFactory(IXpsOMObjectFactory* xpsFactory);
    HRESULT GetXpsType(XPS_DOCUMENT_TYPE* documentType);
}

const GUID IID_IXpsOMRemoteDictionaryResource1 = {0xBF8FC1D4, 0x9D46, 0x4141, [0xBA, 0x5F, 0x94, 0xBB, 0x92, 0x50, 0xD0, 0x41]};
@GUID(0xBF8FC1D4, 0x9D46, 0x4141, [0xBA, 0x5F, 0x94, 0xBB, 0x92, 0x50, 0xD0, 0x41]);
interface IXpsOMRemoteDictionaryResource1 : IXpsOMRemoteDictionaryResource
{
    HRESULT GetDocumentType(XPS_DOCUMENT_TYPE* documentType);
    HRESULT Write1(ISequentialStream stream, XPS_DOCUMENT_TYPE documentType);
}

const GUID IID_IXpsOMPackageWriter3D = {0xE8A45033, 0x640E, 0x43FA, [0x9B, 0xDF, 0xFD, 0xDE, 0xAA, 0x31, 0xC6, 0xA0]};
@GUID(0xE8A45033, 0x640E, 0x43FA, [0x9B, 0xDF, 0xFD, 0xDE, 0xAA, 0x31, 0xC6, 0xA0]);
interface IXpsOMPackageWriter3D : IXpsOMPackageWriter
{
    HRESULT AddModelTexture(IOpcPartUri texturePartName, IStream textureData);
    HRESULT SetModelPrintTicket(IOpcPartUri printTicketPartName, IStream printTicketData);
}

const GUID IID_IXpsDocumentPackageTarget3D = {0x60BA71B8, 0x3101, 0x4984, [0x91, 0x99, 0xF4, 0xEA, 0x77, 0x5F, 0xF0, 0x1D]};
@GUID(0x60BA71B8, 0x3101, 0x4984, [0x91, 0x99, 0xF4, 0xEA, 0x77, 0x5F, 0xF0, 0x1D]);
interface IXpsDocumentPackageTarget3D : IUnknown
{
    HRESULT GetXpsOMPackageWriter3D(IOpcPartUri documentSequencePartName, IOpcPartUri discardControlPartName, IOpcPartUri modelPartName, IStream modelData, IXpsOMPackageWriter3D* packageWriter);
    HRESULT GetXpsOMFactory(IXpsOMObjectFactory* xpsFactory);
}

const GUID CLSID_XpsSignatureManager = {0xB0C43320, 0x2315, 0x44A2, [0xB7, 0x0A, 0x09, 0x43, 0xA1, 0x40, 0xA8, 0xEE]};
@GUID(0xB0C43320, 0x2315, 0x44A2, [0xB7, 0x0A, 0x09, 0x43, 0xA1, 0x40, 0xA8, 0xEE]);
struct XpsSignatureManager;

enum XPS_SIGNATURE_STATUS
{
    XPS_SIGNATURE_STATUS_INCOMPLIANT = 1,
    XPS_SIGNATURE_STATUS_INCOMPLETE = 2,
    XPS_SIGNATURE_STATUS_BROKEN = 3,
    XPS_SIGNATURE_STATUS_QUESTIONABLE = 4,
    XPS_SIGNATURE_STATUS_VALID = 5,
}

enum XPS_SIGN_POLICY
{
    XPS_SIGN_POLICY_NONE = 0,
    XPS_SIGN_POLICY_CORE_PROPERTIES = 1,
    XPS_SIGN_POLICY_SIGNATURE_RELATIONSHIPS = 2,
    XPS_SIGN_POLICY_PRINT_TICKET = 4,
    XPS_SIGN_POLICY_DISCARD_CONTROL = 8,
    XPS_SIGN_POLICY_ALL = 15,
}

enum XPS_SIGN_FLAGS
{
    XPS_SIGN_FLAGS_NONE = 0,
    XPS_SIGN_FLAGS_IGNORE_MARKUP_COMPATIBILITY = 1,
}

const GUID IID_IXpsSigningOptions = {0x7718EAE4, 0x3215, 0x49BE, [0xAF, 0x5B, 0x59, 0x4F, 0xEF, 0x7F, 0xCF, 0xA6]};
@GUID(0x7718EAE4, 0x3215, 0x49BE, [0xAF, 0x5B, 0x59, 0x4F, 0xEF, 0x7F, 0xCF, 0xA6]);
interface IXpsSigningOptions : IUnknown
{
    HRESULT GetSignatureId(ushort** signatureId);
    HRESULT SetSignatureId(const(wchar)* signatureId);
    HRESULT GetSignatureMethod(ushort** signatureMethod);
    HRESULT SetSignatureMethod(const(wchar)* signatureMethod);
    HRESULT GetDigestMethod(ushort** digestMethod);
    HRESULT SetDigestMethod(const(wchar)* digestMethod);
    HRESULT GetSignaturePartName(IOpcPartUri* signaturePartName);
    HRESULT SetSignaturePartName(IOpcPartUri signaturePartName);
    HRESULT GetPolicy(XPS_SIGN_POLICY* policy);
    HRESULT SetPolicy(XPS_SIGN_POLICY policy);
    HRESULT GetSigningTimeFormat(OPC_SIGNATURE_TIME_FORMAT* timeFormat);
    HRESULT SetSigningTimeFormat(OPC_SIGNATURE_TIME_FORMAT timeFormat);
    HRESULT GetCustomObjects(IOpcSignatureCustomObjectSet* customObjectSet);
    HRESULT GetCustomReferences(IOpcSignatureReferenceSet* customReferenceSet);
    HRESULT GetCertificateSet(IOpcCertificateSet* certificateSet);
    HRESULT GetFlags(XPS_SIGN_FLAGS* flags);
    HRESULT SetFlags(XPS_SIGN_FLAGS flags);
}

const GUID IID_IXpsSignatureCollection = {0xA2D1D95D, 0xADD2, 0x4DFF, [0xAB, 0x27, 0x6B, 0x9C, 0x64, 0x5F, 0xF3, 0x22]};
@GUID(0xA2D1D95D, 0xADD2, 0x4DFF, [0xAB, 0x27, 0x6B, 0x9C, 0x64, 0x5F, 0xF3, 0x22]);
interface IXpsSignatureCollection : IUnknown
{
    HRESULT GetCount(uint* count);
    HRESULT GetAt(uint index, IXpsSignature* signature);
    HRESULT RemoveAt(uint index);
}

const GUID IID_IXpsSignature = {0x6AE4C93E, 0x1ADE, 0x42FB, [0x89, 0x8B, 0x3A, 0x56, 0x58, 0x28, 0x48, 0x57]};
@GUID(0x6AE4C93E, 0x1ADE, 0x42FB, [0x89, 0x8B, 0x3A, 0x56, 0x58, 0x28, 0x48, 0x57]);
interface IXpsSignature : IUnknown
{
    HRESULT GetSignatureId(ushort** sigId);
    HRESULT GetSignatureValue(ubyte** signatureHashValue, uint* count);
    HRESULT GetCertificateEnumerator(IOpcCertificateEnumerator* certificateEnumerator);
    HRESULT GetSigningTime(ushort** sigDateTimeString);
    HRESULT GetSigningTimeFormat(OPC_SIGNATURE_TIME_FORMAT* timeFormat);
    HRESULT GetSignaturePartName(IOpcPartUri* signaturePartName);
    HRESULT Verify(const(CERT_CONTEXT)* x509Certificate, XPS_SIGNATURE_STATUS* sigStatus);
    HRESULT GetPolicy(XPS_SIGN_POLICY* policy);
    HRESULT GetCustomObjectEnumerator(IOpcSignatureCustomObjectEnumerator* customObjectEnumerator);
    HRESULT GetCustomReferenceEnumerator(IOpcSignatureReferenceEnumerator* customReferenceEnumerator);
    HRESULT GetSignatureXml(ubyte** signatureXml, uint* count);
    HRESULT SetSignatureXml(const(ubyte)* signatureXml, uint count);
}

const GUID IID_IXpsSignatureBlockCollection = {0x23397050, 0xFE99, 0x467A, [0x8D, 0xCE, 0x92, 0x37, 0xF0, 0x74, 0xFF, 0xE4]};
@GUID(0x23397050, 0xFE99, 0x467A, [0x8D, 0xCE, 0x92, 0x37, 0xF0, 0x74, 0xFF, 0xE4]);
interface IXpsSignatureBlockCollection : IUnknown
{
    HRESULT GetCount(uint* count);
    HRESULT GetAt(uint index, IXpsSignatureBlock* signatureBlock);
    HRESULT RemoveAt(uint index);
}

const GUID IID_IXpsSignatureBlock = {0x151FAC09, 0x0B97, 0x4AC6, [0xA3, 0x23, 0x5E, 0x42, 0x97, 0xD4, 0x32, 0x2B]};
@GUID(0x151FAC09, 0x0B97, 0x4AC6, [0xA3, 0x23, 0x5E, 0x42, 0x97, 0xD4, 0x32, 0x2B]);
interface IXpsSignatureBlock : IUnknown
{
    HRESULT GetRequests(IXpsSignatureRequestCollection* requests);
    HRESULT GetPartName(IOpcPartUri* partName);
    HRESULT GetDocumentIndex(uint* fixedDocumentIndex);
    HRESULT GetDocumentName(IOpcPartUri* fixedDocumentName);
    HRESULT CreateRequest(const(wchar)* requestId, IXpsSignatureRequest* signatureRequest);
}

const GUID IID_IXpsSignatureRequestCollection = {0xF0253E68, 0x9F19, 0x412E, [0x9B, 0x4F, 0x54, 0xD3, 0xB0, 0xAC, 0x6C, 0xD9]};
@GUID(0xF0253E68, 0x9F19, 0x412E, [0x9B, 0x4F, 0x54, 0xD3, 0xB0, 0xAC, 0x6C, 0xD9]);
interface IXpsSignatureRequestCollection : IUnknown
{
    HRESULT GetCount(uint* count);
    HRESULT GetAt(uint index, IXpsSignatureRequest* signatureRequest);
    HRESULT RemoveAt(uint index);
}

const GUID IID_IXpsSignatureRequest = {0xAC58950B, 0x7208, 0x4B2D, [0xB2, 0xC4, 0x95, 0x10, 0x83, 0xD3, 0xB8, 0xEB]};
@GUID(0xAC58950B, 0x7208, 0x4B2D, [0xB2, 0xC4, 0x95, 0x10, 0x83, 0xD3, 0xB8, 0xEB]);
interface IXpsSignatureRequest : IUnknown
{
    HRESULT GetIntent(ushort** intent);
    HRESULT SetIntent(const(wchar)* intent);
    HRESULT GetRequestedSigner(ushort** signerName);
    HRESULT SetRequestedSigner(const(wchar)* signerName);
    HRESULT GetRequestSignByDate(ushort** dateString);
    HRESULT SetRequestSignByDate(const(wchar)* dateString);
    HRESULT GetSigningLocale(ushort** place);
    HRESULT SetSigningLocale(const(wchar)* place);
    HRESULT GetSpotLocation(int* pageIndex, IOpcPartUri* pagePartName, float* x, float* y);
    HRESULT SetSpotLocation(int pageIndex, float x, float y);
    HRESULT GetRequestId(ushort** requestId);
    HRESULT GetSignature(IXpsSignature* signature);
}

const GUID IID_IXpsSignatureManager = {0xD3E8D338, 0xFDC4, 0x4AFC, [0x80, 0xB5, 0xD5, 0x32, 0xA1, 0x78, 0x2E, 0xE1]};
@GUID(0xD3E8D338, 0xFDC4, 0x4AFC, [0x80, 0xB5, 0xD5, 0x32, 0xA1, 0x78, 0x2E, 0xE1]);
interface IXpsSignatureManager : IUnknown
{
    HRESULT LoadPackageFile(const(wchar)* fileName);
    HRESULT LoadPackageStream(IStream stream);
    HRESULT Sign(IXpsSigningOptions signOptions, const(CERT_CONTEXT)* x509Certificate, IXpsSignature* signature);
    HRESULT GetSignatureOriginPartName(IOpcPartUri* signatureOriginPartName);
    HRESULT SetSignatureOriginPartName(IOpcPartUri signatureOriginPartName);
    HRESULT GetSignatures(IXpsSignatureCollection* signatures);
    HRESULT AddSignatureBlock(IOpcPartUri partName, uint fixedDocumentIndex, IXpsSignatureBlock* signatureBlock);
    HRESULT GetSignatureBlocks(IXpsSignatureBlockCollection* signatureBlocks);
    HRESULT CreateSigningOptions(IXpsSigningOptions* signingOptions);
    HRESULT SavePackageToFile(const(wchar)* fileName, SECURITY_ATTRIBUTES* securityAttributes, uint flagsAndAttributes);
    HRESULT SavePackageToStream(IStream stream);
}

const GUID CLSID_PrintDocumentPackageTarget = {0x4842669E, 0x9947, 0x46EA, [0x8B, 0xA2, 0xD8, 0xCC, 0xE4, 0x32, 0xC2, 0xCA]};
@GUID(0x4842669E, 0x9947, 0x46EA, [0x8B, 0xA2, 0xD8, 0xCC, 0xE4, 0x32, 0xC2, 0xCA]);
struct PrintDocumentPackageTarget;

const GUID CLSID_PrintDocumentPackageTargetFactory = {0x348EF17D, 0x6C81, 0x4982, [0x92, 0xB4, 0xEE, 0x18, 0x8A, 0x43, 0x86, 0x7A]};
@GUID(0x348EF17D, 0x6C81, 0x4982, [0x92, 0xB4, 0xEE, 0x18, 0x8A, 0x43, 0x86, 0x7A]);
struct PrintDocumentPackageTargetFactory;

const GUID IID_IPrintDocumentPackageTarget = {0x1B8EFEC4, 0x3019, 0x4C27, [0x96, 0x4E, 0x36, 0x72, 0x02, 0x15, 0x69, 0x06]};
@GUID(0x1B8EFEC4, 0x3019, 0x4C27, [0x96, 0x4E, 0x36, 0x72, 0x02, 0x15, 0x69, 0x06]);
interface IPrintDocumentPackageTarget : IUnknown
{
    HRESULT GetPackageTargetTypes(uint* targetCount, char* targetTypes);
    HRESULT GetPackageTarget(const(Guid)* guidTargetType, const(Guid)* riid, void** ppvTarget);
    HRESULT Cancel();
}

enum PrintDocumentPackageCompletion
{
    PrintDocumentPackageCompletion_InProgress = 0,
    PrintDocumentPackageCompletion_Completed = 1,
    PrintDocumentPackageCompletion_Canceled = 2,
    PrintDocumentPackageCompletion_Failed = 3,
}

struct PrintDocumentPackageStatus
{
    uint JobId;
    int CurrentDocument;
    int CurrentPage;
    int CurrentPageTotal;
    PrintDocumentPackageCompletion Completion;
    HRESULT PackageStatus;
}

const GUID IID_IPrintDocumentPackageStatusEvent = {0xED90C8AD, 0x5C34, 0x4D05, [0xA1, 0xEC, 0x0E, 0x8A, 0x9B, 0x3A, 0xD7, 0xAF]};
@GUID(0xED90C8AD, 0x5C34, 0x4D05, [0xA1, 0xEC, 0x0E, 0x8A, 0x9B, 0x3A, 0xD7, 0xAF]);
interface IPrintDocumentPackageStatusEvent : IDispatch
{
    HRESULT PackageStatusUpdated(PrintDocumentPackageStatus* packageStatus);
}

const GUID IID_IPrintDocumentPackageTargetFactory = {0xD2959BF7, 0xB31B, 0x4A3D, [0x96, 0x00, 0x71, 0x2E, 0xB1, 0x33, 0x5B, 0xA4]};
@GUID(0xD2959BF7, 0xB31B, 0x4A3D, [0x96, 0x00, 0x71, 0x2E, 0xB1, 0x33, 0x5B, 0xA4]);
interface IPrintDocumentPackageTargetFactory : IUnknown
{
    HRESULT CreateDocumentPackageTargetForPrintJob(const(wchar)* printerName, const(wchar)* jobName, IStream jobOutputStream, IStream jobPrintTicketStream, IPrintDocumentPackageTarget* docPackageTarget);
}

struct HPTPROVIDER__
{
    int unused;
}

enum EDefaultDevmodeType
{
    kUserDefaultDevmode = 0,
    kPrinterDefaultDevmode = 1,
}

enum EPrintTicketScope
{
    kPTPageScope = 0,
    kPTDocumentScope = 1,
    kPTJobScope = 2,
}

