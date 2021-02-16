module windows.xps;

public import windows.core;
public import windows.automation : BSTR, IDispatch;
public import windows.com : HRESULT, IUnknown, IUri;
public import windows.displaydevices : DEVMODEW, POINT, POINTL;
public import windows.gdi : HDC;
public import windows.packaging : IOpcCertificateEnumerator, IOpcCertificateSet, IOpcPartUri,
                                  IOpcSignatureCustomObjectEnumerator, IOpcSignatureCustomObjectSet,
                                  IOpcSignatureReferenceEnumerator, IOpcSignatureReferenceSet,
                                  OPC_SIGNATURE_TIME_FORMAT;
public import windows.printdocs : XPS_GLYPH_INDEX;
public import windows.security : CERT_CONTEXT;
public import windows.structuredstorage : ISequentialStream, IStream;
public import windows.systemservices : BOOL, SECURITY_ATTRIBUTES;
public import windows.windowsandmessaging : HWND;
public import windows.windowsprogramming : SYSTEMTIME;

extern(Windows):


// Enums


enum : int
{
    XPS_TILE_MODE_NONE   = 0x00000001,
    XPS_TILE_MODE_TILE   = 0x00000002,
    XPS_TILE_MODE_FLIPX  = 0x00000003,
    XPS_TILE_MODE_FLIPY  = 0x00000004,
    XPS_TILE_MODE_FLIPXY = 0x00000005,
}
alias XPS_TILE_MODE = int;

enum : int
{
    XPS_COLOR_INTERPOLATION_SCRGBLINEAR = 0x00000001,
    XPS_COLOR_INTERPOLATION_SRGBLINEAR  = 0x00000002,
}
alias XPS_COLOR_INTERPOLATION = int;

enum : int
{
    XPS_SPREAD_METHOD_PAD     = 0x00000001,
    XPS_SPREAD_METHOD_REFLECT = 0x00000002,
    XPS_SPREAD_METHOD_REPEAT  = 0x00000003,
}
alias XPS_SPREAD_METHOD = int;

enum : int
{
    XPS_STYLE_SIMULATION_NONE       = 0x00000001,
    XPS_STYLE_SIMULATION_ITALIC     = 0x00000002,
    XPS_STYLE_SIMULATION_BOLD       = 0x00000003,
    XPS_STYLE_SIMULATION_BOLDITALIC = 0x00000004,
}
alias XPS_STYLE_SIMULATION = int;

enum : int
{
    XPS_LINE_CAP_FLAT     = 0x00000001,
    XPS_LINE_CAP_ROUND    = 0x00000002,
    XPS_LINE_CAP_SQUARE   = 0x00000003,
    XPS_LINE_CAP_TRIANGLE = 0x00000004,
}
alias XPS_LINE_CAP = int;

enum : int
{
    XPS_DASH_CAP_FLAT     = 0x00000001,
    XPS_DASH_CAP_ROUND    = 0x00000002,
    XPS_DASH_CAP_SQUARE   = 0x00000003,
    XPS_DASH_CAP_TRIANGLE = 0x00000004,
}
alias XPS_DASH_CAP = int;

enum : int
{
    XPS_LINE_JOIN_MITER = 0x00000001,
    XPS_LINE_JOIN_BEVEL = 0x00000002,
    XPS_LINE_JOIN_ROUND = 0x00000003,
}
alias XPS_LINE_JOIN = int;

enum : int
{
    XPS_IMAGE_TYPE_JPEG = 0x00000001,
    XPS_IMAGE_TYPE_PNG  = 0x00000002,
    XPS_IMAGE_TYPE_TIFF = 0x00000003,
    XPS_IMAGE_TYPE_WDP  = 0x00000004,
    XPS_IMAGE_TYPE_JXR  = 0x00000005,
}
alias XPS_IMAGE_TYPE = int;

enum : int
{
    XPS_COLOR_TYPE_SRGB    = 0x00000001,
    XPS_COLOR_TYPE_SCRGB   = 0x00000002,
    XPS_COLOR_TYPE_CONTEXT = 0x00000003,
}
alias XPS_COLOR_TYPE = int;

enum : int
{
    XPS_FILL_RULE_EVENODD = 0x00000001,
    XPS_FILL_RULE_NONZERO = 0x00000002,
}
alias XPS_FILL_RULE = int;

enum : int
{
    XPS_SEGMENT_TYPE_ARC_LARGE_CLOCKWISE        = 0x00000001,
    XPS_SEGMENT_TYPE_ARC_LARGE_COUNTERCLOCKWISE = 0x00000002,
    XPS_SEGMENT_TYPE_ARC_SMALL_CLOCKWISE        = 0x00000003,
    XPS_SEGMENT_TYPE_ARC_SMALL_COUNTERCLOCKWISE = 0x00000004,
    XPS_SEGMENT_TYPE_BEZIER                     = 0x00000005,
    XPS_SEGMENT_TYPE_LINE                       = 0x00000006,
    XPS_SEGMENT_TYPE_QUADRATIC_BEZIER           = 0x00000007,
}
alias XPS_SEGMENT_TYPE = int;

enum : int
{
    XPS_SEGMENT_STROKE_PATTERN_ALL   = 0x00000001,
    XPS_SEGMENT_STROKE_PATTERN_NONE  = 0x00000002,
    XPS_SEGMENT_STROKE_PATTERN_MIXED = 0x00000003,
}
alias XPS_SEGMENT_STROKE_PATTERN = int;

enum : int
{
    XPS_FONT_EMBEDDING_NORMAL                  = 0x00000001,
    XPS_FONT_EMBEDDING_OBFUSCATED              = 0x00000002,
    XPS_FONT_EMBEDDING_RESTRICTED              = 0x00000003,
    XPS_FONT_EMBEDDING_RESTRICTED_UNOBFUSCATED = 0x00000004,
}
alias XPS_FONT_EMBEDDING = int;

enum : int
{
    XPS_OBJECT_TYPE_CANVAS                = 0x00000001,
    XPS_OBJECT_TYPE_GLYPHS                = 0x00000002,
    XPS_OBJECT_TYPE_PATH                  = 0x00000003,
    XPS_OBJECT_TYPE_MATRIX_TRANSFORM      = 0x00000004,
    XPS_OBJECT_TYPE_GEOMETRY              = 0x00000005,
    XPS_OBJECT_TYPE_SOLID_COLOR_BRUSH     = 0x00000006,
    XPS_OBJECT_TYPE_IMAGE_BRUSH           = 0x00000007,
    XPS_OBJECT_TYPE_LINEAR_GRADIENT_BRUSH = 0x00000008,
    XPS_OBJECT_TYPE_RADIAL_GRADIENT_BRUSH = 0x00000009,
    XPS_OBJECT_TYPE_VISUAL_BRUSH          = 0x0000000a,
}
alias XPS_OBJECT_TYPE = int;

enum : int
{
    XPS_THUMBNAIL_SIZE_VERYSMALL = 0x00000001,
    XPS_THUMBNAIL_SIZE_SMALL     = 0x00000002,
    XPS_THUMBNAIL_SIZE_MEDIUM    = 0x00000003,
    XPS_THUMBNAIL_SIZE_LARGE     = 0x00000004,
}
alias XPS_THUMBNAIL_SIZE = int;

