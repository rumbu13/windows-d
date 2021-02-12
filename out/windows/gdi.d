module windows.gdi;

public import windows.dataexchange;
public import windows.direct2d;
public import windows.directshow;
public import windows.displaydevices;
public import windows.intl;
public import windows.opengl;
public import windows.shell;
public import windows.systemservices;
public import windows.windowsandmessaging;
public import windows.windowscolorsystem;
public import windows.xps;

extern(Windows):

struct XFORM
{
    float eM11;
    float eM12;
    float eM21;
    float eM22;
    float eDx;
    float eDy;
}

struct BITMAP
{
    int bmType;
    int bmWidth;
    int bmHeight;
    int bmWidthBytes;
    ushort bmPlanes;
    ushort bmBitsPixel;
    void* bmBits;
}

struct RGBTRIPLE
{
    ubyte rgbtBlue;
    ubyte rgbtGreen;
    ubyte rgbtRed;
}

struct RGBQUAD
{
    ubyte rgbBlue;
    ubyte rgbGreen;
    ubyte rgbRed;
    ubyte rgbReserved;
}

struct BITMAPCOREHEADER
{
    uint bcSize;
    ushort bcWidth;
    ushort bcHeight;
    ushort bcPlanes;
    ushort bcBitCount;
}

struct BITMAPV4HEADER
{
    uint bV4Size;
    int bV4Width;
    int bV4Height;
    ushort bV4Planes;
    ushort bV4BitCount;
    uint bV4V4Compression;
    uint bV4SizeImage;
    int bV4XPelsPerMeter;
    int bV4YPelsPerMeter;
    uint bV4ClrUsed;
    uint bV4ClrImportant;
    uint bV4RedMask;
    uint bV4GreenMask;
    uint bV4BlueMask;
    uint bV4AlphaMask;
    uint bV4CSType;
    CIEXYZTRIPLE bV4Endpoints;
    uint bV4GammaRed;
    uint bV4GammaGreen;
    uint bV4GammaBlue;
}

struct BITMAPV5HEADER
{
    uint bV5Size;
    int bV5Width;
    int bV5Height;
    ushort bV5Planes;
    ushort bV5BitCount;
    uint bV5Compression;
    uint bV5SizeImage;
    int bV5XPelsPerMeter;
    int bV5YPelsPerMeter;
    uint bV5ClrUsed;
    uint bV5ClrImportant;
    uint bV5RedMask;
    uint bV5GreenMask;
    uint bV5BlueMask;
    uint bV5AlphaMask;
    uint bV5CSType;
    CIEXYZTRIPLE bV5Endpoints;
    uint bV5GammaRed;
    uint bV5GammaGreen;
    uint bV5GammaBlue;
    uint bV5Intent;
    uint bV5ProfileData;
    uint bV5ProfileSize;
    uint bV5Reserved;
}

struct BITMAPINFO
{
    BITMAPINFOHEADER bmiHeader;
    RGBQUAD bmiColors;
}

struct BITMAPCOREINFO
{
    BITMAPCOREHEADER bmciHeader;
    RGBTRIPLE bmciColors;
}

struct BITMAPFILEHEADER
{
    ushort bfType;
    uint bfSize;
    ushort bfReserved1;
    ushort bfReserved2;
    uint bfOffBits;
}

struct HANDLETABLE
{
    int objectHandle;
}

struct METARECORD
{
    uint rdSize;
    ushort rdFunction;
    ushort rdParm;
}

struct METAHEADER
{
    ushort mtType;
    ushort mtHeaderSize;
    ushort mtVersion;
    uint mtSize;
    ushort mtNoObjects;
    uint mtMaxRecord;
    ushort mtNoParameters;
}

struct ENHMETARECORD
{
    uint iType;
    uint nSize;
    uint dParm;
}

struct ENHMETAHEADER
{
    uint iType;
    uint nSize;
    RECTL rclBounds;
    RECTL rclFrame;
    uint dSignature;
    uint nVersion;
    uint nBytes;
    uint nRecords;
    ushort nHandles;
    ushort sReserved;
    uint nDescription;
    uint offDescription;
    uint nPalEntries;
    SIZE szlDevice;
    SIZE szlMillimeters;
    uint cbPixelFormat;
    uint offPixelFormat;
    uint bOpenGL;
    SIZE szlMicrometers;
}

struct TEXTMETRICA
{
    int tmHeight;
    int tmAscent;
    int tmDescent;
    int tmInternalLeading;
    int tmExternalLeading;
    int tmAveCharWidth;
    int tmMaxCharWidth;
    int tmWeight;
    int tmOverhang;
    int tmDigitizedAspectX;
    int tmDigitizedAspectY;
    ubyte tmFirstChar;
    ubyte tmLastChar;
    ubyte tmDefaultChar;
    ubyte tmBreakChar;
    ubyte tmItalic;
    ubyte tmUnderlined;
    ubyte tmStruckOut;
    ubyte tmPitchAndFamily;
    ubyte tmCharSet;
}

struct TEXTMETRICW
{
    int tmHeight;
    int tmAscent;
    int tmDescent;
    int tmInternalLeading;
    int tmExternalLeading;
    int tmAveCharWidth;
    int tmMaxCharWidth;
    int tmWeight;
    int tmOverhang;
    int tmDigitizedAspectX;
    int tmDigitizedAspectY;
    ushort tmFirstChar;
    ushort tmLastChar;
    ushort tmDefaultChar;
    ushort tmBreakChar;
    ubyte tmItalic;
    ubyte tmUnderlined;
    ubyte tmStruckOut;
    ubyte tmPitchAndFamily;
    ubyte tmCharSet;
}

struct NEWTEXTMETRICA
{
    int tmHeight;
    int tmAscent;
    int tmDescent;
    int tmInternalLeading;
    int tmExternalLeading;
    int tmAveCharWidth;
    int tmMaxCharWidth;
    int tmWeight;
    int tmOverhang;
    int tmDigitizedAspectX;
    int tmDigitizedAspectY;
    ubyte tmFirstChar;
    ubyte tmLastChar;
    ubyte tmDefaultChar;
    ubyte tmBreakChar;
    ubyte tmItalic;
    ubyte tmUnderlined;
    ubyte tmStruckOut;
    ubyte tmPitchAndFamily;
    ubyte tmCharSet;
    uint ntmFlags;
    uint ntmSizeEM;
    uint ntmCellHeight;
    uint ntmAvgWidth;
}

struct NEWTEXTMETRICW
{
    int tmHeight;
    int tmAscent;
    int tmDescent;
    int tmInternalLeading;
    int tmExternalLeading;
    int tmAveCharWidth;
    int tmMaxCharWidth;
    int tmWeight;
    int tmOverhang;
    int tmDigitizedAspectX;
    int tmDigitizedAspectY;
    ushort tmFirstChar;
    ushort tmLastChar;
    ushort tmDefaultChar;
    ushort tmBreakChar;
    ubyte tmItalic;
    ubyte tmUnderlined;
    ubyte tmStruckOut;
    ubyte tmPitchAndFamily;
    ubyte tmCharSet;
    uint ntmFlags;
    uint ntmSizeEM;
    uint ntmCellHeight;
    uint ntmAvgWidth;
}

struct NEWTEXTMETRICEXA
{
    NEWTEXTMETRICA ntmTm;
    FONTSIGNATURE ntmFontSig;
}

struct NEWTEXTMETRICEXW
{
    NEWTEXTMETRICW ntmTm;
    FONTSIGNATURE ntmFontSig;
}

struct PELARRAY
{
    int paXCount;
    int paYCount;
    int paXExt;
    int paYExt;
    ubyte paRGBs;
}

struct LOGBRUSH
{
    uint lbStyle;
    uint lbColor;
    uint lbHatch;
}

struct LOGBRUSH32
{
    uint lbStyle;
    uint lbColor;
    uint lbHatch;
}

struct LOGPEN
{
    uint lopnStyle;
    POINT lopnWidth;
    uint lopnColor;
}

struct EXTLOGPEN
{
    uint elpPenStyle;
    uint elpWidth;
    uint elpBrushStyle;
    uint elpColor;
    uint elpHatch;
    uint elpNumEntries;
    uint elpStyleEntry;
}

struct EXTLOGPEN32
{
    uint elpPenStyle;
    uint elpWidth;
    uint elpBrushStyle;
    uint elpColor;
    uint elpHatch;
    uint elpNumEntries;
    uint elpStyleEntry;
}

struct LOGPALETTE
{
    ushort palVersion;
    ushort palNumEntries;
    PALETTEENTRY palPalEntry;
}

struct ENUMLOGFONTA
{
    LOGFONTA elfLogFont;
    ubyte elfFullName;
    ubyte elfStyle;
}

struct ENUMLOGFONTW
{
    LOGFONTW elfLogFont;
    ushort elfFullName;
    ushort elfStyle;
}

struct ENUMLOGFONTEXA
{
    LOGFONTA elfLogFont;
    ubyte elfFullName;
    ubyte elfStyle;
    ubyte elfScript;
}

struct ENUMLOGFONTEXW
{
    LOGFONTW elfLogFont;
    ushort elfFullName;
    ushort elfStyle;
    ushort elfScript;
}

struct PANOSE
{
    ubyte bFamilyType;
    ubyte bSerifStyle;
    ubyte bWeight;
    ubyte bProportion;
    ubyte bContrast;
    ubyte bStrokeVariation;
    ubyte bArmStyle;
    ubyte bLetterform;
    ubyte bMidline;
    ubyte bXHeight;
}

struct EXTLOGFONTA
{
    LOGFONTA elfLogFont;
    ubyte elfFullName;
    ubyte elfStyle;
    uint elfVersion;
    uint elfStyleSize;
    uint elfMatch;
    uint elfReserved;
    ubyte elfVendorId;
    uint elfCulture;
    PANOSE elfPanose;
}

struct EXTLOGFONTW
{
    LOGFONTW elfLogFont;
    ushort elfFullName;
    ushort elfStyle;
    uint elfVersion;
    uint elfStyleSize;
    uint elfMatch;
    uint elfReserved;
    ubyte elfVendorId;
    uint elfCulture;
    PANOSE elfPanose;
}

struct DISPLAY_DEVICEA
{
    uint cb;
    byte DeviceName;
    byte DeviceString;
    uint StateFlags;
    byte DeviceID;
    byte DeviceKey;
}

struct DISPLAY_DEVICEW
{
    uint cb;
    ushort DeviceName;
    ushort DeviceString;
    uint StateFlags;
    ushort DeviceID;
    ushort DeviceKey;
}

enum DISPLAYCONFIG_COLOR_ENCODING
{
    DISPLAYCONFIG_COLOR_ENCODING_RGB = 0,
    DISPLAYCONFIG_COLOR_ENCODING_YCBCR444 = 1,
    DISPLAYCONFIG_COLOR_ENCODING_YCBCR422 = 2,
    DISPLAYCONFIG_COLOR_ENCODING_YCBCR420 = 3,
    DISPLAYCONFIG_COLOR_ENCODING_INTENSITY = 4,
    DISPLAYCONFIG_COLOR_ENCODING_FORCE_UINT32 = -1,
}

struct DISPLAYCONFIG_GET_ADVANCED_COLOR_INFO
{
    DISPLAYCONFIG_DEVICE_INFO_HEADER header;
    _Anonymous_e__Union Anonymous;
    DISPLAYCONFIG_COLOR_ENCODING colorEncoding;
    uint bitsPerColorChannel;
}

struct DISPLAYCONFIG_SET_ADVANCED_COLOR_STATE
{
    DISPLAYCONFIG_DEVICE_INFO_HEADER header;
    _Anonymous_e__Union Anonymous;
}

