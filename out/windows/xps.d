// Written in the D programming language.

module windows.xps;

public import windows.core;
public import windows.automation : BSTR, IDispatch;
public import windows.com : HRESULT, IUnknown, IUri;
public import windows.displaydevices : DEVMODEW, POINT, POINTL;
public import windows.gdi : HDC;
public import windows.packaging : IOpcCertificateEnumerator, IOpcCertificateSet, IOpcPartUri,
                                  IOpcSignatureCustomObjectEnumerator,
                                  IOpcSignatureCustomObjectSet,
                                  IOpcSignatureReferenceEnumerator,
                                  IOpcSignatureReferenceSet, OPC_SIGNATURE_TIME_FORMAT;
public import windows.printdocs : XPS_GLYPH_INDEX;
public import windows.security : CERT_CONTEXT;
public import windows.structuredstorage : ISequentialStream, IStream;
public import windows.systemservices : BOOL, SECURITY_ATTRIBUTES;
public import windows.windowsandmessaging : HWND;
public import windows.windowsprogramming : SYSTEMTIME;

extern(Windows):


// Enums


///Describes the tiling behavior of a tile brush.
alias XPS_TILE_MODE = int;
enum : int
{
    ///Only the base tile is drawn.
    XPS_TILE_MODE_NONE   = 0x00000001,
    ///First, the base tile is drawn. Next, the remaining area is filled by repeating the base tile such that the right
    ///edge of one tile is adjacent to the left edge of the next, and similarly for bottom and top.
    XPS_TILE_MODE_TILE   = 0x00000002,
    ///The same as <b>XPS_TILE_MODE_TILE</b>, but alternate columns of tiles are flipped horizontally.
    XPS_TILE_MODE_FLIPX  = 0x00000003,
    ///The same as <b>XPS_TILE_MODE_TILE</b>, but alternate rows of tiles are flipped vertically.
    XPS_TILE_MODE_FLIPY  = 0x00000004,
    ///The combination of the effects produced by <b>XPS_TILE_MODE_FLIPX</b> and <b>XPS_TILE_MODE_FLIPY</b>.
    XPS_TILE_MODE_FLIPXY = 0x00000005,
}

///Describes the gamma function used for color interpolation.
alias XPS_COLOR_INTERPOLATION = int;
enum : int
{
    ///First, the color values are converted to scRGB, then a linear interpolation is performed between them.
    XPS_COLOR_INTERPOLATION_SCRGBLINEAR = 0x00000001,
    ///First, the color values are converted to sRGB, then a linear interpolation is performed between them.
    XPS_COLOR_INTERPOLATION_SRGBLINEAR  = 0x00000002,
}

///Describes how the spread region is to be filled. The spread region is the area that falls within the drawing area but
///outside of the gradient region.
alias XPS_SPREAD_METHOD = int;
enum : int
{
    ///The spread region is filled with the color whose value equals the color at the end of the gradient region.
    XPS_SPREAD_METHOD_PAD     = 0x00000001,
    ///The spread region is filled by repeating the alternating reflection of the gradient that is inside the gradient
    ///region.
    XPS_SPREAD_METHOD_REFLECT = 0x00000002,
    ///The spread region is filled by repeating the gradient that is inside the gradient region, in the same orientation
    ///and direction.
    XPS_SPREAD_METHOD_REPEAT  = 0x00000003,
}

///Describes the simulation style of a font or glyph. To simulate the appearance of a style that is not provided by the
///font or glyph, style simulation modifies an existing font or a glyph image. <div class="code"></div>
alias XPS_STYLE_SIMULATION = int;
enum : int
{
    ///No font style simulation.
    XPS_STYLE_SIMULATION_NONE       = 0x00000001,
    ///Italic style simulation.
    XPS_STYLE_SIMULATION_ITALIC     = 0x00000002,
    ///Bold style simulation.
    XPS_STYLE_SIMULATION_BOLD       = 0x00000003,
    ///Both bold and italic style simulation: first bold, then italic.
    XPS_STYLE_SIMULATION_BOLDITALIC = 0x00000004,
}

///Specifies the shapes of line segment caps.
alias XPS_LINE_CAP = int;
enum : int
{
    ///Flat line cap.
    XPS_LINE_CAP_FLAT     = 0x00000001,
    ///Round line cap.
    XPS_LINE_CAP_ROUND    = 0x00000002,
    ///Square line cap.
    XPS_LINE_CAP_SQUARE   = 0x00000003,
    ///Triangular line cap.
    XPS_LINE_CAP_TRIANGLE = 0x00000004,
}

///Specifies the style of a dash cap on a dashed stroke.
alias XPS_DASH_CAP = int;
enum : int
{
    ///Flat-line cap.
    XPS_DASH_CAP_FLAT     = 0x00000001,
    ///Round-line cap.
    XPS_DASH_CAP_ROUND    = 0x00000002,
    ///Square-line cap.
    XPS_DASH_CAP_SQUARE   = 0x00000003,
    ///Triangular-line cap.
    XPS_DASH_CAP_TRIANGLE = 0x00000004,
}

///Describes the joint made by two intersecting line segments.
alias XPS_LINE_JOIN = int;
enum : int
{
    ///Produces a sharp or clipped corner, depending on whether the length of the miter exceeds the miter limit.
    XPS_LINE_JOIN_MITER = 0x00000001,
    ///Produces a diagonal corner.
    XPS_LINE_JOIN_BEVEL = 0x00000002,
    ///Produces a smooth, circular arc between the lines.
    XPS_LINE_JOIN_ROUND = 0x00000003,
}

///Describes the image type.
alias XPS_IMAGE_TYPE = int;
enum : int
{
    ///A JPEG (Joint Photographic Experts Group) image.
    XPS_IMAGE_TYPE_JPEG = 0x00000001,
    ///A PNG (Portable Network Graphics) image.
    XPS_IMAGE_TYPE_PNG  = 0x00000002,
    ///A TIFF (Tagged Image File Format) image.
    XPS_IMAGE_TYPE_TIFF = 0x00000003,
    ///An HD Photo (formerly Windows Media Photo) image.
    XPS_IMAGE_TYPE_WDP  = 0x00000004,
    ///JPEG extended range (JPEG XR) image.
    XPS_IMAGE_TYPE_JXR  = 0x00000005,
}

///Describes the color type used by the XPS_COLOR structure.
alias XPS_COLOR_TYPE = int;
enum : int
{
    ///The color value is an sRGB value.
    XPS_COLOR_TYPE_SRGB    = 0x00000001,
    ///The color value is an scRGB value.
    XPS_COLOR_TYPE_SCRGB   = 0x00000002,
    ///The color value is specified using context color syntax.
    XPS_COLOR_TYPE_CONTEXT = 0x00000003,
}

///The rule used by a composite shape to determine whether a given point is part of the geometry.
alias XPS_FILL_RULE = int;
enum : int
{
    ///The rule that determines whether a point is in the fill region. This is determined by drawing a ray from the
    ///point to infinity in any direction, and counting the number of path segments within the shape that the ray
    ///crosses. If this number is odd, the point is inside; if even, the point is outside.
    XPS_FILL_RULE_EVENODD = 0x00000001,
    ///The rule that determines whether a point is in the fill region of the path. This is determined by drawing a ray
    ///from the point to infinity in any direction, and examining the places where a segment of the shape crosses the
    ///ray. Start the count at 0, then add 1 whenever a path segment crosses the ray from left to right; subtract 1
    ///whenever a path segment crosses the ray from right to left. After the crossings are counted, the point is outside
    ///the path if the result is zero and inside if otherwise.
    XPS_FILL_RULE_NONZERO = 0x00000002,
}

///Describes a line segment.
alias XPS_SEGMENT_TYPE = int;
enum : int
{
    ///The line segment is an arc that covers more than 180 degrees and is drawn in a clockwise direction from the start
    ///point to the end point.
    XPS_SEGMENT_TYPE_ARC_LARGE_CLOCKWISE        = 0x00000001,
    ///The line segment is an arc that covers more than 180 degrees and is drawn in a counterclockwise direction from
    ///the start point to the end point.
    XPS_SEGMENT_TYPE_ARC_LARGE_COUNTERCLOCKWISE = 0x00000002,
    ///The line segment is an arc that covers at most 180 degrees and is drawn in a clockwise direction from the start
    ///point to the end point.
    XPS_SEGMENT_TYPE_ARC_SMALL_CLOCKWISE        = 0x00000003,
    ///The line segment is an arc that covers at most 180 degrees and is drawn in a counterclockwise direction from the
    ///start point to the end point.
    XPS_SEGMENT_TYPE_ARC_SMALL_COUNTERCLOCKWISE = 0x00000004,
    ///The line segment is a cubic Bezier curve that is drawn between two points.
    XPS_SEGMENT_TYPE_BEZIER                     = 0x00000005,
    ///The line segment is a straight line that is drawn between two points.
    XPS_SEGMENT_TYPE_LINE                       = 0x00000006,
    ///The line segment is a quadratic Bezier curve that is drawn between two points.
    XPS_SEGMENT_TYPE_QUADRATIC_BEZIER           = 0x00000007,
}

///Indicates whether all, some, or none of the segments in a figure are stroked.
alias XPS_SEGMENT_STROKE_PATTERN = int;
enum : int
{
    ///All segments in the figure are stroked.
    XPS_SEGMENT_STROKE_PATTERN_ALL   = 0x00000001,
    ///No segments in the figure are stroked.
    XPS_SEGMENT_STROKE_PATTERN_NONE  = 0x00000002,
    ///Some segments in the figure are stroked, others are not.
    XPS_SEGMENT_STROKE_PATTERN_MIXED = 0x00000003,
}

///Describes the option for embedding a font.
alias XPS_FONT_EMBEDDING = int;
enum : int
{
    ///The embedded font is neither obfuscated nor restricted.
    XPS_FONT_EMBEDDING_NORMAL                  = 0x00000001,
    ///The embedded font is obfuscated but not restricted.
    XPS_FONT_EMBEDDING_OBFUSCATED              = 0x00000002,
    ///The embedded font is obfuscated and restricted.
    XPS_FONT_EMBEDDING_RESTRICTED              = 0x00000003,
    ///The font is restricted but not obfuscated. This value cannot be set by an application. It is set when the
    ///document being deserialized contains a restricted font that is not obfuscated. Restricted fonts should be
    ///obfuscated, so this value usually indicates an error in the application that created the XPS document being
    ///deserialized.
    XPS_FONT_EMBEDDING_RESTRICTED_UNOBFUSCATED = 0x00000004,
}

///Describes the type of an object that is derived from IXpsOMShareable.
alias XPS_OBJECT_TYPE = int;
enum : int
{
    ///The object is an IXpsOMCanvas interface.
    XPS_OBJECT_TYPE_CANVAS                = 0x00000001,
    ///The object is an IXpsOMGlyphs interface.
    XPS_OBJECT_TYPE_GLYPHS                = 0x00000002,
    ///The object is an IXpsOMPath interface.
    XPS_OBJECT_TYPE_PATH                  = 0x00000003,
    ///The object is an IXpsOMMatrixTransform interface.
    XPS_OBJECT_TYPE_MATRIX_TRANSFORM      = 0x00000004,
    ///The object is an IXpsOMGeometry interface.
    XPS_OBJECT_TYPE_GEOMETRY              = 0x00000005,
    ///The object is an IXpsOMSolidColorBrush interface.
    XPS_OBJECT_TYPE_SOLID_COLOR_BRUSH     = 0x00000006,
    ///The object is an IXpsOMImageBrush interface.
    XPS_OBJECT_TYPE_IMAGE_BRUSH           = 0x00000007,
    ///The object is an IXpsOMLinearGradientBrush interface.
    XPS_OBJECT_TYPE_LINEAR_GRADIENT_BRUSH = 0x00000008,
    ///The object is an IXpsOMRadialGradientBrush interface.
    XPS_OBJECT_TYPE_RADIAL_GRADIENT_BRUSH = 0x00000009,
    ///The object is an IXpsOMVisualBrush interface.
    XPS_OBJECT_TYPE_VISUAL_BRUSH          = 0x0000000a,
}

///Describes the size of a thumbnail image.
alias XPS_THUMBNAIL_SIZE = int;
enum : int
{
    ///The thumbnail image is 32 pixels wide and 32 pixels high.
    XPS_THUMBNAIL_SIZE_VERYSMALL = 0x00000001,
    ///The thumbnail image is 64 pixels wide and 64 pixels high.
    XPS_THUMBNAIL_SIZE_SMALL     = 0x00000002,
    ///The thumbnail image is 100 pixels wide and 100 pixels high.
    XPS_THUMBNAIL_SIZE_MEDIUM    = 0x00000003,
    ///The thumbnail image is 300 pixels wide and 300 pixels high.
    XPS_THUMBNAIL_SIZE_LARGE     = 0x00000004,
}

///Specifies whether the content of the XPS OM will be interleaved when it is written to a file or a stream.
alias XPS_INTERLEAVING = int;
enum : int
{
    ///The content of the XPS OM is not interleaved. The document parts are written as complete parts.
    XPS_INTERLEAVING_OFF = 0x00000001,
    ///The content of the XPS OM is interleaved. The document parts are divided into smaller pieces before they are
    ///written.
    XPS_INTERLEAVING_ON  = 0x00000002,
}

///Indicates the format into which the document was serialized.
alias XPS_DOCUMENT_TYPE = int;
enum : int
{
    ///For documents which have yet to be serialized, and whose type is yet to be determined.
    XPS_DOCUMENT_TYPE_UNSPECIFIED = 0x00000001,
    ///MSXPS v1.0 document format.
    XPS_DOCUMENT_TYPE_XPS         = 0x00000002,
    ///OpenXPS v1.0 document format.
    XPS_DOCUMENT_TYPE_OPENXPS     = 0x00000003,
}

///Describes the status of a document's digital signature.
alias XPS_SIGNATURE_STATUS = int;
enum : int
{
    ///The signature violates one or more signing rules stated in section 10.2.1.2 of the XML Paper Specification. These
    ///rules describe the parts or relationships that must or must not be signed. A signature that is incompliant must
    ///be created as such. Changing signed content cannot make a valid signature incompliant. One example of an
    ///incompliant signature is the signature of a package that has an unknown relationships type at the root.
    XPS_SIGNATURE_STATUS_INCOMPLIANT  = 0x00000001,
    ///The signature does not include parts that must be signed. If a valid XPS signature is created and the XPS
    ///document contents are later modified, the signature will become incomplete or broken. For example, removing a
    ///page from a FixedDocument makes the signature incomplete; it also breaks the signature, but the fact that the
    ///signature is incomplete is of greater importance.
    XPS_SIGNATURE_STATUS_INCOMPLETE   = 0x00000002,
    ///This is a compliant digital signature, but it fails the signature validation routines described in the <i>Open
    ///Packaging Conventions</i> (refer to See Also). Modification of the markup in a FixedPage that has been signed
    ///breaks the signature.
    XPS_SIGNATURE_STATUS_BROKEN       = 0x00000003,
    ///This is not an incompliant or broken digital signature, but the signed content (parts and relationships) includes
    ///elements or attributes from an unknown namespace introduced through the markup compatibility mechanisms.
    XPS_SIGNATURE_STATUS_QUESTIONABLE = 0x00000004,
    ///This is a valid signature: it is not broken, incompliant, or questionable. The application, however, must still
    ///check the certificate trust chain, revocation lists, and expiration dates.
    XPS_SIGNATURE_STATUS_VALID        = 0x00000005,
}

///A bitwise enumerator that indicates which, if any, optional parts of an XPS document are signed.
alias XPS_SIGN_POLICY = int;
enum : int
{
    ///No optional parts or relationships are signed.
    XPS_SIGN_POLICY_NONE                    = 0x00000000,
    ///The CoreProperties part and the relationships that include it are signed.
    XPS_SIGN_POLICY_CORE_PROPERTIES         = 0x00000001,
    ///The signature relationships from the signature origin part are signed. <i>Signature relationships</i> are those
    ///relationships that have a <i>digital signature</i> relationship type. <div class="alert"><b>Note</b> <p
    ///class="note">Setting the <b>XPS_SIGN_POLICY_SIGNATURE_RELATIONSHIPS</b> flag will cause the signature
    ///relationships that start from the signature origin part to be signed. Signatures that are made with this flag set
    ///will break when new signatures are added later, because new signatures add new signature relationships. </div>
    ///<div> </div>
    XPS_SIGN_POLICY_SIGNATURE_RELATIONSHIPS = 0x00000002,
    ///The PrintTicket part and the relationships that include it are signed.
    XPS_SIGN_POLICY_PRINT_TICKET            = 0x00000004,
    ///The DiscardControl part and the relationships that include it are signed.
    XPS_SIGN_POLICY_DISCARD_CONTROL         = 0x00000008,
    ///The CoreProperties part and the relationships that include it, the digital signature relationship type from the
    ///SignatureOrigin part, the PrintTicket part and the relationships that include it, and the DiscardControl part and
    ///the relationships that include it are all signed. <div class="alert"><b>Note</b> <p class="note">Setting the
    ///<b>XPS_SIGN_POLICY_ALL</b> sets the <b>XPS_SIGN_POLICY_SIGNATURE_RELATIONSHIPS</b> flag, which will cause the
    ///signature relationships that start from the signature origin part to be signed. Signatures that are made with
    ///this flag set will break when new signatures are added later, because new signatures add new signature
    ///relationships. </div> <div> </div>
    XPS_SIGN_POLICY_ALL                     = 0x0000000f,
}

///Specifies whether markup compatibility detection must be run before signing.
alias XPS_SIGN_FLAGS = int;
enum : int
{
    ///The system will check for any markup compatibility elements before signing the package. If any markup
    ///compatibility elements are found, the signing operation fails with an <b>XPS_E_MARKUP_COMPATIBILITY_ELEMENTS</b>
    ///error.
    XPS_SIGN_FLAGS_NONE                        = 0x00000000,
    ///The system will not check for any markup compatibility elements before signing the package.
    XPS_SIGN_FLAGS_IGNORE_MARKUP_COMPATIBILITY = 0x00000001,
}

///The PrintDocumentPackageCompletion enumeration specifies the status of the print operation.
enum PrintDocumentPackageCompletion : int
{
    ///The print job is running.
    PrintDocumentPackageCompletion_InProgress = 0x00000000,
    ///The print operation completed without error.
    PrintDocumentPackageCompletion_Completed  = 0x00000001,
    ///The print operation was canceled.
    PrintDocumentPackageCompletion_Canceled   = 0x00000002,
    PrintDocumentPackageCompletion_Failed     = 0x00000003,
}

///Enables users to specify which DEVMODE to use as the source of default values when a print ticket does not specify
///all possible settings.
enum EDefaultDevmodeType : int
{
    ///The user's default preferences.
    kUserDefaultDevmode    = 0x00000000,
    ///The print queue's default preferences.
    kPrinterDefaultDevmode = 0x00000001,
}

///Specifies the scope of a print ticket.
enum EPrintTicketScope : int
{
    ///The print ticket applies only to a single page.
    kPTPageScope     = 0x00000000,
    ///The print ticket applies to the whole document.
    kPTDocumentScope = 0x00000001,
    kPTJobScope      = 0x00000002,
}

// Callbacks

///The <b>AbortProc</b> function is an application-defined callback function used with the SetAbortProc function. It is
///called when a print job is to be canceled during spooling. The <b>ABORTPROC</b> type defines a pointer to this
///callback function. <b>AbortProc</b> is a placeholder for the application-defined function name.
///Params:
///    Arg1 = 
///    Arg2 = 
///Returns:
///    The callback function should return <b>TRUE</b> to continue the print job or <b>FALSE</b> to cancel the print
///    job.
///    
alias ABORTPROC = BOOL function(HDC param0, int param1);

// Structs


///The <b>DRAWPATRECT</b> structure defines a rectangle to be created.
struct DRAWPATRECT
{
    ///The upper-left corner of the rectangle, in logical units.
    POINT  ptPosition;
    ///The lower-right corner of the rectangle, in logical units.
    POINT  ptSize;
    ///The style of the rectangle. It can be one of the following. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
    ///<tr> <td>0</td> <td>Black rectangle.</td> </tr> <tr> <td>1</td> <td>White rectangle.</td> </tr> <tr> <td>2</td>
    ///<td>Gray rectangle. Used with <b>wPattern</b>.</td> </tr> </table>
    ushort wStyle;
    ///Amount of grayness of the rectangle, as a percentage (0-100). A value of 0 means a white rectangle and 100 means
    ///a black rectangle. This is only used when <b>wStyle</b> is 2.
    ushort wPattern;
}

///The <b>PSINJECTDATA</b> structure is a header for the input buffer used with the POSTSCRIPT_INJECTION printer escape
///function.
struct PSINJECTDATA
{
    ///The number of bytes of raw data to be injected. The raw data begins immediately following this structure. This
    ///size does not include the size of the <b>PSINJECTDATA</b> structure.
    uint   DataBytes;
    ///Specifies where to inject the raw data in the PostScript output. This member can be one of the following values.
    ///<table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td>PSINJECT_BEGINSTREAM</td> <td>Before the first byte
    ///of job stream.</td> </tr> <tr> <td>PSINJECT_PSADOBE</td> <td>Before %!PS-Adobe.</td> </tr> <tr>
    ///<td>PSINJECT_PAGESATEND</td> <td>Replaces driver's %%Pages (atend).</td> </tr> <tr> <td>PSINJECT_PAGES</td>
    ///<td>Replaces driver's %%Pages nnn.</td> </tr> <tr> <td>PSINJECT_DOCNEEDEDRES</td> <td>After
    ///%%DocumentNeededResources.</td> </tr> <tr> <td>PSINJECT_DOCSUPPLIEDRES</td> <td>After
    ///%%DocumentSuppliedResources.</td> </tr> <tr> <td>PSINJECT_PAGEORDER</td> <td>Replaces driver's %%PageOrder.</td>
    ///</tr> <tr> <td>PSINJECT_ORIENTATION</td> <td>Replaces driver's %%Orientation.</td> </tr> <tr>
    ///<td>PSINJECT_BOUNDINGBOX</td> <td>Replaces driver's %%BoundingBox.</td> </tr> <tr>
    ///<td>PSINJECT_DOCUMENTPROCESSCOLORS</td> <td>Replaces driver's %%DocumentProcessColors &lt;color&gt;.</td> </tr>
    ///<tr> <td>PSINJECT_COMMENTS</td> <td>Before %%EndComments.</td> </tr> <tr> <td>PSINJECT_BEGINDEFAULTS</td>
    ///<td>After %%BeginDefaults.</td> </tr> <tr> <td>PSINJECT_ENDDEFAULTS</td> <td>Before %%EndDefaults.</td> </tr>
    ///<tr> <td>PSINJECT_BEGINPROLOG</td> <td>After %%BeginProlog.</td> </tr> <tr> <td>PSINJECT_ENDPROLOG</td>
    ///<td>Before %%EndProlog.</td> </tr> <tr> <td>PSINJECT_BEGINSETUP</td> <td>After %%BeginSetup.</td> </tr> <tr>
    ///<td>PSINJECT_ENDSETUP</td> <td>Before %%EndSetup.</td> </tr> <tr> <td>PSINJECT_TRAILER</td> <td>After
    ///%%Trailer</td> </tr> <tr> <td>PSINJECT_EOF</td> <td>After %%EOF</td> </tr> <tr> <td>PSINJECT_ENDSTREAM</td>
    ///<td>After the last byte of job stream</td> </tr> <tr> <td>PSINJECT_DOCUMENTPROCESSCOLORSATEND</td> <td>Replaces
    ///driver's %%DocumentProcessColors (atend)</td> </tr> <tr> <td colspan="2"><b>Page level injection points</b></td>
    ///</tr> <tr> <td>PSINJECT_PAGENUMBER</td> <td>Replaces driver's %%Page</td> </tr> <tr>
    ///<td>PSINJECT_BEGINPAGESETUP</td> <td>After %%BeginPageSetup</td> </tr> <tr> <td>PSINJECT_ENDPAGESETUP</td>
    ///<td>Before %%EndPageSetup</td> </tr> <tr> <td>PSINJECT_PAGETRAILER</td> <td>After %%PageTrailer</td> </tr> <tr>
    ///<td>PSINJECT_PLATECOLOR</td> <td>Replace driver's %%PlateColor: &lt;color&gt;</td> </tr> <tr>
    ///<td>PSINJECT_SHOWPAGE</td> <td>Before showpage operator</td> </tr> <tr> <td>PSINJECT_PAGEBBOX</td> <td>Replaces
    ///driver's %%PageBoundingBox</td> </tr> <tr> <td>PSINJECT_ENDPAGECOMMENTS</td> <td>Before %%EndPageComments</td>
    ///</tr> <tr> <td>PSINJECT_VMSAVE</td> <td>Before save operator</td> </tr> <tr> <td>PSINJECT_VMRESTORE</td>
    ///<td>After restore operator</td> </tr> </table>
    ushort InjectionPoint;
    ///The page number (starting from 1) to which the injection data is applied. Specify zero to apply the injection
    ///data to all pages. This member is meaningful only for page level injection points starting from
    ///PSINJECT_PAGENUMBER. For other injection points, set <b>PageNumber</b> to zero.
    ushort PageNumber;
}

///The <b>PSFEATURE_OUTPUT</b> structure contains information about PostScript driver output options. This structure is
///used with the GET_PS_FEATURESETTING printer escape function.
struct PSFEATURE_OUTPUT
{
    ///<b>TRUE</b> if PostScript output is page-independent or <b>FALSE</b> if PostScript output is page-dependent.
    BOOL bPageIndependent;
    ///<b>TRUE</b> if printer feature code (setpagedevice's) is included or <b>FALSE</b> if all printer feature code is
    ///suppressed.
    BOOL bSetPageDevice;
}

///The <b>PSFEATURE_CUSTPAPER</b> structure contains information about a custom paper size for a PostScript driver. This
///structure is used with the GET_PS_FEATURESETTING printer escape function.
struct PSFEATURE_CUSTPAPER
{
    ///Indicates the custom paper orientation. This member can be 0 to 3 if custom page size is selected. Otherwise, it
    ///is 1 and all other structure members are zero
    int lOrientation;
    ///Custom page width, in points.
    int lWidth;
    ///Custom page height, in points.
    int lHeight;
    ///Custom page width offset, in points.
    int lWidthOffset;
    ///Custom page height offset, in points.
    int lHeightOffset;
}

///The <b>DEVMODE</b> data structure contains information about the initialization and environment of a printer or a
///display device.
struct DEVMODEA
{
    ///A zero-terminated character array that specifies the "friendly" name of the printer or display; for example,
    ///"PCL/HP LaserJet" in the case of PCL/HP LaserJet. This string is unique among device drivers. Note that this name
    ///may be truncated to fit in the <b>dmDeviceName</b> array.
    ubyte[32] dmDeviceName;
    ///The version number of the initialization data specification on which the structure is based. To ensure the
    ///correct version is used for any operating system, use DM_SPECVERSION.
    ushort    dmSpecVersion;
    ///The driver version number assigned by the driver developer.
    ushort    dmDriverVersion;
    ///Specifies the size, in bytes, of the <b>DEVMODE</b> structure, not including any private driver-specific data
    ///that might follow the structure's public members. Set this member to <code>sizeof (DEVMODE)</code> to indicate
    ///the version of the <b>DEVMODE</b> structure being used.
    ushort    dmSize;
    ///Contains the number of bytes of private driver-data that follow this structure. If a device driver does not use
    ///device-specific information, set this member to zero.
    ushort    dmDriverExtra;
    ///Specifies whether certain members of the <b>DEVMODE</b> structure have been initialized. If a member is
    ///initialized, its corresponding bit is set, otherwise the bit is clear. A driver supports only those
    ///<b>DEVMODE</b> members that are appropriate for the printer or display technology. The following values are
    ///defined, and are listed here with the corresponding structure members. <table> <tr> <th>Value</th> <th>Structure
    ///member</th> </tr> <tr> <td>DM_ORIENTATION</td> <td><b>dmOrientation</b></td> </tr> <tr> <td>DM_PAPERSIZE</td>
    ///<td><b>dmPaperSize</b></td> </tr> <tr> <td>DM_PAPERLENGTH</td> <td><b>dmPaperLength</b></td> </tr> <tr>
    ///<td>DM_PAPERWIDTH</td> <td><b>dmPaperWidth</b></td> </tr> <tr> <td>DM_SCALE</td> <td><b>dmScale</b></td> </tr>
    ///<tr> <td>DM_COPIES</td> <td><b>dmCopies</b></td> </tr> <tr> <td>DM_DEFAULTSOURCE</td>
    ///<td><b>dmDefaultSource</b></td> </tr> <tr> <td>DM_PRINTQUALITY</td> <td><b>dmPrintQuality</b></td> </tr> <tr>
    ///<td>DM_POSITION</td> <td><b>dmPosition</b></td> </tr> <tr> <td>DM_DISPLAYORIENTATION</td>
    ///<td><b>dmDisplayOrientation</b></td> </tr> <tr> <td>DM_DISPLAYFIXEDOUTPUT</td>
    ///<td><b>dmDisplayFixedOutput</b></td> </tr> <tr> <td>DM_COLOR</td> <td><b>dmColor</b></td> </tr> <tr>
    ///<td>DM_DUPLEX</td> <td><b>dmDuplex</b></td> </tr> <tr> <td>DM_YRESOLUTION</td> <td><b>dmYResolution</b></td>
    ///</tr> <tr> <td>DM_TTOPTION</td> <td><b>dmTTOption</b></td> </tr> <tr> <td>DM_COLLATE</td>
    ///<td><b>dmCollate</b></td> </tr> <tr> <td>DM_FORMNAME</td> <td><b>dmFormName</b></td> </tr> <tr>
    ///<td>DM_LOGPIXELS</td> <td><b>dmLogPixels</b></td> </tr> <tr> <td>DM_BITSPERPEL</td> <td><b>dmBitsPerPel</b></td>
    ///</tr> <tr> <td>DM_PELSWIDTH</td> <td><b>dmPelsWidth</b></td> </tr> <tr> <td>DM_PELSHEIGHT</td>
    ///<td><b>dmPelsHeight</b></td> </tr> <tr> <td>DM_DISPLAYFLAGS</td> <td><b>dmDisplayFlags</b></td> </tr> <tr>
    ///<td>DM_NUP</td> <td><b>dmNup</b></td> </tr> <tr> <td>DM_DISPLAYFREQUENCY</td> <td><b>dmDisplayFrequency</b></td>
    ///</tr> <tr> <td>DM_ICMMETHOD</td> <td><b>dmICMMethod</b></td> </tr> <tr> <td>DM_ICMINTENT</td>
    ///<td><b>dmICMIntent</b></td> </tr> <tr> <td>DM_MEDIATYPE</td> <td><b>dmMediaType</b></td> </tr> <tr>
    ///<td>DM_DITHERTYPE</td> <td><b>dmDitherType</b></td> </tr> <tr> <td>DM_PANNINGWIDTH</td>
    ///<td><b>dmPanningWidth</b></td> </tr> <tr> <td>DM_PANNINGHEIGHT</td> <td><b>dmPanningHeight</b></td> </tr>
    ///</table>
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
    ///Switches between color and monochrome on color printers. The following are the possible values: <ul>
    ///<li>DMCOLOR_COLOR</li> <li>DMCOLOR_MONOCHROME</li> </ul>
    short     dmColor;
    ///Selects duplex or double-sided printing for printers capable of duplex printing. Following are the possible
    ///values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td>DMDUP_SIMPLEX</td> <td>Normal (nonduplex)
    ///printing.</td> </tr> <tr> <td>DMDUP_HORIZONTAL</td> <td>Short-edge binding, that is, the long edge of the page is
    ///horizontal.</td> </tr> <tr> <td>DMDUP_VERTICAL</td> <td>Long-edge binding, that is, the long edge of the page is
    ///vertical.</td> </tr> </table>
    short     dmDuplex;
    ///Specifies the y-resolution, in dots per inch, of the printer. If the printer initializes this member, the
    ///<b>dmPrintQuality</b> member specifies the x-resolution, in dots per inch, of the printer.
    short     dmYResolution;
    ///Specifies how TrueType fonts should be printed. This member can be one of the following values. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td>DMTT_BITMAP</td> <td>Prints TrueType fonts as graphics. This is
    ///the default action for dot-matrix printers.</td> </tr> <tr> <td>DMTT_DOWNLOAD</td> <td>Downloads TrueType fonts
    ///as soft fonts. This is the default action for Hewlett-Packard printers that use Printer Control Language
    ///(PCL).</td> </tr> <tr> <td>DMTT_DOWNLOAD_OUTLINE</td> <td> Downloads TrueType fonts as outline soft fonts. </td>
    ///</tr> <tr> <td>DMTT_SUBDEV</td> <td>Substitutes device fonts for TrueType fonts. This is the default action for
    ///PostScript printers.</td> </tr> </table>
    short     dmTTOption;
    ///Specifies whether collation should be used when printing multiple copies. (This member is ignored unless the
    ///printer driver indicates support for collation by setting the <b>dmFields</b> member to DM_COLLATE.) This member
    ///can be one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
    ///<td>DMCOLLATE_TRUE</td> <td>Collate when printing multiple copies.</td> </tr> <tr> <td>DMCOLLATE_FALSE</td>
    ///<td>Do not collate when printing multiple copies.</td> </tr> </table>
    short     dmCollate;
    ///A zero-terminated character array that specifies the name of the form to use; for example, "Letter" or "Legal". A
    ///complete set of names can be retrieved by using the EnumForms function.
    ubyte[32] dmFormName;
    ///The number of pixels per logical inch. Printer drivers do not use this member.
    ushort    dmLogPixels;
    ///Specifies the color resolution, in bits per pixel, of the display device (for example: 4 bits for 16 colors, 8
    ///bits for 256 colors, or 16 bits for 65,536 colors). Display drivers use this member, for example, in the
    ///ChangeDisplaySettings function. Printer drivers do not use this member.
    uint      dmBitsPerPel;
    ///Specifies the width, in pixels, of the visible device surface. Display drivers use this member, for example, in
    ///the ChangeDisplaySettings function. Printer drivers do not use this member.
    uint      dmPelsWidth;
    ///Specifies the height, in pixels, of the visible device surface. Display drivers use this member, for example, in
    ///the ChangeDisplaySettings function. Printer drivers do not use this member.
    uint      dmPelsHeight;
    union
    {
        uint dmDisplayFlags;
        uint dmNup;
    }
    ///Specifies the frequency, in hertz (cycles per second), of the display device in a particular mode. This value is
    ///also known as the display device's vertical refresh rate. Display drivers use this member. It is used, for
    ///example, in the ChangeDisplaySettings function. Printer drivers do not use this member. When you call the
    ///EnumDisplaySettings function, the <b>dmDisplayFrequency</b> member may return with the value 0 or 1. These values
    ///represent the display hardware's default refresh rate. This default rate is typically set by switches on a
    ///display card or computer motherboard, or by a configuration program that does not use display functions such as
    ///ChangeDisplaySettings.
    uint      dmDisplayFrequency;
    ///Specifies how ICM is handled. For a non-ICM application, this member determines if ICM is enabled or disabled.
    ///For ICM applications, the system examines this member to determine how to handle ICM support. This member can be
    ///one of the following predefined values, or a driver-defined value greater than or equal to the value of
    ///DMICMMETHOD_USER. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td>DMICMMETHOD_NONE</td> <td>Specifies
    ///that ICM is disabled.</td> </tr> <tr> <td>DMICMMETHOD_SYSTEM</td> <td>Specifies that ICM is handled by
    ///Windows.</td> </tr> <tr> <td>DMICMMETHOD_DRIVER</td> <td>Specifies that ICM is handled by the device driver.</td>
    ///</tr> <tr> <td>DMICMMETHOD_DEVICE</td> <td>Specifies that ICM is handled by the destination device.</td> </tr>
    ///</table> The printer driver must provide a user interface for setting this member. Most printer drivers support
    ///only the DMICMMETHOD_SYSTEM or DMICMMETHOD_NONE value. Drivers for PostScript printers support all values.
    uint      dmICMMethod;
    ///Specifies which color matching method, or intent, should be used by default. This member is primarily for non-ICM
    ///applications. ICM applications can establish intents by using the ICM functions. This member can be one of the
    ///following predefined values, or a driver defined value greater than or equal to the value of DMICM_USER. <table>
    ///<tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td>DMICM_ABS_COLORIMETRIC</td> <td>Color matching should
    ///optimize to match the exact color requested without white point mapping. This value is most appropriate for use
    ///with proofing.</td> </tr> <tr> <td>DMICM_COLORIMETRIC</td> <td>Color matching should optimize to match the exact
    ///color requested. This value is most appropriate for use with business logos or other images when an exact color
    ///match is desired.</td> </tr> <tr> <td>DMICM_CONTRAST</td> <td>Color matching should optimize for color contrast.
    ///This value is the most appropriate choice for scanned or photographic images when dithering is desired.</td>
    ///</tr> <tr> <td>DMICM_SATURATE</td> <td>Color matching should optimize for color saturation. This value is the
    ///most appropriate choice for business graphs when dithering is not desired.</td> </tr> </table>
    uint      dmICMIntent;
    ///Specifies the type of media being printed on. The member can be one of the following predefined values, or a
    ///driver-defined value greater than or equal to the value of DMMEDIA_USER. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td>DMMEDIA_STANDARD</td> <td>Plain paper.</td> </tr> <tr> <td>DMMEDIA_GLOSSY</td>
    ///<td>Glossy paper.</td> </tr> <tr> <td>DMMEDIA_TRANSPARENCY</td> <td>Transparent film.</td> </tr> </table> To
    ///retrieve a list of the available media types for a printer, use the DeviceCapabilities function with the
    ///DC_MEDIATYPES flag.
    uint      dmMediaType;
    ///Specifies how dithering is to be done. The member can be one of the following predefined values, or a
    ///driver-defined value greater than or equal to the value of DMDITHER_USER. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td>DMDITHER_NONE</td> <td>No dithering.</td> </tr> <tr> <td>DMDITHER_COARSE</td>
    ///<td>Dithering with a coarse brush.</td> </tr> <tr> <td>DMDITHER_FINE</td> <td>Dithering with a fine brush.</td>
    ///</tr> <tr> <td>DMDITHER_LINEART</td> <td>Line art dithering, a special dithering method that produces well
    ///defined borders between black, white, and gray scaling. It is not suitable for images that include continuous
    ///graduations in intensity and hue, such as scanned photographs.</td> </tr> <tr> <td>DMDITHER_GRAYSCALE</td>
    ///<td>Device does gray scaling.</td> </tr> </table>
    uint      dmDitherType;
    ///Not used; must be zero.
    uint      dmReserved1;
    ///Not used; must be zero.
    uint      dmReserved2;
    ///This member must be zero.
    uint      dmPanningWidth;
    ///This member must be zero.
    uint      dmPanningHeight;
}

///The <b>DOCINFO</b> structure contains the input and output file names and other information used by the StartDoc
///function.
struct DOCINFOA
{
    ///The size, in bytes, of the structure.
    int          cbSize;
    ///Pointer to a null-terminated string that specifies the name of the document.
    const(char)* lpszDocName;
    ///Pointer to a null-terminated string that specifies the name of an output file. If this pointer is <b>NULL</b>,
    ///the output will be sent to the device identified by the device context handle that was passed to the StartDoc
    ///function.
    const(char)* lpszOutput;
    ///Pointer to a null-terminated string that specifies the type of data used to record the print job. The legal
    ///values for this member can be found by calling EnumPrintProcessorDatatypes and can include such values as raw,
    ///emf, or XPS_PASS. This member can be <b>NULL</b>. Note that the requested data type might be ignored.
    const(char)* lpszDatatype;
    ///Specifies additional information about the print job. This member must be zero or one of the following values.
    ///<table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td>DI_APPBANDING</td> <td>Applications that use banding
    ///should set this flag for optimal performance during printing.</td> </tr> <tr> <td>DI_ROPS_READ_DESTINATION</td>
    ///<td>The application will use raster operations that involve reading from the destination surface.</td> </tr>
    ///</table>
    uint         fwType;
}

///The <b>DOCINFO</b> structure contains the input and output file names and other information used by the StartDoc
///function.
struct DOCINFOW
{
    ///The size, in bytes, of the structure.
    int           cbSize;
    ///Pointer to a null-terminated string that specifies the name of the document.
    const(wchar)* lpszDocName;
    ///Pointer to a null-terminated string that specifies the name of an output file. If this pointer is <b>NULL</b>,
    ///the output will be sent to the device identified by the device context handle that was passed to the StartDoc
    ///function.
    const(wchar)* lpszOutput;
    ///Pointer to a null-terminated string that specifies the type of data used to record the print job. The legal
    ///values for this member can be found by calling EnumPrintProcessorDatatypes and can include such values as raw,
    ///emf, or XPS_PASS. This member can be <b>NULL</b>. Note that the requested data type might be ignored.
    const(wchar)* lpszDatatype;
    ///Specifies additional information about the print job. This member must be zero or one of the following values.
    ///<table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td>DI_APPBANDING</td> <td>Applications that use banding
    ///should set this flag for optimal performance during printing.</td> </tr> <tr> <td>DI_ROPS_READ_DESTINATION</td>
    ///<td>The application will use raster operations that involve reading from the destination surface.</td> </tr>
    ///</table>
    uint          fwType;
}

///Represents an x- and y-coordinate pair in two-dimensional space.
struct XPS_POINT
{
    ///The x-coordinate of a point.
    float x;
    ///The y-coordinate of a point.
    float y;
}

///Describes the size of an object.
struct XPS_SIZE
{
    ///A non-negative value that represents the object's size in the horizontal (x) dimension.
    float width;
    ///A non-negative value that represents the object's size in the vertical (y) dimension.
    float height;
}

///Describes the width, height, and location of a rectangle.
struct XPS_RECT
{
    ///The x-coordinate of the rectangle's left side.
    float x;
    ///The y-coordinate of the rectangle's top side.
    float y;
    ///A non-negative value that represents the object's size in the horizontal (x) dimension.
    float width;
    ///A non-negative value that represents the object's size in the vertical (y) dimension.
    float height;
}

///This structure describes a dash element of a path.
struct XPS_DASH
{
    ///Length of the visible segment of the dash element.
    float length;
    ///Length of the space between the visible segments of the dash sequence.
    float gap;
}

///Describes a glyph-to-index mapping.
struct XPS_GLYPH_MAPPING
{
    ///Index of the first Unicode character in the mapping string.
    uint   unicodeStringStart;
    ///Number of characters in the mapping string.
    ushort unicodeStringLength;
    ///The glyph array's first index that corresponds to <b>unicodeStringStart</b>.
    uint   glyphIndicesStart;
    ///Length of index mapping.
    ushort glyphIndicesLength;
}

///Describes the left two columns of a 3-by-3 matrix.
struct XPS_MATRIX
{
    ///The value in the left column of the first row of the matrix.
    float m11;
    ///The value in the center column of the first row of the matrix.
    float m12;
    ///The value in the left column of the second row of the matrix.
    float m21;
    ///The value in the center column of the second row of the matrix.
    float m22;
    ///The value in the left column of the third row of the matrix. This value is also the x-offset.
    float m31;
    ///The value in the center column of the third row of the matrix. This value is also the y-offset.
    float m32;
}

///The contents of the XPS_COLOR structure when the <i>colorType</i> is <b>XPS_COLOR_TYPE_CONTEXT</b>.
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

///Defines a payload to be used by the PackageStatusUpdated method. This structure is a generic version of
///XPS_JOB_STATUS.
struct PrintDocumentPackageStatus
{
    ///The job ID.
    uint    JobId;
    ///The zero-based index of the most recently processed document.
    int     CurrentDocument;
    ///The zero-based index of the most recently processed page in the current document
    int     CurrentPage;
    ///A running total of the number of pages that have been processed by the print job.
    int     CurrentPageTotal;
    ///The completion status of the job.
    PrintDocumentPackageCompletion Completion;
    ///The error state of the job.
    HRESULT PackageStatus;
}

struct HPTPROVIDER__
{
    int unused;
}

// Functions

///The <b>DeviceCapabilities</b> function retrieves the capabilities of a printer driver.
///Params:
///    pDevice = A pointer to a null-terminated string that contains the name of the printer. Note that this is the name of the
///              printer, not of the printer driver.
///    pPort = A pointer to a null-terminated string that contains the name of the port to which the device is connected, such
///            as LPT1.
///    fwCapability = The capabilities to be queried. This parameter can be one of the following values. <table> <tr> <th>Value</th>
///                   <th>Meaning</th> </tr> <tr> <td width="40%"><a id="DC_BINNAMES"></a><a id="dc_binnames"></a><dl>
///                   <dt><b>DC_BINNAMES</b></dt> </dl> </td> <td width="60%"> Retrieves the names of the printer's paper bins. The
///                   <i>pOutput</i> buffer receives an array of string buffers. Each string buffer is 24 characters long and contains
///                   the name of a paper bin. The return value indicates the number of entries in the array. The name strings are
///                   null-terminated unless the name is 24 characters long. If <i>pOutput</i> is <b>NULL</b>, the return value is the
///                   number of bin entries required. </td> </tr> <tr> <td width="40%"><a id="DC_BINS"></a><a id="dc_bins"></a><dl>
///                   <dt><b>DC_BINS</b></dt> </dl> </td> <td width="60%"> Retrieves a list of available paper bins. The <i>pOutput</i>
///                   buffer receives an array of <b>WORD</b> values that indicate the available paper sources for the printer. The
///                   return value indicates the number of entries in the array. For a list of the possible array values, see the
///                   description of the <b>dmDefaultSource</b> member of the DEVMODE structure. If <i>pOutput</i> is <b>NULL</b>, the
///                   return value indicates the required number of entries in the array. </td> </tr> <tr> <td width="40%"><a
///                   id="DC_COLLATE"></a><a id="dc_collate"></a><dl> <dt><b>DC_COLLATE</b></dt> </dl> </td> <td width="60%"> If the
///                   printer supports collating, the return value is 1; otherwise, the return value is zero. The <i>pOutput</i>
///                   parameter is not used. </td> </tr> <tr> <td width="40%"><a id="DC_COLORDEVICE"></a><a
///                   id="dc_colordevice"></a><dl> <dt><b>DC_COLORDEVICE</b></dt> </dl> </td> <td width="60%"> If the printer supports
///                   color printing, the return value is 1; otherwise, the return value is zero. The <i>pOutput</i> parameter is not
///                   used. </td> </tr> <tr> <td width="40%"><a id="DC_COPIES"></a><a id="dc_copies"></a><dl> <dt><b>DC_COPIES</b></dt>
///                   </dl> </td> <td width="60%"> Returns the number of copies the device can print. </td> </tr> <tr> <td
///                   width="40%"><a id="DC_DRIVER"></a><a id="dc_driver"></a><dl> <dt><b>DC_DRIVER</b></dt> </dl> </td> <td
///                   width="60%"> Returns the version number of the printer driver. </td> </tr> <tr> <td width="40%"><a
///                   id="DC_DUPLEX"></a><a id="dc_duplex"></a><dl> <dt><b>DC_DUPLEX</b></dt> </dl> </td> <td width="60%"> If the
///                   printer supports duplex printing, the return value is 1; otherwise, the return value is zero. The <i>pOutput</i>
///                   parameter is not used. </td> </tr> <tr> <td width="40%"><a id="DC_ENUMRESOLUTIONS"></a><a
///                   id="dc_enumresolutions"></a><dl> <dt><b>DC_ENUMRESOLUTIONS</b></dt> </dl> </td> <td width="60%"> Retrieves a list
///                   of the resolutions supported by the printer. The <i>pOutput</i> buffer receives an array of <b>LONG</b> values.
///                   For each supported resolution, the array contains a pair of <b>LONG</b> values that specify the x and y
///                   dimensions of the resolution, in dots per inch. The return value indicates the number of supported resolutions.
///                   If <i>pOutput</i> is <b>NULL</b>, the return value indicates the number of supported resolutions. </td> </tr>
///                   <tr> <td width="40%"><a id="DC_EXTRA"></a><a id="dc_extra"></a><dl> <dt><b>DC_EXTRA</b></dt> </dl> </td> <td
///                   width="60%"> Returns the number of bytes required for the device-specific portion of the DEVMODE structure for
///                   the printer driver. </td> </tr> <tr> <td width="40%"><a id="DC_FIELDS"></a><a id="dc_fields"></a><dl>
///                   <dt><b>DC_FIELDS</b></dt> </dl> </td> <td width="60%"> Returns the <b>dmFields</b> member of the printer driver's
///                   DEVMODE structure. The <b>dmFields</b> member indicates which members in the device-independent portion of the
///                   structure are supported by the printer driver. </td> </tr> <tr> <td width="40%"><a
///                   id="DC_FILEDEPENDENCIES"></a><a id="dc_filedependencies"></a><dl> <dt><b>DC_FILEDEPENDENCIES</b></dt> </dl> </td>
///                   <td width="60%"> Retrieves the names of any additional files that need to be loaded when a driver is installed.
///                   The <i>pOutput</i> buffer receives an array of string buffers. Each string buffer is 64 characters long and
///                   contains the name of a file. The return value indicates the number of entries in the array. The name strings are
///                   null-terminated unless the name is 64 characters long. If <i>pOutput</i> is <b>NULL</b>, the return value is the
///                   number of files. </td> </tr> <tr> <td width="40%"><a id="DC_MAXEXTENT"></a><a id="dc_maxextent"></a><dl>
///                   <dt><b>DC_MAXEXTENT</b></dt> </dl> </td> <td width="60%"> Returns the maximum paper size that the
///                   <b>dmPaperLength</b> and <b>dmPaperWidth</b> members of the printer driver's DEVMODE structure can specify. The
///                   LOWORD of the return value contains the maximum <b>dmPaperWidth</b> value, and the HIWORD contains the maximum
///                   <b>dmPaperLength</b> value. </td> </tr> <tr> <td width="40%"><a id="DC_MEDIAREADY"></a><a
///                   id="dc_mediaready"></a><dl> <dt><b>DC_MEDIAREADY</b></dt> </dl> </td> <td width="60%"> Retrieves the names of the
///                   paper forms that are currently available for use. The <i>pOutput</i> buffer receives an array of string buffers.
///                   Each string buffer is 64 characters long and contains the name of a paper form. The return value indicates the
///                   number of entries in the array. The name strings are null-terminated unless the name is 64 characters long. If
///                   <i>pOutput</i> is <b>NULL</b>, the return value is the number of paper forms. </td> </tr> <tr> <td width="40%"><a
///                   id="DC_MEDIATYPENAMES"></a><a id="dc_mediatypenames"></a><dl> <dt><b>DC_MEDIATYPENAMES</b></dt> </dl> </td> <td
///                   width="60%"> Retrieves the names of the supported media types. The <i>pOutput</i> buffer receives an array of
///                   string buffers. Each string buffer is 64 characters long and contains the name of a supported media type. The
///                   return value indicates the number of entries in the array. The strings are null-terminated unless the name is 64
///                   characters long. If <i>pOutput</i> is <b>NULL</b>, the return value is the number of media type names required.
///                   </td> </tr> <tr> <td width="40%"><a id="DC_MEDIATYPES"></a><a id="dc_mediatypes"></a><dl>
///                   <dt><b>DC_MEDIATYPES</b></dt> </dl> </td> <td width="60%"> Retrieves a list of supported media types. The
///                   <i>pOutput</i> buffer receives an array of DWORD values that indicate the supported media types. The return value
///                   indicates the number of entries in the array. For a list of possible array values, see the description of the
///                   <b>dmMediaType</b> member of the DEVMODE structure. If <i>pOutput</i> is <b>NULL</b>, the return value indicates
///                   the required number of entries in the array. </td> </tr> <tr> <td width="40%"><a id="DC_MINEXTENT"></a><a
///                   id="dc_minextent"></a><dl> <dt><b>DC_MINEXTENT</b></dt> </dl> </td> <td width="60%"> Returns the minimum paper
///                   size that the <b>dmPaperLength</b> and <b>dmPaperWidth</b> members of the printer driver's DEVMODE structure can
///                   specify. The LOWORD of the return value contains the minimum <b>dmPaperWidth</b> value, and the HIWORD contains
///                   the minimum <b>dmPaperLength</b> value. </td> </tr> <tr> <td width="40%"><a id="DC_ORIENTATION"></a><a
///                   id="dc_orientation"></a><dl> <dt><b>DC_ORIENTATION</b></dt> </dl> </td> <td width="60%"> Returns the relationship
///                   between portrait and landscape orientations for a device, in terms of the number of degrees that portrait
///                   orientation is rotated counterclockwise to produce landscape orientation. The return value can be one of the
///                   following: <dl> <dt>0</dt> <dd> No landscape orientation. </dd> <dt>90</dt> <dd> Portrait is rotated 90 degrees
///                   to produce landscape. </dd> <dt>270</dt> <dd> Portrait is rotated 270 degrees to produce landscape. </dd> </dl>
///                   </td> </tr> <tr> <td width="40%"><a id="DC_NUP"></a><a id="dc_nup"></a><dl> <dt><b>DC_NUP</b></dt> </dl> </td>
///                   <td width="60%"> Retrieves an array of integers that indicate that printer's ability to print multiple document
///                   pages per printed page. The <i>pOutput</i> buffer receives an array of <b>DWORD</b> values. Each value represents
///                   a supported number of document pages per printed page. The return value indicates the number of entries in the
///                   array. If <i>pOutput</i> is <b>NULL</b>, the return value indicates the required number of entries in the array.
///                   </td> </tr> <tr> <td width="40%"><a id="DC_PAPERNAMES"></a><a id="dc_papernames"></a><dl>
///                   <dt><b>DC_PAPERNAMES</b></dt> </dl> </td> <td width="60%"> Retrieves a list of supported paper names (for
///                   example, Letter or Legal). The <i>pOutput</i> buffer receives an array of string buffers. Each string buffer is
///                   64 characters long and contains the name of a paper form. The return value indicates the number of entries in the
///                   array. The name strings are null-terminated unless the name is 64 characters long. If <i>pOutput</i> is
///                   <b>NULL</b>, the return value is the number of paper forms. </td> </tr> <tr> <td width="40%"><a
///                   id="DC_PAPERS"></a><a id="dc_papers"></a><dl> <dt><b>DC_PAPERS</b></dt> </dl> </td> <td width="60%"> Retrieves a
///                   list of supported paper sizes. The <i>pOutput</i> buffer receives an array of <b>WORD</b> values that indicate
///                   the available paper sizes for the printer. The return value indicates the number of entries in the array. For a
///                   list of the possible array values, see the description of the <b>dmPaperSize</b> member of the DEVMODE structure.
///                   If <i>pOutput</i> is <b>NULL</b>, the return value indicates the required number of entries in the array. </td>
///                   </tr> <tr> <td width="40%"><a id="DC_PAPERSIZE"></a><a id="dc_papersize"></a><dl> <dt><b>DC_PAPERSIZE</b></dt>
///                   </dl> </td> <td width="60%"> Retrieves the dimensions, in tenths of a millimeter, of each supported paper size.
///                   The <i>pOutput</i> buffer receives an array of POINT structures. Each structure contains the width (x-dimension)
///                   and length (y-dimension) of a paper size as if the paper were in the <b>DMORIENT_PORTRAIT</b> orientation. The
///                   return value indicates the number of entries in the array. </td> </tr> <tr> <td width="40%"><a
///                   id="DC_PERSONALITY"></a><a id="dc_personality"></a><dl> <dt><b>DC_PERSONALITY</b></dt> </dl> </td> <td
///                   width="60%"> Retrieves a list of printer description languages supported by the printer. The <i>pOutput</i>
///                   buffer receives an array of string buffers. Each buffer is 32 characters long and contains the name of a printer
///                   description language. The return value indicates the number of entries in the array. The name strings are
///                   null-terminated unless the name is 32 characters long. If <i>pOutput</i> is <b>NULL</b>, the return value
///                   indicates the required number of array entries. </td> </tr> <tr> <td width="40%"><a id="DC_PRINTERMEM"></a><a
///                   id="dc_printermem"></a><dl> <dt><b>DC_PRINTERMEM</b></dt> </dl> </td> <td width="60%"> The return value is the
///                   amount of available printer memory, in kilobytes. The <i>pOutput</i> parameter is not used. </td> </tr> <tr> <td
///                   width="40%"><a id="DC_PRINTRATE"></a><a id="dc_printrate"></a><dl> <dt><b>DC_PRINTRATE</b></dt> </dl> </td> <td
///                   width="60%"> The return value indicates the printer's print rate. The value returned for <b>DC_PRINTRATEUNIT</b>
///                   indicates the units of the <b>DC_PRINTRATE</b> value. The <i>pOutput</i> parameter is not used. </td> </tr> <tr>
///                   <td width="40%"><a id="DC_PRINTRATEPPM"></a><a id="dc_printrateppm"></a><dl> <dt><b>DC_PRINTRATEPPM</b></dt>
///                   </dl> </td> <td width="60%"> The return value indicates the printer's print rate, in pages per minute. The
///                   <i>pOutput</i> parameter is not used. </td> </tr> <tr> <td width="40%"><a id="DC_PRINTRATEUNIT"></a><a
///                   id="dc_printrateunit"></a><dl> <dt><b>DC_PRINTRATEUNIT</b></dt> </dl> </td> <td width="60%"> The return value is
///                   one of the following values that indicate the print rate units for the value returned for the <b>DC_PRINTRATE</b>
///                   flag. The <i>pOutput</i> parameter is not used. <dl> <dt><b>PRINTRATEUNIT_CPS</b></dt> <dd> Characters per
///                   second. </dd> <dt><b>PRINTRATEUNIT_IPM</b></dt> <dd> Inches per minute. </dd> <dt><b>PRINTRATEUNIT_LPM</b></dt>
///                   <dd> Lines per minute. </dd> <dt><b>PRINTRATEUNIT_PPM</b></dt> <dd> Pages per minute. </dd> </dl> </td> </tr>
///                   <tr> <td width="40%"><a id="DC_SIZE"></a><a id="dc_size"></a><dl> <dt><b>DC_SIZE</b></dt> </dl> </td> <td
///                   width="60%"> Returns the <b>dmSize</b> member of the printer driver's DEVMODE structure. </td> </tr> <tr> <td
///                   width="40%"><a id="DC_STAPLE"></a><a id="dc_staple"></a><dl> <dt><b>DC_STAPLE</b></dt> </dl> </td> <td
///                   width="60%"> If the printer supports stapling, the return value is a nonzero value; otherwise, the return value
///                   is zero. The <i>pOutput</i> parameter is not used. </td> </tr> <tr> <td width="40%"><a id="DC_TRUETYPE"></a><a
///                   id="dc_truetype"></a><dl> <dt><b>DC_TRUETYPE</b></dt> </dl> </td> <td width="60%"> Retrieves the abilities of the
///                   driver to use TrueType fonts. For <b>DC_TRUETYPE</b>, the <i>pOutput</i> parameter should be <b>NULL</b>. The
///                   return value can be one or more of the following: <dl> <dt><b>DCTT_BITMAP</b></dt> <dd> Device can print TrueType
///                   fonts as graphics. </dd> <dt><b>DCTT_DOWNLOAD</b></dt> <dd> Device can download TrueType fonts. </dd>
///                   <dt><b>DCTT_SUBDEV</b></dt> <dd> Device can substitute device fonts for TrueType fonts. </dd> </dl> </td> </tr>
///                   <tr> <td width="40%"><a id="DC_VERSION"></a><a id="dc_version"></a><dl> <dt><b>DC_VERSION</b></dt> </dl> </td>
///                   <td width="60%"> Returns the specification version to which the printer driver conforms. </td> </tr> </table>
///    pOutput = A pointer to an array. The format of the array depends on the setting of the <i>fwCapability</i> parameter. See
///              each capability above to find out what is returned if <i>pOutput</i> is <b>NULL</b>.
///    pDevMode = A pointer to a DEVMODE structure. If this parameter is <b>NULL</b>, <b>DeviceCapabilities</b> retrieves the
///               current default initialization values for the specified printer driver. Otherwise, the function retrieves the
///               values contained in the structure to which <i>pDevMode</i> points.
///Returns:
///    If the function succeeds, the return value depends on the setting of the <i>fwCapability</i> parameter. A return
///    value of zero generally indicates that, while the function completed successfully, there was some type of
///    failure, such as a capability that is not supported. For more details, see the descriptions for the
///    <i>fwCapability</i> values. If the function returns -1, this may mean either that the capability is not supported
///    or there was a general function failure.
///    
@DllImport("WINSPOOL")
int DeviceCapabilitiesA(const(char)* pDevice, const(char)* pPort, ushort fwCapability, const(char)* pOutput, 
                        const(DEVMODEA)* pDevMode);

///The <b>DeviceCapabilities</b> function retrieves the capabilities of a printer driver.
///Params:
///    pDevice = A pointer to a null-terminated string that contains the name of the printer. Note that this is the name of the
///              printer, not of the printer driver.
///    pPort = A pointer to a null-terminated string that contains the name of the port to which the device is connected, such
///            as LPT1.
///    fwCapability = The capabilities to be queried. This parameter can be one of the following values. <table> <tr> <th>Value</th>
///                   <th>Meaning</th> </tr> <tr> <td width="40%"><a id="DC_BINNAMES"></a><a id="dc_binnames"></a><dl>
///                   <dt><b>DC_BINNAMES</b></dt> </dl> </td> <td width="60%"> Retrieves the names of the printer's paper bins. The
///                   <i>pOutput</i> buffer receives an array of string buffers. Each string buffer is 24 characters long and contains
///                   the name of a paper bin. The return value indicates the number of entries in the array. The name strings are
///                   null-terminated unless the name is 24 characters long. If <i>pOutput</i> is <b>NULL</b>, the return value is the
///                   number of bin entries required. </td> </tr> <tr> <td width="40%"><a id="DC_BINS"></a><a id="dc_bins"></a><dl>
///                   <dt><b>DC_BINS</b></dt> </dl> </td> <td width="60%"> Retrieves a list of available paper bins. The <i>pOutput</i>
///                   buffer receives an array of <b>WORD</b> values that indicate the available paper sources for the printer. The
///                   return value indicates the number of entries in the array. For a list of the possible array values, see the
///                   description of the <b>dmDefaultSource</b> member of the DEVMODE structure. If <i>pOutput</i> is <b>NULL</b>, the
///                   return value indicates the required number of entries in the array. </td> </tr> <tr> <td width="40%"><a
///                   id="DC_COLLATE"></a><a id="dc_collate"></a><dl> <dt><b>DC_COLLATE</b></dt> </dl> </td> <td width="60%"> If the
///                   printer supports collating, the return value is 1; otherwise, the return value is zero. The <i>pOutput</i>
///                   parameter is not used. </td> </tr> <tr> <td width="40%"><a id="DC_COLORDEVICE"></a><a
///                   id="dc_colordevice"></a><dl> <dt><b>DC_COLORDEVICE</b></dt> </dl> </td> <td width="60%"> If the printer supports
///                   color printing, the return value is 1; otherwise, the return value is zero. The <i>pOutput</i> parameter is not
///                   used. </td> </tr> <tr> <td width="40%"><a id="DC_COPIES"></a><a id="dc_copies"></a><dl> <dt><b>DC_COPIES</b></dt>
///                   </dl> </td> <td width="60%"> Returns the number of copies the device can print. </td> </tr> <tr> <td
///                   width="40%"><a id="DC_DRIVER"></a><a id="dc_driver"></a><dl> <dt><b>DC_DRIVER</b></dt> </dl> </td> <td
///                   width="60%"> Returns the version number of the printer driver. </td> </tr> <tr> <td width="40%"><a
///                   id="DC_DUPLEX"></a><a id="dc_duplex"></a><dl> <dt><b>DC_DUPLEX</b></dt> </dl> </td> <td width="60%"> If the
///                   printer supports duplex printing, the return value is 1; otherwise, the return value is zero. The <i>pOutput</i>
///                   parameter is not used. </td> </tr> <tr> <td width="40%"><a id="DC_ENUMRESOLUTIONS"></a><a
///                   id="dc_enumresolutions"></a><dl> <dt><b>DC_ENUMRESOLUTIONS</b></dt> </dl> </td> <td width="60%"> Retrieves a list
///                   of the resolutions supported by the printer. The <i>pOutput</i> buffer receives an array of <b>LONG</b> values.
///                   For each supported resolution, the array contains a pair of <b>LONG</b> values that specify the x and y
///                   dimensions of the resolution, in dots per inch. The return value indicates the number of supported resolutions.
///                   If <i>pOutput</i> is <b>NULL</b>, the return value indicates the number of supported resolutions. </td> </tr>
///                   <tr> <td width="40%"><a id="DC_EXTRA"></a><a id="dc_extra"></a><dl> <dt><b>DC_EXTRA</b></dt> </dl> </td> <td
///                   width="60%"> Returns the number of bytes required for the device-specific portion of the DEVMODE structure for
///                   the printer driver. </td> </tr> <tr> <td width="40%"><a id="DC_FIELDS"></a><a id="dc_fields"></a><dl>
///                   <dt><b>DC_FIELDS</b></dt> </dl> </td> <td width="60%"> Returns the <b>dmFields</b> member of the printer driver's
///                   DEVMODE structure. The <b>dmFields</b> member indicates which members in the device-independent portion of the
///                   structure are supported by the printer driver. </td> </tr> <tr> <td width="40%"><a
///                   id="DC_FILEDEPENDENCIES"></a><a id="dc_filedependencies"></a><dl> <dt><b>DC_FILEDEPENDENCIES</b></dt> </dl> </td>
///                   <td width="60%"> Retrieves the names of any additional files that need to be loaded when a driver is installed.
///                   The <i>pOutput</i> buffer receives an array of string buffers. Each string buffer is 64 characters long and
///                   contains the name of a file. The return value indicates the number of entries in the array. The name strings are
///                   null-terminated unless the name is 64 characters long. If <i>pOutput</i> is <b>NULL</b>, the return value is the
///                   number of files. </td> </tr> <tr> <td width="40%"><a id="DC_MAXEXTENT"></a><a id="dc_maxextent"></a><dl>
///                   <dt><b>DC_MAXEXTENT</b></dt> </dl> </td> <td width="60%"> Returns the maximum paper size that the
///                   <b>dmPaperLength</b> and <b>dmPaperWidth</b> members of the printer driver's DEVMODE structure can specify. The
///                   LOWORD of the return value contains the maximum <b>dmPaperWidth</b> value, and the HIWORD contains the maximum
///                   <b>dmPaperLength</b> value. </td> </tr> <tr> <td width="40%"><a id="DC_MEDIAREADY"></a><a
///                   id="dc_mediaready"></a><dl> <dt><b>DC_MEDIAREADY</b></dt> </dl> </td> <td width="60%"> Retrieves the names of the
///                   paper forms that are currently available for use. The <i>pOutput</i> buffer receives an array of string buffers.
///                   Each string buffer is 64 characters long and contains the name of a paper form. The return value indicates the
///                   number of entries in the array. The name strings are null-terminated unless the name is 64 characters long. If
///                   <i>pOutput</i> is <b>NULL</b>, the return value is the number of paper forms. </td> </tr> <tr> <td width="40%"><a
///                   id="DC_MEDIATYPENAMES"></a><a id="dc_mediatypenames"></a><dl> <dt><b>DC_MEDIATYPENAMES</b></dt> </dl> </td> <td
///                   width="60%"> Retrieves the names of the supported media types. The <i>pOutput</i> buffer receives an array of
///                   string buffers. Each string buffer is 64 characters long and contains the name of a supported media type. The
///                   return value indicates the number of entries in the array. The strings are null-terminated unless the name is 64
///                   characters long. If <i>pOutput</i> is <b>NULL</b>, the return value is the number of media type names required.
///                   </td> </tr> <tr> <td width="40%"><a id="DC_MEDIATYPES"></a><a id="dc_mediatypes"></a><dl>
///                   <dt><b>DC_MEDIATYPES</b></dt> </dl> </td> <td width="60%"> Retrieves a list of supported media types. The
///                   <i>pOutput</i> buffer receives an array of DWORD values that indicate the supported media types. The return value
///                   indicates the number of entries in the array. For a list of possible array values, see the description of the
///                   <b>dmMediaType</b> member of the DEVMODE structure. If <i>pOutput</i> is <b>NULL</b>, the return value indicates
///                   the required number of entries in the array. </td> </tr> <tr> <td width="40%"><a id="DC_MINEXTENT"></a><a
///                   id="dc_minextent"></a><dl> <dt><b>DC_MINEXTENT</b></dt> </dl> </td> <td width="60%"> Returns the minimum paper
///                   size that the <b>dmPaperLength</b> and <b>dmPaperWidth</b> members of the printer driver's DEVMODE structure can
///                   specify. The LOWORD of the return value contains the minimum <b>dmPaperWidth</b> value, and the HIWORD contains
///                   the minimum <b>dmPaperLength</b> value. </td> </tr> <tr> <td width="40%"><a id="DC_ORIENTATION"></a><a
///                   id="dc_orientation"></a><dl> <dt><b>DC_ORIENTATION</b></dt> </dl> </td> <td width="60%"> Returns the relationship
///                   between portrait and landscape orientations for a device, in terms of the number of degrees that portrait
///                   orientation is rotated counterclockwise to produce landscape orientation. The return value can be one of the
///                   following: <dl> <dt>0</dt> <dd> No landscape orientation. </dd> <dt>90</dt> <dd> Portrait is rotated 90 degrees
///                   to produce landscape. </dd> <dt>270</dt> <dd> Portrait is rotated 270 degrees to produce landscape. </dd> </dl>
///                   </td> </tr> <tr> <td width="40%"><a id="DC_NUP"></a><a id="dc_nup"></a><dl> <dt><b>DC_NUP</b></dt> </dl> </td>
///                   <td width="60%"> Retrieves an array of integers that indicate that printer's ability to print multiple document
///                   pages per printed page. The <i>pOutput</i> buffer receives an array of <b>DWORD</b> values. Each value represents
///                   a supported number of document pages per printed page. The return value indicates the number of entries in the
///                   array. If <i>pOutput</i> is <b>NULL</b>, the return value indicates the required number of entries in the array.
///                   </td> </tr> <tr> <td width="40%"><a id="DC_PAPERNAMES"></a><a id="dc_papernames"></a><dl>
///                   <dt><b>DC_PAPERNAMES</b></dt> </dl> </td> <td width="60%"> Retrieves a list of supported paper names (for
///                   example, Letter or Legal). The <i>pOutput</i> buffer receives an array of string buffers. Each string buffer is
///                   64 characters long and contains the name of a paper form. The return value indicates the number of entries in the
///                   array. The name strings are null-terminated unless the name is 64 characters long. If <i>pOutput</i> is
///                   <b>NULL</b>, the return value is the number of paper forms. </td> </tr> <tr> <td width="40%"><a
///                   id="DC_PAPERS"></a><a id="dc_papers"></a><dl> <dt><b>DC_PAPERS</b></dt> </dl> </td> <td width="60%"> Retrieves a
///                   list of supported paper sizes. The <i>pOutput</i> buffer receives an array of <b>WORD</b> values that indicate
///                   the available paper sizes for the printer. The return value indicates the number of entries in the array. For a
///                   list of the possible array values, see the description of the <b>dmPaperSize</b> member of the DEVMODE structure.
///                   If <i>pOutput</i> is <b>NULL</b>, the return value indicates the required number of entries in the array. </td>
///                   </tr> <tr> <td width="40%"><a id="DC_PAPERSIZE"></a><a id="dc_papersize"></a><dl> <dt><b>DC_PAPERSIZE</b></dt>
///                   </dl> </td> <td width="60%"> Retrieves the dimensions, in tenths of a millimeter, of each supported paper size.
///                   The <i>pOutput</i> buffer receives an array of POINT structures. Each structure contains the width (x-dimension)
///                   and length (y-dimension) of a paper size as if the paper were in the <b>DMORIENT_PORTRAIT</b> orientation. The
///                   return value indicates the number of entries in the array. </td> </tr> <tr> <td width="40%"><a
///                   id="DC_PERSONALITY"></a><a id="dc_personality"></a><dl> <dt><b>DC_PERSONALITY</b></dt> </dl> </td> <td
///                   width="60%"> Retrieves a list of printer description languages supported by the printer. The <i>pOutput</i>
///                   buffer receives an array of string buffers. Each buffer is 32 characters long and contains the name of a printer
///                   description language. The return value indicates the number of entries in the array. The name strings are
///                   null-terminated unless the name is 32 characters long. If <i>pOutput</i> is <b>NULL</b>, the return value
///                   indicates the required number of array entries. </td> </tr> <tr> <td width="40%"><a id="DC_PRINTERMEM"></a><a
///                   id="dc_printermem"></a><dl> <dt><b>DC_PRINTERMEM</b></dt> </dl> </td> <td width="60%"> The return value is the
///                   amount of available printer memory, in kilobytes. The <i>pOutput</i> parameter is not used. </td> </tr> <tr> <td
///                   width="40%"><a id="DC_PRINTRATE"></a><a id="dc_printrate"></a><dl> <dt><b>DC_PRINTRATE</b></dt> </dl> </td> <td
///                   width="60%"> The return value indicates the printer's print rate. The value returned for <b>DC_PRINTRATEUNIT</b>
///                   indicates the units of the <b>DC_PRINTRATE</b> value. The <i>pOutput</i> parameter is not used. </td> </tr> <tr>
///                   <td width="40%"><a id="DC_PRINTRATEPPM"></a><a id="dc_printrateppm"></a><dl> <dt><b>DC_PRINTRATEPPM</b></dt>
///                   </dl> </td> <td width="60%"> The return value indicates the printer's print rate, in pages per minute. The
///                   <i>pOutput</i> parameter is not used. </td> </tr> <tr> <td width="40%"><a id="DC_PRINTRATEUNIT"></a><a
///                   id="dc_printrateunit"></a><dl> <dt><b>DC_PRINTRATEUNIT</b></dt> </dl> </td> <td width="60%"> The return value is
///                   one of the following values that indicate the print rate units for the value returned for the <b>DC_PRINTRATE</b>
///                   flag. The <i>pOutput</i> parameter is not used. <dl> <dt><b>PRINTRATEUNIT_CPS</b></dt> <dd> Characters per
///                   second. </dd> <dt><b>PRINTRATEUNIT_IPM</b></dt> <dd> Inches per minute. </dd> <dt><b>PRINTRATEUNIT_LPM</b></dt>
///                   <dd> Lines per minute. </dd> <dt><b>PRINTRATEUNIT_PPM</b></dt> <dd> Pages per minute. </dd> </dl> </td> </tr>
///                   <tr> <td width="40%"><a id="DC_SIZE"></a><a id="dc_size"></a><dl> <dt><b>DC_SIZE</b></dt> </dl> </td> <td
///                   width="60%"> Returns the <b>dmSize</b> member of the printer driver's DEVMODE structure. </td> </tr> <tr> <td
///                   width="40%"><a id="DC_STAPLE"></a><a id="dc_staple"></a><dl> <dt><b>DC_STAPLE</b></dt> </dl> </td> <td
///                   width="60%"> If the printer supports stapling, the return value is a nonzero value; otherwise, the return value
///                   is zero. The <i>pOutput</i> parameter is not used. </td> </tr> <tr> <td width="40%"><a id="DC_TRUETYPE"></a><a
///                   id="dc_truetype"></a><dl> <dt><b>DC_TRUETYPE</b></dt> </dl> </td> <td width="60%"> Retrieves the abilities of the
///                   driver to use TrueType fonts. For <b>DC_TRUETYPE</b>, the <i>pOutput</i> parameter should be <b>NULL</b>. The
///                   return value can be one or more of the following: <dl> <dt><b>DCTT_BITMAP</b></dt> <dd> Device can print TrueType
///                   fonts as graphics. </dd> <dt><b>DCTT_DOWNLOAD</b></dt> <dd> Device can download TrueType fonts. </dd>
///                   <dt><b>DCTT_SUBDEV</b></dt> <dd> Device can substitute device fonts for TrueType fonts. </dd> </dl> </td> </tr>
///                   <tr> <td width="40%"><a id="DC_VERSION"></a><a id="dc_version"></a><dl> <dt><b>DC_VERSION</b></dt> </dl> </td>
///                   <td width="60%"> Returns the specification version to which the printer driver conforms. </td> </tr> </table>
///    pOutput = A pointer to an array. The format of the array depends on the setting of the <i>fwCapability</i> parameter. See
///              each capability above to find out what is returned if <i>pOutput</i> is <b>NULL</b>.
///    pDevMode = A pointer to a DEVMODE structure. If this parameter is <b>NULL</b>, <b>DeviceCapabilities</b> retrieves the
///               current default initialization values for the specified printer driver. Otherwise, the function retrieves the
///               values contained in the structure to which <i>pDevMode</i> points.
///Returns:
///    If the function succeeds, the return value depends on the setting of the <i>fwCapability</i> parameter. A return
///    value of zero generally indicates that, while the function completed successfully, there was some type of
///    failure, such as a capability that is not supported. For more details, see the descriptions for the
///    <i>fwCapability</i> values. If the function returns -1, this may mean either that the capability is not supported
///    or there was a general function failure.
///    
@DllImport("WINSPOOL")
int DeviceCapabilitiesW(const(wchar)* pDevice, const(wchar)* pPort, ushort fwCapability, const(wchar)* pOutput, 
                        const(DEVMODEW)* pDevMode);

///The <b>Escape</b> function enables an application to access the system-defined device capabilities that are not
///available through GDI. Escape calls made by an application are translated and sent to the driver.
///Params:
///    hdc = A handle to the device context.
///    iEscape = The escape function to be performed. This parameter must be one of the predefined escape values listed in
///              Remarks. Use the ExtEscape function if your application defines a private escape value.
///    cjIn = The number of bytes of data pointed to by the <i>lpvInData</i> parameter. This can be 0.
///    pvIn = A pointer to the input structure required for the specified escape.
///    pvOut = A pointer to the structure that receives output from this escape. This parameter should be <b>NULL</b> if no data
///            is returned.
///Returns:
///    If the function succeeds, the return value is greater than zero, except with the QUERYESCSUPPORT printer escape,
///    which checks for implementation only. If the escape is not implemented, the return value is zero. If the function
///    fails, the return value is a system error code.
///    
@DllImport("GDI32")
int Escape(HDC hdc, int iEscape, int cjIn, const(char)* pvIn, void* pvOut);

///The <b>ExtEscape</b> function enables an application to access device capabilities that are not available through
///GDI.
///Params:
///    hdc = A handle to the device context.
///    iEscape = The escape function to be performed. It can be one of the following or it can be an application-defined escape
///              function. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="CHECKJPEGFORMAT"></a><a
///              id="checkjpegformat"></a><dl> <dt><b>CHECKJPEGFORMAT</b></dt> </dl> </td> <td width="60%"> Checks whether the
///              printer supports a JPEG image. </td> </tr> <tr> <td width="40%"><a id="CHECKPNGFORMAT"></a><a
///              id="checkpngformat"></a><dl> <dt><b>CHECKPNGFORMAT</b></dt> </dl> </td> <td width="60%"> Checks whether the
///              printer supports a PNG image. </td> </tr> <tr> <td width="40%"><a id="DRAWPATTERNRECT"></a><a
///              id="drawpatternrect"></a><dl> <dt><b>DRAWPATTERNRECT</b></dt> </dl> </td> <td width="60%"> Draws a white,
///              gray-scale, or black rectangle. </td> </tr> <tr> <td width="40%"><a id="GET_PS_FEATURESETTING"></a><a
///              id="get_ps_featuresetting"></a><dl> <dt><b>GET_PS_FEATURESETTING</b></dt> </dl> </td> <td width="60%"> Gets
///              information on a specified feature setting for a PostScript driver. </td> </tr> <tr> <td width="40%"><a
///              id="GETTECHNOLOGY"></a><a id="gettechnology"></a><dl> <dt><b>GETTECHNOLOGY</b></dt> </dl> </td> <td width="60%">
///              Reports on whether or not the driver is a Postscript driver. </td> </tr> <tr> <td width="40%"><a
///              id="PASSTHROUGH"></a><a id="passthrough"></a><dl> <dt><b>PASSTHROUGH</b></dt> </dl> </td> <td width="60%"> Allows
///              the application to send data directly to a printer. Supported in compatibility mode and GDI-centric mode. </td>
///              </tr> <tr> <td width="40%"><a id="POSTSCRIPT_DATA"></a><a id="postscript_data"></a><dl>
///              <dt><b>POSTSCRIPT_DATA</b></dt> </dl> </td> <td width="60%"> Allows the application to send data directly to a
///              printer. Supported only in compatibility mode. </td> </tr> <tr> <td width="40%"><a
///              id="POSTSCRIPT_IDENTIFY"></a><a id="postscript_identify"></a><dl> <dt><b>POSTSCRIPT_IDENTIFY</b></dt> </dl> </td>
///              <td width="60%"> Sets a PostScript driver to GDI-centric or PostScript-centric mode. </td> </tr> <tr> <td
///              width="40%"><a id="POSTSCRIPT_INJECTION"></a><a id="postscript_injection"></a><dl>
///              <dt><b>POSTSCRIPT_INJECTION</b></dt> </dl> </td> <td width="60%"> Inserts a block of raw data in a PostScript job
///              stream. </td> </tr> <tr> <td width="40%"><a id="POSTSCRIPT_PASSTHROUGH"></a><a
///              id="postscript_passthrough"></a><dl> <dt><b>POSTSCRIPT_PASSTHROUGH</b></dt> </dl> </td> <td width="60%"> Sends
///              data directly to a PostScript printer driver. Supported in compatibility mode and PostScript-centric mode. </td>
///              </tr> <tr> <td width="40%"><a id="QUERYESCSUPPORT"></a><a id="queryescsupport"></a><dl>
///              <dt><b>QUERYESCSUPPORT</b></dt> </dl> </td> <td width="60%"> Determines whether a particular escape is
///              implemented by the device driver. </td> </tr> <tr> <td width="40%"><a id="SPCLPASSTHROUGH2"></a><a
///              id="spclpassthrough2"></a><dl> <dt><b>SPCLPASSTHROUGH2</b></dt> </dl> </td> <td width="60%"> Enables applications
///              to include private procedures and other resources at the document level-save context. </td> </tr> </table>
///    cjInput = The number of bytes of data pointed to by the <i>lpszInData</i> parameter.
///    lpInData = A pointer to the input structure required for the specified escape. See also Remarks.
///    cjOutput = The number of bytes of data pointed to by the <i>lpszOutData</i> parameter.
///    lpOutData = A pointer to the structure that receives output from this escape. This parameter must not be <b>NULL</b> if
///                <b>ExtEscape</b> is called as a query function. If no data is to be returned in this structure, set
///                <i>cbOutput</i> to 0. See also Remarks.
///Returns:
///    The return value specifies the outcome of the function. It is greater than zero if the function is successful,
///    except for the QUERYESCSUPPORT printer escape, which checks for implementation only. The return value is zero if
///    the escape is not implemented. A return value less than zero indicates an error.
///    
@DllImport("GDI32")
int ExtEscape(HDC hdc, int iEscape, int cjInput, const(char)* lpInData, int cjOutput, const(char)* lpOutData);

///The <b>StartDoc</b> function starts a print job.
///Params:
///    hdc = A handle to the device context for the print job.
///    lpdi = A pointer to a DOCINFO structure containing the name of the document file and the name of the output file.
///Returns:
///    If the function succeeds, the return value is greater than zero. This value is the print job identifier for the
///    document. If the function fails, the return value is less than or equal to zero.
///    
@DllImport("GDI32")
int StartDocA(HDC hdc, const(DOCINFOA)* lpdi);

///The <b>StartDoc</b> function starts a print job.
///Params:
///    hdc = A handle to the device context for the print job.
///    lpdi = A pointer to a DOCINFO structure containing the name of the document file and the name of the output file.
///Returns:
///    If the function succeeds, the return value is greater than zero. This value is the print job identifier for the
///    document. If the function fails, the return value is less than or equal to zero.
///    
@DllImport("GDI32")
int StartDocW(HDC hdc, const(DOCINFOW)* lpdi);

///The <b>EndDoc</b> function ends a print job.
///Params:
///    hdc = Handle to the device context for the print job.
///Returns:
///    If the function succeeds, the return value is greater than zero. If the function fails, the return value is less
///    than or equal to zero.
///    
@DllImport("GDI32")
int EndDoc(HDC hdc);

///The <b>StartPage</b> function prepares the printer driver to accept data.
///Params:
///    hdc = A handle to the device context for the print job.
///Returns:
///    If the function succeeds, the return value is greater than zero. If the function fails, the return value is less
///    than or equal to zero.
///    
@DllImport("GDI32")
int StartPage(HDC hdc);

///The <b>EndPage</b> function notifies the device that the application has finished writing to a page. This function is
///typically used to direct the device driver to advance to a new page.
///Params:
///    hdc = A handle to the device context for the print job.
///Returns:
///    If the function succeeds, the return value is greater than zero. If the function fails, the return value is less
///    than or equal to zero.
///    
@DllImport("GDI32")
int EndPage(HDC hdc);

///The <b>AbortDoc</b> function stops the current print job and erases everything drawn since the last call to the
///StartDoc function.
///Params:
///    hdc = Handle to the device context for the print job.
///Returns:
///    If the function succeeds, the return value is greater than zero. If the function fails, the return value is
///    SP_ERROR.
///    
@DllImport("GDI32")
int AbortDoc(HDC hdc);

///The <b>SetAbortProc</b> function sets the application-defined abort function that allows a print job to be canceled
///during spooling.
///Params:
///    hdc = Handle to the device context for the print job.
///    proc = Pointer to the application-defined abort function. For more information about the callback function, see the
///           AbortProc callback function.
///Returns:
///    If the function succeeds, the return value is greater than zero. If the function fails, the return value is
///    SP_ERROR.
///    
@DllImport("GDI32")
int SetAbortProc(HDC hdc, ABORTPROC proc);

///The <b>PrintWindow</b> function copies a visual window into the specified device context (DC), typically a printer
///DC.
///Params:
///    hwnd = A handle to the window that will be copied.
///    hdcBlt = A handle to the device context.
///    nFlags = The drawing options. It can be one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///             <tr> <td width="40%"><a id="PW_CLIENTONLY"></a><a id="pw_clientonly"></a><dl> <dt><b>PW_CLIENTONLY</b></dt> </dl>
///             </td> <td width="60%"> Only the client area of the window is copied to <i>hdcBlt</i>. By default, the entire
///             window is copied. </td> </tr> </table>
///Returns:
///    If the function succeeds, it returns a nonzero value. If the function fails, it returns zero.
///    
@DllImport("USER32")
BOOL PrintWindow(HWND hwnd, HDC hdcBlt, uint nFlags);

///Retrieves the highest (latest) version of the Print Schema that the specified printer supports.
///Params:
///    pszPrinterName = A pointer to the full name of a print queue.
///    pMaxVersion = A pointer to the highest version.
///Returns:
///    If the operation succeeds, the return value is S_OK, otherwise the <b>HRESULT</b> contains an error code. For
///    more information about COM error codes, see Error Handling.
///    
@DllImport("prntvpt")
HRESULT PTQuerySchemaVersionSupport(const(wchar)* pszPrinterName, uint* pMaxVersion);

///Opens an instance of a print ticket provider.
///Params:
///    pszPrinterName = A pointer to the full name of a print queue.
///    dwVersion = The version of the Print Schema requested by the caller.
///    phProvider = A pointer to a handle for the provider.
///Returns:
///    If the operation succeeds, the return value is S_OK, otherwise the <b>HRESULT</b> contains an error code. For
///    more information about COM error codes, see Error Handling.
///    
@DllImport("prntvpt")
HRESULT PTOpenProvider(const(wchar)* pszPrinterName, uint dwVersion, HPTPROVIDER__** phProvider);

///Opens an instance of a print ticket provider.
///Params:
///    pszPrinterName = A pointer to the full name of a print queue.
///    dwMaxVersion = The latest version of the Print Schema that the caller supports.
///    dwPrefVersion = The version of the Print Schema requested by the caller.
///    phProvider = A pointer to a handle for the provider.
///    pUsedVersion = A pointer to the version of the Print Schema that the print ticket provider will use.
///Returns:
///    If the operation succeeds, the return value is S_OK, otherwise the <b>HRESULT</b> contains an error code. For
///    more information about COM error codes, see Error Handling.
///    
@DllImport("prntvpt")
HRESULT PTOpenProviderEx(const(wchar)* pszPrinterName, uint dwMaxVersion, uint dwPrefVersion, 
                         HPTPROVIDER__** phProvider, uint* pUsedVersion);

///Closes a print ticket provider handle.
///Params:
///    hProvider = A handle to the provider. This handle is returned by the PTOpenProvider or PTOpenProviderEx function.
///Returns:
///    If the operation succeeds, the return value is S_OK, otherwise the <b>HRESULT</b> contains an error code. If
///    <i>hProvider</i> was opened in a different thread, the <b>HRESULT</b> is E_INVALIDARG. For more information about
///    COM error codes, see Error Handling.
///    
@DllImport("prntvpt")
HRESULT PTCloseProvider(HPTPROVIDER__* hProvider);

///Releases buffers associated with print tickets and print capabilities.
///Params:
///    pBuffer = A pointer to a buffer allocated during a call to a print ticket API.
///Returns:
///    If the operation succeeds, the return value is S_OK, otherwise the <b>HRESULT</b> contains an error code. For
///    more information about COM error codes, see Error Handling.
///    
@DllImport("prntvpt")
HRESULT PTReleaseMemory(void* pBuffer);

///Retrieves the printer's capabilities formatted in compliance with the XML Print Schema.
///Params:
///    hProvider = A handle to an open provider whose print capabilities are to be retrieved. This handle is returned by the
///                PTOpenProvider or the PTOpenProviderEx function.
///    pPrintTicket = A pointer to a stream with its seek position at the beginning of the print ticket content. This parameter can be
///                   <b>NULL</b>.
///    pCapabilities = A pointer to the stream where the print capabilities will be written, starting at the current seek position.
///    pbstrErrorMessage = A pointer to a string that specifies what, if anything, is invalid about <i>pPrintTicket</i>. If it is valid,
///                        this value is <b>NULL</b>.
///Returns:
///    If the operation succeeds, the return value is S_OK. If <i>hProvider</i> was opened in a different thread, the
///    <b>HRESULT</b> is E_INVALIDARG. If the <i>pPrintTicket</i> is not compliant with the Print Schema , the
///    <b>HRESULT</b> is E_PRINTTICKET_FORMAT. If the <i>pCapabilities</i> is not compliant with the Print Schema , the
///    <b>HRESULT</b> is E_PRINTCAPABILITIES_FORMAT. If <i>hProvider</i> was opened in a different thread, the
///    <b>HRESULT</b> is E_INVALIDARG. Otherwise, another error code is returned in the <b>HRESULT</b>. For more
///    information about COM error codes, see Error Handling.
///    
@DllImport("prntvpt")
HRESULT PTGetPrintCapabilities(HPTPROVIDER__* hProvider, IStream pPrintTicket, IStream pCapabilities, 
                               BSTR* pbstrErrorMessage);

///Retrieves the device printer's capabilities formatted in compliance with the XML Print Schema.
///Params:
///    hProvider = A handle to an open device provider whose print capabilities are to be retrieved. This handle is returned by the
///                PTOpenProvider or the PTOpenProviderEx function.
///    pPrintTicket = An optional pointer to a stream with its seek position at the beginning of the print ticket content. This
///                   parameter can be <b>NULL</b>.
///    pDeviceCapabilities = A pointer to the stream where the device print capabilities will be written, starting at the current seek
///                          position.
///    pbstrErrorMessage = A pointer to a PDC file or string that specifies what, if anything, is invalid about <i>pPrintTicket</i>. If it
///                        is valid, this value is <b>NULL</b>.The function uses this parameter only used if <i>pPrintTicket</i> is used.
///Returns:
///    If the operation succeeds, the return value is S_OK. Otherwise, returns an error message.
///    
@DllImport("prntvpt")
HRESULT PTGetPrintDeviceCapabilities(HPTPROVIDER__* hProvider, IStream pPrintTicket, IStream pDeviceCapabilities, 
                                     BSTR* pbstrErrorMessage);

///It retrieves the print devices resources for a printer formatted in compliance with the XML Print Schema.
///Params:
///    hProvider = A handle to an open device provider whose print device resources are to be retrieved. This handle is returned by
///                the PTOpenProvider or the PTOpenProviderEx function.
///    pszLocaleName = Optional pointer to the locale name. This parameter can be <b>NULL</b>.
///    pPrintTicket = A pointer to a stream with its seek position at the beginning of the print ticket content. This parameter can be
///                   <b>NULL</b>.
///    pDeviceResources = A pointer to the stream where the device print resources will be written, starting at the current seek position.
///    pbstrErrorMessage = A pointer to a PDC file or string that specifies what, if anything, is invalid about <i>pPrintTicket</i>. If it
///                        is valid, this value is <b>NULL</b>.
///Returns:
///    If the operation succeeds, the return value is S_OK. Otherwise, returns an error message.
///    
@DllImport("prntvpt")
HRESULT PTGetPrintDeviceResources(HPTPROVIDER__* hProvider, const(wchar)* pszLocaleName, IStream pPrintTicket, 
                                  IStream pDeviceResources, BSTR* pbstrErrorMessage);

///Merges two print tickets and returns a valid, viable print ticket.
///Params:
///    hProvider = A handle to an open print ticket provider. This handle is returned by the PTOpenProvider or the PTOpenProviderEx
///                function.
///    pBaseTicket = A pointer to a print ticket. The stream's seek position must be at the beginning of the print ticket content.
///                  <div class="alert"><b>Note</b> <b>PTMergeAndValidatePrintTicket</b> will validate the base ticket against the
///                  Print Schema Framework before merging.</div> <div> </div>
///    pDeltaTicket = A pointer to a print ticket. The stream's seek position must be at the beginning of the print ticket content.
///                   <b>NULL</b> can be passed to this parameter. See Remarks. <div class="alert"><b>Note</b>
///                   <b>PTMergeAndValidatePrintTicket</b> will validate the delta ticket against the Print Schema Framework before
///                   merging.</div> <div> </div>
///    scope = A value specifying whether the scope of <i>pDeltaTicket</i> and <i>pResultTicket</i> is a single page, an entire
///            document, or all documents in the print job. See Remarks.
///    pResultTicket = A pointer to the stream where the viable, merged ticket will be written. The seek position will be at the end of
///                    the print ticket. See Remarks.
///    pbstrErrorMessage = A pointer to a string that specifies what, if anything, is invalid about <i>pBaseTicket</i> or
///                        <i>pDeltaTicket</i>. If both are valid, this is <b>NULL</b>. Viability problems are not reported in
///                        <i>pbstrErrorMessage</i>.
///Returns:
///    If the operation succeeds with no conflict between the settings of the merged ticket and the capabilities of the
///    printer, the <b>HRESULT</b> is S_PT_NO_CONFLICT. If the operation succeeds but the merged ticket had to be
///    changed in one or more settings because it requested functionality that the printer does not support, the
///    <b>HRESULT</b> is S_PT_CONFLICT_RESOLVED. See Remarks. If <i>hProvider</i> was opened in a different thread, the
///    <b>HRESULT</b> is E_INVALIDARG. If <i>pBaseTicket</i> is invalid, the <b>HRESULT</b> is E_PRINTTICKET_FORMAT. If
///    <i>pDeltaTicket</i> is invalid, the <b>HRESULT</b> is E_DELTA_PRINTTICKET_FORMAT. Otherwise, some other error
///    code is returned in the <b>HRESULT</b>. For more information about COM error codes, see Error Handling.
///    
@DllImport("prntvpt")
HRESULT PTMergeAndValidatePrintTicket(HPTPROVIDER__* hProvider, IStream pBaseTicket, IStream pDeltaTicket, 
                                      EPrintTicketScope scope_, IStream pResultTicket, BSTR* pbstrErrorMessage);

///Converts a print ticket into a DEVMODE structure.
///Params:
///    hProvider = A handle to an opened print ticket provider. This handle is returned by the PTOpenProvider or the
///                PTOpenProviderEx function.
///    pPrintTicket = A pointer to an IStream with its seek position at the beginning of the print ticket.
///    baseDevmodeType = A value indicating whether the user's default DEVMODE or the print queue's default <b>DEVMODE</b> is used to
///                      provide values to the output <b>DEVMODE</b> when <i>pPrintTicket</i> does not specify every possible setting for
///                      a <b>DEVMODE</b>.
///    scope = A value that specifies the scope of <i>pPrintTicket</i>. This value can specify a single page, an entire
///            document, or all documents in the print job. Settings in <i>pPrintTicket</i> that are outside of the specified
///            scope are ignored. See Remarks.
///    pcbDevmode = A pointer to the size of the DEVMODE in bytes.
///    ppDevmode = A pointer to the newly created DEVMODE.
///    pbstrErrorMessage = A pointer to a string that specifies what, if anything, is invalid about <i>pPrintTicket</i>. If it is valid,
///                        this is <b>NULL</b>.
///Returns:
///    If the operation succeeds, the return value is S_OK. If <i>hProvider</i> was opened in a different thread, the
///    <b>HRESULT</b> is E_INVALIDARG. If <i>pPrintTicket</i> is invalid, the <b>HRESULT</b> is E_PRINTTICKET_FORMAT.
///    Otherwise, some other error code is returned in the <b>HRESULT</b>. For more information about COM error codes,
///    see Error Handling.
///    
@DllImport("prntvpt")
HRESULT PTConvertPrintTicketToDevMode(HPTPROVIDER__* hProvider, IStream pPrintTicket, 
                                      EDefaultDevmodeType baseDevmodeType, EPrintTicketScope scope_, 
                                      uint* pcbDevmode, DEVMODEA** ppDevmode, BSTR* pbstrErrorMessage);

///Converts a DEVMODE structure to a print ticket inside an IStream.
///Params:
///    hProvider = A handle to an open print ticket provider. This handle is returned by the PTOpenProvider or the PTOpenProviderEx
///                function.
///    cbDevmode = The size of the DEVMODE in bytes.
///    pDevmode = A pointer to the DEVMODE.
///    scope = A value that specifies the scope of <i>pPrintTicket</i>. This value can specify a single page, an entire
///            document, or all documents in the print job. Settings in <i>pDevmode</i> that are outside the specified scope
///            will not be included in <i>pPrintTicket</i>. See Remarks.
///    pPrintTicket = A pointer to an IStream with its seek position at the beginning of the print ticket.
///Returns:
///    If the operation succeeds, the return value is S_OK, otherwise the <b>HRESULT</b> contains an error code. If
///    <i>hProvider</i> was opened in a different thread, the <b>HRESULT</b> is E_INVALIDARG. For more information about
///    COM error codes, see Error Handling.
///    
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

///The base interface for sharable interfaces.
@GUID("7137398F-2FC1-454D-8C6A-2C3115A16ECE")
interface IXpsOMShareable : IUnknown
{
    ///Gets the <b>IUnknown</b> interface of the parent.
    ///Params:
    ///    owner = A pointer to the <b>IUnknown</b> interface of the parent.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>owner</i> is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetOwner(IUnknown* owner);
    ///Gets the object type of the interface.
    ///Params:
    ///    type = The XPS_OBJECT_TYPE value that describes the interface that is derived from IXpsOMShareable.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>type</i> is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetType(XPS_OBJECT_TYPE* type);
}

///The base interface for path, canvas, and glyph interfaces.
@GUID("BC3E7333-FB0B-4AF3-A819-0B4EAAD0D2FD")
interface IXpsOMVisual : IXpsOMShareable
{
    ///Gets a pointer to the IXpsOMMatrixTransform interface that contains the visual's resolved matrix transform.
    ///Params:
    ///    matrixTransform = A pointer to the IXpsOMMatrixTransform interface that contains the visual's resolved matrix transform. If a
    ///                      matrix transform has not been set, a <b>NULL</b> pointer is returned. The value that is returned in this
    ///                      parameter depends on which method has most recently been called to set the transform. <table> <tr> <th>Most
    ///                      recent method called</th> <th>Object that is returned in <i>matrixTransform</i></th> </tr> <tr> <td>
    ///                      SetTransformLocal </td> <td> The local transform that is set by SetTransformLocal. </td> </tr> <tr> <td>
    ///                      SetTransformLookup </td> <td> The shared transform that gets retrieved, with a lookup key that matches the
    ///                      key that is set by SetTransformLookup, from the resource directory. </td> </tr> <tr> <td> Neither
    ///                      SetTransformLocal nor SetTransformLookup has been called yet. </td> <td> <b>NULL</b> pointer. </td> </tr>
    ///                      </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>matrixTransform</i> is <b>NULL</b>. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>XPS_E_LOOKUP_INVALID_TYPE</b></dt> </dl> </td> <td width="60%"> The
    ///    lookup key name set by SetStrokeBrushLookup references an object that is not a brush. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>XPS_E_LOOKUP_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> No object could be
    ///    found with a key name that matched the lookup value. </td> </tr> </table>
    ///    
    HRESULT GetTransform(IXpsOMMatrixTransform* matrixTransform);
    ///Gets a pointer to the IXpsOMMatrixTransform interface that contains the local, unshared, resolved matrix
    ///transform for the visual.
    ///Params:
    ///    matrixTransform = A pointer to the IXpsOMMatrixTransform interface that contains the local, unshared, resolved matrix transform
    ///                      for the visual. If a matrix transform lookup key has not been set, or if a local matrix transform has been
    ///                      set, a <b>NULL</b> pointer is returned. <table> <tr> <th>Most recent method called</th> <th>Object that is
    ///                      returned in <i>matrixTransform</i></th> </tr> <tr> <td> SetTransformLocal </td> <td> The local transform that
    ///                      is set by SetTransformLocal. </td> </tr> <tr> <td> SetTransformLookup </td> <td> <b>NULL</b> pointer. </td>
    ///                      </tr> <tr> <td> Neither SetTransformLocal nor SetTransformLookup has been called yet. </td> <td> <b>NULL</b>
    ///                      pointer. </td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>matrixTransform</i> is <b>NULL</b>. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetTransformLocal(IXpsOMMatrixTransform* matrixTransform);
    ///Sets the local, unshared matrix transform.
    ///Params:
    ///    matrixTransform = A pointer to the IXpsOMMatrixTransform interface to be set as the local, unshared matrix transform. A
    ///                      <b>NULL</b> pointer releases the previously assigned transform.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>XPS_E_NO_CUSTOM_OBJECTS</b></dt> </dl> </td> <td width="60%"> <i>matrixTransform</i> does not
    ///    point to a recognized interface implementation. Custom implementation of XPS Document API interfaces is not
    ///    supported. </td> </tr> </table>
    ///    
    HRESULT SetTransformLocal(IXpsOMMatrixTransform matrixTransform);
    ///Gets the lookup key name of the IXpsOMMatrixTransform interface in a resource dictionary that contains the
    ///resolved matrix transform for the visual.
    ///Params:
    ///    key = The lookup key name for the IXpsOMMatrixTransform interface in a resource dictionary that contains the
    ///          resolved matrix transform for the visual. If a matrix transform lookup key has not been set, or if a local
    ///          matrix transform has been set, a <b>NULL</b> pointer is returned. <table> <tr> <th>Most recent method
    ///          called</th> <th>Object that is returned in <i>key</i></th> </tr> <tr> <td> SetTransformLocal </td> <td>
    ///          <b>NULL</b> pointer. </td> </tr> <tr> <td> SetTransformLookup </td> <td> The lookup key that is set by
    ///          SetTransformLookup. </td> </tr> <tr> <td> Neither SetTransformLocal nor SetTransformLookup has been called
    ///          yet. </td> <td> <b>NULL</b> pointer. </td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>key</i> is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetTransformLookup(ushort** key);
    ///Sets the lookup key name of a shared matrix transform in a resource dictionary.
    ///Params:
    ///    key = The lookup key name of the matrix transform in the dictionary.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>XPS_E_INVALID_RESOURCE_KEY</b></dt> </dl> </td> <td width="60%"> According to the XML Paper
    ///    Specification, the value of <i>lookup</i> is not a valid lookup key string. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>XPS_E_INVALID_LOOKUP_TYPE</b></dt> </dl> </td> <td width="60%"> The lookup key name in <i>key</i>
    ///    references an object that is not a geometry. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>XPS_E_LOOKUP_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> No object could be found with a key name
    ///    that matched the value passed in <i>key</i>. </td> </tr> </table>
    ///    
    HRESULT SetTransformLookup(const(wchar)* key);
    ///Gets a pointer to the IXpsOMGeometry interface that contains the resolved geometry of the visual's clipping
    ///region.
    ///Params:
    ///    clipGeometry = A pointer to the IXpsOMGeometry interface that contains the resolved geometry of the visual's clipping
    ///                   region. If the clip geometry has not been set, a <b>NULL</b> pointer is returned. The value that is returned
    ///                   in this parameter depends on which method has most recently been called to set the geometry. <table> <tr>
    ///                   <th>Most recent method called</th> <th>Object that is returned in <i>clipGeometry</i></th> </tr> <tr> <td>
    ///                   SetClipGeometryLocal </td> <td> The local clip geometry that is set by SetClipGeometryLocal. </td> </tr> <tr>
    ///                   <td> SetClipGeometryLookup </td> <td> The shared clip geometry that gets retrieved, with a lookup key that
    ///                   matches the key that is set by SetClipGeometryLookup, from the resource directory. </td> </tr> <tr> <td>
    ///                   Neither SetClipGeometryLocal nor SetClipGeometryLookup has been called yet. </td> <td> <b>NULL</b> pointer.
    ///                   </td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>clipGeometry</i> is <b>NULL</b>. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>XPS_E_LOOKUP_INVALID_TYPE</b></dt> </dl> </td> <td width="60%"> The lookup
    ///    key name set by SetStrokeBrushLookup references an object that is not a brush. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>XPS_E_LOOKUP_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> No object could be
    ///    found with a key name that matched the lookup value. </td> </tr> </table>
    ///    
    HRESULT GetClipGeometry(IXpsOMGeometry* clipGeometry);
    ///Gets a pointer to the IXpsOMGeometry interface that contains the local, unshared geometry of the visual's
    ///clipping region.
    ///Params:
    ///    clipGeometry = A pointer to the IXpsOMGeometry interface that contains the local, unshared geometry of the visual's clipping
    ///                   region. If a clip geometry lookup key has been set, or if a local clip geometry has not been set, a
    ///                   <b>NULL</b> pointer is returned. <table> <tr> <th>Most recent method called</th> <th>Object that is returned
    ///                   in <i>clipGeometry</i></th> </tr> <tr> <td> SetClipGeometryLocal </td> <td> The local clip geometry that is
    ///                   set by SetClipGeometryLocal. </td> </tr> <tr> <td> SetClipGeometryLookup </td> <td> <b>NULL</b> pointer.
    ///                   </td> </tr> <tr> <td> Neither SetClipGeometryLocal nor SetClipGeometryLookup has been called yet. </td> <td>
    ///                   <b>NULL</b> pointer. </td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>clipGeometry</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetClipGeometryLocal(IXpsOMGeometry* clipGeometry);
    ///Sets the local, unshared clipping region for the visual.
    ///Params:
    ///    clipGeometry = A pointer to the IXpsOMGeometry interface to be set as the local, unshared clipping region for the visual. A
    ///                   <b>NULL</b> pointer releases the previously assigned geometry interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>XPS_E_NO_CUSTOM_OBJECTS</b></dt> </dl> </td> <td width="60%"> <i>clipGeometry</i> does not point
    ///    to a recognized interface implementation. Custom implementation of XPS Document API interfaces is not
    ///    supported. </td> </tr> </table>
    ///    
    HRESULT SetClipGeometryLocal(IXpsOMGeometry clipGeometry);
    ///Gets the lookup key for the IXpsOMGeometry interface in a resource dictionary that contains the visual's clipping
    ///region.
    ///Params:
    ///    key = The lookup key for the IXpsOMGeometry interface in a resource dictionary that contains the visual's clipping
    ///          region. If a lookup key for the clip geometry has not been set, or if a local clip geometry has been set, a
    ///          <b>NULL</b> pointer is returned. <table> <tr> <th>Most recent method called</th> <th>Lookup key string that
    ///          is returned in <i>key</i></th> </tr> <tr> <td> SetClipGeometryLocal </td> <td> <b>NULL</b> pointer. </td>
    ///          </tr> <tr> <td> SetClipGeometryLookup </td> <td> The lookup key that is set by SetClipGeometryLookup. </td>
    ///          </tr> <tr> <td> Neither SetClipGeometryLocal nor SetClipGeometryLookup has been called yet. </td> <td>
    ///          <b>NULL</b> pointer. </td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>key</i> is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetClipGeometryLookup(ushort** key);
    ///Sets the lookup key name of a shared clip geometry in a resource dictionary.
    ///Params:
    ///    key = The lookup key name of the clip geometry in the dictionary. A <b>NULL</b> pointer clears the previously
    ///          assigned key name.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>XPS_E_INVALID_RESOURCE_KEY</b></dt> </dl> </td> <td width="60%"> According to the XML Paper
    ///    Specification, the value of <i>lookup</i> is not a valid lookup key string. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>XPS_E_INVALID_LOOKUP_TYPE</b></dt> </dl> </td> <td width="60%"> The lookup key name in <i>key</i>
    ///    references an object that is not a geometry. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>XPS_E_LOOKUP_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> No object could be found with a key name
    ///    that matched the value passed in <i>key</i>. </td> </tr> </table>
    ///    
    HRESULT SetClipGeometryLookup(const(wchar)* key);
    ///Gets the opacity value of this visual.
    ///Params:
    ///    opacity = The opacity value.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>opacity</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetOpacity(float* opacity);
    ///Sets the opacity value of the visual.
    ///Params:
    ///    opacity = The opacity value to be set for the visual. The range of allowed values for this parameter is 0.0 to 1.0;
    ///              with 0.0 the visual is completely transparent, and with 1.0 it is completely opaque.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>opacity</i> contains a value that is not
    ///    allowed. </td> </tr> </table>
    ///    
    HRESULT SetOpacity(float opacity);
    ///Gets a pointer to the IXpsOMBrush interface of the visual's opacity mask brush.
    ///Params:
    ///    opacityMaskBrush = A pointer to the IXpsOMBrush interface of the visual's opacity mask brush. If an opacity mask brush has not
    ///                       been set for this visual, a <b>NULL</b> pointer is returned. The value that is returned in this parameter
    ///                       depends on which method has most recently been called to set the brush. <table> <tr> <th>Most recent method
    ///                       called</th> <th>Object that is returned in <i>opacityMaskBrush</i></th> </tr> <tr> <td>
    ///                       SetOpacityMaskBrushLocal </td> <td> The local opacity mask brush that is set by SetOpacityMaskBrushLocal.
    ///                       </td> </tr> <tr> <td> SetOpacityMaskBrushLookup </td> <td> The shared opacity mask brush that gets retrieved,
    ///                       with a lookup key that matches the key that is set by SetOpacityMaskBrushLookup, from the resource directory.
    ///                       </td> </tr> <tr> <td> Neither SetOpacityMaskBrushLocal nor SetOpacityMaskBrushLookup has been called yet.
    ///                       </td> <td> <b>NULL</b> pointer. </td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>opacityMaskBrush</i> is <b>NULL</b>. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>XPS_E_LOOKUP_INVALID_TYPE</b></dt> </dl> </td> <td width="60%"> The
    ///    lookup key name set by SetStrokeBrushLookup references an object that is not a brush. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>XPS_E_LOOKUP_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> No object could be
    ///    found with a key name that matched the lookup value. </td> </tr> </table>
    ///    
    HRESULT GetOpacityMaskBrush(IXpsOMBrush* opacityMaskBrush);
    ///Gets the local, unshared opacity mask brush for the visual.
    ///Params:
    ///    opacityMaskBrush = A pointer to the IXpsOMBrush interface of the visual's opacity mask brush. If an opacity mask brush lookup
    ///                       key has been set, or if a local opacity mask brush has not been set, a <b>NULL</b> pointer is returned.
    ///                       <table> <tr> <th>Most recent method called</th> <th>Object that is returned in <i>opacityMaskBrush</i></th>
    ///                       </tr> <tr> <td> SetOpacityMaskBrushLocal </td> <td> The local opacity mask brush that is set by
    ///                       SetOpacityMaskBrushLocal. </td> </tr> <tr> <td> SetOpacityMaskBrushLookup </td> <td> <b>NULL</b> pointer.
    ///                       </td> </tr> <tr> <td> Neither SetOpacityMaskBrushLocal nor SetOpacityMaskBrushLookup has been called yet.
    ///                       </td> <td> <b>NULL</b> pointer. </td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>opacityMaskBrush</i> is <b>NULL</b>. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetOpacityMaskBrushLocal(IXpsOMBrush* opacityMaskBrush);
    ///Sets the IXpsOMBrush interface pointer as the local, unshared opacity mask brush.
    ///Params:
    ///    opacityMaskBrush = A pointer to the IXpsOMBrush interface to be set as the local, unshared opacity mask brush. A <b>NULL</b>
    ///                       pointer clears the previously assigned opacity mask brush.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>XPS_E_NO_CUSTOM_OBJECTS</b></dt> </dl> </td> <td width="60%"> <i>opacityMaskBrush</i> does not
    ///    point to a recognized interface implementation. Custom implementation of XPS Document API interfaces is not
    ///    supported. </td> </tr> </table>
    ///    
    HRESULT SetOpacityMaskBrushLocal(IXpsOMBrush opacityMaskBrush);
    ///Gets the name of the lookup key of the shared opacity mask brush in a resource dictionary.
    ///Params:
    ///    key = The name of the lookup key of the shared opacity mask brush in a resource dictionary. If the lookup key of an
    ///          opacity mask brush has not been set, or if a local opacity mask brush has been set, a <b>NULL</b> pointer is
    ///          returned. <table> <tr> <th>Most recent method called</th> <th>Object that is returned in <i>key</i></th>
    ///          </tr> <tr> <td> SetOpacityMaskBrushLocal </td> <td> <b>NULL</b> pointer. </td> </tr> <tr> <td>
    ///          SetOpacityMaskBrushLookup </td> <td> The lookup key that is set by SetOpacityMaskBrushLookup. </td> </tr>
    ///          <tr> <td> Neither SetOpacityMaskBrushLocal nor SetOpacityMaskBrushLookup has been called yet. </td> <td>
    ///          <b>NULL</b> pointer. </td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>key</i> is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetOpacityMaskBrushLookup(ushort** key);
    ///Sets the lookup key name of a shared opacity mask brush in a resource dictionary.
    ///Params:
    ///    key = The lookup key name of the opacity mask brush in the dictionary. A <b>NULL</b> pointer clears the previously
    ///          assigned key name.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>XPS_E_INVALID_RESOURCE_KEY</b></dt> </dl> </td> <td width="60%"> According to the XML Paper
    ///    Specification, the value of <i>lookup</i> is not a valid lookup key string. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>XPS_E_INVALID_LOOKUP_TYPE</b></dt> </dl> </td> <td width="60%"> The lookup key name in <i>key</i>
    ///    references an object that is not a geometry. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>XPS_E_LOOKUP_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> No object could be found with a key name
    ///    that matched the value passed in <i>key</i>. </td> </tr> </table>
    ///    
    HRESULT SetOpacityMaskBrushLookup(const(wchar)* key);
    ///Gets the <b>Name</b> property of the visual.
    ///Params:
    ///    name = The <b>Name</b> property string. If the <b>Name</b> property has not been set, a <b>NULL</b> pointer is
    ///           returned.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>name</i> is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetName(ushort** name);
    ///Sets the <b>Name</b> property of the visual.
    ///Params:
    ///    name = The name of the visual. A <b>NULL</b> pointer clears the <b>Name</b> property.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>XPS_E_INVALID_NAME</b></dt> </dl> </td> <td width="60%"> According to the XML Paper
    ///    Specification, the string that is passed in <i>name</i> is not a valid name. </td> </tr> </table>
    ///    
    HRESULT SetName(const(wchar)* name);
    ///Gets a value that indicates whether the visual is the target of a hyperlink.
    ///Params:
    ///    isHyperlink = The Boolean value that indicates whether the visual is the target of a hyperlink. <table> <tr> <th>Value</th>
    ///                  <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TRUE"></a><a id="true"></a><dl>
    ///                  <dt><b><b>TRUE</b></b></dt> </dl> </td> <td width="60%"> The visual is the target of a hyperlink. </td> </tr>
    ///                  <tr> <td width="40%"><a id="FALSE"></a><a id="false"></a><dl> <dt><b><b>FALSE</b></b></dt> </dl> </td> <td
    ///                  width="60%"> The visual is not the target of a hyperlink. </td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>isHyperlink</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetIsHyperlinkTarget(int* isHyperlink);
    ///Specifies whether the visual is the target of a hyperlink.
    ///Params:
    ///    isHyperlink = The Boolean value that specifies whether the visual is the target of a hyperlink. <table> <tr> <th>Value</th>
    ///                  <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TRUE"></a><a id="true"></a><dl>
    ///                  <dt><b><b>TRUE</b></b></dt> </dl> </td> <td width="60%"> The visual is the target of a hyperlink. </td> </tr>
    ///                  <tr> <td width="40%"><a id="FALSE"></a><a id="false"></a><dl> <dt><b><b>FALSE</b></b></dt> </dl> </td> <td
    ///                  width="60%"> The visual is not the target of a hyperlink. </td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>XPS_E_MISSING_NAME</b></dt> </dl> </td> <td width="60%"> The page has not been named. The
    ///    hyperlink target status can only be set if the page has a name. </td> </tr> </table>
    ///    
    HRESULT SetIsHyperlinkTarget(BOOL isHyperlink);
    ///Gets a pointer to the IUri interface to which this visual object links.
    ///Params:
    ///    hyperlinkUri = A pointer to the IUri interface that contains the destination URI for the link. If a URI has not been set for
    ///                   this object, a <b>NULL</b> pointer is returned.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>hyperlinkUri</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetHyperlinkNavigateUri(IUri* hyperlinkUri);
    ///Sets the destination URI of the visual's hyperlink.
    ///Params:
    ///    hyperlinkUri = The IUri interface that contains the destination URI of the visual's hyperlink.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetHyperlinkNavigateUri(IUri hyperlinkUri);
    ///Gets the <b>Language</b> property of the visual and of its contents.
    ///Params:
    ///    language = The language string that specifies the language of the page. If a language has not been set, a <b>NULL</b>
    ///               pointer is returned.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>language</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetLanguage(ushort** language);
    ///Sets the <b>Language</b> property of the visual.
    ///Params:
    ///    language = The language string that specifies the language of the visual and of its contents. A <b>NULL</b> pointer
    ///               clears the <b>Language</b> property.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>XPS_E_INVALID_LANGUAGE</b></dt> </dl> </td> <td width="60%"> The value of <i>language</i> is
    ///    formatted incorrectly or specifies a language that is not valid. </td> </tr> </table>
    ///    
    HRESULT SetLanguage(const(wchar)* language);
}

///The base interface for all XPS document part interfaces.
@GUID("74EB2F0B-A91E-4486-AFAC-0FABECA3DFC6")
interface IXpsOMPart : IUnknown
{
    ///Gets the name that will be used when the part is serialized.
    ///Params:
    ///    partUri = A pointer to the IOpcPartUri interface that contains the part name. If the part name has not been set (by the
    ///              SetPartName method), a <b>NULL</b> pointer is returned.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>partUri</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetPartName(IOpcPartUri* partUri);
    ///Sets the name that will be used when the part is serialized.
    ///Params:
    ///    partUri = A pointer to the IOpcPartUri interface that contains the name of this part. This parameter cannot be
    ///              <b>NULL</b>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>partUri</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT SetPartName(IOpcPartUri partUri);
}

///Allows batch modification of properties that affect the text content in an IXpsOMGlyphs interface.
@GUID("A5AB8616-5B16-4B9F-9629-89B323ED7909")
interface IXpsOMGlyphsEditor : IUnknown
{
    ///Performs cross-property validation and then copies the changes to the parent IXpsOMGlyphs interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The IXpsOMGlyphsEditor interface does not
    ///    belong to a valid IXpsOMGlyphs interface. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>XPS_E_CARET_OUTSIDE_STRING</b></dt> </dl> </td> <td width="60%"> Caret stops were specified for an
    ///    empty string, or the caret jump index has exceeded the length of the Unicode string. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>XPS_E_MAPPING_OUTSIDE_INDICES</b></dt> </dl> </td> <td width="60%"> The glyph
    ///    mappings exceed the number of glyph indices. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>XPS_E_MAPPING_OUTSIDE_STRING</b></dt> </dl> </td> <td width="60%"> Glyph mappings were defined for an
    ///    empty string. If the Unicode string is empty, there must not be any glyph mappings defined. or The glyph
    ///    mappings exceed the length of the Unicode string. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>XPS_E_MISSING_GLYPHS</b></dt> </dl> </td> <td width="60%"> The IXpsOMGlyphs interface without a
    ///    Unicode string does not have any glyph indices specified. An <b>IXpsOMGlyphs</b> interface must specify
    ///    either a Unicode string or an array of glyph indices. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>XPS_E_ODD_BIDILEVEL</b></dt> </dl> </td> <td width="60%"> The text string was specified as sideways
    ///    and right-to-left. If the text is sideways, it cannot have a bidi level that is an odd value (right-to-left).
    ///    Likewise, if the bidi level is an odd value, it cannot be sideways. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>XPS_E_ONE_TO_ONE_MAPPING_EXPECTED</b></dt> </dl> </td> <td width="60%"> Glyph mappings did not match
    ///    the Unicode string contents. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>XPS_E_TOO_MANY_INDICES</b></dt>
    ///    </dl> </td> <td width="60%"> There were more glyph indices than Unicode code points. If there are no glyph
    ///    mappings, the number of glyph indices must be less than or equal to the number of Unicode code points. </td>
    ///    </tr> </table>
    ///    
    HRESULT ApplyEdits();
    ///Gets the text in unescaped UTF-16 scalar values.
    ///Params:
    ///    unicodeString = The UTF-16 Unicode string. If the string is empty, a <b>NULL</b> pointer is returned.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>unicodeString</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetUnicodeString(ushort** unicodeString);
    ///Sets the text in unescaped UTF-16 scalar values.
    ///Params:
    ///    unicodeString = The address of a UTF-16 Unicode string. A <b>NULL</b> pointer clears the property.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetUnicodeString(const(wchar)* unicodeString);
    ///Gets the number of glyph indices.
    ///Params:
    ///    indexCount = The glyph index count.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>indexCount</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetGlyphIndexCount(uint* indexCount);
    HRESULT GetGlyphIndicesA(uint* indexCount, XPS_GLYPH_INDEX* glyphIndices);
    ///Sets an XPS_GLYPH_INDEX structure array that describes which glyph indices are to be used in the font.
    ///Params:
    ///    indexCount = The number of XPS_GLYPH_INDEX structures in the array that is referenced by <i>glyphIndices</i>. The value of
    ///                 0 clears the property.
    ///    glyphIndices = An array of XPS_GLYPH_INDEX structures that contain the glyph indices. If <i>indexCount</i> is 0, this
    ///                   parameter is ignored.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <b>index</b> field of one or more
    ///    XPS_GLYPH_INDEX structures has a value that is not valid. The <b>index</b> field must have a value between
    ///    and including –1 and 65535 (0xFFFF). </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl>
    ///    </td> <td width="60%"> <i>glyphIndices</i> is <b>NULL</b> and <i>indexCount</i> is greater than 0. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>XPS_E_INVALID_FLOAT</b></dt> </dl> </td> <td width="60%"> The
    ///    <b>advanceWidth</b>, <b>horizontalOffset</b>, or <b>verticalOffset</b> field of one or more XPS_GLYPH_INDEX
    ///    structures has a floating-point value that is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>XPS_E_NEGATIVE_FLOAT</b></dt> </dl> </td> <td width="60%"> The <b>advanceWidth</b> field of one or
    ///    more XPS_GLYPH_INDEX structures has a value that is not valid. The <b>advanceWidth</b> field must have a
    ///    non-negative value or a value of exactly –1.0; a negative value that is not exactly –1.0 is not valid.
    ///    </td> </tr> </table>
    ///    
    HRESULT SetGlyphIndices(uint indexCount, const(XPS_GLYPH_INDEX)* glyphIndices);
    ///Gets the number of glyph mappings.
    ///Params:
    ///    glyphMappingCount = The number of glyph mappings.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>glyphMappingCount</i> is <b>NULL</b>. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetGlyphMappingCount(uint* glyphMappingCount);
    ///Gets an array of XPS_GLYPH_MAPPING structures that describe how to map UTF-16 scalar values to entries in the
    ///array of XPS_GLYPH_INDEX structures, which is returned by GetGlyphIndices.
    ///Params:
    ///    glyphMappingCount = The number of XPS_GLYPH_MAPPING structures that will fit in the array referenced by <i>glyphMappings</i>.
    ///                        When the method returns, <i>glyphMappingCount</i> will contain the number of values in that array.
    ///    glyphMappings = An array of XPS_GLYPH_MAPPING structures that receives the glyph mapping values.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>glyphMappingCount</i> or <i>glyphMappings</i>
    ///    is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td
    ///    width="60%"> <i>glyphMappings</i> is not large enough to receive the glyph index data.
    ///    <i>glyphMappingCount</i> contains the required number of elements. </td> </tr> </table>
    ///    
    HRESULT GetGlyphMappings(uint* glyphMappingCount, XPS_GLYPH_MAPPING* glyphMappings);
    ///Sets an array of XPS_GLYPH_MAPPING structures that describe how to map the UTF-16 scalar values in the
    ///<b>UnicodeString</b> property to entries in the array of XPS_GLYPH_INDEX structures.
    ///Params:
    ///    glyphMappingCount = The number of XPS_GLYPH_MAPPING structures in the array that is referenced by <i>glyphMappings</i>. A value
    ///                        of 0 clears the property.
    ///    glyphMappings = An XPS_GLYPH_MAPPING structure array that contains the glyph mapping values. If <i>glyphMappingCount</i> is
    ///                    0, this parameter is ignored and can be set to <b>NULL</b>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> A member of one or more XPS_GLYPH_MAPPING
    ///    structures has a value that is not valid. This can occur in the following cases: the sum of string length and
    ///    start position is less than the start position; the sum of index position and index length is less than the
    ///    start position; and length of indices is 0. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> <i>glyphMappings</i> is <b>NULL</b> and <i>glyphMappingCount</i> is greater than
    ///    0. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>XPS_E_MAPPING_OUT_OF_ORDER</b></dt> </dl> </td> <td
    ///    width="60%"> In one or more XPS_GLYPH_MAPPING structures, an element is out of sequence. </td> </tr> </table>
    ///    
    HRESULT SetGlyphMappings(uint glyphMappingCount, const(XPS_GLYPH_MAPPING)* glyphMappings);
    ///Gets the number of prohibited caret stops.
    ///Params:
    ///    prohibitedCaretStopCount = The number of prohibited caret stops.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>prohibitedCaretStopCount</i> is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetProhibitedCaretStopCount(uint* prohibitedCaretStopCount);
    ///Gets an array of prohibited caret stop locations.
    ///Params:
    ///    count = The number of prohibited caret stop values that will fit in the array that is referenced by the
    ///            <i>prohibitedCaretStops</i> parameter. When the method returns, <i>prohibitedCaretStopCount</i> will contain
    ///            the number of values in that array.
    ///    prohibitedCaretStops = An array of glyph mapping values. If no prohibited caret stops have been defined, a <b>NULL</b> pointer is
    ///                           returned.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>prohibitedCaretStopCount</i>,
    ///    <i>prohibitedCaretStops</i>, or both were <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td width="60%"> <i>prohibitedCaretStops</i> was not large enough
    ///    to receive the prohibited caret stop data. <i>prohibitedCaretStopCount</i> contains the required number of
    ///    elements. </td> </tr> </table>
    ///    
    HRESULT GetProhibitedCaretStops(uint* count, uint* prohibitedCaretStops);
    ///Sets an array of prohibited caret stop locations.
    ///Params:
    ///    count = The number of prohibited caret stop locations in the array that is referenced by <i>prohibitedCaretStops</i>.
    ///            A value of 0 clears the property.
    ///    prohibitedCaretStops = The array of prohibited caret stop locations to be set. If <i>count</i> is 0, this parameter is ignored and
    ///                           can be set to <b>NULL</b>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>prohibitedCaretStops</i> is <b>NULL</b> and
    ///    <i>count</i> is greater than 0. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>XPS_E_CARET_OUTOFORDER</b></dt>
    ///    </dl> </td> <td width="60%"> A caret location value is out of order. The location values must be sorted in
    ///    ascending order. </td> </tr> </table>
    ///    
    HRESULT SetProhibitedCaretStops(uint count, const(uint)* prohibitedCaretStops);
    ///Gets the bidirectional text level of the parent IXpsOMGlyphs interface.
    ///Params:
    ///    bidiLevel = The bidirectional text level. Range: 0–61
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> bidiLevel is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetBidiLevel(uint* bidiLevel);
    ///Sets the level of bidirectional text.
    ///Params:
    ///    bidiLevel = The level of bidirectional text. Range: 0–61
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The value of <i>bidiLevel</i> is outside of
    ///    the allowed range. For more information, see the Remarks section. </td> </tr> </table>
    ///    
    HRESULT SetBidiLevel(uint bidiLevel);
    ///Gets a Boolean value that indicates whether the text is to be rendered with the glyphs rotated sideways.
    ///Params:
    ///    isSideways = The Boolean value that indicates whether the text is to be rendered with the glyphs rotated sideways. <table>
    ///                 <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TRUE"></a><a id="true"></a><dl>
    ///                 <dt><b><b>TRUE</b></b></dt> </dl> </td> <td width="60%"> Rotate the glyphs sideways. Produces sideways text.
    ///                 </td> </tr> <tr> <td width="40%"><a id="FALSE"></a><a id="false"></a><dl> <dt><b><b>FALSE</b></b></dt> </dl>
    ///                 </td> <td width="60%"> Do not rotate the glyphs sideways. Produces normal text. </td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>isSideways</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetIsSideways(int* isSideways);
    ///Sets the value that indicates whether the text is to be rendered with the glyphs rotated sideways.
    ///Params:
    ///    isSideways = The Boolean value that indicates whether the text is to be rendered with the glyphs rotated sideways. <table>
    ///                 <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TRUE"></a><a id="true"></a><dl>
    ///                 <dt><b>TRUE</b></dt> </dl> </td> <td width="60%"> Rotate the glyphs sideways. Produces sideways text. </td>
    ///                 </tr> <tr> <td width="40%"><a id="FALSE"></a><a id="false"></a><dl> <dt><b>FALSE</b></dt> </dl> </td> <td
    ///                 width="60%"> Do not rotate the glyphs sideways. Produces normal text. </td> </tr> </table>
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetIsSideways(BOOL isSideways);
    ///Gets the name of the device font.
    ///Params:
    ///    deviceFontName = The name of the device font; if not specified, a <b>NULL</b> pointer will be returned.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>deviceFontName</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetDeviceFontName(ushort** deviceFontName);
    ///Sets the name of the device font.
    ///Params:
    ///    deviceFontName = A pointer to the string that contains the name of the device font in its unescaped form. A <b>NULL</b>
    ///                     pointer clears the property.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetDeviceFontName(const(wchar)* deviceFontName);
}

///Describes the text that appears on a page. The IXpsOMGlyphsEditor interface is used to modify the text that is
///described by this interface.
@GUID("819B3199-0A5A-4B64-BEC7-A9E17E780DE2")
interface IXpsOMGlyphs : IXpsOMVisual
{
    ///Gets the text in unescaped UTF-16 scalar values.
    ///Params:
    ///    unicodeString = The UTF-16 Unicode string of the text to be displayed. If the string is empty, a <b>NULL</b> pointer is
    ///                    returned.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>unicodeString</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetUnicodeString(ushort** unicodeString);
    ///Gets the number of Glyph indices.
    ///Params:
    ///    indexCount = The number of glyph indices.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>indexCount</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetGlyphIndexCount(uint* indexCount);
    HRESULT GetGlyphIndicesA(uint* indexCount, XPS_GLYPH_INDEX* glyphIndices);
    ///Gets the number of glyph mappings.
    ///Params:
    ///    glyphMappingCount = The number of glyph mappings.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>glyphMappingCount</i> is <b>NULL</b>. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetGlyphMappingCount(uint* glyphMappingCount);
    ///Gets an array of XPS_GLYPH_MAPPING structures that describe how to map UTF-16 scalar values to entries in the
    ///array of XPS_GLYPH_INDEX structures, which is returned by GetGlyphIndices.
    ///Params:
    ///    glyphMappingCount = The number of XPS_GLYPH_MAPPING structures that will fit in the array referenced by <i>glyphMappings</i>.
    ///                        When the method returns, <i>glyphMappingCount</i> contains the number of values returned in the array
    ///                        referenced by <i>glyphMappings</i>.
    ///    glyphMappings = An array of XPS_GLYPH_MAPPING structures that contain the glyph mapping values.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>glyphMappingCount</i>, <i>glyphMappings</i>,
    ///    or both are <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td>
    ///    <td width="60%"> <i>glyphMappings</i> is not large enough to receive the glyph index data.
    ///    <i>glyphMappingCount</i> contains the required number of elements. </td> </tr> </table>
    ///    
    HRESULT GetGlyphMappings(uint* glyphMappingCount, XPS_GLYPH_MAPPING* glyphMappings);
    ///Gets the number of prohibited caret stops.
    ///Params:
    ///    prohibitedCaretStopCount = The number of prohibited caret stops.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>prohibitedCaretStopCount</i> is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetProhibitedCaretStopCount(uint* prohibitedCaretStopCount);
    ///Gets an array of prohibited caret stop locations.
    ///Params:
    ///    prohibitedCaretStopCount = The number of prohibited caret stop locations that will fit in the array referenced by
    ///                               <i>prohibitedCaretStops</i>. When the method returns, <i>prohibitedCaretStopCount</i> will contain the number
    ///                               of values returned in the array referenced by <i>prohibitedCaretStops</i>.
    ///    prohibitedCaretStops = An array of prohibited caret stop locations; if such are not defined, a <b>NULL</b> pointer is returned.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>prohibitedCaretStopCount</i>,
    ///    <i>prohibitedCaretStops</i>, or both are <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td width="60%"> <i>prohibitedCaretStops</i> is not large enough
    ///    to receive the prohibited caret stop data. <i>prohibitedCaretStopCount</i> contains the required number of
    ///    elements. </td> </tr> </table>
    ///    
    HRESULT GetProhibitedCaretStops(uint* prohibitedCaretStopCount, uint* prohibitedCaretStops);
    ///Gets the level of bidirectional text.
    ///Params:
    ///    bidiLevel = The level of bidirectional text. Range: 0–61
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>bidiLevel</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetBidiLevel(uint* bidiLevel);
    ///Gets a Boolean value that indicates whether the text is to be rendered with the glyphs rotated sideways.
    ///Params:
    ///    isSideways = The Boolean value that indicates whether the text is to be rendered with the glyphs rotated sideways. <table>
    ///                 <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TRUE"></a><a id="true"></a><dl>
    ///                 <dt><b><b>TRUE</b></b></dt> </dl> </td> <td width="60%"> Render the glyphs sideways to produce sideways text.
    ///                 </td> </tr> <tr> <td width="40%"><a id="FALSE"></a><a id="false"></a><dl> <dt><b><b>FALSE</b></b></dt> </dl>
    ///                 </td> <td width="60%"> Do not render the glyphs sideways to produce normal text. </td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>isSideways</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetIsSideways(int* isSideways);
    ///Gets the name of the device font.
    ///Params:
    ///    deviceFontName = The string that contains the unescaped name of the device font. If the name has not been set, a <b>NULL</b>
    ///                     pointer will be returned.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>deviceFontName</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetDeviceFontName(ushort** deviceFontName);
    ///Gets the style simulations that will be applied when rendering the glyphs.
    ///Params:
    ///    styleSimulations = The XPS_STYLE_SIMULATION value that describes the style simulations to be applied.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>styleSimulations</i> is <b>NULL</b>. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetStyleSimulations(XPS_STYLE_SIMULATION* styleSimulations);
    ///Sets the style simulations that will be applied when the glyphs are rendered.
    ///Params:
    ///    styleSimulations = The XPS_STYLE_SIMULATION value that specifies the style simulation to be applied.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>styleSimulations</i> is not a valid
    ///    XPS_STYLE_SIMULATION value. </td> </tr> </table>
    ///    
    HRESULT SetStyleSimulations(XPS_STYLE_SIMULATION styleSimulations);
    ///Gets the starting position of the text.
    ///Params:
    ///    origin = The XPS_POINT structure that receives the starting position of the text.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>origin</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetOrigin(XPS_POINT* origin);
    ///Sets the starting position of the text.
    ///Params:
    ///    origin = The XPS_POINT structure that contains the coordinates to be set as the text's starting position.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>origin</i> is <b>NULL</b>. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>origin.x</i> or
    ///    <i>origin.y</i> refers to a floating-point value that is not valid. </td> </tr> </table>
    ///    
    HRESULT SetOrigin(const(XPS_POINT)* origin);
    ///Gets the font size.
    ///Params:
    ///    fontRenderingEmSize = The font size.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>fontRenderingEmSize</i> is <b>NULL</b>. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetFontRenderingEmSize(float* fontRenderingEmSize);
    ///Sets the font size of the text.
    ///Params:
    ///    fontRenderingEmSize = The font size.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The value of <i>fontRenderingEmSize</i> is not
    ///    valid; it must be a non-negative number. </td> </tr> </table>
    ///    
    HRESULT SetFontRenderingEmSize(float fontRenderingEmSize);
    ///Gets a pointer to the IXpsOMFontResource interface of the font resource object required for this text.
    ///Params:
    ///    fontResource = A pointer to the IXpsOMFontResource interface of the font resource.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>fontResource</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetFontResource(IXpsOMFontResource* fontResource);
    ///Sets the pointer to the IXpsOMFontResource interface of the font resource object that is required for this text.
    ///Params:
    ///    fontResource = The pointer to the IXpsOMFontResource interface to be used.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>fontResource</i> is <b>NULL</b>. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>XPS_E_NO_CUSTOM_OBJECTS</b></dt> </dl> </td> <td width="60%">
    ///    <i>fontResource</i> does not point to a recognized interface implementation. Custom implementation of XPS
    ///    Document API interfaces is not supported. </td> </tr> </table>
    ///    
    HRESULT SetFontResource(IXpsOMFontResource fontResource);
    ///Gets the index of the font face to be used. This value is only used when GetFontResource returns an
    ///IXpsOMFontResource interface that represents a <b>TrueType</b> font collection.
    ///Params:
    ///    fontFaceIndex = The index value of the font face. If the font face has not been set, –1 is returned.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>fontFaceIndex</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetFontFaceIndex(short* fontFaceIndex);
    ///Sets the index of the font face to be used. This value is only used when GetFontResource returns an
    ///IXpsOMFontResource interface that represents a <b>TrueType</b> font collection.
    ///Params:
    ///    fontFaceIndex = The index value of the font face to be used.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The value of <i>fontFaceIndex</i> is not
    ///    valid; it must be an integer that is greater than or equal to –1. </td> </tr> </table>
    ///    
    HRESULT SetFontFaceIndex(short fontFaceIndex);
    ///Gets a pointer to the resolved IXpsOMBrush interface of the fill brush to be used for the text.
    ///Params:
    ///    fillBrush = A pointer to the resolved IXpsOMBrush interface of the fill brush to be used for the text. If a fill brush
    ///                has not been set, a <b>NULL</b> pointer will be returned. The value that is returned in this parameter
    ///                depends on which method has most recently been called to set the brush. <table> <tr> <th>Most recent method
    ///                called</th> <th>Object that is returned in <i>fillBrush</i></th> </tr> <tr> <td> SetFillBrushLocal </td> <td>
    ///                The local brush that is set by SetFillBrushLocal. </td> </tr> <tr> <td> SetFillBrushLookup </td> <td> The
    ///                shared brush retrieved, with a lookup key that matches the key that is set by SetFillBrushLookup, from the
    ///                local or resource directory. </td> </tr> <tr> <td> Neither SetFillBrushLocal nor SetFillBrushLookup has been
    ///                called yet. </td> <td> <b>NULL</b> pointer. </td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>fillBrush</i> is <b>NULL</b>. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>XPS_E_LOOKUP_INVALID_TYPE</b></dt> </dl> </td> <td width="60%"> The lookup key
    ///    name set by SetStrokeBrushLookup references an object that is not a brush. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>XPS_E_LOOKUP_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> No object could be found with a key
    ///    name that matched the lookup value. </td> </tr> </table>
    ///    
    HRESULT GetFillBrush(IXpsOMBrush* fillBrush);
    ///Gets a pointer to the local, unshared IXpsOMBrush interface of the fill brush to be used for the text.
    ///Params:
    ///    fillBrush = A pointer to the local, unshared IXpsOMBrush interface of the fill brush to be used for the text. If a fill
    ///                brush lookup key has been set or if a local fill brush has not been set, a <b>NULL</b> pointer will be
    ///                returned. <table> <tr> <th>Most recent method called</th> <th>Object that is returned in
    ///                <i>fillBrush</i></th> </tr> <tr> <td> SetFillBrushLocal </td> <td> The local brush that is set by
    ///                SetFillBrushLocal. </td> </tr> <tr> <td> SetFillBrushLookup </td> <td> <b>NULL</b> pointer. </td> </tr> <tr>
    ///                <td> Neither SetFillBrushLocal nor SetFillBrushLookup has been called yet. </td> <td> <b>NULL</b> pointer.
    ///                </td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>fillBrush</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetFillBrushLocal(IXpsOMBrush* fillBrush);
    ///Sets the IXpsOMBrush interface pointer to a local, unshared fill brush.
    ///Params:
    ///    fillBrush = The IXpsOMBrush interface pointer to be set as the local, unshared fill brush. A <b>NULL</b> pointer releases
    ///                any previously assigned brushes.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>XPS_E_NO_CUSTOM_OBJECTS</b></dt> </dl> </td> <td width="60%"> <i>fillBrush</i> does not point to
    ///    a recognized interface implementation. Custom implementation of XPS Document API interfaces is not supported.
    ///    </td> </tr> </table>
    ///    
    HRESULT SetFillBrushLocal(IXpsOMBrush fillBrush);
    ///Gets the lookup key of the IXpsOMBrush interface that is stored in a resource dictionary and will be used as the
    ///fill brush.
    ///Params:
    ///    key = The lookup key for the brush that is stored in a resource dictionary and will be used as the fill brush. If a
    ///          fill brush lookup key has not been set or if a local fill brush has been set, a <b>NULL</b> pointer will be
    ///          returned. <table> <tr> <th>Most recent method called</th> <th>String that is returned in <i>key</i></th>
    ///          </tr> <tr> <td> SetFillBrushLocal </td> <td> <b>NULL</b> pointer. </td> </tr> <tr> <td> SetFillBrushLookup
    ///          </td> <td> The lookup key that is set by SetFillBrushLookup. </td> </tr> <tr> <td> Neither SetFillBrushLocal
    ///          nor SetFillBrushLookup has been called yet. </td> <td> <b>NULL</b> pointer. </td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>key</i> is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetFillBrushLookup(ushort** key);
    ///Sets the lookup key name of a shared fill brush.
    ///Params:
    ///    key = A string variable that contains the key name of the fill brush that is stored in the resource dictionary and
    ///          will be used as the shared fill brush. A <b>NULL</b> pointer clears any previously assigned key string.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>XPS_E_INVALID_RESOURCE_KEY</b></dt> </dl> </td> <td width="60%"> According to the XML Paper
    ///    Specification, the value of <i>lookup</i> is not a valid lookup key string. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>XPS_E_INVALID_LOOKUP_TYPE</b></dt> </dl> </td> <td width="60%"> The lookup key name in <i>key</i>
    ///    references an object that is not a geometry. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>XPS_E_LOOKUP_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> No object could be found with a key name
    ///    that matched the value passed in <i>key</i>. </td> </tr> </table>
    ///    
    HRESULT SetFillBrushLookup(const(wchar)* key);
    ///Gets a pointer to the IXpsOMGlyphsEditor interface that will be used to edit the glyphs in the object.
    ///Params:
    ///    editor = A pointer to the IXpsOMGlyphsEditor interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>editor</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetGlyphsEditor(IXpsOMGlyphsEditor* editor);
    ///Makes a deep copy of the interface.
    ///Params:
    ///    glyphs = A pointer to the copy of the interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory to perform this operation.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>glyphs</i>
    ///    is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT Clone(IXpsOMGlyphs* glyphs);
}

///A collection of XPS_DASH structures.
@GUID("081613F4-74EB-48F2-83B3-37A9CE2D7DC6")
interface IXpsOMDashCollection : IUnknown
{
    ///Gets the number of XPS_DASH structures in the collection.
    ///Params:
    ///    count = The number of XPS_DASH structures in the collection.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetCount(uint* count);
    ///Gets an XPS_DASH structure from a specified location in the collection.
    ///Params:
    ///    index = The zero-based index in the collection where an XPS_DASH structure is to be obtained.
    ///    dash = The XPS_DASH structure that is found at the location specified by <i>index</i>.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetAt(uint index, XPS_DASH* dash);
    ///Inserts an XPS_DASH structure at a specified location in the collection.
    ///Params:
    ///    index = The zero-based index in the collection where the structure that is referenced by <i>dash</i> is to be
    ///            inserted.
    ///    dash = A pointer to the XPS_DASH structure that is to be inserted at the location specified by <i>index</i>.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT InsertAt(uint index, const(XPS_DASH)* dash);
    ///Removes and frees an XPS_DASH structure from a specified location in the collection.
    ///Params:
    ///    index = The zero-based index in the collection from which an XPS_DASH structure is to be removed and freed.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT RemoveAt(uint index);
    ///Replaces an XPS_DASH structure at a specified location in the collection.
    ///Params:
    ///    index = The zero-based index in the collection where an XPS_DASH structure is to be replaced.
    ///    dash = A pointer to the XPS_DASH structure that will replace the current contents at the location specified by
    ///           <i>index</i>.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetAt(uint index, const(XPS_DASH)* dash);
    ///Appends an XPS_DASH structure to the end of the collection.
    ///Params:
    ///    dash = A pointer to the XPS_DASH structure that is to be appended to the collection.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT Append(const(XPS_DASH)* dash);
}

///Specifies an affine matrix transform that can be applied to other objects in the object model.
@GUID("B77330FF-BB37-4501-A93E-F1B1E50BFC46")
interface IXpsOMMatrixTransform : IXpsOMShareable
{
    ///Gets the XPS_MATRIX structure, which specifies the transform matrix.
    ///Params:
    ///    matrix = The address of a variable that receives the XPS_MATRIX structure.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>matrix</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetMatrix(XPS_MATRIX* matrix);
    ///Sets the XPS_MATRIX structure, which specifies the transform matrix.
    ///Params:
    ///    matrix = The address of the XPS_MATRIX structure.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>matrix</i> is <b>NULL</b>. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The matrix referenced by
    ///    <i>matrix</i> is not valid. </td> </tr> </table>
    ///    
    HRESULT SetMatrix(const(XPS_MATRIX)* matrix);
    ///Makes a deep copy of the interface.
    ///Params:
    ///    matrixTransform = A pointer to the copy of the interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory to perform this operation.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%">
    ///    <i>matrixTransform</i> is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT Clone(IXpsOMMatrixTransform* matrixTransform);
}

///Describes the shape of a path or of a clipping region.
@GUID("64FCF3D7-4D58-44BA-AD73-A13AF6492072")
interface IXpsOMGeometry : IXpsOMShareable
{
    ///Gets a pointer to the geometry's IXpsOMGeometryFigureCollection interface, which contains the collection of
    ///figures that make up this geometry.
    ///Params:
    ///    figures = A pointer to the IXpsOMGeometryFigureCollection interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>figures</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetFigures(IXpsOMGeometryFigureCollection* figures);
    ///Gets the XPS_FILL_RULE value that describes the fill rule to be used.
    ///Params:
    ///    fillRule = The XPS_FILL_RULE value that describes the fill rule to be used.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>fillRule</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetFillRule(XPS_FILL_RULE* fillRule);
    ///Sets the XPS_FILL_RULE value that describes the fill rule to be used.
    ///Params:
    ///    fillRule = The XPS_FILL_RULE value that describes the fill rule to be used.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>fillRule</i> is not a valid XPS_FILL_RULE
    ///    value. </td> </tr> </table>
    ///    
    HRESULT SetFillRule(XPS_FILL_RULE fillRule);
    ///Gets a pointer to the geometry's IXpsOMMatrixTransform interface, which contains the resolved matrix transform
    ///for the geometry.
    ///Params:
    ///    transform = A pointer to the geometry's IXpsOMMatrixTransform interface, which contains the resolved matrix transform for
    ///                the geometry. If a matrix transform has not been set, a <b>NULL</b> pointer will be returned. The value that
    ///                is returned in this parameter depends on which method has most recently been called to set the transform.
    ///                <table> <tr> <th>Most recent method called</th> <th>Object that is returned in <i>transform</i></th> </tr>
    ///                <tr> <td> SetTransformLocal </td> <td> The local transform that is set by SetTransformLocal. </td> </tr> <tr>
    ///                <td> SetTransformLookup </td> <td> The shared transform retrieved, with a lookup key that matches the key
    ///                that is set by SetTransformLookup, from the resource directory. </td> </tr> <tr> <td> Neither
    ///                SetTransformLocal nor SetTransformLookup has been called yet. </td> <td> <b>NULL</b> pointer. </td> </tr>
    ///                </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>transform</i> is <b>NULL</b>. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>XPS_E_LOOKUP_INVALID_TYPE</b></dt> </dl> </td> <td width="60%"> The lookup key
    ///    name set by SetStrokeBrushLookup references an object that is not a brush. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>XPS_E_LOOKUP_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> No object could be found with a key
    ///    name that matched the lookup value. No object could be found with a key name that matched the value passed in
    ///    <i>lookup</i>. </td> </tr> </table>
    ///    
    HRESULT GetTransform(IXpsOMMatrixTransform* transform);
    ///Gets a pointer to the IXpsOMMatrixTransform interface that contains the local, unshared matrix transform for the
    ///geometry.
    ///Params:
    ///    transform = A pointer to the IXpsOMMatrixTransform interface that contains the local, unshared matrix transform for the
    ///                geometry. A <b>NULL</b> pointer is returned if a local matrix transform has not been set or a matrix
    ///                transform lookup key has been set. The value that is returned in this parameter depends on which method has
    ///                most recently been called to set the transform. <table> <tr> <th>Most recent method called</th> <th>Object
    ///                that is returned in <i>transform</i></th> </tr> <tr> <td> SetTransformLocal </td> <td> The local transform
    ///                that is set by SetTransformLocal. </td> </tr> <tr> <td> SetTransformLookup </td> <td> <b>NULL</b> pointer.
    ///                </td> </tr> <tr> <td> Neither SetTransformLocal nor SetTransformLookup has been called yet. </td> <td>
    ///                <b>NULL</b> pointer. </td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>transform</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetTransformLocal(IXpsOMMatrixTransform* transform);
    ///Sets the local, unshared matrix transform.
    ///Params:
    ///    transform = A pointer to the IXpsOMMatrixTransform interface to be set as the local, unshared matrix transform for the
    ///                geometry.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>XPS_E_NO_CUSTOM_OBJECTS</b></dt> </dl> </td> <td width="60%"> <i>transform</i> does not point to
    ///    a recognized interface implementation. Custom implementation of XPS Document API interfaces is not supported.
    ///    </td> </tr> </table>
    ///    
    HRESULT SetTransformLocal(IXpsOMMatrixTransform transform);
    ///Gets the lookup key for the IXpsOMMatrixTransform interface that contains the resolved matrix transform for the
    ///geometry. The matrix transform is stored in a resource dictionary.
    ///Params:
    ///    lookup = The lookup key for the IXpsOMMatrixTransform interface in a resource dictionary. A <b>NULL</b> pointer is
    ///             returned if a matrix transform lookup key has not been set or if a local matrix transform has been set. The
    ///             value that is returned in this parameter depends on which method has most recently been called to set the
    ///             transform. <table> <tr> <th>Most recent method called</th> <th>Object that is returned in <i>lookup</i></th>
    ///             </tr> <tr> <td> SetTransformLocal </td> <td> <b>NULL</b> pointer. </td> </tr> <tr> <td> SetTransformLookup
    ///             </td> <td> The lookup key set by SetTransformLookup. </td> </tr> <tr> <td> Neither SetTransformLocal nor
    ///             SetTransformLookup has been called yet. </td> <td> <b>NULL</b> pointer. </td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>lookup</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetTransformLookup(ushort** lookup);
    ///Sets the lookup key name of a shared matrix transform in a resource dictionary.
    ///Params:
    ///    lookup = The key name of the shared matrix transform in the resource dictionary.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>XPS_E_INVALID_RESOURCE_KEY</b></dt> </dl> </td> <td width="60%"> According to the XML Paper
    ///    Specification, the value of <i>lookup</i> is not a valid lookup key string. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>XPS_E_INVALID_LOOKUP_TYPE</b></dt> </dl> </td> <td width="60%"> The lookup key name in
    ///    <i>lookup</i> references an object that is not a transform. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>XPS_E_LOOKUP_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> No object could be found with a key name
    ///    that matches the value passed in <i>lookup</i>. </td> </tr> </table>
    ///    
    HRESULT SetTransformLookup(const(wchar)* lookup);
    ///Makes a deep copy of the interface.
    ///Params:
    ///    geometry = A pointer to the copy of the interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory to perform this operation.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>geometry</i>
    ///    is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT Clone(IXpsOMGeometry* geometry);
}

///Describes one portion of the path or clipping region that is specified by an IXpsOMGeometry interface.
@GUID("D410DC83-908C-443E-8947-B1795D3C165A")
interface IXpsOMGeometryFigure : IUnknown
{
    ///Gets a pointer to the IXpsOMGeometry interface that contains the geometry figure.
    ///Params:
    ///    owner = A pointer to the IXpsOMGeometry interface that contains the geometry figure. If the interface is not assigned
    ///            to a geometry, a <b>NULL</b> pointer is returned.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td>
    ///    <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl>
    ///    </td> <td width="60%"> <i>owner</i> is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetOwner(IXpsOMGeometry* owner);
    ///Gets the segment data points for the geometry figure.
    ///Params:
    ///    dataCount = The size of the array referenced by the <i>segmentData</i> parameter. If the method returns successfully,
    ///                <i>dataCount</i> will contain the number of elements returned in the array that is referenced by
    ///                <i>segmentData</i>. If <i>segmentData</i> is set to <b>NULL</b> when the method is called, <i>dataCount</i>
    ///                must be set to zero. If a <b>NULL</b> pointer is returned in <i>segmentData</i>, <i>dataCount</i> will
    ///                contain the required buffer size as the number of elements.
    ///    segmentData = The address of an array that has the same number of elements as specified in <i>dataCount</i>. This value can
    ///                  be set to <b>NULL</b> if the caller requires that the method return only the required buffer size in
    ///                  <i>dataCount</i>. If the array is large enough, this method copies the segment data points into the array and
    ///                  returns, in <i>dataCount</i>, the number of data points that are copied. If <i>segmentData</i> is set to
    ///                  <b>NULL</b> or references a buffer that is not large enough, a <b>NULL</b> pointer will be returned, no data
    ///                  will be copied, and <i>dataCount</i> will contain the required buffer size specified as the number of
    ///                  elements.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>dataCount</i> is <b>NULL</b>. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td width="60%"> <i>segmentData</i> is
    ///    <b>NULL</b> or references a buffer that is not large enough to receive the segment data. <i>dataCount</i>
    ///    contains the required number of elements. </td> </tr> </table>
    ///    
    HRESULT GetSegmentData(uint* dataCount, float* segmentData);
    ///Gets the types of segments in the figure.
    ///Params:
    ///    segmentCount = The size of the array that is referenced by <i>segmentTypes</i> (see below). This parameter must not be
    ///                   <b>NULL</b>. If the method returns successfully, <i>segmentCount</i> will contain the number of elements that
    ///                   are returned in the array referenced by <i>segmentTypes</i>. If <i>segmentTypes</i> is <b>NULL</b> when the
    ///                   method is called, <i>segmentCount</i> must be set to zero. If a <b>NULL</b> pointer is returned in
    ///                   <i>segmentTypes</i>, the value of <i>segmentCount</i> will contain the required buffer size, specified as the
    ///                   number of elements.
    ///    segmentTypes = An array of XPS_SEGMENT_TYPE values that has the same number of elements as specified in <i>segmentCount</i>.
    ///                   If the caller requires that only the specified buffer size be returned, set this value to <b>NULL</b>. If the
    ///                   array is large enough, this method will copy the XPS_SEGMENT_TYPE values into the array and return, in
    ///                   <i>segmentCount</i>, the number of the copied values. If <i>segmentTypes</i> is <b>NULL</b> or references a
    ///                   buffer that is not large enough, a <b>NULL</b> pointer will be returned, no data will be copied, and
    ///                   <i>segmentCount</i> will contain the required buffer size, which is specified as the number of elements.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td>
    ///    <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl>
    ///    </td> <td width="60%"> <i>segmentCount</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td width="60%"> <i>segmentTypes</i> is <b>NULL</b> or references
    ///    a buffer that is not large enough to receive the XPS_SEGMENT_TYPE data. <i>segmentCount</i> contains the
    ///    required number of elements. </td> </tr> </table>
    ///    
    HRESULT GetSegmentTypes(uint* segmentCount, XPS_SEGMENT_TYPE* segmentTypes);
    ///Gets stroke definitions for the figure's segments.
    ///Params:
    ///    segmentCount = The size of the array that is referenced by <i>segmentStrokes</i>. This parameter must not be <b>NULL</b>. If
    ///                   the method returns successfully, <i>segmentCount</i> will contain the number of elements that are returned in
    ///                   the array referenced by <i>segmentStrokes</i>. If <i>segmentStrokes</i> is <b>NULL</b> when the method is
    ///                   called, <i>segmentCount</i> must be set to zero. If a <b>NULL</b> pointer is returned in
    ///                   <i>segmentStrokes</i>, the value of <i>segmentCount</i> will contain the required buffer size, specified as
    ///                   the number of elements.
    ///    segmentStrokes = An array that has the same number of elements as specified in <i>segmentCount</i>. If the caller requires
    ///                     that this method return only the required buffer size, set this value to <b>NULL</b>. If the array is large
    ///                     enough, this method copies the segment stroke values into the array and returns, in <i>segmentCount</i>, the
    ///                     number of copied segment stroke values. If <i>segmentData</i> is <b>NULL</b> or references a buffer that is
    ///                     not large enough, a <b>NULL</b> pointer will be returned, no data will be copied, and <i>segmentCount</i>
    ///                     will contain the required buffer size that is specified as the number of elements. The following table shows
    ///                     the possible values of an element in the array that is referenced by <i>segmentStrokes</i>. <table> <tr>
    ///                     <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TRUE"></a><a id="true"></a><dl>
    ///                     <dt><b><b>TRUE</b></b></dt> </dl> </td> <td width="60%"> The segment is stroked. </td> </tr> <tr> <td
    ///                     width="40%"><a id="FALSE"></a><a id="false"></a><dl> <dt><b><b>FALSE</b></b></dt> </dl> </td> <td
    ///                     width="60%"> The segment is not stroked. </td> </tr> </table>
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td>
    ///    <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl>
    ///    </td> <td width="60%"> <i>segmentCount</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td width="60%"> <i>segmentStrokes</i> is <b>NULL</b> or
    ///    references a buffer that is not large enough to receive the segment stroke data. <i>segmentCount</i> contains
    ///    the required number of elements. </td> </tr> </table>
    ///    
    HRESULT GetSegmentStrokes(uint* segmentCount, int* segmentStrokes);
    ///Sets the segment information and data points for segments in the figure.
    ///Params:
    ///    segmentCount = The number of segments. This value is also the number of elements in the arrays that are referenced by
    ///                   <i>segmentTypes</i> and <i>segmentStrokes</i>.
    ///    segmentDataCount = The number of segment data points. This value is also the number of elements in the array that is referenced
    ///                       by <i>segmentData</i>.
    ///    segmentTypes = An array of XPS_SEGMENT_TYPE variables. The value of <i>segmentCount</i> specifies the number of elements in
    ///                   this array.
    ///    segmentData = An array of segment data values. The value of <i>segmentDataCount</i> specifies the number of elements in
    ///                  this array.
    ///    segmentStrokes = An array of segment stroke values. The value of <i>segmentCount</i> specifies the number of elements in this
    ///                     array.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>segmentTypes</i> contains a value of
    ///    unrecognized type. Alternatively, the number of entries in the <i>segmentData</i> array is greater than the
    ///    number of entries in the <i>segmentTypes</i> array. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>segmentTypes</i>, <i>segmentData</i>, or
    ///    <i>segmentStrokes</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>XPS_E_INVALID_FLOAT</b></dt> </dl> </td> <td width="60%"> <i>segmentData</i> contains a <b>FLOAT</b>
    ///    value that is infinite or is not a number (NAN). </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>XPS_E_MISSING_SEGMENT_DATA</b></dt> </dl> </td> <td width="60%"> The array that is passed in
    ///    <i>segmentData</i> has fewer entries than the array passed in <i>segmentTypes</i>. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>XPS_E_NEGATIVE_FLOAT</b></dt> </dl> </td> <td width="60%"> An entry in the array
    ///    that is passed in <i>segmentData</i> contains a negative value, but it must contain a non-negative value.
    ///    </td> </tr> </table>
    ///    
    HRESULT SetSegments(uint segmentCount, uint segmentDataCount, const(XPS_SEGMENT_TYPE)* segmentTypes, 
                        const(float)* segmentData, const(int)* segmentStrokes);
    ///Gets the starting point of the figure.
    ///Params:
    ///    startPoint = The coordinates of the starting point of the figure.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td>
    ///    <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl>
    ///    </td> <td width="60%"> <i>startPoint</i> is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetStartPoint(XPS_POINT* startPoint);
    ///Sets the starting point of the figure.
    ///Params:
    ///    startPoint = The coordinates of the starting point of the figure.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>startPoint</i> is <b>NULL</b>. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>XPS_E_INVALID_FLOAT</b></dt> </dl> </td> <td width="60%"> One of the fields
    ///    in the XPS_POINT structure that is passed in <i>startPoint</i> contains a value that is not valid. </td>
    ///    </tr> </table>
    ///    
    HRESULT SetStartPoint(const(XPS_POINT)* startPoint);
    ///Gets a value that indicates whether the figure is closed.
    ///Params:
    ///    isClosed = The Boolean value that indicates whether the figure is closed. <table> <tr> <th>Value</th> <th>Meaning</th>
    ///               </tr> <tr> <td width="40%"><a id="TRUE"></a><a id="true"></a><dl> <dt><b><b>TRUE</b></b></dt> </dl> </td> <td
    ///               width="60%"> The figure is closed. The line segment between the start and end points of the figure will be
    ///               stroked to close the shape. </td> </tr> <tr> <td width="40%"><a id="FALSE"></a><a id="false"></a><dl>
    ///               <dt><b><b>FALSE</b></b></dt> </dl> </td> <td width="60%"> The figure is open. No line segment will be stroked
    ///               between the start and end points of the figure. </td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>isClosed</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetIsClosed(int* isClosed);
    ///Sets a value that indicates whether the figure is closed.
    ///Params:
    ///    isClosed = The value to be set. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///               id="TRUE"></a><a id="true"></a><dl> <dt><b>TRUE</b></dt> </dl> </td> <td width="60%"> The figure is closed. A
    ///               line segment between the start point and the last point defined in the figure will be stroked. </td> </tr>
    ///               <tr> <td width="40%"><a id="FALSE"></a><a id="false"></a><dl> <dt><b>FALSE</b></dt> </dl> </td> <td
    ///               width="60%"> The figure is open. There is no line segment between the start point and the last point defined
    ///               in the figure. </td> </tr> </table>
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetIsClosed(BOOL isClosed);
    ///Gets a value that indicates whether the figure is filled.
    ///Params:
    ///    isFilled = The Boolean value that indicates whether the figure is filled. <table> <tr> <th>Value</th> <th>Meaning</th>
    ///               </tr> <tr> <td width="40%"><a id="TRUE"></a><a id="true"></a><dl> <dt><b><b>TRUE</b></b></dt> </dl> </td> <td
    ///               width="60%"> The figure is filled by a brush. </td> </tr> <tr> <td width="40%"><a id="FALSE"></a><a
    ///               id="false"></a><dl> <dt><b><b>FALSE</b></b></dt> </dl> </td> <td width="60%"> The figure is not filled. </td>
    ///               </tr> </table>
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td>
    ///    <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl>
    ///    </td> <td width="60%"> <i>isFilled</i> is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetIsFilled(int* isFilled);
    ///Sets a value that indicates whether the figure is filled.
    ///Params:
    ///    isFilled = The value to be set. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///               id="TRUE"></a><a id="true"></a><dl> <dt><b>TRUE</b></dt> </dl> </td> <td width="60%"> The figure is filled by
    ///               a brush. </td> </tr> <tr> <td width="40%"><a id="FALSE"></a><a id="false"></a><dl> <dt><b>FALSE</b></dt>
    ///               </dl> </td> <td width="60%"> The figure is not filled. </td> </tr> </table>
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetIsFilled(BOOL isFilled);
    ///Gets the number of segments in the figure.
    ///Params:
    ///    segmentCount = The number of segments in the figure.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td>
    ///    <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl>
    ///    </td> <td width="60%"> <i>segmentCount</i> is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetSegmentCount(uint* segmentCount);
    ///Gets the number of segment data points in the figure.
    ///Params:
    ///    segmentDataCount = The number of segment data points. <i>segmentDataCount</i> must not be <b>NULL</b> when the method is called.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td>
    ///    <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl>
    ///    </td> <td width="60%"> <i>segmentDataCount</i> is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetSegmentDataCount(uint* segmentDataCount);
    ///Gets the XPS_SEGMENT_STROKE_PATTERN value that indicates whether the segments in the figure are stroked.
    ///Params:
    ///    segmentStrokePattern = The XPS_SEGMENT_STROKE_PATTERN value that indicates whether the segments in the figure are stroked.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td>
    ///    <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl>
    ///    </td> <td width="60%"> <i>segmentStrokePattern</i> is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetSegmentStrokePattern(XPS_SEGMENT_STROKE_PATTERN* segmentStrokePattern);
    ///Makes a deep copy of the interface.
    ///Params:
    ///    geometryFigure = A pointer to the copy of the interface.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td>
    ///    <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt>
    ///    </dl> </td> <td width="60%"> Not enough memory to perform this operation. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>geometryFigure</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT Clone(IXpsOMGeometryFigure* geometryFigure);
}

///A collection of IXpsOMGeometryFigure interface pointers.
@GUID("FD48C3F3-A58E-4B5A-8826-1DE54ABE72B2")
interface IXpsOMGeometryFigureCollection : IUnknown
{
    ///Gets the number of IXpsOMGeometryFigure interface pointers in the collection.
    ///Params:
    ///    count = The number of IXpsOMGeometryFigure interface pointers in the collection.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetCount(uint* count);
    ///Gets an IXpsOMGeometryFigure interface pointer from a specified location in the collection.
    ///Params:
    ///    index = The zero-based index of the IXpsOMGeometryFigure interface pointer to be obtained.
    ///    geometryFigure = The IXpsOMGeometryFigure interface pointer at the location specified by <i>index</i>.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetAt(uint index, IXpsOMGeometryFigure* geometryFigure);
    ///Inserts an IXpsOMGeometryFigure interface pointer at a specified location in the collection.
    ///Params:
    ///    index = The zero-based index in the collection where the interface pointer that is passed in <i>geometryFigure</i> is
    ///            to be inserted.
    ///    geometryFigure = The IXpsOMGeometryFigure interface pointer that is to be inserted at the location specified by <i>index</i>.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT InsertAt(uint index, IXpsOMGeometryFigure geometryFigure);
    ///Removes and releases an IXpsOMGeometryFigure interface pointer from a specified location in the collection.
    ///Params:
    ///    index = The zero-based index in the collection from which an IXpsOMGeometryFigure interface pointer is to be removed
    ///            and released.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT RemoveAt(uint index);
    ///Replaces an IXpsOMGeometryFigure interface pointer at a specified location in the collection.
    ///Params:
    ///    index = The zero-based index in the collection where an IXpsOMGeometryFigure interface pointer is to be replaced.
    ///    geometryFigure = The IXpsOMGeometryFigure interface pointer that will replace current contents at the location specified by
    ///                     <i>index</i>.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetAt(uint index, IXpsOMGeometryFigure geometryFigure);
    ///Appends an IXpsOMGeometryFigure interface to the end of the collection.
    ///Params:
    ///    geometryFigure = A pointer to the IXpsOMGeometryFigure interface that is to be appended to the collection.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT Append(IXpsOMGeometryFigure geometryFigure);
}

///Describes a non-text visual item.
@GUID("37D38BB6-3EE9-4110-9312-14B194163337")
interface IXpsOMPath : IXpsOMVisual
{
    ///Gets a pointer to the path's IXpsOMGeometry interface, which describes the resolved fill area for this path.
    ///Params:
    ///    geometry = A pointer to the path's IXpsOMGeometry interface, which describes the resolved fill area for this path. If a
    ///               geometry has not been set, a <b>NULL</b> pointer is returned. The value that is returned in this parameter
    ///               depends on which method has most recently been called to set the geometry. <table> <tr> <th>Most recent
    ///               method called</th> <th>Object that is returned in <i>geometry</i></th> </tr> <tr> <td> SetGeometryLocal </td>
    ///               <td> The local geometry that is set by SetGeometryLocal. </td> </tr> <tr> <td> SetGeometryLookup </td> <td>
    ///               The shared geometry retrieved, with a lookup key that matches the key that is set by SetGeometryLookup, from
    ///               the resource directory. </td> </tr> <tr> <td> Neither SetGeometryLocal nor SetGeometryLookup has been called
    ///               yet. </td> <td> <b>NULL</b> pointer. </td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>geometry</i> is <b>NULL</b>. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>XPS_E_LOOKUP_INVALID_TYPE</b></dt> </dl> </td> <td width="60%"> The lookup key
    ///    name set by SetStrokeBrushLookup references an object that is not a brush. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>XPS_E_LOOKUP_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> No object could be found with a key
    ///    name that matched the lookup value. </td> </tr> </table>
    ///    
    HRESULT GetGeometry(IXpsOMGeometry* geometry);
    ///Gets the local, unshared geometry of the resolved fill area for this path.
    ///Params:
    ///    geometry = The local, unshared geometry of the resolved fill area for this path. If a geometry lookup key has been set
    ///               or if a local geometry has not been set, a <b>NULL</b> pointer is returned. <table> <tr> <th>Most recent
    ///               method called</th> <th>Object that is returned in <i>geometry</i></th> </tr> <tr> <td> SetGeometryLocal </td>
    ///               <td> The local geometry that is set by SetGeometryLocal. </td> </tr> <tr> <td> SetGeometryLookup </td> <td>
    ///               <b>NULL</b> pointer. </td> </tr> <tr> <td> Neither SetGeometryLocal nor SetGeometryLookup has been called
    ///               yet. </td> <td> <b>NULL</b> pointer. </td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>geometry</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetGeometryLocal(IXpsOMGeometry* geometry);
    ///Sets the pointer to the local, unshared IXpsOMGeometry interface that contains the geometry of the resolved fill
    ///area to be set for this path.
    ///Params:
    ///    geometry = The pointer to the local, unshared IXpsOMGeometry interface that contains the geometry of the resolved fill
    ///               area to be set for this path.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>XPS_E_NO_CUSTOM_OBJECTS</b></dt> </dl> </td> <td width="60%"> <i>geometry</i> does not point to a
    ///    recognized interface implementation. Custom implementation of XPS Document API interfaces is not supported.
    ///    </td> </tr> </table>
    ///    
    HRESULT SetGeometryLocal(IXpsOMGeometry geometry);
    ///Gets the lookup key of a shared geometry object that is stored in a resource dictionary and that describes the
    ///resolved fill area for this path.
    ///Params:
    ///    lookup = The lookup key of the geometry object that describes the resolved fill area for this path. If a geometry
    ///             lookup key has not been set or if a local geometry has been set, a <b>NULL</b> pointer is returned. <table>
    ///             <tr> <th>Most recent method called</th> <th>String that is returned in <i>lookup</i></th> </tr> <tr> <td>
    ///             SetGeometryLocal </td> <td> <b>NULL</b> pointer. </td> </tr> <tr> <td> SetGeometryLookup </td> <td> The
    ///             lookup key that is set by SetGeometryLookup. </td> </tr> <tr> <td> Neither SetGeometryLocal nor
    ///             SetGeometryLookup has been called yet. </td> <td> <b>NULL</b> pointer. </td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>lookup</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetGeometryLookup(ushort** lookup);
    ///Sets the lookup key name of a shared geometry in a resource dictionary. Here, the geometry describes the resolved
    ///fill area to be set for this path.
    ///Params:
    ///    lookup = The lookup key name of a shared geometry in a resource dictionary.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>XPS_E_INVALID_RESOURCE_KEY</b></dt> </dl> </td> <td width="60%"> According to the XML Paper
    ///    Specification, the value of <i>lookup</i> is not a valid lookup key string. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>XPS_E_INVALID_LOOKUP_TYPE</b></dt> </dl> </td> <td width="60%"> The lookup key name in
    ///    <i>lookup</i> references an object that is not a geometry. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>XPS_E_LOOKUP_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> No object could be found with a key name
    ///    that matched the value passed in <i>lookup</i>. </td> </tr> </table>
    ///    
    HRESULT SetGeometryLookup(const(wchar)* lookup);
    ///Gets the short textual description of the object's contents. This description is used by accessibility clients to
    ///describe the object.
    ///Params:
    ///    shortDescription = The short textual description of the object's contents. If this text has not been set, a <b>NULL</b> pointer
    ///                       will be returned.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>shortDescription</i> is <b>NULL</b>. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetAccessibilityShortDescription(ushort** shortDescription);
    ///Sets the short textual description of the object's contents. This description is used by accessibility clients to
    ///describe the object.
    ///Params:
    ///    shortDescription = The short textual description of the object's contents.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetAccessibilityShortDescription(const(wchar)* shortDescription);
    ///Gets the long (detailed) textual description of the object's contents. This description is used by accessibility
    ///clients to describe the object.
    ///Params:
    ///    longDescription = The detailed textual description of the object's contents. If this text has not been set, a <b>NULL</b>
    ///                      pointer will be returned.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>longDescription</i> is <b>NULL</b>. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetAccessibilityLongDescription(ushort** longDescription);
    ///Sets the long (detailed) textual description of the object's contents. This description is used by accessibility
    ///clients to describe the object.
    ///Params:
    ///    longDescription = The detailed textual description of the object's contents.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetAccessibilityLongDescription(const(wchar)* longDescription);
    ///Gets a Boolean value that indicates whether the path is to be snapped to device pixels when the path is rendered.
    ///Params:
    ///    snapsToPixels = A Boolean value that indicates whether the path is to be snapped to device pixels when the path is rendered.
    ///                    The following table describes the values possible for this parameter. <table> <tr> <th>Value</th>
    ///                    <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TRUE"></a><a id="true"></a><dl>
    ///                    <dt><b><b>TRUE</b></b></dt> </dl> </td> <td width="60%"> The path is to be snapped to device pixels. </td>
    ///                    </tr> <tr> <td width="40%"><a id="FALSE"></a><a id="false"></a><dl> <dt><b><b>FALSE</b></b></dt> </dl> </td>
    ///                    <td width="60%"> The path is not to be snapped to device pixels. </td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>snapsToPixels</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetSnapsToPixels(int* snapsToPixels);
    ///Sets a Boolean value that indicates whether the path will be snapped to device pixels when that path is being
    ///rendered.
    ///Params:
    ///    snapsToPixels = A Boolean value that indicates whether to snap the path to the device pixels when that path is being
    ///                    rendered. The following table describes the values possible for this parameter. <table> <tr> <th>Value</th>
    ///                    <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TRUE"></a><a id="true"></a><dl> <dt><b>TRUE</b></dt> </dl>
    ///                    </td> <td width="60%"> Snap the path to the device pixels. </td> </tr> <tr> <td width="40%"><a
    ///                    id="FALSE"></a><a id="false"></a><dl> <dt><b>FALSE</b></dt> </dl> </td> <td width="60%"> Do not snap the path
    ///                    to the device pixels. </td> </tr> </table>
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetSnapsToPixels(BOOL snapsToPixels);
    ///Gets a pointer to the resolved IXpsOMBrush interface that contains the stroke brush that has been set for the
    ///path.
    ///Params:
    ///    brush = The stroke brush that has been set for the path. If a stroke brush has not been set, a <b>NULL</b> pointer is
    ///            returned. The value that is returned in this parameter depends on which method has most recently been called
    ///            to set the brush. <table> <tr> <th>Most recent method called</th> <th>Object that is returned in
    ///            <i>brush</i></th> </tr> <tr> <td> SetStrokeBrushLocal </td> <td> The local brush that is set by
    ///            SetStrokeBrushLocal. </td> </tr> <tr> <td> SetStrokeBrushLookup </td> <td> The shared brush retrieved, with a
    ///            lookup key that matches the key that is set by SetStrokeBrushLookup, from the resource directory. </td> </tr>
    ///            <tr> <td> Neither SetStrokeBrushLocal nor SetStrokeBrushLookup has been called yet. </td> <td> <b>NULL</b>
    ///            pointer. </td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>brush</i> is <b>NULL</b>. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>XPS_E_LOOKUP_INVALID_TYPE</b></dt> </dl> </td> <td width="60%"> The lookup key name
    ///    set by SetStrokeBrushLookup references an object that is not a brush. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>XPS_E_LOOKUP_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> No object could be found with a key name
    ///    that matched the lookup value. </td> </tr> </table>
    ///    
    HRESULT GetStrokeBrush(IXpsOMBrush* brush);
    ///Gets a pointer to the local, unshared IXpsOMBrush interface that contains the stroke brush for the path.
    ///Params:
    ///    brush = The local, unshared IXpsOMBrush interface that contains the stroke brush for the path. If a stroke brush
    ///            lookup key has been set or if a local stroke brush has not been set, a <b>NULL</b> pointer is returned.
    ///            <table> <tr> <th>Most recent method called</th> <th>Object that is returned in <i>brush</i></th> </tr> <tr>
    ///            <td> SetStrokeBrushLocal </td> <td> The local brush that is set by SetStrokeBrushLocal. </td> </tr> <tr> <td>
    ///            SetStrokeBrushLookup </td> <td> <b>NULL</b> pointer. </td> </tr> <tr> <td> Neither SetStrokeBrushLocal nor
    ///            SetStrokeBrushLookup has been called yet. </td> <td> <b>NULL</b> pointer. </td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>brush</i> is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetStrokeBrushLocal(IXpsOMBrush* brush);
    ///Sets a pointer to a local, unshared IXpsOMBrush interface to be used as a stroke brush.
    ///Params:
    ///    brush = A pointer to a local, unshared IXpsOMBrush interface to be used as a stroke brush.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>XPS_E_NO_CUSTOM_OBJECTS</b></dt> </dl> </td> <td width="60%"> <i>brush</i> does not point to a
    ///    recognized interface implementation. Custom implementation of XPS Document API interfaces is not supported.
    ///    </td> </tr> </table>
    ///    
    HRESULT SetStrokeBrushLocal(IXpsOMBrush brush);
    ///Gets the lookup key of the brush that is stored in a resource dictionary and is to be used as the stroke brush
    ///for the path.
    ///Params:
    ///    lookup = The lookup key of a brush that is stored in a resource dictionary. If a stroke brush lookup key has not been
    ///             set or if a local stroke brush has been set, a <b>NULL</b> pointer is returned. <table> <tr> <th>Most recent
    ///             method called</th> <th>String that is returned in <i>lookup</i></th> </tr> <tr> <td> SetStrokeBrushLocal
    ///             </td> <td> <b>NULL</b> pointer. </td> </tr> <tr> <td> SetStrokeBrushLookup </td> <td> The lookup key that is
    ///             set by SetStrokeBrushLookup. </td> </tr> <tr> <td> Neither SetStrokeBrushLocal nor SetStrokeBrushLookup has
    ///             been called yet. </td> <td> <b>NULL</b> pointer. </td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>lookup</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetStrokeBrushLookup(ushort** lookup);
    ///Sets the lookup key name of a shared brush to be used as the stroke brush.The shared brush is stored in a
    ///resource dictionary.
    ///Params:
    ///    lookup = The lookup key name of a shared brush to be used as the stroke brush for the path.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>XPS_E_INVALID_RESOURCE_KEY</b></dt> </dl> </td> <td width="60%"> According to the XML Paper
    ///    Specification, the value of <i>lookup</i> is not a valid lookup key string. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>XPS_E_INVALID_LOOKUP_TYPE</b></dt> </dl> </td> <td width="60%"> The lookup key name in
    ///    <i>lookup</i> references an object that is not a brush. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>XPS_E_LOOKUP_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> No object could be found with a key name
    ///    that matched the value passed in <i>lookup</i>. </td> </tr> </table>
    ///    
    HRESULT SetStrokeBrushLookup(const(wchar)* lookup);
    ///Gets a pointer to the IXpsOMDashCollection interface that contains the XPS_DASH structures that define the dash
    ///pattern of the stroke.
    ///Params:
    ///    strokeDashes = A pointer to the IXpsOMDashCollection interface that contains the XPS_DASH structures that define the dash
    ///                   pattern of the stroke.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>strokeDashes</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetStrokeDashes(IXpsOMDashCollection* strokeDashes);
    ///Gets the style of the end cap to be used on the stroke dash.
    ///Params:
    ///    strokeDashCap = The XPS_DASH_CAP value that describes the style of the end cap to be used on the stroke dash.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>strokeDashCap</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetStrokeDashCap(XPS_DASH_CAP* strokeDashCap);
    ///Sets the style of the stroke's dash cap.
    ///Params:
    ///    strokeDashCap = The XPS_DASH_CAP value to be set.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> <i>strokeDashCap</i> was not a valid
    ///    XPS_DASH_CAP value. </td> </tr> </table>
    ///    
    HRESULT SetStrokeDashCap(XPS_DASH_CAP strokeDashCap);
    ///Gets the offset from the origin of the stroke to the starting point of the dash array pattern.
    ///Params:
    ///    strokeDashOffset = The offset value; specified in multiples of the stroke thickness.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>strokeDashOffset</i> is <b>NULL</b>. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetStrokeDashOffset(float* strokeDashOffset);
    ///Sets the offset from the origin of the stroke to the starting point of the dash array pattern.
    ///Params:
    ///    strokeDashOffset = The offset value to be set.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>strokeDashOffset</i> is not a valid offset
    ///    value. </td> </tr> </table>
    ///    
    HRESULT SetStrokeDashOffset(float strokeDashOffset);
    ///Gets the style of the line cap at the start of the stroke line.
    ///Params:
    ///    strokeStartLineCap = The XPS_LINE_CAP value that indicates the style of the line cap at the start of the stroke line.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>strokeStartLineCap</i> is <b>NULL</b>. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetStrokeStartLineCap(XPS_LINE_CAP* strokeStartLineCap);
    ///Sets the style of the stroke's line cap at the start of the stroke line.
    ///Params:
    ///    strokeStartLineCap = The XPS_LINE_CAP value to be set.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> <i>strokeStartLineCap</i> is not a valid
    ///    XPS_LINE_CAP value. </td> </tr> </table>
    ///    
    HRESULT SetStrokeStartLineCap(XPS_LINE_CAP strokeStartLineCap);
    ///Gets the style of the stroke line's end cap.
    ///Params:
    ///    strokeEndLineCap = The XPS_LINE_CAP value that specifies the style of the stroke line's end cap.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>strokeEndLineCap</i> is <b>NULL</b>. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetStrokeEndLineCap(XPS_LINE_CAP* strokeEndLineCap);
    ///Sets the style of the stroke line's end cap.
    ///Params:
    ///    strokeEndLineCap = The XPS_LINE_CAP value to be set.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> <i>strokeEndLineCap</i> is not a valid
    ///    XPS_LINE_CAP value. </td> </tr> </table>
    ///    
    HRESULT SetStrokeEndLineCap(XPS_LINE_CAP strokeEndLineCap);
    ///Gets the style for joining stroke lines.
    ///Params:
    ///    strokeLineJoin = The XPS_LINE_JOIN value of the line join style of the stroke.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>strokeLineJoin</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetStrokeLineJoin(XPS_LINE_JOIN* strokeLineJoin);
    ///Sets the style for joining stroke lines.
    ///Params:
    ///    strokeLineJoin = The XPS_LINE_JOIN value to be set.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> <i>strokeLineJoin</i> is not a valid
    ///    XPS_LINE_JOIN value. </td> </tr> </table>
    ///    
    HRESULT SetStrokeLineJoin(XPS_LINE_JOIN strokeLineJoin);
    ///Gets the miter limit value that is set for the stroke.
    ///Params:
    ///    strokeMiterLimit = The miter limit value that is set for the stroke.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>strokeMiterLimit</i> is <b>NULL</b>. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetStrokeMiterLimit(float* strokeMiterLimit);
    ///Sets the miter limit of the path.
    ///Params:
    ///    strokeMiterLimit = The miter limit value to be set. The value must be 1.0 or greater.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> A value that was passed in
    ///    <i>strokeMiterLimit</i> was not valid. </td> </tr> </table>
    ///    
    HRESULT SetStrokeMiterLimit(float strokeMiterLimit);
    ///Gets the stroke thickness.
    ///Params:
    ///    strokeThickness = The stroke thickness value.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>strokeStartLineCap</i> is <b>NULL</b>. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetStrokeThickness(float* strokeThickness);
    ///Sets the stroke thickness.
    ///Params:
    ///    strokeThickness = The stroke thickness value to be set; must be 0.0 or greater.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> A value that was passed in
    ///    <i>strokeThickness</i> was not valid. </td> </tr> </table>
    ///    
    HRESULT SetStrokeThickness(float strokeThickness);
    ///Gets a pointer to the resolved IXpsOMBrush interface that contains the fill brush for the path.
    ///Params:
    ///    brush = A pointer to the resolved IXpsOMBrush interface that contains the fill brush for the path. If a fill brush
    ///            has not been set, a <b>NULL</b> pointer is returned. The value that is returned in this parameter depends on
    ///            which method has most recently been called to set the brush. <table> <tr> <th>Most recent method called</th>
    ///            <th>Object that is returned in <i>brush</i></th> </tr> <tr> <td> SetFillBrushLocal </td> <td> The local brush
    ///            that is set by SetFillBrushLocal. </td> </tr> <tr> <td> SetFillBrushLookup </td> <td> The shared brush
    ///            retrieved, with a lookup key that matches the key that is set by SetFillBrushLookup, from the resource
    ///            directory. </td> </tr> <tr> <td> Neither SetFillBrushLocal nor SetFillBrushLookup has been called yet. </td>
    ///            <td> <b>NULL</b> pointer. </td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>brush</i> is <b>NULL</b>. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>XPS_E_LOOKUP_INVALID_TYPE</b></dt> </dl> </td> <td width="60%"> The lookup key name
    ///    set by SetStrokeBrushLookup references an object that is not a brush. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>XPS_E_LOOKUP_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> No object could be found with a key name
    ///    that matched the lookup value. </td> </tr> </table>
    ///    
    HRESULT GetFillBrush(IXpsOMBrush* brush);
    ///Gets a pointer to the local, unshared IXpsOMBrush interface that contains the fill brush for the path.
    ///Params:
    ///    brush = A pointer to the IXpsOMBrush interface to be used as the local, unshared fill brush for the path. If a fill
    ///            brush lookup key has been set or if a local fill brush has not been set, a <b>NULL</b> pointer is returned.
    ///            The value that is returned in this parameter depends on which method has most recently been called to set the
    ///            brush. <table> <tr> <th>Most recent method called</th> <th>Object that is returned in <i>brush</i></th> </tr>
    ///            <tr> <td> SetFillBrushLocal </td> <td> The local brush that is set by SetFillBrushLocal. </td> </tr> <tr>
    ///            <td> SetFillBrushLookup </td> <td> <b>NULL</b> pointer. </td> </tr> <tr> <td> Neither SetFillBrushLocal nor
    ///            SetFillBrushLookup has been called yet. </td> <td> <b>NULL</b> pointer. </td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>brush</i> is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetFillBrushLocal(IXpsOMBrush* brush);
    ///Sets the pointer to the local, unshared IXpsOMBrush interface to be used as the fill brush.
    ///Params:
    ///    brush = A pointer to the local, unshared IXpsOMBrush interface to be used as the fill brush.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>XPS_E_NO_CUSTOM_OBJECTS</b></dt> </dl> </td> <td width="60%"> <i>brush</i> does not point to a
    ///    recognized interface implementation. Custom implementation of XPS Document API interfaces is not supported.
    ///    </td> </tr> </table>
    ///    
    HRESULT SetFillBrushLocal(IXpsOMBrush brush);
    ///Gets the lookup key of the brush that is stored in a resource dictionary and used as the fill brush for the path.
    ///Params:
    ///    lookup = The lookup key for the fill brush that is stored in a resource dictionary. If the lookup key has not been set
    ///             or if a local fill brush has been set, a <b>NULL</b> pointer is returned. <table> <tr> <th>Most recent method
    ///             called</th> <th>String that is returned in <i>lookup</i></th> </tr> <tr> <td> SetFillBrushLocal </td> <td>
    ///             <b>NULL</b> pointer. </td> </tr> <tr> <td> SetFillBrushLookup </td> <td> The lookup key that is set by
    ///             SetFillBrushLookup. </td> </tr> <tr> <td> Neither SetFillBrushLocal nor SetFillBrushLookup has been called
    ///             yet. </td> <td> <b>NULL</b> pointer. </td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>lookup</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetFillBrushLookup(ushort** lookup);
    ///Sets the lookup key name of a shared brush in a resource dictionary, to be used as the fill brush.
    ///Params:
    ///    lookup = The key name of the brush in a resource dictionary, to be used as the fill brush.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>XPS_E_INVALID_RESOURCE_KEY</b></dt> </dl> </td> <td width="60%"> According to the XML Paper
    ///    Specification, the value of <i>lookup</i> is not a valid lookup key string. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>XPS_E_INVALID_LOOKUP_TYPE</b></dt> </dl> </td> <td width="60%"> The lookup key name in
    ///    <i>lookup</i> references an object that is not a brush. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>XPS_E_LOOKUP_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> No object could be found with a key name
    ///    that matched the value passed in <i>lookup</i>. </td> </tr> </table>
    ///    
    HRESULT SetFillBrushLookup(const(wchar)* lookup);
    ///Makes a deep copy of the interface.
    ///Params:
    ///    path = A pointer to the copy of the interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory to perform this operation.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>path</i> is
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT Clone(IXpsOMPath* path);
}

///Defines objects that are used to paint graphical objects. Classes that derive from <b>IXpsOMBrush</b> describe how
///the area is painted.
@GUID("56A3F80C-EA4C-4187-A57B-A2A473B2B42B")
interface IXpsOMBrush : IXpsOMShareable
{
    ///Gets the opacity of the brush.
    ///Params:
    ///    opacity = The opacity value of the brush.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>opacity</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetOpacity(float* opacity);
    ///Sets the opacity of the brush.
    ///Params:
    ///    opacity = The opacity value of the brush.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>opacity</i> is not a valid value. See the
    ///    Remarks section. </td> </tr> </table>
    ///    
    HRESULT SetOpacity(float opacity);
}

///A collection of IXpsOMGradientStop interface pointers.
@GUID("C9174C3A-3CD3-4319-BDA4-11A39392CEEF")
interface IXpsOMGradientStopCollection : IUnknown
{
    ///Gets the number of IXpsOMGradientStop interface pointers in the collection.
    ///Params:
    ///    count = The number of IXpsOMGradientStop interface pointers in the collection.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetCount(uint* count);
    ///Gets an IXpsOMGradientStop interface pointer from a specified location in the collection.
    ///Params:
    ///    index = The zero-based index of the IXpsOMGradientStop interface pointer to be obtained.
    ///    stop = The IXpsOMGradientStop interface pointer at the location specified by <i>index</i>.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetAt(uint index, IXpsOMGradientStop* stop);
    ///Inserts an IXpsOMGradientStop interface pointer at a specified location in the collection.
    ///Params:
    ///    index = The zero-based index in the collection where the interface pointer that is passed in <i>stop</i> is to be
    ///            inserted.
    ///    stop = The IXpsOMGradientStop interface pointer to be inserted at the location specified by <i>index</i>.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT InsertAt(uint index, IXpsOMGradientStop stop);
    ///Removes and releases an IXpsOMGradientStop interface pointer from a specified location in the collection.
    ///Params:
    ///    index = The zero-based index in the collection from which an IXpsOMGradientStop interface pointer is to be removed
    ///            and released.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The gradient stop collection has only two
    ///    stops. A gradient stop collection must have at least two gradient stops, and removing the specified gradient
    ///    stop would leave fewer than two gradient stops in the collection. </td> </tr> </table>
    ///    
    HRESULT RemoveAt(uint index);
    ///Replaces an IXpsOMGradientStop interface pointer at a specified location in the collection.
    ///Params:
    ///    index = The zero-based index in the collection where an IXpsOMGradientStop interface pointer is to be replaced.
    ///    stop = The IXpsOMGradientStop interface pointer that will replace current contents at the location specified by
    ///           <i>index</i>.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetAt(uint index, IXpsOMGradientStop stop);
    ///Appends an IXpsOMGradientStop interface to the end of the collection.
    ///Params:
    ///    stop = A pointer to the IXpsOMGradientStop interface that is to be appended to the collection.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT Append(IXpsOMGradientStop stop);
}

///A single-color brush.
@GUID("A06F9F05-3BE9-4763-98A8-094FC672E488")
interface IXpsOMSolidColorBrush : IXpsOMBrush
{
    ///Gets the color value and color profile of the brush.
    ///Params:
    ///    color = The color value of the brush.
    ///    colorProfile = The color profile of the brush. If no color profile has been specified for the brush, a <b>NULL</b> pointer
    ///                   is returned.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>color</i>, <i>colorProfile</i>, or both are
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetColor(XPS_COLOR* color, IXpsOMColorProfileResource* colorProfile);
    ///Sets the color value and color profile of the brush.
    ///Params:
    ///    color = The color value of the brush. If the value of the <b>colorType</b> field in the XPS_COLOR structure that is
    ///            passed in this parameter is XPS_COLOR_TYPE_CONTEXT, a valid color profile must be provided in the
    ///            <i>colorProfile</i> parameter.
    ///    colorProfile = The color profile to be used with <i>color</i>. A color profile is required when the value of the
    ///                   <b>colorType</b> field in the XPS_COLOR structure that is passed in the <i>color</i> parameter is
    ///                   XPS_COLOR_TYPE_CONTEXT. If the value of the <b>colorType</b> field is not <b>XPS_COLOR_TYPE_CONTEXT</b>, this
    ///                   parameter must be set to <b>NULL</b>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>color</i> is <b>NULL</b>. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>XPS_E_MISSING_COLORPROFILE</b></dt> </dl> </td> <td width="60%"> <i>colorProfile</i>
    ///    is <b>NULL</b> when a color profile is expected. A color profile is required when the color type is
    ///    XPS_COLOR_TYPE_CONTEXT. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>XPS_E_UNEXPECTED_COLORPROFILE</b></dt>
    ///    </dl> </td> <td width="60%"> <i>colorProfile</i> has a color profile when none is expected. A color profile
    ///    is only allowed when the color type is XPS_COLOR_TYPE_CONTEXT. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>XPS_E_NO_CUSTOM_OBJECTS</b></dt> </dl> </td> <td width="60%"> <i>colorProfile</i> does not point to a
    ///    recognized interface implementation. Custom implementation of XPS Document API interfaces is not supported.
    ///    </td> </tr> </table>
    ///    
    HRESULT SetColor(const(XPS_COLOR)* color, IXpsOMColorProfileResource colorProfile);
    ///Makes a deep copy of the interface.
    ///Params:
    ///    solidColorBrush = A pointer to the copy of the interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory to perform this operation.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%">
    ///    <i>solidColorBrush</i> is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT Clone(IXpsOMSolidColorBrush* solidColorBrush);
}

///A tile brush uses a visual image to paint a region by repeating the image. This is the base interface of
///IXpsOMImageBrush and IXpsOMVisualBrush.
@GUID("0FC2328D-D722-4A54-B2EC-BE90218A789E")
interface IXpsOMTileBrush : IXpsOMBrush
{
    ///Gets a pointer to the IXpsOMMatrixTransform interface that contains the resolved matrix transform for the brush.
    ///Params:
    ///    transform = A pointer to the IXpsOMMatrixTransform interface that contains the resolved matrix transform for the brush.
    ///                If a matrix transform has not been set, a <b>NULL</b> pointer is returned. The value that is returned in this
    ///                parameter depends on which method has most recently been called to set the transform. <table> <tr> <th>Most
    ///                recent method called</th> <th>Object that is returned in <i>transform</i></th> </tr> <tr> <td>
    ///                SetTransformLocal </td> <td> The transform that is set by SetTransformLocal. </td> </tr> <tr> <td>
    ///                SetTransformLookup </td> <td> The transform which is retrieved, using a lookup key that matches the key that
    ///                is set by SetTransformLookup, from the resource directory. </td> </tr> <tr> <td> Neither SetTransformLocal
    ///                nor SetTransformLookup has been called yet. </td> <td> <b>NULL</b> pointer. </td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>transform</i> is <b>NULL</b>. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>XPS_E_LOOKUP_INVALID_TYPE</b></dt> </dl> </td> <td width="60%"> The lookup key
    ///    name set by SetStrokeBrushLookup references an object that is not a brush. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>XPS_E_LOOKUP_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> No object could be found with a key
    ///    name that matched the lookup value. </td> </tr> </table>
    ///    
    HRESULT GetTransform(IXpsOMMatrixTransform* transform);
    ///Gets a pointer to the IXpsOMMatrixTransform interface that contains the local, unshared resolved matrix transform
    ///for the brush.
    ///Params:
    ///    transform = A pointer to the IXpsOMMatrixTransform interface that contains the local, unshared resolved matrix transform
    ///                for the brush. If a local matrix transform has not been set or if a matrix transform lookup key has been set,
    ///                a <b>NULL</b> pointer is returned. <table> <tr> <th>Most recent method called</th> <th>Object that is
    ///                returned in <i>transform</i></th> </tr> <tr> <td> SetTransformLocal </td> <td> The transform that is set by
    ///                SetTransformLocal. </td> </tr> <tr> <td> SetTransformLookup </td> <td> <b>NULL</b> pointer. </td> </tr> <tr>
    ///                <td> Neither SetTransformLocal nor SetTransformLookup has been called yet. </td> <td> <b>NULL</b> pointer.
    ///                </td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>transform</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetTransformLocal(IXpsOMMatrixTransform* transform);
    ///Sets the IXpsOMMatrixTransform interface pointer to a local, unshared matrix transform.
    ///Params:
    ///    transform = A pointer to the IXpsOMMatrixTransform interface to be set as the local, unshared matrix transform. If a
    ///                local transform has been set, a <b>NULL</b> pointer will release it.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>XPS_E_NO_CUSTOM_OBJECTS</b></dt> </dl> </td> <td width="60%"> <i>transform</i> does not point to
    ///    a recognized interface implementation. Custom implementation of XPS Document API interfaces is not supported.
    ///    </td> </tr> </table>
    ///    
    HRESULT SetTransformLocal(IXpsOMMatrixTransform transform);
    ///Gets the lookup key that identifies the IXpsOMMatrixTransform interface in a resource dictionary that contains
    ///the resolved matrix transform for the brush.
    ///Params:
    ///    key = The lookup key that identifies the IXpsOMMatrixTransform interface in a resource dictionary that contains the
    ///          resolved matrix transform for the brush. If a matrix transform lookup key has not been set or if a local
    ///          matrix transform has been set, a <b>NULL</b> pointer is returned. <table> <tr> <th>Most recent method
    ///          called</th> <th>Object that is returned in <i>key</i></th> </tr> <tr> <td> SetTransformLocal </td> <td>
    ///          <b>NULL</b> pointer. </td> </tr> <tr> <td> SetTransformLookup </td> <td> The lookup key set by
    ///          SetTransformLookup. </td> </tr> <tr> <td> Neither SetTransformLocal nor SetTransformLookup has been called
    ///          yet. </td> <td> <b>NULL</b> pointer. </td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>key</i> is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetTransformLookup(ushort** key);
    ///Sets the lookup key name of a shared matrix transform that will be used as the transform for this brush.The
    ///shared matrix transform that is referenced by the lookup key is stored in the resource dictionary.
    ///Params:
    ///    key = A string variable that contains the lookup key name of a shared matrix transform in the resource dictionary.
    ///          If a lookup key has already been set, a <b>NULL</b> pointer will clear it.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>XPS_E_INVALID_RESOURCE_KEY</b></dt> </dl> </td> <td width="60%"> According to the XML Paper
    ///    Specification, the value of <i>lookup</i> is not a valid lookup key string. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>XPS_E_INVALID_LOOKUP_TYPE</b></dt> </dl> </td> <td width="60%"> The lookup key name in <i>key</i>
    ///    references an object that is not a geometry. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>XPS_E_LOOKUP_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> No object could be found with a key name
    ///    that matched the value passed in <i>key</i>. </td> </tr> </table>
    ///    
    HRESULT SetTransformLookup(const(wchar)* key);
    ///Gets the portion of the source image to be used by the tile.
    ///Params:
    ///    viewbox = The XPS_RECT structure that describes the area of the source content to be used by the tile.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td>
    ///    <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl>
    ///    </td> <td width="60%"> <i>viewbox</i> is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetViewbox(XPS_RECT* viewbox);
    ///Sets the portion of the source content to be used as the tile image.
    ///Params:
    ///    viewbox = An XPS_RECT structure that describes the portion of the source content to be used as the tile image.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>viewbox</i> is <b>NULL</b>. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The rectangle described in
    ///    <i>viewbox</i> was not valid. </td> </tr> </table>
    ///    
    HRESULT SetViewbox(const(XPS_RECT)* viewbox);
    ///Gets the portion of the destination geometry that is covered by a single tile.
    ///Params:
    ///    viewport = The XPS_RECT structure that describes the portion of the destination geometry that is covered by a single
    ///               tile.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td>
    ///    <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl>
    ///    </td> <td width="60%"> <i>viewport</i> is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetViewport(XPS_RECT* viewport);
    ///Sets the portion of the destination geometry that is covered by a single tile.
    ///Params:
    ///    viewport = An XPS_RECT structure that describes the portion of the destination geometry that is covered by a single
    ///               tile.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>viewport</i> is <b>NULL</b>. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The rectangle described in
    ///    <i>viewport</i> is not valid. </td> </tr> </table>
    ///    
    HRESULT SetViewport(const(XPS_RECT)* viewport);
    ///Gets the XPS_TILE_MODE value that describes the tile mode of the brush.
    ///Params:
    ///    tileMode = The XPS_TILE_MODE value that describes the tile mode of the brush.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>tileMode</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetTileMode(XPS_TILE_MODE* tileMode);
    ///Sets the XPS_TILE_MODE value that describes the tiling mode of the brush.
    ///Params:
    ///    tileMode = The XPS_TILE_MODE value to be set.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td>
    ///    <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt>
    ///    </dl> </td> <td width="60%"> <i>tileMode</i> was not a valid XPS_TILE_MODE value. </td> </tr> </table>
    ///    
    HRESULT SetTileMode(XPS_TILE_MODE tileMode);
}

///A brush that uses a visual element as a source.
@GUID("97E294AF-5B37-46B4-8057-874D2F64119B")
interface IXpsOMVisualBrush : IXpsOMTileBrush
{
    ///Gets a pointer to the interface of the resolved visual to be used as the source for the brush.
    ///Params:
    ///    visual = A pointer to the IXpsOMVisual interface of the resolved visual object used as the source for the brush. If a
    ///             visual has not been set, a <b>NULL</b> pointer is returned. The value that is returned in this parameter
    ///             depends on which method has most recently been called to set the visual object. <table> <tr> <th>Most recent
    ///             method called</th> <th>Object that is returned in <i>visual</i></th> </tr> <tr> <td> SetVisualLocal </td>
    ///             <td> The visual that is set by SetVisualLocal. </td> </tr> <tr> <td> SetVisualLookup </td> <td> The visual
    ///             that is retrieved, with a lookup key that matches the key that is set by SetVisualLookup, from the resource
    ///             directory. </td> </tr> <tr> <td> Neither SetVisualLocal nor SetVisualLookup has been called yet. </td> <td>
    ///             <b>NULL</b> pointer. </td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>visual</i> is <b>NULL</b>. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>XPS_E_LOOKUP_INVALID_TYPE</b></dt> </dl> </td> <td width="60%"> The lookup key
    ///    name set by SetStrokeBrushLookup references an object that is not a brush. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>XPS_E_LOOKUP_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> No object could be found with a key
    ///    name that matched the lookup value. </td> </tr> </table>
    ///    
    HRESULT GetVisual(IXpsOMVisual* visual);
    ///Gets a pointer to the interface of the local, unshared visual used as the source for the brush.
    ///Params:
    ///    visual = A pointer to the IXpsOMVisual interface of the local, unshared visual used as the source for the brush. If a
    ///             local visual object has not been set or if a visual lookup key has been set, a <b>NULL</b> pointer is
    ///             returned. <table> <tr> <th>Most recent method called</th> <th>Object that is returned in <i>visual</i></th>
    ///             </tr> <tr> <td> SetVisualLocal </td> <td> The visual that is set by SetVisualLocal. </td> </tr> <tr> <td>
    ///             SetVisualLookup </td> <td> <b>NULL</b> pointer. </td> </tr> <tr> <td> Neither SetVisualLocal nor
    ///             SetVisualLookup has been called yet. </td> <td> <b>NULL</b> pointer. </td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>visual</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetVisualLocal(IXpsOMVisual* visual);
    ///Sets the interface pointer of the local, unshared visual used as the source for the brush.
    ///Params:
    ///    visual = A pointer to the IXpsOMVisual interface to be set as the visual for the brush. If a local visual has been
    ///             set, passing a <b>NULL</b> pointer will release it.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>XPS_E_NO_CUSTOM_OBJECTS</b></dt> </dl> </td> <td width="60%"> <i>visual</i> does not point to a
    ///    recognized interface implementation. Custom implementation of XPS Document API interfaces is not supported.
    ///    </td> </tr> </table>
    ///    
    HRESULT SetVisualLocal(IXpsOMVisual visual);
    ///Gets the lookup key name of a visual in a resource dictionary; the visual is to be used as the source for the
    ///brush.
    ///Params:
    ///    lookup = The key name of a visual in a resource dictionary; the visual is to be used as the source for the brush. If a
    ///             visual's lookup key has not been set, or if a local visual has been set, a <b>NULL</b> pointer is returned.
    ///             <table> <tr> <th>Most recent method called</th> <th>Object that is returned in <i>lookup</i></th> </tr> <tr>
    ///             <td> SetVisualLocal </td> <td> <b>NULL</b> pointer. </td> </tr> <tr> <td> SetVisualLookup </td> <td> The
    ///             lookup key that is set by SetVisualLookup. </td> </tr> <tr> <td> Neither SetVisualLocal nor SetVisualLookup
    ///             has been called yet. </td> <td> <b>NULL</b> pointer. </td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>lookup</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetVisualLookup(ushort** lookup);
    ///Sets the lookup key name of the shared visual, which is stored in a resource dictionary, to be used as the source
    ///for the brush.
    ///Params:
    ///    lookup = The lookup key name of the shared visual to be used as the source for the brush. If a lookup key has already
    ///             been set, a <b>NULL</b> pointer will clear it.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>XPS_E_INVALID_RESOURCE_KEY</b></dt> </dl> </td> <td width="60%"> According to the XML Paper
    ///    Specification, the value of <i>lookup</i> is not a valid lookup key string. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>XPS_E_INVALID_LOOKUP_TYPE</b></dt> </dl> </td> <td width="60%"> The lookup key name in <i>key</i>
    ///    references an object that is not a geometry. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>XPS_E_LOOKUP_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> No object could be found with a key name
    ///    that matched the value passed in <i>key</i>. </td> </tr> </table>
    ///    
    HRESULT SetVisualLookup(const(wchar)* lookup);
    ///Makes a deep copy of the interface.
    ///Params:
    ///    visualBrush = A pointer to the copy of the interface.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td>
    ///    <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt>
    ///    </dl> </td> <td width="60%"> Not enough memory to perform this operation. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>visualBrush</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT Clone(IXpsOMVisualBrush* visualBrush);
}

///A brush that uses a raster image as a source.
@GUID("3DF0B466-D382-49EF-8550-DD94C80242E4")
interface IXpsOMImageBrush : IXpsOMTileBrush
{
    ///Gets a pointer to the IXpsOMImageResource interface, which contains the image resource to be used as the source
    ///for the brush.
    ///Params:
    ///    imageResource = A pointer to the IXpsOMImageResource interface that contains the image resource to be used as the source for
    ///                    the brush.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>imageResource</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetImageResource(IXpsOMImageResource* imageResource);
    ///Sets a pointer to the IXpsOMImageResource interface that contains the image resource to be used as the source for
    ///the brush.
    ///Params:
    ///    imageResource = The image resource to be used as the source for the brush. This parameter must not be a <b>NULL</b> pointer.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>imageResource</i> is <b>NULL</b>. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>XPS_E_NO_CUSTOM_OBJECTS</b></dt> </dl> </td> <td width="60%">
    ///    <i>imageResource</i> does not point to a recognized interface implementation. Custom implementation of XPS
    ///    Document API interfaces is not supported. </td> </tr> </table>
    ///    
    HRESULT SetImageResource(IXpsOMImageResource imageResource);
    ///Gets a pointer to the IXpsOMColorProfileResource interface, which contains the color profile resource that is
    ///associated with the image.
    ///Params:
    ///    colorProfileResource = A pointer to the IXpsOMColorProfileResource interface that contains the color profile resource that is
    ///                           associated with the image. If no color profile resource has been set, a <b>NULL</b> pointer is returned.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>colorProfileResource</i> is <b>NULL</b>. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetColorProfileResource(IXpsOMColorProfileResource* colorProfileResource);
    ///Sets a pointer to the IXpsOMColorProfileResource interface, which contains the color profile resource that is
    ///associated with the image.
    ///Params:
    ///    colorProfileResource = The color profile resource that is associated with the image. A <b>NULL</b> pointer will release any
    ///                           previously set color profile resources.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>XPS_E_NO_CUSTOM_OBJECTS</b></dt> </dl> </td> <td width="60%"> <i>colorProfileResource</i> does
    ///    not point to a recognized interface implementation. Custom implementation of XPS Document API interfaces is
    ///    not supported. </td> </tr> </table>
    ///    
    HRESULT SetColorProfileResource(IXpsOMColorProfileResource colorProfileResource);
    ///Makes a deep copy of the interface.
    ///Params:
    ///    imageBrush = A pointer to the copy of the interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory to perform this operation.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%">
    ///    <i>imageBrush</i> is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT Clone(IXpsOMImageBrush* imageBrush);
}

///Represents a single color and location within a gradient.
@GUID("5CF4F5CC-3969-49B5-A70A-5550B618FE49")
interface IXpsOMGradientStop : IUnknown
{
    ///Gets a pointer to the IXpsOMGradientBrush interface that contains the gradient stop.
    ///Params:
    ///    owner = A pointer to the IXpsOMGradientBrush interface that contains the gradient stop. If the gradient stop is not
    ///            assigned to a gradient brush, a <b>NULL</b> pointer is returned.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>owner</i> is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetOwner(IXpsOMGradientBrush* owner);
    ///Gets the offset value of the gradient stop.
    ///Params:
    ///    offset = The offset value of the gradient stop, expressed as a fraction of the gradient path.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>offset</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetOffset(float* offset);
    ///Sets the offset location of the gradient stop.
    ///Params:
    ///    offset = The offset value that describes the location of the gradient stop as a fraction of the gradient path. The
    ///             valid range of this parameter is 0.0 &lt;= <i>offset</i> &lt;= 1.0.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>offset</i> did not contain a valid offset
    ///    value. </td> </tr> </table>
    ///    
    HRESULT SetOffset(float offset);
    ///Gets the color value and color profile of the gradient stop.
    ///Params:
    ///    color = The color value of the gradient stop.
    ///    colorProfile = A pointer to the IXpsOMColorProfileResource interface that contains the color profile to be used. If no color
    ///                   profile resource has been set, a <b>NULL</b> pointer is returned. See remarks.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>color</i>, <i>colorProfile</i>, or both were
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetColor(XPS_COLOR* color, IXpsOMColorProfileResource* colorProfile);
    ///Sets the color value and color profile of the gradient stop.
    ///Params:
    ///    color = The color value to be set at the gradient stop. If the value of the <b>colorType</b> field in the XPS_COLOR
    ///            structure that is passed in this parameter is XPS_COLOR_TYPE_CONTEXT, a valid color profile must be provided
    ///            in the <i>colorProfile</i> parameter.
    ///    colorProfile = The color profile to be used with <i>color</i>. A color profile is required when the value of the
    ///                   <b>colorType</b> field in the XPS_COLOR structure that is passed in the <i>color</i> parameter is
    ///                   XPS_COLOR_TYPE_CONTEXT. If the value of the <b>colorType</b> field is not <b>XPS_COLOR_TYPE_CONTEXT</b>, this
    ///                   parameter must be set to <b>NULL</b>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>color</i> is <b>NULL</b>. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>XPS_E_MISSING_COLORPROFILE</b></dt> </dl> </td> <td width="60%"> <i>colorProfile</i>
    ///    is <b>NULL</b> when a color profile was expected. A color profile is required when the color type is
    ///    XPS_COLOR_TYPE_CONTEXT. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>XPS_E_NO_CUSTOM_OBJECTS</b></dt> </dl>
    ///    </td> <td width="60%"> <i>colorProfile</i> does not point to a recognized interface implementation. Custom
    ///    implementation of XPS Document API interfaces is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>XPS_E_UNEXPECTED_COLORPROFILE</b></dt> </dl> </td> <td width="60%"> <i>colorProfile</i> contained a
    ///    color profile when one was not expected. A color profile is only allowed when the color type is
    ///    XPS_COLOR_TYPE_CONTEXT. </td> </tr> </table>
    ///    
    HRESULT SetColor(const(XPS_COLOR)* color, IXpsOMColorProfileResource colorProfile);
    ///Makes a deep copy of the IXpsOMGradientStop interface.
    ///Params:
    ///    gradientStop = A pointer to the copy of the interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory to perform this operation.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%">
    ///    <i>gradientStop</i> is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT Clone(IXpsOMGradientStop* gradientStop);
}

///This interface describes a gradient that is made up of gradient stops. Classes that inherit from
///<b>IXpsOMGradientBrush</b> specify different ways of interpreting gradient stops. <b>IXpsOMGradientBrush</b> is the
///base interface for the IXpsOMLinearGradientBrush and IXpsOMRadialGradientBrush interfaces.
@GUID("EDB59622-61A2-42C3-BACE-ACF2286C06BF")
interface IXpsOMGradientBrush : IXpsOMBrush
{
    ///Gets a pointer to an IXpsOMGradientStopCollection interface that contains the collection of IXpsOMGradientStop
    ///interfaces that define the gradient.
    ///Params:
    ///    gradientStops = A pointer to the IXpsOMGradientStopCollection interface that contains the collection of IXpsOMGradientStop
    ///                    interfaces.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>gradientStops</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetGradientStops(IXpsOMGradientStopCollection* gradientStops);
    ///Gets a pointer to the IXpsOMMatrixTransform interface that contains the resolved matrix transform for the brush.
    ///Params:
    ///    transform = A pointer to the IXpsOMMatrixTransform interface that contains the resolved matrix transform for the brush.
    ///                If the transform has not been set, a <b>NULL</b> pointer is returned. The value that is returned in this
    ///                parameter depends on which method has been most recently called to set the transform. <table> <tr> <th>Most
    ///                recent method called</th> <th>Object that is returned in <i>transform</i></th> </tr> <tr> <td>
    ///                SetTransformLocal </td> <td> The local transform that is set by SetTransformLocal. </td> </tr> <tr> <td>
    ///                SetTransformLookup </td> <td> The shared transform that is retrieved, with a lookup key that matches the key
    ///                set by SetTransformLookup, from the resource directory. </td> </tr> <tr> <td> Neither SetTransformLocal nor
    ///                SetTransformLookup has been called yet. </td> <td> <b>NULL</b> pointer. </td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>transform</i> is <b>NULL</b>. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>XPS_E_LOOKUP_INVALID_TYPE</b></dt> </dl> </td> <td width="60%"> The lookup key
    ///    name set by SetStrokeBrushLookup references an object that is not a brush. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>XPS_E_LOOKUP_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> No object could be found with a key
    ///    name that matched the lookup value. No object could be found with a key name that matched the value passed in
    ///    <i>lookup</i>. </td> </tr> </table>
    ///    
    HRESULT GetTransform(IXpsOMMatrixTransform* transform);
    ///Gets a pointer to the IXpsOMMatrixTransform interface that contains the local, unshared, resolved matrix
    ///transform for the brush.
    ///Params:
    ///    transform = A pointer to the IXpsOMMatrixTransform interface that contains the local, unshared, resolved matrix transform
    ///                for the brush. If the transform has not been set or if a matrix transform lookup key has been set, a
    ///                <b>NULL</b> pointer is returned. The value that is returned in this parameter depends on which method has
    ///                been most recently called to set the transform. <table> <tr> <th>Most recent method called</th> <th>Object
    ///                that is returned in <i>transform</i></th> </tr> <tr> <td> SetTransformLocal </td> <td> The local transform
    ///                that is set by SetTransformLocal. </td> </tr> <tr> <td> SetTransformLookup </td> <td> <b>NULL</b> pointer.
    ///                </td> </tr> <tr> <td> Neither SetTransformLocal nor SetTransformLookup has been called yet. </td> <td>
    ///                <b>NULL</b> pointer. </td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>transform</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetTransformLocal(IXpsOMMatrixTransform* transform);
    ///Sets the IXpsOMMatrixTransform interface pointer to a local, unshared matrix transform that is to be used for the
    ///brush.
    ///Params:
    ///    transform = A pointer to the IXpsOMMatrixTransform interface of the local, unshared matrix transform that is to be used
    ///                for the brush. A <b>NULL</b> pointer releases any previously set interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>XPS_E_NO_CUSTOM_OBJECTS</b></dt> </dl> </td> <td width="60%"> <i>transform</i> does not point to
    ///    a recognized interface implementation. Custom implementation of XPS Document API interfaces is not supported.
    ///    </td> </tr> </table>
    ///    
    HRESULT SetTransformLocal(IXpsOMMatrixTransform transform);
    ///Gets the name of the lookup key of the shared matrix transform interface that is to be used for the brush. The
    ///key name identifies a shared resource in a resource dictionary.
    ///Params:
    ///    key = The name of the lookup key of the shared matrix transform interface that is to be used for the brush. If the
    ///          lookup key name has not been set or if the local matrix transform has been set, a <b>NULL</b> pointer is
    ///          returned. The value that is returned in this parameter depends on which method has been most recently called
    ///          to set the lookup key or the transform. <table> <tr> <th>Most recent method called</th> <th>String that is
    ///          returned in <i>key</i></th> </tr> <tr> <td> SetTransformLocal </td> <td> <b>NULL</b> pointer. </td> </tr>
    ///          <tr> <td> SetTransformLookup </td> <td> The key that is set by SetTransformLookup. </td> </tr> <tr> <td>
    ///          Neither SetTransformLocal nor SetTransformLookup has been called yet. </td> <td> <b>NULL</b> pointer. </td>
    ///          </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>key</i> is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetTransformLookup(ushort** key);
    ///Sets the name of the lookup key of a shared matrix transform that is to be used for the brush. The key name
    ///identifies a shared resource in a resource dictionary.
    ///Params:
    ///    key = The name of the lookup key of the matrix transform that is to be used for the brush.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>XPS_E_INVALID_RESOURCE_KEY</b></dt> </dl> </td> <td width="60%"> According to the XML Paper
    ///    Specification, the value of <i>lookup</i> is not a valid lookup key string. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>XPS_E_INVALID_LOOKUP_TYPE</b></dt> </dl> </td> <td width="60%"> The lookup key name in <i>key</i>
    ///    references an object that is not a geometry. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>XPS_E_LOOKUP_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> No object could be found with a key name
    ///    that matched the value passed in <i>key</i>. </td> </tr> </table>
    ///    
    HRESULT SetTransformLookup(const(wchar)* key);
    ///Gets the XPS_SPREAD_METHOD value, which describes how the area outside of the gradient region will be rendered.
    ///Params:
    ///    spreadMethod = The XPS_SPREAD_METHOD value that describes how the area outside of the gradient region will be rendered. The
    ///                   gradient region is defined by the linear-gradient brush or radial-gradient brush that inherits this
    ///                   interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>spreadMethod</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetSpreadMethod(XPS_SPREAD_METHOD* spreadMethod);
    ///Sets the XPS_SPREAD_METHOD value, which describes how the area outside of the gradient region is to be rendered.
    ///The gradient region is defined by the start and end points of the gradient.
    ///Params:
    ///    spreadMethod = The XPS_SPREAD_METHOD value that describes how the area outside of the gradient region is to be rendered. The
    ///                   gradient region is defined by the linear-gradient brush or radial-gradient brush that inherits this
    ///                   interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>spreadMethod</i> parameter was not a
    ///    valid XPS_SPREAD_METHOD value. </td> </tr> </table>
    ///    
    HRESULT SetSpreadMethod(XPS_SPREAD_METHOD spreadMethod);
    ///Gets the gamma function to be used for color interpolation.
    ///Params:
    ///    colorInterpolationMode = The XPS_COLOR_INTERPOLATION value that describes the gamma function to be used for color interpolation.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>colorInterpolationMode</i> is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetColorInterpolationMode(XPS_COLOR_INTERPOLATION* colorInterpolationMode);
    ///Sets the XPS_COLOR_INTERPOLATION value, which describes the gamma function to be used for color interpolation.
    ///Params:
    ///    colorInterpolationMode = The XPS_COLOR_INTERPOLATION value, which describes the gamma function to be used for color interpolation.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetColorInterpolationMode(XPS_COLOR_INTERPOLATION colorInterpolationMode);
}

///Specifies a linear gradient, which is the color gradient along a vector.
@GUID("005E279F-C30D-40FF-93EC-1950D3C528DB")
interface IXpsOMLinearGradientBrush : IXpsOMGradientBrush
{
    ///Gets the start point of the gradient.
    ///Params:
    ///    startPoint = The x and y coordinates of the start point.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>startPoint</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetStartPoint(XPS_POINT* startPoint);
    ///Sets the start point of the gradient.
    ///Params:
    ///    startPoint = The x and y coordinates of the start point.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The point described by <i>startPoint</i> was
    ///    not valid. The XPS_POINT structure must contain valid and finite floating-point values. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>startPoint</i> is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT SetStartPoint(const(XPS_POINT)* startPoint);
    ///Gets the end point of the gradient.
    ///Params:
    ///    endPoint = The x and y coordinates of the end point.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>endPoint</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetEndPoint(XPS_POINT* endPoint);
    ///Sets the end point of the gradient.
    ///Params:
    ///    endPoint = The x and y coordinates of the end point.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The point described by <i>endPoint</i> was not
    ///    valid. The XPS_POINT structure must contain valid and finite floating-point values. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>endPoint</i> is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT SetEndPoint(const(XPS_POINT)* endPoint);
    ///Makes a deep copy of the interface.
    ///Params:
    ///    linearGradientBrush = A pointer to the copy of the interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory to perform this operation.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%">
    ///    <i>linearGradientBrush</i> is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT Clone(IXpsOMLinearGradientBrush* linearGradientBrush);
}

///Specifies a radial gradient.
@GUID("75F207E5-08BF-413C-96B1-B82B4064176B")
interface IXpsOMRadialGradientBrush : IXpsOMGradientBrush
{
    ///Gets the center point of the radial gradient region ellipse.
    ///Params:
    ///    center = The x and y coordinates of the center point of the radial gradient region ellipse.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>center</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetCenter(XPS_POINT* center);
    ///Sets the center point of the radial gradient region ellipse.
    ///Params:
    ///    center = The x and y coordinates to be set for the center point of the radial gradient ellipse.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The point described by <i>center</i> is not
    ///    valid. The XPS_POINT structure must contain valid and finite floating-point values. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>center</i> is <b>NULL</b>. </td>
    ///    </tr> </table>
    ///    
    HRESULT SetCenter(const(XPS_POINT)* center);
    ///Gets the sizes of the radii that define the ellipse of the radial gradient region.
    ///Params:
    ///    radiiSizes = The XPS_SIZE structure that receives the sizes of the radii. <table> <tr> <th>Field</th> <th>Meaning</th>
    ///                 </tr> <tr> <td> <b>width</b> </td> <td> Size of the radius along the x-axis. </td> </tr> <tr> <td>
    ///                 <b>height</b> </td> <td> Size of the radius along the y-axis. </td> </tr> </table> Size is described in XPS
    ///                 units. There are 96 XPS units per inch. For example, a 1" radius is 96 XPS units.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>radiiSizes</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetRadiiSizes(XPS_SIZE* radiiSizes);
    ///Sets the sizes of the radii that define ellipse of the radial gradient region.
    ///Params:
    ///    radiiSizes = The XPS_SIZE structure that receives the sizes of the radii. <table> <tr> <th>Field</th> <th>Meaning</th>
    ///                 </tr> <tr> <td> <b>width</b> </td> <td> Size of the radius along the x-axis. </td> </tr> <tr> <td>
    ///                 <b>height</b> </td> <td> Size of the radius along the y-axis. </td> </tr> </table> Size is described in XPS
    ///                 units. There are 96 XPS units per inch. For example, a 1" radius is 96 XPS units.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the sizes described by
    ///    <i>radiiSizes</i> is not valid. The XPS_SIZE structure must contain valid, finite, and non-negative
    ///    floating-point values. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> <i>radiiSizes</i> is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT SetRadiiSizes(const(XPS_SIZE)* radiiSizes);
    ///Gets the origin point of the radial gradient.
    ///Params:
    ///    origin = The x and y coordinates of the radial gradient's origin point.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>origin</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetGradientOrigin(XPS_POINT* origin);
    ///Sets the origin point of the radial gradient.
    ///Params:
    ///    origin = The x and y coordinates to be set for the origin point of the radial gradient.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The point described by <i>origin</i> was not
    ///    valid. The XPS_POINT structure must contain valid and finite floating-point values. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>origin</i> is <b>NULL</b>. </td>
    ///    </tr> </table>
    ///    
    HRESULT SetGradientOrigin(const(XPS_POINT)* origin);
    ///Makes a deep copy of the interface.
    ///Params:
    ///    radialGradientBrush = A pointer to the copy of the interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory to perform this operation.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%">
    ///    <i>radialGradientBrush</i> is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT Clone(IXpsOMRadialGradientBrush* radialGradientBrush);
}

///Used as the base interface for the resource interfaces of the XPS object model.
@GUID("DA2AC0A2-73A2-4975-AD14-74097C3FF3A5")
interface IXpsOMResource : IXpsOMPart
{
}

///Provides access to all shared, part-based resources of the XPS document.
@GUID("F4CF7729-4864-4275-99B3-A8717163ECAF")
interface IXpsOMPartResources : IUnknown
{
    ///Gets the IXpsOMFontResourceCollection interface that contains the fonts that are used in the XPS document.
    ///Params:
    ///    fontResources = A pointer to the IXpsOMFontResourceCollection interface that contains the fonts that are used in the XPS
    ///                    document.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>fontResources</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetFontResources(IXpsOMFontResourceCollection* fontResources);
    ///Gets the IXpsOMImageResourceCollection interface that contains the images that are used in the XPS document.
    ///Params:
    ///    imageResources = A pointer to the IXpsOMImageResourceCollection interface that contains the images that are used in the XPS
    ///                     document.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>imageResources</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetImageResources(IXpsOMImageResourceCollection* imageResources);
    ///Gets the IXpsOMColorProfileResourceCollection interface that contains the color profiles that are used in the XPS
    ///document.
    ///Params:
    ///    colorProfileResources = A pointer to the IXpsOMColorProfileResourceCollection interface that contains the color profiles that are
    ///                            used in the XPS document.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>colorProfileResources</i> is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetColorProfileResources(IXpsOMColorProfileResourceCollection* colorProfileResources);
    ///Gets the IXpsOMRemoteDictionaryResourceCollection interface that contains the remote resource dictionaries that
    ///are used in the XPS document.
    ///Params:
    ///    dictionaryResources = A pointer to the IXpsOMRemoteDictionaryResourceCollection interface that contains the remote resource
    ///                          dictionaries that are used in the XPS document.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>dictionaryResources</i> is <b>NULL</b>. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetRemoteDictionaryResources(IXpsOMRemoteDictionaryResourceCollection* dictionaryResources);
}

///The dictionary is used by an XPS package to share resources.
@GUID("897C86B8-8EAF-4AE3-BDDE-56419FCF4236")
interface IXpsOMDictionary : IUnknown
{
    ///Gets a pointer to the interface that contains the dictionary.
    ///Params:
    ///    owner = The <b>IUnknown</b> interface of the interface that contains the dictionary.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetOwner(IUnknown* owner);
    ///Gets the number of entries in the dictionary.
    ///Params:
    ///    count = The number of entries in the dictionary.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetCount(uint* count);
    ///Gets the IXpsOMShareable interface pointer and the key name string of the entry at a specified index in the
    ///dictionary.
    ///Params:
    ///    index = The zero-based index of the dictionary entry that is to be obtained.
    ///    key = The key string that is found at the location specified by <i>index</i>.
    ///    entry = The IXpsOMShareable interface pointer that is found at the location specified by <i>index</i>.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetAt(uint index, ushort** key, IXpsOMShareable* entry);
    ///Gets the IXpsOMShareable interface pointer of the entry that contains the specified key.
    ///Params:
    ///    key = The entry's key to be found in the dictionary.
    ///    beforeEntry = The IXpsOMShareable interface pointer to the last entry in the dictionary which is to be searched for
    ///                  <i>key</i>. If <i>beforeEntry</i> is <b>NULL</b> or is an interface pointer to an entry that is not in the
    ///                  dictionary, the entire dictionary will be searched.
    ///    entry = The interface pointer to the dictionary entry whose key matches <i>key</i>.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetByKey(const(wchar)* key, IXpsOMShareable beforeEntry, IXpsOMShareable* entry);
    ///Gets the index of an IXpsOMShareable interface from the dictionary.
    ///Params:
    ///    entry = The IXpsOMShareable interface pointer to be found in the dictionary.
    ///    index = The zero-based index of <i>entry</i> in the dictionary.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> The object referenced by <i>entry</i> is not
    ///    in the dictionary. </td> </tr> </table>
    ///    
    HRESULT GetIndex(IXpsOMShareable entry, uint* index);
    ///Appends an IXpsOMShareable interface along with its <i>key</i> to the end of the dictionary.
    ///Params:
    ///    key = The key to be used for this entry. The string referenced by <i>key</i> must be unique in the dictionary.
    ///    entry = A pointer to the IXpsOMShareable interface that is to be appended to the dictionary. A dictionary cannot
    ///            contain duplicate interface pointers. This parameter must contain an interface pointer that is not already in
    ///            the dictionary.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>XPS_E_NO_CUSTOM_OBJECTS</b></dt> </dl> </td> <td width="60%"> <i>entry</i> does not point to a
    ///    recognized interface implementation. Custom implementation of XPS Document API interfaces is not supported.
    ///    </td> </tr> </table>
    ///    
    HRESULT Append(const(wchar)* key, IXpsOMShareable entry);
    ///Inserts an IXpsOMShareable interface at a specified location in the dictionary and sets the key to identify the
    ///interface.
    ///Params:
    ///    index = The zero-based index in the dictionary where the IXpsOMShareable interface is to be inserted.
    ///    key = The key to be used to identify the IXpsOMShareable interface in the dictionary. The string referenced by
    ///          <i>key</i> must be unique in the dictionary.
    ///    entry = The IXpsOMShareable interface pointer to be inserted at the location specified by <i>index</i>. A dictionary
    ///            cannot contain duplicate interface pointers. This parameter must contain an interface pointer that is not
    ///            already in the dictionary.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>XPS_E_NO_CUSTOM_OBJECTS</b></dt> </dl> </td> <td width="60%"> <i>entry</i> does not point to a
    ///    recognized interface implementation. Custom implementation of XPS Document API interfaces is not supported.
    ///    </td> </tr> </table>
    ///    
    HRESULT InsertAt(uint index, const(wchar)* key, IXpsOMShareable entry);
    ///Removes and releases the entry from a specified location in the dictionary.
    ///Params:
    ///    index = The zero-based index in the dictionary from which an entry is to be removed and released.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT RemoveAt(uint index);
    ///Replaces the entry at a specified location in the dictionary.
    ///Params:
    ///    index = The zero-based index in the dictionary in which an entry is to be replaced.
    ///    key = The key to be used for the new entry. The string referenced by <i>key</i> must be unique in the dictionary.
    ///    entry = The IXpsOMShareable interface pointer that will replace current contents at the location specified by
    ///            <i>index</i>. A dictionary cannot contain duplicate interface pointers. This parameter must contain an
    ///            interface pointer that is not already in the dictionary.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>XPS_E_NO_CUSTOM_OBJECTS</b></dt> </dl> </td> <td width="60%"> <i>entry</i> does not point to a
    ///    recognized interface implementation. Custom implementation of XPS Document API interfaces is not supported.
    ///    </td> </tr> </table>
    ///    
    HRESULT SetAt(uint index, const(wchar)* key, IXpsOMShareable entry);
    ///Makes a deep copy of the interface.
    ///Params:
    ///    dictionary = A pointer to the copy of the interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory to perform this operation.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%">
    ///    <i>dictionary</i> is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT Clone(IXpsOMDictionary* dictionary);
}

///Provides an IStream interface to a font resource.
@GUID("A8C45708-47D9-4AF4-8D20-33B48C9B8485")
interface IXpsOMFontResource : IXpsOMResource
{
    ///Gets a new, read-only copy of the stream that is associated with this resource.
    ///Params:
    ///    readerStream = A new, read-only copy of the stream that is associated with this resource.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code. For information
    ///    about XPS document API return values, see XPS Document Errors. This method calls the Packaging API. For
    ///    information about the Packaging API return values, see Packaging Errors.
    ///    
    HRESULT GetStream(IStream* readerStream);
    ///Sets the read-only stream to be associated with this resource.
    ///Params:
    ///    sourceStream = The read-only stream to be associated with this resource.
    ///    embeddingOption = The XPS_FONT_EMBEDDING value that describes how the resource is to be obfuscated. <table> <tr> <th>Value</th>
    ///                      <th>Meaning</th> </tr> <tr> <td width="40%"><a id="XPS_FONT_EMBEDDING_NORMAL"></a><a
    ///                      id="xps_font_embedding_normal"></a><dl> <dt><b>XPS_FONT_EMBEDDING_NORMAL</b></dt> </dl> </td> <td
    ///                      width="60%"> Font resource is neither obfuscated nor restricted. </td> </tr> <tr> <td width="40%"><a
    ///                      id="XPS_FONT_EMBEDDING_OBFUSCATED"></a><a id="xps_font_embedding_obfuscated"></a><dl>
    ///                      <dt><b>XPS_FONT_EMBEDDING_OBFUSCATED</b></dt> </dl> </td> <td width="60%"> Font resource is obfuscated but
    ///                      not restricted. </td> </tr> <tr> <td width="40%"><a id="XPS_FONT_EMBEDDING_RESTRICTED"></a><a
    ///                      id="xps_font_embedding_restricted"></a><dl> <dt><b>XPS_FONT_EMBEDDING_RESTRICTED</b></dt> </dl> </td> <td
    ///                      width="60%"> Font resource is both obfuscated and restricted. </td> </tr> </table>
    ///    partName = The part name to be assigned to this resource.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetContent(IStream sourceStream, XPS_FONT_EMBEDDING embeddingOption, IOpcPartUri partName);
    ///Gets the embedding option that will be applied when the resource is serialized.
    ///Params:
    ///    embeddingOption = The stream's embedding option. The XPS_FONT_EMBEDDING value describes how the resource is obfuscated. The
    ///                      following possible values are returned in this parameter: <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
    ///                      <tr> <td width="40%"><a id="XPS_FONT_EMBEDDING_NORMAL"></a><a id="xps_font_embedding_normal"></a><dl>
    ///                      <dt><b>XPS_FONT_EMBEDDING_NORMAL</b></dt> </dl> </td> <td width="60%"> Font resource is neither obfuscated
    ///                      nor restricted. </td> </tr> <tr> <td width="40%"><a id="XPS_FONT_EMBEDDING_OBFUSCATED"></a><a
    ///                      id="xps_font_embedding_obfuscated"></a><dl> <dt><b>XPS_FONT_EMBEDDING_OBFUSCATED</b></dt> </dl> </td> <td
    ///                      width="60%"> Font resource is obfuscated but not restricted. </td> </tr> <tr> <td width="40%"><a
    ///                      id="XPS_FONT_EMBEDDING_RESTRICTED"></a><a id="xps_font_embedding_restricted"></a><dl>
    ///                      <dt><b>XPS_FONT_EMBEDDING_RESTRICTED</b></dt> </dl> </td> <td width="60%"> Font resource is both obfuscated
    ///                      and restricted. </td> </tr> </table>
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetEmbeddingOption(XPS_FONT_EMBEDDING* embeddingOption);
}

///A collection of IXpsOMFontResource interface pointers.
@GUID("70B4A6BB-88D4-4FA8-AAF9-6D9C596FDBAD")
interface IXpsOMFontResourceCollection : IUnknown
{
    ///Gets the number of IXpsOMFontResource interface pointers in the collection.
    ///Params:
    ///    count = The number of IXpsOMFontResource interface pointers in the collection.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetCount(uint* count);
    ///Gets an IXpsOMFontResource interface pointer from a specified location in the collection.
    ///Params:
    ///    index = The zero-based index of the IXpsOMFontResource interface pointer to be obtained.
    ///    value = The IXpsOMFontResource interface pointer at the location specified by <i>index</i>.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetAt(uint index, IXpsOMFontResource* value);
    ///Replaces an IXpsOMFontResource interface pointer at a specified location in the collection.
    ///Params:
    ///    index = The zero-based index in the collection where an IXpsOMFontResource interface pointer is to be replaced.
    ///    value = The IXpsOMFontResource interface pointer that will replace current contents at the location specified by
    ///            <i>index</i>.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetAt(uint index, IXpsOMFontResource value);
    ///Inserts an IXpsOMFontResource interface pointer at a specified location in the collection.
    ///Params:
    ///    index = The zero-based index in the collection where the interface pointer that is passed in <i>value</i> is to be
    ///            inserted.
    ///    value = The IXpsOMFontResource interface pointer that is to be inserted at the location specified by <i>index</i>.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT InsertAt(uint index, IXpsOMFontResource value);
    ///Appends an IXpsOMFontResource interface to the end of the collection.
    ///Params:
    ///    value = A pointer to the IXpsOMFontResource interface that is to be appended to the collection.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT Append(IXpsOMFontResource value);
    ///Removes and releases an IXpsOMFontResource interface pointer from a specified location in the collection.
    ///Params:
    ///    index = The zero-based index in the collection from which an IXpsOMFontResource interface pointer is to be removed
    ///            and released.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT RemoveAt(uint index);
    ///Gets an IXpsOMFontResource interface pointer from the collection by matching the interface's part name.
    ///Params:
    ///    partName = The part name of the IXpsOMFontResource interface to be found in the collection.
    ///    part = A pointer to the IXpsOMFontResource interface that has the matching part name. If a matching interface is not
    ///           found in the collection, a <b>NULL</b> pointer is returned.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetByPartName(IOpcPartUri partName, IXpsOMFontResource* part);
}

///Provides an IStream interface to an image resource.
@GUID("3DB8417D-AE50-485E-9A44-D7758F78A23F")
interface IXpsOMImageResource : IXpsOMResource
{
    ///Gets a new, read-only copy of the stream that is associated with this resource.
    ///Params:
    ///    readerStream = A new, read-only copy of the stream that is associated with this resource.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code. For information
    ///    about XPS document API return values, see XPS Document Errors. This method calls the Packaging API. For
    ///    information about the Packaging API return values, see Packaging Errors.
    ///    
    HRESULT GetStream(IStream* readerStream);
    ///Sets the read-only stream to be associated with this resource.
    ///Params:
    ///    sourceStream = The read-only stream to be associated with this resource.
    ///    imageType = The XPS_IMAGE_TYPE value that describes the type of image in the stream.
    ///    partName = The part name to be assigned to this resource.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetContent(IStream sourceStream, XPS_IMAGE_TYPE imageType, IOpcPartUri partName);
    ///Gets the type of image resource.
    ///Params:
    ///    imageType = The XPS_IMAGE_TYPE value that describes the image type in the stream.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetImageType(XPS_IMAGE_TYPE* imageType);
}

///A collection of IXpsOMImageResource interface pointers.
@GUID("7A4A1A71-9CDE-4B71-B33F-62DE843EABFE")
interface IXpsOMImageResourceCollection : IUnknown
{
    ///Gets the number of IXpsOMImageResource interface pointers in the collection.
    ///Params:
    ///    count = The number of IXpsOMImageResource interface pointers in the collection.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetCount(uint* count);
    ///Gets an IXpsOMImageResource interface pointer from a specified location in the collection.
    ///Params:
    ///    index = The zero-based index of the IXpsOMImageResource interface pointer to be obtained.
    ///    object = The IXpsOMImageResource interface pointer at the location specified by <i>index</i>.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetAt(uint index, IXpsOMImageResource* object);
    ///Inserts an IXpsOMImageResource interface pointer at a specified location in the collection.
    ///Params:
    ///    index = The zero-based index in the collection where the interface pointer that is passed in <i>object</i> is to be
    ///            inserted.
    ///    object = The IXpsOMImageResource interface pointer that will be inserted at the location specified by <i>index</i>.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT InsertAt(uint index, IXpsOMImageResource object);
    ///Removes and releases an IXpsOMImageResource interface pointer from a specified location in the collection.
    ///Params:
    ///    index = The zero-based index in the collection from which an IXpsOMImageResource interface pointer is to be removed
    ///            and released.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT RemoveAt(uint index);
    ///Replaces an IXpsOMImageResource interface pointer at a specified location in the collection.
    ///Params:
    ///    index = The zero-based index in the collection where an IXpsOMImageResource interface pointer is to be replaced.
    ///    object = The IXpsOMImageResource interface pointer that will replace current contents at the location specified by
    ///             <i>index</i>.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetAt(uint index, IXpsOMImageResource object);
    ///Appends an IXpsOMImageResource interface to the end of the collection.
    ///Params:
    ///    object = A pointer to the IXpsOMImageResource interface that is to be appended to the collection.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT Append(IXpsOMImageResource object);
    ///Gets an IXpsOMImageResource interface pointer from the collection by matching the interface's part name.
    ///Params:
    ///    partName = The part name of the interface that is to be found in the collection.
    ///    part = The IXpsOMImageResource interface whose part name matches <i>partName</i>. If a matching interface is not
    ///           found in the collection, a <b>NULL</b> pointer is returned.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetByPartName(IOpcPartUri partName, IXpsOMImageResource* part);
}

///Provides an IStream interface to a color profile resource.
@GUID("67BD7D69-1EEF-4BB1-B5E7-6F4F87BE8ABE")
interface IXpsOMColorProfileResource : IXpsOMResource
{
    ///Gets a new, read-only copy of the stream that is associated with this resource.
    ///Params:
    ///    stream = A new, read-only copy of the stream that is associated with this resource.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code. For information
    ///    about XPS document API return values, see XPS Document Errors. This method calls the Packaging API. For
    ///    information about the Packaging API return values, see Packaging Errors.
    ///    
    HRESULT GetStream(IStream* stream);
    ///Sets the read-only stream to be associated with this resource.
    ///Params:
    ///    sourceStream = The read-only stream to be associated with this resource.
    ///    partName = The part name to be assigned to this resource.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetContent(IStream sourceStream, IOpcPartUri partName);
}

///A collection of IXpsOMColorProfileResource interface pointers.
@GUID("12759630-5FBA-4283-8F7D-CCA849809EDB")
interface IXpsOMColorProfileResourceCollection : IUnknown
{
    ///Gets the number of IXpsOMColorProfileResource interface pointers in the collection.
    ///Params:
    ///    count = The number of IXpsOMColorProfileResource interface pointers in the collection.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetCount(uint* count);
    ///Gets an IXpsOMColorProfileResource interface pointer from a specified location in the collection.
    ///Params:
    ///    index = The zero-based index of the IXpsOMColorProfileResource interface pointer to be obtained.
    ///    object = The IXpsOMColorProfileResource interface pointer at the location specified by <i>index</i>.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetAt(uint index, IXpsOMColorProfileResource* object);
    ///Inserts an IXpsOMColorProfileResource interface pointer at a specified location in the collection.
    ///Params:
    ///    index = The zero-based index in the collection where the interface pointer that is passed in <i>object</i> is to be
    ///            inserted.
    ///    object = The IXpsOMColorProfileResource interface pointer that is to be inserted in the location specified by
    ///             <i>index</i>.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT InsertAt(uint index, IXpsOMColorProfileResource object);
    ///Removes and releases an IXpsOMColorProfileResource interface pointer from a specified location in the collection.
    ///Params:
    ///    index = The zero-based index in the collection from which an IXpsOMColorProfileResource interface pointer is to be
    ///            removed and released.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT RemoveAt(uint index);
    ///Replaces an IXpsOMColorProfileResource interface pointer at a specified location in the collection.
    ///Params:
    ///    index = The zero-based index in the collection where an IXpsOMColorProfileResource interface pointer is to be
    ///            replaced.
    ///    object = The IXpsOMColorProfileResource interface pointer that will replace current contents at the location specified
    ///             by <i>index</i>.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetAt(uint index, IXpsOMColorProfileResource object);
    ///Appends an IXpsOMColorProfileResource interface pointer to the end of the collection.
    ///Params:
    ///    object = A pointer to the IXpsOMColorProfileResource interface that is to be appended to the collection.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT Append(IXpsOMColorProfileResource object);
    ///Gets an IXpsOMColorProfileResource interface pointer from the collection by matching the interface's part name.
    ///Params:
    ///    partName = The part name of the IXpsOMColorProfileResource interface to be found in the collection.
    ///    part = A pointer to the IXpsOMColorProfileResource interface whose part name matches <i>partName</i>. If a matching
    ///           interface is not found in the collection, a <b>NULL</b> pointer is returned.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetByPartName(IOpcPartUri partName, IXpsOMColorProfileResource* part);
}

///Provides an IStream interface to a <b>PrintTicket</b> resource.
@GUID("E7FF32D2-34AA-499B-BBE9-9CD4EE6C59F7")
interface IXpsOMPrintTicketResource : IXpsOMResource
{
    ///Gets a new, read-only copy of the stream that is associated with this resource.
    ///Params:
    ///    stream = A new, read-only copy of the stream that is associated with this resource.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code. For information
    ///    about XPS document API return values, see XPS Document Errors. This method calls the Packaging API. For
    ///    information about the Packaging API return values, see Packaging Errors.
    ///    
    HRESULT GetStream(IStream* stream);
    ///Sets the read-only stream to be associated with this resource.
    ///Params:
    ///    sourceStream = The read-only stream to be associated with this resource.
    ///    partName = The part name to be assigned to this resource.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetContent(IStream sourceStream, IOpcPartUri partName);
}

///Provides an interface that enables pages in an XPS package to share resources.
@GUID("C9BD7CD4-E16A-4BF8-8C84-C950AF7A3061")
interface IXpsOMRemoteDictionaryResource : IXpsOMResource
{
    ///Gets a pointer to the IXpsOMDictionary interface of the remote dictionary that is associated with this resource.
    ///Params:
    ///    dictionary = A pointer to the IXpsOMDictionary interface of the dictionary that is associated with this resource.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>dictionary</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetDictionary(IXpsOMDictionary* dictionary);
    ///Sets a pointer to the IXpsOMDictionary interface of the remote dictionary that is to be associated with this
    ///resource.
    ///Params:
    ///    dictionary = The IXpsOMDictionary interface of the dictionary that is to be associated with this resource.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>XPS_E_NO_CUSTOM_OBJECTS</b></dt> </dl> </td> <td width="60%"> <i>dictionary</i> does not point to
    ///    a recognized interface implementation. Custom implementation of XPS Document API interfaces is not supported.
    ///    </td> </tr> </table>
    ///    
    HRESULT SetDictionary(IXpsOMDictionary dictionary);
}

///A collection of IXpsOMRemoteDictionaryResource interface pointers.
@GUID("5C38DB61-7FEC-464A-87BD-41E3BEF018BE")
interface IXpsOMRemoteDictionaryResourceCollection : IUnknown
{
    ///Gets the number of IXpsOMRemoteDictionaryResource interface pointers in the collection.
    ///Params:
    ///    count = The number of IXpsOMRemoteDictionaryResource interface pointers in the collection.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetCount(uint* count);
    ///Gets an IXpsOMRemoteDictionaryResource interface pointer from a specified location in the collection.
    ///Params:
    ///    index = The zero-based index of the IXpsOMRemoteDictionaryResource interface pointer to be obtained.
    ///    object = The IXpsOMRemoteDictionaryResource interface pointer at the location specified by <i>index</i>.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetAt(uint index, IXpsOMRemoteDictionaryResource* object);
    ///Inserts an IXpsOMRemoteDictionaryResource interface pointer at a specified location in the collection.
    ///Params:
    ///    index = The zero-based index in the collection where the interface pointer that is passed in <i>object</i> is to be
    ///            inserted.
    ///    object = The IXpsOMRemoteDictionaryResource interface pointer that is to be inserted at the location specified by
    ///             <i>index</i>.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT InsertAt(uint index, IXpsOMRemoteDictionaryResource object);
    ///Removes and releases an IXpsOMRemoteDictionaryResource interface pointer from a specified location in the
    ///collection.
    ///Params:
    ///    index = The zero-based index in the collection from which an IXpsOMRemoteDictionaryResource interface pointer is to
    ///            be removed and released.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT RemoveAt(uint index);
    ///Replaces an IXpsOMRemoteDictionaryResource interface pointer at a specified location in the collection.
    ///Params:
    ///    index = The zero-based index in the collection where an IXpsOMRemoteDictionaryResource interface pointer is to be
    ///            replaced.
    ///    object = The IXpsOMRemoteDictionaryResource interface pointer that will replace current contents at the location
    ///             specified by <i>index</i>.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetAt(uint index, IXpsOMRemoteDictionaryResource object);
    ///Appends an IXpsOMRemoteDictionaryResource interface to the end of the collection.
    ///Params:
    ///    object = A pointer to the IXpsOMRemoteDictionaryResource interface that is to be appended to the collection.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT Append(IXpsOMRemoteDictionaryResource object);
    ///Gets an IXpsOMRemoteDictionaryResource interface pointer from the collection by matching the interface's part
    ///name.
    ///Params:
    ///    partName = The part name of the IXpsOMRemoteDictionaryResource interface to be found in the collection.
    ///    remoteDictionaryResource = A pointer to the IXpsOMRemoteDictionaryResource interface whose part name matches <i>partName</i>. If a
    ///                               matching interface is not found in the collection, a <b>NULL</b> pointer is returned.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetByPartName(IOpcPartUri partName, IXpsOMRemoteDictionaryResource* remoteDictionaryResource);
}

///A collection of IXpsOMSignatureBlockResource interface pointers.
@GUID("AB8F5D8E-351B-4D33-AAED-FA56F0022931")
interface IXpsOMSignatureBlockResourceCollection : IUnknown
{
    ///Gets the number of IXpsOMSignatureBlockResource interface pointers in the collection.
    ///Params:
    ///    count = The number of IXpsOMSignatureBlockResource interface pointers in the collection.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetCount(uint* count);
    ///Gets an IXpsOMSignatureBlockResource interface pointer from a specified location in the collection.
    ///Params:
    ///    index = The zero-based index of the IXpsOMSignatureBlockResource interface pointer to be obtained.
    ///    signatureBlockResource = The IXpsOMSignatureBlockResource interface pointer at the location specified by <i>index</i>.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetAt(uint index, IXpsOMSignatureBlockResource* signatureBlockResource);
    ///Inserts an IXpsOMSignatureBlockResource interface pointer at a specified location in the collection.
    ///Params:
    ///    index = The zero-based index in the collection where the interface pointer that is passed in
    ///            <i>signatureBlockResource</i> is to be inserted.
    ///    signatureBlockResource = The IXpsOMSignatureBlockResource interface pointer that is to be inserted at the location specified by
    ///                             <i>index</i>.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT InsertAt(uint index, IXpsOMSignatureBlockResource signatureBlockResource);
    ///Removes and releases an IXpsOMSignatureBlockResource interface pointer from a specified location in the
    ///collection.
    ///Params:
    ///    index = The zero-based index in the collection from which an IXpsOMSignatureBlockResource interface pointer is to be
    ///            removed and released.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT RemoveAt(uint index);
    ///Replaces an IXpsOMSignatureBlockResource interface pointer at a specified location in the collection.
    ///Params:
    ///    index = The zero-based index in the collection where an IXpsOMSignatureBlockResource interface pointer is to be
    ///            replaced.
    ///    signatureBlockResource = The IXpsOMSignatureBlockResource interface pointer that will replace current contents at the location
    ///                             specified by <i>index</i>.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetAt(uint index, IXpsOMSignatureBlockResource signatureBlockResource);
    ///Appends an IXpsOMSignatureBlockResource interface to the end of the collection.
    ///Params:
    ///    signatureBlockResource = A pointer to the IXpsOMSignatureBlockResource interface that is to be appended to the collection.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT Append(IXpsOMSignatureBlockResource signatureBlockResource);
    ///Gets an IXpsOMSignatureBlockResource interface pointer from the collection by matching the interface's part name.
    ///Params:
    ///    partName = The part name of the IXpsOMSignatureBlockResource interface to be found in the collection.
    ///    signatureBlockResource = A pointer to the IXpsOMSignatureBlockResource interface whose part name matches <i>partName</i>. If a
    ///                             matching interface is not found in the collection, a <b>NULL</b> pointer is returned.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetByPartName(IOpcPartUri partName, IXpsOMSignatureBlockResource* signatureBlockResource);
}

///Provides access to the XML content of the resource stream of the DocumentStructure part.The
///<b>IXpsOMDocumentStructureResource</b> interface enables a program to read and replace the XML content of the
///DocumentStructure part.
@GUID("85FEBC8A-6B63-48A9-AF07-7064E4ECFF30")
interface IXpsOMDocumentStructureResource : IXpsOMResource
{
    ///Gets a pointer to the IXpsOMDocument interface that contains the resource.
    ///Params:
    ///    owner = A pointer to the IXpsOMDocument interface that contains the resource. If the resource is not part of a
    ///            document, a <b>NULL</b> pointer is returned.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetOwner(IXpsOMDocument* owner);
    ///Gets a new, read-only copy of the stream that is associated with this resource.
    ///Params:
    ///    stream = A new, read-only copy of the stream that is associated with this resource.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code. For information
    ///    about XPS document API return values, see XPS Document Errors. This method calls the Packaging API. For
    ///    information about the Packaging API return values, see Packaging Errors.
    ///    
    HRESULT GetStream(IStream* stream);
    ///Sets the read-only stream to be associated with this resource.
    ///Params:
    ///    sourceStream = The read-only stream to be associated with this resource.
    ///    partName = The part name to be assigned to this resource.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetContent(IStream sourceStream, IOpcPartUri partName);
}

///Provides access to the content of the resource stream of a page's StoryFragments part.
@GUID("C2B3CA09-0473-4282-87AE-1780863223F0")
interface IXpsOMStoryFragmentsResource : IXpsOMResource
{
    ///Gets a pointer to the IXpsOMPage interface that contains this resource.
    ///Params:
    ///    owner = A pointer to the IXpsOMPage interface that contains this resource. If the resource is not part of a page, a
    ///            <b>NULL</b> pointer is returned.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetOwner(IXpsOMPageReference* owner);
    ///Gets a new, read-only copy of the stream that is associated with this resource.
    ///Params:
    ///    stream = A new, read-only copy of the stream that is associated with this resource.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code. For information
    ///    about XPS document API return values, see XPS Document Errors. This method calls the Packaging API. For
    ///    information about the Packaging API return values, see Packaging Errors.
    ///    
    HRESULT GetStream(IStream* stream);
    ///Sets the read-only stream to be associated with this resource.
    ///Params:
    ///    sourceStream = The read-only stream to be associated with this resource.
    ///    partName = The part name to be assigned to this resource.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetContent(IStream sourceStream, IOpcPartUri partName);
}

///Provides an IStream interface to a signature block resource.
@GUID("4776AD35-2E04-4357-8743-EBF6C171A905")
interface IXpsOMSignatureBlockResource : IXpsOMResource
{
    ///Gets a pointer to the IXpsOMDocument interface that contains the resource.
    ///Params:
    ///    owner = A pointer to the IXpsOMDocument interface that contains the resource. If the resource is not part of a
    ///            document, a <b>NULL</b> pointer is returned.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetOwner(IXpsOMDocument* owner);
    ///Gets a new, read-only copy of the stream that is associated with this resource.
    ///Params:
    ///    stream = A new, read-only copy of the stream that is associated with this resource.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code. For information
    ///    about XPS document API return values, see XPS Document Errors. This method calls the Packaging API. For
    ///    information about the Packaging API return values, see Packaging Errors.
    ///    
    HRESULT GetStream(IStream* stream);
    ///Sets the read-only stream to be associated with this resource.
    ///Params:
    ///    sourceStream = The read-only stream to be associated with this resource.
    ///    partName = The part name to be assigned to this resource.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetContent(IStream sourceStream, IOpcPartUri partName);
}

///A collection of IXpsOMVisual interface pointers.
@GUID("94D8ABDE-AB91-46A8-82B7-F5B05EF01A96")
interface IXpsOMVisualCollection : IUnknown
{
    ///Gets the number of IXpsOMVisual interface pointers in the collection.
    ///Params:
    ///    count = The number of IXpsOMVisual interface pointers in the collection.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetCount(uint* count);
    ///Gets an IXpsOMVisual interface pointer from a specified location in the collection.
    ///Params:
    ///    index = The zero-based index of the IXpsOMVisual interface pointer to be obtained.
    ///    object = The IXpsOMVisual interface pointer at the location specified by <i>index</i>.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetAt(uint index, IXpsOMVisual* object);
    ///Inserts an IXpsOMVisual interface pointer at a specified location in the collection.
    ///Params:
    ///    index = The zero-based index of the collection where the interface pointer that is passed in <i>object</i> is to be
    ///            inserted.
    ///    object = The IXpsOMVisual interface pointer that is to be inserted at the location specified by <i>index</i>.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT InsertAt(uint index, IXpsOMVisual object);
    ///Removes and releases an IXpsOMVisual interface pointer from a specified location in the collection.
    ///Params:
    ///    index = The zero-based index in the collection from which an IXpsOMVisual interface pointer is to be removed and
    ///            released.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT RemoveAt(uint index);
    ///Replaces an IXpsOMVisual interface pointer at a specified location in the collection.
    ///Params:
    ///    index = The zero-based index in the collection where an IXpsOMVisual interface pointer is to be replaced.
    ///    object = The IXpsOMVisual interface pointer that will replace current contents at the location specified by
    ///             <i>index</i>.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetAt(uint index, IXpsOMVisual object);
    ///Appends an IXpsOMVisual interface to the end of the collection.
    ///Params:
    ///    object = A pointer to the IXpsOMVisual interface that is to be appended to the collection.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT Append(IXpsOMVisual object);
}

///A group of visual elements and related properties.
@GUID("221D1452-331E-47C6-87E9-6CCEFB9B5BA3")
interface IXpsOMCanvas : IXpsOMVisual
{
    ///Gets a pointer to an IXpsOMVisualCollection interface that contains a collection of the visual objects in the
    ///canvas.
    ///Params:
    ///    visuals = The collection of the visual objects in the canvas. If no visual objects are attached to the canvas, an empty
    ///              collection is returned.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>visuals</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetVisuals(IXpsOMVisualCollection* visuals);
    ///Gets a Boolean value that determines whether the edges of the objects in the canvas are to be rendered using the
    ///aliased edge mode.
    ///Params:
    ///    useAliasedEdgeMode = The Boolean value that determines whether the objects in the canvas are to be rendered using the aliased edge
    ///                         mode. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TRUE"></a><a
    ///                         id="true"></a><dl> <dt><b><b>TRUE</b></b></dt> </dl> </td> <td width="60%"> The edges of objects in the
    ///                         canvas are to be rendered without anti-aliasing using the aliased edge mode. This includes any objects in the
    ///                         canvas that have <i>useAliasedEdgeMode</i> set to <b>FALSE</b>. In the document markup, this corresponds to
    ///                         the <b>RenderOptions.EdgeMode</b> attribute having a value of <b>Aliased</b>. </td> </tr> <tr> <td
    ///                         width="40%"><a id="FALSE"></a><a id="false"></a><dl> <dt><b><b>FALSE</b></b></dt> </dl> </td> <td
    ///                         width="60%"> The edges of objects in the canvas are to be rendered in the default manner. In the document
    ///                         markup, this corresponds to the <b>RenderOptions.EdgeMode</b> attribute being absent. </td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>useAliasedEdgeMode</i> is <b>NULL</b>. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetUseAliasedEdgeMode(int* useAliasedEdgeMode);
    ///Sets the value that determines whether the edges of objects in this canvas will be rendered using the aliased
    ///edge mode.
    ///Params:
    ///    useAliasedEdgeMode = The Boolean value that determines whether the edges of child objects in this canvas will be rendered using
    ///                         the aliased edge mode. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///                         id="TRUE"></a><a id="true"></a><dl> <dt><b><b>TRUE</b></b></dt> </dl> </td> <td width="60%"> The edges of
    ///                         objects in the canvas are to be rendered without anti-aliasing using the aliased edge mode. This includes any
    ///                         objects that have this value set to <b>FALSE</b>. In the document markup, this corresponds to the
    ///                         <b>RenderOptions.EdgeMode</b> attribute having the value of <b>Aliased</b>. </td> </tr> <tr> <td
    ///                         width="40%"><a id="FALSE"></a><a id="false"></a><dl> <dt><b><b>FALSE</b></b></dt> </dl> </td> <td
    ///                         width="60%"> The edges of objects in the canvas are to be rendered in the default manner. In the document
    ///                         markup, this corresponds to the <b>RenderOptions.EdgeMode</b> attribute being absent. </td> </tr> </table>
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetUseAliasedEdgeMode(BOOL useAliasedEdgeMode);
    ///Gets a short textual description of the object's contents. This text is used by accessibility clients to describe
    ///the object.
    ///Params:
    ///    shortDescription = The short textual description of the object's contents. If this description is not set, a <b>NULL</b> pointer
    ///                       is returned.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>shortDescription</i> is <b>NULL</b>. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetAccessibilityShortDescription(ushort** shortDescription);
    ///Sets the short textual description of the object's contents. This text is used by accessibility clients to
    ///describe the object.
    ///Params:
    ///    shortDescription = The short textual description of the object's contents. A <b>NULL</b> pointer clears the previously assigned
    ///                       text.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetAccessibilityShortDescription(const(wchar)* shortDescription);
    ///Gets the long (detailed) textual description of the object's contents. This text is used by accessibility clients
    ///to describe the object.
    ///Params:
    ///    longDescription = The long (detailed) textual description of the object's contents. A <b>NULL</b> pointer is returned if this
    ///                      text has not been set.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>longDescription</i> is <b>NULL</b>. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetAccessibilityLongDescription(ushort** longDescription);
    ///Sets the long (detailed) textual description of the object's contents. This text is used by accessibility clients
    ///to describe the object.
    ///Params:
    ///    longDescription = The long (detailed) textual description of the object's contents. A <b>NULL</b> pointer clears the previously
    ///                      assigned value.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetAccessibilityLongDescription(const(wchar)* longDescription);
    ///Gets a pointer to the resolved IXpsOMDictionary interface of the dictionary associated with the canvas.
    ///Params:
    ///    resourceDictionary = A pointer to the resolved IXpsOMDictionary interface of the dictionary. The value that is returned in this
    ///                         parameter depends on which method has been most recently called to set the dictionary. <table> <tr> <th>Most
    ///                         recent method called</th> <th>Object returned in <i>resourceDictionary</i></th> </tr> <tr> <td>
    ///                         SetDictionaryLocal </td> <td> The local dictionary that is set by SetDictionaryLocal. </td> </tr> <tr> <td>
    ///                         SetDictionaryResource </td> <td> The shared dictionary in the dictionary resource that is set by
    ///                         SetDictionaryResource. </td> </tr> <tr> <td> Neither SetDictionaryLocal nor SetDictionaryResource has been
    ///                         called yet. </td> <td> <b>NULL</b> pointer. </td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>resourceDictionary</i> is <b>NULL</b>. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetDictionary(IXpsOMDictionary* resourceDictionary);
    ///Gets a pointer to the IXpsOMDictionary interface of the local, unshared dictionary.
    ///Params:
    ///    resourceDictionary = The IXpsOMDictionary interface pointer to the local, unshared dictionary, if one has been set. If a local
    ///                         dictionary has not been set or if a remote dictionary resource has been set, a <b>NULL</b> pointer is
    ///                         returned. <table> <tr> <th>Most recent method called</th> <th>Object returned in
    ///                         <i>resourceDictionary</i></th> </tr> <tr> <td> SetDictionaryLocal </td> <td> The local dictionary that is set
    ///                         by SetDictionaryLocal. </td> </tr> <tr> <td> SetDictionaryResource </td> <td> <b>NULL</b> pointer. </td>
    ///                         </tr> <tr> <td> Neither SetDictionaryLocal nor SetDictionaryResource has been called yet. </td> <td>
    ///                         <b>NULL</b> pointer. </td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>resourceDictionary</i> is <b>NULL</b>. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetDictionaryLocal(IXpsOMDictionary* resourceDictionary);
    ///Sets the IXpsOMDictionary interface pointer of the local, unshared dictionary.
    ///Params:
    ///    resourceDictionary = The IXpsOMDictionary interface of the local, unshared dictionary. A <b>NULL</b> pointer releases any
    ///                         previously assigned local dictionary.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>XPS_E_NO_CUSTOM_OBJECTS</b></dt> </dl> </td> <td width="60%"> <i>resourceDictionary</i> does not
    ///    point to a recognized interface implementation. Custom implementation of XPS Document API interfaces is not
    ///    supported. </td> </tr> </table>
    ///    
    HRESULT SetDictionaryLocal(IXpsOMDictionary resourceDictionary);
    ///Gets a pointer to the IXpsOMRemoteDictionaryResource interface of the remote dictionary resource.
    ///Params:
    ///    remoteDictionaryResource = The IXpsOMRemoteDictionaryResource interface pointer to the remote dictionary resource, if one has been set.
    ///                               If a remote dictionary resource has not been set or if a local dictionary resource has been set, a
    ///                               <b>NULL</b> pointer is returned. <table> <tr> <th>Most recent method called</th> <th>Object returned in
    ///                               <i>remoteDictionaryResource</i></th> </tr> <tr> <td> SetDictionaryLocal </td> <td> <b>NULL</b> pointer. </td>
    ///                               </tr> <tr> <td> SetDictionaryResource </td> <td> The remote dictionary resource that is set by
    ///                               SetDictionaryResource. </td> </tr> <tr> <td> Neither SetDictionaryLocal nor SetDictionaryResource has been
    ///                               called yet. </td> <td> <b>NULL</b> pointer. </td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>remoteDictionaryResource</i> is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetDictionaryResource(IXpsOMRemoteDictionaryResource* remoteDictionaryResource);
    ///Sets the IXpsOMRemoteDictionaryResource interface pointer of the remote dictionary resource.
    ///Params:
    ///    remoteDictionaryResource = The IXpsOMRemoteDictionaryResource interface of the remote dictionary resource. A <b>NULL</b> pointer
    ///                               releases any previously assigned dictionary resource.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>XPS_E_NO_CUSTOM_OBJECTS</b></dt> </dl> </td> <td width="60%"> <i>remoteDictionaryResource</i>
    ///    does not point to a recognized interface implementation. Custom implementation of XPS Document API interfaces
    ///    is not supported. </td> </tr> </table>
    ///    
    HRESULT SetDictionaryResource(IXpsOMRemoteDictionaryResource remoteDictionaryResource);
    ///Makes a deep copy of the interface.
    ///Params:
    ///    canvas = A pointer to the copy of the interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory to perform this operation.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>canvas</i>
    ///    is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT Clone(IXpsOMCanvas* canvas);
}

///Provides the root node of a tree of objects that hold the contents of a single page. The <b>IXpsOMPage</b> interface
///corresponds to the <b>FixedPage</b> element in XPS document markup.
@GUID("D3E18888-F120-4FEE-8C68-35296EAE91D4")
interface IXpsOMPage : IXpsOMPart
{
    ///Gets a pointer to the IXpsOMPageReference interface that contains the page.
    ///Params:
    ///    pageReference = A pointer to the IXpsOMPageReference interface that contains the page.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>pageReference</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetOwner(IXpsOMPageReference* pageReference);
    ///Gets a pointer to an IXpsOMVisualCollection interface that contains a collection of the page's visual objects.
    ///Params:
    ///    visuals = A pointer to the IXpsOMVisualCollection interface that contains a collection of the page's visual objects.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>visuals</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetVisuals(IXpsOMVisualCollection* visuals);
    ///Gets the page dimensions.
    ///Params:
    ///    pageDimensions = The page dimensions. Size is described in XPS units. There are 96 XPS units per inch. For example, the
    ///                     dimensions of an 8.5" by 11.0" page are 816 by 1,056 XPS units.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>pageDimensions</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetPageDimensions(XPS_SIZE* pageDimensions);
    ///Sets dimensions of the page.
    ///Params:
    ///    pageDimensions = Dimensions of the page. Size is described in XPS units. There are 96 XPS units per inch. For example, the
    ///                     dimensions of an 8.5" by 11.0" page are 816 by 1,056 XPS units. The XPS_SIZE structure has the following
    ///                     properties:
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>pageDimensions</i> is <b>NULL</b>. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>XPS_E_INVALID_PAGE_SIZE</b></dt> </dl> </td> <td width="60%"> The page size
    ///    specified in <i>pageDimensions</i> contains one or more values that are not allowed. </td> </tr> </table>
    ///    
    HRESULT SetPageDimensions(const(XPS_SIZE)* pageDimensions);
    ///Gets the dimensions of the page's content box.
    ///Params:
    ///    contentBox = The dimensions of the content box.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>contentBox</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetContentBox(XPS_RECT* contentBox);
    ///Sets the dimensions of the page's content box.
    ///Params:
    ///    contentBox = The dimensions of the page's content box. <table> <tr> <th><i>contentBox</i> field</th> <th>Valid values</th>
    ///                 </tr> <tr> <td><i>contentBox.width</i></td> <td>Greater than or equal to 0.0 and less than or equal to
    ///                 (pageDimensions.width - contentBox.x).</td> </tr> <tr> <td><i>contentBox.height</i></td> <td>Greater than or
    ///                 equal to 0.0 and less than or equal to (pageDimensions.height - contentBox.y).</td> </tr> <tr>
    ///                 <td><i>contentBox.x</i></td> <td>Greater than or equal to 0.0 and less than pageDimensions.width.</td> </tr>
    ///                 <tr> <td><i>contentBox.y</i></td> <td>Greater than or equal to 0.0 and less than pageDimensions.height.</td>
    ///                 </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>contentBox</i> is <b>NULL</b>. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>XPS_E_INVALID_CONTENT_BOX</b></dt> </dl> </td> <td width="60%"> The
    ///    rectangle specified by <i>contentBox</i> contains one or more values that are not valid. </td> </tr> </table>
    ///    
    HRESULT SetContentBox(const(XPS_RECT)* contentBox);
    ///Gets the dimensions of the page's bleed box.
    ///Params:
    ///    bleedBox = The dimensions of the bleed box.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>bleedBox</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetBleedBox(XPS_RECT* bleedBox);
    ///Sets the dimensions of the page's bleed box.
    ///Params:
    ///    bleedBox = The dimensions of the page's bleed box. This parameter must not be <b>NULL</b>. A valid bleed box has the
    ///               following properties:
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>bleedBox</i> is <b>NULL</b>. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>XPS_E_INVALID_BLEED_BOX</b></dt> </dl> </td> <td width="60%"> The rectangle
    ///    described by <i>bleedBox</i> contains one or more values that are not valid. </td> </tr> </table>
    ///    
    HRESULT SetBleedBox(const(XPS_RECT)* bleedBox);
    ///Gets the <b>Language</b> property of the page.
    ///Params:
    ///    language = A language tag string that represents the language of the page contents. If the <b>Language</b> property has
    ///               not been set, a <b>NULL</b> pointer is returned.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>language</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetLanguage(ushort** language);
    ///Sets the <b>Language</b> property of the page.
    ///Params:
    ///    language = A language tag string that represents the language of the page content. A <b>NULL</b> pointer clears the
    ///               previously assigned language.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>XPS_E_INVALID_LANGUAGE</b></dt> </dl> </td> <td width="60%"> The language string contains one or
    ///    more language strings that are not valid. </td> </tr> </table>
    ///    
    HRESULT SetLanguage(const(wchar)* language);
    ///Gets the <b>Name</b> property of the page.
    ///Params:
    ///    name = The <b>Name</b> property of the page. A <b>NULL</b> pointer is returned if the <b>Name</b> property has not
    ///           been set.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>name</i> is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetName(ushort** name);
    ///Sets the <b>Name</b> property of this page.
    ///Params:
    ///    name = A pointer to the name string to be set as the page's <b>Name</b> property. A <b>NULL</b> pointer clears any
    ///           previously assigned name.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>XPS_E_INVALID_NAME</b></dt> </dl> </td> <td width="60%"> The name string contains a character
    ///    that is not valid. </td> </tr> </table>
    ///    
    HRESULT SetName(const(wchar)* name);
    ///Gets a Boolean value that indicates whether the page is the target of a hyperlink.
    ///Params:
    ///    isHyperlinkTarget = A Boolean value that indicates whether the page is the target of a hyperlink. <table> <tr> <th>Value</th>
    ///                        <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>TRUE</b></dt> </dl> </td> <td width="60%"> The page
    ///                        is the target of a hyperlink. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>FALSE</b></dt> </dl> </td> <td
    ///                        width="60%"> The page is not the target of a hyperlink. </td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>isHyperlinkTarget</i> is <b>NULL</b>. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetIsHyperlinkTarget(int* isHyperlinkTarget);
    ///Specifies whether the page is the target of a hyperlink.
    ///Params:
    ///    isHyperlinkTarget = The Boolean value that indicates whether the page is the target of a hyperlink. <table> <tr> <th>Value</th>
    ///                        <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>TRUE</dt> </dl> </td> <td width="60%"> The page is the
    ///                        target of a hyperlink. </td> </tr> <tr> <td width="40%"> <dl> <dt>FALSE</dt> </dl> </td> <td width="60%"> The
    ///                        page is not the target of a hyperlink. </td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>XPS_E_MISSING_NAME</b></dt> </dl> </td> <td width="60%"> The page has not been named. The
    ///    hyperlink target status can only be set if the page has a name. </td> </tr> </table>
    ///    
    HRESULT SetIsHyperlinkTarget(BOOL isHyperlinkTarget);
    ///Gets a pointer to the resolved IXpsOMDictionary interface that is associated with this page.
    ///Params:
    ///    resourceDictionary = A pointer to the resolved IXpsOMDictionary interface that is associated with this page. The value that is
    ///                         returned in this parameter depends on which method has most recently been called to set the dictionary.
    ///                         <table> <tr> <th>Most recent method called</th> <th>Object that is returned in <i>resourceDictionary</i></th>
    ///                         </tr> <tr> <td> SetDictionaryLocal </td> <td> The local dictionary resource that is set by
    ///                         SetDictionaryLocal. </td> </tr> <tr> <td> SetDictionaryResource </td> <td> The shared dictionary in the
    ///                         dictionary resource that is set by SetDictionaryResource. </td> </tr> <tr> <td> Neither SetDictionaryLocal
    ///                         nor SetDictionaryResource has been called yet. </td> <td> <b>NULL</b> pointer. </td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>resourceDictionary</i> is <b>NULL</b>. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>XPS_E_LOOKUP_INVALID_TYPE</b></dt> </dl> </td> <td width="60%"> The
    ///    lookup key name set by SetStrokeBrushLookup references an object that is not a brush. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>XPS_E_LOOKUP_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> No object could be
    ///    found with a key name that matched the lookup value. No object could be found with a key name that matched
    ///    the value passed in <i>lookup</i>. </td> </tr> </table>
    ///    
    HRESULT GetDictionary(IXpsOMDictionary* resourceDictionary);
    ///Gets a pointer to the IXpsOMDictionary interface of the local, unshared dictionary that is associated with this
    ///page.
    ///Params:
    ///    resourceDictionary = A pointer to the IXpsOMDictionary interface of the local, unshared dictionary that is associated with this
    ///                         page. If no <b>IXpsOMDictionary</b> interface pointer has been set or if a remote dictionary resource has
    ///                         been set, a <b>NULL</b> pointer is returned. <table> <tr> <th>Most recent method called</th> <th>Object that
    ///                         is returned in <i>resourceDictionary</i></th> </tr> <tr> <td> SetDictionaryLocal </td> <td> The local
    ///                         dictionary resource that is set by SetDictionaryLocal. </td> </tr> <tr> <td> SetDictionaryResource </td> <td>
    ///                         <b>NULL</b> pointer. </td> </tr> <tr> <td> Neither SetDictionaryLocal nor SetDictionaryResource has been
    ///                         called yet. </td> <td> <b>NULL</b> pointer. </td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>resourceDictionary</i> is <b>NULL</b>. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetDictionaryLocal(IXpsOMDictionary* resourceDictionary);
    ///Sets the IXpsOMDictionary interface pointer of the page's local dictionary resource.
    ///Params:
    ///    resourceDictionary = The IXpsOMDictionary interface pointer to be set for the page. A <b>NULL</b> pointer releases any previously
    ///                         assigned local dictionary.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>XPS_E_NO_CUSTOM_OBJECTS</b></dt> </dl> </td> <td width="60%"> <i>resourceDictionary</i> does not
    ///    point to a recognized interface implementation. Custom implementation of XPS Document API interfaces is not
    ///    supported. </td> </tr> </table>
    ///    
    HRESULT SetDictionaryLocal(IXpsOMDictionary resourceDictionary);
    ///Gets a pointer to the IXpsOMRemoteDictionaryResource interface of the shared dictionary resource that is used by
    ///this page.
    ///Params:
    ///    remoteDictionaryResource = A pointer to the IXpsOMRemoteDictionaryResource interface of the shared dictionary resource that is used by
    ///                               this page. If no <b>IXpsOMRemoteDictionaryResource</b> interface has been set or if a local dictionary has
    ///                               been set, a <b>NULL</b> pointer is returned. <table> <tr> <th>Most recent method called</th> <th>Object that
    ///                               is returned in <i>remoteDictionaryResource</i></th> </tr> <tr> <td> SetDictionaryLocal </td> <td> <b>NULL</b>
    ///                               pointer. </td> </tr> <tr> <td> SetDictionaryResource </td> <td> The remote dictionary resource that is set by
    ///                               SetDictionaryResource. </td> </tr> <tr> <td> Neither SetDictionaryLocal nor SetDictionaryResource has been
    ///                               called yet. </td> <td> <b>NULL</b> pointer. </td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>remoteDictionaryResource</i> is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetDictionaryResource(IXpsOMRemoteDictionaryResource* remoteDictionaryResource);
    ///Sets the IXpsOMRemoteDictionaryResource interface pointer of the page's remote dictionary resource.
    ///Params:
    ///    remoteDictionaryResource = The IXpsOMRemoteDictionaryResource interface pointer to be set for the page. A <b>NULL</b> value releases the
    ///                               previously assigned dictionary resource.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>XPS_E_NO_CUSTOM_OBJECTS</b></dt> </dl> </td> <td width="60%"> <i>remoteDictionaryResource</i>
    ///    does not point to a recognized interface implementation. Custom implementation of XPS Document API interfaces
    ///    is not supported. </td> </tr> </table>
    ///    
    HRESULT SetDictionaryResource(IXpsOMRemoteDictionaryResource remoteDictionaryResource);
    ///Writes the page to the specified stream.
    ///Params:
    ///    stream = The stream that receives the serialized contents of the page.
    ///    optimizeMarkupSize = A Boolean value that indicates whether the document markup of the page is to be optimized for size when the
    ///                         page is written to the stream. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///                         id="TRUE"></a><a id="true"></a><dl> <dt><b><b>TRUE</b></b></dt> </dl> </td> <td width="60%"> The package
    ///                         writer will attempt to optimize the markup for minimum size when writing the page to the stream. </td> </tr>
    ///                         <tr> <td width="40%"><a id="FALSE"></a><a id="false"></a><dl> <dt><b><b>FALSE</b></b></dt> </dl> </td> <td
    ///                         width="60%"> The package writer will not attempt any optimization when writing the page to the stream. </td>
    ///                         </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>stream</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT Write(ISequentialStream stream, BOOL optimizeMarkupSize);
    ///Generates a unique name that can be used as a lookup key by a resource in a resource dictionary.
    ///Params:
    ///    type = The type of IXpsOMShareable object for which the lookup key is generated.
    ///    key = The lookup key string that is generated by this method.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td>
    ///    <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl>
    ///    </td> <td width="60%"> <i>key</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>type</i> refers to an object type that is not
    ///    recognized. </td> </tr> </table>
    ///    
    HRESULT GenerateUnusedLookupKey(XPS_OBJECT_TYPE type, ushort** key);
    ///Makes a deep copy of the interface.
    ///Params:
    ///    page = A pointer to the copy of the interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory to perform this operation.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>page</i> is
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT Clone(IXpsOMPage* page);
}

///Enables virtualization of pages in an XPS document. A page reference defers loading of the full object model of a
///page until the page is requested. If the page has not been altered, it can also be unloaded on request.
@GUID("ED360180-6F92-4998-890D-2F208531A0A0")
interface IXpsOMPageReference : IUnknown
{
    ///Gets a pointer to the IXpsOMDocument interface that contains the page reference.
    ///Params:
    ///    document = A pointer to the IXpsOMDocument interface that contains the page reference. If the page reference does not
    ///               have an owner, a <b>NULL</b> pointer is returned.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td>
    ///    <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl>
    ///    </td> <td width="60%"> <i>document</i> is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetOwner(IXpsOMDocument* document);
    ///Gets a pointer to the IXpsOMPage interface that contains the page.
    ///Params:
    ///    page = A pointer to the IXpsOMPage interface of the page. If a page has not been set, a <b>NULL</b> pointer is
    ///           returned.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>document</i> is <b>NULL</b>. </td> </tr>
    ///    </table> This method calls the Packaging API. For information about the Packaging API return values, see
    ///    Packaging Errors.
    ///    
    HRESULT GetPage(IXpsOMPage* page);
    ///Sets the IXpsOMPage interface of the page reference.
    ///Params:
    ///    page = The IXpsOMPage interface pointer of the page.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td>
    ///    <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl>
    ///    </td> <td width="60%"> <i>page</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>XPS_E_NO_CUSTOM_OBJECTS</b></dt> </dl> </td> <td width="60%"> <i>page</i> does not point to a
    ///    recognized interface implementation. Custom implementation of XPS Document API interfaces is not supported.
    ///    </td> </tr> </table>
    ///    
    HRESULT SetPage(IXpsOMPage page);
    ///Discards the page from memory.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td>
    ///    <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt>
    ///    </dl> </td> <td width="60%"> DiscardPage has been called more than once or the page has not been loaded.
    ///    </td> </tr> </table>
    ///    
    HRESULT DiscardPage();
    ///Gets the referenced page status, which indicates whether the page is loaded.
    ///Params:
    ///    isPageLoaded = A Boolean value that indicates the status of the page. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
    ///                   <tr> <td width="40%"><a id="TRUE"></a><a id="true"></a><dl> <dt><b><b>TRUE</b></b></dt> </dl> </td> <td
    ///                   width="60%"> The page is loaded. </td> </tr> <tr> <td width="40%"><a id="FALSE"></a><a id="false"></a><dl>
    ///                   <dt><b><b>FALSE</b></b></dt> </dl> </td> <td width="60%"> The page is not loaded. </td> </tr> </table>
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td>
    ///    <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl>
    ///    </td> <td width="60%"> <i>isPageLoaded</i> is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT IsPageLoaded(int* isPageLoaded);
    ///Gets the suggested dimensions of the page.
    ///Params:
    ///    pageDimensions = The suggested dimensions of the page. Size is described in XPS units. There are 96 XPS units per inch. For
    ///                     example, the dimensions of an 8.5" by 11.0" page are 816 by 1,056 XPS units.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td>
    ///    <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl>
    ///    </td> <td width="60%"> <i>pageDimensions</i> is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetAdvisoryPageDimensions(XPS_SIZE* pageDimensions);
    ///Sets the suggested dimensions of the page.
    ///Params:
    ///    pageDimensions = The suggested dimensions to be set for the page. The <b>height</b> and <b>width</b> members must have the
    ///                     value of –1.0 or a value that is greater than or equal to +1.0. Size is described in XPS units. There are
    ///                     96 XPS units per inch. For example, the dimensions of an 8.5" by 11.0" page are 816 by 1,056 XPS units.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td>
    ///    <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl>
    ///    </td> <td width="60%"> Either <i>pageDimensions</i> is <b>NULL</b> or a field in the XPS_SIZE structure that
    ///    is referenced by <i>pageDimensions</i> contains a value that is not valid. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>XPS_E_INVALID_PAGE_SIZE</b></dt> </dl> </td> <td width="60%"> The advisory page size described in
    ///    <i>pageDimensions</i> was not valid. The <b>height</b> and <b>width</b> members of <i>pageDimensions</i> must
    ///    have the value of –1.0 or a value that is greater than or equal to +1.0. </td> </tr> </table>
    ///    
    HRESULT SetAdvisoryPageDimensions(const(XPS_SIZE)* pageDimensions);
    ///Gets a pointer to the IXpsOMStoryFragmentsResource interface of the StoryFragments part resource that is
    ///associated with the page.
    ///Params:
    ///    storyFragmentsResource = A pointer to the IXpsOMStoryFragmentsResource interface of the StoryFragments part resource that is
    ///                             associated with the page. If there is no StoryFragments part, a <b>NULL</b> pointer is returned.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>storyFragmentsResource</i> is <b>NULL</b>.
    ///    </td> </tr> </table> This method calls the Packaging API. For information about the Packaging API return
    ///    values, see Packaging Errors.
    ///    
    HRESULT GetStoryFragmentsResource(IXpsOMStoryFragmentsResource* storyFragmentsResource);
    ///Sets the IXpsOMStoryFragmentsResource interface pointer of the StoryFragments resource to be assigned to the
    ///page.
    ///Params:
    ///    storyFragmentsResource = A pointer to the IXpsOMStoryFragmentsResource interface of the StoryFragments part resource to be assigned to
    ///                             the page. If an <b>IXpsOMStoryFragmentsResource</b> interface has been set, a <b>NULL</b> pointer will
    ///                             release it.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td>
    ///    <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>XPS_E_NO_CUSTOM_OBJECTS</b></dt> </dl> </td> <td width="60%"> <i>storyFragmentsResource</i> does not
    ///    point to a recognized interface implementation. Custom implementation of XPS Document API interfaces is not
    ///    supported. </td> </tr> </table>
    ///    
    HRESULT SetStoryFragmentsResource(IXpsOMStoryFragmentsResource storyFragmentsResource);
    ///Gets a pointer to the IXpsOMPrintTicketResource interface of the page-level print ticket resource that is
    ///associated with the page.
    ///Params:
    ///    printTicketResource = A pointer to the IXpsOMPrintTicketResource interface of the page-level print ticket resource that is
    ///                          associated with the page. If no print ticket resource has been set, a <b>NULL</b> pointer is returned.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>printTicketResource</i> is <b>NULL</b>. </td>
    ///    </tr> </table> This method calls the Packaging API. For information about the Packaging API return values,
    ///    see Packaging Errors.
    ///    
    HRESULT GetPrintTicketResource(IXpsOMPrintTicketResource* printTicketResource);
    ///Sets the IXpsOMPrintTicketResource interface pointer of the page-level print ticket resource that is to be
    ///assigned to the page.
    ///Params:
    ///    printTicketResource = A pointer to the IXpsOMPrintTicketResource interface of the page-level print ticket resource that is to be
    ///                          assigned to the page. If a print ticket has already been set, a <b>NULL</b> pointer releases it.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td>
    ///    <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>XPS_E_NO_CUSTOM_OBJECTS</b></dt> </dl> </td> <td width="60%"> <i>printTicketResource</i> does not
    ///    point to a recognized interface implementation. Custom implementation of XPS Document API interfaces is not
    ///    supported. </td> </tr> </table>
    ///    
    HRESULT SetPrintTicketResource(IXpsOMPrintTicketResource printTicketResource);
    ///Gets a pointer to the IXpsOMImageResource interface of the thumbnail image resource that is associated with the
    ///page.
    ///Params:
    ///    imageResource = A pointer to the IXpsOMImageResource interface of the thumbnail image resource that is associated with the
    ///                    page. If no thumbnail image resource has been assigned to the page, a <b>NULL</b> pointer is returned.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>imageResource</i> is <b>NULL</b>. </td> </tr>
    ///    </table> This method calls the Packaging API. For information about the Packaging API return values, see
    ///    Packaging Errors.
    ///    
    HRESULT GetThumbnailResource(IXpsOMImageResource* imageResource);
    ///Sets the pointer to the IXpsOMImageResource interface of the thumbnail image resource to be assigned to the page.
    ///Params:
    ///    imageResource = A pointer to the IXpsOMImageResource interface of the thumbnail image resource to be assigned to the page. If
    ///                    an <b>IXpsOMImageResource</b> interface has been set, a <b>NULL</b> pointer will release it.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td>
    ///    <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>XPS_E_INVALID_THUMBNAIL_IMAGE_TYPE</b></dt> </dl> </td> <td width="60%"> The image in
    ///    <i>imageResource</i> is not a supported image type. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>XPS_E_NO_CUSTOM_OBJECTS</b></dt> </dl> </td> <td width="60%"> <i>imageResource</i> does not point to a
    ///    recognized interface implementation. Custom implementation of XPS Document API interfaces is not supported.
    ///    </td> </tr> </table>
    ///    
    HRESULT SetThumbnailResource(IXpsOMImageResource imageResource);
    ///Gets an IXpsOMNameCollection interface that contains the names of all the document subtree objects whose
    ///<b>IsHyperlinkTarget</b> property is set to <b>TRUE</b>.
    ///Params:
    ///    linkTargets = A pointer to an IXpsOMNameCollection interface that contains the names of all the document subtree objects
    ///                  whose <b>IsHyperlinkTarget</b> property is set to <b>TRUE</b>. If no such objects exist in the document, the
    ///                  <b>IXpsOMNameCollection</b> interface will be empty. <div class="alert"><b>Note</b> Every time this method is
    ///                  called, it returns a new collection.</div> <div> </div>
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td>
    ///    <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt>
    ///    </dl> </td> <td width="60%"> Not enough memory to perform this operation. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>linkTargets</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT CollectLinkTargets(IXpsOMNameCollection* linkTargets);
    ///Creates a list of all part-based resources that are associated with the page.
    ///Params:
    ///    partResources = A pointer to the IXpsOMPartResources interface that contains the list of all part-based resources that are
    ///                    associated with the page.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>partResources</i> is <b>NULL</b>. </td> </tr>
    ///    </table> This method calls the Packaging API. For information about the Packaging API return values, see
    ///    Packaging Errors.
    ///    
    HRESULT CollectPartResources(IXpsOMPartResources* partResources);
    ///Gets a Boolean value that indicates whether the document sub-tree of the referenced page includes any Glyphs that
    ///have a font resource whose <b>EmbeddingOption</b> property is set to XPS_FONT_EMBEDDING_RESTRICTED.
    ///Params:
    ///    restrictedFonts = A Boolean value that indicates whether the document sub-tree of the referenced page includes any IXpsOMGlyphs
    ///                      interfaces that have a font resource whose <b>EmbeddingOption</b> property is set to
    ///                      XPS_FONT_EMBEDDING_RESTRICTED. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///                      id="TRUE"></a><a id="true"></a><dl> <dt><b><b>TRUE</b></b></dt> </dl> </td> <td width="60%"> If the
    ///                      referenced page is loaded, the page references at least one font resource whose <b>EmbeddingOption</b>
    ///                      property is set to XPS_FONT_EMBEDDING_RESTRICTED. If the referenced page is not loaded, it has a relationship
    ///                      with at least one font resource whose <b>EmbeddingOption</b> property is set to
    ///                      XPS_FONT_EMBEDDING_RESTRICTED. </td> </tr> <tr> <td width="40%"><a id="FALSE"></a><a id="false"></a><dl>
    ///                      <dt><b><b>FALSE</b></b></dt> </dl> </td> <td width="60%"> If the referenced page is loaded, the page does not
    ///                      reference any font resources whose <b>EmbeddingOption</b> property is set to XPS_FONT_EMBEDDING_RESTRICTED.
    ///                      If the referenced page is not loaded, it does not have a relationship with a font resource whose
    ///                      <b>EmbeddingOption</b> property is set to XPS_FONT_EMBEDDING_RESTRICTED. </td> </tr> </table>
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td>
    ///    <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl>
    ///    </td> <td width="60%"> <i>restrictedFonts</i> is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT HasRestrictedFonts(int* restrictedFonts);
    ///Makes a deep copy of the interface.
    ///Params:
    ///    pageReference = A pointer to the copy of the interface.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td>
    ///    <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt>
    ///    </dl> </td> <td width="60%"> Not enough memory to perform this operation. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>pageReference</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT Clone(IXpsOMPageReference* pageReference);
}

///A collection of IXpsOMPageReference interface pointers.
@GUID("CA16BA4D-E7B9-45C5-958B-F98022473745")
interface IXpsOMPageReferenceCollection : IUnknown
{
    ///Gets the number of IXpsOMPageReference interface pointers in the collection.
    ///Params:
    ///    count = The number of IXpsOMPageReference interface pointers in the collection.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetCount(uint* count);
    ///Gets an IXpsOMPageReference interface pointer from a specified location in the collection.
    ///Params:
    ///    index = The zero-based index of the IXpsOMPageReference interface pointer to be obtained.
    ///    pageReference = The IXpsOMPageReference interface pointer at the location specified by <i>index</i>.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetAt(uint index, IXpsOMPageReference* pageReference);
    ///Inserts an IXpsOMPageReference interface pointer at a specified location in the collection.
    ///Params:
    ///    index = The zero-based index in the collection where the interface pointer that is passed in <i>pageReference</i> is
    ///            to be inserted.
    ///    pageReference = The IXpsOMPageReference interface pointer that is to be inserted at the location specified by <i>index</i>.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT InsertAt(uint index, IXpsOMPageReference pageReference);
    ///Removes and releases an IXpsOMPageReference interface pointer from a specified location in the collection.
    ///Params:
    ///    index = The zero-based index in the collection from which an IXpsOMPageReference interface pointer is to be removed
    ///            and released.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT RemoveAt(uint index);
    ///Replaces an IXpsOMPageReference interface pointer at a specified location in the collection.
    ///Params:
    ///    index = The zero-based index in the collection where an IXpsOMPageReference interface pointer is to be replaced.
    ///    pageReference = The IXpsOMPageReference interface pointer that will replace current contents at the location specified by
    ///                    <i>index</i>.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetAt(uint index, IXpsOMPageReference pageReference);
    ///Appends an IXpsOMPageReference interface to the end of the collection.
    ///Params:
    ///    pageReference = A pointer to the IXpsOMPageReference interface that is to be appended to the collection.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT Append(IXpsOMPageReference pageReference);
}

///An ordered sequence of fixed pages and document-level resources that make up the document.
@GUID("2C2C94CB-AC5F-4254-8EE9-23948309D9F0")
interface IXpsOMDocument : IXpsOMPart
{
    ///Gets a pointer to the IXpsOMDocumentSequence interface that contains the document.
    ///Params:
    ///    documentSequence = A pointer to the IXpsOMDocumentSequence interface that contains the document. If the document does not belong
    ///                       to a document sequence, a <b>NULL</b> pointer is returned.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>documentSequence</i> is <b>NULL</b>. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetOwner(IXpsOMDocumentSequence* documentSequence);
    ///Gets the IXpsOMPageReferenceCollection interface of the document, which allows virtualized access to its pages.
    ///Params:
    ///    pageReferences = A pointer to the IXpsOMPageReferenceCollection interface that contains a collection of page references for
    ///                     each page of the document. If there are no page references, the <b>IXpsOMPageReferenceCollection</b> returned
    ///                     in <i>pageReferences</i> will be empty and will have no elements.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>pageReferences</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetPageReferences(IXpsOMPageReferenceCollection* pageReferences);
    ///Gets the IXpsOMPrintTicketResource interface of the document-level print ticket.
    ///Params:
    ///    printTicketResource = A pointer to the IXpsOMPrintTicketResource interface of the document-level print ticket that is associated
    ///                          with the document. If no print ticket has been assigned, a <b>NULL</b> pointer will be returned.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>printTicketResource</i> is <b>NULL</b>. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetPrintTicketResource(IXpsOMPrintTicketResource* printTicketResource);
    ///Sets the IXpsOMPrintTicketResource interface for the document-level print ticket.
    ///Params:
    ///    printTicketResource = A pointer to the IXpsOMPrintTicketResource interface for the document-level print ticket to be assigned to
    ///                          the document. A <b>NULL</b> pointer releases any previously assigned print ticket resource.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>XPS_E_NO_CUSTOM_OBJECTS</b></dt> </dl> </td> <td width="60%"> <i>printTicketResource</i> does not
    ///    point to a recognized interface implementation. Custom implementation of XPS Document API interfaces is not
    ///    supported. </td> </tr> </table>
    ///    
    HRESULT SetPrintTicketResource(IXpsOMPrintTicketResource printTicketResource);
    ///Gets a pointer to the IXpsOMDocumentStructureResource interface of the resource that contains structural
    ///information about the document.
    ///Params:
    ///    documentStructureResource = A pointer to the IXpsOMDocumentStructureResource interface of the resource. A <b>NULL</b> pointer is returned
    ///                                if an <b>IXpsOMDocumentStructureResource</b> interface is not present or has not been specified.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>documentStructureResource</i> is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetDocumentStructureResource(IXpsOMDocumentStructureResource* documentStructureResource);
    ///Sets the IXpsOMDocumentStructureResource interface for the document.
    ///Params:
    ///    documentStructureResource = A pointer to the IXpsOMDocumentStructureResource interface to be assigned to the document. A <b>NULL</b>
    ///                                pointer releases any previously assigned resource.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>XPS_E_NO_CUSTOM_OBJECTS</b></dt> </dl> </td> <td width="60%"> <i>documentStructureResource</i>
    ///    does not point to a recognized interface implementation. Custom implementation of XPS Document API interfaces
    ///    is not supported. </td> </tr> </table>
    ///    
    HRESULT SetDocumentStructureResource(IXpsOMDocumentStructureResource documentStructureResource);
    ///Gets a pointer to the IXpsOMSignatureBlockResourceCollection interface, which refers to a collection of the
    ///document's digital signature block resources.
    ///Params:
    ///    signatureBlockResources = A pointer to the IXpsOMSignatureBlockResourceCollection interface, which refers to a collection of the
    ///                              document's digital signature block resources. If the document does not contain any signature block resources,
    ///                              the <b>IXpsOMSignatureBlockResourceCollection</b> interface will be empty.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>signatureBlockResources</i> is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetSignatureBlockResources(IXpsOMSignatureBlockResourceCollection* signatureBlockResources);
    ///Makes a deep copy of the interface.
    ///Params:
    ///    document = A pointer to the copy of the interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory to perform this operation.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>document</i>
    ///    is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT Clone(IXpsOMDocument* document);
}

///A collection of IXpsOMDocument interface pointers.
@GUID("D1C87F0D-E947-4754-8A25-971478F7E83E")
interface IXpsOMDocumentCollection : IUnknown
{
    ///Gets the number of IXpsOMDocument interface pointers in the collection.
    ///Params:
    ///    count = The number of IXpsOMDocument interface pointers in the collection.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetCount(uint* count);
    ///Gets an IXpsOMDocument interface pointer from a specified location in the collection.
    ///Params:
    ///    index = The zero-based index of the IXpsOMDocument interface pointer to be obtained.
    ///    document = The IXpsOMDocument interface pointer at the location specified by <i>index</i>.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetAt(uint index, IXpsOMDocument* document);
    ///Inserts an IXpsOMDocument interface pointer at a specified location in the collection.
    ///Params:
    ///    index = The zero-based index of the collection where the interface pointer that is passed in <i>document</i> is to be
    ///            inserted.
    ///    document = The IXpsOMDocument interface pointer that is to be inserted at the location specified by <i>index</i>.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT InsertAt(uint index, IXpsOMDocument document);
    ///Removes and releases an IXpsOMDocument interface pointer from a specified location in the collection.
    ///Params:
    ///    index = The zero-based index in the collection from which an IXpsOMDocument interface pointer is to be removed and
    ///            released.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT RemoveAt(uint index);
    ///Replaces an IXpsOMDocument interface pointer at a specified location in the collection.
    ///Params:
    ///    index = The zero-based index in the collection where an IXpsOMDocument interface pointer is to be replaced.
    ///    document = The IXpsOMDocument interface pointer that will replace current contents at the location specified by
    ///               <i>index</i>.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetAt(uint index, IXpsOMDocument document);
    ///Appends an IXpsOMDocument interface to the end of the collection.
    ///Params:
    ///    document = A pointer to the IXpsOMDocument interface that is to be appended to the collection.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT Append(IXpsOMDocument document);
}

///The root object that has the XPS document content.
@GUID("56492EB4-D8D5-425E-8256-4C2B64AD0264")
interface IXpsOMDocumentSequence : IXpsOMPart
{
    ///Gets a pointer to the IXpsOMPackage interface that contains the document sequence.
    ///Params:
    ///    package = A pointer to the IXpsOMPackage interface that contains the document sequence. If the document sequence does
    ///              not belong to a package, a <b>NULL</b> pointer is returned.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>package</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetOwner(IXpsOMPackage* package_);
    ///Gets a pointer to the IXpsOMDocumentCollection interface, which contains the documents specified in the document
    ///sequence.
    ///Params:
    ///    documents = A pointer to the IXpsOMDocumentCollection interface, which contains the documents specified in the document
    ///                sequence. If the sequence does not have any documents, the <b>IXpsOMDocumentCollection</b> interface will be
    ///                empty.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>documents</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetDocuments(IXpsOMDocumentCollection* documents);
    ///Gets the IXpsOMPrintTicketResource interface to the job-level print ticket that is assigned to the document
    ///sequence.
    ///Params:
    ///    printTicketResource = A pointer to the IXpsOMPrintTicketResource interface of the job-level print ticket that is assigned to the
    ///                          document sequence. If no <b>IXpsOMPrintTicketResource</b> interface has been assigned to the document
    ///                          sequence, a <b>NULL</b> pointer is returned.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>printTicketResource</i> is <b>NULL</b>. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetPrintTicketResource(IXpsOMPrintTicketResource* printTicketResource);
    ///Sets the job-level print ticket resource for the document sequence.
    ///Params:
    ///    printTicketResource = A pointer to the IXpsOMPrintTicketResource interface of the job-level print ticket that will be set for the
    ///                          document sequence. If the document sequence has a print ticket resource, a <b>NULL</b> pointer will release
    ///                          it.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetPrintTicketResource(IXpsOMPrintTicketResource printTicketResource);
}

///This interface provides access to the metadata that is stored in the Core Properties part of the XPS document. The
///contents of the Core Properties part are described in the 1st edition, Part 2, "Open Packaging Conventions," of
///Standard ECMA-376, Office Open XML File Formats.
@GUID("3340FE8F-4027-4AA1-8F5F-D35AE45FE597")
interface IXpsOMCoreProperties : IXpsOMPart
{
    ///Gets a pointer to the IXpsOMPackage interface that contains the core properties.
    ///Params:
    ///    package = A pointer to the IXpsOMPackage interface that contains the core properties. If the interface does not belong
    ///              to a package, a <b>NULL</b> pointer is returned.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>package</i> was <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetOwner(IXpsOMPackage* package_);
    ///Gets the <b>category</b> property.
    ///Params:
    ///    category = The string that is read from the <b>category</b> property.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>category</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetCategory(ushort** category);
    ///Sets the <b>category</b> property.
    ///Params:
    ///    category = The string to be written to the <b>category</b> property. A <b>NULL</b> pointer clears the <b>category</b>
    ///               property.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetCategory(const(wchar)* category);
    ///Gets the <b>contentStatus</b> property.
    ///Params:
    ///    contentStatus = The string that is read from the <b>contentStatus</b> property.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>contentStatus</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetContentStatus(ushort** contentStatus);
    ///Sets the <b>contentStatus</b> property.
    ///Params:
    ///    contentStatus = The string to be written to the <b>contentStatus</b> property. A <b>NULL</b> pointer clears the
    ///                    <b>contentStatus</b> property.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetContentStatus(const(wchar)* contentStatus);
    ///Gets the <b>contentType</b> property.
    ///Params:
    ///    contentType = The string that is read from the <b>contentType</b> property.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>contentType</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetContentType(ushort** contentType);
    ///Sets the <b>contentType</b> property.
    ///Params:
    ///    contentType = The string to be written to the <b>contentType</b> property. A <b>NULL</b> pointer clears the
    ///                  <b>contentType</b> property.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetContentType(const(wchar)* contentType);
    ///Gets the <b>created</b> property.
    ///Params:
    ///    created = The date and time that are read from the <b>created</b> property.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>created</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetCreated(SYSTEMTIME* created);
    ///Sets the <b>created</b> property.
    ///Params:
    ///    created = The date and time the package was created. A <b>NULL</b> pointer clears the <b>created</b> property
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>created</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT SetCreated(const(SYSTEMTIME)* created);
    ///Gets the <b>creator</b> property.
    ///Params:
    ///    creator = The string that is read from the <b>creator</b> property.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>creator</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetCreator(ushort** creator);
    ///Sets the <b>creator</b> property.
    ///Params:
    ///    creator = The string to be written to the <b>creator</b> property. A <b>NULL</b> pointer clears the <b>creator</b>
    ///              property.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetCreator(const(wchar)* creator);
    ///Gets the <b>description</b> property.
    ///Params:
    ///    description = The string that is read from the <b>description</b> property.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>description</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetDescription(ushort** description);
    ///Sets the <b>description</b> property.
    ///Params:
    ///    description = The string to be written to the <b>description</b> property. A <b>NULL</b> pointer clears this property.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetDescription(const(wchar)* description);
    ///Gets the <b>identifier</b> property.
    ///Params:
    ///    identifier = The string that is read from the <b>identifier</b> property.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>identifier</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetIdentifier(ushort** identifier);
    ///Sets the <b>identifier</b> property.
    ///Params:
    ///    identifier = The string to be written to the <b>identifier</b> property. A <b>NULL</b> pointer clears the
    ///                 <b>identifier</b> property.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetIdentifier(const(wchar)* identifier);
    ///Gets the <b>keywords</b> property.
    ///Params:
    ///    keywords = The string that is read from the <b>keywords</b> property.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>keywords</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetKeywords(ushort** keywords);
    ///Sets the <b>keywords</b> property.
    ///Params:
    ///    keywords = The string that contains the keywords to be written to the <b>keywords</b> property. A <b>NULL</b> pointer
    ///               clears the <b>keywords</b> property.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetKeywords(const(wchar)* keywords);
    ///Gets the <b>language</b> property.
    ///Params:
    ///    language = The value that is read from the <b>language</b> property.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>language</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetLanguage(ushort** language);
    ///Sets the <b>language</b> property.
    ///Params:
    ///    language = The string that contains the language value to be written to the <b>language</b> property. A <b>NULL</b>
    ///               pointer clears the <b>language</b> property.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetLanguage(const(wchar)* language);
    ///Gets the <b>lastModifiedBy</b> property.
    ///Params:
    ///    lastModifiedBy = The value that is read from the <b>lastModifiedBy</b> property.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>lastModifiedBy</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetLastModifiedBy(ushort** lastModifiedBy);
    ///Sets the <b>lastModifiedBy</b> property.
    ///Params:
    ///    lastModifiedBy = The string that contains the value to be written to the <b>lastModifiedBy</b> property. A <b>NULL</b> pointer
    ///                     clears the <b>lastModifiedBy</b> property.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetLastModifiedBy(const(wchar)* lastModifiedBy);
    ///Gets the <b>lastPrinted</b> property.
    ///Params:
    ///    lastPrinted = The date and time that are read from the <b>lastPrinted</b> property.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>lastPrinted</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetLastPrinted(SYSTEMTIME* lastPrinted);
    ///Sets the <b>lastPrinted</b> property.
    ///Params:
    ///    lastPrinted = The date and time the package was last printed. A <b>NULL</b> pointer clears the <b>lastPrinted</b> property.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>SetLastPrinted</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT SetLastPrinted(const(SYSTEMTIME)* lastPrinted);
    ///Gets the <b>modified</b> property.
    ///Params:
    ///    modified = The date and time that are read from the <b>modified</b> property.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>modified</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetModified(SYSTEMTIME* modified);
    ///Sets the <b>modified</b> property.
    ///Params:
    ///    modified = The date and time the package was last changed. A <b>NULL</b> pointer clears the <b>modified</b> property.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>modified</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT SetModified(const(SYSTEMTIME)* modified);
    ///Gets the <b>revision</b> property.
    ///Params:
    ///    revision = The string that is read from the <b>revision</b> property.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>revision</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetRevision(ushort** revision);
    ///Sets the <b>revision</b> property.
    ///Params:
    ///    revision = The string to be written to the <b>revision</b> property. A <b>NULL</b> pointer clears the <b>revision</b>
    ///               property.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetRevision(const(wchar)* revision);
    ///Gets the <b>subject</b> property.
    ///Params:
    ///    subject = The string that is read from the <b>subject</b> property.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>subject</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetSubject(ushort** subject);
    ///Sets the <b>subject</b> property.
    ///Params:
    ///    subject = The string to be written to the <b>subject</b> property. A <b>NULL</b> pointer clears the <b>subject</b>
    ///              property.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetSubject(const(wchar)* subject);
    ///Gets the <b>title</b> property.
    ///Params:
    ///    title = The string that is read from the <b>title</b> property.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>title</i> is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetTitle(ushort** title);
    ///Sets the <b>title</b> property.
    ///Params:
    ///    title = The string to be written to the <b>title</b> property. A <b>NULL</b> pointer clears the <b>title</b>
    ///            property.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetTitle(const(wchar)* title);
    ///Gets the <b>version</b> property.
    ///Params:
    ///    version = The string that is read from the <b>version</b> property.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>version</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetVersion(ushort** version_);
    ///Sets the <b>version</b> property.
    ///Params:
    ///    version = The string to be written to the <b>version</b> property. A <b>NULL</b> pointer clears the <b>version</b>
    ///              property.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetVersion(const(wchar)* version_);
    ///Makes a deep copy of the interface.
    ///Params:
    ///    coreProperties = A pointer to the copy of the interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory to perform this operation.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%">
    ///    <i>coreProperties</i> is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT Clone(IXpsOMCoreProperties* coreProperties);
}

///Provides the top-level entry into the XPS object model tree. Although this interface does not correspond to any XPS
///markup, it does correspond to the XPS document, and it is required to save the components of an XPS object model tree
///as an XPS document.
@GUID("18C3DF65-81E1-4674-91DC-FC452F5A416F")
interface IXpsOMPackage : IUnknown
{
    ///Gets a pointer to the IXpsOMDocumentSequence interface that contains the document sequence of the XPS package.
    ///Params:
    ///    documentSequence = A pointer to the IXpsOMDocumentSequence interface that contains the document sequence of the XPS package. If
    ///                       an <b>IXpsOMDocumentSequence</b> interface has not been set, a <b>NULL</b> pointer is returned.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>documentSequence</i> is <b>NULL</b>. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetDocumentSequence(IXpsOMDocumentSequence* documentSequence);
    ///Sets the IXpsOMDocumentSequence interface of the XPS package.
    ///Params:
    ///    documentSequence = The IXpsOMDocumentSequence interface pointer to be assigned to the package. This parameter must not be
    ///                       <b>NULL</b>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>documentSequence</i> is <b>NULL</b>. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>XPS_E_NO_CUSTOM_OBJECTS</b></dt> </dl> </td> <td width="60%">
    ///    <i>documentSequence</i> does not point to a recognized interface implementation. Custom implementation of XPS
    ///    Document API interfaces is not supported. </td> </tr> </table>
    ///    
    HRESULT SetDocumentSequence(IXpsOMDocumentSequence documentSequence);
    ///Gets a pointer to the IXpsOMCoreProperties interface of the XPS package.
    ///Params:
    ///    coreProperties = A pointer to the IXpsOMCoreProperties interface of the XPS package. If an <b>IXpsOMCoreProperties</b>
    ///                     interface has not been set, a <b>NULL</b> pointer is returned.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>coreProperties</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetCoreProperties(IXpsOMCoreProperties* coreProperties);
    ///Sets the IXpsOMCoreProperties interface of the XPS package.
    ///Params:
    ///    coreProperties = The IXpsOMCoreProperties interface pointer to be assigned to the package. A <b>NULL</b> pointer releases any
    ///                     previously assigned core properties interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>XPS_E_NO_CUSTOM_OBJECTS</b></dt> </dl> </td> <td width="60%"> <i>coreProperties</i> does not
    ///    point to a recognized interface implementation. Custom implementation of XPS Document API interfaces is not
    ///    supported. </td> </tr> </table>
    ///    
    HRESULT SetCoreProperties(IXpsOMCoreProperties coreProperties);
    ///Gets the name of the discard control part in the XPS package.
    ///Params:
    ///    discardControlPartUri = A pointer to the IOpcPartUri interface that contains the name of the discard control part in the XPS package.
    ///                            If a discard control part has not been set, a <b>NULL</b> pointer is returned.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>discardControlPartUri</i> is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetDiscardControlPartName(IOpcPartUri* discardControlPartUri);
    ///Sets the name of the discard control part in the XPS package.
    ///Params:
    ///    discardControlPartUri = The IOpcPartUri interface that contains the name of the discard control part to be assigned to the XPS
    ///                            package. A <b>NULL</b> pointer releases any previously assigned discard control part.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetDiscardControlPartName(IOpcPartUri discardControlPartUri);
    ///Gets a pointer to the IXpsOMImageResource interface of the thumbnail resource that is associated with the XPS
    ///package.
    ///Params:
    ///    imageResource = A pointer to the IXpsOMImageResource interface of the thumbnail resource that is associated with the XPS
    ///                    package. If the package does not have a thumbnail resource, a <b>NULL</b> pointer is returned.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>imageResource</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetThumbnailResource(IXpsOMImageResource* imageResource);
    ///Sets the thumbnail image of the XPS document.
    ///Params:
    ///    imageResource = The IXpsOMImageResource interface that contains the thumbnail image that will be assigned to the package. A
    ///                    <b>NULL</b> pointer releases any previously assigned thumbnail image resources.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>XPS_E_INVALID_THUMBNAIL_IMAGE_TYPE</b></dt> </dl> </td> <td width="60%"> The image in
    ///    <i>imageResource</i> is not a supported image type. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>XPS_E_NO_CUSTOM_OBJECTS</b></dt> </dl> </td> <td width="60%"> <i>imageResource</i> does not point to a
    ///    recognized interface implementation. Custom implementation of XPS Document API interfaces is not supported.
    ///    </td> </tr> </table>
    ///    
    HRESULT SetThumbnailResource(IXpsOMImageResource imageResource);
    ///Writes the XPS package to a specified file.
    ///Params:
    ///    fileName = The name of the file to be created. This parameter must not be <b>NULL</b>.
    ///    securityAttributes = The SECURITY_ATTRIBUTES structure, which contains two distinct but related data members: <ul>
    ///                         <li><b>lpSecurityDescriptor</b>: an optional security descriptor</li> <li><b>bInheritHandle</b>: a Boolean
    ///                         value that determines whether the returned handle can be inherited by child processes</li> </ul> If
    ///                         <b>lpSecurityDescriptor</b> is <b>NULL</b>, the file or device that is associated with the returned handle
    ///                         will be assigned a default security descriptor. For more information about the <i>securityAttributes</i>
    ///                         parameter, refer to CreateFile.
    ///    flagsAndAttributes = Specifies the settings and attributes of the file to be created. For most files, a value of
    ///                         <b>FILE_ATTRIBUTE_NORMAL</b> can be used. For more information about the <i>flagsAndAttributes</i> parameter,
    ///                         refer to CreateFile.
    ///    optimizeMarkupSize = A Boolean value that indicates whether the document markup is to be optimized for size when it is written to
    ///                         the file. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TRUE"></a><a
    ///                         id="true"></a><dl> <dt><b><b>TRUE</b></b></dt> </dl> </td> <td width="60%"> The package writer will attempt
    ///                         to optimize the markup for minimum size. </td> </tr> <tr> <td width="40%"><a id="FALSE"></a><a
    ///                         id="false"></a><dl> <dt><b><b>FALSE</b></b></dt> </dl> </td> <td width="60%"> The package writer will not
    ///                         attempt any optimization. </td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>fileName</i> is <b>NULL</b>. </td> </tr>
    ///    </table> This method calls the Packaging API. For information about the Packaging API return values, see
    ///    Packaging Errors.
    ///    
    HRESULT WriteToFile(const(wchar)* fileName, SECURITY_ATTRIBUTES* securityAttributes, uint flagsAndAttributes, 
                        BOOL optimizeMarkupSize);
    ///Writes the XPS package to a specified stream.
    ///Params:
    ///    stream = The stream that receives the serialized contents of the package. This parameter must not be <b>NULL</b>.
    ///    optimizeMarkupSize = A Boolean value that indicates whether the document markup is to be optimized for size when it is written to
    ///                         the stream. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TRUE"></a><a
    ///                         id="true"></a><dl> <dt><b><b>TRUE</b></b></dt> </dl> </td> <td width="60%"> The package writer will attempt
    ///                         to optimize the markup for minimum size. </td> </tr> <tr> <td width="40%"><a id="FALSE"></a><a
    ///                         id="false"></a><dl> <dt><b><b>FALSE</b></b></dt> </dl> </td> <td width="60%"> The package writer will not
    ///                         attempt any optimization. </td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>stream</i> is <b>NULL</b>. </td> </tr>
    ///    </table> This method calls the Packaging API. For information about the Packaging API return values, see
    ///    Packaging Errors.
    ///    
    HRESULT WriteToStream(ISequentialStream stream, BOOL optimizeMarkupSize);
}

///Creates objects in the XPS document object model.
@GUID("F9B2A685-A50D-4FC2-B764-B56E093EA0CA")
interface IXpsOMObjectFactory : IUnknown
{
    ///Creates an IXpsOMPackage interface that serves as the root node of an XPS object model document tree.
    ///Params:
    ///    package = A pointer to the new IXpsOMPackage interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>package</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT CreatePackage(IXpsOMPackage* package_);
    ///Opens an XPS package file and returns an instantiated XPS document object tree.
    ///Params:
    ///    filename = The name of the XPS package file.
    ///    reuseObjects = A Boolean value that indicates whether the software is to attempt to optimize the document object tree by
    ///                   sharing objects that are identical in all properties and children. <table> <tr> <th>Value</th>
    ///                   <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TRUE"></a><a id="true"></a><dl>
    ///                   <dt><b><b>TRUE</b></b></dt> </dl> </td> <td width="60%"> The software will attempt to optimize the object
    ///                   tree. </td> </tr> <tr> <td width="40%"><a id="FALSE"></a><a id="false"></a><dl> <dt><b><b>FALSE</b></b></dt>
    ///                   </dl> </td> <td width="60%"> The software will not attempt to optimize the object tree. </td> </tr> </table>
    ///    package = A pointer to the new IXpsOMPackage interface that contains the resulting XPS document object tree.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>filename</i> or <i>package</i> is <b>NULL</b>.
    ///    </td> </tr> </table> This method calls the Packaging API. For information about the Packaging API return
    ///    values, see Packaging Errors.
    ///    
    HRESULT CreatePackageFromFile(const(wchar)* filename, BOOL reuseObjects, IXpsOMPackage* package_);
    ///Opens a stream that contains an XPS package, and returns an instantiated XPS document object tree.
    ///Params:
    ///    stream = The stream that contains an XPS package.
    ///    reuseObjects = The Boolean value that indicates that the software is to attempt to optimize the document object tree by
    ///                   sharing objects that are identical in all properties and children. <table> <tr> <th>Value</th>
    ///                   <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TRUE"></a><a id="true"></a><dl>
    ///                   <dt><b><b>TRUE</b></b></dt> </dl> </td> <td width="60%"> The software will attempt to optimize the object
    ///                   tree. </td> </tr> <tr> <td width="40%"><a id="FALSE"></a><a id="false"></a><dl> <dt><b><b>FALSE</b></b></dt>
    ///                   </dl> </td> <td width="60%"> The software will not attempt to optimize the object tree. </td> </tr> </table>
    ///    package = A pointer to the new IXpsOMPackage interface that contains the resulting XPS document object tree.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>stream</i> or <i>package</i> is <b>NULL</b>.
    ///    </td> </tr> </table> This method calls the Packaging API. For information about the Packaging API return
    ///    values, see Packaging Errors.
    ///    
    HRESULT CreatePackageFromStream(IStream stream, BOOL reuseObjects, IXpsOMPackage* package_);
    ///Creates an IXpsOMStoryFragmentsResource interface that provides access to the content of the resource stream of a
    ///page's StoryFragments part.
    ///Params:
    ///    acquiredStream = The read-only IStream interface to be associated with this StoryFragments resource. <div
    ///                     class="alert"><b>Important</b> Treat this stream as a Single-Threaded Apartment (STA) object; do not re-enter
    ///                     it.</div> <div> </div>
    ///    partUri = The IOpcPartUri interface that contains the part name to be assigned to this resource.
    ///    storyFragmentsResource = A pointer to the new IXpsOMStoryFragmentsResource interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>acquiredStream</i>, <i>partUri</i>, or
    ///    <i>storyFragmentsResource</i> is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT CreateStoryFragmentsResource(IStream acquiredStream, IOpcPartUri partUri, 
                                         IXpsOMStoryFragmentsResource* storyFragmentsResource);
    ///Creates an IXpsOMDocumentStructureResource interface, which provides access to the document structure resource
    ///stream.
    ///Params:
    ///    acquiredStream = The read-only IStream interface to be associated with this resource. This parameter must not be <b>NULL</b>.
    ///                     <div class="alert"><b>Important</b> Treat this stream as a Single-Threaded Apartment (STA) object; do not
    ///                     re-enter it.</div> <div> </div>
    ///    partUri = The IOpcPartUri interface that contains the part name to be assigned to this resource. This parameter must
    ///              not be <b>NULL</b>.
    ///    documentStructureResource = A pointer to the new IXpsOMDocumentStructureResource interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>acquiredStream</i>, <i>partUri</i>, or
    ///    <i>documentStructureResource</i> is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT CreateDocumentStructureResource(IStream acquiredStream, IOpcPartUri partUri, 
                                            IXpsOMDocumentStructureResource* documentStructureResource);
    ///Creates an IXpsOMSignatureBlockResource that can contain one or more signature requests.
    ///Params:
    ///    acquiredStream = A read-only stream to be associated with this resource.
    ///    partUri = A pointer to the IOpcPartUri interface that contains the part name to be assigned to this resource.
    ///    signatureBlockResource = A pointer to the new IXpsOMSignatureBlockResource interface created by this method.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>acquiredStream</i>, <i>partUri</i>, or
    ///    <i>signatureBlockResource</i> is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT CreateSignatureBlockResource(IStream acquiredStream, IOpcPartUri partUri, 
                                         IXpsOMSignatureBlockResource* signatureBlockResource);
    ///Creates an IXpsOMRemoteDictionaryResource interface that enables the sharing of property resources.
    ///Params:
    ///    dictionary = The IXpsOMDictionary interface pointer of the dictionary to be associated with this resource.
    ///    partUri = The IOpcPartUri interface that contains the part name to be assigned to this resource.
    ///    remoteDictionaryResource = A pointer to the new IXpsOMRemoteDictionaryResource interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>dictionary</i>, <i>partUri</i>, or
    ///    <i>remoteDictionaryResource</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>XPS_E_NO_CUSTOM_OBJECTS</b></dt> </dl> </td> <td width="60%"> <i>dictionary</i> does not point to a
    ///    recognized interface implementation. Custom implementation of XPS Document API interfaces is not supported.
    ///    </td> </tr> </table>
    ///    
    HRESULT CreateRemoteDictionaryResource(IXpsOMDictionary dictionary, IOpcPartUri partUri, 
                                           IXpsOMRemoteDictionaryResource* remoteDictionaryResource);
    ///Loads the remote resource dictionary markup into an unrooted IXpsOMRemoteDictionaryResource interface.
    ///Params:
    ///    dictionaryMarkupStream = The <b>IStream</b> interface that contains the remote resource dictionary markup.
    ///    dictionaryPartUri = The IOpcPartUri interface that contains the part name to be assigned to this resource.
    ///    resources = The IXpsOMPartResources interface for the part resources of the dictionary resource objects that have
    ///                streams.
    ///    dictionaryResource = A pointer to the new IXpsOMRemoteDictionaryResource interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>dictionaryMarkupStream</i>,
    ///    <i>dictionaryPartUri</i>, <i>resources</i>, or <i>dictionaryResource</i> is <b>NULL</b>. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>XPS_E_NO_CUSTOM_OBJECTS</b></dt> </dl> </td> <td width="60%"> <i>resources</i> does
    ///    not point to a recognized interface implementation. Custom implementation of XPS Document API interfaces is
    ///    not supported. </td> </tr> </table>
    ///    
    HRESULT CreateRemoteDictionaryResourceFromStream(IStream dictionaryMarkupStream, IOpcPartUri dictionaryPartUri, 
                                                     IXpsOMPartResources resources, 
                                                     IXpsOMRemoteDictionaryResource* dictionaryResource);
    ///Creates an IXpsOMPartResources interface that can contain part-based resources.
    ///Params:
    ///    partResources = A pointer to the new IXpsOMPartResources interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>partResources</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT CreatePartResources(IXpsOMPartResources* partResources);
    ///Creates an IXpsOMDocumentSequence interface, which can contain the IXpsOMDocument interfaces of the XPS document.
    ///Params:
    ///    partUri = A pointer to the IOpcPartUri interface that contains the part name to be assigned to this resource. This
    ///              parameter must not be <b>NULL</b>.
    ///    documentSequence = A pointer to the new IXpsOMDocumentSequence interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>partUri</i> or <i>documentSequence</i> is
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT CreateDocumentSequence(IOpcPartUri partUri, IXpsOMDocumentSequence* documentSequence);
    ///Creates an IXpsOMDocument interface, which can contain a set of IXpsOMPageReference interfaces in an ordered
    ///sequence.
    ///Params:
    ///    partUri = The IOpcPartUri interface that contains the part name to be assigned to this resource. This parameter must
    ///              not be <b>NULL</b>.
    ///    document = A pointer to the new IXpsOMDocument interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>partUri</i> or <i>document</i> is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT CreateDocument(IOpcPartUri partUri, IXpsOMDocument* document);
    ///Creates an IXpsOMPageReference interface that enables the virtualization of pages.
    ///Params:
    ///    advisoryPageDimensions = The XPS_SIZE structure that sets the advisory page dimensions (page width and page height). Size is described
    ///                             in XPS units. There are 96 XPS units per inch. For example, the dimensions of an 8.5" by 11.0" page are 816
    ///                             by 1,056 XPS units.
    ///    pageReference = A pointer to the new IXpsOMPageReference interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>advisoryPageDimensions</i> or
    ///    <i>pageReference</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>XPS_E_INVALID_PAGE_SIZE</b></dt> </dl> </td> <td width="60%"> <i>advisoryPageDimensions</i> contains
    ///    an invalid page size or invalid page size values. </td> </tr> </table>
    ///    
    HRESULT CreatePageReference(const(XPS_SIZE)* advisoryPageDimensions, IXpsOMPageReference* pageReference);
    ///Creates an IXpsOMPage interface, which provides the root node of a tree of objects that represent the contents of
    ///a single page.
    ///Params:
    ///    pageDimensions = The XPS_SIZE structure that specifies the size of the page to be created. Size is described in XPS units.
    ///                     There are 96 XPS units per inch. For example, the dimensions of an 8.5" by 11.0" page are 816 by 1,056 XPS
    ///                     units.
    ///    language = The string that indicates the default language of the created page. <div class="alert"><b>Important</b> The
    ///               language string must follow the RFC 3066 syntax.</div> <div> </div>
    ///    partUri = The IOpcPartUri interface that contains the part name to be assigned to this resource.
    ///    page = A pointer to the new IXpsOMPage interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>pageDimensions</i>, <i>partUri</i>, or
    ///    <i>page</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>XPS_E_INVALID_LANGUAGE</b></dt>
    ///    </dl> </td> <td width="60%"> <i>language</i> does not contain a valid language string. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>XPS_E_INVALID_PAGE_SIZE</b></dt> </dl> </td> <td width="60%"> <i>pageDimensions</i>
    ///    contains an invalid page size or invalid page size values. </td> </tr> </table>
    ///    
    HRESULT CreatePage(const(XPS_SIZE)* pageDimensions, const(wchar)* language, IOpcPartUri partUri, 
                       IXpsOMPage* page);
    ///Reads the page markup from the specified stream to create and populate an IXpsOMPage interface.
    ///Params:
    ///    pageMarkupStream = The stream that contains the page markup.
    ///    partUri = The IOpcPartUri interface that contains the page's URI.
    ///    resources = The IXpsOMPartResources interface that contains the resources used by the page.
    ///    reuseObjects = A Boolean value that specifies whether the software is to attempt to optimize the page contents tree by
    ///                   sharing objects that are identical in all properties and children. <table> <tr> <th>Value</th>
    ///                   <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TRUE"></a><a id="true"></a><dl>
    ///                   <dt><b><b>TRUE</b></b></dt> </dl> </td> <td width="60%"> The software will attempt to optimize the object
    ///                   tree. </td> </tr> <tr> <td width="40%"><a id="FALSE"></a><a id="false"></a><dl> <dt><b><b>FALSE</b></b></dt>
    ///                   </dl> </td> <td width="60%"> The software will not attempt to optimize the object tree. </td> </tr> </table>
    ///    page = A pointer to the new IXpsOMPage interface created by this method.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>pageMarkupStream</i>, <i>partUri</i>,
    ///    <i>resources</i>, or <i>page</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>XPS_E_NO_CUSTOM_OBJECTS</b></dt> </dl> </td> <td width="60%"> <i>resources</i> does not point to a
    ///    recognized interface implementation. Custom implementation of XPS Document API interfaces is not supported.
    ///    </td> </tr> </table> This method calls the Packaging API. For information about the Packaging API return
    ///    values, see Packaging Errors.
    ///    
    HRESULT CreatePageFromStream(IStream pageMarkupStream, IOpcPartUri partUri, IXpsOMPartResources resources, 
                                 BOOL reuseObjects, IXpsOMPage* page);
    ///Creates an IXpsOMCanvas interface that is used to group page elements.
    ///Params:
    ///    canvas = A pointer to the new IXpsOMCanvas interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>canvas</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT CreateCanvas(IXpsOMCanvas* canvas);
    ///Creates an IXpsOMGlyphs interface, which specifies text that appears on a page.
    ///Params:
    ///    fontResource = A pointer to the IXpsOMFontResource interface of the font resource to be used.
    ///    glyphs = The new IXpsOMGlyphs interface pointer.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>fontResource</i> or <i>glyphs</i> is
    ///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>XPS_E_NO_CUSTOM_OBJECTS</b></dt> </dl> </td> <td
    ///    width="60%"> <i>fontResource</i> does not point to a recognized interface implementation. Custom
    ///    implementation of XPS Document API interfaces is not supported. </td> </tr> </table>
    ///    
    HRESULT CreateGlyphs(IXpsOMFontResource fontResource, IXpsOMGlyphs* glyphs);
    ///Creates an IXpsOMPath interface that specifies a graphical path element on a page.
    ///Params:
    ///    path = A pointer to the new IXpsOMPath interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>path</i> is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT CreatePath(IXpsOMPath* path);
    ///Creates an IXpsOMGeometry interface, which specifies the shape of a path or of a clipping region.
    ///Params:
    ///    geometry = A pointer to the new IXpsOMGeometry interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>geometry</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT CreateGeometry(IXpsOMGeometry* geometry);
    ///Creates an IXpsOMGeometryFigure interface, which specifies a portion of an object that is defined by an
    ///IXpsOMGeometry interface.
    ///Params:
    ///    startPoint = The coordinates of the starting point of the geometry figure.
    ///    figure = A pointer to the new IXpsOMGeometryFigure interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>startPoint</i> or <i>figure</i> is
    ///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>XPS_E_INVALID_FLOAT </b></dt> </dl> </td> <td
    ///    width="60%"> One of the fields in the XPS_POINT structure that is passed in <i>startPoint</i> contains a
    ///    value that is not valid. </td> </tr> </table>
    ///    
    HRESULT CreateGeometryFigure(const(XPS_POINT)* startPoint, IXpsOMGeometryFigure* figure);
    ///Creates an IXpsOMMatrixTransform interface that specifies an affine matrix transform.
    ///Params:
    ///    matrix = The initial matrix to be assigned to the transform.
    ///    transform = A pointer to the new IXpsOMMatrixTransform interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>matrix</i> or <i>transform</i> is <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT CreateMatrixTransform(const(XPS_MATRIX)* matrix, IXpsOMMatrixTransform* transform);
    ///Creates an IXpsOMSolidColorBrush interface, which specifies a brush of a single, solid color.
    ///Params:
    ///    color = The XPS_COLOR structure that specifies the brush color.
    ///    colorProfile = The IXpsOMColorProfileResource interface. Unless the color type is XPS_COLOR_TYPE_CONTEXT, this value must be
    ///                   <b>NULL</b>.
    ///    solidColorBrush = A pointer to the new IXpsOMSolidColorBrush interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>color</i> or <i>solidColorBrush</i> is
    ///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>XPS_E_MISSING_COLORPROFILE</b></dt> </dl> </td>
    ///    <td width="60%"> <i>colorProfile</i> is <b>NULL</b> when a color profile is expected. A color profile is
    ///    required when the color type is XPS_COLOR_TYPE_CONTEXT. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>XPS_E_NO_CUSTOM_OBJECTS</b></dt> </dl> </td> <td width="60%"> <i>colorProfile</i> does not point to a
    ///    recognized interface implementation. Custom implementation of XPS Document API interfaces is not supported.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>XPS_E_UNEXPECTED_COLORPROFILE</b></dt> </dl> </td> <td
    ///    width="60%"> <i>colorProfile</i> contains a color profile when one is not expected. A color profile is
    ///    required only when the color type is XPS_COLOR_TYPE_CONTEXT. </td> </tr> </table>
    ///    
    HRESULT CreateSolidColorBrush(const(XPS_COLOR)* color, IXpsOMColorProfileResource colorProfile, 
                                  IXpsOMSolidColorBrush* solidColorBrush);
    ///Creates an IXpsOMColorProfileResource interface, which is used to access a color profile resource stream.
    ///Params:
    ///    acquiredStream = The read-only IStream interface to be associated with this resource. This parameter must not be <b>NULL</b>.
    ///                     <div class="alert"><b>Important</b> Treat this stream as a Single-Threaded Apartment (STA) object; do not
    ///                     re-enter it.</div> <div> </div>
    ///    partUri = The IOpcPartUri interface that contains the part name to be assigned to this resource.
    ///    colorProfileResource = A pointer to the new IXpsOMColorProfileResource interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>acquiredStream</i>, <i>partUri</i>, or
    ///    <i>colorProfileResource</i> is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT CreateColorProfileResource(IStream acquiredStream, IOpcPartUri partUri, 
                                       IXpsOMColorProfileResource* colorProfileResource);
    ///Creates an IXpsOMImageBrush interface.
    ///Params:
    ///    image = The IXpsOMImageResource interface that contains the image to be used as the source image of the brush.
    ///    viewBox = The XPS_RECT structure that defines the <i>viewbox</i>, which is the area of the source image that is used by
    ///              the brush.
    ///    viewPort = The XPS_RECT structure that defines the <i>viewport</i>, which is the area covered by the first tile in the
    ///               output area.
    ///    imageBrush = A pointer to the new IXpsOMImageBrush interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>image</i>, <i>viewBox</i>, <i>viewPort</i>, or
    ///    <i>imageBrush</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl>
    ///    </td> <td width="60%"> <i>viewBox</i> or <i>viewPort</i> contains a rectangle or value that is not valid.
    ///    </td> </tr> </table>
    ///    
    HRESULT CreateImageBrush(IXpsOMImageResource image, const(XPS_RECT)* viewBox, const(XPS_RECT)* viewPort, 
                             IXpsOMImageBrush* imageBrush);
    ///Creates an IXpsOMVisualBrush interface, which is an IXpsOMTileBrush that uses a visual object.
    ///Params:
    ///    viewBox = The XPS_RECT structure that specifies the source image's area to be used in the brush. This parameter must
    ///              not be <b>NULL</b>.
    ///    viewPort = The XPS_RECT structure that specifies the destination geometry area of the tile. This parameter must not be
    ///               <b>NULL</b>.
    ///    visualBrush = A pointer to the new IXpsOMVisualBrush interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>viewBox</i>, <i>viewPort</i>, or
    ///    <i>visualBrush</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl>
    ///    </td> <td width="60%"> <i>viewBox</i> or <i>viewPort</i> contains an invalid rectangle or value. </td> </tr>
    ///    </table>
    ///    
    HRESULT CreateVisualBrush(const(XPS_RECT)* viewBox, const(XPS_RECT)* viewPort, IXpsOMVisualBrush* visualBrush);
    ///Creates an IXpsOMImageResource interface, which is used to access an image resource stream.
    ///Params:
    ///    acquiredStream = The read-only stream to be associated with this resource. This parameter must not be <b>NULL</b>. <div
    ///                     class="alert"><b>Important</b> Treat this stream as a Single-Threaded Apartment (STA) object; do not re-enter
    ///                     it.</div> <div> </div>
    ///    contentType = The XPS_IMAGE_TYPE value that describes the image type of the stream that is referenced by
    ///                  <i>acquiredStream</i>.
    ///    partUri = The IOpcPartUri interface that contains the part name to be assigned to this resource. This parameter must
    ///              not be <b>NULL</b>.
    ///    imageResource = A pointer to the new IXpsOMImageResource interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>contentType</i> was not a valid
    ///    XPS_IMAGE_TYPE value. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> <i>acquiredStream</i>, <i>partUri</i>, or <i>imageResource</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT CreateImageResource(IStream acquiredStream, XPS_IMAGE_TYPE contentType, IOpcPartUri partUri, 
                                IXpsOMImageResource* imageResource);
    ///Creates an IXpsOMPrintTicketResource interface that enables access to a PrintTicket stream.
    ///Params:
    ///    acquiredStream = The read-only PrintTicket resource stream. <div class="alert"><b>Important</b> Treat this stream as a
    ///                     Single-Threaded Apartment (STA) object; do not re-enter it.</div> <div> </div>
    ///    partUri = The IOpcPartUri interface that contains the part name to be assigned to this resource.
    ///    printTicketResource = A pointer to the new IXpsOMPrintTicketResource interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>acquiredStream</i>, <i>partUri</i>, or
    ///    <i>printTicketResource</i> is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT CreatePrintTicketResource(IStream acquiredStream, IOpcPartUri partUri, 
                                      IXpsOMPrintTicketResource* printTicketResource);
    ///Creates an IXpsOMFontResource interface, which provides an IStream interface to the font resource.
    ///Params:
    ///    acquiredStream = The read-only IStream interface to be associated with this font resource. This parameter must not be
    ///                     <b>NULL</b>. <div class="alert"><b>Important</b> Treat this stream as a Single-Threaded Apartment (STA)
    ///                     object; do not re-enter it.</div> <div> </div> <div class="alert"><b>Caution</b> This stream is not to be
    ///                     obfuscated.</div> <div> </div>
    ///    fontEmbedding = The XPS_FONT_EMBEDDING value that specifies the stream's embedding option.
    ///    partUri = The IOpcPartUri interface that contains the part name to be assigned to this resource. This parameter must
    ///              not be <b>NULL</b>.
    ///    isObfSourceStream = A Boolean value that indicates whether the stream referenced by <i>acquiredStream</i> is obfuscated. <table>
    ///                        <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TRUE"></a><a id="true"></a><dl>
    ///                        <dt><b><b>TRUE</b></b></dt> </dl> </td> <td width="60%"> The stream referenced by <i>acquiredStream</i> is
    ///                        obfuscated. </td> </tr> <tr> <td width="40%"><a id="FALSE"></a><a id="false"></a><dl>
    ///                        <dt><b><b>FALSE</b></b></dt> </dl> </td> <td width="60%"> The stream referenced by <i>acquiredStream</i> is
    ///                        not obfuscated. </td> </tr> </table>
    ///    fontResource = A pointer to the new IXpsOMFontResource interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the following errors has occurred: <ul>
    ///    <li><i>fontEmbedding</i> is not a valid XPS_FONT_EMBEDDING value.</li> <li><i>fontEmbedding</i> is
    ///    XPS_FONT_EMBEDDING_NORMAL and <i>isObfSourceStream</i> is <b>TRUE</b>.</li> </ul> </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>acquiredStream</i>,
    ///    <i>partUri</i>, or <i>fontResource</i> is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT CreateFontResource(IStream acquiredStream, XPS_FONT_EMBEDDING fontEmbedding, IOpcPartUri partUri, 
                               BOOL isObfSourceStream, IXpsOMFontResource* fontResource);
    ///Creates an IXpsOMGradientStop interface to represent a single color and location definition within a gradient.
    ///Params:
    ///    color = The color value.
    ///    colorProfile = A pointer to the IXpsOMColorProfileResource interface that contains the color profile to be used. If the
    ///                   color type is not XPS_COLOR_TYPE_CONTEXT, this parameter must be <b>NULL</b>.
    ///    offset = The offset value. Valid range: 0.0–1.0
    ///    gradientStop = A pointer to the new IXpsOMGradientStop interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The value in <i>offset</i> is not valid. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>color</i> or
    ///    <i>gradientStop</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>XPS_E_MISSING_COLORPROFILE</b></dt> </dl> </td> <td width="60%"> <i>colorProfile</i> is <b>NULL</b>
    ///    but a color profile is expected. A color profile is required when the color type is XPS_COLOR_TYPE_CONTEXT.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>XPS_E_NO_CUSTOM_OBJECTS</b></dt> </dl> </td> <td width="60%">
    ///    <i>colorProfile</i> does not point to a recognized interface implementation. Custom implementation of XPS
    ///    Document API interfaces is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>XPS_E_UNEXPECTED_COLORPROFILE</b></dt> </dl> </td> <td width="60%"> <i>colorProfile</i> contains a
    ///    color profile but one is not expected. A color profile is only allowed when the color type is
    ///    XPS_COLOR_TYPE_CONTEXT. </td> </tr> </table>
    ///    
    HRESULT CreateGradientStop(const(XPS_COLOR)* color, IXpsOMColorProfileResource colorProfile, float offset, 
                               IXpsOMGradientStop* gradientStop);
    ///Creates an IXpsOMLinearGradientBrush interface.
    ///Params:
    ///    gradStop1 = The IXpsOMGradientStop interface that specifies the gradient properties at the beginning of the gradient's
    ///                vector. This parameter must not be <b>NULL</b>.
    ///    gradStop2 = The IXpsOMGradientStop interface that specifies the gradient properties at the end of the gradient's vector.
    ///                This parameter must not be <b>NULL</b>.
    ///    startPoint = The XPS_POINT structure that contains the coordinates of the start point in two-dimensional space.
    ///    endPoint = The XPS_POINT structure that contains the coordinates of the end point in two-dimensional space.
    ///    linearGradientBrush = A pointer to the new IXpsOMLinearGradientBrush interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The point specified by either
    ///    <i>startPoint</i> or <i>endPoint</i> was not valid. The members of the XPS_POINT structure must contain valid
    ///    and finite floating-point values. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl>
    ///    </td> <td width="60%"> <i>gradStop1</i>, <i>gradStop2</i>, <i>startPoint</i>, <i>figure</i>, or
    ///    <i>linearGradientBrush</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>XPS_E_NO_CUSTOM_OBJECTS</b></dt> </dl> </td> <td width="60%"> <i>gradStop1</i> or <i>gradStop1</i>
    ///    does not point to a recognized interface implementation. Custom implementation of XPS Document API interfaces
    ///    is not supported. </td> </tr> </table>
    ///    
    HRESULT CreateLinearGradientBrush(IXpsOMGradientStop gradStop1, IXpsOMGradientStop gradStop2, 
                                      const(XPS_POINT)* startPoint, const(XPS_POINT)* endPoint, 
                                      IXpsOMLinearGradientBrush* linearGradientBrush);
    ///Creates an IXpsOMRadialGradientBrush interface.
    ///Params:
    ///    gradStop1 = The IXpsOMGradientStop interface that specifies the properties of the gradient at gradient origin. This
    ///                parameter must not be <b>NULL</b>.
    ///    gradStop2 = The IXpsOMGradientStop interface that specifies the properties of the gradient at the end of the gradient's
    ///                vector, which is the ellipse that encloses the gradient region. This parameter must not be <b>NULL</b>.
    ///    centerPoint = The coordinates of the center point of the radial gradient ellipse.
    ///    gradientOrigin = The coordinates of the origin of the radial gradient.
    ///    radiiSizes = The XPS_SIZE structure whose members specify the lengths of the gradient region's radii. Size is described in
    ///                 XPS units. There are 96 XPS units per inch. For example, a 1" radius is 96 XPS units. <table> <tr> <th>
    ///                 XPS_SIZE Member</th> <th>Meaning</th> </tr> <tr> <td> <b>width</b> </td> <td> Length of the radius along the
    ///                 x-axis. </td> </tr> <tr> <td> <b>height</b> </td> <td> Length of the radius along the y-axis. </td> </tr>
    ///                 </table>
    ///    radialGradientBrush = A pointer to the new IXpsOMRadialGradientBrush interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The point that is described by
    ///    <i>centerPoint</i>, <i>radiiSizes</i>, or <i>gradientOrigin</i> is not valid. The members of the XPS_POINT
    ///    structure must contain valid and finite floating-point values. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>gradStop1</i>, <i>gradStop2</i>,
    ///    <i>centerPoint</i>, <i>gradientOrigin</i>, <i>radiiSizes</i>, or <i>radialGradientBrush</i> is <b>NULL</b>.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>XPS_E_NO_CUSTOM_OBJECTS</b></dt> </dl> </td> <td width="60%">
    ///    <i>gradStop1</i> or <i>gradStop1</i> does not point to a recognized interface implementation. Custom
    ///    implementation of XPS Document API interfaces is not supported. </td> </tr> </table>
    ///    
    HRESULT CreateRadialGradientBrush(IXpsOMGradientStop gradStop1, IXpsOMGradientStop gradStop2, 
                                      const(XPS_POINT)* centerPoint, const(XPS_POINT)* gradientOrigin, 
                                      const(XPS_SIZE)* radiiSizes, IXpsOMRadialGradientBrush* radialGradientBrush);
    ///Creates an IXpsOMCoreProperties interface, which contains the metadata that describes an XPS document.
    ///Params:
    ///    partUri = The IOpcPartUri interface that contains the part name to be assigned to this resource. This parameter must
    ///              not be <b>NULL</b>.
    ///    coreProperties = A pointer to the new IXpsOMCoreProperties interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>partUri</i> or <i>coreProperties</i> is
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT CreateCoreProperties(IOpcPartUri partUri, IXpsOMCoreProperties* coreProperties);
    ///Creates an IXpsOMDictionary interface, which enables the sharing of property resources.
    ///Params:
    ///    dictionary = A pointer to the new IXpsOMDictionary interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>dictionary</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT CreateDictionary(IXpsOMDictionary* dictionary);
    ///Creates an IXpsOMPartUriCollection interface that can contain IOpcPartUri interface pointers.
    ///Params:
    ///    partUriCollection = A pointer to the new IXpsOMPartUriCollection interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>partUriCollection</i> is <b>NULL</b>. </td>
    ///    </tr> </table>
    ///    
    HRESULT CreatePartUriCollection(IXpsOMPartUriCollection* partUriCollection);
    ///Opens a file for writing the contents of an XPS OM to an XPS package.
    ///Params:
    ///    fileName = The name of the file to be created.
    ///    securityAttributes = The SECURITY_ATTRIBUTES structure, which contains two separate but related members: <ul>
    ///                         <li><b>lpSecurityDescriptor</b>: an optional security descriptor</li> <li><b>bInheritHandle</b>: a Boolean
    ///                         value that determines whether the returned handle can be inherited by child processes</li> </ul> If
    ///                         <b>lpSecurityDescriptor</b> is <b>NULL</b>, the file or device associated with the returned handle is
    ///                         assigned a default security descriptor. For more information about <i>securityAttributes</i>, see CreateFile.
    ///    flagsAndAttributes = Specifies the settings and attributes of the file to be created. For most files, the
    ///                         <b>FILE_ATTRIBUTE_NORMAL</b> value can be used. See CreateFile for more information about this parameter.
    ///    optimizeMarkupSize = A Boolean value that indicates whether the document markup will be optimized for size when the contents of
    ///                         the XPS OM are written to the XPS package. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///                         width="40%"><a id="TRUE"></a><a id="true"></a><dl> <dt><b><b>TRUE</b></b></dt> </dl> </td> <td width="60%">
    ///                         The package writer will try to optimize the markup for minimum size. </td> </tr> <tr> <td width="40%"><a
    ///                         id="FALSE"></a><a id="false"></a><dl> <dt><b><b>FALSE</b></b></dt> </dl> </td> <td width="60%"> The package
    ///                         writer will not try to perform any optimization. </td> </tr> </table>
    ///    interleaving = Specifies whether the content of the XPS OM will be interleaved when it is written to the file.
    ///    documentSequencePartName = The IOpcPartUri interface that contains the part name of the document sequence in the new file.
    ///    coreProperties = The IXpsOMCoreProperties interface that contains the core document properties to be given to the new file.
    ///                     This parameter can be set to <b>NULL</b>.
    ///    packageThumbnail = The IXpsOMImageResource interface that contains the thumbnail image to be assigned to the new file. This
    ///                       parameter can be set to <b>NULL</b>.
    ///    documentSequencePrintTicket = The IXpsOMPrintTicketResource interface that contains the package-level print ticket to be assigned to the
    ///                                  new file. This parameter can be set to <b>NULL</b>.
    ///    discardControlPartName = The IOpcPartUri interface that contains the name of the discard control part. This parameter can be set to
    ///                             <b>NULL</b>.
    ///    packageWriter = A pointer to the new IXpsOMPackageWriter interface created by this method.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>filename</i>, <i>documentSequencePartName</i>,
    ///    or <i>packageWriter</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>XPS_E_NO_CUSTOM_OBJECTS</b></dt> </dl> </td> <td width="60%"> <i>coreProperties</i>,
    ///    <i>documentSequencePrintTicket</i>, or <i>packageThumbnail</i> does not point to a recognized interface
    ///    implementation. Custom implementation of XPS Document API interfaces is not supported. </td> </tr> </table>
    ///    This method calls the Packaging API. For information about the Packaging API return values, see Packaging
    ///    Errors.
    ///    
    HRESULT CreatePackageWriterOnFile(const(wchar)* fileName, SECURITY_ATTRIBUTES* securityAttributes, 
                                      uint flagsAndAttributes, BOOL optimizeMarkupSize, 
                                      XPS_INTERLEAVING interleaving, IOpcPartUri documentSequencePartName, 
                                      IXpsOMCoreProperties coreProperties, IXpsOMImageResource packageThumbnail, 
                                      IXpsOMPrintTicketResource documentSequencePrintTicket, 
                                      IOpcPartUri discardControlPartName, IXpsOMPackageWriter* packageWriter);
    ///Opens a stream for writing the contents of an XPS OM to an XPS package.
    ///Params:
    ///    outputStream = The stream to be used for writing.
    ///    optimizeMarkupSize = A Boolean value that indicates whether the document markup will be optimized for size when the document is
    ///                         written to the stream. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///                         id="TRUE"></a><a id="true"></a><dl> <dt><b><b>TRUE</b></b></dt> </dl> </td> <td width="60%"> When writing to
    ///                         the stream, the package writer will attempt to optimize the markup for minimum size. </td> </tr> <tr> <td
    ///                         width="40%"><a id="FALSE"></a><a id="false"></a><dl> <dt><b><b>FALSE</b></b></dt> </dl> </td> <td
    ///                         width="60%"> When writing to the package, the package writer will not attempt any optimization. </td> </tr>
    ///                         </table>
    ///    interleaving = Specifies whether the content of the XPS OM will be interleaved when it is written to the stream.
    ///    documentSequencePartName = The IOpcPartUri interface that contains the part name of the document sequence in the new file.
    ///    coreProperties = The IXpsOMCoreProperties interface that contains the core document properties to be given to the new file.
    ///                     This parameter can be set to <b>NULL</b>.
    ///    packageThumbnail = The IXpsOMImageResource interface that contains the thumbnail image to be assigned to the new file. This
    ///                       parameter can be set to <b>NULL</b>.
    ///    documentSequencePrintTicket = The IXpsOMPrintTicketResource interface that contains the package-level print ticket to be assigned to the
    ///                                  new file. This parameter can be set to <b>NULL</b>.
    ///    discardControlPartName = The IOpcPartUri interface that contains the name of the discard control part. This parameter can be set to
    ///                             <b>NULL</b>.
    ///    packageWriter = A pointer to the new IXpsOMPackageWriter interface created by this method.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>outputStream</i>,
    ///    <i>documentSequencePartName</i>, or <i>packageWriter</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>XPS_E_NO_CUSTOM_OBJECTS</b></dt> </dl> </td> <td width="60%"> <i>coreProperties</i>,
    ///    <i>documentSequencePrintTicket</i> or <i>packageThumbnail</i> does not point to a recognized interface
    ///    implementation. Custom implementation of XPS Document API interfaces is not supported. </td> </tr> </table>
    ///    This method calls the Packaging API. For information about the Packaging API return values, see Packaging
    ///    Errors.
    ///    
    HRESULT CreatePackageWriterOnStream(ISequentialStream outputStream, BOOL optimizeMarkupSize, 
                                        XPS_INTERLEAVING interleaving, IOpcPartUri documentSequencePartName, 
                                        IXpsOMCoreProperties coreProperties, IXpsOMImageResource packageThumbnail, 
                                        IXpsOMPrintTicketResource documentSequencePrintTicket, 
                                        IOpcPartUri discardControlPartName, IXpsOMPackageWriter* packageWriter);
    ///Creates an IOpcPartUri interface that uses the specified URI.
    ///Params:
    ///    uri = The URI string.
    ///    partUri = A pointer to the IOpcPartUri interface created by this method.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>partUri</i> is <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT CreatePartUri(const(wchar)* uri, IOpcPartUri* partUri);
    ///Creates a read-only IStream over the specified file.
    ///Params:
    ///    filename = The name of the file to be opened.
    ///    stream = A stream over the specified file.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>filename</i> or <i>stream</i> is <b>NULL</b>.
    ///    </td> </tr> </table> This method calls the Packaging API. For information about the Packaging API return
    ///    values, see Packaging Errors.
    ///    
    HRESULT CreateReadOnlyStreamOnFile(const(wchar)* filename, IStream* stream);
}

///A collection of name strings.
@GUID("4BDDF8EC-C915-421B-A166-D173D25653D2")
interface IXpsOMNameCollection : IUnknown
{
    ///Gets the number of name strings in the collection.
    ///Params:
    ///    count = The number of name strings in the collection.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetCount(uint* count);
    ///Gets the name string that is stored at a specified location in the collection.
    ///Params:
    ///    index = The zero-based index of the collection that contains the name string to be obtained.
    ///    name = The name string at the location specified by <i>index</i>.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetAt(uint index, ushort** name);
}

///A collection of IOpcPartUri interface pointers.
@GUID("57C650D4-067C-4893-8C33-F62A0633730F")
interface IXpsOMPartUriCollection : IUnknown
{
    ///Gets the number of IOpcPartUri interface pointers in the collection.
    ///Params:
    ///    count = The number of IOpcPartUri interface pointers in the collection.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetCount(uint* count);
    ///Gets an IOpcPartUri interface pointer from a specified location in the collection.
    ///Params:
    ///    index = The zero-based index of the IOpcPartUri interface pointer to be obtained.
    ///    partUri = The IOpcPartUri interface pointer at the location specified by <i>index</i>.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetAt(uint index, IOpcPartUri* partUri);
    ///Inserts an IOpcPartUri interface pointer at a specified location in the collection.
    ///Params:
    ///    index = The zero-based index of the collection where the interface pointer that is passed in <i>partUri</i> is to be
    ///            inserted.
    ///    partUri = The IOpcPartUri interface pointer that is to be inserted at the location specified by <i>index</i>.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT InsertAt(uint index, IOpcPartUri partUri);
    ///Removes and releases an IOpcPartUri interface pointer from a specified location in the collection.
    ///Params:
    ///    index = The zero-based index in the collection from which an IOpcPartUri interface pointer is to be removed and
    ///            released.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT RemoveAt(uint index);
    ///Replaces an IOpcPartUri interface pointer at a specified location in the collection.
    ///Params:
    ///    index = The zero-based index of the collection where an IOpcPartUri interface pointer is to be replaced.
    ///    partUri = The IOpcPartUri interface pointer that will replace current contents at the location specified by
    ///              <i>index</i>.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetAt(uint index, IOpcPartUri partUri);
    ///Appends an IOpcPartUri interface to the end of the collection.
    ///Params:
    ///    partUri = A pointer to the IOpcPartUri interface that is to be appended to the collection.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT Append(IOpcPartUri partUri);
}

///Incrementally writes the parts of an XPS document to a package file.
@GUID("4E2AA182-A443-42C6-B41B-4F8E9DE73FF9")
interface IXpsOMPackageWriter : IUnknown
{
    ///Opens and initializes a new FixedDocument in the FixedDocumentSequence of the package.
    ///Params:
    ///    documentPartName = A pointer to an IOpcPartUri interface that contains the part name of the new document.
    ///    documentPrintTicket = A pointer to an IXpsOMPrintTicketResource interface that contains the document-level print ticket. If there
    ///                          is no document-level print ticket for this package, this parameter can be set to <b>NULL</b>. See also
    ///                          Remarks.
    ///    documentStructure = A pointer to an IXpsOMDocumentStructureResource interface that contains the initial document structure
    ///                        resource, if the resource is available; if it is not available, this parameter can be set to <b>NULL</b>.
    ///    signatureBlockResources = A pointer to an IXpsOMSignatureBlockResourceCollection interface that contains a collection of digital
    ///                              signatures to be attached to the document. If there are no digital signatures to be attached, this parameter
    ///                              can be set to <b>NULL</b>.
    ///    restrictedFonts = A pointer to an IXpsOMPartUriCollection interface that contains the fonts that must have restricted font
    ///                      relationships written for them. The font data are not written until AddResource or Close is called. If the
    ///                      document does not contain any restricted fonts, this parameter can be set to <b>NULL</b>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>XPS_E_UNAVAILABLE_PACKAGE</b></dt> </dl> </td> <td width="60%"> A severe error occurred and the
    ///    contents of the XPS OM might be unrecoverable. Some components of the XPS OM might still be usable but only
    ///    after they have been verified. Because the state of the XPS OM cannot be predicted after this error is
    ///    returned, all components of the XPS OM should be released and discarded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>XPS_E_UNEXPECTED_RESTRICTED_FONT_RELATIONSHIP</b></dt> </dl> </td> <td width="60%"> The
    ///    restricted font collection passed in <i>restrictedFonts</i> contains an unrestricted font. </td> </tr>
    ///    </table> This method calls the Packaging API. For information about the Packaging API return values, see
    ///    Packaging Errors.
    ///    
    HRESULT StartNewDocument(IOpcPartUri documentPartName, IXpsOMPrintTicketResource documentPrintTicket, 
                             IXpsOMDocumentStructureResource documentStructure, 
                             IXpsOMSignatureBlockResourceCollection signatureBlockResources, 
                             IXpsOMPartUriCollection restrictedFonts);
    ///Writes a new FixedPage part to the currently open FixedDocument part in the package.
    ///Params:
    ///    page = The IXpsOMPage interface whose page content is to be written to the currently open FixedDocument of the
    ///           package.
    ///    advisoryPageDimensions = The XPS_SIZE structure that contains page dimensions. Size is described in XPS units. There are 96 XPS units
    ///                             per inch. For example, the dimensions of an 8.5" by 11.0" page are 816 by 1,056 XPS units.
    ///    discardableResourceParts = The IXpsOMPartUriCollection interface that contains a collection of the discardable resource parts.
    ///    storyFragments = The IXpsOMStoryFragmentsResource interface that is to be used for this page.
    ///    pagePrintTicket = The IXpsOMPrintTicketResource interface that contains the page-level print ticket for this page. See also
    ///                      Remarks.
    ///    pageThumbnail = The IXpsOMImageResource interface that contains the thumbnail image of this page.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>XPS_E_MISSING_DISCARDCONTROL</b></dt> </dl> </td> <td width="60%"> A page refers to discardable
    ///    resources but does not specify a DiscardControl part name. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>XPS_E_MISSING_DOCUMENT</b></dt> </dl> </td> <td width="60%"> This method was called before
    ///    StartNewDocument. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>XPS_E_UNAVAILABLE_PACKAGE</b></dt> </dl>
    ///    </td> <td width="60%"> A severe error occurred and the contents of the XPS OM might be unrecoverable. Some
    ///    components of the XPS OM might still be usable but only after they have been verified. Because the state of
    ///    the XPS OM cannot be predicted after this error is returned, all components of the XPS OM should be released
    ///    and discarded. </td> </tr> </table> This method calls the Packaging API. For information about the Packaging
    ///    API return values, see Packaging Errors.
    ///    
    HRESULT AddPage(IXpsOMPage page, const(XPS_SIZE)* advisoryPageDimensions, 
                    IXpsOMPartUriCollection discardableResourceParts, IXpsOMStoryFragmentsResource storyFragments, 
                    IXpsOMPrintTicketResource pagePrintTicket, IXpsOMImageResource pageThumbnail);
    ///Creates a new part resource in the package.
    ///Params:
    ///    resource = The IXpsOMResource interface of the part resource that will be added as a new part in the package. See
    ///               Remarks for the types of resources that may be passed in this parameter.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> A resource with the same name as the resource
    ///    that is referenced by <i>resource</i> has already been added to the stream or there is no relationship that
    ///    includes the resource that is referenced by <i>resource</i>. After <b>E_INVALIDARG</b> is returned, the
    ///    stream or file is no longer valid and Close will return <b>XPS_E_UNAVAILABLE_PACKAGE</b>. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>XPS_E_UNAVAILABLE_PACKAGE</b></dt> </dl> </td> <td width="60%"> A severe error
    ///    occurred and the contents of the XPS OM might be unrecoverable. Some components of the XPS OM might still be
    ///    usable but only after they have been verified. Because the state of the XPS OM cannot be predicted after this
    ///    error is returned, all components of the XPS OM should be released and discarded. </td> </tr> </table> This
    ///    method calls the Packaging API. For information about the Packaging API return values, see Packaging Errors.
    ///    
    HRESULT AddResource(IXpsOMResource resource);
    ///Closes any open parts of the package, then closes the package.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>XPS_E_UNAVAILABLE_PACKAGE</b></dt> </dl> </td> <td width="60%"> A severe error occurred and the
    ///    contents of the XPS OM might be unrecoverable. Some components of the XPS OM might still be usable but only
    ///    after they have been verified. Because the state of the XPS OM cannot be predicted after this error is
    ///    returned, all components of the XPS OM should be released and discarded. </td> </tr> </table> This method
    ///    calls the Packaging API. For information about the Packaging API return values, see Packaging Errors.
    ///    
    HRESULT Close();
    ///Gets the status of the IXpsOMPackageWriter interface.
    ///Params:
    ///    isClosed = A pointer to a Boolean variable that receives the status of the IXpsOMPackageWriter interface. <table> <tr>
    ///               <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TRUE"></a><a id="true"></a><dl>
    ///               <dt><b>TRUE</b></dt> </dl> </td> <td width="60%"> The package is closed and no more content can be added.
    ///               </td> </tr> <tr> <td width="40%"><a id="FALSE"></a><a id="false"></a><dl> <dt><b>FALSE</b></dt> </dl> </td>
    ///               <td width="60%"> The package is open and content can be added. </td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>XPS_E_UNAVAILABLE_PACKAGE</b></dt> </dl> </td> <td width="60%"> A severe error occurred and the
    ///    contents of the XPS OM might be unrecoverable. Some components of the XPS OM might still be usable but only
    ///    after they have been verified. Because the state of the XPS OM cannot be predicted after this error is
    ///    returned, all components of the XPS OM should be released and discarded. </td> </tr> </table> This method
    ///    calls the Packaging API. For information about the Packaging API return values, see Packaging Errors.
    ///    
    HRESULT IsClosed(int* isClosed);
}

///Provides the method to create an IXpsOMPackageWriter that can be used by a print job that was created by the
///StartXpsPrintJob1 function.
@GUID("219A9DB0-4959-47D0-8034-B1CE84F41A4D")
interface IXpsOMPackageTarget : IUnknown
{
    ///Create an IXpsOMPackageWriter interface for use with a print job that the StartXpsPrintJob1 function created.
    ///Params:
    ///    documentSequencePartName = The IOpcPartUri interface that contains the part name of the document sequence in the new file.
    ///    documentSequencePrintTicket = The IXpsOMPrintTicketResource interface that contains the package-level print ticket to be assigned to the
    ///                                  new file. Set this parameter to <b>NULL</b> if you do not have a package-level print ticket.
    ///    discardControlPartName = The IOpcPartUri interface that contains the name of the discard control part. Set this parameter to
    ///                             <b>NULL</b> if you do not have a discard control part.
    ///    packageWriter = A pointer to the new IXpsOMPackageWriter interface that this method created.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>packageWriter</i> is <b>NULL</b>. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>XPS_E_NO_CUSTOM_OBJECTS</b></dt> </dl> </td> <td width="60%">
    ///    <i>documentSequencePrintTicket</i> does not point to a recognized interface implementation. Custom
    ///    implementation of XPS Document API interfaces is not supported. </td> </tr> </table> This method calls the
    ///    Packaging API. For information about the Packaging API return values, see Packaging Errors.
    ///    
    HRESULT CreateXpsOMPackageWriter(IOpcPartUri documentSequencePartName, 
                                     IXpsOMPrintTicketResource documentSequencePrintTicket, 
                                     IOpcPartUri discardControlPartName, IXpsOMPackageWriter* packageWriter);
}

///Generates a thumbnail image resource.
@GUID("15B873D5-1971-41E8-83A3-6578403064C7")
interface IXpsOMThumbnailGenerator : IUnknown
{
    ///Generates a thumbnail image of a page.
    ///Params:
    ///    page = A pointer to the IXpsOMPage interface that contains the page for which the thumbnail image will be created.
    ///    thumbnailType = The XPS_IMAGE_TYPE value that specifies the type of thumbnail image to create.
    ///    thumbnailSize = The XPS_THUMBNAIL_SIZE value that specifies the image size of the thumbnail to create.
    ///    imageResourcePartName = A pointer to the IOpcPartUri interface that contains the name of the new thumbnail image part.
    ///    imageResource = A pointer to the new IXpsOMImageResource interface that contains the thumbnail image created by this method.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>page</i>, <i>imageResourcePartName</i>, or
    ///    <i>imageResource</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt>
    ///    </dl> </td> <td width="60%"> One of the following parameters contains a value that is not valid: <ul>
    ///    <li><i>thumbnailType</i>: The image type must be PNG (XPS_IMAGE_TYPE_PNG) or JPEG
    ///    (<b>XPS_IMAGE_TYPE_JPEG</b>)</li> <li><i>thumbnailSize</i>: <i>thumbnailSize</i> must be a member of
    ///    XPS_THUMBNAIL_SIZE </li> </ul> </td> </tr> </table>
    ///    
    HRESULT GenerateThumbnail(IXpsOMPage page, XPS_IMAGE_TYPE thumbnailType, XPS_THUMBNAIL_SIZE thumbnailSize, 
                              IOpcPartUri imageResourcePartName, IXpsOMImageResource* imageResource);
}

///Inherits from IXpsOMObjectFactory. Adds support for: Detecting the type of an XPS package. Loading of an OpenXPS
///packages into an XPS object model. Saving an in-memory XPS Object model to an OpenXPS package. Converting HDPhoto
///resources into JpegXR resources.
@GUID("0A91B617-D612-4181-BF7C-BE5824E9CC8F")
interface IXpsOMObjectFactory1 : IXpsOMObjectFactory
{
    ///Detects the type of XPS document that is stored in the specified file.
    ///Params:
    ///    filename = [in] The name of the XPS file from which to get the type.
    ///    documentType = [out, retval] The document type.
    ///Returns:
    ///    Possible values include, but are not limited to, the following. For information about XPS document API return
    ///    values that are not listed here, see XPS Document Errors. S_OK: The document type is XPS_DOCUMENT_TYPE_ XPS
    ///    or XPS_DOCUMENT_TYPE_ OPENXPS.
    ///    
    HRESULT GetDocumentTypeFromFile(const(wchar)* filename, XPS_DOCUMENT_TYPE* documentType);
    ///Detects the type of XPS document that is stored in the specified stream.
    ///Params:
    ///    xpsDocumentStream = [in] A stream that contains XPS OM data. The stream must support sequential reading and the read position of
    ///                        the stream must be set to the beginning of the XPS data.
    ///    documentType = [out, retval] The document type of the XPS data found in the stream.
    ///Returns:
    ///    Possible values include, but are not limited to, the following. For information about XPS document API return
    ///    values that are not listed here, see XPS Document Errors. S_OK: The document type is XPS_DOCUMENT_TYPE_ XPS
    ///    or XPS_DOCUMENT_TYPE_ OPENXPS.
    ///    
    HRESULT GetDocumentTypeFromStream(IStream xpsDocumentStream, XPS_DOCUMENT_TYPE* documentType);
    ///Converts an image resource from an HD Photo to a JpegXR.
    ///Params:
    ///    imageResource = [in, out] The image resource to convert. When the method returns, the converted image resource.
    ///Returns:
    ///    Possible values include, but are not limited to, the following. For information about XPS document API return
    ///    values that are not listed here, see XPS Document Errors. S_OK: The method succeeded.
    ///    XPS_E_INVALID_CONTENT_TYPE: The image type is not XPS_IMAGE_TYPE_WDP. E_INVALIDARG: The image resource is not
    ///    recognized by the WDP decoder or another general error occurred.
    ///    
    HRESULT ConvertHDPhotoToJpegXR(IXpsOMImageResource imageResource);
    ///Converts an image resource from a JpegXR to an HD Photo.
    ///Params:
    ///    imageResource = [in, out] The image resource to convert. When the method returns, the converted image resource.
    ///Returns:
    ///    Possible values include, but are not limited to, the following. For information about XPS document API return
    ///    values that are not listed here, see XPS Document Errors. S_OK: The method succeeded.
    ///    XPS_E_INVALID_CONTENT_TYPE: The image type is not XPS_IMAGE_TYPE_JXR. E_INVALIDARG if data is not recognized
    ///    by WDP decoder or another error occurred.
    ///    
    HRESULT ConvertJpegXRToHDPhoto(IXpsOMImageResource imageResource);
    ///Opens a file for writing the contents of an XPS OM to an XPS package of a specified type. This method produces a
    ///package writer for either an MSXPS document or an OpenXPS document.
    ///Params:
    ///    fileName = [in] The name of the file to be created.
    ///    securityAttributes = [in, unique] The SECURITY_ATTRIBUTES structure, which contains two separate but related members: <ul>
    ///                         <li><b>lpSecurityDescriptor</b>: an optional security descriptor</li> <li><b>bInheritHandle</b>: a Boolean
    ///                         value that determines whether the returned handle can be inherited by child processes</li> </ul> If
    ///                         <b>lpSecurityDescriptor</b> is <b>NULL</b>, the file or device associated with the returned handle is
    ///                         assigned a default security descriptor. For more information about <i>securityAttributes</i>, see CreateFile.
    ///    flagsAndAttributes = [in] Specifies the settings and attributes of the file to be created. For most files, the
    ///                         <b>FILE_ATTRIBUTE_NORMAL</b> value can be used. See CreateFile for more information about this parameter.
    ///    optimizeMarkupSize = [in] A Boolean value that indicates whether the document markup will be optimized for size when the contents
    ///                         of the XPS OM are written to the XPS package. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///                         width="40%"><a id="TRUE"></a><a id="true"></a><dl> <dt><b><b>TRUE</b></b></dt> </dl> </td> <td width="60%">
    ///                         The package writer will try to optimize the markup for minimum size. </td> </tr> <tr> <td width="40%"><a
    ///                         id="FALSE"></a><a id="false"></a><dl> <dt><b><b>FALSE</b></b></dt> </dl> </td> <td width="60%"> The package
    ///                         writer will not try to perform any optimization. </td> </tr> </table>
    ///    interleaving = [in] Specifies whether the content of the XPS OM will be interleaved when it is written to the file.
    ///    documentSequencePartName = [in] The IOpcPartUri interface that contains the part name of the document sequence in the new file.
    ///    coreProperties = [in] The IXpsOMCoreProperties interface that contains the core document properties to be given to the new
    ///                     file. This parameter can be set to <b>NULL</b>.
    ///    packageThumbnail = [in] The IXpsOMImageResource interface that contains the thumbnail image to be assigned to the new file. This
    ///                       parameter can be set to <b>NULL</b>.
    ///    documentSequencePrintTicket = [in] The IXpsOMPrintTicketResource interface that contains the package-level print ticket to be assigned to
    ///                                  the new file. This parameter can be set to <b>NULL</b>.
    ///    discardControlPartName = [in] The IOpcPartUri interface that contains the name of the discard control part. This parameter can be set
    ///                             to <b>NULL</b>.
    ///    documentType = [in] Specifies the document type of the package writer. The value of this parameter cannot be
    ///                   XPS_DOCUMENT_TYPE_UNSPECIFIED.
    ///    packageWriter = [out, retval] A pointer to the new IXpsOMPackageWriter interface created by this method.
    ///Returns:
    ///    Possible values include, but are not limited to, the following. For information about XPS document API return
    ///    values that are not listed here, see XPS Document Errors. S_OK: The method succeeded and packageWriter was
    ///    set correctly. E_INVALIDARG: The document type was not a valid XPS document format.
    ///    
    HRESULT CreatePackageWriterOnFile1(const(wchar)* fileName, SECURITY_ATTRIBUTES* securityAttributes, 
                                       uint flagsAndAttributes, BOOL optimizeMarkupSize, 
                                       XPS_INTERLEAVING interleaving, IOpcPartUri documentSequencePartName, 
                                       IXpsOMCoreProperties coreProperties, IXpsOMImageResource packageThumbnail, 
                                       IXpsOMPrintTicketResource documentSequencePrintTicket, 
                                       IOpcPartUri discardControlPartName, XPS_DOCUMENT_TYPE documentType, 
                                       IXpsOMPackageWriter* packageWriter);
    ///Opens a stream for writing the contents of an XPS OM to an XPS package of a specified type.
    ///Params:
    ///    outputStream = [in] The stream to be used for writing.
    ///    optimizeMarkupSize = A Boolean value that indicates whether the document markup will be optimized for size when the document is
    ///                         written to the stream. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///                         id="TRUE"></a><a id="true"></a><dl> <dt><b><b>TRUE</b></b></dt> </dl> </td> <td width="60%"> When writing to
    ///                         the stream, the package writer will attempt to optimize the markup for minimum size. </td> </tr> <tr> <td
    ///                         width="40%"><a id="FALSE"></a><a id="false"></a><dl> <dt><b><b>FALSE</b></b></dt> </dl> </td> <td
    ///                         width="60%"> When writing to the package, the package writer will not attempt any optimization. </td> </tr>
    ///                         </table>
    ///    interleaving = [in] Specifies whether the content of the XPS OM will be interleaved when it is written to the stream.
    ///    documentSequencePartName = [in] The IOpcPartUri interface that contains the part name of the document sequence in the new file.
    ///    coreProperties = [in] The IXpsOMCoreProperties interface that contains the core document properties to be given to the new
    ///                     file. This parameter can be set to <b>NULL</b>.
    ///    packageThumbnail = [in] The IXpsOMImageResource interface that contains the thumbnail image to be assigned to the new file. This
    ///                       parameter can be set to <b>NULL</b>.
    ///    documentSequencePrintTicket = [in] The IXpsOMPrintTicketResource interface that contains the package-level print ticket to be assigned to
    ///                                  the new file. This parameter can be set to <b>NULL</b>.
    ///    discardControlPartName = [in] The IOpcPartUri interface that contains the name of the discard control part. This parameter can be set
    ///                             to <b>NULL</b>.
    ///    documentType = [in] The document type of the package writer. The value of this parameter cannot be
    ///                   XPS_DOCUMENT_TYPE_UNSPECIFIED.
    ///    packageWriter = [out, retval] A pointer to the new IXpsOMPackageWriter interface created by this method.
    ///Returns:
    ///    Possible values include, but are not limited to, the following. For information about XPS document API return
    ///    values that are not listed here, see XPS Document Errors. S_OK: The method succeeded and packageWriter was
    ///    set correctly. E_INVALIDARG: The document type was not a valid XPS document format.
    ///    
    HRESULT CreatePackageWriterOnStream1(ISequentialStream outputStream, BOOL optimizeMarkupSize, 
                                         XPS_INTERLEAVING interleaving, IOpcPartUri documentSequencePartName, 
                                         IXpsOMCoreProperties coreProperties, IXpsOMImageResource packageThumbnail, 
                                         IXpsOMPrintTicketResource documentSequencePrintTicket, 
                                         IOpcPartUri discardControlPartName, XPS_DOCUMENT_TYPE documentType, 
                                         IXpsOMPackageWriter* packageWriter);
    HRESULT CreatePackage1(IXpsOMPackage1* package_);
    ///Opens a stream that contains an XPS package and returns an instantiated XPS document object tree. This method
    ///will read a stream that contains an XPS document that is of type XPS_DOCUMENT_TYPE_ XPS or XPS_DOCUMENT_TYPE_
    ///OPENXPS.
    ///Params:
    ///    stream = [in] The stream that contains an XPS package.
    ///    reuseObjects = [in] The Boolean value that indicates that the software is to attempt to optimize the document object tree by
    ///                   sharing objects that are identical in all properties and children. TRUE: The software will attempt to
    ///                   optimize the object tree. FALSE: The software will not attempt to optimize the object tree.
    ///    package = [out, retval] A pointer to the new IXpsOMPackage1 interface that contains the resulting XPS document object
    ///              tree.
    ///Returns:
    ///    The method returns an HRESULT. Possible values include, but are not limited to, the following. For
    ///    information about XPS document API return values that are not listed here, see XPS Document Errors. S_OK: The
    ///    method succeeded. XPS_E_UNEXPECTED_NAMESPACE: The package markup uses a namespace that is not supported by
    ///    the document type. XPS_E_ABSOLUTE_REFERENCE: The OpenXPS document contains XML elements that use absolute
    ///    URIs to reference other parts in the document.
    ///    
    HRESULT CreatePackageFromStream1(IStream stream, BOOL reuseObjects, IXpsOMPackage1* package_);
    ///Opens an XPS package file and returns an instantiated XPS document object tree. This method will read a file that
    ///contains an XPS document that is of type XPS_DOCUMENT_TYPE_ XPS or XPS_DOCUMENT_TYPE_ OPENXPS
    ///Params:
    ///    filename = [in, string] The name of the XPS package file.
    ///    reuseObjects = [in] The Boolean value that indicates that the software is to attempt to optimize the document object tree by
    ///                   sharing objects that are identical in all properties and children. TRUE: The software will attempt to
    ///                   optimize the object tree. FALSE: The software will not attempt to optimize the object tree.
    ///    package = [out, retval] A pointer to the new IXpsOMPackage1 interface that contains the XPS document object tree that
    ///              was read from filename.
    ///Returns:
    ///    The method returns an HRESULT. Possible values include, but are not limited to, the following. For
    ///    information about XPS document API return values that are not listed here, see XPS Document Errors. S_OK: The
    ///    method succeeded. XPS_E_UNEXPECTED_NAMESPACE: The package markup uses a namespace that is not supported by
    ///    the document type XPS_E_ABSOLUTE_REFERENCE: The OpenXPS document contains XML elements that use absolute URIs
    ///    to reference other parts in the document.
    ///    
    HRESULT CreatePackageFromFile1(const(wchar)* filename, BOOL reuseObjects, IXpsOMPackage1* package_);
    HRESULT CreatePage1(const(XPS_SIZE)* pageDimensions, const(wchar)* language, IOpcPartUri partUri, 
                        IXpsOMPage1* page);
    ///Reads the page markup from the specified stream to create and populate an IXpsOMPage1 interface.
    ///Params:
    ///    pageMarkupStream = [in] The stream that contains the page markup.
    ///    partUri = [in] The IOpcPartUri interface that contains the page's URI.
    ///    resources = [in] The IXpsOMPartResources interface that contains the resources used by the page.
    ///    reuseObjects = [in] A Boolean value that indicates that the software is to attempt to optimize the document object tree by
    ///                   sharing objects that are identical in all properties and children. TRUE: The software will attempt to
    ///                   optimize the object tree. FALSE: The software will not attempt to optimize the object tree.
    ///    page = [out, retval] A pointer to the new IXpsOMPage1 interface created by this method. -
    ///Returns:
    ///    The method returns an HRESULT. Possible values include, but are not limited to, those in the table that
    ///    follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. S_OK: The method succeeded. XPS_E_INVALID_CONTENT_TYPE: The image resource type does not
    ///    match the namespaces used in page markup. For example, one of the elements in the resources collection may be
    ///    JpegXR but namespaces follow the MSXPS specification. E_POINTER: pageMarkupStream, partUri, resources, or
    ///    page is <b>NULL</b>. XPS_E_NO_CUSTOM_OBJECTS: resource does not point to a recognized interface
    ///    implementation. Custom implementation of XPS Document API interfaces is not supported.
    ///    
    HRESULT CreatePageFromStream1(IStream pageMarkupStream, IOpcPartUri partUri, IXpsOMPartResources resources, 
                                  BOOL reuseObjects, IXpsOMPage1* page);
    ///Loads the remote resource dictionary markup into an unrooted IXpsOMRemoteDictionaryResource interface. The
    ///dictionary referenced by the dictionaryMarkupStream parameter can contain markup from either the OpenXPS or the
    ///MSXPS namespace.
    ///Params:
    ///    dictionaryMarkupStream = [in] The IStream interface that contains the remote resource dictionary markup.
    ///    partUri = [in] The IOpcPartUri interface that contains the part name to be assigned to this resource.
    ///    resources = The IXpsOMPartResources interface for the part resources of the dictionary resource objects that have
    ///                streams.
    ///    dictionaryResource = [in] A pointer to the new IXpsOMRemoteDictionaryResource interface.
    ///Returns:
    ///    The method returns an HRESULT. Possible values include, but are not limited to, those in the table that
    ///    follows. For information about XPS document API return values that are not listed in this table, see XPS
    ///    Document Errors. S_OK: The method succeeded. XPS_E_INVALID_CONTENT_TYPE: An image resource type does not
    ///    match the namespaces used in the markup. For example, if one of the elements in resources may be JpegXR but
    ///    namespaces follow the MSXPS specification. E_POINTER: dictionaryMarkupStream, dictionaryPartUri, resources,
    ///    or dictionaryResource is <b>NULL</b>. XPS_E_NO_CUSTOM_OBJECTS: resource does not point to a recognized
    ///    interface implementation. Custom implementation of XPS Document API interfaces is not supported.
    ///    
    HRESULT CreateRemoteDictionaryResourceFromStream1(IStream dictionaryMarkupStream, IOpcPartUri partUri, 
                                                      IXpsOMPartResources resources, 
                                                      IXpsOMRemoteDictionaryResource* dictionaryResource);
}

///Inherits from IXpsOMPackage. Provides support for: Detecting the format/type of an XPS package loaded in the XPS OM.
///Saving an in-memory XPS OM package to an MSXPS or OpenXPS package byte stream or file.
@GUID("95A9435E-12BB-461B-8E7F-C6ADB04CD96A")
interface IXpsOMPackage1 : IXpsOMPackage
{
    ///Gets the document type of the data that was used to initialize this package. This method is used to determine
    ///whether a document is the XPS or OpenXPS type. For more information, see XPS Documents.
    ///Params:
    ///    documentType = [out, retval] The document type of the source data used to initialize this package. A document type value of
    ///                   XPS_DOCUMENT_TYPE_UNSPECIFIED is returned if the package was created in memory.
    ///Returns:
    ///    The method returns an HRESULT. Possible values include, but are not limited to, the following values. For
    ///    information about XPS Document API return values that are not listed in this table, see XPS Document Errors.
    ///    S_OK: The method succeeded. E_POINTER: documentType is <b>NULL</b>.
    ///    
    HRESULT GetDocumentType(XPS_DOCUMENT_TYPE* documentType);
    ///Writes an XPS OM to a file as an XPS package of a specified type.
    ///Params:
    ///    fileName = [in, string] The name of the file to be created. This parameter must not be <b>NULL</b>.
    ///    securityAttributes = [in, unique] The SECURITY_ATTRIBUTES structure, which contains two distinct but related data members:
    ///                         lpSecurityDescriptor: an optional security descriptor bInheritHandle: a Boolean value that determines whether
    ///                         the returned handle can be inherited by child processes If lpSecurityDescriptor is <b>NULL</b>, the file or
    ///                         device that is associated with the returned handle will be assigned a default security descriptor. For more
    ///                         information about the securityAttributes parameter, refer to CreateFile.
    ///    flagsAndAttributes = [in] Specifies the settings and attributes of the file to be created. For most files, a value of
    ///                         FILE_ATTRIBUTE_NORMAL can be used. For more information about the flagsAndAttributes parameter, refer to
    ///                         CreateFile.
    ///    optimizeMarkupSize = [in] A Boolean value that indicates whether the document markup will be optimized for size when the contents
    ///                         of the XPS OM are written to the XPS package. TRUE: The package writer will try to optimize the markup for
    ///                         minimum size. FALSE: The package writer will not try to perform any optimization.
    ///    documentType = [in] The XPS data format to write to outputStream. The value of this parameter cannot be
    ///                   XPS_DOCUMENT_TYPE_UNSPECIFIED.
    ///Returns:
    ///    The method returns an HRESULT. Possible values include, but are not limited to, the following values. For
    ///    information about XPS Document API return values that are not listed in this table, see XPS Document Errors.
    ///    S_OK: The method succeeded. E_POINTER: documentType is <b>NULL</b>. E_INVALIDARG: The document type was
    ///    specified as XPS_DOCUMENT_TYPE_UNSPECIFIED. XPS_E_INVALID_CONTENT_TYPE: An image resource in the package is
    ///    of a type that is not supported by the document type specified in documentType.
    ///    
    HRESULT WriteToFile1(const(wchar)* fileName, SECURITY_ATTRIBUTES* securityAttributes, uint flagsAndAttributes, 
                         BOOL optimizeMarkupSize, XPS_DOCUMENT_TYPE documentType);
    ///Writes an XPS OM to a stream as an XPS package of a specified type.
    ///Params:
    ///    outputStream = [in] The stream that receives the serialized contents of the package. This parameter must not be <b>NULL</b>.
    ///    optimizeMarkupSize = [in] A Boolean value that indicates whether the document markup will be optimized for size when the contents
    ///                         of the XPS OM are written to the XPS package. TRUE: The package writer will try to optimize the markup for
    ///                         minimum size. FALSE: The package writer will not try to perform any optimization.
    ///    documentType = [in] The XPS data format to write to outputStream. The value of this parameter cannot be
    ///                   XPS_DOCUMENT_TYPE_UNSPECIFIED.
    ///Returns:
    ///    The method returns an HRESULT. Possible values include, but are not limited to, the following values. For
    ///    information about XPS Document API return values that are not listed in this table, see XPS Document Errors.
    ///    S_OK: The method succeeded. E_POINTER: documentType is <b>NULL</b>. E_INVALIDARG: documentType was set to
    ///    XPS_DOCUMENT_TYPE_UNSPECIFIED. XPS_E_INVALID_CONTENT_TYPE: An image resource in the package is of a type that
    ///    is not supported by the document type specified in documentType.
    ///    
    HRESULT WriteToStream1(ISequentialStream outputStream, BOOL optimizeMarkupSize, XPS_DOCUMENT_TYPE documentType);
}

///Inherits from IXpsOMPage. Provides support for: Detecting the type of XPS FixedPage markup which this page was loaded
///from. Serializing page objects to markup of the requested type - MSXPS or OpenXps.
@GUID("305B60EF-6892-4DDA-9CBB-3AA65974508A")
interface IXpsOMPage1 : IXpsOMPage
{
    ///Gets the type of FixedPage markup that was used to initialize this page. This method is used to determine whether
    ///a document is the XPS or OpenXPS type. For more information, see XPS Documents.
    ///Params:
    ///    documentType = [out, retval] The document type of the source data used to initialize this package. A document type value of
    ///                   XPS_DOCUMENT_TYPE_UNSPECIFIED is returned if the package was created in memory.
    ///Returns:
    ///    The method returns an HRESULT. Possible values include, but are not limited to, the following values. For
    ///    information about XPS Document API return values that are not listed in this table, see XPS Document Errors.
    ///    S_OK: The method succeeded. E_POINTER: documentType is <b>NULL</b>.
    ///    
    HRESULT GetDocumentType(XPS_DOCUMENT_TYPE* documentType);
    HRESULT Write1(ISequentialStream stream, BOOL optimizeMarkupSize, XPS_DOCUMENT_TYPE documentType);
}

///The <b>IXpsDocumentPackageTarget</b> interface contains the elements needed for printing XPS content in the Document
///Printing model.
@GUID("3B0B6D38-53AD-41DA-B212-D37637A6714E")
interface IXpsDocumentPackageTarget : IUnknown
{
    ///Gets the IXpsOMPackageWriter object for the document package.
    ///Params:
    ///    documentSequencePartName = The document sequence part name.
    ///    discardControlPartName = The control part name.
    ///    packageWriter = The IXpsOMPackageWriter object.
    ///Returns:
    ///    This method returns an HRESULT value. If the method call fails, it returns the appropriate HRESULT error
    ///    code.
    ///    
    HRESULT GetXpsOMPackageWriter(IOpcPartUri documentSequencePartName, IOpcPartUri discardControlPartName, 
                                  IXpsOMPackageWriter* packageWriter);
    ///Gets the IXpsOMObjectFactory object for the document package.
    ///Params:
    ///    xpsFactory = The IXpsOMObjectFactory object.
    ///Returns:
    ///    This method returns an HRESULT value. If the method call fails, it returns the appropriate HRESULT error
    ///    code.
    ///    
    HRESULT GetXpsOMFactory(IXpsOMObjectFactory* xpsFactory);
    ///Gets the XPS_DOCUMENT_TYPE enumerated value for the document package.
    ///Params:
    ///    documentType = The XPS_DOCUMENT_TYPE enumerated value.
    ///Returns:
    ///    This method returns an HRESULT value. If the method call fails, it returns the appropriate HRESULT error
    ///    code.
    ///    
    HRESULT GetXpsType(XPS_DOCUMENT_TYPE* documentType);
}

///Extends IXpsOMRemoteDictionaryResource to provide methods that support OpenXPS documents.
@GUID("BF8FC1D4-9D46-4141-BA5F-94BB9250D041")
interface IXpsOMRemoteDictionaryResource1 : IXpsOMRemoteDictionaryResource
{
    ///Gets the XPS_DOCUMENT_TYPE of the resource.
    ///Params:
    ///    documentType = The XPS_DOCUMENT_TYPE document type of the resource. Returns XPS_DOCUMENT_TYPE_UNSPECIFIED unless the
    ///                   IXpsOMRemoteDictionaryResource interface was created by loading a previously serialized remote dictionary.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. For information about XPS document API return values, see XPS Document
    ///    Errors.
    ///    
    HRESULT GetDocumentType(XPS_DOCUMENT_TYPE* documentType);
    ///Serializes the remote dictionary resource to a stream.
    ///Params:
    ///    stream = The stream that receives the serialized contents of the dictionary.
    ///    documentType = The XPS data format to write to outputStream. The value of this parameter cannot be
    ///                   <b>XPS_DOCUMENT_TYPE_UNSPECIFIED</b>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. For information about XPS document API return values, see XPS Document
    ///    Errors.
    ///    
    HRESULT Write1(ISequentialStream stream, XPS_DOCUMENT_TYPE documentType);
}

///Contains methods that support model textures and print ticket.
@GUID("E8A45033-640E-43FA-9BDF-FDDEAA31C6A0")
interface IXpsOMPackageWriter3D : IXpsOMPackageWriter
{
    ///Creates a new 3D model texture from the specified texture part and stream.
    ///Params:
    ///    texturePartName = The Open Package Convention (OPC) name of the texture part. This part is added to the package and becomes a
    ///                      relationship target of the model part.
    ///    textureData = A readable stream which holds 3D model texture. When calling this method, you must provide PNG or JPEG data.
    ///Returns:
    ///    Returns the appropriate HRESULT error code.
    ///    
    HRESULT AddModelTexture(IOpcPartUri texturePartName, IStream textureData);
    ///Creates a print ticket with the specified part.
    ///Params:
    ///    printTicketPartName = The part is added to package and becomes a target of relationship from model part.
    ///    printTicketData = A readable stream that holds the 3D model print ticket.
    ///Returns:
    ///    Returns the appropriate HRESULT error code. Calling this method more than once per package writer returns the
    ///    error XPS_E_MULTIPLE_PRINTICKETS_ON_DOCUMENT.
    ///    
    HRESULT SetModelPrintTicket(IOpcPartUri printTicketPartName, IStream printTicketData);
}

///Provides methods for sending 3D content to XPS for printing.
@GUID("60BA71B8-3101-4984-9199-F4EA775FF01D")
interface IXpsDocumentPackageTarget3D : IUnknown
{
    ///Gets a new IXpsOMPackageWriter3D object for the document package.
    ///Params:
    ///    documentSequencePartName = The root part of XPS payload.
    ///    discardControlPartName = The discard control part for the XPS payload.
    ///    modelPartName = Name of the part which will hold the 3D model. The part’s content type is
    ///                    “application/vnd.ms-package.3dmanufacturing-3dmodel+xml”. It is linked from package root with
    ///                    relationship type “http://schemas.microsoft.com/3dmanufacturing/2013/01/3dmodel” .
    ///    modelData = A readable stream which holds 3D model description. The model description may be UTF16 encoding of XML
    ///                document, but for XPS OM and XpsPrint, this is a BLOB passing through. The <b>GetXpsOMPackageWriter3D</b>
    ///                method attempts to move the provided stream’s read pointer to the beginning of the stream, but the method
    ///                call will not fail if the stream does not support the Seek method.
    ///    packageWriter = Returns the writer which may be used to send XPS content and textures for the 3D model.
    ///Returns:
    ///    Returns the appropriate HRESULT error code.
    ///    
    HRESULT GetXpsOMPackageWriter3D(IOpcPartUri documentSequencePartName, IOpcPartUri discardControlPartName, 
                                    IOpcPartUri modelPartName, IStream modelData, 
                                    IXpsOMPackageWriter3D* packageWriter);
    ///Gets the IXpsOMObjectFactory object for the document package.
    ///Params:
    ///    xpsFactory = The IXpsOMObjectFactory object.
    ///Returns:
    ///    Returns the appropriate HRESULT error code.
    ///    
    HRESULT GetXpsOMFactory(IXpsOMObjectFactory* xpsFactory);
}

///Provides access to the individual signing options that are used by new signatures.
@GUID("7718EAE4-3215-49BE-AF5B-594FEF7FCFA6")
interface IXpsSigningOptions : IUnknown
{
    ///Gets the value of the <b>Id</b> attribute of the <b>Signature</b> element.
    ///Params:
    ///    signatureId = The value of the <b>Id</b> attribute of the <b>Signature</b> element. If the <b>Id</b> attribute is not
    ///                  present, the method returns an empty string.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetSignatureId(ushort** signatureId);
    ///Sets the value of the <b>Id</b> attribute of the <b>Signature</b> element.
    ///Params:
    ///    signatureId = The string value to be set as the <b>Id</b> attribute of the <b>Signature</b> element. If this parameter is
    ///                  <b>NULL</b>, the <b>Id</b> attribute is cleared.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetSignatureId(const(wchar)* signatureId);
    ///Gets the signature method.
    ///Params:
    ///    signatureMethod = The signature method that is expressed as a URI. If no signature method has been set, a <b>NULL</b> pointer
    ///                      is returned. The following signature methods have been tested in Windows 7:
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetSignatureMethod(ushort** signatureMethod);
    ///Sets the signature method.
    ///Params:
    ///    signatureMethod = The signature method expressed as a URI. This parameter must refer to a valid signature method. The following
    ///                      signature methods have been tested in Windows 7:
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetSignatureMethod(const(wchar)* signatureMethod);
    ///Gets the current digest method.
    ///Params:
    ///    digestMethod = The current digest method. The following digest methods have been tested in Windows 7:
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetDigestMethod(ushort** digestMethod);
    ///Sets the URI of the digest method.
    ///Params:
    ///    digestMethod = The URI of the digest method. This parameter must refer to the URI of a valid digest method. The following
    ///                   digest methods have been tested in Windows 7:
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetDigestMethod(const(wchar)* digestMethod);
    ///Gets the part name of the document's signature part.
    ///Params:
    ///    signaturePartName = A pointer to an IOpcPartUri interface that contains the part name of the document's signature part. If a
    ///                        signature part name has not been set, a <b>NULL</b> pointer is returned.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetSignaturePartName(IOpcPartUri* signaturePartName);
    ///Sets the part name of the document's signature part.
    ///Params:
    ///    signaturePartName = The IOpcPartUri interface that contains the part name of the document's signature part. If this parameter is
    ///                        <b>NULL</b>, this method will generate a random, unique part name for the signature part.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetSignaturePartName(IOpcPartUri signaturePartName);
    ///Gets the XPS_SIGN_POLICY value that specifies the signing policy.
    ///Params:
    ///    policy = The logical <b>OR</b> of the XPS_SIGN_POLICY value that specifies the signing policy.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For return values that are not listed in this table, see XPS Digital Signature API Errors and
    ///    XPS Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>policy</i> is <b>NULL</b>. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The interface is not
    ///    connected to the signature manager. </td> </tr> </table>
    ///    
    HRESULT GetPolicy(XPS_SIGN_POLICY* policy);
    ///Sets the XPS_SIGN_POLICY value that represents the signing policy.
    ///Params:
    ///    policy = The logical <b>OR</b> of the XPS_SIGN_POLICY values to be set as the signing policy.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetPolicy(XPS_SIGN_POLICY policy);
    ///Gets the format of the signing time string.
    ///Params:
    ///    timeFormat = The OPC_SIGNATURE_TIME_FORMAT value that specifies the format of the signing time string.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetSigningTimeFormat(OPC_SIGNATURE_TIME_FORMAT* timeFormat);
    ///Sets the format of the signing time string.
    ///Params:
    ///    timeFormat = The OPC_SIGNATURE_TIME_FORMAT value that specifies the format of the signing time string.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetSigningTimeFormat(OPC_SIGNATURE_TIME_FORMAT timeFormat);
    ///Gets a pointer to an IOpcSignatureCustomObjectSet interface that contains a set of signature custom objects.
    ///Params:
    ///    customObjectSet = A pointer to an IOpcSignatureCustomObjectSet interface that contains a set of signature custom objects.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetCustomObjects(IOpcSignatureCustomObjectSet* customObjectSet);
    ///Gets a pointer to an IOpcSignatureReferenceSet interface, which contains a set of signature custom references.
    ///Params:
    ///    customReferenceSet = A pointer to an IOpcSignatureReferenceSet interface, which contains a set of signature custom references.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetCustomReferences(IOpcSignatureReferenceSet* customReferenceSet);
    ///Gets an IOpcCertificateSet interface, which can be used to add additional certificates to the signature.
    ///Params:
    ///    certificateSet = A pointer to the IOpcCertificateSet interface.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetCertificateSet(IOpcCertificateSet* certificateSet);
    ///Gets the XPS_SIGN_FLAGS value that specifies the signing flags to be used for this signature.
    ///Params:
    ///    flags = The XPS_SIGN_FLAGS value that specifies the signing flags to be used for this signature.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetFlags(XPS_SIGN_FLAGS* flags);
    ///Sets the XPS_SIGN_FLAGS value that specifies the signing flags to use for this signature.
    ///Params:
    ///    flags = The XPS_SIGN_FLAGS value that specifies the signing flags to use for this signature.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT SetFlags(XPS_SIGN_FLAGS flags);
}

///A collection of IXpsSignature interface pointers.
@GUID("A2D1D95D-ADD2-4DFF-AB27-6B9C645FF322")
interface IXpsSignatureCollection : IUnknown
{
    ///Gets the number of IXpsSignature interface pointers in the collection.
    ///Params:
    ///    count = The number of IXpsSignature interface pointers in the collection.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetCount(uint* count);
    ///Gets an IXpsSignature interface pointer from a specified location in the collection.
    ///Params:
    ///    index = The zero-based index of the IXpsSignature interface pointer to be obtained.
    ///    signature = The IXpsSignature interface pointer at the location specified by <i>index</i>.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetAt(uint index, IXpsSignature* signature);
    ///Removes and releases an IXpsSignature interface pointer from a specified location in the collection.
    ///Params:
    ///    index = The zero-based index in the collection from which an IXpsSignature interface pointer is to be removed and
    ///            released.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT RemoveAt(uint index);
}

///Represents a single digital signature.
@GUID("6AE4C93E-1ADE-42FB-898B-3A5658284857")
interface IXpsSignature : IUnknown
{
    ///Gets the value of the <b>Id</b> attribute of the <b>Signature</b> element.
    ///Params:
    ///    sigId = The value of the <b>Id</b> attribute of the <b>Signature</b> element. If the <b>Id</b> attribute is not
    ///            present, a <b>NULL</b> pointer is returned.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For return values that are not listed in this table, see XPS Digital Signature API Errors and
    ///    XPS Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>sigId</i> is <b>NULL</b>. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The interface is not connected to
    ///    the signature manager. </td> </tr> </table>
    ///    
    HRESULT GetSignatureId(ushort** sigId);
    ///Gets the encrypted hash value of the signature.
    ///Params:
    ///    signatureHashValue = The byte array that represents the encrypted hash value of the signature.
    ///    count = The length of the byte array that is referenced by <i>signatureHashValue</i>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For return values that are not listed in this table, see XPS Digital Signature API Errors and
    ///    XPS Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The interface is not connected to the
    ///    signature manager. </td> </tr> </table>
    ///    
    HRESULT GetSignatureValue(ubyte** signatureHashValue, uint* count);
    ///Gets a pointer to an IOpcCertificateEnumerator interface, which enumerates the package certificates that are
    ///attached to the signature.
    ///Params:
    ///    certificateEnumerator = A pointer to an IOpcCertificateEnumerator interface, which enumerates the certificates that are attached to
    ///                            the signature.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For return values that are not listed in this table, see XPS Digital Signature API Errors and
    ///    XPS Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The interface is not connected to the
    ///    signature manager. </td> </tr> </table>
    ///    
    HRESULT GetCertificateEnumerator(IOpcCertificateEnumerator* certificateEnumerator);
    ///Gets the date and time of signature creation.
    ///Params:
    ///    sigDateTimeString = A string that contains the date and time information.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For return values that are not listed in this table, see XPS Digital Signature API Errors and
    ///    XPS Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The interface is not connected to the
    ///    signature manager. </td> </tr> </table>
    ///    
    HRESULT GetSigningTime(ushort** sigDateTimeString);
    ///Gets the format of the signing time.
    ///Params:
    ///    timeFormat = The value of OPC_SIGNATURE_TIME_FORMAT that describes the format of the signing time.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For return values that are not listed in this table, see XPS Digital Signature API Errors and
    ///    XPS Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The interface is not connected to the
    ///    signature manager. </td> </tr> </table>
    ///    
    HRESULT GetSigningTimeFormat(OPC_SIGNATURE_TIME_FORMAT* timeFormat);
    ///Gets the part name of the signature part.
    ///Params:
    ///    signaturePartName = A pointer to an IOpcPartUri interface that contains the part name of the signature part.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For return values that are not listed in this table, see XPS Digital Signature API Errors and
    ///    XPS Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The interface is not connected to the
    ///    signature manager. </td> </tr> </table>
    ///    
    HRESULT GetSignaturePartName(IOpcPartUri* signaturePartName);
    ///Verifies the signature against a specified X.509 certificate.
    ///Params:
    ///    x509Certificate = The CERT_CONTEXT structure that contains the X.509 certificate that will be used for verification. If the
    ///                      signature is not incomplete or incompliant, this certificate will be used only to validate that the signed
    ///                      data in the XPS package is intact. The certificate will not be used to perform any other checks. Before using
    ///                      the certificate the application is expected to verify the trust chain and any other requirements.
    ///    sigStatus = The XPS_SIGNATURE_STATUS value that describes the results of the verification.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For return values that are not listed in this table, see XPS Digital Signature API Errors and
    ///    XPS Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>x509Certificate</i> or <i>sigStatus</i> is
    ///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%">
    ///    The interface is not connected to the signature manager. </td> </tr> </table>
    ///    
    HRESULT Verify(const(CERT_CONTEXT)* x509Certificate, XPS_SIGNATURE_STATUS* sigStatus);
    ///Gets the XPS_SIGN_POLICY value that represents the signing policy used when the signature is created.
    ///Params:
    ///    policy = The logical <b>OR</b> of the XPS_SIGN_POLICY values that represent the signing policy.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For return values that are not listed in this table, see XPS Digital Signature API Errors and
    ///    XPS Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>policy</i> is <b>NULL</b>. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The interface is not
    ///    connected to the signature manager. </td> </tr> </table>
    ///    
    HRESULT GetPolicy(XPS_SIGN_POLICY* policy);
    ///Gets a pointer to an IOpcSignatureCustomObjectEnumerator interface, which enumerates the custom objects of the
    ///signature.
    ///Params:
    ///    customObjectEnumerator = A pointer to an IOpcSignatureCustomObjectSet interface, which enumerates the custom objects of the signature.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For return values that are not listed in this table, see XPS Digital Signature API Errors and
    ///    XPS Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The interface is not connected to the
    ///    signature manager. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>XPS_E_OBJECT_DETACHED</b></dt> </dl> </td>
    ///    <td width="60%"> The interface is not associated with the signature manager. </td> </tr> </table>
    ///    
    HRESULT GetCustomObjectEnumerator(IOpcSignatureCustomObjectEnumerator* customObjectEnumerator);
    ///Gets a pointer to an IOpcSignatureReferenceEnumerator interface, which enumerates the custom references of the
    ///signature.
    ///Params:
    ///    customReferenceEnumerator = A pointer to an IOpcSignatureReferenceEnumerator interface, which enumerates the custom references of the
    ///                                signature.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetCustomReferenceEnumerator(IOpcSignatureReferenceEnumerator* customReferenceEnumerator);
    ///Gets the XML markup of the digital signature.
    ///Params:
    ///    signatureXml = The XML markup of the digital signature.
    ///    count = The size, in bytes, of the buffer referenced by <i>signatureXml</i>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For return values that are not listed in this table, see XPS Digital Signature API Errors and
    ///    XPS Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The interface is not connected to the
    ///    signature manager. </td> </tr> </table>
    ///    
    HRESULT GetSignatureXml(ubyte** signatureXml, uint* count);
    ///Sets the XML markup of the digital signature.
    ///Params:
    ///    signatureXml = The XML markup of the digital signature.
    ///    count = The size, in bytes, of the buffer referenced by <i>signatureXml</i>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For return values that are not listed in this table, see XPS Digital Signature API Errors and
    ///    XPS Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>signatureXml</i> is <b>NULL</b>. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The interface is not
    ///    connected to the signature manager. </td> </tr> </table>
    ///    
    HRESULT SetSignatureXml(const(ubyte)* signatureXml, uint count);
}

///A collection of IXpsSignatureBlock interfaces.
@GUID("23397050-FE99-467A-8DCE-9237F074FFE4")
interface IXpsSignatureBlockCollection : IUnknown
{
    ///Gets the number of IXpsSignatureBlock interface pointers in the collection.
    ///Params:
    ///    count = The number of IXpsSignatureBlock interface pointers in the collection.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetCount(uint* count);
    ///Gets an IXpsSignatureBlock interface pointer from a specified location in the collection.
    ///Params:
    ///    index = The zero-based index of the IXpsSignatureBlock interface pointer to be obtained.
    ///    signatureBlock = The IXpsSignatureBlock interface pointer at the location specified by <i>index</i>.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetAt(uint index, IXpsSignatureBlock* signatureBlock);
    ///Removes and releases an IXpsSignatureBlock interface pointer from a specified location in the collection.
    ///Params:
    ///    index = The zero-based index in the collection from which an IXpsSignatureBlock interface pointer is to be removed
    ///            and released.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT RemoveAt(uint index);
}

///Represents a block of signature requests that are stored in a SignatureDefinitions part.
@GUID("151FAC09-0B97-4AC6-A323-5E4297D4322B")
interface IXpsSignatureBlock : IUnknown
{
    ///Gets a pointer to the IXpsSignatureRequestCollection interface that contains a collection of signature requests.
    ///Params:
    ///    requests = A pointer to the IXpsSignatureRequestCollection interface that contains a collection of signature requests.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For return values that are not listed in this table, see XPS Digital Signature API Errors and
    ///    XPS Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>requests</i> is <b>NULL</b>. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The interface is not
    ///    connected to the signature manager. </td> </tr> </table>
    ///    
    HRESULT GetRequests(IXpsSignatureRequestCollection* requests);
    ///Gets a pointer to the IOpcPartUri interface that contains the URI of the SignatureDefinitions part.
    ///Params:
    ///    partName = A pointer to the IOpcPartUri interface that contains the URI of the SignatureDefinitions part.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For return values that are not listed in this table, see XPS Digital Signature API Errors and
    ///    XPS Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>partName</i> is <b>NULL</b>. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The interface is not connected to
    ///    the signature manager. </td> </tr> </table>
    ///    
    HRESULT GetPartName(IOpcPartUri* partName);
    ///Gets the index of the FixedDocument part that references the SignatureDefinitions part that corresponds to this
    ///signature block.
    ///Params:
    ///    fixedDocumentIndex = The zero-based index of the FixedDocument part that references the SignatureDefinitions part that corresponds
    ///                         to this SignatureBlock.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For return values that are not listed in this table, see XPS Digital Signature API Errors and
    ///    XPS Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>fixedDocumentIndex</i> is <b>NULL</b>. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The interface is not
    ///    connected to the signature manager. </td> </tr> </table>
    ///    
    HRESULT GetDocumentIndex(uint* fixedDocumentIndex);
    ///Gets a pointer to the IOpcPartUri interface that contains the URI of the document part.
    ///Params:
    ///    fixedDocumentName = A pointer to the IOpcPartUri interface that contains the URI of the document part.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For return values that are not listed in this table, see XPS Digital Signature API Errors and
    ///    XPS Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>fixedDocumentName</i> is <b>NULL</b>. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The interface is not
    ///    connected to the signature manager. </td> </tr> </table>
    ///    
    HRESULT GetDocumentName(IOpcPartUri* fixedDocumentName);
    ///Creates a new IXpsSignatureRequest interface and adds it to the signature block.
    ///Params:
    ///    requestId = A string that uniquely identifies the new signature request within the signature block. For the method to
    ///                generate an ID string, set this parameter to <b>NULL</b>.
    ///    signatureRequest = A pointer to the new IXpsSignatureRequest interface. If access to the new request interface is not required,
    ///                       this parameter can be set to <b>NULL</b>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For return values that are not listed in this table, see XPS Digital Signature API Errors and
    ///    XPS Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> Either the interface is not connected to the
    ///    signature manager, or <i>requestId</i> is <b>NULL</b> and a unique ID string could not be generated. </td>
    ///    </tr> </table>
    ///    
    HRESULT CreateRequest(const(wchar)* requestId, IXpsSignatureRequest* signatureRequest);
}

///A collection of IXpsSignatureRequest interfaces.
@GUID("F0253E68-9F19-412E-9B4F-54D3B0AC6CD9")
interface IXpsSignatureRequestCollection : IUnknown
{
    ///Gets the number of IXpsSignatureRequest interface pointers in the collection.
    ///Params:
    ///    count = The number of IXpsSignatureRequest interface pointers in the collection.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetCount(uint* count);
    ///Gets an IXpsSignatureRequest interface pointer from a specified location in the collection.
    ///Params:
    ///    index = The zero-based index of the IXpsSignatureRequest interface pointer to be obtained.
    ///    signatureRequest = The IXpsSignatureRequest interface pointer at the location specified by <i>index</i>.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT GetAt(uint index, IXpsSignatureRequest* signatureRequest);
    ///Removes and releases an IXpsSignatureRequest interface pointer from a specified location in the collection.
    ///Params:
    ///    index = The zero-based index in the collection from which an IXpsSignatureRequest interface pointer is to be removed
    ///            and released.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code.
    ///    
    HRESULT RemoveAt(uint index);
}

///Accesses the components of a signature request.
@GUID("AC58950B-7208-4B2D-B2C4-951083D3B8EB")
interface IXpsSignatureRequest : IUnknown
{
    ///Sets the string that describes the intent or meaning of the signature.
    ///Params:
    ///    intent = The signature intention agreement against which the signer is signing.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For return values that are not listed in this table, see XPS Digital Signature API Errors and
    ///    XPS Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>intent</i> is <b>NULL</b>. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The interface is not
    ///    connected to the signature manager. </td> </tr> </table>
    ///    
    HRESULT GetIntent(ushort** intent);
    ///Sets the string that describes the intent or meaning of the signature.
    ///Params:
    ///    intent = The string that describes the intent or meaning of the signature.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For return values that are not listed in this table, see XPS Digital Signature API Errors and
    ///    XPS Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>intent</i> is <b>NULL</b>. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The interface is not
    ///    connected to the signature manager. </td> </tr> </table>
    ///    
    HRESULT SetIntent(const(wchar)* intent);
    ///Gets the identity of the person who has signed or is requesting to sign the package.
    ///Params:
    ///    signerName = The identity of the person who has signed or is requesting to sign the package.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For return values that are not listed in this table, see XPS Digital Signature API Errors and
    ///    XPS Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>signerName</i> is <b>NULL</b>. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The interface is not
    ///    connected to the signature manager. </td> </tr> </table>
    ///    
    HRESULT GetRequestedSigner(ushort** signerName);
    ///Sets the identity of the person who signed or is requested to sign the package.
    ///Params:
    ///    signerName = The identity of the person who signed or is requesting to sign the package.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For return values that are not listed in this table, see XPS Digital Signature API Errors and
    ///    XPS Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>signerName</i> is <b>NULL</b>. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The interface is not
    ///    connected to the signature manager. </td> </tr> </table>
    ///    
    HRESULT SetRequestedSigner(const(wchar)* signerName);
    ///Gets the date and time before which the requested signer must sign the specified parts of the document.
    ///Params:
    ///    dateString = A string that contains the date and time before which the requested signer must sign the specified parts of
    ///                 the document. The string is formatted as either <code>YYYY-MM-DDThh:mmZ</code>, which includes the UTC time
    ///                 zone offset, or <code>YYYY-MM-DDThh:mm</code>, which does not include the UTC time zone offset. For example,
    ///                 without the time zone offset, 7:30:29 P.M. on July 4, 2008 would be represented as
    ///                 <code>2008-07-04T19:30:29</code>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For return values that are not listed in this table, see XPS Digital Signature API Errors and
    ///    XPS Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>dateString</i> is <b>NULL</b>. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The interface is not
    ///    connected to the signature manager. </td> </tr> </table>
    ///    
    HRESULT GetRequestSignByDate(ushort** dateString);
    ///Sets the date and time before which the requested signer must sign the specified parts of the document.
    ///Params:
    ///    dateString = A string that contains the date and time before which the requested signer must sign the specified parts of
    ///                 the document. The string must be formatted as <code>YYYY-MM-DDThh:mmZ</code> with the UTC time zone offset.
    ///                 For example, 7:30:29 A.M. Pacific Standard Time on July 4, 2008 would be represented as the UTC time of
    ///                 <code>2008-07-04T15:30:29Z</code>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For return values that are not listed in this table, see XPS Digital Signature API Errors and
    ///    XPS Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>dateString</i> is <b>NULL</b>. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The interface is not
    ///    connected to the signature manager. </td> </tr> </table>
    ///    
    HRESULT SetRequestSignByDate(const(wchar)* dateString);
    ///Gets the legal jurisdiction of the package signing location.
    ///Params:
    ///    place = The legal jurisdiction of the package signing location
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For return values that are not listed in this table, see XPS Digital Signature API Errors and
    ///    XPS Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>place</i> is <b>NULL</b>. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The interface is not connected to
    ///    the signature manager. </td> </tr> </table>
    ///    
    HRESULT GetSigningLocale(ushort** place);
    ///Sets the legal jurisdiction of the package signing location.
    ///Params:
    ///    place = The legal jurisdiction of the package signing location.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For return values that are not listed in this table, see XPS Digital Signature API Errors and
    ///    XPS Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>place</i> is <b>NULL</b>. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The interface is not connected to
    ///    the signature manager. </td> </tr> </table>
    ///    
    HRESULT SetSigningLocale(const(wchar)* place);
    ///Gets the page and the location on the page where the visible digital signature or the digital signature request
    ///will be displayed.
    ///Params:
    ///    pageIndex = The index value of the FixedPage part that contains the signature or the digital signature request. If a spot
    ///                location is not specified for the signature request, –1 is returned.
    ///    pagePartName = A pointer to an IOpcPartUri interface of the part that contains the FixedPage on which the digital signature
    ///                   is to be displayed.
    ///    x = The x-coordinate value of the signing spot on the page.
    ///    y = The y-coordinate value of the signing spot on the page.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For return values that are not listed in this table, see XPS Digital Signature API Errors and
    ///    XPS Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>pageIndex</i>, <i>pagePartName</i>, <i>x</i>,
    ///    or <i>y</i> is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td>
    ///    <td width="60%"> The interface is not connected to the signature manager. </td> </tr> </table>
    ///    
    HRESULT GetSpotLocation(int* pageIndex, IOpcPartUri* pagePartName, float* x, float* y);
    ///Specifies the page and the location on the page where the visible digital signature or the digital signature
    ///request will be displayed.
    ///Params:
    ///    pageIndex = The index value of the FixedPage part in the XPS document that contains the visible digital signature or the
    ///                digital signature request. If the value of this parameter is –1, a <b>SpotLocation</b> element will not be
    ///                written to the SignatureDefinitions markup. If the value of this parameter is not –1, it must be a page
    ///                number that exists in the FixedDocument part to which the signature block that contains this request is
    ///                attached.
    ///    x = The x-coordinate value of the signing spot on the page.
    ///    y = The y-coordinate value of the signing spot on the page.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For return values that are not listed in this table, see XPS Digital Signature API Errors and
    ///    XPS Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The interface is not connected to the
    ///    signature manager. </td> </tr> </table>
    ///    
    HRESULT SetSpotLocation(int pageIndex, float x, float y);
    ///Gets the unique identifier of the signature request.
    ///Params:
    ///    requestId = The unique identifier of the signature request.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For return values that are not listed in this table, see XPS Digital Signature API Errors and
    ///    XPS Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>requestId</i> is <b>NULL</b>. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The interface is not
    ///    connected to the signature manager. </td> </tr> </table>
    ///    
    HRESULT GetRequestId(ushort** requestId);
    ///Gets a pointer to an IXpsSignature interface that contains the XPS digital signature with the same unique
    ///identifier as the signature request.
    ///Params:
    ///    signature = A pointer to an IXpsSignature interface that contains the XPS digital signature with the same unique
    ///                identifier as the signature request. If no matching signature is found, a <b>NULL</b> pointer is returned.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For return values that are not listed in this table, see XPS Digital Signature API Errors and
    ///    XPS Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>signature</i> is <b>NULL</b>. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> The interface is not
    ///    connected to the signature manager. </td> </tr> </table>
    ///    
    HRESULT GetSignature(IXpsSignature* signature);
}

///Manages the digital signatures and digital signature requests of an XPS document.
@GUID("D3E8D338-FDC4-4AFC-80B5-D532A1782EE1")
interface IXpsSignatureManager : IUnknown
{
    ///Loads an existing XPS package from a file into the digital signature manager.
    ///Params:
    ///    fileName = The file name of the XPS package to be loaded.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For return values that are not listed in this table, see XPS Digital Signature API Errors and
    ///    XPS Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>fileName</i> is <b>NULL</b>. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>XPS_E_PACKAGE_ALREADY_OPENED</b></dt> </dl> </td> <td width="60%"> An XPS
    ///    package has already been opened in the signature manager. </td> </tr> </table>
    ///    
    HRESULT LoadPackageFile(const(wchar)* fileName);
    ///Loads an XPS package from a stream into the digital signature manager.
    ///Params:
    ///    stream = The stream that contains the XPS package to be loaded.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For return values that are not listed in this table, see XPS Digital Signature API Errors and
    ///    XPS Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>stream</i> is <b>NULL</b>. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>XPS_E_PACKAGE_ALREADY_OPENED</b></dt> </dl> </td> <td width="60%"> An XPS
    ///    package has already been opened in the signature manager. </td> </tr> </table>
    ///    
    HRESULT LoadPackageStream(IStream stream);
    ///Signs the contents of an XPS package as specified by the signing options and returns the resulting digital
    ///signature.
    ///Params:
    ///    signOptions = A pointer to the IXpsSigningOptions interface that contains the signing options. <div
    ///                  class="alert"><b>Note</b> <p class="note">The SignatureMethod and the DigestMethod properties of the
    ///                  IXpsSigningOptions interface must be initialized before the pointer to that interface can be used in the
    ///                  <i>signOptions</i> parameter. </div> <div> </div>
    ///    x509Certificate = A pointer to the CERT_CONTEXT structure that contains the X.509 certificate to be used for signing.
    ///    signature = A pointer to the IXpsSignature interface that contains the new digital signature. If successful, this method
    ///                creates the signature part, adds it to the package, and in <i>signature</i> returns a pointer to the
    ///                interface of that signature part.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For return values that are not listed in this table, see XPS Digital Signature API Errors and
    ///    XPS Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>XPS_E_MARKUP_COMPATIBILITY_ELEMENTS</b></dt> </dl> </td> <td width="60%"> The XPS_SIGN_FLAGS
    ///    value specified that no markup compatibility elements were expected; however, markup compatibility elements
    ///    were found. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>XPS_E_NO_CUSTOM_OBJECTS</b></dt> </dl> </td> <td
    ///    width="60%"> <i>signOptions</i> does not point to a recognized interface implementation. Custom
    ///    implementation of XPS Document API interfaces is not supported. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>XPS_E_PACKAGE_NOT_OPENED</b></dt> </dl> </td> <td width="60%"> An XPS package has not yet been opened
    ///    in the signature manager. </td> </tr> </table>
    ///    
    HRESULT Sign(IXpsSigningOptions signOptions, const(CERT_CONTEXT)* x509Certificate, IXpsSignature* signature);
    ///Gets the part name of the signature origin part.
    ///Params:
    ///    signatureOriginPartName = A pointer to the IOpcPartUri interface that contains the part name of the signature origin part. If the
    ///                              document does not have any signatures, a <b>NULL</b> pointer is returned.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For return values that are not listed in this table, see XPS Digital Signature API Errors and
    ///    XPS Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>XPS_E_PACKAGE_NOT_OPENED</b></dt> </dl> </td> <td width="60%"> An XPS package has not yet been
    ///    opened in the signature manager. </td> </tr> </table>
    ///    
    HRESULT GetSignatureOriginPartName(IOpcPartUri* signatureOriginPartName);
    ///Sets the part name of the signature origin part.
    ///Params:
    ///    signatureOriginPartName = A pointer to an IOpcPartUri interface that contains the part name of the signature origin part.
    ///Returns:
    ///    If the method succeeds, it returns S_OK; otherwise, it returns an <b>HRESULT</b> error code shown in the
    ///    table that follows or an <b>HRESULT</b> error code that is returned by
    ///    IOpcDigitalSignatureManager::SetSignatureOriginPartName. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>XPS_E_PACKAGE_NOT_OPENED</b></dt> </dl> </td>
    ///    <td width="60%"> An XPS package was not loaded into the digital signature manager before calling this method.
    ///    </td> </tr> </table>
    ///    
    HRESULT SetSignatureOriginPartName(IOpcPartUri signatureOriginPartName);
    ///Gets a pointer to an IXpsSignatureCollection interface that contains a collection of XPS digital signatures.
    ///Params:
    ///    signatures = A pointer to an IXpsSignatureCollection interface that contains a collection of XPS digital signatures.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For return values that are not listed in this table, see XPS Digital Signature API Errors and
    ///    XPS Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>signatures</i> is <b>NULL</b>. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>XPS_E_PACKAGE_NOT_OPENED</b></dt> </dl> </td> <td width="60%"> An XPS
    ///    package has not yet been opened in the signature manager. </td> </tr> </table>
    ///    
    HRESULT GetSignatures(IXpsSignatureCollection* signatures);
    ///Creates a new IXpsSignatureBlock interface and adds it to the signature block collection.
    ///Params:
    ///    partName = A pointer to the IOpcPartUri interface that contains the URI of the new part. For the method to generate a
    ///               part name, this parameter can be set to <b>NULL</b>.
    ///    fixedDocumentIndex = The index value of the FixedDocument part with which the new signature block is to be associated.
    ///    signatureBlock = A pointer to the new IXpsSignatureBlock interface. If access to the new interface is not required, this
    ///                     parameter can be set to <b>NULL</b>.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For return values that are not listed in this table, see XPS Digital Signature API Errors and
    ///    XPS Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> <i>fixedDocumentIndex</i> references a fixed
    ///    document that is not found in the XPS package. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>XPS_E_PACKAGE_NOT_OPENED</b></dt> </dl> </td> <td width="60%"> An XPS package has not yet been opened
    ///    in the signature manager. </td> </tr> </table>
    ///    
    HRESULT AddSignatureBlock(IOpcPartUri partName, uint fixedDocumentIndex, IXpsSignatureBlock* signatureBlock);
    ///Gets a pointer to an IXpsSignatureBlockCollection interface that contains a collection of signature blocks.
    ///Params:
    ///    signatureBlocks = A pointer to an IXpsSignatureBlockCollection interface that contains a collection of signature blocks.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For return values that are not listed in this table, see XPS Digital Signature API Errors and
    ///    XPS Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>signatureBlocks</i> is <b>NULL</b>. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>XPS_E_PACKAGE_NOT_OPENED</b></dt> </dl> </td> <td width="60%"> An XPS
    ///    package has not yet been opened in the signature manager. </td> </tr> </table>
    ///    
    HRESULT GetSignatureBlocks(IXpsSignatureBlockCollection* signatureBlocks);
    ///Creates a new IXpsSigningOptions interface.
    ///Params:
    ///    signingOptions = A pointer to the new IXpsSigningOptions interface.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For return values that are not listed in this table, see XPS Digital Signature API Errors and
    ///    XPS Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>signingOptions</i> is <b>NULL</b>. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>XPS_E_PACKAGE_NOT_OPENED</b></dt> </dl> </td> <td width="60%"> An XPS
    ///    package has not yet been opened in the signature manager. </td> </tr> </table>
    ///    
    HRESULT CreateSigningOptions(IXpsSigningOptions* signingOptions);
    ///Saves the XPS package to a file.
    ///Params:
    ///    fileName = The name of the file where the XPS package is to be created and saved.
    ///    securityAttributes = The SECURITY_ATTRIBUTES structure, which contains two separate but related data members: <ul>
    ///                         <li><b>lpSecurityDescriptor</b>, an optional security descriptor.</li> <li><b>bInheritHandle</b>, a Boolean
    ///                         value that determines whether the returned handle can be inherited by child processes.</li> </ul> If the
    ///                         <b>lpSecurityDescriptor</b> member of the structure is <b>NULL</b>, the file or device that is associated
    ///                         with the returned handle is assigned a default security descriptor. For more information about this
    ///                         parameter, see CreateFile.
    ///    flagsAndAttributes = The file or device attributes and flags that will be used in file creation. For more information about this
    ///                         parameter, see the description of the <i>dwFlagsAndAttributes</i> parameter in CreateFile.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For return values that are not listed in this table, see XPS Digital Signature API Errors and
    ///    XPS Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>fileName</i> is <b>NULL</b>. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>XPS_E_PACKAGE_NOT_OPENED</b></dt> </dl> </td> <td width="60%"> An XPS package
    ///    has not yet been opened in the signature manager. </td> </tr> </table>
    ///    
    HRESULT SavePackageToFile(const(wchar)* fileName, SECURITY_ATTRIBUTES* securityAttributes, 
                              uint flagsAndAttributes);
    ///Saves the XPS package by writing it to a stream.
    ///Params:
    ///    stream = The stream to which the XPS package is written.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the table
    ///    that follows. For return values that are not listed in this table, see XPS Digital Signature API Errors and
    ///    XPS Document Errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> <i>stream</i> is <b>NULL</b>. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>XPS_E_PACKAGE_NOT_OPENED</b></dt> </dl> </td> <td width="60%"> An XPS package
    ///    has not yet been opened in the signature manager. </td> </tr> </table>
    ///    
    HRESULT SavePackageToStream(IStream stream);
}

///Allows users to enumerate the supported package target types and to create one with a given type ID.
///<b>IPrintDocumentPackageTarget</b> also supports the tracking of the package printing progress and cancelling.
@GUID("1B8EFEC4-3019-4C27-964E-367202156906")
interface IPrintDocumentPackageTarget : IUnknown
{
    ///Enumerates the supported target types.
    ///Params:
    ///    targetCount = The number of supported target types.
    ///    targetTypes = The array of supported target types. An array of GUIDs.
    ///Returns:
    ///    If the <b>GetPackageTargetTypes</b> method completes successfully, it returns an S_OK. Otherwise it returns
    ///    the appropriate HRESULT error code.
    ///    
    HRESULT GetPackageTargetTypes(uint* targetCount, char* targetTypes);
    ///Retrieves the pointer to the specific document package target, which allows the client to add a document with the
    ///given target type. Clients can call this method multiple times but they always have to use the same target ID.
    ///Params:
    ///    guidTargetType = The target type GUID obtained from GetPackageTargetTypes.
    ///    riid = The identifier of the interface being requested.
    ///    ppvTarget = The requested document target interface. The returned pointer is a pointer to an IXpsDocumentPackageTarget
    ///                interface.
    ///Returns:
    ///    If the <b>GetPackageTarget</b> method completes successfully, it returns an S_OK. Otherwise it returns the
    ///    appropriate HRESULT error code.
    ///    
    HRESULT GetPackageTarget(const(GUID)* guidTargetType, const(GUID)* riid, void** ppvTarget);
    ///Cancels the current print job.
    ///Returns:
    ///    If the <b>Cancel</b> method completes successfully, it returns an S_OK. Otherwise it returns the appropriate
    ///    HRESULT error code.
    ///    
    HRESULT Cancel();
}

///Represents the progress of the print job.
@GUID("ED90C8AD-5C34-4D05-A1EC-0E8A9B3AD7AF")
interface IPrintDocumentPackageStatusEvent : IDispatch
{
    ///Updates the status of the package when the print job in progress raises an event, or the job completes.
    ///Params:
    ///    packageStatus = The status update.
    ///Returns:
    ///    If the <b>PackageStatusUpdated</b> method completes successfully, it returns an S_OK. Otherwise it returns an
    ///    appropriate HRESULT error code.
    ///    
    HRESULT PackageStatusUpdated(PrintDocumentPackageStatus* packageStatus);
}

///Used with IPrintDocumentPackageTarget for starting a print job.
@GUID("D2959BF7-B31B-4A3D-9600-712EB1335BA4")
interface IPrintDocumentPackageTargetFactory : IUnknown
{
    ///Acts as the entry point for creating an IPrintDocumentPackageTarget object.
    ///Params:
    ///    printerName = The name of the target printer.
    ///    jobName = The name to apply to the job. <div class="alert"><b>Note</b> Job name strings longer than 63 characters will
    ///              be truncated to 63 characters and a terminating <b>NULL</b>.</div> <div> </div>
    ///    jobOutputStream = The job content. The application must set the seek pointer to the beginning before specifying the job output
    ///                      stream.
    ///    jobPrintTicketStream = A pointer to the <b>IStream</b> interface that is used by the caller to write the job-level print ticket that
    ///                           will be associated with this job.
    ///    docPackageTarget = The target output.
    ///Returns:
    ///    If the <b>CreateDocumentPackageTargetForPrintJob</b> method completes successfully, it returns an S_OK.
    ///    Otherwise it returns the appropriate HRESULT error code.
    ///    
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
