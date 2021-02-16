module windows.directdraw;

public import windows.core;
public import windows.com : HRESULT, IUnknown;
public import windows.direct2d : PALETTEENTRY;
public import windows.directshow : DDCOLORKEY;
public import windows.displaydevices : RECT, SIZE;
public import windows.gdi : HDC, RGNDATA;
public import windows.systemservices : BOOL, HANDLE, LARGE_INTEGER;
public import windows.windowsandmessaging : HWND;

extern(Windows):


// Callbacks

alias LPDDENUMCALLBACKA = BOOL function(GUID* param0, const(char)* param1, const(char)* param2, void* param3);
alias LPDDENUMCALLBACKW = BOOL function(GUID* param0, const(wchar)* param1, const(wchar)* param2, void* param3);
alias LPDDENUMCALLBACKEXA = BOOL function(GUID* param0, const(char)* param1, const(char)* param2, void* param3, 
                                          ptrdiff_t param4);
alias LPDDENUMCALLBACKEXW = BOOL function(GUID* param0, const(wchar)* param1, const(wchar)* param2, void* param3, 
                                          ptrdiff_t param4);
alias LPDIRECTDRAWENUMERATEEXA = HRESULT function(LPDDENUMCALLBACKEXA lpCallback, void* lpContext, uint dwFlags);
alias LPDIRECTDRAWENUMERATEEXW = HRESULT function(LPDDENUMCALLBACKEXW lpCallback, void* lpContext, uint dwFlags);
alias LPDDENUMCALLBACK = BOOL function();
alias LPDDENUMCALLBACKEX = BOOL function();
alias LPDIRECTDRAWENUMERATEEX = HRESULT function();
alias LPDDENUMMODESCALLBACK = HRESULT function(DDSURFACEDESC* param0, void* param1);
alias LPDDENUMMODESCALLBACK2 = HRESULT function(DDSURFACEDESC2* param0, void* param1);
alias LPDDENUMSURFACESCALLBACK = HRESULT function(IDirectDrawSurface param0, DDSURFACEDESC* param1, void* param2);
alias LPDDENUMSURFACESCALLBACK2 = HRESULT function(IDirectDrawSurface4 param0, DDSURFACEDESC2* param1, 
                                                   void* param2);
alias LPDDENUMSURFACESCALLBACK7 = HRESULT function(IDirectDrawSurface7 param0, DDSURFACEDESC2* param1, 
                                                   void* param2);
alias LPCLIPPERCALLBACK = uint function(IDirectDrawClipper lpDDClipper, HWND hWnd, uint code, void* lpContext);

// Structs


struct _DDFXROP
{
}

struct DDARGB
{
    ubyte blue;
    ubyte green;
    ubyte red;
    ubyte alpha;
}

struct DDRGBA
{
    ubyte red;
    ubyte green;
    ubyte blue;
    ubyte alpha;
}

struct DDBLTFX
{
    uint       dwSize;
    uint       dwDDFX;
    uint       dwROP;
    uint       dwDDROP;
    uint       dwRotationAngle;
    uint       dwZBufferOpCode;
    uint       dwZBufferLow;
    uint       dwZBufferHigh;
    uint       dwZBufferBaseDest;
    uint       dwZDestConstBitDepth;
    union
    {
        uint               dwZDestConst;
        IDirectDrawSurface lpDDSZBufferDest;
    }
    uint       dwZSrcConstBitDepth;
    union
    {
        uint               dwZSrcConst;
        IDirectDrawSurface lpDDSZBufferSrc;
    }
    uint       dwAlphaEdgeBlendBitDepth;
    uint       dwAlphaEdgeBlend;
    uint       dwReserved;
    uint       dwAlphaDestConstBitDepth;
    union
    {
        uint               dwAlphaDestConst;
        IDirectDrawSurface lpDDSAlphaDest;
    }
    uint       dwAlphaSrcConstBitDepth;
    union
    {
        uint               dwAlphaSrcConst;
        IDirectDrawSurface lpDDSAlphaSrc;
    }
    union
    {
        uint               dwFillColor;
        uint               dwFillDepth;
        uint               dwFillPixel;
        IDirectDrawSurface lpDDSPattern;
    }
    DDCOLORKEY ddckDestColorkey;
    DDCOLORKEY ddckSrcColorkey;
}

struct DDSCAPS
{
    uint dwCaps;
}

struct DDOSCAPS
{
    uint dwCaps;
}

struct DDSCAPSEX
{
    uint dwCaps2;
    uint dwCaps3;
    union
    {
        uint dwCaps4;
        uint dwVolumeDepth;
    }
}

struct DDSCAPS2
{
    uint dwCaps;
    uint dwCaps2;
    uint dwCaps3;
    union
    {
        uint dwCaps4;
        uint dwVolumeDepth;
    }
}

struct DDCAPS_DX1
{
    uint    dwSize;
    uint    dwCaps;
    uint    dwCaps2;
    uint    dwCKeyCaps;
    uint    dwFXCaps;
    uint    dwFXAlphaCaps;
    uint    dwPalCaps;
    uint    dwSVCaps;
    uint    dwAlphaBltConstBitDepths;
    uint    dwAlphaBltPixelBitDepths;
    uint    dwAlphaBltSurfaceBitDepths;
    uint    dwAlphaOverlayConstBitDepths;
    uint    dwAlphaOverlayPixelBitDepths;
    uint    dwAlphaOverlaySurfaceBitDepths;
    uint    dwZBufferBitDepths;
    uint    dwVidMemTotal;
    uint    dwVidMemFree;
    uint    dwMaxVisibleOverlays;
    uint    dwCurrVisibleOverlays;
    uint    dwNumFourCCCodes;
    uint    dwAlignBoundarySrc;
    uint    dwAlignSizeSrc;
    uint    dwAlignBoundaryDest;
    uint    dwAlignSizeDest;
    uint    dwAlignStrideAlign;
    uint[8] dwRops;
    DDSCAPS ddsCaps;
    uint    dwMinOverlayStretch;
    uint    dwMaxOverlayStretch;
    uint    dwMinLiveVideoStretch;
    uint    dwMaxLiveVideoStretch;
    uint    dwMinHwCodecStretch;
    uint    dwMaxHwCodecStretch;
    uint    dwReserved1;
    uint    dwReserved2;
    uint    dwReserved3;
}