struct DISPLAYCONFIG_SDR_WHITE_LEVEL
{
    DISPLAYCONFIG_DEVICE_INFO_HEADER header;
    uint SDRWhiteLevel;
}

struct RGNDATAHEADER
{
    uint dwSize;
    uint iType;
    uint nCount;
    uint nRgnSize;
    RECT rcBound;
}

struct RGNDATA
{
    RGNDATAHEADER rdh;
    byte Buffer;
}

struct ABC
{
    int abcA;
    uint abcB;
    int abcC;
}

struct ABCFLOAT
{
    float abcfA;
    float abcfB;
    float abcfC;
}

struct OUTLINETEXTMETRICA
{
    uint otmSize;
    TEXTMETRICA otmTextMetrics;
    ubyte otmFiller;
    PANOSE otmPanoseNumber;
    uint otmfsSelection;
    uint otmfsType;
    int otmsCharSlopeRise;
    int otmsCharSlopeRun;
    int otmItalicAngle;
    uint otmEMSquare;
    int otmAscent;
    int otmDescent;
    uint otmLineGap;
    uint otmsCapEmHeight;
    uint otmsXHeight;
    RECT otmrcFontBox;
    int otmMacAscent;
    int otmMacDescent;
    uint otmMacLineGap;
    uint otmusMinimumPPEM;
    POINT otmptSubscriptSize;
    POINT otmptSubscriptOffset;
    POINT otmptSuperscriptSize;
    POINT otmptSuperscriptOffset;
    uint otmsStrikeoutSize;
    int otmsStrikeoutPosition;
    int otmsUnderscoreSize;
    int otmsUnderscorePosition;
    const(char)* otmpFamilyName;
    const(char)* otmpFaceName;
    const(char)* otmpStyleName;
    const(char)* otmpFullName;
}

struct OUTLINETEXTMETRICW
{
    uint otmSize;
    TEXTMETRICW otmTextMetrics;
    ubyte otmFiller;
    PANOSE otmPanoseNumber;
    uint otmfsSelection;
    uint otmfsType;
    int otmsCharSlopeRise;
    int otmsCharSlopeRun;
    int otmItalicAngle;
    uint otmEMSquare;
    int otmAscent;
    int otmDescent;
    uint otmLineGap;
    uint otmsCapEmHeight;
    uint otmsXHeight;
    RECT otmrcFontBox;
    int otmMacAscent;
    int otmMacDescent;
    uint otmMacLineGap;
    uint otmusMinimumPPEM;
    POINT otmptSubscriptSize;
    POINT otmptSubscriptOffset;
    POINT otmptSuperscriptSize;
    POINT otmptSuperscriptOffset;
    uint otmsStrikeoutSize;
    int otmsStrikeoutPosition;
    int otmsUnderscoreSize;
    int otmsUnderscorePosition;
    const(char)* otmpFamilyName;
    const(char)* otmpFaceName;
    const(char)* otmpStyleName;
    const(char)* otmpFullName;
}

struct POLYTEXTA
{
    int x;
    int y;
    uint n;
    const(char)* lpstr;
    uint uiFlags;
    RECT rcl;
    int* pdx;
}

struct POLYTEXTW
{
    int x;
    int y;
    uint n;
    const(wchar)* lpstr;
    uint uiFlags;
    RECT rcl;
    int* pdx;
}

struct FIXED
{
    ushort fract;
    short value;
}

struct MAT2
{
    FIXED eM11;
    FIXED eM12;
    FIXED eM21;
    FIXED eM22;
}

struct GLYPHMETRICS
{
    uint gmBlackBoxX;
    uint gmBlackBoxY;
    POINT gmptGlyphOrigin;
    short gmCellIncX;
    short gmCellIncY;
}

struct POINTFX
{
    FIXED x;
    FIXED y;
}

struct TTPOLYCURVE
{
    ushort wType;
    ushort cpfx;
    POINTFX apfx;
}

struct TTPOLYGONHEADER
{
    uint cb;
    uint dwType;
    POINTFX pfxStart;
}

struct GCP_RESULTSA
{
    uint lStructSize;
    const(char)* lpOutString;
    uint* lpOrder;
    int* lpDx;
    int* lpCaretPos;
    const(char)* lpClass;
    const(wchar)* lpGlyphs;
    uint nGlyphs;
    int nMaxFit;
}

struct GCP_RESULTSW
{
    uint lStructSize;
    const(wchar)* lpOutString;
    uint* lpOrder;
    int* lpDx;
    int* lpCaretPos;
    const(char)* lpClass;
    const(wchar)* lpGlyphs;
    uint nGlyphs;
    int nMaxFit;
}

struct RASTERIZER_STATUS
{
    short nSize;
    short wFlags;
    short nLanguageID;
}

alias OLDFONTENUMPROCA = extern(Windows) int function(const(LOGFONTA)* param0, const(TEXTMETRICA)* param1, uint param2, LPARAM param3);
alias OLDFONTENUMPROCW = extern(Windows) int function(const(LOGFONTW)* param0, const(TEXTMETRICW)* param1, uint param2, LPARAM param3);
alias FONTENUMPROCA = extern(Windows) int function();
alias FONTENUMPROCW = extern(Windows) int function();
alias FONTENUMPROC = extern(Windows) int function();
alias GOBJENUMPROC = extern(Windows) int function(void* param0, LPARAM param1);
alias LINEDDAPROC = extern(Windows) void function(int param0, int param1, LPARAM param2);
alias LPFNDEVMODE = extern(Windows) uint function(HWND param0, int param1, DEVMODEA* param2, const(char)* param3, const(char)* param4, DEVMODEA* param5, const(char)* param6, uint param7);
alias LPFNDEVCAPS = extern(Windows) uint function(const(char)* param0, const(char)* param1, uint param2, const(char)* param3, DEVMODEA* param4);
struct WCRANGE
{
    ushort wcLow;
    ushort cGlyphs;
}

struct GLYPHSET
{
    uint cbThis;
    uint flAccel;
    uint cGlyphsSupported;
    uint cRanges;
    WCRANGE ranges;
}

struct DESIGNVECTOR
{
    uint dvReserved;
    uint dvNumAxes;
    int dvValues;
}

struct AXISINFOA
{
    int axMinValue;
    int axMaxValue;
    ubyte axAxisName;
}

struct AXISINFOW
{
    int axMinValue;
    int axMaxValue;
    ushort axAxisName;
}

struct AXESLISTA
{
    uint axlReserved;
    uint axlNumAxes;
    AXISINFOA axlAxisInfo;
}

struct AXESLISTW
{
    uint axlReserved;
    uint axlNumAxes;
    AXISINFOW axlAxisInfo;
}

struct ENUMLOGFONTEXDVA
{
    ENUMLOGFONTEXA elfEnumLogfontEx;
    DESIGNVECTOR elfDesignVector;
}

struct ENUMLOGFONTEXDVW
{
    ENUMLOGFONTEXW elfEnumLogfontEx;
    DESIGNVECTOR elfDesignVector;
}

struct ENUMTEXTMETRICA
{
    NEWTEXTMETRICEXA etmNewTextMetricEx;
    AXESLISTA etmAxesList;
}

struct ENUMTEXTMETRICW
{
    NEWTEXTMETRICEXW etmNewTextMetricEx;
    AXESLISTW etmAxesList;
}

struct TRIVERTEX
{
    int x;
    int y;
    ushort Red;
    ushort Green;
    ushort Blue;
    ushort Alpha;
}

struct GRADIENT_TRIANGLE
{
    uint Vertex1;
    uint Vertex2;
    uint Vertex3;
}

struct GRADIENT_RECT
{
    uint UpperLeft;
    uint LowerRight;
}

struct BLENDFUNCTION
{
    ubyte BlendOp;
    ubyte BlendFlags;
    ubyte SourceConstantAlpha;
    ubyte AlphaFormat;
}

alias MFENUMPROC = extern(Windows) int function(HDC hdc, char* lpht, METARECORD* lpMR, int nObj, LPARAM param4);
alias ENHMFENUMPROC = extern(Windows) int function(HDC hdc, char* lpht, const(ENHMETARECORD)* lpmr, int nHandles, LPARAM data);
struct DIBSECTION
{
    BITMAP dsBm;
    BITMAPINFOHEADER dsBmih;
    uint dsBitfields;
    HANDLE dshSection;
    uint dsOffset;
}

struct COLORADJUSTMENT
{
    ushort caSize;
    ushort caFlags;
    ushort caIlluminantIndex;
    ushort caRedGamma;
    ushort caGreenGamma;
    ushort caBlueGamma;
    ushort caReferenceBlack;
    ushort caReferenceWhite;
    short caContrast;
    short caBrightness;
    short caColorfulness;
    short caRedGreenTint;
}

struct KERNINGPAIR
{
    ushort wFirst;
    ushort wSecond;
    int iKernAmount;
}

struct EMR
{
    uint iType;
    uint nSize;
}

struct EMRTEXT
{
    POINTL ptlReference;
    uint nChars;
    uint offString;
    uint fOptions;
    RECTL rcl;
    uint offDx;
}

struct ABORTPATH
{
    EMR emr;
}

struct EMRSELECTCLIPPATH
{
    EMR emr;
    uint iMode;
}

struct EMRSETMITERLIMIT
{
    EMR emr;
    float eMiterLimit;
}

struct EMRRESTOREDC
{
    EMR emr;
    int iRelative;
}

struct EMRSETARCDIRECTION
{
    EMR emr;
    uint iArcDirection;
}

struct EMRSETMAPPERFLAGS
{
    EMR emr;
    uint dwFlags;
}

struct EMRSETTEXTCOLOR
{
    EMR emr;
    uint crColor;
}

struct EMRSELECTOBJECT
{
    EMR emr;
    uint ihObject;
}

struct EMRSELECTPALETTE
{
    EMR emr;
    uint ihPal;
}

struct EMRRESIZEPALETTE
{
    EMR emr;
    uint ihPal;
    uint cEntries;
}

struct EMRSETPALETTEENTRIES
{
    EMR emr;
    uint ihPal;
    uint iStart;
    uint cEntries;
    PALETTEENTRY aPalEntries;
}

struct EMRSETCOLORADJUSTMENT
{
    EMR emr;
    COLORADJUSTMENT ColorAdjustment;
}

struct EMRGDICOMMENT
{
    EMR emr;
    uint cbData;
    ubyte Data;
}

struct EMREOF
{
    EMR emr;
    uint nPalEntries;
    uint offPalEntries;
    uint nSizeLast;
}

struct EMRLINETO
{
    EMR emr;
    POINTL ptl;
}

struct EMROFFSETCLIPRGN
{
    EMR emr;
    POINTL ptlOffset;
}

struct EMRFILLPATH
{
    EMR emr;
    RECTL rclBounds;
}

struct EMREXCLUDECLIPRECT
{
    EMR emr;
    RECTL rclClip;
}

struct EMRSETVIEWPORTORGEX
{
    EMR emr;
    POINTL ptlOrigin;
}

struct EMRSETVIEWPORTEXTEX
{
    EMR emr;
    SIZE szlExtent;
}

struct EMRSCALEVIEWPORTEXTEX
{
    EMR emr;
    int xNum;
    int xDenom;
    int yNum;
    int yDenom;
}

struct EMRSETWORLDTRANSFORM
{
    EMR emr;
    XFORM xform;
}

struct EMRMODIFYWORLDTRANSFORM
{
    EMR emr;
    XFORM xform;
    uint iMode;
}

struct EMRSETPIXELV
{
    EMR emr;
    POINTL ptlPixel;
    uint crColor;
}

