// Written in the D programming language.

module windows.displaydevices;

public import windows.core;
public import windows.com : HRESULT, IUnknown;
public import windows.coreaudio : DDVIDEOPORTCONNECT;
public import windows.direct2d : PALETTEENTRY;
public import windows.directdraw : DDARGB, DDBLTFX, DDCOLORCONTROL, DDOVERLAYFX,
                                   DDPIXELFORMAT, DDSCAPS, DDSCAPS2, DDSCAPSEX,
                                   DDSURFACEDESC;
public import windows.directshow : DDCOLORKEY;
public import windows.gdi : BLENDFUNCTION, COLORADJUSTMENT, HBITMAP, HPALETTE,
                            PANOSE, TRIVERTEX;
public import windows.kernel : LUID;
public import windows.shell : LOGFONTW;
public import windows.systemservices : BOOL, DDNTCORECAPS, DD_DESTROYDDLOCALDATA,
                                       DHPDEV__, DHSURF__, FLOAT_LONG, FREEOBJPROC,
                                       HANDLE, HDEV__, HSEMAPHORE__, HSURF__,
                                       LARGE_INTEGER, PDD_ALPHABLT, PDD_DESTROYDRIVER,
                                       PDD_SETCOLORKEY, PDD_SETMODE,
                                       PDD_SURFCB_SETCLIPLIST, PFN, POINTE,
                                       POINTFIX, POINTQF, RECTFX, XFORMOBJ;
public import windows.windowsprogramming : DDRAWI_DIRECTDRAW_GBL, DDRAWI_DIRECTDRAW_LCL,
                                           LPDDHAL_WAITFORVERTICALBLANK;

extern(Windows):


// Enums


///The DISPLAYCONFIG_VIDEO_OUTPUT_TECHNOLOGY enumeration specifies the target's connector type.
alias DISPLAYCONFIG_VIDEO_OUTPUT_TECHNOLOGY = int;
enum : int
{
    ///Indicates a connector that is not one of the types that is indicated by the following enumerators in this
    ///enumeration.
    DISPLAYCONFIG_OUTPUT_TECHNOLOGY_OTHER                = 0xffffffff,
    ///Indicates an HD15 (VGA) connector.
    DISPLAYCONFIG_OUTPUT_TECHNOLOGY_HD15                 = 0x00000000,
    ///Indicates an S-video connector.
    DISPLAYCONFIG_OUTPUT_TECHNOLOGY_SVIDEO               = 0x00000001,
    ///Indicates a composite video connector group.
    DISPLAYCONFIG_OUTPUT_TECHNOLOGY_COMPOSITE_VIDEO      = 0x00000002,
    ///Indicates a component video connector group.
    DISPLAYCONFIG_OUTPUT_TECHNOLOGY_COMPONENT_VIDEO      = 0x00000003,
    ///Indicates a Digital Video Interface (DVI) connector.
    DISPLAYCONFIG_OUTPUT_TECHNOLOGY_DVI                  = 0x00000004,
    ///Indicates a High-Definition Multimedia Interface (HDMI) connector.
    DISPLAYCONFIG_OUTPUT_TECHNOLOGY_HDMI                 = 0x00000005,
    ///Indicates a Low Voltage Differential Swing (LVDS) connector.
    DISPLAYCONFIG_OUTPUT_TECHNOLOGY_LVDS                 = 0x00000006,
    ///Indicates a Japanese D connector.
    DISPLAYCONFIG_OUTPUT_TECHNOLOGY_D_JPN                = 0x00000008,
    ///Indicates an SDI connector.
    DISPLAYCONFIG_OUTPUT_TECHNOLOGY_SDI                  = 0x00000009,
    ///Indicates an external display port, which is a display port that connects externally to a display device.
    DISPLAYCONFIG_OUTPUT_TECHNOLOGY_DISPLAYPORT_EXTERNAL = 0x0000000a,
    ///Indicates an embedded display port that connects internally to a display device.
    DISPLAYCONFIG_OUTPUT_TECHNOLOGY_DISPLAYPORT_EMBEDDED = 0x0000000b,
    ///Indicates an external Unified Display Interface (UDI), which is a UDI that connects externally to a display
    ///device.
    DISPLAYCONFIG_OUTPUT_TECHNOLOGY_UDI_EXTERNAL         = 0x0000000c,
    ///Indicates an embedded UDI that connects internally to a display device.
    DISPLAYCONFIG_OUTPUT_TECHNOLOGY_UDI_EMBEDDED         = 0x0000000d,
    ///Indicates a dongle cable that supports standard definition television (SDTV).
    DISPLAYCONFIG_OUTPUT_TECHNOLOGY_SDTVDONGLE           = 0x0000000e,
    ///Indicates that the VidPN target is a Miracast wireless display device. Supported starting in Windows 8.1.
    DISPLAYCONFIG_OUTPUT_TECHNOLOGY_MIRACAST             = 0x0000000f,
    DISPLAYCONFIG_OUTPUT_TECHNOLOGY_INDIRECT_WIRED       = 0x00000010,
    DISPLAYCONFIG_OUTPUT_TECHNOLOGY_INDIRECT_VIRTUAL     = 0x00000011,
    ///Indicates that the video output device connects internally to a display device (for example, the internal
    ///connection in a laptop computer).
    DISPLAYCONFIG_OUTPUT_TECHNOLOGY_INTERNAL             = 0x80000000,
    ///Forces this enumeration to compile to 32 bits in size. Without this value, some compilers would allow this
    ///enumeration to compile to a size other than 32 bits. You should not use this value.
    DISPLAYCONFIG_OUTPUT_TECHNOLOGY_FORCE_UINT32         = 0xffffffff,
}

///The DISPLAYCONFIG_SCANLINE_ORDERING enumeration specifies the method that the display uses to create an image on a
///screen.
alias DISPLAYCONFIG_SCANLINE_ORDERING = int;
enum : int
{
    ///Indicates that scan-line ordering of the output is unspecified. The caller can only set the
    ///<b>scanLineOrdering</b> member of the DISPLAYCONFIG_PATH_TARGET_INFO structure in a call to the SetDisplayConfig
    ///function to DISPLAYCONFIG_SCANLINE_ORDERING_UNSPECIFIED if the caller also set the refresh rate denominator and
    ///numerator of the <b>refreshRate</b> member both to zero. In this case, <b>SetDisplayConfig</b> uses the best
    ///refresh rate it can find.
    DISPLAYCONFIG_SCANLINE_ORDERING_UNSPECIFIED                = 0x00000000,
    ///Indicates that the output is a progressive image.
    DISPLAYCONFIG_SCANLINE_ORDERING_PROGRESSIVE                = 0x00000001,
    ///Indicates that the output is an interlaced image that is created beginning with the upper field.
    DISPLAYCONFIG_SCANLINE_ORDERING_INTERLACED                 = 0x00000002,
    ///Indicates that the output is an interlaced image that is created beginning with the upper field.
    DISPLAYCONFIG_SCANLINE_ORDERING_INTERLACED_UPPERFIELDFIRST = 0x00000002,
    ///Indicates that the output is an interlaced image that is created beginning with the lower field.
    DISPLAYCONFIG_SCANLINE_ORDERING_INTERLACED_LOWERFIELDFIRST = 0x00000003,
    DISPLAYCONFIG_SCANLINE_ORDERING_FORCE_UINT32               = 0xffffffff,
}

///The DISPLAYCONFIG_SCALING enumeration specifies the scaling transformation applied to content displayed on a video
///present network (VidPN) present path.
alias DISPLAYCONFIG_SCALING = int;
enum : int
{
    ///Indicates the identity transformation; the source content is presented with no change. This transformation is
    ///available only if the path's source mode has the same spatial resolution as the path's target mode.
    DISPLAYCONFIG_SCALING_IDENTITY               = 0x00000001,
    ///Indicates the centering transformation; the source content is presented unscaled, centered with respect to the
    ///spatial resolution of the target mode.
    DISPLAYCONFIG_SCALING_CENTERED               = 0x00000002,
    ///Indicates the content is scaled to fit the path's target.
    DISPLAYCONFIG_SCALING_STRETCHED              = 0x00000003,
    ///Indicates the aspect-ratio centering transformation.
    DISPLAYCONFIG_SCALING_ASPECTRATIOCENTEREDMAX = 0x00000004,
    ///Indicates that the caller requests a custom scaling that the caller cannot describe with any of the other
    ///DISPLAYCONFIG_SCALING_XXX values. Only a hardware vendor's value-add application should use
    ///DISPLAYCONFIG_SCALING_CUSTOM, because the value-add application might require a private interface to the driver.
    ///The application can then use DISPLAYCONFIG_SCALING_CUSTOM to indicate additional context for the driver for the
    ///custom value on the specified path.
    DISPLAYCONFIG_SCALING_CUSTOM                 = 0x00000005,
    ///Indicates that the caller does not have any preference for the scaling. The SetDisplayConfig function will use
    ///the scaling value that was last saved in the database for the path. If such a scaling value does not exist,
    ///<b>SetDisplayConfig</b> will use the default scaling for the computer. For example, stretched
    ///(DISPLAYCONFIG_SCALING_STRETCHED) for tablet computers and aspect-ratio centered
    ///(DISPLAYCONFIG_SCALING_ASPECTRATIOCENTEREDMAX) for non-tablet computers.
    DISPLAYCONFIG_SCALING_PREFERRED              = 0x00000080,
    ///Forces this enumeration to compile to 32 bits in size. Without this value, some compilers would allow this
    ///enumeration to compile to a size other than 32 bits. You should not use this value.
    DISPLAYCONFIG_SCALING_FORCE_UINT32           = 0xffffffff,
}

///The DISPLAYCONFIG_ROTATION enumeration specifies the clockwise rotation of the display.
alias DISPLAYCONFIG_ROTATION = int;
enum : int
{
    ///Indicates that rotation is 0 degrees—landscape mode.
    DISPLAYCONFIG_ROTATION_IDENTITY     = 0x00000001,
    ///Indicates that rotation is 90 degrees clockwise—portrait mode.
    DISPLAYCONFIG_ROTATION_ROTATE90     = 0x00000002,
    ///Indicates that rotation is 180 degrees clockwise—inverted landscape mode.
    DISPLAYCONFIG_ROTATION_ROTATE180    = 0x00000003,
    ///Indicates that rotation is 270 degrees clockwise—inverted portrait mode.
    DISPLAYCONFIG_ROTATION_ROTATE270    = 0x00000004,
    DISPLAYCONFIG_ROTATION_FORCE_UINT32 = 0xffffffff,
}

///The DISPLAYCONFIG_MODE_INFO_TYPE enumeration specifies that the information that is contained within the
///DISPLAYCONFIG_MODE_INFO structure is either source or target mode.
alias DISPLAYCONFIG_MODE_INFO_TYPE = int;
enum : int
{
    ///Indicates that the DISPLAYCONFIG_MODE_INFO structure contains source mode information.
    DISPLAYCONFIG_MODE_INFO_TYPE_SOURCE        = 0x00000001,
    ///Indicates that the DISPLAYCONFIG_MODE_INFO structure contains target mode information.
    DISPLAYCONFIG_MODE_INFO_TYPE_TARGET        = 0x00000002,
    ///Indicates that the DISPLAYCONFIG_MODE_INFO structure contains a valid DISPLAYCONFIG_DESKTOP_IMAGE_INFO structure.
    ///Supported starting in Windows 10.
    DISPLAYCONFIG_MODE_INFO_TYPE_DESKTOP_IMAGE = 0x00000003,
    ///Forces this enumeration to compile to 32 bits in size. Without this value, some compilers would allow this
    ///enumeration to compile to a size other than 32 bits. You should not use this value.
    DISPLAYCONFIG_MODE_INFO_TYPE_FORCE_UINT32  = 0xffffffff,
}

///The DISPLAYCONFIG_PIXELFORMAT enumeration specifies pixel format in various bits per pixel (BPP) values.
alias DISPLAYCONFIG_PIXELFORMAT = int;
enum : int
{
    ///Indicates 8 BPP format.
    DISPLAYCONFIG_PIXELFORMAT_8BPP         = 0x00000001,
    ///Indicates 16 BPP format.
    DISPLAYCONFIG_PIXELFORMAT_16BPP        = 0x00000002,
    ///Indicates 24 BPP format.
    DISPLAYCONFIG_PIXELFORMAT_24BPP        = 0x00000003,
    ///Indicates 32 BPP format.
    DISPLAYCONFIG_PIXELFORMAT_32BPP        = 0x00000004,
    ///Indicates that the current display is not an 8, 16, 24, or 32 BPP GDI desktop mode. For example, a call to the
    ///QueryDisplayConfig function returns DISPLAYCONFIG_PIXELFORMAT_NONGDI if a DirectX application previously set the
    ///desktop to A2R10G10B10 format. A call to the SetDisplayConfig function fails if any pixel formats for active
    ///paths are set to DISPLAYCONFIG_PIXELFORMAT_NONGDI.
    DISPLAYCONFIG_PIXELFORMAT_NONGDI       = 0x00000005,
    ///Forces this enumeration to compile to 32 bits in size. Without this value, some compilers would allow this
    ///enumeration to compile to a size other than 32 bits. You should not use this value.
    DISPLAYCONFIG_PIXELFORMAT_FORCE_UINT32 = 0xffffffff,
}

///The DISPLAYCONFIG_TOPOLOGY_ID enumeration specifies the type of display topology.
alias DISPLAYCONFIG_TOPOLOGY_ID = int;
enum : int
{
    ///Indicates that the display topology is an internal configuration.
    DISPLAYCONFIG_TOPOLOGY_INTERNAL     = 0x00000001,
    ///Indicates that the display topology is clone-view configuration.
    DISPLAYCONFIG_TOPOLOGY_CLONE        = 0x00000002,
    ///Indicates that the display topology is an extended configuration.
    DISPLAYCONFIG_TOPOLOGY_EXTEND       = 0x00000004,
    ///Indicates that the display topology is an external configuration.
    DISPLAYCONFIG_TOPOLOGY_EXTERNAL     = 0x00000008,
    DISPLAYCONFIG_TOPOLOGY_FORCE_UINT32 = 0xffffffff,
}

///The DISPLAYCONFIG_DEVICE_INFO_TYPE enumeration specifies the type of display device info to configure or obtain
///through the DisplayConfigSetDeviceInfo or DisplayConfigGetDeviceInfo function.
alias DISPLAYCONFIG_DEVICE_INFO_TYPE = int;
enum : int
{
    ///Specifies the source name of the display device. If the DisplayConfigGetDeviceInfo function is successful,
    ///<b>DisplayConfigGetDeviceInfo</b> returns the source name in the DISPLAYCONFIG_SOURCE_DEVICE_NAME structure.
    DISPLAYCONFIG_DEVICE_INFO_GET_SOURCE_NAME                = 0x00000001,
    ///Specifies information about the monitor. If the DisplayConfigGetDeviceInfo function is successful,
    ///<b>DisplayConfigGetDeviceInfo</b> returns info about the monitor in the DISPLAYCONFIG_TARGET_DEVICE_NAME
    ///structure.
    DISPLAYCONFIG_DEVICE_INFO_GET_TARGET_NAME                = 0x00000002,
    ///Specifies information about the preferred mode of a monitor. If the DisplayConfigGetDeviceInfo function is
    ///successful, <b>DisplayConfigGetDeviceInfo</b> returns info about the preferred mode of a monitor in the
    ///DISPLAYCONFIG_TARGET_PREFERRED_MODE structure.
    DISPLAYCONFIG_DEVICE_INFO_GET_TARGET_PREFERRED_MODE      = 0x00000003,
    ///Specifies the graphics adapter name. If the DisplayConfigGetDeviceInfo function is successful,
    ///<b>DisplayConfigGetDeviceInfo</b> returns the adapter name in the DISPLAYCONFIG_ADAPTER_NAME structure.
    DISPLAYCONFIG_DEVICE_INFO_GET_ADAPTER_NAME               = 0x00000004,
    ///Specifies how to set the monitor. If the DisplayConfigSetDeviceInfo function is successful,
    ///<b>DisplayConfigSetDeviceInfo</b> uses info in the DISPLAYCONFIG_SET_TARGET_PERSISTENCE structure to force the
    ///output in a boot-persistent manner.
    DISPLAYCONFIG_DEVICE_INFO_SET_TARGET_PERSISTENCE         = 0x00000005,
    ///Specifies how to set the base output technology for a given target ID. If the DisplayConfigGetDeviceInfo function
    ///is successful, <b>DisplayConfigGetDeviceInfo</b> returns base output technology info in the
    ///DISPLAYCONFIG_TARGET_BASE_TYPE structure. Supported by WDDM 1.3 and later user-mode display drivers running on
    ///Windows 8.1 and later.
    DISPLAYCONFIG_DEVICE_INFO_GET_TARGET_BASE_TYPE           = 0x00000006,
    ///Specifies the state of virtual mode support. If the DisplayConfigGetDeviceInfo function is successful,
    ///<b>DisplayConfigGetDeviceInfo</b> returns virtual mode support information in the
    ///DISPLAYCONFIG_SUPPORT_VIRTUAL_RESOLUTION structure. Supported starting in Windows 10.
    DISPLAYCONFIG_DEVICE_INFO_GET_SUPPORT_VIRTUAL_RESOLUTION = 0x00000007,
    ///Specifies how to set the state of virtual mode support. If the DisplayConfigGetDeviceInfo function is successful,
    ///<b>DisplayConfigGetDeviceInfo</b> uses info in the DISPLAYCONFIG_SUPPORT_VIRTUAL_RESOLUTION structure to change
    ///the state of virtual mode support. Supported starting in Windows 10.
    DISPLAYCONFIG_DEVICE_INFO_SET_SUPPORT_VIRTUAL_RESOLUTION = 0x00000008,
    DISPLAYCONFIG_DEVICE_INFO_GET_ADVANCED_COLOR_INFO        = 0x00000009,
    DISPLAYCONFIG_DEVICE_INFO_SET_ADVANCED_COLOR_STATE       = 0x0000000a,
    DISPLAYCONFIG_DEVICE_INFO_GET_SDR_WHITE_LEVEL            = 0x0000000b,
    ///Forces this enumeration to compile to 32 bits in size. Without this value, some compilers would allow this
    ///enumeration to compile to a size other than 32 bits. You should not use this value.
    DISPLAYCONFIG_DEVICE_INFO_FORCE_UINT32                   = 0xffffffff,
}

// Callbacks

///The <b>CanCreateD3DBuffer</b> callback function determines whether the driver can create a driver-level command or
///vertex buffer of the specified description.
///Params:
///    Arg1 = Points to a DD_CANCREATESURFACEDATA structure. This structure contains the information required for the driver to
///           determine whether a command or vertex buffer can be created.
///Returns:
///    <b>CanCreateD3DBuffer</b> returns a callback code.
///    
alias PDD_CANCREATESURFACE = uint function(DD_CANCREATESURFACEDATA* param0);
///The <b>DdWaitForVerticalBlank</b> callback function returns the vertical blank status of the device.
///Params:
///    Arg1 = Points to a DD_WAITFORVERTICALBLANKDATA structure that contains the information required to obtain the vertical
///           blank status.
///Returns:
///    <b>DdWaitForVerticalBlank</b> returns one of the following callback codes:
///    
alias PDD_WAITFORVERTICALBLANK = uint function(DD_WAITFORVERTICALBLANKDATA* param0);
///The <i>CreateD3DBuffer</i> callback function is used to create a driver-level command or vertex buffer of the
///specified description.
///Params:
///    Arg1 = Points to a DD_CREATESURFACEDATA structure that contains the information required to create the buffer.
///Returns:
///    <i>CreateD3DBuffer</i> returns one of the following callback codes:
///    
alias PDD_CREATESURFACE = uint function(DD_CREATESURFACEDATA* param0);
///The <b>DdCreatePalette</b> callback function creates a DirectDrawPalette object for the specified DirectDraw object.
///Params:
///    Arg1 = Points to a DD_CREATEPALETTEDATA structure that contains the information necessary to create the
///           DirectDrawPalette object.
///Returns:
///    <b>DdCreatePalette</b> returns one of the following callback codes:
///    
alias PDD_CREATEPALETTE = uint function(DD_CREATEPALETTEDATA* param0);
///The <i>DdGetScanLine</i> callback function returns the number of the current physical scan line.
///Params:
///    Arg1 = Points to a DD_GETSCANLINEDATA structure in which the driver returns the number of the current scan line.
///Returns:
///    <i>DdGetScanLine</i> returns one of the following callback codes:
///    
alias PDD_GETSCANLINE = uint function(DD_GETSCANLINEDATA* param0);
///The <b>DdMapMemory</b> callback function maps application-modifiable portions of the frame buffer into the user-mode
///address space of the specified process, or unmaps memory.
///Params:
///    Arg1 = Points to a DD_MAPMEMORYDATA structure that contains details for the memory mapping or unmapping operation.
///Returns:
///    <b>DdMapMemory</b> returns one of the following callback codes:
///    
alias PDD_MAPMEMORY = uint function(DD_MAPMEMORYDATA* param0);
///The <i>DdGetDriverInfo</i> function queries the driver for additional DirectDraw and Direct3D functionality that the
///driver supports.
///Params:
///    Arg1 = Points to a DD_GETDRIVERINFODATA structure that contains the information required to perform the query.
///Returns:
///    <i>DdGetDriverInfo</i> must return DDHAL_DRIVER_HANDLED.
///    
alias PDD_GETDRIVERINFO = uint function(DD_GETDRIVERINFODATA* param0);
///The <b>DdGetAvailDriverMemory</b> callback function queries the amount of free memory in the driver-managed memory
///heap.
///Params:
///    Arg1 = Points to a DD_GETAVAILDRIVERMEMORYDATA structure that contains the information required to perform the query.
///Returns:
///    <b>DdGetAvailDriverMemory</b> returns one of the following callback codes:
///    
alias PDD_GETAVAILDRIVERMEMORY = uint function(DD_GETAVAILDRIVERMEMORYDATA* param0);
///The <b>D3dCreateSurfaceEx</b> function notifies about the association of a Microsoft DirectDraw surface and a
///Microsoft Direct3D handle value to enable setting up the surface for Direct3D rendering.
///Params:
///    Arg1 = Points to a DD_CREATESURFACEEXDATA structure that contains the information required for the driver to create the
///           surface.
///Returns:
///    <b>D3dCreateSurfaceEx</b> returns one of the following callback codes:
///    
alias PDD_CREATESURFACEEX = uint function(DD_CREATESURFACEEXDATA* param0);
///The <i>D3dGetDriverState</i> function is used by both the Microsoft DirectDraw and Microsoft Direct3D runtimes to
///obtain information from the driver about its current state.
///Params:
///    Arg1 = Points to a DD_GETDRIVERSTATEDATA structure that describes the state of the driver.
///Returns:
///    <i>D3dGetDriverState</i> returns one of the following callback codes:
///    
alias PDD_GETDRIVERSTATE = uint function(DD_GETDRIVERSTATEDATA* param0);
///The <b>D3dDestroyDDLocal</b> function destroys all the Microsoft Direct3D surfaces previously created by the
///D3dCreateSurfaceEx function that belong to the same given local Microsoft DirectDraw object.
///Params:
///    Arg1 = Points to a DDHAL_DESTROYDDLOCALDATA structure that contains the information required for the driver to destroy
///           the surfaces.
///Returns:
///    <b>D3dDestroyDDLocal</b> returns one of the following callback codes:
///    
alias PDD_DESTROYDDLOCAL = uint function(DD_DESTROYDDLOCALDATA* param0);
///The <b>DdFreeDriverMemory</b> callback function frees offscreen or nonlocal display memory to satisfy a new
///allocation request.
///Params:
///    Arg1 = Points to a DD_FREEDRIVERMEMORYDATA structure that contains the details of the free request.
///Returns:
///    <b>DdFreeDriverMemory</b> returns one of the following callback codes:
///    
alias PDD_FREEDRIVERMEMORY = uint function(DD_FREEDRIVERMEMORYDATA* param0);
///The <i>DdSetExclusiveMode</i> callback function notifies the driver when a DirectDraw application is switching to or
///from exclusive mode.
///Params:
///    Arg1 = Points to a DD_SETEXCLUSIVEMODEDATA structure that contains the notification information.
///Returns:
///    <i>DdSetExclusiveMode</i> returns one of the following callback codes:
///    
alias PDD_SETEXCLUSIVEMODE = uint function(DD_SETEXCLUSIVEMODEDATA* param0);
///The <i>DdFlipToGDISurface</i> callback function notifies the driver when DirectDraw is flipping to or from a GDI
///surface.
///Params:
///    Arg1 = Points to a DD_FLIPTOGDISURFACEDATA structure that contains the notification information.
///Returns:
///    <i>DdFlipToGDISurface</i> returns one of the following callback codes:
///    
alias PDD_FLIPTOGDISURFACE = uint function(DD_FLIPTOGDISURFACEDATA* param0);
///The <b>DdDestroyPalette</b> callback function destroys the specified palette.
///Params:
///    Arg1 = Points to a DD_DESTROYPALETTEDATA structure that contains the information needed to destroy a palette.
///Returns:
///    <b>DdDestroyPalette</b> returns one of the following callback codes:
///    
alias PDD_PALCB_DESTROYPALETTE = uint function(DD_DESTROYPALETTEDATA* param0);
///The <i>DdSetEntries</i> callback function updates the palette entries in the specified palette.
///Params:
///    Arg1 = Points to a DD_SETENTRIESDATA structure that contains the information required to set the palette's entries.
///Returns:
///    <i>DdSetEntries</i> returns one of the following callback codes:
///    
alias PDD_PALCB_SETENTRIES = uint function(DD_SETENTRIESDATA* param0);
///The <i>DdLock</i> callback function locks a specified area of surface memory and provides a valid pointer to a block
///of memory associated with a surface.
///Params:
///    Arg1 = Points to a DD_LOCKDATA structure that contains the information required to perform the lockdown.
///Returns:
///    <i>DdLock</i> returns one of the following callback codes:
///    
alias PDD_SURFCB_LOCK = uint function(DD_LOCKDATA* param0);
///The <i>DdUnLock</i> callback function releases the lock held on the specified surface.
///Params:
///    Arg1 = Points to a DD_UNLOCKDATA structure that contains the information required to perform the lock release.
///Returns:
///    <i>DdUnLock</i> returns one of the following callback codes:
///    
alias PDD_SURFCB_UNLOCK = uint function(DD_UNLOCKDATA* param0);
///The <i>DdBlt</i> callback function performs a bit-block transfer.
///Params:
///    Arg1 = Points to the DD_BLTDATA structure that contains the information required for the driver to perform the blit.
///Returns:
///    <i>DdBlt</i> returns one of the following callback codes:
///    
alias PDD_SURFCB_BLT = uint function(DD_BLTDATA* param0);
///The <b>DdUpdateOverlay</b> callback function repositions or modifies the visual attributes of an overlay surface.
///Params:
///    Arg1 = Points to a DD_UPDATEOVERLAYDATA structure that contains the information required to update the overlay.
///Returns:
///    <b>DdUpdateOverlay</b> returns one of the following callback codes:
///    
alias PDD_SURFCB_UPDATEOVERLAY = uint function(DD_UPDATEOVERLAYDATA* param0);
///The <b>DdSetOverlayPosition</b> callback function sets the position for an overlay.
///Params:
///    Arg1 = Points to a DD_SETOVERLAYPOSITIONDATA structure that contains the information required to set the overlay
///           position.
///Returns:
///    <b>DdSetOverlayPosition</b> returns one of the following callback codes:
///    
alias PDD_SURFCB_SETOVERLAYPOSITION = uint function(DD_SETOVERLAYPOSITIONDATA* param0);
///The <b>DdSetPalette</b> callback function attaches a palette to the specified surface.
///Params:
///    Arg1 = Points to a DD_SETPALETTEDATA structure that contains the information required to set a palette to the specified
///           surface.
///Returns:
///    <b>DdSetPalette</b> returns one of the following callback codes:
///    
alias PDD_SURFCB_SETPALETTE = uint function(DD_SETPALETTEDATA* param0);
///The <b>DdFlip</b> callback function causes the surface memory associated with the target surface to become the
///primary surface, and the current surface to become the nonprimary surface.
///Params:
///    Arg1 = Points to a DD_FLIPDATA structure that contains the information required to perform the flip.
///Returns:
///    <b>DdFlip</b> returns one of the following callback codes:
///    
alias PDD_SURFCB_FLIP = uint function(DD_FLIPDATA* param0);
///The <b>DdDestroySurface</b> callback function destroys a DirectDraw surface.
///Params:
///    Arg1 = Points to a DD_DESTROYSURFACEDATA structure that contains the information needed to destroy a surface.
///Returns:
///    <b>DdDestroySurface</b> returns one of the following callback codes:
///    
alias PDD_SURFCB_DESTROYSURFACE = uint function(DD_DESTROYSURFACEDATA* param0);
///The <b>DdAddAttachedSurface</b> callback function attaches a surface to another surface.
///Params:
///    Arg1 = Points to a DD_ADDATTACHEDSURFACEDATA structure that contains information required for the driver to perform the
///           attachment.
///Returns:
///    <b>DdAddAttachedSurface</b> returns one of the following callback codes:
///    
alias PDD_SURFCB_ADDATTACHEDSURFACE = uint function(DD_ADDATTACHEDSURFACEDATA* param0);
///The <i>DdSetColorKey</i> callback function sets the color key value for the specified surface.
///Params:
///    Arg1 = Points to a DD_SETCOLORKEYDATA structure that contains the information required to set the color key for the
///           specified surface.
///Returns:
///    <i>DdSetColorKey</i> returns one of the following callback codes:
///    
alias PDD_SURFCB_SETCOLORKEY = uint function(DD_SETCOLORKEYDATA* param0);
///The <b>DdGetBltStatus</b> callback function queries the blit status of the specified surface.
///Params:
///    Arg1 = Points to a DD_GETBLTSTATUSDATA structure that contains the information required to perform the blit status
///           query.
///Returns:
///    <b>DdGetBltStatus</b> returns one of the following callback codes:
///    
alias PDD_SURFCB_GETBLTSTATUS = uint function(DD_GETBLTSTATUSDATA* param0);
///The <b>DdGetFlipStatus</b> callback function determines whether the most recently requested flip on a surface has
///occurred.
///Params:
///    Arg1 = Points to a DD_GETFLIPSTATUSDATA structure that contains the information required to perform the flip status
///           query.
///Returns:
///    <b>DdGetFlipStatus</b> returns one of the following callback codes:
///    
alias PDD_SURFCB_GETFLIPSTATUS = uint function(DD_GETFLIPSTATUSDATA* param0);
///The <i>DdVideoPortCanCreate</i> callback function determines whether the driver can support a DirectDraw VPE object
///of the specified description.
///Params:
///    Arg1 = Points to a DD_CANCREATEVPORTDATA structure that contains the information necessary for the driver to determine
///           whether the specified DirectDraw VPE object can be supported.
///Returns:
///    <i>DdVideoPortCanCreate</i> returns one of the following callback codes:
///    
alias PDD_VPORTCB_CANCREATEVIDEOPORT = uint function(DD_CANCREATEVPORTDATA* param0);
///The <b>DdVideoPortCreate</b> callback function notifies the driver that DirectDraw has created a VPE object.
///Params:
///    Arg1 = Points to a DD_CREATEVPORTDATA structure that describes the created VPE object.
///Returns:
///    <b>DdVideoPortCreate</b> returns one of the following values:
///    
alias PDD_VPORTCB_CREATEVIDEOPORT = uint function(DD_CREATEVPORTDATA* param0);
///The <i>DdVideoPortFlip</i> callback function performs a physical flip, causing the VPE object to start writing data
///to the new surface.
///Params:
///    Arg1 = Points to a DD_FLIPVPORTDATA structure that contains the information required for the driver to perform the flip.
///Returns:
///    <i>DdVideoPortFlip</i> returns one of the following callback codes:
///    
alias PDD_VPORTCB_FLIP = uint function(DD_FLIPVPORTDATA* param0);
///The <b>DdVideoPortGetBandwidth</b> callback function reports the bandwidth limitations of the device's frame buffer
///memory based the specified VPE object output format.
///Params:
///    Arg1 = Points to a DD_GETVPORTBANDWIDTHDATA structure that contains the information required for the driver to return
///           the bandwidth data.
///Returns:
///    <b>DdVideoPortGetBandwidth</b> returns one of the following callback codes:
///    
alias PDD_VPORTCB_GETBANDWIDTH = uint function(DD_GETVPORTBANDWIDTHDATA* param0);
///The <b>DdVideoPortGetInputFormats</b> callback function determines the input formats that the DirectDraw VPE object
///can accept.
///Params:
///    Arg1 = Points to a DD_GETVPORTINPUTFORMATDATA structure that contains the information required for the driver to return
///           the input formats the VPE object can accept.
///Returns:
///    <b>DdVideoPortGetInputFormats</b> returns one of the following callback codes:
///    
alias PDD_VPORTCB_GETINPUTFORMATS = uint function(DD_GETVPORTINPUTFORMATDATA* param0);
///The <b>DdVideoPortGetOutputFormats</b> callback function determines the output formats that the VPE object supports.
///Params:
///    Arg1 = Points to a DD_GETVPORTOUTPUTFORMATDATA structure that contains the information required for the driver to return
///           the output formats the VPE object supports.
///Returns:
///    <b>DdVideoPortGetOutputFormats</b> returns one of the following callback codes:
///    
alias PDD_VPORTCB_GETOUTPUTFORMATS = uint function(DD_GETVPORTOUTPUTFORMATDATA* param0);
///The <b>DdVideoPortGetField</b> callback function determines whether the current field of an interlaced signal is even
///or odd.
///Params:
///    Arg1 = Points to a DD_GETVPORTFIELDDATA structure that contains the information required for the driver to determine
///           whether the current field is even or odd.
///Returns:
///    <b>DdVideoPortGetField</b> returns one of the following callback codes:
///    
alias PDD_VPORTCB_GETFIELD = uint function(DD_GETVPORTFIELDDATA* param0);
///The <b>DdVideoPortGetLine</b> callback function returns the current line number of the hardware video port.
///Params:
///    Arg1 = Points to a DD_GETVPORTLINEDATA structure that contains the information required for the driver to determine and
///           return the current line number for the specified hardware video port.
///Returns:
///    <b>DdVideoPortGetLine</b> returns one of the following callback codes:
///    
alias PDD_VPORTCB_GETLINE = uint function(DD_GETVPORTLINEDATA* param0);
///The <i>DdVideoPortGetConnectInfo</i> callback function returns the connections supported by the specified VPE object.
///Params:
///    Arg1 = Points to a DD_GETVPORTCONNECTDATA structure that contains the information required for the driver to return the
///           VPE object connection data.
///Returns:
///    <i>DdVideoPortGetConnectInfo</i> returns one of the following callback codes:
///    
alias PDD_VPORTCB_GETVPORTCONNECT = uint function(DD_GETVPORTCONNECTDATA* param0);
///The <b>DdVideoPortDestroy</b> callback function notifies the driver that DirectDraw has destroyed the specified VPE
///object.
///Params:
///    Arg1 = Points to a DD_DESTROYVPORTDATA structure that contains the information required for the driver to clean up.
///Returns:
///    <b>DdVideoPortDestroy</b> returns one of the following callback codes:
///    
alias PDD_VPORTCB_DESTROYVPORT = uint function(DD_DESTROYVPORTDATA* param0);
///The <i>DdVideoPortGetFlipStatus</i> callback function determines whether the most recently requested flip on a
///surface has occurred.
///Params:
///    Arg1 = Points to a DD_GETVPORTFLIPSTATUSDATA structure that contains the information required for the driver to
///           determine a surface's flip status.
///Returns:
///    <i>DdVideoPortGetFlipStatus</i> returns one of the following callback codes:
///    
alias PDD_VPORTCB_GETFLIPSTATUS = uint function(DD_GETVPORTFLIPSTATUSDATA* param0);
///The <b>DdVideoPortUpdate</b> callback function starts and stops the VPE object, and modifies the VPE object data
///stream.
///Params:
///    Arg1 = Points to a DD_UPDATEVPORTDATA structure that contains the information required for the driver to update the VPE
///           object.
///Returns:
///    <b>DdVideoPortUpdate</b> returns one of the following callback codes:
///    
alias PDD_VPORTCB_UPDATE = uint function(DD_UPDATEVPORTDATA* param0);
///The <i>DdVideoPortWaitForSync</i> callback function waits until the next vertical synch occurs.
///Params:
///    Arg1 = Points to a DD_WAITFORVPORTSYNCDATA structure that contains the information required for the driver to
///           synchronize the VPE object.
///Returns:
///    <i>DdVideoPortWaitForSync</i> returns one of the following callback codes:
///    
alias PDD_VPORTCB_WAITFORSYNC = uint function(DD_WAITFORVPORTSYNCDATA* param0);
///The <i>DdVideoPortGetSignalStatus</i> callback function retrieves the status of the video signal currently being
///presented to the hardware video port.
///Params:
///    Arg1 = Points to a DD_GETVPORTSIGNALDATA structure that contains the information required for the driver to retrieve the
///           status of the video signal.
///Returns:
///    <i>DdVideoPortGetSignalStatus</i> returns one of the following callback codes:
///    
alias PDD_VPORTCB_GETSIGNALSTATUS = uint function(DD_GETVPORTSIGNALDATA* param0);
///The <b>DdVideoPortColorControl</b> callback function gets or sets the VPE object color controls.
///Params:
///    Arg1 = Points to a DD_VPORTCOLORDATA structure that contains the information required for the driver to get the current
///           VPE object color controls or to set new values.
///Returns:
///    <b>DdVideoPortColorControl</b> returns one of the following callback codes:
///    
alias PDD_VPORTCB_COLORCONTROL = uint function(DD_VPORTCOLORDATA* param0);
///The <b>DdControlColor</b> callback function controls the luminance and brightness controls of an overlay surface.
///Params:
///    Arg1 = Points to a DD_COLORCONTROLDATA structure that contains the color control information for a specified overlay
///           surface.
///Returns:
///    <b>DdControlColor</b> returns a callback code.
///    
alias PDD_COLORCB_COLORCONTROL = uint function(DD_COLORCONTROLDATA* param0);
///The <i>DdSyncSurfaceData</i> callback function sets and modifies surface data before it is passed to the video
///miniport driver.
///Params:
///    Arg1 = Points to a DD_SYNCSURFACEDATA structure that contains the surface data.
///Returns:
///    <i>DdSyncSurfaceData</i> returns one of the following callback codes:
///    
alias PDD_KERNELCB_SYNCSURFACE = uint function(DD_SYNCSURFACEDATA* param0);
///The <b>DdSyncVideoPortData</b> callback function sets and modifies VPE object data before it is passed to the video
///miniport driver.
///Params:
///    Arg1 = Points to a DD_SYNCVIDEOPORTDATA structure that contains the VPE object data.
///Returns:
///    <b>DdSyncVideoPortData</b> returns one of the following callback codes:
///    
alias PDD_KERNELCB_SYNCVIDEOPORT = uint function(DD_SYNCVIDEOPORTDATA* param0);
///The <b>DdMoCompGetGuids</b> callback function retrieves the number of GUIDs the driver supports.
///Params:
///    Arg1 = Points to a DD_GETMOCOMPGUIDSDATA structure that contains the GUID information.
///Returns:
///    <b>DdMoCompGetGuids</b> returns one of the following callback codes:
///    
alias PDD_MOCOMPCB_GETGUIDS = uint function(DD_GETMOCOMPGUIDSDATA* param0);
///The <b>DdMoCompGetFormats</b> callback function indicates the uncompressed formats to which the hardware can decode
///the data.
///Params:
///    Arg1 = Points to a DD_GETMOCOMPFORMATSDATA structure that contains the uncompressed format information for the hardware.
///Returns:
///    <b>DdMoCompGetFormats</b> returns one of the following callback codes:
///    
alias PDD_MOCOMPCB_GETFORMATS = uint function(DD_GETMOCOMPFORMATSDATA* param0);
///The <i>DdMoCompCreate</i> callback function notifies the driver that a software decoder will start using motion
///compensation with the specified GUID.
///Params:
///    Arg1 = Points to a DD_CREATEMOCOMPDATA structure that contains the information required to begin using motion
///           compensation.
///Returns:
///    <i>DdMoCompCreate</i> returns one of the following callback codes:
///    
alias PDD_MOCOMPCB_CREATE = uint function(DD_CREATEMOCOMPDATA* param0);
///The <b>DDMoCompGetBuffInfo</b> callback function allows the driver to specify how many interim surfaces are required
///to support the specified GUID, and the size, location, and format of each of these surfaces.
///Params:
///    Arg1 = Points to a DD_GETMOCOMPCOMPBUFFDATA structure that contains the compressed buffer information.
///Returns:
///    <b>DDMoCompGetBuffInfo</b> returns one of the following callback codes:
///    
alias PDD_MOCOMPCB_GETCOMPBUFFINFO = uint function(DD_GETMOCOMPCOMPBUFFDATA* param0);
///The <b>DdMoCompGetInternalInfo</b> callback function allows the driver to report that it internally allocates display
///memory to perform motion compensation.
///Params:
///    Arg1 = Points to a DD_GETINTERNALMOCOMPDATA structure that contains the internal memory requirements.
///Returns:
///    <b>DdMoCompGetInternalInfo</b> returns one of the following callback codes:
///    
alias PDD_MOCOMPCB_GETINTERNALINFO = uint function(DD_GETINTERNALMOCOMPDATA* param0);
///The <b>DdMoCompBeginFrame</b> callback function starts decoding a new frame.
///Params:
///    Arg1 = Points to a DD_BEGINMOCOMPFRAMEDATA structure that contains the information needed to start decoding a new frame.
///Returns:
///    <b>DdMoCompBeginFrame</b> returns one of the following callback codes:
///    
alias PDD_MOCOMPCB_BEGINFRAME = uint function(DD_BEGINMOCOMPFRAMEDATA* param0);
///The <b>DdMoCompEndFrame</b> callback function completes a decoded frame.
///Params:
///    Arg1 = Points to a DD_ENDMOCOMPFRAMEDATA structure that contains the information needed to complete the decoded frame.
///Returns:
///    <b>DdMoCompEndFrame</b> returns one of the following callback codes:
///    
alias PDD_MOCOMPCB_ENDFRAME = uint function(DD_ENDMOCOMPFRAMEDATA* param0);
///The <b>DdMoCompRender</b> callback function tells the driver what macroblocks to render by specifying the surfaces
///containing the macroblocks, the offsets in each surface where the macroblocks exist, and the size of the macroblock
///data to be rendered.
///Params:
///    Arg1 = Points to a DD_RENDERMOCOMPDATA structure that contains the information needed to render a frame.
///Returns:
///    <b>DdMoCompRender</b> returns one of the following callback codes:
///    
alias PDD_MOCOMPCB_RENDER = uint function(DD_RENDERMOCOMPDATA* param0);
///The <b>DdMoCompQueryStatus</b> callback function queries the status of the most recent rendering operation to the
///specified surface.
///Params:
///    Arg1 = Points to a DD_QUERYMOCOMPSTATUSDATA structure that contains the information needed to query the status.
///Returns:
///    <b>DdMoCompQueryStatus</b> returns one of the following callback codes:
///    
alias PDD_MOCOMPCB_QUERYSTATUS = uint function(DD_QUERYMOCOMPSTATUSDATA* param0);
///The <b>DdMoCompDestroy</b> callback function notifies the driver that this motion compensation object will no longer
///be used. The driver now needs to perform any necessary cleanup.
///Params:
///    Arg1 = Points to a DD_DESTROYMOCOMPDATA structure that contains the information needed to finish motion compensation.
///Returns:
///    <b>DdMoCompDestroy</b> returns one of the following callback codes:
///    
alias PDD_MOCOMPCB_DESTROY = uint function(DD_DESTROYMOCOMPDATA* param0);
///The <b>DrvQueryGlyphAttrs</b> function returns information about a font's glyphs.
///Params:
///     = 
///    Arg1 = 
///Returns:
///    <b>DrvQueryGlyphAttrs</b> should return a pointer to an FD_GLYPHATTR structure. If an error is encountered, such
///    as an invalid input argument, or if the font described by the FONTOBJ structure is not a vertical font, the
///    function should return <b>NULL</b>.
///    
alias PFN_DrvQueryGlyphAttrs = FD_GLYPHATTR* function(FONTOBJ* param0, uint param1);

// Structs


///The DEVMODEW structure is used for specifying characteristics of display and print devices in the Unicode (wide)
///character set.
struct DEVMODEW
{
    ///For a display, specifies the name of the display driver's DLL; for example, "perm3dd" for the 3Dlabs Permedia3
    ///display driver. For a printer, specifies the "friendly name"; for example, "PCL/HP LaserJet" in the case of
    ///PCL/HP LaserJet. If the name is greater than CCHDEVICENAME characters in length, the spooler truncates it to fit
    ///in the array.
    ushort[32] dmDeviceName;
    ///Specifies the version number of this DEVMODEW structure. The current version number is identified by the
    ///DM_SPECVERSION constant in <i>wingdi.h</i>.
    ushort     dmSpecVersion;
    ///For a printer, specifies the printer driver version number assigned by the printer driver developer. Display
    ///drivers can set this member to DM_SPECVERSION.
    ushort     dmDriverVersion;
    ///Specifies the size in bytes of the public DEVMODEW structure, not including any private, driver-specified members
    ///identified by the <b>dmDriverExtra</b> member.
    ushort     dmSize;
    ///Specifies the number of bytes of private driver data that follow the public structure members. If a device driver
    ///does not provide private DEVMODEW members, this member should be set to zero.
    ushort     dmDriverExtra;
    ///Specifies bit flags identifying which of the following DEVMODEW members are in use. For example, the
    ///DM_ORIENTATION flag is set when the <b>dmOrientation</b> member contains valid data. The DM_XXX flags are defined
    ///in <i>wingdi.h</i>.
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
    ///For printers, specifies whether a color printer should print color or monochrome. This member can be one of
    ///DMCOLOR_COLOR or DMCOLOR_MONOCHROME. This member is not used for displays.
    short      dmColor;
    ///For printers, specifies duplex (double-sided) printing for duplex-capable printers. This member can be one of the
    ///following values:
    short      dmDuplex;
    ///For printers, specifies the <i>y</i> resolution of the printer, in DPI. If this member is used, the
    ///<b>dmPrintQuality</b> member specifies the <i>x</i> resolution. This member is not used for displays.
    short      dmYResolution;
    ///For printers, specifies how TrueType fonts should be printed. This member must be one of the DMTT-prefixed
    ///constants defined in <i>wingdi.h</i>. This member is not used for displays.
    short      dmTTOption;
    ///For printers, specifies whether multiple copies should be collated. This member can be one of the following
    ///values:
    short      dmCollate;
    ///For printers, specifies the name of the form to use; such as "Letter" or "Legal". This must be a name that can be
    ///obtain by calling the Win32 <b>EnumForms</b> function (described in the Microsoft Window SDK documentation). This
    ///member is not used for displays.
    ushort[32] dmFormName;
    ///For displays, specifies the number of logical pixels per inch of a display device and should be equal to the
    ///<b>ulLogPixels</b> member of the GDIINFO structure. This member is not used for printers.
    ushort     dmLogPixels;
    ///For displays, specifies the color resolution, in bits per pixel, of a display device. This member is not used for
    ///printers.
    uint       dmBitsPerPel;
    ///For displays, specifies the width, in pixels, of the visible device surface. This member is not used for
    ///printers.
    uint       dmPelsWidth;
    ///For displays, specifies the height, in pixels, of the visible device surface. This member is not used for
    ///printers.
    uint       dmPelsHeight;
    union
    {
        uint dmDisplayFlags;
        uint dmNup;
    }
    ///For displays, specifies the frequency, in hertz, of a display device in its current mode. This member is not used
    ///for printers.
    uint       dmDisplayFrequency;
    ///Specifies one of the DMICMMETHOD-prefixed constants defined in <i>wingdi.h</i>.
    uint       dmICMMethod;
    ///Specifies one of the DMICM-prefixed constants defined in <i>wingdi.h</i>.
    uint       dmICMIntent;
    ///Specifies one of the DMMEDIA-prefixed constants defined in <i>wingdi.h</i>.
    uint       dmMediaType;
    ///Specifies one of the DMDITHER-prefixed constants defined in <i>wingdi.h</i>.
    uint       dmDitherType;
    ///Is reserved for system use and should be ignored by the driver.
    uint       dmReserved1;
    ///Is reserved for system use and should be ignored by the driver.
    uint       dmReserved2;
    ///Is reserved for system use and should be ignored by the driver.
    uint       dmPanningWidth;
    ///Is reserved for system use and should be ignored by the driver.
    uint       dmPanningHeight;
}

///The DISPLAYCONFIG_RATIONAL structure describes a fractional value that represents vertical and horizontal frequencies
///of a video mode (that is, vertical sync and horizontal sync).
struct DISPLAYCONFIG_RATIONAL
{
    ///The numerator of the frequency fraction.
    uint Numerator;
    ///The denominator of the frequency fraction.
    uint Denominator;
}

///The DISPLAYCONFIG_2DREGION structure represents a point or an offset in a two-dimensional space.
struct DISPLAYCONFIG_2DREGION
{
    ///The horizontal component of the point or offset.
    uint cx;
    uint cy;
}

///The DISPLAYCONFIG_VIDEO_SIGNAL_INFO structure contains information about the video signal for a display.
struct DISPLAYCONFIG_VIDEO_SIGNAL_INFO
{
    ///The pixel clock rate.
    ulong pixelRate;
    ///A DISPLAYCONFIG_RATIONAL structure that represents horizontal sync.
    DISPLAYCONFIG_RATIONAL hSyncFreq;
    ///A DISPLAYCONFIG_RATIONAL structure that represents vertical sync.
    DISPLAYCONFIG_RATIONAL vSyncFreq;
    ///A DISPLAYCONFIG_2DREGION structure that specifies the width and height (in pixels) of the active portion of the
    ///video signal.
    DISPLAYCONFIG_2DREGION activeSize;
    ///A DISPLAYCONFIG_2DREGION structure that specifies the width and height (in pixels) of the entire video signal.
    DISPLAYCONFIG_2DREGION totalSize;
    union
    {
        struct AdditionalSignalInfo
        {
            uint _bitfield28;
        }
        uint videoStandard;
    }
    ///The scan-line ordering (for example, progressive or interlaced) of the video signal. For a list of possible
    ///values, see the DISPLAYCONFIG_SCANLINE_ORDERING enumerated type.
    DISPLAYCONFIG_SCANLINE_ORDERING scanLineOrdering;
}

///The <b>DISPLAYCONFIG_SOURCE_MODE</b> structure represents a point or an offset in a two-dimensional space.
struct DISPLAYCONFIG_SOURCE_MODE
{
    ///The width in pixels of the source mode.
    uint   width;
    ///The height in pixels of the source mode.
    uint   height;
    ///A value from the DISPLAYCONFIG_PIXELFORMAT enumeration that specifies the pixel format of the source mode.
    DISPLAYCONFIG_PIXELFORMAT pixelFormat;
    ///A POINTL structure that specifies the position in the desktop coordinate space of the upper-left corner of this
    ///source surface. The source surface that is located at (0, 0) is always the primary source surface.
    POINTL position;
}

///The DISPLAYCONFIG_TARGET_MODE structure describes a display path target mode.
struct DISPLAYCONFIG_TARGET_MODE
{
    ///A DISPLAYCONFIG_VIDEO_SIGNAL_INFO structure that contains a detailed description of the current target mode.
    DISPLAYCONFIG_VIDEO_SIGNAL_INFO targetVideoSignalInfo;
}

///The DISPLAYCONFIG_DESKTOP_IMAGE_INFO structure contains information about the image displayed on the desktop.
struct DISPLAYCONFIG_DESKTOP_IMAGE_INFO
{
    ///A POINTL structure that specifies the size of the VidPn source surface that is being displayed on the monitor.
    POINTL PathSourceSize;
    ///A RECTL structure that defines where the desktop image will be positioned within path source. Region must be
    ///completely inside the bounds of the path source size.
    RECTL  DesktopImageRegion;
    RECTL  DesktopImageClip;
}

///The DISPLAYCONFIG_MODE_INFO structure contains either source mode or target mode information.
struct DISPLAYCONFIG_MODE_INFO
{
    ///A value that indicates whether the <b>DISPLAYCONFIG_MODE_INFO</b> structure represents source or target mode
    ///information. If <b>infoType</b> is DISPLAYCONFIG_MODE_INFO_TYPE_TARGET, the <i>targetMode</i> parameter value
    ///contains a valid DISPLAYCONFIG_TARGET_MODE structure describing the specified target. If <b>infoType</b> is
    ///DISPLAYCONFIG_MODE_INFO_TYPE_SOURCE, the <i>sourceMode</i> parameter value contains a valid
    ///DISPLAYCONFIG_SOURCE_MODE structure describing the specified source.
    DISPLAYCONFIG_MODE_INFO_TYPE infoType;
    ///The source or target identifier on the specified adapter that this path relates to.
    uint id;
    ///The identifier of the adapter that this source or target mode information relates to.
    LUID adapterId;
    union
    {
        DISPLAYCONFIG_TARGET_MODE targetMode;
        DISPLAYCONFIG_SOURCE_MODE sourceMode;
        DISPLAYCONFIG_DESKTOP_IMAGE_INFO desktopImageInfo;
    }
}

///The DISPLAYCONFIG_PATH_SOURCE_INFO structure contains source information for a single path.
struct DISPLAYCONFIG_PATH_SOURCE_INFO
{
    ///The identifier of the adapter that this source information relates to.
    LUID adapterId;
    ///The source identifier on the specified adapter that this path relates to.
    uint id;
    union
    {
        uint modeInfoIdx;
        struct
        {
            uint _bitfield29;
        }
    }
    ///A bitwise OR of flag values that indicates the status of the source. The following values are supported:
    uint statusFlags;
}

///The DISPLAYCONFIG_PATH_TARGET_INFO structure contains target information for a single path.
struct DISPLAYCONFIG_PATH_TARGET_INFO
{
    ///The identifier of the adapter that the path is on.
    LUID adapterId;
    ///The target identifier on the specified adapter that this path relates to.
    uint id;
    union
    {
        uint modeInfoIdx;
        struct
        {
            uint _bitfield30;
        }
    }
    ///The target's connector type. For a list of possible values, see the DISPLAYCONFIG_VIDEO_OUTPUT_TECHNOLOGY
    ///enumerated type.
    DISPLAYCONFIG_VIDEO_OUTPUT_TECHNOLOGY outputTechnology;
    ///A value that specifies the rotation of the target. For a list of possible values, see the DISPLAYCONFIG_ROTATION
    ///enumerated type.
    DISPLAYCONFIG_ROTATION rotation;
    ///A value that specifies how the source image is scaled to the target. For a list of possible values, see the
    ///DISPLAYCONFIG_SCALING enumerated type. For more information about scaling, see Scaling the Desktop Image.
    DISPLAYCONFIG_SCALING scaling;
    ///A DISPLAYCONFIG_RATIONAL structure that specifies the refresh rate of the target. If the caller specifies target
    ///mode information, the operating system will instead use the refresh rate that is stored in the <b>vSyncFreq</b>
    ///member of the DISPLAYCONFIG_VIDEO_SIGNAL_INFO structure. In this case, the caller specifies this value in the
    ///<b>targetVideoSignalInfo</b> member of the DISPLAYCONFIG_TARGET_MODE structure. A refresh rate with both the
    ///numerator and denominator set to zero indicates that the caller does not specify a refresh rate and the operating
    ///system should use the most optimal refresh rate available. For this case, in a call to the SetDisplayConfig
    ///function, the caller must set the <b>scanLineOrdering</b> member to the
    ///DISPLAYCONFIG_SCANLINE_ORDERING_UNSPECIFIED value; otherwise, <b>SetDisplayConfig</b> fails.
    DISPLAYCONFIG_RATIONAL refreshRate;
    ///A value that specifies the scan-line ordering of the output on the target. For a list of possible values, see the
    ///DISPLAYCONFIG_SCANLINE_ORDERING enumerated type. If the caller specifies target mode information, the operating
    ///system will instead use the scan-line ordering that is stored in the <b>scanLineOrdering</b> member of the
    ///DISPLAYCONFIG_VIDEO_SIGNAL_INFO structure. In this case, the caller specifies this value in the
    ///<b>targetVideoSignalInfo</b> member of the DISPLAYCONFIG_TARGET_MODE structure.
    DISPLAYCONFIG_SCANLINE_ORDERING scanLineOrdering;
    ///A Boolean value that specifies whether the target is available. <b>TRUE</b> indicates that the target is
    ///available. Because the asynchronous nature of display topology changes when a monitor is removed, a path might
    ///still be marked as active even though the monitor has been removed. In such a case, <b>targetAvailable</b> could
    ///be <b>FALSE</b> for an active path. This is typically a transient situation that will change after the operating
    ///system takes action on the monitor removal.
    BOOL targetAvailable;
    ///A bitwise OR of flag values that indicates the status of the target. The following values are supported:
    uint statusFlags;
}

///The DISPLAYCONFIG_PATH_INFO structure is used to describe a single path from a target to a source.
struct DISPLAYCONFIG_PATH_INFO
{
    ///A DISPLAYCONFIG_PATH_SOURCE_INFO structure that contains the source information for the path.
    DISPLAYCONFIG_PATH_SOURCE_INFO sourceInfo;
    ///A DISPLAYCONFIG_PATH_TARGET_INFO structure that contains the target information for the path.
    DISPLAYCONFIG_PATH_TARGET_INFO targetInfo;
    ///A bitwise OR of flag values that indicates the state of the path. The following values are supported:
    uint flags;
}

///The DISPLAYCONFIG_DEVICE_INFO_HEADER structure contains display information about the device.
struct DISPLAYCONFIG_DEVICE_INFO_HEADER
{
    ///A DISPLAYCONFIG_DEVICE_INFO_TYPE enumerated value that determines the type of device information to retrieve or
    ///set. The remainder of the packet for the retrieve or set operation follows immediately after the
    ///DISPLAYCONFIG_DEVICE_INFO_HEADER structure.
    DISPLAYCONFIG_DEVICE_INFO_TYPE type;
    ///The size, in bytes, of the device information that is retrieved or set. This size includes the size of the header
    ///and the size of the additional data that follows the header. This device information depends on the request type.
    uint size;
    ///A locally unique identifier (LUID) that identifies the adapter that the device information packet refers to.
    LUID adapterId;
    ///The source or target identifier to get or set the device information for. The meaning of this identifier is
    ///related to the type of information being requested. For example, in the case of
    ///DISPLAYCONFIG_DEVICE_INFO_GET_SOURCE_NAME, this is the source identifier.
    uint id;
}

///The <b>DISPLAYCONFIG_SOURCE_DEVICE_NAME</b> structure contains the GDI device name for the source or view.
struct DISPLAYCONFIG_SOURCE_DEVICE_NAME
{
    ///A DISPLAYCONFIG_DEVICE_INFO_HEADER structure that contains information about the request for the source device
    ///name. The caller should set the <b>type</b> member of DISPLAYCONFIG_DEVICE_INFO_HEADER to
    ///DISPLAYCONFIG_DEVICE_INFO_GET_SOURCE_NAME and the <b>adapterId</b> and <b>id</b> members of
    ///DISPLAYCONFIG_DEVICE_INFO_HEADER to the source for which the caller wants the source device name. The caller
    ///should set the <b>size</b> member of DISPLAYCONFIG_DEVICE_INFO_HEADER to at least the size of the
    ///DISPLAYCONFIG_SOURCE_DEVICE_NAME structure.
    DISPLAYCONFIG_DEVICE_INFO_HEADER header;
    ///A NULL-terminated WCHAR string that is the GDI device name for the source, or view. This name can be used in a
    ///call to <b>EnumDisplaySettings</b> to obtain a list of available modes for the specified source.
    ushort[32] viewGdiDeviceName;
}

///The <b>DISPLAYCONFIG_TARGET_DEVICE_NAME_FLAGS</b> structure contains information about a target device.
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

///The DISPLAYCONFIG_TARGET_DEVICE_NAME structure contains information about the target.
struct DISPLAYCONFIG_TARGET_DEVICE_NAME
{
    ///A DISPLAYCONFIG_DEVICE_INFO_HEADER structure that contains information about the request for the target device
    ///name. The caller should set the <b>type</b> member of DISPLAYCONFIG_DEVICE_INFO_HEADER to
    ///DISPLAYCONFIG_DEVICE_INFO_GET_TARGET_NAME and the <b>adapterId</b> and <b>id</b> members of
    ///DISPLAYCONFIG_DEVICE_INFO_HEADER to the target for which the caller wants the target device name. The caller
    ///should set the <b>size</b> member of DISPLAYCONFIG_DEVICE_INFO_HEADER to at least the size of the
    ///DISPLAYCONFIG_TARGET_DEVICE_NAME structure.
    DISPLAYCONFIG_DEVICE_INFO_HEADER header;
    ///A DISPLAYCONFIG_TARGET_DEVICE_NAME_FLAGS structure that identifies, in bit-field flags, information about the
    ///target.
    DISPLAYCONFIG_TARGET_DEVICE_NAME_FLAGS flags;
    ///A value from the DISPLAYCONFIG_VIDEO_OUTPUT_TECHNOLOGY enumeration that specifies the target's connector type.
    DISPLAYCONFIG_VIDEO_OUTPUT_TECHNOLOGY outputTechnology;
    ///The manufacture identifier from the monitor extended display identification data (EDID). This member is set only
    ///when the <b>edidIdsValid</b> bit-field is set in the <b>flags</b> member.
    ushort      edidManufactureId;
    ///The product code from the monitor EDID. This member is set only when the <b>edidIdsValid</b> bit-field is set in
    ///the <b>flags</b> member.
    ushort      edidProductCodeId;
    ///The one-based instance number of this particular target only when the adapter has multiple targets of this type.
    ///The connector instance is a consecutive one-based number that is unique within each adapter. If this is the only
    ///target of this type on the adapter, this value is zero.
    uint        connectorInstance;
    ///A NULL-terminated WCHAR string that is the device name for the monitor. This name can be used with
    ///<i>SetupAPI.dll</i> to obtain the device name that is contained in the installation package.
    ushort[64]  monitorFriendlyDeviceName;
    ///A NULL-terminated WCHAR string that is the path to the device name for the monitor. This path can be used with
    ///<i>SetupAPI.dll</i> to obtain the device name that is contained in the installation package.
    ushort[128] monitorDevicePath;
}

///The <b>DISPLAYCONFIG_TARGET_PREFERRED_MODE</b> structure contains information about the preferred mode of a display.
struct DISPLAYCONFIG_TARGET_PREFERRED_MODE
{
    ///A DISPLAYCONFIG_DEVICE_INFO_HEADER structure that contains information about the request for the target preferred
    ///mode. The caller should set the <b>type</b> member of DISPLAYCONFIG_DEVICE_INFO_HEADER to
    ///DISPLAYCONFIG_DEVICE_INFO_GET_TARGET_PREFERRED_MODE and the <b>adapterId</b> and <b>id</b> members of
    ///DISPLAYCONFIG_DEVICE_INFO_HEADER to the target for which the caller wants the preferred mode. The caller should
    ///set the <b>size</b> member of DISPLAYCONFIG_DEVICE_INFO_HEADER to at least the size of the
    ///DISPLAYCONFIG_TARGET_PREFERRED_MODE structure.
    DISPLAYCONFIG_DEVICE_INFO_HEADER header;
    ///The width in pixels of the best mode for the monitor that is connected to the target that the <b>targetMode</b>
    ///member specifies.
    uint width;
    ///The height in pixels of the best mode for the monitor that is connected to the target that the <b>targetMode</b>
    ///member specifies.
    uint height;
    ///A DISPLAYCONFIG_TARGET_MODE structure that describes the best target mode for the monitor that is connected to
    ///the specified target.
    DISPLAYCONFIG_TARGET_MODE targetMode;
}

///The DISPLAYCONFIG_ADAPTER_NAME structure contains information about the display adapter.
struct DISPLAYCONFIG_ADAPTER_NAME
{
    ///A DISPLAYCONFIG_DEVICE_INFO_HEADER structure that contains information about the request for the adapter name.
    ///The caller should set the <b>type</b> member of DISPLAYCONFIG_DEVICE_INFO_HEADER to
    ///DISPLAYCONFIG_DEVICE_INFO_GET_ADAPTER_NAME and the <b>adapterId</b> member of DISPLAYCONFIG_DEVICE_INFO_HEADER to
    ///the adapter identifier of the adapter for which the caller wants the name. For this request, the caller does not
    ///need to set the <b>id</b> member of DISPLAYCONFIG_DEVICE_INFO_HEADER. The caller should set the <b>size</b>
    ///member of DISPLAYCONFIG_DEVICE_INFO_HEADER to at least the size of the DISPLAYCONFIG_ADAPTER_NAME structure.
    DISPLAYCONFIG_DEVICE_INFO_HEADER header;
    ushort[128] adapterDevicePath;
}

///Specifies base output technology info for a given target ID.
struct DISPLAYCONFIG_TARGET_BASE_TYPE
{
    ///A DISPLAYCONFIG_DEVICE_INFO_HEADER structure that contains info about the request for the target device name. The
    ///caller should set the <b>type</b> member of <b>DISPLAYCONFIG_DEVICE_INFO_HEADER</b> to
    ///<b>DISPLAYCONFIG_DEVICE_INFO_GET_TARGET_BASE_TYPE</b> and the <b>adapterId</b> and <b>id</b> members of
    ///<b>DISPLAYCONFIG_DEVICE_INFO_HEADER</b> to the target for which the caller wants the target device name. The
    ///caller should set the <b>size</b> member of DISPLAYCONFIG_DEVICE_INFO_HEADER to at least the size of the
    ///<b>DISPLAYCONFIG_TARGET_BASE_TYPE</b> structure.
    DISPLAYCONFIG_DEVICE_INFO_HEADER header;
    ///The base output technology, given as a constant value of the DISPLAYCONFIG_VIDEO_OUTPUT_TECHNOLOGY enumeration,
    ///of the adapter and the target specified by the <b>header</b> member. See Remarks.
    DISPLAYCONFIG_VIDEO_OUTPUT_TECHNOLOGY baseOutputTechnology;
}

///The DISPLAYCONFIG_SET_TARGET_PERSISTENCE structure contains information about setting the display.
struct DISPLAYCONFIG_SET_TARGET_PERSISTENCE
{
    ///A DISPLAYCONFIG_DEVICE_INFO_HEADER structure that contains information for setting the target persistence. The
    ///<b>type</b> member of DISPLAYCONFIG_DEVICE_INFO_HEADER is set to
    ///DISPLAYCONFIG_DEVICE_INFO_SET_TARGET_PERSISTENCE. DISPLAYCONFIG_DEVICE_INFO_HEADER also contains the adapter and
    ///target identifiers of the target to set the persistence for. The <b>size</b> member of
    ///DISPLAYCONFIG_DEVICE_INFO_HEADER is set to at least the size of the DISPLAYCONFIG_SET_TARGET_PERSISTENCE
    ///structure.
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

///The DISPLAYCONFIG_SUPPORT_VIRTUAL_RESOLUTION structure contains information on the state of virtual resolution
///support for the monitor.
struct DISPLAYCONFIG_SUPPORT_VIRTUAL_RESOLUTION
{
    ///A DISPLAYCONFIG_DEVICE_INFO_HEADER structure that holds information on the type, size, adapterID, and ID of the
    ///target the monitor is connected to.
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

///The RECT structure defines a rectangle by the coordinates of its upper-left and lower-right corners.
struct RECT
{
    ///Specifies the <i>x</i>-coordinate of the upper-left corner of the rectangle.
    int left;
    ///Specifies the <i>y</i>-coordinate of the upper-left corner of the rectangle.
    int top;
    ///Specifies the <i>x</i>-coordinate of the lower-right corner of the rectangle.
    int right;
    ///Specifies the <i>y</i>-coordinate of the lower-right corner of the rectangle.
    int bottom;
}

///The RECTL structure defines a rectangle by the coordinates of its upper-left and lower-right corners.
struct RECTL
{
    ///Specifies the <i>x</i>-coordinate of the upper-left corner of the rectangle.
    int left;
    ///Specifies the <i>y</i>-coordinate of the upper-left corner of the rectangle.
    int top;
    ///Specifies the <i>x</i>-coordinate of the lower-right corner of the rectangle.
    int right;
    ///Specifies the <i>y</i>-coordinate of the lower-right corner of the rectangle.
    int bottom;
}

///The POINT structure defines the x- and y-coordinates of a point.
struct POINT
{
    ///Specifies the <i>x</i>-coordinate of the point.
    int x;
    ///Specifies the <i>y</i>-coordinate of the point.
    int y;
}

///The POINTL structure defines the x- and y-coordinates of a point.
struct POINTL
{
    ///Specifies the <i>x</i>-coordinate of the point.
    int x;
    ///Specifies the <i>y</i>-coordinate of the point.
    int y;
}

///The SIZE structure defines the width and height of a rectangle.
struct SIZE
{
    ///Specifies the rectangle's width. The units depend on which function uses this structure.
    int cx;
    ///Specifies the rectangle's height. The units depend on which function uses this structure.
    int cy;
}

///The POINTS structure defines the x- and y-coordinates of a point.
struct POINTS
{
    ///Specifies the <i>x</i>-coordinate of the point.
    short x;
    ///Specifies the <i>y</i>-coordinate of the point.
    short y;
}

///The DDVIDEOPORTCAPS structure describes the capabilities and alignment restrictions of a hardware video port.
struct DDVIDEOPORTCAPS
{
    ///Specifies the size in bytes of the structure.
    uint   dwSize;
    ///Specify what members in this structure contain valid data. This member can be a bitwise OR of any of the
    ///following values: <table> <tr> <th>Flag</th> <th>Meaning</th> </tr> <tr> <td> DDVPD_ALIGN </td> <td> <dl> <dt>All
    ///of the alignment members are valid. These include:</dt> <dt><b>dwAlignVideoPortBoundary</b>,</dt>
    ///<dt><b>dwAlignVideoPortPrescaleWidth</b>,</dt> <dt><b>dwAlignVideoPortCropBoundary</b>, and </dt>
    ///<dt><b>dwAlignVideoPortCropWidth</b>.</dt> </dl> </td> </tr> <tr> <td> DDVPD_AUTOFLIP </td> <td> The
    ///<b>dwNumAutoFlipSurfaces</b> is valid. </td> </tr> <tr> <td> DDVPD_CAPS </td> <td> The <b>dwCaps</b> member is
    ///valid. </td> </tr> <tr> <td> DDVPD_FX </td> <td> The <b>dwFX</b> member is valid. </td> </tr> <tr> <td>
    ///DDVPD_HEIGHT </td> <td> The <b>dwMaxHeight</b> member is valid. </td> </tr> <tr> <td> DDVPD_ID </td> <td> The
    ///<b>dwVideoPortID</b> member is valid. </td> </tr> <tr> <td> DDVPD_WIDTH </td> <td> The <b>dwMaxWidth</b> and
    ///<b>dwMaxVBIWidth</b> members are valid. </td> </tr> </table>
    uint   dwFlags;
    ///Specifies the maximum field width in pixels supported by the hardware video port. This value is typically
    ///dictated by the number of bits in the width register.
    uint   dwMaxWidth;
    ///Specifies the maximum width, in number of samples, in a line of VBI data supported by the hardware video port.
    ///This value can be larger than the normal field width if the hardware video port supports oversampled VBI data.
    uint   dwMaxVBIWidth;
    ///Specifies the maximum field height in pixels supported by the hardware video port. This value is typically
    ///dictated by the number of bits in the height register.
    uint   dwMaxHeight;
    ///Specifies the hardware video port ID for this entry. This member should be the index number of this
    ///DDVIDEOPORTCAPS structure within the array to which the <b>lpDDVideoPortCaps</b> member of the
    ///DD_DIRECTDRAW_GLOBAL structure points. This value ranges from 0 to (<b>dwMaxVideoPorts</b> - 1).
    ///(<b>dwMaxVideoPorts</b> is a member of the DDCORECAPS structure.) If the device supports only one hardware video
    ///port, this member should be zero.
    uint   dwVideoPortID;
    ///Indicates a set of flags that specify the capabilities supported by this hardware video port. This member can be
    ///a bitwise OR of any of the following values: <table> <tr> <th>Flag</th> <th>Meaning</th> </tr> <tr> <td>
    ///DDVPCAPS_AUTOFLIP </td> <td> A flip can be performed automatically to avoid tearing. </td> </tr> <tr> <td>
    ///DDVPCAPS_COLORCONTROL </td> <td> The hardware video port can perform color operations on the incoming data before
    ///it is written to the frame buffer. </td> </tr> <tr> <td> DDVPCAPS_INTERLACED </td> <td> The hardware video port
    ///supports interlaced video. </td> </tr> <tr> <td> DDVPCAPS_NONINTERLACED </td> <td> The hardware video port
    ///supports noninterlaced video. </td> </tr> <tr> <td> DDVPCAPS_OVERSAMPLEDVBI </td> <td> The hardware video port
    ///can accept VBI data in a different width or format than the regular video data. </td> </tr> <tr> <td>
    ///DDVPCAPS_READBACKFIELD </td> <td> The device can return a value signifying whether the current field of an
    ///interlaced signal is even or odd. </td> </tr> <tr> <td> DDVPCAPS_READBACKLINE </td> <td> The device can return
    ///the number of the current line of video being written into the frame buffer. </td> </tr> <tr> <td>
    ///DDVPCAPS_SHAREABLE </td> <td> Ignored by Microsoft DirectDraw. </td> </tr> <tr> <td> DDVPCAPS_SKIPEVENFIELDS
    ///</td> <td> The hardware video port can automatically discard even fields of video. </td> </tr> <tr> <td>
    ///DDVPCAPS_SKIPODDFIELDS </td> <td> The hardware video port can automatically discard odd fields of video. </td>
    ///</tr> <tr> <td> DDVPCAPS_SYNCMASTER </td> <td> The device is capable of driving the graphics V-sync with the
    ///hardware video port driver V-sync. </td> </tr> <tr> <td> DDVPCAPS_SYSTEMMEMORY </td> <td> The hardware video port
    ///can write data directly to system memory. </td> </tr> <tr> <td> DDVPCAPS_VBISURFACE </td> <td> The data within
    ///the vertical blanking interval can be written to a different surface. </td> </tr> </table>
    uint   dwCaps;
    ///Indicates a set of flags that specify the effects supported by this hardware video port. This member is a bitwise
    ///OR of any of the following values: <table> <tr> <th>Flag</th> <th>Meaning</th> </tr> <tr> <td> DDVPFX_CROPTOPDATA
    ///</td> <td> The hardware video port supports limited cropping to crop out the vertical interval data. </td> </tr>
    ///<tr> <td> DDVPFX_CROPX </td> <td> The hardware video port can crop incoming data in the x direction before
    ///writing it to the surface. </td> </tr> <tr> <td> DDVPFX_CROPY </td> <td> The hardware video port can crop
    ///incoming data in the y direction before writing it to the surface. </td> </tr> <tr> <td> DDVPFX_IGNOREVBIXCROP
    ///</td> <td> The hardware video port can ignore the left and right cropping coordinates for video data when
    ///cropping oversampled VBI data. </td> </tr> <tr> <td> DDVPFX_INTERLEAVE </td> <td> The hardware video port
    ///supports interleaving interlaced fields in memory. </td> </tr> <tr> <td> DDVPFX_MIRRORLEFTRIGHT </td> <td> The
    ///hardware video port supports mirroring left to right as the video data is written into the frame buffer. </td>
    ///</tr> <tr> <td> DDVPFX_MIRRORUPDOWN </td> <td> The hardware video port supports mirroring top to bottom as the
    ///video data is written into the frame buffer. </td> </tr> <tr> <td> DDVPFX_PRESHRINKX </td> <td> Data can be
    ///arbitrarily shrunk in the x direction before it is written to the surface. </td> </tr> <tr> <td>
    ///DDVPFX_PRESHRINKXB </td> <td> Data can be shrunk by negative powers of 2 (1/2, 1/4, 1/8, and so on) in the x
    ///direction before it is written to the surface. </td> </tr> <tr> <td> DDVPFX_PRESHRINKXS </td> <td> Data can be
    ///shrunk in increments of 1/<b>dwPreshrinkXStep</b> in the x direction before it is written to the surface. </td>
    ///</tr> <tr> <td> DDVPFX_PRESHRINKY </td> <td> Data can be arbitrarily shrunk in the y direction before it is
    ///written to the surface. </td> </tr> <tr> <td> DDVPFX_PRESHRINKYB </td> <td> Data can be shrunk by negative powers
    ///of 2 (1/2, 1/4, 1/8, and so on) in the y direction before it is written to the surface. </td> </tr> <tr> <td>
    ///DDVPFX_PRESHRINKYS </td> <td> Data can be shrunk in increments of 1/<b>dwPreshrinkYStep</b> in the y direction
    ///before it is written to the surface. </td> </tr> <tr> <td> DDVPFX_PRESTRETCHX </td> <td> Data can be arbitrarily
    ///stretched in the x direction before it is written to the surface. </td> </tr> <tr> <td> DDVPFX_PRESTRETCHXN </td>
    ///<td> Data can be stretched by integer factors in the x direction before it is written to the surface. </td> </tr>
    ///<tr> <td> DDVPFX_PRESTRETCHY </td> <td> Data can be arbitrarily stretched in the y direction before it is written
    ///to the surface. </td> </tr> <tr> <td> DDVPFX_PRESTRETCHYN </td> <td> Data can be stretched by integer factors in
    ///the y direction before it is written to the surface. </td> </tr> <tr> <td> DDVPFX_VBICONVERT </td> <td> Data
    ///within the vertical blanking interval can be converted independent of the remaining video data. </td> </tr> <tr>
    ///<td> DDVPFX_VBINOSCALE </td> <td> Scaling can be disabled for data within the vertical blanking interval. </td>
    ///</tr> </table>
    uint   dwFX;
    ///Specifies the maximum number of surfaces supported in the autoflip chain, if the hardware video port supports
    ///autoflipping. If the hardware video port does not support autoflipping, the driver should set this member to
    ///zero.
    uint   dwNumAutoFlipSurfaces;
    ///Specifies the byte alignment restriction, in bytes, of where the hardware video port can be oriented relative to
    ///the origin of the surface in the x direction.
    uint   dwAlignVideoPortBoundary;
    ///Specifies the byte alignment restriction, in bytes, of how wide the hardware video port data can be when
    ///prescaling is performed.
    uint   dwAlignVideoPortPrescaleWidth;
    ///Specifies the byte alignment restriction, in bytes, for the left cropping coordinate.
    uint   dwAlignVideoPortCropBoundary;
    ///Specifies the byte alignment restriction, in bytes, for the width of the cropping rectangle.
    uint   dwAlignVideoPortCropWidth;
    ///Indicates that the hardware video port can shrink the video data width in steps of 1/<b>dwPreshrinkXStep</b>.
    ///This member is valid only when the DDVPFX_PRESHRINKXS capability is specified.
    uint   dwPreshrinkXStep;
    ///Indicates that the hardware video port can shrink the video data height in steps of 1/<b>dwPreshrinkYStep</b>.
    ///This member is valid only when the DDVPFX_PRESHRINKYS capability is specified.
    uint   dwPreshrinkYStep;
    ///Specifies the maximum number of surfaces supported in the autoflip chain, if the hardware video port supports
    ///autoflipping. If the hardware video port does not support autoflipping, the driver should set this member to
    ///zero. This member works the same way as <b>dwNumAutoFlipSurfaces</b> except that it pertains only to devices that
    ///can send the VBI data to a different surface than that to which the normal video is being written.
    uint   dwNumVBIAutoFlipSurfaces;
    ///Specifies the optimal number of autoflippable surfaces supported by the hardware.
    uint   dwNumPreferredAutoflip;
    ///Indicates the number of taps the prescaler uses in the x direction. A value of 0 indicates no prescale, a value
    ///of 1 indicates replication, and so on.
    ushort wNumFilterTapsX;
    ///Indicates the number of taps the prescaler uses in the y direction. A value of 0 indicates no prescale, a value
    ///of 1 indicates replication, and so on.
    ushort wNumFilterTapsY;
}

///The DDVIDEOPORTDESC structure describes the video port extensions (VPE) object being created.
struct DDVIDEOPORTDESC
{
    ///Specifies the size in bytes of the DDVIDEOPORTDESC structure.
    uint               dwSize;
    ///Specifies the width in pixels of the incoming video stream.
    uint               dwFieldWidth;
    ///Specifies the width, in number of samples, of the VBI data in the incoming video stream.
    uint               dwVBIWidth;
    ///Specifies the field height in scan lines of the incoming video stream.
    uint               dwFieldHeight;
    ///Specifies the time interval in microseconds between live video VSYNCs. This number should be rounded up to the
    ///nearest whole microsecond.
    uint               dwMicrosecondsPerField;
    ///Specifies the maximum pixel rate per second.
    uint               dwMaxPixelsPerSecond;
    ///Specifies the ID of the hardware video port to be used. This ID should range from 0 to (<b>dwMaxVideoPorts</b>
    ///-1), where <b>dwMaxVideoPorts</b> is a member of the DDCORECAPS structure.
    uint               dwVideoPortID;
    ///Reserved for system use and should be ignored by the driver.
    uint               dwReserved1;
    ///Specifies a DDVIDEOPORTCONNECT structure describing the connection characteristics of the hardware video port.
    DDVIDEOPORTCONNECT VideoPortType;
    ///Reserved for future use and should be ignored by the driver.
    size_t             dwReserved2;
    ///Reserved for future use and should be ignored by the driver.
    size_t             dwReserved3;
}

///The DDVIDEOPORTINFO structure describes how the driver should transfer video data to a surface (or to surfaces);
///DDVIDEOPORTINFO is a member of the DD_VIDEOPORT_LOCAL structure.
struct DDVIDEOPORTINFO
{
    ///Specifies the size in bytes of the structure. This member must be initialized before the structure is used.
    uint           dwSize;
    ///Indicates the x placement of the video data within the surface, in pixels. This offset applies to all surfaces
    ///when autoflipping is requested.
    uint           dwOriginX;
    ///Indicates the y placement of the video data within the surface, in pixels. This offset applies to all surfaces
    ///when autoflipping is requested.
    uint           dwOriginY;
    ///Indicates a set of flags that specify how the driver should transfer the video data. This member can be a bitwise
    ///OR of the following values: <table> <tr> <th>Flag</th> <th>Meaning</th> </tr> <tr> <td> DDVP_AUTOFLIP </td> <td>
    ///Perform automatic flipping. Auto-flipping is performed between the overlay surface that was attached to the
    ///hardware video port and the overlay surfaces that are attached to the surface. The flip order is the order in
    ///which the overlay surfaces were attached. </td> </tr> <tr> <td> DDVP_CONVERT </td> <td> The video data and target
    ///surface have different formats. The driver should convert the video data to the format of the target surface
    ///format. </td> </tr> <tr> <td> DDVP_CROP </td> <td> The driver should crop both the video and VBI data using the
    ///rectangle in the <b>rCrop</b> member. </td> </tr> <tr> <td> DDVP_IGNOREVBIXCROP </td> <td> The driver should
    ///ignore the left and right cropping coordinates when cropping the VBI data. </td> </tr> <tr> <td> DDVP_INTERLEAVE
    ///</td> <td> Interlaced fields of both video and VBI data should be interleaved in memory. </td> </tr> <tr> <td>
    ///DDVP_MIRRORLEFTRIGHT </td> <td> Video data should be mirrored left to right as it is written into the frame
    ///buffer. </td> </tr> <tr> <td> DDVP_MIRRORUPDOWN </td> <td> Video data should be mirrored top to bottom as it is
    ///written into the frame buffer. </td> </tr> <tr> <td> DDVP_NOINTERLEAVE </td> <td> If the DDVP_INTERLEAVE flag is
    ///set, the driver should interleave the video data only; that is, the driver should not interleave the VBI data.
    ///</td> </tr> <tr> <td> DDVP_OVERRIDEBOBWEAVE </td> <td> The bob and weave decisions should not be overridden by
    ///other interfaces. If this flag is set, Microsoft DirectDraw does not allow a kernel-mode driver to use the
    ///kernel-mode video transport functionality to switch the hardware between bob and weave modes. </td> </tr> <tr>
    ///<td> DDVP_PRESCALE </td> <td> Perform prescaling/zooming based on the <b>dwPrescaleWidth</b> and
    ///<b>dwPrescaleHeight</b> members. The driver should prescale only the video data if DDVP_VBINOSCALE is set;
    ///otherwise, it should prescale both the video and VBI data. </td> </tr> <tr> <td> DDVP_SKIPEVENFIELDS </td> <td>
    ///Ignore input of even fields for both video and VBI data. </td> </tr> <tr> <td> DDVP_SKIPODDFIELDS </td> <td>
    ///Ignore input of odd fields for both video and VBI data. </td> </tr> <tr> <td> DDVP_SYNCMASTER </td> <td> Drive
    ///the graphics VSYNCs using the hardware video port VSYNCs. </td> </tr> <tr> <td> DDVP_VBICONVERT </td> <td> The
    ///DDPIXELFORMAT structure to which the <b>lpddpfVBIOutputFormat</b> member points contains data that should be used
    ///to convert the data within the vertical blanking interval. </td> </tr> <tr> <td> DDVP_VBINOSCALE </td> <td> Data
    ///within the vertical blanking interval should not be scaled. </td> </tr> </table>
    uint           dwVPFlags;
    ///Specifies a RECT structure that specifies a cropping rectangle in pixels. This member contains a valid rectangle
    ///when the DDVP_CROP flag is set in the <b>dwVPFlags</b> member.
    RECT           rCrop;
    ///Specifies the width in pixels to which the video and VBI data should be prescaled or zoomed. For example, if the
    ///video data is 720 pixels wide and the client requests the width cut in half, the client specifies 360 in
    ///<b>dwPrescaleWidth</b>. This member contains a valid width when the DDVP_PRESCALE flag is set in the
    ///<b>dwVPFlags</b> member.
    uint           dwPrescaleWidth;
    ///Specifies the height in pixels to which the video and VBI data should be prescaled or zoomed. For example, if the
    ///video data is 240 pixels wide and the client requests the width cut in half, the client specifies 120 in
    ///<b>dwPrescaleHeight</b>. This member contains a valid width when the DDVP_PRESCALE flag is set in the
    ///<b>dwVPFlags</b> member.
    uint           dwPrescaleHeight;
    ///Points to a DDPIXELFORMAT structure that specifies the format of the video data to be written to the video port
    ///extensions (VPE) object. This format can be different from the target surface format if the VPE object performs a
    ///conversion.
    DDPIXELFORMAT* lpddpfInputFormat;
    ///Points to a DDPIXELFORMAT structure that specifies the input format of the data within the vertical blanking
    ///interval.
    DDPIXELFORMAT* lpddpfVBIInputFormat;
    ///Points to a DDPIXELFORMAT structure that specifies the output format of the data within the vertical blanking
    ///interval.
    DDPIXELFORMAT* lpddpfVBIOutputFormat;
    ///Specifies the number of lines of data within the vertical blanking interval.
    uint           dwVBIHeight;
    ///Reserved for system use and should be ignored by the driver.
    size_t         dwReserved1;
    ///Reserved for system use and should be ignored by the driver.
    size_t         dwReserved2;
}

///The DDVIDEOPORTBANDWIDTH structure describes the bandwidth characteristics of an overlay when used with a particular
///video port extensions (VPE) object/pixel format configuration.
struct DDVIDEOPORTBANDWIDTH
{
    ///Specifies the size in bytes of this DDVIDEOPORTBANDWIDTH structure.
    uint   dwSize;
    ///Specifies the dependencies of the bandwidth. The driver's DdVideoPortGetBandwidth function sets this member to
    ///one of the following values: <table> <tr> <th>Flag</th> <th>Meaning</th> </tr> <tr> <td> DDVPBCAPS_DESTINATION
    ///</td> <td> The device's capabilities are described in terms of the destination overlay's minimum stretch factor.
    ///The bandwidth information set by the driver in the <b>dwOverlay</b>, <b>dwColorkey</b>, <b>dwYInterpolate</b>,
    ///and <b>dwYInterpAndColorkey</b> members refers to the destination overlay size. </td> </tr> <tr> <td>
    ///DDVPBCAPS_SOURCE </td> <td> The device's capabilities are described in terms of the required source overlay's
    ///rectangle size (in pixels). The bandwidth information set by the driver in the <b>dwOverlay</b>,
    ///<b>dwColorkey</b>, <b>dwYInterpolate</b>, and <b>dwYInterpAndColorkey</b> members refers to the source overlay
    ///size. </td> </tr> </table>
    uint   dwCaps;
    ///Specifies the stretch factor or overlay source size at which the device can support an overlay, multiplied by
    ///1000. The driver sets this value based on its device's type and capabilities, and on the dimensions specified in
    ///the <b>dwWidth</b> and <b>dwHeight</b> members of the DD_GETVPORTBANDWIDTHDATA structure passed to
    ///DdVideoPortGetBandwidth. For example, a stretch factor of 2 is specified as 2000, and an overlay source size of
    ///750 indicates that the specified source overlay be shrunk to 75 percent of its original size. The driver must
    ///return a valid number in this member.
    uint   dwOverlay;
    ///Specifies the stretch factor or overlay source size at which an overlay with color keying is supported,
    ///multiplied by 1000. The driver sets this value based on its device's type and capabilities, and on the dimensions
    ///specified in the <b>dwWidth</b> and <b>dwHeight</b> members of the DD_GETVPORTBANDWIDTHDATA structure passed to
    ///DdVideoPortGetBandwidth. For example, a stretch factor of 2 is specified as 2000.
    uint   dwColorkey;
    ///Specifies the stretch factor or overlay source size at which an overlay with y-axis interpolation is supported,
    ///multiplied by 1000. The driver sets this value based on its device's type and capabilities, and on the dimensions
    ///specified in the <b>dwWidth</b> and <b>dwHeight</b> members of the DD_GETVPORTBANDWIDTHDATA structure passed to
    ///DdVideoPortGetBandwidth. For example, a stretch factor of 2 is specified as 2000.
    uint   dwYInterpolate;
    ///Specifies the stretch factor or overlay source size at which an overlay with y-axis interpolation and color
    ///keying is supported, multiplied by 1000. The driver sets this value based on its device's type and capabilities,
    ///and on the dimensions specified in the <b>dwWidth</b> and <b>dwHeight</b> members of the DD_GETVPORTBANDWIDTHDATA
    ///structure passed to DdVideoPortGetBandwidth. For example, a stretch factor of 2 is specified as 2000.
    uint   dwYInterpAndColorkey;
    ///Reserved for system use and should be ignored by the driver.
    size_t dwReserved1;
    ///Reserved for system use and should be ignored by the driver.
    size_t dwReserved2;
}

///The DD_GETHEAPALIGNMENTDATA structure contains data on required alignments from a particular heap.
struct DD_GETHEAPALIGNMENTDATA
{
}

///The VIDEOMEMORY structure allows the driver to manage its display memory into heaps.
struct VIDEOMEMORY
{
    ///Specifies a set of flags that describe this particular section of display memory. This member can be a bitwise OR
    ///of any of the following values: <table> <tr> <th>Flag</th> <th>Meaning</th> </tr> <tr> <td> VIDMEM_ISLINEAR </td>
    ///<td> The display memory is a contiguous block of memory. </td> </tr> <tr> <td> VIDMEM_ISRECTANGULAR </td> <td>
    ///The display memory is rectangular. </td> </tr> <tr> <td> VIDMEM_ISHEAP </td> <td> This flagais reserved for
    ///system use and should be ignored by the driver. </td> </tr> <tr> <td> VIDMEM_ISNONLOCAL </td> <td> The heap
    ///resides in nonlocal (AGP) memory. </td> </tr> <tr> <td> VIDMEM_ISWC </td> <td> The driver has enabled
    ///write-combining on the display memory in this heap. Write-combining is a special caching mode in Pentium
    ///Pro-class processors that batches writes to the same cache line so they can be transferred in a single bus clock.
    ///Write-combining does not preserve ordering of the writes, a tradeoff that is usually acceptable for frame
    ///buffers. Refer to Intel documentation for more information about write-combining. This flag cannot be used unless
    ///the VIDMEM_ISNONLOCAL flag is also set. </td> </tr> <tr> <td> VIDMEM_HEAPDISABLED </td> <td> The Microsoft
    ///DirectDraw runtime uses this flag to turn off a heap when the heap's initialization has failed. This most likely
    ///occurs with an AGP heap. The driver should not set this bit. </td> </tr> </table>
    uint    dwFlags;
    ///Points to the starting address of a memory range in the heap.
    size_t  fpStart;
    union
    {
        size_t fpEnd;
        uint   dwWidth;
    }
    ///Specifies a DDSCAPS structure in which the driver returns the capabilities for which this section of memory
    ///cannot be used.
    DDSCAPS ddsCaps;
    ///Specifies a DDSCAPS structure in which the driver returns the capabilities for which this chunk of memory cannot
    ///be used when no other memory is found on the first pass.
    DDSCAPS ddsCapsAlt;
    union
    {
        VMEMHEAP* lpHeap;
        uint      dwHeight;
    }
}

///The VIDEOMEMORYINFO structure describes the general format of the display's memory.
struct VIDEOMEMORYINFO
{
    ///Specifies the offset, in bytes, in display memory to the primary surface.
    size_t        fpPrimary;
    ///Currently unused and should be set to zero.
    uint          dwFlags;
    ///Specifies the current width of the display, in pixels.
    uint          dwDisplayWidth;
    ///Specifies the current height of the display, in pixels.
    uint          dwDisplayHeight;
    ///Specifies the current pitch of the display, in bytes.
    int           lDisplayPitch;
    ///Specifies a DDPIXELFORMAT structure in which the pixel format of the display is described.
    DDPIXELFORMAT ddpfDisplay;
    ///Specifies the byte alignment, in bytes, required when allocating this memory for offscreen surfaces.
    uint          dwOffscreenAlign;
    ///Specifies the byte alignment, in bytes, required when allocating this memory for overlay planes.
    uint          dwOverlayAlign;
    ///Specifies the byte alignment, in bytes, required when allocating this memory for textures.
    uint          dwTextureAlign;
    ///Specifies the byte alignment, in bytes, required when allocating this memory for the depth buffer.
    uint          dwZBufferAlign;
    ///Specifies the byte alignment, in bytes, required when allocating this memory for an alpha buffer.
    uint          dwAlphaAlign;
    ///(Microsoft Windows 2000 and later only) Specifies a kernel-mode pointer to the beginning of the primary surface.
    void*         pvPrimary;
}

///The DD_CALLBACKS structure contains entry pointers to the callback functions that a device driver supports.
struct DD_CALLBACKS
{
    ///Specifies the size in bytes of this structure.
    uint                 dwSize;
    ///Indicates what Microsoft DirectDraw callback functions the driver has implemented. For every bit set in
    ///<b>dwFlags</b>, the driver must initialize the corresponding function pointer member of this structure. This
    ///member can be one or more of the following flags: <dl> <dt>DDHAL_CB32_CANCREATESURFACE</dt>
    ///<dt>DDHAL_CB32_CREATEPALETTE</dt> <dt>DDHAL_CB32_CREATESURFACE</dt> <dt>DDHAL_CB32_GETSCANLINE</dt>
    ///<dt>DDHAL_CB32_MAPMEMORY</dt> <dt>DDHAL_CB32_SETCOLORKEY</dt> <dt>DDHAL_CB32_SETMODE</dt>
    ///<dt>DDHAL_CB32_WAITFORVERTICALBLANK</dt> </dl>
    uint                 dwFlags;
    ///Unused on Microsoft Windows 2000 and later and should be ignored by the driver.
    PDD_DESTROYDRIVER    DestroyDriver;
    ///Points to the driver-supplied DdCreateSurface callback.
    PDD_CREATESURFACE    CreateSurface;
    ///Points to the driver-supplied DdSetColorKey callback.
    PDD_SETCOLORKEY      SetColorKey;
    ///Unused on Windows 2000 and later and should be ignored by the driver.
    PDD_SETMODE          SetMode;
    ///Points to the driver-supplied DdWaitForVerticalBlank callback.
    PDD_WAITFORVERTICALBLANK WaitForVerticalBlank;
    ///Points to the driver-supplied DdCanCreateSurface callback.
    PDD_CANCREATESURFACE CanCreateSurface;
    ///Points to the driver-supplied DdCreatePalette callback.
    PDD_CREATEPALETTE    CreatePalette;
    ///Points to the driver-supplied DdGetScanLine callback.
    PDD_GETSCANLINE      GetScanLine;
    ///Points to the driver-supplied DdMapMemory callback.
    PDD_MAPMEMORY        MapMemory;
}

///The DD_MISCELLANEOUSCALLBACKS structure contains an entry pointer to the memory query callback that a device driver
///supports.
struct DD_MISCELLANEOUSCALLBACKS
{
    ///Specifies the size in bytes of this DD_MISCELLANEOUSCALLBACKS structure.
    uint dwSize;
    ///Indicates whether the device supports the DdGetAvailDriverMemory callback. The driver sets this member to
    ///DDHAL_MISCCB32_GETAVAILDRIVERMEMORY when it implements the callback.
    uint dwFlags;
    ///Points to the driver-supplied DdGetAvailDriverMemory callback.
    PDD_GETAVAILDRIVERMEMORY GetAvailDriverMemory;
}

///The DD_MISCELLANEOUS2CALLBACKS structure is used to return the addresses of miscellaneous callback routines. These
///routines are new for Microsoft DirectX 7.0 and later and are exposed through DdGetDriverInfo by responding to the
///GUID_Miscellaneous2Callbacks GUID.
struct DD_MISCELLANEOUS2CALLBACKS
{
    ///Specifies the size, in bytes, of this structure.
    uint                dwSize;
    ///Indicates which miscellaneous callback functions the driver implemented. For every bit set in <b>dwFlags</b>, the
    ///driver must initialize the corresponding function pointer member of this structure. This member can be one or
    ///more of the following flags: <dl> <dt>DDHAL_MISC2CB32_CREATESURFACEEX</dt>
    ///<dt>DDHAL_MISC2CB32_GETDRIVERSTATE</dt> <dt>DDHAL_MISC2CB32_DESTROYDDLOCAL</dt> </dl>
    uint                dwFlags;
    ///Unused and must be set to <b>NULL</b>.
    PDD_ALPHABLT        AlphaBlt;
    ///Points to the driver's D3dCreateSurfaceEx implementation. This callback creates an association between a
    ///DirectDraw surface and a small integer handle.
    PDD_CREATESURFACEEX CreateSurfaceEx;
    ///Points to the driver's D3dGetDriverState implementation.
    PDD_GETDRIVERSTATE  GetDriverState;
    ///Points to the driver's D3dDestroyDDLocal implementation. Used to destroy the local copy of the device context.
    PDD_DESTROYDDLOCAL  DestroyDDLocal;
}

///The DD_NTCALLBACKS structure contains entry pointers to Microsoft Windows 2000 and later Microsoft DirectDraw
///callback functions that a device driver supports.
struct DD_NTCALLBACKS
{
    ///Specifies the size in bytes of this DD_NTCALLBACKS structure.
    uint                 dwSize;
    ///Indicates what Windows 2000 and later callback functions the driver has implemented. For every bit set in
    ///<b>dwFlags</b>, the driver must initialize the corresponding function pointer member of this structure. This
    ///member can be one or more of the following flags: <dl> <dt>DDHAL_NTCB32_FREEDRIVERMEMORY</dt>
    ///<dt>DDHAL_NTCB32_SETEXCLUSIVEMODE</dt> <dt>DDHAL_NTCB32_FLIPTOGDISURFACE</dt> </dl>
    uint                 dwFlags;
    ///Points to the driver-supplied DdFreeDriverMemory callback.
    PDD_FREEDRIVERMEMORY FreeDriverMemory;
    ///Points to the driver-supplied DdSetExclusiveMode callback.
    PDD_SETEXCLUSIVEMODE SetExclusiveMode;
    ///Points to the driver-supplied DdFlipToGDISurface callback.
    PDD_FLIPTOGDISURFACE FlipToGDISurface;
}

///The DD_PALETTECALLBACKS structure contains entry pointers to the DirectDraw palette callback functions that a device
///driver supports.
struct DD_PALETTECALLBACKS
{
    ///Specifies the size in bytes of this DD_PALETTECALLBACKS structure.
    uint                 dwSize;
    ///Indicates what DirectDrawPalette callback functions the driver has implemented. For every bit set in
    ///<b>dwFlags</b>, the driver must initialize the corresponding function pointer member of this structure. This
    ///member can be one or more of the following flags: <dl> <dt>DDHAL_PALCB32_DESTROYPALETTE</dt>
    ///<dt>DDHAL_PALCB32_SETENTRIES</dt> </dl>
    uint                 dwFlags;
    ///Points to the driver-supplied DdDestroyPalette palette callback.
    PDD_PALCB_DESTROYPALETTE DestroyPalette;
    ///Points to the driver-supplied DdSetEntries palette callback.
    PDD_PALCB_SETENTRIES SetEntries;
}

///The DD_SURFACECALLBACKS structure contains entry pointers to the Microsoft DirectDraw surface callback functions that
///a device driver supports.
struct DD_SURFACECALLBACKS
{
    ///Specifies the size in bytes of the DD_SURFACECALLBACKS structure. This member is unused by Microsoft Windows 2000
    ///and later versions.
    uint              dwSize;
    ///Indicates which DirectDrawSurface callback functions the driver has implemented. For every bit set in
    ///<b>dwFlags</b>, the driver must initialize the corresponding function pointer member of this structure. This
    ///member can be one or more of the following flags: <dl> <dt>DDHAL_SURFCB32_DESTROYSURFACE</dt>
    ///<dt>DDHAL_SURFCB32_FLIP</dt> <dt>DDHAL_SURFCB32_SETCLIPLIST</dt> <dt>DDHAL_SURFCB32_LOCK</dt>
    ///<dt>DDHAL_SURFCB32_UNLOCK</dt> <dt>DDHAL_SURFCB32_BLT</dt> <dt>DDHAL_SURFCB32_SETCOLORKEY</dt>
    ///<dt>DDHAL_SURFCB32_ADDATTACHEDSURFACE</dt> <dt>DDHAL_SURFCB32_GETBLTSTATUS</dt>
    ///<dt>DDHAL_SURFCB32_GETFLIPSTATUS</dt> <dt>DDHAL_SURFCB32_UPDATEOVERLAY</dt>
    ///<dt>DDHAL_SURFCB32_SETOVERLAYPOSITION</dt> <dt>DDHAL_SURFCB32_SETPALETTE</dt> </dl>
    uint              dwFlags;
    ///Points to the driver-supplied DdDestroySurface surface callback.
    PDD_SURFCB_DESTROYSURFACE DestroySurface;
    ///Points to the driver-supplied DdFlip surface callback.
    PDD_SURFCB_FLIP   Flip;
    ///Points to the driver-supplied DdSetClipList surface callback.
    PDD_SURFCB_SETCLIPLIST SetClipList;
    ///Points to the driver-supplied DdLock surface callback.
    PDD_SURFCB_LOCK   Lock;
    ///Points to the driver-supplied DdUnlock surface callback.
    PDD_SURFCB_UNLOCK Unlock;
    ///Points to the driver-supplied DdBlt surface callback.
    PDD_SURFCB_BLT    Blt;
    ///Points to the driver-supplied DdSetColorKey surface callback.
    PDD_SURFCB_SETCOLORKEY SetColorKey;
    ///Points to the driver-supplied DdAddAttachedSurface surface callback.
    PDD_SURFCB_ADDATTACHEDSURFACE AddAttachedSurface;
    ///Points to the driver-supplied DdGetBltStatus surface callback.
    PDD_SURFCB_GETBLTSTATUS GetBltStatus;
    ///Points to the driver-supplied DdGetFlipStatus surface callback.
    PDD_SURFCB_GETFLIPSTATUS GetFlipStatus;
    ///Points to the driver-supplied DdUpdateOverlay surface callback.
    PDD_SURFCB_UPDATEOVERLAY UpdateOverlay;
    ///Points to the driver-supplied DdSetOverlayPosition surface callback.
    PDD_SURFCB_SETOVERLAYPOSITION SetOverlayPosition;
    ///Reserved for system use and should be ignored by the driver.
    void*             reserved4;
    ///Points to the driver-supplied DdSetPalette surface callback.
    PDD_SURFCB_SETPALETTE SetPalette;
}

///The DD_VIDEOPORTCALLBACKS structure contains entry pointers to Microsoft DirectDraw video port extensions (VPE)
///callback functions that a device driver supports.
struct DD_VIDEOPORTCALLBACKS
{
    ///Specifies the size in bytes of this DD_VIDEOPORTCALLBACKS structure.
    uint                 dwSize;
    ///Indicates what VPE callback functions the driver has implemented. For every bit set in <b>dwFlags</b>, the driver
    ///must initialize the corresponding function pointer member of this structure. This member can be one or more of
    ///the following flags: <dl> <dt>DDHAL_VPORT32_CANCREATEVIDEOPORT</dt> <dt>DDHAL_VPORT32_CREATEVIDEOPORT</dt>
    ///<dt>DDHAL_VPORT32_FLIP</dt> <dt>DDHAL_VPORT32_GETBANDWIDTH</dt> <dt>DDHAL_VPORT32_GETINPUTFORMATS</dt>
    ///<dt>DDHAL_VPORT32_GETOUTPUTFORMATS</dt> <dt>DDHAL_VPORT32_GETAUTOFLIPSURF</dt> <dt>DDHAL_VPORT32_GETFIELD</dt>
    ///<dt>DDHAL_VPORT32_GETLINE</dt> <dt>DDHAL_VPORT32_GETCONNECT</dt> <dt>DDHAL_VPORT32_DESTROY</dt>
    ///<dt>DDHAL_VPORT32_GETFLIPSTATUS</dt> <dt>DDHAL_VPORT32_UPDATE</dt> <dt>DDHAL_VPORT32_WAITFORSYNC</dt>
    ///<dt>DDHAL_VPORT32_GETSIGNALSTATUS</dt> <dt>DDHAL_VPORT32_COLORCONTROL</dt> </dl>
    uint                 dwFlags;
    ///Points to the driver-supplied DdVideoPortCanCreate callback.
    PDD_VPORTCB_CANCREATEVIDEOPORT CanCreateVideoPort;
    ///Points to the driver-supplied DdVideoPortCreate callback.
    PDD_VPORTCB_CREATEVIDEOPORT CreateVideoPort;
    ///Points to the driver-supplied DdVideoPortFlip callback.
    PDD_VPORTCB_FLIP     FlipVideoPort;
    ///Points to the driver-supplied DdVideoPortGetBandwidth callback.
    PDD_VPORTCB_GETBANDWIDTH GetVideoPortBandwidth;
    ///Points to the driver-supplied DdVideoPortGetInputFormats callback.
    PDD_VPORTCB_GETINPUTFORMATS GetVideoPortInputFormats;
    ///Points to the driver-supplied DdVideoPortGetOutputFormats callback.
    PDD_VPORTCB_GETOUTPUTFORMATS GetVideoPortOutputFormats;
    ///Reserved for system use and should be ignored by the driver.
    void*                lpReserved1;
    ///Points to the driver-supplied DdVideoPortGetField callback.
    PDD_VPORTCB_GETFIELD GetVideoPortField;
    ///Points to the driver-supplied DdVideoPortGetLine callback.
    PDD_VPORTCB_GETLINE  GetVideoPortLine;
    ///Points to the driver-supplied DdVideoPortGetConnectInfo callback.
    PDD_VPORTCB_GETVPORTCONNECT GetVideoPortConnectInfo;
    ///Points to the driver-supplied DdVideoPortDestroy callback.
    PDD_VPORTCB_DESTROYVPORT DestroyVideoPort;
    ///Points to the driver-supplied DdVideoPortGetFlipStatus callback.
    PDD_VPORTCB_GETFLIPSTATUS GetVideoPortFlipStatus;
    ///Points to the driver-supplied DdVideoPortUpdate callback.
    PDD_VPORTCB_UPDATE   UpdateVideoPort;
    ///Points to the driver-supplied DdVideoPortWaitForSync callback.
    PDD_VPORTCB_WAITFORSYNC WaitForVideoPortSync;
    ///Points to the driver-supplied DdVideoPortGetSignalStatus callback.
    PDD_VPORTCB_GETSIGNALSTATUS GetVideoSignalStatus;
    ///Points to the driver-supplied DdVideoPortColorControl callback.
    PDD_VPORTCB_COLORCONTROL ColorControl;
}

///The DD_COLORCONTROLCALLBACKS structure contains an entry pointer to the Microsoft DirectDraw color control callback
///that a device driver supports.
struct DD_COLORCONTROLCALLBACKS
{
    ///Specifies the size in bytes of this DD_COLORCONTROLCALLBACKS structure.
    uint dwSize;
    ///Indicates whether the device supports the color control callback identified by <b>ColorControl</b>. The driver
    ///should set this member to be DDHAL_COLOR_COLORCONTROL when it implements the color control callback.
    uint dwFlags;
    ///Points to the driver-supplied DdControlColor callback.
    PDD_COLORCB_COLORCONTROL ColorControl;
}

///The DD_KERNELCALLBACKS structure contains entry pointers to the DirectDraw kernel-mode callback functions that the
///driver supports.
struct DD_KERNELCALLBACKS
{
    ///Specifies the size in bytes of this DD_KERNELCALLBACKS structure.
    uint dwSize;
    ///Indicates what Microsoft DirectDraw kernel callback functions the driver has implemented. For every bit set in
    ///<b>dwFlags</b>, the driver must initialize the corresponding function pointer member of this structure. This
    ///member can be one or more of the following flags: <dl> <dt>DDHAL_KERNEL_SYNCSURFACEDATA </dt>
    ///<dt>DDHAL_KERNEL_SYNCVIDEOPORTDATA </dt> </dl>
    uint dwFlags;
    ///Points to the driver-supplied DdSyncSurfaceData callback.
    PDD_KERNELCB_SYNCSURFACE SyncSurfaceData;
    ///Points to the driver-supplied DdSyncVideoPortData callback.
    PDD_KERNELCB_SYNCVIDEOPORT SyncVideoPortData;
}

///The DD_MOTIONCOMPCALLBACKS structure contains entry pointers to the motion compensation callback functions that a
///device driver supports.
struct DD_MOTIONCOMPCALLBACKS
{
    ///Specifies the size in bytes of this DD_MOTIONCOMPCALLBACKS structure.
    uint                 dwSize;
    ///Indicates what additional Microsoft DirectDraw motion compensation callback functions the driver has implemented.
    ///For every bit set in <b>dwFlags</b>, the driver must initialize the corresponding function pointer member of this
    ///structure. This member can be one or more of the following flags: <dl> <dt>DDHAL_MOCOMP32_BEGINFRAME</dt>
    ///<dt>DDHAL_MOCOMP32_CREATE</dt> <dt>DDHAL_MOCOMP32_DESTROY</dt> <dt>DDHAL_MOCOMP32_GETCOMPBUFFINFO</dt>
    ///<dt>DDHAL_MOCOMP32_GETINTERNALINFO</dt> <dt>DDHAL_MOCOMP32_ENDFRAME</dt> <dt>DDHAL_MOCOMP32_GETFORMATS</dt>
    ///<dt>DDHAL_MOCOMP32_GETGUIDS</dt> <dt>DDHAL_MOCOMP32_QUERYSTATUS</dt> <dt>DDHAL_MOCOMP32_RENDER</dt> </dl>
    uint                 dwFlags;
    ///Points to the driver-supplied DdMoCompGetGuids callback function.
    PDD_MOCOMPCB_GETGUIDS GetMoCompGuids;
    ///Points to the driver-supplied DdMoCompGetFormats callback function.
    PDD_MOCOMPCB_GETFORMATS GetMoCompFormats;
    ///Points to the driver-supplied DdMoCompCreate callback function.
    PDD_MOCOMPCB_CREATE  CreateMoComp;
    ///Points to the driver-supplied DdMoCompGetBuffInfo callback function.
    PDD_MOCOMPCB_GETCOMPBUFFINFO GetMoCompBuffInfo;
    ///Points to the driver-supplied DdMoCompGetInternalInfo callback function.
    PDD_MOCOMPCB_GETINTERNALINFO GetInternalMoCompInfo;
    ///Points to the driver-supplied DdMoCompBeginFrame callback function.
    PDD_MOCOMPCB_BEGINFRAME BeginMoCompFrame;
    ///Points to the driver-supplied DdMoCompEndFrame callback function.
    PDD_MOCOMPCB_ENDFRAME EndMoCompFrame;
    ///Points to the driver-supplied DdMoCompRender callback function.
    PDD_MOCOMPCB_RENDER  RenderMoComp;
    ///Points to the driver-supplied DdMoCompQueryStatus callback function.
    PDD_MOCOMPCB_QUERYSTATUS QueryMoCompStatus;
    ///Points to the driver-supplied DdMoCompDestroy callback function.
    PDD_MOCOMPCB_DESTROY DestroyMoComp;
}

///The DD_NONLOCALVIDMEMCAPS structure contains the capabilities for nonlocal display memory.
struct DD_NONLOCALVIDMEMCAPS
{
    ///Specifies the size in bytes of this DD_NONLOCALVIDMEMCAPS structure.
    uint    dwSize;
    ///Contains the driver-specific capabilities for nonlocal-to-local display memory blits. See the Remarks section for
    ///more information.
    uint    dwNLVBCaps;
    ///Contains more of the driver-specific capabilities for nonlocal-to-local display memory blits. See the Remarks
    ///section for more information.
    uint    dwNLVBCaps2;
    ///Contains driver color key capabilities for nonlocal-to-local display memory blits. See the Remarks section for
    ///more information.
    uint    dwNLVBCKeyCaps;
    ///Contains driver FX capabilities for nonlocal-to-local display memory blits. See the Remarks section for more
    ///information.
    uint    dwNLVBFXCaps;
    ///Specifies an array of DD_ROP_SPACE DWORDs containing the raster operations supported for nonlocal-to-local blits.
    ///The constant DD_ROP_SPACE is defined in <i>ddraw.h</i>. See the Remarks section for more information.
    uint[8] dwNLVBRops;
}

///The DD_PALETTE_GLOBAL structure contains the global DirectDrawPalette data that can be shared between object
///instances.
struct DD_PALETTE_GLOBAL
{
    size_t dwReserved1;
}

///The DD_PALETTE_LOCAL structure contains palette-related data that is unique to an individual palette object.
struct DD_PALETTE_LOCAL
{
    ///Reserved for system use.
    uint   dwReserved0;
    size_t dwReserved1;
}

///The DD_CLIPPER_GLOBAL structure contains the global DirectDrawClipper data that can be shared between object
///instances.
struct DD_CLIPPER_GLOBAL
{
    size_t dwReserved1;
}

///The DD_CLIPPER_LOCAL structure contains local data for each individual DirectDrawClipper object.
struct DD_CLIPPER_LOCAL
{
    size_t dwReserved1;
}

///The DD_ATTACHLIST structure maintains a list of attached surfaces for Microsoft DirectDraw.
struct DD_ATTACHLIST
{
    ///Points to the next attached surface.
    DD_ATTACHLIST*    lpLink;
    DD_SURFACE_LOCAL* lpAttached;
}

///The DD_SURFACE_INT structure contains the DirectDrawSurface object's interface information.
struct DD_SURFACE_INT
{
    DD_SURFACE_LOCAL* lpLcl;
}

///The DD_SURFACE_GLOBAL structure contains global surface-related data that can be shared between multiple surfaces.
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
    ///If the driver allocates the memory block, it should return the offset into display memory in this member. If the
    ///driver requests DirectDraw to do the memory allocation, it can instead return one of the following values in this
    ///member from its DdCreateSurface routine: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td>
    ///DDHAL_PLEASEALLOC_BLOCKSIZE </td> <td> DirectDraw should allocate a memory block of size <b>dwBlockSizeX</b> and
    ///<b>dwBlockSizeY</b> in offscreen memory. </td> </tr> <tr> <td> DDHAL_PLEASEALLOC_USERMEM </td> <td> DirectDraw
    ///should allocate a memory block of size <b>dwUserMemSize</b> in user-mode memory. </td> </tr> </table>
    size_t        fpVidMem;
    union
    {
        int  lPitch;
        uint dwLinearSize;
    }
    ///Specifies the y-coordinate of the surface. This member is a 2D Cartesian coordinate specified in device space.
    int           yHint;
    ///Specifies the x-coordinate of the surface. This member is a 2D Cartesian coordinate specified in device space.
    int           xHint;
    ///Specifies the height in pixels of the surface.
    uint          wHeight;
    ///Specifies the width in pixels of the surface.
    uint          wWidth;
    ///Reserved for use by the display driver.
    size_t        dwReserved1;
    ///Points to the DDPIXELFORMAT structure that describes the pixel format of the surface.
    DDPIXELFORMAT ddpfSurface;
    ///Points to the raw offset in the source heap.
    size_t        fpHeapOffset;
    ///Reserved for system use and should be ignored by the driver.
    HANDLE        hCreatorProcess;
}

///The DD_SURFACE_MORE structure contains additional local data for each individual DirectDrawSurface object.
struct DD_SURFACE_MORE
{
    ///Contains the number of mipmap levels in the chain.
    uint                dwMipMapCount;
    ///Points to a DD_VIDEOPORT_LOCAL structure of the video port extensions (VPE) object currently writing data to this
    ///surface.
    DD_VIDEOPORT_LOCAL* lpVideoPort;
    ///Specifies a set of flags that indicate the overlay flags most recently passed to DdUpdateOverlay. This member is
    ///a bitwise OR of any of the following values: <table> <tr> <th>Flag</th> <th>Meaning</th> </tr> <tr> <td>
    ///DDOVER_ADDDIRTYRECT </td> <td> Add a dirty rectangle to an emulated overlaid surface. </td> </tr> <tr> <td>
    ///DDOVER_ALPHADEST </td> <td> Use the alpha information in the pixel format or the alpha channel surface attached
    ///to the destination surface as the alpha channel for the destination overlay. </td> </tr> <tr> <td>
    ///DDOVER_ALPHADESTCONSTOVERRIDE </td> <td> Use the <b>dwConstAlphaDest</b> member in the DDOVERLAYFX structure
    ///(defined in the Microsoft DirectDraw SDK documentation) as the destination alpha channel for this overlay. </td>
    ///</tr> <tr> <td> DDOVER_ALPHADESTNEG </td> <td> The NEG suffix indicates that the destination surface becomes more
    ///transparent as the alpha value increases. </td> </tr> <tr> <td> DDOVER_ALPHADESTSURFACEOVERRIDE </td> <td> Use
    ///the <b>lpDDSAlphaDest</b> member in the DDOVERLAYFX structure (defined in the DirectDraw SDK documentation) as
    ///the alpha channel destination for this overlay. </td> </tr> <tr> <td> DDOVER_ALPHAEDGEBLEND </td> <td> Use the
    ///<b>dwAlphaEdgeBlend</b> member in the DDOVERLAYFX structure as the alpha channel for the edges of the image that
    ///border the color key colors. </td> </tr> <tr> <td> DDOVER_ALPHASRC </td> <td> Use the alpha information in the
    ///pixel format or the alpha channel surface attached to the source surface as the source alpha channel for this
    ///overlay. </td> </tr> <tr> <td> DDOVER_ALPHASRCCONSTOVERRIDE </td> <td> Use the <b>dwConstAlphaSrc</b> member in
    ///the DDOVERLAYFX structure (defined in the DirectDraw SDK documentation) as the source alpha channel for this
    ///overlay. </td> </tr> <tr> <td> DDOVER_ALPHASRCNEG </td> <td> The NEG suffix indicates that the source surface
    ///becomes more transparent as the alpha value increases. </td> </tr> <tr> <td> DDOVER_ALPHASRCSURFACEOVERRIDE </td>
    ///<td> Use the <b>lpDDSAlphaSrc</b> member in the DDOVERLAYFX structure as the alpha channel source for this
    ///overlay. </td> </tr> <tr> <td> DDOVER_AUTOFLIP </td> <td> Autoflip the overlay whenever the VPE object autoflips.
    ///</td> </tr> <tr> <td> DDOVER_BOB </td> <td> Display each field of VPE object data individually without causing
    ///any jittery artifacts. </td> </tr> <tr> <td> DDOVER_BOBHARDWARE </td> <td> Bob is performed using hardware rather
    ///than software or emulated. </td> </tr> <tr> <td> DDOVER_DDFX </td> <td> Use the overlay FX flags to define
    ///special overlay FX. </td> </tr> <tr> <td> DDOVER_HIDE </td> <td> Turn this overlay off. </td> </tr> <tr> <td>
    ///DDOVER_INTERLEAVED </td> <td> Indicates that the surface memory is composed of interleaved fields. </td> </tr>
    ///<tr> <td> DDOVER_KEYDEST </td> <td> Use the color key associated with the destination surface. </td> </tr> <tr>
    ///<td> DDOVER_KEYDESTOVERRIDE </td> <td> Use the <b>dckDestColorkey</b> member in the DDOVERLAYFX structure
    ///(defined in the DirectDraw SDK documentation) as the color key for the destination surface. </td> </tr> <tr> <td>
    ///DDOVER_KEYSRC </td> <td> Use the color key associated with the source surface. </td> </tr> <tr> <td>
    ///DDOVER_KEYSRCOVERRIDE </td> <td> Use the <b>dckSrcColorkey</b> member in the DDOVERLAYFX structure as the color
    ///key for the source surface. </td> </tr> <tr> <td> DDOVER_OVERRIDEBOBWEAVE </td> <td> Bob and weave decisions
    ///should not be overridden by other interfaces. If this flag is set, DirectDraw does not allow a kernel-mode driver
    ///to use the kernel-mode video transport functionality to switch the hardware between bob and weave mode. </td>
    ///</tr> <tr> <td> DDOVER_REFRESHALL </td> <td> Redraw the entire surface on an emulated overlayed surface. </td>
    ///</tr> <tr> <td> DDOVER_REFRESHDIRTYRECTS </td> <td> Redraw all dirty rectangles on an emulated overlayed surface.
    ///</td> </tr> <tr> <td> DDOVER_SHOW </td> <td> Turn this overlay on. </td> </tr> </table>
    uint                dwOverlayFlags;
    ///Specifies a DDSCAPSEX structure that is used to expose extended surface capabilities. A DDSCAPSEX structure is
    ///the same as a DDSCAPS2 structure without the <b>dwCaps</b> member.
    DDSCAPSEX           ddsCapsEx;
    ///Specifies a cookie for D3dCreateSurfaceEx so that it can associate a texture handle with the surface.
    uint                dwSurfaceHandle;
}

///The DD_SURFACE_LOCAL structure contains surface-related data that is unique to an individual surface object.
struct DD_SURFACE_LOCAL
{
    ///Points to the DD_SURFACE_GLOBAL structure containing surface data that is shared globally with multiple surfaces.
    DD_SURFACE_GLOBAL* lpGbl;
    ///Specifies a set of surface flags. This member is a bitwise OR of any of the following values: <table> <tr>
    ///<th>Flag</th> <th>Meaning</th> </tr> <tr> <td> DDRAWISURF_BACKBUFFER </td> <td> The surface was originally a back
    ///buffer. </td> </tr> <tr> <td> DDRAWISURF_DRIVERMANAGED </td> <td> The surface is a driver managed texture used
    ///with Microsoft Direct3D. </td> </tr> <tr> <td> DDRAWISURF_FRONTBUFFER </td> <td> The surface was originally a
    ///front buffer. </td> </tr> <tr> <td> DDRAWISURF_HASCKEYSRCBLT </td> <td> The surface has source color key overlay
    ///data in the <b>ddckCKSrcBlt</b> member. </td> </tr> <tr> <td> DDRAWISURF_HASOVERLAYDATA </td> <td> The surface
    ///has overlay data. </td> </tr> <tr> <td> DDRAWISURF_HASPIXELFORMAT </td> <td> The surface has pixel format data.
    ///</td> </tr> <tr> <td> DDRAWISURF_INVALID </td> <td> The surface has been invalidated by a mode setting operation.
    ///</td> </tr> </table>
    uint               dwFlags;
    ///Specifies a DDSCAPS structure that describes the capabilities of the surface.
    DDSCAPS            ddsCaps;
    ///Reserved for use by the display driver.
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
    ///Points to a DD_SURFACE_MORE structure that contains additional local surface data.
    DD_SURFACE_MORE*   lpSurfMore;
    ///Points to a DD_ATTACHLIST structure that contains the list of surfaces to which this surface attached.
    DD_ATTACHLIST*     lpAttachList;
    ///Points to a DD_ATTACHLIST structure that contains the list of surfaces attached to this surface.
    DD_ATTACHLIST*     lpAttachListFrom;
    RECT               rcOverlaySrc;
}

///The DD_D3DBUFCALLBACKS structure is used only by drivers that implement driver level allocation of command and vertex
///buffers.
struct DD_D3DBUFCALLBACKS
{
    ///Specifies the size in bytes of this DD_D3DBUFCALLBACKS structure.
    uint                 dwSize;
    ///Reserved.
    uint                 dwFlags;
    ///Points to the driver's CanCreateD3DBuffer callback.
    PDD_CANCREATESURFACE CanCreateD3DBuffer;
    ///Points to the driver's CreateD3DBuffer callback.
    PDD_CREATESURFACE    CreateD3DBuffer;
    ///Points to the driver's DestroyD3DBuffer callback.
    PDD_SURFCB_DESTROYSURFACE DestroyD3DBuffer;
    ///Points to the driver's LockD3DBuffer callback.
    PDD_SURFCB_LOCK      LockD3DBuffer;
    ///Points to the driver's UnlockD3DBuffer callback.
    PDD_SURFCB_UNLOCK    UnlockD3DBuffer;
}

///The DD_HALINFO structure describes the capabilities of the hardware and driver.
struct DD_HALINFO
{
    ///Specifies the size in bytes of this DD_HALINFO structure.
    uint                dwSize;
    ///Specifies a VIDEOMEMORYINFO structure that describes the display's memory.
    VIDEOMEMORYINFO     vmiData;
    ///Specifies a <b>DDNTCORECAPS</b> structure that contains driver-specific capabilities.
    DDNTCORECAPS        ddCaps;
    ///Points to the driver's DdGetDriverInfo function. This function is called to get further Microsoft DirectDraw
    ///driver information. This member can be <b>NULL</b>.
    PDD_GETDRIVERINFO   GetDriverInfo;
    ///Specifies the display driver's creation flags. This member is a bitwise OR of any of the following values:
    ///<table> <tr> <th>Flag</th> <th>Meaning</th> </tr> <tr> <td> DDHALINFO_ISPRIMARYDISPLAY </td> <td> The driver is
    ///the primary display driver. </td> </tr> <tr> <td> DDHALINFO_MODEXILLEGAL </td> <td> This hardware does not
    ///support ModeX modes. </td> </tr> <tr> <td> DDHALINFO_GETDRIVERINFOSET </td> <td> The <b>GetDriverInfo</b> member
    ///is set. </td> </tr> <tr> <td> DDHALINFO_GETDRIVERINFO2 </td> <td> Driver supports <b>GetDriverInfo2</b> variant
    ///of <b>GetDriverInfo</b>. </td> </tr> </table>
    uint                dwFlags;
    ///Points to a D3DHAL_GLOBALDRIVERDATA structure that describes the 3D capabilities of the driver and its device.
    void*               lpD3DGlobalDriverData;
    ///Points to the driver's initialized D3DHAL_CALLBACKS structure.
    void*               lpD3DHALCallbacks;
    ///Used only by drivers that want to implement driver level vertex and command buffer allocation. This is usually
    ///done for performance reasons. The <b>lpD3DBufCallbacks</b> member is a pointer to a DD_D3DBUFCALLBACKS structure
    ///that the driver fills out with the callbacks used to support driver managed vertex and command buffers. This
    ///member should normally be ignored by the driver.
    DD_D3DBUFCALLBACKS* lpD3DBufCallbacks;
}

///The DD_DIRECTDRAW_GLOBAL structure contains driver information that describes the driver's device.
struct DD_DIRECTDRAW_GLOBAL
{
    ///Handle to the driver's private PDEV.
    void*            dhpdev;
    ///Reserved for use by the display driver.
    size_t           dwReserved1;
    ///Reserved for use by the display driver.
    size_t           dwReserved2;
    ///Points to an array of one or more DDVIDEOPORTCAPS structures in which the driver should describe the DirectDraw
    ///video port extensions (VPE) objects that it supports. The structures are allocated by DirectDraw; the number of
    ///structures is based on the value returned in the <b>dwMaxVideoPort</b> member of DDCORECAPS. This member is
    ///<b>NULL</b> when the driver does not implement the VPE.
    DDVIDEOPORTCAPS* lpDDVideoPortCaps;
}

///The DD_DIRECTDRAW_LOCAL structure contains driver information that is relevant to the current DirectDraw process
///only.
struct DD_DIRECTDRAW_LOCAL
{
    DD_DIRECTDRAW_GLOBAL* lpGbl;
}

///The DD_VIDEOPORT_LOCAL structure contains video port extensions (VPE)-related data that is unique to an individual
///Microsoft DirectDraw VPE object.
struct DD_VIDEOPORT_LOCAL
{
    ///Points to a DD_DIRECTDRAW_LOCAL structure that is relevant to the current DirectDraw process only.
    DD_DIRECTDRAW_LOCAL* lpDD;
    ///Specifies a DDVIDEOPORTDESC structure that describes the VPE object.
    DDVIDEOPORTDESC      ddvpDesc;
    ///Specifies a DDVIDEOPORTINFO structure that describes the transfer of video data to a surface.
    DDVIDEOPORTINFO      ddvpInfo;
    ///Points to a DD_SURFACE_INT structure for the surface receiving the video data.
    DD_SURFACE_INT*      lpSurface;
    ///Points to a DD_SURFACE_INT structure for the surface receiving the VBI data.
    DD_SURFACE_INT*      lpVBISurface;
    ///Specifies the number of current autoflip surfaces.
    uint                 dwNumAutoflip;
    ///Specifies the number of VBI surfaces currently being autoflipped.
    uint                 dwNumVBIAutoflip;
    ///Reserved for use by the display driver.
    size_t               dwReserved1;
    ///Reserved for use by the display driver.
    size_t               dwReserved2;
    ///Reserved for use by the display driver.
    size_t               dwReserved3;
}

///The DD_MOTIONCOMP_LOCAL structure contains local data for each individual Microsoft DirectDraw motion compensation
///object.
struct DD_MOTIONCOMP_LOCAL
{
    ///Points to a DD_DIRECTDRAW_LOCAL structure that is relevant to the current DirectDraw process only.
    DD_DIRECTDRAW_LOCAL* lpDD;
    ///Specifies a GUID that describes the motion compensation process being used.
    GUID                 guid;
    ///Indicates the width in pixels of the uncompressed output frame.
    uint                 dwUncompWidth;
    ///Indicates the height in pixels of the uncompressed output frame.
    uint                 dwUncompHeight;
    ///Specifies a DDPIXELFORMAT structure that contains the pixel format of the uncompressed output frame.
    DDPIXELFORMAT        ddUncompPixelFormat;
    uint                 dwDriverReserved1;
    uint                 dwDriverReserved2;
    ///Are reserved for use by the display driver.
    uint                 dwDriverReserved3;
    void*                lpDriverReserved1;
    void*                lpDriverReserved2;
    void*                lpDriverReserved3;
}

///The DD_MORESURFACECAPS structure defines more driver surface capabilities in addition to those described in
///DDCORECAPS.
struct DD_MORESURFACECAPS
{
    ///Specifies the size of this DD_MORESURFACECAPS structure. The DD_MORESURFACECAPS structure is of variable size.
    ///There should be exactly <b>DD_HALINFO.vmiData.dwNumHeaps</b> copies of the <b>ddsExtendedHeapRestrictions</b>
    ///structure within the array member of this structure. The total size of a DD_MORESURFACECAPS structure is thus:
    ///``` dwSize = sizeof(DD_MORESURFACECAPS) + (DD_HALINFO.vmiData.dwNumHeaps - 1) * sizeof(DDSCAPSEX) * 2 ``` This
    ///calculation accounts for the minimum size of the DD_MORESURFACECAPS structure, which includes only one
    ///<b>ddsExtendedHeapRestrictions</b> array element. Any additional <b>ddsExtendedHeapRestrictions</b> array
    ///elements must be accounted for by adding the sizes of the remaining array elements. That is, by adding the
    ///product of the number of remaining <b>ddsExtendedHeapRestrictions</b> structures times the size of each one.
    uint      dwSize;
    ///Specifies a DDSCAPSEX structure that provides the extensions to <b>ddcaps.ddsCaps</b> that describe the types of
    ///extended surfaces the driver can create. When a DDCAPS structure is returned to the application, it is a DDSCAPS2
    ///structure manufactured from <b>DDCAPS.ddsCaps</b> and <b>DD_MORESURFACECAPS.ddsCapsMore</b>. A DDSCAPSEX
    ///structure is the same as a DDSCAPS2 structure without the <b>dwCaps</b> member.
    DDSCAPSEX ddsCapsMore;
    struct ddsExtendedHeapRestrictions
    {
        DDSCAPSEX ddsCapsEx;
        DDSCAPSEX ddsCapsExAlt;
    }
}

///The DD_STEREOMODE structure is used by the runtime with GUID_DDStereoMode in a <b>DdGetDriverInfo</b> call to query
///whether the driver supports stereo for a given video display mode.
struct DD_STEREOMODE
{
    ///Specifies the size in bytes of the DD_STEREOMODE structure.
    uint dwSize;
    ///Specifies the height in scan lines of the display mode. Has the value D3DGDI2_MAGIC if this structure is, in
    ///fact, a DD_GETDRIVERINFO2DATA call.
    uint dwHeight;
    ///Specifies the width in pixels of the display mode.
    uint dwWidth;
    ///Specifies the bits per pixel of the display mode.
    uint dwBpp;
    ///Specifies the refresh rate in hertz of the display mode.
    uint dwRefreshRate;
    ///Driver sets to <b>TRUE</b> if stereo is supported with the specified display mode, or <b>FALSE</b> otherwise.
    BOOL bSupported;
}

///The DD_UPDATENONLOCALHEAPDATA structure contains the required heap information.
struct DD_UPDATENONLOCALHEAPDATA
{
    ///Points to the DD_DIRECTDRAW_GLOBAL structure that describes the driver's device.
    DD_DIRECTDRAW_GLOBAL* lpDD;
    ///Indicates the ordinal number of the heap for which data is being requested.
    uint    dwHeap;
    ///Points to the linear graphic address remapping table (GART) address of the start of the heap.
    size_t  fpGARTLin;
    ///Points to the physical GART address of the start of the heap.
    size_t  fpGARTDev;
    ///Indicates the maximum amount of AGP memory to use.
    size_t  ulPolicyMaxBytes;
    ///Specifies the location in which the driver writes the return value of the DdGetDriverInfo callback for a
    ///GUID_UpdateNonLocalHeap query. A return code of DD_OK indicates success. For more information, see Return Values
    ///for DirectDraw.
    HRESULT ddRVal;
    ///Unused on Microsoft Windows 2000 and later versions of the operating system.
    void*   UpdateNonLocalHeap;
}

///The DD_NTPRIVATEDRIVERCAPS structure enables the driver to change the behavior of Microsoft DirectDraw when
///DirectDraw is creating surfaces.
struct DD_NTPRIVATEDRIVERCAPS
{
    ///Specifies the size in bytes of this DD_NTPRIVATEDRIVERCAPS structure.
    uint dwSize;
    ///Indicates how DirectDraw should create the surface.
    uint dwPrivateCaps;
}

///The DD_BLTDATA structure contains the information relevant to the driver for doing bit block transfers.
struct DD_BLTDATA
{
    ///Points to a DD_DIRECTDRAW_GLOBAL structure that describes the driver's device.
    DD_DIRECTDRAW_GLOBAL* lpDD;
    ///Points to the DD_SURFACE_LOCAL structure that describes the surface on which to blit.
    DD_SURFACE_LOCAL* lpDDDestSurface;
    RECTL             rDest;
    ///Points to a DD_SURFACE_LOCAL structure that describes the source surface.
    DD_SURFACE_LOCAL* lpDDSrcSurface;
    RECTL             rSrc;
    ///Indicates a set of flags that specify the type of blit operation to perform and what associated structure members
    ///have valid data that the driver should use. This member is a bitwise OR of any of the following flags: <table>
    ///<tr> <th>Flag</th> <th>Meaning</th> </tr> <tr> <td> DDBLT_ASYNC </td> <td> Perform this blit asynchronously
    ///through the FIFO in the order received. If no room exists in the hardware FIFO, the driver should fail the call
    ///and return immediately. </td> </tr> <tr> <td> DDBLT_COLORFILL </td> <td> Use the <b>dwFillColor</b> member in the
    ///DDBLTFX structure (defined in the Microsoft DirectDraw SDK documentation) as the RGB color with which to fill the
    ///destination rectangle on the destination surface. </td> </tr> <tr> <td> DDBLT_DDFX </td> <td> Use the
    ///<b>dwDDFX</b> member in the DDBLTFX structure (defined in the DirectDraw SDK documentation) to determine the
    ///effects to use for the blit. </td> </tr> <tr> <td> DDBLT_DDROPS </td> <td> This flag is reserved for system use
    ///and should be ignored by the driver. The driver should also ignore the <b>dwDDROPS</b> member of the DDBLTFX
    ///structure. </td> </tr> <tr> <td> DDBLT_EXTENDED_FLAGS </td> <td> <dl> <dt><b>Microsoft DirectX 9.0 and later
    ///versions only.</b></dt> <dt>Set by the runtime to direct the driver to reinterpret certain flags in
    ///<b>dwFlags</b> from their meanings in DirectX 8.1 and earlier versions. The runtime combines DDBLT_EXTENDED_FLAGS
    ///with DDBLT_<i>Xxx</i> flags using a bitwise OR to create DDBLT_EXTENDED_<i>Xxx</i> flags.</dt> </dl> </td> </tr>
    ///<tr> <td> DDBLT_EXTENDED_LINEAR_CONTENT </td> <td> <dl> <dt><b>Microsoft DirectX 9.0 and later versions
    ///only.</b></dt> <dt>Created through the bitwise OR combination of DDBLT_EXTENDED_FLAGS and the 0x00000004
    ///bit.</dt> <dt>Indicates that the source surface contains content in a linear color space. The driver can then
    ///perform gamma 2.2 correction (sRGB) to the desktop color space as part of the blt.</dt> </dl> </td> </tr> <tr>
    ///<td> DDBLT_EXTENDED_PRESENTATION_STRETCHFACTOR </td> <td> <dl> <dt><b>Microsoft DirectX 9.0 and later versions
    ///only.</b></dt> <dt><b>NT-based operating systems only.</b></dt> <dt>Created through the bitwise OR combination of
    ///DDBLT_EXTENDED_FLAGS and the 0x00000010 bit. </dt> <dt>Set if the runtime subsequently uses the
    ///DDBLT_PRESENTATION and DDBLT_LAST_PRESENTATION flags to request a series of stretch-blit operations because of a
    ///<b>Present</b> call by an application.</dt> <dt>Notifies the driver about the entire unclipped source and
    ///destination rectangular areas before the driver receives actual sub-rectangular areas for blits. In this way, the
    ///driver can calculate and record the stretch factor for all subsequent blits up to and including the blit with the
    ///DDBLT_LAST_PRESENTATION flag set. However, when the driver receives a blit with the
    ///DDBLT_EXTENDED_PRESENTATION_STRETCHFACTOR flag set, the driver must not use these unclipped rectangular areas to
    ///do any actual blitting.</dt> <dt>After the driver finishes the final blit with the DDBLT_LAST_PRESENTATION flag
    ///set, the driver should clear the stretch-factor record to prevent interference with any subsequent blits</dt>
    ///</dl> . </td> </tr> <tr> <td> DDBLT_KEYDESTOVERRIDE </td> <td> Use the <b>dckDestColorkey</b> member in the
    ///DDBLTFX structure (defined in the DirectDraw SDK documentation) as the color key for the destination surface. If
    ///an override is not being set, then <b>dckDestColorkey</b> does not contain the color key. The driver should test
    ///the surface itself. </td> </tr> <tr> <td> DDBLT_KEYSRCOVERRIDE </td> <td> Use the <b>dckSrcColorkey</b> member in
    ///the DDBLTFX structure (defined in the DirectDraw SDK documentation) as the color key for the source surface. If
    ///an override is not being set, then <b>dckDestColorkey</b> does not contain the color key. The driver should test
    ///the surface itself. </td> </tr> <tr> <td> DDBLT_LAST_PRESENTATION </td> <td> <dl> <dt><b>DirectX 8.0 and later
    ///versions only.</b></dt> <dt>Set if the runtime requests a final blit operation because of a <b>Present</b> call
    ///by an application.</dt> </dl> </td> </tr> <tr> <td> DDBLT_PRESENTATION </td> <td> <dl> <dt><b>DirectX 8.0 and
    ///later versions only.</b></dt> <dt>Set if the runtime requests a blit operation because of a <b>Present</b> call
    ///by an application.</dt> </dl> </td> </tr> <tr> <td> DDBLT_ROP </td> <td> Use the <b>dwROP</b> member in the
    ///DDBLTFX structure (defined in the DirectDraw SDK documentation) for the raster operation for this blit.
    ///Currently, the only ROP passed to the driver is SRCCOPY. This ROP is the same as that defined in the Win32 API.
    ///See the Microsoft Windows SDK documentation for details. </td> </tr> <tr> <td> DDBLT_ROTATIONANGLE </td> <td>
    ///This flag is not supported on Windows 2000 and later and should be ignored by the driver. </td> </tr> <tr> <td>
    ///DDBLT_WAIT </td> <td> Do not return immediately with the DDERR_WASSTILLDRAWING message if the blitter is
    ///busy--wait until the blit can be set up or another error occurs. </td> </tr> </table>
    uint              dwFlags;
    ///Unused on Windows 2000 and later and should be ignored by the driver.
    uint              dwROPFlags;
    DDBLTFX           bltFX;
    ///Specifies the location in which the driver writes the return value of the DdBlt callback. A return code of DD_OK
    ///indicates success. For more information, see Return Values for DirectDraw.
    HRESULT           ddRVal;
    ///Used by the DirectDraw API and should not be filled in by the driver.
    void*             Blt;
    ///Indicates whether this is a clipped blit. On Windows 2000 and later, this member is always <b>FALSE</b>,
    ///indicating that the blit is unclipped.
    BOOL              IsClipped;
    ///<b>Unused for Windows 2000 and later.</b> Specifies a RECTL structure that defines the unclipped destination
    ///rectangle. This member is valid only if <b>IsClipped</b> is <b>TRUE</b>.
    RECTL             rOrigDest;
    ///<b>Unused for Windows 2000 and later.</b> Specifies a RECTL structure that defines the unclipped source
    ///rectangle. This member is valid only if <b>IsClipped</b> is <b>TRUE</b>.
    RECTL             rOrigSrc;
    ///<b>Unused for Windows 2000 and later.</b>Specifies the number of destination rectangles to which
    ///<b>prDestRects</b> points. This member is valid only if <b>IsClipped</b> is <b>TRUE</b>.
    uint              dwRectCnt;
    ///<b>Unused for Windows 2000 and later.</b> Points to an array of RECTL structures that describe of destination
    ///rectangles. This member is valid only if <b>IsClipped</b> is <b>TRUE</b>.
    RECT*             prDestRects;
    ///Unused and should be ignored by the driver.
    uint              dwAFlags;
    ///ARGB scaling factors (AlphaBlt)
    DDARGB            ddargbScaleFactors;
}

///The DD_LOCKDATA structure contains information necessary to do a lock as defined by the Microsoft DirectDraw
///parameter structures.
struct DD_LOCKDATA
{
    ///Points to a DD_DIRECTDRAW_GLOBAL structure that describes the driver's device.
    DD_DIRECTDRAW_GLOBAL* lpDD;
    ///Points to a DD_SURFACE_LOCAL structure that describes the surface--in the case of LockD3DBuffer, a
    ///buffer--associated with the memory region to be locked down.
    DD_SURFACE_LOCAL* lpDDSurface;
    ///Specifies whether the area in <b>rArea</b> is valid. A value of 0x00000001 indicates a valid area, 0x00000000
    ///indicates an invalid area.
    uint              bHasRect;
    ///Specifies a RECTL structure that defines the area on the surface to lock down.
    RECTL             rArea;
    ///Specifies the location in which the driver can return a pointer to the memory region that it locked down.
    void*             lpSurfData;
    ///Specifies the location in which the driver writes the return value of either the DdLock or LockD3DBuffer
    ///callback. A return code of DD_OK indicates success. For more information, see Return Values for DirectDraw.
    HRESULT           ddRVal;
    ///Used by the DirectDraw API and should not be filled in by the driver.
    void*             Lock;
    ///Specifies a bitmask that tells the driver how to perform the memory lockdown. This member is a bitwise OR of any
    ///of the following values: <table> <tr> <th>Flag</th> <th>Meaning</th> </tr> <tr> <td> DDLOCK_DISCARDCONTENTS </td>
    ///<td> <dl> <dt>No assumptions are made about the contents of the surface or vertex buffer during this lock. This
    ///enables two things:</dt> <dt>1. Microsoft Direct3D or the driver may provide an alternative memory area as the
    ///vertex buffer. This is useful when one plans to clear the contents of the vertex buffer and fill in new
    ///data.</dt> <dt>2. Drivers sometimes store surface data in a reordered format. When the application locks the
    ///surface, the driver is forced to undo this surface data reordering before allowing the application to see the
    ///surface contents.</dt> </dl> This flag is a hint to the driver that it can skip the un-reordering process since
    ///the application plans to overwrite every single pixel in the surface or locked rectangle (and so erase any
    ///un-reordered pixels anyway). Applications should always set this flag when they intend to overwrite the entire
    ///surface or locked rectangle. </td> </tr> <tr> <td> DDLOCK_DONOTWAIT </td> <td> On <b>IDirectDrawSurface7</b> and
    ///higher interfaces, the default is DDLOCK_WAIT. If you wish to override the default and use time when the
    ///accelerator is busy (as denoted by the DDERR_WASSTILLDRAWING return code) then use this flag. </td> </tr> <tr>
    ///<td> DDLOCK_EVENT </td> <td> Set if an event handle is being passed to <b>Lock</b>, which triggers the event when
    ///it can return the surface memory pointer requested. </td> </tr> <tr> <td> DDLOCK_HASVOLUMETEXTUREBOXRECT </td>
    ///<td> The driver should return a valid memory pointer to the beginning of the subvolume texture specified in the
    ///rectangle (RECTL) in <b>rArea</b>. The driver obtains the front and back coordinates of the subvolume from the
    ///top 16 bits of the left and right coordinates (left and right members of RECTL) respectively. The left and right
    ///coordinates are constrained to the lower 16 bits. If no rectangle is specified, the driver should return a
    ///pointer to the top of the whole volume. This value is available in DirectX 8.1 and later. </td> </tr> <tr> <td>
    ///DDLOCK_NODIRTYUPDATE </td> <td> <dl> <dt>Sent to the driver by the runtime after an application requests to lock
    ///down a memory region with the D3DLOCK_NO_DIRTY_UPDATE flag set. In this case, the driver should not consider the
    ///memory region that it locks down as dirty when the runtime calls the driver's DdUnlock function to update a
    ///surface that contains this region. Rather, the driver should only consider the regions specified in previous
    ///calls to its D3dDrawPrimitives2 function using the D3DDP2OP_ADDDIRTYRECT and D3DDP2OP_ADDDIRTYBOX enumerators as
    ///dirty. </dt> <dt>By default, a lock on a surface adds a dirty region to that surface. </dt> </dl> </td> </tr>
    ///<tr> <td> DDLOCK_NOOVERWRITE </td> <td> Used only with Direct3D vertex buffer locks. Indicates that no vertices
    ///that were referred to in <b>IDirect3DDevice7::DrawPrimitiveVB</b> and
    ///<b>IDirect3DDevice7::DrawIndexedPrimitiveVB</b> calls (described in the Direct3D SDK documentation) since the
    ///start of the frame (or the last lock without this flag) are modified during the lock. This can be useful when one
    ///is only appending data to the vertex buffer. </td> </tr> <tr> <td> DDLOCK_NOSYSLOCK </td> <td> <dl> <dt>Indicates
    ///that a system-wide lock should not be taken when this surface is locked. This has several advantages when locking
    ///video memory surfaces, such as cursor responsiveness, ability to call more Microsoft Windows functions, and
    ///easier debugging. However, an application specifying this flag must comply with a number of conditions documented
    ///in the help file.</dt> <dt>This flag cannot be specified when locking the primary.</dt> </dl> </td> </tr> <tr>
    ///<td> DDLOCK_OKTOSWAP </td> <td> Same as DDLOCK_DISCARDCONTENTS. </td> </tr> <tr> <td> DDLOCK_READONLY </td> <td>
    ///The surface being locked will only be read from. On Windows 2000 and later, this flag is never set. </td> </tr>
    ///<tr> <td> DDLOCK_SURFACEMEMORYPTR </td> <td> The driver should return a valid memory pointer to the top of the
    ///rectangle specified in <b>rArea</b>. If no rectangle is specified, the driver should return a pointer to the top
    ///of the surface. </td> </tr> <tr> <td> DDLOCK_WAIT </td> <td> Set to indicate that <b>Lock</b> should wait until
    ///it can obtain a valid memory pointer before returning. If this bit is set, <b>Lock</b> never returns
    ///DDERR_WASSTILLDRAWING. </td> </tr> <tr> <td> DDLOCK_WRITEONLY </td> <td> The surface being locked will only be
    ///written to. On Windows 2000 and later, this flag is never set. </td> </tr> </table>
    uint              dwFlags;
    ///Specifies a pointer to a user-mode mapping of the driver's memory. The driver performs this mapping in
    ///DdMapMemory. Windows 2000 and later only.
    size_t            fpProcess;
}

///The DD_UNLOCKDATA structure contains information necessary to do an unlock as defined by Microsoft DirectDraw
///parameter structures.
struct DD_UNLOCKDATA
{
    ///Points to a DD_DIRECTDRAW_GLOBAL structure that describes the driver's device.
    DD_DIRECTDRAW_GLOBAL* lpDD;
    ///Points to a DD_SURFACE_LOCAL structure that describes the surface--in the case of UnlockD3DBuffer, a buffer--to
    ///be unlocked.
    DD_SURFACE_LOCAL* lpDDSurface;
    ///Specifies the location in which the driver writes the return value of either the DdUnlock or UnlockD3DBuffer
    ///callback. A return code of DD_OK indicates success. For more information, see Return Values for DirectDraw.
    HRESULT           ddRVal;
    ///Used by the DirectDraw API and should not be filled in by the driver.
    void*             Unlock;
}

///The DD_UPDATEOVERLAYDATA structure contains information necessary for updating an overlay surface.
struct DD_UPDATEOVERLAYDATA
{
    ///Points to a DD_DIRECTDRAW_GLOBAL structure that describes the driver's device.
    DD_DIRECTDRAW_GLOBAL* lpDD;
    ///Points to a DD_SURFACE_LOCAL structure that represents the Microsoft DirectDraw surface to be overlaid. This
    ///value can be <b>NULL</b> if DDOVER_HIDE is specified in <b>dwFlags</b>.
    DD_SURFACE_LOCAL* lpDDDestSurface;
    ///Specifies a RECTL structure that contains the x, y, width, and height of the region on the destination surface to
    ///be overlaid.
    RECTL             rDest;
    ///Points to a DD_SURFACE_LOCAL structure that describes the overlay surface.
    DD_SURFACE_LOCAL* lpDDSrcSurface;
    ///Specifies a RECTL structure that contains the x, y, width, and height of the region on the source surface to be
    ///used for the overlay.
    RECTL             rSrc;
    ///Specifies how the driver should handle the overlay. This member can be a combination of any of the following
    ///flags: <table> <tr> <th>Flag</th> <th>Meaning</th> </tr> <tr> <td> DDOVER_ADDDIRTYRECT </td> <td> Should be
    ///ignored by the driver. </td> </tr> <tr> <td> DDOVER_AUTOFLIP </td> <td> The driver should autoflip the overlay
    ///whenever the hardware video port autoflips. Drivers that support video port extensions (VPE) need only check this
    ///flag. </td> </tr> <tr> <td> DDOVER_BOB </td> <td> The driver should display each field of VPE object data
    ///individually without causing any jittery artifacts. This flag pertains to both VPE and decoders that want to do
    ///their own flipping in kernel mode using the kernel-mode video transport functionality. </td> </tr> <tr> <td>
    ///DDOVER_BOBHARDWARE </td> <td> Indicates that bob is performed by hardware rather than by software or emulation.
    ///Drivers that support VPE need only check this flag. </td> </tr> <tr> <td> DDOVER_DDFX </td> <td> The driver
    ///should show the overlay surface using the attributes specified by the <b>overlayFX</b> member. </td> </tr> <tr>
    ///<td> DDOVER_HIDE </td> <td> The driver should hide the overlay; that is, the driver should turn this overlay off.
    ///</td> </tr> <tr> <td> DDOVER_INTERLEAVED </td> <td> The overlay surface is composed of interleaved fields.
    ///Drivers that support VPE need only check this flag. </td> </tr> <tr> <td> DDOVER_KEYDEST </td> <td> The driver
    ///should use the color key associated with the destination surface. </td> </tr> <tr> <td> DDOVER_KEYDESTOVERRIDE
    ///</td> <td> The driver should use the <b>dckDestColorKey</b> member of the DDOVERLAYFX structure (described in the
    ///DirectDraw SDK documentation) as the destination color key instead of the color key associated with the
    ///destination surface. </td> </tr> <tr> <td> DDOVER_KEYSRC </td> <td> The driver should use the color key
    ///associated with the destination surface. </td> </tr> <tr> <td> DDOVER_KEYSRCOVERRIDE </td> <td> The driver should
    ///use the <b>dckSrcColorKey</b> member of the DDOVERLAYFX structure (described in the DirectDraw SDK documentation)
    ///as the source color key instead of the color key associated with the destination surface. </td> </tr> <tr> <td>
    ///DDOVER_OVERRIDEBOBWEAVE </td> <td> Bob/weave decisions should not be overridden by other interfaces. If the
    ///overlay mixer sets this flag, DirectDraw does not allow a kernel-mode driver to use the kernel-mode video
    ///transport functionality to switch the hardware between bob and weave mode. </td> </tr> <tr> <td>
    ///DDOVER_REFRESHALL </td> <td> Should be ignored by the driver. </td> </tr> <tr> <td> DDOVER_REFRESHDIRTYRECTS
    ///</td> <td> Should be ignored by the driver. </td> </tr> <tr> <td> DDOVER_SHOW </td> <td> The driver should show
    ///the overlay; that is, the driver should turn this overlay on. </td> </tr> </table>
    uint              dwFlags;
    ///Specifies a DDOVERLAYFX structure (described in the DirectDraw SDK documentation) that describes additional
    ///effects that the driver should use to update the overlay. The driver should use this structure only if one of
    ///DDOVER_DDFX, DDOVER_KEYDESTOVERRIDE, or DDOVER_KEYSRCOVERRIDE are set in the <b>dwFlags</b> member.
    DDOVERLAYFX       overlayFX;
    ///Specifies the location in which the driver writes the return value of the DdUpdateOverlay callback. A return code
    ///of DD_OK indicates success. For more information, see Return Values for DirectDraw.
    HRESULT           ddRVal;
    ///Used by the DirectDraw API and should not be filled in by the driver.
    void*             UpdateOverlay;
}

///The DD_SETOVERLAYPOSITIONDATA structure contains information necessary to change the display coordinates of an
///overlay surface.
struct DD_SETOVERLAYPOSITIONDATA
{
    ///Points to a DD_DIRECTDRAW_GLOBAL structure that describes the driver's device.
    DD_DIRECTDRAW_GLOBAL* lpDD;
    ///Points to a DD_SURFACE_LOCAL structure that represents the Microsoft DirectDraw overlay surface.
    DD_SURFACE_LOCAL* lpDDSrcSurface;
    ///Points to a DD_SURFACE_LOCAL structure representing the surface that is being overlaid.
    DD_SURFACE_LOCAL* lpDDDestSurface;
    ///Specifies the x-coordinate of the upper left corner of the overlay, in pixels.
    int               lXPos;
    ///Specifies the y coordinate of the upper left corner of the overlay, in pixels.
    int               lYPos;
    ///Specifies the location in which the driver writes the return value of the DdSetOverlayPosition callback. A return
    ///code of DD_OK indicates success. For more information, see Return Values for DirectDraw.
    HRESULT           ddRVal;
    ///Used by the DirectDraw API and should not be filled in by the driver.
    void*             SetOverlayPosition;
}

///The DD_SETPALETTEDATA structure contains information necessary to set a palette for a specific surface.
struct DD_SETPALETTEDATA
{
    ///Points to a DD_DIRECTDRAW_GLOBAL structure that describes the driver's device.
    DD_DIRECTDRAW_GLOBAL* lpDD;
    ///Points to a DD_SURFACE_LOCAL structure that represents the DirectDrawSurface object.
    DD_SURFACE_LOCAL*  lpDDSurface;
    ///Points to a DD_PALETTE_GLOBAL structure that specifies the palette to set to the surface.
    DD_PALETTE_GLOBAL* lpDDPalette;
    ///Specifies the location in which the driver writes the return value of the DdSetPalette callback. A return code of
    ///DD_OK indicates success. For more information, see Return Values for DirectDraw.
    HRESULT            ddRVal;
    ///Used by the Microsoft DirectDraw API and should not be filled in by the driver.
    void*              SetPalette;
    ///Indicates whether to attach this palette to the surface.
    BOOL               Attach;
}

///The DD_FLIPDATA structure contains information needed to do a flip.
struct DD_FLIPDATA
{
    ///Points to the DD_DIRECTDRAW_GLOBAL structure that describes the driver's device.
    DD_DIRECTDRAW_GLOBAL* lpDD;
    ///Points to the DD_SURFACE_LOCAL structure describing the current surface.
    DD_SURFACE_LOCAL* lpSurfCurr;
    ///Points to the DD_SURFACE_LOCAL structure describing the target surface; that is, the surface to which the driver
    ///should flip.
    DD_SURFACE_LOCAL* lpSurfTarg;
    ///Indicates a set of flags that provide the driver with details for the flip. This member can be a bitwise OR of
    ///the following flags: <table> <tr> <th>Flag</th> <th>Meaning</th> </tr> <tr> <td> DDFLIP_DONOTWAIT </td> <td>
    ///Specifies to return DDERR_WASSTILLDRAWING if the accelerator is busy. The default is DDFLIP_WAIT. </td> </tr>
    ///<tr> <td> DDFLIP_EVEN </td> <td> The surface to which the <b>lpSurfTarg</b> member points contains only the even
    ///field of video data. This flag is valid only when the surface is an overlay, and is mutually exclusive of
    ///DDFLIP_ODD. </td> </tr> <tr> <td> DDFLIP_ODD </td> <td> The surface to which the <b>lpSurfTarg</b> member points
    ///contains only the odd field of video data. This flag is valid only when the surface is an overlay, and is
    ///mutually exclusive of DDFLIP_EVEN. </td> </tr> <tr> <td> DDFLIP_NOVSYNC </td> <td> The driver should perform the
    ///flip and return immediately. Typically, the current back buffer (which used to be the front buffer) is still
    ///visible until the next vertical retrace. Subsequent operations involving the surfaces to which the
    ///<b>lpSurfCurr</b> and <b>lpSurfTarg</b> members point do not check to see if the physical flip has finished. This
    ///allows an application to perform flips at a higher frequency than the monitor refresh rate, although it might
    ///introduce visible artifacts. </td> </tr> <tr> <td> DDFLIP_INTERVAL2 </td> <td> The driver should perform the flip
    ///on every other vertical sync. It should return DDERR_WASSTILLDRAWING until the second vertical retrace has
    ///occurred. This flag is mutually exclusive of DDFLIP_INTERVAL3 and DDFLIP_INTERVAL4. </td> </tr> <tr> <td>
    ///DDFLIP_INTERVAL3 </td> <td> The driver should perform the flip on every third vertical sync. It should return
    ///DDERR_WASSTILLDRAWING until the third vertical retrace has occurred. This flag is mutually exclusive of
    ///DDFLIP_INTERVAL2 and DDFLIP_INTERVAL4. </td> </tr> <tr> <td> DDFLIP_INTERVAL4 </td> <td> The driver should
    ///perform the flip on every fourth vertical sync. It should return DDERR_WASSTILLDRAWING until the fourth vertical
    ///retrace has occurred. This flag is mutually exclusive of DDFLIP_INTERVAL2 and DDFLIP_INTERVAL3. </td> </tr> <tr>
    ///<td> DDFLIP_STEREO </td> <td> Specifies to enable stereo autoflipping (the hardware automatically flips between
    ///the left and right buffers during each screen refresh). </td> </tr> <tr> <td> DDFLIP_WAIT </td> <td> Specifies to
    ///not return until the flip or an error occurs. </td> </tr> </table>
    uint              dwFlags;
    ///Specifies the location in which the driver writes the return value of the DdFlip callback. A return code of DD_OK
    ///indicates success. For more information, see Return Values for DirectDraw.
    HRESULT           ddRVal;
    ///Used by the Microsoft DirectDraw API and should not be filled in by the driver.
    void*             Flip;
    ///Points to the DD_SURFACE_LOCAL structure describing the current left surface.
    DD_SURFACE_LOCAL* lpSurfCurrLeft;
    ///Points to the DD_SURFACE_LOCAL structure describing the left target surface to flip to.
    DD_SURFACE_LOCAL* lpSurfTargLeft;
}

///The DD_DESTROYSURFACEDATA structure contains information necessary to destroy the specified surface--in the case of
///DestroyD3DBuffer, a command or vertex buffer.
struct DD_DESTROYSURFACEDATA
{
    ///Points to the DD_DIRECTDRAW_GLOBAL structure that describes the driver's device.
    DD_DIRECTDRAW_GLOBAL* lpDD;
    ///Points to the DD_SURFACE_LOCAL structure representing the surface or buffer object to be destroyed.
    DD_SURFACE_LOCAL* lpDDSurface;
    ///Specifies the location in which the driver writes the return value of either the DdDestroySurface or
    ///DestroyD3DBuffer callback. A return code of DD_OK indicates success. For more information, see Return Values for
    ///DirectDraw.
    HRESULT           ddRVal;
    ///Used by the Microsoft DirectDraw API and should not be filled in by the driver.
    void*             DestroySurface;
}

///The DD_ADDATTACHEDSURFACEDATA structure contains information necessary to attach a surface to another surface.
struct DD_ADDATTACHEDSURFACEDATA
{
    ///Points to a DD_DIRECTDRAW_GLOBAL structure that describes the driver's device.
    DD_DIRECTDRAW_GLOBAL* lpDD;
    ///Points to a DD_SURFACE_LOCAL structure that represents the surface to which another surface is being attached.
    DD_SURFACE_LOCAL* lpDDSurface;
    ///Points to a DD_SURFACE_LOCAL structure that represents the surface to be attached.
    DD_SURFACE_LOCAL* lpSurfAttached;
    ///Specifies the location in which the driver writes the return value of the DdAddAttachedSurface callback. A return
    ///code of DD_OK indicates success. For more information, see Return Values for DirectDraw.
    HRESULT           ddRVal;
    ///Unused on Microsoft Windows 2000 and later.
    void*             AddAttachedSurface;
}

///The DD_SETCOLORKEYDATA structure contains information necessary to set the color key value for the specified surface.
struct DD_SETCOLORKEYDATA
{
    ///Points to the DD_DIRECTDRAW_GLOBAL structure that describes the driver's device.
    DD_DIRECTDRAW_GLOBAL* lpDD;
    ///Points to the DD_SURFACE_LOCAL structure that describes the surface with which the color key is to be associated.
    DD_SURFACE_LOCAL* lpDDSurface;
    ///Specifies which color key is being requested. This member is a bitwise OR of any of the following values: <table>
    ///<tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td> DDCKEY_COLORSPACE </td> <td> The DDCOLORKEY structure
    ///contains a color space. If this bit is not set, the structure contains a single color key. </td> </tr> <tr> <td>
    ///DDCKEY_DESTBLT </td> <td> The DDCOLORKEY structure specifies a color key or color space to be used as a
    ///destination color key for blt operations. </td> </tr> <tr> <td> DDCKEY_DESTOVERLAY </td> <td> The DDCOLORKEY
    ///structure specifies a color key or color space to be used as a destination color key for overlay operations.
    ///</td> </tr> <tr> <td> DDCKEY_SRCBLT </td> <td> The DDCOLORKEY structure specifies a color key or color space to
    ///be used as a source color key for blit operations. </td> </tr> <tr> <td> DDCKEY_SRCOVERLAY </td> <td> The
    ///DDCOLORKEY structure specifies a color key or color space to be used as a source color key for overlay operations
    ///</td> </tr> </table>
    uint              dwFlags;
    ///Specifies a DDCOLORKEY structure that specifies the new color key values for the DirectDrawSurface object. For
    ///more information about DDCOLORKEY, see the latest Microsoft DirectX SDK documentation.
    DDCOLORKEY        ckNew;
    ///Specifies the location in which the driver writes the return value of the DdSetColorKey callback. A return code
    ///of DD_OK indicates success. For more information, see Return Values for DirectDraw.
    HRESULT           ddRVal;
    ///This is not used on Microsoft Windows 2000 and later.
    void*             SetColorKey;
}

///The DD_GETBLTSTATUSDATA structure returns the blit status information.
struct DD_GETBLTSTATUSDATA
{
    ///Points to a DD_DIRECTDRAW_GLOBAL structure that describes the driver's device.
    DD_DIRECTDRAW_GLOBAL* lpDD;
    ///Points to a DD_SURFACE_LOCAL structure representing the surface whose blit status is being queried.
    DD_SURFACE_LOCAL* lpDDSurface;
    ///Specifies the blit status being requested. This member can be one of the following values: <table> <tr>
    ///<th>Flag</th> <th>Meaning</th> </tr> <tr> <td> DDGBS_CANBLT </td> <td> Queries whether the driver can currently
    ///perform a blit. </td> </tr> <tr> <td> DDGBS_ISBLTDONE </td> <td> Queries whether the driver has completed the
    ///last blit. </td> </tr> </table>
    uint              dwFlags;
    ///Specifies the location in which the driver writes the return value of the DdGetBltStatus callback. A return code
    ///of DD_OK indicates success. For more information, see Return Values for DirectDraw.
    HRESULT           ddRVal;
    ///Used by the Microsoft DirectDraw API and should not be filled in by the driver.
    void*             GetBltStatus;
}

///The DD_GETFLIPSTATUSDATA structure returns the flip status information.
struct DD_GETFLIPSTATUSDATA
{
    ///Points to a DD_DIRECTDRAW_GLOBAL structure that describes the driver's device.
    DD_DIRECTDRAW_GLOBAL* lpDD;
    ///Points to a DD_SURFACE_LOCAL structure that describes the surface whose flip status is being queried.
    DD_SURFACE_LOCAL* lpDDSurface;
    ///Specifies the flip status being requested. This member can be one of the following values: <table> <tr>
    ///<th>Flag</th> <th>Meaning</th> </tr> <tr> <td> DDGFS_CANFLIP </td> <td> Queries whether the driver can currently
    ///perform a flip. </td> </tr> <tr> <td> DDGFS_ISFLIPDONE </td> <td> Queries whether the driver has finished the
    ///last flip. </td> </tr> </table>
    uint              dwFlags;
    ///Specifies the location in which the driver writes the return value of the DdGetFlipStatus callback. A return code
    ///of DD_OK indicates success. For more information, see Return Values for DirectDraw.
    HRESULT           ddRVal;
    ///Used by the Microsoft DirectDraw API and should not be filled in by the driver.
    void*             GetFlipStatus;
}

///The DD_DESTROYPALETTEDATA structure contains information necessary to destroy the specified palette.
struct DD_DESTROYPALETTEDATA
{
    ///Points to the DD_DIRECTDRAW_GLOBAL structure that describes the driver's device.
    DD_DIRECTDRAW_GLOBAL* lpDD;
    ///Points to the DD_PALETTE_GLOBAL structure representing the palette object to be destroyed.
    DD_PALETTE_GLOBAL* lpDDPalette;
    ///Specifies the location in which the driver writes the return value of the DdDestroyPalette callback. A return
    ///code of DD_OK indicates success. For more information, see Return Values for DirectDraw.
    HRESULT            ddRVal;
    ///Used by the Microsoft DirectDraw API and should not be filled in by the driver.
    void*              DestroyPalette;
}

///The DD_SETENTRIESDATA structure contains information necessary to set palette entries.
struct DD_SETENTRIESDATA
{
    ///Points to a DD_DIRECTDRAW_GLOBAL structure that describes the driver's device.
    DD_DIRECTDRAW_GLOBAL* lpDD;
    ///Points to a DD_PALETTE_GLOBAL structure that represents the DirectDrawPalette object.
    DD_PALETTE_GLOBAL* lpDDPalette;
    ///Specifies a zero-based index into the color table of the first entry to be modified.
    uint               dwBase;
    ///Specifies the number of palette entries that the driver should update.
    uint               dwNumEntries;
    ///Points to a PALETTEENTRY structure that specifies the color table. See the latest Microsoft DirectX SDK
    ///documentation for more information about PALETTEENTRY.
    PALETTEENTRY*      lpEntries;
    ///Specifies the location in which the driver writes the return value of the DdSetEntries callback. For more
    ///information, see Return Values for DirectDraw.
    HRESULT            ddRVal;
    ///Used by the Microsoft DirectDraw API and should not be filled in by the driver.
    void*              SetEntries;
}

///The DD_CREATESURFACEDATA structure contains information necessary to create a surface--in the case of
///CreateD3DBuffer, a command or vertex buffer.
struct DD_CREATESURFACEDATA
{
    ///Points to the DD_DIRECTDRAW_GLOBAL structure that describes the driver's device.
    DD_DIRECTDRAW_GLOBAL* lpDD;
    ///Points to the DDSURFACEDESC structure describing the surface or buffer that the driver should create.
    DDSURFACEDESC*     lpDDSurfaceDesc;
    ///Points to a list of DD_SURFACE_LOCAL structures describing the surface objects created by the driver. On
    ///Microsoft Windows 2000 and later, there is usually only one entry in this array. However, if the driver supports
    ///the Windows 98/Me-style surface creation techniques using DdGetDriverInfo with GUID_NTPrivateDriverCaps, and the
    ///driver sets the DDHAL_PRIVATECAP_ATOMICSURFACECREATION flag, the member contains a list of surfaces (usually more
    ///than one).
    DD_SURFACE_LOCAL** lplpSList;
    ///Specifies the number of surfaces in the list to which <b>lplpSList</b> points. This value is usually 1 on Windows
    ///2000 and later. However, if the driver support the Windows 98/Me-style surface creation techniques using
    ///DdGetDriverInfo with GUID_NTPrivateDriverCaps, the member contains the actual number of surfaces in the list
    ///(usually more than one).
    uint               dwSCnt;
    ///Specifies the location in which the driver writes the return value of either the DdCreateSurface or
    ///CreateD3DBuffer callback. A return code of DD_OK indicates success. For more information, see Return Values for
    ///DirectDraw.
    HRESULT            ddRVal;
    ///Used by the Microsoft DirectDraw API and should not be filled in by the driver.
    void*              CreateSurface;
}

///The DD_CANCREATESURFACEDATA structure contains information necessary to indicate whether a surface--in the case of
///CanCreateD3DBuffer, a buffer--can be created.
struct DD_CANCREATESURFACEDATA
{
    ///Points to the DD_DIRECTDRAW_GLOBAL structure that describes the driver's device.
    DD_DIRECTDRAW_GLOBAL* lpDD;
    ///Points to a DDSURFACEDESC structure that contains a description of the surface or buffer to be created. See the
    ///Remarks section for additional information about this member.
    DDSURFACEDESC* lpDDSurfaceDesc;
    ///Indicates whether the pixel format of the surface to be created differs from that of the primary surface. For the
    ///CanCreateD3DBuffer D3DBuffer callback, this member is always set to <b>FALSE</b> because the driver is attempting
    ///to create a buffer that contains vertex data or commands, rather than pixel data.
    uint           bIsDifferentPixelFormat;
    ///Specifies the location in which the driver writes the return value of either the DdCanCreateSurface or
    ///CanCreateD3DBuffer callback. A return code of DD_OK indicates success. For more information, see Return Values
    ///for DirectDraw.
    HRESULT        ddRVal;
    ///Used by the Microsoft DirectDraw API and should not be filled in by the driver.
    void*          CanCreateSurface;
}

///The DD_CREATEPALETTEDATA structure contains information necessary to create a DirectDrawPalette object for this
///Microsoft DirectDraw object.
struct DD_CREATEPALETTEDATA
{
    ///Points to a DD_DIRECTDRAW_GLOBAL structure that describes the driver's device.
    DD_DIRECTDRAW_GLOBAL* lpDD;
    ///Points to a DD_PALETTE_GLOBAL structure representing the DirectDrawPalette object.
    DD_PALETTE_GLOBAL* lpDDPalette;
    ///Points to an array of 2, 4, 16, or 256 PALETTEENTRY structures used to initialize the colors for this
    ///DirectDrawPalette object. See the latest Microsoft DirectX SDK documentation for more information about
    ///PALETTEENTRY.
    PALETTEENTRY*      lpColorTable;
    ///Specifies the location in which the driver writes the return value of the DdCreatePalette callback. A return code
    ///of DD_OK indicates success. For more information, see Return Values for DirectDraw.
    HRESULT            ddRVal;
    ///Used by the DirectDraw API and should not be filled in by the driver.
    void*              CreatePalette;
    ///Specifies a BOOL value that is set to <b>TRUE</b> to indicate that this process has exclusive mode and
    ///<b>FALSE</b> otherwise.
    BOOL               is_excl;
}

///The DD_WAITFORVERTICALBLANKDATA structure contains information necessary to obtain the monitor's vertical blank
///information.
struct DD_WAITFORVERTICALBLANKDATA
{
    ///Points to a DD_DIRECTDRAW_GLOBAL structure that describes the driver's device.
    DD_DIRECTDRAW_GLOBAL* lpDD;
    ///Specifies how the driver should wait for the vertical blank. This member can be one of the following values:
    ///<table> <tr> <th>Flag</th> <th>Meaning</th> </tr> <tr> <td> DDWAITVB_BLOCKBEGIN </td> <td> The driver should
    ///return when it detects the beginning of the vertical blank interval. </td> </tr> <tr> <td>
    ///DDWAITVB_BLOCKBEGINEVENT </td> <td> Set up an event to trigger when the vertical blank begins. This flag is not
    ///currently supported. </td> </tr> <tr> <td> DDWAITVB_BLOCKEND </td> <td> The driver should return when it detects
    ///the end of the vertical blank interval and display begins. </td> </tr> <tr> <td> DDWAITVB_I_TESTVB </td> <td> The
    ///driver should determine whether a vertical blank is currently occurring and return the status in <b>bIsInVB</b>.
    ///</td> </tr> </table>
    uint    dwFlags;
    ///Indicates the status of the vertical blank. A value of <b>TRUE</b> indicates that the device is in a vertical
    ///blank; <b>FALSE</b> means that it is not. The driver should return the current vertical blanking status in this
    ///member when <b>dwFlags</b> is DDWAITVB_I_TESTVB.
    uint    bIsInVB;
    ///Handle for the event that should be triggered when the vertical blank begins. The event is triggered on an
    ///interrupt, so if your hardware is able to generate an interrupt on the vertical blank, you should pass this event
    ///handle to your HwVidInterrupt function so that the event is triggered when the interrupt fires. This member is
    ///currently unsupported and should be ignored by the driver.
    size_t  hEvent;
    ///Specifies the location in which the driver writes the return value of the DdWaitForVerticalBlank callback. A
    ///return code of DD_OK indicates success. For more information, see Return Values for DirectDraw.
    HRESULT ddRVal;
    ///Used by the Microsoft DirectDraw API and should not be filled in by the driver.
    void*   WaitForVerticalBlank;
}

///The DD_GETSCANLINEDATA structure contains the members required to query and return the number of the current scan
///line.
struct DD_GETSCANLINEDATA
{
    ///Points to a DD_DIRECTDRAW_GLOBAL structure that describes the driver's device.
    DD_DIRECTDRAW_GLOBAL* lpDD;
    ///Specifies the location in which the driver returns the number of the current scan line. See the Remarks section
    ///for more information.
    uint    dwScanLine;
    ///Specifies the location in which the driver writes the return value of the DdGetScanLine callback. A return code
    ///of DD_OK indicates success. For more information, see Return Values for DirectDraw.
    HRESULT ddRVal;
    ///Used by the Microsoft DirectDraw API and should not be filled in by the driver.
    void*   GetScanLine;
}

///The DD_MAPMEMORYDATA structure contains the information necessary to map or unmap a frame buffer into user-mode
///memory.
struct DD_MAPMEMORYDATA
{
    ///Points to a DD_DIRECTDRAW_GLOBAL structure that describes the driver's device.
    DD_DIRECTDRAW_GLOBAL* lpDD;
    ///Specifies the memory operation that the driver should perform. A value of <b>TRUE</b> indicates that the driver
    ///should map memory; <b>FALSE</b> means that the driver should unmap memory.
    BOOL    bMap;
    ///Handle to the process whose address space is affected.
    HANDLE  hProcess;
    ///Specifies the location in which the driver should return the base address of the process's memory-mapped space
    ///when <b>bMap</b> is <b>TRUE</b>. When <b>bMap</b> is <b>FALSE</b>, <b>fpProcess</b> contains the base address of
    ///the memory to be unmapped by the driver.
    size_t  fpProcess;
    ///Specifies the location in which the driver writes the return value of the DdMapMemory callback. A return code of
    ///DD_OK indicates success. For more information, see Return Values for DirectDraw.
    HRESULT ddRVal;
}

///The DD_CANCREATEVPORTDATA structure contains the information required for the driver to determine whether a video
///port extensions (VPE) object can be created.
struct DD_CANCREATEVPORTDATA
{
    ///Points to a DD_DIRECTDRAW_LOCAL structure that is relevant to the current Microsoft DirectDraw process only.
    DD_DIRECTDRAW_LOCAL* lpDD;
    ///Points to a DDVIDEOPORTDESC structure that contains a description of the VPE object being requested.
    DDVIDEOPORTDESC*     lpDDVideoPortDesc;
    ///Specifies the location in which the driver writes the return value of the DdVideoPortCanCreate callback. A return
    ///code of DD_OK indicates success. For more information, see Return Values for DirectDraw.
    HRESULT              ddRVal;
    ///Used by the DirectDraw API and should not be filled in by the driver.
    void*                CanCreateVideoPort;
}

///The DD_CREATEVPORTDATA structure contains the information necessary to describe the video port extensions (VPE)
///object being created.
struct DD_CREATEVPORTDATA
{
    ///Points to a DD_DIRECTDRAW_LOCAL structure that is relevant to the current Microsoft DirectDraw process only.
    DD_DIRECTDRAW_LOCAL* lpDD;
    ///Points to a DDVIDEOPORTDESC structure that describes the created VPE object.
    DDVIDEOPORTDESC*     lpDDVideoPortDesc;
    ///Points to a DD_VIDEOPORT_LOCAL structure that represents the created VPE object.
    DD_VIDEOPORT_LOCAL*  lpVideoPort;
    ///Specifies the location in which the driver writes the return value of the DdVideoPortCreate callback. A return
    ///code of DD_OK indicates success. For more information, see Return Values for DirectDraw.
    HRESULT              ddRVal;
    ///Used by the DirectDraw API and should not be filled in by the driver.
    void*                CreateVideoPort;
}

///The DD_FLIPVPORTDATA structure contains the information necessary for the video port extensions (VPE) object to
///perform a flip.
struct DD_FLIPVPORTDATA
{
    ///Points to a DD_DIRECTDRAW_LOCAL structure that is relevant to the current Microsoft DirectDraw process only.
    DD_DIRECTDRAW_LOCAL* lpDD;
    ///Points to a DD_VIDEOPORT_LOCAL structure that represents this VPE object.
    DD_VIDEOPORT_LOCAL*  lpVideoPort;
    ///Points to a DD_SURFACE_LOCALstructure for the current surface; that is, the surface on which data is currently
    ///being written.
    DD_SURFACE_LOCAL*    lpSurfCurr;
    ///Points to a DD_SURFACE_LOCAL structure for the target surface; that is, the surface to which the driver should
    ///flip.
    DD_SURFACE_LOCAL*    lpSurfTarg;
    ///Specifies the location in which the driver writes the return value of the DdVideoPortFlip callback. A return code
    ///of DD_OK indicates success. For more information, see Return Values for DirectDraw.
    HRESULT              ddRVal;
    ///Used by the DirectDraw API and should not be filled in by the driver.
    void*                FlipVideoPort;
}

///The DD_GETVPORTBANDWIDTHDATA structure contains the bandwidth information for any specified format.
struct DD_GETVPORTBANDWIDTHDATA
{
    ///Points to a DD_DIRECTDRAW_LOCAL structure that is relevant to the current Microsoft DirectDraw process only.
    DD_DIRECTDRAW_LOCAL* lpDD;
    ///Points to a DD_VIDEOPORT_LOCAL structure that represents this video port extensions (VPE) object.
    DD_VIDEOPORT_LOCAL*  lpVideoPort;
    ///Points to a DDPIXELFORMAT structure that describes the output pixel format for which the driver should return
    ///bandwidth information.
    DDPIXELFORMAT*       lpddpfFormat;
    uint                 dwWidth;
    ///Specify the dimensions of the source overlay or of the video data in pixels depending on the value of
    ///<b>dwFlags</b>. These values are calculated by the client based on the VPE object's capabilities returned in a
    ///prior call to DdVideoPortGetBandwidth.
    uint                 dwHeight;
    ///Specifies the flags indicating how the driver should interpret the <b>dwWidth</b> and <b>dwHeight</b> members.
    ///This member can be one of the values listed in the following table. <table> <tr> <th>Flag</th> <th>Meaning</th>
    ///</tr> <tr> <td> DDVPB_OVERLAY </td> <td> The <b>dwWidth</b> and <b>dwHeight</b> members specify the size in
    ///pixels of the source overlay surface. This flag indicates that the VPE object is dependent on the overlay source
    ///size. </td> </tr> <tr> <td> DDVPB_TYPE </td> <td> The <b>dwWidth</b> and <b>dwHeight</b> members are not set.
    ///</td> </tr> <tr> <td> DDVPB_VIDEOPORT </td> <td> The <b>dwWidth</b> and <b>dwHeight</b> members specify the
    ///prescale size of the video data that the VPE object writes to the frame buffer. This flag indicates that the VPE
    ///object is dependent on the overlay stretch factor. </td> </tr> </table>
    uint                 dwFlags;
    ///Points to the DDVIDEOPORTBANDWIDTH structure in which the driver should write the bandwidth parameters.
    DDVIDEOPORTBANDWIDTH* lpBandwidth;
    ///Specifies the location in which the driver writes the return value of the DdVideoPortGetBandwidth callback. A
    ///return code of DD_OK indicates success. For more information, see Return Values for DirectDraw.
    HRESULT              ddRVal;
    ///Used by the DirectDraw API and should not be filled in by the driver.
    void*                GetVideoPortBandwidth;
}

///The DD_GETVPORTINPUTFORMATDATA structure contains the information required for the driver to return the input formats
///that the video port extensions (VPE) object can accept.
struct DD_GETVPORTINPUTFORMATDATA
{
    ///Points to a DD_DIRECTDRAW_LOCAL structure that is relevant to the current Microsoft DirectDraw process only.
    DD_DIRECTDRAW_LOCAL* lpDD;
    ///Points to a DD_VIDEOPORT_LOCAL structure that represents this VPE object.
    DD_VIDEOPORT_LOCAL*  lpVideoPort;
    ///Indicates the type of formats for which support is being queried. This member can be one or more of the following
    ///values: <table> <tr> <th>Flag</th> <th>Meaning</th> </tr> <tr> <td> DDVPFORMAT_VBI </td> <td> The driver should
    ///return formats for the VBI data. </td> </tr> <tr> <td> DDVPFORMAT_VIDEO </td> <td> The driver should return
    ///formats for the video data. </td> </tr> </table>
    uint                 dwFlags;
    ///Points to an array of DDPIXELFORMAT structures in which the driver should write the pixel formats supported by
    ///the VPE object. This member can be <b>NULL</b>.
    DDPIXELFORMAT*       lpddpfFormat;
    ///Specifies the location in which the driver should write the number of formats that the VPE object supports.
    uint                 dwNumFormats;
    ///Specifies the location in which the driver writes the return value of the DdVideoPortGetInputFormats callback. A
    ///return code of DD_OK indicates success. For more information, see Return Values for DirectDraw.
    HRESULT              ddRVal;
    ///Used by the DirectDraw API and should not be filled in by the driver.
    void*                GetVideoPortInputFormats;
}

///The DD_GETVPORTOUTPUTFORMATDATA structure contains the information required for the driver to return all of the
///output formats that the video port extensions (VPE) object supports for a given input format.
struct DD_GETVPORTOUTPUTFORMATDATA
{
    ///Points to the DD_DIRECTDRAW_LOCAL structure that is relevant to the current Microsoft DirectDraw process only.
    DD_DIRECTDRAW_LOCAL* lpDD;
    ///Points to the DD_VIDEOPORT_LOCAL structure that represents this VPE object.
    DD_VIDEOPORT_LOCAL*  lpVideoPort;
    ///Indicates the type of output formats for which support is being queried. This member can be one or more of the
    ///following values: <table> <tr> <th>Flag</th> <th>Meaning</th> </tr> <tr> <td> DDVPFORMAT_VBI </td> <td> The
    ///driver should return formats for the VBI data. </td> </tr> <tr> <td> DDVPFORMAT_VIDEO </td> <td> The driver
    ///should return formats for the video data. </td> </tr> </table>
    uint                 dwFlags;
    ///Points to a DDPIXELFORMAT structure that contains an input format supported by the VPE object. This format was
    ///returned by DdVideoPortGetInputFormats.
    DDPIXELFORMAT*       lpddpfInputFormat;
    ///Points to an array of DDPIXELFORMAT structures in which the driver should return the output formats that the VPE
    ///object supports for the input format specified by <b>lpddpfInputFormat</b>. This member can be <b>NULL</b>.
    DDPIXELFORMAT*       lpddpfOutputFormats;
    ///Specifies the location in which the driver should return the number of output formats that the VPE object
    ///supports for the specified input format.
    uint                 dwNumFormats;
    ///Specifies the location in which the driver writes the return value of the DdVideoPortGetOutputFormats callback. A
    ///return code of DD_OK indicates success. For more information, see Return Values for DirectDraw.
    HRESULT              ddRVal;
    ///Unused: Win95 compatibility
    void*                GetVideoPortInputFormats;
}

///The DD_GETVPORTFIELDDATA structure contains the information required for the driver to determine whether the current
///field of an interlaced signal is even or odd.
struct DD_GETVPORTFIELDDATA
{
    ///Points to a DD_DIRECTDRAW_LOCAL structure that is relevant to the current Microsoft DirectDraw process only.
    DD_DIRECTDRAW_LOCAL* lpDD;
    ///Points to a DD_VIDEOPORT_LOCAL structure that represents this video port extensions (VPE) object.
    DD_VIDEOPORT_LOCAL*  lpVideoPort;
    ///Specifies the location in which the driver should indicate the polarity of the field. This member should be set
    ///to <b>TRUE</b> if the current field is the even field of an interlaced signal and to <b>FALSE</b> if the current
    ///field is the odd field.
    BOOL                 bField;
    ///Specifies the location in which the driver writes the return value of the DdVideoPortGetField callback. A return
    ///code of DD_OK indicates success. For more information, see Return Values for DirectDraw.
    HRESULT              ddRVal;
    ///Used by the DirectDraw API and should not be filled in by the driver.
    void*                GetVideoPortField;
}

///The DD_GETVPORTLINEDATA structure contains the current line number of the hardware video port.
struct DD_GETVPORTLINEDATA
{
    ///Points to a DD_DIRECTDRAW_LOCAL structure that is relevant to the current Microsoft DirectDraw process only.
    DD_DIRECTDRAW_LOCAL* lpDD;
    ///Points to a DD_VIDEOPORT_LOCAL structure that represents this video port extensions (VPE) object.
    DD_VIDEOPORT_LOCAL*  lpVideoPort;
    ///Specifies the location in which the driver should write the current line number on the hardware video port.
    uint                 dwLine;
    ///Specifies the location in which the driver writes the return value of the DdVideoPortGetLine callback. A return
    ///code of DD_OK indicates success. For more information, see Return Values for DirectDraw.
    HRESULT              ddRVal;
    ///Used by the DirectDraw API and should not be filled in by the driver.
    void*                GetVideoPortLine;
}

///The DD_GETVPORTCONNECTDATA structure contains the connection combinations supported by the specified video port
///extensions (VPE) object.
struct DD_GETVPORTCONNECTDATA
{
    ///Points to a DD_DIRECTDRAW_LOCAL structure that is relevant to the current Microsoft DirectDraw process only.
    DD_DIRECTDRAW_LOCAL* lpDD;
    ///Specifies the ID of the VPE object for which the driver is to retrieve connection information. DirectDraw obtains
    ///this ID from the <b>dwVideoPortID</b> member of the DDVIDEOPORTCAPS structure.
    uint                 dwPortId;
    ///Points to an array of DDVIDEOPORTCONNECT structures in which the driver should return the characteristics of each
    ///connection that the VPE object supports. This member can be <b>NULL</b>.
    DDVIDEOPORTCONNECT*  lpConnect;
    ///Specifies the location in which the driver returns the number of connection combinations supported by the
    ///specified VPE object.
    uint                 dwNumEntries;
    ///Specifies the location in which the driver writes the return value of the DdVideoPortGetConnectInfo callback. A
    ///return code of DD_OK indicates success. For more information, see Return Values for DirectDraw.
    HRESULT              ddRVal;
    ///Used by the DirectDraw API and should not be filled in by the driver.
    void*                GetVideoPortConnectInfo;
}

///The DD_DESTROYVPORTDATA structure contains the information necessary for the driver to clean up.
struct DD_DESTROYVPORTDATA
{
    ///Points to a DD_DIRECTDRAW_LOCAL structure that is relevant to the current Microsoft DirectDraw process only.
    DD_DIRECTDRAW_LOCAL* lpDD;
    ///Points to a DD_VIDEOPORT_LOCAL structure that represents this video port extensions (VPE) object.
    DD_VIDEOPORT_LOCAL*  lpVideoPort;
    ///Specifies the location in which the driver writes the return value of the DdVideoPortDestroy callback. A return
    ///code of DD_OK indicates success. For more information, see Return Values for DirectDraw.
    HRESULT              ddRVal;
    ///Used by the DirectDraw API and should not be filled in by the driver.
    void*                DestroyVideoPort;
}

///The DD_GETVPORTFLIPSTATUSDATA structure contains the flip status information for the specified surface.
struct DD_GETVPORTFLIPSTATUSDATA
{
    ///Points to the DD_DIRECTDRAW_LOCAL structure that is relevant to the current Microsoft DirectDraw process only.
    DD_DIRECTDRAW_LOCAL* lpDD;
    ///Points to the surface for which the flip status information is required.
    size_t               fpSurface;
    ///Specifies the location in which the driver writes the return value of the DdVideoPortGetFlipStatus callback. A
    ///return code of DD_OK indicates success. For more information, see Return Values for DirectDraw.
    HRESULT              ddRVal;
    ///Used by the DirectDraw API and should not be filled in by the driver.
    void*                GetVideoPortFlipStatus;
}

///The DD_UPDATEVPORTDATA structure contains the information required to start, stop, and change the video port
///extensions (VPE) object.
struct DD_UPDATEVPORTDATA
{
    ///Points to a DD_DIRECTDRAW_LOCAL structure that is relevant to the current Microsoft DirectDraw process only.
    DD_DIRECTDRAW_LOCAL* lpDD;
    ///Points to a DD_VIDEOPORT_LOCAL structure that represents this VPE object.
    DD_VIDEOPORT_LOCAL*  lpVideoPort;
    ///Points to an array of DD_SURFACE_INT structures that represent regular video surfaces. This member can be
    ///<b>NULL</b>.
    DD_SURFACE_INT**     lplpDDSurface;
    ///Points to an array of DD_SURFACE_INT structures that represent VBI surfaces. This member can be <b>NULL</b>.
    DD_SURFACE_INT**     lplpDDVBISurface;
    ///Points to a DDVIDEOPORTINFO structure that describes how the VPE object should transfer video data to a surface.
    ///This member can be <b>NULL</b> when <b>dwFlags</b> is DDRAWI_VPORTSTOP.
    DDVIDEOPORTINFO*     lpVideoInfo;
    ///Indicates the action to be performed by the VPE object. This member must be one of the following values: <table>
    ///<tr> <th>Flag</th> <th>Meaning</th> </tr> <tr> <td> DDRAWI_VPORTSTART </td> <td> The driver should start the flow
    ///of data through the VPE object. </td> </tr> <tr> <td> DDRAWI_VPORTSTOP </td> <td> The driver should stop the flow
    ///of data through the VPE object. </td> </tr> <tr> <td> DDRAWI_VPORTUPDATE </td> <td> <b>DdVideoPortUpdate</b> has
    ///been called with a new set of flags in the <b>dwVPFlags</b> member of the DDVIDEOPORTINFO structure to which
    ///<b>lpVideoInfo</b> points. The driver should change the flow of data through the VPE object according to the new
    ///flags. </td> </tr> </table>
    uint                 dwFlags;
    ///Specifies the number of surfaces in the list to which <b>lplpDDSurface</b> points. If this member is greater than
    ///1, <b>lplpDDSurface</b> is an array of surface structures to accommodate autoflipping.
    uint                 dwNumAutoflip;
    ///Specifies the number of surfaces in the list to which <b>lplpDDVBISurface</b> points. If this member is greater
    ///than 1, <b>lplpDDVBISurface</b> is an array of surface structures to accommodate autoflipping of VBI data.
    uint                 dwNumVBIAutoflip;
    ///Specifies the location in which the driver writes the return value of the DdVideoPortUpdate callback. A return
    ///code of DD_OK indicates success. For more information, see Return Values for DirectDraw.
    HRESULT              ddRVal;
    ///Used by the DirectDraw API and should not be filled in by the driver.
    void*                UpdateVideoPort;
}

///The DD_WAITFORVPORTSYNCDATA structure contains the information required for the driver to synchronize the video port
///extensions (VPE) object.
struct DD_WAITFORVPORTSYNCDATA
{
    ///Points to a DD_DIRECTDRAW_LOCAL structure that is relevant to the current Microsoft DirectDraw process only.
    DD_DIRECTDRAW_LOCAL* lpDD;
    ///Points to a DD_VIDEOPORT_LOCAL structure that represents this VPE object.
    DD_VIDEOPORT_LOCAL*  lpVideoPort;
    ///Indicates the condition for which the driver should wait. This member can be one of the following values: <table>
    ///<tr> <th>Flag</th> <th>Meaning</th> </tr> <tr> <td> DDVPWAIT_BEGIN </td> <td> The driver should return at the
    ///beginning of the next V-sync. </td> </tr> <tr> <td> DDVPWAIT_END </td> <td> The driver should return at the end
    ///of the next/current V-sync. </td> </tr> <tr> <td> DDVPWAIT_LINE </td> <td> The driver should return at the
    ///beginning of the line specified in <b>dwLine</b>. </td> </tr> </table>
    uint                 dwFlags;
    ///Specifies the line number on which the driver should synchronize when <b>dwFlags</b> is DDVPWAIT_LINE. The driver
    ///should ignore this member when <b>dwFlags</b> is set to DDVPWAIT_BEGIN or DDVPWAIT_END.
    uint                 dwLine;
    ///Specifies the maximum amount of time the driver should wait, in milliseconds, before timing out.
    uint                 dwTimeOut;
    ///Specifies the location in which the driver writes the return value of the DdVideoPortWaitForSync callback. A
    ///return code of DD_OK indicates success. For more information, see Return Values for DirectDraw.
    HRESULT              ddRVal;
    ///Used by the DirectDraw API and should not be filled in by the driver.
    void*                UpdateVideoPort;
}

///The DD_GETVPORTSIGNALDATA structure contains the signal status of the hardware video port.
struct DD_GETVPORTSIGNALDATA
{
    ///Points to a DD_DIRECTDRAW_LOCAL structure that is relevant to the current Microsoft DirectDraw process only.
    DD_DIRECTDRAW_LOCAL* lpDD;
    ///Points to a DD_VIDEOPORT_LOCAL structure that represents this video port extensions (VPE) object.
    DD_VIDEOPORT_LOCAL*  lpVideoPort;
    ///Specifies the location in which the driver should write the status of the signal at the hardware video port. This
    ///member can be one of the following values: <table> <tr> <th>Flag</th> <th>Meaning</th> </tr> <tr> <td>
    ///DDVPSQ_NOSIGNAL </td> <td> No video signal is present at the hardware video port. </td> </tr> <tr> <td>
    ///DDVPSQ_SIGNALOK </td> <td> A valid video signal is present at the hardware video port. </td> </tr> </table>
    uint                 dwStatus;
    ///Specifies the location in which the driver writes the return value of the DdVideoPortGetSignalStatus callback. A
    ///return code of DD_OK indicates success. For more information, see Return Values for DirectDraw.
    HRESULT              ddRVal;
    ///Used by the DirectDraw API and should not be filled in by the driver.
    void*                GetVideoSignalStatus;
}

///The DD_VPORTCOLORDATA structure contains the video port extensions (VPE) object color control information.
struct DD_VPORTCOLORDATA
{
    ///Points to a DD_DIRECTDRAW_LOCAL structure that is relevant to the current Microsoft DirectDraw process only.
    DD_DIRECTDRAW_LOCAL* lpDD;
    ///Points to a DD_VIDEOPORT_LOCAL structure that represents this VPE object.
    DD_VIDEOPORT_LOCAL*  lpVideoPort;
    ///Specifies the color control operation to be performed by the driver. This member can be one of the following
    ///values: <table> <tr> <th>Flag</th> <th>Meaning</th> </tr> <tr> <td> DDRAWI_VPORTGETCOLOR </td> <td> The driver
    ///should write the current VPE object color controls into the DDCOLORCONTROL structure to which <b>lpColorData</b>
    ///points. </td> </tr> <tr> <td> DDRAWI_VPORTSETCOLOR </td> <td> The driver should set new values for the VPE object
    ///color controls based on the contents of the DDCOLORCONTROL structure to which <b>lpColorData</b> points. </td>
    ///</tr> </table>
    uint                 dwFlags;
    ///Points to a DDCOLORCONTROL structure that defines the color control associated with the VPE object to which
    ///<b>lpVideoPort</b> points. The value of <b>dwFlags</b> determines whether the driver reads from or writes to this
    ///structure.
    DDCOLORCONTROL*      lpColorData;
    ///Specifies the location in which the driver writes the return value of the DdVideoPortColorControl callback. A
    ///return code of DD_OK indicates success. For more information, see Return Values for DirectDraw.
    HRESULT              ddRVal;
    ///Used by the DirectDraw API and should not be filled in by the driver.
    void*                ColorControl;
}

///The DD_COLORCONTROLDATA structure contains the color control information for the specified overlay.
struct DD_COLORCONTROLDATA
{
    ///Points to a DD_DIRECTDRAW_GLOBAL structure that describes the driver's device.
    DD_DIRECTDRAW_GLOBAL* lpDD;
    ///Points to the DD_SURFACE_LOCAL structure representing the overlay surface.
    DD_SURFACE_LOCAL* lpDDSurface;
    ///Points to a DDCOLORCONTROL structure. See the <b>dwFlags</b> member to determine how to use this member.
    DDCOLORCONTROL*   lpColorData;
    ///Indicates a set of flags that specify the color control flags. This member can be one of the following values:
    ///<table> <tr> <th>Flag</th> <th>Meaning</th> </tr> <tr> <td> DDRAWI_GETCOLOR </td> <td> The driver should return
    ///the color controls it supports for the specified overlay in the <b>lpColorData</b> member. The driver should set
    ///the appropriate flags in the <b>dwFlags</b> member of the DDCOLORCONTROL structure to indicate in which other
    ///members the driver has returned valid data. </td> </tr> <tr> <td> DDRAWI_SETCOLOR </td> <td> The driver should
    ///set the current color controls for the specified overlay using the values specified in the <b>lpColorData</b>
    ///member. </td> </tr> </table>
    uint              dwFlags;
    ///Specifies the location in which the driver writes the return value of the DdControlColor callback. A return code
    ///of DD_OK indicates success. For more information, see Return Values for DirectDraw.
    HRESULT           ddRVal;
    ///Used by the Microsoft DirectDraw API and should not be filled in by the driver.
    void*             ColorControl;
}

///The DD_GETDRIVERINFODATA structure is used to pass data to and from the <i>DdGetDriverInfo</i> callback routine.
struct DD_GETDRIVERINFODATA
{
    ///Handle to the driver's PDEV. Microsoft Windows 2000 and later only.
    void*   dhpdev;
    ///Specifies the size in bytes of this DD_GETDRIVERINFODATA structure.
    uint    dwSize;
    ///Currently unused and is set to zero.
    uint    dwFlags;
    ///Specifies the GUID of the Microsoft DirectX support for which the driver is being queried. In a Windows 2000 and
    ///later Microsoft DirectDraw driver, this member can be one of the following values (in alphabetic order): <table>
    ///<tr> <th>GUID</th> <th>Description</th> </tr> <tr> <td> GUID_ColorControlCallbacks </td> <td> Queries whether the
    ///driver supports DdControlColor. If the driver does support it, the driver should initialize and return a
    ///DD_COLORCONTROLCALLBACKS structure in the buffer to which <b>lpvData</b> points. </td> </tr> <tr> <td>
    ///GUID_D3DCallbacks </td> <td> Queries whether the driver supports any of the functionality specified through the
    ///D3DHAL_CALLBACKS structure. If the driver does not provide any of this support, it should initialize and return a
    ///D3DHAL_CALLBACKS structure in the buffer to which <b>lpvData</b> points. </td> </tr> <tr> <td> GUID_D3DCallbacks2
    ///</td> <td> Obsolete. </td> </tr> <tr> <td> GUID_D3DCallbacks3 </td> <td> Queries whether the driver supports any
    ///of the functionality specified through the D3DHAL_CALLBACKS3 structure. If the driver does provide any of this
    ///support, it should initialize and return a D3DHAL_CALLBACKS3 structure in the buffer to which <b>lpvData</b>
    ///points. </td> </tr> <tr> <td> GUID_D3DCaps </td> <td> Obsolete. </td> </tr> <tr> <td> GUID_D3DExtendedCaps </td>
    ///<td> Queries whether the driver supports any of the Microsoft Direct3D functionality specified through the
    ///D3DHAL_D3DEXTENDEDCAPS structure. If the driver does provide any of this support, it should initialize and return
    ///a D3DHAL_D3DEXTENDEDCAPS structure in the buffer to which <b>lpvData</b> points. </td> </tr> <tr> <td>
    ///GUID_D3DParseUnknownCommandCallback </td> <td> Provides the Direct3D portion of the driver with the Direct3D
    ///runtime's <i>D3dParseUnknownCommandCallback</i>. The driver's D3dDrawPrimitives2 callback calls
    ///<i>D3dParseUnknownCommandCallback</i> to parse commands from the command buffer that the driver doesn't
    ///understand.DirectDraw passes a pointer to this function in the buffer to which <b>lpvData</b> points. If the
    ///driver supports this aspect of Direct3D, it should store the pointer. </td> </tr> <tr> <td> GUID_GetHeapAlignment
    ///</td> <td> Queries whether the driver supports surface alignment requirements on a per-heap basis. If the driver
    ///does provide this support, it should initialize and return a DD_GETHEAPALIGNMENTDATA structure in the buffer to
    ///which <b>lpvData</b> points. </td> </tr> <tr> <td> GUID_KernelCallbacks </td> <td> Queries whether the driver
    ///supports any of the functionality specified through the DD_KERNELCALLBACKS structure. If the driver does provide
    ///any of this support, it should initialize and return a DD_KERNELCALLBACKS structure in the buffer to which
    ///<b>lpvData</b> points. </td> </tr> <tr> <td> GUID_KernelCaps </td> <td> Queries whether the driver supports any
    ///of the kernel-mode capabilities specified through the DDKERNELCAPS structure. If the driver does provide any of
    ///this support, it should initialize and return a DDKERNELCAPS structure in the buffer to which <b>lpvData</b>
    ///points. </td> </tr> <tr> <td> GUID_MiscellaneousCallbacks </td> <td> Queries whether the driver supports
    ///DdGetAvailDriverMemory. If the driver does support it, the driver should initialize and return a
    ///DD_MISCELLANEOUSCALLBACKS structure in the buffer to which <b>lpvData</b> points. </td> </tr> <tr> <td>
    ///GUID_Miscellaneous2Callbacks </td> <td> Queries whether the driver supports the additional miscellaneous
    ///functionality specified in the DD_MISCELLANEOUS2CALLBACKS structure. If the driver does support any of this
    ///support, the driver should initialize and return a DD_MISCELLANEOUS2CALLBACKS structure in the buffer to which
    ///<b>lpvData</b> points. </td> </tr> <tr> <td> GUID_MotionCompCallbacks </td> <td> Queries whether the driver
    ///supports the motion compensation functionality specified through the DD_MOTIONCOMPCALLBACKS structure. If the
    ///driver does provide any of this support, is should initialize and return a DD_MOTIONCOMPCALLBACKS structure in
    ///the buffer to which <b>lpvData</b> points. </td> </tr> <tr> <td> GUID_NonLocalVidMemCaps </td> <td> Queries
    ///whether the driver supports any of the nonlocal display memory capabilities specified through the
    ///DD_NONLOCALVIDMEMCAPS structure. If the driver does provide any of this support, it should initialize and return
    ///a DD_NONLOCALVIDMEMCAPS structure in the buffer to which <b>lpvData</b> points. </td> </tr> <tr> <td>
    ///GUID_NTCallbacks </td> <td> Queries whether the driver supports any of the functionality specified through the
    ///DD_NTCALLBACKS structure. If the driver does provide any of this support, it should initialize and return a
    ///DD_NTCALLBACKS structure in the buffer to which <b>lpvData</b> points. </td> </tr> <tr> <td>
    ///GUID_NTPrivateDriverCaps </td> <td> Queries whether the driver supports the Windows 98/Me-style surface creation
    ///techniques specified through the DD_NTPRIVATEDRIVERCAPS structure. If the driver does provide any of this
    ///support, it should initialize and return a DD_NTPRIVATEDRIVERCAPS structure in the buffer to which <b>lpvData</b>
    ///points. </td> </tr> <tr> <td> GUID_UpdateNonLocalHeap </td> <td> Queries whether the driver supports retrieval of
    ///the base addresses of each nonlocal heap in turn. If the driver does provide this support, it should initialize
    ///and return a DD_UPDATENONLOCALHEAPDATA structure in the buffer to which <b>lpvData</b> points. </td> </tr> <tr>
    ///<td> GUID_VideoPortCallbacks </td> <td> Queries whether the driver supports the video port extensions (VPE). If
    ///the driver does support VPE, it should initialize and return a DD_VIDEOPORTCALLBACKS structure in the buffer to
    ///which <b>lpvData</b> points. </td> </tr> <tr> <td> GUID_VideoPortCaps </td> <td> Queries whether the driver
    ///supports any of the VPE object capabilities specified through the DDVIDEOPORTCAPS structure. If the driver does
    ///provide any of this support, it should initialize and return a DDVIDEOPORTCAPS structure in the buffer to which
    ///<b>lpvData</b> points. </td> </tr> <tr> <td> GUID_ZPixelFormats </td> <td> Queries the pixel formats supported by
    ///the depth buffer. If the driver supports Direct3D, it should allocate and initialize the appropriate members of a
    ///DDPIXELFORMAT structure for every z-buffer format that it supports and return these in the buffer to which
    ///<b>lpvData</b> points. </td> </tr> </table>
    GUID    guidInfo;
    ///Specifies the number of bytes of data that DirectDraw expects the driver to pass back in the buffer to which
    ///<b>lpvData</b> points.
    uint    dwExpectedSize;
    ///Points to a DirectDraw-allocated buffer into which the driver copies the requested data. This buffer is typically
    ///<b>dwExpectedSize</b> bytes in size. The driver must not write more than <b>dwExpectedSize</b> bytes of data in
    ///it. The driver specifies the number of bytes that it writes to this buffer in the <b>dwActualSize</b> member.
    void*   lpvData;
    ///Specifies the location in which the driver returns the number of bytes of data it writes in <b>lpvData</b>.
    uint    dwActualSize;
    ///Specifies the location in which the driver writes the return value of the DdGetDriverInfo callback. A return code
    ///of DD_OK indicates success. For more information, see Return Values for DirectDraw.
    HRESULT ddRVal;
}

///The DD_GETAVAILDRIVERMEMORYDATA structure contains the information needed by the driver to query and return the
///amount of free memory.
struct DD_GETAVAILDRIVERMEMORYDATA
{
    ///Points to the DD_DIRECTDRAW_GLOBAL structure that describes the driver's device.
    DD_DIRECTDRAW_GLOBAL* lpDD;
    ///Points to a DDSCAPS structure that describes the type of surface for which memory availability is being queried.
    DDSCAPS DDSCaps;
    ///Specifies the location in which the driver returns the number of bytes of driver-managed memory that can be used
    ///for surfaces of the type described by <b>DDSCaps</b>.
    uint    dwTotal;
    ///Specifies the location in which the driver returns the amount of free memory in bytes for the surface type
    ///described by <b>DDSCaps</b>.
    uint    dwFree;
    ///Specifies the location in which the driver writes the return value of the DdGetAvailDriverMemory callback. A
    ///return code of DD_OK indicates success. For more information, see Return Values for DirectDraw.
    HRESULT ddRVal;
    ///Used by the Microsoft DirectDraw API and should not be filled in by the driver.
    void*   GetAvailDriverMemory;
}

///The DD_FREEDRIVERMEMORYDATA structure contains the details of the free request.
struct DD_FREEDRIVERMEMORYDATA
{
    ///Points to the DD_DIRECTDRAW_GLOBAL structure that describes the driver's device.
    DD_DIRECTDRAW_GLOBAL* lpDD;
    ///Points to the DD_SURFACE_LOCAL structure representing the surface that Microsoft DirectDraw is attempting to
    ///allocate.
    DD_SURFACE_LOCAL* lpDDSurface;
    ///Specifies the location in which the driver writes the return value of the DdFreeDriverMemory callback. A return
    ///code of DD_OK indicates that the driver succeeded in freeing some space; otherwise, the driver should set this to
    ///be DDERR_OUTOFMEMORY. For more information, see Return Values for DirectDraw.
    HRESULT           ddRVal;
    ///Used by the DirectDraw API and should not be filled in by the driver.
    void*             FreeDriverMemory;
}

///The DD_SETEXCLUSIVEMODEDATA structure contains the exclusive mode notification information.
struct DD_SETEXCLUSIVEMODEDATA
{
    ///Points to a DD_DIRECTDRAW_GLOBAL structure that describes the driver's device.
    DD_DIRECTDRAW_GLOBAL* lpDD;
    ///Indicates that a Microsoft DirectDraw application is switching into exclusive mode when <b>TRUE</b>; indicates
    ///that a DirectDraw application is leaving exclusive mode when <b>FALSE</b>.
    uint    dwEnterExcl;
    ///This is reserved for system use and should be ignored by the driver.
    uint    dwReserved;
    ///Specifies the location in which the driver writes the return value of the DdSetExclusiveMode callback. A return
    ///code of DD_OK indicates success. For more information, see Return Values for DirectDraw.
    HRESULT ddRVal;
    ///Used by the DirectDraw API and should not be filled in by the driver.
    void*   SetExclusiveMode;
}

///The DD_FLIPTOGDISURFACEDATA structure contains the GDI surface notification information.
struct DD_FLIPTOGDISURFACEDATA
{
    ///Points to the DD_DIRECTDRAW_GLOBAL structure that describes the driver's device.
    DD_DIRECTDRAW_GLOBAL* lpDD;
    ///Indicates that Microsoft DirectDraw is flipping to a GDI surface when <b>TRUE</b>; indicates that DirectDraw is
    ///flipping from a GDI surface when <b>FALSE</b>.
    uint    dwToGDI;
    ///Reserved for system use and should be ignored by the driver.
    uint    dwReserved;
    ///Specifies the location in which the driver writes the return value of the DdFlipToGDISurface callback. A return
    ///code of DD_OK indicates success. For more information, see Return Values for DirectDraw.
    HRESULT ddRVal;
    ///Used by the DirectDraw API and should not be filled in by the driver.
    void*   FlipToGDISurface;
}

///The DD_SYNCSURFACEDATA structure contains the surface information.
struct DD_SYNCSURFACEDATA
{
    ///Points to a DD_DIRECTDRAW_LOCAL structure that is relevant to the current Microsoft DirectDraw process only.
    DD_DIRECTDRAW_LOCAL* lpDD;
    ///Points to the DD_SURFACE_LOCAL structure that describes the surface with which to sync.
    DD_SURFACE_LOCAL*    lpDDSurface;
    ///Contains the byte offset from the start of the frame buffer to the start of the surface. This value is used only
    ///by the video miniport driver. This member must contain data that is filled in by the driver.
    uint                 dwSurfaceOffset;
    ///Contains the pointer value to be returned by the DdLock call for accessing the surface. This value is used by a
    ///kernel-mode client. This member can be modified by the driver, but does not need to be.
    size_t               fpLockPtr;
    ///Contains the pitch in bytes passed to the client during a DdLock call. This member can be modified by the driver,
    ///but does not need to be.
    int                  lPitch;
    ///Contains the byte offset from the start of the frame buffer to the start of the overlay. This value is used only
    ///by the video miniport driver and may be different than the <b>dwSurfaceOffset</b> member if cropping is involved
    ///or if the overlay origin is not the top left of the surface. This member must contain data that is filled in by
    ///the driver.
    uint                 dwOverlayOffset;
    ///Reserved for use by the display driver.
    uint                 dwDriverReserved1;
    ///Reserved for use by the display driver.
    uint                 dwDriverReserved2;
    ///Reserved for use by the display driver.
    uint                 dwDriverReserved3;
    ///Reserved for use by the display driver. Windows 2000 and later only.
    uint                 dwDriverReserved4;
    ///Specifies the location in which the driver writes the return value of the DdSyncSurfaceData callback. A return
    ///code of DD_OK indicates success. For more information, see Return Values for DirectDraw.
    HRESULT              ddRVal;
}

///The DD_SYNCVIDEOPORTDATA structure contains the video port extensions (VPE) object information.
struct DD_SYNCVIDEOPORTDATA
{
    ///Points to a DD_DIRECTDRAW_LOCAL structure that is relevant to the current Microsoft DirectDraw process only.
    DD_DIRECTDRAW_LOCAL* lpDD;
    ///Points to a DD_VIDEOPORT_LOCAL structure that describes the hardware video port with which to sync.
    DD_VIDEOPORT_LOCAL*  lpVideoPort;
    ///Contains the byte offset from the top left corner of the surface to the top left corner of where the VPE object
    ///writes its data. This value is only used by the video miniport driver. This member must contain data that is
    ///filled in by the driver.
    uint                 dwOriginOffset;
    ///Contains the height in pixels of the VPE object data. By default, this is twice the field height when
    ///interleaved, but the driver can change this if it needs to. This value is used only by the video miniport driver.
    ///This member can be modified by the driver, but does not need to be.
    uint                 dwHeight;
    ///Contains the number of lines in the VBI region. This value is used only by the video miniport driver. This member
    ///can be modified by the driver, but does not need to be.
    uint                 dwVBIHeight;
    ///Is reserved for use by the display driver.
    uint                 dwDriverReserved1;
    ///Reserved for use by the display driver.
    uint                 dwDriverReserved2;
    ///Reserved for use by the display driver.
    uint                 dwDriverReserved3;
    ///Specifies the location in which the driver writes the return value of the DdSyncVideoPortData callback. A return
    ///code of DD_OK indicates success. For more information, see Return Values for DirectDraw.
    HRESULT              ddRVal;
}

///The DD_GETMOCOMPGUIDSDATA structure contains the motion compensation GUID information.
struct DD_GETMOCOMPGUIDSDATA
{
    ///Points to a DD_DIRECTDRAW_LOCAL structure that is relevant to the current Microsoft DirectDraw process only.
    DD_DIRECTDRAW_LOCAL* lpDD;
    ///Indicates the number of motion compensation GUIDs in <b>lpGuids</b>.
    uint                 dwNumGuids;
    ///Points to a list of GUIDs that describe the motion compensation processes being used. If <b>lpGuids</b> is
    ///<b>NULL</b>, the driver should set <b>dwNumGuids</b> to the number of GUIDs that it supports. Otherwise, it
    ///should fill <b>lpGuids</b> with the GUIDs that it supports and set the number in <b>dwNumGuids</b>.
    GUID*                lpGuids;
    ///Specifies the location in which the driver writes the return value of the DdMoCompGetGuids callback. A return
    ///code of DD_OK indicates success. For more information, see Return Values for DirectDraw.
    HRESULT              ddRVal;
}

///The DD_GETMOCOMPFORMATSDATA structure contains the uncompressed format information.
struct DD_GETMOCOMPFORMATSDATA
{
    ///Points to a DD_DIRECTDRAW_LOCAL structure that is relevant to the current Microsoft DirectDraw process only.
    DD_DIRECTDRAW_LOCAL* lpDD;
    ///Points to a GUID that describes the uncompressed formats being requested.
    GUID*                lpGuid;
    ///Indicates the number of uncompressed formats supported for the specified GUID.
    uint                 dwNumFormats;
    ///Points to a DDPIXELFORMAT structure that contains the motion compensation pixel format. If this member is not
    ///<b>NULL</b>, the uncompressed formats are copied into the buffer pointed to by this member.
    DDPIXELFORMAT*       lpFormats;
    ///Specifies the location in which the driver writes the return value of the DdMoCompGetFormats callback. A return
    ///code of DD_OK indicates success. For more information, see Return Values for DirectDraw.
    HRESULT              ddRVal;
}

///The DD_CREATEMOCOMPDATA structure contains the data required to begin using motion compensation.
struct DD_CREATEMOCOMPDATA
{
    ///Points to a DD_DIRECTDRAW_LOCAL structure that is relevant to the current Microsoft DirectDraw process only.
    DD_DIRECTDRAW_LOCAL* lpDD;
    ///Points to a DD_MOTIONCOMP_LOCAL structure that contains a description of the motion compensation object.
    DD_MOTIONCOMP_LOCAL* lpMoComp;
    ///Points to a GUID that describes the motion compensation process being used.
    GUID*                lpGuid;
    ///Specifies the width in pixels of the uncompressed output frame.
    uint                 dwUncompWidth;
    ///Specifies the height in pixels of the uncompressed output frame.
    uint                 dwUncompHeight;
    ///Points to a DDPIXELFORMAT structure that contains the format of the uncompressed output frame.
    DDPIXELFORMAT        ddUncompPixelFormat;
    ///Points to an optional data buffer that contains any optional information required by the GUID given in
    ///<b>lpGuid</b>. This buffer cannot contain any embedded pointers.
    void*                lpData;
    ///Indicates the size in bytes of the data buffer contained in <b>lpData</b>.
    uint                 dwDataSize;
    ///Specifies the location in which the driver writes the return value of the DdMoCompCreate callback. A return code
    ///of DD_OK indicates success. For more information, see Return Values for DirectDraw.
    HRESULT              ddRVal;
}

///The DDCOMPBUFFERINFO structure contains driver-supplied information regarding compression buffers.
struct DDCOMPBUFFERINFO
{
    ///Specifies the size in bytes of this DDCOMPBUFFERINFO structure.
    uint          dwSize;
    ///Indicates the number of surfaces of this type required for decompression.
    uint          dwNumCompBuffers;
    ///Indicates the width in pixels of the surface of this type to create.
    uint          dwWidthToCreate;
    ///Indicates the height in pixels of the surface of this type to create.
    uint          dwHeightToCreate;
    ///Indicates the total number of bytes used by each surface.
    uint          dwBytesToAllocate;
    ///Points to a DDSCAPS2 structure that contains the capabilities to use when creating surfaces of this type. This
    ///allows the driver to specify the type of memory to use when creating these surfaces.
    DDSCAPS2      ddCompCaps;
    ///Points to a DDPIXELFORMAT structure that contains the pixel formats to use when creating surfaces of this type.
    DDPIXELFORMAT ddPixelFormat;
}

///The DD_GETMOCOMPCOMPBUFFDATA structure contains the compressed buffer information.
struct DD_GETMOCOMPCOMPBUFFDATA
{
    ///Points to a DD_DIRECTDRAW_LOCAL structure that is relevant to the current Microsoft DirectDraw process only.
    DD_DIRECTDRAW_LOCAL* lpDD;
    ///Points to a GUID for which the compressed buffer information is requested.
    GUID*                lpGuid;
    ///Indicates the width in pixels of the uncompressed output frame.
    uint                 dwWidth;
    ///Indicates the height in pixels of the uncompressed output frame.
    uint                 dwHeight;
    ///Points to a DDPIXELFORMAT structure that contains the pixel format of the uncompressed output frame.
    DDPIXELFORMAT        ddPixelFormat;
    ///Indicates how many different types of surfaces the driver requires to perform motion compensation using the
    ///requested GUID.
    uint                 dwNumTypesCompBuffs;
    ///Points to a DDCOMPBUFFERINFO structure that contains the driver-supplied information for each type of required
    ///surface.
    DDCOMPBUFFERINFO*    lpCompBuffInfo;
    ///Specifies the location in which the driver writes the return value of the DdMoCompGetBuffInfo callback. A return
    ///code of DD_OK indicates success. For more information, see Return Values for DirectDraw.
    HRESULT              ddRVal;
}

///The DD_GETINTERNALMOCOMPDATA structure contains the internal memory requirements.
struct DD_GETINTERNALMOCOMPDATA
{
    ///Points to a DD_DIRECTDRAW_LOCAL structure that is relevant to the current Microsoft DirectDraw process only.
    DD_DIRECTDRAW_LOCAL* lpDD;
    ///Points to a GUID for which the internal memory requirement is requested.
    GUID*                lpGuid;
    ///Indicates the width in pixels of uncompressed output frame.
    uint                 dwWidth;
    ///Indicates the height in pixels of uncompressed output frame.
    uint                 dwHeight;
    ///Points to a DDPIXELFORMAT structure that contains the pixel format of the uncompressed output frame.
    DDPIXELFORMAT        ddPixelFormat;
    ///Indicates the size in bytes of internal memory that the display driver privately reserves to perform motion
    ///compensation
    uint                 dwScratchMemAlloc;
    ///Specifies the location in which the driver writes the return value of the DdMoCompGetInternalInfo callback. A
    ///return code of DD_OK indicates success. For more information, see Return Values for DirectDraw.
    HRESULT              ddRVal;
}

///The DDHAL_BEGINMOCOMPFRAMEDATA structure contains the frame information required to start decoding.
struct DD_BEGINMOCOMPFRAMEDATA
{
    ///Points to a DD_DIRECTDRAW_LOCAL structure that is relevant to the current Microsoft DirectDraw process only.
    DD_DIRECTDRAW_LOCAL* lpDD;
    ///Points to a DD_MOTIONCOMP_LOCAL structure that contains a description of the motion compensation being requested.
    DD_MOTIONCOMP_LOCAL* lpMoComp;
    ///Points to a DD_SURFACE_LOCAL structure representing the destination surface in which to decode this frame.
    DD_SURFACE_LOCAL*    lpDestSurface;
    ///Indicates the size in bytes of optional input data in <b>lpInputData</b> that is required to begin this frame.
    uint                 dwInputDataSize;
    ///Points to an optional input buffer, the contents of which are defined by the GUID. This buffer cannot contain any
    ///embedded pointers.
    void*                lpInputData;
    ///Indicates the size in bytes of optional output data in <b>lpOutputData</b> that is required to begin this frame.
    uint                 dwOutputDataSize;
    ///Points to an optional output buffer, the contents of which are defined by the GUID. This buffer cannot contain
    ///any embedded pointers.
    void*                lpOutputData;
    ///Specifies the location in which the driver writes the return value of the DdMoCompBeginFrame callback. A return
    ///code of DD_OK indicates success. For more information, see Return Values for DirectDraw.
    HRESULT              ddRVal;
}

///The DD_ENDMOCOMPFRAMEDATA structure contains information required to complete a decoded frame.
struct DD_ENDMOCOMPFRAMEDATA
{
    ///Points to a DD_DIRECTDRAW_LOCAL structure that is relevant to the current DirectDraw process only.
    DD_DIRECTDRAW_LOCAL* lpDD;
    ///Points to a DD_MOTIONCOMP_LOCAL structure that contains a description of the motion compensation being requested.
    DD_MOTIONCOMP_LOCAL* lpMoComp;
    ///Points to an optional buffer, the contents of which are defined by the GUID. This buffer cannot contain any
    ///embedded pointers.
    void*                lpInputData;
    ///Indicates the size in bytes of data in <b>lpInputData</b>.
    uint                 dwInputDataSize;
    ///Specifies the location in which the driver writes the return value of the DdMoCompEndFrame callback. A return
    ///code of DD_OK indicates success. For more information, see Return Values for DirectDraw.
    HRESULT              ddRVal;
}

///The DDMOCOMPBUFFERINFO structure contains the macro block information required to render a frame and passes this
///information to the DD_RENDERMOCOMPDATA structure.
struct DDMOCOMPBUFFERINFO
{
    ///Specifies the size in bytes of this DDMOCOMPBUFFERINFO structure.
    uint              dwSize;
    ///Points to a DD_SURFACE_LOCAL structure that contains the compressed data.
    DD_SURFACE_LOCAL* lpCompSurface;
    ///Indicates the offset to the relevant data, in bytes, from the beginning of the buffer. This value does not allow
    ///for pitch.
    uint              dwDataOffset;
    ///Indicates the size of the relevant data in bytes. This value does not allow for pitch.
    uint              dwDataSize;
    ///Used by Microsoft DirectDraw and should be ignored by the driver.
    void*             lpPrivate;
}

///The DD_RENDERMOCOMPDATA structure contains the information required to render a frame.
struct DD_RENDERMOCOMPDATA
{
    ///Points to a DD_DIRECTDRAW_LOCAL structure that is relevant to the current Microsoft DirectDraw process only.
    DD_DIRECTDRAW_LOCAL* lpDD;
    ///Points to a DD_MOTIONCOMP_LOCAL structure that contains a description of the motion compensation being requested.
    DD_MOTIONCOMP_LOCAL* lpMoComp;
    ///Indicates the number of entries in the <b>lpBufferInfo</b> member.
    uint                 dwNumBuffers;
    ///Points to a DDMOCOMPBUFFERINFO structure that contains the surfaces and the locations within the surfaces from
    ///which to get the macroblock data to render.
    DDMOCOMPBUFFERINFO*  lpBufferInfo;
    ///Indicates a specific operation the decoder would like the driver to perform. The possible values for this member
    ///are defined by the GUID used during motion compensation. See DD_CREATEMOCOMPDATA for more information.
    uint                 dwFunction;
    ///Points to an optional input buffer, the contents of which are defined by the GUID. This buffer cannot contain any
    ///embedded pointers.
    void*                lpInputData;
    ///Specifies the size in bytes of the data pointed to by <b>lpInputData</b>.
    uint                 dwInputDataSize;
    ///Points to an optional output buffer, the contents of which are defined by the GUID. This buffer cannot contain
    ///any embedded pointers.
    void*                lpOutputData;
    ///Specifies the size in bytes of the data pointed to by <b>lpOutputData</b>.
    uint                 dwOutputDataSize;
    ///Specifies the location in which the driver writes the return value of the DdMoCompRender callback. A return code
    ///of DD_OK indicates success. For more information, see Return Values for DirectDraw.
    HRESULT              ddRVal;
}

///The DD_QUERYMOCOMPSTATUSDATA structure contains information required to query the status of the previous frame.
struct DD_QUERYMOCOMPSTATUSDATA
{
    ///Points to a DD_DIRECTDRAW_LOCAL structure that is relevant to the current Microsoft DirectDraw process only.
    DD_DIRECTDRAW_LOCAL* lpDD;
    ///Points to a DD_MOTIONCOMP_LOCAL structure that contains a description of the motion compensation being requested.
    DD_MOTIONCOMP_LOCAL* lpMoComp;
    ///Points to a DD_SURFACE_LOCAL structure that contains the surface being queried.
    DD_SURFACE_LOCAL*    lpSurface;
    ///Indicates the type of surface access.
    uint                 dwFlags;
    ///Specifies the location in which the driver writes the return value of the DdMoCompQueryStatus callback. A return
    ///code of DD_OK indicates the hardware has finished processing the DdMoCompRender request. Otherwise the return
    ///value must be DDERR_WASSTILLDRAWING. For more information, see Return Values for DirectDraw.
    HRESULT              ddRVal;
}

///The DD_DESTROYMOCOMPDATA structure contains the information required to finish performing motion compensation.
struct DD_DESTROYMOCOMPDATA
{
    ///Points to a DD_DIRECTDRAW_LOCAL structure that is relevant to the current Microsoft DirectDraw process only.
    DD_DIRECTDRAW_LOCAL* lpDD;
    ///Points to a DD_MOTIONCOMP_LOCAL structure that contains a description of the motion compensation being requested.
    DD_MOTIONCOMP_LOCAL* lpMoComp;
    ///Specifies the location in which the driver writes the return value of the DdMoCompDestroy callback. A return code
    ///of DD_OK indicates success. For more information, see Return Values for DirectDraw.
    HRESULT              ddRVal;
}

///The DD_CREATESURFACEEXDATA structure contains information required for the driver to create a surface and associate
///with it a supplied texture handle.
struct DD_CREATESURFACEEXDATA
{
    ///Specifies a set of flags for the <b>D3dCreateSurfaceEx</b> function that are currently not used and always zero.
    uint                 dwFlags;
    ///Specifies a handle to the DirectDraw object created by the application. This is the scope within which the
    ///<b>lpDDSLcl</b> handles exist. A DD_DIRECTDRAW_LOCAL structure describes the driver.
    DD_DIRECTDRAW_LOCAL* lpDDLcl;
    ///Specifies a handle to the DirectDraw surface to be created for Direct3D. These handles are unique within each
    ///different DD_DIRECTDRAW_LOCAL structure. A DD_SURFACE_LOCAL structure represents the created surface object.
    DD_SURFACE_LOCAL*    lpDDSLcl;
    ///Specifies the location where the driver writes the return value of the D3dCreateSurfaceEx callback. A return code
    ///of D3D_OK indicates success. For more information, see Return Codes for Direct3D Driver Callbacks.
    HRESULT              ddRVal;
}

///The DD_GETDRIVERSTATEDATA structure describes the state of the driver.
struct DD_GETDRIVERSTATEDATA
{
    ///Specifies the set of flags to indicate the data requested. This parameter can be set to one of the following
    ///flags: <table> <tr> <th>Flag</th> <th>Meaning</th> </tr> <tr> <td> D3DDEVINFOID_D3DTEXTUREMANAGER </td> <td>
    ///Requests texture-management information performed by the Direct3D runtime in a D3DDEVINFO_TEXTUREMANAGER
    ///structure. </td> </tr> <tr> <td> D3DDEVINFOID_TEXTUREMANAGER </td> <td> Requests texture-management information
    ///performed by either the driver or the Direct3D runtime in a D3DDEVINFO_TEXTUREMANAGER structure. </td> </tr> <tr>
    ///<td> D3DDEVINFOID_TEXTURING </td> <td> Requests texture-activity information of the application in a
    ///D3DDEVINFO_TEXTURING structure. </td> </tr> <tr> <td> D3DDEVINFOID_VCACHE </td> <td> <dl> <dt>DirectX 8.1
    ///versions only</dt> <dt>Requests vertex-cache information in a D3DDEVINFO_VCACHE structure.</dt> </dl> </td> </tr>
    ///</table>
    uint    dwFlags;
    union
    {
        DD_DIRECTDRAW_GLOBAL* lpDD;
        size_t dwhContext;
    }
    ///Points to the Direct3D driver state data to be filled in by the driver. If, for example, D3DDEVINFOID_VCACHE is
    ///specified in the <b>dwFlags</b> member, the driver points the <b>lpdwStates</b> member to a D3DDEVINFO_VCACHE
    ///structure that contains vertex-cache information.
    uint*   lpdwStates;
    ///Specifies the length, in bytes, of the state data to be filled in by the driver.
    uint    dwLength;
    ///Specifies the location where the driver writes the return value of the D3dGetDriverState callback. A return code
    ///of D3D_OK indicates success. For more information, see Return Codes for Direct3D Driver Callbacks.
    HRESULT ddRVal;
}

///The FD_XFORM structure describes an arbitrary two-dimensional font transform.
struct FD_XFORM
{
    uint eXX;
    uint eXY;
    uint eYX;
    ///Are the four elements that comprise a 2x2 row-major matrix. <b>eXX</b> and <b>eXY</b> are the elements in the
    ///first row; <b>eYX</b> and <b>eYY</b> are the elements in the second row.
    uint eYY;
}

///The FD_DEVICEMETRICS structure is used to provide device-specific font information to GDI if the <i>iMode</i>
///parameter of the driver-supplied DrvQueryFontData function is QFD_MAXEXTENTS.
struct FD_DEVICEMETRICS
{
    ///Is a set of accelerator flags. This value can be a combination of the following values:
    uint     flRealizedType;
    ///Specifies a POINTE structure that contains the notional space unit vector along the font's baseline, transformed
    ///to device space and then normalized. For more information, see POINTE in GDI Data Types.
    POINTE   pteBase;
    ///Specifies POINTE structure that contains a notional space unit vector perpendicular to the font's baseline in the
    ///direction of the ascender, transformed to device space and then normalized. In notional space, baseline and
    ///ascender directions must be orthogonal, but in device space, <b>pteBase</b> and <b>pteSide</b> do not have to be
    ///orthogonal, depending on the Notional to Device space transform.
    POINTE   pteSide;
    ///Specifies the advance width if the font is a fixed pitch (monospaced) font. If the font is a variable pitch font,
    ///this member should be set to zero.
    int      lD;
    ///Specifies the hinted maximum ascender height for this font instance, measured along <b>pteSide</b>. See the FIX
    ///data type in GDI Data Types.
    int      fxMaxAscender;
    ///Specifies the hinted maximum descender height for this font instance, measured along <b>pteSide</b>. See the FIX
    ///data type in GDI Data Types.
    int      fxMaxDescender;
    ///Specifies a POINTL structure that contains the hinted underline position for this font instance, relative to the
    ///glyph's character origin.
    POINTL   ptlUnderline1;
    ///Specifies a POINTL structure that contains the hinted strikeout position for this font instance, relative to the
    ///glyph's character origin.
    POINTL   ptlStrikeOut;
    ///Specifies a POINTL structure that contains the hinted underline thickness for this font instance. This vector
    ///defines the side of the rectangle used to draw the underline. The base is implicitly defined by the baseline.
    POINTL   ptlULThickness;
    ///Specifies a POINTL structure that contains the hinted strikeout thickness for this font instance. This vector
    ///defines the side of the rectangle used to draw the strikeout. The base is implicitly defined by the baseline.
    POINTL   ptlSOThickness;
    ///Specifies the hinted maximum glyph bitmap width, in pixels, for this font instance. Not used for outlines.
    uint     cxMax;
    ///Specifies the hinted maximum glyph bitmap height, in pixels, for this font instance. Not used for outlines.
    uint     cyMax;
    ///Specifies the hinted maximum size of a glyph, in bytes, for this font instance. This value is the maximum size of
    ///the GLYPHBITS structure needed to store any of the font's glyphs.
    uint     cjGlyphMax;
    ///Specifies an FD_XFORM structure. The font driver fills in the font transformation that is actually used in the
    ///realization of the font. This may differ from the transformation requested by GDI as defined by
    ///FONTOBJ_pxoGetXform.
    FD_XFORM fdxQuantized;
    ///Is the nonlinear external leading in 28.4 device units.
    int      lNonLinearExtLeading;
    ///Is the nonlinear internal leading in 28.4 device units.
    int      lNonLinearIntLeading;
    ///Is the nonlinear maximum character increment in 28.4 device units.
    int      lNonLinearMaxCharWidth;
    ///Is the nonlinear average character width in 28.4 device units.
    int      lNonLinearAvgCharWidth;
    ///Is the largest negative A space for this font realization, specified as an absolute value.
    int      lMinA;
    ///Is the largest negative C space for this font realization, specified as an absolute value.
    int      lMinC;
    ///Is the smallest nonzero character width for this font realization.
    int      lMinD;
    ///Is reserved and should be ignored by the font provider.
    int[1]   alReserved;
}

///The WCRUN structure describes a run of Unicode characters.
struct WCRUN
{
    ///Specifies the first character in the run.
    ushort wcLow;
    ///Specifies the count of characters in the run.
    ushort cGlyphs;
    ///Pointer to an array of glyph handles that correspond to this run. If this member is <b>NULL</b>, then each
    ///character in this run can be converted to a glyph handle by a cast, as in the following example: ``` HGLYPH hg =
    ///(HGLYPH) wc; ```
    uint*  phg;
}

///The FD_GLYPHSET structure is used to define the mappings from Unicode characters to glyph handles.
struct FD_GLYPHSET
{
    ///Specifies the size, in bytes, of the structure, including the array of WCRUN structures.
    uint     cjThis;
    ///Specifies accelerator flags. This member must be the following value: <table> <tr> <th>Flags</th>
    ///<th>Meaning</th> </tr> <tr> <td> GS_8BIT_HANDLES </td> <td> All handles are 8-bit quantities. </td> </tr> <tr>
    ///<td> GS_16BIT_HANDLES </td> <td> All handles are 16-bit quantities. </td> </tr> <tr> <td> GS_UNICODE_HANDLES
    ///</td> <td> For all runs in this structure, the handle is obtained by zero extending the Unicode code point. </td>
    ///</tr> </table>
    uint     flAccel;
    ///Specifies the total number of glyphs in all runs.
    uint     cGlyphsSupported;
    ///Specifies the number of WCRUN structures in the <b>awcrun</b> array.
    uint     cRuns;
    ///Is an array of WCRUN structures.
    WCRUN[1] awcrun;
}

///The FD_GLYPHATTR structure is used to specify the return value for the FONTOBJ_pQueryGlyphAttrs and
///DrvQueryGlyphAttrs functions.
struct FD_GLYPHATTR
{
    ///Is the size in bytes of the FD_GLYPHATTR structure, including the array specified by the <b>aGlyphAttr</b>
    ///member.
    uint     cjThis;
    ///Specifies the number of glyphs in the font.
    uint     cGlyphs;
    ///Is a flag indicating the type of information being returned. The following flag is defined: <table> <tr>
    ///<th>Flag</th> <th>Definition</th> </tr> <tr> <td> FO_ATTR_MODE_ROTATE </td> <td> The array specified by
    ///<b>aGlyphAttr</b> is a bit array indicating which glyphs of a vertical font must be rotated. The bit array's
    ///length is (<b>cGlyphs</b>+7)/8. If a glyph's bit is set, the glyph should be rotated during rasterization. </td>
    ///</tr> </table>
    uint     iMode;
    ///Is an array supplying the information specified by <b>iMode</b>. The size of this array is (<b>cGlyphs</b>+7) / 8
    ///bytes.
    ubyte[1] aGlyphAttr;
}

///The FD_KERNINGPAIR structure is used to store information about kerning pairs.
struct FD_KERNINGPAIR
{
    ///Specifies the code point of the first character in the kerning pair.
    ushort wcFirst;
    ///Specifies the code point of the second character in the kerning pair.
    ushort wcSecond;
    ///Specifies the kerning value, in font (notional) units, for the kerning pair. If this value is greater than zero,
    ///the characters will be moved apart; otherwise, the characters will be moved together. For information about the
    ///FWORD data type, see GDI Data Types.
    short  fwdKern;
}

///The FONTDIFF structure describes all of the characteristics that are different between a base font and one of its
///simulations.
struct FONTDIFF
{
    ubyte  jReserved1;
    ubyte  jReserved2;
    ///Are reserved for system use.
    ubyte  jReserved3;
    ///Specifies the Panose weight.
    ubyte  bWeight;
    ///Specifies the weight of the font in the range 0 to 1000 (for example, 400 is normal and 700 is bold). This value
    ///is provided to the application in the <b>lfWeight</b> member of the Win32 LOGFONT structure.
    ushort usWinWeight;
    ///Specifies a combination of the following flags: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td>
    ///FM_SEL_BOLD </td> <td> Set if the characters of the font are bold. </td> </tr> <tr> <td> FM_SEL_ITALIC </td> <td>
    ///Set if the characters of the font are italic. </td> </tr> <tr> <td> FM_SEL_NEGATIVE </td> <td> Set if the
    ///characters of the font have the foreground and background reversed. </td> </tr> <tr> <td> FM_SEL_OUTLINED </td>
    ///<td> Set if the characters of the font are hollow. </td> </tr> <tr> <td> FM_SEL_REGULAR </td> <td> Set if the
    ///characters of the font are normal weight. </td> </tr> <tr> <td> FM_SEL_STRIKEOUT </td> <td> Set if the characters
    ///of the font are struck out by default; otherwise strikeouts must be simulated. </td> </tr> <tr> <td>
    ///FM_SEL_UNDERSCORE </td> <td> Set if all the characters of the font are underscored by default; otherwise
    ///underscoring must be simulated. </td> </tr> </table>
    ushort fsSelection;
    ///Specifies the arithmetic average of the width of all of the 26 lower case letters 'a' through 'z' of the Latin
    ///alphabet and the space character. If any of the 26 lowercase letters are not present, then this member should be
    ///set equal to the weighted average of all glyphs in the font.
    short  fwdAveCharWidth;
    ///Specifies the maximum character increment of all glyphs in the font.
    short  fwdMaxCharInc;
    ///Specifies a POINTL structure that indicates the direction of the ascender direction of the font. For example, the
    ///value for a nonitalicized Latin font is (0,1) while an italicized Latin font might specify a value of (2,5).
    POINTL ptlCaret;
}

///The FONTSIM structure contains offsets to one or more FONTDIFF structures describing bold, italic, and bold italic
///font simulations.
struct FONTSIM
{
    ///If nonzero, specifies the offset from the beginning of this structure to the FONTDIFF structure describing the
    ///bold simulation. If this member is zero, the font does not support bold simulation.
    int dpBold;
    ///If nonzero, specifies the offset from the beginning of this structure to the FONTDIFF structure describing the
    ///italic simulation. If this member is zero, the font does not support italic simulation.
    int dpItalic;
    ///If nonzero, specifies the offset from the beginning of this structure to the FONTDIFF structure describing the
    ///bold italic simulation. If this member is zero, the font does not support bold italic simulation.
    int dpBoldItalic;
}

///The IFIMETRICS structure defines information for a given typeface that GDI can use.
struct IFIMETRICS
{
    ///Specifies the size in bytes of this structure. The specified size includes any Unicode strings appended to the
    ///end of this structure, plus the size in bytes of the optional IFIEXTRA structure.
    uint     cjThis;
    ///Specifies the size in bytes of the IFIEXTRA structure that follows this IFIMETRICS structure. A value of zero
    ///indicates that no IFIEXTRA structure is present.
    uint     cjIfiExtra;
    ///Specifies the offset in bytes to a null-terminated Unicode string containing the family name of the font (for
    ///example, "Times Roman"). Generally, this string immediately follows the IFIMETRICS structure. This string should
    ///be the same as the name recorded in the <b>lfFaceName</b> member of the Win32 LOGFONT structure.
    int      dpwszFamilyName;
    ///Specifies the offset in bytes to a null-terminated Unicode string describing the style of the font (for example,
    ///"Bold").
    int      dpwszStyleName;
    ///Specifies the offset in bytes to a null-terminated Unicode string representing the unique and complete name of
    ///the font. The name contains the family and subfamily names of the font (for example, "Times New Roman Bold").
    int      dpwszFaceName;
    ///Specifies the offset in bytes to a null-terminated Unicode string representing the unique identifier of the font
    ///(for example, "Monotype:Times New Roman:1990").
    int      dpwszUniqueName;
    ///Specifies the offset in bytes from the beginning of this IFIMETRICS structure to a FONTSIM structure that
    ///describes the simulations that the font supports. The driver should set this member to a nonzero value only if
    ///the font supports bold, italic, or bold italic simulations; otherwise, the driver should set this to zero. Note
    ///that if a font is italic by design, the driver should not indicate font support for italic simulation although it
    ///can indicate font support for bold italic simulation. Similarly, the driver should not indicate font support for
    ///bold simulation if the font is bold by design, but can indicate font support for bold italic simulation. If the
    ///font is both bold and italic by design, it should not support any simulations. The offsets in the FONTSIM
    ///structure are relative to the base of the FONTSIM structure.
    int      dpFontSim;
    ///Specifies the Embedding ID of the font. This value is TrueType-specific and should be set to zero by all other
    ///font providers.
    int      lEmbedId;
    ///Specifies the italic angle of the font. This value is TrueType-specific and should be set to zero by all other
    ///font providers.
    int      lItalicAngle;
    ///Specifies the character bias. This value is TrueType-specific and should be set to zero by all other font
    ///providers.
    int      lCharBias;
    ///Specifies the offset from the beginning of this IFIMETRICS structure to an array containing a list of all Windows
    ///character sets supported by this font. The array is 16 bytes in size and is always terminated with
    ///DEFAULT_CHARSET. The first value of the array should identify the Windows character set that has the best and
    ///most complete coverage in the font; this value should also be stored in <b>jWinCharSet</b>. For instance, if this
    ///is a Japanese font that also supports US ANSI and Cyrillic character sets, then <b>jWinCharSet</b> should be set
    ///to SHIFTJIS_CHARSET and the array identified by <b>dpCharSets</b> would contain SHIFTJIS_CHARSET, ANSI_CHARSET,
    ///RUSSIAN_CHARSET, DEFAULT_CHARSET. If this font does not support more than one Windows character set,
    ///<b>dpCharSets</b> should be set to zero.
    int      dpCharSets;
    ///Identifies the character set best supported by this font. If the font supports only a single Windows character
    ///set, the driver should store the corresponding value in <b>jWinCharSet</b>. The driver should not store
    ///DEFAULT_CHARSET in this field. This member can be one of the following values: <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td> ANSI_CHARSET </td> <td> This font supports the Windows ANSI character set. </td>
    ///</tr> <tr> <td> ARABIC_CHARSET </td> <td> This font supports the Arabic character set. </td> </tr> <tr> <td>
    ///BALTIC_CHARSET </td> <td> This font supports the Baltic character set. </td> </tr> <tr> <td> CHINESEBIG5_CHARSET
    ///</td> <td> This font supports the traditional Chinese (Big 5) character set. </td> </tr> <tr> <td>
    ///EASTEUROPE_CHARSET </td> <td> This font supports the Eastern European character set. </td> </tr> <tr> <td>
    ///GB2312_CHARSET </td> <td> This font supports the simplified (PRC) Chinese character set. </td> </tr> <tr> <td>
    ///GREEK_CHARSET </td> <td> This font supports the Greek character set. </td> </tr> <tr> <td> HANGEUL_CHARSET </td>
    ///<td> This font supports the Korean (Hangeul) character set. </td> </tr> <tr> <td> HEBREW_CHARSET </td> <td> This
    ///font supports the Hebrew character set. </td> </tr> <tr> <td> JOHAB_CHARSET </td> <td> This font supports the
    ///Korean (Johab) character set. </td> </tr> <tr> <td> OEM_CHARSET </td> <td> This font supports an OEM-specific
    ///character set. The OEM character set is system dependent. </td> </tr> <tr> <td> SHIFTJIS_CHARSET </td> <td> This
    ///font supports the Shift-JIS (Japanese Industry Standard) character set. </td> </tr> <tr> <td> SYMBOL_CHARSET
    ///</td> <td> This font supports the Windows symbol character set. </td> </tr> <tr> <td> RUSSIAN_CHARSET </td> <td>
    ///This font supports the Cyrillic character set. </td> </tr> <tr> <td> THAI_CHARSET </td> <td> This font supports
    ///the Thai character set. </td> </tr> <tr> <td> TURKISH_CHARSET </td> <td> This font supports the Turkish character
    ///set. </td> </tr> <tr> <td> VIETNAMESE_CHARSET </td> <td> This font supports the Vietnamese character set. </td>
    ///</tr> </table>
    ubyte    jWinCharSet;
    ///Specifies the pitch of the font. The two low-order bits specify the pitch of the font and can be one of the
    ///following values: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td> FIXED_PITCH </td> <td> For fixed
    ///pitch fonts </td> </tr> <tr> <td> VARIABLE_PITCH </td> <td> For variable pitch fonts </td> </tr> </table> Bits 4
    ///through 7 of this member specify the font family and can be one of the following values: <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td> FF_DECORATIVE </td> <td> Novelty fonts, such as Old English.
    ///</td> </tr> <tr> <td> FF_DONTCARE </td> <td> Don't care or unknown. </td> </tr> <tr> <td> FF_MODERN </td> <td>
    ///Fonts with constant stroke width (fixed-pitch), with or without serifs. Fixed-pitch fonts are usually modern,
    ///such as Pica, Elite, and Courier. </td> </tr> <tr> <td> FF_ROMAN </td> <td> Fonts with variable stroke width
    ///(proportionally spaced) and with serifs, such as Times Roman, Palatino, and Century Schoolbook. </td> </tr> <tr>
    ///<td> FF_SCRIPT </td> <td> Fonts designed to look like handwriting, such as Script and Cursive. </td> </tr> <tr>
    ///<td> FF_SWISS </td> <td> Fonts with variable stroke width (proportionally spaced) and without serifs, such as
    ///Helvetica and Swiss. </td> </tr> </table>
    ubyte    jWinPitchAndFamily;
    ///Specifies the weight of the font in the range 0 to 1000 (for example, 400 is normal and 700 is bold). This value
    ///is provided to the application in the <b>lfWeight</b> member of the Win32 LOGFONT structure.
    ushort   usWinWeight;
    ///Specifies additional information about the font. This field can be a combination of the following flag values:
    uint     flInfo;
    ///Specifies a combination of the following flags: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td>
    ///FM_SEL_BOLD </td> <td> Set if the characters of the font are bold. </td> </tr> <tr> <td> FM_SEL_ITALIC </td> <td>
    ///Set if the characters of the font are italic. </td> </tr> <tr> <td> FM_SEL_NEGATIVE </td> <td> Set if the
    ///characters of the font have the foreground and background reversed. </td> </tr> <tr> <td> FM_SEL_OUTLINED </td>
    ///<td> Set if the characters of the font are hollow. </td> </tr> <tr> <td> FM_SEL_REGULAR </td> <td> Set if the
    ///characters of the font are normal weight. </td> </tr> <tr> <td> FM_SEL_STRIKEOUT </td> <td> Set if the characters
    ///of the font are struck out by default; otherwise strikeouts must be simulated. </td> </tr> <tr> <td>
    ///FM_SEL_UNDERSCORE </td> <td> Set if all the characters of the font are underscored by default; otherwise
    ///underscoring must be simulated. </td> </tr> </table>
    ushort   fsSelection;
    ///This is a TrueType-specific bitfield indicating certain properties for the font, such as font embedding and
    ///licensing rights for the font. Embeddable fonts can be stored in a document. When a document with embedded fonts
    ///is opened on a system that does not have the font installed (the remote system), the embedded font can be loaded
    ///for temporary (and in some cases permanent) use on that system by an embedding-aware application. Embedding
    ///licensing rights are granted by the font vendor. The following flags can be set: <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td> FM_EDITABLE_EMBED </td> <td> Set if the font can be embedded and temporarily
    ///loaded on other systems. Documents containing Editable fonts can be opened for reading and writing. </td> </tr>
    ///<tr> <td> FM_READONLY_EMBED </td> <td> Set if read/write embedding is not permitted; only "preview and print"
    ///encapsulation is allowed. When this bit is set, the font can be embedded and temporarily loaded on the remote
    ///system. Documents containing "preview and print" fonts must be opened "read-only;" no edits can be applied to the
    ///document. </td> </tr> <tr> <td> <dl> <dt>FM_TYPE_LICENSED</dt> <dt>FM_NO_EMBEDDING</dt> </dl> </td> <td> Set if
    ///the font is a Restricted License font. When only this bit is set, this font <i>must not be modified, embedded, or
    ///exchanged in any manner</i> without first obtaining permission of the legal owner. For Restricted License
    ///embedding to take effect, it must be the only level of embedding selected. </td> </tr> </table> Fonts with the
    ///FM_READONLY_EMBED bit set indicate that they can be embedded within documents but must only be installed
    ///<i>temporarily</i> on the remote system. Any document that includes an FM_READONLY_EMBED font must be opened
    ///"read-only." That is, the application can let the user view and/or print the document, but not edit it. Fonts
    ///with the FM_EDITABLE_EMBED bit set indicate that they can be embedded in documents, but must only be installed
    ///<i>temporarily</i> on the remote system. In contrast to FM_READONLY_EMBED fonts, documents containing Editable
    ///fonts can be opened "read/write;" editing is permitted, and changes can be saved. Fonts with no <b>fsType</b>
    ///bits set indicate that they can be embedded and permanently installed on the remote system by an application. The
    ///user of the remote system acquires the identical rights, obligations, and licenses for that font as the original
    ///purchaser of the font, and is subject to the same end-user license agreement, copyright, design patent, and/or
    ///trademark as was the original purchaser. Applications that implement support for font embedding, either through
    ///use of the Font Embedding DLL or through other means, must not embed fonts that are not licensed to permit
    ///embedding. Further, applications loading embedded fonts for temporary use <i>must</i> delete the fonts when the
    ///document containing the embedded font is closed. If multiple embedding bits are set, the <i>least</i> restrictive
    ///license granted takes precedence. For example, if bits 1 and 3 are set, bit 3 takes precedence over bit 1and the
    ///font can be embedded with Editable rights. For compatibility purposes, most vendors granting Editable embedding
    ///rights also set the Preview &amp; Print bit (0x000C). This permits an application that only supports Preview
    ///&amp; Print embedding to detect that font embedding is allowed.
    ushort   fsType;
    ///Specifies the em-height of the font.
    short    fwdUnitsPerEm;
    ///Specifies the smallest readable size of the font, in pixels. This value is ignored for bitmap fonts.
    short    fwdLowestPPEm;
    ///Specifies the Windows ascender value for the font.
    short    fwdWinAscender;
    ///Specifies the Windows descender value for the font.
    short    fwdWinDescender;
    ///Specifies the Macintosh ascender value for the font.
    short    fwdMacAscender;
    ///Specifies the Macintosh descender value for the font. This number is typically less than zero. It measures the
    ///signed displacement from the base line of the lowest descender in the Macintosh character set.
    short    fwdMacDescender;
    ///Specifies the Macintosh line gap for the font. The suggested Macintosh interline spacing is equal to
    ///<b>fwdMacLineGap</b> + <b>fwdMacAscender</b> âˆ’ <b>fwdMacDescender</b>.
    short    fwdMacLineGap;
    ///Specifies the typographic ascender value for the font.
    short    fwdTypoAscender;
    ///Specifies the typographic descender value for the font. This value specifies the signed displacement of the
    ///lowest descender from the baseline.
    short    fwdTypoDescender;
    ///Specifies the typographic line gap for the font.
    short    fwdTypoLineGap;
    ///Specifies the arithmetic average of the width of all of the 26 lower case letters 'a' through 'z' of the Latin
    ///alphabet and the space character. If any of the 26 lowercase letters are not present, then this member should be
    ///set equal to the weighted average of all glyphs in the font.
    short    fwdAveCharWidth;
    ///Specifies the maximum character increment of all glyphs in the font.
    short    fwdMaxCharInc;
    ///Specifies the height of the optical line describing the top of the uppercase 'H' in font units (FUnits). This
    ///might not be the same as the measured height of the uppercase 'H.' If this information does not exist,
    ///<b>fwdCapHeight</b> should be set to zero, which indicates that it is undefined.
    short    fwdCapHeight;
    ///Specifies the height of the optical line describing the height of the lowercase 'x' in font units. This might not
    ///be the same as the measured height of the lowercase 'x.' A value of zero indicates that this member is undefined.
    short    fwdXHeight;
    ///Specifies the suggested character width (the size along the baseline direction) of the subscript font.
    short    fwdSubscriptXSize;
    ///Specifies the suggested character height (the size along the ascender direction) of the subscript font.
    short    fwdSubscriptYSize;
    ///Specifies the suggested offset in the baseline direction of the subscript character. The offset is with respect
    ///to the character origin of the base character.
    short    fwdSubscriptXOffset;
    ///Specifies the suggested offset in the baseline direction of the subscript character. The offset is taken from the
    ///character origin of the base character.
    short    fwdSubscriptYOffset;
    ///Specifies the suggested character width (the size along the baseline direction) of the superscript font.
    short    fwdSuperscriptXSize;
    ///Specifies the suggested character height (the size along the ascender direction) of the superscript font.
    short    fwdSuperscriptYSize;
    ///Specifies the suggested offset in the baseline direction of the superscript character. The offset is taken from
    ///the character origin of the base character.
    short    fwdSuperscriptXOffset;
    ///Specifies the suggested offset in the baseline direction of the superscript character. The offset is taken from
    ///the character origin of the base character.
    short    fwdSuperscriptYOffset;
    ///Specifies the suggested width of the underscore bar, in font units.
    short    fwdUnderscoreSize;
    ///Specifies the suggested displacement, in font units, from the base line to the middle of the underscore bar.
    short    fwdUnderscorePosition;
    ///Specifies the suggested width of the strike-out bar, in font coordinates.
    short    fwdStrikeoutSize;
    ///Specifies the suggested displacement of the middle of the strikeout bar from the baseline.
    short    fwdStrikeoutPosition;
    ///Specifies the lowest supported character in the code page specified in <b>jWinCharSet</b>. This field is provided
    ///for Windows 3.1 compatibility.
    ubyte    chFirstChar;
    ///Specifies the highest supported character in the code page specified in <b>jWinCharSet</b>. This field is
    ///provided for Windows 3.1 compatibility.
    ubyte    chLastChar;
    ///Specifies the default character in the code page specified in <b>jWinCharSet</b>. This field is provided for
    ///Windows 3.1 compatibility.
    ubyte    chDefaultChar;
    ///Specifies the break character in the code page specified in <b>jWinCharSet</b>. This field is provided for
    ///Windows 3.1 compatibility.
    ubyte    chBreakChar;
    ///Specifies the supported character with the smallest Unicode character code.
    ushort   wcFirstChar;
    ///Specifies the supported character with the largest Unicode character code.
    ushort   wcLastChar;
    ///Specifies the character to be substituted when an application requests a character that is not supported by the
    ///font.
    ushort   wcDefaultChar;
    ///Specifies the code point of the space character or its equivalent.
    ushort   wcBreakChar;
    ///Specifies a POINTL structure that contains the intended writing direction of this font. For example, a typical
    ///Latin font specifies a value of (1,0).
    POINTL   ptlBaseline;
    ///Specifies a POINTL structure that contains the aspect ratio of the pixel centers for which the bitmap font was
    ///designed. This value is used only by bitmap fonts.
    POINTL   ptlAspect;
    ///Specifies a POINTL structure that contains the direction of the ascender direction of the font. For example, the
    ///value for a nonitalicized Latin font is (0,1) while an italicized Latin font might specify a value of (2,5).
    POINTL   ptlCaret;
    ///Specifies a RECTL structure that describes the bounding box of all glyphs in the font in design space.
    RECTL    rclFontBox;
    ///Specifies a four character identifier for the font vendor. Identifiers are documented in the Microsoft TrueType
    ///specification.
    ubyte[4] achVendId;
    ///Specifies the number of kerning pairs associated with this font.
    uint     cKerningPairs;
    ///Specifies the manner in which to interpret the panose number. This number should be set to
    ///FM_PANOSE_CULTURE_LATIN for Latin-based fonts. See the Microsoft Window SDK documentation for information about
    ///the PANOSE structure.
    uint     ulPanoseCulture;
    ///Is an array of 10 bytes used to describe the visual characteristics of a given typeface. These characteristics
    ///are then used to associate the font with other fonts of similar appearance having different names. See the Window
    ///SDK documentation for information about the PANOSE structure.
    PANOSE   panose;
}

///The IFIEXTRA structure defines additional information for a given typeface that GDI can use.
struct IFIEXTRA
{
    ///Should be set to zero. This member was used by GDI to identify Type1 fonts on Windows NT 4.0.
    uint    ulIdentifier;
    ///Specifies the offset in bytes from the beginning of the IFIMETRICS structure to the FONTSIGNATURE structure
    ///(described in the Microsoft Window SDK documentation). The driver should set this member to zero if it does not
    ///support multiple character sets. The character set information in FONTSIGNATURE should be consistent with the
    ///information provided in the character sets array to which the <b>dpCharSets</b> member of IFIMETRICS points.
    int     dpFontSig;
    ///Specifies the number of distinct glyphs in a font that supports glyph indices. The font's glyph handles are
    ///contiguous values that range from 0 to (<b>cig</b>-1). For OpenType fonts, this value is stored in the
    ///<i>numGlyphs</i> value of the <i>maxp</i> table. Fonts that do not have contiguous glyph handles should set this
    ///member to zero. Note that the Window SDK glyph index APIs will not work for fonts that set this member to zero.
    uint    cig;
    ///Is the offset from the beginning of the IFIMETRICS structure to the DESIGNVECTOR structure for this font. The
    ///driver should set <b>dpDesignVector</b> only if this font is a multiple master font. The DESIGNVECTOR structure
    ///is described in the Window SDK documentation.
    int     dpDesignVector;
    ///Is the offset from the beginning of the IFIMETRICS structure to the AXESINFOW structure for this font. The driver
    ///should set <b>dpAxesInfoW</b> only if this font is a multiple master font. The AXESINFOW structure is described
    ///in the Window SDK documentation.
    int     dpAxesInfoW;
    ///Is reserved and should be ignored by the driver.
    uint[1] aulReserved;
}

///The DRVFN structure is used by graphics drivers to provide GDI with pointers to the graphics DDI functions defined by
///the driver.
struct DRVFN
{
    ///Is the function index that identifies a graphics DDI function implemented by the driver. The index name reflects
    ///the name of the related graphics DDI function; for example, an index value of INDEX_DrvEnablePDEV specifies the
    ///DrvEnablePDEV function. See the header file, <i>winddi.h</i>, for a complete list of index values.
    uint iFunc;
    ///Specifies the address of the driver-defined graphics DDI function associated with the index supplied for
    ///<b>iFunc</b>. This function has the following prototype: ``` LONG_PTR (APIENTRY * PFN) (); ```
    PFN  pfn;
}

///The DRVENABLEDATA structure contains a pointer to an array of DRVFN structures and the graphics DDI version number of
///an NT-based operating system.
struct DRVENABLEDATA
{
    ///Specifies the graphics DDI version number of the NT-based operating system that the driver is targeted for. This
    ///member can be set to one of the following values: <table> <tr> <th>Value</th> <th>Operating System Version</th>
    ///</tr> <tr> <td> DDI_DRIVER_VERSION_NT4 </td> <td> Windows NT 4.0 </td> </tr> <tr> <td> DDI_DRIVER_VERSION_SP3
    ///</td> <td> Windows NT 4.0 Service Pack 3 </td> </tr> <tr> <td> DDI_DRIVER_VERSION_NT5 </td> <td> Windows 2000
    ///</td> </tr> <tr> <td> DDI_DRIVER_VERSION_NT5_01 </td> <td> Windows XP </td> </tr> <tr> <td>
    ///DDI_DRIVER_VERSION_NT5_01_SP1 </td> <td> Windows XP Service Pack 1 </td> </tr> </table> See the Remarks section
    ///for more information.
    uint   iDriverVersion;
    ///Specifies the number of DRVFN structures in the buffer pointed to by the <b>pdrvfn</b> member.
    uint   c;
    ///Pointer to a buffer containing an array of DRVFN structures.
    DRVFN* pdrvfn;
}

///The DEVINFO structure provides information about the driver and its private PDEV to the graphics engine.
struct DEVINFO
{
    ///Is a set of flags that describe graphics capabilities of the graphics driver and/or its hardware. These flags are
    ///defined in the following table. <table> <tr> <th>Flag</th> <th>Definition</th> </tr> <tr> <td>
    ///GCAPS_ALTERNATEFILL </td> <td> Handles alternating fills. </td> </tr> <tr> <td> GCAPS_ARBRUSHOPAQUE </td> <td>
    ///Supports an arbitrary brush for text opaque rectangle (background color). </td> </tr> <tr> <td> GCAPS_ARBRUSHTEXT
    ///</td> <td> Supports an arbitrary brush for the text foreground color. </td> </tr> <tr> <td> GCAPS_ASYNCCHANGE
    ///</td> <td> This flag is obsolete. In legacy drivers, this flag indicates that the driver can change the pointer
    ///shape in hardware while other drawing is occurring on the device. </td> </tr> <tr> <td> GCAPS_ASYNCMOVE </td>
    ///<td> The driver can move the pointer in hardware while other drawing is occurring on the device. </td> </tr> <tr>
    ///<td> GCAPS_BEZIERS </td> <td> Handles Bezier curves. </td> </tr> <tr> <td> GCAPS_CMYKCOLOR </td> <td> The driver
    ///supports the CYMK color space. </td> </tr> <tr> <td> GCAPS_COLOR_DITHER </td> <td> Handles color dithering to a
    ///PDEV-compatible surface. </td> </tr> <tr> <td> GCAPS_DIRECTDRAW </td> <td> This flag is obsolete. </td> </tr>
    ///<tr> <td> GCAPS_DITHERONREALIZE </td> <td> Specifies that GDI can call DrvRealizeBrush with the RGB to be
    ///dithered directly. </td> </tr> <tr> <td> GCAPS_DONTJOURNAL </td> <td> Disallows metafile printing to this printer
    ///driver. This is valid only for printer DCs and will generally result in slower return-to-application time when
    ///printing. </td> </tr> <tr> <td> GCAPS_FONT_RASTERIZER </td> <td> Device hardware can rasterize TrueType fonts.
    ///</td> </tr> <tr> <td> GCAPS_FORCEDITHER </td> <td> Allows dithering on all geometric pens. </td> </tr> <tr> <td>
    ///GCAPS_GEOMETRICWIDE </td> <td> Handles geometric widening. </td> </tr> <tr> <td> GCAPS_GRAY16 </td> <td> Handles
    ///antialiased text natively. </td> </tr> <tr> <td> GCAPS_HALFTONE </td> <td> Handles halftoning. </td> </tr> <tr>
    ///<td> GCAPS_HIGHRESTEXT </td> <td> This flag is obsolete. In legacy drivers, this flag indicates that the driver
    ///is requesting glyph positions as returned by the STROBJ in FIX point coordinates. </td> </tr> <tr> <td>
    ///GCAPS_HORIZSTRIKE </td> <td> This flag is obsolete. In legacy drivers, this flag indicates that the driver
    ///handles horizontal strikeouts in DrvTextOut. </td> </tr> <tr> <td> GCAPS_ICM </td> <td> Indicates that color
    ///management operations can be performed by the driver or printer hardware. </td> </tr> <tr> <td> GCAPS_LAYERED
    ///</td> <td> Indicates that this is a layer or mirror driver for remoting. Printer drivers cannot be layer drivers.
    ///</td> </tr> <tr> <td> GCAPS_MONO_DITHER </td> <td> Handles monochrome dithering. </td> </tr> <tr> <td>
    ///GCAPS_NO64BITMEMACCESS </td> <td> This flag is obsolete. </td> </tr> <tr> <td> GCAPS_NUP </td> <td> Indicates
    ///that "N-up" printing is supported. </td> </tr> <tr> <td> GCAPS_OPAQUERECT </td> <td> Handles opaque rectangles in
    ///DrvTextOut. </td> </tr> <tr> <td> GCAPS_PALMANAGED </td> <td> Supports palette management. </td> </tr> <tr> <td>
    ///GCAPS_PANNING </td> <td> When GDI is simulating the pointer, it should call DrvMovePointer to notify the driver
    ///of the current cursor position. This allows the driver to handle panning virtual displays. </td> </tr> <tr> <td>
    ///GCAPS_SCREENPRECISION </td> <td> The rasterizer (font engine) should choose a screen (soft) font over a device
    ///font when choosing a font for which there is no exact match. </td> </tr> <tr> <td> GCAPS_VECTORFONT </td> <td>
    ///Handles stroking of vector fonts in DrvTextOut. </td> </tr> <tr> <td> GCAPS_VERTSTRIKE </td> <td> This flag is
    ///obsolete. In legacy drivers, this flag indicated that the driver handled vertical strikeouts in DrvTextOut. </td>
    ///</tr> <tr> <td> GCAPS_WINDINGFILL </td> <td> Handles winding mode fills. See Path Fill Modes for more
    ///information. </td> </tr> <tr> <td> GCAPS2_REMOTEDRIVER </td> <td> Indicates that the display driver is used to
    ///support a remote user sesssion. </td> </tr> </table>
    uint     flGraphicsCaps;
    ///Is an Extended Logical Font structure that specifies the default font for a device. For more information about
    ///this structure, see EXTLOGFONT in the Microsoft Windows SDK documentation.
    LOGFONTW lfDefaultFont;
    ///Is an Extended Logical Font structure that specifies the default variable-pitch font for a device. For more
    ///information about this structure, see EXTLOGFONT in the Windows SDK documentation.
    LOGFONTW lfAnsiVarFont;
    ///Is an Extended Logical Font structure that specifies the default fixed-pitch (monospaced) font for a device. For
    ///more information about this structure, see EXTLOGFONT in the Windows SDK documentation.
    LOGFONTW lfAnsiFixFont;
    ///Specifies the number of device fonts. GDI assumes that the device can draw text with this number of fonts on its
    ///own surfaces and that the driver can provide metrics information about the fonts. If the driver sets
    ///<b>cFonts</b> to -1, GDI will wait until fonts are needed to query the driver for the actual number of fonts it
    ///supports in a call to DrvQueryFont.
    uint     cFonts;
    ///Specifies the format of the bitmap. This parameter indicates how many bits of color information per pixel are
    ///requested, and must be one of the following values: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td>
    ///BMF_1BPP </td> <td> Monochrome </td> </tr> <tr> <td> BMF_4BPP </td> <td> 4 bits per pixel </td> </tr> <tr> <td>
    ///BMF_8BPP </td> <td> 8 bits per pixel </td> </tr> <tr> <td> BMF_16BPP </td> <td> 16 bits per pixel </td> </tr>
    ///<tr> <td> BMF_24BPP </td> <td> 24 bits per pixel </td> </tr> <tr> <td> BMF_32BPP </td> <td> 32 bits per pixel
    ///</td> </tr> <tr> <td> BMF_4RLE </td> <td> 4 bits per pixel, run length encoded </td> </tr> <tr> <td> BMF_8RLE
    ///</td> <td> 8 bits per pixel, run length encoded </td> </tr> <tr> <td> BMF_JPEG </td> <td> JPEG compressed image
    ///</td> </tr> <tr> <td> BMF_PNG </td> <td> PNG compressed image </td> </tr> </table>
    uint     iDitherFormat;
    ushort   cxDither;
    ///Specify the dimensions of a dithered brush. If these members are nonzero, then the device can create a dithered
    ///brush for a given RGB color.
    ushort   cyDither;
    ///Handle to the default palette for the device. The driver should create the palette by calling EngCreatePalette.
    ///The driver associates a palette with a device by returning this handle to GDI.
    HPALETTE hpalDefault;
    ///Is a set of flags that describe additional graphics capabilities of the device driver. These flags are defined in
    ///the following table. <table> <tr> <th>Flag</th> <th>Definition</th> </tr> <tr> <td> GCAPS2_ALPHACURSOR </td> <td>
    ///Handles pointers with per-pixel alpha values. </td> </tr> <tr> <td> GCAPS2_CHANGEGAMMARAMP </td> <td> The display
    ///device has a loadable hardware gamma ramp. </td> </tr> <tr> <td> GCAPS2_EXCLUDELAYERED </td> <td> Indicates that
    ///this is an accessibility mirror driver. Mirror drivers that do not set this flag will still receive drawing
    ///primitives for layered HWNDs. See Mirror Drivers for more information. </td> </tr> <tr> <td> GCAPS2_ICD_MULTIMON
    ///</td> <td> Informs GDI that the driver intends to handle DrvSetPixelFormat, DrvDescribePixelFormat, and
    ///DrvSwapBuffers calls in a multimon environment, even when the rectangle in the operation also intersects another
    ///device. Only one device is ever given the opportunity to handle those calls. If the capability is not specified
    ///and the region involved intersects more than one device, no driver is called. </td> </tr> <tr> <td>
    ///GCAPS2_INCLUDEAPIBITMAPS </td> <td> When drawing calls are made to a device-independent bitmap (DIB), an
    ///accessibility mirror driver will be called. See Mirror Drivers for more information. </td> </tr> <tr> <td>
    ///GCAPS2_JPEGSRC </td> <td> Device can accept JPEG compressed images (that is, images for which BMF_JPEG is set in
    ///the SURFOBJ structure). </td> </tr> <tr> <td> GCAPS2_MOUSETRAILS </td> <td> Indicates that the driver supports
    ///mouse trails (a succession of cursor images showing the mouse's location during a short period of time). The
    ///driver is capable of handling the values GDI sends in the <i>fl</i> parameter of the DrvSetPointerShape function.
    ///The driver should use the SPS_LENGTHMASK and SPS_FREQMASK masks to obtain values for the length and frequency of
    ///the mouse trails. See <b>DrvSetPointerShape</b> for more information about these masks. </td> </tr> <tr> <td>
    ///GCAPS2_PNGSRC </td> <td> Device can accept PNG compressed images (that is, images for which BMF_PNG is set in the
    ///SURFOBJ structure). </td> </tr> <tr> <td> GCAPS2_SYNCFLUSH </td> <td> The driver supports a programmatic-based
    ///flush mechanism for batched graphics DDI calls. DrvSynchronizeSurface will be called whenever GDI must flush any
    ///drawing that is being batched by the driver. </td> </tr> <tr> <td> GCAPS2_SYNCTIMER </td> <td> The driver
    ///supports a timer-based flush mechanism for batched graphics DDI calls. DrvSynchronizeSurface will be called
    ///periodically, based on a timer interval determined by GDI. </td> </tr> </table>
    uint     flGraphicsCaps2;
}

///The LINEATTRS structure is used by a driver's line-drawing functions to determine line attributes.
struct LINEATTRS
{
    ///Option flags. This member can be one of the following values: <table> <tr> <th>Flag</th> <th>Meaning</th> </tr>
    ///<tr> <td> LA_ALTERNATE </td> <td> A special cosmetic line style; every other pixel is on. </td> </tr> <tr> <td>
    ///LA_GEOMETRIC </td> <td> A geometric wide line. </td> </tr> <tr> <td> LA_STARTGAP </td> <td> The first entry in
    ///the style array specifies the length of the first gap. </td> </tr> <tr> <td> LA_STYLED </td> <td> The line is a
    ///styled line. </td> </tr> </table>
    uint        fl;
    ///Specifies join styles for geometric wide lines. This member can be one of the following values: <table> <tr>
    ///<th>Join Style</th> <th>Meaning</th> </tr> <tr> <td> JOIN_BEVEL </td> <td> The joining edges of wide lines are
    ///beveled. </td> </tr> <tr> <td> JOIN_MITER </td> <td> The joining edges of wide lines are mitered. </td> </tr>
    ///<tr> <td> JOIN_ROUND </td> <td> The joining edges of wide lines are rounded. </td> </tr> </table>
    uint        iJoin;
    ///Specifies the end cap style for a geometric wide line. This member can be one of the following values: <table>
    ///<tr> <th>End Cap Style</th> <th>Meaning</th> </tr> <tr> <td> ENDCAP_BUTT </td> <td> The end cap is </td> </tr>
    ///<tr> <td> ENDCAP_ROUND </td> <td> The end cap is rounded. </td> </tr> <tr> <td> ENDCAP_SQUARE </td> <td> The end
    ///cap is square. </td> </tr> </table>
    uint        iEndCap;
    ///Specifies a FLOAT_LONG that indicates the width of the line. This width is measured in FLOAT world coordinates
    ///for a geometric wide line, but in LONG device coordinates for a cosmetic wide line. For a description of the
    ///FLOAT_LONG data type, see GDI Data Types.
    FLOAT_LONG  elWidth;
    ///Specifies a FLOATL that sets the limit as a multiple of the line width that a miter join is allowed to extend
    ///from its inside corner to its outer vertex. This prevents very long spikes from occurring when lines of a path
    ///meet at very small angles. If the miter limit is exceeded, a bevel join should be used instead. For a description
    ///of the FLOATL data type, see GDI Data Types. This member is used only by geometric wide lines.
    uint        eMiterLimit;
    ///Specifies the number of entries in the style array pointed to by the <b>pstyle</b> member.
    uint        cstyle;
    ///Pointer to an array of FLOAT_LONG elements: the style array. If this member is <b>NULL</b>, the line style is
    ///solid. For a description of the FLOAT_LONG data type, see GDI Data Types.
    FLOAT_LONG* pstyle;
    ///Specifies a FLOAT_LONG that contains a pair of 16-bit values supplied by GDI whenever the driver calls
    ///PATHOBJ_bEnumClipLines. These two values, packed into a FLOAT_LONG, specify where in the styling array (at which
    ///pixel) to start the first subpath. This value must be updated as part of the output routine if the line is not
    ///solid. This member applies to cosmetic lines only . See also Styled Cosmetic Lines for additional information.
    FLOAT_LONG  elStyleState;
}

///The FLOATOBJ_XFORM structure describes an arbitrary linear two-dimensional transform, such as for geometric wide
///lines.
struct XFORML
{
    uint eM11;
    uint eM12;
    uint eM21;
    ///Are the four FLOATOBJ elements that comprise a 2x2 row-major matrix. The <b>eM11</b> member specifies the matrix
    ///element at row 1, column 1, the <b>eM12</b> member specifies the matrix element at row 1, column2, and so on.
    uint eM22;
    uint eDx;
    ///Are the x- and y-translation components of the transform.
    uint eDy;
}

///The CIECHROMA structure is used to describe the chromaticity coordinates, <b>x</b> and <b>y</b>, and the luminance,
///<b>Y</b> in CIE color space.
struct CIECHROMA
{
    ///Specifies the x-coordinate in CIE chromaticity space.
    int x;
    ///Specifies the y-coordinate in CIE chromaticity space.
    int y;
    ///Specifies the luminance. For more information, see the following Remarks section.
    int Y;
}

///The COLORINFO structure defines a device's colors in CIE coordinate space.
struct COLORINFO
{
    CIECHROMA Red;
    CIECHROMA Green;
    CIECHROMA Blue;
    CIECHROMA Cyan;
    CIECHROMA Magenta;
    CIECHROMA Yellow;
    ///Specify CIECHROMA structures that each define the x-coordinate, y-coordinate, and Y-coordinate (luminance) of the
    ///named color. The <b>Cyan</b> member can have a special meaning for monochrome printers. <b>Cyan.Y</b> must be set
    ///to 65534 (0xFFFE) to enable all of the grayscale halftone pattern sizes. For more information, see the following
    ///Remarks section.
    CIECHROMA AlignmentWhite;
    int       RedGamma;
    int       GreenGamma;
    ///Are the gamma corrections of display devices that permit the display device to display colors between the primary
    ///colors with accuracy. The values of these members should be in the range from 0 through 6.5535, which means that
    ///the numbers that are actually stored in these members must be in the range from 0 through 65535. For more
    ///information about these members and this data type, see the following Remarks section.
    int       BlueGamma;
    int       MagentaInCyanDye;
    int       YellowInCyanDye;
    int       CyanInMagentaDye;
    int       YellowInMagentaDye;
    int       CyanInYellowDye;
    ///Used for printing devices to describe color purity and concentration. Values should be between zero and one,
    ///which means that the numbers actually stored in these members must be in the range 0 through 10000. For more
    ///information about this data type, see the following Remarks section.
    int       MagentaInYellowDye;
}

///The GDIINFO structure describes the graphics capabilities of a given device.
struct GDIINFO
{
    ///Specifies the driver version number. The byte ordering of <b>ulVersion</b> has the following form. <img
    ///alt="Figure showing the ulVersion member specifying the driver version number" src="images/ver_nmbr.png"/> The
    ///high-order 16 bits must be set to zero. Bits 8 through 15 specify the version number of the Microsoft operating
    ///system for which the driver is designed. The high-order 4 bits of this range specify the major number of the
    ///version, the low-order 4 bits contain the minor number of the version. The low-order 8 bits of <b>ulVersion</b>
    ///specify the version number of the display driver; this value should be incremented for each release of the
    ///display driver binary file. The Display program in Control Panel indicates the version number contained in
    ///<b>ulVersion</b>, along with other driver-specific information.
    uint      ulVersion;
    ///Specifies the device technology. This member can be one of the values listed in the following table. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td> DT_CHARSTREAM </td> <td> Device fonts only </td> </tr> <tr> <td>
    ///DT_PLOTTER </td> <td> Vector plotter </td> </tr> <tr> <td> DT_RASCAMERA </td> <td> Raster camera </td> </tr> <tr>
    ///<td> DT_RASDISPLAY </td> <td> Raster display </td> </tr> <tr> <td> DT_RASPRINTER </td> <td> Raster printer </td>
    ///</tr> </table>
    uint      ulTechnology;
    ///Specifies the width of the physical surface. A positive value indicates that the width is in units of
    ///millimeters, while a negative value denotes that the width is in units of micrometers.
    uint      ulHorzSize;
    ///Specifies the height of the physical surface. A positive value indicates that the height is in units of
    ///millimeters, while a negative value denotes that the height is in units of micrometers.
    uint      ulVertSize;
    ///Specifies the width in pixels of the physical surface (display devices), or of the printable surface (printers).
    ///See also <b>ulDesktopHorzRes</b>.
    uint      ulHorzRes;
    ///Specifies the height in pixels of the physical surface (display devices), or of the printable surface (printers).
    uint      ulVertRes;
    ///Specifies the number of adjacent bits in each color plane. The total number of bits per pixel is the product of
    ///<b>cBitsPixel</b> and <b>cPlanes</b>.
    uint      cBitsPixel;
    ///Specifies the number of color planes.
    uint      cPlanes;
    ///For palettized devices, <b>ulNumColors</b> specifies the number of entries in the default color palette. For
    ///nonpalettized devices (which do not include printers), <b>ulNumColors</b> is set to -1.
    uint      ulNumColors;
    ///Is reserved and must be left set to zero.
    uint      flRaster;
    ///Specifies the width resolution of the device in logical pixels per inch. For printers, this member should be set
    ///to the printer's resolution in dpi. For displays, this member must be set to 96.
    uint      ulLogPixelsX;
    ///Specifies the height resolution of the device in logical pixels per inch. For printers, this member should be set
    ///to the printer's resolution in dpi. For displays, this member must be set to 96.
    uint      ulLogPixelsY;
    ///Specifies a flag describing Windows 3.1 text capabilities. If the driver TC_SCROLLBLT flag is in this member, it
    ///indicates that the console should perform text scrolling by redrawing the entire screen, using the
    ///driver-supplied DrvTextOut function rather than the DrvBitBlt or DrvCopyBits functions. The driver should set
    ///this flag if screen-to-screen bit-block transfers are slow. If this flag is not set, the driver is implicitly
    ///requesting that the console perform text scrolls through <i>DrvBitBlt</i><b>/</b><i>DrvCopyBits</i>.
    uint      flTextCaps;
    uint      ulDACRed;
    uint      ulDACGreen;
    ///Specifies the display number of DAC bits for the specified color.
    uint      ulDACBlue;
    ///Specifies the relative width of a device pixel, in the range of one to 1000.
    uint      ulAspectX;
    ///Specifies the relative height of a device pixel, in the range of one to 1000.
    uint      ulAspectY;
    ///Specifies the square root of the sum of the squares of <b>ulAspectX</b> and <b>ulAspectY</b>.
    uint      ulAspectXY;
    ///Specifies the numerator of style advance for x-major lines, <i>dx</i>. For additional information, refer to the
    ///following <b>Remarks</b> section and Styled Cosmetic Lines.
    int       xStyleStep;
    ///Specifies the numerator of style advance for y-major lines, <i>dy</i>. For additional information, refer to the
    ///following <b>Remarks</b> section and Styled Cosmetic Lines.
    int       yStyleStep;
    ///Specifies the denominator of style advance, D. For additional information, refer to the following <b>Remarks</b>
    ///section and Styled Cosmetic Lines.
    int       denStyleStep;
    ///Specifies a POINTL structure that contains the size, in pixels, of the unwritable margin of a surface.
    POINTL    ptlPhysOffset;
    ///Specifies a SIZEL structure that contains the size, in pixels, of the entire surface, including unwritable
    ///margins. A SIZEL structure is identical to a SIZE structure.
    SIZE      szlPhysSize;
    ///Specifies the number of palette registers for an indexed device.
    uint      ulNumPalReg;
    ///Is a COLORINFO structure that defines the device's colors in CIE coordinate space.
    COLORINFO ciDevice;
    ///For printers, specifies the number of pixels (or dots, or nozzles) per inch if the pixels are laid out side by
    ///side without overlapping or space between. For example, if the size of a pixel is 0.001 inch, this value is equal
    ///to one-divided-by 0.001. If the member is zero, GDI halftoning calculates this number based on the assumption
    ///that all pixels are connected with no overlapping. Because the physical dot size for most printers is larger than
    ///the measured dot size, GDI uses this value to approximate how many physical dots can be placed, based on the cell
    ///size (pattern size). A log regression is then performed to determine what is most linear; that is, where the dots
    ///should be placed for the best coverage to optimize the overlapped device pixels coverage (dot gain). For
    ///displays, this member should be set to zero.
    uint      ulDevicePelsDPI;
    ///Specifies the bit order of the device's primary colors or plane numbers for the halftone output. This member can
    ///be one of the values listed in the following table. <table> <tr> <th>Flag</th> <th>Meaning</th> </tr> <tr> <td>
    ///PRIMARY_ORDER_ABC </td> <td> Device output order is RGB or CMY. Red or cyan is in the least significant bits;
    ///blue or yellow is in the most significant bits. </td> </tr> <tr> <td> PRIMARY_ORDER_ACB </td> <td> Device output
    ///order is RBG or CYM. Red or cyan is in the least significant bits; green or magenta is in the most significant
    ///bits. </td> </tr> <tr> <td> PRIMARY_ORDER_BAC </td> <td> Device output order is GRB or MCY. Green or magenta is
    ///in the least significant bits; blue or yellow is in the most significant bits. </td> </tr> <tr> <td>
    ///PRIMARY_ORDER_BCA </td> <td> Device output order is GBR or MYC. Green or magenta is in the least significant
    ///bits; red or cyan is in the most significant bits. </td> </tr> <tr> <td> PRIMARY_ORDER_CBA </td> <td> Device
    ///output order is BGR or YMC. Blue or yellow is in the least significant bits; red or cyan is in the most
    ///significant bits. </td> </tr> <tr> <td> PRIMARY_ORDER_CAB </td> <td> Device output order is BRG or YCM. Blue or
    ///yellow is in the least significant bits; green or magenta is in the most significant bits. </td> </tr> </table>
    uint      ulPrimaryOrder;
    ///Specifies the size of the halftone pattern. The values ending with <i>A</i>x<i>B</i>_M are variations of the
    ///<i>A</i>x<i>B</i> patterns. In other words, SIZE_<i>A</i>x<i>B</i> and SIZE_<i>A</i>x<i>B</i>_M differ by which
    ///pixels are lit in an A x B pattern. This member can be one of the following values: <dl> <dt>HT_PATSIZE_2x2</dt>
    ///<dt>HT_PATSIZE_2x2_M</dt> <dt>HT_PATSIZE_4x4</dt> <dt>HT_PATSIZE_4x4_M</dt> <dt>HT_PATSIZE_6x6</dt>
    ///<dt>HT_PATSIZE_6x6_M</dt> <dt>HT_PATSIZE_8x8</dt> <dt>HT_PATSIZE_8x8_M</dt> <dt>HT_PATSIZE_10x10</dt>
    ///<dt>HT_PATSIZE_10x10_M</dt> <dt>HT_PATSIZE_12x12</dt> <dt>HT_PATSIZE_12x12_M</dt> <dt>HT_PATSIZE_14x14</dt>
    ///<dt>HT_PATSIZE_14x14_M</dt> <dt>HT_PATSIZE_16x16</dt> <dt>HT_PATSIZE_16x16_M</dt> <dt>HT_PATSIZE_SUPERCELL</dt>
    ///<dt>HT_PATSIZE_SUPERCELL_M</dt> <dt>HT_PATSIZE_USER</dt> <dt>HT_PATSIZE_MAX_INDEX</dt>
    ///<dt>HT_PATSIZE_DEFAULT</dt> </dl>
    uint      ulHTPatternSize;
    ///Specifies the preferred output format for halftone. HT_FORMAT_4BPP uses only 8 full intensity colors while
    ///HT_FORMATP_IRGB uses all the 16 colors including the half-intensity colors. It is assumed that a 5 x 5 x 5 format
    ///(5 bits per color) is used for HT_FORMAT_16BPP. This member can be one of the following values: <dl>
    ///<dt>HT_FORMAT_1BPP</dt> <dt>HT_FORMAT_4BPP</dt> <dt>HT_FORMAT_4BPP_IRGB</dt> <dt>HT_FORMAT_8BPP</dt>
    ///<dt>HT_FORMAT_16BPP</dt> <dt>HT_FORMAT_24BPP</dt> <dt>HT_FORMAT_32BPP</dt> </dl>
    uint      ulHTOutputFormat;
    ///Specifies a combination of flags describing the device. These flags are needed for halftoning. This member can be
    ///a combination of the following values: <table> <tr> <th>Flag</th> <th>Meaning</th> </tr> <tr> <td>
    ///HT_FLAG_8BPP_CMY332_MASK </td> <td> Flag used to clear the upper eight bits of <b>flHTFlags</b> (bits 24 to 31).
    ///The <b>MAKE_CMY332_MASK</b> macro can then be used to set these bits with 8-bit-per-pixel CMY mode ink level
    ///information. See Using GDI 8-Bit-Per-Pixel CMY Mask Modes for more information. </td> </tr> <tr> <td>
    ///HT_FLAG_ADDITIVE_PRIMS </td> <td> Device primaries are additive. </td> </tr> <tr> <td> HT_FLAG_DO_DEVCLR_XFORM
    ///</td> <td> Requests GDI to perform generic color correction. </td> </tr> <tr> <td> HT_FLAG_HAS_BLACK_DYE </td>
    ///<td> Device has separate black dye. </td> </tr> <tr> <td> <dl> <dt>HT_FLAG_HIGH_INK_ABSORPTION</dt>
    ///<dt>HT_FLAG_HIGHER_INK_ABSORPTION</dt> <dt>HT_FLAG_HIGHEST_INK_ABSORPTION</dt> </dl> </td> <td> Paper in device
    ///absorbs more than normal amount of ink, so GDI should render less ink to paper. These flags indicate the relative
    ///amount of ink absorption, with HT_FLAG_HIGHER_INK_ABSORPTION denoting more absorption than
    ///HT_FLAG_HIGH_INK_ABSORPTION, but less than HT_FLAG_HIGHEST_INK_ABSORPTION. </td> </tr> <tr> <td> <dl>
    ///<dt>HT_FLAG_INK_ABSORPTION_IDX0</dt> <dt>HT_FLAG_INK_ABSORPTION_IDX1</dt> <dt>HT_FLAG_INK_ABSORPTION_IDX2</dt>
    ///<dt>HT_FLAG_INK_ABSORPTION_IDX3</dt> </dl> </td> <td> Flags used to define
    ///HT_FLAG_HIGH/HIGHER/HIGHEST_INK_ABSORPTION and HT_FLAG_LOW/LOWER/LOWEST_INK_ABSORPTION. </td> </tr> <tr> <td>
    ///HT_FLAG_INK_HIGH_ABSORPTION </td> <td> Flag used to define HT_FLAG_HIGH/HIGHER/HIGHEST_INK_ABSORPTION. </td>
    ///</tr> <tr> <td> HT_FLAG_INVERT_8BPP_BITMASK_IDX </td> <td> GDI halftone should render 8-bit-per-pixel ask mode
    ///surface bitmap using a CMY_INVERTED mode palette. See Using GDI 8-Bit-Per-Pixel CMY Mask Modes for CMY_INVERTED
    ///mode palette description and requirements. </td> </tr> <tr> <td> <dl> <dt>HT_FLAG_LOW_INK_ABSORPTION</dt>
    ///<dt>HT_FLAG_LOWER_INK_ABSORPTION</dt> <dt>HT_FLAG_LOWEST_INK_ABSORPTION</dt> </dl> </td> <td> Paper in device
    ///absorbs less than normal amount of ink, so GDI should render more ink to paper. These flags indicate the relative
    ///amount of ink absorption, with HT_FLAG_LOWER_INK_ABSORPTION denoting less absorption than
    ///HT_FLAG_LOW_INK_ABSORPTION, but more than HT_FLAG_LOWEST_INK_ABSORPTION. </td> </tr> <tr> <td>
    ///HT_FLAG_NORMAL_INK_ABSORPTION </td> <td> Paper in device absorbs normal amount of ink. </td> </tr> <tr> <td>
    ///HT_FLAG_OUTPUT_CMY </td> <td> Device uses CMY primaries rather than RGB primaries. This flag value applies only
    ///to 1 bpp and 4 bpp destination surfaces. </td> </tr> <tr> <td> HT_FLAG_PRINT_DRAFT_MODE </td> <td> Disables GDI's
    ///antialiasing code. </td> </tr> <tr> <td> HT_FLAG_SQUARE_DEVICE_PEL </td> <td> Device pixel is square rather than
    ///round (displays only -- printers require rounded pixels). </td> </tr> <tr> <td> HT_FLAG_USE_8BPP_BITMASK </td>
    ///<td> Device uses monochrome printing. </td> </tr> </table>
    uint      flHTFlags;
    ///The video refresh rate for the current display mode. This is the value returned by the miniport driver for the
    ///refresh rate for the current mode. The Display program in Control Panel displays the refresh rate contained in
    ///the <b>ulVRefresh</b> member.
    uint      ulVRefresh;
    ///This member indicates the preferred x-alignment for bit block transfers to the device. A value of zero indicates
    ///that bit block transfers are accelerated; any other nonnegative number indicates that bit block transfers are not
    ///accelerated, and gives the preferred horizontal alignment as a pixel multiple. This value is used by the system
    ///to determine the default alignment for window positions and is also used to set the initial full-drag default
    ///during setup. A value of zero indicates that full-drag should be on by default; any value other than zero
    ///indicates that full-drag should be off by default.
    uint      ulBltAlignment;
    uint      ulPanningHorzRes;
    ///Should be ignored by the driver and remain zero-initialized.
    uint      ulPanningVertRes;
    uint      xPanningAlignment;
    ///Should be ignored by the driver and remain zero-initialized.
    uint      yPanningAlignment;
    uint      cxHTPat;
    ///Specify the width and height, respectively, in pixels, of the user-supplied halftone dither pattern. The value of
    ///<b>cxHTPat</b> must be in the range HT_USERPAT_CX_MIN to HT_USERPAT_CX_MAX, inclusive. The value of
    ///<b>cyHTPat</b> must be in the range HT_USERPAT_CY_MIN to HT_USERPAT_CY_MAX, inclusive. These constants are
    ///defined in <i>winddi.h</i>. See the following <b>Remarks</b> section for more information.
    uint      cyHTPat;
    ubyte*    pHTPatA;
    ubyte*    pHTPatB;
    ///Point to the user-defined halftone dither patterns for primary colors A, B, and C, respectively, as defined by
    ///the PRIMARY_ORDER_XXX value in the <b>ulPrimaryOrder</b> member. Each dither pattern must be a valid
    ///two-dimensional byte array of size <b>cxHTPat</b> by <b>cyHTPat</b>. See the following <b>Remarks</b> section for
    ///more information.
    ubyte*    pHTPatC;
    ///Specifies a set of flags that indicate the shading and blending capabilities of the device. Display drivers
    ///should ignore this member and should leave it set to zero. For printer drivers, the value that the driver places
    ///in this member is the value that GDI reports when an application calls <b>GetDeviceCaps</b>(hdc, SHADEBLENDCAPS).
    ///The <b>GetDeviceCaps</b> function is described in the Microsoft Window SDK documentation.
    uint      flShadeBlend;
    ///Specifies the way that color fragments are configured to form pixels on the display device. The color fragments
    ///on the display device can be arranged in RGB order, or in BGR order, completely independent of the RGB ordering
    ///in the frame buffer. The color fragments can be configured in horizontal stripes in which all of the fragments in
    ///one row are the same color. Alternatively, the color fragments can be configured in vertical stripes, in which
    ///all fragments in one column are the same color. Vertical striping is preferred, since it effectively provides
    ///three separate fragments in a row for each pixel, thereby giving greater horizontal subpixel resolution. The
    ///<b>ulPhysicalPixelCharacteristics</b> member must be set to one of the values shown in the following table:
    ///<table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td> PPC_DEFAULT </td> <td> Display device physical pixel
    ///information is unknown. </td> </tr> <tr> <td> PPC_BGR_ORDER_HORIZONTAL_STRIPES </td> <td> Physical color
    ///fragments on the display device are arranged, from top to bottom, in rows of blue, green, and red color
    ///fragments. </td> </tr> <tr> <td> PPC_BGR_ORDER_VERTICAL_STRIPES </td> <td> Physical color fragments on the
    ///display device are arranged, from left to right, in columns of blue, green, and red color fragments. </td> </tr>
    ///<tr> <td> PPC_RGB_ORDER_HORIZONTAL_STRIPES </td> <td> Physical color fragments on the display device are
    ///arranged, from top to bottom, in rows of red, green, and blue color fragments. </td> </tr> <tr> <td>
    ///PPC_RGB_ORDER_VERTICAL_STRIPES </td> <td> Physical color fragments on the display device are arranged, from left
    ///to right, in columns of red, green, and blue color fragments. </td> </tr> <tr> <td> PPC_UNDEFINED </td> <td>
    ///Display device physical pixel information is known but cannot be expressed as one of the given enumerations. The
    ///enumerations are currently applicable to an LCD-based monitor. The driver should set
    ///<b>ulPhysicalPixelCharacteristics</b> to PPC_UNDEFINED when either of the following conditions is met. (This list
    ///is not comprehensive, but covers the most common conditions.) <ul> <li> The driver has knowledge that the monitor
    ///is not an LCD device. </li> <li> The device is an LCD device but the resolution of the frame buffer is different
    ///from the native resolution of the physical display requiring scaling. That is, scaling is required because there
    ///is no longer a one-to-one correspondence between frame buffer pixels and device pixels. </li> </ul> </td> </tr>
    ///</table>
    uint      ulPhysicalPixelCharacteristics;
    ///Specifies the gamma of the display device. This member should be set to either the gamma of the physical pixel,
    ///scaled by a factor of 1000, or to one of the following values. For example, a gamma value of 2.2 would be
    ///represented as 2200. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td> PPG_DEFAULT </td> <td> The
    ///driver has no knowledge of the gamma for the device. </td> </tr> <tr> <td> PPG_SRGB </td> <td> The device uses an
    ///sRGB gamma. </td> </tr> </table>
    uint      ulPhysicalPixelGamma;
}

///The <b>BRUSHOBJ</b> structure contains three public members that describe a brush object.
struct BRUSHOBJ
{
    ///Specifies the color index of a solid brush. This index has been translated to the target surface's palette.
    ///Drawing can proceed without realization of the brush. A value of 0xFFFFFFFF indicates that a nonsolid brush must
    ///be realized.
    uint  iSolidColor;
    ///Pointer to the driver's realized brush.
    void* pvRbrush;
    ///Specifies an FLONG value containing flags that describe this brush object. This member can be a combination of
    ///any of the following values (only one of BR_HOST_ICM and BR_DEVICE_ICM can be set): <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td> BR_CMYKCOLOR </td> <td> When this bit is set, <b>iSolidColor</b> contains a
    ///32-bit CMYK color value. Otherwise, <b>iSolidColor</b> contains a palette index or 0xFFFFFFFF. </td> </tr> <tr>
    ///<td> BR_DEVICE_ICM </td> <td> The driver performs image color management for the brush color. </td> </tr> <tr>
    ///<td> BR_HOST_ICM </td> <td> The driver need not perform image color management for the brush color because GDI
    ///(or the calling application) is responsible. </td> </tr> </table>
    uint  flColorType;
}

///The CLIPOBJ structure describes the clip region used when drawing.
struct CLIPOBJ
{
    ///Specifies a value that uniquely identifies the clip region. If <b>iUniq</b> is nonzero, the driver uses it as a
    ///cache identifier. This allows the driver to recognize a region after downloading and caching it. If the value is
    ///zero, the driver should not cache the region because the region will not be used again.
    uint  iUniq;
    ///Specifies a RECTL structure that bounds the part of the region that intersects the drawing. If
    ///<b>iDComplexity</b> is DC_RECT, then this is the clipping rectangle to be considered.
    RECTL rclBounds;
    ///Specifies the complexity of the part of the region that intersects with the drawing. This member must be one of
    ///the following values: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td> DC_COMPLEX </td> <td> The clip
    ///region must be enumerated. </td> </tr> <tr> <td> DC_RECT </td> <td> Clip to a single rectangle. </td> </tr> <tr>
    ///<td> DC_TRIVIAL </td> <td> Clipping need not be considered; draw the whole figure. </td> </tr> </table>
    ubyte iDComplexity;
    ///Specifies the complexity of the whole region. This value is used by the driver in deciding whether to cache the
    ///region. CLIPOBJ_cEnumStart can be called to determine the exact number of rectangles in the region. This member
    ///can be one of the following values: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td> FC_COMPLEX </td>
    ///<td> The region consists of more than four rectangles. </td> </tr> <tr> <td> FC_RECT </td> <td> The region is a
    ///single rectangle. </td> </tr> <tr> <td> FC_RECT4 </td> <td> The region consists of, at most, four rectangles.
    ///</td> </tr> </table>
    ubyte iFComplexity;
    ///Specifies how the region is stored by GDI. This can help the driver determine how to enumerate the region. This
    ///member can be one of the following values: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td>
    ///TC_PATHOBJ </td> <td> The region is stored as a path. </td> </tr> <tr> <td> TC_RECTANGLES </td> <td> The region
    ///is stored as rectangles. </td> </tr> </table>
    ubyte iMode;
    ///Specifies clipping options. This member can be the following value: <table> <tr> <th>Value</th> <th>Meaning</th>
    ///</tr> <tr> <td> OC_BANK_CLIP </td> <td> <b>Obsolete</b>. Indicates an engine callback for a banked device. </td>
    ///</tr> </table>
    ubyte fjOptions;
}

///The DRIVEROBJ structure is used to track a resource, allocated by a driver, that requires use GDI services. A
///DRIVEROBJ structure allows a display driver to request the GDI service in managing per-process resources. By creating
///a DRIVEROBJ structure, a display driver can ensure that resources will be released when an application terminates.
struct DRIVEROBJ
{
    ///Pointer to the driver resource that will be tracked by the DRIVEROBJ structure. The resource is associated with
    ///the current client process.
    void*       pvObj;
    ///Pointer to a driver-supplied callback function that frees the resource pointed to by <b>pvObj</b>. This callback
    ///function has the following prototype: ``` BOOL (CALLBACK * FREEOBJPROC) (DRIVEROBJ * pDriverObj); ``` The
    ///callback function returns <b>TRUE</b> if it is able to free the resource, and <b>FALSE</b> otherwise.
    FREEOBJPROC pFreeProc;
    ///GDI handle to the physical device associated with the object.
    HDEV__*     hdev;
    ///Pointer to the driver's private instance data; that is, this member identifies the driver's PDEV.
    DHPDEV__*   dhpdev;
}

///The FONTOBJ structure is used to give a driver access to information about a particular instance of a font.
struct FONTOBJ
{
    ///Specifies a distinct realization of the font. This value can be used by the driver to identify a GDI font that it
    ///might have cached or to identify a driver's realization of its own font. If this member is zero for a GDI font,
    ///the font should not be cached.
    uint   iUniq;
    ///Specifies the device index for a device font, which was registered by a call to DrvQueryFont. If the font is a
    ///GDI font, this member has meaning only to GDI, and the driver should ignore it.
    uint   iFace;
    ///Specifies the width, in pixels, of the largest glyph in the specified font.
    uint   cxMax;
    ///Is a value specifying the type of the font. This member can be a combination of the flags listed in the following
    ///table. (Note, however, that FO_GRAY16 and FO_NOGRAY16 are mutually exclusive.) <table> <tr> <th>Flag</th>
    ///<th>Meaning</th> </tr> <tr> <td> FO_CFF </td> <td> Postscript OpenType font. </td> </tr> <tr> <td> FO_DBCS_FONT
    ///</td> <td> Font supports DBCS code pages. </td> </tr> <tr> <td> FO_EM_HEIGHT </td> <td> TrueType driver internal
    ///flag. </td> </tr> <tr> <td> FO_GRAY16 </td> <td> Font bitmaps are four bits-per-pixel blending (alpha) values.
    ///</td> </tr> <tr> <td> FO_MULTIPLEMASTER </td> <td> Multiple Master (Type1 or OpenType) font. </td> </tr> <tr>
    ///<td> FO_NOGRAY16 </td> <td> Indicates that the font driver cannot (or will not) grayscale a particular font
    ///realization. </td> </tr> <tr> <td> FO_POSTSCRIPT </td> <td> Postscript (Type1 or OpenType) font. </td> </tr> <tr>
    ///<td> FO_SIM_BOLD </td> <td> Driver-simulated bold font. </td> </tr> <tr> <td> FO_SIM_ITALIC </td> <td>
    ///Driver-simulated italic font. </td> </tr> <tr> <td> FO_TYPE_DEVICE </td> <td> Device-specific font. </td> </tr>
    ///<tr> <td> FO_TYPE_OPENTYPE </td> <td> OpenType font. </td> </tr> <tr> <td> FO_TYPE_RASTER </td> <td> Bitmap font.
    ///</td> </tr> <tr> <td> FO_TYPE_TRUETYPE </td> <td> TrueType font. </td> </tr> <tr> <td> FO_VERT_FACE </td> <td>
    ///Vertical font. </td> </tr> </table> If the FO_RASTER flag is set, the glyphs written to the specified STROBJ
    ///structure are bitmaps, otherwise they are pointers to PATHOBJ structures. If the glyph images are returned in the
    ///form of PATHOBJ structures, the driver must inspect the FM_INFO_TECH_STROKE flag of the <b>flInfo</b> member of
    ///the associated IFIMETRICS structure. If that flag is set, the paths should be stroked, otherwise the paths must
    ///be filled using the alternating mode convention. If the FO_GRAY16 flag is set, then the font bitmaps are four
    ///bits-per-pixel blending (alpha) values. A value of zero means that the resulting pixel should have the same color
    ///as the background. If the alpha value is k, then the following table describes the attributes of the resulting
    ///pixel, using either linear alpha blending, or gamma-corrected alpha blending. In both methods, the foreground and
    ///background colors are, respectively, c<sub>f</sub> and c<sub>b</sub>. <table> <tr> <th>Pixel Attribute</th>
    ///<th>Description</th> </tr> <tr> <td> <dl> <dt>Blended Color</dt> <dt>(linear alpha blending)</dt> </dl> </td>
    ///<td> Linear alpha blending produces a blended color that is a linear combination of the foreground and background
    ///colors. c = b * c<sub>f</sub> + (1 - b) * c<sub>b</sub> The blend fraction, b, is obtained as follows: b = k /
    ///15, for k = 0, 1, 2, ..., 15 Note: the foreground and background colors include all three color channels (R, G,
    ///B). </td> </tr> <tr> <td> <dl> <dt>Blended Color</dt> <dt>(gamma-corrected alpha blending)</dt> </dl> </td> <td>
    ///Gamma-corrected alpha blending produces a blended color by raising a variable that depends on the alpha value to
    ///a fixed power. Two formulas are provided: one should be used when the foreground color is numerically larger than
    ///the background color; the other should be used in the opposite case. (When the foreground and background colors
    ///are equal, both formulas simplify to c = c<sub>b</sub>.) <dl> <dt>If c<sub>f</sub> &gt; c<sub>b</sub>,</dt> <dt>c
    ///= c<sub>b</sub> + <b>pow</b>(b[k], (1 / gamma)) * (c<sub>f</sub> - c<sub>b</sub>)</dt> </dl> <dl> <dt>If
    ///c<sub>f</sub> &lt; c<sub>b</sub>,</dt> <dt>c = c<sub>b</sub> + (1 - <b>pow</b>(1 - b[k], 1 / gamma)) *
    ///(c<sub>f</sub> - c<sub>b</sub>)</dt> </dl> In these formulas, gamma = 2.33, and b[k] is the k<sup>th</sup>
    ///blending fraction, obtained as follows: <dl> <dt> b[k] = 0, for k = 0, and </dt> <dt>b[k] = (k + 1) / 16, for k =
    ///1, 2, ..., 15</dt> </dl> Note: unlike linear alpha blending, these formulas must be applied to <i>each</i> of the
    ///three color channels (R, G, B). </td> </tr> </table> GDI sets the FO_GRAY16 flag on entry to the DrvQueryFontData
    ///function when it requests that a font be grayscaled to one of 16 values. If the font driver cannot grayscale a
    ///particular font realization, then the font provider clears the FO_GRAY16 flag and sets the FO_NOGRAY16 flag to
    ///inform GDI that the grayscaling request will not be satisfied.
    uint   flFontType;
    ///Specifies the associated TrueType file. Two separate point size realizations of a TrueType font face will have
    ///FONTOBJ structures that share the same <b>iTTUniq</b> value, but will have different <b>iUniq</b> values. Only
    ///TrueType font types can have a nonzero <b>iTTUniq</b> member. For more information see <b>flFontType</b>.
    size_t iTTUniq;
    ///Pointer to a driver-defined value for device fonts that are already loaded. If the font is a GDI font, then this
    ///member is used internally to identify the font and should be ignored.
    size_t iFile;
    ///Specifies the resolution of the device for which this font is realized.
    SIZE   sizLogResPpi;
    ///Specifies the style size of the font instance, in points.
    uint   ulStyleSize;
    ///Pointer to consumer-allocated data associated with this font instance. A consumer is a driver that accepts glyph
    ///information as input for generating text output. Only a font consumer can modify this member. The consumer of
    ///this font can store any information in the location pointed to by this member. The engine will not modify this
    ///member. The <b>pvConsumer</b> member is guaranteed to be null the first time a FONTOBJ structure is passed to the
    ///consumer.
    void*  pvConsumer;
    ///Pointer to producer-allocated data associated with this font instance. A producer is a driver that can produce
    ///glyph information as output; this includes glyph metrics, bitmaps, and outlines. Only a font producer can modify
    ///this member. The producer of this font can store any information in the location pointed to by this member. The
    ///engine will not modify this member. The <b>pvProducer</b> member is guaranteed to be null the first time a
    ///FONTOBJ structure is passed to the producer.
    void*  pvProducer;
}

///The BLENDOBJ structure controls blending by specifying the blending functions for source and destination bitmaps.
struct BLENDOBJ
{
    BLENDFUNCTION BlendFunction;
}

///<p class="CCE_Message">[The PALOBJ structure has no public members.] The <b>PALOBJ</b> structure is a user object
///that represents an indexed color palette.
struct PALOBJ
{
    uint ulReserved;
}

///The PATHOBJ structure is used to describe a set of lines and Bezier curves that are to be stroked or filled.
struct PATHOBJ
{
    ///A set of hint flags that describe the path. This member is a bitwise OR (with certain restrictions) of the
    ///following values: <table> <tr> <th>Flag</th> <th>Description</th> </tr> <tr> <td> PO_ALL_INTEGERS </td> <td> The
    ///vertices of the path have integer coordinates with no fractional parts. This flag is intended primarily as an
    ///accelerator so that drivers can use a simpler all-integer fast-path. In addition, when GDI sets this flag, the
    ///driver is permitted to deviate slightly from the standard NT-based operating system GDI Grid Intersection
    ///Quantization (GIQ) convention that dictates the rasterization rules for lines. Specifically, when PO_ALL_INTEGERS
    ///is set the driver can choose its own rules for which pixel should be lit in the tie-breaker case where a line
    ///logically falls exactly between two pixels. Typically, this flag allows drivers to use hardware point-to-point
    ///line drawing capabilities even when the hardware has a different tie-breaker rule from that of GIQ. GDI sets this
    ///flag only for solid lines that are one pixel wide. Also, GDI sets this flag only if the graphics mode of the
    ///device context is set to GM_COMPATIBLE. For more information about setting the graphics mode, see
    ///<b>SetGraphicsMode</b> in the Microsoft Window SDK documentation. </td> </tr> <tr> <td> PO_BEZIERS </td> <td> The
    ///path contains Bezier curves. GDI sets only one of PO_BEZIERS or PO_ELLIPSE in the <b>fl</b> member. </td> </tr>
    ///<tr> <td> PO_ELLIPSE </td> <td> The path consists of a single ellipse inscribed in the path's bounding rectangle.
    ///GDI sets only one of PO_BEZIERS or PO_ELLIPSE in the <b>fl</b> member. </td> </tr> <tr> <td> PO_ENUM_AS_INTEGERS
    ///</td> <td> The driver can request that the vertices returned from PATHOBJ_bEnum be expressed in a 32-bit integer
    ///format rather than the standard 28.4 format. The driver makes this request by ORing PO_ENUM_AS_INTEGERS into the
    ///<b>fl</b> member of the given PATHOBJ before calling <b>PATHOBJ_bEnum</b>. The driver can set PO_ENUM_AS_INTEGERS
    ///only when GDI has set the PO_ALL_INTEGERS flag. That is, the path must be known to contain only integer
    ///coordinates. Note that PO_ENUM_AS_INTEGERS is the only flag that the driver is permitted to modify. When this
    ///flag is set, the driver is permitted to deviate slightly from the standard GIQ convention that dictates the
    ///rasterization rules for lines. Specifically, when PO_ENUM_ALL_INTEGERS is set the driver can choose its own rules
    ///for which pixel should be lit in the tie-breaker case where a line logically falls exactly between two pixels.
    ///Typically, this flag allows drivers to use hardware point-to-point line drawing capabilities even when the
    ///hardware has a different tie-breaker rule from that of GIQ. </td> </tr> </table>
    uint fl;
    ///The number of lines and Bezier curves that make up the path.
    uint cCurves;
}

///The SURFOBJ structure is the user object for a surface. A device driver usually calls methods on a surface object
///only when the surface object represents a GDI bitmap or a device-managed surface.
struct SURFOBJ
{
    ///Handle to a surface, provided that the surface is device-managed. Otherwise, this member is zero.
    DHSURF__* dhsurf;
    ///Handle to the surface.
    HSURF__*  hsurf;
    ///Identifies the device's PDEV that is associated with the specified surface.
    DHPDEV__* dhpdev;
    ///GDI's logical handle to the PDEV associated with this device.
    HDEV__*   hdev;
    ///Specifies a SIZEL structure that contains the width and height, in pixels, of the surface. The SIZEL structure is
    ///identical to the SIZE structure.
    SIZE      sizlBitmap;
    ///Specifies the size of the buffer pointed to by <b>pvBits</b>.
    uint      cjBits;
    ///If the surface is a standard format bitmap, this is a pointer to the surface's pixels. For BMF_JPEG or BMF_PNG
    ///images, this is a pointer to a buffer containing the image data in a JPEG or PNG format. Otherwise, this member
    ///is <b>NULL</b>.
    void*     pvBits;
    ///Pointer to the first scan line of the bitmap. If <b>iBitmapFormat</b> is BMF_JPEG or BMF_PNG, this member is
    ///<b>NULL</b>.
    void*     pvScan0;
    ///Specifies the count of bytes required to move down one scan line in the bitmap. If <b>iBitmapFormat</b> is
    ///BMF_JPEG or BMF_PNG, this member is <b>NULL</b>.
    int       lDelta;
    ///Specifies the current state of the specified surface. Every time the surface changes, this value is incremented.
    ///This enables drivers to cache source surfaces. For a surface that should not be cached, <b>iUniq</b> is set to
    ///zero. This value is used in conjunction with the BMF_DONTCACHE flag of <b>fjBitmap</b>.
    uint      iUniq;
    ///Specifies the standard format most closely matching this surface. If the <b>iType</b> member specifies a bitmap
    ///(STYPE_BITMAP), this member specifies its format. NT-based operating systems support a set of predefined formats,
    ///although applications can also send device-specific formats by using <b>SetDIBitsToDevice</b>. Supported
    ///predefined formats include the following: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td> BMF_1BPP
    ///</td> <td> 1 bit per pixel. </td> </tr> <tr> <td> BMF_4BPP </td> <td> 4 bits per pixel. </td> </tr> <tr> <td>
    ///BMF_8BPP </td> <td> 8 bits per pixel. </td> </tr> <tr> <td> BMF_16BPP </td> <td> 16 bits per pixel. </td> </tr>
    ///<tr> <td> BMF_24BPP </td> <td> 24 bits per pixel. </td> </tr> <tr> <td> BMF_32BPP </td> <td> 32 bits per pixel.
    ///</td> </tr> <tr> <td> BMF_4RLE </td> <td> 4 bits per pixel, run length encoded. </td> </tr> <tr> <td> BMF_8RLE
    ///</td> <td> 8 bits per pixel, run length encoded. </td> </tr> <tr> <td> BMF_JPEG </td> <td> JPEG compressed image.
    ///</td> </tr> <tr> <td> BMF_PNG </td> <td> PNG compressed image. </td> </tr> </table>
    uint      iBitmapFormat;
    ///Surface type, which is one of the following: <table> <tr> <th>Type</th> <th>Definition</th> </tr> <tr> <td>
    ///STYPE_BITMAP </td> <td> The surface is a bitmap. </td> </tr> <tr> <td> STYPE_DEVBITMAP </td> <td> The surface is
    ///a device format bitmap. </td> </tr> <tr> <td> STYPE_DEVICE </td> <td> The surface is managed by the device. </td>
    ///</tr> </table>
    ushort    iType;
    ///If the surface is of type STYPE_BITMAP and is a standard uncompressed format bitmap, the following flags can be
    ///set. Otherwise, this member should be ignored. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td>
    ///BMF_DONTCACHE </td> <td> The bitmap should not be cached by the driver because it is a transient bitmap, created
    ///by GDI, that the driver will never see again. If this flag is set, the <b>iUniq</b> member of this structure will
    ///be set to 0. </td> </tr> <tr> <td> BMF_KMSECTION </td> <td> Is used by GDI only and should be ignored by the
    ///driver. </td> </tr> <tr> <td> BMF_NOTSYSMEM </td> <td> The bitmap is not in system memory. EngModifySurface sets
    ///this flag when it moves a bitmap into video memory. </td> </tr> <tr> <td> BMF_NOZEROINIT </td> <td> The bitmap
    ///was not zero-initialized. </td> </tr> <tr> <td> BMF_TOPDOWN </td> <td> The first scan line represents the
    ///<i>top</i> of the bitmap. </td> </tr> <tr> <td> BMF_WINDOW_BLT </td> <td> GDI sets this flag to notify the driver
    ///of a window move from one screen location to another. </td> </tr> </table>
    ushort    fjBitmap;
}

///The WNDOBJ structure allows the driver to keep track of the position, size, and visible client region changes of a
///window.
struct WNDOBJ
{
    ///Specifies a CLIPOBJ structure that describes the client region of the window. If <b>iDComplexity</b> is DC_RECT
    ///and the left edge in <b>rclBounds</b> is greater than or equal to the right edge, or the top edge is greater than
    ///or equal to the bottom edge, the client region is invisible.
    CLIPOBJ  coClient;
    ///Pointer to a driver-defined value that identifies this particular WNDOBJ structure. This value can be set by
    ///calling the WNDOBJ_vSetConsumer function.
    void*    pvConsumer;
    ///Specifies a RECTL structure that describes the client area of the window in screen coordinates. This rectangle is
    ///lower-right exclusive, which means that the lower and right-hand edges of this region are not included.
    RECTL    rclClient;
    ///Pointer to the SURFOBJ structure that was passed to EngCreateWnd when this WNDOBJ was created.
    SURFOBJ* psoOwner;
}

///The XLATEOBJ structure is used to translate color indexes from one palette to another.
struct XLATEOBJ
{
    ///A cache identifier that enables the driver to recognize an XLATEOBJ structure that it has previously cached. If
    ///this member is zero, the driver should not cache the XLATEOBJ structure.
    uint   iUniq;
    ///Flags specifying hints about the translation. This member can be any combination of the following values: <table>
    ///<tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td> XO_DEVICE_ICM </td> <td> ICM is enabled on the device. The
    ///driver should translate color according to the color transform created by DrvIcmCreateColorTransform. The driver
    ///should call XLATEOBJ_hGetColorTransform to get the color transform handle. This bit is mutually exclusive from
    ///XO_HOST_ICM. </td> </tr> <tr> <td> XO_FROM_CMYK </td> <td> As a result of ICM translation, source indices are
    ///translated to the 32-bit CMYK color format. When this bit is set, <b>iSrcType</b>, <b>iDstType</b>,
    ///<b>cEntries</b>, and <b>pulXlate</b> should be ignored. </td> </tr> <tr> <td> XO_HOST_ICM </td> <td> ICM is
    ///performed by the graphics engine, so the colors in this color table are corrected to the target surface. This bit
    ///is set by the GDI as information for the driver: no action is required by the driver. This bit is mutually
    ///exclusive from XO_DEVICE_ICM. </td> </tr> <tr> <td> XO_TABLE </td> <td> A table is provided to translate source
    ///indices to target indices. </td> </tr> <tr> <td> XO_TO_MONO </td> <td> Source indices are translated to a
    ///monochrome format with the special property that all indices map to zero, except for one. A driver can use this
    ///to accelerate a block transfer. </td> </tr> <tr> <td> XO_TRIVIAL </td> <td> Source indices are usable as target
    ///indices. </td> </tr> </table>
    uint   flXlate;
    ///Is obsolete. Use XLATEOBJ_cGetPalette to query the source format.
    ushort iSrcType;
    ///Is obsolete. Use XLATEOBJ_cGetPalette to query the destination format.
    ushort iDstType;
    ///Specifies the number of entries in the array pointed to by the <b>pulXlate</b> member. Indexing into
    ///<b>pulXlate</b> with a value greater than <b>cEntries</b> results in a memory access violation.
    uint   cEntries;
    ///Pointer to an array of translation entries.
    uint*  pulXlate;
}

///The ENUMRECTS structure is used by the CLIPOBJ_cEnumStart function to provide information about rectangles in a clip
///region for the CLIPOBJ_bEnum function.
struct ENUMRECTS
{
    ///Specifies the number of RECTL structures in the <b>arcl</b> array.
    uint     c;
    RECTL[1] arcl;
}

///The GLYPHBITS structure is used to define a glyph bitmap.
struct GLYPHBITS
{
    ///Specifies a POINTL structure that defines the origin of the character in the bitmap.
    POINTL   ptlOrigin;
    ///Specifies a SIZEL structure that contains the width and height, in pixels, of the bitmap. A SIZEL structure is
    ///identical to a SIZE structure.
    SIZE     sizlBitmap;
    ///Is a variable-sized byte array containing a BYTE-aligned bitmap of the glyph. The array must include padding at
    ///the end to DWORD-align the entire structure. GDI will make this request of drivers that have antialiased fonts
    ///(see the description of DrvQueryFontCaps). It is possible that a driver may not be able to render a font in a
    ///multilevel format. In this case, the driver fails the call and GDI will call the driver again requesting a
    ///monochrome realization.
    ubyte[1] aj;
}

///The GLYPHDEF union identifies individual glyphs and provides either a pointer to a GLYPHBITS structure or a pointer
///to a PATHOBJ structure.
union GLYPHDEF
{
    ///If <b>pgb</b> is defined, this member is a pointer to a GLYPHBITS structure. The driver can use the bitmap bits
    ///stored in this structure to form the associated glyph on its surface.
    GLYPHBITS* pgb;
    ///If <b>ppo</b> is defined, this member is a pointer to a PATHOBJ structure the driver can examine to extract the
    ///path describing the associated glyph.
    PATHOBJ*   ppo;
}

///The GLYPHPOS structure is used by GDI to provide a graphics driver with a glyph's description and position.
struct GLYPHPOS
{
    ///Handle to the glyph.
    uint      hg;
    ///Pointer to a GLYPHDEF union.
    GLYPHDEF* pgdf;
    ///Specifies a POINTL structure that contains the coordinates of the point in device space where the character
    ///origin of the glyph should be placed.
    POINTL    ptl;
}

///The GLYPHDATA structure contains information about an individual glyph.
struct GLYPHDATA
{
    ///Specifies a GLYPHDEF union that contains a pointer to either a GLYPHBITS structure or a PATHOBJ structure,
    ///depending on whether, respectively, the glyph data is in the form of a bitmap or an outline.
    GLYPHDEF gdf;
    ///Handle to the glyph.
    uint     hg;
    ///Specifies a FIX value containing the character increment amount, D = A + B + C. The character increment amount
    ///represents the sum of the prebearing, or left sidebearing amount (A), the width of the glyph (B), and the width
    ///of the right sidebearing amount (C). The two sidebearing amounts represent the (usually) empty space immediately
    ///to the left and right of the glyph. The value stored in <b>fxD</b> is the dot product of D and a unit vector
    ///along the baseline (in device coordinates), yielding the projection of D onto the baseline.
    int      fxD;
    ///Specifies a FIX value containing the prebearing, or left sidebearing amount, A. The value stored in <b>fxA</b> is
    ///the dot product of A and a unit vector along the baseline (in device coordinates), yielding the projection of A
    ///onto the baseline.
    int      fxA;
    ///Specifies a FIX value containing the advancing edge of the character, A + B. The value stored in fxAB is the dot
    ///product of A + B and a unit vector along the baseline (in device coordinates), yielding the projection of A + B
    ///onto the baseline.
    int      fxAB;
    ///Specifies a FIX value containing the distance between the baseline and the ink box top along a unit vector in the
    ///ascent direction (in device coordinates).
    int      fxInkTop;
    ///Specifies a FIX value containing the distance between the baseline and the ink box bottom along a unit vector in
    ///the ascent direction (in device coordinates).
    int      fxInkBottom;
    ///Specifies a RECTL structure that describes the ink box in which the glyph fits. The sides of the ink box are
    ///parallel to the x and y axes.
    RECTL    rclInk;
    ///Specifies a POINTQF structure that contains the character increment vector, D = A + B + C. The high-order WORDs
    ///of <b>ptqD</b> are 28.4 device coordinates. The low-order WORDs of this member provide additional precision. For
    ///a description of the POINTQF structure, see GDI Data Types.
    POINTQF  ptqD;
}

///The STROBJ class, or text string object, contains an enumeration of glyph handles and positions for the device
///driver.
struct STROBJ
{
    ///Specifies the number of glyphs in the STROBJ.
    uint          cGlyphs;
    ///Accelerator flags. This member can be any of the following values:
    uint          flAccel;
    ///Specifies whether the font is a fixed-pitch (monospace) font. If it is, this member is equal to the advance width
    ///of glyphs in pels; otherwise, it is zero. When this member is nonzero, GDI supplies a valid coordinate for only
    ///the first character in the string. All other character positions must be generated by the driver by successively
    ///adding the value of this member along the writing direction.
    uint          ulCharInc;
    ///Specifies a RECTL structure that describes the bounding box for the string.
    RECTL         rclBkGround;
    ///Pointer to the GLYPHPOS array for the whole string. Can be <b>NULL</b> (see the following <b>Remarks</b>
    ///section).
    GLYPHPOS*     pgp;
    ///Pointer to the original Unicode string or <b>cGlyphs</b> characters. Contrary to its name, this string is not
    ///usually null-terminated. Also, this string is not always valid, such as in journalling with printer fonts, in
    ///which case this parameter will be <b>NULL</b>.
    const(wchar)* pwszOrg;
}

///The FONTINFO structure contains information regarding a specific font.
struct FONTINFO
{
    ///Specifies the size of this FONTINFO structure in bytes.
    uint cjThis;
    ///Is a set of capabilities flags. The allowed flags are FO_DEVICE_FONT and FO_OUTLINE_CAPABLE.
    uint flCaps;
    ///Specifies the number of glyphs in the font.
    uint cGlyphsSupported;
    ///Specifies the size of the largest glyph in 1 bit/pixel. A nonzero value implies that 1-bit-per-pixel bitmaps are
    ///supported.
    uint cjMaxGlyph1;
    ///Specifies the size of the largest glyph in 4 bits/pixel. A nonzero value implies that 4-bit-per-pixel bitmaps are
    ///supported.
    uint cjMaxGlyph4;
    ///Specifies the size of the largest glyph in 8 bits/pixel. A nonzero value implies that 8-bit-per-pixel bitmaps are
    ///supported.
    uint cjMaxGlyph8;
    ///Specifies the size of the largest glyph in 32 bits/pixel. A nonzero value implies that 32-bit-per-pixel bitmaps
    ///are supported.
    uint cjMaxGlyph32;
}

///The PATHDATA structure describes all or part of a subpath.
struct PATHDATA
{
    ///Flags describing the data returned are defined as follows: <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
    ///<tr> <td> PD_ALL </td> <td> This flag is the ORed combination of the other flags in this table. That is, PD_ALL
    ///== PD_BEGINSUBPATH | PD_ENDSUBPATH | PD_RESETSTYLE | PD_CLOSEFIGURE | PD_BEZIERS. </td> </tr> <tr> <td>
    ///PD_BEGINSUBPATH </td> <td> The first point begins a new subpath. It is not connected to the previous subpath. If
    ///this flag is not set, the starting point for the first curve to be drawn from this data is the last point
    ///returned in the previous call. </td> </tr> <tr> <td> PD_BEZIERS </td> <td> If set, each set of three control
    ///points returned for this call describes a Bezier curve. If clear, each control point describes a line segment. A
    ///starting point for either type is either explicit at the beginning of the subpath, or implicit as the endpoint of
    ///the previous curve. </td> </tr> <tr> <td> PD_CLOSEFIGURE </td> <td> This bit is only defined if the record ends a
    ///subpath. If set, there is an implicit line segment connecting the last point of the subpath with the first point.
    ///If such a closed subpath is being stroked, joins are used all around the path, and there are no end caps. If this
    ///flag is not set, the subpath is considered open, even if the first and last points happen to coincide. In that
    ///case, end caps should be drawn. This flag is not relevant to filling because all subpaths are assumed closed when
    ///a path is filled. </td> </tr> <tr> <td> PD_ENDSUBPATH </td> <td> The last point in the array ends the subpath.
    ///This subpath can be open or closed depending on the PD_CLOSEFIGURE flag. If there is more data to be returned in
    ///the path, the next record begins a new subpath. Note that a single record might begin and end a subpath. </td>
    ///</tr> <tr> <td> PD_RESETSTYLE </td> <td> This bit is defined only if this record begins a new subpath. If set, it
    ///indicates the style state should be reset to zero at the beginning of the subpath. If not set, the style state is
    ///defined by the LINEATTRS structure, or continues from the previous subpath. </td> </tr> </table>
    uint      flags;
    ///Specifies the count of POINTFIX structures pointed to by <b>pptfx</b>.
    uint      count;
    ///Pointer to an array of POINTFIX structures that define the control points for the curves. These structures must
    ///not be modified. For a description of the POINTFIX structure, see GDI Data Types.
    POINTFIX* pptfx;
}

///The RUN structure is used to describe a linear set of pixels that is not clipped by the CLIPLINE structure.
struct RUN
{
    ///Specifies the starting point for a field of pixels to be drawn. The first pixel of the unclipped line is pixel 0.
    int iStart;
    ///Specifies the stopping point for a field of pixels to be drawn.
    int iStop;
}

///The CLIPLINE structure gives the driver access to a portion of a line between two clip regions used for drawing.
struct CLIPLINE
{
    ///Specifies a POINTFIX structure that contains the starting point of the line.
    POINTFIX ptfxA;
    ///Specifies a POINTFIX structure that contains the end point of the line.
    POINTFIX ptfxB;
    ///Is a pair of 16-bit values supplied by GDI whenever the driver calls PATHOBJ_bEnumClipLines. These two values are
    ///packed into a LONG and specify the style offset back to the first pixel of the line segment. This is the first
    ///pixel that would be rendered if the line were not clipped. This value allows the styling for the remainder of the
    ///line to be computed. Refer to Styled Cosmetic Lines for additional information.
    int      lStyleState;
    ///Specifies the number of RUN structures in the <b>arun</b> array.
    uint     c;
    ///Is an array of RUN structures. The RUN structures describe the start and stop portions of the clip line.
    RUN[1]   arun;
}

///The PERBANDINFO structure is used as input to a printer graphics DLL's DrvQueryPerBandInfo function.
struct PERBANDINFO
{
    ///If <b>TRUE</b>, GDI redraws the previous band. If <b>FALSE</b>, GDI draws the next band.
    BOOL bRepeatThisBand;
    ///Specifies a SIZEL structure that contains the width and height, in pixels, of the rectangle in which GDI can draw
    ///the band. A SIZEL structure is identical to a SIZE structure.
    SIZE szlBand;
    ///Specifies the horizontal resolution GDI should use when scaling the band.
    uint ulHorzRes;
    ///Specifies the vertical resolution GDI should use when scaling the band.
    uint ulVertRes;
}

///The GAMMARAMP structure is used by DrvIcmSetDeviceGammaRamp to set the hardware gamma ramp of a particular display
///device.
struct GAMMARAMP
{
    ///Is the 256-entry ramp for the red color channel.
    ushort[256] Red;
    ///Is the 256-entry ramp for the green color channel.
    ushort[256] Green;
    ///Is the 256-entry ramp for the blue color channel.
    ushort[256] Blue;
}

///The DEVHTINFO structure is used as input to the HTUI_DeviceColorAdjustment function.
struct DEVHTINFO
{
    ///Is a set of caller-supplied flags indicating halftone attributes. See the <b>flHTFlags</b> member of the GDIINFO
    ///structure for a complete list of possible values.
    uint      HTFlags;
    ///Is a caller-supplied value that must be one of the HTPAT_SIZE-prefixed constants defined in <i>winddi.h</i>.
    uint      HTPatternSize;
    ///For printers, specifies the number of dots per inch. See the description of the <b>ulDevicePelsDPI</b> member of
    ///the GDIINFO structure for more information. For displays, this member should be set to zero.
    uint      DevPelsDPI;
    ///Is a caller-supplied pointer to a COLORINFO structure containing halftoning color information.
    COLORINFO ColorInfo;
}

///The DEVHTADJDATA structure is used as input to the HTUI_DeviceColorAdjustment function.
struct DEVHTADJDATA
{
    ///Is a set of flags, set by the caller, describing color mixing and color versus gray-scale output. Either, both,
    ///or neither of the following flags should be set, as appropriate: <table> <tr> <th>Flag</th> <th>Definition</th>
    ///</tr> <tr> <td> DEVHTADJF_ADDITIVE_DEVICE </td> <td> <dl> <dt>If set, the device uses additive color mixing.</dt>
    ///<dt>If not set, the device uses subtractive color mixing.</dt> </dl> </td> </tr> <tr> <td> DEVHTADJF_COLOR_DEVICE
    ///</td> <td> <dl> <dt>If set, the device produces color output.</dt> <dt>If not set, the device produces
    ///gray-scaled output.</dt> </dl> </td> </tr> </table>
    uint       DeviceFlags;
    ///Is the caller-supplied horizontal resolution, in dots per inch, for the device.
    uint       DeviceXDPI;
    ///Is the caller-supplied vertical resolution, in dots per inch, for the device.
    uint       DeviceYDPI;
    ///Is a caller-supplied pointer to a DEVHTINFO structure containing the device's default halftoning properties.
    DEVHTINFO* pDefHTInfo;
    ///Is a caller-supplied pointer to a DEVHTINFO structure containing the device's current halftoning properties.
    ///Before the HTUI_DeviceColorAdjustment function returns, it modifies this structure's contents, if the user has
    ///adjusted the halftoning properties. Can be <b>NULL</b> (see the following Remarks section).
    DEVHTINFO* pAdjHTInfo;
}

///The TYPE1_FONT structure contains the information necessary for a PostScript driver to access a Type1 font through
///GDI.
struct TYPE1_FONT
{
    ///Handle to the PostScript Type1 .pfm file.
    HANDLE hPFM;
    ///Handle to the PostScript Type1 .<i>pfb</i> file.
    HANDLE hPFB;
    ///Is an identifier that is generated and used by GDI. The driver stores <b>ulIdentifier</b> in the
    ///<b>dpCharSets</b> field of the IFIMETRICS structure.
    uint   ulIdentifier;
}

///The ENGSAFESEMAPHORE structure provides the driver with a thread-safe semaphore.
struct ENGSAFESEMAPHORE
{
    ///Handle to the semaphore.
    HSEMAPHORE__* hsem;
    ///Specifies the reference count on the semaphore.
    int           lCount;
}

///The FLOATOBJ structure is used to emulate a floating-point number.
struct FLOATOBJ
{
    ///Reserved for system use.
    uint ul1;
    ///Reserved for system use.
    uint ul2;
}

///The FLOATOBJ_XFORM structure describes an arbitrary linear two-dimensional transform, such as for geometric wide
///lines.
struct FLOATOBJ_XFORM
{
    FLOATOBJ eM11;
    FLOATOBJ eM12;
    FLOATOBJ eM21;
    ///Are the four FLOATOBJ elements that comprise a 2x2 row-major matrix. The <b>eM11</b> member specifies the matrix
    ///element at row 1, column 1, the <b>eM12</b> member specifies the matrix element at row 1, column2, and so on.
    FLOATOBJ eM22;
    FLOATOBJ eDx;
    ///Are the x- and y-translation components of the transform.
    FLOATOBJ eDy;
}

///The ENG_TIME_FIELDS structure is used by the EngQueryLocalTime function to return the local time.
struct ENG_TIME_FIELDS
{
    ///Specifies the current calendar year. The range is [1601,...].
    ushort usYear;
    ///Specifies the current calendar month. The range is [1,12].
    ushort usMonth;
    ///Specifies the current calendar day. The range is [1,31].
    ushort usDay;
    ///Specifies the current hour. The range is [0,23].
    ushort usHour;
    ///Specifies the current minute. The range is [0,59].
    ushort usMinute;
    ///Specifies the current second. The range is [0,59].
    ushort usSecond;
    ///Specifies the current millisecond. The range is [0,999].
    ushort usMilliseconds;
    ///Specifies the current day. The range is [0,6], where 0 is Sunday and 6 is Saturday.
    ushort usWeekday;
}

///The video miniport driver receives a pointer to a VIDEOPARAMETERS structure in the <b>InputBuffer</b> member of a
///VIDEO_REQUEST_PACKET when the IOCTL request is IOCTL_VIDEO_HANDLE_VIDEOPARAMETERS. Depending on the <b>dwCommand</b>
///member of the VIDEOPARAMETERS structure, the miniport driver should get or set the television connector and copy
///protection capabilities of the device.
struct VIDEOPARAMETERS
{
    ///Specifies the globally unique identifier (GUID) for this structure {02C62061-1097-11d1-920F-00A024DF156E}. A
    ///video miniport driver must verify the GUID at the start of the structure before processing the structure.
    GUID       Guid;
    ///Is reserved and should be ignored by the video miniport driver.
    uint       dwOffset;
    ///Indicates the action to be performed by the driver. This member can be one of the following values:
    uint       dwCommand;
    ///Indicates which members of this structure contain valid data. When <b>dwCommand</b> is VP_COMMAND_GET, the driver
    ///should set the appropriate bits in this member to indicate in which corresponding members it has returned valid
    ///data. When <b>dwCommand</b> is VP_COMMAND_SET, the driver should set the functionality on the hardware according
    ///to values in the members that correspond with the bits set in this member. This member can be a bitwise OR of the
    ///values listed in the first column of the following table. <table> <tr> <th>Flag</th> <th>Corresponding
    ///Members</th> <th>Commands</th> </tr> <tr> <td> VP_FLAGS_BRIGHTNESS </td> <td> <b>dwBrightness</b> </td> <td>
    ///get/set </td> </tr> <tr> <td> VP_FLAGS_CONTRAST </td> <td> <b>dwContrast</b> </td> <td> get/set </td> </tr> <tr>
    ///<td> VP_FLAGS_COPYPROTECT </td> <td> <b>dwCPType</b> <b>dwCPCommand</b> <b>dwCPStandard</b> <b>dwCPKey</b>
    ///<b>bCP_APSTriggerBits</b> <b>bOEMCopyProtection</b> </td> <td> get/set set get set set get/set </td> </tr> <tr>
    ///<td> VP_FLAGS_FLICKER </td> <td> <b>dwFlickerFilter</b> </td> <td> get/set </td> </tr> <tr> <td>
    ///VP_FLAGS_MAX_UNSCALED </td> <td> <b>dwMaxUnscaledX</b> <b>dwMaxUnscaledY</b> </td> <td> get get </td> </tr> <tr>
    ///<td> VP_FLAGS_OVERSCAN </td> <td> <b>dwOverscanX</b> <b>dwOverscanY</b> </td> <td> get/set get/set </td> </tr>
    ///<tr> <td> VP_FLAGS_POSITION </td> <td> <b>dwPositionX</b> <b>dwPositionY</b> </td> <td> get/set get/set </td>
    ///</tr> <tr> <td> VP_FLAGS_TV_MODE </td> <td> <b>dwMode</b> <b>dwAvailableModes</b> </td> <td> get/set get </td>
    ///</tr> <tr> <td> VP_FLAGS_TV_STANDARD </td> <td> <b>dwTVStandard</b> <b>dwAvailableTVStandard</b> </td> <td>
    ///get/set get </td> </tr> </table>
    uint       dwFlags;
    ///Specifies the current playback mode. This member is valid for both the VP_COMMAND_SET and VP_COMMAND_GET
    ///commands, and can be one of the following values:
    uint       dwMode;
    ///Is the current world television standard. This member is valid for both the VP_COMMAND_SET and VP_COMMAND_GET
    ///commands, and can be one of the following values: VP_TV_STANDARD_NTSC_M VP_TV_STANDARD_NTSC_M_J
    ///VP_TV_STANDARD_NTSC_433 VP_TV_STANDARD_PAL_B VP_TV_STANDARD_PAL_D VP_TV_STANDARD_PAL_G VP_TV_STANDARD_PAL_H
    ///VP_TV_STANDARD_PAL_I VP_TV_STANDARD_PAL_M VP_TV_STANDARD_PAL_N VP_TV_STANDARD_PAL_60 VP_TV_STANDARD_SECAM_B
    ///VP_TV_STANDARD_SECAM_D VP_TV_STANDARD_SECAM_G VP_TV_STANDARD_SECAM_H VP_TV_STANDARD_SECAM_K
    ///VP_TV_STANDARD_SECAM_K1 VP_TV_STANDARD_SECAM_L VP_TV_STANDARD_SECAM_L1 VP_TV_STANDARD_WIN_VGA
    uint       dwTVStandard;
    ///Indicates the playback modes the device is capable of. This member is only valid for the VP_COMMAND_GET command,
    ///and can be a bitwise OR of the following values: VP_MODE_TV_PLAYBACK VP_MODE_WIN_GRAPHICS
    uint       dwAvailableModes;
    ///Specifies all available world television standards. This member is only valid for the VP_COMMAND_GET command, and
    ///can be a bitwise OR of the following values: VP_TV_STANDARD_NTSC_M VP_TV_STANDARD_NTSC_M_J
    ///VP_TV_STANDARD_NTSC_433 VP_TV_STANDARD_PAL_B VP_TV_STANDARD_PAL_D VP_TV_STANDARD_PAL_G VP_TV_STANDARD_PAL_H
    ///VP_TV_STANDARD_PAL_I VP_TV_STANDARD_PAL_M VP_TV_STANDARD_PAL_N VP_TV_STANDARD_PAL_60 VP_TV_STANDARD_SECAM_B
    ///VP_TV_STANDARD_SECAM_D VP_TV_STANDARD_SECAM_G VP_TV_STANDARD_SECAM_H VP_TV_STANDARD_SECAM_K
    ///VP_TV_STANDARD_SECAM_K1 VP_TV_STANDARD_SECAM_L VP_TV_STANDARD_SECAM_L1 VP_TV_STANDARD_WIN_VGA
    uint       dwAvailableTVStandard;
    ///Is a value in tenths of a percent that indicates the flicker filter state. This member can be a value between
    ///[0,1000], and is valid for both VP_COMMAND_GET and VP_COMMAND_SET.
    uint       dwFlickerFilter;
    ///Is a value in tenths of a percent that indicates the amount of overscan in <i>x</i>. This member can be a value
    ///between [0,1000], and is valid for both VP_COMMAND_GET and VP_COMMAND_SET.
    uint       dwOverScanX;
    ///Is a value in tenths of a percent that indicates the amount of overscan in <i>y</i>. This member can be a value
    ///between [0,1000], and is valid for both VP_COMMAND_GET and VP_COMMAND_SET.
    uint       dwOverScanY;
    ///Is the maximum <i>x</i> resolution that the TV can display without having the hardware scale the video image. The
    ///miniport driver must set a value in this member when <b>dwCommand</b> is VP_COMMAND_GET. This member is invalid
    ///for VP_COMMAND_SET.
    uint       dwMaxUnscaledX;
    ///Is the maximum <i>y</i> resolution that the TV can display without having the hardware scale the video image. The
    ///miniport driver must set a value in this member when <b>dwCommand</b> is VP_COMMAND_GET. This member is invalid
    ///for VP_COMMAND_SET.
    uint       dwMaxUnscaledY;
    ///Is the value used by the hardware to determine the current <i>x</i> position of the image on the TV. This member
    ///is specified in pixels, and is valid for both VP_COMMAND_GET and VP_COMMAND_SET.
    uint       dwPositionX;
    ///Is the value used by the hardware to determine the current <i>y</i> position of the image on the TV. This member
    ///is specified in scan lines, and is valid for both VP_COMMAND_GET and VP_COMMAND_SET.
    uint       dwPositionY;
    ///Is a percentage value that indicates the brightness setting on the TV. This member can be a value between
    ///[0,100], and is valid for both VP_COMMAND_GET and VP_COMMAND_SET.
    uint       dwBrightness;
    ///Is a percentage value that indicates the contrast setting on the TV. This member can be a value between [0,100],
    ///and is valid for both VP_COMMAND_GET and VP_COMMAND_SET.
    uint       dwContrast;
    ///Specifies the type of copy protection supported by the device. This member is valid for both the VP_COMMAND_SET
    ///and VP_COMMAND_GET commands, and can be CP_TYPE_APS_TRIGGER.
    uint       dwCPType;
    ///Is the copy protection command. This member is only valid for the VP_COMMAND_SET command, and can be one of the
    ///following values:
    uint       dwCPCommand;
    ///Is the TV standards for which copy protection types are available. This member is only valid for the
    ///VP_COMMAND_GET command, and can be a bitwise OR of the following values: VP_TV_STANDARD_NTSC_M
    ///VP_TV_STANDARD_NTSC_M_J VP_TV_STANDARD_NTSC_433 VP_TV_STANDARD_PAL_B VP_TV_STANDARD_PAL_D VP_TV_STANDARD_PAL_G
    ///VP_TV_STANDARD_PAL_H VP_TV_STANDARD_PAL_I VP_TV_STANDARD_PAL_M VP_TV_STANDARD_PAL_N VP_TV_STANDARD_PAL_60
    ///VP_TV_STANDARD_SECAM_B VP_TV_STANDARD_SECAM_D VP_TV_STANDARD_SECAM_G VP_TV_STANDARD_SECAM_H
    ///VP_TV_STANDARD_SECAM_K VP_TV_STANDARD_SECAM_K1 VP_TV_STANDARD_SECAM_L VP_TV_STANDARD_SECAM_L1
    ///VP_TV_STANDARD_WIN_VGA
    uint       dwCPStandard;
    ///Is a driver-generated copy protection key that is unique to this instance of the driver. This member is valid
    ///only for the VP_COMMAND_SET command. The miniport driver generates and returns this key when <b>dwCPCommand</b>
    ///is set to VP_CP_CMD_ACTIVATE. The caller must set this key when the <b>dwCPCommand</b> field is either
    ///VP_CP_CMD_DEACTIVATE or VP_CP_CMD_CHANGE. If the caller sets an incorrect key, the driver must not change the
    ///current copy protection settings.
    uint       dwCPKey;
    ///Specifies DVD analog protection system (APS) trigger bit data. Bits zero and 1 are valid. This member is valid
    ///only for the VP_COMMAND_SET command.
    uint       bCP_APSTriggerBits;
    ///OEM-specific copy protection data. This member is valid for both the VP_COMMAND_SET and VP_COMMAND_GET commands.
    ubyte[256] bOEMCopyProtection;
}

///The DDKERNELCAPS structure notifies the client what support, if any, exists in the miniport driver for the
///kernel-mode video transport.
struct DDKERNELCAPS
{
    ///Specifies the size, in bytes, of this structure. This member must be initialized before the structure is used.
    uint dwSize;
    ///Specifies a set of flags indicating the device's capabilities. This member can be any combination of the
    ///following capabilities: <table> <tr> <th>Flag</th> <th>Meaning</th> </tr> <tr> <td> DDKERNELCAPS_AUTOFLIP </td>
    ///<td> The driver supports the DxFlipVideoPort and the DxFlipOverlay callbacks, and that these callbacks can be
    ///used for autoflipping. </td> </tr> <tr> <td> DDKERNELCAPS_CAPTURE_INVERTED </td> <td> The device supports
    ///inverting the DIBs while capturing the data. </td> </tr> <tr> <td> DDKERNELCAPS_CAPTURE_NONLOCALVIDMEM </td> <td>
    ///The device supports a video port extensions (VPE) capture interface capable of transferring data to nonlocal
    ///display memory. </td> </tr> <tr> <td> DDKERNELCAPS_CAPTURE_SYSMEM </td> <td> The device supports a VPE capture
    ///interface capable of transferring data to system memory. </td> </tr> <tr> <td> DDKERNELCAPS_FIELDPOLARITY </td>
    ///<td> The device can report the polarity (even/odd) of the current VPE object field. </td> </tr> <tr> <td>
    ///DDKERNELCAPS_FLIPOVERLAY </td> <td> The driver supports the DxFlipOverlay callback. </td> </tr> <tr> <td>
    ///DDKERNELCAPS_FLIPVIDEOPORT </td> <td> The driver supports the DxFlipVideoPort callback. </td> </tr> <tr> <td>
    ///DDKERNELCAPS_LOCK </td> <td> The device supports accessing the frame buffer without causing contention with
    ///blitters, and so on, and that the driver supports the DxLock callback. </td> </tr> <tr> <td>
    ///DDKERNELCAPS_SETSTATE </td> <td> The driver supports the DxSetState callback, allowing a client to switch between
    ///bob and weave display modes. </td> </tr> <tr> <td> DDKERNELCAPS_SKIPFIELDS </td> <td> The device supports field
    ///skipping, either using hardware or by supporting the DxSkipNextField callback. </td> </tr> </table>
    uint dwCaps;
    ///Can be a combination of the following flags: <table> <tr> <th>Flag</th> <th>Meaning</th> </tr> <tr> <td>
    ///DDIRQ_DISPLAY_VSYNC </td> <td> The device can generate IRQs based on the display VSYNC. </td> </tr> <tr> <td>
    ///DDIRQ_VPORT0_LINE </td> <td> The device can generate IRQs based on a programmable line for hardware video port
    ///number 0. </td> </tr> <tr> <td> DDIRQ_VPORT0_VSYNC </td> <td> The device can generate VSYNC IRQs for hardware
    ///video port number 0. </td> </tr> <tr> <td> DDIRQ_VPORT1_LINE </td> <td> The device can generate IRQs based on a
    ///programmable line for hardware video port number 1. </td> </tr> <tr> <td> DDIRQ_VPORT1_VSYNC </td> <td> The
    ///device can generate V-sync IRQs for hardware video port number 1 </td> </tr> <tr> <td> DDIRQ_VPORT2_LINE </td>
    ///<td> The device can generate IRQs based on a programmable line for hardware video port number 2. </td> </tr> <tr>
    ///<td> DDIRQ_VPORT2_VSYNC </td> <td> The device can generate V-sync IRQs for hardware video port number 2. </td>
    ///</tr> <tr> <td> DDIRQ_VPORT3_LINE </td> <td> The device can generate IRQs based on a programmable line for
    ///hardware video port number 3. </td> </tr> <tr> <td> DDIRQ_VPORT3_VSYNC </td> <td> The device can generate V-sync
    ///IRQs for hardware video port number 3. </td> </tr> <tr> <td> DDIRQ_VPORT4_LINE </td> <td> The device can generate
    ///IRQs based on a programmable line for hardware video port number 4. </td> </tr> <tr> <td> DDIRQ_VPORT4_VSYNC
    ///</td> <td> The device can generate V-sync IRQs for hardware video port number 4. </td> </tr> <tr> <td>
    ///DDIRQ_VPORT5_LINE </td> <td> The device can generate IRQs based on a programmable line for hardware video port
    ///number 5. </td> </tr> <tr> <td> DDIRQ_VPORT5_VSYNC </td> <td> The device can generate V-sync IRQs for hardware
    ///video port number 5. </td> </tr> <tr> <td> DDIRQ_VPORT6_LINE </td> <td> The device can generate IRQs based on a
    ///programmable line for hardware video port number 6. </td> </tr> <tr> <td> DDIRQ_VPORT6_VSYNC </td> <td> The
    ///device can generate V-sync IRQs for hardware video port number 6. </td> </tr> <tr> <td> DDIRQ_VPORT7_LINE </td>
    ///<td> The device can generate IRQs based on a programmable line for hardware video port number 7. </td> </tr> <tr>
    ///<td> DDIRQ_VPORT7_VSYNC </td> <td> The device can generate V-sync IRQs for hardware video port number 7. </td>
    ///</tr> <tr> <td> DDIRQ_VPORT8_LINE </td> <td> The device can generate IRQs based on a programmable line for
    ///hardware video port number 8. </td> </tr> <tr> <td> DDIRQ_VPORT8_VSYNC </td> <td> The device can generate V-sync
    ///IRQs for hardware video port number 8. </td> </tr> <tr> <td> DDIRQ_VPORT9_LINE </td> <td> he device can generate
    ///IRQs based on a programmable line for hardware video port number 9. </td> </tr> <tr> <td> DDIRQ_VPORT9_VSYNC
    ///</td> <td> he device can generate V-sync IRQs for hardware video port number 9. </td> </tr> </table>
    uint dwIRQCaps;
}

///The SURFACEALIGNMENT structure is used by a display driver to describe the alignment restrictions for a surface being
///allocated by HeapVidMemAllocAligned.
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

///The HEAPALIGNMENT structure contains data specifying the alignment requirements for a given display memory heap.
struct HEAPALIGNMENT
{
    ///Specifies the size in bytes of this HEAPALIGNMENT structure.
    uint             dwSize;
    ///Specifies a DDSCAPS structure that indicates what alignment fields are valid.
    DDSCAPS          ddsCaps;
    ///Reserved for system use.
    uint             dwReserved;
    ///Specifies a SURFACEALIGNMENT structure that contains heap alignment requirements for surfaces tagged with
    ///DDSCAPS_EXECUTEBUFFER.
    SURFACEALIGNMENT ExecuteBuffer;
    ///Specifies a SURFACEALIGNMENT structure that contains heap alignment requirements for surfaces tagged with
    ///DDSCAPS_OVERLAY.
    SURFACEALIGNMENT Overlay;
    ///Specifies a SURFACEALIGNMENT structure that contains heap alignment requirements for surfaces tagged with
    ///DDSCAPS_TEXTURE.
    SURFACEALIGNMENT Texture;
    ///Specifies a SURFACEALIGNMENT structure that contains heap alignment requirements for surfaces tagged with
    ///DDSCAPS_ZBUFFER.
    SURFACEALIGNMENT ZBuffer;
    ///Specifies a SURFACEALIGNMENT structure that contains heap alignment requirements for surfaces tagged with
    ///DDSCAPS_ALPHA.
    SURFACEALIGNMENT AlphaBuffer;
    ///Specifies a SURFACEALIGNMENT structure that contains heap alignment requirements for surfaces tagged with
    ///DDSCAPS_OFFSCREENPLAIN.
    SURFACEALIGNMENT Offscreen;
    ///Specifies a SURFACEALIGNMENT structure that contains heap alignment requirements for surfaces tagged with
    ///DDSCAPS_FLIP.
    SURFACEALIGNMENT FlipTarget;
}

///The VMEMHEAP structure contains information about the heap.
struct VMEMHEAP
{
    ///Reserved for system use and should be ignored by the driver.
    uint          dwFlags;
    ///Reserved for system use and should be ignored by the driver.
    uint          stride;
    ///Reserved for system use and should be ignored by the driver.
    void*         freeList;
    ///Reserved for system use and should be ignored by the driver.
    void*         allocList;
    ///Reserved for system use and should be ignored by the driver.
    uint          dwTotalSize;
    ///Points to the linear graphic address remapping table (GART) address of the start of the heap for nonlocal display
    ///memory.
    size_t        fpGARTLin;
    ///Points to the physical GART address of the start of the heap for nonlocal display memory.
    size_t        fpGARTDev;
    ///Reserved for system use and should be ignored by the driver.
    uint          dwCommitedSize;
    ///Reserved for system use and should be ignored by the driver.
    uint          dwCoalesceCount;
    ///Reserved for system use and should be ignored by the driver.
    HEAPALIGNMENT Alignment;
    ///Reserved for system use and should be ignored by the driver.
    DDSCAPSEX     ddsCapsEx;
    ///Reserved for system use and should be ignored by the driver.
    DDSCAPSEX     ddsCapsExAlt;
    ///Reserved for system use and should be ignored by the driver.
    LARGE_INTEGER liPhysAGPBase;
    ///Reserved for system use and should be ignored by the driver.
    HANDLE        hdevAGP;
    ///Reserved for system use and should be ignored by the driver.
    void*         pvPhysRsrv;
    ///Reserved for system use and should be ignored by the driver.
    ubyte*        pAgpCommitMask;
    uint          dwAgpCommitMaskSize;
}

///The DDCORECAPS structure specifies the core capabilities of the Microsoft DirectDraw driver and its device, which are
///exposed to an application through the DirectDraw object.
struct DDCORECAPS
{
    ///Specifies the size in bytes of this DDCORECAPS structure.
    uint    dwSize;
    ///Indicates a flag that specifies the driver's capabilities. The driver should set the appropriate
    ///DDCAPS_<i>Xxx</i> bit for every capability that it supports. <table> <tr> <th>Flag</th> <th>Meaning</th> </tr>
    ///<tr> <td> DDCAPS_3D </td> <td> The display hardware has 3D acceleration. </td> </tr> <tr> <td>
    ///DDCAPS_ALIGNBOUNDARYDEST </td> <td> DirectDraw supports only those source rectangles with the x-axis aligned to
    ///the <b>dwAlignBoundaryDest</b> boundaries of the surface. </td> </tr> <tr> <td> DDCAPS_ALIGNBOUNDARYSRC </td>
    ///<td> DirectDraw supports only those source rectangles with the x-axis aligned to the <b>dwAlignBoundarySrc</b>
    ///boundaries of the surface. </td> </tr> <tr> <td> DDCAPS_ALIGNSIZEDEST </td> <td> DirectDraw supports only those
    ///source rectangles whose x-axis sizes, in bytes, are <b>dwAlignSizeDest</b> multiples. </td> </tr> <tr> <td>
    ///DDCAPS_ALIGNSIZESRC </td> <td> DirectDraw supports only those source rectangles whose x-axis sizes, in bytes, are
    ///<b>dwAlignSizeSrc</b> multiples. </td> </tr> <tr> <td> DDCAPS_ALIGNSTRIDE </td> <td> DirectDraw creates display
    ///memory surfaces that have a stride alignment equal to the <b>dwAlignStrideAlign</b> value. </td> </tr> <tr> <td>
    ///DDCAPS_ALPHA </td> <td> The display hardware supports an alpha channel during blit operations. </td> </tr> <tr>
    ///<td> DDCAPS_BANKSWITCHED </td> <td> The display hardware is bank-switched and is potentially very slow at random
    ///access to display memory. If this capability bit is set by the Microsoft Windows 2000 or later driver, DirectDraw
    ///is disabled. </td> </tr> <tr> <td> DDCAPS_BLT </td> <td> The display hardware is capable of blit operations.
    ///</td> </tr> <tr> <td> DDCAPS_BLTCOLORFILL </td> <td> The display hardware is capable of color filling with a
    ///blitter. </td> </tr> <tr> <td> DDCAPS_BLTDEPTHFILL </td> <td> The display hardware is capable of depth filling
    ///z-buffers with a blitter. </td> </tr> <tr> <td> DDCAPS_BLTFOURCC </td> <td> The display hardware is capable of
    ///color-space conversions during blit operations. </td> </tr> <tr> <td> DDCAPS_BLTQUEUE </td> <td> The display
    ///hardware is capable of asynchronous blit operations. </td> </tr> <tr> <td> DDCAPS_BLTSTRETCH </td> <td> The
    ///display hardware is capable of stretching during blit operations. </td> </tr> <tr> <td> DDCAPS_CANBLTSYSMEM </td>
    ///<td> The display hardware is capable of blitting to or from system memory. </td> </tr> <tr> <td> DDCAPS_CANCLIP
    ///</td> <td> The display hardware is capable of clipping with blitting. </td> </tr> <tr> <td>
    ///DDCAPS_CANCLIPSTRETCHED </td> <td> The display hardware is capable of clipping while stretch-blitting. </td>
    ///</tr> <tr> <td> DDCAPS_COLORKEY </td> <td> Some form of color key in either overlay or blit operations is
    ///supported. More specific color key capability information can be found in the <b>dwCKeyCaps</b> member. </td>
    ///</tr> <tr> <td> DDCAPS_COLORKEYHWASSIST </td> <td> The color key is hardware assisted. </td> </tr> <tr> <td>
    ///DDCAPS_GDI </td> <td> The display hardware is shared with GDI. If this capability bit is set by the Windows 2000
    ///or later driver, DirectDraw is disabled. </td> </tr> <tr> <td> DDCAPS_NOHARDWARE </td> <td> No hardware support
    ///exists. </td> </tr> <tr> <td> DDCAPS_OVERLAY </td> <td> The display hardware supports overlays. </td> </tr> <tr>
    ///<td> DDCAPS_OVERLAYCANTCLIP </td> <td> The display hardware supports overlays but cannot clip them. </td> </tr>
    ///<tr> <td> DDCAPS_OVERLAYFOURCC </td> <td> The overlay hardware is capable of color-space conversions during
    ///overlay operations. </td> </tr> <tr> <td> DDCAPS_OVERLAYSTRETCH </td> <td> The overlay hardware is capable of
    ///stretching. </td> </tr> <tr> <td> DDCAPS_PALETTE </td> <td> DirectDraw is capable of creating and supporting
    ///DirectDrawPalette objects for more than just the primary surface. If this capability bit is set by the Windows
    ///2000 or later driver, DirectDraw is disabled. </td> </tr> <tr> <td> DDCAPS_PALETTEVSYNC </td> <td> DirectDraw is
    ///capable of updating a palette synchronized with the vertical refresh. </td> </tr> <tr> <td> DDCAPS_READSCANLINE
    ///</td> <td> The display hardware is capable of returning the current scan line. </td> </tr> <tr> <td>
    ///DDCAPS_STEREOVIEW </td> <td> The display hardware has stereo vision capabilities. </td> </tr> <tr> <td>
    ///DDCAPS_VBI </td> <td> The display hardware is capable of generating a vertical-blank interrupt. </td> </tr> <tr>
    ///<td> DDCAPS_ZBLTS </td> <td> Supports the use of z-buffers with blit operations. </td> </tr> <tr> <td>
    ///DDCAPS_ZOVERLAYS </td> <td> Supports the use of the application's <b>UpdateOverlayZOrder</b> method as a z-value
    ///for overlays to control their layering. If this capability bit is set by the Windows 2000 or later driver,
    ///DirectDraw is disabled. </td> </tr> </table>
    uint    dwCaps;
    ///Specify more of the driver's capabilities. The driver should set the appropriate DDCAPS2_<i>Xxx</i> bit for every
    ///capability that it supports. <table> <tr> <th>Flag</th> <th>Meaning</th> </tr> <tr> <td> DDCAPS2_AUTOFLIPOVERLAY
    ///</td> <td> The overlay can be automatically flipped to the next surface in the flip chain each time a hardware
    ///video port V-sync occurs, allowing the video port extensions (VPE) object and the overlay to double buffer the
    ///video without CPU overhead. This option is only valid when the surface is receiving data from hardware video
    ///port. If the hardware video port data is noninterlaced or noninterleaved, it flips on every V-sync. If the data
    ///is being interleaved in memory, it flips on every other V-sync. </td> </tr> <tr> <td> DDCAPS2_CANAUTOGENMIPMAP
    ///</td> <td> <dl> <dt><b>DirectX 9.0 and later versions only.</b></dt> <dt>The driver and its device support
    ///automatically regenerating the sublevels of mipmap textures.</dt> </dl> </td> </tr> <tr> <td>
    ///DDCAPS2_CANBOBHARDWARE </td> <td> The overlay hardware can display each field of an interlaced video stream
    ///individually. </td> </tr> <tr> <td> DDCAPS2_CANBOBINTERLEAVED </td> <td> The overlay hardware can display each
    ///field of an interlaced video stream individually while it is interleaved in memory without causing any artifacts
    ///that might normally occur without special hardware support. This option is only valid when the surface is
    ///receiving data from a VPE object and is only valid when the video is zoomed at least 200 percent in the vertical
    ///direction. </td> </tr> <tr> <td> DDCAPS2_CANBOBNONINTERLEAVED </td> <td> The overlay hardware can display each
    ///field of an interlaced video stream individually while it is not interleaved in memory without causing any
    ///artifacts that might normally occur without special hardware support. This option is only valid when the surface
    ///is receiving data from a VPE object and is only valid when the video is zoomed at least 200 percent in the
    ///vertical direction. </td> </tr> <tr> <td> DDCAPS2_CANCALIBRATEGAMMA </td> <td> A calibrator is available to
    ///adjust the gamma ramp according to the physical display properties so that the result is identical on all
    ///calibrated systems. </td> </tr> <tr> <td> DDCAPS2_CANDROPZ16BIT </td> <td> Sixteen-bit RGBZ values can be
    ///converted into 16-bit RGB values. (The system does not support eight-bit conversions.) </td> </tr> <tr> <td>
    ///DDCAPS2_CANFLIPODDEVEN </td> <td> The driver supports bob using software without using a VPE object. </td> </tr>
    ///<tr> <td> DDCAPS2_CANMANAGERESOURCE </td> <td> The driver supports managing resources. </td> </tr> <tr> <td>
    ///DDCAPS2_CANMANAGETEXTURE </td> <td> The driver supports managing textures. </td> </tr> <tr> <td>
    ///DDCAPS2_CANRENDERWINDOWED </td> <td> The driver can render in windowed mode. </td> </tr> <tr> <td>
    ///DDCAPS2_CERTIFIED </td> <td> The display hardware is certified. </td> </tr> <tr> <td> DDCAPS2_COLORCONTROLOVERLAY
    ///</td> <td> The overlay surface contains color controls (brightness, sharpness, and so on). </td> </tr> <tr> <td>
    ///DDCAPS2_COLORCONTROLPRIMARY </td> <td> The primary surface contains color controls (gamma, and so on). </td>
    ///</tr> <tr> <td> DDCAPS2_COPYFOURCC </td> <td> The driver supports blitting any FOURCC surface to another surface
    ///of the same FOURCC. </td> </tr> <tr> <td> DDCAPS2_FLIPINTERVAL </td> <td> The driver responds to the
    ///DDFLIP_INTERVAL2, DDFLIP_INTERVAL3, and DDFLIP_INTERVAL4 flags. </td> </tr> <tr> <td> DDCAPS2_FLIPNOVSYNC </td>
    ///<td> The driver responds to DDFLIP_FLIPNOVSYNC. </td> </tr> <tr> <td> DDCAPS2_NO2DDURING3DSCENE </td> <td> The
    ///driver cannot interleave 2D operations such as DdBlt or DdLock on any surfaces that Microsoft Direct3D is using
    ///between calls to the <b>IDirect3DDevice::BeginScene</b> and <b>IDirect3DDevice::EndScene</b> methods. </td> </tr>
    ///<tr> <td> DDCAPS2_NONLOCALVIDMEM </td> <td> The driver supports nonlocal display memory. </td> </tr> <tr> <td>
    ///DDCAPS2_NONLOCALVIDMEMCAPS </td> <td> Blit capabilities for nonlocal display memory surfaces differ from local
    ///display memory surfaces. If this flag is present, the DDCAPS2_NONLOCALVIDMEM flag is also present. </td> </tr>
    ///<tr> <td> DDCAPS2_NOPAGELOCKREQUIRED </td> <td> The driver should be called for blits involving system memory
    ///surfaces even if the system memory surfaces are not pagelocked. </td> </tr> <tr> <td> DDCAPS2_PRIMARYGAMMA </td>
    ///<td> The driver supports loadable gamma ramps for the primary surface. </td> </tr> <tr> <td> DDCAPS2_VIDEOPORT
    ///</td> <td> The display hardware contains a hardware video port. </td> </tr> <tr> <td> DDCAPS2_WIDESURFACES </td>
    ///<td> The display driver can create surfaces wider than the primary surface. Drivers that set this bit should
    ///expect to receive <b>CreateSurface</b> requests from applications for surfaces wider than the primary surface.
    ///</td> </tr> </table>
    uint    dwCaps2;
    ///Specify the color key capabilities of surfaces. The driver should set the appropriate DDCKEYCAPS_<i>Xxx</i> bit
    ///for every capability that it supports. <table> <tr> <th>Flag</th> <th>Meaning</th> </tr> <tr> <td>
    ///DDCKEYCAPS_DESTBLT </td> <td> Supports transparent blitting with a color key that identifies the replaceable bits
    ///of the destination surface for RGB colors. </td> </tr> <tr> <td> DDCKEYCAPS_DESTBLTCLRSPACE </td> <td> Supports
    ///transparent blitting with a color space that identifies the replaceable bits of the destination surface for RGB
    ///colors. </td> </tr> <tr> <td> DDCKEYCAPS_DESTBLTCLRSPACEYUV </td> <td> Supports transparent blitting with a color
    ///space that identifies the replaceable bits of the destination surface for YUV colors. </td> </tr> <tr> <td>
    ///DDCKEYCAPS_DESTBLTYUV </td> <td> Supports transparent blitting with a color key that identifies the replaceable
    ///bits of the destination surface for YUV colors. </td> </tr> <tr> <td> DDCKEYCAPS_DESTOVERLAY </td> <td> Supports
    ///overlaying with color keying of the replaceable bits of the destination surface being overlaid for RGB colors.
    ///</td> </tr> <tr> <td> DDCKEYCAPS_DESTOVERLAYCLRSPACE </td> <td> Supports a color space as the color key for the
    ///destination of RGB colors. </td> </tr> <tr> <td> DDCKEYCAPS_DESTOVERLAYCLRSPACEYUV </td> <td> Supports a color
    ///space as the color key for the destination of YUV colors. </td> </tr> <tr> <td> DDCKEYCAPS_DESTOVERLAYONEACTIVE
    ///</td> <td> Supports only one active destination color key value for visible overlay surfaces. </td> </tr> <tr>
    ///<td> DDCKEYCAPS_DESTOVERLAYYUV </td> <td> Supports overlaying using color keying of the replaceable bits of the
    ///destination surface being overlaid for YUV colors. </td> </tr> <tr> <td> DDCKEYCAPS_NOCOSTOVERLAY </td> <td>
    ///Indicates that there are no bandwidth tradeoffs for using the color key with an overlay. </td> </tr> <tr> <td>
    ///DDCKEYCAPS_SRCBLT </td> <td> Supports transparent blitting using the color key for the source with this surface
    ///for RGB colors. </td> </tr> <tr> <td> DDCKEYCAPS_SRCBLTCLRSPACE </td> <td> Supports transparent blitting using a
    ///color space for the source with this surface for RGB colors. </td> </tr> <tr> <td> DDCKEYCAPS_SRCBLTCLRSPACEYUV
    ///</td> <td> Supports transparent blitting using a color space for the source with this surface for YUV colors.
    ///</td> </tr> <tr> <td> DDCKEYCAPS_SRCBLTYUV </td> <td> Supports transparent blitting using the color key for the
    ///source with this surface for YUV colors. </td> </tr> <tr> <td> DDCKEYCAPS_SRCOVERLAY </td> <td> Supports
    ///overlaying using the color key for the source with this overlay surface for RGB colors. </td> </tr> <tr> <td>
    ///DDCKEYCAPS_SRCOVERLAYCLRSPACE </td> <td> Supports overlaying using a color space as the source color key for the
    ///overlay surface for RGB colors. </td> </tr> <tr> <td> DDCKEYCAPS_SRCOVERLAYCLRSPACEYUV </td> <td> Supports
    ///overlaying using a color space as the source color key for the overlay surface for YUV colors. </td> </tr> <tr>
    ///<td> DDCKEYCAPS_SRCOVERLAYONEACTIVE </td> <td> Supports only one active source color key value for visible
    ///overlay surfaces. </td> </tr> <tr> <td> DDCKEYCAPS_SRCOVERLAYYUV </td> <td> Supports overlaying using the color
    ///key for the source with this overlay surface for YUV colors. </td> </tr> </table>
    uint    dwCKeyCaps;
    ///Specify the driver's stretching and effects capabilities. The driver should set the appropriate
    ///DDFXCAPS_<i>Xxx</i> bit for every capability that it supports. <table> <tr> <th>Flag</th> <th>Meaning</th> </tr>
    ///<tr> <td> DDFXCAPS_BLTARITHSTRETCHY </td> <td> Uses arithmetic operations, rather than pixel-doubling techniques,
    ///to stretch and shrink surfaces during a blit operation. Occurs along the y-axis (vertically). </td> </tr> <tr>
    ///<td> DDFXCAPS_BLTARITHSTRETCHYN </td> <td> Uses arithmetic operations, rather than pixel-doubling techniques, to
    ///stretch and shrink surfaces during a blit operation. Occurs along the y-axis (vertically), and works only for
    ///integer stretching (x1, x2, and so on). </td> </tr> <tr> <td> DDFXCAPS_BLTMIRRORLEFTRIGHT </td> <td> Supports
    ///mirroring left to right in a blit operation. </td> </tr> <tr> <td> DDFXCAPS_BLTMIRRORUPDOWN </td> <td> Supports
    ///mirroring top to bottom in a blit operation. </td> </tr> <tr> <td> DDFXCAPS_BLTROTATION </td> <td> Supports
    ///arbitrary rotation in a blit operation. If this capability bit is set by the Windows 2000 or later driver,
    ///DirectDraw is disabled. </td> </tr> <tr> <td> DDFXCAPS_BLTROTATION90 </td> <td> Supports 90-degree rotations in a
    ///blit operation. If this capability bit is set by the Windows 2000 or later driver, DirectDraw is disabled. </td>
    ///</tr> <tr> <td> DDFXCAPS_BLTSHRINKX </td> <td> Supports arbitrary shrinking of a surface along the x-axis
    ///(horizontally). This flag is valid only for blit operations. </td> </tr> <tr> <td> DDFXCAPS_BLTSHRINKXN </td>
    ///<td> Supports integer shrinking (x1, x2, and so on) of a surface along the x-axis (horizontally). This flag is
    ///valid only for blit operations. </td> </tr> <tr> <td> DDFXCAPS_BLTSHRINKY </td> <td> Supports arbitrary shrinking
    ///of a surface along the y-axis (vertically). This flag is valid only for blit operations. </td> </tr> <tr> <td>
    ///DDFXCAPS_BLTSHRINKYN </td> <td> Supports integer shrinking (x1, x2, and so on) of a surface along the y-axis
    ///(vertically). This flag is valid only for blit operations. </td> </tr> <tr> <td> DDFXCAPS_BLTSTRETCHX </td> <td>
    ///Supports arbitrary stretching of a surface along the x-axis (horizontally). This flag is valid only for blit
    ///operations. </td> </tr> <tr> <td> DDFXCAPS_BLTSTRETCHXN </td> <td> Supports integer stretching (x1, x2, and so
    ///on) of a surface along the x-axis (horizontally). This flag is valid only for blit operations. </td> </tr> <tr>
    ///<td> DDFXCAPS_BLTSTRETCHY </td> <td> Supports arbitrary stretching of a surface along the y-axis (vertically).
    ///This flag is valid only for blit operations. </td> </tr> <tr> <td> DDFXCAPS_BLTSTRETCHYN </td> <td> Supports
    ///integer stretching (x1, x2, and so on) of a surface along the y-axis (vertically). This flag is valid only for
    ///blit operations. </td> </tr> <tr> <td> DDFXCAPS_OVERLAYARITHSTRETCHY </td> <td> Uses arithmetic operations,
    ///rather than pixel-doubling techniques, to stretch and shrink surfaces during an overlay operation. Occurs along
    ///the y-axis (vertically). </td> </tr> <tr> <td> DDFXCAPS_OVERLAYARITHSTRETCHYN </td> <td> Uses arithmetic
    ///operations, rather than pixel-doubling techniques, to stretch and shrink surfaces during an overlay operation.
    ///Occurs along the y-axis (vertically), and works only for integer stretching (x1, x2, and so on). </td> </tr> <tr>
    ///<td> DDFXCAPS_OVERLAYMIRRORLEFTRIGHT </td> <td> Supports mirroring of overlays around the vertical axis. </td>
    ///</tr> <tr> <td> DDFXCAPS_OVERLAYMIRRORUPDOWN </td> <td> Supports mirroring of overlays across the horizontal
    ///axis. </td> </tr> <tr> <td> DDFXCAPS_OVERLAYSHRINKX </td> <td> Supports arbitrary shrinking of a surface along
    ///the x-axis (horizontally). This flag is valid only for DDSCAPS_OVERLAY surfaces. This flag indicates only the
    ///capabilities of a surface; it does not indicate that shrinking is available. </td> </tr> <tr> <td>
    ///DDFXCAPS_OVERLAYSHRINKXN </td> <td> Supports integer shrinking (x1, x2, and so on) of a surface along the x-axis
    ///(horizontally). This flag is valid only for DDSCAPS_OVERLAY surfaces. This flag indicates only the capabilities
    ///of a surface; it does not indicate that shrinking is available. </td> </tr> <tr> <td> DDFXCAPS_OVERLAYSHRINKY
    ///</td> <td> Supports arbitrary shrinking of a surface along the y-axis (vertically). This flag is valid only for
    ///DDSCAPS_OVERLAY surfaces. This flag indicates only the capabilities of a surface; it does not indicate that
    ///shrinking is available. </td> </tr> <tr> <td> DDFXCAPS_OVERLAYSHRINKYN </td> <td> Supports integer shrinking (x1,
    ///x2, and so on) of a surface along the y-axis (vertically). This flag is valid only for DDSCAPS_OVERLAY surfaces.
    ///This flag indicates only the capabilities of a surface; it does not indicate that shrinking is available. </td>
    ///</tr> <tr> <td> DDFXCAPS_OVERLAYSTRETCHX </td> <td> Supports arbitrary stretching of a surface along the x-axis
    ///(horizontally). This flag is valid only for DDSCAPS_OVERLAY surfaces. This flag indicates only the capabilities
    ///of a surface; it does not indicate that stretching is available. </td> </tr> <tr> <td> DDFXCAPS_OVERLAYSTRETCHXN
    ///</td> <td> Supports integer stretching (x1, x2, and so on) of a surface along the x-axis (horizontally). This
    ///flag is valid only for DDSCAPS_OVERLAY surfaces. This flag indicates only the capabilities of a surface; it does
    ///not indicate that stretching is available. </td> </tr> <tr> <td> DDFXCAPS_OVERLAYSTRETCHY </td> <td> Supports
    ///arbitrary stretching of a surface along the y-axis (vertically). This flag is valid only for DDSCAPS_OVERLAY
    ///surfaces. This flag indicates only the capabilities of a surface; it does not indicate that stretching is
    ///available. </td> </tr> <tr> <td> DDFXCAPS_OVERLAYSTRETCHYN </td> <td> Supports integer stretching (x1, x2, and so
    ///on) of a surface along the y-axis (vertically). This flag is valid only for DDSCAPS_OVERLAY surfaces. This flag
    ///indicates only the capabilities of a surface; it does not indicate that stretching is available. </td> </tr>
    ///</table>
    uint    dwFXCaps;
    ///This member and its flags are obsolete and should not be used by the driver.
    uint    dwFXAlphaCaps;
    ///Specify the driver's palette capabilities. The driver should set the appropriate DDPCAPS_<i>Xxx</i> bit for every
    ///capability that it supports. The DDPCAPS_<i>Xxx</i> flags are defined in <i>ddraw.h</i>. The DirectDraw runtime
    ///currently ignores these capabilities.
    uint    dwPalCaps;
    ///Specify the driver's stereo vision capabilities. The driver should set the appropriate DDSVCAPS_<i>Xxx</i> bit
    ///for every capability that it supports. <table> <tr> <th>Flag</th> <th>Meaning</th> </tr> <tr> <td>
    ///DDSVCAPS_ENIGMA </td> <td> The stereo view is accomplished using Enigma encoding. </td> </tr> <tr> <td>
    ///DDSVCAPS_FLICKER </td> <td> The stereo view is accomplished using high-frequency flickering. </td> </tr> <tr>
    ///<td> DDSVCAPS_REDBLUE </td> <td> The stereo view is accomplished when the viewer looks at the image through red
    ///and blue filters placed over the left and right eyes. All images must adapt their color spaces for this process.
    ///</td> </tr> <tr> <td> DDSVCAPS_SPLIT </td> <td> The stereo view is accomplished with split-screen technology.
    ///</td> </tr> </table>
    uint    dwSVCaps;
    ///Reserved for system use. The driver should ignore this member.
    uint    dwAlphaBltConstBitDepths;
    ///Reserved for system use. The driver should ignore this member.
    uint    dwAlphaBltPixelBitDepths;
    ///Reserved for system use. The driver should ignore this member.
    uint    dwAlphaBltSurfaceBitDepths;
    ///Reserved for system use. The driver should ignore this member.
    uint    dwAlphaOverlayConstBitDepths;
    ///Reserved for system use. The driver should ignore this member.
    uint    dwAlphaOverlayPixelBitDepths;
    ///Reserved for system use. The driver should ignore this member.
    uint    dwAlphaOverlaySurfaceBitDepths;
    ///Indicates a flag that specifies the Z buffer depths supported by the driver. This can be one or more of the
    ///following values: <table> <tr> <th>Flag</th> <th>Meaning</th> </tr> <tr> <td> DDBD_8 </td> <td> The driver
    ///supports an 8bpp depth buffer. </td> </tr> <tr> <td> DDBD_16 </td> <td> The driver supports a 16bpp depth buffer.
    ///</td> </tr> <tr> <td> DDBD_24 </td> <td> The driver supports a 24bpp depth buffer. </td> </tr> <tr> <td> DDBD_32
    ///</td> <td> The driver supports a 32bpp depth buffer. </td> </tr> </table>
    uint    dwZBufferBitDepths;
    ///Specifies the total amount of display memory, in bytes.
    uint    dwVidMemTotal;
    ///Specifies the number of bytes of free display memory. The driver sets this member once during initialization to
    ///the same value it returns in the <b>dwVidMemTotal</b> member. DirectDraw updates it every time the application
    ///does a memory allocation.
    uint    dwVidMemFree;
    ///Specifies the maximum number of visible overlays.
    uint    dwMaxVisibleOverlays;
    ///Specifies the current number of visible overlays.
    uint    dwCurrVisibleOverlays;
    ///Specifies the number of FOURCC codes that the driver supports.
    uint    dwNumFourCCCodes;
    ///Specifies the source rectangle alignment. This member can be optionally set by the driver. If the driver sets
    ///this member, then the overlay source rectangle's top left coordinate value must be a multiple of
    ///<b>dwAlignBoundarySrc</b>.
    uint    dwAlignBoundarySrc;
    ///Specifies the size of the source rectangle, in bytes. This member can be optionally set by the driver. If the
    ///driver sets this member, then the overlay source rectangle's width must be a multiple of <b>dwAlignSizeSrc</b>.
    uint    dwAlignSizeSrc;
    ///Specifies the destination rectangle alignment. This member can be optionally set by the driver. If the driver
    ///sets this member, then the overlay destination rectangle's top left coordinate value must be a multiple of
    ///<b>dwAlignBoundaryDest</b>.
    uint    dwAlignBoundaryDest;
    ///Specifies the destination rectangle byte size. This member can be optionally set by the driver. If the driver
    ///sets this member, then the overlay destination rectangle's width must be a multiple of <b>dwAlignSizeDest</b>.
    uint    dwAlignSizeDest;
    ///Reserved for system use and should be ignored by the driver.
    uint    dwAlignStrideAlign;
    ///Specifies an array of DD_ROP_SPACE DWORDs that together can hold flags to indicate the ROPs that the driver
    ///supports. The driver should set the bitfield for every corresponding ROP that it supports. See the Microsoft
    ///Windows SDK documentation for information about ROPs.
    uint[8] dwRops;
    ///Specifies a DDSCAPS structure that describes the types of surfaces the driver supports.
    DDSCAPS ddsCaps;
    ///Specifies the minimum overlay stretch factor multiplied by 1000. For example, a factor of 1.3 should be stored as
    ///1300. The display driver must set the minimum factor to the actual minimum to which the graphics hardware can
    ///shrink the overlay. If the graphics hardware has no minimum limitation, set to 1.
    uint    dwMinOverlayStretch;
    ///Specifies the maximum overlay stretch factor multiplied by 1000. For example, a factor of 1.3 should be stored as
    ///1300. The display driver must set the maximum factor to the actual maximum to which the graphics hardware can
    ///stretch the overlay. If the graphics hardware has no maximum limitation, set to 32000.
    uint    dwMaxOverlayStretch;
    ///Specifies the minimum live video stretch factor multiplied by 1000. For example, a factor of 1.3 should be stored
    ///as 1300.
    uint    dwMinLiveVideoStretch;
    ///Specifies the maximum live video stretch factor multiplied by 1000. For example, a factor of 1.3 should be stored
    ///as 1300.
    uint    dwMaxLiveVideoStretch;
    ///Specifies the minimum hardware codec stretch factor multiplied by 1000. For example, a factor of 1.3 should be
    ///stored as 1300.
    uint    dwMinHwCodecStretch;
    ///Specifies the maximum hardware codec stretch factor multiplied by 1000. For example, a factor of 1.3 should be
    ///stored as 1300.
    uint    dwMaxHwCodecStretch;
    ///Reserved for system use. The driver should ignore this member.
    uint    dwReserved1;
    ///Reserved for system use. The driver should ignore this member.
    uint    dwReserved2;
    ///Reserved for system use. The driver should ignore this member.
    uint    dwReserved3;
    ///Indicates a set of flags that specify the driver-specific capabilities for system-memory-to-display-memory blits.
    ///The driver should bitwise OR the appropriate DDCAPS_<i>Xxx</i> flags (see the <b>dwCaps</b> member) to indicate
    ///the types of blit operations it supports when blitting from system memory to display memory.
    uint    dwSVBCaps;
    ///Indicates a set of flags that specify driver color-key capabilities for system-memory-to-display-memory blits.
    ///The driver should bitwise OR the appropriate DDCKEYCAPS_<i>Xxx</i> flags (see the <b>dwCKeyCaps</b> member) to
    ///indicate the types of color key operations it supports when blitting from system memory to display memory.
    uint    dwSVBCKeyCaps;
    ///Indicates a set of flags that specify driver FX capabilities for system-memory-to-display-memory blits. The
    ///driver should bitwise OR the appropriate DDFXCAPS_<i>Xxx</i> flags (see the <b>dwFXCaps</b> member) to indicate
    ///the types of effects it supports when blitting from system memory to display memory.
    uint    dwSVBFXCaps;
    ///Specifies an array of DD_ROP_SPACE DWORDs that together can hold flags to indicate the ROPs that the driver
    ///supports when performing system-memory-to-display-memory blits. The driver should set the bitfield for every
    ///corresponding ROP that it supports. See the Microsoft Windows SDK documentation for information about ROPs.
    uint[8] dwSVBRops;
    ///Indicates a set of flags that specify driver-specific capabilities for display-memory-to-system-memory blits. The
    ///driver should bitwise OR the appropriate DDCAPS_<i>Xxx</i> flags (see the <b>dwCaps</b> member) to indicate the
    ///types of blit operations it supports when blitting from display memory to system memory.
    uint    dwVSBCaps;
    ///Indicates a set of flags that specify driver color-key capabilities for display-memory-to-system-memory blits.
    ///The driver should bitwise OR the appropriate DDCKEYCAPS_<i>Xxx</i> flags (see the <b>dwCKeyCaps</b> member) to
    ///indicate the types of color key operations it supports when blitting from display memory to system memory.
    uint    dwVSBCKeyCaps;
    ///Indicates a set of flags that specify driver FX capabilities for display-memory-to-system-memory blits. The
    ///driver should bitwise OR the appropriate DDFXCAPS_<i>Xxx</i> flags (see the <b>dwFXCaps</b> member) to indicate
    ///the types of effects it supports when blitting from display memory to system memory.
    uint    dwVSBFXCaps;
    ///Specifies an array of DD_ROP_SPACE DWORDs that together can hold flags to indicate the ROPs that the driver
    ///supports when performing display-memory-to-system-memory blits. The driver should set the bitfield for every
    ///corresponding ROP that it supports. See the Windows SDK documentation for information about ROPs.
    uint[8] dwVSBRops;
    ///Indicates a set of flags that specify driver-specific capabilities for system-memory-to-system-memory blits. The
    ///driver should bitwise OR the appropriate DDCAPS_<i>Xxx</i> flags (see the <b>dwCaps</b> member) to indicate the
    ///types of blit operations it supports when blitting from system memory to system memory.
    uint    dwSSBCaps;
    ///Indicates a set of flags that specify driver color-key capabilities for system-memory-to-system-memory blits. The
    ///driver should bitwise OR the appropriate DDCKEYCAPS_<i>Xxx</i> flags (see the <b>dwCKeyCaps</b> member) to
    ///indicate the types of color key operations it supports when blitting from system memory to system memory.
    uint    dwSSBCKeyCaps;
    ///Indicates a set of flags that specify driver FX capabilities for system-memory-to-system-memory blits. The driver
    ///should bitwise OR the appropriate DDFXCAPS_<i>Xxx</i> flags (see the <b>dwFXCaps</b> member) to indicate the
    ///types of effects it supports when blitting from system memory to system memory.
    uint    dwSSBFXCaps;
    ///Specifies an array of DD_ROP_SPACE DWORDs that together can hold flags to indicate the ROPs that the driver
    ///supports when performing system-memory-to-system-memory blits. The driver should set the bitfield for every
    ///corresponding ROP that it supports. See the Windows SDK documentation for information about ROPs.
    uint[8] dwSSBRops;
    ///Specifies the maximum number of usable VPE objects.
    uint    dwMaxVideoPorts;
    ///Specifies the current number of VPE objects used. The driver does not need to fill in this member because it is
    ///set by DirectDraw.
    uint    dwCurrVideoPorts;
    ///Specifies additional driver-specific capabilities for system-memory-to-display-memory blits. Valid flags are
    ///identical to the blit-related flags used with the <b>dwCaps2</b> member.
    uint    dwSVBCaps2;
}

///The DD_WAITFORVERTICALBLANKDATA structure contains information necessary to obtain the monitor's vertical blank
///information.
struct DDHAL_WAITFORVERTICALBLANKDATA
{
    ///Points to a DD_DIRECTDRAW_GLOBAL structure that describes the driver's device.
    DDRAWI_DIRECTDRAW_GBL* lpDD;
    ///Specifies how the driver should wait for the vertical blank. This member can be one of the following values:
    ///<table> <tr> <th>Flag</th> <th>Meaning</th> </tr> <tr> <td> DDWAITVB_BLOCKBEGIN </td> <td> The driver should
    ///return when it detects the beginning of the vertical blank interval. </td> </tr> <tr> <td>
    ///DDWAITVB_BLOCKBEGINEVENT </td> <td> Set up an event to trigger when the vertical blank begins. This flag is not
    ///currently supported. </td> </tr> <tr> <td> DDWAITVB_BLOCKEND </td> <td> The driver should return when it detects
    ///the end of the vertical blank interval and display begins. </td> </tr> <tr> <td> DDWAITVB_I_TESTVB </td> <td> The
    ///driver should determine whether a vertical blank is currently occurring and return the status in <b>bIsInVB</b>.
    ///</td> </tr> </table>
    uint    dwFlags;
    ///Indicates the status of the vertical blank. A value of <b>TRUE</b> indicates that the device is in a vertical
    ///blank; <b>FALSE</b> means that it is not. The driver should return the current vertical blanking status in this
    ///member when <b>dwFlags</b> is DDWAITVB_I_TESTVB.
    uint    bIsInVB;
    ///Handle for the event that should be triggered when the vertical blank begins. The event is triggered on an
    ///interrupt, so if your hardware is able to generate an interrupt on the vertical blank, you should pass this event
    ///handle to your HwVidInterrupt function so that the event is triggered when the interrupt fires. This member is
    ///currently unsupported and should be ignored by the driver.
    size_t  hEvent;
    ///Specifies the location in which the driver writes the return value of the DdWaitForVerticalBlank callback. A
    ///return code of DD_OK indicates success. For more information, see Return Values for DirectDraw.
    HRESULT ddRVal;
    ///Used by the Microsoft DirectDraw API and should not be filled in by the driver.
    LPDDHAL_WAITFORVERTICALBLANK WaitForVerticalBlank;
}

///DDHAL_DESTROYDDLOCALDATA contains the information required for the driver to destroy a set of surfaces associated to
///a given local DirectDraw object.
struct DDHAL_DESTROYDDLOCALDATA
{
    ///Unused.
    uint    dwFlags;
    ///Points to the local Direct Draw object that serves as a reference for all Direct3D surfaces that have to be
    ///destroyed.
    DDRAWI_DIRECTDRAW_LCL* pDDLcl;
    ///Specifies the location where the driver writes the return value of D3dDestroyDDLocal. A return code of D3D_OK
    ///indicates success. For more information, see Return Codes for Direct3D Driver Callbacks.
    HRESULT ddRVal;
}

// Functions

///The <b>BRUSHOBJ_pvAllocRbrush</b> function allocates memory for the driver's realization of a specified brush.
///Params:
///    pbo = Pointer to the BRUSHOBJ structure for which the realization is to be allocated.
///    cj = Specifies the size, in bytes, required for the realization.
///Returns:
///    The return value is a pointer to the allocated memory if the function is successful. Otherwise, it is null, and
///    an error code is logged.
///    
@DllImport("GDI32")
void* BRUSHOBJ_pvAllocRbrush(BRUSHOBJ* pbo, uint cj);

///The <b>BRUSHOBJ_pvGetRbrush</b> function retrieves a pointer to the driver's realization of a specified brush.
///Params:
///    pbo = Pointer to the BRUSHOBJ structure whose realization is requested.
///Returns:
///    The return value is a pointer to the realized brush if the function is successful. If the brush cannot be
///    realized, the return value is null and an error code is logged.
///    
@DllImport("GDI32")
void* BRUSHOBJ_pvGetRbrush(BRUSHOBJ* pbo);

///The <b>BRUSHOBJ_ulGetBrushColor</b> function returns the RGB color of the specified solid brush.
///Params:
///    pbo = Pointer to the BRUSHOBJ structure whose color is being queried.
///Returns:
///    <b>BRUSHOBJ_ulGetBrushColor</b> returns the RGB color of a solid brush. If the specified brush is not solid, this
///    function returns -1.
///    
@DllImport("GDI32")
uint BRUSHOBJ_ulGetBrushColor(BRUSHOBJ* pbo);

///The <b>BRUSHOBJ_hGetColorTransform</b> function retrieves the color transform for the specified brush.
///Params:
///    pbo = Pointer to the BRUSHOBJ structure whose color transform is being queried. The color transform was created in a
///          prior call to DrvIcmCreateColorTransform.
///Returns:
///    <b>BRUSHOBJ_hGetColorTransform</b> returns a handle to the color transform for the specified BRUSHOBJ structure
///    upon success. Otherwise, it returns <b>NULL</b>.
///    
@DllImport("GDI32")
HANDLE BRUSHOBJ_hGetColorTransform(BRUSHOBJ* pbo);

///The <b>CLIPOBJ_cEnumStart</b> function sets parameters for enumerating rectangles in a specified clip region.
///Params:
///    pco = Pointer to the CLIPOBJ structure that defines the clip region to be enumerated.
///    bAll = Specifies whether the entire region should be enumerated. This parameter is <b>TRUE</b> if the whole region
///           should be enumerated. It is <b>FALSE</b> if only the parts relevant to the present drawing operation should be
///           enumerated. A driver that caches clip regions must enumerate the entire region.
///    iType = Specifies the data structures that are to be written by CLIPOBJ_bEnum. This parameter currently must be
///            CT_RECTANGLES, indicating that the region is to be enumerated as a list of rectangles.
///    iDirection = Determines the order in which the rectangles are to be enumerated. This order can be essential if a DrvBitBlt
///                 operation is executing concurrently on the same surface. If the order is not relevant to the device driver,
///                 CD_ANY should be specified for complex regions, allowing GDI to optimize the enumeration. This value can be one
///                 of the following: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td> CD_ANY </td> <td> Any order
///                 convenient for GDI. </td> </tr> <tr> <td> CD_LEFTDOWN </td> <td> Right to left, top to bottom. </td> </tr> <tr>
///                 <td> CD_LEFTUP </td> <td> Right to left, bottom to top. </td> </tr> <tr> <td> CD_RIGHTDOWN </td> <td> Left to
///                 right, top to bottom. </td> </tr> <tr> <td> CD_RIGHTUP </td> <td> Left to right, bottom to top. </td> </tr>
///                 </table>
///    cLimit = Specifies the maximum number of rectangles to be enumerated. If this parameter is zero, counting is omitted.
///Returns:
///    The return value is the count of enumerated rectangles. If the count exceeds <b>cLimit</b>, the return value is
///    0xFFFFFFFF.
///    
@DllImport("GDI32")
uint CLIPOBJ_cEnumStart(CLIPOBJ* pco, BOOL bAll, uint iType, uint iDirection, uint cLimit);

///The <b>CLIPOBJ_bEnum</b> function enumerates a batch of rectangles from a specified clip region; a prior call to
///CLIPOBJ_cEnumStart determines the order of enumeration.
///Params:
///    pco = Pointer to a CLIPOBJ structure describing the clip region that is to be enumerated.
///    cj = Specifies the size, in bytes, of the buffer pointed to by <i>pv</i>.
///    pul = Pointer to the buffer that will receive data about the clip region in an ENUMRECTS structure.
///Returns:
///    The return value is <b>TRUE</b> if the driver must call this function again for more enumeration data, or
///    <b>FALSE</b> if the enumeration is complete. It is possible for <b>CLIPOBJ_bEnum</b> to return <b>TRUE</b> with
///    the number of clipping rectangles equal to zero. In such cases, the driver should call <b>CLIPOBJ_bEnum</b> again
///    without taking any action.
///    
@DllImport("GDI32")
BOOL CLIPOBJ_bEnum(CLIPOBJ* pco, uint cj, uint* pul);

///The <b>CLIPOBJ_ppoGetPath</b> function creates a PATHOBJ structure that contains the outline of the specified clip
///region.
///Params:
///    pco = Pointer to a CLIPOBJ structure that defines the specified clip region.
///Returns:
///    The return value is a pointer to a PATHOBJ structure if the function is successful. Otherwise, it is <b>NULL</b>,
///    and an error code is logged.
///    
@DllImport("GDI32")
PATHOBJ* CLIPOBJ_ppoGetPath(CLIPOBJ* pco);

///The <b>FONTOBJ_cGetAllGlyphHandles</b> function allows the device driver to find every glyph handle of a GDI font.
///Params:
///    pfo = Pointer to the FONTOBJ structure that is to be downloaded.
///    phg = Pointer to a buffer large enough to hold all the glyph handles in the font. This parameter can be <b>NULL</b>.
///Returns:
///    The return value is the number of glyph handles supported by the font.
///    
@DllImport("GDI32")
uint FONTOBJ_cGetAllGlyphHandles(FONTOBJ* pfo, uint* phg);

///The <b>FONTOBJ_vGetInfo</b> function retrieves information about an associated font.
///Params:
///    pfo = Pointer to the FONTOBJ structure to be queried.
///    cjSize = Specifies the size in bytes of the buffer pointed to by <i>pfi</i>.
///    pfi = Pointer to a buffer previously allocated by the driver. GDI writes a FONTINFO structure to this buffer.
@DllImport("GDI32")
void FONTOBJ_vGetInfo(FONTOBJ* pfo, uint cjSize, FONTINFO* pfi);

///The <b>FONTOBJ_cGetGlyphs</b> function is a service to the font consumer that translates glyph handles into pointers
///to glyph data, which are valid until the next call to <b>FONTOBJ_cGetGlyphs</b>.
///Params:
///    pfo = Pointer to a FONTOBJ structure containing the glyph handles to be translated.
///    iMode = Specifies whether data will be written as bitmaps or as outline objects. This parameter can be one of the
///            following values: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td> FO_GLYPHBITS </td> <td> Data will
///            consist of GLYPHBITS structures that define the bitmaps of the glyphs. </td> </tr> <tr> <td> FO_PATHOBJ </td>
///            <td> Data will consist of PATHOBJ structures that define the outlines of the glyphs. To determine whether the
///            path should be filled or stroked, the font consumer should check the <b>flInfo</b> member of the IFIMETRICS
///            structure. If the FM_INFO_RETURNS_STROKES flag is set, the path should be stroked; otherwise, the path should be
///            filled. </td> </tr> </table>
///    cGlyph = Specifies the number of glyphs to be translated. The only acceptable value is 1 (the code assumes 1, regardless
///             of the value specified).
///    phg = Pointer to an array of <i>cGlyph</i> HGLYPH structures supplied by the driver.
///    ppvGlyph = Pointer to a memory location that receives the address of a GLYPHDATA structure. The first member of this
///               structure is a GLYPHDEF union, which contains a pointer to either a GLYPHBITS structure or a PATHOBJ structure,
///               depending on the value of the <i>iMode</i> parameter. If the value of <i>iMode</i> is FO_GLYPHBITS,
///               (*<i>ppvGlyph)</i>-&gt;<i>gdf</i> contains the address of a GLYPHBITS structure. If the value of <i>iMode</i> is
///               FO_PATHOBJ, (*<i>ppvGlyph</i>)-&gt;<i>gdf</i> contains the address of a PATHOBJ structure.
///Returns:
///    The return value is the count of pointers passed to the driver if the function is successful. Otherwise, it is
///    zero, and an error code is logged.
///    
@DllImport("GDI32")
uint FONTOBJ_cGetGlyphs(FONTOBJ* pfo, uint iMode, uint cGlyph, uint* phg, void** ppvGlyph);

///The <b>FONTOBJ_pxoGetXform</b> function retrieves the notional-to-device transform for the specified font.
///Params:
///    pfo = Pointer to the FONTOBJ structure for which the transform is to be retrieved.
///Returns:
///    The return value is a pointer to an XFORMOBJ structure that describes the transform. The XFORMOBJ structure can
///    be used by the <b>XFORMOBJ_</b><b><i>Xxx</i></b> service routines. The XFORMOBJ structure assumes that: <ul>
///    <li>The distance between the pixels is in device space units. </li> <li>Both notional and device space have
///    positive values of y in the top-to-bottom direction. </li> </ul> If the font is a raster font, the return value
///    is <b>NULL</b>.
///    
@DllImport("GDI32")
XFORMOBJ* FONTOBJ_pxoGetXform(FONTOBJ* pfo);

///The <b>FONTOBJ_pifi</b> function retrieves the pointer to the IFIMETRICS structure associated with a specified font.
///Params:
///    pfo = Pointer to the FONTOBJ structure for which the associated IFIMETRICS structure is to be retrieved.
///Returns:
///    The return value is a pointer to the IFIMETRICS structure associated with the specified font if the function is
///    successful. Otherwise, it is <b>NULL</b>.
///    
@DllImport("GDI32")
IFIMETRICS* FONTOBJ_pifi(FONTOBJ* pfo);

///The <b>FONTOBJ_pfdg</b> function retrieves the pointer to the FD_GLYPHSET structure associated with the specified
///font.
///Params:
///    pfo = Pointer to the FONTOBJ structure for which the associated FD_GLYPHSET structure is to be returned.
///Returns:
///    <b>FONTOBJ_pfdg</b> returns a pointer to the FD_GLYPHSET structure associated with the specified font.
///    
@DllImport("GDI32")
FD_GLYPHSET* FONTOBJ_pfdg(FONTOBJ* pfo);

///The <b>FONTOBJ_pvTrueTypeFontFile</b> function retrieves a user-mode pointer to a view of a TrueType, OpenType, or
///Type1 font file.
///Params:
///    pfo = Pointer to the FONTOBJ structure with which the TrueType, PostScript OpenType, or PostScript Type1 font is
///          associated.
///    pcjFile = Pointer to a location in which GDI returns the size, in bytes, of the view of the font file.
///Returns:
///    <b>FONTOBJ_pvTrueTypeFontFile</b> returns a pointer to a user-mode view of a font file upon success. If the
///    FONTOBJ structure identifies a Type1 font, the return value is a pointer to the memory-mapped image of the
///    <i>pfb</i> file. Otherwise, this function returns <b>NULL</b>.
///    
@DllImport("GDI32")
void* FONTOBJ_pvTrueTypeFontFile(FONTOBJ* pfo, uint* pcjFile);

///The <b>FONTOBJ_pQueryGlyphAttrs</b> function returns information about a font's glyphs.
///Params:
///    pfo = Is a caller-supplied pointer to a FONTOBJ structure identifying the font for which attributes are being
///          requested.
///    iMode = Is a caller-supplied flag indicating the type of glyph attribute being requested. The following flag is defined:
///            <table> <tr> <th>Flag</th> <th>Definition</th> </tr> <tr> <td> FO_ATTR_MODE_ROTATE </td> <td> The function
///            returns an array indicating which glyphs of a vertical font must be rotated. </td> </tr> </table>
///Returns:
///    <b>FONTOBJ_pQueryGlyphAttrs</b> returns a pointer to an FD_GLYPHATTR structure. If an error is encountered, such
///    as an invalid input argument, or if the font described by the FONTOBJ structure is not a vertical font, the
///    function returns <b>NULL</b>.
///    
@DllImport("GDI32")
FD_GLYPHATTR* FONTOBJ_pQueryGlyphAttrs(FONTOBJ* pfo, uint iMode);

///The <b>PATHOBJ_vEnumStart</b> function notifies a given PATHOBJ structure that the driver will be calling
///PATHOBJ_bEnum to enumerate lines and/or curves in the path.
///Params:
///    ppo = Pointer to a PATHOBJ structure whose lines and/or curves are to be enumerated.
///Returns:
///    None
///    
@DllImport("GDI32")
void PATHOBJ_vEnumStart(PATHOBJ* ppo);

///The <b>PATHOBJ_bEnum</b> function retrieves the next PATHDATA record from a specified path and enumerates the curves
///in the path.
///Params:
///    ppo = Pointer to a PATHOBJ structure whose curves and/or lines are to be enumerated.
///    ppd = Pointer to a PATHDATA structure that is to be filled.
///Returns:
///    The return value is <b>TRUE</b> if the specified path contains more PATHDATA records, indicating that this
///    service should be called again. Otherwise, if the output is the last PATHDATA record in the path, the return
///    value is <b>FALSE</b>.
///    
@DllImport("GDI32")
BOOL PATHOBJ_bEnum(PATHOBJ* ppo, PATHDATA* ppd);

///The <b>PATHOBJ_vEnumStartClipLines</b> function allows the driver to request lines to be clipped against a specified
///clip region.
///Params:
///    ppo = Pointer to the PATHOBJ structure that describes the specified clipping object.
///    pco = Pointer to a CLIPOBJ structure that describes the clip region.
///    pso = Pointer to a SURFOBJ structure that GDI queries to retrieve information about styling steps.
///    pla = Pointer to a LINEATTRS structure that GDI queries to retrieve line width and styling information.
///Returns:
///    None
///    
@DllImport("GDI32")
void PATHOBJ_vEnumStartClipLines(PATHOBJ* ppo, CLIPOBJ* pco, SURFOBJ* pso, LINEATTRS* pla);

///The <b>PATHOBJ_bEnumClipLines</b> function enumerates clipped line segments from a given path.
///Params:
///    ppo = Pointer to the PATHOBJ structure containing the clipped line segments that are to be enumerated.
///    cb = Specifies the size of the output buffer, in bytes. GDI does not write beyond this point in the buffer. The value
///         of this parameter must be large enough to hold a CLIPLINE structure with at least one RUN structure. The driver
///         should allocate space for several RUN structures.
///    pcl = Pointer to the buffer that receives a CLIPLINE structure. The structure contains the original unclipped control
///          points for a line segment. (The correct pixels for the line cannot be computed without the original points.) RUN
///          structures, which describe sets of pixels along the line that are not clipped away, are written to this buffer.
///          If a clip region is complex, a single line segment can be broken into many RUN structures. A segment is returned
///          as many times as necessary to list all of its RUN structures. The CLIPLINE structure contains the starting and
///          ending points of the original unclipped line and the line segments, or RUN structures, of that line that are to
///          appear on the display.
///Returns:
///    The return value is <b>TRUE</b> if more line segments are to be enumerated, indicating that this service should
///    be called again. Otherwise, it is <b>FALSE</b>, indicating that the returned segment is the last segment in the
///    path.
///    
@DllImport("GDI32")
BOOL PATHOBJ_bEnumClipLines(PATHOBJ* ppo, uint cb, CLIPLINE* pcl);

///The <b>PATHOBJ_vGetBounds</b> function retrieves the bounding rectangle for the specified path.
///Params:
///    ppo = Pointer to a PATHOBJ structure that describes the path for which a bounding rectangle is to be calculated.
///    prectfx = Pointer to the address where the RECTFX structure is to be written. The returned rectangle is exclusive of the
///              bottom and right edges. An empty rectangle is specified by setting all four RECTFX members to zero. For a
///              description of this data type, see GDI Data Types.
///Returns:
///    None
///    
@DllImport("GDI32")
void PATHOBJ_vGetBounds(PATHOBJ* ppo, RECTFX* prectfx);

///The <b>STROBJ_vEnumStart</b> function defines the form, or type, for data that will be returned from GDI in
///subsequent calls to STROBJ_bEnum.
///Params:
///    pstro = Pointer to the STROBJ structure whose data form is to be defined.
///Returns:
///    None
///    
@DllImport("GDI32")
void STROBJ_vEnumStart(STROBJ* pstro);

///The <b>STROBJ_bEnum</b> function enumerates glyph identities and positions.
///Params:
///    pstro = Pointer to the STROBJ structure containing the GLYPHPOS information.
///    pc = Pointer to the count, returned by GDI, of GLYPHPOS structures.
///    ppgpos = Pointer to the array in which GDI writes the GLYPHPOS structures.
///Returns:
///    The return value is <b>TRUE</b> if more glyphs remain to be enumerated, or <b>FALSE</b> if the enumeration is
///    complete. The return value is DDI_ERROR if the glyphs cannot be enumerated, and an error code is logged.
///    
@DllImport("GDI32")
BOOL STROBJ_bEnum(STROBJ* pstro, uint* pc, GLYPHPOS** ppgpos);

///The <b>STROBJ_bEnumPositionsOnly</b> function enumerates glyph identities and positions for a specified text string,
///but does not create cached glyph bitmaps.
///Params:
///    pstro = A caller-supplied pointer to a STROBJ structure describing a text string. This is typically the STROBJ structure
///            received by the driver's DrvTextOut function.
///    pc = A caller-supplied address to receive the GDI-supplied number of GLYPHPOS structures pointed to by the pointer in
///         <i>ppgpos</i>.
///    ppgpos = A caller-supplied address that receives a GDI-supplied pointer to an array of GLYPHPOS structures. (See the
///             following <b>Remarks</b> section.)
///Returns:
///    The return value is <b>TRUE</b> if more glyphs remain to be enumerated, or <b>FALSE</b> if the enumeration is
///    complete. The return value is DDI_ERROR if the glyphs cannot be enumerated, and an error code is logged.
///    
@DllImport("GDI32")
BOOL STROBJ_bEnumPositionsOnly(STROBJ* pstro, uint* pc, GLYPHPOS** ppgpos);

///The <b>STROBJ_dwGetCodePage</b> function returns the code page associated with the specified STROBJ structure.
///Params:
///    pstro = Pointer to a STROBJ structure with which the code page is associated.
///Returns:
///    <b>STROBJ_dwGetCodePage</b> returns a DWORD value that identifies the code page associated with the font used in
///    the text output call at the Win32 API level.
///    
@DllImport("GDI32")
uint STROBJ_dwGetCodePage(STROBJ* pstro);

///The <b>STROBJ_bGetAdvanceWidths</b> function retrieves an array of vectors specifying the probable widths of glyphs
///making up a specified string.
///Params:
///    pso = Is a caller-supplied pointer to a STROBJ structure describing a text string. This is typically the STROBJ
///          structure received by the driver's DrvTextOut function.
///    iFirst = Is a caller-supplied, zero-based index into the text string supplied by the STROBJ structure. This index
///             represents the first character of the string for which a width is to be returned.
///    c = Is a caller-supplied count of the number of contiguous characters, starting and the character specified by
///        <i>iFirst</i>, for which width values are to be returned.
///    pptqD = Is a caller-supplied pointer to a <i>c</i>-sized array of POINTQF structures to receive character widths in
///            (28.36, 28.36) format. For a description of this data type, see GDI Data Types.
///Returns:
///    If the operation succeeds, the function returns <b>TRUE</b>; otherwise it returns <b>FALSE</b>.
///    
@DllImport("GDI32")
BOOL STROBJ_bGetAdvanceWidths(STROBJ* pso, uint iFirst, uint c, POINTQF* pptqD);

///The <b>XFORMOBJ_iGetXform</b> function downloads a transform to the driver.
///Params:
///    pxo = Pointer to the XFORMOBJ structure that defines the transform to be downloaded to the driver.
///    pxform = Pointer to the buffer that is to receive the XFORML structure. This parameter can be <b>NULL</b>.
///Returns:
///    If an error occurs, the return value is DDI_ERROR. Otherwise, the return value is a complexity hint about the
///    transform object. The value of this transform characterization can be one of the following: <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>GX_GENERAL</b></dt> </dl> </td>
///    <td width="60%"> Arbitrary 2 x 2 matrix and offset. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>GX_IDENTITY</b></dt> </dl> </td> <td width="60%"> Identity matrix; no translation offset. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>GX_OFFSET</b></dt> </dl> </td> <td width="60%"> Identity matrix; there is a
///    translation offset. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>GX_SCALE</b></dt> </dl> </td> <td width="60%">
///    Off-diagonal matrix elements are zero. </td> </tr> </table>
///    
@DllImport("GDI32")
uint XFORMOBJ_iGetXform(XFORMOBJ* pxo, XFORML* pxform);

///The <b>XFORMOBJ_bApplyXform</b> function applies the given transform or its inverse to the given array of points.
///Params:
///    pxo = Pointer to a XFORMOBJ structure that defines the transform to be applied to the <i>pvIn</i> array.
///    iMode = Identifies the transform and the input and output data types. This parameter can be one of the following: <table>
///            <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td> XF_INV_FXTOL </td> <td> Applies the inverse of the transform
///            to POINTFIX structures to get POINTL structures. </td> </tr> <tr> <td> XF_INV_LTOL </td> <td> Applies the inverse
///            of the transform to POINTL structures to get POINTL structures. </td> </tr> <tr> <td> XF_LTOFX </td> <td> Applies
///            the transform to POINTL structures to get POINTFIX structures (see GDI Data Types). </td> </tr> <tr> <td> XF_LTOL
///            </td> <td> Applies the transform to POINTL structures to get POINTL structures. </td> </tr> </table>
///    cPoints = Specifies the count of points in <i>pvIn</i> to be transformed.
///    pvIn = Pointer to an array of input points. The format of the points is specified by the <i>iMode</i> parameter.
///    pvOut = Pointer to the buffer that is to receive the transformed points. The <i>iMode</i> parameter specifies the format
///            of the points.
///Returns:
///    The return value is <b>TRUE</b> if all points were transformed without overflow. <b>FALSE</b> is returned if
///    <i>pxo</i>, <i>pvIn</i>, or <i>pvOut</i> are <b>null</b>, or if overflow occurs during the transformation.
///    
@DllImport("GDI32")
BOOL XFORMOBJ_bApplyXform(XFORMOBJ* pxo, uint iMode, uint cPoints, void* pvIn, void* pvOut);

///The <b>XLATEOBJ_iXlate</b> function translates a color index of the source palette to the closest index in the
///destination palette.
///Params:
///    pxlo = Pointer to a XLATEOBJ structure that defines the source palette.
///    iColor = Specifies the color index to be translated.
///Returns:
///    The return value is an index into the destination palette if the function is successful. If the function fails,
///    -1 is returned.
///    
@DllImport("GDI32")
uint XLATEOBJ_iXlate(XLATEOBJ* pxlo, uint iColor);

///The <b>XLATEOBJ_piVector</b> function retrieves a translation vector that the driver can use to translate source
///indices to destination indices.
///Params:
///    pxlo = Pointer to a XLATEOBJ structure that defines the indexed source object.
///Returns:
///    The return value is a pointer to a vector of translation entries if the function is successful. Otherwise, it is
///    null, and an error code is logged.
///    
@DllImport("GDI32")
uint* XLATEOBJ_piVector(XLATEOBJ* pxlo);

///The <b>XLATEOBJ_cGetPalette</b> function retrieves RGB colors or the bitfields format from the specified palette.
///Params:
///    pxlo = Pointer to the XLATEOBJ structure from which GDI retrieves the requested information.
///    iPal = Identifies the palette information to be written. This parameter can be one of the following values: <table> <tr>
///           <th>Value</th> <th>Meaning</th> </tr> <tr> <td> XO_DESTBITFIELDS </td> <td> GDI retrieves the bitfields format of
///           the destination palette. </td> </tr> <tr> <td> XO_DESTPALETTE </td> <td> GDI retrieves RGB colors from the
///           destination palette. </td> </tr> <tr> <td> XO_SRCBITFIELDS </td> <td> GDI retrieves the bitfields format of the
///           source palette. </td> </tr> <tr> <td> XO_SRCPALETTE </td> <td> GDI retrieves RGB colors from the source palette.
///           </td> </tr> </table>
///    cPal = Specifies the number of entries in the buffer pointed to by <i>pPal</i>. This can be smaller than the total size
///           of the palette.
///    pPal = Pointer to a buffer in which GDI writes the requested palette information. If <i>iPal</i> is XO_SRCPALETTE or
///           XO_DESTPALETTE and the respective palette type is PAL_INDEXED, each entry is a 24-bit RGB value. If <i>iPal</i>
///           is XO_SRCBITFIELDS or XO_DESTBITFIELDS and the respective palette type is PAL_BITFIELDS, PAL_RGB, or PAL_BGR,
///           <i>pPal</i> points to three ULONG masks that represent the red, green, and blue color masks.
///Returns:
///    <b>XLATEOBJ_cGetPalette</b> returns the number of entries written if <i>pPal</i> is not null. A value of zero is
///    returned if the XLATEOBJ is null or its palette is invalid. <b>XLATEOBJ_cGetPalette</b> will also return zero if
///    the data pointed to by <i>pxlo</i> is not consistent with the value in <i>iPal</i>. For example, if the data
///    pointed to is a bitfield, but <i>iPal</i> is set to either XO_SRCPALETTE or XO_DESTPALETTE,
///    <b>XLATEOBJ_cGetPalette</b> will return zero. Similarly, if the data pointed to by <i>pxlo</i> is a palette, but
///    <i>iPal</i> is set to either XO_SRCBITFIELDS or XO_DESTBITFIELDS, <b>XLATEOBJ_cGetPalette</b> also returns zero.
///    
@DllImport("GDI32")
uint XLATEOBJ_cGetPalette(XLATEOBJ* pxlo, uint iPal, uint cPal, uint* pPal);

///The <b>XLATEOBJ_hGetColorTransform</b> function returns the color transform for the specified translation object.
///Params:
///    pxlo = Pointer to the XLATEOBJ structure whose color transform is being queried. The color transform was created in a
///           prior call to DrvIcmCreateColorTransform.
///Returns:
///    <b>XLATEOBJ_hGetColorTransform</b> returns a handle to the color transform for the specified XLATEOBJ upon
///    success. Otherwise, it returns <b>NULL</b>.
///    
@DllImport("GDI32")
HANDLE XLATEOBJ_hGetColorTransform(XLATEOBJ* pxlo);

///The <b>EngCreateBitmap</b> function requests that GDI create and manage a bitmap.
///Params:
///    sizl = Specifies a SIZEL structure whose members contain the width and height, in pixels, of the bitmap to be created. A
///           SIZEL structure is identical to a SIZE structure. If <i>pvBits</i> is not <b>NULL</b>, this value should
///           represent all pixels visible on the device, allowing the device to keep off-screen memory.
///    lWidth = Specifies the allocation width of the bitmap, which is the number of bytes that must be added to a pointer to
///             move down one scan line.
///    iFormat = Specifies the format of the bitmap in terms of the number of bits of color information per pixel that are
///              required. This parameter can be one of the following values: <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///              <tr> <td> BMF_1BPP </td> <td> Monochrome </td> </tr> <tr> <td> BMF_4BPP </td> <td> 4 bits per pixel </td> </tr>
///              <tr> <td> BMF_8BPP </td> <td> 8 bits per pixel </td> </tr> <tr> <td> BMF_16BPP </td> <td> 16 bits per pixel </td>
///              </tr> <tr> <td> BMF_24BPP </td> <td> 24 bits per pixel </td> </tr> <tr> <td> BMF_32BPP </td> <td> 32 bits per
///              pixel </td> </tr> <tr> <td> BMF_4RLE </td> <td> 4 bits per pixel; run length encoded </td> </tr> <tr> <td>
///              BMF_8RLE </td> <td> 8 bits per pixel; run length encoded </td> </tr> </table>
///    fl = Is a bitmask that specifies properties about the bitmap to be created. This parameter can be zero, or any
///         combination of the following values: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td> BMF_NOZEROINIT
///         </td> <td> GDI will not zero-initialize the bitmap when allocating it. This flag is checked only when
///         <i>pvBits</i> is <b>NULL</b>. </td> </tr> <tr> <td> BMF_TOPDOWN </td> <td> The first scan line represents the top
///         of the bitmap. Note that standard-format bitmaps have the first scan line at the bottom by default. </td> </tr>
///         <tr> <td> BMF_USERMEM </td> <td> GDI will allocate the memory for the bitmap from user memory. By default, the
///         memory is allocated from the kernel's address space. This flag should be specified only when the bitmap being
///         created will not be used by other processes. User memory cannot be passed to EngWritePrinter by the printer
///         driver. </td> </tr> </table>
///    pvBits = Pointer to the first scan line of the bitmap that is to be created. If this parameter is <b>NULL</b>, GDI
///             allocates the storage space for the pixels of the bitmap. If <i>pvBits</i> is not <b>NULL</b>, it is a pointer to
///             the buffer for the bitmap.
///Returns:
///    If the function completes successfully, the return value is a handle that identifies the created bitmap.
///    Otherwise, the return value is 0. <b>EngCreateBitmap</b> does not log an error code.
///    
@DllImport("GDI32")
HBITMAP EngCreateBitmap(SIZE sizl, int lWidth, uint iFormat, uint fl, void* pvBits);

///The <b>EngCreateDeviceSurface</b> function creates and returns a handle for a device surface that the driver will
///manage.
///Params:
///    dhsurf = Device handle to the surface to be managed by the device. This handle is passed to the driver when a SURFOBJ
///             structure is passed for input or output.
///    sizl = Specifies a SIZEL structure that contains the width and height of the surface to be created. The <b>cx</b> and
///           <b>cy</b> members of this structure contain respectively, the surface's width and height, in pixels. A SIZEL
///           structure is identical to a SIZE structure.
///    iFormatCompat = Specifies the compatible engine format of the device surface being created. This is used by GDI if a temporary
///                    buffer is needed to simulate a complicated drawing call.
///Returns:
///    The return value is a handle that identifies the surface if the function is successful. Otherwise, it is zero,
///    and an error code is logged.
///    
@DllImport("GDI32")
HSURF__* EngCreateDeviceSurface(DHSURF__* dhsurf, SIZE sizl, uint iFormatCompat);

///The <b>EngCreateDeviceBitmap</b> function requests GDI to create a handle for a device bitmap.
///Params:
///    dhsurf = Device handle to the device bitmap to be created.
///    sizl = Specifies a SIZEL structure that contains the width and height of the bitmap to be created. The <b>cx</b> and
///           <b>cy</b> members of this structure contain respectively, the bitmap's width and height, in pixels. A SIZEL
///           structure is identical to a SIZE structure.
///    iFormatCompat = Specifies the compatible engine format of the device surface being created. This is used by GDI if a temporary
///                    buffer is needed to simulate a complicated drawing call. The allowable values for <i>iFormatCompat</i> are
///                    BMF_1BPP, BMF_4BPP, BMF_8BPP, BMF_16BPP, BMF_24BPP, and BMF_32BPP.
///Returns:
///    The return value is a handle that identifies the bitmap if the function is successful. Otherwise, it is zero, and
///    an error code is logged.
///    
@DllImport("GDI32")
HBITMAP EngCreateDeviceBitmap(DHSURF__* dhsurf, SIZE sizl, uint iFormatCompat);

///The <b>EngDeleteSurface</b> function deletes the specified surface.
///Params:
///    hsurf = Handle to the surface to delete. This handle can be an HSURF or HBM.
@DllImport("GDI32")
BOOL EngDeleteSurface(HSURF__* hsurf);

///The <b>EngLockSurface</b> function creates a user object for a given surface. This function gives drivers access to
///surfaces they create.
///Params:
///    hsurf = Handle to the surface to be locked.
///Returns:
///    <b>EngLockSurface</b> returns a pointer to a SURFOBJ structure if the function is successful. Otherwise, this
///    function returns <b>NULL</b>.
///    
@DllImport("GDI32")
SURFOBJ* EngLockSurface(HSURF__* hsurf);

///The <b>EngUnlockSurface</b> function causes GDI to unlock the surface.
///Params:
///    pso = Pointer to a SURFOBJ structure that describes the surface to be unlocked.
///Returns:
///    None
///    
@DllImport("GDI32")
void EngUnlockSurface(SURFOBJ* pso);

///The <b>EngEraseSurface</b> function calls GDI to erase the surface; a given rectangle on the surface will be filled
///with the given color.
///Params:
///    pso = Pointer to the surface to erase.
///    prcl = Pointer to a RECTL structure that defines which pixels to erase on the surface. This rectangle is exclusive of
///           the bottom and right edges.
///    iColor = Specifies a color index. This is an index to the value that will be written into each pixel.
@DllImport("GDI32")
BOOL EngEraseSurface(SURFOBJ* pso, RECTL* prcl, uint iColor);

///The <b>EngAssociateSurface</b> function marks a given surface as belonging to a specified device.
///Params:
///    hsurf = Handle to the surface or bitmap to be associated with <i>hdev</i>. This handle was returned by EngCreateBitmap or
///            EngCreateDeviceBitmap.
///    hdev = Handle to the device with which the surface is to be associated. This is the GDI-created handle that was passed
///           to the driver's DrvCompletePDEV function.
///    flHooks = Specifies the functions that the driver can hook from GDI. The driver must implement the corresponding function
///              for every bit that it sets in <i>flHooks</i>. This member is a bitwise OR of any of the following values: <table>
///              <tr> <th>Flag</th> <th>Function to be hooked</th> </tr> <tr> <td> HOOK_ALPHABLEND </td> <td> DrvAlphaBlend </td>
///              </tr> <tr> <td> HOOK_BITBLT </td> <td> DrvBitBlt </td> </tr> <tr> <td> HOOK_COPYBITS </td> <td> DrvCopyBits </td>
///              </tr> <tr> <td> HOOK_FILLPATH </td> <td> DrvFillPath </td> </tr> <tr> <td> HOOK_GRADIENTFILL </td> <td>
///              DrvGradientFill </td> </tr> <tr> <td> HOOK_LINETO </td> <td> DrvLineTo </td> </tr> <tr> <td> HOOK_MOVEPANNING
///              </td> <td> Obsolete </td> </tr> <tr> <td> HOOK_PAINT </td> <td> Obsolete </td> </tr> <tr> <td> HOOK_PLGBLT </td>
///              <td> DrvPlgBlt </td> </tr> <tr> <td> HOOK_STRETCHBLT </td> <td> DrvStretchBlt </td> </tr> <tr> <td>
///              HOOK_STRETCHBLTROP </td> <td> DrvStretchBltROP </td> </tr> <tr> <td> HOOK_STROKEANDFILLPATH </td> <td>
///              DrvStrokeAndFillPath </td> </tr> <tr> <td> HOOK_STROKEPATH </td> <td> DrvStrokePath </td> </tr> <tr> <td>
///              HOOK_SYNCHRONIZE </td> <td> DrvSynchronize or DrvSynchronizeSurface (either or both) </td> </tr> <tr> <td>
///              HOOK_SYNCHRONIZEACCESS </td> <td> Obsolete </td> </tr> <tr> <td> HOOK_TEXTOUT </td> <td> DrvTextOut </td> </tr>
///              <tr> <td> HOOK_TRANSPARENTBLT </td> <td> DrvTransparentBlt </td> </tr> </table>
///Returns:
///    The return value is <b>TRUE</b> if the function is successful. Otherwise, the driver should send the information
///    to the GDI function it is implementing, and return GDI's return value.
///    
@DllImport("GDI32")
BOOL EngAssociateSurface(HSURF__* hsurf, HDEV__* hdev, uint flHooks);

///The <b>EngMarkBandingSurface </b>function marks the specified surface as a banding surface.
///Params:
///    hsurf = Caller-supplied handle to the surface to mark as a banding surface.
///Returns:
///    <b>EngMarkBandingSurface</b> returns <b>TRUE</b> upon success; otherwise it returns <b>FALSE</b>.
///    
@DllImport("GDI32")
BOOL EngMarkBandingSurface(HSURF__* hsurf);

///The <b>EngCheckAbort</b> function enables a printer graphics DLL to determine if a print job should be terminated.
///Params:
///    pso = Caller-supplied pointer to a SURFOBJ structure, previously received from GDI.
///Returns:
///    If the print job should be terminated, the function returns <b>TRUE</b>. If the print job should not be
///    terminated, or if <i>pso</i> does not point to a valid SURFOBJ structure, the function returns <b>FALSE</b>.
///    
@DllImport("GDI32")
BOOL EngCheckAbort(SURFOBJ* pso);

///The <b>EngDeletePath</b> function deletes a path previously allocated by EngCreatePath.
///Params:
///    ppo = Pointer to the PATHOBJ structure to be deleted.
///Returns:
///    None
///    
@DllImport("GDI32")
void EngDeletePath(PATHOBJ* ppo);

///The <b>EngCreatePalette</b> function sends a request to GDI to create an RGB palette.
///Params:
///    iMode = Specifies how the palette will be defined. This parameter can be one of the following values: <table> <tr>
///            <th>Value</th> <th>Meaning</th> </tr> <tr> <td> PAL_BITFIELDS </td> <td> The palette is defined by the
///            <i>flRed</i>, <i>flGreen</i>, and <i>flBlue</i> parameters. </td> </tr> <tr> <td> PAL_BGR </td> <td> The device
///            accepts RGB colors directly, with B (blue) as the least significant byte. </td> </tr> <tr> <td> PAL_CMYK </td>
///            <td> The device accepts CMYK colors directly, with C (cyan) as the least significant byte. </td> </tr> <tr> <td>
///            PAL_INDEXED </td> <td> An array of RGB colors is provided with <i>cColors</i> and <i>pulColors</i>. </td> </tr>
///            <tr> <td> PAL_RGB </td> <td> The device accepts RGB colors directly, with R (red) as the least significant byte.
///            </td> </tr> </table>
///    cColors = If the <i>iMode</i> parameter is PAL_INDEXED, <i>cColors</i> specifies the number of colors provided in the array
///              pointed to by <i>pulColors</i>. Otherwise, this parameter should be zero.
///    pulColors = Pointer to the beginning of an array of ULONG values if <i>iMode</i> is PAL_INDEXED. The low-order 3 bytes of
///                each ULONG define the RGB colors in the palette.
///    flRed = If the <i>iMode</i> parameter is PAL_BITFIELDS, the <i>flRed</i>, <i>flGreen</i> and <i>flBlue</i> parameters are
///            masks that show which bits correspond to red, green, and blue. Each mask must consist of contiguous bits and
///            should not overlap other masks. All combinations of bitfields are supported by GDI.
///    flGreen = If the <i>iMode</i> parameter is PAL_BITFIELDS, the <i>flRed</i>, <i>flGreen</i> and <i>flBlue</i> parameters are
///              masks that show which bits correspond to red, green, and blue. Each mask must consist of contiguous bits and
///              should not overlap other masks. All combinations of bitfields are supported by GDI.
///    flBlue = If the <i>iMode</i> parameter is PAL_BITFIELDS, the <i>flRed</i>, <i>flGreen</i> and <i>flBlue</i> parameters are
///             masks that show which bits correspond to red, green, and blue. Each mask must consist of contiguous bits and
///             should not overlap other masks. All combinations of bitfields are supported by GDI.
///Returns:
///    The return value is a handle to the new palette if the function is successful. Otherwise, it is zero, and an
///    error code is logged.
///    
@DllImport("GDI32")
HPALETTE EngCreatePalette(uint iMode, uint cColors, uint* pulColors, uint flRed, uint flGreen, uint flBlue);

///The <b>EngDeletePalette</b> function sends a request to GDI to delete the specified palette.
///Params:
///    hpal = Handle to the palette to be deleted. This handle is supplied by EngCreatePalette.
@DllImport("GDI32")
BOOL EngDeletePalette(HPALETTE hpal);

///The <b>EngCreateClip</b> function creates a CLIPOBJ structure that the driver uses in callbacks.
///Returns:
///    The return value is a pointer to the newly-created CLIPOBJ structure if the function succeeds. Otherwise, it is
///    <b>NULL</b>.
///    
@DllImport("GDI32")
CLIPOBJ* EngCreateClip();

///The <b>EngDeleteClip</b> function deletes a CLIPOBJ structure allocated by EngCreateClip.
///Params:
///    pco = Pointer to the CLIPOBJ structure to delete.
@DllImport("GDI32")
void EngDeleteClip(CLIPOBJ* pco);

///The <b>EngBitBlt</b> function provides general bit-block transfer capabilities either between device-managed
///surfaces, or between a device-managed surface and a GDI-managed standard format bitmap.
///Params:
///    psoTrg = Pointer to the SURFOBJ structure that identifies the surface on which to draw.
///    psoSrc = If the <i>rop4</i> requires it, pointer to a SURFOBJ structure that defines the source for the bit-block transfer
///             operation.
///    psoMask = Pointer to a SURFOBJ structure that defines a surface to be used as a mask. The mask is defined as a bitmap with
///              1 bit per pixel. Typically, a mask limits the area that is to be modified in the destination surface. Masking is
///              selected by a <i>rop4</i> with the value 0xAACC. The destination surface is unaffected when the mask is zero. The
///              mask is large enough to cover the destination rectangle. If the value of this parameter is <b>NULL</b> and a mask
///              is required by the <i>rop4</i>, then the implicit mask in the brush is used. If a mask is required, then
///              <i>psoMask</i> overrides the implicit mask in the brush.
///    pco = Pointer to a CLIPOBJ structure. The <b>CLIPOBJ_</b><i>Xxx</i> service routines are provided to enumerate the clip
///          region as a set of rectangles. This enumeration limits the area of the destination that will be modified.
///          Whenever possible, GDI simplifies the clipping involved; for example, this function is never called with a single
///          clipping rectangle. GDI clips the destination rectangle before calling this function, making additional clipping
///          unnecessary.
///    pxlo = Pointer to a XLATEOBJ structure that tells how color indices should be translated between the source and target
///           surfaces.
///    prclTrg = Pointer to a RECTL structure in the coordinate system of the destination surface that defines the area to be
///              modified. The rectangle is defined by two points; upper left and lower right. The lower and right edges of this
///              rectangle are not part of the bit-block transfer, meaning the rectangle is lower right exclusive.
///              <b>EngBitBlt</b> is never called with an empty destination rectangle. The two points that define the rectangle
///              are always well ordered.
///    pptlSrc = Pointer to a POINTL structure that defines the upper left corner of the source rectangle, if a source exists. If
///              there is no source, the driver should ignore this parameter.
///    pptlMask = Pointer to a POINTL structure that defines which pixel in the mask corresponds to the upper left corner of the
///               destination rectangle. If no mask is specified in <i>psoMask</i> the driver should ignore this parameter.
///    pbo = Pointer to the BRUSHOBJ structure to be used to define the pattern for the bit-block transfer. GDI's
///          BRUSHOBJ_pvGetRbrush service routine retrieves the device's realization of the brush. The driver can ignore this
///          parameter if the <i>rop4</i> parameter does not require a pattern.
///    pptlBrush = Pointer to a POINTL structure that defines the origin of the brush in the destination surface. The upper left
///                pixel of the brush is aligned at this point and the brush repeats according to its dimensions. Ignore this
///                parameter if the <i>rop4</i> parameter does not require a pattern.
///    rop4 = Represents a raster operation that defines how the mask, pattern, source, and destination pixels are combined to
///           write an output pixel to the destination surface. This is a quaternary raster operation, which is a natural
///           extension of the usual ternary Rop3 operation. A Rop4 has 16 relevant bits, which are similar to the 8 defining
///           bits of a Rop3. (The other, redundant bits of the Rop3 are ignored.) The simplest way to implement a Rop4 is to
///           consider its 2 bytes separately. The lower byte specifies a Rop3 that should be computed wherever the mask is 1.
///           The high byte specifies a Rop3 that can be computed and applied wherever the mask is 0.
///Returns:
///    The return value is <b>TRUE</b> if the function is successful. Otherwise, it is <b>FALSE</b>, and an error code
///    is logged.
///    
@DllImport("GDI32")
BOOL EngBitBlt(SURFOBJ* psoTrg, SURFOBJ* psoSrc, SURFOBJ* psoMask, CLIPOBJ* pco, XLATEOBJ* pxlo, RECTL* prclTrg, 
               POINTL* pptlSrc, POINTL* pptlMask, BRUSHOBJ* pbo, POINTL* pptlBrush, uint rop4);

///The <b>EngLineTo</b> function draws a single, solid, integer-only cosmetic line.
///Params:
///    pso = Pointer to a SURFOBJ structure that describes the surface on which to draw.
///    pco = Pointer to a CLIPOBJ structure that defines the clip region in which the rendering must be done. No pixels can be
///          affected outside this clip region.
///    pbo = Pointer to a BRUSHOBJ structure that specifies the brush to use when drawing the line.
///    x1 = Specify the integer x-coordinate of the line's beginning point.
///    y1 = Specify the integer y-coordinate of the line's beginning point.
///    x2 = Specify the integer x-coordinate of the line's end point.
///    y2 = Specify the integer x- and y-coordinate of the line's end point.
///    prclBounds = Pointer to a RECTL structure that describes the rectangle that bounds the unclipped line. Drivers that support
///                 hardware line drawing can use this rectangle to quickly determine whether the line fits in a coordinate space
///                 small enough to be rendered by the hardware.
///    mix = Defines how the incoming pattern should be mixed with the data already on the device surface. The low-order byte
///          defines the raster operation. For more information about raster operation codes, see the Microsoft Windows SDK
///          documentation.
///Returns:
///    <b>EngLineTo</b> returns <b>TRUE</b> if it succeeds; otherwise, it returns <b>FALSE</b>.
///    
@DllImport("GDI32")
BOOL EngLineTo(SURFOBJ* pso, CLIPOBJ* pco, BRUSHOBJ* pbo, int x1, int y1, int x2, int y2, RECTL* prclBounds, 
               uint mix);

///The <b>EngStretchBlt</b> function causes GDI to do a stretching bit-block transfer.
///Params:
///    psoDest = Pointer to a SURFOBJ structure that describes the surface on which to draw.
///    psoSrc = Pointer to a SURFOBJ structure that describes the source surface for the bit-block transfer.
///    psoMask = Pointer to a SURFOBJ structure that defines a mask for the source. The mask is defined by a logic map, which is a
///              bitmap with one bit per pixel. The mask limits the area of the source that is copied. If this parameter is
///              specified, it has an implicit <i>rop4</i> of 0xCCAA, meaning the source should be copied wherever the mask is 1,
///              but the destination should be left alone wherever the mask is 0. If this parameter is <b>NULL</b>, the
///              <i>rop4</i> is implicitly 0xCCCC, which means the source should be copied everywhere in the source rectangle.
///    pco = Pointer to a CLIPOBJ structure that limits the area to be modified in the destination. GDI services are provided
///          to enumerate the clip region as a set of rectangles. Whenever possible, GDI simplifies the clipping involved.
///          However, unlike DrvBitBlt, <b>EngStretchBlt</b> can be called with a single clipping rectangle. This prevents
///          rounding errors in clipping the output.
///    pxlo = Pointer to a XLATEOBJ structure that specifies how color indices are to be translated between the source and
///           target surfaces. This XLATEOBJ structure can also be queried to find the RGB color for any source index. A high
///           quality stretching bit-block transfer will need to interpolate colors in some cases.
///    pca = Pointer to a COLORADJUSTMENT structure that defines the color adjustment values to be applied to the source
///          bitmap before stretching the bits. For more information, see the Microsoft Windows SDK documentation.
///    pptlHTOrg = Pointer to a POINTL structure that defines the origin of the halftone brush. Drivers that use halftone brushes
///                should align the upper left pixel of the brush's pattern with this point on the device surface.
///    prclDest = Pointer to a RECTL structure that defines the area to be modified in the coordinate system of the destination
///               surface. This rectangle is defined by two points that are not well ordered, meaning the coordinates of the second
///               point are not necessarily larger than those of the first point. The rectangle described does not include the
///               lower and right edges. This function is never called with an empty destination rectangle. If the destination
///               rectangle is not well ordered, <b>EngStretchBlt</b> makes it well ordered.
///    prclSrc = Pointer to a RECTL structure that defines the area to be copied, in the coordinate system of the source surface.
///              The rectangle will map to the rectangle defined by <i>prclDest</i>. This function is never given an empty source
///              rectangle, and the points of the source rectangle are always well-ordered. The mapping is defined by
///              <i>prclSrc</i> and <i>prclDest</i>. The points specified in <i>prclDest</i> and <i>prclSrc</i> lie on integer
///              coordinates, which correspond to pixel centers. A rectangle defined by two such points is considered to be a
///              geometric rectangle with two vertices whose coordinates are the given points, but with 0.5 subtracted from each
///              coordinate. (POINTL structures are shorthand notation for specifying these fractional coordinate vertices.) The
///              edges of any rectangle never intersect a pixel, but go around a set of pixels. The pixels that are inside the
///              rectangle are those expected for a lower-right exclusive rectangle. <b>EngStretchBlt</b> maps the geometric
///              source rectangle exactly onto the geometric destination rectangle.
///    pptlMask = Pointer to a POINTL structure that defines the pixel in the given mask that corresponds to the upper left pixel
///               in the source rectangle. This parameter is ignored if no mask is specified.
///    iMode = Specifies how source pixels are combined to get output pixels. The HALFTONE mode is slower than the other modes,
///            but produces higher quality images. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td> BLACKONWHITE
///            </td> <td> On a shrinking bit-block transfer, pixels should be combined with a Boolean AND operation. On a
///            stretching bit-block transfer, pixels should be replicated. </td> </tr> <tr> <td> COLORONCOLOR </td> <td> On a
///            shrinking bit-block transfer, enough pixels should be ignored so that pixels don't need to be combined. On a
///            stretching bit-block transfer, pixels should be replicated. </td> </tr> <tr> <td> HALFTONE </td> <td> The driver
///            can use groups of pixels in the output surface to best approximate the color or gray level of the input. </td>
///            </tr> <tr> <td> WHITEONBLACK </td> <td> On a shrinking bit-block transfer, pixels should be combined with a
///            Boolean OR operation. On a stretching bit-block transfer, pixels should be replicated. </td> </tr> </table>
///Returns:
///    The return value is <b>TRUE</b> if the function is successful. Otherwise, it is <b>FALSE</b> and an error code is
///    reported.
///    
@DllImport("GDI32")
BOOL EngStretchBlt(SURFOBJ* psoDest, SURFOBJ* psoSrc, SURFOBJ* psoMask, CLIPOBJ* pco, XLATEOBJ* pxlo, 
                   COLORADJUSTMENT* pca, POINTL* pptlHTOrg, RECTL* prclDest, RECTL* prclSrc, POINTL* pptlMask, 
                   uint iMode);

///The <b>EngStretchBltROP</b> function performs a stretching bit-block transfer using a ROP.
///Params:
///    psoDest = Pointer to a SURFOBJ structure that describes the surface on which to draw.
///    psoSrc = Pointer to a SURFOBJ structure that describes the source surface for the bit-block transfer.
///    psoMask = Pointer to a SURFOBJ structure that defines a mask for the source surface. The mask is defined by a logic map,
///              which is a bitmap with 1 bit per pixel. Typically, a mask limits the area that is to be modified in the
///              destination surface. This mask should always be the same size as the source surface.
///    pco = Pointer to a CLIPOBJ structure that limits the area to be modified in the destination. The
///          <b>CLIPOBJ_</b><i>Xxx</i> service routines are provided to enumerate the clip region as a set of rectangles.
///          Whenever possible, GDI simplifies the clipping involved. However, unlike EngBitBlt, <b>EngStretchBltROP</b> can
///          be called with a single clipping rectangle. This prevents rounding errors in clipping the output.
///    pxlo = Pointer to a XLATEOBJ structure that specifies how color indices are to be translated between the source and
///           target surfaces. This XLATEOBJ structure can also be queried to find the RGB color for any source index. A high
///           quality stretching bit-block transfer will need to interpolate colors in some cases.
///    pca = Pointer to a COLORADJUSTMENT structure that defines the color adjustment values to be applied to the source
///          bitmap before stretching the bits. For more information see the Windows SDK documentation.
///    pptlHTOrg = Pointer to a POINTL structure that defines the origin of the halftone brush on the destination surface. When
///                using halftone brushes, GDI aligns the upper left pixel of the brush's pattern at this point and repeats the
///                brush according to its dimensions. GDI ignores this parameter if the <i>rop4</i> parameter does not require a
///                pattern.
///    prclDest = Pointer to a RECTL structure that defines the rectangular area to be modified. This rectangle is specified in the
///               coordinate system of the destination surface and is defined by two points: upper left and lower right. The two
///               points that define the rectangle are not always well ordered, meaning the coordinates of the second point are not
///               necessarily larger than those of the first point. If the destination rectangle is not well ordered, GDI makes it
///               so. The rectangle is lower-right exclusive; that is, its lower and right edges are not a part of the copy.
///               <b>EngStretchBltROP</b> must never be called with an empty destination rectangle.
///    prclSrc = Pointer to a RECTL structure that defines the area to be copied. This rectangle is specified in the coordinate
///              system of the source surface and is defined by two points: upper left and lower right. The two points that define
///              the rectangle are always well ordered. The rectangle is lower-right exclusive; that is, its lower and right edges
///              are not a part of the copy. This rectangle maps to the rectangle to which <i>prclDest</i> points.
///              <b>EngStretchBltROP</b> must never be called with an empty source rectangle.
///    pptlMask = Pointer to a POINTL structure that defines the pixel in the mask to which <i>prclMask</i> points. This pixel
///               corresponds to the upper-left pixel in the source rectangle to which <i>prclSrc</i> points. This parameter is
///               ignored if no mask is specified; that is, GDI ignores <i>pptlMask</i> when <i>prclMask</i> is <b>NULL</b>.
///    iMode = Specifies how source pixels are combined to get output pixels. The HALFTONE mode is slower than the other modes,
///            but produces higher quality images. This parameter can be one of the following values: <table> <tr>
///            <th>Value</th> <th>Meaning</th> </tr> <tr> <td> BLACKONWHITE </td> <td> On a shrinking bit-block transfer, GDI
///            combines pixels with a Boolean AND operation. On a stretching bit-block transfer, pixels are replicated. </td>
///            </tr> <tr> <td> COLORONCOLOR </td> <td> On a shrinking bit-block transfer, GDI ignores enough pixels so that
///            pixels need not be combined. On a stretching bit-block transfer, pixels are replicated. </td> </tr> <tr> <td>
///            HALFTONE </td> <td> GDI uses groups of pixels in the output surface to best approximate the color or gray level
///            of the input. </td> </tr> <tr> <td> WHITEONBLACK </td> <td> On a shrinking bit-block transfer, pixels should be
///            combined with a Boolean OR operation. On a stretching bit-block transfer, pixels should be replicated. </td>
///            </tr> </table>
///    pbo = Pointer to the BRUSHOBJ structure to be used to define the pattern for the bit-block transfer. GDI's
///          BRUSHOBJ_pvGetRbrush service routine retrieves the device's realization of the brush. GDI ignores this parameter
///          if the <i>rop4</i> parameter does not require a pattern.
///    rop4 = Represents a raster operation that defines how the mask, pattern, source, and destination pixels are combined to
///           write an output pixel to the destination surface. This is a quaternary raster operation, which is a natural
///           extension of the usual ternary Rop3 operation. A Rop4 has 16 relevant bits, which are similar to the 8 defining
///           bits of a Rop3. (The other redundant bits of the Rop3 are ignored.) The simplest way to implement a Rop4 is to
///           consider its 2 bytes separately. The lower byte specifies a Rop3 that should be computed wherever the mask to
///           which <i>psoMask</i> points is 1. The high byte specifies a Rop3 that can be computed and applied wherever the
///           mask is zero.
///Returns:
///    <b>EngStretchBltROP</b> returns <b>TRUE</b> upon success. Otherwise, it reports an error and returns
///    <b>FALSE</b>.
///    
@DllImport("GDI32")
BOOL EngStretchBltROP(SURFOBJ* psoDest, SURFOBJ* psoSrc, SURFOBJ* psoMask, CLIPOBJ* pco, XLATEOBJ* pxlo, 
                      COLORADJUSTMENT* pca, POINTL* pptlHTOrg, RECTL* prclDest, RECTL* prclSrc, POINTL* pptlMask, 
                      uint iMode, BRUSHOBJ* pbo, uint rop4);

///The <b>EngAlphaBlend</b> function provides bit-block transfer capabilities with alpha blending.
///Params:
///    psoDest = Pointer to a SURFOBJ structure that identifies the surface on which to draw.
///    psoSrc = Pointer to a SURFOBJ structure that identifies the source surface.
///    pco = Pointer to a CLIPOBJ structure. The <b>CLIPOBJ_</b><b><i>Xxx</i></b> service routines are provided to enumerate
///          the clip region as a set of rectangles. This enumeration limits the area of the destination that is modified.
///          Whenever possible, GDI simplifies the clipping involved. However, unlike EngBitBlt, <b>EngAlphaBlend</b> might be
///          called with a single rectangle in order to prevent round-off errors in clipping the output.
///    pxlo = Pointer to a XLATEOBJ structure that specifies how color indices should be translated between the source and
///           destination surfaces. If the source surface is palette managed, its colors are represented by indices into a
///           lookup table of RGB color values. In this case, GDI can query the XLATEOBJ structure for a translate vector to
///           quickly translate any source index into a color index for the destination. The situation is more complicated
///           when, for example, the source is RGB but the destination is palette-managed. In this case, the closest match to
///           each source RGB value must be found in the destination palette. GDI calls the XLATEOBJ_iXlate service routine to
///           perform this matching operation.
///    prclDest = Pointer to a RECTL structure that defines the rectangular area to be modified. This rectangle is specified in the
///               coordinate system of the destination surface and is defined by two points: upper left and lower right. The two
///               points that define the rectangle are always well ordered. The rectangle is lower-right exclusive; that is, its
///               lower and right edges are not a part of the blend. The specified rectangle can overhang the destination surface;
///               GDI performs the proper clipping when it does. <b>EngAlphaBlend</b> must never be called with an empty
///               destination rectangle.
///    prclSrc = Pointer to a RECTL structure that defines the area to be copied. This rectangle is specified in the coordinate
///              system of the source surface and is defined by two points: upper left and lower right. The two points that define
///              the rectangle are always well ordered. The rectangle is lower-right exclusive; that is, its lower and right edges
///              are not a part of the blend. The source rectangle must never exceed the bounds of the source surface, and thus
///              never overhang the source surface. <b>EngAlphaBlend</b> must never be called with an empty source rectangle. The
///              mapping is defined by <i>prclSrc</i> and <i>prclDest</i>. The points specified in <i>prclDest</i> and
///              <i>prclSrc</i> lie on integer coordinates, which correspond to pixel centers. A rectangle defined by two such
///              points is considered to be a geometric rectangle with two vertices whose coordinates are the given points, but
///              with 0.5 subtracted from each coordinate. (POINTL structures are shorthand notation for specifying these
///              fractional coordinate vertices.)
///    pBlendObj = Pointer to a BLENDOBJ structure that describes the blending operation to perform between the source and
///                destination surfaces. This structure is a wrapper for the BLENDFUNCTION structure, which includes necessary
///                source and destination format information that is not available in the XLATEOBJ structure . BLENDFUNCTION is
///                declared in the Microsoft Windows SDK documentation. Its members are defined as follows: <b>BlendOp</b> defines
///                the blend operation to be performed. Currently this value must be AC_SRC_OVER, which means that the source bitmap
///                is placed over the destination bitmap based on the alpha values of the source pixels. There are three possible
///                cases that this blend operation should handle. These are described in the Remarks section of this reference page.
///                <b>BlendFlags</b> is reserved and is currently set to zero. <b>SourceConstantAlpha</b> defines the constant blend
///                factor to apply to the entire source surface. This value is in the range of [0,255], where 0 is completely
///                transparent and 255 is completely opaque. <b>AlphaFormat</b> defines whether the surface is assumed to have an
///                alpha channel. This member can optionally be set to the following value:
///Returns:
///    <b>EngAlphaBlend</b> returns <b>TRUE</b> upon success. If an error occurs, it returns <b>FALSE</b> and reports an
///    error code.
///    
@DllImport("GDI32")
BOOL EngAlphaBlend(SURFOBJ* psoDest, SURFOBJ* psoSrc, CLIPOBJ* pco, XLATEOBJ* pxlo, RECTL* prclDest, 
                   RECTL* prclSrc, BLENDOBJ* pBlendObj);

///The <b>EngGradientFill</b> function shades the specified primitives.
///Params:
///    psoDest = Pointer to the SURFOBJ structure that identifies the surface on which to draw.
///    pco = Pointer to a CLIPOBJ structure. The <b>CLIPOBJ_</b><i>Xxx</i> service routines are provided to enumerate the clip
///          region as a set of rectangles. This enumeration limits the area of the destination that is modified. Whenever
///          possible, GDI simplifies the clipping involved.
///    pxlo = Pointer to a XLATEOBJ structure. This structure indicates how color indices should be translated between 32 bpp
///           RGB format and the destination. The driver is responsible for converting the input COLOR16 color values to RGB.
///    pVertex = Pointer to an array of TRIVERTEX structures, with each entry containing position and color information. The
///              TRIVERTEX structure is described in the Microsoft Windows SDK documentation.
///    nVertex = Specifies the number of TRIVERTEX structures in the array to which <i>pVertex</i> points.
///    pMesh = Pointer to an array of structures that define the connectivity of the TRIVERTEX elements to which <i>pVertex</i>
///            points. When rectangles are being drawn, <i>pMesh</i> points to an array of GRADIENT_RECT structures, each of
///            which specifies two TRIVERTEX elements that define a rectangle. The TRIVERTEX elements can represent any
///            diagonally-opposed pair of rectangle vertices. Rectangle drawing is lower-right exclusive. Both TRIVERTEX and
///            GRADIENT_RECT are defined in the Windows SDK documentation. When triangles are being drawn, <i>pMesh</i> points
///            to an array of GRADIENT_TRIANGLE structures, each of which specifies the three TRIVERTEX elements that define a
///            triangle. Triangle drawing is lower-right exclusive. The GRADIENT_TRIANGLE structure is defined in the Windows
///            SDK documentation.
///    nMesh = Specifies the number of elements in the array to which <i>pMesh</i> points.
///    prclExtents = Pointer to a RECTL structure that defines the area in which the gradient drawing is to occur. The points are
///                  specified in the coordinate system of the destination surface. This parameter is useful in estimating the size of
///                  the drawing operations.
///    pptlDitherOrg = Pointer to a POINTL structure that defines the origin on the surface for dithering. The upper-left pixel of the
///                    dither pattern is aligned with this point.
///    ulMode = Specifies the current drawing mode and how to interpret the array to which <i>pMesh</i> points. This parameter
///             can be one of the following values:
///Returns:
///    <b>EngGradientFill</b> returns <b>TRUE</b> upon success. Otherwise, it reports an error and returns <b>FALSE</b>.
///    
@DllImport("GDI32")
BOOL EngGradientFill(SURFOBJ* psoDest, CLIPOBJ* pco, XLATEOBJ* pxlo, TRIVERTEX* pVertex, uint nVertex, void* pMesh, 
                     uint nMesh, RECTL* prclExtents, POINTL* pptlDitherOrg, uint ulMode);

///The <b>EngTransparentBlt</b> function provides bit-block transfer capabilities with transparency.
///Params:
///    psoDst = Pointer to the SURFOBJ structure that identifies the target surface on which to draw.
///    psoSrc = Pointer to the SURFOBJ structure that identifies the source surface of the bit-block transfer.
///    pco = Pointer to a CLIPOBJ structure. The <b>CLIPOBJ_</b><i>Xxx</i> service routines are provided to enumerate the clip
///          region as a set of rectangles. This enumeration limits the area of the destination that is modified. Whenever
///          possible, GDI simplifies the clipping involved.
///    pxlo = Pointer to a XLATEOBJ structure that tells how the source color indices should be translated for writing to the
///           target surface.
///    prclDst = Pointer to a RECTL structure that defines the rectangular area to be modified. This rectangle is specified in the
///              coordinate system of the destination surface and is defined by two points: upper left and lower right. The
///              rectangle is lower-right exclusive; that is, its lower and right edges are not a part of the bit-block transfer.
///              The two points that define the rectangle are always well ordered. The driver must never call
///              <b>EngTransparentBlt</b> with an empty destination rectangle.
///    prclSrc = Pointer to a RECTL structure that defines the rectangular area to be copied. This rectangle is specified in the
///              coordinate system of the source surface and is defined by two points: upper left and lower right. The two points
///              that define the rectangle are always well ordered. The source rectangle will never exceed the bounds of the
///              source surface, and so will never overhang the source surface. This rectangle is mapped to the destination
///              rectangle defined by <i>prclDst</i>. The driver must never call <b>EngTransparentBlt</b> with an empty source
///              rectangle.
///    TransColor = Specifies the physical transparent color, in the source surface's format. This is a color index value that has
///                 been translated to the source surface's palette. For more information, see the <b>Remarks</b> section.
///    bCalledFromBitBlt = Reserved. This parameter must be set to zero.
///Returns:
///    <b>EngTransparentBlt</b> returns <b>TRUE</b> upon success. Otherwise, it returns <b>FALSE</b>.
///    
@DllImport("GDI32")
BOOL EngTransparentBlt(SURFOBJ* psoDst, SURFOBJ* psoSrc, CLIPOBJ* pco, XLATEOBJ* pxlo, RECTL* prclDst, 
                       RECTL* prclSrc, uint TransColor, uint bCalledFromBitBlt);

///The <b>EngTextOut</b> function causes GDI to render a set of glyphs at specified positions.
///Params:
///    pso = Pointer to a SURFOBJ structure that describes the surface on which to write.
///    pstro = Pointer to a STROBJ structure that defines the glyphs to be rendered and the positions where they are to be
///            placed.
///    pfo = Pointer to a FONTOBJ structure that is used to retrieve information about the font and its glyphs.
///    pco = Pointer to a CLIPOBJ structure that defines the clip region through which rendering must be done. No pixels can
///          be affected outside this clip region.
///    prclExtra = Pointer to a RECTL structure. This parameter should always be <b>NULL</b>.
///    prclOpaque = Pointer to a RECTL structure that identifies a single opaque rectangle that is lower-right exclusive. Pixels
///                 within this rectangle (those that are not foreground and not clipped) are to be rendered with the opaque brush.
///                 This rectangle always bounds the text to be drawn. If this parameter is <b>NULL</b>, no opaque pixels are to be
///                 rendered.
///    pboFore = Pointer to a BRUSHOBJ structure that represents the brush object to be used for the foreground pixels. This brush
///              will always be a solid color brush.
///    pboOpaque = Pointer to a BRUSHOBJ structure that represents the brush object for the opaque pixels. Both the foreground and
///                background mix modes for this brush are assumed to be R2_COPYPEN. Unless the driver sets the GCAPS_ARBRUSHOPAQUE
///                capabilities bit in the <b>flGraphicsCaps</b> member of the DEVINFO structure, it will always be called with a
///                solid color brush.
///    pptlOrg = Pointer to a POINTL structure that defines the brush origin for both brushes. If this parameter is set to 0 when
///              <b>EngTextOut</b> is called, some printer drivers may print color images incorrectly. For more information, see
///              <b>Remarks</b>.
///    mix = Specifies foreground and background raster operations (mix modes) for <i>pboFore</i>.
///Returns:
///    The return value is <b>TRUE</b> if the function is successful. Otherwise, it is <b>FALSE</b>, and an error code
///    is logged.
///    
@DllImport("GDI32")
BOOL EngTextOut(SURFOBJ* pso, STROBJ* pstro, FONTOBJ* pfo, CLIPOBJ* pco, RECTL* prclExtra, RECTL* prclOpaque, 
                BRUSHOBJ* pboFore, BRUSHOBJ* pboOpaque, POINTL* pptlOrg, uint mix);

///The <b>EngStrokePath</b> function requests that GDI stroke a specified path.
///Params:
///    pso = Pointer to a SURFOBJ structure that describes the surface on which to draw.
///    ppo = Pointer to a PATHOBJ structure. The <b>PATHOBJ_</b><i>Xxx</i> service routines are provided to enumerate the
///          lines, Bezier curves, and other data that make up the path. This indicates what is to be drawn.
///    pco = Pointer to a CLIPOBJ structure. The <b>CLIPOBJ_</b><i>Xxx</i> service routines are provided to enumerate the clip
///          region as a set of rectangles. Optionally, all the lines in the path can be enumerated preclipped by this
///          CLIPOBJ. This means that drivers can have all their line clipping calculations done for them.
///    pxo = Pointer to a XFORMOBJ structure. This is needed only when a geometric wide line is to be drawn. It specifies the
///          transform that converts world coordinates to device coordinates. This is needed because the path is provided in
///          device coordinates but a geometric wide line is actually widened in world coordinates. The driver can use the
///          <b>XFORMOBJ_</b><i>Xxx</i> service routines to determine the transform.
///    pbo = Pointer to a BRUSHOBJ structure that specifies the brush to be used when drawing the path.
///    pptlBrushOrg = Pointer to a POINTL structure that contains the brush origin used to align the brush pattern on the device.
///    plineattrs = Pointer to a LINEATTRS structure. Note that the <b>elStyleState</b> member of this structure must be updated as
///                 part of this function if the line is styled. Also note the <b>ptlLastPel</b> member of the same structure must be
///                 updated if a single-pixel-width cosmetic line is being drawn.
///    mix = Specifies how to combine the brush with the destination.
///Returns:
///    The return value is <b>TRUE</b> if GDI strokes the path. If the driver should stroke the path, the return value
///    is <b>FALSE</b>, and no error is logged. If GDI encounters an error, the return value is DDI_ERROR, and an error
///    code is logged.
///    
@DllImport("GDI32")
BOOL EngStrokePath(SURFOBJ* pso, PATHOBJ* ppo, CLIPOBJ* pco, XFORMOBJ* pxo, BRUSHOBJ* pbo, POINTL* pptlBrushOrg, 
                   LINEATTRS* plineattrs, uint mix);

///The <b>EngFillPath</b> function fills a path.
///Params:
///    pso = Pointer to a SURFOBJ structure that describes the surface on which to draw.
///    ppo = Pointer to a PATHOBJ structure that defines the path to be filled. Use the <b>PATHOBJ_</b><i>Xxx</i> service
///          routines to enumerate the lines, Bezier curves, and other data that make up the path.
///    pco = Pointer to a CLIPOBJ structure. Use the <b>CLIPOBJ_</b><i>Xxx</i> service routines to enumerate the clip region
///          as a set of rectangles.
///    pbo = Pointer to a BRUSHOBJ structure that defines the pattern and colors with which to fill.
///    pptlBrushOrg = Pointer to a POINTL structure defining the brush origin to use to align the brush pattern on the device.
///    mix = Defines the foreground and background raster operations to use for the brush.
///    flOptions = Specifies the mode to use when filling the path. This value should be FP_WINDINGMODE or FP_ALTERNATEMODE. All
///                other flags should be ignored. For more information about these modes, see Path Fill Modes.
///Returns:
///    The return value is <b>TRUE</b> if GDI is able to fill the path. Otherwise, it is <b>FALSE</b>, and an error code
///    is not logged. If an error is encountered, the return value is <b>FALSE</b>, and an error code is logged.
///    
@DllImport("GDI32")
BOOL EngFillPath(SURFOBJ* pso, PATHOBJ* ppo, CLIPOBJ* pco, BRUSHOBJ* pbo, POINTL* pptlBrushOrg, uint mix, 
                 uint flOptions);

///The <b>EngStrokeAndFillPath</b> function causes GDI to fill a path and stroke it at the same time.
///Params:
///    pso = Pointer to a SURFOBJ structure that defines the drawing surface.
///    ppo = Pointer to a PATHOBJ structure that defines the path to be filled. The <b>PATHOBJ_</b><i>Xxx</i> service routines
///          are provided to enumerate the lines, Bezier curves, and other data that make up the path.
///    pco = Pointer to a CLIPOBJ structure. The <b>CLIPOBJ_</b><i>Xxx</i> service routines are provided to enumerate the clip
///          region as a set of rectangles.
///    pxo = Pointer to a XFORMOBJ structure that is only needed when a geometric wide line is to be drawn and specifies the
///          transform that converts world coordinates to device coordinates. The path is provided in device coordinates but a
///          geometric wide line is actually widened in world coordinates. The driver can use the <b>XFORMOBJ_</b><i>Xxx</i>
///          service routines to determine the transform.
///    pboStroke = Pointer to a BRUSHOBJ structure that describes the brush to use when stroking the path.
///    plineattrs = Pointer to a LINEATTRS structure.
///    pboFill = Pointer to a BRUSHOBJ structure that describes the brush to use when filling the path.
///    pptlBrushOrg = Pointer to a POINTL structure that defines the brush origin for both brushes.
///    mixFill = Defines the foreground and background raster operations to use for the fill brush.
///    flOptions = Specifies which fill mode to use. This parameter can be FP_WINDINGMODE or FP_ALTERNATEMODE; all other bits should
///                be ignored. For more information about these modes, see Path Fill Modes.
///Returns:
///    The return value is <b>TRUE</b> if GDI fills the path. If the driver should fill the path, the return value is
///    <b>FALSE</b>, and an error code is not logged. If GDI encounters an unexpected error, such as not being able to
///    realize the brush, the return value is DDI_ERROR, and an error code is logged.
///    
@DllImport("GDI32")
BOOL EngStrokeAndFillPath(SURFOBJ* pso, PATHOBJ* ppo, CLIPOBJ* pco, XFORMOBJ* pxo, BRUSHOBJ* pboStroke, 
                          LINEATTRS* plineattrs, BRUSHOBJ* pboFill, POINTL* pptlBrushOrg, uint mixFill, 
                          uint flOptions);

///The <b>EngPaint</b> function causes GDI to paint a specified region.
///Params:
///    pso = Pointer to a SURFOBJ structure that describes the surface on which to draw.
///    pco = Pointer to a CLIPOBJ structure that defines the area to be painted. The <b>CLIPOBJ_</b><i>Xxx</i> service
///          routines are provided to enumerate the clip region as a set of rectangles.
///    pbo = Pointer to a BRUSHOBJ structure that defines the pattern and colors with which to fill.
///    pptlBrushOrg = Pointer to a POINTL structure that defines the brush origin used to align the brush pattern on the device.
///    mix = Defines the foreground and background raster operations to use for the brush.
///Returns:
///    The return value is <b>TRUE</b> if the function is successful. Otherwise, it is <b>FALSE</b>, and an error code
///    is logged.
///    
@DllImport("GDI32")
BOOL EngPaint(SURFOBJ* pso, CLIPOBJ* pco, BRUSHOBJ* pbo, POINTL* pptlBrushOrg, uint mix);

///The <b>EngCopyBits</b> function translates between device-managed raster surfaces and GDI standard-format bitmaps.
///Params:
///    psoDest = Pointer to a SURFOBJ structure that describes the destination surface for the copy operation.
///    psoSrc = Pointer to a SURFOBJ structure that describes the source surface for the copy operation.
///    pco = Pointer to a CLIPOBJ structure that restricts the area of the destination surface that will be affected. This
///          parameter can be <b>NULL</b>.
///    pxlo = Pointer to a XLATEOBJ structure that defines the translation of color indices between the source and target
///           surfaces.
///    prclDest = Pointer to a RECTL structure that defines the area in the coordinate system of the destination surface that will
///               be modified. The rectangle is lower-right exclusive, meaning the lower and right edges of this rectangle are not
///               part of the copy.
///    pptlSrc = Pointer to a POINTL structure that defines the upper left corner of the source rectangle.
///Returns:
///    The return value is <b>TRUE</b> if the function is successful. If it is unsuccessful, it logs an error and
///    returns <b>FALSE</b>.
///    
@DllImport("GDI32")
BOOL EngCopyBits(SURFOBJ* psoDest, SURFOBJ* psoSrc, CLIPOBJ* pco, XLATEOBJ* pxlo, RECTL* prclDest, POINTL* pptlSrc);

///The <b>EngPlgBlt</b> function causes GDI to perform a rotate bit-block transfer.
///Params:
///    psoTrg = Pointer to a SURFOBJ structure that describes the surface on which to draw.
///    psoSrc = Pointer to a SURFOBJ structure that describes the source surface for the bit-block transfer operation.
///    psoMsk = Pointer to an optional SURFOBJ structure that represents a mask for the source. It is defined by a logic map,
///             which is a bitmap with one bit per pixel. This mask limits the area of the source that is copied. A mask has an
///             implicit <i>rop4</i> of 0xCCAA, which means the source should be copied wherever the mask is 1, but the
///             destination should be left alone wherever the mask is zero. If this parameter is <b>NULL</b>, there is an
///             implicit <i>rop4</i> of 0xCCCC, which means the source should be copied everywhere in the source rectangle. The
///             mask will always be large enough to contain the relevant source; tiling is unnecessary.
///    pco = Pointer to a CLIPOBJ structure that limits the area of the destination to be modified. GDI functions enumerate
///          the clip region as a set of rectangles. Whenever possible, GDI simplifies the clipping involved. Unlike the
///          DrvBitBlt function, <b>EngPlgBlt</b> may be called with a single clipping rectangle. This prevents rounding
///          errors in clipping the output.
///    pxlo = Pointer to a XLATEOBJ structure that defines how color indices are translated between the source and target
///           surfaces. This XLATEOBJ structure can be queried to find the RGB color for any source index. A high quality
///           rotate bit-block transfer is needed to interpolate colors.
///    pca = Pointer to a COLORADJUSTMENT structure that defines the color adjustment values to be applied to the source
///          bitmap before stretching the bits. For more information, see the Microsoft Windows SDK documentation.
///    pptlBrushOrg = Pointer to a POINTL structure that specifies the origin of the halftone brush. Drivers that use halftone brushes
///                   should align the upper left pixel of the brush's pattern with this point on the device surface.
///    pptfx = Pointer to three POINTFIX structures that define a parallelogram in the destination surface. A fourth, implicit,
///            vertex is given as: D = B + C − A. For a description of this data type, see GDI Data Types. <b>EngPlgBlt</b> is
///            never called with A, B, and C collinear.
///    prcl = Pointer to a RECTL structure that defines, in the coordinate system of the source surface, the area to be copied.
///           The points of the source rectangle are well ordered. <b>EngPlgBlt</b> will never be given an empty source
///           rectangle.
///    pptl = Pointer to a POINTL structure that specifies which pixel in the given mask corresponds to the upper-left pixel in
///           the source rectangle. Ignore this parameter if <i>psoMsk</i> is <b>NULL</b>.
///    iMode = Defines how source pixels are combined to get output pixels. This parameter can be one of the following values:
///            <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td> BLACKONWHITE </td> <td> On a shrinking bit-block
///            transfer, pixels should be combined with an AND operation. On a stretching bit-block transfer pixels should be
///            replicated. </td> </tr> <tr> <td> COLORONCOLOR </td> <td> On a shrinking bit-block transfer, enough pixels should
///            be ignored so that pixels need not be combined. On a stretching bit-block transfer, pixels should be replicated.
///            </td> </tr> <tr> <td> HALFTONE </td> <td> The driver may use groups of pixels in the output surface to best
///            approximate the color or gray level of the input. </td> </tr> <tr> <td> WHITEONBLACK </td> <td> On a shrinking
///            bit-block transfer, pixels should be combined with an OR operation. On a stretching block transfers, pixels
///            should be replicated. </td> </tr> </table> The methods WHITEONBLACK, BLACKONWHITE, and COLORONCOLOR are simple
///            and provide compatibility for old applications, but do not produce the best looking results for color surfaces.
///Returns:
///    The return value is <b>TRUE</b> if the function is successful. Otherwise, it is <b>FALSE</b> and an error code is
///    reported.
///    
@DllImport("GDI32")
BOOL EngPlgBlt(SURFOBJ* psoTrg, SURFOBJ* psoSrc, SURFOBJ* psoMsk, CLIPOBJ* pco, XLATEOBJ* pxlo, 
               COLORADJUSTMENT* pca, POINTL* pptlBrushOrg, POINTFIX* pptfx, RECTL* prcl, POINTL* pptl, uint iMode);

///The <b>HT_Get8BPPFormatPalette</b> function returns a halftone palette for use on standard 8-bits per pixel device
///types.
///Params:
///    pPaletteEntry = Pointer to an array of PALETTEENTRY structures (described in the Microsoft Windows SDK documentation). When this
///                    pointer is not <b>NULL</b>, GDI assumes that it points to valid memory space in which GDI can place the entire
///                    8-bits per pixel halftone palette.
///    RedGamma = Specifies the red, green, and blue gamma value. This USHORT value is interpreted as a real number whose four
///               least-significant digits are to the right of the (implied) decimal point. For example, a gamma value of 10000
///               represents the real number 1.0000, and 12345 represents 1.2345. The minimum gamma value allowed is 0.0000, and
///               the maximum allowable value is 6.5535.
///    GreenGamma = Specifies the red, green, and blue gamma value. This USHORT value is interpreted as a real number whose four
///                 least-significant digits are to the right of the (implied) decimal point. For example, a gamma value of 10000
///                 represents the real number 1.0000, and 12345 represents 1.2345. The minimum gamma value allowed is 0.0000, and
///                 the maximum allowable value is 6.5535.
///    BlueGamma = Specifies the red, green, and blue gamma value. This USHORT value is interpreted as a real number whose four
///                least-significant digits are to the right of the (implied) decimal point. For example, a gamma value of 10000
///                represents the real number 1.0000, and 12345 represents 1.2345. The minimum gamma value allowed is 0.0000, and
///                the maximum allowable value is 6.5535.
///Returns:
///    If <i>pPaletteEntry</i> is not <b>NULL</b>, the return value is the number of PALETTEENTRY structures that GDI
///    filled in starting at the memory location pointed to by <i>pPaletteEntry</i>. If <i>pPaletteEntry</i> is
///    <b>NULL</b>, the return value is the total count of PALETTEENTRY structures required to store the 8-bits per
///    pixel halftone palette.
///    
@DllImport("GDI32")
int HT_Get8BPPFormatPalette(PALETTEENTRY* pPaletteEntry, ushort RedGamma, ushort GreenGamma, ushort BlueGamma);

///The <b>HT_Get8BPPMaskPalette</b> function returns a mask palette for an 8-bits-per-pixel device type.
///Params:
///    pPaletteEntry = Pointer to the array of PALETTEENTRY structures (described in the Windows SDK documentation) to be filled in. GDI
///                    assumes that it points to valid memory space in which GDI can place the entire 8-bit-per-pixel halftone palette.
///                    For a driver that runs on Windows XP and later operating system versions, GDI checks <i>pPaletteEntry</i>[0] to
///                    determine how to return the composed CMY palette. If <i>pPaletteEntry</i>[0] is set to 'RGB0', the palette will
///                    be in one of the CMY_INVERTED modes and will have its indexes inverted. That is, index 0 in the palette is black,
///                    and index 255 is white. If <i>pPaletteEntry</i>[0] is not set to 'RGB0', the palette is a normal CMY palette,
///                    with index 0 being white and index 255 being black. See Using GDI 8-Bit-Per-Pixel CMY Mask Modes for new
///                    requirements and details on how to use this parameter. Windows 2000 ignores any value the driver places in
///                    <i>pPaletteEntry</i>[0]. For this reason, if your driver is intended to run on Windows 2000 <i>and</i> on Windows
///                    XP or later versions, and your driver sets <i>pPaletteEntry</i>[0] to 'RGB0', the bitmaps your driver receives
///                    from Windows XP and later might have their colors inverted, relative to those received from Windows 2000.
///                    Therefore, such a driver must examine the palette before downloading a bitmap.
///    Use8BPPMaskPal = Indicates which type of palette should be returned. When <i>Use8BPPMaskPal</i> is <b>TRUE</b>,
///                     <b>HT_Get8BPPMaskPalette</b> sets the <i>pPaletteEntry</i> parameter with the address of a CMY palette (an array
///                     of PALETTEENTRY structures) that is described by the bitmask specified in <i>CMYMask</i>. When
///                     <i>Use8BPPMaskPal</i> is <b>FALSE</b>, the function sets <i>pPaletteEntry</i> with the address of a standard RGB
///                     8-bit-per-pixel halftone palette.
///    CMYMask = Specifies information about the array of PALETTEENTRY structures pointed to by <i>pPaletteEntry</i>. This
///              parameter can have one of the following values: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td> 0
///              </td> <td> Gray scale with 256 levels </td> </tr> <tr> <td> 1 </td> <td> Five levels each of cyan, magenta, and
///              yellow (each ranging from 0 to 4), for a total of 125 colors </td> </tr> <tr> <td> 2 </td> <td> Six levels each
///              of cyan, magenta, and yellow (each ranging from 0 to 5), for a total of 216 colors </td> </tr> <tr> <td> 3 to 255
///              </td> <td> A bitmask that specifies that maximum number of levels of cyan, magenta, and yellow, respectively.
///              </td> </tr> </table> Drivers running on Windows 2000 should be restricted to 8-bits-per-pixel monochrome. That
///              is, the value of <i>CMYMask</i> used should be 0. For Windows XP and later operating system versions, and for all
///              values of <i>CMYMask</i>, the value in <i>pPaletteEntry</i>[0] determines whether the palette that follows
///              <i>pPaletteEntry</i>[0] is a normal CMY palette, or one of the CMY_INVERTED mode palettes. For more information,
///              see the description of the <i>pPaletteEntry</i> parameter. For values of <i>CMYMask</i> from 3 to 255, inclusive,
///              the value is a bitmask in which groups of bits have the following meanings: <ul> <li> The three highest bits
///              (bits 7,6,5) specify the number of levels of cyan. At most, seven levels of cyan (levels 1 to 7) are possible.
///              </li> <li> The middle three bits (bits 4,3,2) specify the number of levels of magenta. At most, seven levels of
///              magenta (levels 1 to 7) are possible. </li> <li> The two lowest bits (bits 1,0) specify the number of levels of
///              yellow. At most, three levels of yellow (levels 1 to 3) are possible. </li> </ul> For values of <i>CMYMask</i>
///              ranging from 3 to 255, any bitmask combination in which the cyan, magenta, or yellow level bits are zero is
///              invalid. In such cases, <b>HT_Get8BPPMaskPalette</b> returns a palette count of zero. See Using GDI
///              8-Bit-Per-Pixel CMY Mask Modes for more information.
///    RedGamma = If <i>Use8BPPMaskPal</i> is <b>TRUE</b>, the value of this parameter is not used. In that case, gamma values will
///               be specified in the <b>ciDevice</b> member of the GDIINFO structure. If <i>Use8BPPMaskPal</i> is <b>FALSE</b>,
///               the value of this parameter specifies the red gamma value, out of the red, green and blue gamma values that GDI
///               is to use to gamma-correct the palette. The USHORT value is interpreted as a real number whose four
///               least-significant digits are to the right of the decimal point. For example, a gamma value of 10000 represents
///               the real number 1.0000, and 12345 represents 1.2345. The minimum gamma value allowed is 0.0000, and the maximum
///               allowable value is 6.5535.
///    GreenGamma = If <i>Use8BPPMaskPal</i> is <b>TRUE</b>, the value of this parameter is not used. In that case, gamma values will
///                 be specified in the <b>ciDevice</b> member of the GDIINFO structure. If <i>Use8BPPMaskPal</i> is <b>FALSE</b>,
///                 the value of this parameter specifies the green gamma value, out of the red, green and blue gamma values that GDI
///                 is to use to gamma-correct the palette. The USHORT value is interpreted as a real number whose four
///                 least-significant digits are to the right of the decimal point. For example, a gamma value of 10000 represents
///                 the real number 1.0000, and 12345 represents 1.2345. The minimum gamma value allowed is 0.0000, and the maximum
///                 allowable value is 6.5535.
///    BlueGamma = If <i>Use8BPPMaskPal</i> is <b>TRUE</b>, the value of this parameter is not used. In that case, gamma values will
///                be specified in the <b>ciDevice</b> member of the GDIINFO structure. If <i>Use8BPPMaskPal</i> is <b>FALSE</b>,
///                the value of this parameter specifies the blue gamma value, out of the red, green and blue gamma values that GDI
///                is to use to gamma-correct the palette. The USHORT value is interpreted as a real number whose four
///                least-significant digits are to the right of the decimal point. For example, a gamma value of 10000 represents
///                the real number 1.0000, and 12345 represents 1.2345. The minimum gamma value allowed is 0.0000, and the maximum
///                allowable value is 6.5535.
///Returns:
///    If <i>pPaletteEntry</i> is not <b>NULL</b>, <b>HT_Get8BPPMaskPalette</b> returns the number of PALETTEENTRY
///    structures that GDI filled out in the array to which <i>pPaletteEntry</i> points. If <i>pPaletteEntry</i> is
///    <b>NULL</b>, the value returned is the total count of PALETTEENTRY structures required to store the halftone
///    palette. If an illegal value of the <i>CMYMask</i> parameter is used in the call to this function,
///    <b>HT_Get8BPPMaskPalette</b> returns a value of zero.
///    
@DllImport("GDI32")
int HT_Get8BPPMaskPalette(PALETTEENTRY* pPaletteEntry, BOOL Use8BPPMaskPal, ubyte CMYMask, ushort RedGamma, 
                          ushort GreenGamma, ushort BlueGamma);

///The <b>EngGetPrinterDataFileName</b> function retrieves the string name of the printer's data file.
///Params:
///    hdev = Handle to the device. This is the GDI handle received by the driver as the <i>hdev</i> parameter for
///           DrvCompletePDEV.
///Returns:
///    <b>EngGetPrinterDataFileName</b> returns a pointer to the null-terminated string buffer in which the name of the
///    printer's data file is specified. The system obtains and stores the printer's data file name from the
///    DRIVER_INFO_2 structure (described in the Microsoft Windows SDK documentation) when the driver is first installed
///    through the Microsoft Win32 <b>AddPrinterDriver</b> routine.
///    
@DllImport("GDI32")
ushort* EngGetPrinterDataFileName(HDEV__* hdev);

///The <b>EngGetDriverName</b> function returns the name of the driver's DLL.
///Params:
///    hdev = Handle to the device. This is the GDI handle received by the driver as the <i>hdev</i> parameter for
///           DrvCompletePDEV.
///Returns:
///    <b>EngGetDriverName</b> returns a pointer to the null-terminated string buffer in which the name of the driver's
///    DLL is specified. The system obtains and stores the driver's name from the DRIVER_INFO_2 structure when the
///    driver is first installed through the Win32 <b>AddPrinterDriver</b> routine.
///    
@DllImport("GDI32")
ushort* EngGetDriverName(HDEV__* hdev);

///The <b>EngLoadModule</b> function loads the specified data module into system memory for reading.
///Params:
///    pwsz = Pointer to a null-terminated string that contains the name of the data file to be loaded.
///Returns:
///    If <b>EngLoadModule</b> succeeds, the return value is a handle to the module that was loaded. Otherwise, the
///    return value is <b>NULL</b>.
///    
@DllImport("GDI32")
HANDLE EngLoadModule(const(wchar)* pwsz);

///The <b>EngFindResource</b> function determines the location of a resource in a module.
///Params:
///    h = Handle to the module that contains the resource. This handle is obtained from EngLoadModule.
///    iName = Is an integer identifier representing the name of the resource being looked up.
///    iType = Is an integer identifier representing the type of the resource being looked up.
///    pulSize = Pointer to a ULONG in which the resource's size, in bytes, is returned.
///Returns:
///    The return value is a pointer to the address of the specified resource. The function returns <b>NULL</b> if an
///    error occurs.
///    
@DllImport("GDI32")
void* EngFindResource(HANDLE h, int iName, int iType, uint* pulSize);

///The <b>EngFreeModule</b> function unmaps a file from system memory.
///Params:
///    h = Handle to the memory-mapped file to be freed. This handle was obtained from EngLoadModule or
///        EngLoadModuleForWrite.
///Returns:
///    None
///    
@DllImport("GDI32")
void EngFreeModule(HANDLE h);

///The <b>EngCreateSemaphore</b> function creates a semaphore object.
///Returns:
///    If the function succeeds, the return value is a handle to the semaphore object. A null pointer is returned if the
///    function fails.
///    
@DllImport("GDI32")
HSEMAPHORE__* EngCreateSemaphore();

///The <b>EngAcquireSemaphore</b> function acquires the resource associated with the semaphore for exclusive access by
///the calling thread.
///Params:
///    hsem = Handle to the semaphore associated with the resource to be acquired.
///Returns:
///    None
///    
@DllImport("GDI32")
void EngAcquireSemaphore(HSEMAPHORE__* hsem);

///The <b>EngReleaseSemaphore</b> function releases the specified semaphore.
///Params:
///    hsem = Handle to the semaphore to be released.
///Returns:
///    None
///    
@DllImport("GDI32")
void EngReleaseSemaphore(HSEMAPHORE__* hsem);

///The <b>EngDeleteSemaphore</b> function deletes a semaphore object from the system's resource list.
///Params:
///    hsem = Handle to the semaphore to be deleted. The semaphore was created in EngCreateSemaphore.
///Returns:
///    None
///    
@DllImport("GDI32")
void EngDeleteSemaphore(HSEMAPHORE__* hsem);

///The <b>EngMultiByteToUnicodeN</b> function converts the specified ANSI source string into a Unicode string using the
///current ANSI code page.
///Params:
///    UnicodeString = Pointer to the buffer that receives the resultant Unicode string.
///    MaxBytesInUnicodeString = Supplies the maximum number of bytes to be written to <i>UnicodeString. </i>If this value is too small, causing
///                              <i>UnicodeString</i> to be a truncated equivalent of <i>MultiByteString</i>, no error condition results.
///    BytesInUnicodeString = Pointer to a ULONG that receives the number of bytes written to <i>UnicodeString</i>.
///    MultiByteString = Pointer to the ANSI source string that is to be converted to Unicode.
///    BytesInMultiByteString = Specifies the number of bytes in <i>MultiByteString.</i>
///Returns:
///    None
///    
@DllImport("GDI32")
void EngMultiByteToUnicodeN(const(wchar)* UnicodeString, uint MaxBytesInUnicodeString, uint* BytesInUnicodeString, 
                            const(char)* MultiByteString, uint BytesInMultiByteString);

///The <b>EngUnicodeToMultiByteN</b> function converts the specified Unicode string into an ANSI string using the
///current ANSI code page.
///Params:
///    MultiByteString = Pointer to the buffer that receives the resultant ANSI string.
///    MaxBytesInMultiByteString = Specifies the maximum number of bytes to be written to <i>MultiByteString. </i>If this value is too small,
///                                causing <i>MultiByteString</i> to be a truncated equivalent of <i>UnicodeString</i>, then no error condition
///                                results.
///    BytesInMultiByteString = Pointer to a ULONG that receives the number of bytes written to <i>MultiByteString</i>.
///    UnicodeString = Pointer to the Unicode source string that is to be converted to ANSI.
///    BytesInUnicodeString = Specifies the number of bytes in <i>UnicodeString.</i>
///Returns:
///    None
///    
@DllImport("GDI32")
void EngUnicodeToMultiByteN(const(char)* MultiByteString, uint MaxBytesInMultiByteString, 
                            uint* BytesInMultiByteString, const(wchar)* UnicodeString, uint BytesInUnicodeString);

///The <b>EngQueryLocalTime</b> function queries the local time.
///Params:
///    Arg1 = Pointer to an ENG_TIME_FIELDS structure that receives the local time.
///Returns:
///    None
///    
@DllImport("GDI32")
void EngQueryLocalTime(ENG_TIME_FIELDS* param0);

///The <b>EngComputeGlyphSet</b> function computes the glyph set supported on a device.
///Params:
///    nCodePage = Specifies the code page supported.
///    nFirstChar = Specifies the character code of the first supported ANSI character.
///    cChars = Specifies the number of ANSI characters supported.
///Returns:
///    If the glyph set is computed successfully, the function returns a pointer to an FD_GLYPHSET structure. If an
///    error occurs, the function returns <b>NULL</b>.
///    
@DllImport("GDI32")
FD_GLYPHSET* EngComputeGlyphSet(int nCodePage, int nFirstChar, int cChars);

///The <b>EngMultiByteToWideChar</b> function converts an ANSI source string into a wide character string using the
///specified code page.
///Params:
///    CodePage = Specifies the code page to use to perform the translation.
///    WideCharString = Pointer to the buffer into which the translated character string is copied.
///    BytesInWideCharString = Specifies the size, in bytes, of <i>WideCharString</i>. If <i>WideCharString</i> is not large enough to contain
///                            the translation, <b>EngMultiByteToWideChar</b> truncates the string, and does not report an error.
///    MultiByteString = Pointer to the buffer containing the multibyte string to be translated.
///    BytesInMultiByteString = Specifies the number of bytes in <i>MultiByteString.</i>
///Returns:
///    The <b>EngMultiByteToWideChar</b> function returns the number of bytes it converted to wide character form, if
///    successful. Otherwise, the function returns -1.
///    
@DllImport("GDI32")
int EngMultiByteToWideChar(uint CodePage, const(wchar)* WideCharString, int BytesInWideCharString, 
                           const(char)* MultiByteString, int BytesInMultiByteString);

///The <b>EngWideCharToMultiByte</b> function converts a wide character string into an ANSI source string using the
///specified code page.
///Params:
///    CodePage = Specifies the code page to use to perform the translation.
///    WideCharString = Pointer to a buffer containing the wide character string to be translated.
///    BytesInWideCharString = Specifies the size, in bytes, of <i>WideCharString</i>.
///    MultiByteString = Pointer to a buffer into which the translated character string is to be copied
///    BytesInMultiByteString = Specifies the number of bytes in <i>MultiByteString</i>. If <i>MultiByteString</i> is not large enough to contain
///                             the translation, <b>EngWideCharToMultiByte</b> truncates the string, and does not report an error.
///Returns:
///    <b>EngWideCharToMultiByte</b> returns the number of bytes converted into multibyte form, if successful.
///    Otherwise, it returns -1.
///    
@DllImport("GDI32")
int EngWideCharToMultiByte(uint CodePage, const(wchar)* WideCharString, int BytesInWideCharString, 
                           const(char)* MultiByteString, int BytesInMultiByteString);

///The <b>EngGetCurrentCodePage</b> function returns the system's default OEM and ANSI code pages.
///Params:
///    OemCodePage = Pointer to a USHORT that receives the system's default OEM code page.
///    AnsiCodePage = Pointer to a USHORT that receives the system's default ANSI code page.
///Returns:
///    None
///    
@DllImport("GDI32")
void EngGetCurrentCodePage(ushort* OemCodePage, ushort* AnsiCodePage);

///The <b>GetDisplayConfigBufferSizes</b> function retrieves the size of the buffers that are required to call the
///QueryDisplayConfig function.
///Params:
///    flags = The type of information to retrieve. The value for the <i>Flags</i> parameter must be one of the following
///            values.
///    numPathArrayElements = Pointer to a variable that receives the number of elements in the path information table. The
///                           <i>pNumPathArrayElements</i> parameter value is then used by a subsequent call to the QueryDisplayConfig
///                           function. This parameter cannot be <b>NULL</b>.
///    numModeInfoArrayElements = Pointer to a variable that receives the number of elements in the mode information table. The
///                               <i>pNumModeInfoArrayElements</i> parameter value is then used by a subsequent call to the QueryDisplayConfig
///                               function. This parameter cannot be <b>NULL</b>.
///Returns:
///    The function returns one of the following return codes. <table> <tr> <th>Return code</th> <th>Description</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_SUCCESS</b></dt> </dl> </td> <td width="60%"> The function
///    succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> The combination of parameters and flags that are specified is invalid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The system is not running a
///    graphics driver that was written according to the Windows Display Driver Model (WDDM). The function is only
///    supported on a system with a WDDM driver running. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The caller does not have access to the console
///    session. This error occurs if the calling process does not have access to the current desktop or is running on a
///    remote session. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_GEN_FAILURE</b></dt> </dl> </td> <td
///    width="60%"> An unspecified error occurred. </td> </tr> </table>
///    
@DllImport("USER32")
int GetDisplayConfigBufferSizes(uint flags, uint* numPathArrayElements, uint* numModeInfoArrayElements);

///The <b>SetDisplayConfig</b> function modifies the display topology, source, and target modes by exclusively enabling
///the specified paths in the current session.
///Params:
///    numPathArrayElements = Number of elements in <i>pathArray</i>.
///    pathArray = Array of all display paths that are to be set. Only the paths within this array that have the
///                DISPLAYCONFIG_PATH_ACTIVE flag set in the <b>flags</b> member of DISPLAYCONFIG_PATH_INFO are set. This parameter
///                can be <b>NULL</b>. The order in which active paths appear in this array determines the path priority. For more
///                information about path priority order, see Path Priority Order.
///    numModeInfoArrayElements = Number of elements in <i>modeInfoArray</i>.
///    modeInfoArray = Array of display source and target mode information (DISPLAYCONFIG_MODE_INFO) that is referenced by the
///                    <b>modeInfoIdx</b> member of DISPLAYCONFIG_PATH_SOURCE_INFO and DISPLAYCONFIG_PATH_TARGET_INFO element of path
///                    information from <i>pathArray</i>. This parameter can be <b>NULL</b>.
///    flags = A bitwise OR of flag values that indicates the behavior of this function. This parameter can be one the following
///            values, or a combination of the following values; 0 is not valid.
///Returns:
///    The function returns one of the following return codes. <table> <tr> <th>Return code</th> <th>Description</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_SUCCESS</b></dt> </dl> </td> <td width="60%"> The function
///    succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> The combination of parameters and flags specified is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The system is not running a graphics driver that
///    was written according to the Windows Display Driver Model (WDDM). The function is only supported on a system with
///    a WDDM driver running. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td
///    width="60%"> The caller does not have access to the console session. This error occurs if the calling process
///    does not have access to the current desktop or is running on a remote session. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_GEN_FAILURE</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_CONFIGURATION</b></dt> </dl> </td> <td width="60%"> The function
///    could not find a workable solution for the source and target modes that the caller did not specify. </td> </tr>
///    </table>
///    
@DllImport("USER32")
int SetDisplayConfig(uint numPathArrayElements, char* pathArray, uint numModeInfoArrayElements, 
                     char* modeInfoArray, uint flags);

///The <b>QueryDisplayConfig</b> function retrieves information about all possible display paths for all display
///devices, or views, in the current setting.
///Params:
///    flags = The type of information to retrieve. The value for the <i>Flags</i> parameter must be one of the following
///            values.
///    numPathArrayElements = Pointer to a variable that contains the number of elements in <i>pPathInfoArray</i>. This parameter cannot be
///                           <b>NULL</b>. If <b>QueryDisplayConfig</b> returns ERROR_SUCCESS, <i>pNumPathInfoElements</i> is updated with the
///                           number of valid entries in <i>pPathInfoArray</i>.
///    pathArray = Pointer to a variable that contains an array of DISPLAYCONFIG_PATH_INFO elements. Each element in
///                <i>pPathInfoArray</i> describes a single path from a source to a target. The source and target mode information
///                indexes are only valid in combination with the <i>pmodeInfoArray</i> tables that are returned for the API at the
///                same time. This parameter cannot be <b>NULL</b>. The <i>pPathInfoArray</i> is always returned in path priority
///                order. For more information about path priority order, see Path Priority Order.
///    numModeInfoArrayElements = Pointer to a variable that specifies the number in element of the mode information table. This parameter cannot
///                               be <b>NULL</b>. If <b>QueryDisplayConfig</b> returns ERROR_SUCCESS, <i>pNumModeInfoArrayElements</i> is updated
///                               with the number of valid entries in <i>pModeInfoArray</i>.
///    modeInfoArray = Pointer to a variable that contains an array of DISPLAYCONFIG_MODE_INFO elements. This parameter cannot be
///                    <b>NULL</b>.
///    currentTopologyId = Pointer to a variable that receives the identifier of the currently active topology in the CCD database. For a
///                        list of possible values, see the DISPLAYCONFIG_TOPOLOGY_ID enumerated type. The <i>pCurrentTopologyId</i>
///                        parameter is only set when the <i>Flags</i> parameter value is QDC_DATABASE_CURRENT. If the <i>Flags</i>
///                        parameter value is set to QDC_DATABASE_CURRENT, the <i>pCurrentTopologyId</i> parameter must not be <b>NULL</b>.
///                        If the <i>Flags</i> parameter value is not set to QDC_DATABASE_CURRENT, the <i>pCurrentTopologyId</i> parameter
///                        value must be <b>NULL</b>.
///Returns:
///    The function returns one of the following return codes. <table> <tr> <th>Return code</th> <th>Description</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_SUCCESS</b></dt> </dl> </td> <td width="60%"> The function
///    succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> The combination of parameters and flags that are specified is invalid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The system is not running a
///    graphics driver that was written according to the Windows Display Driver Model (WDDM). The function is only
///    supported on a system with a WDDM driver running. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The caller does not have access to the console
///    session. This error occurs if the calling process does not have access to the current desktop or is running on a
///    remote session. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_GEN_FAILURE</b></dt> </dl> </td> <td
///    width="60%"> An unspecified error occurred. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The supplied path and mode buffer are too
///    small. </td> </tr> </table>
///    
@DllImport("USER32")
int QueryDisplayConfig(uint flags, uint* numPathArrayElements, char* pathArray, uint* numModeInfoArrayElements, 
                       char* modeInfoArray, DISPLAYCONFIG_TOPOLOGY_ID* currentTopologyId);

///The <b>DisplayConfigGetDeviceInfo</b> function retrieves display configuration information about the device.
///Params:
///    requestPacket = A pointer to a DISPLAYCONFIG_DEVICE_INFO_HEADER structure. This structure contains information about the request,
///                    which includes the packet type in the <b>type</b> member. The type and size of additional data that
///                    <b>DisplayConfigGetDeviceInfo</b> returns after the header structure depend on the packet type.
///Returns:
///    The function returns one of the following return codes. <table> <tr> <th>Return code</th> <th>Description</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_SUCCESS</b></dt> </dl> </td> <td width="60%"> The function
///    succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> The combination of parameters and flags specified are invalid. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The system is not running a graphics driver
///    that was written according to the Windows Display Driver Model (WDDM). The function is only supported on a system
///    with a WDDM driver running. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl>
///    </td> <td width="60%"> The caller does not have access to the console session. This error occurs if the calling
///    process does not have access to the current desktop or is running on a remote session. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The size of the packet
///    that the caller passes is not big enough for the information that the caller requests. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_GEN_FAILURE</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred.
///    </td> </tr> </table>
///    
@DllImport("USER32")
int DisplayConfigGetDeviceInfo(DISPLAYCONFIG_DEVICE_INFO_HEADER* requestPacket);

///The <b>DisplayConfigSetDeviceInfo</b> function sets the properties of a target.
///Params:
///    setPacket = A pointer to a DISPLAYCONFIG_DEVICE_INFO_HEADER structure that contains information to set for the device. The
///                type and size of additional data that <b>DisplayConfigSetDeviceInfo</b> uses for the configuration comes after
///                the header structure. This additional data depends on the packet type, as specified by the <b>type</b> member of
///                DISPLAYCONFIG_DEVICE_INFO_HEADER. For example, if the caller wants to change the boot persistence, that caller
///                allocates and fills a DISPLAYCONFIG_SET_TARGET_PERSISTENCE structure and passes a pointer to this structure in
///                <i>setPacket</i>. Note that the first member of the DISPLAYCONFIG_SET_TARGET_PERSISTENCE structure is the
///                DISPLAYCONFIG_DEVICE_INFO_HEADER.
///Returns:
///    The function returns one of the following return codes. <table> <tr> <th>Return code</th> <th>Description</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_SUCCESS</b></dt> </dl> </td> <td width="60%"> The function
///    succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> The combination of parameters and flags specified are invalid. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The system is not running a graphics driver
///    that was written according to the Windows Display Driver Model (WDDM). The function is only supported on a system
///    with a WDDM driver running. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl>
///    </td> <td width="60%"> The caller does not have access to the console session. This error occurs if the calling
///    process does not have access to the current desktop or is running on a remote session. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The size of the packet
///    that the caller passes is not big enough. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_GEN_FAILURE</b></dt> </dl> </td> <td width="60%"> An unspecified error occurred. </td> </tr>
///    </table>
///    
@DllImport("USER32")
int DisplayConfigSetDeviceInfo(DISPLAYCONFIG_DEVICE_INFO_HEADER* setPacket);


// Interfaces

///IDirectDrawKernel interface
interface IDirectDrawKernel : IUnknown
{
    ///The <b>IDirectDrawKernel::GetCaps</b> method returns the capabilities of this kernel-mode device.
    ///Params:
    ///    arg1 = Caller-supplied pointer to a DDKERNELCAPS structure into which the kernel-mode capabilities of the DirectDraw
    ///           device are returned.
    HRESULT GetCaps(DDKERNELCAPS* param0);
    ///The <b>IDirectDrawKernel::GetKernelHandle</b> method returns a kernel-mode handle to the DirectDraw object.
    ///Params:
    ///    arg1 = Caller-supplied pointer into which the kernel-mode handle of the DirectDraw object is returned.
    HRESULT GetKernelHandle(uint* param0);
    ///The <b>IDirectDrawKernel::ReleaseKernelHandle</b> method releases a kernel-mode handle to the DirectDraw object.
    HRESULT ReleaseKernelHandle();
}

///IDirectDrawSurfaceKernel interface
interface IDirectDrawSurfaceKernel : IUnknown
{
    ///The <b>IDirectDrawSurfaceKernel::GetKernelHandle</b> method returns a kernel-mode handle to the DirectDraw
    ///surface.
    ///Params:
    ///    arg1 = Caller-supplied pointer into which the kernel-mode handle of the DirectDraw surface is returned.
    HRESULT GetKernelHandle(uint* param0);
    ///The <b>IDirectDrawSurfaceKernel::ReleaseKernelHandle</b> method releases a kernel-mode handle to the DirectDraw
    ///surface.
    HRESULT ReleaseKernelHandle();
}


