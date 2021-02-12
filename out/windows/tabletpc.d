module windows.tabletpc;

public import system;
public import windows.automation;
public import windows.com;
public import windows.controls;
public import windows.displaydevices;
public import windows.gdi;
public import windows.systemservices;
public import windows.windowsandmessaging;

extern(Windows):

alias PfnRecoCallback = extern(Windows) HRESULT function(uint param0, ubyte* param1, HRECOCONTEXT__* param2);
@DllImport("inkobjcore.dll")
HRESULT CreateRecognizer(Guid* pCLSID, HRECOGNIZER__** phrec);

@DllImport("inkobjcore.dll")
HRESULT DestroyRecognizer(HRECOGNIZER__* hrec);

@DllImport("inkobjcore.dll")
HRESULT GetRecoAttributes(HRECOGNIZER__* hrec, RECO_ATTRS* pRecoAttrs);

@DllImport("inkobjcore.dll")
HRESULT CreateContext(HRECOGNIZER__* hrec, HRECOCONTEXT__** phrc);

@DllImport("inkobjcore.dll")
HRESULT DestroyContext(HRECOCONTEXT__* hrc);

@DllImport("inkobjcore.dll")
HRESULT GetResultPropertyList(HRECOGNIZER__* hrec, uint* pPropertyCount, Guid* pPropertyGuid);

@DllImport("inkobjcore.dll")
HRESULT GetUnicodeRanges(HRECOGNIZER__* hrec, uint* pcRanges, CHARACTER_RANGE* pcr);

@DllImport("inkobjcore.dll")
HRESULT AddStroke(HRECOCONTEXT__* hrc, const(PACKET_DESCRIPTION)* pPacketDesc, uint cbPacket, const(ubyte)* pPacket, const(XFORM)* pXForm);

@DllImport("inkobjcore.dll")
HRESULT GetBestResultString(HRECOCONTEXT__* hrc, uint* pcSize, char* pwcBestResult);

@DllImport("inkobjcore.dll")
HRESULT SetGuide(HRECOCONTEXT__* hrc, const(RECO_GUIDE)* pGuide, uint iIndex);

@DllImport("inkobjcore.dll")
HRESULT AdviseInkChange(HRECOCONTEXT__* hrc, BOOL bNewStroke);

@DllImport("inkobjcore.dll")
HRESULT EndInkInput(HRECOCONTEXT__* hrc);

@DllImport("inkobjcore.dll")
HRESULT Process(HRECOCONTEXT__* hrc, int* pbPartialProcessing);

@DllImport("inkobjcore.dll")
HRESULT SetFactoid(HRECOCONTEXT__* hrc, uint cwcFactoid, const(wchar)* pwcFactoid);

@DllImport("inkobjcore.dll")
HRESULT SetFlags(HRECOCONTEXT__* hrc, uint dwFlags);

@DllImport("inkobjcore.dll")
HRESULT GetLatticePtr(HRECOCONTEXT__* hrc, RECO_LATTICE** ppLattice);

@DllImport("inkobjcore.dll")
HRESULT SetTextContext(HRECOCONTEXT__* hrc, uint cwcBefore, const(wchar)* pwcBefore, uint cwcAfter, const(wchar)* pwcAfter);

@DllImport("inkobjcore.dll")
HRESULT SetEnabledUnicodeRanges(HRECOCONTEXT__* hrc, uint cRanges, CHARACTER_RANGE* pcr);

@DllImport("inkobjcore.dll")
HRESULT IsStringSupported(HRECOCONTEXT__* hrc, uint wcString, const(wchar)* pwcString);

@DllImport("inkobjcore.dll")
HRESULT SetWordList(HRECOCONTEXT__* hrc, HRECOWORDLIST__* hwl);

@DllImport("inkobjcore.dll")
HRESULT GetRightSeparator(HRECOCONTEXT__* hrc, uint* pcSize, char* pwcRightSeparator);

@DllImport("inkobjcore.dll")
HRESULT GetLeftSeparator(HRECOCONTEXT__* hrc, uint* pcSize, char* pwcLeftSeparator);

@DllImport("inkobjcore.dll")
HRESULT DestroyWordList(HRECOWORDLIST__* hwl);

@DllImport("inkobjcore.dll")
HRESULT AddWordsToWordList(HRECOWORDLIST__* hwl, char* pwcWords);

@DllImport("inkobjcore.dll")
HRESULT MakeWordList(HRECOGNIZER__* hrec, char* pBuffer, HRECOWORDLIST__** phwl);

@DllImport("inkobjcore.dll")
HRESULT GetAllRecognizers(Guid** recognizerClsids, uint* count);

@DllImport("inkobjcore.dll")
HRESULT LoadCachedAttributes(Guid clsid, RECO_ATTRS* pRecoAttributes);

const GUID CLSID_InkDisp = {0x937C1A34, 0x151D, 0x4610, [0x9C, 0xA6, 0xA8, 0xCC, 0x9B, 0xDB, 0x5D, 0x83]};
@GUID(0x937C1A34, 0x151D, 0x4610, [0x9C, 0xA6, 0xA8, 0xCC, 0x9B, 0xDB, 0x5D, 0x83]);
struct InkDisp;

const GUID CLSID_InkOverlay = {0x65D00646, 0xCDE3, 0x4A88, [0x91, 0x63, 0x67, 0x69, 0xF0, 0xF1, 0xA9, 0x7D]};
@GUID(0x65D00646, 0xCDE3, 0x4A88, [0x91, 0x63, 0x67, 0x69, 0xF0, 0xF1, 0xA9, 0x7D]);
struct InkOverlay;

const GUID CLSID_InkPicture = {0x04A1E553, 0xFE36, 0x4FDE, [0x86, 0x5E, 0x34, 0x41, 0x94, 0xE6, 0x94, 0x24]};
@GUID(0x04A1E553, 0xFE36, 0x4FDE, [0x86, 0x5E, 0x34, 0x41, 0x94, 0xE6, 0x94, 0x24]);
struct InkPicture;

const GUID CLSID_InkCollector = {0x43FB1553, 0xAD74, 0x4EE8, [0x88, 0xE4, 0x3E, 0x6D, 0xAA, 0xC9, 0x15, 0xDB]};
@GUID(0x43FB1553, 0xAD74, 0x4EE8, [0x88, 0xE4, 0x3E, 0x6D, 0xAA, 0xC9, 0x15, 0xDB]);
struct InkCollector;

const GUID CLSID_InkDrawingAttributes = {0xD8BF32A2, 0x05A5, 0x44C3, [0xB3, 0xAA, 0x5E, 0x80, 0xAC, 0x7D, 0x25, 0x76]};
@GUID(0xD8BF32A2, 0x05A5, 0x44C3, [0xB3, 0xAA, 0x5E, 0x80, 0xAC, 0x7D, 0x25, 0x76]);
struct InkDrawingAttributes;

const GUID CLSID_InkRectangle = {0x43B07326, 0xAAE0, 0x4B62, [0xA8, 0x3D, 0x5F, 0xD7, 0x68, 0xB7, 0x35, 0x3C]};
@GUID(0x43B07326, 0xAAE0, 0x4B62, [0xA8, 0x3D, 0x5F, 0xD7, 0x68, 0xB7, 0x35, 0x3C]);
struct InkRectangle;

const GUID CLSID_InkRenderer = {0x9C1CC6E4, 0xD7EB, 0x4EEB, [0x90, 0x91, 0x15, 0xA7, 0xC8, 0x79, 0x1E, 0xD9]};
@GUID(0x9C1CC6E4, 0xD7EB, 0x4EEB, [0x90, 0x91, 0x15, 0xA7, 0xC8, 0x79, 0x1E, 0xD9]);
struct InkRenderer;

const GUID CLSID_InkTransform = {0xE3D5D93C, 0x1663, 0x4A78, [0xA1, 0xA7, 0x22, 0x37, 0x5D, 0xFE, 0xBA, 0xEE]};
@GUID(0xE3D5D93C, 0x1663, 0x4A78, [0xA1, 0xA7, 0x22, 0x37, 0x5D, 0xFE, 0xBA, 0xEE]);
struct InkTransform;

const GUID CLSID_InkRecognizers = {0x9FD4E808, 0xF6E6, 0x4E65, [0x98, 0xD3, 0xAA, 0x39, 0x05, 0x4C, 0x12, 0x55]};
@GUID(0x9FD4E808, 0xF6E6, 0x4E65, [0x98, 0xD3, 0xAA, 0x39, 0x05, 0x4C, 0x12, 0x55]);
struct InkRecognizers;

const GUID CLSID_InkRecognizerContext = {0xAAC46A37, 0x9229, 0x4FC0, [0x8C, 0xCE, 0x44, 0x97, 0x56, 0x9B, 0xF4, 0xD1]};
@GUID(0xAAC46A37, 0x9229, 0x4FC0, [0x8C, 0xCE, 0x44, 0x97, 0x56, 0x9B, 0xF4, 0xD1]);
struct InkRecognizerContext;

const GUID CLSID_InkRecognizerGuide = {0x8770D941, 0xA63A, 0x4671, [0xA3, 0x75, 0x28, 0x55, 0xA1, 0x8E, 0xBA, 0x73]};
@GUID(0x8770D941, 0xA63A, 0x4671, [0xA3, 0x75, 0x28, 0x55, 0xA1, 0x8E, 0xBA, 0x73]);
struct InkRecognizerGuide;

const GUID CLSID_InkTablets = {0x6E4FCB12, 0x510A, 0x4D40, [0x93, 0x04, 0x1D, 0xA1, 0x0A, 0xE9, 0x14, 0x7C]};
@GUID(0x6E4FCB12, 0x510A, 0x4D40, [0x93, 0x04, 0x1D, 0xA1, 0x0A, 0xE9, 0x14, 0x7C]);
struct InkTablets;

const GUID CLSID_InkWordList = {0x9DE85094, 0xF71F, 0x44F1, [0x84, 0x71, 0x15, 0xA2, 0xFA, 0x76, 0xFC, 0xF3]};
@GUID(0x9DE85094, 0xF71F, 0x44F1, [0x84, 0x71, 0x15, 0xA2, 0xFA, 0x76, 0xFC, 0xF3]);
struct InkWordList;

const GUID CLSID_InkStrokes = {0x48F491BC, 0x240E, 0x4860, [0xB0, 0x79, 0xA1, 0xE9, 0x4D, 0x3D, 0x2C, 0x86]};
@GUID(0x48F491BC, 0x240E, 0x4860, [0xB0, 0x79, 0xA1, 0xE9, 0x4D, 0x3D, 0x2C, 0x86]);
struct InkStrokes;

const GUID CLSID_Ink = {0x13DE4A42, 0x8D21, 0x4C8E, [0xBF, 0x9C, 0x8F, 0x69, 0xCB, 0x06, 0x8F, 0xCA]};
@GUID(0x13DE4A42, 0x8D21, 0x4C8E, [0xBF, 0x9C, 0x8F, 0x69, 0xCB, 0x06, 0x8F, 0xCA]);
struct Ink;

const GUID CLSID_SketchInk = {0xF0291081, 0xE87C, 0x4E07, [0x97, 0xDA, 0xA0, 0xA0, 0x37, 0x61, 0xE5, 0x86]};
@GUID(0xF0291081, 0xE87C, 0x4E07, [0x97, 0xDA, 0xA0, 0xA0, 0x37, 0x61, 0xE5, 0x86]);
struct SketchInk;

enum PROPERTY_UNITS
{
    PROPERTY_UNITS_DEFAULT = 0,
    PROPERTY_UNITS_INCHES = 1,
    PROPERTY_UNITS_CENTIMETERS = 2,
    PROPERTY_UNITS_DEGREES = 3,
    PROPERTY_UNITS_RADIANS = 4,
    PROPERTY_UNITS_SECONDS = 5,
    PROPERTY_UNITS_POUNDS = 6,
    PROPERTY_UNITS_GRAMS = 7,
    PROPERTY_UNITS_SILINEAR = 8,
    PROPERTY_UNITS_SIROTATION = 9,
    PROPERTY_UNITS_ENGLINEAR = 10,
    PROPERTY_UNITS_ENGROTATION = 11,
    PROPERTY_UNITS_SLUGS = 12,
    PROPERTY_UNITS_KELVIN = 13,
    PROPERTY_UNITS_FAHRENHEIT = 14,
    PROPERTY_UNITS_AMPERE = 15,
    PROPERTY_UNITS_CANDELA = 16,
}

struct SYSTEM_EVENT_DATA
{
    ubyte bModifier;
    ushort wKey;
    int xPos;
    int yPos;
    ubyte bCursorMode;
    uint dwButtonState;
}

struct STROKE_RANGE
{
    uint iStrokeBegin;
    uint iStrokeEnd;
}

struct PROPERTY_METRICS
{
    int nLogicalMin;
    int nLogicalMax;
    PROPERTY_UNITS Units;
    float fResolution;
}

struct PACKET_PROPERTY
{
    Guid guid;
    PROPERTY_METRICS PropertyMetrics;
}

struct PACKET_DESCRIPTION
{
    uint cbPacketSize;
    uint cPacketProperties;
    PACKET_PROPERTY* pPacketProperties;
    uint cButtons;
    Guid* pguidButtons;
}

enum enumINKMETRIC_FLAGS
{
    IMF_FONT_SELECTED_IN_HDC = 1,
    IMF_ITALIC = 2,
    IMF_BOLD = 4,
}

enum enumGetCandidateFlags
{
    TCF_ALLOW_RECOGNITION = 1,
    TCF_FORCE_RECOGNITION = 2,
}