struct DDCAPS_DX3
{
    uint    dwSize;
    uint    dwCaps;
    uint    dwCaps2;
    uint    dwCKeyCaps;
    uint    dwFXCaps;
    uint    dwFXAlphaCaps;
    uint    dwPalCaps;
    uint    dwSVCaps;
    uint    dwAlphaBltConstBitDepths;
    uint    dwAlphaBltPixelBitDepths;
    uint    dwAlphaBltSurfaceBitDepths;
    uint    dwAlphaOverlayConstBitDepths;
    uint    dwAlphaOverlayPixelBitDepths;
    uint    dwAlphaOverlaySurfaceBitDepths;
    uint    dwZBufferBitDepths;
    uint    dwVidMemTotal;
    uint    dwVidMemFree;
    uint    dwMaxVisibleOverlays;
    uint    dwCurrVisibleOverlays;
    uint    dwNumFourCCCodes;
    uint    dwAlignBoundarySrc;
    uint    dwAlignSizeSrc;
    uint    dwAlignBoundaryDest;
    uint    dwAlignSizeDest;
    uint    dwAlignStrideAlign;
    uint[8] dwRops;
    DDSCAPS ddsCaps;
    uint    dwMinOverlayStretch;
    uint    dwMaxOverlayStretch;
    uint    dwMinLiveVideoStretch;
    uint    dwMaxLiveVideoStretch;
    uint    dwMinHwCodecStretch;
    uint    dwMaxHwCodecStretch;
    uint    dwReserved1;
    uint    dwReserved2;
    uint    dwReserved3;
    uint    dwSVBCaps;
    uint    dwSVBCKeyCaps;
    uint    dwSVBFXCaps;
    uint[8] dwSVBRops;
    uint    dwVSBCaps;
    uint    dwVSBCKeyCaps;
    uint    dwVSBFXCaps;
    uint[8] dwVSBRops;
    uint    dwSSBCaps;
    uint    dwSSBCKeyCaps;
    uint    dwSSBFXCaps;
    uint[8] dwSSBRops;
    uint    dwReserved4;
    uint    dwReserved5;
    uint    dwReserved6;
}

struct DDCAPS_DX5
{
    uint    dwSize;
    uint    dwCaps;
    uint    dwCaps2;
    uint    dwCKeyCaps;
    uint    dwFXCaps;
    uint    dwFXAlphaCaps;
    uint    dwPalCaps;
    uint    dwSVCaps;
    uint    dwAlphaBltConstBitDepths;
    uint    dwAlphaBltPixelBitDepths;
    uint    dwAlphaBltSurfaceBitDepths;
    uint    dwAlphaOverlayConstBitDepths;
    uint    dwAlphaOverlayPixelBitDepths;
    uint    dwAlphaOverlaySurfaceBitDepths;
    uint    dwZBufferBitDepths;
    uint    dwVidMemTotal;
    uint    dwVidMemFree;
    uint    dwMaxVisibleOverlays;
    uint    dwCurrVisibleOverlays;
    uint    dwNumFourCCCodes;
    uint    dwAlignBoundarySrc;
    uint    dwAlignSizeSrc;
    uint    dwAlignBoundaryDest;
    uint    dwAlignSizeDest;
    uint    dwAlignStrideAlign;
    uint[8] dwRops;
    DDSCAPS ddsCaps;
    uint    dwMinOverlayStretch;
    uint    dwMaxOverlayStretch;
    uint    dwMinLiveVideoStretch;
    uint    dwMaxLiveVideoStretch;
    uint    dwMinHwCodecStretch;
    uint    dwMaxHwCodecStretch;
    uint    dwReserved1;
    uint    dwReserved2;
    uint    dwReserved3;
    uint    dwSVBCaps;
    uint    dwSVBCKeyCaps;
    uint    dwSVBFXCaps;
    uint[8] dwSVBRops;
    uint    dwVSBCaps;
    uint    dwVSBCKeyCaps;
    uint    dwVSBFXCaps;
    uint[8] dwVSBRops;
    uint    dwSSBCaps;
    uint    dwSSBCKeyCaps;
    uint    dwSSBFXCaps;
    uint[8] dwSSBRops;
    uint    dwMaxVideoPorts;
    uint    dwCurrVideoPorts;
    uint    dwSVBCaps2;
    uint    dwNLVBCaps;
    uint    dwNLVBCaps2;
    uint    dwNLVBCKeyCaps;
    uint    dwNLVBFXCaps;
    uint[8] dwNLVBRops;
}

