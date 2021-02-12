module windows.direct2d;

public import system;
public import windows.com;
public import windows.direct3d11;
public import windows.direct3d9;
public import windows.directwrite;
public import windows.displaydevices;
public import windows.dxgi;
public import windows.gdi;
public import windows.kernel;
public import windows.structuredstorage;
public import windows.systemservices;
public import windows.windowsandmessaging;
public import windows.windowsimagingcomponent;
public import windows.xps;

extern(Windows):

struct PALETTEENTRY
{
    ubyte peRed;
    ubyte peGreen;
    ubyte peBlue;
    ubyte peFlags;
}

enum D2D1_ALPHA_MODE
{
    D2D1_ALPHA_MODE_UNKNOWN = 0,
    D2D1_ALPHA_MODE_PREMULTIPLIED = 1,
    D2D1_ALPHA_MODE_STRAIGHT = 2,
    D2D1_ALPHA_MODE_IGNORE = 3,
    D2D1_ALPHA_MODE_FORCE_DWORD = 4294967295,
}

struct D2D1_PIXEL_FORMAT
{
    DXGI_FORMAT format;
    D2D1_ALPHA_MODE alphaMode;
}

struct D2D_POINT_2U
{
    uint x;
    uint y;
}

struct D2D_POINT_2F
{
    float x;
    float y;
}

struct D2D_VECTOR_2F
{
    float x;
    float y;
}

struct D2D_VECTOR_3F
{
    float x;
    float y;
    float z;
}

struct D2D_VECTOR_4F
{
    float x;
    float y;
    float z;
    float w;
}

struct D2D_RECT_F
{
    float left;
    float top;
    float right;
    float bottom;
}

struct D2D_RECT_U
{
    uint left;
    uint top;
    uint right;
    uint bottom;
}

struct D2D_SIZE_F
{
    float width;
    float height;
}

struct D2D_SIZE_U
{
    uint width;
    uint height;
}

struct D2D_MATRIX_3X2_F
{
    _Anonymous_e__Union Anonymous;
}

struct D2D_MATRIX_4X3_F
{
    _Anonymous_e__Union Anonymous;
}

struct D2D_MATRIX_4X4_F
{
    _Anonymous_e__Union Anonymous;
}

struct D2D_MATRIX_5X4_F
{
    _Anonymous_e__Union Anonymous;
}

enum D2D1_INTERPOLATION_MODE_DEFINITION
{
    D2D1_INTERPOLATION_MODE_DEFINITION_NEAREST_NEIGHBOR = 0,
    D2D1_INTERPOLATION_MODE_DEFINITION_LINEAR = 1,
    D2D1_INTERPOLATION_MODE_DEFINITION_CUBIC = 2,
    D2D1_INTERPOLATION_MODE_DEFINITION_MULTI_SAMPLE_LINEAR = 3,
    D2D1_INTERPOLATION_MODE_DEFINITION_ANISOTROPIC = 4,
    D2D1_INTERPOLATION_MODE_DEFINITION_HIGH_QUALITY_CUBIC = 5,
    D2D1_INTERPOLATION_MODE_DEFINITION_FANT = 6,
    D2D1_INTERPOLATION_MODE_DEFINITION_MIPMAP_LINEAR = 7,
}

enum D2D1_GAMMA
{
    D2D1_GAMMA_2_2 = 0,
    D2D1_GAMMA_1_0 = 1,
    D2D1_GAMMA_FORCE_DWORD = 4294967295,
}

enum D2D1_OPACITY_MASK_CONTENT
{
    D2D1_OPACITY_MASK_CONTENT_GRAPHICS = 0,
    D2D1_OPACITY_MASK_CONTENT_TEXT_NATURAL = 1,
    D2D1_OPACITY_MASK_CONTENT_TEXT_GDI_COMPATIBLE = 2,
    D2D1_OPACITY_MASK_CONTENT_FORCE_DWORD = 4294967295,
}

enum D2D1_EXTEND_MODE
{
    D2D1_EXTEND_MODE_CLAMP = 0,
    D2D1_EXTEND_MODE_WRAP = 1,
    D2D1_EXTEND_MODE_MIRROR = 2,
    D2D1_EXTEND_MODE_FORCE_DWORD = 4294967295,
}

enum D2D1_ANTIALIAS_MODE
{
    D2D1_ANTIALIAS_MODE_PER_PRIMITIVE = 0,
    D2D1_ANTIALIAS_MODE_ALIASED = 1,
    D2D1_ANTIALIAS_MODE_FORCE_DWORD = 4294967295,
}

enum D2D1_TEXT_ANTIALIAS_MODE
{
    D2D1_TEXT_ANTIALIAS_MODE_DEFAULT = 0,
    D2D1_TEXT_ANTIALIAS_MODE_CLEARTYPE = 1,
    D2D1_TEXT_ANTIALIAS_MODE_GRAYSCALE = 2,
    D2D1_TEXT_ANTIALIAS_MODE_ALIASED = 3,
    D2D1_TEXT_ANTIALIAS_MODE_FORCE_DWORD = 4294967295,
}

enum D2D1_BITMAP_INTERPOLATION_MODE
{
    D2D1_BITMAP_INTERPOLATION_MODE_NEAREST_NEIGHBOR = 0,
    D2D1_BITMAP_INTERPOLATION_MODE_LINEAR = 1,
    D2D1_BITMAP_INTERPOLATION_MODE_FORCE_DWORD = 4294967295,
}

enum D2D1_DRAW_TEXT_OPTIONS
{
    D2D1_DRAW_TEXT_OPTIONS_NO_SNAP = 1,
    D2D1_DRAW_TEXT_OPTIONS_CLIP = 2,
    D2D1_DRAW_TEXT_OPTIONS_ENABLE_COLOR_FONT = 4,
    D2D1_DRAW_TEXT_OPTIONS_DISABLE_COLOR_BITMAP_SNAPPING = 8,
    D2D1_DRAW_TEXT_OPTIONS_NONE = 0,
    D2D1_DRAW_TEXT_OPTIONS_FORCE_DWORD = 4294967295,
}

struct D2D1_BITMAP_PROPERTIES
{
    D2D1_PIXEL_FORMAT pixelFormat;
    float dpiX;
    float dpiY;
}

struct D2D1_GRADIENT_STOP
{
    float position;
    DXGI_RGBA color;
}

struct D2D1_BRUSH_PROPERTIES
{
    float opacity;
    D2D_MATRIX_3X2_F transform;
}

struct D2D1_BITMAP_BRUSH_PROPERTIES
{
    D2D1_EXTEND_MODE extendModeX;
    D2D1_EXTEND_MODE extendModeY;
    D2D1_BITMAP_INTERPOLATION_MODE interpolationMode;
}

struct D2D1_LINEAR_GRADIENT_BRUSH_PROPERTIES
{
    D2D_POINT_2F startPoint;
    D2D_POINT_2F endPoint;
}

struct D2D1_RADIAL_GRADIENT_BRUSH_PROPERTIES
{
    D2D_POINT_2F center;
    D2D_POINT_2F gradientOriginOffset;
    float radiusX;
    float radiusY;
}

enum D2D1_ARC_SIZE
{
    D2D1_ARC_SIZE_SMALL = 0,
    D2D1_ARC_SIZE_LARGE = 1,
    D2D1_ARC_SIZE_FORCE_DWORD = 4294967295,
}

enum D2D1_CAP_STYLE
{
    D2D1_CAP_STYLE_FLAT = 0,
    D2D1_CAP_STYLE_SQUARE = 1,
    D2D1_CAP_STYLE_ROUND = 2,
    D2D1_CAP_STYLE_TRIANGLE = 3,
    D2D1_CAP_STYLE_FORCE_DWORD = 4294967295,
}

enum D2D1_DASH_STYLE
{
    D2D1_DASH_STYLE_SOLID = 0,
    D2D1_DASH_STYLE_DASH = 1,
    D2D1_DASH_STYLE_DOT = 2,
    D2D1_DASH_STYLE_DASH_DOT = 3,
    D2D1_DASH_STYLE_DASH_DOT_DOT = 4,
    D2D1_DASH_STYLE_CUSTOM = 5,
    D2D1_DASH_STYLE_FORCE_DWORD = 4294967295,
}

enum D2D1_LINE_JOIN
{
    D2D1_LINE_JOIN_MITER = 0,
    D2D1_LINE_JOIN_BEVEL = 1,
    D2D1_LINE_JOIN_ROUND = 2,
    D2D1_LINE_JOIN_MITER_OR_BEVEL = 3,
    D2D1_LINE_JOIN_FORCE_DWORD = 4294967295,
}

enum D2D1_COMBINE_MODE
{
    D2D1_COMBINE_MODE_UNION = 0,
    D2D1_COMBINE_MODE_INTERSECT = 1,
    D2D1_COMBINE_MODE_XOR = 2,
    D2D1_COMBINE_MODE_EXCLUDE = 3,
    D2D1_COMBINE_MODE_FORCE_DWORD = 4294967295,
}

enum D2D1_GEOMETRY_RELATION
{
    D2D1_GEOMETRY_RELATION_UNKNOWN = 0,
    D2D1_GEOMETRY_RELATION_DISJOINT = 1,
    D2D1_GEOMETRY_RELATION_IS_CONTAINED = 2,
    D2D1_GEOMETRY_RELATION_CONTAINS = 3,
    D2D1_GEOMETRY_RELATION_OVERLAP = 4,
    D2D1_GEOMETRY_RELATION_FORCE_DWORD = 4294967295,
}

enum D2D1_GEOMETRY_SIMPLIFICATION_OPTION
{
    D2D1_GEOMETRY_SIMPLIFICATION_OPTION_CUBICS_AND_LINES = 0,
    D2D1_GEOMETRY_SIMPLIFICATION_OPTION_LINES = 1,
    D2D1_GEOMETRY_SIMPLIFICATION_OPTION_FORCE_DWORD = 4294967295,
}

enum D2D1_FIGURE_BEGIN
{
    D2D1_FIGURE_BEGIN_FILLED = 0,
    D2D1_FIGURE_BEGIN_HOLLOW = 1,
    D2D1_FIGURE_BEGIN_FORCE_DWORD = 4294967295,
}

enum D2D1_FIGURE_END
{
    D2D1_FIGURE_END_OPEN = 0,
    D2D1_FIGURE_END_CLOSED = 1,
    D2D1_FIGURE_END_FORCE_DWORD = 4294967295,
}

struct D2D1_BEZIER_SEGMENT
{
    D2D_POINT_2F point1;
    D2D_POINT_2F point2;
    D2D_POINT_2F point3;
}

struct D2D1_TRIANGLE
{
    D2D_POINT_2F point1;
    D2D_POINT_2F point2;
    D2D_POINT_2F point3;
}

enum D2D1_PATH_SEGMENT
{
    D2D1_PATH_SEGMENT_NONE = 0,
    D2D1_PATH_SEGMENT_FORCE_UNSTROKED = 1,
    D2D1_PATH_SEGMENT_FORCE_ROUND_LINE_JOIN = 2,
    D2D1_PATH_SEGMENT_FORCE_DWORD = 4294967295,
}

enum D2D1_SWEEP_DIRECTION
{
    D2D1_SWEEP_DIRECTION_COUNTER_CLOCKWISE = 0,
    D2D1_SWEEP_DIRECTION_CLOCKWISE = 1,
    D2D1_SWEEP_DIRECTION_FORCE_DWORD = 4294967295,
}

enum D2D1_FILL_MODE
{
    D2D1_FILL_MODE_ALTERNATE = 0,
    D2D1_FILL_MODE_WINDING = 1,
    D2D1_FILL_MODE_FORCE_DWORD = 4294967295,
}

struct D2D1_ARC_SEGMENT
{
    D2D_POINT_2F point;
    D2D_SIZE_F size;
    float rotationAngle;
    D2D1_SWEEP_DIRECTION sweepDirection;
    D2D1_ARC_SIZE arcSize;
}

struct D2D1_QUADRATIC_BEZIER_SEGMENT
{
    D2D_POINT_2F point1;
    D2D_POINT_2F point2;
}

struct D2D1_ELLIPSE
{
    D2D_POINT_2F point;
    float radiusX;
    float radiusY;
}

struct D2D1_ROUNDED_RECT
{
    D2D_RECT_F rect;
    float radiusX;
    float radiusY;
}

struct D2D1_STROKE_STYLE_PROPERTIES
{
    D2D1_CAP_STYLE startCap;
    D2D1_CAP_STYLE endCap;
    D2D1_CAP_STYLE dashCap;
    D2D1_LINE_JOIN lineJoin;
    float miterLimit;
    D2D1_DASH_STYLE dashStyle;
    float dashOffset;
}

enum D2D1_LAYER_OPTIONS
{
    D2D1_LAYER_OPTIONS_NONE = 0,
    D2D1_LAYER_OPTIONS_INITIALIZE_FOR_CLEARTYPE = 1,
    D2D1_LAYER_OPTIONS_FORCE_DWORD = 4294967295,
}

struct D2D1_LAYER_PARAMETERS
{
    D2D_RECT_F contentBounds;
    ID2D1Geometry geometricMask;
    D2D1_ANTIALIAS_MODE maskAntialiasMode;
    D2D_MATRIX_3X2_F maskTransform;
    float opacity;
    ID2D1Brush opacityBrush;
    D2D1_LAYER_OPTIONS layerOptions;
}

enum D2D1_WINDOW_STATE
{
    D2D1_WINDOW_STATE_NONE = 0,
    D2D1_WINDOW_STATE_OCCLUDED = 1,
    D2D1_WINDOW_STATE_FORCE_DWORD = 4294967295,
}

enum D2D1_RENDER_TARGET_TYPE
{
    D2D1_RENDER_TARGET_TYPE_DEFAULT = 0,
    D2D1_RENDER_TARGET_TYPE_SOFTWARE = 1,
    D2D1_RENDER_TARGET_TYPE_HARDWARE = 2,
    D2D1_RENDER_TARGET_TYPE_FORCE_DWORD = 4294967295,
}

enum D2D1_FEATURE_LEVEL
{
    D2D1_FEATURE_LEVEL_DEFAULT = 0,
    D2D1_FEATURE_LEVEL_9 = 37120,
    D2D1_FEATURE_LEVEL_10 = 40960,
    D2D1_FEATURE_LEVEL_FORCE_DWORD = 4294967295,
}

enum D2D1_RENDER_TARGET_USAGE
{
    D2D1_RENDER_TARGET_USAGE_NONE = 0,
    D2D1_RENDER_TARGET_USAGE_FORCE_BITMAP_REMOTING = 1,
    D2D1_RENDER_TARGET_USAGE_GDI_COMPATIBLE = 2,
    D2D1_RENDER_TARGET_USAGE_FORCE_DWORD = 4294967295,
}

enum D2D1_PRESENT_OPTIONS
{
    D2D1_PRESENT_OPTIONS_NONE = 0,
    D2D1_PRESENT_OPTIONS_RETAIN_CONTENTS = 1,
    D2D1_PRESENT_OPTIONS_IMMEDIATELY = 2,
    D2D1_PRESENT_OPTIONS_FORCE_DWORD = 4294967295,
}

struct D2D1_RENDER_TARGET_PROPERTIES
{
    D2D1_RENDER_TARGET_TYPE type;
    D2D1_PIXEL_FORMAT pixelFormat;
    float dpiX;
    float dpiY;
    D2D1_RENDER_TARGET_USAGE usage;
    D2D1_FEATURE_LEVEL minLevel;
}

struct D2D1_HWND_RENDER_TARGET_PROPERTIES
{
    HWND hwnd;
    D2D_SIZE_U pixelSize;
    D2D1_PRESENT_OPTIONS presentOptions;
}

enum D2D1_COMPATIBLE_RENDER_TARGET_OPTIONS
{
    D2D1_COMPATIBLE_RENDER_TARGET_OPTIONS_NONE = 0,
    D2D1_COMPATIBLE_RENDER_TARGET_OPTIONS_GDI_COMPATIBLE = 1,
    D2D1_COMPATIBLE_RENDER_TARGET_OPTIONS_FORCE_DWORD = 4294967295,
}

struct D2D1_DRAWING_STATE_DESCRIPTION
{
    D2D1_ANTIALIAS_MODE antialiasMode;
    D2D1_TEXT_ANTIALIAS_MODE textAntialiasMode;
    ulong tag1;
    ulong tag2;
    D2D_MATRIX_3X2_F transform;
}

enum D2D1_DC_INITIALIZE_MODE
{
    D2D1_DC_INITIALIZE_MODE_COPY = 0,
    D2D1_DC_INITIALIZE_MODE_CLEAR = 1,
    D2D1_DC_INITIALIZE_MODE_FORCE_DWORD = 4294967295,
}

enum D2D1_DEBUG_LEVEL
{
    D2D1_DEBUG_LEVEL_NONE = 0,
    D2D1_DEBUG_LEVEL_ERROR = 1,
    D2D1_DEBUG_LEVEL_WARNING = 2,
    D2D1_DEBUG_LEVEL_INFORMATION = 3,
    D2D1_DEBUG_LEVEL_FORCE_DWORD = 4294967295,
}

enum D2D1_FACTORY_TYPE
{
    D2D1_FACTORY_TYPE_SINGLE_THREADED = 0,
    D2D1_FACTORY_TYPE_MULTI_THREADED = 1,
    D2D1_FACTORY_TYPE_FORCE_DWORD = 4294967295,
}

struct D2D1_FACTORY_OPTIONS
{
    D2D1_DEBUG_LEVEL debugLevel;
}

const GUID IID_ID2D1Resource = {0x2CD90691, 0x12E2, 0x11DC, [0x9F, 0xED, 0x00, 0x11, 0x43, 0xA0, 0x55, 0xF9]};
@GUID(0x2CD90691, 0x12E2, 0x11DC, [0x9F, 0xED, 0x00, 0x11, 0x43, 0xA0, 0x55, 0xF9]);
interface ID2D1Resource : IUnknown
{
    void GetFactory(ID2D1Factory* factory);
}

const GUID IID_ID2D1Image = {0x65019F75, 0x8DA2, 0x497C, [0xB3, 0x2C, 0xDF, 0xA3, 0x4E, 0x48, 0xED, 0xE6]};
@GUID(0x65019F75, 0x8DA2, 0x497C, [0xB3, 0x2C, 0xDF, 0xA3, 0x4E, 0x48, 0xED, 0xE6]);
interface ID2D1Image : ID2D1Resource
{
}

const GUID IID_ID2D1Bitmap = {0xA2296057, 0xEA42, 0x4099, [0x98, 0x3B, 0x53, 0x9F, 0xB6, 0x50, 0x54, 0x26]};
@GUID(0xA2296057, 0xEA42, 0x4099, [0x98, 0x3B, 0x53, 0x9F, 0xB6, 0x50, 0x54, 0x26]);
interface ID2D1Bitmap : ID2D1Image
{
    D2D_SIZE_F GetSize();
    D2D_SIZE_U GetPixelSize();
    D2D1_PIXEL_FORMAT GetPixelFormat();
    void GetDpi(float* dpiX, float* dpiY);
    HRESULT CopyFromBitmap(const(D2D_POINT_2U)* destPoint, ID2D1Bitmap bitmap, const(D2D_RECT_U)* srcRect);
    HRESULT CopyFromRenderTarget(const(D2D_POINT_2U)* destPoint, ID2D1RenderTarget renderTarget, const(D2D_RECT_U)* srcRect);
    HRESULT CopyFromMemory(const(D2D_RECT_U)* dstRect, const(void)* srcData, uint pitch);
}

const GUID IID_ID2D1GradientStopCollection = {0x2CD906A7, 0x12E2, 0x11DC, [0x9F, 0xED, 0x00, 0x11, 0x43, 0xA0, 0x55, 0xF9]};
@GUID(0x2CD906A7, 0x12E2, 0x11DC, [0x9F, 0xED, 0x00, 0x11, 0x43, 0xA0, 0x55, 0xF9]);
interface ID2D1GradientStopCollection : ID2D1Resource
{
    uint GetGradientStopCount();
    void GetGradientStops(char* gradientStops, uint gradientStopsCount);
    D2D1_GAMMA GetColorInterpolationGamma();
    D2D1_EXTEND_MODE GetExtendMode();
}

const GUID IID_ID2D1Brush = {0x2CD906A8, 0x12E2, 0x11DC, [0x9F, 0xED, 0x00, 0x11, 0x43, 0xA0, 0x55, 0xF9]};
@GUID(0x2CD906A8, 0x12E2, 0x11DC, [0x9F, 0xED, 0x00, 0x11, 0x43, 0xA0, 0x55, 0xF9]);
interface ID2D1Brush : ID2D1Resource
{
    void SetOpacity(float opacity);
    void SetTransform(const(D2D_MATRIX_3X2_F)* transform);
    float GetOpacity();
    void GetTransform(D2D_MATRIX_3X2_F* transform);
}

const GUID IID_ID2D1BitmapBrush = {0x2CD906AA, 0x12E2, 0x11DC, [0x9F, 0xED, 0x00, 0x11, 0x43, 0xA0, 0x55, 0xF9]};
@GUID(0x2CD906AA, 0x12E2, 0x11DC, [0x9F, 0xED, 0x00, 0x11, 0x43, 0xA0, 0x55, 0xF9]);
interface ID2D1BitmapBrush : ID2D1Brush
{
    void SetExtendModeX(D2D1_EXTEND_MODE extendModeX);
    void SetExtendModeY(D2D1_EXTEND_MODE extendModeY);
    void SetInterpolationMode(D2D1_BITMAP_INTERPOLATION_MODE interpolationMode);
    void SetBitmap(ID2D1Bitmap bitmap);
    D2D1_EXTEND_MODE GetExtendModeX();
    D2D1_EXTEND_MODE GetExtendModeY();
    D2D1_BITMAP_INTERPOLATION_MODE GetInterpolationMode();
    void GetBitmap(ID2D1Bitmap* bitmap);
}

const GUID IID_ID2D1SolidColorBrush = {0x2CD906A9, 0x12E2, 0x11DC, [0x9F, 0xED, 0x00, 0x11, 0x43, 0xA0, 0x55, 0xF9]};
@GUID(0x2CD906A9, 0x12E2, 0x11DC, [0x9F, 0xED, 0x00, 0x11, 0x43, 0xA0, 0x55, 0xF9]);
interface ID2D1SolidColorBrush : ID2D1Brush
{
    void SetColor(const(DXGI_RGBA)* color);
    DXGI_RGBA GetColor();
}

const GUID IID_ID2D1LinearGradientBrush = {0x2CD906AB, 0x12E2, 0x11DC, [0x9F, 0xED, 0x00, 0x11, 0x43, 0xA0, 0x55, 0xF9]};
@GUID(0x2CD906AB, 0x12E2, 0x11DC, [0x9F, 0xED, 0x00, 0x11, 0x43, 0xA0, 0x55, 0xF9]);
interface ID2D1LinearGradientBrush : ID2D1Brush
{
    void SetStartPoint(D2D_POINT_2F startPoint);
    void SetEndPoint(D2D_POINT_2F endPoint);
    D2D_POINT_2F GetStartPoint();
    D2D_POINT_2F GetEndPoint();
    void GetGradientStopCollection(ID2D1GradientStopCollection* gradientStopCollection);
}

const GUID IID_ID2D1RadialGradientBrush = {0x2CD906AC, 0x12E2, 0x11DC, [0x9F, 0xED, 0x00, 0x11, 0x43, 0xA0, 0x55, 0xF9]};
@GUID(0x2CD906AC, 0x12E2, 0x11DC, [0x9F, 0xED, 0x00, 0x11, 0x43, 0xA0, 0x55, 0xF9]);
interface ID2D1RadialGradientBrush : ID2D1Brush
{
    void SetCenter(D2D_POINT_2F center);
    void SetGradientOriginOffset(D2D_POINT_2F gradientOriginOffset);
    void SetRadiusX(float radiusX);
    void SetRadiusY(float radiusY);
    D2D_POINT_2F GetCenter();
    D2D_POINT_2F GetGradientOriginOffset();
    float GetRadiusX();
    float GetRadiusY();
    void GetGradientStopCollection(ID2D1GradientStopCollection* gradientStopCollection);
}

const GUID IID_ID2D1StrokeStyle = {0x2CD9069D, 0x12E2, 0x11DC, [0x9F, 0xED, 0x00, 0x11, 0x43, 0xA0, 0x55, 0xF9]};
@GUID(0x2CD9069D, 0x12E2, 0x11DC, [0x9F, 0xED, 0x00, 0x11, 0x43, 0xA0, 0x55, 0xF9]);
interface ID2D1StrokeStyle : ID2D1Resource
{
    D2D1_CAP_STYLE GetStartCap();
    D2D1_CAP_STYLE GetEndCap();
    D2D1_CAP_STYLE GetDashCap();
    float GetMiterLimit();
    D2D1_LINE_JOIN GetLineJoin();
    float GetDashOffset();
    D2D1_DASH_STYLE GetDashStyle();
    uint GetDashesCount();
    void GetDashes(char* dashes, uint dashesCount);
}

const GUID IID_ID2D1Geometry = {0x2CD906A1, 0x12E2, 0x11DC, [0x9F, 0xED, 0x00, 0x11, 0x43, 0xA0, 0x55, 0xF9]};
@GUID(0x2CD906A1, 0x12E2, 0x11DC, [0x9F, 0xED, 0x00, 0x11, 0x43, 0xA0, 0x55, 0xF9]);
interface ID2D1Geometry : ID2D1Resource
{
    HRESULT GetBounds(const(D2D_MATRIX_3X2_F)* worldTransform, D2D_RECT_F* bounds);
    HRESULT GetWidenedBounds(float strokeWidth, ID2D1StrokeStyle strokeStyle, const(D2D_MATRIX_3X2_F)* worldTransform, float flatteningTolerance, D2D_RECT_F* bounds);
    HRESULT StrokeContainsPoint(D2D_POINT_2F point, float strokeWidth, ID2D1StrokeStyle strokeStyle, const(D2D_MATRIX_3X2_F)* worldTransform, float flatteningTolerance, int* contains);
    HRESULT FillContainsPoint(D2D_POINT_2F point, const(D2D_MATRIX_3X2_F)* worldTransform, float flatteningTolerance, int* contains);
    HRESULT CompareWithGeometry(ID2D1Geometry inputGeometry, const(D2D_MATRIX_3X2_F)* inputGeometryTransform, float flatteningTolerance, D2D1_GEOMETRY_RELATION* relation);
    HRESULT Simplify(D2D1_GEOMETRY_SIMPLIFICATION_OPTION simplificationOption, const(D2D_MATRIX_3X2_F)* worldTransform, float flatteningTolerance, ID2D1SimplifiedGeometrySink geometrySink);
    HRESULT Tessellate(const(D2D_MATRIX_3X2_F)* worldTransform, float flatteningTolerance, ID2D1TessellationSink tessellationSink);
    HRESULT CombineWithGeometry(ID2D1Geometry inputGeometry, D2D1_COMBINE_MODE combineMode, const(D2D_MATRIX_3X2_F)* inputGeometryTransform, float flatteningTolerance, ID2D1SimplifiedGeometrySink geometrySink);
    HRESULT Outline(const(D2D_MATRIX_3X2_F)* worldTransform, float flatteningTolerance, ID2D1SimplifiedGeometrySink geometrySink);
    HRESULT ComputeArea(const(D2D_MATRIX_3X2_F)* worldTransform, float flatteningTolerance, float* area);
    HRESULT ComputeLength(const(D2D_MATRIX_3X2_F)* worldTransform, float flatteningTolerance, float* length);
    HRESULT ComputePointAtLength(float length, const(D2D_MATRIX_3X2_F)* worldTransform, float flatteningTolerance, D2D_POINT_2F* point, D2D_POINT_2F* unitTangentVector);
    HRESULT Widen(float strokeWidth, ID2D1StrokeStyle strokeStyle, const(D2D_MATRIX_3X2_F)* worldTransform, float flatteningTolerance, ID2D1SimplifiedGeometrySink geometrySink);
}

const GUID IID_ID2D1RectangleGeometry = {0x2CD906A2, 0x12E2, 0x11DC, [0x9F, 0xED, 0x00, 0x11, 0x43, 0xA0, 0x55, 0xF9]};
@GUID(0x2CD906A2, 0x12E2, 0x11DC, [0x9F, 0xED, 0x00, 0x11, 0x43, 0xA0, 0x55, 0xF9]);
interface ID2D1RectangleGeometry : ID2D1Geometry
{
    void GetRect(D2D_RECT_F* rect);
}

const GUID IID_ID2D1RoundedRectangleGeometry = {0x2CD906A3, 0x12E2, 0x11DC, [0x9F, 0xED, 0x00, 0x11, 0x43, 0xA0, 0x55, 0xF9]};
@GUID(0x2CD906A3, 0x12E2, 0x11DC, [0x9F, 0xED, 0x00, 0x11, 0x43, 0xA0, 0x55, 0xF9]);
interface ID2D1RoundedRectangleGeometry : ID2D1Geometry
{
    void GetRoundedRect(D2D1_ROUNDED_RECT* roundedRect);
}

const GUID IID_ID2D1EllipseGeometry = {0x2CD906A4, 0x12E2, 0x11DC, [0x9F, 0xED, 0x00, 0x11, 0x43, 0xA0, 0x55, 0xF9]};
@GUID(0x2CD906A4, 0x12E2, 0x11DC, [0x9F, 0xED, 0x00, 0x11, 0x43, 0xA0, 0x55, 0xF9]);
interface ID2D1EllipseGeometry : ID2D1Geometry
{
    void GetEllipse(D2D1_ELLIPSE* ellipse);
}

const GUID IID_ID2D1GeometryGroup = {0x2CD906A6, 0x12E2, 0x11DC, [0x9F, 0xED, 0x00, 0x11, 0x43, 0xA0, 0x55, 0xF9]};
@GUID(0x2CD906A6, 0x12E2, 0x11DC, [0x9F, 0xED, 0x00, 0x11, 0x43, 0xA0, 0x55, 0xF9]);
interface ID2D1GeometryGroup : ID2D1Geometry
{
    D2D1_FILL_MODE GetFillMode();
    uint GetSourceGeometryCount();
    void GetSourceGeometries(char* geometries, uint geometriesCount);
}

const GUID IID_ID2D1TransformedGeometry = {0x2CD906BB, 0x12E2, 0x11DC, [0x9F, 0xED, 0x00, 0x11, 0x43, 0xA0, 0x55, 0xF9]};
@GUID(0x2CD906BB, 0x12E2, 0x11DC, [0x9F, 0xED, 0x00, 0x11, 0x43, 0xA0, 0x55, 0xF9]);
interface ID2D1TransformedGeometry : ID2D1Geometry
{
    void GetSourceGeometry(ID2D1Geometry* sourceGeometry);
    void GetTransform(D2D_MATRIX_3X2_F* transform);
}

const GUID IID_ID2D1SimplifiedGeometrySink = {0x2CD9069E, 0x12E2, 0x11DC, [0x9F, 0xED, 0x00, 0x11, 0x43, 0xA0, 0x55, 0xF9]};
@GUID(0x2CD9069E, 0x12E2, 0x11DC, [0x9F, 0xED, 0x00, 0x11, 0x43, 0xA0, 0x55, 0xF9]);
interface ID2D1SimplifiedGeometrySink : IUnknown
{
    void SetFillMode(D2D1_FILL_MODE fillMode);
    void SetSegmentFlags(D2D1_PATH_SEGMENT vertexFlags);
    void BeginFigure(D2D_POINT_2F startPoint, D2D1_FIGURE_BEGIN figureBegin);
    void AddLines(char* points, uint pointsCount);
    void AddBeziers(char* beziers, uint beziersCount);
    void EndFigure(D2D1_FIGURE_END figureEnd);
    HRESULT Close();
}