struct INKMETRIC
{
    int iHeight;
    int iFontAscent;
    int iFontDescent;
    uint dwFlags;
    uint color;
}

enum InkSelectionConstants
{
    ISC_FirstElement = 0,
    ISC_AllElements = -1,
}

enum InkBoundingBoxMode
{
    IBBM_Default = 0,
    IBBM_NoCurveFit = 1,
    IBBM_CurveFit = 2,
    IBBM_PointsOnly = 3,
    IBBM_Union = 4,
}

enum InkExtractFlags
{
    IEF_CopyFromOriginal = 0,
    IEF_RemoveFromOriginal = 1,
    IEF_Default = 1,
}

enum InkPersistenceFormat
{
    IPF_InkSerializedFormat = 0,
    IPF_Base64InkSerializedFormat = 1,
    IPF_GIF = 2,
    IPF_Base64GIF = 3,
}

enum InkPersistenceCompressionMode
{
    IPCM_Default = 0,
    IPCM_MaximumCompression = 1,
    IPCM_NoCompression = 2,
}

enum InkPenTip
{
    IPT_Ball = 0,
    IPT_Rectangle = 1,
}

enum InkRasterOperation
{
    IRO_Black = 1,
    IRO_NotMergePen = 2,
    IRO_MaskNotPen = 3,
    IRO_NotCopyPen = 4,
    IRO_MaskPenNot = 5,
    IRO_Not = 6,
    IRO_XOrPen = 7,
    IRO_NotMaskPen = 8,
    IRO_MaskPen = 9,
    IRO_NotXOrPen = 10,
    IRO_NoOperation = 11,
    IRO_MergeNotPen = 12,
    IRO_CopyPen = 13,
    IRO_MergePenNot = 14,
    IRO_MergePen = 15,
    IRO_White = 16,
}

enum InkMousePointer
{
    IMP_Default = 0,
    IMP_Arrow = 1,
    IMP_Crosshair = 2,
    IMP_Ibeam = 3,
    IMP_SizeNESW = 4,
    IMP_SizeNS = 5,
    IMP_SizeNWSE = 6,
    IMP_SizeWE = 7,
    IMP_UpArrow = 8,
    IMP_Hourglass = 9,
    IMP_NoDrop = 10,
    IMP_ArrowHourglass = 11,
    IMP_ArrowQuestion = 12,
    IMP_SizeAll = 13,
    IMP_Hand = 14,
    IMP_Custom = 99,
}

enum InkClipboardModes
{
    ICB_Copy = 0,
    ICB_Cut = 1,
    ICB_ExtractOnly = 48,
    ICB_DelayedCopy = 32,
    ICB_Default = 0,
}

enum InkClipboardFormats
{
    ICF_None = 0,
    ICF_InkSerializedFormat = 1,
    ICF_SketchInk = 2,
    ICF_TextInk = 6,
    ICF_EnhancedMetafile = 8,
    ICF_Metafile = 32,
    ICF_Bitmap = 64,
    ICF_PasteMask = 7,
    ICF_CopyMask = 127,
    ICF_Default = 127,
}

enum SelectionHitResult
{
    SHR_None = 0,
    SHR_NW = 1,
    SHR_SE = 2,
    SHR_NE = 3,
    SHR_SW = 4,
    SHR_E = 5,
    SHR_W = 6,
    SHR_N = 7,
    SHR_S = 8,
    SHR_Selection = 9,
}

enum InkRecognitionStatus
{
    IRS_NoError = 0,
    IRS_Interrupted = 1,
    IRS_ProcessFailed = 2,
    IRS_InkAddedFailed = 4,
    IRS_SetAutoCompletionModeFailed = 8,
    IRS_SetStrokesFailed = 16,
    IRS_SetGuideFailed = 32,
    IRS_SetFlagsFailed = 64,
    IRS_SetFactoidFailed = 128,
    IRS_SetPrefixSuffixFailed = 256,
    IRS_SetWordListFailed = 512,
}

enum DISPID_InkRectangle
{
    DISPID_IRTop = 1,
    DISPID_IRLeft = 2,
    DISPID_IRBottom = 3,
    DISPID_IRRight = 4,
    DISPID_IRGetRectangle = 5,
    DISPID_IRSetRectangle = 6,
    DISPID_IRData = 7,
}

enum DISPID_InkExtendedProperty
{
    DISPID_IEPGuid = 1,
    DISPID_IEPData = 2,
}

enum DISPID_InkExtendedProperties
{
    DISPID_IEPs_NewEnum = -4,
    DISPID_IEPsItem = 0,
    DISPID_IEPsCount = 1,
    DISPID_IEPsAdd = 2,
    DISPID_IEPsRemove = 3,
    DISPID_IEPsClear = 4,
    DISPID_IEPsDoesPropertyExist = 5,
}

enum DISPID_InkDrawingAttributes
{
    DISPID_DAHeight = 1,
    DISPID_DAColor = 2,
    DISPID_DAWidth = 3,
    DISPID_DAFitToCurve = 4,
    DISPID_DAIgnorePressure = 5,
    DISPID_DAAntiAliased = 6,
    DISPID_DATransparency = 7,
    DISPID_DARasterOperation = 8,
    DISPID_DAPenTip = 9,
    DISPID_DAClone = 10,
    DISPID_DAExtendedProperties = 11,
}

enum DISPID_InkTransform
{
    DISPID_ITReset = 1,
    DISPID_ITTranslate = 2,
    DISPID_ITRotate = 3,
    DISPID_ITReflect = 4,
    DISPID_ITShear = 5,
    DISPID_ITScale = 6,
    DISPID_ITeM11 = 7,
    DISPID_ITeM12 = 8,
    DISPID_ITeM21 = 9,
    DISPID_ITeM22 = 10,
    DISPID_ITeDx = 11,
    DISPID_ITeDy = 12,
    DISPID_ITGetTransform = 13,
    DISPID_ITSetTransform = 14,
    DISPID_ITData = 15,
}

enum InkApplicationGesture
{
    IAG_AllGestures = 0,
    IAG_NoGesture = 61440,
    IAG_Scratchout = 61441,
    IAG_Triangle = 61442,
    IAG_Square = 61443,
    IAG_Star = 61444,
    IAG_Check = 61445,
    IAG_Curlicue = 61456,
    IAG_DoubleCurlicue = 61457,
    IAG_Circle = 61472,
    IAG_DoubleCircle = 61473,
    IAG_SemiCircleLeft = 61480,
    IAG_SemiCircleRight = 61481,
    IAG_ChevronUp = 61488,
    IAG_ChevronDown = 61489,
    IAG_ChevronLeft = 61490,
    IAG_ChevronRight = 61491,
    IAG_ArrowUp = 61496,
    IAG_ArrowDown = 61497,
    IAG_ArrowLeft = 61498,
    IAG_ArrowRight = 61499,
    IAG_Up = 61528,
    IAG_Down = 61529,
    IAG_Left = 61530,
    IAG_Right = 61531,
    IAG_UpDown = 61536,
    IAG_DownUp = 61537,
    IAG_LeftRight = 61538,
    IAG_RightLeft = 61539,
    IAG_UpLeftLong = 61540,
    IAG_UpRightLong = 61541,
    IAG_DownLeftLong = 61542,
    IAG_DownRightLong = 61543,
    IAG_UpLeft = 61544,
    IAG_UpRight = 61545,
    IAG_DownLeft = 61546,
    IAG_DownRight = 61547,
    IAG_LeftUp = 61548,
    IAG_LeftDown = 61549,
    IAG_RightUp = 61550,
    IAG_RightDown = 61551,
    IAG_Exclamation = 61604,
    IAG_Tap = 61680,
    IAG_DoubleTap = 61681,
}

enum InkSystemGesture
{
    ISG_Tap = 16,
    ISG_DoubleTap = 17,
    ISG_RightTap = 18,
    ISG_Drag = 19,
    ISG_RightDrag = 20,
    ISG_HoldEnter = 21,
    ISG_HoldLeave = 22,
    ISG_HoverEnter = 23,
    ISG_HoverLeave = 24,
    ISG_Flick = 31,
}

enum InkRecognitionConfidence
{
    IRC_Strong = 0,
    IRC_Intermediate = 1,
    IRC_Poor = 2,
}

enum DISPID_InkGesture
{
    DISPID_IGId = 0,
    DISPID_IGGetHotPoint = 1,
    DISPID_IGConfidence = 2,
}

enum DISPID_InkCursor
{
    DISPID_ICsrName = 0,
    DISPID_ICsrId = 1,
    DISPID_ICsrDrawingAttributes = 2,
    DISPID_ICsrButtons = 3,
    DISPID_ICsrInverted = 4,
    DISPID_ICsrTablet = 5,
}

enum DISPID_InkCursors
{
    DISPID_ICs_NewEnum = -4,
    DISPID_ICsItem = 0,
    DISPID_ICsCount = 1,
}

enum InkCursorButtonState
{
    ICBS_Unavailable = 0,
    ICBS_Up = 1,
    ICBS_Down = 2,
}

enum DISPID_InkCursorButton
{
    DISPID_ICBName = 0,
    DISPID_ICBId = 1,
    DISPID_ICBState = 2,
}

enum DISPID_InkCursorButtons
{
    DISPID_ICBs_NewEnum = -4,
    DISPID_ICBsItem = 0,
    DISPID_ICBsCount = 1,
}

enum TabletHardwareCapabilities
{
    THWC_Integrated = 1,
    THWC_CursorMustTouch = 2,
    THWC_HardProximity = 4,
    THWC_CursorsHavePhysicalIds = 8,
}

enum TabletPropertyMetricUnit
{
    TPMU_Default = 0,
    TPMU_Inches = 1,
    TPMU_Centimeters = 2,
    TPMU_Degrees = 3,
    TPMU_Radians = 4,
    TPMU_Seconds = 5,
    TPMU_Pounds = 6,
    TPMU_Grams = 7,
}

enum DISPID_InkTablet
{
    DISPID_ITName = 0,
    DISPID_ITPlugAndPlayId = 1,
    DISPID_ITPropertyMetrics = 2,
    DISPID_ITIsPacketPropertySupported = 3,
    DISPID_ITMaximumInputRectangle = 4,
    DISPID_ITHardwareCapabilities = 5,
}

enum TabletDeviceKind
{
    TDK_Mouse = 0,
    TDK_Pen = 1,
    TDK_Touch = 2,
}

enum DISPID_InkTablet2
{
    DISPID_IT2DeviceKind = 0,
}

enum DISPID_InkTablet3
{
    DISPID_IT3IsMultiTouch = 0,
    DISPID_IT3MaximumCursors = 1,
}

enum DISPID_InkTablets
{
    DISPID_ITs_NewEnum = -4,
    DISPID_ITsItem = 0,
    DISPID_ITsDefaultTablet = 1,
    DISPID_ITsCount = 2,
    DISPID_ITsIsPacketPropertySupported = 3,
}

enum DISPID_InkStrokeDisp
{
    DISPID_ISDInkIndex = 1,
    DISPID_ISDID = 2,
    DISPID_ISDGetBoundingBox = 3,
    DISPID_ISDDrawingAttributes = 4,
    DISPID_ISDFindIntersections = 5,
    DISPID_ISDGetRectangleIntersections = 6,
    DISPID_ISDClip = 7,
    DISPID_ISDHitTestCircle = 8,
    DISPID_ISDNearestPoint = 9,
    DISPID_ISDSplit = 10,
    DISPID_ISDExtendedProperties = 11,
    DISPID_ISDInk = 12,
    DISPID_ISDBezierPoints = 13,
    DISPID_ISDPolylineCusps = 14,
    DISPID_ISDBezierCusps = 15,
    DISPID_ISDSelfIntersections = 16,
    DISPID_ISDPacketCount = 17,
    DISPID_ISDPacketSize = 18,
    DISPID_ISDPacketDescription = 19,
    DISPID_ISDDeleted = 20,
    DISPID_ISDGetPacketDescriptionPropertyMetrics = 21,
    DISPID_ISDGetPoints = 22,
    DISPID_ISDSetPoints = 23,
    DISPID_ISDGetPacketData = 24,
    DISPID_ISDGetPacketValuesByProperty = 25,
    DISPID_ISDSetPacketValuesByProperty = 26,
    DISPID_ISDGetFlattenedBezierPoints = 27,
    DISPID_ISDScaleToRectangle = 28,
    DISPID_ISDTransform = 29,
    DISPID_ISDMove = 30,
    DISPID_ISDRotate = 31,
    DISPID_ISDShear = 32,
    DISPID_ISDScale = 33,
}

enum DISPID_InkStrokes
{
    DISPID_ISs_NewEnum = -4,
    DISPID_ISsItem = 0,
    DISPID_ISsCount = 1,
    DISPID_ISsValid = 2,
    DISPID_ISsInk = 3,
    DISPID_ISsAdd = 4,
    DISPID_ISsAddStrokes = 5,
    DISPID_ISsRemove = 6,
    DISPID_ISsRemoveStrokes = 7,
    DISPID_ISsToString = 8,
    DISPID_ISsModifyDrawingAttributes = 9,
    DISPID_ISsGetBoundingBox = 10,
    DISPID_ISsScaleToRectangle = 11,
    DISPID_ISsTransform = 12,
    DISPID_ISsMove = 13,
    DISPID_ISsRotate = 14,
    DISPID_ISsShear = 15,
    DISPID_ISsScale = 16,
    DISPID_ISsClip = 17,
    DISPID_ISsRecognitionResult = 18,
    DISPID_ISsRemoveRecognitionResult = 19,
}

