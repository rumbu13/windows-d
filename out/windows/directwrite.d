module windows.directwrite;

public import system;
public import windows.com;
public import windows.direct2d;
public import windows.displaydevices;
public import windows.dxgi;
public import windows.gdi;
public import windows.intl;
public import windows.shell;
public import windows.systemservices;
public import windows.windowsprogramming;

extern(Windows):

@DllImport("DWrite.dll")
HRESULT DWriteCreateFactory(DWRITE_FACTORY_TYPE factoryType, const(Guid)* iid, IUnknown* factory);

enum DWRITE_FONT_AXIS_TAG
{
    DWRITE_FONT_AXIS_TAG_WEIGHT = 1952999287,
    DWRITE_FONT_AXIS_TAG_WIDTH = 1752458359,
    DWRITE_FONT_AXIS_TAG_SLANT = 1953393779,
    DWRITE_FONT_AXIS_TAG_OPTICAL_SIZE = 2054385775,
    DWRITE_FONT_AXIS_TAG_ITALIC = 1818326121,
}

enum DWRITE_FONT_FILE_TYPE
{
    DWRITE_FONT_FILE_TYPE_UNKNOWN = 0,
    DWRITE_FONT_FILE_TYPE_CFF = 1,
    DWRITE_FONT_FILE_TYPE_TRUETYPE = 2,
    DWRITE_FONT_FILE_TYPE_OPENTYPE_COLLECTION = 3,
    DWRITE_FONT_FILE_TYPE_TYPE1_PFM = 4,
    DWRITE_FONT_FILE_TYPE_TYPE1_PFB = 5,
    DWRITE_FONT_FILE_TYPE_VECTOR = 6,
    DWRITE_FONT_FILE_TYPE_BITMAP = 7,
    DWRITE_FONT_FILE_TYPE_TRUETYPE_COLLECTION = 3,
}

enum DWRITE_FONT_FACE_TYPE
{
    DWRITE_FONT_FACE_TYPE_CFF = 0,
    DWRITE_FONT_FACE_TYPE_TRUETYPE = 1,
    DWRITE_FONT_FACE_TYPE_OPENTYPE_COLLECTION = 2,
    DWRITE_FONT_FACE_TYPE_TYPE1 = 3,
    DWRITE_FONT_FACE_TYPE_VECTOR = 4,
    DWRITE_FONT_FACE_TYPE_BITMAP = 5,
    DWRITE_FONT_FACE_TYPE_UNKNOWN = 6,
    DWRITE_FONT_FACE_TYPE_RAW_CFF = 7,
    DWRITE_FONT_FACE_TYPE_TRUETYPE_COLLECTION = 2,
}

enum DWRITE_FONT_SIMULATIONS
{
    DWRITE_FONT_SIMULATIONS_NONE = 0,
    DWRITE_FONT_SIMULATIONS_BOLD = 1,
    DWRITE_FONT_SIMULATIONS_OBLIQUE = 2,
}

enum DWRITE_FONT_WEIGHT
{
    DWRITE_FONT_WEIGHT_THIN = 100,
    DWRITE_FONT_WEIGHT_EXTRA_LIGHT = 200,
    DWRITE_FONT_WEIGHT_ULTRA_LIGHT = 200,
    DWRITE_FONT_WEIGHT_LIGHT = 300,
    DWRITE_FONT_WEIGHT_SEMI_LIGHT = 350,
    DWRITE_FONT_WEIGHT_NORMAL = 400,
    DWRITE_FONT_WEIGHT_REGULAR = 400,
    DWRITE_FONT_WEIGHT_MEDIUM = 500,
    DWRITE_FONT_WEIGHT_DEMI_BOLD = 600,
    DWRITE_FONT_WEIGHT_SEMI_BOLD = 600,
    DWRITE_FONT_WEIGHT_BOLD = 700,
    DWRITE_FONT_WEIGHT_EXTRA_BOLD = 800,
    DWRITE_FONT_WEIGHT_ULTRA_BOLD = 800,
    DWRITE_FONT_WEIGHT_BLACK = 900,
    DWRITE_FONT_WEIGHT_HEAVY = 900,
    DWRITE_FONT_WEIGHT_EXTRA_BLACK = 950,
    DWRITE_FONT_WEIGHT_ULTRA_BLACK = 950,
}

enum DWRITE_FONT_STRETCH
{
    DWRITE_FONT_STRETCH_UNDEFINED = 0,
    DWRITE_FONT_STRETCH_ULTRA_CONDENSED = 1,
    DWRITE_FONT_STRETCH_EXTRA_CONDENSED = 2,
    DWRITE_FONT_STRETCH_CONDENSED = 3,
    DWRITE_FONT_STRETCH_SEMI_CONDENSED = 4,
    DWRITE_FONT_STRETCH_NORMAL = 5,
    DWRITE_FONT_STRETCH_MEDIUM = 5,
    DWRITE_FONT_STRETCH_SEMI_EXPANDED = 6,
    DWRITE_FONT_STRETCH_EXPANDED = 7,
    DWRITE_FONT_STRETCH_EXTRA_EXPANDED = 8,
    DWRITE_FONT_STRETCH_ULTRA_EXPANDED = 9,
}

enum DWRITE_FONT_STYLE
{
    DWRITE_FONT_STYLE_NORMAL = 0,
    DWRITE_FONT_STYLE_OBLIQUE = 1,
    DWRITE_FONT_STYLE_ITALIC = 2,
}

enum DWRITE_INFORMATIONAL_STRING_ID
{
    DWRITE_INFORMATIONAL_STRING_NONE = 0,
    DWRITE_INFORMATIONAL_STRING_COPYRIGHT_NOTICE = 1,
    DWRITE_INFORMATIONAL_STRING_VERSION_STRINGS = 2,
    DWRITE_INFORMATIONAL_STRING_TRADEMARK = 3,
    DWRITE_INFORMATIONAL_STRING_MANUFACTURER = 4,
    DWRITE_INFORMATIONAL_STRING_DESIGNER = 5,
    DWRITE_INFORMATIONAL_STRING_DESIGNER_URL = 6,
    DWRITE_INFORMATIONAL_STRING_DESCRIPTION = 7,
    DWRITE_INFORMATIONAL_STRING_FONT_VENDOR_URL = 8,
    DWRITE_INFORMATIONAL_STRING_LICENSE_DESCRIPTION = 9,
    DWRITE_INFORMATIONAL_STRING_LICENSE_INFO_URL = 10,
    DWRITE_INFORMATIONAL_STRING_WIN32_FAMILY_NAMES = 11,
    DWRITE_INFORMATIONAL_STRING_WIN32_SUBFAMILY_NAMES = 12,
    DWRITE_INFORMATIONAL_STRING_TYPOGRAPHIC_FAMILY_NAMES = 13,
    DWRITE_INFORMATIONAL_STRING_TYPOGRAPHIC_SUBFAMILY_NAMES = 14,
    DWRITE_INFORMATIONAL_STRING_SAMPLE_TEXT = 15,
    DWRITE_INFORMATIONAL_STRING_FULL_NAME = 16,
    DWRITE_INFORMATIONAL_STRING_POSTSCRIPT_NAME = 17,
    DWRITE_INFORMATIONAL_STRING_POSTSCRIPT_CID_NAME = 18,
    DWRITE_INFORMATIONAL_STRING_WEIGHT_STRETCH_STYLE_FAMILY_NAME = 19,
    DWRITE_INFORMATIONAL_STRING_DESIGN_SCRIPT_LANGUAGE_TAG = 20,
    DWRITE_INFORMATIONAL_STRING_SUPPORTED_SCRIPT_LANGUAGE_TAG = 21,
    DWRITE_INFORMATIONAL_STRING_PREFERRED_FAMILY_NAMES = 13,
    DWRITE_INFORMATIONAL_STRING_PREFERRED_SUBFAMILY_NAMES = 14,
    DWRITE_INFORMATIONAL_STRING_WWS_FAMILY_NAME = 19,
}

struct DWRITE_FONT_METRICS
{
    ushort designUnitsPerEm;
    ushort ascent;
    ushort descent;
    short lineGap;
    ushort capHeight;
    ushort xHeight;
    short underlinePosition;
    ushort underlineThickness;
    short strikethroughPosition;
    ushort strikethroughThickness;
}

struct DWRITE_GLYPH_METRICS
{
    int leftSideBearing;
    uint advanceWidth;
    int rightSideBearing;
    int topSideBearing;
    uint advanceHeight;
    int bottomSideBearing;
    int verticalOriginY;
}

struct DWRITE_GLYPH_OFFSET
{
    float advanceOffset;
    float ascenderOffset;
}

enum DWRITE_FACTORY_TYPE
{
    DWRITE_FACTORY_TYPE_SHARED = 0,
    DWRITE_FACTORY_TYPE_ISOLATED = 1,
}

const GUID IID_IDWriteFontFileLoader = {0x727CAD4E, 0xD6AF, 0x4C9E, [0x8A, 0x08, 0xD6, 0x95, 0xB1, 0x1C, 0xAA, 0x49]};
@GUID(0x727CAD4E, 0xD6AF, 0x4C9E, [0x8A, 0x08, 0xD6, 0x95, 0xB1, 0x1C, 0xAA, 0x49]);
interface IDWriteFontFileLoader : IUnknown
{
    HRESULT CreateStreamFromKey(char* fontFileReferenceKey, uint fontFileReferenceKeySize, IDWriteFontFileStream* fontFileStream);
}

const GUID IID_IDWriteLocalFontFileLoader = {0xB2D9F3EC, 0xC9FE, 0x4A11, [0xA2, 0xEC, 0xD8, 0x62, 0x08, 0xF7, 0xC0, 0xA2]};
@GUID(0xB2D9F3EC, 0xC9FE, 0x4A11, [0xA2, 0xEC, 0xD8, 0x62, 0x08, 0xF7, 0xC0, 0xA2]);
interface IDWriteLocalFontFileLoader : IDWriteFontFileLoader
{
    HRESULT GetFilePathLengthFromKey(char* fontFileReferenceKey, uint fontFileReferenceKeySize, uint* filePathLength);
    HRESULT GetFilePathFromKey(char* fontFileReferenceKey, uint fontFileReferenceKeySize, char* filePath, uint filePathSize);
    HRESULT GetLastWriteTimeFromKey(char* fontFileReferenceKey, uint fontFileReferenceKeySize, FILETIME* lastWriteTime);
}

const GUID IID_IDWriteFontFileStream = {0x6D4865FE, 0x0AB8, 0x4D91, [0x8F, 0x62, 0x5D, 0xD6, 0xBE, 0x34, 0xA3, 0xE0]};
@GUID(0x6D4865FE, 0x0AB8, 0x4D91, [0x8F, 0x62, 0x5D, 0xD6, 0xBE, 0x34, 0xA3, 0xE0]);
interface IDWriteFontFileStream : IUnknown
{
    HRESULT ReadFileFragment(const(void)** fragmentStart, ulong fileOffset, ulong fragmentSize, void** fragmentContext);
    void ReleaseFileFragment(void* fragmentContext);
    HRESULT GetFileSize(ulong* fileSize);
    HRESULT GetLastWriteTime(ulong* lastWriteTime);
}

const GUID IID_IDWriteFontFile = {0x739D886A, 0xCEF5, 0x47DC, [0x87, 0x69, 0x1A, 0x8B, 0x41, 0xBE, 0xBB, 0xB0]};
@GUID(0x739D886A, 0xCEF5, 0x47DC, [0x87, 0x69, 0x1A, 0x8B, 0x41, 0xBE, 0xBB, 0xB0]);
interface IDWriteFontFile : IUnknown
{
    HRESULT GetReferenceKey(const(void)** fontFileReferenceKey, uint* fontFileReferenceKeySize);
    HRESULT GetLoader(IDWriteFontFileLoader* fontFileLoader);
    HRESULT Analyze(int* isSupportedFontType, DWRITE_FONT_FILE_TYPE* fontFileType, DWRITE_FONT_FACE_TYPE* fontFaceType, uint* numberOfFaces);
}

enum DWRITE_PIXEL_GEOMETRY
{
    DWRITE_PIXEL_GEOMETRY_FLAT = 0,
    DWRITE_PIXEL_GEOMETRY_RGB = 1,
    DWRITE_PIXEL_GEOMETRY_BGR = 2,
}

enum DWRITE_RENDERING_MODE
{
    DWRITE_RENDERING_MODE_DEFAULT = 0,
    DWRITE_RENDERING_MODE_ALIASED = 1,
    DWRITE_RENDERING_MODE_GDI_CLASSIC = 2,
    DWRITE_RENDERING_MODE_GDI_NATURAL = 3,
    DWRITE_RENDERING_MODE_NATURAL = 4,
    DWRITE_RENDERING_MODE_NATURAL_SYMMETRIC = 5,
    DWRITE_RENDERING_MODE_OUTLINE = 6,
    DWRITE_RENDERING_MODE_CLEARTYPE_GDI_CLASSIC = 2,
    DWRITE_RENDERING_MODE_CLEARTYPE_GDI_NATURAL = 3,
    DWRITE_RENDERING_MODE_CLEARTYPE_NATURAL = 4,
    DWRITE_RENDERING_MODE_CLEARTYPE_NATURAL_SYMMETRIC = 5,
}

struct DWRITE_MATRIX
{
    float m11;
    float m12;
    float m21;
    float m22;
    float dx;
    float dy;
}

const GUID IID_IDWriteRenderingParams = {0x2F0DA53A, 0x2ADD, 0x47CD, [0x82, 0xEE, 0xD9, 0xEC, 0x34, 0x68, 0x8E, 0x75]};
@GUID(0x2F0DA53A, 0x2ADD, 0x47CD, [0x82, 0xEE, 0xD9, 0xEC, 0x34, 0x68, 0x8E, 0x75]);
interface IDWriteRenderingParams : IUnknown
{
    float GetGamma();
    float GetEnhancedContrast();
    float GetClearTypeLevel();
    DWRITE_PIXEL_GEOMETRY GetPixelGeometry();
    DWRITE_RENDERING_MODE GetRenderingMode();
}

const GUID IID_IDWriteFontFace = {0x5F49804D, 0x7024, 0x4D43, [0xBF, 0xA9, 0xD2, 0x59, 0x84, 0xF5, 0x38, 0x49]};
@GUID(0x5F49804D, 0x7024, 0x4D43, [0xBF, 0xA9, 0xD2, 0x59, 0x84, 0xF5, 0x38, 0x49]);
interface IDWriteFontFace : IUnknown
{
    DWRITE_FONT_FACE_TYPE GetType();
    HRESULT GetFiles(uint* numberOfFiles, char* fontFiles);
    uint GetIndex();
    DWRITE_FONT_SIMULATIONS GetSimulations();
    BOOL IsSymbolFont();
    void GetMetrics(DWRITE_FONT_METRICS* fontFaceMetrics);
    ushort GetGlyphCount();
    HRESULT GetDesignGlyphMetrics(char* glyphIndices, uint glyphCount, char* glyphMetrics, BOOL isSideways);
    HRESULT GetGlyphIndicesA(char* codePoints, uint codePointCount, char* glyphIndices);
    HRESULT TryGetFontTable(uint openTypeTableTag, const(void)** tableData, uint* tableSize, void** tableContext, int* exists);
    void ReleaseFontTable(void* tableContext);
    HRESULT GetGlyphRunOutline(float emSize, char* glyphIndices, char* glyphAdvances, char* glyphOffsets, uint glyphCount, BOOL isSideways, BOOL isRightToLeft, ID2D1SimplifiedGeometrySink geometrySink);
    HRESULT GetRecommendedRenderingMode(float emSize, float pixelsPerDip, DWRITE_MEASURING_MODE measuringMode, IDWriteRenderingParams renderingParams, DWRITE_RENDERING_MODE* renderingMode);
    HRESULT GetGdiCompatibleMetrics(float emSize, float pixelsPerDip, const(DWRITE_MATRIX)* transform, DWRITE_FONT_METRICS* fontFaceMetrics);
    HRESULT GetGdiCompatibleGlyphMetrics(float emSize, float pixelsPerDip, const(DWRITE_MATRIX)* transform, BOOL useGdiNatural, char* glyphIndices, uint glyphCount, char* glyphMetrics, BOOL isSideways);
}

const GUID IID_IDWriteFontCollectionLoader = {0xCCA920E4, 0x52F0, 0x492B, [0xBF, 0xA8, 0x29, 0xC7, 0x2E, 0xE0, 0xA4, 0x68]};
@GUID(0xCCA920E4, 0x52F0, 0x492B, [0xBF, 0xA8, 0x29, 0xC7, 0x2E, 0xE0, 0xA4, 0x68]);
interface IDWriteFontCollectionLoader : IUnknown
{
    HRESULT CreateEnumeratorFromKey(IDWriteFactory factory, char* collectionKey, uint collectionKeySize, IDWriteFontFileEnumerator* fontFileEnumerator);
}

const GUID IID_IDWriteFontFileEnumerator = {0x72755049, 0x5FF7, 0x435D, [0x83, 0x48, 0x4B, 0xE9, 0x7C, 0xFA, 0x6C, 0x7C]};
@GUID(0x72755049, 0x5FF7, 0x435D, [0x83, 0x48, 0x4B, 0xE9, 0x7C, 0xFA, 0x6C, 0x7C]);
interface IDWriteFontFileEnumerator : IUnknown
{
    HRESULT MoveNext(int* hasCurrentFile);
    HRESULT GetCurrentFontFile(IDWriteFontFile* fontFile);
}

const GUID IID_IDWriteLocalizedStrings = {0x08256209, 0x099A, 0x4B34, [0xB8, 0x6D, 0xC2, 0x2B, 0x11, 0x0E, 0x77, 0x71]};
@GUID(0x08256209, 0x099A, 0x4B34, [0xB8, 0x6D, 0xC2, 0x2B, 0x11, 0x0E, 0x77, 0x71]);
interface IDWriteLocalizedStrings : IUnknown
{
    uint GetCount();
    HRESULT FindLocaleName(const(wchar)* localeName, uint* index, int* exists);
    HRESULT GetLocaleNameLength(uint index, uint* length);
    HRESULT GetLocaleName(uint index, char* localeName, uint size);
    HRESULT GetStringLength(uint index, uint* length);
    HRESULT GetString(uint index, char* stringBuffer, uint size);
}

const GUID IID_IDWriteFontCollection = {0xA84CEE02, 0x3EEA, 0x4EEE, [0xA8, 0x27, 0x87, 0xC1, 0xA0, 0x2A, 0x0F, 0xCC]};
@GUID(0xA84CEE02, 0x3EEA, 0x4EEE, [0xA8, 0x27, 0x87, 0xC1, 0xA0, 0x2A, 0x0F, 0xCC]);
interface IDWriteFontCollection : IUnknown
{
    uint GetFontFamilyCount();
    HRESULT GetFontFamily(uint index, IDWriteFontFamily* fontFamily);
    HRESULT FindFamilyName(const(wchar)* familyName, uint* index, int* exists);
    HRESULT GetFontFromFontFace(IDWriteFontFace fontFace, IDWriteFont* font);
}

const GUID IID_IDWriteFontList = {0x1A0D8438, 0x1D97, 0x4EC1, [0xAE, 0xF9, 0xA2, 0xFB, 0x86, 0xED, 0x6A, 0xCB]};
@GUID(0x1A0D8438, 0x1D97, 0x4EC1, [0xAE, 0xF9, 0xA2, 0xFB, 0x86, 0xED, 0x6A, 0xCB]);
interface IDWriteFontList : IUnknown
{
    HRESULT GetFontCollection(IDWriteFontCollection* fontCollection);
    uint GetFontCount();
    HRESULT GetFont(uint index, IDWriteFont* font);
}

const GUID IID_IDWriteFontFamily = {0xDA20D8EF, 0x812A, 0x4C43, [0x98, 0x02, 0x62, 0xEC, 0x4A, 0xBD, 0x7A, 0xDD]};
@GUID(0xDA20D8EF, 0x812A, 0x4C43, [0x98, 0x02, 0x62, 0xEC, 0x4A, 0xBD, 0x7A, 0xDD]);
interface IDWriteFontFamily : IDWriteFontList
{
    HRESULT GetFamilyNames(IDWriteLocalizedStrings* names);
    HRESULT GetFirstMatchingFont(DWRITE_FONT_WEIGHT weight, DWRITE_FONT_STRETCH stretch, DWRITE_FONT_STYLE style, IDWriteFont* matchingFont);
    HRESULT GetMatchingFonts(DWRITE_FONT_WEIGHT weight, DWRITE_FONT_STRETCH stretch, DWRITE_FONT_STYLE style, IDWriteFontList* matchingFonts);
}