struct DDCAPS_DX6
{
    uint     dwSize;
    uint     dwCaps;
    uint     dwCaps2;
    uint     dwCKeyCaps;
    uint     dwFXCaps;
    uint     dwFXAlphaCaps;
    uint     dwPalCaps;
    uint     dwSVCaps;
    uint     dwAlphaBltConstBitDepths;
    uint     dwAlphaBltPixelBitDepths;
    uint     dwAlphaBltSurfaceBitDepths;
    uint     dwAlphaOverlayConstBitDepths;
    uint     dwAlphaOverlayPixelBitDepths;
    uint     dwAlphaOverlaySurfaceBitDepths;
    uint     dwZBufferBitDepths;
    uint     dwVidMemTotal;
    uint     dwVidMemFree;
    uint     dwMaxVisibleOverlays;
    uint     dwCurrVisibleOverlays;
    uint     dwNumFourCCCodes;
    uint     dwAlignBoundarySrc;
    uint     dwAlignSizeSrc;
    uint     dwAlignBoundaryDest;
    uint     dwAlignSizeDest;
    uint     dwAlignStrideAlign;
    uint[8]  dwRops;
    DDSCAPS  ddsOldCaps;
    uint     dwMinOverlayStretch;
    uint     dwMaxOverlayStretch;
    uint     dwMinLiveVideoStretch;
    uint     dwMaxLiveVideoStretch;
    uint     dwMinHwCodecStretch;
    uint     dwMaxHwCodecStretch;
    uint     dwReserved1;
    uint     dwReserved2;
    uint     dwReserved3;
    uint     dwSVBCaps;
    uint     dwSVBCKeyCaps;
    uint     dwSVBFXCaps;
    uint[8]  dwSVBRops;
    uint     dwVSBCaps;
    uint     dwVSBCKeyCaps;
    uint     dwVSBFXCaps;
    uint[8]  dwVSBRops;
    uint     dwSSBCaps;
    uint     dwSSBCKeyCaps;
    uint     dwSSBFXCaps;
    uint[8]  dwSSBRops;
    uint     dwMaxVideoPorts;
    uint     dwCurrVideoPorts;
    uint     dwSVBCaps2;
    uint     dwNLVBCaps;
    uint     dwNLVBCaps2;
    uint     dwNLVBCKeyCaps;
    uint     dwNLVBFXCaps;
    uint[8]  dwNLVBRops;
    DDSCAPS2 ddsCaps;
}

struct DDCAPS_DX7
{
    uint     dwSize;
    uint     dwCaps;
    uint     dwCaps2;
    uint     dwCKeyCaps;
    uint     dwFXCaps;
    uint     dwFXAlphaCaps;
    uint     dwPalCaps;
    uint     dwSVCaps;
    uint     dwAlphaBltConstBitDepths;
    uint     dwAlphaBltPixelBitDepths;
    uint     dwAlphaBltSurfaceBitDepths;
    uint     dwAlphaOverlayConstBitDepths;
    uint     dwAlphaOverlayPixelBitDepths;
    uint     dwAlphaOverlaySurfaceBitDepths;
    uint     dwZBufferBitDepths;
    uint     dwVidMemTotal;
    uint     dwVidMemFree;
    uint     dwMaxVisibleOverlays;
    uint     dwCurrVisibleOverlays;
    uint     dwNumFourCCCodes;
    uint     dwAlignBoundarySrc;
    uint     dwAlignSizeSrc;
    uint     dwAlignBoundaryDest;
    uint     dwAlignSizeDest;
    uint     dwAlignStrideAlign;
    uint[8]  dwRops;
    DDSCAPS  ddsOldCaps;
    uint     dwMinOverlayStretch;
    uint     dwMaxOverlayStretch;
    uint     dwMinLiveVideoStretch;
    uint     dwMaxLiveVideoStretch;
    uint     dwMinHwCodecStretch;
    uint     dwMaxHwCodecStretch;
    uint     dwReserved1;
    uint     dwReserved2;
    uint     dwReserved3;
    uint     dwSVBCaps;
    uint     dwSVBCKeyCaps;
    uint     dwSVBFXCaps;
    uint[8]  dwSVBRops;
    uint     dwVSBCaps;
    uint     dwVSBCKeyCaps;
    uint     dwVSBFXCaps;
    uint[8]  dwVSBRops;
    uint     dwSSBCaps;
    uint     dwSSBCKeyCaps;
    uint     dwSSBFXCaps;
    uint[8]  dwSSBRops;
    uint     dwMaxVideoPorts;
    uint     dwCurrVideoPorts;
    uint     dwSVBCaps2;
    uint     dwNLVBCaps;
    uint     dwNLVBCaps2;
    uint     dwNLVBCKeyCaps;
    uint     dwNLVBFXCaps;
    uint[8]  dwNLVBRops;
    DDSCAPS2 ddsCaps;
}

struct DDPIXELFORMAT
{
    uint dwSize;
    uint dwFlags;
    uint dwFourCC;
    union
    {
        uint dwRGBBitCount;
        uint dwYUVBitCount;
        uint dwZBufferBitDepth;
        uint dwAlphaBitDepth;
        uint dwLuminanceBitCount;
        uint dwBumpBitCount;
        uint dwPrivateFormatBitCount;
    }
    union
    {
        uint dwRBitMask;
        uint dwYBitMask;
        uint dwStencilBitDepth;
        uint dwLuminanceBitMask;
        uint dwBumpDuBitMask;
        uint dwOperations;
    }
    union
    {
        uint dwGBitMask;
        uint dwUBitMask;
        uint dwZBitMask;
        uint dwBumpDvBitMask;
        struct MultiSampleCaps
        {
            ushort wFlipMSTypes;
            ushort wBltMSTypes;
        }
    }
    union
    {
        uint dwBBitMask;
        uint dwVBitMask;
        uint dwStencilBitMask;
        uint dwBumpLuminanceBitMask;
    }
    union
    {
        uint dwRGBAlphaBitMask;
        uint dwYUVAlphaBitMask;
        uint dwLuminanceAlphaBitMask;
        uint dwRGBZBitMask;
        uint dwYUVZBitMask;
    }
}

struct DDOVERLAYFX
{
    uint       dwSize;
    uint       dwAlphaEdgeBlendBitDepth;
    uint       dwAlphaEdgeBlend;
    uint       dwReserved;
    uint       dwAlphaDestConstBitDepth;
    union
    {
        uint               dwAlphaDestConst;
        IDirectDrawSurface lpDDSAlphaDest;
    }
    uint       dwAlphaSrcConstBitDepth;
    union
    {
        uint               dwAlphaSrcConst;
        IDirectDrawSurface lpDDSAlphaSrc;
    }
    DDCOLORKEY dckDestColorkey;
    DDCOLORKEY dckSrcColorkey;
    uint       dwDDFX;
    uint       dwFlags;
}