const GUID IID_ID2D1GeometrySink = {0x2CD9069F, 0x12E2, 0x11DC, [0x9F, 0xED, 0x00, 0x11, 0x43, 0xA0, 0x55, 0xF9]};
@GUID(0x2CD9069F, 0x12E2, 0x11DC, [0x9F, 0xED, 0x00, 0x11, 0x43, 0xA0, 0x55, 0xF9]);
interface ID2D1GeometrySink : ID2D1SimplifiedGeometrySink
{
    void AddLine(D2D_POINT_2F point);
    void AddBezier(const(D2D1_BEZIER_SEGMENT)* bezier);
    void AddQuadraticBezier(const(D2D1_QUADRATIC_BEZIER_SEGMENT)* bezier);
    void AddQuadraticBeziers(char* beziers, uint beziersCount);
    void AddArc(const(D2D1_ARC_SEGMENT)* arc);
}

const GUID IID_ID2D1TessellationSink = {0x2CD906C1, 0x12E2, 0x11DC, [0x9F, 0xED, 0x00, 0x11, 0x43, 0xA0, 0x55, 0xF9]};
@GUID(0x2CD906C1, 0x12E2, 0x11DC, [0x9F, 0xED, 0x00, 0x11, 0x43, 0xA0, 0x55, 0xF9]);
interface ID2D1TessellationSink : IUnknown
{
    void AddTriangles(char* triangles, uint trianglesCount);
    HRESULT Close();
}

const GUID IID_ID2D1PathGeometry = {0x2CD906A5, 0x12E2, 0x11DC, [0x9F, 0xED, 0x00, 0x11, 0x43, 0xA0, 0x55, 0xF9]};
@GUID(0x2CD906A5, 0x12E2, 0x11DC, [0x9F, 0xED, 0x00, 0x11, 0x43, 0xA0, 0x55, 0xF9]);
interface ID2D1PathGeometry : ID2D1Geometry
{
    HRESULT Open(ID2D1GeometrySink* geometrySink);
    HRESULT Stream(ID2D1GeometrySink geometrySink);
    HRESULT GetSegmentCount(uint* count);
    HRESULT GetFigureCount(uint* count);
}

const GUID IID_ID2D1Mesh = {0x2CD906C2, 0x12E2, 0x11DC, [0x9F, 0xED, 0x00, 0x11, 0x43, 0xA0, 0x55, 0xF9]};
@GUID(0x2CD906C2, 0x12E2, 0x11DC, [0x9F, 0xED, 0x00, 0x11, 0x43, 0xA0, 0x55, 0xF9]);
interface ID2D1Mesh : ID2D1Resource
{
    HRESULT Open(ID2D1TessellationSink* tessellationSink);
}

const GUID IID_ID2D1Layer = {0x2CD9069B, 0x12E2, 0x11DC, [0x9F, 0xED, 0x00, 0x11, 0x43, 0xA0, 0x55, 0xF9]};
@GUID(0x2CD9069B, 0x12E2, 0x11DC, [0x9F, 0xED, 0x00, 0x11, 0x43, 0xA0, 0x55, 0xF9]);
interface ID2D1Layer : ID2D1Resource
{
    D2D_SIZE_F GetSize();
}

const GUID IID_ID2D1DrawingStateBlock = {0x28506E39, 0xEBF6, 0x46A1, [0xBB, 0x47, 0xFD, 0x85, 0x56, 0x5A, 0xB9, 0x57]};
@GUID(0x28506E39, 0xEBF6, 0x46A1, [0xBB, 0x47, 0xFD, 0x85, 0x56, 0x5A, 0xB9, 0x57]);
interface ID2D1DrawingStateBlock : ID2D1Resource
{
    void GetDescription(D2D1_DRAWING_STATE_DESCRIPTION* stateDescription);
    void SetDescription(const(D2D1_DRAWING_STATE_DESCRIPTION)* stateDescription);
    void SetTextRenderingParams(IDWriteRenderingParams textRenderingParams);
    void GetTextRenderingParams(IDWriteRenderingParams* textRenderingParams);
}

const GUID IID_ID2D1RenderTarget = {0x2CD90694, 0x12E2, 0x11DC, [0x9F, 0xED, 0x00, 0x11, 0x43, 0xA0, 0x55, 0xF9]};
@GUID(0x2CD90694, 0x12E2, 0x11DC, [0x9F, 0xED, 0x00, 0x11, 0x43, 0xA0, 0x55, 0xF9]);
interface ID2D1RenderTarget : ID2D1Resource
{
    HRESULT CreateBitmap(D2D_SIZE_U size, const(void)* srcData, uint pitch, const(D2D1_BITMAP_PROPERTIES)* bitmapProperties, ID2D1Bitmap* bitmap);
    HRESULT CreateBitmapFromWicBitmap(IWICBitmapSource wicBitmapSource, const(D2D1_BITMAP_PROPERTIES)* bitmapProperties, ID2D1Bitmap* bitmap);
    HRESULT CreateSharedBitmap(const(Guid)* riid, void* data, const(D2D1_BITMAP_PROPERTIES)* bitmapProperties, ID2D1Bitmap* bitmap);
    HRESULT CreateBitmapBrush(ID2D1Bitmap bitmap, const(D2D1_BITMAP_BRUSH_PROPERTIES)* bitmapBrushProperties, const(D2D1_BRUSH_PROPERTIES)* brushProperties, ID2D1BitmapBrush* bitmapBrush);
    HRESULT CreateSolidColorBrush(const(DXGI_RGBA)* color, const(D2D1_BRUSH_PROPERTIES)* brushProperties, ID2D1SolidColorBrush* solidColorBrush);
    HRESULT CreateGradientStopCollection(char* gradientStops, uint gradientStopsCount, D2D1_GAMMA colorInterpolationGamma, D2D1_EXTEND_MODE extendMode, ID2D1GradientStopCollection* gradientStopCollection);
    HRESULT CreateLinearGradientBrush(const(D2D1_LINEAR_GRADIENT_BRUSH_PROPERTIES)* linearGradientBrushProperties, const(D2D1_BRUSH_PROPERTIES)* brushProperties, ID2D1GradientStopCollection gradientStopCollection, ID2D1LinearGradientBrush* linearGradientBrush);
    HRESULT CreateRadialGradientBrush(const(D2D1_RADIAL_GRADIENT_BRUSH_PROPERTIES)* radialGradientBrushProperties, const(D2D1_BRUSH_PROPERTIES)* brushProperties, ID2D1GradientStopCollection gradientStopCollection, ID2D1RadialGradientBrush* radialGradientBrush);
    HRESULT CreateCompatibleRenderTarget(const(D2D_SIZE_F)* desiredSize, const(D2D_SIZE_U)* desiredPixelSize, const(D2D1_PIXEL_FORMAT)* desiredFormat, D2D1_COMPATIBLE_RENDER_TARGET_OPTIONS options, ID2D1BitmapRenderTarget* bitmapRenderTarget);
    HRESULT CreateLayer(const(D2D_SIZE_F)* size, ID2D1Layer* layer);
    HRESULT CreateMesh(ID2D1Mesh* mesh);
    void DrawLine(D2D_POINT_2F point0, D2D_POINT_2F point1, ID2D1Brush brush, float strokeWidth, ID2D1StrokeStyle strokeStyle);
    void DrawRectangle(const(D2D_RECT_F)* rect, ID2D1Brush brush, float strokeWidth, ID2D1StrokeStyle strokeStyle);
    void FillRectangle(const(D2D_RECT_F)* rect, ID2D1Brush brush);
    void DrawRoundedRectangle(const(D2D1_ROUNDED_RECT)* roundedRect, ID2D1Brush brush, float strokeWidth, ID2D1StrokeStyle strokeStyle);
    void FillRoundedRectangle(const(D2D1_ROUNDED_RECT)* roundedRect, ID2D1Brush brush);
    void DrawEllipse(const(D2D1_ELLIPSE)* ellipse, ID2D1Brush brush, float strokeWidth, ID2D1StrokeStyle strokeStyle);
    void FillEllipse(const(D2D1_ELLIPSE)* ellipse, ID2D1Brush brush);
    void DrawGeometry(ID2D1Geometry geometry, ID2D1Brush brush, float strokeWidth, ID2D1StrokeStyle strokeStyle);
    void FillGeometry(ID2D1Geometry geometry, ID2D1Brush brush, ID2D1Brush opacityBrush);
    void FillMesh(ID2D1Mesh mesh, ID2D1Brush brush);
    void FillOpacityMask(ID2D1Bitmap opacityMask, ID2D1Brush brush, D2D1_OPACITY_MASK_CONTENT content, const(D2D_RECT_F)* destinationRectangle, const(D2D_RECT_F)* sourceRectangle);
    void DrawBitmap(ID2D1Bitmap bitmap, const(D2D_RECT_F)* destinationRectangle, float opacity, D2D1_BITMAP_INTERPOLATION_MODE interpolationMode, const(D2D_RECT_F)* sourceRectangle);
    void DrawTextA(const(wchar)* string, uint stringLength, IDWriteTextFormat textFormat, const(D2D_RECT_F)* layoutRect, ID2D1Brush defaultFillBrush, D2D1_DRAW_TEXT_OPTIONS options, DWRITE_MEASURING_MODE measuringMode);
    void DrawTextLayout(D2D_POINT_2F origin, IDWriteTextLayout textLayout, ID2D1Brush defaultFillBrush, D2D1_DRAW_TEXT_OPTIONS options);
    void DrawGlyphRun(D2D_POINT_2F baselineOrigin, const(DWRITE_GLYPH_RUN)* glyphRun, ID2D1Brush foregroundBrush, DWRITE_MEASURING_MODE measuringMode);
    void SetTransform(const(D2D_MATRIX_3X2_F)* transform);
    void GetTransform(D2D_MATRIX_3X2_F* transform);
    void SetAntialiasMode(D2D1_ANTIALIAS_MODE antialiasMode);
    D2D1_ANTIALIAS_MODE GetAntialiasMode();
    void SetTextAntialiasMode(D2D1_TEXT_ANTIALIAS_MODE textAntialiasMode);
    D2D1_TEXT_ANTIALIAS_MODE GetTextAntialiasMode();
    void SetTextRenderingParams(IDWriteRenderingParams textRenderingParams);
    void GetTextRenderingParams(IDWriteRenderingParams* textRenderingParams);
    void SetTags(ulong tag1, ulong tag2);
    void GetTags(ulong* tag1, ulong* tag2);
    void PushLayer(const(D2D1_LAYER_PARAMETERS)* layerParameters, ID2D1Layer layer);
    void PopLayer();
    HRESULT Flush(ulong* tag1, ulong* tag2);
    void SaveDrawingState(ID2D1DrawingStateBlock drawingStateBlock);
    void RestoreDrawingState(ID2D1DrawingStateBlock drawingStateBlock);
    void PushAxisAlignedClip(const(D2D_RECT_F)* clipRect, D2D1_ANTIALIAS_MODE antialiasMode);
    void PopAxisAlignedClip();
    void Clear(const(DXGI_RGBA)* clearColor);
    void BeginDraw();
    HRESULT EndDraw(ulong* tag1, ulong* tag2);
    D2D1_PIXEL_FORMAT GetPixelFormat();
    void SetDpi(float dpiX, float dpiY);
    void GetDpi(float* dpiX, float* dpiY);
    D2D_SIZE_F GetSize();
    D2D_SIZE_U GetPixelSize();
    uint GetMaximumBitmapSize();
    BOOL IsSupported(const(D2D1_RENDER_TARGET_PROPERTIES)* renderTargetProperties);
}

const GUID IID_ID2D1BitmapRenderTarget = {0x2CD90695, 0x12E2, 0x11DC, [0x9F, 0xED, 0x00, 0x11, 0x43, 0xA0, 0x55, 0xF9]};
@GUID(0x2CD90695, 0x12E2, 0x11DC, [0x9F, 0xED, 0x00, 0x11, 0x43, 0xA0, 0x55, 0xF9]);
interface ID2D1BitmapRenderTarget : ID2D1RenderTarget
{
    HRESULT GetBitmap(ID2D1Bitmap* bitmap);
}

const GUID IID_ID2D1HwndRenderTarget = {0x2CD90698, 0x12E2, 0x11DC, [0x9F, 0xED, 0x00, 0x11, 0x43, 0xA0, 0x55, 0xF9]};
@GUID(0x2CD90698, 0x12E2, 0x11DC, [0x9F, 0xED, 0x00, 0x11, 0x43, 0xA0, 0x55, 0xF9]);
interface ID2D1HwndRenderTarget : ID2D1RenderTarget
{
    D2D1_WINDOW_STATE CheckWindowState();
    HRESULT Resize(const(D2D_SIZE_U)* pixelSize);
    HWND GetHwnd();
}

const GUID IID_ID2D1GdiInteropRenderTarget = {0xE0DB51C3, 0x6F77, 0x4BAE, [0xB3, 0xD5, 0xE4, 0x75, 0x09, 0xB3, 0x58, 0x38]};
@GUID(0xE0DB51C3, 0x6F77, 0x4BAE, [0xB3, 0xD5, 0xE4, 0x75, 0x09, 0xB3, 0x58, 0x38]);
interface ID2D1GdiInteropRenderTarget : IUnknown
{
    HRESULT GetDC(D2D1_DC_INITIALIZE_MODE mode, HDC* hdc);
    HRESULT ReleaseDC(const(RECT)* update);
}

const GUID IID_ID2D1DCRenderTarget = {0x1C51BC64, 0xDE61, 0x46FD, [0x98, 0x99, 0x63, 0xA5, 0xD8, 0xF0, 0x39, 0x50]};
@GUID(0x1C51BC64, 0xDE61, 0x46FD, [0x98, 0x99, 0x63, 0xA5, 0xD8, 0xF0, 0x39, 0x50]);
interface ID2D1DCRenderTarget : ID2D1RenderTarget
{
    HRESULT BindDC(const(int) hDC, const(RECT)* pSubRect);
}

const GUID IID_ID2D1Factory = {0x06152247, 0x6F50, 0x465A, [0x92, 0x45, 0x11, 0x8B, 0xFD, 0x3B, 0x60, 0x07]};
@GUID(0x06152247, 0x6F50, 0x465A, [0x92, 0x45, 0x11, 0x8B, 0xFD, 0x3B, 0x60, 0x07]);
interface ID2D1Factory : IUnknown
{
    HRESULT ReloadSystemMetrics();
    void GetDesktopDpi(float* dpiX, float* dpiY);
    HRESULT CreateRectangleGeometry(const(D2D_RECT_F)* rectangle, ID2D1RectangleGeometry* rectangleGeometry);
    HRESULT CreateRoundedRectangleGeometry(const(D2D1_ROUNDED_RECT)* roundedRectangle, ID2D1RoundedRectangleGeometry* roundedRectangleGeometry);
    HRESULT CreateEllipseGeometry(const(D2D1_ELLIPSE)* ellipse, ID2D1EllipseGeometry* ellipseGeometry);
    HRESULT CreateGeometryGroup(D2D1_FILL_MODE fillMode, char* geometries, uint geometriesCount, ID2D1GeometryGroup* geometryGroup);
    HRESULT CreateTransformedGeometry(ID2D1Geometry sourceGeometry, const(D2D_MATRIX_3X2_F)* transform, ID2D1TransformedGeometry* transformedGeometry);
    HRESULT CreatePathGeometry(ID2D1PathGeometry* pathGeometry);
    HRESULT CreateStrokeStyle(const(D2D1_STROKE_STYLE_PROPERTIES)* strokeStyleProperties, char* dashes, uint dashesCount, ID2D1StrokeStyle* strokeStyle);
    HRESULT CreateDrawingStateBlock(const(D2D1_DRAWING_STATE_DESCRIPTION)* drawingStateDescription, IDWriteRenderingParams textRenderingParams, ID2D1DrawingStateBlock* drawingStateBlock);
    HRESULT CreateWicBitmapRenderTarget(IWICBitmap target, const(D2D1_RENDER_TARGET_PROPERTIES)* renderTargetProperties, ID2D1RenderTarget* renderTarget);
    HRESULT CreateHwndRenderTarget(const(D2D1_RENDER_TARGET_PROPERTIES)* renderTargetProperties, const(D2D1_HWND_RENDER_TARGET_PROPERTIES)* hwndRenderTargetProperties, ID2D1HwndRenderTarget* hwndRenderTarget);
    HRESULT CreateDxgiSurfaceRenderTarget(IDXGISurface dxgiSurface, const(D2D1_RENDER_TARGET_PROPERTIES)* renderTargetProperties, ID2D1RenderTarget* renderTarget);
    HRESULT CreateDCRenderTarget(const(D2D1_RENDER_TARGET_PROPERTIES)* renderTargetProperties, ID2D1DCRenderTarget* dcRenderTarget);
}

enum D2D1_BORDER_MODE
{
    D2D1_BORDER_MODE_SOFT = 0,
    D2D1_BORDER_MODE_HARD = 1,
    D2D1_BORDER_MODE_FORCE_DWORD = 4294967295,
}

enum D2D1_CHANNEL_SELECTOR
{
    D2D1_CHANNEL_SELECTOR_R = 0,
    D2D1_CHANNEL_SELECTOR_G = 1,
    D2D1_CHANNEL_SELECTOR_B = 2,
    D2D1_CHANNEL_SELECTOR_A = 3,
    D2D1_CHANNEL_SELECTOR_FORCE_DWORD = 4294967295,
}

enum D2D1_BITMAPSOURCE_ORIENTATION
{
    D2D1_BITMAPSOURCE_ORIENTATION_DEFAULT = 1,
    D2D1_BITMAPSOURCE_ORIENTATION_FLIP_HORIZONTAL = 2,
    D2D1_BITMAPSOURCE_ORIENTATION_ROTATE_CLOCKWISE180 = 3,
    D2D1_BITMAPSOURCE_ORIENTATION_ROTATE_CLOCKWISE180_FLIP_HORIZONTAL = 4,
    D2D1_BITMAPSOURCE_ORIENTATION_ROTATE_CLOCKWISE270_FLIP_HORIZONTAL = 5,
    D2D1_BITMAPSOURCE_ORIENTATION_ROTATE_CLOCKWISE90 = 6,
    D2D1_BITMAPSOURCE_ORIENTATION_ROTATE_CLOCKWISE90_FLIP_HORIZONTAL = 7,
    D2D1_BITMAPSOURCE_ORIENTATION_ROTATE_CLOCKWISE270 = 8,
    D2D1_BITMAPSOURCE_ORIENTATION_FORCE_DWORD = 4294967295,
}

enum D2D1_GAUSSIANBLUR_PROP
{
    D2D1_GAUSSIANBLUR_PROP_STANDARD_DEVIATION = 0,
    D2D1_GAUSSIANBLUR_PROP_OPTIMIZATION = 1,
    D2D1_GAUSSIANBLUR_PROP_BORDER_MODE = 2,
    D2D1_GAUSSIANBLUR_PROP_FORCE_DWORD = 4294967295,
}

enum D2D1_GAUSSIANBLUR_OPTIMIZATION
{
    D2D1_GAUSSIANBLUR_OPTIMIZATION_SPEED = 0,
    D2D1_GAUSSIANBLUR_OPTIMIZATION_BALANCED = 1,
    D2D1_GAUSSIANBLUR_OPTIMIZATION_QUALITY = 2,
    D2D1_GAUSSIANBLUR_OPTIMIZATION_FORCE_DWORD = 4294967295,
}

enum D2D1_DIRECTIONALBLUR_PROP
{
    D2D1_DIRECTIONALBLUR_PROP_STANDARD_DEVIATION = 0,
    D2D1_DIRECTIONALBLUR_PROP_ANGLE = 1,
    D2D1_DIRECTIONALBLUR_PROP_OPTIMIZATION = 2,
    D2D1_DIRECTIONALBLUR_PROP_BORDER_MODE = 3,
    D2D1_DIRECTIONALBLUR_PROP_FORCE_DWORD = 4294967295,
}

enum D2D1_DIRECTIONALBLUR_OPTIMIZATION
{
    D2D1_DIRECTIONALBLUR_OPTIMIZATION_SPEED = 0,
    D2D1_DIRECTIONALBLUR_OPTIMIZATION_BALANCED = 1,
    D2D1_DIRECTIONALBLUR_OPTIMIZATION_QUALITY = 2,
    D2D1_DIRECTIONALBLUR_OPTIMIZATION_FORCE_DWORD = 4294967295,
}

enum D2D1_SHADOW_PROP
{
    D2D1_SHADOW_PROP_BLUR_STANDARD_DEVIATION = 0,
    D2D1_SHADOW_PROP_COLOR = 1,
    D2D1_SHADOW_PROP_OPTIMIZATION = 2,
    D2D1_SHADOW_PROP_FORCE_DWORD = 4294967295,
}

enum D2D1_SHADOW_OPTIMIZATION
{
    D2D1_SHADOW_OPTIMIZATION_SPEED = 0,
    D2D1_SHADOW_OPTIMIZATION_BALANCED = 1,
    D2D1_SHADOW_OPTIMIZATION_QUALITY = 2,
    D2D1_SHADOW_OPTIMIZATION_FORCE_DWORD = 4294967295,
}

enum D2D1_BLEND_PROP
{
    D2D1_BLEND_PROP_MODE = 0,
    D2D1_BLEND_PROP_FORCE_DWORD = 4294967295,
}

enum D2D1_BLEND_MODE
{
    D2D1_BLEND_MODE_MULTIPLY = 0,
    D2D1_BLEND_MODE_SCREEN = 1,
    D2D1_BLEND_MODE_DARKEN = 2,
    D2D1_BLEND_MODE_LIGHTEN = 3,
    D2D1_BLEND_MODE_DISSOLVE = 4,
    D2D1_BLEND_MODE_COLOR_BURN = 5,
    D2D1_BLEND_MODE_LINEAR_BURN = 6,
    D2D1_BLEND_MODE_DARKER_COLOR = 7,
    D2D1_BLEND_MODE_LIGHTER_COLOR = 8,
    D2D1_BLEND_MODE_COLOR_DODGE = 9,
    D2D1_BLEND_MODE_LINEAR_DODGE = 10,
    D2D1_BLEND_MODE_OVERLAY = 11,
    D2D1_BLEND_MODE_SOFT_LIGHT = 12,
    D2D1_BLEND_MODE_HARD_LIGHT = 13,
    D2D1_BLEND_MODE_VIVID_LIGHT = 14,
    D2D1_BLEND_MODE_LINEAR_LIGHT = 15,
    D2D1_BLEND_MODE_PIN_LIGHT = 16,
    D2D1_BLEND_MODE_HARD_MIX = 17,
    D2D1_BLEND_MODE_DIFFERENCE = 18,
    D2D1_BLEND_MODE_EXCLUSION = 19,
    D2D1_BLEND_MODE_HUE = 20,
    D2D1_BLEND_MODE_SATURATION = 21,
    D2D1_BLEND_MODE_COLOR = 22,
    D2D1_BLEND_MODE_LUMINOSITY = 23,
    D2D1_BLEND_MODE_SUBTRACT = 24,
    D2D1_BLEND_MODE_DIVISION = 25,
    D2D1_BLEND_MODE_FORCE_DWORD = 4294967295,
}

enum D2D1_SATURATION_PROP
{
    D2D1_SATURATION_PROP_SATURATION = 0,
    D2D1_SATURATION_PROP_FORCE_DWORD = 4294967295,
}

enum D2D1_HUEROTATION_PROP
{
    D2D1_HUEROTATION_PROP_ANGLE = 0,
    D2D1_HUEROTATION_PROP_FORCE_DWORD = 4294967295,
}

enum D2D1_COLORMATRIX_PROP
{
    D2D1_COLORMATRIX_PROP_COLOR_MATRIX = 0,
    D2D1_COLORMATRIX_PROP_ALPHA_MODE = 1,
    D2D1_COLORMATRIX_PROP_CLAMP_OUTPUT = 2,
    D2D1_COLORMATRIX_PROP_FORCE_DWORD = 4294967295,
}

enum D2D1_COLORMATRIX_ALPHA_MODE
{
    D2D1_COLORMATRIX_ALPHA_MODE_PREMULTIPLIED = 1,
    D2D1_COLORMATRIX_ALPHA_MODE_STRAIGHT = 2,
    D2D1_COLORMATRIX_ALPHA_MODE_FORCE_DWORD = 4294967295,
}

enum D2D1_BITMAPSOURCE_PROP
{
    D2D1_BITMAPSOURCE_PROP_WIC_BITMAP_SOURCE = 0,
    D2D1_BITMAPSOURCE_PROP_SCALE = 1,
    D2D1_BITMAPSOURCE_PROP_INTERPOLATION_MODE = 2,
    D2D1_BITMAPSOURCE_PROP_ENABLE_DPI_CORRECTION = 3,
    D2D1_BITMAPSOURCE_PROP_ALPHA_MODE = 4,
    D2D1_BITMAPSOURCE_PROP_ORIENTATION = 5,
    D2D1_BITMAPSOURCE_PROP_FORCE_DWORD = 4294967295,
}

enum D2D1_BITMAPSOURCE_INTERPOLATION_MODE
{
    D2D1_BITMAPSOURCE_INTERPOLATION_MODE_NEAREST_NEIGHBOR = 0,
    D2D1_BITMAPSOURCE_INTERPOLATION_MODE_LINEAR = 1,
    D2D1_BITMAPSOURCE_INTERPOLATION_MODE_CUBIC = 2,
    D2D1_BITMAPSOURCE_INTERPOLATION_MODE_FANT = 6,
    D2D1_BITMAPSOURCE_INTERPOLATION_MODE_MIPMAP_LINEAR = 7,
    D2D1_BITMAPSOURCE_INTERPOLATION_MODE_FORCE_DWORD = 4294967295,
}

enum D2D1_BITMAPSOURCE_ALPHA_MODE
{
    D2D1_BITMAPSOURCE_ALPHA_MODE_PREMULTIPLIED = 1,
    D2D1_BITMAPSOURCE_ALPHA_MODE_STRAIGHT = 2,
    D2D1_BITMAPSOURCE_ALPHA_MODE_FORCE_DWORD = 4294967295,
}

enum D2D1_COMPOSITE_PROP
{
    D2D1_COMPOSITE_PROP_MODE = 0,
    D2D1_COMPOSITE_PROP_FORCE_DWORD = 4294967295,
}

enum D2D1_3DTRANSFORM_PROP
{
    D2D1_3DTRANSFORM_PROP_INTERPOLATION_MODE = 0,
    D2D1_3DTRANSFORM_PROP_BORDER_MODE = 1,
    D2D1_3DTRANSFORM_PROP_TRANSFORM_MATRIX = 2,
    D2D1_3DTRANSFORM_PROP_FORCE_DWORD = 4294967295,
}

enum D2D1_3DTRANSFORM_INTERPOLATION_MODE
{
    D2D1_3DTRANSFORM_INTERPOLATION_MODE_NEAREST_NEIGHBOR = 0,
    D2D1_3DTRANSFORM_INTERPOLATION_MODE_LINEAR = 1,
    D2D1_3DTRANSFORM_INTERPOLATION_MODE_CUBIC = 2,
    D2D1_3DTRANSFORM_INTERPOLATION_MODE_MULTI_SAMPLE_LINEAR = 3,
    D2D1_3DTRANSFORM_INTERPOLATION_MODE_ANISOTROPIC = 4,
    D2D1_3DTRANSFORM_INTERPOLATION_MODE_FORCE_DWORD = 4294967295,
}

enum D2D1_3DPERSPECTIVETRANSFORM_PROP
{
    D2D1_3DPERSPECTIVETRANSFORM_PROP_INTERPOLATION_MODE = 0,
    D2D1_3DPERSPECTIVETRANSFORM_PROP_BORDER_MODE = 1,
    D2D1_3DPERSPECTIVETRANSFORM_PROP_DEPTH = 2,
    D2D1_3DPERSPECTIVETRANSFORM_PROP_PERSPECTIVE_ORIGIN = 3,
    D2D1_3DPERSPECTIVETRANSFORM_PROP_LOCAL_OFFSET = 4,
    D2D1_3DPERSPECTIVETRANSFORM_PROP_GLOBAL_OFFSET = 5,
    D2D1_3DPERSPECTIVETRANSFORM_PROP_ROTATION_ORIGIN = 6,
    D2D1_3DPERSPECTIVETRANSFORM_PROP_ROTATION = 7,
    D2D1_3DPERSPECTIVETRANSFORM_PROP_FORCE_DWORD = 4294967295,
}

enum D2D1_3DPERSPECTIVETRANSFORM_INTERPOLATION_MODE
{
    D2D1_3DPERSPECTIVETRANSFORM_INTERPOLATION_MODE_NEAREST_NEIGHBOR = 0,
    D2D1_3DPERSPECTIVETRANSFORM_INTERPOLATION_MODE_LINEAR = 1,
    D2D1_3DPERSPECTIVETRANSFORM_INTERPOLATION_MODE_CUBIC = 2,
    D2D1_3DPERSPECTIVETRANSFORM_INTERPOLATION_MODE_MULTI_SAMPLE_LINEAR = 3,
    D2D1_3DPERSPECTIVETRANSFORM_INTERPOLATION_MODE_ANISOTROPIC = 4,
    D2D1_3DPERSPECTIVETRANSFORM_INTERPOLATION_MODE_FORCE_DWORD = 4294967295,
}

enum D2D1_2DAFFINETRANSFORM_PROP
{
    D2D1_2DAFFINETRANSFORM_PROP_INTERPOLATION_MODE = 0,
    D2D1_2DAFFINETRANSFORM_PROP_BORDER_MODE = 1,
    D2D1_2DAFFINETRANSFORM_PROP_TRANSFORM_MATRIX = 2,
    D2D1_2DAFFINETRANSFORM_PROP_SHARPNESS = 3,
    D2D1_2DAFFINETRANSFORM_PROP_FORCE_DWORD = 4294967295,
}

enum D2D1_2DAFFINETRANSFORM_INTERPOLATION_MODE
{
    D2D1_2DAFFINETRANSFORM_INTERPOLATION_MODE_NEAREST_NEIGHBOR = 0,
    D2D1_2DAFFINETRANSFORM_INTERPOLATION_MODE_LINEAR = 1,
    D2D1_2DAFFINETRANSFORM_INTERPOLATION_MODE_CUBIC = 2,
    D2D1_2DAFFINETRANSFORM_INTERPOLATION_MODE_MULTI_SAMPLE_LINEAR = 3,
    D2D1_2DAFFINETRANSFORM_INTERPOLATION_MODE_ANISOTROPIC = 4,
    D2D1_2DAFFINETRANSFORM_INTERPOLATION_MODE_HIGH_QUALITY_CUBIC = 5,
    D2D1_2DAFFINETRANSFORM_INTERPOLATION_MODE_FORCE_DWORD = 4294967295,
}

enum D2D1_DPICOMPENSATION_PROP
{
    D2D1_DPICOMPENSATION_PROP_INTERPOLATION_MODE = 0,
    D2D1_DPICOMPENSATION_PROP_BORDER_MODE = 1,
    D2D1_DPICOMPENSATION_PROP_INPUT_DPI = 2,
    D2D1_DPICOMPENSATION_PROP_FORCE_DWORD = 4294967295,
}

enum D2D1_DPICOMPENSATION_INTERPOLATION_MODE
{
    D2D1_DPICOMPENSATION_INTERPOLATION_MODE_NEAREST_NEIGHBOR = 0,
    D2D1_DPICOMPENSATION_INTERPOLATION_MODE_LINEAR = 1,
    D2D1_DPICOMPENSATION_INTERPOLATION_MODE_CUBIC = 2,
    D2D1_DPICOMPENSATION_INTERPOLATION_MODE_MULTI_SAMPLE_LINEAR = 3,
    D2D1_DPICOMPENSATION_INTERPOLATION_MODE_ANISOTROPIC = 4,
    D2D1_DPICOMPENSATION_INTERPOLATION_MODE_HIGH_QUALITY_CUBIC = 5,
    D2D1_DPICOMPENSATION_INTERPOLATION_MODE_FORCE_DWORD = 4294967295,
}

