module windows.tabletpc;

public import windows.core;
public import windows.automation : BSTR, IDispatch, SAFEARRAY, VARIANT;
public import windows.com : HRESULT, IDataObject, IFontDisp, IPictureDisp, IUnknown;
public import windows.controls : NMHDR;
public import windows.displaydevices : POINT, RECT;
public import windows.gdi : XFORM;
public import windows.systemservices : BOOL;
public import windows.windowsandmessaging : HWND;

extern(Windows):


// Enums


enum : int
{
    PROPERTY_UNITS_DEFAULT     = 0x00000000,
    PROPERTY_UNITS_INCHES      = 0x00000001,
    PROPERTY_UNITS_CENTIMETERS = 0x00000002,
    PROPERTY_UNITS_DEGREES     = 0x00000003,
    PROPERTY_UNITS_RADIANS     = 0x00000004,
    PROPERTY_UNITS_SECONDS     = 0x00000005,
    PROPERTY_UNITS_POUNDS      = 0x00000006,
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
alias PROPERTY_UNITS = int;

enum : int
{
    IMF_FONT_SELECTED_IN_HDC = 0x00000001,
    IMF_ITALIC               = 0x00000002,
    IMF_BOLD                 = 0x00000004,
}
alias enumINKMETRIC_FLAGS = int;

enum : int
{
    TCF_ALLOW_RECOGNITION = 0x00000001,
    TCF_FORCE_RECOGNITION = 0x00000002,
}
alias enumGetCandidateFlags = int;

enum InkSelectionConstants : int
{
    ISC_FirstElement = 0x00000000,
    ISC_AllElements  = 0xffffffff,
}

enum InkBoundingBoxMode : int
{
    IBBM_Default    = 0x00000000,
    IBBM_NoCurveFit = 0x00000001,
    IBBM_CurveFit   = 0x00000002,
    IBBM_PointsOnly = 0x00000003,
    IBBM_Union      = 0x00000004,
}

enum InkExtractFlags : int
{
    IEF_CopyFromOriginal   = 0x00000000,
    IEF_RemoveFromOriginal = 0x00000001,
    IEF_Default            = 0x00000001,
}

enum InkPersistenceFormat : int
{
    IPF_InkSerializedFormat       = 0x00000000,
    IPF_Base64InkSerializedFormat = 0x00000001,
    IPF_GIF                       = 0x00000002,
    IPF_Base64GIF                 = 0x00000003,
}

enum InkPersistenceCompressionMode : int
{
    IPCM_Default            = 0x00000000,
    IPCM_MaximumCompression = 0x00000001,
    IPCM_NoCompression      = 0x00000002,
}

enum InkPenTip : int
{
    IPT_Ball      = 0x00000000,
    IPT_Rectangle = 0x00000001,
}

enum InkRasterOperation : int
{
    IRO_Black       = 0x00000001,
    IRO_NotMergePen = 0x00000002,
    IRO_MaskNotPen  = 0x00000003,
    IRO_NotCopyPen  = 0x00000004,
    IRO_MaskPenNot  = 0x00000005,
    IRO_Not         = 0x00000006,
    IRO_XOrPen      = 0x00000007,
    IRO_NotMaskPen  = 0x00000008,
    IRO_MaskPen     = 0x00000009,
    IRO_NotXOrPen   = 0x0000000a,
    IRO_NoOperation = 0x0000000b,
    IRO_MergeNotPen = 0x0000000c,
    IRO_CopyPen     = 0x0000000d,
    IRO_MergePenNot = 0x0000000e,
    IRO_MergePen    = 0x0000000f,
    IRO_White       = 0x00000010,
}

enum InkMousePointer : int
{
    IMP_Default        = 0x00000000,
    IMP_Arrow          = 0x00000001,
    IMP_Crosshair      = 0x00000002,
    IMP_Ibeam          = 0x00000003,
    IMP_SizeNESW       = 0x00000004,
    IMP_SizeNS         = 0x00000005,
    IMP_SizeNWSE       = 0x00000006,
    IMP_SizeWE         = 0x00000007,
    IMP_UpArrow        = 0x00000008,
    IMP_Hourglass      = 0x00000009,
    IMP_NoDrop         = 0x0000000a,
    IMP_ArrowHourglass = 0x0000000b,
    IMP_ArrowQuestion  = 0x0000000c,
    IMP_SizeAll        = 0x0000000d,
    IMP_Hand           = 0x0000000e,
    IMP_Custom         = 0x00000063,
}

enum InkClipboardModes : int
{
    ICB_Copy        = 0x00000000,
    ICB_Cut         = 0x00000001,
    ICB_ExtractOnly = 0x00000030,
    ICB_DelayedCopy = 0x00000020,
    ICB_Default     = 0x00000000,
}

enum InkClipboardFormats : int
{
    ICF_None                = 0x00000000,
    ICF_InkSerializedFormat = 0x00000001,
    ICF_SketchInk           = 0x00000002,
    ICF_TextInk             = 0x00000006,
    ICF_EnhancedMetafile    = 0x00000008,
    ICF_Metafile            = 0x00000020,
    ICF_Bitmap              = 0x00000040,
    ICF_PasteMask           = 0x00000007,
    ICF_CopyMask            = 0x0000007f,
    ICF_Default             = 0x0000007f,
}

enum SelectionHitResult : int
{
    SHR_None      = 0x00000000,
    SHR_NW        = 0x00000001,
    SHR_SE        = 0x00000002,
    SHR_NE        = 0x00000003,
    SHR_SW        = 0x00000004,
    SHR_E         = 0x00000005,
    SHR_W         = 0x00000006,
    SHR_N         = 0x00000007,
    SHR_S         = 0x00000008,
    SHR_Selection = 0x00000009,
}

enum InkRecognitionStatus : int
{
    IRS_NoError                     = 0x00000000,
    IRS_Interrupted                 = 0x00000001,
    IRS_ProcessFailed               = 0x00000002,
    IRS_InkAddedFailed              = 0x00000004,
    IRS_SetAutoCompletionModeFailed = 0x00000008,
    IRS_SetStrokesFailed            = 0x00000010,
    IRS_SetGuideFailed              = 0x00000020,
    IRS_SetFlagsFailed              = 0x00000040,
    IRS_SetFactoidFailed            = 0x00000080,
    IRS_SetPrefixSuffixFailed       = 0x00000100,
    IRS_SetWordListFailed           = 0x00000200,
}

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
alias DISPID_InkRectangle = int;

enum : int
{
    DISPID_IEPGuid = 0x00000001,
    DISPID_IEPData = 0x00000002,
}
alias DISPID_InkExtendedProperty = int;

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
alias DISPID_InkExtendedProperties = int;

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
alias DISPID_InkDrawingAttributes = int;

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
alias DISPID_InkTransform = int;

enum InkApplicationGesture : int
{
    IAG_AllGestures     = 0x00000000,
    IAG_NoGesture       = 0x0000f000,
    IAG_Scratchout      = 0x0000f001,
    IAG_Triangle        = 0x0000f002,
    IAG_Square          = 0x0000f003,
    IAG_Star            = 0x0000f004,
    IAG_Check           = 0x0000f005,
    IAG_Curlicue        = 0x0000f010,
    IAG_DoubleCurlicue  = 0x0000f011,
    IAG_Circle          = 0x0000f020,
    IAG_DoubleCircle    = 0x0000f021,
    IAG_SemiCircleLeft  = 0x0000f028,
    IAG_SemiCircleRight = 0x0000f029,
    IAG_ChevronUp       = 0x0000f030,
    IAG_ChevronDown     = 0x0000f031,
    IAG_ChevronLeft     = 0x0000f032,
    IAG_ChevronRight    = 0x0000f033,
    IAG_ArrowUp         = 0x0000f038,
    IAG_ArrowDown       = 0x0000f039,
    IAG_ArrowLeft       = 0x0000f03a,
    IAG_ArrowRight      = 0x0000f03b,
    IAG_Up              = 0x0000f058,
    IAG_Down            = 0x0000f059,
    IAG_Left            = 0x0000f05a,
    IAG_Right           = 0x0000f05b,
    IAG_UpDown          = 0x0000f060,
    IAG_DownUp          = 0x0000f061,
    IAG_LeftRight       = 0x0000f062,
    IAG_RightLeft       = 0x0000f063,
    IAG_UpLeftLong      = 0x0000f064,
    IAG_UpRightLong     = 0x0000f065,
    IAG_DownLeftLong    = 0x0000f066,
    IAG_DownRightLong   = 0x0000f067,
    IAG_UpLeft          = 0x0000f068,
    IAG_UpRight         = 0x0000f069,
    IAG_DownLeft        = 0x0000f06a,
    IAG_DownRight       = 0x0000f06b,
    IAG_LeftUp          = 0x0000f06c,
    IAG_LeftDown        = 0x0000f06d,
    IAG_RightUp         = 0x0000f06e,
    IAG_RightDown       = 0x0000f06f,
    IAG_Exclamation     = 0x0000f0a4,
    IAG_Tap             = 0x0000f0f0,
    IAG_DoubleTap       = 0x0000f0f1,
}

enum InkSystemGesture : int
{
    ISG_Tap        = 0x00000010,
    ISG_DoubleTap  = 0x00000011,
    ISG_RightTap   = 0x00000012,
    ISG_Drag       = 0x00000013,
    ISG_RightDrag  = 0x00000014,
    ISG_HoldEnter  = 0x00000015,
    ISG_HoldLeave  = 0x00000016,
    ISG_HoverEnter = 0x00000017,
    ISG_HoverLeave = 0x00000018,
    ISG_Flick      = 0x0000001f,
}

enum InkRecognitionConfidence : int
{
    IRC_Strong       = 0x00000000,
    IRC_Intermediate = 0x00000001,
    IRC_Poor         = 0x00000002,
}

enum : int
{
    DISPID_IGId          = 0x00000000,
    DISPID_IGGetHotPoint = 0x00000001,
    DISPID_IGConfidence  = 0x00000002,
}
alias DISPID_InkGesture = int;

enum : int
{
    DISPID_ICsrName              = 0x00000000,
    DISPID_ICsrId                = 0x00000001,
    DISPID_ICsrDrawingAttributes = 0x00000002,
    DISPID_ICsrButtons           = 0x00000003,
    DISPID_ICsrInverted          = 0x00000004,
    DISPID_ICsrTablet            = 0x00000005,
}
alias DISPID_InkCursor = int;

enum : int
{
    DISPID_ICs_NewEnum = 0xfffffffc,
    DISPID_ICsItem     = 0x00000000,
    DISPID_ICsCount    = 0x00000001,
}
alias DISPID_InkCursors = int;

enum InkCursorButtonState : int
{
    ICBS_Unavailable = 0x00000000,
    ICBS_Up          = 0x00000001,
    ICBS_Down        = 0x00000002,
}

enum : int
{
    DISPID_ICBName  = 0x00000000,
    DISPID_ICBId    = 0x00000001,
    DISPID_ICBState = 0x00000002,
}
alias DISPID_InkCursorButton = int;

enum : int
{
    DISPID_ICBs_NewEnum = 0xfffffffc,
    DISPID_ICBsItem     = 0x00000000,
    DISPID_ICBsCount    = 0x00000001,
}
alias DISPID_InkCursorButtons = int;

enum TabletHardwareCapabilities : int
{
    THWC_Integrated             = 0x00000001,
    THWC_CursorMustTouch        = 0x00000002,
    THWC_HardProximity          = 0x00000004,
    THWC_CursorsHavePhysicalIds = 0x00000008,
}

enum TabletPropertyMetricUnit : int
{
    TPMU_Default     = 0x00000000,
    TPMU_Inches      = 0x00000001,
    TPMU_Centimeters = 0x00000002,
    TPMU_Degrees     = 0x00000003,
    TPMU_Radians     = 0x00000004,
    TPMU_Seconds     = 0x00000005,
    TPMU_Pounds      = 0x00000006,
    TPMU_Grams       = 0x00000007,
}

enum : int
{
    DISPID_ITName                      = 0x00000000,
    DISPID_ITPlugAndPlayId             = 0x00000001,
    DISPID_ITPropertyMetrics           = 0x00000002,
    DISPID_ITIsPacketPropertySupported = 0x00000003,
    DISPID_ITMaximumInputRectangle     = 0x00000004,
    DISPID_ITHardwareCapabilities      = 0x00000005,
}
alias DISPID_InkTablet = int;

enum TabletDeviceKind : int
{
    TDK_Mouse = 0x00000000,
    TDK_Pen   = 0x00000001,
    TDK_Touch = 0x00000002,
}

enum : int
{
    DISPID_IT2DeviceKind = 0x00000000,
}
alias DISPID_InkTablet2 = int;

enum : int
{
    DISPID_IT3IsMultiTouch   = 0x00000000,
    DISPID_IT3MaximumCursors = 0x00000001,
}
alias DISPID_InkTablet3 = int;

enum : int
{
    DISPID_ITs_NewEnum                  = 0xfffffffc,
    DISPID_ITsItem                      = 0x00000000,
    DISPID_ITsDefaultTablet             = 0x00000001,
    DISPID_ITsCount                     = 0x00000002,
    DISPID_ITsIsPacketPropertySupported = 0x00000003,
}
alias DISPID_InkTablets = int;

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
alias DISPID_InkStrokeDisp = int;

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
alias DISPID_InkStrokes = int;

enum : int
{
    DISPID_ICSs_NewEnum = 0xfffffffc,
    DISPID_ICSsItem     = 0x00000000,
    DISPID_ICSsCount    = 0x00000001,
    DISPID_ICSsAdd      = 0x00000002,
    DISPID_ICSsRemove   = 0x00000003,
    DISPID_ICSsClear    = 0x00000004,
}
alias DISPID_InkCustomStrokes = int;

enum : int
{
    DISPID_SEStrokesAdded   = 0x00000001,
    DISPID_SEStrokesRemoved = 0x00000002,
}
alias DISPID_StrokeEvent = int;

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
alias DISPID_Ink = int;

enum : int
{
    DISPID_IEInkAdded   = 0x00000001,
    DISPID_IEInkDeleted = 0x00000002,
}
alias DISPID_InkEvent = int;

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
alias DISPID_InkRenderer = int;

enum InkCollectorEventInterest : int
{
    ICEI_DefaultEvents    = 0xffffffff,
    ICEI_CursorDown       = 0x00000000,
    ICEI_Stroke           = 0x00000001,
    ICEI_NewPackets       = 0x00000002,
    ICEI_NewInAirPackets  = 0x00000003,
    ICEI_CursorButtonDown = 0x00000004,
    ICEI_CursorButtonUp   = 0x00000005,
    ICEI_CursorInRange    = 0x00000006,
    ICEI_CursorOutOfRange = 0x00000007,
    ICEI_SystemGesture    = 0x00000008,
    ICEI_TabletAdded      = 0x00000009,
    ICEI_TabletRemoved    = 0x0000000a,
    ICEI_MouseDown        = 0x0000000b,
    ICEI_MouseMove        = 0x0000000c,
    ICEI_MouseUp          = 0x0000000d,
    ICEI_MouseWheel       = 0x0000000e,
    ICEI_DblClick         = 0x0000000f,
    ICEI_AllEvents        = 0x00000010,
}

enum InkMouseButton : int
{
    IMF_Left   = 0x00000001,
    IMF_Right  = 0x00000002,
    IMF_Middle = 0x00000004,
}

enum InkShiftKeyModifierFlags : int
{
    IKM_Shift   = 0x00000001,
    IKM_Control = 0x00000002,
    IKM_Alt     = 0x00000004,
}

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
alias DISPID_InkCollectorEvent = int;

enum InkOverlayEditingMode : int
{
    IOEM_Ink    = 0x00000000,
    IOEM_Delete = 0x00000001,
    IOEM_Select = 0x00000002,
}

enum InkOverlayAttachMode : int
{
    IOAM_Behind  = 0x00000000,
    IOAM_InFront = 0x00000001,
}

enum InkPictureSizeMode : int
{
    IPSM_AutoSize     = 0x00000000,
    IPSM_CenterImage  = 0x00000001,
    IPSM_Normal       = 0x00000002,
    IPSM_StretchImage = 0x00000003,
}

enum InkOverlayEraserMode : int
{
    IOERM_StrokeErase = 0x00000000,
    IOERM_PointErase  = 0x00000001,
}

enum InkCollectionMode : int
{
    ICM_InkOnly       = 0x00000000,
    ICM_GestureOnly   = 0x00000001,
    ICM_InkAndGesture = 0x00000002,
}

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
alias DISPID_InkCollector = int;

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
alias DISPID_InkRecognizer = int;

enum InkRecognizerCapabilities : int
{
    IRC_DontCare                     = 0x00000001,
    IRC_Object                       = 0x00000002,
    IRC_FreeInput                    = 0x00000004,
    IRC_LinedInput                   = 0x00000008,
    IRC_BoxedInput                   = 0x00000010,
    IRC_CharacterAutoCompletionInput = 0x00000020,
    IRC_RightAndDown                 = 0x00000040,
    IRC_LeftAndDown                  = 0x00000080,
    IRC_DownAndLeft                  = 0x00000100,
    IRC_DownAndRight                 = 0x00000200,
    IRC_ArbitraryAngle               = 0x00000400,
    IRC_Lattice                      = 0x00000800,
    IRC_AdviseInkChange              = 0x00001000,
    IRC_StrokeReorder                = 0x00002000,
    IRC_Personalizable               = 0x00004000,
    IRC_PrefersArbitraryAngle        = 0x00008000,
    IRC_PrefersParagraphBreaking     = 0x00010000,
    IRC_PrefersSegmentation          = 0x00020000,
    IRC_Cursive                      = 0x00040000,
    IRC_TextPrediction               = 0x00080000,
    IRC_Alpha                        = 0x00100000,
    IRC_Beta                         = 0x00200000,
}

enum : int
{
    DISPID_RecoId            = 0x00000000,
    DISPID_RecoUnicodeRanges = 0x00000001,
}
alias DISPID_InkRecognizer2 = int;

enum : int
{
    DISPID_IRecos_NewEnum             = 0xfffffffc,
    DISPID_IRecosItem                 = 0x00000000,
    DISPID_IRecosCount                = 0x00000001,
    DISPID_IRecosGetDefaultRecognizer = 0x00000002,
}
alias DISPID_InkRecognizers = int;

enum InkRecognizerCharacterAutoCompletionMode : int
{
    IRCACM_Full   = 0x00000000,
    IRCACM_Prefix = 0x00000001,
    IRCACM_Random = 0x00000002,
}

enum InkRecognitionModes : int
{
    IRM_None                   = 0x00000000,
    IRM_WordModeOnly           = 0x00000001,
    IRM_Coerce                 = 0x00000002,
    IRM_TopInkBreaksOnly       = 0x00000004,
    IRM_PrefixOk               = 0x00000008,
    IRM_LineMode               = 0x00000010,
    IRM_DisablePersonalization = 0x00000020,
    IRM_AutoSpace              = 0x00000040,
    IRM_Max                    = 0x00000080,
}

enum : int
{
    DISPID_IRERecognitionWithAlternates = 0x00000001,
    DISPID_IRERecognition               = 0x00000002,
}
alias DISPID_InkRecognitionEvent = int;

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
alias DISPID_InkRecoContext = int;

enum : int
{
    DISPID_IRecoCtx2_EnabledUnicodeRanges = 0x00000000,
}
alias DISPID_InkRecoContext2 = int;

enum InkRecognitionAlternatesSelection : int
{
    IRAS_Start        = 0x00000000,
    IRAS_DefaultCount = 0x0000000a,
    IRAS_All          = 0xffffffff,
}

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
alias DISPID_InkRecognitionResult = int;

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
alias DISPID_InkRecoAlternate = int;

enum : int
{
    DISPID_InkRecognitionAlternates_NewEnum = 0xfffffffc,
    DISPID_InkRecognitionAlternates_Item    = 0x00000000,
    DISPID_InkRecognitionAlternates_Count   = 0x00000001,
    DISPID_InkRecognitionAlternates_Strokes = 0x00000002,
}
alias DISPID_InkRecognitionAlternates = int;

enum : int
{
    DISPID_IRGWritingBox = 0x00000001,
    DISPID_IRGDrawnBox   = 0x00000002,
    DISPID_IRGRows       = 0x00000003,
    DISPID_IRGColumns    = 0x00000004,
    DISPID_IRGMidline    = 0x00000005,
    DISPID_IRGGuideData  = 0x00000006,
}
alias DISPID_InkRecognizerGuide = int;

enum : int
{
    DISPID_InkWordList_AddWord    = 0x00000000,
    DISPID_InkWordList_RemoveWord = 0x00000001,
    DISPID_InkWordList_Merge      = 0x00000002,
}
alias DISPID_InkWordList = int;

enum : int
{
    DISPID_InkWordList2_AddWords = 0x00000003,
}
alias DISPID_InkWordList2 = int;

enum InkDivisionType : int
{
    IDT_Segment   = 0x00000000,
    IDT_Line      = 0x00000001,
    IDT_Paragraph = 0x00000002,
    IDT_Drawing   = 0x00000003,
}

enum : int
{
    DISPID_IInkDivider_Strokes           = 0x00000001,
    DISPID_IInkDivider_RecognizerContext = 0x00000002,
    DISPID_IInkDivider_LineHeight        = 0x00000003,
    DISPID_IInkDivider_Divide            = 0x00000004,
}
alias DISPID_InkDivider = int;

enum : int
{
    DISPID_IInkDivisionResult_Strokes      = 0x00000001,
    DISPID_IInkDivisionResult_ResultByType = 0x00000002,
}
alias DISPID_InkDivisionResult = int;

enum : int
{
    DISPID_IInkDivisionUnit_Strokes           = 0x00000001,
    DISPID_IInkDivisionUnit_DivisionType      = 0x00000002,
    DISPID_IInkDivisionUnit_RecognizedString  = 0x00000003,
    DISPID_IInkDivisionUnit_RotationTransform = 0x00000004,
}
alias DISPID_InkDivisionUnit = int;

enum : int
{
    DISPID_IInkDivisionUnits_NewEnum = 0xfffffffc,
    DISPID_IInkDivisionUnits_Item    = 0x00000000,
    DISPID_IInkDivisionUnits_Count   = 0x00000001,
}
alias DISPID_InkDivisionUnits = int;

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
alias DISPID_PenInputPanel = int;

enum : int
{
    DISPID_PIPEVisibleChanged = 0x00000000,
    DISPID_PIPEPanelChanged   = 0x00000001,
    DISPID_PIPEInputFailed    = 0x00000002,
    DISPID_PIPEPanelMoving    = 0x00000003,
}
alias DISPID_PenInputPanelEvents = int;

enum VisualState : int
{
    InPlace      = 0x00000000,
    Floating     = 0x00000001,
    DockedTop    = 0x00000002,
    DockedBottom = 0x00000003,
    Closed       = 0x00000004,
}

enum InteractionMode : int
{
    InteractionMode_InPlace      = 0x00000000,
    InteractionMode_Floating     = 0x00000001,
    InteractionMode_DockedTop    = 0x00000002,
    InteractionMode_DockedBottom = 0x00000003,
}

enum InPlaceState : int
{
    InPlaceState_Auto        = 0x00000000,
    InPlaceState_HoverTarget = 0x00000001,
    InPlaceState_Expanded    = 0x00000002,
}

enum PanelInputArea : int
{
    PanelInputArea_Auto         = 0x00000000,
    PanelInputArea_Keyboard     = 0x00000001,
    PanelInputArea_WritingPad   = 0x00000002,
    PanelInputArea_CharacterPad = 0x00000003,
}

enum CorrectionMode : int
{
    CorrectionMode_NotVisible             = 0x00000000,
    CorrectionMode_PreInsertion           = 0x00000001,
    CorrectionMode_PostInsertionCollapsed = 0x00000002,
    CorrectionMode_PostInsertionExpanded  = 0x00000003,
}

enum CorrectionPosition : int
{
    CorrectionPosition_Auto   = 0x00000000,
    CorrectionPosition_Bottom = 0x00000001,
    CorrectionPosition_Top    = 0x00000002,
}

enum InPlaceDirection : int
{
    InPlaceDirection_Auto   = 0x00000000,
    InPlaceDirection_Bottom = 0x00000001,
    InPlaceDirection_Top    = 0x00000002,
}

enum EventMask : int
{
    EventMask_InPlaceStateChanging      = 0x00000001,
    EventMask_InPlaceStateChanged       = 0x00000002,
    EventMask_InPlaceSizeChanging       = 0x00000004,
    EventMask_InPlaceSizeChanged        = 0x00000008,
    EventMask_InputAreaChanging         = 0x00000010,
    EventMask_InputAreaChanged          = 0x00000020,
    EventMask_CorrectionModeChanging    = 0x00000040,
    EventMask_CorrectionModeChanged     = 0x00000080,
    EventMask_InPlaceVisibilityChanging = 0x00000100,
    EventMask_InPlaceVisibilityChanged  = 0x00000200,
    EventMask_TextInserting             = 0x00000400,
    EventMask_TextInserted              = 0x00000800,
    EventMask_All                       = 0x00000fff,
}

enum PanelType : int
{
    PT_Default     = 0x00000000,
    PT_Inactive    = 0x00000001,
    PT_Handwriting = 0x00000002,
    PT_Keyboard    = 0x00000003,
}

enum : int
{
    FLICKDIRECTION_MIN       = 0x00000000,
    FLICKDIRECTION_RIGHT     = 0x00000000,
    FLICKDIRECTION_UPRIGHT   = 0x00000001,
    FLICKDIRECTION_UP        = 0x00000002,
    FLICKDIRECTION_UPLEFT    = 0x00000003,
    FLICKDIRECTION_LEFT      = 0x00000004,
    FLICKDIRECTION_DOWNLEFT  = 0x00000005,
    FLICKDIRECTION_DOWN      = 0x00000006,
    FLICKDIRECTION_DOWNRIGHT = 0x00000007,
    FLICKDIRECTION_INVALID   = 0x00000008,
}
alias FLICKDIRECTION = int;

enum : int
{
    FLICKMODE_MIN      = 0x00000000,
    FLICKMODE_OFF      = 0x00000000,
    FLICKMODE_ON       = 0x00000001,
    FLICKMODE_LEARNING = 0x00000002,
    FLICKMODE_MAX      = 0x00000002,
    FLICKMODE_DEFAULT  = 0x00000001,
}
alias FLICKMODE = int;

enum : int
{
    FLICKACTION_COMMANDCODE_NULL        = 0x00000000,
    FLICKACTION_COMMANDCODE_SCROLL      = 0x00000001,
    FLICKACTION_COMMANDCODE_APPCOMMAND  = 0x00000002,
    FLICKACTION_COMMANDCODE_CUSTOMKEY   = 0x00000003,
    FLICKACTION_COMMANDCODE_KEYMODIFIER = 0x00000004,
}
alias FLICKACTION_COMMANDCODE = int;

enum : int
{
    SCROLLDIRECTION_UP   = 0x00000000,
    SCROLLDIRECTION_DOWN = 0x00000001,
}
alias SCROLLDIRECTION = int;

enum : int
{
    KEYMODIFIER_CONTROL = 0x00000001,
    KEYMODIFIER_MENU    = 0x00000002,
    KEYMODIFIER_SHIFT   = 0x00000004,
    KEYMODIFIER_WIN     = 0x00000008,
    KEYMODIFIER_ALTGR   = 0x00000010,
    KEYMODIFIER_EXT     = 0x00000020,
}
alias KEYMODIFIER = int;

enum MouseButton : int
{
    NO_BUTTON     = 0x00000000,
    LEFT_BUTTON   = 0x00000001,
    RIGHT_BUTTON  = 0x00000002,
    MIDDLE_BUTTON = 0x00000004,
}

enum SelAlignmentConstants : int
{
    rtfLeft   = 0x00000000,
    rtfRight  = 0x00000001,
    rtfCenter = 0x00000002,
}

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
alias DISPID_InkEdit = int;

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
alias DISPID_InkEditEvents = int;

enum InkMode : int
{
    IEM_Disabled      = 0x00000000,
    IEM_Ink           = 0x00000001,
    IEM_InkAndGesture = 0x00000002,
}

enum InkInsertMode : int
{
    IEM_InsertText = 0x00000000,
    IEM_InsertInk  = 0x00000001,
}

enum InkEditStatus : int
{
    IES_Idle        = 0x00000000,
    IES_Collecting  = 0x00000001,
    IES_Recognizing = 0x00000002,
}

enum InkDisplayMode : int
{
    IDM_Ink  = 0x00000000,
    IDM_Text = 0x00000001,
}

enum AppearanceConstants : int
{
    rtfFlat   = 0x00000000,
    rtfThreeD = 0x00000001,
}

enum BorderStyleConstants : int
{
    rtfNoBorder    = 0x00000000,
    rtfFixedSingle = 0x00000001,
}

enum ScrollBarsConstants : int
{
    rtfNone       = 0x00000000,
    rtfHorizontal = 0x00000001,
    rtfVertical   = 0x00000002,
    rtfBoth       = 0x00000003,
}

enum : int
{
    MICUIELEMENT_BUTTON_WRITE           = 0x00000001,
    MICUIELEMENT_BUTTON_ERASE           = 0x00000002,
    MICUIELEMENT_BUTTON_CORRECT         = 0x00000004,
    MICUIELEMENT_BUTTON_CLEAR           = 0x00000008,
    MICUIELEMENT_BUTTON_UNDO            = 0x00000010,
    MICUIELEMENT_BUTTON_REDO            = 0x00000020,
    MICUIELEMENT_BUTTON_INSERT          = 0x00000040,
    MICUIELEMENT_BUTTON_CANCEL          = 0x00000080,
    MICUIELEMENT_INKPANEL_BACKGROUND    = 0x00000100,
    MICUIELEMENT_RESULTPANEL_BACKGROUND = 0x00000200,
}
alias MICUIELEMENT = int;

enum : int
{
    MICUIELEMENTSTATE_NORMAL   = 0x00000001,
    MICUIELEMENTSTATE_HOT      = 0x00000002,
    MICUIELEMENTSTATE_PRESSED  = 0x00000003,
    MICUIELEMENTSTATE_DISABLED = 0x00000004,
}
alias MICUIELEMENTSTATE = int;

enum : int
{
    DISPID_MICInsert = 0x00000000,
    DISPID_MICClose  = 0x00000001,
    DISPID_MICPaint  = 0x00000002,
    DISPID_MICClear  = 0x00000003,
}
alias DISPID_MathInputControlEvents = int;

enum RealTimeStylusDataInterest : int
{
    RTSDI_AllData                = 0xffffffff,
    RTSDI_None                   = 0x00000000,
    RTSDI_Error                  = 0x00000001,
    RTSDI_RealTimeStylusEnabled  = 0x00000002,
    RTSDI_RealTimeStylusDisabled = 0x00000004,
    RTSDI_StylusNew              = 0x00000008,
    RTSDI_StylusInRange          = 0x00000010,
    RTSDI_InAirPackets           = 0x00000020,
    RTSDI_StylusOutOfRange       = 0x00000040,
    RTSDI_StylusDown             = 0x00000080,
    RTSDI_Packets                = 0x00000100,
    RTSDI_StylusUp               = 0x00000200,
    RTSDI_StylusButtonUp         = 0x00000400,
    RTSDI_StylusButtonDown       = 0x00000800,
    RTSDI_SystemEvents           = 0x00001000,
    RTSDI_TabletAdded            = 0x00002000,
    RTSDI_TabletRemoved          = 0x00004000,
    RTSDI_CustomStylusDataAdded  = 0x00008000,
    RTSDI_UpdateMapping          = 0x00010000,
    RTSDI_DefaultEvents          = 0x00009386,
}

enum StylusQueue : int
{
    SyncStylusQueue           = 0x00000001,
    AsyncStylusQueueImmediate = 0x00000002,
    AsyncStylusQueue          = 0x00000003,
}

enum RealTimeStylusLockType : int
{
    RTSLT_ObjLock         = 0x00000001,
    RTSLT_SyncEventLock   = 0x00000002,
    RTSLT_AsyncEventLock  = 0x00000004,
    RTSLT_ExcludeCallback = 0x00000008,
    RTSLT_SyncObjLock     = 0x0000000b,
    RTSLT_AsyncObjLock    = 0x0000000d,
}

enum : int
{
    LM_BASELINE  = 0x00000000,
    LM_MIDLINE   = 0x00000001,
    LM_ASCENDER  = 0x00000002,
    LM_DESCENDER = 0x00000003,
}
alias LINE_METRICS = int;

enum : int
{
    CFL_STRONG       = 0x00000000,
    CFL_INTERMEDIATE = 0x00000001,
    CFL_POOR         = 0x00000002,
}
alias CONFIDENCE_LEVEL = int;

enum : int
{
    ALT_BREAKS_SAME   = 0x00000000,
    ALT_BREAKS_UNIQUE = 0x00000001,
    ALT_BREAKS_FULL   = 0x00000002,
}
alias ALT_BREAKS = int;

enum : int
{
    RECO_TYPE_WSTRING = 0x00000000,
    RECO_TYPE_WCHAR   = 0x00000001,
}
alias enumRECO_TYPE = int;

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


struct SYSTEM_EVENT_DATA
{
    ubyte  bModifier;
    ushort wKey;
    int    xPos;
    int    yPos;
    ubyte  bCursorMode;
    uint   dwButtonState;
}

struct STROKE_RANGE
{
    uint iStrokeBegin;
    uint iStrokeEnd;
}

struct PROPERTY_METRICS
{
    int            nLogicalMin;
    int            nLogicalMax;
    PROPERTY_UNITS Units;
    float          fResolution;
}

struct PACKET_PROPERTY
{
    GUID             guid;
    PROPERTY_METRICS PropertyMetrics;
}

struct PACKET_DESCRIPTION
{
    uint             cbPacketSize;
    uint             cPacketProperties;
    PACKET_PROPERTY* pPacketProperties;
    uint             cButtons;
    GUID*            pguidButtons;
}

struct INKMETRIC
{
    int  iHeight;
    int  iFontAscent;
    int  iFontDescent;
    uint dwFlags;
    uint color;
}

struct InkRecoGuide
{
    RECT rectWritingBox;
    RECT rectDrawnBox;
    int  cRows;
    int  cColumns;
    int  midline;
}

struct FLICK_POINT
{
    int _bitfield172;
}

struct FLICK_DATA
{
    int _bitfield173;
}

struct IEC_STROKEINFO
{
    NMHDR          nmhdr;
    IInkCursor     Cursor;
    IInkStrokeDisp Stroke;
}

struct IEC_GESTUREINFO
{
    NMHDR       nmhdr;
    IInkCursor  Cursor;
    IInkStrokes Strokes;
    VARIANT     Gestures;
}

struct IEC_RECOGNITIONRESULTINFO
{
    NMHDR nmhdr;
    IInkRecognitionResult RecognitionResult;
}

struct StylusInfo
{
    uint tcid;
    uint cid;
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

struct RECO_GUIDE
{
    int xOrigin;
    int yOrigin;
    int cxBox;
    int cyBox;
    int cxBase;
    int cyBase;
    int cHorzBox;
    int cVertBox;
    int cyMid;
}

struct RECO_ATTRS
{
    uint       dwRecoCapabilityFlags;
    ushort[32] awcVendorName;
    ushort[64] awcFriendlyName;
    ushort[64] awLanguageId;
}

struct RECO_RANGE
{
    uint iwcBegin;
    uint cCount;
}

struct LINE_SEGMENT
{
    POINT PtA;
    POINT PtB;
}

struct LATTICE_METRICS
{
    LINE_SEGMENT lsBaseline;
    short        iMidlineOffset;
}

struct RECO_LATTICE_PROPERTY
{
    GUID   guidProperty;
    ushort cbPropertyValue;
    ubyte* pPropertyValue;
}

struct RECO_LATTICE_PROPERTIES
{
    uint cProperties;
    RECO_LATTICE_PROPERTY** apProps;
}

struct RECO_LATTICE_ELEMENT
{
    int    score;
    ushort type;
    ubyte* pData;
    uint   ulNextColumn;
    uint   ulStrokeNumber;
    RECO_LATTICE_PROPERTIES epProp;
}

struct RECO_LATTICE_COLUMN
{
    uint  key;
    RECO_LATTICE_PROPERTIES cpProp;
    uint  cStrokes;
    uint* pStrokes;
    uint  cLatticeElements;
    RECO_LATTICE_ELEMENT* pLatticeElements;
}

struct RECO_LATTICE
{
    uint                 ulColumnCount;
    RECO_LATTICE_COLUMN* pLatticeColumns;
    uint                 ulPropertyCount;
    GUID*                pGuidProperties;
    uint                 ulBestResultColumnCount;
    uint*                pulBestResultColumns;
    uint*                pulBestResultIndexes;
}

struct CHARACTER_RANGE
{
    ushort wcLow;
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

@DllImport("inkobjcore")
HRESULT CreateRecognizer(GUID* pCLSID, HRECOGNIZER__** phrec);

@DllImport("inkobjcore")
HRESULT DestroyRecognizer(HRECOGNIZER__* hrec);

@DllImport("inkobjcore")
HRESULT GetRecoAttributes(HRECOGNIZER__* hrec, RECO_ATTRS* pRecoAttrs);

@DllImport("inkobjcore")
HRESULT CreateContext(HRECOGNIZER__* hrec, HRECOCONTEXT__** phrc);

@DllImport("inkobjcore")
HRESULT DestroyContext(HRECOCONTEXT__* hrc);

@DllImport("inkobjcore")
HRESULT GetResultPropertyList(HRECOGNIZER__* hrec, uint* pPropertyCount, GUID* pPropertyGuid);

@DllImport("inkobjcore")
HRESULT GetUnicodeRanges(HRECOGNIZER__* hrec, uint* pcRanges, CHARACTER_RANGE* pcr);

@DllImport("inkobjcore")
HRESULT AddStroke(HRECOCONTEXT__* hrc, const(PACKET_DESCRIPTION)* pPacketDesc, uint cbPacket, 
                  const(ubyte)* pPacket, const(XFORM)* pXForm);

@DllImport("inkobjcore")
HRESULT GetBestResultString(HRECOCONTEXT__* hrc, uint* pcSize, char* pwcBestResult);

@DllImport("inkobjcore")
HRESULT SetGuide(HRECOCONTEXT__* hrc, const(RECO_GUIDE)* pGuide, uint iIndex);

@DllImport("inkobjcore")
HRESULT AdviseInkChange(HRECOCONTEXT__* hrc, BOOL bNewStroke);

@DllImport("inkobjcore")
HRESULT EndInkInput(HRECOCONTEXT__* hrc);

@DllImport("inkobjcore")
HRESULT Process(HRECOCONTEXT__* hrc, int* pbPartialProcessing);

@DllImport("inkobjcore")
HRESULT SetFactoid(HRECOCONTEXT__* hrc, uint cwcFactoid, const(wchar)* pwcFactoid);

@DllImport("inkobjcore")
HRESULT SetFlags(HRECOCONTEXT__* hrc, uint dwFlags);

@DllImport("inkobjcore")
HRESULT GetLatticePtr(HRECOCONTEXT__* hrc, RECO_LATTICE** ppLattice);

@DllImport("inkobjcore")
HRESULT SetTextContext(HRECOCONTEXT__* hrc, uint cwcBefore, const(wchar)* pwcBefore, uint cwcAfter, 
                       const(wchar)* pwcAfter);

@DllImport("inkobjcore")
HRESULT SetEnabledUnicodeRanges(HRECOCONTEXT__* hrc, uint cRanges, CHARACTER_RANGE* pcr);

@DllImport("inkobjcore")
HRESULT IsStringSupported(HRECOCONTEXT__* hrc, uint wcString, const(wchar)* pwcString);

@DllImport("inkobjcore")
HRESULT SetWordList(HRECOCONTEXT__* hrc, HRECOWORDLIST__* hwl);

@DllImport("inkobjcore")
HRESULT GetRightSeparator(HRECOCONTEXT__* hrc, uint* pcSize, char* pwcRightSeparator);

@DllImport("inkobjcore")
HRESULT GetLeftSeparator(HRECOCONTEXT__* hrc, uint* pcSize, char* pwcLeftSeparator);

@DllImport("inkobjcore")
HRESULT DestroyWordList(HRECOWORDLIST__* hwl);

@DllImport("inkobjcore")
HRESULT AddWordsToWordList(HRECOWORDLIST__* hwl, char* pwcWords);

@DllImport("inkobjcore")
HRESULT MakeWordList(HRECOGNIZER__* hrec, char* pBuffer, HRECOWORDLIST__** phwl);

@DllImport("inkobjcore")
HRESULT GetAllRecognizers(GUID** recognizerClsids, uint* count);

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

@GUID("9794FF82-6071-4717-8A8B-6AC7C64A686E")
interface IInkRectangle : IDispatch
{
    HRESULT get_Top(int* Units);
    HRESULT put_Top(int Units);
    HRESULT get_Left(int* Units);
    HRESULT put_Left(int Units);
    HRESULT get_Bottom(int* Units);
    HRESULT put_Bottom(int Units);
    HRESULT get_Right(int* Units);
    HRESULT put_Right(int Units);
    HRESULT get_Data(RECT* Rect);
    HRESULT put_Data(RECT Rect);
    HRESULT GetRectangle(int* Top, int* Left, int* Bottom, int* Right);
    HRESULT SetRectangle(int Top, int Left, int Bottom, int Right);
}

@GUID("DB489209-B7C3-411D-90F6-1548CFFF271E")
interface IInkExtendedProperty : IDispatch
{
    HRESULT get_Guid(BSTR* Guid);
    HRESULT get_Data(VARIANT* Data);
    HRESULT put_Data(VARIANT Data);
}

@GUID("89F2A8BE-95A9-4530-8B8F-88E971E3E25F")
interface IInkExtendedProperties : IDispatch
{
    HRESULT get_Count(int* Count);
    HRESULT get__NewEnum(IUnknown* _NewEnum);
    HRESULT Item(VARIANT Identifier, IInkExtendedProperty* Item);
    HRESULT Add(BSTR Guid, VARIANT Data, IInkExtendedProperty* InkExtendedProperty);
    HRESULT Remove(VARIANT Identifier);
    HRESULT Clear();
    HRESULT DoesPropertyExist(BSTR Guid, short* DoesPropertyExist);
}

@GUID("BF519B75-0A15-4623-ADC9-C00D436A8092")
interface IInkDrawingAttributes : IDispatch
{
    HRESULT get_Color(int* CurrentColor);
    HRESULT put_Color(int NewColor);
    HRESULT get_Width(float* CurrentWidth);
    HRESULT put_Width(float NewWidth);
    HRESULT get_Height(float* CurrentHeight);
    HRESULT put_Height(float NewHeight);
    HRESULT get_FitToCurve(short* Flag);
    HRESULT put_FitToCurve(short Flag);
    HRESULT get_IgnorePressure(short* Flag);
    HRESULT put_IgnorePressure(short Flag);
    HRESULT get_AntiAliased(short* Flag);
    HRESULT put_AntiAliased(short Flag);
    HRESULT get_Transparency(int* CurrentTransparency);
    HRESULT put_Transparency(int NewTransparency);
    HRESULT get_RasterOperation(InkRasterOperation* CurrentRasterOperation);
    HRESULT put_RasterOperation(InkRasterOperation NewRasterOperation);
    HRESULT get_PenTip(InkPenTip* CurrentPenTip);
    HRESULT put_PenTip(InkPenTip NewPenTip);
    HRESULT get_ExtendedProperties(IInkExtendedProperties* Properties);
    HRESULT Clone(IInkDrawingAttributes* DrawingAttributes);
}

@GUID("615F1D43-8703-4565-88E2-8201D2ECD7B7")
interface IInkTransform : IDispatch
{
    HRESULT Reset();
    HRESULT Translate(float HorizontalComponent, float VerticalComponent);
    HRESULT Rotate(float Degrees, float x, float y);
    HRESULT Reflect(short Horizontally, short Vertically);
    HRESULT Shear(float HorizontalComponent, float VerticalComponent);
    HRESULT ScaleTransform(float HorizontalMultiplier, float VerticalMultiplier);
    HRESULT GetTransform(float* eM11, float* eM12, float* eM21, float* eM22, float* eDx, float* eDy);
    HRESULT SetTransform(float eM11, float eM12, float eM21, float eM22, float eDx, float eDy);
    HRESULT get_eM11(float* Value);
    HRESULT put_eM11(float Value);
    HRESULT get_eM12(float* Value);
    HRESULT put_eM12(float Value);
    HRESULT get_eM21(float* Value);
    HRESULT put_eM21(float Value);
    HRESULT get_eM22(float* Value);
    HRESULT put_eM22(float Value);
    HRESULT get_eDx(float* Value);
    HRESULT put_eDx(float Value);
    HRESULT get_eDy(float* Value);
    HRESULT put_eDy(float Value);
    HRESULT get_Data(XFORM* XForm);
    HRESULT put_Data(XFORM XForm);
}

@GUID("3BDC0A97-04E5-4E26-B813-18F052D41DEF")
interface IInkGesture : IDispatch
{
    HRESULT get_Confidence(InkRecognitionConfidence* Confidence);
    HRESULT get_Id(InkApplicationGesture* Id);
    HRESULT GetHotPoint(int* X, int* Y);
}

@GUID("AD30C630-40C5-4350-8405-9C71012FC558")
interface IInkCursor : IDispatch
{
    HRESULT get_Name(BSTR* Name);
    HRESULT get_Id(int* Id);
    HRESULT get_Inverted(short* Status);
    HRESULT get_DrawingAttributes(IInkDrawingAttributes* Attributes);
    HRESULT putref_DrawingAttributes(IInkDrawingAttributes Attributes);
    HRESULT get_Tablet(IInkTablet* Tablet);
    HRESULT get_Buttons(IInkCursorButtons* Buttons);
}

@GUID("A248C1AC-C698-4E06-9E5C-D57F77C7E647")
interface IInkCursors : IDispatch
{
    HRESULT get_Count(int* Count);
    HRESULT get__NewEnum(IUnknown* _NewEnum);
    HRESULT Item(int Index, IInkCursor* Cursor);
}

@GUID("85EF9417-1D59-49B2-A13C-702C85430894")
interface IInkCursorButton : IDispatch
{
    HRESULT get_Name(BSTR* Name);
    HRESULT get_Id(BSTR* Id);
    HRESULT get_State(InkCursorButtonState* CurrentState);
}

@GUID("3671CC40-B624-4671-9FA0-DB119D952D54")
interface IInkCursorButtons : IDispatch
{
    HRESULT get_Count(int* Count);
    HRESULT get__NewEnum(IUnknown* _NewEnum);
    HRESULT Item(VARIANT Identifier, IInkCursorButton* Button);
}

@GUID("2DE25EAA-6EF8-42D5-AEE9-185BC81B912D")
interface IInkTablet : IDispatch
{
    HRESULT get_Name(BSTR* Name);
    HRESULT get_PlugAndPlayId(BSTR* Id);
    HRESULT get_MaximumInputRectangle(IInkRectangle* Rectangle);
    HRESULT get_HardwareCapabilities(TabletHardwareCapabilities* Capabilities);
    HRESULT IsPacketPropertySupported(BSTR packetPropertyName, short* Supported);
    HRESULT GetPropertyMetrics(BSTR propertyName, int* Minimum, int* Maximum, TabletPropertyMetricUnit* Units, 
                               float* Resolution);
}

@GUID("90C91AD2-FA36-49D6-9516-CE8D570F6F85")
interface IInkTablet2 : IDispatch
{
    HRESULT get_DeviceKind(TabletDeviceKind* Kind);
}

@GUID("7E313997-1327-41DD-8CA9-79F24BE17250")
interface IInkTablet3 : IDispatch
{
    HRESULT get_IsMultiTouch(short* pIsMultiTouch);
    HRESULT get_MaximumCursors(uint* pMaximumCursors);
}

@GUID("112086D9-7779-4535-A699-862B43AC1863")
interface IInkTablets : IDispatch
{
    HRESULT get_Count(int* Count);
    HRESULT get__NewEnum(IUnknown* _NewEnum);
    HRESULT get_DefaultTablet(IInkTablet* DefaultTablet);
    HRESULT Item(int Index, IInkTablet* Tablet);
    HRESULT IsPacketPropertySupported(BSTR packetPropertyName, short* Supported);
}

@GUID("43242FEA-91D1-4A72-963E-FBB91829CFA2")
interface IInkStrokeDisp : IDispatch
{
    HRESULT get_ID(int* ID);
    HRESULT get_BezierPoints(VARIANT* Points);
    HRESULT get_DrawingAttributes(IInkDrawingAttributes* DrawAttrs);
    HRESULT putref_DrawingAttributes(IInkDrawingAttributes DrawAttrs);
    HRESULT get_Ink(IInkDisp* Ink);
    HRESULT get_ExtendedProperties(IInkExtendedProperties* Properties);
    HRESULT get_PolylineCusps(VARIANT* Cusps);
    HRESULT get_BezierCusps(VARIANT* Cusps);
    HRESULT get_SelfIntersections(VARIANT* Intersections);
    HRESULT get_PacketCount(int* plCount);
    HRESULT get_PacketSize(int* plSize);
    HRESULT get_PacketDescription(VARIANT* PacketDescription);
    HRESULT get_Deleted(short* Deleted);
    HRESULT GetBoundingBox(InkBoundingBoxMode BoundingBoxMode, IInkRectangle* Rectangle);
    HRESULT FindIntersections(IInkStrokes Strokes, VARIANT* Intersections);
    HRESULT GetRectangleIntersections(IInkRectangle Rectangle, VARIANT* Intersections);
    HRESULT Clip(IInkRectangle Rectangle);
    HRESULT HitTestCircle(int X, int Y, float Radius, short* Intersects);
    HRESULT NearestPoint(int X, int Y, float* Distance, float* Point);
    HRESULT Split(float SplitAt, IInkStrokeDisp* NewStroke);
    HRESULT GetPacketDescriptionPropertyMetrics(BSTR PropertyName, int* Minimum, int* Maximum, 
                                                TabletPropertyMetricUnit* Units, float* Resolution);
    HRESULT GetPoints(int Index, int Count, VARIANT* Points);
    HRESULT SetPoints(VARIANT Points, int Index, int Count, int* NumberOfPointsSet);
    HRESULT GetPacketData(int Index, int Count, VARIANT* PacketData);
    HRESULT GetPacketValuesByProperty(BSTR PropertyName, int Index, int Count, VARIANT* PacketValues);
    HRESULT SetPacketValuesByProperty(BSTR bstrPropertyName, VARIANT PacketValues, int Index, int Count, 
                                      int* NumberOfPacketsSet);
    HRESULT GetFlattenedBezierPoints(int FittingError, VARIANT* FlattenedBezierPoints);
    HRESULT Transform(IInkTransform Transform, short ApplyOnPenWidth);
    HRESULT ScaleToRectangle(IInkRectangle Rectangle);
    HRESULT Move(float HorizontalComponent, float VerticalComponent);
    HRESULT Rotate(float Degrees, float x, float y);
    HRESULT Shear(float HorizontalMultiplier, float VerticalMultiplier);
    HRESULT ScaleTransform(float HorizontalMultiplier, float VerticalMultiplier);
}

@GUID("F1F4C9D8-590A-4963-B3AE-1935671BB6F3")
interface IInkStrokes : IDispatch
{
    HRESULT get_Count(int* Count);
    HRESULT get__NewEnum(IUnknown* _NewEnum);
    HRESULT get_Ink(IInkDisp* Ink);
    HRESULT get_RecognitionResult(IInkRecognitionResult* RecognitionResult);
    HRESULT ToString(BSTR* ToString);
    HRESULT Item(int Index, IInkStrokeDisp* Stroke);
    HRESULT Add(IInkStrokeDisp InkStroke);
    HRESULT AddStrokes(IInkStrokes InkStrokes);
    HRESULT Remove(IInkStrokeDisp InkStroke);
    HRESULT RemoveStrokes(IInkStrokes InkStrokes);
    HRESULT ModifyDrawingAttributes(IInkDrawingAttributes DrawAttrs);
    HRESULT GetBoundingBox(InkBoundingBoxMode BoundingBoxMode, IInkRectangle* BoundingBox);
    HRESULT Transform(IInkTransform Transform, short ApplyOnPenWidth);
    HRESULT ScaleToRectangle(IInkRectangle Rectangle);
    HRESULT Move(float HorizontalComponent, float VerticalComponent);
    HRESULT Rotate(float Degrees, float x, float y);
    HRESULT Shear(float HorizontalMultiplier, float VerticalMultiplier);
    HRESULT ScaleTransform(float HorizontalMultiplier, float VerticalMultiplier);
    HRESULT Clip(IInkRectangle Rectangle);
    HRESULT RemoveRecognitionResult();
}

@GUID("7E23A88F-C30E-420F-9BDB-28902543F0C1")
interface IInkCustomStrokes : IDispatch
{
    HRESULT get_Count(int* Count);
    HRESULT get__NewEnum(IUnknown* _NewEnum);
    HRESULT Item(VARIANT Identifier, IInkStrokes* Strokes);
    HRESULT Add(BSTR Name, IInkStrokes Strokes);
    HRESULT Remove(VARIANT Identifier);
    HRESULT Clear();
}

@GUID("F33053EC-5D25-430A-928F-76A6491DDE15")
interface _IInkStrokesEvents : IDispatch
{
}

@GUID("9D398FA0-C4E2-4FCD-9973-975CAAF47EA6")
interface IInkDisp : IDispatch
{
    HRESULT get_Strokes(IInkStrokes* Strokes);
    HRESULT get_ExtendedProperties(IInkExtendedProperties* Properties);
    HRESULT get_Dirty(short* Dirty);
    HRESULT put_Dirty(short Dirty);
    HRESULT get_CustomStrokes(IInkCustomStrokes* ppunkInkCustomStrokes);
    HRESULT GetBoundingBox(InkBoundingBoxMode BoundingBoxMode, IInkRectangle* Rectangle);
    HRESULT DeleteStrokes(IInkStrokes Strokes);
    HRESULT DeleteStroke(IInkStrokeDisp Stroke);
    HRESULT ExtractStrokes(IInkStrokes Strokes, InkExtractFlags ExtractFlags, IInkDisp* ExtractedInk);
    HRESULT ExtractWithRectangle(IInkRectangle Rectangle, InkExtractFlags extractFlags, IInkDisp* ExtractedInk);
    HRESULT Clip(IInkRectangle Rectangle);
    HRESULT Clone(IInkDisp* NewInk);
    HRESULT HitTestCircle(int X, int Y, float radius, IInkStrokes* Strokes);
    HRESULT HitTestWithRectangle(IInkRectangle SelectionRectangle, float IntersectPercent, IInkStrokes* Strokes);
    HRESULT HitTestWithLasso(VARIANT Points, float IntersectPercent, VARIANT* LassoPoints, IInkStrokes* Strokes);
    HRESULT NearestPoint(int X, int Y, float* PointOnStroke, float* DistanceFromPacket, IInkStrokeDisp* Stroke);
    HRESULT CreateStrokes(VARIANT StrokeIds, IInkStrokes* Strokes);
    HRESULT AddStrokesAtRectangle(IInkStrokes SourceStrokes, IInkRectangle TargetRectangle);
    HRESULT Save(InkPersistenceFormat PersistenceFormat, InkPersistenceCompressionMode CompressionMode, 
                 VARIANT* Data);
    HRESULT Load(VARIANT Data);
    HRESULT CreateStroke(VARIANT PacketData, VARIANT PacketDescription, IInkStrokeDisp* Stroke);
    HRESULT ClipboardCopyWithRectangle(IInkRectangle Rectangle, InkClipboardFormats ClipboardFormats, 
                                       InkClipboardModes ClipboardModes, IDataObject* DataObject);
    HRESULT ClipboardCopy(IInkStrokes strokes, InkClipboardFormats ClipboardFormats, 
                          InkClipboardModes ClipboardModes, IDataObject* DataObject);
    HRESULT CanPaste(IDataObject DataObject, short* CanPaste);
    HRESULT ClipboardPaste(int x, int y, IDataObject DataObject, IInkStrokes* Strokes);
}

@GUID("427B1865-CA3F-479A-83A9-0F420F2A0073")
interface _IInkEvents : IDispatch
{
}

@GUID("E6257A9C-B511-4F4C-A8B0-A7DBC9506B83")
interface IInkRenderer : IDispatch
{
    HRESULT GetViewTransform(IInkTransform ViewTransform);
    HRESULT SetViewTransform(IInkTransform ViewTransform);
    HRESULT GetObjectTransform(IInkTransform ObjectTransform);
    HRESULT SetObjectTransform(IInkTransform ObjectTransform);
    HRESULT Draw(ptrdiff_t hDC, IInkStrokes Strokes);
    HRESULT DrawStroke(ptrdiff_t hDC, IInkStrokeDisp Stroke, IInkDrawingAttributes DrawingAttributes);
    HRESULT PixelToInkSpace(ptrdiff_t hDC, int* x, int* y);
    HRESULT InkSpaceToPixel(ptrdiff_t hdcDisplay, int* x, int* y);
    HRESULT PixelToInkSpaceFromPoints(ptrdiff_t hDC, VARIANT* Points);
    HRESULT InkSpaceToPixelFromPoints(ptrdiff_t hDC, VARIANT* Points);
    HRESULT Measure(IInkStrokes Strokes, IInkRectangle* Rectangle);
    HRESULT MeasureStroke(IInkStrokeDisp Stroke, IInkDrawingAttributes DrawingAttributes, IInkRectangle* Rectangle);
    HRESULT Move(float HorizontalComponent, float VerticalComponent);
    HRESULT Rotate(float Degrees, float x, float y);
    HRESULT ScaleTransform(float HorizontalMultiplier, float VerticalMultiplier, short ApplyOnPenWidth);
}

@GUID("F0F060B5-8B1F-4A7C-89EC-880692588A4F")
interface IInkCollector : IDispatch
{
    HRESULT get_hWnd(ptrdiff_t* CurrentWindow);
    HRESULT put_hWnd(ptrdiff_t NewWindow);
    HRESULT get_Enabled(short* Collecting);
    HRESULT put_Enabled(short Collecting);
    HRESULT get_DefaultDrawingAttributes(IInkDrawingAttributes* CurrentAttributes);
    HRESULT putref_DefaultDrawingAttributes(IInkDrawingAttributes NewAttributes);
    HRESULT get_Renderer(IInkRenderer* CurrentInkRenderer);
    HRESULT putref_Renderer(IInkRenderer NewInkRenderer);
    HRESULT get_Ink(IInkDisp* Ink);
    HRESULT putref_Ink(IInkDisp NewInk);
    HRESULT get_AutoRedraw(short* AutoRedraw);
    HRESULT put_AutoRedraw(short AutoRedraw);
    HRESULT get_CollectingInk(short* Collecting);
    HRESULT get_CollectionMode(InkCollectionMode* Mode);
    HRESULT put_CollectionMode(InkCollectionMode Mode);
    HRESULT get_DynamicRendering(short* Enabled);
    HRESULT put_DynamicRendering(short Enabled);
    HRESULT get_DesiredPacketDescription(VARIANT* PacketGuids);
    HRESULT put_DesiredPacketDescription(VARIANT PacketGuids);
    HRESULT get_MouseIcon(IPictureDisp* MouseIcon);
    HRESULT put_MouseIcon(IPictureDisp MouseIcon);
    HRESULT putref_MouseIcon(IPictureDisp MouseIcon);
    HRESULT get_MousePointer(InkMousePointer* MousePointer);
    HRESULT put_MousePointer(InkMousePointer MousePointer);
    HRESULT get_Cursors(IInkCursors* Cursors);
    HRESULT get_MarginX(int* MarginX);
    HRESULT put_MarginX(int MarginX);
    HRESULT get_MarginY(int* MarginY);
    HRESULT put_MarginY(int MarginY);
    HRESULT get_Tablet(IInkTablet* SingleTablet);
    HRESULT get_SupportHighContrastInk(short* Support);
    HRESULT put_SupportHighContrastInk(short Support);
    HRESULT SetGestureStatus(InkApplicationGesture Gesture, short Listen);
    HRESULT GetGestureStatus(InkApplicationGesture Gesture, short* Listening);
    HRESULT GetWindowInputRectangle(IInkRectangle* WindowInputRectangle);
    HRESULT SetWindowInputRectangle(IInkRectangle WindowInputRectangle);
    HRESULT SetAllTabletsMode(short UseMouseForInput);
    HRESULT SetSingleTabletIntegratedMode(IInkTablet Tablet);
    HRESULT GetEventInterest(InkCollectorEventInterest EventId, short* Listen);
    HRESULT SetEventInterest(InkCollectorEventInterest EventId, short Listen);
}

@GUID("11A583F2-712D-4FEA-ABCF-AB4AF38EA06B")
interface _IInkCollectorEvents : IDispatch
{
}

@GUID("B82A463B-C1C5-45A3-997C-DEAB5651B67A")
interface IInkOverlay : IDispatch
{
    HRESULT get_hWnd(ptrdiff_t* CurrentWindow);
    HRESULT put_hWnd(ptrdiff_t NewWindow);
    HRESULT get_Enabled(short* Collecting);
    HRESULT put_Enabled(short Collecting);
    HRESULT get_DefaultDrawingAttributes(IInkDrawingAttributes* CurrentAttributes);
    HRESULT putref_DefaultDrawingAttributes(IInkDrawingAttributes NewAttributes);
    HRESULT get_Renderer(IInkRenderer* CurrentInkRenderer);
    HRESULT putref_Renderer(IInkRenderer NewInkRenderer);
    HRESULT get_Ink(IInkDisp* Ink);
    HRESULT putref_Ink(IInkDisp NewInk);
    HRESULT get_AutoRedraw(short* AutoRedraw);
    HRESULT put_AutoRedraw(short AutoRedraw);
    HRESULT get_CollectingInk(short* Collecting);
    HRESULT get_CollectionMode(InkCollectionMode* Mode);
    HRESULT put_CollectionMode(InkCollectionMode Mode);
    HRESULT get_DynamicRendering(short* Enabled);
    HRESULT put_DynamicRendering(short Enabled);
    HRESULT get_DesiredPacketDescription(VARIANT* PacketGuids);
    HRESULT put_DesiredPacketDescription(VARIANT PacketGuids);
    HRESULT get_MouseIcon(IPictureDisp* MouseIcon);
    HRESULT put_MouseIcon(IPictureDisp MouseIcon);
    HRESULT putref_MouseIcon(IPictureDisp MouseIcon);
    HRESULT get_MousePointer(InkMousePointer* MousePointer);
    HRESULT put_MousePointer(InkMousePointer MousePointer);
    HRESULT get_EditingMode(InkOverlayEditingMode* EditingMode);
    HRESULT put_EditingMode(InkOverlayEditingMode EditingMode);
    HRESULT get_Selection(IInkStrokes* Selection);
    HRESULT put_Selection(IInkStrokes Selection);
    HRESULT get_EraserMode(InkOverlayEraserMode* EraserMode);
    HRESULT put_EraserMode(InkOverlayEraserMode EraserMode);
    HRESULT get_EraserWidth(int* EraserWidth);
    HRESULT put_EraserWidth(int newEraserWidth);
    HRESULT get_AttachMode(InkOverlayAttachMode* AttachMode);
    HRESULT put_AttachMode(InkOverlayAttachMode AttachMode);
    HRESULT get_Cursors(IInkCursors* Cursors);
    HRESULT get_MarginX(int* MarginX);
    HRESULT put_MarginX(int MarginX);
    HRESULT get_MarginY(int* MarginY);
    HRESULT put_MarginY(int MarginY);
    HRESULT get_Tablet(IInkTablet* SingleTablet);
    HRESULT get_SupportHighContrastInk(short* Support);
    HRESULT put_SupportHighContrastInk(short Support);
    HRESULT get_SupportHighContrastSelectionUI(short* Support);
    HRESULT put_SupportHighContrastSelectionUI(short Support);
    HRESULT HitTestSelection(int x, int y, SelectionHitResult* SelArea);
    HRESULT Draw(IInkRectangle Rect);
    HRESULT SetGestureStatus(InkApplicationGesture Gesture, short Listen);
    HRESULT GetGestureStatus(InkApplicationGesture Gesture, short* Listening);
    HRESULT GetWindowInputRectangle(IInkRectangle* WindowInputRectangle);
    HRESULT SetWindowInputRectangle(IInkRectangle WindowInputRectangle);
    HRESULT SetAllTabletsMode(short UseMouseForInput);
    HRESULT SetSingleTabletIntegratedMode(IInkTablet Tablet);
    HRESULT GetEventInterest(InkCollectorEventInterest EventId, short* Listen);
    HRESULT SetEventInterest(InkCollectorEventInterest EventId, short Listen);
}

@GUID("31179B69-E563-489E-B16F-712F1E8A0651")
interface _IInkOverlayEvents : IDispatch
{
}

@GUID("E85662E0-379A-40D7-9B5C-757D233F9923")
interface IInkPicture : IDispatch
{
    HRESULT get_hWnd(ptrdiff_t* CurrentWindow);
    HRESULT get_DefaultDrawingAttributes(IInkDrawingAttributes* CurrentAttributes);
    HRESULT putref_DefaultDrawingAttributes(IInkDrawingAttributes NewAttributes);
    HRESULT get_Renderer(IInkRenderer* CurrentInkRenderer);
    HRESULT putref_Renderer(IInkRenderer NewInkRenderer);
    HRESULT get_Ink(IInkDisp* Ink);
    HRESULT putref_Ink(IInkDisp NewInk);
    HRESULT get_AutoRedraw(short* AutoRedraw);
    HRESULT put_AutoRedraw(short AutoRedraw);
    HRESULT get_CollectingInk(short* Collecting);
    HRESULT get_CollectionMode(InkCollectionMode* Mode);
    HRESULT put_CollectionMode(InkCollectionMode Mode);
    HRESULT get_DynamicRendering(short* Enabled);
    HRESULT put_DynamicRendering(short Enabled);
    HRESULT get_DesiredPacketDescription(VARIANT* PacketGuids);
    HRESULT put_DesiredPacketDescription(VARIANT PacketGuids);
    HRESULT get_MouseIcon(IPictureDisp* MouseIcon);
    HRESULT put_MouseIcon(IPictureDisp MouseIcon);
    HRESULT putref_MouseIcon(IPictureDisp MouseIcon);
    HRESULT get_MousePointer(InkMousePointer* MousePointer);
    HRESULT put_MousePointer(InkMousePointer MousePointer);
    HRESULT get_EditingMode(InkOverlayEditingMode* EditingMode);
    HRESULT put_EditingMode(InkOverlayEditingMode EditingMode);
    HRESULT get_Selection(IInkStrokes* Selection);
    HRESULT put_Selection(IInkStrokes Selection);
    HRESULT get_EraserMode(InkOverlayEraserMode* EraserMode);
    HRESULT put_EraserMode(InkOverlayEraserMode EraserMode);
    HRESULT get_EraserWidth(int* EraserWidth);
    HRESULT put_EraserWidth(int newEraserWidth);
    HRESULT putref_Picture(IPictureDisp pPicture);
    HRESULT put_Picture(IPictureDisp pPicture);
    HRESULT get_Picture(IPictureDisp* ppPicture);
    HRESULT put_SizeMode(InkPictureSizeMode smNewSizeMode);
    HRESULT get_SizeMode(InkPictureSizeMode* smSizeMode);
    HRESULT put_BackColor(uint newColor);
    HRESULT get_BackColor(uint* pColor);
    HRESULT get_Cursors(IInkCursors* Cursors);
    HRESULT get_MarginX(int* MarginX);
    HRESULT put_MarginX(int MarginX);
    HRESULT get_MarginY(int* MarginY);
    HRESULT put_MarginY(int MarginY);
    HRESULT get_Tablet(IInkTablet* SingleTablet);
    HRESULT get_SupportHighContrastInk(short* Support);
    HRESULT put_SupportHighContrastInk(short Support);
    HRESULT get_SupportHighContrastSelectionUI(short* Support);
    HRESULT put_SupportHighContrastSelectionUI(short Support);
    HRESULT HitTestSelection(int x, int y, SelectionHitResult* SelArea);
    HRESULT SetGestureStatus(InkApplicationGesture Gesture, short Listen);
    HRESULT GetGestureStatus(InkApplicationGesture Gesture, short* Listening);
    HRESULT GetWindowInputRectangle(IInkRectangle* WindowInputRectangle);
    HRESULT SetWindowInputRectangle(IInkRectangle WindowInputRectangle);
    HRESULT SetAllTabletsMode(short UseMouseForInput);
    HRESULT SetSingleTabletIntegratedMode(IInkTablet Tablet);
    HRESULT GetEventInterest(InkCollectorEventInterest EventId, short* Listen);
    HRESULT SetEventInterest(InkCollectorEventInterest EventId, short Listen);
    HRESULT get_InkEnabled(short* Collecting);
    HRESULT put_InkEnabled(short Collecting);
    HRESULT get_Enabled(short* pbool);
    HRESULT put_Enabled(short vbool);
}

@GUID("60FF4FEE-22FF-4484-ACC1-D308D9CD7EA3")
interface _IInkPictureEvents : IDispatch
{
}

@GUID("782BF7CF-034B-4396-8A32-3A1833CF6B56")
interface IInkRecognizer : IDispatch
{
    HRESULT get_Name(BSTR* Name);
    HRESULT get_Vendor(BSTR* Vendor);
    HRESULT get_Capabilities(InkRecognizerCapabilities* CapabilitiesFlags);
    HRESULT get_Languages(VARIANT* Languages);
    HRESULT get_SupportedProperties(VARIANT* SupportedProperties);
    HRESULT get_PreferredPacketDescription(VARIANT* PreferredPacketDescription);
    HRESULT CreateRecognizerContext(IInkRecognizerContext* Context);
}

@GUID("6110118A-3A75-4AD6-B2AA-04B2B72BBE65")
interface IInkRecognizer2 : IDispatch
{
    HRESULT get_Id(BSTR* pbstrId);
    HRESULT get_UnicodeRanges(VARIANT* UnicodeRanges);
}

@GUID("9CCC4F12-B0B7-4A8B-BF58-4AECA4E8CEFD")
interface IInkRecognizers : IDispatch
{
    HRESULT get_Count(int* Count);
    HRESULT get__NewEnum(IUnknown* _NewEnum);
    HRESULT GetDefaultRecognizer(int lcid, IInkRecognizer* DefaultRecognizer);
    HRESULT Item(int Index, IInkRecognizer* InkRecognizer);
}

@GUID("17BCE92F-2E21-47FD-9D33-3C6AFBFD8C59")
interface _IInkRecognitionEvents : IDispatch
{
}

@GUID("C68F52F9-32A3-4625-906C-44FC23B40958")
interface IInkRecognizerContext : IDispatch
{
    HRESULT get_Strokes(IInkStrokes* Strokes);
    HRESULT putref_Strokes(IInkStrokes Strokes);
    HRESULT get_CharacterAutoCompletionMode(InkRecognizerCharacterAutoCompletionMode* Mode);
    HRESULT put_CharacterAutoCompletionMode(InkRecognizerCharacterAutoCompletionMode Mode);
    HRESULT get_Factoid(BSTR* Factoid);
    HRESULT put_Factoid(BSTR factoid);
    HRESULT get_Guide(IInkRecognizerGuide* RecognizerGuide);
    HRESULT putref_Guide(IInkRecognizerGuide RecognizerGuide);
    HRESULT get_PrefixText(BSTR* Prefix);
    HRESULT put_PrefixText(BSTR Prefix);
    HRESULT get_SuffixText(BSTR* Suffix);
    HRESULT put_SuffixText(BSTR Suffix);
    HRESULT get_RecognitionFlags(InkRecognitionModes* Modes);
    HRESULT put_RecognitionFlags(InkRecognitionModes Modes);
    HRESULT get_WordList(IInkWordList* WordList);
    HRESULT putref_WordList(IInkWordList WordList);
    HRESULT get_Recognizer(IInkRecognizer* Recognizer);
    HRESULT Recognize(InkRecognitionStatus* RecognitionStatus, IInkRecognitionResult* RecognitionResult);
    HRESULT StopBackgroundRecognition();
    HRESULT EndInkInput();
    HRESULT BackgroundRecognize(VARIANT CustomData);
    HRESULT BackgroundRecognizeWithAlternates(VARIANT CustomData);
    HRESULT Clone(IInkRecognizerContext* RecoContext);
    HRESULT IsStringSupported(BSTR String, short* Supported);
}

@GUID("D6F0E32F-73D8-408E-8E9F-5FEA592C363F")
interface IInkRecognizerContext2 : IDispatch
{
    HRESULT get_EnabledUnicodeRanges(VARIANT* UnicodeRanges);
    HRESULT put_EnabledUnicodeRanges(VARIANT UnicodeRanges);
}

@GUID("3BC129A8-86CD-45AD-BDE8-E0D32D61C16D")
interface IInkRecognitionResult : IDispatch
{
    HRESULT get_TopString(BSTR* TopString);
    HRESULT get_TopAlternate(IInkRecognitionAlternate* TopAlternate);
    HRESULT get_TopConfidence(InkRecognitionConfidence* TopConfidence);
    HRESULT get_Strokes(IInkStrokes* Strokes);
    HRESULT AlternatesFromSelection(int selectionStart, int selectionLength, int maximumAlternates, 
                                    IInkRecognitionAlternates* AlternatesFromSelection);
    HRESULT ModifyTopAlternate(IInkRecognitionAlternate Alternate);
    HRESULT SetResultOnStrokes();
}

@GUID("B7E660AD-77E4-429B-ADDA-873780D1FC4A")
interface IInkRecognitionAlternate : IDispatch
{
    HRESULT get_String(BSTR* RecoString);
    HRESULT get_Confidence(InkRecognitionConfidence* Confidence);
    HRESULT get_Baseline(VARIANT* Baseline);
    HRESULT get_Midline(VARIANT* Midline);
    HRESULT get_Ascender(VARIANT* Ascender);
    HRESULT get_Descender(VARIANT* Descender);
    HRESULT get_LineNumber(int* LineNumber);
    HRESULT get_Strokes(IInkStrokes* Strokes);
    HRESULT get_LineAlternates(IInkRecognitionAlternates* LineAlternates);
    HRESULT get_ConfidenceAlternates(IInkRecognitionAlternates* ConfidenceAlternates);
    HRESULT GetStrokesFromStrokeRanges(IInkStrokes Strokes, IInkStrokes* GetStrokesFromStrokeRanges);
    HRESULT GetStrokesFromTextRange(int* selectionStart, int* selectionLength, 
                                    IInkStrokes* GetStrokesFromTextRange);
    HRESULT GetTextRangeFromStrokes(IInkStrokes Strokes, int* selectionStart, int* selectionLength);
    HRESULT AlternatesWithConstantPropertyValues(BSTR PropertyType, 
                                                 IInkRecognitionAlternates* AlternatesWithConstantPropertyValues);
    HRESULT GetPropertyValue(BSTR PropertyType, VARIANT* PropertyValue);
}

@GUID("286A167F-9F19-4C61-9D53-4F07BE622B84")
interface IInkRecognitionAlternates : IDispatch
{
    HRESULT get_Count(int* Count);
    HRESULT get__NewEnum(IUnknown* _NewEnum);
    HRESULT get_Strokes(IInkStrokes* Strokes);
    HRESULT Item(int Index, IInkRecognitionAlternate* InkRecoAlternate);
}

@GUID("D934BE07-7B84-4208-9136-83C20994E905")
interface IInkRecognizerGuide : IDispatch
{
    HRESULT get_WritingBox(IInkRectangle* Rectangle);
    HRESULT put_WritingBox(IInkRectangle Rectangle);
    HRESULT get_DrawnBox(IInkRectangle* Rectangle);
    HRESULT put_DrawnBox(IInkRectangle Rectangle);
    HRESULT get_Rows(int* Units);
    HRESULT put_Rows(int Units);
    HRESULT get_Columns(int* Units);
    HRESULT put_Columns(int Units);
    HRESULT get_Midline(int* Units);
    HRESULT put_Midline(int Units);
    HRESULT get_GuideData(InkRecoGuide* pRecoGuide);
    HRESULT put_GuideData(InkRecoGuide recoGuide);
}

@GUID("76BA3491-CB2F-406B-9961-0E0C4CDAAEF2")
interface IInkWordList : IDispatch
{
    HRESULT AddWord(BSTR NewWord);
    HRESULT RemoveWord(BSTR RemoveWord);
    HRESULT Merge(IInkWordList MergeWordList);
}

@GUID("14542586-11BF-4F5F-B6E7-49D0744AAB6E")
interface IInkWordList2 : IDispatch
{
    HRESULT AddWords(BSTR NewWords);
}

@GUID("03F8E511-43A1-11D3-8BB6-0080C7D6BAD5")
interface IInk : IDispatch
{
}

@GUID("9C1C5AD6-F22F-4DE4-B453-A2CC482E7C33")
interface IInkLineInfo : IUnknown
{
    HRESULT SetFormat(INKMETRIC* pim);
    HRESULT GetFormat(INKMETRIC* pim);
    HRESULT GetInkExtent(INKMETRIC* pim, uint* pnWidth);
    HRESULT GetCandidate(uint nCandidateNum, const(wchar)* pwcRecogWord, uint* pcwcRecogWord, uint dwFlags);
    HRESULT SetCandidate(uint nCandidateNum, const(wchar)* strRecogWord);
    HRESULT Recognize();
}

@GUID("B4563688-98EB-4646-B279-44DA14D45748")
interface ISketchInk : IDispatch
{
}

@GUID("5DE00405-F9A4-4651-B0C5-C317DEFD58B9")
interface IInkDivider : IDispatch
{
    HRESULT get_Strokes(IInkStrokes* Strokes);
    HRESULT putref_Strokes(IInkStrokes Strokes);
    HRESULT get_RecognizerContext(IInkRecognizerContext* RecognizerContext);
    HRESULT putref_RecognizerContext(IInkRecognizerContext RecognizerContext);
    HRESULT get_LineHeight(int* LineHeight);
    HRESULT put_LineHeight(int LineHeight);
    HRESULT Divide(IInkDivisionResult* InkDivisionResult);
}

@GUID("2DBEC0A7-74C7-4B38-81EB-AA8EF0C24900")
interface IInkDivisionResult : IDispatch
{
    HRESULT get_Strokes(IInkStrokes* Strokes);
    HRESULT ResultByType(InkDivisionType divisionType, IInkDivisionUnits* InkDivisionUnits);
}

@GUID("85AEE342-48B0-4244-9DD5-1ED435410FAB")
interface IInkDivisionUnit : IDispatch
{
    HRESULT get_Strokes(IInkStrokes* Strokes);
    HRESULT get_DivisionType(InkDivisionType* divisionType);
    HRESULT get_RecognizedString(BSTR* RecoString);
    HRESULT get_RotationTransform(IInkTransform* RotationTransform);
}

@GUID("1BB5DDC2-31CC-4135-AB82-2C66C9F00C41")
interface IInkDivisionUnits : IDispatch
{
    HRESULT get_Count(int* Count);
    HRESULT get__NewEnum(IUnknown* _NewEnum);
    HRESULT Item(int Index, IInkDivisionUnit* InkDivisionUnit);
}

@GUID("FA7A4083-5747-4040-A182-0B0E9FD4FAC7")
interface IPenInputPanel : IDispatch
{
    HRESULT get_Busy(short* Busy);
    HRESULT get_Factoid(BSTR* Factoid);
    HRESULT put_Factoid(BSTR Factoid);
    HRESULT get_AttachedEditWindow(int* AttachedEditWindow);
    HRESULT put_AttachedEditWindow(int AttachedEditWindow);
    HRESULT get_CurrentPanel(PanelType* CurrentPanel);
    HRESULT put_CurrentPanel(PanelType CurrentPanel);
    HRESULT get_DefaultPanel(PanelType* pDefaultPanel);
    HRESULT put_DefaultPanel(PanelType DefaultPanel);
    HRESULT get_Visible(short* Visible);
    HRESULT put_Visible(short Visible);
    HRESULT get_Top(int* Top);
    HRESULT get_Left(int* Left);
    HRESULT get_Width(int* Width);
    HRESULT get_Height(int* Height);
    HRESULT get_VerticalOffset(int* VerticalOffset);
    HRESULT put_VerticalOffset(int VerticalOffset);
    HRESULT get_HorizontalOffset(int* HorizontalOffset);
    HRESULT put_HorizontalOffset(int HorizontalOffset);
    HRESULT get_AutoShow(short* pAutoShow);
    HRESULT put_AutoShow(short AutoShow);
    HRESULT MoveTo(int Left, int Top);
    HRESULT CommitPendingInput();
    HRESULT Refresh();
    HRESULT EnableTsf(short Enable);
}

@GUID("B7E489DA-3719-439F-848F-E7ACBD820F17")
interface _IPenInputPanelEvents : IDispatch
{
}

@GUID("56FDEA97-ECD6-43E7-AA3A-816BE7785860")
interface IHandwrittenTextInsertion : IUnknown
{
    HRESULT InsertRecognitionResultsArray(SAFEARRAY* psaAlternates, uint locale, 
                                          BOOL fAlternateContainsAutoSpacingInformation);
    HRESULT InsertInkRecognitionResult(IInkRecognitionResult pIInkRecoResult, uint locale, 
                                       BOOL fAlternateContainsAutoSpacingInformation);
}

@GUID("27560408-8E64-4FE1-804E-421201584B31")
interface ITextInputPanelEventSink : IUnknown
{
    HRESULT InPlaceStateChanging(InPlaceState oldInPlaceState, InPlaceState newInPlaceState);
    HRESULT InPlaceStateChanged(InPlaceState oldInPlaceState, InPlaceState newInPlaceState);
    HRESULT InPlaceSizeChanging(RECT oldBoundingRectangle, RECT newBoundingRectangle);
    HRESULT InPlaceSizeChanged(RECT oldBoundingRectangle, RECT newBoundingRectangle);
    HRESULT InputAreaChanging(PanelInputArea oldInputArea, PanelInputArea newInputArea);
    HRESULT InputAreaChanged(PanelInputArea oldInputArea, PanelInputArea newInputArea);
    HRESULT CorrectionModeChanging(CorrectionMode oldCorrectionMode, CorrectionMode newCorrectionMode);
    HRESULT CorrectionModeChanged(CorrectionMode oldCorrectionMode, CorrectionMode newCorrectionMode);
    HRESULT InPlaceVisibilityChanging(BOOL oldVisible, BOOL newVisible);
    HRESULT InPlaceVisibilityChanged(BOOL oldVisible, BOOL newVisible);
    HRESULT TextInserting(SAFEARRAY* Ink);
    HRESULT TextInserted(SAFEARRAY* Ink);
}

@GUID("6B6A65A5-6AF3-46C2-B6EA-56CD1F80DF71")
interface ITextInputPanel : IUnknown
{
    HRESULT get_AttachedEditWindow(HWND* AttachedEditWindow);
    HRESULT put_AttachedEditWindow(HWND AttachedEditWindow);
    HRESULT get_CurrentInteractionMode(InteractionMode* CurrentInteractionMode);
    HRESULT get_DefaultInPlaceState(InPlaceState* State);
    HRESULT put_DefaultInPlaceState(InPlaceState State);
    HRESULT get_CurrentInPlaceState(InPlaceState* State);
    HRESULT get_DefaultInputArea(PanelInputArea* Area);
    HRESULT put_DefaultInputArea(PanelInputArea Area);
    HRESULT get_CurrentInputArea(PanelInputArea* Area);
    HRESULT get_CurrentCorrectionMode(CorrectionMode* Mode);
    HRESULT get_PreferredInPlaceDirection(InPlaceDirection* Direction);
    HRESULT put_PreferredInPlaceDirection(InPlaceDirection Direction);
    HRESULT get_ExpandPostInsertionCorrection(int* Expand);
    HRESULT put_ExpandPostInsertionCorrection(BOOL Expand);
    HRESULT get_InPlaceVisibleOnFocus(int* Visible);
    HRESULT put_InPlaceVisibleOnFocus(BOOL Visible);
    HRESULT get_InPlaceBoundingRectangle(RECT* BoundingRectangle);
    HRESULT get_PopUpCorrectionHeight(int* Height);
    HRESULT get_PopDownCorrectionHeight(int* Height);
    HRESULT CommitPendingInput();
    HRESULT SetInPlaceVisibility(BOOL Visible);
    HRESULT SetInPlacePosition(int xPosition, int yPosition, CorrectionPosition position);
    HRESULT SetInPlaceHoverTargetPosition(int xPosition, int yPosition);
    HRESULT Advise(ITextInputPanelEventSink EventSink, uint EventMask);
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

@GUID("9F424568-1920-48CC-9811-A993CBF5ADBA")
interface ITextInputPanelRunInfo : IUnknown
{
    HRESULT IsTipRunning(int* pfRunning);
}

@GUID("F2127A19-FBFB-4AED-8464-3F36D78CFEFB")
interface IInkEdit : IDispatch
{
    HRESULT get_Status(InkEditStatus* pStatus);
    HRESULT get_UseMouseForInput(short* pVal);
    HRESULT put_UseMouseForInput(short newVal);
    HRESULT get_InkMode(InkMode* pVal);
    HRESULT put_InkMode(InkMode newVal);
    HRESULT get_InkInsertMode(InkInsertMode* pVal);
    HRESULT put_InkInsertMode(InkInsertMode newVal);
    HRESULT get_DrawingAttributes(IInkDrawingAttributes* pVal);
    HRESULT putref_DrawingAttributes(IInkDrawingAttributes newVal);
    HRESULT get_RecognitionTimeout(int* pVal);
    HRESULT put_RecognitionTimeout(int newVal);
    HRESULT get_Recognizer(IInkRecognizer* pVal);
    HRESULT putref_Recognizer(IInkRecognizer newVal);
    HRESULT get_Factoid(BSTR* pVal);
    HRESULT put_Factoid(BSTR newVal);
    HRESULT get_SelInks(VARIANT* pSelInk);
    HRESULT put_SelInks(VARIANT SelInk);
    HRESULT get_SelInksDisplayMode(InkDisplayMode* pInkDisplayMode);
    HRESULT put_SelInksDisplayMode(InkDisplayMode InkDisplayMode);
    HRESULT Recognize();
    HRESULT GetGestureStatus(InkApplicationGesture Gesture, short* pListen);
    HRESULT SetGestureStatus(InkApplicationGesture Gesture, short Listen);
    HRESULT put_BackColor(uint clr);
    HRESULT get_BackColor(uint* pclr);
    HRESULT get_Appearance(AppearanceConstants* pAppearance);
    HRESULT put_Appearance(AppearanceConstants pAppearance);
    HRESULT get_BorderStyle(BorderStyleConstants* pBorderStyle);
    HRESULT put_BorderStyle(BorderStyleConstants pBorderStyle);
    HRESULT get_Hwnd(uint* pohHwnd);
    HRESULT get_Font(IFontDisp* ppFont);
    HRESULT putref_Font(IFontDisp ppFont);
    HRESULT get_Text(BSTR* pbstrText);
    HRESULT put_Text(BSTR pbstrText);
    HRESULT get_MouseIcon(IPictureDisp* MouseIcon);
    HRESULT put_MouseIcon(IPictureDisp MouseIcon);
    HRESULT putref_MouseIcon(IPictureDisp MouseIcon);
    HRESULT get_MousePointer(InkMousePointer* MousePointer);
    HRESULT put_MousePointer(InkMousePointer MousePointer);
    HRESULT get_Locked(short* pVal);
    HRESULT put_Locked(short newVal);
    HRESULT get_Enabled(short* pVal);
    HRESULT put_Enabled(short newVal);
    HRESULT get_MaxLength(int* plMaxLength);
    HRESULT put_MaxLength(int lMaxLength);
    HRESULT get_MultiLine(short* pVal);
    HRESULT put_MultiLine(short newVal);
    HRESULT get_ScrollBars(ScrollBarsConstants* pVal);
    HRESULT put_ScrollBars(ScrollBarsConstants newVal);
    HRESULT get_DisableNoScroll(short* pVal);
    HRESULT put_DisableNoScroll(short newVal);
    HRESULT get_SelAlignment(VARIANT* pvarSelAlignment);
    HRESULT put_SelAlignment(VARIANT pvarSelAlignment);
    HRESULT get_SelBold(VARIANT* pvarSelBold);
    HRESULT put_SelBold(VARIANT pvarSelBold);
    HRESULT get_SelItalic(VARIANT* pvarSelItalic);
    HRESULT put_SelItalic(VARIANT pvarSelItalic);
    HRESULT get_SelUnderline(VARIANT* pvarSelUnderline);
    HRESULT put_SelUnderline(VARIANT pvarSelUnderline);
    HRESULT get_SelColor(VARIANT* pvarSelColor);
    HRESULT put_SelColor(VARIANT pvarSelColor);
    HRESULT get_SelFontName(VARIANT* pvarSelFontName);
    HRESULT put_SelFontName(VARIANT pvarSelFontName);
    HRESULT get_SelFontSize(VARIANT* pvarSelFontSize);
    HRESULT put_SelFontSize(VARIANT pvarSelFontSize);
    HRESULT get_SelCharOffset(VARIANT* pvarSelCharOffset);
    HRESULT put_SelCharOffset(VARIANT pvarSelCharOffset);
    HRESULT get_TextRTF(BSTR* pbstrTextRTF);
    HRESULT put_TextRTF(BSTR pbstrTextRTF);
    HRESULT get_SelStart(int* plSelStart);
    HRESULT put_SelStart(int plSelStart);
    HRESULT get_SelLength(int* plSelLength);
    HRESULT put_SelLength(int plSelLength);
    HRESULT get_SelText(BSTR* pbstrSelText);
    HRESULT put_SelText(BSTR pbstrSelText);
    HRESULT get_SelRTF(BSTR* pbstrSelRTF);
    HRESULT put_SelRTF(BSTR pbstrSelRTF);
    HRESULT Refresh();
}

@GUID("E3B0B797-A72E-46DB-A0D7-6C9EBA8E9BBC")
interface _IInkEditEvents : IDispatch
{
}

@GUID("EBA615AA-FAC6-4738-BA5F-FF09E9FE473E")
interface IMathInputControl : IDispatch
{
    HRESULT Show();
    HRESULT Hide();
    HRESULT IsVisible(short* pvbShown);
    HRESULT GetPosition(int* Left, int* Top, int* Right, int* Bottom);
    HRESULT SetPosition(int Left, int Top, int Right, int Bottom);
    HRESULT Clear();
    HRESULT SetCustomPaint(int Element, short Paint);
    HRESULT SetCaptionText(BSTR CaptionText);
    HRESULT LoadInk(IInkDisp Ink);
    HRESULT SetOwnerWindow(ptrdiff_t OwnerWindow);
    HRESULT EnableExtendedButtons(short Extended);
    HRESULT GetPreviewHeight(int* Height);
    HRESULT SetPreviewHeight(int Height);
    HRESULT EnableAutoGrow(short AutoGrow);
    HRESULT AddFunctionName(BSTR FunctionName);
    HRESULT RemoveFunctionName(BSTR FunctionName);
    HRESULT GetHoverIcon(IPictureDisp* HoverImage);
}

@GUID("683336B5-A47D-4358-96F9-875A472AE70A")
interface _IMathInputControlEvents : IDispatch
{
}

@GUID("A8BB5D22-3144-4A7B-93CD-F34A16BE513A")
interface IRealTimeStylus : IUnknown
{
    HRESULT get_Enabled(int* pfEnable);
    HRESULT put_Enabled(BOOL fEnable);
    HRESULT get_HWND(size_t* phwnd);
    HRESULT put_HWND(size_t hwnd);
    HRESULT get_WindowInputRectangle(RECT* prcWndInputRect);
    HRESULT put_WindowInputRectangle(const(RECT)* prcWndInputRect);
    HRESULT AddStylusSyncPlugin(uint iIndex, IStylusSyncPlugin piPlugin);
    HRESULT RemoveStylusSyncPlugin(uint iIndex, IStylusSyncPlugin* ppiPlugin);
    HRESULT RemoveAllStylusSyncPlugins();
    HRESULT GetStylusSyncPlugin(uint iIndex, IStylusSyncPlugin* ppiPlugin);
    HRESULT GetStylusSyncPluginCount(uint* pcPlugins);
    HRESULT AddStylusAsyncPlugin(uint iIndex, IStylusAsyncPlugin piPlugin);
    HRESULT RemoveStylusAsyncPlugin(uint iIndex, IStylusAsyncPlugin* ppiPlugin);
    HRESULT RemoveAllStylusAsyncPlugins();
    HRESULT GetStylusAsyncPlugin(uint iIndex, IStylusAsyncPlugin* ppiPlugin);
    HRESULT GetStylusAsyncPluginCount(uint* pcPlugins);
    HRESULT get_ChildRealTimeStylusPlugin(IRealTimeStylus* ppiRTS);
    HRESULT putref_ChildRealTimeStylusPlugin(IRealTimeStylus piRTS);
    HRESULT AddCustomStylusDataToQueue(StylusQueue sq, const(GUID)* pGuidId, uint cbData, char* pbData);
    HRESULT ClearStylusQueues();
    HRESULT SetAllTabletsMode(BOOL fUseMouseForInput);
    HRESULT SetSingleTabletMode(IInkTablet piTablet);
    HRESULT GetTablet(IInkTablet* ppiSingleTablet);
    HRESULT GetTabletContextIdFromTablet(IInkTablet piTablet, uint* ptcid);
    HRESULT GetTabletFromTabletContextId(uint tcid, IInkTablet* ppiTablet);
    HRESULT GetAllTabletContextIds(uint* pcTcidCount, char* ppTcids);
    HRESULT GetStyluses(IInkCursors* ppiInkCursors);
    HRESULT GetStylusForId(uint sid, IInkCursor* ppiInkCursor);
    HRESULT SetDesiredPacketDescription(uint cProperties, char* pPropertyGuids);
    HRESULT GetDesiredPacketDescription(uint* pcProperties, char* ppPropertyGuids);
    HRESULT GetPacketDescriptionData(uint tcid, float* pfInkToDeviceScaleX, float* pfInkToDeviceScaleY, 
                                     uint* pcPacketProperties, char* ppPacketProperties);
}

@GUID("B5F2A6CD-3179-4A3E-B9C4-BB5865962BE2")
interface IRealTimeStylus2 : IUnknown
{
    HRESULT get_FlicksEnabled(int* pfEnable);
    HRESULT put_FlicksEnabled(BOOL fEnable);
}

@GUID("D70230A3-6986-4051-B57A-1CF69F4D9DB5")
interface IRealTimeStylus3 : IUnknown
{
    HRESULT get_MultiTouchEnabled(int* pfEnable);
    HRESULT put_MultiTouchEnabled(BOOL fEnable);
}

@GUID("AA87EAB8-AB4A-4CEA-B5CB-46D84C6A2509")
interface IRealTimeStylusSynchronization : IUnknown
{
    HRESULT AcquireLock(RealTimeStylusLockType lock);
    HRESULT ReleaseLock(RealTimeStylusLockType lock);
}

@GUID("A5FD4E2D-C44B-4092-9177-260905EB672B")
interface IStrokeBuilder : IUnknown
{
    HRESULT CreateStroke(uint cPktBuffLength, char* pPackets, uint cPacketProperties, char* pPacketProperties, 
                         float fInkToDeviceScaleX, float fInkToDeviceScaleY, IInkStrokeDisp* ppIInkStroke);
    HRESULT BeginStroke(uint tcid, uint sid, const(int)* pPacket, uint cPacketProperties, char* pPacketProperties, 
                        float fInkToDeviceScaleX, float fInkToDeviceScaleY, IInkStrokeDisp* ppIInkStroke);
    HRESULT AppendPackets(uint tcid, uint sid, uint cPktBuffLength, char* pPackets);
    HRESULT EndStroke(uint tcid, uint sid, IInkStrokeDisp* ppIInkStroke, RECT* pDirtyRect);
    HRESULT get_Ink(IInkDisp* ppiInkObj);
    HRESULT putref_Ink(IInkDisp piInkObj);
}

@GUID("A81436D8-4757-4FD1-A185-133F97C6C545")
interface IStylusPlugin : IUnknown
{
    HRESULT RealTimeStylusEnabled(IRealTimeStylus piRtsSrc, uint cTcidCount, char* pTcids);
    HRESULT RealTimeStylusDisabled(IRealTimeStylus piRtsSrc, uint cTcidCount, char* pTcids);
    HRESULT StylusInRange(IRealTimeStylus piRtsSrc, uint tcid, uint sid);
    HRESULT StylusOutOfRange(IRealTimeStylus piRtsSrc, uint tcid, uint sid);
    HRESULT StylusDown(IRealTimeStylus piRtsSrc, const(StylusInfo)* pStylusInfo, uint cPropCountPerPkt, 
                       char* pPacket, int** ppInOutPkt);
    HRESULT StylusUp(IRealTimeStylus piRtsSrc, const(StylusInfo)* pStylusInfo, uint cPropCountPerPkt, 
                     char* pPacket, int** ppInOutPkt);
    HRESULT StylusButtonDown(IRealTimeStylus piRtsSrc, uint sid, const(GUID)* pGuidStylusButton, POINT* pStylusPos);
    HRESULT StylusButtonUp(IRealTimeStylus piRtsSrc, uint sid, const(GUID)* pGuidStylusButton, POINT* pStylusPos);
    HRESULT InAirPackets(IRealTimeStylus piRtsSrc, const(StylusInfo)* pStylusInfo, uint cPktCount, 
                         uint cPktBuffLength, char* pPackets, uint* pcInOutPkts, int** ppInOutPkts);
    HRESULT Packets(IRealTimeStylus piRtsSrc, const(StylusInfo)* pStylusInfo, uint cPktCount, uint cPktBuffLength, 
                    char* pPackets, uint* pcInOutPkts, int** ppInOutPkts);
    HRESULT CustomStylusDataAdded(IRealTimeStylus piRtsSrc, const(GUID)* pGuidId, uint cbData, char* pbData);
    HRESULT SystemEvent(IRealTimeStylus piRtsSrc, uint tcid, uint sid, ushort event, SYSTEM_EVENT_DATA eventdata);
    HRESULT TabletAdded(IRealTimeStylus piRtsSrc, IInkTablet piTablet);
    HRESULT TabletRemoved(IRealTimeStylus piRtsSrc, int iTabletIndex);
    HRESULT Error(IRealTimeStylus piRtsSrc, IStylusPlugin piPlugin, RealTimeStylusDataInterest dataInterest, 
                  HRESULT hrErrorCode, ptrdiff_t* lptrKey);
    HRESULT UpdateMapping(IRealTimeStylus piRtsSrc);
    HRESULT DataInterest(RealTimeStylusDataInterest* pDataInterest);
}

@GUID("A157B174-482F-4D71-A3F6-3A41DDD11BE9")
interface IStylusSyncPlugin : IStylusPlugin
{
}

@GUID("A7CCA85A-31BC-4CD2-AADC-3289A3AF11C8")
interface IStylusAsyncPlugin : IStylusPlugin
{
}

@GUID("A079468E-7165-46F9-B7AF-98AD01A93009")
interface IDynamicRenderer : IUnknown
{
    HRESULT get_Enabled(int* bEnabled);
    HRESULT put_Enabled(BOOL bEnabled);
    HRESULT get_HWND(size_t* hwnd);
    HRESULT put_HWND(size_t hwnd);
    HRESULT get_ClipRectangle(RECT* prcClipRect);
    HRESULT put_ClipRectangle(const(RECT)* prcClipRect);
    HRESULT get_ClipRegion(size_t* phClipRgn);
    HRESULT put_ClipRegion(size_t hClipRgn);
    HRESULT get_DrawingAttributes(IInkDrawingAttributes* ppiDA);
    HRESULT putref_DrawingAttributes(IInkDrawingAttributes piDA);
    HRESULT get_DataCacheEnabled(int* pfCacheData);
    HRESULT put_DataCacheEnabled(BOOL fCacheData);
    HRESULT ReleaseCachedData(uint strokeId);
    HRESULT Refresh();
    HRESULT Draw(size_t hDC);
}

@GUID("AE9EF86B-7054-45E3-AE22-3174DC8811B7")
interface IGestureRecognizer : IUnknown
{
    HRESULT get_Enabled(int* pfEnabled);
    HRESULT put_Enabled(BOOL fEnabled);
    HRESULT get_MaxStrokeCount(int* pcStrokes);
    HRESULT put_MaxStrokeCount(int cStrokes);
    HRESULT EnableGestures(uint cGestures, char* pGestures);
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