struct DDBLTBATCH
{
    RECT*              lprDest;
    IDirectDrawSurface lpDDSSrc;
    RECT*              lprSrc;
    uint               dwFlags;
    DDBLTFX*           lpDDBltFx;
}

struct DDGAMMARAMP
{
    ushort[256] red;
    ushort[256] green;
    ushort[256] blue;
}

struct DDDEVICEIDENTIFIER
{
    byte[512]     szDriver;
    byte[512]     szDescription;
    LARGE_INTEGER liDriverVersion;
    uint          dwVendorId;
    uint          dwDeviceId;
    uint          dwSubSysId;
    uint          dwRevision;
    GUID          guidDeviceIdentifier;
}

struct DDDEVICEIDENTIFIER2
{
    byte[512]     szDriver;
    byte[512]     szDescription;
    LARGE_INTEGER liDriverVersion;
    uint          dwVendorId;
    uint          dwDeviceId;
    uint          dwSubSysId;
    uint          dwRevision;
    GUID          guidDeviceIdentifier;
    uint          dwWHQLLevel;
}

struct DDSURFACEDESC
{
    uint          dwSize;
    uint          dwFlags;
    uint          dwHeight;
    uint          dwWidth;
    union
    {
        int  lPitch;
        uint dwLinearSize;
    }
    uint          dwBackBufferCount;
    union
    {
        uint dwMipMapCount;
        uint dwZBufferBitDepth;
        uint dwRefreshRate;
    }
    uint          dwAlphaBitDepth;
    uint          dwReserved;
    void*         lpSurface;
    DDCOLORKEY    ddckCKDestOverlay;
    DDCOLORKEY    ddckCKDestBlt;
    DDCOLORKEY    ddckCKSrcOverlay;
    DDCOLORKEY    ddckCKSrcBlt;
    DDPIXELFORMAT ddpfPixelFormat;
    DDSCAPS       ddsCaps;
}

struct DDSURFACEDESC2
{
    uint       dwSize;
    uint       dwFlags;
    uint       dwHeight;
    uint       dwWidth;
    union
    {
        int  lPitch;
        uint dwLinearSize;
    }
    union
    {
        uint dwBackBufferCount;
        uint dwDepth;
    }
    union
    {
        uint dwMipMapCount;
        uint dwRefreshRate;
        uint dwSrcVBHandle;
    }
    uint       dwAlphaBitDepth;
    uint       dwReserved;
    void*      lpSurface;
    union
    {
        DDCOLORKEY ddckCKDestOverlay;
        uint       dwEmptyFaceColor;
    }
    DDCOLORKEY ddckCKDestBlt;
    DDCOLORKEY ddckCKSrcOverlay;
    DDCOLORKEY ddckCKSrcBlt;
    union
    {
        DDPIXELFORMAT ddpfPixelFormat;
        uint          dwFVF;
    }
    DDSCAPS2   ddsCaps;
    uint       dwTextureStage;
}

struct DDOPTSURFACEDESC
{
    uint     dwSize;
    uint     dwFlags;
    DDSCAPS2 ddSCaps;
    DDOSCAPS ddOSCaps;
    GUID     guid;
    uint     dwCompressionRatio;
}

struct DDCOLORCONTROL
{
    uint dwSize;
    uint dwFlags;
    int  lBrightness;
    int  lContrast;
    int  lHue;
    int  lSaturation;
    int  lSharpness;
    int  lGamma;
    int  lColorEnable;
    uint dwReserved1;
}

// Functions

@DllImport("DDRAW")
HRESULT DirectDrawEnumerateW(LPDDENUMCALLBACKW lpCallback, void* lpContext);

@DllImport("DDRAW")
HRESULT DirectDrawEnumerateA(LPDDENUMCALLBACKA lpCallback, void* lpContext);

@DllImport("DDRAW")
HRESULT DirectDrawEnumerateExW(LPDDENUMCALLBACKEXW lpCallback, void* lpContext, uint dwFlags);

@DllImport("DDRAW")
HRESULT DirectDrawEnumerateExA(LPDDENUMCALLBACKEXA lpCallback, void* lpContext, uint dwFlags);

@DllImport("DDRAW")
HRESULT DirectDrawCreate(GUID* lpGUID, IDirectDraw* lplpDD, IUnknown pUnkOuter);

@DllImport("DDRAW")
HRESULT DirectDrawCreateEx(GUID* lpGuid, void** lplpDD, const(GUID)* iid, IUnknown pUnkOuter);

@DllImport("DDRAW")
HRESULT DirectDrawCreateClipper(uint dwFlags, IDirectDrawClipper* lplpDDClipper, IUnknown pUnkOuter);


// Interfaces

interface IDirectDraw : IUnknown
{
    HRESULT Compact();
    HRESULT CreateClipper(uint param0, IDirectDrawClipper* param1, IUnknown param2);
    HRESULT CreatePalette(uint param0, PALETTEENTRY* param1, IDirectDrawPalette* param2, IUnknown param3);
    HRESULT CreateSurface(DDSURFACEDESC* param0, IDirectDrawSurface* param1, IUnknown param2);
    HRESULT DuplicateSurface(IDirectDrawSurface param0, IDirectDrawSurface* param1);
    HRESULT EnumDisplayModes(uint param0, DDSURFACEDESC* param1, void* param2, LPDDENUMMODESCALLBACK param3);
    HRESULT EnumSurfaces(uint param0, DDSURFACEDESC* param1, void* param2, LPDDENUMSURFACESCALLBACK param3);
    HRESULT FlipToGDISurface();
    HRESULT GetCaps(DDCAPS_DX7* param0, DDCAPS_DX7* param1);
    HRESULT GetDisplayMode(DDSURFACEDESC* param0);
    HRESULT GetFourCCCodes(uint* param0, uint* param1);
    HRESULT GetGDISurface(IDirectDrawSurface* param0);
    HRESULT GetMonitorFrequency(uint* param0);
    HRESULT GetScanLine(uint* param0);
    HRESULT GetVerticalBlankStatus(int* param0);
    HRESULT Initialize(GUID* param0);
    HRESULT RestoreDisplayMode();
    HRESULT SetCooperativeLevel(HWND param0, uint param1);
    HRESULT SetDisplayMode(uint param0, uint param1, uint param2);
    HRESULT WaitForVerticalBlank(uint param0, HANDLE param1);
}

