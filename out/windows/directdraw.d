// Written in the D programming language.

module windows.directdraw;

public import windows.core;
public import windows.com : HRESULT, IUnknown;
public import windows.directshow : DDCOLORKEY;
public import windows.displaydevices : RECT, SIZE;
public import windows.gdi : HDC, HMONITOR, PALETTEENTRY, RGNDATA;
public import windows.systemservices : BOOL, HANDLE, LARGE_INTEGER, PSTR, PWSTR;
public import windows.windowsandmessaging : HWND;

extern(Windows) @nogc nothrow:


// Callbacks

///The <i>DDEnumCallback</i> function is an application-defined callback function for the DirectDrawEnumerate function.
///Params:
///    Arg1 = A pointer to the unique identifier of the DirectDraw object.
///    Arg2 = Address of a string that contains the driver name.
///    Arg3 = Address of a string that contains the driver description.
///    Arg4 = A pointer to an application-defined structure to be passed to the callback function each time the function is
///           called.
///Returns:
///    The callback function returns nonzero to continue the enumeration. It returns zero to stop the enumeration.
///    
alias LPDDENUMCALLBACKA = BOOL function(GUID* param0, PSTR param1, PSTR param2, void* param3);
///The <i>DDEnumCallback</i> function is an application-defined callback function for the DirectDrawEnumerate function.
///Params:
///    Arg1 = A pointer to the unique identifier of the DirectDraw object.
///    Arg2 = Address of a string that contains the driver name.
///    Arg3 = Address of a string that contains the driver description.
///    Arg4 = A pointer to an application-defined structure to be passed to the callback function each time that the function
///           is called.
///Returns:
///    The callback function returns nonzero to continue the enumeration. It returns zero to stop the enumeration.
///    
alias LPDDENUMCALLBACKW = BOOL function(GUID* param0, PWSTR param1, PWSTR param2, void* param3);
///The <i>DDEnumCallbackEx</i> function is an application-defined callback function for the DirectDrawEnumerateEx
///function.
///Params:
///    Arg1 = A pointer to the unique identifier of the DirectDraw object.
///    Arg2 = Address of a string that contains the driver name.
///    Arg3 = Address of a string that contains the driver description.
///    Arg4 = A pointer to an application-defined structure to be passed to the callback function each time that the function
///           is called.
///    Arg5 = Handle of the monitor that is associated with the enumerated DirectDraw object. This parameter is NULL when the
///           enumerated DirectDraw object is for the primary device, a nondisplay device (such as a 3-D accelerator with no
///           2-D capabilities), or devices not attached to the desktop.
///Returns:
///    The callback function returns nonzero to continue the enumeration. It returns zero to stop the enumeration.
///    
alias LPDDENUMCALLBACKEXA = BOOL function(GUID* param0, PSTR param1, PSTR param2, void* param3, HMONITOR param4);
///The <i>DDEnumCallbackEx</i> function is an application-defined callback function for the DirectDrawEnumerateEx
///function.
///Params:
///    Arg1 = A pointer to the unique identifier of the DirectDraw object.
///    Arg2 = Address of a string that contains the driver name.
///    Arg3 = Address of a string that contains the driver description.
///    Arg4 = A pointer to an application-defined structure to be passed to the callback function each time that the function
///           is called.
///    Arg5 = Handle of the monitor that is associated with the enumerated DirectDraw object. This parameter is NULL when the
///           enumerated DirectDraw object is for the primary device, a nondisplay device (such as a 3-D accelerator with no
///           2-D capabilities), or devices not attached to the desktop.
///Returns:
///    The callback function returns nonzero to continue the enumeration. It returns zero to stop the enumeration.
///    
alias LPDDENUMCALLBACKEXW = BOOL function(GUID* param0, PWSTR param1, PWSTR param2, void* param3, HMONITOR param4);
alias LPDIRECTDRAWENUMERATEEXA = HRESULT function(LPDDENUMCALLBACKEXA lpCallback, void* lpContext, uint dwFlags);
alias LPDIRECTDRAWENUMERATEEXW = HRESULT function(LPDDENUMCALLBACKEXW lpCallback, void* lpContext, uint dwFlags);
alias LPDDENUMCALLBACK = BOOL function();
alias LPDDENUMCALLBACKEX = BOOL function();
alias LPDIRECTDRAWENUMERATEEX = HRESULT function();
///Do not use. This callback function is superseded by the EnumModesCallback2 function that is used with the
///IDirectDraw7::EnumDisplayModes method.
///Params:
///    Arg1 = A pointer to a read-only DDSURFACEDESC structure that provides the monitor frequency and the mode that can be
///           created.
///    Arg2 = A pointer to an application-defined structure to be passed to the callback function each time that the function
///           is called.
///Returns:
///    The callback function returns DDENUMRET_OK to continue the enumeration. It returns DDENUMRET_CANCEL to stop the
///    enumeration.
///    
alias LPDDENUMMODESCALLBACK = HRESULT function(DDSURFACEDESC* param0, void* param1);
///The <i>EnumModesCallback2</i> function is an application-defined callback function for the
///IDirectDraw7::EnumDisplayModes method.
///Params:
///    Arg1 = A pointer to a read-only DDSURFACEDESC2 structure that provides the monitor frequency and the mode that can be
///           created.
///    Arg2 = A pointer to an application-defined structure to be passed to the callback function each time that the function
///           is called.
///Returns:
///    The callback function returns DDENUMRET_OK to continue the enumeration. It returns DDENUMRET_CANCEL to stop the
///    enumeration.
///    
alias LPDDENUMMODESCALLBACK2 = HRESULT function(DDSURFACEDESC2* param0, void* param1);
///Do not use. This callback function is superseded by the EnumSurfacesCallback7 function that is used with the
///IDirectDraw7::EnumSurfaces, IDirectDrawSurface7::EnumAttachedSurfaces, and IDirectDrawSurface7::EnumOverlayZOrders
///methods.
///Params:
///    Arg1 = A pointer to the <b>IDirectDrawSurface</b> interface for the attached surface.
///    Arg2 = A pointer to a DDSURFACEDESC structure that describes the attached surface.
///    Arg3 = A pointer to an application-defined structure to be passed to the callback function each time that the function
///           is called.
///Returns:
///    The callback function returns DDENUMRET_OK to continue the enumeration. It returns DDENUMRET_CANCEL to stop the
///    enumeration.
///    
alias LPDDENUMSURFACESCALLBACK = HRESULT function(IDirectDrawSurface param0, DDSURFACEDESC* param1, void* param2);
///Do not use. This callback function is superseded by the EnumSurfacesCallback7 function that is used with the
///IDirectDraw7::EnumSurfaces, IDirectDrawSurface7::EnumAttachedSurfaces, and IDirectDrawSurface7::EnumOverlayZOrders
///methods.
///Params:
///    Arg1 = A pointer to the <b>IDirectDrawSurface4</b> interface of the attached surface.
///    Arg2 = A pointer to a DDSURFACEDESC2 structure that describes the attached surface.
///    Arg3 = A pointer to an application-defined structure to be passed to the callback function each time that the function
///           is called.
///Returns:
///    The callback function returns DDENUMRET_OK to continue the enumeration. It returns DDENUMRET_CANCEL to stop the
///    enumeration.
///    
alias LPDDENUMSURFACESCALLBACK2 = HRESULT function(IDirectDrawSurface4 param0, DDSURFACEDESC2* param1, 
                                                   void* param2);
///The <i>EnumSurfacesCallback7</i> function is an application-defined callback function for the
///IDirectDrawSurface7::EnumAttachedSurfaces and IDirectDrawSurface7::EnumOverlayZOrders methods.
///Params:
///    Arg1 = A pointer to the IDirectDrawSurface7 interface of the attached surface.
///    Arg2 = A pointer to a DDSURFACEDESC2 structure that describes the attached surface.
///    Arg3 = A pointer to an application-defined structure to be passed to the callback function each time that the function
///           is called.
///Returns:
///    The callback function returns DDENUMRET_OK to continue the enumeration. It returns DDENUMRET_CANCEL to stop the
///    enumeration.
///    
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

