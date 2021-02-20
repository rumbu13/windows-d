// Written in the D programming language.

module windows.directwrite;

public import windows.core;
public import windows.com : HRESULT, IUnknown;
public import windows.direct2d : D2D_POINT_2F, D2D_SIZE_U, ID2D1SimplifiedGeometrySink;
public import windows.displaydevices : POINT, RECT, SIZE;
public import windows.dxgi : DXGI_RGBA;
public import windows.gdi : HDC, HMONITOR;
public import windows.intl : FONTSIGNATURE;
public import windows.shell : LOGFONTA, LOGFONTW;
public import windows.systemservices : BOOL, HANDLE, PWSTR;
public import windows.windowsprogramming : FILETIME;

extern(Windows) @nogc nothrow:


// Enums


///Defines constants that specify a four-character identifier for a font axis.
alias DWRITE_FONT_AXIS_TAG = uint;
enum : uint
{
    ///Specifies the weight axis, using the identifier 'w','g','h','t'.
    DWRITE_FONT_AXIS_TAG_WEIGHT       = 0x74686777,
    ///Specifies the width axis, using the identifier 'w','d','t','h'.
    DWRITE_FONT_AXIS_TAG_WIDTH        = 0x68746477,
    ///Specifies the slant axis, using the identifier 's','l','n','t'.
    DWRITE_FONT_AXIS_TAG_SLANT        = 0x746e6c73,
    ///Specifies the optical size axis, using the identifier 'o','p','s','z'.
    DWRITE_FONT_AXIS_TAG_OPTICAL_SIZE = 0x7a73706f,
    ///Specifies the italic axis, using the identifier 'i','t','a','l'.
    DWRITE_FONT_AXIS_TAG_ITALIC       = 0x6c617469,
}

///The type of a font represented by a single font file. Font formats that consist of multiple files, for example Type 1
///.PFM and .PFB, have separate enum values for each of the file types.
alias DWRITE_FONT_FILE_TYPE = int;
enum : int
{
    ///Font type is not recognized by the DirectWrite font system.
    DWRITE_FONT_FILE_TYPE_UNKNOWN             = 0x00000000,
    ///OpenType font with CFF outlines.
    DWRITE_FONT_FILE_TYPE_CFF                 = 0x00000001,
    ///OpenType font with TrueType outlines.
    DWRITE_FONT_FILE_TYPE_TRUETYPE            = 0x00000002,
    DWRITE_FONT_FILE_TYPE_OPENTYPE_COLLECTION = 0x00000003,
    ///Type 1 PFM font.
    DWRITE_FONT_FILE_TYPE_TYPE1_PFM           = 0x00000004,
    ///Type 1 PFB font.
    DWRITE_FONT_FILE_TYPE_TYPE1_PFB           = 0x00000005,
    ///Vector .FON font.
    DWRITE_FONT_FILE_TYPE_VECTOR              = 0x00000006,
    ///Bitmap .FON font.
    DWRITE_FONT_FILE_TYPE_BITMAP              = 0x00000007,
    DWRITE_FONT_FILE_TYPE_TRUETYPE_COLLECTION = 0x00000003,
}

///Indicates the file format of a complete font face.
alias DWRITE_FONT_FACE_TYPE = int;
enum : int
{
    ///OpenType font face with CFF outlines.
    DWRITE_FONT_FACE_TYPE_CFF                 = 0x00000000,
    ///OpenType font face with TrueType outlines.
    DWRITE_FONT_FACE_TYPE_TRUETYPE            = 0x00000001,
    DWRITE_FONT_FACE_TYPE_OPENTYPE_COLLECTION = 0x00000002,
    ///A Type 1 font face.
    DWRITE_FONT_FACE_TYPE_TYPE1               = 0x00000003,
    ///A vector .FON format font face.
    DWRITE_FONT_FACE_TYPE_VECTOR              = 0x00000004,
    ///A bitmap .FON format font face.
    DWRITE_FONT_FACE_TYPE_BITMAP              = 0x00000005,
    ///Font face type is not recognized by the DirectWrite font system.
    DWRITE_FONT_FACE_TYPE_UNKNOWN             = 0x00000006,
    ///The font data includes only the CFF table from an OpenType CFF font. This font face type can be used only for
    ///embedded fonts (i.e., custom font file loaders) and the resulting font face object supports only the minimum
    ///functionality necessary to render glyphs.
    DWRITE_FONT_FACE_TYPE_RAW_CFF             = 0x00000007,
    ///OpenType font face that is a part of a TrueType collection.
    DWRITE_FONT_FACE_TYPE_TRUETYPE_COLLECTION = 0x00000002,
}

///Specifies algorithmic style simulations to be applied to the font face. Bold and oblique simulations can be combined
///via bitwise OR operation.
alias DWRITE_FONT_SIMULATIONS = int;
enum : int
{
    ///Indicates that no simulations are applied to the font face.
    DWRITE_FONT_SIMULATIONS_NONE    = 0x00000000,
    ///Indicates that algorithmic emboldening is applied to the font face. DWRITE_FONT_SIMULATIONS_BOLD increases weight
    ///by applying a widening algorithm to the glyph outline. This may be used to simulate a bold weight where no
    ///designed bold weight is available.
    DWRITE_FONT_SIMULATIONS_BOLD    = 0x00000001,
    ///Indicates that algorithmic italicization is applied to the font face. DWRITE_FONT_SIMULATIONS_OBLIQUE applies
    ///obliquing (shear) to the glyph outline. This may be used to simulate an oblique/italic style where no designed
    ///oblique/italic style is available.
    DWRITE_FONT_SIMULATIONS_OBLIQUE = 0x00000002,
}

///Represents the density of a typeface, in terms of the lightness or heaviness of the strokes. The enumerated values
///correspond to the usWeightClass definition in the OpenType specification. The <i>usWeightClass</i> represents an
///integer value between 1 and 999. Lower values indicate lighter weights; higher values indicate heavier weights.
alias DWRITE_FONT_WEIGHT = int;
enum : int
{
    ///Predefined font weight : Thin (100).
    DWRITE_FONT_WEIGHT_THIN        = 0x00000064,
    ///Predefined font weight : Extra-light (200).
    DWRITE_FONT_WEIGHT_EXTRA_LIGHT = 0x000000c8,
    ///Predefined font weight : Ultra-light (200).
    DWRITE_FONT_WEIGHT_ULTRA_LIGHT = 0x000000c8,
    ///Predefined font weight : Light (300).
    DWRITE_FONT_WEIGHT_LIGHT       = 0x0000012c,
    ///Predefined font weight : Semi-Light (350).
    DWRITE_FONT_WEIGHT_SEMI_LIGHT  = 0x0000015e,
    ///Predefined font weight : Normal (400).
    DWRITE_FONT_WEIGHT_NORMAL      = 0x00000190,
    ///Predefined font weight : Regular (400).
    DWRITE_FONT_WEIGHT_REGULAR     = 0x00000190,
    ///Predefined font weight : Medium (500).
    DWRITE_FONT_WEIGHT_MEDIUM      = 0x000001f4,
    ///Predefined font weight : Demi-bold (600).
    DWRITE_FONT_WEIGHT_DEMI_BOLD   = 0x00000258,
    ///Predefined font weight : Semi-bold (600).
    DWRITE_FONT_WEIGHT_SEMI_BOLD   = 0x00000258,
    ///Predefined font weight : Bold (700).
    DWRITE_FONT_WEIGHT_BOLD        = 0x000002bc,
    ///Predefined font weight : Extra-bold (800).
    DWRITE_FONT_WEIGHT_EXTRA_BOLD  = 0x00000320,
    ///Predefined font weight : Ultra-bold (800).
    DWRITE_FONT_WEIGHT_ULTRA_BOLD  = 0x00000320,
    ///Predefined font weight : Black (900).
    DWRITE_FONT_WEIGHT_BLACK       = 0x00000384,
    ///Predefined font weight : Heavy (900).
    DWRITE_FONT_WEIGHT_HEAVY       = 0x00000384,
    ///Predefined font weight : Extra-black (950).
    DWRITE_FONT_WEIGHT_EXTRA_BLACK = 0x000003b6,
    ///Predefined font weight : Ultra-black (950).
    DWRITE_FONT_WEIGHT_ULTRA_BLACK = 0x000003b6,
}

///Represents the degree to which a font has been stretched compared to a font's normal aspect ratio.The enumerated
///values correspond to the <i>usWidthClass</i> definition in the OpenType specification. The usWidthClass represents an
///integer value between 1 and 9—lower values indicate narrower widths; higher values indicate wider widths.
alias DWRITE_FONT_STRETCH = int;
enum : int
{
    ///Predefined font stretch : Not known (0).
    DWRITE_FONT_STRETCH_UNDEFINED       = 0x00000000,
    ///Predefined font stretch : Ultra-condensed (1).
    DWRITE_FONT_STRETCH_ULTRA_CONDENSED = 0x00000001,
    ///Predefined font stretch : Extra-condensed (2).
    DWRITE_FONT_STRETCH_EXTRA_CONDENSED = 0x00000002,
    ///Predefined font stretch : Condensed (3).
    DWRITE_FONT_STRETCH_CONDENSED       = 0x00000003,
    ///Predefined font stretch : Semi-condensed (4).
    DWRITE_FONT_STRETCH_SEMI_CONDENSED  = 0x00000004,
    ///Predefined font stretch : Normal (5).
    DWRITE_FONT_STRETCH_NORMAL          = 0x00000005,
    ///Predefined font stretch : Medium (5).
    DWRITE_FONT_STRETCH_MEDIUM          = 0x00000005,
    ///Predefined font stretch : Semi-expanded (6).
    DWRITE_FONT_STRETCH_SEMI_EXPANDED   = 0x00000006,
    ///Predefined font stretch : Expanded (7).
    DWRITE_FONT_STRETCH_EXPANDED        = 0x00000007,
    ///Predefined font stretch : Extra-expanded (8).
    DWRITE_FONT_STRETCH_EXTRA_EXPANDED  = 0x00000008,
    ///Predefined font stretch : Ultra-expanded (9).
    DWRITE_FONT_STRETCH_ULTRA_EXPANDED  = 0x00000009,
}

///Represents the style of a font face as normal, italic, or oblique.
alias DWRITE_FONT_STYLE = int;
enum : int
{
    ///Font style : Normal.
    DWRITE_FONT_STYLE_NORMAL  = 0x00000000,
    ///Font style : Oblique.
    DWRITE_FONT_STYLE_OBLIQUE = 0x00000001,
    ///Font style : Italic.
    DWRITE_FONT_STYLE_ITALIC  = 0x00000002,
}

///The informational string enumeration which identifies a string embedded in a font file.
alias DWRITE_INFORMATIONAL_STRING_ID = int;
enum : int
{
    ///Indicates the string containing the unspecified name ID.
    DWRITE_INFORMATIONAL_STRING_NONE                             = 0x00000000,
    ///Indicates the string containing the copyright notice provided by the font.
    DWRITE_INFORMATIONAL_STRING_COPYRIGHT_NOTICE                 = 0x00000001,
    ///Indicates the string containing a version number.
    DWRITE_INFORMATIONAL_STRING_VERSION_STRINGS                  = 0x00000002,
    ///Indicates the string containing the trademark information provided by the font.
    DWRITE_INFORMATIONAL_STRING_TRADEMARK                        = 0x00000003,
    ///Indicates the string containing the name of the font manufacturer.
    DWRITE_INFORMATIONAL_STRING_MANUFACTURER                     = 0x00000004,
    ///Indicates the string containing the name of the font designer.
    DWRITE_INFORMATIONAL_STRING_DESIGNER                         = 0x00000005,
    ///Indicates the string containing the URL of the font designer (with protocol, e.g., http://, ftp://).
    DWRITE_INFORMATIONAL_STRING_DESIGNER_URL                     = 0x00000006,
    ///Indicates the string containing the description of the font. This may also contain revision information, usage
    ///recommendations, history, features, and so on.
    DWRITE_INFORMATIONAL_STRING_DESCRIPTION                      = 0x00000007,
    ///Indicates the string containing the URL of the font vendor (with protocol, e.g., http://, ftp://). If a unique
    ///serial number is embedded in the URL, it can be used to register the font.
    DWRITE_INFORMATIONAL_STRING_FONT_VENDOR_URL                  = 0x00000008,
    ///Indicates the string containing the description of how the font may be legally used, or different example
    ///scenarios for licensed use.
    DWRITE_INFORMATIONAL_STRING_LICENSE_DESCRIPTION              = 0x00000009,
    ///Indicates the string containing the URL where additional licensing information can be found.
    DWRITE_INFORMATIONAL_STRING_LICENSE_INFO_URL                 = 0x0000000a,
    ///Indicates the string containing the GDI-compatible family name. Since GDI allows a maximum of four fonts per
    ///family, fonts in the same family may have different GDI-compatible family names (e.g., "Arial", "Arial Narrow",
    ///"Arial Black").
    DWRITE_INFORMATIONAL_STRING_WIN32_FAMILY_NAMES               = 0x0000000b,
    ///Indicates the string containing a GDI-compatible subfamily name.
    DWRITE_INFORMATIONAL_STRING_WIN32_SUBFAMILY_NAMES            = 0x0000000c,
    DWRITE_INFORMATIONAL_STRING_TYPOGRAPHIC_FAMILY_NAMES         = 0x0000000d,
    DWRITE_INFORMATIONAL_STRING_TYPOGRAPHIC_SUBFAMILY_NAMES      = 0x0000000e,
    ///Contains sample text for display in font lists. This can be the font name or any other text that the designer
    ///thinks is the best example to display the font in.
    DWRITE_INFORMATIONAL_STRING_SAMPLE_TEXT                      = 0x0000000f,
    ///The full name of the font, like Arial Bold, from <i>name id 4</i> in the name table
    DWRITE_INFORMATIONAL_STRING_FULL_NAME                        = 0x00000010,
    ///The postscript name of the font, like GillSans-Bold, from <i>name id 6</i> in the name table.
    DWRITE_INFORMATIONAL_STRING_POSTSCRIPT_NAME                  = 0x00000011,
    ///The postscript CID findfont name, from <i>name id 20</i> in the name table
    DWRITE_INFORMATIONAL_STRING_POSTSCRIPT_CID_NAME              = 0x00000012,
    DWRITE_INFORMATIONAL_STRING_WEIGHT_STRETCH_STYLE_FAMILY_NAME = 0x00000013,
    DWRITE_INFORMATIONAL_STRING_DESIGN_SCRIPT_LANGUAGE_TAG       = 0x00000014,
    DWRITE_INFORMATIONAL_STRING_SUPPORTED_SCRIPT_LANGUAGE_TAG    = 0x00000015,
    ///Indicates the string containing the family name preferred by the designer. This enables font designers to group
    ///more than four fonts in a single family without losing compatibility with GDI. This name is typically only
    ///present if it differs from the GDI-compatible family name.
    DWRITE_INFORMATIONAL_STRING_PREFERRED_FAMILY_NAMES           = 0x0000000d,
    ///Indicates the string containing the subfamily name preferred by the designer. This name is typically only present
    ///if it differs from the GDI-compatible subfamily name.
    DWRITE_INFORMATIONAL_STRING_PREFERRED_SUBFAMILY_NAMES        = 0x0000000e,
    DWRITE_INFORMATIONAL_STRING_WWS_FAMILY_NAME                  = 0x00000013,
}

///Specifies the type of DirectWrite factory object.
alias DWRITE_FACTORY_TYPE = int;
enum : int
{
    ///Indicates that the DirectWrite factory is a shared factory and that it allows for the reuse of cached font data
    ///across multiple in-process components. Such factories also take advantage of cross process font caching
    ///components for better performance.
    DWRITE_FACTORY_TYPE_SHARED   = 0x00000000,
    ///Indicates that the DirectWrite factory object is isolated. Objects created from the isolated factory do not
    ///interact with internal DirectWrite state from other components.
    DWRITE_FACTORY_TYPE_ISOLATED = 0x00000001,
}

///Represents the internal structure of a device pixel (that is, the physical arrangement of red, green, and blue color
///components) that is assumed for purposes of rendering text.
alias DWRITE_PIXEL_GEOMETRY = int;
enum : int
{
    ///The red, green, and blue color components of each pixel are assumed to occupy the same point.
    DWRITE_PIXEL_GEOMETRY_FLAT = 0x00000000,
    ///Each pixel is composed of three vertical stripes, with red on the left, green in the center, and blue on the
    ///right. This is the most common pixel geometry for LCD monitors.
    DWRITE_PIXEL_GEOMETRY_RGB  = 0x00000001,
    DWRITE_PIXEL_GEOMETRY_BGR  = 0x00000002,
}

///Represents a method of rendering glyphs. <div class="alert"><b>Note</b> This topic is about
///<b>DWRITE_RENDERING_MODE</b> in Windows 8 and later. For info on the previous version see the Remarks section.
///</div><div> </div>
alias DWRITE_RENDERING_MODE = int;
enum : int
{
    ///Specifies that the rendering mode is determined automatically, based on the font and size.
    DWRITE_RENDERING_MODE_DEFAULT                     = 0x00000000,
    ///Specifies that no anti-aliasing is performed. Each pixel is either set to the foreground color of the text or
    ///retains the color of the background.
    DWRITE_RENDERING_MODE_ALIASED                     = 0x00000001,
    ///Specifies that antialiasing is performed in the horizontal direction and the appearance of glyphs is
    ///layout-compatible with GDI using CLEARTYPE_QUALITY. Use DWRITE_MEASURING_MODE_GDI_CLASSIC to get glyph advances.
    ///The antialiasing may be either ClearType or grayscale depending on the text antialiasing mode.
    DWRITE_RENDERING_MODE_GDI_CLASSIC                 = 0x00000002,
    ///Specifies that antialiasing is performed in the horizontal direction and the appearance of glyphs is
    ///layout-compatible with GDI using CLEARTYPE_NATURAL_QUALITY. Glyph advances are close to the font design advances,
    ///but are still rounded to whole pixels. Use DWRITE_MEASURING_MODE_GDI_NATURAL to get glyph advances. The
    ///antialiasing may be either ClearType or grayscale depending on the text antialiasing mode.
    DWRITE_RENDERING_MODE_GDI_NATURAL                 = 0x00000003,
    ///Specifies that antialiasing is performed in the horizontal direction. This rendering mode allows glyphs to be
    ///positioned with subpixel precision and is therefore suitable for natural (i.e., resolution-independent) layout.
    ///The antialiasing may be either ClearType or grayscale depending on the text antialiasing mode.
    DWRITE_RENDERING_MODE_NATURAL                     = 0x00000004,
    ///Similar to natural mode except that antialiasing is performed in both the horizontal and vertical directions.
    ///This is typically used at larger sizes to make curves and diagonal lines look smoother. The antialiasing may be
    ///either ClearType or grayscale depending on the text antialiasing mode.
    DWRITE_RENDERING_MODE_NATURAL_SYMMETRIC           = 0x00000005,
    ///Specifies that rendering should bypass the rasterizer and use the outlines directly. This is typically used at
    ///very large sizes.
    DWRITE_RENDERING_MODE_OUTLINE                     = 0x00000006,
    DWRITE_RENDERING_MODE_CLEARTYPE_GDI_CLASSIC       = 0x00000002,
    DWRITE_RENDERING_MODE_CLEARTYPE_GDI_NATURAL       = 0x00000003,
    DWRITE_RENDERING_MODE_CLEARTYPE_NATURAL           = 0x00000004,
    DWRITE_RENDERING_MODE_CLEARTYPE_NATURAL_SYMMETRIC = 0x00000005,
}

///Specifies the direction in which reading progresses. <div class="alert"><b>Note</b>
///<b>DWRITE_READING_DIRECTION_TOP_TO_BOTTOM</b> and <b>DWRITE_READING_DIRECTION_BOTTOM_TO_TOP</b> are available in
///Windows 8.1 and later, only.</div><div> </div>
alias DWRITE_READING_DIRECTION = int;
enum : int
{
    ///Indicates that reading progresses from left to right.
    DWRITE_READING_DIRECTION_LEFT_TO_RIGHT = 0x00000000,
    ///Indicates that reading progresses from right to left.
    DWRITE_READING_DIRECTION_RIGHT_TO_LEFT = 0x00000001,
    ///<div class="alert"><b>Note</b> Windows 8.1 and later only.</div> <div> </div> Indicates that reading progresses
    ///from top to bottom.
    DWRITE_READING_DIRECTION_TOP_TO_BOTTOM = 0x00000002,
    DWRITE_READING_DIRECTION_BOTTOM_TO_TOP = 0x00000003,
}

///Indicates the direction of how lines of text are placed relative to one another.
alias DWRITE_FLOW_DIRECTION = int;
enum : int
{
    ///Specifies that text lines are placed from top to bottom.
    DWRITE_FLOW_DIRECTION_TOP_TO_BOTTOM = 0x00000000,
    ///Specifies that text lines are placed from bottom to top.
    DWRITE_FLOW_DIRECTION_BOTTOM_TO_TOP = 0x00000001,
    ///Specifies that text lines are placed from left to right.
    DWRITE_FLOW_DIRECTION_LEFT_TO_RIGHT = 0x00000002,
    DWRITE_FLOW_DIRECTION_RIGHT_TO_LEFT = 0x00000003,
}

///Specifies the alignment of paragraph text along the reading direction axis, relative to the leading and trailing edge
///of the layout box.
alias DWRITE_TEXT_ALIGNMENT = int;
enum : int
{
    ///The leading edge of the paragraph text is aligned to the leading edge of the layout box.
    DWRITE_TEXT_ALIGNMENT_LEADING   = 0x00000000,
    ///The trailing edge of the paragraph text is aligned to the trailing edge of the layout box.
    DWRITE_TEXT_ALIGNMENT_TRAILING  = 0x00000001,
    ///The center of the paragraph text is aligned to the center of the layout box.
    DWRITE_TEXT_ALIGNMENT_CENTER    = 0x00000002,
    DWRITE_TEXT_ALIGNMENT_JUSTIFIED = 0x00000003,
}

///Specifies the alignment of paragraph text along the flow direction axis, relative to the top and bottom of the flow's
///layout box.
alias DWRITE_PARAGRAPH_ALIGNMENT = int;
enum : int
{
    ///The top of the text flow is aligned to the top edge of the layout box.
    DWRITE_PARAGRAPH_ALIGNMENT_NEAR   = 0x00000000,
    ///The bottom of the text flow is aligned to the bottom edge of the layout box.
    DWRITE_PARAGRAPH_ALIGNMENT_FAR    = 0x00000001,
    DWRITE_PARAGRAPH_ALIGNMENT_CENTER = 0x00000002,
}

///Specifies the word wrapping to be used in a particular multiline paragraph. <div class="alert"><b>Note</b>
///<b>DWRITE_WORD_WRAPPING_EMERGENCY_BREAK</b>, <b>DWRITE_WORD_WRAPPING_WHOLE _WORD</b>, and
///<b>DWRITE_WORD_WRAPPING_CHARACTER</b> are available in Windows 8.1 and later, only.</div><div> </div>
alias DWRITE_WORD_WRAPPING = int;
enum : int
{
    ///Indicates that words are broken across lines to avoid text overflowing the layout box.
    DWRITE_WORD_WRAPPING_WRAP            = 0x00000000,
    ///Indicates that words are kept within the same line even when it overflows the layout box. This option is often
    ///used with scrolling to reveal overflow text.
    DWRITE_WORD_WRAPPING_NO_WRAP         = 0x00000001,
    ///<div class="alert"><b>Note</b> Windows 8.1 and later only.</div> <div> </div> Words are broken across lines to
    ///avoid text overflowing the layout box. Emergency wrapping occurs if the word is larger than the maximum width.
    DWRITE_WORD_WRAPPING_EMERGENCY_BREAK = 0x00000002,
    ///<div class="alert"><b>Note</b> Windows 8.1 and later only.</div> <div> </div> When emergency wrapping, only wrap
    ///whole words, never breaking words when the layout width is too small for even a single word.
    DWRITE_WORD_WRAPPING_WHOLE_WORD      = 0x00000003,
    DWRITE_WORD_WRAPPING_CHARACTER       = 0x00000004,
}

///The method used for line spacing in a text layout.
alias DWRITE_LINE_SPACING_METHOD = int;
enum : int
{
    ///Line spacing depends solely on the content, adjusting to accommodate the size of fonts and inline objects.
    DWRITE_LINE_SPACING_METHOD_DEFAULT      = 0x00000000,
    ///Lines are explicitly set to uniform spacing, regardless of the size of fonts and inline objects. This can be
    ///useful to avoid the uneven appearance that can occur from font fallback.
    DWRITE_LINE_SPACING_METHOD_UNIFORM      = 0x00000001,
    ///Line spacing and baseline distances are proportional to the computed values based on the content, the size of the
    ///fonts and inline objects. <div class="alert"><b>Note</b> This value is only available on Windows 10 or later and
    ///it can be used with IDWriteTextLayout3::SetLineSpacing, but can not be used with
    ///IDWriteTextFormat::SetLineSpacing.</div> <div> </div>
    DWRITE_LINE_SPACING_METHOD_PROPORTIONAL = 0x00000002,
}

///Specifies the text granularity used to trim text overflowing the layout box.
alias DWRITE_TRIMMING_GRANULARITY = int;
enum : int
{
    ///No trimming occurs. Text flows beyond the layout width.
    DWRITE_TRIMMING_GRANULARITY_NONE      = 0x00000000,
    ///Trimming occurs at a character cluster boundary.
    DWRITE_TRIMMING_GRANULARITY_CHARACTER = 0x00000001,
    DWRITE_TRIMMING_GRANULARITY_WORD      = 0x00000002,
}

///A value that indicates the typographic feature of text supplied by the font.
alias DWRITE_FONT_FEATURE_TAG = uint;
enum : uint
{
    ///Replaces figures separated by a slash with an alternative form. <b>Equivalent OpenType tag:</b> 'afrc'
    DWRITE_FONT_FEATURE_TAG_ALTERNATIVE_FRACTIONS            = 0x63726661,
    ///Turns capital characters into petite capitals. It is generally used for words which would otherwise be set in all
    ///caps, such as acronyms, but which are desired in petite-cap form to avoid disrupting the flow of text. See the
    ///pcap feature description for notes on the relationship of caps, smallcaps and petite caps. <b>Equivalent OpenType
    ///tag:</b> 'c2pc'
    DWRITE_FONT_FEATURE_TAG_PETITE_CAPITALS_FROM_CAPITALS    = 0x63703263,
    ///Turns capital characters into small capitals. It is generally used for words which would otherwise be set in all
    ///caps, such as acronyms, but which are desired in small-cap form to avoid disrupting the flow of text.
    ///<b>Equivalent OpenType tag:</b> 'c2sc'
    DWRITE_FONT_FEATURE_TAG_SMALL_CAPITALS_FROM_CAPITALS     = 0x63733263,
    ///In specified situations, replaces default glyphs with alternate forms which provide better joining behavior. Used
    ///in script typefaces which are designed to have some or all of their glyphs join. <b>Equivalent OpenType tag:</b>
    ///'calt'
    DWRITE_FONT_FEATURE_TAG_CONTEXTUAL_ALTERNATES            = 0x746c6163,
    ///Shifts various punctuation marks up to a position that works better with all-capital sequences or sets of lining
    ///figures; also changes oldstyle figures to lining figures. By default, glyphs in a text face are designed to work
    ///with lowercase characters. Some characters should be shifted vertically to fit the higher visual center of
    ///all-capital or lining text. Also, lining figures are the same height (or close to it) as capitals, and fit much
    ///better with all-capital text. <b>Equivalent OpenType tag:</b> 'case'
    DWRITE_FONT_FEATURE_TAG_CASE_SENSITIVE_FORMS             = 0x65736163,
    ///To minimize the number of glyph alternates, it is sometimes desired to decompose a character into two glyphs.
    ///Additionally, it may be preferable to compose two characters into a single glyph for better glyph processing.
    ///This feature permits such composition/decomposition. The feature should be processed as the first feature
    ///processed, and should be processed only when it is called. <b>Equivalent OpenType tag:</b> 'ccmp'
    DWRITE_FONT_FEATURE_TAG_GLYPH_COMPOSITION_DECOMPOSITION  = 0x706d6363,
    ///Replaces a sequence of glyphs with a single glyph which is preferred for typographic purposes. Unlike other
    ///ligature features, clig specifies the context in which the ligature is recommended. This capability is important
    ///in some script designs and for swash ligatures. <b>Equivalent OpenType tag:</b> 'clig'
    DWRITE_FONT_FEATURE_TAG_CONTEXTUAL_LIGATURES             = 0x67696c63,
    ///Globally adjusts inter-glyph spacing for all-capital text. Most typefaces contain capitals and lowercase
    ///characters, and the capitals are positioned to work with the lowercase. When capitals are used for words, they
    ///need more space between them for legibility and esthetics. This feature would not apply to monospaced designs. Of
    ///course the user may want to override this behavior in order to do more pronounced letterspacing for esthetic
    ///reasons. <b>Equivalent OpenType tag:</b> 'cpsp'
    DWRITE_FONT_FEATURE_TAG_CAPITAL_SPACING                  = 0x70737063,
    ///Replaces default character glyphs with corresponding swash glyphs in a specified context. Note that there may be
    ///more than one swash alternate for a given character. <b>Equivalent OpenType tag:</b> 'cswh'
    DWRITE_FONT_FEATURE_TAG_CONTEXTUAL_SWASH                 = 0x68777363,
    ///In cursive scripts like Arabic, this feature cursively positions adjacent glyphs. <b>Equivalent OpenType tag:</b>
    ///'curs'
    DWRITE_FONT_FEATURE_TAG_CURSIVE_POSITIONING              = 0x73727563,
    ///The default.
    DWRITE_FONT_FEATURE_TAG_DEFAULT                          = 0x746c6664,
    ///Replaces a sequence of glyphs with a single glyph which is preferred for typographic purposes. This feature
    ///covers those ligatures which may be used for special effect, at the user's preference. <b>Equivalent OpenType
    ///tag:</b> 'dlig'
    DWRITE_FONT_FEATURE_TAG_DISCRETIONARY_LIGATURES          = 0x67696c64,
    ///Replaces standard forms in Japanese fonts with corresponding forms preferred by typographers. For example, a user
    ///would invoke this feature to replace kanji character U+5516 with U+555E. <b>Equivalent OpenType tag:</b> 'expt'
    DWRITE_FONT_FEATURE_TAG_EXPERT_FORMS                     = 0x74707865,
    ///Replaces figures separated by a slash with 'common' (diagonal) fractions. <b>Equivalent OpenType tag:</b> 'frac'
    DWRITE_FONT_FEATURE_TAG_FRACTIONS                        = 0x63617266,
    ///Replaces glyphs set on other widths with glyphs set on full (usually em) widths. In a CJKV font, this may include
    ///"lower ASCII" Latin characters and various symbols. In a European font, this feature replaces
    ///proportionally-spaced glyphs with monospaced glyphs, which are generally set on widths of 0.6 em. For example, a
    ///user may invoke this feature in a Japanese font to get full monospaced Latin glyphs instead of the corresponding
    ///proportionally-spaced versions. <b>Equivalent OpenType tag:</b> 'fwid'
    DWRITE_FONT_FEATURE_TAG_FULL_WIDTH                       = 0x64697766,
    ///Produces the half forms of consonants in Indic scripts. For example, in Hindi (Devanagari script), the conjunct
    ///KKa, obtained by doubling the Ka, is denoted with a half form of Ka followed by the full form. <b>Equivalent
    ///OpenType tag:</b> 'half'
    DWRITE_FONT_FEATURE_TAG_HALF_FORMS                       = 0x666c6168,
    ///Produces the halant forms of consonants in Indic scripts. For example, in Sanskrit (Devanagari script), syllable
    ///final consonants are frequently required in their halant form. <b>Equivalent OpenType tag:</b> 'haln'
    DWRITE_FONT_FEATURE_TAG_HALANT_FORMS                     = 0x6e6c6168,
    ///Respaces glyphs designed to be set on full-em widths, fitting them onto half-em widths. This differs from hwid in
    ///that it does not substitute new glyphs. <b>Equivalent OpenType tag:</b> 'halt'
    DWRITE_FONT_FEATURE_TAG_ALTERNATE_HALF_WIDTH             = 0x746c6168,
    ///Replaces the default (current) forms with the historical alternates. While some ligatures are also used for
    ///historical effect, this feature deals only with single characters. Some fonts include the historical forms as
    ///alternates, so they can be used for a 'period' effect. <b>Equivalent OpenType tag:</b> 'hist'
    DWRITE_FONT_FEATURE_TAG_HISTORICAL_FORMS                 = 0x74736968,
    ///Replaces standard kana with forms that have been specially designed for only horizontal writing. This is a
    ///typographic optimization for improved fit and more even color. <b>Equivalent OpenType tag:</b> 'hkna'
    DWRITE_FONT_FEATURE_TAG_HORIZONTAL_KANA_ALTERNATES       = 0x616e6b68,
    ///Replaces the default (current) forms with the historical alternates. Some ligatures were in common use in the
    ///past, but appear anachronistic today. Some fonts include the historical forms as alternates, so they can be used
    ///for a 'period' effect. <b>Equivalent OpenType tag:</b> 'hlig'
    DWRITE_FONT_FEATURE_TAG_HISTORICAL_LIGATURES             = 0x67696c68,
    ///Replaces glyphs on proportional widths, or fixed widths other than half an em, with glyphs on half-em (en)
    ///widths. Many CJKV fonts have glyphs which are set on multiple widths; this feature selects the half-em version.
    ///There are various contexts in which this is the preferred behavior, including compatibility with older desktop
    ///documents. <b>Equivalent OpenType tag:</b> 'hwid'
    DWRITE_FONT_FEATURE_TAG_HALF_WIDTH                       = 0x64697768,
    ///Used to access the JIS X 0212-1990 glyphs for the cases when the JIS X 0213:2004 form is encoded. The JIS X
    ///0212-1990 (aka, "Hojo Kanji") and JIS X 0213:2004 character sets overlap significantly. In some cases their
    ///prototypical glyphs differ. When building fonts that support both JIS X 0212-1990 and JIS X 0213:2004 (such as
    ///those supporting the Adobe-Japan 1-6 character collection), it is recommended that JIS X 0213:2004 forms be the
    ///preferred encoded form. <b>Equivalent OpenType tag:</b> 'hojo'
    DWRITE_FONT_FEATURE_TAG_HOJO_KANJI_FORMS                 = 0x6f6a6f68,
    ///The National Language Council (NLC) of Japan has defined new glyph shapes for a number of JIS characters, which
    ///were incorporated into JIS X 0213:2004 as new prototypical forms. The 'jp04' feature is A subset of the 'nlck'
    ///feature, and is used to access these prototypical glyphs in a manner that maintains the integrity of JIS X
    ///0213:2004. <b>Equivalent OpenType tag:</b> 'jp04'
    DWRITE_FONT_FEATURE_TAG_JIS04_FORMS                      = 0x3430706a,
    ///Replaces default (JIS90) Japanese glyphs with the corresponding forms from the JIS C 6226-1978 (JIS78)
    ///specification. <b>Equivalent OpenType tag:</b> 'jp78'
    DWRITE_FONT_FEATURE_TAG_JIS78_FORMS                      = 0x3837706a,
    ///Replaces default (JIS90) Japanese glyphs with the corresponding forms from the JIS X 0208-1983 (JIS83)
    ///specification. <b>Equivalent OpenType tag:</b> 'jp83'
    DWRITE_FONT_FEATURE_TAG_JIS83_FORMS                      = 0x3338706a,
    ///Replaces Japanese glyphs from the JIS78 or JIS83 specifications with the corresponding forms from the JIS X
    ///0208-1990 (JIS90) specification. <b>Equivalent OpenType tag:</b> 'jp90'
    DWRITE_FONT_FEATURE_TAG_JIS90_FORMS                      = 0x3039706a,
    ///Adjusts amount of space between glyphs, generally to provide optically consistent spacing between glyphs.
    ///Although a well-designed typeface has consistent inter-glyph spacing overall, some glyph combinations require
    ///adjustment for improved legibility. Besides standard adjustment in the horizontal direction, this feature can
    ///supply size-dependent kerning data via device tables, "cross-stream" kerning in the Y text direction, and
    ///adjustment of glyph placement independent of the advance adjustment. Note that this feature may apply to runs of
    ///more than two glyphs, and would not be used in monospaced fonts. Also note that this feature does not apply to
    ///text set vertically. <b>Equivalent OpenType tag:</b> 'kern'
    DWRITE_FONT_FEATURE_TAG_KERNING                          = 0x6e72656b,
    ///Replaces a sequence of glyphs with a single glyph which is preferred for typographic purposes. This feature
    ///covers the ligatures which the designer/manufacturer judges should be used in normal conditions. <b>Equivalent
    ///OpenType tag:</b> 'liga'
    DWRITE_FONT_FEATURE_TAG_STANDARD_LIGATURES               = 0x6167696c,
    ///Changes selected figures from oldstyle to the default lining form. For example, a user may invoke this feature in
    ///order to get lining figures, which fit better with all-capital text. This feature overrides results of the
    ///Oldstyle Figures feature (onum). <b>Equivalent OpenType tag:</b> 'lnum'
    DWRITE_FONT_FEATURE_TAG_LINING_FIGURES                   = 0x6d756e6c,
    ///Enables localized forms of glyphs to be substituted for default forms. Many scripts used to write multiple
    ///languages over wide geographical areas have developed localized variant forms of specific letters, which are used
    ///by individual literary communities. For example, a number of letters in the Bulgarian and Serbian alphabets have
    ///forms distinct from their Russian counterparts and from each other. In some cases the localized form differs only
    ///subtly from the script 'norm', in others the forms are radically distinct. <b>Equivalent OpenType tag:</b> 'locl'
    DWRITE_FONT_FEATURE_TAG_LOCALIZED_FORMS                  = 0x6c636f6c,
    ///Positions mark glyphs with respect to base glyphs. For example, in Arabic script positioning the Hamza above the
    ///Yeh. <b>Equivalent OpenType tag: </b> 'mark'
    DWRITE_FONT_FEATURE_TAG_MARK_POSITIONING                 = 0x6b72616d,
    ///Replaces standard typographic forms of Greek glyphs with corresponding forms commonly used in mathematical
    ///notation (which are a subset of the Greek alphabet). <b>Equivalent OpenType tag:</b> 'mgrk'
    DWRITE_FONT_FEATURE_TAG_MATHEMATICAL_GREEK               = 0x6b72676d,
    ///Positions marks with respect to other marks. Required in various non-Latin scripts like Arabic. For example, in
    ///Arabic, the ligaturised mark Ha with Hamza above it can also be obtained by positioning these marks relative to
    ///one another. <b>Equivalent OpenType tag:</b> 'mkmk'
    DWRITE_FONT_FEATURE_TAG_MARK_TO_MARK_POSITIONING         = 0x6b6d6b6d,
    ///Replaces default glyphs with various notational forms (such as glyphs placed in open or solid circles, squares,
    ///parentheses, diamonds or rounded boxes). In some cases an annotation form may already be present, but the user
    ///may want a different one. <b>Equivalent OpenType tag:</b> 'nalt'
    DWRITE_FONT_FEATURE_TAG_ALTERNATE_ANNOTATION_FORMS       = 0x746c616e,
    ///Used to access glyphs made from glyph shapes defined by the National Language Council (NLC) of Japan for a number
    ///of JIS characters in 2000. <b>Equivalent OpenType tag:</b> 'nlck'
    DWRITE_FONT_FEATURE_TAG_NLC_KANJI_FORMS                  = 0x6b636c6e,
    ///Changes selected figures from the default lining style to oldstyle form. For example, a user may invoke this
    ///feature to get oldstyle figures, which fit better into the flow of normal upper- and lowercase text. This feature
    ///overrides results of the Lining Figures feature (lnum). <b>Equivalent OpenType tag:</b> 'onum'
    DWRITE_FONT_FEATURE_TAG_OLD_STYLE_FIGURES                = 0x6d756e6f,
    ///Replaces default alphabetic glyphs with the corresponding ordinal forms for use after figures. One exception to
    ///the follows-a-figure rule is the numero character (U+2116), which is actually a ligature substitution, but is
    ///best accessed through this feature. <b>Equivalent OpenType tag:</b> 'ordn'
    DWRITE_FONT_FEATURE_TAG_ORDINALS                         = 0x6e64726f,
    ///Respaces glyphs designed to be set on full-em widths, fitting them onto individual (more or less proportional)
    ///horizontal widths. This differs from pwid in that it does not substitute new glyphs (GPOS, not GSUB feature). The
    ///user may prefer the monospaced form, or may simply want to ensure that the glyph is well-fit and not rotated in
    ///vertical setting (Latin forms designed for proportional spacing would be rotated). <b>Equivalent OpenType
    ///tag:</b> 'palt'
    DWRITE_FONT_FEATURE_TAG_PROPORTIONAL_ALTERNATE_WIDTH     = 0x746c6170,
    ///Turns lowercase characters into petite capitals. Forms related to petite capitals, such as specially designed
    ///figures, may be included. Some fonts contain an additional size of capital letters, shorter than the regular
    ///smallcaps and it is referred to as petite caps. Such forms are most likely to be found in designs with a small
    ///lowercase x-height, where they better harmonise with lowercase text than the taller smallcaps (for examples of
    ///petite caps, see the Emigre type families Mrs Eaves and Filosofia). <b>Equivalent OpenType tag:</b> 'pcap'
    DWRITE_FONT_FEATURE_TAG_PETITE_CAPITALS                  = 0x70616370,
    ///Replaces figure glyphs set on uniform (tabular) widths with corresponding glyphs set on glyph-specific
    ///(proportional) widths. Tabular widths will generally be the default, but this cannot be safely assumed. Of course
    ///this feature would not be present in monospaced designs. <b>Equivalent OpenType tag:</b> 'pnum'
    DWRITE_FONT_FEATURE_TAG_PROPORTIONAL_FIGURES             = 0x6d756e70,
    ///Replaces glyphs set on uniform widths (typically full or half-em) with proportionally spaced glyphs. The
    ///proportional variants are often used for the Latin characters in CJKV fonts, but may also be used for Kana in
    ///Japanese fonts. <b>Equivalent OpenType tag:</b> 'pwid'
    DWRITE_FONT_FEATURE_TAG_PROPORTIONAL_WIDTHS              = 0x64697770,
    ///Replaces glyphs on other widths with glyphs set on widths of one quarter of an em (half an en). The characters
    ///involved are normally figures and some forms of punctuation. <b>Equivalent OpenType tag:</b> 'qwid'
    DWRITE_FONT_FEATURE_TAG_QUARTER_WIDTHS                   = 0x64697771,
    ///Replaces a sequence of glyphs with a single glyph which is preferred for typographic purposes. This feature
    ///covers those ligatures, which the script determines as required to be used in normal conditions. This feature is
    ///important for some scripts to ensure correct glyph formation. <b>Equivalent OpenType tag:</b> 'rlig'
    DWRITE_FONT_FEATURE_TAG_REQUIRED_LIGATURES               = 0x67696c72,
    ///Identifies glyphs in the font which have been designed for "ruby", from the old typesetting term for
    ///four-point-sized type. Japanese typesetting often uses smaller kana glyphs, generally in superscripted form, to
    ///clarify the meaning of kanji which may be unfamiliar to the reader. <b>Equivalent OpenType tag:</b> 'ruby'
    DWRITE_FONT_FEATURE_TAG_RUBY_NOTATION_FORMS              = 0x79627572,
    ///Replaces the default forms with the stylistic alternates. Many fonts contain alternate glyph designs for a purely
    ///esthetic effect; these don't always fit into a clear category like swash or historical. As in the case of swash
    ///glyphs, there may be more than one alternate form. <b>Equivalent OpenType tag:</b> 'salt'
    DWRITE_FONT_FEATURE_TAG_STYLISTIC_ALTERNATES             = 0x746c6173,
    ///Replaces lining or oldstyle figures with inferior figures (smaller glyphs which sit lower than the standard
    ///baseline, primarily for chemical or mathematical notation). May also replace lowercase characters with alphabetic
    ///inferiors. <b>Equivalent OpenType tag:</b> 'sinf'
    DWRITE_FONT_FEATURE_TAG_SCIENTIFIC_INFERIORS             = 0x666e6973,
    ///Turns lowercase characters into small capitals. This corresponds to the common SC font layout. It is generally
    ///used for display lines set in Large &amp; small caps, such as titles. Forms related to small capitals, such as
    ///oldstyle figures, may be included. <b>Equivalent OpenType tag:</b> 'smcp'
    DWRITE_FONT_FEATURE_TAG_SMALL_CAPITALS                   = 0x70636d73,
    ///Replaces 'traditional' Chinese or Japanese forms with the corresponding 'simplified' forms. <b>Equivalent
    ///OpenType tag:</b> 'smpl'
    DWRITE_FONT_FEATURE_TAG_SIMPLIFIED_FORMS                 = 0x6c706d73,
    ///In addition to, or instead of, stylistic alternatives of individual glyphs (see 'salt' feature), some fonts may
    ///contain sets of stylistic variant glyphs corresponding to portions of the character set, such as multiple
    ///variants for lowercase letters in a Latin font. Glyphs in stylistic sets may be designed to harmonise visually,
    ///interract in particular ways, or otherwise work together. Examples of fonts including stylistic sets are Zapfino
    ///Linotype and Adobe's Poetica. Individual features numbered sequentially with the tag name convention 'ss01'
    ///'ss02' 'ss03' . 'ss20' provide a mechanism for glyphs in these sets to be associated via GSUB lookup indexes to
    ///default forms and to each other, and for users to select from available stylistic sets <b>Equivalent OpenType
    ///tag:</b> 'ss01'
    DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_1                  = 0x31307373,
    ///See the description for DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_1. <b>Equivalent OpenType tag:</b> 'ss02'
    DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_2                  = 0x32307373,
    ///See the description for DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_1. <b>Equivalent OpenType tag:</b> 'ss03'
    DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_3                  = 0x33307373,
    ///See the description for DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_1. <b>Equivalent OpenType tag:</b> 'ss04'
    DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_4                  = 0x34307373,
    ///See the description for DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_1. <b>Equivalent OpenType tag:</b> 'ss05'
    DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_5                  = 0x35307373,
    ///See the description for DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_1. <b>Equivalent OpenType tag:</b> 'ss06'
    DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_6                  = 0x36307373,
    ///See the description for DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_1. <b>Equivalent OpenType tag:</b> 'ss07'
    DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_7                  = 0x37307373,
    ///See the description for DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_1. <b>Equivalent OpenType tag:</b> 'ss08'
    DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_8                  = 0x38307373,
    ///See the description for DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_1. <b>Equivalent OpenType tag:</b> 'ss09'
    DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_9                  = 0x39307373,
    ///See the description for DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_1. <b>Equivalent OpenType tag:</b> 'ss10'
    DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_10                 = 0x30317373,
    ///See the description for DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_1. <b>Equivalent OpenType tag:</b> 'ss11'
    DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_11                 = 0x31317373,
    ///See the description for DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_1. <b>Equivalent OpenType tag:</b> 'ss12'
    DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_12                 = 0x32317373,
    ///See the description for DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_1. <b>Equivalent OpenType tag:</b> 'ss13'
    DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_13                 = 0x33317373,
    ///See the description for DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_1. <b>Equivalent OpenType tag:</b> 'ss14'
    DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_14                 = 0x34317373,
    ///See the description for DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_1. <b>Equivalent OpenType tag:</b> 'ss15'
    DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_15                 = 0x35317373,
    ///See the description for DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_1. <b>Equivalent OpenType tag:</b> 'ss16'
    DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_16                 = 0x36317373,
    ///See the description for DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_1. <b>Equivalent OpenType tag:</b> 'ss17'
    DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_17                 = 0x37317373,
    ///See the description for DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_1. <b>Equivalent OpenType tag:</b> 'ss18'
    DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_18                 = 0x38317373,
    ///See the description for DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_1. <b>Equivalent OpenType tag:</b> 'ss19'
    DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_19                 = 0x39317373,
    ///See the description for DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_1. <b>Equivalent OpenType tag:</b> 'ss20'
    DWRITE_FONT_FEATURE_TAG_STYLISTIC_SET_20                 = 0x30327373,
    ///May replace a default glyph with a subscript glyph, or it may combine a glyph substitution with positioning
    ///adjustments for proper placement. <b>Equivalent OpenType tag:</b> 'subs'
    DWRITE_FONT_FEATURE_TAG_SUBSCRIPT                        = 0x73627573,
    ///Replaces lining or oldstyle figures with superior figures (primarily for footnote indication), and replaces
    ///lowercase letters with superior letters (primarily for abbreviated French titles). <b>Equivalent OpenType
    ///tag:</b> 'sups'
    DWRITE_FONT_FEATURE_TAG_SUPERSCRIPT                      = 0x73707573,
    ///Replaces default character glyphs with corresponding swash glyphs. Note that there may be more than one swash
    ///alternate for a given character. <b>Equivalent OpenType tag:</b> 'swsh'
    DWRITE_FONT_FEATURE_TAG_SWASH                            = 0x68737773,
    ///Replaces the default glyphs with corresponding forms designed specifically for titling. These may be all-capital
    ///and/or larger on the body, and adjusted for viewing at larger sizes. <b>Equivalent OpenType tag:</b> 'titl'
    DWRITE_FONT_FEATURE_TAG_TITLING                          = 0x6c746974,
    ///Replaces 'simplified' Japanese kanji forms with the corresponding 'traditional' forms. This is equivalent to the
    ///Traditional Forms feature, but explicitly limited to the traditional forms considered proper for use in personal
    ///names (as many as 205 glyphs in some fonts). <b>Equivalent OpenType tag:</b> 'tnam'
    DWRITE_FONT_FEATURE_TAG_TRADITIONAL_NAME_FORMS           = 0x6d616e74,
    ///Replaces figure glyphs set on proportional widths with corresponding glyphs set on uniform (tabular) widths.
    ///Tabular widths will generally be the default, but this cannot be safely assumed. Of course this feature would not
    ///be present in monospaced designs. <b>Equivalent OpenType tag:</b> 'tnum'
    DWRITE_FONT_FEATURE_TAG_TABULAR_FIGURES                  = 0x6d756e74,
    ///Replaces 'simplified' Chinese hanzi or Japanese kanji forms with the corresponding 'traditional' forms.
    ///<b>Equivalent OpenType tag:</b> 'trad'
    DWRITE_FONT_FEATURE_TAG_TRADITIONAL_FORMS                = 0x64617274,
    ///Replaces glyphs on other widths with glyphs set on widths of one third of an em. The characters involved are
    ///normally figures and some forms of punctuation. <b>Equivalent OpenType tag:</b> 'twid'
    DWRITE_FONT_FEATURE_TAG_THIRD_WIDTHS                     = 0x64697774,
    ///Maps upper- and lowercase letters to a mixed set of lowercase and small capital forms, resulting in a single case
    ///alphabet (for an example of unicase, see the Emigre type family Filosofia). The letters substituted may vary from
    ///font to font, as appropriate to the design. If aligning to the x-height, smallcap glyphs may be substituted, or
    ///specially designed unicase forms might be used. Substitutions might also include specially designed figures.
    ///<b>Equivalent OpenType tag:</b> 'unic'
    DWRITE_FONT_FEATURE_TAG_UNICASE                          = 0x63696e75,
    ///Indicates that the font is displayed vertically.
    DWRITE_FONT_FEATURE_TAG_VERTICAL_WRITING                 = 0x74726576,
    ///Replaces normal figures with figures adjusted for vertical display.
    DWRITE_FONT_FEATURE_TAG_VERTICAL_ALTERNATES_AND_ROTATION = 0x32747276,
    DWRITE_FONT_FEATURE_TAG_SLASHED_ZERO                     = 0x6f72657a,
}

///Indicates additional shaping requirements for text.
alias DWRITE_SCRIPT_SHAPES = int;
enum : int
{
    ///Indicates that there is no additional shaping requirements for text. Text is shaped with the writing system
    ///default behavior.
    DWRITE_SCRIPT_SHAPES_DEFAULT   = 0x00000000,
    DWRITE_SCRIPT_SHAPES_NO_VISUAL = 0x00000001,
}

///Indicates the condition at the edges of inline object or text used to determine line-breaking behavior.
alias DWRITE_BREAK_CONDITION = int;
enum : int
{
    ///Indicates whether a break is allowed by determining the condition of the neighboring text span or inline object.
    DWRITE_BREAK_CONDITION_NEUTRAL       = 0x00000000,
    ///Indicates that a line break is allowed, unless overruled by the condition of the neighboring text span or inline
    ///object, either prohibited by a "may not break" condition or forced by a "must break" condition.
    DWRITE_BREAK_CONDITION_CAN_BREAK     = 0x00000001,
    ///Indicates that there should be no line break, unless overruled by a "must break" condition from the neighboring
    ///text span or inline object.
    DWRITE_BREAK_CONDITION_MAY_NOT_BREAK = 0x00000002,
    DWRITE_BREAK_CONDITION_MUST_BREAK    = 0x00000003,
}

///Specifies how to apply number substitution on digits and related punctuation.
alias DWRITE_NUMBER_SUBSTITUTION_METHOD = int;
enum : int
{
    ///Specifies that the substitution method should be determined based on the LOCALE_IDIGITSUBSTITUTION value of the
    ///specified text culture.
    DWRITE_NUMBER_SUBSTITUTION_METHOD_FROM_CULTURE = 0x00000000,
    ///If the culture is Arabic or Persian, specifies that the number shapes depend on the context. Either traditional
    ///or nominal number shapes are used, depending on the nearest preceding strong character or (if there is none) the
    ///reading direction of the paragraph.
    DWRITE_NUMBER_SUBSTITUTION_METHOD_CONTEXTUAL   = 0x00000001,
    ///Specifies that code points 0x30-0x39 are always rendered as nominal numeral shapes (ones of the European number),
    ///that is, no substitution is performed.
    DWRITE_NUMBER_SUBSTITUTION_METHOD_NONE         = 0x00000002,
    ///Specifies that numbers are rendered using the national number shapes as specified by the LOCALE_SNATIVEDIGITS
    ///value of the specified text culture.
    DWRITE_NUMBER_SUBSTITUTION_METHOD_NATIONAL     = 0x00000003,
    DWRITE_NUMBER_SUBSTITUTION_METHOD_TRADITIONAL  = 0x00000004,
}

///Identifies a type of alpha texture.
alias DWRITE_TEXTURE_TYPE = int;
enum : int
{
    ///Specifies an alpha texture for aliased text rendering (that is, each pixel is either fully opaque or fully
    ///transparent), with one byte per pixel.
    DWRITE_TEXTURE_ALIASED_1x1   = 0x00000000,
    ///Specifies an alpha texture for ClearType text rendering, with three bytes per pixel in the horizontal dimension
    ///and one byte per pixel in the vertical dimension.
    DWRITE_TEXTURE_CLEARTYPE_3x1 = 0x00000001,
}

///The <b>DWRITE_PANOSE_FAMILY</b> enumeration contains values that specify the kind of typeface classification.
alias DWRITE_PANOSE_FAMILY = int;
enum : int
{
    ///Any typeface classification.
    DWRITE_PANOSE_FAMILY_ANY          = 0x00000000,
    ///No fit typeface classification.
    DWRITE_PANOSE_FAMILY_NO_FIT       = 0x00000001,
    ///Text display typeface classification.
    DWRITE_PANOSE_FAMILY_TEXT_DISPLAY = 0x00000002,
    ///Script (or hand written) typeface classification.
    DWRITE_PANOSE_FAMILY_SCRIPT       = 0x00000003,
    ///Decorative typeface classification.
    DWRITE_PANOSE_FAMILY_DECORATIVE   = 0x00000004,
    ///Symbol typeface classification.
    DWRITE_PANOSE_FAMILY_SYMBOL       = 0x00000005,
    ///Pictorial (or symbol) typeface classification.
    DWRITE_PANOSE_FAMILY_PICTORIAL    = 0x00000005,
}

///The <b>DWRITE_PANOSE_SERIF_STYLE</b> enumeration contains values that specify the appearance of the serif text.
alias DWRITE_PANOSE_SERIF_STYLE = int;
enum : int
{
    ///Any appearance of the serif text.
    DWRITE_PANOSE_SERIF_STYLE_ANY                = 0x00000000,
    ///No fit appearance of the serif text.
    DWRITE_PANOSE_SERIF_STYLE_NO_FIT             = 0x00000001,
    ///Cove appearance of the serif text.
    DWRITE_PANOSE_SERIF_STYLE_COVE               = 0x00000002,
    ///Obtuse cove appearance of the serif text.
    DWRITE_PANOSE_SERIF_STYLE_OBTUSE_COVE        = 0x00000003,
    ///Square cove appearance of the serif text.
    DWRITE_PANOSE_SERIF_STYLE_SQUARE_COVE        = 0x00000004,
    ///Obtuse square cove appearance of the serif text.
    DWRITE_PANOSE_SERIF_STYLE_OBTUSE_SQUARE_COVE = 0x00000005,
    ///Square appearance of the serif text.
    DWRITE_PANOSE_SERIF_STYLE_SQUARE             = 0x00000006,
    ///Thin appearance of the serif text.
    DWRITE_PANOSE_SERIF_STYLE_THIN               = 0x00000007,
    ///Oval appearance of the serif text.
    DWRITE_PANOSE_SERIF_STYLE_OVAL               = 0x00000008,
    ///Exaggerated appearance of the serif text.
    DWRITE_PANOSE_SERIF_STYLE_EXAGGERATED        = 0x00000009,
    ///Triangle appearance of the serif text.
    DWRITE_PANOSE_SERIF_STYLE_TRIANGLE           = 0x0000000a,
    ///Normal sans appearance of the serif text.
    DWRITE_PANOSE_SERIF_STYLE_NORMAL_SANS        = 0x0000000b,
    ///Obtuse sans appearance of the serif text.
    DWRITE_PANOSE_SERIF_STYLE_OBTUSE_SANS        = 0x0000000c,
    ///Perpendicular sans appearance of the serif text.
    DWRITE_PANOSE_SERIF_STYLE_PERPENDICULAR_SANS = 0x0000000d,
    ///Flared appearance of the serif text.
    DWRITE_PANOSE_SERIF_STYLE_FLARED             = 0x0000000e,
    ///Rounded appearance of the serif text.
    DWRITE_PANOSE_SERIF_STYLE_ROUNDED            = 0x0000000f,
    ///Script appearance of the serif text.
    DWRITE_PANOSE_SERIF_STYLE_SCRIPT             = 0x00000010,
    ///Perpendicular sans appearance of the serif text.
    DWRITE_PANOSE_SERIF_STYLE_PERP_SANS          = 0x0000000d,
    ///Oval appearance of the serif text.
    DWRITE_PANOSE_SERIF_STYLE_BONE               = 0x00000008,
}

///The <b>DWRITE_PANOSE_WEIGHT</b> enumeration contains values that specify the weight of characters.
alias DWRITE_PANOSE_WEIGHT = int;
enum : int
{
    ///Any weight.
    DWRITE_PANOSE_WEIGHT_ANY         = 0x00000000,
    ///No fit weight.
    DWRITE_PANOSE_WEIGHT_NO_FIT      = 0x00000001,
    ///Very light weight.
    DWRITE_PANOSE_WEIGHT_VERY_LIGHT  = 0x00000002,
    ///Light weight.
    DWRITE_PANOSE_WEIGHT_LIGHT       = 0x00000003,
    ///Thin weight.
    DWRITE_PANOSE_WEIGHT_THIN        = 0x00000004,
    ///Book weight.
    DWRITE_PANOSE_WEIGHT_BOOK        = 0x00000005,
    ///Medium weight.
    DWRITE_PANOSE_WEIGHT_MEDIUM      = 0x00000006,
    ///Demi weight.
    DWRITE_PANOSE_WEIGHT_DEMI        = 0x00000007,
    ///Bold weight.
    DWRITE_PANOSE_WEIGHT_BOLD        = 0x00000008,
    ///Heavy weight.
    DWRITE_PANOSE_WEIGHT_HEAVY       = 0x00000009,
    ///Black weight.
    DWRITE_PANOSE_WEIGHT_BLACK       = 0x0000000a,
    ///Extra black weight.
    DWRITE_PANOSE_WEIGHT_EXTRA_BLACK = 0x0000000b,
    ///Extra black weight.
    DWRITE_PANOSE_WEIGHT_NORD        = 0x0000000b,
}

///The <b>DWRITE_PANOSE_PROPORTION</b> enumeration contains values that specify the proportion of the glyph shape by
///considering additional detail to standard characters.
alias DWRITE_PANOSE_PROPORTION = int;
enum : int
{
    ///Any proportion for the text.
    DWRITE_PANOSE_PROPORTION_ANY            = 0x00000000,
    ///No fit proportion for the text.
    DWRITE_PANOSE_PROPORTION_NO_FIT         = 0x00000001,
    ///Old style proportion for the text.
    DWRITE_PANOSE_PROPORTION_OLD_STYLE      = 0x00000002,
    ///Modern proportion for the text.
    DWRITE_PANOSE_PROPORTION_MODERN         = 0x00000003,
    ///Extra width proportion for the text.
    DWRITE_PANOSE_PROPORTION_EVEN_WIDTH     = 0x00000004,
    ///Expanded proportion for the text.
    DWRITE_PANOSE_PROPORTION_EXPANDED       = 0x00000005,
    ///Condensed proportion for the text.
    DWRITE_PANOSE_PROPORTION_CONDENSED      = 0x00000006,
    ///Very expanded proportion for the text.
    DWRITE_PANOSE_PROPORTION_VERY_EXPANDED  = 0x00000007,
    ///Very condensed proportion for the text.
    DWRITE_PANOSE_PROPORTION_VERY_CONDENSED = 0x00000008,
    ///Monospaced proportion for the text.
    DWRITE_PANOSE_PROPORTION_MONOSPACED     = 0x00000009,
}

///The <b>DWRITE_PANOSE_CONTRAST</b> enumeration contains values that specify the ratio between thickest and thinnest
///point of the stroke for a letter such as uppercase 'O'.
alias DWRITE_PANOSE_CONTRAST = int;
enum : int
{
    ///Any contrast.
    DWRITE_PANOSE_CONTRAST_ANY               = 0x00000000,
    ///No fit contrast.
    DWRITE_PANOSE_CONTRAST_NO_FIT            = 0x00000001,
    ///No contrast.
    DWRITE_PANOSE_CONTRAST_NONE              = 0x00000002,
    ///Very low contrast.
    DWRITE_PANOSE_CONTRAST_VERY_LOW          = 0x00000003,
    ///Low contrast.
    DWRITE_PANOSE_CONTRAST_LOW               = 0x00000004,
    ///Medium low contrast.
    DWRITE_PANOSE_CONTRAST_MEDIUM_LOW        = 0x00000005,
    ///Medium contrast.
    DWRITE_PANOSE_CONTRAST_MEDIUM            = 0x00000006,
    ///Medium high contrast.
    DWRITE_PANOSE_CONTRAST_MEDIUM_HIGH       = 0x00000007,
    ///High contrast.
    DWRITE_PANOSE_CONTRAST_HIGH              = 0x00000008,
    ///Very high contrast.
    DWRITE_PANOSE_CONTRAST_VERY_HIGH         = 0x00000009,
    ///Horizontal low contrast.
    DWRITE_PANOSE_CONTRAST_HORIZONTAL_LOW    = 0x0000000a,
    ///Horizontal medium contrast.
    DWRITE_PANOSE_CONTRAST_HORIZONTAL_MEDIUM = 0x0000000b,
    ///Horizontal high contrast.
    DWRITE_PANOSE_CONTRAST_HORIZONTAL_HIGH   = 0x0000000c,
    ///Broken contrast.
    DWRITE_PANOSE_CONTRAST_BROKEN            = 0x0000000d,
}

///The <b>DWRITE_PANOSE_STROKE_VARIATION</b> enumeration contains values that specify the relationship between thin and
///thick stems of text characters.
alias DWRITE_PANOSE_STROKE_VARIATION = int;
enum : int
{
    ///Any stroke variation for text characters.
    DWRITE_PANOSE_STROKE_VARIATION_ANY                  = 0x00000000,
    ///No fit stroke variation for text characters.
    DWRITE_PANOSE_STROKE_VARIATION_NO_FIT               = 0x00000001,
    ///No stroke variation for text characters.
    DWRITE_PANOSE_STROKE_VARIATION_NO_VARIATION         = 0x00000002,
    ///The stroke variation for text characters is gradual diagonal.
    DWRITE_PANOSE_STROKE_VARIATION_GRADUAL_DIAGONAL     = 0x00000003,
    ///The stroke variation for text characters is gradual transitional.
    DWRITE_PANOSE_STROKE_VARIATION_GRADUAL_TRANSITIONAL = 0x00000004,
    ///The stroke variation for text characters is gradual vertical.
    DWRITE_PANOSE_STROKE_VARIATION_GRADUAL_VERTICAL     = 0x00000005,
    ///The stroke variation for text characters is gradual horizontal.
    DWRITE_PANOSE_STROKE_VARIATION_GRADUAL_HORIZONTAL   = 0x00000006,
    ///The stroke variation for text characters is rapid vertical.
    DWRITE_PANOSE_STROKE_VARIATION_RAPID_VERTICAL       = 0x00000007,
    ///The stroke variation for text characters is rapid horizontal.
    DWRITE_PANOSE_STROKE_VARIATION_RAPID_HORIZONTAL     = 0x00000008,
    ///The stroke variation for text characters is instant vertical.
    DWRITE_PANOSE_STROKE_VARIATION_INSTANT_VERTICAL     = 0x00000009,
    ///The stroke variation for text characters is instant horizontal.
    DWRITE_PANOSE_STROKE_VARIATION_INSTANT_HORIZONTAL   = 0x0000000a,
}

///The <b>DWRITE_PANOSE_ARM_STYLE</b> enumeration contains values that specify the style of termination of stems and
///rounded letterforms for text.
alias DWRITE_PANOSE_ARM_STYLE = int;
enum : int
{
    ///Any arm style.
    DWRITE_PANOSE_ARM_STYLE_ANY                           = 0x00000000,
    ///No fit arm style.
    DWRITE_PANOSE_ARM_STYLE_NO_FIT                        = 0x00000001,
    ///The arm style is straight horizontal.
    DWRITE_PANOSE_ARM_STYLE_STRAIGHT_ARMS_HORIZONTAL      = 0x00000002,
    ///The arm style is straight wedge.
    DWRITE_PANOSE_ARM_STYLE_STRAIGHT_ARMS_WEDGE           = 0x00000003,
    ///The arm style is straight vertical.
    DWRITE_PANOSE_ARM_STYLE_STRAIGHT_ARMS_VERTICAL        = 0x00000004,
    ///The arm style is straight single serif.
    DWRITE_PANOSE_ARM_STYLE_STRAIGHT_ARMS_SINGLE_SERIF    = 0x00000005,
    ///The arm style is straight double serif.
    DWRITE_PANOSE_ARM_STYLE_STRAIGHT_ARMS_DOUBLE_SERIF    = 0x00000006,
    ///The arm style is non-straight horizontal.
    DWRITE_PANOSE_ARM_STYLE_NONSTRAIGHT_ARMS_HORIZONTAL   = 0x00000007,
    ///The arm style is non-straight wedge.
    DWRITE_PANOSE_ARM_STYLE_NONSTRAIGHT_ARMS_WEDGE        = 0x00000008,
    ///The arm style is non-straight vertical.
    DWRITE_PANOSE_ARM_STYLE_NONSTRAIGHT_ARMS_VERTICAL     = 0x00000009,
    ///The arm style is non-straight single serif.
    DWRITE_PANOSE_ARM_STYLE_NONSTRAIGHT_ARMS_SINGLE_SERIF = 0x0000000a,
    ///The arm style is non-straight double serif.
    DWRITE_PANOSE_ARM_STYLE_NONSTRAIGHT_ARMS_DOUBLE_SERIF = 0x0000000b,
    ///The arm style is straight horizontal.
    DWRITE_PANOSE_ARM_STYLE_STRAIGHT_ARMS_HORZ            = 0x00000002,
    ///The arm style is straight vertical.
    DWRITE_PANOSE_ARM_STYLE_STRAIGHT_ARMS_VERT            = 0x00000004,
    ///The arm style is non-straight horizontal.
    DWRITE_PANOSE_ARM_STYLE_BENT_ARMS_HORZ                = 0x00000007,
    ///The arm style is non-straight wedge.
    DWRITE_PANOSE_ARM_STYLE_BENT_ARMS_WEDGE               = 0x00000008,
    ///The arm style is non-straight vertical.
    DWRITE_PANOSE_ARM_STYLE_BENT_ARMS_VERT                = 0x00000009,
    ///The arm style is non-straight single serif.
    DWRITE_PANOSE_ARM_STYLE_BENT_ARMS_SINGLE_SERIF        = 0x0000000a,
    ///The arm style is non-straight double serif.
    DWRITE_PANOSE_ARM_STYLE_BENT_ARMS_DOUBLE_SERIF        = 0x0000000b,
}

///The <b>DWRITE_PANOSE_LETTERFORM</b> enumeration contains values that specify the roundness of letterform for text.
alias DWRITE_PANOSE_LETTERFORM = int;
enum : int
{
    ///Any letterform.
    DWRITE_PANOSE_LETTERFORM_ANY                = 0x00000000,
    ///No fit letterform.
    DWRITE_PANOSE_LETTERFORM_NO_FIT             = 0x00000001,
    ///Normal contact letterform.
    DWRITE_PANOSE_LETTERFORM_NORMAL_CONTACT     = 0x00000002,
    ///Normal weighted letterform.
    DWRITE_PANOSE_LETTERFORM_NORMAL_WEIGHTED    = 0x00000003,
    ///Normal boxed letterform.
    DWRITE_PANOSE_LETTERFORM_NORMAL_BOXED       = 0x00000004,
    ///Normal flattened letterform.
    DWRITE_PANOSE_LETTERFORM_NORMAL_FLATTENED   = 0x00000005,
    ///Normal rounded letterform.
    DWRITE_PANOSE_LETTERFORM_NORMAL_ROUNDED     = 0x00000006,
    ///Normal off-center letterform.
    DWRITE_PANOSE_LETTERFORM_NORMAL_OFF_CENTER  = 0x00000007,
    ///Normal square letterform.
    DWRITE_PANOSE_LETTERFORM_NORMAL_SQUARE      = 0x00000008,
    ///Oblique contact letterform.
    DWRITE_PANOSE_LETTERFORM_OBLIQUE_CONTACT    = 0x00000009,
    ///Oblique weighted letterform.
    DWRITE_PANOSE_LETTERFORM_OBLIQUE_WEIGHTED   = 0x0000000a,
    ///Oblique boxed letterform.
    DWRITE_PANOSE_LETTERFORM_OBLIQUE_BOXED      = 0x0000000b,
    ///Oblique flattened letterform.
    DWRITE_PANOSE_LETTERFORM_OBLIQUE_FLATTENED  = 0x0000000c,
    ///Oblique rounded letterform.
    DWRITE_PANOSE_LETTERFORM_OBLIQUE_ROUNDED    = 0x0000000d,
    ///Oblique off-center letterform.
    DWRITE_PANOSE_LETTERFORM_OBLIQUE_OFF_CENTER = 0x0000000e,
    ///Oblique square letterform.
    DWRITE_PANOSE_LETTERFORM_OBLIQUE_SQUARE     = 0x0000000f,
}

///The <b>DWRITE_PANOSE_MIDLINE</b> enumeration contains values that specify info about the placement of midline across
///uppercase characters and the treatment of diagonal stem apexes.
alias DWRITE_PANOSE_MIDLINE = int;
enum : int
{
    ///Any midline.
    DWRITE_PANOSE_MIDLINE_ANY              = 0x00000000,
    ///No fit midline.
    DWRITE_PANOSE_MIDLINE_NO_FIT           = 0x00000001,
    ///Standard trimmed midline.
    DWRITE_PANOSE_MIDLINE_STANDARD_TRIMMED = 0x00000002,
    ///Standard pointed midline.
    DWRITE_PANOSE_MIDLINE_STANDARD_POINTED = 0x00000003,
    ///Standard serifed midline.
    DWRITE_PANOSE_MIDLINE_STANDARD_SERIFED = 0x00000004,
    ///High trimmed midline.
    DWRITE_PANOSE_MIDLINE_HIGH_TRIMMED     = 0x00000005,
    ///High pointed midline.
    DWRITE_PANOSE_MIDLINE_HIGH_POINTED     = 0x00000006,
    ///High serifed midline.
    DWRITE_PANOSE_MIDLINE_HIGH_SERIFED     = 0x00000007,
    ///Constant trimmed midline.
    DWRITE_PANOSE_MIDLINE_CONSTANT_TRIMMED = 0x00000008,
    ///Constant pointed midline.
    DWRITE_PANOSE_MIDLINE_CONSTANT_POINTED = 0x00000009,
    ///Constant serifed midline.
    DWRITE_PANOSE_MIDLINE_CONSTANT_SERIFED = 0x0000000a,
    ///Low trimmed midline.
    DWRITE_PANOSE_MIDLINE_LOW_TRIMMED      = 0x0000000b,
    ///Low pointed midline.
    DWRITE_PANOSE_MIDLINE_LOW_POINTED      = 0x0000000c,
    ///Low serifed midline.
    DWRITE_PANOSE_MIDLINE_LOW_SERIFED      = 0x0000000d,
}

///The <b>DWRITE_PANOSE_XHEIGHT</b> enumeration contains values that specify info about the relative size of lowercase
///letters and the treatment of diacritic marks (xheight).
alias DWRITE_PANOSE_XHEIGHT = int;
enum : int
{
    ///Any xheight.
    DWRITE_PANOSE_XHEIGHT_ANY               = 0x00000000,
    ///No fit xheight.
    DWRITE_PANOSE_XHEIGHT_NO_FIT            = 0x00000001,
    ///Constant small xheight.
    DWRITE_PANOSE_XHEIGHT_CONSTANT_SMALL    = 0x00000002,
    ///Constant standard xheight.
    DWRITE_PANOSE_XHEIGHT_CONSTANT_STANDARD = 0x00000003,
    ///Constant large xheight.
    DWRITE_PANOSE_XHEIGHT_CONSTANT_LARGE    = 0x00000004,
    ///Ducking small xheight.
    DWRITE_PANOSE_XHEIGHT_DUCKING_SMALL     = 0x00000005,
    ///Ducking standard xheight.
    DWRITE_PANOSE_XHEIGHT_DUCKING_STANDARD  = 0x00000006,
    ///Ducking large xheight.
    DWRITE_PANOSE_XHEIGHT_DUCKING_LARGE     = 0x00000007,
    ///Constant standard xheight.
    DWRITE_PANOSE_XHEIGHT_CONSTANT_STD      = 0x00000003,
    ///Ducking standard xheight.
    DWRITE_PANOSE_XHEIGHT_DUCKING_STD       = 0x00000006,
}

///The <b>DWRITE_PANOSE_TOOL_KIND</b> enumeration contains values that specify the kind of tool that is used to create
///character forms.
alias DWRITE_PANOSE_TOOL_KIND = int;
enum : int
{
    ///Any kind of tool.
    DWRITE_PANOSE_TOOL_KIND_ANY                = 0x00000000,
    ///No fit for the kind of tool.
    DWRITE_PANOSE_TOOL_KIND_NO_FIT             = 0x00000001,
    ///Flat NIB tool.
    DWRITE_PANOSE_TOOL_KIND_FLAT_NIB           = 0x00000002,
    ///Pressure point tool.
    DWRITE_PANOSE_TOOL_KIND_PRESSURE_POINT     = 0x00000003,
    ///Engraved tool.
    DWRITE_PANOSE_TOOL_KIND_ENGRAVED           = 0x00000004,
    ///Ball tool.
    DWRITE_PANOSE_TOOL_KIND_BALL               = 0x00000005,
    ///Brush tool.
    DWRITE_PANOSE_TOOL_KIND_BRUSH              = 0x00000006,
    ///Rough tool.
    DWRITE_PANOSE_TOOL_KIND_ROUGH              = 0x00000007,
    ///Felt-pen-brush-tip tool.
    DWRITE_PANOSE_TOOL_KIND_FELT_PEN_BRUSH_TIP = 0x00000008,
    ///Wild-brush tool.
    DWRITE_PANOSE_TOOL_KIND_WILD_BRUSH         = 0x00000009,
}

///The <b>DWRITE_PANOSE_SPACING</b> enumeration contains values that specify character spacing (monospace versus
///proportional).
alias DWRITE_PANOSE_SPACING = int;
enum : int
{
    ///Any spacing.
    DWRITE_PANOSE_SPACING_ANY                 = 0x00000000,
    ///No fit for spacing.
    DWRITE_PANOSE_SPACING_NO_FIT              = 0x00000001,
    ///Spacing is proportional.
    DWRITE_PANOSE_SPACING_PROPORTIONAL_SPACED = 0x00000002,
    ///Spacing is monospace.
    DWRITE_PANOSE_SPACING_MONOSPACED          = 0x00000003,
}

///The <b>DWRITE_PANOSE_ASPECT_RATIO</b> enumeration contains values that specify info about the ratio between width and
///height of the character face.
alias DWRITE_PANOSE_ASPECT_RATIO = int;
enum : int
{
    ///Any aspect ratio.
    DWRITE_PANOSE_ASPECT_RATIO_ANY            = 0x00000000,
    ///No fit for aspect ratio.
    DWRITE_PANOSE_ASPECT_RATIO_NO_FIT         = 0x00000001,
    ///Very condensed aspect ratio.
    DWRITE_PANOSE_ASPECT_RATIO_VERY_CONDENSED = 0x00000002,
    ///Condensed aspect ratio.
    DWRITE_PANOSE_ASPECT_RATIO_CONDENSED      = 0x00000003,
    ///Normal aspect ratio.
    DWRITE_PANOSE_ASPECT_RATIO_NORMAL         = 0x00000004,
    ///Expanded aspect ratio.
    DWRITE_PANOSE_ASPECT_RATIO_EXPANDED       = 0x00000005,
    ///Very expanded aspect ratio.
    DWRITE_PANOSE_ASPECT_RATIO_VERY_EXPANDED  = 0x00000006,
}

///The <b>DWRITE_PANOSE_SCRIPT_TOPOLOGY</b> enumeration contains values that specify the topology of letterforms.
alias DWRITE_PANOSE_SCRIPT_TOPOLOGY = int;
enum : int
{
    ///Any script topology.
    DWRITE_PANOSE_SCRIPT_TOPOLOGY_ANY                      = 0x00000000,
    ///No fit for script topology.
    DWRITE_PANOSE_SCRIPT_TOPOLOGY_NO_FIT                   = 0x00000001,
    ///Script topology is roman disconnected.
    DWRITE_PANOSE_SCRIPT_TOPOLOGY_ROMAN_DISCONNECTED       = 0x00000002,
    ///Script topology is roman trailing.
    DWRITE_PANOSE_SCRIPT_TOPOLOGY_ROMAN_TRAILING           = 0x00000003,
    ///Script topology is roman connected.
    DWRITE_PANOSE_SCRIPT_TOPOLOGY_ROMAN_CONNECTED          = 0x00000004,
    ///Script topology is cursive disconnected.
    DWRITE_PANOSE_SCRIPT_TOPOLOGY_CURSIVE_DISCONNECTED     = 0x00000005,
    ///Script topology is cursive trailing.
    DWRITE_PANOSE_SCRIPT_TOPOLOGY_CURSIVE_TRAILING         = 0x00000006,
    ///Script topology is cursive connected.
    DWRITE_PANOSE_SCRIPT_TOPOLOGY_CURSIVE_CONNECTED        = 0x00000007,
    ///Script topology is black-letter disconnected.
    DWRITE_PANOSE_SCRIPT_TOPOLOGY_BLACKLETTER_DISCONNECTED = 0x00000008,
    ///Script topology is black-letter trailing.
    DWRITE_PANOSE_SCRIPT_TOPOLOGY_BLACKLETTER_TRAILING     = 0x00000009,
    ///Script topology is black-letter connected.
    DWRITE_PANOSE_SCRIPT_TOPOLOGY_BLACKLETTER_CONNECTED    = 0x0000000a,
}

///The <b>DWRITE_PANOSE_SCRIPT_FORM</b> enumeration contains values that specify the general look of the character face,
///with consideration of its slope and tails.
alias DWRITE_PANOSE_SCRIPT_FORM = int;
enum : int
{
    ///Any script form.
    DWRITE_PANOSE_SCRIPT_FORM_ANY                          = 0x00000000,
    ///No fit for script form.
    DWRITE_PANOSE_SCRIPT_FORM_NO_FIT                       = 0x00000001,
    ///Script form is upright with no wrapping.
    DWRITE_PANOSE_SCRIPT_FORM_UPRIGHT_NO_WRAPPING          = 0x00000002,
    ///Script form is upright with some wrapping.
    DWRITE_PANOSE_SCRIPT_FORM_UPRIGHT_SOME_WRAPPING        = 0x00000003,
    ///Script form is upright with more wrapping.
    DWRITE_PANOSE_SCRIPT_FORM_UPRIGHT_MORE_WRAPPING        = 0x00000004,
    ///Script form is upright with extreme wrapping.
    DWRITE_PANOSE_SCRIPT_FORM_UPRIGHT_EXTREME_WRAPPING     = 0x00000005,
    ///Script form is oblique with no wrapping.
    DWRITE_PANOSE_SCRIPT_FORM_OBLIQUE_NO_WRAPPING          = 0x00000006,
    ///Script form is oblique with some wrapping.
    DWRITE_PANOSE_SCRIPT_FORM_OBLIQUE_SOME_WRAPPING        = 0x00000007,
    ///Script form is oblique with more wrapping.
    DWRITE_PANOSE_SCRIPT_FORM_OBLIQUE_MORE_WRAPPING        = 0x00000008,
    ///Script form is oblique with extreme wrapping.
    DWRITE_PANOSE_SCRIPT_FORM_OBLIQUE_EXTREME_WRAPPING     = 0x00000009,
    ///Script form is exaggerated with no wrapping.
    DWRITE_PANOSE_SCRIPT_FORM_EXAGGERATED_NO_WRAPPING      = 0x0000000a,
    ///Script form is exaggerated with some wrapping.
    DWRITE_PANOSE_SCRIPT_FORM_EXAGGERATED_SOME_WRAPPING    = 0x0000000b,
    ///Script form is exaggerated with more wrapping.
    DWRITE_PANOSE_SCRIPT_FORM_EXAGGERATED_MORE_WRAPPING    = 0x0000000c,
    ///Script form is exaggerated with extreme wrapping.
    DWRITE_PANOSE_SCRIPT_FORM_EXAGGERATED_EXTREME_WRAPPING = 0x0000000d,
}

///The <b>DWRITE_PANOSE_FINIALS</b> enumeration contains values that specify how character ends and miniscule ascenders
///are treated.
alias DWRITE_PANOSE_FINIALS = int;
enum : int
{
    ///Any finials.
    DWRITE_PANOSE_FINIALS_ANY                  = 0x00000000,
    ///No fit for finials.
    DWRITE_PANOSE_FINIALS_NO_FIT               = 0x00000001,
    ///No loops.
    DWRITE_PANOSE_FINIALS_NONE_NO_LOOPS        = 0x00000002,
    ///No closed loops.
    DWRITE_PANOSE_FINIALS_NONE_CLOSED_LOOPS    = 0x00000003,
    ///No open loops.
    DWRITE_PANOSE_FINIALS_NONE_OPEN_LOOPS      = 0x00000004,
    ///Sharp with no loops.
    DWRITE_PANOSE_FINIALS_SHARP_NO_LOOPS       = 0x00000005,
    ///Sharp with closed loops.
    DWRITE_PANOSE_FINIALS_SHARP_CLOSED_LOOPS   = 0x00000006,
    ///Sharp with open loops.
    DWRITE_PANOSE_FINIALS_SHARP_OPEN_LOOPS     = 0x00000007,
    ///Tapered with no loops.
    DWRITE_PANOSE_FINIALS_TAPERED_NO_LOOPS     = 0x00000008,
    ///Tapered with closed loops.
    DWRITE_PANOSE_FINIALS_TAPERED_CLOSED_LOOPS = 0x00000009,
    ///Tapered with open loops.
    DWRITE_PANOSE_FINIALS_TAPERED_OPEN_LOOPS   = 0x0000000a,
    ///Round with no loops.
    DWRITE_PANOSE_FINIALS_ROUND_NO_LOOPS       = 0x0000000b,
    ///Round with closed loops.
    DWRITE_PANOSE_FINIALS_ROUND_CLOSED_LOOPS   = 0x0000000c,
    ///Round with open loops.
    DWRITE_PANOSE_FINIALS_ROUND_OPEN_LOOPS     = 0x0000000d,
}

///The <b>DWRITE_PANOSE_XASCENT</b> enumeration contains values that specify the relative size of the lowercase letters.
alias DWRITE_PANOSE_XASCENT = int;
enum : int
{
    ///Any xascent.
    DWRITE_PANOSE_XASCENT_ANY       = 0x00000000,
    ///No fit for xascent.
    DWRITE_PANOSE_XASCENT_NO_FIT    = 0x00000001,
    ///Very low xascent.
    DWRITE_PANOSE_XASCENT_VERY_LOW  = 0x00000002,
    ///Low xascent.
    DWRITE_PANOSE_XASCENT_LOW       = 0x00000003,
    ///Medium xascent.
    DWRITE_PANOSE_XASCENT_MEDIUM    = 0x00000004,
    ///High xascent.
    DWRITE_PANOSE_XASCENT_HIGH      = 0x00000005,
    ///Very high xascent.
    DWRITE_PANOSE_XASCENT_VERY_HIGH = 0x00000006,
}

///The <b>DWRITE_PANOSE_DECORATIVE_CLASS</b> enumeration contains values that specify the general look of the character
///face.
alias DWRITE_PANOSE_DECORATIVE_CLASS = int;
enum : int
{
    ///Any class of decorative typeface.
    DWRITE_PANOSE_DECORATIVE_CLASS_ANY                  = 0x00000000,
    ///No fit for decorative typeface.
    DWRITE_PANOSE_DECORATIVE_CLASS_NO_FIT               = 0x00000001,
    ///Derivative decorative typeface.
    DWRITE_PANOSE_DECORATIVE_CLASS_DERIVATIVE           = 0x00000002,
    ///Nonstandard topology decorative typeface.
    DWRITE_PANOSE_DECORATIVE_CLASS_NONSTANDARD_TOPOLOGY = 0x00000003,
    ///Nonstandard elements decorative typeface.
    DWRITE_PANOSE_DECORATIVE_CLASS_NONSTANDARD_ELEMENTS = 0x00000004,
    ///Nonstandard aspect decorative typeface.
    DWRITE_PANOSE_DECORATIVE_CLASS_NONSTANDARD_ASPECT   = 0x00000005,
    ///Initials decorative typeface.
    DWRITE_PANOSE_DECORATIVE_CLASS_INITIALS             = 0x00000006,
    ///Cartoon decorative typeface.
    DWRITE_PANOSE_DECORATIVE_CLASS_CARTOON              = 0x00000007,
    ///Picture stems decorative typeface.
    DWRITE_PANOSE_DECORATIVE_CLASS_PICTURE_STEMS        = 0x00000008,
    ///Ornamented decorative typeface.
    DWRITE_PANOSE_DECORATIVE_CLASS_ORNAMENTED           = 0x00000009,
    ///Text and background decorative typeface.
    DWRITE_PANOSE_DECORATIVE_CLASS_TEXT_AND_BACKGROUND  = 0x0000000a,
    ///Collage decorative typeface.
    DWRITE_PANOSE_DECORATIVE_CLASS_COLLAGE              = 0x0000000b,
    ///Montage decorative typeface.
    DWRITE_PANOSE_DECORATIVE_CLASS_MONTAGE              = 0x0000000c,
}

///The <b>DWRITE_PANOSE_ASPECT</b> enumeration contains values that specify the ratio between the width and height of
///the character face.
alias DWRITE_PANOSE_ASPECT = int;
enum : int
{
    ///Any aspect.
    DWRITE_PANOSE_ASPECT_ANY             = 0x00000000,
    ///No fit for aspect.
    DWRITE_PANOSE_ASPECT_NO_FIT          = 0x00000001,
    ///Super condensed aspect.
    DWRITE_PANOSE_ASPECT_SUPER_CONDENSED = 0x00000002,
    ///Very condensed aspect.
    DWRITE_PANOSE_ASPECT_VERY_CONDENSED  = 0x00000003,
    ///Condensed aspect.
    DWRITE_PANOSE_ASPECT_CONDENSED       = 0x00000004,
    ///Normal aspect.
    DWRITE_PANOSE_ASPECT_NORMAL          = 0x00000005,
    ///Extended aspect.
    DWRITE_PANOSE_ASPECT_EXTENDED        = 0x00000006,
    ///Very extended aspect.
    DWRITE_PANOSE_ASPECT_VERY_EXTENDED   = 0x00000007,
    ///Super extended aspect.
    DWRITE_PANOSE_ASPECT_SUPER_EXTENDED  = 0x00000008,
    ///Monospace aspect.
    DWRITE_PANOSE_ASPECT_MONOSPACED      = 0x00000009,
}

///The <b>DWRITE_PANOSE_FILL</b> enumeration contains values that specify the type of fill and line treatment.
alias DWRITE_PANOSE_FILL = int;
enum : int
{
    ///Any fill.
    DWRITE_PANOSE_FILL_ANY                 = 0x00000000,
    ///No fit for fill.
    DWRITE_PANOSE_FILL_NO_FIT              = 0x00000001,
    ///The fill is the standard solid fill.
    DWRITE_PANOSE_FILL_STANDARD_SOLID_FILL = 0x00000002,
    ///No fill.
    DWRITE_PANOSE_FILL_NO_FILL             = 0x00000003,
    ///The fill is patterned fill.
    DWRITE_PANOSE_FILL_PATTERNED_FILL      = 0x00000004,
    ///The fill is complex fill.
    DWRITE_PANOSE_FILL_COMPLEX_FILL        = 0x00000005,
    ///The fill is shaped fill.
    DWRITE_PANOSE_FILL_SHAPED_FILL         = 0x00000006,
    ///The fill is drawn distressed.
    DWRITE_PANOSE_FILL_DRAWN_DISTRESSED    = 0x00000007,
}

///The <b>DWRITE_PANOSE_LINING</b> enumeration contains values that specify the handling of the outline for the
///decorative typeface.
alias DWRITE_PANOSE_LINING = int;
enum : int
{
    ///Any lining.
    DWRITE_PANOSE_LINING_ANY      = 0x00000000,
    ///No fit for lining.
    DWRITE_PANOSE_LINING_NO_FIT   = 0x00000001,
    ///No lining.
    DWRITE_PANOSE_LINING_NONE     = 0x00000002,
    ///The lining is inline.
    DWRITE_PANOSE_LINING_INLINE   = 0x00000003,
    ///The lining is outline.
    DWRITE_PANOSE_LINING_OUTLINE  = 0x00000004,
    ///The lining is engraved.
    DWRITE_PANOSE_LINING_ENGRAVED = 0x00000005,
    ///The lining is shadowed.
    DWRITE_PANOSE_LINING_SHADOW   = 0x00000006,
    ///The lining is relief.
    DWRITE_PANOSE_LINING_RELIEF   = 0x00000007,
    ///The lining is backdrop.
    DWRITE_PANOSE_LINING_BACKDROP = 0x00000008,
}

///The <b>DWRITE_PANOSE_DECORATIVE_TOPOLOGY</b> enumeration contains values that specify the overall shape
///characteristics of the font.
alias DWRITE_PANOSE_DECORATIVE_TOPOLOGY = int;
enum : int
{
    ///Any decorative topology.
    DWRITE_PANOSE_DECORATIVE_TOPOLOGY_ANY                      = 0x00000000,
    ///No fit for decorative topology.
    DWRITE_PANOSE_DECORATIVE_TOPOLOGY_NO_FIT                   = 0x00000001,
    ///Standard decorative topology.
    DWRITE_PANOSE_DECORATIVE_TOPOLOGY_STANDARD                 = 0x00000002,
    ///Square decorative topology.
    DWRITE_PANOSE_DECORATIVE_TOPOLOGY_SQUARE                   = 0x00000003,
    ///Multiple segment decorative topology.
    DWRITE_PANOSE_DECORATIVE_TOPOLOGY_MULTIPLE_SEGMENT         = 0x00000004,
    ///Art deco decorative topology.
    DWRITE_PANOSE_DECORATIVE_TOPOLOGY_ART_DECO                 = 0x00000005,
    ///Uneven weighting decorative topology.
    DWRITE_PANOSE_DECORATIVE_TOPOLOGY_UNEVEN_WEIGHTING         = 0x00000006,
    ///Diverse arms decorative topology.
    DWRITE_PANOSE_DECORATIVE_TOPOLOGY_DIVERSE_ARMS             = 0x00000007,
    ///Diverse forms decorative topology.
    DWRITE_PANOSE_DECORATIVE_TOPOLOGY_DIVERSE_FORMS            = 0x00000008,
    ///Lombardic forms decorative topology.
    DWRITE_PANOSE_DECORATIVE_TOPOLOGY_LOMBARDIC_FORMS          = 0x00000009,
    ///Upper case in lower case decorative topology.
    DWRITE_PANOSE_DECORATIVE_TOPOLOGY_UPPER_CASE_IN_LOWER_CASE = 0x0000000a,
    ///The decorative topology is implied.
    DWRITE_PANOSE_DECORATIVE_TOPOLOGY_IMPLIED_TOPOLOGY         = 0x0000000b,
    ///Horseshoe E and A decorative topology.
    DWRITE_PANOSE_DECORATIVE_TOPOLOGY_HORSESHOE_E_AND_A        = 0x0000000c,
    ///Cursive decorative topology.
    DWRITE_PANOSE_DECORATIVE_TOPOLOGY_CURSIVE                  = 0x0000000d,
    ///Blackletter decorative topology.
    DWRITE_PANOSE_DECORATIVE_TOPOLOGY_BLACKLETTER              = 0x0000000e,
    ///Swash variance decorative topology.
    DWRITE_PANOSE_DECORATIVE_TOPOLOGY_SWASH_VARIANCE           = 0x0000000f,
}

///The <b>DWRITE_PANOSE_CHARACTER_RANGES</b> enumeration contains values that specify the type of characters available
///in the font.
alias DWRITE_PANOSE_CHARACTER_RANGES = int;
enum : int
{
    ///Any range.
    DWRITE_PANOSE_CHARACTER_RANGES_ANY                 = 0x00000000,
    ///No fit for range.
    DWRITE_PANOSE_CHARACTER_RANGES_NO_FIT              = 0x00000001,
    ///The range includes extended collection.
    DWRITE_PANOSE_CHARACTER_RANGES_EXTENDED_COLLECTION = 0x00000002,
    ///The range includes literals.
    DWRITE_PANOSE_CHARACTER_RANGES_LITERALS            = 0x00000003,
    ///The range doesn't include lower case.
    DWRITE_PANOSE_CHARACTER_RANGES_NO_LOWER_CASE       = 0x00000004,
    ///The range includes small capitals.
    DWRITE_PANOSE_CHARACTER_RANGES_SMALL_CAPS          = 0x00000005,
}

///The <b>DWRITE_PANOSE_SYMBOL_KIND</b> enumeration contains values that specify the kind of symbol set.
alias DWRITE_PANOSE_SYMBOL_KIND = int;
enum : int
{
    ///Any kind of symbol set.
    DWRITE_PANOSE_SYMBOL_KIND_ANY               = 0x00000000,
    ///No fit for the kind of symbol set.
    DWRITE_PANOSE_SYMBOL_KIND_NO_FIT            = 0x00000001,
    ///The kind of symbol set is montages.
    DWRITE_PANOSE_SYMBOL_KIND_MONTAGES          = 0x00000002,
    ///The kind of symbol set is pictures.
    DWRITE_PANOSE_SYMBOL_KIND_PICTURES          = 0x00000003,
    ///The kind of symbol set is shapes.
    DWRITE_PANOSE_SYMBOL_KIND_SHAPES            = 0x00000004,
    ///The kind of symbol set is scientific symbols.
    DWRITE_PANOSE_SYMBOL_KIND_SCIENTIFIC        = 0x00000005,
    ///The kind of symbol set is music symbols.
    DWRITE_PANOSE_SYMBOL_KIND_MUSIC             = 0x00000006,
    ///The kind of symbol set is expert symbols.
    DWRITE_PANOSE_SYMBOL_KIND_EXPERT            = 0x00000007,
    ///The kind of symbol set is patterns.
    DWRITE_PANOSE_SYMBOL_KIND_PATTERNS          = 0x00000008,
    ///The kind of symbol set is boarders.
    DWRITE_PANOSE_SYMBOL_KIND_BOARDERS          = 0x00000009,
    ///The kind of symbol set is icons.
    DWRITE_PANOSE_SYMBOL_KIND_ICONS             = 0x0000000a,
    ///The kind of symbol set is logos.
    DWRITE_PANOSE_SYMBOL_KIND_LOGOS             = 0x0000000b,
    ///The kind of symbol set is industry specific.
    DWRITE_PANOSE_SYMBOL_KIND_INDUSTRY_SPECIFIC = 0x0000000c,
}

///The <b>DWRITE_PANOSE_SYMBOL_ASPECT_RATIO</b> enumeration contains values that specify the aspect ratio of symbolic
///characters.
alias DWRITE_PANOSE_SYMBOL_ASPECT_RATIO = int;
enum : int
{
    ///Any aspect ratio of symbolic characters.
    DWRITE_PANOSE_SYMBOL_ASPECT_RATIO_ANY                = 0x00000000,
    ///No fit for aspect ratio of symbolic characters.
    DWRITE_PANOSE_SYMBOL_ASPECT_RATIO_NO_FIT             = 0x00000001,
    ///No width aspect ratio of symbolic characters.
    DWRITE_PANOSE_SYMBOL_ASPECT_RATIO_NO_WIDTH           = 0x00000002,
    ///Exceptionally wide symbolic characters.
    DWRITE_PANOSE_SYMBOL_ASPECT_RATIO_EXCEPTIONALLY_WIDE = 0x00000003,
    ///Super wide symbolic characters.
    DWRITE_PANOSE_SYMBOL_ASPECT_RATIO_SUPER_WIDE         = 0x00000004,
    ///Very wide symbolic characters.
    DWRITE_PANOSE_SYMBOL_ASPECT_RATIO_VERY_WIDE          = 0x00000005,
    ///Wide symbolic characters.
    DWRITE_PANOSE_SYMBOL_ASPECT_RATIO_WIDE               = 0x00000006,
    ///Normal aspect ratio of symbolic characters.
    DWRITE_PANOSE_SYMBOL_ASPECT_RATIO_NORMAL             = 0x00000007,
    ///Narrow symbolic characters.
    DWRITE_PANOSE_SYMBOL_ASPECT_RATIO_NARROW             = 0x00000008,
    ///Very narrow symbolic characters.
    DWRITE_PANOSE_SYMBOL_ASPECT_RATIO_VERY_NARROW        = 0x00000009,
}

///The <b>DWRITE_OUTLINE_THRESHOLD</b> enumeration contains values that specify the policy used by the
///IDWriteFontFace1::GetRecommendedRenderingMode method to determine whether to render glyphs in outline mode.
alias DWRITE_OUTLINE_THRESHOLD = int;
enum : int
{
    ///Graphics system renders anti-aliased outlines.
    DWRITE_OUTLINE_THRESHOLD_ANTIALIASED = 0x00000000,
    ///Graphics system renders aliased outlines.
    DWRITE_OUTLINE_THRESHOLD_ALIASED     = 0x00000001,
}

///The <b>DWRITE_BASELINE</b> enumeration contains values that specify the baseline for text alignment.
alias DWRITE_BASELINE = int;
enum : int
{
    ///The Roman baseline for horizontal; the Central baseline for vertical.
    DWRITE_BASELINE_DEFAULT            = 0x00000000,
    ///The baseline that is used by alphabetic scripts such as Latin, Greek, and Cyrillic.
    DWRITE_BASELINE_ROMAN              = 0x00000001,
    ///Central baseline, which is generally used for vertical text.
    DWRITE_BASELINE_CENTRAL            = 0x00000002,
    ///Mathematical baseline, which math characters are centered on.
    DWRITE_BASELINE_MATH               = 0x00000003,
    ///Hanging baseline, which is used in scripts like Devanagari.
    DWRITE_BASELINE_HANGING            = 0x00000004,
    ///Ideographic bottom baseline for CJK, left in vertical.
    DWRITE_BASELINE_IDEOGRAPHIC_BOTTOM = 0x00000005,
    ///Ideographic top baseline for CJK, right in vertical.
    DWRITE_BASELINE_IDEOGRAPHIC_TOP    = 0x00000006,
    ///The bottom-most extent in horizontal, left-most in vertical.
    DWRITE_BASELINE_MINIMUM            = 0x00000007,
    ///The top-most extent in horizontal, right-most in vertical.
    DWRITE_BASELINE_MAXIMUM            = 0x00000008,
}

///The <b>DWRITE_VERTICAL_GLYPH_ORIENTATION</b> enumeration contains values that specify the desired kind of glyph
///orientation for the text.
alias DWRITE_VERTICAL_GLYPH_ORIENTATION = int;
enum : int
{
    ///The default glyph orientation. In vertical layout, naturally horizontal scripts (Latin, Thai, Arabic, Devanagari)
    ///rotate 90 degrees clockwise, while ideographic scripts (Chinese, Japanese, Korean) remain upright, 0 degrees.
    DWRITE_VERTICAL_GLYPH_ORIENTATION_DEFAULT = 0x00000000,
    ///Stacked glyph orientation. Ideographic scripts and scripts that permit stacking (Latin, Hebrew) are stacked in
    ///vertical reading layout. Connected scripts (Arabic, Syriac, 'Phags-pa, Ogham), which would otherwise look broken
    ///if glyphs were kept at 0 degrees, remain connected and rotate.
    DWRITE_VERTICAL_GLYPH_ORIENTATION_STACKED = 0x00000001,
}

///The <b>DWRITE_GLYPH_ORIENTATION_ANGLE</b> enumeration contains values that specify how the glyph is oriented to the
///x-axis.
alias DWRITE_GLYPH_ORIENTATION_ANGLE = int;
enum : int
{
    ///Glyph orientation is upright.
    DWRITE_GLYPH_ORIENTATION_ANGLE_0_DEGREES   = 0x00000000,
    ///Glyph orientation is rotated 90 degrees clockwise.
    DWRITE_GLYPH_ORIENTATION_ANGLE_90_DEGREES  = 0x00000001,
    ///Glyph orientation is upside-down.
    DWRITE_GLYPH_ORIENTATION_ANGLE_180_DEGREES = 0x00000002,
    ///Glyph orientation is rotated 270 degrees clockwise.
    DWRITE_GLYPH_ORIENTATION_ANGLE_270_DEGREES = 0x00000003,
}

///The <b>DWRITE_TEXT_ANTIALIAS_MODE</b> enumeration contains values that specify the type of antialiasing to use for
///text when the rendering mode calls for antialiasing.
alias DWRITE_TEXT_ANTIALIAS_MODE = int;
enum : int
{
    ///ClearType antialiasing computes coverage independently for the red, green, and blue color elements of each pixel.
    ///This allows for more detail than conventional antialiasing. However, because there is no one alpha value for each
    ///pixel, ClearType is not suitable for rendering text onto a transparent intermediate bitmap.
    DWRITE_TEXT_ANTIALIAS_MODE_CLEARTYPE = 0x00000000,
    ///Grayscale antialiasing computes one coverage value for each pixel. Because the alpha value of each pixel is
    ///well-defined, text can be rendered onto a transparent bitmap, which can then be composited with other content.
    ///<div class="alert"><b>Note</b> Grayscale rendering with IDWriteBitmapRenderTarget1 uses premultiplied
    ///alpha.</div> <div> </div>
    DWRITE_TEXT_ANTIALIAS_MODE_GRAYSCALE = 0x00000001,
}

///The optical margin alignment mode. By default, glyphs are aligned to the margin by the default origin and
///side-bearings of the glyph. If you specify <b>DWRITE_OPTICAL_ALIGNMENT_NO_SIDE_BEARINGS</b>, then the alignment uses
///the side bearings to offset the glyph from the aligned edge to ensure the ink of the glyphs are aligned.
alias DWRITE_OPTICAL_ALIGNMENT = int;
enum : int
{
    ///Align to the default origin and side-bearings of the glyph.
    DWRITE_OPTICAL_ALIGNMENT_NONE             = 0x00000000,
    DWRITE_OPTICAL_ALIGNMENT_NO_SIDE_BEARINGS = 0x00000001,
}

///Specifies whether to enable grid-fitting of glyph outlines (also known as hinting).
alias DWRITE_GRID_FIT_MODE = int;
enum : int
{
    ///Choose grid fitting based on the font's table information.
    DWRITE_GRID_FIT_MODE_DEFAULT  = 0x00000000,
    ///Always disable grid fitting, using the ideal glyph outlines.
    DWRITE_GRID_FIT_MODE_DISABLED = 0x00000001,
    DWRITE_GRID_FIT_MODE_ENABLED  = 0x00000002,
}

///Identifies a string in a font.
alias DWRITE_FONT_PROPERTY_ID = int;
enum : int
{
    ///Unspecified font property identifier.
    DWRITE_FONT_PROPERTY_ID_NONE                             = 0x00000000,
    DWRITE_FONT_PROPERTY_ID_WEIGHT_STRETCH_STYLE_FAMILY_NAME = 0x00000001,
    DWRITE_FONT_PROPERTY_ID_TYPOGRAPHIC_FAMILY_NAME          = 0x00000002,
    DWRITE_FONT_PROPERTY_ID_WEIGHT_STRETCH_STYLE_FACE_NAME   = 0x00000003,
    ///The full name of the font, for example "Arial Bold", from name id 4 in the name table.
    DWRITE_FONT_PROPERTY_ID_FULL_NAME                        = 0x00000004,
    ///GDI-compatible family name. Because GDI allows a maximum of four fonts per family, fonts in the same family may
    ///have different GDI-compatible family names, for example "Arial", "Arial Narrow", "Arial Black".
    DWRITE_FONT_PROPERTY_ID_WIN32_FAMILY_NAME                = 0x00000005,
    ///The postscript name of the font, for example "GillSans-Bold", from name id 6 in the name table.
    DWRITE_FONT_PROPERTY_ID_POSTSCRIPT_NAME                  = 0x00000006,
    ///Script/language tag to identify the scripts or languages that the font was primarily designed to support.
    DWRITE_FONT_PROPERTY_ID_DESIGN_SCRIPT_LANGUAGE_TAG       = 0x00000007,
    ///Script/language tag to identify the scripts or languages that the font declares it is able to support.
    DWRITE_FONT_PROPERTY_ID_SUPPORTED_SCRIPT_LANGUAGE_TAG    = 0x00000008,
    ///Semantic tag to describe the font, for example Fancy, Decorative, Handmade, Sans-serif, Swiss, Pixel, Futuristic.
    DWRITE_FONT_PROPERTY_ID_SEMANTIC_TAG                     = 0x00000009,
    ///Weight of the font represented as a decimal string in the range 1-999.
    DWRITE_FONT_PROPERTY_ID_WEIGHT                           = 0x0000000a,
    ///Stretch of the font represented as a decimal string in the range 1-9.
    DWRITE_FONT_PROPERTY_ID_STRETCH                          = 0x0000000b,
    ///Style of the font represented as a decimal string in the range 0-2.
    DWRITE_FONT_PROPERTY_ID_STYLE                            = 0x0000000c,
    DWRITE_FONT_PROPERTY_ID_TYPOGRAPHIC_FACE_NAME            = 0x0000000d,
    ///Total number of properties.
    DWRITE_FONT_PROPERTY_ID_TOTAL                            = 0x0000000d,
    DWRITE_FONT_PROPERTY_ID_TOTAL_RS3                        = 0x0000000e,
    ///Family name preferred by the designer. This enables font designers to group more than four fonts in a single
    ///family without losing compatibility with GDI. This name is typically only present if it differs from the
    ///GDI-compatible family name.
    DWRITE_FONT_PROPERTY_ID_PREFERRED_FAMILY_NAME            = 0x00000002,
    ///Family name for the weight-width-slope model.
    DWRITE_FONT_PROPERTY_ID_FAMILY_NAME                      = 0x00000001,
    DWRITE_FONT_PROPERTY_ID_FACE_NAME                        = 0x00000003,
}

///Specifies the location of a resource.
alias DWRITE_LOCALITY = int;
enum : int
{
    ///The resource is remote, and information about it is unknown, including the file size and date. If you attempt to
    ///create a font or file stream, the creation will fail until locality becomes at least partial.
    DWRITE_LOCALITY_REMOTE  = 0x00000000,
    ///The resource is partially local, which means you can query the size and date of the file stream. With this type,
    ///you also might be able to create a font face and retrieve the particular glyphs for metrics and drawing, but not
    ///all the glyphs will be present.
    DWRITE_LOCALITY_PARTIAL = 0x00000001,
    DWRITE_LOCALITY_LOCAL   = 0x00000002,
}

///Specifies how glyphs are rendered.
alias DWRITE_RENDERING_MODE1 = int;
enum : int
{
    ///Specifies that the rendering mode is determined automatically, based on the font and size.
    DWRITE_RENDERING_MODE1_DEFAULT                       = 0x00000000,
    ///Specifies that no anti-aliasing is performed. Each pixel is either set to the foreground color of the text or
    ///retains the color of the background.
    DWRITE_RENDERING_MODE1_ALIASED                       = 0x00000001,
    ///Specifies that antialiasing is performed in the horizontal direction and the appearance of glyphs is
    ///layout-compatible with GDI using CLEARTYPE_QUALITY. Use DWRITE_MEASURING_MODE_GDI_CLASSIC to get glyph advances.
    ///The antialiasing may be either ClearType or grayscale depending on the text antialiasing mode.
    DWRITE_RENDERING_MODE1_GDI_CLASSIC                   = 0x00000002,
    ///Specifies that antialiasing is performed in the horizontal direction and the appearance of glyphs is
    ///layout-compatible with GDI using CLEARTYPE_NATURAL_QUALITY. Glyph advances are close to the font design advances,
    ///but are still rounded to whole pixels. Use DWRITE_MEASURING_MODE_GDI_NATURAL to get glyph advances. The
    ///antialiasing may be either ClearType or grayscale depending on the text antialiasing mode.
    DWRITE_RENDERING_MODE1_GDI_NATURAL                   = 0x00000003,
    ///Specifies that antialiasing is performed in the horizontal direction. This rendering mode allows glyphs to be
    ///positioned with subpixel precision and is therefore suitable for natural (i.e., resolution-independent) layout.
    ///The antialiasing may be either ClearType or grayscale depending on the text antialiasing mode.
    DWRITE_RENDERING_MODE1_NATURAL                       = 0x00000004,
    ///Similar to natural mode except that antialiasing is performed in both the horizontal and vertical directions.
    ///This is typically used at larger sizes to make curves and diagonal lines look smoother. The antialiasing may be
    ///either ClearType or grayscale depending on the text antialiasing mode.
    DWRITE_RENDERING_MODE1_NATURAL_SYMMETRIC             = 0x00000005,
    ///Specifies that rendering should bypass the rasterizer and use the outlines directly. This is typically used at
    ///very large sizes.
    DWRITE_RENDERING_MODE1_OUTLINE                       = 0x00000006,
    DWRITE_RENDERING_MODE1_NATURAL_SYMMETRIC_DOWNSAMPLED = 0x00000007,
}

///Specify whether DWRITE_FONT_METRICS::lineGap value should be part of the line metrics
alias DWRITE_FONT_LINE_GAP_USAGE = int;
enum : int
{
    ///The usage of the font line gap depends on the method used for text layout.
    DWRITE_FONT_LINE_GAP_USAGE_DEFAULT  = 0x00000000,
    ///The font line gap is excluded from line spacing.
    DWRITE_FONT_LINE_GAP_USAGE_DISABLED = 0x00000001,
    DWRITE_FONT_LINE_GAP_USAGE_ENABLED  = 0x00000002,
}

///Specifies the container format of a font resource. A container format is distinct from a font file format
///(DWRITE_FONT_FILE_TYPE) because the container describes the container in which the underlying font file is packaged.
alias DWRITE_CONTAINER_TYPE = int;
enum : int
{
    DWRITE_CONTAINER_TYPE_UNKNOWN = 0x00000000,
    DWRITE_CONTAINER_TYPE_WOFF    = 0x00000001,
    DWRITE_CONTAINER_TYPE_WOFF2   = 0x00000002,
}

///Defines constants that specify how font families are grouped together. Used by
///[IDWriteFontCollection2](./nn-dwrite_3-idwritefontcollection2.md), for example.
alias DWRITE_FONT_FAMILY_MODEL = int;
enum : int
{
    ///Families are grouped by the typographic family name preferred by the font author. The family can contain as many
    ///faces as the font author wants. This corresponds to DWRITE_FONT_PROPERTY_ID_TYPOGRAPHIC_FAMILY_NAME.
    DWRITE_FONT_FAMILY_MODEL_TYPOGRAPHIC          = 0x00000000,
    ///Families are grouped by the weight-stretch-style family name, where all faces that differ only by those three
    ///axes are grouped into the same family, but any other axes go into a distinct family. For example, the Sitka
    ///family with six different optical sizes yields six separate families (Sitka Caption, Display, Text, Subheading,
    ///Heading, Banner...). This corresponds to DWRITE_FONT_PROPERTY_ID_WEIGHT_STRETCH_STYLE_FAMILY_NAME.
    DWRITE_FONT_FAMILY_MODEL_WEIGHT_STRETCH_STYLE = 0x00000001,
}

///Defines constants that specifies axes that can be applied automatically in layout during font selection. Values can
///be bitwise OR'd together.
alias DWRITE_AUTOMATIC_FONT_AXES = int;
enum : int
{
    ///Specifies that no axes are automatically applied.
    DWRITE_AUTOMATIC_FONT_AXES_NONE         = 0x00000000,
    ///Specifies that&mdash;when no value is specified via DWRITE_FONT_AXIS_TAG_OPTICAL_SIZE&mdash;an appropriate
    ///optical value should be automatically chosen based on the font size (via IDWriteTextLayout::SetFontSize). You can
    ///still apply the 'opsz' value over text ranges via IDWriteTextFormat3::SetFontAxisValues, which take priority.
    DWRITE_AUTOMATIC_FONT_AXES_OPTICAL_SIZE = 0x00000001,
}

///Defines constants that specify attributes for a font axis. Values can be bitwise OR'd together.
alias DWRITE_FONT_AXIS_ATTRIBUTES = int;
enum : int
{
    ///Specifies no attributes.
    DWRITE_FONT_AXIS_ATTRIBUTES_NONE     = 0x00000000,
    ///Specifies that this axis is implemented as a variation axis in a variable font, with a continuous range of
    ///values, such as a range of weights from 100..900. Otherwise, it is either a static axis that holds a single
    ///point, or it has a range but doesn't vary, such as optical size in the Skia Heading font (which covers a range of
    ///points but doesn't interpolate any new glyph outlines).
    DWRITE_FONT_AXIS_ATTRIBUTES_VARIABLE = 0x00000001,
    ///Specifies that this axis is recommended to be remain hidden in user interfaces. The font developer may recommend
    ///this if an axis is intended to be accessed only programmatically, or is meant for font-internal or font-developer
    ///use only. The axis may be exposed in lower-level font inspection utilities, but should not be exposed in common
    ///nor even advanced-mode user interfaces in content-authoring apps.
    DWRITE_FONT_AXIS_ATTRIBUTES_HIDDEN   = 0x00000002,
}

///Defines constants that specify the mechanism by which a font came to be included in a font set.
alias DWRITE_FONT_SOURCE_TYPE = int;
enum : int
{
    ///Specifies that the font source is unknown, or is not any of the other defined font source types.
    DWRITE_FONT_SOURCE_TYPE_UNKNOWN              = 0x00000000,
    ///Specifies that the font source is a font file that's installed for all users on the device.
    DWRITE_FONT_SOURCE_TYPE_PER_MACHINE          = 0x00000001,
    ///Specifies that the font source is a font file that's installed for the current user.
    DWRITE_FONT_SOURCE_TYPE_PER_USER             = 0x00000002,
    ///Specifies that the font source is an APPX package, which includes one or more font files. The font source name is
    ///the full name of the package.
    DWRITE_FONT_SOURCE_TYPE_APPX_PACKAGE         = 0x00000003,
    ///Specifies that the font source is a font provider for downloadable fonts.
    DWRITE_FONT_SOURCE_TYPE_REMOTE_FONT_PROVIDER = 0x00000004,
}

///Indicates the measuring method used for text layout.
alias DWRITE_MEASURING_MODE = int;
enum : int
{
    ///Specifies that text is measured using glyph ideal metrics whose values are independent to the current display
    ///resolution.
    DWRITE_MEASURING_MODE_NATURAL     = 0x00000000,
    ///Specifies that text is measured using glyph display-compatible metrics whose values tuned for the current display
    ///resolution.
    DWRITE_MEASURING_MODE_GDI_CLASSIC = 0x00000001,
    DWRITE_MEASURING_MODE_GDI_NATURAL = 0x00000002,
}

///Specifies which formats are supported in the font, either at a font-wide level or per glyph.
alias DWRITE_GLYPH_IMAGE_FORMATS = int;
enum : int
{
    ///Indicates no data is available for this glyph.
    DWRITE_GLYPH_IMAGE_FORMATS_NONE                   = 0x00000000,
    ///The glyph has TrueType outlines.
    DWRITE_GLYPH_IMAGE_FORMATS_TRUETYPE               = 0x00000001,
    ///The glyph has CFF outlines.
    DWRITE_GLYPH_IMAGE_FORMATS_CFF                    = 0x00000002,
    ///The glyph has multilayered COLR data.
    DWRITE_GLYPH_IMAGE_FORMATS_COLR                   = 0x00000004,
    ///The glyph has SVG outlines as standard XML. Fonts may store the content gzip'd rather than plain text, indicated
    ///by the first two bytes as gzip header {0x1F 0x8B}.
    DWRITE_GLYPH_IMAGE_FORMATS_SVG                    = 0x00000008,
    ///The glyph has PNG image data, with standard PNG IHDR.
    DWRITE_GLYPH_IMAGE_FORMATS_PNG                    = 0x00000010,
    ///The glyph has JPEG image data, with standard JIFF SOI header.
    DWRITE_GLYPH_IMAGE_FORMATS_JPEG                   = 0x00000020,
    ///The glyph has TIFF image data.
    DWRITE_GLYPH_IMAGE_FORMATS_TIFF                   = 0x00000040,
    DWRITE_GLYPH_IMAGE_FORMATS_PREMULTIPLIED_B8G8R8A8 = 0x00000080,
}

// Structs


///The <b>DWRITE_FONT_METRICS</b> structure specifies the metrics that are applicable to all glyphs within the font
///face.
struct DWRITE_FONT_METRICS
{
    ///Type: <b>UINT16</b> The number of font design units per em unit. Font files use their own coordinate system of
    ///font design units. A font design unit is the smallest measurable unit in the em square, an imaginary square that
    ///is used to size and align glyphs. The concept of em square is used as a reference scale factor when defining font
    ///size and device transformation semantics. The size of one em square is also commonly used to compute the
    ///paragraph identation value.
    ushort designUnitsPerEm;
    ///Type: <b>UINT16</b> The ascent value of the font face in font design units. Ascent is the distance from the top
    ///of font character alignment box to the English baseline.
    ushort ascent;
    ///Type: <b>UINT16</b> The descent value of the font face in font design units. Descent is the distance from the
    ///bottom of font character alignment box to the English baseline.
    ushort descent;
    ///Type: <b>INT16</b> The line gap in font design units. Recommended additional white space to add between lines to
    ///improve legibility. The recommended line spacing (baseline-to-baseline distance) is the sum of <b>ascent</b>,
    ///<b>descent</b>, and <b>lineGap</b>. The line gap is usually positive or zero but can be negative, in which case
    ///the recommended line spacing is less than the height of the character alignment box.
    short  lineGap;
    ///Type: <b>UINT16</b> The cap height value of the font face in font design units. Cap height is the distance from
    ///the English baseline to the top of a typical English capital. Capital "H" is often used as a reference character
    ///for the purpose of calculating the cap height value.
    ushort capHeight;
    ///Type: <b>UINT16</b> The x-height value of the font face in font design units. x-height is the distance from the
    ///English baseline to the top of lowercase letter "x", or a similar lowercase character.
    ushort xHeight;
    ///Type: <b>INT16</b> The underline position value of the font face in font design units. Underline position is the
    ///position of underline relative to the English baseline. The value is usually made negative in order to place the
    ///underline below the baseline.
    short  underlinePosition;
    ///Type: <b>UINT16</b> The suggested underline thickness value of the font face in font design units.
    ushort underlineThickness;
    ///Type: <b>INT16</b> The strikethrough position value of the font face in font design units. Strikethrough position
    ///is the position of strikethrough relative to the English baseline. The value is usually made positive in order to
    ///place the strikethrough above the baseline.
    short  strikethroughPosition;
    ushort strikethroughThickness;
}

///Specifies the metrics of an individual glyph.The units depend on how the metrics are obtained.
struct DWRITE_GLYPH_METRICS
{
    ///Type: <b>INT32</b> Specifies the X offset from the glyph origin to the left edge of the black box. The glyph
    ///origin is the current horizontal writing position. A negative value means the black box extends to the left of
    ///the origin (often true for lowercase italic 'f').
    int  leftSideBearing;
    ///Type: <b>UINT32</b> Specifies the X offset from the origin of the current glyph to the origin of the next glyph
    ///when writing horizontally.
    uint advanceWidth;
    ///Type: <b>INT32</b> Specifies the X offset from the right edge of the black box to the origin of the next glyph
    ///when writing horizontally. The value is negative when the right edge of the black box overhangs the layout box.
    int  rightSideBearing;
    ///Type: <b>INT32</b> Specifies the vertical offset from the vertical origin to the top of the black box. Thus, a
    ///positive value adds whitespace whereas a negative value means the glyph overhangs the top of the layout box.
    int  topSideBearing;
    ///Type: <b>UINT32</b> Specifies the Y offset from the vertical origin of the current glyph to the vertical origin
    ///of the next glyph when writing vertically. Note that the term "origin" by itself denotes the horizontal origin.
    ///The vertical origin is different. Its Y coordinate is specified by <b>verticalOriginY</b> value, and its X
    ///coordinate is half the <b>advanceWidth</b> to the right of the horizontal origin.
    uint advanceHeight;
    ///Type: <b>INT32</b> Specifies the vertical distance from the bottom edge of the black box to the advance height.
    ///This is positive when the bottom edge of the black box is within the layout box, or negative when the bottom edge
    ///of black box overhangs the layout box.
    int  bottomSideBearing;
    int  verticalOriginY;
}

///The optional adjustment to a glyph's position.
struct DWRITE_GLYPH_OFFSET
{
    ///Type: <b>FLOAT</b> The offset in the advance direction of the run. A positive advance offset moves the glyph to
    ///the right (in pre-transform coordinates) if the run is left-to-right or to the left if the run is right-to-left.
    float advanceOffset;
    ///Type: <b>FLOAT</b> The offset in the ascent direction, that is, the direction ascenders point. A positive
    ///ascender offset moves the glyph up (in pre-transform coordinates). A negative ascender offset moves the glyph
    ///down.
    float ascenderOffset;
}

///The <b>DWRITE_MATRIX</b> structure specifies the graphics transform to be applied to rendered glyphs.
struct DWRITE_MATRIX
{
    ///Type: <b>FLOAT</b> A value indicating the horizontal scaling / cosine of rotation.
    float m11;
    ///Type: <b>FLOAT</b> A value indicating the vertical shear / sine of rotation.
    float m12;
    ///Type: <b>FLOAT</b> A value indicating the horizontal shear / negative sine of rotation.
    float m21;
    ///Type: <b>FLOAT</b> A value indicating the vertical scaling / cosine of rotation.
    float m22;
    ///Type: <b>FLOAT</b> A value indicating the horizontal shift (always orthogonal regardless of rotation).
    float dx;
    float dy;
}

///Specifies a range of text positions where format is applied in the text represented by an IDWriteTextLayout object.
struct DWRITE_TEXT_RANGE
{
    ///Type: <b>UINT32</b> The start position of the text range.
    uint startPosition;
    uint length;
}

///Specifies properties used to identify and execute typographic features in the current font face.
struct DWRITE_FONT_FEATURE
{
    ///Type: <b>DWRITE_FONT_FEATURE_TAG</b> The feature OpenType name identifier.
    DWRITE_FONT_FEATURE_TAG nameTag;
    ///Type: <b>UINT32</b> The execution parameter of the feature.
    uint parameter;
}

///Contains a set of typographic features to be applied during text shaping.
struct DWRITE_TYPOGRAPHIC_FEATURES
{
    ///Type: <b>DWRITE_FONT_FEATURE*</b> A pointer to a structure that specifies properties used to identify and execute
    ///typographic features in the font.
    DWRITE_FONT_FEATURE* features;
    uint                 featureCount;
}

///Specifies the trimming option for text overflowing the layout box.
struct DWRITE_TRIMMING
{
    ///Type: <b>DWRITE_TRIMMING_GRANULARITY</b> A value that specifies the text granularity used to trim text
    ///overflowing the layout box.
    DWRITE_TRIMMING_GRANULARITY granularity;
    ///Type: <b>UINT32</b> A character code used as the delimiter that signals the beginning of the portion of text to
    ///be preserved. Text starting from the Nth occurence of the delimiter (where N equals delimiterCount) counting
    ///backwards from the end of the text block will be preserved. For example, given the text is a path like
    ///c:\A\B\C\D\file.txt and delimiter equal to '\' and delimiterCount equal to 1, the file.txt portion of the text
    ///would be preserved. Specifying a delimiterCount of 2 would preserve D\file.txt.
    uint delimiter;
    uint delimiterCount;
}

///Stores the association of text and its writing system script, as well as some display attributes.
struct DWRITE_SCRIPT_ANALYSIS
{
    ///Type: <b>UINT16</b> The zero-based index representation of writing system script.
    ushort               script;
    ///Type: <b>DWRITE_SCRIPT_SHAPES</b> A value that indicates additional shaping requirement of text.
    DWRITE_SCRIPT_SHAPES shapes;
}

///Line breakpoint characteristics of a character.
struct DWRITE_LINE_BREAKPOINT
{
    ubyte _bitfield22;
}

///Shaping output properties for an output glyph.
struct DWRITE_SHAPING_TEXT_PROPERTIES
{
    ushort _bitfield23;
}

///Contains shaping output properties for an output glyph.
struct DWRITE_SHAPING_GLYPH_PROPERTIES
{
    ushort _bitfield24;
}

///Contains the information needed by renderers to draw glyph runs. All coordinates are in device independent pixels
///(DIPs).
struct DWRITE_GLYPH_RUN
{
    ///Type: <b>IDWriteFontFace*</b> The physical font face object to draw with.
    IDWriteFontFace fontFace;
    ///Type: <b>FLOAT</b> The logical size of the font in DIPs (equals 1/96 inch), not points.
    float           fontEmSize;
    ///Type: <b>UINT32</b> The number of glyphs in the glyph run.
    uint            glyphCount;
    ///Type: <b>const UINT16*</b> A pointer to an array of indices to render for the glyph run.
    const(ushort)*  glyphIndices;
    ///Type: <b>const FLOAT*</b> A pointer to an array containing glyph advance widths for the glyph run.
    const(float)*   glyphAdvances;
    ///Type: <b>const DWRITE_GLYPH_OFFSET*</b> A pointer to an array containing glyph offsets for the glyph run.
    const(DWRITE_GLYPH_OFFSET)* glyphOffsets;
    ///Type: <b>BOOL</b> If true, specifies that glyphs are rotated 90 degrees to the left and vertical metrics are
    ///used. Vertical writing is achieved by specifying <b>isSideways</b> = true and rotating the entire run 90 degrees
    ///to the right via a rotate transform.
    BOOL            isSideways;
    uint            bidiLevel;
}

///Contains additional properties related to those in DWRITE_GLYPH_RUN.
struct DWRITE_GLYPH_RUN_DESCRIPTION
{
    ///Type: <b>const WCHAR*</b> An array of characters containing the locale name associated with this run.
    const(PWSTR)   localeName;
    ///Type: <b>const WCHAR*</b> An array of characters containing the text associated with the glyphs.
    const(PWSTR)   string;
    ///Type: <b>UINT32</b> The number of characters in UTF16 code-units. Note that this may be different than the number
    ///of glyphs.
    uint           stringLength;
    ///Type: <b>const UINT16*</b> An array of indices to the glyph indices array, of the first glyphs of all the glyph
    ///clusters of the glyphs to render.
    const(ushort)* clusterMap;
    uint           textPosition;
}

///Contains information about the width, thickness, offset, run height, reading direction, and flow direction of an
///underline.
struct DWRITE_UNDERLINE
{
    ///Type: <b>FLOAT</b> A value that indicates the width of the underline, measured parallel to the baseline.
    float        width;
    ///Type: <b>FLOAT</b> A value that indicates the thickness of the underline, measured perpendicular to the baseline.
    float        thickness;
    ///Type: <b>FLOAT</b> A value that indicates the offset of the underline from the baseline. A positive offset
    ///represents a position below the baseline (away from the text) and a negative offset is above (toward the text).
    float        offset;
    ///Type: <b>FLOAT</b> A value that indicates the height of the tallest run where the underline is applied.
    float        runHeight;
    ///Type: <b>DWRITE_READING_DIRECTION</b> A value that indicates the reading direction of the text associated with
    ///the underline. This value is used to interpret whether the width value runs horizontally or vertically.
    DWRITE_READING_DIRECTION readingDirection;
    ///Type: <b>DWRITE_FLOW_DIRECTION</b> A value that indicates the flow direction of the text associated with the
    ///underline. This value is used to interpret whether the thickness value advances top to bottom, left to right, or
    ///right to left.
    DWRITE_FLOW_DIRECTION flowDirection;
    ///Type: <b>const WCHAR*</b> An array of characters which contains the locale of the text that the underline is
    ///being drawn under. For example, in vertical text, the underline belongs on the left for Chinese but on the right
    ///for Japanese.
    const(PWSTR) localeName;
    ///Type: <b>DWRITE_MEASURING_MODE</b> The measuring mode can be useful to the renderer to determine how underlines
    ///are rendered, such as rounding the thickness to a whole pixel in GDI-compatible modes.
    DWRITE_MEASURING_MODE measuringMode;
}

///Contains information regarding the size and placement of strikethroughs.All coordinates are in device independent
///pixels (DIPs).
struct DWRITE_STRIKETHROUGH
{
    ///Type: <b>FLOAT</b> A value that indicates the width of the strikethrough, measured parallel to the baseline.
    float        width;
    ///Type: <b>FLOAT</b> A value that indicates the thickness of the strikethrough, measured perpendicular to the
    ///baseline.
    float        thickness;
    ///Type: <b>FLOAT</b> A value that indicates the offset of the strikethrough from the baseline. A positive offset
    ///represents a position below the baseline and a negative offset is above. Typically, the offset will be negative.
    float        offset;
    ///Type: <b>DWRITE_READING_DIRECTION</b> Reading direction of the text associated with the strikethrough. This value
    ///is used to interpret whether the width value runs horizontally or vertically.
    DWRITE_READING_DIRECTION readingDirection;
    ///Type: <b>DWRITE_FLOW_DIRECTION</b> Flow direction of the text associated with the strikethrough. This value is
    ///used to interpret whether the thickness value advances top to bottom, left to right, or right to left.
    DWRITE_FLOW_DIRECTION flowDirection;
    ///Type: <b>const WCHAR*</b> An array of characters containing the locale of the text that is the strikethrough is
    ///being drawn over.
    const(PWSTR) localeName;
    DWRITE_MEASURING_MODE measuringMode;
}

///Contains information about a formatted line of text.
struct DWRITE_LINE_METRICS
{
    ///Type: <b>UINT32</b> The number of text positions in the text line. This includes any trailing whitespace and
    ///newline characters.
    uint  length;
    ///Type: <b>UINT32</b> The number of whitespace positions at the end of the text line. Newline sequences are
    ///considered whitespace.
    uint  trailingWhitespaceLength;
    ///Type: <b>UINT32</b> The number of characters in the newline sequence at the end of the text line. If the count is
    ///zero, then the text line was either wrapped or it is the end of the text.
    uint  newlineLength;
    ///Type: <b>FLOAT</b> The height of the text line.
    float height;
    ///Type: <b>FLOAT</b> The distance from the top of the text line to its baseline.
    float baseline;
    BOOL  isTrimmed;
}

///Contains information about a glyph cluster.
struct DWRITE_CLUSTER_METRICS
{
    ///Type: <b>FLOAT</b> The total advance width of all glyphs in the cluster.
    float  width;
    ///Type: <b>UINT16</b> The number of text positions in the cluster.
    ushort length;
    ushort _bitfield25;
}

///Contains the metrics associated with text after layout. All coordinates are in device independent pixels (DIPs).
struct DWRITE_TEXT_METRICS
{
    ///Type: <b>FLOAT</b> A value that indicates the left-most point of formatted text relative to the layout box, while
    ///excluding any glyph overhang.
    float left;
    ///Type: <b>FLOAT</b> A value that indicates the top-most point of formatted text relative to the layout box, while
    ///excluding any glyph overhang.
    float top;
    ///Type: <b>FLOAT</b> A value that indicates the width of the formatted text, while ignoring trailing whitespace at
    ///the end of each line.
    float width;
    ///Type: <b>FLOAT</b> The width of the formatted text, taking into account the trailing whitespace at the end of
    ///each line.
    float widthIncludingTrailingWhitespace;
    ///Type: <b>FLOAT</b> The height of the formatted text. The height of an empty string is set to the same value as
    ///that of the default font.
    float height;
    ///Type: <b>FLOAT</b> The initial width given to the layout. It can be either larger or smaller than the text
    ///content width, depending on whether the text was wrapped.
    float layoutWidth;
    ///Type: <b>FLOAT</b> Initial height given to the layout. Depending on the length of the text, it may be larger or
    ///smaller than the text content height.
    float layoutHeight;
    ///Type: <b>UINT32</b> The maximum reordering count of any line of text, used to calculate the most number of
    ///hit-testing boxes needed. If the layout has no bidirectional text, or no text at all, the minimum level is 1.
    uint  maxBidiReorderingDepth;
    uint  lineCount;
}

///Contains properties describing the geometric measurement of an application-defined inline object.
struct DWRITE_INLINE_OBJECT_METRICS
{
    ///Type: <b>FLOAT</b> The width of the inline object.
    float width;
    ///Type: <b>FLOAT</b> The height of the inline object.
    float height;
    ///Type: <b>FLOAT</b> The distance from the top of the object to the point where it is lined up with the adjacent
    ///text. If the baseline is at the bottom, then <b>baseline</b> simply equals <b>height</b>.
    float baseline;
    BOOL  supportsSideways;
}

///Indicates how much any visible DIPs (device independent pixels) overshoot each side of the layout or inline objects.
///Positive overhangs indicate that the visible area extends outside the layout box or inline object, while negative
///values mean there is whitespace inside. The returned values are unaffected by rendering transforms or pixel snapping.
///Additionally, they may not exactly match the final target's pixel bounds after applying grid fitting and hinting.
struct DWRITE_OVERHANG_METRICS
{
    ///Type: <b>FLOAT</b> The distance from the left-most visible DIP to its left-alignment edge.
    float left;
    ///Type: <b>FLOAT</b> The distance from the top-most visible DIP to its top alignment edge.
    float top;
    ///Type: <b>FLOAT</b> The distance from the right-most visible DIP to its right-alignment edge.
    float right;
    float bottom;
}

///Describes the region obtained by a hit test.
struct DWRITE_HIT_TEST_METRICS
{
    ///Type: <b>UINT32</b> The first text position within the hit region.
    uint  textPosition;
    ///Type: <b>UINT32</b> The number of text positions within the hit region.
    uint  length;
    ///Type: <b>FLOAT</b> The x-coordinate of the upper-left corner of the hit region.
    float left;
    ///Type: <b>FLOAT</b> The y-coordinate of the upper-left corner of the hit region.
    float top;
    ///Type: <b>FLOAT</b> The width of the hit region.
    float width;
    ///Type: <b>FLOAT</b> The height of the hit region.
    float height;
    ///Type: <b>UINT32</b> The BIDI level of the text positions within the hit region.
    uint  bidiLevel;
    ///Type: <b>BOOL</b> true if the hit region contains text; otherwise, false.
    BOOL  isText;
    BOOL  isTrimmed;
}

///The <b>DWRITE_FONT_METRICS1</b> structure specifies the metrics that are applicable to all glyphs within the font
///face.
struct DWRITE_FONT_METRICS1
{
    DWRITE_FONT_METRICS __AnonymousBase_DWrite_1_L627_C38;
    ///Left edge of accumulated bounding blackbox of all glyphs in the font.
    short               glyphBoxLeft;
    ///Top edge of accumulated bounding blackbox of all glyphs in the font.
    short               glyphBoxTop;
    ///Right edge of accumulated bounding blackbox of all glyphs in the font.
    short               glyphBoxRight;
    ///Bottom edge of accumulated bounding blackbox of all glyphs in the font.
    short               glyphBoxBottom;
    ///Horizontal position of the subscript relative to the baseline origin. This is typically negative (to the left) in
    ///italic and oblique fonts, and zero in regular fonts.
    short               subscriptPositionX;
    ///Vertical position of the subscript relative to the baseline. This is typically negative.
    short               subscriptPositionY;
    ///Horizontal size of the subscript em box in design units, used to scale the simulated subscript relative to the
    ///full em box size. This is the numerator of the scaling ratio where denominator is the design units per em. If
    ///this member is zero, the font does not specify a scale factor, and the client uses its own policy.
    short               subscriptSizeX;
    ///Vertical size of the subscript em box in design units, used to scale the simulated subscript relative to the full
    ///em box size. This is the numerator of the scaling ratio where denominator is the design units per em. If this
    ///member is zero, the font does not specify a scale factor, and the client uses its own policy.
    short               subscriptSizeY;
    ///Horizontal position of the superscript relative to the baseline origin. This is typically positive (to the right)
    ///in italic and oblique fonts, and zero in regular fonts.
    short               superscriptPositionX;
    ///Vertical position of the superscript relative to the baseline. This is typically positive.
    short               superscriptPositionY;
    ///Horizontal size of the superscript em box in design units, used to scale the simulated superscript relative to
    ///the full em box size. This is the numerator of the scaling ratio where denominator is the design units per em. If
    ///this member is zero, the font does not specify a scale factor, and the client should use its own policy.
    short               superscriptSizeX;
    ///Vertical size of the superscript em box in design units, used to scale the simulated superscript relative to the
    ///full em box size. This is the numerator of the scaling ratio where denominator is the design units per em. If
    ///this member is zero, the font does not specify a scale factor, and the client should use its own policy.
    short               superscriptSizeY;
    ///A Boolean value that indicates that the ascent, descent, and lineGap are based on newer 'typographic' values in
    ///the font, rather than legacy values.
    BOOL                hasTypographicMetrics;
}

///The <b>DWRITE_CARET_METRICS</b> structure specifies the metrics for caret placement in a font.
struct DWRITE_CARET_METRICS
{
    ///Vertical rise of the caret in font design units. Rise / Run yields the caret angle. Rise = 1 for perfectly
    ///upright fonts (non-italic).
    short slopeRise;
    ///Horizontal run of the caret in font design units. Rise / Run yields the caret angle. Run = 0 for perfectly
    ///upright fonts (non-italic).
    short slopeRun;
    ///Horizontal offset of the caret, in font design units, along the baseline for good appearance. Offset = 0 for
    ///perfectly upright fonts (non-italic).
    short offset;
}

///The <b>DWRITE_PANOSE</b> union describes typeface classification values that you use with IDWriteFont1::GetPanose to
///select and match the font.
union DWRITE_PANOSE
{
    ///A 10-byte array of typeface classification values.
    ubyte[10] values;
    ///A DWRITE_PANOSE_FAMILY-typed value that specifies the typeface classification values to get.
    ubyte     familyKind;
struct text
    {
        ubyte familyKind;
        ubyte serifStyle;
        ubyte weight;
        ubyte proportion;
        ubyte contrast;
        ubyte strokeVariation;
        ubyte armStyle;
        ubyte letterform;
        ubyte midline;
        ubyte xHeight;
    }
struct script
    {
        ubyte familyKind;
        ubyte toolKind;
        ubyte weight;
        ubyte spacing;
        ubyte aspectRatio;
        ubyte contrast;
        ubyte scriptTopology;
        ubyte scriptForm;
        ubyte finials;
        ubyte xAscent;
    }
struct decorative
    {
        ubyte familyKind;
        ubyte decorativeClass;
        ubyte weight;
        ubyte aspect;
        ubyte contrast;
        ubyte serifVariant;
        ubyte fill;
        ubyte lining;
        ubyte decorativeTopology;
        ubyte characterRange;
    }
struct symbol
    {
        ubyte familyKind;
        ubyte symbolKind;
        ubyte weight;
        ubyte spacing;
        ubyte aspectRatioAndContrast;
        ubyte aspectRatio94;
        ubyte aspectRatio119;
        ubyte aspectRatio157;
        ubyte aspectRatio163;
        ubyte aspectRatio211;
    }
}

///The <b>DWRITE_UNICODE_RANGE</b> structure specifies the range of Unicode code points.
struct DWRITE_UNICODE_RANGE
{
    ///The first code point in the Unicode range.
    uint first;
    ///The last code point in the Unicode range.
    uint last;
}

///The <b>DWRITE_SCRIPT_PROPERTIES</b> structure specifies script properties for caret navigation and justification.
struct DWRITE_SCRIPT_PROPERTIES
{
    ///The standardized four character code for the given script. <div class="alert"><b>Note</b> These only include the
    ///general Unicode scripts, not any additional ISO 15924 scripts for bibliographic distinction.</div> <div> </div>
    uint isoScriptCode;
    ///The standardized numeric code, ranging 0-999.
    uint isoScriptNumber;
    ///Number of characters to estimate look-ahead for complex scripts. Latin and all Kana are generally 1. Indic
    ///scripts are up to 15, and most others are 8. <div class="alert"><b>Note</b> Combining marks and variation
    ///selectors can produce clusters that are longer than these look-aheads, so this estimate is considered typical
    ///language use. Diacritics must be tested explicitly separately.</div> <div> </div>
    uint clusterLookahead;
    ///Appropriate character to elongate the given script for justification. For example: <ul> <li>Arabic - U+0640
    ///Tatweel</li> <li>Ogham - U+1680 Ogham Space Mark</li> </ul>
    uint justificationCharacter;
    uint _bitfield26;
}

///The <b>DWRITE_JUSTIFICATION_OPPORTUNITY</b> structure specifies justification info per glyph.
struct DWRITE_JUSTIFICATION_OPPORTUNITY
{
    ///Minimum amount of expansion to apply to the side of the glyph. This might vary from zero to infinity, typically
    ///being zero except for kashida.
    float expansionMinimum;
    ///Maximum amount of expansion to apply to the side of the glyph. This might vary from zero to infinity, being zero
    ///for fixed-size characters and connected scripts, and non-zero for discrete scripts, and non-zero for cursive
    ///scripts at expansion points.
    float expansionMaximum;
    ///Maximum amount of compression to apply to the side of the glyph. This might vary from zero up to the glyph
    ///cluster size.
    float compressionMaximum;
    uint  _bitfield27;
}

///Contains the metrics associated with text after layout.All coordinates are in device independent pixels (DIPs).
///<b>DWRITE_TEXT_METRICS1</b> extends DWRITE_TEXT_METRICS to include the height of the formatted text.
struct DWRITE_TEXT_METRICS1
{
    DWRITE_TEXT_METRICS Base;
    ///The height of the formatted text taking into account the trailing whitespace at the end of each line. This is
    ///pertinent for vertical text.
    float               heightIncludingTrailingWhitespace;
}

///Contains the information needed by renderers to draw glyph runs with glyph color information. All coordinates are in
///device independent pixels (DIPs).
struct DWRITE_COLOR_GLYPH_RUN
{
    ///Glyph run to draw for this layer.
    DWRITE_GLYPH_RUN glyphRun;
    ///Pointer to the glyph run description for this layer. This may be <b>NULL</b>. For example, when the original
    ///glyph run is split into multiple layers, one layer might have a description and the others have none.
    DWRITE_GLYPH_RUN_DESCRIPTION* glyphRunDescription;
    ///X coordinate of the baseline origin for the layer.
    float            baselineOriginX;
    ///Y coordinate of the baseline origin for the layer.
    float            baselineOriginY;
    ///Color value of the run; if all members are zero, the run should be drawn using the current brush.
    DXGI_RGBA        runColor;
    ushort           paletteIndex;
}

///Font property used for filtering font sets and building a font set with explicit properties.
struct DWRITE_FONT_PROPERTY
{
    ///Specifies the requested font property, such as DWRITE_FONT_PROPERTY_ID_FAMILY_NAME.
    DWRITE_FONT_PROPERTY_ID propertyId;
    ///Specifies the value, such as "Segoe UI".
    const(PWSTR) propertyValue;
    const(PWSTR) localeName;
}

///Contains information about a formatted line of text.
struct DWRITE_LINE_METRICS1
{
    DWRITE_LINE_METRICS Base;
    ///Type: <b>FLOAT</b> White space before the content of the line. This is included in the line height and baseline
    ///distances. If the line is formatted horizontally either with a uniform line spacing or with proportional line
    ///spacing, this value represents the extra space above the content.
    float               leadingBefore;
    float               leadingAfter;
}

///Sets the vertical spacing between lines of text.
struct DWRITE_LINE_SPACING
{
    ///Type: <b>DWRITE_LINE_SPACING_METHOD</b> Method used to determine line spacing.
    DWRITE_LINE_SPACING_METHOD method;
    ///Type: <b>FLOAT</b> Spacing between lines. The interpretation of this parameter depends upon the line spacing
    ///method, as follows: <ul> <li>Line spacing: ignored</li> <li>uniform line spacing: explicit distance in DIPs
    ///between lines</li> <li>proportional line spacing: a scaling factor to be applied to the computed line height; for
    ///each line, the height of the line is computed as for default line spacing, and the scaling factor is applied to
    ///that value.</li> </ul>
    float height;
    ///Type: <b>FLOAT</b> Distance from top of line to baseline. The interpretation of this parameter depends upon the
    ///line spacing method, as follows: <ul> <li>default line spacing: ignored</li> <li>uniform line spacing: explicit
    ///distance in DIPs from the top of the line to the baseline</li> <li>proportional line spacing: a scaling factor
    ///applied to the computed baseline; for each line, the baseline distance is computed as for default line spacing,
    ///and the scaling factor is applied to that value.</li> </ul>
    float baseline;
    ///Type: <b>FLOAT</b> Proportion of the entire leading distributed before the line. The allowed value is between 0
    ///and 1.0. The remaining leading is distributed after the line. It is ignored for the default and uniform line
    ///spacing methods. The leading that is available to distribute before or after the line depends on the values of
    ///the height and baseline parameters.
    float leadingBefore;
    DWRITE_FONT_LINE_GAP_USAGE fontLineGapUsage;
}

///Represents a color glyph run. The IDWriteFactory4::TranslateColorGlyphRun method returns an ordered collection of
///color glyph runs of varying types depending on what the font supports.
struct DWRITE_COLOR_GLYPH_RUN1
{
    DWRITE_COLOR_GLYPH_RUN Base;
    ///Type of glyph image format for this color run. Exactly one type will be set since TranslateColorGlyphRun has
    ///already broken down the run into separate parts.
    DWRITE_GLYPH_IMAGE_FORMATS glyphImageFormat;
    ///Measuring mode to use for this glyph run.
    DWRITE_MEASURING_MODE measuringMode;
}

///Data for a single glyph from GetGlyphImageData.
struct DWRITE_GLYPH_IMAGE_DATA
{
    ///Pointer to the glyph data.
    const(void)* imageData;
    ///Size of glyph data in bytes.
    uint         imageDataSize;
    ///Unique identifier for the glyph data. Clients may use this to cache a parsed/decompressed version and tell
    ///whether a repeated call to the same font returns the same data.
    uint         uniqueDataId;
    ///Pixels per em of the returned data. For non-scalable raster data (PNG/TIFF/JPG), this can be larger or smaller
    ///than requested from GetGlyphImageData when there isn't an exact match. For scaling intermediate sizes, use:
    ///desired pixels per em * font em size / actual pixels per em.
    uint         pixelsPerEm;
    ///Size of image when the format is pixel data.
    D2D_SIZE_U   pixelSize;
    ///Left origin along the horizontal Roman baseline.
    POINT        horizontalLeftOrigin;
    ///Right origin along the horizontal Roman baseline.
    POINT        horizontalRightOrigin;
    ///Top origin along the vertical central baseline.
    POINT        verticalTopOrigin;
    POINT        verticalBottomOrigin;
}

///Represents a range of bytes in a font file.
struct DWRITE_FILE_FRAGMENT
{
    ///Starting offset of the fragment from the beginning of the file.
    ulong fileOffset;
    ///Size of the file fragment, in bytes.
    ulong fragmentSize;
}

///Represents a value for a font axis. Used when querying and creating font instances (for example, see
///[IDWriteFontFace5::GetFontAxisValues](./nf-dwrite_3-idwritefontface5-getfontaxisvalues.md)).
struct DWRITE_FONT_AXIS_VALUE
{
    ///Type: **[DWRITE_FONT_AXIS_TAG](./ne-dwrite_3-dwrite_font_axis_tag.md)** The four-character identifier of the font
    ///axis (for example, weight, width, slant, italic, and so on).
    DWRITE_FONT_AXIS_TAG axisTag;
    ///Type: **[FLOAT](/windows/win32/winprog/windows-data-types)** A value for the axis specified in `axisTag`. The
    ///meaning and range of the value depends on the semantics of the particular axis. Certain well-known axes have
    ///standard ranges and defaults. Here are some examples. - Weight (1..1000, default == 400) - Width (>0, default ==
    ///100) - Slant (-90..90, default == -20) - Italic (0 or 1)
    float                value;
}

///Represents the minimum and maximum range of the possible values for a font axis. If *minValue* equals *maxValue*,
///then the axis is static rather than variable.
struct DWRITE_FONT_AXIS_RANGE
{
    ///Type: **[DWRITE_FONT_AXIS_TAG](./ne-dwrite_3-dwrite_font_axis_tag.md)** The four-character identifier of the font
    ///axis (for example, weight, width, slant, italic, and so on).
    DWRITE_FONT_AXIS_TAG axisTag;
    ///Type: **[FLOAT](/windows/win32/winprog/windows-data-types)** The minimum value supported by this axis.
    float                minValue;
    ///Type: **[FLOAT](/windows/win32/winprog/windows-data-types)** The maximum value supported by this axis.
    float                maxValue;
}

// Functions

///Creates a DirectWrite factory object that is used for subsequent creation of individual DirectWrite objects.
///Params:
///    factoryType = Type: <b>DWRITE_FACTORY_TYPE</b> A value that specifies whether the factory object will be shared or isolated.
///    iid = Type: <b>REFIID</b> A GUID value that identifies the DirectWrite factory interface, such as
///          __uuidof(IDWriteFactory).
///    factory = Type: <b>IUnknown**</b> An address of a pointer to the newly created DirectWrite factory object.
///Returns:
///    Type: <b>HRESULT</b> If this function succeeds, it returns <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("DWrite")
HRESULT DWriteCreateFactory(DWRITE_FACTORY_TYPE factoryType, const(GUID)* iid, IUnknown* factory);


// Interfaces

///Handles loading font file resources of a particular type from a font file reference key into a font file stream
///object.
@GUID("727CAD4E-D6AF-4C9E-8A08-D695B11CAA49")
interface IDWriteFontFileLoader : IUnknown
{
    ///Creates a font file stream object that encapsulates an open file resource.
    ///Params:
    ///    fontFileReferenceKey = Type: <b>const void*</b> A pointer to a font file reference key that uniquely identifies the font file
    ///                           resource within the scope of the font loader being used. The buffer allocated for this key must at least be
    ///                           the size, in bytes, specified by <i> fontFileReferenceKeySize</i>.
    ///    fontFileReferenceKeySize = Type: <b>UINT32</b> The size of font file reference key, in bytes.
    ///    fontFileStream = Type: <b>IDWriteFontFileStream**</b> When this method returns, contains the address of a pointer to the newly
    ///                     created IDWriteFontFileStream object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateStreamFromKey(const(void)* fontFileReferenceKey, uint fontFileReferenceKeySize, 
                                IDWriteFontFileStream* fontFileStream);
}

///A built-in implementation of the IDWriteFontFileLoader interface, that operates on local font files and exposes local
///font file information from the font file reference key. Font file references created using CreateFontFileReference
///use this font file loader.
@GUID("B2D9F3EC-C9FE-4A11-A2EC-D86208F7C0A2")
interface IDWriteLocalFontFileLoader : IDWriteFontFileLoader
{
    ///Obtains the length of the absolute file path from the font file reference key.
    ///Params:
    ///    fontFileReferenceKey = Type: <b>const void*</b> Font file reference key that uniquely identifies the local font file within the
    ///                           scope of the font loader being used.
    ///    fontFileReferenceKeySize = Type: <b>UINT32</b> Size of font file reference key in bytes.
    ///    filePathLength = Type: <b>UINT32*</b> Length of the file path string, not including the terminated <b>NULL</b> character.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetFilePathLengthFromKey(const(void)* fontFileReferenceKey, uint fontFileReferenceKeySize, 
                                     uint* filePathLength);
    ///Obtains the absolute font file path from the font file reference key.
    ///Params:
    ///    fontFileReferenceKey = Type: <b>const void*</b> The font file reference key that uniquely identifies the local font file within the
    ///                           scope of the font loader being used.
    ///    fontFileReferenceKeySize = Type: <b>UINT32</b> The size of font file reference key in bytes.
    ///    filePath = Type: <b>WCHAR*</b> The character array that receives the local file path.
    ///    filePathSize = Type: <b>UINT32</b> The length of the file path character array.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetFilePathFromKey(const(void)* fontFileReferenceKey, uint fontFileReferenceKeySize, PWSTR filePath, 
                               uint filePathSize);
    ///Obtains the last write time of the file from the font file reference key.
    ///Params:
    ///    fontFileReferenceKey = Type: <b>const void*</b> The font file reference key that uniquely identifies the local font file within the
    ///                           scope of the font loader being used.
    ///    fontFileReferenceKeySize = Type: <b>UINT32</b> The size of font file reference key in bytes.
    ///    lastWriteTime = Type: <b>FILETIME*</b> The time of the last font file modification.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetLastWriteTimeFromKey(const(void)* fontFileReferenceKey, uint fontFileReferenceKeySize, 
                                    FILETIME* lastWriteTime);
}

///Loads font file data from a custom font file loader.
@GUID("6D4865FE-0AB8-4D91-8F62-5DD6BE34A3E0")
interface IDWriteFontFileStream : IUnknown
{
    ///Reads a fragment from a font file.
    ///Params:
    ///    fragmentStart = Type: <b>const void**</b> When this method returns, contains an address of a pointer to the start of the font
    ///                    file fragment. This parameter is passed uninitialized.
    ///    fileOffset = Type: <b>UINT64</b> The offset of the fragment, in bytes, from the beginning of the font file.
    ///    fragmentSize = Type: <b>UINT64</b> The size of the file fragment, in bytes.
    ///    fragmentContext = Type: <b>void**</b> When this method returns, contains the address of a pointer to a pointer to the
    ///                      client-defined context to be passed to ReleaseFileFragment.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ReadFileFragment(const(void)** fragmentStart, ulong fileOffset, ulong fragmentSize, 
                             void** fragmentContext);
    ///Releases a fragment from a file.
    ///Params:
    ///    fragmentContext = Type: <b>void*</b> A pointer to the client-defined context of a font fragment returned from ReadFileFragment.
    void    ReleaseFileFragment(void* fragmentContext);
    ///Obtains the total size of a file.
    ///Params:
    ///    fileSize = Type: <b>UINT64*</b> When this method returns, contains the total size of the file.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetFileSize(ulong* fileSize);
    ///Obtains the last modified time of the file.
    ///Params:
    ///    lastWriteTime = Type: <b>UINT64*</b> When this method returns, contains the last modified time of the file in the format that
    ///                    represents the number of 100-nanosecond intervals since January 1, 1601 (UTC).
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetLastWriteTime(ulong* lastWriteTime);
}

///Represents a font file. Applications such as font managers or font viewers can call IDWriteFontFile::Analyze to find
///out if a particular file is a font file, and whether it is a font type that is supported by the font system.
@GUID("739D886A-CEF5-47DC-8769-1A8B41BEBBB0")
interface IDWriteFontFile : IUnknown
{
    ///Obtains the pointer to the reference key of a font file. The returned pointer is valid until the font file object
    ///is released.
    ///Params:
    ///    fontFileReferenceKey = Type: <b>const void**</b> When this method returns, contains an address of a pointer to the font file
    ///                           reference key. Note that the pointer value is only valid until the font file object it is obtained from is
    ///                           released. This parameter is passed uninitialized.
    ///    fontFileReferenceKeySize = Type: <b>UINT32*</b> When this method returns, contains the size of the font file reference key in bytes.
    ///                               This parameter is passed uninitialized.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetReferenceKey(const(void)** fontFileReferenceKey, uint* fontFileReferenceKeySize);
    ///Obtains the file loader associated with a font file object.
    ///Params:
    ///    fontFileLoader = Type: <b>IDWriteFontFileLoader**</b> When this method returns, contains the address of a pointer to the font
    ///                     file loader associated with the font file object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetLoader(IDWriteFontFileLoader* fontFileLoader);
    ///Analyzes a file and returns whether it represents a font, and whether the font type is supported by the font
    ///system.
    ///Params:
    ///    isSupportedFontType = Type: <b>BOOL*</b> <b>TRUE</b> if the font type is supported by the font system; otherwise, <b>FALSE</b>.
    ///    fontFileType = Type: <b>DWRITE_FONT_FILE_TYPE*</b> When this method returns, contains a value that indicates the type of the
    ///                   font file. Note that even if <i> isSupportedFontType</i> is <b>FALSE</b>, the <i>fontFileType</i> value may
    ///                   be different from <b>DWRITE_FONT_FILE_TYPE_UNKNOWN</b>.
    ///    fontFaceType = Type: <b>DWRITE_FONT_FACE_TYPE*</b> When this method returns, contains a value that indicates the type of the
    ///                   font face. If <i>fontFileType</i> is not equal to <b>DWRITE_FONT_FILE_TYPE_UNKNOWN</b>, then that can be
    ///                   constructed from the font file.
    ///    numberOfFaces = Type: <b>UINT32*</b> When this method returns, contains the number of font faces contained in the font file.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Analyze(BOOL* isSupportedFontType, DWRITE_FONT_FILE_TYPE* fontFileType, 
                    DWRITE_FONT_FACE_TYPE* fontFaceType, uint* numberOfFaces);
}

///Represents text rendering settings such as ClearType level, enhanced contrast, and gamma correction for glyph
///rasterization and filtering. An application typically obtains a rendering parameters object by calling the
///IDWriteFactory::CreateMonitorRenderingParams method.
@GUID("2F0DA53A-2ADD-47CD-82EE-D9EC34688E75")
interface IDWriteRenderingParams : IUnknown
{
    ///Gets the gamma value used for gamma correction. Valid values must be greater than zero and cannot exceed 256.
    ///Returns:
    ///    Type: <b>FLOAT</b> Returns the gamma value used for gamma correction. Valid values must be greater than zero
    ///    and cannot exceed 256.
    ///    
    float GetGamma();
    ///Gets the enhanced contrast property of the rendering parameters object. Valid values are greater than or equal to
    ///zero.
    ///Returns:
    ///    Type: <b>FLOAT</b> Returns the amount of contrast enhancement. Valid values are greater than or equal to
    ///    zero.
    ///    
    float GetEnhancedContrast();
    ///Gets the ClearType level of the rendering parameters object.
    ///Returns:
    ///    Type: <b>FLOAT</b> The ClearType level of the rendering parameters object.
    ///    
    float GetClearTypeLevel();
    ///Gets the pixel geometry of the rendering parameters object.
    ///Returns:
    ///    Type: <b>DWRITE_PIXEL_GEOMETRY</b> A value that indicates the type of pixel geometry used in the rendering
    ///    parameters object.
    ///    
    DWRITE_PIXEL_GEOMETRY GetPixelGeometry();
    ///Gets the rendering mode of the rendering parameters object.
    ///Returns:
    ///    Type: <b>DWRITE_RENDERING_MODE</b> A value that indicates the rendering mode of the rendering parameters
    ///    object.
    ///    
    DWRITE_RENDERING_MODE GetRenderingMode();
}

///This interface exposes various font data such as metrics, names, and glyph outlines. It contains font face type,
///appropriate file references, and face identification data.
@GUID("5F49804D-7024-4D43-BFA9-D25984F53849")
interface IDWriteFontFace : IUnknown
{
    ///Obtains the file format type of a font face.
    ///Returns:
    ///    Type: <b>DWRITE_FONT_FACE_TYPE</b> A value that indicates the type of format for the font face (such as Type
    ///    1, TrueType, vector, or bitmap).
    ///    
    DWRITE_FONT_FACE_TYPE GetType();
    ///Obtains the font files representing a font face.
    ///Params:
    ///    numberOfFiles = Type: <b>UINT32*</b> If <i>fontFiles</i> is <b>NULL</b>, receives the number of files representing the font
    ///                    face. Otherwise, the number of font files being requested should be passed. See the Remarks section below for
    ///                    more information.
    ///    fontFiles = Type: <b>IDWriteFontFile**</b> When this method returns, contains a pointer to a user-provided array that
    ///                stores pointers to font files representing the font face. This parameter can be <b>NULL</b> if the user wants
    ///                only the number of files representing the font face. This API increments reference count of the font file
    ///                pointers returned according to COM conventions, and the client should release them when finished.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetFiles(uint* numberOfFiles, IDWriteFontFile* fontFiles);
    ///Obtains the index of a font face in the context of its font files.
    ///Returns:
    ///    Type: <b>UINT32</b> The zero-based index of a font face in cases when the font files contain a collection of
    ///    font faces. If the font files contain a single face, this value is zero.
    ///    
    uint    GetIndex();
    ///Obtains the algorithmic style simulation flags of a font face.
    ///Returns:
    ///    Type: <b>DWRITE_FONT_SIMULATIONS</b> Font face simulation flags for algorithmic means of making text bold or
    ///    italic.
    ///    
    DWRITE_FONT_SIMULATIONS GetSimulations();
    ///Determines whether the font is a symbol font.
    ///Returns:
    ///    Type: <b>BOOL</b> Returns <b>TRUE</b> if the font is a symbol font, otherwise <b>FALSE</b>.
    ///    
    BOOL    IsSymbolFont();
    ///Obtains design units and common metrics for the font face. These metrics are applicable to all the glyphs within
    ///a font face and are used by applications for layout calculations.
    ///Params:
    ///    fontFaceMetrics = Type: <b>DWRITE_FONT_METRICS*</b> When this method returns, a DWRITE_FONT_METRICS structure that holds
    ///                      metrics (such as ascent, descent, or cap height) for the current font face element. The metrics returned by
    ///                      this function are in font design units.
    void    GetMetrics(DWRITE_FONT_METRICS* fontFaceMetrics);
    ///Obtains the number of glyphs in the font face.
    ///Returns:
    ///    Type: <b>UINT16</b> The number of glyphs in the font face.
    ///    
    ushort  GetGlyphCount();
    ///Obtains ideal (resolution-independent) glyph metrics in font design units.
    ///Params:
    ///    glyphIndices = Type: <b>const UINT16*</b> An array of glyph indices for which to compute metrics. The array must contain at
    ///                   least as many elements as specified by <i>glyphCount</i>.
    ///    glyphCount = Type: <b>UINT32</b> The number of elements in the <i>glyphIndices</i> array.
    ///    glyphMetrics = Type: <b>DWRITE_GLYPH_METRICS*</b> When this method returns, contains an array of DWRITE_GLYPH_METRICS
    ///                   structures. <i>glyphMetrics</i> must be initialized with an empty buffer that contains at least as many
    ///                   elements as <i>glyphCount</i>. The metrics returned by this function are in font design units.
    ///    isSideways = Type: <b>BOOL</b> Indicates whether the font is being used in a sideways run. This can affect the glyph
    ///                 metrics if the font has oblique simulation because sideways oblique simulation differs from non-sideways
    ///                 oblique simulation
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetDesignGlyphMetrics(const(ushort)* glyphIndices, uint glyphCount, DWRITE_GLYPH_METRICS* glyphMetrics, 
                                  BOOL isSideways);
    HRESULT GetGlyphIndicesA(const(uint)* codePoints, uint codePointCount, ushort* glyphIndices);
    ///Finds the specified OpenType font table if it exists and returns a pointer to it. The function accesses the
    ///underlying font data through the IDWriteFontFileStream interface implemented by the font file loader.
    ///Params:
    ///    openTypeTableTag = Type: <b>UINT32</b> The four-character tag of a OpenType font table to find. Use the
    ///                       <b>DWRITE_MAKE_OPENTYPE_TAG</b> macro to create it as an <b>UINT32</b>. Unlike GDI, it does not support the
    ///                       special TTCF and null tags to access the whole font.
    ///    tableData = Type: <b>const void**</b> When this method returns, contains the address of a pointer to the base of the
    ///                table in memory. The pointer is valid only as long as the font face used to get the font table still exists;
    ///                (not any other font face, even if it actually refers to the same physical font). This parameter is passed
    ///                uninitialized.
    ///    tableSize = Type: <b>UINT32*</b> When this method returns, contains a pointer to the size, in bytes, of the font table.
    ///    tableContext = Type: <b>void**</b> When this method returns, the address of a pointer to the opaque context, which must be
    ///                   freed by calling ReleaseFontTable. The context actually comes from the lower-level IDWriteFontFileStream,
    ///                   which may be implemented by the application or DWrite itself. It is possible for a <b>NULL</b>
    ///                   <i>tableContext</i> to be returned, especially if the implementation performs direct memory mapping on the
    ///                   whole file. Nevertheless, always release it later, and do not use it as a test for function success. The same
    ///                   table can be queried multiple times, but because each returned context can be different, you must release
    ///                   each context separately.
    ///    exists = Type: <b>BOOL*</b> When this method returns, <b>TRUE</b> if the font table exists; otherwise, <b>FALSE</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT TryGetFontTable(uint openTypeTableTag, const(void)** tableData, uint* tableSize, void** tableContext, 
                            BOOL* exists);
    ///Releases the table obtained earlier from TryGetFontTable.
    ///Params:
    ///    tableContext = Type: <b>void*</b> A pointer to the opaque context from TryGetFontTable.
    void    ReleaseFontTable(void* tableContext);
    ///Computes the outline of a run of glyphs by calling back to the outline sink interface.
    ///Params:
    ///    emSize = Type: <b>FLOAT</b> The logical size of the font in DIP units. A DIP ("device-independent pixel") equals 1/96
    ///             inch.
    ///    glyphIndices = Type: <b>const UINT16*</b> An array of glyph indices. The glyphs are in logical order and the advance
    ///                   direction depends on the <i>isRightToLeft</i> parameter. The array must be allocated and be able to contain
    ///                   the number of elements specified by <i>glyphCount</i>.
    ///    glyphAdvances = Type: <b>const FLOAT*</b> An optional array of glyph advances in DIPs. The advance of a glyph is the amount
    ///                    to advance the position (in the direction of the baseline) after drawing the glyph. <i>glyphAdvances</i>
    ///                    contains the number of elements specified by <i>glyphCount</i>.
    ///    glyphOffsets = Type: <b>const DWRITE_GLYPH_OFFSET*</b> An optional array of glyph offsets, each of which specifies the
    ///                   offset along the baseline and offset perpendicular to the baseline of a glyph relative to the current pen
    ///                   position. <i>glyphOffsets</i> contains the number of elements specified by <i>glyphCount</i>.
    ///    glyphCount = Type: <b>UINT32</b> The number of glyphs in the run.
    ///    isSideways = Type: <b>BOOL</b> If <b>TRUE</b>, the ascender of the glyph runs alongside the baseline. If <b>FALSE</b>, the
    ///                 glyph ascender runs perpendicular to the baseline. For example, an English alphabet on a vertical baseline
    ///                 would have <i>isSideways</i> set to <b>FALSE</b>. A client can render a vertical run by setting
    ///                 <i>isSideways</i> to <b>TRUE</b> and rotating the resulting geometry 90 degrees to the right using a
    ///                 transform. The <i>isSideways</i> and <i>isRightToLeft</i> parameters cannot both be true.
    ///    isRightToLeft = Type: <b>BOOL</b> The visual order of the glyphs. If this parameter is <b>FALSE</b>, then glyph advances are
    ///                    from left to right. If <b>TRUE</b>, the advance direction is right to left. By default, the advance direction
    ///                    is left to right.
    ///    geometrySink = Type: <b>IDWriteGeometrySink*</b> A pointer to the interface that is called back to perform outline drawing
    ///                   operations.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetGlyphRunOutline(float emSize, const(ushort)* glyphIndices, const(float)* glyphAdvances, 
                               const(DWRITE_GLYPH_OFFSET)* glyphOffsets, uint glyphCount, BOOL isSideways, 
                               BOOL isRightToLeft, ID2D1SimplifiedGeometrySink geometrySink);
    ///Determines the recommended rendering mode for the font, using the specified size and rendering parameters.
    ///Params:
    ///    emSize = Type: <b>FLOAT</b> The logical size of the font in DIP units. A DIP ("device-independent pixel") equals 1/96
    ///             inch.
    ///    pixelsPerDip = Type: <b>FLOAT</b> The number of physical pixels per DIP. For example, if the DPI of the rendering surface is
    ///                   96, this value is 1.0f. If the DPI is 120, this value is 120.0f/96.
    ///    measuringMode = Type: <b>DWRITE_MEASURING_MODE</b> The measuring method that will be used for glyphs in the font. Renderer
    ///                    implementations may choose different rendering modes for different measuring methods, for example: <ul>
    ///                    <li>DWRITE_RENDERING_MODE_CLEARTYPE_NATURAL for DWRITE_MEASURING_MODE_NATURAL </li>
    ///                    <li>DWRITE_RENDERING_MODE_CLEARTYPE_GDI_CLASSIC for DWRITE_MEASURING_MODE_GDI_CLASSIC </li>
    ///                    <li>DWRITE_RENDERING_MODE_CLEARTYPE_GDI_NATURAL for DWRITE_MEASURING_MODE_GDI_NATURAL </li> </ul>
    ///    renderingParams = Type: <b>IDWriteRenderingParams*</b> A pointer to an object that contains rendering settings such as gamma
    ///                      level, enhanced contrast, and ClearType level. This parameter is necessary in case the rendering parameters
    ///                      object overrides the rendering mode.
    ///    renderingMode = Type: <b>DWRITE_RENDERING_MODE*</b> When this method returns, contains a value that indicates the recommended
    ///                    rendering mode to use.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetRecommendedRenderingMode(float emSize, float pixelsPerDip, DWRITE_MEASURING_MODE measuringMode, 
                                        IDWriteRenderingParams renderingParams, DWRITE_RENDERING_MODE* renderingMode);
    ///Obtains design units and common metrics for the font face. These metrics are applicable to all the glyphs within
    ///a fontface and are used by applications for layout calculations.
    ///Params:
    ///    emSize = Type: <b>FLOAT</b> The logical size of the font in DIP units.
    ///    pixelsPerDip = Type: <b>FLOAT</b> The number of physical pixels per DIP.
    ///    transform = Type: <b>const DWRITE_MATRIX*</b> An optional transform applied to the glyphs and their positions. This
    ///                transform is applied after the scaling specified by the font size and <i>pixelsPerDip</i>.
    ///    fontFaceMetrics = Type: <b>DWRITE_FONT_METRICS*</b> A pointer to a DWRITE_FONT_METRICS structure to fill in. The metrics
    ///                      returned by this function are in font design units.
    ///Returns:
    ///    Type: <b>HRESULT</b> Standard HRESULT error code.
    ///    
    HRESULT GetGdiCompatibleMetrics(float emSize, float pixelsPerDip, const(DWRITE_MATRIX)* transform, 
                                    DWRITE_FONT_METRICS* fontFaceMetrics);
    ///Obtains glyph metrics in font design units with the return values compatible with what GDI would produce.
    ///Params:
    ///    emSize = Type: <b>FLOAT</b> The ogical size of the font in DIP units.
    ///    pixelsPerDip = Type: <b>FLOAT</b> The number of physical pixels per DIP.
    ///    transform = Type: <b>const DWRITE_MATRIX*</b> An optional transform applied to the glyphs and their positions. This
    ///                transform is applied after the scaling specified by the font size and <i>pixelsPerDip</i>.
    ///    useGdiNatural = Type: <b>BOOL</b> When set to <b>FALSE</b>, the metrics are the same as the metrics of GDI aliased text. When
    ///                    set to <b>TRUE</b>, the metrics are the same as the metrics of text measured by GDI using a font created with
    ///                    <b>CLEARTYPE_NATURAL_QUALITY</b>.
    ///    glyphIndices = Type: <b>const UINT16*</b> An array of glyph indices for which to compute the metrics.
    ///    glyphCount = Type: <b>UINT32</b> The number of elements in the <i>glyphIndices</i> array.
    ///    glyphMetrics = Type: <b>DWRITE_GLYPH_METRICS*</b> An array of DWRITE_GLYPH_METRICS structures filled by this function. The
    ///                   metrics are in font design units.
    ///    isSideways = Type: <b>BOOL</b> A BOOL value that indicates whether the font is being used in a sideways run. This can
    ///                 affect the glyph metrics if the font has oblique simulation because sideways oblique simulation differs from
    ///                 non-sideways oblique simulation.
    ///Returns:
    ///    Type: <b>HRESULT</b> Standard <b>HRESULT</b> error code. If any of the input glyph indices are outside of the
    ///    valid glyph index range for the current font face, <b>E_INVALIDARG</b> will be returned.
    ///    
    HRESULT GetGdiCompatibleGlyphMetrics(float emSize, float pixelsPerDip, const(DWRITE_MATRIX)* transform, 
                                         BOOL useGdiNatural, const(ushort)* glyphIndices, uint glyphCount, 
                                         DWRITE_GLYPH_METRICS* glyphMetrics, BOOL isSideways);
}

///Used to construct a collection of fonts given a particular type of key.
@GUID("CCA920E4-52F0-492B-BFA8-29C72EE0A468")
interface IDWriteFontCollectionLoader : IUnknown
{
    ///Creates a font file enumerator object that encapsulates a collection of font files. The font system calls back to
    ///this interface to create a font collection.
    ///Params:
    ///    factory = Type: <b>IDWriteFactory*</b> Pointer to the IDWriteFactory object that was used to create the current font
    ///              collection.
    ///    collectionKey = Type: <b>const void*</b> A font collection key that uniquely identifies the collection of font files within
    ///                    the scope of the font collection loader being used. The buffer allocated for this key must be at least the
    ///                    size, in bytes, specified by <i>collectionKeySize</i>.
    ///    collectionKeySize = Type: <b>UINT32</b> The size of the font collection key, in bytes.
    ///    fontFileEnumerator = Type: <b>IDWriteFontFileEnumerator**</b> When this method returns, contains the address of a pointer to the
    ///                         newly created font file enumerator.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateEnumeratorFromKey(IDWriteFactory factory, const(void)* collectionKey, uint collectionKeySize, 
                                    IDWriteFontFileEnumerator* fontFileEnumerator);
}

///Encapsulates a collection of font files. The font system uses this interface to enumerate font files when building a
///font collection.
@GUID("72755049-5FF7-435D-8348-4BE97CFA6C7C")
interface IDWriteFontFileEnumerator : IUnknown
{
    ///Advances to the next font file in the collection. When it is first created, the enumerator is positioned before
    ///the first element of the collection and the first call to <b>MoveNext</b> advances to the first file.
    ///Params:
    ///    hasCurrentFile = Type: <b>BOOL*</b> When the method returns, contains the value <b>TRUE</b> if the enumerator advances to a
    ///                     file; otherwise, <b>FALSE</b> if the enumerator advances past the last file in the collection.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT MoveNext(BOOL* hasCurrentFile);
    ///Gets a reference to the current font file.
    ///Params:
    ///    fontFile = Type: <b>IDWriteFontFile**</b> When this method returns, the address of a pointer to the newly created
    ///               IDWriteFontFile object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetCurrentFontFile(IDWriteFontFile* fontFile);
}

///Represents a collection of strings indexed by locale name.
@GUID("08256209-099A-4B34-B86D-C22B110E7771")
interface IDWriteLocalizedStrings : IUnknown
{
    ///Gets the number of language/string pairs.
    ///Returns:
    ///    Type: <b>UINT32</b> The number of language/string pairs.
    ///    
    uint    GetCount();
    ///Gets the zero-based index of the locale name/string pair with the specified locale name.
    ///Params:
    ///    localeName = Type: <b>const WCHAR*</b> A null-terminated array of characters containing the locale name to look for.
    ///    index = Type: <b>UINT32*</b> The zero-based index of the locale name/string pair. This method initializes
    ///            <i>index</i> to <b>UINT_MAX</b>.
    ///    exists = Type: <b>BOOL*</b> When this method returns, contains <b>TRUE</b> if the locale name exists; otherwise,
    ///             <b>FALSE</b>. This method initializes <i>exists</i> to <b>FALSE</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the specified locale name does not exist, the return value is <b>S_OK</b>, but
    ///    <i>index</i> is <b>UINT_MAX</b> and <i>exists</i> is <b>FALSE</b>.
    ///    
    HRESULT FindLocaleName(const(PWSTR) localeName, uint* index, BOOL* exists);
    ///Gets the length in characters (not including the null terminator) of the locale name with the specified index.
    ///Params:
    ///    index = Type: <b>UINT32</b> Zero-based index of the locale name to be retrieved.
    ///    length = Type: <b>UINT32*</b> When this method returns, contains the length in characters of the locale name, not
    ///             including the null terminator.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetLocaleNameLength(uint index, uint* length);
    ///Copies the locale name with the specified index to the specified array.
    ///Params:
    ///    index = Type: <b>UINT32</b> Zero-based index of the locale name to be retrieved.
    ///    localeName = Type: <b>WCHAR*</b> When this method returns, contains a character array, which is null-terminated, that
    ///                 receives the locale name from the language/string pair. The buffer allocated for this array must be at least
    ///                 the size of <i>size</i>, in element count.
    ///    size = Type: <b>UINT32</b> The size of the array in characters. The size must include space for the terminating null
    ///           character.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetLocaleName(uint index, PWSTR localeName, uint size);
    ///Gets the length in characters (not including the null terminator) of the string with the specified index.
    ///Params:
    ///    index = Type: <b>UINT32</b> A zero-based index of the language/string pair.
    ///    length = Type: <b>UINT32*</b> The length in characters of the string, not including the null terminator, from the
    ///             language/string pair.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetStringLength(uint index, uint* length);
    ///Copies the string with the specified index to the specified array.
    ///Params:
    ///    index = Type: <b>UINT32</b> The zero-based index of the language/string pair to be examined.
    ///    stringBuffer = Type: <b>WCHAR*</b> The null terminated array of characters that receives the string from the language/string
    ///                   pair. The buffer allocated for this array should be at least the size of <i>size</i>. GetStringLength can be
    ///                   used to get the size of the array before using this method.
    ///    size = Type: <b>UINT32</b> The size of the array in characters. The size must include space for the terminating null
    ///           character. GetStringLength can be used to get the size of the array before using this method.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetString(uint index, PWSTR stringBuffer, uint size);
}

///An object that encapsulates a set of fonts, such as the set of fonts installed on the system, or the set of fonts in
///a particular directory. The font collection API can be used to discover what font families and fonts are available,
///and to obtain some metadata about the fonts.
@GUID("A84CEE02-3EEA-4EEE-A827-87C1A02A0FCC")
interface IDWriteFontCollection : IUnknown
{
    ///Gets the number of font families in the collection.
    ///Returns:
    ///    Type: <b>UINT32</b> The number of font families in the collection.
    ///    
    uint    GetFontFamilyCount();
    ///Creates a font family object given a zero-based font family index.
    ///Params:
    ///    index = Type: <b>UINT32</b> Zero-based index of the font family.
    ///    fontFamily = Type: <b>IDWriteFontFamily**</b> When this method returns, contains the address of a pointer to the newly
    ///                 created font family object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetFontFamily(uint index, IDWriteFontFamily* fontFamily);
    ///Finds the font family with the specified family name.
    ///Params:
    ///    familyName = Type: <b>const WCHAR*</b> An array of characters, which is null-terminated, containing the name of the font
    ///                 family. The name is not case-sensitive but must otherwise exactly match a family name in the collection.
    ///    index = Type: <b>UINT32*</b> When this method returns, contains the zero-based index of the matching font family if
    ///            the family name was found; otherwise, <b>UINT_MAX</b>.
    ///    exists = Type: <b>BOOL*</b> When this method returns, <b>TRUE</b> if the family name exists; otherwise, <b>FALSE</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT FindFamilyName(const(PWSTR) familyName, uint* index, BOOL* exists);
    ///Gets the font object that corresponds to the same physical font as the specified font face object. The specified
    ///physical font must belong to the font collection.
    ///Params:
    ///    fontFace = Type: <b>IDWriteFontFace*</b> A font face object that specifies the physical font.
    ///    font = Type: <b>IDWriteFont**</b> When this method returns, contains the address of a pointer to the newly created
    ///           font object if successful; otherwise, <b>NULL</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetFontFromFontFace(IDWriteFontFace fontFace, IDWriteFont* font);
}

///Represents a list of fonts.
@GUID("1A0D8438-1D97-4EC1-AEF9-A2FB86ED6ACB")
interface IDWriteFontList : IUnknown
{
    ///Gets the font collection that contains the fonts in the font list.
    ///Params:
    ///    fontCollection = Type: <b>IDWriteFontCollection**</b> When this method returns, contains the address of a pointer to the
    ///                     current IDWriteFontCollection object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetFontCollection(IDWriteFontCollection* fontCollection);
    ///Gets the number of fonts in the font list.
    ///Returns:
    ///    Type: <b>UINT32</b> The number of fonts in the font list.
    ///    
    uint    GetFontCount();
    ///Gets a font given its zero-based index.
    ///Params:
    ///    index = Type: <b>UINT32</b> Zero-based index of the font in the font list.
    ///    font = Type: <b>IDWriteFont**</b> When this method returns, contains the address of a pointer to the newly created
    ///           IDWriteFont object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetFont(uint index, IDWriteFont* font);
}

///Represents a family of related fonts.
@GUID("DA20D8EF-812A-4C43-9802-62EC4ABD7ADD")
interface IDWriteFontFamily : IDWriteFontList
{
    ///Creates a localized strings object that contains the family names for the font family, indexed by locale name.
    ///Params:
    ///    names = Type: <b>IDWriteLocalizedStrings**</b> The address of a pointer to the newly created IDWriteLocalizedStrings
    ///            object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetFamilyNames(IDWriteLocalizedStrings* names);
    ///Gets the font that best matches the specified properties.
    ///Params:
    ///    weight = Type: <b>DWRITE_FONT_WEIGHT</b> A value that is used to match a requested font weight.
    ///    stretch = Type: <b>DWRITE_FONT_STRETCH</b> A value that is used to match a requested font stretch.
    ///    style = Type: <b>DWRITE_FONT_STYLE</b> A value that is used to match a requested font style.
    ///    matchingFont = Type: <b>IDWriteFont**</b> When this method returns, contains the address of a pointer to the newly created
    ///                   IDWriteFont object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetFirstMatchingFont(DWRITE_FONT_WEIGHT weight, DWRITE_FONT_STRETCH stretch, DWRITE_FONT_STYLE style, 
                                 IDWriteFont* matchingFont);
    ///Gets a list of fonts in the font family ranked in order of how well they match the specified properties.
    ///Params:
    ///    weight = Type: <b>DWRITE_FONT_WEIGHT</b> A value that is used to match a requested font weight.
    ///    stretch = Type: <b>DWRITE_FONT_STRETCH</b> A value that is used to match a requested font stretch.
    ///    style = Type: <b>DWRITE_FONT_STYLE</b> A value that is used to match a requested font style.
    ///    matchingFonts = Type: <b>IDWriteFontList**</b> An address of a pointer to the newly created IDWriteFontList object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetMatchingFonts(DWRITE_FONT_WEIGHT weight, DWRITE_FONT_STRETCH stretch, DWRITE_FONT_STYLE style, 
                             IDWriteFontList* matchingFonts);
}

///Represents a physical font in a font collection. This interface is used to create font faces from physical fonts, or
///to retrieve information such as font face metrics or face names from existing font faces.
@GUID("ACD16696-8C14-4F5D-877E-FE3FC1D32737")
interface IDWriteFont : IUnknown
{
    ///Gets the font family to which the specified font belongs.
    ///Params:
    ///    fontFamily = Type: <b>IDWriteFontFamily**</b> When this method returns, contains an address of a pointer to the font
    ///                 family object to which the specified font belongs.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetFontFamily(IDWriteFontFamily* fontFamily);
    ///Gets the weight, or stroke thickness, of the specified font.
    ///Returns:
    ///    Type: <b>DWRITE_FONT_WEIGHT</b> A value that indicates the weight for the specified font.
    ///    
    DWRITE_FONT_WEIGHT GetWeight();
    ///Gets the stretch, or width, of the specified font.
    ///Returns:
    ///    Type: <b>DWRITE_FONT_STRETCH</b> A value that indicates the type of stretch, or width, applied to the
    ///    specified font.
    ///    
    DWRITE_FONT_STRETCH GetStretch();
    ///Gets the style, or slope, of the specified font.
    ///Returns:
    ///    Type: <b>DWRITE_FONT_STYLE</b> A value that indicates the type of style, or slope, of the specified font.
    ///    
    DWRITE_FONT_STYLE GetStyle();
    ///Determines whether the font is a symbol font.
    ///Returns:
    ///    Type: <b>BOOL</b> <b>TRUE</b> if the font is a symbol font; otherwise, <b>FALSE</b>.
    ///    
    BOOL    IsSymbolFont();
    ///Gets a localized strings collection containing the face names for the font (such as Regular or Bold), indexed by
    ///locale name.
    ///Params:
    ///    names = Type: <b>IDWriteLocalizedStrings**</b> When this method returns, contains an address to a pointer to the
    ///            newly created localized strings object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetFaceNames(IDWriteLocalizedStrings* names);
    ///Gets a localized strings collection containing the specified informational strings, indexed by locale name.
    ///Params:
    ///    informationalStringID = Type: <b>DWRITE_INFORMATIONAL_STRING_ID</b> A value that identifies the informational string to get. For
    ///                            example, DWRITE_INFORMATIONAL_STRING_DESCRIPTION specifies a string that contains a description of the font.
    ///    informationalStrings = Type: <b>IDWriteLocalizedStrings**</b> When this method returns, contains an address of a pointer to the
    ///                           newly created localized strings object.
    ///    exists = Type: <b>BOOL*</b> When this method returns, <b>TRUE</b> if the font contains the specified string ID;
    ///             otherwise, <b>FALSE</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetInformationalStrings(DWRITE_INFORMATIONAL_STRING_ID informationalStringID, 
                                    IDWriteLocalizedStrings* informationalStrings, BOOL* exists);
    ///Gets a value that indicates what simulations are applied to the specified font.
    ///Returns:
    ///    Type: <b>DWRITE_FONT_SIMULATIONS</b> A value that indicates one or more of the types of simulations (none,
    ///    bold, or oblique) applied to the specified font.
    ///    
    DWRITE_FONT_SIMULATIONS GetSimulations();
    ///Obtains design units and common metrics for the font face. These metrics are applicable to all the glyphs within
    ///a font face and are used by applications for layout calculations.
    ///Params:
    ///    fontMetrics = Type: <b>DWRITE_FONT_METRICS*</b> When this method returns, contains a structure that has font metrics for
    ///                  the current font face. The metrics returned by this function are in font design units.
    void    GetMetrics(DWRITE_FONT_METRICS* fontMetrics);
    ///Determines whether the font supports a specified character.
    ///Params:
    ///    unicodeValue = Type: <b>UINT32</b> A Unicode (UCS-4) character value for the method to inspect.
    ///    exists = Type: <b>BOOL*</b> When this method returns, <b>TRUE</b> if the font supports the specified character;
    ///             otherwise, <b>FALSE</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT HasCharacter(uint unicodeValue, BOOL* exists);
    ///Creates a font face object for the font.
    ///Params:
    ///    fontFace = Type: <b>IDWriteFontFace**</b> When this method returns, contains an address of a pointer to the newly
    ///               created font face object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateFontFace(IDWriteFontFace* fontFace);
}

///The <b>IDWriteTextFormat</b> interface describes the font and paragraph properties used to format text, and it
///describes locale information.
@GUID("9C906818-31D7-4FD3-A151-7C5E225DB55A")
interface IDWriteTextFormat : IUnknown
{
    ///Sets the alignment of text in a paragraph, relative to the leading and trailing edge of a layout box for a
    ///IDWriteTextFormat interface.
    ///Params:
    ///    textAlignment = Type: <b>DWRITE_TEXT_ALIGNMENT</b> The text alignment option being set for the paragraph of type
    ///                    DWRITE_TEXT_ALIGNMENT. For more information, see Remarks.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method can return one of these values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> The textAlignment argument is invalid. </td> </tr> </table>
    ///    
    HRESULT SetTextAlignment(DWRITE_TEXT_ALIGNMENT textAlignment);
    ///Sets the alignment option of a paragraph relative to the layout box's top and bottom edge.
    ///Params:
    ///    paragraphAlignment = Type: <b>DWRITE_PARAGRAPH_ALIGNMENT</b> The paragraph alignment option being set for a paragraph; see
    ///                         DWRITE_PARAGRAPH_ALIGNMENT for more information.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetParagraphAlignment(DWRITE_PARAGRAPH_ALIGNMENT paragraphAlignment);
    ///Sets the word wrapping option.
    ///Params:
    ///    wordWrapping = Type: <b>DWRITE_WORD_WRAPPING</b> The word wrapping option being set for a paragraph; see
    ///                   DWRITE_WORD_WRAPPING for more information.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetWordWrapping(DWRITE_WORD_WRAPPING wordWrapping);
    ///Sets the paragraph reading direction.
    ///Params:
    ///    readingDirection = Type: <b>DWRITE_READING_DIRECTION</b> The text reading direction (for example,
    ///                       DWRITE_READING_DIRECTION_RIGHT_TO_LEFT for languages, such as Arabic, that read from right to left) for a
    ///                       paragraph.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetReadingDirection(DWRITE_READING_DIRECTION readingDirection);
    ///Sets the paragraph flow direction.
    ///Params:
    ///    flowDirection = Type: <b>DWRITE_FLOW_DIRECTION</b> The paragraph flow direction; see DWRITE_FLOW_DIRECTION for more
    ///                    information.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetFlowDirection(DWRITE_FLOW_DIRECTION flowDirection);
    ///Sets a fixed distance between two adjacent tab stops.
    ///Params:
    ///    incrementalTabStop = Type: <b>FLOAT</b> The fixed distance between two adjacent tab stops.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetIncrementalTabStop(float incrementalTabStop);
    ///Sets trimming options for text overflowing the layout width.
    ///Params:
    ///    trimmingOptions = Type: <b>const DWRITE_TRIMMING*</b> Text trimming options.
    ///    trimmingSign = Type: <b>IDWriteInlineObject*</b> Application-defined omission sign. This parameter may be <b>NULL</b>. See
    ///                   IDWriteInlineObject for more information.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetTrimming(const(DWRITE_TRIMMING)* trimmingOptions, IDWriteInlineObject trimmingSign);
    ///Sets the line spacing.
    ///Params:
    ///    lineSpacingMethod = Type: <b>DWRITE_LINE_SPACING_METHOD</b> Specifies how line height is being determined; see
    ///                        DWRITE_LINE_SPACING_METHOD for more information.
    ///    lineSpacing = Type: <b>FLOAT</b> The line height, or distance between one baseline to another.
    ///    baseline = Type: <b>FLOAT</b> The distance from top of line to baseline. A reasonable ratio to <i>lineSpacing</i> is 80
    ///               percent.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetLineSpacing(DWRITE_LINE_SPACING_METHOD lineSpacingMethod, float lineSpacing, float baseline);
    ///Gets the alignment option of text relative to the layout box's leading and trailing edge.
    ///Returns:
    ///    Type: <b>DWRITE_TEXT_ALIGNMENT</b> Returns the text alignment option of the current paragraph.
    ///    
    DWRITE_TEXT_ALIGNMENT GetTextAlignment();
    ///Gets the alignment option of a paragraph which is relative to the top and bottom edges of a layout box.
    ///Returns:
    ///    Type: <b>DWRITE_PARAGRAPH_ALIGNMENT</b> A value that indicates the current paragraph alignment option.
    ///    
    DWRITE_PARAGRAPH_ALIGNMENT GetParagraphAlignment();
    ///Gets the word wrapping option.
    ///Returns:
    ///    Type: <b>DWRITE_WORD_WRAPPING</b> Returns the word wrapping option; see DWRITE_WORD_WRAPPING for more
    ///    information.
    ///    
    DWRITE_WORD_WRAPPING GetWordWrapping();
    ///Gets the current reading direction for text in a paragraph.
    ///Returns:
    ///    Type: <b>DWRITE_READING_DIRECTION</b> A value that indicates the current reading direction for text in a
    ///    paragraph.
    ///    
    DWRITE_READING_DIRECTION GetReadingDirection();
    ///Gets the direction that text lines flow.
    ///Returns:
    ///    Type: <b>DWRITE_FLOW_DIRECTION</b> The direction that text lines flow within their parent container. For
    ///    example, DWRITE_FLOW_DIRECTION_TOP_TO_BOTTOM indicates that text lines are placed from top to bottom.
    ///    
    DWRITE_FLOW_DIRECTION GetFlowDirection();
    ///Gets the incremental tab stop position.
    ///Returns:
    ///    Type: <b>FLOAT</b> The incremental tab stop value.
    ///    
    float   GetIncrementalTabStop();
    ///Gets the trimming options for text that overflows the layout box.
    ///Params:
    ///    trimmingOptions = Type: <b>DWRITE_TRIMMING*</b> When this method returns, it contains a pointer to a DWRITE_TRIMMING structure
    ///                      that holds the text trimming options for the overflowing text.
    ///    trimmingSign = Type: <b>IDWriteInlineObject**</b> When this method returns, contains an address of a pointer to a trimming
    ///                   omission sign. This parameter may be <b>NULL</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetTrimming(DWRITE_TRIMMING* trimmingOptions, IDWriteInlineObject* trimmingSign);
    ///Gets the line spacing adjustment set for a multiline text paragraph.
    ///Params:
    ///    lineSpacingMethod = Type: <b>DWRITE_LINE_SPACING_METHOD*</b> A value that indicates how line height is determined.
    ///    lineSpacing = Type: <b>FLOAT*</b> When this method returns, contains the line height, or distance between one baseline to
    ///                  another.
    ///    baseline = Type: <b>FLOAT*</b> When this method returns, contains the distance from top of line to baseline. A
    ///               reasonable ratio to <i>lineSpacing</i> is 80 percent.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetLineSpacing(DWRITE_LINE_SPACING_METHOD* lineSpacingMethod, float* lineSpacing, float* baseline);
    ///Gets the current font collection.
    ///Params:
    ///    fontCollection = Type: <b>IDWriteFontCollection**</b> When this method returns, contains an address of a pointer to the font
    ///                     collection being used for the current text.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetFontCollection(IDWriteFontCollection* fontCollection);
    ///Gets the length of the font family name.
    ///Returns:
    ///    Type: <b>UINT32</b> The size of the character array, in character count, not including the terminated
    ///    <b>NULL</b> character.
    ///    
    uint    GetFontFamilyNameLength();
    ///Gets a copy of the font family name.
    ///Params:
    ///    fontFamilyName = Type: <b>WCHAR*</b> When this method returns, contains a pointer to a character array, which is
    ///                     null-terminated, that receives the current font family name. The buffer allocated for this array should be at
    ///                     least the size, in elements, of <i>nameSize</i>.
    ///    nameSize = Type: <b>UINT32</b> The size of the <i>fontFamilyName</i> character array, in character count, including the
    ///               terminated <b>NULL</b> character. To find the size of <i>fontFamilyName</i>, use GetFontFamilyNameLength.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetFontFamilyName(PWSTR fontFamilyName, uint nameSize);
    ///Gets the font weight of the text.
    ///Returns:
    ///    Type: <b>DWRITE_FONT_WEIGHT</b> A value that indicates the type of weight (such as normal, bold, or black).
    ///    
    DWRITE_FONT_WEIGHT GetFontWeight();
    ///Gets the font style of the text.
    ///Returns:
    ///    Type: <b>DWRITE_FONT_STYLE</b> A value which indicates the type of font style (such as slope or incline).
    ///    
    DWRITE_FONT_STYLE GetFontStyle();
    ///Gets the font stretch of the text.
    ///Returns:
    ///    Type: <b>DWRITE_FONT_STRETCH</b> A value which indicates the type of font stretch (such as normal or
    ///    condensed).
    ///    
    DWRITE_FONT_STRETCH GetFontStretch();
    ///Gets the font size in DIP unites.
    ///Returns:
    ///    Type: <b>FLOAT</b> The current font size in DIP units.
    ///    
    float   GetFontSize();
    ///Gets the length of the locale name.
    ///Returns:
    ///    Type: <b>UINT32</b> The size of the character array in character count, not including the terminated
    ///    <b>NULL</b> character.
    ///    
    uint    GetLocaleNameLength();
    ///Gets a copy of the locale name.
    ///Params:
    ///    localeName = Type: <b>WCHAR*</b> Contains a character array that receives the current locale name.
    ///    nameSize = Type: <b>UINT32</b> The size of the character array, in character count, including the terminated <b>NULL</b>
    ///               character. Use GetLocaleNameLength to get the size of the locale name character array.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetLocaleName(PWSTR localeName, uint nameSize);
}

///Represents a font typography setting.
@GUID("55F1112B-1DC2-4B3C-9541-F46894ED85B6")
interface IDWriteTypography : IUnknown
{
    ///Adds an OpenType font feature.
    ///Params:
    ///    fontFeature = Type: <b>DWRITE_FONT_FEATURE</b> A structure that contains the OpenType name identifier and the execution
    ///                  parameter for the font feature being added.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AddFontFeature(DWRITE_FONT_FEATURE fontFeature);
    ///Gets the number of OpenType font features for the current font.
    ///Returns:
    ///    Type: <b>UINT32</b> The number of font features for the current text format.
    ///    
    uint    GetFontFeatureCount();
    ///Gets the font feature at the specified index.
    ///Params:
    ///    fontFeatureIndex = Type: <b>UINT32</b> The zero-based index of the font feature to retrieve.
    ///    fontFeature = Type: <b>DWRITE_FONT_FEATURE*</b> When this method returns, contains the font feature which is at the
    ///                  specified index.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetFontFeature(uint fontFeatureIndex, DWRITE_FONT_FEATURE* fontFeature);
}

///Holds the appropriate digits and numeric punctuation for a specified locale.
@GUID("14885CC9-BAB0-4F90-B6ED-5C366A2CD03D")
interface IDWriteNumberSubstitution : IUnknown
{
}

///Implemented by the text analyzer's client to provide text to the analyzer. It allows the separation between the
///logical view of text as a continuous stream of characters identifiable by unique text positions, and the actual
///memory layout of potentially discrete blocks of text in the client's backing store.
@GUID("688E1A58-5094-47C8-ADC8-FBCEA60AE92B")
interface IDWriteTextAnalysisSource : IUnknown
{
    ///Gets a block of text starting at the specified text position.
    ///Params:
    ///    textPosition = Type: <b>UINT32</b> The first position of the piece to obtain. All positions are in <b>UTF16</b> code units,
    ///                   not whole characters, which matters when supplementary characters are used.
    ///    textString = Type: <b>const WCHAR**</b> When this method returns, contains an address of the block of text as an array of
    ///                 characters to be retrieved from the text analysis.
    ///    textLength = Type: <b>UINT32*</b> When this method returns, contains the number of <b>UTF16</b> units of the retrieved
    ///                 chunk. The returned length is not the length of the block, but the length remaining in the block, from the
    ///                 specified position until its end. For example, querying for a position that is 75 positions into a
    ///                 100-position block would return 25.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetTextAtPosition(uint textPosition, const(ushort)** textString, uint* textLength);
    ///Gets a block of text immediately preceding the specified position.
    ///Params:
    ///    textPosition = Type: <b>UINT32</b> The position immediately after the last position of the block of text to obtain.
    ///    textString = Type: <b>const WCHAR**</b> When this method returns, contains an address of a pointer to the block of text,
    ///                 as an array of characters from the specified range. The text range will be from <i>textPosition</i> to the
    ///                 front of the block.
    ///    textLength = Type: <b>UINT32*</b> Number of UTF16 units of the retrieved block. The length returned is from the specified
    ///                 position to the front of the block.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetTextBeforePosition(uint textPosition, const(ushort)** textString, uint* textLength);
    ///Gets the paragraph reading direction.
    ///Returns:
    ///    Type: <b>DWRITE_READING_DIRECTION</b> The reading direction of the current paragraph.
    ///    
    DWRITE_READING_DIRECTION GetParagraphReadingDirection();
    ///Gets the locale name on the range affected by the text analysis.
    ///Params:
    ///    textPosition = Type: <b>UINT32</b> The text position to examine.
    ///    textLength = Type: <b>UINT32*</b> Contains the length of the text being affected by the text analysis up to the next
    ///                 differing locale.
    ///    localeName = Type: <b>const WCHAR**</b> Contains an address of a pointer to an array of characters which receives the
    ///                 locale name from the text affected by the text analysis. The array of characters is null-terminated.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetLocaleName(uint textPosition, uint* textLength, const(ushort)** localeName);
    ///Gets the number substitution from the text range affected by the text analysis.
    ///Params:
    ///    textPosition = Type: <b>UINT32</b> The starting position from which to report.
    ///    textLength = Type: <b>UINT32*</b> Contains the length of the text, in characters, remaining in the text range up to the
    ///                 next differing number substitution.
    ///    numberSubstitution = Type: <b>IDWriteNumberSubstitution**</b> Contains an address of a pointer to an object, which was created
    ///                         with IDWriteFactory::CreateNumberSubstitution, that holds the appropriate digits and numeric punctuation for
    ///                         a given locale.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetNumberSubstitution(uint textPosition, uint* textLength, 
                                  IDWriteNumberSubstitution* numberSubstitution);
}

///This interface is implemented by the text analyzer's client to receive the output of a given text analysis.
@GUID("5810CD44-0CA0-4701-B3FA-BEC5182AE4F6")
interface IDWriteTextAnalysisSink : IUnknown
{
    ///Reports script analysis for the specified text range.
    ///Params:
    ///    textPosition = Type: <b>UINT32</b> The starting position from which to report.
    ///    textLength = Type: <b>UINT32</b> The number of UTF16 units of the reported range.
    ///    scriptAnalysis = Type: <b>const DWRITE_SCRIPT_ANALYSIS*</b> A pointer to a structure that contains a zero-based index
    ///                     representation of a writing system script and a value indicating whether additional shaping of text is
    ///                     required.
    ///Returns:
    ///    Type: <b>HRESULT</b> A successful code or error code to stop analysis.
    ///    
    HRESULT SetScriptAnalysis(uint textPosition, uint textLength, const(DWRITE_SCRIPT_ANALYSIS)* scriptAnalysis);
    ///Sets line-break opportunities for each character, starting from the specified position.
    ///Params:
    ///    textPosition = Type: <b>UINT32</b> The starting text position from which to report.
    ///    textLength = Type: <b>UINT32</b> The number of UTF16 units of the reported range.
    ///    lineBreakpoints = Type: <b>DWRITE_LINE_BREAKPOINT*</b> A pointer to a structure that contains breaking conditions set for each
    ///                      character from the starting position to the end of the specified range.
    ///Returns:
    ///    Type: <b>HRESULT</b> A successful code or error code to stop analysis.
    ///    
    HRESULT SetLineBreakpoints(uint textPosition, uint textLength, const(DWRITE_LINE_BREAKPOINT)* lineBreakpoints);
    ///Sets a bidirectional level on the range, which is called once per run change (either explicit or resolved
    ///implicit).
    ///Params:
    ///    textPosition = Type: <b>UINT32</b> The starting position from which to report.
    ///    textLength = Type: <b>UINT32</b> The number of UTF16 units of the reported range.
    ///    explicitLevel = Type: <b>UINT8</b> The explicit level from the paragraph reading direction and any embedded control codes
    ///                    RLE/RLO/LRE/LRO/PDF, which is determined before any additional rules.
    ///    resolvedLevel = Type: <b>UINT8</b> The final implicit level considering the explicit level and characters' natural
    ///                    directionality, after all Bidi rules have been applied.
    ///Returns:
    ///    Type: <b>HRESULT</b> A successful code or error code to stop analysis.
    ///    
    HRESULT SetBidiLevel(uint textPosition, uint textLength, ubyte explicitLevel, ubyte resolvedLevel);
    ///Sets the number substitution on the text range affected by the text analysis.
    ///Params:
    ///    textPosition = Type: <b>UINT32</b> The starting position from which to report.
    ///    textLength = Type: <b>UINT32</b> The number of UTF16 units of the reported range.
    ///    numberSubstitution = Type: <b>IDWriteNumberSubstitution*</b> An object that holds the appropriate digits and numeric punctuation
    ///                         for a given locale. Use IDWriteFactory::CreateNumberSubstitution to create this object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetNumberSubstitution(uint textPosition, uint textLength, IDWriteNumberSubstitution numberSubstitution);
}

///Analyzes various text properties for complex script processing such as bidirectional (bidi) support for languages
///like Arabic, determination of line break opportunities, glyph placement, and number substitution.
@GUID("B7E6163E-7F46-43B4-84B3-E4E6249C365D")
interface IDWriteTextAnalyzer : IUnknown
{
    ///Analyzes a text range for script boundaries, reading text attributes from the source and reporting the Unicode
    ///script ID to the sink callback SetScript.
    ///Params:
    ///    analysisSource = Type: <b>IDWriteTextAnalysisSource*</b> A pointer to the source object to analyze.
    ///    textPosition = Type: <b>UINT32</b> The starting text position within the source object.
    ///    textLength = Type: <b>UINT32</b> The text length to analyze.
    ///    analysisSink = Type: <b>IDWriteTextAnalysisSink*</b> A pointer to the sink callback object that receives the text analysis.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AnalyzeScript(IDWriteTextAnalysisSource analysisSource, uint textPosition, uint textLength, 
                          IDWriteTextAnalysisSink analysisSink);
    ///Analyzes a text range for script directionality, reading attributes from the source and reporting levels to the
    ///sink callback SetBidiLevel.
    ///Params:
    ///    analysisSource = Type: <b>IDWriteTextAnalysisSource*</b> A pointer to a source object to analyze.
    ///    textPosition = Type: <b>UINT32</b> The starting text position within the source object.
    ///    textLength = Type: <b>UINT32</b> The text length to analyze.
    ///    analysisSink = Type: <b>IDWriteTextAnalysisSink*</b> A pointer to the sink callback object that receives the text analysis.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AnalyzeBidi(IDWriteTextAnalysisSource analysisSource, uint textPosition, uint textLength, 
                        IDWriteTextAnalysisSink analysisSink);
    ///Analyzes a text range for spans where number substitution is applicable, reading attributes from the source and
    ///reporting substitutable ranges to the sink callback SetNumberSubstitution.
    ///Params:
    ///    analysisSource = Type: <b>IDWriteTextAnalysisSource*</b> The source object to analyze.
    ///    textPosition = Type: <b>UINT32</b> The starting position within the source object.
    ///    textLength = Type: <b>UINT32</b> The length to analyze.
    ///    analysisSink = Type: <b>IDWriteTextAnalysisSink*</b> A pointer to the sink callback object that receives the text analysis.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AnalyzeNumberSubstitution(IDWriteTextAnalysisSource analysisSource, uint textPosition, uint textLength, 
                                      IDWriteTextAnalysisSink analysisSink);
    ///Analyzes a text range for potential breakpoint opportunities, reading attributes from the source and reporting
    ///breakpoint opportunities to the sink callback SetLineBreakpoints.
    ///Params:
    ///    analysisSource = Type: <b>IDWriteTextAnalysisSource*</b> A pointer to the source object to analyze.
    ///    textPosition = Type: <b>UINT32</b> The starting text position within the source object.
    ///    textLength = Type: <b>UINT32</b> The text length to analyze.
    ///    analysisSink = Type: <b>IDWriteTextAnalysisSink*</b> A pointer to the sink callback object that receives the text analysis.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AnalyzeLineBreakpoints(IDWriteTextAnalysisSource analysisSource, uint textPosition, uint textLength, 
                                   IDWriteTextAnalysisSink analysisSink);
    ///Parses the input text string and maps it to the set of glyphs and associated glyph data according to the font and
    ///the writing system's rendering rules.
    ///Params:
    ///    textString = Type: <b>const WCHAR*</b> An array of characters to convert to glyphs.
    ///    textLength = Type: <b>UINT32</b> The length of <i>textString</i>.
    ///    fontFace = Type: <b>IDWriteFontFace*</b> The font face that is the source of the output glyphs.
    ///    isSideways = Type: <b>BOOL</b> A Boolean flag set to <b>TRUE</b> if the text is intended to be drawn vertically.
    ///    isRightToLeft = Type: <b>BOOL</b> A Boolean flag set to <b>TRUE</b> for right-to-left text.
    ///    scriptAnalysis = Type: <b>const DWRITE_SCRIPT_ANALYSIS*</b> A pointer to a Script analysis result from an AnalyzeScript call.
    ///    localeName = Type: <b>const WCHAR*</b> The locale to use when selecting glyphs. For example the same character may map to
    ///                 different glyphs for ja-jp versus zh-chs. If this is <b>NULL</b>, then the default mapping based on the
    ///                 script is used.
    ///    numberSubstitution = Type: <b>IDWriteNumberSubstitution*</b> A pointer to an optional number substitution which selects the
    ///                         appropriate glyphs for digits and related numeric characters, depending on the results obtained from
    ///                         AnalyzeNumberSubstitution. Passing <b>NULL</b> indicates that no substitution is needed and that the digits
    ///                         should receive nominal glyphs.
    ///    features = Type: <b>const DWRITE_TYPOGRAPHIC_FEATURES**</b> An array of pointers to the sets of typographic features to
    ///               use in each feature range.
    ///    featureRangeLengths = Type: <b>const UINT32*</b> The length of each feature range, in characters. The sum of all lengths should be
    ///                          equal to <i>textLength</i>.
    ///    featureRanges = Type: <b>UINT32</b> The number of feature ranges.
    ///    maxGlyphCount = Type: <b>UINT32</b> The maximum number of glyphs that can be returned.
    ///    clusterMap = Type: <b>UINT16*</b> When this method returns, contains the mapping from character ranges to glyph ranges.
    ///    textProps = Type: <b>DWRITE_SHAPING_TEXT_PROPERTIES*</b> When this method returns, contains a pointer to an array of
    ///                structures that contains shaping properties for each character.
    ///    glyphIndices = Type: <b>UINT16*</b> The output glyph indices.
    ///    glyphProps = Type: <b>DWRITE_SHAPING_GLYPH_PROPERTIES*</b> When this method returns, contains a pointer to an array of
    ///                 structures that contain shaping properties for each output glyph.
    ///    actualGlyphCount = Type: <b>UINT32*</b> When this method returns, contains the actual number of glyphs returned if the call
    ///                       succeeds.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetGlyphs(const(PWSTR) textString, uint textLength, IDWriteFontFace fontFace, BOOL isSideways, 
                      BOOL isRightToLeft, const(DWRITE_SCRIPT_ANALYSIS)* scriptAnalysis, const(PWSTR) localeName, 
                      IDWriteNumberSubstitution numberSubstitution, const(DWRITE_TYPOGRAPHIC_FEATURES)** features, 
                      const(uint)* featureRangeLengths, uint featureRanges, uint maxGlyphCount, ushort* clusterMap, 
                      DWRITE_SHAPING_TEXT_PROPERTIES* textProps, ushort* glyphIndices, 
                      DWRITE_SHAPING_GLYPH_PROPERTIES* glyphProps, uint* actualGlyphCount);
    ///Places glyphs output from the GetGlyphs method according to the font and the writing system's rendering rules.
    ///Params:
    ///    textString = Type: <b>const WCHAR*</b> An array of characters containing the original string from which the glyphs came.
    ///    clusterMap = Type: <b>const UINT16*</b> A pointer to the mapping from character ranges to glyph ranges. This is returned
    ///                 by GetGlyphs.
    ///    textProps = Type: <b>DWRITE_SHAPING_TEXT_PROPERTIES*</b> A pointer to an array of structures that contains shaping
    ///                properties for each character. This structure is returned by GetGlyphs.
    ///    textLength = Type: <b>UINT32</b> The text length of <i>textString</i>.
    ///    glyphIndices = Type: <b>const UINT16*</b> An array of glyph indices returned by GetGlyphs.
    ///    glyphProps = Type: <b>const DWRITE_SHAPING_GLYPH_PROPERTIES*</b> A pointer to an array of structures that contain shaping
    ///                 properties for each glyph returned by GetGlyphs.
    ///    glyphCount = Type: <b>UINT32</b> The number of glyphs returned from GetGlyphs.
    ///    fontFace = Type: <b>IDWriteFontFace*</b> A pointer to the font face that is the source for the output glyphs.
    ///    fontEmSize = Type: <b>FLOAT</b> The logical font size in DIPs.
    ///    isSideways = Type: <b>BOOL</b> A Boolean flag set to <b>TRUE</b> if the text is intended to be drawn vertically.
    ///    isRightToLeft = Type: <b>BOOL</b> A Boolean flag set to <b>TRUE</b> for right-to-left text.
    ///    scriptAnalysis = Type: <b>const DWRITE_SCRIPT_ANALYSIS*</b> A pointer to a Script analysis result from an AnalyzeScript call.
    ///    localeName = Type: <b>const WCHAR*</b> An array of characters containing the locale to use when selecting glyphs. For
    ///                 example, the same character may map to different glyphs for ja-jp versus zh-chs. If this is <b>NULL</b>, the
    ///                 default mapping based on the script is used.
    ///    features = Type: <b>const DWRITE_TYPOGRAPHIC_FEATURES**</b> An array of pointers to the sets of typographic features to
    ///               use in each feature range.
    ///    featureRangeLengths = Type: <b>const UINT32*</b> The length of each feature range, in characters. The sum of all lengths should be
    ///                          equal to <i>textLength</i>.
    ///    featureRanges = Type: <b>UINT32</b> The number of feature ranges.
    ///    glyphAdvances = Type: <b>FLOAT*</b> When this method returns, contains the advance width of each glyph.
    ///    glyphOffsets = Type: <b>DWRITE_GLYPH_OFFSET*</b> When this method returns, contains the offset of the origin of each glyph.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetGlyphPlacements(const(PWSTR) textString, const(ushort)* clusterMap, 
                               DWRITE_SHAPING_TEXT_PROPERTIES* textProps, uint textLength, 
                               const(ushort)* glyphIndices, const(DWRITE_SHAPING_GLYPH_PROPERTIES)* glyphProps, 
                               uint glyphCount, IDWriteFontFace fontFace, float fontEmSize, BOOL isSideways, 
                               BOOL isRightToLeft, const(DWRITE_SCRIPT_ANALYSIS)* scriptAnalysis, 
                               const(PWSTR) localeName, const(DWRITE_TYPOGRAPHIC_FEATURES)** features, 
                               const(uint)* featureRangeLengths, uint featureRanges, float* glyphAdvances, 
                               DWRITE_GLYPH_OFFSET* glyphOffsets);
    ///Place glyphs output from the GetGlyphs method according to the font and the writing system's rendering rules.
    ///Params:
    ///    textString = Type: <b>const WCHAR*</b> An array of characters containing the original string from which the glyphs came.
    ///    clusterMap = Type: <b>const UINT16*</b> A pointer to the mapping from character ranges to glyph ranges. This is returned
    ///                 by GetGlyphs.
    ///    textProps = Type: <b>DWRITE_SHAPING_TEXT_PROPERTIES*</b> A pointer to an array of structures that contains shaping
    ///                properties for each character. This structure is returned by GetGlyphs.
    ///    textLength = Type: <b>UINT32</b> The text length of <i>textString</i>.
    ///    glyphIndices = Type: <b>const UINT16*</b> An array of glyph indices returned by GetGlyphs.
    ///    glyphProps = Type: <b>const DWRITE_SHAPING_GLYPH_PROPERTIES*</b> A pointer to an array of structures that contain shaping
    ///                 properties for each glyph returned by GetGlyphs.
    ///    glyphCount = Type: <b>UINT32</b> The number of glyphs returned from GetGlyphs.
    ///    fontFace = Type: <b>IDWriteFontFace*</b> A pointer to the font face that is the source for the output glyphs.
    ///    fontEmSize = Type: <b>FLOAT</b> The logical font size in DIPs.
    ///    pixelsPerDip = Type: <b>FLOAT</b> The number of physical pixels per DIP.
    ///    transform = Type: <b>const DWRITE_MATRIX*</b> An optional transform applied to the glyphs and their positions. This
    ///                transform is applied after the scaling specified by the font size and <i>pixelsPerDip</i>.
    ///    useGdiNatural = Type: <b>BOOL</b> When set to <b>FALSE</b>, the metrics are the same as the metrics of GDI aliased text. When
    ///                    set to <b>TRUE</b>, the metrics are the same as the metrics of text measured by GDI using a font created with
    ///                    <b>CLEARTYPE_NATURAL_QUALITY</b>.
    ///    isSideways = Type: <b>BOOL</b> A Boolean flag set to <b>TRUE</b> if the text is intended to be drawn vertically.
    ///    isRightToLeft = Type: <b>BOOL</b> A Boolean flag set to <b>TRUE</b> for right-to-left text.
    ///    scriptAnalysis = Type: <b>const DWRITE_SCRIPT_ANALYSIS*</b> A pointer to a Script analysis result from anAnalyzeScript call.
    ///    localeName = Type: <b>const WCHAR*</b> An array of characters containing the locale to use when selecting glyphs. For
    ///                 example, the same character may map to different glyphs for ja-jp versus zh-chs. If this is <b>NULL</b>, then
    ///                 the default mapping based on the script is used.
    ///    features = Type: <b>const DWRITE_TYPOGRAPHIC_FEATURES**</b> An array of pointers to the sets of typographic features to
    ///               use in each feature range.
    ///    featureRangeLengths = Type: <b>const UINT32*</b> The length of each feature range, in characters. The sum of all lengths should be
    ///                          equal to <i>textLength</i>.
    ///    featureRanges = Type: <b>UINT32</b> The number of feature ranges.
    ///    glyphAdvances = Type: <b>FLOAT*</b> When this method returns, contains the advance width of each glyph.
    ///    glyphOffsets = Type: <b>DWRITE_GLYPH_OFFSET*</b> When this method returns, contains the offset of the origin of each glyph.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetGdiCompatibleGlyphPlacements(const(PWSTR) textString, const(ushort)* clusterMap, 
                                            DWRITE_SHAPING_TEXT_PROPERTIES* textProps, uint textLength, 
                                            const(ushort)* glyphIndices, 
                                            const(DWRITE_SHAPING_GLYPH_PROPERTIES)* glyphProps, uint glyphCount, 
                                            IDWriteFontFace fontFace, float fontEmSize, float pixelsPerDip, 
                                            const(DWRITE_MATRIX)* transform, BOOL useGdiNatural, BOOL isSideways, 
                                            BOOL isRightToLeft, const(DWRITE_SCRIPT_ANALYSIS)* scriptAnalysis, 
                                            const(PWSTR) localeName, const(DWRITE_TYPOGRAPHIC_FEATURES)** features, 
                                            const(uint)* featureRangeLengths, uint featureRanges, 
                                            float* glyphAdvances, DWRITE_GLYPH_OFFSET* glyphOffsets);
}

///Wraps an application-defined inline graphic, allowing DWrite to query metrics as if the graphic were a glyph inline
///with the text.
@GUID("8339FDE3-106F-47AB-8373-1C6295EB10B3")
interface IDWriteInlineObject : IUnknown
{
    ///The application implemented rendering callback (IDWriteTextRenderer::DrawInlineObject) can use this to draw the
    ///inline object without needing to cast or query the object type. The text layout does not call this method
    ///directly.
    ///Params:
    ///    clientDrawingContext = Type: <b>void*</b> The drawing context passed to IDWriteTextLayout::Draw. This parameter may be <b>NULL</b>.
    ///    renderer = Type: <b>IDWriteTextRenderer*</b> The same renderer passed to IDWriteTextLayout::Draw as the object's
    ///               containing parent. This is useful if the inline object is recursive such as a nested layout.
    ///    originX = Type: <b>FLOAT</b> The x-coordinate at the upper-left corner of the inline object.
    ///    originY = Type: <b>FLOAT</b> The y-coordinate at the upper-left corner of the inline object.
    ///    isSideways = Type: <b>BOOL</b> A Boolean flag that indicates whether the object's baseline runs alongside the baseline
    ///                 axis of the line.
    ///    isRightToLeft = Type: <b>BOOL</b> A Boolean flag that indicates whether the object is in a right-to-left context and should
    ///                    be drawn flipped.
    ///    clientDrawingEffect = Type: <b>IUnknown*</b> The drawing effect set in IDWriteTextLayout::SetDrawingEffect. Usually this effect is
    ///                          a foreground brush that is used in glyph drawing.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Draw(void* clientDrawingContext, IDWriteTextRenderer renderer, float originX, float originY, 
                 BOOL isSideways, BOOL isRightToLeft, IUnknown clientDrawingEffect);
    ///IDWriteTextLayout calls this callback function to get the measurement of the inline object.
    ///Params:
    ///    metrics = Type: <b>DWRITE_INLINE_OBJECT_METRICS*</b> When this method returns, contains a structure describing the
    ///              geometric measurement of an application-defined inline object. These metrics are in relation to the baseline
    ///              of the adjacent text.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetMetrics(DWRITE_INLINE_OBJECT_METRICS* metrics);
    ///IDWriteTextLayout calls this callback function to get the visible extents (in DIPs) of the inline object. In the
    ///case of a simple bitmap, with no padding and no overhang, all the overhangs will simply be zeroes. The overhangs
    ///should be returned relative to the reported size of the object (see DWRITE_INLINE_OBJECT_METRICS), and should not
    ///be baseline adjusted.
    ///Params:
    ///    overhangs = Type: <b>DWRITE_OVERHANG_METRICS*</b> Overshoot of visible extents (in DIPs) outside the object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetOverhangMetrics(DWRITE_OVERHANG_METRICS* overhangs);
    ///Layout uses this to determine the line-breaking behavior of the inline object among the text.
    ///Params:
    ///    breakConditionBefore = Type: <b>DWRITE_BREAK_CONDITION*</b> When this method returns, contains a value which indicates the
    ///                           line-breaking condition between the object and the content immediately preceding it.
    ///    breakConditionAfter = Type: <b>DWRITE_BREAK_CONDITION*</b> When this method returns, contains a value which indicates the
    ///                          line-breaking condition between the object and the content immediately following it.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetBreakConditions(DWRITE_BREAK_CONDITION* breakConditionBefore, 
                               DWRITE_BREAK_CONDITION* breakConditionAfter);
}

///Defines the pixel snapping properties such as pixels per DIP(device-independent pixel) and the current transform
///matrix of a text renderer.
@GUID("EAF3A2DA-ECF4-4D24-B644-B34F6842024B")
interface IDWritePixelSnapping : IUnknown
{
    HRESULT IsPixelSnappingDisabled(void* clientDrawingContext, BOOL* isDisabled);
    ///Gets a transform that maps abstract coordinates to DIPs.
    ///Params:
    ///    clientDrawingContext = Type: <b>void*</b> The drawing context passed to IDWriteTextLayout::Draw.
    ///    transform = Type: <b>DWRITE_MATRIX*</b> When this method returns, contains a structure which has transform information
    ///                for pixel snapping.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetCurrentTransform(void* clientDrawingContext, DWRITE_MATRIX* transform);
    ///Gets the number of physical pixels per DIP.
    ///Params:
    ///    clientDrawingContext = Type: <b>void*</b> The drawing context passed to IDWriteTextLayout::Draw.
    ///    pixelsPerDip = Type: <b>FLOAT*</b> When this method returns, contains the number of physical pixels per DIP.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetPixelsPerDip(void* clientDrawingContext, float* pixelsPerDip);
}

///Represents a set of application-defined callbacks that perform rendering of text, inline objects, and decorations
///such as underlines.
@GUID("EF8A8135-5CC6-45FE-8825-C5A0724EB819")
interface IDWriteTextRenderer : IDWritePixelSnapping
{
    ///IDWriteTextLayout::Draw calls this function to instruct the client to render a run of glyphs.
    ///Params:
    ///    clientDrawingContext = Type: <b>void*</b> The application-defined drawing context passed to IDWriteTextLayout::Draw.
    ///    baselineOriginX = Type: <b>FLOAT</b> The pixel location (X-coordinate) at the baseline origin of the glyph run.
    ///    baselineOriginY = Type: <b>FLOAT</b> The pixel location (Y-coordinate) at the baseline origin of the glyph run.
    ///    measuringMode = Type: <b>DWRITE_MEASURING_MODE</b> The measuring method for glyphs in the run, used with the other properties
    ///                    to determine the rendering mode.
    ///    glyphRun = Type: <b>const DWRITE_GLYPH_RUN*</b> Pointer to the glyph run instance to render.
    ///    glyphRunDescription = Type: <b>const DWRITE_GLYPH_RUN_DESCRIPTION*</b> A pointer to the glyph run description instance which
    ///                          contains properties of the characters associated with this run.
    ///    clientDrawingEffect = Type: <b>IUnknown*</b> Application-defined drawing effects for the glyphs to render. Usually this argument
    ///                          represents effects such as the foreground brush filling the interior of text.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT DrawGlyphRun(void* clientDrawingContext, float baselineOriginX, float baselineOriginY, 
                         DWRITE_MEASURING_MODE measuringMode, const(DWRITE_GLYPH_RUN)* glyphRun, 
                         const(DWRITE_GLYPH_RUN_DESCRIPTION)* glyphRunDescription, IUnknown clientDrawingEffect);
    ///IDWriteTextLayout::Draw calls this function to instruct the client to draw an underline.
    ///Params:
    ///    clientDrawingContext = Type: <b>void*</b> The application-defined drawing context passed to IDWriteTextLayout::Draw.
    ///    baselineOriginX = Type: <b>FLOAT</b> The pixel location (X-coordinate) at the baseline origin of the run where underline
    ///                      applies.
    ///    baselineOriginY = Type: <b>FLOAT</b> The pixel location (Y-coordinate) at the baseline origin of the run where underline
    ///                      applies.
    ///    underline = Type: <b>const DWRITE_UNDERLINE*</b> Pointer to a structure containing underline logical information.
    ///    clientDrawingEffect = Type: <b>IUnknown*</b> Application-defined effect to apply to the underline. Usually this argument represents
    ///                          effects such as the foreground brush filling the interior of a line.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT DrawUnderline(void* clientDrawingContext, float baselineOriginX, float baselineOriginY, 
                          const(DWRITE_UNDERLINE)* underline, IUnknown clientDrawingEffect);
    ///IDWriteTextLayout::Draw calls this function to instruct the client to draw a strikethrough.
    ///Params:
    ///    clientDrawingContext = Type: <b>void*</b> The application-defined drawing context passed to IDWriteTextLayout::Draw.
    ///    baselineOriginX = Type: <b>FLOAT</b> The pixel location (X-coordinate) at the baseline origin of the run where strikethrough
    ///                      applies.
    ///    baselineOriginY = Type: <b>FLOAT</b> The pixel location (Y-coordinate) at the baseline origin of the run where strikethrough
    ///                      applies.
    ///    strikethrough = Type: <b>const DWRITE_STRIKETHROUGH*</b> Pointer to a structure containing strikethrough logical information.
    ///    clientDrawingEffect = Type: <b>IUnknown*</b> Application-defined effect to apply to the strikethrough. Usually this argument
    ///                          represents effects such as the foreground brush filling the interior of a line.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT DrawStrikethrough(void* clientDrawingContext, float baselineOriginX, float baselineOriginY, 
                              const(DWRITE_STRIKETHROUGH)* strikethrough, IUnknown clientDrawingEffect);
    ///IDWriteTextLayout::Draw calls this application callback when it needs to draw an inline object.
    ///Params:
    ///    clientDrawingContext = Type: <b>void*</b> The application-defined drawing context passed to IDWriteTextLayout::Draw.
    ///    originX = Type: <b>FLOAT</b> X-coordinate at the top-left corner of the inline object.
    ///    originY = Type: <b>FLOAT</b> Y-coordinate at the top-left corner of the inline object.
    ///    inlineObject = Type: <b>IDWriteInlineObject*</b> The application-defined inline object set using
    ///                   IDWriteTextFormat::SetInlineObject.
    ///    isSideways = Type: <b>BOOL</b> A Boolean flag that indicates whether the object's baseline runs alongside the baseline
    ///                 axis of the line.
    ///    isRightToLeft = Type: <b>BOOL</b> A Boolean flag that indicates whether the object is in a right-to-left context, hinting
    ///                    that the drawing may want to mirror the normal image.
    ///    clientDrawingEffect = Type: <b>IUnknown*</b> Application-defined drawing effects for the glyphs to render. Usually this argument
    ///                          represents effects such as the foreground brush filling the interior of a line.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT DrawInlineObject(void* clientDrawingContext, float originX, float originY, 
                             IDWriteInlineObject inlineObject, BOOL isSideways, BOOL isRightToLeft, 
                             IUnknown clientDrawingEffect);
}

///The <b>IDWriteTextLayout</b> interface represents a block of text after it has been fully analyzed and formatted.
@GUID("53737037-6D14-410B-9BFE-0B182BB70961")
interface IDWriteTextLayout : IDWriteTextFormat
{
    ///Sets the layout maximum width.
    ///Params:
    ///    maxWidth = Type: <b>FLOAT</b> A value that indicates the maximum width of the layout box.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetMaxWidth(float maxWidth);
    ///Sets the layout maximum height.
    ///Params:
    ///    maxHeight = Type: <b>FLOAT</b> A value that indicates the maximum height of the layout box.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetMaxHeight(float maxHeight);
    ///Sets the font collection.
    ///Params:
    ///    fontCollection = Type: <b>IDWriteFontCollection*</b> The font collection to set.
    ///    textRange = Type: <b>DWRITE_TEXT_RANGE</b> Text range to which this change applies.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetFontCollection(IDWriteFontCollection fontCollection, DWRITE_TEXT_RANGE textRange);
    ///Sets null-terminated font family name for text within a specified text range.
    ///Params:
    ///    fontFamilyName = Type: <b>const WCHAR*</b> The font family name that applies to the entire text string within the range
    ///                     specified by <i>textRange</i>.
    ///    textRange = Type: <b>DWRITE_TEXT_RANGE</b> Text range to which this change applies.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetFontFamilyName(const(PWSTR) fontFamilyName, DWRITE_TEXT_RANGE textRange);
    ///Sets the font weight for text within a text range specified by a DWRITE_TEXT_RANGE structure.
    ///Params:
    ///    fontWeight = Type: <b>DWRITE_FONT_WEIGHT</b> The font weight to be set for text within the range specified by
    ///                 <i>textRange</i>.
    ///    textRange = Type: <b>DWRITE_TEXT_RANGE</b> Text range to which this change applies.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetFontWeight(DWRITE_FONT_WEIGHT fontWeight, DWRITE_TEXT_RANGE textRange);
    ///Sets the font style for text within a text range specified by a DWRITE_TEXT_RANGE structure.
    ///Params:
    ///    fontStyle = Type: <b>DWRITE_FONT_STYLE</b> The font style to be set for text within a range specified by
    ///                <i>textRange</i>.
    ///    textRange = Type: <b>DWRITE_TEXT_RANGE</b> The text range to which this change applies.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetFontStyle(DWRITE_FONT_STYLE fontStyle, DWRITE_TEXT_RANGE textRange);
    ///Sets the font stretch for text within a specified text range.
    ///Params:
    ///    fontStretch = Type: <b>DWRITE_FONT_STRETCH</b> A value which indicates the type of font stretch for text within the range
    ///                  specified by <i>textRange</i>.
    ///    textRange = Type: <b>DWRITE_TEXT_RANGE</b> Text range to which this change applies.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetFontStretch(DWRITE_FONT_STRETCH fontStretch, DWRITE_TEXT_RANGE textRange);
    ///Sets the font size in DIP units for text within a specified text range.
    ///Params:
    ///    fontSize = Type: <b>FLOAT</b> The font size in DIP units to be set for text in the range specified by <i>textRange</i>.
    ///    textRange = Type: <b>DWRITE_TEXT_RANGE</b> Text range to which this change applies.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetFontSize(float fontSize, DWRITE_TEXT_RANGE textRange);
    ///Sets underlining for text within a specified text range.
    ///Params:
    ///    hasUnderline = Type: <b>BOOL</b> A Boolean flag that indicates whether underline takes place within a specified text range.
    ///    textRange = Type: <b>DWRITE_TEXT_RANGE</b> Text range to which this change applies.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetUnderline(BOOL hasUnderline, DWRITE_TEXT_RANGE textRange);
    ///Sets strikethrough for text within a specified text range.
    ///Params:
    ///    hasStrikethrough = Type: <b>BOOL</b> A Boolean flag that indicates whether strikethrough takes place in the range specified by
    ///                       <i>textRange</i>.
    ///    textRange = Type: <b>DWRITE_TEXT_RANGE</b> Text range to which this change applies.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetStrikethrough(BOOL hasStrikethrough, DWRITE_TEXT_RANGE textRange);
    ///Sets the application-defined drawing effect.
    ///Params:
    ///    drawingEffect = Type: <b>IUnknown*</b> Application-defined drawing effects that apply to the range. This data object will be
    ///                    passed back to the application's drawing callbacks for final rendering.
    ///    textRange = Type: <b>DWRITE_TEXT_RANGE</b> The text range to which this change applies.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetDrawingEffect(IUnknown drawingEffect, DWRITE_TEXT_RANGE textRange);
    ///Sets the inline object.
    ///Params:
    ///    inlineObject = Type: <b>IDWriteInlineObject*</b> An application-defined inline object.
    ///    textRange = Type: <b>DWRITE_TEXT_RANGE</b> Text range to which this change applies.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetInlineObject(IDWriteInlineObject inlineObject, DWRITE_TEXT_RANGE textRange);
    ///Sets font typography features for text within a specified text range.
    ///Params:
    ///    typography = Type: <b>IDWriteTypography*</b> Pointer to font typography settings.
    ///    textRange = Type: <b>DWRITE_TEXT_RANGE</b> Text range to which this change applies.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetTypography(IDWriteTypography typography, DWRITE_TEXT_RANGE textRange);
    ///Sets the locale name for text within a specified text range.
    ///Params:
    ///    localeName = Type: <b>const WCHAR*</b> A null-terminated locale name string.
    ///    textRange = Type: <b>DWRITE_TEXT_RANGE</b> Text range to which this change applies.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetLocaleName(const(PWSTR) localeName, DWRITE_TEXT_RANGE textRange);
    ///Gets the layout maximum width.
    ///Returns:
    ///    Type: <b>FLOAT</b> Returns the layout maximum width.
    ///    
    float   GetMaxWidth();
    ///Gets the layout maximum height.
    ///Returns:
    ///    Type: <b>FLOAT</b> The layout maximum height.
    ///    
    float   GetMaxHeight();
    ///Gets the font collection associated with the text at the specified position.
    ///Params:
    ///    currentPosition = Type: <b>UINT32</b> The position of the text to inspect.
    ///    fontCollection = Type: <b>IDWriteFontCollection**</b> Contains an address of a pointer to the current font collection.
    ///    textRange = Type: <b>DWRITE_TEXT_RANGE*</b> The range of text that has the same formatting as the text at the position
    ///                specified by <i>currentPosition</i>. This means the run has the exact formatting as the position specified,
    ///                including but not limited to the underline.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetFontCollection(uint currentPosition, IDWriteFontCollection* fontCollection, 
                              DWRITE_TEXT_RANGE* textRange);
    ///Get the length of the font family name at the current position.
    ///Params:
    ///    currentPosition = Type: <b>UINT32</b> The current text position.
    ///    nameLength = Type: <b>UINT32*</b> When this method returns, contains the size of the character array containing the font
    ///                 family name, in character count, not including the terminated <b>NULL</b> character.
    ///    textRange = Type: <b>DWRITE_TEXT_RANGE*</b> The range of text that has the same formatting as the text at the position
    ///                specified by <i>currentPosition</i>. This means the run has the exact formatting as the position specified,
    ///                including but not limited to the font family.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetFontFamilyNameLength(uint currentPosition, uint* nameLength, DWRITE_TEXT_RANGE* textRange);
    ///Copies the font family name of the text at the specified position.
    ///Params:
    ///    currentPosition = Type: <b>UINT32</b> The position of the text to examine.
    ///    fontFamilyName = Type: <b>WCHAR*</b> When this method returns, contains an array of characters that receives the current font
    ///                     family name. You must allocate storage for this parameter.
    ///    nameSize = Type: <b>UINT32</b> The size of the character array in character count including the terminated <b>NULL</b>
    ///               character.
    ///    textRange = Type: <b>DWRITE_TEXT_RANGE*</b> The range of text that has the same formatting as the text at the position
    ///                specified by <i>currentPosition</i>. This means the run has the exact formatting as the position specified,
    ///                including but not limited to the font family name.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetFontFamilyName(uint currentPosition, PWSTR fontFamilyName, uint nameSize, 
                              DWRITE_TEXT_RANGE* textRange);
    ///Gets the font weight of the text at the specified position.
    ///Params:
    ///    currentPosition = Type: <b>UINT32</b> The position of the text to inspect.
    ///    fontWeight = Type: <b>DWRITE_FONT_WEIGHT*</b> When this method returns, contains a value which indicates the type of font
    ///                 weight being applied at the specified position.
    ///    textRange = Type: <b>DWRITE_TEXT_RANGE*</b> The range of text that has the same formatting as the text at the position
    ///                specified by <i>currentPosition</i>. This means the run has the exact formatting as the position specified,
    ///                including but not limited to the font weight.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetFontWeight(uint currentPosition, DWRITE_FONT_WEIGHT* fontWeight, DWRITE_TEXT_RANGE* textRange);
    ///Gets the font style (also known as slope) of the text at the specified position.
    ///Params:
    ///    currentPosition = Type: <b>UINT32</b> The position of the text to inspect.
    ///    fontStyle = Type: <b>DWRITE_FONT_STYLE*</b> When this method returns, contains a value which indicates the type of font
    ///                style (also known as slope or incline) being applied at the specified position.
    ///    textRange = Type: <b>DWRITE_TEXT_RANGE*</b> The range of text that has the same formatting as the text at the position
    ///                specified by <i>currentPosition</i>. This means the run has the exact formatting as the position specified,
    ///                including but not limited to the font style.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetFontStyle(uint currentPosition, DWRITE_FONT_STYLE* fontStyle, DWRITE_TEXT_RANGE* textRange);
    ///Gets the font stretch of the text at the specified position.
    ///Params:
    ///    currentPosition = Type: <b>UINT32</b> The position of the text to inspect.
    ///    fontStretch = Type: <b>DWRITE_FONT_STRETCH*</b> When this method returns, contains a value which indicates the type of font
    ///                  stretch (also known as width) being applied at the specified position.
    ///    textRange = Type: <b>DWRITE_TEXT_RANGE*</b> The range of text that has the same formatting as the text at the position
    ///                specified by <i>currentPosition</i>. This means the run has the exact formatting as the position specified,
    ///                including but not limited to the font stretch.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetFontStretch(uint currentPosition, DWRITE_FONT_STRETCH* fontStretch, DWRITE_TEXT_RANGE* textRange);
    ///Gets the font em height of the text at the specified position.
    ///Params:
    ///    currentPosition = Type: <b>UINT32</b> The position of the text to inspect.
    ///    fontSize = Type: <b>FLOAT*</b> When this method returns, contains the size of the font in ems of the text at the
    ///               specified position.
    ///    textRange = Type: <b>DWRITE_TEXT_RANGE*</b> The range of text that has the same formatting as the text at the position
    ///                specified by <i>currentPosition</i>. This means the run has the exact formatting as the position specified,
    ///                including but not limited to the font size.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetFontSize(uint currentPosition, float* fontSize, DWRITE_TEXT_RANGE* textRange);
    ///Gets the underline presence of the text at the specified position.
    ///Params:
    ///    currentPosition = Type: <b>UINT32</b> The current text position.
    ///    hasUnderline = Type: <b>BOOL*</b> A Boolean flag that indicates whether underline is present at the position indicated by
    ///                   <i>currentPosition</i>.
    ///    textRange = Type: <b>DWRITE_TEXT_RANGE*</b> The range of text that has the same formatting as the text at the position
    ///                specified by <i>currentPosition</i>. This means the run has the exact formatting as the position specified,
    ///                including but not limited to the underline.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetUnderline(uint currentPosition, BOOL* hasUnderline, DWRITE_TEXT_RANGE* textRange);
    ///Get the strikethrough presence of the text at the specified position.
    ///Params:
    ///    currentPosition = Type: <b>UINT32</b> The position of the text to inspect.
    ///    hasStrikethrough = Type: <b>BOOL*</b> A Boolean flag that indicates whether strikethrough is present at the position indicated
    ///                       by <i>currentPosition</i>.
    ///    textRange = Type: <b>DWRITE_TEXT_RANGE*</b> Contains the range of text that has the same formatting as the text at the
    ///                position specified by <i>currentPosition</i>. This means the run has the exact formatting as the position
    ///                specified, including but not limited to strikethrough.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetStrikethrough(uint currentPosition, BOOL* hasStrikethrough, DWRITE_TEXT_RANGE* textRange);
    ///Gets the application-defined drawing effect at the specified text position.
    ///Params:
    ///    currentPosition = Type: <b>UINT32</b> The position of the text whose drawing effect is to be retrieved.
    ///    drawingEffect = Type: <b>IUnknown**</b> When this method returns, contains an address of a pointer to the current
    ///                    application-defined drawing effect. Usually this effect is a foreground brush that is used in glyph drawing.
    ///    textRange = Type: <b>DWRITE_TEXT_RANGE*</b> Contains the range of text that has the same formatting as the text at the
    ///                position specified by <i>currentPosition</i>. This means the run has the exact formatting as the position
    ///                specified, including but not limited to the drawing effect.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetDrawingEffect(uint currentPosition, IUnknown* drawingEffect, DWRITE_TEXT_RANGE* textRange);
    ///Gets the inline object at the specified position.
    ///Params:
    ///    currentPosition = Type: <b>UINT32</b> The specified text position.
    ///    inlineObject = Type: <b>IDWriteInlineObject**</b> Contains the application-defined inline object.
    ///    textRange = Type: <b>DWRITE_TEXT_RANGE*</b> The range of text that has the same formatting as the text at the position
    ///                specified by <i>currentPosition</i>. This means the run has the exact formatting as the position specified,
    ///                including but not limited to the inline object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetInlineObject(uint currentPosition, IDWriteInlineObject* inlineObject, DWRITE_TEXT_RANGE* textRange);
    ///Gets the typography setting of the text at the specified position.
    ///Params:
    ///    currentPosition = Type: <b>UINT32</b> The position of the text to inspect.
    ///    typography = Type: <b>IDWriteTypography**</b> When this method returns, contains an address of a pointer to the current
    ///                 typography setting.
    ///    textRange = Type: <b>DWRITE_TEXT_RANGE*</b> The range of text that has the same formatting as the text at the position
    ///                specified by <i>currentPosition</i>. This means the run has the exact formatting as the position specified,
    ///                including but not limited to the typography.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetTypography(uint currentPosition, IDWriteTypography* typography, DWRITE_TEXT_RANGE* textRange);
    ///Gets the length of the locale name of the text at the specified position.
    ///Params:
    ///    currentPosition = Type: <b>UINT32</b> The position of the text to inspect.
    ///    nameLength = Type: <b>UINT32*</b> Size of the character array, in character count, not including the terminated
    ///                 <b>NULL</b> character.
    ///    textRange = Type: <b>DWRITE_TEXT_RANGE*</b> The range of text that has the same formatting as the text at the position
    ///                specified by <i>currentPosition</i>. This means the run has the exact formatting as the position specified,
    ///                including but not limited to the locale name.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetLocaleNameLength(uint currentPosition, uint* nameLength, DWRITE_TEXT_RANGE* textRange);
    ///Gets the locale name of the text at the specified position.
    ///Params:
    ///    currentPosition = Type: <b>UINT32</b> The position of the text to inspect.
    ///    localeName = Type: <b>WCHAR*</b> When this method returns, contains the character array receiving the current locale name.
    ///    nameSize = Type: <b>UINT32</b> Size of the character array, in character count, including the terminated <b>NULL</b>
    ///               character.
    ///    textRange = Type: <b>DWRITE_TEXT_RANGE*</b> The range of text that has the same formatting as the text at the position
    ///                specified by <i>currentPosition</i>. This means the run has the exact formatting as the position specified,
    ///                including but not limited to the locale name.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetLocaleName(uint currentPosition, PWSTR localeName, uint nameSize, DWRITE_TEXT_RANGE* textRange);
    ///Draws text using the specified client drawing context.
    ///Params:
    ///    clientDrawingContext = Type: <b>void*</b> An application-defined drawing context.
    ///    renderer = Type: <b>IDWriteTextRenderer*</b> Pointer to the set of callback functions used to draw parts of a text
    ///               string.
    ///    originX = Type: <b>FLOAT</b> The x-coordinate of the layout's left side.
    ///    originY = Type: <b>FLOAT</b> The y-coordinate of the layout's top side.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Draw(void* clientDrawingContext, IDWriteTextRenderer renderer, float originX, float originY);
    ///Retrieves the information about each individual text line of the text string.
    ///Params:
    ///    lineMetrics = Type: <b>DWRITE_LINE_METRICS*</b> When this method returns, contains a pointer to an array of structures
    ///                  containing various calculated length values of individual text lines.
    ///    maxLineCount = Type: <b>UINT32</b> The maximum size of the <i>lineMetrics</i> array.
    ///    actualLineCount = Type: <b>UINT32*</b> When this method returns, contains the actual size of the <i>lineMetrics</i>array that
    ///                      is needed.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetLineMetrics(DWRITE_LINE_METRICS* lineMetrics, uint maxLineCount, uint* actualLineCount);
    ///Retrieves overall metrics for the formatted string.
    ///Params:
    ///    textMetrics = Type: <b>DWRITE_TEXT_METRICS*</b> When this method returns, contains the measured distances of text and
    ///                  associated content after being formatted.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetMetrics(DWRITE_TEXT_METRICS* textMetrics);
    ///Returns the overhangs (in DIPs) of the layout and all objects contained in it, including text glyphs and inline
    ///objects.
    ///Params:
    ///    overhangs = Type: <b>DWRITE_OVERHANG_METRICS*</b> Overshoots of visible extents (in DIPs) outside the layout.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetOverhangMetrics(DWRITE_OVERHANG_METRICS* overhangs);
    ///Retrieves logical properties and measurements of each glyph cluster.
    ///Params:
    ///    clusterMetrics = Type: <b>DWRITE_CLUSTER_METRICS*</b> When this method returns, contains metrics, such as line-break or total
    ///                     advance width, for a glyph cluster.
    ///    maxClusterCount = Type: <b>UINT32</b> The maximum size of the <i>clusterMetrics</i> array.
    ///    actualClusterCount = Type: <b>UINT32*</b> When this method returns, contains the actual size of the <i>clusterMetrics</i> array
    ///                         that is needed.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetClusterMetrics(DWRITE_CLUSTER_METRICS* clusterMetrics, uint maxClusterCount, 
                              uint* actualClusterCount);
    ///Determines the minimum possible width the layout can be set to without emergency breaking between the characters
    ///of whole words occurring.
    ///Params:
    ///    minWidth = Type: <b>FLOAT*</b> Minimum width.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT DetermineMinWidth(float* minWidth);
    ///The application calls this function passing in a specific pixel location relative to the top-left location of the
    ///layout box and obtains the information about the correspondent hit-test metrics of the text string where the
    ///hit-test has occurred. When the specified pixel location is outside the text string, the function sets the output
    ///value <i>*isInside</i> to <b>FALSE</b>.
    ///Params:
    ///    pointX = Type: <b>FLOAT</b> The pixel location X to hit-test, relative to the top-left location of the layout box.
    ///    pointY = Type: <b>FLOAT</b> The pixel location Y to hit-test, relative to the top-left location of the layout box.
    ///    isTrailingHit = Type: <b>BOOL*</b> An output flag that indicates whether the hit-test location is at the leading or the
    ///                    trailing side of the character. When the output <i>*isInside</i> value is set to <b>FALSE</b>, this value is
    ///                    set according to the output <i>hitTestMetrics-&gt;textPosition</i> value to represent the edge closest to the
    ///                    hit-test location.
    ///    isInside = Type: <b>BOOL*</b> An output flag that indicates whether the hit-test location is inside the text string.
    ///               When <b>FALSE</b>, the position nearest the text's edge is returned.
    ///    hitTestMetrics = Type: <b>DWRITE_HIT_TEST_METRICS*</b> The output geometry fully enclosing the hit-test location. When the
    ///                     output <i>*isInside</i> value is set to <b>FALSE</b>, this structure represents the geometry enclosing the
    ///                     edge closest to the hit-test location.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT HitTestPoint(float pointX, float pointY, BOOL* isTrailingHit, BOOL* isInside, 
                         DWRITE_HIT_TEST_METRICS* hitTestMetrics);
    ///The application calls this function to get the pixel location relative to the top-left of the layout box given
    ///the text position and the logical side of the position. This function is normally used as part of caret
    ///positioning of text where the caret is drawn at the location corresponding to the current text editing position.
    ///It may also be used as a way to programmatically obtain the geometry of a particular text position in UI
    ///automation.
    ///Params:
    ///    textPosition = Type: <b>UINT32</b> The text position used to get the pixel location.
    ///    isTrailingHit = Type: <b>BOOL</b> A Boolean flag that indicates whether the pixel location is of the leading or the trailing
    ///                    side of the specified text position.
    ///    pointX = Type: <b>FLOAT*</b> When this method returns, contains the output pixel location X, relative to the top-left
    ///             location of the layout box.
    ///    pointY = Type: <b>FLOAT*</b> When this method returns, contains the output pixel location Y, relative to the top-left
    ///             location of the layout box.
    ///    hitTestMetrics = Type: <b>DWRITE_HIT_TEST_METRICS*</b> When this method returns, contains the output geometry fully enclosing
    ///                     the specified text position.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT HitTestTextPosition(uint textPosition, BOOL isTrailingHit, float* pointX, float* pointY, 
                                DWRITE_HIT_TEST_METRICS* hitTestMetrics);
    ///The application calls this function to get a set of hit-test metrics corresponding to a range of text positions.
    ///One of the main usages is to implement highlight selection of the text string. The function returns
    ///E_NOT_SUFFICIENT_BUFFER, which is equivalent to HRESULT_FROM_WIN32(ERROR_INSUFFICIENT_BUFFER), when the buffer
    ///size of hitTestMetrics is too small to hold all the regions calculated by the function. In this situation, the
    ///function sets the output value *actualHitTestMetricsCount to the number of geometries calculated. The application
    ///is responsible for allocating a new buffer of greater size and calling the function again. A good value to use as
    ///an initial value for maxHitTestMetricsCount may be calculated from the following equation: <pre class="syntax"
    ///xml:space="preserve"><code>maxHitTestMetricsCount = lineCount * maxBidiReorderingDepth</code></pre> where
    ///lineCount is obtained from the value of the output argument *actualLineCount (from the function
    ///IDWriteTextLayout::GetLineLengths), and the maxBidiReorderingDepth value from the DWRITE_TEXT_METRICSstructure of
    ///the output argument *textMetrics (from the function IDWriteFactory::CreateTextLayout).
    ///Params:
    ///    textPosition = Type: <b>UINT32</b> The first text position of the specified range.
    ///    textLength = Type: <b>UINT32</b> The number of positions of the specified range.
    ///    originX = Type: <b>FLOAT</b> The origin pixel location X at the left of the layout box. This offset is added to the
    ///              hit-test metrics returned.
    ///    originY = Type: <b>FLOAT</b> The origin pixel location Y at the top of the layout box. This offset is added to the
    ///              hit-test metrics returned.
    ///    hitTestMetrics = Type: <b>DWRITE_HIT_TEST_METRICS*</b> When this method returns, contains a pointer to a buffer of the output
    ///                     geometry fully enclosing the specified position range. The buffer must be at least as large as
    ///                     <i>maxHitTestMetricsCount</i>.
    ///    maxHitTestMetricsCount = Type: <b>UINT32</b> Maximum number of boxes <i>hitTestMetrics</i> could hold in its buffer memory.
    ///    actualHitTestMetricsCount = Type: <b>UINT32*</b> Actual number of geometries <i>hitTestMetrics</i> holds in its buffer memory.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT HitTestTextRange(uint textPosition, uint textLength, float originX, float originY, 
                             DWRITE_HIT_TEST_METRICS* hitTestMetrics, uint maxHitTestMetricsCount, 
                             uint* actualHitTestMetricsCount);
}

///Encapsulates a 32-bit device independent bitmap and device context, which can be used for rendering glyphs.
@GUID("5E5A32A3-8DFF-4773-9FF6-0696EAB77267")
interface IDWriteBitmapRenderTarget : IUnknown
{
    ///Draws a run of glyphs to a bitmap target at the specified position.
    ///Params:
    ///    baselineOriginX = Type: <b>FLOAT</b> The horizontal position of the baseline origin, in DIPs, relative to the upper-left corner
    ///                      of the DIB.
    ///    baselineOriginY = Type: <b>FLOAT</b> The vertical position of the baseline origin, in DIPs, relative to the upper-left corner
    ///                      of the DIB.
    ///    measuringMode = Type: <b>DWRITE_MEASURING_MODE</b> The measuring method for glyphs in the run, used with the other properties
    ///                    to determine the rendering mode.
    ///    glyphRun = Type: <b>const DWRITE_GLYPH_RUN*</b> The structure containing the properties of the glyph run.
    ///    renderingParams = Type: <b>IDWriteRenderingParams*</b> The object that controls rendering behavior.
    ///    textColor = Type: <b>COLORREF</b> The foreground color of the text.
    ///    blackBoxRect = Type: <b>RECT*</b> The optional rectangle that receives the bounding box (in pixels not DIPs) of all the
    ///                   pixels affected by drawing the glyph run. The black box rectangle may extend beyond the dimensions of the
    ///                   bitmap.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT DrawGlyphRun(float baselineOriginX, float baselineOriginY, DWRITE_MEASURING_MODE measuringMode, 
                         const(DWRITE_GLYPH_RUN)* glyphRun, IDWriteRenderingParams renderingParams, uint textColor, 
                         RECT* blackBoxRect);
    ///Gets a handle to the memory device context.
    ///Returns:
    ///    Type: <b>HDC</b> Returns a device context handle to the memory device context.
    ///    
    HDC     GetMemoryDC();
    ///Gets the number of bitmap pixels per DIP.
    ///Returns:
    ///    Type: <b>FLOAT</b> The number of bitmap pixels per DIP.
    ///    
    float   GetPixelsPerDip();
    ///Sets the number of bitmap pixels per DIP (device-independent pixel). A DIP is 1/96 inch, so this value is the
    ///number if pixels per inch divided by 96.
    ///Params:
    ///    pixelsPerDip = Type: <b>FLOAT</b> A value that specifies the number of pixels per DIP.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetPixelsPerDip(float pixelsPerDip);
    ///Gets the transform that maps abstract coordinates to DIPs. By default this is the identity transform. Note that
    ///this is unrelated to the world transform of the underlying device context.
    ///Params:
    ///    transform = Type: <b>DWRITE_MATRIX*</b> When this method returns, contains a transform matrix.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetCurrentTransform(DWRITE_MATRIX* transform);
    ///Sets the transform that maps abstract coordinate to DIPs (device-independent pixel). This does not affect the
    ///world transform of the underlying device context.
    ///Params:
    ///    transform = Type: <b>const DWRITE_MATRIX*</b> Specifies the new transform. This parameter can be <b>NULL</b>, in which
    ///                case the identity transform is implied.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetCurrentTransform(const(DWRITE_MATRIX)* transform);
    ///Gets the dimensions of the target bitmap.
    ///Params:
    ///    size = Type: <b>SIZE*</b> Returns the width and height of the bitmap in pixels.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetSize(SIZE* size);
    ///Resizes the bitmap.
    ///Params:
    ///    width = Type: <b>UINT32</b> The new bitmap width, in pixels.
    ///    height = Type: <b>UINT32</b> The new bitmap height, in pixels.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Resize(uint width, uint height);
}

///Provides interoperability with GDI, such as methods to convert a font face to a LOGFONT structure, or to convert a
///GDI font description into a font face. It is also used to create bitmap render target objects.
@GUID("1EDD9491-9853-4299-898F-6432983B6F3A")
interface IDWriteGdiInterop : IUnknown
{
    ///Creates a font object that matches the properties specified by the <b>LOGFONT</b> structure.
    ///Params:
    ///    logFont = Type: <b>const LOGFONTW*</b> A structure containing a GDI-compatible font description.
    ///    font = Type: <b>IDWriteFont**</b> When this method returns, contains an address of a pointer to a newly created
    ///           IDWriteFont object if successful; otherwise, <b>NULL</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateFontFromLOGFONT(const(LOGFONTW)* logFont, IDWriteFont* font);
    ///Initializes a <b>LOGFONT</b> structure based on the GDI-compatible properties of the specified font.
    ///Params:
    ///    font = Type: <b>IDWriteFont*</b> An IDWriteFont object to be converted into a GDI-compatible <b>LOGFONT</b>
    ///           structure.
    ///    logFont = Type: <b>LOGFONTW*</b> When this method returns, contains a structure that receives a GDI-compatible font
    ///              description.
    ///    isSystemFont = Type: <b>BOOL*</b> When this method returns, contains <b>TRUE</b> if the specified font object is part of the
    ///                   system font collection; otherwise, <b>FALSE</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ConvertFontToLOGFONT(IDWriteFont font, LOGFONTW* logFont, BOOL* isSystemFont);
    ///Initializes a LOGFONT structure based on the GDI-compatible properties of the specified font.
    ///Params:
    ///    font = Type: <b>IDWriteFontFace*</b> An IDWriteFontFace object to be converted into a GDI-compatible LOGFONT
    ///           structure.
    ///    logFont = Type: <b>LOGFONTW*</b> When this method returns, contains a pointer to a structure that receives a
    ///              GDI-compatible font description.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ConvertFontFaceToLOGFONT(IDWriteFontFace font, LOGFONTW* logFont);
    ///Creates an <b>IDWriteFontFace</b> object that corresponds to the currently selected <b>HFONT</b> of the specified
    ///<b>HDC</b>.
    ///Params:
    ///    hdc = Type: <b>HDC</b> A handle to a device context into which a font has been selected. It is assumed that the
    ///          client has already performed font mapping and that the font selected into the device context is the actual
    ///          font to be used for rendering glyphs.
    ///    fontFace = Type: <b>IDWriteFontFace**</b> Contains an address of a pointer to the newly created font face object, or
    ///               <b>NULL</b> in case of failure. The font face returned is guaranteed to reference the same physical typeface
    ///               that would be used for drawing glyphs (but not necessarily characters) using ExtTextOut.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateFontFaceFromHdc(HDC hdc, IDWriteFontFace* fontFace);
    ///Creates an object that encapsulates a bitmap and memory DC (device context) which can be used for rendering
    ///glyphs.
    ///Params:
    ///    hdc = Type: <b>HDC</b> A handle to the optional device context used to create a compatible memory DC (device
    ///          context).
    ///    width = Type: <b>UINT32</b> The width of the bitmap render target.
    ///    height = Type: <b>UINT32</b> The height of the bitmap render target.
    ///    renderTarget = Type: <b>IDWriteBitmapRenderTarget**</b> When this method returns, contains an address of a pointer to the
    ///                   newly created IDWriteBitmapRenderTarget object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateBitmapRenderTarget(HDC hdc, uint width, uint height, IDWriteBitmapRenderTarget* renderTarget);
}

///Contains low-level information used to render a glyph run.
@GUID("7D97DBF7-E085-42D4-81E3-6A883BDED118")
interface IDWriteGlyphRunAnalysis : IUnknown
{
    ///Gets the bounding rectangle of the physical pixels affected by the glyph run.
    ///Params:
    ///    textureType = Type: <b>DWRITE_TEXTURE_TYPE</b> Specifies the type of texture requested. If a bi-level texture is requested,
    ///                  the bounding rectangle includes only bi-level glyphs. Otherwise, the bounding rectangle includes only
    ///                  antialiased glyphs.
    ///    textureBounds = Type: <b>RECT*</b> When this method returns, contains the bounding rectangle of the physical pixels affected
    ///                    by the glyph run, or an empty rectangle if there are no glyphs of the specified texture type.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetAlphaTextureBounds(DWRITE_TEXTURE_TYPE textureType, RECT* textureBounds);
    ///Creates an alpha texture of the specified type for glyphs within a specified bounding rectangle.
    ///Params:
    ///    textureType = Type: <b>DWRITE_TEXTURE_TYPE</b> A value that specifies the type of texture requested. This can be
    ///                  DWRITE_TEXTURE_BILEVEL_1x1 or <b>DWRITE_TEXTURE_CLEARTYPE_3x1</b>. If a bi-level texture is requested, the
    ///                  texture contains only bi-level glyphs. Otherwise, the texture contains only antialiased glyphs.
    ///    textureBounds = Type: <b>const RECT*</b> The bounding rectangle of the texture, which can be different than the bounding
    ///                    rectangle returned by GetAlphaTextureBounds.
    ///    alphaValues = Type: <b>BYTE*</b> When this method returns, contains the array of alpha values from the texture. The buffer
    ///                  allocated for this array must be at least the size of <i>bufferSize</i>.
    ///    bufferSize = Type: <b>UINT32</b> The size of the <i>alphaValues</i> array, in bytes. The minimum size depends on the
    ///                 dimensions of the rectangle and the type of texture requested.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateAlphaTexture(DWRITE_TEXTURE_TYPE textureType, const(RECT)* textureBounds, ubyte* alphaValues, 
                               uint bufferSize);
    ///Gets alpha blending properties required for ClearType blending.
    ///Params:
    ///    renderingParams = Type: <b>IDWriteRenderingParams*</b> An object that specifies the ClearType level and enhanced contrast,
    ///                      gamma, pixel geometry, and rendering mode. In most cases, the values returned by the output parameters of
    ///                      this method are based on the properties of this object, unless a GDI-compatible rendering mode was specified.
    ///    blendGamma = Type: <b>FLOAT*</b> When this method returns, contains the gamma value to use for gamma correction.
    ///    blendEnhancedContrast = Type: <b>FLOAT*</b> When this method returns, contains the enhanced contrast value to be used for blending.
    ///    blendClearTypeLevel = Type: <b>FLOAT*</b> When this method returns, contains the ClearType level used in the alpha blending.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetAlphaBlendParams(IDWriteRenderingParams renderingParams, float* blendGamma, 
                                float* blendEnhancedContrast, float* blendClearTypeLevel);
}

///Used to create all subsequent DirectWrite objects. This interface is the root factory interface for all DirectWrite
///objects.
@GUID("B859EE5A-D838-4B5B-A2E8-1ADC7D93DB48")
interface IDWriteFactory : IUnknown
{
    ///Gets an object which represents the set of installed fonts.
    ///Params:
    ///    fontCollection = Type: <b>IDWriteFontCollection**</b> When this method returns, contains the address of a pointer to the
    ///                     system font collection object, or <b>NULL</b> in case of failure.
    ///    checkForUpdates = Type: <b>BOOL</b> If this parameter is nonzero, the function performs an immediate check for changes to the
    ///                      set of installed fonts. If this parameter is <b>FALSE</b>, the function will still detect changes if the font
    ///                      cache service is running, but there may be some latency. For example, an application might specify
    ///                      <b>TRUE</b> if it has itself just installed a font and wants to be sure the font collection contains that
    ///                      font.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetSystemFontCollection(IDWriteFontCollection* fontCollection, BOOL checkForUpdates);
    ///Creates a font collection using a custom font collection loader.
    ///Params:
    ///    collectionLoader = Type: <b>IDWriteFontCollectionLoader*</b> An application-defined font collection loader, which must have been
    ///                       previously registered using RegisterFontCollectionLoader.
    ///    collectionKey = Type: <b>const void*</b> The key used by the loader to identify a collection of font files. The buffer
    ///                    allocated for this key should at least be the size of <i>collectionKeySize</i>.
    ///    collectionKeySize = Type: <b>UINT32</b> The size, in bytes, of the collection key.
    ///    fontCollection = Type: <b>IDWriteFontCollection**</b> Contains an address of a pointer to the system font collection object if
    ///                     the method succeeds, or <b>NULL</b> in case of failure.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateCustomFontCollection(IDWriteFontCollectionLoader collectionLoader, const(void)* collectionKey, 
                                       uint collectionKeySize, IDWriteFontCollection* fontCollection);
    ///Registers a custom font collection loader with the factory object.
    ///Params:
    ///    fontCollectionLoader = Type: <b>IDWriteFontCollectionLoader*</b> Pointer to a IDWriteFontCollectionLoader object to be registered.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT RegisterFontCollectionLoader(IDWriteFontCollectionLoader fontCollectionLoader);
    ///Unregisters a custom font collection loader that was previously registered using RegisterFontCollectionLoader.
    ///Params:
    ///    fontCollectionLoader = Type: <b>IDWriteFontCollectionLoader*</b> Pointer to a IDWriteFontCollectionLoader object to be unregistered.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT UnregisterFontCollectionLoader(IDWriteFontCollectionLoader fontCollectionLoader);
    ///Creates a font file reference object from a local font file.
    ///Params:
    ///    filePath = Type: <b>const WCHAR*</b> An array of characters that contains the absolute file path for the font file.
    ///               Subsequent operations on the constructed object may fail if the user provided <i>filePath</i> doesn't
    ///               correspond to a valid file on the disk.
    ///    lastWriteTime = Type: <b>const FILETIME*</b> The last modified time of the input file path. If the parameter is omitted, the
    ///                    function will access the font file to obtain its last write time. You should specify this value to avoid
    ///                    extra disk access. Subsequent operations on the constructed object may fail if the user provided
    ///                    <i>lastWriteTime</i> doesn't match the file on the disk.
    ///    fontFile = Type: <b>IDWriteFontFile**</b> When this method returns, contains an address of a pointer to the newly
    ///               created font file reference object, or <b>NULL</b> in case of failure.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateFontFileReference(const(PWSTR) filePath, const(FILETIME)* lastWriteTime, 
                                    IDWriteFontFile* fontFile);
    ///Creates a reference to an application-specific font file resource.
    ///Params:
    ///    fontFileReferenceKey = Type: <b>const void*</b> A font file reference key that uniquely identifies the font file resource during the
    ///                           lifetime of <i>fontFileLoader</i>.
    ///    fontFileReferenceKeySize = Type: <b>UINT32</b> The size of the font file reference key in bytes.
    ///    fontFileLoader = Type: <b>IDWriteFontFileLoader*</b> The font file loader that will be used by the font system to load data
    ///                     from the file identified by <i>fontFileReferenceKey</i>.
    ///    fontFile = Type: <b>IDWriteFontFile**</b> Contains an address of a pointer to the newly created font file object when
    ///               this method succeeds, or <b>NULL</b> in case of failure.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateCustomFontFileReference(const(void)* fontFileReferenceKey, uint fontFileReferenceKeySize, 
                                          IDWriteFontFileLoader fontFileLoader, IDWriteFontFile* fontFile);
    ///Creates an object that represents a font face.
    ///Params:
    ///    fontFaceType = Type: <b>DWRITE_FONT_FACE_TYPE</b> A value that indicates the type of file format of the font face.
    ///    numberOfFiles = Type: <b>UINT32</b> The number of font files, in element count, required to represent the font face.
    ///    fontFiles = Type: <b>const IDWriteFontFile*</b> A font file object representing the font face. Because
    ///                IDWriteFontFacemaintains its own references to the input font file objects, you may release them after this
    ///                call.
    ///    faceIndex = Type: <b>UINT32</b> The zero-based index of a font face, in cases when the font files contain a collection of
    ///                font faces. If the font files contain a single face, this value should be zero.
    ///    fontFaceSimulationFlags = Type: <b>DWRITE_FONT_SIMULATIONS</b> A value that indicates which, if any, font face simulation flags for
    ///                              algorithmic means of making text bold or italic are applied to the current font face.
    ///    fontFace = Type: <b>IDWriteFontFace**</b> When this method returns, contains an address of a pointer to the newly
    ///               created font face object, or <b>NULL</b> in case of failure.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateFontFace(DWRITE_FONT_FACE_TYPE fontFaceType, uint numberOfFiles, IDWriteFontFile* fontFiles, 
                           uint faceIndex, DWRITE_FONT_SIMULATIONS fontFaceSimulationFlags, 
                           IDWriteFontFace* fontFace);
    ///Creates a rendering parameters object with default settings for the primary monitor. Different monitors may have
    ///different rendering parameters, for more information see the How to Add Support for Multiple Monitors topic.
    ///Params:
    ///    renderingParams = Type: <b>IDWriteRenderingParams**</b> When this method returns, contains an address of a pointer to the newly
    ///                      created rendering parameters object.
    ///Returns:
    ///    Type: <b>HRESULT</b> Standard HRESULT error code.
    ///    
    HRESULT CreateRenderingParams(IDWriteRenderingParams* renderingParams);
    ///Creates a rendering parameters object with default settings for the specified monitor. In most cases, this is the
    ///preferred way to create a rendering parameters object.
    ///Params:
    ///    monitor = Type: <b>HMONITOR</b> A handle for the specified monitor.
    ///    renderingParams = Type: <b>IDWriteRenderingParams**</b> When this method returns, contains an address of a pointer to the
    ///                      rendering parameters object created by this method.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateMonitorRenderingParams(HMONITOR monitor, IDWriteRenderingParams* renderingParams);
    ///Creates a rendering parameters object with the specified properties.
    ///Params:
    ///    gamma = Type: <b>FLOAT</b> The gamma level to be set for the new rendering parameters object.
    ///    enhancedContrast = Type: <b>FLOAT</b> The enhanced contrast level to be set for the new rendering parameters object.
    ///    clearTypeLevel = Type: <b>FLOAT</b> The ClearType level to be set for the new rendering parameters object.
    ///    pixelGeometry = Type: <b>DWRITE_PIXEL_GEOMETRY</b> Represents the internal structure of a device pixel (that is, the physical
    ///                    arrangement of red, green, and blue color components) that is assumed for purposes of rendering text.
    ///    renderingMode = Type: <b>DWRITE_RENDERING_MODE</b> A value that represents the method (for example, ClearType natural
    ///                    quality) for rendering glyphs.
    ///    renderingParams = Type: <b>IDWriteRenderingParams**</b> When this method returns, contains an address of a pointer to the newly
    ///                      created rendering parameters object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateCustomRenderingParams(float gamma, float enhancedContrast, float clearTypeLevel, 
                                        DWRITE_PIXEL_GEOMETRY pixelGeometry, DWRITE_RENDERING_MODE renderingMode, 
                                        IDWriteRenderingParams* renderingParams);
    ///Registers a font file loader with DirectWrite.
    ///Params:
    ///    fontFileLoader = Type: <b>IDWriteFontFileLoader*</b> Pointer to a IDWriteFontFileLoader object for a particular file resource
    ///                     type.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT RegisterFontFileLoader(IDWriteFontFileLoader fontFileLoader);
    ///Unregisters a font file loader that was previously registered with the DirectWrite font system using
    ///RegisterFontFileLoader.
    ///Params:
    ///    fontFileLoader = Type: <b>IDWriteFontFileLoader*</b> Pointer to the file loader that was previously registered with the
    ///                     DirectWrite font system using RegisterFontFileLoader.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT UnregisterFontFileLoader(IDWriteFontFileLoader fontFileLoader);
    ///Creates a text format object used for text layout.
    ///Params:
    ///    fontFamilyName = Type: <b>const WCHAR*</b> An array of characters that contains the name of the font family
    ///    fontCollection = Type: <b>IDWriteFontCollection*</b> A pointer to a font collection object. When this is <b>NULL</b>,
    ///                     indicates the system font collection.
    ///    fontWeight = Type: <b>DWRITE_FONT_WEIGHT</b> A value that indicates the font weight for the text object created by this
    ///                 method.
    ///    fontStyle = Type: <b>DWRITE_FONT_STYLE</b> A value that indicates the font style for the text object created by this
    ///                method.
    ///    fontStretch = Type: <b>DWRITE_FONT_STRETCH</b> A value that indicates the font stretch for the text object created by this
    ///                  method.
    ///    fontSize = Type: <b>FLOAT</b> The logical size of the font in DIP ("device-independent pixel") units. A DIP equals 1/96
    ///               inch.
    ///    localeName = Type: <b>const WCHAR*</b> An array of characters that contains the locale name.
    ///    textFormat = Type: <b>IDWriteTextFormat**</b> When this method returns, contains an address of a pointer to a newly
    ///                 created text format object, or <b>NULL</b> in case of failure.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateTextFormat(const(PWSTR) fontFamilyName, IDWriteFontCollection fontCollection, 
                             DWRITE_FONT_WEIGHT fontWeight, DWRITE_FONT_STYLE fontStyle, 
                             DWRITE_FONT_STRETCH fontStretch, float fontSize, const(PWSTR) localeName, 
                             IDWriteTextFormat* textFormat);
    ///Creates a typography object for use in a text layout.
    ///Params:
    ///    typography = Type: <b>IDWriteTypography**</b> When this method returns, contains the address of a pointer to a newly
    ///                 created typography object, or <b>NULL</b> in case of failure.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateTypography(IDWriteTypography* typography);
    ///Creates an object that is used for interoperability with GDI.
    ///Params:
    ///    gdiInterop = Type: <b>IDWriteGdiInterop**</b> When this method returns, contains an address of a pointer to a GDI interop
    ///                 object if successful, or <b>NULL</b> in case of failure.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetGdiInterop(IDWriteGdiInterop* gdiInterop);
    ///Takes a string, text format, and associated constraints, and produces an object that represents the fully
    ///analyzed and formatted result.
    ///Params:
    ///    string = Type: <b>const WCHAR*</b> An array of characters that contains the string to create a new IDWriteTextLayout
    ///             object from. This array must be of length <i>stringLength</i> and can contain embedded <b>NULL</b>
    ///             characters.
    ///    stringLength = Type: <b>UINT32</b> The number of characters in the string.
    ///    textFormat = Type: <b>IDWriteTextFormat*</b> A pointer to an object that indicates the format to apply to the string.
    ///    maxWidth = Type: <b>FLOAT</b> The width of the layout box.
    ///    maxHeight = Type: <b>FLOAT</b> The height of the layout box.
    ///    textLayout = Type: <b>IDWriteTextLayout**</b> When this method returns, contains an address of a pointer to the resultant
    ///                 text layout object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateTextLayout(const(PWSTR) string, uint stringLength, IDWriteTextFormat textFormat, float maxWidth, 
                             float maxHeight, IDWriteTextLayout* textLayout);
    ///Takes a string, format, and associated constraints, and produces an object representing the result, formatted for
    ///a particular display resolution and measuring mode.
    ///Params:
    ///    string = Type: <b>const WCHAR*</b> An array of characters that contains the string to create a new IDWriteTextLayout
    ///             object from. This array must be of length <i>stringLength</i> and can contain embedded <b>NULL</b>
    ///             characters.
    ///    stringLength = Type: <b>UINT32</b> The length of the string, in character count.
    ///    textFormat = Type: <b>IDWriteTextFormat*</b> The text formatting object to apply to the string.
    ///    layoutWidth = Type: <b>FLOAT</b> The width of the layout box.
    ///    layoutHeight = Type: <b>FLOAT</b> The height of the layout box.
    ///    pixelsPerDip = Type: <b>FLOAT</b> The number of physical pixels per DIP (device independent pixel). For example, if
    ///                   rendering onto a 96 DPI device <i>pixelsPerDip</i>is 1. If rendering onto a 120 DPI device
    ///                   <i>pixelsPerDip</i> is 1.25 (120/96).
    ///    transform = Type: <b>const DWRITE_MATRIX*</b> An optional transform applied to the glyphs and their positions. This
    ///                transform is applied after the scaling specifies the font size and pixels per DIP.
    ///    useGdiNatural = Type: <b>BOOL</b> Instructs the text layout to use the same metrics as GDI bi-level text when set to
    ///                    <b>FALSE</b>. When set to <b>TRUE</b>, instructs the text layout to use the same metrics as text measured by
    ///                    GDI using a font created with <b>CLEARTYPE_NATURAL_QUALITY</b>.
    ///    textLayout = Type: <b>IDWriteTextLayout**</b> When this method returns, contains an address to the pointer of the
    ///                 resultant text layout object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateGdiCompatibleTextLayout(const(PWSTR) string, uint stringLength, IDWriteTextFormat textFormat, 
                                          float layoutWidth, float layoutHeight, float pixelsPerDip, 
                                          const(DWRITE_MATRIX)* transform, BOOL useGdiNatural, 
                                          IDWriteTextLayout* textLayout);
    ///Creates an inline object for trimming, using an ellipsis as the omission sign.
    ///Params:
    ///    textFormat = Type: <b>IDWriteTextFormat*</b> A text format object, created with CreateTextFormat, used for text layout.
    ///    trimmingSign = Type: <b>IDWriteInlineObject**</b> When this method returns, contains an address of a pointer to the omission
    ///                   (that is, ellipsis trimming) sign created by this method.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateEllipsisTrimmingSign(IDWriteTextFormat textFormat, IDWriteInlineObject* trimmingSign);
    ///Returns an interface for performing text analysis.
    ///Params:
    ///    textAnalyzer = Type: <b>IDWriteTextAnalyzer**</b> When this method returns, contains an address of a pointer to the newly
    ///                   created text analyzer object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateTextAnalyzer(IDWriteTextAnalyzer* textAnalyzer);
    ///Creates a number substitution object using a locale name, substitution method, and an indicator whether to ignore
    ///user overrides (use NLS defaults for the given culture instead).
    ///Params:
    ///    substitutionMethod = Type: <b>DWRITE_NUMBER_SUBSTITUTION_METHOD</b> A value that specifies how to apply number substitution on
    ///                         digits and related punctuation.
    ///    localeName = Type: <b>const WCHAR*</b> The name of the locale to be used in the <i>numberSubstitution</i> object.
    ///    ignoreUserOverride = Type: <b>BOOL</b> A Boolean flag that indicates whether to ignore user overrides.
    ///    numberSubstitution = Type: <b>IDWriteNumberSubstitution**</b> When this method returns, contains an address to a pointer to the
    ///                         number substitution object created by this method.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateNumberSubstitution(DWRITE_NUMBER_SUBSTITUTION_METHOD substitutionMethod, const(PWSTR) localeName, 
                                     BOOL ignoreUserOverride, IDWriteNumberSubstitution* numberSubstitution);
    ///Creates a glyph run analysis object, which encapsulates information used to render a glyph run.
    ///Params:
    ///    glyphRun = Type: <b>const DWRITE_GLYPH_RUN*</b> A structure that contains the properties of the glyph run (font face,
    ///               advances, and so on).
    ///    pixelsPerDip = Type: <b>FLOAT</b> Number of physical pixels per DIP (device independent pixel). For example, if rendering
    ///                   onto a 96 DPI bitmap then <i>pixelsPerDip</i>is 1. If rendering onto a 120 DPI bitmap then
    ///                   <i>pixelsPerDip</i> is 1.25.
    ///    transform = Type: <b>const DWRITE_MATRIX*</b> Optional transform applied to the glyphs and their positions. This
    ///                transform is applied after the scaling specified the <i>emSize</i> and <i>pixelsPerDip</i>.
    ///    renderingMode = Type: <b>DWRITE_RENDERING_MODE</b> A value that specifies the rendering mode, which must be one of the raster
    ///                    rendering modes (that is, not default and not outline).
    ///    measuringMode = Type: <b>DWRITE_MEASURING_MODE</b> Specifies the measuring mode to use with glyphs.
    ///    baselineOriginX = Type: <b>FLOAT</b> The horizontal position (X-coordinate) of the baseline origin, in DIPs.
    ///    baselineOriginY = Type: <b>FLOAT</b> Vertical position (Y-coordinate) of the baseline origin, in DIPs.
    ///    glyphRunAnalysis = Type: <b>IDWriteGlyphRunAnalysis**</b> When this method returns, contains an address of a pointer to the
    ///                       newly created glyph run analysis object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateGlyphRunAnalysis(const(DWRITE_GLYPH_RUN)* glyphRun, float pixelsPerDip, 
                                   const(DWRITE_MATRIX)* transform, DWRITE_RENDERING_MODE renderingMode, 
                                   DWRITE_MEASURING_MODE measuringMode, float baselineOriginX, float baselineOriginY, 
                                   IDWriteGlyphRunAnalysis* glyphRunAnalysis);
}

///The root factory interface for all DirectWrite objects.
@GUID("30572F99-DAC6-41DB-A16E-0486307E606A")
interface IDWriteFactory1 : IDWriteFactory
{
    ///Gets a font collection representing the set of EUDC (end-user defined characters) fonts.
    ///Params:
    ///    fontCollection = Type: <b>IDWriteFontCollection**</b> The font collection to fill.
    ///    checkForUpdates = Type: <b>BOOL</b> Whether to check for updates.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetEudcFontCollection(IDWriteFontCollection* fontCollection, BOOL checkForUpdates);
    ///Creates a rendering parameters object with the specified properties.
    ///Params:
    ///    gamma = Type: <b>FLOAT</b> The gamma level to be set for the new rendering parameters object.
    ///    enhancedContrast = Type: <b>FLOAT</b> The enhanced contrast level to be set for the new rendering parameters object.
    ///    enhancedContrastGrayscale = Type: <b>FLOAT</b> The amount of contrast enhancement to use for grayscale antialiasing, zero or greater.
    ///    clearTypeLevel = Type: <b>FLOAT</b> The ClearType level to be set for the new rendering parameters object.
    ///    pixelGeometry = Type: <b>DWRITE_PIXEL_GEOMETRY</b> Represents the internal structure of a device pixel (that is, the physical
    ///                    arrangement of red, green, and blue color components) that is assumed for purposes of rendering text.
    ///    renderingMode = Type: <b>DWRITE_RENDERING_MODE</b> A value that represents the method (for example, ClearType natural
    ///                    quality) for rendering glyphs.
    ///    renderingParams = Type: <b>IDWriteRenderingParams1**</b> When this method returns, contains an address of a pointer to the
    ///                      newly created rendering parameters object.
    ///Returns:
    ///    Type: <b>HRESULT</b> Standard HRESULT error code.
    ///    
    HRESULT CreateCustomRenderingParams(float gamma, float enhancedContrast, float enhancedContrastGrayscale, 
                                        float clearTypeLevel, DWRITE_PIXEL_GEOMETRY pixelGeometry, 
                                        DWRITE_RENDERING_MODE renderingMode, 
                                        IDWriteRenderingParams1* renderingParams);
}

///Represents an absolute reference to a font face. This interface contains font face type, appropriate file references,
///and face identification data. This interface extends [IDWriteFontFace](../dwrite/nn-dwrite-idwritefontface.md).
///Various font data such as metrics, names, and glyph outlines are obtained from **IDWriteFontFace**.
@GUID("A71EFDB4-9FDB-4838-AD90-CFC3BE8C3DAF")
interface IDWriteFontFace1 : IDWriteFontFace
{
    ///Obtains design units and common metrics for the font face. These metrics are applicable to all the glyphs within
    ///a font face and are used by applications for layout calculations.
    ///Params:
    ///    fontMetrics = Type: <b>DWRITE_FONT_METRICS1*</b> A filled DWRITE_FONT_METRICS1 structure that holds metrics for the current
    ///                  font face element. The metrics returned by this method are in font design units.
    void    GetMetrics(DWRITE_FONT_METRICS1* fontMetrics);
    ///Obtains design units and common metrics for the font face. These metrics are applicable to all the glyphs within
    ///a fontface and are used by applications for layout calculations.
    ///Params:
    ///    emSize = Type: <b>FLOAT</b> The logical size of the font in DIP units.
    ///    pixelsPerDip = Type: <b>FLOAT</b> The number of physical pixels per DIP.
    ///    transform = Type: <b>const DWRITE_MATRIX*</b> An optional transform applied to the glyphs and their positions. This
    ///                transform is applied after the scaling specified by the font size and <i>pixelsPerDip</i>.
    ///    fontMetrics = Type: <b>DWRITE_FONT_METRICS1*</b> A pointer to a DWRITE_FONT_METRICS1 structure to fill in. The metrics
    ///                  returned by this function are in font design units.
    ///Returns:
    ///    Type: <b>HRESULT</b> Standard HRESULT error code.
    ///    
    HRESULT GetGdiCompatibleMetrics(float emSize, float pixelsPerDip, const(DWRITE_MATRIX)* transform, 
                                    DWRITE_FONT_METRICS1* fontMetrics);
    ///Gets caret metrics for the font in design units.
    ///Params:
    ///    caretMetrics = Type: <b>DWRITE_CARET_METRICS*</b> A pointer to the DWRITE_CARET_METRICS structure that is filled.
    void    GetCaretMetrics(DWRITE_CARET_METRICS* caretMetrics);
    ///Retrieves a list of character ranges supported by a font.
    ///Params:
    ///    maxRangeCount = Type: <b>UINT32</b> Maximum number of character ranges passed in from the client.
    ///    unicodeRanges = Type: <b>DWRITE_UNICODE_RANGE*</b> An array of DWRITE_UNICODE_RANGE structures that are filled with the
    ///                    character ranges.
    ///    actualRangeCount = Type: <b>UINT32*</b> A pointer to the actual number of character ranges, regardless of the maximum count.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method can return one of these values. <table> <tr> <th>Return value</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt>S_OK</dt> </dl> </td> <td width="60%"> The method
    ///    executed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt>E_NOT_SUFFICIENT_BUFFER</dt> </dl> </td>
    ///    <td width="60%"> The buffer is too small. The <i>actualRangeCount</i> was more than the <i>maxRangeCount</i>.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetUnicodeRanges(uint maxRangeCount, DWRITE_UNICODE_RANGE* unicodeRanges, uint* actualRangeCount);
    ///Determines whether the font of a text range is monospaced, that is, the font characters are the same fixed-pitch
    ///width.
    ///Returns:
    ///    Type: <b>BOOL</b> Returns TRUE if the font is monospaced, otherwise it returns FALSE.
    ///    
    BOOL    IsMonospacedFont();
    ///Retrieves the advances in design units for a sequences of glyphs.
    ///Params:
    ///    glyphCount = Type: <b>UINT32</b> The number of glyphs to retrieve advances for.
    ///    glyphIndices = Type: <b>const UINT16*</b> An array of glyph id's to retrieve advances for.
    ///    glyphAdvances = Type: <b>INT32*</b> The returned advances in font design units for each glyph.
    ///    isSideways = Type: <b>BOOL</b> Retrieve the glyph's vertical advance height rather than horizontal advance widths.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetDesignGlyphAdvances(uint glyphCount, const(ushort)* glyphIndices, int* glyphAdvances, 
                                   BOOL isSideways);
    ///Returns the pixel-aligned advances for a sequences of glyphs.
    ///Params:
    ///    emSize = Type: <b>FLOAT</b> Logical size of the font in DIP units. A DIP ("device-independent pixel") equals 1/96
    ///             inch.
    ///    pixelsPerDip = Type: <b>FLOAT</b> Number of physical pixels per DIP. For example, if the DPI of the rendering surface is 96
    ///                   this value is 1.0f. If the DPI is 120, this value is 120.0f/96.
    ///    transform = Type: <b>const DWRITE_MATRIX*</b> Optional transform applied to the glyphs and their positions. This
    ///                transform is applied after the scaling specified by the font size and pixelsPerDip.
    ///    useGdiNatural = Type: <b>BOOL</b> When FALSE, the metrics are the same as GDI aliased text
    ///                    (DWRITE_MEASURING_MODE_GDI_CLASSIC). When TRUE, the metrics are the same as those measured by GDI using a
    ///                    font using CLEARTYPE_NATURAL_QUALITY (DWRITE_MEASURING_MODE_GDI_NATURAL).
    ///    isSideways = Type: <b>BOOL</b> Retrieve the glyph's vertical advances rather than horizontal advances.
    ///    glyphCount = Type: <b>UINT32</b> Total glyphs to retrieve adjustments for.
    ///    glyphIndices = Type: <b>const UINT16*</b> An array of glyph id's to retrieve advances.
    ///    glyphAdvances = Type: <b>const INT32*</b> The returned advances in font design units for each glyph.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetGdiCompatibleGlyphAdvances(float emSize, float pixelsPerDip, const(DWRITE_MATRIX)* transform, 
                                          BOOL useGdiNatural, BOOL isSideways, uint glyphCount, 
                                          const(ushort)* glyphIndices, int* glyphAdvances);
    ///Retrieves the kerning pair adjustments from the font's kern table.
    ///Params:
    ///    glyphCount = Type: <b>UINT32</b> Number of glyphs to retrieve adjustments for.
    ///    glyphIndices = Type: <b>const UINT16*</b> An array of glyph id's to retrieve adjustments for.
    ///    glyphAdvanceAdjustments = Type: <b>INT32*</b> The advances, returned in font design units, for each glyph. The last glyph adjustment is
    ///                              zero.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetKerningPairAdjustments(uint glyphCount, const(ushort)* glyphIndices, int* glyphAdvanceAdjustments);
    ///Determines whether the font supports pair-kerning.
    ///Returns:
    ///    Returns TRUE if the font supports kerning pairs, otherwise FALSE.
    ///    
    BOOL    HasKerningPairs();
    ///Determines the recommended rendering mode for the font, using the specified size and rendering parameters.
    ///Params:
    ///    fontEmSize = Type: <b>FLOAT</b> The logical size of the font in DIP units. A DIP ("device-independent pixel") equals 1/96
    ///                 inch.
    ///    dpiX = Type: <b>FLOAT</b> The number of physical pixels per DIP in a horizontal position. For example, if the DPI of
    ///           the rendering surface is 96, this value is 1.0f. If the DPI is 120, this value is 120.0f/96.
    ///    dpiY = Type: <b>FLOAT</b> The number of physical pixels per DIP in a vertical position. For example, if the DPI of
    ///           the rendering surface is 96, this value is 1.0f. If the DPI is 120, this value is 120.0f/96.
    ///    transform = Type: <b>const DWRITE_MATRIX*</b> Specifies the world transform.
    ///    isSideways = Type: <b>BOOL</b> Whether the glyphs in the run are sideways or not.
    ///    outlineThreshold = Type: <b>DWRITE_OUTLINE_THRESHOLD</b> A DWRITE_OUTLINE_THRESHOLD-typed value that specifies the quality of
    ///                       the graphics system's outline rendering, affects the size threshold above which outline rendering is used.
    ///    measuringMode = Type: <b>DWRITE_MEASURING_MODE</b> The measuring method that will be used for glyphs in the font. Renderer
    ///                    implementations may choose different rendering modes for different measuring methods, for example: <ul>
    ///                    <li>DWRITE_RENDERING_MODE_CLEARTYPE_NATURAL for DWRITE_MEASURING_MODE_NATURAL </li>
    ///                    <li>DWRITE_RENDERING_MODE_CLEARTYPE_GDI_CLASSIC for DWRITE_MEASURING_MODE_GDI_CLASSIC </li>
    ///                    <li>DWRITE_RENDERING_MODE_CLEARTYPE_GDI_NATURAL for DWRITE_MEASURING_MODE_GDI_NATURAL </li> </ul>
    ///    renderingMode = Type: <b>DWRITE_RENDERING_MODE*</b> When this method returns, contains a value that indicates the recommended
    ///                    rendering mode to use.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetRecommendedRenderingMode(float fontEmSize, float dpiX, float dpiY, const(DWRITE_MATRIX)* transform, 
                                        BOOL isSideways, DWRITE_OUTLINE_THRESHOLD outlineThreshold, 
                                        DWRITE_MEASURING_MODE measuringMode, DWRITE_RENDERING_MODE* renderingMode);
    ///Retrieves the vertical forms of the nominal glyphs retrieved from GetGlyphIndices.
    ///Params:
    ///    glyphCount = Type: <b>UINT32</b> The number of glyphs to retrieve.
    ///    nominalGlyphIndices = Type: <b>const UINT16*</b> Original glyph indices from cmap.
    ///    verticalGlyphIndices = Type: <b>UINT16*</b> The vertical form of glyph indices.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetVerticalGlyphVariants(uint glyphCount, const(ushort)* nominalGlyphIndices, 
                                     ushort* verticalGlyphIndices);
    ///Determines whether the font has any vertical glyph variants.
    ///Returns:
    ///    Returns TRUE if the font contains vertical glyph variants, otherwise FALSE.
    ///    
    BOOL    HasVerticalGlyphVariants();
}

///Represents a physical font in a font collection.
@GUID("ACD16696-8C14-4F5D-877E-FE3FC1D32738")
interface IDWriteFont1 : IDWriteFont
{
    ///Obtains design units and common metrics for the font face. These metrics are applicable to all the glyphs within
    ///a font face and are used by applications for layout calculations.
    ///Params:
    ///    fontMetrics = Type: <b>DWRITE_FONT_METRICS1*</b> A filled DWRITE_FONT_METRICS1 structure that has font metrics for the
    ///                  current font face. The metrics returned by this method are in font design units.
    void    GetMetrics(DWRITE_FONT_METRICS1* fontMetrics);
    ///Gets the PANOSE values from the font and is used for font selection and matching.
    ///Params:
    ///    panose = Type: <b>DWRITE_PANOSE*</b> A pointer to the DWRITE_PANOSE structure to fill in.
    void    GetPanose(DWRITE_PANOSE* panose);
    ///Retrieves the list of character ranges supported by a font.
    ///Params:
    ///    maxRangeCount = Type: <b>UINT32</b> The maximum number of character ranges passed in from the client.
    ///    unicodeRanges = Type: <b>DWRITE_UNICODE_RANGE*</b> An array of DWRITE_UNICODE_RANGE structures that are filled with the
    ///                    character ranges.
    ///    actualRangeCount = Type: <b>UINT32*</b> A pointer to the actual number of character ranges, regardless of the maximum count.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method can return one of these values. <table> <tr> <th>Return value</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt>S_OK</dt> </dl> </td> <td width="60%"> The method
    ///    executed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt>E_NOT_SUFFICIENT_BUFFER</dt> </dl> </td>
    ///    <td width="60%"> The buffer is too small. The <i>actualRangeCount</i> was more than the <i>maxRangeCount</i>.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetUnicodeRanges(uint maxRangeCount, DWRITE_UNICODE_RANGE* unicodeRanges, uint* actualRangeCount);
    ///Determines if the font is monospaced, that is, the characters are the same fixed-pitch width (non-proportional).
    ///Returns:
    ///    Type: <b>BOOL</b> Returns true if the font is monospaced, else it returns false.
    ///    
    BOOL    IsMonospacedFont();
}

///Represents text rendering settings for glyph rasterization and filtering.
@GUID("94413CF4-A6FC-4248-8B50-6674348FCAD3")
interface IDWriteRenderingParams1 : IDWriteRenderingParams
{
    ///Gets the amount of contrast enhancement to use for grayscale antialiasing.
    ///Returns:
    ///    Type: <b>FLOAT</b> The contrast enhancement value. Valid values are greater than or equal to zero.
    ///    
    float GetGrayscaleEnhancedContrast();
}

///Analyzes various text properties for complex script processing.
@GUID("80DAD800-E21F-4E83-96CE-BFCCE500DB7C")
interface IDWriteTextAnalyzer1 : IDWriteTextAnalyzer
{
    ///Applies spacing between characters, properly adjusting glyph clusters and diacritics.
    ///Params:
    ///    leadingSpacing = The spacing before each character, in reading order.
    ///    trailingSpacing = The spacing after each character, in reading order.
    ///    minimumAdvanceWidth = The minimum advance of each character, to prevent characters from becoming too thin or zero-width. This must
    ///                          be zero or greater.
    ///    textLength = The length of the clustermap and original text.
    ///    glyphCount = The number of glyphs.
    ///    clusterMap = Mapping from character ranges to glyph ranges.
    ///    glyphAdvances = The advance width of each glyph.
    ///    glyphOffsets = The offset of the origin of each glyph.
    ///    glyphProperties = Properties of each glyph, from GetGlyphs.
    ///    modifiedGlyphAdvances = The new advance width of each glyph.
    ///    modifiedGlyphOffsets = The new offset of the origin of each glyph.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ApplyCharacterSpacing(float leadingSpacing, float trailingSpacing, float minimumAdvanceWidth, 
                                  uint textLength, uint glyphCount, const(ushort)* clusterMap, 
                                  const(float)* glyphAdvances, const(DWRITE_GLYPH_OFFSET)* glyphOffsets, 
                                  const(DWRITE_SHAPING_GLYPH_PROPERTIES)* glyphProperties, 
                                  float* modifiedGlyphAdvances, DWRITE_GLYPH_OFFSET* modifiedGlyphOffsets);
    ///Retrieves the given baseline from the font.
    ///Params:
    ///    fontFace = Type: <b>IDWriteFontFace*</b> The font face to read.
    ///    baseline = Type: <b>DWRITE_BASELINE</b> A DWRITE_BASELINE-typed value that specifies the baseline of interest.
    ///    isVertical = Type: <b>BOOL</b> Whether the baseline is vertical or horizontal.
    ///    isSimulationAllowed = Type: <b>BOOL</b> Simulate the baseline if it is missing in the font.
    ///    scriptAnalysis = Type: <b>DWRITE_SCRIPT_ANALYSIS</b> Script analysis result from AnalyzeScript. <div class="alert"><b>Note</b>
    ///                     You can pass an empty script analysis structure, like this <code>DWRITE_SCRIPT_ANALYSIS scriptAnalysis =
    ///                     {};</code>, and this method will return the default baseline.</div> <div> </div>
    ///    localeName = Type: <b>const WCHAR*</b> The language of the run.
    ///    baselineCoordinate = Type: <b>INT32*</b> The baseline coordinate value in design units.
    ///    exists = Type: <b>BOOL*</b> Whether the returned baseline exists in the font.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetBaseline(IDWriteFontFace fontFace, DWRITE_BASELINE baseline, BOOL isVertical, 
                        BOOL isSimulationAllowed, DWRITE_SCRIPT_ANALYSIS scriptAnalysis, const(PWSTR) localeName, 
                        int* baselineCoordinate, BOOL* exists);
    ///Analyzes a text range for script orientation, reading text and attributes from the source and reporting results
    ///to the sink callback SetGlyphOrientation.
    ///Params:
    ///    analysisSource = Type: <b>IDWriteTextAnalysisSource1*</b> Source object to analyze.
    ///    textPosition = Type: <b>UINT32</b> Starting position within the source object.
    ///    textLength = Type: <b>UINT32</b> Length to analyze.
    ///    analysisSink = Type: <b>IDWriteTextAnalysisSink1*</b> Length to analyze.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AnalyzeVerticalGlyphOrientation(IDWriteTextAnalysisSource1 analysisSource, uint textPosition, 
                                            uint textLength, IDWriteTextAnalysisSink1 analysisSink);
    ///Returns 2x3 transform matrix for the respective angle to draw the glyph run.
    ///Params:
    ///    glyphOrientationAngle = Type: <b>DWRITE_GLYPH_ORIENTATION_ANGLE</b> A DWRITE_GLYPH_ORIENTATION_ANGLE-typed value that specifies the
    ///                            angle that was reported into IDWriteTextAnalysisSink1::SetGlyphOrientation.
    ///    isSideways = Type: <b>BOOL</b> Whether the run's glyphs are sideways or not.
    ///    transform = Type: <b>DWRITE_MATRIX*</b> Returned transform.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetGlyphOrientationTransform(DWRITE_GLYPH_ORIENTATION_ANGLE glyphOrientationAngle, BOOL isSideways, 
                                         DWRITE_MATRIX* transform);
    ///Retrieves the properties for a given script.
    ///Params:
    ///    scriptAnalysis = Type: <b>DWRITE_SCRIPT_ANALYSIS</b> The script for a run of text returned from
    ///                     IDWriteTextAnalyzer::AnalyzeScript.
    ///    scriptProperties = Type: <b>DWRITE_SCRIPT_PROPERTIES*</b> A pointer to a DWRITE_SCRIPT_PROPERTIES structure that describes info
    ///                       for the script.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns properties for the given script. If the script is invalid, it returns generic
    ///    properties for the unknown script and E_INVALIDARG.
    ///    
    HRESULT GetScriptProperties(DWRITE_SCRIPT_ANALYSIS scriptAnalysis, DWRITE_SCRIPT_PROPERTIES* scriptProperties);
    ///Determines the complexity of text, and whether you need to call IDWriteTextAnalyzer::GetGlyphs for full script
    ///shaping.
    ///Params:
    ///    textString = Type: <b>const WCHAR*</b> The text to check for complexity. This string may be UTF-16, but any supplementary
    ///                 characters will be considered complex.
    ///    textLength = Type: <b>UINT32</b> Length of the text to check.
    ///    fontFace = Type: <b>IDWriteFontFace*</b> The font face to read.
    ///    isTextSimple = Type: <b>BOOL*</b> If true, the text is simple, and the <i>glyphIndices</i> array will already have the
    ///                   nominal glyphs for you. Otherwise, you need to call IDWriteTextAnalyzer::GetGlyphs to properly shape complex
    ///                   scripts and OpenType features.
    ///    textLengthRead = Type: <b>UINT32*</b> The length read of the text run with the same complexity, simple or complex. You may
    ///                     call again from that point onward.
    ///    glyphIndices = Type: <b>UINT16*</b> Optional glyph indices for the text. If the function returned that the text was simple,
    ///                   you already have the glyphs you need. Otherwise the glyph indices are not meaningful, and you need to call
    ///                   IDWriteTextAnalyzer::GetGlyphs for shaping instead.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetTextComplexity(const(PWSTR) textString, uint textLength, IDWriteFontFace fontFace, 
                              BOOL* isTextSimple, uint* textLengthRead, ushort* glyphIndices);
    ///Retrieves justification opportunity information for each of the glyphs given the text and shaping glyph
    ///properties.
    ///Params:
    ///    fontFace = Type: <b>IDWriteFontFace*</b> Font face that was used for shaping. This is mainly important for returning
    ///               correct results of the kashida width. May be NULL.
    ///    fontEmSize = Type: <b>FLOAT</b> Font em size used for the glyph run.
    ///    scriptAnalysis = Type: <b>DWRITE_SCRIPT_ANALYSIS</b> Script of the text from the itemizer.
    ///    textLength = Type: <b>UINT32</b> Length of the text.
    ///    glyphCount = Type: <b>UINT32</b> Number of glyphs.
    ///    textString = Type: <b>const WCHAR*</b> Characters used to produce the glyphs.
    ///    clusterMap = Type: <b>const UINT16*</b> Clustermap produced from shaping.
    ///    glyphProperties = Type: <b>const DWRITE_SHAPING_GLYPH_PROPERTIES*</b> Glyph properties produced from shaping.
    ///    justificationOpportunities = Type: <b>DWRITE_JUSTIFICATION_OPPORTUNITY*</b> A pointer to a DWRITE_JUSTIFICATION_OPPORTUNITY structure that
    ///                                 receives info for the allowed justification expansion/compression for each glyph.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetJustificationOpportunities(IDWriteFontFace fontFace, float fontEmSize, 
                                          DWRITE_SCRIPT_ANALYSIS scriptAnalysis, uint textLength, uint glyphCount, 
                                          const(PWSTR) textString, const(ushort)* clusterMap, 
                                          const(DWRITE_SHAPING_GLYPH_PROPERTIES)* glyphProperties, 
                                          DWRITE_JUSTIFICATION_OPPORTUNITY* justificationOpportunities);
    ///Justifies an array of glyph advances to fit the line width.
    ///Params:
    ///    lineWidth = Type: <b>FLOAT</b> The line width.
    ///    glyphCount = Type: <b>UINT32</b> The glyph count.
    ///    justificationOpportunities = Type: <b>const DWRITE_JUSTIFICATION_OPPORTUNITY*</b> A pointer to a DWRITE_JUSTIFICATION_OPPORTUNITY
    ///                                 structure that contains info for the allowed justification expansion/compression for each glyph. Get this
    ///                                 info from IDWriteTextAnalyzer1::GetJustificationOpportunities.
    ///    glyphAdvances = Type: <b>const FLOAT*</b> An array of glyph advances.
    ///    glyphOffsets = Type: <b>const DWRITE_GLYPH_OFFSET*</b> An array of glyph offsets.
    ///    justifiedGlyphAdvances = Type: <b>FLOAT*</b> The returned array of justified glyph advances.
    ///    justifiedGlyphOffsets = Type: <b>DWRITE_GLYPH_OFFSET*</b> The returned array of justified glyph offsets.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT JustifyGlyphAdvances(float lineWidth, uint glyphCount, 
                                 const(DWRITE_JUSTIFICATION_OPPORTUNITY)* justificationOpportunities, 
                                 const(float)* glyphAdvances, const(DWRITE_GLYPH_OFFSET)* glyphOffsets, 
                                 float* justifiedGlyphAdvances, DWRITE_GLYPH_OFFSET* justifiedGlyphOffsets);
    ///Fills in new glyphs for complex scripts where justification increased the advances of glyphs, such as Arabic with
    ///kashida.
    ///Params:
    ///    fontFace = Type: <b>IDWriteFontFace*</b> Font face used for shaping. May be NULL.
    ///    fontEmSize = Type: <b>FLOAT</b> Font em size used for the glyph run.
    ///    scriptAnalysis = Type: <b>DWRITE_SCRIPT_ANALYSIS</b> Script of the text from the itemizer.
    ///    textLength = Type: <b>UINT32</b> Length of the text.
    ///    glyphCount = Type: <b>UINT32</b> Number of glyphs.
    ///    maxGlyphCount = Type: <b>UINT32</b> Maximum number of output glyphs allocated by caller.
    ///    clusterMap = Type: <b>const UINT16*</b> Clustermap produced from shaping.
    ///    glyphIndices = Type: <b>const UINT16*</b> Original glyphs produced from shaping.
    ///    glyphAdvances = Type: <b>const FLOAT*</b> Original glyph advances produced from shaping.
    ///    justifiedGlyphAdvances = Type: <b>const FLOAT*</b> Justified glyph advances from IDWriteTextAnalyzer1::JustifyGlyphAdvances.
    ///    justifiedGlyphOffsets = Type: <b>const DWRITE_GLYPH_OFFSET*</b> Justified glyph offsets from
    ///                            IDWriteTextAnalyzer1::JustifyGlyphAdvances.
    ///    glyphProperties = Type: <b>const DWRITE_SHAPING_GLYPH_PROPERTIES*</b> Properties of each glyph, from
    ///                      IDWriteTextAnalyzer::GetGlyphs.
    ///    actualGlyphCount = Type: <b>UINT32*</b> The new glyph count written to the modified arrays, or the needed glyph count if the
    ///                       size is not large enough.
    ///    modifiedClusterMap = Type: <b>UINT16*</b> Updated clustermap.
    ///    modifiedGlyphIndices = Type: <b>UINT16*</b> Updated glyphs with new glyphs inserted where needed.
    ///    modifiedGlyphAdvances = Type: <b>FLOAT*</b> Updated glyph advances.
    ///    modifiedGlyphOffsets = Type: <b>DWRITE_GLYPH_OFFSET*</b> Updated glyph offsets.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetJustifiedGlyphs(IDWriteFontFace fontFace, float fontEmSize, DWRITE_SCRIPT_ANALYSIS scriptAnalysis, 
                               uint textLength, uint glyphCount, uint maxGlyphCount, const(ushort)* clusterMap, 
                               const(ushort)* glyphIndices, const(float)* glyphAdvances, 
                               const(float)* justifiedGlyphAdvances, 
                               const(DWRITE_GLYPH_OFFSET)* justifiedGlyphOffsets, 
                               const(DWRITE_SHAPING_GLYPH_PROPERTIES)* glyphProperties, uint* actualGlyphCount, 
                               ushort* modifiedClusterMap, ushort* modifiedGlyphIndices, 
                               float* modifiedGlyphAdvances, DWRITE_GLYPH_OFFSET* modifiedGlyphOffsets);
}

///The interface you implement to provide needed information to the text analyzer, like the text and associated text
///properties. <div class="alert"><b>Note</b> If any of these callbacks return an error, the analysis functions will
///stop prematurely and return a callback error. </div> <div> </div>
@GUID("639CFAD8-0FB4-4B21-A58A-067920120009")
interface IDWriteTextAnalysisSource1 : IDWriteTextAnalysisSource
{
    ///Used by the text analyzer to obtain the desired glyph orientation and resolved bidi level.
    ///Params:
    ///    textPosition = Type: <b>UINT32</b> The text position.
    ///    textLength = Type: <b>UINT32*</b> A pointer to the text length.
    ///    glyphOrientation = Type: <b>DWRITE_VERTICAL_GLYPH_ORIENTATION*</b> A DWRITE_VERTICAL_GLYPH_ORIENTATION-typed value that
    ///                       specifies the desired kind of glyph orientation for the text.
    ///    bidiLevel = Type: <b>UINT8*</b> A pointer to the resolved bidi level.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returning an error will abort the analysis.
    ///    
    HRESULT GetVerticalGlyphOrientation(uint textPosition, uint* textLength, 
                                        DWRITE_VERTICAL_GLYPH_ORIENTATION* glyphOrientation, ubyte* bidiLevel);
}

///The interface you implement to receive the output of the text analyzers.
@GUID("B0D941A0-85E7-4D8B-9FD3-5CED9934482A")
interface IDWriteTextAnalysisSink1 : IDWriteTextAnalysisSink
{
    ///The text analyzer calls back to this to report the actual orientation of each character for shaping and drawing.
    ///Params:
    ///    textPosition = Type: <b>UINT32 </b> The starting position to report from.
    ///    textLength = Type: <b>UINT32 </b> Number of UTF-16 units of the reported range.
    ///    glyphOrientationAngle = Type: <b>DWRITE_GLYPH_ORIENTATION_ANGLE</b> A DWRITE_GLYPH_ORIENTATION_ANGLE-typed value that specifies the
    ///                            angle of the glyphs within the text range (pass to IDWriteTextAnalyzer1::GetGlyphOrientationTransform to get
    ///                            the world relative transform).
    ///    adjustedBidiLevel = Type: <b>UINT8</b> The adjusted bidi level to be used by the client layout for reordering runs. This will
    ///                        differ from the resolved bidi level retrieved from the source for cases such as Arabic stacked top-to-bottom,
    ///                        where the glyphs are still shaped as RTL, but the runs are TTB along with any CJK or Latin.
    ///    isSideways = Type: <b>BOOL</b> Whether the glyphs are rotated on their side, which is the default case for CJK and the
    ///                 case stacked Latin
    ///    isRightToLeft = Type: <b>BOOL</b> Whether the script should be shaped as right-to-left. For Arabic stacked top-to-bottom,
    ///                    even when the adjusted bidi level is coerced to an even level, this will still be true.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns a successful code or an error code to abort analysis.
    ///    
    HRESULT SetGlyphOrientation(uint textPosition, uint textLength, 
                                DWRITE_GLYPH_ORIENTATION_ANGLE glyphOrientationAngle, ubyte adjustedBidiLevel, 
                                BOOL isSideways, BOOL isRightToLeft);
}

///Represents a block of text after it has been fully analyzed and formatted.
@GUID("9064D822-80A7-465C-A986-DF65F78B8FEB")
interface IDWriteTextLayout1 : IDWriteTextLayout
{
    ///Enables or disables pair-kerning on a given text range.
    ///Params:
    ///    isPairKerningEnabled = Type: <b>BOOL</b> The flag that indicates whether text is pair-kerned.
    ///    textRange = Type: <b>DWRITE_TEXT_RANGE</b> The text range to which the change applies.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetPairKerning(BOOL isPairKerningEnabled, DWRITE_TEXT_RANGE textRange);
    ///Gets whether or not pair-kerning is enabled at given position.
    ///Params:
    ///    currentPosition = Type: <b>UINT32</b> The current text position.
    ///    isPairKerningEnabled = Type: <b>BOOL*</b> The flag that indicates whether text is pair-kerned.
    ///    textRange = Type: <b>DWRITE_TEXT_RANGE*</b> The position range of the current format.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetPairKerning(uint currentPosition, BOOL* isPairKerningEnabled, DWRITE_TEXT_RANGE* textRange);
    ///Sets the spacing between characters.
    ///Params:
    ///    leadingSpacing = Type: <b>FLOAT</b> The spacing before each character, in reading order.
    ///    trailingSpacing = Type: <b>FLOAT</b> The spacing after each character, in reading order.
    ///    minimumAdvanceWidth = Type: <b>FLOAT</b> The minimum advance of each character, to prevent characters from becoming too thin or
    ///                          zero-width. This must be zero or greater.
    ///    textRange = Type: <b>DWRITE_TEXT_RANGE</b> Text range to which this change applies.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetCharacterSpacing(float leadingSpacing, float trailingSpacing, float minimumAdvanceWidth, 
                                DWRITE_TEXT_RANGE textRange);
    ///Gets the spacing between characters.
    ///Params:
    ///    currentPosition = Type: <b>UINT32</b> The current text position.
    ///    leadingSpacing = Type: <b>FLOAT*</b> The spacing before each character, in reading order.
    ///    trailingSpacing = Type: <b>FLOAT*</b> The spacing after each character, in reading order.
    ///    minimumAdvanceWidth = Type: <b>FLOAT*</b> The minimum advance of each character, to prevent characters from becoming too thin or
    ///                          zero-width. This must be zero or greater.
    ///    textRange = Type: <b>DWRITE_TEXT_RANGE*</b> The position range of the current format.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetCharacterSpacing(uint currentPosition, float* leadingSpacing, float* trailingSpacing, 
                                float* minimumAdvanceWidth, DWRITE_TEXT_RANGE* textRange);
}

///Encapsulates a 32-bit device independent bitmap and device context, which you can use for rendering glyphs.
@GUID("791E8298-3EF3-4230-9880-C9BDECC42064")
interface IDWriteBitmapRenderTarget1 : IDWriteBitmapRenderTarget
{
    ///Gets the current text antialiasing mode of the bitmap render target.
    ///Returns:
    ///    Type: <b>DWRITE_TEXT_ANTIALIAS_MODE</b> Returns a DWRITE_TEXT_ANTIALIAS_MODE-typed value that specifies the
    ///    antialiasing mode.
    ///    
    DWRITE_TEXT_ANTIALIAS_MODE GetTextAntialiasMode();
    ///Sets the current text antialiasing mode of the bitmap render target.
    ///Params:
    ///    antialiasMode = Type: <b>DWRITE_TEXT_ANTIALIAS_MODE</b> A DWRITE_TEXT_ANTIALIAS_MODE-typed value that specifies the
    ///                    antialiasing mode.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if successful, or E_INVALIDARG if the argument is not valid.
    ///    
    HRESULT SetTextAntialiasMode(DWRITE_TEXT_ANTIALIAS_MODE antialiasMode);
}

///Represents a set of application-defined callbacks that perform rendering of text, inline objects, and decorations
///such as underlines.
@GUID("D3E0E934-22A0-427E-AAE4-7D9574B59DB1")
interface IDWriteTextRenderer1 : IDWriteTextRenderer
{
    ///IDWriteTextLayout::Draw calls this function to instruct the client to render a run of glyphs.
    ///Params:
    ///    clientDrawingContext = Type: <b>void*</b> The application-defined drawing context passed to IDWriteTextLayout::Draw.
    ///    baselineOriginX = Type: <b>FLOAT</b> The pixel location (X-coordinate) at the baseline origin of the glyph run.
    ///    baselineOriginY = Type: <b>FLOAT</b> The pixel location (Y-coordinate) at the baseline origin of the glyph run.
    ///    orientationAngle = Type: <b>DWRITE_GLYPH_ORIENTATION_ANGLE</b> Orientation of the glyph run.
    ///    measuringMode = Type: <b>DWRITE_MEASURING_MODE</b> The measuring method for glyphs in the run, used with the other properties
    ///                    to determine the rendering mode.
    ///    glyphRun = Type: <b>const DWRITE_GLYPH_RUN*</b> Pointer to the glyph run instance to render.
    ///    glyphRunDescription = Type: <b>const DWRITE_GLYPH_RUN_DESCRIPTION*</b> A pointer to the glyph run description instance which
    ///                          contains properties of the characters associated with this run.
    ///    clientDrawingEffect = Type: <b>IUnknown*</b> Application-defined drawing effects for the glyphs to render. Usually this argument
    ///                          represents effects such as the foreground brush filling the interior of text.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT DrawGlyphRun(void* clientDrawingContext, float baselineOriginX, float baselineOriginY, 
                         DWRITE_GLYPH_ORIENTATION_ANGLE orientationAngle, DWRITE_MEASURING_MODE measuringMode, 
                         const(DWRITE_GLYPH_RUN)* glyphRun, const(DWRITE_GLYPH_RUN_DESCRIPTION)* glyphRunDescription, 
                         IUnknown clientDrawingEffect);
    ///IDWriteTextLayout::Draw calls this function to instruct the client to draw an underline.
    ///Params:
    ///    clientDrawingContext = Type: <b>void*</b> The application-defined drawing context passed to IDWriteTextLayout::Draw.
    ///    baselineOriginX = Type: <b>FLOAT</b> The pixel location (X-coordinate) at the baseline origin of the run where underline
    ///                      applies.
    ///    baselineOriginY = Type: <b>FLOAT</b> The pixel location (Y-coordinate) at the baseline origin of the run where underline
    ///                      applies.
    ///    orientationAngle = Type: <b>DWRITE_GLYPH_ORIENTATION_ANGLE</b> Orientation of the underline.
    ///    underline = Type: <b>const DWRITE_UNDERLINE*</b> Pointer to a structure containing underline logical information.
    ///    clientDrawingEffect = Type: <b>IUnknown*</b> Application-defined effect to apply to the underline. Usually this argument represents
    ///                          effects such as the foreground brush filling the interior of a line.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT DrawUnderline(void* clientDrawingContext, float baselineOriginX, float baselineOriginY, 
                          DWRITE_GLYPH_ORIENTATION_ANGLE orientationAngle, const(DWRITE_UNDERLINE)* underline, 
                          IUnknown clientDrawingEffect);
    ///IDWriteTextLayout::Draw calls this function to instruct the client to draw a strikethrough.
    ///Params:
    ///    clientDrawingContext = Type: <b>void*</b> The application-defined drawing context passed to IDWriteTextLayout::Draw.
    ///    baselineOriginX = Type: <b>FLOAT</b> The pixel location (X-coordinate) at the baseline origin of the run where strikethrough
    ///                      applies.
    ///    baselineOriginY = Type: <b>FLOAT</b> The pixel location (Y-coordinate) at the baseline origin of the run where strikethrough
    ///                      applies.
    ///    orientationAngle = Type: <b>DWRITE_GLYPH_ORIENTATION_ANGLE</b> Orientation of the strikethrough.
    ///    strikethrough = Type: <b>const DWRITE_STRIKETHROUGH*</b> Pointer to a structure containing strikethrough logical information.
    ///    clientDrawingEffect = Type: <b>IUnknown*</b> Application-defined effect to apply to the strikethrough. Usually this argument
    ///                          represents effects such as the foreground brush filling the interior of a line.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT DrawStrikethrough(void* clientDrawingContext, float baselineOriginX, float baselineOriginY, 
                              DWRITE_GLYPH_ORIENTATION_ANGLE orientationAngle, 
                              const(DWRITE_STRIKETHROUGH)* strikethrough, IUnknown clientDrawingEffect);
    ///IDWriteTextLayout::Draw calls this application callback when it needs to draw an inline object.
    ///Params:
    ///    clientDrawingContext = Type: <b>void*</b> The application-defined drawing context passed to IDWriteTextLayout::Draw.
    ///    originX = Type: <b>FLOAT</b> X-coordinate at the top-left corner of the inline object.
    ///    originY = Type: <b>FLOAT</b> Y-coordinate at the top-left corner of the inline object.
    ///    orientationAngle = Type: <b>DWRITE_GLYPH_ORIENTATION_ANGLE</b> Orientation of the inline object.
    ///    inlineObject = Type: <b>IDWriteInlineObject*</b> The application-defined inline object set using
    ///                   IDWriteTextFormat::SetInlineObject.
    ///    isSideways = Type: <b>BOOL</b> A Boolean flag that indicates whether the object's baseline runs alongside the baseline
    ///                 axis of the line.
    ///    isRightToLeft = Type: <b>BOOL</b> A Boolean flag that indicates whether the object is in a right-to-left context, hinting
    ///                    that the drawing may want to mirror the normal image.
    ///    clientDrawingEffect = Type: <b>IUnknown*</b> Application-defined drawing effects for the glyphs to render. Usually this argument
    ///                          represents effects such as the foreground brush filling the interior of a line.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT DrawInlineObject(void* clientDrawingContext, float originX, float originY, 
                             DWRITE_GLYPH_ORIENTATION_ANGLE orientationAngle, IDWriteInlineObject inlineObject, 
                             BOOL isSideways, BOOL isRightToLeft, IUnknown clientDrawingEffect);
}

///Describes the font and paragraph properties used to format text, and it describes locale information. This interface
///has all the same methods as IDWriteTextFormat and adds the ability for you to apply an explicit orientation.
@GUID("5F174B49-0D8B-4CFB-8BCA-F1CCE9D06C67")
interface IDWriteTextFormat1 : IDWriteTextFormat
{
    ///Sets the orientation of a text format.
    ///Params:
    ///    glyphOrientation = Type: <b>DWRITE_VERTICAL_GLYPH_ORIENTATION</b> The orientation to apply to the text format.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetVerticalGlyphOrientation(DWRITE_VERTICAL_GLYPH_ORIENTATION glyphOrientation);
    ///Get the preferred orientation of glyphs when using a vertical reading direction.
    ///Returns:
    ///    Type: <b>DWRITE_VERTICAL_GLYPH_ORIENTATION</b> The preferred orientation of glyphs when using a vertical
    ///    reading direction.
    ///    
    DWRITE_VERTICAL_GLYPH_ORIENTATION GetVerticalGlyphOrientation();
    ///Sets the wrapping mode of the last line.
    ///Params:
    ///    isLastLineWrappingEnabled = Type: <b>BOOL</b> If set to FALSE, the last line is not wrapped. If set to TRUE, the last line is wrapped.
    ///                                The last line is wrapped by default.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetLastLineWrapping(BOOL isLastLineWrappingEnabled);
    ///Gets the wrapping mode of the last line.
    ///Returns:
    ///    Type: <b>BOOL</b> Returns FALSE if the last line is not wrapped; TRUE if the last line is wrapped.
    ///    
    BOOL    GetLastLineWrapping();
    ///Sets the optical margin alignment for the text format. By default, glyphs are aligned to the margin by the
    ///default origin and side-bearings of the glyph. If you specify
    ///<b>DWRITE_OPTICAL_ALIGNMENT_USING_SIDE_BEARINGS</b>, then the alignment Suses the side bearings to offset the
    ///glyph from the aligned edge to ensure the ink of the glyphs are aligned.
    ///Params:
    ///    opticalAlignment = The optical alignment to set.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetOpticalAlignment(DWRITE_OPTICAL_ALIGNMENT opticalAlignment);
    ///Gets the optical margin alignment for the text format.
    ///Returns:
    ///    The optical alignment.
    ///    
    DWRITE_OPTICAL_ALIGNMENT GetOpticalAlignment();
    ///Applies the custom font fallback onto the layout. If none is set, it uses the default system fallback list.
    ///Params:
    ///    fontFallback = Type: <b>IDWriteFontFallback*</b> The font fallback to apply to the layout.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetFontFallback(IDWriteFontFallback fontFallback);
    ///Gets the current fallback. If none was ever set since creating the layout, it will be nullptr.
    ///Params:
    ///    fontFallback = Type: <b>IDWriteFontFallback**</b> Contains an address of a pointer to the the current font fallback object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetFontFallback(IDWriteFontFallback* fontFallback);
}

///Represents a block of text after it has been fully analyzed and formatted.
@GUID("1093C18F-8D5E-43F0-B064-0917311B525E")
interface IDWriteTextLayout2 : IDWriteTextLayout1
{
    ///Retrieves overall metrics for the formatted string.
    ///Params:
    ///    textMetrics = Type: <b>DWRITE_TEXT_METRICS1*</b> When this method returns, contains the measured distances of text and
    ///                  associated content after being formatted.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetMetrics(DWRITE_TEXT_METRICS1* textMetrics);
    ///Set the preferred orientation of glyphs when using a vertical reading direction.
    ///Params:
    ///    glyphOrientation = Preferred glyph orientation.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetVerticalGlyphOrientation(DWRITE_VERTICAL_GLYPH_ORIENTATION glyphOrientation);
    ///Get the preferred orientation of glyphs when using a vertical reading direction.
    DWRITE_VERTICAL_GLYPH_ORIENTATION GetVerticalGlyphOrientation();
    ///Set whether or not the last word on the last line is wrapped.
    ///Params:
    ///    isLastLineWrappingEnabled = Line wrapping option.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetLastLineWrapping(BOOL isLastLineWrappingEnabled);
    ///Get whether or not the last word on the last line is wrapped.
    BOOL    GetLastLineWrapping();
    ///Set how the glyphs align to the edges the margin. Default behavior is to align glyphs using their default glyphs
    ///metrics, which include side bearings.
    ///Params:
    ///    opticalAlignment = Optical alignment option.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetOpticalAlignment(DWRITE_OPTICAL_ALIGNMENT opticalAlignment);
    ///Get how the glyphs align to the edges the margin.
    DWRITE_OPTICAL_ALIGNMENT GetOpticalAlignment();
    ///Apply a custom font fallback onto layout. If none is specified, the layout uses the system fallback list.
    ///Params:
    ///    fontFallback = Custom font fallback created from IDWriteFontFallbackBuilder::CreateFontFallback or
    ///                   IDWriteFactory2::GetSystemFontFallback.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetFontFallback(IDWriteFontFallback fontFallback);
    ///Get the current font fallback object.
    ///Params:
    ///    fontFallback = The current font fallback object.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetFontFallback(IDWriteFontFallback* fontFallback);
}

///Analyzes various text properties for complex script processing.
@GUID("553A9FF3-5693-4DF7-B52B-74806F7F2EB9")
interface IDWriteTextAnalyzer2 : IDWriteTextAnalyzer1
{
    ///Returns 2x3 transform matrix for the respective angle to draw the glyph run. Extends
    ///IDWriteTextAnalyzer1::GetGlyphOrientationTransform to pass valid values for the baseline origin rather than
    ///zeroes.
    ///Params:
    ///    glyphOrientationAngle = Type: <b>DWRITE_GLYPH_ORIENTATION_ANGLE</b> A DWRITE_GLYPH_ORIENTATION_ANGLE-typed value that specifies the
    ///                            angle that was reported into IDWriteTextAnalysisSink1::SetGlyphOrientation.
    ///    isSideways = Type: <b>BOOL</b> Whether the run's glyphs are sideways or not.
    ///    originX = Type: <b>FLOAT</b> The X value of the baseline origin.
    ///    originY = Type: <b>FLOAT</b> The Y value of the baseline origin.
    ///    transform = Type: <b>DWRITE_MATRIX*</b> Returned transform.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetGlyphOrientationTransform(DWRITE_GLYPH_ORIENTATION_ANGLE glyphOrientationAngle, BOOL isSideways, 
                                         float originX, float originY, DWRITE_MATRIX* transform);
    ///Returns a complete list of OpenType features available for a script or font. If a feature is partially supported,
    ///then this method indicates that it is supported.
    ///Params:
    ///    fontFace = Type: <b>IDWriteFontFace*</b> The font face to get features from.
    ///    scriptAnalysis = Type: <b>DWRITE_SCRIPT_ANALYSIS</b> The script analysis for the script or font to check.
    ///    localeName = Type: <b>const WCHAR*</b> The locale name to check.
    ///    maxTagCount = Type: <b>UINT32</b> The maximum number of tags to return.
    ///    actualTagCount = Type: <b>UINT32*</b> The actual number of tags returned.
    ///    tags = Type: <b>DWRITE_FONT_FEATURE_TAG*</b> An array of OpenType font feature tags.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetTypographicFeatures(IDWriteFontFace fontFace, DWRITE_SCRIPT_ANALYSIS scriptAnalysis, 
                                   const(PWSTR) localeName, uint maxTagCount, uint* actualTagCount, 
                                   DWRITE_FONT_FEATURE_TAG* tags);
    ///Checks if a typographic feature is available for a glyph or a set of glyphs.
    ///Params:
    ///    fontFace = The font face to read glyph information from.
    ///    scriptAnalysis = The script analysis for the script or font to check.
    ///    localeName = The locale name to check.
    ///    featureTag = The font feature tag to check.
    ///    glyphCount = The number of glyphs to check.
    ///    glyphIndices = An array of glyph indices to check.
    ///    featureApplies = An array of integers that indicate whether or not the font feature applies to each glyph specified.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CheckTypographicFeature(IDWriteFontFace fontFace, DWRITE_SCRIPT_ANALYSIS scriptAnalysis, 
                                    const(PWSTR) localeName, DWRITE_FONT_FEATURE_TAG featureTag, uint glyphCount, 
                                    const(ushort)* glyphIndices, ubyte* featureApplies);
}

///Allows you to access fallback fonts from the font list. The <b>IDWriteFontFallback</b> interface defines a fallback
///sequence to map character ranges to fonts, which is either created via IDWriteFontFallbackBuilder or retrieved from
///IDWriteFactory2::GetSystemFontFallback.
@GUID("EFA008F9-F7A1-48BF-B05C-F224713CC0FF")
interface IDWriteFontFallback : IUnknown
{
    ///Determines an appropriate font to use to render the beginning range of text.
    ///Params:
    ///    analysisSource = Type: <b>IDWriteTextAnalysisSource*</b> The text source implementation holds the text and locale.
    ///    textPosition = Type: <b>UINT32</b> Starting position to analyze.
    ///    textLength = Type: <b>UINT32</b> Length of the text to analyze.
    ///    baseFontCollection = Type: <b>IDWriteFontCollection*</b> Default font collection to use.
    ///    baseFamilyName = Type: <b>const wchar_t*</b> Family name of the base font. If you pass null, no matching will be done against
    ///                     the family.
    ///    baseWeight = Type: <b>DWRITE_FONT_WEIGHT</b> The desired weight.
    ///    baseStyle = Type: <b>DWRITE_FONT_STYLE</b> The desired style.
    ///    baseStretch = Type: <b>DWRITE_FONT_STRETCH</b> The desired stretch.
    ///    mappedLength = Type: <b>UINT32*</b> Length of text mapped to the mapped font. This will always be less than or equal to the
    ///                   text length and greater than zero (if the text length is non-zero) so the caller advances at least one
    ///                   character.
    ///    mappedFont = Type: <b>IDWriteFont**</b> The font that should be used to render the first <i>mappedLength</i> characters of
    ///                 the text. If it returns NULL, that means that no font can render the text, and <i>mappedLength</i> is the
    ///                 number of characters to skip (rendered with a missing glyph).
    ///    scale = Type: <b>FLOAT*</b> Scale factor to multiply the em size of the returned font by.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT MapCharacters(IDWriteTextAnalysisSource analysisSource, uint textPosition, uint textLength, 
                          IDWriteFontCollection baseFontCollection, const(PWSTR) baseFamilyName, 
                          DWRITE_FONT_WEIGHT baseWeight, DWRITE_FONT_STYLE baseStyle, 
                          DWRITE_FONT_STRETCH baseStretch, uint* mappedLength, IDWriteFont* mappedFont, float* scale);
}

///Allows you to create Unicode font fallback mappings and create a font fall back object from those mappings.
@GUID("FD882D06-8ABA-4FB8-B849-8BE8B73E14DE")
interface IDWriteFontFallbackBuilder : IUnknown
{
    ///Appends a single mapping to the list. Call this once for each additional mapping.
    ///Params:
    ///    ranges = Type: <b>DWRITE_UNICODE_RANGE*</b> Unicode ranges that apply to this mapping.
    ///    rangesCount = Type: <b>UINT32</b> Number of Unicode ranges.
    ///    targetFamilyNames = Type: <b>const WCHAR**</b> List of target family name strings.
    ///    targetFamilyNamesCount = Type: <b>UINT32</b> Number of target family names.
    ///    fontCollection = Type: <b>IDWriteFontCollection</b> Optional explicit font collection for this mapping.
    ///    localeName = Type: <b>const WCHAR*</b> Locale of the context.
    ///    baseFamilyName = Type: <b>const WCHAR*</b> Base family name to match against, if applicable.
    ///    scale = Type: <b>FLOAT</b> Scale factor to multiply the result target font by.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AddMapping(const(DWRITE_UNICODE_RANGE)* ranges, uint rangesCount, const(ushort)** targetFamilyNames, 
                       uint targetFamilyNamesCount, IDWriteFontCollection fontCollection, const(PWSTR) localeName, 
                       const(PWSTR) baseFamilyName, float scale);
    ///Add all the mappings from an existing font fallback object.
    ///Params:
    ///    fontFallback = Type: <b>IDWriteFontFallback*</b> An existing font fallback object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AddMappings(IDWriteFontFallback fontFallback);
    ///Creates the finalized fallback object from the mappings added.
    ///Params:
    ///    fontFallback = Contains an address of a pointer to the created fallback list.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateFontFallback(IDWriteFontFallback* fontFallback);
}

///Represents a physical font in a font collection. This interface adds the ability to check if a color rendering path
///is potentially necessary.
@GUID("29748ED6-8C9C-4A6A-BE0B-D912E8538944")
interface IDWriteFont2 : IDWriteFont1
{
    ///Enables determining if a color rendering path is potentially necessary.
    ///Returns:
    ///    Type: <b>BOOL</b> Returns <b>TRUE</b> if the font has color information (COLR and CPAL tables); otherwise
    ///    <b>FALSE</b>.
    ///    
    BOOL IsColorFont();
}

///Represents an absolute reference to a font face. This interface contains font face type, appropriate file references,
///and face identification data. It adds the ability to check whether a color rendering path is potentially necessary.
///This interface extends [IDWriteFontFace1](../dwrite_1/nn-dwrite_1-idwritefontface1.md). Various font data such as
///metrics, names, and glyph outlines are obtained from **IDWriteFontFace**.
@GUID("D8B768FF-64BC-4E66-982B-EC8E87F693F7")
interface IDWriteFontFace2 : IDWriteFontFace1
{
    ///Allows you to determine if a color rendering path is potentially necessary.
    ///Returns:
    ///    Type: <b>BOOL</b> Returns <b>TRUE</b> if a color rendering path is potentially necessary.
    ///    
    BOOL    IsColorFont();
    ///Gets the number of color palettes defined by the font.
    ///Returns:
    ///    The return value is zero if the font has no color information. Color fonts are required to define at least
    ///    one palette, with palette index zero reserved as the default palette.
    ///    
    uint    GetColorPaletteCount();
    ///Get the number of entries in each color palette.
    ///Returns:
    ///    The number of entries in each color palette. All color palettes in a font have the same number of palette
    ///    entries. The return value is zero if the font has no color information.
    ///    
    uint    GetPaletteEntryCount();
    ///Gets color values from the font's color palette.
    ///Params:
    ///    colorPaletteIndex = Zero-based index of the color palette. If the font does not have a palette with the specified index, the
    ///                        method returns <b>DWRITE_E_NOCOLOR</b>.
    ///    firstEntryIndex = Zero-based index of the first palette entry to read.
    ///    entryCount = Number of palette entries to read.
    ///    paletteEntries = Array that receives the color values.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return value</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt>E_INVALIDARG</dt> </dl> </td> <td width="60%"> The sum of
    ///    <i>firstEntryIndex</i> and <i>entryCount</i> is greater than the actual number of palette entries that's
    ///    returned by the GetPaletteEntryCount method. </td> </tr> <tr> <td width="40%"> <dl> <dt>DWRITE_E_NOCOLOR</dt>
    ///    </dl> </td> <td width="60%"> The font doesn't have a palette with the specified palette index. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetPaletteEntries(uint colorPaletteIndex, uint firstEntryIndex, uint entryCount, 
                              DXGI_RGBA* paletteEntries);
    ///Determines the recommended text rendering and grid-fit mode to be used based on the font, size, world transform,
    ///and measuring mode.
    ///Params:
    ///    fontEmSize = Type: <b>FLOAT</b> Logical font size in DIPs.
    ///    dpiX = Type: <b>FLOAT</b> Number of pixels per logical inch in the horizontal direction.
    ///    dpiY = Type: <b>FLOAT</b> Number of pixels per logical inch in the vertical direction.
    ///    transform = Type: <b>const DWRITE_MATRIX*</b> A DWRITE_MATRIX structure that describes the world transform.
    ///    isSideways = Type: <b>BOOL</b> Specifies whether the font is sideways. <b>TRUE</b> if the font is sideways; otherwise,
    ///                 <b>FALSE</b>.
    ///    outlineThreshold = Type: <b>DWRITE_OUTLINE_THRESHOLD</b> A DWRITE_OUTLINE_THRESHOLD-typed value that specifies the quality of
    ///                       the graphics system's outline rendering, affects the size threshold above which outline rendering is used.
    ///    measuringMode = Type: <b>DWRITE_MEASURING_MODE</b> A DWRITE_MEASURING_MODE-typed value that specifies the method used to
    ///                    measure during text layout. For proper glyph spacing, this method returns a rendering mode that is compatible
    ///                    with the specified measuring mode.
    ///    renderingParams = Type: <b>IDWriteRenderingParams*</b> A pointer to a IDWriteRenderingParams interface for the rendering
    ///                      parameters object. This parameter is necessary in case the rendering parameters object overrides the
    ///                      rendering mode.
    ///    renderingMode = Type: <b>DWRITE_RENDERING_MODE*</b> A pointer to a variable that receives a DWRITE_RENDERING_MODE-typed value
    ///                    for the recommended rendering mode.
    ///    gridFitMode = Type: <b>DWRITE_GRID_FIT_MODE*</b> A pointer to a variable that receives a DWRITE_GRID_FIT_MODE-typed value
    ///                  for the recommended grid-fit mode.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetRecommendedRenderingMode(float fontEmSize, float dpiX, float dpiY, const(DWRITE_MATRIX)* transform, 
                                        BOOL isSideways, DWRITE_OUTLINE_THRESHOLD outlineThreshold, 
                                        DWRITE_MEASURING_MODE measuringMode, IDWriteRenderingParams renderingParams, 
                                        DWRITE_RENDERING_MODE* renderingMode, DWRITE_GRID_FIT_MODE* gridFitMode);
}

///This interface allows the application to enumerate through the color glyph runs. The enumerator enumerates the layers
///in a back to front order for appropriate layering.
@GUID("D31FBE17-F157-41A2-8D24-CB779E0560E8")
interface IDWriteColorGlyphRunEnumerator : IUnknown
{
    ///Move to the next glyph run in the enumerator.
    ///Params:
    ///    hasRun = Type: <b>BOOL*</b> Returns <b>TRUE</b> if there is a next glyph run.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT MoveNext(BOOL* hasRun);
    ///Returns the current glyph run of the enumerator.
    ///Params:
    ///    colorGlyphRun = Type: <b>const DWRITE_COLOR_GLYPH_RUN**</b> A pointer to the current glyph run.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetCurrentRun(const(DWRITE_COLOR_GLYPH_RUN)** colorGlyphRun);
}

///Represents text rendering settings for glyph rasterization and filtering.
@GUID("F9D711C3-9777-40AE-87E8-3E5AF9BF0948")
interface IDWriteRenderingParams2 : IDWriteRenderingParams1
{
    ///Gets the grid fitting mode.
    ///Returns:
    ///    Type: <b>DWRITE_GRID_FIT_MODE</b> Returns a DWRITE_GRID_FIT_MODE-typed value for the grid fitting mode.
    ///    
    DWRITE_GRID_FIT_MODE GetGridFitMode();
}

///The root factory interface for all DirectWrite objects.
@GUID("0439FC60-CA44-4994-8DEE-3A9AF7B732EC")
interface IDWriteFactory2 : IDWriteFactory1
{
    ///Creates a font fallback object from the system font fallback list.
    ///Params:
    ///    fontFallback = Type: <b>IDWriteFontFallback**</b> Contains an address of a pointer to the newly created font fallback
    ///                   object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetSystemFontFallback(IDWriteFontFallback* fontFallback);
    ///Creates a font fallback builder object. A font fall back builder allows you to create Unicode font fallback
    ///mappings and create a font fall back object from those mappings.
    ///Params:
    ///    fontFallbackBuilder = Type: <b>IDWriteFontFallbackBuilder**</b> Contains an address of a pointer to the newly created font fallback
    ///                          builder object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateFontFallbackBuilder(IDWriteFontFallbackBuilder* fontFallbackBuilder);
    ///This method is called on a glyph run to translate it in to multiple color glyph runs.
    ///Params:
    ///    baselineOriginX = Type: <b>FLOAT</b> The horizontal baseline origin of the original glyph run.
    ///    baselineOriginY = Type: <b>FLOAT</b> The vertical baseline origin of the original glyph run.
    ///    glyphRun = Type: <b>const DWRITE_GLYPH_RUN*</b> Original glyph run containing monochrome glyph IDs.
    ///    glyphRunDescription = Type: <b>const DWRITE_GLYPH_RUN_DESCRIPTION*</b> Optional glyph run description.
    ///    measuringMode = Type: <b>DWRITE_MEASURING_MODE</b> Measuring mode used to compute glyph positions if the run contains color
    ///                    glyphs.
    ///    worldToDeviceTransform = Type: <b>const DWRITE_MATRIX*</b> World transform multiplied by any DPI scaling. This is needed to compute
    ///                             glyph positions if the run contains color glyphs and the measuring mode is not DWRITE_MEASURING_MODE_NATURAL.
    ///                             If this parameter is <b>NULL</b>, and identity transform is assumed.
    ///    colorPaletteIndex = Type: <b>UINT32</b> Zero-based index of the color palette to use. Valid indices are less than the number of
    ///                        palettes in the font, as returned by IDWriteFontFace2::GetColorPaletteCount.
    ///    colorLayers = Type: <b>IDWriteColorGlyphRunEnumerator**</b> If the original glyph run contains color glyphs, this parameter
    ///                  receives a pointer to an IDWriteColorGlyphRunEnumerator interface. The client uses the returned interface to
    ///                  get information about glyph runs and associated colors to render instead of the original glyph run. If the
    ///                  original glyph run does not contain color glyphs, this method returns <b>DWRITE_E_NOCOLOR</b> and the output
    ///                  pointer is <b>NULL</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT TranslateColorGlyphRun(float baselineOriginX, float baselineOriginY, const(DWRITE_GLYPH_RUN)* glyphRun, 
                                   const(DWRITE_GLYPH_RUN_DESCRIPTION)* glyphRunDescription, 
                                   DWRITE_MEASURING_MODE measuringMode, const(DWRITE_MATRIX)* worldToDeviceTransform, 
                                   uint colorPaletteIndex, IDWriteColorGlyphRunEnumerator* colorLayers);
    ///Creates a rendering parameters object with the specified properties.
    ///Params:
    ///    gamma = Type: <b>FLOAT</b> The gamma value used for gamma correction, which must be greater than zero and cannot
    ///            exceed 256.
    ///    enhancedContrast = Type: <b>FLOAT</b> The amount of contrast enhancement, zero or greater.
    ///    grayscaleEnhancedContrast = Type: <b>FLOAT</b> The amount of contrast enhancement, zero or greater.
    ///    clearTypeLevel = Type: <b>FLOAT</b> The degree of ClearType level, from 0.0f (no ClearType) to 1.0f (full ClearType).
    ///    pixelGeometry = Type: <b>DWRITE_PIXEL_GEOMETRY</b> The geometry of a device pixel.
    ///    renderingMode = Type: <b>DWRITE_RENDERING_MODE</b> Method of rendering glyphs. In most cases, this should be
    ///                    DWRITE_RENDERING_MODE_DEFAULT to automatically use an appropriate mode.
    ///    gridFitMode = Type: <b>DWRITE_GRID_FIT_MODE</b> How to grid fit glyph outlines. In most cases, this should be
    ///                  DWRITE_GRID_FIT_DEFAULT to automatically choose an appropriate mode.
    ///    renderingParams = Type: <b>IDWriteRenderingParams2**</b> Holds the newly created rendering parameters object, or NULL in case
    ///                      of failure.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateCustomRenderingParams(float gamma, float enhancedContrast, float grayscaleEnhancedContrast, 
                                        float clearTypeLevel, DWRITE_PIXEL_GEOMETRY pixelGeometry, 
                                        DWRITE_RENDERING_MODE renderingMode, DWRITE_GRID_FIT_MODE gridFitMode, 
                                        IDWriteRenderingParams2* renderingParams);
    ///Creates a glyph run analysis object, which encapsulates information used to render a glyph run.
    ///Params:
    ///    glyphRun = Type: <b>const DWRITE_GLYPH_RUN*</b> Structure specifying the properties of the glyph run.
    ///    transform = Type: <b>const DWRITE_MATRIX*</b> Optional transform applied to the glyphs and their positions. This
    ///                transform is applied after the scaling specified by the emSize and pixelsPerDip.
    ///    renderingMode = Type: <b>DWRITE_RENDERING_MODE</b> Specifies the rendering mode, which must be one of the raster rendering
    ///                    modes (i.e., not default and not outline).
    ///    measuringMode = Type: <b>DWRITE_MEASURING_MODE</b> Specifies the method to measure glyphs.
    ///    gridFitMode = Type: <b>DWRITE_GRID_FIT_MODE</b> How to grid-fit glyph outlines. This must be non-default.
    ///    antialiasMode = Type: <b>DWRITE_TEXT_ANTIALIAS_MODE</b> Specifies the antialias mode.
    ///    baselineOriginX = Type: <b>FLOAT</b> Horizontal position of the baseline origin, in DIPs.
    ///    baselineOriginY = Type: <b>FLOAT</b> Vertical position of the baseline origin, in DIPs.
    ///    glyphRunAnalysis = Type: <b>IDWriteGlyphRunAnalysis**</b> Receives a pointer to the newly created object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateGlyphRunAnalysis(const(DWRITE_GLYPH_RUN)* glyphRun, const(DWRITE_MATRIX)* transform, 
                                   DWRITE_RENDERING_MODE renderingMode, DWRITE_MEASURING_MODE measuringMode, 
                                   DWRITE_GRID_FIT_MODE gridFitMode, DWRITE_TEXT_ANTIALIAS_MODE antialiasMode, 
                                   float baselineOriginX, float baselineOriginY, 
                                   IDWriteGlyphRunAnalysis* glyphRunAnalysis);
}

///Represents text rendering settings for glyph rasterization and filtering.
@GUID("B7924BAA-391B-412A-8C5C-E44CC2D867DC")
interface IDWriteRenderingParams3 : IDWriteRenderingParams2
{
    ///Gets the rendering mode.
    ///Returns:
    ///    Type: <b>DWRITE_RENDERING_MODE1</b> Returns a DWRITE_RENDERING_MODE1-typed value for the rendering mode.
    ///    
    DWRITE_RENDERING_MODE1 GetRenderingMode1();
}

///The root factory interface for all DirectWrite objects.
@GUID("9A1B41C3-D3BB-466A-87FC-FE67556A3B65")
interface IDWriteFactory3 : IDWriteFactory2
{
    ///Creates a glyph-run-analysis object that encapsulates info that DirectWrite uses to render a glyph run.
    ///Params:
    ///    glyphRun = Type: <b>DWRITE_GLYPH_RUN</b> A DWRITE_GLYPH_RUN structure that contains the properties of the glyph run.
    ///    transform = Type: <b>DWRITE_MATRIX</b> A DWRITE_MATRIX structure that describes the optional transform to be applied to
    ///                glyphs and their positions.
    ///    renderingMode = Type: <b>DWRITE_RENDERING_MODE1</b> A DWRITE_RENDERING_MODE1-typed value that specifies the rendering mode,
    ///                    which must be one of the raster rendering modes (that is, not default and not outline).
    ///    measuringMode = Type: <b>DWRITE_MEASURING_MODE</b> A DWRITE_MEASURING_MODE-typed value that specifies the measuring method
    ///                    for glyphs in the run. This method uses this value with the other properties to determine the rendering mode.
    ///    gridFitMode = Type: <b>DWRITE_GRID_FIT_MODE</b> A DWRITE_GRID_FIT_MODE-typed value that specifies how to grid-fit glyph
    ///                  outlines. This value must be non-default.
    ///    antialiasMode = Type: <b>DWRITE_TEXT_ANTIALIAS_MODE</b> A DWRITE_TEXT_ANTIALIAS_MODE-typed value that specifies the type of
    ///                    antialiasing to use for text when the rendering mode calls for antialiasing.
    ///    baselineOriginX = Type: <b>FLOAT</b> The horizontal position of the baseline origin, in DIPs, relative to the upper-left corner
    ///                      of the DIB.
    ///    baselineOriginY = Type: <b>FLOAT</b> The vertical position of the baseline origin, in DIPs, relative to the upper-left corner
    ///                      of the DIB.
    ///    glyphRunAnalysis = Type: <b>IDWriteGlyphRunAnalysis**</b> A pointer to a memory block that receives a pointer to a
    ///                       IDWriteGlyphRunAnalysis interface for the newly created glyph-run-analysis object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateGlyphRunAnalysis(const(DWRITE_GLYPH_RUN)* glyphRun, const(DWRITE_MATRIX)* transform, 
                                   DWRITE_RENDERING_MODE1 renderingMode, DWRITE_MEASURING_MODE measuringMode, 
                                   DWRITE_GRID_FIT_MODE gridFitMode, DWRITE_TEXT_ANTIALIAS_MODE antialiasMode, 
                                   float baselineOriginX, float baselineOriginY, 
                                   IDWriteGlyphRunAnalysis* glyphRunAnalysis);
    ///Creates a rendering parameters object with the specified properties.
    ///Params:
    ///    gamma = Type: <b>FLOAT</b> The gamma value used for gamma correction, which must be greater than zero and cannot
    ///            exceed 256.
    ///    enhancedContrast = Type: <b>FLOAT</b> The amount of contrast enhancement, zero or greater.
    ///    grayscaleEnhancedContrast = Type: <b>FLOAT</b> The amount of contrast enhancement to use for grayscale antialiasing, zero or greater.
    ///    clearTypeLevel = Type: <b>FLOAT</b> The degree of ClearType level, from 0.0f (no ClearType) to 1.0f (full ClearType).
    ///    pixelGeometry = Type: <b>DWRITE_PIXEL_GEOMETRY</b> A DWRITE_PIXEL_GEOMETRY-typed value that specifies the internal structure
    ///                    of a device pixel (that is, the physical arrangement of red, green, and blue color components) that is
    ///                    assumed for purposes of rendering text.
    ///    renderingMode = Type: <b>DWRITE_RENDERING_MODE1</b> A DWRITE_RENDERING_MODE1-typed value that specifies the method (for
    ///                    example, ClearType natural quality) for rendering glyphs. In most cases, specify
    ///                    <b>DWRITE_RENDERING_MODE1_DEFAULT</b> to automatically use an appropriate mode.
    ///    gridFitMode = Type: <b>DWRITE_GRID_FIT_MODE</b> A DWRITE_GRID_FIT_MODE-typed value that specifies how to grid-fit glyph
    ///                  outlines. In most cases, specify <b>DWRITE_GRID_FIT_DEFAULT</b> to automatically choose an appropriate mode.
    ///    renderingParams = Type: <b>IDWriteRenderingParams3**</b> A pointer to a memory block that receives a pointer to a
    ///                      IDWriteRenderingParams3 interface for the newly created rendering parameters object, or <b>NULL</b> in case
    ///                      of failure.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateCustomRenderingParams(float gamma, float enhancedContrast, float grayscaleEnhancedContrast, 
                                        float clearTypeLevel, DWRITE_PIXEL_GEOMETRY pixelGeometry, 
                                        DWRITE_RENDERING_MODE1 renderingMode, DWRITE_GRID_FIT_MODE gridFitMode, 
                                        IDWriteRenderingParams3* renderingParams);
    HRESULT CreateFontFaceReference(const(PWSTR) filePath, const(FILETIME)* lastWriteTime, uint faceIndex, 
                                    DWRITE_FONT_SIMULATIONS fontSimulations, 
                                    IDWriteFontFaceReference* fontFaceReference);
    HRESULT CreateFontFaceReference(IDWriteFontFile fontFile, uint faceIndex, 
                                    DWRITE_FONT_SIMULATIONS fontSimulations, 
                                    IDWriteFontFaceReference* fontFaceReference);
    ///Retrieves the list of system fonts.
    ///Params:
    ///    fontSet = Type: <b>IDWriteFontSet**</b> Holds the newly created font set object, or NULL in case of failure.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetSystemFontSet(IDWriteFontSet* fontSet);
    ///Creates an empty font set builder to add font face references and create a custom font set.
    ///Params:
    ///    fontSetBuilder = Type: <b>IDWriteFontSetBuilder**</b> Holds the newly created font set builder object, or NULL in case of
    ///                     failure.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateFontSetBuilder(IDWriteFontSetBuilder* fontSetBuilder);
    ///Create a weight/width/slope tree from a set of fonts.
    ///Params:
    ///    fontSet = Type: <b>IDWriteFontSet*</b> A set of fonts to use to build the collection.
    ///    fontCollection = Type: <b>IDWriteFontCollection1**</b> Holds the newly created font collection object, or NULL in case of
    ///                     failure.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateFontCollectionFromFontSet(IDWriteFontSet fontSet, IDWriteFontCollection1* fontCollection);
    ///Retrieves a weight/width/slope tree of system fonts.
    ///Params:
    ///    includeDownloadableFonts = Type: <b>BOOL</b> Indicates whether to include cloud fonts or only locally installed fonts.
    ///    fontCollection = Type: <b>IDWriteFontCollection1**</b> Holds the newly created font collection object, or NULL in case of
    ///                     failure.
    ///    checkForUpdates = Type: <b>BOOL</b> If this parameter is TRUE, the function performs an immediate check for changes to the set
    ///                      of system fonts. If this parameter is FALSE, the function will still detect changes if the font cache service
    ///                      is running, but there may be some latency. For example, an application might specify TRUE if it has just
    ///                      installed a font and wants to be sure the font collection contains that font.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetSystemFontCollection(BOOL includeDownloadableFonts, IDWriteFontCollection1* fontCollection, 
                                    BOOL checkForUpdates);
    ///Gets the font download queue associated with this factory object.
    ///Params:
    ///    fontDownloadQueue = Type: <b>IDWriteFontDownloadQueue**</b> Receives a pointer to the font download queue interface.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetFontDownloadQueue(IDWriteFontDownloadQueue* fontDownloadQueue);
}

///Represents a font set.
@GUID("53585141-D9F8-4095-8321-D73CF6BD116B")
interface IDWriteFontSet : IUnknown
{
    ///Get the number of total fonts in the set.
    ///Returns:
    ///    Type: <b>UINT32</b> Returns the number of total fonts in the set.
    ///    
    uint    GetFontCount();
    ///Gets a reference to the font at the specified index, which may be local or remote.
    ///Params:
    ///    listIndex = Type: <b>UINT32</b> Zero-based index of the font.
    ///    fontFaceReference = Type: <b>IDWriteFontFaceReference**</b> Receives a pointer the font face reference object, or nullptr on
    ///                        failure.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetFontFaceReference(uint listIndex, IDWriteFontFaceReference* fontFaceReference);
    ///Gets the index of the matching font face reference in the font set, with the same file, face index, and
    ///simulations.
    ///Params:
    ///    fontFaceReference = Type: <b>IDWriteFontFaceReference*</b> Font face object that specifies the physical font.
    ///    listIndex = Type: <b>UINT32*</b> Receives the zero-based index of the matching font if the font was found, or UINT_MAX
    ///                otherwise.
    ///    exists = Type: <b>BOOL*</b> Receives TRUE if the font exists or FALSE otherwise.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT FindFontFaceReference(IDWriteFontFaceReference fontFaceReference, uint* listIndex, BOOL* exists);
    ///Gets the index of the matching font face reference in the font set, with the same file, face index, and
    ///simulations.
    ///Params:
    ///    fontFace = Type: <b>IDWriteFontFace*</b> Font face object that specifies the physical font.
    ///    listIndex = Type: <b>UINT32*</b> Receives the zero-based index of the matching font if the font was found, or UINT_MAX
    ///                otherwise.
    ///    exists = Type: <b>BOOL*</b> Receives TRUE if the font exists or FALSE otherwise.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT FindFontFace(IDWriteFontFace fontFace, uint* listIndex, BOOL* exists);
    HRESULT GetPropertyValues(uint listIndex, DWRITE_FONT_PROPERTY_ID propertyId, BOOL* exists, 
                              IDWriteLocalizedStrings* values);
    HRESULT GetPropertyValues(DWRITE_FONT_PROPERTY_ID propertyID, const(PWSTR) preferredLocaleNames, 
                              IDWriteStringList* values);
    HRESULT GetPropertyValues(DWRITE_FONT_PROPERTY_ID propertyID, IDWriteStringList* values);
    ///Returns how many times a given property value occurs in the set.
    ///Params:
    ///    property = Type: <b>const DWRITE_FONT_PROPERTY*</b> Font property of interest.
    ///    propertyOccurrenceCount = Type: <b>UINT32*</b> Receives how many times the property occurs.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetPropertyOccurrenceCount(const(DWRITE_FONT_PROPERTY)* property, uint* propertyOccurrenceCount);
    HRESULT GetMatchingFonts(const(DWRITE_FONT_PROPERTY)* properties, uint propertyCount, 
                             IDWriteFontSet* filteredSet);
    HRESULT GetMatchingFonts(const(PWSTR) familyName, DWRITE_FONT_WEIGHT fontWeight, 
                             DWRITE_FONT_STRETCH fontStretch, DWRITE_FONT_STYLE fontStyle, 
                             IDWriteFontSet* filteredSet);
}

///Contains methods for building a font set.
@GUID("2F642AFE-9C68-4F40-B8BE-457401AFCB3D")
interface IDWriteFontSetBuilder : IUnknown
{
    HRESULT AddFontFaceReference(IDWriteFontFaceReference fontFaceReference);
    HRESULT AddFontFaceReference(IDWriteFontFaceReference fontFaceReference, 
                                 const(DWRITE_FONT_PROPERTY)* properties, uint propertyCount);
    ///Appends an existing font set to the one being built, allowing one to aggregate two sets or to essentially extend
    ///an existing one.
    ///Params:
    ///    fontSet = Type: <b>IDWriteFontSet*</b> Font set to append font face references from.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AddFontSet(IDWriteFontSet fontSet);
    ///Creates a font set from all the font face references added so far with AddFontFaceReference.
    ///Params:
    ///    fontSet = Type: <b>IDWriteFontSet**</b> Contains the newly created font set object, or nullptr in case of failure.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateFontSet(IDWriteFontSet* fontSet);
}

///An object that encapsulates a set of fonts, such as the set of fonts installed on the system, or the set of fonts in
///a particular directory. The font collection API can be used to discover what font families and fonts are available,
///and to obtain some metadata about the fonts.
@GUID("53585141-D9F8-4095-8321-D73CF6BD116C")
interface IDWriteFontCollection1 : IDWriteFontCollection
{
    ///Gets the underlying font set used by this collection.
    ///Params:
    ///    fontSet = Type: <b>IDWriteFontSet**</b> Returns the font set used by the collection.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetFontSet(IDWriteFontSet* fontSet);
    HRESULT GetFontFamily(uint index, IDWriteFontFamily1* fontFamily);
}

///Represents a family of related fonts.
@GUID("DA20D8EF-812A-4C43-9802-62EC4ABD7ADF")
interface IDWriteFontFamily1 : IDWriteFontFamily
{
    ///Gets the current location of a font given its zero-based index.
    ///Params:
    ///    listIndex = Type: <b>UINT32</b> Zero-based index of the font in the font list.
    ///Returns:
    ///    Type: <b>DWRITE_LOCALITY</b> Returns a DWRITE_LOCALITY-typed value that specifies the location of the
    ///    specified font.
    ///    
    DWRITE_LOCALITY GetFontLocality(uint listIndex);
    ///Gets a font given its zero-based index.
    ///Params:
    ///    listIndex = Type: <b>UINT32</b> Zero-based index of the font in the font list.
    ///    font = Type: <b>IDWriteFont3**</b> A pointer to a memory block that receives a pointer to a IDWriteFont3 interface
    ///           for the newly created font object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetFont(uint listIndex, IDWriteFont3* font);
    ///Gets a font face reference given its zero-based index.
    ///Params:
    ///    listIndex = Type: <b>UINT32</b> Zero-based index of the font in the font list.
    ///    fontFaceReference = Type: <b>IDWriteFontFaceReference**</b> A pointer to a memory block that receives a pointer to a
    ///                        IDWriteFontFaceReference interface for the newly created font face reference object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetFontFaceReference(uint listIndex, IDWriteFontFaceReference* fontFaceReference);
}

///Represents a list of fonts.
@GUID("DA20D8EF-812A-4C43-9802-62EC4ABD7ADE")
interface IDWriteFontList1 : IDWriteFontList
{
    ///Gets the current location of a font given its zero-based index.
    ///Params:
    ///    listIndex = Type: <b>UINT32</b> Zero-based index of the font in the font list.
    ///Returns:
    ///    Type: <b>DWRITE_LOCALITY</b> Returns a DWRITE_LOCALITY-typed value that specifies the location of the
    ///    specified font.
    ///    
    DWRITE_LOCALITY GetFontLocality(uint listIndex);
    ///Gets a font given its zero-based index.
    ///Params:
    ///    listIndex = Type: <b>UINT32</b> Zero-based index of the font in the font list.
    ///    font = Type: <b>IDWriteFont3**</b> A pointer to a memory block that receives a pointer to a IDWriteFont3 interface
    ///           for the newly created font object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b>
    ///    error code. This method returns <b>DWRITE_E_REMOTEFONT</b> if it could not construct a remote font.
    ///    
    HRESULT GetFont(uint listIndex, IDWriteFont3* font);
    ///Gets a font face reference given its zero-based index.
    ///Params:
    ///    listIndex = Type: <b>UINT32</b> Zero-based index of the font in the font list.
    ///    fontFaceReference = Type: <b>IDWriteFontFaceReference**</b> A pointer to a memory block that receives a pointer to a
    ///                        IDWriteFontFaceReference interface for the newly created font face reference object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetFontFaceReference(uint listIndex, IDWriteFontFaceReference* fontFaceReference);
}

///Represents a reference to a font face. A uniquely identifying reference to a font, from which you can create a font
///face to query font metrics and use for rendering. A font face reference consists of a font file, font face index, and
///font face simulation. The file data may or may not be physically present on the local machine yet.
@GUID("5E7FA7CA-DDE3-424C-89F0-9FCD6FED58CD")
interface IDWriteFontFaceReference : IUnknown
{
    ///Creates a font face from the reference for use with layout, shaping, or rendering.
    ///Params:
    ///    fontFace = Type: <b>IDWriteFontFace3**</b> Newly created font face object, or nullptr in the case of failure.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateFontFace(IDWriteFontFace3* fontFace);
    ///Creates a font face with alternate font simulations, for example, to explicitly simulate a bold font face out of
    ///a regular variant.
    ///Params:
    ///    fontFaceSimulationFlags = Type: <b>DWRITE_FONT_SIMULATIONS</b> Font face simulation flags for algorithmic emboldening and
    ///                              italicization.
    ///    fontFace = Type: <b>IDWriteFontFace3**</b> Newly created font face object, or nullptr in the case of failure.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateFontFaceWithSimulations(DWRITE_FONT_SIMULATIONS fontFaceSimulationFlags, 
                                          IDWriteFontFace3* fontFace);
    BOOL    Equals(IDWriteFontFaceReference fontFaceReference);
    ///Obtains the zero-based index of the font face in its font file or files. If the font files contain a single face,
    ///the return value is zero.
    ///Returns:
    ///    Type: <b>UINT32</b> the zero-based index of the font face in its font file or files. If the font files
    ///    contain a single face, the return value is zero.
    ///    
    uint    GetFontFaceIndex();
    ///Obtains the algorithmic style simulation flags of a font face.
    ///Returns:
    ///    Type: <b>DWRITE_FONT_SIMULATIONS</b> Returns the algorithmic style simulation flags of a font face.
    ///    
    DWRITE_FONT_SIMULATIONS GetSimulations();
    ///Obtains the font file representing a font face.
    ///Params:
    ///    fontFile = Type: <b>IDWriteFontFile**</b>
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetFontFile(IDWriteFontFile* fontFile);
    ///Get the local size of the font face in bytes, which will always be less than or equal to GetFullSize. If the
    ///locality is remote, this value is zero. If full, this value will equal GetFileSize.
    ///Returns:
    ///    Type: <b>UINT64</b> the local size of the font face in bytes, which will always be less than or equal to
    ///    GetFullSize. If the locality is remote, this value is zero. If full, this value will equal GetFileSize.
    ///    
    ulong   GetLocalFileSize();
    ///Get the total size of the font face in bytes.
    ///Returns:
    ///    Type: <b>UINT64</b> Returns the total size of the font face in bytes. If the locality is remote, this value
    ///    is unknown and will be zero.
    ///    
    ulong   GetFileSize();
    ///Get the last modified date.
    ///Params:
    ///    lastWriteTime = Type: <b>FILETIME*</b> Returns the last modified date. The time may be zero if the font file loader does not
    ///                    expose file time.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetFileTime(FILETIME* lastWriteTime);
    ///Get the locality of this font face reference.
    ///Returns:
    ///    Type: <b>DWRITE_LOCALITY</b> Returns the locality of this font face reference.
    ///    
    DWRITE_LOCALITY GetLocality();
    ///Adds a request to the font download queue (IDWriteFontDownloadQueue).
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT EnqueueFontDownloadRequest();
    ///Adds a request to the font download queue (IDWriteFontDownloadQueue).
    ///Params:
    ///    characters = Type: <b>const WCHAR*</b> Array of characters to download.
    ///    characterCount = Type: <b>UINT32</b> The number of elements in the character array.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT EnqueueCharacterDownloadRequest(const(PWSTR) characters, uint characterCount);
    ///Adds a request to the font download queue (IDWriteFontDownloadQueue).
    ///Params:
    ///    glyphIndices = Type: <b>const UINT16*</b> Array of glyph indices to download.
    ///    glyphCount = Type: <b>UINT32</b> The number of elements in the glyph index array.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT EnqueueGlyphDownloadRequest(const(ushort)* glyphIndices, uint glyphCount);
    ///Adds a request to the font download queue (IDWriteFontDownloadQueue).
    ///Params:
    ///    fileOffset = Type: <b>UINT64</b> Offset of the fragment from the beginning of the font file.
    ///    fragmentSize = Type: <b>UINT64</b> Size of the fragment in bytes.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT EnqueueFileFragmentDownloadRequest(ulong fileOffset, ulong fragmentSize);
}

///Represents a font in a font collection.
@GUID("29748ED6-8C9C-4A6A-BE0B-D912E8538944")
interface IDWriteFont3 : IDWriteFont2
{
    ///Creates a font face object for the font.
    ///Params:
    ///    fontFace = Type: <b>IDWriteFontFace3**</b> A pointer to a memory block that receives a pointer to a IDWriteFontFace3
    ///               interface for the newly created font face object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b>
    ///    error code. This method returns <b>DWRITE_E_REMOTEFONT</b> if it could not construct a remote font.
    ///    
    HRESULT CreateFontFace(IDWriteFontFace3* fontFace);
    ///Compares two instances of font references for equality.
    ///Params:
    ///    font = Type: <b>IDWriteFont*</b> A pointer to a IDWriteFont interface for the other font instance to compare to this
    ///           font instance.
    ///Returns:
    ///    Type: <b>BOOL</b> Returns whether the two instances of font references are equal. Returns <b>TRUE</b> if the
    ///    two instances are equal; otherwise, <b>FALSE</b>.
    ///    
    BOOL    Equals(IDWriteFont font);
    ///Gets a font face reference that identifies this font.
    ///Params:
    ///    fontFaceReference = Type: <b>IDWriteFontFaceReference**</b> A pointer to a memory block that receives a pointer to a
    ///                        IDWriteFontFaceReference interface for the newly created font face reference object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetFontFaceReference(IDWriteFontFaceReference* fontFaceReference);
    BOOL    HasCharacter(uint unicodeValue);
    ///Gets the current locality of the font.
    ///Returns:
    ///    Type: <b>DWRITE_LOCALITY</b> Returns the current locality of the font.
    ///    
    DWRITE_LOCALITY GetLocality();
}

///Represents an absolute reference to a font face. This interface contains font face type, appropriate file references,
///and face identification data. This interface extends [IDWriteFontFace2](../dwrite_2/nn-dwrite_2-idwritefontface2.md).
///Various font data such as metrics, names, and glyph outlines are obtained from **IDWriteFontFace**.
@GUID("D37D7598-09BE-4222-A236-2081341CC1F2")
interface IDWriteFontFace3 : IDWriteFontFace2
{
    ///Gets a font face reference that identifies this font.
    ///Params:
    ///    fontFaceReference = Type: <b>IDWriteFontFaceReference**</b> A pointer to a memory block that receives a pointer to a
    ///                        IDWriteFontFaceReference interface for the newly created font face reference object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetFontFaceReference(IDWriteFontFaceReference* fontFaceReference);
    ///Gets the PANOSE values from the font, used for font selection and matching.
    ///Params:
    ///    panose = Type: <b>DWRITE_PANOSE*</b> A pointer to a DWRITE_PANOSE structure that receives the PANOSE values from the
    ///             font.
    void    GetPanose(DWRITE_PANOSE* panose);
    ///Gets the weight of this font.
    ///Returns:
    ///    Type: <b>DWRITE_FONT_WEIGHT</b> Returns a DWRITE_FONT_WEIGHT-typed value that specifies the density of a
    ///    typeface, in terms of the lightness or heaviness of the strokes.
    ///    
    DWRITE_FONT_WEIGHT GetWeight();
    ///Gets the stretch (also known as width) of this font.
    ///Returns:
    ///    Type: <b>DWRITE_FONT_STRETCH</b> Returns a DWRITE_FONT_STRETCH-typed value that specifies the degree to which
    ///    a font has been stretched compared to a font's normal aspect ratio.
    ///    
    DWRITE_FONT_STRETCH GetStretch();
    ///Gets the style (also known as slope) of this font.
    ///Returns:
    ///    Type: <b>DWRITE_FONT_STYLE</b> Returns a DWRITE_FONT_STYLE-typed value that specifies the style of the font.
    ///    
    DWRITE_FONT_STYLE GetStyle();
    ///Creates a localized strings object that contains the family names for the font family, indexed by locale name.
    ///Params:
    ///    names = Type: <b>IDWriteLocalizedStrings**</b> A pointer to a memory block that receives a pointer to a
    ///            IDWriteLocalizedStrings interface for the newly created localized strings object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetFamilyNames(IDWriteLocalizedStrings* names);
    ///Creates a localized strings object that contains the face names for the font (for example, Regular or Bold),
    ///indexed by locale name.
    ///Params:
    ///    names = Type: <b>IDWriteLocalizedStrings**</b> A pointer to a memory block that receives a pointer to a
    ///            IDWriteLocalizedStrings interface for the newly created localized strings object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetFaceNames(IDWriteLocalizedStrings* names);
    ///Gets a localized strings collection that contains the specified informational strings, indexed by locale name.
    ///Params:
    ///    informationalStringID = Type: <b>DWRITE_INFORMATIONAL_STRING_ID</b> A DWRITE_INFORMATIONAL_STRING_ID-typed value that identifies the
    ///                            strings to get.
    ///    informationalStrings = Type: <b>IDWriteLocalizedStrings**</b> A pointer to a memory block that receives a pointer to a
    ///                           IDWriteLocalizedStrings interface for the newly created localized strings object.
    ///    exists = Type: <b>BOOL*</b> A pointer to a variable that receives whether the font contains the specified string ID.
    ///             <b>TRUE</b> if the font contains the specified string ID; otherwise, <b>FALSE</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the font doesn't contain the specified string, the return value is S_OK, but
    ///    <i>informationalStrings</i> receives a <b>NULL</b> pointer and <i>exists</i> receives the value <b>FALSE</b>.
    ///    
    HRESULT GetInformationalStrings(DWRITE_INFORMATIONAL_STRING_ID informationalStringID, 
                                    IDWriteLocalizedStrings* informationalStrings, BOOL* exists);
    ///Determines whether the font supports the specified character.
    ///Params:
    ///    unicodeValue = Type: <b>UINT32</b> A Unicode (UCS-4) character value.
    ///Returns:
    ///    Type: <b>BOOL</b> Returns whether the font supports the specified character. Returns <b>TRUE</b> if the font
    ///    has the specified character; otherwise, <b>FALSE</b>.
    ///    
    BOOL    HasCharacter(uint unicodeValue);
    ///Determines the recommended text rendering and grid-fit mode to be used based on the font, size, world transform,
    ///and measuring mode.
    ///Params:
    ///    fontEmSize = Type: <b>FLOAT</b> Logical font size in DIPs.
    ///    dpiX = Type: <b>FLOAT</b> Number of pixels per logical inch in the horizontal direction.
    ///    dpiY = Type: <b>FLOAT</b> Number of pixels per logical inch in the vertical direction.
    ///    transform = Type: <b>const DWRITE_MATRIX*</b> A DWRITE_MATRIX structure that describes the world transform.
    ///    isSideways = Type: <b>BOOL</b> Specifies whether the font is sideways. <b>TRUE</b> if the font is sideways; otherwise,
    ///                 <b>FALSE</b>.
    ///    outlineThreshold = Type: <b>DWRITE_OUTLINE_THRESHOLD</b> A DWRITE_OUTLINE_THRESHOLD-typed value that specifies the quality of
    ///                       the graphics system's outline rendering, affects the size threshold above which outline rendering is used.
    ///    measuringMode = Type: <b>DWRITE_MEASURING_MODE</b> A DWRITE_MEASURING_MODE-typed value that specifies the method used to
    ///                    measure during text layout. For proper glyph spacing, this method returns a rendering mode that is compatible
    ///                    with the specified measuring mode.
    ///    renderingParams = Type: <b>IDWriteRenderingParams*</b> A pointer to a IDWriteRenderingParams interface for the rendering
    ///                      parameters object. This parameter is necessary in case the rendering parameters object overrides the
    ///                      rendering mode.
    ///    renderingMode = Type: <b>DWRITE_RENDERING_MODE1*</b> A pointer to a variable that receives a DWRITE_RENDERING_MODE1-typed
    ///                    value for the recommended rendering mode.
    ///    gridFitMode = Type: <b>DWRITE_GRID_FIT_MODE*</b> A pointer to a variable that receives a DWRITE_GRID_FIT_MODE-typed value
    ///                  for the recommended grid-fit mode.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetRecommendedRenderingMode(float fontEmSize, float dpiX, float dpiY, const(DWRITE_MATRIX)* transform, 
                                        BOOL isSideways, DWRITE_OUTLINE_THRESHOLD outlineThreshold, 
                                        DWRITE_MEASURING_MODE measuringMode, IDWriteRenderingParams renderingParams, 
                                        DWRITE_RENDERING_MODE1* renderingMode, DWRITE_GRID_FIT_MODE* gridFitMode);
    ///Determines whether the character is locally downloaded from the font.
    ///Params:
    ///    unicodeValue = Type: <b>UINT32</b> A Unicode (UCS-4) character value.
    ///Returns:
    ///    Type: <b>BOOL</b> Returns <b>TRUE</b> if the font has the specified character locally available, <b>FALSE</b>
    ///    if not or if the font does not support that character.
    ///    
    BOOL    IsCharacterLocal(uint unicodeValue);
    ///Determines whether the glyph is locally downloaded from the font.
    ///Params:
    ///    glyphId = Type: <b>UINT16</b> Glyph identifier.
    ///Returns:
    ///    Type: <b>BOOL</b> Returns TRUE if the font has the specified glyph locally available.
    ///    
    BOOL    IsGlyphLocal(ushort glyphId);
    ///Determines whether the specified characters are local.
    ///Params:
    ///    characters = Type: <b>WCHAR</b> Array of characters.
    ///    characterCount = Type: <b>UINT32</b> The number of elements in the character array.
    ///    enqueueIfNotLocal = Type: <b>BOOL</b> Specifies whether to enqueue a download request if any of the specified characters are not
    ///                        local.
    ///    isLocal = Type: <b>BOOL*</b> Receives TRUE if all of the specified characters are local, FALSE if any of the specified
    ///              characters are remote.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AreCharactersLocal(const(PWSTR) characters, uint characterCount, BOOL enqueueIfNotLocal, BOOL* isLocal);
    ///Determines whether the specified glyphs are local.
    ///Params:
    ///    glyphIndices = Type: <b>UINT16</b> Array of glyph indices.
    ///    glyphCount = Type: <b>UINT32</b> The number of elements in the glyph index array.
    ///    enqueueIfNotLocal = Type: <b>BOOL</b> Specifies whether to enqueue a download request if any of the specified glyphs are not
    ///                        local.
    ///    isLocal = Type: <b>BOOL*</b> Receives TRUE if all of the specified glyphs are local, FALSE if any of the specified
    ///              glyphs are remote.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AreGlyphsLocal(const(ushort)* glyphIndices, uint glyphCount, BOOL enqueueIfNotLocal, BOOL* isLocal);
}

///Represents a collection of strings indexed by number.An IDWriteStringList is identical to IDWriteLocalizedStrings
///except for the semantics, where localized strings are indexed on language (each language has one string property)
///whereas IDWriteStringList may contain multiple strings of the same language, such as a string list of family names
///from a font set. You can QueryInterface from an IDWriteLocalizedStrings to an IDWriteStringList.
@GUID("CFEE3140-1157-47CA-8B85-31BFCF3F2D0E")
interface IDWriteStringList : IUnknown
{
    ///Gets the number of strings in the string list.
    ///Returns:
    ///    Type: <b>UINT32</b> Returns the number of strings in the string list.
    ///    
    uint    GetCount();
    ///Gets the length in characters (not including the null terminator) of the locale name with the specified index.
    ///Params:
    ///    listIndex = Type: <b>UINT32</b> Zero-based index of the locale name.
    ///    length = Type: <b>UINT32*</b> Receives the length in characters, not including the null terminator.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetLocaleNameLength(uint listIndex, uint* length);
    ///Copies the locale name with the specified index to the specified array.
    ///Params:
    ///    listIndex = Type: <b>UINT32</b> Zero-based index of the locale name.
    ///    localeName = Type: <b>WCHAR*</b> Character array that receives the locale name.
    ///    size = Type: <b>UINT32</b> Size of the array in characters. The size must include space for the terminating null
    ///           character.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetLocaleName(uint listIndex, PWSTR localeName, uint size);
    ///Gets the length in characters (not including the null terminator) of the string with the specified index.
    ///Params:
    ///    listIndex = Type: <b>UINT32</b> Zero-based index of the string.
    ///    length = Type: <b>UINT32*</b> Receives the length in characters of the string, not including the null terminator.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetStringLength(uint listIndex, uint* length);
    ///Copies the string with the specified index to the specified array.
    ///Params:
    ///    listIndex = Type: <b>UINT32</b> Zero-based index of the string.
    ///    stringBuffer = Type: <b>WCHAR*</b> Character array that receives the string.
    ///    stringBufferSize = Type: <b>UINT32</b> Size of the array in characters. The size must include space for the terminating null
    ///                       character.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetString(uint listIndex, PWSTR stringBuffer, uint stringBufferSize);
}

///Application-defined callback interface that receives notifications from the font download queue
///(IDWriteFontDownloadQueue interface). Callbacks will occur on the downloading thread, and objects must be prepared to
///handle calls on their methods from other threads at any time.
@GUID("B06FE5B9-43EC-4393-881B-DBE4DC72FDA7")
interface IDWriteFontDownloadListener : IUnknown
{
    ///The DownloadCompleted method is called back on an arbitrary thread when a download operation ends.
    ///Params:
    ///    downloadQueue = Type: <b>IDWriteFontDownloadQueue*</b> Pointer to the download queue interface on which the BeginDownload
    ///                    method was called.
    ///    context = Type: <b>IUnknown*</b> Optional context object that was passed to BeginDownload. AddRef is called on the
    ///              context object by BeginDownload and Release is called after the DownloadCompleted method returns.
    ///    downloadResult = Type: <b>HRESULT</b> Result of the download operation.
    void DownloadCompleted(IDWriteFontDownloadQueue downloadQueue, IUnknown context, HRESULT downloadResult);
}

///Interface that enqueues download requests for remote fonts, characters, glyphs, and font fragments. Provides methods
///to asynchronously execute a download, cancel pending downloads, and be notified of download completion. Callbacks to
///listeners will occur on the downloading thread, and objects must be must be able to handle calls on their methods
///from other threads at any time.
@GUID("B71E6052-5AEA-4FA3-832E-F60D431F7E91")
interface IDWriteFontDownloadQueue : IUnknown
{
    ///Registers a client-defined listener object that receives download notifications. All registered listener's
    ///DownloadCompleted will be called after BeginDownloadcompletes.
    ///Params:
    ///    listener = Type: <b>IDWriteFontDownloadListener*</b> Listener object to add.
    ///    token = Type: <b>UINT32*</b> Receives a token value, which the caller must subsequently pass to RemoveListener.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AddListener(IDWriteFontDownloadListener listener, uint* token);
    ///Unregisters a notification handler that was previously registered using AddListener.
    ///Params:
    ///    token = Type: <b>UINT32</b> Token value previously returned by AddListener.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT RemoveListener(uint token);
    ///Determines whether the download queue is empty. Note that the queue does not include requests that are already
    ///being downloaded. Calling BeginDownloadclears the queue.
    ///Returns:
    ///    Type: <b>BOOL</b> TRUE if the queue is empty, FALSE if there are requests pending for BeginDownload.
    ///    
    BOOL    IsEmpty();
    ///Begins an asynchronous download operation. The download operation executes in the background until it completes
    ///or is cancelled by a CancelDownload call.
    ///Params:
    ///    context = Type: <b>IUnknown*</b> Optional context object that is passed back to the download notification handler's
    ///              DownloadCompleted method. If the context object implements IDWriteFontDownloadListener, its DownloadCompleted
    ///              will be called when done.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns S_OK if a download was successfully begun, S_FALSE if the queue was empty, or a
    ///    standard HRESULT error code.
    ///    
    HRESULT BeginDownload(IUnknown context);
    ///Removes all download requests from the queue and cancels any active download operations.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CancelDownload();
    ///Gets the current generation number of the download queue, which is incremented every time after a download
    ///completes, whether failed or successful. This cookie value can be compared against cached data to determine if it
    ///is stale.
    ///Returns:
    ///    Type: <b>UINT64</b> The current generation number of the download queue.
    ///    
    ulong   GetGenerationCount();
}

///Provides interoperability with GDI, such as methods to convert a font face to a LOGFONT structure, or to convert a
///GDI font description into a font face. It is also used to create bitmap render target objects.
@GUID("4556BE70-3ABD-4F70-90BE-421780A6F515")
interface IDWriteGdiInterop1 : IDWriteGdiInterop
{
    ///Creates a font object that matches the properties specified by the LOGFONT structure.
    ///Params:
    ///    logFont = Type: <b>LOGFONTW</b> Structure containing a GDI-compatible font description.
    ///    fontCollection = Type: <b>IDWriteFontCollection*</b> The font collection to search. If NULL, the local system font collection
    ///                     is used.
    ///    font = Type: <b>IDWriteFont**</b> Receives a newly created font object if successful, or NULL in case of error.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateFontFromLOGFONT(const(LOGFONTW)* logFont, IDWriteFontCollection fontCollection, 
                                  IDWriteFont* font);
    HRESULT GetFontSignature(IDWriteFont font, FONTSIGNATURE* fontSignature);
    HRESULT GetFontSignature(IDWriteFontFace fontFace, FONTSIGNATURE* fontSignature);
    ///Gets a list of matching fonts based on the specified LOGFONT values. Only fonts of that family name will be
    ///returned.
    ///Params:
    ///    logFont = Type: <b>LOGFONT</b> Structure containing a GDI-compatible font description.
    ///    fontSet = Type: <b>IDWriteFontSet*</b> The font set to search.
    ///    filteredSet = Type: <b>IDWriteFontSet**</b> &gt;Receives the filtered font set if successful.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetMatchingFontsByLOGFONT(const(LOGFONTA)* logFont, IDWriteFontSet fontSet, 
                                      IDWriteFontSet* filteredSet);
}

///Describes the font and paragraph properties used to format text, and it describes locale information.
@GUID("F67E0EDD-9E3D-4ECC-8C32-4183253DFE70")
interface IDWriteTextFormat2 : IDWriteTextFormat1
{
    ///Set line spacing.
    ///Params:
    ///    lineSpacingOptions = Type: <b>const DWRITE_LINE_SPACING*</b> How to manage space between lines.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetLineSpacing(const(DWRITE_LINE_SPACING)* lineSpacingOptions);
    ///Gets the line spacing adjustment set for a multiline text paragraph.
    ///Params:
    ///    lineSpacingOptions = Type: <b>DWRITE_LINE_SPACING*</b> A structure describing how the space between lines is managed for the
    ///                         paragraph.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetLineSpacing(DWRITE_LINE_SPACING* lineSpacingOptions);
}

///Represents a block of text after it has been fully analyzed and formatted.
@GUID("07DDCD52-020E-4DE8-AC33-6C953D83F92D")
interface IDWriteTextLayout3 : IDWriteTextLayout2
{
    ///Invalidates the layout, forcing layout to remeasure before calling the metrics or drawing functions. This is
    ///useful if the locality of a font changes, and layout should be redrawn, or if the size of a client implemented
    ///IDWriteInlineObject changes.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT InvalidateLayout();
    ///Set line spacing.
    ///Params:
    ///    lineSpacingOptions = How to manage space between lines.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetLineSpacing(const(DWRITE_LINE_SPACING)* lineSpacingOptions);
    ///Gets line spacing information.
    ///Params:
    ///    lineSpacingOptions = How to manage space between lines.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetLineSpacing(DWRITE_LINE_SPACING* lineSpacingOptions);
    ///Retrieves properties of each line.
    ///Params:
    ///    lineMetrics = The array to fill with line information.
    ///    maxLineCount = The maximum size of the lineMetrics array.
    ///    actualLineCount = The actual size of the lineMetrics array that is needed.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetLineMetrics(DWRITE_LINE_METRICS1* lineMetrics, uint maxLineCount, uint* actualLineCount);
}

///Enumerator for an ordered collection of color glyph runs.
@GUID("7C5F86DA-C7A1-4F05-B8E1-55A179FE5A35")
interface IDWriteColorGlyphRunEnumerator1 : IDWriteColorGlyphRunEnumerator
{
    ///Gets the current color glyph run.
    ///Params:
    ///    colorGlyphRun = Type: <b>DWRITE_COLOR_GLYPH_RUN1</b> Receives a pointer to the color glyph run. The pointer remains valid
    ///                    until the next call to MoveNext or until the interface is released.
    ///Returns:
    ///    Type: <b>HRESULT</b> Standard HRESULT error code. An error is returned if there is no current glyph run,
    ///    i.e., if MoveNext has not yet been called or if the end of the sequence has been reached.
    ///    
    HRESULT GetCurrentRun(const(DWRITE_COLOR_GLYPH_RUN1)** colorGlyphRun);
}

///Represents an absolute reference to a font face. This interface contains font face type, appropriate file references,
///and face identification data. This interface extends [IDWriteFontFace3](./nn-dwrite_3-idwritefontface3.md). Various
///font data such as metrics, names, and glyph outlines are obtained from **IDWriteFontFace**.
@GUID("27F2A904-4EB8-441D-9678-0563F53E3E2F")
interface IDWriteFontFace4 : IDWriteFontFace3
{
    ///Gets all the glyph image formats supported by the entire font.
    ///Returns:
    ///    Type: <b>DWRITE_GLYPH_IMAGE_FORMATS</b> Returns all the glyph image formats supported by the entire font.
    ///    
    DWRITE_GLYPH_IMAGE_FORMATS GetGlyphImageFormats();
    ///Gets all the glyph image formats supported by the entire font.
    ///Returns:
    ///    Type: <b>DWRITE_GLYPH_IMAGE_FORMATS</b> Returns all the glyph image formats supported by the entire font.
    ///    
    HRESULT GetGlyphImageFormats(ushort glyphId, uint pixelsPerEmFirst, uint pixelsPerEmLast, 
                                 DWRITE_GLYPH_IMAGE_FORMATS* glyphImageFormats);
    ///Gets a pointer to the glyph data based on the desired image format.
    ///Params:
    ///    glyphId = Type: <b>UINT16</b> The ID of the glyph to retrieve image data for.
    ///    pixelsPerEm = Type: <b>UINT32</b> Requested pixels per em.
    ///    glyphImageFormat = Type: <b>DWRITE_GLYPH_IMAGE_FORMATS</b> Specifies which formats are supported in the font.
    ///    glyphData = Type: <b>DWRITE_GLYPH_IMAGE_DATA*</b> On return contains data for a glyph.
    ///    glyphDataContext = Type: <b>void**</b>
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns S_OK. Otherwise, it returns an HRESULT error code.
    ///    
    HRESULT GetGlyphImageData(ushort glyphId, uint pixelsPerEm, DWRITE_GLYPH_IMAGE_FORMATS glyphImageFormat, 
                              DWRITE_GLYPH_IMAGE_DATA* glyphData, void** glyphDataContext);
    ///Releases the table data obtained from ReadGlyphData.
    ///Params:
    ///    glyphDataContext = Type: <b>void*</b> Opaque context from ReadGlyphData.
    void    ReleaseGlyphImageData(void* glyphDataContext);
}

///The root factory interface for all DirectWrite objects.
@GUID("4B0B5BD3-0797-4549-8AC5-FE915CC53856")
interface IDWriteFactory4 : IDWriteFactory3
{
    ///Translates a glyph run to a sequence of color glyph runs, which can be rendered to produce a color representation
    ///of the original "base" run.
    ///Params:
    ///    baselineOrigin = Type: <b>D2D1_POINT_2F</b> Horizontal and vertical origin of the base glyph run in pre-transform coordinates.
    ///    glyphRun = Type: <b>DWRITE_GLYPH_RUN</b> Pointer to the original "base" glyph run.
    ///    glyphRunDescription = Type: <b>DWRITE_GLYPH_RUN_DESCRIPTION</b> Optional glyph run description.
    ///    desiredGlyphImageFormats = Type: <b>DWRITE_GLYPH_IMAGE_FORMATS</b> Which data formats the runs should be split into.
    ///    measuringMode = Type: <b>DWRITE_MEASURING_MODE</b> Measuring mode, needed to compute the origins of each glyph.
    ///    worldAndDpiTransform = Type: <b>DWRITE_MATRIX</b> Matrix converting from the client's coordinate space to device coordinates
    ///                           (pixels), i.e., the world transform multiplied by any DPI scaling.
    ///    colorPaletteIndex = Type: <b>UINT32</b> Zero-based index of the color palette to use. Valid indices are less than the number of
    ///                        palettes in the font, as returned by IDWriteFontFace2::GetColorPaletteCount.
    ///    colorLayers = Type: <b>IDWriteColorGlyphRunEnumerator1**</b> If the function succeeds, receives a pointer to an enumerator
    ///                  object that can be used to obtain the color glyph runs. If the base run has no color glyphs, then the output
    ///                  pointer is NULL and the method returns DWRITE_E_NOCOLOR.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns DWRITE_E_NOCOLOR if the font has no color information, the glyph run does not
    ///    contain any color glyphs, or the specified color palette index is out of range. In this case, the client
    ///    should render the original glyph run. Otherwise, returns a standard HRESULT error code.
    ///    
    HRESULT TranslateColorGlyphRun(D2D_POINT_2F baselineOrigin, const(DWRITE_GLYPH_RUN)* glyphRun, 
                                   const(DWRITE_GLYPH_RUN_DESCRIPTION)* glyphRunDescription, 
                                   DWRITE_GLYPH_IMAGE_FORMATS desiredGlyphImageFormats, 
                                   DWRITE_MEASURING_MODE measuringMode, const(DWRITE_MATRIX)* worldAndDpiTransform, 
                                   uint colorPaletteIndex, IDWriteColorGlyphRunEnumerator1* colorLayers);
    HRESULT ComputeGlyphOrigins(const(DWRITE_GLYPH_RUN)* glyphRun, DWRITE_MEASURING_MODE measuringMode, 
                                D2D_POINT_2F baselineOrigin, const(DWRITE_MATRIX)* worldAndDpiTransform, 
                                D2D_POINT_2F* glyphOrigins);
    HRESULT ComputeGlyphOrigins(const(DWRITE_GLYPH_RUN)* glyphRun, D2D_POINT_2F baselineOrigin, 
                                D2D_POINT_2F* glyphOrigins);
}

///Contains methods for building a font set.
@GUID("3FF7715F-3CDC-4DC6-9B72-EC5621DCCAFD")
interface IDWriteFontSetBuilder1 : IDWriteFontSetBuilder
{
    ///Adds references to all the fonts in the specified font file. The method parses the font file to determine the
    ///fonts and their properties.
    ///Params:
    ///    fontFile = Type: <b>IDWriteFontFile*</b> Font file reference object to add to the set. If the file is not a supported
    ///               OpenType font file, then a DWRITE_E_FILEFORMAT error will be returned.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code.
    ///    
    HRESULT AddFontFile(IDWriteFontFile fontFile);
}

///Represents the result of an asynchronous operation. A client can use the interface to wait for the operation to
///complete and to get the result.
@GUID("CE25F8FD-863B-4D13-9651-C1F88DC73FE2")
interface IDWriteAsyncResult : IUnknown
{
    ///Returns a handle that can be used to wait for the asynchronous operation to complete. The handle remains valid
    ///until the interface is released.
    ///Returns:
    ///    Type: <b>HANDLE</b> Returns a handle that can be used to wait for the asynchronous operation to complete. The
    ///    handle remains valid until the interface is released.
    ///    
    HANDLE  GetWaitHandle();
    ///Returns the result of the asynchronous operation. The return value is E_PENDING if the operation has not yet
    ///completed.
    ///Returns:
    ///    Type: <b>HRESULT</b> Returns the result of the asynchronous operation. The return value is E_PENDING if the
    ///    operation has not yet completed.
    ///    
    HRESULT GetResult();
}

///Represents a font file stream, parts of which may be non-local. Non-local data must be downloaded before it can be
///accessed using ReadFragment. The interface exposes methods to download font data and query the locality of font data.
@GUID("4DB3757A-2C72-4ED9-B2B6-1ABABE1AFF9C")
interface IDWriteRemoteFontFileStream : IDWriteFontFileStream
{
    ///GetLocalFileSize returns the number of bytes of the font file that are currently local, which should always be
    ///less than or equal to the full file size returned by GetFileSize. If the locality is remote, the return value is
    ///zero. If the file is fully local, the return value must be the same as GetFileSize.
    ///Params:
    ///    localFileSize = Type: <b>UINT64*</b> Receives the local size of the file.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code.
    ///    
    HRESULT GetLocalFileSize(ulong* localFileSize);
    ///Returns information about the locality of a byte range (i.e., font fragment) within the font file stream.
    ///Params:
    ///    fileOffset = Type: <b>UINT64</b> Offset of the fragment from the beginning of the font file.
    ///    fragmentSize = Type: <b>UINT64</b> Size of the fragment in bytes.
    ///    isLocal = Type: <b>BOOL*</b> Receives TRUE if the first byte of the fragment is local, FALSE if not.
    ///    partialSize = Type: <b>UINT64*</b> Receives the number of contiguous bytes from the start of the fragment that have the
    ///                  same locality as the first byte.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code.
    ///    
    HRESULT GetFileFragmentLocality(ulong fileOffset, ulong fragmentSize, BOOL* isLocal, ulong* partialSize);
    ///Gets the current locality of the file.
    ///Returns:
    ///    Type: <b>DWRITE_LOCALITY</b> Returns the current locality (i.e., remote, partial, or local).
    ///    
    DWRITE_LOCALITY GetLocality();
    ///Begins downloading all or part of the font file.
    ///Params:
    ///    downloadOperationID = Type: <b>UUID</b>
    ///    fileFragments = Type: <b>DWRITE_FILE_FRAGMENT</b> Array of structures, each specifying a byte range to download.
    ///    fragmentCount = Type: <b>UINT32</b> Number of elements in the fileFragments array. This can be zero to just download file
    ///                    information, such as the size.
    ///    asyncResult = Type: <b>_COM_Outptr_result_maybenull_</b> Receives an object that can be used to wait for the asynchronous
    ///                  download to complete and to get the download result upon completion. The result may be NULL if the download
    ///                  completes synchronously. For example, this can happen if method determines that the requested data is already
    ///                  local.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code.
    ///    
    HRESULT BeginDownload(const(GUID)* downloadOperationID, const(DWRITE_FILE_FRAGMENT)* fileFragments, 
                          uint fragmentCount, IDWriteAsyncResult* asyncResult);
}

///Represents a font file loader that can access remote (i.e., downloadable) fonts. The
///IDWriteFactory5::CreateHttpFontFileLoader method returns an instance of this interface, which the client can use to
///load remote fonts without having to implement a custom loader. A client can also create its own custom
///implementation, however. In either case, the client is responsible for registering and unregistering the loader using
///IDWriteFactory::RegisterFontFileLoader and IDWriteFactory::UnregisterFontFileLoader.
@GUID("68648C83-6EDE-46C0-AB46-20083A887FDE")
interface IDWriteRemoteFontFileLoader : IDWriteFontFileLoader
{
    ///Creates a remote font file stream object that encapsulates an open file resource and can be used to download
    ///remote file data.
    ///Params:
    ///    fontFileReferenceKey = Type: <b>void</b> Font file reference key that uniquely identifies the font file resource within the scope of
    ///                           the font loader being used.
    ///    fontFileReferenceKeySize = Type: <b>UINT32</b> Size of font file reference key in bytes.
    ///    fontFileStream = Type: <b>IDWriteRemoteFontFileStream**</b> Pointer to the newly created font file stream.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code.
    ///    
    HRESULT CreateRemoteStreamFromKey(const(void)* fontFileReferenceKey, uint fontFileReferenceKeySize, 
                                      IDWriteRemoteFontFileStream* fontFileStream);
    ///Gets the locality of the file resource identified by the unique key.
    ///Params:
    ///    fontFileReferenceKey = Type: <b>void</b> Font file reference key that uniquely identifies the font file resource within the scope of
    ///                           the font loader being used.
    ///    fontFileReferenceKeySize = Type: <b>UINT32</b> Size of font file reference key in bytes.
    ///    locality = Type: <b>DWRITE_LOCALITY*</b> Locality of the file.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code.
    ///    
    HRESULT GetLocalityFromKey(const(void)* fontFileReferenceKey, uint fontFileReferenceKeySize, 
                               DWRITE_LOCALITY* locality);
    ///Creates a font file reference from a URL if the loader supports this capability.
    ///Params:
    ///    factory = Type: <b>IDWriteFactory*</b> Factory used to create the font file reference.
    ///    baseUrl = Type: <b>WCHAR</b> Optional base URL. The base URL is used to resolve the fontFileUrl if it is relative. For
    ///              example, the baseUrl might be the URL of the referring document that contained the fontFileUrl.
    ///    fontFileUrl = Type: <b>WCHAR</b> URL of the font resource.
    ///    fontFile = Type: <b>IDWriteFontFile**</b> Receives a pointer to the newly created font file reference.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code.
    ///    
    HRESULT CreateFontFileReferenceFromUrl(IDWriteFactory factory, const(PWSTR) baseUrl, const(PWSTR) fontFileUrl, 
                                           IDWriteFontFile* fontFile);
}

///Represents a font file loader that can access in-memory fonts. The IDWriteFactory5::CreateInMemoryFontFileLoader
///method returns an instance of this interface, which the client can use to load in-memory fonts without having to
///implement a custom loader. A client can also create its own custom implementation, however. In either case, the
///client is responsible for registering and unregistering the loader using IDWriteFactory::RegisterFontFileLoader and
///IDWriteFactory::UnregisterFontFileLoader.
@GUID("DC102F47-A12D-4B1C-822D-9E117E33043F")
interface IDWriteInMemoryFontFileLoader : IDWriteFontFileLoader
{
    ///Creates a font file reference (IDWriteFontFile object) from an array of bytes. The font file reference is bound
    ///to the IDWriteInMemoryFontFileLoader instance with which it was created and remains valid for as long as that
    ///loader is registered with the factory.
    ///Params:
    ///    factory = Type: <b>IDWriteFactory*</b> Factory object used to create the font file reference.
    ///    fontData = Type: <b>void const*</b> Pointer to a memory block containing the font data.
    ///    fontDataSize = Type: <b>UINT32</b> Size of the font data.
    ///    ownerObject = Type: <b>IUnknown*</b> Optional object that owns the memory specified by the fontData parameter. If this
    ///                  parameter is not NULL, the method stores a pointer to the font data and adds a reference to the owner object.
    ///                  The fontData pointer must remain valid until the owner object is released. If this parameter is NULL, the
    ///                  method makes a copy of the font data.
    ///    fontFile = Type: <b>IDWriteFontFile**</b> Receives a pointer to the newly-created font file reference.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code.
    ///    
    HRESULT CreateInMemoryFontFileReference(IDWriteFactory factory, const(void)* fontData, uint fontDataSize, 
                                            IUnknown ownerObject, IDWriteFontFile* fontFile);
    ///Returns the number of font file references that have been created using this loader instance.
    ///Returns:
    ///    Type: <b>UINT32</b> Returns the number of font file references that have been created using this loader
    ///    instance.
    ///    
    uint    GetFileCount();
}

///The root factory interface for all DirectWrite objects.
@GUID("958DB99A-BE2A-4F09-AF7D-65189803D1D3")
interface IDWriteFactory5 : IDWriteFactory4
{
    ///Creates an empty font set builder to add font face references and create a custom font set.
    ///Params:
    ///    fontSetBuilder = Type: <b>IDWriteFontSetBuilder1**</b> Holds the newly created font set builder object, or NULL in case of
    ///                     failure.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code.
    ///    
    HRESULT CreateFontSetBuilder(IDWriteFontSetBuilder1* fontSetBuilder);
    ///Creates a loader object that can be used to create font file references to in-memory fonts. The caller is
    ///responsible for registering and unregistering the loader.
    ///Params:
    ///    newLoader = Type: <b>IDWriteInMemoryFontFileLoader**</b> Receives a pointer to the newly-created loader object.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an HRESULT success or error code.
    ///    
    HRESULT CreateInMemoryFontFileLoader(IDWriteInMemoryFontFileLoader* newLoader);
    ///Creates a remote font file loader that can create font file references from HTTP or HTTPS URLs. The caller is
    ///responsible for registering and unregistering the loader.
    ///Params:
    ///    referrerUrl = Type: <b>wchar_t const*</b> Optional referrer URL for HTTP requests.
    ///    extraHeaders = Type: <b>wchar_t const*</b> Optional additional header fields to include in HTTP requests. Each header field
    ///                   consists of a name followed by a colon (":") and the field value, as specified by RFC 2616. Multiple header
    ///                   fields may be separated by newlines.
    ///    newLoader = Type: <b>IDWriteRemoteFontFileLoader**</b> Receives a pointer to the newly-created loader object.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns an **HRESULT** success or error code.
    ///    
    HRESULT CreateHttpFontFileLoader(const(PWSTR) referrerUrl, const(PWSTR) extraHeaders, 
                                     IDWriteRemoteFontFileLoader* newLoader);
    ///The AnalyzeContainerType method analyzes the specified file data to determine whether it is a known font
    ///container format (e.g., WOFF or WOFF2).
    ///Params:
    ///    fileData = Type: <b>void</b> Pointer to the file data to analyze.
    ///    fileDataSize = Type: <b>UINT32</b> Size of the buffer passed in fileData.
    ///Returns:
    ///    Type: <b>DWRITE_CONTAINER_TYPE</b> Returns the container type if recognized. DWRITE_CONTAINER_TYPE_UNKOWNN is
    ///    returned for all other files, including uncompressed font files.
    ///    
    DWRITE_CONTAINER_TYPE AnalyzeContainerType(const(void)* fileData, uint fileDataSize);
    ///The UnpackFontFile method unpacks font data from a container file (WOFF or WOFF2) and returns the unpacked font
    ///data in the form of a font file stream.
    ///Params:
    ///    containerType = Type: <b>DWRITE_CONTAINER_TYPE</b> Container type returned by AnalyzeContainerType.
    ///    fileData = Type: <b>void</b> Pointer to the compressed data.
    ///    fileDataSize = Type: <b>UINT32</b> Size of the compressed data, in bytes.
    ///    unpackedFontStream = Type: <b>IDWriteFontFileStream**</b> Receives a pointer to a newly created font file stream containing the
    ///                         uncompressed data.
    ///Returns:
    ///    Type: <b>HRESULT</b> Standard HRESULT error code. The return value is E_INVALIDARG if the container type is
    ///    DWRITE_CONTAINER_TYPE_UNKNOWN.
    ///    
    HRESULT UnpackFontFile(DWRITE_CONTAINER_TYPE containerType, const(void)* fileData, uint fileDataSize, 
                           IDWriteFontFileStream* unpackedFontStream);
}

///This interface represents a factory object from which all DirectWrite objects are created. **IDWriteFactory6** adds
///new facilities for working with fonts and font resources. This interface extends
///[IDWriteFactory5](./nn-dwrite_3-idwritefactory5.md).
@GUID("F3744D80-21F7-42EB-B35D-995BC72FC223")
interface IDWriteFactory6 : IDWriteFactory5
{
    ///Creates a reference to a specific font instance within a file.
    ///Params:
    ///    fontFile = Type: **[IDWriteFontFile](../dwrite/nn-dwrite-idwritefontfile.md)\*** A user-provided font file representing
    ///               the font face.
    ///    faceIndex = Type: **[UINT32](/windows/win32/winprog/windows-data-types)** The zero-based index of a font face in cases
    ///                when the font file contains a collection of font faces. If the font file contains a single face, then set
    ///                this value to zero.
    ///    fontSimulations = Type: **[DWRITE_FONT_SIMULATIONS](../dwrite/ne-dwrite-dwrite_font_simulations.md)** Font face simulation
    ///                      flags for algorithmic emboldening and italicization.
    ///    fontAxisValues = Type: **[DWRITE_FONT_AXIS_VALUE](./ns-dwrite_3-dwrite_font_axis_value.md) const \*** A pointer to an array
    ///                     containing a list of font axis values. The array should be the size (the number of elements) indicated by the
    ///                     *fontAxisValueCount* argument.
    ///    fontAxisValueCount = Type: **[UINT32](/windows/win32/winprog/windows-data-types)** The number of font axis values contained in the
    ///                         *fontAxisValues* array.
    ///    fontFaceReference = Type: **[IDWriteFontFaceReference1](./nn-dwrite_3-idwritefontfacereference1.md)\*\*** The address of a
    ///                        pointer to an [IDWriteFontFaceReference1](./nn-dwrite_3-idwritefontfacereference1.md) interface. On
    ///                        successful completion, the function sets the pointer to a newly created font face reference object, otherwise
    ///                        it sets the pointer to `nullptr`.
    ///Returns:
    ///    Type: **[HRESULT](/windows/win32/com/structure-of-com-error-codes)** If the function succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an [**HRESULT**](/windows/win32/com/structure-of-com-error-codes) [error
    ///    code](/windows/win32/com/com-error-codes-10).
    ///    
    HRESULT CreateFontFaceReference(IDWriteFontFile fontFile, uint faceIndex, 
                                    DWRITE_FONT_SIMULATIONS fontSimulations, 
                                    const(DWRITE_FONT_AXIS_VALUE)* fontAxisValues, uint fontAxisValueCount, 
                                    IDWriteFontFaceReference1* fontFaceReference);
    ///Creates a font resource, given a font file and a face index.
    ///Params:
    ///    fontFile = Type: **[IDWriteFontFile](../dwrite/nn-dwrite-idwritefontfile.md)\*** A user-provided font file representing
    ///               the font face.
    ///    faceIndex = Type: **[UINT32](/windows/win32/winprog/windows-data-types)** The zero-based index of a font face in cases
    ///                when the font file contains a collection of font faces. If the font file contains a single face, then set
    ///                this value to zero.
    ///    fontResource = Type: **[IDWriteFontResource](./nn-dwrite_3-idwritefontresource.md)\*\*** The address of a pointer to an
    ///                   [IDWriteFontResource](./nn-dwrite_3-idwritefontresource.md) interface. On successful completion, the function
    ///                   sets the pointer to a newly created font resource object, otherwise it sets the pointer to `nullptr`.
    ///Returns:
    ///    Type: **[HRESULT](/windows/win32/com/structure-of-com-error-codes)** If the function succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an [**HRESULT**](/windows/win32/com/structure-of-com-error-codes) [error
    ///    code](/windows/win32/com/com-error-codes-10).
    ///    
    HRESULT CreateFontResource(IDWriteFontFile fontFile, uint faceIndex, IDWriteFontResource* fontResource);
    ///Retrieves the set of system fonts.
    ///Params:
    ///    includeDownloadableFonts = Type: **[BOOL](/windows/win32/winprog/windows-data-types)** `true` if you want to include downloadable fonts.
    ///                               `false` if you only want locally installed fonts.
    ///    fontSet = Type: **[IDWriteFontSet1](./nn-dwrite_3-idwritefontset1.md)\*\*** The address of a pointer to an
    ///              [IDWriteFontSet1](./nn-dwrite_3-idwritefontset1.md) interface. On successful completion, the function sets
    ///              the pointer to the font set object, otherwise it sets the pointer to `nullptr`.
    ///Returns:
    ///    Type: **[HRESULT](/windows/win32/com/structure-of-com-error-codes)** If the function succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an [**HRESULT**](/windows/win32/com/structure-of-com-error-codes) [error
    ///    code](/windows/win32/com/com-error-codes-10).
    ///    
    HRESULT GetSystemFontSet(BOOL includeDownloadableFonts, IDWriteFontSet1* fontSet);
    ///Retrieves a collection of fonts, grouped into families.
    ///Params:
    ///    includeDownloadableFonts = Type: **[BOOL](/windows/win32/winprog/windows-data-types)** `true` if you want to include downloadable fonts.
    ///                               `false` if you only want locally installed fonts.
    ///    fontFamilyModel = Type: **[DWRITE_FONT_FAMILY_MODEL](./ne-dwrite_3-dwrite_font_family_model.md)** How to group families in the
    ///                      collection.
    ///    fontCollection = Type: **[IDWriteFontCollection2](./nn-dwrite_3-idwritefontcollection2.md)\*\*** The address of a pointer to
    ///                     an [IDWriteFontCollection2](./nn-dwrite_3-idwritefontcollection2.md) interface. On successful completion, the
    ///                     function sets the pointer to a newly created font collection object, otherwise it sets the pointer to
    ///                     `nullptr`.
    ///Returns:
    ///    Type: **[HRESULT](/windows/win32/com/structure-of-com-error-codes)** If the function succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an [**HRESULT**](/windows/win32/com/structure-of-com-error-codes) [error
    ///    code](/windows/win32/com/com-error-codes-10).
    ///    
    HRESULT GetSystemFontCollection(BOOL includeDownloadableFonts, DWRITE_FONT_FAMILY_MODEL fontFamilyModel, 
                                    IDWriteFontCollection2* fontCollection);
    ///From a font set, create a collection of fonts grouped into families.
    ///Params:
    ///    fontSet = Type: **[IDWriteFontSet](./nn-dwrite_3-idwritefontset.md)\*** A set of fonts to use to build the collection.
    ///    fontFamilyModel = Type: **[DWRITE_FONT_FAMILY_MODEL](./ne-dwrite_3-dwrite_font_family_model.md)** How to group families in the
    ///                      collection.
    ///    fontCollection = Type: **[IDWriteFontCollection2](./nn-dwrite_3-idwritefontcollection2.md)\*\*** The address of a pointer to
    ///                     an [IDWriteFontCollection2](./nn-dwrite_3-idwritefontcollection2.md) interface. On successful completion, the
    ///                     function sets the pointer to a newly created font collection object, otherwise it sets the pointer to
    ///                     `nullptr`.
    ///Returns:
    ///    Type: **[HRESULT](/windows/win32/com/structure-of-com-error-codes)** If the function succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an [**HRESULT**](/windows/win32/com/structure-of-com-error-codes) [error
    ///    code](/windows/win32/com/com-error-codes-10).
    ///    
    HRESULT CreateFontCollectionFromFontSet(IDWriteFontSet fontSet, DWRITE_FONT_FAMILY_MODEL fontFamilyModel, 
                                            IDWriteFontCollection2* fontCollection);
    ///Creates an empty font set builder, ready to add font instances to, and create a custom font set.
    ///Params:
    ///    fontSetBuilder = Type: **[IDWriteFontSetBuilder2](./nn-dwrite_3-idwritefontsetbuilder2.md)\*\*** The address of a pointer to
    ///                     an [IDWriteFontSetBuilder2](./nn-dwrite_3-idwritefontsetbuilder2.md) interface. On successful completion, the
    ///                     function sets the pointer to a newly created font set builder object, otherwise it sets the pointer to
    ///                     `nullptr`.
    ///Returns:
    ///    Type: **[HRESULT](/windows/win32/com/structure-of-com-error-codes)** If the function succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an [**HRESULT**](/windows/win32/com/structure-of-com-error-codes) [error
    ///    code](/windows/win32/com/com-error-codes-10).
    ///    
    HRESULT CreateFontSetBuilder(IDWriteFontSetBuilder2* fontSetBuilder);
    ///Creates a text format object used for text layout.
    ///Params:
    ///    fontFamilyName = Type: **[WCHAR](/windows/win32/winprog/windows-data-types) const \*** Name of the font family from the
    ///                     collection.
    ///    fontCollection = Type: **[IDWriteFontCollection](../dwrite/nn-dwrite-idwritefontcollection.md)\*** Font collection. Use
    ///                     `nullptr` to indicate the system font collection.
    ///    fontAxisValues = Type: **[DWRITE_FONT_AXIS_VALUE](./ns-dwrite_3-dwrite_font_axis_value.md) const \*** A pointer to an array
    ///                     containing a list of font axis values. The array should be the size (the number of elements) indicated by the
    ///                     *fontAxisValueCount* argument.
    ///    fontAxisValueCount = Type: **[UINT32](/windows/win32/winprog/windows-data-types)** The number of font axis values contained in the
    ///                         *fontAxisValues* array.
    ///    fontSize = Type: **[FLOAT](/windows/win32/winprog/windows-data-types)** Logical size of the font in DIP units.
    ///    localeName = Type: **[WCHAR](/windows/win32/winprog/windows-data-types) const \*** Locale name (for example, "ja-JP",
    ///                 "en-US", "ar-EG").
    ///    textFormat = Type: **[IDWriteTextFormat3](./nn-dwrite_3-idwritetextformat3.md)\*\*** The address of a pointer to an
    ///                 [IDWriteTextFormat3](./nn-dwrite_3-idwritetextformat3.md) interface. On successful completion, the function
    ///                 sets the pointer to a newly created text format object, otherwise it sets the pointer to `nullptr`.
    ///Returns:
    ///    Type: **[HRESULT](/windows/win32/com/structure-of-com-error-codes)** If the function succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an [**HRESULT**](/windows/win32/com/structure-of-com-error-codes) [error
    ///    code](/windows/win32/com/com-error-codes-10).
    ///    
    HRESULT CreateTextFormat(const(PWSTR) fontFamilyName, IDWriteFontCollection fontCollection, 
                             const(DWRITE_FONT_AXIS_VALUE)* fontAxisValues, uint fontAxisValueCount, float fontSize, 
                             const(PWSTR) localeName, IDWriteTextFormat3* textFormat);
}

///Represents an absolute reference to a font face. This interface contains font face type, appropriate file references,
///and face identification data. It adds new facilities such as comparing two font faces, retrieving font axis values,
///and retrieving the underlying font resource. This interface extends
///[IDWriteFontFace4](./nn-dwrite_3-idwritefontface4.md). Various font data such as metrics, names, and glyph outlines
///are obtained from **IDWriteFontFace**.
@GUID("98EFF3A5-B667-479A-B145-E2FA5B9FDC29")
interface IDWriteFontFace5 : IDWriteFontFace4
{
    ///Retrieves the number of axes defined by the font face. This includes both static and variable axes (see
    ///[DWRITE_FONT_AXIS_RANGE](./ns-dwrite_3-dwrite_font_axis_range.md)).
    ///Returns:
    ///    Type: **[UINT32](/windows/win32/winprog/windows-data-types)** The number of axes defined by the font face.
    ///    
    uint    GetFontAxisValueCount();
    ///Retrieves the list of axis values used by the font.
    ///Params:
    ///    fontAxisValues = Type: **[DWRITE_FONT_AXIS_VALUE](./ns-dwrite_3-dwrite_font_axis_value.md)\*** A pointer to an array of
    ///                     **DWRITE_FONT_AXIS_VALUE** structures into which **GetFontAxisValues** writes the list of font axis values.
    ///                     You're responsible for managing the size and the lifetime of this array. Call
    ///                     [GetFontAxisValueCount](./nf-dwrite_3-idwritefontface5-getfontaxisvaluecount.md) to determine the size of
    ///                     array to allocate.
    ///    fontAxisValueCount = Type: **[UINT32](/windows/win32/winprog/windows-data-types)** The maximum number of font axis values to write
    ///                         into the memory block pointed to by `fontAxisValues`.
    ///Returns:
    ///    Type: **[HRESULT](/windows/win32/com/structure-of-com-error-codes)** If the function succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an [**HRESULT**](/windows/win32/com/structure-of-com-error-codes) [error
    ///    code](/windows/win32/com/com-error-codes-10). |Return value|Description| |-|-|
    ///    |E_INVALIDARG|`fontAxisValueCount` doesn't match the value returned by **GetFontAxisValueCount**.|
    ///    
    HRESULT GetFontAxisValues(DWRITE_FONT_AXIS_VALUE* fontAxisValues, uint fontAxisValueCount);
    ///Determines whether this font face's resource supports any variable axes. When `true`, at least one
    ///[DWRITE_FONT_AXIS_RANGE](./ns-dwrite_3-dwrite_font_axis_range.md) in the font resource has a non-empty range
    ///(*maxValue* > *minValue*).
    ///Returns:
    ///    Type: **[BOOL](/windows/win32/winprog/windows-data-types)** `true` if the font face's resource supports any
    ///    variable axes. Otherwise, `false`.
    ///    
    BOOL    HasVariations();
    ///Retrieves the underlying font resource for this font face. You can use that to query information about the
    ///resource, or to recreate a new font face instance with different axis values.
    ///Params:
    ///    fontResource = Type: **[IDWriteFontResource](./nn-dwrite_3-idwritefontresource.md)\*\*** The address of a pointer to an
    ///                   [IDWriteFontResource](./nn-dwrite_3-idwritefontresource.md) interface. On successful completion, the function
    ///                   sets the pointer to a newly created font resource object.
    ///Returns:
    ///    Type: **[HRESULT](/windows/win32/com/structure-of-com-error-codes)** If the function succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an [**HRESULT**](/windows/win32/com/structure-of-com-error-codes) [error
    ///    code](/windows/win32/com/com-error-codes-10).
    ///    
    HRESULT GetFontResource(IDWriteFontResource* fontResource);
    ///Performs an equality comparison between the font face object on which **Equals** is being called and the font
    ///face object passed as a parameter.
    ///Params:
    ///    fontFace = Type: **[IDWriteFontFace](../dwrite/nn-dwrite-idwritefontface.md)\*** A pointer to a font face object to
    ///               compare with the font face object on which **Equals** is being called.
    ///Returns:
    ///    Type: **[BOOL](/windows/win32/winprog/windows-data-types)** `true` if the font face objects are equal.
    ///    Otherwise, `false`.
    ///    
    BOOL    Equals(IDWriteFontFace fontFace);
}

///Provides axis information for a font resource, and is used to create specific font face instances. This interface
///extends [IUnknown](../unknwn/nn-unknwn-iunknown.md).
@GUID("1F803A76-6871-48E8-987F-B975551C50F2")
interface IDWriteFontResource : IUnknown
{
    ///Retrieves the font file of the resource.
    ///Params:
    ///    fontFile = Type: **[IDWriteFontFile](../dwrite/nn-dwrite-idwritefontfile.md)\*\*** The address of a pointer to an
    ///               [IDWriteFontFile](../dwrite/nn-dwrite-idwritefontfile.md) interface. On successful completion, the function
    ///               sets the pointer to the font file object.
    ///Returns:
    ///    Type: **[HRESULT](/windows/win32/com/structure-of-com-error-codes)** If the function succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an [**HRESULT**](/windows/win32/com/structure-of-com-error-codes) [error
    ///    code](/windows/win32/com/com-error-codes-10).
    ///    
    HRESULT GetFontFile(IDWriteFontFile* fontFile);
    ///Retrieves the zero-based index of the font face within its font file. If the font file contains a single face,
    ///then the return value is zero.
    ///Returns:
    ///    Type: **[UINT32](/windows/win32/winprog/windows-data-types)** The zero-based index of the font face within
    ///    its font file.
    ///    
    uint    GetFontFaceIndex();
    ///Retrieves the number of axes supported by the font resource. This includes both static and variable axes (see
    ///[DWRITE_FONT_AXIS_RANGE](./ns-dwrite_3-dwrite_font_axis_range.md)).
    ///Returns:
    ///    Type: **[UINT32](/windows/win32/winprog/windows-data-types)** The number of axes defined by the font face.
    ///    
    uint    GetFontAxisCount();
    ///Retrieves the default values for all axes supported by the font resource.
    ///Params:
    ///    fontAxisValues = Type: **[DWRITE_FONT_AXIS_VALUE](./ns-dwrite_3-dwrite_font_axis_value.md)\*** A pointer to an array of
    ///                     **DWRITE_FONT_AXIS_VALUE** structures into which **GetDefaultFontAxisValues** writes the list of font axis
    ///                     values. You're responsible for managing the size and the lifetime of this array. Call
    ///                     [GetFontAxisCount](./nf-dwrite_3-idwritefontresource-getfontaxiscount.md) to determine the size of array to
    ///                     allocate.
    ///    fontAxisValueCount = Type: **[UINT32](/windows/win32/winprog/windows-data-types)** The maximum number of font axis values to write
    ///                         into the memory block pointed to by `fontAxisValues`.
    ///Returns:
    ///    Type: **[HRESULT](/windows/win32/com/structure-of-com-error-codes)** If the function succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an [**HRESULT**](/windows/win32/com/structure-of-com-error-codes) [error
    ///    code](/windows/win32/com/com-error-codes-10). |Return value|Description| |-|-|
    ///    |E_INVALIDARG|`fontAxisValueCount` doesn't match the value returned by **GetFontAxisCount**.|
    ///    
    HRESULT GetDefaultFontAxisValues(DWRITE_FONT_AXIS_VALUE* fontAxisValues, uint fontAxisValueCount);
    ///Retrieves the value ranges of each axis.
    ///Params:
    ///    fontAxisRanges = Type: **[DWRITE_FONT_AXIS_RANGE](./ns-dwrite_3-dwrite_font_axis_range.md)\*** A pointer to an array of
    ///                     **DWRITE_FONT_AXIS_RANGE** structures into which **GetFontAxisRanges** writes the list of font axis value
    ///                     ranges. You're responsible for managing the size and the lifetime of this array. Call
    ///                     [GetFontAxisCount](./nf-dwrite_3-idwritefontresource-getfontaxiscount.md) to determine the size of array to
    ///                     allocate.
    ///    fontAxisRangeCount = Type: **[UINT32](/windows/win32/winprog/windows-data-types)** The maximum number of font axis value ranges to
    ///                         write into the memory block pointed to by `fontAxisRanges`.
    ///Returns:
    ///    Type: **[HRESULT](/windows/win32/com/structure-of-com-error-codes)** If the function succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an [**HRESULT**](/windows/win32/com/structure-of-com-error-codes) [error
    ///    code](/windows/win32/com/com-error-codes-10). |Return value|Description| |-|-|
    ///    |E_INVALIDARG|`fontAxisValueCount` doesn't match the value returned by **GetFontAxisCount**.|
    ///    
    HRESULT GetFontAxisRanges(DWRITE_FONT_AXIS_RANGE* fontAxisRanges, uint fontAxisRangeCount);
    ///Retrieves attributes describing the given axis, such as whether the font author recommends to hide the axis in
    ///user interfaces.
    ///Params:
    ///    axisIndex = Type: **[UINT32](/windows/win32/winprog/windows-data-types)** Font axis, from 0 to
    ///                [GetFontAxisCount](./nf-dwrite_3-idwritefontresource-getfontaxiscount.md) minus 1.
    ///Returns:
    ///    Type: **[DWRITE_FONT_AXIS_ATTRIBUTES](./ne-dwrite_3-dwrite_font_axis_attributes.md)** The attributes for the
    ///    given axis, or **DWRITE_FONT_AXIS_ATTRIBUTES_NONE** if *axisIndex* is beyond the font count.
    ///    
    DWRITE_FONT_AXIS_ATTRIBUTES GetFontAxisAttributes(uint axisIndex);
    ///Retrieves the localized names of a font axis.
    ///Params:
    ///    axisIndex = Type: **[UINT32](/windows/win32/winprog/windows-data-types)** Font axis, from 0 to
    ///                [GetFontAxisCount](./nf-dwrite_3-idwritefontresource-getfontaxiscount.md) minus 1.
    ///    names = Type: **[IDWriteLocalizedStrings](../dwrite/nn-dwrite-idwritelocalizedstrings.md)\*\*** The address of a
    ///            pointer to an [IDWriteLocalizedStrings](../dwrite/nn-dwrite-idwritelocalizedstrings.md) interface. On
    ///            successful completion, the function sets the pointer to a newly created localized strings object.
    ///Returns:
    ///    Type: **[HRESULT](/windows/win32/com/structure-of-com-error-codes)** If the function succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an [**HRESULT**](/windows/win32/com/structure-of-com-error-codes) [error
    ///    code](/windows/win32/com/com-error-codes-10).
    ///    
    HRESULT GetAxisNames(uint axisIndex, IDWriteLocalizedStrings* names);
    ///Retrieves the number of named values for a specific axis.
    ///Params:
    ///    axisIndex = Type: **[UINT32](/windows/win32/winprog/windows-data-types)** Font axis, from 0 to
    ///                [GetFontAxisCount](./nf-dwrite_3-idwritefontresource-getfontaxiscount.md) minus 1.
    ///Returns:
    ///    Type: **[UINT32](/windows/win32/winprog/windows-data-types)** The number of named values for the axis
    ///    specified by *axisIndex*.
    ///    
    uint    GetAxisValueNameCount(uint axisIndex);
    ///Retrieves the localized names of specific values for a font axis.
    ///Params:
    ///    axisIndex = Type: **[UINT32](/windows/win32/winprog/windows-data-types)** Font axis, from 0 to
    ///                [GetFontAxisCount](./nf-dwrite_3-idwritefontresource-getfontaxiscount.md) minus 1.
    ///    axisValueIndex = Type: **[UINT32](/windows/win32/winprog/windows-data-types)** Value index, from 0 to
    ///                     [GetAxisValueNameCount](./nf-dwrite_3-idwritefontresource-getaxisvaluenamecount.md) minus 1.
    ///    fontAxisRange = Type: **[DWRITE_FONT_AXIS_RANGE](./ns-dwrite_3-dwrite_font_axis_range.md)\*** Range of the named value.
    ///    names = Type: **[IDWriteLocalizedStrings](../dwrite/nn-dwrite-idwritelocalizedstrings.md)\*\*** The address of a
    ///            pointer to an [IDWriteLocalizedStrings](../dwrite/nn-dwrite-idwritelocalizedstrings.md) interface. On
    ///            successful completion, the function sets the pointer to a newly created localized strings object.
    ///Returns:
    ///    Type: **[HRESULT](/windows/win32/com/structure-of-com-error-codes)** If the function succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an [**HRESULT**](/windows/win32/com/structure-of-com-error-codes) [error
    ///    code](/windows/win32/com/com-error-codes-10).
    ///    
    HRESULT GetAxisValueNames(uint axisIndex, uint axisValueIndex, DWRITE_FONT_AXIS_RANGE* fontAxisRange, 
                              IDWriteLocalizedStrings* names);
    ///Determines whether this font face's resource supports any variable axes. When `true`, at least one
    ///[DWRITE_FONT_AXIS_RANGE](./ns-dwrite_3-dwrite_font_axis_range.md) in the font resource has a non-empty range
    ///(*maxValue* > *minValue*).
    ///Returns:
    ///    Type: **[BOOL](/windows/win32/winprog/windows-data-types)** `true` if the font face's resource supports any
    ///    variable axes. Otherwise, `false`.
    ///    
    BOOL    HasVariations();
    ///Creates a font face instance with specific axis values.
    ///Params:
    ///    fontSimulations = Type: **[DWRITE_FONT_SIMULATIONS](../dwrite/ne-dwrite-dwrite_font_simulations.md)** Font face simulation
    ///                      flags for algorithmic emboldening and italicization.
    ///    fontAxisValues = Type: **[DWRITE_FONT_AXIS_VALUE](./ns-dwrite_3-dwrite_font_axis_value.md) const \*** A pointer to an array
    ///                     containing a list of font axis values. The array should be the size (the number of elements) indicated by the
    ///                     *fontAxisValueCount* argument.
    ///    fontAxisValueCount = Type: **[UINT32](/windows/win32/winprog/windows-data-types)** The number of font axis values contained in the
    ///                         *fontAxisValues* array.
    ///    fontFace = Type: **[IDWriteFontFace5](./nn-dwrite_3-idwritefontface5.md)\*\*** The address of a pointer to an
    ///               [IDWriteFontFace5](./nn-dwrite_3-idwritefontface5.md) interface. On successful completion, the function sets
    ///               the pointer to a newly created font face object, otherwise it sets the pointer to `nullptr`.
    ///Returns:
    ///    Type: **[HRESULT](/windows/win32/com/structure-of-com-error-codes)** If the function succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an [**HRESULT**](/windows/win32/com/structure-of-com-error-codes) [error
    ///    code](/windows/win32/com/com-error-codes-10). |Return value|Description| |-|-| |DWRITE_E_REMOTEFONT|The font
    ///    is not local.|
    ///    
    HRESULT CreateFontFace(DWRITE_FONT_SIMULATIONS fontSimulations, const(DWRITE_FONT_AXIS_VALUE)* fontAxisValues, 
                           uint fontAxisValueCount, IDWriteFontFace5* fontFace);
    ///Creates a font face reference with specific axis values.
    ///Params:
    ///    fontSimulations = Type: **[DWRITE_FONT_SIMULATIONS](../dwrite/ne-dwrite-dwrite_font_simulations.md)** Font face simulation
    ///                      flags for algorithmic emboldening and italicization.
    ///    fontAxisValues = Type: **[DWRITE_FONT_AXIS_VALUE](./ns-dwrite_3-dwrite_font_axis_value.md) const \*** A pointer to an array
    ///                     containing a list of font axis values. The array should be the size (the number of elements) indicated by the
    ///                     *fontAxisValueCount* argument.
    ///    fontAxisValueCount = Type: **[UINT32](/windows/win32/winprog/windows-data-types)** The number of font axis values contained in the
    ///                         *fontAxisValues* array.
    ///    fontFaceReference = Type: **[IDWriteFontFaceReference1](./nn-dwrite_3-idwritefontfacereference1.md)\*\*** The address of a
    ///                        pointer to an [IDWriteFontFaceReference1](./nn-dwrite_3-idwritefontfacereference1.md) interface. On
    ///                        successful completion, the function sets the pointer to a newly created font face reference object, otherwise
    ///                        it sets the pointer to `nullptr`.
    ///Returns:
    ///    Type: **[HRESULT](/windows/win32/com/structure-of-com-error-codes)** If the function succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an [**HRESULT**](/windows/win32/com/structure-of-com-error-codes) [error
    ///    code](/windows/win32/com/com-error-codes-10).
    ///    
    HRESULT CreateFontFaceReference(DWRITE_FONT_SIMULATIONS fontSimulations, 
                                    const(DWRITE_FONT_AXIS_VALUE)* fontAxisValues, uint fontAxisValueCount, 
                                    IDWriteFontFaceReference1* fontFaceReference);
}

///Represents a reference to a font face. A uniquely identifying reference to a font, from which you can create a font
///face to query font metrics and use for rendering. A font face reference consists of a font file, font face index, and
///font face simulation. The file data may or may not be physically present on the local machine yet.
///**IDWriteFontFaceReference1** adds new facilities, including support for
///[IDWriteFontFace5](./nn-dwrite_3-idwritefontface5.md). This interface extends
///[IDWriteFontFaceReference](./nn-dwrite_3-idwritefontfacereference.md).
@GUID("C081FE77-2FD1-41AC-A5A3-34983C4BA61A")
interface IDWriteFontFaceReference1 : IDWriteFontFaceReference
{
    ///Uses the reference to create a font face, for use with layout, shaping, or rendering.
    ///Params:
    ///    fontFace = Type: **[IDWriteFontFace5](./nn-dwrite_3-idwritefontface5.md)\*\*** The address of a pointer to an
    ///               [IDWriteFontFace5](./nn-dwrite_3-idwritefontface5.md) interface. On successful completion, the function sets
    ///               the pointer to a newly created font face object, otherwise it sets the pointer to `nullptr`.
    ///Returns:
    ///    Type: **[HRESULT](/windows/win32/com/structure-of-com-error-codes)** If the function succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an [**HRESULT**](/windows/win32/com/structure-of-com-error-codes) [error
    ///    code](/windows/win32/com/com-error-codes-10). |Return value|Description| |-|-| |DWRITE_E_REMOTEFONT|The font
    ///    is not local.|
    ///    
    HRESULT CreateFontFace(IDWriteFontFace5* fontFace);
    ///Retrieves the number of axes specified by the reference.
    ///Returns:
    ///    Type: **[UINT32](/windows/win32/winprog/windows-data-types)** The number of axes defined by the font face.
    ///    
    uint    GetFontAxisValueCount();
    ///Retrieves the list of font axis values specified by the reference.
    ///Params:
    ///    fontAxisValues = Type: **[DWRITE_FONT_AXIS_VALUE](./ns-dwrite_3-dwrite_font_axis_value.md)\*** A pointer to an array of
    ///                     **DWRITE_FONT_AXIS_VALUE** structures into which **GetFontAxisValues** writes the list of font axis values.
    ///                     You're responsible for managing the size and the lifetime of this array. Call
    ///                     [GetFontAxisValueCount](./nf-dwrite_3-idwritefontfacereference1-getfontaxisvaluecount.md) to determine the
    ///                     size of array to allocate.
    ///    fontAxisValueCount = Type: **[UINT32](/windows/win32/winprog/windows-data-types)** The maximum number of font axis values to write
    ///                         into the memory block pointed to by `fontAxisValues`.
    ///Returns:
    ///    
    ///    
    HRESULT GetFontAxisValues(DWRITE_FONT_AXIS_VALUE* fontAxisValues, uint fontAxisValueCount);
}

///Contains methods for building a font set. This interface extends
///[IDWriteFontSetBuilder1](./nn-dwrite_3-idwritefontsetbuilder1.md).
@GUID("EE5BA612-B131-463C-8F4F-3189B9401E45")
interface IDWriteFontSetBuilder2 : IDWriteFontSetBuilder1
{
    ///Adds a font to the set being built, with the caller supplying enough information to search on and determine axis
    ///ranges, avoiding the need to open the potentially non-local font.
    ///Params:
    ///    fontFile = Type: **[IDWriteFontFile](../dwrite/nn-dwrite-idwritefontfile.md)\*** Font file reference object to add to
    ///               the set.
    ///    fontFaceIndex = Type: **[UINT32](/windows/win32/winprog/windows-data-types)** The zero-based index of a font face in a
    ///                    collection.
    ///    fontSimulations = Type: **[DWRITE_FONT_SIMULATIONS](../dwrite/ne-dwrite-dwrite_font_simulations.md)** Font face simulation
    ///                      flags for algorithmic emboldening and italicization.
    ///    fontAxisValues = Type: **[DWRITE_FONT_AXIS_VALUE](./ns-dwrite_3-dwrite_font_axis_value.md) const \*** A pointer to an array
    ///                     containing a list of font axis values. The array should be the size (the number of elements) indicated by the
    ///                     *fontAxisValueCount* argument.
    ///    fontAxisValueCount = Type: **[UINT32](/windows/win32/winprog/windows-data-types)** The number of font axis values contained in the
    ///                         *fontAxisValues* array.
    ///    fontAxisRanges = Type: **[DWRITE_FONT_AXIS_RANGE](./ns-dwrite_3-dwrite_font_axis_range.md) const \*** List of axis ranges.
    ///    fontAxisRangeCount = Type: **[UINT32](/windows/win32/winprog/windows-data-types)** Number of axis ranges.
    ///    properties = Type: **[DWRITE_FONT_PROPERTY](./ns-dwrite_3-dwrite_font_property.md) const \*** List of properties to
    ///                 associate with the reference.
    ///    propertyCount = Type: **[UINT32](/windows/win32/winprog/windows-data-types)** The number of properties defined.
    ///Returns:
    ///    Type: **[HRESULT](/windows/win32/com/structure-of-com-error-codes)** If the function succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an [**HRESULT**](/windows/win32/com/structure-of-com-error-codes) [error
    ///    code](/windows/win32/com/com-error-codes-10).
    ///    
    HRESULT AddFont(IDWriteFontFile fontFile, uint fontFaceIndex, DWRITE_FONT_SIMULATIONS fontSimulations, 
                    const(DWRITE_FONT_AXIS_VALUE)* fontAxisValues, uint fontAxisValueCount, 
                    const(DWRITE_FONT_AXIS_RANGE)* fontAxisRanges, uint fontAxisRangeCount, 
                    const(DWRITE_FONT_PROPERTY)* properties, uint propertyCount);
    ///Adds references to all the fonts in the specified font file. The method parses the font file to determine the
    ///fonts and their properties.
    ///Params:
    ///    filePath = Type: **[WCHAR](/windows/win32/winprog/windows-data-types) const \*** Absolute file path to add to the font
    ///               set.
    ///Returns:
    ///    Type: **[HRESULT](/windows/win32/com/structure-of-com-error-codes)** If the function succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an [**HRESULT**](/windows/win32/com/structure-of-com-error-codes) [error
    ///    code](/windows/win32/com/com-error-codes-10).
    ///    
    HRESULT AddFontFile(const(PWSTR) filePath);
}

///Represents a font set. This interface extends [IDWriteFontSet](./nn-dwrite_3-idwritefontset.md).
@GUID("7E9FDA85-6C92-4053-BC47-7AE3530DB4D3")
interface IDWriteFontSet1 : IDWriteFontSet
{
    ///Retrieves a matching font set based on the requested inputs, ordered so that nearer matches are earlier.
    ///Params:
    ///    fontProperty = Type: **[DWRITE_FONT_PROPERTY](./ns-dwrite_3-dwrite_font_property.md) const \*** Font property of interest,
    ///                   such as typographic family or weight/stretch/style family.
    ///    fontAxisValues = Type: **[DWRITE_FONT_AXIS_VALUE](./ns-dwrite_3-dwrite_font_axis_value.md) const \*** A pointer to an array
    ///                     containing a list of font axis values. The array should be the size (the number of elements) indicated by the
    ///                     *fontAxisValueCount* argument.
    ///    fontAxisValueCount = Type: **[UINT32](/windows/win32/winprog/windows-data-types)** The number of font axis values contained in the
    ///                         *fontAxisValues* array.
    ///    matchingFonts = Type: **[IDWriteFontSet1](./nn-dwrite_3-idwritefontset1.md)\*\*** The address of a pointer to an
    ///                    [IDWriteFontSet1](./nn-dwrite_3-idwritefontset1.md) interface. On successful completion, the function sets
    ///                    the pointer to a prioritized list of fonts that match the properties, otherwise it sets the pointer to
    ///                    `nullptr`.
    ///Returns:
    ///    Type: **[HRESULT](/windows/win32/com/structure-of-com-error-codes)** If the function succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an [**HRESULT**](/windows/win32/com/structure-of-com-error-codes) [error
    ///    code](/windows/win32/com/com-error-codes-10).
    ///    
    HRESULT GetMatchingFonts(const(DWRITE_FONT_PROPERTY)* fontProperty, 
                             const(DWRITE_FONT_AXIS_VALUE)* fontAxisValues, uint fontAxisValueCount, 
                             IDWriteFontSet1* matchingFonts);
    ///Retrieves a new font set that contains only the first occurrence of each font resource from the set.
    ///Params:
    ///    filteredFontSet = Type: **[IDWriteFontSet1](./nn-dwrite_3-idwritefontset1.md)\*\*** The address of a pointer to an
    ///                      [IDWriteFontSet1](./nn-dwrite_3-idwritefontset1.md) interface. On successful completion, the function sets
    ///                      the pointer to a new font set object consisting of single default instances from font resources, otherwise it
    ///                      sets the pointer to `nullptr`.
    ///Returns:
    ///    Type: **[HRESULT](/windows/win32/com/structure-of-com-error-codes)** If the function succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an [**HRESULT**](/windows/win32/com/structure-of-com-error-codes) [error
    ///    code](/windows/win32/com/com-error-codes-10).
    ///    
    HRESULT GetFirstFontResources(IDWriteFontSet1* filteredFontSet);
    ///Retrieves a subset of fonts, filtered by the given indices.
    ///Params:
    ///    indices = Type: **[UINT32](/windows/win32/winprog/windows-data-types) const \*** An array of indices to filter by, in
    ///              the range 0 to [IDwriteFontSet::GetFontCount](./nf-dwrite_3-idwritefontset-getfontcount.md) minus 1.
    ///    indexCount = Type: **[UINT32](/windows/win32/winprog/windows-data-types)** The number of indices.
    ///    filteredFontSet = Type: **[IDWriteFontSet1](./nn-dwrite_3-idwritefontset1.md)\*\*** The address of a pointer to an
    ///                      [IDWriteFontSet1](./nn-dwrite_3-idwritefontset1.md) interface. On successful completion, the function sets
    ///                      the pointer to an object representing the subset of fonts indicated by the given indices, otherwise it sets
    ///                      the pointer to `nullptr`.
    ///Returns:
    ///    Type: **[HRESULT](/windows/win32/com/structure-of-com-error-codes)** If the function succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an [**HRESULT**](/windows/win32/com/structure-of-com-error-codes) [error
    ///    code](/windows/win32/com/com-error-codes-10).
    ///    
    HRESULT GetFilteredFonts(const(DWRITE_FONT_PROPERTY)* properties, uint propertyCount, BOOL selectAnyProperty, 
                             IDWriteFontSet1* filteredFontSet);
    ///Retrieves a subset of fonts, filtered by the given indices.
    ///Params:
    ///    indices = Type: **[UINT32](/windows/win32/winprog/windows-data-types) const \*** An array of indices to filter by, in
    ///              the range 0 to [IDwriteFontSet::GetFontCount](./nf-dwrite_3-idwritefontset-getfontcount.md) minus 1.
    ///    indexCount = Type: **[UINT32](/windows/win32/winprog/windows-data-types)** The number of indices.
    ///    filteredFontSet = Type: **[IDWriteFontSet1](./nn-dwrite_3-idwritefontset1.md)\*\*** The address of a pointer to an
    ///                      [IDWriteFontSet1](./nn-dwrite_3-idwritefontset1.md) interface. On successful completion, the function sets
    ///                      the pointer to an object representing the subset of fonts indicated by the given indices, otherwise it sets
    ///                      the pointer to `nullptr`.
    ///Returns:
    ///    Type: **[HRESULT](/windows/win32/com/structure-of-com-error-codes)** If the function succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an [**HRESULT**](/windows/win32/com/structure-of-com-error-codes) [error
    ///    code](/windows/win32/com/com-error-codes-10).
    ///    
    HRESULT GetFilteredFonts(const(DWRITE_FONT_AXIS_RANGE)* fontAxisRanges, uint fontAxisRangeCount, 
                             BOOL selectAnyRange, IDWriteFontSet1* filteredFontSet);
    ///Retrieves a subset of fonts, filtered by the given indices.
    ///Params:
    ///    indices = Type: **[UINT32](/windows/win32/winprog/windows-data-types) const \*** An array of indices to filter by, in
    ///              the range 0 to [IDwriteFontSet::GetFontCount](./nf-dwrite_3-idwritefontset-getfontcount.md) minus 1.
    ///    indexCount = Type: **[UINT32](/windows/win32/winprog/windows-data-types)** The number of indices.
    ///    filteredFontSet = Type: **[IDWriteFontSet1](./nn-dwrite_3-idwritefontset1.md)\*\*** The address of a pointer to an
    ///                      [IDWriteFontSet1](./nn-dwrite_3-idwritefontset1.md) interface. On successful completion, the function sets
    ///                      the pointer to an object representing the subset of fonts indicated by the given indices, otherwise it sets
    ///                      the pointer to `nullptr`.
    ///Returns:
    ///    Type: **[HRESULT](/windows/win32/com/structure-of-com-error-codes)** If the function succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an [**HRESULT**](/windows/win32/com/structure-of-com-error-codes) [error
    ///    code](/windows/win32/com/com-error-codes-10).
    ///    
    HRESULT GetFilteredFonts(const(uint)* indices, uint indexCount, IDWriteFontSet1* filteredFontSet);
    ///Retrives all the item indices, filtered by the given properties.
    ///Params:
    ///    properties = Type: **[DWRITE_FONT_PROPERTY](./ns-dwrite_3-dwrite_font_property.md) const \*** List of properties to filter
    ///                 by.
    ///    propertyCount = Type: **[UINT32](/windows/win32/winprog/windows-data-types)** The number of properties to filter.
    ///    selectAnyProperty = Type: **[BOOL](/windows/win32/winprog/windows-data-types)** `true` if **GetFilteredFontIndices** should
    ///                        select any property; `false` if it should select the intersection of them all.
    ///    indices = Type: **[UINT32](/windows/win32/winprog/windows-data-types)\*** An ascending array of indices, in the range 0
    ///              to [IDwriteFontSet::GetFontCount](./nf-dwrite_3-idwritefontset-getfontcount.md) minus 1.
    ///    maxIndexCount = Type: **[UINT32](/windows/win32/winprog/windows-data-types)** The number of indices.
    ///    actualIndexCount = Type: **[UINT32](/windows/win32/winprog/windows-data-types)\*** The actual number of indices written or
    ///                       needed, in the range 0 to [IDwriteFontSet::GetFontCount](./nf-dwrite_3-idwritefontset-getfontcount.md) minus
    ///                       1.
    ///Returns:
    ///    Type: **[HRESULT](/windows/win32/com/structure-of-com-error-codes)** If the function succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an [**HRESULT**](/windows/win32/com/structure-of-com-error-codes) [error
    ///    code](/windows/win32/com/com-error-codes-10). |Return value|Description| |-|-| |E_NOT_SUFFICIENT_BUFFER|The
    ///    buffer is too small, with *actualIndexCount* set to the needed size. The *actualIndexCount* will always be <=
    ///    [IDwriteFontSet::GetFontCount](./nf-dwrite_3-idwritefontset-getfontcount.md).|
    ///    
    HRESULT GetFilteredFontIndices(const(DWRITE_FONT_PROPERTY)* properties, uint propertyCount, 
                                   BOOL selectAnyProperty, uint* indices, uint maxIndexCount, uint* actualIndexCount);
    ///Retrives all the item indices, filtered by the given properties.
    ///Params:
    ///    properties = Type: **[DWRITE_FONT_PROPERTY](./ns-dwrite_3-dwrite_font_property.md) const \*** List of properties to filter
    ///                 by.
    ///    propertyCount = Type: **[UINT32](/windows/win32/winprog/windows-data-types)** The number of properties to filter.
    ///    selectAnyProperty = Type: **[BOOL](/windows/win32/winprog/windows-data-types)** `true` if **GetFilteredFontIndices** should
    ///                        select any property; `false` if it should select the intersection of them all.
    ///    indices = Type: **[UINT32](/windows/win32/winprog/windows-data-types)\*** An ascending array of indices, in the range 0
    ///              to [IDwriteFontSet::GetFontCount](./nf-dwrite_3-idwritefontset-getfontcount.md) minus 1.
    ///    maxIndexCount = Type: **[UINT32](/windows/win32/winprog/windows-data-types)** The number of indices.
    ///    actualIndexCount = Type: **[UINT32](/windows/win32/winprog/windows-data-types)\*** The actual number of indices written or
    ///                       needed, in the range 0 to [IDwriteFontSet::GetFontCount](./nf-dwrite_3-idwritefontset-getfontcount.md) minus
    ///                       1.
    ///Returns:
    ///    Type: **[HRESULT](/windows/win32/com/structure-of-com-error-codes)** If the function succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an [**HRESULT**](/windows/win32/com/structure-of-com-error-codes) [error
    ///    code](/windows/win32/com/com-error-codes-10). |Return value|Description| |-|-| |E_NOT_SUFFICIENT_BUFFER|The
    ///    buffer is too small, with *actualIndexCount* set to the needed size. The *actualIndexCount* will always be <=
    ///    [IDwriteFontSet::GetFontCount](./nf-dwrite_3-idwritefontset-getfontcount.md).|
    ///    
    HRESULT GetFilteredFontIndices(const(DWRITE_FONT_AXIS_RANGE)* fontAxisRanges, uint fontAxisRangeCount, 
                                   BOOL selectAnyRange, uint* indices, uint maxIndexCount, uint* actualIndexCount);
    ///Retrieves all axis ranges in the font set; the union of all contained items.
    ///Params:
    ///    fontAxisRanges = Type: **[DWRITE_FONT_AXIS_RANGE](./ns-dwrite_3-dwrite_font_axis_range.md)\*** List of axis value ranges to
    ///                     retrieve.
    ///    maxFontAxisRangeCount = Type: **[UINT32](/windows/win32/winprog/windows-data-types)** The number of axis value ranges to retrieve.
    ///    actualFontAxisRangeCount = Type: **[UINT32](/windows/win32/winprog/windows-data-types)\*** The actual number of axis ranges written or
    ///                               needed.
    ///Returns:
    ///    Type: **[HRESULT](/windows/win32/com/structure-of-com-error-codes)** If the function succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an [**HRESULT**](/windows/win32/com/structure-of-com-error-codes) [error
    ///    code](/windows/win32/com/com-error-codes-10). |Return value|Description| |-|-| |E_NOT_SUFFICIENT_BUFFER|The
    ///    buffer is too small, with *actualFontAxisRangeCount* set to the needed size.|
    ///    
    HRESULT GetFontAxisRanges(DWRITE_FONT_AXIS_RANGE* fontAxisRanges, uint maxFontAxisRangeCount, 
                              uint* actualFontAxisRangeCount);
    ///Retrieves all axis ranges in the font set; the union of all contained items.
    ///Params:
    ///    fontAxisRanges = Type: **[DWRITE_FONT_AXIS_RANGE](./ns-dwrite_3-dwrite_font_axis_range.md)\*** List of axis value ranges to
    ///                     retrieve.
    ///    maxFontAxisRangeCount = Type: **[UINT32](/windows/win32/winprog/windows-data-types)** The number of axis value ranges to retrieve.
    ///    actualFontAxisRangeCount = Type: **[UINT32](/windows/win32/winprog/windows-data-types)\*** The actual number of axis ranges written or
    ///                               needed.
    ///Returns:
    ///    Type: **[HRESULT](/windows/win32/com/structure-of-com-error-codes)** If the function succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an [**HRESULT**](/windows/win32/com/structure-of-com-error-codes) [error
    ///    code](/windows/win32/com/com-error-codes-10). |Return value|Description| |-|-| |E_NOT_SUFFICIENT_BUFFER|The
    ///    buffer is too small, with *actualFontAxisRangeCount* set to the needed size.|
    ///    
    HRESULT GetFontAxisRanges(uint listIndex, DWRITE_FONT_AXIS_RANGE* fontAxisRanges, uint maxFontAxisRangeCount, 
                              uint* actualFontAxisRangeCount);
    ///Retrieves the font face reference of a single item.
    ///Params:
    ///    listIndex = Type: **[UINT32](/windows/win32/winprog/windows-data-types)** Zero-based index of the font item in the set.
    ///    fontFaceReference = Type: **[IDWriteFontFaceReference1](./nn-dwrite_3-idwritefontfacereference1.md)\*\*** The address of a
    ///                        pointer to an [IDWriteFontFaceReference1](./nn-dwrite_3-idwritefontfacereference1.md) interface. On
    ///                        successful completion, the function sets the pointer to the font face reference.
    ///Returns:
    ///    Type: **[HRESULT](/windows/win32/com/structure-of-com-error-codes)** If the function succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an [**HRESULT**](/windows/win32/com/structure-of-com-error-codes) [error
    ///    code](/windows/win32/com/com-error-codes-10).
    ///    
    HRESULT GetFontFaceReference(uint listIndex, IDWriteFontFaceReference1* fontFaceReference);
    ///Creates the font resource of a single item.
    ///Params:
    ///    listIndex = Type: **[UINT32](/windows/win32/winprog/windows-data-types)** Zero-based index of the font item in the set.
    ///    fontResource = Type: **[IDWriteFontResource](./nn-dwrite_3-idwritefontresource.md)\*\*** The address of a pointer to an
    ///                   [IDWriteFontResource](./nn-dwrite_3-idwritefontresource.md) interface. On successful completion, the function
    ///                   sets the pointer to a newly created font resource object.
    ///Returns:
    ///    Type: **[HRESULT](/windows/win32/com/structure-of-com-error-codes)** If the function succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an [**HRESULT**](/windows/win32/com/structure-of-com-error-codes) [error
    ///    code](/windows/win32/com/com-error-codes-10). |Return value|Description| |-|-| |DWRITE_E_REMOTEFONT|The file
    ///    is not local.|
    ///    
    HRESULT CreateFontResource(uint listIndex, IDWriteFontResource* fontResource);
    ///Creates a font face for a single item (rather than going through the font face reference).
    ///Params:
    ///    listIndex = Type: **[UINT32](/windows/win32/winprog/windows-data-types)** Zero-based index of the font item in the set.
    ///    fontFace = Type: **[IDWriteFontFace5](./nn-dwrite_3-idwritefontface5.md)\*\*** The address of a pointer to an
    ///               [IDWriteFontFace5](./nn-dwrite_3-idwritefontface5.md) interface. On successful completion, the function sets
    ///               the pointer to a newly created font face object.
    ///Returns:
    ///    Type: **[HRESULT](/windows/win32/com/structure-of-com-error-codes)** If the function succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an [**HRESULT**](/windows/win32/com/structure-of-com-error-codes) [error
    ///    code](/windows/win32/com/com-error-codes-10). |Return value|Description| |-|-| |DWRITE_E_REMOTEFONT|The font
    ///    is not local.|
    ///    
    HRESULT CreateFontFace(uint listIndex, IDWriteFontFace5* fontFace);
    ///Retrieves the locality of a single item.
    ///Params:
    ///    listIndex = Type: **[UINT32](/windows/win32/winprog/windows-data-types)** Zero-based index of the font item in the set.
    ///Returns:
    ///    Type: **[DWRITE_LOCALITY](./ne-dwrite_3-dwrite_locality.md)** A value indicating the locality.
    ///    
    DWRITE_LOCALITY GetFontLocality(uint listIndex);
}

///Represents a list of fonts. **IDWriteFontList2** adds new facilities, including retrieving the underlying font set
///used by the list. This interface extends [IDWriteFontList1](./nn-dwrite_3-idwritefontlist1.md).
@GUID("C0763A34-77AF-445A-B735-08C37B0A5BF5")
interface IDWriteFontList2 : IDWriteFontList1
{
    ///Retrieves the underlying font set used by this list.
    ///Params:
    ///    fontSet = Type: **[IDWriteFontSet1](./nn-dwrite_3-idwritefontset1.md)\*\*** The address of a pointer to an
    ///              [IDWriteFontSet1](./nn-dwrite_3-idwritefontset1.md) interface. On successful completion, the function sets
    ///              the pointer to the font set used by the list.
    ///Returns:
    ///    Type: **[HRESULT](/windows/win32/com/structure-of-com-error-codes)** If the function succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an [**HRESULT**](/windows/win32/com/structure-of-com-error-codes) [error
    ///    code](/windows/win32/com/com-error-codes-10).
    ///    
    HRESULT GetFontSet(IDWriteFontSet1* fontSet);
}

///Represents a family of related fonts. **IDWriteFontFamily2** adds new facilities, including retrieving fonts by font
///axis values. This interface extends [IDWriteFontFamily1](./nn-dwrite_3-idwritefontfamily1.md).
@GUID("3ED49E77-A398-4261-B9CF-C126C2131EF3")
interface IDWriteFontFamily2 : IDWriteFontFamily1
{
    ///Retrieves a list of fonts in the font family, ranked in order of how well they match the specified axis values.
    ///Params:
    ///    fontAxisValues = Type: **[DWRITE_FONT_AXIS_VALUE](./ns-dwrite_3-dwrite_font_axis_value.md) const \*** A pointer to an array
    ///                     containing a list of font axis values. The array should be the size (the number of elements) indicated by the
    ///                     *fontAxisValueCount* argument.
    ///    fontAxisValueCount = Type: **[UINT32](/windows/win32/winprog/windows-data-types)** The number of font axis values contained in the
    ///                         *fontAxisValues* array.
    ///    matchingFonts = Type: **[IDWriteFontList2](./nn-dwrite_3-idwritefontlist2.md)\*\*** The address of a pointer to an
    ///                    [IDWriteFontList2](./nn-dwrite_3-idwritefontlist2.md) interface. On successful completion, the function sets
    ///                    the pointer to a newly created font list object.
    ///Returns:
    ///    Type: **[HRESULT](/windows/win32/com/structure-of-com-error-codes)** If the function succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an [**HRESULT**](/windows/win32/com/structure-of-com-error-codes) [error
    ///    code](/windows/win32/com/com-error-codes-10).
    ///    
    HRESULT GetMatchingFonts(const(DWRITE_FONT_AXIS_VALUE)* fontAxisValues, uint fontAxisValueCount, 
                             IDWriteFontList2* matchingFonts);
    ///Retrieves the underlying font set used by this family.
    ///Params:
    ///    fontSet = Type: **[IDWriteFontSet1](./nn-dwrite_3-idwritefontset1.md)\*\*** The address of a pointer to an
    ///              [IDWriteFontSet1](./nn-dwrite_3-idwritefontset1.md) interface. On successful completion, the function sets
    ///              the pointer to the font set used by the family.
    ///Returns:
    ///    Type: **[HRESULT](/windows/win32/com/structure-of-com-error-codes)** If the function succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an [**HRESULT**](/windows/win32/com/structure-of-com-error-codes) [error
    ///    code](/windows/win32/com/com-error-codes-10).
    ///    
    HRESULT GetFontSet(IDWriteFontSet1* fontSet);
}

///This interface encapsulates a set of fonts, such as the set of fonts installed on the system, or the set of fonts in
///a particular directory. The font collection API can be used to discover what font families and fonts are available,
///and to obtain some metadata about the fonts. **IDWriteFontCollection2** adds new facilities, including support for
///[IDWriteFontSet1](./nn-dwrite_3-idwritefontset1.md). This interface extends
///[IDWriteFontCollection1](./nn-dwrite_3-idwritefontcollection1.md).
@GUID("514039C6-4617-4064-BF8B-92EA83E506E0")
interface IDWriteFontCollection2 : IDWriteFontCollection1
{
    ///Creates a font family object, given a zero-based font family index.
    ///Params:
    ///    index = Type: **[UINT32](/windows/win32/winprog/windows-data-types)** Zero-based index of the font family.
    ///    fontFamily = Type: **[IDWriteFontFamily2](./nn-dwrite_3-idwritefontfamily2.md)\*\*** The address of a pointer to an
    ///                 [IDWriteFontFamily2](./nn-dwrite_3-idwritefontfamily2.md) interface. On successful completion, the function
    ///                 sets the pointer to a newly created font family object.
    ///Returns:
    ///    Type: **[HRESULT](/windows/win32/com/structure-of-com-error-codes)** If the function succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an [**HRESULT**](/windows/win32/com/structure-of-com-error-codes) [error
    ///    code](/windows/win32/com/com-error-codes-10).
    ///    
    HRESULT GetFontFamily(uint index, IDWriteFontFamily2* fontFamily);
    ///Retrieves a list of fonts in the specified font family, ranked in order of how well they match the specified axis
    ///values.
    ///Params:
    ///    familyName = Type: **[WCHAR](/windows/win32/winprog/windows-data-types) const \*** Name of the font family. The name is
    ///                 not case-sensitive, but must otherwise exactly match a family name in the collection.
    ///    fontAxisValues = Type: **[DWRITE_FONT_AXIS_VALUE](./ns-dwrite_3-dwrite_font_axis_value.md) const \*** A pointer to an array
    ///                     containing a list of font axis values. The array should be the size (the number of elements) indicated by the
    ///                     *fontAxisValueCount* argument.
    ///    fontAxisValueCount = Type: **[UINT32](/windows/win32/winprog/windows-data-types)** The number of font axis values contained in the
    ///                         *fontAxisValues* array.
    ///    fontList = Type: **[IDWriteFontList2](./nn-dwrite_3-idwritefontlist2.md)\*\*** The address of a pointer to an
    ///               [IDWriteFontList2](./nn-dwrite_3-idwritefontlist2.md) interface. On successful completion, the function sets
    ///               the pointer to a newly created font list object.
    ///Returns:
    ///    Type: **[HRESULT](/windows/win32/com/structure-of-com-error-codes)** If the function succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an [**HRESULT**](/windows/win32/com/structure-of-com-error-codes) [error
    ///    code](/windows/win32/com/com-error-codes-10).
    ///    
    HRESULT GetMatchingFonts(const(PWSTR) familyName, const(DWRITE_FONT_AXIS_VALUE)* fontAxisValues, 
                             uint fontAxisValueCount, IDWriteFontList2* fontList);
    ///Retrieves the font family model used by the font collection to group families.
    ///Returns:
    ///    Type: **[DWRITE_FONT_FAMILY_MODEL](./ne-dwrite_3-dwrite_font_family_model.md)** How families are grouped in
    ///    the collection.
    ///    
    DWRITE_FONT_FAMILY_MODEL GetFontFamilyModel();
    ///Retrieves the underlying font set used by this collection.
    ///Params:
    ///    fontSet = Type: **[IDWriteFontSet1](./nn-dwrite_3-idwritefontset1.md)\*\*** The address of a pointer to an
    ///              [IDWriteFontSet1](./nn-dwrite_3-idwritefontset1.md) interface. On successful completion, the function sets
    ///              the pointer to the font set used by the collection.
    ///Returns:
    ///    Type: **[HRESULT](/windows/win32/com/structure-of-com-error-codes)** If the function succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an [**HRESULT**](/windows/win32/com/structure-of-com-error-codes) [error
    ///    code](/windows/win32/com/com-error-codes-10).
    ///    
    HRESULT GetFontSet(IDWriteFontSet1* fontSet);
}

@GUID("05A9BF42-223F-4441-B5FB-8263685F55E9")
interface IDWriteTextLayout4 : IDWriteTextLayout3
{
    HRESULT SetFontAxisValues(const(DWRITE_FONT_AXIS_VALUE)* fontAxisValues, uint fontAxisValueCount, 
                              DWRITE_TEXT_RANGE textRange);
    uint    GetFontAxisValueCount(uint currentPosition);
    HRESULT GetFontAxisValues(uint currentPosition, DWRITE_FONT_AXIS_VALUE* fontAxisValues, 
                              uint fontAxisValueCount, DWRITE_TEXT_RANGE* textRange);
    DWRITE_AUTOMATIC_FONT_AXES GetAutomaticFontAxes();
    HRESULT SetAutomaticFontAxes(DWRITE_AUTOMATIC_FONT_AXES automaticFontAxes);
}

///Describes the font and paragraph properties used to format text, and it describes locale information. This interface
///extends [IDWriteTextFormat2](/windows/win32/directwrite/idwritetextformat2).
@GUID("6D3B5641-E550-430D-A85B-B7BF48A93427")
interface IDWriteTextFormat3 : IDWriteTextFormat2
{
    ///Sets values for the font axes of the format.
    ///Params:
    ///    fontAxisValues = Type: **[DWRITE_FONT_AXIS_VALUE](./ns-dwrite_3-dwrite_font_axis_value.md) const \*** A pointer to an array
    ///                     containing a list of font axis values. The array should be the size (the number of elements) indicated by the
    ///                     *fontAxisValueCount* argument.
    ///    fontAxisValueCount = Type: **[UINT32](/windows/win32/winprog/windows-data-types)** The number of font axis values contained in the
    ///                         *fontAxisValues* array.
    ///Returns:
    ///    Type: **[HRESULT](/windows/win32/com/structure-of-com-error-codes)** If the function succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an [**HRESULT**](/windows/win32/com/structure-of-com-error-codes) [error
    ///    code](/windows/win32/com/com-error-codes-10).
    ///    
    HRESULT SetFontAxisValues(const(DWRITE_FONT_AXIS_VALUE)* fontAxisValues, uint fontAxisValueCount);
    ///Retrieves the number of axes set on the format.
    ///Returns:
    ///    Type: **[UINT32](/windows/win32/winprog/windows-data-types)** The number of axes set on the format.
    ///    
    uint    GetFontAxisValueCount();
    ///Retrieves the list of font axis values on the format.
    ///Params:
    ///    fontAxisValues = Type: **[DWRITE_FONT_AXIS_VALUE](./ns-dwrite_3-dwrite_font_axis_value.md)\*** A pointer to an array of
    ///                     **DWRITE_FONT_AXIS_VALUE** structures into which **GetFontAxisValues** writes the list of font axis values.
    ///                     You're responsible for managing the size and the lifetime of this array. Call
    ///                     [GetFontAxisValueCount](./nf-dwrite_3-idwritetextformat3-getfontaxisvaluecount.md) to determine the size of
    ///                     array to allocate.
    ///    fontAxisValueCount = Type: **[UINT32](/windows/win32/winprog/windows-data-types)** The maximum number of font axis values to write
    ///                         into the memory block pointed to by `fontAxisValues`.
    ///Returns:
    ///    Type: **[HRESULT](/windows/win32/com/structure-of-com-error-codes)** If the function succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an [**HRESULT**](/windows/win32/com/structure-of-com-error-codes) [error
    ///    code](/windows/win32/com/com-error-codes-10).
    ///    
    HRESULT GetFontAxisValues(DWRITE_FONT_AXIS_VALUE* fontAxisValues, uint fontAxisValueCount);
    ///Retrieves the automatic axis options.
    ///Returns:
    ///    Type: **[DWRITE_AUTOMATIC_FONT_AXES](./ne-dwrite_3-dwrite_automatic_font_axes.md)** Automatic axis options.
    ///    
    DWRITE_AUTOMATIC_FONT_AXES GetAutomaticFontAxes();
    ///Sets the automatic font axis options.
    ///Params:
    ///    automaticFontAxes = Type: **[DWRITE_AUTOMATIC_FONT_AXES](./ne-dwrite_3-dwrite_automatic_font_axes.md)** Automatic font axis
    ///                        options.
    ///Returns:
    ///    Type: **[HRESULT](/windows/win32/com/structure-of-com-error-codes)** If the function succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an [**HRESULT**](/windows/win32/com/structure-of-com-error-codes) [error
    ///    code](/windows/win32/com/com-error-codes-10).
    ///    
    HRESULT SetAutomaticFontAxes(DWRITE_AUTOMATIC_FONT_AXES automaticFontAxes);
}

@GUID("2397599D-DD0D-4681-BD6A-F4F31EAADE77")
interface IDWriteFontFallback1 : IDWriteFontFallback
{
    HRESULT MapCharacters(IDWriteTextAnalysisSource analysisSource, uint textPosition, uint textLength, 
                          IDWriteFontCollection baseFontCollection, const(PWSTR) baseFamilyName, 
                          const(DWRITE_FONT_AXIS_VALUE)* fontAxisValues, uint fontAxisValueCount, uint* mappedLength, 
                          float* scale, IDWriteFontFace5* mappedFontFace);
}

///Represents a font set. This interface extends [IDWriteFontSet1](./nn-dwrite_3-idwritefontset1.md).
@GUID("DC7EAD19-E54C-43AF-B2DA-4E2B79BA3F7F")
interface IDWriteFontSet2 : IDWriteFontSet1
{
    ///Retrieves the expiration event for the font set, if any. The expiration event is set on a system font set object
    ///if it is out of date due to fonts being installed, uninstalled, or updated. You should handle the event by
    ///getting a new system font set.
    ///Returns:
    ///    Type: **[HANDLE](/windows/win32/winprog/windows-data-types)** An event handle, if called on the system font
    ///    set, or `nullptr` if called on a custom font set.
    ///    
    HANDLE GetExpirationEvent();
}

///This interface encapsulates a set of fonts, such as the set of fonts installed on the system, or the set of fonts in
///a particular directory. The font collection API can be used to discover what font families and fonts are available,
///and to obtain some metadata about the fonts. **IDWriteFontCollection3** adds the ability to retrieve the expiration
///event. This interface extends [IDWriteFontCollection2](./nn-dwrite_3-idwritefontcollection2.md).
@GUID("A4D055A6-F9E3-4E25-93B7-9E309F3AF8E9")
interface IDWriteFontCollection3 : IDWriteFontCollection2
{
    ///Retrieves the expiration event for the font set, if any. The expiration event is set on a system font set object
    ///if it is out of date due to fonts being installed, uninstalled, or updated. You should handle the event by
    ///getting a new system font set.
    ///Returns:
    ///    Type: **[HANDLE](/windows/win32/winprog/windows-data-types)** An event handle, if called on the system font
    ///    set, or `nullptr` if called on a custom font set.
    ///    
    HANDLE GetExpirationEvent();
}

///This interface represents a factory object from which all DirectWrite objects are created. **IDWriteFactory7** adds
///new facilities for working with system fonts. This interface extends
///[IDWriteFactory6](./nn-dwrite_3-idwritefactory6.md).
@GUID("35D0E0B3-9076-4D2E-A016-A91B568A06B4")
interface IDWriteFactory7 : IDWriteFactory6
{
    ///Retrieves the set of system fonts.
    ///Params:
    ///    includeDownloadableFonts = Type: **[BOOL](/windows/win32/winprog/windows-data-types)** `true` if you want to include downloadable fonts.
    ///                               `false` if you only want locally installed fonts.
    ///    fontSet = Type: **[IDWriteFontSet2](./nn-dwrite_3-idwritefontset2.md)\*\*** The address of a pointer to an
    ///              [IDWriteFontSet2](./nn-dwrite_3-idwritefontset2.md) interface. On successful completion, the function sets
    ///              the pointer to the font set object, otherwise it sets the pointer to `nullptr`.
    ///Returns:
    ///    Type: **[HRESULT](/windows/win32/com/structure-of-com-error-codes)** If the function succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an [**HRESULT**](/windows/win32/com/structure-of-com-error-codes) [error
    ///    code](/windows/win32/com/com-error-codes-10).
    ///    
    HRESULT GetSystemFontSet(BOOL includeDownloadableFonts, IDWriteFontSet2* fontSet);
    ///Retrieves a collection of fonts, grouped into families.
    ///Params:
    ///    includeDownloadableFonts = Type: **[BOOL](/windows/win32/winprog/windows-data-types)** `true` if you want to include downloadable fonts.
    ///                               `false` if you only want locally installed fonts.
    ///    fontFamilyModel = Type: **[DWRITE_FONT_FAMILY_MODEL](./ne-dwrite_3-dwrite_font_family_model.md)** How to group families in the
    ///                      collection.
    ///    fontCollection = Type: **[IDWriteFontCollection3](./nn-dwrite_3-idwritefontcollection3.md)\*\*** The address of a pointer to
    ///                     an [IDWriteFontCollection3](./nn-dwrite_3-idwritefontcollection3.md) interface. On successful completion, the
    ///                     function sets the pointer to a newly created font collection object, otherwise it sets the pointer to
    ///                     `nullptr`.
    ///Returns:
    ///    Type: **[HRESULT](/windows/win32/com/structure-of-com-error-codes)** If the function succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an [**HRESULT**](/windows/win32/com/structure-of-com-error-codes) [error
    ///    code](/windows/win32/com/com-error-codes-10).
    ///    
    HRESULT GetSystemFontCollection(BOOL includeDownloadableFonts, DWRITE_FONT_FAMILY_MODEL fontFamilyModel, 
                                    IDWriteFontCollection3* fontCollection);
}

///Represents a font set. This interface extends [IDWriteFontSet2](./nn-dwrite_3-idwritefontset2.md).
@GUID("7C073EF2-A7F4-4045-8C32-8AB8AE640F90")
interface IDWriteFontSet3 : IDWriteFontSet2
{
    ///Retrieves the font source type of the specified font.
    ///Params:
    ///    fontIndex = Type: **[UINT32](/windows/win32/winprog/windows-data-types)** Zero-based index of the font.
    ///Returns:
    ///    Type: **[DWRITE_FONT_SOURCE_TYPE](./ne-dwrite_3-dwrite_font_source_type.md)** The font source type of the
    ///    specified font.
    ///    
    DWRITE_FONT_SOURCE_TYPE GetFontSourceType(uint fontIndex);
    ///Retrieves the length of the font source name for the specified font.
    ///Params:
    ///    listIndex = Type: **[UINT32](/windows/win32/winprog/windows-data-types)** Zero-based index of the font.
    ///Returns:
    ///    Type: **[UINT32](/windows/win32/winprog/windows-data-types)** The length of the font source name for the
    ///    specified font.
    ///    
    uint    GetFontSourceNameLength(uint listIndex);
    ///Copies the font source name (for the specified font) into an output array.
    ///Params:
    ///    listIndex = Type: **[UINT32](/windows/win32/winprog/windows-data-types)** Zero-based index of the font.
    ///    stringBuffer = Type: **[WCHAR](/windows/win32/winprog/windows-data-types)\*** Character array that receives the string. Call
    ///                   [GetFontSourceNameLength](./nf-dwrite_3-idwritefontset3-getfontsourcenamelength.md) to determine the size of
    ///                   array to allocate.
    ///    stringBufferSize = Type: **[UINT32](/windows/win32/winprog/windows-data-types)** Size of the array in characters. The size must
    ///                       include space for the terminating null character.
    ///Returns:
    ///    Type: **[HRESULT](/windows/win32/com/structure-of-com-error-codes)** If the function succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an [**HRESULT**](/windows/win32/com/structure-of-com-error-codes) [error
    ///    code](/windows/win32/com/com-error-codes-10).
    ///    
    HRESULT GetFontSourceName(uint listIndex, PWSTR stringBuffer, uint stringBufferSize);
}


// GUIDs


const GUID IID_IDWriteAsyncResult              = GUIDOF!IDWriteAsyncResult;
const GUID IID_IDWriteBitmapRenderTarget       = GUIDOF!IDWriteBitmapRenderTarget;
const GUID IID_IDWriteBitmapRenderTarget1      = GUIDOF!IDWriteBitmapRenderTarget1;
const GUID IID_IDWriteColorGlyphRunEnumerator  = GUIDOF!IDWriteColorGlyphRunEnumerator;
const GUID IID_IDWriteColorGlyphRunEnumerator1 = GUIDOF!IDWriteColorGlyphRunEnumerator1;
const GUID IID_IDWriteFactory                  = GUIDOF!IDWriteFactory;
const GUID IID_IDWriteFactory1                 = GUIDOF!IDWriteFactory1;
const GUID IID_IDWriteFactory2                 = GUIDOF!IDWriteFactory2;
const GUID IID_IDWriteFactory3                 = GUIDOF!IDWriteFactory3;
const GUID IID_IDWriteFactory4                 = GUIDOF!IDWriteFactory4;
const GUID IID_IDWriteFactory5                 = GUIDOF!IDWriteFactory5;
const GUID IID_IDWriteFactory6                 = GUIDOF!IDWriteFactory6;
const GUID IID_IDWriteFactory7                 = GUIDOF!IDWriteFactory7;
const GUID IID_IDWriteFont                     = GUIDOF!IDWriteFont;
const GUID IID_IDWriteFont1                    = GUIDOF!IDWriteFont1;
const GUID IID_IDWriteFont2                    = GUIDOF!IDWriteFont2;
const GUID IID_IDWriteFont3                    = GUIDOF!IDWriteFont3;
const GUID IID_IDWriteFontCollection           = GUIDOF!IDWriteFontCollection;
const GUID IID_IDWriteFontCollection1          = GUIDOF!IDWriteFontCollection1;
const GUID IID_IDWriteFontCollection2          = GUIDOF!IDWriteFontCollection2;
const GUID IID_IDWriteFontCollection3          = GUIDOF!IDWriteFontCollection3;
const GUID IID_IDWriteFontCollectionLoader     = GUIDOF!IDWriteFontCollectionLoader;
const GUID IID_IDWriteFontDownloadListener     = GUIDOF!IDWriteFontDownloadListener;
const GUID IID_IDWriteFontDownloadQueue        = GUIDOF!IDWriteFontDownloadQueue;
const GUID IID_IDWriteFontFace                 = GUIDOF!IDWriteFontFace;
const GUID IID_IDWriteFontFace1                = GUIDOF!IDWriteFontFace1;
const GUID IID_IDWriteFontFace2                = GUIDOF!IDWriteFontFace2;
const GUID IID_IDWriteFontFace3                = GUIDOF!IDWriteFontFace3;
const GUID IID_IDWriteFontFace4                = GUIDOF!IDWriteFontFace4;
const GUID IID_IDWriteFontFace5                = GUIDOF!IDWriteFontFace5;
const GUID IID_IDWriteFontFaceReference        = GUIDOF!IDWriteFontFaceReference;
const GUID IID_IDWriteFontFaceReference1       = GUIDOF!IDWriteFontFaceReference1;
const GUID IID_IDWriteFontFallback             = GUIDOF!IDWriteFontFallback;
const GUID IID_IDWriteFontFallback1            = GUIDOF!IDWriteFontFallback1;
const GUID IID_IDWriteFontFallbackBuilder      = GUIDOF!IDWriteFontFallbackBuilder;
const GUID IID_IDWriteFontFamily               = GUIDOF!IDWriteFontFamily;
const GUID IID_IDWriteFontFamily1              = GUIDOF!IDWriteFontFamily1;
const GUID IID_IDWriteFontFamily2              = GUIDOF!IDWriteFontFamily2;
const GUID IID_IDWriteFontFile                 = GUIDOF!IDWriteFontFile;
const GUID IID_IDWriteFontFileEnumerator       = GUIDOF!IDWriteFontFileEnumerator;
const GUID IID_IDWriteFontFileLoader           = GUIDOF!IDWriteFontFileLoader;
const GUID IID_IDWriteFontFileStream           = GUIDOF!IDWriteFontFileStream;
const GUID IID_IDWriteFontList                 = GUIDOF!IDWriteFontList;
const GUID IID_IDWriteFontList1                = GUIDOF!IDWriteFontList1;
const GUID IID_IDWriteFontList2                = GUIDOF!IDWriteFontList2;
const GUID IID_IDWriteFontResource             = GUIDOF!IDWriteFontResource;
const GUID IID_IDWriteFontSet                  = GUIDOF!IDWriteFontSet;
const GUID IID_IDWriteFontSet1                 = GUIDOF!IDWriteFontSet1;
const GUID IID_IDWriteFontSet2                 = GUIDOF!IDWriteFontSet2;
const GUID IID_IDWriteFontSet3                 = GUIDOF!IDWriteFontSet3;
const GUID IID_IDWriteFontSetBuilder           = GUIDOF!IDWriteFontSetBuilder;
const GUID IID_IDWriteFontSetBuilder1          = GUIDOF!IDWriteFontSetBuilder1;
const GUID IID_IDWriteFontSetBuilder2          = GUIDOF!IDWriteFontSetBuilder2;
const GUID IID_IDWriteGdiInterop               = GUIDOF!IDWriteGdiInterop;
const GUID IID_IDWriteGdiInterop1              = GUIDOF!IDWriteGdiInterop1;
const GUID IID_IDWriteGlyphRunAnalysis         = GUIDOF!IDWriteGlyphRunAnalysis;
const GUID IID_IDWriteInMemoryFontFileLoader   = GUIDOF!IDWriteInMemoryFontFileLoader;
const GUID IID_IDWriteInlineObject             = GUIDOF!IDWriteInlineObject;
const GUID IID_IDWriteLocalFontFileLoader      = GUIDOF!IDWriteLocalFontFileLoader;
const GUID IID_IDWriteLocalizedStrings         = GUIDOF!IDWriteLocalizedStrings;
const GUID IID_IDWriteNumberSubstitution       = GUIDOF!IDWriteNumberSubstitution;
const GUID IID_IDWritePixelSnapping            = GUIDOF!IDWritePixelSnapping;
const GUID IID_IDWriteRemoteFontFileLoader     = GUIDOF!IDWriteRemoteFontFileLoader;
const GUID IID_IDWriteRemoteFontFileStream     = GUIDOF!IDWriteRemoteFontFileStream;
const GUID IID_IDWriteRenderingParams          = GUIDOF!IDWriteRenderingParams;
const GUID IID_IDWriteRenderingParams1         = GUIDOF!IDWriteRenderingParams1;
const GUID IID_IDWriteRenderingParams2         = GUIDOF!IDWriteRenderingParams2;
const GUID IID_IDWriteRenderingParams3         = GUIDOF!IDWriteRenderingParams3;
const GUID IID_IDWriteStringList               = GUIDOF!IDWriteStringList;
const GUID IID_IDWriteTextAnalysisSink         = GUIDOF!IDWriteTextAnalysisSink;
const GUID IID_IDWriteTextAnalysisSink1        = GUIDOF!IDWriteTextAnalysisSink1;
const GUID IID_IDWriteTextAnalysisSource       = GUIDOF!IDWriteTextAnalysisSource;
const GUID IID_IDWriteTextAnalysisSource1      = GUIDOF!IDWriteTextAnalysisSource1;
const GUID IID_IDWriteTextAnalyzer             = GUIDOF!IDWriteTextAnalyzer;
const GUID IID_IDWriteTextAnalyzer1            = GUIDOF!IDWriteTextAnalyzer1;
const GUID IID_IDWriteTextAnalyzer2            = GUIDOF!IDWriteTextAnalyzer2;
const GUID IID_IDWriteTextFormat               = GUIDOF!IDWriteTextFormat;
const GUID IID_IDWriteTextFormat1              = GUIDOF!IDWriteTextFormat1;
const GUID IID_IDWriteTextFormat2              = GUIDOF!IDWriteTextFormat2;
const GUID IID_IDWriteTextFormat3              = GUIDOF!IDWriteTextFormat3;
const GUID IID_IDWriteTextLayout               = GUIDOF!IDWriteTextLayout;
const GUID IID_IDWriteTextLayout1              = GUIDOF!IDWriteTextLayout1;
const GUID IID_IDWriteTextLayout2              = GUIDOF!IDWriteTextLayout2;
const GUID IID_IDWriteTextLayout3              = GUIDOF!IDWriteTextLayout3;
const GUID IID_IDWriteTextLayout4              = GUIDOF!IDWriteTextLayout4;
const GUID IID_IDWriteTextRenderer             = GUIDOF!IDWriteTextRenderer;
const GUID IID_IDWriteTextRenderer1            = GUIDOF!IDWriteTextRenderer1;
const GUID IID_IDWriteTypography               = GUIDOF!IDWriteTypography;
