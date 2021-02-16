module windows.displaydevices;

public import windows.core;
public import windows.com : HRESULT, IUnknown;
public import windows.coreaudio : DDVIDEOPORTCONNECT;
public import windows.direct2d : PALETTEENTRY;
public import windows.directdraw : DDARGB, DDBLTFX, DDCOLORCONTROL, DDOVERLAYFX, DDPIXELFORMAT, DDSCAPS, DDSCAPS2,
                                   DDSCAPSEX, DDSURFACEDESC;
public import windows.directshow : DDCOLORKEY;
public import windows.gdi : BLENDFUNCTION, COLORADJUSTMENT, HBITMAP, HPALETTE, PANOSE, TRIVERTEX;
public import windows.kernel : LUID;
public import windows.shell : LOGFONTW;
public import windows.systemservices : BOOL, DDNTCORECAPS, DD_DESTROYDDLOCALDATA, DHPDEV__, DHSURF__, FLOAT_LONG,
                                       FREEOBJPROC, HANDLE, HDEV__, HSEMAPHORE__, HSURF__, LARGE_INTEGER,
                                       PDD_ALPHABLT, PDD_DESTROYDRIVER, PDD_SETCOLORKEY, PDD_SETMODE,
                                       PDD_SURFCB_SETCLIPLIST, PFN, POINTE, POINTFIX, POINTQF, RECTFX, XFORMOBJ;
public import windows.windowsprogramming : DDRAWI_DIRECTDRAW_GBL, DDRAWI_DIRECTDRAW_LCL, LPDDHAL_WAITFORVERTICALBLANK;

extern(Windows):


// Enums


enum : int
{
    DISPLAYCONFIG_OUTPUT_TECHNOLOGY_OTHER                = 0xffffffff,
    DISPLAYCONFIG_OUTPUT_TECHNOLOGY_HD15                 = 0x00000000,
    DISPLAYCONFIG_OUTPUT_TECHNOLOGY_SVIDEO               = 0x00000001,
    DISPLAYCONFIG_OUTPUT_TECHNOLOGY_COMPOSITE_VIDEO      = 0x00000002,
    DISPLAYCONFIG_OUTPUT_TECHNOLOGY_COMPONENT_VIDEO      = 0x00000003,
    DISPLAYCONFIG_OUTPUT_TECHNOLOGY_DVI                  = 0x00000004,
    DISPLAYCONFIG_OUTPUT_TECHNOLOGY_HDMI                 = 0x00000005,
    DISPLAYCONFIG_OUTPUT_TECHNOLOGY_LVDS                 = 0x00000006,
    DISPLAYCONFIG_OUTPUT_TECHNOLOGY_D_JPN                = 0x00000008,
    DISPLAYCONFIG_OUTPUT_TECHNOLOGY_SDI                  = 0x00000009,
    DISPLAYCONFIG_OUTPUT_TECHNOLOGY_DISPLAYPORT_EXTERNAL = 0x0000000a,
    DISPLAYCONFIG_OUTPUT_TECHNOLOGY_DISPLAYPORT_EMBEDDED = 0x0000000b,
    DISPLAYCONFIG_OUTPUT_TECHNOLOGY_UDI_EXTERNAL         = 0x0000000c,
    DISPLAYCONFIG_OUTPUT_TECHNOLOGY_UDI_EMBEDDED         = 0x0000000d,
    DISPLAYCONFIG_OUTPUT_TECHNOLOGY_SDTVDONGLE           = 0x0000000e,
    DISPLAYCONFIG_OUTPUT_TECHNOLOGY_MIRACAST             = 0x0000000f,
    DISPLAYCONFIG_OUTPUT_TECHNOLOGY_INDIRECT_WIRED       = 0x00000010,
    DISPLAYCONFIG_OUTPUT_TECHNOLOGY_INDIRECT_VIRTUAL     = 0x00000011,
    DISPLAYCONFIG_OUTPUT_TECHNOLOGY_INTERNAL             = 0x80000000,
    DISPLAYCONFIG_OUTPUT_TECHNOLOGY_FORCE_UINT32         = 0xffffffff,
}
alias DISPLAYCONFIG_VIDEO_OUTPUT_TECHNOLOGY = int;

enum : int
{
    DISPLAYCONFIG_SCANLINE_ORDERING_UNSPECIFIED                = 0x00000000,
    DISPLAYCONFIG_SCANLINE_ORDERING_PROGRESSIVE                = 0x00000001,
    DISPLAYCONFIG_SCANLINE_ORDERING_INTERLACED                 = 0x00000002,
    DISPLAYCONFIG_SCANLINE_ORDERING_INTERLACED_UPPERFIELDFIRST = 0x00000002,
    DISPLAYCONFIG_SCANLINE_ORDERING_INTERLACED_LOWERFIELDFIRST = 0x00000003,
    DISPLAYCONFIG_SCANLINE_ORDERING_FORCE_UINT32               = 0xffffffff,
}
alias DISPLAYCONFIG_SCANLINE_ORDERING = int;

enum : int
{
    DISPLAYCONFIG_SCALING_IDENTITY               = 0x00000001,
    DISPLAYCONFIG_SCALING_CENTERED               = 0x00000002,
    DISPLAYCONFIG_SCALING_STRETCHED              = 0x00000003,
    DISPLAYCONFIG_SCALING_ASPECTRATIOCENTEREDMAX = 0x00000004,
    DISPLAYCONFIG_SCALING_CUSTOM                 = 0x00000005,
    DISPLAYCONFIG_SCALING_PREFERRED              = 0x00000080,
    DISPLAYCONFIG_SCALING_FORCE_UINT32           = 0xffffffff,
}
alias DISPLAYCONFIG_SCALING = int;

enum : int
{
    DISPLAYCONFIG_ROTATION_IDENTITY     = 0x00000001,
    DISPLAYCONFIG_ROTATION_ROTATE90     = 0x00000002,
    DISPLAYCONFIG_ROTATION_ROTATE180    = 0x00000003,
    DISPLAYCONFIG_ROTATION_ROTATE270    = 0x00000004,
    DISPLAYCONFIG_ROTATION_FORCE_UINT32 = 0xffffffff,
}
alias DISPLAYCONFIG_ROTATION = int;

enum : int
{
    DISPLAYCONFIG_MODE_INFO_TYPE_SOURCE        = 0x00000001,
    DISPLAYCONFIG_MODE_INFO_TYPE_TARGET        = 0x00000002,
    DISPLAYCONFIG_MODE_INFO_TYPE_DESKTOP_IMAGE = 0x00000003,
    DISPLAYCONFIG_MODE_INFO_TYPE_FORCE_UINT32  = 0xffffffff,
}
alias DISPLAYCONFIG_MODE_INFO_TYPE = int;

enum : int
{
    DISPLAYCONFIG_PIXELFORMAT_8BPP         = 0x00000001,
    DISPLAYCONFIG_PIXELFORMAT_16BPP        = 0x00000002,
    DISPLAYCONFIG_PIXELFORMAT_24BPP        = 0x00000003,
    DISPLAYCONFIG_PIXELFORMAT_32BPP        = 0x00000004,
    DISPLAYCONFIG_PIXELFORMAT_NONGDI       = 0x00000005,
    DISPLAYCONFIG_PIXELFORMAT_FORCE_UINT32 = 0xffffffff,
}
alias DISPLAYCONFIG_PIXELFORMAT = int;

enum : int
{
    DISPLAYCONFIG_TOPOLOGY_INTERNAL     = 0x00000001,
    DISPLAYCONFIG_TOPOLOGY_CLONE        = 0x00000002,
    DISPLAYCONFIG_TOPOLOGY_EXTEND       = 0x00000004,
    DISPLAYCONFIG_TOPOLOGY_EXTERNAL     = 0x00000008,
    DISPLAYCONFIG_TOPOLOGY_FORCE_UINT32 = 0xffffffff,
}
alias DISPLAYCONFIG_TOPOLOGY_ID = int;

enum : int
{
    DISPLAYCONFIG_DEVICE_INFO_GET_SOURCE_NAME                = 0x00000001,
    DISPLAYCONFIG_DEVICE_INFO_GET_TARGET_NAME                = 0x00000002,
    DISPLAYCONFIG_DEVICE_INFO_GET_TARGET_PREFERRED_MODE      = 0x00000003,
    DISPLAYCONFIG_DEVICE_INFO_GET_ADAPTER_NAME               = 0x00000004,
    DISPLAYCONFIG_DEVICE_INFO_SET_TARGET_PERSISTENCE         = 0x00000005,
    DISPLAYCONFIG_DEVICE_INFO_GET_TARGET_BASE_TYPE           = 0x00000006,
    DISPLAYCONFIG_DEVICE_INFO_GET_SUPPORT_VIRTUAL_RESOLUTION = 0x00000007,
    DISPLAYCONFIG_DEVICE_INFO_SET_SUPPORT_VIRTUAL_RESOLUTION = 0x00000008,
    DISPLAYCONFIG_DEVICE_INFO_GET_ADVANCED_COLOR_INFO        = 0x00000009,
    DISPLAYCONFIG_DEVICE_INFO_SET_ADVANCED_COLOR_STATE       = 0x0000000a,
    DISPLAYCONFIG_DEVICE_INFO_GET_SDR_WHITE_LEVEL            = 0x0000000b,
    DISPLAYCONFIG_DEVICE_INFO_FORCE_UINT32                   = 0xffffffff,
}
alias DISPLAYCONFIG_DEVICE_INFO_TYPE = int;

// Callbacks