enum D2D1_SCALE_PROP
{
    D2D1_SCALE_PROP_SCALE = 0,
    D2D1_SCALE_PROP_CENTER_POINT = 1,
    D2D1_SCALE_PROP_INTERPOLATION_MODE = 2,
    D2D1_SCALE_PROP_BORDER_MODE = 3,
    D2D1_SCALE_PROP_SHARPNESS = 4,
    D2D1_SCALE_PROP_FORCE_DWORD = 4294967295,
}

enum D2D1_SCALE_INTERPOLATION_MODE
{
    D2D1_SCALE_INTERPOLATION_MODE_NEAREST_NEIGHBOR = 0,
    D2D1_SCALE_INTERPOLATION_MODE_LINEAR = 1,
    D2D1_SCALE_INTERPOLATION_MODE_CUBIC = 2,
    D2D1_SCALE_INTERPOLATION_MODE_MULTI_SAMPLE_LINEAR = 3,
    D2D1_SCALE_INTERPOLATION_MODE_ANISOTROPIC = 4,
    D2D1_SCALE_INTERPOLATION_MODE_HIGH_QUALITY_CUBIC = 5,
    D2D1_SCALE_INTERPOLATION_MODE_FORCE_DWORD = 4294967295,
}

enum D2D1_TURBULENCE_PROP
{
    D2D1_TURBULENCE_PROP_OFFSET = 0,
    D2D1_TURBULENCE_PROP_SIZE = 1,
    D2D1_TURBULENCE_PROP_BASE_FREQUENCY = 2,
    D2D1_TURBULENCE_PROP_NUM_OCTAVES = 3,
    D2D1_TURBULENCE_PROP_SEED = 4,
    D2D1_TURBULENCE_PROP_NOISE = 5,
    D2D1_TURBULENCE_PROP_STITCHABLE = 6,
    D2D1_TURBULENCE_PROP_FORCE_DWORD = 4294967295,
}

enum D2D1_TURBULENCE_NOISE
{
    D2D1_TURBULENCE_NOISE_FRACTAL_SUM = 0,
    D2D1_TURBULENCE_NOISE_TURBULENCE = 1,
    D2D1_TURBULENCE_NOISE_FORCE_DWORD = 4294967295,
}

enum D2D1_DISPLACEMENTMAP_PROP
{
    D2D1_DISPLACEMENTMAP_PROP_SCALE = 0,
    D2D1_DISPLACEMENTMAP_PROP_X_CHANNEL_SELECT = 1,
    D2D1_DISPLACEMENTMAP_PROP_Y_CHANNEL_SELECT = 2,
    D2D1_DISPLACEMENTMAP_PROP_FORCE_DWORD = 4294967295,
}

enum D2D1_COLORMANAGEMENT_PROP
{
    D2D1_COLORMANAGEMENT_PROP_SOURCE_COLOR_CONTEXT = 0,
    D2D1_COLORMANAGEMENT_PROP_SOURCE_RENDERING_INTENT = 1,
    D2D1_COLORMANAGEMENT_PROP_DESTINATION_COLOR_CONTEXT = 2,
    D2D1_COLORMANAGEMENT_PROP_DESTINATION_RENDERING_INTENT = 3,
    D2D1_COLORMANAGEMENT_PROP_ALPHA_MODE = 4,
    D2D1_COLORMANAGEMENT_PROP_QUALITY = 5,
    D2D1_COLORMANAGEMENT_PROP_FORCE_DWORD = 4294967295,
}

enum D2D1_COLORMANAGEMENT_ALPHA_MODE
{
    D2D1_COLORMANAGEMENT_ALPHA_MODE_PREMULTIPLIED = 1,
    D2D1_COLORMANAGEMENT_ALPHA_MODE_STRAIGHT = 2,
    D2D1_COLORMANAGEMENT_ALPHA_MODE_FORCE_DWORD = 4294967295,
}

enum D2D1_COLORMANAGEMENT_QUALITY
{
    D2D1_COLORMANAGEMENT_QUALITY_PROOF = 0,
    D2D1_COLORMANAGEMENT_QUALITY_NORMAL = 1,
    D2D1_COLORMANAGEMENT_QUALITY_BEST = 2,
    D2D1_COLORMANAGEMENT_QUALITY_FORCE_DWORD = 4294967295,
}

enum D2D1_COLORMANAGEMENT_RENDERING_INTENT
{
    D2D1_COLORMANAGEMENT_RENDERING_INTENT_PERCEPTUAL = 0,
    D2D1_COLORMANAGEMENT_RENDERING_INTENT_RELATIVE_COLORIMETRIC = 1,
    D2D1_COLORMANAGEMENT_RENDERING_INTENT_SATURATION = 2,
    D2D1_COLORMANAGEMENT_RENDERING_INTENT_ABSOLUTE_COLORIMETRIC = 3,
    D2D1_COLORMANAGEMENT_RENDERING_INTENT_FORCE_DWORD = 4294967295,
}

enum D2D1_HISTOGRAM_PROP
{
    D2D1_HISTOGRAM_PROP_NUM_BINS = 0,
    D2D1_HISTOGRAM_PROP_CHANNEL_SELECT = 1,
    D2D1_HISTOGRAM_PROP_HISTOGRAM_OUTPUT = 2,
    D2D1_HISTOGRAM_PROP_FORCE_DWORD = 4294967295,
}

enum D2D1_POINTSPECULAR_PROP
{
    D2D1_POINTSPECULAR_PROP_LIGHT_POSITION = 0,
    D2D1_POINTSPECULAR_PROP_SPECULAR_EXPONENT = 1,
    D2D1_POINTSPECULAR_PROP_SPECULAR_CONSTANT = 2,
    D2D1_POINTSPECULAR_PROP_SURFACE_SCALE = 3,
    D2D1_POINTSPECULAR_PROP_COLOR = 4,
    D2D1_POINTSPECULAR_PROP_KERNEL_UNIT_LENGTH = 5,
    D2D1_POINTSPECULAR_PROP_SCALE_MODE = 6,
    D2D1_POINTSPECULAR_PROP_FORCE_DWORD = 4294967295,
}

enum D2D1_POINTSPECULAR_SCALE_MODE
{
    D2D1_POINTSPECULAR_SCALE_MODE_NEAREST_NEIGHBOR = 0,
    D2D1_POINTSPECULAR_SCALE_MODE_LINEAR = 1,
    D2D1_POINTSPECULAR_SCALE_MODE_CUBIC = 2,
    D2D1_POINTSPECULAR_SCALE_MODE_MULTI_SAMPLE_LINEAR = 3,
    D2D1_POINTSPECULAR_SCALE_MODE_ANISOTROPIC = 4,
    D2D1_POINTSPECULAR_SCALE_MODE_HIGH_QUALITY_CUBIC = 5,
    D2D1_POINTSPECULAR_SCALE_MODE_FORCE_DWORD = 4294967295,
}

enum D2D1_SPOTSPECULAR_PROP
{
    D2D1_SPOTSPECULAR_PROP_LIGHT_POSITION = 0,
    D2D1_SPOTSPECULAR_PROP_POINTS_AT = 1,
    D2D1_SPOTSPECULAR_PROP_FOCUS = 2,
    D2D1_SPOTSPECULAR_PROP_LIMITING_CONE_ANGLE = 3,
    D2D1_SPOTSPECULAR_PROP_SPECULAR_EXPONENT = 4,
    D2D1_SPOTSPECULAR_PROP_SPECULAR_CONSTANT = 5,
    D2D1_SPOTSPECULAR_PROP_SURFACE_SCALE = 6,
    D2D1_SPOTSPECULAR_PROP_COLOR = 7,
    D2D1_SPOTSPECULAR_PROP_KERNEL_UNIT_LENGTH = 8,
    D2D1_SPOTSPECULAR_PROP_SCALE_MODE = 9,
    D2D1_SPOTSPECULAR_PROP_FORCE_DWORD = 4294967295,
}

enum D2D1_SPOTSPECULAR_SCALE_MODE
{
    D2D1_SPOTSPECULAR_SCALE_MODE_NEAREST_NEIGHBOR = 0,
    D2D1_SPOTSPECULAR_SCALE_MODE_LINEAR = 1,
    D2D1_SPOTSPECULAR_SCALE_MODE_CUBIC = 2,
    D2D1_SPOTSPECULAR_SCALE_MODE_MULTI_SAMPLE_LINEAR = 3,
    D2D1_SPOTSPECULAR_SCALE_MODE_ANISOTROPIC = 4,
    D2D1_SPOTSPECULAR_SCALE_MODE_HIGH_QUALITY_CUBIC = 5,
    D2D1_SPOTSPECULAR_SCALE_MODE_FORCE_DWORD = 4294967295,
}

enum D2D1_DISTANTSPECULAR_PROP
{
    D2D1_DISTANTSPECULAR_PROP_AZIMUTH = 0,
    D2D1_DISTANTSPECULAR_PROP_ELEVATION = 1,
    D2D1_DISTANTSPECULAR_PROP_SPECULAR_EXPONENT = 2,
    D2D1_DISTANTSPECULAR_PROP_SPECULAR_CONSTANT = 3,
    D2D1_DISTANTSPECULAR_PROP_SURFACE_SCALE = 4,
    D2D1_DISTANTSPECULAR_PROP_COLOR = 5,
    D2D1_DISTANTSPECULAR_PROP_KERNEL_UNIT_LENGTH = 6,
    D2D1_DISTANTSPECULAR_PROP_SCALE_MODE = 7,
    D2D1_DISTANTSPECULAR_PROP_FORCE_DWORD = 4294967295,
}

enum D2D1_DISTANTSPECULAR_SCALE_MODE
{
    D2D1_DISTANTSPECULAR_SCALE_MODE_NEAREST_NEIGHBOR = 0,
    D2D1_DISTANTSPECULAR_SCALE_MODE_LINEAR = 1,
    D2D1_DISTANTSPECULAR_SCALE_MODE_CUBIC = 2,
    D2D1_DISTANTSPECULAR_SCALE_MODE_MULTI_SAMPLE_LINEAR = 3,
    D2D1_DISTANTSPECULAR_SCALE_MODE_ANISOTROPIC = 4,
    D2D1_DISTANTSPECULAR_SCALE_MODE_HIGH_QUALITY_CUBIC = 5,
    D2D1_DISTANTSPECULAR_SCALE_MODE_FORCE_DWORD = 4294967295,
}

enum D2D1_POINTDIFFUSE_PROP
{
    D2D1_POINTDIFFUSE_PROP_LIGHT_POSITION = 0,
    D2D1_POINTDIFFUSE_PROP_DIFFUSE_CONSTANT = 1,
    D2D1_POINTDIFFUSE_PROP_SURFACE_SCALE = 2,
    D2D1_POINTDIFFUSE_PROP_COLOR = 3,
    D2D1_POINTDIFFUSE_PROP_KERNEL_UNIT_LENGTH = 4,
    D2D1_POINTDIFFUSE_PROP_SCALE_MODE = 5,
    D2D1_POINTDIFFUSE_PROP_FORCE_DWORD = 4294967295,
}

enum D2D1_POINTDIFFUSE_SCALE_MODE
{
    D2D1_POINTDIFFUSE_SCALE_MODE_NEAREST_NEIGHBOR = 0,
    D2D1_POINTDIFFUSE_SCALE_MODE_LINEAR = 1,
    D2D1_POINTDIFFUSE_SCALE_MODE_CUBIC = 2,
    D2D1_POINTDIFFUSE_SCALE_MODE_MULTI_SAMPLE_LINEAR = 3,
    D2D1_POINTDIFFUSE_SCALE_MODE_ANISOTROPIC = 4,
    D2D1_POINTDIFFUSE_SCALE_MODE_HIGH_QUALITY_CUBIC = 5,
    D2D1_POINTDIFFUSE_SCALE_MODE_FORCE_DWORD = 4294967295,
}

enum D2D1_SPOTDIFFUSE_PROP
{
    D2D1_SPOTDIFFUSE_PROP_LIGHT_POSITION = 0,
    D2D1_SPOTDIFFUSE_PROP_POINTS_AT = 1,
    D2D1_SPOTDIFFUSE_PROP_FOCUS = 2,
    D2D1_SPOTDIFFUSE_PROP_LIMITING_CONE_ANGLE = 3,
    D2D1_SPOTDIFFUSE_PROP_DIFFUSE_CONSTANT = 4,
    D2D1_SPOTDIFFUSE_PROP_SURFACE_SCALE = 5,
    D2D1_SPOTDIFFUSE_PROP_COLOR = 6,
    D2D1_SPOTDIFFUSE_PROP_KERNEL_UNIT_LENGTH = 7,
    D2D1_SPOTDIFFUSE_PROP_SCALE_MODE = 8,
    D2D1_SPOTDIFFUSE_PROP_FORCE_DWORD = 4294967295,
}

enum D2D1_SPOTDIFFUSE_SCALE_MODE
{
    D2D1_SPOTDIFFUSE_SCALE_MODE_NEAREST_NEIGHBOR = 0,
    D2D1_SPOTDIFFUSE_SCALE_MODE_LINEAR = 1,
    D2D1_SPOTDIFFUSE_SCALE_MODE_CUBIC = 2,
    D2D1_SPOTDIFFUSE_SCALE_MODE_MULTI_SAMPLE_LINEAR = 3,
    D2D1_SPOTDIFFUSE_SCALE_MODE_ANISOTROPIC = 4,
    D2D1_SPOTDIFFUSE_SCALE_MODE_HIGH_QUALITY_CUBIC = 5,
    D2D1_SPOTDIFFUSE_SCALE_MODE_FORCE_DWORD = 4294967295,
}

enum D2D1_DISTANTDIFFUSE_PROP
{
    D2D1_DISTANTDIFFUSE_PROP_AZIMUTH = 0,
    D2D1_DISTANTDIFFUSE_PROP_ELEVATION = 1,
    D2D1_DISTANTDIFFUSE_PROP_DIFFUSE_CONSTANT = 2,
    D2D1_DISTANTDIFFUSE_PROP_SURFACE_SCALE = 3,
    D2D1_DISTANTDIFFUSE_PROP_COLOR = 4,
    D2D1_DISTANTDIFFUSE_PROP_KERNEL_UNIT_LENGTH = 5,
    D2D1_DISTANTDIFFUSE_PROP_SCALE_MODE = 6,
    D2D1_DISTANTDIFFUSE_PROP_FORCE_DWORD = 4294967295,
}

enum D2D1_DISTANTDIFFUSE_SCALE_MODE
{
    D2D1_DISTANTDIFFUSE_SCALE_MODE_NEAREST_NEIGHBOR = 0,
    D2D1_DISTANTDIFFUSE_SCALE_MODE_LINEAR = 1,
    D2D1_DISTANTDIFFUSE_SCALE_MODE_CUBIC = 2,
    D2D1_DISTANTDIFFUSE_SCALE_MODE_MULTI_SAMPLE_LINEAR = 3,
    D2D1_DISTANTDIFFUSE_SCALE_MODE_ANISOTROPIC = 4,
    D2D1_DISTANTDIFFUSE_SCALE_MODE_HIGH_QUALITY_CUBIC = 5,
    D2D1_DISTANTDIFFUSE_SCALE_MODE_FORCE_DWORD = 4294967295,
}

enum D2D1_FLOOD_PROP
{
    D2D1_FLOOD_PROP_COLOR = 0,
    D2D1_FLOOD_PROP_FORCE_DWORD = 4294967295,
}

enum D2D1_LINEARTRANSFER_PROP
{
    D2D1_LINEARTRANSFER_PROP_RED_Y_INTERCEPT = 0,
    D2D1_LINEARTRANSFER_PROP_RED_SLOPE = 1,
    D2D1_LINEARTRANSFER_PROP_RED_DISABLE = 2,
    D2D1_LINEARTRANSFER_PROP_GREEN_Y_INTERCEPT = 3,
    D2D1_LINEARTRANSFER_PROP_GREEN_SLOPE = 4,
    D2D1_LINEARTRANSFER_PROP_GREEN_DISABLE = 5,
    D2D1_LINEARTRANSFER_PROP_BLUE_Y_INTERCEPT = 6,
    D2D1_LINEARTRANSFER_PROP_BLUE_SLOPE = 7,
    D2D1_LINEARTRANSFER_PROP_BLUE_DISABLE = 8,
    D2D1_LINEARTRANSFER_PROP_ALPHA_Y_INTERCEPT = 9,
    D2D1_LINEARTRANSFER_PROP_ALPHA_SLOPE = 10,
    D2D1_LINEARTRANSFER_PROP_ALPHA_DISABLE = 11,
    D2D1_LINEARTRANSFER_PROP_CLAMP_OUTPUT = 12,
    D2D1_LINEARTRANSFER_PROP_FORCE_DWORD = 4294967295,
}

enum D2D1_GAMMATRANSFER_PROP
{
    D2D1_GAMMATRANSFER_PROP_RED_AMPLITUDE = 0,
    D2D1_GAMMATRANSFER_PROP_RED_EXPONENT = 1,
    D2D1_GAMMATRANSFER_PROP_RED_OFFSET = 2,
    D2D1_GAMMATRANSFER_PROP_RED_DISABLE = 3,
    D2D1_GAMMATRANSFER_PROP_GREEN_AMPLITUDE = 4,
    D2D1_GAMMATRANSFER_PROP_GREEN_EXPONENT = 5,
    D2D1_GAMMATRANSFER_PROP_GREEN_OFFSET = 6,
    D2D1_GAMMATRANSFER_PROP_GREEN_DISABLE = 7,
    D2D1_GAMMATRANSFER_PROP_BLUE_AMPLITUDE = 8,
    D2D1_GAMMATRANSFER_PROP_BLUE_EXPONENT = 9,
    D2D1_GAMMATRANSFER_PROP_BLUE_OFFSET = 10,
    D2D1_GAMMATRANSFER_PROP_BLUE_DISABLE = 11,
    D2D1_GAMMATRANSFER_PROP_ALPHA_AMPLITUDE = 12,
    D2D1_GAMMATRANSFER_PROP_ALPHA_EXPONENT = 13,
    D2D1_GAMMATRANSFER_PROP_ALPHA_OFFSET = 14,
    D2D1_GAMMATRANSFER_PROP_ALPHA_DISABLE = 15,
    D2D1_GAMMATRANSFER_PROP_CLAMP_OUTPUT = 16,
    D2D1_GAMMATRANSFER_PROP_FORCE_DWORD = 4294967295,
}

enum D2D1_TABLETRANSFER_PROP
{
    D2D1_TABLETRANSFER_PROP_RED_TABLE = 0,
    D2D1_TABLETRANSFER_PROP_RED_DISABLE = 1,
    D2D1_TABLETRANSFER_PROP_GREEN_TABLE = 2,
    D2D1_TABLETRANSFER_PROP_GREEN_DISABLE = 3,
    D2D1_TABLETRANSFER_PROP_BLUE_TABLE = 4,
    D2D1_TABLETRANSFER_PROP_BLUE_DISABLE = 5,
    D2D1_TABLETRANSFER_PROP_ALPHA_TABLE = 6,
    D2D1_TABLETRANSFER_PROP_ALPHA_DISABLE = 7,
    D2D1_TABLETRANSFER_PROP_CLAMP_OUTPUT = 8,
    D2D1_TABLETRANSFER_PROP_FORCE_DWORD = 4294967295,
}

enum D2D1_DISCRETETRANSFER_PROP
{
    D2D1_DISCRETETRANSFER_PROP_RED_TABLE = 0,
    D2D1_DISCRETETRANSFER_PROP_RED_DISABLE = 1,
    D2D1_DISCRETETRANSFER_PROP_GREEN_TABLE = 2,
    D2D1_DISCRETETRANSFER_PROP_GREEN_DISABLE = 3,
    D2D1_DISCRETETRANSFER_PROP_BLUE_TABLE = 4,
    D2D1_DISCRETETRANSFER_PROP_BLUE_DISABLE = 5,
    D2D1_DISCRETETRANSFER_PROP_ALPHA_TABLE = 6,
    D2D1_DISCRETETRANSFER_PROP_ALPHA_DISABLE = 7,
    D2D1_DISCRETETRANSFER_PROP_CLAMP_OUTPUT = 8,
    D2D1_DISCRETETRANSFER_PROP_FORCE_DWORD = 4294967295,
}

enum D2D1_CONVOLVEMATRIX_PROP
{
    D2D1_CONVOLVEMATRIX_PROP_KERNEL_UNIT_LENGTH = 0,
    D2D1_CONVOLVEMATRIX_PROP_SCALE_MODE = 1,
    D2D1_CONVOLVEMATRIX_PROP_KERNEL_SIZE_X = 2,
    D2D1_CONVOLVEMATRIX_PROP_KERNEL_SIZE_Y = 3,
    D2D1_CONVOLVEMATRIX_PROP_KERNEL_MATRIX = 4,
    D2D1_CONVOLVEMATRIX_PROP_DIVISOR = 5,
    D2D1_CONVOLVEMATRIX_PROP_BIAS = 6,
    D2D1_CONVOLVEMATRIX_PROP_KERNEL_OFFSET = 7,
    D2D1_CONVOLVEMATRIX_PROP_PRESERVE_ALPHA = 8,
    D2D1_CONVOLVEMATRIX_PROP_BORDER_MODE = 9,
    D2D1_CONVOLVEMATRIX_PROP_CLAMP_OUTPUT = 10,
    D2D1_CONVOLVEMATRIX_PROP_FORCE_DWORD = 4294967295,
}

enum D2D1_CONVOLVEMATRIX_SCALE_MODE
{
    D2D1_CONVOLVEMATRIX_SCALE_MODE_NEAREST_NEIGHBOR = 0,
    D2D1_CONVOLVEMATRIX_SCALE_MODE_LINEAR = 1,
    D2D1_CONVOLVEMATRIX_SCALE_MODE_CUBIC = 2,
    D2D1_CONVOLVEMATRIX_SCALE_MODE_MULTI_SAMPLE_LINEAR = 3,
    D2D1_CONVOLVEMATRIX_SCALE_MODE_ANISOTROPIC = 4,
    D2D1_CONVOLVEMATRIX_SCALE_MODE_HIGH_QUALITY_CUBIC = 5,
    D2D1_CONVOLVEMATRIX_SCALE_MODE_FORCE_DWORD = 4294967295,
}

enum D2D1_BRIGHTNESS_PROP
{
    D2D1_BRIGHTNESS_PROP_WHITE_POINT = 0,
    D2D1_BRIGHTNESS_PROP_BLACK_POINT = 1,
    D2D1_BRIGHTNESS_PROP_FORCE_DWORD = 4294967295,
}

enum D2D1_ARITHMETICCOMPOSITE_PROP
{
    D2D1_ARITHMETICCOMPOSITE_PROP_COEFFICIENTS = 0,
    D2D1_ARITHMETICCOMPOSITE_PROP_CLAMP_OUTPUT = 1,
    D2D1_ARITHMETICCOMPOSITE_PROP_FORCE_DWORD = 4294967295,
}

enum D2D1_CROP_PROP
{
    D2D1_CROP_PROP_RECT = 0,
    D2D1_CROP_PROP_BORDER_MODE = 1,
    D2D1_CROP_PROP_FORCE_DWORD = 4294967295,
}

enum D2D1_BORDER_PROP
{
    D2D1_BORDER_PROP_EDGE_MODE_X = 0,
    D2D1_BORDER_PROP_EDGE_MODE_Y = 1,
    D2D1_BORDER_PROP_FORCE_DWORD = 4294967295,
}

enum D2D1_BORDER_EDGE_MODE
{
    D2D1_BORDER_EDGE_MODE_CLAMP = 0,
    D2D1_BORDER_EDGE_MODE_WRAP = 1,
    D2D1_BORDER_EDGE_MODE_MIRROR = 2,
    D2D1_BORDER_EDGE_MODE_FORCE_DWORD = 4294967295,
}

enum D2D1_MORPHOLOGY_PROP
{
    D2D1_MORPHOLOGY_PROP_MODE = 0,
    D2D1_MORPHOLOGY_PROP_WIDTH = 1,
    D2D1_MORPHOLOGY_PROP_HEIGHT = 2,
    D2D1_MORPHOLOGY_PROP_FORCE_DWORD = 4294967295,
}

enum D2D1_MORPHOLOGY_MODE
{
    D2D1_MORPHOLOGY_MODE_ERODE = 0,
    D2D1_MORPHOLOGY_MODE_DILATE = 1,
    D2D1_MORPHOLOGY_MODE_FORCE_DWORD = 4294967295,
}

enum D2D1_TILE_PROP
{
    D2D1_TILE_PROP_RECT = 0,
    D2D1_TILE_PROP_FORCE_DWORD = 4294967295,
}

enum D2D1_ATLAS_PROP
{
    D2D1_ATLAS_PROP_INPUT_RECT = 0,
    D2D1_ATLAS_PROP_INPUT_PADDING_RECT = 1,
    D2D1_ATLAS_PROP_FORCE_DWORD = 4294967295,
}

enum D2D1_OPACITYMETADATA_PROP
{
    D2D1_OPACITYMETADATA_PROP_INPUT_OPAQUE_RECT = 0,
    D2D1_OPACITYMETADATA_PROP_FORCE_DWORD = 4294967295,
}

alias PD2D1_EFFECT_FACTORY = extern(Windows) HRESULT function(IUnknown* effectImpl);
enum D2D1_PROPERTY_TYPE
{
    D2D1_PROPERTY_TYPE_UNKNOWN = 0,
    D2D1_PROPERTY_TYPE_STRING = 1,
    D2D1_PROPERTY_TYPE_BOOL = 2,
    D2D1_PROPERTY_TYPE_UINT32 = 3,
    D2D1_PROPERTY_TYPE_INT32 = 4,
    D2D1_PROPERTY_TYPE_FLOAT = 5,
    D2D1_PROPERTY_TYPE_VECTOR2 = 6,
    D2D1_PROPERTY_TYPE_VECTOR3 = 7,
    D2D1_PROPERTY_TYPE_VECTOR4 = 8,
    D2D1_PROPERTY_TYPE_BLOB = 9,
    D2D1_PROPERTY_TYPE_IUNKNOWN = 10,
    D2D1_PROPERTY_TYPE_ENUM = 11,
    D2D1_PROPERTY_TYPE_ARRAY = 12,
    D2D1_PROPERTY_TYPE_CLSID = 13,
    D2D1_PROPERTY_TYPE_MATRIX_3X2 = 14,
    D2D1_PROPERTY_TYPE_MATRIX_4X3 = 15,
    D2D1_PROPERTY_TYPE_MATRIX_4X4 = 16,
    D2D1_PROPERTY_TYPE_MATRIX_5X4 = 17,
    D2D1_PROPERTY_TYPE_COLOR_CONTEXT = 18,
    D2D1_PROPERTY_TYPE_FORCE_DWORD = 4294967295,
}

enum D2D1_PROPERTY
{
    D2D1_PROPERTY_CLSID = 2147483648,
    D2D1_PROPERTY_DISPLAYNAME = 2147483649,
    D2D1_PROPERTY_AUTHOR = 2147483650,
    D2D1_PROPERTY_CATEGORY = 2147483651,
    D2D1_PROPERTY_DESCRIPTION = 2147483652,
    D2D1_PROPERTY_INPUTS = 2147483653,
    D2D1_PROPERTY_CACHED = 2147483654,
    D2D1_PROPERTY_PRECISION = 2147483655,
    D2D1_PROPERTY_MIN_INPUTS = 2147483656,
    D2D1_PROPERTY_MAX_INPUTS = 2147483657,
    D2D1_PROPERTY_FORCE_DWORD = 4294967295,
}

enum D2D1_SUBPROPERTY
{
    D2D1_SUBPROPERTY_DISPLAYNAME = 2147483648,
    D2D1_SUBPROPERTY_ISREADONLY = 2147483649,
    D2D1_SUBPROPERTY_MIN = 2147483650,
    D2D1_SUBPROPERTY_MAX = 2147483651,
    D2D1_SUBPROPERTY_DEFAULT = 2147483652,
    D2D1_SUBPROPERTY_FIELDS = 2147483653,
    D2D1_SUBPROPERTY_INDEX = 2147483654,
    D2D1_SUBPROPERTY_FORCE_DWORD = 4294967295,
}

enum D2D1_BITMAP_OPTIONS
{
    D2D1_BITMAP_OPTIONS_NONE = 0,
    D2D1_BITMAP_OPTIONS_TARGET = 1,
    D2D1_BITMAP_OPTIONS_CANNOT_DRAW = 2,
    D2D1_BITMAP_OPTIONS_CPU_READ = 4,
    D2D1_BITMAP_OPTIONS_GDI_COMPATIBLE = 8,
    D2D1_BITMAP_OPTIONS_FORCE_DWORD = 4294967295,
}

enum D2D1_COMPOSITE_MODE
{
    D2D1_COMPOSITE_MODE_SOURCE_OVER = 0,
    D2D1_COMPOSITE_MODE_DESTINATION_OVER = 1,
    D2D1_COMPOSITE_MODE_SOURCE_IN = 2,
    D2D1_COMPOSITE_MODE_DESTINATION_IN = 3,
    D2D1_COMPOSITE_MODE_SOURCE_OUT = 4,
    D2D1_COMPOSITE_MODE_DESTINATION_OUT = 5,
    D2D1_COMPOSITE_MODE_SOURCE_ATOP = 6,
    D2D1_COMPOSITE_MODE_DESTINATION_ATOP = 7,
    D2D1_COMPOSITE_MODE_XOR = 8,
    D2D1_COMPOSITE_MODE_PLUS = 9,
    D2D1_COMPOSITE_MODE_SOURCE_COPY = 10,
    D2D1_COMPOSITE_MODE_BOUNDED_SOURCE_COPY = 11,
    D2D1_COMPOSITE_MODE_MASK_INVERT = 12,
    D2D1_COMPOSITE_MODE_FORCE_DWORD = 4294967295,
}

enum D2D1_BUFFER_PRECISION
{
    D2D1_BUFFER_PRECISION_UNKNOWN = 0,
    D2D1_BUFFER_PRECISION_8BPC_UNORM = 1,
    D2D1_BUFFER_PRECISION_8BPC_UNORM_SRGB = 2,
    D2D1_BUFFER_PRECISION_16BPC_UNORM = 3,
    D2D1_BUFFER_PRECISION_16BPC_FLOAT = 4,
    D2D1_BUFFER_PRECISION_32BPC_FLOAT = 5,
    D2D1_BUFFER_PRECISION_FORCE_DWORD = 4294967295,
}

enum D2D1_MAP_OPTIONS
{
    D2D1_MAP_OPTIONS_NONE = 0,
    D2D1_MAP_OPTIONS_READ = 1,
    D2D1_MAP_OPTIONS_WRITE = 2,
    D2D1_MAP_OPTIONS_DISCARD = 4,
    D2D1_MAP_OPTIONS_FORCE_DWORD = 4294967295,
}

enum D2D1_INTERPOLATION_MODE
{
    D2D1_INTERPOLATION_MODE_NEAREST_NEIGHBOR = 0,
    D2D1_INTERPOLATION_MODE_LINEAR = 1,
    D2D1_INTERPOLATION_MODE_CUBIC = 2,
    D2D1_INTERPOLATION_MODE_MULTI_SAMPLE_LINEAR = 3,
    D2D1_INTERPOLATION_MODE_ANISOTROPIC = 4,
    D2D1_INTERPOLATION_MODE_HIGH_QUALITY_CUBIC = 5,
    D2D1_INTERPOLATION_MODE_FORCE_DWORD = 4294967295,
}