interface IDirectDraw2 : IUnknown
{
    HRESULT Compact();
    HRESULT CreateClipper(uint param0, IDirectDrawClipper* param1, IUnknown param2);
    HRESULT CreatePalette(uint param0, PALETTEENTRY* param1, IDirectDrawPalette* param2, IUnknown param3);
    HRESULT CreateSurface(DDSURFACEDESC* param0, IDirectDrawSurface* param1, IUnknown param2);
    HRESULT DuplicateSurface(IDirectDrawSurface param0, IDirectDrawSurface* param1);
    HRESULT EnumDisplayModes(uint param0, DDSURFACEDESC* param1, void* param2, LPDDENUMMODESCALLBACK param3);
    HRESULT EnumSurfaces(uint param0, DDSURFACEDESC* param1, void* param2, LPDDENUMSURFACESCALLBACK param3);
    HRESULT FlipToGDISurface();
    HRESULT GetCaps(DDCAPS_DX7* param0, DDCAPS_DX7* param1);
    HRESULT GetDisplayMode(DDSURFACEDESC* param0);
    HRESULT GetFourCCCodes(uint* param0, uint* param1);
    HRESULT GetGDISurface(IDirectDrawSurface* param0);
    HRESULT GetMonitorFrequency(uint* param0);
    HRESULT GetScanLine(uint* param0);
    HRESULT GetVerticalBlankStatus(int* param0);
    HRESULT Initialize(GUID* param0);
    HRESULT RestoreDisplayMode();
    HRESULT SetCooperativeLevel(HWND param0, uint param1);
    HRESULT SetDisplayMode(uint param0, uint param1, uint param2, uint param3, uint param4);
    HRESULT WaitForVerticalBlank(uint param0, HANDLE param1);
    HRESULT GetAvailableVidMem(DDSCAPS* param0, uint* param1, uint* param2);
}

interface IDirectDraw4 : IUnknown
{
    HRESULT Compact();
    HRESULT CreateClipper(uint param0, IDirectDrawClipper* param1, IUnknown param2);
    HRESULT CreatePalette(uint param0, PALETTEENTRY* param1, IDirectDrawPalette* param2, IUnknown param3);
    HRESULT CreateSurface(DDSURFACEDESC2* param0, IDirectDrawSurface4* param1, IUnknown param2);
    HRESULT DuplicateSurface(IDirectDrawSurface4 param0, IDirectDrawSurface4* param1);
    HRESULT EnumDisplayModes(uint param0, DDSURFACEDESC2* param1, void* param2, LPDDENUMMODESCALLBACK2 param3);
    HRESULT EnumSurfaces(uint param0, DDSURFACEDESC2* param1, void* param2, LPDDENUMSURFACESCALLBACK2 param3);
    HRESULT FlipToGDISurface();
    HRESULT GetCaps(DDCAPS_DX7* param0, DDCAPS_DX7* param1);
    HRESULT GetDisplayMode(DDSURFACEDESC2* param0);
    HRESULT GetFourCCCodes(uint* param0, uint* param1);
    HRESULT GetGDISurface(IDirectDrawSurface4* param0);
    HRESULT GetMonitorFrequency(uint* param0);
    HRESULT GetScanLine(uint* param0);
    HRESULT GetVerticalBlankStatus(int* param0);
    HRESULT Initialize(GUID* param0);
    HRESULT RestoreDisplayMode();
    HRESULT SetCooperativeLevel(HWND param0, uint param1);
    HRESULT SetDisplayMode(uint param0, uint param1, uint param2, uint param3, uint param4);
    HRESULT WaitForVerticalBlank(uint param0, HANDLE param1);
    HRESULT GetAvailableVidMem(DDSCAPS2* param0, uint* param1, uint* param2);
    HRESULT GetSurfaceFromDC(HDC param0, IDirectDrawSurface4* param1);
    HRESULT RestoreAllSurfaces();
    HRESULT TestCooperativeLevel();
    HRESULT GetDeviceIdentifier(DDDEVICEIDENTIFIER* param0, uint param1);
}

interface IDirectDraw7 : IUnknown
{
    HRESULT Compact();
    HRESULT CreateClipper(uint param0, IDirectDrawClipper* param1, IUnknown param2);
    HRESULT CreatePalette(uint param0, PALETTEENTRY* param1, IDirectDrawPalette* param2, IUnknown param3);
    HRESULT CreateSurface(DDSURFACEDESC2* param0, IDirectDrawSurface7* param1, IUnknown param2);
    HRESULT DuplicateSurface(IDirectDrawSurface7 param0, IDirectDrawSurface7* param1);
    HRESULT EnumDisplayModes(uint param0, DDSURFACEDESC2* param1, void* param2, LPDDENUMMODESCALLBACK2 param3);
    HRESULT EnumSurfaces(uint param0, DDSURFACEDESC2* param1, void* param2, LPDDENUMSURFACESCALLBACK7 param3);
    HRESULT FlipToGDISurface();
    HRESULT GetCaps(DDCAPS_DX7* param0, DDCAPS_DX7* param1);
    HRESULT GetDisplayMode(DDSURFACEDESC2* param0);
    HRESULT GetFourCCCodes(uint* param0, uint* param1);
    HRESULT GetGDISurface(IDirectDrawSurface7* param0);
    HRESULT GetMonitorFrequency(uint* param0);
    HRESULT GetScanLine(uint* param0);
    HRESULT GetVerticalBlankStatus(int* param0);
    HRESULT Initialize(GUID* param0);
    HRESULT RestoreDisplayMode();
    HRESULT SetCooperativeLevel(HWND param0, uint param1);
    HRESULT SetDisplayMode(uint param0, uint param1, uint param2, uint param3, uint param4);
    HRESULT WaitForVerticalBlank(uint param0, HANDLE param1);
    HRESULT GetAvailableVidMem(DDSCAPS2* param0, uint* param1, uint* param2);
    HRESULT GetSurfaceFromDC(HDC param0, IDirectDrawSurface7* param1);
    HRESULT RestoreAllSurfaces();
    HRESULT TestCooperativeLevel();
    HRESULT GetDeviceIdentifier(DDDEVICEIDENTIFIER2* param0, uint param1);
    HRESULT StartModeTest(SIZE* param0, uint param1, uint param2);
    HRESULT EvaluateMode(uint param0, uint* param1);
}