alias PDD_CANCREATESURFACE = uint function(DD_CANCREATESURFACEDATA* param0);
alias PDD_WAITFORVERTICALBLANK = uint function(DD_WAITFORVERTICALBLANKDATA* param0);
alias PDD_CREATESURFACE = uint function(DD_CREATESURFACEDATA* param0);
alias PDD_CREATEPALETTE = uint function(DD_CREATEPALETTEDATA* param0);
alias PDD_GETSCANLINE = uint function(DD_GETSCANLINEDATA* param0);
alias PDD_MAPMEMORY = uint function(DD_MAPMEMORYDATA* param0);
alias PDD_GETDRIVERINFO = uint function(DD_GETDRIVERINFODATA* param0);
alias PDD_GETAVAILDRIVERMEMORY = uint function(DD_GETAVAILDRIVERMEMORYDATA* param0);
alias PDD_CREATESURFACEEX = uint function(DD_CREATESURFACEEXDATA* param0);
alias PDD_GETDRIVERSTATE = uint function(DD_GETDRIVERSTATEDATA* param0);
alias PDD_DESTROYDDLOCAL = uint function(DD_DESTROYDDLOCALDATA* param0);
alias PDD_FREEDRIVERMEMORY = uint function(DD_FREEDRIVERMEMORYDATA* param0);
alias PDD_SETEXCLUSIVEMODE = uint function(DD_SETEXCLUSIVEMODEDATA* param0);
alias PDD_FLIPTOGDISURFACE = uint function(DD_FLIPTOGDISURFACEDATA* param0);
alias PDD_PALCB_DESTROYPALETTE = uint function(DD_DESTROYPALETTEDATA* param0);
alias PDD_PALCB_SETENTRIES = uint function(DD_SETENTRIESDATA* param0);
alias PDD_SURFCB_LOCK = uint function(DD_LOCKDATA* param0);
alias PDD_SURFCB_UNLOCK = uint function(DD_UNLOCKDATA* param0);
alias PDD_SURFCB_BLT = uint function(DD_BLTDATA* param0);
alias PDD_SURFCB_UPDATEOVERLAY = uint function(DD_UPDATEOVERLAYDATA* param0);
alias PDD_SURFCB_SETOVERLAYPOSITION = uint function(DD_SETOVERLAYPOSITIONDATA* param0);
alias PDD_SURFCB_SETPALETTE = uint function(DD_SETPALETTEDATA* param0);
alias PDD_SURFCB_FLIP = uint function(DD_FLIPDATA* param0);
alias PDD_SURFCB_DESTROYSURFACE = uint function(DD_DESTROYSURFACEDATA* param0);
alias PDD_SURFCB_ADDATTACHEDSURFACE = uint function(DD_ADDATTACHEDSURFACEDATA* param0);
alias PDD_SURFCB_SETCOLORKEY = uint function(DD_SETCOLORKEYDATA* param0);
alias PDD_SURFCB_GETBLTSTATUS = uint function(DD_GETBLTSTATUSDATA* param0);
alias PDD_SURFCB_GETFLIPSTATUS = uint function(DD_GETFLIPSTATUSDATA* param0);
alias PDD_VPORTCB_CANCREATEVIDEOPORT = uint function(DD_CANCREATEVPORTDATA* param0);
alias PDD_VPORTCB_CREATEVIDEOPORT = uint function(DD_CREATEVPORTDATA* param0);
alias PDD_VPORTCB_FLIP = uint function(DD_FLIPVPORTDATA* param0);
alias PDD_VPORTCB_GETBANDWIDTH = uint function(DD_GETVPORTBANDWIDTHDATA* param0);
alias PDD_VPORTCB_GETINPUTFORMATS = uint function(DD_GETVPORTINPUTFORMATDATA* param0);
alias PDD_VPORTCB_GETOUTPUTFORMATS = uint function(DD_GETVPORTOUTPUTFORMATDATA* param0);
alias PDD_VPORTCB_GETFIELD = uint function(DD_GETVPORTFIELDDATA* param0);
alias PDD_VPORTCB_GETLINE = uint function(DD_GETVPORTLINEDATA* param0);
alias PDD_VPORTCB_GETVPORTCONNECT = uint function(DD_GETVPORTCONNECTDATA* param0);
alias PDD_VPORTCB_DESTROYVPORT = uint function(DD_DESTROYVPORTDATA* param0);
alias PDD_VPORTCB_GETFLIPSTATUS = uint function(DD_GETVPORTFLIPSTATUSDATA* param0);
alias PDD_VPORTCB_UPDATE = uint function(DD_UPDATEVPORTDATA* param0);
alias PDD_VPORTCB_WAITFORSYNC = uint function(DD_WAITFORVPORTSYNCDATA* param0);
alias PDD_VPORTCB_GETSIGNALSTATUS = uint function(DD_GETVPORTSIGNALDATA* param0);
alias PDD_VPORTCB_COLORCONTROL = uint function(DD_VPORTCOLORDATA* param0);
alias PDD_COLORCB_COLORCONTROL = uint function(DD_COLORCONTROLDATA* param0);
alias PDD_KERNELCB_SYNCSURFACE = uint function(DD_SYNCSURFACEDATA* param0);
alias PDD_KERNELCB_SYNCVIDEOPORT = uint function(DD_SYNCVIDEOPORTDATA* param0);
alias PDD_MOCOMPCB_GETGUIDS = uint function(DD_GETMOCOMPGUIDSDATA* param0);
alias PDD_MOCOMPCB_GETFORMATS = uint function(DD_GETMOCOMPFORMATSDATA* param0);
alias PDD_MOCOMPCB_CREATE = uint function(DD_CREATEMOCOMPDATA* param0);
alias PDD_MOCOMPCB_GETCOMPBUFFINFO = uint function(DD_GETMOCOMPCOMPBUFFDATA* param0);
alias PDD_MOCOMPCB_GETINTERNALINFO = uint function(DD_GETINTERNALMOCOMPDATA* param0);
alias PDD_MOCOMPCB_BEGINFRAME = uint function(DD_BEGINMOCOMPFRAMEDATA* param0);
alias PDD_MOCOMPCB_ENDFRAME = uint function(DD_ENDMOCOMPFRAMEDATA* param0);
alias PDD_MOCOMPCB_RENDER = uint function(DD_RENDERMOCOMPDATA* param0);
alias PDD_MOCOMPCB_QUERYSTATUS = uint function(DD_QUERYMOCOMPSTATUSDATA* param0);
alias PDD_MOCOMPCB_DESTROY = uint function(DD_DESTROYMOCOMPDATA* param0);
alias PFN_DrvQueryGlyphAttrs = FD_GLYPHATTR* function(FONTOBJ* param0, uint param1);

// Structs


struct DEVMODEW
{
    ushort[32] dmDeviceName;
    ushort     dmSpecVersion;
    ushort     dmDriverVersion;
    ushort     dmSize;
    ushort     dmDriverExtra;
    uint       dmFields;
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
    short      dmColor;
    short      dmDuplex;
    short      dmYResolution;
    short      dmTTOption;
    short      dmCollate;
    ushort[32] dmFormName;
    ushort     dmLogPixels;
    uint       dmBitsPerPel;
    uint       dmPelsWidth;
    uint       dmPelsHeight;
    union
    {
        uint dmDisplayFlags;
        uint dmNup;
    }
    uint       dmDisplayFrequency;
    uint       dmICMMethod;
    uint       dmICMIntent;
    uint       dmMediaType;
    uint       dmDitherType;
    uint       dmReserved1;
    uint       dmReserved2;
    uint       dmPanningWidth;
    uint       dmPanningHeight;
}

struct DISPLAYCONFIG_RATIONAL
{
    uint Numerator;
    uint Denominator;
}

struct DISPLAYCONFIG_2DREGION
{
    uint cx;
    uint cy;
}

struct DISPLAYCONFIG_VIDEO_SIGNAL_INFO
{
    ulong pixelRate;
    DISPLAYCONFIG_RATIONAL hSyncFreq;
    DISPLAYCONFIG_RATIONAL vSyncFreq;
    DISPLAYCONFIG_2DREGION activeSize;
    DISPLAYCONFIG_2DREGION totalSize;
    union
    {
        struct AdditionalSignalInfo
        {
            uint _bitfield28;
        }
        uint videoStandard;
    }
    DISPLAYCONFIG_SCANLINE_ORDERING scanLineOrdering;
}

struct DISPLAYCONFIG_SOURCE_MODE
{
    uint   width;
    uint   height;
    DISPLAYCONFIG_PIXELFORMAT pixelFormat;
    POINTL position;
}

struct DISPLAYCONFIG_TARGET_MODE
{
    DISPLAYCONFIG_VIDEO_SIGNAL_INFO targetVideoSignalInfo;
}

struct DISPLAYCONFIG_DESKTOP_IMAGE_INFO
{
    POINTL PathSourceSize;
    RECTL  DesktopImageRegion;
    RECTL  DesktopImageClip;
}

struct DISPLAYCONFIG_MODE_INFO
{
    DISPLAYCONFIG_MODE_INFO_TYPE infoType;
    uint id;
    LUID adapterId;
    union
    {
        DISPLAYCONFIG_TARGET_MODE targetMode;
        DISPLAYCONFIG_SOURCE_MODE sourceMode;
        DISPLAYCONFIG_DESKTOP_IMAGE_INFO desktopImageInfo;
    }
}

struct DISPLAYCONFIG_PATH_SOURCE_INFO
{
    LUID adapterId;
    uint id;
    union
    {
        uint modeInfoIdx;
        struct
        {
            uint _bitfield29;
        }
    }
    uint statusFlags;
}

struct DISPLAYCONFIG_PATH_TARGET_INFO
{
    LUID adapterId;
    uint id;
    union
    {
        uint modeInfoIdx;
        struct
        {
            uint _bitfield30;
        }
    }
    DISPLAYCONFIG_VIDEO_OUTPUT_TECHNOLOGY outputTechnology;
    DISPLAYCONFIG_ROTATION rotation;
    DISPLAYCONFIG_SCALING scaling;
    DISPLAYCONFIG_RATIONAL refreshRate;
    DISPLAYCONFIG_SCANLINE_ORDERING scanLineOrdering;
    BOOL targetAvailable;
    uint statusFlags;
}

struct DISPLAYCONFIG_PATH_INFO
{
    DISPLAYCONFIG_PATH_SOURCE_INFO sourceInfo;
    DISPLAYCONFIG_PATH_TARGET_INFO targetInfo;
    uint flags;
}

struct DISPLAYCONFIG_DEVICE_INFO_HEADER
{
    DISPLAYCONFIG_DEVICE_INFO_TYPE type;
    uint size;
    LUID adapterId;
    uint id;
}

struct DISPLAYCONFIG_SOURCE_DEVICE_NAME
{
    DISPLAYCONFIG_DEVICE_INFO_HEADER header;
    ushort[32] viewGdiDeviceName;
}

struct DISPLAYCONFIG_TARGET_DEVICE_NAME_FLAGS
{
    union
    {
        struct
        {
            uint _bitfield31;
        }
        uint value;
    }
}

struct DISPLAYCONFIG_TARGET_DEVICE_NAME
{
    DISPLAYCONFIG_DEVICE_INFO_HEADER header;
    DISPLAYCONFIG_TARGET_DEVICE_NAME_FLAGS flags;
    DISPLAYCONFIG_VIDEO_OUTPUT_TECHNOLOGY outputTechnology;
    ushort      edidManufactureId;
    ushort      edidProductCodeId;
    uint        connectorInstance;
    ushort[64]  monitorFriendlyDeviceName;
    ushort[128] monitorDevicePath;
}

struct DISPLAYCONFIG_TARGET_PREFERRED_MODE
{
    DISPLAYCONFIG_DEVICE_INFO_HEADER header;
    uint width;
    uint height;
    DISPLAYCONFIG_TARGET_MODE targetMode;
}

struct DISPLAYCONFIG_ADAPTER_NAME
{
    DISPLAYCONFIG_DEVICE_INFO_HEADER header;
    ushort[128] adapterDevicePath;
}