enum D2D1_UNIT_MODE
{
    D2D1_UNIT_MODE_DIPS = 0,
    D2D1_UNIT_MODE_PIXELS = 1,
    D2D1_UNIT_MODE_FORCE_DWORD = 4294967295,
}

enum D2D1_COLOR_SPACE
{
    D2D1_COLOR_SPACE_CUSTOM = 0,
    D2D1_COLOR_SPACE_SRGB = 1,
    D2D1_COLOR_SPACE_SCRGB = 2,
    D2D1_COLOR_SPACE_FORCE_DWORD = 4294967295,
}

enum D2D1_DEVICE_CONTEXT_OPTIONS
{
    D2D1_DEVICE_CONTEXT_OPTIONS_NONE = 0,
    D2D1_DEVICE_CONTEXT_OPTIONS_ENABLE_MULTITHREADED_OPTIMIZATIONS = 1,
    D2D1_DEVICE_CONTEXT_OPTIONS_FORCE_DWORD = 4294967295,
}

enum D2D1_STROKE_TRANSFORM_TYPE
{
    D2D1_STROKE_TRANSFORM_TYPE_NORMAL = 0,
    D2D1_STROKE_TRANSFORM_TYPE_FIXED = 1,
    D2D1_STROKE_TRANSFORM_TYPE_HAIRLINE = 2,
    D2D1_STROKE_TRANSFORM_TYPE_FORCE_DWORD = 4294967295,
}

enum D2D1_PRIMITIVE_BLEND
{
    D2D1_PRIMITIVE_BLEND_SOURCE_OVER = 0,
    D2D1_PRIMITIVE_BLEND_COPY = 1,
    D2D1_PRIMITIVE_BLEND_MIN = 2,
    D2D1_PRIMITIVE_BLEND_ADD = 3,
    D2D1_PRIMITIVE_BLEND_MAX = 4,
    D2D1_PRIMITIVE_BLEND_FORCE_DWORD = 4294967295,
}

enum D2D1_THREADING_MODE
{
    D2D1_THREADING_MODE_SINGLE_THREADED = 0,
    D2D1_THREADING_MODE_MULTI_THREADED = 1,
    D2D1_THREADING_MODE_FORCE_DWORD = 4294967295,
}

enum D2D1_COLOR_INTERPOLATION_MODE
{
    D2D1_COLOR_INTERPOLATION_MODE_STRAIGHT = 0,
    D2D1_COLOR_INTERPOLATION_MODE_PREMULTIPLIED = 1,
    D2D1_COLOR_INTERPOLATION_MODE_FORCE_DWORD = 4294967295,
}

struct D2D1_BITMAP_PROPERTIES1
{
    D2D1_PIXEL_FORMAT pixelFormat;
    float dpiX;
    float dpiY;
    D2D1_BITMAP_OPTIONS bitmapOptions;
    ID2D1ColorContext colorContext;
}

struct D2D1_MAPPED_RECT
{
    uint pitch;
    ubyte* bits;
}

struct D2D1_RENDERING_CONTROLS
{
    D2D1_BUFFER_PRECISION bufferPrecision;
    D2D_SIZE_U tileSize;
}

struct D2D1_EFFECT_INPUT_DESCRIPTION
{
    ID2D1Effect effect;
    uint inputIndex;
    D2D_RECT_F inputRectangle;
}

struct D2D1_POINT_DESCRIPTION
{
    D2D_POINT_2F point;
    D2D_POINT_2F unitTangentVector;
    uint endSegment;
    uint endFigure;
    float lengthToEndSegment;
}

struct D2D1_IMAGE_BRUSH_PROPERTIES
{
    D2D_RECT_F sourceRectangle;
    D2D1_EXTEND_MODE extendModeX;
    D2D1_EXTEND_MODE extendModeY;
    D2D1_INTERPOLATION_MODE interpolationMode;
}

struct D2D1_BITMAP_BRUSH_PROPERTIES1
{
    D2D1_EXTEND_MODE extendModeX;
    D2D1_EXTEND_MODE extendModeY;
    D2D1_INTERPOLATION_MODE interpolationMode;
}

struct D2D1_STROKE_STYLE_PROPERTIES1
{
    D2D1_CAP_STYLE startCap;
    D2D1_CAP_STYLE endCap;
    D2D1_CAP_STYLE dashCap;
    D2D1_LINE_JOIN lineJoin;
    float miterLimit;
    D2D1_DASH_STYLE dashStyle;
    float dashOffset;
    D2D1_STROKE_TRANSFORM_TYPE transformType;
}

enum D2D1_LAYER_OPTIONS1
{
    D2D1_LAYER_OPTIONS1_NONE = 0,
    D2D1_LAYER_OPTIONS1_INITIALIZE_FROM_BACKGROUND = 1,
    D2D1_LAYER_OPTIONS1_IGNORE_ALPHA = 2,
    D2D1_LAYER_OPTIONS1_FORCE_DWORD = 4294967295,
}

struct D2D1_LAYER_PARAMETERS1
{
    D2D_RECT_F contentBounds;
    ID2D1Geometry geometricMask;
    D2D1_ANTIALIAS_MODE maskAntialiasMode;
    D2D_MATRIX_3X2_F maskTransform;
    float opacity;
    ID2D1Brush opacityBrush;
    D2D1_LAYER_OPTIONS1 layerOptions;
}

enum D2D1_PRINT_FONT_SUBSET_MODE
{
    D2D1_PRINT_FONT_SUBSET_MODE_DEFAULT = 0,
    D2D1_PRINT_FONT_SUBSET_MODE_EACHPAGE = 1,
    D2D1_PRINT_FONT_SUBSET_MODE_NONE = 2,
    D2D1_PRINT_FONT_SUBSET_MODE_FORCE_DWORD = 4294967295,
}

struct D2D1_DRAWING_STATE_DESCRIPTION1
{
    D2D1_ANTIALIAS_MODE antialiasMode;
    D2D1_TEXT_ANTIALIAS_MODE textAntialiasMode;
    ulong tag1;
    ulong tag2;
    D2D_MATRIX_3X2_F transform;
    D2D1_PRIMITIVE_BLEND primitiveBlend;
    D2D1_UNIT_MODE unitMode;
}

struct D2D1_PRINT_CONTROL_PROPERTIES
{
    D2D1_PRINT_FONT_SUBSET_MODE fontSubset;
    float rasterDPI;
    D2D1_COLOR_SPACE colorSpace;
}

struct D2D1_CREATION_PROPERTIES
{
    D2D1_THREADING_MODE threadingMode;
    D2D1_DEBUG_LEVEL debugLevel;
    D2D1_DEVICE_CONTEXT_OPTIONS options;
}

const GUID IID_ID2D1GdiMetafileSink = {0x82237326, 0x8111, 0x4F7C, [0xBC, 0xF4, 0xB5, 0xC1, 0x17, 0x55, 0x64, 0xFE]};
@GUID(0x82237326, 0x8111, 0x4F7C, [0xBC, 0xF4, 0xB5, 0xC1, 0x17, 0x55, 0x64, 0xFE]);
interface ID2D1GdiMetafileSink : IUnknown
{
    HRESULT ProcessRecord(uint recordType, const(void)* recordData, uint recordDataSize);
}

const GUID IID_ID2D1GdiMetafile = {0x2F543DC3, 0xCFC1, 0x4211, [0x86, 0x4F, 0xCF, 0xD9, 0x1C, 0x6F, 0x33, 0x95]};
@GUID(0x2F543DC3, 0xCFC1, 0x4211, [0x86, 0x4F, 0xCF, 0xD9, 0x1C, 0x6F, 0x33, 0x95]);
interface ID2D1GdiMetafile : ID2D1Resource
{
    HRESULT Stream(ID2D1GdiMetafileSink sink);
    HRESULT GetBounds(D2D_RECT_F* bounds);
}

const GUID IID_ID2D1CommandSink = {0x54D7898A, 0xA061, 0x40A7, [0xBE, 0xC7, 0xE4, 0x65, 0xBC, 0xBA, 0x2C, 0x4F]};
@GUID(0x54D7898A, 0xA061, 0x40A7, [0xBE, 0xC7, 0xE4, 0x65, 0xBC, 0xBA, 0x2C, 0x4F]);
interface ID2D1CommandSink : IUnknown
{
    HRESULT BeginDraw();
    HRESULT EndDraw();
    HRESULT SetAntialiasMode(D2D1_ANTIALIAS_MODE antialiasMode);
    HRESULT SetTags(ulong tag1, ulong tag2);
    HRESULT SetTextAntialiasMode(D2D1_TEXT_ANTIALIAS_MODE textAntialiasMode);
    HRESULT SetTextRenderingParams(IDWriteRenderingParams textRenderingParams);
    HRESULT SetTransform(const(D2D_MATRIX_3X2_F)* transform);
    HRESULT SetPrimitiveBlend(D2D1_PRIMITIVE_BLEND primitiveBlend);
    HRESULT SetUnitMode(D2D1_UNIT_MODE unitMode);
    HRESULT Clear(const(DXGI_RGBA)* color);
    HRESULT DrawGlyphRun(D2D_POINT_2F baselineOrigin, const(DWRITE_GLYPH_RUN)* glyphRun, const(DWRITE_GLYPH_RUN_DESCRIPTION)* glyphRunDescription, ID2D1Brush foregroundBrush, DWRITE_MEASURING_MODE measuringMode);
    HRESULT DrawLine(D2D_POINT_2F point0, D2D_POINT_2F point1, ID2D1Brush brush, float strokeWidth, ID2D1StrokeStyle strokeStyle);
    HRESULT DrawGeometry(ID2D1Geometry geometry, ID2D1Brush brush, float strokeWidth, ID2D1StrokeStyle strokeStyle);
    HRESULT DrawRectangle(const(D2D_RECT_F)* rect, ID2D1Brush brush, float strokeWidth, ID2D1StrokeStyle strokeStyle);
    HRESULT DrawBitmap(ID2D1Bitmap bitmap, const(D2D_RECT_F)* destinationRectangle, float opacity, D2D1_INTERPOLATION_MODE interpolationMode, const(D2D_RECT_F)* sourceRectangle, const(D2D_MATRIX_4X4_F)* perspectiveTransform);
    HRESULT DrawImage(ID2D1Image image, const(D2D_POINT_2F)* targetOffset, const(D2D_RECT_F)* imageRectangle, D2D1_INTERPOLATION_MODE interpolationMode, D2D1_COMPOSITE_MODE compositeMode);
    HRESULT DrawGdiMetafile(ID2D1GdiMetafile gdiMetafile, const(D2D_POINT_2F)* targetOffset);
    HRESULT FillMesh(ID2D1Mesh mesh, ID2D1Brush brush);
    HRESULT FillOpacityMask(ID2D1Bitmap opacityMask, ID2D1Brush brush, const(D2D_RECT_F)* destinationRectangle, const(D2D_RECT_F)* sourceRectangle);
    HRESULT FillGeometry(ID2D1Geometry geometry, ID2D1Brush brush, ID2D1Brush opacityBrush);
    HRESULT FillRectangle(const(D2D_RECT_F)* rect, ID2D1Brush brush);
    HRESULT PushAxisAlignedClip(const(D2D_RECT_F)* clipRect, D2D1_ANTIALIAS_MODE antialiasMode);
    HRESULT PushLayer(const(D2D1_LAYER_PARAMETERS1)* layerParameters1, ID2D1Layer layer);
    HRESULT PopAxisAlignedClip();
    HRESULT PopLayer();
}

const GUID IID_ID2D1CommandList = {0xB4F34A19, 0x2383, 0x4D76, [0x94, 0xF6, 0xEC, 0x34, 0x36, 0x57, 0xC3, 0xDC]};
@GUID(0xB4F34A19, 0x2383, 0x4D76, [0x94, 0xF6, 0xEC, 0x34, 0x36, 0x57, 0xC3, 0xDC]);
interface ID2D1CommandList : ID2D1Image
{
    HRESULT Stream(ID2D1CommandSink sink);
    HRESULT Close();
}

const GUID IID_ID2D1PrintControl = {0x2C1D867D, 0xC290, 0x41C8, [0xAE, 0x7E, 0x34, 0xA9, 0x87, 0x02, 0xE9, 0xA5]};
@GUID(0x2C1D867D, 0xC290, 0x41C8, [0xAE, 0x7E, 0x34, 0xA9, 0x87, 0x02, 0xE9, 0xA5]);
interface ID2D1PrintControl : IUnknown
{
    HRESULT AddPage(ID2D1CommandList commandList, D2D_SIZE_F pageSize, IStream pagePrintTicketStream, ulong* tag1, ulong* tag2);
    HRESULT Close();
}

const GUID IID_ID2D1ImageBrush = {0xFE9E984D, 0x3F95, 0x407C, [0xB5, 0xDB, 0xCB, 0x94, 0xD4, 0xE8, 0xF8, 0x7C]};
@GUID(0xFE9E984D, 0x3F95, 0x407C, [0xB5, 0xDB, 0xCB, 0x94, 0xD4, 0xE8, 0xF8, 0x7C]);
interface ID2D1ImageBrush : ID2D1Brush
{
    void SetImage(ID2D1Image image);
    void SetExtendModeX(D2D1_EXTEND_MODE extendModeX);
    void SetExtendModeY(D2D1_EXTEND_MODE extendModeY);
    void SetInterpolationMode(D2D1_INTERPOLATION_MODE interpolationMode);
    void SetSourceRectangle(const(D2D_RECT_F)* sourceRectangle);
    void GetImage(ID2D1Image* image);
    D2D1_EXTEND_MODE GetExtendModeX();
    D2D1_EXTEND_MODE GetExtendModeY();
    D2D1_INTERPOLATION_MODE GetInterpolationMode();
    void GetSourceRectangle(D2D_RECT_F* sourceRectangle);
}

const GUID IID_ID2D1BitmapBrush1 = {0x41343A53, 0xE41A, 0x49A2, [0x91, 0xCD, 0x21, 0x79, 0x3B, 0xBB, 0x62, 0xE5]};
@GUID(0x41343A53, 0xE41A, 0x49A2, [0x91, 0xCD, 0x21, 0x79, 0x3B, 0xBB, 0x62, 0xE5]);
interface ID2D1BitmapBrush1 : ID2D1BitmapBrush
{
    void SetInterpolationMode1(D2D1_INTERPOLATION_MODE interpolationMode);
    D2D1_INTERPOLATION_MODE GetInterpolationMode1();
}

const GUID IID_ID2D1StrokeStyle1 = {0x10A72A66, 0xE91C, 0x43F4, [0x99, 0x3F, 0xDD, 0xF4, 0xB8, 0x2B, 0x0B, 0x4A]};
@GUID(0x10A72A66, 0xE91C, 0x43F4, [0x99, 0x3F, 0xDD, 0xF4, 0xB8, 0x2B, 0x0B, 0x4A]);
interface ID2D1StrokeStyle1 : ID2D1StrokeStyle
{
    D2D1_STROKE_TRANSFORM_TYPE GetStrokeTransformType();
}

const GUID IID_ID2D1PathGeometry1 = {0x62BAA2D2, 0xAB54, 0x41B7, [0xB8, 0x72, 0x78, 0x7E, 0x01, 0x06, 0xA4, 0x21]};
@GUID(0x62BAA2D2, 0xAB54, 0x41B7, [0xB8, 0x72, 0x78, 0x7E, 0x01, 0x06, 0xA4, 0x21]);
interface ID2D1PathGeometry1 : ID2D1PathGeometry
{
    HRESULT ComputePointAndSegmentAtLength(float length, uint startSegment, const(D2D_MATRIX_3X2_F)* worldTransform, float flatteningTolerance, D2D1_POINT_DESCRIPTION* pointDescription);
}

const GUID IID_ID2D1Properties = {0x483473D7, 0xCD46, 0x4F9D, [0x9D, 0x3A, 0x31, 0x12, 0xAA, 0x80, 0x15, 0x9D]};
@GUID(0x483473D7, 0xCD46, 0x4F9D, [0x9D, 0x3A, 0x31, 0x12, 0xAA, 0x80, 0x15, 0x9D]);
interface ID2D1Properties : IUnknown
{
    uint GetPropertyCount();
    HRESULT GetPropertyName(uint index, const(wchar)* name, uint nameCount);
    uint GetPropertyNameLength(uint index);
    D2D1_PROPERTY_TYPE GetType(uint index);
    uint GetPropertyIndex(const(wchar)* name);
    HRESULT SetValueByName(const(wchar)* name, D2D1_PROPERTY_TYPE type, char* data, uint dataSize);
    HRESULT SetValue(uint index, D2D1_PROPERTY_TYPE type, char* data, uint dataSize);
    HRESULT GetValueByName(const(wchar)* name, D2D1_PROPERTY_TYPE type, char* data, uint dataSize);
    HRESULT GetValue(uint index, D2D1_PROPERTY_TYPE type, char* data, uint dataSize);
    uint GetValueSize(uint index);
    HRESULT GetSubProperties(uint index, ID2D1Properties* subProperties);
}

const GUID IID_ID2D1Effect = {0x28211A43, 0x7D89, 0x476F, [0x81, 0x81, 0x2D, 0x61, 0x59, 0xB2, 0x20, 0xAD]};
@GUID(0x28211A43, 0x7D89, 0x476F, [0x81, 0x81, 0x2D, 0x61, 0x59, 0xB2, 0x20, 0xAD]);
interface ID2D1Effect : ID2D1Properties
{
    void SetInput(uint index, ID2D1Image input, BOOL invalidate);
    HRESULT SetInputCount(uint inputCount);
    void GetInput(uint index, ID2D1Image* input);
    uint GetInputCount();
    void GetOutput(ID2D1Image* outputImage);
}

const GUID IID_ID2D1Bitmap1 = {0xA898A84C, 0x3873, 0x4588, [0xB0, 0x8B, 0xEB, 0xBF, 0x97, 0x8D, 0xF0, 0x41]};
@GUID(0xA898A84C, 0x3873, 0x4588, [0xB0, 0x8B, 0xEB, 0xBF, 0x97, 0x8D, 0xF0, 0x41]);
interface ID2D1Bitmap1 : ID2D1Bitmap
{
    void GetColorContext(ID2D1ColorContext* colorContext);
    D2D1_BITMAP_OPTIONS GetOptions();
    HRESULT GetSurface(IDXGISurface* dxgiSurface);
    HRESULT Map(D2D1_MAP_OPTIONS options, D2D1_MAPPED_RECT* mappedRect);
    HRESULT Unmap();
}

const GUID IID_ID2D1ColorContext = {0x1C4820BB, 0x5771, 0x4518, [0xA5, 0x81, 0x2F, 0xE4, 0xDD, 0x0E, 0xC6, 0x57]};
@GUID(0x1C4820BB, 0x5771, 0x4518, [0xA5, 0x81, 0x2F, 0xE4, 0xDD, 0x0E, 0xC6, 0x57]);
interface ID2D1ColorContext : ID2D1Resource
{
    D2D1_COLOR_SPACE GetColorSpace();
    uint GetProfileSize();
    HRESULT GetProfile(char* profile, uint profileSize);
}

const GUID IID_ID2D1GradientStopCollection1 = {0xAE1572F4, 0x5DD0, 0x4777, [0x99, 0x8B, 0x92, 0x79, 0x47, 0x2A, 0xE6, 0x3B]};
@GUID(0xAE1572F4, 0x5DD0, 0x4777, [0x99, 0x8B, 0x92, 0x79, 0x47, 0x2A, 0xE6, 0x3B]);
interface ID2D1GradientStopCollection1 : ID2D1GradientStopCollection
{
    void GetGradientStops1(char* gradientStops, uint gradientStopsCount);
    D2D1_COLOR_SPACE GetPreInterpolationSpace();
    D2D1_COLOR_SPACE GetPostInterpolationSpace();
    D2D1_BUFFER_PRECISION GetBufferPrecision();
    D2D1_COLOR_INTERPOLATION_MODE GetColorInterpolationMode();
}

const GUID IID_ID2D1DrawingStateBlock1 = {0x689F1F85, 0xC72E, 0x4E33, [0x8F, 0x19, 0x85, 0x75, 0x4E, 0xFD, 0x5A, 0xCE]};
@GUID(0x689F1F85, 0xC72E, 0x4E33, [0x8F, 0x19, 0x85, 0x75, 0x4E, 0xFD, 0x5A, 0xCE]);
interface ID2D1DrawingStateBlock1 : ID2D1DrawingStateBlock
{
    void GetDescription(D2D1_DRAWING_STATE_DESCRIPTION1* stateDescription);
    void SetDescription(const(D2D1_DRAWING_STATE_DESCRIPTION1)* stateDescription);
}

const GUID IID_ID2D1DeviceContext = {0xE8F7FE7A, 0x191C, 0x466D, [0xAD, 0x95, 0x97, 0x56, 0x78, 0xBD, 0xA9, 0x98]};
@GUID(0xE8F7FE7A, 0x191C, 0x466D, [0xAD, 0x95, 0x97, 0x56, 0x78, 0xBD, 0xA9, 0x98]);
interface ID2D1DeviceContext : ID2D1RenderTarget
{
    HRESULT CreateBitmap(D2D_SIZE_U size, const(void)* sourceData, uint pitch, const(D2D1_BITMAP_PROPERTIES1)* bitmapProperties, ID2D1Bitmap1* bitmap);
    HRESULT CreateBitmapFromWicBitmap(IWICBitmapSource wicBitmapSource, const(D2D1_BITMAP_PROPERTIES1)* bitmapProperties, ID2D1Bitmap1* bitmap);
    HRESULT CreateColorContext(D2D1_COLOR_SPACE space, char* profile, uint profileSize, ID2D1ColorContext* colorContext);
    HRESULT CreateColorContextFromFilename(const(wchar)* filename, ID2D1ColorContext* colorContext);
    HRESULT CreateColorContextFromWicColorContext(IWICColorContext wicColorContext, ID2D1ColorContext* colorContext);
    HRESULT CreateBitmapFromDxgiSurface(IDXGISurface surface, const(D2D1_BITMAP_PROPERTIES1)* bitmapProperties, ID2D1Bitmap1* bitmap);
    HRESULT CreateEffect(const(Guid)* effectId, ID2D1Effect* effect);
    HRESULT CreateGradientStopCollection(char* straightAlphaGradientStops, uint straightAlphaGradientStopsCount, D2D1_COLOR_SPACE preInterpolationSpace, D2D1_COLOR_SPACE postInterpolationSpace, D2D1_BUFFER_PRECISION bufferPrecision, D2D1_EXTEND_MODE extendMode, D2D1_COLOR_INTERPOLATION_MODE colorInterpolationMode, ID2D1GradientStopCollection1* gradientStopCollection1);
    HRESULT CreateImageBrush(ID2D1Image image, const(D2D1_IMAGE_BRUSH_PROPERTIES)* imageBrushProperties, const(D2D1_BRUSH_PROPERTIES)* brushProperties, ID2D1ImageBrush* imageBrush);
    HRESULT CreateBitmapBrush(ID2D1Bitmap bitmap, const(D2D1_BITMAP_BRUSH_PROPERTIES1)* bitmapBrushProperties, const(D2D1_BRUSH_PROPERTIES)* brushProperties, ID2D1BitmapBrush1* bitmapBrush);
    HRESULT CreateCommandList(ID2D1CommandList* commandList);
    BOOL IsDxgiFormatSupported(DXGI_FORMAT format);
    BOOL IsBufferPrecisionSupported(D2D1_BUFFER_PRECISION bufferPrecision);
    HRESULT GetImageLocalBounds(ID2D1Image image, D2D_RECT_F* localBounds);
    HRESULT GetImageWorldBounds(ID2D1Image image, D2D_RECT_F* worldBounds);
    HRESULT GetGlyphRunWorldBounds(D2D_POINT_2F baselineOrigin, const(DWRITE_GLYPH_RUN)* glyphRun, DWRITE_MEASURING_MODE measuringMode, D2D_RECT_F* bounds);
    void GetDevice(ID2D1Device* device);
    void SetTarget(ID2D1Image image);
    void GetTarget(ID2D1Image* image);
    void SetRenderingControls(const(D2D1_RENDERING_CONTROLS)* renderingControls);
    void GetRenderingControls(D2D1_RENDERING_CONTROLS* renderingControls);
    void SetPrimitiveBlend(D2D1_PRIMITIVE_BLEND primitiveBlend);
    D2D1_PRIMITIVE_BLEND GetPrimitiveBlend();
    void SetUnitMode(D2D1_UNIT_MODE unitMode);
    D2D1_UNIT_MODE GetUnitMode();
    void DrawGlyphRun(D2D_POINT_2F baselineOrigin, const(DWRITE_GLYPH_RUN)* glyphRun, const(DWRITE_GLYPH_RUN_DESCRIPTION)* glyphRunDescription, ID2D1Brush foregroundBrush, DWRITE_MEASURING_MODE measuringMode);
    void DrawImage(ID2D1Image image, const(D2D_POINT_2F)* targetOffset, const(D2D_RECT_F)* imageRectangle, D2D1_INTERPOLATION_MODE interpolationMode, D2D1_COMPOSITE_MODE compositeMode);
    void DrawGdiMetafile(ID2D1GdiMetafile gdiMetafile, const(D2D_POINT_2F)* targetOffset);
    void DrawBitmap(ID2D1Bitmap bitmap, const(D2D_RECT_F)* destinationRectangle, float opacity, D2D1_INTERPOLATION_MODE interpolationMode, const(D2D_RECT_F)* sourceRectangle, const(D2D_MATRIX_4X4_F)* perspectiveTransform);
    void PushLayer(const(D2D1_LAYER_PARAMETERS1)* layerParameters, ID2D1Layer layer);
    HRESULT InvalidateEffectInputRectangle(ID2D1Effect effect, uint input, const(D2D_RECT_F)* inputRectangle);
    HRESULT GetEffectInvalidRectangleCount(ID2D1Effect effect, uint* rectangleCount);
    HRESULT GetEffectInvalidRectangles(ID2D1Effect effect, char* rectangles, uint rectanglesCount);
    HRESULT GetEffectRequiredInputRectangles(ID2D1Effect renderEffect, const(D2D_RECT_F)* renderImageRectangle, char* inputDescriptions, char* requiredInputRects, uint inputCount);
    void FillOpacityMask(ID2D1Bitmap opacityMask, ID2D1Brush brush, const(D2D_RECT_F)* destinationRectangle, const(D2D_RECT_F)* sourceRectangle);
}

const GUID IID_ID2D1Device = {0x47DD575D, 0xAC05, 0x4CDD, [0x80, 0x49, 0x9B, 0x02, 0xCD, 0x16, 0xF4, 0x4C]};
@GUID(0x47DD575D, 0xAC05, 0x4CDD, [0x80, 0x49, 0x9B, 0x02, 0xCD, 0x16, 0xF4, 0x4C]);
interface ID2D1Device : ID2D1Resource
{
    HRESULT CreateDeviceContext(D2D1_DEVICE_CONTEXT_OPTIONS options, ID2D1DeviceContext* deviceContext);
    HRESULT CreatePrintControl(IWICImagingFactory wicFactory, IPrintDocumentPackageTarget documentTarget, const(D2D1_PRINT_CONTROL_PROPERTIES)* printControlProperties, ID2D1PrintControl* printControl);
    void SetMaximumTextureMemory(ulong maximumInBytes);
    ulong GetMaximumTextureMemory();
    void ClearResources(uint millisecondsSinceUse);
}

const GUID IID_ID2D1Factory1 = {0xBB12D362, 0xDAEE, 0x4B9A, [0xAA, 0x1D, 0x14, 0xBA, 0x40, 0x1C, 0xFA, 0x1F]};
@GUID(0xBB12D362, 0xDAEE, 0x4B9A, [0xAA, 0x1D, 0x14, 0xBA, 0x40, 0x1C, 0xFA, 0x1F]);
interface ID2D1Factory1 : ID2D1Factory
{
    HRESULT CreateDevice(IDXGIDevice dxgiDevice, ID2D1Device* d2dDevice);
    HRESULT CreateStrokeStyle(const(D2D1_STROKE_STYLE_PROPERTIES1)* strokeStyleProperties, char* dashes, uint dashesCount, ID2D1StrokeStyle1* strokeStyle);
    HRESULT CreatePathGeometry(ID2D1PathGeometry1* pathGeometry);
    HRESULT CreateDrawingStateBlock(const(D2D1_DRAWING_STATE_DESCRIPTION1)* drawingStateDescription, IDWriteRenderingParams textRenderingParams, ID2D1DrawingStateBlock1* drawingStateBlock);
    HRESULT CreateGdiMetafile(IStream metafileStream, ID2D1GdiMetafile* metafile);
    HRESULT RegisterEffectFromStream(const(Guid)* classId, IStream propertyXml, char* bindings, uint bindingsCount, const(int) effectFactory);
    HRESULT RegisterEffectFromString(const(Guid)* classId, const(wchar)* propertyXml, char* bindings, uint bindingsCount, const(int) effectFactory);
    HRESULT UnregisterEffect(const(Guid)* classId);
    HRESULT GetRegisteredEffects(char* effects, uint effectsCount, uint* effectsReturned, uint* effectsRegistered);
    HRESULT GetEffectProperties(const(Guid)* effectId, ID2D1Properties* properties);
}

const GUID IID_ID2D1Multithread = {0x31E6E7BC, 0xE0FF, 0x4D46, [0x8C, 0x64, 0xA0, 0xA8, 0xC4, 0x1C, 0x15, 0xD3]};
@GUID(0x31E6E7BC, 0xE0FF, 0x4D46, [0x8C, 0x64, 0xA0, 0xA8, 0xC4, 0x1C, 0x15, 0xD3]);
interface ID2D1Multithread : IUnknown
{
    BOOL GetMultithreadProtected();
    void Enter();
    void Leave();
}

struct Matrix4x3F
{
    D2D_MATRIX_4X3_F __AnonymousBase_d2d1_1helper_L45_C31;
}

struct Matrix4x4F
{
    D2D_MATRIX_4X4_F __AnonymousBase_d2d1_1helper_L97_C31;
}

struct Matrix5x4F
{
    D2D_MATRIX_5X4_F __AnonymousBase_d2d1_1helper_L472_C31;
}

alias PD2D1_PROPERTY_SET_FUNCTION = extern(Windows) HRESULT function(IUnknown effect, char* data, uint dataSize);
alias PD2D1_PROPERTY_GET_FUNCTION = extern(Windows) HRESULT function(const(IUnknown) effect, char* data, uint dataSize, uint* actualSize);
enum D2D1_CHANGE_TYPE
{
    D2D1_CHANGE_TYPE_NONE = 0,
    D2D1_CHANGE_TYPE_PROPERTIES = 1,
    D2D1_CHANGE_TYPE_CONTEXT = 2,
    D2D1_CHANGE_TYPE_GRAPH = 3,
    D2D1_CHANGE_TYPE_FORCE_DWORD = 4294967295,
}

enum D2D1_PIXEL_OPTIONS
{
    D2D1_PIXEL_OPTIONS_NONE = 0,
    D2D1_PIXEL_OPTIONS_TRIVIAL_SAMPLING = 1,
    D2D1_PIXEL_OPTIONS_FORCE_DWORD = 4294967295,
}

enum D2D1_VERTEX_OPTIONS
{
    D2D1_VERTEX_OPTIONS_NONE = 0,
    D2D1_VERTEX_OPTIONS_DO_NOT_CLEAR = 1,
    D2D1_VERTEX_OPTIONS_USE_DEPTH_BUFFER = 2,
    D2D1_VERTEX_OPTIONS_ASSUME_NO_OVERLAP = 4,
    D2D1_VERTEX_OPTIONS_FORCE_DWORD = 4294967295,
}

enum D2D1_VERTEX_USAGE
{
    D2D1_VERTEX_USAGE_STATIC = 0,
    D2D1_VERTEX_USAGE_DYNAMIC = 1,
    D2D1_VERTEX_USAGE_FORCE_DWORD = 4294967295,
}