struct EMREXTFLOODFILL
{
    EMR emr;
    POINTL ptlStart;
    uint crColor;
    uint iMode;
}

struct EMRELLIPSE
{
    EMR emr;
    RECTL rclBox;
}

struct EMRROUNDRECT
{
    EMR emr;
    RECTL rclBox;
    SIZE szlCorner;
}

struct EMRARC
{
    EMR emr;
    RECTL rclBox;
    POINTL ptlStart;
    POINTL ptlEnd;
}

struct EMRANGLEARC
{
    EMR emr;
    POINTL ptlCenter;
    uint nRadius;
    float eStartAngle;
    float eSweepAngle;
}

struct EMRPOLYLINE
{
    EMR emr;
    RECTL rclBounds;
    uint cptl;
    POINTL aptl;
}

struct EMRPOLYLINE16
{
    EMR emr;
    RECTL rclBounds;
    uint cpts;
    POINTS apts;
}

struct EMRPOLYDRAW
{
    EMR emr;
    RECTL rclBounds;
    uint cptl;
    POINTL aptl;
    ubyte abTypes;
}

struct EMRPOLYDRAW16
{
    EMR emr;
    RECTL rclBounds;
    uint cpts;
    POINTS apts;
    ubyte abTypes;
}

struct EMRPOLYPOLYLINE
{
    EMR emr;
    RECTL rclBounds;
    uint nPolys;
    uint cptl;
    uint aPolyCounts;
    POINTL aptl;
}

struct EMRPOLYPOLYLINE16
{
    EMR emr;
    RECTL rclBounds;
    uint nPolys;
    uint cpts;
    uint aPolyCounts;
    POINTS apts;
}

struct EMRINVERTRGN
{
    EMR emr;
    RECTL rclBounds;
    uint cbRgnData;
    ubyte RgnData;
}

struct EMRFILLRGN
{
    EMR emr;
    RECTL rclBounds;
    uint cbRgnData;
    uint ihBrush;
    ubyte RgnData;
}

struct EMRFRAMERGN
{
    EMR emr;
    RECTL rclBounds;
    uint cbRgnData;
    uint ihBrush;
    SIZE szlStroke;
    ubyte RgnData;
}

struct EMREXTSELECTCLIPRGN
{
    EMR emr;
    uint cbRgnData;
    uint iMode;
    ubyte RgnData;
}

struct EMREXTTEXTOUTA
{
    EMR emr;
    RECTL rclBounds;
    uint iGraphicsMode;
    float exScale;
    float eyScale;
    EMRTEXT emrtext;
}

struct EMRPOLYTEXTOUTA
{
    EMR emr;
    RECTL rclBounds;
    uint iGraphicsMode;
    float exScale;
    float eyScale;
    int cStrings;
    EMRTEXT aemrtext;
}

struct EMRBITBLT
{
    EMR emr;
    RECTL rclBounds;
    int xDest;
    int yDest;
    int cxDest;
    int cyDest;
    uint dwRop;
    int xSrc;
    int ySrc;
    XFORM xformSrc;
    uint crBkColorSrc;
    uint iUsageSrc;
    uint offBmiSrc;
    uint cbBmiSrc;
    uint offBitsSrc;
    uint cbBitsSrc;
}

struct EMRSTRETCHBLT
{
    EMR emr;
    RECTL rclBounds;
    int xDest;
    int yDest;
    int cxDest;
    int cyDest;
    uint dwRop;
    int xSrc;
    int ySrc;
    XFORM xformSrc;
    uint crBkColorSrc;
    uint iUsageSrc;
    uint offBmiSrc;
    uint cbBmiSrc;
    uint offBitsSrc;
    uint cbBitsSrc;
    int cxSrc;
    int cySrc;
}

struct EMRMASKBLT
{
    EMR emr;
    RECTL rclBounds;
    int xDest;
    int yDest;
    int cxDest;
    int cyDest;
    uint dwRop;
    int xSrc;
    int ySrc;
    XFORM xformSrc;
    uint crBkColorSrc;
    uint iUsageSrc;
    uint offBmiSrc;
    uint cbBmiSrc;
    uint offBitsSrc;
    uint cbBitsSrc;
    int xMask;
    int yMask;
    uint iUsageMask;
    uint offBmiMask;
    uint cbBmiMask;
    uint offBitsMask;
    uint cbBitsMask;
}

struct EMRPLGBLT
{
    EMR emr;
    RECTL rclBounds;
    POINTL aptlDest;
    int xSrc;
    int ySrc;
    int cxSrc;
    int cySrc;
    XFORM xformSrc;
    uint crBkColorSrc;
    uint iUsageSrc;
    uint offBmiSrc;
    uint cbBmiSrc;
    uint offBitsSrc;
    uint cbBitsSrc;
    int xMask;
    int yMask;
    uint iUsageMask;
    uint offBmiMask;
    uint cbBmiMask;
    uint offBitsMask;
    uint cbBitsMask;
}

struct EMRSETDIBITSTODEVICE
{
    EMR emr;
    RECTL rclBounds;
    int xDest;
    int yDest;
    int xSrc;
    int ySrc;
    int cxSrc;
    int cySrc;
    uint offBmiSrc;
    uint cbBmiSrc;
    uint offBitsSrc;
    uint cbBitsSrc;
    uint iUsageSrc;
    uint iStartScan;
    uint cScans;
}

struct EMRSTRETCHDIBITS
{
    EMR emr;
    RECTL rclBounds;
    int xDest;
    int yDest;
    int xSrc;
    int ySrc;
    int cxSrc;
    int cySrc;
    uint offBmiSrc;
    uint cbBmiSrc;
    uint offBitsSrc;
    uint cbBitsSrc;
    uint iUsageSrc;
    uint dwRop;
    int cxDest;
    int cyDest;
}

struct EMREXTCREATEFONTINDIRECTW
{
    EMR emr;
    uint ihFont;
    EXTLOGFONTW elfw;
}

struct EMRCREATEPALETTE
{
    EMR emr;
    uint ihPal;
    LOGPALETTE lgpl;
}

struct EMRCREATEPEN
{
    EMR emr;
    uint ihPen;
    LOGPEN lopn;
}

struct EMREXTCREATEPEN
{
    EMR emr;
    uint ihPen;
    uint offBmi;
    uint cbBmi;
    uint offBits;
    uint cbBits;
    EXTLOGPEN32 elp;
}

struct EMRCREATEBRUSHINDIRECT
{
    EMR emr;
    uint ihBrush;
    LOGBRUSH32 lb;
}

struct EMRCREATEMONOBRUSH
{
    EMR emr;
    uint ihBrush;
    uint iUsage;
    uint offBmi;
    uint cbBmi;
    uint offBits;
    uint cbBits;
}

struct EMRCREATEDIBPATTERNBRUSHPT
{
    EMR emr;
    uint ihBrush;
    uint iUsage;
    uint offBmi;
    uint cbBmi;
    uint offBits;
    uint cbBits;
}

struct EMRFORMAT
{
    uint dSignature;
    uint nVersion;
    uint cbData;
    uint offData;
}

struct EMRGLSRECORD
{
    EMR emr;
    uint cbData;
    ubyte Data;
}

struct EMRGLSBOUNDEDRECORD
{
    EMR emr;
    RECTL rclBounds;
    uint cbData;
    ubyte Data;
}

struct EMRPIXELFORMAT
{
    EMR emr;
    PIXELFORMATDESCRIPTOR pfd;
}

struct EMRCREATECOLORSPACE
{
    EMR emr;
    uint ihCS;
    LOGCOLORSPACEA lcs;
}

struct EMRSETCOLORSPACE
{
    EMR emr;
    uint ihCS;
}

struct EMREXTESCAPE
{
    EMR emr;
    int iEscape;
    int cbEscData;
    ubyte EscData;
}

struct EMRNAMEDESCAPE
{
    EMR emr;
    int iEscape;
    int cbDriver;
    int cbEscData;
    ubyte EscData;
}

struct EMRSETICMPROFILE
{
    EMR emr;
    uint dwFlags;
    uint cbName;
    uint cbData;
    ubyte Data;
}

struct EMRCREATECOLORSPACEW
{
    EMR emr;
    uint ihCS;
    LOGCOLORSPACEW lcs;
    uint dwFlags;
    uint cbData;
    ubyte Data;
}

struct COLORMATCHTOTARGET
{
    EMR emr;
    uint dwAction;
    uint dwFlags;
    uint cbName;
    uint cbData;
    ubyte Data;
}

struct COLORCORRECTPALETTE
{
    EMR emr;
    uint ihPalette;
    uint nFirstEntry;
    uint nPalEntries;
    uint nReserved;
}

struct EMRALPHABLEND
{
    EMR emr;
    RECTL rclBounds;
    int xDest;
    int yDest;
    int cxDest;
    int cyDest;
    uint dwRop;
    int xSrc;
    int ySrc;
    XFORM xformSrc;
    uint crBkColorSrc;
    uint iUsageSrc;
    uint offBmiSrc;
    uint cbBmiSrc;
    uint offBitsSrc;
    uint cbBitsSrc;
    int cxSrc;
    int cySrc;
}

struct EMRGRADIENTFILL
{
    EMR emr;
    RECTL rclBounds;
    uint nVer;
    uint nTri;
    uint ulMode;
    TRIVERTEX Ver;
}

struct EMRTRANSPARENTBLT
{
    EMR emr;
    RECTL rclBounds;
    int xDest;
    int yDest;
    int cxDest;
    int cyDest;
    uint dwRop;
    int xSrc;
    int ySrc;
    XFORM xformSrc;
    uint crBkColorSrc;
    uint iUsageSrc;
    uint offBmiSrc;
    uint cbBmiSrc;
    uint offBitsSrc;
    uint cbBitsSrc;
    int cxSrc;
    int cySrc;
}

struct WGLSWAP
{
    HDC hdc;
    uint uiFlags;
}

alias CFP_ALLOCPROC = extern(Windows) void* function(uint param0);
alias CFP_REALLOCPROC = extern(Windows) void* function(void* param0, uint param1);
alias CFP_FREEPROC = extern(Windows) void function(void* param0);
alias READEMBEDPROC = extern(Windows) uint function(void* param0, void* param1, const(uint) param2);
alias WRITEEMBEDPROC = extern(Windows) uint function(void* param0, const(void)* param1, const(uint) param2);
struct TTLOADINFO
{
    ushort usStructSize;
    ushort usRefStrSize;
    ushort* pusRefStr;
}

struct TTEMBEDINFO
{
    ushort usStructSize;
    ushort usRootStrSize;
    ushort* pusRootStr;
}

struct TTVALIDATIONTESTSPARAMS
{
    uint ulStructSize;
    int lTestFromSize;
    int lTestToSize;
    uint ulCharSet;
    ushort usReserved1;
    ushort usCharCodeCount;
    ushort* pusCharCodeSet;
}

struct TTVALIDATIONTESTSPARAMSEX
{
    uint ulStructSize;
    int lTestFromSize;
    int lTestToSize;
    uint ulCharSet;
    ushort usReserved1;
    ushort usCharCodeCount;
    uint* pulCharCodeSet;
}

enum tagMxdcLandscapeRotationEnums
{
    MXDC_LANDSCAPE_ROTATE_COUNTERCLOCKWISE_90_DEGREES = 90,
    MXDC_LANDSCAPE_ROTATE_NONE = 0,
    MXDC_LANDSCAPE_ROTATE_COUNTERCLOCKWISE_270_DEGREES = -90,
}