enum DISPID_InkCustomStrokes
{
    DISPID_ICSs_NewEnum = -4,
    DISPID_ICSsItem = 0,
    DISPID_ICSsCount = 1,
    DISPID_ICSsAdd = 2,
    DISPID_ICSsRemove = 3,
    DISPID_ICSsClear = 4,
}

enum DISPID_StrokeEvent
{
    DISPID_SEStrokesAdded = 1,
    DISPID_SEStrokesRemoved = 2,
}

enum DISPID_Ink
{
    DISPID_IStrokes = 1,
    DISPID_IExtendedProperties = 2,
    DISPID_IGetBoundingBox = 3,
    DISPID_IDeleteStrokes = 4,
    DISPID_IDeleteStroke = 5,
    DISPID_IExtractStrokes = 6,
    DISPID_IExtractWithRectangle = 7,
    DISPID_IDirty = 8,
    DISPID_ICustomStrokes = 9,
    DISPID_IClone = 10,
    DISPID_IHitTestCircle = 11,
    DISPID_IHitTestWithRectangle = 12,
    DISPID_IHitTestWithLasso = 13,
    DISPID_INearestPoint = 14,
    DISPID_ICreateStrokes = 15,
    DISPID_ICreateStroke = 16,
    DISPID_IAddStrokesAtRectangle = 17,
    DISPID_IClip = 18,
    DISPID_ISave = 19,
    DISPID_ILoad = 20,
    DISPID_ICreateStrokeFromPoints = 21,
    DISPID_IClipboardCopyWithRectangle = 22,
    DISPID_IClipboardCopy = 23,
    DISPID_ICanPaste = 24,
    DISPID_IClipboardPaste = 25,
}

enum DISPID_InkEvent
{
    DISPID_IEInkAdded = 1,
    DISPID_IEInkDeleted = 2,
}

enum DISPID_InkRenderer
{
    DISPID_IRGetViewTransform = 1,
    DISPID_IRSetViewTransform = 2,
    DISPID_IRGetObjectTransform = 3,
    DISPID_IRSetObjectTransform = 4,
    DISPID_IRDraw = 5,
    DISPID_IRDrawStroke = 6,
    DISPID_IRPixelToInkSpace = 7,
    DISPID_IRInkSpaceToPixel = 8,
    DISPID_IRPixelToInkSpaceFromPoints = 9,
    DISPID_IRInkSpaceToPixelFromPoints = 10,
    DISPID_IRMeasure = 11,
    DISPID_IRMeasureStroke = 12,
    DISPID_IRMove = 13,
    DISPID_IRRotate = 14,
    DISPID_IRScale = 15,
}

enum InkCollectorEventInterest
{
    ICEI_DefaultEvents = -1,
    ICEI_CursorDown = 0,
    ICEI_Stroke = 1,
    ICEI_NewPackets = 2,
    ICEI_NewInAirPackets = 3,
    ICEI_CursorButtonDown = 4,
    ICEI_CursorButtonUp = 5,
    ICEI_CursorInRange = 6,
    ICEI_CursorOutOfRange = 7,
    ICEI_SystemGesture = 8,
    ICEI_TabletAdded = 9,
    ICEI_TabletRemoved = 10,
    ICEI_MouseDown = 11,
    ICEI_MouseMove = 12,
    ICEI_MouseUp = 13,
    ICEI_MouseWheel = 14,
    ICEI_DblClick = 15,
    ICEI_AllEvents = 16,
}

enum InkMouseButton
{
    IMF_Left = 1,
    IMF_Right = 2,
    IMF_Middle = 4,
}

enum InkShiftKeyModifierFlags
{
    IKM_Shift = 1,
    IKM_Control = 2,
    IKM_Alt = 4,
}

enum DISPID_InkCollectorEvent
{
    DISPID_ICEStroke = 1,
    DISPID_ICECursorDown = 2,
    DISPID_ICENewPackets = 3,
    DISPID_ICENewInAirPackets = 4,
    DISPID_ICECursorButtonDown = 5,
    DISPID_ICECursorButtonUp = 6,
    DISPID_ICECursorInRange = 7,
    DISPID_ICECursorOutOfRange = 8,
    DISPID_ICESystemGesture = 9,
    DISPID_ICEGesture = 10,
    DISPID_ICETabletAdded = 11,
    DISPID_ICETabletRemoved = 12,
    DISPID_IOEPainting = 13,
    DISPID_IOEPainted = 14,
    DISPID_IOESelectionChanging = 15,
    DISPID_IOESelectionChanged = 16,
    DISPID_IOESelectionMoving = 17,
    DISPID_IOESelectionMoved = 18,
    DISPID_IOESelectionResizing = 19,
    DISPID_IOESelectionResized = 20,
    DISPID_IOEStrokesDeleting = 21,
    DISPID_IOEStrokesDeleted = 22,
    DISPID_IPEChangeUICues = 23,
    DISPID_IPEClick = 24,
    DISPID_IPEDblClick = 25,
    DISPID_IPEInvalidated = 26,
    DISPID_IPEMouseDown = 27,
    DISPID_IPEMouseEnter = 28,
    DISPID_IPEMouseHover = 29,
    DISPID_IPEMouseLeave = 30,
    DISPID_IPEMouseMove = 31,
    DISPID_IPEMouseUp = 32,
    DISPID_IPEMouseWheel = 33,
    DISPID_IPESizeModeChanged = 34,
    DISPID_IPEStyleChanged = 35,
    DISPID_IPESystemColorsChanged = 36,
    DISPID_IPEKeyDown = 37,
    DISPID_IPEKeyPress = 38,
    DISPID_IPEKeyUp = 39,
    DISPID_IPEResize = 40,
    DISPID_IPESizeChanged = 41,
}

enum InkOverlayEditingMode
{
    IOEM_Ink = 0,
    IOEM_Delete = 1,
    IOEM_Select = 2,
}

enum InkOverlayAttachMode
{
    IOAM_Behind = 0,
    IOAM_InFront = 1,
}

enum InkPictureSizeMode
{
    IPSM_AutoSize = 0,
    IPSM_CenterImage = 1,
    IPSM_Normal = 2,
    IPSM_StretchImage = 3,
}

enum InkOverlayEraserMode
{
    IOERM_StrokeErase = 0,
    IOERM_PointErase = 1,
}

enum InkCollectionMode
{
    ICM_InkOnly = 0,
    ICM_GestureOnly = 1,
    ICM_InkAndGesture = 2,
}

enum DISPID_InkCollector
{
    DISPID_ICEnabled = 1,
    DISPID_ICHwnd = 2,
    DISPID_ICPaint = 3,
    DISPID_ICText = 4,
    DISPID_ICDefaultDrawingAttributes = 5,
    DISPID_ICRenderer = 6,
    DISPID_ICInk = 7,
    DISPID_ICAutoRedraw = 8,
    DISPID_ICCollectingInk = 9,
    DISPID_ICSetEventInterest = 10,
    DISPID_ICGetEventInterest = 11,
    DISPID_IOEditingMode = 12,
    DISPID_IOSelection = 13,
    DISPID_IOAttachMode = 14,
    DISPID_IOHitTestSelection = 15,
    DISPID_IODraw = 16,
    DISPID_IPPicture = 17,
    DISPID_IPSizeMode = 18,
    DISPID_IPBackColor = 19,
    DISPID_ICCursors = 20,
    DISPID_ICMarginX = 21,
    DISPID_ICMarginY = 22,
    DISPID_ICSetWindowInputRectangle = 23,
    DISPID_ICGetWindowInputRectangle = 24,
    DISPID_ICTablet = 25,
    DISPID_ICSetAllTabletsMode = 26,
    DISPID_ICSetSingleTabletIntegratedMode = 27,
    DISPID_ICCollectionMode = 28,
    DISPID_ICSetGestureStatus = 29,
    DISPID_ICGetGestureStatus = 30,
    DISPID_ICDynamicRendering = 31,
    DISPID_ICDesiredPacketDescription = 32,
    DISPID_IOEraserMode = 33,
    DISPID_IOEraserWidth = 34,
    DISPID_ICMouseIcon = 35,
    DISPID_ICMousePointer = 36,
    DISPID_IPInkEnabled = 37,
    DISPID_ICSupportHighContrastInk = 38,
    DISPID_IOSupportHighContrastSelectionUI = 39,
}

enum DISPID_InkRecognizer
{
    DISPID_RecoClsid = 1,
    DISPID_RecoName = 2,
    DISPID_RecoVendor = 3,
    DISPID_RecoCapabilities = 4,
    DISPID_RecoLanguageID = 5,
    DISPID_RecoPreferredPacketDescription = 6,
    DISPID_RecoCreateRecognizerContext = 7,
    DISPID_RecoSupportedProperties = 8,
}

enum InkRecognizerCapabilities
{
    IRC_DontCare = 1,
    IRC_Object = 2,
    IRC_FreeInput = 4,
    IRC_LinedInput = 8,
    IRC_BoxedInput = 16,
    IRC_CharacterAutoCompletionInput = 32,
    IRC_RightAndDown = 64,
    IRC_LeftAndDown = 128,
    IRC_DownAndLeft = 256,
    IRC_DownAndRight = 512,
    IRC_ArbitraryAngle = 1024,
    IRC_Lattice = 2048,
    IRC_AdviseInkChange = 4096,
    IRC_StrokeReorder = 8192,
    IRC_Personalizable = 16384,
    IRC_PrefersArbitraryAngle = 32768,
    IRC_PrefersParagraphBreaking = 65536,
    IRC_PrefersSegmentation = 131072,
    IRC_Cursive = 262144,
    IRC_TextPrediction = 524288,
    IRC_Alpha = 1048576,
    IRC_Beta = 2097152,
}

enum DISPID_InkRecognizer2
{
    DISPID_RecoId = 0,
    DISPID_RecoUnicodeRanges = 1,
}

enum DISPID_InkRecognizers
{
    DISPID_IRecos_NewEnum = -4,
    DISPID_IRecosItem = 0,
    DISPID_IRecosCount = 1,
    DISPID_IRecosGetDefaultRecognizer = 2,
}

enum InkRecognizerCharacterAutoCompletionMode
{
    IRCACM_Full = 0,
    IRCACM_Prefix = 1,
    IRCACM_Random = 2,
}

enum InkRecognitionModes
{
    IRM_None = 0,
    IRM_WordModeOnly = 1,
    IRM_Coerce = 2,
    IRM_TopInkBreaksOnly = 4,
    IRM_PrefixOk = 8,
    IRM_LineMode = 16,
    IRM_DisablePersonalization = 32,
    IRM_AutoSpace = 64,
    IRM_Max = 128,
}

enum DISPID_InkRecognitionEvent
{
    DISPID_IRERecognitionWithAlternates = 1,
    DISPID_IRERecognition = 2,
}

enum DISPID_InkRecoContext
{
    DISPID_IRecoCtx_Strokes = 1,
    DISPID_IRecoCtx_CharacterAutoCompletionMode = 2,
    DISPID_IRecoCtx_Factoid = 3,
    DISPID_IRecoCtx_WordList = 4,
    DISPID_IRecoCtx_Recognizer = 5,
    DISPID_IRecoCtx_Guide = 6,
    DISPID_IRecoCtx_Flags = 7,
    DISPID_IRecoCtx_PrefixText = 8,
    DISPID_IRecoCtx_SuffixText = 9,
    DISPID_IRecoCtx_StopRecognition = 10,
    DISPID_IRecoCtx_Clone = 11,
    DISPID_IRecoCtx_Recognize = 12,
    DISPID_IRecoCtx_StopBackgroundRecognition = 13,
    DISPID_IRecoCtx_EndInkInput = 14,
    DISPID_IRecoCtx_BackgroundRecognize = 15,
    DISPID_IRecoCtx_BackgroundRecognizeWithAlternates = 16,
    DISPID_IRecoCtx_IsStringSupported = 17,
}

enum DISPID_InkRecoContext2
{
    DISPID_IRecoCtx2_EnabledUnicodeRanges = 0,
}

enum InkRecognitionAlternatesSelection
{
    IRAS_Start = 0,
    IRAS_DefaultCount = 10,
    IRAS_All = -1,
}

enum DISPID_InkRecognitionResult
{
    DISPID_InkRecognitionResult_TopString = 1,
    DISPID_InkRecognitionResult_TopAlternate = 2,
    DISPID_InkRecognitionResult_Strokes = 3,
    DISPID_InkRecognitionResult_TopConfidence = 4,
    DISPID_InkRecognitionResult_AlternatesFromSelection = 5,
    DISPID_InkRecognitionResult_ModifyTopAlternate = 6,
    DISPID_InkRecognitionResult_SetResultOnStrokes = 7,
}

enum DISPID_InkRecoAlternate
{
    DISPID_InkRecoAlternate_String = 1,
    DISPID_InkRecoAlternate_LineNumber = 2,
    DISPID_InkRecoAlternate_Baseline = 3,
    DISPID_InkRecoAlternate_Midline = 4,
    DISPID_InkRecoAlternate_Ascender = 5,
    DISPID_InkRecoAlternate_Descender = 6,
    DISPID_InkRecoAlternate_Confidence = 7,
    DISPID_InkRecoAlternate_Strokes = 8,
    DISPID_InkRecoAlternate_GetStrokesFromStrokeRanges = 9,
    DISPID_InkRecoAlternate_GetStrokesFromTextRange = 10,
    DISPID_InkRecoAlternate_GetTextRangeFromStrokes = 11,
    DISPID_InkRecoAlternate_GetPropertyValue = 12,
    DISPID_InkRecoAlternate_LineAlternates = 13,
    DISPID_InkRecoAlternate_ConfidenceAlternates = 14,
    DISPID_InkRecoAlternate_AlternatesWithConstantPropertyValues = 15,
}