const GUID IID_IDWriteFont = {0xACD16696, 0x8C14, 0x4F5D, [0x87, 0x7E, 0xFE, 0x3F, 0xC1, 0xD3, 0x27, 0x37]};
@GUID(0xACD16696, 0x8C14, 0x4F5D, [0x87, 0x7E, 0xFE, 0x3F, 0xC1, 0xD3, 0x27, 0x37]);
interface IDWriteFont : IUnknown
{
    HRESULT GetFontFamily(IDWriteFontFamily* fontFamily);
    DWRITE_FONT_WEIGHT GetWeight();
    DWRITE_FONT_STRETCH GetStretch();
    DWRITE_FONT_STYLE GetStyle();
    BOOL IsSymbolFont();
    HRESULT GetFaceNames(IDWriteLocalizedStrings* names);
    HRESULT GetInformationalStrings(DWRITE_INFORMATIONAL_STRING_ID informationalStringID, IDWriteLocalizedStrings* informationalStrings, int* exists);
    DWRITE_FONT_SIMULATIONS GetSimulations();
    void GetMetrics(DWRITE_FONT_METRICS* fontMetrics);
    HRESULT HasCharacter(uint unicodeValue, int* exists);
    HRESULT CreateFontFace(IDWriteFontFace* fontFace);
}

enum DWRITE_READING_DIRECTION
{
    DWRITE_READING_DIRECTION_LEFT_TO_RIGHT = 0,
    DWRITE_READING_DIRECTION_RIGHT_TO_LEFT = 1,
    DWRITE_READING_DIRECTION_TOP_TO_BOTTOM = 2,
    DWRITE_READING_DIRECTION_BOTTOM_TO_TOP = 3,
}

enum DWRITE_FLOW_DIRECTION
{
    DWRITE_FLOW_DIRECTION_TOP_TO_BOTTOM = 0,
    DWRITE_FLOW_DIRECTION_BOTTOM_TO_TOP = 1,
    DWRITE_FLOW_DIRECTION_LEFT_TO_RIGHT = 2,
    DWRITE_FLOW_DIRECTION_RIGHT_TO_LEFT = 3,
}

enum DWRITE_TEXT_ALIGNMENT
{
    DWRITE_TEXT_ALIGNMENT_LEADING = 0,
    DWRITE_TEXT_ALIGNMENT_TRAILING = 1,
    DWRITE_TEXT_ALIGNMENT_CENTER = 2,
    DWRITE_TEXT_ALIGNMENT_JUSTIFIED = 3,
}

enum DWRITE_PARAGRAPH_ALIGNMENT
{
    DWRITE_PARAGRAPH_ALIGNMENT_NEAR = 0,
    DWRITE_PARAGRAPH_ALIGNMENT_FAR = 1,
    DWRITE_PARAGRAPH_ALIGNMENT_CENTER = 2,
}

enum DWRITE_WORD_WRAPPING
{
    DWRITE_WORD_WRAPPING_WRAP = 0,
    DWRITE_WORD_WRAPPING_NO_WRAP = 1,
    DWRITE_WORD_WRAPPING_EMERGENCY_BREAK = 2,
    DWRITE_WORD_WRAPPING_WHOLE_WORD = 3,
    DWRITE_WORD_WRAPPING_CHARACTER = 4,
}

enum DWRITE_LINE_SPACING_METHOD
{
    DWRITE_LINE_SPACING_METHOD_DEFAULT = 0,
    DWRITE_LINE_SPACING_METHOD_UNIFORM = 1,
    DWRITE_LINE_SPACING_METHOD_PROPORTIONAL = 2,
}

enum DWRITE_TRIMMING_GRANULARITY
{
    DWRITE_TRIMMING_GRANULARITY_NONE = 0,
    DWRITE_TRIMMING_GRANULARITY_CHARACTER = 1,
    DWRITE_TRIMMING_GRANULARITY_WORD = 2,
}

enum DWRITE_FONT_FEATURE_TAG
{
    DWRITE_FONT_FEATURE_TAG_ALTERNATIVE_FRACTIONS = 1668441697,
    DWRITE_FONT_FEATURE_TAG_PETITE_CAPITALS_FROM_CAPITALS = 1668297315,
    DWRITE_FONT_FEATURE_TAG_SMALL_CAPITALS_FROM_CAPITALS = 1668493923,
    DWRITE_FONT_FEATURE_TAG_CONTEXTUAL_ALTERNATES = 1953259875,
    DWRITE_FONT_FEATURE_TAG_CASE_SENSITIVE_FORMS = 1702060387,
    DWRITE_FONT_FEATURE_TAG_GLYPH_COMPOSITION_DECOMPOSITION = 1886217059,
    DWRITE_FONT_FEATURE_TAG_CONTEXTUAL_LIGATURES = 1734962275,
    DWRITE_FONT_FEATURE_TAG_CAPITAL_SPACING = 1886613603,
    DWRITE_FONT_FEATURE_TAG_CONTEXTUAL_SWASH = 1752658787,
    DWRITE_FONT_FEATURE_TAG_CURSIVE_POSITIONING = 1936880995,
    DWRITE_FONT_FEATURE_TAG_DEFAULT = 1953261156,
    DWRITE_FONT_FEATURE_TAG_DISCRETIONARY_LIGATURES = 1734962276,
    DWRITE_FONT_FEATURE_TAG_EXPERT_FORMS = 1953527909,
    DWRITE_FONT_FEATURE_TAG_FRACTIONS = 1667330662,
    DWRITE_FONT_FEATURE_TAG_FULL_WIDTH = 1684633446,
    DWRITE_FONT_FEATURE_TAG_HALF_FORMS = 1718378856,
    DWRITE_FONT_FEATURE_TAG_HALANT_FORMS = 1852596584,
    DWRITE_FONT_FEATURE_TAG_ALTERNATE_HALF_WIDTH = 1953259880,
    DWRITE_FONT_FEATURE_TAG_HISTORICAL_FORMS = 1953720680,
    DWRITE_FONT_FEATURE_TAG_HORIZONTAL_KANA_ALTERNATES = 1634626408,
    DWRITE_FONT_FEATURE_TAG_HISTORICAL_LIGATURES = 1734962280,
    DWRITE_FONT_FEATURE_TAG_HALF_WIDTH = 1684633448,
    DWRITE_FONT_FEATURE_TAG_HOJO_KANJI_FORMS = 1869246312,
    DWRITE_FONT_FEATURE_TAG_JIS04_FORMS = 875589738,
    DWRITE_FONT_FEATURE_TAG_JIS78_FORMS = 943157354,
    DWRITE_FONT_FEATURE_TAG_JIS83_FORMS = 859336810,
    DWRITE_FONT_FEATURE_TAG_JIS90_FORMS = 809070698,
    DWRITE_FONT_FEATURE_TAG_KERNING = 1852990827,
    DWRITE_FONT_FEATURE_TAG_STANDARD_LIGATURES = 1634167148,
    DWRITE_FONT_FEATURE_TAG_LINING_FIGURES = 1836412524,
    DWRITE_FONT_FEATURE_TAG_LOCALIZED_FORMS = 1818455916,
    DWRITE_FONT_FEATURE_TAG_MARK_POSITIONING = 1802658157,
    DWRITE_FONT_FEATURE_TAG_MATHEMATICAL_GREEK = 1802659693,
    DWRITE_FONT_FEATURE_TAG_MARK_TO_MARK_POSITIONING = 1802333037,
    DWRITE_FONT_FEATURE_TAG_ALTERNATE_ANNOTATION_FORMS = 1953259886,
    DWRITE_FONT_FEATURE_TAG_NLC_KANJI_FORMS = 1801677934,
    DWRITE_FONT_FEATURE_TAG_OLD_STYLE_FIGURES = 1836412527,
    DWRITE_FONT_FEATURE_TAG_ORDINALS = 1852076655,
    DWRITE_FONT_FEATURE_TAG_PROPORTIONAL_ALTERNATE_WIDTH = 1953259888,
    DWRITE_FONT_FEATURE_TAG_PETITE_CAPITALS = 1885430640,
    DWRITE_FONT_FEATURE_TAG_PROPORTIONAL_FIGURES = 1836412528,
    DWRITE_FONT_FEATURE_TAG_PROPORTIONAL_WIDTHS = 1684633456,
    DWRITE_FONT_FEATURE_TAG_QUARTER_WIDTHS = 1684633457,
    DWRITE_FONT_FEATURE_TAG_REQUIRED_LIGATURES = 1734962290,
    DWRITE_FONT_FEATURE_TAG_RUBY_NOTATION_FORMS = 2036495730,
    DWRITE_FONT_FEATURE_TAG_STYLISTIC_ALTERNATES = 1953259891,
    DWRITE_FONT_FEATURE_TAG_SCIENTIFIC_INFERIORS = 1718511987,
    DWRITE_FONT_FEATURE_TAG_SMALL_CAPITALS = 1885564275,
    DWRITE_FONT_FEATURE_TAG_SIMPLIFIED_FORMS = 1819307379,
    DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_1 = 825258867,
    DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_2 = 842036083,
    DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_3 = 858813299,
    DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_4 = 875590515,
    DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_5 = 892367731,
    DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_6 = 909144947,
    DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_7 = 925922163,
    DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_8 = 942699379,
    DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_9 = 959476595,
    DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_10 = 808547187,
    DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_11 = 825324403,
    DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_12 = 842101619,
    DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_13 = 858878835,
    DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_14 = 875656051,
    DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_15 = 892433267,
    DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_16 = 909210483,
    DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_17 = 925987699,
    DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_18 = 942764915,
    DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_19 = 959542131,
    DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_20 = 808612723,
    DWRITE_FONT_FEATURE_TAG_SUBSCRIPT = 1935832435,
    DWRITE_FONT_FEATURE_TAG_SUPERSCRIPT = 1936749939,
    DWRITE_FONT_FEATURE_TAG_SWASH = 1752397683,
    DWRITE_FONT_FEATURE_TAG_TITLING = 1819568500,
    DWRITE_FONT_FEATURE_TAG_TRADITIONAL_NAME_FORMS = 1835101812,
    DWRITE_FONT_FEATURE_TAG_TABULAR_FIGURES = 1836412532,
    DWRITE_FONT_FEATURE_TAG_TRADITIONAL_FORMS = 1684107892,
    DWRITE_FONT_FEATURE_TAG_THIRD_WIDTHS = 1684633460,
    DWRITE_FONT_FEATURE_TAG_UNICASE = 1667853941,
    DWRITE_FONT_FEATURE_TAG_VERTICAL_WRITING = 1953654134,
    DWRITE_FONT_FEATURE_TAG_VERTICAL_ALTERNATES_AND_ROTATION = 846492278,
    DWRITE_FONT_FEATURE_TAG_SLASHED_ZERO = 1869768058,
}

struct DWRITE_TEXT_RANGE
{
    uint startPosition;
    uint length;
}

struct DWRITE_FONT_FEATURE
{
    DWRITE_FONT_FEATURE_TAG nameTag;
    uint parameter;
}

struct DWRITE_TYPOGRAPHIC_FEATURES
{
    DWRITE_FONT_FEATURE* features;
    uint featureCount;
}

struct DWRITE_TRIMMING
{
    DWRITE_TRIMMING_GRANULARITY granularity;
    uint delimiter;
    uint delimiterCount;
}

const GUID IID_IDWriteTextFormat = {0x9C906818, 0x31D7, 0x4FD3, [0xA1, 0x51, 0x7C, 0x5E, 0x22, 0x5D, 0xB5, 0x5A]};
@GUID(0x9C906818, 0x31D7, 0x4FD3, [0xA1, 0x51, 0x7C, 0x5E, 0x22, 0x5D, 0xB5, 0x5A]);
interface IDWriteTextFormat : IUnknown
{
    HRESULT SetTextAlignment(DWRITE_TEXT_ALIGNMENT textAlignment);
    HRESULT SetParagraphAlignment(DWRITE_PARAGRAPH_ALIGNMENT paragraphAlignment);
    HRESULT SetWordWrapping(DWRITE_WORD_WRAPPING wordWrapping);
    HRESULT SetReadingDirection(DWRITE_READING_DIRECTION readingDirection);
    HRESULT SetFlowDirection(DWRITE_FLOW_DIRECTION flowDirection);
    HRESULT SetIncrementalTabStop(float incrementalTabStop);
    HRESULT SetTrimming(const(DWRITE_TRIMMING)* trimmingOptions, IDWriteInlineObject trimmingSign);
    HRESULT SetLineSpacing(DWRITE_LINE_SPACING_METHOD lineSpacingMethod, float lineSpacing, float baseline);
    DWRITE_TEXT_ALIGNMENT GetTextAlignment();
    DWRITE_PARAGRAPH_ALIGNMENT GetParagraphAlignment();
    DWRITE_WORD_WRAPPING GetWordWrapping();
    DWRITE_READING_DIRECTION GetReadingDirection();
    DWRITE_FLOW_DIRECTION GetFlowDirection();
    float GetIncrementalTabStop();
    HRESULT GetTrimming(DWRITE_TRIMMING* trimmingOptions, IDWriteInlineObject* trimmingSign);
    HRESULT GetLineSpacing(DWRITE_LINE_SPACING_METHOD* lineSpacingMethod, float* lineSpacing, float* baseline);
    HRESULT GetFontCollection(IDWriteFontCollection* fontCollection);
    uint GetFontFamilyNameLength();
    HRESULT GetFontFamilyName(char* fontFamilyName, uint nameSize);
    DWRITE_FONT_WEIGHT GetFontWeight();
    DWRITE_FONT_STYLE GetFontStyle();
    DWRITE_FONT_STRETCH GetFontStretch();
    float GetFontSize();
    uint GetLocaleNameLength();
    HRESULT GetLocaleName(char* localeName, uint nameSize);
}

const GUID IID_IDWriteTypography = {0x55F1112B, 0x1DC2, 0x4B3C, [0x95, 0x41, 0xF4, 0x68, 0x94, 0xED, 0x85, 0xB6]};
@GUID(0x55F1112B, 0x1DC2, 0x4B3C, [0x95, 0x41, 0xF4, 0x68, 0x94, 0xED, 0x85, 0xB6]);
interface IDWriteTypography : IUnknown
{
    HRESULT AddFontFeature(DWRITE_FONT_FEATURE fontFeature);
    uint GetFontFeatureCount();
    HRESULT GetFontFeature(uint fontFeatureIndex, DWRITE_FONT_FEATURE* fontFeature);
}

enum DWRITE_SCRIPT_SHAPES
{
    DWRITE_SCRIPT_SHAPES_DEFAULT = 0,
    DWRITE_SCRIPT_SHAPES_NO_VISUAL = 1,
}

struct DWRITE_SCRIPT_ANALYSIS
{
    ushort script;
    DWRITE_SCRIPT_SHAPES shapes;
}

enum DWRITE_BREAK_CONDITION
{
    DWRITE_BREAK_CONDITION_NEUTRAL = 0,
    DWRITE_BREAK_CONDITION_CAN_BREAK = 1,
    DWRITE_BREAK_CONDITION_MAY_NOT_BREAK = 2,
    DWRITE_BREAK_CONDITION_MUST_BREAK = 3,
}

struct DWRITE_LINE_BREAKPOINT
{
    ubyte _bitfield;
}

enum DWRITE_NUMBER_SUBSTITUTION_METHOD
{
    DWRITE_NUMBER_SUBSTITUTION_METHOD_FROM_CULTURE = 0,
    DWRITE_NUMBER_SUBSTITUTION_METHOD_CONTEXTUAL = 1,
    DWRITE_NUMBER_SUBSTITUTION_METHOD_NONE = 2,
    DWRITE_NUMBER_SUBSTITUTION_METHOD_NATIONAL = 3,
    DWRITE_NUMBER_SUBSTITUTION_METHOD_TRADITIONAL = 4,
}

const GUID IID_IDWriteNumberSubstitution = {0x14885CC9, 0xBAB0, 0x4F90, [0xB6, 0xED, 0x5C, 0x36, 0x6A, 0x2C, 0xD0, 0x3D]};
@GUID(0x14885CC9, 0xBAB0, 0x4F90, [0xB6, 0xED, 0x5C, 0x36, 0x6A, 0x2C, 0xD0, 0x3D]);
interface IDWriteNumberSubstitution : IUnknown
{
}

struct DWRITE_SHAPING_TEXT_PROPERTIES
{
    ushort _bitfield;
}

struct DWRITE_SHAPING_GLYPH_PROPERTIES
{
    ushort _bitfield;
}

const GUID IID_IDWriteTextAnalysisSource = {0x688E1A58, 0x5094, 0x47C8, [0xAD, 0xC8, 0xFB, 0xCE, 0xA6, 0x0A, 0xE9, 0x2B]};
@GUID(0x688E1A58, 0x5094, 0x47C8, [0xAD, 0xC8, 0xFB, 0xCE, 0xA6, 0x0A, 0xE9, 0x2B]);
interface IDWriteTextAnalysisSource : IUnknown
{
    HRESULT GetTextAtPosition(uint textPosition, const(ushort)** textString, uint* textLength);
    HRESULT GetTextBeforePosition(uint textPosition, const(ushort)** textString, uint* textLength);
    DWRITE_READING_DIRECTION GetParagraphReadingDirection();
    HRESULT GetLocaleName(uint textPosition, uint* textLength, const(ushort)** localeName);
    HRESULT GetNumberSubstitution(uint textPosition, uint* textLength, IDWriteNumberSubstitution* numberSubstitution);
}

const GUID IID_IDWriteTextAnalysisSink = {0x5810CD44, 0x0CA0, 0x4701, [0xB3, 0xFA, 0xBE, 0xC5, 0x18, 0x2A, 0xE4, 0xF6]};
@GUID(0x5810CD44, 0x0CA0, 0x4701, [0xB3, 0xFA, 0xBE, 0xC5, 0x18, 0x2A, 0xE4, 0xF6]);
interface IDWriteTextAnalysisSink : IUnknown
{
    HRESULT SetScriptAnalysis(uint textPosition, uint textLength, const(DWRITE_SCRIPT_ANALYSIS)* scriptAnalysis);
    HRESULT SetLineBreakpoints(uint textPosition, uint textLength, char* lineBreakpoints);
    HRESULT SetBidiLevel(uint textPosition, uint textLength, ubyte explicitLevel, ubyte resolvedLevel);
    HRESULT SetNumberSubstitution(uint textPosition, uint textLength, IDWriteNumberSubstitution numberSubstitution);
}