interface IDirectDrawPalette : IUnknown
{
    HRESULT GetCaps(uint* param0);
    HRESULT GetEntries(uint param0, uint param1, uint param2, PALETTEENTRY* param3);
    HRESULT Initialize(IDirectDraw param0, uint param1, PALETTEENTRY* param2);
    HRESULT SetEntries(uint param0, uint param1, uint param2, PALETTEENTRY* param3);
}

interface IDirectDrawClipper : IUnknown
{
    HRESULT GetClipList(RECT* param0, RGNDATA* param1, uint* param2);
    HRESULT GetHWnd(HWND* param0);
    HRESULT Initialize(IDirectDraw param0, uint param1);
    HRESULT IsClipListChanged(int* param0);
    HRESULT SetClipList(RGNDATA* param0, uint param1);
    HRESULT SetHWnd(uint param0, HWND param1);
}

interface IDirectDrawSurface : IUnknown
{
    HRESULT AddAttachedSurface(IDirectDrawSurface param0);
    HRESULT AddOverlayDirtyRect(RECT* param0);
    HRESULT Blt(RECT* param0, IDirectDrawSurface param1, RECT* param2, uint param3, DDBLTFX* param4);
    HRESULT BltBatch(DDBLTBATCH* param0, uint param1, uint param2);
    HRESULT BltFast(uint param0, uint param1, IDirectDrawSurface param2, RECT* param3, uint param4);
    HRESULT DeleteAttachedSurface(uint param0, IDirectDrawSurface param1);
    HRESULT EnumAttachedSurfaces(void* param0, LPDDENUMSURFACESCALLBACK param1);
    HRESULT EnumOverlayZOrders(uint param0, void* param1, LPDDENUMSURFACESCALLBACK param2);
    HRESULT Flip(IDirectDrawSurface param0, uint param1);
    HRESULT GetAttachedSurface(DDSCAPS* param0, IDirectDrawSurface* param1);
    HRESULT GetBltStatus(uint param0);
    HRESULT GetCaps(DDSCAPS* param0);
    HRESULT GetClipper(IDirectDrawClipper* param0);
    HRESULT GetColorKey(uint param0, DDCOLORKEY* param1);
    HRESULT GetDC(HDC* param0);
    HRESULT GetFlipStatus(uint param0);
    HRESULT GetOverlayPosition(int* param0, int* param1);
    HRESULT GetPalette(IDirectDrawPalette* param0);
    HRESULT GetPixelFormat(DDPIXELFORMAT* param0);
    HRESULT GetSurfaceDesc(DDSURFACEDESC* param0);
    HRESULT Initialize(IDirectDraw param0, DDSURFACEDESC* param1);
    HRESULT IsLost();
    HRESULT Lock(RECT* param0, DDSURFACEDESC* param1, uint param2, HANDLE param3);
    HRESULT ReleaseDC(HDC param0);
    HRESULT Restore();
    HRESULT SetClipper(IDirectDrawClipper param0);
    HRESULT SetColorKey(uint param0, DDCOLORKEY* param1);
    HRESULT SetOverlayPosition(int param0, int param1);
    HRESULT SetPalette(IDirectDrawPalette param0);
    HRESULT Unlock(void* param0);
    HRESULT UpdateOverlay(RECT* param0, IDirectDrawSurface param1, RECT* param2, uint param3, DDOVERLAYFX* param4);
    HRESULT UpdateOverlayDisplay(uint param0);
    HRESULT UpdateOverlayZOrder(uint param0, IDirectDrawSurface param1);
}