enum : int
{
    XPS_INTERLEAVING_OFF = 0x00000001,
    XPS_INTERLEAVING_ON  = 0x00000002,
}
alias XPS_INTERLEAVING = int;

enum : int
{
    XPS_DOCUMENT_TYPE_UNSPECIFIED = 0x00000001,
    XPS_DOCUMENT_TYPE_XPS         = 0x00000002,
    XPS_DOCUMENT_TYPE_OPENXPS     = 0x00000003,
}
alias XPS_DOCUMENT_TYPE = int;

enum : int
{
    XPS_SIGNATURE_STATUS_INCOMPLIANT  = 0x00000001,
    XPS_SIGNATURE_STATUS_INCOMPLETE   = 0x00000002,
    XPS_SIGNATURE_STATUS_BROKEN       = 0x00000003,
    XPS_SIGNATURE_STATUS_QUESTIONABLE = 0x00000004,
    XPS_SIGNATURE_STATUS_VALID        = 0x00000005,
}
alias XPS_SIGNATURE_STATUS = int;

enum : int
{
    XPS_SIGN_POLICY_NONE                    = 0x00000000,
    XPS_SIGN_POLICY_CORE_PROPERTIES         = 0x00000001,
    XPS_SIGN_POLICY_SIGNATURE_RELATIONSHIPS = 0x00000002,
    XPS_SIGN_POLICY_PRINT_TICKET            = 0x00000004,
    XPS_SIGN_POLICY_DISCARD_CONTROL         = 0x00000008,
    XPS_SIGN_POLICY_ALL                     = 0x0000000f,
}
alias XPS_SIGN_POLICY = int;

enum : int
{
    XPS_SIGN_FLAGS_NONE                        = 0x00000000,
    XPS_SIGN_FLAGS_IGNORE_MARKUP_COMPATIBILITY = 0x00000001,
}
alias XPS_SIGN_FLAGS = int;

enum PrintDocumentPackageCompletion : int
{
    PrintDocumentPackageCompletion_InProgress = 0x00000000,
    PrintDocumentPackageCompletion_Completed  = 0x00000001,
    PrintDocumentPackageCompletion_Canceled   = 0x00000002,
    PrintDocumentPackageCompletion_Failed     = 0x00000003,
}

enum EDefaultDevmodeType : int
{
    kUserDefaultDevmode    = 0x00000000,
    kPrinterDefaultDevmode = 0x00000001,
}

enum EPrintTicketScope : int
{
    kPTPageScope     = 0x00000000,
    kPTDocumentScope = 0x00000001,
    kPTJobScope      = 0x00000002,
}

// Callbacks

alias ABORTPROC = BOOL function(HDC param0, int param1);

// Structs


struct DRAWPATRECT
{
    POINT  ptPosition;
    POINT  ptSize;
    ushort wStyle;
    ushort wPattern;
}

struct PSINJECTDATA
{
    uint   DataBytes;
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
    ubyte[32] dmDeviceName;
    ushort    dmSpecVersion;
    ushort    dmDriverVersion;
    ushort    dmSize;
    ushort    dmDriverExtra;
    uint      dmFields;
    union
    {
        struct
        {
            short dmOrientation;
            short dmPaperSize;
            short dmPaperLength;
            short dmPaperWidth;
            short dmScale;
            short dmCopies;
            short dmDefaultSource;
            short dmPrintQuality;
        }
        struct
        {
            POINTL dmPosition;
            uint   dmDisplayOrientation;
            uint   dmDisplayFixedOutput;
        }
    }
    short     dmColor;
    short     dmDuplex;
    short     dmYResolution;
    short     dmTTOption;
    short     dmCollate;
    ubyte[32] dmFormName;
    ushort    dmLogPixels;
    uint      dmBitsPerPel;
    uint      dmPelsWidth;
    uint      dmPelsHeight;
    union
    {
        uint dmDisplayFlags;
        uint dmNup;
    }
    uint      dmDisplayFrequency;
    uint      dmICMMethod;
    uint      dmICMIntent;
    uint      dmMediaType;
    uint      dmDitherType;
    uint      dmReserved1;
    uint      dmReserved2;
    uint      dmPanningWidth;
    uint      dmPanningHeight;
}

struct DOCINFOA
{
    int          cbSize;
    const(char)* lpszDocName;
    const(char)* lpszOutput;
    const(char)* lpszDatatype;
    uint         fwType;
}

struct DOCINFOW
{
    int           cbSize;
    const(wchar)* lpszDocName;
    const(wchar)* lpszOutput;
    const(wchar)* lpszDatatype;
    uint          fwType;
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
    uint   unicodeStringStart;
    ushort unicodeStringLength;
    uint   glyphIndicesStart;
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
    union value
    {
        struct sRGB
        {
            ubyte alpha;
            ubyte red;
            ubyte green;
            ubyte blue;
        }
        struct scRGB
        {
            float alpha;
            float red;
            float green;
            float blue;
        }
        struct context
        {
            ubyte    channelCount;
            float[9] channels;
        }
    }
}

struct PrintDocumentPackageStatus
{
    uint    JobId;
    int     CurrentDocument;
    int     CurrentPage;
    int     CurrentPageTotal;
    PrintDocumentPackageCompletion Completion;
    HRESULT PackageStatus;
}

struct HPTPROVIDER__
{
    int unused;
}

// Functions

@DllImport("WINSPOOL")
int DeviceCapabilitiesA(const(char)* pDevice, const(char)* pPort, ushort fwCapability, const(char)* pOutput, 
                        const(DEVMODEA)* pDevMode);

@DllImport("WINSPOOL")
int DeviceCapabilitiesW(const(wchar)* pDevice, const(wchar)* pPort, ushort fwCapability, const(wchar)* pOutput, 
                        const(DEVMODEW)* pDevMode);

@DllImport("GDI32")
int Escape(HDC hdc, int iEscape, int cjIn, const(char)* pvIn, void* pvOut);

@DllImport("GDI32")
int ExtEscape(HDC hdc, int iEscape, int cjInput, const(char)* lpInData, int cjOutput, const(char)* lpOutData);

@DllImport("GDI32")
int StartDocA(HDC hdc, const(DOCINFOA)* lpdi);

@DllImport("GDI32")
int StartDocW(HDC hdc, const(DOCINFOW)* lpdi);

@DllImport("GDI32")
int EndDoc(HDC hdc);

@DllImport("GDI32")
int StartPage(HDC hdc);

@DllImport("GDI32")
int EndPage(HDC hdc);

@DllImport("GDI32")
int AbortDoc(HDC hdc);

@DllImport("GDI32")
int SetAbortProc(HDC hdc, ABORTPROC proc);

@DllImport("USER32")
BOOL PrintWindow(HWND hwnd, HDC hdcBlt, uint nFlags);

@DllImport("prntvpt")
HRESULT PTQuerySchemaVersionSupport(const(wchar)* pszPrinterName, uint* pMaxVersion);

@DllImport("prntvpt")
HRESULT PTOpenProvider(const(wchar)* pszPrinterName, uint dwVersion, HPTPROVIDER__** phProvider);