enum tagMxdcImageTypeEnums
{
    MXDC_IMAGETYPE_JPEGHIGH_COMPRESSION = 1,
    MXDC_IMAGETYPE_JPEGMEDIUM_COMPRESSION = 2,
    MXDC_IMAGETYPE_JPEGLOW_COMPRESSION = 3,
    MXDC_IMAGETYPE_PNG = 4,
}

struct tagMxdcEscapeHeader
{
    uint cbInput;
    uint cbOutput;
    uint opCode;
}

struct tagMxdcGetFileNameData
{
    uint cbOutput;
    ushort wszData;
}

struct tagMxdcS0PageData
{
    uint dwSize;
    ubyte bData;
}

enum tagMxdcS0PageEnums
{
    MXDC_RESOURCE_TTF = 0,
    MXDC_RESOURCE_JPEG = 1,
    MXDC_RESOURCE_PNG = 2,
    MXDC_RESOURCE_TIFF = 3,
    MXDC_RESOURCE_WDP = 4,
    MXDC_RESOURCE_DICTIONARY = 5,
    MXDC_RESOURCE_ICC_PROFILE = 6,
    MXDC_RESOURCE_JPEG_THUMBNAIL = 7,
    MXDC_RESOURCE_PNG_THUMBNAIL = 8,
    MXDC_RESOURCE_MAX = 9,
}

struct tagMxdcXpsS0PageResource
{
    uint dwSize;
    uint dwResourceType;
    ubyte szUri;
    uint dwDataSize;
    ubyte bData;
}

struct tagMxdcPrintTicketPassthrough
{
    uint dwDataSize;
    ubyte bData;
}

struct tagMxdcPrintTicketEscape
{
    tagMxdcEscapeHeader mxdcEscape;
    tagMxdcPrintTicketPassthrough printTicketData;
}

struct tagMxdcS0PagePassthroughEscape
{
    tagMxdcEscapeHeader mxdcEscape;
    tagMxdcS0PageData xpsS0PageData;
}

struct tagMxdcS0PageResourceEscape
{
    tagMxdcEscapeHeader mxdcEscape;
    tagMxdcXpsS0PageResource xpsS0PageResourcePassthrough;
}

@DllImport("GDI32.dll")
int AddFontResourceA(const(char)* param0);

@DllImport("GDI32.dll")
int AddFontResourceW(const(wchar)* param0);

@DllImport("GDI32.dll")
BOOL AnimatePalette(HPALETTE hPal, uint iStartIndex, uint cEntries, char* ppe);

@DllImport("GDI32.dll")
BOOL Arc(HDC hdc, int x1, int y1, int x2, int y2, int x3, int y3, int x4, int y4);

@DllImport("GDI32.dll")
BOOL BitBlt(HDC hdc, int x, int y, int cx, int cy, HDC hdcSrc, int x1, int y1, uint rop);

@DllImport("GDI32.dll")
BOOL CancelDC(HDC hdc);

@DllImport("GDI32.dll")
BOOL Chord(HDC hdc, int x1, int y1, int x2, int y2, int x3, int y3, int x4, int y4);

@DllImport("GDI32.dll")
int CloseMetaFile(HDC hdc);

@DllImport("GDI32.dll")
int CombineRgn(HRGN hrgnDst, HRGN hrgnSrc1, HRGN hrgnSrc2, int iMode);

@DllImport("GDI32.dll")
int CopyMetaFileA(int param0, const(char)* param1);

@DllImport("GDI32.dll")
int CopyMetaFileW(int param0, const(wchar)* param1);

@DllImport("GDI32.dll")
HBITMAP CreateBitmap(int nWidth, int nHeight, uint nPlanes, uint nBitCount, const(void)* lpBits);

@DllImport("GDI32.dll")
HBITMAP CreateBitmapIndirect(const(BITMAP)* pbm);

@DllImport("GDI32.dll")
HBRUSH CreateBrushIndirect(const(LOGBRUSH)* plbrush);

@DllImport("GDI32.dll")
HBITMAP CreateCompatibleBitmap(HDC hdc, int cx, int cy);

@DllImport("GDI32.dll")
HBITMAP CreateDiscardableBitmap(HDC hdc, int cx, int cy);

@DllImport("GDI32.dll")
HDC CreateCompatibleDC(HDC hdc);

@DllImport("GDI32.dll")
HDC CreateDCA(const(char)* pwszDriver, const(char)* pwszDevice, const(char)* pszPort, const(DEVMODEA)* pdm);

@DllImport("GDI32.dll")
HDC CreateDCW(const(wchar)* pwszDriver, const(wchar)* pwszDevice, const(wchar)* pszPort, const(DEVMODEW)* pdm);

@DllImport("GDI32.dll")
HBITMAP CreateDIBitmap(HDC hdc, const(BITMAPINFOHEADER)* pbmih, uint flInit, const(void)* pjBits, const(BITMAPINFO)* pbmi, uint iUsage);

@DllImport("GDI32.dll")
HBRUSH CreateDIBPatternBrush(int h, uint iUsage);

@DllImport("GDI32.dll")
HBRUSH CreateDIBPatternBrushPt(const(void)* lpPackedDIB, uint iUsage);

@DllImport("GDI32.dll")
HRGN CreateEllipticRgn(int x1, int y1, int x2, int y2);

@DllImport("GDI32.dll")
HRGN CreateEllipticRgnIndirect(const(RECT)* lprect);

@DllImport("GDI32.dll")
HFONT CreateFontIndirectA(const(LOGFONTA)* lplf);

@DllImport("GDI32.dll")
HFONT CreateFontIndirectW(const(LOGFONTW)* lplf);

@DllImport("GDI32.dll")
HFONT CreateFontA(int cHeight, int cWidth, int cEscapement, int cOrientation, int cWeight, uint bItalic, uint bUnderline, uint bStrikeOut, uint iCharSet, uint iOutPrecision, uint iClipPrecision, uint iQuality, uint iPitchAndFamily, const(char)* pszFaceName);

@DllImport("GDI32.dll")
HFONT CreateFontW(int cHeight, int cWidth, int cEscapement, int cOrientation, int cWeight, uint bItalic, uint bUnderline, uint bStrikeOut, uint iCharSet, uint iOutPrecision, uint iClipPrecision, uint iQuality, uint iPitchAndFamily, const(wchar)* pszFaceName);

@DllImport("GDI32.dll")
HBRUSH CreateHatchBrush(int iHatch, uint color);

@DllImport("GDI32.dll")
HDC CreateICA(const(char)* pszDriver, const(char)* pszDevice, const(char)* pszPort, const(DEVMODEA)* pdm);

@DllImport("GDI32.dll")
HDC CreateICW(const(wchar)* pszDriver, const(wchar)* pszDevice, const(wchar)* pszPort, const(DEVMODEW)* pdm);

@DllImport("GDI32.dll")
HdcMetdataFileHandle CreateMetaFileA(const(char)* pszFile);

@DllImport("GDI32.dll")
HdcMetdataFileHandle CreateMetaFileW(const(wchar)* pszFile);

@DllImport("GDI32.dll")
HPALETTE CreatePalette(char* plpal);

@DllImport("GDI32.dll")
HPEN CreatePen(int iStyle, int cWidth, uint color);

@DllImport("GDI32.dll")
HPEN CreatePenIndirect(const(LOGPEN)* plpen);

@DllImport("GDI32.dll")
HRGN CreatePolyPolygonRgn(const(POINT)* pptl, char* pc, int cPoly, int iMode);

@DllImport("GDI32.dll")
HBRUSH CreatePatternBrush(HBITMAP hbm);

@DllImport("GDI32.dll")
HRGN CreateRectRgn(int x1, int y1, int x2, int y2);

@DllImport("GDI32.dll")
HRGN CreateRectRgnIndirect(const(RECT)* lprect);

@DllImport("GDI32.dll")
HRGN CreateRoundRectRgn(int x1, int y1, int x2, int y2, int w, int h);

@DllImport("GDI32.dll")
BOOL CreateScalableFontResourceA(uint fdwHidden, const(char)* lpszFont, const(char)* lpszFile, const(char)* lpszPath);

@DllImport("GDI32.dll")
BOOL CreateScalableFontResourceW(uint fdwHidden, const(wchar)* lpszFont, const(wchar)* lpszFile, const(wchar)* lpszPath);

@DllImport("GDI32.dll")
HBRUSH CreateSolidBrush(uint color);

@DllImport("GDI32.dll")
BOOL DeleteDC(HDC hdc);

@DllImport("GDI32.dll")
BOOL DeleteMetaFile(int hmf);

@DllImport("GDI32.dll")
BOOL DeleteObject(int ho);

@DllImport("GDI32.dll")
int DrawEscape(HDC hdc, int iEscape, int cjIn, const(char)* lpIn);

@DllImport("GDI32.dll")
BOOL Ellipse(HDC hdc, int left, int top, int right, int bottom);

@DllImport("GDI32.dll")
int EnumFontFamiliesExA(HDC hdc, LOGFONTA* lpLogfont, FONTENUMPROCA lpProc, LPARAM lParam, uint dwFlags);

@DllImport("GDI32.dll")
int EnumFontFamiliesExW(HDC hdc, LOGFONTW* lpLogfont, FONTENUMPROCW lpProc, LPARAM lParam, uint dwFlags);

@DllImport("GDI32.dll")
int EnumFontFamiliesA(HDC hdc, const(char)* lpLogfont, FONTENUMPROCA lpProc, LPARAM lParam);

@DllImport("GDI32.dll")
int EnumFontFamiliesW(HDC hdc, const(wchar)* lpLogfont, FONTENUMPROCW lpProc, LPARAM lParam);

@DllImport("GDI32.dll")
int EnumFontsA(HDC hdc, const(char)* lpLogfont, FONTENUMPROCA lpProc, LPARAM lParam);

@DllImport("GDI32.dll")
int EnumFontsW(HDC hdc, const(wchar)* lpLogfont, FONTENUMPROCW lpProc, LPARAM lParam);

@DllImport("GDI32.dll")
int EnumObjects(HDC hdc, int nType, GOBJENUMPROC lpFunc, LPARAM lParam);

@DllImport("GDI32.dll")
BOOL EqualRgn(HRGN hrgn1, HRGN hrgn2);

@DllImport("GDI32.dll")
int ExcludeClipRect(HDC hdc, int left, int top, int right, int bottom);

@DllImport("GDI32.dll")
HRGN ExtCreateRegion(const(XFORM)* lpx, uint nCount, char* lpData);

@DllImport("GDI32.dll")
BOOL ExtFloodFill(HDC hdc, int x, int y, uint color, uint type);

@DllImport("GDI32.dll")
BOOL FillRgn(HDC hdc, HRGN hrgn, HBRUSH hbr);

@DllImport("GDI32.dll")
BOOL FloodFill(HDC hdc, int x, int y, uint color);

@DllImport("GDI32.dll")
BOOL FrameRgn(HDC hdc, HRGN hrgn, HBRUSH hbr, int w, int h);

@DllImport("GDI32.dll")
int GetROP2(HDC hdc);

@DllImport("GDI32.dll")
BOOL GetAspectRatioFilterEx(HDC hdc, SIZE* lpsize);

@DllImport("GDI32.dll")
uint GetBkColor(HDC hdc);

@DllImport("GDI32.dll")
uint GetDCBrushColor(HDC hdc);

@DllImport("GDI32.dll")
uint GetDCPenColor(HDC hdc);

@DllImport("GDI32.dll")
int GetBkMode(HDC hdc);

@DllImport("GDI32.dll")
int GetBitmapBits(HBITMAP hbit, int cb, char* lpvBits);

@DllImport("GDI32.dll")
BOOL GetBitmapDimensionEx(HBITMAP hbit, SIZE* lpsize);