interface IDirectDrawSurface2 : IUnknown
{
    HRESULT AddAttachedSurface(IDirectDrawSurface2 param0);
    HRESULT AddOverlayDirtyRect(RECT* param0);
    HRESULT Blt(RECT* param0, IDirectDrawSurface2 param1, RECT* param2, uint param3, DDBLTFX* param4);
    HRESULT BltBatch(DDBLTBATCH* param0, uint param1, uint param2);
    HRESULT BltFast(uint param0, uint param1, IDirectDrawSurface2 param2, RECT* param3, uint param4);
    HRESULT DeleteAttachedSurface(uint param0, IDirectDrawSurface2 param1);
    HRESULT EnumAttachedSurfaces(void* param0, LPDDENUMSURFACESCALLBACK param1);
    HRESULT EnumOverlayZOrders(uint param0, void* param1, LPDDENUMSURFACESCALLBACK param2);
    HRESULT Flip(IDirectDrawSurface2 param0, uint param1);
    HRESULT GetAttachedSurface(DDSCAPS* param0, IDirectDrawSurface2* param1);
    HRESULT GetBltStatus(uint param0);
    HRESULT GetCaps(DDSCAPS* param0);
    HRESULT GetClipper(IDirectDrawClipper* param0);
    HRESULT GetColorKey(uint param0, DDCOLORKEY* param1);
    HRESULT GetDC(HDC* param0);
    HRESULT GetFlipStatus(uint param0);
    HRESULT GetOverlayPosition(int* param0, int* param1);
    HRESULT GetPalette(IDirectDrawPalette* param0);
    HRESULT GetPixelFormat(DDPIXELFORMAT* param0);
    HRESULT GetSurfaceDesc(DDSURFACEDESC* param0);
    HRESULT Initialize(IDirectDraw param0, DDSURFACEDESC* param1);
    HRESULT IsLost();
    HRESULT Lock(RECT* param0, DDSURFACEDESC* param1, uint param2, HANDLE param3);
    HRESULT ReleaseDC(HDC param0);
    HRESULT Restore();
    HRESULT SetClipper(IDirectDrawClipper param0);
    HRESULT SetColorKey(uint param0, DDCOLORKEY* param1);
    HRESULT SetOverlayPosition(int param0, int param1);
    HRESULT SetPalette(IDirectDrawPalette param0);
    HRESULT Unlock(void* param0);
    HRESULT UpdateOverlay(RECT* param0, IDirectDrawSurface2 param1, RECT* param2, uint param3, DDOVERLAYFX* param4);
    HRESULT UpdateOverlayDisplay(uint param0);
    HRESULT UpdateOverlayZOrder(uint param0, IDirectDrawSurface2 param1);
    HRESULT GetDDInterface(void** param0);
    HRESULT PageLock(uint param0);
    HRESULT PageUnlock(uint param0);
}

interface IDirectDrawSurface3 : IUnknown
{
    HRESULT AddAttachedSurface(IDirectDrawSurface3 param0);
    HRESULT AddOverlayDirtyRect(RECT* param0);
    HRESULT Blt(RECT* param0, IDirectDrawSurface3 param1, RECT* param2, uint param3, DDBLTFX* param4);
    HRESULT BltBatch(DDBLTBATCH* param0, uint param1, uint param2);
    HRESULT BltFast(uint param0, uint param1, IDirectDrawSurface3 param2, RECT* param3, uint param4);
    HRESULT DeleteAttachedSurface(uint param0, IDirectDrawSurface3 param1);
    HRESULT EnumAttachedSurfaces(void* param0, LPDDENUMSURFACESCALLBACK param1);
    HRESULT EnumOverlayZOrders(uint param0, void* param1, LPDDENUMSURFACESCALLBACK param2);
    HRESULT Flip(IDirectDrawSurface3 param0, uint param1);
    HRESULT GetAttachedSurface(DDSCAPS* param0, IDirectDrawSurface3* param1);
    HRESULT GetBltStatus(uint param0);
    HRESULT GetCaps(DDSCAPS* param0);
    HRESULT GetClipper(IDirectDrawClipper* param0);
    HRESULT GetColorKey(uint param0, DDCOLORKEY* param1);
    HRESULT GetDC(HDC* param0);
    HRESULT GetFlipStatus(uint param0);
    HRESULT GetOverlayPosition(int* param0, int* param1);
    HRESULT GetPalette(IDirectDrawPalette* param0);
    HRESULT GetPixelFormat(DDPIXELFORMAT* param0);
    HRESULT GetSurfaceDesc(DDSURFACEDESC* param0);
    HRESULT Initialize(IDirectDraw param0, DDSURFACEDESC* param1);
    HRESULT IsLost();
    HRESULT Lock(RECT* param0, DDSURFACEDESC* param1, uint param2, HANDLE param3);
    HRESULT ReleaseDC(HDC param0);
    HRESULT Restore();
    HRESULT SetClipper(IDirectDrawClipper param0);
    HRESULT SetColorKey(uint param0, DDCOLORKEY* param1);
    HRESULT SetOverlayPosition(int param0, int param1);
    HRESULT SetPalette(IDirectDrawPalette param0);
    HRESULT Unlock(void* param0);
    HRESULT UpdateOverlay(RECT* param0, IDirectDrawSurface3 param1, RECT* param2, uint param3, DDOVERLAYFX* param4);
    HRESULT UpdateOverlayDisplay(uint param0);
    HRESULT UpdateOverlayZOrder(uint param0, IDirectDrawSurface3 param1);
    HRESULT GetDDInterface(void** param0);
    HRESULT PageLock(uint param0);
    HRESULT PageUnlock(uint param0);
    HRESULT SetSurfaceDesc(DDSURFACEDESC* param0, uint param1);
}