const GUID IID_IDWriteTextAnalyzer = {0xB7E6163E, 0x7F46, 0x43B4, [0x84, 0xB3, 0xE4, 0xE6, 0x24, 0x9C, 0x36, 0x5D]};
@GUID(0xB7E6163E, 0x7F46, 0x43B4, [0x84, 0xB3, 0xE4, 0xE6, 0x24, 0x9C, 0x36, 0x5D]);
interface IDWriteTextAnalyzer : IUnknown
{
    HRESULT AnalyzeScript(IDWriteTextAnalysisSource analysisSource, uint textPosition, uint textLength, IDWriteTextAnalysisSink analysisSink);
    HRESULT AnalyzeBidi(IDWriteTextAnalysisSource analysisSource, uint textPosition, uint textLength, IDWriteTextAnalysisSink analysisSink);
    HRESULT AnalyzeNumberSubstitution(IDWriteTextAnalysisSource analysisSource, uint textPosition, uint textLength, IDWriteTextAnalysisSink analysisSink);
    HRESULT AnalyzeLineBreakpoints(IDWriteTextAnalysisSource analysisSource, uint textPosition, uint textLength, IDWriteTextAnalysisSink analysisSink);
    HRESULT GetGlyphs(const(wchar)* textString, uint textLength, IDWriteFontFace fontFace, BOOL isSideways, BOOL isRightToLeft, const(DWRITE_SCRIPT_ANALYSIS)* scriptAnalysis, const(wchar)* localeName, IDWriteNumberSubstitution numberSubstitution, char* features, char* featureRangeLengths, uint featureRanges, uint maxGlyphCount, char* clusterMap, char* textProps, char* glyphIndices, char* glyphProps, uint* actualGlyphCount);
    HRESULT GetGlyphPlacements(const(wchar)* textString, char* clusterMap, char* textProps, uint textLength, char* glyphIndices, char* glyphProps, uint glyphCount, IDWriteFontFace fontFace, float fontEmSize, BOOL isSideways, BOOL isRightToLeft, const(DWRITE_SCRIPT_ANALYSIS)* scriptAnalysis, const(wchar)* localeName, char* features, char* featureRangeLengths, uint featureRanges, char* glyphAdvances, char* glyphOffsets);
    HRESULT GetGdiCompatibleGlyphPlacements(const(wchar)* textString, char* clusterMap, char* textProps, uint textLength, char* glyphIndices, char* glyphProps, uint glyphCount, IDWriteFontFace fontFace, float fontEmSize, float pixelsPerDip, const(DWRITE_MATRIX)* transform, BOOL useGdiNatural, BOOL isSideways, BOOL isRightToLeft, const(DWRITE_SCRIPT_ANALYSIS)* scriptAnalysis, const(wchar)* localeName, char* features, char* featureRangeLengths, uint featureRanges, char* glyphAdvances, char* glyphOffsets);
}

struct DWRITE_GLYPH_RUN
{
    IDWriteFontFace fontFace;
    float fontEmSize;
    uint glyphCount;
    const(ushort)* glyphIndices;
    const(float)* glyphAdvances;
    const(DWRITE_GLYPH_OFFSET)* glyphOffsets;
    BOOL isSideways;
    uint bidiLevel;
}

struct DWRITE_GLYPH_RUN_DESCRIPTION
{
    const(wchar)* localeName;
    const(wchar)* string;
    uint stringLength;
    const(ushort)* clusterMap;
    uint textPosition;
}

struct DWRITE_UNDERLINE
{
    float width;
    float thickness;
    float offset;
    float runHeight;
    DWRITE_READING_DIRECTION readingDirection;
    DWRITE_FLOW_DIRECTION flowDirection;
    const(wchar)* localeName;
    DWRITE_MEASURING_MODE measuringMode;
}

struct DWRITE_STRIKETHROUGH
{
    float width;
    float thickness;
    float offset;
    DWRITE_READING_DIRECTION readingDirection;
    DWRITE_FLOW_DIRECTION flowDirection;
    const(wchar)* localeName;
    DWRITE_MEASURING_MODE measuringMode;
}

struct DWRITE_LINE_METRICS
{
    uint length;
    uint trailingWhitespaceLength;
    uint newlineLength;
    float height;
    float baseline;
    BOOL isTrimmed;
}

struct DWRITE_CLUSTER_METRICS
{
    float width;
    ushort length;
    ushort _bitfield;
}

struct DWRITE_TEXT_METRICS
{
    float left;
    float top;
    float width;
    float widthIncludingTrailingWhitespace;
    float height;
    float layoutWidth;
    float layoutHeight;
    uint maxBidiReorderingDepth;
    uint lineCount;
}

struct DWRITE_INLINE_OBJECT_METRICS
{
    float width;
    float height;
    float baseline;
    BOOL supportsSideways;
}

struct DWRITE_OVERHANG_METRICS
{
    float left;
    float top;
    float right;
    float bottom;
}

struct DWRITE_HIT_TEST_METRICS
{
    uint textPosition;
    uint length;
    float left;
    float top;
    float width;
    float height;
    uint bidiLevel;
    BOOL isText;
    BOOL isTrimmed;
}

const GUID IID_IDWriteInlineObject = {0x8339FDE3, 0x106F, 0x47AB, [0x83, 0x73, 0x1C, 0x62, 0x95, 0xEB, 0x10, 0xB3]};
@GUID(0x8339FDE3, 0x106F, 0x47AB, [0x83, 0x73, 0x1C, 0x62, 0x95, 0xEB, 0x10, 0xB3]);
interface IDWriteInlineObject : IUnknown
{
    HRESULT Draw(void* clientDrawingContext, IDWriteTextRenderer renderer, float originX, float originY, BOOL isSideways, BOOL isRightToLeft, IUnknown clientDrawingEffect);
    HRESULT GetMetrics(DWRITE_INLINE_OBJECT_METRICS* metrics);
    HRESULT GetOverhangMetrics(DWRITE_OVERHANG_METRICS* overhangs);
    HRESULT GetBreakConditions(DWRITE_BREAK_CONDITION* breakConditionBefore, DWRITE_BREAK_CONDITION* breakConditionAfter);
}

const GUID IID_IDWritePixelSnapping = {0xEAF3A2DA, 0xECF4, 0x4D24, [0xB6, 0x44, 0xB3, 0x4F, 0x68, 0x42, 0x02, 0x4B]};
@GUID(0xEAF3A2DA, 0xECF4, 0x4D24, [0xB6, 0x44, 0xB3, 0x4F, 0x68, 0x42, 0x02, 0x4B]);
interface IDWritePixelSnapping : IUnknown
{
    HRESULT IsPixelSnappingDisabled(void* clientDrawingContext, int* isDisabled);
    HRESULT GetCurrentTransform(void* clientDrawingContext, DWRITE_MATRIX* transform);
    HRESULT GetPixelsPerDip(void* clientDrawingContext, float* pixelsPerDip);
}

const GUID IID_IDWriteTextRenderer = {0xEF8A8135, 0x5CC6, 0x45FE, [0x88, 0x25, 0xC5, 0xA0, 0x72, 0x4E, 0xB8, 0x19]};
@GUID(0xEF8A8135, 0x5CC6, 0x45FE, [0x88, 0x25, 0xC5, 0xA0, 0x72, 0x4E, 0xB8, 0x19]);
interface IDWriteTextRenderer : IDWritePixelSnapping
{
    HRESULT DrawGlyphRun(void* clientDrawingContext, float baselineOriginX, float baselineOriginY, DWRITE_MEASURING_MODE measuringMode, const(DWRITE_GLYPH_RUN)* glyphRun, const(DWRITE_GLYPH_RUN_DESCRIPTION)* glyphRunDescription, IUnknown clientDrawingEffect);
    HRESULT DrawUnderline(void* clientDrawingContext, float baselineOriginX, float baselineOriginY, const(DWRITE_UNDERLINE)* underline, IUnknown clientDrawingEffect);
    HRESULT DrawStrikethrough(void* clientDrawingContext, float baselineOriginX, float baselineOriginY, const(DWRITE_STRIKETHROUGH)* strikethrough, IUnknown clientDrawingEffect);
    HRESULT DrawInlineObject(void* clientDrawingContext, float originX, float originY, IDWriteInlineObject inlineObject, BOOL isSideways, BOOL isRightToLeft, IUnknown clientDrawingEffect);
}

const GUID IID_IDWriteTextLayout = {0x53737037, 0x6D14, 0x410B, [0x9B, 0xFE, 0x0B, 0x18, 0x2B, 0xB7, 0x09, 0x61]};
@GUID(0x53737037, 0x6D14, 0x410B, [0x9B, 0xFE, 0x0B, 0x18, 0x2B, 0xB7, 0x09, 0x61]);
interface IDWriteTextLayout : IDWriteTextFormat
{
    HRESULT SetMaxWidth(float maxWidth);
    HRESULT SetMaxHeight(float maxHeight);
    HRESULT SetFontCollection(IDWriteFontCollection fontCollection, DWRITE_TEXT_RANGE textRange);
    HRESULT SetFontFamilyName(const(wchar)* fontFamilyName, DWRITE_TEXT_RANGE textRange);
    HRESULT SetFontWeight(DWRITE_FONT_WEIGHT fontWeight, DWRITE_TEXT_RANGE textRange);
    HRESULT SetFontStyle(DWRITE_FONT_STYLE fontStyle, DWRITE_TEXT_RANGE textRange);
    HRESULT SetFontStretch(DWRITE_FONT_STRETCH fontStretch, DWRITE_TEXT_RANGE textRange);
    HRESULT SetFontSize(float fontSize, DWRITE_TEXT_RANGE textRange);
    HRESULT SetUnderline(BOOL hasUnderline, DWRITE_TEXT_RANGE textRange);
    HRESULT SetStrikethrough(BOOL hasStrikethrough, DWRITE_TEXT_RANGE textRange);
    HRESULT SetDrawingEffect(IUnknown drawingEffect, DWRITE_TEXT_RANGE textRange);
    HRESULT SetInlineObject(IDWriteInlineObject inlineObject, DWRITE_TEXT_RANGE textRange);
    HRESULT SetTypography(IDWriteTypography typography, DWRITE_TEXT_RANGE textRange);
    HRESULT SetLocaleName(const(wchar)* localeName, DWRITE_TEXT_RANGE textRange);
    float GetMaxWidth();
    float GetMaxHeight();
    HRESULT GetFontCollection(uint currentPosition, IDWriteFontCollection* fontCollection, DWRITE_TEXT_RANGE* textRange);
    HRESULT GetFontFamilyNameLength(uint currentPosition, uint* nameLength, DWRITE_TEXT_RANGE* textRange);
    HRESULT GetFontFamilyName(uint currentPosition, char* fontFamilyName, uint nameSize, DWRITE_TEXT_RANGE* textRange);
    HRESULT GetFontWeight(uint currentPosition, DWRITE_FONT_WEIGHT* fontWeight, DWRITE_TEXT_RANGE* textRange);
    HRESULT GetFontStyle(uint currentPosition, DWRITE_FONT_STYLE* fontStyle, DWRITE_TEXT_RANGE* textRange);
    HRESULT GetFontStretch(uint currentPosition, DWRITE_FONT_STRETCH* fontStretch, DWRITE_TEXT_RANGE* textRange);
    HRESULT GetFontSize(uint currentPosition, float* fontSize, DWRITE_TEXT_RANGE* textRange);
    HRESULT GetUnderline(uint currentPosition, int* hasUnderline, DWRITE_TEXT_RANGE* textRange);
    HRESULT GetStrikethrough(uint currentPosition, int* hasStrikethrough, DWRITE_TEXT_RANGE* textRange);
    HRESULT GetDrawingEffect(uint currentPosition, IUnknown* drawingEffect, DWRITE_TEXT_RANGE* textRange);
    HRESULT GetInlineObject(uint currentPosition, IDWriteInlineObject* inlineObject, DWRITE_TEXT_RANGE* textRange);
    HRESULT GetTypography(uint currentPosition, IDWriteTypography* typography, DWRITE_TEXT_RANGE* textRange);
    HRESULT GetLocaleNameLength(uint currentPosition, uint* nameLength, DWRITE_TEXT_RANGE* textRange);
    HRESULT GetLocaleName(uint currentPosition, char* localeName, uint nameSize, DWRITE_TEXT_RANGE* textRange);
    HRESULT Draw(void* clientDrawingContext, IDWriteTextRenderer renderer, float originX, float originY);
    HRESULT GetLineMetrics(char* lineMetrics, uint maxLineCount, uint* actualLineCount);
    HRESULT GetMetrics(DWRITE_TEXT_METRICS* textMetrics);
    HRESULT GetOverhangMetrics(DWRITE_OVERHANG_METRICS* overhangs);
    HRESULT GetClusterMetrics(char* clusterMetrics, uint maxClusterCount, uint* actualClusterCount);
    HRESULT DetermineMinWidth(float* minWidth);
    HRESULT HitTestPoint(float pointX, float pointY, int* isTrailingHit, int* isInside, DWRITE_HIT_TEST_METRICS* hitTestMetrics);
    HRESULT HitTestTextPosition(uint textPosition, BOOL isTrailingHit, float* pointX, float* pointY, DWRITE_HIT_TEST_METRICS* hitTestMetrics);
    HRESULT HitTestTextRange(uint textPosition, uint textLength, float originX, float originY, char* hitTestMetrics, uint maxHitTestMetricsCount, uint* actualHitTestMetricsCount);
}

const GUID IID_IDWriteBitmapRenderTarget = {0x5E5A32A3, 0x8DFF, 0x4773, [0x9F, 0xF6, 0x06, 0x96, 0xEA, 0xB7, 0x72, 0x67]};
@GUID(0x5E5A32A3, 0x8DFF, 0x4773, [0x9F, 0xF6, 0x06, 0x96, 0xEA, 0xB7, 0x72, 0x67]);
interface IDWriteBitmapRenderTarget : IUnknown
{
    HRESULT DrawGlyphRun(float baselineOriginX, float baselineOriginY, DWRITE_MEASURING_MODE measuringMode, const(DWRITE_GLYPH_RUN)* glyphRun, IDWriteRenderingParams renderingParams, uint textColor, RECT* blackBoxRect);
    HDC GetMemoryDC();
    float GetPixelsPerDip();
    HRESULT SetPixelsPerDip(float pixelsPerDip);
    HRESULT GetCurrentTransform(DWRITE_MATRIX* transform);
    HRESULT SetCurrentTransform(const(DWRITE_MATRIX)* transform);
    HRESULT GetSize(SIZE* size);
    HRESULT Resize(uint width, uint height);
}

const GUID IID_IDWriteGdiInterop = {0x1EDD9491, 0x9853, 0x4299, [0x89, 0x8F, 0x64, 0x32, 0x98, 0x3B, 0x6F, 0x3A]};
@GUID(0x1EDD9491, 0x9853, 0x4299, [0x89, 0x8F, 0x64, 0x32, 0x98, 0x3B, 0x6F, 0x3A]);
interface IDWriteGdiInterop : IUnknown
{
    HRESULT CreateFontFromLOGFONT(const(LOGFONTW)* logFont, IDWriteFont* font);
    HRESULT ConvertFontToLOGFONT(IDWriteFont font, LOGFONTW* logFont, int* isSystemFont);
    HRESULT ConvertFontFaceToLOGFONT(IDWriteFontFace font, LOGFONTW* logFont);
    HRESULT CreateFontFaceFromHdc(HDC hdc, IDWriteFontFace* fontFace);
    HRESULT CreateBitmapRenderTarget(HDC hdc, uint width, uint height, IDWriteBitmapRenderTarget* renderTarget);
}

enum DWRITE_TEXTURE_TYPE
{
    DWRITE_TEXTURE_ALIASED_1x1 = 0,
    DWRITE_TEXTURE_CLEARTYPE_3x1 = 1,
}

const GUID IID_IDWriteGlyphRunAnalysis = {0x7D97DBF7, 0xE085, 0x42D4, [0x81, 0xE3, 0x6A, 0x88, 0x3B, 0xDE, 0xD1, 0x18]};
@GUID(0x7D97DBF7, 0xE085, 0x42D4, [0x81, 0xE3, 0x6A, 0x88, 0x3B, 0xDE, 0xD1, 0x18]);
interface IDWriteGlyphRunAnalysis : IUnknown
{
    HRESULT GetAlphaTextureBounds(DWRITE_TEXTURE_TYPE textureType, RECT* textureBounds);
    HRESULT CreateAlphaTexture(DWRITE_TEXTURE_TYPE textureType, const(RECT)* textureBounds, char* alphaValues, uint bufferSize);
    HRESULT GetAlphaBlendParams(IDWriteRenderingParams renderingParams, float* blendGamma, float* blendEnhancedContrast, float* blendClearTypeLevel);
}

const GUID IID_IDWriteFactory = {0xB859EE5A, 0xD838, 0x4B5B, [0xA2, 0xE8, 0x1A, 0xDC, 0x7D, 0x93, 0xDB, 0x48]};
@GUID(0xB859EE5A, 0xD838, 0x4B5B, [0xA2, 0xE8, 0x1A, 0xDC, 0x7D, 0x93, 0xDB, 0x48]);
interface IDWriteFactory : IUnknown
{
    HRESULT GetSystemFontCollection(IDWriteFontCollection* fontCollection, BOOL checkForUpdates);
    HRESULT CreateCustomFontCollection(IDWriteFontCollectionLoader collectionLoader, char* collectionKey, uint collectionKeySize, IDWriteFontCollection* fontCollection);
    HRESULT RegisterFontCollectionLoader(IDWriteFontCollectionLoader fontCollectionLoader);
    HRESULT UnregisterFontCollectionLoader(IDWriteFontCollectionLoader fontCollectionLoader);
    HRESULT CreateFontFileReference(const(wchar)* filePath, const(FILETIME)* lastWriteTime, IDWriteFontFile* fontFile);
    HRESULT CreateCustomFontFileReference(char* fontFileReferenceKey, uint fontFileReferenceKeySize, IDWriteFontFileLoader fontFileLoader, IDWriteFontFile* fontFile);
    HRESULT CreateFontFace(DWRITE_FONT_FACE_TYPE fontFaceType, uint numberOfFiles, char* fontFiles, uint faceIndex, DWRITE_FONT_SIMULATIONS fontFaceSimulationFlags, IDWriteFontFace* fontFace);
    HRESULT CreateRenderingParams(IDWriteRenderingParams* renderingParams);
    HRESULT CreateMonitorRenderingParams(int monitor, IDWriteRenderingParams* renderingParams);
    HRESULT CreateCustomRenderingParams(float gamma, float enhancedContrast, float clearTypeLevel, DWRITE_PIXEL_GEOMETRY pixelGeometry, DWRITE_RENDERING_MODE renderingMode, IDWriteRenderingParams* renderingParams);
    HRESULT RegisterFontFileLoader(IDWriteFontFileLoader fontFileLoader);
    HRESULT UnregisterFontFileLoader(IDWriteFontFileLoader fontFileLoader);
    HRESULT CreateTextFormat(const(wchar)* fontFamilyName, IDWriteFontCollection fontCollection, DWRITE_FONT_WEIGHT fontWeight, DWRITE_FONT_STYLE fontStyle, DWRITE_FONT_STRETCH fontStretch, float fontSize, const(wchar)* localeName, IDWriteTextFormat* textFormat);
    HRESULT CreateTypography(IDWriteTypography* typography);
    HRESULT GetGdiInterop(IDWriteGdiInterop* gdiInterop);
    HRESULT CreateTextLayout(const(wchar)* string, uint stringLength, IDWriteTextFormat textFormat, float maxWidth, float maxHeight, IDWriteTextLayout* textLayout);
    HRESULT CreateGdiCompatibleTextLayout(const(wchar)* string, uint stringLength, IDWriteTextFormat textFormat, float layoutWidth, float layoutHeight, float pixelsPerDip, const(DWRITE_MATRIX)* transform, BOOL useGdiNatural, IDWriteTextLayout* textLayout);
    HRESULT CreateEllipsisTrimmingSign(IDWriteTextFormat textFormat, IDWriteInlineObject* trimmingSign);
    HRESULT CreateTextAnalyzer(IDWriteTextAnalyzer* textAnalyzer);
    HRESULT CreateNumberSubstitution(DWRITE_NUMBER_SUBSTITUTION_METHOD substitutionMethod, const(wchar)* localeName, BOOL ignoreUserOverride, IDWriteNumberSubstitution* numberSubstitution);
    HRESULT CreateGlyphRunAnalysis(const(DWRITE_GLYPH_RUN)* glyphRun, float pixelsPerDip, const(DWRITE_MATRIX)* transform, DWRITE_RENDERING_MODE renderingMode, DWRITE_MEASURING_MODE measuringMode, float baselineOriginX, float baselineOriginY, IDWriteGlyphRunAnalysis* glyphRunAnalysis);
}

enum DWRITE_PANOSE_FAMILY
{
    DWRITE_PANOSE_FAMILY_ANY = 0,
    DWRITE_PANOSE_FAMILY_NO_FIT = 1,
    DWRITE_PANOSE_FAMILY_TEXT_DISPLAY = 2,
    DWRITE_PANOSE_FAMILY_SCRIPT = 3,
    DWRITE_PANOSE_FAMILY_DECORATIVE = 4,
    DWRITE_PANOSE_FAMILY_SYMBOL = 5,
    DWRITE_PANOSE_FAMILY_PICTORIAL = 5,
}