enum D2D1_BLEND_OPERATION
{
    D2D1_BLEND_OPERATION_ADD = 1,
    D2D1_BLEND_OPERATION_SUBTRACT = 2,
    D2D1_BLEND_OPERATION_REV_SUBTRACT = 3,
    D2D1_BLEND_OPERATION_MIN = 4,
    D2D1_BLEND_OPERATION_MAX = 5,
    D2D1_BLEND_OPERATION_FORCE_DWORD = 4294967295,
}

enum D2D1_BLEND
{
    D2D1_BLEND_ZERO = 1,
    D2D1_BLEND_ONE = 2,
    D2D1_BLEND_SRC_COLOR = 3,
    D2D1_BLEND_INV_SRC_COLOR = 4,
    D2D1_BLEND_SRC_ALPHA = 5,
    D2D1_BLEND_INV_SRC_ALPHA = 6,
    D2D1_BLEND_DEST_ALPHA = 7,
    D2D1_BLEND_INV_DEST_ALPHA = 8,
    D2D1_BLEND_DEST_COLOR = 9,
    D2D1_BLEND_INV_DEST_COLOR = 10,
    D2D1_BLEND_SRC_ALPHA_SAT = 11,
    D2D1_BLEND_BLEND_FACTOR = 14,
    D2D1_BLEND_INV_BLEND_FACTOR = 15,
    D2D1_BLEND_FORCE_DWORD = 4294967295,
}

enum D2D1_CHANNEL_DEPTH
{
    D2D1_CHANNEL_DEPTH_DEFAULT = 0,
    D2D1_CHANNEL_DEPTH_1 = 1,
    D2D1_CHANNEL_DEPTH_4 = 4,
    D2D1_CHANNEL_DEPTH_FORCE_DWORD = 4294967295,
}

enum D2D1_FILTER
{
    D2D1_FILTER_MIN_MAG_MIP_POINT = 0,
    D2D1_FILTER_MIN_MAG_POINT_MIP_LINEAR = 1,
    D2D1_FILTER_MIN_POINT_MAG_LINEAR_MIP_POINT = 4,
    D2D1_FILTER_MIN_POINT_MAG_MIP_LINEAR = 5,
    D2D1_FILTER_MIN_LINEAR_MAG_MIP_POINT = 16,
    D2D1_FILTER_MIN_LINEAR_MAG_POINT_MIP_LINEAR = 17,
    D2D1_FILTER_MIN_MAG_LINEAR_MIP_POINT = 20,
    D2D1_FILTER_MIN_MAG_MIP_LINEAR = 21,
    D2D1_FILTER_ANISOTROPIC = 85,
    D2D1_FILTER_FORCE_DWORD = 4294967295,
}

enum D2D1_FEATURE
{
    D2D1_FEATURE_DOUBLES = 0,
    D2D1_FEATURE_D3D10_X_HARDWARE_OPTIONS = 1,
    D2D1_FEATURE_FORCE_DWORD = 4294967295,
}

struct D2D1_PROPERTY_BINDING
{
    const(wchar)* propertyName;
    PD2D1_PROPERTY_SET_FUNCTION setFunction;
    PD2D1_PROPERTY_GET_FUNCTION getFunction;
}

struct D2D1_RESOURCE_TEXTURE_PROPERTIES
{
    const(uint)* extents;
    uint dimensions;
    D2D1_BUFFER_PRECISION bufferPrecision;
    D2D1_CHANNEL_DEPTH channelDepth;
    D2D1_FILTER filter;
    const(D2D1_EXTEND_MODE)* extendModes;
}

struct D2D1_INPUT_ELEMENT_DESC
{
    const(char)* semanticName;
    uint semanticIndex;
    DXGI_FORMAT format;
    uint inputSlot;
    uint alignedByteOffset;
}

struct D2D1_VERTEX_BUFFER_PROPERTIES
{
    uint inputCount;
    D2D1_VERTEX_USAGE usage;
    const(ubyte)* data;
    uint byteWidth;
}

struct D2D1_CUSTOM_VERTEX_BUFFER_PROPERTIES
{
    const(ubyte)* shaderBufferWithInputSignature;
    uint shaderBufferSize;
    const(D2D1_INPUT_ELEMENT_DESC)* inputElements;
    uint elementCount;
    uint stride;
}

struct D2D1_VERTEX_RANGE
{
    uint startVertex;
    uint vertexCount;
}

struct D2D1_BLEND_DESCRIPTION
{
    D2D1_BLEND sourceBlend;
    D2D1_BLEND destinationBlend;
    D2D1_BLEND_OPERATION blendOperation;
    D2D1_BLEND sourceBlendAlpha;
    D2D1_BLEND destinationBlendAlpha;
    D2D1_BLEND_OPERATION blendOperationAlpha;
    float blendFactor;
}

struct D2D1_INPUT_DESCRIPTION
{
    D2D1_FILTER filter;
    uint levelOfDetailCount;
}

struct D2D1_FEATURE_DATA_DOUBLES
{
    BOOL doublePrecisionFloatShaderOps;
}

struct D2D1_FEATURE_DATA_D3D10_X_HARDWARE_OPTIONS
{
    BOOL computeShaders_Plus_RawAndStructuredBuffers_Via_Shader_4_x;
}

const GUID IID_ID2D1VertexBuffer = {0x9B8B1336, 0x00A5, 0x4668, [0x92, 0xB7, 0xCE, 0xD5, 0xD8, 0xBF, 0x9B, 0x7B]};
@GUID(0x9B8B1336, 0x00A5, 0x4668, [0x92, 0xB7, 0xCE, 0xD5, 0xD8, 0xBF, 0x9B, 0x7B]);
interface ID2D1VertexBuffer : IUnknown
{
    HRESULT Map(ubyte** data, uint bufferSize);
    HRESULT Unmap();
}

const GUID IID_ID2D1ResourceTexture = {0x688D15C3, 0x02B0, 0x438D, [0xB1, 0x3A, 0xD1, 0xB4, 0x4C, 0x32, 0xC3, 0x9A]};
@GUID(0x688D15C3, 0x02B0, 0x438D, [0xB1, 0x3A, 0xD1, 0xB4, 0x4C, 0x32, 0xC3, 0x9A]);
interface ID2D1ResourceTexture : IUnknown
{
    HRESULT Update(char* minimumExtents, char* maximimumExtents, char* strides, uint dimensions, char* data, uint dataCount);
}

const GUID IID_ID2D1RenderInfo = {0x519AE1BD, 0xD19A, 0x420D, [0xB8, 0x49, 0x36, 0x4F, 0x59, 0x47, 0x76, 0xB7]};
@GUID(0x519AE1BD, 0xD19A, 0x420D, [0xB8, 0x49, 0x36, 0x4F, 0x59, 0x47, 0x76, 0xB7]);
interface ID2D1RenderInfo : IUnknown
{
    HRESULT SetInputDescription(uint inputIndex, D2D1_INPUT_DESCRIPTION inputDescription);
    HRESULT SetOutputBuffer(D2D1_BUFFER_PRECISION bufferPrecision, D2D1_CHANNEL_DEPTH channelDepth);
    void SetCached(BOOL isCached);
    void SetInstructionCountHint(uint instructionCount);
}

const GUID IID_ID2D1DrawInfo = {0x693CE632, 0x7F2F, 0x45DE, [0x93, 0xFE, 0x18, 0xD8, 0x8B, 0x37, 0xAA, 0x21]};
@GUID(0x693CE632, 0x7F2F, 0x45DE, [0x93, 0xFE, 0x18, 0xD8, 0x8B, 0x37, 0xAA, 0x21]);
interface ID2D1DrawInfo : ID2D1RenderInfo
{
    HRESULT SetPixelShaderConstantBuffer(char* buffer, uint bufferCount);
    HRESULT SetResourceTexture(uint textureIndex, ID2D1ResourceTexture resourceTexture);
    HRESULT SetVertexShaderConstantBuffer(char* buffer, uint bufferCount);
    HRESULT SetPixelShader(const(Guid)* shaderId, D2D1_PIXEL_OPTIONS pixelOptions);
    HRESULT SetVertexProcessing(ID2D1VertexBuffer vertexBuffer, D2D1_VERTEX_OPTIONS vertexOptions, const(D2D1_BLEND_DESCRIPTION)* blendDescription, const(D2D1_VERTEX_RANGE)* vertexRange, const(Guid)* vertexShader);
}

const GUID IID_ID2D1ComputeInfo = {0x5598B14B, 0x9FD7, 0x48B7, [0x9B, 0xDB, 0x8F, 0x09, 0x64, 0xEB, 0x38, 0xBC]};
@GUID(0x5598B14B, 0x9FD7, 0x48B7, [0x9B, 0xDB, 0x8F, 0x09, 0x64, 0xEB, 0x38, 0xBC]);
interface ID2D1ComputeInfo : ID2D1RenderInfo
{
    HRESULT SetComputeShaderConstantBuffer(char* buffer, uint bufferCount);
    HRESULT SetComputeShader(const(Guid)* shaderId);
    HRESULT SetResourceTexture(uint textureIndex, ID2D1ResourceTexture resourceTexture);
}

const GUID IID_ID2D1TransformNode = {0xB2EFE1E7, 0x729F, 0x4102, [0x94, 0x9F, 0x50, 0x5F, 0xA2, 0x1B, 0xF6, 0x66]};
@GUID(0xB2EFE1E7, 0x729F, 0x4102, [0x94, 0x9F, 0x50, 0x5F, 0xA2, 0x1B, 0xF6, 0x66]);
interface ID2D1TransformNode : IUnknown
{
    uint GetInputCount();
}

const GUID IID_ID2D1TransformGraph = {0x13D29038, 0xC3E6, 0x4034, [0x90, 0x81, 0x13, 0xB5, 0x3A, 0x41, 0x79, 0x92]};
@GUID(0x13D29038, 0xC3E6, 0x4034, [0x90, 0x81, 0x13, 0xB5, 0x3A, 0x41, 0x79, 0x92]);
interface ID2D1TransformGraph : IUnknown
{
    uint GetInputCount();
    HRESULT SetSingleTransformNode(ID2D1TransformNode node);
    HRESULT AddNode(ID2D1TransformNode node);
    HRESULT RemoveNode(ID2D1TransformNode node);
    HRESULT SetOutputNode(ID2D1TransformNode node);
    HRESULT ConnectNode(ID2D1TransformNode fromNode, ID2D1TransformNode toNode, uint toNodeInputIndex);
    HRESULT ConnectToEffectInput(uint toEffectInputIndex, ID2D1TransformNode node, uint toNodeInputIndex);
    void Clear();
    HRESULT SetPassthroughGraph(uint effectInputIndex);
}

const GUID IID_ID2D1Transform = {0xEF1A287D, 0x342A, 0x4F76, [0x8F, 0xDB, 0xDA, 0x0D, 0x6E, 0xA9, 0xF9, 0x2B]};
@GUID(0xEF1A287D, 0x342A, 0x4F76, [0x8F, 0xDB, 0xDA, 0x0D, 0x6E, 0xA9, 0xF9, 0x2B]);
interface ID2D1Transform : ID2D1TransformNode
{
    HRESULT MapOutputRectToInputRects(const(RECT)* outputRect, char* inputRects, uint inputRectsCount);
    HRESULT MapInputRectsToOutputRect(char* inputRects, char* inputOpaqueSubRects, uint inputRectCount, RECT* outputRect, RECT* outputOpaqueSubRect);
    HRESULT MapInvalidRect(uint inputIndex, RECT invalidInputRect, RECT* invalidOutputRect);
}

const GUID IID_ID2D1DrawTransform = {0x36BFDCB6, 0x9739, 0x435D, [0xA3, 0x0D, 0xA6, 0x53, 0xBE, 0xFF, 0x6A, 0x6F]};
@GUID(0x36BFDCB6, 0x9739, 0x435D, [0xA3, 0x0D, 0xA6, 0x53, 0xBE, 0xFF, 0x6A, 0x6F]);
interface ID2D1DrawTransform : ID2D1Transform
{
    HRESULT SetDrawInfo(ID2D1DrawInfo drawInfo);
}

const GUID IID_ID2D1ComputeTransform = {0x0D85573C, 0x01E3, 0x4F7D, [0xBF, 0xD9, 0x0D, 0x60, 0x60, 0x8B, 0xF3, 0xC3]};
@GUID(0x0D85573C, 0x01E3, 0x4F7D, [0xBF, 0xD9, 0x0D, 0x60, 0x60, 0x8B, 0xF3, 0xC3]);
interface ID2D1ComputeTransform : ID2D1Transform
{
    HRESULT SetComputeInfo(ID2D1ComputeInfo computeInfo);
    HRESULT CalculateThreadgroups(const(RECT)* outputRect, uint* dimensionX, uint* dimensionY, uint* dimensionZ);
}

const GUID IID_ID2D1AnalysisTransform = {0x0359DC30, 0x95E6, 0x4568, [0x90, 0x55, 0x27, 0x72, 0x0D, 0x13, 0x0E, 0x93]};
@GUID(0x0359DC30, 0x95E6, 0x4568, [0x90, 0x55, 0x27, 0x72, 0x0D, 0x13, 0x0E, 0x93]);
interface ID2D1AnalysisTransform : IUnknown
{
    HRESULT ProcessAnalysisResults(char* analysisData, uint analysisDataCount);
}

const GUID IID_ID2D1SourceTransform = {0xDB1800DD, 0x0C34, 0x4CF9, [0xBE, 0x90, 0x31, 0xCC, 0x0A, 0x56, 0x53, 0xE1]};
@GUID(0xDB1800DD, 0x0C34, 0x4CF9, [0xBE, 0x90, 0x31, 0xCC, 0x0A, 0x56, 0x53, 0xE1]);
interface ID2D1SourceTransform : ID2D1Transform
{
    HRESULT SetRenderInfo(ID2D1RenderInfo renderInfo);
    HRESULT Draw(ID2D1Bitmap1 target, const(RECT)* drawRect, D2D_POINT_2U targetOrigin);
}

const GUID IID_ID2D1ConcreteTransform = {0x1A799D8A, 0x69F7, 0x4E4C, [0x9F, 0xED, 0x43, 0x7C, 0xCC, 0x66, 0x84, 0xCC]};
@GUID(0x1A799D8A, 0x69F7, 0x4E4C, [0x9F, 0xED, 0x43, 0x7C, 0xCC, 0x66, 0x84, 0xCC]);
interface ID2D1ConcreteTransform : ID2D1TransformNode
{
    HRESULT SetOutputBuffer(D2D1_BUFFER_PRECISION bufferPrecision, D2D1_CHANNEL_DEPTH channelDepth);
    void SetCached(BOOL isCached);
}

const GUID IID_ID2D1BlendTransform = {0x63AC0B32, 0xBA44, 0x450F, [0x88, 0x06, 0x7F, 0x4C, 0xA1, 0xFF, 0x2F, 0x1B]};
@GUID(0x63AC0B32, 0xBA44, 0x450F, [0x88, 0x06, 0x7F, 0x4C, 0xA1, 0xFF, 0x2F, 0x1B]);
interface ID2D1BlendTransform : ID2D1ConcreteTransform
{
    void SetDescription(const(D2D1_BLEND_DESCRIPTION)* description);
    void GetDescription(D2D1_BLEND_DESCRIPTION* description);
}

const GUID IID_ID2D1BorderTransform = {0x4998735C, 0x3A19, 0x473C, [0x97, 0x81, 0x65, 0x68, 0x47, 0xE3, 0xA3, 0x47]};
@GUID(0x4998735C, 0x3A19, 0x473C, [0x97, 0x81, 0x65, 0x68, 0x47, 0xE3, 0xA3, 0x47]);
interface ID2D1BorderTransform : ID2D1ConcreteTransform
{
    void SetExtendModeX(D2D1_EXTEND_MODE extendMode);
    void SetExtendModeY(D2D1_EXTEND_MODE extendMode);
    D2D1_EXTEND_MODE GetExtendModeX();
    D2D1_EXTEND_MODE GetExtendModeY();
}

const GUID IID_ID2D1OffsetTransform = {0x3FE6ADEA, 0x7643, 0x4F53, [0xBD, 0x14, 0xA0, 0xCE, 0x63, 0xF2, 0x40, 0x42]};
@GUID(0x3FE6ADEA, 0x7643, 0x4F53, [0xBD, 0x14, 0xA0, 0xCE, 0x63, 0xF2, 0x40, 0x42]);
interface ID2D1OffsetTransform : ID2D1TransformNode
{
    void SetOffset(POINT offset);
    POINT GetOffset();
}

const GUID IID_ID2D1BoundsAdjustmentTransform = {0x90F732E2, 0x5092, 0x4606, [0xA8, 0x19, 0x86, 0x51, 0x97, 0x0B, 0xAC, 0xCD]};
@GUID(0x90F732E2, 0x5092, 0x4606, [0xA8, 0x19, 0x86, 0x51, 0x97, 0x0B, 0xAC, 0xCD]);
interface ID2D1BoundsAdjustmentTransform : ID2D1TransformNode
{
    void SetOutputBounds(const(RECT)* outputBounds);
    void GetOutputBounds(RECT* outputBounds);
}

const GUID IID_ID2D1EffectImpl = {0xA248FD3F, 0x3E6C, 0x4E63, [0x9F, 0x03, 0x7F, 0x68, 0xEC, 0xC9, 0x1D, 0xB9]};
@GUID(0xA248FD3F, 0x3E6C, 0x4E63, [0x9F, 0x03, 0x7F, 0x68, 0xEC, 0xC9, 0x1D, 0xB9]);
interface ID2D1EffectImpl : IUnknown
{
    HRESULT Initialize(ID2D1EffectContext effectContext, ID2D1TransformGraph transformGraph);
    HRESULT PrepareForRender(D2D1_CHANGE_TYPE changeType);
    HRESULT SetGraph(ID2D1TransformGraph transformGraph);
}

const GUID IID_ID2D1EffectContext = {0x3D9F916B, 0x27DC, 0x4AD7, [0xB4, 0xF1, 0x64, 0x94, 0x53, 0x40, 0xF5, 0x63]};
@GUID(0x3D9F916B, 0x27DC, 0x4AD7, [0xB4, 0xF1, 0x64, 0x94, 0x53, 0x40, 0xF5, 0x63]);
interface ID2D1EffectContext : IUnknown
{
    void GetDpi(float* dpiX, float* dpiY);
    HRESULT CreateEffect(const(Guid)* effectId, ID2D1Effect* effect);
    HRESULT GetMaximumSupportedFeatureLevel(char* featureLevels, uint featureLevelsCount, D3D_FEATURE_LEVEL* maximumSupportedFeatureLevel);
    HRESULT CreateTransformNodeFromEffect(ID2D1Effect effect, ID2D1TransformNode* transformNode);
    HRESULT CreateBlendTransform(uint numInputs, const(D2D1_BLEND_DESCRIPTION)* blendDescription, ID2D1BlendTransform* transform);
    HRESULT CreateBorderTransform(D2D1_EXTEND_MODE extendModeX, D2D1_EXTEND_MODE extendModeY, ID2D1BorderTransform* transform);
    HRESULT CreateOffsetTransform(POINT offset, ID2D1OffsetTransform* transform);
    HRESULT CreateBoundsAdjustmentTransform(const(RECT)* outputRectangle, ID2D1BoundsAdjustmentTransform* transform);
    HRESULT LoadPixelShader(const(Guid)* shaderId, char* shaderBuffer, uint shaderBufferCount);
    HRESULT LoadVertexShader(const(Guid)* resourceId, char* shaderBuffer, uint shaderBufferCount);
    HRESULT LoadComputeShader(const(Guid)* resourceId, char* shaderBuffer, uint shaderBufferCount);
    BOOL IsShaderLoaded(const(Guid)* shaderId);
    HRESULT CreateResourceTexture(const(Guid)* resourceId, const(D2D1_RESOURCE_TEXTURE_PROPERTIES)* resourceTextureProperties, char* data, char* strides, uint dataSize, ID2D1ResourceTexture* resourceTexture);
    HRESULT FindResourceTexture(const(Guid)* resourceId, ID2D1ResourceTexture* resourceTexture);
    HRESULT CreateVertexBuffer(const(D2D1_VERTEX_BUFFER_PROPERTIES)* vertexBufferProperties, const(Guid)* resourceId, const(D2D1_CUSTOM_VERTEX_BUFFER_PROPERTIES)* customVertexBufferProperties, ID2D1VertexBuffer* buffer);
    HRESULT FindVertexBuffer(const(Guid)* resourceId, ID2D1VertexBuffer* buffer);
    HRESULT CreateColorContext(D2D1_COLOR_SPACE space, char* profile, uint profileSize, ID2D1ColorContext* colorContext);
    HRESULT CreateColorContextFromFilename(const(wchar)* filename, ID2D1ColorContext* colorContext);
    HRESULT CreateColorContextFromWicColorContext(IWICColorContext wicColorContext, ID2D1ColorContext* colorContext);
    HRESULT CheckFeatureSupport(D2D1_FEATURE feature, char* featureSupportData, uint featureSupportDataSize);
    BOOL IsBufferPrecisionSupported(D2D1_BUFFER_PRECISION bufferPrecision);
}

enum D2D1_YCBCR_PROP
{
    D2D1_YCBCR_PROP_CHROMA_SUBSAMPLING = 0,
    D2D1_YCBCR_PROP_TRANSFORM_MATRIX = 1,
    D2D1_YCBCR_PROP_INTERPOLATION_MODE = 2,
    D2D1_YCBCR_PROP_FORCE_DWORD = 4294967295,
}

enum D2D1_YCBCR_CHROMA_SUBSAMPLING
{
    D2D1_YCBCR_CHROMA_SUBSAMPLING_AUTO = 0,
    D2D1_YCBCR_CHROMA_SUBSAMPLING_420 = 1,
    D2D1_YCBCR_CHROMA_SUBSAMPLING_422 = 2,
    D2D1_YCBCR_CHROMA_SUBSAMPLING_444 = 3,
    D2D1_YCBCR_CHROMA_SUBSAMPLING_440 = 4,
    D2D1_YCBCR_CHROMA_SUBSAMPLING_FORCE_DWORD = 4294967295,
}

enum D2D1_YCBCR_INTERPOLATION_MODE
{
    D2D1_YCBCR_INTERPOLATION_MODE_NEAREST_NEIGHBOR = 0,
    D2D1_YCBCR_INTERPOLATION_MODE_LINEAR = 1,
    D2D1_YCBCR_INTERPOLATION_MODE_CUBIC = 2,
    D2D1_YCBCR_INTERPOLATION_MODE_MULTI_SAMPLE_LINEAR = 3,
    D2D1_YCBCR_INTERPOLATION_MODE_ANISOTROPIC = 4,
    D2D1_YCBCR_INTERPOLATION_MODE_HIGH_QUALITY_CUBIC = 5,
    D2D1_YCBCR_INTERPOLATION_MODE_FORCE_DWORD = 4294967295,
}

enum D2D1_CONTRAST_PROP
{
    D2D1_CONTRAST_PROP_CONTRAST = 0,
    D2D1_CONTRAST_PROP_CLAMP_INPUT = 1,
    D2D1_CONTRAST_PROP_FORCE_DWORD = 4294967295,
}

enum D2D1_RGBTOHUE_PROP
{
    D2D1_RGBTOHUE_PROP_OUTPUT_COLOR_SPACE = 0,
    D2D1_RGBTOHUE_PROP_FORCE_DWORD = 4294967295,
}

enum D2D1_RGBTOHUE_OUTPUT_COLOR_SPACE
{
    D2D1_RGBTOHUE_OUTPUT_COLOR_SPACE_HUE_SATURATION_VALUE = 0,
    D2D1_RGBTOHUE_OUTPUT_COLOR_SPACE_HUE_SATURATION_LIGHTNESS = 1,
    D2D1_RGBTOHUE_OUTPUT_COLOR_SPACE_FORCE_DWORD = 4294967295,
}

enum D2D1_HUETORGB_PROP
{
    D2D1_HUETORGB_PROP_INPUT_COLOR_SPACE = 0,
    D2D1_HUETORGB_PROP_FORCE_DWORD = 4294967295,
}

enum D2D1_HUETORGB_INPUT_COLOR_SPACE
{
    D2D1_HUETORGB_INPUT_COLOR_SPACE_HUE_SATURATION_VALUE = 0,
    D2D1_HUETORGB_INPUT_COLOR_SPACE_HUE_SATURATION_LIGHTNESS = 1,
    D2D1_HUETORGB_INPUT_COLOR_SPACE_FORCE_DWORD = 4294967295,
}

enum D2D1_CHROMAKEY_PROP
{
    D2D1_CHROMAKEY_PROP_COLOR = 0,
    D2D1_CHROMAKEY_PROP_TOLERANCE = 1,
    D2D1_CHROMAKEY_PROP_INVERT_ALPHA = 2,
    D2D1_CHROMAKEY_PROP_FEATHER = 3,
    D2D1_CHROMAKEY_PROP_FORCE_DWORD = 4294967295,
}

enum D2D1_EMBOSS_PROP
{
    D2D1_EMBOSS_PROP_HEIGHT = 0,
    D2D1_EMBOSS_PROP_DIRECTION = 1,
    D2D1_EMBOSS_PROP_FORCE_DWORD = 4294967295,
}

enum D2D1_EXPOSURE_PROP
{
    D2D1_EXPOSURE_PROP_EXPOSURE_VALUE = 0,
    D2D1_EXPOSURE_PROP_FORCE_DWORD = 4294967295,
}

enum D2D1_POSTERIZE_PROP
{
    D2D1_POSTERIZE_PROP_RED_VALUE_COUNT = 0,
    D2D1_POSTERIZE_PROP_GREEN_VALUE_COUNT = 1,
    D2D1_POSTERIZE_PROP_BLUE_VALUE_COUNT = 2,
    D2D1_POSTERIZE_PROP_FORCE_DWORD = 4294967295,
}

enum D2D1_SEPIA_PROP
{
    D2D1_SEPIA_PROP_INTENSITY = 0,
    D2D1_SEPIA_PROP_ALPHA_MODE = 1,
    D2D1_SEPIA_PROP_FORCE_DWORD = 4294967295,
}

enum D2D1_SHARPEN_PROP
{
    D2D1_SHARPEN_PROP_SHARPNESS = 0,
    D2D1_SHARPEN_PROP_THRESHOLD = 1,
    D2D1_SHARPEN_PROP_FORCE_DWORD = 4294967295,
}

enum D2D1_STRAIGHTEN_PROP
{
    D2D1_STRAIGHTEN_PROP_ANGLE = 0,
    D2D1_STRAIGHTEN_PROP_MAINTAIN_SIZE = 1,
    D2D1_STRAIGHTEN_PROP_SCALE_MODE = 2,
    D2D1_STRAIGHTEN_PROP_FORCE_DWORD = 4294967295,
}

enum D2D1_STRAIGHTEN_SCALE_MODE
{
    D2D1_STRAIGHTEN_SCALE_MODE_NEAREST_NEIGHBOR = 0,
    D2D1_STRAIGHTEN_SCALE_MODE_LINEAR = 1,
    D2D1_STRAIGHTEN_SCALE_MODE_CUBIC = 2,
    D2D1_STRAIGHTEN_SCALE_MODE_MULTI_SAMPLE_LINEAR = 3,
    D2D1_STRAIGHTEN_SCALE_MODE_ANISOTROPIC = 4,
    D2D1_STRAIGHTEN_SCALE_MODE_FORCE_DWORD = 4294967295,
}

enum D2D1_TEMPERATUREANDTINT_PROP
{
    D2D1_TEMPERATUREANDTINT_PROP_TEMPERATURE = 0,
    D2D1_TEMPERATUREANDTINT_PROP_TINT = 1,
    D2D1_TEMPERATUREANDTINT_PROP_FORCE_DWORD = 4294967295,
}

enum D2D1_VIGNETTE_PROP
{
    D2D1_VIGNETTE_PROP_COLOR = 0,
    D2D1_VIGNETTE_PROP_TRANSITION_SIZE = 1,
    D2D1_VIGNETTE_PROP_STRENGTH = 2,
    D2D1_VIGNETTE_PROP_FORCE_DWORD = 4294967295,
}

enum D2D1_EDGEDETECTION_PROP
{
    D2D1_EDGEDETECTION_PROP_STRENGTH = 0,
    D2D1_EDGEDETECTION_PROP_BLUR_RADIUS = 1,
    D2D1_EDGEDETECTION_PROP_MODE = 2,
    D2D1_EDGEDETECTION_PROP_OVERLAY_EDGES = 3,
    D2D1_EDGEDETECTION_PROP_ALPHA_MODE = 4,
    D2D1_EDGEDETECTION_PROP_FORCE_DWORD = 4294967295,
}

enum D2D1_EDGEDETECTION_MODE
{
    D2D1_EDGEDETECTION_MODE_SOBEL = 0,
    D2D1_EDGEDETECTION_MODE_PREWITT = 1,
    D2D1_EDGEDETECTION_MODE_FORCE_DWORD = 4294967295,
}

enum D2D1_HIGHLIGHTSANDSHADOWS_PROP
{
    D2D1_HIGHLIGHTSANDSHADOWS_PROP_HIGHLIGHTS = 0,
    D2D1_HIGHLIGHTSANDSHADOWS_PROP_SHADOWS = 1,
    D2D1_HIGHLIGHTSANDSHADOWS_PROP_CLARITY = 2,
    D2D1_HIGHLIGHTSANDSHADOWS_PROP_INPUT_GAMMA = 3,
    D2D1_HIGHLIGHTSANDSHADOWS_PROP_MASK_BLUR_RADIUS = 4,
    D2D1_HIGHLIGHTSANDSHADOWS_PROP_FORCE_DWORD = 4294967295,
}

enum D2D1_HIGHLIGHTSANDSHADOWS_INPUT_GAMMA
{
    D2D1_HIGHLIGHTSANDSHADOWS_INPUT_GAMMA_LINEAR = 0,
    D2D1_HIGHLIGHTSANDSHADOWS_INPUT_GAMMA_SRGB = 1,
    D2D1_HIGHLIGHTSANDSHADOWS_INPUT_GAMMA_FORCE_DWORD = 4294967295,
}

enum D2D1_LOOKUPTABLE3D_PROP
{
    D2D1_LOOKUPTABLE3D_PROP_LUT = 0,
    D2D1_LOOKUPTABLE3D_PROP_ALPHA_MODE = 1,
    D2D1_LOOKUPTABLE3D_PROP_FORCE_DWORD = 4294967295,
}

enum D2D1_OPACITY_PROP
{
    D2D1_OPACITY_PROP_OPACITY = 0,
    D2D1_OPACITY_PROP_FORCE_DWORD = 4294967295,
}

enum D2D1_CROSSFADE_PROP
{
    D2D1_CROSSFADE_PROP_WEIGHT = 0,
    D2D1_CROSSFADE_PROP_FORCE_DWORD = 4294967295,
}

enum D2D1_TINT_PROP
{
    D2D1_TINT_PROP_COLOR = 0,
    D2D1_TINT_PROP_CLAMP_OUTPUT = 1,
    D2D1_TINT_PROP_FORCE_DWORD = 4294967295,
}

enum D2D1_WHITELEVELADJUSTMENT_PROP
{
    D2D1_WHITELEVELADJUSTMENT_PROP_INPUT_WHITE_LEVEL = 0,
    D2D1_WHITELEVELADJUSTMENT_PROP_OUTPUT_WHITE_LEVEL = 1,
    D2D1_WHITELEVELADJUSTMENT_PROP_FORCE_DWORD = 4294967295,
}

