// Written in the D programming language.

module windows.win32.ui.magnification;

public import windows.core;
public import windows.win32.foundation : BOOL, HWND, RECT;
public import windows.win32.graphics.gdi : HRGN;

extern(Windows) @nogc nothrow:


// Enums


alias MW_FILTERMODE = uint;
enum : uint
{
    MW_FILTERMODE_EXCLUDE = 0x00000000U,
    MW_FILTERMODE_INCLUDE = 0x00000001U,
}

// Constants


enum : const(wchar)*
{
    // Native encoding: ansi
    WC_MAGNIFIERA = "Magnifier",
    WC_MAGNIFIERW = "Magnifier",
    WC_MAGNIFIER  = "Magnifier",
}

enum int MS_SHOWMAGNIFIEDCURSOR = 0x00000001;
enum int MS_CLIPAROUNDCURSOR = 0x00000002;
enum int MS_INVERTCOLORS = 0x00000004;

// Callbacks

alias MagImageScalingCallback = BOOL function(HWND hwnd, void* srcdata, MAGIMAGEHEADER srcheader, void* destdata, 
                                              MAGIMAGEHEADER destheader, RECT unclipped, RECT clipped, HRGN dirty);

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/magnification/ns-magnification-magtransform
struct MAGTRANSFORM
{
    float[9] v;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/magnification/ns-magnification-magimageheader
struct MAGIMAGEHEADER
{
    uint   width;
    uint   height;
    GUID   format;
    uint   stride;
    uint   offset;
    size_t cbSize;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/magnification/ns-magnification-magcoloreffect
struct MAGCOLOREFFECT
{
    float[25] transform;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("MAGNIFICATION.dll")
BOOL MagInitialize();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("MAGNIFICATION.dll")
BOOL MagUninitialize();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("MAGNIFICATION.dll")
BOOL MagSetWindowSource(HWND hwnd, RECT rect);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("MAGNIFICATION.dll")
BOOL MagGetWindowSource(HWND hwnd, RECT* pRect);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("MAGNIFICATION.dll")
BOOL MagSetWindowTransform(HWND hwnd, MAGTRANSFORM* pTransform);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("MAGNIFICATION.dll")
BOOL MagGetWindowTransform(HWND hwnd, MAGTRANSFORM* pTransform);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("MAGNIFICATION.dll")
BOOL MagSetWindowFilterList(HWND hwnd, MW_FILTERMODE dwFilterMode, int count, HWND* pHWND);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("MAGNIFICATION.dll")
int MagGetWindowFilterList(HWND hwnd, MW_FILTERMODE* pdwFilterMode, int count, HWND* pHWND);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("MAGNIFICATION.dll")
BOOL MagSetImageScalingCallback(HWND hwnd, MagImageScalingCallback callback);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("MAGNIFICATION.dll")
MagImageScalingCallback MagGetImageScalingCallback(HWND hwnd);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("MAGNIFICATION.dll")
BOOL MagSetColorEffect(HWND hwnd, MAGCOLOREFFECT* pEffect);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("MAGNIFICATION.dll")
BOOL MagGetColorEffect(HWND hwnd, MAGCOLOREFFECT* pEffect);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("MAGNIFICATION.dll")
BOOL MagSetFullscreenTransform(float magLevel, int xOffset, int yOffset);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("MAGNIFICATION.dll")
BOOL MagGetFullscreenTransform(float* pMagLevel, int* pxOffset, int* pyOffset);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("MAGNIFICATION.dll")
BOOL MagSetFullscreenColorEffect(MAGCOLOREFFECT* pEffect);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("MAGNIFICATION.dll")
BOOL MagGetFullscreenColorEffect(MAGCOLOREFFECT* pEffect);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("MAGNIFICATION.dll")
BOOL MagSetInputTransform(BOOL fEnabled, const(RECT)* pRectSource, const(RECT)* pRectDest);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("MAGNIFICATION.dll")
BOOL MagGetInputTransform(BOOL* pfEnabled, RECT* pRectSource, RECT* pRectDest);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("MAGNIFICATION.dll")
BOOL MagShowSystemCursor(BOOL fShowCursor);