struct DISPLAYCONFIG_TARGET_BASE_TYPE
{
    DISPLAYCONFIG_DEVICE_INFO_HEADER header;
    DISPLAYCONFIG_VIDEO_OUTPUT_TECHNOLOGY baseOutputTechnology;
}

struct DISPLAYCONFIG_SET_TARGET_PERSISTENCE
{
    DISPLAYCONFIG_DEVICE_INFO_HEADER header;
    union
    {
        struct
        {
            uint _bitfield32;
        }
        uint value;
    }
}

struct DISPLAYCONFIG_SUPPORT_VIRTUAL_RESOLUTION
{
    DISPLAYCONFIG_DEVICE_INFO_HEADER header;
    union
    {
        struct
        {
            uint _bitfield33;
        }
        uint value;
    }
}

struct RECT
{
    int left;
    int top;
    int right;
    int bottom;
}

struct RECTL
{
    int left;
    int top;
    int right;
    int bottom;
}

struct POINT
{
    int x;
    int y;
}

struct POINTL
{
    int x;
    int y;
}

struct SIZE
{
    int cx;
    int cy;
}

struct POINTS
{
    short x;
    short y;
}

struct DDVIDEOPORTCAPS
{
    uint   dwSize;
    uint   dwFlags;
    uint   dwMaxWidth;
    uint   dwMaxVBIWidth;
    uint   dwMaxHeight;
    uint   dwVideoPortID;
    uint   dwCaps;
    uint   dwFX;
    uint   dwNumAutoFlipSurfaces;
    uint   dwAlignVideoPortBoundary;
    uint   dwAlignVideoPortPrescaleWidth;
    uint   dwAlignVideoPortCropBoundary;
    uint   dwAlignVideoPortCropWidth;
    uint   dwPreshrinkXStep;
    uint   dwPreshrinkYStep;
    uint   dwNumVBIAutoFlipSurfaces;
    uint   dwNumPreferredAutoflip;
    ushort wNumFilterTapsX;
    ushort wNumFilterTapsY;
}

struct DDVIDEOPORTDESC
{
    uint               dwSize;
    uint               dwFieldWidth;
    uint               dwVBIWidth;
    uint               dwFieldHeight;
    uint               dwMicrosecondsPerField;
    uint               dwMaxPixelsPerSecond;
    uint               dwVideoPortID;
    uint               dwReserved1;
    DDVIDEOPORTCONNECT VideoPortType;
    size_t             dwReserved2;
    size_t             dwReserved3;
}

struct DDVIDEOPORTINFO
{
    uint           dwSize;
    uint           dwOriginX;
    uint           dwOriginY;
    uint           dwVPFlags;
    RECT           rCrop;
    uint           dwPrescaleWidth;
    uint           dwPrescaleHeight;
    DDPIXELFORMAT* lpddpfInputFormat;
    DDPIXELFORMAT* lpddpfVBIInputFormat;
    DDPIXELFORMAT* lpddpfVBIOutputFormat;
    uint           dwVBIHeight;
    size_t         dwReserved1;
    size_t         dwReserved2;
}

struct DDVIDEOPORTBANDWIDTH
{
    uint   dwSize;
    uint   dwCaps;
    uint   dwOverlay;
    uint   dwColorkey;
    uint   dwYInterpolate;
    uint   dwYInterpAndColorkey;
    size_t dwReserved1;
    size_t dwReserved2;
}

struct DD_GETHEAPALIGNMENTDATA
{
}

struct VIDEOMEMORY
{
    uint    dwFlags;
    size_t  fpStart;
    union
    {
        size_t fpEnd;
        uint   dwWidth;
    }
    DDSCAPS ddsCaps;
    DDSCAPS ddsCapsAlt;
    union
    {
        VMEMHEAP* lpHeap;
        uint      dwHeight;
    }
}

struct VIDEOMEMORYINFO
{
    size_t        fpPrimary;
    uint          dwFlags;
    uint          dwDisplayWidth;
    uint          dwDisplayHeight;
    int           lDisplayPitch;
    DDPIXELFORMAT ddpfDisplay;
    uint          dwOffscreenAlign;
    uint          dwOverlayAlign;
    uint          dwTextureAlign;
    uint          dwZBufferAlign;
    uint          dwAlphaAlign;
    void*         pvPrimary;
}

struct DD_CALLBACKS
{
    uint                 dwSize;
    uint                 dwFlags;
    PDD_DESTROYDRIVER    DestroyDriver;
    PDD_CREATESURFACE    CreateSurface;
    PDD_SETCOLORKEY      SetColorKey;
    PDD_SETMODE          SetMode;
    PDD_WAITFORVERTICALBLANK WaitForVerticalBlank;
    PDD_CANCREATESURFACE CanCreateSurface;
    PDD_CREATEPALETTE    CreatePalette;
    PDD_GETSCANLINE      GetScanLine;
    PDD_MAPMEMORY        MapMemory;
}

struct DD_MISCELLANEOUSCALLBACKS
{
    uint dwSize;
    uint dwFlags;
    PDD_GETAVAILDRIVERMEMORY GetAvailDriverMemory;
}

struct DD_MISCELLANEOUS2CALLBACKS
{
    uint                dwSize;
    uint                dwFlags;
    PDD_ALPHABLT        AlphaBlt;
    PDD_CREATESURFACEEX CreateSurfaceEx;
    PDD_GETDRIVERSTATE  GetDriverState;
    PDD_DESTROYDDLOCAL  DestroyDDLocal;
}

struct DD_NTCALLBACKS
{
    uint                 dwSize;
    uint                 dwFlags;
    PDD_FREEDRIVERMEMORY FreeDriverMemory;
    PDD_SETEXCLUSIVEMODE SetExclusiveMode;
    PDD_FLIPTOGDISURFACE FlipToGDISurface;
}

struct DD_PALETTECALLBACKS
{
    uint                 dwSize;
    uint                 dwFlags;
    PDD_PALCB_DESTROYPALETTE DestroyPalette;
    PDD_PALCB_SETENTRIES SetEntries;
}

struct DD_SURFACECALLBACKS
{
    uint              dwSize;
    uint              dwFlags;
    PDD_SURFCB_DESTROYSURFACE DestroySurface;
    PDD_SURFCB_FLIP   Flip;
    PDD_SURFCB_SETCLIPLIST SetClipList;
    PDD_SURFCB_LOCK   Lock;
    PDD_SURFCB_UNLOCK Unlock;
    PDD_SURFCB_BLT    Blt;
    PDD_SURFCB_SETCOLORKEY SetColorKey;
    PDD_SURFCB_ADDATTACHEDSURFACE AddAttachedSurface;
    PDD_SURFCB_GETBLTSTATUS GetBltStatus;
    PDD_SURFCB_GETFLIPSTATUS GetFlipStatus;
    PDD_SURFCB_UPDATEOVERLAY UpdateOverlay;
    PDD_SURFCB_SETOVERLAYPOSITION SetOverlayPosition;
    void*             reserved4;
    PDD_SURFCB_SETPALETTE SetPalette;
}

struct DD_VIDEOPORTCALLBACKS
{
    uint                 dwSize;
    uint                 dwFlags;
    PDD_VPORTCB_CANCREATEVIDEOPORT CanCreateVideoPort;
    PDD_VPORTCB_CREATEVIDEOPORT CreateVideoPort;
    PDD_VPORTCB_FLIP     FlipVideoPort;
    PDD_VPORTCB_GETBANDWIDTH GetVideoPortBandwidth;
    PDD_VPORTCB_GETINPUTFORMATS GetVideoPortInputFormats;
    PDD_VPORTCB_GETOUTPUTFORMATS GetVideoPortOutputFormats;
    void*                lpReserved1;
    PDD_VPORTCB_GETFIELD GetVideoPortField;
    PDD_VPORTCB_GETLINE  GetVideoPortLine;
    PDD_VPORTCB_GETVPORTCONNECT GetVideoPortConnectInfo;
    PDD_VPORTCB_DESTROYVPORT DestroyVideoPort;
    PDD_VPORTCB_GETFLIPSTATUS GetVideoPortFlipStatus;
    PDD_VPORTCB_UPDATE   UpdateVideoPort;
    PDD_VPORTCB_WAITFORSYNC WaitForVideoPortSync;
    PDD_VPORTCB_GETSIGNALSTATUS GetVideoSignalStatus;
    PDD_VPORTCB_COLORCONTROL ColorControl;
}

struct DD_COLORCONTROLCALLBACKS
{
    uint dwSize;
    uint dwFlags;
    PDD_COLORCB_COLORCONTROL ColorControl;
}

struct DD_KERNELCALLBACKS
{
    uint dwSize;
    uint dwFlags;
    PDD_KERNELCB_SYNCSURFACE SyncSurfaceData;
    PDD_KERNELCB_SYNCVIDEOPORT SyncVideoPortData;
}

struct DD_MOTIONCOMPCALLBACKS
{
    uint                 dwSize;
    uint                 dwFlags;
    PDD_MOCOMPCB_GETGUIDS GetMoCompGuids;
    PDD_MOCOMPCB_GETFORMATS GetMoCompFormats;
    PDD_MOCOMPCB_CREATE  CreateMoComp;
    PDD_MOCOMPCB_GETCOMPBUFFINFO GetMoCompBuffInfo;
    PDD_MOCOMPCB_GETINTERNALINFO GetInternalMoCompInfo;
    PDD_MOCOMPCB_BEGINFRAME BeginMoCompFrame;
    PDD_MOCOMPCB_ENDFRAME EndMoCompFrame;
    PDD_MOCOMPCB_RENDER  RenderMoComp;
    PDD_MOCOMPCB_QUERYSTATUS QueryMoCompStatus;
    PDD_MOCOMPCB_DESTROY DestroyMoComp;
}

struct DD_NONLOCALVIDMEMCAPS
{
    uint    dwSize;
    uint    dwNLVBCaps;
    uint    dwNLVBCaps2;
    uint    dwNLVBCKeyCaps;
    uint    dwNLVBFXCaps;
    uint[8] dwNLVBRops;
}

struct DD_PALETTE_GLOBAL
{
    size_t dwReserved1;
}

struct DD_PALETTE_LOCAL
{
    uint   dwReserved0;
    size_t dwReserved1;
}

struct DD_CLIPPER_GLOBAL
{
    size_t dwReserved1;
}

struct DD_CLIPPER_LOCAL
{
    size_t dwReserved1;
}

struct DD_ATTACHLIST
{
    DD_ATTACHLIST*    lpLink;
    DD_SURFACE_LOCAL* lpAttached;
}

struct DD_SURFACE_INT
{
    DD_SURFACE_LOCAL* lpLcl;
}