@DllImport("prntvpt")
HRESULT PTOpenProviderEx(const(wchar)* pszPrinterName, uint dwMaxVersion, uint dwPrefVersion, 
                         HPTPROVIDER__** phProvider, uint* pUsedVersion);

@DllImport("prntvpt")
HRESULT PTCloseProvider(HPTPROVIDER__* hProvider);

@DllImport("prntvpt")
HRESULT PTReleaseMemory(void* pBuffer);

@DllImport("prntvpt")
HRESULT PTGetPrintCapabilities(HPTPROVIDER__* hProvider, IStream pPrintTicket, IStream pCapabilities, 
                               BSTR* pbstrErrorMessage);

@DllImport("prntvpt")
HRESULT PTGetPrintDeviceCapabilities(HPTPROVIDER__* hProvider, IStream pPrintTicket, IStream pDeviceCapabilities, 
                                     BSTR* pbstrErrorMessage);

@DllImport("prntvpt")
HRESULT PTGetPrintDeviceResources(HPTPROVIDER__* hProvider, const(wchar)* pszLocaleName, IStream pPrintTicket, 
                                  IStream pDeviceResources, BSTR* pbstrErrorMessage);

@DllImport("prntvpt")
HRESULT PTMergeAndValidatePrintTicket(HPTPROVIDER__* hProvider, IStream pBaseTicket, IStream pDeltaTicket, 
                                      EPrintTicketScope scope_, IStream pResultTicket, BSTR* pbstrErrorMessage);

@DllImport("prntvpt")
HRESULT PTConvertPrintTicketToDevMode(HPTPROVIDER__* hProvider, IStream pPrintTicket, 
                                      EDefaultDevmodeType baseDevmodeType, EPrintTicketScope scope_, 
                                      uint* pcbDevmode, DEVMODEA** ppDevmode, BSTR* pbstrErrorMessage);

@DllImport("prntvpt")
HRESULT PTConvertDevModeToPrintTicket(HPTPROVIDER__* hProvider, uint cbDevmode, DEVMODEA* pDevmode, 
                                      EPrintTicketScope scope_, IStream pPrintTicket);


// Interfaces

@GUID("E974D26D-3D9B-4D47-88CC-3872F2DC3585")
struct XpsOMObjectFactory;

@GUID("7E4A23E2-B969-4761-BE35-1A8CED58E323")
struct XpsOMThumbnailGenerator;

@GUID("B0C43320-2315-44A2-B70A-0943A140A8EE")
struct XpsSignatureManager;

@GUID("4842669E-9947-46EA-8BA2-D8CCE432C2CA")
struct PrintDocumentPackageTarget;

@GUID("348EF17D-6C81-4982-92B4-EE188A43867A")
struct PrintDocumentPackageTargetFactory;

@GUID("7137398F-2FC1-454D-8C6A-2C3115A16ECE")
interface IXpsOMShareable : IUnknown
{
    HRESULT GetOwner(IUnknown* owner);
    HRESULT GetType(XPS_OBJECT_TYPE* type);
}

@GUID("BC3E7333-FB0B-4AF3-A819-0B4EAAD0D2FD")
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

@GUID("74EB2F0B-A91E-4486-AFAC-0FABECA3DFC6")
interface IXpsOMPart : IUnknown
{
    HRESULT GetPartName(IOpcPartUri* partUri);
    HRESULT SetPartName(IOpcPartUri partUri);
}

@GUID("A5AB8616-5B16-4B9F-9629-89B323ED7909")
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

@GUID("819B3199-0A5A-4B64-BEC7-A9E17E780DE2")
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

@GUID("081613F4-74EB-48F2-83B3-37A9CE2D7DC6")
interface IXpsOMDashCollection : IUnknown
{
    HRESULT GetCount(uint* count);
    HRESULT GetAt(uint index, XPS_DASH* dash);
    HRESULT InsertAt(uint index, const(XPS_DASH)* dash);
    HRESULT RemoveAt(uint index);
    HRESULT SetAt(uint index, const(XPS_DASH)* dash);
    HRESULT Append(const(XPS_DASH)* dash);
}

@GUID("B77330FF-BB37-4501-A93E-F1B1E50BFC46")
interface IXpsOMMatrixTransform : IXpsOMShareable
{
    HRESULT GetMatrix(XPS_MATRIX* matrix);
    HRESULT SetMatrix(const(XPS_MATRIX)* matrix);
    HRESULT Clone(IXpsOMMatrixTransform* matrixTransform);
}

@GUID("64FCF3D7-4D58-44BA-AD73-A13AF6492072")
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