enum DWRITE_PANOSE_SERIF_STYLE
{
    DWRITE_PANOSE_SERIF_STYLE_ANY = 0,
    DWRITE_PANOSE_SERIF_STYLE_NO_FIT = 1,
    DWRITE_PANOSE_SERIF_STYLE_COVE = 2,
    DWRITE_PANOSE_SERIF_STYLE_OBTUSE_COVE = 3,
    DWRITE_PANOSE_SERIF_STYLE_SQUARE_COVE = 4,
    DWRITE_PANOSE_SERIF_STYLE_OBTUSE_SQUARE_COVE = 5,
    DWRITE_PANOSE_SERIF_STYLE_SQUARE = 6,
    DWRITE_PANOSE_SERIF_STYLE_THIN = 7,
    DWRITE_PANOSE_SERIF_STYLE_OVAL = 8,
    DWRITE_PANOSE_SERIF_STYLE_EXAGGERATED = 9,
    DWRITE_PANOSE_SERIF_STYLE_TRIANGLE = 10,
    DWRITE_PANOSE_SERIF_STYLE_NORMAL_SANS = 11,
    DWRITE_PANOSE_SERIF_STYLE_OBTUSE_SANS = 12,
    DWRITE_PANOSE_SERIF_STYLE_PERPENDICULAR_SANS = 13,
    DWRITE_PANOSE_SERIF_STYLE_FLARED = 14,
    DWRITE_PANOSE_SERIF_STYLE_ROUNDED = 15,
    DWRITE_PANOSE_SERIF_STYLE_SCRIPT = 16,
    DWRITE_PANOSE_SERIF_STYLE_PERP_SANS = 13,
    DWRITE_PANOSE_SERIF_STYLE_BONE = 8,
}

enum DWRITE_PANOSE_WEIGHT
{
    DWRITE_PANOSE_WEIGHT_ANY = 0,
    DWRITE_PANOSE_WEIGHT_NO_FIT = 1,
    DWRITE_PANOSE_WEIGHT_VERY_LIGHT = 2,
    DWRITE_PANOSE_WEIGHT_LIGHT = 3,
    DWRITE_PANOSE_WEIGHT_THIN = 4,
    DWRITE_PANOSE_WEIGHT_BOOK = 5,
    DWRITE_PANOSE_WEIGHT_MEDIUM = 6,
    DWRITE_PANOSE_WEIGHT_DEMI = 7,
    DWRITE_PANOSE_WEIGHT_BOLD = 8,
    DWRITE_PANOSE_WEIGHT_HEAVY = 9,
    DWRITE_PANOSE_WEIGHT_BLACK = 10,
    DWRITE_PANOSE_WEIGHT_EXTRA_BLACK = 11,
    DWRITE_PANOSE_WEIGHT_NORD = 11,
}

enum DWRITE_PANOSE_PROPORTION
{
    DWRITE_PANOSE_PROPORTION_ANY = 0,
    DWRITE_PANOSE_PROPORTION_NO_FIT = 1,
    DWRITE_PANOSE_PROPORTION_OLD_STYLE = 2,
    DWRITE_PANOSE_PROPORTION_MODERN = 3,
    DWRITE_PANOSE_PROPORTION_EVEN_WIDTH = 4,
    DWRITE_PANOSE_PROPORTION_EXPANDED = 5,
    DWRITE_PANOSE_PROPORTION_CONDENSED = 6,
    DWRITE_PANOSE_PROPORTION_VERY_EXPANDED = 7,
    DWRITE_PANOSE_PROPORTION_VERY_CONDENSED = 8,
    DWRITE_PANOSE_PROPORTION_MONOSPACED = 9,
}

enum DWRITE_PANOSE_CONTRAST
{
    DWRITE_PANOSE_CONTRAST_ANY = 0,
    DWRITE_PANOSE_CONTRAST_NO_FIT = 1,
    DWRITE_PANOSE_CONTRAST_NONE = 2,
    DWRITE_PANOSE_CONTRAST_VERY_LOW = 3,
    DWRITE_PANOSE_CONTRAST_LOW = 4,
    DWRITE_PANOSE_CONTRAST_MEDIUM_LOW = 5,
    DWRITE_PANOSE_CONTRAST_MEDIUM = 6,
    DWRITE_PANOSE_CONTRAST_MEDIUM_HIGH = 7,
    DWRITE_PANOSE_CONTRAST_HIGH = 8,
    DWRITE_PANOSE_CONTRAST_VERY_HIGH = 9,
    DWRITE_PANOSE_CONTRAST_HORIZONTAL_LOW = 10,
    DWRITE_PANOSE_CONTRAST_HORIZONTAL_MEDIUM = 11,
    DWRITE_PANOSE_CONTRAST_HORIZONTAL_HIGH = 12,
    DWRITE_PANOSE_CONTRAST_BROKEN = 13,
}

enum DWRITE_PANOSE_STROKE_VARIATION
{
    DWRITE_PANOSE_STROKE_VARIATION_ANY = 0,
    DWRITE_PANOSE_STROKE_VARIATION_NO_FIT = 1,
    DWRITE_PANOSE_STROKE_VARIATION_NO_VARIATION = 2,
    DWRITE_PANOSE_STROKE_VARIATION_GRADUAL_DIAGONAL = 3,
    DWRITE_PANOSE_STROKE_VARIATION_GRADUAL_TRANSITIONAL = 4,
    DWRITE_PANOSE_STROKE_VARIATION_GRADUAL_VERTICAL = 5,
    DWRITE_PANOSE_STROKE_VARIATION_GRADUAL_HORIZONTAL = 6,
    DWRITE_PANOSE_STROKE_VARIATION_RAPID_VERTICAL = 7,
    DWRITE_PANOSE_STROKE_VARIATION_RAPID_HORIZONTAL = 8,
    DWRITE_PANOSE_STROKE_VARIATION_INSTANT_VERTICAL = 9,
    DWRITE_PANOSE_STROKE_VARIATION_INSTANT_HORIZONTAL = 10,
}

enum DWRITE_PANOSE_ARM_STYLE
{
    DWRITE_PANOSE_ARM_STYLE_ANY = 0,
    DWRITE_PANOSE_ARM_STYLE_NO_FIT = 1,
    DWRITE_PANOSE_ARM_STYLE_STRAIGHT_ARMS_HORIZONTAL = 2,
    DWRITE_PANOSE_ARM_STYLE_STRAIGHT_ARMS_WEDGE = 3,
    DWRITE_PANOSE_ARM_STYLE_STRAIGHT_ARMS_VERTICAL = 4,
    DWRITE_PANOSE_ARM_STYLE_STRAIGHT_ARMS_SINGLE_SERIF = 5,
    DWRITE_PANOSE_ARM_STYLE_STRAIGHT_ARMS_DOUBLE_SERIF = 6,
    DWRITE_PANOSE_ARM_STYLE_NONSTRAIGHT_ARMS_HORIZONTAL = 7,
    DWRITE_PANOSE_ARM_STYLE_NONSTRAIGHT_ARMS_WEDGE = 8,
    DWRITE_PANOSE_ARM_STYLE_NONSTRAIGHT_ARMS_VERTICAL = 9,
    DWRITE_PANOSE_ARM_STYLE_NONSTRAIGHT_ARMS_SINGLE_SERIF = 10,
    DWRITE_PANOSE_ARM_STYLE_NONSTRAIGHT_ARMS_DOUBLE_SERIF = 11,
    DWRITE_PANOSE_ARM_STYLE_STRAIGHT_ARMS_HORZ = 2,
    DWRITE_PANOSE_ARM_STYLE_STRAIGHT_ARMS_VERT = 4,
    DWRITE_PANOSE_ARM_STYLE_BENT_ARMS_HORZ = 7,
    DWRITE_PANOSE_ARM_STYLE_BENT_ARMS_WEDGE = 8,
    DWRITE_PANOSE_ARM_STYLE_BENT_ARMS_VERT = 9,
    DWRITE_PANOSE_ARM_STYLE_BENT_ARMS_SINGLE_SERIF = 10,
    DWRITE_PANOSE_ARM_STYLE_BENT_ARMS_DOUBLE_SERIF = 11,
}

enum DWRITE_PANOSE_LETTERFORM
{
    DWRITE_PANOSE_LETTERFORM_ANY = 0,
    DWRITE_PANOSE_LETTERFORM_NO_FIT = 1,
    DWRITE_PANOSE_LETTERFORM_NORMAL_CONTACT = 2,
    DWRITE_PANOSE_LETTERFORM_NORMAL_WEIGHTED = 3,
    DWRITE_PANOSE_LETTERFORM_NORMAL_BOXED = 4,
    DWRITE_PANOSE_LETTERFORM_NORMAL_FLATTENED = 5,
    DWRITE_PANOSE_LETTERFORM_NORMAL_ROUNDED = 6,
    DWRITE_PANOSE_LETTERFORM_NORMAL_OFF_CENTER = 7,
    DWRITE_PANOSE_LETTERFORM_NORMAL_SQUARE = 8,
    DWRITE_PANOSE_LETTERFORM_OBLIQUE_CONTACT = 9,
    DWRITE_PANOSE_LETTERFORM_OBLIQUE_WEIGHTED = 10,
    DWRITE_PANOSE_LETTERFORM_OBLIQUE_BOXED = 11,
    DWRITE_PANOSE_LETTERFORM_OBLIQUE_FLATTENED = 12,
    DWRITE_PANOSE_LETTERFORM_OBLIQUE_ROUNDED = 13,
    DWRITE_PANOSE_LETTERFORM_OBLIQUE_OFF_CENTER = 14,
    DWRITE_PANOSE_LETTERFORM_OBLIQUE_SQUARE = 15,
}

enum DWRITE_PANOSE_MIDLINE
{
    DWRITE_PANOSE_MIDLINE_ANY = 0,
    DWRITE_PANOSE_MIDLINE_NO_FIT = 1,
    DWRITE_PANOSE_MIDLINE_STANDARD_TRIMMED = 2,
    DWRITE_PANOSE_MIDLINE_STANDARD_POINTED = 3,
    DWRITE_PANOSE_MIDLINE_STANDARD_SERIFED = 4,
    DWRITE_PANOSE_MIDLINE_HIGH_TRIMMED = 5,
    DWRITE_PANOSE_MIDLINE_HIGH_POINTED = 6,
    DWRITE_PANOSE_MIDLINE_HIGH_SERIFED = 7,
    DWRITE_PANOSE_MIDLINE_CONSTANT_TRIMMED = 8,
    DWRITE_PANOSE_MIDLINE_CONSTANT_POINTED = 9,
    DWRITE_PANOSE_MIDLINE_CONSTANT_SERIFED = 10,
    DWRITE_PANOSE_MIDLINE_LOW_TRIMMED = 11,
    DWRITE_PANOSE_MIDLINE_LOW_POINTED = 12,
    DWRITE_PANOSE_MIDLINE_LOW_SERIFED = 13,
}

enum DWRITE_PANOSE_XHEIGHT
{
    DWRITE_PANOSE_XHEIGHT_ANY = 0,
    DWRITE_PANOSE_XHEIGHT_NO_FIT = 1,
    DWRITE_PANOSE_XHEIGHT_CONSTANT_SMALL = 2,
    DWRITE_PANOSE_XHEIGHT_CONSTANT_STANDARD = 3,
    DWRITE_PANOSE_XHEIGHT_CONSTANT_LARGE = 4,
    DWRITE_PANOSE_XHEIGHT_DUCKING_SMALL = 5,
    DWRITE_PANOSE_XHEIGHT_DUCKING_STANDARD = 6,
    DWRITE_PANOSE_XHEIGHT_DUCKING_LARGE = 7,
    DWRITE_PANOSE_XHEIGHT_CONSTANT_STD = 3,
    DWRITE_PANOSE_XHEIGHT_DUCKING_STD = 6,
}

enum DWRITE_PANOSE_TOOL_KIND
{
    DWRITE_PANOSE_TOOL_KIND_ANY = 0,
    DWRITE_PANOSE_TOOL_KIND_NO_FIT = 1,
    DWRITE_PANOSE_TOOL_KIND_FLAT_NIB = 2,
    DWRITE_PANOSE_TOOL_KIND_PRESSURE_POINT = 3,
    DWRITE_PANOSE_TOOL_KIND_ENGRAVED = 4,
    DWRITE_PANOSE_TOOL_KIND_BALL = 5,
    DWRITE_PANOSE_TOOL_KIND_BRUSH = 6,
    DWRITE_PANOSE_TOOL_KIND_ROUGH = 7,
    DWRITE_PANOSE_TOOL_KIND_FELT_PEN_BRUSH_TIP = 8,
    DWRITE_PANOSE_TOOL_KIND_WILD_BRUSH = 9,
}

enum DWRITE_PANOSE_SPACING
{
    DWRITE_PANOSE_SPACING_ANY = 0,
    DWRITE_PANOSE_SPACING_NO_FIT = 1,
    DWRITE_PANOSE_SPACING_PROPORTIONAL_SPACED = 2,
    DWRITE_PANOSE_SPACING_MONOSPACED = 3,
}

enum DWRITE_PANOSE_ASPECT_RATIO
{
    DWRITE_PANOSE_ASPECT_RATIO_ANY = 0,
    DWRITE_PANOSE_ASPECT_RATIO_NO_FIT = 1,
    DWRITE_PANOSE_ASPECT_RATIO_VERY_CONDENSED = 2,
    DWRITE_PANOSE_ASPECT_RATIO_CONDENSED = 3,
    DWRITE_PANOSE_ASPECT_RATIO_NORMAL = 4,
    DWRITE_PANOSE_ASPECT_RATIO_EXPANDED = 5,
    DWRITE_PANOSE_ASPECT_RATIO_VERY_EXPANDED = 6,
}

enum DWRITE_PANOSE_SCRIPT_TOPOLOGY
{
    DWRITE_PANOSE_SCRIPT_TOPOLOGY_ANY = 0,
    DWRITE_PANOSE_SCRIPT_TOPOLOGY_NO_FIT = 1,
    DWRITE_PANOSE_SCRIPT_TOPOLOGY_ROMAN_DISCONNECTED = 2,
    DWRITE_PANOSE_SCRIPT_TOPOLOGY_ROMAN_TRAILING = 3,
    DWRITE_PANOSE_SCRIPT_TOPOLOGY_ROMAN_CONNECTED = 4,
    DWRITE_PANOSE_SCRIPT_TOPOLOGY_CURSIVE_DISCONNECTED = 5,
    DWRITE_PANOSE_SCRIPT_TOPOLOGY_CURSIVE_TRAILING = 6,
    DWRITE_PANOSE_SCRIPT_TOPOLOGY_CURSIVE_CONNECTED = 7,
    DWRITE_PANOSE_SCRIPT_TOPOLOGY_BLACKLETTER_DISCONNECTED = 8,
    DWRITE_PANOSE_SCRIPT_TOPOLOGY_BLACKLETTER_TRAILING = 9,
    DWRITE_PANOSE_SCRIPT_TOPOLOGY_BLACKLETTER_CONNECTED = 10,
}

enum DWRITE_PANOSE_SCRIPT_FORM
{
    DWRITE_PANOSE_SCRIPT_FORM_ANY = 0,
    DWRITE_PANOSE_SCRIPT_FORM_NO_FIT = 1,
    DWRITE_PANOSE_SCRIPT_FORM_UPRIGHT_NO_WRAPPING = 2,
    DWRITE_PANOSE_SCRIPT_FORM_UPRIGHT_SOME_WRAPPING = 3,
    DWRITE_PANOSE_SCRIPT_FORM_UPRIGHT_MORE_WRAPPING = 4,
    DWRITE_PANOSE_SCRIPT_FORM_UPRIGHT_EXTREME_WRAPPING = 5,
    DWRITE_PANOSE_SCRIPT_FORM_OBLIQUE_NO_WRAPPING = 6,
    DWRITE_PANOSE_SCRIPT_FORM_OBLIQUE_SOME_WRAPPING = 7,
    DWRITE_PANOSE_SCRIPT_FORM_OBLIQUE_MORE_WRAPPING = 8,
    DWRITE_PANOSE_SCRIPT_FORM_OBLIQUE_EXTREME_WRAPPING = 9,
    DWRITE_PANOSE_SCRIPT_FORM_EXAGGERATED_NO_WRAPPING = 10,
    DWRITE_PANOSE_SCRIPT_FORM_EXAGGERATED_SOME_WRAPPING = 11,
    DWRITE_PANOSE_SCRIPT_FORM_EXAGGERATED_MORE_WRAPPING = 12,
    DWRITE_PANOSE_SCRIPT_FORM_EXAGGERATED_EXTREME_WRAPPING = 13,
}

enum DWRITE_PANOSE_FINIALS
{
    DWRITE_PANOSE_FINIALS_ANY = 0,
    DWRITE_PANOSE_FINIALS_NO_FIT = 1,
    DWRITE_PANOSE_FINIALS_NONE_NO_LOOPS = 2,
    DWRITE_PANOSE_FINIALS_NONE_CLOSED_LOOPS = 3,
    DWRITE_PANOSE_FINIALS_NONE_OPEN_LOOPS = 4,
    DWRITE_PANOSE_FINIALS_SHARP_NO_LOOPS = 5,
    DWRITE_PANOSE_FINIALS_SHARP_CLOSED_LOOPS = 6,
    DWRITE_PANOSE_FINIALS_SHARP_OPEN_LOOPS = 7,
    DWRITE_PANOSE_FINIALS_TAPERED_NO_LOOPS = 8,
    DWRITE_PANOSE_FINIALS_TAPERED_CLOSED_LOOPS = 9,
    DWRITE_PANOSE_FINIALS_TAPERED_OPEN_LOOPS = 10,
    DWRITE_PANOSE_FINIALS_ROUND_NO_LOOPS = 11,
    DWRITE_PANOSE_FINIALS_ROUND_CLOSED_LOOPS = 12,
    DWRITE_PANOSE_FINIALS_ROUND_OPEN_LOOPS = 13,
}

enum DWRITE_PANOSE_XASCENT
{
    DWRITE_PANOSE_XASCENT_ANY = 0,
    DWRITE_PANOSE_XASCENT_NO_FIT = 1,
    DWRITE_PANOSE_XASCENT_VERY_LOW = 2,
    DWRITE_PANOSE_XASCENT_LOW = 3,
    DWRITE_PANOSE_XASCENT_MEDIUM = 4,
    DWRITE_PANOSE_XASCENT_HIGH = 5,
    DWRITE_PANOSE_XASCENT_VERY_HIGH = 6,
}

enum DWRITE_PANOSE_DECORATIVE_CLASS
{
    DWRITE_PANOSE_DECORATIVE_CLASS_ANY = 0,
    DWRITE_PANOSE_DECORATIVE_CLASS_NO_FIT = 1,
    DWRITE_PANOSE_DECORATIVE_CLASS_DERIVATIVE = 2,
    DWRITE_PANOSE_DECORATIVE_CLASS_NONSTANDARD_TOPOLOGY = 3,
    DWRITE_PANOSE_DECORATIVE_CLASS_NONSTANDARD_ELEMENTS = 4,
    DWRITE_PANOSE_DECORATIVE_CLASS_NONSTANDARD_ASPECT = 5,
    DWRITE_PANOSE_DECORATIVE_CLASS_INITIALS = 6,
    DWRITE_PANOSE_DECORATIVE_CLASS_CARTOON = 7,
    DWRITE_PANOSE_DECORATIVE_CLASS_PICTURE_STEMS = 8,
    DWRITE_PANOSE_DECORATIVE_CLASS_ORNAMENTED = 9,
    DWRITE_PANOSE_DECORATIVE_CLASS_TEXT_AND_BACKGROUND = 10,
    DWRITE_PANOSE_DECORATIVE_CLASS_COLLAGE = 11,
    DWRITE_PANOSE_DECORATIVE_CLASS_MONTAGE = 12,
}

enum DWRITE_PANOSE_ASPECT
{
    DWRITE_PANOSE_ASPECT_ANY = 0,
    DWRITE_PANOSE_ASPECT_NO_FIT = 1,
    DWRITE_PANOSE_ASPECT_SUPER_CONDENSED = 2,
    DWRITE_PANOSE_ASPECT_VERY_CONDENSED = 3,
    DWRITE_PANOSE_ASPECT_CONDENSED = 4,
    DWRITE_PANOSE_ASPECT_NORMAL = 5,
    DWRITE_PANOSE_ASPECT_EXTENDED = 6,
    DWRITE_PANOSE_ASPECT_VERY_EXTENDED = 7,
    DWRITE_PANOSE_ASPECT_SUPER_EXTENDED = 8,
    DWRITE_PANOSE_ASPECT_MONOSPACED = 9,
}