struct DD_SURFACE_GLOBAL
{
    union
    {
        uint dwBlockSizeY;
        int  lSlicePitch;
    }
    union
    {
        VIDEOMEMORY* lpVidMemHeap;
        uint         dwBlockSizeX;
        uint         dwUserMemSize;
    }
    size_t        fpVidMem;
    union
    {
        int  lPitch;
        uint dwLinearSize;
    }
    int           yHint;
    int           xHint;
    uint          wHeight;
    uint          wWidth;
    size_t        dwReserved1;
    DDPIXELFORMAT ddpfSurface;
    size_t        fpHeapOffset;
    HANDLE        hCreatorProcess;
}

struct DD_SURFACE_MORE
{
    uint                dwMipMapCount;
    DD_VIDEOPORT_LOCAL* lpVideoPort;
    uint                dwOverlayFlags;
    DDSCAPSEX           ddsCapsEx;
    uint                dwSurfaceHandle;
}

struct DD_SURFACE_LOCAL
{
    DD_SURFACE_GLOBAL* lpGbl;
    uint               dwFlags;
    DDSCAPS            ddsCaps;
    size_t             dwReserved1;
    union
    {
        DDCOLORKEY ddckCKSrcOverlay;
        DDCOLORKEY ddckCKSrcBlt;
    }
    union
    {
        DDCOLORKEY ddckCKDestOverlay;
        DDCOLORKEY ddckCKDestBlt;
    }
    DD_SURFACE_MORE*   lpSurfMore;
    DD_ATTACHLIST*     lpAttachList;
    DD_ATTACHLIST*     lpAttachListFrom;
    RECT               rcOverlaySrc;
}

struct DD_D3DBUFCALLBACKS
{
    uint                 dwSize;
    uint                 dwFlags;
    PDD_CANCREATESURFACE CanCreateD3DBuffer;
    PDD_CREATESURFACE    CreateD3DBuffer;
    PDD_SURFCB_DESTROYSURFACE DestroyD3DBuffer;
    PDD_SURFCB_LOCK      LockD3DBuffer;
    PDD_SURFCB_UNLOCK    UnlockD3DBuffer;
}

struct DD_HALINFO
{
    uint                dwSize;
    VIDEOMEMORYINFO     vmiData;
    DDNTCORECAPS        ddCaps;
    PDD_GETDRIVERINFO   GetDriverInfo;
    uint                dwFlags;
    void*               lpD3DGlobalDriverData;
    void*               lpD3DHALCallbacks;
    DD_D3DBUFCALLBACKS* lpD3DBufCallbacks;
}

struct DD_DIRECTDRAW_GLOBAL
{
    void*            dhpdev;
    size_t           dwReserved1;
    size_t           dwReserved2;
    DDVIDEOPORTCAPS* lpDDVideoPortCaps;
}

struct DD_DIRECTDRAW_LOCAL
{
    DD_DIRECTDRAW_GLOBAL* lpGbl;
}

struct DD_VIDEOPORT_LOCAL
{
    DD_DIRECTDRAW_LOCAL* lpDD;
    DDVIDEOPORTDESC      ddvpDesc;
    DDVIDEOPORTINFO      ddvpInfo;
    DD_SURFACE_INT*      lpSurface;
    DD_SURFACE_INT*      lpVBISurface;
    uint                 dwNumAutoflip;
    uint                 dwNumVBIAutoflip;
    size_t               dwReserved1;
    size_t               dwReserved2;
    size_t               dwReserved3;
}

struct DD_MOTIONCOMP_LOCAL
{
    DD_DIRECTDRAW_LOCAL* lpDD;
    GUID                 guid;
    uint                 dwUncompWidth;
    uint                 dwUncompHeight;
    DDPIXELFORMAT        ddUncompPixelFormat;
    uint                 dwDriverReserved1;
    uint                 dwDriverReserved2;
    uint                 dwDriverReserved3;
    void*                lpDriverReserved1;
    void*                lpDriverReserved2;
    void*                lpDriverReserved3;
}

struct DD_MORESURFACECAPS
{
    uint      dwSize;
    DDSCAPSEX ddsCapsMore;
    struct ddsExtendedHeapRestrictions
    {
        DDSCAPSEX ddsCapsEx;
        DDSCAPSEX ddsCapsExAlt;
    }
}

struct DD_STEREOMODE
{
    uint dwSize;
    uint dwHeight;
    uint dwWidth;
    uint dwBpp;
    uint dwRefreshRate;
    BOOL bSupported;
}

struct DD_UPDATENONLOCALHEAPDATA
{
    DD_DIRECTDRAW_GLOBAL* lpDD;
    uint    dwHeap;
    size_t  fpGARTLin;
    size_t  fpGARTDev;
    size_t  ulPolicyMaxBytes;
    HRESULT ddRVal;
    void*   UpdateNonLocalHeap;
}

struct DD_NTPRIVATEDRIVERCAPS
{
    uint dwSize;
    uint dwPrivateCaps;
}

struct DD_BLTDATA
{
    DD_DIRECTDRAW_GLOBAL* lpDD;
    DD_SURFACE_LOCAL* lpDDDestSurface;
    RECTL             rDest;
    DD_SURFACE_LOCAL* lpDDSrcSurface;
    RECTL             rSrc;
    uint              dwFlags;
    uint              dwROPFlags;
    DDBLTFX           bltFX;
    HRESULT           ddRVal;
    void*             Blt;
    BOOL              IsClipped;
    RECTL             rOrigDest;
    RECTL             rOrigSrc;
    uint              dwRectCnt;
    RECT*             prDestRects;
    uint              dwAFlags;
    DDARGB            ddargbScaleFactors;
}

struct DD_LOCKDATA
{
    DD_DIRECTDRAW_GLOBAL* lpDD;
    DD_SURFACE_LOCAL* lpDDSurface;
    uint              bHasRect;
    RECTL             rArea;
    void*             lpSurfData;
    HRESULT           ddRVal;
    void*             Lock;
    uint              dwFlags;
    size_t            fpProcess;
}

struct DD_UNLOCKDATA
{
    DD_DIRECTDRAW_GLOBAL* lpDD;
    DD_SURFACE_LOCAL* lpDDSurface;
    HRESULT           ddRVal;
    void*             Unlock;
}

struct DD_UPDATEOVERLAYDATA
{
    DD_DIRECTDRAW_GLOBAL* lpDD;
    DD_SURFACE_LOCAL* lpDDDestSurface;
    RECTL             rDest;
    DD_SURFACE_LOCAL* lpDDSrcSurface;
    RECTL             rSrc;
    uint              dwFlags;
    DDOVERLAYFX       overlayFX;
    HRESULT           ddRVal;
    void*             UpdateOverlay;
}

struct DD_SETOVERLAYPOSITIONDATA
{
    DD_DIRECTDRAW_GLOBAL* lpDD;
    DD_SURFACE_LOCAL* lpDDSrcSurface;
    DD_SURFACE_LOCAL* lpDDDestSurface;
    int               lXPos;
    int               lYPos;
    HRESULT           ddRVal;
    void*             SetOverlayPosition;
}

struct DD_SETPALETTEDATA
{
    DD_DIRECTDRAW_GLOBAL* lpDD;
    DD_SURFACE_LOCAL*  lpDDSurface;
    DD_PALETTE_GLOBAL* lpDDPalette;
    HRESULT            ddRVal;
    void*              SetPalette;
    BOOL               Attach;
}

struct DD_FLIPDATA
{
    DD_DIRECTDRAW_GLOBAL* lpDD;
    DD_SURFACE_LOCAL* lpSurfCurr;
    DD_SURFACE_LOCAL* lpSurfTarg;
    uint              dwFlags;
    HRESULT           ddRVal;
    void*             Flip;
    DD_SURFACE_LOCAL* lpSurfCurrLeft;
    DD_SURFACE_LOCAL* lpSurfTargLeft;
}

struct DD_DESTROYSURFACEDATA
{
    DD_DIRECTDRAW_GLOBAL* lpDD;
    DD_SURFACE_LOCAL* lpDDSurface;
    HRESULT           ddRVal;
    void*             DestroySurface;
}

struct DD_ADDATTACHEDSURFACEDATA
{
    DD_DIRECTDRAW_GLOBAL* lpDD;
    DD_SURFACE_LOCAL* lpDDSurface;
    DD_SURFACE_LOCAL* lpSurfAttached;
    HRESULT           ddRVal;
    void*             AddAttachedSurface;
}

struct DD_SETCOLORKEYDATA
{
    DD_DIRECTDRAW_GLOBAL* lpDD;
    DD_SURFACE_LOCAL* lpDDSurface;
    uint              dwFlags;
    DDCOLORKEY        ckNew;
    HRESULT           ddRVal;
    void*             SetColorKey;
}

struct DD_GETBLTSTATUSDATA
{
    DD_DIRECTDRAW_GLOBAL* lpDD;
    DD_SURFACE_LOCAL* lpDDSurface;
    uint              dwFlags;
    HRESULT           ddRVal;
    void*             GetBltStatus;
}

struct DD_GETFLIPSTATUSDATA
{
    DD_DIRECTDRAW_GLOBAL* lpDD;
    DD_SURFACE_LOCAL* lpDDSurface;
    uint              dwFlags;
    HRESULT           ddRVal;
    void*             GetFlipStatus;
}

struct DD_DESTROYPALETTEDATA
{
    DD_DIRECTDRAW_GLOBAL* lpDD;
    DD_PALETTE_GLOBAL* lpDDPalette;
    HRESULT            ddRVal;
    void*              DestroyPalette;
}

struct DD_SETENTRIESDATA
{
    DD_DIRECTDRAW_GLOBAL* lpDD;
    DD_PALETTE_GLOBAL* lpDDPalette;
    uint               dwBase;
    uint               dwNumEntries;
    PALETTEENTRY*      lpEntries;
    HRESULT            ddRVal;
    void*              SetEntries;
}

struct DD_CREATESURFACEDATA
{
    DD_DIRECTDRAW_GLOBAL* lpDD;
    DDSURFACEDESC*     lpDDSurfaceDesc;
    DD_SURFACE_LOCAL** lplpSList;
    uint               dwSCnt;
    HRESULT            ddRVal;
    void*              CreateSurface;
}

struct DD_CANCREATESURFACEDATA
{
    DD_DIRECTDRAW_GLOBAL* lpDD;
    DDSURFACEDESC* lpDDSurfaceDesc;
    uint           bIsDifferentPixelFormat;
    HRESULT        ddRVal;
    void*          CanCreateSurface;
}

struct DD_CREATEPALETTEDATA
{
    DD_DIRECTDRAW_GLOBAL* lpDD;
    DD_PALETTE_GLOBAL* lpDDPalette;
    PALETTEENTRY*      lpColorTable;
    HRESULT            ddRVal;
    void*              CreatePalette;
    BOOL               is_excl;
}