@GUID("D410DC83-908C-443E-8947-B1795D3C165A")
interface IXpsOMGeometryFigure : IUnknown
{
    HRESULT GetOwner(IXpsOMGeometry* owner);
    HRESULT GetSegmentData(uint* dataCount, float* segmentData);
    HRESULT GetSegmentTypes(uint* segmentCount, XPS_SEGMENT_TYPE* segmentTypes);
    HRESULT GetSegmentStrokes(uint* segmentCount, int* segmentStrokes);
    HRESULT SetSegments(uint segmentCount, uint segmentDataCount, const(XPS_SEGMENT_TYPE)* segmentTypes, 
                        const(float)* segmentData, const(int)* segmentStrokes);
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

@GUID("FD48C3F3-A58E-4B5A-8826-1DE54ABE72B2")
interface IXpsOMGeometryFigureCollection : IUnknown
{
    HRESULT GetCount(uint* count);
    HRESULT GetAt(uint index, IXpsOMGeometryFigure* geometryFigure);
    HRESULT InsertAt(uint index, IXpsOMGeometryFigure geometryFigure);
    HRESULT RemoveAt(uint index);
    HRESULT SetAt(uint index, IXpsOMGeometryFigure geometryFigure);
    HRESULT Append(IXpsOMGeometryFigure geometryFigure);
}

@GUID("37D38BB6-3EE9-4110-9312-14B194163337")
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

@GUID("56A3F80C-EA4C-4187-A57B-A2A473B2B42B")
interface IXpsOMBrush : IXpsOMShareable
{
    HRESULT GetOpacity(float* opacity);
    HRESULT SetOpacity(float opacity);
}

@GUID("C9174C3A-3CD3-4319-BDA4-11A39392CEEF")
interface IXpsOMGradientStopCollection : IUnknown
{
    HRESULT GetCount(uint* count);
    HRESULT GetAt(uint index, IXpsOMGradientStop* stop);
    HRESULT InsertAt(uint index, IXpsOMGradientStop stop);
    HRESULT RemoveAt(uint index);
    HRESULT SetAt(uint index, IXpsOMGradientStop stop);
    HRESULT Append(IXpsOMGradientStop stop);
}

@GUID("A06F9F05-3BE9-4763-98A8-094FC672E488")
interface IXpsOMSolidColorBrush : IXpsOMBrush
{
    HRESULT GetColor(XPS_COLOR* color, IXpsOMColorProfileResource* colorProfile);
    HRESULT SetColor(const(XPS_COLOR)* color, IXpsOMColorProfileResource colorProfile);
    HRESULT Clone(IXpsOMSolidColorBrush* solidColorBrush);
}

@GUID("0FC2328D-D722-4A54-B2EC-BE90218A789E")
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

@GUID("97E294AF-5B37-46B4-8057-874D2F64119B")
interface IXpsOMVisualBrush : IXpsOMTileBrush
{
    HRESULT GetVisual(IXpsOMVisual* visual);
    HRESULT GetVisualLocal(IXpsOMVisual* visual);
    HRESULT SetVisualLocal(IXpsOMVisual visual);
    HRESULT GetVisualLookup(ushort** lookup);
    HRESULT SetVisualLookup(const(wchar)* lookup);
    HRESULT Clone(IXpsOMVisualBrush* visualBrush);
}

@GUID("3DF0B466-D382-49EF-8550-DD94C80242E4")
interface IXpsOMImageBrush : IXpsOMTileBrush
{
    HRESULT GetImageResource(IXpsOMImageResource* imageResource);
    HRESULT SetImageResource(IXpsOMImageResource imageResource);
    HRESULT GetColorProfileResource(IXpsOMColorProfileResource* colorProfileResource);
    HRESULT SetColorProfileResource(IXpsOMColorProfileResource colorProfileResource);
    HRESULT Clone(IXpsOMImageBrush* imageBrush);
}

@GUID("5CF4F5CC-3969-49B5-A70A-5550B618FE49")
interface IXpsOMGradientStop : IUnknown
{
    HRESULT GetOwner(IXpsOMGradientBrush* owner);
    HRESULT GetOffset(float* offset);
    HRESULT SetOffset(float offset);
    HRESULT GetColor(XPS_COLOR* color, IXpsOMColorProfileResource* colorProfile);
    HRESULT SetColor(const(XPS_COLOR)* color, IXpsOMColorProfileResource colorProfile);
    HRESULT Clone(IXpsOMGradientStop* gradientStop);
}

@GUID("EDB59622-61A2-42C3-BACE-ACF2286C06BF")
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

@GUID("005E279F-C30D-40FF-93EC-1950D3C528DB")
interface IXpsOMLinearGradientBrush : IXpsOMGradientBrush
{
    HRESULT GetStartPoint(XPS_POINT* startPoint);
    HRESULT SetStartPoint(const(XPS_POINT)* startPoint);
    HRESULT GetEndPoint(XPS_POINT* endPoint);
    HRESULT SetEndPoint(const(XPS_POINT)* endPoint);
    HRESULT Clone(IXpsOMLinearGradientBrush* linearGradientBrush);
}

@GUID("75F207E5-08BF-413C-96B1-B82B4064176B")
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

@GUID("DA2AC0A2-73A2-4975-AD14-74097C3FF3A5")
interface IXpsOMResource : IXpsOMPart
{
}

@GUID("F4CF7729-4864-4275-99B3-A8717163ECAF")
interface IXpsOMPartResources : IUnknown
{
    HRESULT GetFontResources(IXpsOMFontResourceCollection* fontResources);
    HRESULT GetImageResources(IXpsOMImageResourceCollection* imageResources);
    HRESULT GetColorProfileResources(IXpsOMColorProfileResourceCollection* colorProfileResources);
    HRESULT GetRemoteDictionaryResources(IXpsOMRemoteDictionaryResourceCollection* dictionaryResources);
}

@GUID("897C86B8-8EAF-4AE3-BDDE-56419FCF4236")
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

@GUID("A8C45708-47D9-4AF4-8D20-33B48C9B8485")
interface IXpsOMFontResource : IXpsOMResource
{
    HRESULT GetStream(IStream* readerStream);
    HRESULT SetContent(IStream sourceStream, XPS_FONT_EMBEDDING embeddingOption, IOpcPartUri partName);
    HRESULT GetEmbeddingOption(XPS_FONT_EMBEDDING* embeddingOption);
}

@GUID("70B4A6BB-88D4-4FA8-AAF9-6D9C596FDBAD")
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

@GUID("3DB8417D-AE50-485E-9A44-D7758F78A23F")
interface IXpsOMImageResource : IXpsOMResource
{
    HRESULT GetStream(IStream* readerStream);
    HRESULT SetContent(IStream sourceStream, XPS_IMAGE_TYPE imageType, IOpcPartUri partName);
    HRESULT GetImageType(XPS_IMAGE_TYPE* imageType);
}

@GUID("7A4A1A71-9CDE-4B71-B33F-62DE843EABFE")
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

@GUID("67BD7D69-1EEF-4BB1-B5E7-6F4F87BE8ABE")
interface IXpsOMColorProfileResource : IXpsOMResource
{
    HRESULT GetStream(IStream* stream);
    HRESULT SetContent(IStream sourceStream, IOpcPartUri partName);
}

@GUID("12759630-5FBA-4283-8F7D-CCA849809EDB")
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

@GUID("E7FF32D2-34AA-499B-BBE9-9CD4EE6C59F7")
interface IXpsOMPrintTicketResource : IXpsOMResource
{
    HRESULT GetStream(IStream* stream);
    HRESULT SetContent(IStream sourceStream, IOpcPartUri partName);
}

@GUID("C9BD7CD4-E16A-4BF8-8C84-C950AF7A3061")
interface IXpsOMRemoteDictionaryResource : IXpsOMResource
{
    HRESULT GetDictionary(IXpsOMDictionary* dictionary);
    HRESULT SetDictionary(IXpsOMDictionary dictionary);
}

@GUID("5C38DB61-7FEC-464A-87BD-41E3BEF018BE")
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

@GUID("AB8F5D8E-351B-4D33-AAED-FA56F0022931")
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

@GUID("85FEBC8A-6B63-48A9-AF07-7064E4ECFF30")
interface IXpsOMDocumentStructureResource : IXpsOMResource
{
    HRESULT GetOwner(IXpsOMDocument* owner);
    HRESULT GetStream(IStream* stream);
    HRESULT SetContent(IStream sourceStream, IOpcPartUri partName);
}

@GUID("C2B3CA09-0473-4282-87AE-1780863223F0")
interface IXpsOMStoryFragmentsResource : IXpsOMResource
{
    HRESULT GetOwner(IXpsOMPageReference* owner);
    HRESULT GetStream(IStream* stream);
    HRESULT SetContent(IStream sourceStream, IOpcPartUri partName);
}

@GUID("4776AD35-2E04-4357-8743-EBF6C171A905")
interface IXpsOMSignatureBlockResource : IXpsOMResource
{
    HRESULT GetOwner(IXpsOMDocument* owner);
    HRESULT GetStream(IStream* stream);
    HRESULT SetContent(IStream sourceStream, IOpcPartUri partName);
}

@GUID("94D8ABDE-AB91-46A8-82B7-F5B05EF01A96")
interface IXpsOMVisualCollection : IUnknown
{
    HRESULT GetCount(uint* count);
    HRESULT GetAt(uint index, IXpsOMVisual* object);
    HRESULT InsertAt(uint index, IXpsOMVisual object);
    HRESULT RemoveAt(uint index);
    HRESULT SetAt(uint index, IXpsOMVisual object);
    HRESULT Append(IXpsOMVisual object);
}

@GUID("221D1452-331E-47C6-87E9-6CCEFB9B5BA3")
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

@GUID("D3E18888-F120-4FEE-8C68-35296EAE91D4")
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

@GUID("ED360180-6F92-4998-890D-2F208531A0A0")
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

@GUID("CA16BA4D-E7B9-45C5-958B-F98022473745")
interface IXpsOMPageReferenceCollection : IUnknown
{
    HRESULT GetCount(uint* count);
    HRESULT GetAt(uint index, IXpsOMPageReference* pageReference);
    HRESULT InsertAt(uint index, IXpsOMPageReference pageReference);
    HRESULT RemoveAt(uint index);
    HRESULT SetAt(uint index, IXpsOMPageReference pageReference);
    HRESULT Append(IXpsOMPageReference pageReference);
}

@GUID("2C2C94CB-AC5F-4254-8EE9-23948309D9F0")
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

@GUID("D1C87F0D-E947-4754-8A25-971478F7E83E")
interface IXpsOMDocumentCollection : IUnknown
{
    HRESULT GetCount(uint* count);
    HRESULT GetAt(uint index, IXpsOMDocument* document);
    HRESULT InsertAt(uint index, IXpsOMDocument document);
    HRESULT RemoveAt(uint index);
    HRESULT SetAt(uint index, IXpsOMDocument document);
    HRESULT Append(IXpsOMDocument document);
}

@GUID("56492EB4-D8D5-425E-8256-4C2B64AD0264")
interface IXpsOMDocumentSequence : IXpsOMPart
{
    HRESULT GetOwner(IXpsOMPackage* package_);
    HRESULT GetDocuments(IXpsOMDocumentCollection* documents);
    HRESULT GetPrintTicketResource(IXpsOMPrintTicketResource* printTicketResource);
    HRESULT SetPrintTicketResource(IXpsOMPrintTicketResource printTicketResource);
}

@GUID("3340FE8F-4027-4AA1-8F5F-D35AE45FE597")
interface IXpsOMCoreProperties : IXpsOMPart
{
    HRESULT GetOwner(IXpsOMPackage* package_);
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
    HRESULT GetVersion(ushort** version_);
    HRESULT SetVersion(const(wchar)* version_);
    HRESULT Clone(IXpsOMCoreProperties* coreProperties);
}

@GUID("18C3DF65-81E1-4674-91DC-FC452F5A416F")
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
    HRESULT WriteToFile(const(wchar)* fileName, SECURITY_ATTRIBUTES* securityAttributes, uint flagsAndAttributes, 
                        BOOL optimizeMarkupSize);
    HRESULT WriteToStream(ISequentialStream stream, BOOL optimizeMarkupSize);
}