enum DISPID_InkRecognitionAlternates
{
    DISPID_InkRecognitionAlternates_NewEnum = -4,
    DISPID_InkRecognitionAlternates_Item = 0,
    DISPID_InkRecognitionAlternates_Count = 1,
    DISPID_InkRecognitionAlternates_Strokes = 2,
}

struct InkRecoGuide
{
    RECT rectWritingBox;
    RECT rectDrawnBox;
    int cRows;
    int cColumns;
    int midline;
}

enum DISPID_InkRecognizerGuide
{
    DISPID_IRGWritingBox = 1,
    DISPID_IRGDrawnBox = 2,
    DISPID_IRGRows = 3,
    DISPID_IRGColumns = 4,
    DISPID_IRGMidline = 5,
    DISPID_IRGGuideData = 6,
}

enum DISPID_InkWordList
{
    DISPID_InkWordList_AddWord = 0,
    DISPID_InkWordList_RemoveWord = 1,
    DISPID_InkWordList_Merge = 2,
}

enum DISPID_InkWordList2
{
    DISPID_InkWordList2_AddWords = 3,
}

const GUID IID_IInkRectangle = {0x9794FF82, 0x6071, 0x4717, [0x8A, 0x8B, 0x6A, 0xC7, 0xC6, 0x4A, 0x68, 0x6E]};
@GUID(0x9794FF82, 0x6071, 0x4717, [0x8A, 0x8B, 0x6A, 0xC7, 0xC6, 0x4A, 0x68, 0x6E]);
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

const GUID IID_IInkExtendedProperty = {0xDB489209, 0xB7C3, 0x411D, [0x90, 0xF6, 0x15, 0x48, 0xCF, 0xFF, 0x27, 0x1E]};
@GUID(0xDB489209, 0xB7C3, 0x411D, [0x90, 0xF6, 0x15, 0x48, 0xCF, 0xFF, 0x27, 0x1E]);
interface IInkExtendedProperty : IDispatch
{
    HRESULT get_Guid(BSTR* Guid);
    HRESULT get_Data(VARIANT* Data);
    HRESULT put_Data(VARIANT Data);
}

const GUID IID_IInkExtendedProperties = {0x89F2A8BE, 0x95A9, 0x4530, [0x8B, 0x8F, 0x88, 0xE9, 0x71, 0xE3, 0xE2, 0x5F]};
@GUID(0x89F2A8BE, 0x95A9, 0x4530, [0x8B, 0x8F, 0x88, 0xE9, 0x71, 0xE3, 0xE2, 0x5F]);
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

const GUID IID_IInkDrawingAttributes = {0xBF519B75, 0x0A15, 0x4623, [0xAD, 0xC9, 0xC0, 0x0D, 0x43, 0x6A, 0x80, 0x92]};
@GUID(0xBF519B75, 0x0A15, 0x4623, [0xAD, 0xC9, 0xC0, 0x0D, 0x43, 0x6A, 0x80, 0x92]);
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

const GUID IID_IInkTransform = {0x615F1D43, 0x8703, 0x4565, [0x88, 0xE2, 0x82, 0x01, 0xD2, 0xEC, 0xD7, 0xB7]};
@GUID(0x615F1D43, 0x8703, 0x4565, [0x88, 0xE2, 0x82, 0x01, 0xD2, 0xEC, 0xD7, 0xB7]);
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

const GUID IID_IInkGesture = {0x3BDC0A97, 0x04E5, 0x4E26, [0xB8, 0x13, 0x18, 0xF0, 0x52, 0xD4, 0x1D, 0xEF]};
@GUID(0x3BDC0A97, 0x04E5, 0x4E26, [0xB8, 0x13, 0x18, 0xF0, 0x52, 0xD4, 0x1D, 0xEF]);
interface IInkGesture : IDispatch
{
    HRESULT get_Confidence(InkRecognitionConfidence* Confidence);
    HRESULT get_Id(InkApplicationGesture* Id);
    HRESULT GetHotPoint(int* X, int* Y);
}

const GUID IID_IInkCursor = {0xAD30C630, 0x40C5, 0x4350, [0x84, 0x05, 0x9C, 0x71, 0x01, 0x2F, 0xC5, 0x58]};
@GUID(0xAD30C630, 0x40C5, 0x4350, [0x84, 0x05, 0x9C, 0x71, 0x01, 0x2F, 0xC5, 0x58]);
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

const GUID IID_IInkCursors = {0xA248C1AC, 0xC698, 0x4E06, [0x9E, 0x5C, 0xD5, 0x7F, 0x77, 0xC7, 0xE6, 0x47]};
@GUID(0xA248C1AC, 0xC698, 0x4E06, [0x9E, 0x5C, 0xD5, 0x7F, 0x77, 0xC7, 0xE6, 0x47]);
interface IInkCursors : IDispatch
{
    HRESULT get_Count(int* Count);
    HRESULT get__NewEnum(IUnknown* _NewEnum);
    HRESULT Item(int Index, IInkCursor* Cursor);
}

const GUID IID_IInkCursorButton = {0x85EF9417, 0x1D59, 0x49B2, [0xA1, 0x3C, 0x70, 0x2C, 0x85, 0x43, 0x08, 0x94]};
@GUID(0x85EF9417, 0x1D59, 0x49B2, [0xA1, 0x3C, 0x70, 0x2C, 0x85, 0x43, 0x08, 0x94]);
interface IInkCursorButton : IDispatch
{
    HRESULT get_Name(BSTR* Name);
    HRESULT get_Id(BSTR* Id);
    HRESULT get_State(InkCursorButtonState* CurrentState);
}

const GUID IID_IInkCursorButtons = {0x3671CC40, 0xB624, 0x4671, [0x9F, 0xA0, 0xDB, 0x11, 0x9D, 0x95, 0x2D, 0x54]};
@GUID(0x3671CC40, 0xB624, 0x4671, [0x9F, 0xA0, 0xDB, 0x11, 0x9D, 0x95, 0x2D, 0x54]);
interface IInkCursorButtons : IDispatch
{
    HRESULT get_Count(int* Count);
    HRESULT get__NewEnum(IUnknown* _NewEnum);
    HRESULT Item(VARIANT Identifier, IInkCursorButton* Button);
}

const GUID IID_IInkTablet = {0x2DE25EAA, 0x6EF8, 0x42D5, [0xAE, 0xE9, 0x18, 0x5B, 0xC8, 0x1B, 0x91, 0x2D]};
@GUID(0x2DE25EAA, 0x6EF8, 0x42D5, [0xAE, 0xE9, 0x18, 0x5B, 0xC8, 0x1B, 0x91, 0x2D]);
interface IInkTablet : IDispatch
{
    HRESULT get_Name(BSTR* Name);
    HRESULT get_PlugAndPlayId(BSTR* Id);
    HRESULT get_MaximumInputRectangle(IInkRectangle* Rectangle);
    HRESULT get_HardwareCapabilities(TabletHardwareCapabilities* Capabilities);
    HRESULT IsPacketPropertySupported(BSTR packetPropertyName, short* Supported);
    HRESULT GetPropertyMetrics(BSTR propertyName, int* Minimum, int* Maximum, TabletPropertyMetricUnit* Units, float* Resolution);
}

const GUID IID_IInkTablet2 = {0x90C91AD2, 0xFA36, 0x49D6, [0x95, 0x16, 0xCE, 0x8D, 0x57, 0x0F, 0x6F, 0x85]};
@GUID(0x90C91AD2, 0xFA36, 0x49D6, [0x95, 0x16, 0xCE, 0x8D, 0x57, 0x0F, 0x6F, 0x85]);
interface IInkTablet2 : IDispatch
{
    HRESULT get_DeviceKind(TabletDeviceKind* Kind);
}

const GUID IID_IInkTablet3 = {0x7E313997, 0x1327, 0x41DD, [0x8C, 0xA9, 0x79, 0xF2, 0x4B, 0xE1, 0x72, 0x50]};
@GUID(0x7E313997, 0x1327, 0x41DD, [0x8C, 0xA9, 0x79, 0xF2, 0x4B, 0xE1, 0x72, 0x50]);
interface IInkTablet3 : IDispatch
{
    HRESULT get_IsMultiTouch(short* pIsMultiTouch);
    HRESULT get_MaximumCursors(uint* pMaximumCursors);
}

const GUID IID_IInkTablets = {0x112086D9, 0x7779, 0x4535, [0xA6, 0x99, 0x86, 0x2B, 0x43, 0xAC, 0x18, 0x63]};
@GUID(0x112086D9, 0x7779, 0x4535, [0xA6, 0x99, 0x86, 0x2B, 0x43, 0xAC, 0x18, 0x63]);
interface IInkTablets : IDispatch
{
    HRESULT get_Count(int* Count);
    HRESULT get__NewEnum(IUnknown* _NewEnum);
    HRESULT get_DefaultTablet(IInkTablet* DefaultTablet);
    HRESULT Item(int Index, IInkTablet* Tablet);
    HRESULT IsPacketPropertySupported(BSTR packetPropertyName, short* Supported);
}

const GUID IID_IInkStrokeDisp = {0x43242FEA, 0x91D1, 0x4A72, [0x96, 0x3E, 0xFB, 0xB9, 0x18, 0x29, 0xCF, 0xA2]};
@GUID(0x43242FEA, 0x91D1, 0x4A72, [0x96, 0x3E, 0xFB, 0xB9, 0x18, 0x29, 0xCF, 0xA2]);
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
    HRESULT GetPacketDescriptionPropertyMetrics(BSTR PropertyName, int* Minimum, int* Maximum, TabletPropertyMetricUnit* Units, float* Resolution);
    HRESULT GetPoints(int Index, int Count, VARIANT* Points);
    HRESULT SetPoints(VARIANT Points, int Index, int Count, int* NumberOfPointsSet);
    HRESULT GetPacketData(int Index, int Count, VARIANT* PacketData);
    HRESULT GetPacketValuesByProperty(BSTR PropertyName, int Index, int Count, VARIANT* PacketValues);
    HRESULT SetPacketValuesByProperty(BSTR bstrPropertyName, VARIANT PacketValues, int Index, int Count, int* NumberOfPacketsSet);
    HRESULT GetFlattenedBezierPoints(int FittingError, VARIANT* FlattenedBezierPoints);
    HRESULT Transform(IInkTransform Transform, short ApplyOnPenWidth);
    HRESULT ScaleToRectangle(IInkRectangle Rectangle);
    HRESULT Move(float HorizontalComponent, float VerticalComponent);
    HRESULT Rotate(float Degrees, float x, float y);
    HRESULT Shear(float HorizontalMultiplier, float VerticalMultiplier);
    HRESULT ScaleTransform(float HorizontalMultiplier, float VerticalMultiplier);
}

const GUID IID_IInkStrokes = {0xF1F4C9D8, 0x590A, 0x4963, [0xB3, 0xAE, 0x19, 0x35, 0x67, 0x1B, 0xB6, 0xF3]};
@GUID(0xF1F4C9D8, 0x590A, 0x4963, [0xB3, 0xAE, 0x19, 0x35, 0x67, 0x1B, 0xB6, 0xF3]);
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

const GUID IID_IInkCustomStrokes = {0x7E23A88F, 0xC30E, 0x420F, [0x9B, 0xDB, 0x28, 0x90, 0x25, 0x43, 0xF0, 0xC1]};
@GUID(0x7E23A88F, 0xC30E, 0x420F, [0x9B, 0xDB, 0x28, 0x90, 0x25, 0x43, 0xF0, 0xC1]);
interface IInkCustomStrokes : IDispatch
{
    HRESULT get_Count(int* Count);
    HRESULT get__NewEnum(IUnknown* _NewEnum);
    HRESULT Item(VARIANT Identifier, IInkStrokes* Strokes);
    HRESULT Add(BSTR Name, IInkStrokes Strokes);
    HRESULT Remove(VARIANT Identifier);
    HRESULT Clear();
}

const GUID IID__IInkStrokesEvents = {0xF33053EC, 0x5D25, 0x430A, [0x92, 0x8F, 0x76, 0xA6, 0x49, 0x1D, 0xDE, 0x15]};
@GUID(0xF33053EC, 0x5D25, 0x430A, [0x92, 0x8F, 0x76, 0xA6, 0x49, 0x1D, 0xDE, 0x15]);
interface _IInkStrokesEvents : IDispatch
{
}

const GUID IID_IInkDisp = {0x9D398FA0, 0xC4E2, 0x4FCD, [0x99, 0x73, 0x97, 0x5C, 0xAA, 0xF4, 0x7E, 0xA6]};
@GUID(0x9D398FA0, 0xC4E2, 0x4FCD, [0x99, 0x73, 0x97, 0x5C, 0xAA, 0xF4, 0x7E, 0xA6]);
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
    HRESULT Save(InkPersistenceFormat PersistenceFormat, InkPersistenceCompressionMode CompressionMode, VARIANT* Data);
    HRESULT Load(VARIANT Data);
    HRESULT CreateStroke(VARIANT PacketData, VARIANT PacketDescription, IInkStrokeDisp* Stroke);
    HRESULT ClipboardCopyWithRectangle(IInkRectangle Rectangle, InkClipboardFormats ClipboardFormats, InkClipboardModes ClipboardModes, IDataObject* DataObject);
    HRESULT ClipboardCopy(IInkStrokes strokes, InkClipboardFormats ClipboardFormats, InkClipboardModes ClipboardModes, IDataObject* DataObject);
    HRESULT CanPaste(IDataObject DataObject, short* CanPaste);
    HRESULT ClipboardPaste(int x, int y, IDataObject DataObject, IInkStrokes* Strokes);
}