enum DWRITE_PANOSE_FILL
{
    DWRITE_PANOSE_FILL_ANY = 0,
    DWRITE_PANOSE_FILL_NO_FIT = 1,
    DWRITE_PANOSE_FILL_STANDARD_SOLID_FILL = 2,
    DWRITE_PANOSE_FILL_NO_FILL = 3,
    DWRITE_PANOSE_FILL_PATTERNED_FILL = 4,
    DWRITE_PANOSE_FILL_COMPLEX_FILL = 5,
    DWRITE_PANOSE_FILL_SHAPED_FILL = 6,
    DWRITE_PANOSE_FILL_DRAWN_DISTRESSED = 7,
}

enum DWRITE_PANOSE_LINING
{
    DWRITE_PANOSE_LINING_ANY = 0,
    DWRITE_PANOSE_LINING_NO_FIT = 1,
    DWRITE_PANOSE_LINING_NONE = 2,
    DWRITE_PANOSE_LINING_INLINE = 3,
    DWRITE_PANOSE_LINING_OUTLINE = 4,
    DWRITE_PANOSE_LINING_ENGRAVED = 5,
    DWRITE_PANOSE_LINING_SHADOW = 6,
    DWRITE_PANOSE_LINING_RELIEF = 7,
    DWRITE_PANOSE_LINING_BACKDROP = 8,
}

enum DWRITE_PANOSE_DECORATIVE_TOPOLOGY
{
    DWRITE_PANOSE_DECORATIVE_TOPOLOGY_ANY = 0,
    DWRITE_PANOSE_DECORATIVE_TOPOLOGY_NO_FIT = 1,
    DWRITE_PANOSE_DECORATIVE_TOPOLOGY_STANDARD = 2,
    DWRITE_PANOSE_DECORATIVE_TOPOLOGY_SQUARE = 3,
    DWRITE_PANOSE_DECORATIVE_TOPOLOGY_MULTIPLE_SEGMENT = 4,
    DWRITE_PANOSE_DECORATIVE_TOPOLOGY_ART_DECO = 5,
    DWRITE_PANOSE_DECORATIVE_TOPOLOGY_UNEVEN_WEIGHTING = 6,
    DWRITE_PANOSE_DECORATIVE_TOPOLOGY_DIVERSE_ARMS = 7,
    DWRITE_PANOSE_DECORATIVE_TOPOLOGY_DIVERSE_FORMS = 8,
    DWRITE_PANOSE_DECORATIVE_TOPOLOGY_LOMBARDIC_FORMS = 9,
    DWRITE_PANOSE_DECORATIVE_TOPOLOGY_UPPER_CASE_IN_LOWER_CASE = 10,
    DWRITE_PANOSE_DECORATIVE_TOPOLOGY_IMPLIED_TOPOLOGY = 11,
    DWRITE_PANOSE_DECORATIVE_TOPOLOGY_HORSESHOE_E_AND_A = 12,
    DWRITE_PANOSE_DECORATIVE_TOPOLOGY_CURSIVE = 13,
    DWRITE_PANOSE_DECORATIVE_TOPOLOGY_BLACKLETTER = 14,
    DWRITE_PANOSE_DECORATIVE_TOPOLOGY_SWASH_VARIANCE = 15,
}

enum DWRITE_PANOSE_CHARACTER_RANGES
{
    DWRITE_PANOSE_CHARACTER_RANGES_ANY = 0,
    DWRITE_PANOSE_CHARACTER_RANGES_NO_FIT = 1,
    DWRITE_PANOSE_CHARACTER_RANGES_EXTENDED_COLLECTION = 2,
    DWRITE_PANOSE_CHARACTER_RANGES_LITERALS = 3,
    DWRITE_PANOSE_CHARACTER_RANGES_NO_LOWER_CASE = 4,
    DWRITE_PANOSE_CHARACTER_RANGES_SMALL_CAPS = 5,
}

enum DWRITE_PANOSE_SYMBOL_KIND
{
    DWRITE_PANOSE_SYMBOL_KIND_ANY = 0,
    DWRITE_PANOSE_SYMBOL_KIND_NO_FIT = 1,
    DWRITE_PANOSE_SYMBOL_KIND_MONTAGES = 2,
    DWRITE_PANOSE_SYMBOL_KIND_PICTURES = 3,
    DWRITE_PANOSE_SYMBOL_KIND_SHAPES = 4,
    DWRITE_PANOSE_SYMBOL_KIND_SCIENTIFIC = 5,
    DWRITE_PANOSE_SYMBOL_KIND_MUSIC = 6,
    DWRITE_PANOSE_SYMBOL_KIND_EXPERT = 7,
    DWRITE_PANOSE_SYMBOL_KIND_PATTERNS = 8,
    DWRITE_PANOSE_SYMBOL_KIND_BOARDERS = 9,
    DWRITE_PANOSE_SYMBOL_KIND_ICONS = 10,
    DWRITE_PANOSE_SYMBOL_KIND_LOGOS = 11,
    DWRITE_PANOSE_SYMBOL_KIND_INDUSTRY_SPECIFIC = 12,
}

enum DWRITE_PANOSE_SYMBOL_ASPECT_RATIO
{
    DWRITE_PANOSE_SYMBOL_ASPECT_RATIO_ANY = 0,
    DWRITE_PANOSE_SYMBOL_ASPECT_RATIO_NO_FIT = 1,
    DWRITE_PANOSE_SYMBOL_ASPECT_RATIO_NO_WIDTH = 2,
    DWRITE_PANOSE_SYMBOL_ASPECT_RATIO_EXCEPTIONALLY_WIDE = 3,
    DWRITE_PANOSE_SYMBOL_ASPECT_RATIO_SUPER_WIDE = 4,
    DWRITE_PANOSE_SYMBOL_ASPECT_RATIO_VERY_WIDE = 5,
    DWRITE_PANOSE_SYMBOL_ASPECT_RATIO_WIDE = 6,
    DWRITE_PANOSE_SYMBOL_ASPECT_RATIO_NORMAL = 7,
    DWRITE_PANOSE_SYMBOL_ASPECT_RATIO_NARROW = 8,
    DWRITE_PANOSE_SYMBOL_ASPECT_RATIO_VERY_NARROW = 9,
}

enum DWRITE_OUTLINE_THRESHOLD
{
    DWRITE_OUTLINE_THRESHOLD_ANTIALIASED = 0,
    DWRITE_OUTLINE_THRESHOLD_ALIASED = 1,
}

enum DWRITE_BASELINE
{
    DWRITE_BASELINE_DEFAULT = 0,
    DWRITE_BASELINE_ROMAN = 1,
    DWRITE_BASELINE_CENTRAL = 2,
    DWRITE_BASELINE_MATH = 3,
    DWRITE_BASELINE_HANGING = 4,
    DWRITE_BASELINE_IDEOGRAPHIC_BOTTOM = 5,
    DWRITE_BASELINE_IDEOGRAPHIC_TOP = 6,
    DWRITE_BASELINE_MINIMUM = 7,
    DWRITE_BASELINE_MAXIMUM = 8,
}

enum DWRITE_VERTICAL_GLYPH_ORIENTATION
{
    DWRITE_VERTICAL_GLYPH_ORIENTATION_DEFAULT = 0,
    DWRITE_VERTICAL_GLYPH_ORIENTATION_STACKED = 1,
}

enum DWRITE_GLYPH_ORIENTATION_ANGLE
{
    DWRITE_GLYPH_ORIENTATION_ANGLE_0_DEGREES = 0,
    DWRITE_GLYPH_ORIENTATION_ANGLE_90_DEGREES = 1,
    DWRITE_GLYPH_ORIENTATION_ANGLE_180_DEGREES = 2,
    DWRITE_GLYPH_ORIENTATION_ANGLE_270_DEGREES = 3,
}

struct DWRITE_FONT_METRICS1
{
    DWRITE_FONT_METRICS __AnonymousBase_DWrite_1_L627_C38;
    short glyphBoxLeft;
    short glyphBoxTop;
    short glyphBoxRight;
    short glyphBoxBottom;
    short subscriptPositionX;
    short subscriptPositionY;
    short subscriptSizeX;
    short subscriptSizeY;
    short superscriptPositionX;
    short superscriptPositionY;
    short superscriptSizeX;
    short superscriptSizeY;
    BOOL hasTypographicMetrics;
}

struct DWRITE_CARET_METRICS
{
    short slopeRise;
    short slopeRun;
    short offset;
}

struct DWRITE_PANOSE
{
    ubyte values;
    ubyte familyKind;
    _text_e__Struct text;
    _script_e__Struct script;
    _decorative_e__Struct decorative;
    _symbol_e__Struct symbol;
}

struct DWRITE_UNICODE_RANGE
{
    uint first;
    uint last;
}

struct DWRITE_SCRIPT_PROPERTIES
{
    uint isoScriptCode;
    uint isoScriptNumber;
    uint clusterLookahead;
    uint justificationCharacter;
    uint _bitfield;
}

struct DWRITE_JUSTIFICATION_OPPORTUNITY
{
    float expansionMinimum;
    float expansionMaximum;
    float compressionMaximum;
    uint _bitfield;
}

const GUID IID_IDWriteFactory1 = {0x30572F99, 0xDAC6, 0x41DB, [0xA1, 0x6E, 0x04, 0x86, 0x30, 0x7E, 0x60, 0x6A]};
@GUID(0x30572F99, 0xDAC6, 0x41DB, [0xA1, 0x6E, 0x04, 0x86, 0x30, 0x7E, 0x60, 0x6A]);
interface IDWriteFactory1 : IDWriteFactory
{
    HRESULT GetEudcFontCollection(IDWriteFontCollection* fontCollection, BOOL checkForUpdates);
    HRESULT CreateCustomRenderingParams(float gamma, float enhancedContrast, float enhancedContrastGrayscale, float clearTypeLevel, DWRITE_PIXEL_GEOMETRY pixelGeometry, DWRITE_RENDERING_MODE renderingMode, IDWriteRenderingParams1* renderingParams);
}

const GUID IID_IDWriteFontFace1 = {0xA71EFDB4, 0x9FDB, 0x4838, [0xAD, 0x90, 0xCF, 0xC3, 0xBE, 0x8C, 0x3D, 0xAF]};
@GUID(0xA71EFDB4, 0x9FDB, 0x4838, [0xAD, 0x90, 0xCF, 0xC3, 0xBE, 0x8C, 0x3D, 0xAF]);
interface IDWriteFontFace1 : IDWriteFontFace
{
    void GetMetrics(DWRITE_FONT_METRICS1* fontMetrics);
    HRESULT GetGdiCompatibleMetrics(float emSize, float pixelsPerDip, const(DWRITE_MATRIX)* transform, DWRITE_FONT_METRICS1* fontMetrics);
    void GetCaretMetrics(DWRITE_CARET_METRICS* caretMetrics);
    HRESULT GetUnicodeRanges(uint maxRangeCount, char* unicodeRanges, uint* actualRangeCount);
    BOOL IsMonospacedFont();
    HRESULT GetDesignGlyphAdvances(uint glyphCount, char* glyphIndices, char* glyphAdvances, BOOL isSideways);
    HRESULT GetGdiCompatibleGlyphAdvances(float emSize, float pixelsPerDip, const(DWRITE_MATRIX)* transform, BOOL useGdiNatural, BOOL isSideways, uint glyphCount, char* glyphIndices, char* glyphAdvances);
    HRESULT GetKerningPairAdjustments(uint glyphCount, char* glyphIndices, char* glyphAdvanceAdjustments);
    BOOL HasKerningPairs();
    HRESULT GetRecommendedRenderingMode(float fontEmSize, float dpiX, float dpiY, const(DWRITE_MATRIX)* transform, BOOL isSideways, DWRITE_OUTLINE_THRESHOLD outlineThreshold, DWRITE_MEASURING_MODE measuringMode, DWRITE_RENDERING_MODE* renderingMode);
    HRESULT GetVerticalGlyphVariants(uint glyphCount, char* nominalGlyphIndices, char* verticalGlyphIndices);
    BOOL HasVerticalGlyphVariants();
}

const GUID IID_IDWriteFont1 = {0xACD16696, 0x8C14, 0x4F5D, [0x87, 0x7E, 0xFE, 0x3F, 0xC1, 0xD3, 0x27, 0x38]};
@GUID(0xACD16696, 0x8C14, 0x4F5D, [0x87, 0x7E, 0xFE, 0x3F, 0xC1, 0xD3, 0x27, 0x38]);
interface IDWriteFont1 : IDWriteFont
{
    void GetMetrics(DWRITE_FONT_METRICS1* fontMetrics);
    void GetPanose(DWRITE_PANOSE* panose);
    HRESULT GetUnicodeRanges(uint maxRangeCount, char* unicodeRanges, uint* actualRangeCount);
    BOOL IsMonospacedFont();
}

const GUID IID_IDWriteRenderingParams1 = {0x94413CF4, 0xA6FC, 0x4248, [0x8B, 0x50, 0x66, 0x74, 0x34, 0x8F, 0xCA, 0xD3]};
@GUID(0x94413CF4, 0xA6FC, 0x4248, [0x8B, 0x50, 0x66, 0x74, 0x34, 0x8F, 0xCA, 0xD3]);
interface IDWriteRenderingParams1 : IDWriteRenderingParams
{
    float GetGrayscaleEnhancedContrast();
}

const GUID IID_IDWriteTextAnalyzer1 = {0x80DAD800, 0xE21F, 0x4E83, [0x96, 0xCE, 0xBF, 0xCC, 0xE5, 0x00, 0xDB, 0x7C]};
@GUID(0x80DAD800, 0xE21F, 0x4E83, [0x96, 0xCE, 0xBF, 0xCC, 0xE5, 0x00, 0xDB, 0x7C]);
interface IDWriteTextAnalyzer1 : IDWriteTextAnalyzer
{
    HRESULT ApplyCharacterSpacing(float leadingSpacing, float trailingSpacing, float minimumAdvanceWidth, uint textLength, uint glyphCount, char* clusterMap, char* glyphAdvances, char* glyphOffsets, char* glyphProperties, char* modifiedGlyphAdvances, char* modifiedGlyphOffsets);
    HRESULT GetBaseline(IDWriteFontFace fontFace, DWRITE_BASELINE baseline, BOOL isVertical, BOOL isSimulationAllowed, DWRITE_SCRIPT_ANALYSIS scriptAnalysis, const(wchar)* localeName, int* baselineCoordinate, int* exists);
    HRESULT AnalyzeVerticalGlyphOrientation(IDWriteTextAnalysisSource1 analysisSource, uint textPosition, uint textLength, IDWriteTextAnalysisSink1 analysisSink);
    HRESULT GetGlyphOrientationTransform(DWRITE_GLYPH_ORIENTATION_ANGLE glyphOrientationAngle, BOOL isSideways, DWRITE_MATRIX* transform);
    HRESULT GetScriptProperties(DWRITE_SCRIPT_ANALYSIS scriptAnalysis, DWRITE_SCRIPT_PROPERTIES* scriptProperties);
    HRESULT GetTextComplexity(const(wchar)* textString, uint textLength, IDWriteFontFace fontFace, int* isTextSimple, uint* textLengthRead, char* glyphIndices);
    HRESULT GetJustificationOpportunities(IDWriteFontFace fontFace, float fontEmSize, DWRITE_SCRIPT_ANALYSIS scriptAnalysis, uint textLength, uint glyphCount, const(wchar)* textString, char* clusterMap, char* glyphProperties, char* justificationOpportunities);
    HRESULT JustifyGlyphAdvances(float lineWidth, uint glyphCount, char* justificationOpportunities, char* glyphAdvances, char* glyphOffsets, char* justifiedGlyphAdvances, char* justifiedGlyphOffsets);
    HRESULT GetJustifiedGlyphs(IDWriteFontFace fontFace, float fontEmSize, DWRITE_SCRIPT_ANALYSIS scriptAnalysis, uint textLength, uint glyphCount, uint maxGlyphCount, char* clusterMap, char* glyphIndices, char* glyphAdvances, char* justifiedGlyphAdvances, char* justifiedGlyphOffsets, char* glyphProperties, uint* actualGlyphCount, char* modifiedClusterMap, char* modifiedGlyphIndices, char* modifiedGlyphAdvances, char* modifiedGlyphOffsets);
}

const GUID IID_IDWriteTextAnalysisSource1 = {0x639CFAD8, 0x0FB4, 0x4B21, [0xA5, 0x8A, 0x06, 0x79, 0x20, 0x12, 0x00, 0x09]};
@GUID(0x639CFAD8, 0x0FB4, 0x4B21, [0xA5, 0x8A, 0x06, 0x79, 0x20, 0x12, 0x00, 0x09]);
interface IDWriteTextAnalysisSource1 : IDWriteTextAnalysisSource
{
    HRESULT GetVerticalGlyphOrientation(uint textPosition, uint* textLength, DWRITE_VERTICAL_GLYPH_ORIENTATION* glyphOrientation, ubyte* bidiLevel);
}

const GUID IID_IDWriteTextAnalysisSink1 = {0xB0D941A0, 0x85E7, 0x4D8B, [0x9F, 0xD3, 0x5C, 0xED, 0x99, 0x34, 0x48, 0x2A]};
@GUID(0xB0D941A0, 0x85E7, 0x4D8B, [0x9F, 0xD3, 0x5C, 0xED, 0x99, 0x34, 0x48, 0x2A]);
interface IDWriteTextAnalysisSink1 : IDWriteTextAnalysisSink
{
    HRESULT SetGlyphOrientation(uint textPosition, uint textLength, DWRITE_GLYPH_ORIENTATION_ANGLE glyphOrientationAngle, ubyte adjustedBidiLevel, BOOL isSideways, BOOL isRightToLeft);
}

const GUID IID_IDWriteTextLayout1 = {0x9064D822, 0x80A7, 0x465C, [0xA9, 0x86, 0xDF, 0x65, 0xF7, 0x8B, 0x8F, 0xEB]};
@GUID(0x9064D822, 0x80A7, 0x465C, [0xA9, 0x86, 0xDF, 0x65, 0xF7, 0x8B, 0x8F, 0xEB]);
interface IDWriteTextLayout1 : IDWriteTextLayout
{
    HRESULT SetPairKerning(BOOL isPairKerningEnabled, DWRITE_TEXT_RANGE textRange);
    HRESULT GetPairKerning(uint currentPosition, int* isPairKerningEnabled, DWRITE_TEXT_RANGE* textRange);
    HRESULT SetCharacterSpacing(float leadingSpacing, float trailingSpacing, float minimumAdvanceWidth, DWRITE_TEXT_RANGE textRange);
    HRESULT GetCharacterSpacing(uint currentPosition, float* leadingSpacing, float* trailingSpacing, float* minimumAdvanceWidth, DWRITE_TEXT_RANGE* textRange);
}

enum DWRITE_TEXT_ANTIALIAS_MODE
{
    DWRITE_TEXT_ANTIALIAS_MODE_CLEARTYPE = 0,
    DWRITE_TEXT_ANTIALIAS_MODE_GRAYSCALE = 1,
}

const GUID IID_IDWriteBitmapRenderTarget1 = {0x791E8298, 0x3EF3, 0x4230, [0x98, 0x80, 0xC9, 0xBD, 0xEC, 0xC4, 0x20, 0x64]};
@GUID(0x791E8298, 0x3EF3, 0x4230, [0x98, 0x80, 0xC9, 0xBD, 0xEC, 0xC4, 0x20, 0x64]);
interface IDWriteBitmapRenderTarget1 : IDWriteBitmapRenderTarget
{
    DWRITE_TEXT_ANTIALIAS_MODE GetTextAntialiasMode();
    HRESULT SetTextAntialiasMode(DWRITE_TEXT_ANTIALIAS_MODE antialiasMode);
}