struct DD_WAITFORVERTICALBLANKDATA
{
    DD_DIRECTDRAW_GLOBAL* lpDD;
    uint    dwFlags;
    uint    bIsInVB;
    size_t  hEvent;
    HRESULT ddRVal;
    void*   WaitForVerticalBlank;
}

struct DD_GETSCANLINEDATA
{
    DD_DIRECTDRAW_GLOBAL* lpDD;
    uint    dwScanLine;
    HRESULT ddRVal;
    void*   GetScanLine;
}

struct DD_MAPMEMORYDATA
{
    DD_DIRECTDRAW_GLOBAL* lpDD;
    BOOL    bMap;
    HANDLE  hProcess;
    size_t  fpProcess;
    HRESULT ddRVal;
}

struct DD_CANCREATEVPORTDATA
{
    DD_DIRECTDRAW_LOCAL* lpDD;
    DDVIDEOPORTDESC*     lpDDVideoPortDesc;
    HRESULT              ddRVal;
    void*                CanCreateVideoPort;
}

struct DD_CREATEVPORTDATA
{
    DD_DIRECTDRAW_LOCAL* lpDD;
    DDVIDEOPORTDESC*     lpDDVideoPortDesc;
    DD_VIDEOPORT_LOCAL*  lpVideoPort;
    HRESULT              ddRVal;
    void*                CreateVideoPort;
}

struct DD_FLIPVPORTDATA
{
    DD_DIRECTDRAW_LOCAL* lpDD;
    DD_VIDEOPORT_LOCAL*  lpVideoPort;
    DD_SURFACE_LOCAL*    lpSurfCurr;
    DD_SURFACE_LOCAL*    lpSurfTarg;
    HRESULT              ddRVal;
    void*                FlipVideoPort;
}

struct DD_GETVPORTBANDWIDTHDATA
{
    DD_DIRECTDRAW_LOCAL* lpDD;
    DD_VIDEOPORT_LOCAL*  lpVideoPort;
    DDPIXELFORMAT*       lpddpfFormat;
    uint                 dwWidth;
    uint                 dwHeight;
    uint                 dwFlags;
    DDVIDEOPORTBANDWIDTH* lpBandwidth;
    HRESULT              ddRVal;
    void*                GetVideoPortBandwidth;
}

struct DD_GETVPORTINPUTFORMATDATA
{
    DD_DIRECTDRAW_LOCAL* lpDD;
    DD_VIDEOPORT_LOCAL*  lpVideoPort;
    uint                 dwFlags;
    DDPIXELFORMAT*       lpddpfFormat;
    uint                 dwNumFormats;
    HRESULT              ddRVal;
    void*                GetVideoPortInputFormats;
}

struct DD_GETVPORTOUTPUTFORMATDATA
{
    DD_DIRECTDRAW_LOCAL* lpDD;
    DD_VIDEOPORT_LOCAL*  lpVideoPort;
    uint                 dwFlags;
    DDPIXELFORMAT*       lpddpfInputFormat;
    DDPIXELFORMAT*       lpddpfOutputFormats;
    uint                 dwNumFormats;
    HRESULT              ddRVal;
    void*                GetVideoPortInputFormats;
}

struct DD_GETVPORTFIELDDATA
{
    DD_DIRECTDRAW_LOCAL* lpDD;
    DD_VIDEOPORT_LOCAL*  lpVideoPort;
    BOOL                 bField;
    HRESULT              ddRVal;
    void*                GetVideoPortField;
}

struct DD_GETVPORTLINEDATA
{
    DD_DIRECTDRAW_LOCAL* lpDD;
    DD_VIDEOPORT_LOCAL*  lpVideoPort;
    uint                 dwLine;
    HRESULT              ddRVal;
    void*                GetVideoPortLine;
}

struct DD_GETVPORTCONNECTDATA
{
    DD_DIRECTDRAW_LOCAL* lpDD;
    uint                 dwPortId;
    DDVIDEOPORTCONNECT*  lpConnect;
    uint                 dwNumEntries;
    HRESULT              ddRVal;
    void*                GetVideoPortConnectInfo;
}

struct DD_DESTROYVPORTDATA
{
    DD_DIRECTDRAW_LOCAL* lpDD;
    DD_VIDEOPORT_LOCAL*  lpVideoPort;
    HRESULT              ddRVal;
    void*                DestroyVideoPort;
}

struct DD_GETVPORTFLIPSTATUSDATA
{
    DD_DIRECTDRAW_LOCAL* lpDD;
    size_t               fpSurface;
    HRESULT              ddRVal;
    void*                GetVideoPortFlipStatus;
}

struct DD_UPDATEVPORTDATA
{
    DD_DIRECTDRAW_LOCAL* lpDD;
    DD_VIDEOPORT_LOCAL*  lpVideoPort;
    DD_SURFACE_INT**     lplpDDSurface;
    DD_SURFACE_INT**     lplpDDVBISurface;
    DDVIDEOPORTINFO*     lpVideoInfo;
    uint                 dwFlags;
    uint                 dwNumAutoflip;
    uint                 dwNumVBIAutoflip;
    HRESULT              ddRVal;
    void*                UpdateVideoPort;
}

struct DD_WAITFORVPORTSYNCDATA
{
    DD_DIRECTDRAW_LOCAL* lpDD;
    DD_VIDEOPORT_LOCAL*  lpVideoPort;
    uint                 dwFlags;
    uint                 dwLine;
    uint                 dwTimeOut;
    HRESULT              ddRVal;
    void*                UpdateVideoPort;
}

struct DD_GETVPORTSIGNALDATA
{
    DD_DIRECTDRAW_LOCAL* lpDD;
    DD_VIDEOPORT_LOCAL*  lpVideoPort;
    uint                 dwStatus;
    HRESULT              ddRVal;
    void*                GetVideoSignalStatus;
}

struct DD_VPORTCOLORDATA
{
    DD_DIRECTDRAW_LOCAL* lpDD;
    DD_VIDEOPORT_LOCAL*  lpVideoPort;
    uint                 dwFlags;
    DDCOLORCONTROL*      lpColorData;
    HRESULT              ddRVal;
    void*                ColorControl;
}

struct DD_COLORCONTROLDATA
{
    DD_DIRECTDRAW_GLOBAL* lpDD;
    DD_SURFACE_LOCAL* lpDDSurface;
    DDCOLORCONTROL*   lpColorData;
    uint              dwFlags;
    HRESULT           ddRVal;
    void*             ColorControl;
}

struct DD_GETDRIVERINFODATA
{
    void*   dhpdev;
    uint    dwSize;
    uint    dwFlags;
    GUID    guidInfo;
    uint    dwExpectedSize;
    void*   lpvData;
    uint    dwActualSize;
    HRESULT ddRVal;
}

struct DD_GETAVAILDRIVERMEMORYDATA
{
    DD_DIRECTDRAW_GLOBAL* lpDD;
    DDSCAPS DDSCaps;
    uint    dwTotal;
    uint    dwFree;
    HRESULT ddRVal;
    void*   GetAvailDriverMemory;
}

struct DD_FREEDRIVERMEMORYDATA
{
    DD_DIRECTDRAW_GLOBAL* lpDD;
    DD_SURFACE_LOCAL* lpDDSurface;
    HRESULT           ddRVal;
    void*             FreeDriverMemory;
}

struct DD_SETEXCLUSIVEMODEDATA
{
    DD_DIRECTDRAW_GLOBAL* lpDD;
    uint    dwEnterExcl;
    uint    dwReserved;
    HRESULT ddRVal;
    void*   SetExclusiveMode;
}

struct DD_FLIPTOGDISURFACEDATA
{
    DD_DIRECTDRAW_GLOBAL* lpDD;
    uint    dwToGDI;
    uint    dwReserved;
    HRESULT ddRVal;
    void*   FlipToGDISurface;
}

struct DD_SYNCSURFACEDATA
{
    DD_DIRECTDRAW_LOCAL* lpDD;
    DD_SURFACE_LOCAL*    lpDDSurface;
    uint                 dwSurfaceOffset;
    size_t               fpLockPtr;
    int                  lPitch;
    uint                 dwOverlayOffset;
    uint                 dwDriverReserved1;
    uint                 dwDriverReserved2;
    uint                 dwDriverReserved3;
    uint                 dwDriverReserved4;
    HRESULT              ddRVal;
}

struct DD_SYNCVIDEOPORTDATA
{
    DD_DIRECTDRAW_LOCAL* lpDD;
    DD_VIDEOPORT_LOCAL*  lpVideoPort;
    uint                 dwOriginOffset;
    uint                 dwHeight;
    uint                 dwVBIHeight;
    uint                 dwDriverReserved1;
    uint                 dwDriverReserved2;
    uint                 dwDriverReserved3;
    HRESULT              ddRVal;
}

struct DD_GETMOCOMPGUIDSDATA
{
    DD_DIRECTDRAW_LOCAL* lpDD;
    uint                 dwNumGuids;
    GUID*                lpGuids;
    HRESULT              ddRVal;
}

struct DD_GETMOCOMPFORMATSDATA
{
    DD_DIRECTDRAW_LOCAL* lpDD;
    GUID*                lpGuid;
    uint                 dwNumFormats;
    DDPIXELFORMAT*       lpFormats;
    HRESULT              ddRVal;
}

struct DD_CREATEMOCOMPDATA
{
    DD_DIRECTDRAW_LOCAL* lpDD;
    DD_MOTIONCOMP_LOCAL* lpMoComp;
    GUID*                lpGuid;
    uint                 dwUncompWidth;
    uint                 dwUncompHeight;
    DDPIXELFORMAT        ddUncompPixelFormat;
    void*                lpData;
    uint                 dwDataSize;
    HRESULT              ddRVal;
}

struct DDCOMPBUFFERINFO
{
    uint          dwSize;
    uint          dwNumCompBuffers;
    uint          dwWidthToCreate;
    uint          dwHeightToCreate;
    uint          dwBytesToAllocate;
    DDSCAPS2      ddCompCaps;
    DDPIXELFORMAT ddPixelFormat;
}

struct DD_GETMOCOMPCOMPBUFFDATA
{
    DD_DIRECTDRAW_LOCAL* lpDD;
    GUID*                lpGuid;
    uint                 dwWidth;
    uint                 dwHeight;
    DDPIXELFORMAT        ddPixelFormat;
    uint                 dwNumTypesCompBuffs;
    DDCOMPBUFFERINFO*    lpCompBuffInfo;
    HRESULT              ddRVal;
}

struct DD_GETINTERNALMOCOMPDATA
{
    DD_DIRECTDRAW_LOCAL* lpDD;
    GUID*                lpGuid;
    uint                 dwWidth;
    uint                 dwHeight;
    DDPIXELFORMAT        ddPixelFormat;
    uint                 dwScratchMemAlloc;
    HRESULT              ddRVal;
}