interface IDirectDrawSurface4 : IUnknown
{
    HRESULT AddAttachedSurface(IDirectDrawSurface4 param0);
    HRESULT AddOverlayDirtyRect(RECT* param0);
    HRESULT Blt(RECT* param0, IDirectDrawSurface4 param1, RECT* param2, uint param3, DDBLTFX* param4);
    HRESULT BltBatch(DDBLTBATCH* param0, uint param1, uint param2);
    HRESULT BltFast(uint param0, uint param1, IDirectDrawSurface4 param2, RECT* param3, uint param4);
    HRESULT DeleteAttachedSurface(uint param0, IDirectDrawSurface4 param1);
    HRESULT EnumAttachedSurfaces(void* param0, LPDDENUMSURFACESCALLBACK2 param1);
    HRESULT EnumOverlayZOrders(uint param0, void* param1, LPDDENUMSURFACESCALLBACK2 param2);
    HRESULT Flip(IDirectDrawSurface4 param0, uint param1);
    HRESULT GetAttachedSurface(DDSCAPS2* param0, IDirectDrawSurface4* param1);
    HRESULT GetBltStatus(uint param0);
    HRESULT GetCaps(DDSCAPS2* param0);
    HRESULT GetClipper(IDirectDrawClipper* param0);
    HRESULT GetColorKey(uint param0, DDCOLORKEY* param1);
    HRESULT GetDC(HDC* param0);
    HRESULT GetFlipStatus(uint param0);
    HRESULT GetOverlayPosition(int* param0, int* param1);
    HRESULT GetPalette(IDirectDrawPalette* param0);
    HRESULT GetPixelFormat(DDPIXELFORMAT* param0);
    HRESULT GetSurfaceDesc(DDSURFACEDESC2* param0);
    HRESULT Initialize(IDirectDraw param0, DDSURFACEDESC2* param1);
    HRESULT IsLost();
    HRESULT Lock(RECT* param0, DDSURFACEDESC2* param1, uint param2, HANDLE param3);
    HRESULT ReleaseDC(HDC param0);
    HRESULT Restore();
    HRESULT SetClipper(IDirectDrawClipper param0);
    HRESULT SetColorKey(uint param0, DDCOLORKEY* param1);
    HRESULT SetOverlayPosition(int param0, int param1);
    HRESULT SetPalette(IDirectDrawPalette param0);
    HRESULT Unlock(RECT* param0);
    HRESULT UpdateOverlay(RECT* param0, IDirectDrawSurface4 param1, RECT* param2, uint param3, DDOVERLAYFX* param4);
    HRESULT UpdateOverlayDisplay(uint param0);
    HRESULT UpdateOverlayZOrder(uint param0, IDirectDrawSurface4 param1);
    HRESULT GetDDInterface(void** param0);
    HRESULT PageLock(uint param0);
    HRESULT PageUnlock(uint param0);
    HRESULT SetSurfaceDesc(DDSURFACEDESC2* param0, uint param1);
    HRESULT SetPrivateData(const(GUID)* param0, void* param1, uint param2, uint param3);
    HRESULT GetPrivateData(const(GUID)* param0, void* param1, uint* param2);
    HRESULT FreePrivateData(const(GUID)* param0);
    HRESULT GetUniquenessValue(uint* param0);
    HRESULT ChangeUniquenessValue();
}

interface IDirectDrawSurface7 : IUnknown
{
    HRESULT AddAttachedSurface(IDirectDrawSurface7 param0);
    HRESULT AddOverlayDirtyRect(RECT* param0);
    HRESULT Blt(RECT* param0, IDirectDrawSurface7 param1, RECT* param2, uint param3, DDBLTFX* param4);
    HRESULT BltBatch(DDBLTBATCH* param0, uint param1, uint param2);
    HRESULT BltFast(uint param0, uint param1, IDirectDrawSurface7 param2, RECT* param3, uint param4);
    HRESULT DeleteAttachedSurface(uint param0, IDirectDrawSurface7 param1);
    HRESULT EnumAttachedSurfaces(void* param0, LPDDENUMSURFACESCALLBACK7 param1);
    HRESULT EnumOverlayZOrders(uint param0, void* param1, LPDDENUMSURFACESCALLBACK7 param2);
    HRESULT Flip(IDirectDrawSurface7 param0, uint param1);
    HRESULT GetAttachedSurface(DDSCAPS2* param0, IDirectDrawSurface7* param1);
    HRESULT GetBltStatus(uint param0);
    HRESULT GetCaps(DDSCAPS2* param0);
    HRESULT GetClipper(IDirectDrawClipper* param0);
    HRESULT GetColorKey(uint param0, DDCOLORKEY* param1);
    HRESULT GetDC(HDC* param0);
    HRESULT GetFlipStatus(uint param0);
    HRESULT GetOverlayPosition(int* param0, int* param1);
    HRESULT GetPalette(IDirectDrawPalette* param0);
    HRESULT GetPixelFormat(DDPIXELFORMAT* param0);
    HRESULT GetSurfaceDesc(DDSURFACEDESC2* param0);
    HRESULT Initialize(IDirectDraw param0, DDSURFACEDESC2* param1);
    HRESULT IsLost();
    HRESULT Lock(RECT* param0, DDSURFACEDESC2* param1, uint param2, HANDLE param3);
    HRESULT ReleaseDC(HDC param0);
    HRESULT Restore();
    HRESULT SetClipper(IDirectDrawClipper param0);
    HRESULT SetColorKey(uint param0, DDCOLORKEY* param1);
    HRESULT SetOverlayPosition(int param0, int param1);
    HRESULT SetPalette(IDirectDrawPalette param0);
    HRESULT Unlock(RECT* param0);
    HRESULT UpdateOverlay(RECT* param0, IDirectDrawSurface7 param1, RECT* param2, uint param3, DDOVERLAYFX* param4);
    HRESULT UpdateOverlayDisplay(uint param0);
    HRESULT UpdateOverlayZOrder(uint param0, IDirectDrawSurface7 param1);
    HRESULT GetDDInterface(void** param0);
    HRESULT PageLock(uint param0);
    HRESULT PageUnlock(uint param0);
    HRESULT SetSurfaceDesc(DDSURFACEDESC2* param0, uint param1);
    HRESULT SetPrivateData(const(GUID)* param0, void* param1, uint param2, uint param3);
    HRESULT GetPrivateData(const(GUID)* param0, void* param1, uint* param2);
    HRESULT FreePrivateData(const(GUID)* param0);
    HRESULT GetUniquenessValue(uint* param0);
    HRESULT ChangeUniquenessValue();
    HRESULT SetPriority(uint param0);
    HRESULT GetPriority(uint* param0);
    HRESULT SetLOD(uint param0);
    HRESULT GetLOD(uint* param0);
}

interface IDirectDrawColorControl : IUnknown
{
    HRESULT GetColorControls(DDCOLORCONTROL* param0);
    HRESULT SetColorControls(DDCOLORCONTROL* param0);
}

interface IDirectDrawGammaControl : IUnknown
{
    HRESULT GetGammaRamp(uint param0, DDGAMMARAMP* param1);
    HRESULT SetGammaRamp(uint param0, DDGAMMARAMP* param1);
}