enum D2D1_HDRTONEMAP_PROP
{
    D2D1_HDRTONEMAP_PROP_INPUT_MAX_LUMINANCE = 0,
    D2D1_HDRTONEMAP_PROP_OUTPUT_MAX_LUMINANCE = 1,
    D2D1_HDRTONEMAP_PROP_DISPLAY_MODE = 2,
    D2D1_HDRTONEMAP_PROP_FORCE_DWORD = 4294967295,
}

enum D2D1_HDRTONEMAP_DISPLAY_MODE
{
    D2D1_HDRTONEMAP_DISPLAY_MODE_SDR = 0,
    D2D1_HDRTONEMAP_DISPLAY_MODE_HDR = 1,
    D2D1_HDRTONEMAP_DISPLAY_MODE_FORCE_DWORD = 4294967295,
}

enum D2D1_RENDERING_PRIORITY
{
    D2D1_RENDERING_PRIORITY_NORMAL = 0,
    D2D1_RENDERING_PRIORITY_LOW = 1,
    D2D1_RENDERING_PRIORITY_FORCE_DWORD = 4294967295,
}

const GUID IID_ID2D1GeometryRealization = {0xA16907D7, 0xBC02, 0x4801, [0x99, 0xE8, 0x8C, 0xF7, 0xF4, 0x85, 0xF7, 0x74]};
@GUID(0xA16907D7, 0xBC02, 0x4801, [0x99, 0xE8, 0x8C, 0xF7, 0xF4, 0x85, 0xF7, 0x74]);
interface ID2D1GeometryRealization : ID2D1Resource
{
}

const GUID IID_ID2D1DeviceContext1 = {0xD37F57E4, 0x6908, 0x459F, [0xA1, 0x99, 0xE7, 0x2F, 0x24, 0xF7, 0x99, 0x87]};
@GUID(0xD37F57E4, 0x6908, 0x459F, [0xA1, 0x99, 0xE7, 0x2F, 0x24, 0xF7, 0x99, 0x87]);
interface ID2D1DeviceContext1 : ID2D1DeviceContext
{
    HRESULT CreateFilledGeometryRealization(ID2D1Geometry geometry, float flatteningTolerance, ID2D1GeometryRealization* geometryRealization);
    HRESULT CreateStrokedGeometryRealization(ID2D1Geometry geometry, float flatteningTolerance, float strokeWidth, ID2D1StrokeStyle strokeStyle, ID2D1GeometryRealization* geometryRealization);
    void DrawGeometryRealization(ID2D1GeometryRealization geometryRealization, ID2D1Brush brush);
}

const GUID IID_ID2D1Device1 = {0xD21768E1, 0x23A4, 0x4823, [0xA1, 0x4B, 0x7C, 0x3E, 0xBA, 0x85, 0xD6, 0x58]};
@GUID(0xD21768E1, 0x23A4, 0x4823, [0xA1, 0x4B, 0x7C, 0x3E, 0xBA, 0x85, 0xD6, 0x58]);
interface ID2D1Device1 : ID2D1Device
{
    D2D1_RENDERING_PRIORITY GetRenderingPriority();
    void SetRenderingPriority(D2D1_RENDERING_PRIORITY renderingPriority);
    HRESULT CreateDeviceContext(D2D1_DEVICE_CONTEXT_OPTIONS options, ID2D1DeviceContext1* deviceContext1);
}

const GUID IID_ID2D1Factory2 = {0x94F81A73, 0x9212, 0x4376, [0x9C, 0x58, 0xB1, 0x6A, 0x3A, 0x0D, 0x39, 0x92]};
@GUID(0x94F81A73, 0x9212, 0x4376, [0x9C, 0x58, 0xB1, 0x6A, 0x3A, 0x0D, 0x39, 0x92]);
interface ID2D1Factory2 : ID2D1Factory1
{
    HRESULT CreateDevice(IDXGIDevice dxgiDevice, ID2D1Device1* d2dDevice1);
}

const GUID IID_ID2D1CommandSink1 = {0x9EB767FD, 0x4269, 0x4467, [0xB8, 0xC2, 0xEB, 0x30, 0xCB, 0x30, 0x57, 0x43]};
@GUID(0x9EB767FD, 0x4269, 0x4467, [0xB8, 0xC2, 0xEB, 0x30, 0xCB, 0x30, 0x57, 0x43]);
interface ID2D1CommandSink1 : ID2D1CommandSink
{
    HRESULT SetPrimitiveBlend1(D2D1_PRIMITIVE_BLEND primitiveBlend);
}

enum D2D1_SVG_PAINT_TYPE
{
    D2D1_SVG_PAINT_TYPE_NONE = 0,
    D2D1_SVG_PAINT_TYPE_COLOR = 1,
    D2D1_SVG_PAINT_TYPE_CURRENT_COLOR = 2,
    D2D1_SVG_PAINT_TYPE_URI = 3,
    D2D1_SVG_PAINT_TYPE_URI_NONE = 4,
    D2D1_SVG_PAINT_TYPE_URI_COLOR = 5,
    D2D1_SVG_PAINT_TYPE_URI_CURRENT_COLOR = 6,
    D2D1_SVG_PAINT_TYPE_FORCE_DWORD = 4294967295,
}

enum D2D1_SVG_LENGTH_UNITS
{
    D2D1_SVG_LENGTH_UNITS_NUMBER = 0,
    D2D1_SVG_LENGTH_UNITS_PERCENTAGE = 1,
    D2D1_SVG_LENGTH_UNITS_FORCE_DWORD = 4294967295,
}

enum D2D1_SVG_DISPLAY
{
    D2D1_SVG_DISPLAY_INLINE = 0,
    D2D1_SVG_DISPLAY_NONE = 1,
    D2D1_SVG_DISPLAY_FORCE_DWORD = 4294967295,
}

enum D2D1_SVG_VISIBILITY
{
    D2D1_SVG_VISIBILITY_VISIBLE = 0,
    D2D1_SVG_VISIBILITY_HIDDEN = 1,
    D2D1_SVG_VISIBILITY_FORCE_DWORD = 4294967295,
}

enum D2D1_SVG_OVERFLOW
{
    D2D1_SVG_OVERFLOW_VISIBLE = 0,
    D2D1_SVG_OVERFLOW_HIDDEN = 1,
    D2D1_SVG_OVERFLOW_FORCE_DWORD = 4294967295,
}

enum D2D1_SVG_LINE_CAP
{
    D2D1_SVG_LINE_CAP_BUTT = 0,
    D2D1_SVG_LINE_CAP_SQUARE = 1,
    D2D1_SVG_LINE_CAP_ROUND = 2,
    D2D1_SVG_LINE_CAP_FORCE_DWORD = 4294967295,
}

enum D2D1_SVG_LINE_JOIN
{
    D2D1_SVG_LINE_JOIN_BEVEL = 1,
    D2D1_SVG_LINE_JOIN_MITER = 3,
    D2D1_SVG_LINE_JOIN_ROUND = 2,
    D2D1_SVG_LINE_JOIN_FORCE_DWORD = 4294967295,
}

enum D2D1_SVG_ASPECT_ALIGN
{
    D2D1_SVG_ASPECT_ALIGN_NONE = 0,
    D2D1_SVG_ASPECT_ALIGN_X_MIN_Y_MIN = 1,
    D2D1_SVG_ASPECT_ALIGN_X_MID_Y_MIN = 2,
    D2D1_SVG_ASPECT_ALIGN_X_MAX_Y_MIN = 3,
    D2D1_SVG_ASPECT_ALIGN_X_MIN_Y_MID = 4,
    D2D1_SVG_ASPECT_ALIGN_X_MID_Y_MID = 5,
    D2D1_SVG_ASPECT_ALIGN_X_MAX_Y_MID = 6,
    D2D1_SVG_ASPECT_ALIGN_X_MIN_Y_MAX = 7,
    D2D1_SVG_ASPECT_ALIGN_X_MID_Y_MAX = 8,
    D2D1_SVG_ASPECT_ALIGN_X_MAX_Y_MAX = 9,
    D2D1_SVG_ASPECT_ALIGN_FORCE_DWORD = 4294967295,
}

enum D2D1_SVG_ASPECT_SCALING
{
    D2D1_SVG_ASPECT_SCALING_MEET = 0,
    D2D1_SVG_ASPECT_SCALING_SLICE = 1,
    D2D1_SVG_ASPECT_SCALING_FORCE_DWORD = 4294967295,
}

enum D2D1_SVG_PATH_COMMAND
{
    D2D1_SVG_PATH_COMMAND_CLOSE_PATH = 0,
    D2D1_SVG_PATH_COMMAND_MOVE_ABSOLUTE = 1,
    D2D1_SVG_PATH_COMMAND_MOVE_RELATIVE = 2,
    D2D1_SVG_PATH_COMMAND_LINE_ABSOLUTE = 3,
    D2D1_SVG_PATH_COMMAND_LINE_RELATIVE = 4,
    D2D1_SVG_PATH_COMMAND_CUBIC_ABSOLUTE = 5,
    D2D1_SVG_PATH_COMMAND_CUBIC_RELATIVE = 6,
    D2D1_SVG_PATH_COMMAND_QUADRADIC_ABSOLUTE = 7,
    D2D1_SVG_PATH_COMMAND_QUADRADIC_RELATIVE = 8,
    D2D1_SVG_PATH_COMMAND_ARC_ABSOLUTE = 9,
    D2D1_SVG_PATH_COMMAND_ARC_RELATIVE = 10,
    D2D1_SVG_PATH_COMMAND_HORIZONTAL_ABSOLUTE = 11,
    D2D1_SVG_PATH_COMMAND_HORIZONTAL_RELATIVE = 12,
    D2D1_SVG_PATH_COMMAND_VERTICAL_ABSOLUTE = 13,
    D2D1_SVG_PATH_COMMAND_VERTICAL_RELATIVE = 14,
    D2D1_SVG_PATH_COMMAND_CUBIC_SMOOTH_ABSOLUTE = 15,
    D2D1_SVG_PATH_COMMAND_CUBIC_SMOOTH_RELATIVE = 16,
    D2D1_SVG_PATH_COMMAND_QUADRADIC_SMOOTH_ABSOLUTE = 17,
    D2D1_SVG_PATH_COMMAND_QUADRADIC_SMOOTH_RELATIVE = 18,
    D2D1_SVG_PATH_COMMAND_FORCE_DWORD = 4294967295,
}

enum D2D1_SVG_UNIT_TYPE
{
    D2D1_SVG_UNIT_TYPE_USER_SPACE_ON_USE = 0,
    D2D1_SVG_UNIT_TYPE_OBJECT_BOUNDING_BOX = 1,
    D2D1_SVG_UNIT_TYPE_FORCE_DWORD = 4294967295,
}

enum D2D1_SVG_ATTRIBUTE_STRING_TYPE
{
    D2D1_SVG_ATTRIBUTE_STRING_TYPE_SVG = 0,
    D2D1_SVG_ATTRIBUTE_STRING_TYPE_ID = 1,
    D2D1_SVG_ATTRIBUTE_STRING_TYPE_FORCE_DWORD = 4294967295,
}

enum D2D1_SVG_ATTRIBUTE_POD_TYPE
{
    D2D1_SVG_ATTRIBUTE_POD_TYPE_FLOAT = 0,
    D2D1_SVG_ATTRIBUTE_POD_TYPE_COLOR = 1,
    D2D1_SVG_ATTRIBUTE_POD_TYPE_FILL_MODE = 2,
    D2D1_SVG_ATTRIBUTE_POD_TYPE_DISPLAY = 3,
    D2D1_SVG_ATTRIBUTE_POD_TYPE_OVERFLOW = 4,
    D2D1_SVG_ATTRIBUTE_POD_TYPE_LINE_CAP = 5,
    D2D1_SVG_ATTRIBUTE_POD_TYPE_LINE_JOIN = 6,
    D2D1_SVG_ATTRIBUTE_POD_TYPE_VISIBILITY = 7,
    D2D1_SVG_ATTRIBUTE_POD_TYPE_MATRIX = 8,
    D2D1_SVG_ATTRIBUTE_POD_TYPE_UNIT_TYPE = 9,
    D2D1_SVG_ATTRIBUTE_POD_TYPE_EXTEND_MODE = 10,
    D2D1_SVG_ATTRIBUTE_POD_TYPE_PRESERVE_ASPECT_RATIO = 11,
    D2D1_SVG_ATTRIBUTE_POD_TYPE_VIEWBOX = 12,
    D2D1_SVG_ATTRIBUTE_POD_TYPE_LENGTH = 13,
    D2D1_SVG_ATTRIBUTE_POD_TYPE_FORCE_DWORD = 4294967295,
}

struct D2D1_SVG_LENGTH
{
    float value;
    D2D1_SVG_LENGTH_UNITS units;
}

struct D2D1_SVG_PRESERVE_ASPECT_RATIO
{
    BOOL defer;
    D2D1_SVG_ASPECT_ALIGN align;
    D2D1_SVG_ASPECT_SCALING meetOrSlice;
}

struct D2D1_SVG_VIEWBOX
{
    float x;
    float y;
    float width;
    float height;
}

const GUID IID_ID2D1SvgAttribute = {0xC9CDB0DD, 0xF8C9, 0x4E70, [0xB7, 0xC2, 0x30, 0x1C, 0x80, 0x29, 0x2C, 0x5E]};
@GUID(0xC9CDB0DD, 0xF8C9, 0x4E70, [0xB7, 0xC2, 0x30, 0x1C, 0x80, 0x29, 0x2C, 0x5E]);
interface ID2D1SvgAttribute : ID2D1Resource
{
    void GetElement(ID2D1SvgElement* element);
    HRESULT Clone(ID2D1SvgAttribute* attribute);
}

const GUID IID_ID2D1SvgPaint = {0xD59BAB0A, 0x68A2, 0x455B, [0xA5, 0xDC, 0x9E, 0xB2, 0x85, 0x4E, 0x24, 0x90]};
@GUID(0xD59BAB0A, 0x68A2, 0x455B, [0xA5, 0xDC, 0x9E, 0xB2, 0x85, 0x4E, 0x24, 0x90]);
interface ID2D1SvgPaint : ID2D1SvgAttribute
{
    HRESULT SetPaintType(D2D1_SVG_PAINT_TYPE paintType);
    D2D1_SVG_PAINT_TYPE GetPaintType();
    HRESULT SetColor(const(DXGI_RGBA)* color);
    void GetColor(DXGI_RGBA* color);
    HRESULT SetId(const(wchar)* id);
    HRESULT GetId(const(wchar)* id, uint idCount);
    uint GetIdLength();
}

const GUID IID_ID2D1SvgStrokeDashArray = {0xF1C0CA52, 0x92A3, 0x4F00, [0xB4, 0xCE, 0xF3, 0x56, 0x91, 0xEF, 0xD9, 0xD9]};
@GUID(0xF1C0CA52, 0x92A3, 0x4F00, [0xB4, 0xCE, 0xF3, 0x56, 0x91, 0xEF, 0xD9, 0xD9]);
interface ID2D1SvgStrokeDashArray : ID2D1SvgAttribute
{
    HRESULT RemoveDashesAtEnd(uint dashesCount);
    HRESULT UpdateDashes(char* dashes, uint dashesCount, uint startIndex);
    HRESULT UpdateDashes(char* dashes, uint dashesCount, uint startIndex);
    HRESULT GetDashes(char* dashes, uint dashesCount, uint startIndex);
    HRESULT GetDashes(char* dashes, uint dashesCount, uint startIndex);
    uint GetDashesCount();
}

const GUID IID_ID2D1SvgPointCollection = {0x9DBE4C0D, 0x3572, 0x4DD9, [0x98, 0x25, 0x55, 0x30, 0x81, 0x3B, 0xB7, 0x12]};
@GUID(0x9DBE4C0D, 0x3572, 0x4DD9, [0x98, 0x25, 0x55, 0x30, 0x81, 0x3B, 0xB7, 0x12]);
interface ID2D1SvgPointCollection : ID2D1SvgAttribute
{
    HRESULT RemovePointsAtEnd(uint pointsCount);
    HRESULT UpdatePoints(char* points, uint pointsCount, uint startIndex);
    HRESULT GetPoints(char* points, uint pointsCount, uint startIndex);
    uint GetPointsCount();
}

const GUID IID_ID2D1SvgPathData = {0xC095E4F4, 0xBB98, 0x43D6, [0x97, 0x45, 0x4D, 0x1B, 0x84, 0xEC, 0x98, 0x88]};
@GUID(0xC095E4F4, 0xBB98, 0x43D6, [0x97, 0x45, 0x4D, 0x1B, 0x84, 0xEC, 0x98, 0x88]);
interface ID2D1SvgPathData : ID2D1SvgAttribute
{
    HRESULT RemoveSegmentDataAtEnd(uint dataCount);
    HRESULT UpdateSegmentData(char* data, uint dataCount, uint startIndex);
    HRESULT GetSegmentData(char* data, uint dataCount, uint startIndex);
    uint GetSegmentDataCount();
    HRESULT RemoveCommandsAtEnd(uint commandsCount);
    HRESULT UpdateCommands(char* commands, uint commandsCount, uint startIndex);
    HRESULT GetCommands(char* commands, uint commandsCount, uint startIndex);
    uint GetCommandsCount();
    HRESULT CreatePathGeometry(D2D1_FILL_MODE fillMode, ID2D1PathGeometry1* pathGeometry);
}

const GUID IID_ID2D1SvgElement = {0xAC7B67A6, 0x183E, 0x49C1, [0xA8, 0x23, 0x0E, 0xBE, 0x40, 0xB0, 0xDB, 0x29]};
@GUID(0xAC7B67A6, 0x183E, 0x49C1, [0xA8, 0x23, 0x0E, 0xBE, 0x40, 0xB0, 0xDB, 0x29]);
interface ID2D1SvgElement : ID2D1Resource
{
    void GetDocument(ID2D1SvgDocument* document);
    HRESULT GetTagName(const(wchar)* name, uint nameCount);
    uint GetTagNameLength();
    BOOL IsTextContent();
    void GetParent(ID2D1SvgElement* parent);
    BOOL HasChildren();
    void GetFirstChild(ID2D1SvgElement* child);
    void GetLastChild(ID2D1SvgElement* child);
    HRESULT GetPreviousChild(ID2D1SvgElement referenceChild, ID2D1SvgElement* previousChild);
    HRESULT GetNextChild(ID2D1SvgElement referenceChild, ID2D1SvgElement* nextChild);
    HRESULT InsertChildBefore(ID2D1SvgElement newChild, ID2D1SvgElement referenceChild);
    HRESULT AppendChild(ID2D1SvgElement newChild);
    HRESULT ReplaceChild(ID2D1SvgElement newChild, ID2D1SvgElement oldChild);
    HRESULT RemoveChild(ID2D1SvgElement oldChild);
    HRESULT CreateChild(const(wchar)* tagName, ID2D1SvgElement* newChild);
    BOOL IsAttributeSpecified(const(wchar)* name, int* inherited);
    uint GetSpecifiedAttributeCount();
    HRESULT GetSpecifiedAttributeName(uint index, const(wchar)* name, uint nameCount, int* inherited);
    HRESULT GetSpecifiedAttributeNameLength(uint index, uint* nameLength, int* inherited);
    HRESULT RemoveAttribute(const(wchar)* name);
    HRESULT SetTextValue(const(wchar)* name, uint nameCount);
    HRESULT GetTextValue(const(wchar)* name, uint nameCount);
    uint GetTextValueLength();
    HRESULT SetAttributeValue(const(wchar)* name, D2D1_SVG_ATTRIBUTE_STRING_TYPE type, const(wchar)* value);
    HRESULT GetAttributeValue(const(wchar)* name, D2D1_SVG_ATTRIBUTE_STRING_TYPE type, const(wchar)* value, uint valueCount);
    HRESULT GetAttributeValueLength(const(wchar)* name, D2D1_SVG_ATTRIBUTE_STRING_TYPE type, uint* valueLength);
    HRESULT SetAttributeValue(const(wchar)* name, D2D1_SVG_ATTRIBUTE_POD_TYPE type, char* value, uint valueSizeInBytes);
    HRESULT GetAttributeValue(const(wchar)* name, D2D1_SVG_ATTRIBUTE_POD_TYPE type, char* value, uint valueSizeInBytes);
    HRESULT SetAttributeValue(const(wchar)* name, ID2D1SvgAttribute value);
    HRESULT GetAttributeValue(const(wchar)* name, const(Guid)* riid, void** value);
}

const GUID IID_ID2D1SvgDocument = {0x86B88E4D, 0xAFA4, 0x4D7B, [0x88, 0xE4, 0x68, 0xA5, 0x1C, 0x4A, 0x0A, 0xEC]};
@GUID(0x86B88E4D, 0xAFA4, 0x4D7B, [0x88, 0xE4, 0x68, 0xA5, 0x1C, 0x4A, 0x0A, 0xEC]);
interface ID2D1SvgDocument : ID2D1Resource
{
    HRESULT SetViewportSize(D2D_SIZE_F viewportSize);
    D2D_SIZE_F GetViewportSize();
    HRESULT SetRoot(ID2D1SvgElement root);
    void GetRoot(ID2D1SvgElement* root);
    HRESULT FindElementById(const(wchar)* id, ID2D1SvgElement* svgElement);
    HRESULT Serialize(IStream outputXmlStream, ID2D1SvgElement subtree);
    HRESULT Deserialize(IStream inputXmlStream, ID2D1SvgElement* subtree);
    HRESULT CreatePaint(D2D1_SVG_PAINT_TYPE paintType, const(DXGI_RGBA)* color, const(wchar)* id, ID2D1SvgPaint* paint);
    HRESULT CreateStrokeDashArray(char* dashes, uint dashesCount, ID2D1SvgStrokeDashArray* strokeDashArray);
    HRESULT CreatePointCollection(char* points, uint pointsCount, ID2D1SvgPointCollection* pointCollection);
    HRESULT CreatePathData(char* segmentData, uint segmentDataCount, char* commands, uint commandsCount, ID2D1SvgPathData* pathData);
}

enum D2D1_INK_NIB_SHAPE
{
    D2D1_INK_NIB_SHAPE_ROUND = 0,
    D2D1_INK_NIB_SHAPE_SQUARE = 1,
    D2D1_INK_NIB_SHAPE_FORCE_DWORD = 4294967295,
}

enum D2D1_ORIENTATION
{
    D2D1_ORIENTATION_DEFAULT = 1,
    D2D1_ORIENTATION_FLIP_HORIZONTAL = 2,
    D2D1_ORIENTATION_ROTATE_CLOCKWISE180 = 3,
    D2D1_ORIENTATION_ROTATE_CLOCKWISE180_FLIP_HORIZONTAL = 4,
    D2D1_ORIENTATION_ROTATE_CLOCKWISE90_FLIP_HORIZONTAL = 5,
    D2D1_ORIENTATION_ROTATE_CLOCKWISE270 = 6,
    D2D1_ORIENTATION_ROTATE_CLOCKWISE270_FLIP_HORIZONTAL = 7,
    D2D1_ORIENTATION_ROTATE_CLOCKWISE90 = 8,
    D2D1_ORIENTATION_FORCE_DWORD = 4294967295,
}

enum D2D1_IMAGE_SOURCE_LOADING_OPTIONS
{
    D2D1_IMAGE_SOURCE_LOADING_OPTIONS_NONE = 0,
    D2D1_IMAGE_SOURCE_LOADING_OPTIONS_RELEASE_SOURCE = 1,
    D2D1_IMAGE_SOURCE_LOADING_OPTIONS_CACHE_ON_DEMAND = 2,
    D2D1_IMAGE_SOURCE_LOADING_OPTIONS_FORCE_DWORD = 4294967295,
}

enum D2D1_IMAGE_SOURCE_FROM_DXGI_OPTIONS
{
    D2D1_IMAGE_SOURCE_FROM_DXGI_OPTIONS_NONE = 0,
    D2D1_IMAGE_SOURCE_FROM_DXGI_OPTIONS_LOW_QUALITY_PRIMARY_CONVERSION = 1,
    D2D1_IMAGE_SOURCE_FROM_DXGI_OPTIONS_FORCE_DWORD = 4294967295,
}

enum D2D1_TRANSFORMED_IMAGE_SOURCE_OPTIONS
{
    D2D1_TRANSFORMED_IMAGE_SOURCE_OPTIONS_NONE = 0,
    D2D1_TRANSFORMED_IMAGE_SOURCE_OPTIONS_DISABLE_DPI_SCALE = 1,
    D2D1_TRANSFORMED_IMAGE_SOURCE_OPTIONS_FORCE_DWORD = 4294967295,
}

struct D2D1_TRANSFORMED_IMAGE_SOURCE_PROPERTIES
{
    D2D1_ORIENTATION orientation;
    float scaleX;
    float scaleY;
    D2D1_INTERPOLATION_MODE interpolationMode;
    D2D1_TRANSFORMED_IMAGE_SOURCE_OPTIONS options;
}

struct D2D1_INK_POINT
{
    float x;
    float y;
    float radius;
}

struct D2D1_INK_BEZIER_SEGMENT
{
    D2D1_INK_POINT point1;
    D2D1_INK_POINT point2;
    D2D1_INK_POINT point3;
}

struct D2D1_INK_STYLE_PROPERTIES
{
    D2D1_INK_NIB_SHAPE nibShape;
    D2D_MATRIX_3X2_F nibTransform;
}

enum D2D1_PATCH_EDGE_MODE
{
    D2D1_PATCH_EDGE_MODE_ALIASED = 0,
    D2D1_PATCH_EDGE_MODE_ANTIALIASED = 1,
    D2D1_PATCH_EDGE_MODE_ALIASED_INFLATED = 2,
    D2D1_PATCH_EDGE_MODE_FORCE_DWORD = 4294967295,
}

struct D2D1_GRADIENT_MESH_PATCH
{
    D2D_POINT_2F point00;
    D2D_POINT_2F point01;
    D2D_POINT_2F point02;
    D2D_POINT_2F point03;
    D2D_POINT_2F point10;
    D2D_POINT_2F point11;
    D2D_POINT_2F point12;
    D2D_POINT_2F point13;
    D2D_POINT_2F point20;
    D2D_POINT_2F point21;
    D2D_POINT_2F point22;
    D2D_POINT_2F point23;
    D2D_POINT_2F point30;
    D2D_POINT_2F point31;
    D2D_POINT_2F point32;
    D2D_POINT_2F point33;
    DXGI_RGBA color00;
    DXGI_RGBA color03;
    DXGI_RGBA color30;
    DXGI_RGBA color33;
    D2D1_PATCH_EDGE_MODE topEdgeMode;
    D2D1_PATCH_EDGE_MODE leftEdgeMode;
    D2D1_PATCH_EDGE_MODE bottomEdgeMode;
    D2D1_PATCH_EDGE_MODE rightEdgeMode;
}

enum D2D1_SPRITE_OPTIONS
{
    D2D1_SPRITE_OPTIONS_NONE = 0,
    D2D1_SPRITE_OPTIONS_CLAMP_TO_SOURCE_RECTANGLE = 1,
    D2D1_SPRITE_OPTIONS_FORCE_DWORD = 4294967295,
}

enum D2D1_COLOR_BITMAP_GLYPH_SNAP_OPTION
{
    D2D1_COLOR_BITMAP_GLYPH_SNAP_OPTION_DEFAULT = 0,
    D2D1_COLOR_BITMAP_GLYPH_SNAP_OPTION_DISABLE = 1,
    D2D1_COLOR_BITMAP_GLYPH_SNAP_OPTION_FORCE_DWORD = 4294967295,
}

enum D2D1_GAMMA1
{
    D2D1_GAMMA1_G22 = 0,
    D2D1_GAMMA1_G10 = 1,
    D2D1_GAMMA1_G2084 = 2,
    D2D1_GAMMA1_FORCE_DWORD = 4294967295,
}

struct D2D1_SIMPLE_COLOR_PROFILE
{
    D2D_POINT_2F redPrimary;
    D2D_POINT_2F greenPrimary;
    D2D_POINT_2F bluePrimary;
    D2D_POINT_2F whitePointXZ;
    D2D1_GAMMA1 gamma;
}

enum D2D1_COLOR_CONTEXT_TYPE
{
    D2D1_COLOR_CONTEXT_TYPE_ICC = 0,
    D2D1_COLOR_CONTEXT_TYPE_SIMPLE = 1,
    D2D1_COLOR_CONTEXT_TYPE_DXGI = 2,
    D2D1_COLOR_CONTEXT_TYPE_FORCE_DWORD = 4294967295,
}

const GUID IID_ID2D1InkStyle = {0xBAE8B344, 0x23FC, 0x4071, [0x8C, 0xB5, 0xD0, 0x5D, 0x6F, 0x07, 0x38, 0x48]};
@GUID(0xBAE8B344, 0x23FC, 0x4071, [0x8C, 0xB5, 0xD0, 0x5D, 0x6F, 0x07, 0x38, 0x48]);
interface ID2D1InkStyle : ID2D1Resource
{
    void SetNibTransform(const(D2D_MATRIX_3X2_F)* transform);
    void GetNibTransform(D2D_MATRIX_3X2_F* transform);
    void SetNibShape(D2D1_INK_NIB_SHAPE nibShape);
    D2D1_INK_NIB_SHAPE GetNibShape();
}

const GUID IID_ID2D1Ink = {0xB499923B, 0x7029, 0x478F, [0xA8, 0xB3, 0x43, 0x2C, 0x7C, 0x5F, 0x53, 0x12]};
@GUID(0xB499923B, 0x7029, 0x478F, [0xA8, 0xB3, 0x43, 0x2C, 0x7C, 0x5F, 0x53, 0x12]);
interface ID2D1Ink : ID2D1Resource
{
    void SetStartPoint(const(D2D1_INK_POINT)* startPoint);
    D2D1_INK_POINT GetStartPoint();
    HRESULT AddSegments(char* segments, uint segmentsCount);
    HRESULT RemoveSegmentsAtEnd(uint segmentsCount);
    HRESULT SetSegments(uint startSegment, char* segments, uint segmentsCount);
    HRESULT SetSegmentAtEnd(const(D2D1_INK_BEZIER_SEGMENT)* segment);
    uint GetSegmentCount();
    HRESULT GetSegments(uint startSegment, char* segments, uint segmentsCount);
    HRESULT StreamAsGeometry(ID2D1InkStyle inkStyle, const(D2D_MATRIX_3X2_F)* worldTransform, float flatteningTolerance, ID2D1SimplifiedGeometrySink geometrySink);
    HRESULT GetBounds(ID2D1InkStyle inkStyle, const(D2D_MATRIX_3X2_F)* worldTransform, D2D_RECT_F* bounds);
}

const GUID IID_ID2D1GradientMesh = {0xF292E401, 0xC050, 0x4CDE, [0x83, 0xD7, 0x04, 0x96, 0x2D, 0x3B, 0x23, 0xC2]};
@GUID(0xF292E401, 0xC050, 0x4CDE, [0x83, 0xD7, 0x04, 0x96, 0x2D, 0x3B, 0x23, 0xC2]);
interface ID2D1GradientMesh : ID2D1Resource
{
    uint GetPatchCount();
    HRESULT GetPatches(uint startIndex, char* patches, uint patchesCount);
}

const GUID IID_ID2D1ImageSource = {0xC9B664E5, 0x74A1, 0x4378, [0x9A, 0xC2, 0xEE, 0xFC, 0x37, 0xA3, 0xF4, 0xD8]};
@GUID(0xC9B664E5, 0x74A1, 0x4378, [0x9A, 0xC2, 0xEE, 0xFC, 0x37, 0xA3, 0xF4, 0xD8]);
interface ID2D1ImageSource : ID2D1Image
{
    HRESULT OfferResources();
    HRESULT TryReclaimResources(int* resourcesDiscarded);
}