struct DD_BEGINMOCOMPFRAMEDATA
{
    DD_DIRECTDRAW_LOCAL* lpDD;
    DD_MOTIONCOMP_LOCAL* lpMoComp;
    DD_SURFACE_LOCAL*    lpDestSurface;
    uint                 dwInputDataSize;
    void*                lpInputData;
    uint                 dwOutputDataSize;
    void*                lpOutputData;
    HRESULT              ddRVal;
}

struct DD_ENDMOCOMPFRAMEDATA
{
    DD_DIRECTDRAW_LOCAL* lpDD;
    DD_MOTIONCOMP_LOCAL* lpMoComp;
    void*                lpInputData;
    uint                 dwInputDataSize;
    HRESULT              ddRVal;
}

struct DDMOCOMPBUFFERINFO
{
    uint              dwSize;
    DD_SURFACE_LOCAL* lpCompSurface;
    uint              dwDataOffset;
    uint              dwDataSize;
    void*             lpPrivate;
}

struct DD_RENDERMOCOMPDATA
{
    DD_DIRECTDRAW_LOCAL* lpDD;
    DD_MOTIONCOMP_LOCAL* lpMoComp;
    uint                 dwNumBuffers;
    DDMOCOMPBUFFERINFO*  lpBufferInfo;
    uint                 dwFunction;
    void*                lpInputData;
    uint                 dwInputDataSize;
    void*                lpOutputData;
    uint                 dwOutputDataSize;
    HRESULT              ddRVal;
}

struct DD_QUERYMOCOMPSTATUSDATA
{
    DD_DIRECTDRAW_LOCAL* lpDD;
    DD_MOTIONCOMP_LOCAL* lpMoComp;
    DD_SURFACE_LOCAL*    lpSurface;
    uint                 dwFlags;
    HRESULT              ddRVal;
}

struct DD_DESTROYMOCOMPDATA
{
    DD_DIRECTDRAW_LOCAL* lpDD;
    DD_MOTIONCOMP_LOCAL* lpMoComp;
    HRESULT              ddRVal;
}

struct DD_CREATESURFACEEXDATA
{
    uint                 dwFlags;
    DD_DIRECTDRAW_LOCAL* lpDDLcl;
    DD_SURFACE_LOCAL*    lpDDSLcl;
    HRESULT              ddRVal;
}

struct DD_GETDRIVERSTATEDATA
{
    uint    dwFlags;
    union
    {
        DD_DIRECTDRAW_GLOBAL* lpDD;
        size_t dwhContext;
    }
    uint*   lpdwStates;
    uint    dwLength;
    HRESULT ddRVal;
}

struct FD_XFORM
{
    uint eXX;
    uint eXY;
    uint eYX;
    uint eYY;
}

struct FD_DEVICEMETRICS
{
    uint     flRealizedType;
    POINTE   pteBase;
    POINTE   pteSide;
    int      lD;
    int      fxMaxAscender;
    int      fxMaxDescender;
    POINTL   ptlUnderline1;
    POINTL   ptlStrikeOut;
    POINTL   ptlULThickness;
    POINTL   ptlSOThickness;
    uint     cxMax;
    uint     cyMax;
    uint     cjGlyphMax;
    FD_XFORM fdxQuantized;
    int      lNonLinearExtLeading;
    int      lNonLinearIntLeading;
    int      lNonLinearMaxCharWidth;
    int      lNonLinearAvgCharWidth;
    int      lMinA;
    int      lMinC;
    int      lMinD;
    int[1]   alReserved;
}

struct WCRUN
{
    ushort wcLow;
    ushort cGlyphs;
    uint*  phg;
}

struct FD_GLYPHSET
{
    uint     cjThis;
    uint     flAccel;
    uint     cGlyphsSupported;
    uint     cRuns;
    WCRUN[1] awcrun;
}

struct FD_GLYPHATTR
{
    uint     cjThis;
    uint     cGlyphs;
    uint     iMode;
    ubyte[1] aGlyphAttr;
}

struct FD_KERNINGPAIR
{
    ushort wcFirst;
    ushort wcSecond;
    short  fwdKern;
}

struct FONTDIFF
{
    ubyte  jReserved1;
    ubyte  jReserved2;
    ubyte  jReserved3;
    ubyte  bWeight;
    ushort usWinWeight;
    ushort fsSelection;
    short  fwdAveCharWidth;
    short  fwdMaxCharInc;
    POINTL ptlCaret;
}

struct FONTSIM
{
    int dpBold;
    int dpItalic;
    int dpBoldItalic;
}

struct IFIMETRICS
{
    uint     cjThis;
    uint     cjIfiExtra;
    int      dpwszFamilyName;
    int      dpwszStyleName;
    int      dpwszFaceName;
    int      dpwszUniqueName;
    int      dpFontSim;
    int      lEmbedId;
    int      lItalicAngle;
    int      lCharBias;
    int      dpCharSets;
    ubyte    jWinCharSet;
    ubyte    jWinPitchAndFamily;
    ushort   usWinWeight;
    uint     flInfo;
    ushort   fsSelection;
    ushort   fsType;
    short    fwdUnitsPerEm;
    short    fwdLowestPPEm;
    short    fwdWinAscender;
    short    fwdWinDescender;
    short    fwdMacAscender;
    short    fwdMacDescender;
    short    fwdMacLineGap;
    short    fwdTypoAscender;
    short    fwdTypoDescender;
    short    fwdTypoLineGap;
    short    fwdAveCharWidth;
    short    fwdMaxCharInc;
    short    fwdCapHeight;
    short    fwdXHeight;
    short    fwdSubscriptXSize;
    short    fwdSubscriptYSize;
    short    fwdSubscriptXOffset;
    short    fwdSubscriptYOffset;
    short    fwdSuperscriptXSize;
    short    fwdSuperscriptYSize;
    short    fwdSuperscriptXOffset;
    short    fwdSuperscriptYOffset;
    short    fwdUnderscoreSize;
    short    fwdUnderscorePosition;
    short    fwdStrikeoutSize;
    short    fwdStrikeoutPosition;
    ubyte    chFirstChar;
    ubyte    chLastChar;
    ubyte    chDefaultChar;
    ubyte    chBreakChar;
    ushort   wcFirstChar;
    ushort   wcLastChar;
    ushort   wcDefaultChar;
    ushort   wcBreakChar;
    POINTL   ptlBaseline;
    POINTL   ptlAspect;
    POINTL   ptlCaret;
    RECTL    rclFontBox;
    ubyte[4] achVendId;
    uint     cKerningPairs;
    uint     ulPanoseCulture;
    PANOSE   panose;
}

struct IFIEXTRA
{
    uint    ulIdentifier;
    int     dpFontSig;
    uint    cig;
    int     dpDesignVector;
    int     dpAxesInfoW;
    uint[1] aulReserved;
}

struct DRVFN
{
    uint iFunc;
    PFN  pfn;
}

struct DRVENABLEDATA
{
    uint   iDriverVersion;
    uint   c;
    DRVFN* pdrvfn;
}

struct DEVINFO
{
    uint     flGraphicsCaps;
    LOGFONTW lfDefaultFont;
    LOGFONTW lfAnsiVarFont;
    LOGFONTW lfAnsiFixFont;
    uint     cFonts;
    uint     iDitherFormat;
    ushort   cxDither;
    ushort   cyDither;
    HPALETTE hpalDefault;
    uint     flGraphicsCaps2;
}

struct LINEATTRS
{
    uint        fl;
    uint        iJoin;
    uint        iEndCap;
    FLOAT_LONG  elWidth;
    uint        eMiterLimit;
    uint        cstyle;
    FLOAT_LONG* pstyle;
    FLOAT_LONG  elStyleState;
}

struct XFORML
{
    uint eM11;
    uint eM12;
    uint eM21;
    uint eM22;
    uint eDx;
    uint eDy;
}

struct CIECHROMA
{
    int x;
    int y;
    int Y;
}

struct COLORINFO
{
    CIECHROMA Red;
    CIECHROMA Green;
    CIECHROMA Blue;
    CIECHROMA Cyan;
    CIECHROMA Magenta;
    CIECHROMA Yellow;
    CIECHROMA AlignmentWhite;
    int       RedGamma;
    int       GreenGamma;
    int       BlueGamma;
    int       MagentaInCyanDye;
    int       YellowInCyanDye;
    int       CyanInMagentaDye;
    int       YellowInMagentaDye;
    int       CyanInYellowDye;
    int       MagentaInYellowDye;
}

struct GDIINFO
{
    uint      ulVersion;
    uint      ulTechnology;
    uint      ulHorzSize;
    uint      ulVertSize;
    uint      ulHorzRes;
    uint      ulVertRes;
    uint      cBitsPixel;
    uint      cPlanes;
    uint      ulNumColors;
    uint      flRaster;
    uint      ulLogPixelsX;
    uint      ulLogPixelsY;
    uint      flTextCaps;
    uint      ulDACRed;
    uint      ulDACGreen;
    uint      ulDACBlue;
    uint      ulAspectX;
    uint      ulAspectY;
    uint      ulAspectXY;
    int       xStyleStep;
    int       yStyleStep;
    int       denStyleStep;
    POINTL    ptlPhysOffset;
    SIZE      szlPhysSize;
    uint      ulNumPalReg;
    COLORINFO ciDevice;
    uint      ulDevicePelsDPI;
    uint      ulPrimaryOrder;
    uint      ulHTPatternSize;
    uint      ulHTOutputFormat;
    uint      flHTFlags;
    uint      ulVRefresh;
    uint      ulBltAlignment;
    uint      ulPanningHorzRes;
    uint      ulPanningVertRes;
    uint      xPanningAlignment;
    uint      yPanningAlignment;
    uint      cxHTPat;
    uint      cyHTPat;
    ubyte*    pHTPatA;
    ubyte*    pHTPatB;
    ubyte*    pHTPatC;
    uint      flShadeBlend;
    uint      ulPhysicalPixelCharacteristics;
    uint      ulPhysicalPixelGamma;
}

struct BRUSHOBJ
{
    uint  iSolidColor;
    void* pvRbrush;
    uint  flColorType;
}

struct CLIPOBJ
{
    uint  iUniq;
    RECTL rclBounds;
    ubyte iDComplexity;
    ubyte iFComplexity;
    ubyte iMode;
    ubyte fjOptions;
}

struct DRIVEROBJ
{
    void*       pvObj;
    FREEOBJPROC pFreeProc;
    HDEV__*     hdev;
    DHPDEV__*   dhpdev;
}

struct FONTOBJ
{
    uint   iUniq;
    uint   iFace;
    uint   cxMax;
    uint   flFontType;
    size_t iTTUniq;
    size_t iFile;
    SIZE   sizLogResPpi;
    uint   ulStyleSize;
    void*  pvConsumer;
    void*  pvProducer;
}