@GUID("F9B2A685-A50D-4FC2-B764-B56E093EA0CA")
interface IXpsOMObjectFactory : IUnknown
{
    HRESULT CreatePackage(IXpsOMPackage* package_);
    HRESULT CreatePackageFromFile(const(wchar)* filename, BOOL reuseObjects, IXpsOMPackage* package_);
    HRESULT CreatePackageFromStream(IStream stream, BOOL reuseObjects, IXpsOMPackage* package_);
    HRESULT CreateStoryFragmentsResource(IStream acquiredStream, IOpcPartUri partUri, 
                                         IXpsOMStoryFragmentsResource* storyFragmentsResource);
    HRESULT CreateDocumentStructureResource(IStream acquiredStream, IOpcPartUri partUri, 
                                            IXpsOMDocumentStructureResource* documentStructureResource);
    HRESULT CreateSignatureBlockResource(IStream acquiredStream, IOpcPartUri partUri, 
                                         IXpsOMSignatureBlockResource* signatureBlockResource);
    HRESULT CreateRemoteDictionaryResource(IXpsOMDictionary dictionary, IOpcPartUri partUri, 
                                           IXpsOMRemoteDictionaryResource* remoteDictionaryResource);
    HRESULT CreateRemoteDictionaryResourceFromStream(IStream dictionaryMarkupStream, IOpcPartUri dictionaryPartUri, 
                                                     IXpsOMPartResources resources, 
                                                     IXpsOMRemoteDictionaryResource* dictionaryResource);
    HRESULT CreatePartResources(IXpsOMPartResources* partResources);
    HRESULT CreateDocumentSequence(IOpcPartUri partUri, IXpsOMDocumentSequence* documentSequence);
    HRESULT CreateDocument(IOpcPartUri partUri, IXpsOMDocument* document);
    HRESULT CreatePageReference(const(XPS_SIZE)* advisoryPageDimensions, IXpsOMPageReference* pageReference);
    HRESULT CreatePage(const(XPS_SIZE)* pageDimensions, const(wchar)* language, IOpcPartUri partUri, 
                       IXpsOMPage* page);
    HRESULT CreatePageFromStream(IStream pageMarkupStream, IOpcPartUri partUri, IXpsOMPartResources resources, 
                                 BOOL reuseObjects, IXpsOMPage* page);
    HRESULT CreateCanvas(IXpsOMCanvas* canvas);
    HRESULT CreateGlyphs(IXpsOMFontResource fontResource, IXpsOMGlyphs* glyphs);
    HRESULT CreatePath(IXpsOMPath* path);
    HRESULT CreateGeometry(IXpsOMGeometry* geometry);
    HRESULT CreateGeometryFigure(const(XPS_POINT)* startPoint, IXpsOMGeometryFigure* figure);
    HRESULT CreateMatrixTransform(const(XPS_MATRIX)* matrix, IXpsOMMatrixTransform* transform);
    HRESULT CreateSolidColorBrush(const(XPS_COLOR)* color, IXpsOMColorProfileResource colorProfile, 
                                  IXpsOMSolidColorBrush* solidColorBrush);
    HRESULT CreateColorProfileResource(IStream acquiredStream, IOpcPartUri partUri, 
                                       IXpsOMColorProfileResource* colorProfileResource);
    HRESULT CreateImageBrush(IXpsOMImageResource image, const(XPS_RECT)* viewBox, const(XPS_RECT)* viewPort, 
                             IXpsOMImageBrush* imageBrush);
    HRESULT CreateVisualBrush(const(XPS_RECT)* viewBox, const(XPS_RECT)* viewPort, IXpsOMVisualBrush* visualBrush);
    HRESULT CreateImageResource(IStream acquiredStream, XPS_IMAGE_TYPE contentType, IOpcPartUri partUri, 
                                IXpsOMImageResource* imageResource);
    HRESULT CreatePrintTicketResource(IStream acquiredStream, IOpcPartUri partUri, 
                                      IXpsOMPrintTicketResource* printTicketResource);
    HRESULT CreateFontResource(IStream acquiredStream, XPS_FONT_EMBEDDING fontEmbedding, IOpcPartUri partUri, 
                               BOOL isObfSourceStream, IXpsOMFontResource* fontResource);
    HRESULT CreateGradientStop(const(XPS_COLOR)* color, IXpsOMColorProfileResource colorProfile, float offset, 
                               IXpsOMGradientStop* gradientStop);
    HRESULT CreateLinearGradientBrush(IXpsOMGradientStop gradStop1, IXpsOMGradientStop gradStop2, 
                                      const(XPS_POINT)* startPoint, const(XPS_POINT)* endPoint, 
                                      IXpsOMLinearGradientBrush* linearGradientBrush);
    HRESULT CreateRadialGradientBrush(IXpsOMGradientStop gradStop1, IXpsOMGradientStop gradStop2, 
                                      const(XPS_POINT)* centerPoint, const(XPS_POINT)* gradientOrigin, 
                                      const(XPS_SIZE)* radiiSizes, IXpsOMRadialGradientBrush* radialGradientBrush);
    HRESULT CreateCoreProperties(IOpcPartUri partUri, IXpsOMCoreProperties* coreProperties);
    HRESULT CreateDictionary(IXpsOMDictionary* dictionary);
    HRESULT CreatePartUriCollection(IXpsOMPartUriCollection* partUriCollection);
    HRESULT CreatePackageWriterOnFile(const(wchar)* fileName, SECURITY_ATTRIBUTES* securityAttributes, 
                                      uint flagsAndAttributes, BOOL optimizeMarkupSize, 
                                      XPS_INTERLEAVING interleaving, IOpcPartUri documentSequencePartName, 
                                      IXpsOMCoreProperties coreProperties, IXpsOMImageResource packageThumbnail, 
                                      IXpsOMPrintTicketResource documentSequencePrintTicket, 
                                      IOpcPartUri discardControlPartName, IXpsOMPackageWriter* packageWriter);
    HRESULT CreatePackageWriterOnStream(ISequentialStream outputStream, BOOL optimizeMarkupSize, 
                                        XPS_INTERLEAVING interleaving, IOpcPartUri documentSequencePartName, 
                                        IXpsOMCoreProperties coreProperties, IXpsOMImageResource packageThumbnail, 
                                        IXpsOMPrintTicketResource documentSequencePrintTicket, 
                                        IOpcPartUri discardControlPartName, IXpsOMPackageWriter* packageWriter);
    HRESULT CreatePartUri(const(wchar)* uri, IOpcPartUri* partUri);
    HRESULT CreateReadOnlyStreamOnFile(const(wchar)* filename, IStream* stream);
}