///The DDBLTFX structure passes raster operations (ROPs), effects, and override information to the
///IDirectDrawSurface7::Blt method. This structure is also part of the DDBLTBATCH structure that is used with the
///IDirectDrawSurface7::BltBatch method.
struct DDBLTFX
{
    ///Size of the structure, in bytes. This member must be initialized before the structure is used.
    uint       dwSize;
    ///Type of FX operations. The following types are defined.
    uint       dwDDFX;
    ///Win32 raster operations. You can retrieve a list of supported raster operations by calling the
    ///IDirectDraw7::GetCaps method.
    uint       dwROP;
    ///DirectDraw raster operations.
    uint       dwDDROP;
    ///Rotation angle for the bitblt.
    uint       dwRotationAngle;
    ///Z-buffer compares.
    uint       dwZBufferOpCode;
    ///Low limit of a z-buffer.
    uint       dwZBufferLow;
    ///High limit of a z-buffer.
    uint       dwZBufferHigh;
    ///Destination base value of a z-buffer.
    uint       dwZBufferBaseDest;
    ///Bit depth of the destination z-constant.
    uint       dwZDestConstBitDepth;
union
    {
        uint               dwZDestConst;
        IDirectDrawSurface lpDDSZBufferDest;
    }
    ///Bit depth of the source z-constant.
    uint       dwZSrcConstBitDepth;
union
    {
        uint               dwZSrcConst;
        IDirectDrawSurface lpDDSZBufferSrc;
    }
    ///Bit depth of the constant for an alpha edge blend.
    uint       dwAlphaEdgeBlendBitDepth;
    ///Alpha constant used for edge blending.
    uint       dwAlphaEdgeBlend;
    ///Reserved
    uint       dwReserved;
    ///Bit depth of the destination alpha constant.
    uint       dwAlphaDestConstBitDepth;
union
    {
        uint               dwAlphaDestConst;
        IDirectDrawSurface lpDDSAlphaDest;
    }
    ///Bit depth of the source alpha constant.
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
    ///Destination color key override.
    DDCOLORKEY ddckDestColorkey;
    ///Source color key override.
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

///The DDCAPS structure represents the capabilities of the hardware exposed through the DirectDraw object. This
///structure contains a DDSCAPS2 structure used in this context to describe what kinds of DirectDrawSurface objects can
///be created. It might not be possible to create all the surfaces described by these capabilities simultaneously. This
///structure is used with the IDirectDraw7::GetCaps method. The Ddraw.h header file contains multiple versions of this
///structure (for example, DDCAPS_DX7). For more information about how to determine which version to use, see Remarks.
struct DDCAPS_DX3
{
    ///Size of the structure, in bytes. This member must be initialized before the structure is used.
    uint    dwSize;
    ///This value consists of one or more of the following flags that specify hardware and driver capabilities.
    uint    dwCaps;
    ///This value consists of one or more of the following flags that specify more hardware and driver capabilities.
    uint    dwCaps2;
    ///This value consists of one or more of the following flags that specify color-key capabilities.
    uint    dwCKeyCaps;
    ///This value consists of one or more of the following flags that specify driver stretching and effects
    ///capabilities.
    uint    dwFXCaps;
    ///This value consists of one or more of the following flags that specify driver alpha capabilities.
    uint    dwFXAlphaCaps;
    ///This value consists of one or more of the following flags that specify palette capabilities.
    uint    dwPalCaps;
    ///This value consists of one or more of the following flags that specify stereo-vision capabilities.
    uint    dwSVCaps;
    ///DDBD_2, DDBD_4, or DDBD_8. (Indicate 2, 4, or 8 bits per pixel.)
    uint    dwAlphaBltConstBitDepths;
    ///DDBD_1, DDBD_2, DDBD_4, or DDBD_8. (Indicate 1, 2, 4, or 8 bits per pixel.)
    uint    dwAlphaBltPixelBitDepths;
    ///DDBD_1, DDBD_2, DDBD_4, or DDBD_8. (Indicate 1, 2, 4, or 8 bits per pixel.)
    uint    dwAlphaBltSurfaceBitDepths;
    ///DDBD_2, DDBD_4, or DDBD_8. (Indicate 2, 4, or 8 bits per pixel.)
    uint    dwAlphaOverlayConstBitDepths;
    ///DDBD_1, DDBD_2, DDBD_4, or DDBD_8. (Indicate 1, 2, 4, or 8 bits per pixel.)
    uint    dwAlphaOverlayPixelBitDepths;
    ///DDBD_1, DDBD_2, DDBD_4, or DDBD_8. (Indicate 1, 2, 4, or 8 bits per pixel.)
    uint    dwAlphaOverlaySurfaceBitDepths;
    ///DDBD_8, DDBD_16, DDBD_24, or DDBD_32. (Indicate 8, 16, 24, or 32 bits per pixel.) This member is obsolete for
    ///DirectX 6.0 and later. Use the <b>IDirect3D7::EnumZBufferFormats</b> to retrieve information about supported
    ///depth buffer formats.
    uint    dwZBufferBitDepths;
    ///Total amount of display memory on the device, in bytes, minus memory reserved for the primary surface and any
    ///private data structures reserved by the driver. (This value is the same as the total video memory reported by the
    ///IDirectDraw7::GetAvailableVidMem method.)
    uint    dwVidMemTotal;
    ///Free display memory. This value equals the value in <b>dwVidMemTotal</b>, minus any memory currently allocated by
    ///the application for surfaces. Unlike the IDirectDraw7::GetAvailableVidMem method, which reports the memory
    ///available for a particular type of surface (such as a texture), this value reflects the memory available for any
    ///type of surface.
    uint    dwVidMemFree;
    ///Maximum number of visible overlays or overlay sprites.
    uint    dwMaxVisibleOverlays;
    ///Current number of visible overlays or overlay sprites.
    uint    dwCurrVisibleOverlays;
    ///Number of FourCC codes.
    uint    dwNumFourCCCodes;
    ///Source-rectangle alignment for an overlay surface, in pixels.
    uint    dwAlignBoundarySrc;
    ///Source-rectangle size alignment for an overlay surface, in pixels. Overlay source rectangles must have a pixel
    ///width that is a multiple of this value.
    uint    dwAlignSizeSrc;
    ///Destination-rectangle alignment for an overlay surface, in pixels.
    uint    dwAlignBoundaryDest;
    ///Destination-rectangle size alignment for an overlay surface, in pixels. Overlay destination rectangles must have
    ///a pixel width that is a multiple of this value.
    uint    dwAlignSizeDest;
    ///Stride alignment.
    uint    dwAlignStrideAlign;
    ///Raster operations supported.
    uint[8] dwRops;
    ///A DDSCAPS2 structure that contains general surface capabilities.
    DDSCAPS ddsCaps;
    ///Minimum overlay stretch factor, multiplied by 1000. For example, 1.3 = 1300.
    uint    dwMinOverlayStretch;
    ///Maximum overlay stretch factor, multiplied by 1000. For example, 1.3 = 1300.
    uint    dwMaxOverlayStretch;
    ///Obsolete; do not use.
    uint    dwMinLiveVideoStretch;
    ///Obsolete; do not use.
    uint    dwMaxLiveVideoStretch;
    ///Obsolete; do not use.
    uint    dwMinHwCodecStretch;
    ///Obsolete; do not use.
    uint    dwMaxHwCodecStretch;
    ///Reserved
    uint    dwReserved1;
    ///Reserved
    uint    dwReserved2;
    ///Reserved
    uint    dwReserved3;
    ///Driver-specific capabilities for bitblts from system memory to display memory. Valid flags are identical to the
    ///bitblt-related flags that are used with the <b>dwCaps</b> member.
    uint    dwSVBCaps;
    ///Driver color-key capabilities for bitblts from system memory to display memory. Valid flags are identical to the
    ///bitblt-related flags that are used with the <b>dwCKeyCaps</b> member.
    uint    dwSVBCKeyCaps;
    ///Driver FX capabilities for bitblts from system memory to display memory. Valid flags are identical to the
    ///bitblt-related flags that are used with the <b>dwFXCaps</b> member.
    uint    dwSVBFXCaps;
    ///Raster operations supported for bitblts from system memory to display memory.
    uint[8] dwSVBRops;
    ///Driver-specific capabilities for bitblts from display memory to system memory. Valid flags are identical to the
    ///bitblt-related flags that are used with the <b>dwCaps</b> member.
    uint    dwVSBCaps;
    ///Driver color-key capabilities for bitblts from display memory to system memory. Valid flags are identical to the
    ///bitblt-related flags that are used with the <b>dwCKeyCaps</b> member.
    uint    dwVSBCKeyCaps;
    ///Driver FX capabilities for bitblts from display memory to system memory. Valid flags are identical to the
    ///bitblt-related flags used with the <b>dwFXCaps</b> member.
    uint    dwVSBFXCaps;
    ///Raster operations supported for bitblts from display memory to system memory.
    uint[8] dwVSBRops;
    ///Driver-specific capabilities for bitblts from system memory to system memory. Valid flags are identical to the
    ///bitblt-related flags used with the <b>dwCaps</b> member.
    uint    dwSSBCaps;
    ///Driver color-key capabilities for bitblts from system memory to system memory. Valid flags are identical to the
    ///bitblt-related flags used with the <b>dwCKeyCaps</b> member.
    uint    dwSSBCKeyCaps;
    ///Driver FX capabilities for bitblts from system memory to system memory. Valid flags are identical to the
    ///bitblt-related flags used with the <b>dwFXCaps</b> member.
    uint    dwSSBFXCaps;
    ///Raster operations supported for bitblts from system memory to system memory.
    uint[8] dwSSBRops;
    ///Reserved
    uint    dwReserved4;
    ///Reserved
    uint    dwReserved5;
    ///Reserved
    uint    dwReserved6;
}

///The DDCAPS structure represents the capabilities of the hardware exposed through the DirectDraw object. This
///structure contains a DDSCAPS2 structure used in this context to describe what kinds of DirectDrawSurface objects can
///be created. It might not be possible to create all the surfaces described by these capabilities simultaneously. This
///structure is used with the IDirectDraw7::GetCaps method. The Ddraw.h header file contains multiple versions of this
///structure (for example, DDCAPS_DX7). For more information about how to determine which version to use, see Remarks.
struct DDCAPS_DX5
{
    ///Size of the structure, in bytes. This member must be initialized before the structure is used.
    uint    dwSize;
    ///This value consists of one or more of the following flags that specify hardware and driver capabilities:
    uint    dwCaps;
    ///This value consists of one or more of the following flags that specify more hardware and driver capabilities:
    uint    dwCaps2;
    ///This value consists of one or more of the following flags that specify color-key capabilities:
    uint    dwCKeyCaps;
    ///This value consists of one or more of the following flags that specify driver stretching and effects
    ///capabilities:
    uint    dwFXCaps;
    ///This value consists of one or more of the following flags that specify driver alpha capabilities:
    uint    dwFXAlphaCaps;
    ///This value consists of one or more of the following flags that specify palette capabilities:
    uint    dwPalCaps;
    ///This value consists of one or more of the following flags that specify stereo-vision capabilities:
    uint    dwSVCaps;
    ///DDBD_2, DDBD_4, or DDBD_8. (Indicate 2, 4, or 8 bits per pixel.)
    uint    dwAlphaBltConstBitDepths;
    ///DDBD_1, DDBD_2, DDBD_4, or DDBD_8. (Indicate 1, 2, 4, or 8 bits per pixel.)
    uint    dwAlphaBltPixelBitDepths;
    ///DDBD_1, DDBD_2, DDBD_4, or DDBD_8. (Indicate 1, 2, 4, or 8 bits per pixel.)
    uint    dwAlphaBltSurfaceBitDepths;
    ///DDBD_2, DDBD_4, or DDBD_8. (Indicate 2, 4, or 8 bits per pixel.)
    uint    dwAlphaOverlayConstBitDepths;
    ///DDBD_1, DDBD_2, DDBD_4, or DDBD_8. (Indicate 1, 2, 4, or 8 bits per pixel.)
    uint    dwAlphaOverlayPixelBitDepths;
    ///DDBD_1, DDBD_2, DDBD_4, or DDBD_8. (Indicate 1, 2, 4, or 8 bits per pixel.)
    uint    dwAlphaOverlaySurfaceBitDepths;
    ///DDBD_8, DDBD_16, DDBD_24, or DDBD_32. (Indicate 8, 16, 24, or 32 bits per pixel.) This member is obsolete for
    ///DirectX 6.0 and later. Use the <b>IDirect3D7::EnumZBufferFormats</b> to retrieve information about supported
    ///depth buffer formats.
    uint    dwZBufferBitDepths;
    ///Total amount of display memory on the device, in bytes, minus memory reserved for the primary surface and any
    ///private data structures reserved by the driver. (This value is the same as the total video memory reported by the
    ///IDirectDraw7::GetAvailableVidMem method.)
    uint    dwVidMemTotal;
    ///Free display memory. This value equals the value in <b>dwVidMemTotal</b>, minus any memory currently allocated by
    ///the application for surfaces. Unlike the IDirectDraw7::GetAvailableVidMem method, which reports the memory
    ///available for a particular type of surface (such as a texture), this value reflects the memory available for any
    ///type of surface.
    uint    dwVidMemFree;
    ///Maximum number of visible overlays or overlay sprites.
    uint    dwMaxVisibleOverlays;
    ///Current number of visible overlays or overlay sprites.
    uint    dwCurrVisibleOverlays;
    ///Number of FourCC codes.
    uint    dwNumFourCCCodes;
    ///Source-rectangle alignment for an overlay surface, in pixels.
    uint    dwAlignBoundarySrc;
    ///Source-rectangle size alignment for an overlay surface, in pixels. Overlay source rectangles must have a pixel
    ///width that is a multiple of this value.
    uint    dwAlignSizeSrc;
    ///Destination-rectangle alignment for an overlay surface, in pixels.
    uint    dwAlignBoundaryDest;
    ///Destination-rectangle size alignment for an overlay surface, in pixels. Overlay destination rectangles must have
    ///a pixel width that is a multiple of this value.
    uint    dwAlignSizeDest;
    ///Stride alignment.
    uint    dwAlignStrideAlign;
    ///Raster operations supported.
    uint[8] dwRops;
    ///A DDSCAPS2 structure that contains general surface capabilities.
    DDSCAPS ddsCaps;
    ///Minimum overlay stretch factor, multiplied by 1000. For example, 1.3 = 1300.
    uint    dwMinOverlayStretch;
    ///Maximum overlay stretch factor, multiplied by 1000. For example, 1.3 = 1300.
    uint    dwMaxOverlayStretch;
    ///Obsolete; do not use.
    uint    dwMinLiveVideoStretch;
    ///Obsolete; do not use.
    uint    dwMaxLiveVideoStretch;
    ///Obsolete; do not use.
    uint    dwMinHwCodecStretch;
    ///Obsolete; do not use.
    uint    dwMaxHwCodecStretch;
    ///Reserved
    uint    dwReserved1;
    ///Reserved
    uint    dwReserved2;
    ///Reserved
    uint    dwReserved3;
    ///Driver-specific capabilities for bitblts from system memory to display memory. Valid flags are identical to the
    ///bitblt-related flags that are used with the <b>dwCaps</b> member.
    uint    dwSVBCaps;
    ///Driver color-key capabilities for bitblts from system memory to display memory. Valid flags are identical to the
    ///bitblt-related flags that are used with the <b>dwCKeyCaps</b> member.
    uint    dwSVBCKeyCaps;
    ///Driver FX capabilities for bitblts from system memory to display memory. Valid flags are identical to the
    ///bitblt-related flags that are used with the <b>dwFXCaps</b> member.
    uint    dwSVBFXCaps;
    ///Raster operations supported for bitblts from system memory to display memory.
    uint[8] dwSVBRops;
    ///Driver-specific capabilities for bitblts from display memory to system memory. Valid flags are identical to the
    ///bitblt-related flags that are used with the <b>dwCaps</b> member.
    uint    dwVSBCaps;
    ///Driver color-key capabilities for bitblts from display memory to system memory. Valid flags are identical to the
    ///bitblt-related flags that are used with the <b>dwCKeyCaps</b> member.
    uint    dwVSBCKeyCaps;
    ///Driver FX capabilities for bitblts from display memory to system memory. Valid flags are identical to the
    ///bitblt-related flags used with the <b>dwFXCaps</b> member.
    uint    dwVSBFXCaps;
    ///Raster operations supported for bitblts from display memory to system memory.
    uint[8] dwVSBRops;
    ///Driver-specific capabilities for bitblts from system memory to system memory. Valid flags are identical to the
    ///bitblt-related flags used with the <b>dwCaps</b> member.
    uint    dwSSBCaps;
    ///Driver color-key capabilities for bitblts from system memory to system memory. Valid flags are identical to the
    ///bitblt-related flags used with the <b>dwCKeyCaps</b> member.
    uint    dwSSBCKeyCaps;
    ///Driver FX capabilities for bitblts from system memory to system memory. Valid flags are identical to the
    ///bitblt-related flags used with the <b>dwFXCaps</b> member.
    uint    dwSSBFXCaps;
    ///Raster operations supported for bitblts from system memory to system memory.
    uint[8] dwSSBRops;
    ///Maximum number of live video ports.
    uint    dwMaxVideoPorts;
    ///Current number of live video ports.
    uint    dwCurrVideoPorts;
    ///More driver-specific capabilities for bitblts from system memory to video memory. Valid flags are identical to
    ///the bitblt-related flags used with the <b>dwCaps2</b> member.
    uint    dwSVBCaps2;
    ///Driver-specific capabilities for bitblts from nonlocal to local video memory. Valid flags are identical to the
    ///bitblt-related flags used with the <b>dwCaps</b> member.
    uint    dwNLVBCaps;
    ///More driver-specific capabilities for bitblts from nonlocal to local video memory. Valid flags are identical to
    ///the bitblt-related flags used with the <b>dwCaps2</b> member.
    uint    dwNLVBCaps2;
    ///Driver color-key capabilities for bitblts form nonlocal to local video memory. Valid flags are identical to the
    ///bitblt-related flags used with the <b>dwCKeyCaps</b> member.
    uint    dwNLVBCKeyCaps;
    ///Driver FX capabilities for bitblts from nonlocal to local video memory. Valid flags are identical to the
    ///bitblt-related flags used with the <b>dwFXCaps</b> member.
    uint    dwNLVBFXCaps;
    ///Raster operations supported for bitblts from nonlocal to local video memory. DirectDraw supports only those
    ///overlay source rectangles whose x-axis sizes, in pixels, are <b>dwAlignSizeSrc</b> multiples.
    uint[8] dwNLVBRops;
}

///The DDCAPS structure represents the capabilities of the hardware exposed through the DirectDraw object. This
///structure contains a DDSCAPS2 structure used in this context to describe what kinds of DirectDrawSurface objects can
///be created. It might not be possible to create all the surfaces described by these capabilities simultaneously. This
///structure is used with the IDirectDraw7::GetCaps method. The Ddraw.h header file contains multiple versions of this
///structure (for example, DDCAPS_DX7). For more information about how to determine which version to use, see Remarks.
struct DDCAPS_DX6
{
    ///Size of the structure, in bytes. This member must be initialized before the structure is used.
    uint     dwSize;
    ///This value consists of one or more of the following flags that specify hardware and driver capabilities:
    uint     dwCaps;
    ///This value consists of one or more of the following flags that specify more hardware and driver capabilities:
    uint     dwCaps2;
    ///This value consists of one or more of the following flags that specify color-key capabilities:
    uint     dwCKeyCaps;
    ///This value consists of one or more of the following flags that specify driver stretching and effects
    ///capabilities:
    uint     dwFXCaps;
    ///This value consists of one or more of the following flags that specify driver alpha capabilities:
    uint     dwFXAlphaCaps;
    ///This value consists of one or more of the following flags that specify palette capabilities:
    uint     dwPalCaps;
    ///This value consists of one or more of the following flags that specify stereo-vision capabilities:
    uint     dwSVCaps;
    ///DDBD_2, DDBD_4, or DDBD_8. (Indicate 2, 4, or 8 bits per pixel.)
    uint     dwAlphaBltConstBitDepths;
    ///DDBD_1, DDBD_2, DDBD_4, or DDBD_8. (Indicate 1, 2, 4, or 8 bits per pixel.)
    uint     dwAlphaBltPixelBitDepths;
    ///DDBD_1, DDBD_2, DDBD_4, or DDBD_8. (Indicate 1, 2, 4, or 8 bits per pixel.)
    uint     dwAlphaBltSurfaceBitDepths;
    ///DDBD_2, DDBD_4, or DDBD_8. (Indicate 2, 4, or 8 bits per pixel.)
    uint     dwAlphaOverlayConstBitDepths;
    ///DDBD_1, DDBD_2, DDBD_4, or DDBD_8. (Indicate 1, 2, 4, or 8 bits per pixel.)
    uint     dwAlphaOverlayPixelBitDepths;
    ///DDBD_1, DDBD_2, DDBD_4, or DDBD_8. (Indicate 1, 2, 4, or 8 bits per pixel.)
    uint     dwAlphaOverlaySurfaceBitDepths;
    ///DDBD_8, DDBD_16, DDBD_24, or DDBD_32. (Indicate 8, 16, 24, or 32 bits per pixel.) This member is obsolete for
    ///DirectX 6.0 and later. Use the <b>IDirect3D7::EnumZBufferFormats</b> to retrieve information about supported
    ///depth buffer formats.
    uint     dwZBufferBitDepths;
    ///Total amount of display memory on the device, in bytes, minus memory reserved for the primary surface and any
    ///private data structures reserved by the driver. (This value is the same as the total video memory reported by the
    ///IDirectDraw7::GetAvailableVidMem method.)
    uint     dwVidMemTotal;
    ///Free display memory. This value equals the value in <b>dwVidMemTotal</b>, minus any memory currently allocated by
    ///the application for surfaces. Unlike the IDirectDraw7::GetAvailableVidMem method, which reports the memory
    ///available for a particular type of surface (such as a texture), this value reflects the memory available for any
    ///type of surface.
    uint     dwVidMemFree;
    ///Maximum number of visible overlays or overlay sprites.
    uint     dwMaxVisibleOverlays;
    ///Current number of visible overlays or overlay sprites.
    uint     dwCurrVisibleOverlays;
    ///Number of FourCC codes.
    uint     dwNumFourCCCodes;
    ///Source-rectangle alignment for an overlay surface, in pixels.
    uint     dwAlignBoundarySrc;
    ///Source-rectangle size alignment for an overlay surface, in pixels. Overlay source rectangles must have a pixel
    ///width that is a multiple of this value.
    uint     dwAlignSizeSrc;
    ///Destination-rectangle alignment for an overlay surface, in pixels.
    uint     dwAlignBoundaryDest;
    ///Destination-rectangle size alignment for an overlay surface, in pixels. Overlay destination rectangles must have
    ///a pixel width that is a multiple of this value.
    uint     dwAlignSizeDest;
    ///Stride alignment.
    uint     dwAlignStrideAlign;
    ///Raster operations supported.
    uint[8]  dwRops;
    ///Obsolete. Prior to DirectX 6.0, this member contained general surface capabilities, which are now contained in
    ///the <b>ddsCaps</b> member (a DDSCAPS2 structure).
    DDSCAPS  ddsOldCaps;
    ///Minimum overlay stretch factor, multiplied by 1000. For example, 1.3 = 1300.
    uint     dwMinOverlayStretch;
    ///Maximum overlay stretch factor, multiplied by 1000. For example, 1.3 = 1300.
    uint     dwMaxOverlayStretch;
    ///Obsolete; do not use.
    uint     dwMinLiveVideoStretch;
    ///Obsolete; do not use.
    uint     dwMaxLiveVideoStretch;
    ///Obsolete; do not use.
    uint     dwMinHwCodecStretch;
    ///Obsolete; do not use.
    uint     dwMaxHwCodecStretch;
    ///Reserved
    uint     dwReserved1;
    ///Reserved
    uint     dwReserved2;
    ///Reserved
    uint     dwReserved3;
    ///Driver-specific capabilities for bitblts from system memory to display memory. Valid flags are identical to the
    ///bitblt-related flags that are used with the <b>dwCaps</b> member.
    uint     dwSVBCaps;
    ///Driver color-key capabilities for bitblts from system memory to display memory. Valid flags are identical to the
    ///bitblt-related flags that are used with the <b>dwCKeyCaps</b> member.
    uint     dwSVBCKeyCaps;
    ///Driver FX capabilities for bitblts from system memory to display memory. Valid flags are identical to the
    ///bitblt-related flags that are used with the <b>dwFXCaps</b> member.
    uint     dwSVBFXCaps;
    ///Raster operations supported for bitblts from system memory to display memory.
    uint[8]  dwSVBRops;
    ///Driver-specific capabilities for bitblts from display memory to system memory. Valid flags are identical to the
    ///bitblt-related flags that are used with the <b>dwCaps</b> member.
    uint     dwVSBCaps;
    ///Driver color-key capabilities for bitblts from display memory to system memory. Valid flags are identical to the
    ///bitblt-related flags that are used with the <b>dwCKeyCaps</b> member.
    uint     dwVSBCKeyCaps;
    ///Driver FX capabilities for bitblts from display memory to system memory. Valid flags are identical to the
    ///bitblt-related flags used with the <b>dwFXCaps</b> member.
    uint     dwVSBFXCaps;
    ///Raster operations supported for bitblts from display memory to system memory.
    uint[8]  dwVSBRops;
    ///Driver-specific capabilities for bitblts from system memory to system memory. Valid flags are identical to the
    ///bitblt-related flags used with the <b>dwCaps</b> member.
    uint     dwSSBCaps;
    ///Driver color-key capabilities for bitblts from system memory to system memory. Valid flags are identical to the
    ///bitblt-related flags used with the <b>dwCKeyCaps</b> member.
    uint     dwSSBCKeyCaps;
    ///Driver FX capabilities for bitblts from system memory to system memory. Valid flags are identical to the
    ///bitblt-related flags used with the <b>dwFXCaps</b> member.
    uint     dwSSBFXCaps;
    ///Raster operations supported for bitblts from system memory to system memory.
    uint[8]  dwSSBRops;
    ///Maximum number of live video ports.
    uint     dwMaxVideoPorts;
    ///Current number of live video ports.
    uint     dwCurrVideoPorts;
    ///More driver-specific capabilities for bitblts from system memory to video memory. Valid flags are identical to
    ///the bitblt-related flags used with the <b>dwCaps2</b> member.
    uint     dwSVBCaps2;
    ///Driver-specific capabilities for bitblts from nonlocal to local video memory. Valid flags are identical to the
    ///bitblt-related flags used with the <b>dwCaps</b> member.
    uint     dwNLVBCaps;
    ///More driver-specific capabilities for bitblts from nonlocal to local video memory. Valid flags are identical to
    ///the bitblt-related flags used with the <b>dwCaps2</b> member.
    uint     dwNLVBCaps2;
    ///Driver color-key capabilities for bitblts form nonlocal to local video memory. Valid flags are identical to the
    ///bitblt-related flags used with the <b>dwCKeyCaps</b> member.
    uint     dwNLVBCKeyCaps;
    ///Driver FX capabilities for bitblts from nonlocal to local video memory. Valid flags are identical to the
    ///bitblt-related flags used with the <b>dwFXCaps</b> member.
    uint     dwNLVBFXCaps;
    ///Raster operations supported for bitblts from nonlocal to local video memory.
    uint[8]  dwNLVBRops;
    ///A DDSCAPS2 structure that contains general surface capabilities.
    DDSCAPS2 ddsCaps;
}

///The DDCAPS structure represents the capabilities of the hardware exposed through the DirectDraw object. This
///structure contains a DDSCAPS2 structure used in this context to describe what kinds of DirectDrawSurface objects can
///be created. It might not be possible to create all the surfaces described by these capabilities simultaneously. This
///structure is used with the IDirectDraw7::GetCaps method. The Ddraw.h header file contains multiple versions of this
///structure (for example, DDCAPS_DX7). For more information about how to determine which version to use, see Remarks.
struct DDCAPS_DX7
{
    ///Size of the structure, in bytes. This member must be initialized before the structure is used.
    uint     dwSize;
    ///This value consists of one or more of the following flags that specify hardware and driver capabilities:
    uint     dwCaps;
    ///This value consists of one or more of the following flags that specify more hardware and driver capabilities:
    uint     dwCaps2;
    ///This value consists of one or more of the following flags that specify color-key capabilities:
    uint     dwCKeyCaps;
    ///This value consists of one or more of the following flags that specify driver stretching and effects
    ///capabilities:
    uint     dwFXCaps;
    ///This value consists of one or more of the following flags that specify driver alpha capabilities:
    uint     dwFXAlphaCaps;
    ///This value consists of one or more of the following flags that specify palette capabilities:
    uint     dwPalCaps;
    ///This value consists of one or more of the following flags that specify stereo-vision capabilities:
    uint     dwSVCaps;
    ///DDBD_2, DDBD_4, or DDBD_8. (Indicate 2, 4, or 8 bits per pixel.)
    uint     dwAlphaBltConstBitDepths;
    ///DDBD_1, DDBD_2, DDBD_4, or DDBD_8. (Indicate 1, 2, 4, or 8 bits per pixel.)
    uint     dwAlphaBltPixelBitDepths;
    ///DDBD_1, DDBD_2, DDBD_4, or DDBD_8. (Indicate 1, 2, 4, or 8 bits per pixel.)
    uint     dwAlphaBltSurfaceBitDepths;
    ///DDBD_2, DDBD_4, or DDBD_8. (Indicate 2, 4, or 8 bits per pixel.)
    uint     dwAlphaOverlayConstBitDepths;
    ///DDBD_1, DDBD_2, DDBD_4, or DDBD_8. (Indicate 1, 2, 4, or 8 bits per pixel.)
    uint     dwAlphaOverlayPixelBitDepths;
    ///DDBD_1, DDBD_2, DDBD_4, or DDBD_8. (Indicate 1, 2, 4, or 8 bits per pixel.)
    uint     dwAlphaOverlaySurfaceBitDepths;
    ///DDBD_8, DDBD_16, DDBD_24, or DDBD_32. (Indicate 8, 16, 24, or 32 bits per pixel.) This member is obsolete for
    ///DirectX 6.0 and later. Use the <b>IDirect3D7::EnumZBufferFormats</b> to retrieve information about supported
    ///depth buffer formats.
    uint     dwZBufferBitDepths;
    ///Total amount of display memory on the device, in bytes, minus memory reserved for the primary surface and any
    ///private data structures reserved by the driver. (This value is the same as the total video memory reported by the
    ///IDirectDraw7::GetAvailableVidMem method.)
    uint     dwVidMemTotal;
    ///Free display memory. This value equals the value in <b>dwVidMemTotal</b>, minus any memory currently allocated by
    ///the application for surfaces. Unlike the IDirectDraw7::GetAvailableVidMem method, which reports the memory
    ///available for a particular type of surface (such as a texture), this value reflects the memory available for any
    ///type of surface.
    uint     dwVidMemFree;
    ///Maximum number of visible overlays or overlay sprites.
    uint     dwMaxVisibleOverlays;
    ///Current number of visible overlays or overlay sprites.
    uint     dwCurrVisibleOverlays;
    ///Number of FourCC codes.
    uint     dwNumFourCCCodes;
    ///Source-rectangle alignment for an overlay surface, in pixels.
    uint     dwAlignBoundarySrc;
    ///Source-rectangle size alignment for an overlay surface, in pixels. Overlay source rectangles must have a pixel
    ///width that is a multiple of this value.
    uint     dwAlignSizeSrc;
    ///Destination-rectangle alignment for an overlay surface, in pixels.
    uint     dwAlignBoundaryDest;
    ///Destination-rectangle size alignment for an overlay surface, in pixels. Overlay destination rectangles must have
    ///a pixel width that is a multiple of this value.
    uint     dwAlignSizeDest;
    ///Stride alignment.
    uint     dwAlignStrideAlign;
    ///Raster operations supported.
    uint[8]  dwRops;
    ///Obsolete. Prior to DirectX 6.0, this member contained general surface capabilities, which are now contained in
    ///the <b>ddsCaps</b> member (a DDSCAPS2 structure).
    DDSCAPS  ddsOldCaps;
    ///Minimum overlay stretch factor, multiplied by 1000. For example, 1.3 = 1300.
    uint     dwMinOverlayStretch;
    ///Maximum overlay stretch factor, multiplied by 1000. For example, 1.3 = 1300.
    uint     dwMaxOverlayStretch;
    ///Obsolete; do not use.
    uint     dwMinLiveVideoStretch;
    ///Obsolete; do not use.
    uint     dwMaxLiveVideoStretch;
    ///Obsolete; do not use.
    uint     dwMinHwCodecStretch;
    ///Obsolete; do not use.
    uint     dwMaxHwCodecStretch;
    ///Reserved
    uint     dwReserved1;
    ///Reserved
    uint     dwReserved2;
    ///Reserved
    uint     dwReserved3;
    ///Driver-specific capabilities for bitblts from system memory to display memory. Valid flags are identical to the
    ///bitblt-related flags that are used with the <b>dwCaps</b> member.
    uint     dwSVBCaps;
    ///Driver color-key capabilities for bitblts from system memory to display memory. Valid flags are identical to the
    ///bitblt-related flags that are used with the <b>dwCKeyCaps</b> member.
    uint     dwSVBCKeyCaps;
    ///Driver FX capabilities for bitblts from system memory to display memory. Valid flags are identical to the
    ///bitblt-related flags that are used with the <b>dwFXCaps</b> member.
    uint     dwSVBFXCaps;
    ///Raster operations supported for bitblts from system memory to display memory.
    uint[8]  dwSVBRops;
    ///Driver-specific capabilities for bitblts from display memory to system memory. Valid flags are identical to the
    ///bitblt-related flags that are used with the <b>dwCaps</b> member.
    uint     dwVSBCaps;
    ///Driver color-key capabilities for bitblts from display memory to system memory. Valid flags are identical to the
    ///bitblt-related flags that are used with the <b>dwCKeyCaps</b> member.
    uint     dwVSBCKeyCaps;
    ///Driver FX capabilities for bitblts from display memory to system memory. Valid flags are identical to the
    ///bitblt-related flags used with the <b>dwFXCaps</b> member.
    uint     dwVSBFXCaps;
    ///Raster operations supported for bitblts from display memory to system memory.
    uint[8]  dwVSBRops;
    ///Driver-specific capabilities for bitblts from system memory to system memory. Valid flags are identical to the
    ///bitblt-related flags used with the <b>dwCaps</b> member.
    uint     dwSSBCaps;
    ///Driver color-key capabilities for bitblts from system memory to system memory. Valid flags are identical to the
    ///bitblt-related flags used with the <b>dwCKeyCaps</b> member.
    uint     dwSSBCKeyCaps;
    ///Driver FX capabilities for bitblts from system memory to system memory. Valid flags are identical to the
    ///bitblt-related flags used with the <b>dwFXCaps</b> member.
    uint     dwSSBFXCaps;
    ///Raster operations supported for bitblts from system memory to system memory.
    uint[8]  dwSSBRops;
    ///Maximum number of live video ports.
    uint     dwMaxVideoPorts;
    ///Current number of live video ports.
    uint     dwCurrVideoPorts;
    ///More driver-specific capabilities for bitblts from system memory to video memory. Valid flags are identical to
    ///the bitblt-related flags used with the <b>dwCaps2</b> member.
    uint     dwSVBCaps2;
    ///Driver-specific capabilities for bitblts from nonlocal to local video memory. Valid flags are identical to the
    ///bitblt-related flags used with the <b>dwCaps</b> member.
    uint     dwNLVBCaps;
    ///More driver-specific capabilities for bitblts from nonlocal to local video memory. Valid flags are identical to
    ///the bitblt-related flags used with the <b>dwCaps2</b> member.
    uint     dwNLVBCaps2;
    ///Driver color-key capabilities for bitblts form nonlocal to local video memory. Valid flags are identical to the
    ///bitblt-related flags used with the <b>dwCKeyCaps</b> member.
    uint     dwNLVBCKeyCaps;
    ///Driver FX capabilities for bitblts from nonlocal to local video memory. Valid flags are identical to the
    ///bitblt-related flags used with the <b>dwFXCaps</b> member.
    uint     dwNLVBFXCaps;
    ///Raster operations supported for bitblts from nonlocal to local video memory.
    uint[8]  dwNLVBRops;
    ///A DDSCAPS2 structure that contains general surface capabilities.
    DDSCAPS2 ddsCaps;
}

///The <b>DDPIXELFORMAT</b> structure describes the pixel format of a DirectDrawSurface object for the
///IDirectDrawSurface7::GetPixelFormat method. <div class="alert"><b>Note</b> Rather than use this structure to decode
///files with the DirectDraw Surface (DDS) file format (.dds), you should use an alternative structure that does not
///rely on Ddraw.h. For more information about alternative structures for DDS, see DDS.</div><div> </div>
struct DDPIXELFORMAT
{
    ///Size of the structure, in bytes. This member must be initialized before the structure is used.
    uint dwSize;
    ///The following flags to describe optional controls for this structure.
    uint dwFlags;
    ///A FourCC code.
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

///The <b>DDOVERLAYFX</b> structure passes overlay information to the IDirectDrawSurface7::UpdateOverlay method.
struct DDOVERLAYFX
{
    ///Size of the structure, in bytes. This member must be initialized before the structure is used.
    uint       dwSize;
    ///Bit depth used to specify the constant for an alpha edge blend.
    uint       dwAlphaEdgeBlendBitDepth;
    ///Constant to use as the alpha for an edge blend.
    uint       dwAlphaEdgeBlend;
    ///Reserved
    uint       dwReserved;
    ///Bit depth used to specify the alpha constant for a destination.
    uint       dwAlphaDestConstBitDepth;
union
    {
        uint               dwAlphaDestConst;
        IDirectDrawSurface lpDDSAlphaDest;
    }
    ///Bit depth used to specify the alpha constant for a source.
    uint       dwAlphaSrcConstBitDepth;
union
    {
        uint               dwAlphaSrcConst;
        IDirectDrawSurface lpDDSAlphaSrc;
    }
    ///Destination color key for the overlay.
    DDCOLORKEY dckDestColorkey;
    ///Source color key for the overlay.
    DDCOLORKEY dckSrcColorkey;
    ///The following flags that specify overlay effects.
    uint       dwDDFX;
    ///Currently not used and must be set to 0.
    uint       dwFlags;
}

///The DDBLTBATCH structure passes bit block transfer (bitblt) operations to the IDirectDrawSurface7::BltBatch method.
struct DDBLTBATCH
{
    ///Address of a RECT structure that defines the destination for the bitblt.
    RECT*              lprDest;
    ///Address of a DirectDrawSurface object to be the source of the bitblt.
    IDirectDrawSurface lpDDSSrc;
    ///Address of a RECT structure that defines the source rectangle of the bitblt.
    RECT*              lprSrc;
    ///Optional control flags. The following values are defined:
    uint               dwFlags;
    DDBLTFX*           lpDDBltFx;
}

///The <b>DDGAMMARAMP</b> structure contains red, green, and blue ramp data for the
///IDirectDrawGammaControl::GetGammaRamp and IDirectDrawGammaControl::SetGammaRamp methods.
struct DDGAMMARAMP
{
    ///Array of 256 WORD elements that describe the red gamma ramp.
    ushort[256] red;
    ///Array of 256 WORD elements that describe the green gamma ramp.
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

///The <b>DDDEVICEIDENTIFIER2</b> structure is passed to the IDirectDraw7::GetDeviceIdentifier method to obtain
///information about a device.
struct DDDEVICEIDENTIFIER2
{
    ///Name of the driver.
    byte[512]     szDriver;
    ///Description of the driver.
    byte[512]     szDescription;
    ///Version of the driver. It is valid to do less than and greater than comparisons on all 64 bits. Caution should be
    ///exercised if you use this element to identify problematic drivers; instead, use the <b>guidDeviceIdentifier</b>
    ///member for this purpose. The data takes the following form: ``` wProduct = HIWORD(liDriverVersion.HighPart)
    ///wVersion = LOWORD(liDriverVersion.HighPart) wSubVersion = HIWORD(liDriverVersion.LowPart) wBuild =
    ///LOWORD(liDriverVersion.LowPart) ```
    LARGE_INTEGER liDriverVersion;
    ///Identifier of the manufacturer. Can be 0 if unknown.
    uint          dwVendorId;
    ///Identifier of the type of chipset. Can be 0 if unknown.
    uint          dwDeviceId;
    ///Identifier of the subsystem. Typically, this means the particular board. Can be 0 if unknown.
    uint          dwSubSysId;
    ///Identifier of the revision level of the chipset. Can be 0 if unknown.
    uint          dwRevision;
    ///Unique identifier for the driver and chipset pair. Use this value if you want to track changes to the driver or
    ///chipset to reprofile the graphics subsystem. It can also be used to identify particular problematic drivers.
    GUID          guidDeviceIdentifier;
    ///The Windows Hardware Quality Lab (WHQL) certification level for the device and driver pair.
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

///This function is superseded by the DirectDrawEnumerateEx function. The <b>DirectDrawEnumerate</b> function enumerates
///the primary DirectDraw display device and a nondisplay device (such as a 3-D accelerator that has no 2-D
///capabilities), if one is installed. The NULL entry always identifies the primary display device shared with the GDI.
///Params:
///    lpCallback = Address of a DDEnumCallback function to be called with a description of each enumerated DirectDraw-enabled
///                 hardware abstraction layer (HAL).
///    lpContext = Address of an application-defined context to be passed to the enumeration callback function each time that it is
///                called.
///Returns:
///    If the function succeeds, the return value is <b>DD_OK</b>. If it fails, the function returns
///    <b>DDERR_INVALIDPARAMS</b>.
///    
@DllImport("DDRAW")
HRESULT DirectDrawEnumerateW(LPDDENUMCALLBACKW lpCallback, void* lpContext);

@DllImport("DDRAW")
HRESULT DirectDrawEnumerateA(LPDDENUMCALLBACKA lpCallback, void* lpContext);

///Enumerates all DirectDraw devices that are installed on the computer. The NULL entry always identifies the primary
///display device that is shared with GDI.
///Params:
///    lpCallback = Address of a DDEnumCallbackEx function to be called with a description of each enumerated DirectDraw-enabled
///                 hardware abstraction layer (HAL).
///    lpContext = Address of an application-defined value to be passed to the enumeration callback function each time that it is
///                called.
///    dwFlags = Flags that specify the enumeration scope. This parameter can be 0 or a combination of the following flags. If the
///              value is 0, the function enumerates only the primary display device.
///Returns:
///    If the function succeeds, the return value is <b>DD_OK</b>. If it fails, the function returns
///    <b>DDERR_INVALIDPARAMS</b>.
///    
@DllImport("DDRAW")
HRESULT DirectDrawEnumerateExW(LPDDENUMCALLBACKEXW lpCallback, void* lpContext, uint dwFlags);

///Enumerates all DirectDraw devices that are installed on the computer. The NULL entry always identifies the primary
///display device that is shared with GDI.
///Params:
///    lpCallback = Address of a DDEnumCallbackEx function to be called with a description of each enumerated DirectDraw-enabled
///                 hardware abstraction layer (HAL).
///    lpContext = Address of an application-defined value to be passed to the enumeration callback function each time that it is
///                called.
///    dwFlags = Flags that specify the enumeration scope. This parameter can be 0 or a combination of the following flags. If the
///              value is 0, the function enumerates only the primary display device.
///Returns:
///    If the function succeeds, the return value is <b>DD_OK</b>. If it fails, the function returns
///    <b>DDERR_INVALIDPARAMS</b>.
///    
@DllImport("DDRAW")
HRESULT DirectDrawEnumerateExA(LPDDENUMCALLBACKEXA lpCallback, void* lpContext, uint dwFlags);

///Creates an instance of a DirectDraw object. A DirectDraw object that is created by using this function does not
///support the complete set of Direct3D interfaces in DirectX 7.0. To create a DirectDraw object that is capable of
///exposing all of the features of Direct3D in DirectX 7.0, use the DirectDrawCreateEx function.
///Params:
///    lpGUID = A pointer to the globally unique identifier (GUID) that represents the driver to be created. This can be NULL to
///             indicate the active display driver, or you can pass one of the following flags to restrict the active display
///             driver's behavior for debugging purposes:
///    lplpDD = A pointer to a variable to be set to a valid <b>IDirectDraw</b> interface pointer if the call succeeds.
///    pUnkOuter = Allows for future compatibility with COM aggregation features. Presently, however, this function returns an error
///                if this parameter is anything but NULL.
///Returns:
///    If the function succeeds, the return value is DD_OK. If it fails, the function can return one of the following
///    error values: <ul> <li>DDERR_DIRECTDRAWALREADYCREATED</li> <li>DDERR_GENERIC</li>
///    <li>DDERR_INVALIDDIRECTDRAWGUID</li> <li>DDERR_INVALIDPARAMS</li> <li>DDERR_NODIRECTDRAWHW</li>
///    <li>DDERR_OUTOFMEMORY</li> </ul>
///    
@DllImport("DDRAW")
HRESULT DirectDrawCreate(GUID* lpGUID, IDirectDraw* lplpDD, IUnknown pUnkOuter);

///Creates an instance of a DirectDraw object that supports the set of Direct3D interfaces in DirectX 7.0. To use the
///features of Direct3D in DirectX 7.0, create a DirectDraw object with this function.
///Params:
///    lpGuid = A pointer to the globally unique identifier (GUID) that represents the driver to be created. This can be NULL to
///             indicate the active display driver, or you can pass one of the following flags to restrict the active display
///             driver's behavior for debugging purposes:
///    lplpDD = A pointer to a variable to be set to a valid IDirectDraw7 interface pointer if the call succeeds.
///    iid = This parameter must be set to IID_IDirectDraw7. This function fails and returns DDERR_INVALIDPARAMS if any other
///          interface is specified.
///    pUnkOuter = Allows for future compatibility with COM aggregation features. Currently, this function returns an error if this
///                parameter is not NULL.
///Returns:
///    If the function succeeds, the return value is DD_OK. If it fails, the function can return one of the following
///    error values: <ul> <li>DDERR_DIRECTDRAWALREADYCREATED</li> <li>DDERR_GENERIC</li>
///    <li>DDERR_INVALIDDIRECTDRAWGUID</li> <li>DDERR_INVALIDPARAMS</li> <li>DDERR_NODIRECTDRAWHW</li>
///    <li>DDERR_OUTOFMEMORY</li> </ul>
///    
@DllImport("DDRAW")
HRESULT DirectDrawCreateEx(GUID* lpGuid, void** lplpDD, const(GUID)* iid, IUnknown pUnkOuter);

///Creates an instance of a DirectDrawClipper object that is not associated with a DirectDraw object.
///Params:
///    dwFlags = Currently not used and must be set to 0.
///    lplpDDClipper = Address of a pointer to be filled with the address of the new DirectDrawClipper object.
///    pUnkOuter = Allows for future compatibility with COM aggregation features. Currently, this function returns an error if this
///                parameter is not NULL.
///Returns:
///    If the function succeeds, the return value is DD_OK. If it fails, the function can return one of the following
///    error values: <ul> <li>DDERR_INVALIDPARAMS</li> <li>DDERR_OUTOFMEMORY</li> </ul>
///    
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

///Applications use the methods of the <b>IDirectDraw7</b> interface to create DirectDraw objects and work with
///system-level variables. This section is a reference to the methods of the <b>IDirectDraw7</b> interface.
interface IDirectDraw7 : IUnknown
{
    ///This method is not currently implemented.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_INVALIDOBJECT</li> <li>DDERR_INVALIDPARAMS</li> <li>DDERR_NOEXCLUSIVEMODE</li>
    ///    <li>DDERR_SURFACEBUSY</li> </ul>
    ///    
    HRESULT Compact();
    ///Creates a DirectDrawClipper object.
    ///Params:
    ///    arg1 = Currently not used and must be set to 0.
    ///    arg2 = Address of a variable to be set to a valid IDirectDrawClipper interface pointer if the call succeeds.
    ///    arg3 = Allows for future compatibility with COM aggregation features. Currently this method returns an error if this
    ///           parameter is not NULL.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_INVALIDOBJECT</li> <li>DDERR_INVALIDPARAMS</li>
    ///    <li>DDERR_NOCOOPERATIVELEVELSET</li> <li>DDERR_OUTOFMEMORY</li> </ul>
    ///    
    HRESULT CreateClipper(uint param0, IDirectDrawClipper* param1, IUnknown param2);
    ///Creates a DirectDrawPalette object for this DirectDraw object.
    ///Params:
    ///    arg1 = This value consists of one or more of the following flags:
    ///    arg2 = Address of an array of 2, 4, 16, or 256 PALETTEENTRY structures to initialize the DirectDrawPalette object.
    ///    arg3 = Address of a variable to be set to a valid IDirectDrawPalette interface pointer if the call succeeds.
    ///    arg4 = Allows for future compatibility with COM aggregation features. Currently, this method returns an error if
    ///           this parameter is not NULL.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_INVALIDOBJECT</li> <li>DDERR_INVALIDPARAMS</li>
    ///    <li>DDERR_NOCOOPERATIVELEVELSET</li> <li>DDERR_OUTOFMEMORY</li> <li>DDERR_UNSUPPORTED</li> </ul>
    ///    
    HRESULT CreatePalette(uint param0, PALETTEENTRY* param1, IDirectDrawPalette* param2, IUnknown param3);
    ///Creates a DirectDrawSurface object for this DirectDraw object.
    ///Params:
    ///    arg1 = Address of a DDSURFACEDESC2 structure that describes the requested surface. Set any unused members of the
    ///           <b>DDSURFACEDESC2</b> structure to 0 before calling this method. A DDSCAPS2 structure is a member of
    ///           <b>DDSURFACEDESC2</b>.
    ///    arg2 = Address of a variable to be set to a valid IDirectDrawSurface7 interface pointer if the call succeeds.
    ///    arg3 = Allows for future compatibility with COM aggregation features. Currently, this method returns an error if
    ///           this parameter is not NULL.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_INCOMPATIBLEPRIMARY</li> <li>DDERR_INVALIDCAPS</li> <li>DDERR_INVALIDOBJECT</li>
    ///    <li>DDERR_INVALIDPARAMS</li> <li>DDERR_INVALIDPIXELFORMAT</li> <li>DDERR_NOALPHAHW</li>
    ///    <li>DDERR_NOCOOPERATIVELEVELSET</li> <li>DDERR_NODIRECTDRAWHW</li> <li>DDERR_NOEMULATION</li>
    ///    <li>DDERR_NOEXCLUSIVEMODE</li> <li>DDERR_NOFLIPHW</li> <li>DDERR_NOMIPMAPHW</li> <li>DDERR_NOOVERLAYHW</li>
    ///    <li>DDERR_NOZBUFFERHW</li> <li>DDERR_OUTOFMEMORY</li> <li>DDERR_OUTOFVIDEOMEMORY</li>
    ///    <li>DDERR_PRIMARYSURFACEALREADYEXISTS</li> <li>DDERR_UNSUPPORTEDMODE</li> </ul>
    ///    
    HRESULT CreateSurface(DDSURFACEDESC2* param0, IDirectDrawSurface7* param1, IUnknown param2);
    ///Duplicates a DirectDrawSurface object.
    ///Params:
    ///    arg1 = Address of the IDirectDrawSurface7 interface for the surface to be duplicated.
    ///    arg2 = Address of a variable to contain an IDirectDrawSurface7 interface pointer for the newly duplicated
    ///           DirectDrawSurface object.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_CANTDUPLICATE</li> <li>DDERR_INVALIDOBJECT</li> <li>DDERR_INVALIDPARAMS</li>
    ///    <li>DDERR_OUTOFMEMORY</li> <li>DDERR_SURFACELOST</li> </ul>
    ///    
    HRESULT DuplicateSurface(IDirectDrawSurface7 param0, IDirectDrawSurface7* param1);
    ///Enumerates all the display modes that the hardware exposes through the DirectDraw object and that are compatible
    ///with a provided surface description.
    ///Params:
    ///    arg1 = This value consists of one or more of the following flags:
    ///    arg2 = Address of a DDSURFACEDESC2 structure to be checked against available modes. If the value of this parameter
    ///           is NULL, all modes are enumerated.
    ///    arg3 = Address of an application-defined structure to be passed to each enumeration member.
    ///    arg4 = Address of the EnumModesCallback2 function that the enumeration procedure calls every time a match is found.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_INVALIDOBJECT</li> <li>DDERR_INVALIDPARAMS</li> </ul>
    ///    
    HRESULT EnumDisplayModes(uint param0, DDSURFACEDESC2* param1, void* param2, LPDDENUMMODESCALLBACK2 param3);
    ///Enumerates all the existing or possible surfaces that meet the specified surface description.
    ///Params:
    ///    arg1 = A combination of one search type flag and one matching flag. The search type flag determines how the method
    ///           searches for matching surfaces; you can search for surfaces that can be created using the description in the
    ///           <i>lpDDSD2</i> parameter or for existing surfaces that already match that description. The matching flag
    ///           determines whether the method enumerates all surfaces, only those that match, or only those that do not match
    ///           the description in the <i>lpDDSD2</i> parameter. <b>Search type flags</b>
    ///    arg2 = Address of a DDSURFACEDESC2 structure that defines the surface of interest. This parameter can be NULL if
    ///           <i>dwFlags</i> includes the DDENUMSURFACES_ALL flag.
    ///    arg3 = Address of an application-defined structure to be passed to each enumeration member.
    ///    arg4 = Address of the EnumSurfacesCallback7 function that the enumeration procedure calls every time a match is
    ///           found.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_INVALIDOBJECT</li> <li>DDERR_INVALIDPARAMS</li> </ul>
    ///    
    HRESULT EnumSurfaces(uint param0, DDSURFACEDESC2* param1, void* param2, LPDDENUMSURFACESCALLBACK7 param3);
    ///Makes the surface that the GDI writes to the primary surface.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_INVALIDOBJECT</li> <li>DDERR_INVALIDPARAMS</li> <li>DDERR_NOTFOUND</li> </ul>
    ///    
    HRESULT FlipToGDISurface();
    ///Retrieves the capabilities of the device driver for the hardware and the hardware emulation layer (HEL).
    ///Params:
    ///    arg1 = A pointer to a DDCAPS structure that receives the capabilities of the hardware, as reported by the device
    ///           driver. Set this parameter to NULL if you do not want to retrieve device driver capabilities.
    ///    arg2 = A pointer to a DDCAPS structure that receives the capabilities of the HEL. Set this parameter to NULL if you
    ///           do not want to retrieve HEL capabilities.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_INVALIDOBJECT</li> <li>DDERR_INVALIDPARAMS</li> </ul> You can set only one of
    ///    the two parameters to NULL to exclude it. If you set both to NULL, the method fails and returns
    ///    DDERR_INVALIDPARAMS.
    ///    
    HRESULT GetCaps(DDCAPS_DX7* param0, DDCAPS_DX7* param1);
    ///Retrieves the current display mode.
    ///Params:
    ///    arg1 = A pointer to a DDSURFACEDESC2 structure that receives a description of the current surface.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_INVALIDOBJECT</li> <li>DDERR_INVALIDPARAMS</li> <li>DDERR_UNSUPPORTEDMODE</li>
    ///    </ul>
    ///    
    HRESULT GetDisplayMode(DDSURFACEDESC2* param0);
    ///Retrieves the four-character codes (FOURCC) that are supported by the DirectDraw object. This method can also
    ///retrieve the number of codes that are supported.
    ///Params:
    ///    arg1 = A pointer to a variable that contains the number of entries that the array specified by <i>lpCodes</i> can
    ///           hold. If the number of entries is too small to accommodate all the codes, <i>lpNumCodes</i> is set to the
    ///           required number, and the array specified by <i>lpCodes</i> is filled with all that fits.
    ///    arg2 = An array of variables to be filled with FOURCCs that are supported by this DirectDraw object. If you specify
    ///           NULL, <i>lpNumCodes</i> is set to the number of supported FOURCCs, and the method returns.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_INVALIDOBJECT</li> <li>DDERR_INVALIDPARAMS</li> </ul>
    ///    
    HRESULT GetFourCCCodes(uint* param0, uint* param1);
    ///Retrieves the DirectDrawSurface object that currently represents the surface memory that GDI is treating as the
    ///primary surface.
    ///Params:
    ///    arg1 = Address of a variable to be filled with a pointer to the IDirectDrawSurface7 interface for the surface that
    ///           currently controls the GDI's primary surface memory.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_INVALIDOBJECT</li> <li>DDERR_INVALIDPARAMS</li> <li>DDERR_NOTFOUND</li> </ul>
    ///    
    HRESULT GetGDISurface(IDirectDrawSurface7* param0);
    ///Retrieves the frequency of the monitor that the DirectDraw object controls.
    ///Params:
    ///    arg1 = A pointer to a variable that receives the monitor frequency, in Hertz (Hz).
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_INVALIDOBJECT</li> <li>DDERR_INVALIDPARAMS</li> <li>DDERR_UNSUPPORTED</li> </ul>
    ///    
    HRESULT GetMonitorFrequency(uint* param0);
    ///Retrieves the scan line that is currently being drawn on the monitor.
    ///Params:
    ///    arg1 = A pointer to a variable that receives the scan line that the display is currently drawing.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_INVALIDOBJECT</li> <li>DDERR_INVALIDPARAMS</li> <li>DDERR_UNSUPPORTED</li>
    ///    <li>DDERR_VERTICALBLANKINPROGRESS</li> </ul>
    ///    
    HRESULT GetScanLine(uint* param0);
    ///Retrieves the status of the vertical blank.
    ///Params:
    ///    arg1 = A pointer to a variable that receives the status of the vertical blank. This parameter is TRUE if a vertical
    ///           blank is occurring, and FALSE otherwise.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_INVALIDOBJECT</li> <li>DDERR_INVALIDPARAMS</li> </ul>
    ///    
    HRESULT GetVerticalBlankStatus(int* param0);
    ///Initializes a DirectDraw object that was created by using the CoCreateInstance COM function.
    ///Params:
    ///    arg1 = A pointer to the globally unique identifier (GUID) that this method uses as the DirectDraw interface
    ///           identifier.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_ALREADYINITIALIZED</li> <li>DDERR_DIRECTDRAWALREADYCREATED</li>
    ///    <li>DDERR_GENERIC</li> <li>DDERR_INVALIDOBJECT</li> <li>DDERR_INVALIDPARAMS</li>
    ///    <li>DDERR_NODIRECTDRAWHW</li> <li>DDERR_NODIRECTDRAWSUPPORT</li> <li>DDERR_OUTOFMEMORY</li> </ul> This method
    ///    is provided for compliance with the Component Object Model (COM). If you already used the DirectDrawCreate
    ///    function to create a DirectDraw object, this method returns DDERR_ALREADYINITIALIZED. If you do not call
    ///    <b>IDirectDraw7::Initialize</b> when you use CoCreateInstance to create a DirectDraw object, any method that
    ///    you call afterward returns DDERR_NOTINITIALIZED.
    ///    
    HRESULT Initialize(GUID* param0);
    ///Resets the mode of the display device hardware for the primary surface to what it was before the
    ///IDirectDraw7::SetDisplayMode method was called. Exclusive-level access is required to use this method.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_GENERIC</li> <li>DDERR_INVALIDOBJECT</li> <li>DDERR_INVALIDPARAMS</li>
    ///    <li>DDERR_LOCKEDSURFACES</li> <li>DDERR_NOEXCLUSIVEMODE</li> </ul>
    ///    
    HRESULT RestoreDisplayMode();
    ///Determines the top-level behavior of the application.
    ///Params:
    ///    arg1 = Window handle used for the application. Set to the calling application's top-level window handle (not a
    ///           handle for any child windows created by the top-level window). This parameter can be NULL when the
    ///           DDSCL_NORMAL flag is specified in the <i>dwFlags</i> parameter.
    ///    arg2 = This value consists of one or more of the following flags:
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_EXCLUSIVEMODEALREADYSET</li> <li>DDERR_HWNDALREADYSET</li>
    ///    <li>DDERR_HWNDSUBCLASSED</li> <li>DDERR_INVALIDOBJECT</li> <li>DDERR_INVALIDPARAMS</li>
    ///    <li>DDERR_OUTOFMEMORY</li> </ul>
    ///    
    HRESULT SetCooperativeLevel(HWND param0, uint param1);
    ///Sets the mode of the display-device hardware.
    ///Params:
    ///    arg1 = Width of the new display mode.
    ///    arg2 = Height of the new display mode.
    ///    arg3 = Bits per pixel (bpp) of the new display mode.
    ///    arg4 = Refresh rate of the new display mode. Set this value to 0 to request the default refresh rate for the driver.
    ///    arg5 = This value consists of flags that describe additional options. Currently, the only valid flag is
    ///           DDSDM_STANDARDVGAMODE, which causes the method to set Mode 13, instead of Mode X 320x200x8 mode. If you are
    ///           setting another resolution, bit depth, or a Mode X mode, do not use this flag; instead, set the parameter to
    ///           0.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_GENERIC</li> <li>DDERR_INVALIDMODE</li> <li>DDERR_INVALIDOBJECT</li>
    ///    <li>DDERR_INVALIDPARAMS</li> <li>DDERR_LOCKEDSURFACES</li> <li>DDERR_NOEXCLUSIVEMODE</li>
    ///    <li>DDERR_SURFACEBUSY</li> <li>DDERR_UNSUPPORTED</li> <li>DDERR_UNSUPPORTEDMODE</li>
    ///    <li>DDERR_WASSTILLDRAWING</li> </ul>
    ///    
    HRESULT SetDisplayMode(uint param0, uint param1, uint param2, uint param3, uint param4);
    ///Helps the application synchronize itself with the vertical-blank interval.
    ///Params:
    ///    arg1 = One of the following flags that indicates how long to wait for the vertical blank:
    ///    arg2 = Handle of the event to be triggered when the vertical blank begins. This parameter is not currently used.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_INVALIDOBJECT</li> <li>DDERR_INVALIDPARAMS</li> <li>DDERR_UNSUPPORTED</li>
    ///    <li>DDERR_WASSTILLDRAWING</li> </ul>
    ///    
    HRESULT WaitForVerticalBlank(uint param0, HANDLE param1);
    ///Retrieves the total amount of display memory available and the amount of display memory currently free for a
    ///given type of surface.
    ///Params:
    ///    arg1 = A pointer to a DDSCAPS2 structure that indicates the hardware capabilities of the proposed surface.
    ///    arg2 = A pointer to a variable that receives the total amount of display memory available, in bytes. The value
    ///           received reflects the total video memory, minus the video memory required for the primary surface and any
    ///           private caches that the display driver reserves.
    ///    arg3 = A pointer to a variable that receives the amount of display memory currently free that can be allocated for a
    ///           surface that matches the capabilities specified by the structure at <i>lpDDSCaps2</i>.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_INVALIDCAPS</li> <li>DDERR_INVALIDOBJECT</li> <li>DDERR_INVALIDPARAMS</li>
    ///    <li>DDERR_NODIRECTDRAWHW</li> </ul>
    ///    
    HRESULT GetAvailableVidMem(DDSCAPS2* param0, uint* param1, uint* param2);
    ///Retrieves the IDirectDrawSurface7 interface for a surface, based on its GDI device context handle.
    ///Params:
    ///    arg1 = Handle of a display device context.
    ///    arg2 = Address of a variable to be filled with a pointer to the IDirectDrawSurface7 interface for the surface if the
    ///           call succeeds.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_GENERIC</li> <li>DDERR_INVALIDPARAMS</li> <li>DDERR_OUTOFMEMORY</li>
    ///    <li>DDERR_NOTFOUND</li> </ul>
    ///    
    HRESULT GetSurfaceFromDC(HDC param0, IDirectDrawSurface7* param1);
    ///Restores all the surfaces that were created for the DirectDraw object, in the order that they were created.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_INVALIDOBJECT</li> <li>DDERR_INVALIDPARAMS</li> </ul>
    ///    
    HRESULT RestoreAllSurfaces();
    ///Reports the current cooperative-level status of the DirectDraw device for a windowed or full-screen application.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK, which indicates that the calling application can continue.
    ///    If it fails, the method can return one of the following error values (see Remarks): <ul>
    ///    <li>DDERR_INVALIDOBJECT</li> <li>DDERR_EXCLUSIVEMODEALREADYSET</li> <li>DDERR_NOEXCLUSIVEMODE</li>
    ///    <li>DDERR_WRONGMODE</li> </ul>
    ///    
    HRESULT TestCooperativeLevel();
    ///Obtains information about the device driver. This method can be used, with caution, to recognize specific
    ///hardware installations to implement workarounds for poor driver or chipset behavior.
    ///Params:
    ///    arg1 = A pointer to a DDDEVICEIDENTIFIER2 structure that receives information about the driver.
    ///    arg2 = This value consists of flags that specify options. The following flag is the only defined flag:
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return DDERR_INVALIDPARAMS.
    ///    
    HRESULT GetDeviceIdentifier(DDDEVICEIDENTIFIER2* param0, uint param1);
    ///Initiates a test to update the system registry with refresh rate information for the current display adapter and
    ///monitor combination. A call to this method is typically followed by calls to IDirectDraw7::EvaluateMode to pass
    ///or fail modes displayed by the test.
    ///Params:
    ///    arg1 = An array of SIZE elements that describe, in terms of screen resolutions, the modes that should be tested.
    ///    arg2 = The number of elements in the array that the <i>lpModesToTest</i> parameter specifies.
    ///    arg3 = Flags that specify options for starting a test. The only flag value that is currently valid is
    ///           DDSMT_ISTESTREQUIRED. When this flag is specified, <b>StartModeTest</b> does not initiate a test, but instead
    ///           returns a value that indicates whether it is possible or necessary to test the resolutions that the
    ///           <i>lpModesToTest</i> and <i>dwNumEntries</i> parameters identify.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_CURRENTLYNOTAVAIL</li> <li>DDERR_INVALIDOBJECT</li> <li>DDERR_INVALIDPARAMS</li>
    ///    <li>DDERR_NOEXCLUSIVEMODE</li> <li>DDERR_NOTFOUND</li> <li>DDERR_TESTFINISHED</li> </ul> When the method is
    ///    called with the DDSMT_ISTESTREQUIRED flag, it can return one of the following values: <ul>
    ///    <li>DDERR_NEWMODE</li> <li>DDERR_NODRIVERSUPPORT</li> <li>DDERR_NOMONITORINFORMATION</li>
    ///    <li>DDERR_TESTFINISHED</li> </ul>
    ///    
    HRESULT StartModeTest(SIZE* param0, uint param1, uint param2);
    ///Used after a call to IDirectDraw7::StartModeTest to pass or fail each mode that the test presents and to step
    ///through the modes until the test is complete.
    ///Params:
    ///    arg1 = One of the following flags that indicate the status of the mode being tested:
    ///    arg2 = A pointer to a variable that receives a value that denotes the seconds that remain before the current mode is
    ///           failed automatically unless it is explicitly passed or failed.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails or on completion, the method can return one of
    ///    the following error values: <ul> <li>DDERR_TESTFINISHED</li> <li>DDERR_NEWMODE</li>
    ///    <li>DDERR_INVALIDOBJECT</li> <li>DDERR_INVALIDPARAMS</li> <li>DDERR_NOTFOUND </li> </ul>
    ///    
    HRESULT EvaluateMode(uint param0, uint* param1);
}

///Applications use the methods of the <b>IDirectDrawPalette</b> interface to create DirectDrawPalette objects and work
///with system-level variables. This section is a reference to the methods of this interface.
interface IDirectDrawPalette : IUnknown
{
    ///Retrieves the capabilities of the palette object.
    ///Params:
    ///    arg1 = A pointer to a variable that receives a value from the <b>dwPalCaps</b> member of the DDCAPS structure that
    ///           defines palette capabilities. This value consists of one or more of the following flags.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_INVALIDOBJECT</li> <li>DDERR_INVALIDPARAMS</li> </ul>
    ///    
    HRESULT GetCaps(uint* param0);
    ///Retrieves palette values from a DirectDrawPalette object.
    ///Params:
    ///    arg1 = Currently not used and must be set to 0.
    ///    arg2 = Start of the entries to be retrieved sequentially.
    ///    arg3 = Number of palette entries that can fit in the array that <i>lpEntries</i> specifies. The colors of the
    ///           palette entries are returned in sequence, from the value of the <i>dwStartingEntry</i> parameter through the
    ///           value of the <i>dwCount</i> parameter minus 1. (These parameters are set by IDirectDrawPalette::SetEntries.)
    ///    arg4 = An array of PALETTEENTRY structures that receives the palette entries from the DirectDrawPalette object. The
    ///           palette entries are 1 byte each if the DDPCAPS_8BITENTRIES flag is set, and 4 bytes otherwise. Each field is
    ///           a color description.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_INVALIDOBJECT</li> <li>DDERR_INVALIDPARAMS</li> <li>DDERR_NOTPALETTIZED</li>
    ///    </ul>
    ///    
    HRESULT GetEntries(uint param0, uint param1, uint param2, PALETTEENTRY* param3);
    ///Initializes the DirectDrawPalette object.
    ///Params:
    ///    arg1 = A pointer to the DirectDraw object to associate with the DirectDrawPalette object.
    ///    arg2 = Currently not used and must be set to 0.
    ///    arg3 = Currently not used and must be set to NULL.
    ///Returns:
    ///    This method returns DDERR_ALREADYINITIALIZED. This method is provided for compliance with the Component
    ///    Object Model (COM). Because the DirectDrawPalette object is initialized when it is created, this method
    ///    always returns DDERR_ALREADYINITIALIZED.
    ///    
    HRESULT Initialize(IDirectDraw param0, uint param1, PALETTEENTRY* param2);
    ///Changes entries in a DirectDrawPalette object immediately.
    ///Params:
    ///    arg1 = Currently not used and must be set to 0.
    ///    arg2 = First entry to be set.
    ///    arg3 = Number of palette entries to be changed.
    ///    arg4 = An array of PALETTEENTRY structures that contains the palette entries that <b>SetEntries</b> uses to change
    ///           the DirectDrawPalette object. The palette entries are 1 byte each if the DDPCAPS_8BITENTRIES flag is set, and
    ///           4 bytes otherwise. Each field is a color description.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_INVALIDOBJECT</li> <li>DDERR_INVALIDPARAMS</li> <li>DDERR_NOPALETTEATTACHED</li>
    ///    <li>DDERR_NOTPALETTIZED</li> <li>DDERR_UNSUPPORTED</li> </ul>
    ///    
    HRESULT SetEntries(uint param0, uint param1, uint param2, PALETTEENTRY* param3);
}

///Applications use the methods of the <b>IDirectDrawClipper</b> interface to manage clip lists. This section is a
///reference to the methods of this interface.
interface IDirectDrawClipper : IUnknown
{
    ///Retrieves a copy of the clip list that is associated with a DirectDrawClipper object. To select a subset of the
    ///clip list, you can pass a rectangle that clips the clip list.
    ///Params:
    ///    arg1 = A pointer to a RECT structure that <b>GetClipList</b> uses to clip the clip list. Set this parameter to NULL
    ///           to retrieve the entire clip list.
    ///    arg2 = A pointer to a RGNDATA structure that receives the resulting copy of the clip list. If this parameter is
    ///           NULL, <b>GetClipList</b> fills the variable at <i>lpdwSize</i> with the number of bytes necessary to hold the
    ///           entire clip list.
    ///    arg3 = A pointer to a variable that receives the size of the resulting clip list. When retrieving the clip list,
    ///           this parameter is the size of the buffer at <i>lpClipList</i>. When <i>lpClipList</i> is NULL, the variable
    ///           at <i>lpdwSize</i> receives the required size of the buffer, in bytes.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_GENERIC</li> <li>DDERR_INVALIDCLIPLIST</li> <li>DDERR_INVALIDOBJECT</li>
    ///    <li>DDERR_INVALIDPARAMS</li> <li>DDERR_NOCLIPLIST</li> <li>DDERR_REGIONTOOSMALL</li> </ul>
    ///    
    HRESULT GetClipList(RECT* param0, RGNDATA* param1, uint* param2);
    ///Retrieves the window handle that was previously associated with this DirectDrawClipper object by the
    ///IDirectDrawClipper::SetHWnd method.
    ///Params:
    ///    arg1 = A pointer to a variable that receives the window handle that was previously associated with this
    ///           DirectDrawClipper object by the IDirectDrawClipper::SetHWnd method.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_INVALIDOBJECT</li> <li>DDERR_INVALIDPARAMS</li> </ul>
    ///    
    HRESULT GetHWnd(HWND* param0);
    ///Initializes a DirectDrawClipper object that was created by using the CoCreateInstance COM function.
    ///Params:
    ///    arg1 = A pointer to the DirectDraw object to associate with the DirectDrawClipper object. If this parameter is set
    ///           to NULL, an independent DirectDrawClipper object is initialized; a call of this type is equivalent to using
    ///           the DirectDrawCreateClipper function.
    ///    arg2 = Currently not used and must be set to 0.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_ALREADYINITIALIZED</li> <li>DDERR_INVALIDPARAMS</li> </ul>
    ///    
    HRESULT Initialize(IDirectDraw param0, uint param1);
    ///Retrieves the status of the clip list if a window handle is associated with a DirectDrawClipper object.
    ///Params:
    ///    arg1 = A pointer to a variable that receives the status of the clip list. This parameter is TRUE if the clip list
    ///           has changed, and FALSE otherwise.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_INVALIDOBJECT</li> <li>DDERR_INVALIDPARAMS</li> </ul>
    ///    
    HRESULT IsClipListChanged(BOOL* param0);
    ///Sets or deletes the clip list that is used by the IDirectDrawSurface7::Blt, IDirectDrawSurface7::BltBatch, and
    ///IDirectDrawSurface7::UpdateOverlay methods on surfaces to which the parent DirectDrawClipper object is attached.
    ///Params:
    ///    arg1 = A pointer to a valid RGNDATA structure for the clip list to set or NULL. If there is an existing clip list
    ///           that is associated with the DirectDrawClipper object and this value is NULL, the clip list is deleted.
    ///    arg2 = Currently not used and must be set to 0.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_CLIPPERISUSINGHWND</li> <li>DDERR_INVALIDCLIPLIST</li>
    ///    <li>DDERR_INVALIDOBJECT</li> <li>DDERR_INVALIDPARAMS</li> <li>DDERR_OUTOFMEMORY</li> </ul>
    ///    
    HRESULT SetClipList(RGNDATA* param0, uint param1);
    ///Sets the window handle that the clipper object uses to obtain clipping information.
    ///Params:
    ///    arg1 = Currently not used and must be set to 0.
    ///    arg2 = Window handle that obtains the clipping information.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_INVALIDCLIPLIST</li> <li>DDERR_INVALIDOBJECT</li> <li>DDERR_INVALIDPARAMS</li>
    ///    <li>DDERR_OUTOFMEMORY</li> </ul>
    ///    
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

///Applications use the methods of the <b>IDirectDrawSurface7</b> interface to create DirectDrawSurface objects and work
///with system-level variables. This section is a reference to the methods of this interface.
interface IDirectDrawSurface7 : IUnknown
{
    ///Attaches the specified z-buffer surface to this surface.
    ///Params:
    ///    arg1 = Address of the IDirectDrawSurface7 interface for the surface to be attached.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_CANNOTATTACHSURFACE</li> <li>DDERR_GENERIC</li> <li>DDERR_INVALIDOBJECT</li>
    ///    <li>DDERR_INVALIDPARAMS</li> <li>DDERR_SURFACEALREADYATTACHED</li> <li>DDERR_SURFACELOST</li>
    ///    <li>DDERR_WASSTILLDRAWING</li> </ul>
    ///    
    HRESULT AddAttachedSurface(IDirectDrawSurface7 param0);
    ///The <b>IDirectDrawSurface7::AddOverlayDirtyRect</b> method is not currently implemented.
    ///Params:
    ///    arg1 = A pointer to a <b>RECT</b> structure for the rectangle to update.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_INVALIDOBJECT</li> <li>DDERR_INVALIDPARAMS</li>
    ///    <li>DDERR_INVALIDSURFACETYPE</li> <li>DDERR_UNSUPPORTED</li> </ul>
    ///    
    HRESULT AddOverlayDirtyRect(RECT* param0);
    ///Performs a bit block transfer (bitblt). This method does not support z-buffering or alpha blending during bitblt
    ///operations.
    ///Params:
    ///    arg1 = A pointer to a <b>RECT</b> structure that defines the upper-left and lower-right points of the rectangle to
    ///           bitblt to on the destination surface. If this parameter is NULL, the entire destination surface is used.
    ///    arg2 = A pointer to the IDirectDrawSurface7 interface for the DirectDrawSurface object that is the source of the
    ///           bitblt.
    ///    arg3 = A pointer to a <b>RECT</b> structure that defines the upper-left and lower-right points of the rectangle to
    ///           bitblt from on the source surface. If this parameter is NULL, the entire source surface is used.
    ///    arg4 = A combination of flags that determine the valid members of the associated DDBLTFX structure, specify
    ///           color-key information, or request special behavior from the method. The following flags are defined:
    ///           <b>Validation flags</b>
    ///    arg5 = A pointer to the DDBLTFX structure for the bitblt.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_GENERIC</li> <li>DDERR_INVALIDCLIPLIST</li> <li>DDERR_INVALIDOBJECT</li>
    ///    <li>DDERR_INVALIDPARAMS</li> <li>DDERR_INVALIDRECT</li> <li>DDERR_NOALPHAHW</li> <li>DDERR_NOBLTHW</li>
    ///    <li>DDERR_NOCLIPLIST</li> <li>DDERR_NODDROPSHW</li> <li>DDERR_NOMIRRORHW</li> <li>DDERR_NORASTEROPHW</li>
    ///    <li>DDERR_NOROTATIONHW</li> <li>DDERR_NOSTRETCHHW</li> <li>DDERR_NOZBUFFERHW</li> <li>DDERR_SURFACEBUSY</li>
    ///    <li>DDERR_SURFACELOST</li> <li>DDERR_UNSUPPORTED</li> <li>DDERR_WASSTILLDRAWING</li> </ul>
    ///    
    HRESULT Blt(RECT* param0, IDirectDrawSurface7 param1, RECT* param2, uint param3, DDBLTFX* param4);
    ///The <b>IDirectDrawSurface7::BltBatch</b> method is not currently implemented.
    ///Params:
    ///    arg1 = A pointer to the first DDBLTBATCH structure that defines the parameters for the bitblt operations.
    ///    arg2 = Number of bitblt operations to be performed.
    ///    arg3 = Currently not used and must be set to 0.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_GENERIC</li> <li>DDERR_INVALIDCLIPLIST</li> <li>DDERR_INVALIDOBJECT</li>
    ///    <li>DDERR_INVALIDPARAMS</li> <li>DDERR_INVALIDRECT</li> <li>DDERR_NOALPHAHW</li> <li>DDERR_NOBLTHW</li>
    ///    <li>DDERR_NOCLIPLIST</li> <li>DDERR_NODDROPSHW</li> <li>DDERR_NOMIRRORHW</li> <li>DDERR_NORASTEROPHW</li>
    ///    <li>DDERR_NOROTATIONHW</li> <li>DDERR_NOSTRETCHHW</li> <li>DDERR_NOZBUFFERHW</li> <li>DDERR_SURFACEBUSY</li>
    ///    <li>DDERR_SURFACELOST</li> <li>DDERR_UNSUPPORTED</li> </ul>
    ///    
    HRESULT BltBatch(DDBLTBATCH* param0, uint param1, uint param2);
    ///Performs a source copy bitblt or transparent bitblt by using a source color key or destination color key.
    ///Params:
    ///    arg1 = The x-coordinate to bitblt to on the destination surface.
    ///    arg2 = The y-coordinate to bitblt to on the destination surface.
    ///    arg3 = A pointer to the IDirectDrawSurface7 interface for the DirectDrawSurface object that is the source of the
    ///           bitblt.
    ///    arg4 = A pointer to a <b>RECT</b> structure that defines the upper-left and lower-right points of the rectangle to
    ///           bitblt from on the source surface.
    ///    arg5 = Type of transfer. The following transfers are defined:
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_EXCEPTION</li> <li>DDERR_GENERIC</li> <li>DDERR_INVALIDOBJECT</li>
    ///    <li>DDERR_INVALIDPARAMS</li> <li>DDERR_INVALIDRECT</li> <li>DDERR_NOBLTHW</li> <li>DDERR_SURFACEBUSY</li>
    ///    <li>DDERR_SURFACELOST</li> <li>DDERR_UNSUPPORTED</li> <li>DDERR_WASSTILLDRAWING</li> </ul>
    ///    
    HRESULT BltFast(uint param0, uint param1, IDirectDrawSurface7 param2, RECT* param3, uint param4);
    ///Detaches one or more attached surfaces.
    ///Params:
    ///    arg1 = Currently not used and must be set to 0.
    ///    arg2 = A pointer to the IDirectDrawSurface7 interface for the DirectDrawSurface object to be detached. If this
    ///           parameter is NULL, all attached surfaces become detached.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_CANNOTDETACHSURFACE</li> <li>DDERR_INVALIDOBJECT</li>
    ///    <li>DDERR_INVALIDPARAMS</li> <li>DDERR_SURFACELOST</li> <li>DDERR_SURFACENOTATTACHED</li> </ul>
    ///    
    HRESULT DeleteAttachedSurface(uint param0, IDirectDrawSurface7 param1);
    ///Enumerates all the surfaces that are attached to this surface.
    ///Params:
    ///    arg1 = Address of the application-defined structure that is passed to the enumeration member every time that it is
    ///           called.
    ///    arg2 = Address of the EnumSurfacesCallback7 function to be called for each surface that is attached to this surface.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_INVALIDOBJECT</li> <li>DDERR_INVALIDPARAMS</li> <li>DDERR_SURFACELOST</li> </ul>
    ///    
    HRESULT EnumAttachedSurfaces(void* param0, LPDDENUMSURFACESCALLBACK7 param1);
    ///Enumerates the overlay surfaces on the specified destination. You can enumerate the overlays in front-to-back or
    ///back-to-front order.
    ///Params:
    ///    arg1 = A value that can be set to one of the following flags:
    ///    arg2 = Address of the user-defined structure to be passed to the callback function for each overlay surface.
    ///    arg3 = Address of the EnumSurfacesCallback7 callback function to be called for each surface to be overlaid on this
    ///           surface.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_INVALIDOBJECT</li> <li>DDERR_INVALIDPARAMS</li> </ul>
    ///    
    HRESULT EnumOverlayZOrders(uint param0, void* param1, LPDDENUMSURFACESCALLBACK7 param2);
    ///Makes the surface memory that is associated with the DDSCAPS_BACKBUFFER surface become associated with the
    ///front-buffer surface.
    ///Params:
    ///    arg1 = A pointer to the IDirectDrawSurface7 interface for an arbitrary surface in the flipping chain. The default
    ///           for this parameter is NULL, in which case DirectDraw cycles through the buffers in the order that they are
    ///           attached to each other. If this parameter is not NULL, DirectDraw flips to the specified surface, instead of
    ///           the next surface in the flipping chain. <b>Flip</b> fails if the specified surface is not a member of the
    ///           flipping chain.
    ///    arg2 = A combination of flags that specify flip options. The following flags are defined:
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_GENERIC</li> <li>DDERR_INVALIDOBJECT</li> <li>DDERR_INVALIDPARAMS</li>
    ///    <li>DDERR_NOFLIPHW</li> <li>DDERR_NOTFLIPPABLE</li> <li>DDERR_SURFACEBUSY</li> <li>DDERR_SURFACELOST</li>
    ///    <li>DDERR_UNSUPPORTED</li> <li>DDERR_WASSTILLDRAWING</li> </ul>
    ///    
    HRESULT Flip(IDirectDrawSurface7 param0, uint param1);
    ///Obtains the attached surface that has the specified capabilities, and increments the reference count of the
    ///retrieved interface.
    ///Params:
    ///    arg1 = A pointer to a DDSCAPS2 structure that indicates the hardware capabilities of the attached surface.
    ///    arg2 = A pointer to a variable to receive a pointer to the retrieved surface's IDirectDrawSurface7 interface. The
    ///           retrieved surface is the one that matches the description, according to the <i>lpDDSCaps</i> parameter.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_INVALIDOBJECT</li> <li>DDERR_INVALIDPARAMS</li> <li>DDERR_NOTFOUND</li>
    ///    <li>DDERR_SURFACELOST</li> </ul>
    ///    
    HRESULT GetAttachedSurface(DDSCAPS2* param0, IDirectDrawSurface7* param1);
    ///Obtains status about a bit block transfer (bitblt) operation.
    ///Params:
    ///    arg1 = A value that can be set to one of the following flags.
    ///Returns:
    ///    If the method succeeds, a bitbltter is present, and the return value is DD_OK. If it fails, the method
    ///    returns DDERR_WASSTILLDRAWING if the bitbltter is busy, DDERR_NOBLTHW if there is no bitbltter, or one of the
    ///    following error values: <ul> <li>DDERR_INVALIDOBJECT</li> <li>DDERR_INVALIDPARAMS</li> <li>DDERR_NOBLTHW</li>
    ///    <li>DDERR_SURFACEBUSY</li> <li>DDERR_SURFACELOST</li> <li>DDERR_UNSUPPORTED</li>
    ///    <li>DDERR_WASSTILLDRAWING</li> </ul>
    ///    
    HRESULT GetBltStatus(uint param0);
    ///Retrieves the capabilities of this surface. These capabilities are not necessarily related to the capabilities of
    ///the display device.
    ///Params:
    ///    arg1 = A pointer to a DDSCAPS2 structure that receives the hardware capabilities of this surface.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_INVALIDOBJECT</li> <li>DDERR_INVALIDPARAMS</li> </ul>
    ///    
    HRESULT GetCaps(DDSCAPS2* param0);
    ///Retrieves the DirectDrawClipper object that is associated with this surface, and increments the reference count
    ///of the returned clipper.
    ///Params:
    ///    arg1 = A pointer to a variable to receive a pointer to the clipper's IDirectDrawClipper interface.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_INVALIDOBJECT</li> <li>DDERR_INVALIDPARAMS</li> <li>DDERR_NOCLIPPERATTACHED</li>
    ///    </ul>
    ///    
    HRESULT GetClipper(IDirectDrawClipper* param0);
    ///Retrieves the color key value for this surface.
    ///Params:
    ///    arg1 = A value that can be set to one of the following flags to specify the color key to retrieve:
    ///    arg2 = A pointer to a DDCOLORKEY structure that receives the current values for the specified color key of the
    ///           DirectDrawSurface object.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_INVALIDOBJECT</li> <li>DDERR_INVALIDPARAMS</li> <li>DDERR_NOCOLORKEY</li>
    ///    <li>DDERR_NOCOLORKEYHW</li> <li>DDERR_SURFACELOST</li> <li>DDERR_UNSUPPORTED</li> </ul>
    ///    
    HRESULT GetColorKey(uint param0, DDCOLORKEY* param1);
    ///Creates a GDI-compatible handle of a device context for this surface.
    ///Params:
    ///    arg1 = A pointer to a variable that receives the handle of the device context for this surface.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_DCALREADYCREATED</li> <li>DDERR_GENERIC</li> <li>DDERR_INVALIDOBJECT</li>
    ///    <li>DDERR_INVALIDPARAMS</li> <li>DDERR_INVALIDSURFACETYPE</li> <li>DDERR_SURFACELOST</li>
    ///    <li>DDERR_UNSUPPORTED</li> <li>DDERR_WASSTILLDRAWING</li> </ul>
    ///    
    HRESULT GetDC(HDC* param0);
    ///Retrieves status about whether this surface has finished its flipping process.
    ///Params:
    ///    arg1 = A value that can be set to one of the following flags:
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return DDERR_WASSTILLDRAWING
    ///    if the surface has not finished its flipping process, or one of the following error values: <ul>
    ///    <li>DDERR_INVALIDOBJECT</li> <li>DDERR_INVALIDPARAMS</li> <li>DDERR_INVALIDSURFACETYPE</li>
    ///    <li>DDERR_SURFACEBUSY</li> <li>DDERR_SURFACELOST</li> <li>DDERR_UNSUPPORTED</li>
    ///    <li>DDERR_WASSTILLDRAWING</li> </ul>
    ///    
    HRESULT GetFlipStatus(uint param0);
    ///Retrieves the display coordinates of this surface. This method is used on a visible, active overlay surface (that
    ///is, a surface that has the DDSCAPS_OVERLAY flag set).
    ///Params:
    ///    arg1 = A pointer to a variable that receives the x- display coordinate of this surface if the call succeeds.
    ///    arg2 = A pointer to a variable that receives the y-display coordinate of this surface if the call succeeds.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_GENERIC</li> <li>DDERR_INVALIDOBJECT</li> <li>DDERR_INVALIDPARAMS</li>
    ///    <li>DDERR_INVALIDPOSITION</li> <li>DDERR_NOOVERLAYDEST</li> <li>DDERR_NOTAOVERLAYSURFACE</li>
    ///    <li>DDERR_OVERLAYNOTVISIBLE</li> <li>DDERR_SURFACELOST</li> </ul>
    ///    
    HRESULT GetOverlayPosition(int* param0, int* param1);
    ///Retrieves the DirectDrawPalette object that is associated with this surface, and increments the reference count
    ///of the returned palette.
    ///Params:
    ///    arg1 = A pointer to a variable to receive a pointer to the palette object's IDirectDrawPalette interface.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_GENERIC</li> <li>DDERR_INVALIDOBJECT</li> <li>DDERR_INVALIDPARAMS</li>
    ///    <li>DDERR_NOEXCLUSIVEMODE</li> <li>DDERR_NOPALETTEATTACHED</li> <li>DDERR_SURFACELOST</li>
    ///    <li>DDERR_UNSUPPORTED</li> </ul>
    ///    
    HRESULT GetPalette(IDirectDrawPalette* param0);
    ///Retrieves the color and pixel format of this surface.
    ///Params:
    ///    arg1 = A pointer to a DDPIXELFORMAT structure that receives a detailed description of the current pixel and color
    ///           space format of this surface.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_INVALIDOBJECT</li> <li>DDERR_INVALIDPARAMS</li>
    ///    <li>DDERR_INVALIDSURFACETYPE</li> </ul>
    ///    
    HRESULT GetPixelFormat(DDPIXELFORMAT* param0);
    ///Retrieves a description of this surface in its current condition.
    ///Params:
    ///    arg1 = A pointer to a DDSURFACEDESC2 structure that receives the current description of this surface. You need only
    ///           initialize this structure's <b>dwSize</b> member to the size, in bytes, of the structure prior to the call;
    ///           no other preparation is required.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_INVALIDOBJECT</li> <li>DDERR_INVALIDPARAMS</li> </ul>
    ///    
    HRESULT GetSurfaceDesc(DDSURFACEDESC2* param0);
    ///Initializes a DirectDrawSurface object.
    ///Params:
    ///    arg1 = A pointer to the DirectDraw object to associate with the DirectDrawSurface object.
    ///    arg2 = A pointer to a DDSURFACEDESC2 structure that describes how to initialize this surface.
    ///Returns:
    ///    This method returns DDERR_ALREADYINITIALIZED. This method is provided for compliance with the Component
    ///    Object Model (COM). Because the DirectDrawSurface object is initialized when it is created, this method
    ///    always returns DDERR_ALREADYINITIALIZED.
    ///    
    HRESULT Initialize(IDirectDraw param0, DDSURFACEDESC2* param1);
    ///Determines whether the surface memory that is associated with a DirectDrawSurface object has been freed.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK because the memory has not been freed. If it fails, the
    ///    method can return one of the following error values: <ul> <li>DDERR_INVALIDOBJECT</li>
    ///    <li>DDERR_INVALIDPARAMS</li> <li>DDERR_SURFACELOST</li> </ul> You can use this method to determine when you
    ///    need to reallocate surface memory. When a DirectDrawSurface object loses its surface memory, most methods
    ///    return DDERR_SURFACELOST and perform no other action.
    ///    
    HRESULT IsLost();
    ///Obtains a pointer to the surface memory.
    ///Params:
    ///    arg1 = A pointer to a <b>RECT</b> structure that identifies the region of the surface that is being locked. If this
    ///           parameter is NULL, the entire surface is locked.
    ///    arg2 = A pointer to a DDSURFACEDESC2 structure that describes relevant details about the surface and that receives
    ///           information about the surface.
    ///    arg3 = A combination of flags that determine how to lock the surface. The following flags are defined:
    ///    arg4 = Handle of the event. This parameter is not currently used and must be set to NULL.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_INVALIDOBJECT</li> <li>DDERR_INVALIDPARAMS</li> <li>DDERR_OUTOFMEMORY</li>
    ///    <li>DDERR_SURFACEBUSY</li> <li>DDERR_SURFACELOST</li> <li>DDERR_WASSTILLDRAWING</li> </ul>
    ///    
    HRESULT Lock(RECT* param0, DDSURFACEDESC2* param1, uint param2, HANDLE param3);
    ///Releases the handle of a device context that was previously obtained by using the IDirectDrawSurface7::GetDC
    ///method.
    ///Params:
    ///    arg1 = The handle of a device context that was previously obtained by IDirectDrawSurface7::GetDC.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_GENERIC</li> <li>DDERR_INVALIDOBJECT</li> <li>DDERR_INVALIDPARAMS</li>
    ///    <li>DDERR_SURFACELOST</li> <li>DDERR_UNSUPPORTED</li> </ul>
    ///    
    HRESULT ReleaseDC(HDC param0);
    ///Restores a surface that has been lost. This occurs when the surface memory that is associated with the
    ///DirectDrawSurface object has been freed.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_GENERIC</li> <li>DDERR_IMPLICITLYCREATED</li> <li>DDERR_INCOMPATIBLEPRIMARY</li>
    ///    <li>DDERR_INVALIDOBJECT</li> <li>DDERR_INVALIDPARAMS</li> <li>DDERR_NOEXCLUSIVEMODE</li>
    ///    <li>DDERR_OUTOFMEMORY</li> <li>DDERR_UNSUPPORTED</li> <li>DDERR_WRONGMODE</li> </ul>
    ///    
    HRESULT Restore();
    ///Attaches a clipper object to, or deletes one from, this surface.
    ///Params:
    ///    arg1 = A pointer to the IDirectDrawClipper interface for the DirectDrawClipper object to be attached to the
    ///           DirectDrawSurface object. If you set this parameter to NULL, the current DirectDrawClipper object is
    ///           detached.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_INVALIDOBJECT</li> <li>DDERR_INVALIDPARAMS</li>
    ///    <li>DDERR_INVALIDSURFACETYPE</li> <li>DDERR_NOCLIPPERATTACHED</li> </ul>
    ///    
    HRESULT SetClipper(IDirectDrawClipper param0);
    ///Sets the color key value for the DirectDrawSurface object if the hardware supports color keys on a per-surface
    ///basis.
    ///Params:
    ///    arg1 = A value that can be set to one of the following flags to specify the requested color key:
    ///    arg2 = A pointer to a DDCOLORKEY structure that contains the new color key values for the DirectDrawSurface object.
    ///           This value can be NULL to remove a previously set color key.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_GENERIC</li> <li>DDERR_INVALIDOBJECT</li> <li>DDERR_INVALIDPARAMS</li>
    ///    <li>DDERR_INVALIDSURFACETYPE</li> <li>DDERR_NOOVERLAYHW</li> <li>DDERR_NOTAOVERLAYSURFACE</li>
    ///    <li>DDERR_SURFACELOST</li> <li>DDERR_UNSUPPORTED</li> <li>DDERR_WASSTILLDRAWING</li> </ul>
    ///    
    HRESULT SetColorKey(uint param0, DDCOLORKEY* param1);
    ///Changes the display coordinates of an overlay surface.
    ///Params:
    ///    arg1 = The new x- display coordinate of this surface.
    ///    arg2 = The new y-display coordinate of this surface.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_GENERIC</li> <li>DDERR_INVALIDOBJECT</li> <li>DDERR_INVALIDPARAMS</li>
    ///    <li>DDERR_INVALIDPOSITION</li> <li>DDERR_NOOVERLAYDEST</li> <li>DDERR_NOTAOVERLAYSURFACE</li>
    ///    <li>DDERR_OVERLAYNOTVISIBLE</li> <li>DDERR_SURFACELOST</li> <li>DDERR_UNSUPPORTED</li> </ul>
    ///    
    HRESULT SetOverlayPosition(int param0, int param1);
    ///Attaches a palette object to (or detaches one from) a surface. The surface uses this palette for all subsequent
    ///operations. The palette change takes place immediately, without regard to refresh timing.
    ///Params:
    ///    arg1 = A pointer to the IDirectDrawPalette interface for the palette object to be used with this surface. If NULL,
    ///           the current palette is detached.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_GENERIC</li> <li>DDERR_INVALIDOBJECT</li> <li>DDERR_INVALIDPARAMS</li>
    ///    <li>DDERR_INVALIDPIXELFORMAT</li> <li>DDERR_INVALIDSURFACETYPE</li> <li>DDERR_NOEXCLUSIVEMODE</li>
    ///    <li>DDERR_NOPALETTEATTACHED</li> <li>DDERR_NOPALETTEHW</li> <li>DDERR_NOT8BITCOLOR</li>
    ///    <li>DDERR_SURFACELOST</li> <li>DDERR_UNSUPPORTED</li> </ul>
    ///    
    HRESULT SetPalette(IDirectDrawPalette param0);
    ///Notifies DirectDraw that the direct surface manipulations are complete.
    ///Params:
    ///    arg1 = A pointer to a <b>RECT</b> structure that was used to lock the surface in the corresponding call to the
    ///           IDirectDrawSurface7::Lock method. This parameter can be NULL only if the entire surface was locked by passing
    ///           NULL in the <i>lpDestRect</i> parameter of the corresponding call to the <b>IDirectDrawSurface7::Lock</b>
    ///           method.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_GENERIC</li> <li>DDERR_INVALIDOBJECT</li> <li>DDERR_INVALIDPARAMS</li>
    ///    <li>DDERR_INVALIDRECT</li> <li>DDERR_NOTLOCKED</li> <li>DDERR_SURFACELOST</li> </ul>
    ///    
    HRESULT Unlock(RECT* param0);
    ///Repositions or modifies the visual attributes of an overlay surface. These surfaces must have the DDSCAPS_OVERLAY
    ///flag set.
    ///Params:
    ///    arg1 = A pointer to a <b>RECT</b> structure that defines the x, y, width, and height of the region on the source
    ///           surface being used as the overlay. This parameter can be NULL to hide an overlay or to indicate that the
    ///           entire overlay surface is to be used and that the overlay surface conforms to any boundary and size-alignment
    ///           restrictions imposed by the device driver.
    ///    arg2 = A pointer to the IDirectDrawSurface7 interface for the DirectDrawSurface object that is being overlaid.
    ///    arg3 = A pointer to a <b>RECT</b> structure that defines the width, x, and height, y, of the region on the
    ///           destination surface that the overlay should be moved to. This parameter can be NULL to hide the overlay.
    ///    arg4 = A combination of the following flags that determine the overlay update:
    ///    arg5 = A pointer to the DDOVERLAYFX structure that describes the effects to be used. Can be NULL if the DDOVER_DDFX
    ///           flag is not specified.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_DEVICEDOESNTOWNSURFACE</li> <li>DDERR_GENERIC</li> <li>DDERR_HEIGHTALIGN</li>
    ///    <li>DDERR_INVALIDOBJECT</li> <li>DDERR_INVALIDPARAMS</li> <li>DDERR_INVALIDRECT</li>
    ///    <li>DDERR_INVALIDSURFACETYPE</li> <li>DDERR_NOSTRETCHHW</li> <li>DDERR_NOTAOVERLAYSURFACE</li>
    ///    <li>DDERR_OUTOFCAPS</li> <li>DDERR_SURFACELOST</li> <li>DDERR_UNSUPPORTED</li> <li>DDERR_XALIGN</li> </ul>
    ///    
    HRESULT UpdateOverlay(RECT* param0, IDirectDrawSurface7 param1, RECT* param2, uint param3, DDOVERLAYFX* param4);
    ///The <b>IDirectDrawSurface7::UpdateOverlayDisplay</b> method is not currently implemented.
    ///Params:
    ///    arg1 = The method is not currently implemented.
    ///Returns:
    ///    The method is not currently implemented.
    ///    
    HRESULT UpdateOverlayDisplay(uint param0);
    ///Sets the z-order of an overlay.
    ///Params:
    ///    arg1 = One of the following flags that determines the z-order of the overlay:
    ///    arg2 = A pointer to the IDirectDrawSurface7 interface for the DirectDraw surface to be used as a relative position
    ///           in the overlay chain. This parameter is needed only for the DDOVERZ_INSERTINBACKOF and
    ///           DDOVERZ_INSERTINFRONTOF flags.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_INVALIDOBJECT</li> <li>DDERR_INVALIDPARAMS</li>
    ///    <li>DDERR_NOTAOVERLAYSURFACE</li> </ul>
    ///    
    HRESULT UpdateOverlayZOrder(uint param0, IDirectDrawSurface7 param1);
    ///Retrieves an interface to the DirectDraw object that was used to create this surface.
    ///Params:
    ///    arg1 = A pointer to a variable that receives a valid interface pointer if the call succeeds. Cast this pointer to an
    ///           IUnknown interface pointer; then query for the IDirectDraw7 interface.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_INVALIDOBJECT</li> <li>DDERR_INVALIDPARAMS</li> </ul>
    ///    
    HRESULT GetDDInterface(void** param0);
    ///Prevents a system-memory surface from being paged out while a bit block transfer (bitblt) operation that uses
    ///direct memory access (DMA) transfers to or from system memory is in progress.
    ///Params:
    ///    arg1 = Currently not used and must be set to 0.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_CANTPAGELOCK</li> <li>DDERR_INVALIDOBJECT</li> <li>DDERR_INVALIDPARAMS</li>
    ///    <li>DDERR_SURFACELOST</li> </ul>
    ///    
    HRESULT PageLock(uint param0);
    ///Unlocks a system-memory surface, which then allows it to be paged out.
    ///Params:
    ///    arg1 = Currently not used and must be set to 0.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_CANTPAGEUNLOCK</li> <li>DDERR_INVALIDOBJECT</li> <li>DDERR_INVALIDPARAMS</li>
    ///    <li>DDERR_NOTPAGELOCKED</li> <li>DDERR_SURFACELOST</li> </ul>
    ///    
    HRESULT PageUnlock(uint param0);
    ///Sets the characteristics of an existing surface.
    ///Params:
    ///    arg1 = A pointer to a DDSURFACEDESC2 structure that contains the new surface characteristics.
    ///    arg2 = Currently not used and must be set to 0.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_INVALIDPARAMS</li> <li>DDERR_INVALIDOBJECT</li> <li>DDERR_SURFACELOST</li>
    ///    <li>DDERR_SURFACEBUSY</li> <li>DDERR_INVALIDSURFACETYPE</li> <li>DDERR_INVALIDPIXELFORMAT</li>
    ///    <li>DDERR_INVALIDCAPS</li> <li>DDERR_UNSUPPORTED</li> <li>DDERR_GENERIC</li> </ul>
    ///    
    HRESULT SetSurfaceDesc(DDSURFACEDESC2* param0, uint param1);
    ///Associates data with the surface that is intended for use by the application, not by DirectDraw. Data is passed
    ///by value, and multiple sets of data can be associated with a single surface.
    ///Params:
    ///    arg1 = Reference to (C++) or address of (C) the globally unique identifier that identifies the private data to be
    ///           set.
    ///    arg2 = A pointer to a buffer that contains the data to be associated with the surface.
    ///    arg3 = The size value of the buffer at <i>lpData</i>, in bytes.
    ///    arg4 = A value that can be set to one of the following flags. These flags describe the type of data being passed or
    ///           request that the data be invalidated when the surface changes.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_INVALIDOBJECT</li> <li>DDERR_INVALIDPARAMS</li> <li>DDERR_OUTOFMEMORY</li> </ul>
    ///    
    HRESULT SetPrivateData(const(GUID)* param0, void* param1, uint param2, uint param3);
    ///Copies the private data that is associated with this surface to a provided buffer.
    ///Params:
    ///    arg1 = Reference to (C++) or address of (C) the globally unique identifier that identifies the private data to be
    ///           retrieved.
    ///    arg2 = A pointer to a previously allocated buffer that receives the requested private data if the call succeeds. The
    ///           application that calls this method must allocate and release this buffer.
    ///    arg3 = A pointer to a variable that contains the size value of the buffer at <i>lpBuffer</i>, in bytes. If this
    ///           value is less than the actual size of the private data (such as 0), <b>GetPrivateData</b> sets the variable
    ///           to the required buffer size, and then returns DDERR_MOREDATA.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_EXPIRED</li> <li>DDERR_INVALIDOBJECT</li> <li>DDERR_INVALIDPARAMS</li>
    ///    <li>DDERR_MOREDATA</li> <li>DDERR_NOTFOUND</li> <li>DDERR_OUTOFMEMORY</li> </ul>
    ///    
    HRESULT GetPrivateData(const(GUID)* param0, void* param1, uint* param2);
    ///Frees the specified private data that is associated with this surface.
    ///Params:
    ///    arg1 = Reference to (C++) or address of (C) the globally unique identifier that identifies the private data to be
    ///           freed.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_INVALIDOBJECT</li> <li>DDERR_INVALIDPARAMS</li> <li>DDERR_NOTFOUND</li> </ul>
    ///    
    HRESULT FreePrivateData(const(GUID)* param0);
    ///Retrieves the current uniqueness value for this surface.
    ///Params:
    ///    arg1 = A pointer to a variable that receives the surface's current uniqueness value if the call succeeds.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_INVALIDOBJECT</li> <li>DDERR_INVALIDPARAMS</li> </ul>
    ///    
    HRESULT GetUniquenessValue(uint* param0);
    ///Manually updates the uniqueness value for this surface.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_EXCEPTION</li> <li>DDERR_INVALIDOBJECT</li> <li>DDERR_INVALIDPARAMS</li> </ul>
    ///    
    HRESULT ChangeUniquenessValue();
    ///Assigns the texture-management priority for this texture. This method succeeds only on managed textures.
    ///Params:
    ///    arg1 = A value that specifies the new texture-management priority for the texture.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the return value is an error. The method
    ///    returns DDERR_INVALIDOBJECT if the parameter is invalid or if the texture is not managed by Direct3D.
    ///    
    HRESULT SetPriority(uint param0);
    ///Retrieves the texture-management priority for this texture. This method succeeds only on managed textures.
    ///Params:
    ///    arg1 = A pointer to a variable that receives the texture priority if the call succeeds.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the return value is an error. The method
    ///    returns DDERR_INVALIDOBJECT if the parameter is invalid or if the texture is not managed by Direct3D.
    ///    
    HRESULT GetPriority(uint* param0);
    ///Sets the maximum level of detail (LOD) for a managed mipmap surface. This method succeeds only on managed
    ///textures.
    ///Params:
    ///    arg1 = The maximum LOD value to be set for the mipmap chain if the call succeeds.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_INVALIDOBJECT</li> <li>DDERR_INVALIDPARAMS</li> </ul>
    ///    
    HRESULT SetLOD(uint param0);
    ///Retrieves the maximum level of detail (LOD) currently set for a managed mipmap surface. This method succeeds only
    ///on managed textures.
    ///Params:
    ///    arg1 = A pointer to a variable that receives the maximum LOD value if the call succeeds.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_INVALIDOBJECT</li> <li>DDERR_INVALIDPARAMS</li> </ul>
    ///    
    HRESULT GetLOD(uint* param0);
}

///Applications use the methods of the <b>IDirectDrawColorControl</b> interface to get and set color controls.
interface IDirectDrawColorControl : IUnknown
{
    ///Retrieves the current color-control settings that are associated with an overlay or a primary surface.
    ///Params:
    ///    arg1 = A pointer to a DDCOLORCONTROL structure that receives the current control settings.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_INVALIDOBJECT</li> <li>DDERR_INVALIDPARAMS</li> <li>DDERR_UNSUPPORTED</li> </ul>
    ///    
    HRESULT GetColorControls(DDCOLORCONTROL* param0);
    ///Sets the color-control options for an overlay or a primary surface.
    ///Params:
    ///    arg1 = A pointer to a DDCOLORCONTROL structure that contains the new control settings to apply.
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_INVALIDOBJECT</li> <li>DDERR_INVALIDPARAMS</li> <li>DDERR_UNSUPPORTED</li> </ul>
    ///    
    HRESULT SetColorControls(DDCOLORCONTROL* param0);
}

///Applications use the methods of the <b>IDirectDrawGammaControl</b> interface to adjust the red, green, and blue gamma
///ramp levels of the primary surface. This section is a reference to the methods of this interface.
interface IDirectDrawGammaControl : IUnknown
{
    ///Retrieves the red, green, and blue gamma ramps for the primary surface.
    ///Params:
    ///    arg1 = Currently not used and must be set to 0.
    ///    arg2 = A pointer to a DDGAMMARAMP structure that receives the current red, green, and blue gamma ramps. Each array
    ///           maps color values in the frame buffer to the color values to be passed to the digital-to-analog converter
    ///           (DAC).
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_EXCEPTION</li> <li>DDERR_INVALIDOBJECT</li> <li>DDERR_INVALIDPARAMS</li> </ul>
    ///    
    HRESULT GetGammaRamp(uint param0, DDGAMMARAMP* param1);
    ///Sets the red, green, and blue gamma ramps for the primary surface.
    ///Params:
    ///    arg1 = Flag that indicates whether gamma calibration is required. Set this parameter to DDSGR_CALIBRATE to request
    ///           that the calibrator adjust the gamma ramp according to the physical properties of the display, which makes
    ///           the result identical on all computers. If calibration is not needed, set this parameter to 0.
    ///    arg2 = A pointer to a DDGAMMARAMP structure that contains the new red, green, and blue gamma ramp entries. Each
    ///           array maps color values in the frame buffer to the color values to be passed to the digital-to-analog
    ///           converter (DAC).
    ///Returns:
    ///    If the method succeeds, the return value is DD_OK. If it fails, the method can return one of the following
    ///    error values: <ul> <li>DDERR_EXCEPTION</li> <li>DDERR_INVALIDOBJECT</li> <li>DDERR_INVALIDPARAMS</li>
    ///    <li>DDERR_OUTOFMEMORY</li> </ul>
    ///    
    HRESULT SetGammaRamp(uint param0, DDGAMMARAMP* param1);
}