enum DWRITE_OPTICAL_ALIGNMENT
{
    DWRITE_OPTICAL_ALIGNMENT_NONE = 0,
    DWRITE_OPTICAL_ALIGNMENT_NO_SIDE_BEARINGS = 1,
}

enum DWRITE_GRID_FIT_MODE
{
    DWRITE_GRID_FIT_MODE_DEFAULT = 0,
    DWRITE_GRID_FIT_MODE_DISABLED = 1,
    DWRITE_GRID_FIT_MODE_ENABLED = 2,
}

struct DWRITE_TEXT_METRICS1
{
    DWRITE_TEXT_METRICS Base;
    float heightIncludingTrailingWhitespace;
}

const GUID IID_IDWriteTextRenderer1 = {0xD3E0E934, 0x22A0, 0x427E, [0xAA, 0xE4, 0x7D, 0x95, 0x74, 0xB5, 0x9D, 0xB1]};
@GUID(0xD3E0E934, 0x22A0, 0x427E, [0xAA, 0xE4, 0x7D, 0x95, 0x74, 0xB5, 0x9D, 0xB1]);
interface IDWriteTextRenderer1 : IDWriteTextRenderer
{
    HRESULT DrawGlyphRun(void* clientDrawingContext, float baselineOriginX, float baselineOriginY, DWRITE_GLYPH_ORIENTATION_ANGLE orientationAngle, DWRITE_MEASURING_MODE measuringMode, const(DWRITE_GLYPH_RUN)* glyphRun, const(DWRITE_GLYPH_RUN_DESCRIPTION)* glyphRunDescription, IUnknown clientDrawingEffect);
    HRESULT DrawUnderline(void* clientDrawingContext, float baselineOriginX, float baselineOriginY, DWRITE_GLYPH_ORIENTATION_ANGLE orientationAngle, const(DWRITE_UNDERLINE)* underline, IUnknown clientDrawingEffect);
    HRESULT DrawStrikethrough(void* clientDrawingContext, float baselineOriginX, float baselineOriginY, DWRITE_GLYPH_ORIENTATION_ANGLE orientationAngle, const(DWRITE_STRIKETHROUGH)* strikethrough, IUnknown clientDrawingEffect);
    HRESULT DrawInlineObject(void* clientDrawingContext, float originX, float originY, DWRITE_GLYPH_ORIENTATION_ANGLE orientationAngle, IDWriteInlineObject inlineObject, BOOL isSideways, BOOL isRightToLeft, IUnknown clientDrawingEffect);
}

const GUID IID_IDWriteTextFormat1 = {0x5F174B49, 0x0D8B, 0x4CFB, [0x8B, 0xCA, 0xF1, 0xCC, 0xE9, 0xD0, 0x6C, 0x67]};
@GUID(0x5F174B49, 0x0D8B, 0x4CFB, [0x8B, 0xCA, 0xF1, 0xCC, 0xE9, 0xD0, 0x6C, 0x67]);
interface IDWriteTextFormat1 : IDWriteTextFormat
{
    HRESULT SetVerticalGlyphOrientation(DWRITE_VERTICAL_GLYPH_ORIENTATION glyphOrientation);
    DWRITE_VERTICAL_GLYPH_ORIENTATION GetVerticalGlyphOrientation();
    HRESULT SetLastLineWrapping(BOOL isLastLineWrappingEnabled);
    BOOL GetLastLineWrapping();
    HRESULT SetOpticalAlignment(DWRITE_OPTICAL_ALIGNMENT opticalAlignment);
    DWRITE_OPTICAL_ALIGNMENT GetOpticalAlignment();
    HRESULT SetFontFallback(IDWriteFontFallback fontFallback);
    HRESULT GetFontFallback(IDWriteFontFallback* fontFallback);
}

const GUID IID_IDWriteTextLayout2 = {0x1093C18F, 0x8D5E, 0x43F0, [0xB0, 0x64, 0x09, 0x17, 0x31, 0x1B, 0x52, 0x5E]};
@GUID(0x1093C18F, 0x8D5E, 0x43F0, [0xB0, 0x64, 0x09, 0x17, 0x31, 0x1B, 0x52, 0x5E]);
interface IDWriteTextLayout2 : IDWriteTextLayout1
{
    HRESULT GetMetrics(DWRITE_TEXT_METRICS1* textMetrics);
    HRESULT SetVerticalGlyphOrientation(DWRITE_VERTICAL_GLYPH_ORIENTATION glyphOrientation);
    DWRITE_VERTICAL_GLYPH_ORIENTATION GetVerticalGlyphOrientation();
    HRESULT SetLastLineWrapping(BOOL isLastLineWrappingEnabled);
    BOOL GetLastLineWrapping();
    HRESULT SetOpticalAlignment(DWRITE_OPTICAL_ALIGNMENT opticalAlignment);
    DWRITE_OPTICAL_ALIGNMENT GetOpticalAlignment();
    HRESULT SetFontFallback(IDWriteFontFallback fontFallback);
    HRESULT GetFontFallback(IDWriteFontFallback* fontFallback);
}

const GUID IID_IDWriteTextAnalyzer2 = {0x553A9FF3, 0x5693, 0x4DF7, [0xB5, 0x2B, 0x74, 0x80, 0x6F, 0x7F, 0x2E, 0xB9]};
@GUID(0x553A9FF3, 0x5693, 0x4DF7, [0xB5, 0x2B, 0x74, 0x80, 0x6F, 0x7F, 0x2E, 0xB9]);
interface IDWriteTextAnalyzer2 : IDWriteTextAnalyzer1
{
    HRESULT GetGlyphOrientationTransform(DWRITE_GLYPH_ORIENTATION_ANGLE glyphOrientationAngle, BOOL isSideways, float originX, float originY, DWRITE_MATRIX* transform);
    HRESULT GetTypographicFeatures(IDWriteFontFace fontFace, DWRITE_SCRIPT_ANALYSIS scriptAnalysis, const(wchar)* localeName, uint maxTagCount, uint* actualTagCount, char* tags);
    HRESULT CheckTypographicFeature(IDWriteFontFace fontFace, DWRITE_SCRIPT_ANALYSIS scriptAnalysis, const(wchar)* localeName, DWRITE_FONT_FEATURE_TAG featureTag, uint glyphCount, char* glyphIndices, char* featureApplies);
}

const GUID IID_IDWriteFontFallback = {0xEFA008F9, 0xF7A1, 0x48BF, [0xB0, 0x5C, 0xF2, 0x24, 0x71, 0x3C, 0xC0, 0xFF]};
@GUID(0xEFA008F9, 0xF7A1, 0x48BF, [0xB0, 0x5C, 0xF2, 0x24, 0x71, 0x3C, 0xC0, 0xFF]);
interface IDWriteFontFallback : IUnknown
{
    HRESULT MapCharacters(IDWriteTextAnalysisSource analysisSource, uint textPosition, uint textLength, IDWriteFontCollection baseFontCollection, const(ushort)* baseFamilyName, DWRITE_FONT_WEIGHT baseWeight, DWRITE_FONT_STYLE baseStyle, DWRITE_FONT_STRETCH baseStretch, uint* mappedLength, IDWriteFont* mappedFont, float* scale);
}

const GUID IID_IDWriteFontFallbackBuilder = {0xFD882D06, 0x8ABA, 0x4FB8, [0xB8, 0x49, 0x8B, 0xE8, 0xB7, 0x3E, 0x14, 0xDE]};
@GUID(0xFD882D06, 0x8ABA, 0x4FB8, [0xB8, 0x49, 0x8B, 0xE8, 0xB7, 0x3E, 0x14, 0xDE]);
interface IDWriteFontFallbackBuilder : IUnknown
{
    HRESULT AddMapping(char* ranges, uint rangesCount, char* targetFamilyNames, uint targetFamilyNamesCount, IDWriteFontCollection fontCollection, const(wchar)* localeName, const(wchar)* baseFamilyName, float scale);
    HRESULT AddMappings(IDWriteFontFallback fontFallback);
    HRESULT CreateFontFallback(IDWriteFontFallback* fontFallback);
}

const GUID IID_IDWriteFont2 = {0x29748ED6, 0x8C9C, 0x4A6A, [0xBE, 0x0B, 0xD9, 0x12, 0xE8, 0x53, 0x89, 0x44]};
@GUID(0x29748ED6, 0x8C9C, 0x4A6A, [0xBE, 0x0B, 0xD9, 0x12, 0xE8, 0x53, 0x89, 0x44]);
interface IDWriteFont2 : IDWriteFont1
{
    BOOL IsColorFont();
}

const GUID IID_IDWriteFontFace2 = {0xD8B768FF, 0x64BC, 0x4E66, [0x98, 0x2B, 0xEC, 0x8E, 0x87, 0xF6, 0x93, 0xF7]};
@GUID(0xD8B768FF, 0x64BC, 0x4E66, [0x98, 0x2B, 0xEC, 0x8E, 0x87, 0xF6, 0x93, 0xF7]);
interface IDWriteFontFace2 : IDWriteFontFace1
{
    BOOL IsColorFont();
    uint GetColorPaletteCount();
    uint GetPaletteEntryCount();
    HRESULT GetPaletteEntries(uint colorPaletteIndex, uint firstEntryIndex, uint entryCount, char* paletteEntries);
    HRESULT GetRecommendedRenderingMode(float fontEmSize, float dpiX, float dpiY, const(DWRITE_MATRIX)* transform, BOOL isSideways, DWRITE_OUTLINE_THRESHOLD outlineThreshold, DWRITE_MEASURING_MODE measuringMode, IDWriteRenderingParams renderingParams, DWRITE_RENDERING_MODE* renderingMode, DWRITE_GRID_FIT_MODE* gridFitMode);
}

struct DWRITE_COLOR_GLYPH_RUN
{
    DWRITE_GLYPH_RUN glyphRun;
    DWRITE_GLYPH_RUN_DESCRIPTION* glyphRunDescription;
    float baselineOriginX;
    float baselineOriginY;
    DXGI_RGBA runColor;
    ushort paletteIndex;
}

const GUID IID_IDWriteColorGlyphRunEnumerator = {0xD31FBE17, 0xF157, 0x41A2, [0x8D, 0x24, 0xCB, 0x77, 0x9E, 0x05, 0x60, 0xE8]};
@GUID(0xD31FBE17, 0xF157, 0x41A2, [0x8D, 0x24, 0xCB, 0x77, 0x9E, 0x05, 0x60, 0xE8]);
interface IDWriteColorGlyphRunEnumerator : IUnknown
{
    HRESULT MoveNext(int* hasRun);
    HRESULT GetCurrentRun(const(DWRITE_COLOR_GLYPH_RUN)** colorGlyphRun);
}

const GUID IID_IDWriteRenderingParams2 = {0xF9D711C3, 0x9777, 0x40AE, [0x87, 0xE8, 0x3E, 0x5A, 0xF9, 0xBF, 0x09, 0x48]};
@GUID(0xF9D711C3, 0x9777, 0x40AE, [0x87, 0xE8, 0x3E, 0x5A, 0xF9, 0xBF, 0x09, 0x48]);
interface IDWriteRenderingParams2 : IDWriteRenderingParams1
{
    DWRITE_GRID_FIT_MODE GetGridFitMode();
}

const GUID IID_IDWriteFactory2 = {0x0439FC60, 0xCA44, 0x4994, [0x8D, 0xEE, 0x3A, 0x9A, 0xF7, 0xB7, 0x32, 0xEC]};
@GUID(0x0439FC60, 0xCA44, 0x4994, [0x8D, 0xEE, 0x3A, 0x9A, 0xF7, 0xB7, 0x32, 0xEC]);
interface IDWriteFactory2 : IDWriteFactory1
{
    HRESULT GetSystemFontFallback(IDWriteFontFallback* fontFallback);
    HRESULT CreateFontFallbackBuilder(IDWriteFontFallbackBuilder* fontFallbackBuilder);
    HRESULT TranslateColorGlyphRun(float baselineOriginX, float baselineOriginY, const(DWRITE_GLYPH_RUN)* glyphRun, const(DWRITE_GLYPH_RUN_DESCRIPTION)* glyphRunDescription, DWRITE_MEASURING_MODE measuringMode, const(DWRITE_MATRIX)* worldToDeviceTransform, uint colorPaletteIndex, IDWriteColorGlyphRunEnumerator* colorLayers);
    HRESULT CreateCustomRenderingParams(float gamma, float enhancedContrast, float grayscaleEnhancedContrast, float clearTypeLevel, DWRITE_PIXEL_GEOMETRY pixelGeometry, DWRITE_RENDERING_MODE renderingMode, DWRITE_GRID_FIT_MODE gridFitMode, IDWriteRenderingParams2* renderingParams);
    HRESULT CreateGlyphRunAnalysis(const(DWRITE_GLYPH_RUN)* glyphRun, const(DWRITE_MATRIX)* transform, DWRITE_RENDERING_MODE renderingMode, DWRITE_MEASURING_MODE measuringMode, DWRITE_GRID_FIT_MODE gridFitMode, DWRITE_TEXT_ANTIALIAS_MODE antialiasMode, float baselineOriginX, float baselineOriginY, IDWriteGlyphRunAnalysis* glyphRunAnalysis);
}

enum DWRITE_FONT_PROPERTY_ID
{
    DWRITE_FONT_PROPERTY_ID_NONE = 0,
    DWRITE_FONT_PROPERTY_ID_WEIGHT_STRETCH_STYLE_FAMILY_NAME = 1,
    DWRITE_FONT_PROPERTY_ID_TYPOGRAPHIC_FAMILY_NAME = 2,
    DWRITE_FONT_PROPERTY_ID_WEIGHT_STRETCH_STYLE_FACE_NAME = 3,
    DWRITE_FONT_PROPERTY_ID_FULL_NAME = 4,
    DWRITE_FONT_PROPERTY_ID_WIN32_FAMILY_NAME = 5,
    DWRITE_FONT_PROPERTY_ID_POSTSCRIPT_NAME = 6,
    DWRITE_FONT_PROPERTY_ID_DESIGN_SCRIPT_LANGUAGE_TAG = 7,
    DWRITE_FONT_PROPERTY_ID_SUPPORTED_SCRIPT_LANGUAGE_TAG = 8,
    DWRITE_FONT_PROPERTY_ID_SEMANTIC_TAG = 9,
    DWRITE_FONT_PROPERTY_ID_WEIGHT = 10,
    DWRITE_FONT_PROPERTY_ID_STRETCH = 11,
    DWRITE_FONT_PROPERTY_ID_STYLE = 12,
    DWRITE_FONT_PROPERTY_ID_TYPOGRAPHIC_FACE_NAME = 13,
    DWRITE_FONT_PROPERTY_ID_TOTAL = 13,
    DWRITE_FONT_PROPERTY_ID_TOTAL_RS3 = 14,
    DWRITE_FONT_PROPERTY_ID_PREFERRED_FAMILY_NAME = 2,
    DWRITE_FONT_PROPERTY_ID_FAMILY_NAME = 1,
    DWRITE_FONT_PROPERTY_ID_FACE_NAME = 3,
}

struct DWRITE_FONT_PROPERTY
{
    DWRITE_FONT_PROPERTY_ID propertyId;
    const(wchar)* propertyValue;
    const(wchar)* localeName;
}

enum DWRITE_LOCALITY
{
    DWRITE_LOCALITY_REMOTE = 0,
    DWRITE_LOCALITY_PARTIAL = 1,
    DWRITE_LOCALITY_LOCAL = 2,
}

enum DWRITE_RENDERING_MODE1
{
    DWRITE_RENDERING_MODE1_DEFAULT = 0,
    DWRITE_RENDERING_MODE1_ALIASED = 1,
    DWRITE_RENDERING_MODE1_GDI_CLASSIC = 2,
    DWRITE_RENDERING_MODE1_GDI_NATURAL = 3,
    DWRITE_RENDERING_MODE1_NATURAL = 4,
    DWRITE_RENDERING_MODE1_NATURAL_SYMMETRIC = 5,
    DWRITE_RENDERING_MODE1_OUTLINE = 6,
    DWRITE_RENDERING_MODE1_NATURAL_SYMMETRIC_DOWNSAMPLED = 7,
}

const GUID IID_IDWriteRenderingParams3 = {0xB7924BAA, 0x391B, 0x412A, [0x8C, 0x5C, 0xE4, 0x4C, 0xC2, 0xD8, 0x67, 0xDC]};
@GUID(0xB7924BAA, 0x391B, 0x412A, [0x8C, 0x5C, 0xE4, 0x4C, 0xC2, 0xD8, 0x67, 0xDC]);
interface IDWriteRenderingParams3 : IDWriteRenderingParams2
{
    DWRITE_RENDERING_MODE1 GetRenderingMode1();
}

const GUID IID_IDWriteFactory3 = {0x9A1B41C3, 0xD3BB, 0x466A, [0x87, 0xFC, 0xFE, 0x67, 0x55, 0x6A, 0x3B, 0x65]};
@GUID(0x9A1B41C3, 0xD3BB, 0x466A, [0x87, 0xFC, 0xFE, 0x67, 0x55, 0x6A, 0x3B, 0x65]);
interface IDWriteFactory3 : IDWriteFactory2
{
    HRESULT CreateGlyphRunAnalysis(const(DWRITE_GLYPH_RUN)* glyphRun, const(DWRITE_MATRIX)* transform, DWRITE_RENDERING_MODE1 renderingMode, DWRITE_MEASURING_MODE measuringMode, DWRITE_GRID_FIT_MODE gridFitMode, DWRITE_TEXT_ANTIALIAS_MODE antialiasMode, float baselineOriginX, float baselineOriginY, IDWriteGlyphRunAnalysis* glyphRunAnalysis);
    HRESULT CreateCustomRenderingParams(float gamma, float enhancedContrast, float grayscaleEnhancedContrast, float clearTypeLevel, DWRITE_PIXEL_GEOMETRY pixelGeometry, DWRITE_RENDERING_MODE1 renderingMode, DWRITE_GRID_FIT_MODE gridFitMode, IDWriteRenderingParams3* renderingParams);
    HRESULT CreateFontFaceReference(const(wchar)* filePath, const(FILETIME)* lastWriteTime, uint faceIndex, DWRITE_FONT_SIMULATIONS fontSimulations, IDWriteFontFaceReference* fontFaceReference);
    HRESULT CreateFontFaceReference(IDWriteFontFile fontFile, uint faceIndex, DWRITE_FONT_SIMULATIONS fontSimulations, IDWriteFontFaceReference* fontFaceReference);
    HRESULT GetSystemFontSet(IDWriteFontSet* fontSet);
    HRESULT CreateFontSetBuilder(IDWriteFontSetBuilder* fontSetBuilder);
    HRESULT CreateFontCollectionFromFontSet(IDWriteFontSet fontSet, IDWriteFontCollection1* fontCollection);
    HRESULT GetSystemFontCollection(BOOL includeDownloadableFonts, IDWriteFontCollection1* fontCollection, BOOL checkForUpdates);
    HRESULT GetFontDownloadQueue(IDWriteFontDownloadQueue* fontDownloadQueue);
}

const GUID IID_IDWriteFontSet = {0x53585141, 0xD9F8, 0x4095, [0x83, 0x21, 0xD7, 0x3C, 0xF6, 0xBD, 0x11, 0x6B]};
@GUID(0x53585141, 0xD9F8, 0x4095, [0x83, 0x21, 0xD7, 0x3C, 0xF6, 0xBD, 0x11, 0x6B]);
interface IDWriteFontSet : IUnknown
{
    uint GetFontCount();
    HRESULT GetFontFaceReference(uint listIndex, IDWriteFontFaceReference* fontFaceReference);
    HRESULT FindFontFaceReference(IDWriteFontFaceReference fontFaceReference, uint* listIndex, int* exists);
    HRESULT FindFontFace(IDWriteFontFace fontFace, uint* listIndex, int* exists);
    HRESULT GetPropertyValues(uint listIndex, DWRITE_FONT_PROPERTY_ID propertyId, int* exists, IDWriteLocalizedStrings* values);
    HRESULT GetPropertyValues(DWRITE_FONT_PROPERTY_ID propertyID, const(wchar)* preferredLocaleNames, IDWriteStringList* values);
    HRESULT GetPropertyValues(DWRITE_FONT_PROPERTY_ID propertyID, IDWriteStringList* values);
    HRESULT GetPropertyOccurrenceCount(const(DWRITE_FONT_PROPERTY)* property, uint* propertyOccurrenceCount);
    HRESULT GetMatchingFonts(char* properties, uint propertyCount, IDWriteFontSet* filteredSet);
    HRESULT GetMatchingFonts(const(wchar)* familyName, DWRITE_FONT_WEIGHT fontWeight, DWRITE_FONT_STRETCH fontStretch, DWRITE_FONT_STYLE fontStyle, IDWriteFontSet* filteredSet);
}

