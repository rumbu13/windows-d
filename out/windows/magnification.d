module windows.magnification;

public import windows.core;
public import windows.displaydevices : RECT;
public import windows.gdi : HRGN;
public import windows.systemservices : BOOL;
public import windows.windowsandmessaging : HWND;

extern(Windows):


// Callbacks

alias MagImageScalingCallback = BOOL function(HWND hwnd, void* srcdata, MAGIMAGEHEADER srcheader, void* destdata, 
                                              MAGIMAGEHEADER destheader, RECT unclipped, RECT clipped, HRGN dirty);

// Structs


struct MAGTRANSFORM
{
    float[9] v;
}

struct MAGIMAGEHEADER
{
    uint   width;
    uint   height;
    GUID   format;
    uint   stride;
    uint   offset;
    size_t cbSize;
}

struct MAGCOLOREFFECT
{
    float[25] transform;
}

// Functions

@DllImport("MAGNIFICATION")
BOOL MagInitialize();

@DllImport("MAGNIFICATION")
BOOL MagUninitialize();

@DllImport("MAGNIFICATION")
BOOL MagSetWindowSource(HWND hwnd, RECT rect);

@DllImport("MAGNIFICATION")
BOOL MagGetWindowSource(HWND hwnd, RECT* pRect);

@DllImport("MAGNIFICATION")
BOOL MagSetWindowTransform(HWND hwnd, MAGTRANSFORM* pTransform);

@DllImport("MAGNIFICATION")
BOOL MagGetWindowTransform(HWND hwnd, MAGTRANSFORM* pTransform);

@DllImport("MAGNIFICATION")
BOOL MagSetWindowFilterList(HWND hwnd, uint dwFilterMode, int count, HWND* pHWND);

@DllImport("MAGNIFICATION")
int MagGetWindowFilterList(HWND hwnd, uint* pdwFilterMode, int count, HWND* pHWND);

@DllImport("MAGNIFICATION")
BOOL MagSetImageScalingCallback(HWND hwnd, MagImageScalingCallback callback);

@DllImport("MAGNIFICATION")
MagImageScalingCallback MagGetImageScalingCallback(HWND hwnd);

@DllImport("MAGNIFICATION")
BOOL MagSetColorEffect(HWND hwnd, MAGCOLOREFFECT* pEffect);

@DllImport("MAGNIFICATION")
BOOL MagGetColorEffect(HWND hwnd, MAGCOLOREFFECT* pEffect);

@DllImport("MAGNIFICATION")
BOOL MagSetFullscreenTransform(float magLevel, int xOffset, int yOffset);

@DllImport("MAGNIFICATION")
BOOL MagGetFullscreenTransform(float* pMagLevel, int* pxOffset, int* pyOffset);

@DllImport("MAGNIFICATION")
BOOL MagSetFullscreenColorEffect(MAGCOLOREFFECT* pEffect);

@DllImport("MAGNIFICATION")
BOOL MagGetFullscreenColorEffect(MAGCOLOREFFECT* pEffect);

@DllImport("MAGNIFICATION")
BOOL MagSetInputTransform(BOOL fEnabled, const(RECT)* pRectSource, const(RECT)* pRectDest);

@DllImport("MAGNIFICATION")
BOOL MagGetInputTransform(int* pfEnabled, RECT* pRectSource, RECT* pRectDest);

@DllImport("MAGNIFICATION")
BOOL MagShowSystemCursor(BOOL fShowCursor);