const GUID IID_ID2D1ImageSourceFromWic = {0x77395441, 0x1C8F, 0x4555, [0x86, 0x83, 0xF5, 0x0D, 0xAB, 0x0F, 0xE7, 0x92]};
@GUID(0x77395441, 0x1C8F, 0x4555, [0x86, 0x83, 0xF5, 0x0D, 0xAB, 0x0F, 0xE7, 0x92]);
interface ID2D1ImageSourceFromWic : ID2D1ImageSource
{
    HRESULT EnsureCached(const(D2D_RECT_U)* rectangleToFill);
    HRESULT TrimCache(const(D2D_RECT_U)* rectangleToPreserve);
    void GetSource(IWICBitmapSource* wicBitmapSource);
}

const GUID IID_ID2D1TransformedImageSource = {0x7F1F79E5, 0x2796, 0x416C, [0x8F, 0x55, 0x70, 0x0F, 0x91, 0x14, 0x45, 0xE5]};
@GUID(0x7F1F79E5, 0x2796, 0x416C, [0x8F, 0x55, 0x70, 0x0F, 0x91, 0x14, 0x45, 0xE5]);
interface ID2D1TransformedImageSource : ID2D1Image
{
    void GetSource(ID2D1ImageSource* imageSource);
    void GetProperties(D2D1_TRANSFORMED_IMAGE_SOURCE_PROPERTIES* properties);
}

const GUID IID_ID2D1LookupTable3D = {0x53DD9855, 0xA3B0, 0x4D5B, [0x82, 0xE1, 0x26, 0xE2, 0x5C, 0x5E, 0x57, 0x97]};
@GUID(0x53DD9855, 0xA3B0, 0x4D5B, [0x82, 0xE1, 0x26, 0xE2, 0x5C, 0x5E, 0x57, 0x97]);
interface ID2D1LookupTable3D : ID2D1Resource
{
}

const GUID IID_ID2D1DeviceContext2 = {0x394EA6A3, 0x0C34, 0x4321, [0x95, 0x0B, 0x6C, 0xA2, 0x0F, 0x0B, 0xE6, 0xC7]};
@GUID(0x394EA6A3, 0x0C34, 0x4321, [0x95, 0x0B, 0x6C, 0xA2, 0x0F, 0x0B, 0xE6, 0xC7]);
interface ID2D1DeviceContext2 : ID2D1DeviceContext1
{
    HRESULT CreateInk(const(D2D1_INK_POINT)* startPoint, ID2D1Ink* ink);
    HRESULT CreateInkStyle(const(D2D1_INK_STYLE_PROPERTIES)* inkStyleProperties, ID2D1InkStyle* inkStyle);
    HRESULT CreateGradientMesh(char* patches, uint patchesCount, ID2D1GradientMesh* gradientMesh);
    HRESULT CreateImageSourceFromWic(IWICBitmapSource wicBitmapSource, D2D1_IMAGE_SOURCE_LOADING_OPTIONS loadingOptions, D2D1_ALPHA_MODE alphaMode, ID2D1ImageSourceFromWic* imageSource);
    HRESULT CreateLookupTable3D(D2D1_BUFFER_PRECISION precision, char* extents, char* data, uint dataCount, char* strides, ID2D1LookupTable3D* lookupTable);
    HRESULT CreateImageSourceFromDxgi(char* surfaces, uint surfaceCount, DXGI_COLOR_SPACE_TYPE colorSpace, D2D1_IMAGE_SOURCE_FROM_DXGI_OPTIONS options, ID2D1ImageSource* imageSource);
    HRESULT GetGradientMeshWorldBounds(ID2D1GradientMesh gradientMesh, D2D_RECT_F* pBounds);
    void DrawInk(ID2D1Ink ink, ID2D1Brush brush, ID2D1InkStyle inkStyle);
    void DrawGradientMesh(ID2D1GradientMesh gradientMesh);
    void DrawGdiMetafile(ID2D1GdiMetafile gdiMetafile, const(D2D_RECT_F)* destinationRectangle, const(D2D_RECT_F)* sourceRectangle);
    HRESULT CreateTransformedImageSource(ID2D1ImageSource imageSource, const(D2D1_TRANSFORMED_IMAGE_SOURCE_PROPERTIES)* properties, ID2D1TransformedImageSource* transformedImageSource);
}

const GUID IID_ID2D1Device2 = {0xA44472E1, 0x8DFB, 0x4E60, [0x84, 0x92, 0x6E, 0x28, 0x61, 0xC9, 0xCA, 0x8B]};
@GUID(0xA44472E1, 0x8DFB, 0x4E60, [0x84, 0x92, 0x6E, 0x28, 0x61, 0xC9, 0xCA, 0x8B]);
interface ID2D1Device2 : ID2D1Device1
{
    HRESULT CreateDeviceContext(D2D1_DEVICE_CONTEXT_OPTIONS options, ID2D1DeviceContext2* deviceContext2);
    void FlushDeviceContexts(ID2D1Bitmap bitmap);
    HRESULT GetDxgiDevice(IDXGIDevice* dxgiDevice);
}

const GUID IID_ID2D1Factory3 = {0x0869759F, 0x4F00, 0x413F, [0xB0, 0x3E, 0x2B, 0xDA, 0x45, 0x40, 0x4D, 0x0F]};
@GUID(0x0869759F, 0x4F00, 0x413F, [0xB0, 0x3E, 0x2B, 0xDA, 0x45, 0x40, 0x4D, 0x0F]);
interface ID2D1Factory3 : ID2D1Factory2
{
    HRESULT CreateDevice(IDXGIDevice dxgiDevice, ID2D1Device2* d2dDevice2);
}

const GUID IID_ID2D1CommandSink2 = {0x3BAB440E, 0x417E, 0x47DF, [0xA2, 0xE2, 0xBC, 0x0B, 0xE6, 0xA0, 0x09, 0x16]};
@GUID(0x3BAB440E, 0x417E, 0x47DF, [0xA2, 0xE2, 0xBC, 0x0B, 0xE6, 0xA0, 0x09, 0x16]);
interface ID2D1CommandSink2 : ID2D1CommandSink1
{
    HRESULT DrawInk(ID2D1Ink ink, ID2D1Brush brush, ID2D1InkStyle inkStyle);
    HRESULT DrawGradientMesh(ID2D1GradientMesh gradientMesh);
    HRESULT DrawGdiMetafile(ID2D1GdiMetafile gdiMetafile, const(D2D_RECT_F)* destinationRectangle, const(D2D_RECT_F)* sourceRectangle);
}

const GUID IID_ID2D1GdiMetafile1 = {0x2E69F9E8, 0xDD3F, 0x4BF9, [0x95, 0xBA, 0xC0, 0x4F, 0x49, 0xD7, 0x88, 0xDF]};
@GUID(0x2E69F9E8, 0xDD3F, 0x4BF9, [0x95, 0xBA, 0xC0, 0x4F, 0x49, 0xD7, 0x88, 0xDF]);
interface ID2D1GdiMetafile1 : ID2D1GdiMetafile
{
    HRESULT GetDpi(float* dpiX, float* dpiY);
    HRESULT GetSourceBounds(D2D_RECT_F* bounds);
}

const GUID IID_ID2D1GdiMetafileSink1 = {0xFD0ECB6B, 0x91E6, 0x411E, [0x86, 0x55, 0x39, 0x5E, 0x76, 0x0F, 0x91, 0xB4]};
@GUID(0xFD0ECB6B, 0x91E6, 0x411E, [0x86, 0x55, 0x39, 0x5E, 0x76, 0x0F, 0x91, 0xB4]);
interface ID2D1GdiMetafileSink1 : ID2D1GdiMetafileSink
{
    HRESULT ProcessRecord(uint recordType, const(void)* recordData, uint recordDataSize, uint flags);
}

const GUID IID_ID2D1SpriteBatch = {0x4DC583BF, 0x3A10, 0x438A, [0x87, 0x22, 0xE9, 0x76, 0x52, 0x24, 0xF1, 0xF1]};
@GUID(0x4DC583BF, 0x3A10, 0x438A, [0x87, 0x22, 0xE9, 0x76, 0x52, 0x24, 0xF1, 0xF1]);
interface ID2D1SpriteBatch : ID2D1Resource
{
    HRESULT AddSprites(uint spriteCount, char* destinationRectangles, char* sourceRectangles, char* colors, char* transforms, uint destinationRectanglesStride, uint sourceRectanglesStride, uint colorsStride, uint transformsStride);
    HRESULT SetSprites(uint startIndex, uint spriteCount, char* destinationRectangles, char* sourceRectangles, char* colors, char* transforms, uint destinationRectanglesStride, uint sourceRectanglesStride, uint colorsStride, uint transformsStride);
    HRESULT GetSprites(uint startIndex, uint spriteCount, char* destinationRectangles, char* sourceRectangles, char* colors, char* transforms);
    uint GetSpriteCount();
    void Clear();
}

const GUID IID_ID2D1DeviceContext3 = {0x235A7496, 0x8351, 0x414C, [0xBC, 0xD4, 0x66, 0x72, 0xAB, 0x2D, 0x8E, 0x00]};
@GUID(0x235A7496, 0x8351, 0x414C, [0xBC, 0xD4, 0x66, 0x72, 0xAB, 0x2D, 0x8E, 0x00]);
interface ID2D1DeviceContext3 : ID2D1DeviceContext2
{
    HRESULT CreateSpriteBatch(ID2D1SpriteBatch* spriteBatch);
    void DrawSpriteBatch(ID2D1SpriteBatch spriteBatch, uint startIndex, uint spriteCount, ID2D1Bitmap bitmap, D2D1_BITMAP_INTERPOLATION_MODE interpolationMode, D2D1_SPRITE_OPTIONS spriteOptions);
}

const GUID IID_ID2D1Device3 = {0x852F2087, 0x802C, 0x4037, [0xAB, 0x60, 0xFF, 0x2E, 0x7E, 0xE6, 0xFC, 0x01]};
@GUID(0x852F2087, 0x802C, 0x4037, [0xAB, 0x60, 0xFF, 0x2E, 0x7E, 0xE6, 0xFC, 0x01]);
interface ID2D1Device3 : ID2D1Device2
{
    HRESULT CreateDeviceContext(D2D1_DEVICE_CONTEXT_OPTIONS options, ID2D1DeviceContext3* deviceContext3);
}

const GUID IID_ID2D1Factory4 = {0xBD4EC2D2, 0x0662, 0x4BEE, [0xBA, 0x8E, 0x6F, 0x29, 0xF0, 0x32, 0xE0, 0x96]};
@GUID(0xBD4EC2D2, 0x0662, 0x4BEE, [0xBA, 0x8E, 0x6F, 0x29, 0xF0, 0x32, 0xE0, 0x96]);
interface ID2D1Factory4 : ID2D1Factory3
{
    HRESULT CreateDevice(IDXGIDevice dxgiDevice, ID2D1Device3* d2dDevice3);
}

const GUID IID_ID2D1CommandSink3 = {0x18079135, 0x4CF3, 0x4868, [0xBC, 0x8E, 0x06, 0x06, 0x7E, 0x6D, 0x24, 0x2D]};
@GUID(0x18079135, 0x4CF3, 0x4868, [0xBC, 0x8E, 0x06, 0x06, 0x7E, 0x6D, 0x24, 0x2D]);
interface ID2D1CommandSink3 : ID2D1CommandSink2
{
    HRESULT DrawSpriteBatch(ID2D1SpriteBatch spriteBatch, uint startIndex, uint spriteCount, ID2D1Bitmap bitmap, D2D1_BITMAP_INTERPOLATION_MODE interpolationMode, D2D1_SPRITE_OPTIONS spriteOptions);
}

const GUID IID_ID2D1SvgGlyphStyle = {0xAF671749, 0xD241, 0x4DB8, [0x8E, 0x41, 0xDC, 0xC2, 0xE5, 0xC1, 0xA4, 0x38]};
@GUID(0xAF671749, 0xD241, 0x4DB8, [0x8E, 0x41, 0xDC, 0xC2, 0xE5, 0xC1, 0xA4, 0x38]);
interface ID2D1SvgGlyphStyle : ID2D1Resource
{
    HRESULT SetFill(ID2D1Brush brush);
    void GetFill(ID2D1Brush* brush);
    HRESULT SetStroke(ID2D1Brush brush, float strokeWidth, char* dashes, uint dashesCount, float dashOffset);
    uint GetStrokeDashesCount();
    void GetStroke(ID2D1Brush* brush, float* strokeWidth, char* dashes, uint dashesCount, float* dashOffset);
}

const GUID IID_ID2D1DeviceContext4 = {0x8C427831, 0x3D90, 0x4476, [0xB6, 0x47, 0xC4, 0xFA, 0xE3, 0x49, 0xE4, 0xDB]};
@GUID(0x8C427831, 0x3D90, 0x4476, [0xB6, 0x47, 0xC4, 0xFA, 0xE3, 0x49, 0xE4, 0xDB]);
interface ID2D1DeviceContext4 : ID2D1DeviceContext3
{
    HRESULT CreateSvgGlyphStyle(ID2D1SvgGlyphStyle* svgGlyphStyle);
    void DrawTextA(const(wchar)* string, uint stringLength, IDWriteTextFormat textFormat, const(D2D_RECT_F)* layoutRect, ID2D1Brush defaultFillBrush, ID2D1SvgGlyphStyle svgGlyphStyle, uint colorPaletteIndex, D2D1_DRAW_TEXT_OPTIONS options, DWRITE_MEASURING_MODE measuringMode);
    void DrawTextLayout(D2D_POINT_2F origin, IDWriteTextLayout textLayout, ID2D1Brush defaultFillBrush, ID2D1SvgGlyphStyle svgGlyphStyle, uint colorPaletteIndex, D2D1_DRAW_TEXT_OPTIONS options);
    void DrawColorBitmapGlyphRun(DWRITE_GLYPH_IMAGE_FORMATS glyphImageFormat, D2D_POINT_2F baselineOrigin, const(DWRITE_GLYPH_RUN)* glyphRun, DWRITE_MEASURING_MODE measuringMode, D2D1_COLOR_BITMAP_GLYPH_SNAP_OPTION bitmapSnapOption);
    void DrawSvgGlyphRun(D2D_POINT_2F baselineOrigin, const(DWRITE_GLYPH_RUN)* glyphRun, ID2D1Brush defaultFillBrush, ID2D1SvgGlyphStyle svgGlyphStyle, uint colorPaletteIndex, DWRITE_MEASURING_MODE measuringMode);
    HRESULT GetColorBitmapGlyphImage(DWRITE_GLYPH_IMAGE_FORMATS glyphImageFormat, D2D_POINT_2F glyphOrigin, IDWriteFontFace fontFace, float fontEmSize, ushort glyphIndex, BOOL isSideways, const(D2D_MATRIX_3X2_F)* worldTransform, float dpiX, float dpiY, D2D_MATRIX_3X2_F* glyphTransform, ID2D1Image* glyphImage);
    HRESULT GetSvgGlyphImage(D2D_POINT_2F glyphOrigin, IDWriteFontFace fontFace, float fontEmSize, ushort glyphIndex, BOOL isSideways, const(D2D_MATRIX_3X2_F)* worldTransform, ID2D1Brush defaultFillBrush, ID2D1SvgGlyphStyle svgGlyphStyle, uint colorPaletteIndex, D2D_MATRIX_3X2_F* glyphTransform, ID2D1CommandList* glyphImage);
}

const GUID IID_ID2D1Device4 = {0xD7BDB159, 0x5683, 0x4A46, [0xBC, 0x9C, 0x72, 0xDC, 0x72, 0x0B, 0x85, 0x8B]};
@GUID(0xD7BDB159, 0x5683, 0x4A46, [0xBC, 0x9C, 0x72, 0xDC, 0x72, 0x0B, 0x85, 0x8B]);
interface ID2D1Device4 : ID2D1Device3
{
    HRESULT CreateDeviceContext(D2D1_DEVICE_CONTEXT_OPTIONS options, ID2D1DeviceContext4* deviceContext4);
    void SetMaximumColorGlyphCacheMemory(ulong maximumInBytes);
    ulong GetMaximumColorGlyphCacheMemory();
}

const GUID IID_ID2D1Factory5 = {0xC4349994, 0x838E, 0x4B0F, [0x8C, 0xAB, 0x44, 0x99, 0x7D, 0x9E, 0xEA, 0xCC]};
@GUID(0xC4349994, 0x838E, 0x4B0F, [0x8C, 0xAB, 0x44, 0x99, 0x7D, 0x9E, 0xEA, 0xCC]);
interface ID2D1Factory5 : ID2D1Factory4
{
    HRESULT CreateDevice(IDXGIDevice dxgiDevice, ID2D1Device4* d2dDevice4);
}

const GUID IID_ID2D1CommandSink4 = {0xC78A6519, 0x40D6, 0x4218, [0xB2, 0xDE, 0xBE, 0xEE, 0xB7, 0x44, 0xBB, 0x3E]};
@GUID(0xC78A6519, 0x40D6, 0x4218, [0xB2, 0xDE, 0xBE, 0xEE, 0xB7, 0x44, 0xBB, 0x3E]);
interface ID2D1CommandSink4 : ID2D1CommandSink3
{
    HRESULT SetPrimitiveBlend2(D2D1_PRIMITIVE_BLEND primitiveBlend);
}

const GUID IID_ID2D1ColorContext1 = {0x1AB42875, 0xC57F, 0x4BE9, [0xBD, 0x85, 0x9C, 0xD7, 0x8D, 0x6F, 0x55, 0xEE]};
@GUID(0x1AB42875, 0xC57F, 0x4BE9, [0xBD, 0x85, 0x9C, 0xD7, 0x8D, 0x6F, 0x55, 0xEE]);
interface ID2D1ColorContext1 : ID2D1ColorContext
{
    D2D1_COLOR_CONTEXT_TYPE GetColorContextType();
    DXGI_COLOR_SPACE_TYPE GetDXGIColorSpace();
    HRESULT GetSimpleColorProfile(D2D1_SIMPLE_COLOR_PROFILE* simpleProfile);
}

const GUID IID_ID2D1DeviceContext5 = {0x7836D248, 0x68CC, 0x4DF6, [0xB9, 0xE8, 0xDE, 0x99, 0x1B, 0xF6, 0x2E, 0xB7]};
@GUID(0x7836D248, 0x68CC, 0x4DF6, [0xB9, 0xE8, 0xDE, 0x99, 0x1B, 0xF6, 0x2E, 0xB7]);
interface ID2D1DeviceContext5 : ID2D1DeviceContext4
{
    HRESULT CreateSvgDocument(IStream inputXmlStream, D2D_SIZE_F viewportSize, ID2D1SvgDocument* svgDocument);
    void DrawSvgDocument(ID2D1SvgDocument svgDocument);
    HRESULT CreateColorContextFromDxgiColorSpace(DXGI_COLOR_SPACE_TYPE colorSpace, ID2D1ColorContext1* colorContext);
    HRESULT CreateColorContextFromSimpleColorProfile(const(D2D1_SIMPLE_COLOR_PROFILE)* simpleProfile, ID2D1ColorContext1* colorContext);
}

const GUID IID_ID2D1Device5 = {0xD55BA0A4, 0x6405, 0x4694, [0xAE, 0xF5, 0x08, 0xEE, 0x1A, 0x43, 0x58, 0xB4]};
@GUID(0xD55BA0A4, 0x6405, 0x4694, [0xAE, 0xF5, 0x08, 0xEE, 0x1A, 0x43, 0x58, 0xB4]);
interface ID2D1Device5 : ID2D1Device4
{
    HRESULT CreateDeviceContext(D2D1_DEVICE_CONTEXT_OPTIONS options, ID2D1DeviceContext5* deviceContext5);
}

const GUID IID_ID2D1Factory6 = {0xF9976F46, 0xF642, 0x44C1, [0x97, 0xCA, 0xDA, 0x32, 0xEA, 0x2A, 0x26, 0x35]};
@GUID(0xF9976F46, 0xF642, 0x44C1, [0x97, 0xCA, 0xDA, 0x32, 0xEA, 0x2A, 0x26, 0x35]);
interface ID2D1Factory6 : ID2D1Factory5
{
    HRESULT CreateDevice(IDXGIDevice dxgiDevice, ID2D1Device5* d2dDevice5);
}

const GUID IID_ID2D1CommandSink5 = {0x7047DD26, 0xB1E7, 0x44A7, [0x95, 0x9A, 0x83, 0x49, 0xE2, 0x14, 0x4F, 0xA8]};
@GUID(0x7047DD26, 0xB1E7, 0x44A7, [0x95, 0x9A, 0x83, 0x49, 0xE2, 0x14, 0x4F, 0xA8]);
interface ID2D1CommandSink5 : ID2D1CommandSink4
{
    HRESULT BlendImage(ID2D1Image image, D2D1_BLEND_MODE blendMode, const(D2D_POINT_2F)* targetOffset, const(D2D_RECT_F)* imageRectangle, D2D1_INTERPOLATION_MODE interpolationMode);
}

const GUID IID_ID2D1DeviceContext6 = {0x985F7E37, 0x4ED0, 0x4A19, [0x98, 0xA3, 0x15, 0xB0, 0xED, 0xFD, 0xE3, 0x06]};
@GUID(0x985F7E37, 0x4ED0, 0x4A19, [0x98, 0xA3, 0x15, 0xB0, 0xED, 0xFD, 0xE3, 0x06]);
interface ID2D1DeviceContext6 : ID2D1DeviceContext5
{
    void BlendImage(ID2D1Image image, D2D1_BLEND_MODE blendMode, const(D2D_POINT_2F)* targetOffset, const(D2D_RECT_F)* imageRectangle, D2D1_INTERPOLATION_MODE interpolationMode);
}

const GUID IID_ID2D1Device6 = {0x7BFEF914, 0x2D75, 0x4BAD, [0xBE, 0x87, 0xE1, 0x8D, 0xDB, 0x07, 0x7B, 0x6D]};
@GUID(0x7BFEF914, 0x2D75, 0x4BAD, [0xBE, 0x87, 0xE1, 0x8D, 0xDB, 0x07, 0x7B, 0x6D]);
interface ID2D1Device6 : ID2D1Device5
{
    HRESULT CreateDeviceContext(D2D1_DEVICE_CONTEXT_OPTIONS options, ID2D1DeviceContext6* deviceContext6);
}

const GUID IID_ID2D1Factory7 = {0xBDC2BDD3, 0xB96C, 0x4DE6, [0xBD, 0xF7, 0x99, 0xD4, 0x74, 0x54, 0x54, 0xDE]};
@GUID(0xBDC2BDD3, 0xB96C, 0x4DE6, [0xBD, 0xF7, 0x99, 0xD4, 0x74, 0x54, 0x54, 0xDE]);
interface ID2D1Factory7 : ID2D1Factory6
{
    HRESULT CreateDevice(IDXGIDevice dxgiDevice, ID2D1Device6* d2dDevice6);
}

const GUID IID_ID2D1EffectContext1 = {0x84AB595A, 0xFC81, 0x4546, [0xBA, 0xCD, 0xE8, 0xEF, 0x4D, 0x8A, 0xBE, 0x7A]};
@GUID(0x84AB595A, 0xFC81, 0x4546, [0xBA, 0xCD, 0xE8, 0xEF, 0x4D, 0x8A, 0xBE, 0x7A]);
interface ID2D1EffectContext1 : ID2D1EffectContext
{
    HRESULT CreateLookupTable3D(D2D1_BUFFER_PRECISION precision, char* extents, char* data, uint dataCount, char* strides, ID2D1LookupTable3D* lookupTable);
}

const GUID IID_ID2D1EffectContext2 = {0x577AD2A0, 0x9FC7, 0x4DDA, [0x8B, 0x18, 0xDA, 0xB8, 0x10, 0x14, 0x00, 0x52]};
@GUID(0x577AD2A0, 0x9FC7, 0x4DDA, [0x8B, 0x18, 0xDA, 0xB8, 0x10, 0x14, 0x00, 0x52]);
interface ID2D1EffectContext2 : ID2D1EffectContext1
{
    HRESULT CreateColorContextFromDxgiColorSpace(DXGI_COLOR_SPACE_TYPE colorSpace, ID2D1ColorContext1* colorContext);
    HRESULT CreateColorContextFromSimpleColorProfile(const(D2D1_SIMPLE_COLOR_PROFILE)* simpleProfile, ID2D1ColorContext1* colorContext);
}

@DllImport("d2d1.dll")
HRESULT D2D1CreateFactory(D2D1_FACTORY_TYPE factoryType, const(Guid)* riid, const(D2D1_FACTORY_OPTIONS)* pFactoryOptions, void** ppIFactory);

@DllImport("d2d1.dll")
void D2D1MakeRotateMatrix(float angle, D2D_POINT_2F center, D2D_MATRIX_3X2_F* matrix);

@DllImport("d2d1.dll")
void D2D1MakeSkewMatrix(float angleX, float angleY, D2D_POINT_2F center, D2D_MATRIX_3X2_F* matrix);

@DllImport("d2d1.dll")
BOOL D2D1IsMatrixInvertible(const(D2D_MATRIX_3X2_F)* matrix);

@DllImport("d2d1.dll")
BOOL D2D1InvertMatrix(D2D_MATRIX_3X2_F* matrix);

@DllImport("d2d1.dll")
HRESULT D2D1CreateDevice(IDXGIDevice dxgiDevice, const(D2D1_CREATION_PROPERTIES)* creationProperties, ID2D1Device* d2dDevice);

@DllImport("d2d1.dll")
HRESULT D2D1CreateDeviceContext(IDXGISurface dxgiSurface, const(D2D1_CREATION_PROPERTIES)* creationProperties, ID2D1DeviceContext* d2dDeviceContext);

@DllImport("d2d1.dll")
DXGI_RGBA D2D1ConvertColorSpace(D2D1_COLOR_SPACE sourceColorSpace, D2D1_COLOR_SPACE destinationColorSpace, const(DXGI_RGBA)* color);

@DllImport("d2d1.dll")
void D2D1SinCos(float angle, float* s, float* c);

@DllImport("d2d1.dll")
float D2D1Tan(float angle);

@DllImport("d2d1.dll")
float D2D1Vec3Length(float x, float y, float z);

@DllImport("d2d1.dll")
float D2D1ComputeMaximumScaleFactor(const(D2D_MATRIX_3X2_F)* matrix);

@DllImport("d2d1.dll")
void D2D1GetGradientMeshInteriorPointsFromCoonsPatch(const(D2D_POINT_2F)* pPoint0, const(D2D_POINT_2F)* pPoint1, const(D2D_POINT_2F)* pPoint2, const(D2D_POINT_2F)* pPoint3, const(D2D_POINT_2F)* pPoint4, const(D2D_POINT_2F)* pPoint5, const(D2D_POINT_2F)* pPoint6, const(D2D_POINT_2F)* pPoint7, const(D2D_POINT_2F)* pPoint8, const(D2D_POINT_2F)* pPoint9, const(D2D_POINT_2F)* pPoint10, const(D2D_POINT_2F)* pPoint11, D2D_POINT_2F* pTensorPoint11, D2D_POINT_2F* pTensorPoint12, D2D_POINT_2F* pTensorPoint21, D2D_POINT_2F* pTensorPoint22);

@DllImport("d3d9.dll")
IDirect3D9 Direct3DCreate9(uint SDKVersion);

@DllImport("d3d9.dll")
HRESULT Direct3DCreate9Ex(uint SDKVersion, IDirect3D9Ex* param1);

struct D3DVSHADERCAPS2_0
{
    uint Caps;
    int DynamicFlowControlDepth;
    int NumTemps;
    int StaticFlowControlDepth;
}

struct D3DPSHADERCAPS2_0
{
    uint Caps;
    int DynamicFlowControlDepth;
    int NumTemps;
    int StaticFlowControlDepth;
    int NumInstructionSlots;
}

struct D3DCAPS9
{
    D3DDEVTYPE DeviceType;
    uint AdapterOrdinal;
    uint Caps;
    uint Caps2;
    uint Caps3;
    uint PresentationIntervals;
    uint CursorCaps;
    uint DevCaps;
    uint PrimitiveMiscCaps;
    uint RasterCaps;
    uint ZCmpCaps;
    uint SrcBlendCaps;
    uint DestBlendCaps;
    uint AlphaCmpCaps;
    uint ShadeCaps;
    uint TextureCaps;
    uint TextureFilterCaps;
    uint CubeTextureFilterCaps;
    uint VolumeTextureFilterCaps;
    uint TextureAddressCaps;
    uint VolumeTextureAddressCaps;
    uint LineCaps;
    uint MaxTextureWidth;
    uint MaxTextureHeight;
    uint MaxVolumeExtent;
    uint MaxTextureRepeat;
    uint MaxTextureAspectRatio;
    uint MaxAnisotropy;
    float MaxVertexW;
    float GuardBandLeft;
    float GuardBandTop;
    float GuardBandRight;
    float GuardBandBottom;
    float ExtentsAdjust;
    uint StencilCaps;
    uint FVFCaps;
    uint TextureOpCaps;
    uint MaxTextureBlendStages;
    uint MaxSimultaneousTextures;
    uint VertexProcessingCaps;
    uint MaxActiveLights;
    uint MaxUserClipPlanes;
    uint MaxVertexBlendMatrices;
    uint MaxVertexBlendMatrixIndex;
    float MaxPointSize;
    uint MaxPrimitiveCount;
    uint MaxVertexIndex;
    uint MaxStreams;
    uint MaxStreamStride;
    uint VertexShaderVersion;
    uint MaxVertexShaderConst;
    uint PixelShaderVersion;
    float PixelShader1xMaxValue;
    uint DevCaps2;
    float MaxNpatchTessellationLevel;
    uint Reserved5;
    uint MasterAdapterOrdinal;
    uint AdapterOrdinalInGroup;
    uint NumberOfAdaptersInGroup;
    uint DeclTypes;
    uint NumSimultaneousRTs;
    uint StretchRectFilterCaps;
    D3DVSHADERCAPS2_0 VS20Caps;
    D3DPSHADERCAPS2_0 PS20Caps;
    uint VertexTextureFilterCaps;
    uint MaxVShaderInstructionsExecuted;
    uint MaxPShaderInstructionsExecuted;
    uint MaxVertexShader30InstructionSlots;
    uint MaxPixelShader30InstructionSlots;
}

const GUID IID_IDirect3D9 = {0x81BDCBCA, 0x64D4, 0x426D, [0xAE, 0x8D, 0xAD, 0x01, 0x47, 0xF4, 0x27, 0x5C]};
@GUID(0x81BDCBCA, 0x64D4, 0x426D, [0xAE, 0x8D, 0xAD, 0x01, 0x47, 0xF4, 0x27, 0x5C]);
interface IDirect3D9 : IUnknown
{
    HRESULT RegisterSoftwareDevice(void* pInitializeFunction);
    uint GetAdapterCount();
    HRESULT GetAdapterIdentifier(uint Adapter, uint Flags, D3DADAPTER_IDENTIFIER9* pIdentifier);
    uint GetAdapterModeCount(uint Adapter, D3DFORMAT Format);
    HRESULT EnumAdapterModes(uint Adapter, D3DFORMAT Format, uint Mode, D3DDISPLAYMODE* pMode);
    HRESULT GetAdapterDisplayMode(uint Adapter, D3DDISPLAYMODE* pMode);
    HRESULT CheckDeviceType(uint Adapter, D3DDEVTYPE DevType, D3DFORMAT AdapterFormat, D3DFORMAT BackBufferFormat, BOOL bWindowed);
    HRESULT CheckDeviceFormat(uint Adapter, D3DDEVTYPE DeviceType, D3DFORMAT AdapterFormat, uint Usage, D3DRESOURCETYPE RType, D3DFORMAT CheckFormat);
    HRESULT CheckDeviceMultiSampleType(uint Adapter, D3DDEVTYPE DeviceType, D3DFORMAT SurfaceFormat, BOOL Windowed, D3DMULTISAMPLE_TYPE MultiSampleType, uint* pQualityLevels);
    HRESULT CheckDepthStencilMatch(uint Adapter, D3DDEVTYPE DeviceType, D3DFORMAT AdapterFormat, D3DFORMAT RenderTargetFormat, D3DFORMAT DepthStencilFormat);
    HRESULT CheckDeviceFormatConversion(uint Adapter, D3DDEVTYPE DeviceType, D3DFORMAT SourceFormat, D3DFORMAT TargetFormat);
    HRESULT GetDeviceCaps(uint Adapter, D3DDEVTYPE DeviceType, D3DCAPS9* pCaps);
    int GetAdapterMonitor(uint Adapter);
    HRESULT CreateDevice(uint Adapter, D3DDEVTYPE DeviceType, HWND hFocusWindow, uint BehaviorFlags, _D3DPRESENT_PARAMETERS_* pPresentationParameters, IDirect3DDevice9* ppReturnedDeviceInterface);
}