struct BLENDOBJ
{
    BLENDFUNCTION BlendFunction;
}

struct PALOBJ
{
    uint ulReserved;
}

struct PATHOBJ
{
    uint fl;
    uint cCurves;
}

struct SURFOBJ
{
    DHSURF__* dhsurf;
    HSURF__*  hsurf;
    DHPDEV__* dhpdev;
    HDEV__*   hdev;
    SIZE      sizlBitmap;
    uint      cjBits;
    void*     pvBits;
    void*     pvScan0;
    int       lDelta;
    uint      iUniq;
    uint      iBitmapFormat;
    ushort    iType;
    ushort    fjBitmap;
}

struct WNDOBJ
{
    CLIPOBJ  coClient;
    void*    pvConsumer;
    RECTL    rclClient;
    SURFOBJ* psoOwner;
}

struct XLATEOBJ
{
    uint   iUniq;
    uint   flXlate;
    ushort iSrcType;
    ushort iDstType;
    uint   cEntries;
    uint*  pulXlate;
}

struct ENUMRECTS
{
    uint     c;
    RECTL[1] arcl;
}

struct GLYPHBITS
{
    POINTL   ptlOrigin;
    SIZE     sizlBitmap;
    ubyte[1] aj;
}

union GLYPHDEF
{
    GLYPHBITS* pgb;
    PATHOBJ*   ppo;
}

struct GLYPHPOS
{
    uint      hg;
    GLYPHDEF* pgdf;
    POINTL    ptl;
}

struct GLYPHDATA
{
    GLYPHDEF gdf;
    uint     hg;
    int      fxD;
    int      fxA;
    int      fxAB;
    int      fxInkTop;
    int      fxInkBottom;
    RECTL    rclInk;
    POINTQF  ptqD;
}

struct STROBJ
{
    uint          cGlyphs;
    uint          flAccel;
    uint          ulCharInc;
    RECTL         rclBkGround;
    GLYPHPOS*     pgp;
    const(wchar)* pwszOrg;
}

struct FONTINFO
{
    uint cjThis;
    uint flCaps;
    uint cGlyphsSupported;
    uint cjMaxGlyph1;
    uint cjMaxGlyph4;
    uint cjMaxGlyph8;
    uint cjMaxGlyph32;
}

struct PATHDATA
{
    uint      flags;
    uint      count;
    POINTFIX* pptfx;
}

struct RUN
{
    int iStart;
    int iStop;
}

struct CLIPLINE
{
    POINTFIX ptfxA;
    POINTFIX ptfxB;
    int      lStyleState;
    uint     c;
    RUN[1]   arun;
}

struct PERBANDINFO
{
    BOOL bRepeatThisBand;
    SIZE szlBand;
    uint ulHorzRes;
    uint ulVertRes;
}

struct GAMMARAMP
{
    ushort[256] Red;
    ushort[256] Green;
    ushort[256] Blue;
}

struct DEVHTINFO
{
    uint      HTFlags;
    uint      HTPatternSize;
    uint      DevPelsDPI;
    COLORINFO ColorInfo;
}

struct DEVHTADJDATA
{
    uint       DeviceFlags;
    uint       DeviceXDPI;
    uint       DeviceYDPI;
    DEVHTINFO* pDefHTInfo;
    DEVHTINFO* pAdjHTInfo;
}

struct TYPE1_FONT
{
    HANDLE hPFM;
    HANDLE hPFB;
    uint   ulIdentifier;
}

struct ENGSAFESEMAPHORE
{
    HSEMAPHORE__* hsem;
    int           lCount;
}

struct FLOATOBJ
{
    uint ul1;
    uint ul2;
}

struct FLOATOBJ_XFORM
{
    FLOATOBJ eM11;
    FLOATOBJ eM12;
    FLOATOBJ eM21;
    FLOATOBJ eM22;
    FLOATOBJ eDx;
    FLOATOBJ eDy;
}

struct ENG_TIME_FIELDS
{
    ushort usYear;
    ushort usMonth;
    ushort usDay;
    ushort usHour;
    ushort usMinute;
    ushort usSecond;
    ushort usMilliseconds;
    ushort usWeekday;
}

struct VIDEOPARAMETERS
{
    GUID       Guid;
    uint       dwOffset;
    uint       dwCommand;
    uint       dwFlags;
    uint       dwMode;
    uint       dwTVStandard;
    uint       dwAvailableModes;
    uint       dwAvailableTVStandard;
    uint       dwFlickerFilter;
    uint       dwOverScanX;
    uint       dwOverScanY;
    uint       dwMaxUnscaledX;
    uint       dwMaxUnscaledY;
    uint       dwPositionX;
    uint       dwPositionY;
    uint       dwBrightness;
    uint       dwContrast;
    uint       dwCPType;
    uint       dwCPCommand;
    uint       dwCPStandard;
    uint       dwCPKey;
    uint       bCP_APSTriggerBits;
    ubyte[256] bOEMCopyProtection;
}

struct DDKERNELCAPS
{
    uint dwSize;
    uint dwCaps;
    uint dwIRQCaps;
}

struct SURFACEALIGNMENT
{
    union
    {
        struct Linear
        {
            uint dwStartAlignment;
            uint dwPitchAlignment;
            uint dwFlags;
            uint dwReserved2;
        }
        struct Rectangular
        {
            uint dwXAlignment;
            uint dwYAlignment;
            uint dwFlags;
            uint dwReserved2;
        }
    }
}

struct HEAPALIGNMENT
{
    uint             dwSize;
    DDSCAPS          ddsCaps;
    uint             dwReserved;
    SURFACEALIGNMENT ExecuteBuffer;
    SURFACEALIGNMENT Overlay;
    SURFACEALIGNMENT Texture;
    SURFACEALIGNMENT ZBuffer;
    SURFACEALIGNMENT AlphaBuffer;
    SURFACEALIGNMENT Offscreen;
    SURFACEALIGNMENT FlipTarget;
}

struct VMEMHEAP
{
    uint          dwFlags;
    uint          stride;
    void*         freeList;
    void*         allocList;
    uint          dwTotalSize;
    size_t        fpGARTLin;
    size_t        fpGARTDev;
    uint          dwCommitedSize;
    uint          dwCoalesceCount;
    HEAPALIGNMENT Alignment;
    DDSCAPSEX     ddsCapsEx;
    DDSCAPSEX     ddsCapsExAlt;
    LARGE_INTEGER liPhysAGPBase;
    HANDLE        hdevAGP;
    void*         pvPhysRsrv;
    ubyte*        pAgpCommitMask;
    uint          dwAgpCommitMaskSize;
}

struct DDCORECAPS
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
}

struct DDHAL_WAITFORVERTICALBLANKDATA
{
    DDRAWI_DIRECTDRAW_GBL* lpDD;
    uint    dwFlags;
    uint    bIsInVB;
    size_t  hEvent;
    HRESULT ddRVal;
    LPDDHAL_WAITFORVERTICALBLANK WaitForVerticalBlank;
}

struct DDHAL_DESTROYDDLOCALDATA
{
    uint    dwFlags;
    DDRAWI_DIRECTDRAW_LCL* pDDLcl;
    HRESULT ddRVal;
}

// Functions

@DllImport("GDI32")
void* BRUSHOBJ_pvAllocRbrush(BRUSHOBJ* pbo, uint cj);

@DllImport("GDI32")
void* BRUSHOBJ_pvGetRbrush(BRUSHOBJ* pbo);

@DllImport("GDI32")
uint BRUSHOBJ_ulGetBrushColor(BRUSHOBJ* pbo);

@DllImport("GDI32")
HANDLE BRUSHOBJ_hGetColorTransform(BRUSHOBJ* pbo);

@DllImport("GDI32")
uint CLIPOBJ_cEnumStart(CLIPOBJ* pco, BOOL bAll, uint iType, uint iDirection, uint cLimit);

@DllImport("GDI32")
BOOL CLIPOBJ_bEnum(CLIPOBJ* pco, uint cj, uint* pul);

@DllImport("GDI32")
PATHOBJ* CLIPOBJ_ppoGetPath(CLIPOBJ* pco);

@DllImport("GDI32")
uint FONTOBJ_cGetAllGlyphHandles(FONTOBJ* pfo, uint* phg);

@DllImport("GDI32")
void FONTOBJ_vGetInfo(FONTOBJ* pfo, uint cjSize, FONTINFO* pfi);

@DllImport("GDI32")
uint FONTOBJ_cGetGlyphs(FONTOBJ* pfo, uint iMode, uint cGlyph, uint* phg, void** ppvGlyph);

@DllImport("GDI32")
XFORMOBJ* FONTOBJ_pxoGetXform(FONTOBJ* pfo);

@DllImport("GDI32")
IFIMETRICS* FONTOBJ_pifi(FONTOBJ* pfo);

@DllImport("GDI32")
FD_GLYPHSET* FONTOBJ_pfdg(FONTOBJ* pfo);

@DllImport("GDI32")
void* FONTOBJ_pvTrueTypeFontFile(FONTOBJ* pfo, uint* pcjFile);

@DllImport("GDI32")
FD_GLYPHATTR* FONTOBJ_pQueryGlyphAttrs(FONTOBJ* pfo, uint iMode);

@DllImport("GDI32")
void PATHOBJ_vEnumStart(PATHOBJ* ppo);

@DllImport("GDI32")
BOOL PATHOBJ_bEnum(PATHOBJ* ppo, PATHDATA* ppd);

@DllImport("GDI32")
void PATHOBJ_vEnumStartClipLines(PATHOBJ* ppo, CLIPOBJ* pco, SURFOBJ* pso, LINEATTRS* pla);

@DllImport("GDI32")
BOOL PATHOBJ_bEnumClipLines(PATHOBJ* ppo, uint cb, CLIPLINE* pcl);

@DllImport("GDI32")
void PATHOBJ_vGetBounds(PATHOBJ* ppo, RECTFX* prectfx);

@DllImport("GDI32")
void STROBJ_vEnumStart(STROBJ* pstro);

@DllImport("GDI32")
BOOL STROBJ_bEnum(STROBJ* pstro, uint* pc, GLYPHPOS** ppgpos);

@DllImport("GDI32")
BOOL STROBJ_bEnumPositionsOnly(STROBJ* pstro, uint* pc, GLYPHPOS** ppgpos);

@DllImport("GDI32")
uint STROBJ_dwGetCodePage(STROBJ* pstro);

@DllImport("GDI32")
BOOL STROBJ_bGetAdvanceWidths(STROBJ* pso, uint iFirst, uint c, POINTQF* pptqD);

@DllImport("GDI32")
uint XFORMOBJ_iGetXform(XFORMOBJ* pxo, XFORML* pxform);

@DllImport("GDI32")
BOOL XFORMOBJ_bApplyXform(XFORMOBJ* pxo, uint iMode, uint cPoints, void* pvIn, void* pvOut);

