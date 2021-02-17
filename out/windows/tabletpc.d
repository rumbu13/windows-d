// Written in the D programming language.

module windows.tabletpc;

public import windows.core;
public import windows.automation : BSTR, IDispatch, SAFEARRAY, VARIANT;
public import windows.com : HRESULT, IDataObject, IFontDisp, IPictureDisp,
                            IUnknown;
public import windows.controls : NMHDR;
public import windows.displaydevices : POINT, RECT;
public import windows.gdi : XFORM;
public import windows.systemservices : BOOL;
public import windows.windowsandmessaging : HWND;

extern(Windows):


// Enums


///Defines constant values for the unit of measurement of a property.
alias PROPERTY_UNITS = int;
enum : int
{
    ///Units are unknown.
    PROPERTY_UNITS_DEFAULT     = 0x00000000,
    ///The property value is in inches.
    PROPERTY_UNITS_INCHES      = 0x00000001,
    ///The property value is in centimeters.
    PROPERTY_UNITS_CENTIMETERS = 0x00000002,
    ///The property value is in degrees.
    PROPERTY_UNITS_DEGREES     = 0x00000003,
    ///The property value is in radians.
    PROPERTY_UNITS_RADIANS     = 0x00000004,
    ///The property value is in seconds.
    PROPERTY_UNITS_SECONDS     = 0x00000005,
    ///The property value is in pounds.
    PROPERTY_UNITS_POUNDS      = 0x00000006,
    ///The property value is in grams.
    PROPERTY_UNITS_GRAMS       = 0x00000007,
    PROPERTY_UNITS_SILINEAR    = 0x00000008,
    PROPERTY_UNITS_SIROTATION  = 0x00000009,
    PROPERTY_UNITS_ENGLINEAR   = 0x0000000a,
    PROPERTY_UNITS_ENGROTATION = 0x0000000b,
    PROPERTY_UNITS_SLUGS       = 0x0000000c,
    PROPERTY_UNITS_KELVIN      = 0x0000000d,
    PROPERTY_UNITS_FAHRENHEIT  = 0x0000000e,
    PROPERTY_UNITS_AMPERE      = 0x0000000f,
    PROPERTY_UNITS_CANDELA     = 0x00000010,
}

alias enumINKMETRIC_FLAGS = int;
enum : int
{
    IMF_FONT_SELECTED_IN_HDC = 0x00000001,
    IMF_ITALIC               = 0x00000002,
    IMF_BOLD                 = 0x00000004,
}

alias enumGetCandidateFlags = int;
enum : int
{
    TCF_ALLOW_RECOGNITION = 0x00000001,
    TCF_FORCE_RECOGNITION = 0x00000002,
}

///Specifies whether the first element or all elements within a group of points or packet values are used.
enum InkSelectionConstants : int
{
    ///The first element is used.
    ISC_FirstElement = 0x00000000,
    ///All elements are used.
    ISC_AllElements  = 0xffffffff,
}

///Specifies which characteristics of a stroke, such as drawing attributes, are used to calculate the bounding box of
///the ink. The bounding box is the smallest rectangle that includes all points in the InkDisp object. The size of the
///rectangle varies depending on whether you use drawing attributes, Bezier curve fitting, or just the points of the
///stroke to calculate the rectangle.
enum InkBoundingBoxMode : int
{
    ///The definition of each stroke (polyline or Bezier) is used to calculate the bounding box; includes the drawing
    ///attributes, such as pen width, in the calculation.
    IBBM_Default    = 0x00000000,
    ///The polyline of the strokes (ignoring Bezier curve fitting requests) is used to calculate the bounding box;
    ///includes the drawing attributes in the calculation.
    IBBM_NoCurveFit = 0x00000001,
    ///The Bezier curve fitting line of the strokes (apply Bezier curve fitting to all strokes) is used to calculate the
    ///bounding box; includes the drawing attributes in the calculation.
    IBBM_CurveFit   = 0x00000002,
    ///Only the points of the strokes are used to calculate the bounding box.
    IBBM_PointsOnly = 0x00000003,
    ///The union of a NoCurveFit request and a CurveFit request.
    IBBM_Union      = 0x00000004,
}

///Determines how a stroke is removed from an InkDisp object.
enum InkExtractFlags : int
{
    ///The ink is copied from the InkDisp object.
    IEF_CopyFromOriginal   = 0x00000000,
    ///The ink is cut from the InkDisp object.
    IEF_RemoveFromOriginal = 0x00000001,
    ///The ink is cut from the InkDisp object.
    IEF_Default            = 0x00000001,
}

///Specifies how ink is persisted.
enum InkPersistenceFormat : int
{
    ///Ink is persisted using ink serialized format (ISF). This is the most compact persistent representation of ink. It
    ///can be embedded within a binary document format or placed directly on the Clipboard.
    IPF_InkSerializedFormat       = 0x00000000,
    ///Ink is persisted by encoding the ISF as a base64 stream. This format is provided so that ink can be encoded
    ///directly in an Extensible Markup Language (XML) or HTML file.
    IPF_Base64InkSerializedFormat = 0x00000001,
    ///Ink is persisted by using a Graphics Interchange Format (GIF) file that contains ISF as metadata that is embedded
    ///within the file. This allows ink to be viewed in applications that are not ink-enabled and maintain its full ink
    ///fidelity when it returns to an ink-enabled application. This format is ideal when transporting ink content within
    ///an HTML file and making it usable by ink-enabled and ink-unaware applications.
    IPF_GIF                       = 0x00000002,
    ///Ink is persisted by using a base64 encoded fortified. This GIF format is provided when ink is to be encoded
    ///directly in an XML or HTML file with later conversion into an image. A possible use of this would be in an XML
    ///format that is generated to contain all ink information and used as a way to generate HTML through Extensible
    ///Stylesheet Language Transformations (XSLT).
    IPF_Base64GIF                 = 0x00000003,
}

///Defines values for the compression modes that are used to save the InkDisp object to a serialized format.
enum InkPersistenceCompressionMode : int
{
    ///The default. Provides the best tradeoff between save-time and storage for the typical application.
    IPCM_Default            = 0x00000000,
    ///Maximum compression. This is the default value.
    IPCM_MaximumCompression = 0x00000001,
    ///No compression. Used when save-time is more important than the amount of storage space used and when
    ///compatibility between versions is important.
    IPCM_NoCompression      = 0x00000002,
}

///Specifies the pen-tip shape.
enum InkPenTip : int
{
    ///The pen tip is round. This is the default pen tip.
    IPT_Ball      = 0x00000000,
    ///The pen tip is rectangular.
    IPT_Rectangle = 0x00000001,
}

///Defines values for performing raster operations on drawn ink.
enum InkRasterOperation : int
{
    ///Black pen color.
    IRO_Black       = 0x00000001,
    ///The inverse of MergePen.
    IRO_NotMergePen = 0x00000002,
    ///A combination of the colors that are common to the background color and the inverse of the pen.
    IRO_MaskNotPen  = 0x00000003,
    ///The inverse of CopyPen.
    IRO_NotCopyPen  = 0x00000004,
    ///A combination of the colors that are common to both the pen and the inverse of the display.
    IRO_MaskPenNot  = 0x00000005,
    ///The inverse of the display color.
    IRO_Not         = 0x00000006,
    ///A combination of the colors in the pen and in the display color, but not in both.
    IRO_XOrPen      = 0x00000007,
    ///The inverse of MaskPen.
    IRO_NotMaskPen  = 0x00000008,
    ///A combination of the colors that are common to both the pen and the display.
    IRO_MaskPen     = 0x00000009,
    ///An inverse of XOrPen.
    IRO_NotXOrPen   = 0x0000000a,
    ///No operation; the output remains unchanged.
    IRO_NoOperation = 0x0000000b,
    ///A combination of the display color and the inverse of the pen color.
    IRO_MergeNotPen = 0x0000000c,
    ///The pen color. This is the default value.
    IRO_CopyPen     = 0x0000000d,
    ///A combination of the pen color and the inverse of the display color.
    IRO_MergePenNot = 0x0000000e,
    ///A combination of the pen color and the display color.
    IRO_MergePen    = 0x0000000f,
    ///A white pen color.
    IRO_White       = 0x00000010,
}

///Specifies the type of mouse pointer to appear.
enum InkMousePointer : int
{
    ///The default mouse pointer.
    IMP_Default        = 0x00000000,
    ///The arrow mouse pointer.
    IMP_Arrow          = 0x00000001,
    ///The cross (cross-hair) mouse pointer.
    IMP_Crosshair      = 0x00000002,
    ///The I-beam mouse pointer.
    IMP_Ibeam          = 0x00000003,
    ///The sizing handle NE/SW mouse pointer (double arrow that points northeast and southwest).
    IMP_SizeNESW       = 0x00000004,
    ///The sizing handle N/S mouse pointer (double arrow that points north and south).
    IMP_SizeNS         = 0x00000005,
    ///The sizing handle NW/SE mouse pointer (double arrow that points northwest and southeast).
    IMP_SizeNWSE       = 0x00000006,
    ///The sizing handle W/E mouse pointer (double arrow that points west and east).
    IMP_SizeWE         = 0x00000007,
    ///The up arrow mouse pointer.
    IMP_UpArrow        = 0x00000008,
    ///The hourglass (wait) mouse pointer.
    IMP_Hourglass      = 0x00000009,
    ///The no-drop mouse pointer.
    IMP_NoDrop         = 0x0000000a,
    ///The arrow and hourglass mouse pointer.
    IMP_ArrowHourglass = 0x0000000b,
    ///The arrow and question mark mouse pointer.
    IMP_ArrowQuestion  = 0x0000000c,
    ///The size-all mouse pointer.
    IMP_SizeAll        = 0x0000000d,
    ///The hand mouse pointer.
    IMP_Hand           = 0x0000000e,
    ///The custom mouse pointer that the MouseIcon property specifies.
    IMP_Custom         = 0x00000063,
}

///Specifies the copy options of the Clipboard.
enum InkClipboardModes : int
{
    ///The ink is copied to the Clipboard.
    ICB_Copy        = 0x00000000,
    ///The ink is cut and copied to the Clipboard.
    ICB_Cut         = 0x00000001,
    ///The ink is not copied to the Clipboard. Typically, use this option if you want to add something else, such as
    ///text, to the ink before you copy it to the Clipboard.
    ICB_ExtractOnly = 0x00000030,
    ///Delayed rendering is used to reduce the amount of data that is stored on the Clipboard. The data is rendered when
    ///a paste request is made.
    ICB_DelayedCopy = 0x00000020,
    ///Copy mode is used to copy the Ink.
    ICB_Default     = 0x00000000,
}

///Specifies the format of ink that is stored on the Clipboard.
enum InkClipboardFormats : int
{
    ///A flag that can be used to verify whether any formats are present by checking against it.
    ICF_None                = 0x00000000,
    ///Ink is encoded in ink serialized format (ISF). This is the most compact persistent representation of ink.
    ///Although it often contains only ink data, ISF is extensible. Applications can set custom attributes (identified
    ///by a globally unique identifier (GUID)) on an InkDisp object, stroke, or point. This allows an application to
    ///store any kind of data or metadata that it requires as an attribute in an ISF stream.
    ICF_InkSerializedFormat = 0x00000001,
    ///Ink is not expected to form words, but rather is interpreted as a picture. This is also useful for representing
    ///multiple words.
    ICF_SketchInk           = 0x00000002,
    ///Ink is expected to form words. It enables the recognizer to convert the ink to text. The recognized text is
    ///either the recognition alternate with the greatest confidence rating or another alternate chosen from a list.
    ///This is useful for representing a single word.
    ICF_TextInk             = 0x00000006,
    ///The enhanced metafile to play to create the background. The metafile must remain valid for as long as it is used
    ///to render the ink background.
    ICF_EnhancedMetafile    = 0x00000008,
    ///Ink is stored as a metafile or a list of commands that can be played back to draw a graphic.
    ICF_Metafile            = 0x00000020,
    ///The bitmap to use as the background. The bitmap device context must remain valid for as long as it is used to
    ///render the ink background.
    ICF_Bitmap              = 0x00000040,
    ///The formats that can be used for pasting, including tInk, sInk, and ISF.
    ICF_PasteMask           = 0x00000007,
    ///The formats that are copied to the Clipboard through ink. This is the default value.
    ICF_CopyMask            = 0x0000007f,
    ///Ink is stored as a CopyMask.
    ICF_Default             = 0x0000007f,
}

///Specifies which part of a selection, if any, was hit during a hit test.
enum SelectionHitResult : int
{
    ///No part of the selection was hit.
    SHR_None      = 0x00000000,
    ///The northwest corner sizing handle was hit.
    SHR_NW        = 0x00000001,
    ///The southeast corner sizing handle was hit.
    SHR_SE        = 0x00000002,
    ///The northeast corner sizing handle was hit.
    SHR_NE        = 0x00000003,
    ///That the southwest corner sizing handle was hit.
    SHR_SW        = 0x00000004,
    ///The east side sizing handle was hit.
    SHR_E         = 0x00000005,
    ///The west side sizing handle was hit.
    SHR_W         = 0x00000006,
    ///The north side sizing handle was hit.
    SHR_N         = 0x00000007,
    ///The south side sizing handle was hit.
    SHR_S         = 0x00000008,
    ///The selection itself was hit (no selection handle was hit).
    SHR_Selection = 0x00000009,
}

///Specifies whether an error occurred during recognition and, if so, which error occurred.
enum InkRecognitionStatus : int
{
    ///Specifies no error.
    IRS_NoError                     = 0x00000000,
    ///The recognition was interrupted by a call to StopBackgroundRecognition.
    IRS_Interrupted                 = 0x00000001,
    ///The ink recognition process failed.
    IRS_ProcessFailed               = 0x00000002,
    ///The ink could not be added.
    IRS_InkAddedFailed              = 0x00000004,
    ///The <i>character Autocomplete</i> mode could not be set.
    IRS_SetAutoCompletionModeFailed = 0x00000008,
    ///The strokes could not be set.
    IRS_SetStrokesFailed            = 0x00000010,
    ///The recognition guide could not be set.
    IRS_SetGuideFailed              = 0x00000020,
    ///The flags could not be set.
    IRS_SetFlagsFailed              = 0x00000040,
    ///The factoid could not be set.
    IRS_SetFactoidFailed            = 0x00000080,
    ///The suffix or the prefix could not be set.
    IRS_SetPrefixSuffixFailed       = 0x00000100,
    ///The word list could not be set.
    IRS_SetWordListFailed           = 0x00000200,
}

alias DISPID_InkRectangle = int;
enum : int
{
    DISPID_IRTop          = 0x00000001,
    DISPID_IRLeft         = 0x00000002,
    DISPID_IRBottom       = 0x00000003,
    DISPID_IRRight        = 0x00000004,
    DISPID_IRGetRectangle = 0x00000005,
    DISPID_IRSetRectangle = 0x00000006,
    DISPID_IRData         = 0x00000007,
}

alias DISPID_InkExtendedProperty = int;
enum : int
{
    DISPID_IEPGuid = 0x00000001,
    DISPID_IEPData = 0x00000002,
}

alias DISPID_InkExtendedProperties = int;
enum : int
{
    DISPID_IEPs_NewEnum          = 0xfffffffc,
    DISPID_IEPsItem              = 0x00000000,
    DISPID_IEPsCount             = 0x00000001,
    DISPID_IEPsAdd               = 0x00000002,
    DISPID_IEPsRemove            = 0x00000003,
    DISPID_IEPsClear             = 0x00000004,
    DISPID_IEPsDoesPropertyExist = 0x00000005,
}

alias DISPID_InkDrawingAttributes = int;
enum : int
{
    DISPID_DAHeight             = 0x00000001,
    DISPID_DAColor              = 0x00000002,
    DISPID_DAWidth              = 0x00000003,
    DISPID_DAFitToCurve         = 0x00000004,
    DISPID_DAIgnorePressure     = 0x00000005,
    DISPID_DAAntiAliased        = 0x00000006,
    DISPID_DATransparency       = 0x00000007,
    DISPID_DARasterOperation    = 0x00000008,
    DISPID_DAPenTip             = 0x00000009,
    DISPID_DAClone              = 0x0000000a,
    DISPID_DAExtendedProperties = 0x0000000b,
}

alias DISPID_InkTransform = int;
enum : int
{
    DISPID_ITReset        = 0x00000001,
    DISPID_ITTranslate    = 0x00000002,
    DISPID_ITRotate       = 0x00000003,
    DISPID_ITReflect      = 0x00000004,
    DISPID_ITShear        = 0x00000005,
    DISPID_ITScale        = 0x00000006,
    DISPID_ITeM11         = 0x00000007,
    DISPID_ITeM12         = 0x00000008,
    DISPID_ITeM21         = 0x00000009,
    DISPID_ITeM22         = 0x0000000a,
    DISPID_ITeDx          = 0x0000000b,
    DISPID_ITeDy          = 0x0000000c,
    DISPID_ITGetTransform = 0x0000000d,
    DISPID_ITSetTransform = 0x0000000e,
    DISPID_ITData         = 0x0000000f,
}

///Defines values that set the interest in a set of application-specific gesture. Application gestures are gestures that
///you can choose to have your application support. Applications that are specifically designed to work with a pen are
///more likely to use these gestures than applications designed for mouse and keyboard. The <b>Tap</b> and
///<b>DoubleTap</b> gestures are supported as application gestures and system gestures (system gestures are defined in
///the InkSystemGesture enumeration type). This means you can incorporate an application gesture that has a component
///that may be construed as a <b>Tap</b> or <b>DoubleTap</b> (such as the <b>Exclamation</b> gesture). In this case,
///enable the <b>Tap</b> application gesture and disable the <b>Tap</b> system gesture in your application. When a user
///taps, the application gesture is recognized. This allows your application to listen for a single component that can
///both identify and distinguish a system gesture <b>Tap</b> from a <b>Tap</b> within the application gesture. In
///addition to the following list of gestures, Microsoft intends to support many gesture glyphs as part of the Microsoft
///gesture recognizer. For more information about these unimplemented gesture glyphs, see Unimplemented Glyphs. For more
///information about application gestures and system gestures, see Using Gestures and Pen Input, Ink, and Recognition.
enum InkApplicationGesture : int
{
    ///All application-specific gestures.
    IAG_AllGestures     = 0x00000000,
    ///No application-specific gestures. See the following "Remarks" section for more details on this member. This is
    ///the default value.
    IAG_NoGesture       = 0x0000f000,
    ///This gesture must be drawn as a single stroke that has at least three back-and-forth motions.
    IAG_Scratchout      = 0x0000f001,
    ///The triangle must be drawn in a single stroke, without lifting the pen.
    IAG_Triangle        = 0x0000f002,
    ///The square can be drawn in one or two strokes. In one stroke, draw the entire square without lifting the pen. In
    ///two strokes, draw three sides of the square and use another stroke to draw the remaining side. Do not use more
    ///than two strokes to draw the square.
    IAG_Square          = 0x0000f003,
    ///The star must have exactly five points and be drawn in a single stroke without lifting the pen.
    IAG_Star            = 0x0000f004,
    ///The upward stroke must be twice as long as the smaller downward stroke.
    IAG_Check           = 0x0000f005,
    ///Start the curlicue on the ink on which you intend to take action.
    IAG_Curlicue        = 0x0000f010,
    ///Start the double-curlicue on the ink on which you intend to take action.
    IAG_DoubleCurlicue  = 0x0000f011,
    ///The circle must be drawn in a single stroke without lifting the pen.
    IAG_Circle          = 0x0000f020,
    ///The two circles must overlap each other and be drawn in a single stroke without lifting the pen.
    IAG_DoubleCircle    = 0x0000f021,
    ///The semicircle must be drawn from left to right. Horizontally, the two ends of the semicircle should be as even
    ///as possible.
    IAG_SemiCircleLeft  = 0x0000f028,
    ///The semicircle must be drawn from right to left. Horizontally, the two ends of the semicircle should be as even
    ///as possible.
    IAG_SemiCircleRight = 0x0000f029,
    ///Both sides of the chevron must be drawn as equal as possible. The angle must be sharp and end in a point.
    IAG_ChevronUp       = 0x0000f030,
    ///Both sides of the chevron must be drawn as equal as possible. The angle must be sharp and end in a point.
    IAG_ChevronDown     = 0x0000f031,
    ///Both sides of the chevron must be drawn as equal as possible. The angle must be sharp and end in a point.
    IAG_ChevronLeft     = 0x0000f032,
    ///Both sides of the chevron must be drawn as equal as possible. The angle must be sharp and end in a point.
    IAG_ChevronRight    = 0x0000f033,
    ///The arrow can be drawn in single stroke or in two strokes in which one stroke is the line and the other is the
    ///arrow head. Do not use more than two strokes to draw the arrow.
    IAG_ArrowUp         = 0x0000f038,
    ///The arrow can be drawn in a single stroke or in two strokes in which one stroke is the line and the other is the
    ///arrow head. Do not use more than two strokes to draw the arrow.
    IAG_ArrowDown       = 0x0000f039,
    ///The arrow can be drawn in a single stroke or in two strokes in which one stroke is the line and the other is the
    ///arrow head. Do not use more than two strokes to draw the arrow.
    IAG_ArrowLeft       = 0x0000f03a,
    ///The arrow can be drawn in a single stroke or in two strokes in which one stroke is the line and the other is the
    ///arrow head. Do not use more than two strokes to draw the arrow.
    IAG_ArrowRight      = 0x0000f03b,
    ///This gesture must be drawn as a single fast flick in the upward direction. This gesture is used by Flicks
    ///Gestures.
    IAG_Up              = 0x0000f058,
    ///This gesture must be drawn as a single fast flick in the downward direction. This gesture is used by Flicks
    ///Gestures.
    IAG_Down            = 0x0000f059,
    ///This gesture must be drawn as a single fast flick to the left. This gesture is used by Flicks Gestures.
    IAG_Left            = 0x0000f05a,
    ///This gesture must be drawn as a single fast flick to the right. This gesture is used by Flicks Gestures.
    IAG_Right           = 0x0000f05b,
    ///This gesture must be drawn in a single stroke starting with the up stroke. The two strokes must be as close to
    ///each other as possible.
    IAG_UpDown          = 0x0000f060,
    ///This gesture must be drawn in a single stroke starting with the down stroke. The two strokes must be as close to
    ///each other as possible.
    IAG_DownUp          = 0x0000f061,
    ///This gesture must be drawn in a single stroke starting with the left stroke. The two strokes must be as close to
    ///each other as possible.
    IAG_LeftRight       = 0x0000f062,
    ///This gesture must be drawn in a single stroke starting with the right stroke. The two strokes must be as close to
    ///each other as possible.
    IAG_RightLeft       = 0x0000f063,
    ///This gesture must be drawn in a single stroke starting with the up stroke. The left stroke must be about twice as
    ///long as the up stroke, and the two strokes must be at a right angle.
    IAG_UpLeftLong      = 0x0000f064,
    ///This gesture must be drawn in a single stroke starting with the up stroke. The right stroke must be about twice
    ///as long as the up stroke, and the two strokes must be at a right angle.
    IAG_UpRightLong     = 0x0000f065,
    ///This gesture must be drawn in a single stroke starting with the down stroke. The left stroke is about twice as
    ///long as the up stroke, and the two strokes must be at a right angle.
    IAG_DownLeftLong    = 0x0000f066,
    ///This gesture must be drawn in a single stroke starting with the down stroke. The right stroke must be about twice
    ///as long as the up stroke, and the two strokes must be at a right angle.
    IAG_DownRightLong   = 0x0000f067,
    ///This gesture must be drawn in a single stroke starting with the up stroke. The two sides must be as equal in
    ///length as possible and at a right angle.
    IAG_UpLeft          = 0x0000f068,
    ///This gesture must be drawn in a single stroke starting with the up stroke. The two sides must be as equal in
    ///length as possible and at a right angle.
    IAG_UpRight         = 0x0000f069,
    ///This gesture must be drawn in a single stroke starting with the down stroke. The two sides must be as equal in
    ///length as possible and at a right angle.
    IAG_DownLeft        = 0x0000f06a,
    ///This gesture must be drawn in a single stroke starting with the down stroke. The two sides must be as equal in
    ///length as possible and at a right angle.
    IAG_DownRight       = 0x0000f06b,
    ///This gesture must be drawn in a single stroke starting with the left stroke. The two sides must be as equal in
    ///length as possible and at a right angle.
    IAG_LeftUp          = 0x0000f06c,
    ///This gesture must be drawn in a single stroke starting with the left stroke. The two sides are as equal in length
    ///as possible and at a right angle.
    IAG_LeftDown        = 0x0000f06d,
    ///This gesture must be drawn in a single stroke starting with the right stroke. The two sides must be as equal in
    ///length as possible and at a right angle.
    IAG_RightUp         = 0x0000f06e,
    ///This gesture must be drawn in a single stroke starting with the right stroke. The two sides must be as equal in
    ///length as possible and at a right angle.
    IAG_RightDown       = 0x0000f06f,
    ///The line must be drawn first and then the dot drawn quickly and as close to the line as possible.
    IAG_Exclamation     = 0x0000f0a4,
    ///A mouse click. For the least amount of slipping across the digitizer surface, tap quickly.
    IAG_Tap             = 0x0000f0f0,
    ///A mouse double-click. Tap quickly and in as close to the same place for best results.
    IAG_DoubleTap       = 0x0000f0f1,
}

///Specifies the interest in a set of operating system-specific gestures.
enum InkSystemGesture : int
{
    ///A click of the left mouse button. This can be used to choose a command from the menu or toolbar, take action if a
    ///command is chosen, set an insertion point (IP), or show selection feedback.
    ISG_Tap        = 0x00000010,
    ///A double-click of the left mouse button. This can be used to select a word or open a file or folder.
    ISG_DoubleTap  = 0x00000011,
    ///A click of the right mouse button. This can be used to show a shortcut menu.
    ISG_RightTap   = 0x00000012,
    ///A drag of the mouse while pressing the left mouse button. This can be used to drag-select (such as in Microsoft
    ///Word when starting with an IP), select multiple words, drag (such as when dragging an object in Microsoft
    ///Windows), or scroll.
    ISG_Drag       = 0x00000013,
    ///A press and hold followed by a stroke, which maps to a right drag of a mouse. This can be used to drag (such as
    ///when dragging an object or selection followed by a shortcut menu).
    ISG_RightDrag  = 0x00000014,
    ///A press and hold of the left mouse button that lasts for a long time, which has no mouse equivalent. This is a
    ///fallback for when a user continues a press-and-hold action for a long time and the event reverts to a Tap.
    ISG_HoldEnter  = 0x00000015,
    ///Not implemented.
    ISG_HoldLeave  = 0x00000016,
    ///A pause of the mouse on an object. This can be used to show a ToolTip, roll-over effects, or other mouse pausing
    ///behaviors.
    ISG_HoverEnter = 0x00000017,
    ///A mouse leaving a pause. This can be used to end ToolTip roll-over effects or other mouse pausing behaviors.
    ISG_HoverLeave = 0x00000018,
    ///A flick gesture.
    ISG_Flick      = 0x0000001f,
}

///Indicates the level of confidence that the recognizer has in the recognition result.
enum InkRecognitionConfidence : int
{
    ///The recognizer is confident that the best recognition alternate is correct.
    IRC_Strong       = 0x00000000,
    ///The recognizer is confident that the correct result is in the list of alternates.
    IRC_Intermediate = 0x00000001,
    ///The recognizer is not confident that the result is in the list of alternates.
    IRC_Poor         = 0x00000002,
}

alias DISPID_InkGesture = int;
enum : int
{
    DISPID_IGId          = 0x00000000,
    DISPID_IGGetHotPoint = 0x00000001,
    DISPID_IGConfidence  = 0x00000002,
}

alias DISPID_InkCursor = int;
enum : int
{
    DISPID_ICsrName              = 0x00000000,
    DISPID_ICsrId                = 0x00000001,
    DISPID_ICsrDrawingAttributes = 0x00000002,
    DISPID_ICsrButtons           = 0x00000003,
    DISPID_ICsrInverted          = 0x00000004,
    DISPID_ICsrTablet            = 0x00000005,
}

alias DISPID_InkCursors = int;
enum : int
{
    DISPID_ICs_NewEnum = 0xfffffffc,
    DISPID_ICsItem     = 0x00000000,
    DISPID_ICsCount    = 0x00000001,
}

///Defines values that specify the state of a cursor button.
enum InkCursorButtonState : int
{
    ///The cursor button is unavailable. A cursor button may become unavailable, for example, when a cursor leaves the
    ///range of Tablet PC.
    ICBS_Unavailable = 0x00000000,
    ///The cursor button is up. A button on a pen tip is up when the pen is not pressed against the digitizer. A button
    ///on a pen barrel is up when the button is not depressed.
    ICBS_Up          = 0x00000001,
    ///The cursor button is down. A button on a pen tip is down when the user lowers the pen to the digitizer and draws
    ///a stroke. For a button on a barrel, the button is down when the button is depressed.
    ICBS_Down        = 0x00000002,
}

alias DISPID_InkCursorButton = int;
enum : int
{
    DISPID_ICBName  = 0x00000000,
    DISPID_ICBId    = 0x00000001,
    DISPID_ICBState = 0x00000002,
}

alias DISPID_InkCursorButtons = int;
enum : int
{
    DISPID_ICBs_NewEnum = 0xfffffffc,
    DISPID_ICBsItem     = 0x00000000,
    DISPID_ICBsCount    = 0x00000001,
}

///Specifies the hardware capabilities of the Tablet PC.
enum TabletHardwareCapabilities : int
{
    ///The digitizer is integrated with the display.
    THWC_Integrated             = 0x00000001,
    ///The cursor must be in physical contact with the device to report position.
    THWC_CursorMustTouch        = 0x00000002,
    ///The device can generate in-air packets when the cursor is in the physical detection range (proximity) of the
    ///device.
    THWC_HardProximity          = 0x00000004,
    ///The device can uniquely identify the active cursor.
    THWC_CursorsHavePhysicalIds = 0x00000008,
}

///Indicates the unit of measurement of a property.
enum TabletPropertyMetricUnit : int
{
    ///The units are unknown.
    TPMU_Default     = 0x00000000,
    ///The property value is in inches (distance units).
    TPMU_Inches      = 0x00000001,
    ///The property value is in centimeters (distance units).
    TPMU_Centimeters = 0x00000002,
    ///The property value is in degrees (angle units).
    TPMU_Degrees     = 0x00000003,
    ///The property value is in radians (angle units).
    TPMU_Radians     = 0x00000004,
    ///The property value is in seconds (angle units).
    TPMU_Seconds     = 0x00000005,
    ///The property value is in pounds (force, or mass, units).
    TPMU_Pounds      = 0x00000006,
    ///The property value is in grams (force, or mass, units).
    TPMU_Grams       = 0x00000007,
}

alias DISPID_InkTablet = int;
enum : int
{
    DISPID_ITName                      = 0x00000000,
    DISPID_ITPlugAndPlayId             = 0x00000001,
    DISPID_ITPropertyMetrics           = 0x00000002,
    DISPID_ITIsPacketPropertySupported = 0x00000003,
    DISPID_ITMaximumInputRectangle     = 0x00000004,
    DISPID_ITHardwareCapabilities      = 0x00000005,
}

enum TabletDeviceKind : int
{
    TDK_Mouse = 0x00000000,
    TDK_Pen   = 0x00000001,
    TDK_Touch = 0x00000002,
}

alias DISPID_InkTablet2 = int;
enum : int
{
    DISPID_IT2DeviceKind = 0x00000000,
}

alias DISPID_InkTablet3 = int;
enum : int
{
    DISPID_IT3IsMultiTouch   = 0x00000000,
    DISPID_IT3MaximumCursors = 0x00000001,
}

alias DISPID_InkTablets = int;
enum : int
{
    DISPID_ITs_NewEnum                  = 0xfffffffc,
    DISPID_ITsItem                      = 0x00000000,
    DISPID_ITsDefaultTablet             = 0x00000001,
    DISPID_ITsCount                     = 0x00000002,
    DISPID_ITsIsPacketPropertySupported = 0x00000003,
}

alias DISPID_InkStrokeDisp = int;
enum : int
{
    DISPID_ISDInkIndex                            = 0x00000001,
    DISPID_ISDID                                  = 0x00000002,
    DISPID_ISDGetBoundingBox                      = 0x00000003,
    DISPID_ISDDrawingAttributes                   = 0x00000004,
    DISPID_ISDFindIntersections                   = 0x00000005,
    DISPID_ISDGetRectangleIntersections           = 0x00000006,
    DISPID_ISDClip                                = 0x00000007,
    DISPID_ISDHitTestCircle                       = 0x00000008,
    DISPID_ISDNearestPoint                        = 0x00000009,
    DISPID_ISDSplit                               = 0x0000000a,
    DISPID_ISDExtendedProperties                  = 0x0000000b,
    DISPID_ISDInk                                 = 0x0000000c,
    DISPID_ISDBezierPoints                        = 0x0000000d,
    DISPID_ISDPolylineCusps                       = 0x0000000e,
    DISPID_ISDBezierCusps                         = 0x0000000f,
    DISPID_ISDSelfIntersections                   = 0x00000010,
    DISPID_ISDPacketCount                         = 0x00000011,
    DISPID_ISDPacketSize                          = 0x00000012,
    DISPID_ISDPacketDescription                   = 0x00000013,
    DISPID_ISDDeleted                             = 0x00000014,
    DISPID_ISDGetPacketDescriptionPropertyMetrics = 0x00000015,
    DISPID_ISDGetPoints                           = 0x00000016,
    DISPID_ISDSetPoints                           = 0x00000017,
    DISPID_ISDGetPacketData                       = 0x00000018,
    DISPID_ISDGetPacketValuesByProperty           = 0x00000019,
    DISPID_ISDSetPacketValuesByProperty           = 0x0000001a,
    DISPID_ISDGetFlattenedBezierPoints            = 0x0000001b,
    DISPID_ISDScaleToRectangle                    = 0x0000001c,
    DISPID_ISDTransform                           = 0x0000001d,
    DISPID_ISDMove                                = 0x0000001e,
    DISPID_ISDRotate                              = 0x0000001f,
    DISPID_ISDShear                               = 0x00000020,
    DISPID_ISDScale                               = 0x00000021,
}

alias DISPID_InkStrokes = int;
enum : int
{
    DISPID_ISs_NewEnum                = 0xfffffffc,
    DISPID_ISsItem                    = 0x00000000,
    DISPID_ISsCount                   = 0x00000001,
    DISPID_ISsValid                   = 0x00000002,
    DISPID_ISsInk                     = 0x00000003,
    DISPID_ISsAdd                     = 0x00000004,
    DISPID_ISsAddStrokes              = 0x00000005,
    DISPID_ISsRemove                  = 0x00000006,
    DISPID_ISsRemoveStrokes           = 0x00000007,
    DISPID_ISsToString                = 0x00000008,
    DISPID_ISsModifyDrawingAttributes = 0x00000009,
    DISPID_ISsGetBoundingBox          = 0x0000000a,
    DISPID_ISsScaleToRectangle        = 0x0000000b,
    DISPID_ISsTransform               = 0x0000000c,
    DISPID_ISsMove                    = 0x0000000d,
    DISPID_ISsRotate                  = 0x0000000e,
    DISPID_ISsShear                   = 0x0000000f,
    DISPID_ISsScale                   = 0x00000010,
    DISPID_ISsClip                    = 0x00000011,
    DISPID_ISsRecognitionResult       = 0x00000012,
    DISPID_ISsRemoveRecognitionResult = 0x00000013,
}

alias DISPID_InkCustomStrokes = int;
enum : int
{
    DISPID_ICSs_NewEnum = 0xfffffffc,
    DISPID_ICSsItem     = 0x00000000,
    DISPID_ICSsCount    = 0x00000001,
    DISPID_ICSsAdd      = 0x00000002,
    DISPID_ICSsRemove   = 0x00000003,
    DISPID_ICSsClear    = 0x00000004,
}

alias DISPID_StrokeEvent = int;
enum : int
{
    DISPID_SEStrokesAdded   = 0x00000001,
    DISPID_SEStrokesRemoved = 0x00000002,
}

alias DISPID_Ink = int;
enum : int
{
    DISPID_IStrokes                    = 0x00000001,
    DISPID_IExtendedProperties         = 0x00000002,
    DISPID_IGetBoundingBox             = 0x00000003,
    DISPID_IDeleteStrokes              = 0x00000004,
    DISPID_IDeleteStroke               = 0x00000005,
    DISPID_IExtractStrokes             = 0x00000006,
    DISPID_IExtractWithRectangle       = 0x00000007,
    DISPID_IDirty                      = 0x00000008,
    DISPID_ICustomStrokes              = 0x00000009,
    DISPID_IClone                      = 0x0000000a,
    DISPID_IHitTestCircle              = 0x0000000b,
    DISPID_IHitTestWithRectangle       = 0x0000000c,
    DISPID_IHitTestWithLasso           = 0x0000000d,
    DISPID_INearestPoint               = 0x0000000e,
    DISPID_ICreateStrokes              = 0x0000000f,
    DISPID_ICreateStroke               = 0x00000010,
    DISPID_IAddStrokesAtRectangle      = 0x00000011,
    DISPID_IClip                       = 0x00000012,
    DISPID_ISave                       = 0x00000013,
    DISPID_ILoad                       = 0x00000014,
    DISPID_ICreateStrokeFromPoints     = 0x00000015,
    DISPID_IClipboardCopyWithRectangle = 0x00000016,
    DISPID_IClipboardCopy              = 0x00000017,
    DISPID_ICanPaste                   = 0x00000018,
    DISPID_IClipboardPaste             = 0x00000019,
}

alias DISPID_InkEvent = int;
enum : int
{
    DISPID_IEInkAdded   = 0x00000001,
    DISPID_IEInkDeleted = 0x00000002,
}

alias DISPID_InkRenderer = int;
enum : int
{
    DISPID_IRGetViewTransform          = 0x00000001,
    DISPID_IRSetViewTransform          = 0x00000002,
    DISPID_IRGetObjectTransform        = 0x00000003,
    DISPID_IRSetObjectTransform        = 0x00000004,
    DISPID_IRDraw                      = 0x00000005,
    DISPID_IRDrawStroke                = 0x00000006,
    DISPID_IRPixelToInkSpace           = 0x00000007,
    DISPID_IRInkSpaceToPixel           = 0x00000008,
    DISPID_IRPixelToInkSpaceFromPoints = 0x00000009,
    DISPID_IRInkSpaceToPixelFromPoints = 0x0000000a,
    DISPID_IRMeasure                   = 0x0000000b,
    DISPID_IRMeasureStroke             = 0x0000000c,
    DISPID_IRMove                      = 0x0000000d,
    DISPID_IRRotate                    = 0x0000000e,
    DISPID_IRScale                     = 0x0000000f,
}

///Defines values that are used to specify whether an event occurred on an ink collector and, if so, which event fired.
///To get the status of a given event, call the GetEventInterest method. To set the status of a given event, call the
///SetEventInterest method.
enum InkCollectorEventInterest : int
{
    ///The ink collector is interested in the Stroke, CursorInRange, and CursorOutOfRange events.
    ICEI_DefaultEvents    = 0xffffffff,
    ///The ink collector detects a cursor down.
    ICEI_CursorDown       = 0x00000000,
    ///Specifies that a new stroke is drawn on a tablet.
    ICEI_Stroke           = 0x00000001,
    ///The ink collector receives a <i>packet</i>.
    ICEI_NewPackets       = 0x00000002,
    ///The ink collector detects an in-air packet.
    ICEI_NewInAirPackets  = 0x00000003,
    ///The ink collector detects a cursor button down.
    ICEI_CursorButtonDown = 0x00000004,
    ///The ink collector detects a cursor button up.
    ICEI_CursorButtonUp   = 0x00000005,
    ///Specifies that a cursor is detected in range of a tablet.
    ICEI_CursorInRange    = 0x00000006,
    ///Specifies that a cursor is detected leaving the range of a tablet.
    ICEI_CursorOutOfRange = 0x00000007,
    ///The ink collector recognizes a system gesture.
    ICEI_SystemGesture    = 0x00000008,
    ///Specifies that a tablet was added to the system.
    ICEI_TabletAdded      = 0x00000009,
    ///Specifies that a tablet was removed from the system.
    ICEI_TabletRemoved    = 0x0000000a,
    ///The mouse pointer is over the object and a mouse button is pressed.
    ICEI_MouseDown        = 0x0000000b,
    ///The mouse pointer is moved over the object.
    ICEI_MouseMove        = 0x0000000c,
    ///The mouse pointer is over the object and a mouse button is released.
    ICEI_MouseUp          = 0x0000000d,
    ///The mouse wheel moves while the object has focus.
    ICEI_MouseWheel       = 0x0000000e,
    ///The object was double-clicked.
    ICEI_DblClick         = 0x0000000f,
    ///The ink collector recognizes all events.
    ICEI_AllEvents        = 0x00000010,
}

///Specifies which mouse button was pressed.
enum InkMouseButton : int
{
    ///The left mouse button was pressed.
    IMF_Left   = 0x00000001,
    ///The right mouse button was pressed.
    IMF_Right  = 0x00000002,
    ///The middle mouse button was pressed.
    IMF_Middle = 0x00000004,
}

///Specifies which modifier key was pressed.
enum InkShiftKeyModifierFlags : int
{
    ///The SHIFT key was used as a modifier.
    IKM_Shift   = 0x00000001,
    ///The CTRL key was used as a modifier.
    IKM_Control = 0x00000002,
    ///The ALT key was used as a modifier.
    IKM_Alt     = 0x00000004,
}

alias DISPID_InkCollectorEvent = int;
enum : int
{
    DISPID_ICEStroke              = 0x00000001,
    DISPID_ICECursorDown          = 0x00000002,
    DISPID_ICENewPackets          = 0x00000003,
    DISPID_ICENewInAirPackets     = 0x00000004,
    DISPID_ICECursorButtonDown    = 0x00000005,
    DISPID_ICECursorButtonUp      = 0x00000006,
    DISPID_ICECursorInRange       = 0x00000007,
    DISPID_ICECursorOutOfRange    = 0x00000008,
    DISPID_ICESystemGesture       = 0x00000009,
    DISPID_ICEGesture             = 0x0000000a,
    DISPID_ICETabletAdded         = 0x0000000b,
    DISPID_ICETabletRemoved       = 0x0000000c,
    DISPID_IOEPainting            = 0x0000000d,
    DISPID_IOEPainted             = 0x0000000e,
    DISPID_IOESelectionChanging   = 0x0000000f,
    DISPID_IOESelectionChanged    = 0x00000010,
    DISPID_IOESelectionMoving     = 0x00000011,
    DISPID_IOESelectionMoved      = 0x00000012,
    DISPID_IOESelectionResizing   = 0x00000013,
    DISPID_IOESelectionResized    = 0x00000014,
    DISPID_IOEStrokesDeleting     = 0x00000015,
    DISPID_IOEStrokesDeleted      = 0x00000016,
    DISPID_IPEChangeUICues        = 0x00000017,
    DISPID_IPEClick               = 0x00000018,
    DISPID_IPEDblClick            = 0x00000019,
    DISPID_IPEInvalidated         = 0x0000001a,
    DISPID_IPEMouseDown           = 0x0000001b,
    DISPID_IPEMouseEnter          = 0x0000001c,
    DISPID_IPEMouseHover          = 0x0000001d,
    DISPID_IPEMouseLeave          = 0x0000001e,
    DISPID_IPEMouseMove           = 0x0000001f,
    DISPID_IPEMouseUp             = 0x00000020,
    DISPID_IPEMouseWheel          = 0x00000021,
    DISPID_IPESizeModeChanged     = 0x00000022,
    DISPID_IPEStyleChanged        = 0x00000023,
    DISPID_IPESystemColorsChanged = 0x00000024,
    DISPID_IPEKeyDown             = 0x00000025,
    DISPID_IPEKeyPress            = 0x00000026,
    DISPID_IPEKeyUp               = 0x00000027,
    DISPID_IPEResize              = 0x00000028,
    DISPID_IPESizeChanged         = 0x00000029,
}

///Specifies the behavior mode of the InkOverlay object and the InkPicture control.
enum InkOverlayEditingMode : int
{
    ///The object or control is in collection mode.
    IOEM_Ink    = 0x00000000,
    ///The object or control is in deletion mode.
    IOEM_Delete = 0x00000001,
    ///The object or control is in selection and editing mode.
    IOEM_Select = 0x00000002,
}

///Specifies where to attach the new InkOverlay object, behind or in front of the active layer.
enum InkOverlayAttachMode : int
{
    ///The new InkOverlay object is attached behind the active window. This is the default value.
    IOAM_Behind  = 0x00000000,
    ///The new InkOverlay object is attached in front of the active window.
    IOAM_InFront = 0x00000001,
}

///Specifies how the picture behaves inside the InkPicture control. The mode is set by using the SizeMode property and
///is applied to the picture set with the Picture property.
enum InkPictureSizeMode : int
{
    ///The control auto sizes to fit the picture.
    IPSM_AutoSize     = 0x00000000,
    ///The picture is centered within the control.
    IPSM_CenterImage  = 0x00000001,
    ///The picture appears at its regular size within the control.
    IPSM_Normal       = 0x00000002,
    ///The picture is stretched within the control.
    IPSM_StretchImage = 0x00000003,
}

///Specifies the way in which ink is erased from the InkOverlay object and the InkPicture control. This mode is used
///when the InkOverlayEditingMode is set to Delete.
enum InkOverlayEraserMode : int
{
    ///Ink is erased by stroke. This is the default value.
    IOERM_StrokeErase = 0x00000000,
    ///Ink is erased by point.
    IOERM_PointErase  = 0x00000001,
}

///Defines values that determine whether ink, gestures, or ink and gestures are recognized as the user writes.
enum InkCollectionMode : int
{
    ///Collects only ink, creating a stroke. The Gesture event interest is set to <b>FALSE</b>, meaning that gestures
    ///are not collected (all other event interests remain as they were).
    ICM_InkOnly       = 0x00000000,
    ///Collects only gestures and does not create a stroke. Gestures can be either single or multi-stroke. Multi-stroke
    ///gestures are accepted if the strokes are made within the time set by the built-in timer of the recognizer. All
    ///stroke-related and packet-related events do not fire from the InkCollector. Cursor events do fire, and ink is
    ///always deleted. The Gesture event interest is set to <b>TRUE</b>, meaning that gestures are collected (all other
    ///event interests remain as they were).
    ICM_GestureOnly   = 0x00000001,
    ///Accepts only single-stroke gestures. The Gesture event fires first, giving the user the ability to say
    ///<i>Cancel</i> = <b>TRUE</b> or <b>FALSE</b>. The default is <b>TRUE</b>, except when NoGesture is the primary
    ///gesture, <i>Cancel</i> defaults to <b>FALSE</b>. If <b>TRUE</b>, the ink is a gesture and is deleted. If
    ///<b>FALSE</b>, the gesture is ink and a Stroke event fires. The Gesture event interest is set to <b>TRUE</b> (all
    ///other event interests are kept as they were).
    ICM_InkAndGesture = 0x00000002,
}

alias DISPID_InkCollector = int;
enum : int
{
    DISPID_ICEnabled                        = 0x00000001,
    DISPID_ICHwnd                           = 0x00000002,
    DISPID_ICPaint                          = 0x00000003,
    DISPID_ICText                           = 0x00000004,
    DISPID_ICDefaultDrawingAttributes       = 0x00000005,
    DISPID_ICRenderer                       = 0x00000006,
    DISPID_ICInk                            = 0x00000007,
    DISPID_ICAutoRedraw                     = 0x00000008,
    DISPID_ICCollectingInk                  = 0x00000009,
    DISPID_ICSetEventInterest               = 0x0000000a,
    DISPID_ICGetEventInterest               = 0x0000000b,
    DISPID_IOEditingMode                    = 0x0000000c,
    DISPID_IOSelection                      = 0x0000000d,
    DISPID_IOAttachMode                     = 0x0000000e,
    DISPID_IOHitTestSelection               = 0x0000000f,
    DISPID_IODraw                           = 0x00000010,
    DISPID_IPPicture                        = 0x00000011,
    DISPID_IPSizeMode                       = 0x00000012,
    DISPID_IPBackColor                      = 0x00000013,
    DISPID_ICCursors                        = 0x00000014,
    DISPID_ICMarginX                        = 0x00000015,
    DISPID_ICMarginY                        = 0x00000016,
    DISPID_ICSetWindowInputRectangle        = 0x00000017,
    DISPID_ICGetWindowInputRectangle        = 0x00000018,
    DISPID_ICTablet                         = 0x00000019,
    DISPID_ICSetAllTabletsMode              = 0x0000001a,
    DISPID_ICSetSingleTabletIntegratedMode  = 0x0000001b,
    DISPID_ICCollectionMode                 = 0x0000001c,
    DISPID_ICSetGestureStatus               = 0x0000001d,
    DISPID_ICGetGestureStatus               = 0x0000001e,
    DISPID_ICDynamicRendering               = 0x0000001f,
    DISPID_ICDesiredPacketDescription       = 0x00000020,
    DISPID_IOEraserMode                     = 0x00000021,
    DISPID_IOEraserWidth                    = 0x00000022,
    DISPID_ICMouseIcon                      = 0x00000023,
    DISPID_ICMousePointer                   = 0x00000024,
    DISPID_IPInkEnabled                     = 0x00000025,
    DISPID_ICSupportHighContrastInk         = 0x00000026,
    DISPID_IOSupportHighContrastSelectionUI = 0x00000027,
}

alias DISPID_InkRecognizer = int;
enum : int
{
    DISPID_RecoClsid                      = 0x00000001,
    DISPID_RecoName                       = 0x00000002,
    DISPID_RecoVendor                     = 0x00000003,
    DISPID_RecoCapabilities               = 0x00000004,
    DISPID_RecoLanguageID                 = 0x00000005,
    DISPID_RecoPreferredPacketDescription = 0x00000006,
    DISPID_RecoCreateRecognizerContext    = 0x00000007,
    DISPID_RecoSupportedProperties        = 0x00000008,
}

///Specifies the attributes of a recognizer. You also use this enumeration to determine which attributes to use when you
///search for an installed recognizer.
enum InkRecognizerCapabilities : int
{
    ///Ignores all other flags that are set.
    IRC_DontCare                     = 0x00000001,
    ///The recognizer performs object recognition; otherwise, the recognizer performs text recognition.
    IRC_Object                       = 0x00000002,
    ///The recognizer supports free input. Ink is entered without the use of a recognition guide, such as lines or
    ///boxes.
    IRC_FreeInput                    = 0x00000004,
    ///The recognizer supports lined input, which is similar to writing on lined paper.
    IRC_LinedInput                   = 0x00000008,
    ///The recognizer supports boxed input, in which each character or word is entered in a box.
    IRC_BoxedInput                   = 0x00000010,
    ///The recognizer supports character Autocomplete. Recognizers that support character Autocomplete require boxed
    ///input.
    IRC_CharacterAutoCompletionInput = 0x00000020,
    ///The recognizer supports western and Asian languages.
    IRC_RightAndDown                 = 0x00000040,
    ///The recognizer supports Hebrew and Arabic languages.
    IRC_LeftAndDown                  = 0x00000080,
    ///The recognizer supports Asian languages.
    IRC_DownAndLeft                  = 0x00000100,
    ///The recognizer supports the Chinese language.
    IRC_DownAndRight                 = 0x00000200,
    ///The recognizer supports text that is written at arbitrary angles.
    IRC_ArbitraryAngle               = 0x00000400,
    ///The recognizer can return a lattice object.
    IRC_Lattice                      = 0x00000800,
    ///The recognizer's background recognition can be interrupted, as in when the ink has changed.
    IRC_AdviseInkChange              = 0x00001000,
    ///Specifies that stroke order - spatial and temporal - is handled.
    IRC_StrokeReorder                = 0x00002000,
    ///The recognizer supports personalization.
    IRC_Personalizable               = 0x00004000,
    IRC_PrefersArbitraryAngle        = 0x00008000,
    IRC_PrefersParagraphBreaking     = 0x00010000,
    IRC_PrefersSegmentation          = 0x00020000,
    IRC_Cursive                      = 0x00040000,
    IRC_TextPrediction               = 0x00080000,
    IRC_Alpha                        = 0x00100000,
    IRC_Beta                         = 0x00200000,
}

alias DISPID_InkRecognizer2 = int;
enum : int
{
    DISPID_RecoId            = 0x00000000,
    DISPID_RecoUnicodeRanges = 0x00000001,
}

alias DISPID_InkRecognizers = int;
enum : int
{
    DISPID_IRecos_NewEnum             = 0xfffffffc,
    DISPID_IRecosItem                 = 0x00000000,
    DISPID_IRecosCount                = 0x00000001,
    DISPID_IRecosGetDefaultRecognizer = 0x00000002,
}

///Specifies types of character input modes.
enum InkRecognizerCharacterAutoCompletionMode : int
{
    ///Recognition occurs as if all strokes have been input.
    IRCACM_Full   = 0x00000000,
    ///Recognition occurs on partial input. The order of the strokes must conform to the rules of the language.
    IRCACM_Prefix = 0x00000001,
    ///Recognition occurs on partial input. The order of the strokes can be arbitrary.
    IRCACM_Random = 0x00000002,
}

///Specifies how the recognizer interprets the ink and determines the result string.
enum InkRecognitionModes : int
{
    ///The recognizer applies no recognition modes.
    IRM_None                   = 0x00000000,
    ///The recognizer treats the ink as a single word. For example, if the recognizer context contains to get her, the
    ///recognizer returns together. <div class="alert"><b>Note</b> Some compound words in the dictionary are treated as
    ///single words by recognizers of Latin script. For example, recognizers of Latin script treat "Los Angeles" as a
    ///single word if you use the WordMode flag. In addition, certain factoids-such as the Date Factoid in English
    ///(United Kingdom), English (United States), German, and French-treat some multiple word dates as single words. For
    ///example, these recognizers treat "January 21, 2000" as a single word if you use the WordMode flag.</div> <div>
    ///</div>
    IRM_WordModeOnly           = 0x00000001,
    ///The recognizer coerces the result based on the factoid that you specified for the context. For example, if you
    ///specified the Telephone factoid and the user enters the word hello, the recognizer may return a random phone
    ///number or an empty string. If you do not specify this flag, the recognizer returns hello as the result.
    IRM_Coerce                 = 0x00000002,
    ///The recognizer disables multiple segmentation. This turns off the recognizer's ability to return recognition
    ///results based on more than one recognition segment of the ink, where each segment corresponds to a word (in
    ///recognizers of Latin script) or a character (in recognizers of East Asian characters). In other words, the word
    ///together always returns alternates based on together being a single word, and the recognizer does not consider
    ///that the string might also be "to get her" or some other variation with differing segmentation. Turning on this
    ///flag enhances recognition speed.
    IRM_TopInkBreaksOnly       = 0x00000004,
    ///The recognizer applies partial word recognition.
    IRM_PrefixOk               = 0x00000008,
    ///The recognizer does not emply line breaking inside the recognizer and all of the ink is recognized as one line.
    IRM_LineMode               = 0x00000010,
    ///The recognizer disables personalization on the recognizer.
    IRM_DisablePersonalization = 0x00000020,
    ///The recognizer should automatically determine word breaks between newly written (and recognized) text and the
    ///suffix and prefix. For example, when AutoSpace is enabled and the user inserts bye after the recognized word,
    ///good, the recognizer returns bye with no space inserted before it as the recognized text because the compound
    ///"goodbye" is a valid word. If the user inserts world after the recognized word, hello, the recognizer returns
    ///world with a space inserted before it as the recognized text to produce the words, hello world. If AutoSpace is
    ///disabled, the recognizer returns world with no space. This flag is used only by recognizers of Latin script.
    IRM_AutoSpace              = 0x00000040,
    ///For internal use only.
    IRM_Max                    = 0x00000080,
}

alias DISPID_InkRecognitionEvent = int;
enum : int
{
    DISPID_IRERecognitionWithAlternates = 0x00000001,
    DISPID_IRERecognition               = 0x00000002,
}

alias DISPID_InkRecoContext = int;
enum : int
{
    DISPID_IRecoCtx_Strokes                           = 0x00000001,
    DISPID_IRecoCtx_CharacterAutoCompletionMode       = 0x00000002,
    DISPID_IRecoCtx_Factoid                           = 0x00000003,
    DISPID_IRecoCtx_WordList                          = 0x00000004,
    DISPID_IRecoCtx_Recognizer                        = 0x00000005,
    DISPID_IRecoCtx_Guide                             = 0x00000006,
    DISPID_IRecoCtx_Flags                             = 0x00000007,
    DISPID_IRecoCtx_PrefixText                        = 0x00000008,
    DISPID_IRecoCtx_SuffixText                        = 0x00000009,
    DISPID_IRecoCtx_StopRecognition                   = 0x0000000a,
    DISPID_IRecoCtx_Clone                             = 0x0000000b,
    DISPID_IRecoCtx_Recognize                         = 0x0000000c,
    DISPID_IRecoCtx_StopBackgroundRecognition         = 0x0000000d,
    DISPID_IRecoCtx_EndInkInput                       = 0x0000000e,
    DISPID_IRecoCtx_BackgroundRecognize               = 0x0000000f,
    DISPID_IRecoCtx_BackgroundRecognizeWithAlternates = 0x00000010,
    DISPID_IRecoCtx_IsStringSupported                 = 0x00000011,
}

alias DISPID_InkRecoContext2 = int;
enum : int
{
    DISPID_IRecoCtx2_EnabledUnicodeRanges = 0x00000000,
}

///Not implemented.
enum InkRecognitionAlternatesSelection : int
{
    ///Reserved.
    IRAS_Start        = 0x00000000,
    ///Reserved.
    IRAS_DefaultCount = 0x0000000a,
    IRAS_All          = 0xffffffff,
}

alias DISPID_InkRecognitionResult = int;
enum : int
{
    DISPID_InkRecognitionResult_TopString               = 0x00000001,
    DISPID_InkRecognitionResult_TopAlternate            = 0x00000002,
    DISPID_InkRecognitionResult_Strokes                 = 0x00000003,
    DISPID_InkRecognitionResult_TopConfidence           = 0x00000004,
    DISPID_InkRecognitionResult_AlternatesFromSelection = 0x00000005,
    DISPID_InkRecognitionResult_ModifyTopAlternate      = 0x00000006,
    DISPID_InkRecognitionResult_SetResultOnStrokes      = 0x00000007,
}

alias DISPID_InkRecoAlternate = int;
enum : int
{
    DISPID_InkRecoAlternate_String                               = 0x00000001,
    DISPID_InkRecoAlternate_LineNumber                           = 0x00000002,
    DISPID_InkRecoAlternate_Baseline                             = 0x00000003,
    DISPID_InkRecoAlternate_Midline                              = 0x00000004,
    DISPID_InkRecoAlternate_Ascender                             = 0x00000005,
    DISPID_InkRecoAlternate_Descender                            = 0x00000006,
    DISPID_InkRecoAlternate_Confidence                           = 0x00000007,
    DISPID_InkRecoAlternate_Strokes                              = 0x00000008,
    DISPID_InkRecoAlternate_GetStrokesFromStrokeRanges           = 0x00000009,
    DISPID_InkRecoAlternate_GetStrokesFromTextRange              = 0x0000000a,
    DISPID_InkRecoAlternate_GetTextRangeFromStrokes              = 0x0000000b,
    DISPID_InkRecoAlternate_GetPropertyValue                     = 0x0000000c,
    DISPID_InkRecoAlternate_LineAlternates                       = 0x0000000d,
    DISPID_InkRecoAlternate_ConfidenceAlternates                 = 0x0000000e,
    DISPID_InkRecoAlternate_AlternatesWithConstantPropertyValues = 0x0000000f,
}

alias DISPID_InkRecognitionAlternates = int;
enum : int
{
    DISPID_InkRecognitionAlternates_NewEnum = 0xfffffffc,
    DISPID_InkRecognitionAlternates_Item    = 0x00000000,
    DISPID_InkRecognitionAlternates_Count   = 0x00000001,
    DISPID_InkRecognitionAlternates_Strokes = 0x00000002,
}

alias DISPID_InkRecognizerGuide = int;
enum : int
{
    DISPID_IRGWritingBox = 0x00000001,
    DISPID_IRGDrawnBox   = 0x00000002,
    DISPID_IRGRows       = 0x00000003,
    DISPID_IRGColumns    = 0x00000004,
    DISPID_IRGMidline    = 0x00000005,
    DISPID_IRGGuideData  = 0x00000006,
}

alias DISPID_InkWordList = int;
enum : int
{
    DISPID_InkWordList_AddWord    = 0x00000000,
    DISPID_InkWordList_RemoveWord = 0x00000001,
    DISPID_InkWordList_Merge      = 0x00000002,
}

alias DISPID_InkWordList2 = int;
enum : int
{
    DISPID_InkWordList2_AddWords = 0x00000003,
}

///Defines values for the structural types within the IInkDivisionResult object.
enum InkDivisionType : int
{
    ///A recognition segment.
    IDT_Segment   = 0x00000000,
    ///A line of handwriting that contains one or more recognition segments.
    IDT_Line      = 0x00000001,
    ///A block of strokes that contains one or more lines of handwriting.
    IDT_Paragraph = 0x00000002,
    ///Ink that is not text.
    IDT_Drawing   = 0x00000003,
}

alias DISPID_InkDivider = int;
enum : int
{
    DISPID_IInkDivider_Strokes           = 0x00000001,
    DISPID_IInkDivider_RecognizerContext = 0x00000002,
    DISPID_IInkDivider_LineHeight        = 0x00000003,
    DISPID_IInkDivider_Divide            = 0x00000004,
}

alias DISPID_InkDivisionResult = int;
enum : int
{
    DISPID_IInkDivisionResult_Strokes      = 0x00000001,
    DISPID_IInkDivisionResult_ResultByType = 0x00000002,
}

alias DISPID_InkDivisionUnit = int;
enum : int
{
    DISPID_IInkDivisionUnit_Strokes           = 0x00000001,
    DISPID_IInkDivisionUnit_DivisionType      = 0x00000002,
    DISPID_IInkDivisionUnit_RecognizedString  = 0x00000003,
    DISPID_IInkDivisionUnit_RotationTransform = 0x00000004,
}

alias DISPID_InkDivisionUnits = int;
enum : int
{
    DISPID_IInkDivisionUnits_NewEnum = 0xfffffffc,
    DISPID_IInkDivisionUnits_Item    = 0x00000000,
    DISPID_IInkDivisionUnits_Count   = 0x00000001,
}

alias DISPID_PenInputPanel = int;
enum : int
{
    DISPID_PIPAttachedEditWindow = 0x00000000,
    DISPID_PIPFactoid            = 0x00000001,
    DISPID_PIPCurrentPanel       = 0x00000002,
    DISPID_PIPDefaultPanel       = 0x00000003,
    DISPID_PIPVisible            = 0x00000004,
    DISPID_PIPTop                = 0x00000005,
    DISPID_PIPLeft               = 0x00000006,
    DISPID_PIPWidth              = 0x00000007,
    DISPID_PIPHeight             = 0x00000008,
    DISPID_PIPMoveTo             = 0x00000009,
    DISPID_PIPCommitPendingInput = 0x0000000a,
    DISPID_PIPRefresh            = 0x0000000b,
    DISPID_PIPBusy               = 0x0000000c,
    DISPID_PIPVerticalOffset     = 0x0000000d,
    DISPID_PIPHorizontalOffset   = 0x0000000e,
    DISPID_PIPEnableTsf          = 0x0000000f,
    DISPID_PIPAutoShow           = 0x00000010,
}

alias DISPID_PenInputPanelEvents = int;
enum : int
{
    DISPID_PIPEVisibleChanged = 0x00000000,
    DISPID_PIPEPanelChanged   = 0x00000001,
    DISPID_PIPEInputFailed    = 0x00000002,
    DISPID_PIPEPanelMoving    = 0x00000003,
}

enum VisualState : int
{
    InPlace      = 0x00000000,
    Floating     = 0x00000001,
    DockedTop    = 0x00000002,
    DockedBottom = 0x00000003,
    Closed       = 0x00000004,
}

///Specifies the interaction modes that can be chosen by the user for the Tablet PC Input Panel.
enum InteractionMode : int
{
    ///The Input Panel appears next to the text insertion point that currently has focus.
    InteractionMode_InPlace      = 0x00000000,
    ///The Input Panel is not tied to an insertion point. The Floating Input Panel is opened by tapping on the Input
    ///Panel tab which appears by default on the left edge of the screen. The positioning and control of the Input Panel
    ///is left entirely to the user.
    InteractionMode_Floating     = 0x00000001,
    ///The Input Panel appears at the top of the screen and the active desktop is resized so that the Input Panel does
    ///not overlap with any other windows or UI elements.
    InteractionMode_DockedTop    = 0x00000002,
    InteractionMode_DockedBottom = 0x00000003,
}

///Specifies the In-Place state values of the Tablet PC Input Panel.
enum InPlaceState : int
{
    ///The system decides which In-Place state of the Input Panel is the most appropriate.
    InPlaceState_Auto        = 0x00000000,
    ///The Input Panel Icon appears. The expanded Input Panel will not appear.
    InPlaceState_HoverTarget = 0x00000001,
    ///The In-Place Input Panel always appears expanded, rather than the Input Panel Icon appearing first and then
    ///requiring the user to tap the Input Panel Icon before Input Panel expands.
    InPlaceState_Expanded    = 0x00000002,
}

///Specifies the values that represent the default input areas of the Tablet PC Input Panel.
enum PanelInputArea : int
{
    ///The system controls the default input area.
    PanelInputArea_Auto         = 0x00000000,
    ///The keyboard is the default input area.
    PanelInputArea_Keyboard     = 0x00000001,
    ///The writing pad is the default input area.
    PanelInputArea_WritingPad   = 0x00000002,
    PanelInputArea_CharacterPad = 0x00000003,
}

///Specifies the correction modes of the Tablet PC Input Panel.
enum CorrectionMode : int
{
    ///The Input Panel and the correction comb are not visible.
    CorrectionMode_NotVisible             = 0x00000000,
    ///The correction comb is shown in pre-insertion mode.
    CorrectionMode_PreInsertion           = 0x00000001,
    ///The correction comb is shown in post-insertion collapsed mode.
    CorrectionMode_PostInsertionCollapsed = 0x00000002,
    ///The correction comb is shown in post-insertion expanded mode.
    CorrectionMode_PostInsertionExpanded  = 0x00000003,
}

///Specifies the direction, relative to Input Panel, that the post insertion correction comb displays.
enum CorrectionPosition : int
{
    ///The system decides on the position of the correction comb.
    CorrectionPosition_Auto   = 0x00000000,
    ///The correction comb is shown below the input area.
    CorrectionPosition_Bottom = 0x00000001,
    ///The correction comb is shown above the input area.
    CorrectionPosition_Top    = 0x00000002,
}

///Specifies the preferred direction of the In-Place Input Panel relative to the text entry field.
enum InPlaceDirection : int
{
    ///Restores the system default.
    InPlaceDirection_Auto   = 0x00000000,
    ///The preferred direction is above the text entry field.
    InPlaceDirection_Bottom = 0x00000001,
    ///The preferred direction is below the text entry field.
    InPlaceDirection_Top    = 0x00000002,
}

///The events on the ITextInputPanel Interface that you can set attention for.
enum EventMask : int
{
    ///Occurs when the correction mode is about to change.
    EventMask_InPlaceStateChanging      = 0x00000001,
    ///Occurs when the correction mode has changed.
    EventMask_InPlaceStateChanged       = 0x00000002,
    ///Occurs when the in-place Input Panel size is about to change due to user resizing, auto growth or an input area
    ///change.
    EventMask_InPlaceSizeChanging       = 0x00000004,
    ///Occurs when the in-place Input Panel size has changed due to a user resize, auto growth, or an input area change.
    EventMask_InPlaceSizeChanged        = 0x00000008,
    ///Occurs when the input area is about to change.
    EventMask_InputAreaChanging         = 0x00000010,
    ///Occurs when the input area has changed.
    EventMask_InputAreaChanged          = 0x00000020,
    ///Occurs when the correction mode is about to change.
    EventMask_CorrectionModeChanging    = 0x00000040,
    ///Occurs when the correction mode has changed.
    EventMask_CorrectionModeChanged     = 0x00000080,
    ///Occurs when the in-place Input Panel visibility is about to change.
    EventMask_InPlaceVisibilityChanging = 0x00000100,
    ///Occurs when the input area has changed.
    EventMask_InPlaceVisibilityChanged  = 0x00000200,
    ///Occurs when Tablet PC Input Panel is about to insert text into the control with input focus.
    EventMask_TextInserting             = 0x00000400,
    ///Occurs when the Tablet PC Input Panel has inserted text into the control with input focus.
    EventMask_TextInserted              = 0x00000800,
    ///Represents a bitwise combination of all member events.
    EventMask_All                       = 0x00000fff,
}

///Defines the type of input currently available in the PenInputPanel object.
enum PanelType : int
{
    ///The PenInputPanel object displays the last panel type used for any pen input panel in any application. If all
    ///previous references to the pen input panel have been destroyed in all active applications, a new pen input panel
    ///will use the handwriting panel type.
    PT_Default     = 0x00000000,
    ///The PenInputPanel object does not accept input. This value is returned by the CurrentPanel property when the
    ///panel window is owned by another instance of the <b>PenInputPanel</b> object. This value is also returned if the
    ///panel window has not yet been activated.
    PT_Inactive    = 0x00000001,
    ///The PenInputPanel object displays the default handwriting panel for the current input language.
    PT_Handwriting = 0x00000002,
    ///The PenInputPanel object displays the default keyboard panel for the current input language.
    PT_Keyboard    = 0x00000003,
}

///Defines the directions in which a pen flick has occurred.
alias FLICKDIRECTION = int;
enum : int
{
    FLICKDIRECTION_MIN       = 0x00000000,
    ///A pen flick to the right.
    FLICKDIRECTION_RIGHT     = 0x00000000,
    ///A pen flick to the upper right.
    FLICKDIRECTION_UPRIGHT   = 0x00000001,
    ///An upward pen flick.
    FLICKDIRECTION_UP        = 0x00000002,
    ///A pen flick to the upper left.
    FLICKDIRECTION_UPLEFT    = 0x00000003,
    ///A pen flick to the left.
    FLICKDIRECTION_LEFT      = 0x00000004,
    ///A pen flick to the lower left.
    FLICKDIRECTION_DOWNLEFT  = 0x00000005,
    ///A downward pen flick.
    FLICKDIRECTION_DOWN      = 0x00000006,
    ///A pen flick to the down right.
    FLICKDIRECTION_DOWNRIGHT = 0x00000007,
    ///An invalid pen flick.
    FLICKDIRECTION_INVALID   = 0x00000008,
}

///Describes where Flick gestures are enabled.
alias FLICKMODE = int;
enum : int
{
    FLICKMODE_MIN      = 0x00000000,
    ///Pen flicks are not enabled.
    FLICKMODE_OFF      = 0x00000000,
    ///Pen flicks are enabled.
    FLICKMODE_ON       = 0x00000001,
    FLICKMODE_LEARNING = 0x00000002,
    FLICKMODE_MAX      = 0x00000002,
    FLICKMODE_DEFAULT  = 0x00000001,
}

///Defines the possible flick actions that can be assigned to a pen flick.
alias FLICKACTION_COMMANDCODE = int;
enum : int
{
    ///No action is assigned to the pen flick.
    FLICKACTION_COMMANDCODE_NULL        = 0x00000000,
    ///A scrolling command is assigned to the pen flick.
    FLICKACTION_COMMANDCODE_SCROLL      = 0x00000001,
    ///An application command is assigned to a pen flick.
    FLICKACTION_COMMANDCODE_APPCOMMAND  = 0x00000002,
    ///A customized key sequence is assigned to the pen flick.
    FLICKACTION_COMMANDCODE_CUSTOMKEY   = 0x00000003,
    ///A key modifier is assigned to the pen flick.
    FLICKACTION_COMMANDCODE_KEYMODIFIER = 0x00000004,
}

///Defines the direction of the scrolling command for a pen flick.
alias SCROLLDIRECTION = int;
enum : int
{
    ///The flick action is a Scroll Up command.
    SCROLLDIRECTION_UP   = 0x00000000,
    ///The flick action is a Scroll Down command.
    SCROLLDIRECTION_DOWN = 0x00000001,
}

///Determines which, if any, modifier keys were pressed when the flick gesture occurred.
alias KEYMODIFIER = int;
enum : int
{
    ///The Control key was pressed when the Flicks gesture occurred.
    KEYMODIFIER_CONTROL = 0x00000001,
    ///The Menu key was pressed when the Flicks gesture occurred.
    KEYMODIFIER_MENU    = 0x00000002,
    ///The Shift key was pressed when the Flicks gesture occurred.
    KEYMODIFIER_SHIFT   = 0x00000004,
    ///The Windows key was pressed when the Flicks gesture occurred.
    KEYMODIFIER_WIN     = 0x00000008,
    ///The Alt key was pressed when the Flicks gesture occurred.
    KEYMODIFIER_ALTGR   = 0x00000010,
    KEYMODIFIER_EXT     = 0x00000020,
}

///Specifies which mouse button was pressed.
enum MouseButton : int
{
    ///Default. No mouse button was pressed.
    NO_BUTTON     = 0x00000000,
    ///The left mouse button was pressed.
    LEFT_BUTTON   = 0x00000001,
    ///The right mouse button was pressed.
    RIGHT_BUTTON  = 0x00000002,
    ///The middle mouse button was pressed.
    MIDDLE_BUTTON = 0x00000004,
}

///Specifies the alignment of the paragraph relative to the margins of the InkEdit control.
enum SelAlignmentConstants : int
{
    ///Default. The paragraph is aligned along the left margin.
    rtfLeft   = 0x00000000,
    ///The paragraph is aligned along the right margin.
    rtfRight  = 0x00000001,
    ///The paragraph is centered between the left and right margins.
    rtfCenter = 0x00000002,
}

alias DISPID_InkEdit = int;
enum : int
{
    DISPID_Text               = 0x00000000,
    DISPID_TextRTF            = 0x00000001,
    DISPID_Hwnd               = 0x00000002,
    DISPID_DisableNoScroll    = 0x00000003,
    DISPID_Locked             = 0x00000004,
    DISPID_Enabled            = 0x00000005,
    DISPID_MaxLength          = 0x00000006,
    DISPID_MultiLine          = 0x00000007,
    DISPID_ScrollBars         = 0x00000008,
    DISPID_RTSelStart         = 0x00000009,
    DISPID_RTSelLength        = 0x0000000a,
    DISPID_RTSelText          = 0x0000000b,
    DISPID_SelAlignment       = 0x0000000c,
    DISPID_SelBold            = 0x0000000d,
    DISPID_SelCharOffset      = 0x0000000e,
    DISPID_SelColor           = 0x0000000f,
    DISPID_SelFontName        = 0x00000010,
    DISPID_SelFontSize        = 0x00000011,
    DISPID_SelItalic          = 0x00000012,
    DISPID_SelRTF             = 0x00000013,
    DISPID_SelUnderline       = 0x00000014,
    DISPID_DragIcon           = 0x00000015,
    DISPID_Status             = 0x00000016,
    DISPID_UseMouseForInput   = 0x00000017,
    DISPID_InkMode            = 0x00000018,
    DISPID_InkInsertMode      = 0x00000019,
    DISPID_RecoTimeout        = 0x0000001a,
    DISPID_DrawAttr           = 0x0000001b,
    DISPID_Recognizer         = 0x0000001c,
    DISPID_Factoid            = 0x0000001d,
    DISPID_SelInk             = 0x0000001e,
    DISPID_SelInksDisplayMode = 0x0000001f,
    DISPID_Recognize          = 0x00000020,
    DISPID_GetGestStatus      = 0x00000021,
    DISPID_SetGestStatus      = 0x00000022,
    DISPID_Refresh            = 0x00000023,
}

alias DISPID_InkEditEvents = int;
enum : int
{
    DISPID_IeeChange            = 0x00000001,
    DISPID_IeeSelChange         = 0x00000002,
    DISPID_IeeKeyDown           = 0x00000003,
    DISPID_IeeKeyUp             = 0x00000004,
    DISPID_IeeMouseUp           = 0x00000005,
    DISPID_IeeMouseDown         = 0x00000006,
    DISPID_IeeKeyPress          = 0x00000007,
    DISPID_IeeDblClick          = 0x00000008,
    DISPID_IeeClick             = 0x00000009,
    DISPID_IeeMouseMove         = 0x0000000a,
    DISPID_IeeCursorDown        = 0x00000015,
    DISPID_IeeStroke            = 0x00000016,
    DISPID_IeeGesture           = 0x00000017,
    DISPID_IeeRecognitionResult = 0x00000018,
}

///Specifies the collection mode for drawn ink-whether ink collection is disabled, ink is collected, or ink and gestures
///are collected.
enum InkMode : int
{
    ///Ink collection is disabled. No strokes are created when in this mode.
    IEM_Disabled      = 0x00000000,
    ///Ink only is collected, creating a stroke.
    IEM_Ink           = 0x00000001,
    ///Default. Ink is collected and single-stroke gestures are accepted.
    IEM_InkAndGesture = 0x00000002,
}

///Specifies how ink is inserted onto the InkEdit control.
enum InkInsertMode : int
{
    ///Default. Drawn ink is inserted as text.
    IEM_InsertText = 0x00000000,
    ///Drawn ink is inserted as ink.
    IEM_InsertInk  = 0x00000001,
}

///Specifies whether the InkEdit control is idle, collecting ink, or recognizing ink.
enum InkEditStatus : int
{
    ///The InkEdit control is neither collecting nor recognizing ink.
    IES_Idle        = 0x00000000,
    ///The InkEdit control is collecting ink.
    IES_Collecting  = 0x00000001,
    ///The InkEdit control is recognizing ink.
    IES_Recognizing = 0x00000002,
}

///Specifies how a selection appears on the control.
enum InkDisplayMode : int
{
    ///The selection appears as ink.
    IDM_Ink  = 0x00000000,
    ///The selection appears as text.
    IDM_Text = 0x00000001,
}

///Specifies how an InkEdit control appears on the screen.
enum AppearanceConstants : int
{
    ///Flat. Paints without visual effects.
    rtfFlat   = 0x00000000,
    ///Default. 3D. Paints with three-dimensional effects.
    rtfThreeD = 0x00000001,
}

///Specifies how the borders of an InkEdit control appear on the screen.
enum BorderStyleConstants : int
{
    ///No border.
    rtfNoBorder    = 0x00000000,
    ///Single line border.
    rtfFixedSingle = 0x00000001,
}

///Specifies how the scroll bars of an InkEdit control appear on the screen.
enum ScrollBarsConstants : int
{
    ///Default. No scroll bars.
    rtfNone       = 0x00000000,
    ///Horizontal scroll bar only.
    rtfHorizontal = 0x00000001,
    ///Vertical scroll bar only.
    rtfVertical   = 0x00000002,
    ///Both horizontal and vertical scroll bars.
    rtfBoth       = 0x00000003,
}

///Specifies the user interface (UI) elements of a math input control (MIC).
alias MICUIELEMENT = int;
enum : int
{
    ///The <b>Write</b> button.
    MICUIELEMENT_BUTTON_WRITE           = 0x00000001,
    ///The <b>Erase</b> button.
    MICUIELEMENT_BUTTON_ERASE           = 0x00000002,
    ///The <b>Select and Correct</b> button.
    MICUIELEMENT_BUTTON_CORRECT         = 0x00000004,
    ///The <b>Clear</b> button.
    MICUIELEMENT_BUTTON_CLEAR           = 0x00000008,
    ///The <b>Undo</b> button.
    MICUIELEMENT_BUTTON_UNDO            = 0x00000010,
    ///The <b>Redo</b> button.
    MICUIELEMENT_BUTTON_REDO            = 0x00000020,
    ///The <b>Insert</b> button.
    MICUIELEMENT_BUTTON_INSERT          = 0x00000040,
    ///The <b>Cancel</b> button.
    MICUIELEMENT_BUTTON_CANCEL          = 0x00000080,
    ///The writing-area background.
    MICUIELEMENT_INKPANEL_BACKGROUND    = 0x00000100,
    ///The result preview-area background.
    MICUIELEMENT_RESULTPANEL_BACKGROUND = 0x00000200,
}

///Specifies the button states of a math input control (MIC).
alias MICUIELEMENTSTATE = int;
enum : int
{
    ///The button does not have the mouse hovering over it.
    MICUIELEMENTSTATE_NORMAL   = 0x00000001,
    ///The button has the mouse hovering over it.
    MICUIELEMENTSTATE_HOT      = 0x00000002,
    ///The button is pressed.
    MICUIELEMENTSTATE_PRESSED  = 0x00000003,
    ///The button is disabled.
    MICUIELEMENTSTATE_DISABLED = 0x00000004,
}

alias DISPID_MathInputControlEvents = int;
enum : int
{
    DISPID_MICInsert = 0x00000000,
    DISPID_MICClose  = 0x00000001,
    DISPID_MICPaint  = 0x00000002,
    DISPID_MICClear  = 0x00000003,
}

///Defines the values used by plug-ins to specify which event notifications the plug-ins receive.
enum RealTimeStylusDataInterest : int
{
    ///The plug-in receives notifications for all stylus data.
    RTSDI_AllData                = 0xffffffff,
    ///The plug-in receives no notifications for any stylus data.
    RTSDI_None                   = 0x00000000,
    ///An error has been added to the input queue.
    RTSDI_Error                  = 0x00000001,
    ///The RealTimeStylus Class object has been enabled.
    RTSDI_RealTimeStylusEnabled  = 0x00000002,
    ///The RealTimeStylus Class object has been disabled.
    RTSDI_RealTimeStylusDisabled = 0x00000004,
    ///A RealTimeStylus Class object encounters a new Stylus object.
    RTSDI_StylusNew              = 0x00000008,
    ///The Stylus object is in range of the digitizer. Notifies the implementing plug-in that the stylus is entering the
    ///input area of the RealTimeStylus Class object or is entering the detection range of the digitizer above the input
    ///area of the <b>RealTimeStylus Class</b> object.
    RTSDI_StylusInRange          = 0x00000010,
    ///The RealTimeStylus Class object is within range of, but not touching, the digitizer and is moving.
    RTSDI_InAirPackets           = 0x00000020,
    ///The RealTimeStylus Class object is out of range of the digitizer. Informs the implementing plug-in that the
    ///stylus is leaving the input area of the <b>RealTimeStylus Class</b> object or is leaving the detection range of
    ///the digitizer above the input area of the <b>RealTimeStylus Class</b> object.
    RTSDI_StylusOutOfRange       = 0x00000040,
    ///The stylus is in contact with the digitizer.
    RTSDI_StylusDown             = 0x00000080,
    ///The stylus is moving and is in contact with the digitizer.
    RTSDI_Packets                = 0x00000100,
    ///The stylus has broken physical contact with the digitizer.
    RTSDI_StylusUp               = 0x00000200,
    ///A user has realeased a stylus button.
    RTSDI_StylusButtonUp         = 0x00000400,
    ///A user has pressed a stylus button.
    RTSDI_StylusButtonDown       = 0x00000800,
    ///A system event has been detected.
    RTSDI_SystemEvents           = 0x00001000,
    ///A new tablet device has been detected by the system. Notifies the implementing plug-in when a
    ///Microsoft.Ink.Tablet object is added to the system.
    RTSDI_TabletAdded            = 0x00002000,
    ///A tablet device has been removed from the system. Notifies the implementing plug-in when a Microsoft.Ink.Tablet
    ///object is removed from the system.
    RTSDI_TabletRemoved          = 0x00004000,
    ///A plug-in has added data to a queue. You can identify the kind of custom data by either the GUID or Type.
    RTSDI_CustomStylusDataAdded  = 0x00008000,
    ///A tablet mapping to the screen has been changed or set.
    RTSDI_UpdateMapping          = 0x00010000,
    ///The plug-in receives the default stylus data.
    RTSDI_DefaultEvents          = 0x00009386,
}

///Specifies the queue to which stylus data is added.
enum StylusQueue : int
{
    ///Data is added to the input queue. When data is added to the input queue, it is automatically added to the output
    ///queue.
    SyncStylusQueue           = 0x00000001,
    ///Data is added to the output queue. The data is added before any data currently being processed.
    AsyncStylusQueueImmediate = 0x00000002,
    ///Data is added to the output queue.
    AsyncStylusQueue          = 0x00000003,
}

///Specifies the locks within the RealTimeStylus Class object that protect the <b>RealTimeStylus Class</b> object's
///members and properties from modification.
enum RealTimeStylusLockType : int
{
    ///The object lock protects the RealTimeStylus Class object's members and properties from modification.
    RTSLT_ObjLock         = 0x00000001,
    ///The object lock protects the synchronous plug-in collection from modification during event broadcasts.
    RTSLT_SyncEventLock   = 0x00000002,
    ///The object lock protects the asynchronous plug-in collection from modification during event broadcasts.
    RTSLT_AsyncEventLock  = 0x00000004,
    ///The system excludes callbacks from the object's event or modification lock.
    RTSLT_ExcludeCallback = 0x00000008,
    ///The object lock protects the RealTimeStylus Class synchronous object's members and properties from modification.
    RTSLT_SyncObjLock     = 0x0000000b,
    ///The object lock protects the RealTimeStylus Class asynchronous object's members and properties from modification.
    RTSLT_AsyncObjLock    = 0x0000000d,
}

///Represents the lines found in a recognition segment.
alias LINE_METRICS = int;
enum : int
{
    ///Requests baseline metrics. For an example that shows the baseline of a segment, see the Remarks section.
    LM_BASELINE  = 0x00000000,
    ///Requests midline metrics. For an example that shows the midline of a segment, see the remarks section.
    LM_MIDLINE   = 0x00000001,
    ///Requests ascender metrics. For an example that shows the ascender line of a segment, see the Remarks section.
    LM_ASCENDER  = 0x00000002,
    ///Requests descender metrics. For an example that shows the decender line of a segment, see the Remarks section.
    LM_DESCENDER = 0x00000003,
}

///Indicates the level of confidence the recognizer has in the recognition result.
alias CONFIDENCE_LEVEL = int;
enum : int
{
    ///The recognizer is confident that the best alternate is correct.
    CFL_STRONG       = 0x00000000,
    ///The recognizer is confident that the correct result is in the list of alternates.
    CFL_INTERMEDIATE = 0x00000001,
    CFL_POOR         = 0x00000002,
}

///Specifiers how to create alternates from a best result string.
alias ALT_BREAKS = int;
enum : int
{
    ///An alternate must use the same segment breaks as the best result string. For example, if you ask for an alternate
    ///list for the best result string of "together", the recognizer may return "Tunisia" but not "to get her". This is
    ///because "to get her" involves different segment breaks.
    ALT_BREAKS_SAME   = 0x00000000,
    ///An alternate must have different segment breaks than the best result string. Only one such alternate is returned.
    ///For example, alternates for the best result string of "to get her" may include "to gather" and "together".
    ///However, "to got her" is not returned because it has the same segment break as "to get her".
    ALT_BREAKS_UNIQUE = 0x00000001,
    ///The top-rated alternates are returned regardless of segment breaks. Thus "together" may return "Tunisia", "to get
    ///her", and "to gather" among others. The alternates are returned in order of their rating, from best to worst.
    ALT_BREAKS_FULL   = 0x00000002,
}

alias enumRECO_TYPE = int;
enum : int
{
    RECO_TYPE_WSTRING = 0x00000000,
    RECO_TYPE_WCHAR   = 0x00000001,
}

// Constants


enum const(wchar)* MICROSOFT_URL_EXPERIENCE_PROPERTY = "Microsoft TIP URL Experience";
enum const(wchar)* MICROSOFT_TIP_COMBOBOXLIST_PROPERTY = "Microsoft TIP ComboBox List Window Identifier";
enum int InkMinTransparencyValue = 0x00000000;

enum : int
{
    InkCollectorClipInkToMargin = 0x00000000,
    InkCollectorDefaultMargin   = 0x80000000,
}

// Callbacks

alias PfnRecoCallback = HRESULT function(uint param0, ubyte* param1, HRECOCONTEXT__* param2);

// Structs


///Contains information about a tablet system event.
struct SYSTEM_EVENT_DATA
{
    ///Bit values for the modifiers. Possible values include SE_MODIFIER_CTRL (the Control key was pressed),
    ///SE_MODIFIER_ALT (the Alt key was pressed), and SE_MODIFIER_SHIFT (the Shift key was pressed).
    ubyte  bModifier;
    ///Scan code for the keyboard character.
    ushort wKey;
    ///X position of the event.
    int    xPos;
    ///Y position of the event.
    int    yPos;
    ///The type of cursor that caused the event. Possible values include SE_NORMAL_CURSOR (the pen tip) and
    ///SE_ERASER_CURSOR (the eraser).
    ubyte  bCursorMode;
    ///State of the buttons at the time of the system event.
    uint   dwButtonState;
}

///Specifies a range of strokes in the InkDisp object.
struct STROKE_RANGE
{
    ///Index of the first stroke in the range, inclusive.
    uint iStrokeBegin;
    uint iStrokeEnd;
}

///Defines the range and resolution of a packet property.
struct PROPERTY_METRICS
{
    ///The minimum value, in logical units, that the tablet reports for this property. For example, a tablet reporting
    ///x-values from 0 to 9000 has a logical minimum of 0.
    int            nLogicalMin;
    ///The maximum value, in logical units, that the tablet reports for this property. For example, a tablet reporting
    ///x-values from 0 to 9000 has a logical maximum of 9000.
    int            nLogicalMax;
    ///The physical units of the property, such as inches or degrees. For a list of property units, see the
    ///PROPERTY_UNITS enumeration type.
    PROPERTY_UNITS Units;
    ///The resolution or increment value for the <code>Units</code> member. For example, a tablet that reports 400 dots
    ///per inch (dpi) has an <i>fResoution</i> value of 400.
    float          fResolution;
}

///Describes a packet property that is reported by the tablet driver.
struct PACKET_PROPERTY
{
    ///The property. This value is not limited to the set of predefined GUIDs. An application or a device driver may
    ///define new GUIDs at any time.
    GUID             guid;
    ///The range, units, and resolution of the packet property.
    PROPERTY_METRICS PropertyMetrics;
}

///Describes the content of the packet for a particular tablet recognizer context. Do not use this structure to access
///the data contained in a packet. This structure describes the content of the packet.
struct PACKET_DESCRIPTION
{
    ///The size, in bytes, of the packet data.
    uint             cbPacketSize;
    ///The number of elements in the <i>pPacketProperties</i> array.
    uint             cPacketProperties;
    ///An array of PACKET_PROPERTY structures.
    PACKET_PROPERTY* pPacketProperties;
    ///Deprecated. Do not use.
    uint             cButtons;
    ///Deprecated. Do not use.
    GUID*            pguidButtons;
}

///Specifies display properties for a text ink object (tInk).
struct INKMETRIC
{
    ///Ink height.
    int  iHeight;
    ///Assent height.
    int  iFontAscent;
    ///Descent height.
    int  iFontDescent;
    ///Ink metric flags. <table> <tr> <th>Ink Metric Flags </th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="IMF_FONT_SELECTED_IN_HDC"></a><a id="imf_font_selected_in_hdc"></a><dl>
    ///<dt><b>IMF_FONT_SELECTED_IN_HDC</b></dt> </dl> </td> <td width="60%"> Use the ambient properties of the
    ///surrounding text. </td> </tr> <tr> <td width="40%"><a id="IMF_ITALIC"></a><a id="imf_italic"></a><dl>
    ///<dt><b>IMF_ITALIC</b></dt> </dl> </td> <td width="60%"> Apply the italic style. </td> </tr> <tr> <td
    ///width="40%"><a id="IMF_BOLD"></a><a id="imf_bold"></a><dl> <dt><b>IMF_BOLD</b></dt> </dl> </td> <td width="60%">
    ///Apply the bold style. </td> </tr> </table>
    uint dwFlags;
    ///Ink color.
    uint color;
}

///Deprecated. Represents information about the <b>recognition guide</b>. Use the WritingBox Property, DrawnBox
///Property, Rows Property, Columns Property, and Midline Property [InkRecognizerGuide Class] properties instead.
struct InkRecoGuide
{
    ///Deprecated.
    RECT rectWritingBox;
    ///Deprecated.
    RECT rectDrawnBox;
    ///Deprecated.
    int  cRows;
    ///Deprecated.
    int  cColumns;
    ///Deprecated.
    int  midline;
}

///Provides information about a pen flick.
struct FLICK_POINT
{
    int _bitfield172;
}

///Contains information about a pen flick.
struct FLICK_DATA
{
    int _bitfield173;
}

///Contains information about a Stroke event.
struct IEC_STROKEINFO
{
    ///Specifies the NMHDR structure that contains standard information about the WM_NOTIFY message. The NMHDR structure
    ///contains the handle and identifier of the control that is sending the message and the notification code, which in
    ///this case is IECN_STROKE. The format of the NMHDR structure is: ```cpp typedef struct tagNMHDR { HWND hwndFrom;
    ///UINT idFrom; UINT code; } NMHDR; ```
    NMHDR          nmhdr;
    ///The IInkCursor object that was used to create the IInkStrokeDisp object.
    IInkCursor     Cursor;
    ///The IInkStrokeDisp object that was created.
    IInkStrokeDisp Stroke;
}

///Contains information about a specific gesture.
struct IEC_GESTUREINFO
{
    ///The NMHDR structure that contains standard information about the WM_NOTIFY message. The NMHDR structure contains
    ///the handle and identifier of the control that is sending the message and the notification code, which in this
    ///case is IECN_GESTURE. The format of the NMHDR structure is: ```cpp typedef struct tagNMHDR { HWND hwndFrom; UINT
    ///idFrom; UINT code; } NMHDR; ```
    NMHDR       nmhdr;
    ///The IInkCursor object that was used to create the gesture.
    IInkCursor  Cursor;
    ///The InkStrokes collection that makes up the gesture.
    IInkStrokes Strokes;
    ///An array of IInkGesture objects, in order of confidence. For more information about this member, see the Gesture
    ///event. For more information about the VARIANT structure, see Using the COM Library.
    VARIANT     Gestures;
}

///Contains information about an IInkRecognitionResult Interface object.
struct IEC_RECOGNITIONRESULTINFO
{
    ///The NMHDR structure that contains standard information about the WM_NOTIFY message. The NMHDR structure contains
    ///the handle and identifier of the control that is sending the message and the notification code, which in this
    ///case is IECN_RECOGNITIONRESULT. The format of the NMHDR structure is: ```cpp typedef struct tagNMHDR { HWND
    ///hwndFrom; UINT idFrom; UINT code; } NMHDR; ```
    NMHDR nmhdr;
    ///The IInkRecognitionResult object that contains recognition results.
    IInkRecognitionResult RecognitionResult;
}

///Provides information about the stylus.
struct StylusInfo
{
    ///Uniquely identifies the tablet.
    uint tcid;
    ///Uniquely identifies the stylus.
    uint cid;
    ///<b>TRUE</b> if the stylus is upside down, otherwise <b>FALSE</b>.
    BOOL bIsInvertedCursor;
}

struct GESTURE_DATA
{
    int gestureId;
    int recoConfidence;
    int strokeCount;
}

struct DYNAMIC_RENDERER_CACHED_DATA
{
    int              strokeId;
    IDynamicRenderer dynamicRenderer;
}

///Defines the boundaries of the ink to the recognizer.
struct RECO_GUIDE
{
    ///Left edge of the first box in ink space coordinates.
    int xOrigin;
    ///Top edge of first box in ink-space coordinates.
    int yOrigin;
    ///Width of each box in ink space units.
    int cxBox;
    ///Height of each box in ink-space units.
    int cyBox;
    ///Margin to the guideline. This is one-half the distance in ink-space units between adjacent boxes.
    int cxBase;
    ///Vertical distance in ink-space units from the baseline to the top of the box.
    int cyBase;
    ///Count of columns of boxes.
    int cHorzBox;
    ///Count of rows of boxes.
    int cVertBox;
    ///Distance in ink-space units from the baseline to the midline, or 0 if the midline is not present.
    int cyMid;
}

///Retrieves the attributes of a recognizer or specifies which attributes to use when you search for an installed
///recognizer.
struct RECO_ATTRS
{
    uint       dwRecoCapabilityFlags;
    ///Vendor who wrote the recognizer.
    ushort[32] awcVendorName;
    ///A human-readable name for the recognizer. Specify this name when you search for an installed recognizer.
    ushort[64] awcFriendlyName;
    ///List of language and sublanguage combinations that the recognizer supports. The list is <b>NULL</b> -terminated.
    ///Specify language identifiers when you search for an installed recognizer if the <i>awcFriendlyName</i> member
    ///contains an empty string. Use the MAKELANGID macro to create the language identifiers. If the recognizer does not
    ///distinguish between writing styles corresponding to different sublanguages, specify SUBLANG_NEUTRAL for the
    ///sublanguage identifier.
    ushort[64] awLanguageId;
}

///The structure is obsolete.
struct RECO_RANGE
{
    ///Zero-based index in the string of the current alternate that marks the beginning of the recognition segment.
    uint iwcBegin;
    ///Count of characters in the range.
    uint cCount;
}

///Describes the start and end points of a line recognition segment, such as the baseline or midline.
struct LINE_SEGMENT
{
    ///Point that represents the start of the line segment. The point is in ink space coordinates.
    POINT PtA;
    ///Point that represents the end of the line segment. The point is in ink space coordinates.
    POINT PtB;
}

///Describes the baseline and the midline height.
struct LATTICE_METRICS
{
    ///The LINE_SEGMENT structure containing the start and end point of the baseline, in ink coordinates.
    LINE_SEGMENT lsBaseline;
    ///Offset of the midline, relative to the baseline, in HIMETRIC units.
    short        iMidlineOffset;
}

///Contains a property used in the lattice.
struct RECO_LATTICE_PROPERTY
{
    ///GUID for the property value that is being assigned.
    GUID   guidProperty;
    ///Length in bytes of the <i>pPropertyValue</i> byte array.
    ushort cbPropertyValue;
    ///Byte array that points to the property data.
    ubyte* pPropertyValue;
}

///Contains an array of pointers to property structures.
struct RECO_LATTICE_PROPERTIES
{
    ///A count of the properties in the array of properties.
    uint cProperties;
    ///An array of pointers to properties.
    RECO_LATTICE_PROPERTY** apProps;
}

///Corresponds to one word or one East Asian character, typically; however, an element may also correspond to a gesture,
///a shape, or some other code.
struct RECO_LATTICE_ELEMENT
{
    ///Integer value that represents the shape probability assigned for this element.
    int    score;
    ///Describes whether the element contains wide string or wide character data. <code>enum
    ///enumRECO_TYPE</code><code>{</code><code>RECO_TYPE_WSTRING = 0,</code><code>RECO_TYPE_WCHAR = 1</code><code>}
    ///RECO_TYPE;</code>
    ushort type;
    ///Holds the recognition result. This can be a string or a character. Note: For recognizers of Latin script, the
    ///<code>pData</code> member contains a pointer to a <b>NULL</b>–terminated string of wide characters. For
    ///recognizers of East Asian characters, the <code>pData</code> member contains the wide character (WCHAR) value
    ///itself.
    ubyte* pData;
    ///Contains the index for the next column.
    uint   ulNextColumn;
    ///Count of strokes used by this alternate.
    uint   ulStrokeNumber;
    ///Properties structure. These are properties that are applicable to this element only. For details about
    ///properties, see the RECO_LATTICE_PROPERTIES structure.
    RECO_LATTICE_PROPERTIES epProp;
}

///Represents a column in the lattice.
struct RECO_LATTICE_COLUMN
{
    ///Unused. Should be set to 0 (zero).
    uint  key;
    ///Holds the properties for the column.
    RECO_LATTICE_PROPERTIES cpProp;
    ///Count of strokes in the <i>pStrokes</i> array for the longest element in the column.
    uint  cStrokes;
    ///An array of stroke indices in the order in which they were fed to the recognizer. For example, imagine you have
    ///two strokes, stroke one containing the word "back" and stroke two containing the word "door". The column
    ///containing "back" will have a strokes array containing one ULONG {0}. The column for "door" will have a strokes
    ///array containing two ULONG items {1,2}.
    uint* pStrokes;
    ///Number of members in <i>pLatticeElements</i>.
    uint  cLatticeElements;
    ///Array of RECO_LATTICE_ELEMENT structures.
    RECO_LATTICE_ELEMENT* pLatticeElements;
}

///Serves as the entry point into a lattice.
struct RECO_LATTICE
{
    ///The number of columns in the lattice.
    uint                 ulColumnCount;
    ///An array of RECO_LATTICE_COLUMN structures contained by the lattice.
    RECO_LATTICE_COLUMN* pLatticeColumns;
    ///The number of properties assigned to the lattice. For details about properties, see the RECO_LATTICE_PROPERTIES
    ///structure.
    uint                 ulPropertyCount;
    ///An array of property GUIDs. The GUIDS for these properties can either be the properties defined in the Msinkaut.h
    ///header file (for example, line metrics) or custom properties defined by your recognizer.
    GUID*                pGuidProperties;
    ///The number of columns that the best result consists of.
    uint                 ulBestResultColumnCount;
    ///An array containing the indexes of the columns in the <i>pLatticeColumns</i> array that makes up the best result.
    uint*                pulBestResultColumns;
    ///An array of indexes of the elements in the <i>pLatticeElements</i> array of the corresponding column designated
    ///by <i>pulBestResultColumn</i>.
    uint*                pulBestResultIndexes;
}

///Specifies a range of Unicode points (characters).
struct CHARACTER_RANGE
{
    ///The low Unicode code point in the range of supported Unicode points.
    ushort wcLow;
    ///The number of supported Unicode points in this range.
    ushort cChars;
}

struct HRECOALT__
{
    int unused;
}

struct HRECOCONTEXT__
{
    int unused;
}

struct HRECOGNIZER__
{
    int unused;
}

struct HRECOLATTICE__
{
    int unused;
}

struct HRECOWORDLIST__
{
    int unused;
}

// Functions

///Creates a recognizer.
///Params:
///    pCLSID = CLSID of the recognizer. This value is created in the registry when you register the recognizer.
///    phrec = Handle for the recognizer.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The parameter is an invalid
///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> An
///    invalid argument was received. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td>
///    <td width="60%"> Insufficient memory. </td> </tr> </table>
///    
@DllImport("inkobjcore")
HRESULT CreateRecognizer(GUID* pCLSID, HRECOGNIZER__** phrec);

///Destroys a recognizer.
///Params:
///    hrec = Handle to the recognizer.
@DllImport("inkobjcore")
HRESULT DestroyRecognizer(HRECOGNIZER__* hrec);

///Retrieves the attributes of the recognizer.
///Params:
///    hrec = Handle to the recognizer.
///    pRecoAttrs = The attributes of the recognizer. The attributes define the languages and capabilities that the recognizer
///                 supports. For more information, see the RECO_ATTRS structure.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> An invalid argument was received.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The parameter is an
///    invalid pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An
///    unspecified error occurred. </td> </tr> </table>
///    
@DllImport("inkobjcore")
HRESULT GetRecoAttributes(HRECOGNIZER__* hrec, RECO_ATTRS* pRecoAttrs);

///Creates a recognizer context.
///Params:
///    hrec = Handle to the recognizer.
///    phrc = Pointer to the recognizer context.
@DllImport("inkobjcore")
HRESULT CreateContext(HRECOGNIZER__* hrec, HRECOCONTEXT__** phrc);

///Destroys a recognizer context.
///Params:
///    hrc = Handle to the recognizer context.
@DllImport("inkobjcore")
HRESULT DestroyContext(HRECOCONTEXT__* hrc);

///Retrieves a list of properties the recognizer can return for a result range.
///Params:
///    hrec = Handle to the recognizer.
///    pPropertyCount = On input, the number of GUIDs the <i>pPropertyGuid</i> buffer can hold. On output, the number of GUIDs the
///                     <i>pPropertyGuid</i> buffer contains.
///    pPropertyGuid = Array of properties the recognizer can return. The order of the array is arbitrary. For a list of predefined
///                    properties, see the recognition Property GUIDs. To determine the required size of the buffer, set
///                    <i>pPropertyGuid</i> to <b>NULL</b>; use the number of GUIDs to allocate the buffer.
@DllImport("inkobjcore")
HRESULT GetResultPropertyList(HRECOGNIZER__* hrec, uint* pPropertyCount, GUID* pPropertyGuid);

///Returns the ranges of Unicode points that the recognizer supports.
///Params:
///    hrec = Handle to the recognizer.
///    pcRanges = On input, the number of ranges the <i>pcr</i> buffer can hold. On output, the number of ranges the <i>pcr</i>
///               buffer contains.
///    pcr = Array of CHARACTER_RANGE structures. Each structure contains a range of Unicode points that the recognizer
///          supports. The order of the array is arbitrary. To determine the required size of the buffer, set <i>pcr</i> to
///          <b>NULL</b>; use the number of ranges to allocate the <i>pcr</i> buffer.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> One of the parameters is an invalid
///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TPC_E_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td
///    width="60%"> The <i>pcr</i> buffer is too small. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt>
///    </dl> </td> <td width="60%"> An unspecified error occurred. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> An invalid argument was received. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory. </td> </tr>
///    </table>
///    
@DllImport("inkobjcore")
HRESULT GetUnicodeRanges(HRECOGNIZER__* hrec, uint* pcRanges, CHARACTER_RANGE* pcr);

///Adds an ink stroke to the RecognizerContext.
///Params:
///    hrc = The handle to the recognizer context.
///    pPacketDesc = Describes the contents of the packets. The description must match the contents of the packets in <i>pPacket</i>.
///                  If <b>NULL</b>, this function uses the GetPreferredPacketDescription function.
///    cbPacket = Size, in bytes, of the <i>pPacket</i> buffer.
///    pPacket = Array of packets that contain tablet space coordinates.
///    pXForm = Describes the transform that can be applied to ink to transform it from tablet space into ink space. A recognizer
///             may choose to ignore this transform and implement their own ink rotation algorithms. These recognizers should
///             still return properties calculated in the lattice data relative to this transform.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> One of the parameters is an invalid
///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Unable
///    to allocate memory to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>TPC_E_INVALID_PACKET_DESCRIPTION</b></dt> </dl> </td> <td width="60%"> The packet description does not
///    contain the necessary information for the packet to be considered valid. For example, it does not include a
///    GUID_X or GUID_Y property. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TPC_E_OUT_OF_ORDER_CALL</b></dt> </dl>
///    </td> <td width="60%"> The call to the method was made out of order. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> An invalid argument was received.
///    </td> </tr> </table>
///    
@DllImport("inkobjcore")
HRESULT AddStroke(HRECOCONTEXT__* hrc, const(PACKET_DESCRIPTION)* pPacketDesc, uint cbPacket, 
                  const(ubyte)* pPacket, const(XFORM)* pXForm);

///Retrieves the best result string.
///Params:
///    hrc = Handle to the recognizer context.
///    pcSize = On input, the number of characters the <i>pwcBestResult</i> buffer can hold. On output, the number of characters
///             the <i>pwcBestResult</i> buffer contains. If <i>pwcBestResult</i> is <b>NULL</b>, the function returns the
///             required size of the buffer that you use to allocate the <i>pwcBestResult</i> buffer.
///    pwcBestResult = Recognition result. If the buffer is too small, the function truncates the string. The string is not
///                    <b>NULL</b>-terminated. To determine the required size of the buffer, set <i>pwcBestResult</i> to <b>NULL</b>;
///                    use <i>pcSize</i> to allocate the <i>pwcBestResult</i> buffer.
@DllImport("inkobjcore")
HRESULT GetBestResultString(HRECOCONTEXT__* hrc, uint* pcSize, char* pwcBestResult);

///Sets the recognition guide to use for boxed or lined input. You must call this function before you add strokes to the
///context.
///Params:
///    hrc = Handle to the recognizer context.
///    pGuide = Guide to use for box or line input. Setting this parameter to <b>NULL</b> means that the context has no guide.
///             This is the default and means the recognizer is in free input mode. For guide details, see the RECO_GUIDE
///             structure.
///    iIndex = Index value to use for the first box or line in the context.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The context is invalid or one of the
///    parameters is an invalid pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl>
///    </td> <td width="60%"> Unable to allocate memory to complete the operation. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> Attempted to set a recognition mode (free, lined,
///    boxed, and so on) that is not supported by the recognizer, or the RECO_GUIDE field values are illegal (negative
///    heights or widths, for example). </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
///    width="60%"> An unspecified error occurred. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>TPC_E_OUT_OF_ORDER_CALL</b></dt> </dl> </td> <td width="60%"> Attempted to set guide when there was
///    already some ink in the reco context, or, in the case of recognizers of East Asian characters, SetCACMode was
///    called previously. </td> </tr> </table>
///    
@DllImport("inkobjcore")
HRESULT SetGuide(HRECOCONTEXT__* hrc, const(RECO_GUIDE)* pGuide, uint iIndex);

///Stops the recognizer from processing ink because a stroke has been added or deleted.
///Params:
///    hrc = The handle to the recognizer context.
///    bNewStroke = <b>TRUE</b> if adding a new stroke. Set to <b>FALSE</b> if strokes were erased, split, merged, extracted, or
///                 deleted from the Ink object.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. This function also returns S_OK
///    if the recognizer does not support this function. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> One of the parameters is an invalid pointer. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> An invalid
///    argument was received. </td> </tr> </table>
///    
@DllImport("inkobjcore")
HRESULT AdviseInkChange(HRECOCONTEXT__* hrc, BOOL bNewStroke);

///Indicates that no more ink will be added to the context. You cannot add strokes to the context after calling this
///function.
///Params:
///    hrc = The handle to the recognizer context.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> An invalid argument was
///    received. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The
///    recognizer context handle is invalid or null. </td> </tr> </table>
///    
@DllImport("inkobjcore")
HRESULT EndInkInput(HRECOCONTEXT__* hrc);

///Performs ink recognition synchronously.
///Params:
///    hrc = The handle to the recognizer context.
///    pbPartialProcessing = Specify <b>TRUE</b> to process a subset of the ink. Partial processing reduces the time the recognizer spends
///                          performing recognition if more ink is expected. Typically an application specifies <b>FALSE</b> to process all
///                          the ink. The function does not process all the ink if you have not called the EndInkInput function. The function
///                          sets the <i>pbPartialProcessing</i> parameter to <b>TRUE</b> if there is enough ink left to continue processing;
///                          otherwise, <b>FALSE</b>.
@DllImport("inkobjcore")
HRESULT Process(HRECOCONTEXT__* hrc, int* pbPartialProcessing);

///Specifies the factoid a recognizer uses to constrain its search for the result. You specify a factoid if an input
///field is of a known type, such as if the input field contains a date. You call this function before processing the
///ink for the first time. Therefore, call the <b>SetFactoid</b> function before calling the Process function.
///Params:
///    hrc = Handle to the recognizer context.
///    cwcFactoid = Number of characters in <i>pwcFactoid</i>.
///    pwcFactoid = Identifies the factoid to use on the recognizer context. The string is not <b>NULL</b>-terminated.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>TPC_E_INVALID_PROPERTY</b></dt> </dl> </td> <td width="60%"> The specified factoid is
///    not supported. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TPC_E_OUT_OF_ORDER_CALL</b></dt> </dl> </td> <td
///    width="60%"> You must call the SetFactoid function before calling the Process function. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The context is invalid or one of the
///    parameters is an invalid pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td>
///    <td width="60%"> The recognizer does not support this function. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Unable to allocate memory to complete the operation.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error
///    occurred. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The
///    context contains an invalid value. </td> </tr> </table>
///    
@DllImport("inkobjcore")
HRESULT SetFactoid(HRECOCONTEXT__* hrc, uint cwcFactoid, const(wchar)* pwcFactoid);

///Specifies how the recognizer interprets the ink and determines the result string. Call this function before
///processing the ink for the first time. Therefore, call the <b>SetFlags</b> function before calling the Process
///function.
///Params:
///    hrc = Handle to the recognizer context.
///    dwFlags = The following table lists the flags that you may set to specify how the recognizer interprets the ink and
///              determines the result string. Use the <b>OR</b> operator (|) to combine flags as appropriate. <table> <tr>
///              <th>Bit flag</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="RECOFLAG_AUTOSPACE"></a><a
///              id="recoflag_autospace"></a><dl> <dt><b>RECOFLAG_AUTOSPACE</b></dt> </dl> </td> <td width="60%"> Recognizer uses
///              smart spacing based on language model rules. </td> </tr> <tr> <td width="40%"><a id="RECOFLAG_COERCE"></a><a
///              id="recoflag_coerce"></a><dl> <dt><b>RECOFLAG_COERCE</b></dt> </dl> </td> <td width="60%"> Recognizer coerces the
///              result based on the factoid you specify for the context. For example, if you specify a phone number factoid and
///              the user enters the word "hello", the recognizer may return a random phone number or an empty string. If you do
///              not specify this flag, the recognizer returns "hello" as the result. </td> </tr> <tr> <td width="40%"><a
///              id="RECOFLAG_PREFIXOK"></a><a id="recoflag_prefixok"></a><dl> <dt><b>RECOFLAG_PREFIXOK</b></dt> </dl> </td> <td
///              width="60%"> Recognizer supports the recognition of any prefix part of the strings that are defined in the
///              default or specified (factoid) language model. For example, without this flag, the user writes "handw" and the
///              recognizer returns suggestions (such as "hander" or "handed") that are words that exist in the recognizer
///              lexicon. With the flag, the recognizer may return "handw" as one of the suggestions since it is a valid prefix of
///              the word "handwriting" that exists in the recognizer lexicon. The Tablet PC Input Panel sets this flag in most
///              cases, except when the input scope is IS_DEFAULT (or no input scope) or when there is no user word list or
///              regular expression. Recognizers of East Asian characters should return E_INVALIDARG when a caller passes in this
///              flag. </td> </tr> <tr> <td width="40%"><a id="RECOFLAG_LINEMODE"></a><a id="recoflag_linemode"></a><dl>
///              <dt><b>RECOFLAG_LINEMODE</b></dt> </dl> </td> <td width="60%"> The recognizer does not split lines but must still
///              do character and word separation. This is the same as lined mode, except that there is no guide, and all ink is
///              assumed to be in a single line. When this flag is set, a guide, if set, is ignored. </td> </tr> <tr> <td
///              width="40%"><a id="RECOFLAG_SINGLESEG"></a><a id="recoflag_singleseg"></a><dl> <dt><b>RECOFLAG_SINGLESEG</b></dt>
///              </dl> </td> <td width="60%"> Disables multiple segmentation. By default, the recognizer returns multiple
///              segmentations (alternates) for the ink. For example, if you write "together" as separate strokes, the recognizer
///              may segment the ink as "to get her", "to gather", or "together". Set this flag if you do not need multiple
///              segmentations of the ink when you query for alternates. This improves performance and reduces memory usage. </td>
///              </tr> <tr> <td width="40%"><a id="RECOFLAG_WORDMODE"></a><a id="recoflag_wordmode"></a><dl>
///              <dt><b>RECOFLAG_WORDMODE</b></dt> </dl> </td> <td width="60%"> Recognizer treats the ink as a single word. For
///              example, if the context contains "to get her", the recognizer returns "together". </td> </tr> </table>
///Returns:
///    This function can return one of these values. <table> <tr> <th>HRESULT value</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The flag is invalid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> The recognizer does not support this
///    function. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
///    Unable to allocate memory to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The context is invalid or one of the
///    parameters is an invalid pointer. </td> </tr> </table>
///    
@DllImport("inkobjcore")
HRESULT SetFlags(HRECOCONTEXT__* hrc, uint dwFlags);

///Retrieves a pointer to the lattice for the current results.
///Params:
///    hrc = The handle to the recognizer context.
///    ppLattice = The recognition results.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Unable to allocate memory to
///    complete the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td
///    width="60%"> The recognizer does not support this function. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>TPC_E_NOT_RELEVANT</b></dt> </dl> </td> <td width="60%"> The recognizer context does not contain results.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> One of the
///    parameters is an invalid pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
///    width="60%"> An unspecified error occurred. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt>
///    </dl> </td> <td width="60%"> An invalid argument was received. </td> </tr> </table>
///    
@DllImport("inkobjcore")
HRESULT GetLatticePtr(HRECOCONTEXT__* hrc, RECO_LATTICE** ppLattice);

///Provides the text strings that come before and after the text contained in the recognizer context. You call this
///function before processing the ink for the first time. Therefore, call the <b>SetTextContext</b> function before
///calling the Process function.
///Params:
///    hrc = Handle to the recognizer context.
///    cwcBefore = Number of characters in <i>pwcBefore</i>.
///    pwcBefore = Text string that comes before the text contained in the recognizer context. The string is not <b>NULL</b>
///                terminated.
///    cwcAfter = Number of characters in <i>pwcAfter</i>.
///    pwcAfter = Text string that comes after the text contained in the recognizer context. The string is not <b>NULL</b>
///               -terminated.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The context is invalid or one of the
///    parameters is an invalid pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td>
///    <td width="60%"> The recognizer does not support this function. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Unable to allocate memory to complete the operation.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error
///    occurred. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> An
///    invalid argument was specified. </td> </tr> </table>
///    
@DllImport("inkobjcore")
HRESULT SetTextContext(HRECOCONTEXT__* hrc, uint cwcBefore, const(wchar)* pwcBefore, uint cwcAfter, 
                       const(wchar)* pwcAfter);

///Enables one or more Unicode point ranges on the context.
///Params:
///    hrc = The handle to the recognizer context.
///    cRanges = The number of ranges in the <i>pRanges</i> buffer.
///    pcr = An array of CHARACTER_RANGE structures. Each structure identifies a range of Unicode points that you want to
///          enable in the recognizer. The order of the array is arbitrary.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>TPC_S_TRUNCATED</b></dt> </dl> </td> <td width="60%"> The recognizer does not support
///    one of the specified Unicode point ranges. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl>
///    </td> <td width="60%"> An unspecified error occurred. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> An invalid argument was received. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> One of the parameters is an invalid
///    pointer. </td> </tr> </table>
///    
@DllImport("inkobjcore")
HRESULT SetEnabledUnicodeRanges(HRECOCONTEXT__* hrc, uint cRanges, CHARACTER_RANGE* pcr);

///Returns a value that indicates whether a word, date, time, number, or other text that is passed in is contained in
///the dictionary. The results of this test depend on the factoid setting.
///Params:
///    hrc = The handle to the recognizer context.
///    wcString = The count, in Unicode (wide) characters, of <i>pwcString</i>.
///    pwcString = The Unicode (wide) characters to test.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. This function also returns S_OK
///    if the recognizer does not support this function. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Unable to allocate memory to complete the operation.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The string is not
///    supported. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> One of
///    the parameters is an invalid pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td>
///    <td width="60%"> An unspecified error occurred. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> An invalid argument was received. </td> </tr> </table>
///    
@DllImport("inkobjcore")
HRESULT IsStringSupported(HRECOCONTEXT__* hrc, uint wcString, const(wchar)* pwcString);

///Sets the word list for the current recognizer context to recognize.
///Params:
///    hrc = Handle to the recognizer context.
///    hwl = Handle to recognition word list to be used.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The context is invalid or one of the
///    parameters is an invalid pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td>
///    <td width="60%"> The recognizer does not support this function. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Unable to allocate memory to complete the operation.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> An invalid
///    argument was received. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%">
///    The method was called after Process has been called. </td> </tr> </table>
///    
@DllImport("inkobjcore")
HRESULT SetWordList(HRECOCONTEXT__* hrc, HRECOWORDLIST__* hwl);

///Gets the right separator for the recognizer context.
///Params:
///    hrc = The handle to the recognizer context.
///    pcSize = A pointer to the size of the right separator.
///    pwcRightSeparator = A pointer to the right separator.
@DllImport("inkobjcore")
HRESULT GetRightSeparator(HRECOCONTEXT__* hrc, uint* pcSize, char* pwcRightSeparator);

///Gets the left separator for the recognizer context.
///Params:
///    hrc = The handle to the recognizer context.
///    pcSize = A pointer to the size of the left separator.
///    pwcLeftSeparator = A pointer to the left separator.
@DllImport("inkobjcore")
HRESULT GetLeftSeparator(HRECOCONTEXT__* hrc, uint* pcSize, char* pwcLeftSeparator);

///Destroys the current word list.
///Params:
///    hwl = Handle to the word list.
@DllImport("inkobjcore")
HRESULT DestroyWordList(HRECOWORDLIST__* hwl);

///Adds one or more words to the word list.
///Params:
///    hwl = Handle to the word list.
///    pwcWords = Words to add to the word list. Separate words in this list with a \0 character and end the list with two \0
///               characters. Words that already exist in the list are not added.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> An invalid argument was received.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Returned when the word
///    list handle parameter is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td>
///    <td width="60%"> The pointer to the word list is incorrect. </td> </tr> </table>
///    
@DllImport("inkobjcore")
HRESULT AddWordsToWordList(HRECOWORDLIST__* hwl, char* pwcWords);

///Creates a word list.
///Params:
///    hrec = Handle to the recognizer.
///    pBuffer = Words to insert into the new word list. Separate words in this list with a \0 character and end the list with two
///              \0 characters.
///    phwl = Handle to the new word list.
///Returns:
///    This function can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The pointer to the word list is
///    incorrect. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> An
///    invalid argument was received. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td>
///    <td width="60%"> Unable to allocate memory to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>TPC_S_TRUNCATED</b></dt> </dl> </td> <td width="60%"> An error is found in one of the words in the list.
///    Possible errors include unsupported characters, spaces at the start or the end of the word or more than a single
///    space between words. All words up to the incorrect word are added to the word list. </td> </tr> </table>
///    
@DllImport("inkobjcore")
HRESULT MakeWordList(HRECOGNIZER__* hrec, char* pBuffer, HRECOWORDLIST__** phwl);

///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified before
///it's commercially released. Microsoft makes no warranties, express or implied, with respect to the information
///provided here.] Gets all recognizers.
///Params:
///    recognizerClsids = Pointer to the CLSIDs of the recognizers. The CLSID value is created in the registry when you register the
///                       recognizer.
///    count = Pointer to the number of recognizers.
@DllImport("inkobjcore")
HRESULT GetAllRecognizers(GUID** recognizerClsids, uint* count);

///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified before
///it's commercially released. Microsoft makes no warranties, express or implied, with respect to the information
///provided here.] Loads the cached attributes of a recognizer.
///Params:
///    clsid = The CLSID of the recognizer. This value is created in the registry when you register the recognizer.
///    pRecoAttributes = Pointer to the recognizer attributes.
@DllImport("inkobjcore")
HRESULT LoadCachedAttributes(GUID clsid, RECO_ATTRS* pRecoAttributes);


// Interfaces

@GUID("937C1A34-151D-4610-9CA6-A8CC9BDB5D83")
struct InkDisp;

@GUID("65D00646-CDE3-4A88-9163-6769F0F1A97D")
struct InkOverlay;

@GUID("04A1E553-FE36-4FDE-865E-344194E69424")
struct InkPicture;

@GUID("43FB1553-AD74-4EE8-88E4-3E6DAAC915DB")
struct InkCollector;

@GUID("D8BF32A2-05A5-44C3-B3AA-5E80AC7D2576")
struct InkDrawingAttributes;

@GUID("43B07326-AAE0-4B62-A83D-5FD768B7353C")
struct InkRectangle;

@GUID("9C1CC6E4-D7EB-4EEB-9091-15A7C8791ED9")
struct InkRenderer;

@GUID("E3D5D93C-1663-4A78-A1A7-22375DFEBAEE")
struct InkTransform;

@GUID("9FD4E808-F6E6-4E65-98D3-AA39054C1255")
struct InkRecognizers;

@GUID("AAC46A37-9229-4FC0-8CCE-4497569BF4D1")
struct InkRecognizerContext;

@GUID("8770D941-A63A-4671-A375-2855A18EBA73")
struct InkRecognizerGuide;

@GUID("6E4FCB12-510A-4D40-9304-1DA10AE9147C")
struct InkTablets;

@GUID("9DE85094-F71F-44F1-8471-15A2FA76FCF3")
struct InkWordList;

@GUID("48F491BC-240E-4860-B079-A1E94D3D2C86")
struct InkStrokes;

@GUID("13DE4A42-8D21-4C8E-BF9C-8F69CB068FCA")
struct Ink;

@GUID("F0291081-E87C-4E07-97DA-A0A03761E586")
struct SketchInk;

@GUID("8854F6A0-4683-4AE7-9191-752FE64612C3")
struct InkDivider;

@GUID("9F074EE2-E6E9-4D8A-A047-EB5B5C3C55DA")
struct HandwrittenTextInsertion;

@GUID("F744E496-1B5A-489E-81DC-FBD7AC6298A8")
struct PenInputPanel;

@GUID("F9B189D7-228B-4F2B-8650-B97F59E02C8C")
struct TextInputPanel;

@GUID("802B1FB9-056B-4720-B0CC-80D23B71171E")
struct PenInputPanel_Internal;

@GUID("E5CA59F5-57C4-4DD8-9BD6-1DEEEDD27AF4")
struct InkEdit;

@GUID("C561816C-14D8-4090-830C-98D994B21C7B")
struct MathInputControl;

@GUID("E26B366D-F998-43CE-836F-CB6D904432B0")
struct RealTimeStylus;

@GUID("ECD32AEA-746F-4DCB-BF68-082757FAFF18")
struct DynamicRenderer;

@GUID("EA30C654-C62C-441F-AC00-95F9A196782C")
struct GestureRecognizer;

@GUID("E810CEE7-6E51-4CB0-AA3A-0B985B70DAF7")
struct StrokeBuilder;

@GUID("807C1E6C-1D00-453F-B920-B61BB7CDD997")
struct TipAutoCompleteClient;

///Represents an ink rectangle.
@GUID("9794FF82-6071-4717-8A8B-6AC7C64A686E")
interface IInkRectangle : IDispatch
{
    ///Gets or sets the top position of the InkRectangle object. This property is read/write.
    HRESULT get_Top(int* Units);
    ///Gets or sets the top position of the InkRectangle object. This property is read/write.
    HRESULT put_Top(int Units);
    ///Gets or sets the left position of the InkRectangle object. This property is read/write.
    HRESULT get_Left(int* Units);
    ///Gets or sets the left position of the InkRectangle object. This property is read/write.
    HRESULT put_Left(int Units);
    ///Gets or sets the bottom position of the InkRectangle object. This property is read/write.
    HRESULT get_Bottom(int* Units);
    ///Gets or sets the bottom position of the InkRectangle object. This property is read/write.
    HRESULT put_Bottom(int Units);
    ///Gets or sets the right position of the InkRectangle object. This property is read/write.
    HRESULT get_Right(int* Units);
    ///Gets or sets the right position of the InkRectangle object. This property is read/write.
    HRESULT put_Right(int Units);
    ///Gets or sets access to the rectangle structure (C++ only). This property is read/write.
    HRESULT get_Data(RECT* Rect);
    ///Gets or sets access to the rectangle structure (C++ only). This property is read/write.
    HRESULT put_Data(RECT Rect);
    ///Gets the elements of the InkRectangle object in a single call.
    ///Params:
    ///    Top = The top of the rectangle.
    ///    Left = The left edge of the rectangle.
    ///    Bottom = The bottom of the rectangle.
    ///    Right = The right edge of the rectangle.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%">
    ///    An exception occurred inside the method. </td> </tr> </table>
    ///    
    HRESULT GetRectangle(int* Top, int* Left, int* Bottom, int* Right);
    ///Sets the elements of the InkRectangle object in a single call.
    ///Params:
    ///    Top = The top of the rectangle.
    ///    Left = The left of the rectangle.
    ///    Bottom = The bottom of the rectangle.
    ///    Right = The right of the rectangle.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%">
    ///    An exception occurred inside the method. </td> </tr> </table>
    ///    
    HRESULT SetRectangle(int Top, int Left, int Bottom, int Right);
}

///Represents the ability to add your own data to a variety of objects within the Tablet PC object model.
@GUID("DB489209-B7C3-411D-90F6-1548CFFF271E")
interface IInkExtendedProperty : IDispatch
{
    ///Gets the globally unique identifier (GUID) of the IInkExtendedProperty object. This property is read-only.
    HRESULT get_Guid(BSTR* Guid);
    ///Gets or sets the data of the extended property. This property is read/write.
    HRESULT get_Data(VARIANT* Data);
    ///Gets or sets the data of the extended property. This property is read/write.
    HRESULT put_Data(VARIANT Data);
}

///Represents a collection of IInkExtendedProperty objects that contain application-defined data.
@GUID("89F2A8BE-95A9-4530-8B8F-88E971E3E25F")
interface IInkExtendedProperties : IDispatch
{
    ///Gets the number of objects or collections contained in a collection. This property is read-only.
    HRESULT get_Count(int* Count);
    HRESULT get__NewEnum(IUnknown* _NewEnum);
    ///Retrieves the IInkExtendedProperty object at the specified index within the IInkExtendedProperties collection.
    ///Params:
    ///    Identifier = The zero-based index or GUID of the IInkExtendedProperty object to get. For more information about the
    ///                 VARIANT structure, see Using the COM Library.
    ///    Item = When this method returns, contains a pointer to the IInkExtendedProperty object at the specified index within
    ///           the IInkExtendedProperties collection.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An
    ///    unspecified error occurred. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>CO_E_CLASSTRING</b></dt> </dl>
    ///    </td> <td width="60%"> Invalid GUID format. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>DISP_E_TYPEMISMATCH</b></dt> </dl> </td> <td width="60%"> One of the parameters is not a valid VARIANT
    ///    type. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    Invalid argument. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td
    ///    width="60%"> Unexpected parameter or property type. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>REGDB_CLASSNOTREG</b></dt> </dl> </td> <td width="60%"> Type object not registered. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Cannot allocate memory to
    ///    complete the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td>
    ///    <td width="60%"> An exception occurred inside the method. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>TPC_E_RECOGNIZER_NOT_REGISTERED</b></dt> </dl> </td> <td width="60%"> The recognizers registry key is
    ///    corrupted or your environment does not support handwriting recognition. </td> </tr> </table>
    ///    
    HRESULT Item(VARIANT Identifier, IInkExtendedProperty* Item);
    ///Creates and adds an IInkExtendedProperty object to the IInkExtendedProperties collection.
    ///Params:
    ///    Guid = The name of the new IInkExtendedProperty object. The name is expressed as a BSTR that represents the globally
    ///           unique identifier (GUID) in the following format: {dfc71f44-354b-4ca1-93d7-7459410b6343} (Including curly
    ///           braces) For more information about the BSTR data type, see Using the COM Library.
    ///    Data = The data for the new IInkExtendedProperty object. For more information about the VARIANT structure, see Using
    ///           the COM Library.
    ///    InkExtendedProperty = When this method returns, contains a poitner to the new extended property.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The
    ///    user did not specify data. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>CO_E_CLASSSTRING</b></dt> </dl>
    ///    </td> <td width="60%"> Invalid GUID format. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurred inside the method. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>TPC_E_INVALID_STROKE</b></dt> </dl> </td> <td width="60%"> The stroke
    ///    is invalid. </td> </tr> </table>
    ///    
    HRESULT Add(BSTR Guid, VARIANT Data, IInkExtendedProperty* InkExtendedProperty);
    ///Removes the IInkExtendedProperty object from the IInkExtendedProperties collection.
    ///Params:
    ///    Identifier = The identifier of the IInkExtendedProperty object to remove from the collection. The identifier can be a
    ///                 globally unique identifier (GUID), an index, or an extended property object. For more information about the
    ///                 VARIANT structure, see Using the COM Library.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>CO_E_CLASSSTRING</b></dt> </dl> </td> <td width="60%">
    ///    Invalid GUID format. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TPC_E_INVALID_PROPERTY</b></dt> </dl>
    ///    </td> <td width="60%"> Property could not be found (invalid GUID or index). </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurred inside the method.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified
    ///    error occurred. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> Invalid display handle. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt>
    ///    </dl> </td> <td width="60%"> Unexpected parameter or property type. </td> </tr> </table>
    ///    
    HRESULT Remove(VARIANT Identifier);
    ///Clears all of the IInkExtendedProperty objects from the IInkExtendedProperties collection.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurred inside
    ///    the method. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An
    ///    unspecified error occurred. </td> </tr> </table>
    ///    
    HRESULT Clear();
    ///Retrieves a value that indicates whether an IInkExtendedProperty object exists within an IInkExtendedProperties
    ///collection.
    ///Params:
    ///    Guid = Specifies the globally unique identifier (GUID) of the property to be checked. For more information about the
    ///           BSTR data type, see Using the COM Library.
    ///    DoesPropertyExist = When this method returns, contains <b>VARIANT_TRUE</b> if the property exists within the collection;
    ///                        otherwise, <b>VARIANT_FALSE</b>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained
    ///    an invalid pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>CO_E_CLASSSTRING</b></dt> </dl> </td> <td
    ///    width="60%"> Invalid GUID format. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt>
    ///    </dl> </td> <td width="60%"> An exception occurred inside the method. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> Invalid display handle. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>TPC_E_INVALID_STROKE</b></dt> </dl> </td> <td width="60%"> The stroke is invalid.
    ///    </td> </tr> </table>
    ///    
    HRESULT DoesPropertyExist(BSTR Guid, short* DoesPropertyExist);
}

///Represents the attributes applied to ink when drawn.
@GUID("BF519B75-0A15-4623-ADC9-C00D436A8092")
interface IInkDrawingAttributes : IDispatch
{
    ///Gets or sets the color of the ink that is drawn with this InkDrawingAttributes object. This property is
    ///read/write.
    HRESULT get_Color(int* CurrentColor);
    ///Gets or sets the color of the ink that is drawn with this InkDrawingAttributes object. This property is
    ///read/write.
    HRESULT put_Color(int NewColor);
    ///Gets or sets the y-axis dimension, or width, of the pen tip when drawing ink. This property is read/write.
    HRESULT get_Width(float* CurrentWidth);
    ///Gets or sets the y-axis dimension, or width, of the pen tip when drawing ink. This property is read/write.
    HRESULT put_Width(float NewWidth);
    ///Gets or sets the height of the pen when drawing ink with the InkDrawingAttributes object. This property is
    ///read/write.
    HRESULT get_Height(float* CurrentHeight);
    ///Gets or sets the height of the pen when drawing ink with the InkDrawingAttributes object. This property is
    ///read/write.
    HRESULT put_Height(float NewHeight);
    ///Gets or sets the value that specifies whether Bezier smoothing is used to render ink. This property is
    ///read/write.
    HRESULT get_FitToCurve(short* Flag);
    ///Gets or sets the value that specifies whether Bezier smoothing is used to render ink. This property is
    ///read/write.
    HRESULT put_FitToCurve(short Flag);
    ///Gets or sets the value that specifies whether drawn ink automatically gets wider with increased pressure of the
    ///pen tip on the tablet surface. This property is read/write.
    HRESULT get_IgnorePressure(short* Flag);
    ///Gets or sets the value that specifies whether drawn ink automatically gets wider with increased pressure of the
    ///pen tip on the tablet surface. This property is read/write.
    HRESULT put_IgnorePressure(short Flag);
    ///Gets or sets the value that indicates whether a stroke is antialiased. This property is read/write.
    HRESULT get_AntiAliased(short* Flag);
    ///Gets or sets the value that indicates whether a stroke is antialiased. This property is read/write.
    HRESULT put_AntiAliased(short Flag);
    ///Gets or sets a value that indicates the transparency value of ink. This property is read/write.
    HRESULT get_Transparency(int* CurrentTransparency);
    ///Gets or sets a value that indicates the transparency value of ink. This property is read/write.
    HRESULT put_Transparency(int NewTransparency);
    ///Gets or sets a value that defines how the colors of the pen and background interact. This property is read/write.
    HRESULT get_RasterOperation(InkRasterOperation* CurrentRasterOperation);
    ///Gets or sets a value that defines how the colors of the pen and background interact. This property is read/write.
    HRESULT put_RasterOperation(InkRasterOperation NewRasterOperation);
    ///Gets or sets a value that indicates which pen tip to use when drawing ink that is associated with this
    ///InkDrawingAttributes object. This property is read/write.
    HRESULT get_PenTip(InkPenTip* CurrentPenTip);
    ///Gets or sets a value that indicates which pen tip to use when drawing ink that is associated with this
    ///InkDrawingAttributes object. This property is read/write.
    HRESULT put_PenTip(InkPenTip NewPenTip);
    ///Gets the collection of application-defined data that are stored in an object. This property is read-only.
    HRESULT get_ExtendedProperties(IInkExtendedProperties* Properties);
    ///Creates a duplicate InkDrawingAttributes object.
    ///Params:
    ///    DrawingAttributes = When this method returns, contains a pointer to the newly created InkDrawingAttributes object.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Cannot allocate memory to
    ///    complete the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> An unspecified error occurred. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> A parameter contained an invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurred inside the method. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>REGDB_CLASSNOTREG</b></dt> </dl> </td> <td width="60%"> The InkDisp
    ///    object was not registered. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td>
    ///    <td width="60%"> Unexpected parameter or property type. </td> </tr> </table>
    ///    
    HRESULT Clone(IInkDrawingAttributes* DrawingAttributes);
}

///Represents a 3x3 matrix that, in turn, represents an affine transformation.
@GUID("615F1D43-8703-4565-88E2-8201D2ECD7B7")
interface IInkTransform : IDispatch
{
    ///Resets the transform to its default state, the identity transform.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Reset();
    ///Applies a translation to a transform.
    ///Params:
    ///    HorizontalComponent = The horizontal component of the translation.
    ///    VerticalComponent = The vertical component of the translation.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%">
    ///    Unexpected parameter or property type. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid argument. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurred inside the method. </td>
    ///    </tr> </table>
    ///    
    HRESULT Translate(float HorizontalComponent, float VerticalComponent);
    ///Changes the amount, measured in degrees, to change the rotation factor of the InkTransform object and optionally
    ///the center point of the rotation.
    ///Params:
    ///    Degrees = The degrees by which to rotate clockwise. Without the optional x and y arguments, rotation takes place around
    ///              the origin point, which by default is the upper left corner of the ink collection area to which the transform
    ///              is applied.
    ///    x = Optional. The x-coordinate of the point in ink space coordinates around which rotation occurs. The default
    ///        value is 0.
    ///    y = Optional. The y-coordinate of the point in ink space coordinates around which rotation occurs. The default
    ///        value is 0.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurred inside
    ///    the method. </td> </tr> </table>
    ///    
    HRESULT Rotate(float Degrees, float x, float y);
    ///Performs reflection on a transform in either horizontal or vertical directions.
    ///Params:
    ///    Horizontally = <b>VARIANT_TRUE</b> to reflect in the horizontal direction; otherwise, <b>VARIANT_FALSE</b>.
    ///    Vertically = <b>VARIANT_TRUE</b> to reflect in the vertical direction; otherwise, <b>VARIANT_FALSE</b>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> Invalid VARIANT_BOOL variants.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An
    ///    exception occurred inside the method. </td> </tr> </table>
    ///    
    HRESULT Reflect(short Horizontally, short Vertically);
    ///Adjusts the shear of the InkTransform by the specified horizontal and vertical factors.
    ///Params:
    ///    HorizontalComponent = The horizontal factor of the shear.
    ///    VerticalComponent = The vertical factor of the shear.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurred inside
    ///    the method. </td> </tr> </table>
    ///    
    HRESULT Shear(float HorizontalComponent, float VerticalComponent);
    ///Applies the specified horizontal and vertical factors to the transform or ink.
    ///Params:
    ///    HorizontalMultiplier = The factor to scale the horizontal dimension in the transform.
    ///    VerticalMultiplier = The factor to scale the vertical dimension in the transform.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurred inside
    ///    the method. </td> </tr> </table>
    ///    
    HRESULT ScaleTransform(float HorizontalMultiplier, float VerticalMultiplier);
    ///Gets the InkTransform member data.
    ///Params:
    ///    eM11 = The real number that specifies the element in the first row, first column.
    ///    eM12 = The real number that specifies the element in the first row, second column.
    ///    eM21 = The real number that specifies the element in the second row, first column.
    ///    eM22 = The real number that specifies the element in the second row, second column.
    ///    eDx = The real number that specifies the element in the third row, first column.
    ///    eDy = The real number that specifies the element in the third row, second column.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurred inside
    ///    the method. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A
    ///    parameter contained an invalid pointer. </td> </tr> </table>
    ///    
    HRESULT GetTransform(float* eM11, float* eM12, float* eM21, float* eM22, float* eDx, float* eDy);
    ///Modifies the InkTransform member data. An InkTransform object represents a 3×3 matrix that, in turn, represents
    ///an affine transformation. The object stores only six of the nine numbers in a 3×3 matrix because all 3×3
    ///matrices that represent affine transformations have the same third column (0, 0, 1).
    ///Params:
    ///    eM11 = The element in the first row, first column.
    ///    eM12 = The element in the first row, second column.
    ///    eM21 = The element in the second row, first column.
    ///    eM22 = The element in the second row, second column.
    ///    eDx = The element in the third row, first column.
    ///    eDy = The element in the third row, second column.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurred inside
    ///    the method. </td> </tr> </table>
    ///    
    HRESULT SetTransform(float eM11, float eM12, float eM21, float eM22, float eDx, float eDy);
    ///Gets or sets the element in the first row, first column of the affine transform matrix that is represented by an
    ///InkTransform object. This property is read/write.
    HRESULT get_eM11(float* Value);
    ///Gets or sets the element in the first row, first column of the affine transform matrix that is represented by an
    ///InkTransform object. This property is read/write.
    HRESULT put_eM11(float Value);
    ///Gets or sets the element in the first row, second column of the affine transform matrix that is represented by an
    ///InkTransform object. This property is read/write.
    HRESULT get_eM12(float* Value);
    ///Gets or sets the element in the first row, second column of the affine transform matrix that is represented by an
    ///InkTransform object. This property is read/write.
    HRESULT put_eM12(float Value);
    ///Gets or sets the element in the second row, first column of the affine transform matrix that is represented by an
    ///InkTransform object. This property is read/write.
    HRESULT get_eM21(float* Value);
    ///Gets or sets the element in the second row, first column of the affine transform matrix that is represented by an
    ///InkTransform object. This property is read/write.
    HRESULT put_eM21(float Value);
    ///Gets or sets the element in the second row, second column of the affine transform matrix that is represented by
    ///an InkTransform object. This property is read/write.
    HRESULT get_eM22(float* Value);
    ///Gets or sets the element in the second row, second column of the affine transform matrix that is represented by
    ///an InkTransform object. This property is read/write.
    HRESULT put_eM22(float Value);
    ///Gets or sets the element in the third row, first column of the affine transform matrix that is represented by an
    ///InkTransform object. This property is read/write.
    HRESULT get_eDx(float* Value);
    ///Gets or sets the element in the third row, first column of the affine transform matrix that is represented by an
    ///InkTransform object. This property is read/write.
    HRESULT put_eDx(float Value);
    ///Gets or sets the element in the third row, second column of the affine transform matrix that is represented by an
    ///InkTransform object. This property is read/write.
    HRESULT get_eDy(float* Value);
    ///Gets or sets the element in the third row, second column of the affine transform matrix that is represented by an
    ///InkTransform object. This property is read/write.
    HRESULT put_eDy(float Value);
    ///Gets or sets access to the XFORM structure. This property is read/write.
    HRESULT get_Data(XFORM* XForm);
    ///Gets or sets access to the XFORM structure. This property is read/write.
    HRESULT put_Data(XFORM XForm);
}

///Represents the ability to query particular properties of a gesture returned from a gesture recognition.
@GUID("3BDC0A97-04E5-4E26-B813-18F052D41DEF")
interface IInkGesture : IDispatch
{
    ///Gets the level of confidence (strong, intermediate, or poor) that a recognizer has in the recognition of an
    ///IInkRecognitionAlternate object or a gesture. This property is read-only.
    HRESULT get_Confidence(InkRecognitionConfidence* Confidence);
    ///Gets the identifier of an object. This property is read-only.
    HRESULT get_Id(InkApplicationGesture* Id);
    ///Gets the hot point of the gesture, in ink space coordinates.
    ///Params:
    ///    X = The X-value of the hot point, in ink space coordinates.
    ///    Y = The Y-value of the hot point, in ink space coordinates.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Error information is provided. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained
    ///    an invalid pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td
    ///    width="60%"> An exception occurred while processing. </td> </tr> </table>
    ///    
    HRESULT GetHotPoint(int* X, int* Y);
}

///Represents general information about the tablet cursor.
@GUID("AD30C630-40C5-4350-8405-9C71012FC558")
interface IInkCursor : IDispatch
{
    ///Gets the name of the object. This property is read-only.
    HRESULT get_Name(BSTR* Name);
    ///Gets the identifier of an object. This property is read-only.
    HRESULT get_Id(int* Id);
    ///Gets a value that indicates whether the cursor is the inverted end of the pen. This property is read-only.
    HRESULT get_Inverted(short* Status);
    ///Gets or sets the drawing attributes to apply to ink as it is drawn. This property is read/write.
    HRESULT get_DrawingAttributes(IInkDrawingAttributes* Attributes);
    ///Gets or sets the drawing attributes to apply to ink as it is drawn. This property is read/write.
    HRESULT putref_DrawingAttributes(IInkDrawingAttributes Attributes);
    ///Gets either the IInkTablet object to which a cursor belongs or the <b>IInkTablet</b> object that an object or
    ///control is currently using to collect input. This property is read-only.
    HRESULT get_Tablet(IInkTablet* Tablet);
    ///Gets the IInkCursorButtons collection that is available on an IInkCursor. This property is read-only.
    HRESULT get_Buttons(IInkCursorButtons* Buttons);
}

///Represents a collection of IInkCursor objects.
@GUID("A248C1AC-C698-4E06-9E5C-D57F77C7E647")
interface IInkCursors : IDispatch
{
    ///Gets the number of objects or collections contained in a collection. This property is read-only.
    HRESULT get_Count(int* Count);
    HRESULT get__NewEnum(IUnknown* _NewEnum);
    ///Returns the IInkCursor object at the specified index within the IInkCursors collection.
    ///Params:
    ///    Index = The zero-based index of the IInkCursor object to get.
    ///    Cursor = Whenthis method returns, contains a pointer to the IInkCursor object at the specified index within the
    ///             IInkCursors collection.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An
    ///    unspecified error occurred. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>CO_E_CLASSTRING</b></dt> </dl>
    ///    </td> <td width="60%"> Invalid GUID format. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>DISP_E_TYPEMISMATCH</b></dt> </dl> </td> <td width="60%"> One of the parameters is not a valid VARIANT
    ///    type. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    Invalid argument. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td
    ///    width="60%"> Unexpected parameter or property type. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>REGDB_CLASSNOTREG</b></dt> </dl> </td> <td width="60%"> Type OBJECT not registered. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Cannot allocate memory to
    ///    complete the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td>
    ///    <td width="60%"> An exception occurred inside the method. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>TPC_E_RECOGNIZER_NOT_REGISTERED</b></dt> </dl> </td> <td width="60%"> The recognizers registry key is
    ///    corrupted or your environment does not support handwriting recognition. </td> </tr> </table>
    ///    
    HRESULT Item(int Index, IInkCursor* Cursor);
}

///Represents general information about a button on a tablet pointing and selecting device.
@GUID("85EF9417-1D59-49B2-A13C-702C85430894")
interface IInkCursorButton : IDispatch
{
    ///Gets the name of the object. This property is read-only.
    HRESULT get_Name(BSTR* Name);
    ///Gets the identifier of an object. This property is read-only.
    HRESULT get_Id(BSTR* Id);
    ///Gets the state of a cursor button, such as whether the button is unavailable, up, or down. This property is
    ///read-only.
    HRESULT get_State(InkCursorButtonState* CurrentState);
}

///Represents a collection of IInkCursorButton objects for an IInkCursor interface.
@GUID("3671CC40-B624-4671-9FA0-DB119D952D54")
interface IInkCursorButtons : IDispatch
{
    ///Gets the number of objects or collections contained in a collection. This property is read-only.
    HRESULT get_Count(int* Count);
    HRESULT get__NewEnum(IUnknown* _NewEnum);
    ///Retrieves the IInkCursorButton object at the specified index or string identifier within the IInkCursorButtons
    ///collection.
    ///Params:
    ///    Identifier = The zero-based index or BSTR identifier of the IInkCursorButton object to get. For more information about the
    ///                 VARIANT and BSTR data types, see Using the COM Library.
    ///    Button = Upon return, contains the IInkCursorButton object at the specified index within the IInkCursorButtons
    ///             collection.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An
    ///    unspecified error occurred. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>CO_E_CLASSTRING</b></dt> </dl>
    ///    </td> <td width="60%"> Invalid GUID format. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>DISP_E_TYPEMISMATCH</b></dt> </dl> </td> <td width="60%"> One of the parameters is not a valid VARIANT
    ///    type. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    Invalid argument. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td
    ///    width="60%"> Unexpected parameter or property type. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>REGDB_CLASSNOTREG</b></dt> </dl> </td> <td width="60%"> Type object not registered. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Cannot allocate memory to
    ///    complete the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td>
    ///    <td width="60%"> An exception occurred inside the method. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>TPC_E_RECOGNIZER_NOT_REGISTERED</b></dt> </dl> </td> <td width="60%"> The recognizers registry key is
    ///    corrupted or your environment does not support handwriting recognition. </td> </tr> </table>
    ///    
    HRESULT Item(VARIANT Identifier, IInkCursorButton* Button);
}

///Represents the digitizer device of Tablet PC that receives tablet device messages or events.
@GUID("2DE25EAA-6EF8-42D5-AEE9-185BC81B912D")
interface IInkTablet : IDispatch
{
    ///Gets the name of the object. This property is read-only.
    HRESULT get_Name(BSTR* Name);
    ///Gets a string representation of the Plug and Play identifier of the IInkTablet object. This property is
    ///read-only.
    HRESULT get_PlugAndPlayId(BSTR* Id);
    ///Gets the maximum input rectangle, in tablet device coordinates that the IInkTablet object supports. This property
    ///is read-only.
    HRESULT get_MaximumInputRectangle(IInkRectangle* Rectangle);
    ///Gets a bitmask that defines the hardware capabilities of the tablet, such as whether a cursor must be in physical
    ///contact with the tablet to report its position. This property is read-only.
    HRESULT get_HardwareCapabilities(TabletHardwareCapabilities* Capabilities);
    ///Determines whether a property of a tablet device or a collection of tablet devices, identified with a globally
    ///unique identifier (GUID), is supported. For example, use this method to determine if all of the tablets in a
    ///collection support tangential pressure from a pen.
    ///Params:
    ///    packetPropertyName = The GUID for the PacketProperty GUIDs of the tablet or tablets that is requested. Use a defined BSTR constant
    ///                         from the PacketProperty constants. For more information about the BSTR data type, see Using the COM Library.
    ///    Supported = <b>VARIANT_TRUE</b> if a known property is supported by the tablet or tablets; otherwise,
    ///                <b>VARIANT_FALSE</b>. <div class="alert"><b>Note</b> This method can be re-entered when called within certain
    ///                message handlers, causing unexpected results. Take care to avoid a reentrant call when handling any of the
    ///                following messages: WM_ACTIVATE, WM_ACTIVATEAPP, WM_NCACTIVATE, WM_PAINT; WM_SYSCOMMAND if <i>wParam</i> is
    ///                set to SC_HOTKEY or SC_TASKLIST; and WM_SYSKEYDOWN (when processing Alt-Tab or Alt-Esc key combinations).
    ///                This is an issue with single-threaded apartment model applications.</div> <div> </div>
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>CO_E_CLASSSTRING</b></dt> </dl> </td> <td width="60%">
    ///    Invalid GUID format. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td
    ///    width="60%"> An exception occurred while processing. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The flag is invalid. </td> </tr> </table>
    ///    
    HRESULT IsPacketPropertySupported(BSTR packetPropertyName, short* Supported);
    ///Retrieves the metrics data for a specified property.
    ///Params:
    ///    propertyName = The property for which you want to determine metrics. For more information about the BSTR data type, see
    ///                   Using the COM Library.
    ///    Minimum = The minimum value, in logical units, that the tablet reports for this property. For example, a tablet
    ///              reporting x-values from 0 to 9000 has a logical minimum of 0.
    ///    Maximum = The maximum value, in logical units, that the tablet reports for this property. For example, a tablet
    ///              reporting x-values from 0 to 9000 would have a logical maximum of 9000.
    ///    Units = The physical units of the property, such as inches or degrees. For a list of property units, see the
    ///            TabletPropertyMetricUnit enumeration type.
    ///    Resolution = Specifies the resolution or increment value for the <b>units</b> member. For example, a tablet that reports
    ///                 400 dots per inch (dpi) has a resolution value of 400.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>TPC_E_UNKNOWN_PROPERTY</b></dt> </dl> </td> <td width="60%"> The tablet does not
    ///    support the specified property. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> An unspecified error occurred. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> A parameter contained an invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>CO_E_CLASSSTRING</b></dt> </dl> </td> <td width="60%"> Invalid GUID format. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> Unknown property string. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception
    ///    occurred while processing. </td> </tr> </table>
    ///    
    HRESULT GetPropertyMetrics(BSTR propertyName, int* Minimum, int* Maximum, TabletPropertyMetricUnit* Units, 
                               float* Resolution);
}

///Extends the IInkTablet interface.
@GUID("90C91AD2-FA36-49D6-9516-CE8D570F6F85")
interface IInkTablet2 : IDispatch
{
    ///Gets the type of Tablet device being used. This property is read-only.
    HRESULT get_DeviceKind(TabletDeviceKind* Kind);
}

///Enables multitouch querying for input.
@GUID("7E313997-1327-41DD-8CA9-79F24BE17250")
interface IInkTablet3 : IDispatch
{
    ///Gets a value that indicates whether an input device supports multitouch. This property is read-only.
    HRESULT get_IsMultiTouch(short* pIsMultiTouch);
    ///Gets the maximum number of cursors that a tablet device supports. This property is read-only.
    HRESULT get_MaximumCursors(uint* pMaximumCursors);
}

///Represents the object used to capture ink from available tablet devices.
@GUID("112086D9-7779-4535-A699-862B43AC1863")
interface IInkTablets : IDispatch
{
    ///Gets the number of objects or collections contained in a collection. This property is read-only.
    HRESULT get_Count(int* Count);
    HRESULT get__NewEnum(IUnknown* _NewEnum);
    ///Gets the default tablet within the set of available tablets. This property is read-only.
    HRESULT get_DefaultTablet(IInkTablet* DefaultTablet);
    ///Retrieves the IInkTablet object at the specified index within the InkTablets collection.
    ///Params:
    ///    Index = The zero-based index of the IInkTablet object to get.
    ///    Tablet = When this method returns, contains a pointer to the IInkTablet object at the specified index within the
    ///             InkTablets collection.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An
    ///    unspecified error occurred. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>CO_E_CLASSTRING</b></dt> </dl>
    ///    </td> <td width="60%"> Invalid GUID format. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>DISP_E_TYPEMISMATCH</b></dt> </dl> </td> <td width="60%"> One of the parameters is not a valid VARIANT
    ///    type. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    Invalid argument. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td
    ///    width="60%"> Unexpected parameter or property type. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>REGDB_CLASSNOTREG</b></dt> </dl> </td> <td width="60%"> Type object not registered. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Cannot allocate memory to
    ///    complete the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td>
    ///    <td width="60%"> An exception occurred inside the method. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>TPC_E_RECOGNIZER_NOT_REGISTERED</b></dt> </dl> </td> <td width="60%"> The recognizers registry key is
    ///    corrupted or your environment does not support handwriting recognition. </td> </tr> </table>
    ///    
    HRESULT Item(int Index, IInkTablet* Tablet);
    ///Determines whether a property of a tablet device or a collection of tablet devices, identified with a globally
    ///unique identifier (GUID), is supported. For example, use this method to determine if all of the tablets in a
    ///collection support tangential pressure from a pen.
    ///Params:
    ///    packetPropertyName = The GUID for the PacketProperty GUIDs of the tablet or tablets that is requested. Use a defined BSTR constant
    ///                         from the PacketProperty constants. For more information about the BSTR data type, see Using the COM Library.
    ///    Supported = When this method returns, contains <b>VARIANT_TRUE</b> if a known property is supported by the tablet or
    ///                tablets; otherwise, <b>VARIANT_FALSE</b>. <div class="alert"><b>Note</b> This method can be re-entered when
    ///                called within certain message handlers, causing unexpected results. Take care to avoid a reentrant call when
    ///                handling any of the following messages: WM_ACTIVATE, WM_ACTIVATEAPP, WM_NCACTIVATE, WM_PAINT; WM_SYSCOMMAND
    ///                if <i>wParam</i> is set to SC_HOTKEY or SC_TASKLIST; and WM_SYSKEYDOWN (when processing Alt-Tab or Alt-Esc
    ///                key combinations). This is an issue with single-threaded apartment model applications.</div> <div> </div>
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>CO_E_CLASSSTRING</b></dt> </dl> </td> <td width="60%">
    ///    Invalid GUID format. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td
    ///    width="60%"> An exception occurred while processing. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The flag is invalid. </td> </tr> </table>
    ///    
    HRESULT IsPacketPropertySupported(BSTR packetPropertyName, short* Supported);
}

///Represents a single ink stroke. A stroke is a set of properties and point data that the digitizer captures that
///represent the coordinates and properties of a known ink mark. It is the set of data that is captured in a single pen
///down, up, or move sequence.
@GUID("43242FEA-91D1-4A72-963E-FBB91829CFA2")
interface IInkStrokeDisp : IDispatch
{
    ///Gets the identifier of an object. This property is read-only.
    HRESULT get_ID(int* ID);
    ///Gets the array of control points that represent the Bezier approximation of the stroke. This property is
    ///read-only.
    HRESULT get_BezierPoints(VARIANT* Points);
    ///Gets or sets the drawing attributes to apply to ink as it is drawn. This property is read/write.
    HRESULT get_DrawingAttributes(IInkDrawingAttributes* DrawAttrs);
    HRESULT putref_DrawingAttributes(IInkDrawingAttributes DrawAttrs);
    ///Gets the parent InkDisp object of a stroke. This property is read-only.
    HRESULT get_Ink(IInkDisp* Ink);
    ///Gets the collection of application-defined data that are stored in an object. This property is read-only.
    HRESULT get_ExtendedProperties(IInkExtendedProperties* Properties);
    ///Gets an array that contains the indices of the cusps of the IInkStrokeDisp object. This property is read-only.
    HRESULT get_PolylineCusps(VARIANT* Cusps);
    ///Gets an array that contains the indices of the <b>cusps</b> of the Bezier approximation of the stroke. This
    ///property is read-only.
    HRESULT get_BezierCusps(VARIANT* Cusps);
    ///Gets the self-intersections of the stroke. This property is read-only.
    HRESULT get_SelfIntersections(VARIANT* Intersections);
    ///Gets the number of packets received for an IInkStrokeDisp object. This property is read-only.
    HRESULT get_PacketCount(int* plCount);
    ///Gets the size, in bytes, of a packet. This property is read-only.
    HRESULT get_PacketSize(int* plSize);
    ///Gets an array of globally unique identifiers (GUIDs) that describes the types of packet data stored in the
    ///IInkStrokeDisp object. This property is read-only.
    HRESULT get_PacketDescription(VARIANT* PacketDescription);
    ///Gets a value that specifies whether a known stroke is deleted from the ink. This property is read-only.
    HRESULT get_Deleted(short* Deleted);
    ///Retrieves the bounding box in <b>ink space</b> coordinates for either all of the strokes in an InkDisp object, an
    ///individual stroke, or an InkStrokes collection.
    ///Params:
    ///    BoundingBoxMode = Optional. Specifies the stroke characteristics to use to calculate the bounding box. The default value is -1,
    ///                      indicating that all characteristics of a stroke are used to specify the bounding box. For more details about
    ///                      the use of stroke characteristics to calculate a bounding box, see the BoundingBoxMode enumeration type.
    ///    Rectangle = When this method returns, contains a pointer to the rectangle that defines the bounding box of an InkDisp
    ///                object, an IInkStrokeDisp object, or an InkStrokes collection. <div class="alert"><b>Note</b> For an
    ///                IInkStrokeDisp object, the returned bounding box is a copy of the strokes bounding box, so altering the
    ///                returned bounding box does not affect the strokes location.</div> <div> </div>
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%">
    ///    An exception occurred inside the method. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt>
    ///    </dl> </td> <td width="60%"> Unexpected parameter or property type. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>REGDB_CLASSNOTREG</b></dt> </dl> </td> <td width="60%"> The InkRectangle object is not registered.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetBoundingBox(InkBoundingBoxMode BoundingBoxMode, IInkRectangle* Rectangle);
    ///Retrieves the points where this IInkStrokeDisp object intersects other <b>IInkStrokeDisp</b> objects within a
    ///known InkStrokes collection.
    ///Params:
    ///    Strokes = The known collection of strokes that are used to calculate the points where this stroke intersects strokes in
    ///              the collection. If <b>NULL</b>, use all strokes in the InkDisp object. <div class="alert"><b>Note</b> The
    ///              known collection of strokes must come from the same InkDisp object as the stroke being tested for
    ///              intersection. If it is not from the same <b>InkDisp</b> object, <b>E_INK_MISMATCHED_INK_OBJECT</b> is
    ///              returned (see "HRESULT value" below). The <b>FindIntersections</b> method is the only Tablet PC application
    ///              programming interface (API) that requires that the known collection of strokes come from the same
    ///              <b>InkDisp</b> object.</div> <div> </div>
    ///    Intersections = When this method returns, contains an array of floating point index values that indicate the locations where
    ///                    this stroke intersects strokes within a known collection of strokes. A floating point index is a float value
    ///                    that represents a location somewhere between two points in the stroke. As examples, if 0.0 is the first point
    ///                    in the stroke and 1.0 is the second point in the stroke, 0.5 is halfway between the first and second points.
    ///                    Similarly, a floating point index value of 37.25 represents a location that is 25 percent along the line
    ///                    between points 37 and 38 of the stroke. For more information about the VARIANT structure, see Using the COM
    ///                    Library.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    Cannot allocate an IInkStrokeDisp handle helper object. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> Unexpected parameter or property type. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurred
    ///    inside the method. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_INCOMPATIBLE_OBJECT</b></dt> </dl>
    ///    </td> <td width="60%"> The <i>strokes</i>parameter does not point to a compatible InkDisp object. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INK_MISMATCHED_INK_OBJECT</b></dt> </dl> </td> <td width="60%"> The
    ///    InkDisp object of the InkStrokes collection and this IInkStrokeDisp object don't match. </td> </tr> </table>
    ///    
    HRESULT FindIntersections(IInkStrokes Strokes, VARIANT* Intersections);
    ///Finds the points where a IInkStrokeDisp object intersects a given rectangle.
    ///Params:
    ///    Rectangle = The rectangle in <b>ink space</b> coordinates, that describes the hit test area.
    ///    Intersections = When this method returns, contains a VARIANT array that indicates where the stroke intersects the
    ///                    <i>rectangle</i>. The beginning floating point indices are stored in the even indices. The ending floating
    ///                    point indices are stored in the odd indices. The first pair of indices represents the first intersection. For
    ///                    more information about the VARIANT structure, see Using the COM Library.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    Cannot allocate Stroke handler helper object. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> Unexpected parameter or property type. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurred
    ///    inside the method. </td> </tr> </table>
    ///    
    HRESULT GetRectangleIntersections(IInkRectangle Rectangle, VARIANT* Intersections);
    ///Removes portions of an IInkStrokeDisp object or InkStrokes collection that are outside a rectangle.
    ///Params:
    ///    Rectangle = Specifies the rectangle outside of which the stroke or strokes are clipped. The rectangle is specified in ink
    ///                space coordinates.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>REGDB_CLASSNOTREG</b></dt> </dl> </td> <td
    ///    width="60%"> The InkDisp object is not registered. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> Invalid clip rectangle. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurred inside
    ///    the method. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An
    ///    unspecified error occurred. </td> </tr> </table>
    ///    
    HRESULT Clip(IInkRectangle Rectangle);
    ///Determines whether a stroke is either completely inside or intersected by a given circle.
    ///Params:
    ///    X = The x-position of the center of the hit-test circle in ink space coordinates.
    ///    Y = The y-position of the center of the hit-test circle in ink space coordinates.
    ///    Radius = The radius of the circle to use in the hit test.
    ///    Intersects = <b>VARIANT_TRUE</b> if the stroke intersects or is inside the circle; otherwise, <b>VARIANT_FALSE</b>
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%">
    ///    An exception occurred inside the method. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt>
    ///    </dl> </td> <td width="60%"> Unexpected parameter or property type. </td> </tr> </table>
    ///    
    HRESULT HitTestCircle(int X, int Y, float Radius, short* Intersects);
    ///Finds the location on the stroke nearest to a known point and returns the distance that point is from the stroke.
    ///Everything is in ink space coordinates.
    ///Params:
    ///    X = The x-position in ink space of the point to test.
    ///    Y = The y-position in ink space of the point to test.
    ///    Distance = Optional. The distance from the point to the stroke. This parameter can be <b>NULL</b>. The default value is
    ///               0.
    ///    Point = When this method returns, contains the floating point index value that represents the closest location on the
    ///            stroke. A floating point index is a float value that represents a location somewhere between two points in
    ///            the stroke. As examples, if 0.0 is the first point in the stroke and 1.0 is the second point in the stroke,
    ///            0.5 is halfway between the first and second points. Similarly, a floating point index value of 37.25
    ///            represents a location that is 25 percent along the line between points 37 and 38 of the stroke.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An
    ///    unspecified error occurred. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl>
    ///    </td> <td width="60%"> An exception occurred inside the method. </td> </tr> </table>
    ///    
    HRESULT NearestPoint(int X, int Y, float* Distance, float* Point);
    ///Splits the stroke at the specified location on the stroke.
    ///Params:
    ///    SplitAt = The floating point index value that represents where to split the stroke. <div class="alert"><b>Note</b> A
    ///              floating point index is a float value that represents a location somewhere between two points in the stroke.
    ///              As examples, if 0.0 is the first point in the stroke and 1.0 is the second point in the stroke, 0.5 is
    ///              halfway between the first and second points. Similarly, a floating point index value of 37.25 represents a
    ///              location that is 25 percent along the line between points 37 and 38 of the stroke.</div> <div> </div>
    ///    NewStroke = When this method returns, contains a pointer to the new IInkStrokeDisp object that is created from the split
    ///                operation.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    Cannot allocate Stroke handler helper object. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The parameter is invalid. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> Unexpected parameter or property
    ///    type. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An
    ///    exception occurred inside the method. </td> </tr> </table>
    ///    
    HRESULT Split(float SplitAt, IInkStrokeDisp* NewStroke);
    ///Retrieves the metrics for a given packet description type.
    ///Params:
    ///    PropertyName = The globally unique identifier (GUID) from the PacketProperty constants that identifies the property for
    ///                   which to obtain metrics. For more information about the BSTR data type, see Using the COM Library.
    ///    Minimum = The minimum value, in logical units, that the tablet reports for this property. For example, a tablet
    ///              reporting x-values from 0 to 9000 would have a logical minimum of 0.
    ///    Maximum = The maximum value, in logical units, that the tablet reports for this property. For example, a tablet
    ///              reporting x-values from 0 to 9000 would have a logical maximum of 9000.
    ///    Units = The physical units of the property, such as inches or degrees. For a list of property units, see the
    ///            TabletPropertyMetricUnit enumeration type.
    ///    Resolution = The resolution or increment value for the <i>units</i> member. For example, a tablet that reports 400 dots
    ///                 per inch (dpi) would have a <i>resolution</i> value of 400.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    Cannot allocate memory necessary to complete this request. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>CO_E_CLASSSTRING</b></dt> </dl> </td> <td width="60%"> Invalid GUID format. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The property does not exist in
    ///    the collection. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td
    ///    width="60%"> An exception occurred while processing. </td> </tr> </table>
    ///    
    HRESULT GetPacketDescriptionPropertyMetrics(BSTR PropertyName, int* Minimum, int* Maximum, 
                                                TabletPropertyMetricUnit* Units, float* Resolution);
    ///Retrieves the points that make up a stroke.
    ///Params:
    ///    Index = Optional. The starting index within the array of points that make up the stroke. The default value
    ///            ISC_FirstElement, defined in the InkSelectionConstants enumeration type, specifies the first point.
    ///    Count = Optional. The number of points to return. The default value ISC_AllElements, defined in the
    ///            InkSelectionConstants enumeration type, specifies all of the points that make up the stroke data.
    ///    Points = Whent this method returns, contains the array of points from the stroke. For more information about the
    ///             VARIANT structure, see Using the COM Library.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    Cannot allocate memory for the points. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid index (out of range). </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurred inside the method. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> Unexpected
    ///    parameter or property type. </td> </tr> </table>
    ///    
    HRESULT GetPoints(int Index, int Count, VARIANT* Points);
    ///Sets the points of the IInkStrokeDisp using an array of X, Y values.
    ///Params:
    ///    Points = The array of new points to replace the points in the stroke beginning at <i>index</i>. This is a VARIANT
    ///             containing an array of Long with the points represented by alternating values of the form x0, y0, x1, y1, x2,
    ///             y2, and so on. For more information about the VARIANT structure, see Using the COM Library.
    ///    Index = Optional. The zero-based index of the first point in the stroke to be modified. The default value
    ///            ISC_FirstElement, defined in the <b>ItemSelectionConstants</b> enumeration type, specifies that the first
    ///            point in the stroke is modified.
    ///    Count = Optional. The count of points in the stroke to be modified. The default value ISC_AllElements, defined in the
    ///            <b>ItemSelectionConstants</b> enumeration type, specifies that all points in the stroke are modified.
    ///    NumberOfPointsSet = When this method returns, contains the actual number of packets set.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    Invalid <i>index</i> (out of range), or <i>points</i> parameter. Was not in the correct format. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurred
    ///    inside the method. </td> </tr> </table>
    ///    
    HRESULT SetPoints(VARIANT Points, int Index, int Count, int* NumberOfPointsSet);
    ///Retrieves the packet data for a range of packets within the IInkStrokeDisp object.
    ///Params:
    ///    Index = Optional. The starting point of the zero-based index to a packet within the stroke. The default value
    ///            ISC_FirstElement, defined in the InkSelectionConstants enumeration type, specifies the first packet.
    ///    Count = Optional. The number of point packet data sets that should be returned, starting with the packet specified in
    ///            the <i>startingIndex</i> parameter. The default value ISC_AllElements, defined in the InkSelectionConstants
    ///            enumeration type, specifies all of the points that make up the stroke data.
    ///    PacketData = When this method returns, contains a signed 32-bit integer array containing the packet data for the requested
    ///                 points in the stroke. The array contains the data for the first point, then the data for the second point,
    ///                 and so on. For more information about the VARIANT structure, see Using the COM Library.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An
    ///    unspecified error occurred. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td>
    ///    <td width="60%"> Cannot allocate Stroke handler helper object. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The stroke is invalid. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurred inside
    ///    the method. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%">
    ///    Unexpected parameter or property type. </td> </tr> </table>
    ///    
    HRESULT GetPacketData(int Index, int Count, VARIANT* PacketData);
    ///Retrieves the data for a known packet property from one or more packets in the stroke.
    ///Params:
    ///    PropertyName = The identifier from the PacketProperty constants that was used to select which packet data is retrieved. For
    ///                   more information about the BSTR data type, see Using the COM Library.
    ///    Index = Optional. The starting point of the zero-based index to a packet within the stroke. The default value
    ///            ISC_FirstElement, defined in the InkSelectionConstants enumeration type, specifies the first packet.
    ///    Count = Optional. The number of points that make up the stroke data. The default value ISC_AllElements, defined in
    ///            the InkSelectionConstants enumeration type, specifies all of the points that make up the stroke data.
    ///    PacketValues = When this method returns, contains an array of signed 32-bit integers that specifies the value of the
    ///                   requested PacketProperty for each point requested from the stroke. For more information about the VARIANT
    ///                   structure, see Using the COM Library.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>TPC_E_INVALID_STROKE</b></dt> </dl> </td> <td width="60%"> The stroke is invalid.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter
    ///    contained an invalid pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> An unspecified error occurred. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Cannot allocate packet data array. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> Invalid index, count, or
    ///    packet property. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td
    ///    width="60%"> An exception occurred inside the method. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>CO_E_CLASSSTRING</b></dt> </dl> </td> <td width="60%"> Invalid GUID format. </td> </tr> </table>
    ///    
    HRESULT GetPacketValuesByProperty(BSTR PropertyName, int Index, int Count, VARIANT* PacketValues);
    ///Modifies the packet values for a particular property.
    ///Params:
    ///    bstrPropertyName = The globally unique identifier (GUID) identifier from the PacketProperty constants that is used to select
    ///                       which packet data is set. Use PacketDescription to determine the defined properties for this stroke.
    ///    PacketValues = The array of packet data values. The method fails if any of the values in the array are outside the minimum
    ///                   or maximum value of the property. To determine the range of values in the property, call the
    ///                   GetPacketDescriptionPropertyMetrics method.
    ///    Index = Optional. The starting index of the packet to be modified. The default value ISC_FirstElement, defined in the
    ///            <b>ItemSelectionConstants</b> enumeration type, specifies the first packet.
    ///    Count = Optional. Specifies the number of packets in the stroke to modify and the number of values in
    ///            <i>PacketValues</i>. The default value ISC_AllElements, defined in the <b>ItemSelectionConstants</b>
    ///            enumeration type, specifies that all packets are modified.
    ///    NumberOfPacketsSet = When this method returns, contains the actual number of packets set.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>CO_E_CLASSSTRING</b></dt> </dl> </td> <td width="60%">
    ///    Invalid GUID format. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> Invalid variant, index (out of range), or property GUID. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurred inside method. </td> </tr>
    ///    </table>
    ///    
    HRESULT SetPacketValuesByProperty(BSTR bstrPropertyName, VARIANT PacketValues, int Index, int Count, 
                                      int* NumberOfPacketsSet);
    ///Retrieves the bounding box in <b>ink space</b> coordinates for either all of the strokes in an InkDisp object, an
    ///individual stroke, or a InkStrokes collection.
    ///Params:
    ///    FittingError = Optional. The maximum distance (accuracy), using ink space units, between the Bezier control points and the
    ///                   points of the stroke. This is also known as the curve fitting error level. The default value is 0.
    ///    FlattenedBezierPoints = When this method returns, contains a point array that indicates the points that were used to draw the Bezier
    ///                            curve representation of the IInkStrokeDisp object. The Variant result contains an array in the form x1, y1,
    ///                            x2, y2, and so on, of the Bezier points. For more information about the VARIANT structure, see Using the COM
    ///                            Library.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>TPC_E_INVALID_STROKE</b></dt> </dl> </td> <td width="60%"> The stroke is invalid.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter
    ///    contained an invalid pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> An unspecified error occurred. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Cannot allocate Stroke handler helper object.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The fitting
    ///    error was out of range. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td>
    ///    <td width="60%"> An exception occurred inside the method. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> Unexpected parameter or property type. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetFlattenedBezierPoints(int FittingError, VARIANT* FlattenedBezierPoints);
    ///Applies a linear transformation to an IInkStrokeDisp object or an InkStrokes collection, which can represent
    ///scaling, rotation, translation, and combinations of transformations.
    ///Params:
    ///    Transform = The transform to use on the stroke or strokes. (This is an InkTransform object, which correlates to the XFORM
    ///                structure). The transformation applies to both the points and pen width (if <i>ApplyOnPenWidth</i> is
    ///                <b>VARIANT_TRUE</b>).
    ///    ApplyOnPenWidth = Optional. <b>VARIANT_TRUE</b> to apply the transform to the width of the ink in the InkDrawingAttributes of
    ///                      the strokes; otherwise, <b>VARIANT_FALSE</b>. The default is <b>VARIANT_FALSE</b>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    Invalid argument. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td
    ///    width="60%"> Unexpected parameter or property type. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurred inside the method. </td>
    ///    </tr> </table>
    ///    
    HRESULT Transform(IInkTransform Transform, short ApplyOnPenWidth);
    ///Scales the IInkStrokeDisp object or InkStrokes collection to fit in the specified InkRectangle object.
    ///Params:
    ///    Rectangle = The InkRectangle in ink space to which the stroke or collection of strokes is scaled. The strokes are scaled
    ///                and translated to match the strokes' bounding box to the rectangle.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%">
    ///    An exception occurred inside the method. </td> </tr> </table>
    ///    
    HRESULT ScaleToRectangle(IInkRectangle Rectangle);
    ///Applies a translation to the ink of an IInkStrokeDisp object or InkStrokes collection.
    ///Params:
    ///    HorizontalComponent = The distance in ink space coordinates to translate the view transform in the X dimension.
    ///    VerticalComponent = The distance in ink space coordinates to translate the view transform in the Y dimension.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Move(float HorizontalComponent, float VerticalComponent);
    ///Rotates the ink using an angle in degrees around a center point of the rotation.
    ///Params:
    ///    Degrees = The degrees by which to rotate clockwise.
    ///    x = Optional. The x-coordinate of the point in ink space coordinates around which to rotate. Default is the
    ///        origin. The default value is the origin (0).
    ///    y = Optional. The y-coordinate of the point in ink space coordinates around which to rotate. The default value is
    ///        the origin (0).
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurred inside
    ///    the method. </td> </tr> </table>
    ///    
    HRESULT Rotate(float Degrees, float x, float y);
    ///Shears the ink in the stroke or strokes by the specified horizontal and vertical factors.
    ///Params:
    ///    HorizontalMultiplier = The horizontal factor of the shear.
    ///    VerticalMultiplier = The vertical factor of the shear.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurred inside
    ///    the method. </td> </tr> </table>
    ///    
    HRESULT Shear(float HorizontalMultiplier, float VerticalMultiplier);
    ///Applies the specified horizontal and vertical factors to the transform or ink.
    ///Params:
    ///    HorizontalMultiplier = The factor to scale the horizontal dimension in the transform.
    ///    VerticalMultiplier = The factor to scale the vertical dimension in the transform.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurred inside
    ///    the method. </td> </tr> </table>
    ///    
    HRESULT ScaleTransform(float HorizontalMultiplier, float VerticalMultiplier);
}

///Represents a collection of ink strokes. A stroke is a set of properties and point data that the digitizer captures
///that represent the coordinates and properties of a known ink mark. It is the set of data that is captured in a single
///pen down, up, or move sequence.
@GUID("F1F4C9D8-590A-4963-B3AE-1935671BB6F3")
interface IInkStrokes : IDispatch
{
    ///Gets the number of objects or collections contained in a collection. This property is read-only.
    HRESULT get_Count(int* Count);
    HRESULT get__NewEnum(IUnknown* _NewEnum);
    ///Gets the InkDisp object that contains a collection of strokes. This property is read-only.
    HRESULT get_Ink(IInkDisp* Ink);
    ///Gets the IInkRecognitionResult object of the InkStrokes collection. This property is read-only.
    HRESULT get_RecognitionResult(IInkRecognitionResult* RecognitionResult);
    ///<p class="CCE_Message">[<b>ToString</b> is no longer available for use as of Windows Vista. Instead, see the
    ///String property for the equivalent of this method for the IInkRecognitionAlternate object. ] Has the default
    ///recognizer perform recognition on the collection of strokes and returns the top string of the top alternate of
    ///the recognition result.
    ///Params:
    ///    ToString = The top string of the TopAlternate property of the IInkRecognitionResult object, after the default recognizer
    ///               performs recognition on the collection of strokes. For more information about the <b>BSTR</b> data type, see
    ///               Using the COM Library.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Operation
    ///    failed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Out
    ///    of memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td
    ///    width="60%"> An exception occurred inside the method. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>TPC_E_RECOGNIZER_NOT_REGISTERED</b></dt> </dl> </td> <td width="60%"> No recognizers are installed,
    ///    the recognizers registry key is corrupted, or your environment does not support handwriting recognition.
    ///    </td> </tr> </table>
    ///    
    HRESULT ToString(BSTR* ToString);
    ///Retrieves the IInkStrokeDisp object at the specified index within the InkStrokes collection.
    ///Params:
    ///    Index = The zero-based index of the IInkStrokeDisp object to get.
    ///    Stroke = When this method returns, contains a pointer to the IInkStrokeDisp object at the specified index within the
    ///             InkStrokes collection.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An
    ///    unspecified error occurred. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>CO_E_CLASSTRING</b></dt> </dl>
    ///    </td> <td width="60%"> Invalid GUID format. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>DISP_E_TYPEMISMATCH</b></dt> </dl> </td> <td width="60%"> One of the parameters is not a valid VARIANT
    ///    type. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    Invalid argument. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td
    ///    width="60%"> Unexpected parameter or property type. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>REGDB_CLASSNOTREG</b></dt> </dl> </td> <td width="60%"> Type object not registered. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Cannot allocate memory to
    ///    complete the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td>
    ///    <td width="60%"> An exception occurred inside the method. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>TPC_E_RECOGNIZER_NOT_REGISTERED</b></dt> </dl> </td> <td width="60%"> The recognizers registry key is
    ///    corrupted or your environment does not support handwriting recognition. </td> </tr> </table>
    ///    
    HRESULT Item(int Index, IInkStrokeDisp* Stroke);
    ///Adds an IInkStrokeDisp object or InkStrokes collection to an existing InkStrokes collection.
    ///Params:
    ///    InkStroke = The stroke to add to the InkStrokes collection.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    Cannot allocate Stroke handler helper object. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurred inside the method. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_INCOMPATIBLE_OBJECT</b></dt> </dl> </td> <td width="60%">
    ///    IInkStrokeDisp* does not point to a compatible IInkStrokeDisp object. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INK_MISMATCHED_INK_OBJECT</b></dt> </dl> </td> <td width="60%"> The InkDisp object of the
    ///    IInkStrokeDisp being added does not match the <b>InkDisp</b> object of the InkStrokes collection. </td> </tr>
    ///    </table>
    ///    
    HRESULT Add(IInkStrokeDisp InkStroke);
    ///Adds a Strokes collection to an existing Strokes collection.
    ///Params:
    ///    InkStrokes = The collection of strokes to add to the collection of strokes.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    Cannot allocate Stroke handler helper object. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurred inside the method. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_INCOMPATIBLE_OBJECT</b></dt> </dl> </td> <td width="60%">
    ///    IInkStrokes* does not point to a compatible InkDisp object. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INK_MISMATCHED_INK_OBJECT</b></dt> </dl> </td> <td width="60%"> The InkDisp object of the InkStrokes
    ///    collection that is being added must match the <b>InkDisp</b> object of the InkStrokes collection to which it
    ///    is being added. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td
    ///    width="60%"> Unexpected parameter or property type. </td> </tr> </table>
    ///    
    HRESULT AddStrokes(IInkStrokes InkStrokes);
    ///Removes an IInkStrokeDisp object from a InkStrokes collection.
    ///Params:
    ///    InkStroke = The IInkStrokeDisp to remove.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    Cannot allocate IInkStrokeDisp handler helper object. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurred inside the method. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_INCOMPATIBLE_OBJECT</b></dt> </dl> </td> <td width="60%">
    ///    IInkStroke* does not point to a valid InkDisp Class object. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INK_MISMATCHED_INK_OBJECT</b></dt> </dl> </td> <td width="60%"> The InkDisp object of the InkStrokes
    ///    collection and this IInkStrokeDisp object do not match. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> Unexpected parameter or property type. </td> </tr>
    ///    </table>
    ///    
    HRESULT Remove(IInkStrokeDisp InkStroke);
    ///Removes strokes from the collection.
    ///Params:
    ///    InkStrokes = The strokes to remove from the collection.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    Cannot allocate Stroke handler helper object. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurred inside the method. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_INCOMPATIBLE_OBJECT</b></dt> </dl> </td> <td width="60%">
    ///    IInkStrokes* does not point to a valid InkDisp object. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INK_MISMATCHED_INK_OBJECT</b></dt> </dl> </td> <td width="60%"> The InkDisp object of the InkStrokes
    ///    collection and the specified InkStrokes don't match. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> Unexpected parameter or property type. </td> </tr>
    ///    </table>
    ///    
    HRESULT RemoveStrokes(IInkStrokes InkStrokes);
    ///Sets the drawing attributes of all of the strokes in an InkStrokes collection.
    ///Params:
    ///    DrawAttrs = The new drawing attributes for all of the strokes in the collection.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%">
    ///    An exception occurred inside the method. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt>
    ///    </dl> </td> <td width="60%"> Unexpected parameter or property type. </td> </tr> </table>
    ///    
    HRESULT ModifyDrawingAttributes(IInkDrawingAttributes DrawAttrs);
    ///Gets the bounding box in ink space coordinates for either all of the strokes in an InkDisp object, an individual
    ///stroke, or an InkStrokes collection.
    ///Params:
    ///    BoundingBoxMode = Optional. Specifies the stroke characteristics to use to calculate the bounding box. For more details about
    ///                      the use of stroke characteristics to calculate a bounding box, see the BoundingBoxMode enumeration type. The
    ///                      <i>BoundingBoxMode</i> parameter of the GetBoundingBox method has a default value of -1, which means that all
    ///                      characteristics of a stroke are used to specify the bounding box.
    ///    BoundingBox = When this method returns, contains a pointer to the rectangle that defines the bounding box of an InkDisp
    ///                  object, an IInkStrokeDisp object, or an InkStrokes collection. <div class="alert"><b>Note</b> For an
    ///                  IInkStrokeDisp object, the returned bounding box is a copy of the strokes bounding box, so altering the
    ///                  returned bounding box does not affect the strokes location.</div> <div> </div>
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%">
    ///    An exception occurred inside the method. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt>
    ///    </dl> </td> <td width="60%"> Unexpected parameter or property type. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>REGDB_CLASSNOTREG</b></dt> </dl> </td> <td width="60%"> The InkRectangle object is not registered.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetBoundingBox(InkBoundingBoxMode BoundingBoxMode, IInkRectangle* BoundingBox);
    ///Applies a linear transformation to an IInkStrokeDisp object or an InkStrokes collection, which can represent
    ///scaling, rotation, translation, and combinations of transformations.
    ///Params:
    ///    Transform = The transform to use on the stroke or strokes. (This is an InkTransform object, which correlates to the XFORM
    ///                structure). The transformation applies to both the points and pen width (if <i>ApplyOnPenWidth</i> is
    ///                <b>VARIANT_TRUE</b>).
    ///    ApplyOnPenWidth = Optional. <b>VARIANT_TRUE</b> to apply the transform to the width of the ink in the InkDrawingAttributes of
    ///                      the strokes; otherwise, <b>VARIANT_FALSE</b>. The default is <b>VARIANT_FALSE</b>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    Invalid argument. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td
    ///    width="60%"> Unexpected parameter or property type. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurred inside the method. </td>
    ///    </tr> </table>
    ///    
    HRESULT Transform(IInkTransform Transform, short ApplyOnPenWidth);
    ///Scales the IInkStrokeDisp object or InkStrokes collection to fit in the specified InkRectangle object.
    ///Params:
    ///    Rectangle = The InkRectangle in ink space to which the stroke or collection of strokes is scaled. The strokes are scaled
    ///                and translated to match the strokes' bounding box to the rectangle.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%">
    ///    An exception occurred inside the method. </td> </tr> </table>
    ///    
    HRESULT ScaleToRectangle(IInkRectangle Rectangle);
    ///Applies a translation to the ink of an IInkStrokeDisp object or InkStrokes collection.
    ///Params:
    ///    HorizontalComponent = The distance in ink space coordinates to translate the view transform in the X dimension.
    ///    VerticalComponent = The distance in ink space coordinates to translate the view transform in the Y dimension.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Move(float HorizontalComponent, float VerticalComponent);
    ///Rotates the ink using an angle in degrees around a center point of the rotation.
    ///Params:
    ///    Degrees = The degrees by which to rotate clockwise.
    ///    x = Optional. The x-coordinate of the point in ink space coordinates around which to rotate. Default is the
    ///        origin.
    ///    y = Optional. The y-coordinate of the point in ink space coordinates around which to rotate. Default is the
    ///        origin.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurred inside
    ///    the method. </td> </tr> </table>
    ///    
    HRESULT Rotate(float Degrees, float x, float y);
    ///Shears the ink in the stroke or strokes by the specified horizontal and vertical factors.
    ///Params:
    ///    HorizontalMultiplier = The horizontal factor of the shear.
    ///    VerticalMultiplier = The vertical factor of the shear.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurred inside
    ///    the method. </td> </tr> </table>
    ///    
    HRESULT Shear(float HorizontalMultiplier, float VerticalMultiplier);
    ///Applies the specified horizontal and vertical factors to the transform or ink.
    ///Params:
    ///    HorizontalMultiplier = The factor to scale the horizontal dimension in the transform.
    ///    VerticalMultiplier = The factor to scale the vertical dimension in the transform.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurred inside
    ///    the method. </td> </tr> </table>
    ///    
    HRESULT ScaleTransform(float HorizontalMultiplier, float VerticalMultiplier);
    ///Removes portions of an IInkStrokeDisp object or InkStrokes collection that are outside a rectangle.
    ///Params:
    ///    Rectangle = Specifies the rectangle outside of which the stroke or strokes are clipped. The rectangle is specified in ink
    ///                space coordinates.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>REGDB_CLASSNOTREG</b></dt> </dl> </td> <td
    ///    width="60%"> The InkDisp object is not registered. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> Invalid clip rectangle. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurred inside
    ///    the method. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An
    ///    unspecified error occurred. </td> </tr> </table>
    ///    
    HRESULT Clip(IInkRectangle Rectangle);
    ///Removes the RecognitionResult that is associated with the InkStrokes collection.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurred inside
    ///    the method. </td> </tr> </table>
    ///    
    HRESULT RemoveRecognitionResult();
}

///Contains a collection of user-defined InkStrokes collections.
@GUID("7E23A88F-C30E-420F-9BDB-28902543F0C1")
interface IInkCustomStrokes : IDispatch
{
    ///Gets the number of objects or collections contained in a collection. This property is read-only.
    HRESULT get_Count(int* Count);
    HRESULT get__NewEnum(IUnknown* _NewEnum);
    ///Retrieves the InkStrokes Collection at the location specified within the IInkCustomStrokes Interface.
    ///Params:
    ///    Identifier = The numeric index or string name of the InkStrokes Collection to return from the IInkCustomStrokes
    ///                 collection.
    ///    Strokes = When this method returns, contains a pointer to the InkStrokes Collection at the location specified within
    ///              the IInkCustomStrokes Interface.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>HRESULT Value</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An
    ///    unspecified error occurred. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>CO_E_CLASSTRING</b></dt> </dl>
    ///    </td> <td width="60%"> Invalid GUID format. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>DISP_E_TYPEMISMATCH</b></dt> </dl> </td> <td width="60%"> One of the parameters is not a valid VARIANT
    ///    type. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    Invalid argument. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td
    ///    width="60%"> Unexpected parameter or property type. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>REGDB_CLASSNOTREG</b></dt> </dl> </td> <td width="60%"> Type OBJECT not registered. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Cannot allocate memory to
    ///    complete the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td>
    ///    <td width="60%"> An exception occurred inside the method. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>TPC_E_RECOGNIZER_NOT_REGISTERED</b></dt> </dl> </td> <td width="60%"> The recognizers registry key is
    ///    corrupted or your environment does not support handwriting recognition. </td> </tr> </table>
    ///    
    HRESULT Item(VARIANT Identifier, IInkStrokes* Strokes);
    ///Adds an InkStrokes collection to an IInkCustomStrokes collection.
    ///Params:
    ///    Name = Specifies the name of the InkStrokes collection to add to the IInkCustomStrokes collection. For more
    ///           information about the BSTR data type, see Using the COM Library.
    ///    Strokes = Specifies the InkStrokes collection to add to the IInkCustomStrokes collection.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The item already exists in the
    ///    collection or a parameter contained an invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Cannot allocate memory to complete the operation.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An
    ///    exception occurred inside the method. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INK_INCOMPATIBLE_OBJECT</b></dt> </dl> </td> <td width="60%"> The collection of strokes is
    ///    incompatible with the API. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_MISMATCHED_INK_OBJECT</b></dt>
    ///    </dl> </td> <td width="60%"> The strokes parameter is associated with a different INK object. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> </table>
    ///    
    HRESULT Add(BSTR Name, IInkStrokes Strokes);
    ///Removes the InkStrokes collection from the IInkCustomStrokes collection.
    ///Params:
    ///    Identifier = The name or index of the collection of strokes to remove from the collection of custom strokes. For more
    ///                 information about the VARIANT structure, see Using the COM Library.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    Cannot allocate memory to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurred inside the method. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_INCOMPATIBLE_OBJECT</b></dt> </dl> </td> <td width="60%">
    ///    Invalid input parameter. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_MISMATCHED_INK_OBJECT</b></dt>
    ///    </dl> </td> <td width="60%"> The InkDisp object of the InkStrokes collection and the IInkStrokeDisp object
    ///    don't match. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An
    ///    unspecified error occurred. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>DISP_E_TYPEMISMATCH</b></dt> </dl>
    ///    </td> <td width="60%"> An invalid variant was passed in. </td> </tr> </table>
    ///    
    HRESULT Remove(VARIANT Identifier);
    ///Clears all InkStrokes collections from the IInkCustomStrokes collection.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception
    ///    occurred inside the method. </td> </tr> </table>
    ///    
    HRESULT Clear();
}

@GUID("F33053EC-5D25-430A-928F-76A6491DDE15")
interface _IInkStrokesEvents : IDispatch
{
}

///Represents the collected strokes of ink within an ink space.
@GUID("9D398FA0-C4E2-4FCD-9973-975CAAF47EA6")
interface IInkDisp : IDispatch
{
    ///Gets the collection of strokes that are contained in an object or used to create an object. This property is
    ///read-only.
    HRESULT get_Strokes(IInkStrokes* Strokes);
    ///Gets the collection of application-defined data that are stored in an object. This property is read-only.
    HRESULT get_ExtendedProperties(IInkExtendedProperties* Properties);
    ///Gets or sets the value that specifies whether the strokes of an InkDisp Class object have been modified since the
    ///last time the ink was saved. This property is read/write.
    HRESULT get_Dirty(short* Dirty);
    ///Gets or sets the value that specifies whether the strokes of an InkDisp Class object have been modified since the
    ///last time the ink was saved. This property is read/write.
    HRESULT put_Dirty(short Dirty);
    ///Gets the collection of custom strokes to be persisted with the ink. This property is read-only.
    HRESULT get_CustomStrokes(IInkCustomStrokes* ppunkInkCustomStrokes);
    ///Retrieves the bounding box in ink space coordinates for either all of the strokes in an InkDisp object, an
    ///individual stroke, or an InkStrokes collection.
    ///Params:
    ///    BoundingBoxMode = Optional. Specifies the stroke characteristics to use to calculate the bounding box. For more details about
    ///                      the use of stroke characteristics to calculate a bounding box, see the BoundingBoxMode enumeration type. The
    ///                      default value is -1 (IBBM_DEFAULT), which means that all characteristics of a stroke are used to specify the
    ///                      bounding box.
    ///    Rectangle = When this method returns, contains the rectangle that defines the bounding box of an InkDisp object, an
    ///                IInkStrokeDisp object, or an InkStrokes collection. <div class="alert"><b>Note</b> For an IInkStrokeDisp
    ///                object, the returned bounding box is a copy of the strokes bounding box, so altering the returned bounding
    ///                box does not affect the strokes location.</div> <div> </div>
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%">
    ///    An exception occurred inside the method. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt>
    ///    </dl> </td> <td width="60%"> Unexpected parameter or property type. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>REGDB_CLASSNOTREG</b></dt> </dl> </td> <td width="60%"> The InkRectangle object is not registered.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetBoundingBox(InkBoundingBoxMode BoundingBoxMode, IInkRectangle* Rectangle);
    ///Deletes an InkStrokes collection from the Strokes collection of the InkDisp object.
    ///Params:
    ///    Strokes = Optional. Specifies the collection of strokes to delete from the InkDisp object. The default value is
    ///              <b>NULL</b>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    Cannot allocate memory that is used to perform the operation. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INK_MISMATCHED_INK_OBJECT</b></dt> </dl> </td> <td width="60%"> The InkDisp object
    ///    of the strokes must match the known <b>InkDisp</b> object. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurred inside the method. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> Unexpected
    ///    parameter or property type. </td> </tr> </table>
    ///    
    HRESULT DeleteStrokes(IInkStrokes Strokes);
    ///Deletes a IInkStrokeDisp object from the InkDisp object.
    ///Params:
    ///    Stroke = The stroke to delete from the InkDisp object.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An
    ///    unspecified error occurred. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INK_MISMATCHED_INK_OBJECT</b></dt> </dl> </td> <td width="60%"> The InkDisp object of the strokes
    ///    must match the known <b>InkDisp</b> object. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurred inside the method. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> Unexpected
    ///    parameter or property type. </td> </tr> </table>
    ///    
    HRESULT DeleteStroke(IInkStrokeDisp Stroke);
    ///Specifies the strokes to extract from an InkDisp Class and cut or copy into a new <b>InkDisp Class</b>, by using
    ///the known collection of strokes to determine which strokes to extract.
    ///Params:
    ///    Strokes = Optional. Specifies the collection of strokes to extract. The default value is 0, which specifies that all
    ///              strokes are extracted.
    ///    ExtractFlags = Optional. Specifies the InkExtractFlags Enumeration type, which specifies whether the ink is cut or copied
    ///                   into the new Ink object. The default value is IEF_DEFAULT, which cuts the strokes.
    ///    ExtractedInk = When this method returns, contains a pointer to a new InkDisp Class object that contains the extracted
    ///                   collection of cut or copied strokes.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_MISMATCHED_INK_OBJECT</b></dt> </dl> </td> <td
    ///    width="60%"> The InkDisp Class object of the InkStrokes Collection collection must match the known <b>InkDisp
    ///    Class</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td
    ///    width="60%"> An exception occurred inside the method. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INK_SOME_STROKES_NOT_EXTRACTED</b></dt> </dl> </td> <td width="60%"> Not all strokes were extracted.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Cannot
    ///    allocate memory that is used to perform the operation. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> Invalid extraction flags. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>REGDB_CLASSNOTREG</b></dt> </dl> </td> <td width="60%"> The InkDisp Class object
    ///    class is not registered. </td> </tr> </table>
    ///    
    HRESULT ExtractStrokes(IInkStrokes Strokes, InkExtractFlags ExtractFlags, IInkDisp* ExtractedInk);
    ///Cuts or copies strokes from an existing InkDisp object and pastes them into a new <b>InkDisp</b> object, by using
    ///the known rectangle to determine which strokes to extract.
    ///Params:
    ///    Rectangle = Specifies the InkRectangle object which delimits the ink to extract from the InkDisp object.
    ///    extractFlags = Optional. Specifies the InkExtractFlags enumeration type, which determines whether the ink should be cut or
    ///                   copied from the existing InkDisp object. The default value is IEF_DEFAULT, which cuts the strokes from the
    ///                   existing <b>InkDisp</b> object.
    ///    ExtractedInk = When this method returns, contains a pointer to an InkDisp object that contains the extracted collection of
    ///                   strokes.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%">
    ///    An exception occurred inside the method. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INK_SOME_STROKES_NOT_EXTRACTED</b></dt> </dl> </td> <td width="60%"> Not all strokes were extracted.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Cannot
    ///    allocate memory to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> Invalid extraction flags. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>REGDB_CLASSNOTREG</b></dt> </dl> </td> <td width="60%"> The Ink object was not
    ///    registered. </td> </tr> </table>
    ///    
    HRESULT ExtractWithRectangle(IInkRectangle Rectangle, InkExtractFlags extractFlags, IInkDisp* ExtractedInk);
    ///Removes portions of an IInkStrokeDisp object or InkStrokes collection that are outside a rectangle.
    ///Params:
    ///    Rectangle = Specifies the rectangle outside of which the stroke or strokes are clipped. The rectangle is specified in ink
    ///                space coordinates.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>REGDB_CLASSNOTREG</b></dt> </dl> </td> <td
    ///    width="60%"> The InkDisp object is not registered. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> Invalid clip rectangle. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurred inside
    ///    the method. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An
    ///    unspecified error occurred. </td> </tr> </table>
    ///    
    HRESULT Clip(IInkRectangle Rectangle);
    ///Creates a duplicate InkDisp object.
    ///Params:
    ///    NewInk = When this method returns, contains a pointer to the newly created InkDisp object.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Cannot allocate memory to
    ///    complete the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> An unspecified error occurred. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> A parameter contained an invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurred inside the method. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>REGDB_CLASSNOTREG</b></dt> </dl> </td> <td width="60%"> The InkDisp
    ///    object was not registered. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td>
    ///    <td width="60%"> Unexpected parameter or property type. </td> </tr> </table>
    ///    
    HRESULT Clone(IInkDisp* NewInk);
    ///Retrieves the InkStrokes collection that are either completely inside or intersected by a known circle.
    ///Params:
    ///    X = The x-position of the center of the hit test circle in ink space units.
    ///    Y = The y-position of the center of the hit test circle in ink space units.
    ///    radius = The radius of the circle to use in the hit test, in ink space units.
    ///    Strokes = When this method returns, contains the collection of strokes that are either completely inside or intersected
    ///              by the specified circle.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%">
    ///    An exception occurred inside the method. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid display handle. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> Unexpected parameter or property type. </td> </tr>
    ///    </table>
    ///    
    HRESULT HitTestCircle(int X, int Y, float radius, IInkStrokes* Strokes);
    ///Retrieves the strokes that are contained within a specified rectangle.
    ///Params:
    ///    SelectionRectangle = The selection rectangle, of type InkRectangle, in ink space coordinates.
    ///    IntersectPercent = The float or single percentage value that determines which strokes are included in the collection. Strokes
    ///                       that intersect the rectangle are included in the collection if the percentage of points in those strokes
    ///                       contained within the rectangle is greater than or equal to the <i>IntersectPercent</i> percentage.
    ///    Strokes = When this method returns, contains a pointer to the collection of strokes that makes up the ink.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%">
    ///    An exception occurred inside the method. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid display handle. </td> </tr> </table>
    ///    
    HRESULT HitTestWithRectangle(IInkRectangle SelectionRectangle, float IntersectPercent, IInkStrokes* Strokes);
    ///Retrieves the strokes within a polyline selection area.
    ///Params:
    ///    Points = The points that are used in the selection tool to select the strokes. The selection area is the area inside
    ///             the selection boundary in which the boundary first intersects itself. If the boundary does not intersect
    ///             itself, the method adds a point to the end of the array to create a straight line from the first point to the
    ///             last point. If the boundary is a straight line (no area within the selection boundary), no strokes are
    ///             selected. For more information about the VARIANT structure, see Using the COM Library.
    ///    IntersectPercent = The percentage of stroke points that must be contained within the selection tool to include the stroke in the
    ///                       resulting collection of strokes. If zero (<code>0</code>), all strokes that are contained within or
    ///                       intersected by the selection tool are included in the resulting collection of strokes. If 100, only strokes
    ///                       fully contained in the selection tool are included in the collection. Strokes that intersect the selection
    ///                       tool are included in the collection if the percentage of points in those strokes contained within the
    ///                       selection tool is greater than or equal to the <i>percentIntersect</i> percentage. Fractional percentages are
    ///                       rounded up.
    ///    LassoPoints = Optional. Retrieves the specific portion of the selection tool that is used for the selection. Because a user
    ///                  can draw many different types of selection tools, some of which overlap multiple times, this can be useful
    ///                  for illustrating which portion of the selection tool was used for selection. The default value is a
    ///                  <b>NULL</b> pointer, which means no information is returned. For more information about the VARIANT
    ///                  structure, see Using the COM Library.
    ///    Strokes = When this method returns, contains a pointer to the collection of strokes that makes up the ink.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%">
    ///    An exception occurred inside the method. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid display handle. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Cannot allocate memory operation. </td> </tr>
    ///    </table>
    ///    
    HRESULT HitTestWithLasso(VARIANT Points, float IntersectPercent, VARIANT* LassoPoints, IInkStrokes* Strokes);
    ///Retrieves the IInkStrokeDisp within the InkDisp object that is nearest to a known point, optionally providing the
    ///index of the nearest point and the distance to the stroke from the specified point.
    ///Params:
    ///    X = The <code>x-</code>position in ink space of the point.
    ///    Y = Specifies the <code>y-</code>position in ink space of the point.
    ///    PointOnStroke = Optional. Retrieves the point on the line of the stroke that is closest to the specified point within the
    ///                    InkDisp object. For example, a value of 1.5 indicates that the point falls halfway between the first and
    ///                    second packets of the stroke. This parameter can be <b>NULL</b>. The default value is 0.
    ///    DistanceFromPacket = Optional. Retrieves the distance between the specified point in ink space and the nearest stroke in the
    ///                         InkDisp object. This parameter can be <b>NULL</b>. the default value is 0.
    ///    Stroke = When this method returns, contains the IInkStrokeDisp that contains a point that is closest to the specified
    ///             point in the InkDisp object. If more than one stroke contains a point that is the same distance from the
    ///             specified point, the value of this result is arbitrary.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An
    ///    unspecified error occurred. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl>
    ///    </td> <td width="60%"> An exception occurred inside the method. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Cannot allocate memory operation. </td> </tr>
    ///    </table>
    ///    
    HRESULT NearestPoint(int X, int Y, float* PointOnStroke, float* DistanceFromPacket, IInkStrokeDisp* Stroke);
    ///Creates a new InkStrokes collection from existing IInkStrokeDisp objects.
    ///Params:
    ///    StrokeIds = Optional. Specifies an array of stroke IDs that exist in the InkDisp object. The strokes with these IDs are
    ///                added to a new InkStrokes collection. The default value is <b>NULL</b>. For more information about the
    ///                VARIANT structure, see Using the COM Library.
    ///    Strokes = When this method returns, contains a pointer to a new InkStrokes collection.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    Invalid VARIANT type (only VT_ARRAY | VT_I4 supported). </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurred inside the method. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Cannot allocate
    ///    memory to create the new Strokes collection. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>TPC_E_INVALID_STROKE</b></dt> </dl> </td> <td width="60%"> Stroke IDs that do not exist were passed to
    ///    the method. </td> </tr> </table>
    ///    
    HRESULT CreateStrokes(VARIANT StrokeIds, IInkStrokes* Strokes);
    ///Adds a specified Strokes collection into this InkDisp object at a specified rectangle.
    ///Params:
    ///    SourceStrokes = The strokes to add to the ink. These source strokes are appended to this InkDisp object.
    ///    TargetRectangle = The InkRectangle in ink space coordinates where the strokes are added. A run-time error occurs if the
    ///                      coordinates of the rectangle are {0,0,0,0}.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An
    ///    unspecified error occurred. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_INCOMPATIBLE_OBJECT</b></dt>
    ///    </dl> </td> <td width="60%"> A pointer does not point at a valid object. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurred inside the method.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The
    ///    rectangle's top and bottom are equal. </td> </tr> </table>
    ///    
    HRESULT AddStrokesAtRectangle(IInkStrokes SourceStrokes, IInkRectangle TargetRectangle);
    ///Converts the ink to the specified InkPersistenceFormat, saves the ink by using the specified
    ///InkPersistenceCompressionMode, and returns the binary data in an array of bytes.
    ///Params:
    ///    PersistenceFormat = Optional. Sets one of the InkPersistenceFormat values that indicates the format of the persisted ink. The
    ///                        default value is InkSerializedFormat. <table> <tr> <th>Name </th> <th>Description </th> </tr> <tr> <td
    ///                        width="40%"><a id="InkSerializedFormat"></a><a id="inkserializedformat"></a><a
    ///                        id="INKSERIALIZEDFORMAT"></a><dl> <dt><b>InkSerializedFormat</b></dt> </dl> </td> <td width="60%"> Ink is
    ///                        persisted using ink serialized format (ISF). This is the most compact persistent representation of ink. It
    ///                        can be embedded within a binary document format or placed directly on the Clipboard. This is the default
    ///                        value. </td> </tr> <tr> <td width="40%"><a id="Base64InkSerializedFormat"></a><a
    ///                        id="base64inkserializedformat"></a><a id="BASE64INKSERIALIZEDFORMAT"></a><dl>
    ///                        <dt><b>Base64InkSerializedFormat</b></dt> </dl> </td> <td width="60%"> Ink is persisted by encoding the ISF
    ///                        as a base64 stream. This format is provided so that ink can be encoded directly in an Extensible Markup
    ///                        Language (XML) or HTML file. </td> </tr> <tr> <td width="40%"><a id="Gif"></a><a id="gif"></a><a
    ///                        id="GIF"></a><dl> <dt><b>Gif</b></dt> </dl> </td> <td width="60%"> Ink is persisted by using a Graphics
    ///                        Interchange Format (GIF) file that contains ISF as metadata that is embedded within the file. This allows ink
    ///                        to be viewed in applications that are not ink-enabled and maintain its full ink fidelity when it returns to
    ///                        an ink-enabled application. This format is ideal when transporting ink content within an HTML file and making
    ///                        it usable by ink-enabled and ink-unaware applications. </td> </tr> <tr> <td width="40%"><a
    ///                        id="Base64Gif"></a><a id="base64gif"></a><a id="BASE64GIF"></a><dl> <dt><b>Base64Gif</b></dt> </dl> </td> <td
    ///                        width="60%"> Ink is persisted by using a base64 encoded fortified. This GIFformat is provided when ink is to
    ///                        be encoded directly in an XML or HTML file with later conversion into an image. A possible use of this would
    ///                        be in an XML format that is generated to contain all ink information and used as a way to generate HTML
    ///                        through Extensible Stylesheet Language Transformations (XSLT). </td> </tr> </table>
    ///    CompressionMode = Optional. One of the InkPersistenceCompressionMode values that specifies the compression mode of the
    ///                      persisted ink. The default value is IPCM_Default. <table> <tr> <th>Name </th> <th>Description </th> </tr>
    ///                      <tr> <td width="40%"><a id="IPCM_Default"></a><a id="ipcm_default"></a><a id="IPCM_DEFAULT"></a><dl>
    ///                      <dt><b>IPCM_Default</b></dt> </dl> </td> <td width="60%"> Is used when the best tradeoff between save-time
    ///                      and storage for the typical application is needed. </td> </tr> <tr> <td width="40%"><a
    ///                      id="IPCM_MaximumCompression"></a><a id="ipcm_maximumcompression"></a><a id="IPCM_MAXIMUMCOMPRESSION"></a><dl>
    ///                      <dt><b>IPCM_MaximumCompression</b></dt> </dl> </td> <td width="60%"> Is used when minimizing storage space is
    ///                      more important than how fast the ink is saved. </td> </tr> <tr> <td width="40%"><a
    ///                      id="IPCM_NoCompression"></a><a id="ipcm_nocompression"></a><a id="IPCM_NOCOMPRESSION"></a><dl>
    ///                      <dt><b>IPCM_NoCompression</b></dt> </dl> </td> <td width="60%"> Is used when save-time is more important than
    ///                      the amount of storage space used and when compatibility between versions is important. </td> </tr> </table>
    ///    Data = When this method returns, contains the byte array that contains the persisted ink. For more information about
    ///           the VARIANT structure, see Using the COM Library.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%">
    ///    An exception occurred inside the method. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid compression mode. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Cannot allocate byte array. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> Occurs if you attempt to save an
    ///    empty Ink object in GIF format. </td> </tr> </table>
    ///    
    HRESULT Save(InkPersistenceFormat PersistenceFormat, InkPersistenceCompressionMode CompressionMode, 
                 VARIANT* Data);
    ///Populates a new InkDisp object with known binary data.
    ///Params:
    ///    Data = The stream that contains the ink data. For more information about the VARIANT structure, see Using the COM
    ///           Library.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> VARIANT was not of correct type
    ///    (byte array). </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td
    ///    width="60%"> Cannot allocate memory for Stream. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> Unexpected parameter or property type. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurred
    ///    inside the method. </td> </tr> </table>
    ///    
    HRESULT Load(VARIANT Data);
    ///Creates an IInkStrokeDisp object from an array of packet data input values.
    ///Params:
    ///    PacketData = Specifies the array of packet data. The data is an array of Int32 values which, taken in order, form the
    ///                 array of points (x0, y0), (x1, y1), which is passed into the method within a Variant. For more information
    ///                 about the VARIANT structure, see Using the COM Library.
    ///    PacketDescription = Is a reserved parameter that is currently not implemented.
    ///    Stroke = When this method returns, contains a pointer to the newly-created stroke.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    Invalid VARIANT type (only VT_ARRAY | VT_I4 supported). </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurred inside the method. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Cannot allocate
    ///    memory to create the new stroke. </td> </tr> </table>
    ///    
    HRESULT CreateStroke(VARIANT PacketData, VARIANT PacketDescription, IInkStrokeDisp* Stroke);
    ///Copies the IInkStrokeDisp objects that are contained within the known rectangle to the Clipboard.
    ///Params:
    ///    Rectangle = Specifies the rectangle that contains the strokes to copy to the Clipboard.
    ///    ClipboardFormats = Optional. Specifies the InkClipboardFormats enumeration value of the InkDisp object. The default value is
    ///                       <b>ICF_Default</b>.
    ///    ClipboardModes = Optional. Specifies the InkClipboardModes Enumeration value of the InkDisp Class object. The default value is
    ///                     <b>ICB_Default</b>.
    ///    DataObject = When this method returns, contains a pointer to the newly create data object.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%">
    ///    An exception occurred inside the method. </td> </tr> </table>
    ///    
    HRESULT ClipboardCopyWithRectangle(IInkRectangle Rectangle, InkClipboardFormats ClipboardFormats, 
                                       InkClipboardModes ClipboardModes, IDataObject* DataObject);
    ///Copies the InkStrokes collection to the Clipboard.
    ///Params:
    ///    strokes = Optional. Specifies the strokes to copy. If the strokes parameter is <b>NULL</b>, the <b>ClipboardCopy</b>
    ///              method copies the entire InkDisp object. The default value is <b>NULL</b>.
    ///    ClipboardFormats = Optional. Specifies the InkClipboardFormats enumeration value of the InkDisp object. The default value is
    ///                       <b>ICF_Default</b>.
    ///    ClipboardModes = Optional. Specifies the InkClipboardModes enumeration value of the InkDisp object. The default value is
    ///                     <b>ICB_Default</b>.
    ///    DataObject = When this method returns, contains a pointer to the newly create data object.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%">
    ///    An exception occurred inside the method. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INK_MISMATCHED_INK_OBJECT</b></dt> </dl> </td> <td width="60%"> The strokes parameter is associated
    ///    with a different Ink object. </td> </tr> </table>
    ///    
    HRESULT ClipboardCopy(IInkStrokes strokes, InkClipboardFormats ClipboardFormats, 
                          InkClipboardModes ClipboardModes, IDataObject* DataObject);
    ///Indicates whether the IDataObject can be converted to an InkDisp object.
    ///Params:
    ///    DataObject = Optional. Specifies the IDataObject to inspect. The default value is <b>NULL</b>, which means the data object
    ///                 on the Clipboard is used.
    ///    CanPaste = <b>VARIANT_TRUE</b> if the data object can be converted to an InkDisp object; otherwise,
    ///               <b>VARIANT_FALSE</b>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%">
    ///    An exception occurred inside the method. </td> </tr> </table>
    ///    
    HRESULT CanPaste(IDataObject DataObject, short* CanPaste);
    ///Copies the IDataObject from the Clipboard to the InkDisp object.
    ///Params:
    ///    x = Optional. Specifies the x-coordinate to paste to in <b>ink space</b> coordinates. The default value is 0.
    ///    y = Optional. Specifies the y-coordinate to paste to in ink space coordinates. The default value is 0.
    ///    DataObject = Optional. Specifies the IDataObject to be used. To paste from the Clipboard, set to <b>NULL</b>. The default
    ///                 value is <b>NULL</b>.
    ///    Strokes = When this method returns, contains a pointer to the InkStrokes collection in the InkDisp object.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%">
    ///    An exception occurred inside the method. </td> </tr> </table>
    ///    
    HRESULT ClipboardPaste(int x, int y, IDataObject DataObject, IInkStrokes* Strokes);
}

@GUID("427B1865-CA3F-479A-83A9-0F420F2A0073")
interface _IInkEvents : IDispatch
{
}

///Represents the management of mappings from ink to the display window. Use the InkRenderer object to display ink in a
///window. You can also use it to reposition and resize stroke.
@GUID("E6257A9C-B511-4F4C-A8B0-A7DBC9506B83")
interface IInkRenderer : IDispatch
{
    ///Gets the InkTransform object that represents the view transform that is used to render ink.
    ///Params:
    ///    ViewTransform = The matrix that represents the geometric transformation - rotation, scaling, shear, and reflection - values
    ///                    to use to transform the stroke coordinates within the ink space. The transformation applies to both the
    ///                    points and pen width. View transformation occurs after object transformation.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%">
    ///    An exception occurred inside the method. </td> </tr> </table>
    ///    
    HRESULT GetViewTransform(IInkTransform ViewTransform);
    ///Sets the InkTransform object that represents the view transform that is used to render ink.
    ///Params:
    ///    ViewTransform = The InkTransform object that represents the geometric transformation - rotation, scaling, shear, and
    ///                    reflection - values to use to transform the stroke coordinates within the ink space. A <b>NULL</b> value for
    ///                    the <i>viewTransform</i> parameter correlates to the identity transform.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    <i>viewTransform</i> does not point to a compatible InkTransform object. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurred inside the method.
    ///    </td> </tr> </table>
    ///    
    HRESULT SetViewTransform(IInkTransform ViewTransform);
    ///Gets the InkTransform object that represents the object transform that was used to render ink.
    ///Params:
    ///    ObjectTransform = The InkTransform object that represents the geometric transformation - rotation, scaling, shear, and
    ///                      reflection - values to use to transform the stroke coordinates within the ink space.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%">
    ///    An exception occurred inside the method. </td> </tr> </table>
    ///    
    HRESULT GetObjectTransform(IInkTransform ObjectTransform);
    ///Sets the InkTransform object that represents the object transform that is used to render ink.
    ///Params:
    ///    ObjectTransform = The InkTransform object that represents the geometric transformation - rotation, scaling, shear, and
    ///                      reflection - values to use to transform the stroke coordinates within the ink space. A <b>NULL</b> value for
    ///                      the <i>objectTransform</i> parameter correlates to the identity transform.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    <i>objectTransform</i> does not point to a compatible InkTransform object. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurred inside the method.
    ///    </td> </tr> </table>
    ///    
    HRESULT SetObjectTransform(IInkTransform ObjectTransform);
    ///Draws ink strokes using the known device context.
    ///Params:
    ///    hDC = Specifies the hWnd of the device context on which to draw.
    ///    Strokes = Specifies the strokes to draw.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_MISMATCHED_INK_OBJECT</b></dt> </dl> </td> <td
    ///    width="60%"> The strokes parameter is associated with a different InkDisp object. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> An argument is invalid. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_INCOMPATIBLE_OBJECT</b></dt> </dl> </td> <td width="60%"> The
    ///    <i>hdc</i> or the <i>strokes</i> parameter does not point to a valid object. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurred inside
    ///    the method. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%">
    ///    Unexpected parameter or property type. </td> </tr> </table>
    ///    
    HRESULT Draw(ptrdiff_t hDC, IInkStrokes Strokes);
    ///Draws the IInkStrokeDisp object using the known device context, and optionally draws the <b>IInkStrokeDisp</b>
    ///object with the known InkDrawingAttributes object.
    ///Params:
    ///    hDC = The hWnd of the device context on which to draw.
    ///    Stroke = The stroke to draw.
    ///    DrawingAttributes = Optional. Specifies the InkDrawingAttributes to use on the drawing. The default value is <b>NULL</b>. If
    ///                        <b>InkDrawingAttributes</b> is specified, they override the DrawingAttributes on the IInkStrokeDisp.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_MISMATCHED_INK_OBJECT</b></dt> </dl> </td> <td
    ///    width="60%"> The strokes parameter is associated with a different InkDisp object. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> Invalid display handle. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_INCOMPATIBLE_OBJECT</b></dt> </dl> </td> <td width="60%"> The
    ///    <i>stroke</i> or the <i>drawingAttributes</i> parameter does not point to a valid object. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurred
    ///    inside the method. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td
    ///    width="60%"> Unexpected parameter or property type. </td> </tr> </table>
    ///    
    HRESULT DrawStroke(ptrdiff_t hDC, IInkStrokeDisp Stroke, IInkDrawingAttributes DrawingAttributes);
    ///Converts a location in pixel space coordinates to be a location in ink space coordinates.
    ///Params:
    ///    hDC = The handle of the device context for the containing control or form.
    ///    x = The x coordinate of the point to convert into an ink location.
    ///    y = The y coordinate of the point to convert into an ink location.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    Invalid display handle. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td>
    ///    <td width="60%"> An exception occurred inside the method. </td> </tr> </table>
    ///    
    HRESULT PixelToInkSpace(ptrdiff_t hDC, int* x, int* y);
    ///Converts a location in ink space coordinates to a location in pixel space using a handle for the conversion.
    ///Params:
    ///    hdcDisplay = The handle of the device context.
    ///    x = The X-coordinate of the point to convert into a pixel location.
    ///    y = The Y-coordinate of the point to convert into a pixel location.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%">
    ///    An exception occurred inside the method. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid display handle. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Coordinates overflowed during operation. </td> </tr>
    ///    </table>
    ///    
    HRESULT InkSpaceToPixel(ptrdiff_t hdcDisplay, int* x, int* y);
    ///Converts an array of locations in pixel space coordinates to an array of locations in ink space coordinates.
    ///Params:
    ///    hDC = The handle of the device context for the containing control or form.
    ///    Points = The Variant array of points, as alternating Long x and y values of the form x0, y0, x1, y1, x2, y2, and so
    ///             on, to convert from a pixel location to ink space coordinates. For more information about the VARIANT
    ///             structure, see Using the COM Library.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    Invalid display handle. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td>
    ///    <td width="60%"> An exception occurred inside the method. </td> </tr> </table>
    ///    
    HRESULT PixelToInkSpaceFromPoints(ptrdiff_t hDC, VARIANT* Points);
    ///Converts an array of points in ink space coordinates to an array of points in pixel space.
    ///Params:
    ///    hDC = The handle of the device context on which to draw.
    ///    Points = The array of points in ink space coordinates to convert into pixel locations. This should be an array of
    ///             32-bit integer values, passed within a VARIANT. For more information about the VARIANT structure, see Using
    ///             the COM Library.
    ///Returns:
    ///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt>
    ///    </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl>
    ///    </td> <td width="60%"> A parameter contained an invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> Invalid display handle. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurred inside
    ///    the method. </td> </tr> </table>
    ///    
    HRESULT InkSpaceToPixelFromPoints(ptrdiff_t hDC, VARIANT* Points);
    ///Calculates the rectangle on the device context that would contain a collection of strokes if the strokes were
    ///drawn with the InkRenderer object using the DrawStroke method.
    ///Params:
    ///    Strokes = The collection of strokes to measure.
    ///    Rectangle = When this method returns, contains a pointer to the rectangle on the device context that would contain the
    ///                strokes if they were drawn with the DrawStroke method of the InkRenderer object. The strokes must contain x-
    ///                and y-coordinates to calculate the rectangle. Otherwise, the method returns an empty rectangle.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    Invalid display handle. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_INCOMPATIBLE_OBJECT</b></dt>
    ///    </dl> </td> <td width="60%"> The <i>strokes</i> parameter does not point to a valid object. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_INK_MISMATCHED_INK_OBJECT</b></dt> </dl> </td> <td width="60%"> The strokes
    ///    parameter is associated with a different InkDisp object. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurred inside the method. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> Unexpected
    ///    parameter or property type. </td> </tr> </table>
    ///    
    HRESULT Measure(IInkStrokes Strokes, IInkRectangle* Rectangle);
    ///Calculates the rectangle on the device context that would contain a stroke if it were drawn with the InkRenderer
    ///object using the DrawStroke method.
    ///Params:
    ///    Stroke = The stroke to measure.
    ///    DrawingAttributes = Optional. The InkDrawingAttributes to use when calculating the rectangle, which override the drawing
    ///                        attributes on the stroke. The default value is <b>NULL</b>, which means the stroke is measured by using its
    ///                        own drawing attributes.
    ///    Rectangle = When this method returns, contains a pointer to the rectangle on the device context that would contain the
    ///                stroke if the stroke were drawn with the DrawStroke method of the InkRenderer object. The stroke must contain
    ///                x- and y-coordinates to calculate the rectangle. Otherwise, the method returns an empty rectangle.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>REGDB_E_CLASSNOTREG</b></dt> </dl> </td> <td width="60%"> The InkRectangle object is
    ///    not registered on the system. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INK_INCOMPATIBLE_OBJECT</b></dt> </dl> </td> <td width="60%"> IInkStrokeDisp does not point to a
    ///    compatible InkDisp object, or <i>drawingAttributes</i> is an invalid input parameter. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurred inside
    ///    the method. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A
    ///    parameter contained an invalid pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid display handle. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> Unexpected parameter or property type. </td> </tr>
    ///    </table>
    ///    
    HRESULT MeasureStroke(IInkStrokeDisp Stroke, IInkDrawingAttributes DrawingAttributes, IInkRectangle* Rectangle);
    ///Applies a translation to the view transform in ink space coordinates.
    ///Params:
    ///    HorizontalComponent = The amount in ink space coordinates to translate the view transform in the X dimension.
    ///    VerticalComponent = The amount in ink space coordinates to translate the view transform in the Y dimension.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Move(float HorizontalComponent, float VerticalComponent);
    ///Applies a rotation to a InkRenderer's view transform.
    ///Params:
    ///    Degrees = The degrees by which to rotate clockwise.
    ///    x = Optional. The x-coordinate of the point in ink space coordinates around which to rotate. The default is zero.
    ///    y = Optional. The y-coordinate of the point in ink space coordinates around which to rotate. The default is zero.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurred inside
    ///    the method. </td> </tr> </table>
    ///    
    HRESULT Rotate(float Degrees, float x, float y);
    ///Scales the view transform in the X and Y dimension.
    ///Params:
    ///    HorizontalMultiplier = The factor to scale the X dimension in the view transform.
    ///    VerticalMultiplier = The factor to scale the Y dimension in the view transform.
    ///    ApplyOnPenWidth = Optional. <b>VARIANT_TRUE</b> to apply the scale factors to the pen width; otherwise, <b>VARIANT_FALSE</b>.
    ///                      The default is <b>VARIANT_TRUE</b>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurred inside
    ///    the method. </td> </tr> </table>
    ///    
    HRESULT ScaleTransform(float HorizontalMultiplier, float VerticalMultiplier, short ApplyOnPenWidth);
}

///Represents the object used to capture ink from available tablet devices.
@GUID("F0F060B5-8B1F-4A7C-89EC-880692588A4F")
interface IInkCollector : IDispatch
{
    ///Gets or sets the handle value of the window on which ink is drawn. This property is read/write.
    HRESULT get_hWnd(ptrdiff_t* CurrentWindow);
    ///Gets or sets the handle value of the window on which ink is drawn. This property is read/write.
    HRESULT put_hWnd(ptrdiff_t NewWindow);
    ///Gets or sets a value that specifies whether the InkCollector object collects pen input (in-air packets, cursor in
    ///range events, and so on). This property is read/write.
    HRESULT get_Enabled(short* Collecting);
    ///Gets or sets a value that specifies whether the InkCollector object collects pen input (in-air packets, cursor in
    ///range events, and so on). This property is read/write.
    HRESULT put_Enabled(short Collecting);
    ///Gets or sets the default drawing attributes to use when drawing and displaying ink. This property is read/write.
    HRESULT get_DefaultDrawingAttributes(IInkDrawingAttributes* CurrentAttributes);
    ///Gets or sets the default drawing attributes to use when drawing and displaying ink. This property is read/write.
    HRESULT putref_DefaultDrawingAttributes(IInkDrawingAttributes NewAttributes);
    ///Gets or sets the InkRenderer object that is used to draw ink. This property is read/write.
    HRESULT get_Renderer(IInkRenderer* CurrentInkRenderer);
    ///Gets or sets the InkRenderer object that is used to draw ink. This property is read/write.
    HRESULT putref_Renderer(IInkRenderer NewInkRenderer);
    ///Gets or sets the InkDisp object that is associated with an InkCollector object or an InkOverlay object. This
    ///property is read/write.
    HRESULT get_Ink(IInkDisp* Ink);
    ///Gets or sets the InkDisp object that is associated with an InkCollector object or an InkOverlay object. This
    ///property is read/write.
    HRESULT putref_Ink(IInkDisp NewInk);
    ///Gets or sets a value that specifies whether an ink collector repaints the ink when the window is invalidated.
    ///This property is read/write.
    HRESULT get_AutoRedraw(short* AutoRedraw);
    ///Gets or sets a value that specifies whether an ink collector repaints the ink when the window is invalidated.
    ///This property is read/write.
    HRESULT put_AutoRedraw(short AutoRedraw);
    ///Gets a value that specifies whether ink is currently being drawn on an ink collector (InkCollector, InkOverlay,
    ///or InkPicture). This property is read-only.
    HRESULT get_CollectingInk(short* Collecting);
    ///Gets or sets the collection mode that determines whether ink, gesture, or both are recognized as the user writes.
    ///This property is read/write.
    HRESULT get_CollectionMode(InkCollectionMode* Mode);
    ///Gets or sets the collection mode that determines whether ink, gesture, or both are recognized as the user writes.
    ///This property is read/write.
    HRESULT put_CollectionMode(InkCollectionMode Mode);
    ///Gets or sets the value that specifies whether ink is rendered as it is drawn. This property is read/write.
    HRESULT get_DynamicRendering(short* Enabled);
    ///Gets or sets the value that specifies whether ink is rendered as it is drawn. This property is read/write.
    HRESULT put_DynamicRendering(short Enabled);
    ///Gets or sets the desired packet description of the InkCollector. This property is read/write.
    HRESULT get_DesiredPacketDescription(VARIANT* PacketGuids);
    ///Gets or sets the desired packet description of the InkCollector. This property is read/write.
    HRESULT put_DesiredPacketDescription(VARIANT PacketGuids);
    ///Gets or sets the custom mouse icon. This property is read/write.
    HRESULT get_MouseIcon(IPictureDisp* MouseIcon);
    HRESULT put_MouseIcon(IPictureDisp MouseIcon);
    ///Gets or sets the custom mouse icon. This property is read/write.
    HRESULT putref_MouseIcon(IPictureDisp MouseIcon);
    ///Gets or sets a value that indicates the type of mouse pointer that appears. This property is read/write.
    HRESULT get_MousePointer(InkMousePointer* MousePointer);
    ///Gets or sets a value that indicates the type of mouse pointer that appears. This property is read/write.
    HRESULT put_MousePointer(InkMousePointer MousePointer);
    ///Gets the collection of cursors that are available for use in the inking region. Each cursor corresponds to the
    ///tip of a pen or other ink input device. This property is read-only.
    HRESULT get_Cursors(IInkCursors* Cursors);
    ///Gets or sets the x-axis margin around the window rectangle, in screen coordinates. This margin provides a buffer
    ///around the edge of the ink window. This property is read/write.
    HRESULT get_MarginX(int* MarginX);
    ///Gets or sets the x-axis margin around the window rectangle, in screen coordinates. This margin provides a buffer
    ///around the edge of the ink window. This property is read/write.
    HRESULT put_MarginX(int MarginX);
    ///Gets or sets the y-axis margin around the window rectangle, in screen coordinates. This margin provides a buffer
    ///around the edge of the ink window. This property is read/write.
    HRESULT get_MarginY(int* MarginY);
    ///Gets or sets the y-axis margin around the window rectangle, in screen coordinates. This margin provides a buffer
    ///around the edge of the ink window. This property is read/write.
    HRESULT put_MarginY(int MarginY);
    ///Gets either the IInkTablet object to which a cursor belongs or the <b>IInkTablet</b> object that an object or
    ///control is currently using to collect input. This property is read-only.
    HRESULT get_Tablet(IInkTablet* SingleTablet);
    ///Gets or sets a value that specifies whether ink is rendered as just one color when the system is in High Contrast
    ///mode. This property is read/write.
    HRESULT get_SupportHighContrastInk(short* Support);
    ///Gets or sets a value that specifies whether ink is rendered as just one color when the system is in High Contrast
    ///mode. This property is read/write.
    HRESULT put_SupportHighContrastInk(short Support);
    ///Modifies the interest of the object or control in a known gesture.
    ///Params:
    ///    Gesture = The gesture that you want to set the status of.
    ///    Listen = <b>VARIANT_TRUE</b> to indicate that the gesture is being used or <b>VARIANT_FALSE</b> if it is being
    ///             ignored.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_INVALID_MODE</b></dt> </dl> </td> <td
    ///    width="60%"> The InkCollector collection mode must be in gesture mode. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurred. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>TPC_S_TRUNCATED</b></dt> </dl> </td> <td width="60%"> Unsupported gesture. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The flag is
    ///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    Cannot allocate memory operation. </td> </tr> </table>
    ///    
    HRESULT SetGestureStatus(InkApplicationGesture Gesture, short Listen);
    ///Indicates whether the InkCollector or InkOverlay object is interested in a particular application gesture.
    ///Params:
    ///    Gesture = Sets the gesture that you want the status of.
    ///    Listening = <b>VARIANT_TRUE</b> if the InkCollector control has interest in a particular application gesture; otherwise,
    ///                <b>VARIANT_VALSE</b>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_INVALID_MODE</b></dt> </dl> </td> <td
    ///    width="60%"> Collection mode must be in gesture-mode. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Cannot allocate memory to perform action. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception
    ///    occurred. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    The flag is invalid. </td> </tr> </table>
    ///    
    HRESULT GetGestureStatus(InkApplicationGesture Gesture, short* Listening);
    ///Gets the window rectangle, in pixels, within which ink is drawn.
    ///Params:
    ///    WindowInputRectangle = The rectangle, of type InkRectangle, on which ink is drawn.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contains an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>REGDB_CLASSNOTREG</b></dt> </dl> </td> <td
    ///    width="60%"> The InkRectangle object is not registered. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurs inside the method. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetWindowInputRectangle(IInkRectangle* WindowInputRectangle);
    ///Sets the window rectangle, in pixels, within which ink is drawn.
    ///Params:
    ///    WindowInputRectangle = The rectangle, in window coordinates, on which ink is drawn.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The
    ///    rectangle coordinates are invalid (for example, width/height of 0). </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INK_COLLECTOR_BUSY</b></dt> </dl> </td> <td width="60%"> Cannot update mappings while in the middle
    ///    of a stroke. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td
    ///    width="60%"> An exception occurred inside the method. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INK_OVERLAPPING_INPUT_RECT</b></dt> </dl> </td> <td width="60%"> The window input rectangle overlaps
    ///    with the window input rectangle of an enabled InkCollector. </td> </tr> </table>
    ///    
    HRESULT SetWindowInputRectangle(IInkRectangle WindowInputRectangle);
    ///Allows an ink collector (InkCollector, InkOverlay, or InkPicture) to collect ink from any tablet attached to the
    ///Tablet PC.
    ///Params:
    ///    UseMouseForInput = <b>VARIANT_TRUE</b> to use the mouse for input; otherwise, <b>VARIANT_FALSE</b>. The default value is
    ///                       <b>VARIANT_TRUE</b>. This parameter is optional.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INK_COLLECTOR_ENABLED</b></dt> </dl> </td> <td width="60%"> Cannot change modes
    ///    while the InkCollector is enabled. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt>
    ///    </dl> </td> <td width="60%"> An exception occurred inside the method. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The flag is invalid. </td> </tr> </table>
    ///    
    HRESULT SetAllTabletsMode(short UseMouseForInput);
    ///Allows the ink collector (InkCollector, InkOverlay, or InkPicture) to collect ink from only one tablet. Ink from
    ///other tablets is ignored by the ink collector.
    ///Params:
    ///    Tablet = The tablet on which ink is collected, or drawn.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_COLLECTOR_ENABLED</b></dt> </dl> </td> <td
    ///    width="60%"> The tablet cannot change modes while the collector is enabled. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurred while processing.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_INCOMPATIBLE_OBJECT</b></dt> </dl> </td> <td width="60%">
    ///    The tablet does not point to a compatible Ink object. </td> </tr> </table>
    ///    
    HRESULT SetSingleTabletIntegratedMode(IInkTablet Tablet);
    ///Retrieves the interest an object has in a particular event for the InkCollector class, InkOverlay class, or
    ///InkPicture class.
    ///Params:
    ///    EventId = The event this method checks the interest of.
    ///    Listen = <b>VARIANT_BOOL</b> if interest in the specified event has been set; otherwise, <b>VARIANT_FALSE</b>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    Invalid event interest. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td>
    ///    <td width="60%"> An exception occurred during processing. </td> </tr> </table>
    ///    
    HRESULT GetEventInterest(InkCollectorEventInterest EventId, short* Listen);
    ///Modifies a value that indicates whether an object or control has interest in a specified event.
    ///Params:
    ///    EventId = The event to be listened for.
    ///    Listen = <b>VARIANT_TRUE</b> to indicate that the event is being used; <b>VARIANT_FALSE</b> if it is being ignored.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    Invalid event interest. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td>
    ///    <td width="60%"> An exception occurred during processing. </td> </tr> </table>
    ///    
    HRESULT SetEventInterest(InkCollectorEventInterest EventId, short Listen);
}

@GUID("11A583F2-712D-4FEA-ABCF-AB4AF38EA06B")
interface _IInkCollectorEvents : IDispatch
{
}

///Represents an object that is useful for annotation scenarios where users are not concerned with performing
///recognition on ink but instead are interested in the size, shape, color, and position of the ink.
@GUID("B82A463B-C1C5-45A3-997C-DEAB5651B67A")
interface IInkOverlay : IDispatch
{
    ///Gets or sets the handle value of the window on which ink is drawn. This property is read/write.
    HRESULT get_hWnd(ptrdiff_t* CurrentWindow);
    ///Gets or sets the handle value of the window on which ink is drawn. This property is read/write.
    HRESULT put_hWnd(ptrdiff_t NewWindow);
    ///Gets or sets a value that specifies whether the InkOverlay object collects pen input (in-air packets, cursor in
    ///range events, and so on). This property is read/write.
    HRESULT get_Enabled(short* Collecting);
    ///Gets or sets a value that specifies whether the InkOverlay object collects pen input (in-air packets, cursor in
    ///range events, and so on). This property is read/write.
    HRESULT put_Enabled(short Collecting);
    ///Gets or sets the default drawing attributes to use when drawing and displaying ink. This property is read/write.
    HRESULT get_DefaultDrawingAttributes(IInkDrawingAttributes* CurrentAttributes);
    HRESULT putref_DefaultDrawingAttributes(IInkDrawingAttributes NewAttributes);
    ///Gets or sets the InkRenderer object that is used to draw ink. This property is read/write.
    HRESULT get_Renderer(IInkRenderer* CurrentInkRenderer);
    HRESULT putref_Renderer(IInkRenderer NewInkRenderer);
    ///Gets or sets the InkDisp object that is associated with an InkCollector object or an InkOverlay object. This
    ///property is read/write.
    HRESULT get_Ink(IInkDisp* Ink);
    HRESULT putref_Ink(IInkDisp NewInk);
    ///Gets or sets a value that specifies whether an ink collector repaints the ink when the window is invalidated.
    ///This property is read/write.
    HRESULT get_AutoRedraw(short* AutoRedraw);
    ///Gets or sets a value that specifies whether an ink collector repaints the ink when the window is invalidated.
    ///This property is read/write.
    HRESULT put_AutoRedraw(short AutoRedraw);
    ///Gets a value that specifies whether ink is currently being drawn on an ink collector (InkCollector, InkOverlay,
    ///or InkPicture). This property is read-only.
    HRESULT get_CollectingInk(short* Collecting);
    ///Gets or sets the collection mode that determines whether ink, gesture, or both are recognized as the user writes.
    ///This property is read/write.
    HRESULT get_CollectionMode(InkCollectionMode* Mode);
    ///Gets or sets the collection mode that determines whether ink, gesture, or both are recognized as the user writes.
    ///This property is read/write.
    HRESULT put_CollectionMode(InkCollectionMode Mode);
    ///Gets or sets the value that specifies whether ink is rendered as it is drawn. This property is read/write.
    HRESULT get_DynamicRendering(short* Enabled);
    ///Gets or sets the value that specifies whether ink is rendered as it is drawn. This property is read/write.
    HRESULT put_DynamicRendering(short Enabled);
    ///Gets or sets the desired packet description of the InkCollector. This property is read/write.
    HRESULT get_DesiredPacketDescription(VARIANT* PacketGuids);
    ///Gets or sets the desired packet description of the InkCollector. This property is read/write.
    HRESULT put_DesiredPacketDescription(VARIANT PacketGuids);
    ///Gets or sets the custom mouse icon. This property is read/write.
    HRESULT get_MouseIcon(IPictureDisp* MouseIcon);
    ///Gets or sets the custom mouse icon. This property is read/write.
    HRESULT put_MouseIcon(IPictureDisp MouseIcon);
    HRESULT putref_MouseIcon(IPictureDisp MouseIcon);
    ///Gets or sets a value that indicates the type of mouse pointer that appears. This property is read/write.
    HRESULT get_MousePointer(InkMousePointer* MousePointer);
    ///Gets or sets a value that indicates the type of mouse pointer that appears. This property is read/write.
    HRESULT put_MousePointer(InkMousePointer MousePointer);
    ///Gets or sets a value that specifies whether the object/control is in ink mode, deletion mode, or
    ///selecting/editing mode. This property is read/write.
    HRESULT get_EditingMode(InkOverlayEditingMode* EditingMode);
    ///Gets or sets a value that specifies whether the object/control is in ink mode, deletion mode, or
    ///selecting/editing mode. This property is read/write.
    HRESULT put_EditingMode(InkOverlayEditingMode EditingMode);
    ///Gets or sets the InkStrokes collection that is currently selected inside the InkOverlay object or the InkPicture
    ///control. This property is read/write.
    HRESULT get_Selection(IInkStrokes* Selection);
    ///Gets or sets the InkStrokes collection that is currently selected inside the InkOverlay object or the InkPicture
    ///control. This property is read/write.
    HRESULT put_Selection(IInkStrokes Selection);
    ///Gets or sets the value that specifies whether ink is erased by stroke or by point. This property is read/write.
    HRESULT get_EraserMode(InkOverlayEraserMode* EraserMode);
    ///Gets or sets the value that specifies whether ink is erased by stroke or by point. This property is read/write.
    HRESULT put_EraserMode(InkOverlayEraserMode EraserMode);
    ///Gets or sets the value that specifies the width of the eraser pen tip. This property is read/write.
    HRESULT get_EraserWidth(int* EraserWidth);
    ///Gets or sets the value that specifies the width of the eraser pen tip. This property is read/write.
    HRESULT put_EraserWidth(int newEraserWidth);
    ///Gets or sets the value that specifies whether the InkOverlay object is attached behind or in front of the known
    ///window. This property is read/write.
    HRESULT get_AttachMode(InkOverlayAttachMode* AttachMode);
    ///Gets or sets the value that specifies whether the InkOverlay object is attached behind or in front of the known
    ///window. This property is read/write.
    HRESULT put_AttachMode(InkOverlayAttachMode AttachMode);
    ///Gets the collection of cursors that are available for use in the inking region. Each cursor corresponds to the
    ///tip of a pen or other ink input device. This property is read-only.
    HRESULT get_Cursors(IInkCursors* Cursors);
    ///Gets or sets the x-axis margin around the window rectangle, in screen coordinates. This margin provides a buffer
    ///around the edge of the ink window. This property is read/write.
    HRESULT get_MarginX(int* MarginX);
    ///Gets or sets the x-axis margin around the window rectangle, in screen coordinates. This margin provides a buffer
    ///around the edge of the ink window. This property is read/write.
    HRESULT put_MarginX(int MarginX);
    ///Gets or sets the y-axis margin around the window rectangle, in screen coordinates. This margin provides a buffer
    ///around the edge of the ink window. This property is read/write.
    HRESULT get_MarginY(int* MarginY);
    ///Gets or sets the y-axis margin around the window rectangle, in screen coordinates. This margin provides a buffer
    ///around the edge of the ink window. This property is read/write.
    HRESULT put_MarginY(int MarginY);
    ///Gets either the IInkTablet object to which a cursor belongs or the <b>IInkTablet</b> object that an object or
    ///control is currently using to collect input. This property is read-only.
    HRESULT get_Tablet(IInkTablet* SingleTablet);
    ///Gets or sets a value that specifies whether ink is rendered as just one color when the system is in High Contrast
    ///mode. This property is read/write.
    HRESULT get_SupportHighContrastInk(short* Support);
    ///Gets or sets a value that specifies whether ink is rendered as just one color when the system is in High Contrast
    ///mode. This property is read/write.
    HRESULT put_SupportHighContrastInk(short Support);
    ///Gets or sets a value that specifies whether all selection user interface (UI) elements are drawn in high contrast
    ///when the system is in High Contrast mode. This property is read/write.
    HRESULT get_SupportHighContrastSelectionUI(short* Support);
    ///Gets or sets a value that specifies whether all selection user interface (UI) elements are drawn in high contrast
    ///when the system is in High Contrast mode. This property is read/write.
    HRESULT put_SupportHighContrastSelectionUI(short Support);
    ///Determines what portion of the selection was hit during a hit test.
    ///Params:
    ///    x = The x-position, in pixels, of the hit test.
    ///    y = The y-position, in pixels, of the hit test.
    ///    SelArea = The value from the SelectionHitResult enumeration,which specifies which part of a selection, if any, was hit
    ///              during a hit test.
    ///Returns:
    ///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>East</b></dt>
    ///    </dl> </td> <td width="60%"> The east side sizing handle was hit. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>None</b></dt> </dl> </td> <td width="60%"> No part of the selection was hit. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>North</b></dt> </dl> </td> <td width="60%"> The north side sizing handle was hit.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Northeast</b></dt> </dl> </td> <td width="60%"> The northeast
    ///    corner sizing handle was hit. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Northwest</b></dt> </dl> </td>
    ///    <td width="60%"> The northwest corner sizing handle was hit. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>Selection</b></dt> </dl> </td> <td width="60%"> The selection itself was hit (no selection handle was
    ///    hit). </td> </tr> <tr> <td width="40%"> <dl> <dt><b>South</b></dt> </dl> </td> <td width="60%"> The south
    ///    side sizing handle was hit. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Southeast</b></dt> </dl> </td> <td
    ///    width="60%"> The southeast corner sizing handle was hit. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>Southwest</b></dt> </dl> </td> <td width="60%"> The southwest corner sizing handle was hit. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>West</b></dt> </dl> </td> <td width="60%"> The west side sizing
    ///    handle was hit. </td> </tr> </table>
    ///    
    HRESULT HitTestSelection(int x, int y, SelectionHitResult* SelArea);
    ///Sets a rectangle in which to redraw the ink within the InkOverlay object.
    ///Params:
    ///    Rect = The rectangle on which to draw, in pixel coordinates. When this parameter is <b>NULL</b>, the entire window
    ///           is redrawn.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT Draw(IInkRectangle Rect);
    ///Sets the interest of the object or control in a known gesture.
    ///Params:
    ///    Gesture = The gesture that you want to set the status of.
    ///    Listen = <b>VARIANT_TRUE</b> if the gesture is being used or <b>VARIANT_FALSE</b> if it is being ignored.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_INVALID_MODE</b></dt> </dl> </td> <td
    ///    width="60%"> InkCollector collection mode must be in gesture mode. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurred. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>TPC_S_TRUNCATED</b></dt> </dl> </td> <td width="60%"> Unsupported gesture. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The flag is
    ///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    Cannot allocate memory operation. </td> </tr> </table>
    ///    
    HRESULT SetGestureStatus(InkApplicationGesture Gesture, short Listen);
    ///Retrieves a value that determines whether the InkCollector or InkOverlay object is interested in a particular
    ///application gesture.
    ///Params:
    ///    Gesture = The gesture that you want the status of.
    ///    Listening = <b>VARIANT_TRUE</b> if the InkCollector control has interest in a particular application gesture; otherwise,
    ///                <b>VARIANT_FALSE</b>. This method returns a value that indicates the interest of the InkCollector or
    ///                InkOverlay object in a known application gesture. If <b>VARIANT_TRUE</b>, the <b>InkCollector</b> or
    ///                <b>InkOverlay</b> object is interested in the gesture and the Gesture event of the <b>InkCollector</b> or
    ///                <b>InkOverlay</b> object fires when the gesture is recognized.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_INVALID_MODE</b></dt> </dl> </td> <td
    ///    width="60%"> Collection mode must be in gesture-mode. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Cannot allocate memory to perform action. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception
    ///    occurred. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    The flag is invalid. </td> </tr> </table>
    ///    
    HRESULT GetGestureStatus(InkApplicationGesture Gesture, short* Listening);
    ///Gets the window rectangle, in pixels, within which ink is drawn.
    ///Params:
    ///    WindowInputRectangle = The rectangle, of type InkRectangle, on which ink is drawn.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contains an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>REGDB_CLASSNOTREG</b></dt> </dl> </td> <td
    ///    width="60%"> The InkRectangle object is not registered. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurs inside the method. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetWindowInputRectangle(IInkRectangle* WindowInputRectangle);
    ///Sets the window rectangle, in pixels, within which ink is drawn.
    ///Params:
    ///    WindowInputRectangle = The rectangle, in window coordinates, on which ink is drawn.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The
    ///    rectangle coordinates are invalid (for example, width/height of 0). </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INK_COLLECTOR_BUSY</b></dt> </dl> </td> <td width="60%"> Cannot update mappings while in the middle
    ///    of a stroke. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td
    ///    width="60%"> An exception occurred inside the method. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INK_OVERLAPPING_INPUT_RECT</b></dt> </dl> </td> <td width="60%"> The window input rectangle overlaps
    ///    with the window input rectangle of an enabled InkCollector. </td> </tr> </table>
    ///    
    HRESULT SetWindowInputRectangle(IInkRectangle WindowInputRectangle);
    ///Allows an ink collector (InkCollector, InkOverlay, or InkPicture) to collect ink from any tablet attached to the
    ///Tablet PC.
    ///Params:
    ///    UseMouseForInput = Optional. <b>VARIANT_TRUE</b> to use the mouse as an input device; otherwise, <b>VARIANT_FALSE</b>. The
    ///                       default value is <b>VARIANT_TRUE</b>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INK_COLLECTOR_ENABLED</b></dt> </dl> </td> <td width="60%"> Cannot change modes
    ///    while the InkCollector is enabled. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt>
    ///    </dl> </td> <td width="60%"> An exception occurred inside the method. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The flag is invalid. </td> </tr> </table>
    ///    
    HRESULT SetAllTabletsMode(short UseMouseForInput);
    ///Allows the ink collector (InkCollector, InkOverlay, or InkPicture) to collect ink from only one tablet. Ink from
    ///other tablets is ignored by the ink collector.
    ///Params:
    ///    Tablet = The tablet on which ink is collected, or drawn.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_COLLECTOR_ENABLED</b></dt> </dl> </td> <td
    ///    width="60%"> Cannot change modes while the collector is enabled. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurred while processing. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_INCOMPATIBLE_OBJECT</b></dt> </dl> </td> <td width="60%">
    ///    <i>tablet</i> does not point to a compatible Ink object. </td> </tr> </table>
    ///    
    HRESULT SetSingleTabletIntegratedMode(IInkTablet Tablet);
    ///Retrieves the interest an object has in a particular event for the InkCollector class, InkOverlay class, or
    ///InkPicture class.
    ///Params:
    ///    EventId = The event in which the ink collector is or is not interested.
    ///    Listen = <b>VARIANT_TRUE</b> if interest in the specified event has been set; otherwise, <b>VARIANT_FALSE</b>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    Invalid event interest. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td>
    ///    <td width="60%"> An exception occurred during processing. </td> </tr> </table>
    ///    
    HRESULT GetEventInterest(InkCollectorEventInterest EventId, short* Listen);
    ///Sets a value that indicates whether an object or control has interest in a specified event.
    ///Params:
    ///    EventId = The event to be listened for. Possible values for <i>EventID</i> appear in the InkCollectorEventInterest
    ///              enumeration type.
    ///    Listen = <b>VARIANT_TRUE</b> if the event is being used and <b>VARIANT_FALSE</b> if it is being ignored.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    Invalid event interest. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td>
    ///    <td width="60%"> An exception occurred during processing. </td> </tr> </table>
    ///    
    HRESULT SetEventInterest(InkCollectorEventInterest EventId, short Listen);
}

@GUID("31179B69-E563-489E-B16F-712F1E8A0651")
interface _IInkOverlayEvents : IDispatch
{
}

///Represents an object that provides the ability to place an image in an application for users to add ink on top of. It
///is intended for scenarios in which ink is not recognized as text but is instead stored as ink.
@GUID("E85662E0-379A-40D7-9B5C-757D233F9923")
interface IInkPicture : IDispatch
{
    ///Gets or sets the handle value of the window on which ink is drawn. This property is read/write.
    HRESULT get_hWnd(ptrdiff_t* CurrentWindow);
    ///Gets or sets the default drawing attributes to use when drawing and displaying ink. This property is read/write.
    HRESULT get_DefaultDrawingAttributes(IInkDrawingAttributes* CurrentAttributes);
    HRESULT putref_DefaultDrawingAttributes(IInkDrawingAttributes NewAttributes);
    ///Gets or sets the InkRenderer object that is used to draw ink. This property is read/write.
    HRESULT get_Renderer(IInkRenderer* CurrentInkRenderer);
    HRESULT putref_Renderer(IInkRenderer NewInkRenderer);
    ///Gets or sets the InkDisp object that is associated with the InkPicture control. This property is read/write.
    HRESULT get_Ink(IInkDisp* Ink);
    HRESULT putref_Ink(IInkDisp NewInk);
    ///Gets or sets a value that specifies whether an ink collectcor repaints the ink when the window is invalidated.
    ///This property is read/write.
    HRESULT get_AutoRedraw(short* AutoRedraw);
    ///Gets or sets a value that specifies whether an ink collectcor repaints the ink when the window is invalidated.
    ///This property is read/write.
    HRESULT put_AutoRedraw(short AutoRedraw);
    ///Gets a value that specifies whether ink is currently being drawn on an ink collector (InkCollector, InkOverlay,
    ///or InkPicture). This property is read-only.
    HRESULT get_CollectingInk(short* Collecting);
    ///Gets or sets the collection mode that determines whether ink, gestures, or both are recognized as the user
    ///writes. This property is read/write.
    HRESULT get_CollectionMode(InkCollectionMode* Mode);
    ///Gets or sets the collection mode that determines whether ink, gestures, or both are recognized as the user
    ///writes. This property is read/write.
    HRESULT put_CollectionMode(InkCollectionMode Mode);
    ///Gets or sets the value that specifies whether ink is rendered as it is drawn. This property is read/write.
    HRESULT get_DynamicRendering(short* Enabled);
    ///Gets or sets the value that specifies whether ink is rendered as it is drawn. This property is read/write.
    HRESULT put_DynamicRendering(short Enabled);
    ///Gets or sets the desired packet description of the InkCollector. This property is read/write.
    HRESULT get_DesiredPacketDescription(VARIANT* PacketGuids);
    ///Gets or sets the desired packet description of the InkCollector. This property is read/write.
    HRESULT put_DesiredPacketDescription(VARIANT PacketGuids);
    ///Gets or sets the custom mouse icon. This property is read/write.
    HRESULT get_MouseIcon(IPictureDisp* MouseIcon);
    ///Gets or sets the custom mouse icon. This property is read/write.
    HRESULT put_MouseIcon(IPictureDisp MouseIcon);
    HRESULT putref_MouseIcon(IPictureDisp MouseIcon);
    ///Gets or sets a value that indicates the type of mouse pointer that appears. This property is read/write.
    HRESULT get_MousePointer(InkMousePointer* MousePointer);
    ///Gets or sets a value that indicates the type of mouse pointer that appears. This property is read/write.
    HRESULT put_MousePointer(InkMousePointer MousePointer);
    ///Gets or sets a value that specifies whether the InkPicture control is in ink mode, deletion mode, or
    ///selecting/editing mode. This property is read/write.
    HRESULT get_EditingMode(InkOverlayEditingMode* EditingMode);
    ///Gets or sets a value that specifies whether the InkPicture control is in ink mode, deletion mode, or
    ///selecting/editing mode. This property is read/write.
    HRESULT put_EditingMode(InkOverlayEditingMode EditingMode);
    ///Gets or sets theInkStrokes collection that is currently selected inside the InkOverlay object or the InkPicture
    ///control. This property is read/write.
    HRESULT get_Selection(IInkStrokes* Selection);
    ///Gets or sets theInkStrokes collection that is currently selected inside the InkOverlay object or the InkPicture
    ///control. This property is read/write.
    HRESULT put_Selection(IInkStrokes Selection);
    ///Gets or sets a value that specifies whether ink is erased by stroke or by point. This property is read/write.
    HRESULT get_EraserMode(InkOverlayEraserMode* EraserMode);
    ///Gets or sets a value that specifies whether ink is erased by stroke or by point. This property is read/write.
    HRESULT put_EraserMode(InkOverlayEraserMode EraserMode);
    ///Gets or sets a value that specifies the width of the eraser pen tip. This property is read/write.
    HRESULT get_EraserWidth(int* EraserWidth);
    ///Gets or sets a value that specifies the width of the eraser pen tip. This property is read/write.
    HRESULT put_EraserWidth(int newEraserWidth);
    HRESULT putref_Picture(IPictureDisp pPicture);
    ///Gets the graphics file to appear on the InkPicture control. This property is read/write.
    HRESULT put_Picture(IPictureDisp pPicture);
    ///Gets the graphics file to appear on the InkPicture control. This property is read/write.
    HRESULT get_Picture(IPictureDisp* ppPicture);
    ///Gets or sets how the InkPicture control handles image placement and sizing. This property is read/write.
    HRESULT put_SizeMode(InkPictureSizeMode smNewSizeMode);
    ///Gets or sets how the InkPicture control handles image placement and sizing. This property is read/write.
    HRESULT get_SizeMode(InkPictureSizeMode* smSizeMode);
    ///Gets or sets the background color for the InkPicture control. This property is read/write.
    HRESULT put_BackColor(uint newColor);
    ///Gets or sets the background color for the InkPicture control. This property is read/write.
    HRESULT get_BackColor(uint* pColor);
    ///Gets the collection of cursors that are available for use in the inking region. Each cursor corresponds to the
    ///tip of a pen or other ink input device. This property is read-only.
    HRESULT get_Cursors(IInkCursors* Cursors);
    ///Gets or sets the x-axis margin around the window rectangle, in screen coordinates. This margin provides a buffer
    ///around the edge of the ink window. This property is read/write.
    HRESULT get_MarginX(int* MarginX);
    ///Gets or sets the x-axis margin around the window rectangle, in screen coordinates. This margin provides a buffer
    ///around the edge of the ink window. This property is read/write.
    HRESULT put_MarginX(int MarginX);
    ///Gets or sets the y-axis margin around the window rectangle, in screen coordinates. This margin provides a buffer
    ///around the edge of the ink window. This property is read/write.
    HRESULT get_MarginY(int* MarginY);
    ///Gets or sets the y-axis margin around the window rectangle, in screen coordinates. This margin provides a buffer
    ///around the edge of the ink window. This property is read/write.
    HRESULT put_MarginY(int MarginY);
    ///Gets either the IInkTablet object to which a cursor belongs or the <b>IInkTablet</b> object that an object or
    ///control is currently using to collect input. This property is read-only.
    HRESULT get_Tablet(IInkTablet* SingleTablet);
    ///Gets or sets a value that specifies whether ink is rendered as just one color when the system is in High Contrast
    ///mode. This property is read/write.
    HRESULT get_SupportHighContrastInk(short* Support);
    ///Gets or sets a value that specifies whether ink is rendered as just one color when the system is in High Contrast
    ///mode. This property is read/write.
    HRESULT put_SupportHighContrastInk(short Support);
    ///Gets or sets a value that specifies whether all selection user interface (selection bounding box and selection
    ///handles) are drawn in high contrast when the system is in High Contrast mode. This property is read/write.
    HRESULT get_SupportHighContrastSelectionUI(short* Support);
    ///Gets or sets a value that specifies whether all selection user interface (selection bounding box and selection
    ///handles) are drawn in high contrast when the system is in High Contrast mode. This property is read/write.
    HRESULT put_SupportHighContrastSelectionUI(short Support);
    ///Retrieves a member of the SelectionHitResult enumeration, which specifies which part of a selection, if any, was
    ///hit during a hit test.
    ///Params:
    ///    x = The x-position, in pixels, of the hit test.
    ///    y = The y-position, in pixels, of the hit test.
    ///    SelArea = The value from the SelectionHitResult enumeration.
    HRESULT HitTestSelection(int x, int y, SelectionHitResult* SelArea);
    ///Modifies the interest of the object or control in a known gesture.
    ///Params:
    ///    Gesture = The gesture that you want to set the status of.
    ///    Listen = VARIANT_TRUE to indicate that the gesture is being used; VARIANT_FALSE to indicate the gesture is being
    ///             ignored.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_INVALID_MODE</b></dt> </dl> </td> <td
    ///    width="60%"> InkCollector collection mode must be in gesture mode. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurred. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>TPC_S_TRUNCATED</b></dt> </dl> </td> <td width="60%"> Unsupported gesture. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The flag is
    ///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    Cannot allocate memory operation. </td> </tr> </table>
    ///    
    HRESULT SetGestureStatus(InkApplicationGesture Gesture, short Listen);
    ///Retrieves a value that indicates whether the InkPicture control has interest in a particular application gesture.
    ///Params:
    ///    Gesture = The gesture that you want the status of.
    ///    Listening = <b>VARIANT_TRUE</b> if the InkPicture control has interest in the gesture and the Gesture Event fires when
    ///                the gesture is recognized. <b>VARIANT_FALSE</b> if the InkPicture control has no interest in the gesture, and
    ///                the strokes that were recognized as a gesture remain as IInkStrokeDisp objects.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>HRESULT value</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_INVALID_MODE</b></dt> </dl> </td> <td
    ///    width="60%"> Collection mode must be in gesture-mode. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Cannot allocate memory to perform action. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception
    ///    occurred. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    The flag is invalid. </td> </tr> </table>
    ///    
    HRESULT GetGestureStatus(InkApplicationGesture Gesture, short* Listening);
    ///Retrieves the window rectangle, in pixels, within which ink is drawn.
    ///Params:
    ///    WindowInputRectangle = Gets the rectangle, of type InkRectangle, on which ink is drawn.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contains an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>REGDB_CLASSNOTREG</b></dt> </dl> </td> <td
    ///    width="60%"> The InkRectangle object is not registered. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurs inside the method. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetWindowInputRectangle(IInkRectangle* WindowInputRectangle);
    ///Modifies the window rectangle, in pixels, within which ink is drawn.
    ///Params:
    ///    WindowInputRectangle = The rectangle, in window coordinates, on which ink is drawn.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The
    ///    rectangle coordinates are invalid (for example, width/height of 0). </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INK_COLLECTOR_BUSY</b></dt> </dl> </td> <td width="60%"> Cannot update mappings while in the middle
    ///    of a stroke. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td
    ///    width="60%"> An exception occurred inside the method. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INK_OVERLAPPING_INPUT_RECT</b></dt> </dl> </td> <td width="60%"> The window input rectangle overlaps
    ///    with the window input rectangle of an enabled InkCollector. </td> </tr> </table>
    ///    
    HRESULT SetWindowInputRectangle(IInkRectangle WindowInputRectangle);
    ///Allows an ink collector (InkCollector, InkOverlay, or InkPicture) to collect ink from any tablet attached to the
    ///Tablet PC.
    ///Params:
    ///    UseMouseForInput = Optional. <b>VARIANT_TRUE</b> to use the mouse as an input device; otherwise, <b>VARIANT_FALSE. </b>The
    ///                       default value is <b>VARIANT_TRUE</b>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INK_COLLECTOR_ENABLED</b></dt> </dl> </td> <td width="60%"> Cannot change modes
    ///    while the InkCollector is enabled. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt>
    ///    </dl> </td> <td width="60%"> An exception occurred inside the method. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The flag is invalid. </td> </tr> </table>
    ///    
    HRESULT SetAllTabletsMode(short UseMouseForInput);
    ///Allows the ink collector (InkCollector, InkOverlay, or InkPicture) to collect ink from only one tablet. Ink from
    ///other tablets is ignored by the ink collector.
    ///Params:
    ///    Tablet = The tablet on which ink is collected, or drawn.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_COLLECTOR_ENABLED</b></dt> </dl> </td> <td
    ///    width="60%"> Cannot change modes while the collector is enabled. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurred while processing. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_INCOMPATIBLE_OBJECT</b></dt> </dl> </td> <td width="60%">
    ///    <i>tablet</i> does not point to a compatible Ink object. </td> </tr> </table>
    ///    
    HRESULT SetSingleTabletIntegratedMode(IInkTablet Tablet);
    ///Retrieves the interest an object has in a particular event for the InkCollector class, InkOverlay class, or
    ///InkPicture class.
    ///Params:
    ///    EventId = The event about which the ink collector specifies the interest level.
    ///    Listen = <b>VARIANT_TRUE</b> if interest in the specified event has been sent; otherwise, <b>VARIANT_FALSE</b>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    Invalid event interest. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td>
    ///    <td width="60%"> An exception occurred during processing. </td> </tr> </table>
    ///    
    HRESULT GetEventInterest(InkCollectorEventInterest EventId, short* Listen);
    ///Modifies a value that indicates whether an object or control has interest in a specified event.
    ///Params:
    ///    EventId = The event to be listened for. Possible values for <i>eventID</i> appear in the InkCollectorEventInterest
    ///              enumeration type.
    ///    Listen = <b>VARIANT_TRUE</b> to indicate the event is being used; <b>VARIANT_FALSE</b> to indicate the event is being
    ///             ignored.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    Invalid event interest. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td>
    ///    <td width="60%"> An exception occurred during processing. </td> </tr> </table>
    ///    
    HRESULT SetEventInterest(InkCollectorEventInterest EventId, short Listen);
    ///Gets or sets a value that specifies whether the InkPicture control collects pen input (in-air packets, cursor in
    ///range events, and so on). This property is read/write.
    HRESULT get_InkEnabled(short* Collecting);
    ///Gets or sets a value that specifies whether the InkPicture control collects pen input (in-air packets, cursor in
    ///range events, and so on). This property is read/write.
    HRESULT put_InkEnabled(short Collecting);
    ///Gets or sets a value that determines whether the InkPicture control can respond to user-generated events. This
    ///property is read/write.
    HRESULT get_Enabled(short* pbool);
    ///Gets or sets a value that determines whether the InkPicture control can respond to user-generated events. This
    ///property is read/write.
    HRESULT put_Enabled(short vbool);
}

@GUID("60FF4FEE-22FF-4484-ACC1-D308D9CD7EA3")
interface _IInkPictureEvents : IDispatch
{
}

///Represents the ability to process ink, or handwriting, and translate the stroke into text or gesture. The recognizer
///creates an InkRecognizerContext object, which is used to perform the actual handwriting recognition.
@GUID("782BF7CF-034B-4396-8A32-3A1833CF6B56")
interface IInkRecognizer : IDispatch
{
    ///Gets the name of the object. This property is read-only.
    HRESULT get_Name(BSTR* Name);
    ///Gets the vendor name of the IInkRecognizer object. This property is read-only.
    HRESULT get_Vendor(BSTR* Vendor);
    ///Gets the capabilities of the IInkRecognizer object. This property is read-only.
    HRESULT get_Capabilities(InkRecognizerCapabilities* CapabilitiesFlags);
    ///Gets an array of language identifiers for the languages that the IInkRecognizer object supports. This property is
    ///read-only.
    HRESULT get_Languages(VARIANT* Languages);
    ///Gets an array of globally unique identifiers (GUIDs) that describe the properties that the IInkRecognizer object
    ///supports. This property is read-only.
    HRESULT get_SupportedProperties(VARIANT* SupportedProperties);
    ///Gets an array of globally unique identifiers (GUIDs) that represents the preferred packet properties for the
    ///recognizer. This property is read-only.
    HRESULT get_PreferredPacketDescription(VARIANT* PreferredPacketDescription);
    ///Creates a new InkRecognizerContext object.
    ///Params:
    ///    Context = Returns a InkRecognizerContext for the invoking IInkRecognizer.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%">
    ///    An exception occurred inside the method. </td> </tr> </table>
    ///    
    HRESULT CreateRecognizerContext(IInkRecognizerContext* Context);
}

///Adds members to the IInkWordList2 Interface.
@GUID("6110118A-3A75-4AD6-B2AA-04B2B72BBE65")
interface IInkRecognizer2 : IDispatch
{
    ///Retrieves the ID for the InkRecognizer.
    ///Params:
    ///    pbstrId = A BSTR containing the ID of the recognizer.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT get_Id(BSTR* pbstrId);
    ///Retrieves the Unicode ranges set for the current recognizer.
    ///Params:
    ///    UnicodeRanges = A VARIANT array containing the Unicode ranges being used by the recognizer. An array (VT_ARRAY) of long
    ///                    integers (VT_ARRAY|VT_UI4). The array consists of alternating pairs for each range. For each pair in the
    ///                    array, the first value specifies the low Unicode code point in the range of supported Unicode points, and the
    ///                    second value specifies the number of Unicode points in the range.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT get_UnicodeRanges(VARIANT* UnicodeRanges);
}

///Represents a collection of IInkRecognizer objects having the ability to create a recognizer context, retrieve its
///attributes and properties, and determine which packet properties the recognizer needs to perform recognition.
@GUID("9CCC4F12-B0B7-4A8B-BF58-4AECA4E8CEFD")
interface IInkRecognizers : IDispatch
{
    ///Gets the number of objects or collections contained in a collection. This property is read-only.
    HRESULT get_Count(int* Count);
    HRESULT get__NewEnum(IUnknown* _NewEnum);
    ///Retrieves the default recognizer for a known language, specified by a national language support (NLS) language
    ///code identifier (LCID).
    ///Params:
    ///    lcid = The LCID locale identifier of the language for which you are retrieving the default recognizer. If
    ///           <i>lcid</i> is 0, the method uses the user's locale setting to determine which default recognizer to
    ///           retrieve. If the user has not specified a locale in Regional Options, the method uses the locale that was
    ///           specified for the computer. The default value is 0.
    ///    DefaultRecognizer = When this method returns, contains a pointer to the requested recognizer.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%">
    ///    An exception occurred inside the method. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt>
    ///    </dl> </td> <td width="60%"> The flag is invalid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> Unexpected parameter or property type. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetDefaultRecognizer(int lcid, IInkRecognizer* DefaultRecognizer);
    ///Retrieves the IInkRecognizer object at the specified index within the InkRecognizers collection.
    ///Params:
    ///    Index = The zero-based index of the IInkRecognizer object to get.
    ///    InkRecognizer = When this method returns, contains a pointer to the IInkRecognizer object at the specified index within the
    ///                    InkRecognizers collection.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An
    ///    unspecified error occurred. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>CO_E_CLASSTRING</b></dt> </dl>
    ///    </td> <td width="60%"> Invalid GUID format. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>DISP_E_TYPEMISMATCH</b></dt> </dl> </td> <td width="60%"> One of the parameters is not a valid VARIANT
    ///    type. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    Invalid argument. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td
    ///    width="60%"> Unexpected parameter or property type. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>REGDB_CLASSNOTREG</b></dt> </dl> </td> <td width="60%"> Type object not registered. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Cannot allocate memory to
    ///    complete the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td>
    ///    <td width="60%"> An exception occurred inside the method. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>TPC_E_RECOGNIZER_NOT_REGISTERED</b></dt> </dl> </td> <td width="60%"> The recognizers registry key is
    ///    corrupted or your environment does not support handwriting recognition. </td> </tr> </table>
    ///    
    HRESULT Item(int Index, IInkRecognizer* InkRecognizer);
}

@GUID("17BCE92F-2E21-47FD-9D33-3C6AFBFD8C59")
interface _IInkRecognitionEvents : IDispatch
{
}

///Enables the ability to perform ink recognition, retrieve the recognition result, and retrieve alternates. The
///**InkRecognizerContext** enables the various recognizers installed on a system to use ink recognition to process
///input appropriately.
@GUID("C68F52F9-32A3-4625-906C-44FC23B40958")
interface IInkRecognizerContext : IDispatch
{
    ///Gets or sets the InkStrokes collection associated with the InkRecognizerContext object. This property is
    ///read/write.
    HRESULT get_Strokes(IInkStrokes* Strokes);
    ///Gets or sets the InkStrokes collection associated with the InkRecognizerContext object. This property is
    ///read/write.
    HRESULT putref_Strokes(IInkStrokes Strokes);
    ///Gets or sets the character Autocomplete mode, which determines when characters or words are recognized. This
    ///property is read/write.
    HRESULT get_CharacterAutoCompletionMode(InkRecognizerCharacterAutoCompletionMode* Mode);
    ///Gets or sets the character Autocomplete mode, which determines when characters or words are recognized. This
    ///property is read/write.
    HRESULT put_CharacterAutoCompletionMode(InkRecognizerCharacterAutoCompletionMode Mode);
    ///Gets or sets the factoid that a recognizer uses to constrain its search for the recognition result. This property
    ///is read/write.
    HRESULT get_Factoid(BSTR* Factoid);
    ///Gets or sets the factoid that a recognizer uses to constrain its search for the recognition result. This property
    ///is read/write.
    HRESULT put_Factoid(BSTR factoid);
    ///Gets or sets the InkRecognizerGuide to use for ink input. This property is read/write.
    HRESULT get_Guide(IInkRecognizerGuide* RecognizerGuide);
    ///Gets or sets the InkRecognizerGuide to use for ink input. This property is read/write.
    HRESULT putref_Guide(IInkRecognizerGuide RecognizerGuide);
    ///Gets or sets the characters that come before the InkStrokes collection in the InkRecognizerContext object. This
    ///property is read/write.
    HRESULT get_PrefixText(BSTR* Prefix);
    ///Gets or sets the characters that come before the InkStrokes collection in the InkRecognizerContext object. This
    ///property is read/write.
    HRESULT put_PrefixText(BSTR Prefix);
    ///Gets or sets the characters that come after the InkStrokes collection in the InkRecognizerContext object. This
    ///property is read/write.
    HRESULT get_SuffixText(BSTR* Suffix);
    ///Gets or sets the characters that come after the InkStrokes collection in the InkRecognizerContext object. This
    ///property is read/write.
    HRESULT put_SuffixText(BSTR Suffix);
    ///Gets or sets the flags that specify how the recognizer interprets the ink and determines the result string. This
    ///property is read/write.
    HRESULT get_RecognitionFlags(InkRecognitionModes* Modes);
    ///Gets or sets the flags that specify how the recognizer interprets the ink and determines the result string. This
    ///property is read/write.
    HRESULT put_RecognitionFlags(InkRecognitionModes Modes);
    ///Gets or sets the word list that is used in the recognition process to improve the recognition results. This
    ///property is read/write.
    HRESULT get_WordList(IInkWordList* WordList);
    ///Gets or sets the word list that is used in the recognition process to improve the recognition results. This
    ///property is read/write.
    HRESULT putref_WordList(IInkWordList WordList);
    ///Gets the IInkRecognizer object used by the InkRecognizerContext object. This property is read-only.
    HRESULT get_Recognizer(IInkRecognizer* Recognizer);
    ///Performs recognition on an InkStrokes collection and returns recognition results.
    ///Params:
    ///    RecognitionStatus = The most recent InkRecognitionStatus value.
    ///    RecognitionResult = When this method returns, contains a pointer to the IInkRecognitionResult results of a recognized collection
    ///                        of strokes, or else <b>NULL</b> if the recognizer could not compute a result for the ink.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%">
    ///    Unexpected parameter or property type. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt>
    ///    </dl> </td> <td width="60%"> An exception occurred inside the method. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Cannot allocate memory operation. </td> </tr>
    ///    </table>
    ///    
    HRESULT Recognize(InkRecognitionStatus* RecognitionStatus, IInkRecognitionResult* RecognitionResult);
    ///Ends background recognition that was started with a call to BackgroundRecognize or
    ///BackgroundRecognizeWithAlternates.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. This method also returns
    ///    S_OK if the recognizer does not support this method. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Cannot allocate memory to complete the operation.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An
    ///    exception occurred inside method. </td> </tr> </table>
    ///    
    HRESULT StopBackgroundRecognition();
    ///<p class="CCE_Message">[<b>EndInkInput</b> is no longer available for use for recognizers of western languages as
    ///of Windows Vista.] Stops adding ink to the InkRecognizerContext object.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Cannot allocate memory to
    ///    complete the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> An unspecified error occurred. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurred inside the method. </td>
    ///    </tr> </table>
    ///    
    HRESULT EndInkInput();
    ///Causes the IInkRecognizer object to recognize the associated strokes collection and fire a Recognition event when
    ///recognition is complete.
    ///Params:
    ///    CustomData = Specifies any application-defined data that is available to the application in the Recognition event. This
    ///                 parameter may be a VARIANT of type VT_EMPTY or VT_NULL if no data needs to be passed. The default value is
    ///                 <b>NULL</b>. For more information about the VARIANT structure, see Using the COM Library.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Cannot allocate memory to
    ///    complete the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_NO_STROKES_TO_RECOGNIZE</b></dt>
    ///    </dl> </td> <td width="60%"> No strokes exist. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurred inside the method. </td>
    ///    </tr> </table>
    ///    
    HRESULT BackgroundRecognize(VARIANT CustomData);
    ///Causes the IInkRecognizer object to recognize the associated strokes collection and fire a
    ///RecognitionWithAlternates event when recognition is complete.
    ///Params:
    ///    CustomData = Optional. Specifies any application-defined data that is available to the application in the
    ///                 RecognitionWithAlternates event. This parameter may be a VARIANT of type VT_EMPTY or VT_NULL if no data needs
    ///                 to be passed. The default value is <b>NULL</b>. For more information about the VARIANT structure, see Using
    ///                 the COM Library.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>HRESULT Value</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Cannot allocate memory to
    ///    complete the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_NO_STROKES_TO_RECOGNIZE</b></dt>
    ///    </dl> </td> <td width="60%"> No strokes exist. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurred inside the method. </td>
    ///    </tr> </table>
    ///    
    HRESULT BackgroundRecognizeWithAlternates(VARIANT CustomData);
    ///Creates a duplicate InkRecognizerContext object.
    ///Params:
    ///    RecoContext = When this method returns, contains the newly created InkRecognizerContext object.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Cannot allocate memory to
    ///    complete the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> An unspecified error occurred. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> A parameter contained an invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurred inside the method. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>REGDB_CLASSNOTREG</b></dt> </dl> </td> <td width="60%"> The InkDisp
    ///    object was not registered. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td>
    ///    <td width="60%"> Unexpected parameter or property type. </td> </tr> </table>
    ///    
    HRESULT Clone(IInkRecognizerContext* RecoContext);
    ///Indicates whether the system dictionary, user dictionary, or word list contain a specified string.
    ///Params:
    ///    String = The string to look up in the dictionaries and word list. For more information about the BSTR data type, see
    ///             Using the COM Library.
    ///    Supported = When this method returns, contains <b>VARIANT_TRUE</b> if the string is in the dictionary or word list;
    ///                otherwise <b>VARIANT_FALSE</b>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> One of the dictionaries contains the
    ///    string. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A
    ///    parameter contained an invalid pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt>
    ///    </dl> </td> <td width="60%"> Invalid input string. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurred while processing. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Cannot allocate
    ///    memory operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td
    ///    width="60%"> Unexpected parameter or property type. </td> </tr> </table>
    ///    
    HRESULT IsStringSupported(BSTR String, short* Supported);
}

///Adds members to the InkRecognizerContext Class.
@GUID("D6F0E32F-73D8-408E-8E9F-5FEA592C363F")
interface IInkRecognizerContext2 : IDispatch
{
    ///Gets or sets a set of one or more Unicode ranges that the recognizer context will support. This property is
    ///read/write.
    HRESULT get_EnabledUnicodeRanges(VARIANT* UnicodeRanges);
    ///Gets or sets a set of one or more Unicode ranges that the recognizer context will support. This property is
    ///read/write.
    HRESULT put_EnabledUnicodeRanges(VARIANT UnicodeRanges);
}

///Represents the result of the recognition. The results of recognizing handwritten ink are returned in an
///<b>IInkRecognitionResult</b> object.
@GUID("3BC129A8-86CD-45AD-BDE8-E0D32D61C16D")
interface IInkRecognitionResult : IDispatch
{
    ///Gets the result text for the TopAlternate property. This property is read-only.
    HRESULT get_TopString(BSTR* TopString);
    ///Gets the top alternate of the recognition result. This property is read-only.
    HRESULT get_TopAlternate(IInkRecognitionAlternate* TopAlternate);
    ///Gets the top alternate of the recognition result. This property is read-only.
    HRESULT get_TopConfidence(InkRecognitionConfidence* TopConfidence);
    ///Gets the collection of strokes that are contained in an object or used to create an object. This property is
    ///read-only.
    HRESULT get_Strokes(IInkStrokes* Strokes);
    HRESULT AlternatesFromSelection(int selectionStart, int selectionLength, int maximumAlternates, 
                                    IInkRecognitionAlternates* AlternatesFromSelection);
    ///Changes the top alternate of a recognition result by using the specified alternate.
    ///Params:
    ///    Alternate = The IInkRecognitionAlternate to use to modify the top alternate.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>TPC_E_NOT_RELEVANT</b></dt> </dl> </td> <td width="60%"> The lattice does not
    ///    contain data. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A
    ///    parameter contained an invalid pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt>
    ///    </dl> </td> <td width="60%"> The alternate does not match the known range, or it was not obtained from this
    ///    lattice. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%">
    ///    An exception occurred while processing. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt>
    ///    </dl> </td> <td width="60%"> Cannot allocate memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT ModifyTopAlternate(IInkRecognitionAlternate Alternate);
    ///Assigns the recognition results to the strokes that were used to create the results.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> Unexpected parameter or property
    ///    type. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An
    ///    exception occurred while processing. </td> </tr> </table>
    ///    
    HRESULT SetResultOnStrokes();
}

///Represents the possible word matches for segments of ink that are compared to a recognizers dictionary.
@GUID("B7E660AD-77E4-429B-ADDA-873780D1FC4A")
interface IInkRecognitionAlternate : IDispatch
{
    ///Gets the top string of the alternate. This property is read-only.
    HRESULT get_String(BSTR* RecoString);
    ///Gets the level of confidence (strong, intermediate, or poor) that a recognizer has in the recognition of an
    ///IInkRecognitionAlternate object or a gesture. This property is read-only.
    HRESULT get_Confidence(InkRecognitionConfidence* Confidence);
    ///Gets the baseline for a IInkRecognitionAlternate object that represents a single line of text. This property is
    ///read-only.
    HRESULT get_Baseline(VARIANT* Baseline);
    ///Gets the midline for a IInkRecognitionAlternate object that represents a single line of text. This property is
    ///read-only.
    HRESULT get_Midline(VARIANT* Midline);
    ///Gets the ascender line for a IInkRecognitionAlternate object that represents a single line of text. This property
    ///is read-only.
    HRESULT get_Ascender(VARIANT* Ascender);
    ///Gets the decender line for an IInkRecognitionAlternate object that represents a single line of text. This
    ///property is read-only.
    HRESULT get_Descender(VARIANT* Descender);
    ///Gets the line number of the ink that makes up the alternate. This property is read-only.
    HRESULT get_LineNumber(int* LineNumber);
    ///Gets the collection of strokes that are contained in an object or used to create an object. This property is
    ///read-only.
    HRESULT get_Strokes(IInkStrokes* Strokes);
    ///Gets the IInkRecognitionAlternates collection in which each alternate in the collection is on a separate line.
    ///This property is read-only.
    HRESULT get_LineAlternates(IInkRecognitionAlternates* LineAlternates);
    ///Gets the collection of alternates in which each alternate in the collection consists of the segments with the
    ///same property values. This property is read-only.
    HRESULT get_ConfidenceAlternates(IInkRecognitionAlternates* ConfidenceAlternates);
    ///Retrieves the smallest InkStrokes collection that contains a known input InkStrokes collection and for which the
    ///IInkRecognizer object can provide alternates.
    ///Params:
    ///    Strokes = The collection of stroke objects to use to find the smallest stroke collection of the recognition result
    ///              alternate that contains this collection.
    ///    GetStrokesFromStrokeRanges = When this method returns, contains a pointer to the smallest collection of strokes that contains a known
    ///                                 input collection of strokes and for which the recognizer can provide alternates.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%">
    ///    An exception occurred inside the method. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INK_MISMATCHED_INK_OBJECT</b></dt> </dl> </td> <td width="60%"> The strokes parameter is associated
    ///    with a different Ink object. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> An unspecified error occurred. </td> </tr> </table>
    ///    
    HRESULT GetStrokesFromStrokeRanges(IInkStrokes Strokes, IInkStrokes* GetStrokesFromStrokeRanges);
    ///Retrives the collection that corresponds to the smallest set of recognition segments that contains a specified
    ///character range within the alternate.
    ///Params:
    ///    selectionStart = The start of the character range within this alternate. The character at the <i>selectionStart</i> position
    ///                     is included in the range of recognized text. This parameter is adjusted to the beginning of the smallest
    ///                     recognized set of one or more segments that includes the input selection. The <i>selectionStart</i> parameter
    ///                     is a zero-based index into the characters in the recognition alternate's text.
    ///    selectionLength = The length of the character range within the alternate. This parameter must be greater than 0. This parameter
    ///                      is adjusted to the length of the smallest set of one or more segments that includes the input selection.
    ///    GetStrokesFromTextRange = Upon return, contains a pointer to the collection of strokes that corresponds to the known range of
    ///                              recognized text.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%">
    ///    An exception occurred inside the method. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl>
    ///    </td> <td width="60%"> An unspecified error occurred. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Cannot allocate stroke handler helper object.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetStrokesFromTextRange(int* selectionStart, int* selectionLength, 
                                    IInkStrokes* GetStrokesFromTextRange);
    ///Retrieves the smallest range of recognized text for which the recognizer can return an alternate that contains a
    ///known InkStrokes collection.
    ///Params:
    ///    Strokes = The collection of strokes for which to find the containing alternate.
    ///    selectionStart = The start position of the range of recognized text within the alternate object on which this method was
    ///                     called that matches the smallest alternate that contains the passed-in strokes.
    ///    selectionLength = When this method returns, contains the length of the text within the range of recognized text of the smallest
    ///                      alternate that contains the passed-in strokes.
    ///Returns:
    ///    If successful, returns S_OK; otherwise, returns an HRESULT error code.
    ///    
    HRESULT GetTextRangeFromStrokes(IInkStrokes Strokes, int* selectionStart, int* selectionLength);
    ///Retrieves a IInkRecognitionAlternates collection, which are a division of the IInkRecognitionAlternate object on
    ///which this method is called.
    ///Params:
    ///    PropertyType = Specifies a string value that identifies the property. For a list of the properties that can be used, see
    ///                   RecognitionProperty. For more information about the BSTR data type, see Using the COM Library.
    ///    AlternatesWithConstantPropertyValues = When this method returns, contains an IInkRecognitionAlternates collection which is made up of a division of
    ///                                           the alternate on which this method is called. Each IInkRecognitionAlternate object in the collection contains
    ///                                           adjacent recognition segments which have the same property value for the <i>propertyType</i> parameter.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The
    ///    recognition range is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl>
    ///    </td> <td width="60%"> An exception occurred while processing. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Cannot allocate memory to complete the operation.
    ///    </td> </tr> </table>
    ///    
    HRESULT AlternatesWithConstantPropertyValues(BSTR PropertyType, 
                                                 IInkRecognitionAlternates* AlternatesWithConstantPropertyValues);
    ///Retrieves the value of a specified property of the alternate.
    ///Params:
    ///    PropertyType = Specifies which property of the alternate to return, as one of the GUIDs from the RecognitionProperty object.
    ///                   For more information about the BSTR data type, see Using the COM Library.
    ///    PropertyValue = Upon return, contains the value of the property type as an array of bytes. this value is interpreted
    ///                    differently for each property type. <table> <tr> <th>RecognitionProperty Type </th> <th>Description </th>
    ///                    </tr> <tr> <td width="40%"><a id="ConfidenceLevel_______________"></a><a
    ///                    id="confidencelevel_______________"></a><a id="CONFIDENCELEVEL_______________"></a><dl>
    ///                    <dt><b>ConfidenceLevel </b></dt> </dl> </td> <td width="60%"> CONFIDENCE_LEVEL enumeration type. </td> </tr>
    ///                    <tr> <td width="40%"><a id="HotPoint_______________"></a><a id="hotpoint_______________"></a><a
    ///                    id="HOTPOINT_______________"></a><dl> <dt><b>HotPoint </b></dt> </dl> </td> <td width="60%"> POINT. </td>
    ///                    </tr> <tr> <td width="40%"><a id="LineMetrics_______________"></a><a id="linemetrics_______________"></a><a
    ///                    id="LINEMETRICS_______________"></a><dl> <dt><b>LineMetrics </b></dt> </dl> </td> <td width="60%">
    ///                    LATTICE_METRICS structure. </td> </tr> <tr> <td width="40%"><a id="LineNumber_______________"></a><a
    ///                    id="linenumber_______________"></a><a id="LINENUMBER_______________"></a><dl> <dt><b>LineNumber </b></dt>
    ///                    </dl> </td> <td width="60%"> ULONG. </td> </tr> <tr> <td width="40%"><a
    ///                    id="MaximumStrokeCount_______________"></a><a id="maximumstrokecount_______________"></a><a
    ///                    id="MAXIMUMSTROKECOUNT_______________"></a><dl> <dt><b>MaximumStrokeCount </b></dt> </dl> </td> <td
    ///                    width="60%"> Not used. </td> </tr> <tr> <td width="40%"><a id="PointsPerInch_______________"></a><a
    ///                    id="pointsperinch_______________"></a><a id="POINTSPERINCH_______________"></a><dl> <dt><b>PointsPerInch
    ///                    </b></dt> </dl> </td> <td width="60%"> Not used. </td> </tr> <tr> <td width="40%"><a
    ///                    id="Segmentation_______________"></a><a id="segmentation_______________"></a><a
    ///                    id="SEGMENTATION_______________"></a><dl> <dt><b>Segmentation </b></dt> </dl> </td> <td width="60%"> Not a
    ///                    value, returns TPC_E_INVALID_PROPERTY. </td> </tr> <tr> <td width="40%"><a id="S_OK_______________"></a><a
    ///                    id="s_ok_______________"></a><dl> <dt><b>S_OK </b></dt> </dl> </td> <td width="60%"> Success. </td> </tr>
    ///                    </table> For more information about the VARIANT structure, see Using the COM Library.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurred
    ///    while processing. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A parameter contained an invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>CO_E_CLASSSTRING</b></dt> </dl> </td> <td width="60%"> Invalid GUID format. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The flag is
    ///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    Cannot allocate memory to complete the operation. </td> </tr> </table>
    ///    
    HRESULT GetPropertyValue(BSTR PropertyType, VARIANT* PropertyValue);
}

///Contains the IInkRecognitionAlternate objects that represent possible word matches for segments of ink.
@GUID("286A167F-9F19-4C61-9D53-4F07BE622B84")
interface IInkRecognitionAlternates : IDispatch
{
    ///Gets the number of objects or collections contained in a collection. This property is read-only.
    HRESULT get_Count(int* Count);
    HRESULT get__NewEnum(IUnknown* _NewEnum);
    ///Gets the collection of strokes that are contained in an object or used to create an object. This property is
    ///read-only.
    HRESULT get_Strokes(IInkStrokes* Strokes);
    ///Retrieves the IInkRecognitionAlternate object at the specified index within the IInkRecognitionAlternates
    ///collection.
    ///Params:
    ///    Index = The zero-based index of the IInkRecognitionAlternate object to get.
    ///    InkRecoAlternate = When this method returns, contains a pointer to the IInkRecognitionAlternate object at the specified index
    ///                       within the IInkRecognitionAlternates collection.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An
    ///    unspecified error occurred. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>CO_E_CLASSTRING</b></dt> </dl>
    ///    </td> <td width="60%"> Invalid GUID format. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>DISP_E_TYPEMISMATCH</b></dt> </dl> </td> <td width="60%"> One of the parameters is not a valid VARIANT
    ///    type. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    Invalid argument. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td
    ///    width="60%"> Unexpected parameter or property type. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>REGDB_CLASSNOTREG</b></dt> </dl> </td> <td width="60%"> Type object not registered. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Cannot allocate memory to
    ///    complete the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td>
    ///    <td width="60%"> An exception occurred inside the method. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>TPC_E_RECOGNIZER_NOT_REGISTERED</b></dt> </dl> </td> <td width="60%"> The recognizers registry key is
    ///    corrupted or your environment does not support handwriting recognition. </td> </tr> </table>
    ///    
    HRESULT Item(int Index, IInkRecognitionAlternate* InkRecoAlternate);
}

///Represents the area that the recognizer uses in which ink can be drawn. The area is known as the recognition guide.
@GUID("D934BE07-7B84-4208-9136-83C20994E905")
interface IInkRecognizerGuide : IDispatch
{
    ///Gets or sets the invisible writing area of the recognition guide in which writing can actually take place. This
    ///property is read/write.
    HRESULT get_WritingBox(IInkRectangle* Rectangle);
    ///Gets or sets the invisible writing area of the recognition guide in which writing can actually take place. This
    ///property is read/write.
    HRESULT put_WritingBox(IInkRectangle Rectangle);
    ///Gets or sets the box that is physically drawn on the tablet's screen and in which writing takes place. This
    ///property is read/write.
    HRESULT get_DrawnBox(IInkRectangle* Rectangle);
    ///Gets or sets the box that is physically drawn on the tablet's screen and in which writing takes place. This
    ///property is read/write.
    HRESULT put_DrawnBox(IInkRectangle Rectangle);
    ///Gets or sets the number of rows in the recognition guide. This property is read/write.
    HRESULT get_Rows(int* Units);
    ///Gets or sets the number of rows in the recognition guide. This property is read/write.
    HRESULT put_Rows(int Units);
    ///Gets or sets the number of columns in the recognition guide box. This property is read/write.
    HRESULT get_Columns(int* Units);
    ///Gets or sets the number of columns in the recognition guide box. This property is read/write.
    HRESULT put_Columns(int Units);
    ///Gets or sets the midline height. The midline height is distance from the baseline to the midline, of the drawn
    ///box. This property is read/write.
    HRESULT get_Midline(int* Units);
    ///Gets or sets the midline height. The midline height is distance from the baseline to the midline, of the drawn
    ///box. This property is read/write.
    HRESULT put_Midline(int Units);
    ///Gets or sets the InkRecoGuide structure that represents the boundaries of the ink to the recognizer. This
    ///property is read/write.
    HRESULT get_GuideData(InkRecoGuide* pRecoGuide);
    ///Gets or sets the InkRecoGuide structure that represents the boundaries of the ink to the recognizer. This
    ///property is read/write.
    HRESULT put_GuideData(InkRecoGuide recoGuide);
}

///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified before
///it's commercially released. Microsoft makes no warranties, express or implied, with respect to the information
///provided here.]
@GUID("76BA3491-CB2F-406B-9961-0E0C4CDAAEF2")
interface IInkWordList : IDispatch
{
    ///Adds a single word to the InkWordList object.
    ///Params:
    ///    NewWord = The word to add to an InkWordList object. The word is not added if it already exists in the list. For more
    ///              information about the BSTR data type, see Using the COM Library.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The word already exists in the list.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Cannot
    ///    allocate memory to complete the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt>
    ///    </dl> </td> <td width="60%"> An unspecified error occurred. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid pointer. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurred
    ///    inside the method. </td> </tr> </table>
    ///    
    HRESULT AddWord(BSTR NewWord);
    ///Removes a single word from an InkWordList.
    ///Params:
    ///    RemoveWord = The word to remove from the InkWordList. For more information about the BSTR data type, see Using the COM
    ///                 Library.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Cannot allocate memory to
    ///    complete the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td
    ///    width="60%"> An unspecified error occurred. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    </dl> </td> <td width="60%"> A parameter contained an invalid pointer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurred inside the method. </td>
    ///    </tr> </table>
    ///    
    HRESULT RemoveWord(BSTR RemoveWord);
    ///Merges the specified InkWordList object into this word list.
    ///Params:
    ///    MergeWordList = The word list to merge into this word list. Words that already exist in the list are not added.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    Cannot allocate memory to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurred inside
    ///    the method. </td> </tr> </table>
    ///    
    HRESULT Merge(IInkWordList MergeWordList);
}

///Adds members to the InkWordList Class.
@GUID("14542586-11BF-4F5F-B6E7-49D0744AAB6E")
interface IInkWordList2 : IDispatch
{
    ///Adds more than one word to an InkWordList in a single operation.
    ///Params:
    ///    NewWords = A <b>BSTR</b> of <b>NULL</b> separated words terminated by a double <b>NULL</b> containing the words to add
    ///               to the InkWordList. For more information about the <b>BSTR</b> data type, see Using the COM Library.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> At least one word already exists in
    ///    the list. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    Cannot allocate memory to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contained an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%">
    ///    An exception occurred inside the method. </td> </tr> </table>
    ///    
    HRESULT AddWords(BSTR NewWords);
}

@GUID("03F8E511-43A1-11D3-8BB6-0080C7D6BAD5")
interface IInk : IDispatch
{
}

///The <b>IInkLineInfo</b> interface provides access to the display properties and recognition result list of a text ink
///object (tInk).
@GUID("9C1C5AD6-F22F-4DE4-B453-A2CC482E7C33")
interface IInkLineInfo : IUnknown
{
    ///Specifies the display properties to set on the text ink object (tInk).
    ///Params:
    ///    pim = A pointer to an INKMETRIC structure which contains the display properties to set on the text ink object.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>pim</i> parameter is
    ///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td
    ///    width="60%"> Could not complete the operation. The display properties are not changed. </td> </tr> </table>
    ///    
    HRESULT SetFormat(INKMETRIC* pim);
    ///Returns the display properties currently set on the text ink object (tInk).
    ///Params:
    ///    pim = A pointer to an INKMETRIC structure that stores the display properties of the text ink object.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>pim</i> parameter is
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetFormat(INKMETRIC* pim);
    ///Specifies the display properties to set on the text ink object (tInk), and retrieves the width of the text ink
    ///object in HIMETRIC units.
    ///Params:
    ///    pim = A pointer to an INKMETRIC structure, which contains the display properties to set on the text ink object, or
    ///          <b>NULL</b>.
    ///    pnWidth = The width of the text ink object in HIMETRIC units.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The <i>pnWidth</i> parameter is
    ///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td
    ///    width="60%"> Could not complete the operation. The display properties are not changed. </td> </tr> </table>
    ///    
    HRESULT GetInkExtent(INKMETRIC* pim, uint* pnWidth);
    ///Returns one recognition alternate from the recognition result list.
    ///Params:
    ///    nCandidateNum = Zero-based index of the alternate list entry to retrieve.
    ///    pwcRecogWord = Buffer in which to store the selected recognition alternate. If <i>pwcRecogWord</i> is <b>NULL</b>, the
    ///                   method does not attempt to retrieve the recognition alternate word.
    ///    pcwcRecogWord = Passes the length of the <i>pwcRecogWord</i> buffer in Unicode characters, and returns the number of Unicode
    ///                    characters that were copied into the buffer.
    ///    dwFlags = Not used.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The <i>nCandidateNum</i> index
    ///    is greater that the number of recognition alternates. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td width="60%"> The <i>pwcRecogWord</i> buffer is not large
    ///    enough to accept the recognition alternate. </td> </tr> </table>
    ///    
    HRESULT GetCandidate(uint nCandidateNum, const(wchar)* pwcRecogWord, uint* pcwcRecogWord, uint dwFlags);
    ///Updates one recognition <i>alternate</i> in the recognition result list, either by replacing an existing
    ///alternate, or by adding an alternate to the list.
    ///Params:
    ///    nCandidateNum = Zero based index of the alternate list entry to set.
    ///    strRecogWord = Pointer to the new alternate text.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The <i>nCandidateNum</i> index
    ///    is out of range. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td
    ///    width="60%"> Could not complete the operation. The recognition result list is not changed. </td> </tr>
    ///    </table>
    ///    
    HRESULT SetCandidate(uint nCandidateNum, const(wchar)* strRecogWord);
    ///Reserved.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> The method is not implemented.
    ///    </td> </tr> </table>
    ///    
    HRESULT Recognize();
}

@GUID("B4563688-98EB-4646-B279-44DA14D45748")
interface ISketchInk : IDispatch
{
}

///Represents the ability to analyze the layout of a collection of ink strokes and divide them into text and graphics.
@GUID("5DE00405-F9A4-4651-B0C5-C317DEFD58B9")
interface IInkDivider : IDispatch
{
    ///Gets or sets the InkStrokes collection on which the InkDivider object performs layout analysis. This property is
    ///read/write.
    HRESULT get_Strokes(IInkStrokes* Strokes);
    ///Gets or sets the InkStrokes collection on which the InkDivider object performs layout analysis. This property is
    ///read/write.
    HRESULT putref_Strokes(IInkStrokes Strokes);
    ///Gets or sets the InkRecognizerContext object that the InkDivider object uses for layout analysis. This property
    ///is read/write.
    HRESULT get_RecognizerContext(IInkRecognizerContext* RecognizerContext);
    ///Gets or sets the InkRecognizerContext object that the InkDivider object uses for layout analysis. This property
    ///is read/write.
    HRESULT putref_RecognizerContext(IInkRecognizerContext RecognizerContext);
    ///Gets or sets the expected handwriting height, in HIMETRIC units. This property is read/write.
    HRESULT get_LineHeight(int* LineHeight);
    ///Gets or sets the expected handwriting height, in HIMETRIC units. This property is read/write.
    HRESULT put_LineHeight(int LineHeight);
    ///Returns a IInkDivisionResult object that contains the results of the layout analysis of strokes in the InkDivider
    ///object.
    ///Params:
    ///    InkDivisionResult = When this method returns, contains a pointer to an IInkDivisionResult object that contains structural
    ///                        information about the strokes in the InkDivider object.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contains an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%">
    ///    Unexpected parameter or property type. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl>
    ///    </td> <td width="60%"> An unspecified error occurred. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Unable to allocate memory to complete the
    ///    operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td
    ///    width="60%"> An exception occurred inside the method. </td> </tr> </table>
    ///    
    HRESULT Divide(IInkDivisionResult* InkDivisionResult);
}

///Represents the layout analysis of the collection of strokes contained by the InkDivider object.
@GUID("2DBEC0A7-74C7-4B38-81EB-AA8EF0C24900")
interface IInkDivisionResult : IDispatch
{
    ///Gets the collection of strokes that are contained in an object or used to create an object. This property is
    ///read-only.
    HRESULT get_Strokes(IInkStrokes* Strokes);
    ///Gets the requested structural units of the analysis results for an IInkDivisionUnits collection.
    ///Params:
    ///    divisionType = The InkDivisionType enumeration value that indicates the structural units to return.
    ///    InkDivisionUnits = A pointer to the IInkDivisionUnits collection that contains the requested structural units of the analysis
    ///                       results.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contains an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> A
    ///    parameter contains an invalid value. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt>
    ///    </dl> </td> <td width="60%"> Unexpected parameter or property type. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurred inside the method. </td>
    ///    </tr> </table>
    ///    
    HRESULT ResultByType(InkDivisionType divisionType, IInkDivisionUnits* InkDivisionUnits);
}

///Represents a single structural element within an IInkDivisionResult object.
@GUID("85AEE342-48B0-4244-9DD5-1ED435410FAB")
interface IInkDivisionUnit : IDispatch
{
    ///Gets the collection of strokes that are contained in an object or used to create an object. This property is
    ///read-only.
    HRESULT get_Strokes(IInkStrokes* Strokes);
    ///Gets the type of structural unit the IInkDivisionUnit object represents within the analysis results. This
    ///property is read-only.
    HRESULT get_DivisionType(InkDivisionType* divisionType);
    HRESULT get_RecognizedString(BSTR* RecoString);
    ///Gets the transformation matrix that the IInkDivisionUnit object uses to rotate the strokes to horizontal. This
    ///property is read-only.
    HRESULT get_RotationTransform(IInkTransform* RotationTransform);
}

///Contains a collection of IInkDivisionUnit objects that are contained in an IInkDivisionResult object.
@GUID("1BB5DDC2-31CC-4135-AB82-2C66C9F00C41")
interface IInkDivisionUnits : IDispatch
{
    ///Gets the number of objects or collections contained in a collection. This property is read-only.
    HRESULT get_Count(int* Count);
    HRESULT get__NewEnum(IUnknown* _NewEnum);
    ///Retrieves the IInkDivisionUnit object at the specified index within the IInkDivisionUnits collection.
    ///Params:
    ///    Index = The zero-based index of the IInkDivisionUnit object to get.
    ///    InkDivisionUnit = When this method returns, contains a pointer to the IInkDivisionUnit object at the specified index within the
    ///                      IInkDivisionUnits collection.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter contains an invalid
    ///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> A
    ///    parameter contains an invalid value. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt>
    ///    </dl> </td> <td width="60%"> Unexpected parameter or property type. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurred inside the method. </td>
    ///    </tr> </table>
    ///    
    HRESULT Item(int Index, IInkDivisionUnit* InkDivisionUnit);
}

///Enables adding in-place pen input to your applications. **IPenInputPanel** is available for use in the operating
///systems specified in the Requirements section. It may be altered or unavailable in subsequent versions. Instead, use
///[IInputPanelConfiguration
///interface](../inputpanelconfiguration/nn-inputpanelconfiguration-iinputpanelconfiguration.md).
@GUID("FA7A4083-5747-4040-A182-0B0E9FD4FAC7")
interface IPenInputPanel : IDispatch
{
    ///Deprecated. The PenInputPanel has been replaced by the Text Input Panel (TIP). Gets a a value that indicates
    ///whether the PenInputPanel object is currently processing ink. This property is read-only.
    HRESULT get_Busy(short* Busy);
    ///Deprecated. The PenInputPanel has been replaced by the Text Input Panel (TIP). Gets or sets the string name of
    ///the factoid used by the PenInputPanel object. This property is read/write.
    HRESULT get_Factoid(BSTR* Factoid);
    ///Deprecated. The PenInputPanel has been replaced by the Text Input Panel (TIP). Gets or sets the string name of
    ///the factoid used by the PenInputPanel object. This property is read/write.
    HRESULT put_Factoid(BSTR Factoid);
    ///Deprecated. The PenInputPanel has been replaced by the Text Input Panel (TIP). Sets or gets the window handle of
    ///the object that the PenInputPanel object is attached to. This property is read/write.
    HRESULT get_AttachedEditWindow(int* AttachedEditWindow);
    ///Deprecated. The PenInputPanel has been replaced by the Text Input Panel (TIP). Sets or gets the window handle of
    ///the object that the PenInputPanel object is attached to. This property is read/write.
    HRESULT put_AttachedEditWindow(int AttachedEditWindow);
    ///Deprecated. The PenInputPanel has been replaced by the Text Input Panel (TIP). Gets or sets which panel type is
    ///currently being used for input within the PenInputPanel object. This property is read/write.
    HRESULT get_CurrentPanel(PanelType* CurrentPanel);
    ///Deprecated. The PenInputPanel has been replaced by the Text Input Panel (TIP). Gets or sets which panel type is
    ///currently being used for input within the PenInputPanel object. This property is read/write.
    HRESULT put_CurrentPanel(PanelType CurrentPanel);
    ///Deprecated. The PenInputPanel has been replaced by the Text Input Panel (TIP). Gets or sets the default panel
    ///type used for input within the PenInputPanel object. This property is read/write.
    HRESULT get_DefaultPanel(PanelType* pDefaultPanel);
    ///Deprecated. The PenInputPanel has been replaced by the Text Input Panel (TIP). Gets or sets the default panel
    ///type used for input within the PenInputPanel object. This property is read/write.
    HRESULT put_DefaultPanel(PanelType DefaultPanel);
    ///Deprecated. The PenInputPanel has been replaced by the Text Input Panel (TIP). Gets or sets a value that
    ///indicates whether the PenInputPanel object is visible. This property is read/write.
    HRESULT get_Visible(short* Visible);
    HRESULT put_Visible(short Visible);
    ///Deprecated. The PenInputPanel has been replaced by the Text Input Panel (TIP). Gets the vertical, or y-axis,
    ///location of the top edge of the PenInputPanel object, in screen coordinates. This property is read-only.
    HRESULT get_Top(int* Top);
    ///Deprecated. The PenInputPanel has been replaced by the Text Input Panel (TIP). Gets the horizontal, or x-axis,
    ///location of the left edge of the PenInputPanel object, in screen coordinates. This property is read-only.
    HRESULT get_Left(int* Left);
    ///Deprecated. The PenInputPanel has been replaced by the Text Input Panel (TIP). Gets the width of the pen input
    ///panel in client coordinates. This property is read-only.
    HRESULT get_Width(int* Width);
    ///Deprecated. The PenInputPanel has been replaced by the Text Input Panel (TIP). Gets the height of the pen input
    ///panel in client coordinates. This property is read-only.
    HRESULT get_Height(int* Height);
    ///Deprecated. The PenInputPanel has been replaced by the Text Input Panel (TIP). Gets or sets the offset between
    ///the closest horizontal edge of the pen input panel and the closest horizontal edge of the control to which it is
    ///attached. This property is read/write.
    HRESULT get_VerticalOffset(int* VerticalOffset);
    ///Deprecated. The PenInputPanel has been replaced by the Text Input Panel (TIP). Gets or sets the offset between
    ///the closest horizontal edge of the pen input panel and the closest horizontal edge of the control to which it is
    ///attached. This property is read/write.
    HRESULT put_VerticalOffset(int VerticalOffset);
    ///Deprecated. The PenInputPanel has been replaced by the Text Input Panel (TIP). Gets or sets the offset between
    ///the left edge of the pen input panel and the left edge of the control to which it is attached. This property is
    ///read/write.
    HRESULT get_HorizontalOffset(int* HorizontalOffset);
    ///Deprecated. The PenInputPanel has been replaced by the Text Input Panel (TIP). Gets or sets the offset between
    ///the left edge of the pen input panel and the left edge of the control to which it is attached. This property is
    ///read/write.
    HRESULT put_HorizontalOffset(int HorizontalOffset);
    ///Deprecated. The PenInputPanel has been replaced by the Text Input Panel (TIP). Gets or sets a value that
    ///indicates whether the pen input panel appears when focus is set on the attached control by using the pen. This
    ///property is read/write.
    HRESULT get_AutoShow(short* pAutoShow);
    ///Deprecated. The PenInputPanel has been replaced by the Text Input Panel (TIP). Gets or sets a value that
    ///indicates whether the pen input panel appears when focus is set on the attached control by using the pen. This
    ///property is read/write.
    HRESULT put_AutoShow(short AutoShow);
    ///Deprecated. The PenInputPanel has been replaced by the Text Input Panel (TIP). Sets the position of the
    ///PenInputPanel object to a static screen position.
    ///Params:
    ///    Left = The new horizontal position in screen coordinates.
    ///    Top = The new vertical position in screen coordinates.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> Unexpected parameter or property
    ///    type. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An
    ///    unspecified error occurred. </td> </tr> </table>
    ///    
    HRESULT MoveTo(int Left, int Top);
    ///Deprecated. The PenInputPanel has been replaced by the Text Input Panel (TIP). Sends collected ink to the
    ///recognizer and posts the recognition result.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> Unexpected parameter or property
    ///    type. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An
    ///    unspecified error occurred. </td> </tr> </table>
    ///    
    HRESULT CommitPendingInput();
    ///<p class="CCE_Message">[<b>Refresh</b> is no longer available for use as of Windows XP Tablet PC Edition.
    ///Instead, use Text Input Panel (TIP).] Updates and restores the PenInputPanel properties based on Tablet PC Input
    ///Panel settings, automatically positions the pen input panel, and sets the user interface to the default panel.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> Unexpected parameter or property
    ///    type. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An
    ///    unspecified error occurred. </td> </tr> </table>
    ///    
    HRESULT Refresh();
    ///<p class="CCE_Message">[ The PenInputPanel has been replaced by the Text Input Panel (TIP).] Deprecated. Gets or
    ///sets a Boolean value that indicates whether the PenInputPanel object attempts to send text to the attached
    ///control through the Text Services Framework (TSF) and enables the use of the <b>correction</b> user interface.
    ///Params:
    ///    Enable = <b>TRUE</b> if the PenInputPanel object should attempt to send text to the attached control using TSF and
    ///             that the correction user interface should be enabled; otherwise <b>FALSE</b>. The default value is
    ///             <b>TRUE</b>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> Unexpected parameter or property
    ///    type. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td width="60%"> TSF
    ///    interfaces are not exposed on the attached control. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td> </tr> </table>
    ///    
    HRESULT EnableTsf(short Enable);
}

@GUID("B7E489DA-3719-439F-848F-E7ACBD820F17")
interface _IPenInputPanelEvents : IDispatch
{
}

///Used by the application's custom text entry code to insert the text into both the text field and the Text Services
///backing-store.
@GUID("56FDEA97-ECD6-43E7-AA3A-816BE7785860")
interface IHandwrittenTextInsertion : IUnknown
{
    ///Insert recognition results array.
    ///Params:
    ///    psaAlternates = A two-dimensional array of strings, where each entry in the first array is a list of alternates for a single
    ///                    word. The first entry in the sub arrays of alternates is the text to insert (the top alternate).
    ///    locale = A specific culture for the input language of the recognizer used to produce alternates.
    ///    fAlternateContainsAutoSpacingInformation = Specifies whether the recognized text is generated with auto-spacing enabled. When <b>FALSE</b>, a space at
    ///                                               the start/end of the lattice will always be inserted. When <b>TRUE</b>, a space exists, and is added where
    ///                                               necessary. If no space exists, a space is consumed.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT InsertRecognitionResultsArray(SAFEARRAY* psaAlternates, uint locale, 
                                          BOOL fAlternateContainsAutoSpacingInformation);
    ///Inserts recognition results.
    ///Params:
    ///    pIInkRecoResult = The IInkRecognitionResult for the insertion which contains the recognition results and the collection of ink
    ///                      strokes for the insertion.
    ///    locale = The locale identifier of a specific culture for the input language of the recognizer used to produce
    ///             alternates.
    ///    fAlternateContainsAutoSpacingInformation = Specifies whether the recognized text was generated with auto-spacing enabled on the recognized. <b>TRUE</b>
    ///                                               if auto-spacing was enabled; otherwise, <b>FALSE</b>.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT InsertInkRecognitionResult(IInkRecognitionResult pIInkRecoResult, uint locale, 
                                       BOOL fAlternateContainsAutoSpacingInformation);
}

///Defines methods that handle the ITextInputPanel Interface events.
@GUID("27560408-8E64-4FE1-804E-421201584B31")
interface ITextInputPanelEventSink : IUnknown
{
    ///Occurs when the In-Place state is about to change.
    ///Params:
    ///    oldInPlaceState = The current state, as defined by the InPlaceState Enumeration.
    ///    newInPlaceState = The new state that the Input Panel is changing to, as defined by the InPlaceState Enumeration.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> </table>
    ///    
    HRESULT InPlaceStateChanging(InPlaceState oldInPlaceState, InPlaceState newInPlaceState);
    ///Occurs when the In-Place state has changed.
    ///Params:
    ///    oldInPlaceState = The current state, as defined by the InPlaceState Enumeration.
    ///    newInPlaceState = The new state that the Input Panel has changed to, as defined by the InPlaceState Enumeration.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> </table>
    ///    
    HRESULT InPlaceStateChanged(InPlaceState oldInPlaceState, InPlaceState newInPlaceState);
    ///Occurs when the in-place Input Panel size is about to change due to a user resize, auto growth, or an input area
    ///change.
    ///Params:
    ///    oldBoundingRectangle = The bounding rectangle that represents the current size of the Input Panel.
    ///    newBoundingRectangle = The bounding rectangle that represents the new size of the Input Panel.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> </table>
    ///    
    HRESULT InPlaceSizeChanging(RECT oldBoundingRectangle, RECT newBoundingRectangle);
    ///Occurs when the in-place Input Panel size has changed due to a user resize, auto growth, or an input area change.
    ///Params:
    ///    oldBoundingRectangle = The bounding rectangle that represents the previous size of the Input Panel.
    ///    newBoundingRectangle = The bounding rectangle that represents the current size of the Input Panel.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> </table>
    ///    
    HRESULT InPlaceSizeChanged(RECT oldBoundingRectangle, RECT newBoundingRectangle);
    ///Occurs when the input area is about to change on the Tablet PC Input Panel.
    ///Params:
    ///    oldInputArea = The current input area as defined by the PanelInputArea Enumeration.
    ///    newInputArea = The input area the Input Panel is changing to as defined by the PanelInputArea Enumeration.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> </table>
    ///    
    HRESULT InputAreaChanging(PanelInputArea oldInputArea, PanelInputArea newInputArea);
    ///Occurs when the input area has changed on the Tablet PC Input Panel.
    ///Params:
    ///    oldInputArea = The previous input area as defined by the PanelInputArea Enumeration.
    ///    newInputArea = The current input area as defined by the PanelInputArea Enumeration.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> </table>
    ///    
    HRESULT InputAreaChanged(PanelInputArea oldInputArea, PanelInputArea newInputArea);
    ///Occurs when the correction comb on the Tablet PC Input Panel is about to change modes.
    ///Params:
    ///    oldCorrectionMode = The current correction mode, as defined by the CorrectionMode Enumeration.
    ///    newCorrectionMode = The correction mode the Input Panel is changing to, as defined by the CorrectionMode Enumeration.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> </table>
    ///    
    HRESULT CorrectionModeChanging(CorrectionMode oldCorrectionMode, CorrectionMode newCorrectionMode);
    ///Occurs when the correction comb on the Tablet PC Input Panel has changed modes.
    ///Params:
    ///    oldCorrectionMode = The previous correction mode, as defined by the CorrectionMode Enumeration.
    ///    newCorrectionMode = The current correction mode, as defined by the CorrectionMode Enumeration.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> </table>
    ///    
    HRESULT CorrectionModeChanged(CorrectionMode oldCorrectionMode, CorrectionMode newCorrectionMode);
    ///Occurs when the Tablet PC Input Panel is about to switch between visible and invisible.
    ///Params:
    ///    oldVisible = <b>TRUE</b> if the Input Panel is changing from visible to invisible, otherwise <b>FALSE</b>.
    ///    newVisible = <b>TRUE</b> if the Input Panel is changing from invisible to visible, otherwise <b>FALSE</b>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> </table>
    ///    
    HRESULT InPlaceVisibilityChanging(BOOL oldVisible, BOOL newVisible);
    ///Occurs when the Tablet PC Input Panel has switched between visible and invisible.
    ///Params:
    ///    oldVisible = <b>TRUE</b> if the Input Panel has changed from visible to invisible, otherwise <b>FALSE</b>.
    ///    newVisible = <b>TRUE</b> if the Input Panel has changed from invisible to visible, otherwise <b>FALSE</b>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> </table>
    ///    
    HRESULT InPlaceVisibilityChanged(BOOL oldVisible, BOOL newVisible);
    ///Occurs when the Tablet PC Input Panel is about to insert text into the control with input focus. Provides access
    ///to the ink the user entered in the Input Panel.
    ///Params:
    ///    Ink = Array of Ink objects in the Input Panel.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> </table>
    ///    
    HRESULT TextInserting(SAFEARRAY* Ink);
    ///Occurs when the Tablet PC Input Panel has inserted text into the control with input focus. Provides access to the
    ///ink the user entered in the Input Panel.
    ///Params:
    ///    Ink = Array of Ink objects in the Input Panel.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> </table>
    ///    
    HRESULT TextInserted(SAFEARRAY* Ink);
}

///**ITextInputPanel** is available for use in the operating systems specified in the Requirements section. It may be
///altered or unavailable in subsequent versions. Instead, use [IInputPanelConfiguration
///interface](../inputpanelconfiguration/nn-inputpanelconfiguration-iinputpanelconfiguration.md). Provides control of
///appearance and behavior of the Tablet PC Input Panel.
@GUID("6B6A65A5-6AF3-46C2-B6EA-56CD1F80DF71")
interface ITextInputPanel : IUnknown
{
    ///<p class="CCE_Message">[ITextInputPanel is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use
    ///IInputPanelConfiguration. ] Gets or sets the window handle of the object to which the ITextInputPanel object is
    ///attached. This property is read/write.
    HRESULT get_AttachedEditWindow(HWND* AttachedEditWindow);
    ///<p class="CCE_Message">[ITextInputPanel is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use
    ///IInputPanelConfiguration. ] Gets or sets the window handle of the object to which the ITextInputPanel object is
    ///attached. This property is read/write.
    HRESULT put_AttachedEditWindow(HWND AttachedEditWindow);
    ///<p class="CCE_Message">[ITextInputPanel is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use
    ///IInputPanelConfiguration. ] Gets the positioning of the Tablet PC Input Panel as specified by the InteractionMode
    ///Enumeration. This property is read-only.
    HRESULT get_CurrentInteractionMode(InteractionMode* CurrentInteractionMode);
    ///<p class="CCE_Message">[ITextInputPanel is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use
    ///IInputPanelConfiguration. ] Gets or sets the default in-place state as specified by the InPlaceState Enumeration.
    ///This property is read/write.
    HRESULT get_DefaultInPlaceState(InPlaceState* State);
    ///<p class="CCE_Message">[ITextInputPanel is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use
    ///IInputPanelConfiguration. ] Gets or sets the default in-place state as specified by the InPlaceState Enumeration.
    ///This property is read/write.
    HRESULT put_DefaultInPlaceState(InPlaceState State);
    ///<p class="CCE_Message">[ITextInputPanel is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use
    ///IInputPanelConfiguration. ] Gets the current in-place state as specified by the InPlaceState Enumeration. This
    ///property is read-only.
    HRESULT get_CurrentInPlaceState(InPlaceState* State);
    ///<p class="CCE_Message">[ITextInputPanel is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use
    ///IInputPanelConfiguration. ] Gets or sets the default input area as specified by the PanelInputArea Enumeration.
    ///This property is read/write.
    HRESULT get_DefaultInputArea(PanelInputArea* Area);
    ///<p class="CCE_Message">[ITextInputPanel is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use
    ///IInputPanelConfiguration. ] Gets or sets the default input area as specified by the PanelInputArea Enumeration.
    ///This property is read/write.
    HRESULT put_DefaultInputArea(PanelInputArea Area);
    ///<p class="CCE_Message">[ITextInputPanel is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use
    ///IInputPanelConfiguration. ] Gets the current input area as specified by the PanelInputArea Enumeration. This
    ///property is read-only.
    HRESULT get_CurrentInputArea(PanelInputArea* Area);
    ///<p class="CCE_Message">[ITextInputPanel is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use
    ///IInputPanelConfiguration. ] Gets the current correction comb mode as specified by the CorrectionMode Enumeration.
    ///This property is read-only.
    HRESULT get_CurrentCorrectionMode(CorrectionMode* Mode);
    ///<p class="CCE_Message">[ITextInputPanel is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use
    ///IInputPanelConfiguration. ] Gets or sets the preferred direction of the in-place Input Panel relative to the text
    ///entry field. This property is read/write.
    HRESULT get_PreferredInPlaceDirection(InPlaceDirection* Direction);
    ///<p class="CCE_Message">[ITextInputPanel is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use
    ///IInputPanelConfiguration. ] Gets or sets the preferred direction of the in-place Input Panel relative to the text
    ///entry field. This property is read/write.
    HRESULT put_PreferredInPlaceDirection(InPlaceDirection Direction);
    ///<p class="CCE_Message">[ITextInputPanel is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use
    ///IInputPanelConfiguration. ] Gets or sets a value that indicates whether the correction comb on the Tablet PC
    ///Input Panel is automatically expanded. This property is read/write.
    HRESULT get_ExpandPostInsertionCorrection(int* Expand);
    ///<p class="CCE_Message">[ITextInputPanel is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use
    ///IInputPanelConfiguration. ] Gets or sets a value that indicates whether the correction comb on the Tablet PC
    ///Input Panel is automatically expanded. This property is read/write.
    HRESULT put_ExpandPostInsertionCorrection(BOOL Expand);
    ///<p class="CCE_Message">[ITextInputPanel is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use
    ///IInputPanelConfiguration. ] Gets or sets a value that indicates whether the Tablet PC Input Panel is displayed
    ///automatically when the window to which it is attached gets focus. This property is read/write.
    HRESULT get_InPlaceVisibleOnFocus(int* Visible);
    ///<p class="CCE_Message">[ITextInputPanel is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use
    ///IInputPanelConfiguration. ] Gets or sets a value that indicates whether the Tablet PC Input Panel is displayed
    ///automatically when the window to which it is attached gets focus. This property is read/write.
    HRESULT put_InPlaceVisibleOnFocus(BOOL Visible);
    ///<p class="CCE_Message">[ITextInputPanel is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use
    ///IInputPanelConfiguration. ] Gets the bounding rectangle for Tablet PC Input Panel. This property is read-only.
    HRESULT get_InPlaceBoundingRectangle(RECT* BoundingRectangle);
    ///<p class="CCE_Message">[ITextInputPanel is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use
    ///IInputPanelConfiguration. ] Gets the height of the Post-Insertion correction comb when it is positioned above
    ///Input Panel. This property is read-only.
    HRESULT get_PopUpCorrectionHeight(int* Height);
    ///<p class="CCE_Message">[ITextInputPanel is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use
    ///IInputPanelConfiguration. ] Gets the height of the Post-Insertion correction comb when it is positioned below
    ///Input Panel. This property is read-only.
    HRESULT get_PopDownCorrectionHeight(int* Height);
    ///<p class="CCE_Message">[ITextInputPanel is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use
    ///IInputPanelConfiguration. ] Sends collected ink to the recognizer and posts the recognition result.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> Unexpected parameter or property
    ///    type. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An
    ///    unspecified error occurred. </td> </tr> </table>
    ///    
    HRESULT CommitPendingInput();
    ///<p class="CCE_Message">[ITextInputPanel is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use
    ///IInputPanelConfiguration. ] Shows or hides the Tablet PC Input Panel.
    ///Params:
    ///    Visible = <b>TRUE</b> to show the Input Panel; <b>FALSE</b> to hide the Input Panel.
    ///Returns:
    ///    If the Input Panel can display, the method returns <b>S_OK</b>, otherwise <b>E_FAIL</b>. See the Remarks
    ///    section for more information about when the Input Panel can and cannot be affected by the
    ///    <b>ITextInputPanel::SetInPlaceVisibility Method</b>. <table> <tr> <th>Return code</th> <th>Description</th>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
    ///    </td> </tr> </table>
    ///    
    HRESULT SetInPlaceVisibility(BOOL Visible);
    ///<p class="CCE_Message">[ITextInputPanel is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use
    ///IInputPanelConfiguration. ] Explicitly positions the Tablet PC Input Panel in screen coordinates.
    ///Params:
    ///    xPosition = The horizontal x-coordinate for the top left corner of the Input Panel, with no correction comb visible.
    ///    yPosition = The vertical y-coordinate for the top left corner of the Input Panel, with no correction comb visible.
    ///    position = The direction the post insertion correction comb should pop up in, as defined by the CorrectionPosition
    ///               enumeration.
    ///Returns:
    ///    Returns <b>false</b> when the Input Panel is open (docked or floating) and cannot be moved; otherwise it
    ///    returns <b>true</b>. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td> </tr> </table>
    ///    
    HRESULT SetInPlacePosition(int xPosition, int yPosition, CorrectionPosition position);
    ///<p class="CCE_Message">[ITextInputPanel is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use
    ///IInputPanelConfiguration. ] Explicitly positions the Tablet PC Input Panel hover target in screen coordinates.
    ///Params:
    ///    xPosition = The horizontal x-coordinate for the top left corner of the hover target, with no correction comb visible.
    ///    yPosition = The vertical y-coordinate for the top left corner of the hover target, with no correction comb visible.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> </table>
    ///    
    HRESULT SetInPlaceHoverTargetPosition(int xPosition, int yPosition);
    ///<p class="CCE_Message">[ITextInputPanel is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use
    ///IInputPanelConfiguration. ] Establishes an advisory connection between the Tablet PC Input Panel and the
    ///specified sink object.
    ///Params:
    ///    EventSink = Reference to the sink object to receive event notifications from the Input Panel.
    ///    EventMask = A bitwise value of the EventMask Enumeration, indicating the events of interest.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> </table>
    ///    
    HRESULT Advise(ITextInputPanelEventSink EventSink, uint EventMask);
    ///<p class="CCE_Message">[ITextInputPanel is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use
    ///IInputPanelConfiguration. ] Terminates an advisory connection previously established through
    ///ITextInputPanel::Advise Method.
    ///Params:
    ///    EventSink = Reference to the sink object currently receiving event notifications from the Input Panel.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td>
    ///    </tr> </table>
    ///    
    HRESULT Unadvise(ITextInputPanelEventSink EventSink);
}

@GUID("4AF81847-FDC4-4FC3-AD0B-422479C1B935")
interface IInputPanelWindowHandle : IUnknown
{
    HRESULT get_AttachedEditWindow32(int* AttachedEditWindow);
    HRESULT put_AttachedEditWindow32(int AttachedEditWindow);
    HRESULT get_AttachedEditWindow64(long* AttachedEditWindow);
    HRESULT put_AttachedEditWindow64(long AttachedEditWindow);
}

///Provides a method to determine if the Text Input Panel is currently running.
@GUID("9F424568-1920-48CC-9811-A993CBF5ADBA")
interface ITextInputPanelRunInfo : IUnknown
{
    ///Indicates if the Tablet PC Input Panel is running at the time the method is called.
    ///Params:
    ///    pfRunning = <b>TRUE</b> if the Input Panel was running, otherwise <b>FALSE</b>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The <i>pfRunning</i> parameter has
    ///    been set appropriately. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> The <i>pfRunning</i> parameter was <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT IsTipRunning(int* pfRunning);
}

///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified before
///it's commercially released. Microsoft makes no warranties, express or implied, with respect to the information
///provided here.]
@GUID("F2127A19-FBFB-4AED-8464-3F36D78CFEFB")
interface IInkEdit : IDispatch
{
    ///Gets a value that specifies whether the InkEdit control is idle, collecting ink, or recognizing ink. This
    ///property is read-only.
    HRESULT get_Status(InkEditStatus* pStatus);
    ///Gets or sets a value that indicates whether the mouse can be used as an input device. This property is
    ///read/write.
    HRESULT get_UseMouseForInput(short* pVal);
    ///Gets or sets a value that indicates whether the mouse can be used as an input device. This property is
    ///read/write.
    HRESULT put_UseMouseForInput(short newVal);
    ///Gets or sets a value that specifies whether ink collection is disabled, ink is collected, or ink and gestures are
    ///collected. This property is read/write.
    HRESULT get_InkMode(InkMode* pVal);
    ///Gets or sets a value that specifies whether ink collection is disabled, ink is collected, or ink and gestures are
    ///collected. This property is read/write.
    HRESULT put_InkMode(InkMode newVal);
    ///Gets or sets a value that specifies how ink is inserted onto the InkEdit control, either as text or as ink. This
    ///property is read/write.
    HRESULT get_InkInsertMode(InkInsertMode* pVal);
    ///Gets or sets a value that specifies how ink is inserted onto the InkEdit control, either as text or as ink. This
    ///property is read/write.
    HRESULT put_InkInsertMode(InkInsertMode newVal);
    ///Gets or sets the drawing attributes for ink that is yet to be drawn on the InkEdit control. This property is
    ///read/write.
    HRESULT get_DrawingAttributes(IInkDrawingAttributes* pVal);
    ///Gets or sets the drawing attributes for ink that is yet to be drawn on the InkEdit control. This property is
    ///read/write.
    HRESULT putref_DrawingAttributes(IInkDrawingAttributes newVal);
    ///Gets or sets the length of time, in milliseconds, between the last IInkStrokeDisp object collected and the
    ///beginning of text recognition. This property is read/write.
    HRESULT get_RecognitionTimeout(int* pVal);
    ///Gets or sets the length of time, in milliseconds, between the last IInkStrokeDisp object collected and the
    ///beginning of text recognition. This property is read/write.
    HRESULT put_RecognitionTimeout(int newVal);
    ///Gets or sets the IInkRecognizer object to use for recognition. This property is read/write.
    HRESULT get_Recognizer(IInkRecognizer* pVal);
    HRESULT putref_Recognizer(IInkRecognizer newVal);
    ///Gets or sets the Factoid constant that a IInkRecognizer object uses to constrain its search for the recognition
    ///result. This property is read/write.
    HRESULT get_Factoid(BSTR* pVal);
    ///Gets or sets the Factoid constant that a IInkRecognizer object uses to constrain its search for the recognition
    ///result. This property is read/write.
    HRESULT put_Factoid(BSTR newVal);
    ///Gets or sets the array of embedded InkDisp objects (if displayed as ink) in the current selection. This property
    ///is read/write.
    HRESULT get_SelInks(VARIANT* pSelInk);
    ///Gets or sets the array of embedded InkDisp objects (if displayed as ink) in the current selection. This property
    ///is read/write.
    HRESULT put_SelInks(VARIANT SelInk);
    ///Gets or sets a value that allows for toggling the appearance of the selection between ink and text. This property
    ///is read/write.
    HRESULT get_SelInksDisplayMode(InkDisplayMode* pInkDisplayMode);
    ///Gets or sets a value that allows for toggling the appearance of the selection between ink and text. This property
    ///is read/write.
    HRESULT put_SelInksDisplayMode(InkDisplayMode InkDisplayMode);
    ///Performs recognition on an InkStrokes collection and returns recognition results.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurred inside
    ///    the method. </td> </tr> </table>
    ///    
    HRESULT Recognize();
    ///Indicates whether the InkEdit control is interested in a particular application gesture.
    ///Params:
    ///    Gesture = The gesture that you want the status of.
    ///    pListen = <b>VARIANT_TRUE</b> if the InkEdit control has interest in the gesture and the Gesture event of the InkEdit
    ///              control fires when the gesture is recognized. <b>VARIANT_FALSE</b> if the InkEdit control has no interest in
    ///              the gesture.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Input parameter was incorrect. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_INVALID_MODE</b></dt> </dl> </td> <td width="60%"> Collection
    ///    mode must be in gesture-mode. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl>
    ///    </td> <td width="60%"> Cannot allocate memory to perform action. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INK_EXCEPTION</b></dt> </dl> </td> <td width="60%"> An exception occurred. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The flag is invalid. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetGestureStatus(InkApplicationGesture Gesture, short* pListen);
    ///Modifies the interest of the InkEdit control in a known application gesture.
    ///Params:
    ///    Gesture = The IInkGesture object that you want the status of.
    ///    Listen = <b>VARIANT_TRUE</b> to indicate that the InkEdit control uses the application gesture; otherwise,
    ///             <b>VARIANT_FALSE</b>.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The input parameter was incorrect.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_INVALID_MODE</b></dt> </dl> </td> <td width="60%">
    ///    InkEdit status must be IES_Idle. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INK_EXCEPTION</b></dt> </dl>
    ///    </td> <td width="60%"> An exception occurred. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>TPC_S_TRUNCATED</b></dt> </dl> </td> <td width="60%"> Unsupported gesture. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The flag is invalid. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Cannot allocate memory
    ///    operation. </td> </tr> </table>
    ///    
    HRESULT SetGestureStatus(InkApplicationGesture Gesture, short Listen);
    ///Gets or sets the background color for the InkEdit control. This property is read/write.
    HRESULT put_BackColor(uint clr);
    ///Gets or sets the background color for the InkEdit control. This property is read/write.
    HRESULT get_BackColor(uint* pclr);
    ///Gets or sets a value that determines the appearance of the InkEdit control - whether it is flat (painted with no
    ///visual effects) or 3D (painted with three-dimensional effects). This property is read/write.
    HRESULT get_Appearance(AppearanceConstants* pAppearance);
    ///Gets or sets a value that determines the appearance of the InkEdit control - whether it is flat (painted with no
    ///visual effects) or 3D (painted with three-dimensional effects). This property is read/write.
    HRESULT put_Appearance(AppearanceConstants pAppearance);
    ///Gets or sets a value that determines whether the InkEdit control has a border. This property is read/write.
    HRESULT get_BorderStyle(BorderStyleConstants* pBorderStyle);
    ///Gets or sets a value that determines whether the InkEdit control has a border. This property is read/write.
    HRESULT put_BorderStyle(BorderStyleConstants pBorderStyle);
    ///Gets a handle to the InkEdit control. This property is read-only.
    HRESULT get_Hwnd(uint* pohHwnd);
    ///Gets or sets a Font object. This property is read/write.
    HRESULT get_Font(IFontDisp* ppFont);
    HRESULT putref_Font(IFontDisp ppFont);
    ///Gets or sets the current text in the InkEdit control. This property is read/write.
    HRESULT get_Text(BSTR* pbstrText);
    ///Gets or sets the current text in the InkEdit control. This property is read/write.
    HRESULT put_Text(BSTR pbstrText);
    ///Gets or sets the custom mouse icon for the InkEdit control. This property is read/write.
    HRESULT get_MouseIcon(IPictureDisp* MouseIcon);
    ///Gets or sets the custom mouse icon for the InkEdit control. This property is read/write.
    HRESULT put_MouseIcon(IPictureDisp MouseIcon);
    HRESULT putref_MouseIcon(IPictureDisp MouseIcon);
    ///Gets or sets a value indicating the type of mouse pointer to be displayed. This property is read/write.
    HRESULT get_MousePointer(InkMousePointer* MousePointer);
    ///Gets or sets a value indicating the type of mouse pointer to be displayed. This property is read/write.
    HRESULT put_MousePointer(InkMousePointer MousePointer);
    ///Gets or sets a value indicating whether the contents of the InkEdit control can be edited. This property is
    ///read/write.
    HRESULT get_Locked(short* pVal);
    ///Gets or sets a value indicating whether the contents of the InkEdit control can be edited. This property is
    ///read/write.
    HRESULT put_Locked(short newVal);
    ///Gets or sets a value that determines whether the InkEdit control can respond to user-generated events. This
    ///property is read/write.
    HRESULT get_Enabled(short* pVal);
    ///Gets or sets a value that determines whether the InkEdit control can respond to user-generated events. This
    ///property is read/write.
    HRESULT put_Enabled(short newVal);
    ///Gets or sets a value indicating whether there is a maximum number of characters an InkEdit control can hold and,
    ///if so, specifies the maximum number of characters. This property is read/write.
    HRESULT get_MaxLength(int* plMaxLength);
    ///Gets or sets a value indicating whether there is a maximum number of characters an InkEdit control can hold and,
    ///if so, specifies the maximum number of characters. This property is read/write.
    HRESULT put_MaxLength(int lMaxLength);
    ///Gets or sets a value indicating whether an InkEdit control can accept and display multiple lines of text. This
    ///property is read/write.
    HRESULT get_MultiLine(short* pVal);
    ///Gets or sets a value indicating whether an InkEdit control can accept and display multiple lines of text. This
    ///property is read/write.
    HRESULT put_MultiLine(short newVal);
    ///Gets or sets the type of scroll bars, if any, to display in the InkEdit control. This property is read/write.
    HRESULT get_ScrollBars(ScrollBarsConstants* pVal);
    ///Gets or sets the type of scroll bars, if any, to display in the InkEdit control. This property is read/write.
    HRESULT put_ScrollBars(ScrollBarsConstants newVal);
    ///Gets or sets a value that determines whether scroll bars in the InkEdit control are disabled. This property is
    ///read/write.
    HRESULT get_DisableNoScroll(short* pVal);
    ///Gets or sets a value that determines whether scroll bars in the InkEdit control are disabled. This property is
    ///read/write.
    HRESULT put_DisableNoScroll(short newVal);
    ///Gets or sets a value that controls the alignment of the paragraphs in an InkEdit control. This property is
    ///read/write.
    HRESULT get_SelAlignment(VARIANT* pvarSelAlignment);
    ///Gets or sets a value that controls the alignment of the paragraphs in an InkEdit control. This property is
    ///read/write.
    HRESULT put_SelAlignment(VARIANT pvarSelAlignment);
    ///Gets or sets a value that specifies whether the font style of the currently selected text in the InkEdit control
    ///is bold. This property is read/write.
    HRESULT get_SelBold(VARIANT* pvarSelBold);
    ///Gets or sets a value that specifies whether the font style of the currently selected text in the InkEdit control
    ///is bold. This property is read/write.
    HRESULT put_SelBold(VARIANT pvarSelBold);
    ///Gets or sets a value that specifies whether the font style of the currently selected text in the InkEdit control
    ///is italic (run time only). This property is read/write.
    HRESULT get_SelItalic(VARIANT* pvarSelItalic);
    ///Gets or sets a value that specifies whether the font style of the currently selected text in the InkEdit control
    ///is italic (run time only). This property is read/write.
    HRESULT put_SelItalic(VARIANT pvarSelItalic);
    ///Gets or sets a value that specifies whether the font style of the currently selected text in the InkEdit control
    ///is underlined (run time only). This property is read/write.
    HRESULT get_SelUnderline(VARIANT* pvarSelUnderline);
    ///Gets or sets a value that specifies whether the font style of the currently selected text in the InkEdit control
    ///is underlined (run time only). This property is read/write.
    HRESULT put_SelUnderline(VARIANT pvarSelUnderline);
    ///Gets or sets the text color of the current text selection or insertion point (run time only). This property is
    ///read/write.
    HRESULT get_SelColor(VARIANT* pvarSelColor);
    ///Gets or sets the text color of the current text selection or insertion point (run time only). This property is
    ///read/write.
    HRESULT put_SelColor(VARIANT pvarSelColor);
    ///Gets or sets the font name of the selected text within the InkEdit control (run time only). This property is
    ///read/write.
    HRESULT get_SelFontName(VARIANT* pvarSelFontName);
    ///Gets or sets the font name of the selected text within the InkEdit control (run time only). This property is
    ///read/write.
    HRESULT put_SelFontName(VARIANT pvarSelFontName);
    ///Gets or sets the font size of the selected text within the InkEdit control (run time only). This property is
    ///read/write.
    HRESULT get_SelFontSize(VARIANT* pvarSelFontSize);
    ///Gets or sets the font size of the selected text within the InkEdit control (run time only). This property is
    ///read/write.
    HRESULT put_SelFontSize(VARIANT pvarSelFontSize);
    ///Returns or sets a value that determines whether text in the InkEdit control appears on the baseline (normal), as
    ///a superscript above the baseline, or as a subscript below the baseline. This property is read/write.
    HRESULT get_SelCharOffset(VARIANT* pvarSelCharOffset);
    ///Returns or sets a value that determines whether text in the InkEdit control appears on the baseline (normal), as
    ///a superscript above the baseline, or as a subscript below the baseline. This property is read/write.
    HRESULT put_SelCharOffset(VARIANT pvarSelCharOffset);
    ///Gets or sets the text of the InkEdit control, including all RTF codes. This property is read/write.
    HRESULT get_TextRTF(BSTR* pbstrTextRTF);
    ///Gets or sets the text of the InkEdit control, including all RTF codes. This property is read/write.
    HRESULT put_TextRTF(BSTR pbstrTextRTF);
    ///Gets or sets the starting point of the text that is selected in the InkEdit control (run time only). This
    ///property is read/write.
    HRESULT get_SelStart(int* plSelStart);
    ///Gets or sets the starting point of the text that is selected in the InkEdit control (run time only). This
    ///property is read/write.
    HRESULT put_SelStart(int plSelStart);
    ///Gets or sets the number of characters that are selected in the InkEdit control (run time only). This property is
    ///read/write.
    HRESULT get_SelLength(int* plSelLength);
    ///Gets or sets the number of characters that are selected in the InkEdit control (run time only). This property is
    ///read/write.
    HRESULT put_SelLength(int plSelLength);
    ///Gets or sets the selected text within the InkEdit control (run time only). This property is read/write.
    HRESULT get_SelText(BSTR* pbstrSelText);
    ///Gets or sets the selected text within the InkEdit control (run time only). This property is read/write.
    HRESULT put_SelText(BSTR pbstrSelText);
    ///Gets or sets the currently selected Rich Text Format (RTF) formatted text in the InkEdit control (run time only).
    ///This property is read/write.
    HRESULT get_SelRTF(BSTR* pbstrSelRTF);
    ///Gets or sets the currently selected Rich Text Format (RTF) formatted text in the InkEdit control (run time only).
    ///This property is read/write.
    HRESULT put_SelRTF(BSTR pbstrSelRTF);
    ///Causes the InkEdit control to redraw.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Refresh();
}

@GUID("E3B0B797-A72E-46DB-A0D7-6C9EBA8E9BBC")
interface _IInkEditEvents : IDispatch
{
}

///The <b>IMathInputControl</b> interface exposes methods that turn ink input into interpreted math output.
@GUID("EBA615AA-FAC6-4738-BA5F-FF09E9FE473E")
interface IMathInputControl : IDispatch
{
    ///Shows the control.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Show();
    ///Hides the control.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Hide();
    ///Determines whether the control is visible.
    ///Params:
    ///    pvbShown = <b>VARIANT_TRUE</b> to show the control; <b>VARIANT_FALSE</b> to hide the control.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>pvbShown</i> parameter is
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT IsVisible(short* pvbShown);
    ///Retrieves the position and size of the control.
    ///Params:
    ///    Left = The leftmost position of the control.
    ///    Top = The highest position of the control.
    ///    Right = The rightmost position of the control.
    ///    Bottom = The lowest position of the control.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetPosition(int* Left, int* Top, int* Right, int* Bottom);
    ///Modifies the location and size of the control.
    ///Params:
    ///    Left = The leftmost position of the control.
    ///    Top = The highest position of the control.
    ///    Right = The rightmost position of the control.
    ///    Bottom = The lowest position of the control.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The control was resized but the resulting width,
    ///    height, or both are not equal to the input parameters. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td> </tr> </table>
    ///    
    HRESULT SetPosition(int Left, int Top, int Right, int Bottom);
    ///Clears all ink from the control.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Clear();
    ///Determines whether a button or background has custom painting.
    ///Params:
    ///    Element = The identifier for a button or background.
    ///    Paint = <b>VARIANT_TRUE</b> to enable custom painting for the specified UI element; otherwise, <b>VARIANT_FALSE</b>.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetCustomPaint(int Element, short Paint);
    ///Modifies the string that will be used as the control's caption when the window is created.
    ///Params:
    ///    CaptionText = The caption text.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetCaptionText(BSTR CaptionText);
    ///Processes ink and triggers recognition.
    ///Params:
    ///    Ink = The ink object.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT LoadInk(IInkDisp Ink);
    ///Modifies the window that owns this control.
    ///Params:
    ///    OwnerWindow = A handle to the owner window.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetOwnerWindow(ptrdiff_t OwnerWindow);
    ///Determines whether the extended set of control buttons is shown.
    ///Params:
    ///    Extended = <b>VARIANT_TRUE</b> to show the extended button set; <b>VARIANT_FALSE</b> to show the basic button set.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT EnableExtendedButtons(short Extended);
    ///Retrieves the height in pixels of the preview area.
    ///Params:
    ///    Height = The height in pixels of the preview area.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetPreviewHeight(int* Height);
    ///Modifies the preview-area height in pixels.
    ///Params:
    ///    Height = The preview-area height in pixels.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The height specified by the <i>Height</i> parameter
    ///    is outside the control's bounds. </td> </tr> </table>
    ///    
    HRESULT SetPreviewHeight(int Height);
    ///Determines whether the control automatically grows when input is entered beyond the control's current range.
    ///Params:
    ///    AutoGrow = <b>VARIANT_TRUE</b> to enable automatic growth; otherwise, <b>VARIANT_FALSE</b>.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT EnableAutoGrow(short AutoGrow);
    ///Adds a new function-name definition to the list of custom math functions that the recognizer accepts.
    ///Params:
    ///    FunctionName = The name of the function to be added.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The name could not be added. </td> </tr> </table>
    ///    
    HRESULT AddFunctionName(BSTR FunctionName);
    ///Removes a function-name definition from the list of custom math functions that the recognizer accepts.
    ///Params:
    ///    FunctionName = The name of the function to remove.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The named math function cannot be removed because
    ///    it is not in the list of custom math functions that the recognizer accepts. </td> </tr> </table>
    ///    
    HRESULT RemoveFunctionName(BSTR FunctionName);
    ///Retrieves the icon to be used for the hover target to launch math input control.
    ///Params:
    ///    HoverImage = The address of the pointer to the hover target icon.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible return codes include, but are not limited to, those in the
    ///    following table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The icon could not be retrieved. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetHoverIcon(IPictureDisp* HoverImage);
}

///The <b>_IMathInputControlEvents</b> interface exposes the math input control event handlers.
@GUID("683336B5-A47D-4358-96F9-875A472AE70A")
interface _IMathInputControlEvents : IDispatch
{
}

///Handles the stylus packet data from a digitizer in real time.
@GUID("A8BB5D22-3144-4A7B-93CD-F34A16BE513A")
interface IRealTimeStylus : IUnknown
{
    ///Gets or sets a value that specifies whether the RealTimeStylus object collects tablet pen data. This property is
    ///read/write.
    HRESULT get_Enabled(int* pfEnable);
    ///Gets or sets a value that specifies whether the RealTimeStylus object collects tablet pen data. This property is
    ///read/write.
    HRESULT put_Enabled(BOOL fEnable);
    ///Gets or sets the handle value associated with the window the RealTimeStylus object uses. This property is
    ///read/write.
    HRESULT get_HWND(size_t* phwnd);
    ///Gets or sets the handle value associated with the window the RealTimeStylus object uses. This property is
    ///read/write.
    HRESULT put_HWND(size_t hwnd);
    ///Gets or sets the window input rectangle for the RealTimeStylus Class object. This property is read/write.
    HRESULT get_WindowInputRectangle(RECT* prcWndInputRect);
    ///Gets or sets the window input rectangle for the RealTimeStylus Class object. This property is read/write.
    HRESULT put_WindowInputRectangle(const(RECT)* prcWndInputRect);
    ///Adds an IStylusSyncPlugin to the synchronous plug-in collection at the specified index.
    ///Params:
    ///    iIndex = The index of the synchronous plug-in collection where the plug-in is added.
    ///    piPlugin = The plug-in that is added.
    ///Returns:
    ///    For a description of the return values, see RealTimeStylus Classes and Interfaces.
    ///    
    HRESULT AddStylusSyncPlugin(uint iIndex, IStylusSyncPlugin piPlugin);
    ///Removes an IStylusSyncPlugin from the collection at the specified index.
    ///Params:
    ///    iIndex = The index of the plug-in to be removed.
    ///    ppiPlugin = A pointer to the plug-in to remove. If you are not interested in receiving the pointer to the removed
    ///                plug-in, pass <b>NULL</b> for this parameter.
    ///Returns:
    ///    For a description of the return values, see RealTimeStylus Classes and Interfaces.
    ///    
    HRESULT RemoveStylusSyncPlugin(uint iIndex, IStylusSyncPlugin* ppiPlugin);
    ///Removes all of the plug-ins from the synchronous plug-in collection.
    ///Returns:
    ///    For a description of the return values, see RealTimeStylus Classes and Interfaces.
    ///    
    HRESULT RemoveAllStylusSyncPlugins();
    ///Retrieves the plug-in at the specified index in the synchronous plug-in collection.
    ///Params:
    ///    iIndex = The index for the plug-in that is in the synchronous plug-in collection.
    ///    ppiPlugin = A pointer to the plug-in.
    ///Returns:
    ///    For a description of the return values see RealTimeStylus Classes and Interfaces.
    ///    
    HRESULT GetStylusSyncPlugin(uint iIndex, IStylusSyncPlugin* ppiPlugin);
    ///Retrieves the number of plug-ins in the synchronous plug-in collection.
    ///Params:
    ///    pcPlugins = The number of plug-ins in the synchronous plug-in collection.
    ///Returns:
    ///    For a description of the return values, see RealTimeStylus Classes and Interfaces.
    ///    
    HRESULT GetStylusSyncPluginCount(uint* pcPlugins);
    ///Adds an IStylusAsyncPlugin to the asynchronous plug-in collection at the specified index.
    ///Params:
    ///    iIndex = Specifies the index of the plug-in in the asynchronous plug-in collection.
    ///    piPlugin = The plug-in to add to.
    ///Returns:
    ///    For a description of the return values, see RealTimeStylus Classes and Interfaces.
    ///    
    HRESULT AddStylusAsyncPlugin(uint iIndex, IStylusAsyncPlugin piPlugin);
    ///Removes and optionally returns an IStylusAsyncPlugin with the specified index in the asynchronous plug-in
    ///collection.
    ///Params:
    ///    iIndex = The index of the plug-in to be removed.
    ///    ppiPlugin = A pointer to the plug-in to remove. If you are not interested in receiving the pointer to the removed
    ///                plug-in, pass <b>NULL</b> for this parameter.
    ///Returns:
    ///    For a description of the return values, see RealTimeStylus Classes and Interfaces.
    ///    
    HRESULT RemoveStylusAsyncPlugin(uint iIndex, IStylusAsyncPlugin* ppiPlugin);
    ///Removes all the plug-ins from the asynchronous plug-in collection.
    ///Returns:
    ///    For a description of the return values, see RealTimeStylus Classes and Interfaces.
    ///    
    HRESULT RemoveAllStylusAsyncPlugins();
    ///Retrieves the plug-in at the specified index in the asynchronous plug-in collection.
    ///Params:
    ///    iIndex = The index for the plug-in that is in the asynchronous plug-in collection.
    ///    ppiPlugin = A pointer to the plug-in.
    ///Returns:
    ///    For a description of the return values see RealTimeStylus Classes and Interfaces.
    ///    
    HRESULT GetStylusAsyncPlugin(uint iIndex, IStylusAsyncPlugin* ppiPlugin);
    ///Retrieves the number of plug-ins in the asynchronous plug-in collection.
    ///Params:
    ///    pcPlugins = The plug-in count for the asynchronous plug-in collection.
    ///Returns:
    ///    For a description of the return values, see RealTimeStylus Classes and Interfaces.
    ///    
    HRESULT GetStylusAsyncPluginCount(uint* pcPlugins);
    ///Gets or sets a RealTimeStylus object as an asynchronous plug-in of the current <b>RealTimeStylus</b> object. This
    ///property is read/write.
    HRESULT get_ChildRealTimeStylusPlugin(IRealTimeStylus* ppiRTS);
    HRESULT putref_ChildRealTimeStylusPlugin(IRealTimeStylus piRTS);
    ///Adds custom data to the specified queue of the RealTimeStylus Class object.
    ///Params:
    ///    sq = The StylusQueue Enumeration specifying the stylus queue to which to add the custom data.
    ///    pGuidId = The GUID for the data to add to the queue specified in <i>sq</i>.
    ///    cbData = The size, in chars, of the data that <i>pbData</i> points to and which is to be added to the specified queue.
    ///    pbData = The custom data to add to the specified queue. May not be <b>NULL</b>.
    ///Returns:
    ///    For a description of the return values, see RealTimeStylus Classes and Interfaces.
    ///    
    HRESULT AddCustomStylusDataToQueue(StylusQueue sq, const(GUID)* pGuidId, uint cbData, char* pbData);
    ///Clears the RealTimeStylus Class input and output queues of data.
    ///Returns:
    ///    For a description of the return values, see RealTimeStylus Classes and Interfaces.
    ///    
    HRESULT ClearStylusQueues();
    ///Sets the mode for the RealTimeStylus Class object to collect data from all digitizers.
    ///Params:
    ///    fUseMouseForInput = <b>TRUE</b> for both the mouse and stylus to be used for input; <b>FALSE</b> for the mouse not to be used as
    ///                        input.
    ///Returns:
    ///    For a description of the return values, see RealTimeStylus Classes and Interfaces.
    ///    
    HRESULT SetAllTabletsMode(BOOL fUseMouseForInput);
    ///Modifies the mode for RealTimeStylus Class (RTS) object to collect input from only one tablet object representing
    ///a digitizer attached to the Tablet PC. Stylus input from other digitizers is ignored by the RealTimeStylus.
    ///Params:
    ///    piTablet = The IInkTablet Interface object that represents the digitizer device attached to the Tablet PC.
    ///Returns:
    ///    For a description of the return values, see RealTimeStylus Classes and Interfaces.
    ///    
    HRESULT SetSingleTabletMode(IInkTablet piTablet);
    ///Retrieves an IInkTablet Interface object to the caller.
    ///Params:
    ///    ppiSingleTablet = A pointer to the IInkTablet Interface object.
    ///Returns:
    ///    For a description of the return values, see RealTimeStylus Classes and Interfaces.
    ///    
    HRESULT GetTablet(IInkTablet* ppiSingleTablet);
    ///Retrieves the TabletContextId property that is associated with a given tablet digitizer object.
    ///Params:
    ///    piTablet = Specifies the tablet object associated with a digitizer for which to get the unique identifier for the tablet
    ///               context.
    ///    ptcid = The unique identifier for the tablet context.
    ///Returns:
    ///    For a description of the return values, see RealTimeStylus Classes and Interfaces.
    ///    
    HRESULT GetTabletContextIdFromTablet(IInkTablet piTablet, uint* ptcid);
    ///Retrieves an IInkTablet Interface for a specified tablet context.
    ///Params:
    ///    tcid = Specifies the unique identifier for the tablet context.
    ///    ppiTablet = A pointer to the digitizer object specified by the tablet context identifier.
    ///Returns:
    ///    For a description of the return values, see RealTimeStylus Classes and Interfaces.
    ///    
    HRESULT GetTabletFromTabletContextId(uint tcid, IInkTablet* ppiTablet);
    ///Retrieves an array containing all of the currently active tablet context identifiers.
    ///Params:
    ///    pcTcidCount = The number of tablet context identifiers.
    ///    ppTcids = Pointer to the array of tablet context identifiers
    ///Returns:
    ///    For a description of the return values, see RealTimeStylus Classes and Interfaces.
    ///    
    HRESULT GetAllTabletContextIds(uint* pcTcidCount, char* ppTcids);
    ///Retrieves the collection of styluses the RealTimeStylus Class object has encountered.
    ///Params:
    ///    ppiInkCursors = When this method returns, contains a pointer to the collection of styluses the RealTimeStylus Class object
    ///                    has encountered.
    ///Returns:
    ///    For a description of the return values, see RealTimeStylus Classes and Interfaces.
    ///    
    HRESULT GetStyluses(IInkCursors* ppiInkCursors);
    ///Retrieves a stylus for the specified stylus identifier.
    ///Params:
    ///    sid = Specifies security identifier (SID) for the collection.
    ///    ppiInkCursor = When this method returns, contains a pointer to an IInkCursor that describes the stylus for the <i>sid</i>
    ///                   parameter.
    ///Returns:
    ///    For a description of the return values, see RealTimeStylus Classes and Interfaces.
    ///    
    HRESULT GetStylusForId(uint sid, IInkCursor* ppiInkCursor);
    ///Requests properties to be included in the packet stream.
    ///Params:
    ///    cProperties = Count of the properties specified by the <i>pPropertyGuids</i> parameter. Valid values are between 0 and 32,
    ///                  inclusive.
    ///    pPropertyGuids = The array of globally unique identifiers (GUIDs) for the properties requested to be included in the packet
    ///                     stream.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetDesiredPacketDescription(uint cProperties, char* pPropertyGuids);
    ///Retrieves the list of properties that have been requested to be included in the packet stream.
    ///Params:
    ///    pcProperties = The size, in bytes, of the <i>ppPropertyGUIDS</i> buffer.
    ///    ppPropertyGuids = A pointer to a list of GUIDs specifying which properties, such as X, Y, and NormalPressure, are present in
    ///                      the packet data. For a list of predefined properties, see PacketPropertyGuids Constants.
    ///Returns:
    ///    For a description of the return values, see RealTimeStylus Classes and Interfaces.
    ///    
    HRESULT GetDesiredPacketDescription(uint* pcProperties, char* ppPropertyGuids);
    ///Retrieves the packet properties and scaling factors.
    ///Params:
    ///    tcid = Specifies the tablet context identifier.
    ///    pfInkToDeviceScaleX = Specifies the conversion factor for the horizontal axis from ink space to digitizer coordinates.
    ///    pfInkToDeviceScaleY = Specifies the conversion factor for the vertical axis from ink space to digitizer coordinates.
    ///    pcPacketProperties = The number of properties in each packet.
    ///    ppPacketProperties = Pointer to an array containing the GUIDs and property metrics for each packet property.
    ///Returns:
    ///    For a description of the return values, see RealTimeStylus Classes and Interfaces.
    ///    
    HRESULT GetPacketDescriptionData(uint tcid, float* pfInkToDeviceScaleX, float* pfInkToDeviceScaleY, 
                                     uint* pcPacketProperties, char* ppPacketProperties);
}

///Extends the IRealTimeStylus interface.
@GUID("B5F2A6CD-3179-4A3E-B9C4-BB5865962BE2")
interface IRealTimeStylus2 : IUnknown
{
    ///Returns a value indicating whether flick gestures are enabled for the RTS.
    ///Params:
    ///    pfEnable = <b>TRUE</b> if flick gestures have been enabled; otherwise, <b>FALSE</b>.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT get_FlicksEnabled(int* pfEnable);
    ///Indicates if flick gesture recognition is enabled.
    ///Params:
    ///    fEnable = <b>TRUE</b> to enable flicks gesture recognition; <b>FALSE</b> to disable flicks.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT put_FlicksEnabled(BOOL fEnable);
}

///The IRealTimeStylus3 interface enables multitouch for the realtime stylus.
@GUID("D70230A3-6986-4051-B57A-1CF69F4D9DB5")
interface IRealTimeStylus3 : IUnknown
{
    ///Indicates whether the IRealTimeStylus3 object has multitouch input enabled. This property is read/write.
    HRESULT get_MultiTouchEnabled(int* pfEnable);
    ///Indicates whether the IRealTimeStylus3 object has multitouch input enabled. This property is read/write.
    HRESULT put_MultiTouchEnabled(BOOL fEnable);
}

///Synchronizes access to the RealTimeStylus Class object.
@GUID("AA87EAB8-AB4A-4CEA-B5CB-46D84C6A2509")
interface IRealTimeStylusSynchronization : IUnknown
{
    ///Retrieves the specified lock.
    ///Params:
    ///    lock = The RealTimeStylusLockType Enumeration value that indicates which object lock to use.
    ///Returns:
    ///    For a description of the return values, see RealTimeStylus Classes and Interfaces.
    ///    
    HRESULT AcquireLock(RealTimeStylusLockType lock);
    ///Releases the specified lock.
    ///Params:
    ///    lock = The RealTimeStylusLockType Enumeration value that indicates which object lock to release.
    ///Returns:
    ///    For a description of the return values, see RealTimeStylus Classes and Interfaces.
    ///    
    HRESULT ReleaseLock(RealTimeStylusLockType lock);
}

///Use interface to programmatically create strokes from packet data.
@GUID("A5FD4E2D-C44B-4092-9177-260905EB672B")
interface IStrokeBuilder : IUnknown
{
    ///Creates strokes on an ink object by using packet data that came from a RealTimeStylus Class object.
    ///Params:
    ///    cPktBuffLength = The number of LONGs in the <i>pPackets</i> array not the size in bytes. Valid values are between 0 and
    ///                     0x000FFFFF, inclusive.
    ///    pPackets = A pointer to the start of the packet data.
    ///    cPacketProperties = The count of longs in the <i>pPacketProperties</i> buffer. This is the number of packets multiplied by the
    ///                        number of properties. Valid values are between 0 and 32, inclusive.
    ///    pPacketProperties = The buffer containing the packet properties.
    ///    fInkToDeviceScaleX = The horizontal, or x-axis, conversion factor for the horizontal axis from ink space to digitizer coordinates.
    ///    fInkToDeviceScaleY = The vertical, or y-axis, conversion factor for the vertical axis from ink space to digitizer coordinates.
    ///    ppIInkStroke = A pointer to the newly created stroke. This value can be <b>NULL</b>.
    ///Returns:
    ///    For a description of the return values, see RealTimeStylus Classes and Interfaces.
    ///    
    HRESULT CreateStroke(uint cPktBuffLength, char* pPackets, uint cPacketProperties, char* pPacketProperties, 
                         float fInkToDeviceScaleX, float fInkToDeviceScaleY, IInkStrokeDisp* ppIInkStroke);
    ///Begins a stroke on an ink object by using packet data from a RealTimeStylus Class object.
    ///Params:
    ///    tcid = The tablet context identifier.
    ///    sid = The stylus identifier.
    ///    pPacket = The start of the packet data. It is read-only.
    ///    cPacketProperties = The count of LONGs, which is the number of packets multiplied by the number of properties, in the
    ///                        <i>pPacketProperties</i> buffer.
    ///    pPacketProperties = The buffer containing the packet properties.
    ///    fInkToDeviceScaleX = The horizontal, or x-axis, conversion factor for the horizontal axis from ink space to digitizer coordinates.
    ///    fInkToDeviceScaleY = The vertical, or y-axis, conversion factor for the vertical axis from ink space to digitizer coordinates.
    ///    ppIInkStroke = A a pointer to the new stroke. This value can be <b>NULL</b>.
    ///Returns:
    ///    For a description of return values, see RealTimeStylus Classes and Interfaces.
    ///    
    HRESULT BeginStroke(uint tcid, uint sid, const(int)* pPacket, uint cPacketProperties, char* pPacketProperties, 
                        float fInkToDeviceScaleX, float fInkToDeviceScaleY, IInkStrokeDisp* ppIInkStroke);
    ///Adds a packet to the end of the digitizer input packet list.
    ///Params:
    ///    tcid = The context identifier for the tablet device to which the stylus belongs.
    ///    sid = The identifier of the stylus object.
    ///    cPktBuffLength = The number of LONGs in the <i>pPackets</i> array not the size in bytes. Valid values are betwwen 0 and
    ///                     0x7FFF, inclusive.
    ///    pPackets = The start of the packet data. It is read-only.
    ///Returns:
    ///    For a description of the return values, see RealTimeStylus Classes and Interfaces.
    ///    
    HRESULT AppendPackets(uint tcid, uint sid, uint cPktBuffLength, char* pPackets);
    ///Ends a stroke and returns the stroke object.
    ///Params:
    ///    tcid = The tablet context identifier.
    ///    sid = The stylus identifier.
    ///    ppIInkStroke = A pointer to the new stroke. This value can be <b>NULL</b>.
    ///    pDirtyRect = The dirty, or changed, rectangle of the tablet. This value can be <b>NULL</b>.
    ///Returns:
    ///    For a description of return values, see RealTimeStylus Classes and Interfaces..
    ///    
    HRESULT EndStroke(uint tcid, uint sid, IInkStrokeDisp* ppIInkStroke, RECT* pDirtyRect);
    ///Gets or sets the ink object that is associated with the IStrokeBuilder object. This property is read/write.
    HRESULT get_Ink(IInkDisp* ppiInkObj);
    HRESULT putref_Ink(IInkDisp piInkObj);
}

///Receives notifications of RealTimeStylus Class events to enable you to perform custom processing based on those
///events.
@GUID("A81436D8-4757-4FD1-A185-133F97C6C545")
interface IStylusPlugin : IUnknown
{
    ///Notifies the implementing plug-in that the RealTimeStylus Class (RTS) object is enabled.
    ///Params:
    ///    piRtsSrc = The RealTimeStylus Class object that sent the notification.
    ///    cTcidCount = Number of tablet context identifiers the RTS has encountered. Valid values are 0 through 8, inclusive.
    ///    pTcids = The tablet context identifiers.
    ///Returns:
    ///    For a description of return values, see RealTimeStylus Classes and Interfaces.
    ///    
    HRESULT RealTimeStylusEnabled(IRealTimeStylus piRtsSrc, uint cTcidCount, char* pTcids);
    ///Notifies the implementing plug-in that the RealTimeStylus Class (RTS) object is disabled.
    ///Params:
    ///    piRtsSrc = The RealTimeStylus Class object that sent the notification.
    ///    cTcidCount = Number of tablet context identifiers the RTS has encountered. Valid values are 0 through 8, inclusive.
    ///    pTcids = The tablet context identifiers.
    ///Returns:
    ///    For a description of return values, see RealTimeStylus Classes and Interfaces.
    ///    
    HRESULT RealTimeStylusDisabled(IRealTimeStylus piRtsSrc, uint cTcidCount, char* pTcids);
    ///Notifies the implementing plug-in that the stylus is entering the detection range of the digitizer.
    ///Params:
    ///    piRtsSrc = The RealTimeStylus Class object that sent the notification.
    ///    tcid = Tablet context identifier.
    ///    sid = Stylus identifier.
    ///Returns:
    ///    For a description of return values, see RealTimeStylus Classes and Interfaces.
    ///    
    HRESULT StylusInRange(IRealTimeStylus piRtsSrc, uint tcid, uint sid);
    ///Notifies the implementing plug-in that the stylus has left the detection range of the digitizer.
    ///Params:
    ///    piRtsSrc = The RealTimeStylus Class object that sent the notification.
    ///    tcid = Tablet context identifier.
    ///    sid = Stylus identifier.
    ///Returns:
    ///    For a description of return values, see RealTimeStylus Classes and Interfaces.
    ///    
    HRESULT StylusOutOfRange(IRealTimeStylus piRtsSrc, uint tcid, uint sid);
    ///Notifies the implementing plug-in that the tablet pen has touched the digitizer surface.
    ///Params:
    ///    piRtsSrc = The RealTimeStylus Class (RTS) object that sent the notification.
    ///    pStylusInfo = A StylusInfo Structure containing the information about the RTS that is associated with the stylus.
    ///    cPropCountPerPkt = Number of properties per packet. Valid values are 0 through 32, inclusive.
    ///    pPacket = The start of the packet data.
    ///    ppInOutPkt = A pointer to the modified stylus data packet. The plug-in can use this parameter to feed modified packet data
    ///                 to downstream packets. A value other than <b>NULL</b> indicates that the packet has been modified and RTS
    ///                 will send this data down to plug-ins by using the <i>pPacket</i> parameter.
    ///Returns:
    ///    For a description of return values, RealTimeStylus Classes and Interfaces.
    ///    
    HRESULT StylusDown(IRealTimeStylus piRtsSrc, const(StylusInfo)* pStylusInfo, uint cPropCountPerPkt, 
                       char* pPacket, int** ppInOutPkt);
    ///Notifies the implementing plug-in that the user has raised the tablet pen from the tablet digitizer surface.
    ///Params:
    ///    piRtsSrc = The RealTimeStylus Class (RTS) object that sent the notification.
    ///    pStylusInfo = A StylusInfo Structure containing the information about the RTS that is associated with the pen.
    ///    cPropCountPerPkt = Number of properties per packet. Valid values are 0 through 32, inclusive.
    ///    pPacket = The start of the packet data.
    ///    ppInOutPkt = A pointer to the modified stylus data packet. The plug-in can use this parameter to feed modified packet data
    ///                 to downstream packets. A value other than <b>NULL</b> indicates that the packet has been modified and RTS
    ///                 will send this data down to plug-ins by using the <i>pPacket</i> parameter.
    ///Returns:
    ///    For a description of return values, see RealTimeStylus Classes and Interfaces.
    ///    
    HRESULT StylusUp(IRealTimeStylus piRtsSrc, const(StylusInfo)* pStylusInfo, uint cPropCountPerPkt, 
                     char* pPacket, int** ppInOutPkt);
    ///Notifies the implementing plug-in that the user is pressing a stylus button.
    ///Params:
    ///    piRtsSrc = The RealTimeStylus Class object that sent the notification.
    ///    sid = Security identifier.
    ///    pGuidStylusButton = The GUID-type identifier for the stylus button data. The GUID indcates the unique identifier for this data
    ///                        object.
    ///    pStylusPos = A StylusInfo Structure containing the information about the RealTimeStylus Class object that is associated
    ///                 with the stylus.
    ///Returns:
    ///    For a description of return values, see RealTimeStylus Classes and Interfaces.
    ///    
    HRESULT StylusButtonDown(IRealTimeStylus piRtsSrc, uint sid, const(GUID)* pGuidStylusButton, POINT* pStylusPos);
    ///Notifies the implementing plug-in that the user has released a stylus button.
    ///Params:
    ///    piRtsSrc = The RealTimeStylus Class (RTS) object that sent the notification.
    ///    sid = Security identifier.
    ///    pGuidStylusButton = The globally unique identifier (GUID) for the stylus button data.
    ///    pStylusPos = AStylusInfo Structure containing the information about the RTS that is associated with the stylus.
    ///Returns:
    ///    For a description of return values, see RealTimeStylus Classes and Interfaces.
    ///    
    HRESULT StylusButtonUp(IRealTimeStylus piRtsSrc, uint sid, const(GUID)* pGuidStylusButton, POINT* pStylusPos);
    ///Notifies the object implementing the plug-in that the stylus is moving above the digitizer.
    ///Params:
    ///    piRtsSrc = The RealTimeStylus Class (RTS) object that sent the notification.
    ///    pStylusInfo = A StylusInfo Structure structure containing the information about the RTS that is associated with the stylus.
    ///    cPktCount = The number of properties per data packet.
    ///    cPktBuffLength = The length, in <b>bytes</b>, of the buffer pointed to by <i>pPackets</i>. The memory occupied by each packet
    ///                     is (<i>cPktBuffLength</i> / <i>cPktCount</i>). Valid values are 0 through 0x7FFF, inclusive.
    ///    pPackets = A pointer to the start of the packet data. It is read-only.
    ///    pcInOutPkts = The number of <b>LONGs</b> in <i>ppInOutPkt</i>.
    ///    ppInOutPkts = A pointer to an array of modified stylus data packets. The plug-in can use this parameter to feed modified
    ///                  packet data to downstream packets. For a value other than <b>NULL</b>, RTS will send this data down to
    ///                  plug-ins by using the <i>pPacket</i> parameter.
    ///Returns:
    ///    For a description of return values, see Classes and Interfaces - Ink Analysis.
    ///    
    HRESULT InAirPackets(IRealTimeStylus piRtsSrc, const(StylusInfo)* pStylusInfo, uint cPktCount, 
                         uint cPktBuffLength, char* pPackets, uint* pcInOutPkts, int** ppInOutPkts);
    ///Notifies the object implementing the plug-in that the tablet pen is moving on the digitizer.
    ///Params:
    ///    piRtsSrc = The RealTimeStylus Class object that sent the notification.
    ///    pStylusInfo = A StylusInfo Structure structure which contains information about the RTS that is associated with the pen.
    ///    cPktCount = The number of properties per data packet.
    ///    cPktBuffLength = The length, in <b>bytes</b>, of the buffer pointed to by <i>pPackets</i>. The memory occupied by each packet
    ///                     is (<i>cPktBuffLength</i> / <i>cPktCount</i>). Valid values are 0 through 0x7FFF, inclusive.
    ///    pPackets = A pointer to the start of the packet data.
    ///    pcInOutPkts = The number of <b>LONGs</b> in <i>ppInOutPkt</i>.
    ///    ppInOutPkts = A pointer to an array of modified stylus data packets. The plug-in can use this parameter to feed modified
    ///                  packet data to downstream packets. A value other than <b>NULL</b> indicates that the RTS will send this data
    ///                  to plug-ins by using the <i>pPacket</i> parameter.
    ///Returns:
    ///    For a description of return values, see RealTimeStylus Classes and Interfaces.
    ///    
    HRESULT Packets(IRealTimeStylus piRtsSrc, const(StylusInfo)* pStylusInfo, uint cPktCount, uint cPktBuffLength, 
                    char* pPackets, uint* pcInOutPkts, int** ppInOutPkts);
    ///Notifies the implementing plug-in that custom stylus data is available.
    ///Params:
    ///    piRtsSrc = The RealTimeStylus Class (RTS) object that sent the notification.
    ///    pGuidId = The globally unique identifier (GUID) for the custom data.
    ///    cbData = The size, in chars, of the buffer, <i>pbData</i>. Valid values are 0 through 0x7FFF, inclusive.
    ///    pbData = A pointer to the buffer containing the custom data sent by the RTS object.
    ///Returns:
    ///    For a description of return values, see RealTimeStylus Classes and Interfaces.
    ///    
    HRESULT CustomStylusDataAdded(IRealTimeStylus piRtsSrc, const(GUID)* pGuidId, uint cbData, char* pbData);
    ///Notifies the implementing plug-in that a system event is available.
    ///Params:
    ///    piRtsSrc = The RealTimeStylus Class (RTS) object that sent the notification.
    ///    tcid = The tablet context identifier for the event.
    ///    sid = The security identifier.
    ///    event = The system event sent by the RTS object
    ///    eventdata = The SYSTEM_EVENT_DATA structure containing information about the system event, <i>event</i>.
    ///Returns:
    ///    For a description of return values, see Classes and Interfaces - Ink Analysis.
    ///    
    HRESULT SystemEvent(IRealTimeStylus piRtsSrc, uint tcid, uint sid, ushort event, SYSTEM_EVENT_DATA eventdata);
    ///Notifies an implementing plug-in when an ITablet object is attached to the system.
    ///Params:
    ///    piRtsSrc = The RealTimeStylus Class object that sent the notification.
    ///    piTablet = The added tablet object.
    ///Returns:
    ///    For a description of return values, see RealTimeStylus Classes and Interfaces.
    ///    
    HRESULT TabletAdded(IRealTimeStylus piRtsSrc, IInkTablet piTablet);
    ///Notifies an implementing plug-in when an ITablet object is removed from the system.
    ///Params:
    ///    piRtsSrc = The RealTimeStylus Class (RTS) object that sent the notification.
    ///    iTabletIndex = The tablet index.
    ///Returns:
    ///    For a description of return values, see RealTimeStylus Classes and Interfaces.
    ///    
    HRESULT TabletRemoved(IRealTimeStylus piRtsSrc, int iTabletIndex);
    ///Notifies the implementing object that this plug-in or one of the previous plug-ins in either the
    ///IStylusAsyncPlugin or IStylusSyncPlugin collection threw an exception.
    ///Params:
    ///    piRtsSrc = The RealTimeStylus Class (RTS) object that sent the notification.
    ///    piPlugin = The IStylusPlugin object that sent the notification.
    ///    dataInterest = Identifier of the IStylusPlugin method that generated the error.
    ///    hrErrorCode = The <b>HRESULT</b> code for the error that occurred.
    ///    lptrKey = Used internally by the system.
    ///Returns:
    ///    For a description of return values, see Classes and Interfaces - Ink Analysis.
    ///    
    HRESULT Error(IRealTimeStylus piRtsSrc, IStylusPlugin piPlugin, RealTimeStylusDataInterest dataInterest, 
                  HRESULT hrErrorCode, ptrdiff_t* lptrKey);
    ///Notifies the plug-in when display properties, such as dpi or orientation, change.
    ///Params:
    ///    piRtsSrc = The RealTimeStylus Class object that sent the notification.
    ///Returns:
    ///    For a description of the return values, see RealTimeStylus Classes and Interfaces.
    ///    
    HRESULT UpdateMapping(IRealTimeStylus piRtsSrc);
    ///Retrieves the events for which the plug-in is to receive notifications.
    ///Params:
    ///    pDataInterest = The bitmask indicating the events for which the plug-in is to receive notifications.
    ///Returns:
    ///    For a description of the return values, see RealTimeStylus Classes and Interfaces.
    ///    
    HRESULT DataInterest(RealTimeStylusDataInterest* pDataInterest);
}

///Represents a synchronous plug-in that can be added to the RealTimeStylus Class object's synchronous plug-in
///collection.
@GUID("A157B174-482F-4D71-A3F6-3A41DDD11BE9")
interface IStylusSyncPlugin : IStylusPlugin
{
}

///Represents an asynchronous plug-in that can be added to the asynchronous plug-in collection of the RealTimeStylus
///Class object.
@GUID("A7CCA85A-31BC-4CD2-AADC-3289A3AF11C8")
interface IStylusAsyncPlugin : IStylusPlugin
{
}

///Displays the tablet pen data in real-time as that data is being handled by the RealTimeStylus Class object.
@GUID("A079468E-7165-46F9-B7AF-98AD01A93009")
interface IDynamicRenderer : IUnknown
{
    ///Gets or sets a value that turns dynamic rendering on and off. This property is read/write.
    HRESULT get_Enabled(int* bEnabled);
    ///Gets or sets a value that turns dynamic rendering on and off. This property is read/write.
    HRESULT put_Enabled(BOOL bEnabled);
    ///Gets or sets the window handle, HWND, associated with the DynamicRenderer Class object. This property is
    ///read/write.
    HRESULT get_HWND(size_t* hwnd);
    ///Gets or sets the window handle, HWND, associated with the DynamicRenderer Class object. This property is
    ///read/write.
    HRESULT put_HWND(size_t hwnd);
    ///Gets or sets the clipping rectangle for the DynamicRenderer Class object. This property is read/write.
    HRESULT get_ClipRectangle(RECT* prcClipRect);
    ///Gets or sets the clipping rectangle for the DynamicRenderer Class object. This property is read/write.
    HRESULT put_ClipRectangle(const(RECT)* prcClipRect);
    ///Gets or sets the clipping region for the DynamicRenderer Class object. This property is read/write.
    HRESULT get_ClipRegion(size_t* phClipRgn);
    ///Gets or sets the clipping region for the DynamicRenderer Class object. This property is read/write.
    HRESULT put_ClipRegion(size_t hClipRgn);
    ///Gets or sets the <b>DrawingAttributes</b> object used by the DynamicRenderer Class object. This property is
    ///read/write.
    HRESULT get_DrawingAttributes(IInkDrawingAttributes* ppiDA);
    HRESULT putref_DrawingAttributes(IInkDrawingAttributes piDA);
    ///Gets or sets a value that indicates whether data caching is enabled for the DynamicRenderer Class object. This
    ///property is read/write.
    HRESULT get_DataCacheEnabled(int* pfCacheData);
    ///Gets or sets a value that indicates whether data caching is enabled for the DynamicRenderer Class object. This
    ///property is read/write.
    HRESULT put_DataCacheEnabled(BOOL fCacheData);
    ///Releases specified stroke data from the temporal data held by DynamicRenderer Class.
    ///Params:
    ///    strokeId = The identifier for the stroke.
    ///Returns:
    ///    For a description of the return values, see RealTimeStylus Classes and Interfaces.
    ///    
    HRESULT ReleaseCachedData(uint strokeId);
    ///Causes the DynamicRenderer Class object to redraw the ink data that is currently rendering.
    ///Returns:
    ///    This method can return one of these values.
    ///    
    HRESULT Refresh();
    ///Draws the cached data to the specified device context.
    ///Params:
    ///    hDC = The handle of the device context on which to draw.
    ///Returns:
    ///    For a description of the return values, see RealTimeStylus Classes and Interfaces.
    ///    
    HRESULT Draw(size_t hDC);
}

///Reacts to events by recognizing gestures and adding gesture data to the input queue.
@GUID("AE9EF86B-7054-45E3-AE22-3174DC8811B7")
interface IGestureRecognizer : IUnknown
{
    ///Gets or sets a value that indicates whether gesture recognition is enabled. This property is read/write.
    HRESULT get_Enabled(int* pfEnabled);
    ///Gets or sets a value that indicates whether gesture recognition is enabled. This property is read/write.
    HRESULT put_Enabled(BOOL fEnabled);
    ///Gets or sets the maximum number of strokes allowed per gesture recognition. This property is read/write.
    HRESULT get_MaxStrokeCount(int* pcStrokes);
    ///Gets or sets the maximum number of strokes allowed per gesture recognition. This property is read/write.
    HRESULT put_MaxStrokeCount(int cStrokes);
    ///Sets a value that indicates to which application gestures the GestureRecognizer Class object responds.
    ///Params:
    ///    cGestures = The size of the array to which the <i>pGestures</i> parameter points. Valid values are between 0 and 64,
    ///                inclusive.
    ///    pGestures = An array of the InkApplicationGesture Enumeration values that indicates to which application gestures the
    ///                GestureRecognizer Class object responds.
    ///Returns:
    ///    For a description of return values, see RealTimeStylus Classes and Interfaces.
    ///    
    HRESULT EnableGestures(uint cGestures, char* pGestures);
    ///Deletes past stroke information from the GestureRecognizer Class object.
    ///Returns:
    ///    For a description of return values see RealTimeStylus Classes and Interfaces.
    ///    
    HRESULT Reset();
}

@GUID("7C6CF46D-8404-46B9-AD33-F5B6036D4007")
interface ITipAutoCompleteProvider : IUnknown
{
    HRESULT UpdatePendingText(BSTR bstrPendingText);
    HRESULT Show(BOOL fShow);
}

@GUID("5E078E03-8265-4BBE-9487-D242EDBEF910")
interface ITipAutoCompleteClient : IUnknown
{
    HRESULT AdviseProvider(HWND hWndField, ITipAutoCompleteProvider pIProvider);
    HRESULT UnadviseProvider(HWND hWndField, ITipAutoCompleteProvider pIProvider);
    HRESULT UserSelection();
    HRESULT PreferredRects(RECT* prcACList, RECT* prcField, RECT* prcModifiedACList, int* pfShownAboveTip);
    HRESULT RequestShowUI(HWND hWndList, int* pfAllowShowing);
}


// GUIDs

const GUID CLSID_DynamicRenderer          = GUIDOF!DynamicRenderer;
const GUID CLSID_GestureRecognizer        = GUIDOF!GestureRecognizer;
const GUID CLSID_HandwrittenTextInsertion = GUIDOF!HandwrittenTextInsertion;
const GUID CLSID_Ink                      = GUIDOF!Ink;
const GUID CLSID_InkCollector             = GUIDOF!InkCollector;
const GUID CLSID_InkDisp                  = GUIDOF!InkDisp;
const GUID CLSID_InkDivider               = GUIDOF!InkDivider;
const GUID CLSID_InkDrawingAttributes     = GUIDOF!InkDrawingAttributes;
const GUID CLSID_InkEdit                  = GUIDOF!InkEdit;
const GUID CLSID_InkOverlay               = GUIDOF!InkOverlay;
const GUID CLSID_InkPicture               = GUIDOF!InkPicture;
const GUID CLSID_InkRecognizerContext     = GUIDOF!InkRecognizerContext;
const GUID CLSID_InkRecognizerGuide       = GUIDOF!InkRecognizerGuide;
const GUID CLSID_InkRecognizers           = GUIDOF!InkRecognizers;
const GUID CLSID_InkRectangle             = GUIDOF!InkRectangle;
const GUID CLSID_InkRenderer              = GUIDOF!InkRenderer;
const GUID CLSID_InkStrokes               = GUIDOF!InkStrokes;
const GUID CLSID_InkTablets               = GUIDOF!InkTablets;
const GUID CLSID_InkTransform             = GUIDOF!InkTransform;
const GUID CLSID_InkWordList              = GUIDOF!InkWordList;
const GUID CLSID_MathInputControl         = GUIDOF!MathInputControl;
const GUID CLSID_PenInputPanel            = GUIDOF!PenInputPanel;
const GUID CLSID_PenInputPanel_Internal   = GUIDOF!PenInputPanel_Internal;
const GUID CLSID_RealTimeStylus           = GUIDOF!RealTimeStylus;
const GUID CLSID_SketchInk                = GUIDOF!SketchInk;
const GUID CLSID_StrokeBuilder            = GUIDOF!StrokeBuilder;
const GUID CLSID_TextInputPanel           = GUIDOF!TextInputPanel;
const GUID CLSID_TipAutoCompleteClient    = GUIDOF!TipAutoCompleteClient;

const GUID IID_IDynamicRenderer               = GUIDOF!IDynamicRenderer;
const GUID IID_IGestureRecognizer             = GUIDOF!IGestureRecognizer;
const GUID IID_IHandwrittenTextInsertion      = GUIDOF!IHandwrittenTextInsertion;
const GUID IID_IInk                           = GUIDOF!IInk;
const GUID IID_IInkCollector                  = GUIDOF!IInkCollector;
const GUID IID_IInkCursor                     = GUIDOF!IInkCursor;
const GUID IID_IInkCursorButton               = GUIDOF!IInkCursorButton;
const GUID IID_IInkCursorButtons              = GUIDOF!IInkCursorButtons;
const GUID IID_IInkCursors                    = GUIDOF!IInkCursors;
const GUID IID_IInkCustomStrokes              = GUIDOF!IInkCustomStrokes;
const GUID IID_IInkDisp                       = GUIDOF!IInkDisp;
const GUID IID_IInkDivider                    = GUIDOF!IInkDivider;
const GUID IID_IInkDivisionResult             = GUIDOF!IInkDivisionResult;
const GUID IID_IInkDivisionUnit               = GUIDOF!IInkDivisionUnit;
const GUID IID_IInkDivisionUnits              = GUIDOF!IInkDivisionUnits;
const GUID IID_IInkDrawingAttributes          = GUIDOF!IInkDrawingAttributes;
const GUID IID_IInkEdit                       = GUIDOF!IInkEdit;
const GUID IID_IInkExtendedProperties         = GUIDOF!IInkExtendedProperties;
const GUID IID_IInkExtendedProperty           = GUIDOF!IInkExtendedProperty;
const GUID IID_IInkGesture                    = GUIDOF!IInkGesture;
const GUID IID_IInkLineInfo                   = GUIDOF!IInkLineInfo;
const GUID IID_IInkOverlay                    = GUIDOF!IInkOverlay;
const GUID IID_IInkPicture                    = GUIDOF!IInkPicture;
const GUID IID_IInkRecognitionAlternate       = GUIDOF!IInkRecognitionAlternate;
const GUID IID_IInkRecognitionAlternates      = GUIDOF!IInkRecognitionAlternates;
const GUID IID_IInkRecognitionResult          = GUIDOF!IInkRecognitionResult;
const GUID IID_IInkRecognizer                 = GUIDOF!IInkRecognizer;
const GUID IID_IInkRecognizer2                = GUIDOF!IInkRecognizer2;
const GUID IID_IInkRecognizerContext          = GUIDOF!IInkRecognizerContext;
const GUID IID_IInkRecognizerContext2         = GUIDOF!IInkRecognizerContext2;
const GUID IID_IInkRecognizerGuide            = GUIDOF!IInkRecognizerGuide;
const GUID IID_IInkRecognizers                = GUIDOF!IInkRecognizers;
const GUID IID_IInkRectangle                  = GUIDOF!IInkRectangle;
const GUID IID_IInkRenderer                   = GUIDOF!IInkRenderer;
const GUID IID_IInkStrokeDisp                 = GUIDOF!IInkStrokeDisp;
const GUID IID_IInkStrokes                    = GUIDOF!IInkStrokes;
const GUID IID_IInkTablet                     = GUIDOF!IInkTablet;
const GUID IID_IInkTablet2                    = GUIDOF!IInkTablet2;
const GUID IID_IInkTablet3                    = GUIDOF!IInkTablet3;
const GUID IID_IInkTablets                    = GUIDOF!IInkTablets;
const GUID IID_IInkTransform                  = GUIDOF!IInkTransform;
const GUID IID_IInkWordList                   = GUIDOF!IInkWordList;
const GUID IID_IInkWordList2                  = GUIDOF!IInkWordList2;
const GUID IID_IInputPanelWindowHandle        = GUIDOF!IInputPanelWindowHandle;
const GUID IID_IMathInputControl              = GUIDOF!IMathInputControl;
const GUID IID_IPenInputPanel                 = GUIDOF!IPenInputPanel;
const GUID IID_IRealTimeStylus                = GUIDOF!IRealTimeStylus;
const GUID IID_IRealTimeStylus2               = GUIDOF!IRealTimeStylus2;
const GUID IID_IRealTimeStylus3               = GUIDOF!IRealTimeStylus3;
const GUID IID_IRealTimeStylusSynchronization = GUIDOF!IRealTimeStylusSynchronization;
const GUID IID_ISketchInk                     = GUIDOF!ISketchInk;
const GUID IID_IStrokeBuilder                 = GUIDOF!IStrokeBuilder;
const GUID IID_IStylusAsyncPlugin             = GUIDOF!IStylusAsyncPlugin;
const GUID IID_IStylusPlugin                  = GUIDOF!IStylusPlugin;
const GUID IID_IStylusSyncPlugin              = GUIDOF!IStylusSyncPlugin;
const GUID IID_ITextInputPanel                = GUIDOF!ITextInputPanel;
const GUID IID_ITextInputPanelEventSink       = GUIDOF!ITextInputPanelEventSink;
const GUID IID_ITextInputPanelRunInfo         = GUIDOF!ITextInputPanelRunInfo;
const GUID IID_ITipAutoCompleteClient         = GUIDOF!ITipAutoCompleteClient;
const GUID IID_ITipAutoCompleteProvider       = GUIDOF!ITipAutoCompleteProvider;
const GUID IID__IInkCollectorEvents           = GUIDOF!_IInkCollectorEvents;
const GUID IID__IInkEditEvents                = GUIDOF!_IInkEditEvents;
const GUID IID__IInkEvents                    = GUIDOF!_IInkEvents;
const GUID IID__IInkOverlayEvents             = GUIDOF!_IInkOverlayEvents;
const GUID IID__IInkPictureEvents             = GUIDOF!_IInkPictureEvents;
const GUID IID__IInkRecognitionEvents         = GUIDOF!_IInkRecognitionEvents;
const GUID IID__IInkStrokesEvents             = GUIDOF!_IInkStrokesEvents;
const GUID IID__IMathInputControlEvents       = GUIDOF!_IMathInputControlEvents;
const GUID IID__IPenInputPanelEvents          = GUIDOF!_IPenInputPanelEvents;