@GUID("4BDDF8EC-C915-421B-A166-D173D25653D2")
interface IXpsOMNameCollection : IUnknown
{
    HRESULT GetCount(uint* count);
    HRESULT GetAt(uint index, ushort** name);
}

@GUID("57C650D4-067C-4893-8C33-F62A0633730F")
interface IXpsOMPartUriCollection : IUnknown
{
    HRESULT GetCount(uint* count);
    HRESULT GetAt(uint index, IOpcPartUri* partUri);
    HRESULT InsertAt(uint index, IOpcPartUri partUri);
    HRESULT RemoveAt(uint index);
    HRESULT SetAt(uint index, IOpcPartUri partUri);
    HRESULT Append(IOpcPartUri partUri);
}

@GUID("4E2AA182-A443-42C6-B41B-4F8E9DE73FF9")
interface IXpsOMPackageWriter : IUnknown
{
    HRESULT StartNewDocument(IOpcPartUri documentPartName, IXpsOMPrintTicketResource documentPrintTicket, 
                             IXpsOMDocumentStructureResource documentStructure, 
                             IXpsOMSignatureBlockResourceCollection signatureBlockResources, 
                             IXpsOMPartUriCollection restrictedFonts);
    HRESULT AddPage(IXpsOMPage page, const(XPS_SIZE)* advisoryPageDimensions, 
                    IXpsOMPartUriCollection discardableResourceParts, IXpsOMStoryFragmentsResource storyFragments, 
                    IXpsOMPrintTicketResource pagePrintTicket, IXpsOMImageResource pageThumbnail);
    HRESULT AddResource(IXpsOMResource resource);
    HRESULT Close();
    HRESULT IsClosed(int* isClosed);
}

@GUID("219A9DB0-4959-47D0-8034-B1CE84F41A4D")
interface IXpsOMPackageTarget : IUnknown
{
    HRESULT CreateXpsOMPackageWriter(IOpcPartUri documentSequencePartName, 
                                     IXpsOMPrintTicketResource documentSequencePrintTicket, 
                                     IOpcPartUri discardControlPartName, IXpsOMPackageWriter* packageWriter);
}

@GUID("15B873D5-1971-41E8-83A3-6578403064C7")
interface IXpsOMThumbnailGenerator : IUnknown
{
    HRESULT GenerateThumbnail(IXpsOMPage page, XPS_IMAGE_TYPE thumbnailType, XPS_THUMBNAIL_SIZE thumbnailSize, 
                              IOpcPartUri imageResourcePartName, IXpsOMImageResource* imageResource);
}

@GUID("0A91B617-D612-4181-BF7C-BE5824E9CC8F")
interface IXpsOMObjectFactory1 : IXpsOMObjectFactory
{
    HRESULT GetDocumentTypeFromFile(const(wchar)* filename, XPS_DOCUMENT_TYPE* documentType);
    HRESULT GetDocumentTypeFromStream(IStream xpsDocumentStream, XPS_DOCUMENT_TYPE* documentType);
    HRESULT ConvertHDPhotoToJpegXR(IXpsOMImageResource imageResource);
    HRESULT ConvertJpegXRToHDPhoto(IXpsOMImageResource imageResource);
    HRESULT CreatePackageWriterOnFile1(const(wchar)* fileName, SECURITY_ATTRIBUTES* securityAttributes, 
                                       uint flagsAndAttributes, BOOL optimizeMarkupSize, 
                                       XPS_INTERLEAVING interleaving, IOpcPartUri documentSequencePartName, 
                                       IXpsOMCoreProperties coreProperties, IXpsOMImageResource packageThumbnail, 
                                       IXpsOMPrintTicketResource documentSequencePrintTicket, 
                                       IOpcPartUri discardControlPartName, XPS_DOCUMENT_TYPE documentType, 
                                       IXpsOMPackageWriter* packageWriter);
    HRESULT CreatePackageWriterOnStream1(ISequentialStream outputStream, BOOL optimizeMarkupSize, 
                                         XPS_INTERLEAVING interleaving, IOpcPartUri documentSequencePartName, 
                                         IXpsOMCoreProperties coreProperties, IXpsOMImageResource packageThumbnail, 
                                         IXpsOMPrintTicketResource documentSequencePrintTicket, 
                                         IOpcPartUri discardControlPartName, XPS_DOCUMENT_TYPE documentType, 
                                         IXpsOMPackageWriter* packageWriter);
    HRESULT CreatePackage1(IXpsOMPackage1* package_);
    HRESULT CreatePackageFromStream1(IStream stream, BOOL reuseObjects, IXpsOMPackage1* package_);
    HRESULT CreatePackageFromFile1(const(wchar)* filename, BOOL reuseObjects, IXpsOMPackage1* package_);
    HRESULT CreatePage1(const(XPS_SIZE)* pageDimensions, const(wchar)* language, IOpcPartUri partUri, 
                        IXpsOMPage1* page);
    HRESULT CreatePageFromStream1(IStream pageMarkupStream, IOpcPartUri partUri, IXpsOMPartResources resources, 
                                  BOOL reuseObjects, IXpsOMPage1* page);
    HRESULT CreateRemoteDictionaryResourceFromStream1(IStream dictionaryMarkupStream, IOpcPartUri partUri, 
                                                      IXpsOMPartResources resources, 
                                                      IXpsOMRemoteDictionaryResource* dictionaryResource);
}