@DllImport("GDI32")
uint XLATEOBJ_iXlate(XLATEOBJ* pxlo, uint iColor);

@DllImport("GDI32")
uint* XLATEOBJ_piVector(XLATEOBJ* pxlo);

@DllImport("GDI32")
uint XLATEOBJ_cGetPalette(XLATEOBJ* pxlo, uint iPal, uint cPal, uint* pPal);

@DllImport("GDI32")
HANDLE XLATEOBJ_hGetColorTransform(XLATEOBJ* pxlo);

@DllImport("GDI32")
HBITMAP EngCreateBitmap(SIZE sizl, int lWidth, uint iFormat, uint fl, void* pvBits);

@DllImport("GDI32")
HSURF__* EngCreateDeviceSurface(DHSURF__* dhsurf, SIZE sizl, uint iFormatCompat);

@DllImport("GDI32")
HBITMAP EngCreateDeviceBitmap(DHSURF__* dhsurf, SIZE sizl, uint iFormatCompat);

@DllImport("GDI32")
BOOL EngDeleteSurface(HSURF__* hsurf);

@DllImport("GDI32")
SURFOBJ* EngLockSurface(HSURF__* hsurf);

@DllImport("GDI32")
void EngUnlockSurface(SURFOBJ* pso);

@DllImport("GDI32")
BOOL EngEraseSurface(SURFOBJ* pso, RECTL* prcl, uint iColor);

@DllImport("GDI32")
BOOL EngAssociateSurface(HSURF__* hsurf, HDEV__* hdev, uint flHooks);

@DllImport("GDI32")
BOOL EngMarkBandingSurface(HSURF__* hsurf);

@DllImport("GDI32")
BOOL EngCheckAbort(SURFOBJ* pso);

@DllImport("GDI32")
void EngDeletePath(PATHOBJ* ppo);

@DllImport("GDI32")
HPALETTE EngCreatePalette(uint iMode, uint cColors, uint* pulColors, uint flRed, uint flGreen, uint flBlue);

@DllImport("GDI32")
BOOL EngDeletePalette(HPALETTE hpal);

@DllImport("GDI32")
CLIPOBJ* EngCreateClip();

@DllImport("GDI32")
void EngDeleteClip(CLIPOBJ* pco);

@DllImport("GDI32")
BOOL EngBitBlt(SURFOBJ* psoTrg, SURFOBJ* psoSrc, SURFOBJ* psoMask, CLIPOBJ* pco, XLATEOBJ* pxlo, RECTL* prclTrg, 
               POINTL* pptlSrc, POINTL* pptlMask, BRUSHOBJ* pbo, POINTL* pptlBrush, uint rop4);

@DllImport("GDI32")
BOOL EngLineTo(SURFOBJ* pso, CLIPOBJ* pco, BRUSHOBJ* pbo, int x1, int y1, int x2, int y2, RECTL* prclBounds, 
               uint mix);

@DllImport("GDI32")
BOOL EngStretchBlt(SURFOBJ* psoDest, SURFOBJ* psoSrc, SURFOBJ* psoMask, CLIPOBJ* pco, XLATEOBJ* pxlo, 
                   COLORADJUSTMENT* pca, POINTL* pptlHTOrg, RECTL* prclDest, RECTL* prclSrc, POINTL* pptlMask, 
                   uint iMode);

@DllImport("GDI32")
BOOL EngStretchBltROP(SURFOBJ* psoDest, SURFOBJ* psoSrc, SURFOBJ* psoMask, CLIPOBJ* pco, XLATEOBJ* pxlo, 
                      COLORADJUSTMENT* pca, POINTL* pptlHTOrg, RECTL* prclDest, RECTL* prclSrc, POINTL* pptlMask, 
                      uint iMode, BRUSHOBJ* pbo, uint rop4);

@DllImport("GDI32")
BOOL EngAlphaBlend(SURFOBJ* psoDest, SURFOBJ* psoSrc, CLIPOBJ* pco, XLATEOBJ* pxlo, RECTL* prclDest, 
                   RECTL* prclSrc, BLENDOBJ* pBlendObj);

@DllImport("GDI32")
BOOL EngGradientFill(SURFOBJ* psoDest, CLIPOBJ* pco, XLATEOBJ* pxlo, TRIVERTEX* pVertex, uint nVertex, void* pMesh, 
                     uint nMesh, RECTL* prclExtents, POINTL* pptlDitherOrg, uint ulMode);

@DllImport("GDI32")
BOOL EngTransparentBlt(SURFOBJ* psoDst, SURFOBJ* psoSrc, CLIPOBJ* pco, XLATEOBJ* pxlo, RECTL* prclDst, 
                       RECTL* prclSrc, uint TransColor, uint bCalledFromBitBlt);

@DllImport("GDI32")
BOOL EngTextOut(SURFOBJ* pso, STROBJ* pstro, FONTOBJ* pfo, CLIPOBJ* pco, RECTL* prclExtra, RECTL* prclOpaque, 
                BRUSHOBJ* pboFore, BRUSHOBJ* pboOpaque, POINTL* pptlOrg, uint mix);

@DllImport("GDI32")
BOOL EngStrokePath(SURFOBJ* pso, PATHOBJ* ppo, CLIPOBJ* pco, XFORMOBJ* pxo, BRUSHOBJ* pbo, POINTL* pptlBrushOrg, 
                   LINEATTRS* plineattrs, uint mix);

@DllImport("GDI32")
BOOL EngFillPath(SURFOBJ* pso, PATHOBJ* ppo, CLIPOBJ* pco, BRUSHOBJ* pbo, POINTL* pptlBrushOrg, uint mix, 
                 uint flOptions);

@DllImport("GDI32")
BOOL EngStrokeAndFillPath(SURFOBJ* pso, PATHOBJ* ppo, CLIPOBJ* pco, XFORMOBJ* pxo, BRUSHOBJ* pboStroke, 
                          LINEATTRS* plineattrs, BRUSHOBJ* pboFill, POINTL* pptlBrushOrg, uint mixFill, 
                          uint flOptions);

@DllImport("GDI32")
BOOL EngPaint(SURFOBJ* pso, CLIPOBJ* pco, BRUSHOBJ* pbo, POINTL* pptlBrushOrg, uint mix);

@DllImport("GDI32")
BOOL EngCopyBits(SURFOBJ* psoDest, SURFOBJ* psoSrc, CLIPOBJ* pco, XLATEOBJ* pxlo, RECTL* prclDest, POINTL* pptlSrc);

@DllImport("GDI32")
BOOL EngPlgBlt(SURFOBJ* psoTrg, SURFOBJ* psoSrc, SURFOBJ* psoMsk, CLIPOBJ* pco, XLATEOBJ* pxlo, 
               COLORADJUSTMENT* pca, POINTL* pptlBrushOrg, POINTFIX* pptfx, RECTL* prcl, POINTL* pptl, uint iMode);

@DllImport("GDI32")
int HT_Get8BPPFormatPalette(PALETTEENTRY* pPaletteEntry, ushort RedGamma, ushort GreenGamma, ushort BlueGamma);

@DllImport("GDI32")
int HT_Get8BPPMaskPalette(PALETTEENTRY* pPaletteEntry, BOOL Use8BPPMaskPal, ubyte CMYMask, ushort RedGamma, 
                          ushort GreenGamma, ushort BlueGamma);

@DllImport("GDI32")
ushort* EngGetPrinterDataFileName(HDEV__* hdev);

@DllImport("GDI32")
ushort* EngGetDriverName(HDEV__* hdev);

@DllImport("GDI32")
HANDLE EngLoadModule(const(wchar)* pwsz);

@DllImport("GDI32")
void* EngFindResource(HANDLE h, int iName, int iType, uint* pulSize);

@DllImport("GDI32")
void EngFreeModule(HANDLE h);

@DllImport("GDI32")
HSEMAPHORE__* EngCreateSemaphore();

@DllImport("GDI32")
void EngAcquireSemaphore(HSEMAPHORE__* hsem);

@DllImport("GDI32")
void EngReleaseSemaphore(HSEMAPHORE__* hsem);

@DllImport("GDI32")
void EngDeleteSemaphore(HSEMAPHORE__* hsem);

@DllImport("GDI32")
void EngMultiByteToUnicodeN(const(wchar)* UnicodeString, uint MaxBytesInUnicodeString, uint* BytesInUnicodeString, 
                            const(char)* MultiByteString, uint BytesInMultiByteString);

@DllImport("GDI32")
void EngUnicodeToMultiByteN(const(char)* MultiByteString, uint MaxBytesInMultiByteString, 
                            uint* BytesInMultiByteString, const(wchar)* UnicodeString, uint BytesInUnicodeString);

@DllImport("GDI32")
void EngQueryLocalTime(ENG_TIME_FIELDS* param0);

@DllImport("GDI32")
FD_GLYPHSET* EngComputeGlyphSet(int nCodePage, int nFirstChar, int cChars);

@DllImport("GDI32")
int EngMultiByteToWideChar(uint CodePage, const(wchar)* WideCharString, int BytesInWideCharString, 
                           const(char)* MultiByteString, int BytesInMultiByteString);

@DllImport("GDI32")
int EngWideCharToMultiByte(uint CodePage, const(wchar)* WideCharString, int BytesInWideCharString, 
                           const(char)* MultiByteString, int BytesInMultiByteString);

@DllImport("GDI32")
void EngGetCurrentCodePage(ushort* OemCodePage, ushort* AnsiCodePage);

@DllImport("USER32")
int GetDisplayConfigBufferSizes(uint flags, uint* numPathArrayElements, uint* numModeInfoArrayElements);

@DllImport("USER32")
int SetDisplayConfig(uint numPathArrayElements, char* pathArray, uint numModeInfoArrayElements, 
                     char* modeInfoArray, uint flags);

@DllImport("USER32")
int QueryDisplayConfig(uint flags, uint* numPathArrayElements, char* pathArray, uint* numModeInfoArrayElements, 
                       char* modeInfoArray, DISPLAYCONFIG_TOPOLOGY_ID* currentTopologyId);

@DllImport("USER32")
int DisplayConfigGetDeviceInfo(DISPLAYCONFIG_DEVICE_INFO_HEADER* requestPacket);

@DllImport("USER32")
int DisplayConfigSetDeviceInfo(DISPLAYCONFIG_DEVICE_INFO_HEADER* setPacket);


// Interfaces

interface IDirectDrawKernel : IUnknown
{
    HRESULT GetCaps(DDKERNELCAPS* param0);
    HRESULT GetKernelHandle(uint* param0);
    HRESULT ReleaseKernelHandle();
}

interface IDirectDrawSurfaceKernel : IUnknown
{
    HRESULT GetKernelHandle(uint* param0);
    HRESULT ReleaseKernelHandle();
}