@DllImport("GDI32.dll")
uint GetBoundsRect(HDC hdc, RECT* lprect, uint flags);

@DllImport("GDI32.dll")
BOOL GetBrushOrgEx(HDC hdc, POINT* lppt);

@DllImport("GDI32.dll")
BOOL GetCharWidthA(HDC hdc, uint iFirst, uint iLast, char* lpBuffer);

@DllImport("GDI32.dll")
BOOL GetCharWidthW(HDC hdc, uint iFirst, uint iLast, char* lpBuffer);

@DllImport("GDI32.dll")
BOOL GetCharWidth32A(HDC hdc, uint iFirst, uint iLast, char* lpBuffer);

@DllImport("GDI32.dll")
BOOL GetCharWidth32W(HDC hdc, uint iFirst, uint iLast, char* lpBuffer);

@DllImport("GDI32.dll")
BOOL GetCharWidthFloatA(HDC hdc, uint iFirst, uint iLast, char* lpBuffer);

@DllImport("GDI32.dll")
BOOL GetCharWidthFloatW(HDC hdc, uint iFirst, uint iLast, char* lpBuffer);

@DllImport("GDI32.dll")
BOOL GetCharABCWidthsA(HDC hdc, uint wFirst, uint wLast, char* lpABC);

@DllImport("GDI32.dll")
BOOL GetCharABCWidthsW(HDC hdc, uint wFirst, uint wLast, char* lpABC);

@DllImport("GDI32.dll")
BOOL GetCharABCWidthsFloatA(HDC hdc, uint iFirst, uint iLast, char* lpABC);

@DllImport("GDI32.dll")
BOOL GetCharABCWidthsFloatW(HDC hdc, uint iFirst, uint iLast, char* lpABC);

@DllImport("GDI32.dll")
int GetClipBox(HDC hdc, RECT* lprect);

@DllImport("GDI32.dll")
int GetClipRgn(HDC hdc, HRGN hrgn);

@DllImport("GDI32.dll")
int GetMetaRgn(HDC hdc, HRGN hrgn);

@DllImport("GDI32.dll")
int GetCurrentObject(HDC hdc, uint type);

@DllImport("GDI32.dll")
BOOL GetCurrentPositionEx(HDC hdc, POINT* lppt);

@DllImport("GDI32.dll")
int GetDeviceCaps(HDC hdc, int index);

@DllImport("GDI32.dll")
int GetDIBits(HDC hdc, HBITMAP hbm, uint start, uint cLines, void* lpvBits, BITMAPINFO* lpbmi, uint usage);

@DllImport("GDI32.dll")
uint GetFontData(HDC hdc, uint dwTable, uint dwOffset, char* pvBuffer, uint cjBuffer);

@DllImport("GDI32.dll")
uint GetGlyphOutlineA(HDC hdc, uint uChar, uint fuFormat, GLYPHMETRICS* lpgm, uint cjBuffer, char* pvBuffer, const(MAT2)* lpmat2);

@DllImport("GDI32.dll")
uint GetGlyphOutlineW(HDC hdc, uint uChar, uint fuFormat, GLYPHMETRICS* lpgm, uint cjBuffer, char* pvBuffer, const(MAT2)* lpmat2);

@DllImport("GDI32.dll")
int GetGraphicsMode(HDC hdc);

@DllImport("GDI32.dll")
int GetMapMode(HDC hdc);

@DllImport("GDI32.dll")
uint GetMetaFileBitsEx(int hMF, uint cbBuffer, char* lpData);

@DllImport("GDI32.dll")
int GetMetaFileA(const(char)* lpName);

@DllImport("GDI32.dll")
int GetMetaFileW(const(wchar)* lpName);

@DllImport("GDI32.dll")
uint GetNearestColor(HDC hdc, uint color);

@DllImport("GDI32.dll")
uint GetNearestPaletteIndex(HPALETTE h, uint color);

@DllImport("GDI32.dll")
uint GetObjectType(int h);

@DllImport("GDI32.dll")
uint GetOutlineTextMetricsA(HDC hdc, uint cjCopy, char* potm);

@DllImport("GDI32.dll")
uint GetOutlineTextMetricsW(HDC hdc, uint cjCopy, char* potm);

@DllImport("GDI32.dll")
uint GetPaletteEntries(HPALETTE hpal, uint iStart, uint cEntries, char* pPalEntries);

@DllImport("GDI32.dll")
uint GetPixel(HDC hdc, int x, int y);

@DllImport("GDI32.dll")
int GetPolyFillMode(HDC hdc);

@DllImport("GDI32.dll")
BOOL GetRasterizerCaps(char* lpraststat, uint cjBytes);

@DllImport("GDI32.dll")
int GetRandomRgn(HDC hdc, HRGN hrgn, int i);

@DllImport("GDI32.dll")
uint GetRegionData(HRGN hrgn, uint nCount, char* lpRgnData);

@DllImport("GDI32.dll")
int GetRgnBox(HRGN hrgn, RECT* lprc);

@DllImport("GDI32.dll")
int GetStockObject(int i);

@DllImport("GDI32.dll")
int GetStretchBltMode(HDC hdc);

@DllImport("GDI32.dll")
uint GetSystemPaletteEntries(HDC hdc, uint iStart, uint cEntries, char* pPalEntries);

@DllImport("GDI32.dll")
uint GetSystemPaletteUse(HDC hdc);

@DllImport("GDI32.dll")
int GetTextCharacterExtra(HDC hdc);

@DllImport("GDI32.dll")
uint GetTextAlign(HDC hdc);

@DllImport("GDI32.dll")
uint GetTextColor(HDC hdc);

@DllImport("GDI32.dll")
BOOL GetTextExtentPointA(HDC hdc, const(char)* lpString, int c, SIZE* lpsz);

@DllImport("GDI32.dll")
BOOL GetTextExtentPointW(HDC hdc, const(wchar)* lpString, int c, SIZE* lpsz);

@DllImport("GDI32.dll")
BOOL GetTextExtentPoint32A(HDC hdc, const(char)* lpString, int c, SIZE* psizl);

@DllImport("GDI32.dll")
BOOL GetTextExtentPoint32W(HDC hdc, const(wchar)* lpString, int c, SIZE* psizl);

@DllImport("GDI32.dll")
BOOL GetTextExtentExPointA(HDC hdc, const(char)* lpszString, int cchString, int nMaxExtent, int* lpnFit, char* lpnDx, SIZE* lpSize);

@DllImport("GDI32.dll")
BOOL GetTextExtentExPointW(HDC hdc, const(wchar)* lpszString, int cchString, int nMaxExtent, int* lpnFit, char* lpnDx, SIZE* lpSize);

@DllImport("GDI32.dll")
uint GetFontLanguageInfo(HDC hdc);

@DllImport("GDI32.dll")
uint GetCharacterPlacementA(HDC hdc, const(char)* lpString, int nCount, int nMexExtent, GCP_RESULTSA* lpResults, uint dwFlags);

@DllImport("GDI32.dll")
uint GetCharacterPlacementW(HDC hdc, const(wchar)* lpString, int nCount, int nMexExtent, GCP_RESULTSW* lpResults, uint dwFlags);

@DllImport("GDI32.dll")
uint GetFontUnicodeRanges(HDC hdc, GLYPHSET* lpgs);

@DllImport("GDI32.dll")
uint GetGlyphIndicesA(HDC hdc, const(char)* lpstr, int c, char* pgi, uint fl);

@DllImport("GDI32.dll")
uint GetGlyphIndicesW(HDC hdc, const(wchar)* lpstr, int c, char* pgi, uint fl);

@DllImport("GDI32.dll")
BOOL GetTextExtentPointI(HDC hdc, char* pgiIn, int cgi, SIZE* psize);

@DllImport("GDI32.dll")
BOOL GetTextExtentExPointI(HDC hdc, char* lpwszString, int cwchString, int nMaxExtent, int* lpnFit, char* lpnDx, SIZE* lpSize);

@DllImport("GDI32.dll")
BOOL GetCharWidthI(HDC hdc, uint giFirst, uint cgi, char* pgi, char* piWidths);

@DllImport("GDI32.dll")
BOOL GetCharABCWidthsI(HDC hdc, uint giFirst, uint cgi, char* pgi, char* pabc);

@DllImport("GDI32.dll")
int AddFontResourceExA(const(char)* name, uint fl, void* res);

@DllImport("GDI32.dll")
int AddFontResourceExW(const(wchar)* name, uint fl, void* res);

@DllImport("GDI32.dll")
BOOL RemoveFontResourceExA(const(char)* name, uint fl, void* pdv);

@DllImport("GDI32.dll")
BOOL RemoveFontResourceExW(const(wchar)* name, uint fl, void* pdv);

@DllImport("GDI32.dll")
HANDLE AddFontMemResourceEx(char* pFileView, uint cjSize, void* pvResrved, uint* pNumFonts);

@DllImport("GDI32.dll")
BOOL RemoveFontMemResourceEx(HANDLE h);

@DllImport("GDI32.dll")
HFONT CreateFontIndirectExA(const(ENUMLOGFONTEXDVA)* param0);

@DllImport("GDI32.dll")
HFONT CreateFontIndirectExW(const(ENUMLOGFONTEXDVW)* param0);

@DllImport("GDI32.dll")
BOOL GetViewportExtEx(HDC hdc, SIZE* lpsize);

@DllImport("GDI32.dll")
BOOL GetViewportOrgEx(HDC hdc, POINT* lppoint);

@DllImport("GDI32.dll")
BOOL GetWindowExtEx(HDC hdc, SIZE* lpsize);

@DllImport("GDI32.dll")
BOOL GetWindowOrgEx(HDC hdc, POINT* lppoint);

@DllImport("GDI32.dll")
int IntersectClipRect(HDC hdc, int left, int top, int right, int bottom);

@DllImport("GDI32.dll")
BOOL InvertRgn(HDC hdc, HRGN hrgn);

@DllImport("GDI32.dll")
BOOL LineDDA(int xStart, int yStart, int xEnd, int yEnd, LINEDDAPROC lpProc, LPARAM data);

@DllImport("GDI32.dll")
BOOL LineTo(HDC hdc, int x, int y);

@DllImport("GDI32.dll")
BOOL MaskBlt(HDC hdcDest, int xDest, int yDest, int width, int height, HDC hdcSrc, int xSrc, int ySrc, HBITMAP hbmMask, int xMask, int yMask, uint rop);

@DllImport("GDI32.dll")
BOOL PlgBlt(HDC hdcDest, char* lpPoint, HDC hdcSrc, int xSrc, int ySrc, int width, int height, HBITMAP hbmMask, int xMask, int yMask);

@DllImport("GDI32.dll")
int OffsetClipRgn(HDC hdc, int x, int y);

@DllImport("GDI32.dll")
int OffsetRgn(HRGN hrgn, int x, int y);

@DllImport("GDI32.dll")
BOOL PatBlt(HDC hdc, int x, int y, int w, int h, uint rop);

@DllImport("GDI32.dll")
BOOL Pie(HDC hdc, int left, int top, int right, int bottom, int xr1, int yr1, int xr2, int yr2);

@DllImport("GDI32.dll")
BOOL PlayMetaFile(HDC hdc, int hmf);

@DllImport("GDI32.dll")
BOOL PaintRgn(HDC hdc, HRGN hrgn);

@DllImport("GDI32.dll")
BOOL PolyPolygon(HDC hdc, const(POINT)* apt, char* asz, int csz);

@DllImport("GDI32.dll")
BOOL PtInRegion(HRGN hrgn, int x, int y);

@DllImport("GDI32.dll")
BOOL PtVisible(HDC hdc, int x, int y);