@GUID("95A9435E-12BB-461B-8E7F-C6ADB04CD96A")
interface IXpsOMPackage1 : IXpsOMPackage
{
    HRESULT GetDocumentType(XPS_DOCUMENT_TYPE* documentType);
    HRESULT WriteToFile1(const(wchar)* fileName, SECURITY_ATTRIBUTES* securityAttributes, uint flagsAndAttributes, 
                         BOOL optimizeMarkupSize, XPS_DOCUMENT_TYPE documentType);
    HRESULT WriteToStream1(ISequentialStream outputStream, BOOL optimizeMarkupSize, XPS_DOCUMENT_TYPE documentType);
}

@GUID("305B60EF-6892-4DDA-9CBB-3AA65974508A")
interface IXpsOMPage1 : IXpsOMPage
{
    HRESULT GetDocumentType(XPS_DOCUMENT_TYPE* documentType);
    HRESULT Write1(ISequentialStream stream, BOOL optimizeMarkupSize, XPS_DOCUMENT_TYPE documentType);
}

@GUID("3B0B6D38-53AD-41DA-B212-D37637A6714E")
interface IXpsDocumentPackageTarget : IUnknown
{
    HRESULT GetXpsOMPackageWriter(IOpcPartUri documentSequencePartName, IOpcPartUri discardControlPartName, 
                                  IXpsOMPackageWriter* packageWriter);
    HRESULT GetXpsOMFactory(IXpsOMObjectFactory* xpsFactory);
    HRESULT GetXpsType(XPS_DOCUMENT_TYPE* documentType);
}

@GUID("BF8FC1D4-9D46-4141-BA5F-94BB9250D041")
interface IXpsOMRemoteDictionaryResource1 : IXpsOMRemoteDictionaryResource
{
    HRESULT GetDocumentType(XPS_DOCUMENT_TYPE* documentType);
    HRESULT Write1(ISequentialStream stream, XPS_DOCUMENT_TYPE documentType);
}

@GUID("E8A45033-640E-43FA-9BDF-FDDEAA31C6A0")
interface IXpsOMPackageWriter3D : IXpsOMPackageWriter
{
    HRESULT AddModelTexture(IOpcPartUri texturePartName, IStream textureData);
    HRESULT SetModelPrintTicket(IOpcPartUri printTicketPartName, IStream printTicketData);
}

@GUID("60BA71B8-3101-4984-9199-F4EA775FF01D")
interface IXpsDocumentPackageTarget3D : IUnknown
{
    HRESULT GetXpsOMPackageWriter3D(IOpcPartUri documentSequencePartName, IOpcPartUri discardControlPartName, 
                                    IOpcPartUri modelPartName, IStream modelData, 
                                    IXpsOMPackageWriter3D* packageWriter);
    HRESULT GetXpsOMFactory(IXpsOMObjectFactory* xpsFactory);
}

@GUID("7718EAE4-3215-49BE-AF5B-594FEF7FCFA6")
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

@GUID("A2D1D95D-ADD2-4DFF-AB27-6B9C645FF322")
interface IXpsSignatureCollection : IUnknown
{
    HRESULT GetCount(uint* count);
    HRESULT GetAt(uint index, IXpsSignature* signature);
    HRESULT RemoveAt(uint index);
}

@GUID("6AE4C93E-1ADE-42FB-898B-3A5658284857")
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

@GUID("23397050-FE99-467A-8DCE-9237F074FFE4")
interface IXpsSignatureBlockCollection : IUnknown
{
    HRESULT GetCount(uint* count);
    HRESULT GetAt(uint index, IXpsSignatureBlock* signatureBlock);
    HRESULT RemoveAt(uint index);
}

@GUID("151FAC09-0B97-4AC6-A323-5E4297D4322B")
interface IXpsSignatureBlock : IUnknown
{
    HRESULT GetRequests(IXpsSignatureRequestCollection* requests);
    HRESULT GetPartName(IOpcPartUri* partName);
    HRESULT GetDocumentIndex(uint* fixedDocumentIndex);
    HRESULT GetDocumentName(IOpcPartUri* fixedDocumentName);
    HRESULT CreateRequest(const(wchar)* requestId, IXpsSignatureRequest* signatureRequest);
}

@GUID("F0253E68-9F19-412E-9B4F-54D3B0AC6CD9")
interface IXpsSignatureRequestCollection : IUnknown
{
    HRESULT GetCount(uint* count);
    HRESULT GetAt(uint index, IXpsSignatureRequest* signatureRequest);
    HRESULT RemoveAt(uint index);
}

@GUID("AC58950B-7208-4B2D-B2C4-951083D3B8EB")
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

@GUID("D3E8D338-FDC4-4AFC-80B5-D532A1782EE1")
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
    HRESULT SavePackageToFile(const(wchar)* fileName, SECURITY_ATTRIBUTES* securityAttributes, 
                              uint flagsAndAttributes);
    HRESULT SavePackageToStream(IStream stream);
}

@GUID("1B8EFEC4-3019-4C27-964E-367202156906")
interface IPrintDocumentPackageTarget : IUnknown
{
    HRESULT GetPackageTargetTypes(uint* targetCount, char* targetTypes);
    HRESULT GetPackageTarget(const(GUID)* guidTargetType, const(GUID)* riid, void** ppvTarget);
    HRESULT Cancel();
}

@GUID("ED90C8AD-5C34-4D05-A1EC-0E8A9B3AD7AF")
interface IPrintDocumentPackageStatusEvent : IDispatch
{
    HRESULT PackageStatusUpdated(PrintDocumentPackageStatus* packageStatus);
}

@GUID("D2959BF7-B31B-4A3D-9600-712EB1335BA4")
interface IPrintDocumentPackageTargetFactory : IUnknown
{
    HRESULT CreateDocumentPackageTargetForPrintJob(const(wchar)* printerName, const(wchar)* jobName, 
                                                   IStream jobOutputStream, IStream jobPrintTicketStream, 
                                                   IPrintDocumentPackageTarget* docPackageTarget);
}


// GUIDs

const GUID CLSID_PrintDocumentPackageTarget        = GUIDOF!PrintDocumentPackageTarget;
const GUID CLSID_PrintDocumentPackageTargetFactory = GUIDOF!PrintDocumentPackageTargetFactory;
const GUID CLSID_XpsOMObjectFactory                = GUIDOF!XpsOMObjectFactory;
const GUID CLSID_XpsOMThumbnailGenerator           = GUIDOF!XpsOMThumbnailGenerator;
const GUID CLSID_XpsSignatureManager               = GUIDOF!XpsSignatureManager;