const GUID IID_IDWriteFontSetBuilder = {0x2F642AFE, 0x9C68, 0x4F40, [0xB8, 0xBE, 0x45, 0x74, 0x01, 0xAF, 0xCB, 0x3D]};
@GUID(0x2F642AFE, 0x9C68, 0x4F40, [0xB8, 0xBE, 0x45, 0x74, 0x01, 0xAF, 0xCB, 0x3D]);
interface IDWriteFontSetBuilder : IUnknown
{
    HRESULT AddFontFaceReference(IDWriteFontFaceReference fontFaceReference);
    HRESULT AddFontFaceReference(IDWriteFontFaceReference fontFaceReference, char* properties, uint propertyCount);
    HRESULT AddFontSet(IDWriteFontSet fontSet);
    HRESULT CreateFontSet(IDWriteFontSet* fontSet);
}

const GUID IID_IDWriteFontCollection1 = {0x53585141, 0xD9F8, 0x4095, [0x83, 0x21, 0xD7, 0x3C, 0xF6, 0xBD, 0x11, 0x6C]};
@GUID(0x53585141, 0xD9F8, 0x4095, [0x83, 0x21, 0xD7, 0x3C, 0xF6, 0xBD, 0x11, 0x6C]);
interface IDWriteFontCollection1 : IDWriteFontCollection
{
    HRESULT GetFontSet(IDWriteFontSet* fontSet);
    HRESULT GetFontFamily(uint index, IDWriteFontFamily1* fontFamily);
}

const GUID IID_IDWriteFontFamily1 = {0xDA20D8EF, 0x812A, 0x4C43, [0x98, 0x02, 0x62, 0xEC, 0x4A, 0xBD, 0x7A, 0xDF]};
@GUID(0xDA20D8EF, 0x812A, 0x4C43, [0x98, 0x02, 0x62, 0xEC, 0x4A, 0xBD, 0x7A, 0xDF]);
interface IDWriteFontFamily1 : IDWriteFontFamily
{
    DWRITE_LOCALITY GetFontLocality(uint listIndex);
    HRESULT GetFont(uint listIndex, IDWriteFont3* font);
    HRESULT GetFontFaceReference(uint listIndex, IDWriteFontFaceReference* fontFaceReference);
}

const GUID IID_IDWriteFontList1 = {0xDA20D8EF, 0x812A, 0x4C43, [0x98, 0x02, 0x62, 0xEC, 0x4A, 0xBD, 0x7A, 0xDE]};
@GUID(0xDA20D8EF, 0x812A, 0x4C43, [0x98, 0x02, 0x62, 0xEC, 0x4A, 0xBD, 0x7A, 0xDE]);
interface IDWriteFontList1 : IDWriteFontList
{
    DWRITE_LOCALITY GetFontLocality(uint listIndex);
    HRESULT GetFont(uint listIndex, IDWriteFont3* font);
    HRESULT GetFontFaceReference(uint listIndex, IDWriteFontFaceReference* fontFaceReference);
}

const GUID IID_IDWriteFontFaceReference = {0x5E7FA7CA, 0xDDE3, 0x424C, [0x89, 0xF0, 0x9F, 0xCD, 0x6F, 0xED, 0x58, 0xCD]};
@GUID(0x5E7FA7CA, 0xDDE3, 0x424C, [0x89, 0xF0, 0x9F, 0xCD, 0x6F, 0xED, 0x58, 0xCD]);
interface IDWriteFontFaceReference : IUnknown
{
    HRESULT CreateFontFace(IDWriteFontFace3* fontFace);
    HRESULT CreateFontFaceWithSimulations(DWRITE_FONT_SIMULATIONS fontFaceSimulationFlags, IDWriteFontFace3* fontFace);
    BOOL Equals(IDWriteFontFaceReference fontFaceReference);
    uint GetFontFaceIndex();
    DWRITE_FONT_SIMULATIONS GetSimulations();
    HRESULT GetFontFile(IDWriteFontFile* fontFile);
    ulong GetLocalFileSize();
    ulong GetFileSize();
    HRESULT GetFileTime(FILETIME* lastWriteTime);
    DWRITE_LOCALITY GetLocality();
    HRESULT EnqueueFontDownloadRequest();
    HRESULT EnqueueCharacterDownloadRequest(const(wchar)* characters, uint characterCount);
    HRESULT EnqueueGlyphDownloadRequest(char* glyphIndices, uint glyphCount);
    HRESULT EnqueueFileFragmentDownloadRequest(ulong fileOffset, ulong fragmentSize);
}

const GUID IID_IDWriteFont3 = {0x29748ED6, 0x8C9C, 0x4A6A, [0xBE, 0x0B, 0xD9, 0x12, 0xE8, 0x53, 0x89, 0x44]};
@GUID(0x29748ED6, 0x8C9C, 0x4A6A, [0xBE, 0x0B, 0xD9, 0x12, 0xE8, 0x53, 0x89, 0x44]);
interface IDWriteFont3 : IDWriteFont2
{
    HRESULT CreateFontFace(IDWriteFontFace3* fontFace);
    BOOL Equals(IDWriteFont font);
    HRESULT GetFontFaceReference(IDWriteFontFaceReference* fontFaceReference);
    BOOL HasCharacter(uint unicodeValue);
    DWRITE_LOCALITY GetLocality();
}

const GUID IID_IDWriteFontFace3 = {0xD37D7598, 0x09BE, 0x4222, [0xA2, 0x36, 0x20, 0x81, 0x34, 0x1C, 0xC1, 0xF2]};
@GUID(0xD37D7598, 0x09BE, 0x4222, [0xA2, 0x36, 0x20, 0x81, 0x34, 0x1C, 0xC1, 0xF2]);
interface IDWriteFontFace3 : IDWriteFontFace2
{
    HRESULT GetFontFaceReference(IDWriteFontFaceReference* fontFaceReference);
    void GetPanose(DWRITE_PANOSE* panose);
    DWRITE_FONT_WEIGHT GetWeight();
    DWRITE_FONT_STRETCH GetStretch();
    DWRITE_FONT_STYLE GetStyle();
    HRESULT GetFamilyNames(IDWriteLocalizedStrings* names);
    HRESULT GetFaceNames(IDWriteLocalizedStrings* names);
    HRESULT GetInformationalStrings(DWRITE_INFORMATIONAL_STRING_ID informationalStringID, IDWriteLocalizedStrings* informationalStrings, int* exists);
    BOOL HasCharacter(uint unicodeValue);
    HRESULT GetRecommendedRenderingMode(float fontEmSize, float dpiX, float dpiY, const(DWRITE_MATRIX)* transform, BOOL isSideways, DWRITE_OUTLINE_THRESHOLD outlineThreshold, DWRITE_MEASURING_MODE measuringMode, IDWriteRenderingParams renderingParams, DWRITE_RENDERING_MODE1* renderingMode, DWRITE_GRID_FIT_MODE* gridFitMode);
    BOOL IsCharacterLocal(uint unicodeValue);
    BOOL IsGlyphLocal(ushort glyphId);
    HRESULT AreCharactersLocal(const(wchar)* characters, uint characterCount, BOOL enqueueIfNotLocal, int* isLocal);
    HRESULT AreGlyphsLocal(char* glyphIndices, uint glyphCount, BOOL enqueueIfNotLocal, int* isLocal);
}

const GUID IID_IDWriteStringList = {0xCFEE3140, 0x1157, 0x47CA, [0x8B, 0x85, 0x31, 0xBF, 0xCF, 0x3F, 0x2D, 0x0E]};
@GUID(0xCFEE3140, 0x1157, 0x47CA, [0x8B, 0x85, 0x31, 0xBF, 0xCF, 0x3F, 0x2D, 0x0E]);
interface IDWriteStringList : IUnknown
{
    uint GetCount();
    HRESULT GetLocaleNameLength(uint listIndex, uint* length);
    HRESULT GetLocaleName(uint listIndex, char* localeName, uint size);
    HRESULT GetStringLength(uint listIndex, uint* length);
    HRESULT GetString(uint listIndex, char* stringBuffer, uint stringBufferSize);
}

const GUID IID_IDWriteFontDownloadListener = {0xB06FE5B9, 0x43EC, 0x4393, [0x88, 0x1B, 0xDB, 0xE4, 0xDC, 0x72, 0xFD, 0xA7]};
@GUID(0xB06FE5B9, 0x43EC, 0x4393, [0x88, 0x1B, 0xDB, 0xE4, 0xDC, 0x72, 0xFD, 0xA7]);
interface IDWriteFontDownloadListener : IUnknown
{
    void DownloadCompleted(IDWriteFontDownloadQueue downloadQueue, IUnknown context, HRESULT downloadResult);
}

const GUID IID_IDWriteFontDownloadQueue = {0xB71E6052, 0x5AEA, 0x4FA3, [0x83, 0x2E, 0xF6, 0x0D, 0x43, 0x1F, 0x7E, 0x91]};
@GUID(0xB71E6052, 0x5AEA, 0x4FA3, [0x83, 0x2E, 0xF6, 0x0D, 0x43, 0x1F, 0x7E, 0x91]);
interface IDWriteFontDownloadQueue : IUnknown
{
    HRESULT AddListener(IDWriteFontDownloadListener listener, uint* token);
    HRESULT RemoveListener(uint token);
    BOOL IsEmpty();
    HRESULT BeginDownload(IUnknown context);
    HRESULT CancelDownload();
    ulong GetGenerationCount();
}

const GUID IID_IDWriteGdiInterop1 = {0x4556BE70, 0x3ABD, 0x4F70, [0x90, 0xBE, 0x42, 0x17, 0x80, 0xA6, 0xF5, 0x15]};
@GUID(0x4556BE70, 0x3ABD, 0x4F70, [0x90, 0xBE, 0x42, 0x17, 0x80, 0xA6, 0xF5, 0x15]);
interface IDWriteGdiInterop1 : IDWriteGdiInterop
{
    HRESULT CreateFontFromLOGFONT(const(LOGFONTW)* logFont, IDWriteFontCollection fontCollection, IDWriteFont* font);
    HRESULT GetFontSignature(IDWriteFont font, FONTSIGNATURE* fontSignature);
    HRESULT GetFontSignature(IDWriteFontFace fontFace, FONTSIGNATURE* fontSignature);
    HRESULT GetMatchingFontsByLOGFONT(const(LOGFONTA)* logFont, IDWriteFontSet fontSet, IDWriteFontSet* filteredSet);
}

struct DWRITE_LINE_METRICS1
{
    DWRITE_LINE_METRICS Base;
    float leadingBefore;
    float leadingAfter;
}

enum DWRITE_FONT_LINE_GAP_USAGE
{
    DWRITE_FONT_LINE_GAP_USAGE_DEFAULT = 0,
    DWRITE_FONT_LINE_GAP_USAGE_DISABLED = 1,
    DWRITE_FONT_LINE_GAP_USAGE_ENABLED = 2,
}

struct DWRITE_LINE_SPACING
{
    DWRITE_LINE_SPACING_METHOD method;
    float height;
    float baseline;
    float leadingBefore;
    DWRITE_FONT_LINE_GAP_USAGE fontLineGapUsage;
}

const GUID IID_IDWriteTextFormat2 = {0xF67E0EDD, 0x9E3D, 0x4ECC, [0x8C, 0x32, 0x41, 0x83, 0x25, 0x3D, 0xFE, 0x70]};
@GUID(0xF67E0EDD, 0x9E3D, 0x4ECC, [0x8C, 0x32, 0x41, 0x83, 0x25, 0x3D, 0xFE, 0x70]);
interface IDWriteTextFormat2 : IDWriteTextFormat1
{
    HRESULT SetLineSpacing(const(DWRITE_LINE_SPACING)* lineSpacingOptions);
    HRESULT GetLineSpacing(DWRITE_LINE_SPACING* lineSpacingOptions);
}

const GUID IID_IDWriteTextLayout3 = {0x07DDCD52, 0x020E, 0x4DE8, [0xAC, 0x33, 0x6C, 0x95, 0x3D, 0x83, 0xF9, 0x2D]};
@GUID(0x07DDCD52, 0x020E, 0x4DE8, [0xAC, 0x33, 0x6C, 0x95, 0x3D, 0x83, 0xF9, 0x2D]);
interface IDWriteTextLayout3 : IDWriteTextLayout2
{
    HRESULT InvalidateLayout();
    HRESULT SetLineSpacing(const(DWRITE_LINE_SPACING)* lineSpacingOptions);
    HRESULT GetLineSpacing(DWRITE_LINE_SPACING* lineSpacingOptions);
    HRESULT GetLineMetrics(char* lineMetrics, uint maxLineCount, uint* actualLineCount);
}

struct DWRITE_COLOR_GLYPH_RUN1
{
    DWRITE_COLOR_GLYPH_RUN Base;
    DWRITE_GLYPH_IMAGE_FORMATS glyphImageFormat;
    DWRITE_MEASURING_MODE measuringMode;
}

struct DWRITE_GLYPH_IMAGE_DATA
{
    const(void)* imageData;
    uint imageDataSize;
    uint uniqueDataId;
    uint pixelsPerEm;
    D2D_SIZE_U pixelSize;
    POINT horizontalLeftOrigin;
    POINT horizontalRightOrigin;
    POINT verticalTopOrigin;
    POINT verticalBottomOrigin;
}

const GUID IID_IDWriteColorGlyphRunEnumerator1 = {0x7C5F86DA, 0xC7A1, 0x4F05, [0xB8, 0xE1, 0x55, 0xA1, 0x79, 0xFE, 0x5A, 0x35]};
@GUID(0x7C5F86DA, 0xC7A1, 0x4F05, [0xB8, 0xE1, 0x55, 0xA1, 0x79, 0xFE, 0x5A, 0x35]);
interface IDWriteColorGlyphRunEnumerator1 : IDWriteColorGlyphRunEnumerator
{
    HRESULT GetCurrentRun(const(DWRITE_COLOR_GLYPH_RUN1)** colorGlyphRun);
}

const GUID IID_IDWriteFontFace4 = {0x27F2A904, 0x4EB8, 0x441D, [0x96, 0x78, 0x05, 0x63, 0xF5, 0x3E, 0x3E, 0x2F]};
@GUID(0x27F2A904, 0x4EB8, 0x441D, [0x96, 0x78, 0x05, 0x63, 0xF5, 0x3E, 0x3E, 0x2F]);
interface IDWriteFontFace4 : IDWriteFontFace3
{
    DWRITE_GLYPH_IMAGE_FORMATS GetGlyphImageFormats();
    HRESULT GetGlyphImageFormats(ushort glyphId, uint pixelsPerEmFirst, uint pixelsPerEmLast, DWRITE_GLYPH_IMAGE_FORMATS* glyphImageFormats);
    HRESULT GetGlyphImageData(ushort glyphId, uint pixelsPerEm, DWRITE_GLYPH_IMAGE_FORMATS glyphImageFormat, DWRITE_GLYPH_IMAGE_DATA* glyphData, void** glyphDataContext);
    void ReleaseGlyphImageData(void* glyphDataContext);
}

const GUID IID_IDWriteFactory4 = {0x4B0B5BD3, 0x0797, 0x4549, [0x8A, 0xC5, 0xFE, 0x91, 0x5C, 0xC5, 0x38, 0x56]};
@GUID(0x4B0B5BD3, 0x0797, 0x4549, [0x8A, 0xC5, 0xFE, 0x91, 0x5C, 0xC5, 0x38, 0x56]);
interface IDWriteFactory4 : IDWriteFactory3
{
    HRESULT TranslateColorGlyphRun(D2D_POINT_2F baselineOrigin, const(DWRITE_GLYPH_RUN)* glyphRun, const(DWRITE_GLYPH_RUN_DESCRIPTION)* glyphRunDescription, DWRITE_GLYPH_IMAGE_FORMATS desiredGlyphImageFormats, DWRITE_MEASURING_MODE measuringMode, const(DWRITE_MATRIX)* worldAndDpiTransform, uint colorPaletteIndex, IDWriteColorGlyphRunEnumerator1* colorLayers);
    HRESULT ComputeGlyphOrigins(const(DWRITE_GLYPH_RUN)* glyphRun, DWRITE_MEASURING_MODE measuringMode, D2D_POINT_2F baselineOrigin, const(DWRITE_MATRIX)* worldAndDpiTransform, char* glyphOrigins);
    HRESULT ComputeGlyphOrigins(const(DWRITE_GLYPH_RUN)* glyphRun, D2D_POINT_2F baselineOrigin, char* glyphOrigins);
}

const GUID IID_IDWriteFontSetBuilder1 = {0x3FF7715F, 0x3CDC, 0x4DC6, [0x9B, 0x72, 0xEC, 0x56, 0x21, 0xDC, 0xCA, 0xFD]};
@GUID(0x3FF7715F, 0x3CDC, 0x4DC6, [0x9B, 0x72, 0xEC, 0x56, 0x21, 0xDC, 0xCA, 0xFD]);
interface IDWriteFontSetBuilder1 : IDWriteFontSetBuilder
{
    HRESULT AddFontFile(IDWriteFontFile fontFile);
}

const GUID IID_IDWriteAsyncResult = {0xCE25F8FD, 0x863B, 0x4D13, [0x96, 0x51, 0xC1, 0xF8, 0x8D, 0xC7, 0x3F, 0xE2]};
@GUID(0xCE25F8FD, 0x863B, 0x4D13, [0x96, 0x51, 0xC1, 0xF8, 0x8D, 0xC7, 0x3F, 0xE2]);
interface IDWriteAsyncResult : IUnknown
{
    HANDLE GetWaitHandle();
    HRESULT GetResult();
}

struct DWRITE_FILE_FRAGMENT
{
    ulong fileOffset;
    ulong fragmentSize;
}

const GUID IID_IDWriteRemoteFontFileStream = {0x4DB3757A, 0x2C72, 0x4ED9, [0xB2, 0xB6, 0x1A, 0xBA, 0xBE, 0x1A, 0xFF, 0x9C]};
@GUID(0x4DB3757A, 0x2C72, 0x4ED9, [0xB2, 0xB6, 0x1A, 0xBA, 0xBE, 0x1A, 0xFF, 0x9C]);
interface IDWriteRemoteFontFileStream : IDWriteFontFileStream
{
    HRESULT GetLocalFileSize(ulong* localFileSize);
    HRESULT GetFileFragmentLocality(ulong fileOffset, ulong fragmentSize, int* isLocal, ulong* partialSize);
    DWRITE_LOCALITY GetLocality();
    HRESULT BeginDownload(const(Guid)* downloadOperationID, char* fileFragments, uint fragmentCount, IDWriteAsyncResult* asyncResult);
}

enum DWRITE_CONTAINER_TYPE
{
    DWRITE_CONTAINER_TYPE_UNKNOWN = 0,
    DWRITE_CONTAINER_TYPE_WOFF = 1,
    DWRITE_CONTAINER_TYPE_WOFF2 = 2,
}

const GUID IID_IDWriteRemoteFontFileLoader = {0x68648C83, 0x6EDE, 0x46C0, [0xAB, 0x46, 0x20, 0x08, 0x3A, 0x88, 0x7F, 0xDE]};
@GUID(0x68648C83, 0x6EDE, 0x46C0, [0xAB, 0x46, 0x20, 0x08, 0x3A, 0x88, 0x7F, 0xDE]);
interface IDWriteRemoteFontFileLoader : IDWriteFontFileLoader
{
    HRESULT CreateRemoteStreamFromKey(char* fontFileReferenceKey, uint fontFileReferenceKeySize, IDWriteRemoteFontFileStream* fontFileStream);
    HRESULT GetLocalityFromKey(char* fontFileReferenceKey, uint fontFileReferenceKeySize, DWRITE_LOCALITY* locality);
    HRESULT CreateFontFileReferenceFromUrl(IDWriteFactory factory, const(wchar)* baseUrl, const(wchar)* fontFileUrl, IDWriteFontFile* fontFile);
}