@DllImport("GDI32.dll")
BOOL RectInRegion(HRGN hrgn, const(RECT)* lprect);

@DllImport("GDI32.dll")
BOOL RectVisible(HDC hdc, const(RECT)* lprect);

@DllImport("GDI32.dll")
BOOL Rectangle(HDC hdc, int left, int top, int right, int bottom);

@DllImport("GDI32.dll")
BOOL RestoreDC(HDC hdc, int nSavedDC);

@DllImport("GDI32.dll")
HDC ResetDCA(HDC hdc, const(DEVMODEA)* lpdm);

@DllImport("GDI32.dll")
HDC ResetDCW(HDC hdc, const(DEVMODEW)* lpdm);

@DllImport("GDI32.dll")
uint RealizePalette(HDC hdc);

@DllImport("GDI32.dll")
BOOL RemoveFontResourceA(const(char)* lpFileName);

@DllImport("GDI32.dll")
BOOL RemoveFontResourceW(const(wchar)* lpFileName);

@DllImport("GDI32.dll")
BOOL RoundRect(HDC hdc, int left, int top, int right, int bottom, int width, int height);

@DllImport("GDI32.dll")
BOOL ResizePalette(HPALETTE hpal, uint n);

@DllImport("GDI32.dll")
int SaveDC(HDC hdc);

@DllImport("GDI32.dll")
int SelectClipRgn(HDC hdc, HRGN hrgn);

@DllImport("GDI32.dll")
int ExtSelectClipRgn(HDC hdc, HRGN hrgn, int mode);

@DllImport("GDI32.dll")
int SetMetaRgn(HDC hdc);

@DllImport("GDI32.dll")
int SelectObject(HDC hdc, int h);

@DllImport("GDI32.dll")
HPALETTE SelectPalette(HDC hdc, HPALETTE hPal, BOOL bForceBkgd);

@DllImport("GDI32.dll")
uint SetBkColor(HDC hdc, uint color);

@DllImport("GDI32.dll")
uint SetDCBrushColor(HDC hdc, uint color);

@DllImport("GDI32.dll")
uint SetDCPenColor(HDC hdc, uint color);

@DllImport("GDI32.dll")
int SetBkMode(HDC hdc, int mode);

@DllImport("GDI32.dll")
int SetBitmapBits(HBITMAP hbm, uint cb, char* pvBits);

@DllImport("GDI32.dll")
uint SetBoundsRect(HDC hdc, const(RECT)* lprect, uint flags);

@DllImport("GDI32.dll")
int SetDIBits(HDC hdc, HBITMAP hbm, uint start, uint cLines, const(void)* lpBits, const(BITMAPINFO)* lpbmi, uint ColorUse);

@DllImport("GDI32.dll")
int SetDIBitsToDevice(HDC hdc, int xDest, int yDest, uint w, uint h, int xSrc, int ySrc, uint StartScan, uint cLines, const(void)* lpvBits, const(BITMAPINFO)* lpbmi, uint ColorUse);

@DllImport("GDI32.dll")
uint SetMapperFlags(HDC hdc, uint flags);

@DllImport("GDI32.dll")
int SetGraphicsMode(HDC hdc, int iMode);

@DllImport("GDI32.dll")
int SetMapMode(HDC hdc, int iMode);

@DllImport("GDI32.dll")
uint SetLayout(HDC hdc, uint l);

@DllImport("GDI32.dll")
uint GetLayout(HDC hdc);

@DllImport("GDI32.dll")
int SetMetaFileBitsEx(uint cbBuffer, char* lpData);

@DllImport("GDI32.dll")
uint SetPaletteEntries(HPALETTE hpal, uint iStart, uint cEntries, char* pPalEntries);

@DllImport("GDI32.dll")
uint SetPixel(HDC hdc, int x, int y, uint color);

@DllImport("GDI32.dll")
BOOL SetPixelV(HDC hdc, int x, int y, uint color);

@DllImport("GDI32.dll")
int SetPolyFillMode(HDC hdc, int mode);

@DllImport("GDI32.dll")
BOOL StretchBlt(HDC hdcDest, int xDest, int yDest, int wDest, int hDest, HDC hdcSrc, int xSrc, int ySrc, int wSrc, int hSrc, uint rop);

@DllImport("GDI32.dll")
BOOL SetRectRgn(HRGN hrgn, int left, int top, int right, int bottom);

@DllImport("GDI32.dll")
int StretchDIBits(HDC hdc, int xDest, int yDest, int DestWidth, int DestHeight, int xSrc, int ySrc, int SrcWidth, int SrcHeight, const(void)* lpBits, const(BITMAPINFO)* lpbmi, uint iUsage, uint rop);

@DllImport("GDI32.dll")
int SetROP2(HDC hdc, int rop2);

@DllImport("GDI32.dll")
int SetStretchBltMode(HDC hdc, int mode);

@DllImport("GDI32.dll")
uint SetSystemPaletteUse(HDC hdc, uint use);

@DllImport("GDI32.dll")
int SetTextCharacterExtra(HDC hdc, int extra);

@DllImport("GDI32.dll")
uint SetTextColor(HDC hdc, uint color);

@DllImport("GDI32.dll")
uint SetTextAlign(HDC hdc, uint align);

@DllImport("GDI32.dll")
BOOL SetTextJustification(HDC hdc, int extra, int count);

@DllImport("GDI32.dll")
BOOL UpdateColors(HDC hdc);

@DllImport("MSIMG32.dll")
BOOL AlphaBlend(HDC hdcDest, int xoriginDest, int yoriginDest, int wDest, int hDest, HDC hdcSrc, int xoriginSrc, int yoriginSrc, int wSrc, int hSrc, BLENDFUNCTION ftn);

@DllImport("MSIMG32.dll")
BOOL TransparentBlt(HDC hdcDest, int xoriginDest, int yoriginDest, int wDest, int hDest, HDC hdcSrc, int xoriginSrc, int yoriginSrc, int wSrc, int hSrc, uint crTransparent);

@DllImport("MSIMG32.dll")
BOOL GradientFill(HDC hdc, char* pVertex, uint nVertex, void* pMesh, uint nMesh, uint ulMode);

@DllImport("GDI32.dll")
BOOL GdiAlphaBlend(HDC hdcDest, int xoriginDest, int yoriginDest, int wDest, int hDest, HDC hdcSrc, int xoriginSrc, int yoriginSrc, int wSrc, int hSrc, BLENDFUNCTION ftn);

@DllImport("GDI32.dll")
BOOL GdiTransparentBlt(HDC hdcDest, int xoriginDest, int yoriginDest, int wDest, int hDest, HDC hdcSrc, int xoriginSrc, int yoriginSrc, int wSrc, int hSrc, uint crTransparent);

@DllImport("GDI32.dll")
BOOL GdiGradientFill(HDC hdc, char* pVertex, uint nVertex, void* pMesh, uint nCount, uint ulMode);

@DllImport("GDI32.dll")
BOOL PlayMetaFileRecord(HDC hdc, char* lpHandleTable, METARECORD* lpMR, uint noObjs);

@DllImport("GDI32.dll")
BOOL EnumMetaFile(HDC hdc, int hmf, MFENUMPROC proc, LPARAM param3);

@DllImport("GDI32.dll")
int CloseEnhMetaFile(HDC hdc);

@DllImport("GDI32.dll")
int CopyEnhMetaFileA(int hEnh, const(char)* lpFileName);

@DllImport("GDI32.dll")
int CopyEnhMetaFileW(int hEnh, const(wchar)* lpFileName);

@DllImport("GDI32.dll")
HdcMetdataEnhFileHandle CreateEnhMetaFileA(HDC hdc, const(char)* lpFilename, const(RECT)* lprc, const(char)* lpDesc);

@DllImport("GDI32.dll")
HdcMetdataEnhFileHandle CreateEnhMetaFileW(HDC hdc, const(wchar)* lpFilename, const(RECT)* lprc, const(wchar)* lpDesc);

@DllImport("GDI32.dll")
BOOL DeleteEnhMetaFile(int hmf);

@DllImport("GDI32.dll")
BOOL EnumEnhMetaFile(HDC hdc, int hmf, ENHMFENUMPROC proc, void* param3, const(RECT)* lpRect);

@DllImport("GDI32.dll")
int GetEnhMetaFileA(const(char)* lpName);

@DllImport("GDI32.dll")
int GetEnhMetaFileW(const(wchar)* lpName);

@DllImport("GDI32.dll")
uint GetEnhMetaFileBits(int hEMF, uint nSize, char* lpData);

@DllImport("GDI32.dll")
uint GetEnhMetaFileDescriptionA(int hemf, uint cchBuffer, const(char)* lpDescription);

@DllImport("GDI32.dll")
uint GetEnhMetaFileDescriptionW(int hemf, uint cchBuffer, const(wchar)* lpDescription);

@DllImport("GDI32.dll")
uint GetEnhMetaFileHeader(int hemf, uint nSize, char* lpEnhMetaHeader);

@DllImport("GDI32.dll")
uint GetEnhMetaFilePaletteEntries(int hemf, uint nNumEntries, char* lpPaletteEntries);

@DllImport("GDI32.dll")
uint GetWinMetaFileBits(int hemf, uint cbData16, char* pData16, int iMapMode, HDC hdcRef);

@DllImport("GDI32.dll")
BOOL PlayEnhMetaFile(HDC hdc, int hmf, const(RECT)* lprect);

@DllImport("GDI32.dll")
BOOL PlayEnhMetaFileRecord(HDC hdc, char* pht, const(ENHMETARECORD)* pmr, uint cht);

@DllImport("GDI32.dll")
int SetEnhMetaFileBits(uint nSize, char* pb);

@DllImport("GDI32.dll")
int SetWinMetaFileBits(uint nSize, char* lpMeta16Data, HDC hdcRef, const(METAFILEPICT)* lpMFP);

@DllImport("GDI32.dll")
BOOL GdiComment(HDC hdc, uint nSize, char* lpData);

@DllImport("GDI32.dll")
BOOL GetTextMetricsA(HDC hdc, TEXTMETRICA* lptm);

@DllImport("GDI32.dll")
BOOL GetTextMetricsW(HDC hdc, TEXTMETRICW* lptm);

@DllImport("GDI32.dll")
BOOL AngleArc(HDC hdc, int x, int y, uint r, float StartAngle, float SweepAngle);

@DllImport("GDI32.dll")
BOOL PolyPolyline(HDC hdc, const(POINT)* apt, char* asz, uint csz);

@DllImport("GDI32.dll")
BOOL GetWorldTransform(HDC hdc, XFORM* lpxf);

@DllImport("GDI32.dll")
BOOL SetWorldTransform(HDC hdc, const(XFORM)* lpxf);

@DllImport("GDI32.dll")
BOOL ModifyWorldTransform(HDC hdc, const(XFORM)* lpxf, uint mode);

@DllImport("GDI32.dll")
BOOL CombineTransform(XFORM* lpxfOut, const(XFORM)* lpxf1, const(XFORM)* lpxf2);

@DllImport("GDI32.dll")
HBITMAP CreateDIBSection(HDC hdc, const(BITMAPINFO)* pbmi, uint usage, void** ppvBits, HANDLE hSection, uint offset);

@DllImport("GDI32.dll")
uint GetDIBColorTable(HDC hdc, uint iStart, uint cEntries, char* prgbq);

@DllImport("GDI32.dll")
uint SetDIBColorTable(HDC hdc, uint iStart, uint cEntries, char* prgbq);

@DllImport("GDI32.dll")
BOOL SetColorAdjustment(HDC hdc, const(COLORADJUSTMENT)* lpca);