const GUID IID_IDirect3DDevice9 = {0xD0223B96, 0xBF7A, 0x43FD, [0x92, 0xBD, 0xA4, 0x3B, 0x0D, 0x82, 0xB9, 0xEB]};
@GUID(0xD0223B96, 0xBF7A, 0x43FD, [0x92, 0xBD, 0xA4, 0x3B, 0x0D, 0x82, 0xB9, 0xEB]);
interface IDirect3DDevice9 : IUnknown
{
    HRESULT TestCooperativeLevel();
    uint GetAvailableTextureMem();
    HRESULT EvictManagedResources();
    HRESULT GetDirect3D(IDirect3D9* ppD3D9);
    HRESULT GetDeviceCaps(D3DCAPS9* pCaps);
    HRESULT GetDisplayMode(uint iSwapChain, D3DDISPLAYMODE* pMode);
    HRESULT GetCreationParameters(D3DDEVICE_CREATION_PARAMETERS* pParameters);
    HRESULT SetCursorProperties(uint XHotSpot, uint YHotSpot, IDirect3DSurface9 pCursorBitmap);
    void SetCursorPosition(int X, int Y, uint Flags);
    BOOL ShowCursor(BOOL bShow);
    HRESULT CreateAdditionalSwapChain(_D3DPRESENT_PARAMETERS_* pPresentationParameters, IDirect3DSwapChain9* pSwapChain);
    HRESULT GetSwapChain(uint iSwapChain, IDirect3DSwapChain9* pSwapChain);
    uint GetNumberOfSwapChains();
    HRESULT Reset(_D3DPRESENT_PARAMETERS_* pPresentationParameters);
    HRESULT Present(const(RECT)* pSourceRect, const(RECT)* pDestRect, HWND hDestWindowOverride, const(RGNDATA)* pDirtyRegion);
    HRESULT GetBackBuffer(uint iSwapChain, uint iBackBuffer, D3DBACKBUFFER_TYPE Type, IDirect3DSurface9* ppBackBuffer);
    HRESULT GetRasterStatus(uint iSwapChain, D3DRASTER_STATUS* pRasterStatus);
    HRESULT SetDialogBoxMode(BOOL bEnableDialogs);
    void SetGammaRamp(uint iSwapChain, uint Flags, const(D3DGAMMARAMP)* pRamp);
    void GetGammaRamp(uint iSwapChain, D3DGAMMARAMP* pRamp);
    HRESULT CreateTexture(uint Width, uint Height, uint Levels, uint Usage, D3DFORMAT Format, D3DPOOL Pool, IDirect3DTexture9* ppTexture, HANDLE* pSharedHandle);
    HRESULT CreateVolumeTexture(uint Width, uint Height, uint Depth, uint Levels, uint Usage, D3DFORMAT Format, D3DPOOL Pool, IDirect3DVolumeTexture9* ppVolumeTexture, HANDLE* pSharedHandle);
    HRESULT CreateCubeTexture(uint EdgeLength, uint Levels, uint Usage, D3DFORMAT Format, D3DPOOL Pool, IDirect3DCubeTexture9* ppCubeTexture, HANDLE* pSharedHandle);
    HRESULT CreateVertexBuffer(uint Length, uint Usage, uint FVF, D3DPOOL Pool, IDirect3DVertexBuffer9* ppVertexBuffer, HANDLE* pSharedHandle);
    HRESULT CreateIndexBuffer(uint Length, uint Usage, D3DFORMAT Format, D3DPOOL Pool, IDirect3DIndexBuffer9* ppIndexBuffer, HANDLE* pSharedHandle);
    HRESULT CreateRenderTarget(uint Width, uint Height, D3DFORMAT Format, D3DMULTISAMPLE_TYPE MultiSample, uint MultisampleQuality, BOOL Lockable, IDirect3DSurface9* ppSurface, HANDLE* pSharedHandle);
    HRESULT CreateDepthStencilSurface(uint Width, uint Height, D3DFORMAT Format, D3DMULTISAMPLE_TYPE MultiSample, uint MultisampleQuality, BOOL Discard, IDirect3DSurface9* ppSurface, HANDLE* pSharedHandle);
    HRESULT UpdateSurface(IDirect3DSurface9 pSourceSurface, const(RECT)* pSourceRect, IDirect3DSurface9 pDestinationSurface, const(POINT)* pDestPoint);
    HRESULT UpdateTexture(IDirect3DBaseTexture9 pSourceTexture, IDirect3DBaseTexture9 pDestinationTexture);
    HRESULT GetRenderTargetData(IDirect3DSurface9 pRenderTarget, IDirect3DSurface9 pDestSurface);
    HRESULT GetFrontBufferData(uint iSwapChain, IDirect3DSurface9 pDestSurface);
    HRESULT StretchRect(IDirect3DSurface9 pSourceSurface, const(RECT)* pSourceRect, IDirect3DSurface9 pDestSurface, const(RECT)* pDestRect, D3DTEXTUREFILTERTYPE Filter);
    HRESULT ColorFill(IDirect3DSurface9 pSurface, const(RECT)* pRect, uint color);
    HRESULT CreateOffscreenPlainSurface(uint Width, uint Height, D3DFORMAT Format, D3DPOOL Pool, IDirect3DSurface9* ppSurface, HANDLE* pSharedHandle);
    HRESULT SetRenderTarget(uint RenderTargetIndex, IDirect3DSurface9 pRenderTarget);
    HRESULT GetRenderTarget(uint RenderTargetIndex, IDirect3DSurface9* ppRenderTarget);
    HRESULT SetDepthStencilSurface(IDirect3DSurface9 pNewZStencil);
    HRESULT GetDepthStencilSurface(IDirect3DSurface9* ppZStencilSurface);
    HRESULT BeginScene();
    HRESULT EndScene();
    HRESULT Clear(uint Count, const(D3DRECT)* pRects, uint Flags, uint Color, float Z, uint Stencil);
    HRESULT SetTransform(D3DTRANSFORMSTATETYPE State, const(D3DMATRIX)* pMatrix);
    HRESULT GetTransform(D3DTRANSFORMSTATETYPE State, D3DMATRIX* pMatrix);
    HRESULT MultiplyTransform(D3DTRANSFORMSTATETYPE param0, const(D3DMATRIX)* param1);
    HRESULT SetViewport(const(D3DVIEWPORT9)* pViewport);
    HRESULT GetViewport(D3DVIEWPORT9* pViewport);
    HRESULT SetMaterial(const(D3DMATERIAL9)* pMaterial);
    HRESULT GetMaterial(D3DMATERIAL9* pMaterial);
    HRESULT SetLight(uint Index, const(D3DLIGHT9)* param1);
    HRESULT GetLight(uint Index, D3DLIGHT9* param1);
    HRESULT LightEnable(uint Index, BOOL Enable);
    HRESULT GetLightEnable(uint Index, int* pEnable);
    HRESULT SetClipPlane(uint Index, const(float)* pPlane);
    HRESULT GetClipPlane(uint Index, float* pPlane);
    HRESULT SetRenderState(D3DRENDERSTATETYPE State, uint Value);
    HRESULT GetRenderState(D3DRENDERSTATETYPE State, uint* pValue);
    HRESULT CreateStateBlock(D3DSTATEBLOCKTYPE Type, IDirect3DStateBlock9* ppSB);
    HRESULT BeginStateBlock();
    HRESULT EndStateBlock(IDirect3DStateBlock9* ppSB);
    HRESULT SetClipStatus(const(D3DCLIPSTATUS9)* pClipStatus);
    HRESULT GetClipStatus(D3DCLIPSTATUS9* pClipStatus);
    HRESULT GetTexture(uint Stage, IDirect3DBaseTexture9* ppTexture);
    HRESULT SetTexture(uint Stage, IDirect3DBaseTexture9 pTexture);
    HRESULT GetTextureStageState(uint Stage, D3DTEXTURESTAGESTATETYPE Type, uint* pValue);
    HRESULT SetTextureStageState(uint Stage, D3DTEXTURESTAGESTATETYPE Type, uint Value);
    HRESULT GetSamplerState(uint Sampler, D3DSAMPLERSTATETYPE Type, uint* pValue);
    HRESULT SetSamplerState(uint Sampler, D3DSAMPLERSTATETYPE Type, uint Value);
    HRESULT ValidateDevice(uint* pNumPasses);
    HRESULT SetPaletteEntries(uint PaletteNumber, const(PALETTEENTRY)* pEntries);
    HRESULT GetPaletteEntries(uint PaletteNumber, PALETTEENTRY* pEntries);
    HRESULT SetCurrentTexturePalette(uint PaletteNumber);
    HRESULT GetCurrentTexturePalette(uint* PaletteNumber);
    HRESULT SetScissorRect(const(RECT)* pRect);
    HRESULT GetScissorRect(RECT* pRect);
    HRESULT SetSoftwareVertexProcessing(BOOL bSoftware);
    BOOL GetSoftwareVertexProcessing();
    HRESULT SetNPatchMode(float nSegments);
    float GetNPatchMode();
    HRESULT DrawPrimitive(D3DPRIMITIVETYPE PrimitiveType, uint StartVertex, uint PrimitiveCount);
    HRESULT DrawIndexedPrimitive(D3DPRIMITIVETYPE param0, int BaseVertexIndex, uint MinVertexIndex, uint NumVertices, uint startIndex, uint primCount);
    HRESULT DrawPrimitiveUP(D3DPRIMITIVETYPE PrimitiveType, uint PrimitiveCount, const(void)* pVertexStreamZeroData, uint VertexStreamZeroStride);
    HRESULT DrawIndexedPrimitiveUP(D3DPRIMITIVETYPE PrimitiveType, uint MinVertexIndex, uint NumVertices, uint PrimitiveCount, const(void)* pIndexData, D3DFORMAT IndexDataFormat, const(void)* pVertexStreamZeroData, uint VertexStreamZeroStride);
    HRESULT ProcessVertices(uint SrcStartIndex, uint DestIndex, uint VertexCount, IDirect3DVertexBuffer9 pDestBuffer, IDirect3DVertexDeclaration9 pVertexDecl, uint Flags);
    HRESULT CreateVertexDeclaration(const(D3DVERTEXELEMENT9)* pVertexElements, IDirect3DVertexDeclaration9* ppDecl);
    HRESULT SetVertexDeclaration(IDirect3DVertexDeclaration9 pDecl);
    HRESULT GetVertexDeclaration(IDirect3DVertexDeclaration9* ppDecl);
    HRESULT SetFVF(uint FVF);
    HRESULT GetFVF(uint* pFVF);
    HRESULT CreateVertexShader(const(uint)* pFunction, IDirect3DVertexShader9* ppShader);
    HRESULT SetVertexShader(IDirect3DVertexShader9 pShader);
    HRESULT GetVertexShader(IDirect3DVertexShader9* ppShader);
    HRESULT SetVertexShaderConstantF(uint StartRegister, const(float)* pConstantData, uint Vector4fCount);
    HRESULT GetVertexShaderConstantF(uint StartRegister, float* pConstantData, uint Vector4fCount);
    HRESULT SetVertexShaderConstantI(uint StartRegister, const(int)* pConstantData, uint Vector4iCount);
    HRESULT GetVertexShaderConstantI(uint StartRegister, int* pConstantData, uint Vector4iCount);
    HRESULT SetVertexShaderConstantB(uint StartRegister, const(int)* pConstantData, uint BoolCount);
    HRESULT GetVertexShaderConstantB(uint StartRegister, int* pConstantData, uint BoolCount);
    HRESULT SetStreamSource(uint StreamNumber, IDirect3DVertexBuffer9 pStreamData, uint OffsetInBytes, uint Stride);
    HRESULT GetStreamSource(uint StreamNumber, IDirect3DVertexBuffer9* ppStreamData, uint* pOffsetInBytes, uint* pStride);
    HRESULT SetStreamSourceFreq(uint StreamNumber, uint Setting);
    HRESULT GetStreamSourceFreq(uint StreamNumber, uint* pSetting);
    HRESULT SetIndices(IDirect3DIndexBuffer9 pIndexData);
    HRESULT GetIndices(IDirect3DIndexBuffer9* ppIndexData);
    HRESULT CreatePixelShader(const(uint)* pFunction, IDirect3DPixelShader9* ppShader);
    HRESULT SetPixelShader(IDirect3DPixelShader9 pShader);
    HRESULT GetPixelShader(IDirect3DPixelShader9* ppShader);
    HRESULT SetPixelShaderConstantF(uint StartRegister, const(float)* pConstantData, uint Vector4fCount);
    HRESULT GetPixelShaderConstantF(uint StartRegister, float* pConstantData, uint Vector4fCount);
    HRESULT SetPixelShaderConstantI(uint StartRegister, const(int)* pConstantData, uint Vector4iCount);
    HRESULT GetPixelShaderConstantI(uint StartRegister, int* pConstantData, uint Vector4iCount);
    HRESULT SetPixelShaderConstantB(uint StartRegister, const(int)* pConstantData, uint BoolCount);
    HRESULT GetPixelShaderConstantB(uint StartRegister, int* pConstantData, uint BoolCount);
    HRESULT DrawRectPatch(uint Handle, const(float)* pNumSegs, const(D3DRECTPATCH_INFO)* pRectPatchInfo);
    HRESULT DrawTriPatch(uint Handle, const(float)* pNumSegs, const(D3DTRIPATCH_INFO)* pTriPatchInfo);
    HRESULT DeletePatch(uint Handle);
    HRESULT CreateQuery(D3DQUERYTYPE Type, IDirect3DQuery9* ppQuery);
}

const GUID IID_IDirect3DStateBlock9 = {0xB07C4FE5, 0x310D, 0x4BA8, [0xA2, 0x3C, 0x4F, 0x0F, 0x20, 0x6F, 0x21, 0x8B]};
@GUID(0xB07C4FE5, 0x310D, 0x4BA8, [0xA2, 0x3C, 0x4F, 0x0F, 0x20, 0x6F, 0x21, 0x8B]);
interface IDirect3DStateBlock9 : IUnknown
{
    HRESULT GetDevice(IDirect3DDevice9* ppDevice);
    HRESULT Capture();
    HRESULT Apply();
}

const GUID IID_IDirect3DSwapChain9 = {0x794950F2, 0xADFC, 0x458A, [0x90, 0x5E, 0x10, 0xA1, 0x0B, 0x0B, 0x50, 0x3B]};
@GUID(0x794950F2, 0xADFC, 0x458A, [0x90, 0x5E, 0x10, 0xA1, 0x0B, 0x0B, 0x50, 0x3B]);
interface IDirect3DSwapChain9 : IUnknown
{
    HRESULT Present(const(RECT)* pSourceRect, const(RECT)* pDestRect, HWND hDestWindowOverride, const(RGNDATA)* pDirtyRegion, uint dwFlags);
    HRESULT GetFrontBufferData(IDirect3DSurface9 pDestSurface);
    HRESULT GetBackBuffer(uint iBackBuffer, D3DBACKBUFFER_TYPE Type, IDirect3DSurface9* ppBackBuffer);
    HRESULT GetRasterStatus(D3DRASTER_STATUS* pRasterStatus);
    HRESULT GetDisplayMode(D3DDISPLAYMODE* pMode);
    HRESULT GetDevice(IDirect3DDevice9* ppDevice);
    HRESULT GetPresentParameters(_D3DPRESENT_PARAMETERS_* pPresentationParameters);
}

const GUID IID_IDirect3DResource9 = {0x05EEC05D, 0x8F7D, 0x4362, [0xB9, 0x99, 0xD1, 0xBA, 0xF3, 0x57, 0xC7, 0x04]};
@GUID(0x05EEC05D, 0x8F7D, 0x4362, [0xB9, 0x99, 0xD1, 0xBA, 0xF3, 0x57, 0xC7, 0x04]);
interface IDirect3DResource9 : IUnknown
{
    HRESULT GetDevice(IDirect3DDevice9* ppDevice);
    HRESULT SetPrivateData(const(Guid)* refguid, const(void)* pData, uint SizeOfData, uint Flags);
    HRESULT GetPrivateData(const(Guid)* refguid, void* pData, uint* pSizeOfData);
    HRESULT FreePrivateData(const(Guid)* refguid);
    uint SetPriority(uint PriorityNew);
    uint GetPriority();
    void PreLoad();
    D3DRESOURCETYPE GetType();
}

const GUID IID_IDirect3DVertexDeclaration9 = {0xDD13C59C, 0x36FA, 0x4098, [0xA8, 0xFB, 0xC7, 0xED, 0x39, 0xDC, 0x85, 0x46]};
@GUID(0xDD13C59C, 0x36FA, 0x4098, [0xA8, 0xFB, 0xC7, 0xED, 0x39, 0xDC, 0x85, 0x46]);
interface IDirect3DVertexDeclaration9 : IUnknown
{
    HRESULT GetDevice(IDirect3DDevice9* ppDevice);
    HRESULT GetDeclaration(D3DVERTEXELEMENT9* pElement, uint* pNumElements);
}

const GUID IID_IDirect3DVertexShader9 = {0xEFC5557E, 0x6265, 0x4613, [0x8A, 0x94, 0x43, 0x85, 0x78, 0x89, 0xEB, 0x36]};
@GUID(0xEFC5557E, 0x6265, 0x4613, [0x8A, 0x94, 0x43, 0x85, 0x78, 0x89, 0xEB, 0x36]);
interface IDirect3DVertexShader9 : IUnknown
{
    HRESULT GetDevice(IDirect3DDevice9* ppDevice);
    HRESULT GetFunction(void* param0, uint* pSizeOfData);
}

const GUID IID_IDirect3DPixelShader9 = {0x6D3BDBDC, 0x5B02, 0x4415, [0xB8, 0x52, 0xCE, 0x5E, 0x8B, 0xCC, 0xB2, 0x89]};
@GUID(0x6D3BDBDC, 0x5B02, 0x4415, [0xB8, 0x52, 0xCE, 0x5E, 0x8B, 0xCC, 0xB2, 0x89]);
interface IDirect3DPixelShader9 : IUnknown
{
    HRESULT GetDevice(IDirect3DDevice9* ppDevice);
    HRESULT GetFunction(void* param0, uint* pSizeOfData);
}

const GUID IID_IDirect3DBaseTexture9 = {0x580CA87E, 0x1D3C, 0x4D54, [0x99, 0x1D, 0xB7, 0xD3, 0xE3, 0xC2, 0x98, 0xCE]};
@GUID(0x580CA87E, 0x1D3C, 0x4D54, [0x99, 0x1D, 0xB7, 0xD3, 0xE3, 0xC2, 0x98, 0xCE]);
interface IDirect3DBaseTexture9 : IDirect3DResource9
{
    uint SetLOD(uint LODNew);
    uint GetLOD();
    uint GetLevelCount();
    HRESULT SetAutoGenFilterType(D3DTEXTUREFILTERTYPE FilterType);
    D3DTEXTUREFILTERTYPE GetAutoGenFilterType();
    void GenerateMipSubLevels();
}

const GUID IID_IDirect3DTexture9 = {0x85C31227, 0x3DE5, 0x4F00, [0x9B, 0x3A, 0xF1, 0x1A, 0xC3, 0x8C, 0x18, 0xB5]};
@GUID(0x85C31227, 0x3DE5, 0x4F00, [0x9B, 0x3A, 0xF1, 0x1A, 0xC3, 0x8C, 0x18, 0xB5]);
interface IDirect3DTexture9 : IDirect3DBaseTexture9
{
    HRESULT GetLevelDesc(uint Level, D3DSURFACE_DESC* pDesc);
    HRESULT GetSurfaceLevel(uint Level, IDirect3DSurface9* ppSurfaceLevel);
    HRESULT LockRect(uint Level, D3DLOCKED_RECT* pLockedRect, const(RECT)* pRect, uint Flags);
    HRESULT UnlockRect(uint Level);
    HRESULT AddDirtyRect(const(RECT)* pDirtyRect);
}

const GUID IID_IDirect3DVolumeTexture9 = {0x2518526C, 0xE789, 0x4111, [0xA7, 0xB9, 0x47, 0xEF, 0x32, 0x8D, 0x13, 0xE6]};
@GUID(0x2518526C, 0xE789, 0x4111, [0xA7, 0xB9, 0x47, 0xEF, 0x32, 0x8D, 0x13, 0xE6]);
interface IDirect3DVolumeTexture9 : IDirect3DBaseTexture9
{
    HRESULT GetLevelDesc(uint Level, D3DVOLUME_DESC* pDesc);
    HRESULT GetVolumeLevel(uint Level, IDirect3DVolume9* ppVolumeLevel);
    HRESULT LockBox(uint Level, D3DLOCKED_BOX* pLockedVolume, const(D3DBOX)* pBox, uint Flags);
    HRESULT UnlockBox(uint Level);
    HRESULT AddDirtyBox(const(D3DBOX)* pDirtyBox);
}

const GUID IID_IDirect3DCubeTexture9 = {0xFFF32F81, 0xD953, 0x473A, [0x92, 0x23, 0x93, 0xD6, 0x52, 0xAB, 0xA9, 0x3F]};
@GUID(0xFFF32F81, 0xD953, 0x473A, [0x92, 0x23, 0x93, 0xD6, 0x52, 0xAB, 0xA9, 0x3F]);
interface IDirect3DCubeTexture9 : IDirect3DBaseTexture9
{
    HRESULT GetLevelDesc(uint Level, D3DSURFACE_DESC* pDesc);
    HRESULT GetCubeMapSurface(D3DCUBEMAP_FACES FaceType, uint Level, IDirect3DSurface9* ppCubeMapSurface);
    HRESULT LockRect(D3DCUBEMAP_FACES FaceType, uint Level, D3DLOCKED_RECT* pLockedRect, const(RECT)* pRect, uint Flags);
    HRESULT UnlockRect(D3DCUBEMAP_FACES FaceType, uint Level);
    HRESULT AddDirtyRect(D3DCUBEMAP_FACES FaceType, const(RECT)* pDirtyRect);
}

const GUID IID_IDirect3DVertexBuffer9 = {0xB64BB1B5, 0xFD70, 0x4DF6, [0xBF, 0x91, 0x19, 0xD0, 0xA1, 0x24, 0x55, 0xE3]};
@GUID(0xB64BB1B5, 0xFD70, 0x4DF6, [0xBF, 0x91, 0x19, 0xD0, 0xA1, 0x24, 0x55, 0xE3]);
interface IDirect3DVertexBuffer9 : IDirect3DResource9
{
    HRESULT Lock(uint OffsetToLock, uint SizeToLock, void** ppbData, uint Flags);
    HRESULT Unlock();
    HRESULT GetDesc(D3DVERTEXBUFFER_DESC* pDesc);
}

const GUID IID_IDirect3DIndexBuffer9 = {0x7C9DD65E, 0xD3F7, 0x4529, [0xAC, 0xEE, 0x78, 0x58, 0x30, 0xAC, 0xDE, 0x35]};
@GUID(0x7C9DD65E, 0xD3F7, 0x4529, [0xAC, 0xEE, 0x78, 0x58, 0x30, 0xAC, 0xDE, 0x35]);
interface IDirect3DIndexBuffer9 : IDirect3DResource9
{
    HRESULT Lock(uint OffsetToLock, uint SizeToLock, void** ppbData, uint Flags);
    HRESULT Unlock();
    HRESULT GetDesc(D3DINDEXBUFFER_DESC* pDesc);
}

const GUID IID_IDirect3DSurface9 = {0x0CFBAF3A, 0x9FF6, 0x429A, [0x99, 0xB3, 0xA2, 0x79, 0x6A, 0xF8, 0xB8, 0x9B]};
@GUID(0x0CFBAF3A, 0x9FF6, 0x429A, [0x99, 0xB3, 0xA2, 0x79, 0x6A, 0xF8, 0xB8, 0x9B]);
interface IDirect3DSurface9 : IDirect3DResource9
{
    HRESULT GetContainer(const(Guid)* riid, void** ppContainer);
    HRESULT GetDesc(D3DSURFACE_DESC* pDesc);
    HRESULT LockRect(D3DLOCKED_RECT* pLockedRect, const(RECT)* pRect, uint Flags);
    HRESULT UnlockRect();
    HRESULT GetDC(HDC* phdc);
    HRESULT ReleaseDC(HDC hdc);
}

const GUID IID_IDirect3DVolume9 = {0x24F416E6, 0x1F67, 0x4AA7, [0xB8, 0x8E, 0xD3, 0x3F, 0x6F, 0x31, 0x28, 0xA1]};
@GUID(0x24F416E6, 0x1F67, 0x4AA7, [0xB8, 0x8E, 0xD3, 0x3F, 0x6F, 0x31, 0x28, 0xA1]);
interface IDirect3DVolume9 : IUnknown
{
    HRESULT GetDevice(IDirect3DDevice9* ppDevice);
    HRESULT SetPrivateData(const(Guid)* refguid, const(void)* pData, uint SizeOfData, uint Flags);
    HRESULT GetPrivateData(const(Guid)* refguid, void* pData, uint* pSizeOfData);
    HRESULT FreePrivateData(const(Guid)* refguid);
    HRESULT GetContainer(const(Guid)* riid, void** ppContainer);
    HRESULT GetDesc(D3DVOLUME_DESC* pDesc);
    HRESULT LockBox(D3DLOCKED_BOX* pLockedVolume, const(D3DBOX)* pBox, uint Flags);
    HRESULT UnlockBox();
}

const GUID IID_IDirect3DQuery9 = {0xD9771460, 0xA695, 0x4F26, [0xBB, 0xD3, 0x27, 0xB8, 0x40, 0xB5, 0x41, 0xCC]};
@GUID(0xD9771460, 0xA695, 0x4F26, [0xBB, 0xD3, 0x27, 0xB8, 0x40, 0xB5, 0x41, 0xCC]);
interface IDirect3DQuery9 : IUnknown
{
    HRESULT GetDevice(IDirect3DDevice9* ppDevice);
    D3DQUERYTYPE GetType();
    uint GetDataSize();
    HRESULT Issue(uint dwIssueFlags);
    HRESULT GetData(void* pData, uint dwSize, uint dwGetDataFlags);
}

const GUID IID_IDirect3D9Ex = {0x02177241, 0x69FC, 0x400C, [0x8F, 0xF1, 0x93, 0xA4, 0x4D, 0xF6, 0x86, 0x1D]};
@GUID(0x02177241, 0x69FC, 0x400C, [0x8F, 0xF1, 0x93, 0xA4, 0x4D, 0xF6, 0x86, 0x1D]);
interface IDirect3D9Ex : IDirect3D9
{
    uint GetAdapterModeCountEx(uint Adapter, const(D3DDISPLAYMODEFILTER)* pFilter);
    HRESULT EnumAdapterModesEx(uint Adapter, const(D3DDISPLAYMODEFILTER)* pFilter, uint Mode, D3DDISPLAYMODEEX* pMode);
    HRESULT GetAdapterDisplayModeEx(uint Adapter, D3DDISPLAYMODEEX* pMode, D3DDISPLAYROTATION* pRotation);
    HRESULT CreateDeviceEx(uint Adapter, D3DDEVTYPE DeviceType, HWND hFocusWindow, uint BehaviorFlags, _D3DPRESENT_PARAMETERS_* pPresentationParameters, D3DDISPLAYMODEEX* pFullscreenDisplayMode, IDirect3DDevice9Ex* ppReturnedDeviceInterface);
    HRESULT GetAdapterLUID(uint Adapter, LUID* pLUID);
}

const GUID IID_IDirect3DDevice9Ex = {0xB18B10CE, 0x2649, 0x405A, [0x87, 0x0F, 0x95, 0xF7, 0x77, 0xD4, 0x31, 0x3A]};
@GUID(0xB18B10CE, 0x2649, 0x405A, [0x87, 0x0F, 0x95, 0xF7, 0x77, 0xD4, 0x31, 0x3A]);
interface IDirect3DDevice9Ex : IDirect3DDevice9
{
    HRESULT SetConvolutionMonoKernel(uint width, uint height, float* rows, float* columns);
    HRESULT ComposeRects(IDirect3DSurface9 pSrc, IDirect3DSurface9 pDst, IDirect3DVertexBuffer9 pSrcRectDescs, uint NumRects, IDirect3DVertexBuffer9 pDstRectDescs, D3DCOMPOSERECTSOP Operation, int Xoffset, int Yoffset);
    HRESULT PresentEx(const(RECT)* pSourceRect, const(RECT)* pDestRect, HWND hDestWindowOverride, const(RGNDATA)* pDirtyRegion, uint dwFlags);
    HRESULT GetGPUThreadPriority(int* pPriority);
    HRESULT SetGPUThreadPriority(int Priority);
    HRESULT WaitForVBlank(uint iSwapChain);
    HRESULT CheckResourceResidency(IDirect3DResource9* pResourceArray, uint NumResources);
    HRESULT SetMaximumFrameLatency(uint MaxLatency);
    HRESULT GetMaximumFrameLatency(uint* pMaxLatency);
    HRESULT CheckDeviceState(HWND hDestinationWindow);
    HRESULT CreateRenderTargetEx(uint Width, uint Height, D3DFORMAT Format, D3DMULTISAMPLE_TYPE MultiSample, uint MultisampleQuality, BOOL Lockable, IDirect3DSurface9* ppSurface, HANDLE* pSharedHandle, uint Usage);
    HRESULT CreateOffscreenPlainSurfaceEx(uint Width, uint Height, D3DFORMAT Format, D3DPOOL Pool, IDirect3DSurface9* ppSurface, HANDLE* pSharedHandle, uint Usage);
    HRESULT CreateDepthStencilSurfaceEx(uint Width, uint Height, D3DFORMAT Format, D3DMULTISAMPLE_TYPE MultiSample, uint MultisampleQuality, BOOL Discard, IDirect3DSurface9* ppSurface, HANDLE* pSharedHandle, uint Usage);
    HRESULT ResetEx(_D3DPRESENT_PARAMETERS_* pPresentationParameters, D3DDISPLAYMODEEX* pFullscreenDisplayMode);
    HRESULT GetDisplayModeEx(uint iSwapChain, D3DDISPLAYMODEEX* pMode, D3DDISPLAYROTATION* pRotation);
}

const GUID IID_IDirect3DSwapChain9Ex = {0x91886CAF, 0x1C3D, 0x4D2E, [0xA0, 0xAB, 0x3E, 0x4C, 0x7D, 0x8D, 0x33, 0x03]};
@GUID(0x91886CAF, 0x1C3D, 0x4D2E, [0xA0, 0xAB, 0x3E, 0x4C, 0x7D, 0x8D, 0x33, 0x03]);
interface IDirect3DSwapChain9Ex : IDirect3DSwapChain9
{
    HRESULT GetLastPresentCount(uint* pLastPresentCount);
    HRESULT GetPresentStats(D3DPRESENTSTATS* pPresentationStatistics);
    HRESULT GetDisplayModeEx(D3DDISPLAYMODEEX* pMode, D3DDISPLAYROTATION* pRotation);
}