const GUID IID_IPrintDocumentPackageStatusEvent         = GUIDOF!IPrintDocumentPackageStatusEvent;
const GUID IID_IPrintDocumentPackageTarget              = GUIDOF!IPrintDocumentPackageTarget;
const GUID IID_IPrintDocumentPackageTargetFactory       = GUIDOF!IPrintDocumentPackageTargetFactory;
const GUID IID_IXpsDocumentPackageTarget                = GUIDOF!IXpsDocumentPackageTarget;
const GUID IID_IXpsDocumentPackageTarget3D              = GUIDOF!IXpsDocumentPackageTarget3D;
const GUID IID_IXpsOMBrush                              = GUIDOF!IXpsOMBrush;
const GUID IID_IXpsOMCanvas                             = GUIDOF!IXpsOMCanvas;
const GUID IID_IXpsOMColorProfileResource               = GUIDOF!IXpsOMColorProfileResource;
const GUID IID_IXpsOMColorProfileResourceCollection     = GUIDOF!IXpsOMColorProfileResourceCollection;
const GUID IID_IXpsOMCoreProperties                     = GUIDOF!IXpsOMCoreProperties;
const GUID IID_IXpsOMDashCollection                     = GUIDOF!IXpsOMDashCollection;
const GUID IID_IXpsOMDictionary                         = GUIDOF!IXpsOMDictionary;
const GUID IID_IXpsOMDocument                           = GUIDOF!IXpsOMDocument;
const GUID IID_IXpsOMDocumentCollection                 = GUIDOF!IXpsOMDocumentCollection;
const GUID IID_IXpsOMDocumentSequence                   = GUIDOF!IXpsOMDocumentSequence;
const GUID IID_IXpsOMDocumentStructureResource          = GUIDOF!IXpsOMDocumentStructureResource;
const GUID IID_IXpsOMFontResource                       = GUIDOF!IXpsOMFontResource;
const GUID IID_IXpsOMFontResourceCollection             = GUIDOF!IXpsOMFontResourceCollection;
const GUID IID_IXpsOMGeometry                           = GUIDOF!IXpsOMGeometry;
const GUID IID_IXpsOMGeometryFigure                     = GUIDOF!IXpsOMGeometryFigure;
const GUID IID_IXpsOMGeometryFigureCollection           = GUIDOF!IXpsOMGeometryFigureCollection;
const GUID IID_IXpsOMGlyphs                             = GUIDOF!IXpsOMGlyphs;
const GUID IID_IXpsOMGlyphsEditor                       = GUIDOF!IXpsOMGlyphsEditor;
const GUID IID_IXpsOMGradientBrush                      = GUIDOF!IXpsOMGradientBrush;
const GUID IID_IXpsOMGradientStop                       = GUIDOF!IXpsOMGradientStop;
const GUID IID_IXpsOMGradientStopCollection             = GUIDOF!IXpsOMGradientStopCollection;
const GUID IID_IXpsOMImageBrush                         = GUIDOF!IXpsOMImageBrush;
const GUID IID_IXpsOMImageResource                      = GUIDOF!IXpsOMImageResource;
const GUID IID_IXpsOMImageResourceCollection            = GUIDOF!IXpsOMImageResourceCollection;
const GUID IID_IXpsOMLinearGradientBrush                = GUIDOF!IXpsOMLinearGradientBrush;
const GUID IID_IXpsOMMatrixTransform                    = GUIDOF!IXpsOMMatrixTransform;
const GUID IID_IXpsOMNameCollection                     = GUIDOF!IXpsOMNameCollection;
const GUID IID_IXpsOMObjectFactory                      = GUIDOF!IXpsOMObjectFactory;
const GUID IID_IXpsOMObjectFactory1                     = GUIDOF!IXpsOMObjectFactory1;
const GUID IID_IXpsOMPackage                            = GUIDOF!IXpsOMPackage;
const GUID IID_IXpsOMPackage1                           = GUIDOF!IXpsOMPackage1;
const GUID IID_IXpsOMPackageTarget                      = GUIDOF!IXpsOMPackageTarget;
const GUID IID_IXpsOMPackageWriter                      = GUIDOF!IXpsOMPackageWriter;
const GUID IID_IXpsOMPackageWriter3D                    = GUIDOF!IXpsOMPackageWriter3D;
const GUID IID_IXpsOMPage                               = GUIDOF!IXpsOMPage;
const GUID IID_IXpsOMPage1                              = GUIDOF!IXpsOMPage1;
const GUID IID_IXpsOMPageReference                      = GUIDOF!IXpsOMPageReference;
const GUID IID_IXpsOMPageReferenceCollection            = GUIDOF!IXpsOMPageReferenceCollection;
const GUID IID_IXpsOMPart                               = GUIDOF!IXpsOMPart;
const GUID IID_IXpsOMPartResources                      = GUIDOF!IXpsOMPartResources;
const GUID IID_IXpsOMPartUriCollection                  = GUIDOF!IXpsOMPartUriCollection;
const GUID IID_IXpsOMPath                               = GUIDOF!IXpsOMPath;
const GUID IID_IXpsOMPrintTicketResource                = GUIDOF!IXpsOMPrintTicketResource;
const GUID IID_IXpsOMRadialGradientBrush                = GUIDOF!IXpsOMRadialGradientBrush;
const GUID IID_IXpsOMRemoteDictionaryResource           = GUIDOF!IXpsOMRemoteDictionaryResource;
const GUID IID_IXpsOMRemoteDictionaryResource1          = GUIDOF!IXpsOMRemoteDictionaryResource1;
const GUID IID_IXpsOMRemoteDictionaryResourceCollection = GUIDOF!IXpsOMRemoteDictionaryResourceCollection;
const GUID IID_IXpsOMResource                           = GUIDOF!IXpsOMResource;
const GUID IID_IXpsOMShareable                          = GUIDOF!IXpsOMShareable;
const GUID IID_IXpsOMSignatureBlockResource             = GUIDOF!IXpsOMSignatureBlockResource;
const GUID IID_IXpsOMSignatureBlockResourceCollection   = GUIDOF!IXpsOMSignatureBlockResourceCollection;
const GUID IID_IXpsOMSolidColorBrush                    = GUIDOF!IXpsOMSolidColorBrush;
const GUID IID_IXpsOMStoryFragmentsResource             = GUIDOF!IXpsOMStoryFragmentsResource;
const GUID IID_IXpsOMThumbnailGenerator                 = GUIDOF!IXpsOMThumbnailGenerator;
const GUID IID_IXpsOMTileBrush                          = GUIDOF!IXpsOMTileBrush;
const GUID IID_IXpsOMVisual                             = GUIDOF!IXpsOMVisual;
const GUID IID_IXpsOMVisualBrush                        = GUIDOF!IXpsOMVisualBrush;
const GUID IID_IXpsOMVisualCollection                   = GUIDOF!IXpsOMVisualCollection;
const GUID IID_IXpsSignature                            = GUIDOF!IXpsSignature;
const GUID IID_IXpsSignatureBlock                       = GUIDOF!IXpsSignatureBlock;
const GUID IID_IXpsSignatureBlockCollection             = GUIDOF!IXpsSignatureBlockCollection;
const GUID IID_IXpsSignatureCollection                  = GUIDOF!IXpsSignatureCollection;
const GUID IID_IXpsSignatureManager                     = GUIDOF!IXpsSignatureManager;
const GUID IID_IXpsSignatureRequest                     = GUIDOF!IXpsSignatureRequest;
const GUID IID_IXpsSignatureRequestCollection           = GUIDOF!IXpsSignatureRequestCollection;
const GUID IID_IXpsSigningOptions                       = GUIDOF!IXpsSigningOptions;