@DllImport("GDI32.dll")
BOOL GetColorAdjustment(HDC hdc, COLORADJUSTMENT* lpca);

@DllImport("GDI32.dll")
HPALETTE CreateHalftonePalette(HDC hdc);

@DllImport("GDI32.dll")
BOOL AbortPath(HDC hdc);

@DllImport("GDI32.dll")
BOOL ArcTo(HDC hdc, int left, int top, int right, int bottom, int xr1, int yr1, int xr2, int yr2);

@DllImport("GDI32.dll")
BOOL BeginPath(HDC hdc);

@DllImport("GDI32.dll")
BOOL CloseFigure(HDC hdc);

@DllImport("GDI32.dll")
BOOL EndPath(HDC hdc);

@DllImport("GDI32.dll")
BOOL FillPath(HDC hdc);

@DllImport("GDI32.dll")
BOOL FlattenPath(HDC hdc);

@DllImport("GDI32.dll")
int GetPath(HDC hdc, char* apt, char* aj, int cpt);

@DllImport("GDI32.dll")
HRGN PathToRegion(HDC hdc);

@DllImport("GDI32.dll")
BOOL PolyDraw(HDC hdc, char* apt, char* aj, int cpt);

@DllImport("GDI32.dll")
BOOL SelectClipPath(HDC hdc, int mode);

@DllImport("GDI32.dll")
int SetArcDirection(HDC hdc, int dir);

@DllImport("GDI32.dll")
BOOL SetMiterLimit(HDC hdc, float limit, float* old);

@DllImport("GDI32.dll")
BOOL StrokeAndFillPath(HDC hdc);

@DllImport("GDI32.dll")
BOOL StrokePath(HDC hdc);

@DllImport("GDI32.dll")
BOOL WidenPath(HDC hdc);

@DllImport("GDI32.dll")
HPEN ExtCreatePen(uint iPenStyle, uint cWidth, const(LOGBRUSH)* plbrush, uint cStyle, char* pstyle);

@DllImport("GDI32.dll")
BOOL GetMiterLimit(HDC hdc, float* plimit);

@DllImport("GDI32.dll")
int GetArcDirection(HDC hdc);

@DllImport("GDI32.dll")
int GetObjectA(HANDLE h, int c, char* pv);

@DllImport("GDI32.dll")
int GetObjectW(HANDLE h, int c, char* pv);

@DllImport("GDI32.dll")
BOOL MoveToEx(HDC hdc, int x, int y, POINT* lppt);

@DllImport("GDI32.dll")
BOOL TextOutA(HDC hdc, int x, int y, const(char)* lpString, int c);

@DllImport("GDI32.dll")
BOOL TextOutW(HDC hdc, int x, int y, const(wchar)* lpString, int c);

@DllImport("GDI32.dll")
BOOL ExtTextOutA(HDC hdc, int x, int y, uint options, const(RECT)* lprect, const(char)* lpString, uint c, char* lpDx);

@DllImport("GDI32.dll")
BOOL ExtTextOutW(HDC hdc, int x, int y, uint options, const(RECT)* lprect, const(wchar)* lpString, uint c, char* lpDx);

@DllImport("GDI32.dll")
BOOL PolyTextOutA(HDC hdc, char* ppt, int nstrings);

@DllImport("GDI32.dll")
BOOL PolyTextOutW(HDC hdc, char* ppt, int nstrings);

@DllImport("GDI32.dll")
HRGN CreatePolygonRgn(char* pptl, int cPoint, int iMode);

@DllImport("GDI32.dll")
BOOL DPtoLP(HDC hdc, char* lppt, int c);

@DllImport("GDI32.dll")
BOOL LPtoDP(HDC hdc, char* lppt, int c);

@DllImport("GDI32.dll")
BOOL Polygon(HDC hdc, char* apt, int cpt);

@DllImport("GDI32.dll")
BOOL Polyline(HDC hdc, char* apt, int cpt);

@DllImport("GDI32.dll")
BOOL PolyBezier(HDC hdc, char* apt, uint cpt);

@DllImport("GDI32.dll")
BOOL PolyBezierTo(HDC hdc, char* apt, uint cpt);

@DllImport("GDI32.dll")
BOOL PolylineTo(HDC hdc, char* apt, uint cpt);

@DllImport("GDI32.dll")
BOOL SetViewportExtEx(HDC hdc, int x, int y, SIZE* lpsz);

@DllImport("GDI32.dll")
BOOL SetViewportOrgEx(HDC hdc, int x, int y, POINT* lppt);

@DllImport("GDI32.dll")
BOOL SetWindowExtEx(HDC hdc, int x, int y, SIZE* lpsz);

@DllImport("GDI32.dll")
BOOL SetWindowOrgEx(HDC hdc, int x, int y, POINT* lppt);

@DllImport("GDI32.dll")
BOOL OffsetViewportOrgEx(HDC hdc, int x, int y, POINT* lppt);

@DllImport("GDI32.dll")
BOOL OffsetWindowOrgEx(HDC hdc, int x, int y, POINT* lppt);

@DllImport("GDI32.dll")
BOOL ScaleViewportExtEx(HDC hdc, int xn, int dx, int yn, int yd, SIZE* lpsz);

@DllImport("GDI32.dll")
BOOL ScaleWindowExtEx(HDC hdc, int xn, int xd, int yn, int yd, SIZE* lpsz);

@DllImport("GDI32.dll")
BOOL SetBitmapDimensionEx(HBITMAP hbm, int w, int h, SIZE* lpsz);

@DllImport("GDI32.dll")
BOOL SetBrushOrgEx(HDC hdc, int x, int y, POINT* lppt);

@DllImport("GDI32.dll")
int GetTextFaceA(HDC hdc, int c, const(char)* lpName);

@DllImport("GDI32.dll")
int GetTextFaceW(HDC hdc, int c, const(wchar)* lpName);

@DllImport("GDI32.dll")
uint GetKerningPairsA(HDC hdc, uint nPairs, char* lpKernPair);

@DllImport("GDI32.dll")
uint GetKerningPairsW(HDC hdc, uint nPairs, char* lpKernPair);

@DllImport("GDI32.dll")
BOOL GetDCOrgEx(HDC hdc, POINT* lppt);

@DllImport("GDI32.dll")
BOOL FixBrushOrgEx(HDC hdc, int x, int y, POINT* ptl);

@DllImport("GDI32.dll")
BOOL UnrealizeObject(int h);

@DllImport("GDI32.dll")
BOOL GdiFlush();

@DllImport("GDI32.dll")
uint GdiSetBatchLimit(uint dw);

@DllImport("GDI32.dll")
uint GdiGetBatchLimit();

@DllImport("OPENGL32.dll")
uint wglSwapMultipleBuffers(uint param0, const(WGLSWAP)* param1);

@DllImport("FONTSUB.dll")
uint CreateFontPackage(const(ubyte)* puchSrcBuffer, const(uint) ulSrcBufferSize, ubyte** ppuchFontPackageBuffer, uint* pulFontPackageBufferSize, uint* pulBytesWritten, const(ushort) usFlag, const(ushort) usTTCIndex, const(ushort) usSubsetFormat, const(ushort) usSubsetLanguage, const(ushort) usSubsetPlatform, const(ushort) usSubsetEncoding, const(ushort)* pusSubsetKeepList, const(ushort) usSubsetListCount, CFP_ALLOCPROC lpfnAllocate, CFP_REALLOCPROC lpfnReAllocate, CFP_FREEPROC lpfnFree, void* lpvReserved);

@DllImport("FONTSUB.dll")
uint MergeFontPackage(const(ubyte)* puchMergeFontBuffer, const(uint) ulMergeFontBufferSize, const(ubyte)* puchFontPackageBuffer, const(uint) ulFontPackageBufferSize, ubyte** ppuchDestBuffer, uint* pulDestBufferSize, uint* pulBytesWritten, const(ushort) usMode, CFP_ALLOCPROC lpfnAllocate, CFP_REALLOCPROC lpfnReAllocate, CFP_FREEPROC lpfnFree, void* lpvReserved);

@DllImport("t2embed.dll")
int TTEmbedFont(HDC hDC, uint ulFlags, uint ulCharSet, uint* pulPrivStatus, uint* pulStatus, WRITEEMBEDPROC lpfnWriteToStream, void* lpvWriteStream, char* pusCharCodeSet, ushort usCharCodeCount, ushort usLanguage, TTEMBEDINFO* pTTEmbedInfo);

@DllImport("t2embed.dll")
int TTEmbedFontFromFileA(HDC hDC, const(char)* szFontFileName, ushort usTTCIndex, uint ulFlags, uint ulCharSet, uint* pulPrivStatus, uint* pulStatus, WRITEEMBEDPROC lpfnWriteToStream, void* lpvWriteStream, char* pusCharCodeSet, ushort usCharCodeCount, ushort usLanguage, TTEMBEDINFO* pTTEmbedInfo);

@DllImport("t2embed.dll")
int TTLoadEmbeddedFont(HANDLE* phFontReference, uint ulFlags, uint* pulPrivStatus, uint ulPrivs, uint* pulStatus, READEMBEDPROC lpfnReadFromStream, void* lpvReadStream, const(wchar)* szWinFamilyName, const(char)* szMacFamilyName, TTLOADINFO* pTTLoadInfo);

@DllImport("t2embed.dll")
int TTGetEmbeddedFontInfo(uint ulFlags, uint* pulPrivStatus, uint ulPrivs, uint* pulStatus, READEMBEDPROC lpfnReadFromStream, void* lpvReadStream, TTLOADINFO* pTTLoadInfo);

@DllImport("t2embed.dll")
int TTDeleteEmbeddedFont(HANDLE hFontReference, uint ulFlags, uint* pulStatus);

@DllImport("t2embed.dll")
int TTGetEmbeddingType(HDC hDC, uint* pulEmbedType);

@DllImport("t2embed.dll")
int TTCharToUnicode(HDC hDC, char* pucCharCodes, uint ulCharCodeSize, char* pusShortCodes, uint ulShortCodeSize, uint ulFlags);

@DllImport("t2embed.dll")
int TTRunValidationTests(HDC hDC, TTVALIDATIONTESTSPARAMS* pTestParam);

@DllImport("t2embed.dll")
int TTIsEmbeddingEnabled(HDC hDC, int* pbEnabled);

@DllImport("t2embed.dll")
int TTIsEmbeddingEnabledForFacename(const(char)* lpszFacename, int* pbEnabled);

@DllImport("t2embed.dll")
int TTEnableEmbeddingForFacename(const(char)* lpszFacename, BOOL bEnable);

@DllImport("t2embed.dll")
int TTEmbedFontEx(HDC hDC, uint ulFlags, uint ulCharSet, uint* pulPrivStatus, uint* pulStatus, WRITEEMBEDPROC lpfnWriteToStream, void* lpvWriteStream, char* pulCharCodeSet, ushort usCharCodeCount, ushort usLanguage, TTEMBEDINFO* pTTEmbedInfo);

@DllImport("t2embed.dll")
int TTRunValidationTestsEx(HDC hDC, TTVALIDATIONTESTSPARAMSEX* pTestParam);

@DllImport("t2embed.dll")
int TTGetNewFontName(HANDLE* phFontReference, const(wchar)* wzWinFamilyName, int cchMaxWinName, const(char)* szMacFamilyName, int cchMaxMacName);

@DllImport("USER32.dll")
BOOL DrawEdge(HDC hdc, RECT* qrc, uint edge, uint grfFlags);

@DllImport("USER32.dll")
BOOL DrawFrameControl(HDC param0, RECT* param1, uint param2, uint param3);

@DllImport("USER32.dll")
BOOL DrawCaption(HWND hwnd, HDC hdc, const(RECT)* lprect, uint flags);