const GUID IID_IDWriteInMemoryFontFileLoader = {0xDC102F47, 0xA12D, 0x4B1C, [0x82, 0x2D, 0x9E, 0x11, 0x7E, 0x33, 0x04, 0x3F]};
@GUID(0xDC102F47, 0xA12D, 0x4B1C, [0x82, 0x2D, 0x9E, 0x11, 0x7E, 0x33, 0x04, 0x3F]);
interface IDWriteInMemoryFontFileLoader : IDWriteFontFileLoader
{
    HRESULT CreateInMemoryFontFileReference(IDWriteFactory factory, char* fontData, uint fontDataSize, IUnknown ownerObject, IDWriteFontFile* fontFile);
    uint GetFileCount();
}

const GUID IID_IDWriteFactory5 = {0x958DB99A, 0xBE2A, 0x4F09, [0xAF, 0x7D, 0x65, 0x18, 0x98, 0x03, 0xD1, 0xD3]};
@GUID(0x958DB99A, 0xBE2A, 0x4F09, [0xAF, 0x7D, 0x65, 0x18, 0x98, 0x03, 0xD1, 0xD3]);
interface IDWriteFactory5 : IDWriteFactory4
{
    HRESULT CreateFontSetBuilder(IDWriteFontSetBuilder1* fontSetBuilder);
    HRESULT CreateInMemoryFontFileLoader(IDWriteInMemoryFontFileLoader* newLoader);
    HRESULT CreateHttpFontFileLoader(const(ushort)* referrerUrl, const(ushort)* extraHeaders, IDWriteRemoteFontFileLoader* newLoader);
    DWRITE_CONTAINER_TYPE AnalyzeContainerType(char* fileData, uint fileDataSize);
    HRESULT UnpackFontFile(DWRITE_CONTAINER_TYPE containerType, char* fileData, uint fileDataSize, IDWriteFontFileStream* unpackedFontStream);
}

struct DWRITE_FONT_AXIS_VALUE
{
    DWRITE_FONT_AXIS_TAG axisTag;
    float value;
}

struct DWRITE_FONT_AXIS_RANGE
{
    DWRITE_FONT_AXIS_TAG axisTag;
    float minValue;
    float maxValue;
}

enum DWRITE_FONT_FAMILY_MODEL
{
    DWRITE_FONT_FAMILY_MODEL_TYPOGRAPHIC = 0,
    DWRITE_FONT_FAMILY_MODEL_WEIGHT_STRETCH_STYLE = 1,
}

enum DWRITE_AUTOMATIC_FONT_AXES
{
    DWRITE_AUTOMATIC_FONT_AXES_NONE = 0,
    DWRITE_AUTOMATIC_FONT_AXES_OPTICAL_SIZE = 1,
}

enum DWRITE_FONT_AXIS_ATTRIBUTES
{
    DWRITE_FONT_AXIS_ATTRIBUTES_NONE = 0,
    DWRITE_FONT_AXIS_ATTRIBUTES_VARIABLE = 1,
    DWRITE_FONT_AXIS_ATTRIBUTES_HIDDEN = 2,
}

const GUID IID_IDWriteFactory6 = {0xF3744D80, 0x21F7, 0x42EB, [0xB3, 0x5D, 0x99, 0x5B, 0xC7, 0x2F, 0xC2, 0x23]};
@GUID(0xF3744D80, 0x21F7, 0x42EB, [0xB3, 0x5D, 0x99, 0x5B, 0xC7, 0x2F, 0xC2, 0x23]);
interface IDWriteFactory6 : IDWriteFactory5
{
    HRESULT CreateFontFaceReference(IDWriteFontFile fontFile, uint faceIndex, DWRITE_FONT_SIMULATIONS fontSimulations, char* fontAxisValues, uint fontAxisValueCount, IDWriteFontFaceReference1* fontFaceReference);
    HRESULT CreateFontResource(IDWriteFontFile fontFile, uint faceIndex, IDWriteFontResource* fontResource);
    HRESULT GetSystemFontSet(BOOL includeDownloadableFonts, IDWriteFontSet1* fontSet);
    HRESULT GetSystemFontCollection(BOOL includeDownloadableFonts, DWRITE_FONT_FAMILY_MODEL fontFamilyModel, IDWriteFontCollection2* fontCollection);
    HRESULT CreateFontCollectionFromFontSet(IDWriteFontSet fontSet, DWRITE_FONT_FAMILY_MODEL fontFamilyModel, IDWriteFontCollection2* fontCollection);
    HRESULT CreateFontSetBuilder(IDWriteFontSetBuilder2* fontSetBuilder);
    HRESULT CreateTextFormat(const(wchar)* fontFamilyName, IDWriteFontCollection fontCollection, char* fontAxisValues, uint fontAxisValueCount, float fontSize, const(wchar)* localeName, IDWriteTextFormat3* textFormat);
}

const GUID IID_IDWriteFontFace5 = {0x98EFF3A5, 0xB667, 0x479A, [0xB1, 0x45, 0xE2, 0xFA, 0x5B, 0x9F, 0xDC, 0x29]};
@GUID(0x98EFF3A5, 0xB667, 0x479A, [0xB1, 0x45, 0xE2, 0xFA, 0x5B, 0x9F, 0xDC, 0x29]);
interface IDWriteFontFace5 : IDWriteFontFace4
{
    uint GetFontAxisValueCount();
    HRESULT GetFontAxisValues(char* fontAxisValues, uint fontAxisValueCount);
    BOOL HasVariations();
    HRESULT GetFontResource(IDWriteFontResource* fontResource);
    BOOL Equals(IDWriteFontFace fontFace);
}

const GUID IID_IDWriteFontResource = {0x1F803A76, 0x6871, 0x48E8, [0x98, 0x7F, 0xB9, 0x75, 0x55, 0x1C, 0x50, 0xF2]};
@GUID(0x1F803A76, 0x6871, 0x48E8, [0x98, 0x7F, 0xB9, 0x75, 0x55, 0x1C, 0x50, 0xF2]);
interface IDWriteFontResource : IUnknown
{
    HRESULT GetFontFile(IDWriteFontFile* fontFile);
    uint GetFontFaceIndex();
    uint GetFontAxisCount();
    HRESULT GetDefaultFontAxisValues(char* fontAxisValues, uint fontAxisValueCount);
    HRESULT GetFontAxisRanges(char* fontAxisRanges, uint fontAxisRangeCount);
    DWRITE_FONT_AXIS_ATTRIBUTES GetFontAxisAttributes(uint axisIndex);
    HRESULT GetAxisNames(uint axisIndex, IDWriteLocalizedStrings* names);
    uint GetAxisValueNameCount(uint axisIndex);
    HRESULT GetAxisValueNames(uint axisIndex, uint axisValueIndex, DWRITE_FONT_AXIS_RANGE* fontAxisRange, IDWriteLocalizedStrings* names);
    BOOL HasVariations();
    HRESULT CreateFontFace(DWRITE_FONT_SIMULATIONS fontSimulations, char* fontAxisValues, uint fontAxisValueCount, IDWriteFontFace5* fontFace);
    HRESULT CreateFontFaceReference(DWRITE_FONT_SIMULATIONS fontSimulations, char* fontAxisValues, uint fontAxisValueCount, IDWriteFontFaceReference1* fontFaceReference);
}

const GUID IID_IDWriteFontFaceReference1 = {0xC081FE77, 0x2FD1, 0x41AC, [0xA5, 0xA3, 0x34, 0x98, 0x3C, 0x4B, 0xA6, 0x1A]};
@GUID(0xC081FE77, 0x2FD1, 0x41AC, [0xA5, 0xA3, 0x34, 0x98, 0x3C, 0x4B, 0xA6, 0x1A]);
interface IDWriteFontFaceReference1 : IDWriteFontFaceReference
{
    HRESULT CreateFontFace(IDWriteFontFace5* fontFace);
    uint GetFontAxisValueCount();
    HRESULT GetFontAxisValues(char* fontAxisValues, uint fontAxisValueCount);
}

const GUID IID_IDWriteFontSetBuilder2 = {0xEE5BA612, 0xB131, 0x463C, [0x8F, 0x4F, 0x31, 0x89, 0xB9, 0x40, 0x1E, 0x45]};
@GUID(0xEE5BA612, 0xB131, 0x463C, [0x8F, 0x4F, 0x31, 0x89, 0xB9, 0x40, 0x1E, 0x45]);
interface IDWriteFontSetBuilder2 : IDWriteFontSetBuilder1
{
    HRESULT AddFont(IDWriteFontFile fontFile, uint fontFaceIndex, DWRITE_FONT_SIMULATIONS fontSimulations, char* fontAxisValues, uint fontAxisValueCount, char* fontAxisRanges, uint fontAxisRangeCount, char* properties, uint propertyCount);
    HRESULT AddFontFile(const(wchar)* filePath);
}

const GUID IID_IDWriteFontSet1 = {0x7E9FDA85, 0x6C92, 0x4053, [0xBC, 0x47, 0x7A, 0xE3, 0x53, 0x0D, 0xB4, 0xD3]};
@GUID(0x7E9FDA85, 0x6C92, 0x4053, [0xBC, 0x47, 0x7A, 0xE3, 0x53, 0x0D, 0xB4, 0xD3]);
interface IDWriteFontSet1 : IDWriteFontSet
{
    HRESULT GetMatchingFonts(const(DWRITE_FONT_PROPERTY)* fontProperty, char* fontAxisValues, uint fontAxisValueCount, IDWriteFontSet1* matchingFonts);
    HRESULT GetFirstFontResources(IDWriteFontSet1* filteredFontSet);
    HRESULT GetFilteredFonts(char* properties, uint propertyCount, BOOL selectAnyProperty, IDWriteFontSet1* filteredFontSet);
    HRESULT GetFilteredFonts(char* fontAxisRanges, uint fontAxisRangeCount, BOOL selectAnyRange, IDWriteFontSet1* filteredFontSet);
    HRESULT GetFilteredFonts(char* indices, uint indexCount, IDWriteFontSet1* filteredFontSet);
    HRESULT GetFilteredFontIndices(char* properties, uint propertyCount, BOOL selectAnyProperty, char* indices, uint maxIndexCount, uint* actualIndexCount);
    HRESULT GetFilteredFontIndices(char* fontAxisRanges, uint fontAxisRangeCount, BOOL selectAnyRange, char* indices, uint maxIndexCount, uint* actualIndexCount);
    HRESULT GetFontAxisRanges(char* fontAxisRanges, uint maxFontAxisRangeCount, uint* actualFontAxisRangeCount);
    HRESULT GetFontAxisRanges(uint listIndex, char* fontAxisRanges, uint maxFontAxisRangeCount, uint* actualFontAxisRangeCount);
    HRESULT GetFontFaceReference(uint listIndex, IDWriteFontFaceReference1* fontFaceReference);
    HRESULT CreateFontResource(uint listIndex, IDWriteFontResource* fontResource);
    HRESULT CreateFontFace(uint listIndex, IDWriteFontFace5* fontFace);
    DWRITE_LOCALITY GetFontLocality(uint listIndex);
}

const GUID IID_IDWriteFontList2 = {0xC0763A34, 0x77AF, 0x445A, [0xB7, 0x35, 0x08, 0xC3, 0x7B, 0x0A, 0x5B, 0xF5]};
@GUID(0xC0763A34, 0x77AF, 0x445A, [0xB7, 0x35, 0x08, 0xC3, 0x7B, 0x0A, 0x5B, 0xF5]);
interface IDWriteFontList2 : IDWriteFontList1
{
    HRESULT GetFontSet(IDWriteFontSet1* fontSet);
}

const GUID IID_IDWriteFontFamily2 = {0x3ED49E77, 0xA398, 0x4261, [0xB9, 0xCF, 0xC1, 0x26, 0xC2, 0x13, 0x1E, 0xF3]};
@GUID(0x3ED49E77, 0xA398, 0x4261, [0xB9, 0xCF, 0xC1, 0x26, 0xC2, 0x13, 0x1E, 0xF3]);
interface IDWriteFontFamily2 : IDWriteFontFamily1
{
    HRESULT GetMatchingFonts(char* fontAxisValues, uint fontAxisValueCount, IDWriteFontList2* matchingFonts);
    HRESULT GetFontSet(IDWriteFontSet1* fontSet);
}

const GUID IID_IDWriteFontCollection2 = {0x514039C6, 0x4617, 0x4064, [0xBF, 0x8B, 0x92, 0xEA, 0x83, 0xE5, 0x06, 0xE0]};
@GUID(0x514039C6, 0x4617, 0x4064, [0xBF, 0x8B, 0x92, 0xEA, 0x83, 0xE5, 0x06, 0xE0]);
interface IDWriteFontCollection2 : IDWriteFontCollection1
{
    HRESULT GetFontFamily(uint index, IDWriteFontFamily2* fontFamily);
    HRESULT GetMatchingFonts(const(wchar)* familyName, char* fontAxisValues, uint fontAxisValueCount, IDWriteFontList2* fontList);
    DWRITE_FONT_FAMILY_MODEL GetFontFamilyModel();
    HRESULT GetFontSet(IDWriteFontSet1* fontSet);
}

const GUID IID_IDWriteTextLayout4 = {0x05A9BF42, 0x223F, 0x4441, [0xB5, 0xFB, 0x82, 0x63, 0x68, 0x5F, 0x55, 0xE9]};
@GUID(0x05A9BF42, 0x223F, 0x4441, [0xB5, 0xFB, 0x82, 0x63, 0x68, 0x5F, 0x55, 0xE9]);
interface IDWriteTextLayout4 : IDWriteTextLayout3
{
    HRESULT SetFontAxisValues(char* fontAxisValues, uint fontAxisValueCount, DWRITE_TEXT_RANGE textRange);
    uint GetFontAxisValueCount(uint currentPosition);
    HRESULT GetFontAxisValues(uint currentPosition, char* fontAxisValues, uint fontAxisValueCount, DWRITE_TEXT_RANGE* textRange);
    DWRITE_AUTOMATIC_FONT_AXES GetAutomaticFontAxes();
    HRESULT SetAutomaticFontAxes(DWRITE_AUTOMATIC_FONT_AXES automaticFontAxes);
}

const GUID IID_IDWriteTextFormat3 = {0x6D3B5641, 0xE550, 0x430D, [0xA8, 0x5B, 0xB7, 0xBF, 0x48, 0xA9, 0x34, 0x27]};
@GUID(0x6D3B5641, 0xE550, 0x430D, [0xA8, 0x5B, 0xB7, 0xBF, 0x48, 0xA9, 0x34, 0x27]);
interface IDWriteTextFormat3 : IDWriteTextFormat2
{
    HRESULT SetFontAxisValues(char* fontAxisValues, uint fontAxisValueCount);
    uint GetFontAxisValueCount();
    HRESULT GetFontAxisValues(char* fontAxisValues, uint fontAxisValueCount);
    DWRITE_AUTOMATIC_FONT_AXES GetAutomaticFontAxes();
    HRESULT SetAutomaticFontAxes(DWRITE_AUTOMATIC_FONT_AXES automaticFontAxes);
}

const GUID IID_IDWriteFontFallback1 = {0x2397599D, 0xDD0D, 0x4681, [0xBD, 0x6A, 0xF4, 0xF3, 0x1E, 0xAA, 0xDE, 0x77]};
@GUID(0x2397599D, 0xDD0D, 0x4681, [0xBD, 0x6A, 0xF4, 0xF3, 0x1E, 0xAA, 0xDE, 0x77]);
interface IDWriteFontFallback1 : IDWriteFontFallback
{
    HRESULT MapCharacters(IDWriteTextAnalysisSource analysisSource, uint textPosition, uint textLength, IDWriteFontCollection baseFontCollection, const(wchar)* baseFamilyName, char* fontAxisValues, uint fontAxisValueCount, uint* mappedLength, float* scale, IDWriteFontFace5* mappedFontFace);
}

const GUID IID_IDWriteFontSet2 = {0xDC7EAD19, 0xE54C, 0x43AF, [0xB2, 0xDA, 0x4E, 0x2B, 0x79, 0xBA, 0x3F, 0x7F]};
@GUID(0xDC7EAD19, 0xE54C, 0x43AF, [0xB2, 0xDA, 0x4E, 0x2B, 0x79, 0xBA, 0x3F, 0x7F]);
interface IDWriteFontSet2 : IDWriteFontSet1
{
    HANDLE GetExpirationEvent();
}

const GUID IID_IDWriteFontCollection3 = {0xA4D055A6, 0xF9E3, 0x4E25, [0x93, 0xB7, 0x9E, 0x30, 0x9F, 0x3A, 0xF8, 0xE9]};
@GUID(0xA4D055A6, 0xF9E3, 0x4E25, [0x93, 0xB7, 0x9E, 0x30, 0x9F, 0x3A, 0xF8, 0xE9]);
interface IDWriteFontCollection3 : IDWriteFontCollection2
{
    HANDLE GetExpirationEvent();
}

const GUID IID_IDWriteFactory7 = {0x35D0E0B3, 0x9076, 0x4D2E, [0xA0, 0x16, 0xA9, 0x1B, 0x56, 0x8A, 0x06, 0xB4]};
@GUID(0x35D0E0B3, 0x9076, 0x4D2E, [0xA0, 0x16, 0xA9, 0x1B, 0x56, 0x8A, 0x06, 0xB4]);
interface IDWriteFactory7 : IDWriteFactory6
{
    HRESULT GetSystemFontSet(BOOL includeDownloadableFonts, IDWriteFontSet2* fontSet);
    HRESULT GetSystemFontCollection(BOOL includeDownloadableFonts, DWRITE_FONT_FAMILY_MODEL fontFamilyModel, IDWriteFontCollection3* fontCollection);
}

enum DWRITE_FONT_SOURCE_TYPE
{
    DWRITE_FONT_SOURCE_TYPE_UNKNOWN = 0,
    DWRITE_FONT_SOURCE_TYPE_PER_MACHINE = 1,
    DWRITE_FONT_SOURCE_TYPE_PER_USER = 2,
    DWRITE_FONT_SOURCE_TYPE_APPX_PACKAGE = 3,
    DWRITE_FONT_SOURCE_TYPE_REMOTE_FONT_PROVIDER = 4,
}

const GUID IID_IDWriteFontSet3 = {0x7C073EF2, 0xA7F4, 0x4045, [0x8C, 0x32, 0x8A, 0xB8, 0xAE, 0x64, 0x0F, 0x90]};
@GUID(0x7C073EF2, 0xA7F4, 0x4045, [0x8C, 0x32, 0x8A, 0xB8, 0xAE, 0x64, 0x0F, 0x90]);
interface IDWriteFontSet3 : IDWriteFontSet2
{
    DWRITE_FONT_SOURCE_TYPE GetFontSourceType(uint fontIndex);
    uint GetFontSourceNameLength(uint listIndex);
    HRESULT GetFontSourceName(uint listIndex, char* stringBuffer, uint stringBufferSize);
}

enum DWRITE_MEASURING_MODE
{
    DWRITE_MEASURING_MODE_NATURAL = 0,
    DWRITE_MEASURING_MODE_GDI_CLASSIC = 1,
    DWRITE_MEASURING_MODE_GDI_NATURAL = 2,
}

enum DWRITE_GLYPH_IMAGE_FORMATS
{
    DWRITE_GLYPH_IMAGE_FORMATS_NONE = 0,
    DWRITE_GLYPH_IMAGE_FORMATS_TRUETYPE = 1,
    DWRITE_GLYPH_IMAGE_FORMATS_CFF = 2,
    DWRITE_GLYPH_IMAGE_FORMATS_COLR = 4,
    DWRITE_GLYPH_IMAGE_FORMATS_SVG = 8,
    DWRITE_GLYPH_IMAGE_FORMATS_PNG = 16,
    DWRITE_GLYPH_IMAGE_FORMATS_JPEG = 32,
    DWRITE_GLYPH_IMAGE_FORMATS_TIFF = 64,
    DWRITE_GLYPH_IMAGE_FORMATS_PREMULTIPLIED_B8G8R8A8 = 128,
}