const GUID IID__IInkEvents = {0x427B1865, 0xCA3F, 0x479A, [0x83, 0xA9, 0x0F, 0x42, 0x0F, 0x2A, 0x00, 0x73]};
@GUID(0x427B1865, 0xCA3F, 0x479A, [0x83, 0xA9, 0x0F, 0x42, 0x0F, 0x2A, 0x00, 0x73]);
interface _IInkEvents : IDispatch
{
}

const GUID IID_IInkRenderer = {0xE6257A9C, 0xB511, 0x4F4C, [0xA8, 0xB0, 0xA7, 0xDB, 0xC9, 0x50, 0x6B, 0x83]};
@GUID(0xE6257A9C, 0xB511, 0x4F4C, [0xA8, 0xB0, 0xA7, 0xDB, 0xC9, 0x50, 0x6B, 0x83]);
interface IInkRenderer : IDispatch
{
    HRESULT GetViewTransform(IInkTransform ViewTransform);
    HRESULT SetViewTransform(IInkTransform ViewTransform);
    HRESULT GetObjectTransform(IInkTransform ObjectTransform);
    HRESULT SetObjectTransform(IInkTransform ObjectTransform);
    HRESULT Draw(int hDC, IInkStrokes Strokes);
    HRESULT DrawStroke(int hDC, IInkStrokeDisp Stroke, IInkDrawingAttributes DrawingAttributes);
    HRESULT PixelToInkSpace(int hDC, int* x, int* y);
    HRESULT InkSpaceToPixel(int hdcDisplay, int* x, int* y);
    HRESULT PixelToInkSpaceFromPoints(int hDC, VARIANT* Points);
    HRESULT InkSpaceToPixelFromPoints(int hDC, VARIANT* Points);
    HRESULT Measure(IInkStrokes Strokes, IInkRectangle* Rectangle);
    HRESULT MeasureStroke(IInkStrokeDisp Stroke, IInkDrawingAttributes DrawingAttributes, IInkRectangle* Rectangle);
    HRESULT Move(float HorizontalComponent, float VerticalComponent);
    HRESULT Rotate(float Degrees, float x, float y);
    HRESULT ScaleTransform(float HorizontalMultiplier, float VerticalMultiplier, short ApplyOnPenWidth);
}