@DllImport("USER32.dll")
BOOL DrawAnimatedRects(HWND hwnd, int idAni, const(RECT)* lprcFrom, const(RECT)* lprcTo);

@DllImport("USER32.dll")
int DrawTextA(HDC hdc, const(char)* lpchText, int cchText, RECT* lprc, uint format);

@DllImport("USER32.dll")
int DrawTextW(HDC hdc, const(wchar)* lpchText, int cchText, RECT* lprc, uint format);

@DllImport("USER32.dll")
int DrawTextExA(HDC hdc, const(char)* lpchText, int cchText, RECT* lprc, uint format, DRAWTEXTPARAMS* lpdtp);

@DllImport("USER32.dll")
int DrawTextExW(HDC hdc, const(wchar)* lpchText, int cchText, RECT* lprc, uint format, DRAWTEXTPARAMS* lpdtp);

@DllImport("USER32.dll")
BOOL GrayStringA(HDC hDC, HBRUSH hBrush, GRAYSTRINGPROC lpOutputFunc, LPARAM lpData, int nCount, int X, int Y, int nWidth, int nHeight);

@DllImport("USER32.dll")
BOOL GrayStringW(HDC hDC, HBRUSH hBrush, GRAYSTRINGPROC lpOutputFunc, LPARAM lpData, int nCount, int X, int Y, int nWidth, int nHeight);

@DllImport("USER32.dll")
BOOL DrawStateA(HDC hdc, HBRUSH hbrFore, DRAWSTATEPROC qfnCallBack, LPARAM lData, WPARAM wData, int x, int y, int cx, int cy, uint uFlags);

@DllImport("USER32.dll")
BOOL DrawStateW(HDC hdc, HBRUSH hbrFore, DRAWSTATEPROC qfnCallBack, LPARAM lData, WPARAM wData, int x, int y, int cx, int cy, uint uFlags);

@DllImport("USER32.dll")
int TabbedTextOutA(HDC hdc, int x, int y, const(char)* lpString, int chCount, int nTabPositions, char* lpnTabStopPositions, int nTabOrigin);

@DllImport("USER32.dll")
int TabbedTextOutW(HDC hdc, int x, int y, const(wchar)* lpString, int chCount, int nTabPositions, char* lpnTabStopPositions, int nTabOrigin);

@DllImport("USER32.dll")
uint GetTabbedTextExtentA(HDC hdc, const(char)* lpString, int chCount, int nTabPositions, char* lpnTabStopPositions);

@DllImport("USER32.dll")
uint GetTabbedTextExtentW(HDC hdc, const(wchar)* lpString, int chCount, int nTabPositions, char* lpnTabStopPositions);

@DllImport("USER32.dll")
BOOL UpdateWindow(HWND hWnd);

@DllImport("USER32.dll")
BOOL PaintDesktop(HDC hdc);

@DllImport("USER32.dll")
HWND WindowFromDC(HDC hDC);

@DllImport("USER32.dll")
HDC GetDC(HWND hWnd);

@DllImport("USER32.dll")
HDC GetDCEx(HWND hWnd, HRGN hrgnClip, uint flags);

@DllImport("USER32.dll")
HDC GetWindowDC(HWND hWnd);

@DllImport("USER32.dll")
int ReleaseDC(HWND hWnd, HDC hDC);

@DllImport("USER32.dll")
HDC BeginPaint(HWND hWnd, PAINTSTRUCT* lpPaint);

@DllImport("USER32.dll")
BOOL EndPaint(HWND hWnd, const(PAINTSTRUCT)* lpPaint);

@DllImport("USER32.dll")
BOOL GetUpdateRect(HWND hWnd, RECT* lpRect, BOOL bErase);

@DllImport("USER32.dll")
int GetUpdateRgn(HWND hWnd, HRGN hRgn, BOOL bErase);

@DllImport("USER32.dll")
int SetWindowRgn(HWND hWnd, HRGN hRgn, BOOL bRedraw);

@DllImport("USER32.dll")
int GetWindowRgn(HWND hWnd, HRGN hRgn);

@DllImport("USER32.dll")
int GetWindowRgnBox(HWND hWnd, RECT* lprc);

@DllImport("USER32.dll")
int ExcludeUpdateRgn(HDC hDC, HWND hWnd);

@DllImport("USER32.dll")
BOOL InvalidateRect(HWND hWnd, const(RECT)* lpRect, BOOL bErase);

@DllImport("USER32.dll")
BOOL ValidateRect(HWND hWnd, const(RECT)* lpRect);

@DllImport("USER32.dll")
BOOL InvalidateRgn(HWND hWnd, HRGN hRgn, BOOL bErase);

@DllImport("USER32.dll")
BOOL ValidateRgn(HWND hWnd, HRGN hRgn);

@DllImport("USER32.dll")
BOOL RedrawWindow(HWND hWnd, const(RECT)* lprcUpdate, HRGN hrgnUpdate, uint flags);

@DllImport("USER32.dll")
BOOL LockWindowUpdate(HWND hWndLock);

@DllImport("USER32.dll")
BOOL ClientToScreen(HWND hWnd, POINT* lpPoint);

@DllImport("USER32.dll")
BOOL ScreenToClient(HWND hWnd, POINT* lpPoint);

@DllImport("USER32.dll")
int MapWindowPoints(HWND hWndFrom, HWND hWndTo, char* lpPoints, uint cPoints);

@DllImport("USER32.dll")
HBRUSH GetSysColorBrush(int nIndex);

@DllImport("USER32.dll")
BOOL DrawFocusRect(HDC hDC, const(RECT)* lprc);

@DllImport("USER32.dll")
int FillRect(HDC hDC, const(RECT)* lprc, HBRUSH hbr);

@DllImport("USER32.dll")
int FrameRect(HDC hDC, const(RECT)* lprc, HBRUSH hbr);

@DllImport("USER32.dll")
BOOL InvertRect(HDC hDC, const(RECT)* lprc);

@DllImport("USER32.dll")
BOOL SetRect(RECT* lprc, int xLeft, int yTop, int xRight, int yBottom);

@DllImport("USER32.dll")
BOOL SetRectEmpty(RECT* lprc);

@DllImport("USER32.dll")
BOOL CopyRect(RECT* lprcDst, const(RECT)* lprcSrc);

@DllImport("USER32.dll")
BOOL InflateRect(RECT* lprc, int dx, int dy);

@DllImport("USER32.dll")
BOOL IntersectRect(RECT* lprcDst, const(RECT)* lprcSrc1, const(RECT)* lprcSrc2);

@DllImport("USER32.dll")
BOOL UnionRect(RECT* lprcDst, const(RECT)* lprcSrc1, const(RECT)* lprcSrc2);

@DllImport("USER32.dll")
BOOL SubtractRect(RECT* lprcDst, const(RECT)* lprcSrc1, const(RECT)* lprcSrc2);

@DllImport("USER32.dll")
BOOL OffsetRect(RECT* lprc, int dx, int dy);

@DllImport("USER32.dll")
BOOL IsRectEmpty(const(RECT)* lprc);

@DllImport("USER32.dll")
BOOL EqualRect(const(RECT)* lprc1, const(RECT)* lprc2);

@DllImport("USER32.dll")
BOOL PtInRect(const(RECT)* lprc, POINT pt);

@DllImport("USER32.dll")
HBITMAP LoadBitmapA(HINSTANCE hInstance, const(char)* lpBitmapName);

@DllImport("USER32.dll")
HBITMAP LoadBitmapW(HINSTANCE hInstance, const(wchar)* lpBitmapName);

@DllImport("USER32.dll")
int ChangeDisplaySettingsA(DEVMODEA* lpDevMode, uint dwFlags);

@DllImport("USER32.dll")
int ChangeDisplaySettingsW(DEVMODEW* lpDevMode, uint dwFlags);

@DllImport("USER32.dll")
int ChangeDisplaySettingsExA(const(char)* lpszDeviceName, DEVMODEA* lpDevMode, HWND hwnd, uint dwflags, void* lParam);

@DllImport("USER32.dll")
int ChangeDisplaySettingsExW(const(wchar)* lpszDeviceName, DEVMODEW* lpDevMode, HWND hwnd, uint dwflags, void* lParam);

@DllImport("USER32.dll")
BOOL EnumDisplaySettingsA(const(char)* lpszDeviceName, uint iModeNum, DEVMODEA* lpDevMode);

@DllImport("USER32.dll")
BOOL EnumDisplaySettingsW(const(wchar)* lpszDeviceName, uint iModeNum, DEVMODEW* lpDevMode);

@DllImport("USER32.dll")
BOOL EnumDisplaySettingsExA(const(char)* lpszDeviceName, uint iModeNum, DEVMODEA* lpDevMode, uint dwFlags);

@DllImport("USER32.dll")
BOOL EnumDisplaySettingsExW(const(wchar)* lpszDeviceName, uint iModeNum, DEVMODEW* lpDevMode, uint dwFlags);

@DllImport("USER32.dll")
BOOL EnumDisplayDevicesA(const(char)* lpDevice, uint iDevNum, DISPLAY_DEVICEA* lpDisplayDevice, uint dwFlags);

@DllImport("USER32.dll")
BOOL EnumDisplayDevicesW(const(wchar)* lpDevice, uint iDevNum, DISPLAY_DEVICEW* lpDisplayDevice, uint dwFlags);

@DllImport("USER32.dll")
int MonitorFromPoint(POINT pt, uint dwFlags);

@DllImport("USER32.dll")
int MonitorFromRect(RECT* lprc, uint dwFlags);

@DllImport("USER32.dll")
int MonitorFromWindow(HWND hwnd, uint dwFlags);

@DllImport("USER32.dll")
BOOL GetMonitorInfoA(int hMonitor, MONITORINFO* lpmi);

@DllImport("USER32.dll")
BOOL GetMonitorInfoW(int hMonitor, MONITORINFO* lpmi);

@DllImport("USER32.dll")
BOOL EnumDisplayMonitors(HDC hdc, RECT* lprcClip, MONITORENUMPROC lpfnEnum, LPARAM dwData);

alias HBITMAP = int;
alias HBRUSH = int;
alias HCOLORSPACE = int;
alias HCURSOR = int;
alias HDC = int;
alias HdcMetdataEnhFileHandle = int;
alias HdcMetdataFileHandle = int;
alias HFONT = int;
alias HICON = int;
alias HPALETTE = int;
alias HPEN = int;
alias HRGN = int;
alias GRAYSTRINGPROC = extern(Windows) BOOL function(HDC param0, LPARAM param1, int param2);
alias DRAWSTATEPROC = extern(Windows) BOOL function(HDC hdc, LPARAM lData, WPARAM wData, int cx, int cy);
struct PAINTSTRUCT
{
    HDC hdc;
    BOOL fErase;
    RECT rcPaint;
    BOOL fRestore;
    BOOL fIncUpdate;
    ubyte rgbReserved;
}

struct DRAWTEXTPARAMS
{
    uint cbSize;
    int iTabLength;
    int iLeftMargin;
    int iRightMargin;
    uint uiLengthDrawn;
}

struct MONITORINFO
{
    uint cbSize;
    RECT rcMonitor;
    RECT rcWork;
    uint dwFlags;
}

struct MONITORINFOEXA
{
    MONITORINFO __AnonymousBase_winuser_L13554_C43;
    byte szDevice;
}

struct MONITORINFOEXW
{
    MONITORINFO __AnonymousBase_winuser_L13558_C43;
    ushort szDevice;
}

alias MONITORENUMPROC = extern(Windows) BOOL function(int param0, HDC param1, RECT* param2, LPARAM param3);
