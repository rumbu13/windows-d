module windows.magnification;

public import system;
public import windows.displaydevices;
public import windows.gdi;
public import windows.systemservices;
public import windows.windowsandmessaging;

extern(Windows):

struct MAGTRANSFORM
{
    float v;
}

struct MAGIMAGEHEADER
{
    uint width;
    uint height;
    Guid format;
    uint stride;
    uint offset;
    uint cbSize;
}

struct MAGCOLOREFFECT
{
    float transform;
}

alias MagImageScalingCallback = extern(Windows) BOOL function(HWND hwnd, void* srcdata, MAGIMAGEHEADER srcheader, void* destdata, MAGIMAGEHEADER destheader, RECT unclipped, RECT clipped, HRGN dirty);
@DllImport("MAGNIFICATION.dll")
BOOL MagInitialize();

@DllImport("MAGNIFICATION.dll")
BOOL MagUninitialize();

@DllImport("MAGNIFICATION.dll")
BOOL MagSetWindowSource(HWND hwnd, RECT rect);

@DllImport("MAGNIFICATION.dll")
BOOL MagGetWindowSource(HWND hwnd, RECT* pRect);

@DllImport("MAGNIFICATION.dll")
BOOL MagSetWindowTransform(HWND hwnd, MAGTRANSFORM* pTransform);

@DllImport("MAGNIFICATION.dll")
BOOL MagGetWindowTransform(HWND hwnd, MAGTRANSFORM* pTransform);

@DllImport("MAGNIFICATION.dll")
BOOL MagSetWindowFilterList(HWND hwnd, uint dwFilterMode, int count, HWND* pHWND);

@DllImport("MAGNIFICATION.dll")
int MagGetWindowFilterList(HWND hwnd, uint* pdwFilterMode, int count, HWND* pHWND);

@DllImport("MAGNIFICATION.dll")
BOOL MagSetImageScalingCallback(HWND hwnd, MagImageScalingCallback callback);

@DllImport("MAGNIFICATION.dll")
MagImageScalingCallback MagGetImageScalingCallback(HWND hwnd);

@DllImport("MAGNIFICATION.dll")
BOOL MagSetColorEffect(HWND hwnd, MAGCOLOREFFECT* pEffect);

@DllImport("MAGNIFICATION.dll")
BOOL MagGetColorEffect(HWND hwnd, MAGCOLOREFFECT* pEffect);

@DllImport("MAGNIFICATION.dll")
BOOL MagSetFullscreenTransform(float magLevel, int xOffset, int yOffset);

@DllImport("MAGNIFICATION.dll")
BOOL MagGetFullscreenTransform(float* pMagLevel, int* pxOffset, int* pyOffset);

@DllImport("MAGNIFICATION.dll")
BOOL MagSetFullscreenColorEffect(MAGCOLOREFFECT* pEffect);

@DllImport("MAGNIFICATION.dll")
BOOL MagGetFullscreenColorEffect(MAGCOLOREFFECT* pEffect);

@DllImport("MAGNIFICATION.dll")
BOOL MagSetInputTransform(BOOL fEnabled, const(RECT)* pRectSource, const(RECT)* pRectDest);

@DllImport("MAGNIFICATION.dll")
BOOL MagGetInputTransform(int* pfEnabled, RECT* pRectSource, RECT* pRectDest);

@DllImport("MAGNIFICATION.dll")
BOOL MagShowSystemCursor(BOOL fShowCursor);