const GUID IID_IInkCollector = {0xF0F060B5, 0x8B1F, 0x4A7C, [0x89, 0xEC, 0x88, 0x06, 0x92, 0x58, 0x8A, 0x4F]};
@GUID(0xF0F060B5, 0x8B1F, 0x4A7C, [0x89, 0xEC, 0x88, 0x06, 0x92, 0x58, 0x8A, 0x4F]);
interface IInkCollector : IDispatch
{
    HRESULT get_hWnd(int* CurrentWindow);
    HRESULT put_hWnd(int NewWindow);
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

const GUID IID__IInkCollectorEvents = {0x11A583F2, 0x712D, 0x4FEA, [0xAB, 0xCF, 0xAB, 0x4A, 0xF3, 0x8E, 0xA0, 0x6B]};
@GUID(0x11A583F2, 0x712D, 0x4FEA, [0xAB, 0xCF, 0xAB, 0x4A, 0xF3, 0x8E, 0xA0, 0x6B]);
interface _IInkCollectorEvents : IDispatch
{
}

const GUID IID_IInkOverlay = {0xB82A463B, 0xC1C5, 0x45A3, [0x99, 0x7C, 0xDE, 0xAB, 0x56, 0x51, 0xB6, 0x7A]};
@GUID(0xB82A463B, 0xC1C5, 0x45A3, [0x99, 0x7C, 0xDE, 0xAB, 0x56, 0x51, 0xB6, 0x7A]);
interface IInkOverlay : IDispatch
{
    HRESULT get_hWnd(int* CurrentWindow);
    HRESULT put_hWnd(int NewWindow);
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

const GUID IID__IInkOverlayEvents = {0x31179B69, 0xE563, 0x489E, [0xB1, 0x6F, 0x71, 0x2F, 0x1E, 0x8A, 0x06, 0x51]};
@GUID(0x31179B69, 0xE563, 0x489E, [0xB1, 0x6F, 0x71, 0x2F, 0x1E, 0x8A, 0x06, 0x51]);
interface _IInkOverlayEvents : IDispatch
{
}

const GUID IID_IInkPicture = {0xE85662E0, 0x379A, 0x40D7, [0x9B, 0x5C, 0x75, 0x7D, 0x23, 0x3F, 0x99, 0x23]};
@GUID(0xE85662E0, 0x379A, 0x40D7, [0x9B, 0x5C, 0x75, 0x7D, 0x23, 0x3F, 0x99, 0x23]);
interface IInkPicture : IDispatch
{
    HRESULT get_hWnd(int* CurrentWindow);
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

const GUID IID__IInkPictureEvents = {0x60FF4FEE, 0x22FF, 0x4484, [0xAC, 0xC1, 0xD3, 0x08, 0xD9, 0xCD, 0x7E, 0xA3]};
@GUID(0x60FF4FEE, 0x22FF, 0x4484, [0xAC, 0xC1, 0xD3, 0x08, 0xD9, 0xCD, 0x7E, 0xA3]);
interface _IInkPictureEvents : IDispatch
{
}

const GUID IID_IInkRecognizer = {0x782BF7CF, 0x034B, 0x4396, [0x8A, 0x32, 0x3A, 0x18, 0x33, 0xCF, 0x6B, 0x56]};
@GUID(0x782BF7CF, 0x034B, 0x4396, [0x8A, 0x32, 0x3A, 0x18, 0x33, 0xCF, 0x6B, 0x56]);
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

const GUID IID_IInkRecognizer2 = {0x6110118A, 0x3A75, 0x4AD6, [0xB2, 0xAA, 0x04, 0xB2, 0xB7, 0x2B, 0xBE, 0x65]};
@GUID(0x6110118A, 0x3A75, 0x4AD6, [0xB2, 0xAA, 0x04, 0xB2, 0xB7, 0x2B, 0xBE, 0x65]);
interface IInkRecognizer2 : IDispatch
{
    HRESULT get_Id(BSTR* pbstrId);
    HRESULT get_UnicodeRanges(VARIANT* UnicodeRanges);
}

const GUID IID_IInkRecognizers = {0x9CCC4F12, 0xB0B7, 0x4A8B, [0xBF, 0x58, 0x4A, 0xEC, 0xA4, 0xE8, 0xCE, 0xFD]};
@GUID(0x9CCC4F12, 0xB0B7, 0x4A8B, [0xBF, 0x58, 0x4A, 0xEC, 0xA4, 0xE8, 0xCE, 0xFD]);
interface IInkRecognizers : IDispatch
{
    HRESULT get_Count(int* Count);
    HRESULT get__NewEnum(IUnknown* _NewEnum);
    HRESULT GetDefaultRecognizer(int lcid, IInkRecognizer* DefaultRecognizer);
    HRESULT Item(int Index, IInkRecognizer* InkRecognizer);
}

const GUID IID__IInkRecognitionEvents = {0x17BCE92F, 0x2E21, 0x47FD, [0x9D, 0x33, 0x3C, 0x6A, 0xFB, 0xFD, 0x8C, 0x59]};
@GUID(0x17BCE92F, 0x2E21, 0x47FD, [0x9D, 0x33, 0x3C, 0x6A, 0xFB, 0xFD, 0x8C, 0x59]);
interface _IInkRecognitionEvents : IDispatch
{
}

const GUID IID_IInkRecognizerContext = {0xC68F52F9, 0x32A3, 0x4625, [0x90, 0x6C, 0x44, 0xFC, 0x23, 0xB4, 0x09, 0x58]};
@GUID(0xC68F52F9, 0x32A3, 0x4625, [0x90, 0x6C, 0x44, 0xFC, 0x23, 0xB4, 0x09, 0x58]);
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

const GUID IID_IInkRecognizerContext2 = {0xD6F0E32F, 0x73D8, 0x408E, [0x8E, 0x9F, 0x5F, 0xEA, 0x59, 0x2C, 0x36, 0x3F]};
@GUID(0xD6F0E32F, 0x73D8, 0x408E, [0x8E, 0x9F, 0x5F, 0xEA, 0x59, 0x2C, 0x36, 0x3F]);
interface IInkRecognizerContext2 : IDispatch
{
    HRESULT get_EnabledUnicodeRanges(VARIANT* UnicodeRanges);
    HRESULT put_EnabledUnicodeRanges(VARIANT UnicodeRanges);
}

const GUID IID_IInkRecognitionResult = {0x3BC129A8, 0x86CD, 0x45AD, [0xBD, 0xE8, 0xE0, 0xD3, 0x2D, 0x61, 0xC1, 0x6D]};
@GUID(0x3BC129A8, 0x86CD, 0x45AD, [0xBD, 0xE8, 0xE0, 0xD3, 0x2D, 0x61, 0xC1, 0x6D]);
interface IInkRecognitionResult : IDispatch
{
    HRESULT get_TopString(BSTR* TopString);
    HRESULT get_TopAlternate(IInkRecognitionAlternate* TopAlternate);
    HRESULT get_TopConfidence(InkRecognitionConfidence* TopConfidence);
    HRESULT get_Strokes(IInkStrokes* Strokes);
    HRESULT AlternatesFromSelection(int selectionStart, int selectionLength, int maximumAlternates, IInkRecognitionAlternates* AlternatesFromSelection);
    HRESULT ModifyTopAlternate(IInkRecognitionAlternate Alternate);
    HRESULT SetResultOnStrokes();
}

const GUID IID_IInkRecognitionAlternate = {0xB7E660AD, 0x77E4, 0x429B, [0xAD, 0xDA, 0x87, 0x37, 0x80, 0xD1, 0xFC, 0x4A]};
@GUID(0xB7E660AD, 0x77E4, 0x429B, [0xAD, 0xDA, 0x87, 0x37, 0x80, 0xD1, 0xFC, 0x4A]);
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
    HRESULT GetStrokesFromTextRange(int* selectionStart, int* selectionLength, IInkStrokes* GetStrokesFromTextRange);
    HRESULT GetTextRangeFromStrokes(IInkStrokes Strokes, int* selectionStart, int* selectionLength);
    HRESULT AlternatesWithConstantPropertyValues(BSTR PropertyType, IInkRecognitionAlternates* AlternatesWithConstantPropertyValues);
    HRESULT GetPropertyValue(BSTR PropertyType, VARIANT* PropertyValue);
}

const GUID IID_IInkRecognitionAlternates = {0x286A167F, 0x9F19, 0x4C61, [0x9D, 0x53, 0x4F, 0x07, 0xBE, 0x62, 0x2B, 0x84]};
@GUID(0x286A167F, 0x9F19, 0x4C61, [0x9D, 0x53, 0x4F, 0x07, 0xBE, 0x62, 0x2B, 0x84]);
interface IInkRecognitionAlternates : IDispatch
{
    HRESULT get_Count(int* Count);
    HRESULT get__NewEnum(IUnknown* _NewEnum);
    HRESULT get_Strokes(IInkStrokes* Strokes);
    HRESULT Item(int Index, IInkRecognitionAlternate* InkRecoAlternate);
}

const GUID IID_IInkRecognizerGuide = {0xD934BE07, 0x7B84, 0x4208, [0x91, 0x36, 0x83, 0xC2, 0x09, 0x94, 0xE9, 0x05]};
@GUID(0xD934BE07, 0x7B84, 0x4208, [0x91, 0x36, 0x83, 0xC2, 0x09, 0x94, 0xE9, 0x05]);
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

const GUID IID_IInkWordList = {0x76BA3491, 0xCB2F, 0x406B, [0x99, 0x61, 0x0E, 0x0C, 0x4C, 0xDA, 0xAE, 0xF2]};
@GUID(0x76BA3491, 0xCB2F, 0x406B, [0x99, 0x61, 0x0E, 0x0C, 0x4C, 0xDA, 0xAE, 0xF2]);
interface IInkWordList : IDispatch
{
    HRESULT AddWord(BSTR NewWord);
    HRESULT RemoveWord(BSTR RemoveWord);
    HRESULT Merge(IInkWordList MergeWordList);
}

const GUID IID_IInkWordList2 = {0x14542586, 0x11BF, 0x4F5F, [0xB6, 0xE7, 0x49, 0xD0, 0x74, 0x4A, 0xAB, 0x6E]};
@GUID(0x14542586, 0x11BF, 0x4F5F, [0xB6, 0xE7, 0x49, 0xD0, 0x74, 0x4A, 0xAB, 0x6E]);
interface IInkWordList2 : IDispatch
{
    HRESULT AddWords(BSTR NewWords);
}

const GUID IID_IInk = {0x03F8E511, 0x43A1, 0x11D3, [0x8B, 0xB6, 0x00, 0x80, 0xC7, 0xD6, 0xBA, 0xD5]};
@GUID(0x03F8E511, 0x43A1, 0x11D3, [0x8B, 0xB6, 0x00, 0x80, 0xC7, 0xD6, 0xBA, 0xD5]);
interface IInk : IDispatch
{
}

const GUID IID_IInkLineInfo = {0x9C1C5AD6, 0xF22F, 0x4DE4, [0xB4, 0x53, 0xA2, 0xCC, 0x48, 0x2E, 0x7C, 0x33]};
@GUID(0x9C1C5AD6, 0xF22F, 0x4DE4, [0xB4, 0x53, 0xA2, 0xCC, 0x48, 0x2E, 0x7C, 0x33]);
interface IInkLineInfo : IUnknown
{
    HRESULT SetFormat(INKMETRIC* pim);
    HRESULT GetFormat(INKMETRIC* pim);
    HRESULT GetInkExtent(INKMETRIC* pim, uint* pnWidth);
    HRESULT GetCandidate(uint nCandidateNum, const(wchar)* pwcRecogWord, uint* pcwcRecogWord, uint dwFlags);
    HRESULT SetCandidate(uint nCandidateNum, const(wchar)* strRecogWord);
    HRESULT Recognize();
}

const GUID IID_ISketchInk = {0xB4563688, 0x98EB, 0x4646, [0xB2, 0x79, 0x44, 0xDA, 0x14, 0xD4, 0x57, 0x48]};
@GUID(0xB4563688, 0x98EB, 0x4646, [0xB2, 0x79, 0x44, 0xDA, 0x14, 0xD4, 0x57, 0x48]);
interface ISketchInk : IDispatch
{
}

const GUID CLSID_InkDivider = {0x8854F6A0, 0x4683, 0x4AE7, [0x91, 0x91, 0x75, 0x2F, 0xE6, 0x46, 0x12, 0xC3]};
@GUID(0x8854F6A0, 0x4683, 0x4AE7, [0x91, 0x91, 0x75, 0x2F, 0xE6, 0x46, 0x12, 0xC3]);
struct InkDivider;

enum InkDivisionType
{
    IDT_Segment = 0,
    IDT_Line = 1,
    IDT_Paragraph = 2,
    IDT_Drawing = 3,
}

enum DISPID_InkDivider
{
    DISPID_IInkDivider_Strokes = 1,
    DISPID_IInkDivider_RecognizerContext = 2,
    DISPID_IInkDivider_LineHeight = 3,
    DISPID_IInkDivider_Divide = 4,
}

enum DISPID_InkDivisionResult
{
    DISPID_IInkDivisionResult_Strokes = 1,
    DISPID_IInkDivisionResult_ResultByType = 2,
}

enum DISPID_InkDivisionUnit
{
    DISPID_IInkDivisionUnit_Strokes = 1,
    DISPID_IInkDivisionUnit_DivisionType = 2,
    DISPID_IInkDivisionUnit_RecognizedString = 3,
    DISPID_IInkDivisionUnit_RotationTransform = 4,
}

enum DISPID_InkDivisionUnits
{
    DISPID_IInkDivisionUnits_NewEnum = -4,
    DISPID_IInkDivisionUnits_Item = 0,
    DISPID_IInkDivisionUnits_Count = 1,
}

const GUID IID_IInkDivider = {0x5DE00405, 0xF9A4, 0x4651, [0xB0, 0xC5, 0xC3, 0x17, 0xDE, 0xFD, 0x58, 0xB9]};
@GUID(0x5DE00405, 0xF9A4, 0x4651, [0xB0, 0xC5, 0xC3, 0x17, 0xDE, 0xFD, 0x58, 0xB9]);
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

const GUID IID_IInkDivisionResult = {0x2DBEC0A7, 0x74C7, 0x4B38, [0x81, 0xEB, 0xAA, 0x8E, 0xF0, 0xC2, 0x49, 0x00]};
@GUID(0x2DBEC0A7, 0x74C7, 0x4B38, [0x81, 0xEB, 0xAA, 0x8E, 0xF0, 0xC2, 0x49, 0x00]);
interface IInkDivisionResult : IDispatch
{
    HRESULT get_Strokes(IInkStrokes* Strokes);
    HRESULT ResultByType(InkDivisionType divisionType, IInkDivisionUnits* InkDivisionUnits);
}

const GUID IID_IInkDivisionUnit = {0x85AEE342, 0x48B0, 0x4244, [0x9D, 0xD5, 0x1E, 0xD4, 0x35, 0x41, 0x0F, 0xAB]};
@GUID(0x85AEE342, 0x48B0, 0x4244, [0x9D, 0xD5, 0x1E, 0xD4, 0x35, 0x41, 0x0F, 0xAB]);
interface IInkDivisionUnit : IDispatch
{
    HRESULT get_Strokes(IInkStrokes* Strokes);
    HRESULT get_DivisionType(InkDivisionType* divisionType);
    HRESULT get_RecognizedString(BSTR* RecoString);
    HRESULT get_RotationTransform(IInkTransform* RotationTransform);
}

const GUID IID_IInkDivisionUnits = {0x1BB5DDC2, 0x31CC, 0x4135, [0xAB, 0x82, 0x2C, 0x66, 0xC9, 0xF0, 0x0C, 0x41]};
@GUID(0x1BB5DDC2, 0x31CC, 0x4135, [0xAB, 0x82, 0x2C, 0x66, 0xC9, 0xF0, 0x0C, 0x41]);
interface IInkDivisionUnits : IDispatch
{
    HRESULT get_Count(int* Count);
    HRESULT get__NewEnum(IUnknown* _NewEnum);
    HRESULT Item(int Index, IInkDivisionUnit* InkDivisionUnit);
}

const GUID CLSID_HandwrittenTextInsertion = {0x9F074EE2, 0xE6E9, 0x4D8A, [0xA0, 0x47, 0xEB, 0x5B, 0x5C, 0x3C, 0x55, 0xDA]};
@GUID(0x9F074EE2, 0xE6E9, 0x4D8A, [0xA0, 0x47, 0xEB, 0x5B, 0x5C, 0x3C, 0x55, 0xDA]);
struct HandwrittenTextInsertion;

const GUID CLSID_PenInputPanel = {0xF744E496, 0x1B5A, 0x489E, [0x81, 0xDC, 0xFB, 0xD7, 0xAC, 0x62, 0x98, 0xA8]};
@GUID(0xF744E496, 0x1B5A, 0x489E, [0x81, 0xDC, 0xFB, 0xD7, 0xAC, 0x62, 0x98, 0xA8]);
struct PenInputPanel;

const GUID CLSID_TextInputPanel = {0xF9B189D7, 0x228B, 0x4F2B, [0x86, 0x50, 0xB9, 0x7F, 0x59, 0xE0, 0x2C, 0x8C]};
@GUID(0xF9B189D7, 0x228B, 0x4F2B, [0x86, 0x50, 0xB9, 0x7F, 0x59, 0xE0, 0x2C, 0x8C]);
struct TextInputPanel;

const GUID CLSID_PenInputPanel_Internal = {0x802B1FB9, 0x056B, 0x4720, [0xB0, 0xCC, 0x80, 0xD2, 0x3B, 0x71, 0x17, 0x1E]};
@GUID(0x802B1FB9, 0x056B, 0x4720, [0xB0, 0xCC, 0x80, 0xD2, 0x3B, 0x71, 0x17, 0x1E]);
struct PenInputPanel_Internal;

enum DISPID_PenInputPanel
{
    DISPID_PIPAttachedEditWindow = 0,
    DISPID_PIPFactoid = 1,
    DISPID_PIPCurrentPanel = 2,
    DISPID_PIPDefaultPanel = 3,
    DISPID_PIPVisible = 4,
    DISPID_PIPTop = 5,
    DISPID_PIPLeft = 6,
    DISPID_PIPWidth = 7,
    DISPID_PIPHeight = 8,
    DISPID_PIPMoveTo = 9,
    DISPID_PIPCommitPendingInput = 10,
    DISPID_PIPRefresh = 11,
    DISPID_PIPBusy = 12,
    DISPID_PIPVerticalOffset = 13,
    DISPID_PIPHorizontalOffset = 14,
    DISPID_PIPEnableTsf = 15,
    DISPID_PIPAutoShow = 16,
}

enum DISPID_PenInputPanelEvents
{
    DISPID_PIPEVisibleChanged = 0,
    DISPID_PIPEPanelChanged = 1,
    DISPID_PIPEInputFailed = 2,
    DISPID_PIPEPanelMoving = 3,
}

enum VisualState
{
    InPlace = 0,
    Floating = 1,
    DockedTop = 2,
    DockedBottom = 3,
    Closed = 4,
}

enum InteractionMode
{
    InteractionMode_InPlace = 0,
    InteractionMode_Floating = 1,
    InteractionMode_DockedTop = 2,
    InteractionMode_DockedBottom = 3,
}

enum InPlaceState
{
    InPlaceState_Auto = 0,
    InPlaceState_HoverTarget = 1,
    InPlaceState_Expanded = 2,
}

enum PanelInputArea
{
    PanelInputArea_Auto = 0,
    PanelInputArea_Keyboard = 1,
    PanelInputArea_WritingPad = 2,
    PanelInputArea_CharacterPad = 3,
}

enum CorrectionMode
{
    CorrectionMode_NotVisible = 0,
    CorrectionMode_PreInsertion = 1,
    CorrectionMode_PostInsertionCollapsed = 2,
    CorrectionMode_PostInsertionExpanded = 3,
}

enum CorrectionPosition
{
    CorrectionPosition_Auto = 0,
    CorrectionPosition_Bottom = 1,
    CorrectionPosition_Top = 2,
}

enum InPlaceDirection
{
    InPlaceDirection_Auto = 0,
    InPlaceDirection_Bottom = 1,
    InPlaceDirection_Top = 2,
}

enum EventMask
{
    EventMask_InPlaceStateChanging = 1,
    EventMask_InPlaceStateChanged = 2,
    EventMask_InPlaceSizeChanging = 4,
    EventMask_InPlaceSizeChanged = 8,
    EventMask_InputAreaChanging = 16,
    EventMask_InputAreaChanged = 32,
    EventMask_CorrectionModeChanging = 64,
    EventMask_CorrectionModeChanged = 128,
    EventMask_InPlaceVisibilityChanging = 256,
    EventMask_InPlaceVisibilityChanged = 512,
    EventMask_TextInserting = 1024,
    EventMask_TextInserted = 2048,
    EventMask_All = 4095,
}

enum PanelType
{
    PT_Default = 0,
    PT_Inactive = 1,
    PT_Handwriting = 2,
    PT_Keyboard = 3,
}

const GUID IID_IPenInputPanel = {0xFA7A4083, 0x5747, 0x4040, [0xA1, 0x82, 0x0B, 0x0E, 0x9F, 0xD4, 0xFA, 0xC7]};
@GUID(0xFA7A4083, 0x5747, 0x4040, [0xA1, 0x82, 0x0B, 0x0E, 0x9F, 0xD4, 0xFA, 0xC7]);
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

const GUID IID__IPenInputPanelEvents = {0xB7E489DA, 0x3719, 0x439F, [0x84, 0x8F, 0xE7, 0xAC, 0xBD, 0x82, 0x0F, 0x17]};
@GUID(0xB7E489DA, 0x3719, 0x439F, [0x84, 0x8F, 0xE7, 0xAC, 0xBD, 0x82, 0x0F, 0x17]);
interface _IPenInputPanelEvents : IDispatch
{
}

const GUID IID_IHandwrittenTextInsertion = {0x56FDEA97, 0xECD6, 0x43E7, [0xAA, 0x3A, 0x81, 0x6B, 0xE7, 0x78, 0x58, 0x60]};
@GUID(0x56FDEA97, 0xECD6, 0x43E7, [0xAA, 0x3A, 0x81, 0x6B, 0xE7, 0x78, 0x58, 0x60]);
interface IHandwrittenTextInsertion : IUnknown
{
    HRESULT InsertRecognitionResultsArray(SAFEARRAY* psaAlternates, uint locale, BOOL fAlternateContainsAutoSpacingInformation);
    HRESULT InsertInkRecognitionResult(IInkRecognitionResult pIInkRecoResult, uint locale, BOOL fAlternateContainsAutoSpacingInformation);
}

const GUID IID_ITextInputPanelEventSink = {0x27560408, 0x8E64, 0x4FE1, [0x80, 0x4E, 0x42, 0x12, 0x01, 0x58, 0x4B, 0x31]};
@GUID(0x27560408, 0x8E64, 0x4FE1, [0x80, 0x4E, 0x42, 0x12, 0x01, 0x58, 0x4B, 0x31]);
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

const GUID IID_ITextInputPanel = {0x6B6A65A5, 0x6AF3, 0x46C2, [0xB6, 0xEA, 0x56, 0xCD, 0x1F, 0x80, 0xDF, 0x71]};
@GUID(0x6B6A65A5, 0x6AF3, 0x46C2, [0xB6, 0xEA, 0x56, 0xCD, 0x1F, 0x80, 0xDF, 0x71]);
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

const GUID IID_IInputPanelWindowHandle = {0x4AF81847, 0xFDC4, 0x4FC3, [0xAD, 0x0B, 0x42, 0x24, 0x79, 0xC1, 0xB9, 0x35]};
@GUID(0x4AF81847, 0xFDC4, 0x4FC3, [0xAD, 0x0B, 0x42, 0x24, 0x79, 0xC1, 0xB9, 0x35]);
interface IInputPanelWindowHandle : IUnknown
{
    HRESULT get_AttachedEditWindow32(int* AttachedEditWindow);
    HRESULT put_AttachedEditWindow32(int AttachedEditWindow);
    HRESULT get_AttachedEditWindow64(long* AttachedEditWindow);
    HRESULT put_AttachedEditWindow64(long AttachedEditWindow);
}

const GUID IID_ITextInputPanelRunInfo = {0x9F424568, 0x1920, 0x48CC, [0x98, 0x11, 0xA9, 0x93, 0xCB, 0xF5, 0xAD, 0xBA]};
@GUID(0x9F424568, 0x1920, 0x48CC, [0x98, 0x11, 0xA9, 0x93, 0xCB, 0xF5, 0xAD, 0xBA]);
interface ITextInputPanelRunInfo : IUnknown
{
    HRESULT IsTipRunning(int* pfRunning);
}

enum FLICKDIRECTION
{
    FLICKDIRECTION_MIN = 0,
    FLICKDIRECTION_RIGHT = 0,
    FLICKDIRECTION_UPRIGHT = 1,
    FLICKDIRECTION_UP = 2,
    FLICKDIRECTION_UPLEFT = 3,
    FLICKDIRECTION_LEFT = 4,
    FLICKDIRECTION_DOWNLEFT = 5,
    FLICKDIRECTION_DOWN = 6,
    FLICKDIRECTION_DOWNRIGHT = 7,
    FLICKDIRECTION_INVALID = 8,
}

enum FLICKMODE
{
    FLICKMODE_MIN = 0,
    FLICKMODE_OFF = 0,
    FLICKMODE_ON = 1,
    FLICKMODE_LEARNING = 2,
    FLICKMODE_MAX = 2,
    FLICKMODE_DEFAULT = 1,
}

enum FLICKACTION_COMMANDCODE
{
    FLICKACTION_COMMANDCODE_NULL = 0,
    FLICKACTION_COMMANDCODE_SCROLL = 1,
    FLICKACTION_COMMANDCODE_APPCOMMAND = 2,
    FLICKACTION_COMMANDCODE_CUSTOMKEY = 3,
    FLICKACTION_COMMANDCODE_KEYMODIFIER = 4,
}

struct FLICK_POINT
{
    int _bitfield;
}

struct FLICK_DATA
{
    int _bitfield;
}

enum SCROLLDIRECTION
{
    SCROLLDIRECTION_UP = 0,
    SCROLLDIRECTION_DOWN = 1,
}

enum KEYMODIFIER
{
    KEYMODIFIER_CONTROL = 1,
    KEYMODIFIER_MENU = 2,
    KEYMODIFIER_SHIFT = 4,
    KEYMODIFIER_WIN = 8,
    KEYMODIFIER_ALTGR = 16,
    KEYMODIFIER_EXT = 32,
}

const GUID CLSID_InkEdit = {0xE5CA59F5, 0x57C4, 0x4DD8, [0x9B, 0xD6, 0x1D, 0xEE, 0xED, 0xD2, 0x7A, 0xF4]};
@GUID(0xE5CA59F5, 0x57C4, 0x4DD8, [0x9B, 0xD6, 0x1D, 0xEE, 0xED, 0xD2, 0x7A, 0xF4]);
struct InkEdit;

struct IEC_STROKEINFO
{
    NMHDR nmhdr;
    IInkCursor Cursor;
    IInkStrokeDisp Stroke;
}

struct IEC_GESTUREINFO
{
    NMHDR nmhdr;
    IInkCursor Cursor;
    IInkStrokes Strokes;
    VARIANT Gestures;
}

struct IEC_RECOGNITIONRESULTINFO
{
    NMHDR nmhdr;
    IInkRecognitionResult RecognitionResult;
}

enum MouseButton
{
    NO_BUTTON = 0,
    LEFT_BUTTON = 1,
    RIGHT_BUTTON = 2,
    MIDDLE_BUTTON = 4,
}

enum SelAlignmentConstants
{
    rtfLeft = 0,
    rtfRight = 1,
    rtfCenter = 2,
}

enum DISPID_InkEdit
{
    DISPID_Text = 0,
    DISPID_TextRTF = 1,
    DISPID_Hwnd = 2,
    DISPID_DisableNoScroll = 3,
    DISPID_Locked = 4,
    DISPID_Enabled = 5,
    DISPID_MaxLength = 6,
    DISPID_MultiLine = 7,
    DISPID_ScrollBars = 8,
    DISPID_RTSelStart = 9,
    DISPID_RTSelLength = 10,
    DISPID_RTSelText = 11,
    DISPID_SelAlignment = 12,
    DISPID_SelBold = 13,
    DISPID_SelCharOffset = 14,
    DISPID_SelColor = 15,
    DISPID_SelFontName = 16,
    DISPID_SelFontSize = 17,
    DISPID_SelItalic = 18,
    DISPID_SelRTF = 19,
    DISPID_SelUnderline = 20,
    DISPID_DragIcon = 21,
    DISPID_Status = 22,
    DISPID_UseMouseForInput = 23,
    DISPID_InkMode = 24,
    DISPID_InkInsertMode = 25,
    DISPID_RecoTimeout = 26,
    DISPID_DrawAttr = 27,
    DISPID_Recognizer = 28,
    DISPID_Factoid = 29,
    DISPID_SelInk = 30,
    DISPID_SelInksDisplayMode = 31,
    DISPID_Recognize = 32,
    DISPID_GetGestStatus = 33,
    DISPID_SetGestStatus = 34,
    DISPID_Refresh = 35,
}

enum DISPID_InkEditEvents
{
    DISPID_IeeChange = 1,
    DISPID_IeeSelChange = 2,
    DISPID_IeeKeyDown = 3,
    DISPID_IeeKeyUp = 4,
    DISPID_IeeMouseUp = 5,
    DISPID_IeeMouseDown = 6,
    DISPID_IeeKeyPress = 7,
    DISPID_IeeDblClick = 8,
    DISPID_IeeClick = 9,
    DISPID_IeeMouseMove = 10,
    DISPID_IeeCursorDown = 21,
    DISPID_IeeStroke = 22,
    DISPID_IeeGesture = 23,
    DISPID_IeeRecognitionResult = 24,
}

enum InkMode
{
    IEM_Disabled = 0,
    IEM_Ink = 1,
    IEM_InkAndGesture = 2,
}

enum InkInsertMode
{
    IEM_InsertText = 0,
    IEM_InsertInk = 1,
}

enum InkEditStatus
{
    IES_Idle = 0,
    IES_Collecting = 1,
    IES_Recognizing = 2,
}

enum InkDisplayMode
{
    IDM_Ink = 0,
    IDM_Text = 1,
}

enum AppearanceConstants
{
    rtfFlat = 0,
    rtfThreeD = 1,
}

enum BorderStyleConstants
{
    rtfNoBorder = 0,
    rtfFixedSingle = 1,
}

enum ScrollBarsConstants
{
    rtfNone = 0,
    rtfHorizontal = 1,
    rtfVertical = 2,
    rtfBoth = 3,
}

const GUID IID_IInkEdit = {0xF2127A19, 0xFBFB, 0x4AED, [0x84, 0x64, 0x3F, 0x36, 0xD7, 0x8C, 0xFE, 0xFB]};
@GUID(0xF2127A19, 0xFBFB, 0x4AED, [0x84, 0x64, 0x3F, 0x36, 0xD7, 0x8C, 0xFE, 0xFB]);
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

const GUID IID__IInkEditEvents = {0xE3B0B797, 0xA72E, 0x46DB, [0xA0, 0xD7, 0x6C, 0x9E, 0xBA, 0x8E, 0x9B, 0xBC]};
@GUID(0xE3B0B797, 0xA72E, 0x46DB, [0xA0, 0xD7, 0x6C, 0x9E, 0xBA, 0x8E, 0x9B, 0xBC]);
interface _IInkEditEvents : IDispatch
{
}

const GUID CLSID_MathInputControl = {0xC561816C, 0x14D8, 0x4090, [0x83, 0x0C, 0x98, 0xD9, 0x94, 0xB2, 0x1C, 0x7B]};
@GUID(0xC561816C, 0x14D8, 0x4090, [0x83, 0x0C, 0x98, 0xD9, 0x94, 0xB2, 0x1C, 0x7B]);
struct MathInputControl;

enum MICUIELEMENT
{
    MICUIELEMENT_BUTTON_WRITE = 1,
    MICUIELEMENT_BUTTON_ERASE = 2,
    MICUIELEMENT_BUTTON_CORRECT = 4,
    MICUIELEMENT_BUTTON_CLEAR = 8,
    MICUIELEMENT_BUTTON_UNDO = 16,
    MICUIELEMENT_BUTTON_REDO = 32,
    MICUIELEMENT_BUTTON_INSERT = 64,
    MICUIELEMENT_BUTTON_CANCEL = 128,
    MICUIELEMENT_INKPANEL_BACKGROUND = 256,
    MICUIELEMENT_RESULTPANEL_BACKGROUND = 512,
}

enum MICUIELEMENTSTATE
{
    MICUIELEMENTSTATE_NORMAL = 1,
    MICUIELEMENTSTATE_HOT = 2,
    MICUIELEMENTSTATE_PRESSED = 3,
    MICUIELEMENTSTATE_DISABLED = 4,
}

enum DISPID_MathInputControlEvents
{
    DISPID_MICInsert = 0,
    DISPID_MICClose = 1,
    DISPID_MICPaint = 2,
    DISPID_MICClear = 3,
}

const GUID IID_IMathInputControl = {0xEBA615AA, 0xFAC6, 0x4738, [0xBA, 0x5F, 0xFF, 0x09, 0xE9, 0xFE, 0x47, 0x3E]};
@GUID(0xEBA615AA, 0xFAC6, 0x4738, [0xBA, 0x5F, 0xFF, 0x09, 0xE9, 0xFE, 0x47, 0x3E]);
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
    HRESULT SetOwnerWindow(int OwnerWindow);
    HRESULT EnableExtendedButtons(short Extended);
    HRESULT GetPreviewHeight(int* Height);
    HRESULT SetPreviewHeight(int Height);
    HRESULT EnableAutoGrow(short AutoGrow);
    HRESULT AddFunctionName(BSTR FunctionName);
    HRESULT RemoveFunctionName(BSTR FunctionName);
    HRESULT GetHoverIcon(IPictureDisp* HoverImage);
}

const GUID IID__IMathInputControlEvents = {0x683336B5, 0xA47D, 0x4358, [0x96, 0xF9, 0x87, 0x5A, 0x47, 0x2A, 0xE7, 0x0A]};
@GUID(0x683336B5, 0xA47D, 0x4358, [0x96, 0xF9, 0x87, 0x5A, 0x47, 0x2A, 0xE7, 0x0A]);
interface _IMathInputControlEvents : IDispatch
{
}

const GUID CLSID_RealTimeStylus = {0xE26B366D, 0xF998, 0x43CE, [0x83, 0x6F, 0xCB, 0x6D, 0x90, 0x44, 0x32, 0xB0]};
@GUID(0xE26B366D, 0xF998, 0x43CE, [0x83, 0x6F, 0xCB, 0x6D, 0x90, 0x44, 0x32, 0xB0]);
struct RealTimeStylus;

const GUID CLSID_DynamicRenderer = {0xECD32AEA, 0x746F, 0x4DCB, [0xBF, 0x68, 0x08, 0x27, 0x57, 0xFA, 0xFF, 0x18]};
@GUID(0xECD32AEA, 0x746F, 0x4DCB, [0xBF, 0x68, 0x08, 0x27, 0x57, 0xFA, 0xFF, 0x18]);
struct DynamicRenderer;

const GUID CLSID_GestureRecognizer = {0xEA30C654, 0xC62C, 0x441F, [0xAC, 0x00, 0x95, 0xF9, 0xA1, 0x96, 0x78, 0x2C]};
@GUID(0xEA30C654, 0xC62C, 0x441F, [0xAC, 0x00, 0x95, 0xF9, 0xA1, 0x96, 0x78, 0x2C]);
struct GestureRecognizer;

const GUID CLSID_StrokeBuilder = {0xE810CEE7, 0x6E51, 0x4CB0, [0xAA, 0x3A, 0x0B, 0x98, 0x5B, 0x70, 0xDA, 0xF7]};
@GUID(0xE810CEE7, 0x6E51, 0x4CB0, [0xAA, 0x3A, 0x0B, 0x98, 0x5B, 0x70, 0xDA, 0xF7]);
struct StrokeBuilder;

enum RealTimeStylusDataInterest
{
    RTSDI_AllData = -1,
    RTSDI_None = 0,
    RTSDI_Error = 1,
    RTSDI_RealTimeStylusEnabled = 2,
    RTSDI_RealTimeStylusDisabled = 4,
    RTSDI_StylusNew = 8,
    RTSDI_StylusInRange = 16,
    RTSDI_InAirPackets = 32,
    RTSDI_StylusOutOfRange = 64,
    RTSDI_StylusDown = 128,
    RTSDI_Packets = 256,
    RTSDI_StylusUp = 512,
    RTSDI_StylusButtonUp = 1024,
    RTSDI_StylusButtonDown = 2048,
    RTSDI_SystemEvents = 4096,
    RTSDI_TabletAdded = 8192,
    RTSDI_TabletRemoved = 16384,
    RTSDI_CustomStylusDataAdded = 32768,
    RTSDI_UpdateMapping = 65536,
    RTSDI_DefaultEvents = 37766,
}

struct StylusInfo
{
    uint tcid;
    uint cid;
    BOOL bIsInvertedCursor;
}

enum StylusQueue
{
    SyncStylusQueue = 1,
    AsyncStylusQueueImmediate = 2,
    AsyncStylusQueue = 3,
}

enum RealTimeStylusLockType
{
    RTSLT_ObjLock = 1,
    RTSLT_SyncEventLock = 2,
    RTSLT_AsyncEventLock = 4,
    RTSLT_ExcludeCallback = 8,
    RTSLT_SyncObjLock = 11,
    RTSLT_AsyncObjLock = 13,
}

struct GESTURE_DATA
{
    int gestureId;
    int recoConfidence;
    int strokeCount;
}

struct DYNAMIC_RENDERER_CACHED_DATA
{
    int strokeId;
    IDynamicRenderer dynamicRenderer;
}

const GUID IID_IRealTimeStylus = {0xA8BB5D22, 0x3144, 0x4A7B, [0x93, 0xCD, 0xF3, 0x4A, 0x16, 0xBE, 0x51, 0x3A]};
@GUID(0xA8BB5D22, 0x3144, 0x4A7B, [0x93, 0xCD, 0xF3, 0x4A, 0x16, 0xBE, 0x51, 0x3A]);
interface IRealTimeStylus : IUnknown
{
    HRESULT get_Enabled(int* pfEnable);
    HRESULT put_Enabled(BOOL fEnable);
    HRESULT get_HWND(uint* phwnd);
    HRESULT put_HWND(uint hwnd);
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
    HRESULT AddCustomStylusDataToQueue(StylusQueue sq, const(Guid)* pGuidId, uint cbData, char* pbData);
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
    HRESULT GetPacketDescriptionData(uint tcid, float* pfInkToDeviceScaleX, float* pfInkToDeviceScaleY, uint* pcPacketProperties, char* ppPacketProperties);
}

const GUID IID_IRealTimeStylus2 = {0xB5F2A6CD, 0x3179, 0x4A3E, [0xB9, 0xC4, 0xBB, 0x58, 0x65, 0x96, 0x2B, 0xE2]};
@GUID(0xB5F2A6CD, 0x3179, 0x4A3E, [0xB9, 0xC4, 0xBB, 0x58, 0x65, 0x96, 0x2B, 0xE2]);
interface IRealTimeStylus2 : IUnknown
{
    HRESULT get_FlicksEnabled(int* pfEnable);
    HRESULT put_FlicksEnabled(BOOL fEnable);
}

const GUID IID_IRealTimeStylus3 = {0xD70230A3, 0x6986, 0x4051, [0xB5, 0x7A, 0x1C, 0xF6, 0x9F, 0x4D, 0x9D, 0xB5]};
@GUID(0xD70230A3, 0x6986, 0x4051, [0xB5, 0x7A, 0x1C, 0xF6, 0x9F, 0x4D, 0x9D, 0xB5]);
interface IRealTimeStylus3 : IUnknown
{
    HRESULT get_MultiTouchEnabled(int* pfEnable);
    HRESULT put_MultiTouchEnabled(BOOL fEnable);
}

const GUID IID_IRealTimeStylusSynchronization = {0xAA87EAB8, 0xAB4A, 0x4CEA, [0xB5, 0xCB, 0x46, 0xD8, 0x4C, 0x6A, 0x25, 0x09]};
@GUID(0xAA87EAB8, 0xAB4A, 0x4CEA, [0xB5, 0xCB, 0x46, 0xD8, 0x4C, 0x6A, 0x25, 0x09]);
interface IRealTimeStylusSynchronization : IUnknown
{
    HRESULT AcquireLock(RealTimeStylusLockType lock);
    HRESULT ReleaseLock(RealTimeStylusLockType lock);
}

const GUID IID_IStrokeBuilder = {0xA5FD4E2D, 0xC44B, 0x4092, [0x91, 0x77, 0x26, 0x09, 0x05, 0xEB, 0x67, 0x2B]};
@GUID(0xA5FD4E2D, 0xC44B, 0x4092, [0x91, 0x77, 0x26, 0x09, 0x05, 0xEB, 0x67, 0x2B]);
interface IStrokeBuilder : IUnknown
{
    HRESULT CreateStroke(uint cPktBuffLength, char* pPackets, uint cPacketProperties, char* pPacketProperties, float fInkToDeviceScaleX, float fInkToDeviceScaleY, IInkStrokeDisp* ppIInkStroke);
    HRESULT BeginStroke(uint tcid, uint sid, const(int)* pPacket, uint cPacketProperties, char* pPacketProperties, float fInkToDeviceScaleX, float fInkToDeviceScaleY, IInkStrokeDisp* ppIInkStroke);
    HRESULT AppendPackets(uint tcid, uint sid, uint cPktBuffLength, char* pPackets);
    HRESULT EndStroke(uint tcid, uint sid, IInkStrokeDisp* ppIInkStroke, RECT* pDirtyRect);
    HRESULT get_Ink(IInkDisp* ppiInkObj);
    HRESULT putref_Ink(IInkDisp piInkObj);
}

const GUID IID_IStylusPlugin = {0xA81436D8, 0x4757, 0x4FD1, [0xA1, 0x85, 0x13, 0x3F, 0x97, 0xC6, 0xC5, 0x45]};
@GUID(0xA81436D8, 0x4757, 0x4FD1, [0xA1, 0x85, 0x13, 0x3F, 0x97, 0xC6, 0xC5, 0x45]);
interface IStylusPlugin : IUnknown
{
    HRESULT RealTimeStylusEnabled(IRealTimeStylus piRtsSrc, uint cTcidCount, char* pTcids);
    HRESULT RealTimeStylusDisabled(IRealTimeStylus piRtsSrc, uint cTcidCount, char* pTcids);
    HRESULT StylusInRange(IRealTimeStylus piRtsSrc, uint tcid, uint sid);
    HRESULT StylusOutOfRange(IRealTimeStylus piRtsSrc, uint tcid, uint sid);
    HRESULT StylusDown(IRealTimeStylus piRtsSrc, const(StylusInfo)* pStylusInfo, uint cPropCountPerPkt, char* pPacket, int** ppInOutPkt);
    HRESULT StylusUp(IRealTimeStylus piRtsSrc, const(StylusInfo)* pStylusInfo, uint cPropCountPerPkt, char* pPacket, int** ppInOutPkt);
    HRESULT StylusButtonDown(IRealTimeStylus piRtsSrc, uint sid, const(Guid)* pGuidStylusButton, POINT* pStylusPos);
    HRESULT StylusButtonUp(IRealTimeStylus piRtsSrc, uint sid, const(Guid)* pGuidStylusButton, POINT* pStylusPos);
    HRESULT InAirPackets(IRealTimeStylus piRtsSrc, const(StylusInfo)* pStylusInfo, uint cPktCount, uint cPktBuffLength, char* pPackets, uint* pcInOutPkts, int** ppInOutPkts);
    HRESULT Packets(IRealTimeStylus piRtsSrc, const(StylusInfo)* pStylusInfo, uint cPktCount, uint cPktBuffLength, char* pPackets, uint* pcInOutPkts, int** ppInOutPkts);
    HRESULT CustomStylusDataAdded(IRealTimeStylus piRtsSrc, const(Guid)* pGuidId, uint cbData, char* pbData);
    HRESULT SystemEvent(IRealTimeStylus piRtsSrc, uint tcid, uint sid, ushort event, SYSTEM_EVENT_DATA eventdata);
    HRESULT TabletAdded(IRealTimeStylus piRtsSrc, IInkTablet piTablet);
    HRESULT TabletRemoved(IRealTimeStylus piRtsSrc, int iTabletIndex);
    HRESULT Error(IRealTimeStylus piRtsSrc, IStylusPlugin piPlugin, RealTimeStylusDataInterest dataInterest, HRESULT hrErrorCode, int* lptrKey);
    HRESULT UpdateMapping(IRealTimeStylus piRtsSrc);
    HRESULT DataInterest(RealTimeStylusDataInterest* pDataInterest);
}

const GUID IID_IStylusSyncPlugin = {0xA157B174, 0x482F, 0x4D71, [0xA3, 0xF6, 0x3A, 0x41, 0xDD, 0xD1, 0x1B, 0xE9]};
@GUID(0xA157B174, 0x482F, 0x4D71, [0xA3, 0xF6, 0x3A, 0x41, 0xDD, 0xD1, 0x1B, 0xE9]);
interface IStylusSyncPlugin : IStylusPlugin
{
}

const GUID IID_IStylusAsyncPlugin = {0xA7CCA85A, 0x31BC, 0x4CD2, [0xAA, 0xDC, 0x32, 0x89, 0xA3, 0xAF, 0x11, 0xC8]};
@GUID(0xA7CCA85A, 0x31BC, 0x4CD2, [0xAA, 0xDC, 0x32, 0x89, 0xA3, 0xAF, 0x11, 0xC8]);
interface IStylusAsyncPlugin : IStylusPlugin
{
}

const GUID IID_IDynamicRenderer = {0xA079468E, 0x7165, 0x46F9, [0xB7, 0xAF, 0x98, 0xAD, 0x01, 0xA9, 0x30, 0x09]};
@GUID(0xA079468E, 0x7165, 0x46F9, [0xB7, 0xAF, 0x98, 0xAD, 0x01, 0xA9, 0x30, 0x09]);
interface IDynamicRenderer : IUnknown
{
    HRESULT get_Enabled(int* bEnabled);
    HRESULT put_Enabled(BOOL bEnabled);
    HRESULT get_HWND(uint* hwnd);
    HRESULT put_HWND(uint hwnd);
    HRESULT get_ClipRectangle(RECT* prcClipRect);
    HRESULT put_ClipRectangle(const(RECT)* prcClipRect);
    HRESULT get_ClipRegion(uint* phClipRgn);
    HRESULT put_ClipRegion(uint hClipRgn);
    HRESULT get_DrawingAttributes(IInkDrawingAttributes* ppiDA);
    HRESULT putref_DrawingAttributes(IInkDrawingAttributes piDA);
    HRESULT get_DataCacheEnabled(int* pfCacheData);
    HRESULT put_DataCacheEnabled(BOOL fCacheData);
    HRESULT ReleaseCachedData(uint strokeId);
    HRESULT Refresh();
    HRESULT Draw(uint hDC);
}

const GUID IID_IGestureRecognizer = {0xAE9EF86B, 0x7054, 0x45E3, [0xAE, 0x22, 0x31, 0x74, 0xDC, 0x88, 0x11, 0xB7]};
@GUID(0xAE9EF86B, 0x7054, 0x45E3, [0xAE, 0x22, 0x31, 0x74, 0xDC, 0x88, 0x11, 0xB7]);
interface IGestureRecognizer : IUnknown
{
    HRESULT get_Enabled(int* pfEnabled);
    HRESULT put_Enabled(BOOL fEnabled);
    HRESULT get_MaxStrokeCount(int* pcStrokes);
    HRESULT put_MaxStrokeCount(int cStrokes);
    HRESULT EnableGestures(uint cGestures, char* pGestures);
    HRESULT Reset();
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
    uint dwRecoCapabilityFlags;
    ushort awcVendorName;
    ushort awcFriendlyName;
    ushort awLanguageId;
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
    short iMidlineOffset;
}

enum LINE_METRICS
{
    LM_BASELINE = 0,
    LM_MIDLINE = 1,
    LM_ASCENDER = 2,
    LM_DESCENDER = 3,
}

enum CONFIDENCE_LEVEL
{
    CFL_STRONG = 0,
    CFL_INTERMEDIATE = 1,
    CFL_POOR = 2,
}

enum ALT_BREAKS
{
    ALT_BREAKS_SAME = 0,
    ALT_BREAKS_UNIQUE = 1,
    ALT_BREAKS_FULL = 2,
}

enum enumRECO_TYPE
{
    RECO_TYPE_WSTRING = 0,
    RECO_TYPE_WCHAR = 1,
}

struct RECO_LATTICE_PROPERTY
{
    Guid guidProperty;
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
    int score;
    ushort type;
    ubyte* pData;
    uint ulNextColumn;
    uint ulStrokeNumber;
    RECO_LATTICE_PROPERTIES epProp;
}

struct RECO_LATTICE_COLUMN
{
    uint key;
    RECO_LATTICE_PROPERTIES cpProp;
    uint cStrokes;
    uint* pStrokes;
    uint cLatticeElements;
    RECO_LATTICE_ELEMENT* pLatticeElements;
}

struct RECO_LATTICE
{
    uint ulColumnCount;
    RECO_LATTICE_COLUMN* pLatticeColumns;
    uint ulPropertyCount;
    Guid* pGuidProperties;
    uint ulBestResultColumnCount;
    uint* pulBestResultColumns;
    uint* pulBestResultIndexes;
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

const GUID CLSID_TipAutoCompleteClient = {0x807C1E6C, 0x1D00, 0x453F, [0xB9, 0x20, 0xB6, 0x1B, 0xB7, 0xCD, 0xD9, 0x97]};
@GUID(0x807C1E6C, 0x1D00, 0x453F, [0xB9, 0x20, 0xB6, 0x1B, 0xB7, 0xCD, 0xD9, 0x97]);
struct TipAutoCompleteClient;

const GUID IID_ITipAutoCompleteProvider = {0x7C6CF46D, 0x8404, 0x46B9, [0xAD, 0x33, 0xF5, 0xB6, 0x03, 0x6D, 0x40, 0x07]};
@GUID(0x7C6CF46D, 0x8404, 0x46B9, [0xAD, 0x33, 0xF5, 0xB6, 0x03, 0x6D, 0x40, 0x07]);
interface ITipAutoCompleteProvider : IUnknown
{
    HRESULT UpdatePendingText(BSTR bstrPendingText);
    HRESULT Show(BOOL fShow);
}

const GUID IID_ITipAutoCompleteClient = {0x5E078E03, 0x8265, 0x4BBE, [0x94, 0x87, 0xD2, 0x42, 0xED, 0xBE, 0xF9, 0x10]};
@GUID(0x5E078E03, 0x8265, 0x4BBE, [0x94, 0x87, 0xD2, 0x42, 0xED, 0xBE, 0xF9, 0x10]);
interface ITipAutoCompleteClient : IUnknown
{
    HRESULT AdviseProvider(HWND hWndField, ITipAutoCompleteProvider pIProvider);
    HRESULT UnadviseProvider(HWND hWndField, ITipAutoCompleteProvider pIProvider);
    HRESULT UserSelection();
    HRESULT PreferredRects(RECT* prcACList, RECT* prcField, RECT* prcModifiedACList, int* pfShownAboveTip);
    HRESULT RequestShowUI(HWND hWndList, int* pfAllowShowing);
}

