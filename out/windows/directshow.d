module windows.directshow;

public import windows.core;
public import windows.audio : IDirectSound, IDirectSoundBuffer;
public import windows.automation : BSTR, IDispatch, IEnumVARIANT, IErrorLog, IPropertyBag, SAFEARRAY, VARIANT;
public import windows.com : HRESULT, IBindCtx, IEnumGUID, IEnumMoniker, IMoniker, IPersist, IPictureDisp, IUnknown;
public import windows.coreaudio : DDVIDEOPORTCONNECT, KSDATAFORMAT, KSEVENTDATA, KSIDENTIFIER, KSM_NODE, KSP_NODE,
                                  KS_COMPRESSION, KS_FRAMING_RANGE, KS_FRAMING_RANGE_WEIGHTED;
public import windows.direct2d : IDirect3DDevice9, IDirect3DSurface9, PALETTEENTRY;
public import windows.direct3d9 : D3DFORMAT, D3DPOOL;
public import windows.directdraw : DDCAPS_DX7, DDCOLORCONTROL, DDPIXELFORMAT, DDSCAPS2, DDSURFACEDESC, IDirectDraw,
                                   IDirectDraw7, IDirectDrawPalette, IDirectDrawSurface, IDirectDrawSurface7;
public import windows.displaydevices : POINT, RECT, SIZE;
public import windows.gdi : BITMAPINFO, HDC, RGBQUAD, RGNDATA;
public import windows.mediafoundation : IMFVideoPresenter;
public import windows.menusandresources : HACCEL;
public import windows.multimedia : WAVEFORMATEX;
public import windows.systemservices : BOOL, HANDLE, LARGE_INTEGER, PAPCFUNC;
public import windows.windowsandmessaging : HWND;
public import windows.windowsmediaformat : IWMProfile;
public import windows.windowsprogramming : HKEY, IXMLElement;

extern(Windows):


// Enums


enum : int
{
    READYSTATE_UNINITIALIZED = 0x00000000,
    READYSTATE_LOADING       = 0x00000001,
    READYSTATE_LOADED        = 0x00000002,
    READYSTATE_INTERACTIVE   = 0x00000003,
    READYSTATE_COMPLETE      = 0x00000004,
}
alias READYSTATE = int;

enum : int
{
    AMVP_DO_NOT_CARE          = 0x00000000,
    AMVP_BEST_BANDWIDTH       = 0x00000001,
    AMVP_INPUT_SAME_AS_OUTPUT = 0x00000002,
}
alias AMVP_SELECT_FORMAT_BY = int;

enum : int
{
    AMVP_MODE_WEAVE             = 0x00000000,
    AMVP_MODE_BOBINTERLEAVED    = 0x00000001,
    AMVP_MODE_BOBNONINTERLEAVED = 0x00000002,
    AMVP_MODE_SKIPEVEN          = 0x00000003,
    AMVP_MODE_SKIPODD           = 0x00000004,
}
alias AMVP_MODE = int;

enum : int
{
    PINDIR_INPUT  = 0x00000000,
    PINDIR_OUTPUT = 0x00000001,
}
alias PIN_DIRECTION = int;

enum : int
{
    State_Stopped = 0x00000000,
    State_Paused  = 0x00000001,
    State_Running = 0x00000002,
}
alias FILTER_STATE = int;

enum : int
{
    AM_SAMPLE_SPLICEPOINT       = 0x00000001,
    AM_SAMPLE_PREROLL           = 0x00000002,
    AM_SAMPLE_DATADISCONTINUITY = 0x00000004,
    AM_SAMPLE_TYPECHANGED       = 0x00000008,
    AM_SAMPLE_TIMEVALID         = 0x00000010,
    AM_SAMPLE_TIMEDISCONTINUITY = 0x00000040,
    AM_SAMPLE_FLUSH_ON_PAUSE    = 0x00000080,
    AM_SAMPLE_STOPVALID         = 0x00000100,
    AM_SAMPLE_ENDOFSTREAM       = 0x00000200,
    AM_STREAM_MEDIA             = 0x00000000,
    AM_STREAM_CONTROL           = 0x00000001,
}
alias tagAM_SAMPLE_PROPERTY_FLAGS = int;

enum : int
{
    AM_SEEKING_NoPositioning          = 0x00000000,
    AM_SEEKING_AbsolutePositioning    = 0x00000001,
    AM_SEEKING_RelativePositioning    = 0x00000002,
    AM_SEEKING_IncrementalPositioning = 0x00000003,
    AM_SEEKING_PositioningBitsMask    = 0x00000003,
    AM_SEEKING_SeekToKeyFrame         = 0x00000004,
    AM_SEEKING_ReturnTime             = 0x00000008,
    AM_SEEKING_Segment                = 0x00000010,
    AM_SEEKING_NoFlush                = 0x00000020,
}
alias AM_SEEKING_SeekingFlags = int;

enum : int
{
    AM_SEEKING_CanSeekAbsolute  = 0x00000001,
    AM_SEEKING_CanSeekForwards  = 0x00000002,
    AM_SEEKING_CanSeekBackwards = 0x00000004,
    AM_SEEKING_CanGetCurrentPos = 0x00000008,
    AM_SEEKING_CanGetStopPos    = 0x00000010,
    AM_SEEKING_CanGetDuration   = 0x00000020,
    AM_SEEKING_CanPlayBackwards = 0x00000040,
    AM_SEEKING_CanDoSegments    = 0x00000080,
    AM_SEEKING_Source           = 0x00000100,
}
alias AM_SEEKING_SEEKING_CAPABILITIES = int;

enum : int
{
    AM_MEDIAEVENT_NONOTIFY = 0x00000001,
}
alias tagAM_MEDIAEVENT_FLAGS = int;

enum : int
{
    MERIT_PREFERRED     = 0x00800000,
    MERIT_NORMAL        = 0x00600000,
    MERIT_UNLIKELY      = 0x00400000,
    MERIT_DO_NOT_USE    = 0x00200000,
    MERIT_SW_COMPRESSOR = 0x00100000,
    MERIT_HW_COMPRESSOR = 0x00100050,
}
alias __MIDL_IFilterMapper_0001 = int;

enum : int
{
    REG_PINFLAG_B_ZERO     = 0x00000001,
    REG_PINFLAG_B_RENDERER = 0x00000002,
    REG_PINFLAG_B_MANY     = 0x00000004,
    REG_PINFLAG_B_OUTPUT   = 0x00000008,
}
alias __MIDL___MIDL_itf_strmif_0000_0023_0001 = int;

enum QualityMessageType : int
{
    Famine  = 0x00000000,
    Flood   = 0x00000001,
}

enum : int
{
    CK_NOCOLORKEY = 0x00000000,
    CK_INDEX      = 0x00000001,
    CK_RGB        = 0x00000002,
}
alias __MIDL___MIDL_itf_strmif_0000_0026_0001 = int;

enum : int
{
    ADVISE_NONE           = 0x00000000,
    ADVISE_CLIPPING       = 0x00000001,
    ADVISE_PALETTE        = 0x00000002,
    ADVISE_COLORKEY       = 0x00000004,
    ADVISE_POSITION       = 0x00000008,
    ADVISE_DISPLAY_CHANGE = 0x00000010,
}
alias __MIDL___MIDL_itf_strmif_0000_0026_0002 = int;

enum : int
{
    AM_FILE_OVERWRITE = 0x00000001,
}
alias AM_FILESINK_FLAGS = int;

enum : int
{
    AM_RENDEREX_RENDERTOEXISTINGRENDERERS = 0x00000001,
}
alias _AM_RENSDEREXFLAGS = int;

enum : int
{
    AM_STREAM_INFO_START_DEFINED   = 0x00000001,
    AM_STREAM_INFO_STOP_DEFINED    = 0x00000002,
    AM_STREAM_INFO_DISCARDING      = 0x00000004,
    AM_STREAM_INFO_STOP_SEND_EXTRA = 0x00000010,
}
alias AM_STREAM_INFO_FLAGS = int;

enum InterleavingMode : int
{
    INTERLEAVE_NONE          = 0x00000000,
    INTERLEAVE_CAPTURE       = 0x00000001,
    INTERLEAVE_FULL          = 0x00000002,
    INTERLEAVE_NONE_BUFFERED = 0x00000003,
}

enum CompressionCaps : int
{
    CompressionCaps_CanQuality  = 0x00000001,
    CompressionCaps_CanCrunch   = 0x00000002,
    CompressionCaps_CanKeyFrame = 0x00000004,
    CompressionCaps_CanBFrame   = 0x00000008,
    CompressionCaps_CanWindow   = 0x00000010,
}

enum VfwCaptureDialogs : int
{
    VfwCaptureDialog_Source  = 0x00000001,
    VfwCaptureDialog_Format  = 0x00000002,
    VfwCaptureDialog_Display = 0x00000004,
}

enum VfwCompressDialogs : int
{
    VfwCompressDialog_Config      = 0x00000001,
    VfwCompressDialog_About       = 0x00000002,
    VfwCompressDialog_QueryConfig = 0x00000004,
    VfwCompressDialog_QueryAbout  = 0x00000008,
}

enum AnalogVideoStandard : int
{
    AnalogVideo_None          = 0x00000000,
    AnalogVideo_NTSC_M        = 0x00000001,
    AnalogVideo_NTSC_M_J      = 0x00000002,
    AnalogVideo_NTSC_433      = 0x00000004,
    AnalogVideo_PAL_B         = 0x00000010,
    AnalogVideo_PAL_D         = 0x00000020,
    AnalogVideo_PAL_G         = 0x00000040,
    AnalogVideo_PAL_H         = 0x00000080,
    AnalogVideo_PAL_I         = 0x00000100,
    AnalogVideo_PAL_M         = 0x00000200,
    AnalogVideo_PAL_N         = 0x00000400,
    AnalogVideo_PAL_60        = 0x00000800,
    AnalogVideo_SECAM_B       = 0x00001000,
    AnalogVideo_SECAM_D       = 0x00002000,
    AnalogVideo_SECAM_G       = 0x00004000,
    AnalogVideo_SECAM_H       = 0x00008000,
    AnalogVideo_SECAM_K       = 0x00010000,
    AnalogVideo_SECAM_K1      = 0x00020000,
    AnalogVideo_SECAM_L       = 0x00040000,
    AnalogVideo_SECAM_L1      = 0x00080000,
    AnalogVideo_PAL_N_COMBO   = 0x00100000,
    AnalogVideoMask_MCE_NTSC  = 0x00100e07,
    AnalogVideoMask_MCE_PAL   = 0x000001f0,
    AnalogVideoMask_MCE_SECAM = 0x000ff000,
}

enum TunerInputType : int
{
    TunerInputCable   = 0x00000000,
    TunerInputAntenna = 0x00000001,
}

enum VideoCopyProtectionType : int
{
    VideoCopyProtectionMacrovisionBasic = 0x00000000,
    VideoCopyProtectionMacrovisionCBI   = 0x00000001,
}

enum PhysicalConnectorType : int
{
    PhysConn_Video_Tuner           = 0x00000001,
    PhysConn_Video_Composite       = 0x00000002,
    PhysConn_Video_SVideo          = 0x00000003,
    PhysConn_Video_RGB             = 0x00000004,
    PhysConn_Video_YRYBY           = 0x00000005,
    PhysConn_Video_SerialDigital   = 0x00000006,
    PhysConn_Video_ParallelDigital = 0x00000007,
    PhysConn_Video_SCSI            = 0x00000008,
    PhysConn_Video_AUX             = 0x00000009,
    PhysConn_Video_1394            = 0x0000000a,
    PhysConn_Video_USB             = 0x0000000b,
    PhysConn_Video_VideoDecoder    = 0x0000000c,
    PhysConn_Video_VideoEncoder    = 0x0000000d,
    PhysConn_Video_SCART           = 0x0000000e,
    PhysConn_Video_Black           = 0x0000000f,
    PhysConn_Audio_Tuner           = 0x00001000,
    PhysConn_Audio_Line            = 0x00001001,
    PhysConn_Audio_Mic             = 0x00001002,
    PhysConn_Audio_AESDigital      = 0x00001003,
    PhysConn_Audio_SPDIFDigital    = 0x00001004,
    PhysConn_Audio_SCSI            = 0x00001005,
    PhysConn_Audio_AUX             = 0x00001006,
    PhysConn_Audio_1394            = 0x00001007,
    PhysConn_Audio_USB             = 0x00001008,
    PhysConn_Audio_AudioDecoder    = 0x00001009,
}

enum VideoProcAmpProperty : int
{
    VideoProcAmp_Brightness            = 0x00000000,
    VideoProcAmp_Contrast              = 0x00000001,
    VideoProcAmp_Hue                   = 0x00000002,
    VideoProcAmp_Saturation            = 0x00000003,
    VideoProcAmp_Sharpness             = 0x00000004,
    VideoProcAmp_Gamma                 = 0x00000005,
    VideoProcAmp_ColorEnable           = 0x00000006,
    VideoProcAmp_WhiteBalance          = 0x00000007,
    VideoProcAmp_BacklightCompensation = 0x00000008,
    VideoProcAmp_Gain                  = 0x00000009,
}

enum VideoProcAmpFlags : int
{
    VideoProcAmp_Flags_Auto   = 0x00000001,
    VideoProcAmp_Flags_Manual = 0x00000002,
}

enum CameraControlProperty : int
{
    CameraControl_Pan      = 0x00000000,
    CameraControl_Tilt     = 0x00000001,
    CameraControl_Roll     = 0x00000002,
    CameraControl_Zoom     = 0x00000003,
    CameraControl_Exposure = 0x00000004,
    CameraControl_Iris     = 0x00000005,
    CameraControl_Focus    = 0x00000006,
}

enum CameraControlFlags : int
{
    CameraControl_Flags_Auto   = 0x00000001,
    CameraControl_Flags_Manual = 0x00000002,
}

enum VideoControlFlags : int
{
    VideoControlFlag_FlipHorizontal        = 0x00000001,
    VideoControlFlag_FlipVertical          = 0x00000002,
    VideoControlFlag_ExternalTriggerEnable = 0x00000004,
    VideoControlFlag_Trigger               = 0x00000008,
}

enum AMTunerSubChannel : int
{
    AMTUNER_SUBCHAN_NO_TUNE = 0xfffffffe,
    AMTUNER_SUBCHAN_DEFAULT = 0xffffffff,
}

enum AMTunerSignalStrength : int
{
    AMTUNER_HASNOSIGNALSTRENGTH = 0xffffffff,
    AMTUNER_NOSIGNAL            = 0x00000000,
    AMTUNER_SIGNALPRESENT       = 0x00000001,
}

enum AMTunerModeType : int
{
    AMTUNER_MODE_DEFAULT  = 0x00000000,
    AMTUNER_MODE_TV       = 0x00000001,
    AMTUNER_MODE_FM_RADIO = 0x00000002,
    AMTUNER_MODE_AM_RADIO = 0x00000004,
    AMTUNER_MODE_DSS      = 0x00000008,
}

enum AMTunerEventType : int
{
    AMTUNER_EVENT_CHANGED = 0x00000001,
}

enum TVAudioMode : int
{
    AMTVAUDIO_MODE_MONO     = 0x00000001,
    AMTVAUDIO_MODE_STEREO   = 0x00000002,
    AMTVAUDIO_MODE_LANG_A   = 0x00000010,
    AMTVAUDIO_MODE_LANG_B   = 0x00000020,
    AMTVAUDIO_MODE_LANG_C   = 0x00000040,
    AMTVAUDIO_PRESET_STEREO = 0x00000200,
    AMTVAUDIO_PRESET_LANG_A = 0x00001000,
    AMTVAUDIO_PRESET_LANG_B = 0x00002000,
    AMTVAUDIO_PRESET_LANG_C = 0x00004000,
}

enum AMTVAudioEventType : int
{
    AMTVAUDIO_EVENT_CHANGED = 0x00000001,
}

enum : int
{
    AMPROPERTY_PIN_CATEGORY = 0x00000000,
    AMPROPERTY_PIN_MEDIUM   = 0x00000001,
}
alias AMPROPERTY_PIN = int;

enum : int
{
    AMSTREAMSELECTINFO_ENABLED   = 0x00000001,
    AMSTREAMSELECTINFO_EXCLUSIVE = 0x00000002,
}
alias _AMSTREAMSELECTINFOFLAGS = int;

enum : int
{
    AMSTREAMSELECTENABLE_ENABLE    = 0x00000001,
    AMSTREAMSELECTENABLE_ENABLEALL = 0x00000002,
}
alias _AMSTREAMSELECTENABLEFLAGS = int;

enum : int
{
    AMRESCTL_RESERVEFLAGS_RESERVE   = 0x00000000,
    AMRESCTL_RESERVEFLAGS_UNRESERVE = 0x00000001,
}
alias _AMRESCTL_RESERVEFLAGS = int;

enum : int
{
    AM_FILTER_MISC_FLAGS_IS_RENDERER = 0x00000001,
    AM_FILTER_MISC_FLAGS_IS_SOURCE   = 0x00000002,
}
alias _AM_FILTER_MISC_FLAGS = int;

enum : int
{
    DECIMATION_LEGACY             = 0x00000000,
    DECIMATION_USE_DECODER_ONLY   = 0x00000001,
    DECIMATION_USE_VIDEOPORT_ONLY = 0x00000002,
    DECIMATION_USE_OVERLAY_ONLY   = 0x00000003,
    DECIMATION_DEFAULT            = 0x00000004,
}
alias DECIMATION_USAGE = int;

enum : int
{
    AM_PUSHSOURCECAPS_INTERNAL_RM      = 0x00000001,
    AM_PUSHSOURCECAPS_NOT_LIVE         = 0x00000002,
    AM_PUSHSOURCECAPS_PRIVATE_CLOCK    = 0x00000004,
    AM_PUSHSOURCEREQS_USE_STREAM_CLOCK = 0x00010000,
    AM_PUSHSOURCEREQS_USE_CLOCK_CHAIN  = 0x00020000,
}
alias _AM_PUSHSOURCE_FLAGS = int;

enum : int
{
    DVENCODERRESOLUTION_720x480 = 0x000007dc,
    DVENCODERRESOLUTION_360x240 = 0x000007dd,
    DVENCODERRESOLUTION_180x120 = 0x000007de,
    DVENCODERRESOLUTION_88x60   = 0x000007df,
}
alias _DVENCODERRESOLUTION = int;

enum : int
{
    DVENCODERVIDEOFORMAT_NTSC = 0x000007d0,
    DVENCODERVIDEOFORMAT_PAL  = 0x000007d1,
}
alias _DVENCODERVIDEOFORMAT = int;

enum : int
{
    DVENCODERFORMAT_DVSD = 0x000007d7,
    DVENCODERFORMAT_DVHD = 0x000007d8,
    DVENCODERFORMAT_DVSL = 0x000007d9,
}
alias _DVENCODERFORMAT = int;

enum : int
{
    DVDECODERRESOLUTION_720x480 = 0x000003e8,
    DVDECODERRESOLUTION_360x240 = 0x000003e9,
    DVDECODERRESOLUTION_180x120 = 0x000003ea,
    DVDECODERRESOLUTION_88x60   = 0x000003eb,
}
alias _DVDECODERRESOLUTION = int;

enum : int
{
    DVRESOLUTION_FULL    = 0x000003e8,
    DVRESOLUTION_HALF    = 0x000003e9,
    DVRESOLUTION_QUARTER = 0x000003ea,
    DVRESOLUTION_DC      = 0x000003eb,
}
alias _DVRESOLUTION = int;

enum : int
{
    AM_AUDREND_STAT_PARAM_BREAK_COUNT            = 0x00000001,
    AM_AUDREND_STAT_PARAM_SLAVE_MODE             = 0x00000002,
    AM_AUDREND_STAT_PARAM_SILENCE_DUR            = 0x00000003,
    AM_AUDREND_STAT_PARAM_LAST_BUFFER_DUR        = 0x00000004,
    AM_AUDREND_STAT_PARAM_DISCONTINUITIES        = 0x00000005,
    AM_AUDREND_STAT_PARAM_SLAVE_RATE             = 0x00000006,
    AM_AUDREND_STAT_PARAM_SLAVE_DROPWRITE_DUR    = 0x00000007,
    AM_AUDREND_STAT_PARAM_SLAVE_HIGHLOWERROR     = 0x00000008,
    AM_AUDREND_STAT_PARAM_SLAVE_LASTHIGHLOWERROR = 0x00000009,
    AM_AUDREND_STAT_PARAM_SLAVE_ACCUMERROR       = 0x0000000a,
    AM_AUDREND_STAT_PARAM_BUFFERFULLNESS         = 0x0000000b,
    AM_AUDREND_STAT_PARAM_JITTER                 = 0x0000000c,
}
alias _AM_AUDIO_RENDERER_STAT_PARAM = int;

enum : int
{
    AM_INTF_SEARCH_INPUT_PIN  = 0x00000001,
    AM_INTF_SEARCH_OUTPUT_PIN = 0x00000002,
    AM_INTF_SEARCH_FILTER     = 0x00000004,
}
alias _AM_INTF_SEARCH_FLAGS = int;

enum : int
{
    AMOVERFX_NOFX            = 0x00000000,
    AMOVERFX_MIRRORLEFTRIGHT = 0x00000002,
    AMOVERFX_MIRRORUPDOWN    = 0x00000004,
    AMOVERFX_DEINTERLACE     = 0x00000008,
}
alias AMOVERLAYFX = int;

enum : int
{
    AM_PIN_FLOW_CONTROL_BLOCK = 0x00000001,
}
alias _AM_PIN_FLOW_CONTROL_BLOCK_FLAGS = int;

enum : int
{
    AM_GRAPH_CONFIG_RECONNECT_DIRECTCONNECT           = 0x00000001,
    AM_GRAPH_CONFIG_RECONNECT_CACHE_REMOVED_FILTERS   = 0x00000002,
    AM_GRAPH_CONFIG_RECONNECT_USE_ONLY_CACHED_FILTERS = 0x00000004,
}
alias AM_GRAPH_CONFIG_RECONNECT_FLAGS = int;

enum : int
{
    REMFILTERF_LEAVECONNECTED = 0x00000001,
}
alias _REM_FILTER_FLAGS = int;

enum : int
{
    AM_FILTER_FLAGS_REMOVABLE = 0x00000001,
}
alias AM_FILTER_FLAGS = int;

enum VMRPresentationFlags : int
{
    VMRSample_SyncPoint        = 0x00000001,
    VMRSample_Preroll          = 0x00000002,
    VMRSample_Discontinuity    = 0x00000004,
    VMRSample_TimeValid        = 0x00000008,
    VMRSample_SrcDstRectsValid = 0x00000010,
}

enum VMRSurfaceAllocationFlags : int
{
    AMAP_PIXELFORMAT_VALID = 0x00000001,
    AMAP_3D_TARGET         = 0x00000002,
    AMAP_ALLOW_SYSMEM      = 0x00000004,
    AMAP_FORCE_SYSMEM      = 0x00000008,
    AMAP_DIRECTED_FLIP     = 0x00000010,
    AMAP_DXVA_TARGET       = 0x00000020,
}

enum : int
{
    VMR_ARMODE_NONE       = 0x00000000,
    VMR_ARMODE_LETTER_BOX = 0x00000001,
}
alias VMR_ASPECT_RATIO_MODE = int;

enum VMRMixerPrefs : int
{
    MixerPref_NoDecimation         = 0x00000001,
    MixerPref_DecimateOutput       = 0x00000002,
    MixerPref_ARAdjustXorY         = 0x00000004,
    MixerPref_DecimationReserved   = 0x00000008,
    MixerPref_DecimateMask         = 0x0000000f,
    MixerPref_BiLinearFiltering    = 0x00000010,
    MixerPref_PointFiltering       = 0x00000020,
    MixerPref_FilteringMask        = 0x000000f0,
    MixerPref_RenderTargetRGB      = 0x00000100,
    MixerPref_RenderTargetYUV      = 0x00001000,
    MixerPref_RenderTargetYUV420   = 0x00000200,
    MixerPref_RenderTargetYUV422   = 0x00000400,
    MixerPref_RenderTargetYUV444   = 0x00000800,
    MixerPref_RenderTargetReserved = 0x0000e000,
    MixerPref_RenderTargetMask     = 0x0000ff00,
    MixerPref_DynamicSwitchToBOB   = 0x00010000,
    MixerPref_DynamicDecimateBy2   = 0x00020000,
    MixerPref_DynamicReserved      = 0x000c0000,
    MixerPref_DynamicMask          = 0x000f0000,
}

enum VMRRenderPrefs : int
{
    RenderPrefs_RestrictToInitialMonitor     = 0x00000000,
    RenderPrefs_ForceOffscreen               = 0x00000001,
    RenderPrefs_ForceOverlays                = 0x00000002,
    RenderPrefs_AllowOverlays                = 0x00000000,
    RenderPrefs_AllowOffscreen               = 0x00000000,
    RenderPrefs_DoNotRenderColorKeyAndBorder = 0x00000008,
    RenderPrefs_Reserved                     = 0x00000010,
    RenderPrefs_PreferAGPMemWhenMixing       = 0x00000020,
    RenderPrefs_Mask                         = 0x0000003f,
}

enum : int
{
    VMRMode_Windowed   = 0x00000001,
    VMRMode_Windowless = 0x00000002,
    VMRMode_Renderless = 0x00000004,
    VMRMode_Mask       = 0x00000007,
}
alias VMRMode = int;

enum : int
{
    MAX_NUMBER_OF_STREAMS = 0x00000010,
}
alias __MIDL___MIDL_itf_strmif_0000_0122_0001 = int;

enum VMRDeinterlacePrefs : int
{
    DeinterlacePref_NextBest = 0x00000001,
    DeinterlacePref_BOB      = 0x00000002,
    DeinterlacePref_Weave    = 0x00000004,
    DeinterlacePref_Mask     = 0x00000007,
}

enum VMRDeinterlaceTech : int
{
    DeinterlaceTech_Unknown             = 0x00000000,
    DeinterlaceTech_BOBLineReplicate    = 0x00000001,
    DeinterlaceTech_BOBVerticalStretch  = 0x00000002,
    DeinterlaceTech_MedianFiltering     = 0x00000004,
    DeinterlaceTech_EdgeFiltering       = 0x00000010,
    DeinterlaceTech_FieldAdaptive       = 0x00000020,
    DeinterlaceTech_PixelAdaptive       = 0x00000040,
    DeinterlaceTech_MotionVectorSteered = 0x00000080,
}

enum : int
{
    DVD_DOMAIN_FirstPlay         = 0x00000001,
    DVD_DOMAIN_VideoManagerMenu  = 0x00000002,
    DVD_DOMAIN_VideoTitleSetMenu = 0x00000003,
    DVD_DOMAIN_Title             = 0x00000004,
    DVD_DOMAIN_Stop              = 0x00000005,
}
alias DVD_DOMAIN = int;

enum : int
{
    DVD_MENU_Title      = 0x00000002,
    DVD_MENU_Root       = 0x00000003,
    DVD_MENU_Subpicture = 0x00000004,
    DVD_MENU_Audio      = 0x00000005,
    DVD_MENU_Angle      = 0x00000006,
    DVD_MENU_Chapter    = 0x00000007,
}
alias DVD_MENU_ID = int;

enum : int
{
    DVD_SIDE_A = 0x00000001,
    DVD_SIDE_B = 0x00000002,
}
alias DVD_DISC_SIDE = int;

enum : int
{
    DISPLAY_CONTENT_DEFAULT         = 0x00000000,
    DISPLAY_16x9                    = 0x00000001,
    DISPLAY_4x3_PANSCAN_PREFERRED   = 0x00000002,
    DISPLAY_4x3_LETTERBOX_PREFERRED = 0x00000003,
}
alias DVD_PREFERRED_DISPLAY_MODE = int;

enum : int
{
    DVD_FPS_25        = 0x00000001,
    DVD_FPS_30NonDrop = 0x00000003,
}
alias DVD_FRAMERATE = int;

enum : int
{
    DVD_NavCmdType_Pre    = 0x00000001,
    DVD_NavCmdType_Post   = 0x00000002,
    DVD_NavCmdType_Cell   = 0x00000003,
    DVD_NavCmdType_Button = 0x00000004,
}
alias DVD_NavCmdType = int;

enum : int
{
    DVD_TC_FLAG_25fps        = 0x00000001,
    DVD_TC_FLAG_30fps        = 0x00000002,
    DVD_TC_FLAG_DropFrame    = 0x00000004,
    DVD_TC_FLAG_Interpolated = 0x00000008,
}
alias DVD_TIMECODE_FLAGS = int;

enum : int
{
    UOP_FLAG_Play_Title_Or_AtTime                   = 0x00000001,
    UOP_FLAG_Play_Chapter                           = 0x00000002,
    UOP_FLAG_Play_Title                             = 0x00000004,
    UOP_FLAG_Stop                                   = 0x00000008,
    UOP_FLAG_ReturnFromSubMenu                      = 0x00000010,
    UOP_FLAG_Play_Chapter_Or_AtTime                 = 0x00000020,
    UOP_FLAG_PlayPrev_Or_Replay_Chapter             = 0x00000040,
    UOP_FLAG_PlayNext_Chapter                       = 0x00000080,
    UOP_FLAG_Play_Forwards                          = 0x00000100,
    UOP_FLAG_Play_Backwards                         = 0x00000200,
    UOP_FLAG_ShowMenu_Title                         = 0x00000400,
    UOP_FLAG_ShowMenu_Root                          = 0x00000800,
    UOP_FLAG_ShowMenu_SubPic                        = 0x00001000,
    UOP_FLAG_ShowMenu_Audio                         = 0x00002000,
    UOP_FLAG_ShowMenu_Angle                         = 0x00004000,
    UOP_FLAG_ShowMenu_Chapter                       = 0x00008000,
    UOP_FLAG_Resume                                 = 0x00010000,
    UOP_FLAG_Select_Or_Activate_Button              = 0x00020000,
    UOP_FLAG_Still_Off                              = 0x00040000,
    UOP_FLAG_Pause_On                               = 0x00080000,
    UOP_FLAG_Select_Audio_Stream                    = 0x00100000,
    UOP_FLAG_Select_SubPic_Stream                   = 0x00200000,
    UOP_FLAG_Select_Angle                           = 0x00400000,
    UOP_FLAG_Select_Karaoke_Audio_Presentation_Mode = 0x00800000,
    UOP_FLAG_Select_Video_Mode_Preference           = 0x01000000,
}
alias VALID_UOP_FLAG = int;

enum : int
{
    DVD_CMD_FLAG_None              = 0x00000000,
    DVD_CMD_FLAG_Flush             = 0x00000001,
    DVD_CMD_FLAG_SendEvents        = 0x00000002,
    DVD_CMD_FLAG_Block             = 0x00000004,
    DVD_CMD_FLAG_StartWhenRendered = 0x00000008,
    DVD_CMD_FLAG_EndAfterRendered  = 0x00000010,
}
alias DVD_CMD_FLAGS = int;

enum : int
{
    DVD_ResetOnStop                     = 0x00000001,
    DVD_NotifyParentalLevelChange       = 0x00000002,
    DVD_HMSF_TimeCodeEvents             = 0x00000003,
    DVD_AudioDuringFFwdRew              = 0x00000004,
    DVD_EnableNonblockingAPIs           = 0x00000005,
    DVD_CacheSizeInMB                   = 0x00000006,
    DVD_EnablePortableBookmarks         = 0x00000007,
    DVD_EnableExtendedCopyProtectErrors = 0x00000008,
    DVD_NotifyPositionChange            = 0x00000009,
    DVD_IncreaseOutputControl           = 0x0000000a,
    DVD_EnableStreaming                 = 0x0000000b,
    DVD_EnableESOutput                  = 0x0000000c,
    DVD_EnableTitleLength               = 0x0000000d,
    DVD_DisableStillThrottle            = 0x0000000e,
    DVD_EnableLoggingEvents             = 0x0000000f,
    DVD_MaxReadBurstInKB                = 0x00000010,
    DVD_ReadBurstPeriodInMS             = 0x00000011,
    DVD_RestartDisc                     = 0x00000012,
    DVD_EnableCC                        = 0x00000013,
}
alias DVD_OPTION_FLAG = int;

enum : int
{
    DVD_Relative_Upper = 0x00000001,
    DVD_Relative_Lower = 0x00000002,
    DVD_Relative_Left  = 0x00000003,
    DVD_Relative_Right = 0x00000004,
}
alias DVD_RELATIVE_BUTTON = int;

enum : int
{
    DVD_PARENTAL_LEVEL_8 = 0x00008000,
    DVD_PARENTAL_LEVEL_7 = 0x00004000,
    DVD_PARENTAL_LEVEL_6 = 0x00002000,
    DVD_PARENTAL_LEVEL_5 = 0x00001000,
    DVD_PARENTAL_LEVEL_4 = 0x00000800,
    DVD_PARENTAL_LEVEL_3 = 0x00000400,
    DVD_PARENTAL_LEVEL_2 = 0x00000200,
    DVD_PARENTAL_LEVEL_1 = 0x00000100,
}
alias DVD_PARENTAL_LEVEL = int;

enum : int
{
    DVD_AUD_EXT_NotSpecified      = 0x00000000,
    DVD_AUD_EXT_Captions          = 0x00000001,
    DVD_AUD_EXT_VisuallyImpaired  = 0x00000002,
    DVD_AUD_EXT_DirectorComments1 = 0x00000003,
    DVD_AUD_EXT_DirectorComments2 = 0x00000004,
}
alias DVD_AUDIO_LANG_EXT = int;

enum : int
{
    DVD_SP_EXT_NotSpecified              = 0x00000000,
    DVD_SP_EXT_Caption_Normal            = 0x00000001,
    DVD_SP_EXT_Caption_Big               = 0x00000002,
    DVD_SP_EXT_Caption_Children          = 0x00000003,
    DVD_SP_EXT_CC_Normal                 = 0x00000005,
    DVD_SP_EXT_CC_Big                    = 0x00000006,
    DVD_SP_EXT_CC_Children               = 0x00000007,
    DVD_SP_EXT_Forced                    = 0x00000009,
    DVD_SP_EXT_DirectorComments_Normal   = 0x0000000d,
    DVD_SP_EXT_DirectorComments_Big      = 0x0000000e,
    DVD_SP_EXT_DirectorComments_Children = 0x0000000f,
}
alias DVD_SUBPICTURE_LANG_EXT = int;

enum : int
{
    DVD_AudioMode_None     = 0x00000000,
    DVD_AudioMode_Karaoke  = 0x00000001,
    DVD_AudioMode_Surround = 0x00000002,
    DVD_AudioMode_Other    = 0x00000003,
}
alias DVD_AUDIO_APPMODE = int;

enum : int
{
    DVD_AudioFormat_AC3       = 0x00000000,
    DVD_AudioFormat_MPEG1     = 0x00000001,
    DVD_AudioFormat_MPEG1_DRC = 0x00000002,
    DVD_AudioFormat_MPEG2     = 0x00000003,
    DVD_AudioFormat_MPEG2_DRC = 0x00000004,
    DVD_AudioFormat_LPCM      = 0x00000005,
    DVD_AudioFormat_DTS       = 0x00000006,
    DVD_AudioFormat_SDDS      = 0x00000007,
    DVD_AudioFormat_Other     = 0x00000008,
}
alias DVD_AUDIO_FORMAT = int;

enum : int
{
    DVD_Mix_0to0 = 0x00000001,
    DVD_Mix_1to0 = 0x00000002,
    DVD_Mix_2to0 = 0x00000004,
    DVD_Mix_3to0 = 0x00000008,
    DVD_Mix_4to0 = 0x00000010,
    DVD_Mix_Lto0 = 0x00000020,
    DVD_Mix_Rto0 = 0x00000040,
    DVD_Mix_0to1 = 0x00000100,
    DVD_Mix_1to1 = 0x00000200,
    DVD_Mix_2to1 = 0x00000400,
    DVD_Mix_3to1 = 0x00000800,
    DVD_Mix_4to1 = 0x00001000,
    DVD_Mix_Lto1 = 0x00002000,
    DVD_Mix_Rto1 = 0x00004000,
}
alias DVD_KARAOKE_DOWNMIX = int;

enum : int
{
    DVD_Karaoke_GuideVocal1  = 0x00000001,
    DVD_Karaoke_GuideVocal2  = 0x00000002,
    DVD_Karaoke_GuideMelody1 = 0x00000004,
    DVD_Karaoke_GuideMelody2 = 0x00000008,
    DVD_Karaoke_GuideMelodyA = 0x00000010,
    DVD_Karaoke_GuideMelodyB = 0x00000020,
    DVD_Karaoke_SoundEffectA = 0x00000040,
    DVD_Karaoke_SoundEffectB = 0x00000080,
}
alias DVD_KARAOKE_CONTENTS = int;

enum : int
{
    DVD_Assignment_reserved0 = 0x00000000,
    DVD_Assignment_reserved1 = 0x00000001,
    DVD_Assignment_LR        = 0x00000002,
    DVD_Assignment_LRM       = 0x00000003,
    DVD_Assignment_LR1       = 0x00000004,
    DVD_Assignment_LRM1      = 0x00000005,
    DVD_Assignment_LR12      = 0x00000006,
    DVD_Assignment_LRM12     = 0x00000007,
}
alias DVD_KARAOKE_ASSIGNMENT = int;

enum : int
{
    DVD_VideoCompression_Other = 0x00000000,
    DVD_VideoCompression_MPEG1 = 0x00000001,
    DVD_VideoCompression_MPEG2 = 0x00000002,
}
alias DVD_VIDEO_COMPRESSION = int;

enum : int
{
    DVD_SPType_NotSpecified = 0x00000000,
    DVD_SPType_Language     = 0x00000001,
    DVD_SPType_Other        = 0x00000002,
}
alias DVD_SUBPICTURE_TYPE = int;

enum : int
{
    DVD_SPCoding_RunLength = 0x00000000,
    DVD_SPCoding_Extended  = 0x00000001,
    DVD_SPCoding_Other     = 0x00000002,
}
alias DVD_SUBPICTURE_CODING = int;

enum : int
{
    DVD_AppMode_Not_Specified = 0x00000000,
    DVD_AppMode_Karaoke       = 0x00000001,
    DVD_AppMode_Other         = 0x00000003,
}
alias DVD_TITLE_APPMODE = int;

enum : int
{
    DVD_Struct_Volume      = 0x00000001,
    DVD_Struct_Title       = 0x00000002,
    DVD_Struct_ParentalID  = 0x00000003,
    DVD_Struct_PartOfTitle = 0x00000004,
    DVD_Struct_Cell        = 0x00000005,
    DVD_Stream_Audio       = 0x00000010,
    DVD_Stream_Subpicture  = 0x00000011,
    DVD_Stream_Angle       = 0x00000012,
    DVD_Channel_Audio      = 0x00000020,
    DVD_General_Name       = 0x00000030,
    DVD_General_Comments   = 0x00000031,
    DVD_Title_Series       = 0x00000038,
    DVD_Title_Movie        = 0x00000039,
    DVD_Title_Video        = 0x0000003a,
    DVD_Title_Album        = 0x0000003b,
    DVD_Title_Song         = 0x0000003c,
    DVD_Title_Other        = 0x0000003f,
    DVD_Title_Sub_Series   = 0x00000040,
    DVD_Title_Sub_Movie    = 0x00000041,
    DVD_Title_Sub_Video    = 0x00000042,
    DVD_Title_Sub_Album    = 0x00000043,
    DVD_Title_Sub_Song     = 0x00000044,
    DVD_Title_Sub_Other    = 0x00000047,
    DVD_Title_Orig_Series  = 0x00000048,
    DVD_Title_Orig_Movie   = 0x00000049,
    DVD_Title_Orig_Video   = 0x0000004a,
    DVD_Title_Orig_Album   = 0x0000004b,
    DVD_Title_Orig_Song    = 0x0000004c,
    DVD_Title_Orig_Other   = 0x0000004f,
    DVD_Other_Scene        = 0x00000050,
    DVD_Other_Cut          = 0x00000051,
    DVD_Other_Take         = 0x00000052,
}
alias DVD_TextStringType = int;

enum : int
{
    DVD_CharSet_Unicode                       = 0x00000000,
    DVD_CharSet_ISO646                        = 0x00000001,
    DVD_CharSet_JIS_Roman_Kanji               = 0x00000002,
    DVD_CharSet_ISO8859_1                     = 0x00000003,
    DVD_CharSet_ShiftJIS_Kanji_Roman_Katakana = 0x00000004,
}
alias DVD_TextCharSet = int;

enum : int
{
    AM_DVD_HWDEC_PREFER = 0x00000001,
    AM_DVD_HWDEC_ONLY   = 0x00000002,
    AM_DVD_SWDEC_PREFER = 0x00000004,
    AM_DVD_SWDEC_ONLY   = 0x00000008,
    AM_DVD_NOVPE        = 0x00000100,
    AM_DVD_DO_NOT_CLEAR = 0x00000200,
    AM_DVD_VMR9_ONLY    = 0x00000800,
    AM_DVD_EVR_ONLY     = 0x00001000,
    AM_DVD_EVR_QOS      = 0x00002000,
    AM_DVD_ADAPT_GRAPH  = 0x00004000,
    AM_DVD_MASK         = 0x0000ffff,
}
alias AM_DVD_GRAPH_FLAGS = int;

enum : int
{
    AM_DVD_STREAM_VIDEO  = 0x00000001,
    AM_DVD_STREAM_AUDIO  = 0x00000002,
    AM_DVD_STREAM_SUBPIC = 0x00000004,
}
alias AM_DVD_STREAM_FLAGS = int;

enum : int
{
    AM_OVERLAY_NOTIFY_VISIBLE_CHANGE = 0x00000001,
    AM_OVERLAY_NOTIFY_SOURCE_CHANGE  = 0x00000002,
    AM_OVERLAY_NOTIFY_DEST_CHANGE    = 0x00000004,
}
alias _AM_OVERLAY_NOTIFY_FLAGS = int;

enum : int
{
    BDA_EVENT_SIGNAL_LOSS               = 0x00000000,
    BDA_EVENT_SIGNAL_LOCK               = 0x00000001,
    BDA_EVENT_DATA_START                = 0x00000002,
    BDA_EVENT_DATA_STOP                 = 0x00000003,
    BDA_EVENT_CHANNEL_ACQUIRED          = 0x00000004,
    BDA_EVENT_CHANNEL_LOST              = 0x00000005,
    BDA_EVENT_CHANNEL_SOURCE_CHANGED    = 0x00000006,
    BDA_EVENT_CHANNEL_ACTIVATED         = 0x00000007,
    BDA_EVENT_CHANNEL_DEACTIVATED       = 0x00000008,
    BDA_EVENT_SUBCHANNEL_ACQUIRED       = 0x00000009,
    BDA_EVENT_SUBCHANNEL_LOST           = 0x0000000a,
    BDA_EVENT_SUBCHANNEL_SOURCE_CHANGED = 0x0000000b,
    BDA_EVENT_SUBCHANNEL_ACTIVATED      = 0x0000000c,
    BDA_EVENT_SUBCHANNEL_DEACTIVATED    = 0x0000000d,
    BDA_EVENT_ACCESS_GRANTED            = 0x0000000e,
    BDA_EVENT_ACCESS_DENIED             = 0x0000000f,
    BDA_EVENT_OFFER_EXTENDED            = 0x00000010,
    BDA_EVENT_PURCHASE_COMPLETED        = 0x00000011,
    BDA_EVENT_SMART_CARD_INSERTED       = 0x00000012,
    BDA_EVENT_SMART_CARD_REMOVED        = 0x00000013,
}
alias BDA_EVENT_ID = int;

enum : int
{
    BDA_PROMISCUOUS_MULTICAST = 0x00000000,
    BDA_FILTERED_MULTICAST    = 0x00000001,
    BDA_NO_MULTICAST          = 0x00000002,
}
alias BDA_MULTICAST_MODE = int;

enum : int
{
    BDA_SIGNAL_UNAVAILABLE = 0x00000000,
    BDA_SIGNAL_INACTIVE    = 0x00000001,
    BDA_SIGNAL_ACTIVE      = 0x00000002,
}
alias BDA_SIGNAL_STATE = int;

enum : int
{
    BDA_CHANGES_COMPLETE = 0x00000000,
    BDA_CHANGES_PENDING  = 0x00000001,
}
alias BDA_CHANGE_STATE = int;

enum : int
{
    MEDIA_TRANSPORT_PACKET  = 0x00000000,
    MEDIA_ELEMENTARY_STREAM = 0x00000001,
    MEDIA_MPEG2_PSI         = 0x00000002,
    MEDIA_TRANSPORT_PAYLOAD = 0x00000003,
}
alias MEDIA_SAMPLE_CONTENT = int;

enum : int
{
    ISDBCAS_REQUEST_ID_EMG = 0x00000038,
    ISDBCAS_REQUEST_ID_EMD = 0x0000003a,
}
alias ISDBCAS_REQUEST_ID = int;

enum : int
{
    PID_OTHER                = 0xffffffff,
    PID_ELEMENTARY_STREAM    = 0x00000000,
    PID_MPEG2_SECTION_PSI_SI = 0x00000001,
}
alias MUX_PID_TYPE = int;

enum DVBSystemType : int
{
    DVB_Cable        = 0x00000000,
    DVB_Terrestrial  = 0x00000001,
    DVB_Satellite    = 0x00000002,
    ISDB_Terrestrial = 0x00000003,
    ISDB_Satellite   = 0x00000004,
}

enum : int
{
    BDA_UNDEFINED_CHANNEL = 0xffffffff,
}
alias BDA_Channel = int;

enum ComponentCategory : int
{
    CategoryNotSet      = 0xffffffff,
    CategoryOther       = 0x00000000,
    CategoryVideo       = 0x00000001,
    CategoryAudio       = 0x00000002,
    CategoryText        = 0x00000003,
    CategorySubtitles   = 0x00000004,
    CategoryCaptions    = 0x00000005,
    CategorySuperimpose = 0x00000006,
    CategoryData        = 0x00000007,
    CATEGORY_COUNT      = 0x00000008,
}

enum ComponentStatus : int
{
    StatusActive      = 0x00000000,
    StatusInactive    = 0x00000001,
    StatusUnavailable = 0x00000002,
}

enum MPEG2StreamType : int
{
    BDA_UNITIALIZED_MPEG2STREAMTYPE = 0xffffffff,
    Reserved1                       = 0x00000000,
    ISO_IEC_11172_2_VIDEO           = 0x00000001,
    ISO_IEC_13818_2_VIDEO           = 0x00000002,
    ISO_IEC_11172_3_AUDIO           = 0x00000003,
    ISO_IEC_13818_3_AUDIO           = 0x00000004,
    ISO_IEC_13818_1_PRIVATE_SECTION = 0x00000005,
    ISO_IEC_13818_1_PES             = 0x00000006,
    ISO_IEC_13522_MHEG              = 0x00000007,
    ANNEX_A_DSM_CC                  = 0x00000008,
    ITU_T_REC_H_222_1               = 0x00000009,
    ISO_IEC_13818_6_TYPE_A          = 0x0000000a,
    ISO_IEC_13818_6_TYPE_B          = 0x0000000b,
    ISO_IEC_13818_6_TYPE_C          = 0x0000000c,
    ISO_IEC_13818_6_TYPE_D          = 0x0000000d,
    ISO_IEC_13818_1_AUXILIARY       = 0x0000000e,
    ISO_IEC_13818_7_AUDIO           = 0x0000000f,
    ISO_IEC_14496_2_VISUAL          = 0x00000010,
    ISO_IEC_14496_3_AUDIO           = 0x00000011,
    ISO_IEC_14496_1_IN_PES          = 0x00000012,
    ISO_IEC_14496_1_IN_SECTION      = 0x00000013,
    ISO_IEC_13818_6_DOWNLOAD        = 0x00000014,
    METADATA_IN_PES                 = 0x00000015,
    METADATA_IN_SECTION             = 0x00000016,
    METADATA_IN_DATA_CAROUSEL       = 0x00000017,
    METADATA_IN_OBJECT_CAROUSEL     = 0x00000018,
    METADATA_IN_DOWNLOAD_PROTOCOL   = 0x00000019,
    IRPM_STREAMM                    = 0x0000001a,
    ITU_T_H264                      = 0x0000001b,
    ISO_IEC_13818_1_RESERVED        = 0x0000001c,
    USER_PRIVATE                    = 0x00000010,
    HEVC_VIDEO_OR_TEMPORAL_VIDEO    = 0x00000024,
    HEVC_TEMPORAL_VIDEO_SUBSET      = 0x00000025,
    ISO_IEC_USER_PRIVATE            = 0x00000080,
    DOLBY_AC3_AUDIO                 = 0x00000081,
    DOLBY_DIGITAL_PLUS_AUDIO_ATSC   = 0x00000087,
}

enum ATSCComponentTypeFlags : int
{
    ATSCCT_AC3 = 0x00000001,
}

enum BinaryConvolutionCodeRate : int
{
    BDA_BCC_RATE_NOT_SET     = 0xffffffff,
    BDA_BCC_RATE_NOT_DEFINED = 0x00000000,
    BDA_BCC_RATE_1_2         = 0x00000001,
    BDA_BCC_RATE_2_3         = 0x00000002,
    BDA_BCC_RATE_3_4         = 0x00000003,
    BDA_BCC_RATE_3_5         = 0x00000004,
    BDA_BCC_RATE_4_5         = 0x00000005,
    BDA_BCC_RATE_5_6         = 0x00000006,
    BDA_BCC_RATE_5_11        = 0x00000007,
    BDA_BCC_RATE_7_8         = 0x00000008,
    BDA_BCC_RATE_1_4         = 0x00000009,
    BDA_BCC_RATE_1_3         = 0x0000000a,
    BDA_BCC_RATE_2_5         = 0x0000000b,
    BDA_BCC_RATE_6_7         = 0x0000000c,
    BDA_BCC_RATE_8_9         = 0x0000000d,
    BDA_BCC_RATE_9_10        = 0x0000000e,
    BDA_BCC_RATE_MAX         = 0x0000000f,
}

enum FECMethod : int
{
    BDA_FEC_METHOD_NOT_SET     = 0xffffffff,
    BDA_FEC_METHOD_NOT_DEFINED = 0x00000000,
    BDA_FEC_VITERBI            = 0x00000001,
    BDA_FEC_RS_204_188         = 0x00000002,
    BDA_FEC_LDPC               = 0x00000003,
    BDA_FEC_BCH                = 0x00000004,
    BDA_FEC_RS_147_130         = 0x00000005,
    BDA_FEC_MAX                = 0x00000006,
}

enum ModulationType : int
{
    BDA_MOD_NOT_SET          = 0xffffffff,
    BDA_MOD_NOT_DEFINED      = 0x00000000,
    BDA_MOD_16QAM            = 0x00000001,
    BDA_MOD_32QAM            = 0x00000002,
    BDA_MOD_64QAM            = 0x00000003,
    BDA_MOD_80QAM            = 0x00000004,
    BDA_MOD_96QAM            = 0x00000005,
    BDA_MOD_112QAM           = 0x00000006,
    BDA_MOD_128QAM           = 0x00000007,
    BDA_MOD_160QAM           = 0x00000008,
    BDA_MOD_192QAM           = 0x00000009,
    BDA_MOD_224QAM           = 0x0000000a,
    BDA_MOD_256QAM           = 0x0000000b,
    BDA_MOD_320QAM           = 0x0000000c,
    BDA_MOD_384QAM           = 0x0000000d,
    BDA_MOD_448QAM           = 0x0000000e,
    BDA_MOD_512QAM           = 0x0000000f,
    BDA_MOD_640QAM           = 0x00000010,
    BDA_MOD_768QAM           = 0x00000011,
    BDA_MOD_896QAM           = 0x00000012,
    BDA_MOD_1024QAM          = 0x00000013,
    BDA_MOD_QPSK             = 0x00000014,
    BDA_MOD_BPSK             = 0x00000015,
    BDA_MOD_OQPSK            = 0x00000016,
    BDA_MOD_8VSB             = 0x00000017,
    BDA_MOD_16VSB            = 0x00000018,
    BDA_MOD_ANALOG_AMPLITUDE = 0x00000019,
    BDA_MOD_ANALOG_FREQUENCY = 0x0000001a,
    BDA_MOD_8PSK             = 0x0000001b,
    BDA_MOD_RF               = 0x0000001c,
    BDA_MOD_16APSK           = 0x0000001d,
    BDA_MOD_32APSK           = 0x0000001e,
    BDA_MOD_NBC_QPSK         = 0x0000001f,
    BDA_MOD_NBC_8PSK         = 0x00000020,
    BDA_MOD_DIRECTV          = 0x00000021,
    BDA_MOD_ISDB_T_TMCC      = 0x00000022,
    BDA_MOD_ISDB_S_TMCC      = 0x00000023,
    BDA_MOD_MAX              = 0x00000024,
}

enum ScanModulationTypes : int
{
    BDA_SCAN_MOD_16QAM                          = 0x00000001,
    BDA_SCAN_MOD_32QAM                          = 0x00000002,
    BDA_SCAN_MOD_64QAM                          = 0x00000004,
    BDA_SCAN_MOD_80QAM                          = 0x00000008,
    BDA_SCAN_MOD_96QAM                          = 0x00000010,
    BDA_SCAN_MOD_112QAM                         = 0x00000020,
    BDA_SCAN_MOD_128QAM                         = 0x00000040,
    BDA_SCAN_MOD_160QAM                         = 0x00000080,
    BDA_SCAN_MOD_192QAM                         = 0x00000100,
    BDA_SCAN_MOD_224QAM                         = 0x00000200,
    BDA_SCAN_MOD_256QAM                         = 0x00000400,
    BDA_SCAN_MOD_320QAM                         = 0x00000800,
    BDA_SCAN_MOD_384QAM                         = 0x00001000,
    BDA_SCAN_MOD_448QAM                         = 0x00002000,
    BDA_SCAN_MOD_512QAM                         = 0x00004000,
    BDA_SCAN_MOD_640QAM                         = 0x00008000,
    BDA_SCAN_MOD_768QAM                         = 0x00010000,
    BDA_SCAN_MOD_896QAM                         = 0x00020000,
    BDA_SCAN_MOD_1024QAM                        = 0x00040000,
    BDA_SCAN_MOD_QPSK                           = 0x00080000,
    BDA_SCAN_MOD_BPSK                           = 0x00100000,
    BDA_SCAN_MOD_OQPSK                          = 0x00200000,
    BDA_SCAN_MOD_8VSB                           = 0x00400000,
    BDA_SCAN_MOD_16VSB                          = 0x00800000,
    BDA_SCAN_MOD_AM_RADIO                       = 0x01000000,
    BDA_SCAN_MOD_FM_RADIO                       = 0x02000000,
    BDA_SCAN_MOD_8PSK                           = 0x04000000,
    BDA_SCAN_MOD_RF                             = 0x08000000,
    ScanModulationTypesMask_MCE_DigitalCable    = 0x0000000b,
    ScanModulationTypesMask_MCE_TerrestrialATSC = 0x00000017,
    ScanModulationTypesMask_MCE_AnalogTv        = 0x0000001c,
    ScanModulationTypesMask_MCE_All_TV          = 0xffffffff,
    ScanModulationTypesMask_DVBC                = 0x0000004b,
    BDA_SCAN_MOD_16APSK                         = 0x10000000,
    BDA_SCAN_MOD_32APSK                         = 0x20000000,
}

enum SpectralInversion : int
{
    BDA_SPECTRAL_INVERSION_NOT_SET     = 0xffffffff,
    BDA_SPECTRAL_INVERSION_NOT_DEFINED = 0x00000000,
    BDA_SPECTRAL_INVERSION_AUTOMATIC   = 0x00000001,
    BDA_SPECTRAL_INVERSION_NORMAL      = 0x00000002,
    BDA_SPECTRAL_INVERSION_INVERTED    = 0x00000003,
    BDA_SPECTRAL_INVERSION_MAX         = 0x00000004,
}

enum Polarisation : int
{
    BDA_POLARISATION_NOT_SET     = 0xffffffff,
    BDA_POLARISATION_NOT_DEFINED = 0x00000000,
    BDA_POLARISATION_LINEAR_H    = 0x00000001,
    BDA_POLARISATION_LINEAR_V    = 0x00000002,
    BDA_POLARISATION_CIRCULAR_L  = 0x00000003,
    BDA_POLARISATION_CIRCULAR_R  = 0x00000004,
    BDA_POLARISATION_MAX         = 0x00000005,
}

enum : int
{
    BDA_LNB_SOURCE_NOT_SET     = 0xffffffff,
    BDA_LNB_SOURCE_NOT_DEFINED = 0x00000000,
    BDA_LNB_SOURCE_A           = 0x00000001,
    BDA_LNB_SOURCE_B           = 0x00000002,
    BDA_LNB_SOURCE_C           = 0x00000003,
    BDA_LNB_SOURCE_D           = 0x00000004,
    BDA_LNB_SOURCE_MAX         = 0x00000005,
}
alias LNB_Source = int;

enum GuardInterval : int
{
    BDA_GUARD_NOT_SET     = 0xffffffff,
    BDA_GUARD_NOT_DEFINED = 0x00000000,
    BDA_GUARD_1_32        = 0x00000001,
    BDA_GUARD_1_16        = 0x00000002,
    BDA_GUARD_1_8         = 0x00000003,
    BDA_GUARD_1_4         = 0x00000004,
    BDA_GUARD_1_128       = 0x00000005,
    BDA_GUARD_19_128      = 0x00000006,
    BDA_GUARD_19_256      = 0x00000007,
    BDA_GUARD_MAX         = 0x00000008,
}

enum HierarchyAlpha : int
{
    BDA_HALPHA_NOT_SET     = 0xffffffff,
    BDA_HALPHA_NOT_DEFINED = 0x00000000,
    BDA_HALPHA_1           = 0x00000001,
    BDA_HALPHA_2           = 0x00000002,
    BDA_HALPHA_4           = 0x00000003,
    BDA_HALPHA_MAX         = 0x00000004,
}

enum TransmissionMode : int
{
    BDA_XMIT_MODE_NOT_SET        = 0xffffffff,
    BDA_XMIT_MODE_NOT_DEFINED    = 0x00000000,
    BDA_XMIT_MODE_2K             = 0x00000001,
    BDA_XMIT_MODE_8K             = 0x00000002,
    BDA_XMIT_MODE_4K             = 0x00000003,
    BDA_XMIT_MODE_2K_INTERLEAVED = 0x00000004,
    BDA_XMIT_MODE_4K_INTERLEAVED = 0x00000005,
    BDA_XMIT_MODE_1K             = 0x00000006,
    BDA_XMIT_MODE_16K            = 0x00000007,
    BDA_XMIT_MODE_32K            = 0x00000008,
    BDA_XMIT_MODE_MAX            = 0x00000009,
}

enum RollOff : int
{
    BDA_ROLL_OFF_NOT_SET     = 0xffffffff,
    BDA_ROLL_OFF_NOT_DEFINED = 0x00000000,
    BDA_ROLL_OFF_20          = 0x00000001,
    BDA_ROLL_OFF_25          = 0x00000002,
    BDA_ROLL_OFF_35          = 0x00000003,
    BDA_ROLL_OFF_MAX         = 0x00000004,
}

enum Pilot : int
{
    BDA_PILOT_NOT_SET     = 0xffffffff,
    BDA_PILOT_NOT_DEFINED = 0x00000000,
    BDA_PILOT_OFF         = 0x00000001,
    BDA_PILOT_ON          = 0x00000002,
    BDA_PILOT_MAX         = 0x00000003,
}

enum : int
{
    BDA_FREQUENCY_NOT_SET     = 0xffffffff,
    BDA_FREQUENCY_NOT_DEFINED = 0x00000000,
}
alias BDA_Frequency = int;

enum : int
{
    BDA_RANGE_NOT_SET     = 0xffffffff,
    BDA_RANGE_NOT_DEFINED = 0x00000000,
}
alias BDA_Range = int;

enum : int
{
    BDA_CHAN_BANDWITH_NOT_SET     = 0xffffffff,
    BDA_CHAN_BANDWITH_NOT_DEFINED = 0x00000000,
}
alias BDA_Channel_Bandwidth = int;

enum : int
{
    BDA_FREQUENCY_MULTIPLIER_NOT_SET     = 0xffffffff,
    BDA_FREQUENCY_MULTIPLIER_NOT_DEFINED = 0x00000000,
}
alias BDA_Frequency_Multiplier = int;

enum : int
{
    BDACOMP_NOT_DEFINED              = 0x00000000,
    BDACOMP_EXCLUDE_TS_FROM_TR       = 0x00000001,
    BDACOMP_INCLUDE_LOCATOR_IN_TR    = 0x00000002,
    BDACOMP_INCLUDE_COMPONENTS_IN_TR = 0x00000004,
}
alias BDA_Comp_Flags = int;

enum ApplicationTypeType : int
{
    SCTE28_ConditionalAccess            = 0x00000000,
    SCTE28_POD_Host_Binding_Information = 0x00000001,
    SCTE28_IPService                    = 0x00000002,
    SCTE28_NetworkInterface_SCTE55_2    = 0x00000003,
    SCTE28_NetworkInterface_SCTE55_1    = 0x00000004,
    SCTE28_CopyProtection               = 0x00000005,
    SCTE28_Diagnostic                   = 0x00000006,
    SCTE28_Undesignated                 = 0x00000007,
    SCTE28_Reserved                     = 0x00000008,
}

enum : int
{
    CONDITIONALACCESS_ACCESS_UNSPECIFIED                      = 0x00000000,
    CONDITIONALACCESS_ACCESS_NOT_POSSIBLE                     = 0x00000001,
    CONDITIONALACCESS_ACCESS_POSSIBLE                         = 0x00000002,
    CONDITIONALACCESS_ACCESS_POSSIBLE_NO_STREAMING_DISRUPTION = 0x00000003,
}
alias BDA_CONDITIONALACCESS_REQUESTTYPE = int;

enum : int
{
    CONDITIONALACCESS_UNSPECIFIED               = 0x00000000,
    CONDITIONALACCESS_CLOSED_ITSELF             = 0x00000001,
    CONDITIONALACCESS_TUNER_REQUESTED_CLOSE     = 0x00000002,
    CONDITIONALACCESS_DIALOG_TIMEOUT            = 0x00000003,
    CONDITIONALACCESS_DIALOG_FOCUS_CHANGE       = 0x00000004,
    CONDITIONALACCESS_DIALOG_USER_DISMISSED     = 0x00000005,
    CONDITIONALACCESS_DIALOG_USER_NOT_AVAILABLE = 0x00000006,
}
alias BDA_CONDITIONALACCESS_MMICLOSEREASON = int;

enum : int
{
    CONDITIONALACCESS_SUCCESSFULL    = 0x00000000,
    CONDITIONALACCESS_ENDED_NOCHANGE = 0x00000001,
    CONDITIONALACCESS_ABORTED        = 0x00000002,
}
alias BDA_CONDITIONALACCESS_SESSION_RESULT = int;

enum : int
{
    BDA_DISCOVERY_UNSPECIFIED = 0x00000000,
    BDA_DISCOVERY_REQUIRED    = 0x00000001,
    BDA_DISCOVERY_COMPLETE    = 0x00000002,
}
alias BDA_DISCOVERY_STATE = int;

enum SmartCardStatusType : int
{
    CardInserted        = 0x00000000,
    CardRemoved         = 0x00000001,
    CardError           = 0x00000002,
    CardDataChanged     = 0x00000003,
    CardFirmwareUpgrade = 0x00000004,
}

enum SmartCardAssociationType : int
{
    NotAssociated      = 0x00000000,
    Associated         = 0x00000001,
    AssociationUnknown = 0x00000002,
}

enum LocationCodeSchemeType : int
{
    SCTE_18 = 0x00000000,
}

enum EntitlementType : int
{
    Entitled         = 0x00000000,
    NotEntitled      = 0x00000001,
    TechnicalFailure = 0x00000002,
}

enum UICloseReasonType : int
{
    NotReady     = 0x00000000,
    UserClosed   = 0x00000001,
    SystemClosed = 0x00000002,
    DeviceClosed = 0x00000003,
    ErrorClosed  = 0x00000004,
}

enum : int
{
    BDA_DrmPairing_Succeeded          = 0x00000000,
    BDA_DrmPairing_HardwareFailure    = 0x00000001,
    BDA_DrmPairing_NeedRevocationData = 0x00000002,
    BDA_DrmPairing_NeedIndiv          = 0x00000003,
    BDA_DrmPairing_Other              = 0x00000004,
    BDA_DrmPairing_DrmInitFailed      = 0x00000005,
    BDA_DrmPairing_DrmNotPaired       = 0x00000006,
    BDA_DrmPairing_DrmRePairSoon      = 0x00000007,
    BDA_DrmPairing_Aborted            = 0x00000008,
    BDA_DrmPairing_NeedSDKUpdate      = 0x00000009,
}
alias BDA_DrmPairingError = int;

enum : int
{
    KSPROPERTY_IPSINK_MULTICASTLIST       = 0x00000000,
    KSPROPERTY_IPSINK_ADAPTER_DESCRIPTION = 0x00000001,
    KSPROPERTY_IPSINK_ADAPTER_ADDRESS     = 0x00000002,
}
alias __MIDL___MIDL_itf_bdaiface_0000_0019_0001 = int;

enum AMExtendedSeekingCapabilities : int
{
    AM_EXSEEK_CANSEEK               = 0x00000001,
    AM_EXSEEK_CANSCAN               = 0x00000002,
    AM_EXSEEK_MARKERSEEK            = 0x00000004,
    AM_EXSEEK_SCANWITHOUTCLOCK      = 0x00000008,
    AM_EXSEEK_NOSTANDARDREPAINT     = 0x00000010,
    AM_EXSEEK_BUFFERING             = 0x00000020,
    AM_EXSEEK_SENDS_VIDEOFRAMEREADY = 0x00000040,
}

enum : int
{
    AM_L21_CCLEVEL_TC2 = 0x00000000,
}
alias AM_LINE21_CCLEVEL = int;

enum : int
{
    AM_L21_CCSERVICE_None       = 0x00000000,
    AM_L21_CCSERVICE_Caption1   = 0x00000001,
    AM_L21_CCSERVICE_Caption2   = 0x00000002,
    AM_L21_CCSERVICE_Text1      = 0x00000003,
    AM_L21_CCSERVICE_Text2      = 0x00000004,
    AM_L21_CCSERVICE_XDS        = 0x00000005,
    AM_L21_CCSERVICE_DefChannel = 0x0000000a,
    AM_L21_CCSERVICE_Invalid    = 0x0000000b,
}
alias AM_LINE21_CCSERVICE = int;

enum : int
{
    AM_L21_CCSTATE_Off = 0x00000000,
    AM_L21_CCSTATE_On  = 0x00000001,
}
alias AM_LINE21_CCSTATE = int;

enum : int
{
    AM_L21_CCSTYLE_None    = 0x00000000,
    AM_L21_CCSTYLE_PopOn   = 0x00000001,
    AM_L21_CCSTYLE_PaintOn = 0x00000002,
    AM_L21_CCSTYLE_RollUp  = 0x00000003,
}
alias AM_LINE21_CCSTYLE = int;

enum : int
{
    AM_L21_DRAWBGMODE_Opaque      = 0x00000000,
    AM_L21_DRAWBGMODE_Transparent = 0x00000001,
}
alias AM_LINE21_DRAWBGMODE = int;

enum : int
{
    AM_WST_LEVEL_1_5 = 0x00000000,
}
alias AM_WST_LEVEL = int;

enum : int
{
    AM_WST_SERVICE_None    = 0x00000000,
    AM_WST_SERVICE_Text    = 0x00000001,
    AM_WST_SERVICE_IDS     = 0x00000002,
    AM_WST_SERVICE_Invalid = 0x00000003,
}
alias AM_WST_SERVICE = int;

enum : int
{
    AM_WST_STATE_Off = 0x00000000,
    AM_WST_STATE_On  = 0x00000001,
}
alias AM_WST_STATE = int;

enum : int
{
    AM_WST_STYLE_None   = 0x00000000,
    AM_WST_STYLE_Invers = 0x00000001,
}
alias AM_WST_STYLE = int;

enum : int
{
    AM_WST_DRAWBGMODE_Opaque      = 0x00000000,
    AM_WST_DRAWBGMODE_Transparent = 0x00000001,
}
alias AM_WST_DRAWBGMODE = int;

enum : int
{
    STREAMTYPE_READ      = 0x00000000,
    STREAMTYPE_WRITE     = 0x00000001,
    STREAMTYPE_TRANSFORM = 0x00000002,
}
alias STREAM_TYPE = int;

enum : int
{
    STREAMSTATE_STOP = 0x00000000,
    STREAMSTATE_RUN  = 0x00000001,
}
alias STREAM_STATE = int;

enum : int
{
    COMPSTAT_NOUPDATEOK = 0x00000001,
    COMPSTAT_WAIT       = 0x00000002,
    COMPSTAT_ABORT      = 0x00000004,
}
alias __MIDL___MIDL_itf_mmstream_0000_0000_0003 = int;

enum : int
{
    MMSSF_HASCLOCK     = 0x00000001,
    MMSSF_SUPPORTSEEK  = 0x00000002,
    MMSSF_ASYNCHRONOUS = 0x00000004,
}
alias __MIDL___MIDL_itf_mmstream_0000_0000_0004 = int;

enum : int
{
    SSUPDATE_ASYNC      = 0x00000001,
    SSUPDATE_CONTINUOUS = 0x00000002,
}
alias __MIDL___MIDL_itf_mmstream_0000_0000_0005 = int;

enum : int
{
    DDSFF_PROGRESSIVERENDER = 0x00000001,
}
alias __MIDL___MIDL_itf_ddstream_0000_0000_0001 = int;

enum : int
{
    AMMSF_NOGRAPHTHREAD = 0x00000001,
}
alias __MIDL___MIDL_itf_amstream_0000_0000_0001 = int;

enum : int
{
    AMMSF_ADDDEFAULTRENDERER = 0x00000001,
    AMMSF_CREATEPEER         = 0x00000002,
    AMMSF_STOPIFNOSAMPLES    = 0x00000004,
    AMMSF_NOSTALL            = 0x00000008,
}
alias __MIDL___MIDL_itf_amstream_0000_0000_0002 = int;

enum : int
{
    AMMSF_RENDERTYPEMASK   = 0x00000003,
    AMMSF_RENDERTOEXISTING = 0x00000000,
    AMMSF_RENDERALLSTREAMS = 0x00000001,
    AMMSF_NORENDER         = 0x00000002,
    AMMSF_NOCLOCK          = 0x00000004,
    AMMSF_RUN              = 0x00000008,
}
alias __MIDL___MIDL_itf_amstream_0000_0000_0003 = int;

enum : int
{
    Disabled   = 0x00000000,
    ReadData   = 0x00000001,
    RenderData = 0x00000002,
}
alias __MIDL___MIDL_itf_amstream_0000_0000_0004 = int;

enum : int
{
    AM_PROPERTY_FRAMESTEP_STEP            = 0x00000001,
    AM_PROPERTY_FRAMESTEP_CANCEL          = 0x00000002,
    AM_PROPERTY_FRAMESTEP_CANSTEP         = 0x00000003,
    AM_PROPERTY_FRAMESTEP_CANSTEPMULTIPLE = 0x00000004,
}
alias AM_PROPERTY_FRAMESTEP = int;

enum : int
{
    KsAllocatorMode_User   = 0x00000000,
    KsAllocatorMode_Kernel = 0x00000001,
}
alias KSALLOCATORMODE = int;

enum : int
{
    FramingProp_Uninitialized = 0x00000000,
    FramingProp_None          = 0x00000001,
    FramingProp_Old           = 0x00000002,
    FramingProp_Ex            = 0x00000003,
}
alias FRAMING_PROP = int;

enum : int
{
    Framing_Cache_Update   = 0x00000000,
    Framing_Cache_ReadLast = 0x00000001,
    Framing_Cache_ReadOrig = 0x00000002,
    Framing_Cache_Write    = 0x00000003,
}
alias FRAMING_CACHE_OPS = int;

enum : int
{
    PipeState_DontCare           = 0x00000000,
    PipeState_RangeNotFixed      = 0x00000001,
    PipeState_RangeFixed         = 0x00000002,
    PipeState_CompressionUnknown = 0x00000003,
    PipeState_Finalized          = 0x00000004,
}
alias PIPE_STATE = int;

enum : int
{
    Pipe_Allocator_None      = 0x00000000,
    Pipe_Allocator_FirstPin  = 0x00000001,
    Pipe_Allocator_LastPin   = 0x00000002,
    Pipe_Allocator_MiddlePin = 0x00000003,
}
alias PIPE_ALLOCATOR_PLACE = int;

enum : int
{
    KS_MemoryTypeDontCare         = 0x00000000,
    KS_MemoryTypeKernelPaged      = 0x00000001,
    KS_MemoryTypeKernelNonPaged   = 0x00000002,
    KS_MemoryTypeDeviceHostMapped = 0x00000003,
    KS_MemoryTypeDeviceSpecific   = 0x00000004,
    KS_MemoryTypeUser             = 0x00000005,
    KS_MemoryTypeAnyHost          = 0x00000006,
}
alias KS_LogicalMemoryType = int;

enum : int
{
    AM_ARMODE_STRETCHED            = 0x00000000,
    AM_ARMODE_LETTER_BOX           = 0x00000001,
    AM_ARMODE_CROP                 = 0x00000002,
    AM_ARMODE_STRETCHED_AS_PRIMARY = 0x00000003,
}
alias AM_ASPECT_RATIO_MODE = int;

enum VMR9PresentationFlags : int
{
    VMR9Sample_SyncPoint        = 0x00000001,
    VMR9Sample_Preroll          = 0x00000002,
    VMR9Sample_Discontinuity    = 0x00000004,
    VMR9Sample_TimeValid        = 0x00000008,
    VMR9Sample_SrcDstRectsValid = 0x00000010,
}

enum VMR9SurfaceAllocationFlags : int
{
    VMR9AllocFlag_3DRenderTarget   = 0x00000001,
    VMR9AllocFlag_DXVATarget       = 0x00000002,
    VMR9AllocFlag_TextureSurface   = 0x00000004,
    VMR9AllocFlag_OffscreenSurface = 0x00000008,
    VMR9AllocFlag_RGBDynamicSwitch = 0x00000010,
    VMR9AllocFlag_UsageReserved    = 0x000000e0,
    VMR9AllocFlag_UsageMask        = 0x000000ff,
}

enum VMR9AspectRatioMode : int
{
    VMR9ARMode_None      = 0x00000000,
    VMR9ARMode_LetterBox = 0x00000001,
}

enum VMR9MixerPrefs : int
{
    MixerPref9_NoDecimation           = 0x00000001,
    MixerPref9_DecimateOutput         = 0x00000002,
    MixerPref9_ARAdjustXorY           = 0x00000004,
    MixerPref9_NonSquareMixing        = 0x00000008,
    MixerPref9_DecimateMask           = 0x0000000f,
    MixerPref9_BiLinearFiltering      = 0x00000010,
    MixerPref9_PointFiltering         = 0x00000020,
    MixerPref9_AnisotropicFiltering   = 0x00000040,
    MixerPref9_PyramidalQuadFiltering = 0x00000080,
    MixerPref9_GaussianQuadFiltering  = 0x00000100,
    MixerPref9_FilteringReserved      = 0x00000e00,
    MixerPref9_FilteringMask          = 0x00000ff0,
    MixerPref9_RenderTargetRGB        = 0x00001000,
    MixerPref9_RenderTargetYUV        = 0x00002000,
    MixerPref9_RenderTargetReserved   = 0x000fc000,
    MixerPref9_RenderTargetMask       = 0x000ff000,
    MixerPref9_DynamicSwitchToBOB     = 0x00100000,
    MixerPref9_DynamicDecimateBy2     = 0x00200000,
    MixerPref9_DynamicReserved        = 0x00c00000,
    MixerPref9_DynamicMask            = 0x00f00000,
}

enum VMR9ProcAmpControlFlags : int
{
    ProcAmpControl9_Brightness = 0x00000001,
    ProcAmpControl9_Contrast   = 0x00000002,
    ProcAmpControl9_Hue        = 0x00000004,
    ProcAmpControl9_Saturation = 0x00000008,
    ProcAmpControl9_Mask       = 0x0000000f,
}

enum VMR9AlphaBitmapFlags : int
{
    VMR9AlphaBitmap_Disable     = 0x00000001,
    VMR9AlphaBitmap_hDC         = 0x00000002,
    VMR9AlphaBitmap_EntireDDS   = 0x00000004,
    VMR9AlphaBitmap_SrcColorKey = 0x00000008,
    VMR9AlphaBitmap_SrcRect     = 0x00000010,
    VMR9AlphaBitmap_FilterMode  = 0x00000020,
}

enum VMR9RenderPrefs : int
{
    RenderPrefs9_DoNotRenderBorder = 0x00000001,
    RenderPrefs9_Mask              = 0x00000001,
}

enum : int
{
    VMR9Mode_Windowed   = 0x00000001,
    VMR9Mode_Windowless = 0x00000002,
    VMR9Mode_Renderless = 0x00000004,
    VMR9Mode_Mask       = 0x00000007,
}
alias VMR9Mode = int;

enum VMR9DeinterlacePrefs : int
{
    DeinterlacePref9_NextBest = 0x00000001,
    DeinterlacePref9_BOB      = 0x00000002,
    DeinterlacePref9_Weave    = 0x00000004,
    DeinterlacePref9_Mask     = 0x00000007,
}

enum VMR9DeinterlaceTech : int
{
    DeinterlaceTech9_Unknown             = 0x00000000,
    DeinterlaceTech9_BOBLineReplicate    = 0x00000001,
    DeinterlaceTech9_BOBVerticalStretch  = 0x00000002,
    DeinterlaceTech9_MedianFiltering     = 0x00000004,
    DeinterlaceTech9_EdgeFiltering       = 0x00000010,
    DeinterlaceTech9_FieldAdaptive       = 0x00000020,
    DeinterlaceTech9_PixelAdaptive       = 0x00000040,
    DeinterlaceTech9_MotionVectorSteered = 0x00000080,
}

enum : int
{
    VMR9_SampleReserved                  = 0x00000001,
    VMR9_SampleProgressiveFrame          = 0x00000002,
    VMR9_SampleFieldInterleavedEvenFirst = 0x00000003,
    VMR9_SampleFieldInterleavedOddFirst  = 0x00000004,
    VMR9_SampleFieldSingleEven           = 0x00000005,
    VMR9_SampleFieldSingleOdd            = 0x00000006,
}
alias VMR9_SampleFormat = int;

enum : int
{
    AM_PROPERTY_AC3_ERROR_CONCEALMENT = 0x00000001,
    AM_PROPERTY_AC3_ALTERNATE_AUDIO   = 0x00000002,
    AM_PROPERTY_AC3_DOWNMIX           = 0x00000003,
    AM_PROPERTY_AC3_BIT_STREAM_MODE   = 0x00000004,
    AM_PROPERTY_AC3_DIALOGUE_LEVEL    = 0x00000005,
    AM_PROPERTY_AC3_LANGUAGE_CODE     = 0x00000006,
    AM_PROPERTY_AC3_ROOM_TYPE         = 0x00000007,
}
alias AM_PROPERTY_AC3 = int;

enum : int
{
    AM_PROPERTY_DVDSUBPIC_PALETTE     = 0x00000000,
    AM_PROPERTY_DVDSUBPIC_HLI         = 0x00000001,
    AM_PROPERTY_DVDSUBPIC_COMPOSIT_ON = 0x00000002,
}
alias AM_PROPERTY_DVDSUBPIC = int;

enum : int
{
    AM_PROPERTY_DVDCOPY_CHLG_KEY              = 0x00000001,
    AM_PROPERTY_DVDCOPY_DVD_KEY1              = 0x00000002,
    AM_PROPERTY_DVDCOPY_DEC_KEY2              = 0x00000003,
    AM_PROPERTY_DVDCOPY_TITLE_KEY             = 0x00000004,
    AM_PROPERTY_COPY_MACROVISION              = 0x00000005,
    AM_PROPERTY_DVDCOPY_REGION                = 0x00000006,
    AM_PROPERTY_DVDCOPY_SET_COPY_STATE        = 0x00000007,
    AM_PROPERTY_COPY_ANALOG_COMPONENT         = 0x00000008,
    AM_PROPERTY_COPY_DIGITAL_CP               = 0x00000009,
    AM_PROPERTY_COPY_DVD_SRM                  = 0x0000000a,
    AM_PROPERTY_DVDCOPY_SUPPORTS_NEW_KEYCOUNT = 0x0000000b,
    AM_PROPERTY_DVDCOPY_DISC_KEY              = 0x00000080,
}
alias AM_PROPERTY_DVDCOPYPROT = int;

enum : int
{
    AM_DIGITAL_CP_OFF           = 0x00000000,
    AM_DIGITAL_CP_ON            = 0x00000001,
    AM_DIGITAL_CP_DVD_COMPLIANT = 0x00000002,
}
alias AM_DIGITAL_CP = int;

enum : int
{
    AM_DVDCOPYSTATE_INITIALIZE                  = 0x00000000,
    AM_DVDCOPYSTATE_INITIALIZE_TITLE            = 0x00000001,
    AM_DVDCOPYSTATE_AUTHENTICATION_NOT_REQUIRED = 0x00000002,
    AM_DVDCOPYSTATE_AUTHENTICATION_REQUIRED     = 0x00000003,
    AM_DVDCOPYSTATE_DONE                        = 0x00000004,
}
alias AM_DVDCOPYSTATE = int;

enum : int
{
    AM_MACROVISION_DISABLED = 0x00000000,
    AM_MACROVISION_LEVEL1   = 0x00000001,
    AM_MACROVISION_LEVEL2   = 0x00000002,
    AM_MACROVISION_LEVEL3   = 0x00000003,
}
alias AM_COPY_MACROVISION_LEVEL = int;

enum : int
{
    AM_MPEG2Level_Low      = 0x00000001,
    AM_MPEG2Level_Main     = 0x00000002,
    AM_MPEG2Level_High1440 = 0x00000003,
    AM_MPEG2Level_High     = 0x00000004,
}
alias AM_MPEG2Level = int;

enum : int
{
    AM_MPEG2Profile_Simple            = 0x00000001,
    AM_MPEG2Profile_Main              = 0x00000002,
    AM_MPEG2Profile_SNRScalable       = 0x00000003,
    AM_MPEG2Profile_SpatiallyScalable = 0x00000004,
    AM_MPEG2Profile_High              = 0x00000005,
}
alias AM_MPEG2Profile = int;

enum : int
{
    AM_PROPERTY_DVDKARAOKE_ENABLE = 0x00000000,
    AM_PROPERTY_DVDKARAOKE_DATA   = 0x00000001,
}
alias AM_PROPERTY_DVDKARAOKE = int;

enum : int
{
    AM_RATE_SimpleRateChange       = 0x00000001,
    AM_RATE_ExactRateChange        = 0x00000002,
    AM_RATE_MaxFullDataRate        = 0x00000003,
    AM_RATE_Step                   = 0x00000004,
    AM_RATE_UseRateVersion         = 0x00000005,
    AM_RATE_QueryFullFrameRate     = 0x00000006,
    AM_RATE_QueryLastRateSegPTS    = 0x00000007,
    AM_RATE_CorrectTS              = 0x00000008,
    AM_RATE_ReverseMaxFullDataRate = 0x00000009,
    AM_RATE_ResetOnTimeDisc        = 0x0000000a,
    AM_RATE_QueryMapping           = 0x0000000b,
}
alias AM_PROPERTY_TS_RATE_CHANGE = int;

enum : int
{
    AM_RATE_ChangeRate      = 0x00000001,
    AM_RATE_FullDataRateMax = 0x00000002,
    AM_RATE_ReverseDecode   = 0x00000003,
    AM_RATE_DecoderPosition = 0x00000004,
    AM_RATE_DecoderVersion  = 0x00000005,
}
alias AM_PROPERTY_DVD_RATE_CHANGE = int;

enum : int
{
    DVD_DIR_FORWARD  = 0x00000000,
    DVD_DIR_BACKWARD = 0x00000001,
}
alias DVD_PLAY_DIRECTION = int;

enum : int
{
    DVD_ERROR_Unexpected                          = 0x00000001,
    DVD_ERROR_CopyProtectFail                     = 0x00000002,
    DVD_ERROR_InvalidDVD1_0Disc                   = 0x00000003,
    DVD_ERROR_InvalidDiscRegion                   = 0x00000004,
    DVD_ERROR_LowParentalLevel                    = 0x00000005,
    DVD_ERROR_MacrovisionFail                     = 0x00000006,
    DVD_ERROR_IncompatibleSystemAndDecoderRegions = 0x00000007,
    DVD_ERROR_IncompatibleDiscAndDecoderRegions   = 0x00000008,
    DVD_ERROR_CopyProtectOutputFail               = 0x00000009,
    DVD_ERROR_CopyProtectOutputNotSupported       = 0x0000000a,
}
alias DVD_ERROR = int;

enum : int
{
    DVD_WARNING_InvalidDVD1_0Disc  = 0x00000001,
    DVD_WARNING_FormatNotSupported = 0x00000002,
    DVD_WARNING_IllegalNavCommand  = 0x00000003,
    DVD_WARNING_Open               = 0x00000004,
    DVD_WARNING_Seek               = 0x00000005,
    DVD_WARNING_Read               = 0x00000006,
}
alias DVD_WARNING = int;

enum : int
{
    DVD_PB_STOPPED_Other                         = 0x00000000,
    DVD_PB_STOPPED_NoBranch                      = 0x00000001,
    DVD_PB_STOPPED_NoFirstPlayDomain             = 0x00000002,
    DVD_PB_STOPPED_StopCommand                   = 0x00000003,
    DVD_PB_STOPPED_Reset                         = 0x00000004,
    DVD_PB_STOPPED_DiscEjected                   = 0x00000005,
    DVD_PB_STOPPED_IllegalNavCommand             = 0x00000006,
    DVD_PB_STOPPED_PlayPeriodAutoStop            = 0x00000007,
    DVD_PB_STOPPED_PlayChapterAutoStop           = 0x00000008,
    DVD_PB_STOPPED_ParentalFailure               = 0x00000009,
    DVD_PB_STOPPED_RegionFailure                 = 0x0000000a,
    DVD_PB_STOPPED_MacrovisionFailure            = 0x0000000b,
    DVD_PB_STOPPED_DiscReadError                 = 0x0000000c,
    DVD_PB_STOPPED_CopyProtectFailure            = 0x0000000d,
    DVD_PB_STOPPED_CopyProtectOutputFailure      = 0x0000000e,
    DVD_PB_STOPPED_CopyProtectOutputNotSupported = 0x0000000f,
}
alias DVD_PB_STOPPED = int;

enum : int
{
    SNDDEV_ERROR_Open            = 0x00000001,
    SNDDEV_ERROR_Close           = 0x00000002,
    SNDDEV_ERROR_GetCaps         = 0x00000003,
    SNDDEV_ERROR_PrepareHeader   = 0x00000004,
    SNDDEV_ERROR_UnprepareHeader = 0x00000005,
    SNDDEV_ERROR_Reset           = 0x00000006,
    SNDDEV_ERROR_Restart         = 0x00000007,
    SNDDEV_ERROR_GetPosition     = 0x00000008,
    SNDDEV_ERROR_Write           = 0x00000009,
    SNDDEV_ERROR_Pause           = 0x0000000a,
    SNDDEV_ERROR_Stop            = 0x0000000b,
    SNDDEV_ERROR_Start           = 0x0000000c,
    SNDDEV_ERROR_AddBuffer       = 0x0000000d,
    SNDDEV_ERROR_Query           = 0x0000000e,
}
alias SNDDEV_ERR = int;

enum : int
{
    MPT_INT   = 0x00000000,
    MPT_FLOAT = 0x00000001,
    MPT_BOOL  = 0x00000002,
    MPT_ENUM  = 0x00000003,
    MPT_MAX   = 0x00000004,
}
alias MP_TYPE = int;

enum : int
{
    MP_CURVE_JUMP      = 0x00000001,
    MP_CURVE_LINEAR    = 0x00000002,
    MP_CURVE_SQUARE    = 0x00000004,
    MP_CURVE_INVSQUARE = 0x00000008,
    MP_CURVE_SINE      = 0x00000010,
}
alias MP_CURVE_TYPE = int;

enum : int
{
    DMO_REGISTERF_IS_KEYED = 0x00000001,
}
alias DMO_REGISTER_FLAGS = int;

enum : int
{
    DMO_ENUMF_INCLUDE_KEYED = 0x00000001,
}
alias DMO_ENUM_FLAGS = int;

enum : int
{
    ConstantBitRate        = 0x00000000,
    VariableBitRateAverage = 0x00000001,
    VariableBitRatePeak    = 0x00000002,
}
alias VIDEOENCODER_BITRATE_MODE = int;

enum : int
{
    DISPID_TUNER_TS_UNIQUENAME                        = 0x00000001,
    DISPID_TUNER_TS_FRIENDLYNAME                      = 0x00000002,
    DISPID_TUNER_TS_CLSID                             = 0x00000003,
    DISPID_TUNER_TS_NETWORKTYPE                       = 0x00000004,
    DISPID_TUNER_TS__NETWORKTYPE                      = 0x00000005,
    DISPID_TUNER_TS_CREATETUNEREQUEST                 = 0x00000006,
    DISPID_TUNER_TS_ENUMCATEGORYGUIDS                 = 0x00000007,
    DISPID_TUNER_TS_ENUMDEVICEMONIKERS                = 0x00000008,
    DISPID_TUNER_TS_DEFAULTPREFERREDCOMPONENTTYPES    = 0x00000009,
    DISPID_TUNER_TS_FREQMAP                           = 0x0000000a,
    DISPID_TUNER_TS_DEFLOCATOR                        = 0x0000000b,
    DISPID_TUNER_TS_CLONE                             = 0x0000000c,
    DISPID_TUNER_TR_TUNINGSPACE                       = 0x00000001,
    DISPID_TUNER_TR_COMPONENTS                        = 0x00000002,
    DISPID_TUNER_TR_CLONE                             = 0x00000003,
    DISPID_TUNER_TR_LOCATOR                           = 0x00000004,
    DISPID_TUNER_CT_CATEGORY                          = 0x00000001,
    DISPID_TUNER_CT_MEDIAMAJORTYPE                    = 0x00000002,
    DISPID_TUNER_CT__MEDIAMAJORTYPE                   = 0x00000003,
    DISPID_TUNER_CT_MEDIASUBTYPE                      = 0x00000004,
    DISPID_TUNER_CT__MEDIASUBTYPE                     = 0x00000005,
    DISPID_TUNER_CT_MEDIAFORMATTYPE                   = 0x00000006,
    DISPID_TUNER_CT__MEDIAFORMATTYPE                  = 0x00000007,
    DISPID_TUNER_CT_MEDIATYPE                         = 0x00000008,
    DISPID_TUNER_CT_CLONE                             = 0x00000009,
    DISPID_TUNER_LCT_LANGID                           = 0x00000064,
    DISPID_TUNER_MP2CT_TYPE                           = 0x000000c8,
    DISPID_TUNER_ATSCCT_FLAGS                         = 0x0000012c,
    DISPID_TUNER_L_CARRFREQ                           = 0x00000001,
    DISPID_TUNER_L_INNERFECMETHOD                     = 0x00000002,
    DISPID_TUNER_L_INNERFECRATE                       = 0x00000003,
    DISPID_TUNER_L_OUTERFECMETHOD                     = 0x00000004,
    DISPID_TUNER_L_OUTERFECRATE                       = 0x00000005,
    DISPID_TUNER_L_MOD                                = 0x00000006,
    DISPID_TUNER_L_SYMRATE                            = 0x00000007,
    DISPID_TUNER_L_CLONE                              = 0x00000008,
    DISPID_TUNER_L_ATSC_PHYS_CHANNEL                  = 0x000000c9,
    DISPID_TUNER_L_ATSC_TSID                          = 0x000000ca,
    DISPID_TUNER_L_ATSC_MP2_PROGNO                    = 0x000000cb,
    DISPID_TUNER_L_DVBT_BANDWIDTH                     = 0x0000012d,
    DISPID_TUNER_L_DVBT_LPINNERFECMETHOD              = 0x0000012e,
    DISPID_TUNER_L_DVBT_LPINNERFECRATE                = 0x0000012f,
    DISPID_TUNER_L_DVBT_GUARDINTERVAL                 = 0x00000130,
    DISPID_TUNER_L_DVBT_HALPHA                        = 0x00000131,
    DISPID_TUNER_L_DVBT_TRANSMISSIONMODE              = 0x00000132,
    DISPID_TUNER_L_DVBT_INUSE                         = 0x00000133,
    DISPID_TUNER_L_DVBT2_PHYSICALLAYERPIPEID          = 0x0000015f,
    DISPID_TUNER_L_DVBS_POLARISATION                  = 0x00000191,
    DISPID_TUNER_L_DVBS_WEST                          = 0x00000192,
    DISPID_TUNER_L_DVBS_ORBITAL                       = 0x00000193,
    DISPID_TUNER_L_DVBS_AZIMUTH                       = 0x00000194,
    DISPID_TUNER_L_DVBS_ELEVATION                     = 0x00000195,
    DISPID_TUNER_L_DVBS2_DISEQ_LNB_SOURCE             = 0x00000196,
    DISPID_TUNER_TS_DVBS2_LOW_OSC_FREQ_OVERRIDE       = 0x00000197,
    DISPID_TUNER_TS_DVBS2_HI_OSC_FREQ_OVERRIDE        = 0x00000198,
    DISPID_TUNER_TS_DVBS2_LNB_SWITCH_FREQ_OVERRIDE    = 0x00000199,
    DISPID_TUNER_TS_DVBS2_SPECTRAL_INVERSION_OVERRIDE = 0x0000019a,
    DISPID_TUNER_L_DVBS2_ROLLOFF                      = 0x0000019b,
    DISPID_TUNER_L_DVBS2_PILOT                        = 0x0000019c,
    DISPID_TUNER_L_ANALOG_STANDARD                    = 0x00000259,
    DISPID_TUNER_L_DTV_O_MAJOR_CHANNEL                = 0x000002bd,
    DISPID_TUNER_C_TYPE                               = 0x00000001,
    DISPID_TUNER_C_STATUS                             = 0x00000002,
    DISPID_TUNER_C_LANGID                             = 0x00000003,
    DISPID_TUNER_C_DESCRIPTION                        = 0x00000004,
    DISPID_TUNER_C_CLONE                              = 0x00000005,
    DISPID_TUNER_C_MP2_PID                            = 0x00000065,
    DISPID_TUNER_C_MP2_PCRPID                         = 0x00000066,
    DISPID_TUNER_C_MP2_PROGNO                         = 0x00000067,
    DISPID_TUNER_C_ANALOG_AUDIO                       = 0x000000c9,
    DISPID_TUNER_TS_DVB_SYSTEMTYPE                    = 0x00000065,
    DISPID_TUNER_TS_DVB2_NETWORK_ID                   = 0x00000066,
    DISPID_TUNER_TS_DVBS_LOW_OSC_FREQ                 = 0x000003e9,
    DISPID_TUNER_TS_DVBS_HI_OSC_FREQ                  = 0x000003ea,
    DISPID_TUNER_TS_DVBS_LNB_SWITCH_FREQ              = 0x000003eb,
    DISPID_TUNER_TS_DVBS_INPUT_RANGE                  = 0x000003ec,
    DISPID_TUNER_TS_DVBS_SPECTRAL_INVERSION           = 0x000003ed,
    DISPID_TUNER_TS_AR_MINFREQUENCY                   = 0x00000065,
    DISPID_TUNER_TS_AR_MAXFREQUENCY                   = 0x00000066,
    DISPID_TUNER_TS_AR_STEP                           = 0x00000067,
    DISPID_TUNER_TS_AR_COUNTRYCODE                    = 0x00000068,
    DISPID_TUNER_TS_AUX_COUNTRYCODE                   = 0x00000065,
    DISPID_TUNER_TS_ATV_MINCHANNEL                    = 0x00000065,
    DISPID_TUNER_TS_ATV_MAXCHANNEL                    = 0x00000066,
    DISPID_TUNER_TS_ATV_INPUTTYPE                     = 0x00000067,
    DISPID_TUNER_TS_ATV_COUNTRYCODE                   = 0x00000068,
    DISPID_TUNER_TS_ATSC_MINMINORCHANNEL              = 0x000000c9,
    DISPID_TUNER_TS_ATSC_MAXMINORCHANNEL              = 0x000000ca,
    DISPID_TUNER_TS_ATSC_MINPHYSCHANNEL               = 0x000000cb,
    DISPID_TUNER_TS_ATSC_MAXPHYSCHANNEL               = 0x000000cc,
    DISPID_TUNER_TS_DC_MINMAJORCHANNEL                = 0x0000012d,
    DISPID_TUNER_TS_DC_MAXMAJORCHANNEL                = 0x0000012e,
    DISPID_TUNER_TS_DC_MINSOURCEID                    = 0x0000012f,
    DISPID_TUNER_TS_DC_MAXSOURCEID                    = 0x00000130,
    DISPID_CHTUNER_ATVAC_CHANNEL                      = 0x00000065,
    DISPID_CHTUNER_ATVDC_SYSTEM                       = 0x00000065,
    DISPID_CHTUNER_ATVDC_CONTENT                      = 0x00000066,
    DISPID_CHTUNER_CIDTR_CHANNELID                    = 0x00000065,
    DISPID_CHTUNER_CTR_CHANNEL                        = 0x00000065,
    DISPID_CHTUNER_ACTR_MINOR_CHANNEL                 = 0x000000c9,
    DISPID_CHTUNER_DCTR_MAJOR_CHANNEL                 = 0x0000012d,
    DISPID_CHTUNER_DCTR_SRCID                         = 0x0000012e,
    DISPID_DVBTUNER_DVBC_ATTRIBUTESVALID              = 0x00000065,
    DISPID_DVBTUNER_DVBC_PID                          = 0x00000066,
    DISPID_DVBTUNER_DVBC_TAG                          = 0x00000067,
    DISPID_DVBTUNER_DVBC_COMPONENTTYPE                = 0x00000068,
    DISPID_DVBTUNER_ONID                              = 0x00000065,
    DISPID_DVBTUNER_TSID                              = 0x00000066,
    DISPID_DVBTUNER_SID                               = 0x00000067,
    DISPID_MP2TUNER_TSID                              = 0x00000065,
    DISPID_MP2TUNER_PROGNO                            = 0x00000066,
    DISPID_MP2TUNERFACTORY_CREATETUNEREQUEST          = 0x00000001,
}
alias __MIDL___MIDL_itf_tuner_0000_0000_0001 = int;

enum : int
{
    MPAA                 = 0x00000000,
    US_TV                = 0x00000001,
    Canadian_English     = 0x00000002,
    Canadian_French      = 0x00000003,
    Reserved4            = 0x00000004,
    System5              = 0x00000005,
    System6              = 0x00000006,
    Reserved7            = 0x00000007,
    PBDA                 = 0x00000008,
    AgeBased             = 0x00000009,
    TvRat_kSystems       = 0x0000000a,
    TvRat_SystemDontKnow = 0x000000ff,
}
alias EnTvRat_System = int;

enum : int
{
    TvRat_0             = 0x00000000,
    TvRat_1             = 0x00000001,
    TvRat_2             = 0x00000002,
    TvRat_3             = 0x00000003,
    TvRat_4             = 0x00000004,
    TvRat_5             = 0x00000005,
    TvRat_6             = 0x00000006,
    TvRat_7             = 0x00000007,
    TvRat_8             = 0x00000008,
    TvRat_9             = 0x00000009,
    TvRat_10            = 0x0000000a,
    TvRat_11            = 0x0000000b,
    TvRat_12            = 0x0000000c,
    TvRat_13            = 0x0000000d,
    TvRat_14            = 0x0000000e,
    TvRat_15            = 0x0000000f,
    TvRat_16            = 0x00000010,
    TvRat_17            = 0x00000011,
    TvRat_18            = 0x00000012,
    TvRat_19            = 0x00000013,
    TvRat_20            = 0x00000014,
    TvRat_21            = 0x00000015,
    TvRat_kLevels       = 0x00000016,
    TvRat_Unblock       = 0xffffffff,
    TvRat_LevelDontKnow = 0x000000ff,
}
alias EnTvRat_GenericLevel = int;

enum : int
{
    MPAA_NotApplicable = 0x00000000,
    MPAA_G             = 0x00000001,
    MPAA_PG            = 0x00000002,
    MPAA_PG13          = 0x00000003,
    MPAA_R             = 0x00000004,
    MPAA_NC17          = 0x00000005,
    MPAA_X             = 0x00000006,
    MPAA_NotRated      = 0x00000007,
}
alias EnTvRat_MPAA = int;

enum : int
{
    US_TV_None  = 0x00000000,
    US_TV_Y     = 0x00000001,
    US_TV_Y7    = 0x00000002,
    US_TV_G     = 0x00000003,
    US_TV_PG    = 0x00000004,
    US_TV_14    = 0x00000005,
    US_TV_MA    = 0x00000006,
    US_TV_None7 = 0x00000007,
}
alias EnTvRat_US_TV = int;

enum : int
{
    CAE_TV_Exempt   = 0x00000000,
    CAE_TV_C        = 0x00000001,
    CAE_TV_C8       = 0x00000002,
    CAE_TV_G        = 0x00000003,
    CAE_TV_PG       = 0x00000004,
    CAE_TV_14       = 0x00000005,
    CAE_TV_18       = 0x00000006,
    CAE_TV_Reserved = 0x00000007,
}
alias EnTvRat_CAE_TV = int;

enum : int
{
    CAF_TV_Exempt    = 0x00000000,
    CAF_TV_G         = 0x00000001,
    CAF_TV_8         = 0x00000002,
    CAF_TV_13        = 0x00000003,
    CAF_TV_16        = 0x00000004,
    CAF_TV_18        = 0x00000005,
    CAF_TV_Reserved6 = 0x00000006,
    CAF_TV_Reserved  = 0x00000007,
}
alias EnTvRat_CAF_TV = int;

enum : int
{
    BfAttrNone         = 0x00000000,
    BfIsBlocked        = 0x00000001,
    BfIsAttr_1         = 0x00000002,
    BfIsAttr_2         = 0x00000004,
    BfIsAttr_3         = 0x00000008,
    BfIsAttr_4         = 0x00000010,
    BfIsAttr_5         = 0x00000020,
    BfIsAttr_6         = 0x00000040,
    BfIsAttr_7         = 0x00000080,
    BfValidAttrSubmask = 0x000000ff,
}
alias BfEnTvRat_GenericAttributes = int;

enum : int
{
    US_TV_IsBlocked                  = 0x00000001,
    US_TV_IsViolent                  = 0x00000002,
    US_TV_IsSexualSituation          = 0x00000004,
    US_TV_IsAdultLanguage            = 0x00000008,
    US_TV_IsSexuallySuggestiveDialog = 0x00000010,
    US_TV_ValidAttrSubmask           = 0x0000001f,
}
alias BfEnTvRat_Attributes_US_TV = int;

enum : int
{
    MPAA_IsBlocked        = 0x00000001,
    MPAA_ValidAttrSubmask = 0x00000001,
}
alias BfEnTvRat_Attributes_MPAA = int;

enum : int
{
    CAE_IsBlocked        = 0x00000001,
    CAE_ValidAttrSubmask = 0x00000001,
}
alias BfEnTvRat_Attributes_CAE_TV = int;

enum : int
{
    CAF_IsBlocked        = 0x00000001,
    CAF_ValidAttrSubmask = 0x00000001,
}
alias BfEnTvRat_Attributes_CAF_TV = int;

enum FormatNotSupportedEvents : int
{
    FORMATNOTSUPPORTED_CLEAR        = 0x00000000,
    FORMATNOTSUPPORTED_NOTSUPPORTED = 0x00000001,
}

enum ProtType : int
{
    PROT_COPY_FREE              = 0x00000001,
    PROT_COPY_ONCE              = 0x00000002,
    PROT_COPY_NEVER             = 0x00000003,
    PROT_COPY_NEVER_REALLY      = 0x00000004,
    PROT_COPY_NO_MORE           = 0x00000005,
    PROT_COPY_FREE_CIT          = 0x00000006,
    PROT_COPY_BF                = 0x00000007,
    PROT_COPY_CN_RECORDING_STOP = 0x00000008,
    PROT_COPY_FREE_SECURE       = 0x00000009,
    PROT_COPY_INVALID           = 0x00000032,
}

enum EncDecEvents : int
{
    ENCDEC_CPEVENT          = 0x00000000,
    ENCDEC_RECORDING_STATUS = 0x00000001,
}

enum CPRecordingStatus : int
{
    RECORDING_STOPPED = 0x00000000,
    RECORDING_STARTED = 0x00000001,
}

enum CPEventBitShift : int
{
    CPEVENT_BITSHIFT_RATINGS             = 0x00000000,
    CPEVENT_BITSHIFT_COPP                = 0x00000001,
    CPEVENT_BITSHIFT_LICENSE             = 0x00000002,
    CPEVENT_BITSHIFT_ROLLBACK            = 0x00000003,
    CPEVENT_BITSHIFT_SAC                 = 0x00000004,
    CPEVENT_BITSHIFT_DOWNRES             = 0x00000005,
    CPEVENT_BITSHIFT_STUBLIB             = 0x00000006,
    CPEVENT_BITSHIFT_UNTRUSTEDGRAPH      = 0x00000007,
    CPEVENT_BITSHIFT_PENDING_CERTIFICATE = 0x00000008,
    CPEVENT_BITSHIFT_NO_PLAYREADY        = 0x00000009,
}

enum CPEvents : int
{
    CPEVENT_NONE            = 0x00000000,
    CPEVENT_RATINGS         = 0x00000001,
    CPEVENT_COPP            = 0x00000002,
    CPEVENT_LICENSE         = 0x00000003,
    CPEVENT_ROLLBACK        = 0x00000004,
    CPEVENT_SAC             = 0x00000005,
    CPEVENT_DOWNRES         = 0x00000006,
    CPEVENT_STUBLIB         = 0x00000007,
    CPEVENT_UNTRUSTEDGRAPH  = 0x00000008,
    CPEVENT_PROTECTWINDOWED = 0x00000009,
}

enum RevokedComponent : int
{
    REVOKED_COPP            = 0x00000000,
    REVOKED_SAC             = 0x00000001,
    REVOKED_APP_STUB        = 0x00000002,
    REVOKED_SECURE_PIPELINE = 0x00000003,
    REVOKED_MAX_TYPES       = 0x00000004,
}

enum : int
{
    EnTag_Remove = 0x00000000,
    EnTag_Once   = 0x00000001,
    EnTag_Repeat = 0x00000002,
}
alias EnTag_Mode = int;

enum COPPEventBlockReason : int
{
    COPP_Unknown                 = 0xffffffff,
    COPP_BadDriver               = 0x00000000,
    COPP_NoCardHDCPSupport       = 0x00000001,
    COPP_NoMonitorHDCPSupport    = 0x00000002,
    COPP_BadCertificate          = 0x00000003,
    COPP_InvalidBusProtection    = 0x00000004,
    COPP_AeroGlassOff            = 0x00000005,
    COPP_RogueApp                = 0x00000006,
    COPP_ForbiddenVideo          = 0x00000007,
    COPP_Activate                = 0x00000008,
    COPP_DigitalAudioUnprotected = 0x00000009,
}

enum LicenseEventBlockReason : int
{
    LIC_BadLicense      = 0x00000000,
    LIC_NeedIndiv       = 0x00000001,
    LIC_Expired         = 0x00000002,
    LIC_NeedActivation  = 0x00000003,
    LIC_ExtenderBlocked = 0x00000004,
}

enum DownResEventParam : int
{
    DOWNRES_Always       = 0x00000000,
    DOWNRES_InWindowOnly = 0x00000001,
    DOWNRES_Undefined    = 0x00000002,
}

enum SegDispidList : int
{
    dispidName                             = 0x00000000,
    dispidStatus                           = 0x00000001,
    dispidDevImageSourceWidth              = 0x00000002,
    dispidDevImageSourceHeight             = 0x00000003,
    dispidDevCountryCode                   = 0x00000004,
    dispidDevOverScan                      = 0x00000005,
    dispidSegment                          = 0x00000006,
    dispidDevVolume                        = 0x00000007,
    dispidDevBalance                       = 0x00000008,
    dispidDevPower                         = 0x00000009,
    dispidTuneChan                         = 0x0000000a,
    dispidDevVideoSubchannel               = 0x0000000b,
    dispidDevAudioSubchannel               = 0x0000000c,
    dispidChannelAvailable                 = 0x0000000d,
    dispidDevVideoFrequency                = 0x0000000e,
    dispidDevAudioFrequency                = 0x0000000f,
    dispidCount                            = 0x00000010,
    dispidDevFileName                      = 0x00000011,
    dispidVisible                          = 0x00000012,
    dispidOwner                            = 0x00000013,
    dispidMessageDrain                     = 0x00000014,
    dispidViewable                         = 0x00000015,
    dispidDevView                          = 0x00000016,
    dispidKSCat                            = 0x00000017,
    dispidCLSID                            = 0x00000018,
    dispid_KSCat                           = 0x00000019,
    dispid_CLSID                           = 0x0000001a,
    dispidTune                             = 0x0000001b,
    dispidTS                               = 0x0000001c,
    dispidDevSAP                           = 0x0000001d,
    dispidClip                             = 0x0000001e,
    dispidRequestedClipRect                = 0x0000001f,
    dispidClippedSourceRect                = 0x00000020,
    dispidAvailableSourceRect              = 0x00000021,
    dispidMediaPosition                    = 0x00000022,
    dispidDevRun                           = 0x00000023,
    dispidDevPause                         = 0x00000024,
    dispidDevStop                          = 0x00000025,
    dispidCCEnable                         = 0x00000026,
    dispidDevStep                          = 0x00000027,
    dispidDevCanStep                       = 0x00000028,
    dispidSourceSize                       = 0x00000029,
    dispid_playtitle                       = 0x0000002a,
    dispid_playchapterintitle              = 0x0000002b,
    dispid_playchapter                     = 0x0000002c,
    dispid_playchaptersautostop            = 0x0000002d,
    dispid_playattime                      = 0x0000002e,
    dispid_playattimeintitle               = 0x0000002f,
    dispid_playperiodintitleautostop       = 0x00000030,
    dispid_replaychapter                   = 0x00000031,
    dispid_playprevchapter                 = 0x00000032,
    dispid_playnextchapter                 = 0x00000033,
    dispid_playforwards                    = 0x00000034,
    dispid_playbackwards                   = 0x00000035,
    dispid_stilloff                        = 0x00000036,
    dispid_audiolanguage                   = 0x00000037,
    dispid_showmenu                        = 0x00000038,
    dispid_resume                          = 0x00000039,
    dispid_returnfromsubmenu               = 0x0000003a,
    dispid_buttonsavailable                = 0x0000003b,
    dispid_currentbutton                   = 0x0000003c,
    dispid_SelectAndActivateButton         = 0x0000003d,
    dispid_ActivateButton                  = 0x0000003e,
    dispid_SelectRightButton               = 0x0000003f,
    dispid_SelectLeftButton                = 0x00000040,
    dispid_SelectLowerButton               = 0x00000041,
    dispid_SelectUpperButton               = 0x00000042,
    dispid_ActivateAtPosition              = 0x00000043,
    dispid_SelectAtPosition                = 0x00000044,
    dispid_ButtonAtPosition                = 0x00000045,
    dispid_NumberOfChapters                = 0x00000046,
    dispid_TotalTitleTime                  = 0x00000047,
    dispid_TitlesAvailable                 = 0x00000048,
    dispid_VolumesAvailable                = 0x00000049,
    dispid_CurrentVolume                   = 0x0000004a,
    dispid_CurrentDiscSide                 = 0x0000004b,
    dispid_CurrentDomain                   = 0x0000004c,
    dispid_CurrentChapter                  = 0x0000004d,
    dispid_CurrentTitle                    = 0x0000004e,
    dispid_CurrentTime                     = 0x0000004f,
    dispid_FramesPerSecond                 = 0x00000050,
    dispid_DVDTimeCode2bstr                = 0x00000051,
    dispid_DVDDirectory                    = 0x00000052,
    dispid_IsSubpictureStreamEnabled       = 0x00000053,
    dispid_IsAudioStreamEnabled            = 0x00000054,
    dispid_CurrentSubpictureStream         = 0x00000055,
    dispid_SubpictureLanguage              = 0x00000056,
    dispid_CurrentAudioStream              = 0x00000057,
    dispid_AudioStreamsAvailable           = 0x00000058,
    dispid_AnglesAvailable                 = 0x00000059,
    dispid_CurrentAngle                    = 0x0000005a,
    dispid_CCActive                        = 0x0000005b,
    dispid_CurrentCCService                = 0x0000005c,
    dispid_SubpictureStreamsAvailable      = 0x0000005d,
    dispid_SubpictureOn                    = 0x0000005e,
    dispid_DVDUniqueID                     = 0x0000005f,
    dispid_EnableResetOnStop               = 0x00000060,
    dispid_AcceptParentalLevelChange       = 0x00000061,
    dispid_NotifyParentalLevelChange       = 0x00000062,
    dispid_SelectParentalCountry           = 0x00000063,
    dispid_SelectParentalLevel             = 0x00000064,
    dispid_TitleParentalLevels             = 0x00000065,
    dispid_PlayerParentalCountry           = 0x00000066,
    dispid_PlayerParentalLevel             = 0x00000067,
    dispid_Eject                           = 0x00000068,
    dispid_UOPValid                        = 0x00000069,
    dispid_SPRM                            = 0x0000006a,
    dispid_GPRM                            = 0x0000006b,
    dispid_DVDTextStringType               = 0x0000006c,
    dispid_DVDTextString                   = 0x0000006d,
    dispid_DVDTextNumberOfStrings          = 0x0000006e,
    dispid_DVDTextNumberOfLanguages        = 0x0000006f,
    dispid_DVDTextLanguageLCID             = 0x00000070,
    dispid_RegionChange                    = 0x00000071,
    dispid_DVDAdm                          = 0x00000072,
    dispid_DeleteBookmark                  = 0x00000073,
    dispid_RestoreBookmark                 = 0x00000074,
    dispid_SaveBookmark                    = 0x00000075,
    dispid_SelectDefaultAudioLanguage      = 0x00000076,
    dispid_SelectDefaultSubpictureLanguage = 0x00000077,
    dispid_PreferredSubpictureStream       = 0x00000078,
    dispid_DefaultMenuLanguage             = 0x00000079,
    dispid_DefaultSubpictureLanguage       = 0x0000007a,
    dispid_DefaultAudioLanguage            = 0x0000007b,
    dispid_DefaultSubpictureLanguageExt    = 0x0000007c,
    dispid_DefaultAudioLanguageExt         = 0x0000007d,
    dispid_LanguageFromLCID                = 0x0000007e,
    dispid_KaraokeAudioPresentationMode    = 0x0000007f,
    dispid_KaraokeChannelContent           = 0x00000080,
    dispid_KaraokeChannelAssignment        = 0x00000081,
    dispid_RestorePreferredSettings        = 0x00000082,
    dispid_ButtonRect                      = 0x00000083,
    dispid_DVDScreenInMouseCoordinates     = 0x00000084,
    dispid_CustomCompositorClass           = 0x00000085,
    dispidCustomCompositorClass            = 0x00000086,
    dispid_CustomCompositor                = 0x00000087,
    dispidMixerBitmap                      = 0x00000088,
    dispid_MixerBitmap                     = 0x00000089,
    dispidMixerBitmapOpacity               = 0x0000008a,
    dispidMixerBitmapRect                  = 0x0000008b,
    dispidSetupMixerBitmap                 = 0x0000008c,
    dispidUsingOverlay                     = 0x0000008d,
    dispidDisplayChange                    = 0x0000008e,
    dispidRePaint                          = 0x0000008f,
    dispid_IsEqualDevice                   = 0x00000090,
    dispidrate                             = 0x00000091,
    dispidposition                         = 0x00000092,
    dispidpositionmode                     = 0x00000093,
    dispidlength                           = 0x00000094,
    dispidChangePassword                   = 0x00000095,
    dispidSaveParentalLevel                = 0x00000096,
    dispidSaveParentalCountry              = 0x00000097,
    dispidConfirmPassword                  = 0x00000098,
    dispidGetParentalLevel                 = 0x00000099,
    dispidGetParentalCountry               = 0x0000009a,
    dispidDefaultAudioLCID                 = 0x0000009b,
    dispidDefaultSubpictureLCID            = 0x0000009c,
    dispidDefaultMenuLCID                  = 0x0000009d,
    dispidBookmarkOnStop                   = 0x0000009e,
    dispidMaxVidRect                       = 0x0000009f,
    dispidMinVidRect                       = 0x000000a0,
    dispidCapture                          = 0x000000a1,
    dispid_DecimateInput                   = 0x000000a2,
    dispidAlloctor                         = 0x000000a3,
    dispid_Allocator                       = 0x000000a4,
    dispidAllocPresentID                   = 0x000000a5,
    dispidSetAllocator                     = 0x000000a6,
    dispid_SetAllocator                    = 0x000000a7,
    dispidStreamBufferSinkName             = 0x000000a8,
    dispidStreamBufferSourceName           = 0x000000a9,
    dispidStreamBufferContentRecording     = 0x000000aa,
    dispidStreamBufferReferenceRecording   = 0x000000ab,
    dispidstarttime                        = 0x000000ac,
    dispidstoptime                         = 0x000000ad,
    dispidrecordingstopped                 = 0x000000ae,
    dispidrecordingstarted                 = 0x000000af,
    dispidNameSetLock                      = 0x000000b0,
    dispidrecordingtype                    = 0x000000b1,
    dispidstart                            = 0x000000b2,
    dispidRecordingAttribute               = 0x000000b3,
    dispid_RecordingAttribute              = 0x000000b4,
    dispidSBEConfigure                     = 0x000000b5,
    dispid_CurrentRatings                  = 0x000000b6,
    dispid_MaxRatingsLevel                 = 0x000000b7,
    dispid_audioencoderint                 = 0x000000b8,
    dispid_videoencoderint                 = 0x000000b9,
    dispidService                          = 0x000000ba,
    dispid_BlockUnrated                    = 0x000000bb,
    dispid_UnratedDelay                    = 0x000000bc,
    dispid_SuppressEffects                 = 0x000000bd,
    dispidsbesource                        = 0x000000be,
    dispidSetSinkFilter                    = 0x000000bf,
    dispid_SinkStreams                     = 0x000000c0,
    dispidTVFormats                        = 0x000000c1,
    dispidModes                            = 0x000000c2,
    dispidAuxInputs                        = 0x000000c3,
    dispidTeleTextFilter                   = 0x000000c4,
    dispid_channelchangeint                = 0x000000c5,
    dispidUnlockProfile                    = 0x000000c6,
    dispid_AddFilter                       = 0x000000c7,
    dispidSetMinSeek                       = 0x000000c8,
    dispidRateEx                           = 0x000000c9,
    dispidaudiocounter                     = 0x000000ca,
    dispidvideocounter                     = 0x000000cb,
    dispidcccounter                        = 0x000000cc,
    dispidwstcounter                       = 0x000000cd,
    dispid_audiocounter                    = 0x000000ce,
    dispid_videocounter                    = 0x000000cf,
    dispid_cccounter                       = 0x000000d0,
    dispid_wstcounter                      = 0x000000d1,
    dispidaudioanalysis                    = 0x000000d2,
    dispidvideoanalysis                    = 0x000000d3,
    dispiddataanalysis                     = 0x000000d4,
    dispidaudio_analysis                   = 0x000000d5,
    dispidvideo_analysis                   = 0x000000d6,
    dispiddata_analysis                    = 0x000000d7,
    dispid_resetFilterList                 = 0x000000d8,
    dispidDevicePath                       = 0x000000d9,
    dispid_SourceFilter                    = 0x000000da,
    dispid__SourceFilter                   = 0x000000db,
    dispidUserEvent                        = 0x000000dc,
    dispid_Bookmark                        = 0x000000dd,
    LastReservedDeviceDispid               = 0x00003fff,
}

enum SegEventidList : int
{
    eventidStateChange                   = 0x00000000,
    eventidOnTuneChanged                 = 0x00000001,
    eventidEndOfMedia                    = 0x00000002,
    eventidDVDNotify                     = 0x00000003,
    eventidPlayForwards                  = 0x00000004,
    eventidPlayBackwards                 = 0x00000005,
    eventidShowMenu                      = 0x00000006,
    eventidResume                        = 0x00000007,
    eventidSelectOrActivateButton        = 0x00000008,
    eventidStillOff                      = 0x00000009,
    eventidPauseOn                       = 0x0000000a,
    eventidChangeCurrentAudioStream      = 0x0000000b,
    eventidChangeCurrentSubpictureStream = 0x0000000c,
    eventidChangeCurrentAngle            = 0x0000000d,
    eventidPlayAtTimeInTitle             = 0x0000000e,
    eventidPlayAtTime                    = 0x0000000f,
    eventidPlayChapterInTitle            = 0x00000010,
    eventidPlayChapter                   = 0x00000011,
    eventidReplayChapter                 = 0x00000012,
    eventidPlayNextChapter               = 0x00000013,
    eventidStop                          = 0x00000014,
    eventidReturnFromSubmenu             = 0x00000015,
    eventidPlayTitle                     = 0x00000016,
    eventidPlayPrevChapter               = 0x00000017,
    eventidChangeKaraokePresMode         = 0x00000018,
    eventidChangeVideoPresMode           = 0x00000019,
    eventidOverlayUnavailable            = 0x0000001a,
    eventidSinkCertificateFailure        = 0x0000001b,
    eventidSinkCertificateSuccess        = 0x0000001c,
    eventidSourceCertificateFailure      = 0x0000001d,
    eventidSourceCertificateSuccess      = 0x0000001e,
    eventidRatingsBlocked                = 0x0000001f,
    eventidRatingsUnlocked               = 0x00000020,
    eventidRatingsChanged                = 0x00000021,
    eventidWriteFailure                  = 0x00000022,
    eventidTimeHole                      = 0x00000023,
    eventidStaleDataRead                 = 0x00000024,
    eventidContentBecomingStale          = 0x00000025,
    eventidStaleFileDeleted              = 0x00000026,
    eventidEncryptionOn                  = 0x00000027,
    eventidEncryptionOff                 = 0x00000028,
    eventidRateChange                    = 0x00000029,
    eventidLicenseChange                 = 0x0000002a,
    eventidCOPPBlocked                   = 0x0000002b,
    eventidCOPPUnblocked                 = 0x0000002c,
    dispidlicenseerrorcode               = 0x0000002d,
    eventidBroadcastEvent                = 0x0000002e,
    eventidBroadcastEventEx              = 0x0000002f,
    eventidContentPrimarilyAudio         = 0x00000030,
    dispidAVDecAudioDualMonoEvent        = 0x00000031,
    dispidAVAudioSampleRateEvent         = 0x00000032,
    dispidAVAudioChannelConfigEvent      = 0x00000033,
    dispidAVAudioChannelCountEvent       = 0x00000034,
    dispidAVDecCommonMeanBitRateEvent    = 0x00000035,
    dispidAVDDSurroundModeEvent          = 0x00000036,
    dispidAVDecCommonInputFormatEvent    = 0x00000037,
    dispidAVDecCommonOutputFormatEvent   = 0x00000038,
    eventidWriteFailureClear             = 0x00000039,
    LastReservedDeviceEvent              = 0x00003fff,
}

enum PositionModeList : int
{
    FrameMode         = 0x00000000,
    TenthsSecondsMode = 0x00000001,
}

enum RecordingType : int
{
    CONTENT   = 0x00000000,
    REFERENCE = 0x00000001,
}

enum MSVidCCService : int
{
    None     = 0x00000000,
    Caption1 = 0x00000001,
    Caption2 = 0x00000002,
    Text1    = 0x00000003,
    Text2    = 0x00000004,
    XDS      = 0x00000005,
}

enum MSVidSinkStreams : int
{
    MSVidSink_Video = 0x00000001,
    MSVidSink_Audio = 0x00000002,
    MSVidSink_Other = 0x00000004,
}

enum MSVidSegmentType : int
{
    MSVidSEG_SOURCE = 0x00000000,
    MSVidSEG_XFORM  = 0x00000001,
    MSVidSEG_DEST   = 0x00000002,
}

enum MSVidCtlButtonstate : int
{
    MSVIDCTL_LEFT_BUTTON   = 0x00000001,
    MSVIDCTL_RIGHT_BUTTON  = 0x00000002,
    MSVIDCTL_MIDDLE_BUTTON = 0x00000004,
    MSVIDCTL_X_BUTTON1     = 0x00000008,
    MSVIDCTL_X_BUTTON2     = 0x00000010,
    MSVIDCTL_SHIFT         = 0x00000001,
    MSVIDCTL_CTRL          = 0x00000002,
    MSVIDCTL_ALT           = 0x00000004,
}

enum DVDMenuIDConstants : int
{
    dvdMenu_Title      = 0x00000002,
    dvdMenu_Root       = 0x00000003,
    dvdMenu_Subpicture = 0x00000004,
    dvdMenu_Audio      = 0x00000005,
    dvdMenu_Angle      = 0x00000006,
    dvdMenu_Chapter    = 0x00000007,
}

enum DVDFilterState : int
{
    dvdState_Undefined   = 0xfffffffe,
    dvdState_Unitialized = 0xffffffff,
    dvdState_Stopped     = 0x00000000,
    dvdState_Paused      = 0x00000001,
    dvdState_Running     = 0x00000002,
}

enum DVDTextStringType : int
{
    dvdStruct_Volume      = 0x00000001,
    dvdStruct_Title       = 0x00000002,
    dvdStruct_ParentalID  = 0x00000003,
    dvdStruct_PartOfTitle = 0x00000004,
    dvdStruct_Cell        = 0x00000005,
    dvdStream_Audio       = 0x00000010,
    dvdStream_Subpicture  = 0x00000011,
    dvdStream_Angle       = 0x00000012,
    dvdChannel_Audio      = 0x00000020,
    dvdGeneral_Name       = 0x00000030,
    dvdGeneral_Comments   = 0x00000031,
    dvdTitle_Series       = 0x00000038,
    dvdTitle_Movie        = 0x00000039,
    dvdTitle_Video        = 0x0000003a,
    dvdTitle_Album        = 0x0000003b,
    dvdTitle_Song         = 0x0000003c,
    dvdTitle_Other        = 0x0000003f,
    dvdTitle_Sub_Series   = 0x00000040,
    dvdTitle_Sub_Movie    = 0x00000041,
    dvdTitle_Sub_Video    = 0x00000042,
    dvdTitle_Sub_Album    = 0x00000043,
    dvdTitle_Sub_Song     = 0x00000044,
    dvdTitle_Sub_Other    = 0x00000047,
    dvdTitle_Orig_Series  = 0x00000048,
    dvdTitle_Orig_Movie   = 0x00000049,
    dvdTitle_Orig_Video   = 0x0000004a,
    dvdTitle_Orig_Album   = 0x0000004b,
    dvdTitle_Orig_Song    = 0x0000004c,
    dvdTitle_Orig_Other   = 0x0000004f,
    dvdOther_Scene        = 0x00000050,
    dvdOther_Cut          = 0x00000051,
    dvdOther_Take         = 0x00000052,
}

enum : int
{
    dvdSPExt_NotSpecified              = 0x00000000,
    dvdSPExt_Caption_Normal            = 0x00000001,
    dvdSPExt_Caption_Big               = 0x00000002,
    dvdSPExt_Caption_Children          = 0x00000003,
    dvdSPExt_CC_Normal                 = 0x00000005,
    dvdSPExt_CC_Big                    = 0x00000006,
    dvdSPExt_CC_Children               = 0x00000007,
    dvdSPExt_Forced                    = 0x00000009,
    dvdSPExt_DirectorComments_Normal   = 0x0000000d,
    dvdSPExt_DirectorComments_Big      = 0x0000000e,
    dvdSPExt_DirectorComments_Children = 0x0000000f,
}
alias DVDSPExt = int;

enum SourceSizeList : int
{
    sslFullSize       = 0x00000000,
    sslClipByOverScan = 0x00000001,
    sslClipByClipRect = 0x00000002,
}

enum MSViddispidList : int
{
    dispidInputs              = 0x00000000,
    dispidOutputs             = 0x00000001,
    dispid_Inputs             = 0x00000002,
    dispid_Outputs            = 0x00000003,
    dispidVideoRenderers      = 0x00000004,
    dispidAudioRenderers      = 0x00000005,
    dispidFeatures            = 0x00000006,
    dispidInput               = 0x00000007,
    dispidOutput              = 0x00000008,
    dispidVideoRenderer       = 0x00000009,
    dispidAudioRenderer       = 0x0000000a,
    dispidSelectedFeatures    = 0x0000000b,
    dispidView                = 0x0000000c,
    dispidBuild               = 0x0000000d,
    dispidPause               = 0x0000000e,
    dispidRun                 = 0x0000000f,
    dispidStop                = 0x00000010,
    dispidDecompose           = 0x00000011,
    dispidDisplaySize         = 0x00000012,
    dispidMaintainAspectRatio = 0x00000013,
    dispidColorKey            = 0x00000014,
    dispidStateChange         = 0x00000015,
    dispidgetState            = 0x00000016,
    dispidunbind              = 0x00000017,
    dispidbind                = 0x00000018,
    dispidDisableVideo        = 0x00000019,
    dispidDisableAudio        = 0x0000001a,
    dispidViewNext            = 0x0000001b,
    dispidServiceP            = 0x0000001c,
}

enum DisplaySizeList : int
{
    dslDefaultSize      = 0x00000000,
    dslSourceSize       = 0x00000000,
    dslHalfSourceSize   = 0x00000001,
    dslDoubleSourceSize = 0x00000002,
    dslFullScreen       = 0x00000003,
    dslHalfScreen       = 0x00000004,
    dslQuarterScreen    = 0x00000005,
    dslSixteenthScreen  = 0x00000006,
}

enum MSVidCtlStateList : int
{
    STATE_UNBUILT = 0xffffffff,
    STATE_STOP    = 0x00000000,
    STATE_PAUSE   = 0x00000001,
    STATE_PLAY    = 0x00000002,
}

enum : int
{
    RECORDING_TYPE_CONTENT   = 0x00000000,
    RECORDING_TYPE_REFERENCE = 0x00000001,
}
alias __MIDL___MIDL_itf_sbe_0000_0001_0001 = int;

enum : int
{
    STREAMBUFFER_TYPE_DWORD  = 0x00000000,
    STREAMBUFFER_TYPE_STRING = 0x00000001,
    STREAMBUFFER_TYPE_BINARY = 0x00000002,
    STREAMBUFFER_TYPE_BOOL   = 0x00000003,
    STREAMBUFFER_TYPE_QWORD  = 0x00000004,
    STREAMBUFFER_TYPE_WORD   = 0x00000005,
    STREAMBUFFER_TYPE_GUID   = 0x00000006,
}
alias STREAMBUFFER_ATTR_DATATYPE = int;

enum : int
{
    DEF_MODE_PROFILE = 0x00000001,
    DEF_MODE_STREAMS = 0x00000002,
}
alias CROSSBAR_DEFAULT_FLAGS = int;

enum : int
{
    MPEG_SECTION_IS_NEXT    = 0x00000000,
    MPEG_SECTION_IS_CURRENT = 0x00000001,
}
alias MPEG_CURRENT_NEXT_BIT = int;

enum : int
{
    MPEG_CONTEXT_BCS_DEMUX = 0x00000000,
    MPEG_CONTEXT_WINSOCK   = 0x00000001,
}
alias MPEG_CONTEXT_TYPE = int;

enum : int
{
    MPEG_RQST_UNKNOWN             = 0x00000000,
    MPEG_RQST_GET_SECTION         = 0x00000001,
    MPEG_RQST_GET_SECTION_ASYNC   = 0x00000002,
    MPEG_RQST_GET_TABLE           = 0x00000003,
    MPEG_RQST_GET_TABLE_ASYNC     = 0x00000004,
    MPEG_RQST_GET_SECTIONS_STREAM = 0x00000005,
    MPEG_RQST_GET_PES_STREAM      = 0x00000006,
    MPEG_RQST_GET_TS_STREAM       = 0x00000007,
    MPEG_RQST_START_MPE_STREAM    = 0x00000008,
}
alias MPEG_REQUEST_TYPE = int;

enum : int
{
    VA_VIDEO_COMPONENT   = 0x00000000,
    VA_VIDEO_PAL         = 0x00000001,
    VA_VIDEO_NTSC        = 0x00000002,
    VA_VIDEO_SECAM       = 0x00000003,
    VA_VIDEO_MAC         = 0x00000004,
    VA_VIDEO_UNSPECIFIED = 0x00000005,
}
alias VA_VIDEO_FORMAT = int;

enum : int
{
    VA_PRIMARIES_ITU_R_BT_709            = 0x00000001,
    VA_PRIMARIES_UNSPECIFIED             = 0x00000002,
    VA_PRIMARIES_ITU_R_BT_470_SYSTEM_M   = 0x00000004,
    VA_PRIMARIES_ITU_R_BT_470_SYSTEM_B_G = 0x00000005,
    VA_PRIMARIES_SMPTE_170M              = 0x00000006,
    VA_PRIMARIES_SMPTE_240M              = 0x00000007,
    VA_PRIMARIES_H264_GENERIC_FILM       = 0x00000008,
}
alias VA_COLOR_PRIMARIES = int;

enum : int
{
    VA_TRANSFER_CHARACTERISTICS_ITU_R_BT_709            = 0x00000001,
    VA_TRANSFER_CHARACTERISTICS_UNSPECIFIED             = 0x00000002,
    VA_TRANSFER_CHARACTERISTICS_ITU_R_BT_470_SYSTEM_M   = 0x00000004,
    VA_TRANSFER_CHARACTERISTICS_ITU_R_BT_470_SYSTEM_B_G = 0x00000005,
    VA_TRANSFER_CHARACTERISTICS_SMPTE_170M              = 0x00000006,
    VA_TRANSFER_CHARACTERISTICS_SMPTE_240M              = 0x00000007,
    VA_TRANSFER_CHARACTERISTICS_LINEAR                  = 0x00000008,
    VA_TRANSFER_CHARACTERISTICS_H264_LOG_100_TO_1       = 0x00000009,
    VA_TRANSFER_CHARACTERISTICS_H264_LOG_316_TO_1       = 0x0000000a,
}
alias VA_TRANSFER_CHARACTERISTICS = int;

enum : int
{
    VA_MATRIX_COEFF_H264_RGB                = 0x00000000,
    VA_MATRIX_COEFF_ITU_R_BT_709            = 0x00000001,
    VA_MATRIX_COEFF_UNSPECIFIED             = 0x00000002,
    VA_MATRIX_COEFF_FCC                     = 0x00000004,
    VA_MATRIX_COEFF_ITU_R_BT_470_SYSTEM_B_G = 0x00000005,
    VA_MATRIX_COEFF_SMPTE_170M              = 0x00000006,
    VA_MATRIX_COEFF_SMPTE_240M              = 0x00000007,
    VA_MATRIX_COEFF_H264_YCgCo              = 0x00000008,
}
alias VA_MATRIX_COEFFICIENTS = int;

enum : int
{
    STRCONV_MODE_DVB                  = 0x00000000,
    STRCONV_MODE_DVB_EMPHASIS         = 0x00000001,
    STRCONV_MODE_DVB_WITHOUT_EMPHASIS = 0x00000002,
    STRCONV_MODE_ISDB                 = 0x00000003,
}
alias __MIDL___MIDL_itf_dvbsiparser_0000_0000_0001 = int;

enum : int
{
    CRID_LOCATION_IN_DESCRIPTOR = 0x00000000,
    CRID_LOCATION_IN_CIT        = 0x00000001,
    CRID_LOCATION_DVB_RESERVED1 = 0x00000002,
    CRID_LOCATION_DVB_RESERVED2 = 0x00000003,
}
alias __MIDL___MIDL_itf_dvbsiparser_0000_0022_0001 = int;

enum : int
{
    DESC_LINKAGE_RESERVED0               = 0x00000000,
    DESC_LINKAGE_INFORMATION             = 0x00000001,
    DESC_LINKAGE_EPG                     = 0x00000002,
    DESC_LINKAGE_CA_REPLACEMENT          = 0x00000003,
    DESC_LINKAGE_COMPLETE_NET_BOUQUET_SI = 0x00000004,
    DESC_LINKAGE_REPLACEMENT             = 0x00000005,
    DESC_LINKAGE_DATA                    = 0x00000006,
    DESC_LINKAGE_RESERVED1               = 0x00000007,
    DESC_LINKAGE_USER                    = 0x00000008,
    DESC_LINKAGE_RESERVED2               = 0x000000ff,
}
alias __MIDL___MIDL_itf_dvbsiparser_0000_0036_0001 = int;

enum : int
{
    ChannelChangeSpanningEvent_Start = 0x00000000,
    ChannelChangeSpanningEvent_End   = 0x00000002,
}
alias ChannelChangeSpanningEvent_State = int;

enum ChannelType : int
{
    ChannelTypeNone        = 0x00000000,
    ChannelTypeOther       = 0x00000001,
    ChannelTypeVideo       = 0x00000002,
    ChannelTypeAudio       = 0x00000004,
    ChannelTypeText        = 0x00000008,
    ChannelTypeSubtitles   = 0x00000010,
    ChannelTypeCaptions    = 0x00000020,
    ChannelTypeSuperimpose = 0x00000040,
    ChannelTypeData        = 0x00000080,
}

enum : int
{
    SignalAndServiceStatusSpanningEvent_None           = 0xffffffff,
    SignalAndServiceStatusSpanningEvent_Clear          = 0x00000000,
    SignalAndServiceStatusSpanningEvent_NoTVSignal     = 0x00000001,
    SignalAndServiceStatusSpanningEvent_ServiceOffAir  = 0x00000002,
    SignalAndServiceStatusSpanningEvent_WeakTVSignal   = 0x00000003,
    SignalAndServiceStatusSpanningEvent_NoSubscription = 0x00000004,
    SignalAndServiceStatusSpanningEvent_AllAVScrambled = 0x00000005,
}
alias SignalAndServiceStatusSpanningEvent_State = int;

enum : int
{
    KSPROPERTY_BDA_ETHERNET_FILTER_MULTICAST_LIST_SIZE = 0x00000000,
    KSPROPERTY_BDA_ETHERNET_FILTER_MULTICAST_LIST      = 0x00000001,
    KSPROPERTY_BDA_ETHERNET_FILTER_MULTICAST_MODE      = 0x00000002,
}
alias KSPROPERTY_BDA_ETHERNET_FILTER = int;

enum : int
{
    KSPROPERTY_BDA_IPv4_FILTER_MULTICAST_LIST_SIZE = 0x00000000,
    KSPROPERTY_BDA_IPv4_FILTER_MULTICAST_LIST      = 0x00000001,
    KSPROPERTY_BDA_IPv4_FILTER_MULTICAST_MODE      = 0x00000002,
}
alias KSPROPERTY_BDA_IPv4_FILTER = int;

enum : int
{
    KSPROPERTY_BDA_IPv6_FILTER_MULTICAST_LIST_SIZE = 0x00000000,
    KSPROPERTY_BDA_IPv6_FILTER_MULTICAST_LIST      = 0x00000001,
    KSPROPERTY_BDA_IPv6_FILTER_MULTICAST_MODE      = 0x00000002,
}
alias KSPROPERTY_BDA_IPv6_FILTER = int;

enum : int
{
    KSPROPERTY_BDA_SIGNAL_STRENGTH  = 0x00000000,
    KSPROPERTY_BDA_SIGNAL_QUALITY   = 0x00000001,
    KSPROPERTY_BDA_SIGNAL_PRESENT   = 0x00000002,
    KSPROPERTY_BDA_SIGNAL_LOCKED    = 0x00000003,
    KSPROPERTY_BDA_SAMPLE_TIME      = 0x00000004,
    KSPROPERTY_BDA_SIGNAL_LOCK_CAPS = 0x00000005,
    KSPROPERTY_BDA_SIGNAL_LOCK_TYPE = 0x00000006,
}
alias KSPROPERTY_BDA_SIGNAL_STATS = int;

enum : int
{
    Bda_LockType_None         = 0x00000000,
    Bda_LockType_PLL          = 0x00000001,
    Bda_LockType_DecoderDemod = 0x00000002,
    Bda_LockType_Complete     = 0x00000080,
}
alias _BdaLockType = int;

enum : int
{
    KSMETHOD_BDA_START_CHANGES    = 0x00000000,
    KSMETHOD_BDA_CHECK_CHANGES    = 0x00000001,
    KSMETHOD_BDA_COMMIT_CHANGES   = 0x00000002,
    KSMETHOD_BDA_GET_CHANGE_STATE = 0x00000003,
}
alias KSMETHOD_BDA_CHANGE_SYNC = int;

enum : int
{
    KSMETHOD_BDA_CREATE_PIN_FACTORY = 0x00000000,
    KSMETHOD_BDA_DELETE_PIN_FACTORY = 0x00000001,
    KSMETHOD_BDA_CREATE_TOPOLOGY    = 0x00000002,
}
alias KSMETHOD_BDA_DEVICE_CONFIGURATION = int;

enum : int
{
    KSPROPERTY_BDA_NODE_TYPES           = 0x00000000,
    KSPROPERTY_BDA_PIN_TYPES            = 0x00000001,
    KSPROPERTY_BDA_TEMPLATE_CONNECTIONS = 0x00000002,
    KSPROPERTY_BDA_NODE_METHODS         = 0x00000003,
    KSPROPERTY_BDA_NODE_PROPERTIES      = 0x00000004,
    KSPROPERTY_BDA_NODE_EVENTS          = 0x00000005,
    KSPROPERTY_BDA_CONTROLLING_PIN_ID   = 0x00000006,
    KSPROPERTY_BDA_NODE_DESCRIPTORS     = 0x00000007,
}
alias KSPROPERTY_BDA_TOPOLOGY = int;

enum : int
{
    KSPROPERTY_BDA_PIN_ID   = 0x00000000,
    KSPROPERTY_BDA_PIN_TYPE = 0x00000001,
}
alias KSPROPERTY_BDA_PIN_CONTROL = int;

enum : int
{
    KSEVENT_BDA_PIN_CONNECTED    = 0x00000000,
    KSEVENT_BDA_PIN_DISCONNECTED = 0x00000001,
}
alias KSPROPERTY_BDA_PIN_EVENT = int;

enum : int
{
    KSPROPERTY_BDA_VOID_TRANSFORM_START = 0x00000000,
    KSPROPERTY_BDA_VOID_TRANSFORM_STOP  = 0x00000001,
}
alias KSPROPERTY_BDA_VOID_TRANSFORM = int;

enum : int
{
    KSPROPERTY_BDA_NULL_TRANSFORM_START = 0x00000000,
    KSPROPERTY_BDA_NULL_TRANSFORM_STOP  = 0x00000001,
}
alias KSPROPERTY_BDA_NULL_TRANSFORM = int;

enum : int
{
    KSPROPERTY_BDA_RF_TUNER_FREQUENCY            = 0x00000000,
    KSPROPERTY_BDA_RF_TUNER_POLARITY             = 0x00000001,
    KSPROPERTY_BDA_RF_TUNER_RANGE                = 0x00000002,
    KSPROPERTY_BDA_RF_TUNER_TRANSPONDER          = 0x00000003,
    KSPROPERTY_BDA_RF_TUNER_BANDWIDTH            = 0x00000004,
    KSPROPERTY_BDA_RF_TUNER_FREQUENCY_MULTIPLIER = 0x00000005,
    KSPROPERTY_BDA_RF_TUNER_CAPS                 = 0x00000006,
    KSPROPERTY_BDA_RF_TUNER_SCAN_STATUS          = 0x00000007,
    KSPROPERTY_BDA_RF_TUNER_STANDARD             = 0x00000008,
    KSPROPERTY_BDA_RF_TUNER_STANDARD_MODE        = 0x00000009,
}
alias KSPROPERTY_BDA_FREQUENCY_FILTER = int;

enum : int
{
    Bda_SignalType_Unknown = 0x00000000,
    Bda_SignalType_Analog  = 0x00000001,
    Bda_SignalType_Digital = 0x00000002,
}
alias _BdaSignalType = int;

enum : int
{
    Bda_DigitalStandard_None   = 0x00000000,
    Bda_DigitalStandard_DVB_T  = 0x00000001,
    Bda_DigitalStandard_DVB_S  = 0x00000002,
    Bda_DigitalStandard_DVB_C  = 0x00000004,
    Bda_DigitalStandard_ATSC   = 0x00000008,
    Bda_DigitalStandard_ISDB_T = 0x00000010,
    Bda_DigitalStandard_ISDB_S = 0x00000020,
    Bda_DigitalStandard_ISDB_C = 0x00000040,
}
alias BDA_DigitalSignalStandard = int;

enum : int
{
    KSEVENT_BDA_TUNER_SCAN = 0x00000000,
}
alias KSEVENT_BDA_TUNER = int;

enum : int
{
    KSPROPERTY_BDA_LNB_LOF_LOW_BAND     = 0x00000000,
    KSPROPERTY_BDA_LNB_LOF_HIGH_BAND    = 0x00000001,
    KSPROPERTY_BDA_LNB_SWITCH_FREQUENCY = 0x00000002,
}
alias KSPROPERTY_BDA_LNB_INFO = int;

enum : int
{
    KSPROPERTY_BDA_DISEQC_ENABLE       = 0x00000000,
    KSPROPERTY_BDA_DISEQC_LNB_SOURCE   = 0x00000001,
    KSPROPERTY_BDA_DISEQC_USETONEBURST = 0x00000002,
    KSPROPERTY_BDA_DISEQC_REPEATS      = 0x00000003,
    KSPROPERTY_BDA_DISEQC_SEND         = 0x00000004,
    KSPROPERTY_BDA_DISEQC_RESPONSE     = 0x00000005,
}
alias KSPROPERTY_BDA_DISEQC_COMMAND = int;

enum : int
{
    KSEVENT_BDA_DISEQC_DATA_RECEIVED = 0x00000000,
}
alias KSPROPERTY_BDA_DISEQC_EVENT = int;

enum : int
{
    KSPROPERTY_BDA_MODULATION_TYPE    = 0x00000000,
    KSPROPERTY_BDA_INNER_FEC_TYPE     = 0x00000001,
    KSPROPERTY_BDA_INNER_FEC_RATE     = 0x00000002,
    KSPROPERTY_BDA_OUTER_FEC_TYPE     = 0x00000003,
    KSPROPERTY_BDA_OUTER_FEC_RATE     = 0x00000004,
    KSPROPERTY_BDA_SYMBOL_RATE        = 0x00000005,
    KSPROPERTY_BDA_SPECTRAL_INVERSION = 0x00000006,
    KSPROPERTY_BDA_GUARD_INTERVAL     = 0x00000007,
    KSPROPERTY_BDA_TRANSMISSION_MODE  = 0x00000008,
    KSPROPERTY_BDA_ROLL_OFF           = 0x00000009,
    KSPROPERTY_BDA_PILOT              = 0x0000000a,
    KSPROPERTY_BDA_SIGNALTIMEOUTS     = 0x0000000b,
    KSPROPERTY_BDA_PLP_NUMBER         = 0x0000000c,
}
alias KSPROPERTY_BDA_DIGITAL_DEMODULATOR = int;

enum : int
{
    KSPROPERTY_BDA_AUTODEMODULATE_START = 0x00000000,
    KSPROPERTY_BDA_AUTODEMODULATE_STOP  = 0x00000001,
}
alias KSPROPERTY_BDA_AUTODEMODULATE = int;

enum : int
{
    KSPROPERTY_BDA_TABLE_SECTION = 0x00000000,
}
alias KSPROPERTY_IDS_BDA_TABLE = int;

enum : int
{
    KSPROPERTY_BDA_PIDFILTER_MAP_PIDS   = 0x00000000,
    KSPROPERTY_BDA_PIDFILTER_UNMAP_PIDS = 0x00000001,
    KSPROPERTY_BDA_PIDFILTER_LIST_PIDS  = 0x00000002,
}
alias KSPROPERTY_BDA_PIDFILTER = int;

enum : int
{
    KSPROPERTY_BDA_ECM_MAP_STATUS       = 0x00000000,
    KSPROPERTY_BDA_CA_MODULE_STATUS     = 0x00000001,
    KSPROPERTY_BDA_CA_SMART_CARD_STATUS = 0x00000002,
    KSPROPERTY_BDA_CA_MODULE_UI         = 0x00000003,
    KSPROPERTY_BDA_CA_SET_PROGRAM_PIDS  = 0x00000004,
    KSPROPERTY_BDA_CA_REMOVE_PROGRAM    = 0x00000005,
}
alias KSPROPERTY_BDA_CA = int;

enum : int
{
    KSEVENT_BDA_PROGRAM_FLOW_STATUS_CHANGED  = 0x00000000,
    KSEVENT_BDA_CA_MODULE_STATUS_CHANGED     = 0x00000001,
    KSEVENT_BDA_CA_SMART_CARD_STATUS_CHANGED = 0x00000002,
    KSEVENT_BDA_CA_MODULE_UI_REQUESTED       = 0x00000003,
}
alias KSPROPERTY_BDA_CA_EVENT = int;

enum : int
{
    KSMETHOD_BDA_DRM_CURRENT   = 0x00000000,
    KSMETHOD_BDA_DRM_DRMSTATUS = 0x00000001,
}
alias KSMETHOD_BDA_DRM = int;

enum : int
{
    KSMETHOD_BDA_WMDRM_STATUS         = 0x00000000,
    KSMETHOD_BDA_WMDRM_REVINFO        = 0x00000001,
    KSMETHOD_BDA_WMDRM_CRL            = 0x00000002,
    KSMETHOD_BDA_WMDRM_MESSAGE        = 0x00000003,
    KSMETHOD_BDA_WMDRM_REISSUELICENSE = 0x00000004,
    KSMETHOD_BDA_WMDRM_RENEWLICENSE   = 0x00000005,
    KSMETHOD_BDA_WMDRM_LICENSE        = 0x00000006,
    KSMETHOD_BDA_WMDRM_KEYINFO        = 0x00000007,
}
alias KSMETHOD_BDA_WMDRM = int;

enum : int
{
    KSMETHOD_BDA_WMDRMTUNER_CANCELCAPTURETOKEN   = 0x00000000,
    KSMETHOD_BDA_WMDRMTUNER_SETPIDPROTECTION     = 0x00000001,
    KSMETHOD_BDA_WMDRMTUNER_GETPIDPROTECTION     = 0x00000002,
    KSMETHOD_BDA_WMDRMTUNER_SETSYNCVALUE         = 0x00000003,
    KSMETHOD_BDA_WMDRMTUNER_STARTCODEPROFILE     = 0x00000004,
    KSMETHOD_BDA_WMDRMTUNER_PURCHASE_ENTITLEMENT = 0x00000005,
}
alias KSMETHOD_BDA_WMDRM_TUNER = int;

enum : int
{
    KSMETHOD_BDA_EVENT_DATA     = 0x00000000,
    KSMETHOD_BDA_EVENT_COMPLETE = 0x00000001,
}
alias KSMETHOD_BDA_EVENTING_SERVICE = int;

enum : int
{
    KSEVENT_BDA_EVENT_PENDINGEVENT = 0x00000000,
}
alias KSEVENT_BDA_EVENT_TYPE = int;

enum : int
{
    KSMETHOD_BDA_DEBUG_LEVEL = 0x00000000,
    KSMETHOD_BDA_DEBUG_DATA  = 0x00000001,
}
alias KSMETHOD_BDA_DEBUG_SERVICE = int;

enum : int
{
    KSMETHOD_BDA_TUNER_SETTUNER         = 0x00000000,
    KSMETHOD_BDA_TUNER_GETTUNERSTATE    = 0x00000001,
    KSMETHOD_BDA_TUNER_SIGNALNOISERATIO = 0x00000002,
}
alias KSMETHOD_BDA_TUNER_SERVICE = int;

enum : int
{
    KSMETHOD_BDA_GPNV_GETVALUE           = 0x00000000,
    KSMETHOD_BDA_GPNV_SETVALUE           = 0x00000001,
    KSMETHOD_BDA_GPNV_NAMEFROMINDEX      = 0x00000002,
    KSMETHOD_BDA_GPNV_GETVALUEUPDATENAME = 0x00000003,
}
alias KSMETHOD_BDA_GPNV_SERVICE = int;

enum : int
{
    KSMETHOD_BDA_MUX_GETPIDLIST = 0x00000000,
    KSMETHOD_BDA_MUX_SETPIDLIST = 0x00000001,
}
alias KSMETHOD_BDA_MUX_SERVICE = int;

enum : int
{
    KSMETHOD_BDA_SCAN_CAPABILTIES = 0x00000000,
    KSMETHOD_BDA_SCANNING_STATE   = 0x00000001,
    KSMETHOD_BDA_SCAN_FILTER      = 0x00000002,
    KSMETHOD_BDA_SCAN_START       = 0x00000003,
    KSMETHOD_BDA_SCAN_RESUME      = 0x00000004,
    KSMETHOD_BDA_SCAN_STOP        = 0x00000005,
}
alias KSMETHOD_BDA_SCAN_SERVICE = int;

enum : int
{
    KSMETHOD_BDA_GDDS_DATATYPE           = 0x00000000,
    KSMETHOD_BDA_GDDS_DATA               = 0x00000001,
    KSMETHOD_BDA_GDDS_TUNEXMLFROMIDX     = 0x00000002,
    KSMETHOD_BDA_GDDS_GETSERVICES        = 0x00000003,
    KSMETHOD_BDA_GDDS_SERVICEFROMTUNEXML = 0x00000004,
    KSMETHOD_BDA_GDDS_DATAUPDATE         = 0x00000005,
}
alias KSMETHOD_BDA_GDDS_SERVICE = int;

enum : int
{
    KSMETHOD_BDA_CAS_CHECKENTITLEMENTTOKEN = 0x00000000,
    KSMETHOD_BDA_CAS_SETCAPTURETOKEN       = 0x00000001,
    KSMETHOD_BDA_CAS_OPENBROADCASTMMI      = 0x00000002,
    KSMETHOD_BDA_CAS_CLOSEMMIDIALOG        = 0x00000003,
}
alias KSMETHOD_BDA_CAS_SERVICE = int;

enum : int
{
    KSMETHOD_BDA_ISDBCAS_SETREQUEST   = 0x00000000,
    KSMETHOD_BDA_ISDBCAS_RESPONSEDATA = 0x00000001,
}
alias KSMETHOD_BDA_ISDB_CAS = int;

enum : int
{
    KSMETHOD_BDA_TS_SELECTOR_SETTSID          = 0x00000000,
    KSMETHOD_BDA_TS_SELECTOR_GETTSINFORMATION = 0x00000001,
}
alias KSMETHOD_BDA_TS_SELECTOR = int;

enum : int
{
    KSMETHOD_BDA_USERACTIVITY_USEREASON = 0x00000000,
    KSMETHOD_BDA_USERACTIVITY_INTERVAL  = 0x00000001,
    KSMETHOD_BDA_USERACTIVITY_DETECTED  = 0x00000002,
}
alias KSMETHOD_BDA_USERACTIVITY_SERVICE = int;

enum : int
{
    COPP_HDCP_Level0     = 0x00000000,
    COPP_HDCP_LevelMin   = 0x00000000,
    COPP_HDCP_Level1     = 0x00000001,
    COPP_HDCP_LevelMax   = 0x00000001,
    COPP_HDCP_ForceDWORD = 0x7fffffff,
}
alias COPP_HDCP_Protection_Level = int;

enum : int
{
    COPP_CGMSA_Disabled                      = 0x00000000,
    COPP_CGMSA_LevelMin                      = 0x00000000,
    COPP_CGMSA_CopyFreely                    = 0x00000001,
    COPP_CGMSA_CopyNoMore                    = 0x00000002,
    COPP_CGMSA_CopyOneGeneration             = 0x00000003,
    COPP_CGMSA_CopyNever                     = 0x00000004,
    COPP_CGMSA_RedistributionControlRequired = 0x00000008,
    COPP_CGMSA_LevelMax                      = 0x0000000c,
    COPP_CGMSA_ForceDWORD                    = 0x7fffffff,
}
alias COPP_CGMSA_Protection_Level = int;

enum : int
{
    COPP_ACP_Level0     = 0x00000000,
    COPP_ACP_LevelMin   = 0x00000000,
    COPP_ACP_Level1     = 0x00000001,
    COPP_ACP_Level2     = 0x00000002,
    COPP_ACP_Level3     = 0x00000003,
    COPP_ACP_LevelMax   = 0x00000003,
    COPP_ACP_ForceDWORD = 0x7fffffff,
}
alias COPP_ACP_Protection_Level = int;

enum : int
{
    COPP_ProtectionStandard_Unknown             = 0x80000000,
    COPP_ProtectionStandard_None                = 0x00000000,
    COPP_ProtectionStandard_IEC61880_525i       = 0x00000001,
    COPP_ProtectionStandard_IEC61880_2_525i     = 0x00000002,
    COPP_ProtectionStandard_IEC62375_625p       = 0x00000004,
    COPP_ProtectionStandard_EIA608B_525         = 0x00000008,
    COPP_ProtectionStandard_EN300294_625i       = 0x00000010,
    COPP_ProtectionStandard_CEA805A_TypeA_525p  = 0x00000020,
    COPP_ProtectionStandard_CEA805A_TypeA_750p  = 0x00000040,
    COPP_ProtectionStandard_CEA805A_TypeA_1125i = 0x00000080,
    COPP_ProtectionStandard_CEA805A_TypeB_525p  = 0x00000100,
    COPP_ProtectionStandard_CEA805A_TypeB_750p  = 0x00000200,
    COPP_ProtectionStandard_CEA805A_TypeB_1125i = 0x00000400,
    COPP_ProtectionStandard_ARIBTRB15_525i      = 0x00000800,
    COPP_ProtectionStandard_ARIBTRB15_525p      = 0x00001000,
    COPP_ProtectionStandard_ARIBTRB15_750p      = 0x00002000,
    COPP_ProtectionStandard_ARIBTRB15_1125i     = 0x00004000,
    COPP_ProtectionStandard_Mask                = 0x80007fff,
    COPP_ProtectionStandard_Reserved            = 0x7fff8000,
}
alias COPP_TVProtectionStandard = int;

enum : int
{
    COPP_AspectRatio_EN300294_FullFormat4by3                = 0x00000000,
    COPP_AspectRatio_EN300294_Box14by9Center                = 0x00000001,
    COPP_AspectRatio_EN300294_Box14by9Top                   = 0x00000002,
    COPP_AspectRatio_EN300294_Box16by9Center                = 0x00000003,
    COPP_AspectRatio_EN300294_Box16by9Top                   = 0x00000004,
    COPP_AspectRatio_EN300294_BoxGT16by9Center              = 0x00000005,
    COPP_AspectRatio_EN300294_FullFormat4by3ProtectedCenter = 0x00000006,
    COPP_AspectRatio_EN300294_FullFormat16by9Anamorphic     = 0x00000007,
    COPP_AspectRatio_ForceDWORD                             = 0x7fffffff,
}
alias COPP_ImageAspectRatio_EN300294 = int;

enum : int
{
    COPP_StatusNormal          = 0x00000000,
    COPP_LinkLost              = 0x00000001,
    COPP_RenegotiationRequired = 0x00000002,
    COPP_StatusFlagsReserved   = 0xfffffffc,
}
alias COPP_StatusFlags = int;

enum : int
{
    COPP_HDCPRepeater      = 0x00000001,
    COPP_HDCPFlagsReserved = 0xfffffffe,
}
alias COPP_StatusHDCPFlags = int;

enum : int
{
    COPP_ConnectorType_Unknown        = 0xffffffff,
    COPP_ConnectorType_VGA            = 0x00000000,
    COPP_ConnectorType_SVideo         = 0x00000001,
    COPP_ConnectorType_CompositeVideo = 0x00000002,
    COPP_ConnectorType_ComponentVideo = 0x00000003,
    COPP_ConnectorType_DVI            = 0x00000004,
    COPP_ConnectorType_HDMI           = 0x00000005,
    COPP_ConnectorType_LVDS           = 0x00000006,
    COPP_ConnectorType_TMDS           = 0x00000007,
    COPP_ConnectorType_D_JPN          = 0x00000008,
    COPP_ConnectorType_Internal       = 0x80000000,
    COPP_ConnectorType_ForceDWORD     = 0x7fffffff,
}
alias COPP_ConnectorType = int;

enum : int
{
    COPP_BusType_Unknown    = 0x00000000,
    COPP_BusType_PCI        = 0x00000001,
    COPP_BusType_PCIX       = 0x00000002,
    COPP_BusType_PCIExpress = 0x00000003,
    COPP_BusType_AGP        = 0x00000004,
    COPP_BusType_Integrated = 0x80000000,
    COPP_BusType_ForceDWORD = 0x7fffffff,
}
alias COPP_BusType = int;

// Constants


enum const(wchar)* g_wszExcludeScriptStreamDeliverySynchronization = "ExcludeScriptStreamDeliverySynchronization";

enum : const(wchar)*
{
    g_wszStreamBufferRecordingBitrate                = "Bitrate",
    g_wszStreamBufferRecordingSeekable               = "Seekable",
    g_wszStreamBufferRecordingStridable              = "Stridable",
    g_wszStreamBufferRecordingBroadcast              = "Broadcast",
    g_wszStreamBufferRecordingProtected              = "Is_Protected",
    g_wszStreamBufferRecordingTrusted                = "Is_Trusted",
    g_wszStreamBufferRecordingSignature_Name         = "Signature_Name",
    g_wszStreamBufferRecordingHasAudio               = "HasAudio",
    g_wszStreamBufferRecordingHasImage               = "HasImage",
    g_wszStreamBufferRecordingHasScript              = "HasScript",
    g_wszStreamBufferRecordingHasVideo               = "HasVideo",
    g_wszStreamBufferRecordingCurrentBitrate         = "CurrentBitrate",
    g_wszStreamBufferRecordingOptimalBitrate         = "OptimalBitrate",
    g_wszStreamBufferRecordingHasAttachedImages      = "HasAttachedImages",
    g_wszStreamBufferRecordingSkipBackward           = "Can_Skip_Backward",
    g_wszStreamBufferRecordingSkipForward            = "Can_Skip_Forward",
    g_wszStreamBufferRecordingNumberOfFrames         = "NumberOfFrames",
    g_wszStreamBufferRecordingFileSize               = "FileSize",
    g_wszStreamBufferRecordingHasArbitraryDataStream = "HasArbitraryDataStream",
    g_wszStreamBufferRecordingHasFileTransferStream  = "HasFileTransferStream",
    g_wszStreamBufferRecordingTitle                  = "Title",
    g_wszStreamBufferRecordingAuthor                 = "Author",
    g_wszStreamBufferRecordingDescription            = "Description",
    g_wszStreamBufferRecordingRating                 = "Rating",
    g_wszStreamBufferRecordingCopyright              = "Copyright",
    g_wszStreamBufferRecordingUse_DRM                = "Use_DRM",
    g_wszStreamBufferRecordingDRM_Flags              = "DRM_Flags",
    g_wszStreamBufferRecordingDRM_Level              = "DRM_Level",
    g_wszStreamBufferRecordingAlbumTitle             = "WM/AlbumTitle",
    g_wszStreamBufferRecordingTrack                  = "WM/Track",
    g_wszStreamBufferRecordingPromotionURL           = "WM/PromotionURL",
    g_wszStreamBufferRecordingAlbumCoverURL          = "WM/AlbumCoverURL",
    g_wszStreamBufferRecordingGenre                  = "WM/Genre",
    g_wszStreamBufferRecordingYear                   = "WM/Year",
    g_wszStreamBufferRecordingGenreID                = "WM/GenreID",
    g_wszStreamBufferRecordingMCDI                   = "WM/MCDI",
    g_wszStreamBufferRecordingComposer               = "WM/Composer",
    g_wszStreamBufferRecordingLyrics                 = "WM/Lyrics",
    g_wszStreamBufferRecordingTrackNumber            = "WM/TrackNumber",
    g_wszStreamBufferRecordingToolName               = "WM/ToolName",
    g_wszStreamBufferRecordingToolVersion            = "WM/ToolVersion",
    g_wszStreamBufferRecordingIsVBR                  = "IsVBR",
    g_wszStreamBufferRecordingAlbumArtist            = "WM/AlbumArtist",
    g_wszStreamBufferRecordingBannerImageType        = "BannerImageType",
    g_wszStreamBufferRecordingBannerImageData        = "BannerImageData",
    g_wszStreamBufferRecordingBannerImageURL         = "BannerImageURL",
    g_wszStreamBufferRecordingCopyrightURL           = "CopyrightURL",
    g_wszStreamBufferRecordingAspectRatioX           = "AspectRatioX",
    g_wszStreamBufferRecordingAspectRatioY           = "AspectRatioY",
    g_wszStreamBufferRecordingNSCName                = "NSC_Name",
    g_wszStreamBufferRecordingNSCAddress             = "NSC_Address",
    g_wszStreamBufferRecordingNSCPhone               = "NSC_Phone",
    g_wszStreamBufferRecordingNSCEmail               = "NSC_Email",
    g_wszStreamBufferRecordingNSCDescription         = "NSC_Description",
}

enum : int
{
    STREAMBUFFER_EC_STALE_DATA_READ                = 0x00000327,
    STREAMBUFFER_EC_STALE_FILE_DELETED             = 0x00000328,
    STREAMBUFFER_EC_CONTENT_BECOMING_STALE         = 0x00000329,
    STREAMBUFFER_EC_WRITE_FAILURE                  = 0x0000032a,
    STREAMBUFFER_EC_WRITE_FAILURE_CLEAR            = 0x0000032b,
    STREAMBUFFER_EC_READ_FAILURE                   = 0x0000032c,
    STREAMBUFFER_EC_RATE_CHANGED                   = 0x0000032d,
    STREAMBUFFER_EC_PRIMARY_AUDIO                  = 0x0000032e,
    STREAMBUFFER_EC_RATE_CHANGING_FOR_SETPOSITIONS = 0x0000032f,
}

// Callbacks

alias AMGETERRORTEXTPROCA = BOOL function(HRESULT param0, byte* param1, uint param2);
alias AMGETERRORTEXTPROCW = BOOL function(HRESULT param0, ushort* param1, uint param2);
alias AMGETERRORTEXTPROC = BOOL function();

// Structs


struct BITMAPINFOHEADER
{
    uint   biSize;
    int    biWidth;
    int    biHeight;
    ushort biPlanes;
    ushort biBitCount;
    uint   biCompression;
    uint   biSizeImage;
    int    biXPelsPerMeter;
    int    biYPelsPerMeter;
    uint   biClrUsed;
    uint   biClrImportant;
}

struct AMVPSIZE
{
    uint dwWidth;
    uint dwHeight;
}

struct AMVPDIMINFO
{
    uint dwFieldWidth;
    uint dwFieldHeight;
    uint dwVBIWidth;
    uint dwVBIHeight;
    RECT rcValidRegion;
}

struct AMVPDATAINFO
{
    uint        dwSize;
    uint        dwMicrosecondsPerField;
    AMVPDIMINFO amvpDimInfo;
    uint        dwPictAspectRatioX;
    uint        dwPictAspectRatioY;
    BOOL        bEnableDoubleClock;
    BOOL        bEnableVACT;
    BOOL        bDataIsInterlaced;
    int         lHalfLinesOdd;
    BOOL        bFieldPolarityInverted;
    uint        dwNumLinesInVREF;
    int         lHalfLinesEven;
    uint        dwReserved1;
}

struct AM_MEDIA_TYPE
{
    GUID     majortype;
    GUID     subtype;
    BOOL     bFixedSizeSamples;
    BOOL     bTemporalCompression;
    uint     lSampleSize;
    GUID     formattype;
    IUnknown pUnk;
    uint     cbFormat;
    ubyte*   pbFormat;
}

struct ALLOCATOR_PROPERTIES
{
    int cBuffers;
    int cbBuffer;
    int cbAlign;
    int cbPrefix;
}

struct PIN_INFO
{
    IBaseFilter   pFilter;
    PIN_DIRECTION dir;
    ushort[128]   achName;
}

struct FILTER_INFO
{
    ushort[128]  achName;
    IFilterGraph pGraph;
}

struct AM_SAMPLE2_PROPERTIES
{
    uint           cbData;
    uint           dwTypeSpecificFlags;
    uint           dwSampleFlags;
    int            lActual;
    long           tStart;
    long           tStop;
    uint           dwStreamId;
    AM_MEDIA_TYPE* pMediaType;
    ubyte*         pbBuffer;
    int            cbBuffer;
}

struct REGFILTER
{
    GUID          Clsid;
    const(wchar)* Name;
}

struct REGPINTYPES
{
    const(GUID)* clsMajorType;
    const(GUID)* clsMinorType;
}

struct REGFILTERPINS
{
    const(wchar)*       strName;
    BOOL                bRendered;
    BOOL                bOutput;
    BOOL                bZero;
    BOOL                bMany;
    const(GUID)*        clsConnectsToFilter;
    const(wchar)*       strConnectsToPin;
    uint                nMediaTypes;
    const(REGPINTYPES)* lpMediaType;
}

struct REGPINMEDIUM
{
    GUID clsMedium;
    uint dw1;
    uint dw2;
}

struct REGFILTERPINS2
{
    uint                 dwFlags;
    uint                 cInstances;
    uint                 nMediaTypes;
    const(REGPINTYPES)*  lpMediaType;
    uint                 nMediums;
    const(REGPINMEDIUM)* lpMedium;
    const(GUID)*         clsPinCategory;
}

struct REGFILTER2
{
    uint dwVersion;
    uint dwMerit;
    union
    {
        struct
        {
            uint cPins;
            const(REGFILTERPINS)* rgPins;
        }
        struct
        {
            uint cPins2;
            const(REGFILTERPINS2)* rgPins2;
        }
    }
}

struct Quality
{
    QualityMessageType Type;
    int                Proportion;
    long               Late;
    long               TimeStamp;
}

struct COLORKEY
{
    uint KeyType;
    uint PaletteIndex;
    uint LowColorValue;
    uint HighColorValue;
}

struct AM_STREAM_INFO
{
    long tStart;
    long tStop;
    uint dwStartCookie;
    uint dwStopCookie;
    uint dwFlags;
}

struct VIDEO_STREAM_CONFIG_CAPS
{
    GUID guid;
    uint VideoStandard;
    SIZE InputSize;
    SIZE MinCroppingSize;
    SIZE MaxCroppingSize;
    int  CropGranularityX;
    int  CropGranularityY;
    int  CropAlignX;
    int  CropAlignY;
    SIZE MinOutputSize;
    SIZE MaxOutputSize;
    int  OutputGranularityX;
    int  OutputGranularityY;
    int  StretchTapsX;
    int  StretchTapsY;
    int  ShrinkTapsX;
    int  ShrinkTapsY;
    long MinFrameInterval;
    long MaxFrameInterval;
    int  MinBitsPerSecond;
    int  MaxBitsPerSecond;
}

struct AUDIO_STREAM_CONFIG_CAPS
{
    GUID guid;
    uint MinimumChannels;
    uint MaximumChannels;
    uint ChannelsGranularity;
    uint MinimumBitsPerSample;
    uint MaximumBitsPerSample;
    uint BitsPerSampleGranularity;
    uint MinimumSampleFrequency;
    uint MaximumSampleFrequency;
    uint SampleFrequencyGranularity;
}

struct DVINFO
{
    uint    dwDVAAuxSrc;
    uint    dwDVAAuxCtl;
    uint    dwDVAAuxSrc1;
    uint    dwDVAAuxCtl1;
    uint    dwDVVAuxSrc;
    uint    dwDVVAuxCtl;
    uint[2] dwDVReserved;
}

struct STREAM_ID_MAP
{
    uint stream_id;
    uint dwMediaSampleContent;
    uint ulSubstreamFilterValue;
    int  iDataOffset;
}

struct AMCOPPSignature
{
    ubyte[256] Signature;
}

struct AMCOPPCommand
{
    GUID        macKDI;
    GUID        guidCommandID;
    uint        dwSequence;
    uint        cbSizeData;
    ubyte[4056] CommandData;
}

struct AMCOPPStatusInput
{
    GUID        rApp;
    GUID        guidStatusRequestID;
    uint        dwSequence;
    uint        cbSizeData;
    ubyte[4056] StatusData;
}

struct AMCOPPStatusOutput
{
    GUID        macKDI;
    uint        cbSizeData;
    ubyte[4076] COPPStatus;
}

struct VMRPRESENTATIONINFO
{
    uint                dwFlags;
    IDirectDrawSurface7 lpSurf;
    long                rtStart;
    long                rtEnd;
    SIZE                szAspectRatio;
    RECT                rcSrc;
    RECT                rcDst;
    uint                dwTypeSpecificFlags;
    uint                dwInterlaceFlags;
}

struct VMRALLOCATIONINFO
{
    uint              dwFlags;
    BITMAPINFOHEADER* lpHdr;
    DDPIXELFORMAT*    lpPixFmt;
    SIZE              szAspectRatio;
    uint              dwMinBuffers;
    uint              dwMaxBuffers;
    uint              dwInterlaceFlags;
    SIZE              szNativeSize;
}

struct NORMALIZEDRECT
{
    float left;
    float top;
    float right;
    float bottom;
}

struct VMRGUID
{
    GUID* pGUID;
    GUID  Guid;
}

struct VMRMONITORINFO
{
    VMRGUID       guid;
    RECT          rcMonitor;
    ptrdiff_t     hMon;
    uint          dwFlags;
    ushort[32]    szDevice;
    ushort[256]   szDescription;
    LARGE_INTEGER liDriverVersion;
    uint          dwVendorId;
    uint          dwDeviceId;
    uint          dwSubSysId;
    uint          dwRevision;
}

struct VMRFrequency
{
    uint dwNumerator;
    uint dwDenominator;
}

struct VMRVideoDesc
{
    uint         dwSize;
    uint         dwSampleWidth;
    uint         dwSampleHeight;
    BOOL         SingleFieldPerSample;
    uint         dwFourCC;
    VMRFrequency InputSampleFreq;
    VMRFrequency OutputFrameFreq;
}

struct VMRDeinterlaceCaps
{
    uint               dwSize;
    uint               dwNumPreviousOutputFrames;
    uint               dwNumForwardRefSamples;
    uint               dwNumBackwardRefSamples;
    VMRDeinterlaceTech DeinterlaceTechnology;
}

struct VMRALPHABITMAP
{
    uint                dwFlags;
    HDC                 hdc;
    IDirectDrawSurface7 pDDS;
    RECT                rSrc;
    NORMALIZEDRECT      rDest;
    float               fAlpha;
    uint                clrSrcKey;
}

struct VMRVIDEOSTREAMINFO
{
    IDirectDrawSurface7 pddsVideoSurface;
    uint                dwWidth;
    uint                dwHeight;
    uint                dwStrmID;
    float               fAlpha;
    DDCOLORKEY          ddClrKey;
    NORMALIZEDRECT      rNormal;
}

struct DVD_ATR
{
    uint       ulCAT;
    ubyte[768] pbATRI;
}

struct DVD_TIMECODE
{
    uint _bitfield14;
}

struct DVD_HMSF_TIMECODE
{
    ubyte bHours;
    ubyte bMinutes;
    ubyte bSeconds;
    ubyte bFrames;
}

struct DVD_PLAYBACK_LOCATION2
{
    uint              TitleNum;
    uint              ChapterNum;
    DVD_HMSF_TIMECODE TimeCode;
    uint              TimeCodeFlags;
}

struct DVD_PLAYBACK_LOCATION
{
    uint TitleNum;
    uint ChapterNum;
    uint TimeCode;
}

struct DVD_AudioAttributes
{
    DVD_AUDIO_APPMODE  AppMode;
    ubyte              AppModeData;
    DVD_AUDIO_FORMAT   AudioFormat;
    uint               Language;
    DVD_AUDIO_LANG_EXT LanguageExtension;
    BOOL               fHasMultichannelInfo;
    uint               dwFrequency;
    ubyte              bQuantization;
    ubyte              bNumberOfChannels;
    uint[2]            dwReserved;
}

struct DVD_MUA_MixingInfo
{
    BOOL fMixTo0;
    BOOL fMixTo1;
    BOOL fMix0InPhase;
    BOOL fMix1InPhase;
    uint dwSpeakerPosition;
}

struct DVD_MUA_Coeff
{
    double log2_alpha;
    double log2_beta;
}

struct DVD_MultichannelAudioAttributes
{
    DVD_MUA_MixingInfo[8] Info;
    DVD_MUA_Coeff[8] Coeff;
}

struct DVD_KaraokeAttributes
{
    ubyte     bVersion;
    BOOL      fMasterOfCeremoniesInGuideVocal1;
    BOOL      fDuet;
    DVD_KARAOKE_ASSIGNMENT ChannelAssignment;
    ushort[8] wChannelContents;
}

struct DVD_VideoAttributes
{
    BOOL fPanscanPermitted;
    BOOL fLetterboxPermitted;
    uint ulAspectX;
    uint ulAspectY;
    uint ulFrameRate;
    uint ulFrameHeight;
    DVD_VIDEO_COMPRESSION Compression;
    BOOL fLine21Field1InGOP;
    BOOL fLine21Field2InGOP;
    uint ulSourceResolutionX;
    uint ulSourceResolutionY;
    BOOL fIsSourceLetterboxed;
    BOOL fIsFilmMode;
}

struct DVD_SubpictureAttributes
{
    DVD_SUBPICTURE_TYPE Type;
    DVD_SUBPICTURE_CODING CodingMode;
    uint                Language;
    DVD_SUBPICTURE_LANG_EXT LanguageExtension;
}

struct DVD_TitleAttributes
{
    union
    {
        DVD_TITLE_APPMODE AppMode;
        DVD_HMSF_TIMECODE TitleLength;
    }
    DVD_VideoAttributes VideoAttributes;
    uint                ulNumberOfAudioStreams;
    DVD_AudioAttributes[8] AudioAttributes;
    DVD_MultichannelAudioAttributes[8] MultichannelAudioAttributes;
    uint                ulNumberOfSubpictureStreams;
    DVD_SubpictureAttributes[32] SubpictureAttributes;
}

struct DVD_MenuAttributes
{
    BOOL[8]***          fCompatibleRegion;
    DVD_VideoAttributes VideoAttributes;
    BOOL                fAudioPresent;
    DVD_AudioAttributes AudioAttributes;
    BOOL                fSubpicturePresent;
    DVD_SubpictureAttributes SubpictureAttributes;
}

struct DVD_DECODER_CAPS
{
    uint   dwSize;
    uint   dwAudioCaps;
    double dFwdMaxRateVideo;
    double dFwdMaxRateAudio;
    double dFwdMaxRateSP;
    double dBwdMaxRateVideo;
    double dBwdMaxRateAudio;
    double dBwdMaxRateSP;
    uint   dwRes1;
    uint   dwRes2;
    uint   dwRes3;
    uint   dwRes4;
}

struct AM_DVD_RENDERSTATUS
{
    HRESULT hrVPEStatus;
    BOOL    bDvdVolInvalid;
    BOOL    bDvdVolUnknown;
    BOOL    bNoLine21In;
    BOOL    bNoLine21Out;
    int     iNumStreams;
    int     iNumStreamsFailed;
    uint    dwFailedStreamsFlag;
}

struct BDA_TEMPLATE_CONNECTION
{
    uint FromNodeType;
    uint FromNodePinType;
    uint ToNodeType;
    uint ToNodePinType;
}

struct BDA_TEMPLATE_PIN_JOINT
{
    uint uliTemplateConnection;
    uint ulcInstancesMax;
}

struct KS_BDA_FRAME_INFO
{
    uint ExtendedHeaderSize;
    uint dwFrameFlags;
    uint ulEvent;
    uint ulChannelNumber;
    uint ulSubchannelNumber;
    uint ulReason;
}

struct BDA_ETHERNET_ADDRESS
{
    ubyte[6] rgbAddress;
}

struct BDA_ETHERNET_ADDRESS_LIST
{
    uint ulcAddresses;
    BDA_ETHERNET_ADDRESS[1] rgAddressl;
}

struct BDA_IPv4_ADDRESS
{
    ubyte[4] rgbAddress;
}

struct BDA_IPv4_ADDRESS_LIST
{
    uint                ulcAddresses;
    BDA_IPv4_ADDRESS[1] rgAddressl;
}

struct BDA_IPv6_ADDRESS
{
    ubyte[6] rgbAddress;
}

struct BDA_IPv6_ADDRESS_LIST
{
    uint                ulcAddresses;
    BDA_IPv6_ADDRESS[1] rgAddressl;
}

struct BDANODE_DESCRIPTOR
{
    uint ulBdaNodeType;
    GUID guidFunction;
    GUID guidName;
}

struct BDA_TABLE_SECTION
{
    uint    ulPrimarySectionId;
    uint    ulSecondarySectionId;
    uint    ulcbSectionLength;
    uint[1] argbSectionData;
}

struct BDA_DISEQC_SEND
{
    uint     ulRequestId;
    uint     ulPacketLength;
    ubyte[8] argbPacketData;
}

struct BDA_DISEQC_RESPONSE
{
    uint     ulRequestId;
    uint     ulPacketLength;
    ubyte[8] argbPacketData;
}

struct PID_MAP
{
    uint                 ulPID;
    MEDIA_SAMPLE_CONTENT MediaSampleContent;
}

struct BDA_PID_MAP
{
    MEDIA_SAMPLE_CONTENT MediaSampleContent;
    uint                 ulcPIDs;
    uint[1]              aulPIDs;
}

struct BDA_PID_UNMAP
{
    uint    ulcPIDs;
    uint[1] aulPIDs;
}

struct BDA_CA_MODULE_UI
{
    uint    ulFormat;
    uint    ulbcDesc;
    uint[1] ulDesc;
}

struct BDA_PROGRAM_PID_LIST
{
    uint    ulProgramNumber;
    uint    ulcPIDs;
    uint[1] ulPID;
}

struct BDA_DRM_DRMSTATUS
{
    int     lResult;
    GUID    DRMuuid;
    uint    ulDrmUuidListStringSize;
    GUID[1] argbDrmUuidListString;
}

struct BDA_WMDRM_STATUS
{
    int   lResult;
    uint  ulMaxCaptureTokenSize;
    uint  uMaxStreamingPid;
    uint  ulMaxLicense;
    uint  ulMinSecurityLevel;
    uint  ulRevInfoSequenceNumber;
    ulong ulRevInfoIssuedTime;
    uint  ulRevListVersion;
    uint  ulRevInfoTTL;
    uint  ulState;
}

struct BDA_WMDRM_KEYINFOLIST
{
    int     lResult;
    uint    ulKeyuuidBufferLen;
    GUID[1] argKeyuuidBuffer;
}

struct BDA_BUFFER
{
    int      lResult;
    uint     ulBufferSize;
    ubyte[1] argbBuffer;
}

struct BDA_WMDRM_RENEWLICENSE
{
    int      lResult;
    uint     ulDescrambleStatus;
    uint     ulXmrLicenseOutputLength;
    ubyte[1] argbXmrLicenceOutputBuffer;
}

struct BDA_WMDRMTUNER_PIDPROTECTION
{
    int  lResult;
    GUID uuidKeyID;
}

struct BDA_WMDRMTUNER_PURCHASEENTITLEMENT
{
    int      lResult;
    uint     ulDescrambleStatus;
    uint     ulCaptureTokenLength;
    ubyte[1] argbCaptureTokenBuffer;
}

struct BDA_TUNER_TUNERSTATE
{
    int      lResult;
    uint     ulTuneLength;
    ubyte[1] argbTuneData;
}

struct BDA_TUNER_DIAGNOSTICS
{
    int  lResult;
    uint ulSignalLevel;
    uint ulSignalLevelQuality;
    uint ulSignalNoiseRatio;
}

struct BDA_STRING
{
    int      lResult;
    uint     ulStringSize;
    ubyte[1] argbString;
}

struct BDA_SCAN_CAPABILTIES
{
    int   lResult;
    ulong ul64AnalogStandardsSupported;
}

struct BDA_SCAN_STATE
{
    int  lResult;
    uint ulSignalLock;
    uint ulSecondsLeft;
    uint ulCurrentFrequency;
}

struct BDA_SCAN_START
{
    int  lResult;
    uint LowerFrequency;
    uint HigerFrequency;
}

struct BDA_GDDS_DATATYPE
{
    int  lResult;
    GUID uuidDataType;
}

struct BDA_GDDS_DATA
{
    int      lResult;
    uint     ulDataLength;
    uint     ulPercentageProgress;
    ubyte[1] argbData;
}

struct BDA_USERACTIVITY_INTERVAL
{
    int  lResult;
    uint ulActivityInterval;
}

struct BDA_CAS_CHECK_ENTITLEMENTTOKEN
{
    int  lResult;
    uint ulDescrambleStatus;
}

struct BDA_CAS_CLOSE_MMIDIALOG
{
    int  lResult;
    uint SessionResult;
}

struct BDA_CAS_REQUESTTUNERDATA
{
    ubyte ucRequestPriority;
    ubyte ucRequestReason;
    ubyte ucRequestConsequences;
    uint  ulEstimatedTime;
}

struct BDA_CAS_OPENMMIDATA
{
    uint     ulDialogNumber;
    uint     ulDialogRequest;
    GUID     uuidDialogType;
    ushort   usDialogDataLength;
    ubyte[1] argbDialogData;
}

struct BDA_CAS_CLOSEMMIDATA
{
    uint ulDialogNumber;
}

struct BDA_ISDBCAS_REQUESTHEADER
{
align (1):
    ubyte    bInstruction;
    ubyte[3] bReserved;
    uint     ulDataLength;
    ubyte[1] argbIsdbCommand;
}

struct BDA_ISDBCAS_RESPONSEDATA
{
align (1):
    int      lResult;
    uint     ulRequestID;
    uint     ulIsdbStatus;
    uint     ulIsdbDataSize;
    ubyte[1] argbIsdbCommandData;
}

struct BDA_ISDBCAS_EMG_REQ
{
    ubyte    bCLA;
    ubyte    bINS;
    ubyte    bP1;
    ubyte    bP2;
    ubyte    bLC;
    ubyte[6] bCardId;
    ubyte    bProtocol;
    ubyte    bCABroadcasterGroupId;
    ubyte    bMessageControl;
    ubyte[1] bMessageCode;
}

struct BDA_MUX_PIDLISTITEM
{
align (2):
    ushort       usPIDNumber;
    ushort       usProgramNumber;
    MUX_PID_TYPE ePIDType;
}

struct BDA_TS_SELECTORINFO
{
align (1):
    ubyte     bTSInfolength;
    ubyte[2]  bReserved;
    GUID      guidNetworkType;
    ubyte     bTSIDCount;
    ushort[1] usTSID;
}

struct BDA_TS_SELECTORINFO_ISDBS_EXT
{
    ubyte[48] bTMCC;
}

struct BDA_DVBT2_L1_SIGNALLING_DATA
{
    ubyte    L1Pre_TYPE;
    ubyte    L1Pre_BWT_S1_S2;
    ubyte    L1Pre_REPETITION_GUARD_PAPR;
    ubyte    L1Pre_MOD_COD_FEC;
    ubyte[5] L1Pre_POSTSIZE_INFO_PILOT;
    ubyte    L1Pre_TX_ID_AVAIL;
    ubyte[2] L1Pre_CELL_ID;
    ubyte[2] L1Pre_NETWORK_ID;
    ubyte[2] L1Pre_T2SYSTEM_ID;
    ubyte    L1Pre_NUM_T2_FRAMES;
    ubyte[2] L1Pre_NUM_DATA_REGENFLAG_L1POSTEXT;
    ubyte[2] L1Pre_NUMRF_CURRENTRF_RESERVED;
    ubyte[4] L1Pre_CRC32;
    ubyte[1] L1PostData;
}

struct BDA_RATING_PINRESET
{
    ubyte    bPinLength;
    ubyte[1] argbNewPin;
}

struct MPEG2_TRANSPORT_STRIDE
{
    uint dwOffset;
    uint dwPacketLength;
    uint dwStride;
}

struct BDA_SIGNAL_TIMEOUTS
{
    uint ulCarrierTimeoutMs;
    uint ulScanningTimeoutMs;
    uint ulTuningTimeoutMs;
}

struct EALocationCodeType
{
    LocationCodeSchemeType LocationCodeScheme;
    ubyte  state_code;
    ubyte  county_subdivision;
    ushort county_code;
}

struct SmartCardApplication
{
    ApplicationTypeType ApplicationType;
    ushort              ApplicationVersion;
    BSTR                pbstrApplicationName;
    BSTR                pbstrApplicationURL;
}

struct AMVAUncompBufferInfo
{
    uint          dwMinNumSurfaces;
    uint          dwMaxNumSurfaces;
    DDPIXELFORMAT ddUncompPixelFormat;
}

struct AMVAUncompDataInfo
{
    uint          dwUncompWidth;
    uint          dwUncompHeight;
    DDPIXELFORMAT ddUncompPixelFormat;
}

struct AMVAInternalMemInfo
{
    uint dwScratchMemAlloc;
}

struct AMVACompBufferInfo
{
    uint          dwNumCompBuffers;
    uint          dwWidthToCreate;
    uint          dwHeightToCreate;
    uint          dwBytesToAllocate;
    DDSCAPS2      ddCompCaps;
    DDPIXELFORMAT ddPixelFormat;
}

struct AMVABeginFrameInfo
{
    uint  dwDestSurfaceIndex;
    void* pInputData;
    uint  dwSizeInputData;
    void* pOutputData;
    uint  dwSizeOutputData;
}

struct AMVAEndFrameInfo
{
    uint  dwSizeMiscData;
    void* pMiscData;
}

struct AMVABUFFERINFO
{
    uint dwTypeIndex;
    uint dwBufferIndex;
    uint dwDataOffset;
    uint dwDataSize;
}

struct AM_WST_PAGE
{
    uint   dwPageNr;
    uint   dwSubPageNr;
    ubyte* pucPageData;
}

struct TRUECOLORINFO
{
    uint[3]      dwBitMasks;
    RGBQUAD[256] bmiColors;
}

struct VIDEOINFOHEADER
{
    RECT             rcSource;
    RECT             rcTarget;
    uint             dwBitRate;
    uint             dwBitErrorRate;
    long             AvgTimePerFrame;
    BITMAPINFOHEADER bmiHeader;
}

struct VIDEOINFO
{
    RECT             rcSource;
    RECT             rcTarget;
    uint             dwBitRate;
    uint             dwBitErrorRate;
    long             AvgTimePerFrame;
    BITMAPINFOHEADER bmiHeader;
    union
    {
        RGBQUAD[256]  bmiColors;
        uint[3]       dwBitMasks;
        TRUECOLORINFO TrueColorInfo;
    }
}

struct MPEG1VIDEOINFO
{
    VIDEOINFOHEADER hdr;
    uint            dwStartTimeCode;
    uint            cbSequenceHeader;
    ubyte[1]        bSequenceHeader;
}

struct ANALOGVIDEOINFO
{
    RECT rcSource;
    RECT rcTarget;
    uint dwActiveWidth;
    uint dwActiveHeight;
    long AvgTimePerFrame;
}

struct AM_FRAMESTEP_STEP
{
    uint dwFramesToStep;
}

struct OPTIMAL_WEIGHT_TOTALS
{
    long MinTotalNominator;
    long MaxTotalNominator;
    long TotalDenominator;
}

struct IKsPin
{
}

struct IKsAllocator
{
}

struct IKsAllocatorEx
{
}

struct PIPE_DIMENSIONS
{
    KS_COMPRESSION AllocatorPin;
    KS_COMPRESSION MaxExpansionPin;
    KS_COMPRESSION EndPin;
}

struct PIPE_TERMINATION
{
    uint             Flags;
    uint             OutsideFactors;
    uint             Weigth;
    KS_FRAMING_RANGE PhysicalRange;
    KS_FRAMING_RANGE_WEIGHTED OptimalRange;
    KS_COMPRESSION   Compression;
}

struct ALLOCATOR_PROPERTIES_EX
{
    int                  cBuffers;
    int                  cbBuffer;
    int                  cbAlign;
    int                  cbPrefix;
    GUID                 MemoryType;
    GUID                 BusType;
    PIPE_STATE           State;
    PIPE_TERMINATION     Input;
    PIPE_TERMINATION     Output;
    uint                 Strategy;
    uint                 Flags;
    uint                 Weight;
    KS_LogicalMemoryType LogicalMemoryType;
    PIPE_ALLOCATOR_PLACE AllocatorPlace;
    PIPE_DIMENSIONS      Dimensions;
    KS_FRAMING_RANGE     PhysicalRange;
    IKsAllocatorEx*      PrevSegment;
    uint                 CountNextSegments;
    IKsAllocatorEx**     NextSegments;
    uint                 InsideFactors;
    uint                 NumberPins;
}

struct AM_MPEGSTREAMTYPE
{
    uint          dwStreamId;
    uint          dwReserved;
    AM_MEDIA_TYPE mt;
    ubyte[1]      bFormat;
}

struct AM_MPEGSYSTEMTYPE
{
    uint                 dwBitRate;
    uint                 cStreams;
    AM_MPEGSTREAMTYPE[1] Streams;
}

struct VMR9PresentationInfo
{
    uint              dwFlags;
    IDirect3DSurface9 lpSurf;
    long              rtStart;
    long              rtEnd;
    SIZE              szAspectRatio;
    RECT              rcSrc;
    RECT              rcDst;
    uint              dwReserved1;
    uint              dwReserved2;
}

struct VMR9AllocationInfo
{
    uint      dwFlags;
    uint      dwWidth;
    uint      dwHeight;
    D3DFORMAT Format;
    D3DPOOL   Pool;
    uint      MinBuffers;
    SIZE      szAspectRatio;
    SIZE      szNativeSize;
}

struct VMR9NormalizedRect
{
    float left;
    float top;
    float right;
    float bottom;
}

struct VMR9ProcAmpControl
{
    uint  dwSize;
    uint  dwFlags;
    float Brightness;
    float Contrast;
    float Hue;
    float Saturation;
}

struct VMR9ProcAmpControlRange
{
    uint  dwSize;
    VMR9ProcAmpControlFlags dwProperty;
    float MinValue;
    float MaxValue;
    float DefaultValue;
    float StepSize;
}

struct VMR9AlphaBitmap
{
    uint               dwFlags;
    HDC                hdc;
    IDirect3DSurface9  pDDS;
    RECT               rSrc;
    VMR9NormalizedRect rDest;
    float              fAlpha;
    uint               clrSrcKey;
    uint               dwFilterMode;
}

struct VMR9MonitorInfo
{
    uint          uDevID;
    RECT          rcMonitor;
    ptrdiff_t     hMon;
    uint          dwFlags;
    ushort[32]    szDevice;
    ushort[512]   szDescription;
    LARGE_INTEGER liDriverVersion;
    uint          dwVendorId;
    uint          dwDeviceId;
    uint          dwSubSysId;
    uint          dwRevision;
}

struct VMR9Frequency
{
    uint dwNumerator;
    uint dwDenominator;
}

struct VMR9VideoDesc
{
    uint              dwSize;
    uint              dwSampleWidth;
    uint              dwSampleHeight;
    VMR9_SampleFormat SampleFormat;
    uint              dwFourCC;
    VMR9Frequency     InputSampleFreq;
    VMR9Frequency     OutputFrameFreq;
}

struct VMR9DeinterlaceCaps
{
    uint                dwSize;
    uint                dwNumPreviousOutputFrames;
    uint                dwNumForwardRefSamples;
    uint                dwNumBackwardRefSamples;
    VMR9DeinterlaceTech DeinterlaceTechnology;
}

struct VMR9VideoStreamInfo
{
    IDirect3DSurface9  pddsVideoSurface;
    uint               dwWidth;
    uint               dwHeight;
    uint               dwStrmID;
    float              fAlpha;
    VMR9NormalizedRect rNormal;
    long               rtStart;
    long               rtEnd;
    VMR9_SampleFormat  SampleFormat;
}

struct _riffchunk
{
align (2):
    uint fcc;
    uint cb;
}

struct _rifflist
{
align (2):
    uint fcc;
    uint cb;
    uint fccListType;
}

struct AVIMAINHEADER
{
align (2):
    uint    fcc;
    uint    cb;
    uint    dwMicroSecPerFrame;
    uint    dwMaxBytesPerSec;
    uint    dwPaddingGranularity;
    uint    dwFlags;
    uint    dwTotalFrames;
    uint    dwInitialFrames;
    uint    dwStreams;
    uint    dwSuggestedBufferSize;
    uint    dwWidth;
    uint    dwHeight;
    uint[4] dwReserved;
}

struct _aviextheader
{
align (2):
    uint     fcc;
    uint     cb;
    uint     dwGrandFrames;
    uint[61] dwFuture;
}

struct AVISTREAMHEADER
{
align (2):
    uint   fcc;
    uint   cb;
    uint   fccType;
    uint   fccHandler;
    uint   dwFlags;
    ushort wPriority;
    ushort wLanguage;
    uint   dwInitialFrames;
    uint   dwScale;
    uint   dwRate;
    uint   dwStart;
    uint   dwLength;
    uint   dwSuggestedBufferSize;
    uint   dwQuality;
    uint   dwSampleSize;
    struct rcFrame
    {
        short left;
        short top;
        short right;
        short bottom;
    }
}

struct AVIOLDINDEX
{
align (2):
    uint fcc;
    uint cb;
    struct aIndex
    {
    align (2):
        uint dwChunkId;
        uint dwFlags;
        uint dwOffset;
        uint dwSize;
    }
}

struct _timecodedata
{
align (2):
    TIMECODE time;
    uint     dwSMPTEflags;
    uint     dwUser;
}

struct AVIMETAINDEX
{
align (2):
    uint    fcc;
    uint    cb;
    ushort  wLongsPerEntry;
    ubyte   bIndexSubType;
    ubyte   bIndexType;
    uint    nEntriesInUse;
    uint    dwChunkId;
    uint[3] dwReserved;
    uint    adwIndex;
}

struct AVISUPERINDEX
{
align (2):
    uint    fcc;
    uint    cb;
    ushort  wLongsPerEntry;
    ubyte   bIndexSubType;
    ubyte   bIndexType;
    uint    nEntriesInUse;
    uint    dwChunkId;
    uint[3] dwReserved;
    struct aIndex
    {
    align (2):
        ulong qwOffset;
        uint  dwSize;
        uint  dwDuration;
    }
}

struct AVISTDINDEX_ENTRY
{
align (2):
    uint dwOffset;
    uint dwSize;
}

struct AVISTDINDEX
{
align (2):
    uint   fcc;
    uint   cb;
    ushort wLongsPerEntry;
    ubyte  bIndexSubType;
    ubyte  bIndexType;
    uint   nEntriesInUse;
    uint   dwChunkId;
    ulong  qwBaseOffset;
    uint   dwReserved_3;
    AVISTDINDEX_ENTRY[2044] aIndex;
}

struct _avitimedindex_entry
{
align (2):
    uint dwOffset;
    uint dwSize;
    uint dwDuration;
}

struct _avitimedindex
{
align (2):
    uint       fcc;
    uint       cb;
    ushort     wLongsPerEntry;
    ubyte      bIndexSubType;
    ubyte      bIndexType;
    uint       nEntriesInUse;
    uint       dwChunkId;
    ulong      qwBaseOffset;
    uint       dwReserved_3;
    _avitimedindex_entry[1362] aIndex;
    uint[2734] adwTrailingFill;
}

struct _avitimecodeindex
{
align (2):
    uint                fcc;
    uint                cb;
    ushort              wLongsPerEntry;
    ubyte               bIndexSubType;
    ubyte               bIndexType;
    uint                nEntriesInUse;
    uint                dwChunkId;
    uint[3]             dwReserved;
    _timecodedata[1022] aIndex;
}

struct _avitcdlindex_entry
{
align (2):
    uint     dwTick;
    TIMECODE time;
    uint     dwSMPTEflags;
    uint     dwUser;
    byte[12] szReelId;
}

struct _avitcdlindex
{
align (2):
    uint       fcc;
    uint       cb;
    ushort     wLongsPerEntry;
    ubyte      bIndexSubType;
    ubyte      bIndexType;
    uint       nEntriesInUse;
    uint       dwChunkId;
    uint[3]    dwReserved;
    _avitcdlindex_entry[584] aIndex;
    uint[3512] adwTrailingFill;
}

struct _avifieldindex_chunk
{
align (2):
    uint   fcc;
    uint   cb;
    ushort wLongsPerEntry;
    ubyte  bIndexSubType;
    ubyte  bIndexType;
    uint   nEntriesInUse;
    uint   dwChunkId;
    ulong  qwBaseOffset;
    uint   dwReserved3;
    struct aIndex
    {
    align (2):
        uint dwOffset;
        uint dwSize;
        uint dwOffsetField2;
    }
}

struct MainAVIHeader
{
    uint    dwMicroSecPerFrame;
    uint    dwMaxBytesPerSec;
    uint    dwPaddingGranularity;
    uint    dwFlags;
    uint    dwTotalFrames;
    uint    dwInitialFrames;
    uint    dwStreams;
    uint    dwSuggestedBufferSize;
    uint    dwWidth;
    uint    dwHeight;
    uint[4] dwReserved;
}

struct AVIStreamHeader
{
    uint   fccType;
    uint   fccHandler;
    uint   dwFlags;
    ushort wPriority;
    ushort wLanguage;
    uint   dwInitialFrames;
    uint   dwScale;
    uint   dwRate;
    uint   dwStart;
    uint   dwLength;
    uint   dwSuggestedBufferSize;
    uint   dwQuality;
    uint   dwSampleSize;
    RECT   rcFrame;
}

struct AVIINDEXENTRY
{
    uint ckid;
    uint dwFlags;
    uint dwChunkOffset;
    uint dwChunkLength;
}

struct AVIPALCHANGE
{
    ubyte        bFirstEntry;
    ubyte        bNumEntries;
    ushort       wFlags;
    PALETTEENTRY peNew;
}

struct AM_AC3_ERROR_CONCEALMENT
{
    BOOL fRepeatPreviousBlock;
    BOOL fErrorInCurrentBlock;
}

struct AM_AC3_ALTERNATE_AUDIO
{
    BOOL fStereo;
    uint DualMode;
}

struct AM_AC3_DOWNMIX
{
    BOOL fDownMix;
    BOOL fDolbySurround;
}

struct AM_AC3_BIT_STREAM_MODE
{
    int BitStreamMode;
}

struct AM_AC3_DIALOGUE_LEVEL
{
    uint DialogueLevel;
}

struct AM_AC3_ROOM_TYPE
{
    BOOL fLargeRoom;
}

struct AM_DVD_YUV
{
    ubyte Reserved;
    ubyte Y;
    ubyte U;
    ubyte V;
}

struct AM_PROPERTY_SPPAL
{
    AM_DVD_YUV[16] sppal;
}

struct AM_COLCON
{
    ubyte _bitfield1;
    ubyte _bitfield2;
    ubyte _bitfield3;
    ubyte _bitfield4;
}

struct AM_PROPERTY_SPHLI
{
    ushort    HLISS;
    ushort    Reserved;
    uint      StartPTM;
    uint      EndPTM;
    ushort    StartX;
    ushort    StartY;
    ushort    StopX;
    ushort    StopY;
    AM_COLCON ColCon;
}

struct AM_DVDCOPY_CHLGKEY
{
    ubyte[10] ChlgKey;
    ubyte[2]  Reserved;
}

struct AM_DVDCOPY_BUSKEY
{
    ubyte[5] BusKey;
    ubyte[1] Reserved;
}

struct AM_DVDCOPY_DISCKEY
{
    ubyte[2048] DiscKey;
}

struct AM_DVDCOPY_TITLEKEY
{
    uint     KeyFlags;
    uint[2]  Reserved1;
    ubyte[6] TitleKey;
    ubyte[2] Reserved2;
}

struct AM_COPY_MACROVISION
{
    uint MACROVISIONLevel;
}

struct AM_DVDCOPY_SET_COPY_STATE
{
    uint DVDCopyState;
}

struct DVD_REGION
{
    ubyte CopySystem;
    ubyte RegionData;
    ubyte SystemRegion;
    ubyte ResetCount;
}

struct VIDEOINFOHEADER2
{
    RECT             rcSource;
    RECT             rcTarget;
    uint             dwBitRate;
    uint             dwBitErrorRate;
    long             AvgTimePerFrame;
    uint             dwInterlaceFlags;
    uint             dwCopyProtectFlags;
    uint             dwPictAspectRatioX;
    uint             dwPictAspectRatioY;
    union
    {
        uint dwControlFlags;
        uint dwReserved1;
    }
    uint             dwReserved2;
    BITMAPINFOHEADER bmiHeader;
}

struct MPEG2VIDEOINFO
{
    VIDEOINFOHEADER2 hdr;
    uint             dwStartTimeCode;
    uint             cbSequenceHeader;
    uint             dwProfile;
    uint             dwLevel;
    uint             dwFlags;
    uint[1]          dwSequenceHeader;
}

struct AM_DvdKaraokeData
{
    uint dwDownmix;
    uint dwSpeakerAssignment;
}

struct AM_SimpleRateChange
{
    long StartTime;
    int  Rate;
}

struct AM_QueryRate
{
    int lMaxForwardFullFrame;
    int lMaxReverseFullFrame;
}

struct AM_ExactRateChange
{
    long OutputZeroTime;
    int  Rate;
}

struct AM_DVD_ChangeRate
{
    long StartInTime;
    long StartOutTime;
    int  Rate;
}

struct MP_PARAMINFO
{
    MP_TYPE    mpType;
    uint       mopCaps;
    float      mpdMinValue;
    float      mpdMaxValue;
    float      mpdNeutralValue;
    ushort[32] szUnitText;
    ushort[32] szLabel;
}

struct MP_ENVELOPE_SEGMENT
{
    long          rtStart;
    long          rtEnd;
    float         valStart;
    float         valEnd;
    MP_CURVE_TYPE iCurve;
    uint          flags;
}

struct DMO_PARTIAL_MEDIATYPE
{
    GUID type;
    GUID subtype;
}

struct KSTOPOLOGY_CONNECTION
{
    uint FromNode;
    uint FromNodePin;
    uint ToNode;
    uint ToNodePin;
}

union TIMECODE
{
    struct
    {
        ushort wFrameRate;
        ushort wFrameFract;
        uint   dwFrames;
    }
    ulong qw;
}

struct TIMECODE_SAMPLE
{
    long     qwTick;
    TIMECODE timecode;
    uint     dwUser;
    uint     dwFlags;
}

struct __MIDL___MIDL_itf_encdec_0000_0000_0001
{
align (1):
    ushort[25] wszKID;
    ulong      qwCounter;
    ulong      qwIndex;
    ubyte      bOffset;
}

struct __MIDL___MIDL_itf_encdec_0000_0000_0002
{
align (1):
    HRESULT hrReason;
}

struct STREAMBUFFER_ATTRIBUTE
{
    const(wchar)* pszName;
    STREAMBUFFER_ATTR_DATATYPE StreamBufferAttributeType;
    ubyte*        pbAttribute;
    ushort        cbLength;
}

struct SBE_PIN_DATA
{
    ulong cDataBytes;
    ulong cSamplesProcessed;
    ulong cDiscontinuities;
    ulong cSyncPoints;
    ulong cTimestamps;
}

struct SBE2_STREAM_DESC
{
    uint Version;
    uint StreamId;
    uint Default;
    uint Reserved;
}

struct DVR_STREAM_DESC
{
    uint          Version;
    uint          StreamId;
    BOOL          Default;
    BOOL          Creation;
    uint          Reserved;
    GUID          guidSubMediaType;
    GUID          guidFormatType;
    AM_MEDIA_TYPE MediaType;
}

struct __MIDL___MIDL_itf_mpeg2structs_0000_0000_0001
{
align (1):
    ushort Bits;
}

struct __MIDL___MIDL_itf_mpeg2structs_0000_0000_0002
{
align (1):
    ushort Bits;
}

struct __MIDL___MIDL_itf_mpeg2structs_0000_0000_0003
{
    ubyte Bits;
}

struct __MIDL___MIDL_itf_mpeg2structs_0000_0000_0005
{
align (1):
    ushort wTidExt;
    ushort wCount;
}

struct SECTION
{
    ubyte    TableId;
    union Header
    {
    align (1):
        __MIDL___MIDL_itf_mpeg2structs_0000_0000_0002 S;
        ushort W;
    }
    ubyte[1] SectionData;
}

struct LONG_SECTION
{
align (1):
    ubyte    TableId;
    union Header
    {
    align (1):
        __MIDL___MIDL_itf_mpeg2structs_0000_0000_0002 S;
        ushort W;
    }
    ushort   TableIdExtension;
    union Version
    {
        __MIDL___MIDL_itf_mpeg2structs_0000_0000_0003 S;
        ubyte B;
    }
    ubyte    SectionNumber;
    ubyte    LastSectionNumber;
    ubyte[1] RemainingData;
}

struct DSMCC_SECTION
{
align (1):
    ubyte    TableId;
    union Header
    {
    align (1):
        __MIDL___MIDL_itf_mpeg2structs_0000_0000_0002 S;
        ushort W;
    }
    ushort   TableIdExtension;
    union Version
    {
        __MIDL___MIDL_itf_mpeg2structs_0000_0000_0003 S;
        ubyte B;
    }
    ubyte    SectionNumber;
    ubyte    LastSectionNumber;
    ubyte    ProtocolDiscriminator;
    ubyte    DsmccType;
    ushort   MessageId;
    uint     TransactionId;
    ubyte    Reserved;
    ubyte    AdaptationLength;
    ushort   MessageLength;
    ubyte[1] RemainingData;
}

struct MPEG_RQST_PACKET
{
align (1):
    uint     dwLength;
    SECTION* pSection;
}

struct MPEG_PACKET_LIST
{
align (1):
    ushort               wPacketCount;
    MPEG_RQST_PACKET[1]* PacketList;
}

struct DSMCC_FILTER_OPTIONS
{
align (1):
    BOOL   fSpecifyProtocol;
    ubyte  Protocol;
    BOOL   fSpecifyType;
    ubyte  Type;
    BOOL   fSpecifyMessageId;
    ushort MessageId;
    BOOL   fSpecifyTransactionId;
    BOOL   fUseTrxIdMessageIdMask;
    uint   TransactionId;
    BOOL   fSpecifyModuleVersion;
    ubyte  ModuleVersion;
    BOOL   fSpecifyBlockNumber;
    ushort BlockNumber;
    BOOL   fGetModuleCall;
    ushort NumberOfBlocksInModule;
}

struct ATSC_FILTER_OPTIONS
{
align (1):
    BOOL fSpecifyEtmId;
    uint EtmId;
}

struct DVB_EIT_FILTER_OPTIONS
{
align (1):
    BOOL  fSpecifySegment;
    ubyte bSegment;
}

struct MPEG2_FILTER
{
align (1):
    ubyte                bVersionNumber;
    ushort               wFilterSize;
    BOOL                 fUseRawFilteringBits;
    ubyte[16]            Filter;
    ubyte[16]            Mask;
    BOOL                 fSpecifyTableIdExtension;
    ushort               TableIdExtension;
    BOOL                 fSpecifyVersion;
    ubyte                Version;
    BOOL                 fSpecifySectionNumber;
    ubyte                SectionNumber;
    BOOL                 fSpecifyCurrentNext;
    BOOL                 fNext;
    BOOL                 fSpecifyDsmccOptions;
    DSMCC_FILTER_OPTIONS Dsmcc;
    BOOL                 fSpecifyAtscOptions;
    ATSC_FILTER_OPTIONS  Atsc;
}

struct MPEG2_FILTER2
{
align (1):
    union
    {
        struct
        {
        align (1):
            ubyte                bVersionNumber;
            ushort               wFilterSize;
            BOOL                 fUseRawFilteringBits;
            ubyte[16]            Filter;
            ubyte[16]            Mask;
            BOOL                 fSpecifyTableIdExtension;
            ushort               TableIdExtension;
            BOOL                 fSpecifyVersion;
            ubyte                Version;
            BOOL                 fSpecifySectionNumber;
            ubyte                SectionNumber;
            BOOL                 fSpecifyCurrentNext;
            BOOL                 fNext;
            BOOL                 fSpecifyDsmccOptions;
            DSMCC_FILTER_OPTIONS Dsmcc;
            BOOL                 fSpecifyAtscOptions;
            ATSC_FILTER_OPTIONS  Atsc;
        }
        ubyte[124] bVersion1Bytes;
    }
    BOOL fSpecifyDvbEitOptions;
    DVB_EIT_FILTER_OPTIONS DvbEit;
}

struct MPEG_STREAM_BUFFER
{
align (1):
    HRESULT hr;
    uint    dwDataBufferSize;
    uint    dwSizeOfDataRead;
    ubyte*  pDataBuffer;
}

struct MPEG_TIME
{
    ubyte Hours;
    ubyte Minutes;
    ubyte Seconds;
}

struct MPEG_DATE
{
align (1):
    ubyte  Date;
    ubyte  Month;
    ushort Year;
}

struct MPEG_DATE_AND_TIME
{
    MPEG_DATE D;
    MPEG_TIME T;
}

struct MPEG_BCS_DEMUX
{
align (1):
    uint AVMGraphId;
}

struct MPEG_WINSOCK
{
align (1):
    uint AVMGraphId;
}

struct MPEG_CONTEXT
{
align (1):
    MPEG_CONTEXT_TYPE Type;
    union U
    {
        MPEG_BCS_DEMUX Demux;
        MPEG_WINSOCK   Winsock;
    }
}

struct __MIDL___MIDL_itf_mpeg2structs_0000_0000_0033
{
align (1):
    MPEG_REQUEST_TYPE Type;
    MPEG_CONTEXT      Context;
    ushort            Pid;
    ubyte             TableId;
    MPEG2_FILTER      Filter;
    uint              Flags;
}

struct __MIDL___MIDL_itf_mpeg2structs_0000_0000_0034
{
align (1):
    uint   IPAddress;
    ushort Port;
}

struct DSMCC_ELEMENT
{
align (1):
    ushort         pid;
    ubyte          bComponentTag;
    uint           dwCarouselId;
    uint           dwTransactionId;
    DSMCC_ELEMENT* pNext;
}

struct MPE_ELEMENT
{
align (1):
    ushort       pid;
    ubyte        bComponentTag;
    MPE_ELEMENT* pNext;
}

struct MPEG_STREAM_FILTER
{
align (1):
    ushort    wPidValue;
    uint      dwFilterSize;
    BOOL      fCrcEnabled;
    ubyte[16] rgchFilter;
    ubyte[16] rgchMask;
}

struct Mpeg2TableSampleHdr
{
align (1):
    ubyte    SectionCount;
    ubyte[3] Reserved;
    int[1]   SectionOffsets;
}

struct __MIDL_IPAT_0001
{
    ushort wProgramNumber;
    ushort wProgramMapPID;
}

struct UDCR_TAG
{
    ubyte     bVersion;
    ubyte[25] KID;
    ulong     ullBaseCounter;
    ulong     ullBaseCounterRange;
    BOOL      fScrambled;
    ubyte     bStreamMark;
    uint      dwReserved1;
    uint      dwReserved2;
}

struct PIC_SEQ_SAMPLE
{
    uint _bitfield15;
}

struct SAMPLE_SEQ_OFFSET
{
    uint _bitfield16;
}

struct VA_OPTIONAL_VIDEO_PROPERTIES
{
    ushort             dwPictureHeight;
    ushort             dwPictureWidth;
    ushort             dwAspectRatioX;
    ushort             dwAspectRatioY;
    VA_VIDEO_FORMAT    VAVideoFormat;
    VA_COLOR_PRIMARIES VAColorPrimaries;
    VA_TRANSFER_CHARACTERISTICS VATransferCharacteristics;
    VA_MATRIX_COEFFICIENTS VAMatrixCoefficients;
}

struct TRANSPORT_PROPERTIES
{
    uint PID;
    long PCR;
    union Fields
    {
        struct Others
        {
            long _bitfield17;
        }
        long Value;
    }
}

struct PBDA_TAG_ATTRIBUTE
{
    GUID     TableUUId;
    ubyte    TableId;
    ushort   VersionNo;
    uint     TableDataSize;
    ubyte[1] TableData;
}

struct CAPTURE_STREAMTIME
{
    long StreamTime;
}

struct DSHOW_STREAM_DESC
{
    uint VersionNo;
    uint StreamId;
    BOOL Default;
    BOOL Creation;
    uint Reserved;
}

struct SAMPLE_LIVE_STREAM_TIME
{
    ulong qwStreamTime;
    ulong qwLiveTime;
}

struct KSP_BDA_NODE_PIN
{
    KSIDENTIFIER Property;
    uint         ulNodeType;
    uint         ulInputPinId;
    uint         ulOutputPinId;
}

struct KSM_BDA_PIN
{
    KSIDENTIFIER Method;
    union
    {
        uint PinId;
        uint PinType;
    }
    uint         Reserved;
}

struct KSM_BDA_PIN_PAIR
{
    KSIDENTIFIER Method;
    union
    {
        uint InputPinId;
        uint InputPinType;
    }
    union
    {
        uint OutputPinId;
        uint OutputPinType;
    }
}

struct KSP_NODE_ESPID
{
    KSP_NODE Property;
    uint     EsPid;
}

struct KSM_BDA_DEBUG_LEVEL
{
    KSIDENTIFIER Method;
    ubyte        ucDebugLevel;
    uint         ulDebugStringSize;
    ubyte[1]     argbDebugString;
}

struct BDA_DEBUG_DATA
{
    int      lResult;
    GUID     uuidDebugDataType;
    uint     ulDataSize;
    ubyte[1] argbDebugData;
}

struct BDA_EVENT_DATA
{
    int      lResult;
    uint     ulEventID;
    GUID     uuidEventType;
    uint     ulEventDataLength;
    ubyte[1] argbEventData;
}

struct KSM_BDA_EVENT_COMPLETE
{
    KSIDENTIFIER Method;
    uint         ulEventID;
    uint         ulEventResult;
}

struct KSM_BDA_DRM_SETDRM
{
    KSM_NODE NodeMethod;
    GUID     NewDRMuuid;
}

struct KSM_BDA_BUFFER
{
    KSM_NODE NodeMethod;
    uint     ulBufferSize;
    ubyte[1] argbBuffer;
}

struct KSM_BDA_WMDRM_LICENSE
{
    KSM_NODE NodeMethod;
    GUID     uuidKeyID;
}

struct KSM_BDA_WMDRM_RENEWLICENSE
{
    KSM_NODE NodeMethod;
    uint     ulXMRLicenseLength;
    uint     ulEntitlementTokenLength;
    ubyte[1] argbDataBuffer;
}

struct KSM_BDA_WMDRMTUNER_PURCHASEENTITLEMENT
{
    KSM_NODE NodeMethod;
    uint     ulDialogRequest;
    byte[12] cLanguage;
    uint     ulPurchaseTokenLength;
    ubyte[1] argbDataBuffer;
}

struct KSM_BDA_WMDRMTUNER_SETPIDPROTECTION
{
    KSM_NODE NodeMethod;
    uint     ulPID;
    GUID     uuidKeyID;
}

struct KSM_BDA_WMDRMTUNER_GETPIDPROTECTION
{
    KSM_NODE NodeMethod;
    uint     ulPID;
}

struct KSM_BDA_WMDRMTUNER_SYNCVALUE
{
    KSM_NODE NodeMethod;
    uint     ulSyncValue;
}

struct KSM_BDA_TUNER_TUNEREQUEST
{
    KSIDENTIFIER Method;
    uint         ulTuneLength;
    ubyte[1]     argbTuneData;
}

struct KSM_BDA_GPNV_GETVALUE
{
    KSIDENTIFIER Method;
    uint         ulNameLength;
    byte[12]     cLanguage;
    ubyte[1]     argbData;
}

struct KSM_BDA_GPNV_SETVALUE
{
    KSIDENTIFIER Method;
    uint         ulDialogRequest;
    byte[12]     cLanguage;
    uint         ulNameLength;
    uint         ulValueLength;
    ubyte[1]     argbName;
}

struct KSM_BDA_GPNV_NAMEINDEX
{
    KSIDENTIFIER Method;
    uint         ulValueNameIndex;
}

struct KSM_BDA_SCAN_CAPABILTIES
{
    KSIDENTIFIER Method;
    GUID         uuidBroadcastStandard;
}

struct KSM_BDA_SCAN_FILTER
{
    KSIDENTIFIER Method;
    uint         ulScanModulationTypeSize;
    ulong        AnalogVideoStandards;
    ubyte[1]     argbScanModulationTypes;
}

struct KSM_BDA_SCAN_START
{
    KSIDENTIFIER Method;
    uint         LowerFrequency;
    uint         HigherFrequency;
}

struct KSM_BDA_GDDS_TUNEXMLFROMIDX
{
    KSIDENTIFIER Method;
    ulong        ulIdx;
}

struct KSM_BDA_GDDS_SERVICEFROMTUNEXML
{
    KSIDENTIFIER Method;
    uint         ulTuneXmlLength;
    ubyte[1]     argbTuneXml;
}

struct KSM_BDA_USERACTIVITY_USEREASON
{
    KSIDENTIFIER Method;
    uint         ulUseReason;
}

struct KSM_BDA_CAS_ENTITLEMENTTOKEN
{
    KSM_NODE NodeMethod;
    uint     ulDialogRequest;
    byte[12] cLanguage;
    uint     ulRequestType;
    uint     ulEntitlementTokenLen;
    ubyte[1] argbEntitlementToken;
}

struct KSM_BDA_CAS_CAPTURETOKEN
{
    KSM_NODE NodeMethod;
    uint     ulTokenLength;
    ubyte[1] argbToken;
}

struct KSM_BDA_CAS_OPENBROADCASTMMI
{
    KSM_NODE NodeMethod;
    uint     ulDialogRequest;
    byte[12] cLanguage;
    uint     ulEventId;
}

struct KSM_BDA_CAS_CLOSEMMIDIALOG
{
    KSM_NODE NodeMethod;
    uint     ulDialogRequest;
    byte[12] cLanguage;
    uint     ulDialogNumber;
    uint     ulReason;
}

struct KSM_BDA_ISDBCAS_REQUEST
{
    KSM_NODE NodeMethod;
    uint     ulRequestID;
    uint     ulIsdbCommandSize;
    ubyte[1] argbIsdbCommandData;
}

struct KSM_BDA_TS_SELECTOR_SETTSID
{
    KSM_NODE NodeMethod;
    ushort   usTSID;
}

struct KS_DATARANGE_BDA_ANTENNA
{
    KSDATAFORMAT DataRange;
}

struct BDA_TRANSPORT_INFO
{
    uint ulcbPhyiscalPacket;
    uint ulcbPhyiscalFrame;
    uint ulcbPhyiscalFrameAlignment;
    long AvgTimePerFrame;
}

struct KS_DATARANGE_BDA_TRANSPORT
{
    KSDATAFORMAT       DataRange;
    BDA_TRANSPORT_INFO BdaTransportInfo;
}

struct ChannelChangeInfo
{
    ChannelChangeSpanningEvent_State state;
    ulong TimeStamp;
}

struct ChannelTypeInfo
{
    ChannelType channelType;
    ulong       timeStamp;
}

struct ChannelInfo
{
    int lFrequency;
    union
    {
        struct DVB
        {
            int lONID;
            int lTSID;
            int lSID;
        }
        struct DC
        {
            int lProgNumber;
        }
        struct ATSC
        {
            int lProgNumber;
        }
    }
}

struct SpanningEventDescriptor
{
    ushort   wDataLen;
    ushort   wProgNumber;
    ushort   wSID;
    ubyte[1] bDescriptor;
}

struct DVBScramblingControlSpanningEvent
{
    uint ulPID;
    BOOL fScrambled;
}

struct SpanningEventEmmMessage
{
    ubyte     bCAbroadcasterGroupId;
    ubyte     bMessageControl;
    ushort    wServiceId;
    ushort    wTableIdExtension;
    ubyte     bDeletionStatus;
    ubyte     bDisplayingDuration1;
    ubyte     bDisplayingDuration2;
    ubyte     bDisplayingDuration3;
    ubyte     bDisplayingCycle;
    ubyte     bFormatVersion;
    ubyte     bDisplayPosition;
    ushort    wMessageLength;
    ushort[1] szMessageArea;
}

struct LanguageInfo
{
    ushort LangID;
    int    lISOLangCode;
}

struct DualMonoInfo
{
    ushort LangID1;
    ushort LangID2;
    int    lISOLangCode1;
    int    lISOLangCode2;
}

struct PIDListSpanningEvent
{
    ushort  wPIDCount;
    uint[1] pulPIDs;
}

struct RATING_ATTRIBUTE
{
align (1):
    uint rating_attribute_id;
    uint rating_attribute_value;
}

struct RATING_SYSTEM
{
align (1):
    GUID              rating_system_id;
    ubyte             _bitfield18;
    ubyte[3]          country_code;
    uint              rating_attribute_count;
    RATING_ATTRIBUTE* lpratingattrib;
}

struct RATING_INFO
{
align (1):
    uint           rating_system_count;
    RATING_SYSTEM* lpratingsystem;
}

struct PBDAParentalControl
{
align (1):
    uint           rating_system_count;
    RATING_SYSTEM* rating_systems;
}

struct DvbParentalRatingParam
{
    byte[4] szCountryCode;
    ubyte   bRating;
}

struct DvbParentalRatingDescriptor
{
    uint ulNumParams;
    DvbParentalRatingParam[1] pParams;
}

struct KSPROPERTY_BDA_RF_TUNER_CAPS_S
{
    KSP_NODE Property;
    uint     Mode;
    uint     AnalogStandardsSupported;
    uint     DigitalStandardsSupported;
    uint     MinFrequency;
    uint     MaxFrequency;
    uint     SettlingTime;
    uint     AnalogSensingRange;
    uint     DigitalSensingRange;
    uint     MilliSecondsPerMHz;
}

struct KSPROPERTY_BDA_RF_TUNER_SCAN_STATUS_S
{
    KSP_NODE Property;
    uint     CurrentFrequency;
    uint     FrequencyRangeMin;
    uint     FrequencyRangeMax;
    uint     MilliSecondsLeft;
}

struct KSPROPERTY_BDA_RF_TUNER_STANDARD_S
{
    KSP_NODE       Property;
    _BdaSignalType SignalType;
    uint           SignalStandard;
}

struct KSPROPERTY_BDA_RF_TUNER_STANDARD_MODE_S
{
    KSP_NODE Property;
    BOOL     AutoDetect;
}

struct KSEVENTDATA_BDA_RF_TUNER_SCAN_S
{
    KSEVENTDATA  EventData;
    uint         StartFrequency;
    uint         EndFrequency;
    _BdaLockType LockRequested;
}

struct PID_BITS
{
align (1):
    ushort _bitfield19;
}

struct MPEG_HEADER_BITS
{
align (1):
    ushort _bitfield20;
}

struct MPEG_HEADER_VERSION_BITS
{
    ubyte _bitfield21;
}

struct MPEG1WAVEFORMAT
{
align (1):
    WAVEFORMATEX wfx;
    ushort       fwHeadLayer;
    uint         dwHeadBitrate;
    ushort       fwHeadMode;
    ushort       fwHeadModeExt;
    ushort       wHeadEmphasis;
    ushort       fwHeadFlags;
    uint         dwPTSLow;
    uint         dwPTSHigh;
}

struct MPEGLAYER3WAVEFORMAT
{
align (1):
    WAVEFORMATEX wfx;
    ushort       wID;
    uint         fdwFlags;
    ushort       nBlockSize;
    ushort       nFramesPerBlock;
    ushort       nCodecDelay;
}

struct HEAACWAVEINFO
{
align (1):
    WAVEFORMATEX wfx;
    ushort       wPayloadType;
    ushort       wAudioProfileLevelIndication;
    ushort       wStructType;
    ushort       wReserved1;
    uint         dwReserved2;
}

struct HEAACWAVEFORMAT
{
    HEAACWAVEINFO wfInfo;
    ubyte[1]      pbAudioSpecificConfig;
}

struct DMO_MEDIA_TYPE
{
    GUID     majortype;
    GUID     subtype;
    BOOL     bFixedSizeSamples;
    BOOL     bTemporalCompression;
    uint     lSampleSize;
    GUID     formattype;
    IUnknown pUnk;
    uint     cbFormat;
    ubyte*   pbFormat;
}

struct DMO_OUTPUT_DATA_BUFFER
{
    IMediaBuffer pBuffer;
    uint         dwStatus;
    long         rtTimestamp;
    long         rtTimelength;
}

struct DXVA_COPPSetProtectionLevelCmdData
{
    uint ProtType;
    uint ProtLevel;
    uint ExtendedInfoChangeMask;
    uint ExtendedInfoData;
}

struct DXVA_COPPSetSignalingCmdData
{
    uint    ActiveTVProtectionStandard;
    uint    AspectRatioChangeMask1;
    uint    AspectRatioData1;
    uint    AspectRatioChangeMask2;
    uint    AspectRatioData2;
    uint    AspectRatioChangeMask3;
    uint    AspectRatioData3;
    uint[4] ExtendedInfoChangeMask;
    uint[4] ExtendedInfoData;
    uint    Reserved;
}

struct DXVA_COPPStatusData
{
    GUID rApp;
    uint dwFlags;
    uint dwData;
    uint ExtendedInfoValidMask;
    uint ExtendedInfoData;
}

struct DXVA_COPPStatusDisplayData
{
    GUID rApp;
    uint dwFlags;
    uint DisplayWidth;
    uint DisplayHeight;
    uint Format;
    uint d3dFormat;
    uint FreqNumerator;
    uint FreqDenominator;
}

struct DXVA_COPPStatusHDCPKeyData
{
    GUID rApp;
    uint dwFlags;
    uint dwHDCPFlags;
    GUID BKey;
    GUID Reserved1;
    GUID Reserved2;
}

struct DXVA_COPPStatusSignalingCmdData
{
    GUID    rApp;
    uint    dwFlags;
    uint    AvailableTVProtectionStandards;
    uint    ActiveTVProtectionStandard;
    uint    TVType;
    uint    AspectRatioValidMask1;
    uint    AspectRatioData1;
    uint    AspectRatioValidMask2;
    uint    AspectRatioData2;
    uint    AspectRatioValidMask3;
    uint    AspectRatioData3;
    uint[4] ExtendedInfoValidMask;
    uint[4] ExtendedInfoData;
}

struct DDCOLORKEY
{
    uint dwColorSpaceLowValue;
    uint dwColorSpaceHighValue;
}

// Functions

@DllImport("QUARTZ")
uint AMGetErrorTextA(HRESULT hr, const(char)* pbuffer, uint MaxLen);

@DllImport("QUARTZ")
uint AMGetErrorTextW(HRESULT hr, const(wchar)* pbuffer, uint MaxLen);

@DllImport("msdmo")
HRESULT DMORegister(const(wchar)* szName, const(GUID)* clsidDMO, const(GUID)* guidCategory, uint dwFlags, 
                    uint cInTypes, const(DMO_PARTIAL_MEDIATYPE)* pInTypes, uint cOutTypes, 
                    const(DMO_PARTIAL_MEDIATYPE)* pOutTypes);

@DllImport("msdmo")
HRESULT DMOUnregister(const(GUID)* clsidDMO, const(GUID)* guidCategory);

@DllImport("msdmo")
HRESULT DMOEnum(const(GUID)* guidCategory, uint dwFlags, uint cInTypes, const(DMO_PARTIAL_MEDIATYPE)* pInTypes, 
                uint cOutTypes, const(DMO_PARTIAL_MEDIATYPE)* pOutTypes, IEnumDMO* ppEnum);

@DllImport("msdmo")
HRESULT DMOGetTypes(const(GUID)* clsidDMO, uint ulInputTypesRequested, uint* pulInputTypesSupplied, 
                    DMO_PARTIAL_MEDIATYPE* pInputTypes, uint ulOutputTypesRequested, uint* pulOutputTypesSupplied, 
                    DMO_PARTIAL_MEDIATYPE* pOutputTypes);

@DllImport("msdmo")
HRESULT DMOGetName(const(GUID)* clsidDMO, char* szName);

@DllImport("msdmo")
HRESULT MoInitMediaType(AM_MEDIA_TYPE* pmt, uint cbFormat);

@DllImport("msdmo")
HRESULT MoFreeMediaType(AM_MEDIA_TYPE* pmt);

@DllImport("msdmo")
HRESULT MoCopyMediaType(AM_MEDIA_TYPE* pmtDest, const(AM_MEDIA_TYPE)* pmtSrc);

@DllImport("msdmo")
HRESULT MoCreateMediaType(AM_MEDIA_TYPE** ppmt, uint cbFormat);

@DllImport("msdmo")
HRESULT MoDeleteMediaType(AM_MEDIA_TYPE* pmt);

@DllImport("msdmo")
HRESULT MoDuplicateMediaType(AM_MEDIA_TYPE** ppmtDest, const(AM_MEDIA_TYPE)* pmtSrc);


// Interfaces

@GUID("E436EBB3-524F-11CE-9F53-0020AF0BA770")
struct FilgraphManager;

@GUID("17CCA71B-ECD7-11D0-B908-00A0C9223196")
struct CLSID_Proxy;

@GUID("D02AAC50-027E-11D3-9D8E-00C04F72D980")
struct SystemTuningSpaces;

@GUID("5FFDC5E6-B83A-4B55-B6E8-C69E765FE9DB")
struct TuningSpace;

@GUID("CC829A2F-3365-463F-AF13-81DBB6F3A555")
struct ChannelIDTuningSpace;

@GUID("A2E30750-6C3D-11D3-B653-00C04F79498E")
struct ATSCTuningSpace;

@GUID("D9BB4CEE-B87A-47F1-AC92-B08D9C7813FC")
struct DigitalCableTuningSpace;

@GUID("8A674B4C-1F63-11D3-B64C-00C04F79498E")
struct AnalogRadioTuningSpace;

@GUID("F9769A06-7ACA-4E39-9CFB-97BB35F0E77E")
struct AuxInTuningSpace;

@GUID("8A674B4D-1F63-11D3-B64C-00C04F79498E")
struct AnalogTVTuningSpace;

@GUID("C6B14B32-76AA-4A86-A7AC-5C79AAF58DA7")
struct DVBTuningSpace;

@GUID("B64016F3-C9A2-4066-96F0-BD9563314726")
struct DVBSTuningSpace;

@GUID("A1A2B1C4-0E3A-11D3-9D8E-00C04F72D980")
struct ComponentTypes;

@GUID("823535A0-0318-11D3-9D8E-00C04F72D980")
struct ComponentType;

@GUID("1BE49F30-0E1B-11D3-9D8E-00C04F72D980")
struct LanguageComponentType;

@GUID("418008F3-CF67-4668-9628-10DC52BE1D08")
struct MPEG2ComponentType;

@GUID("A8DCF3D5-0780-4EF4-8A83-2CFFAACB8ACE")
struct ATSCComponentType;

@GUID("809B6661-94C4-49E6-B6EC-3F0F862215AA")
struct Components;

@GUID("59DC47A8-116C-11D3-9D8E-00C04F72D980")
struct Component;

@GUID("055CB2D7-2969-45CD-914B-76890722F112")
struct MPEG2Component;

@GUID("28AB0005-E845-4FFA-AA9B-F4665236141C")
struct AnalogAudioComponentType;

@GUID("B46E0D38-AB35-4A06-A137-70576B01B39F")
struct TuneRequest;

@GUID("3A9428A7-31A4-45E9-9EFB-E055BF7BB3DB")
struct ChannelIDTuneRequest;

@GUID("0369B4E5-45B6-11D3-B650-00C04F79498E")
struct ChannelTuneRequest;

@GUID("0369B4E6-45B6-11D3-B650-00C04F79498E")
struct ATSCChannelTuneRequest;

@GUID("26EC0B63-AA90-458A-8DF4-5659F2C8A18A")
struct DigitalCableTuneRequest;

@GUID("0955AC62-BF2E-4CBA-A2B9-A63F772D46CF")
struct MPEG2TuneRequest;

@GUID("2C63E4EB-4CEA-41B8-919C-E947EA19A77C")
struct MPEG2TuneRequestFactory;

@GUID("0888C883-AC4F-4943-B516-2C38D9B34562")
struct Locator;

@GUID("6E50CC0D-C19B-4BF6-810B-5BD60761F5CC")
struct DigitalLocator;

@GUID("49638B91-48AB-48B7-A47A-7D0E75A08EDE")
struct AnalogLocator;

@GUID("8872FF1B-98FA-4D7A-8D93-C9F1055F85BB")
struct ATSCLocator;

@GUID("03C06416-D127-407A-AB4C-FDD279ABBE5D")
struct DigitalCableLocator;

@GUID("9CD64701-BDF3-4D14-8E03-F12983D86664")
struct DVBTLocator;

@GUID("EFE3FA02-45D7-4920-BE96-53FA7F35B0E6")
struct DVBTLocator2;

@GUID("1DF7D126-4050-47F0-A7CF-4C4CA9241333")
struct DVBSLocator;

@GUID("C531D9FD-9685-4028-8B68-6E1232079F1E")
struct DVBCLocator;

@GUID("6504AFED-A629-455C-A7F1-04964DEA5CC4")
struct ISDBSLocator;

@GUID("15D6504A-5494-499C-886C-973C9E53B9F1")
struct DVBTuneRequest;

@GUID("8A674B49-1F63-11D3-B64C-00C04F79498E")
struct CreatePropBagOnRegKey;

@GUID("0B3FFB92-0919-4934-9D5B-619C719D0202")
struct BroadcastEventService;

@GUID("6438570B-0C08-4A25-9504-8012BB4D50CF")
struct TunerMarshaler;

@GUID("E77026B0-B97F-4CBB-B7FB-F4F03AD69F11")
struct PersistTuneXmlUtility;

@GUID("C20447FC-EC60-475E-813F-D2B0A6DECEFE")
struct ESEventService;

@GUID("8E8A07DA-71F8-40C1-A929-5E3A868AC2C6")
struct ESEventFactory;

@GUID("C5C5C5F0-3ABC-11D6-B25B-00C04FA0C026")
struct XDSToRat;

@GUID("C5C5C5F1-3ABC-11D6-B25B-00C04FA0C026")
struct EvalRat;

@GUID("C4C4C4F1-0049-4E2B-98FB-9537F6CE516D")
struct ETFilter;

@GUID("C4C4C4F2-0049-4E2B-98FB-9537F6CE516D")
struct DTFilter;

@GUID("C4C4C4F3-0049-4E2B-98FB-9537F6CE516D")
struct XDSCodec;

@GUID("C4C4C4F4-0049-4E2B-98FB-9537F6CE516D")
struct CXDSData;

@GUID("1C15D484-911D-11D2-B632-00C04F79498E")
struct MSVidAnalogTunerDevice;

@GUID("A2E3074E-6C3D-11D3-B653-00C04F79498E")
struct MSVidBDATunerDevice;

@GUID("37B0353C-A4C8-11D2-B634-00C04F79498E")
struct MSVidFilePlaybackDevice;

@GUID("011B3619-FE63-4814-8A84-15A194CE9CE3")
struct MSVidWebDVD;

@GUID("FA7C375B-66A7-4280-879D-FD459C84BB02")
struct MSVidWebDVDAdm;

@GUID("37B03543-A4C8-11D2-B634-00C04F79498E")
struct MSVidVideoRenderer;

@GUID("24DC3975-09BF-4231-8655-3EE71F43837D")
struct MSVidVMR9;

@GUID("C45268A2-FA81-4E19-B1E3-72EDBD60AEDA")
struct MSVidEVR;

@GUID("37B03544-A4C8-11D2-B634-00C04F79498E")
struct MSVidAudioRenderer;

@GUID("4A5869CF-929D-4040-AE03-FCAFC5B9CD42")
struct MSVidGenericSink;

@GUID("9E77AAC4-35E5-42A1-BDC2-8F3FF399847C")
struct MSVidStreamBufferSink;

@GUID("AD8E510D-217F-409B-8076-29C5E73B98E8")
struct MSVidStreamBufferSource;

@GUID("FD351EA1-4173-4AF4-821D-80D4AE979048")
struct MSVidStreamBufferV2Source;

@GUID("BB530C63-D9DF-4B49-9439-63453962E598")
struct MSVidEncoder;

@GUID("5740A302-EF0B-45CE-BF3B-4470A14A8980")
struct MSVidITVCapture;

@GUID("9E797ED0-5253-4243-A9B7-BD06C58F8EF3")
struct MSVidITVPlayback;

@GUID("86151827-E47B-45EE-8421-D10E6E690979")
struct MSVidCCA;

@GUID("7F9CB14D-48E4-43B6-9346-1AEBC39C64D3")
struct MSVidClosedCaptioning;

@GUID("92ED88BF-879E-448F-B6B6-A385BCEB846D")
struct MSVidClosedCaptioningSI;

@GUID("334125C0-77E5-11D3-B653-00C04F79498E")
struct MSVidDataServices;

@GUID("0149EEDF-D08F-4142-8D73-D23903D21E90")
struct MSVidXDS;

@GUID("C5702CD6-9B79-11D3-B654-00C04F79498E")
struct MSVidAnalogCaptureToDataServices;

@GUID("38F03426-E83B-4E68-B65B-DCAE73304838")
struct MSVidDataServicesToStreamBufferSink;

@GUID("0429EC6E-1144-4BED-B88B-2FB9899A4A3D")
struct MSVidDataServicesToXDS;

@GUID("3540D440-5B1D-49CB-821A-E84B8CF065A7")
struct MSVidAnalogCaptureToXDS;

@GUID("B0EDF163-910A-11D2-B632-00C04F79498E")
struct MSVidCtl;

@GUID("C5702CCC-9B79-11D3-B654-00C04F79498E")
struct MSVidInputDevices;

@GUID("C5702CCD-9B79-11D3-B654-00C04F79498E")
struct MSVidOutputDevices;

@GUID("C5702CCE-9B79-11D3-B654-00C04F79498E")
struct MSVidVideoRendererDevices;

@GUID("C5702CCF-9B79-11D3-B654-00C04F79498E")
struct MSVidAudioRendererDevices;

@GUID("C5702CD0-9B79-11D3-B654-00C04F79498E")
struct MSVidFeatures;

@GUID("2764BCE5-CC39-11D2-B639-00C04F79498E")
struct MSVidGenericComposite;

@GUID("E18AF75A-08AF-11D3-B64A-00C04F79498E")
struct MSVidAnalogCaptureToOverlayMixer;

@GUID("267DB0B3-55E3-4902-949B-DF8F5CEC0191")
struct MSVidWebDVDToVideoRenderer;

@GUID("8D04238E-9FD1-41C6-8DE3-9E1EE309E935")
struct MSVidWebDVDToAudioRenderer;

@GUID("6AD28EE1-5002-4E71-AAF7-BD077907B1A4")
struct MSVidMPEG2DecoderToClosedCaptioning;

@GUID("9F50E8B1-9530-4DDC-825E-1AF81D47AED6")
struct MSVidAnalogCaptureToStreamBufferSink;

@GUID("ABE40035-27C3-4A2F-8153-6624471608AF")
struct MSVidDigitalCaptureToStreamBufferSink;

@GUID("92B94828-1AF7-4E6E-9EBF-770657F77AF5")
struct MSVidITVToStreamBufferSink;

@GUID("3EF76D68-8661-4843-8B8F-C37163D8C9CE")
struct MSVidCCAToStreamBufferSink;

@GUID("A0B9B497-AFBC-45AD-A8A6-9B077C40D4F2")
struct MSVidEncoderToStreamBufferSink;

@GUID("B401C5EB-8457-427F-84EA-A4D2363364B0")
struct MSVidFilePlaybackToVideoRenderer;

@GUID("CC23F537-18D4-4ECE-93BD-207A84726979")
struct MSVidFilePlaybackToAudioRenderer;

@GUID("28953661-0231-41DB-8986-21FF4388EE9B")
struct MSVidAnalogTVToEncoder;

@GUID("3C4708DC-B181-46A8-8DA8-4AB0371758CD")
struct MSVidStreamBufferSourceToVideoRenderer;

@GUID("942B7909-A28E-49A1-A207-34EBCBCB4B3B")
struct MSVidAnalogCaptureToCCA;

@GUID("73D14237-B9DB-4EFA-A6DD-84350421FB2F")
struct MSVidDigitalCaptureToCCA;

@GUID("5D8E73F7-4989-4AC8-8A98-39BA0D325302")
struct MSVidDigitalCaptureToITV;

@GUID("2291478C-5EE3-4BEF-AB5D-B5FF2CF58352")
struct MSVidSBESourceToITV;

@GUID("9193A8F9-0CBA-400E-AA97-EB4709164576")
struct MSVidSBESourceToCC;

@GUID("991DA7E5-953F-435B-BE5E-B92A05EDFC42")
struct MSVidSBESourceToGenericSink;

@GUID("C4BF2784-AE00-41BA-9828-9C953BD3C54A")
struct MSVidCCToVMR;

@GUID("D76334CA-D89E-4BAF-86AB-DDB59372AFC2")
struct MSVidCCToAR;

@GUID("577FAA18-4518-445E-8F70-1473F8CF4BA4")
struct MSEventBinder;

@GUID("CAAFDD83-CEFC-4E3D-BA03-175F17A24F91")
struct MSVidStreamBufferRecordingControl;

@GUID("CB4276E6-7D5F-4CF1-9727-629C5E6DB6AE")
struct MSVidRect;

@GUID("6E40476F-9C49-4C3E-8BB9-8587958EFF74")
struct MSVidDevice;

@GUID("30997F7D-B3B5-4A1C-983A-1FE8098CB77D")
struct MSVidDevice2;

@GUID("AC1972F2-138A-4CA3-90DA-AE51112EDA28")
struct MSVidInputDevice;

@GUID("95F4820B-BB3A-4E2D-BC64-5B817BC2C30E")
struct MSVidVideoInputDevice;

@GUID("1990D634-1A5E-4071-A34A-53AAFFCE9F36")
struct MSVidVideoPlaybackDevice;

@GUID("7748530B-C08A-47EA-B24C-BE8695FF405F")
struct MSVidFeature;

@GUID("87EB890D-03AD-4E9D-9866-376E5EC572ED")
struct MSVidOutput;

@GUID("73DA5D04-4347-45D3-A9DC-FAE9DDBE558D")
struct SectionList;

@GUID("F91D96C7-8509-4D0B-AB26-A0DD10904BB7")
struct Mpeg2Stream;

@GUID("C666E115-BB62-4027-A113-82D643FE2D99")
struct Mpeg2Data;

@GUID("DBAF6C1B-B6A4-4898-AE65-204F0D9509A1")
struct Mpeg2DataLib;

@GUID("14EB8748-1753-4393-95AE-4F7E7A87AAD6")
struct TIFLoad;

@GUID("83183C03-C09E-45C4-A719-807A94952BF9")
struct EVENTID_TuningChanging;

@GUID("9D7E6235-4B7D-425D-A6D1-D717C33B9C4C")
struct EVENTID_TuningChanged;

@GUID("9F02D3D0-9F06-4369-9F1E-3AD6CA19807E")
struct EVENTID_CandidatePostTuneData;

@GUID("2A65C528-2249-4070-AC16-00390CDFB2DD")
struct EVENTID_CADenialCountChanged;

@GUID("6D9CFAF2-702D-4B01-8DFF-6892AD20D191")
struct EVENTID_SignalStatusChanged;

@GUID("C87EC52D-CD18-404A-A076-C02A273D3DE7")
struct EVENTID_NewSignalAcquired;

@GUID("D10DF9D5-C261-4B85-9E8A-517B3299CAB2")
struct EVENTID_EASMessageReceived;

@GUID("1B9C3703-D447-4E16-97BB-01799FC031ED")
struct EVENTID_PSITable;

@GUID("0A1D591C-E0D2-4F8E-8960-2335BEF45CCB")
struct EVENTID_ServiceTerminated;

@GUID("A265FAEA-F874-4B38-9FF7-C53D02969996")
struct EVENTID_CardStatusChanged;

@GUID("000906F5-F0D1-41D6-A7DF-4028697669F6")
struct EVENTID_DRMParingStatusChanged;

@GUID("5B2EBF78-B752-4420-B41E-A472DC95828E")
struct EVENTID_DRMParingStepComplete;

@GUID("052C29AF-09A4-4B93-890F-BD6A348968A4")
struct EVENTID_MMIMessage;

@GUID("9071AD5D-2359-4C95-8694-AFA81D70BFD5")
struct EVENTID_EntitlementChanged;

@GUID("17C4D730-D0F0-413A-8C99-500469DE35AD")
struct EVENTID_STBChannelNumber;

@GUID("5CA51711-5DDC-41A6-9430-E41B8B3BBC5B")
struct EVENTID_BDAEventingServicePendingEvent;

@GUID("EFC3A459-AE8B-4B4A-8FE9-79A0D097F3EA")
struct EVENTID_BDAConditionalAccessTAG;

@GUID("B2127D42-7BE5-4F4B-9130-6679899F4F4B")
struct EVENTTYPE_CASDescrambleFailureEvent;

@GUID("EAD831AE-5529-4D1F-AFCE-0D8CD1257D30")
struct EVENTID_CASFailureSpanningEvent;

@GUID("9067C5E5-4C5C-4205-86C8-7AFE20FE1EFA")
struct EVENTID_ChannelChangeSpanningEvent;

@GUID("72AB1D51-87D2-489B-BA11-0E08DC210243")
struct EVENTID_ChannelTypeSpanningEvent;

@GUID("41F36D80-4132-4CC2-B121-01A43219D81B")
struct EVENTID_ChannelInfoSpanningEvent;

@GUID("F6CFC8F4-DA93-4F2F-BFF8-BA1EE6FCA3A2")
struct EVENTID_RRTSpanningEvent;

@GUID("EFE779D9-97F0-4786-800D-95CF505DDC66")
struct EVENTID_CSDescriptorSpanningEvent;

@GUID("3AB4A2E6-4247-4B34-896C-30AFA5D21C24")
struct EVENTID_CtxADescriptorSpanningEvent;

@GUID("4BD4E1C4-90A1-4109-8236-27F00E7DCC5B")
struct EVENTID_DVBScramblingControlSpanningEvent;

@GUID("8068C5CB-3C04-492B-B47D-0308820DCE51")
struct EVENTID_SignalAndServiceStatusSpanningEvent;

@GUID("6BF00268-4F7E-4294-AA87-E9E953E43F14")
struct EVENTID_EmmMessageSpanningEvent;

@GUID("501CBFBE-B849-42CE-9BE9-3DB869FB82B3")
struct EVENTID_AudioTypeSpanningEvent;

@GUID("82AF2EBC-30A6-4264-A80B-AD2E1372AC60")
struct EVENTID_StreamTypeSpanningEvent;

@GUID("3A954083-93D0-463E-90B2-0742C496EDF0")
struct EVENTID_ARIBcontentSpanningEvent;

@GUID("E292666D-9C02-448D-AA8D-781A93FDC395")
struct EVENTID_LanguageSpanningEvent;

@GUID("A9A29B56-A84B-488C-89D5-0D4E7657C8CE")
struct EVENTID_DualMonoSpanningEvent;

@GUID("47FC8F65-E2BB-4634-9CEF-FDBFE6261D5C")
struct EVENTID_PIDListSpanningEvent;

@GUID("107BD41C-A6DA-4691-8369-11B2CDAA288E")
struct EVENTID_AudioDescriptorSpanningEvent;

@GUID("5DCEC048-D0B9-4163-872C-4F32223BE88A")
struct EVENTID_SubtitleSpanningEvent;

@GUID("9599D950-5F33-4617-AF7C-1E54B510DAA3")
struct EVENTID_TeletextSpanningEvent;

@GUID("CAF1AB68-E153-4D41-A6B3-A7C998DB75EE")
struct EVENTID_StreamIDSpanningEvent;

@GUID("F947AA85-FB52-48E8-B9C5-E1E1F411A51A")
struct EVENTID_PBDAParentalControlEvent;

@GUID("D97287B2-2DFD-436A-9485-99D7D4AB5A69")
struct EVENTID_TuneFailureEvent;

@GUID("6F8AA455-5EE1-48AB-A27C-4C8D70B9AEBA")
struct EVENTID_TuneFailureSpanningEvent;

@GUID("2A67A58D-ECA5-4EAC-ABCB-E734D3776D0A")
struct EVENTID_DvbParentalRatingDescriptor;

@GUID("F5689FFE-55F9-4BB3-96BE-AE971C63BAE0")
struct EVENTID_DFNWithNoActualAVData;

@GUID("71985F41-1CA1-11D3-9CC8-00C04F7971E0")
struct KSDATAFORMAT_TYPE_BDA_ANTENNA;

@GUID("F4AEB342-0329-4FDD-A8FD-4AFF4926C978")
struct KSDATAFORMAT_SUBTYPE_BDA_MPEG2_TRANSPORT;

@GUID("8DEDA6FD-AC5F-4334-8ECF-A4BA8FA7D0F0")
struct KSDATAFORMAT_SPECIFIER_BDA_TRANSPORT;

@GUID("61BE0B47-A5EB-499B-9A85-5B16C07F1258")
struct KSDATAFORMAT_TYPE_BDA_IF_SIGNAL;

@GUID("455F176C-4B06-47CE-9AEF-8CAEF73DF7B5")
struct KSDATAFORMAT_TYPE_MPEG2_SECTIONS;

@GUID("B3C7397C-D303-414D-B33C-4ED2C9D29733")
struct KSDATAFORMAT_SUBTYPE_ATSC_SI;

@GUID("E9DD31A3-221D-4ADB-8532-9AF309C1A408")
struct KSDATAFORMAT_SUBTYPE_DVB_SI;

@GUID("762E3F66-336F-48D1-BF83-2B00352C11F0")
struct KSDATAFORMAT_SUBTYPE_BDA_OPENCABLE_PSIP;

@GUID("951727DB-D2CE-4528-96F6-3301FABB2DE0")
struct KSDATAFORMAT_SUBTYPE_BDA_OPENCABLE_OOB_PSIP;

@GUID("4A2EEB99-6458-4538-B187-04017C41413F")
struct KSDATAFORMAT_SUBTYPE_ISDB_SI;

@GUID("0D7AED42-CB9A-11DB-9705-005056C00008")
struct KSDATAFORMAT_SUBTYPE_PBDA_TRANSPORT_RAW;

@GUID("78216A81-CFA8-493E-9711-36A61C08BD9D")
struct PINNAME_BDA_TRANSPORT;

@GUID("5C0C8281-5667-486C-8482-63E31F01A6E9")
struct PINNAME_BDA_ANALOG_VIDEO;

@GUID("D28A580A-9B1F-4B0C-9C33-9BF0A8EA636B")
struct PINNAME_BDA_ANALOG_AUDIO;

@GUID("D2855FED-B2D3-4EEB-9BD0-193436A2F890")
struct PINNAME_BDA_FM_RADIO;

@GUID("1A9D4A42-F3CD-48A1-9AEA-71DE133CBE14")
struct PINNAME_BDA_IF_PIN;

@GUID("297BB104-E5C9-4ACE-B123-95C3CBB24D4F")
struct PINNAME_BDA_OPENCABLE_PSIP_PIN;

@GUID("71985F43-1CA1-11D3-9CC8-00C04F7971E0")
struct KSPROPSETID_BdaEthernetFilter;

@GUID("71985F44-1CA1-11D3-9CC8-00C04F7971E0")
struct KSPROPSETID_BdaIPv4Filter;

@GUID("E1785A74-2A23-4FB3-9245-A8F88017EF33")
struct KSPROPSETID_BdaIPv6Filter;

@GUID("1347D106-CF3A-428A-A5CB-AC0D9A2A4338")
struct KSPROPSETID_BdaSignalStats;

@GUID("FD0A5AF3-B41D-11D2-9C95-00C04F7971E0")
struct KSMETHODSETID_BdaChangeSync;

@GUID("71985F45-1CA1-11D3-9CC8-00C04F7971E0")
struct KSMETHODSETID_BdaDeviceConfiguration;

@GUID("A14EE835-0A23-11D3-9CC7-00C04F7971E0")
struct KSPROPSETID_BdaTopology;

@GUID("0DED49D5-A8B7-4D5D-97A1-12B0C195874D")
struct KSPROPSETID_BdaPinControl;

@GUID("104781CD-50BD-40D5-95FB-087E0E86A591")
struct KSEVENTSETID_BdaPinEvent;

@GUID("71985F46-1CA1-11D3-9CC8-00C04F7971E0")
struct KSPROPSETID_BdaVoidTransform;

@GUID("DDF15B0D-BD25-11D2-9CA0-00C04F7971E0")
struct KSPROPSETID_BdaNullTransform;

@GUID("71985F47-1CA1-11D3-9CC8-00C04F7971E0")
struct KSPROPSETID_BdaFrequencyFilter;

@GUID("AAB59E17-01C9-4EBF-93F2-FC3B79B46F91")
struct KSEVENTSETID_BdaTunerEvent;

@GUID("992CF102-49F9-4719-A664-C4F23E2408F4")
struct KSPROPSETID_BdaLNBInfo;

@GUID("F84E2AB0-3C6B-45E3-A0FC-8669D4B81F11")
struct KSPROPSETID_BdaDiseqCommand;

@GUID("8B19BBF0-4184-43AC-AD3C-0C889BE4C212")
struct KSEVENTSETID_BdaDiseqCEvent;

@GUID("EF30F379-985B-4D10-B640-A79D5E04E1E0")
struct KSPROPSETID_BdaDigitalDemodulator;

@GUID("DDF15B12-BD25-11D2-9CA0-00C04F7971E0")
struct KSPROPSETID_BdaAutodemodulate;

@GUID("516B99C5-971C-4AAF-B3F3-D9FDA8A15E16")
struct KSPROPSETID_BdaTableSection;

@GUID("D0A67D65-08DF-4FEC-8533-E5B550410B85")
struct KSPROPSETID_BdaPIDFilter;

@GUID("B0693766-5278-4EC6-B9E1-3CE40560EF5A")
struct KSPROPSETID_BdaCA;

@GUID("488C4CCC-B768-4129-8EB1-B00A071F9068")
struct KSEVENTSETID_BdaCAEvent;

@GUID("BFF6B5BB-B0AE-484C-9DCA-73528FB0B46E")
struct KSMETHODSETID_BdaDrmService;

@GUID("4BE6FA3D-07CD-4139-8B80-8C18BA3AEC88")
struct KSMETHODSETID_BdaWmdrmSession;

@GUID("86D979CF-A8A7-4F94-B5FB-14C0ACA68FE6")
struct KSMETHODSETID_BdaWmdrmTuner;

@GUID("F99492DA-6193-4EB0-8690-6686CBFF713E")
struct KSMETHODSETID_BdaEventing;

@GUID("AE7E55B2-96D7-4E29-908F-62F95B2A1679")
struct KSEVENTSETID_BdaEvent;

@GUID("0D4A90EC-C69D-4EE2-8C5A-FB1F63A50DA1")
struct KSMETHODSETID_BdaDebug;

@GUID("B774102F-AC07-478A-8228-2742D961FA7E")
struct KSMETHODSETID_BdaTuner;

@GUID("0C24096D-5FF5-47DE-A856-062E587E3727")
struct KSMETHODSETID_BdaNameValueA;

@GUID("36E07304-9F0D-4E88-9118-AC0BA317B7F2")
struct KSMETHODSETID_BdaNameValue;

@GUID("942AAFEC-4C05-4C74-B8EB-8706C2A4943F")
struct KSMETHODSETID_BdaMux;

@GUID("12EB49DF-6249-47F3-B190-E21E6E2F8A9C")
struct KSMETHODSETID_BdaScanning;

@GUID("8D9D5562-1589-417D-99CE-AC531DDA19F9")
struct KSMETHODSETID_BdaGuideDataDeliveryService;

@GUID("10CED3B4-320B-41BF-9824-1B2E68E71EB9")
struct KSMETHODSETID_BdaConditionalAccessService;

@GUID("5E68C627-16C2-4E6C-B1E2-D00170CDAA0F")
struct KSMETHODSETID_BdaIsdbConditionalAccess;

@GUID("1DCFAFE9-B45E-41B3-BB2A-561EB129AE98")
struct KSMETHODSETID_BdaTSSelector;

@GUID("EDA5C834-4531-483C-BE0A-94E6C96FF396")
struct KSMETHODSETID_BdaUserActivity;

@GUID("FD0A5AF4-B41D-11D2-9C95-00C04F7971E0")
struct KSCATEGORY_BDA_RECEIVER_COMPONENT;

@GUID("71985F48-1CA1-11D3-9CC8-00C04F7971E0")
struct KSCATEGORY_BDA_NETWORK_TUNER;

@GUID("71985F49-1CA1-11D3-9CC8-00C04F7971E0")
struct KSCATEGORY_BDA_NETWORK_EPG;

@GUID("71985F4A-1CA1-11D3-9CC8-00C04F7971E0")
struct KSCATEGORY_BDA_IP_SINK;

@GUID("71985F4B-1CA1-11D3-9CC8-00C04F7971E0")
struct KSCATEGORY_BDA_NETWORK_PROVIDER;

@GUID("A2E3074F-6C3D-11D3-B653-00C04F79498E")
struct KSCATEGORY_BDA_TRANSPORT_INFORMATION;

@GUID("71985F4C-1CA1-11D3-9CC8-00C04F7971E0")
struct KSNODE_BDA_RF_TUNER;

@GUID("634DB199-27DD-46B8-ACFB-ECC98E61A2AD")
struct KSNODE_BDA_ANALOG_DEMODULATOR;

@GUID("71985F4D-1CA1-11D3-9CC8-00C04F7971E0")
struct KSNODE_BDA_QAM_DEMODULATOR;

@GUID("6390C905-27C1-4D67-BDB7-77C50D079300")
struct KSNODE_BDA_QPSK_DEMODULATOR;

@GUID("71985F4F-1CA1-11D3-9CC8-00C04F7971E0")
struct KSNODE_BDA_8VSB_DEMODULATOR;

@GUID("2DAC6E05-EDBE-4B9C-B387-1B6FAD7D6495")
struct KSNODE_BDA_COFDM_DEMODULATOR;

@GUID("E957A0E7-DD98-4A3C-810B-3525157AB62E")
struct KSNODE_BDA_8PSK_DEMODULATOR;

@GUID("FCEA3AE3-2CB2-464D-8F5D-305C0BB778A2")
struct KSNODE_BDA_ISDB_T_DEMODULATOR;

@GUID("EDDE230A-9086-432D-B8A5-6670263807E9")
struct KSNODE_BDA_ISDB_S_DEMODULATOR;

@GUID("345812A0-FB7C-4790-AA7E-B1DB88AC19C9")
struct KSNODE_BDA_OPENCABLE_POD;

@GUID("D83EF8FC-F3B8-45AB-8B71-ECF7C339DEB4")
struct KSNODE_BDA_COMMON_CA_POD;

@GUID("F5412789-B0A0-44E1-AE4F-EE999B1B7FBE")
struct KSNODE_BDA_PID_FILTER;

@GUID("71985F4E-1CA1-11D3-9CC8-00C04F7971E0")
struct KSNODE_BDA_IP_SINK;

@GUID("D98429E3-65C9-4AC4-93AA-766782833B7A")
struct KSNODE_BDA_VIDEO_ENCODER;

@GUID("C026869F-7129-4E71-8696-EC8F75299B77")
struct KSNODE_BDA_PBDA_CAS;

@GUID("F2CF2AB3-5B9D-40AE-AB7C-4E7AD0BD1C52")
struct KSNODE_BDA_PBDA_ISDBCAS;

@GUID("AA5E8286-593C-4979-9494-46A2A9DFE076")
struct KSNODE_BDA_PBDA_TUNER;

@GUID("F88C7787-6678-4F4B-A13E-DA09861D682B")
struct KSNODE_BDA_PBDA_MUX;

@GUID("9EEEBD03-EEA1-450F-96AE-633E6DE63CCE")
struct KSNODE_BDA_PBDA_DRM;

@GUID("4F95AD74-CEFB-42D2-94A9-68C5B2C1AABE")
struct KSNODE_BDA_DRI_DRM;

@GUID("5EDDF185-FED1-4F45-9685-BBB73C323CFC")
struct KSNODE_BDA_TS_SELECTOR;

@GUID("3FDFFA70-AC9A-11D2-8F17-00C04F7971E2")
struct PINNAME_IPSINK_INPUT;

@GUID("E25F7B8E-CCCC-11D2-8F25-00C04F7971E2")
struct KSDATAFORMAT_TYPE_BDA_IP;

@GUID("5A9A213C-DB08-11D2-8F32-00C04F7971E2")
struct KSDATAFORMAT_SUBTYPE_BDA_IP;

@GUID("6B891420-DB09-11D2-8F32-00C04F7971E2")
struct KSDATAFORMAT_SPECIFIER_BDA_IP;

@GUID("DADD5799-7D5B-4B63-80FB-D1442F26B621")
struct KSDATAFORMAT_TYPE_BDA_IP_CONTROL;

@GUID("499856E8-E85B-48ED-9BEA-410D0DD4EF81")
struct KSDATAFORMAT_SUBTYPE_BDA_IP_CONTROL;

@GUID("C1B06D73-1DBB-11D3-8F46-00C04F7971E2")
struct PINNAME_MPE;

@GUID("455F176C-4B06-47CE-9AEF-8CAEF73DF7B5")
struct KSDATAFORMAT_TYPE_MPE;

@GUID("143827AB-F77B-498D-81CA-5A007AEC28BF")
struct DIGITAL_CABLE_NETWORK_TYPE;

@GUID("B820D87E-E0E3-478F-8A38-4E13F7B3DF42")
struct ANALOG_TV_NETWORK_TYPE;

@GUID("742EF867-09E1-40A3-82D3-9669BA35325F")
struct ANALOG_AUXIN_NETWORK_TYPE;

@GUID("7728087B-2BB9-4E30-8078-449476E59DBB")
struct ANALOG_FM_NETWORK_TYPE;

@GUID("95037F6F-3AC7-4452-B6C4-45A9CE9292A2")
struct ISDB_TERRESTRIAL_TV_NETWORK_TYPE;

@GUID("FC3855A6-C901-4F2E-ABA8-90815AFC6C83")
struct ISDB_T_NETWORK_TYPE;

@GUID("B0A4E6A0-6A1A-4B83-BB5B-903E1D90E6B6")
struct ISDB_SATELLITE_TV_NETWORK_TYPE;

@GUID("A1E78202-1459-41B1-9CA9-2A92587A42CC")
struct ISDB_S_NETWORK_TYPE;

@GUID("C974DDB5-41FE-4B25-9741-92F049F1D5D1")
struct ISDB_CABLE_TV_NETWORK_TYPE;

@GUID("93B66FB5-93D4-4323-921C-C1F52DF61D3F")
struct DIRECT_TV_SATELLITE_TV_NETWORK_TYPE;

@GUID("C4F6B31B-C6BF-4759-886F-A7386DCA27A0")
struct ECHOSTAR_SATELLITE_TV_NETWORK_TYPE;

@GUID("0DAD2FDD-5FD7-11D3-8F50-00C04F7971E2")
struct ATSC_TERRESTRIAL_TV_NETWORK_TYPE;

@GUID("216C62DF-6D7F-4E9A-8571-05F14EDB766A")
struct DVB_TERRESTRIAL_TV_NETWORK_TYPE;

@GUID("9E9E46C6-3ABA-4F08-AD0E-CC5AC8148C2B")
struct BSKYB_TERRESTRIAL_TV_NETWORK_TYPE;

@GUID("FA4B375A-45B4-4D45-8440-263957B11623")
struct DVB_SATELLITE_TV_NETWORK_TYPE;

@GUID("DC0C0FE7-0485-4266-B93F-68FBF80ED834")
struct DVB_CABLE_TV_NETWORK_TYPE;

@GUID("69C24F54-9983-497E-B415-282BE4C555FB")
struct BDA_DEBUG_DATA_AVAILABLE;

@GUID("A806E767-DE5C-430C-80BF-A21EBE06C748")
struct BDA_DEBUG_DATA_TYPE_STRING;

@GUID("D4CB1966-41BC-4CED-9A20-FDCEAC78F70D")
struct EVENTID_BDA_IsdbCASResponse;

@GUID("CF39A9D8-F5D3-4685-BE57-ED81DBA46B27")
struct EVENTID_BDA_CASRequestTuner;

@GUID("20C1A16B-441F-49A5-BB5C-E9A04495C6C1")
struct EVENTID_BDA_CASReleaseTuner;

@GUID("85DAC915-E593-410D-8471-D6812105F28E")
struct EVENTID_BDA_CASOpenMMI;

@GUID("5D0F550F-DE2E-479D-8345-EC0E9557E8A2")
struct EVENTID_BDA_CASCloseMMI;

@GUID("676876F0-1132-404C-A7CA-E72069A9D54F")
struct EVENTID_BDA_CASBroadcastMMI;

@GUID("1872E740-F573-429B-A00E-D9C1E408AF09")
struct EVENTID_BDA_TunerSignalLock;

@GUID("E29B382B-1EDD-4930-BC46-682FD72D2DFB")
struct EVENTID_BDA_TunerNoSignal;

@GUID("FF75C68C-F416-4E7E-BF17-6D55C5DF1575")
struct EVENTID_BDA_GPNVValueUpdate;

@GUID("65A6F681-1462-473B-88CE-CB731427BDB5")
struct EVENTID_BDA_UpdateDrmStatus;

@GUID("55702B50-7B49-42B8-A82F-4AFB691B0628")
struct EVENTID_BDA_UpdateScanState;

@GUID("98DB717A-478A-4CD4-92D0-95F66B89E5B1")
struct EVENTID_BDA_GuideDataAvailable;

@GUID("A1C3EA2B-175F-4458-B735-507D22DB23A6")
struct EVENTID_BDA_GuideServiceInformationUpdated;

@GUID("AC33C448-6F73-4FD7-B341-594C360D8D74")
struct EVENTID_BDA_GuideDataError;

@GUID("EFA628F8-1F2C-4B67-9EA5-ACF6FA9A1F36")
struct EVENTID_BDA_DiseqCResponseAvailable;

@GUID("356207B2-6F31-4EB0-A271-B3FA6BB7680F")
struct EVENTID_BDA_LbigsOpenConnection;

@GUID("1123277B-F1C6-4154-8B0D-48E6157059AA")
struct EVENTID_BDA_LbigsSendData;

@GUID("C2F08B99-65EF-4314-9671-E99D4CCE0BAE")
struct EVENTID_BDA_LbigsCloseConnectionHandle;

@GUID("5EC90EB9-39FA-4CFC-B93F-00BB11077F5E")
struct EVENTID_BDA_EncoderSignalLock;

@GUID("05F25366-D0EB-43D2-BC3C-682B863DF142")
struct EVENTID_BDA_FdcStatus;

@GUID("6A0CD757-4CE3-4E5B-9444-7187B87152C5")
struct EVENTID_BDA_FdcTableSection;

@GUID("C40F9F85-09D0-489C-9E9C-0ABBB56951B0")
struct EVENTID_BDA_TransprtStreamSelectorInfo;

@GUID("C6E048C0-C574-4C26-BCDA-2F4D35EB5E85")
struct EVENTID_BDA_RatingPinReset;

@GUID("1E1D7141-583F-4AC2-B019-1F430EDA0F4C")
struct PBDA_ALWAYS_TUNE_IN_MUX;

@GUID("29840822-5B84-11D0-BD3B-00A0C911CE86")
interface ICreateDevEnum : IUnknown
{
    HRESULT CreateClassEnumerator(const(GUID)* clsidDeviceClass, IEnumMoniker* ppEnumMoniker, uint dwFlags);
}

@GUID("56A86891-0AD4-11CE-B03A-0020AF0BA770")
interface IPin : IUnknown
{
    HRESULT Connect(IPin pReceivePin, const(AM_MEDIA_TYPE)* pmt);
    HRESULT ReceiveConnection(IPin pConnector, const(AM_MEDIA_TYPE)* pmt);
    HRESULT Disconnect();
    HRESULT ConnectedTo(IPin* pPin);
    HRESULT ConnectionMediaType(AM_MEDIA_TYPE* pmt);
    HRESULT QueryPinInfo(PIN_INFO* pInfo);
    HRESULT QueryDirection(PIN_DIRECTION* pPinDir);
    HRESULT QueryId(ushort** Id);
    HRESULT QueryAccept(const(AM_MEDIA_TYPE)* pmt);
    HRESULT EnumMediaTypes(IEnumMediaTypes* ppEnum);
    HRESULT QueryInternalConnections(char* apPin, uint* nPin);
    HRESULT EndOfStream();
    HRESULT BeginFlush();
    HRESULT EndFlush();
    HRESULT NewSegment(long tStart, long tStop, double dRate);
}

@GUID("56A86892-0AD4-11CE-B03A-0020AF0BA770")
interface IEnumPins : IUnknown
{
    HRESULT Next(uint cPins, char* ppPins, uint* pcFetched);
    HRESULT Skip(uint cPins);
    HRESULT Reset();
    HRESULT Clone(IEnumPins* ppEnum);
}

@GUID("89C31040-846B-11CE-97D3-00AA0055595A")
interface IEnumMediaTypes : IUnknown
{
    HRESULT Next(uint cMediaTypes, char* ppMediaTypes, uint* pcFetched);
    HRESULT Skip(uint cMediaTypes);
    HRESULT Reset();
    HRESULT Clone(IEnumMediaTypes* ppEnum);
}

@GUID("56A8689F-0AD4-11CE-B03A-0020AF0BA770")
interface IFilterGraph : IUnknown
{
    HRESULT AddFilter(IBaseFilter pFilter, const(wchar)* pName);
    HRESULT RemoveFilter(IBaseFilter pFilter);
    HRESULT EnumFilters(IEnumFilters* ppEnum);
    HRESULT FindFilterByName(const(wchar)* pName, IBaseFilter* ppFilter);
    HRESULT ConnectDirect(IPin ppinOut, IPin ppinIn, const(AM_MEDIA_TYPE)* pmt);
    HRESULT Reconnect(IPin ppin);
    HRESULT Disconnect(IPin ppin);
    HRESULT SetDefaultSyncSource();
}

@GUID("56A86893-0AD4-11CE-B03A-0020AF0BA770")
interface IEnumFilters : IUnknown
{
    HRESULT Next(uint cFilters, char* ppFilter, uint* pcFetched);
    HRESULT Skip(uint cFilters);
    HRESULT Reset();
    HRESULT Clone(IEnumFilters* ppEnum);
}

@GUID("56A86899-0AD4-11CE-B03A-0020AF0BA770")
interface IMediaFilter : IPersist
{
    HRESULT Stop();
    HRESULT Pause();
    HRESULT Run(long tStart);
    HRESULT GetState(uint dwMilliSecsTimeout, FILTER_STATE* State);
    HRESULT SetSyncSource(IReferenceClock pClock);
    HRESULT GetSyncSource(IReferenceClock* pClock);
}

@GUID("56A86895-0AD4-11CE-B03A-0020AF0BA770")
interface IBaseFilter : IMediaFilter
{
    HRESULT EnumPins(IEnumPins* ppEnum);
    HRESULT FindPin(const(wchar)* Id, IPin* ppPin);
    HRESULT QueryFilterInfo(FILTER_INFO* pInfo);
    HRESULT JoinFilterGraph(IFilterGraph pGraph, const(wchar)* pName);
    HRESULT QueryVendorInfo(ushort** pVendorInfo);
}

@GUID("56A86897-0AD4-11CE-B03A-0020AF0BA770")
interface IReferenceClock : IUnknown
{
    HRESULT GetTime(long* pTime);
    HRESULT AdviseTime(long baseTime, long streamTime, size_t hEvent, size_t* pdwAdviseCookie);
    HRESULT AdvisePeriodic(long startTime, long periodTime, size_t hSemaphore, size_t* pdwAdviseCookie);
    HRESULT Unadvise(size_t dwAdviseCookie);
}

@GUID("EBEC459C-2ECA-4D42-A8AF-30DF557614B8")
interface IReferenceClockTimerControl : IUnknown
{
    HRESULT SetDefaultTimerResolution(long timerResolution);
    HRESULT GetDefaultTimerResolution(long* pTimerResolution);
}

@GUID("36B73885-C2C8-11CF-8B46-00805F6CEF60")
interface IReferenceClock2 : IReferenceClock
{
}

@GUID("56A8689A-0AD4-11CE-B03A-0020AF0BA770")
interface IMediaSample : IUnknown
{
    HRESULT GetPointer(char* ppBuffer);
    int     GetSize();
    HRESULT GetTime(long* pTimeStart, long* pTimeEnd);
    HRESULT SetTime(long* pTimeStart, long* pTimeEnd);
    HRESULT IsSyncPoint();
    HRESULT SetSyncPoint(BOOL bIsSyncPoint);
    HRESULT IsPreroll();
    HRESULT SetPreroll(BOOL bIsPreroll);
    int     GetActualDataLength();
    HRESULT SetActualDataLength(int __MIDL__IMediaSample0000);
    HRESULT GetMediaType(AM_MEDIA_TYPE** ppMediaType);
    HRESULT SetMediaType(AM_MEDIA_TYPE* pMediaType);
    HRESULT IsDiscontinuity();
    HRESULT SetDiscontinuity(BOOL bDiscontinuity);
    HRESULT GetMediaTime(long* pTimeStart, long* pTimeEnd);
    HRESULT SetMediaTime(long* pTimeStart, long* pTimeEnd);
}

@GUID("36B73884-C2C8-11CF-8B46-00805F6CEF60")
interface IMediaSample2 : IMediaSample
{
    HRESULT GetProperties(uint cbProperties, char* pbProperties);
    HRESULT SetProperties(uint cbProperties, char* pbProperties);
}

@GUID("68961E68-832B-41EA-BC91-63593F3E70E3")
interface IMediaSample2Config : IUnknown
{
    HRESULT GetSurface(IUnknown* ppDirect3DSurface9);
}

@GUID("56A8689C-0AD4-11CE-B03A-0020AF0BA770")
interface IMemAllocator : IUnknown
{
    HRESULT SetProperties(ALLOCATOR_PROPERTIES* pRequest, ALLOCATOR_PROPERTIES* pActual);
    HRESULT GetProperties(ALLOCATOR_PROPERTIES* pProps);
    HRESULT Commit();
    HRESULT Decommit();
    HRESULT GetBuffer(IMediaSample* ppBuffer, long* pStartTime, long* pEndTime, uint dwFlags);
    HRESULT ReleaseBuffer(IMediaSample pBuffer);
}

@GUID("379A0CF0-C1DE-11D2-ABF5-00A0C905F375")
interface IMemAllocatorCallbackTemp : IMemAllocator
{
    HRESULT SetNotify(IMemAllocatorNotifyCallbackTemp pNotify);
    HRESULT GetFreeCount(int* plBuffersFree);
}

@GUID("92980B30-C1DE-11D2-ABF5-00A0C905F375")
interface IMemAllocatorNotifyCallbackTemp : IUnknown
{
    HRESULT NotifyRelease();
}

@GUID("56A8689D-0AD4-11CE-B03A-0020AF0BA770")
interface IMemInputPin : IUnknown
{
    HRESULT GetAllocator(IMemAllocator* ppAllocator);
    HRESULT NotifyAllocator(IMemAllocator pAllocator, BOOL bReadOnly);
    HRESULT GetAllocatorRequirements(ALLOCATOR_PROPERTIES* pProps);
    HRESULT Receive(IMediaSample pSample);
    HRESULT ReceiveMultiple(char* pSamples, int nSamples, int* nSamplesProcessed);
    HRESULT ReceiveCanBlock();
}

@GUID("A3D8CEC0-7E5A-11CF-BBC5-00805F6CEF20")
interface IAMovieSetup : IUnknown
{
    HRESULT Register();
    HRESULT Unregister();
}

@GUID("36B73880-C2C8-11CF-8B46-00805F6CEF60")
interface IMediaSeeking : IUnknown
{
    HRESULT GetCapabilities(uint* pCapabilities);
    HRESULT CheckCapabilities(uint* pCapabilities);
    HRESULT IsFormatSupported(const(GUID)* pFormat);
    HRESULT QueryPreferredFormat(GUID* pFormat);
    HRESULT GetTimeFormatA(GUID* pFormat);
    HRESULT IsUsingTimeFormat(const(GUID)* pFormat);
    HRESULT SetTimeFormat(const(GUID)* pFormat);
    HRESULT GetDuration(long* pDuration);
    HRESULT GetStopPosition(long* pStop);
    HRESULT GetCurrentPosition(long* pCurrent);
    HRESULT ConvertTimeFormat(long* pTarget, const(GUID)* pTargetFormat, long Source, const(GUID)* pSourceFormat);
    HRESULT SetPositions(long* pCurrent, uint dwCurrentFlags, long* pStop, uint dwStopFlags);
    HRESULT GetPositions(long* pCurrent, long* pStop);
    HRESULT GetAvailable(long* pEarliest, long* pLatest);
    HRESULT SetRate(double dRate);
    HRESULT GetRate(double* pdRate);
    HRESULT GetPreroll(long* pllPreroll);
}

@GUID("56A868A4-0AD4-11CE-B03A-0020AF0BA770")
interface IEnumRegFilters : IUnknown
{
    HRESULT Next(uint cFilters, char* apRegFilter, uint* pcFetched);
    HRESULT Skip(uint cFilters);
    HRESULT Reset();
    HRESULT Clone(IEnumRegFilters* ppEnum);
}

@GUID("56A868A3-0AD4-11CE-B03A-0020AF0BA770")
interface IFilterMapper : IUnknown
{
    HRESULT RegisterFilter(GUID clsid, const(wchar)* Name, uint dwMerit);
    HRESULT RegisterFilterInstance(GUID clsid, const(wchar)* Name, GUID* MRId);
    HRESULT RegisterPin(GUID Filter, const(wchar)* Name, BOOL bRendered, BOOL bOutput, BOOL bZero, BOOL bMany, 
                        GUID ConnectsToFilter, const(wchar)* ConnectsToPin);
    HRESULT RegisterPinType(GUID clsFilter, const(wchar)* strName, GUID clsMajorType, GUID clsSubType);
    HRESULT UnregisterFilter(GUID Filter);
    HRESULT UnregisterFilterInstance(GUID MRId);
    HRESULT UnregisterPin(GUID Filter, const(wchar)* Name);
    HRESULT EnumMatchingFilters(IEnumRegFilters* ppEnum, uint dwMerit, BOOL bInputNeeded, GUID clsInMaj, 
                                GUID clsInSub, BOOL bRender, BOOL bOututNeeded, GUID clsOutMaj, GUID clsOutSub);
}

@GUID("B79BB0B0-33C1-11D1-ABE1-00A0C905F375")
interface IFilterMapper2 : IUnknown
{
    HRESULT CreateCategory(const(GUID)* clsidCategory, uint dwCategoryMerit, const(wchar)* Description);
    HRESULT UnregisterFilter(const(GUID)* pclsidCategory, ushort* szInstance, const(GUID)* Filter);
    HRESULT RegisterFilter(const(GUID)* clsidFilter, const(wchar)* Name, IMoniker* ppMoniker, 
                           const(GUID)* pclsidCategory, ushort* szInstance, const(REGFILTER2)* prf2);
    HRESULT EnumMatchingFilters(IEnumMoniker* ppEnum, uint dwFlags, BOOL bExactMatch, uint dwMerit, 
                                BOOL bInputNeeded, uint cInputTypes, char* pInputTypes, const(REGPINMEDIUM)* pMedIn, 
                                const(GUID)* pPinCategoryIn, BOOL bRender, BOOL bOutputNeeded, uint cOutputTypes, 
                                char* pOutputTypes, const(REGPINMEDIUM)* pMedOut, const(GUID)* pPinCategoryOut);
}

@GUID("B79BB0B1-33C1-11D1-ABE1-00A0C905F375")
interface IFilterMapper3 : IFilterMapper2
{
    HRESULT GetICreateDevEnum(ICreateDevEnum* ppEnum);
}

@GUID("56A868A5-0AD4-11CE-B03A-0020AF0BA770")
interface IQualityControl : IUnknown
{
    HRESULT Notify(IBaseFilter pSelf, Quality q);
    HRESULT SetSink(IQualityControl piqc);
}

@GUID("56A868A0-0AD4-11CE-B03A-0020AF0BA770")
interface IOverlayNotify : IUnknown
{
    HRESULT OnPaletteChange(uint dwColors, const(PALETTEENTRY)* pPalette);
    HRESULT OnClipChange(const(RECT)* pSourceRect, const(RECT)* pDestinationRect, const(RGNDATA)* pRgnData);
    HRESULT OnColorKeyChange(const(COLORKEY)* pColorKey);
    HRESULT OnPositionChange(const(RECT)* pSourceRect, const(RECT)* pDestinationRect);
}

@GUID("680EFA10-D535-11D1-87C8-00A0C9223196")
interface IOverlayNotify2 : IOverlayNotify
{
    HRESULT OnDisplayChange(ptrdiff_t hMonitor);
}

@GUID("56A868A1-0AD4-11CE-B03A-0020AF0BA770")
interface IOverlay : IUnknown
{
    HRESULT GetPalette(uint* pdwColors, char* ppPalette);
    HRESULT SetPalette(uint dwColors, char* pPalette);
    HRESULT GetDefaultColorKey(COLORKEY* pColorKey);
    HRESULT GetColorKey(COLORKEY* pColorKey);
    HRESULT SetColorKey(COLORKEY* pColorKey);
    HRESULT GetWindowHandle(HWND* pHwnd);
    HRESULT GetClipList(RECT* pSourceRect, RECT* pDestinationRect, RGNDATA** ppRgnData);
    HRESULT GetVideoPosition(RECT* pSourceRect, RECT* pDestinationRect);
    HRESULT Advise(IOverlayNotify pOverlayNotify, uint dwInterests);
    HRESULT Unadvise();
}

@GUID("56A868A2-0AD4-11CE-B03A-0020AF0BA770")
interface IMediaEventSink : IUnknown
{
    HRESULT Notify(int EventCode, ptrdiff_t EventParam1, ptrdiff_t EventParam2);
}

@GUID("56A868A6-0AD4-11CE-B03A-0020AF0BA770")
interface IFileSourceFilter : IUnknown
{
    HRESULT Load(ushort* pszFileName, const(AM_MEDIA_TYPE)* pmt);
    HRESULT GetCurFile(ushort** ppszFileName, AM_MEDIA_TYPE* pmt);
}

@GUID("A2104830-7C70-11CF-8BCE-00AA00A3F1A6")
interface IFileSinkFilter : IUnknown
{
    HRESULT SetFileName(ushort* pszFileName, const(AM_MEDIA_TYPE)* pmt);
    HRESULT GetCurFile(ushort** ppszFileName, AM_MEDIA_TYPE* pmt);
}

@GUID("00855B90-CE1B-11D0-BD4F-00A0C911CE86")
interface IFileSinkFilter2 : IFileSinkFilter
{
    HRESULT SetMode(uint dwFlags);
    HRESULT GetMode(uint* pdwFlags);
}

@GUID("56A868A9-0AD4-11CE-B03A-0020AF0BA770")
interface IGraphBuilder : IFilterGraph
{
    HRESULT Connect(IPin ppinOut, IPin ppinIn);
    HRESULT Render(IPin ppinOut);
    HRESULT RenderFile(const(wchar)* lpcwstrFile, const(wchar)* lpcwstrPlayList);
    HRESULT AddSourceFilter(const(wchar)* lpcwstrFileName, const(wchar)* lpcwstrFilterName, IBaseFilter* ppFilter);
    HRESULT SetLogFile(size_t hFile);
    HRESULT Abort();
    HRESULT ShouldOperationContinue();
}

@GUID("BF87B6E0-8C27-11D0-B3F0-00AA003761C5")
interface ICaptureGraphBuilder : IUnknown
{
    HRESULT SetFiltergraph(IGraphBuilder pfg);
    HRESULT GetFiltergraph(IGraphBuilder* ppfg);
    HRESULT SetOutputFileName(const(GUID)* pType, ushort* lpstrFile, IBaseFilter* ppf, IFileSinkFilter* ppSink);
    HRESULT FindInterface(const(GUID)* pCategory, IBaseFilter pf, const(GUID)* riid, void** ppint);
    HRESULT RenderStream(const(GUID)* pCategory, IUnknown pSource, IBaseFilter pfCompressor, 
                         IBaseFilter pfRenderer);
    HRESULT ControlStream(const(GUID)* pCategory, IBaseFilter pFilter, long* pstart, long* pstop, 
                          ushort wStartCookie, ushort wStopCookie);
    HRESULT AllocCapFile(ushort* lpstr, ulong dwlSize);
    HRESULT CopyCaptureFile(ushort* lpwstrOld, ushort* lpwstrNew, int fAllowEscAbort, 
                            IAMCopyCaptureFileProgress pCallback);
}

@GUID("670D1D20-A068-11D0-B3F0-00AA003761C5")
interface IAMCopyCaptureFileProgress : IUnknown
{
    HRESULT Progress(int iProgress);
}

@GUID("93E5A4E0-2D50-11D2-ABFA-00A0C9C6E38D")
interface ICaptureGraphBuilder2 : IUnknown
{
    HRESULT SetFiltergraph(IGraphBuilder pfg);
    HRESULT GetFiltergraph(IGraphBuilder* ppfg);
    HRESULT SetOutputFileName(const(GUID)* pType, ushort* lpstrFile, IBaseFilter* ppf, IFileSinkFilter* ppSink);
    HRESULT FindInterface(const(GUID)* pCategory, const(GUID)* pType, IBaseFilter pf, const(GUID)* riid, 
                          void** ppint);
    HRESULT RenderStream(const(GUID)* pCategory, const(GUID)* pType, IUnknown pSource, IBaseFilter pfCompressor, 
                         IBaseFilter pfRenderer);
    HRESULT ControlStream(const(GUID)* pCategory, const(GUID)* pType, IBaseFilter pFilter, long* pstart, 
                          long* pstop, ushort wStartCookie, ushort wStopCookie);
    HRESULT AllocCapFile(ushort* lpstr, ulong dwlSize);
    HRESULT CopyCaptureFile(ushort* lpwstrOld, ushort* lpwstrNew, int fAllowEscAbort, 
                            IAMCopyCaptureFileProgress pCallback);
    HRESULT FindPin(IUnknown pSource, PIN_DIRECTION pindir, const(GUID)* pCategory, const(GUID)* pType, 
                    BOOL fUnconnected, int num, IPin* ppPin);
}

@GUID("36B73882-C2C8-11CF-8B46-00805F6CEF60")
interface IFilterGraph2 : IGraphBuilder
{
    HRESULT AddSourceFilterForMoniker(IMoniker pMoniker, IBindCtx pCtx, const(wchar)* lpcwstrFilterName, 
                                      IBaseFilter* ppFilter);
    HRESULT ReconnectEx(IPin ppin, const(AM_MEDIA_TYPE)* pmt);
    HRESULT RenderEx(IPin pPinOut, uint dwFlags, uint* pvContext);
}

@GUID("AAF38154-B80B-422F-91E6-B66467509A07")
interface IFilterGraph3 : IFilterGraph2
{
    HRESULT SetSyncSourceEx(IReferenceClock pClockForMostOfFilterGraph, IReferenceClock pClockForFilter, 
                            IBaseFilter pFilter);
}

@GUID("56A868BF-0AD4-11CE-B03A-0020AF0BA770")
interface IStreamBuilder : IUnknown
{
    HRESULT Render(IPin ppinOut, IGraphBuilder pGraph);
    HRESULT Backout(IPin ppinOut, IGraphBuilder pGraph);
}

@GUID("56A868AA-0AD4-11CE-B03A-0020AF0BA770")
interface IAsyncReader : IUnknown
{
    HRESULT RequestAllocator(IMemAllocator pPreferred, ALLOCATOR_PROPERTIES* pProps, IMemAllocator* ppActual);
    HRESULT Request(IMediaSample pSample, size_t dwUser);
    HRESULT WaitForNext(uint dwTimeout, IMediaSample* ppSample, size_t* pdwUser);
    HRESULT SyncReadAligned(IMediaSample pSample);
    HRESULT SyncRead(long llPosition, int lLength, char* pBuffer);
    HRESULT Length(long* pTotal, long* pAvailable);
    HRESULT BeginFlush();
    HRESULT EndFlush();
}

@GUID("56A868AB-0AD4-11CE-B03A-0020AF0BA770")
interface IGraphVersion : IUnknown
{
    HRESULT QueryVersion(int* pVersion);
}

@GUID("56A868AD-0AD4-11CE-B03A-0020AF0BA770")
interface IResourceConsumer : IUnknown
{
    HRESULT AcquireResource(int idResource);
    HRESULT ReleaseResource(int idResource);
}

@GUID("56A868AC-0AD4-11CE-B03A-0020AF0BA770")
interface IResourceManager : IUnknown
{
    HRESULT Register(const(wchar)* pName, int cResource, int* plToken);
    HRESULT RegisterGroup(const(wchar)* pName, int cResource, char* palTokens, int* plToken);
    HRESULT RequestResource(int idResource, IUnknown pFocusObject, IResourceConsumer pConsumer);
    HRESULT NotifyAcquire(int idResource, IResourceConsumer pConsumer, HRESULT hr);
    HRESULT NotifyRelease(int idResource, IResourceConsumer pConsumer, BOOL bStillWant);
    HRESULT CancelRequest(int idResource, IResourceConsumer pConsumer);
    HRESULT SetFocus(IUnknown pFocusObject);
    HRESULT ReleaseFocus(IUnknown pFocusObject);
}

@GUID("56A868AF-0AD4-11CE-B03A-0020AF0BA770")
interface IDistributorNotify : IUnknown
{
    HRESULT Stop();
    HRESULT Pause();
    HRESULT Run(long tStart);
    HRESULT SetSyncSource(IReferenceClock pClock);
    HRESULT NotifyGraphChange();
}

@GUID("36B73881-C2C8-11CF-8B46-00805F6CEF60")
interface IAMStreamControl : IUnknown
{
    HRESULT StartAt(const(long)* ptStart, uint dwCookie);
    HRESULT StopAt(const(long)* ptStop, BOOL bSendExtra, uint dwCookie);
    HRESULT GetInfo(AM_STREAM_INFO* pInfo);
}

@GUID("36B73883-C2C8-11CF-8B46-00805F6CEF60")
interface ISeekingPassThru : IUnknown
{
    HRESULT Init(BOOL bSupportRendering, IPin pPin);
}

@GUID("C6E13340-30AC-11D0-A18C-00A0C9118956")
interface IAMStreamConfig : IUnknown
{
    HRESULT SetFormat(AM_MEDIA_TYPE* pmt);
    HRESULT GetFormat(AM_MEDIA_TYPE** ppmt);
    HRESULT GetNumberOfCapabilities(int* piCount, int* piSize);
    HRESULT GetStreamCaps(int iIndex, AM_MEDIA_TYPE** ppmt, ubyte* pSCC);
}

@GUID("BEE3D220-157B-11D0-BD23-00A0C911CE86")
interface IConfigInterleaving : IUnknown
{
    HRESULT put_Mode(InterleavingMode mode);
    HRESULT get_Mode(InterleavingMode* pMode);
    HRESULT put_Interleaving(const(long)* prtInterleave, const(long)* prtPreroll);
    HRESULT get_Interleaving(long* prtInterleave, long* prtPreroll);
}

@GUID("5ACD6AA0-F482-11CE-8B67-00AA00A3F1A6")
interface IConfigAviMux : IUnknown
{
    HRESULT SetMasterStream(int iStream);
    HRESULT GetMasterStream(int* pStream);
    HRESULT SetOutputCompatibilityIndex(BOOL fOldIndex);
    HRESULT GetOutputCompatibilityIndex(int* pfOldIndex);
}

@GUID("C6E13343-30AC-11D0-A18C-00A0C9118956")
interface IAMVideoCompression : IUnknown
{
    HRESULT put_KeyFrameRate(int KeyFrameRate);
    HRESULT get_KeyFrameRate(int* pKeyFrameRate);
    HRESULT put_PFramesPerKeyFrame(int PFramesPerKeyFrame);
    HRESULT get_PFramesPerKeyFrame(int* pPFramesPerKeyFrame);
    HRESULT put_Quality(double Quality);
    HRESULT get_Quality(double* pQuality);
    HRESULT put_WindowSize(ulong WindowSize);
    HRESULT get_WindowSize(ulong* pWindowSize);
    HRESULT GetInfo(const(wchar)* pszVersion, int* pcbVersion, const(wchar)* pszDescription, int* pcbDescription, 
                    int* pDefaultKeyFrameRate, int* pDefaultPFramesPerKey, double* pDefaultQuality, 
                    int* pCapabilities);
    HRESULT OverrideKeyFrame(int FrameNumber);
    HRESULT OverrideFrameSize(int FrameNumber, int Size);
}

@GUID("D8D715A0-6E5E-11D0-B3F0-00AA003761C5")
interface IAMVfwCaptureDialogs : IUnknown
{
    HRESULT HasDialog(int iDialog);
    HRESULT ShowDialog(int iDialog, HWND hwnd);
    HRESULT SendDriverMessage(int iDialog, int uMsg, int dw1, int dw2);
}

@GUID("D8D715A3-6E5E-11D0-B3F0-00AA003761C5")
interface IAMVfwCompressDialogs : IUnknown
{
    HRESULT ShowDialog(int iDialog, HWND hwnd);
    HRESULT GetState(char* pState, int* pcbState);
    HRESULT SetState(char* pState, int cbState);
    HRESULT SendDriverMessage(int uMsg, int dw1, int dw2);
}

@GUID("C6E13344-30AC-11D0-A18C-00A0C9118956")
interface IAMDroppedFrames : IUnknown
{
    HRESULT GetNumDropped(int* plDropped);
    HRESULT GetNumNotDropped(int* plNotDropped);
    HRESULT GetDroppedInfo(int lSize, int* plArray, int* plNumCopied);
    HRESULT GetAverageFrameSize(int* plAverageSize);
}

@GUID("54C39221-8380-11D0-B3F0-00AA003761C5")
interface IAMAudioInputMixer : IUnknown
{
    HRESULT put_Enable(BOOL fEnable);
    HRESULT get_Enable(int* pfEnable);
    HRESULT put_Mono(BOOL fMono);
    HRESULT get_Mono(int* pfMono);
    HRESULT put_MixLevel(double Level);
    HRESULT get_MixLevel(double* pLevel);
    HRESULT put_Pan(double Pan);
    HRESULT get_Pan(double* pPan);
    HRESULT put_Loudness(BOOL fLoudness);
    HRESULT get_Loudness(int* pfLoudness);
    HRESULT put_Treble(double Treble);
    HRESULT get_Treble(double* pTreble);
    HRESULT get_TrebleRange(double* pRange);
    HRESULT put_Bass(double Bass);
    HRESULT get_Bass(double* pBass);
    HRESULT get_BassRange(double* pRange);
}

@GUID("56ED71A0-AF5F-11D0-B3F0-00AA003761C5")
interface IAMBufferNegotiation : IUnknown
{
    HRESULT SuggestAllocatorProperties(const(ALLOCATOR_PROPERTIES)* pprop);
    HRESULT GetAllocatorProperties(ALLOCATOR_PROPERTIES* pprop);
}

@GUID("C6E13350-30AC-11D0-A18C-00A0C9118956")
interface IAMAnalogVideoDecoder : IUnknown
{
    HRESULT get_AvailableTVFormats(int* lAnalogVideoStandard);
    HRESULT put_TVFormat(int lAnalogVideoStandard);
    HRESULT get_TVFormat(int* plAnalogVideoStandard);
    HRESULT get_HorizontalLocked(int* plLocked);
    HRESULT put_VCRHorizontalLocking(int lVCRHorizontalLocking);
    HRESULT get_VCRHorizontalLocking(int* plVCRHorizontalLocking);
    HRESULT get_NumberOfLines(int* plNumberOfLines);
    HRESULT put_OutputEnable(int lOutputEnable);
    HRESULT get_OutputEnable(int* plOutputEnable);
}

@GUID("C6E13360-30AC-11D0-A18C-00A0C9118956")
interface IAMVideoProcAmp : IUnknown
{
    HRESULT GetRange(int Property, int* pMin, int* pMax, int* pSteppingDelta, int* pDefault, int* pCapsFlags);
    HRESULT Set(int Property, int lValue, int Flags);
    HRESULT Get(int Property, int* lValue, int* Flags);
}

@GUID("C6E13370-30AC-11D0-A18C-00A0C9118956")
interface IAMCameraControl : IUnknown
{
    HRESULT GetRange(int Property, int* pMin, int* pMax, int* pSteppingDelta, int* pDefault, int* pCapsFlags);
    HRESULT Set(int Property, int lValue, int Flags);
    HRESULT Get(int Property, int* lValue, int* Flags);
}

@GUID("6A2E0670-28E4-11D0-A18C-00A0C9118956")
interface IAMVideoControl : IUnknown
{
    HRESULT GetCaps(IPin pPin, int* pCapsFlags);
    HRESULT SetMode(IPin pPin, int Mode);
    HRESULT GetMode(IPin pPin, int* Mode);
    HRESULT GetCurrentActualFrameRate(IPin pPin, long* ActualFrameRate);
    HRESULT GetMaxAvailableFrameRate(IPin pPin, int iIndex, SIZE Dimensions, long* MaxAvailableFrameRate);
    HRESULT GetFrameRateList(IPin pPin, int iIndex, SIZE Dimensions, int* ListSize, long** FrameRates);
}

@GUID("C6E13380-30AC-11D0-A18C-00A0C9118956")
interface IAMCrossbar : IUnknown
{
    HRESULT get_PinCounts(int* OutputPinCount, int* InputPinCount);
    HRESULT CanRoute(int OutputPinIndex, int InputPinIndex);
    HRESULT Route(int OutputPinIndex, int InputPinIndex);
    HRESULT get_IsRoutedTo(int OutputPinIndex, int* InputPinIndex);
    HRESULT get_CrossbarPinInfo(BOOL IsInputPin, int PinIndex, int* PinIndexRelated, int* PhysicalType);
}

@GUID("211A8761-03AC-11D1-8D13-00AA00BD8339")
interface IAMTuner : IUnknown
{
    HRESULT put_Channel(int lChannel, int lVideoSubChannel, int lAudioSubChannel);
    HRESULT get_Channel(int* plChannel, int* plVideoSubChannel, int* plAudioSubChannel);
    HRESULT ChannelMinMax(int* lChannelMin, int* lChannelMax);
    HRESULT put_CountryCode(int lCountryCode);
    HRESULT get_CountryCode(int* plCountryCode);
    HRESULT put_TuningSpace(int lTuningSpace);
    HRESULT get_TuningSpace(int* plTuningSpace);
    HRESULT Logon(HANDLE hCurrentUser);
    HRESULT Logout();
    HRESULT SignalPresent(int* plSignalStrength);
    HRESULT put_Mode(AMTunerModeType lMode);
    HRESULT get_Mode(AMTunerModeType* plMode);
    HRESULT GetAvailableModes(int* plModes);
    HRESULT RegisterNotificationCallBack(IAMTunerNotification pNotify, int lEvents);
    HRESULT UnRegisterNotificationCallBack(IAMTunerNotification pNotify);
}

@GUID("211A8760-03AC-11D1-8D13-00AA00BD8339")
interface IAMTunerNotification : IUnknown
{
    HRESULT OnEvent(AMTunerEventType Event);
}

@GUID("211A8766-03AC-11D1-8D13-00AA00BD8339")
interface IAMTVTuner : IAMTuner
{
    HRESULT get_AvailableTVFormats(int* lAnalogVideoStandard);
    HRESULT get_TVFormat(int* plAnalogVideoStandard);
    HRESULT AutoTune(int lChannel, int* plFoundSignal);
    HRESULT StoreAutoTune();
    HRESULT get_NumInputConnections(int* plNumInputConnections);
    HRESULT put_InputType(int lIndex, TunerInputType InputType);
    HRESULT get_InputType(int lIndex, TunerInputType* pInputType);
    HRESULT put_ConnectInput(int lIndex);
    HRESULT get_ConnectInput(int* plIndex);
    HRESULT get_VideoFrequency(int* lFreq);
    HRESULT get_AudioFrequency(int* lFreq);
}

@GUID("211A8765-03AC-11D1-8D13-00AA00BD8339")
interface IBPCSatelliteTuner : IAMTuner
{
    HRESULT get_DefaultSubChannelTypes(int* plDefaultVideoType, int* plDefaultAudioType);
    HRESULT put_DefaultSubChannelTypes(int lDefaultVideoType, int lDefaultAudioType);
    HRESULT IsTapingPermitted();
}

@GUID("83EC1C30-23D1-11D1-99E6-00A0C9560266")
interface IAMTVAudio : IUnknown
{
    HRESULT GetHardwareSupportedTVAudioModes(int* plModes);
    HRESULT GetAvailableTVAudioModes(int* plModes);
    HRESULT get_TVAudioMode(int* plMode);
    HRESULT put_TVAudioMode(int lMode);
    HRESULT RegisterNotificationCallBack(IAMTunerNotification pNotify, int lEvents);
    HRESULT UnRegisterNotificationCallBack(IAMTunerNotification pNotify);
}

@GUID("83EC1C33-23D1-11D1-99E6-00A0C9560266")
interface IAMTVAudioNotification : IUnknown
{
    HRESULT OnEvent(AMTVAudioEventType Event);
}

@GUID("C6E133B0-30AC-11D0-A18C-00A0C9118956")
interface IAMAnalogVideoEncoder : IUnknown
{
    HRESULT get_AvailableTVFormats(int* lAnalogVideoStandard);
    HRESULT put_TVFormat(int lAnalogVideoStandard);
    HRESULT get_TVFormat(int* plAnalogVideoStandard);
    HRESULT put_CopyProtection(int lVideoCopyProtection);
    HRESULT get_CopyProtection(int* lVideoCopyProtection);
    HRESULT put_CCEnable(int lCCEnable);
    HRESULT get_CCEnable(int* lCCEnable);
}

@GUID("31EFAC30-515C-11D0-A9AA-00AA0061BE93")
interface IKsPropertySet : IUnknown
{
    HRESULT Set(const(GUID)* guidPropSet, uint dwPropID, char* pInstanceData, uint cbInstanceData, char* pPropData, 
                uint cbPropData);
    HRESULT Get(const(GUID)* guidPropSet, uint dwPropID, char* pInstanceData, uint cbInstanceData, char* pPropData, 
                uint cbPropData, uint* pcbReturned);
    HRESULT QuerySupported(const(GUID)* guidPropSet, uint dwPropID, uint* pTypeSupport);
}

@GUID("6025A880-C0D5-11D0-BD4E-00A0C911CE86")
interface IMediaPropertyBag : IPropertyBag
{
    HRESULT EnumProperty(uint iProperty, VARIANT* pvarPropertyName, VARIANT* pvarPropertyValue);
}

@GUID("5738E040-B67F-11D0-BD4D-00A0C911CE86")
interface IPersistMediaPropertyBag : IPersist
{
    HRESULT InitNew();
    HRESULT Load(IMediaPropertyBag pPropBag, IErrorLog pErrorLog);
    HRESULT Save(IMediaPropertyBag pPropBag, BOOL fClearDirty, BOOL fSaveAllProperties);
}

@GUID("F938C991-3029-11CF-8C44-00AA006B6814")
interface IAMPhysicalPinInfo : IUnknown
{
    HRESULT GetPhysicalType(int* pType, ushort** ppszType);
}

@GUID("B5730A90-1A2C-11CF-8C23-00AA006B6814")
interface IAMExtDevice : IUnknown
{
    HRESULT GetCapability(int Capability, int* pValue, double* pdblValue);
    HRESULT get_ExternalDeviceID(ushort** ppszData);
    HRESULT get_ExternalDeviceVersion(ushort** ppszData);
    HRESULT put_DevicePower(int PowerMode);
    HRESULT get_DevicePower(int* pPowerMode);
    HRESULT Calibrate(size_t hEvent, int Mode, int* pStatus);
    HRESULT put_DevicePort(int DevicePort);
    HRESULT get_DevicePort(int* pDevicePort);
}

@GUID("A03CD5F0-3045-11CF-8C44-00AA006B6814")
interface IAMExtTransport : IUnknown
{
    HRESULT GetCapability(int Capability, int* pValue, double* pdblValue);
    HRESULT put_MediaState(int State);
    HRESULT get_MediaState(int* pState);
    HRESULT put_LocalControl(int State);
    HRESULT get_LocalControl(int* pState);
    HRESULT GetStatus(int StatusItem, int* pValue);
    HRESULT GetTransportBasicParameters(int Param, int* pValue, ushort** ppszData);
    HRESULT SetTransportBasicParameters(int Param, int Value, ushort* pszData);
    HRESULT GetTransportVideoParameters(int Param, int* pValue);
    HRESULT SetTransportVideoParameters(int Param, int Value);
    HRESULT GetTransportAudioParameters(int Param, int* pValue);
    HRESULT SetTransportAudioParameters(int Param, int Value);
    HRESULT put_Mode(int Mode);
    HRESULT get_Mode(int* pMode);
    HRESULT put_Rate(double dblRate);
    HRESULT get_Rate(double* pdblRate);
    HRESULT GetChase(int* pEnabled, int* pOffset, size_t* phEvent);
    HRESULT SetChase(int Enable, int Offset, size_t hEvent);
    HRESULT GetBump(int* pSpeed, int* pDuration);
    HRESULT SetBump(int Speed, int Duration);
    HRESULT get_AntiClogControl(int* pEnabled);
    HRESULT put_AntiClogControl(int Enable);
    HRESULT GetEditPropertySet(int EditID, int* pState);
    HRESULT SetEditPropertySet(int* pEditID, int State);
    HRESULT GetEditProperty(int EditID, int Param, int* pValue);
    HRESULT SetEditProperty(int EditID, int Param, int Value);
    HRESULT get_EditStart(int* pValue);
    HRESULT put_EditStart(int Value);
}

@GUID("9B496CE1-811B-11CF-8C77-00AA006B6814")
interface IAMTimecodeReader : IUnknown
{
    HRESULT GetTCRMode(int Param, int* pValue);
    HRESULT SetTCRMode(int Param, int Value);
    HRESULT put_VITCLine(int Line);
    HRESULT get_VITCLine(int* pLine);
    HRESULT GetTimecode(TIMECODE_SAMPLE* pTimecodeSample);
}

@GUID("9B496CE0-811B-11CF-8C77-00AA006B6814")
interface IAMTimecodeGenerator : IUnknown
{
    HRESULT GetTCGMode(int Param, int* pValue);
    HRESULT SetTCGMode(int Param, int Value);
    HRESULT put_VITCLine(int Line);
    HRESULT get_VITCLine(int* pLine);
    HRESULT SetTimecode(TIMECODE_SAMPLE* pTimecodeSample);
    HRESULT GetTimecode(TIMECODE_SAMPLE* pTimecodeSample);
}

@GUID("9B496CE2-811B-11CF-8C77-00AA006B6814")
interface IAMTimecodeDisplay : IUnknown
{
    HRESULT GetTCDisplayEnable(int* pState);
    HRESULT SetTCDisplayEnable(int State);
    HRESULT GetTCDisplay(int Param, int* pValue);
    HRESULT SetTCDisplay(int Param, int Value);
}

@GUID("C6545BF0-E76B-11D0-BD52-00A0C911CE86")
interface IAMDevMemoryAllocator : IUnknown
{
    HRESULT GetInfo(uint* pdwcbTotalFree, uint* pdwcbLargestFree, uint* pdwcbTotalMemory, uint* pdwcbMinimumChunk);
    HRESULT CheckMemory(const(ubyte)* pBuffer);
    HRESULT Alloc(ubyte** ppBuffer, uint* pdwcbBuffer);
    HRESULT Free(ubyte* pBuffer);
    HRESULT GetDevMemoryObject(IUnknown* ppUnkInnner, IUnknown pUnkOuter);
}

@GUID("C6545BF1-E76B-11D0-BD52-00A0C911CE86")
interface IAMDevMemoryControl : IUnknown
{
    HRESULT QueryWriteSync();
    HRESULT WriteSync();
    HRESULT GetDevId(uint* pdwDevId);
}

@GUID("C1960960-17F5-11D1-ABE1-00A0C905F375")
interface IAMStreamSelect : IUnknown
{
    HRESULT Count(uint* pcStreams);
    HRESULT Info(int lIndex, AM_MEDIA_TYPE** ppmt, uint* pdwFlags, uint* plcid, uint* pdwGroup, ushort** ppszName, 
                 IUnknown* ppObject, IUnknown* ppUnk);
    HRESULT Enable(int lIndex, uint dwFlags);
}

@GUID("8389D2D0-77D7-11D1-ABE6-00A0C905F375")
interface IAMResourceControl : IUnknown
{
    HRESULT Reserve(uint dwFlags, void* pvReserved);
}

@GUID("4D5466B0-A49C-11D1-ABE8-00A0C905F375")
interface IAMClockAdjust : IUnknown
{
    HRESULT SetClockDelta(long rtDelta);
}

@GUID("2DD74950-A890-11D1-ABE8-00A0C905F375")
interface IAMFilterMiscFlags : IUnknown
{
    uint GetMiscFlags();
}

@GUID("48EFB120-AB49-11D2-AED2-00A0C995E8D5")
interface IDrawVideoImage : IUnknown
{
    HRESULT DrawVideoImageBegin();
    HRESULT DrawVideoImageEnd();
    HRESULT DrawVideoImageDraw(HDC hdc, RECT* lprcSrc, RECT* lprcDst);
}

@GUID("2E5EA3E0-E924-11D2-B6DA-00A0C995E8DF")
interface IDecimateVideoImage : IUnknown
{
    HRESULT SetDecimationImageSize(int lWidth, int lHeight);
    HRESULT ResetDecimationImageSize();
}

@GUID("60D32930-13DA-11D3-9EC6-C4FCAEF5C7BE")
interface IAMVideoDecimationProperties : IUnknown
{
    HRESULT QueryDecimationUsage(DECIMATION_USAGE* lpUsage);
    HRESULT SetDecimationUsage(DECIMATION_USAGE Usage);
}

@GUID("E46A9787-2B71-444D-A4B5-1FAB7B708D6A")
interface IVideoFrameStep : IUnknown
{
    HRESULT Step(uint dwFrames, IUnknown pStepObject);
    HRESULT CanStep(int bMultiple, IUnknown pStepObject);
    HRESULT CancelStep();
}

@GUID("62EA93BA-EC62-11D2-B770-00C04FB6BD3D")
interface IAMLatency : IUnknown
{
    HRESULT GetLatency(long* prtLatency);
}

@GUID("F185FE76-E64E-11D2-B76E-00C04FB6BD3D")
interface IAMPushSource : IAMLatency
{
    HRESULT GetPushSourceFlags(uint* pFlags);
    HRESULT SetPushSourceFlags(uint Flags);
    HRESULT SetStreamOffset(long rtOffset);
    HRESULT GetStreamOffset(long* prtOffset);
    HRESULT GetMaxStreamOffset(long* prtMaxOffset);
    HRESULT SetMaxStreamOffset(long rtMaxOffset);
}

@GUID("F90A6130-B658-11D2-AE49-0000F8754B99")
interface IAMDeviceRemoval : IUnknown
{
    HRESULT DeviceInfo(GUID* pclsidInterfaceClass, ushort** pwszSymbolicLink);
    HRESULT Reassociate();
    HRESULT Disassociate();
}

@GUID("D18E17A0-AACB-11D0-AFB0-00AA00B67A42")
interface IDVEnc : IUnknown
{
    HRESULT get_IFormatResolution(int* VideoFormat, int* DVFormat, int* Resolution, ubyte fDVInfo, DVINFO* sDVInfo);
    HRESULT put_IFormatResolution(int VideoFormat, int DVFormat, int Resolution, ubyte fDVInfo, DVINFO* sDVInfo);
}

@GUID("B8E8BD60-0BFE-11D0-AF91-00AA00B67A42")
interface IIPDVDec : IUnknown
{
    HRESULT get_IPDisplay(int* displayPix);
    HRESULT put_IPDisplay(int displayPix);
}

@GUID("58473A19-2BC8-4663-8012-25F81BABDDD1")
interface IDVRGB219 : IUnknown
{
    HRESULT SetRGB219(BOOL bState);
}

@GUID("92A3A302-DA7C-4A1F-BA7E-1802BB5D2D02")
interface IDVSplitter : IUnknown
{
    HRESULT DiscardAlternateVideoFrames(int nDiscard);
}

@GUID("22320CB2-D41A-11D2-BF7C-D7CB9DF0BF93")
interface IAMAudioRendererStats : IUnknown
{
    HRESULT GetStatParam(uint dwParam, uint* pdwParam1, uint* pdwParam2);
}

@GUID("632105FA-072E-11D3-8AF9-00C04FB6BD3D")
interface IAMGraphStreams : IUnknown
{
    HRESULT FindUpstreamInterface(IPin pPin, const(GUID)* riid, void** ppvInterface, uint dwFlags);
    HRESULT SyncUsingStreamOffset(BOOL bUseStreamOffset);
    HRESULT SetMaxGraphLatency(long rtMaxGraphLatency);
}

@GUID("62FAE250-7E65-4460-BFC9-6398B322073C")
interface IAMOverlayFX : IUnknown
{
    HRESULT QueryOverlayFXCaps(uint* lpdwOverlayFXCaps);
    HRESULT SetOverlayFX(uint dwOverlayFX);
    HRESULT GetOverlayFX(uint* lpdwOverlayFX);
}

@GUID("8E1C39A1-DE53-11CF-AA63-0080C744528D")
interface IAMOpenProgress : IUnknown
{
    HRESULT QueryProgress(long* pllTotal, long* pllCurrent);
    HRESULT AbortOperation();
}

@GUID("436EEE9C-264F-4242-90E1-4E330C107512")
interface IMpeg2Demultiplexer : IUnknown
{
    HRESULT CreateOutputPin(AM_MEDIA_TYPE* pMediaType, const(wchar)* pszPinName, IPin* ppIPin);
    HRESULT SetOutputPinMediaType(const(wchar)* pszPinName, AM_MEDIA_TYPE* pMediaType);
    HRESULT DeleteOutputPin(const(wchar)* pszPinName);
}

@GUID("945C1566-6202-46FC-96C7-D87F289C6534")
interface IEnumStreamIdMap : IUnknown
{
    HRESULT Next(uint cRequest, char* pStreamIdMap, uint* pcReceived);
    HRESULT Skip(uint cRecords);
    HRESULT Reset();
    HRESULT Clone(IEnumStreamIdMap* ppIEnumStreamIdMap);
}

@GUID("D0E04C47-25B8-4369-925A-362A01D95444")
interface IMPEG2StreamIdMap : IUnknown
{
    HRESULT MapStreamId(uint ulStreamId, uint MediaSampleContent, uint ulSubstreamFilterValue, int iDataOffset);
    HRESULT UnmapStreamId(uint culStreamId, char* pulStreamId);
    HRESULT EnumStreamIdMap(IEnumStreamIdMap* ppIEnumStreamIdMap);
}

@GUID("7B3A2F01-0751-48DD-B556-004785171C54")
interface IRegisterServiceProvider : IUnknown
{
    HRESULT RegisterService(const(GUID)* guidService, IUnknown pUnkObject);
}

@GUID("9FD52741-176D-4B36-8F51-CA8F933223BE")
interface IAMClockSlave : IUnknown
{
    HRESULT SetErrorTolerance(uint dwTolerance);
    HRESULT GetErrorTolerance(uint* pdwTolerance);
}

@GUID("4995F511-9DDB-4F12-BD3B-F04611807B79")
interface IAMGraphBuilderCallback : IUnknown
{
    HRESULT SelectedFilter(IMoniker pMon);
    HRESULT CreatedFilter(IBaseFilter pFil);
}

interface IAMFilterGraphCallback : IUnknown
{
    HRESULT UnableToRender(IPin pPin);
}

@GUID("A8809222-07BB-48EA-951C-33158100625B")
interface IGetCapabilitiesKey : IUnknown
{
    HRESULT GetCapabilitiesKey(HKEY* pHKey);
}

@GUID("70423839-6ACC-4B23-B079-21DBF08156A5")
interface IEncoderAPI : IUnknown
{
    HRESULT IsSupported(const(GUID)* Api);
    HRESULT IsAvailable(const(GUID)* Api);
    HRESULT GetParameterRange(const(GUID)* Api, VARIANT* ValueMin, VARIANT* ValueMax, VARIANT* SteppingDelta);
    HRESULT GetParameterValues(const(GUID)* Api, char* Values, uint* ValuesCount);
    HRESULT GetDefaultValue(const(GUID)* Api, VARIANT* Value);
    HRESULT GetValue(const(GUID)* Api, VARIANT* Value);
    HRESULT SetValue(const(GUID)* Api, VARIANT* Value);
}

@GUID("02997C3B-8E1B-460E-9270-545E0DE9563E")
interface IVideoEncoder : IEncoderAPI
{
}

@GUID("C0DFF467-D499-4986-972B-E1D9090FA941")
interface IAMDecoderCaps : IUnknown
{
    HRESULT GetDecoderCaps(uint dwCapIndex, uint* lpdwCap);
}

@GUID("6FEDED3E-0FF1-4901-A2F1-43F7012C8515")
interface IAMCertifiedOutputProtection : IUnknown
{
    HRESULT KeyExchange(GUID* pRandom, ubyte** VarLenCertGH, uint* pdwLengthCertGH);
    HRESULT SessionSequenceStart(AMCOPPSignature* pSig);
    HRESULT ProtectionCommand(const(AMCOPPCommand)* cmd);
    HRESULT ProtectionStatus(const(AMCOPPStatusInput)* pStatusInput, AMCOPPStatusOutput* pStatusOutput);
}

@GUID("CF7B26FC-9A00-485B-8147-3E789D5E8F67")
interface IAMAsyncReaderTimestampScaling : IUnknown
{
    HRESULT GetTimestampMode(int* pfRaw);
    HRESULT SetTimestampMode(BOOL fRaw);
}

@GUID("0E26A181-F40C-4635-8786-976284B52981")
interface IAMPluginControl : IUnknown
{
    HRESULT GetPreferredClsid(const(GUID)* subType, GUID* clsid);
    HRESULT GetPreferredClsidByIndex(uint index, GUID* subType, GUID* clsid);
    HRESULT SetPreferredClsid(const(GUID)* subType, const(GUID)* clsid);
    HRESULT IsDisabled(const(GUID)* clsid);
    HRESULT GetDisabledByIndex(uint index, GUID* clsid);
    HRESULT SetDisabled(const(GUID)* clsid, BOOL disabled);
    HRESULT IsLegacyDisabled(const(wchar)* dllName);
}

@GUID("4A9A62D3-27D4-403D-91E9-89F540E55534")
interface IPinConnection : IUnknown
{
    HRESULT DynamicQueryAccept(const(AM_MEDIA_TYPE)* pmt);
    HRESULT NotifyEndOfStream(HANDLE hNotifyEvent);
    HRESULT IsEndPin();
    HRESULT DynamicDisconnect();
}

@GUID("C56E9858-DBF3-4F6B-8119-384AF2060DEB")
interface IPinFlowControl : IUnknown
{
    HRESULT Block(uint dwBlockFlags, HANDLE hEvent);
}

@GUID("03A1EB8E-32BF-4245-8502-114D08A9CB88")
interface IGraphConfig : IUnknown
{
    HRESULT Reconnect(IPin pOutputPin, IPin pInputPin, const(AM_MEDIA_TYPE)* pmtFirstConnection, 
                      IBaseFilter pUsingFilter, HANDLE hAbortEvent, uint dwFlags);
    HRESULT Reconfigure(IGraphConfigCallback pCallback, void* pvContext, uint dwFlags, HANDLE hAbortEvent);
    HRESULT AddFilterToCache(IBaseFilter pFilter);
    HRESULT EnumCacheFilter(IEnumFilters* pEnum);
    HRESULT RemoveFilterFromCache(IBaseFilter pFilter);
    HRESULT GetStartTime(long* prtStart);
    HRESULT PushThroughData(IPin pOutputPin, IPinConnection pConnection, HANDLE hEventAbort);
    HRESULT SetFilterFlags(IBaseFilter pFilter, uint dwFlags);
    HRESULT GetFilterFlags(IBaseFilter pFilter, uint* pdwFlags);
    HRESULT RemoveFilterEx(IBaseFilter pFilter, uint Flags);
}

@GUID("ADE0FD60-D19D-11D2-ABF6-00A0C905F375")
interface IGraphConfigCallback : IUnknown
{
    HRESULT Reconfigure(void* pvContext, uint dwFlags);
}

@GUID("DCFBDCF6-0DC2-45F5-9AB2-7C330EA09C29")
interface IFilterChain : IUnknown
{
    HRESULT StartChain(IBaseFilter pStartFilter, IBaseFilter pEndFilter);
    HRESULT PauseChain(IBaseFilter pStartFilter, IBaseFilter pEndFilter);
    HRESULT StopChain(IBaseFilter pStartFilter, IBaseFilter pEndFilter);
    HRESULT RemoveChain(IBaseFilter pStartFilter, IBaseFilter pEndFilter);
}

@GUID("CE704FE7-E71E-41FB-BAA2-C4403E1182F5")
interface IVMRImagePresenter : IUnknown
{
    HRESULT StartPresenting(size_t dwUserID);
    HRESULT StopPresenting(size_t dwUserID);
    HRESULT PresentImage(size_t dwUserID, VMRPRESENTATIONINFO* lpPresInfo);
}

@GUID("31CE832E-4484-458B-8CCA-F4D7E3DB0B52")
interface IVMRSurfaceAllocator : IUnknown
{
    HRESULT AllocateSurface(size_t dwUserID, VMRALLOCATIONINFO* lpAllocInfo, uint* lpdwActualBuffers, 
                            IDirectDrawSurface7* lplpSurface);
    HRESULT FreeSurface(size_t dwID);
    HRESULT PrepareSurface(size_t dwUserID, IDirectDrawSurface7 lpSurface, uint dwSurfaceFlags);
    HRESULT AdviseNotify(IVMRSurfaceAllocatorNotify lpIVMRSurfAllocNotify);
}

@GUID("AADA05A8-5A4E-4729-AF0B-CEA27AED51E2")
interface IVMRSurfaceAllocatorNotify : IUnknown
{
    HRESULT AdviseSurfaceAllocator(size_t dwUserID, IVMRSurfaceAllocator lpIVRMSurfaceAllocator);
    HRESULT SetDDrawDevice(IDirectDraw7 lpDDrawDevice, ptrdiff_t hMonitor);
    HRESULT ChangeDDrawDevice(IDirectDraw7 lpDDrawDevice, ptrdiff_t hMonitor);
    HRESULT RestoreDDrawSurfaces();
    HRESULT NotifyEvent(int EventCode, ptrdiff_t Param1, ptrdiff_t Param2);
    HRESULT SetBorderColor(uint clrBorder);
}

@GUID("0EB1088C-4DCD-46F0-878F-39DAE86A51B7")
interface IVMRWindowlessControl : IUnknown
{
    HRESULT GetNativeVideoSize(int* lpWidth, int* lpHeight, int* lpARWidth, int* lpARHeight);
    HRESULT GetMinIdealVideoSize(int* lpWidth, int* lpHeight);
    HRESULT GetMaxIdealVideoSize(int* lpWidth, int* lpHeight);
    HRESULT SetVideoPosition(const(RECT)* lpSRCRect, const(RECT)* lpDSTRect);
    HRESULT GetVideoPosition(RECT* lpSRCRect, RECT* lpDSTRect);
    HRESULT GetAspectRatioMode(uint* lpAspectRatioMode);
    HRESULT SetAspectRatioMode(uint AspectRatioMode);
    HRESULT SetVideoClippingWindow(HWND hwnd);
    HRESULT RepaintVideo(HWND hwnd, HDC hdc);
    HRESULT DisplayModeChanged();
    HRESULT GetCurrentImage(ubyte** lpDib);
    HRESULT SetBorderColor(uint Clr);
    HRESULT GetBorderColor(uint* lpClr);
    HRESULT SetColorKey(uint Clr);
    HRESULT GetColorKey(uint* lpClr);
}

@GUID("1C1A17B0-BED0-415D-974B-DC6696131599")
interface IVMRMixerControl : IUnknown
{
    HRESULT SetAlpha(uint dwStreamID, float Alpha);
    HRESULT GetAlpha(uint dwStreamID, float* pAlpha);
    HRESULT SetZOrder(uint dwStreamID, uint dwZ);
    HRESULT GetZOrder(uint dwStreamID, uint* pZ);
    HRESULT SetOutputRect(uint dwStreamID, const(NORMALIZEDRECT)* pRect);
    HRESULT GetOutputRect(uint dwStreamID, NORMALIZEDRECT* pRect);
    HRESULT SetBackgroundClr(uint ClrBkg);
    HRESULT GetBackgroundClr(uint* lpClrBkg);
    HRESULT SetMixingPrefs(uint dwMixerPrefs);
    HRESULT GetMixingPrefs(uint* pdwMixerPrefs);
}

@GUID("9CF0B1B6-FBAA-4B7F-88CF-CF1F130A0DCE")
interface IVMRMonitorConfig : IUnknown
{
    HRESULT SetMonitor(const(VMRGUID)* pGUID);
    HRESULT GetMonitor(VMRGUID* pGUID);
    HRESULT SetDefaultMonitor(const(VMRGUID)* pGUID);
    HRESULT GetDefaultMonitor(VMRGUID* pGUID);
    HRESULT GetAvailableMonitors(VMRMONITORINFO* pInfo, uint dwMaxInfoArraySize, uint* pdwNumDevices);
}

@GUID("9E5530C5-7034-48B4-BB46-0B8A6EFC8E36")
interface IVMRFilterConfig : IUnknown
{
    HRESULT SetImageCompositor(IVMRImageCompositor lpVMRImgCompositor);
    HRESULT SetNumberOfStreams(uint dwMaxStreams);
    HRESULT GetNumberOfStreams(uint* pdwMaxStreams);
    HRESULT SetRenderingPrefs(uint dwRenderFlags);
    HRESULT GetRenderingPrefs(uint* pdwRenderFlags);
    HRESULT SetRenderingMode(uint Mode);
    HRESULT GetRenderingMode(uint* pMode);
}

@GUID("EDE80B5C-BAD6-4623-B537-65586C9F8DFD")
interface IVMRAspectRatioControl : IUnknown
{
    HRESULT GetAspectRatioMode(uint* lpdwARMode);
    HRESULT SetAspectRatioMode(uint dwARMode);
}

@GUID("BB057577-0DB8-4E6A-87A7-1A8C9A505A0F")
interface IVMRDeinterlaceControl : IUnknown
{
    HRESULT GetNumberOfDeinterlaceModes(VMRVideoDesc* lpVideoDescription, uint* lpdwNumDeinterlaceModes, 
                                        GUID* lpDeinterlaceModes);
    HRESULT GetDeinterlaceModeCaps(GUID* lpDeinterlaceMode, VMRVideoDesc* lpVideoDescription, 
                                   VMRDeinterlaceCaps* lpDeinterlaceCaps);
    HRESULT GetDeinterlaceMode(uint dwStreamID, GUID* lpDeinterlaceMode);
    HRESULT SetDeinterlaceMode(uint dwStreamID, GUID* lpDeinterlaceMode);
    HRESULT GetDeinterlacePrefs(uint* lpdwDeinterlacePrefs);
    HRESULT SetDeinterlacePrefs(uint dwDeinterlacePrefs);
    HRESULT GetActualDeinterlaceMode(uint dwStreamID, GUID* lpDeinterlaceMode);
}

@GUID("1E673275-0257-40AA-AF20-7C608D4A0428")
interface IVMRMixerBitmap : IUnknown
{
    HRESULT SetAlphaBitmap(const(VMRALPHABITMAP)* pBmpParms);
    HRESULT UpdateAlphaBitmapParameters(VMRALPHABITMAP* pBmpParms);
    HRESULT GetAlphaBitmapParameters(VMRALPHABITMAP* pBmpParms);
}

@GUID("7A4FB5AF-479F-4074-BB40-CE6722E43C82")
interface IVMRImageCompositor : IUnknown
{
    HRESULT InitCompositionTarget(IUnknown pD3DDevice, IDirectDrawSurface7 pddsRenderTarget);
    HRESULT TermCompositionTarget(IUnknown pD3DDevice, IDirectDrawSurface7 pddsRenderTarget);
    HRESULT SetStreamMediaType(uint dwStrmID, AM_MEDIA_TYPE* pmt, BOOL fTexture);
    HRESULT CompositeImage(IUnknown pD3DDevice, IDirectDrawSurface7 pddsRenderTarget, 
                           AM_MEDIA_TYPE* pmtRenderTarget, long rtStart, long rtEnd, uint dwClrBkGnd, 
                           VMRVIDEOSTREAMINFO* pVideoStreamInfo, uint cStreams);
}

@GUID("058D1F11-2A54-4BEF-BD54-DF706626B727")
interface IVMRVideoStreamControl : IUnknown
{
    HRESULT SetColorKey(DDCOLORKEY* lpClrKey);
    HRESULT GetColorKey(DDCOLORKEY* lpClrKey);
    HRESULT SetStreamActiveState(BOOL fActive);
    HRESULT GetStreamActiveState(int* lpfActive);
}

@GUID("A9849BBE-9EC8-4263-B764-62730F0D15D0")
interface IVMRSurface : IUnknown
{
    HRESULT IsSurfaceLocked();
    HRESULT LockSurface(ubyte** lpSurface);
    HRESULT UnlockSurface();
    HRESULT GetSurface(IDirectDrawSurface7* lplpSurface);
}

@GUID("9F3A1C85-8555-49BA-935F-BE5B5B29D178")
interface IVMRImagePresenterConfig : IUnknown
{
    HRESULT SetRenderingPrefs(uint dwRenderFlags);
    HRESULT GetRenderingPrefs(uint* dwRenderFlags);
}

@GUID("E6F7CE40-4673-44F1-8F77-5499D68CB4EA")
interface IVMRImagePresenterExclModeConfig : IVMRImagePresenterConfig
{
    HRESULT SetXlcModeDDObjAndPrimarySurface(IDirectDraw7 lpDDObj, IDirectDrawSurface7 lpPrimarySurf);
    HRESULT GetXlcModeDDObjAndPrimarySurface(IDirectDraw7* lpDDObj, IDirectDrawSurface7* lpPrimarySurf);
}

@GUID("AAC18C18-E186-46D2-825D-A1F8DC8E395A")
interface IVPManager : IUnknown
{
    HRESULT SetVideoPortIndex(uint dwVideoPortIndex);
    HRESULT GetVideoPortIndex(uint* pdwVideoPortIndex);
}

@GUID("A70EFE61-E2A3-11D0-A9BE-00AA0061BE93")
interface IDvdControl : IUnknown
{
    HRESULT TitlePlay(uint ulTitle);
    HRESULT ChapterPlay(uint ulTitle, uint ulChapter);
    HRESULT TimePlay(uint ulTitle, uint bcdTime);
    HRESULT StopForResume();
    HRESULT GoUp();
    HRESULT TimeSearch(uint bcdTime);
    HRESULT ChapterSearch(uint ulChapter);
    HRESULT PrevPGSearch();
    HRESULT TopPGSearch();
    HRESULT NextPGSearch();
    HRESULT ForwardScan(double dwSpeed);
    HRESULT BackwardScan(double dwSpeed);
    HRESULT MenuCall(DVD_MENU_ID MenuID);
    HRESULT Resume();
    HRESULT UpperButtonSelect();
    HRESULT LowerButtonSelect();
    HRESULT LeftButtonSelect();
    HRESULT RightButtonSelect();
    HRESULT ButtonActivate();
    HRESULT ButtonSelectAndActivate(uint ulButton);
    HRESULT StillOff();
    HRESULT PauseOn();
    HRESULT PauseOff();
    HRESULT MenuLanguageSelect(uint Language);
    HRESULT AudioStreamChange(uint ulAudio);
    HRESULT SubpictureStreamChange(uint ulSubPicture, BOOL bDisplay);
    HRESULT AngleChange(uint ulAngle);
    HRESULT ParentalLevelSelect(uint ulParentalLevel);
    HRESULT ParentalCountrySelect(ushort wCountry);
    HRESULT KaraokeAudioPresentationModeChange(uint ulMode);
    HRESULT VideoModePreferrence(uint ulPreferredDisplayMode);
    HRESULT SetRoot(const(wchar)* pszPath);
    HRESULT MouseActivate(POINT point);
    HRESULT MouseSelect(POINT point);
    HRESULT ChapterPlayAutoStop(uint ulTitle, uint ulChapter, uint ulChaptersToPlay);
}

@GUID("A70EFE60-E2A3-11D0-A9BE-00AA0061BE93")
interface IDvdInfo : IUnknown
{
    HRESULT GetCurrentDomain(DVD_DOMAIN* pDomain);
    HRESULT GetCurrentLocation(DVD_PLAYBACK_LOCATION* pLocation);
    HRESULT GetTotalTitleTime(uint* pulTotalTime);
    HRESULT GetCurrentButton(uint* pulButtonsAvailable, uint* pulCurrentButton);
    HRESULT GetCurrentAngle(uint* pulAnglesAvailable, uint* pulCurrentAngle);
    HRESULT GetCurrentAudio(uint* pulStreamsAvailable, uint* pulCurrentStream);
    HRESULT GetCurrentSubpicture(uint* pulStreamsAvailable, uint* pulCurrentStream, int* pIsDisabled);
    HRESULT GetCurrentUOPS(uint* pUOP);
    HRESULT GetAllSPRMs(ushort** pRegisterArray);
    HRESULT GetAllGPRMs(ushort** pRegisterArray);
    HRESULT GetAudioLanguage(uint ulStream, uint* pLanguage);
    HRESULT GetSubpictureLanguage(uint ulStream, uint* pLanguage);
    HRESULT GetTitleAttributes(uint ulTitle, DVD_ATR* pATR);
    HRESULT GetVMGAttributes(DVD_ATR* pATR);
    HRESULT GetCurrentVideoAttributes(ubyte** pATR);
    HRESULT GetCurrentAudioAttributes(ubyte** pATR);
    HRESULT GetCurrentSubpictureAttributes(ubyte** pATR);
    HRESULT GetCurrentVolumeInfo(uint* pulNumOfVol, uint* pulThisVolNum, DVD_DISC_SIDE* pSide, 
                                 uint* pulNumOfTitles);
    HRESULT GetDVDTextInfo(char* pTextManager, uint ulBufSize, uint* pulActualSize);
    HRESULT GetPlayerParentalLevel(uint* pulParentalLevel, uint* pulCountryCode);
    HRESULT GetNumberOfChapters(uint ulTitle, uint* pulNumberOfChapters);
    HRESULT GetTitleParentalLevels(uint ulTitle, uint* pulParentalLevels);
    HRESULT GetRoot(const(char)* pRoot, uint ulBufSize, uint* pulActualSize);
}

@GUID("5A4A97E4-94EE-4A55-9751-74B5643AA27D")
interface IDvdCmd : IUnknown
{
    HRESULT WaitForStart();
    HRESULT WaitForEnd();
}

@GUID("86303D6D-1C4A-4087-AB42-F711167048EF")
interface IDvdState : IUnknown
{
    HRESULT GetDiscID(ulong* pullUniqueID);
    HRESULT GetParentalLevel(uint* pulParentalLevel);
}

@GUID("33BC7430-EEC0-11D2-8201-00A0C9D74842")
interface IDvdControl2 : IUnknown
{
    HRESULT PlayTitle(uint ulTitle, uint dwFlags, IDvdCmd* ppCmd);
    HRESULT PlayChapterInTitle(uint ulTitle, uint ulChapter, uint dwFlags, IDvdCmd* ppCmd);
    HRESULT PlayAtTimeInTitle(uint ulTitle, DVD_HMSF_TIMECODE* pStartTime, uint dwFlags, IDvdCmd* ppCmd);
    HRESULT Stop();
    HRESULT ReturnFromSubmenu(uint dwFlags, IDvdCmd* ppCmd);
    HRESULT PlayAtTime(DVD_HMSF_TIMECODE* pTime, uint dwFlags, IDvdCmd* ppCmd);
    HRESULT PlayChapter(uint ulChapter, uint dwFlags, IDvdCmd* ppCmd);
    HRESULT PlayPrevChapter(uint dwFlags, IDvdCmd* ppCmd);
    HRESULT ReplayChapter(uint dwFlags, IDvdCmd* ppCmd);
    HRESULT PlayNextChapter(uint dwFlags, IDvdCmd* ppCmd);
    HRESULT PlayForwards(double dSpeed, uint dwFlags, IDvdCmd* ppCmd);
    HRESULT PlayBackwards(double dSpeed, uint dwFlags, IDvdCmd* ppCmd);
    HRESULT ShowMenu(DVD_MENU_ID MenuID, uint dwFlags, IDvdCmd* ppCmd);
    HRESULT Resume(uint dwFlags, IDvdCmd* ppCmd);
    HRESULT SelectRelativeButton(DVD_RELATIVE_BUTTON buttonDir);
    HRESULT ActivateButton();
    HRESULT SelectButton(uint ulButton);
    HRESULT SelectAndActivateButton(uint ulButton);
    HRESULT StillOff();
    HRESULT Pause(BOOL bState);
    HRESULT SelectAudioStream(uint ulAudio, uint dwFlags, IDvdCmd* ppCmd);
    HRESULT SelectSubpictureStream(uint ulSubPicture, uint dwFlags, IDvdCmd* ppCmd);
    HRESULT SetSubpictureState(BOOL bState, uint dwFlags, IDvdCmd* ppCmd);
    HRESULT SelectAngle(uint ulAngle, uint dwFlags, IDvdCmd* ppCmd);
    HRESULT SelectParentalLevel(uint ulParentalLevel);
    HRESULT SelectParentalCountry(ubyte* bCountry);
    HRESULT SelectKaraokeAudioPresentationMode(uint ulMode);
    HRESULT SelectVideoModePreference(uint ulPreferredDisplayMode);
    HRESULT SetDVDDirectory(const(wchar)* pszwPath);
    HRESULT ActivateAtPosition(POINT point);
    HRESULT SelectAtPosition(POINT point);
    HRESULT PlayChaptersAutoStop(uint ulTitle, uint ulChapter, uint ulChaptersToPlay, uint dwFlags, IDvdCmd* ppCmd);
    HRESULT AcceptParentalLevelChange(BOOL bAccept);
    HRESULT SetOption(DVD_OPTION_FLAG flag, BOOL fState);
    HRESULT SetState(IDvdState pState, uint dwFlags, IDvdCmd* ppCmd);
    HRESULT PlayPeriodInTitleAutoStop(uint ulTitle, DVD_HMSF_TIMECODE* pStartTime, DVD_HMSF_TIMECODE* pEndTime, 
                                      uint dwFlags, IDvdCmd* ppCmd);
    HRESULT SetGPRM(uint ulIndex, ushort wValue, uint dwFlags, IDvdCmd* ppCmd);
    HRESULT SelectDefaultMenuLanguage(uint Language);
    HRESULT SelectDefaultAudioLanguage(uint Language, DVD_AUDIO_LANG_EXT audioExtension);
    HRESULT SelectDefaultSubpictureLanguage(uint Language, DVD_SUBPICTURE_LANG_EXT subpictureExtension);
}

@GUID("34151510-EEC0-11D2-8201-00A0C9D74842")
interface IDvdInfo2 : IUnknown
{
    HRESULT GetCurrentDomain(DVD_DOMAIN* pDomain);
    HRESULT GetCurrentLocation(DVD_PLAYBACK_LOCATION2* pLocation);
    HRESULT GetTotalTitleTime(DVD_HMSF_TIMECODE* pTotalTime, uint* ulTimeCodeFlags);
    HRESULT GetCurrentButton(uint* pulButtonsAvailable, uint* pulCurrentButton);
    HRESULT GetCurrentAngle(uint* pulAnglesAvailable, uint* pulCurrentAngle);
    HRESULT GetCurrentAudio(uint* pulStreamsAvailable, uint* pulCurrentStream);
    HRESULT GetCurrentSubpicture(uint* pulStreamsAvailable, uint* pulCurrentStream, int* pbIsDisabled);
    HRESULT GetCurrentUOPS(uint* pulUOPs);
    HRESULT GetAllSPRMs(ushort** pRegisterArray);
    HRESULT GetAllGPRMs(ushort** pRegisterArray);
    HRESULT GetAudioLanguage(uint ulStream, uint* pLanguage);
    HRESULT GetSubpictureLanguage(uint ulStream, uint* pLanguage);
    HRESULT GetTitleAttributes(uint ulTitle, DVD_MenuAttributes* pMenu, DVD_TitleAttributes* pTitle);
    HRESULT GetVMGAttributes(DVD_MenuAttributes* pATR);
    HRESULT GetCurrentVideoAttributes(DVD_VideoAttributes* pATR);
    HRESULT GetAudioAttributes(uint ulStream, DVD_AudioAttributes* pATR);
    HRESULT GetKaraokeAttributes(uint ulStream, DVD_KaraokeAttributes* pAttributes);
    HRESULT GetSubpictureAttributes(uint ulStream, DVD_SubpictureAttributes* pATR);
    HRESULT GetDVDVolumeInfo(uint* pulNumOfVolumes, uint* pulVolume, DVD_DISC_SIDE* pSide, uint* pulNumOfTitles);
    HRESULT GetDVDTextNumberOfLanguages(uint* pulNumOfLangs);
    HRESULT GetDVDTextLanguageInfo(uint ulLangIndex, uint* pulNumOfStrings, uint* pLangCode, 
                                   DVD_TextCharSet* pbCharacterSet);
    HRESULT GetDVDTextStringAsNative(uint ulLangIndex, uint ulStringIndex, ubyte* pbBuffer, uint ulMaxBufferSize, 
                                     uint* pulActualSize, DVD_TextStringType* pType);
    HRESULT GetDVDTextStringAsUnicode(uint ulLangIndex, uint ulStringIndex, ushort* pchwBuffer, 
                                      uint ulMaxBufferSize, uint* pulActualSize, DVD_TextStringType* pType);
    HRESULT GetPlayerParentalLevel(uint* pulParentalLevel, ubyte* pbCountryCode);
    HRESULT GetNumberOfChapters(uint ulTitle, uint* pulNumOfChapters);
    HRESULT GetTitleParentalLevels(uint ulTitle, uint* pulParentalLevels);
    HRESULT GetDVDDirectory(const(wchar)* pszwPath, uint ulMaxSize, uint* pulActualSize);
    HRESULT IsAudioStreamEnabled(uint ulStreamNum, int* pbEnabled);
    HRESULT GetDiscID(const(wchar)* pszwPath, ulong* pullDiscID);
    HRESULT GetState(IDvdState* pStateData);
    HRESULT GetMenuLanguages(uint* pLanguages, uint ulMaxLanguages, uint* pulActualLanguages);
    HRESULT GetButtonAtPosition(POINT point, uint* pulButtonIndex);
    HRESULT GetCmdFromEvent(ptrdiff_t lParam1, IDvdCmd* pCmdObj);
    HRESULT GetDefaultMenuLanguage(uint* pLanguage);
    HRESULT GetDefaultAudioLanguage(uint* pLanguage, DVD_AUDIO_LANG_EXT* pAudioExtension);
    HRESULT GetDefaultSubpictureLanguage(uint* pLanguage, DVD_SUBPICTURE_LANG_EXT* pSubpictureExtension);
    HRESULT GetDecoderCaps(DVD_DECODER_CAPS* pCaps);
    HRESULT GetButtonRect(uint ulButton, RECT* pRect);
    HRESULT IsSubpictureStreamEnabled(uint ulStreamNum, int* pbEnabled);
}

@GUID("FCC152B6-F372-11D0-8E00-00C04FD7C08B")
interface IDvdGraphBuilder : IUnknown
{
    HRESULT GetFiltergraph(IGraphBuilder* ppGB);
    HRESULT GetDvdInterface(const(GUID)* riid, void** ppvIF);
    HRESULT RenderDvdVideoVolume(const(wchar)* lpcwszPathName, uint dwFlags, AM_DVD_RENDERSTATUS* pStatus);
}

@GUID("153ACC21-D83B-11D1-82BF-00A0C9696C8F")
interface IDDrawExclModeVideo : IUnknown
{
    HRESULT SetDDrawObject(IDirectDraw pDDrawObject);
    HRESULT GetDDrawObject(IDirectDraw* ppDDrawObject, int* pbUsingExternal);
    HRESULT SetDDrawSurface(IDirectDrawSurface pDDrawSurface);
    HRESULT GetDDrawSurface(IDirectDrawSurface* ppDDrawSurface, int* pbUsingExternal);
    HRESULT SetDrawParameters(const(RECT)* prcSource, const(RECT)* prcTarget);
    HRESULT GetNativeVideoProps(uint* pdwVideoWidth, uint* pdwVideoHeight, uint* pdwPictAspectRatioX, 
                                uint* pdwPictAspectRatioY);
    HRESULT SetCallbackInterface(IDDrawExclModeVideoCallback pCallback, uint dwFlags);
}

@GUID("913C24A0-20AB-11D2-9038-00A0C9697298")
interface IDDrawExclModeVideoCallback : IUnknown
{
    HRESULT OnUpdateOverlay(BOOL bBefore, uint dwFlags, BOOL bOldVisible, const(RECT)* prcOldSrc, 
                            const(RECT)* prcOldDest, BOOL bNewVisible, const(RECT)* prcNewSrc, 
                            const(RECT)* prcNewDest);
    HRESULT OnUpdateColorKey(const(COLORKEY)* pKey, uint dwColor);
    HRESULT OnUpdateSize(uint dwWidth, uint dwHeight, uint dwARWidth, uint dwARHeight);
}

@GUID("FD501041-8EBE-11CE-8183-00AA00577DA2")
interface IBDA_NetworkProvider : IUnknown
{
    HRESULT PutSignalSource(uint ulSignalSource);
    HRESULT GetSignalSource(uint* pulSignalSource);
    HRESULT GetNetworkType(GUID* pguidNetworkType);
    HRESULT PutTuningSpace(const(GUID)* guidTuningSpace);
    HRESULT GetTuningSpace(GUID* pguidTuingSpace);
    HRESULT RegisterDeviceFilter(IUnknown pUnkFilterControl, uint* ppvRegisitrationContext);
    HRESULT UnRegisterDeviceFilter(uint pvRegistrationContext);
}

@GUID("71985F43-1CA1-11D3-9CC8-00C04F7971E0")
interface IBDA_EthernetFilter : IUnknown
{
    HRESULT GetMulticastListSize(uint* pulcbAddresses);
    HRESULT PutMulticastList(uint ulcbAddresses, char* pAddressList);
    HRESULT GetMulticastList(uint* pulcbAddresses, char* pAddressList);
    HRESULT PutMulticastMode(uint ulModeMask);
    HRESULT GetMulticastMode(uint* pulModeMask);
}

@GUID("71985F44-1CA1-11D3-9CC8-00C04F7971E0")
interface IBDA_IPV4Filter : IUnknown
{
    HRESULT GetMulticastListSize(uint* pulcbAddresses);
    HRESULT PutMulticastList(uint ulcbAddresses, char* pAddressList);
    HRESULT GetMulticastList(uint* pulcbAddresses, char* pAddressList);
    HRESULT PutMulticastMode(uint ulModeMask);
    HRESULT GetMulticastMode(uint* pulModeMask);
}

@GUID("E1785A74-2A23-4FB3-9245-A8F88017EF33")
interface IBDA_IPV6Filter : IUnknown
{
    HRESULT GetMulticastListSize(uint* pulcbAddresses);
    HRESULT PutMulticastList(uint ulcbAddresses, char* pAddressList);
    HRESULT GetMulticastList(uint* pulcbAddresses, char* pAddressList);
    HRESULT PutMulticastMode(uint ulModeMask);
    HRESULT GetMulticastMode(uint* pulModeMask);
}

@GUID("FD0A5AF3-B41D-11D2-9C95-00C04F7971E0")
interface IBDA_DeviceControl : IUnknown
{
    HRESULT StartChanges();
    HRESULT CheckChanges();
    HRESULT CommitChanges();
    HRESULT GetChangeState(uint* pState);
}

@GUID("0DED49D5-A8B7-4D5D-97A1-12B0C195874D")
interface IBDA_PinControl : IUnknown
{
    HRESULT GetPinID(uint* pulPinID);
    HRESULT GetPinType(uint* pulPinType);
    HRESULT RegistrationContext(uint* pulRegistrationCtx);
}

@GUID("D2F1644B-B409-11D2-BC69-00A0C9EE9E16")
interface IBDA_SignalProperties : IUnknown
{
    HRESULT PutNetworkType(const(GUID)* guidNetworkType);
    HRESULT GetNetworkType(GUID* pguidNetworkType);
    HRESULT PutSignalSource(uint ulSignalSource);
    HRESULT GetSignalSource(uint* pulSignalSource);
    HRESULT PutTuningSpace(const(GUID)* guidTuningSpace);
    HRESULT GetTuningSpace(GUID* pguidTuingSpace);
}

@GUID("1347D106-CF3A-428A-A5CB-AC0D9A2A4338")
interface IBDA_SignalStatistics : IUnknown
{
    HRESULT put_SignalStrength(int lDbStrength);
    HRESULT get_SignalStrength(int* plDbStrength);
    HRESULT put_SignalQuality(int lPercentQuality);
    HRESULT get_SignalQuality(int* plPercentQuality);
    HRESULT put_SignalPresent(ubyte fPresent);
    HRESULT get_SignalPresent(ubyte* pfPresent);
    HRESULT put_SignalLocked(ubyte fLocked);
    HRESULT get_SignalLocked(ubyte* pfLocked);
    HRESULT put_SampleTime(int lmsSampleTime);
    HRESULT get_SampleTime(int* plmsSampleTime);
}

@GUID("79B56888-7FEA-4690-B45D-38FD3C7849BE")
interface IBDA_Topology : IUnknown
{
    HRESULT GetNodeTypes(uint* pulcNodeTypes, uint ulcNodeTypesMax, char* rgulNodeTypes);
    HRESULT GetNodeDescriptors(uint* ulcNodeDescriptors, uint ulcNodeDescriptorsMax, char* rgNodeDescriptors);
    HRESULT GetNodeInterfaces(uint ulNodeType, uint* pulcInterfaces, uint ulcInterfacesMax, char* rgguidInterfaces);
    HRESULT GetPinTypes(uint* pulcPinTypes, uint ulcPinTypesMax, char* rgulPinTypes);
    HRESULT GetTemplateConnections(uint* pulcConnections, uint ulcConnectionsMax, char* rgConnections);
    HRESULT CreatePin(uint ulPinType, uint* pulPinId);
    HRESULT DeletePin(uint ulPinId);
    HRESULT SetMediaType(uint ulPinId, AM_MEDIA_TYPE* pMediaType);
    HRESULT SetMedium(uint ulPinId, REGPINMEDIUM* pMedium);
    HRESULT CreateTopology(uint ulInputPinId, uint ulOutputPinId);
    HRESULT GetControlNode(uint ulInputPinId, uint ulOutputPinId, uint ulNodeType, IUnknown* ppControlNode);
}

@GUID("71985F46-1CA1-11D3-9CC8-00C04F7971E0")
interface IBDA_VoidTransform : IUnknown
{
    HRESULT Start();
    HRESULT Stop();
}

@GUID("DDF15B0D-BD25-11D2-9CA0-00C04F7971E0")
interface IBDA_NullTransform : IUnknown
{
    HRESULT Start();
    HRESULT Stop();
}

@GUID("71985F47-1CA1-11D3-9CC8-00C04F7971E0")
interface IBDA_FrequencyFilter : IUnknown
{
    HRESULT put_Autotune(uint ulTransponder);
    HRESULT get_Autotune(uint* pulTransponder);
    HRESULT put_Frequency(uint ulFrequency);
    HRESULT get_Frequency(uint* pulFrequency);
    HRESULT put_Polarity(Polarisation Polarity);
    HRESULT get_Polarity(Polarisation* pPolarity);
    HRESULT put_Range(uint ulRange);
    HRESULT get_Range(uint* pulRange);
    HRESULT put_Bandwidth(uint ulBandwidth);
    HRESULT get_Bandwidth(uint* pulBandwidth);
    HRESULT put_FrequencyMultiplier(uint ulMultiplier);
    HRESULT get_FrequencyMultiplier(uint* pulMultiplier);
}

@GUID("992CF102-49F9-4719-A664-C4F23E2408F4")
interface IBDA_LNBInfo : IUnknown
{
    HRESULT put_LocalOscilatorFrequencyLowBand(uint ulLOFLow);
    HRESULT get_LocalOscilatorFrequencyLowBand(uint* pulLOFLow);
    HRESULT put_LocalOscilatorFrequencyHighBand(uint ulLOFHigh);
    HRESULT get_LocalOscilatorFrequencyHighBand(uint* pulLOFHigh);
    HRESULT put_HighLowSwitchFrequency(uint ulSwitchFrequency);
    HRESULT get_HighLowSwitchFrequency(uint* pulSwitchFrequency);
}

@GUID("F84E2AB0-3C6B-45E3-A0FC-8669D4B81F11")
interface IBDA_DiseqCommand : IUnknown
{
    HRESULT put_EnableDiseqCommands(ubyte bEnable);
    HRESULT put_DiseqLNBSource(uint ulLNBSource);
    HRESULT put_DiseqUseToneBurst(ubyte bUseToneBurst);
    HRESULT put_DiseqRepeats(uint ulRepeats);
    HRESULT put_DiseqSendCommand(uint ulRequestId, uint ulcbCommandLen, char* pbCommand);
    HRESULT get_DiseqResponse(uint ulRequestId, uint* pulcbResponseLen, char* pbResponse);
}

@GUID("DDF15B12-BD25-11D2-9CA0-00C04F7971E0")
interface IBDA_AutoDemodulate : IUnknown
{
    HRESULT put_AutoDemodulate();
}

@GUID("34518D13-1182-48E6-B28F-B24987787326")
interface IBDA_AutoDemodulateEx : IBDA_AutoDemodulate
{
    HRESULT get_SupportedDeviceNodeTypes(uint ulcDeviceNodeTypesMax, uint* pulcDeviceNodeTypes, 
                                         GUID* pguidDeviceNodeTypes);
    HRESULT get_SupportedVideoFormats(uint* pulAMTunerModeType, uint* pulAnalogVideoStandard);
    HRESULT get_AuxInputCount(uint* pulCompositeCount, uint* pulSvideoCount);
}

@GUID("EF30F379-985B-4D10-B640-A79D5E04E1E0")
interface IBDA_DigitalDemodulator : IUnknown
{
    HRESULT put_ModulationType(ModulationType* pModulationType);
    HRESULT get_ModulationType(ModulationType* pModulationType);
    HRESULT put_InnerFECMethod(FECMethod* pFECMethod);
    HRESULT get_InnerFECMethod(FECMethod* pFECMethod);
    HRESULT put_InnerFECRate(BinaryConvolutionCodeRate* pFECRate);
    HRESULT get_InnerFECRate(BinaryConvolutionCodeRate* pFECRate);
    HRESULT put_OuterFECMethod(FECMethod* pFECMethod);
    HRESULT get_OuterFECMethod(FECMethod* pFECMethod);
    HRESULT put_OuterFECRate(BinaryConvolutionCodeRate* pFECRate);
    HRESULT get_OuterFECRate(BinaryConvolutionCodeRate* pFECRate);
    HRESULT put_SymbolRate(uint* pSymbolRate);
    HRESULT get_SymbolRate(uint* pSymbolRate);
    HRESULT put_SpectralInversion(SpectralInversion* pSpectralInversion);
    HRESULT get_SpectralInversion(SpectralInversion* pSpectralInversion);
}

@GUID("525ED3EE-5CF3-4E1E-9A06-5368A84F9A6E")
interface IBDA_DigitalDemodulator2 : IBDA_DigitalDemodulator
{
    HRESULT put_GuardInterval(GuardInterval* pGuardInterval);
    HRESULT get_GuardInterval(GuardInterval* pGuardInterval);
    HRESULT put_TransmissionMode(TransmissionMode* pTransmissionMode);
    HRESULT get_TransmissionMode(TransmissionMode* pTransmissionMode);
    HRESULT put_RollOff(RollOff* pRollOff);
    HRESULT get_RollOff(RollOff* pRollOff);
    HRESULT put_Pilot(Pilot* pPilot);
    HRESULT get_Pilot(Pilot* pPilot);
}

@GUID("13F19604-7D32-4359-93A2-A05205D90AC9")
interface IBDA_DigitalDemodulator3 : IBDA_DigitalDemodulator2
{
    HRESULT put_SignalTimeouts(BDA_SIGNAL_TIMEOUTS* pSignalTimeouts);
    HRESULT get_SignalTimeouts(BDA_SIGNAL_TIMEOUTS* pSignalTimeouts);
    HRESULT put_PLPNumber(uint* pPLPNumber);
    HRESULT get_PLPNumber(uint* pPLPNumber);
}

@GUID("4B2BD7EA-8347-467B-8DBF-62F784929CC3")
interface ICCSubStreamFiltering : IUnknown
{
    HRESULT get_SubstreamTypes(int* pTypes);
    HRESULT put_SubstreamTypes(int Types);
}

@GUID("3F4DC8E2-4050-11D3-8F4B-00C04F7971E2")
interface IBDA_IPSinkControl : IUnknown
{
    HRESULT GetMulticastList(uint* pulcbSize, ubyte** pbBuffer);
    HRESULT GetAdapterIPAddress(uint* pulcbSize, ubyte** pbBuffer);
}

@GUID("A750108F-492E-4D51-95F7-649B23FF7AD7")
interface IBDA_IPSinkInfo : IUnknown
{
    HRESULT get_MulticastList(uint* pulcbAddresses, char* ppbAddressList);
    HRESULT get_AdapterIPAddress(BSTR* pbstrBuffer);
    HRESULT get_AdapterDescription(BSTR* pbstrBuffer);
}

@GUID("AFB6C2A2-2C41-11D3-8A60-0000F81E0E4A")
interface IEnumPIDMap : IUnknown
{
    HRESULT Next(uint cRequest, char* pPIDMap, uint* pcReceived);
    HRESULT Skip(uint cRecords);
    HRESULT Reset();
    HRESULT Clone(IEnumPIDMap* ppIEnumPIDMap);
}

@GUID("AFB6C2A1-2C41-11D3-8A60-0000F81E0E4A")
interface IMPEG2PIDMap : IUnknown
{
    HRESULT MapPID(uint culPID, uint* pulPID, MEDIA_SAMPLE_CONTENT MediaSampleContent);
    HRESULT UnmapPID(uint culPID, uint* pulPID);
    HRESULT EnumPIDMap(IEnumPIDMap* pIEnumPIDMap);
}

@GUID("06FB45C1-693C-4EA7-B79F-7A6A54D8DEF2")
interface IFrequencyMap : IUnknown
{
    HRESULT get_FrequencyMapping(uint* ulCount, uint** ppulList);
    HRESULT put_FrequencyMapping(uint ulCount, char* pList);
    HRESULT get_CountryCode(uint* pulCountryCode);
    HRESULT put_CountryCode(uint ulCountryCode);
    HRESULT get_DefaultFrequencyMapping(uint ulCountryCode, uint* pulCount, uint** ppulList);
    HRESULT get_CountryCodeList(uint* pulCount, uint** ppulList);
}

@GUID("D806973D-3EBE-46DE-8FBB-6358FE784208")
interface IBDA_EasMessage : IUnknown
{
    HRESULT get_EasMessage(uint ulEventID, IUnknown* ppEASObject);
}

@GUID("8E882535-5F86-47AB-86CF-C281A72A0549")
interface IBDA_TransportStreamInfo : IUnknown
{
    HRESULT get_PatTableTickCount(uint* pPatTickCount);
}

@GUID("CD51F1E0-7BE9-4123-8482-A2A796C0A6B0")
interface IBDA_ConditionalAccess : IUnknown
{
    HRESULT get_SmartCardStatus(SmartCardStatusType* pCardStatus, SmartCardAssociationType* pCardAssociation, 
                                BSTR* pbstrCardError, short* pfOOBLocked);
    HRESULT get_SmartCardInfo(BSTR* pbstrCardName, BSTR* pbstrCardManufacturer, short* pfDaylightSavings, 
                              ubyte* pbyRatingRegion, int* plTimeZoneOffsetMinutes, BSTR* pbstrLanguage, 
                              EALocationCodeType* pEALocationCode);
    HRESULT get_SmartCardApplications(uint* pulcApplications, uint ulcApplicationsMax, char* rgApplications);
    HRESULT get_Entitlement(ushort usVirtualChannel, EntitlementType* pEntitlement);
    HRESULT TuneByChannel(ushort usVirtualChannel);
    HRESULT SetProgram(ushort usProgramNumber);
    HRESULT AddProgram(ushort usProgramNumber);
    HRESULT RemoveProgram(ushort usProgramNumber);
    HRESULT GetModuleUI(ubyte byDialogNumber, BSTR* pbstrURL);
    HRESULT InformUIClosed(ubyte byDialogNumber, UICloseReasonType CloseReason);
}

@GUID("20E80CB5-C543-4C1B-8EB3-49E719EEE7D4")
interface IBDA_DiagnosticProperties : IPropertyBag
{
}

@GUID("F98D88B0-1992-4CD6-A6D9-B9AFAB99330D")
interface IBDA_DRM : IUnknown
{
    HRESULT GetDRMPairingStatus(uint* pdwStatus, int* phError);
    HRESULT PerformDRMPairing(BOOL fSync);
}

@GUID("7F0B3150-7B81-4AD4-98E3-7E9097094301")
interface IBDA_NameValueService : IUnknown
{
    HRESULT GetValueNameByIndex(uint ulIndex, BSTR* pbstrName);
    HRESULT GetValue(BSTR bstrName, BSTR bstrLanguage, BSTR* pbstrValue);
    HRESULT SetValue(uint ulDialogRequest, BSTR bstrLanguage, BSTR bstrName, BSTR bstrValue, uint ulReserved);
}

@GUID("497C3418-23CB-44BA-BB62-769F506FCEA7")
interface IBDA_ConditionalAccessEx : IUnknown
{
    HRESULT CheckEntitlementToken(uint ulDialogRequest, BSTR bstrLanguage, 
                                  BDA_CONDITIONALACCESS_REQUESTTYPE RequestType, uint ulcbEntitlementTokenLen, 
                                  char* pbEntitlementToken, uint* pulDescrambleStatus);
    HRESULT SetCaptureToken(uint ulcbCaptureTokenLen, char* pbCaptureToken);
    HRESULT OpenBroadcastMmi(uint ulDialogRequest, BSTR bstrLanguage, uint EventId);
    HRESULT CloseMmiDialog(uint ulDialogRequest, BSTR bstrLanguage, uint ulDialogNumber, 
                           BDA_CONDITIONALACCESS_MMICLOSEREASON ReasonCode, uint* pulSessionResult);
    HRESULT CreateDialogRequestNumber(uint* pulDialogRequestNumber);
}

@GUID("5E68C627-16C2-4E6C-B1E2-D00170CDAA0F")
interface IBDA_ISDBConditionalAccess : IUnknown
{
    HRESULT SetIsdbCasRequest(uint ulRequestId, uint ulcbRequestBufferLen, char* pbRequestBuffer);
}

@GUID("207C413F-00DC-4C61-BAD6-6FEE1FF07064")
interface IBDA_EventingService : IUnknown
{
    HRESULT CompleteEvent(uint ulEventID, uint ulEventResult);
}

@GUID("7DEF4C09-6E66-4567-A819-F0E17F4A81AB")
interface IBDA_AUX : IUnknown
{
    HRESULT QueryCapabilities(uint* pdwNumAuxInputsBSTR);
    HRESULT EnumCapability(uint dwIndex, uint* dwInputID, GUID* pConnectorType, uint* ConnTypeNum, 
                           uint* NumVideoStds, ulong* AnalogStds);
}

@GUID("3A8BAD59-59FE-4559-A0BA-396CFAA98AE3")
interface IBDA_Encoder : IUnknown
{
    HRESULT QueryCapabilities(uint* NumAudioFmts, uint* NumVideoFmts);
    HRESULT EnumAudioCapability(uint FmtIndex, uint* MethodID, uint* AlgorithmType, uint* SamplingRate, 
                                uint* BitDepth, uint* NumChannels);
    HRESULT EnumVideoCapability(uint FmtIndex, uint* MethodID, uint* AlgorithmType, uint* VerticalSize, 
                                uint* HorizontalSize, uint* AspectRatio, uint* FrameRateCode, 
                                uint* ProgressiveSequence);
    HRESULT SetParameters(uint AudioBitrateMode, uint AudioBitrate, uint AudioMethodID, uint AudioProgram, 
                          uint VideoBitrateMode, uint VideoBitrate, uint VideoMethodID);
    HRESULT GetState(uint* AudioBitrateMax, uint* AudioBitrateMin, uint* AudioBitrateMode, 
                     uint* AudioBitrateStepping, uint* AudioBitrate, uint* AudioMethodID, 
                     uint* AvailableAudioPrograms, uint* AudioProgram, uint* VideoBitrateMax, uint* VideoBitrateMin, 
                     uint* VideoBitrateMode, uint* VideoBitrate, uint* VideoBitrateStepping, uint* VideoMethodID, 
                     uint* SignalSourceID, ulong* SignalFormat, int* SignalLock, int* SignalLevel, 
                     uint* SignalToNoiseRatio);
}

@GUID("138ADC7E-58AE-437F-B0B4-C9FE19D5B4AC")
interface IBDA_FDC : IUnknown
{
    HRESULT GetStatus(uint* CurrentBitrate, int* CarrierLock, uint* CurrentFrequency, 
                      int* CurrentSpectrumInversion, BSTR* CurrentPIDList, BSTR* CurrentTIDList, int* Overflow);
    HRESULT RequestTables(BSTR TableIDs);
    HRESULT AddPid(BSTR PidsToAdd, uint* RemainingFilterEntries);
    HRESULT RemovePid(BSTR PidsToRemove);
    HRESULT AddTid(BSTR TidsToAdd, BSTR* CurrentTidList);
    HRESULT RemoveTid(BSTR TidsToRemove);
    HRESULT GetTableSection(uint* Pid, uint MaxBufferSize, uint* ActualSize, ubyte* SecBuffer);
}

@GUID("C0AFCB73-23E7-4BC6-BAFA-FDC167B4719F")
interface IBDA_GuideDataDeliveryService : IUnknown
{
    HRESULT GetGuideDataType(GUID* pguidDataType);
    HRESULT GetGuideData(uint* pulcbBufferLen, ubyte* pbBuffer, uint* pulGuideDataPercentageProgress);
    HRESULT RequestGuideDataUpdate();
    HRESULT GetTuneXmlFromServiceIdx(ulong ul64ServiceIdx, BSTR* pbstrTuneXml);
    HRESULT GetServices(uint* pulcbBufferLen, ubyte* pbBuffer);
    HRESULT GetServiceInfoFromTuneXml(BSTR bstrTuneXml, BSTR* pbstrServiceDescription);
}

@GUID("BFF6B5BB-B0AE-484C-9DCA-73528FB0B46E")
interface IBDA_DRMService : IUnknown
{
    HRESULT SetDRM(GUID* puuidNewDrm);
    HRESULT GetDRMStatus(BSTR* pbstrDrmUuidList, GUID* DrmUuid);
}

@GUID("4BE6FA3D-07CD-4139-8B80-8C18BA3AEC88")
interface IBDA_WMDRMSession : IUnknown
{
    HRESULT GetStatus(uint* MaxCaptureToken, uint* MaxStreamingPid, uint* MaxLicense, uint* MinSecurityLevel, 
                      uint* RevInfoSequenceNumber, ulong* RevInfoIssuedTime, uint* RevInfoTTL, uint* RevListVersion, 
                      uint* ulState);
    HRESULT SetRevInfo(uint ulRevInfoLen, char* pbRevInfo);
    HRESULT SetCrl(uint ulCrlLen, char* pbCrlLen);
    HRESULT TransactMessage(uint ulcbRequest, char* pbRequest, uint* pulcbResponse, ubyte* pbResponse);
    HRESULT GetLicense(GUID* uuidKey, uint* pulPackageLen, ubyte* pbPackage);
    HRESULT ReissueLicense(GUID* uuidKey);
    HRESULT RenewLicense(uint ulInXmrLicenseLen, char* pbInXmrLicense, uint ulEntitlementTokenLen, 
                         char* pbEntitlementToken, uint* pulDescrambleStatus, uint* pulOutXmrLicenseLen, 
                         ubyte* pbOutXmrLicense);
    HRESULT GetKeyInfo(uint* pulKeyInfoLen, ubyte* pbKeyInfo);
}

@GUID("86D979CF-A8A7-4F94-B5FB-14C0ACA68FE6")
interface IBDA_WMDRMTuner : IUnknown
{
    HRESULT PurchaseEntitlement(uint ulDialogRequest, BSTR bstrLanguage, uint ulPurchaseTokenLen, 
                                char* pbPurchaseToken, uint* pulDescrambleStatus, uint* pulCaptureTokenLen, 
                                ubyte* pbCaptureToken);
    HRESULT CancelCaptureToken(uint ulCaptureTokenLen, char* pbCaptureToken);
    HRESULT SetPidProtection(uint ulPid, GUID* uuidKey);
    HRESULT GetPidProtection(uint pulPid, GUID* uuidKey);
    HRESULT SetSyncValue(uint ulSyncValue);
    HRESULT GetStartCodeProfile(uint* pulStartCodeProfileLen, ubyte* pbStartCodeProfile);
}

@GUID("1F9BC2A5-44A3-4C52-AAB1-0BBCE5A1381D")
interface IBDA_DRIDRMService : IUnknown
{
    HRESULT SetDRM(BSTR bstrNewDrm);
    HRESULT GetDRMStatus(BSTR* pbstrDrmUuidList, GUID* DrmUuid);
    HRESULT GetPairingStatus(BDA_DrmPairingError* penumPairingStatus);
}

@GUID("05C690F8-56DB-4BB2-B053-79C12098BB26")
interface IBDA_DRIWMDRMSession : IUnknown
{
    HRESULT AcknowledgeLicense(HRESULT hrLicenseAck);
    HRESULT ProcessLicenseChallenge(uint dwcbLicenseMessage, char* pbLicenseMessage, uint* pdwcbLicenseResponse, 
                                    char* ppbLicenseResponse);
    HRESULT ProcessRegistrationChallenge(uint dwcbRegistrationMessage, char* pbRegistrationMessage, 
                                         uint* pdwcbRegistrationResponse, ubyte** ppbRegistrationResponse);
    HRESULT SetRevInfo(uint dwRevInfoLen, char* pbRevInfo, uint* pdwResponse);
    HRESULT SetCrl(uint dwCrlLen, char* pbCrlLen, uint* pdwResponse);
    HRESULT GetHMSAssociationData();
    HRESULT GetLastCardeaError(uint* pdwError);
}

@GUID("942AAFEC-4C05-4C74-B8EB-8706C2A4943F")
interface IBDA_MUX : IUnknown
{
    HRESULT SetPidList(uint ulPidListCount, char* pbPidListBuffer);
    HRESULT GetPidList(uint* pulPidListCount, BDA_MUX_PIDLISTITEM* pbPidListBuffer);
}

@GUID("1DCFAFE9-B45E-41B3-BB2A-561EB129AE98")
interface IBDA_TransportStreamSelector : IUnknown
{
    HRESULT SetTSID(ushort usTSID);
    HRESULT GetTSInformation(uint* pulTSInformationBufferLen, char* pbTSInformationBuffer);
}

@GUID("53B14189-E478-4B7A-A1FF-506DB4B99DFE")
interface IBDA_UserActivityService : IUnknown
{
    HRESULT SetCurrentTunerUseReason(uint dwUseReason);
    HRESULT GetUserActivityInterval(uint* pdwActivityInterval);
    HRESULT UserActivityDetected();
}

@GUID("1F0E5357-AF43-44E6-8547-654C645145D2")
interface IESEvent : IUnknown
{
    HRESULT GetEventId(uint* pdwEventId);
    HRESULT GetEventType(GUID* pguidEventType);
    HRESULT SetCompletionStatus(uint dwResult);
    HRESULT GetData(SAFEARRAY** pbData);
    HRESULT GetStringData(BSTR* pbstrData);
}

@GUID("ABD414BF-CFE5-4E5E-AF5B-4B4E49C5BFEB")
interface IESEvents : IUnknown
{
    HRESULT OnESEventReceived(GUID guidEventType, IESEvent pESEvent);
}

@GUID("3B21263F-26E8-489D-AAC4-924F7EFD9511")
interface IBroadcastEvent : IUnknown
{
    HRESULT Fire(GUID EventID);
}

@GUID("3D9E3887-1929-423F-8021-43682DE95448")
interface IBroadcastEventEx : IBroadcastEvent
{
    HRESULT FireEx(GUID EventID, uint Param1, uint Param2, uint Param3, uint Param4);
}

interface IAMNetShowConfig : IDispatch
{
    HRESULT get_BufferingTime(double* pBufferingTime);
    HRESULT put_BufferingTime(double BufferingTime);
    HRESULT get_UseFixedUDPPort(short* pUseFixedUDPPort);
    HRESULT put_UseFixedUDPPort(short UseFixedUDPPort);
    HRESULT get_FixedUDPPort(int* pFixedUDPPort);
    HRESULT put_FixedUDPPort(int FixedUDPPort);
    HRESULT get_UseHTTPProxy(short* pUseHTTPProxy);
    HRESULT put_UseHTTPProxy(short UseHTTPProxy);
    HRESULT get_EnableAutoProxy(short* pEnableAutoProxy);
    HRESULT put_EnableAutoProxy(short EnableAutoProxy);
    HRESULT get_HTTPProxyHost(BSTR* pbstrHTTPProxyHost);
    HRESULT put_HTTPProxyHost(BSTR bstrHTTPProxyHost);
    HRESULT get_HTTPProxyPort(int* pHTTPProxyPort);
    HRESULT put_HTTPProxyPort(int HTTPProxyPort);
    HRESULT get_EnableMulticast(short* pEnableMulticast);
    HRESULT put_EnableMulticast(short EnableMulticast);
    HRESULT get_EnableUDP(short* pEnableUDP);
    HRESULT put_EnableUDP(short EnableUDP);
    HRESULT get_EnableTCP(short* pEnableTCP);
    HRESULT put_EnableTCP(short EnableTCP);
    HRESULT get_EnableHTTP(short* pEnableHTTP);
    HRESULT put_EnableHTTP(short EnableHTTP);
}

interface IAMChannelInfo : IDispatch
{
    HRESULT get_ChannelName(BSTR* pbstrChannelName);
    HRESULT get_ChannelDescription(BSTR* pbstrChannelDescription);
    HRESULT get_ChannelURL(BSTR* pbstrChannelURL);
    HRESULT get_ContactAddress(BSTR* pbstrContactAddress);
    HRESULT get_ContactPhone(BSTR* pbstrContactPhone);
    HRESULT get_ContactEmail(BSTR* pbstrContactEmail);
}

interface IAMNetworkStatus : IDispatch
{
    HRESULT get_ReceivedPackets(int* pReceivedPackets);
    HRESULT get_RecoveredPackets(int* pRecoveredPackets);
    HRESULT get_LostPackets(int* pLostPackets);
    HRESULT get_ReceptionQuality(int* pReceptionQuality);
    HRESULT get_BufferingCount(int* pBufferingCount);
    HRESULT get_IsBroadcast(short* pIsBroadcast);
    HRESULT get_BufferingProgress(int* pBufferingProgress);
}

interface IAMExtendedSeeking : IDispatch
{
    HRESULT get_ExSeekCapabilities(int* pExCapabilities);
    HRESULT get_MarkerCount(int* pMarkerCount);
    HRESULT get_CurrentMarker(int* pCurrentMarker);
    HRESULT GetMarkerTime(int MarkerNum, double* pMarkerTime);
    HRESULT GetMarkerName(int MarkerNum, BSTR* pbstrMarkerName);
    HRESULT put_PlaybackSpeed(double Speed);
    HRESULT get_PlaybackSpeed(double* pSpeed);
}

interface IAMNetShowExProps : IDispatch
{
    HRESULT get_SourceProtocol(int* pSourceProtocol);
    HRESULT get_Bandwidth(int* pBandwidth);
    HRESULT get_ErrorCorrection(BSTR* pbstrErrorCorrection);
    HRESULT get_CodecCount(int* pCodecCount);
    HRESULT GetCodecInstalled(int CodecNum, short* pCodecInstalled);
    HRESULT GetCodecDescription(int CodecNum, BSTR* pbstrCodecDescription);
    HRESULT GetCodecURL(int CodecNum, BSTR* pbstrCodecURL);
    HRESULT get_CreationDate(double* pCreationDate);
    HRESULT get_SourceLink(BSTR* pbstrSourceLink);
}

interface IAMExtendedErrorInfo : IDispatch
{
    HRESULT get_HasError(short* pHasError);
    HRESULT get_ErrorDescription(BSTR* pbstrErrorDescription);
    HRESULT get_ErrorCode(int* pErrorCode);
}

interface IAMMediaContent : IDispatch
{
    HRESULT get_AuthorName(BSTR* pbstrAuthorName);
    HRESULT get_Title(BSTR* pbstrTitle);
    HRESULT get_Rating(BSTR* pbstrRating);
    HRESULT get_Description(BSTR* pbstrDescription);
    HRESULT get_Copyright(BSTR* pbstrCopyright);
    HRESULT get_BaseURL(BSTR* pbstrBaseURL);
    HRESULT get_LogoURL(BSTR* pbstrLogoURL);
    HRESULT get_LogoIconURL(BSTR* pbstrLogoURL);
    HRESULT get_WatermarkURL(BSTR* pbstrWatermarkURL);
    HRESULT get_MoreInfoURL(BSTR* pbstrMoreInfoURL);
    HRESULT get_MoreInfoBannerImage(BSTR* pbstrMoreInfoBannerImage);
    HRESULT get_MoreInfoBannerURL(BSTR* pbstrMoreInfoBannerURL);
    HRESULT get_MoreInfoText(BSTR* pbstrMoreInfoText);
}

interface IAMMediaContent2 : IDispatch
{
    HRESULT get_MediaParameter(int EntryNum, BSTR bstrName, BSTR* pbstrValue);
    HRESULT get_MediaParameterName(int EntryNum, int Index, BSTR* pbstrName);
    HRESULT get_PlaylistCount(int* pNumberEntries);
}

interface IAMNetShowPreroll : IDispatch
{
    HRESULT put_Preroll(short fPreroll);
    HRESULT get_Preroll(short* pfPreroll);
}

interface IDShowPlugin : IUnknown
{
    HRESULT get_URL(BSTR* pURL);
    HRESULT get_UserAgent(BSTR* pUserAgent);
}

interface IAMDirectSound : IUnknown
{
    HRESULT GetDirectSoundInterface(IDirectSound* lplpds);
    HRESULT GetPrimaryBufferInterface(IDirectSoundBuffer* lplpdsb);
    HRESULT GetSecondaryBufferInterface(IDirectSoundBuffer* lplpdsb);
    HRESULT ReleaseDirectSoundInterface(IDirectSound lpds);
    HRESULT ReleasePrimaryBufferInterface(IDirectSoundBuffer lpdsb);
    HRESULT ReleaseSecondaryBufferInterface(IDirectSoundBuffer lpdsb);
    HRESULT SetFocusWindow(HWND param0, BOOL param1);
    HRESULT GetFocusWindow(HWND* param0, int* param1);
}

interface IAMLine21Decoder : IUnknown
{
    HRESULT GetDecoderLevel(AM_LINE21_CCLEVEL* lpLevel);
    HRESULT GetCurrentService(AM_LINE21_CCSERVICE* lpService);
    HRESULT SetCurrentService(AM_LINE21_CCSERVICE Service);
    HRESULT GetServiceState(AM_LINE21_CCSTATE* lpState);
    HRESULT SetServiceState(AM_LINE21_CCSTATE State);
    HRESULT GetOutputFormat(BITMAPINFOHEADER* lpbmih);
    HRESULT SetOutputFormat(BITMAPINFO* lpbmi);
    HRESULT GetBackgroundColor(uint* pdwPhysColor);
    HRESULT SetBackgroundColor(uint dwPhysColor);
    HRESULT GetRedrawAlways(int* lpbOption);
    HRESULT SetRedrawAlways(BOOL bOption);
    HRESULT GetDrawBackgroundMode(AM_LINE21_DRAWBGMODE* lpMode);
    HRESULT SetDrawBackgroundMode(AM_LINE21_DRAWBGMODE Mode);
}

interface IAMParse : IUnknown
{
    HRESULT GetParseTime(long* prtCurrent);
    HRESULT SetParseTime(long rtCurrent);
    HRESULT Flush();
}

@GUID("56A868B9-0AD4-11CE-B03A-0020AF0BA770")
interface IAMCollection : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT Item(int lItem, IUnknown* ppUnk);
    HRESULT get__NewEnum(IUnknown* ppUnk);
}

@GUID("56A868B1-0AD4-11CE-B03A-0020AF0BA770")
interface IMediaControl : IDispatch
{
    HRESULT Run();
    HRESULT Pause();
    HRESULT Stop();
    HRESULT GetState(int msTimeout, int* pfs);
    HRESULT RenderFile(BSTR strFilename);
    HRESULT AddSourceFilter(BSTR strFilename, IDispatch* ppUnk);
    HRESULT get_FilterCollection(IDispatch* ppUnk);
    HRESULT get_RegFilterCollection(IDispatch* ppUnk);
    HRESULT StopWhenReady();
}

@GUID("56A868B6-0AD4-11CE-B03A-0020AF0BA770")
interface IMediaEvent : IDispatch
{
    HRESULT GetEventHandle(ptrdiff_t* hEvent);
    HRESULT GetEvent(int* lEventCode, ptrdiff_t* lParam1, ptrdiff_t* lParam2, int msTimeout);
    HRESULT WaitForCompletion(int msTimeout, int* pEvCode);
    HRESULT CancelDefaultHandling(int lEvCode);
    HRESULT RestoreDefaultHandling(int lEvCode);
    HRESULT FreeEventParams(int lEvCode, ptrdiff_t lParam1, ptrdiff_t lParam2);
}

@GUID("56A868C0-0AD4-11CE-B03A-0020AF0BA770")
interface IMediaEventEx : IMediaEvent
{
    HRESULT SetNotifyWindow(ptrdiff_t hwnd, int lMsg, ptrdiff_t lInstanceData);
    HRESULT SetNotifyFlags(int lNoNotifyFlags);
    HRESULT GetNotifyFlags(int* lplNoNotifyFlags);
}

@GUID("56A868B2-0AD4-11CE-B03A-0020AF0BA770")
interface IMediaPosition : IDispatch
{
    HRESULT get_Duration(double* plength);
    HRESULT put_CurrentPosition(double llTime);
    HRESULT get_CurrentPosition(double* pllTime);
    HRESULT get_StopTime(double* pllTime);
    HRESULT put_StopTime(double llTime);
    HRESULT get_PrerollTime(double* pllTime);
    HRESULT put_PrerollTime(double llTime);
    HRESULT put_Rate(double dRate);
    HRESULT get_Rate(double* pdRate);
    HRESULT CanSeekForward(int* pCanSeekForward);
    HRESULT CanSeekBackward(int* pCanSeekBackward);
}

@GUID("56A868B3-0AD4-11CE-B03A-0020AF0BA770")
interface IBasicAudio : IDispatch
{
    HRESULT put_Volume(int lVolume);
    HRESULT get_Volume(int* plVolume);
    HRESULT put_Balance(int lBalance);
    HRESULT get_Balance(int* plBalance);
}

@GUID("56A868B4-0AD4-11CE-B03A-0020AF0BA770")
interface IVideoWindow : IDispatch
{
    HRESULT put_Caption(BSTR strCaption);
    HRESULT get_Caption(BSTR* strCaption);
    HRESULT put_WindowStyle(int WindowStyle);
    HRESULT get_WindowStyle(int* WindowStyle);
    HRESULT put_WindowStyleEx(int WindowStyleEx);
    HRESULT get_WindowStyleEx(int* WindowStyleEx);
    HRESULT put_AutoShow(int AutoShow);
    HRESULT get_AutoShow(int* AutoShow);
    HRESULT put_WindowState(int WindowState);
    HRESULT get_WindowState(int* WindowState);
    HRESULT put_BackgroundPalette(int BackgroundPalette);
    HRESULT get_BackgroundPalette(int* pBackgroundPalette);
    HRESULT put_Visible(int Visible);
    HRESULT get_Visible(int* pVisible);
    HRESULT put_Left(int Left);
    HRESULT get_Left(int* pLeft);
    HRESULT put_Width(int Width);
    HRESULT get_Width(int* pWidth);
    HRESULT put_Top(int Top);
    HRESULT get_Top(int* pTop);
    HRESULT put_Height(int Height);
    HRESULT get_Height(int* pHeight);
    HRESULT put_Owner(ptrdiff_t Owner);
    HRESULT get_Owner(ptrdiff_t* Owner);
    HRESULT put_MessageDrain(ptrdiff_t Drain);
    HRESULT get_MessageDrain(ptrdiff_t* Drain);
    HRESULT get_BorderColor(int* Color);
    HRESULT put_BorderColor(int Color);
    HRESULT get_FullScreenMode(int* FullScreenMode);
    HRESULT put_FullScreenMode(int FullScreenMode);
    HRESULT SetWindowForeground(int Focus);
    HRESULT NotifyOwnerMessage(ptrdiff_t hwnd, int uMsg, ptrdiff_t wParam, ptrdiff_t lParam);
    HRESULT SetWindowPosition(int Left, int Top, int Width, int Height);
    HRESULT GetWindowPosition(int* pLeft, int* pTop, int* pWidth, int* pHeight);
    HRESULT GetMinIdealImageSize(int* pWidth, int* pHeight);
    HRESULT GetMaxIdealImageSize(int* pWidth, int* pHeight);
    HRESULT GetRestorePosition(int* pLeft, int* pTop, int* pWidth, int* pHeight);
    HRESULT HideCursor(int HideCursor);
    HRESULT IsCursorHidden(int* CursorHidden);
}

@GUID("56A868B5-0AD4-11CE-B03A-0020AF0BA770")
interface IBasicVideo : IDispatch
{
    HRESULT get_AvgTimePerFrame(double* pAvgTimePerFrame);
    HRESULT get_BitRate(int* pBitRate);
    HRESULT get_BitErrorRate(int* pBitErrorRate);
    HRESULT get_VideoWidth(int* pVideoWidth);
    HRESULT get_VideoHeight(int* pVideoHeight);
    HRESULT put_SourceLeft(int SourceLeft);
    HRESULT get_SourceLeft(int* pSourceLeft);
    HRESULT put_SourceWidth(int SourceWidth);
    HRESULT get_SourceWidth(int* pSourceWidth);
    HRESULT put_SourceTop(int SourceTop);
    HRESULT get_SourceTop(int* pSourceTop);
    HRESULT put_SourceHeight(int SourceHeight);
    HRESULT get_SourceHeight(int* pSourceHeight);
    HRESULT put_DestinationLeft(int DestinationLeft);
    HRESULT get_DestinationLeft(int* pDestinationLeft);
    HRESULT put_DestinationWidth(int DestinationWidth);
    HRESULT get_DestinationWidth(int* pDestinationWidth);
    HRESULT put_DestinationTop(int DestinationTop);
    HRESULT get_DestinationTop(int* pDestinationTop);
    HRESULT put_DestinationHeight(int DestinationHeight);
    HRESULT get_DestinationHeight(int* pDestinationHeight);
    HRESULT SetSourcePosition(int Left, int Top, int Width, int Height);
    HRESULT GetSourcePosition(int* pLeft, int* pTop, int* pWidth, int* pHeight);
    HRESULT SetDefaultSourcePosition();
    HRESULT SetDestinationPosition(int Left, int Top, int Width, int Height);
    HRESULT GetDestinationPosition(int* pLeft, int* pTop, int* pWidth, int* pHeight);
    HRESULT SetDefaultDestinationPosition();
    HRESULT GetVideoSize(int* pWidth, int* pHeight);
    HRESULT GetVideoPaletteEntries(int StartIndex, int Entries, int* pRetrieved, int* pPalette);
    HRESULT GetCurrentImage(int* pBufferSize, int* pDIBImage);
    HRESULT IsUsingDefaultSource();
    HRESULT IsUsingDefaultDestination();
}

@GUID("329BB360-F6EA-11D1-9038-00A0C9697298")
interface IBasicVideo2 : IBasicVideo
{
    HRESULT GetPreferredAspectRatio(int* plAspectX, int* plAspectY);
}

@GUID("56A868B8-0AD4-11CE-B03A-0020AF0BA770")
interface IDeferredCommand : IUnknown
{
    HRESULT Cancel();
    HRESULT Confidence(int* pConfidence);
    HRESULT Postpone(double newtime);
    HRESULT GetHResult(int* phrResult);
}

@GUID("56A868B7-0AD4-11CE-B03A-0020AF0BA770")
interface IQueueCommand : IUnknown
{
    HRESULT InvokeAtStreamTime(IDeferredCommand* pCmd, double time, GUID* iid, int dispidMethod, short wFlags, 
                               int cArgs, VARIANT* pDispParams, VARIANT* pvarResult, short* puArgErr);
    HRESULT InvokeAtPresentationTime(IDeferredCommand* pCmd, double time, GUID* iid, int dispidMethod, 
                                     short wFlags, int cArgs, VARIANT* pDispParams, VARIANT* pvarResult, 
                                     short* puArgErr);
}

@GUID("56A868BA-0AD4-11CE-B03A-0020AF0BA770")
interface IFilterInfo : IDispatch
{
    HRESULT FindPin(BSTR strPinID, IDispatch* ppUnk);
    HRESULT get_Name(BSTR* strName);
    HRESULT get_VendorInfo(BSTR* strVendorInfo);
    HRESULT get_Filter(IUnknown* ppUnk);
    HRESULT get_Pins(IDispatch* ppUnk);
    HRESULT get_IsFileSource(int* pbIsSource);
    HRESULT get_Filename(BSTR* pstrFilename);
    HRESULT put_Filename(BSTR strFilename);
}

@GUID("56A868BB-0AD4-11CE-B03A-0020AF0BA770")
interface IRegFilterInfo : IDispatch
{
    HRESULT get_Name(BSTR* strName);
    HRESULT Filter(IDispatch* ppUnk);
}

@GUID("56A868BC-0AD4-11CE-B03A-0020AF0BA770")
interface IMediaTypeInfo : IDispatch
{
    HRESULT get_Type(BSTR* strType);
    HRESULT get_Subtype(BSTR* strType);
}

@GUID("56A868BD-0AD4-11CE-B03A-0020AF0BA770")
interface IPinInfo : IDispatch
{
    HRESULT get_Pin(IUnknown* ppUnk);
    HRESULT get_ConnectedTo(IDispatch* ppUnk);
    HRESULT get_ConnectionMediaType(IDispatch* ppUnk);
    HRESULT get_FilterInfo(IDispatch* ppUnk);
    HRESULT get_Name(BSTR* ppUnk);
    HRESULT get_Direction(int* ppDirection);
    HRESULT get_PinID(BSTR* strPinID);
    HRESULT get_MediaTypes(IDispatch* ppUnk);
    HRESULT Connect(IUnknown pPin);
    HRESULT ConnectDirect(IUnknown pPin);
    HRESULT ConnectWithType(IUnknown pPin, IDispatch pMediaType);
    HRESULT Disconnect();
    HRESULT Render();
}

@GUID("BC9BCF80-DCD2-11D2-ABF6-00A0C905F375")
interface IAMStats : IDispatch
{
    HRESULT Reset();
    HRESULT get_Count(int* plCount);
    HRESULT GetValueByIndex(int lIndex, BSTR* szName, int* lCount, double* dLast, double* dAverage, 
                            double* dStdDev, double* dMin, double* dMax);
    HRESULT GetValueByName(BSTR szName, int* lIndex, int* lCount, double* dLast, double* dAverage, double* dStdDev, 
                           double* dMin, double* dMax);
    HRESULT GetIndex(BSTR szName, int lCreate, int* plIndex);
    HRESULT AddValue(int lIndex, double dValue);
}

@GUID("256A6A21-FBAD-11D1-82BF-00A0C9696C8F")
interface IAMVideoAcceleratorNotify : IUnknown
{
    HRESULT GetUncompSurfacesInfo(const(GUID)* pGuid, AMVAUncompBufferInfo* pUncompBufferInfo);
    HRESULT SetUncompSurfacesInfo(uint dwActualUncompSurfacesAllocated);
    HRESULT GetCreateVideoAcceleratorData(const(GUID)* pGuid, uint* pdwSizeMiscData, void** ppMiscData);
}

@GUID("256A6A22-FBAD-11D1-82BF-00A0C9696C8F")
interface IAMVideoAccelerator : IUnknown
{
    HRESULT GetVideoAcceleratorGUIDs(uint* pdwNumGuidsSupported, char* pGuidsSupported);
    HRESULT GetUncompFormatsSupported(const(GUID)* pGuid, uint* pdwNumFormatsSupported, char* pFormatsSupported);
    HRESULT GetInternalMemInfo(const(GUID)* pGuid, const(AMVAUncompDataInfo)* pamvaUncompDataInfo, 
                               AMVAInternalMemInfo* pamvaInternalMemInfo);
    HRESULT GetCompBufferInfo(const(GUID)* pGuid, const(AMVAUncompDataInfo)* pamvaUncompDataInfo, 
                              uint* pdwNumTypesCompBuffers, char* pamvaCompBufferInfo);
    HRESULT GetInternalCompBufferInfo(uint* pdwNumTypesCompBuffers, char* pamvaCompBufferInfo);
    HRESULT BeginFrame(const(AMVABeginFrameInfo)* amvaBeginFrameInfo);
    HRESULT EndFrame(const(AMVAEndFrameInfo)* pEndFrameInfo);
    HRESULT GetBuffer(uint dwTypeIndex, uint dwBufferIndex, BOOL bReadOnly, void** ppBuffer, int* lpStride);
    HRESULT ReleaseBuffer(uint dwTypeIndex, uint dwBufferIndex);
    HRESULT Execute(uint dwFunction, void* lpPrivateInputData, uint cbPrivateInputData, void* lpPrivateOutputDat, 
                    uint cbPrivateOutputData, uint dwNumBuffers, char* pamvaBufferInfo);
    HRESULT QueryRenderStatus(uint dwTypeIndex, uint dwBufferIndex, uint dwFlags);
    HRESULT DisplayFrame(uint dwFlipToIndex, IMediaSample pMediaSample);
}

interface IAMWstDecoder : IUnknown
{
    HRESULT GetDecoderLevel(AM_WST_LEVEL* lpLevel);
    HRESULT GetCurrentService(AM_WST_SERVICE* lpService);
    HRESULT GetServiceState(AM_WST_STATE* lpState);
    HRESULT SetServiceState(AM_WST_STATE State);
    HRESULT GetOutputFormat(BITMAPINFOHEADER* lpbmih);
    HRESULT SetOutputFormat(BITMAPINFO* lpbmi);
    HRESULT GetBackgroundColor(uint* pdwPhysColor);
    HRESULT SetBackgroundColor(uint dwPhysColor);
    HRESULT GetRedrawAlways(int* lpbOption);
    HRESULT SetRedrawAlways(BOOL bOption);
    HRESULT GetDrawBackgroundMode(AM_WST_DRAWBGMODE* lpMode);
    HRESULT SetDrawBackgroundMode(AM_WST_DRAWBGMODE Mode);
    HRESULT SetAnswerMode(BOOL bAnswer);
    HRESULT GetAnswerMode(int* pbAnswer);
    HRESULT SetHoldPage(BOOL bHoldPage);
    HRESULT GetHoldPage(int* pbHoldPage);
    HRESULT GetCurrentPage(AM_WST_PAGE* pWstPage);
    HRESULT SetCurrentPage(AM_WST_PAGE WstPage);
}

@GUID("720D4AC0-7533-11D0-A5D6-28DB04C10000")
interface IKsTopologyInfo : IUnknown
{
    HRESULT get_NumCategories(uint* pdwNumCategories);
    HRESULT get_Category(uint dwIndex, GUID* pCategory);
    HRESULT get_NumConnections(uint* pdwNumConnections);
    HRESULT get_ConnectionInfo(uint dwIndex, KSTOPOLOGY_CONNECTION* pConnectionInfo);
    HRESULT get_NodeName(uint dwNodeId, char* pwchNodeName, uint dwBufSize, uint* pdwNameLen);
    HRESULT get_NumNodes(uint* pdwNumNodes);
    HRESULT get_NodeType(uint dwNodeId, GUID* pNodeType);
    HRESULT CreateNodeInstance(uint dwNodeId, const(GUID)* iid, void** ppvObject);
}

@GUID("1ABDAECA-68B6-4F83-9371-B413907C7B9F")
interface ISelector : IUnknown
{
    HRESULT get_NumSources(uint* pdwNumSources);
    HRESULT get_SourceNodeId(uint* pdwPinId);
    HRESULT put_SourceNodeId(uint dwPinId);
}

@GUID("2BA1785D-4D1B-44EF-85E8-C7F1D3F20184")
interface ICameraControl : IUnknown
{
    HRESULT get_Exposure(int* pValue, int* pFlags);
    HRESULT put_Exposure(int Value, int Flags);
    HRESULT getRange_Exposure(int* pMin, int* pMax, int* pSteppingDelta, int* pDefault, int* pCapsFlag);
    HRESULT get_Focus(int* pValue, int* pFlags);
    HRESULT put_Focus(int Value, int Flags);
    HRESULT getRange_Focus(int* pMin, int* pMax, int* pSteppingDelta, int* pDefault, int* pCapsFlag);
    HRESULT get_Iris(int* pValue, int* pFlags);
    HRESULT put_Iris(int Value, int Flags);
    HRESULT getRange_Iris(int* pMin, int* pMax, int* pSteppingDelta, int* pDefault, int* pCapsFlag);
    HRESULT get_Zoom(int* pValue, int* pFlags);
    HRESULT put_Zoom(int Value, int Flags);
    HRESULT getRange_Zoom(int* pMin, int* pMax, int* pSteppingDelta, int* pDefault, int* pCapsFlag);
    HRESULT get_FocalLengths(int* plOcularFocalLength, int* plObjectiveFocalLengthMin, 
                             int* plObjectiveFocalLengthMax);
    HRESULT get_Pan(int* pValue, int* pFlags);
    HRESULT put_Pan(int Value, int Flags);
    HRESULT getRange_Pan(int* pMin, int* pMax, int* pSteppingDelta, int* pDefault, int* pCapsFlag);
    HRESULT get_Tilt(int* pValue, int* pFlags);
    HRESULT put_Tilt(int Value, int Flags);
    HRESULT getRange_Tilt(int* pMin, int* pMax, int* pSteppingDelta, int* pDefault, int* pCapsFlag);
    HRESULT get_PanTilt(int* pPanValue, int* pTiltValue, int* pFlags);
    HRESULT put_PanTilt(int PanValue, int TiltValue, int Flags);
    HRESULT get_Roll(int* pValue, int* pFlags);
    HRESULT put_Roll(int Value, int Flags);
    HRESULT getRange_Roll(int* pMin, int* pMax, int* pSteppingDelta, int* pDefault, int* pCapsFlag);
    HRESULT get_ExposureRelative(int* pValue, int* pFlags);
    HRESULT put_ExposureRelative(int Value, int Flags);
    HRESULT getRange_ExposureRelative(int* pMin, int* pMax, int* pSteppingDelta, int* pDefault, int* pCapsFlag);
    HRESULT get_FocusRelative(int* pValue, int* pFlags);
    HRESULT put_FocusRelative(int Value, int Flags);
    HRESULT getRange_FocusRelative(int* pMin, int* pMax, int* pSteppingDelta, int* pDefault, int* pCapsFlag);
    HRESULT get_IrisRelative(int* pValue, int* pFlags);
    HRESULT put_IrisRelative(int Value, int Flags);
    HRESULT getRange_IrisRelative(int* pMin, int* pMax, int* pSteppingDelta, int* pDefault, int* pCapsFlag);
    HRESULT get_ZoomRelative(int* pValue, int* pFlags);
    HRESULT put_ZoomRelative(int Value, int Flags);
    HRESULT getRange_ZoomRelative(int* pMin, int* pMax, int* pSteppingDelta, int* pDefault, int* pCapsFlag);
    HRESULT get_PanRelative(int* pValue, int* pFlags);
    HRESULT put_PanRelative(int Value, int Flags);
    HRESULT get_TiltRelative(int* pValue, int* pFlags);
    HRESULT put_TiltRelative(int Value, int Flags);
    HRESULT getRange_TiltRelative(int* pMin, int* pMax, int* pSteppingDelta, int* pDefault, int* pCapsFlag);
    HRESULT get_PanTiltRelative(int* pPanValue, int* pTiltValue, int* pFlags);
    HRESULT put_PanTiltRelative(int PanValue, int TiltValue, int Flags);
    HRESULT getRange_PanRelative(int* pMin, int* pMax, int* pSteppingDelta, int* pDefault, int* pCapsFlag);
    HRESULT get_RollRelative(int* pValue, int* pFlags);
    HRESULT put_RollRelative(int Value, int Flags);
    HRESULT getRange_RollRelative(int* pMin, int* pMax, int* pSteppingDelta, int* pDefault, int* pCapsFlag);
    HRESULT get_ScanMode(int* pValue, int* pFlags);
    HRESULT put_ScanMode(int Value, int Flags);
    HRESULT get_PrivacyMode(int* pValue, int* pFlags);
    HRESULT put_PrivacyMode(int Value, int Flags);
}

@GUID("4050560E-42A7-413A-85C2-09269A2D0F44")
interface IVideoProcAmp : IUnknown
{
    HRESULT get_BacklightCompensation(int* pValue, int* pFlags);
    HRESULT put_BacklightCompensation(int Value, int Flags);
    HRESULT getRange_BacklightCompensation(int* pMin, int* pMax, int* pSteppingDelta, int* pDefault, 
                                           int* pCapsFlag);
    HRESULT get_Brightness(int* pValue, int* pFlags);
    HRESULT put_Brightness(int Value, int Flags);
    HRESULT getRange_Brightness(int* pMin, int* pMax, int* pSteppingDelta, int* pDefault, int* pCapsFlag);
    HRESULT get_ColorEnable(int* pValue, int* pFlags);
    HRESULT put_ColorEnable(int Value, int Flags);
    HRESULT getRange_ColorEnable(int* pMin, int* pMax, int* pSteppingDelta, int* pDefault, int* pCapsFlag);
    HRESULT get_Contrast(int* pValue, int* pFlags);
    HRESULT put_Contrast(int Value, int Flags);
    HRESULT getRange_Contrast(int* pMin, int* pMax, int* pSteppingDelta, int* pDefault, int* pCapsFlag);
    HRESULT get_Gamma(int* pValue, int* pFlags);
    HRESULT put_Gamma(int Value, int Flags);
    HRESULT getRange_Gamma(int* pMin, int* pMax, int* pSteppingDelta, int* pDefault, int* pCapsFlag);
    HRESULT get_Saturation(int* pValue, int* pFlags);
    HRESULT put_Saturation(int Value, int Flags);
    HRESULT getRange_Saturation(int* pMin, int* pMax, int* pSteppingDelta, int* pDefault, int* pCapsFlag);
    HRESULT get_Sharpness(int* pValue, int* pFlags);
    HRESULT put_Sharpness(int Value, int Flags);
    HRESULT getRange_Sharpness(int* pMin, int* pMax, int* pSteppingDelta, int* pDefault, int* pCapsFlag);
    HRESULT get_WhiteBalance(int* pValue, int* pFlags);
    HRESULT put_WhiteBalance(int Value, int Flags);
    HRESULT getRange_WhiteBalance(int* pMin, int* pMax, int* pSteppingDelta, int* pDefault, int* pCapsFlag);
    HRESULT get_Gain(int* pValue, int* pFlags);
    HRESULT put_Gain(int Value, int Flags);
    HRESULT getRange_Gain(int* pMin, int* pMax, int* pSteppingDelta, int* pDefault, int* pCapsFlag);
    HRESULT get_Hue(int* pValue, int* pFlags);
    HRESULT put_Hue(int Value, int Flags);
    HRESULT getRange_Hue(int* pMin, int* pMax, int* pSteppingDelta, int* pDefault, int* pCapsFlag);
    HRESULT get_DigitalMultiplier(int* pValue, int* pFlags);
    HRESULT put_DigitalMultiplier(int Value, int Flags);
    HRESULT getRange_DigitalMultiplier(int* pMin, int* pMax, int* pSteppingDelta, int* pDefault, int* pCapsFlag);
    HRESULT get_PowerlineFrequency(int* pValue, int* pFlags);
    HRESULT put_PowerlineFrequency(int Value, int Flags);
    HRESULT getRange_PowerlineFrequency(int* pMin, int* pMax, int* pSteppingDelta, int* pDefault, int* pCapsFlag);
    HRESULT get_WhiteBalanceComponent(int* pValue1, int* pValue2, int* pFlags);
    HRESULT put_WhiteBalanceComponent(int Value1, int Value2, int Flags);
    HRESULT getRange_WhiteBalanceComponent(int* pMin, int* pMax, int* pSteppingDelta, int* pDefault, 
                                           int* pCapsFlag);
}

@GUID("11737C14-24A7-4BB5-81A0-0D003813B0C4")
interface IKsNodeControl : IUnknown
{
    HRESULT put_NodeId(uint dwNodeId);
    HRESULT put_KsControl(void* pKsControl);
}

@GUID("45086030-F7E4-486A-B504-826BB5792A3B")
interface IConfigAsfWriter : IUnknown
{
    HRESULT ConfigureFilterUsingProfileId(uint dwProfileId);
    HRESULT GetCurrentProfileId(uint* pdwProfileId);
    HRESULT ConfigureFilterUsingProfileGuid(const(GUID)* guidProfile);
    HRESULT GetCurrentProfileGuid(GUID* pProfileGuid);
    HRESULT ConfigureFilterUsingProfile(IWMProfile pProfile);
    HRESULT GetCurrentProfile(IWMProfile* ppProfile);
    HRESULT SetIndexMode(BOOL bIndexFile);
    HRESULT GetIndexMode(int* pbIndexFile);
}

@GUID("7989CCAA-53F0-44F0-884A-F3B03F6AE066")
interface IConfigAsfWriter2 : IConfigAsfWriter
{
    HRESULT StreamNumFromPin(IPin pPin, ushort* pwStreamNum);
    HRESULT SetParam(uint dwParam, uint dwParam1, uint dwParam2);
    HRESULT GetParam(uint dwParam, uint* pdwParam1, uint* pdwParam2);
    HRESULT ResetMultiPassState();
}

@GUID("B502D1BC-9A57-11D0-8FDE-00C04FD9189D")
interface IMultiMediaStream : IUnknown
{
    HRESULT GetInformation(uint* pdwFlags, STREAM_TYPE* pStreamType);
    HRESULT GetMediaStream(GUID* idPurpose, IMediaStream* ppMediaStream);
    HRESULT EnumMediaStreams(int Index, IMediaStream* ppMediaStream);
    HRESULT GetState(STREAM_STATE* pCurrentState);
    HRESULT SetState(STREAM_STATE NewState);
    HRESULT GetTime(long* pCurrentTime);
    HRESULT GetDuration(long* pDuration);
    HRESULT Seek(long SeekTime);
    HRESULT GetEndOfStreamEventHandle(HANDLE* phEOS);
}

@GUID("B502D1BD-9A57-11D0-8FDE-00C04FD9189D")
interface IMediaStream : IUnknown
{
    HRESULT GetMultiMediaStream(IMultiMediaStream* ppMultiMediaStream);
    HRESULT GetInformation(GUID* pPurposeId, STREAM_TYPE* pType);
    HRESULT SetSameFormat(IMediaStream pStreamThatHasDesiredFormat, uint dwFlags);
    HRESULT AllocateSample(uint dwFlags, IStreamSample* ppSample);
    HRESULT CreateSharedSample(IStreamSample pExistingSample, uint dwFlags, IStreamSample* ppNewSample);
    HRESULT SendEndOfStream(uint dwFlags);
}

@GUID("B502D1BE-9A57-11D0-8FDE-00C04FD9189D")
interface IStreamSample : IUnknown
{
    HRESULT GetMediaStream(IMediaStream* ppMediaStream);
    HRESULT GetSampleTimes(long* pStartTime, long* pEndTime, long* pCurrentTime);
    HRESULT SetSampleTimes(const(long)* pStartTime, const(long)* pEndTime);
    HRESULT Update(uint dwFlags, HANDLE hEvent, PAPCFUNC pfnAPC, size_t dwAPCData);
    HRESULT CompletionStatus(uint dwFlags, uint dwMilliseconds);
}

@GUID("F4104FCE-9A70-11D0-8FDE-00C04FD9189D")
interface IDirectDrawMediaStream : IMediaStream
{
    HRESULT GetFormat(DDSURFACEDESC* pDDSDCurrent, IDirectDrawPalette* ppDirectDrawPalette, 
                      DDSURFACEDESC* pDDSDDesired, uint* pdwFlags);
    HRESULT SetFormat(const(DDSURFACEDESC)* pDDSurfaceDesc, IDirectDrawPalette pDirectDrawPalette);
    HRESULT GetDirectDraw(IDirectDraw* ppDirectDraw);
    HRESULT SetDirectDraw(IDirectDraw pDirectDraw);
    HRESULT CreateSample(IDirectDrawSurface pSurface, const(RECT)* pRect, uint dwFlags, 
                         IDirectDrawStreamSample* ppSample);
    HRESULT GetTimePerFrame(long* pFrameTime);
}

@GUID("F4104FCF-9A70-11D0-8FDE-00C04FD9189D")
interface IDirectDrawStreamSample : IStreamSample
{
    HRESULT GetSurface(IDirectDrawSurface* ppDirectDrawSurface, RECT* pRect);
    HRESULT SetRect(const(RECT)* pRect);
}

@GUID("F7537560-A3BE-11D0-8212-00C04FC32C45")
interface IAudioMediaStream : IMediaStream
{
    HRESULT GetFormat(WAVEFORMATEX* pWaveFormatCurrent);
    HRESULT SetFormat(const(WAVEFORMATEX)* lpWaveFormat);
    HRESULT CreateSample(IAudioData pAudioData, uint dwFlags, IAudioStreamSample* ppSample);
}

@GUID("345FEE00-ABA5-11D0-8212-00C04FC32C45")
interface IAudioStreamSample : IStreamSample
{
    HRESULT GetAudioData(IAudioData* ppAudio);
}

@GUID("327FC560-AF60-11D0-8212-00C04FC32C45")
interface IMemoryData : IUnknown
{
    HRESULT SetBuffer(uint cbSize, ubyte* pbData, uint dwFlags);
    HRESULT GetInfo(uint* pdwLength, ubyte** ppbData, uint* pcbActualData);
    HRESULT SetActual(uint cbDataValid);
}

@GUID("54C719C0-AF60-11D0-8212-00C04FC32C45")
interface IAudioData : IMemoryData
{
    HRESULT GetFormat(WAVEFORMATEX* pWaveFormatCurrent);
    HRESULT SetFormat(const(WAVEFORMATEX)* lpWaveFormat);
}

@GUID("BEBE595C-9A6F-11D0-8FDE-00C04FD9189D")
interface IAMMultiMediaStream : IMultiMediaStream
{
    HRESULT Initialize(STREAM_TYPE StreamType, uint dwFlags, IGraphBuilder pFilterGraph);
    HRESULT GetFilterGraph(IGraphBuilder* ppGraphBuilder);
    HRESULT GetFilter(IMediaStreamFilter* ppFilter);
    HRESULT AddMediaStream(IUnknown pStreamObject, const(GUID)* PurposeId, uint dwFlags, IMediaStream* ppNewStream);
    HRESULT OpenFile(const(wchar)* pszFileName, uint dwFlags);
    HRESULT OpenMoniker(IBindCtx pCtx, IMoniker pMoniker, uint dwFlags);
    HRESULT Render(uint dwFlags);
}

@GUID("BEBE595D-9A6F-11D0-8FDE-00C04FD9189D")
interface IAMMediaStream : IMediaStream
{
    HRESULT Initialize(IUnknown pSourceObject, uint dwFlags, GUID* PurposeId, const(STREAM_TYPE) StreamType);
    HRESULT SetState(FILTER_STATE State);
    HRESULT JoinAMMultiMediaStream(IAMMultiMediaStream pAMMultiMediaStream);
    HRESULT JoinFilter(IMediaStreamFilter pMediaStreamFilter);
    HRESULT JoinFilterGraph(IFilterGraph pFilterGraph);
}

@GUID("BEBE595E-9A6F-11D0-8FDE-00C04FD9189D")
interface IMediaStreamFilter : IBaseFilter
{
    HRESULT AddMediaStream(IAMMediaStream pAMMediaStream);
    HRESULT GetMediaStream(GUID* idPurpose, IMediaStream* ppMediaStream);
    HRESULT EnumMediaStreams(int Index, IMediaStream* ppMediaStream);
    HRESULT SupportSeeking(BOOL bRenderer);
    HRESULT ReferenceTimeToStreamTime(long* pTime);
    HRESULT GetCurrentStreamTime(long* pCurrentStreamTime);
    HRESULT WaitUntil(long WaitStreamTime);
    HRESULT Flush(BOOL bCancelEOS);
    HRESULT EndOfStream();
}

@GUID("AB6B4AFC-F6E4-11D0-900D-00C04FD9189D")
interface IDirectDrawMediaSampleAllocator : IUnknown
{
    HRESULT GetDirectDraw(IDirectDraw* ppDirectDraw);
}

@GUID("AB6B4AFE-F6E4-11D0-900D-00C04FD9189D")
interface IDirectDrawMediaSample : IUnknown
{
    HRESULT GetSurfaceAndReleaseLock(IDirectDrawSurface* ppDirectDrawSurface, RECT* pRect);
    HRESULT LockMediaSamplePointer();
}

@GUID("AB6B4AFA-F6E4-11D0-900D-00C04FD9189D")
interface IAMMediaTypeStream : IMediaStream
{
    HRESULT GetFormat(AM_MEDIA_TYPE* pMediaType, uint dwFlags);
    HRESULT SetFormat(AM_MEDIA_TYPE* pMediaType, uint dwFlags);
    HRESULT CreateSample(int lSampleSize, ubyte* pbBuffer, uint dwFlags, IUnknown pUnkOuter, 
                         IAMMediaTypeSample* ppAMMediaTypeSample);
    HRESULT GetStreamAllocatorRequirements(ALLOCATOR_PROPERTIES* pProps);
    HRESULT SetStreamAllocatorRequirements(ALLOCATOR_PROPERTIES* pProps);
}

@GUID("AB6B4AFB-F6E4-11D0-900D-00C04FD9189D")
interface IAMMediaTypeSample : IStreamSample
{
    HRESULT SetPointer(ubyte* pBuffer, int lSize);
    HRESULT GetPointer(ubyte** ppBuffer);
    int     GetSize();
    HRESULT GetTime(long* pTimeStart, long* pTimeEnd);
    HRESULT SetTime(long* pTimeStart, long* pTimeEnd);
    HRESULT IsSyncPoint();
    HRESULT SetSyncPoint(BOOL bIsSyncPoint);
    HRESULT IsPreroll();
    HRESULT SetPreroll(BOOL bIsPreroll);
    int     GetActualDataLength();
    HRESULT SetActualDataLength(int __MIDL__IAMMediaTypeSample0000);
    HRESULT GetMediaType(AM_MEDIA_TYPE** ppMediaType);
    HRESULT SetMediaType(AM_MEDIA_TYPE* pMediaType);
    HRESULT IsDiscontinuity();
    HRESULT SetDiscontinuity(BOOL bDiscontinuity);
    HRESULT GetMediaTime(long* pTimeStart, long* pTimeEnd);
    HRESULT SetMediaTime(long* pTimeStart, long* pTimeEnd);
}

interface IDirectDrawVideo : IUnknown
{
    HRESULT GetSwitches(uint* pSwitches);
    HRESULT SetSwitches(uint Switches);
    HRESULT GetCaps(DDCAPS_DX7* pCaps);
    HRESULT GetEmulatedCaps(DDCAPS_DX7* pCaps);
    HRESULT GetSurfaceDesc(DDSURFACEDESC* pSurfaceDesc);
    HRESULT GetFourCCCodes(uint* pCount, uint* pCodes);
    HRESULT SetDirectDraw(IDirectDraw pDirectDraw);
    HRESULT GetDirectDraw(IDirectDraw* ppDirectDraw);
    HRESULT GetSurfaceType(uint* pSurfaceType);
    HRESULT SetDefault();
    HRESULT UseScanLine(int UseScanLine);
    HRESULT CanUseScanLine(int* UseScanLine);
    HRESULT UseOverlayStretch(int UseOverlayStretch);
    HRESULT CanUseOverlayStretch(int* UseOverlayStretch);
    HRESULT UseWhenFullScreen(int UseWhenFullScreen);
    HRESULT WillUseFullScreen(int* UseWhenFullScreen);
}

interface IQualProp : IUnknown
{
    HRESULT get_FramesDroppedInRenderer(int* pcFrames);
    HRESULT get_FramesDrawn(int* pcFramesDrawn);
    HRESULT get_AvgFrameRate(int* piAvgFrameRate);
    HRESULT get_Jitter(int* iJitter);
    HRESULT get_AvgSyncOffset(int* piAvg);
    HRESULT get_DevSyncOffset(int* piDev);
}

interface IFullScreenVideo : IUnknown
{
    HRESULT CountModes(int* pModes);
    HRESULT GetModeInfo(int Mode, int* pWidth, int* pHeight, int* pDepth);
    HRESULT GetCurrentMode(int* pMode);
    HRESULT IsModeAvailable(int Mode);
    HRESULT IsModeEnabled(int Mode);
    HRESULT SetEnabled(int Mode, int bEnabled);
    HRESULT GetClipFactor(int* pClipFactor);
    HRESULT SetClipFactor(int ClipFactor);
    HRESULT SetMessageDrain(HWND hwnd);
    HRESULT GetMessageDrain(HWND* hwnd);
    HRESULT SetMonitor(int Monitor);
    HRESULT GetMonitor(int* Monitor);
    HRESULT HideOnDeactivate(int Hide);
    HRESULT IsHideOnDeactivate();
    HRESULT SetCaption(BSTR strCaption);
    HRESULT GetCaption(BSTR* pstrCaption);
    HRESULT SetDefault();
}

interface IFullScreenVideoEx : IFullScreenVideo
{
    HRESULT SetAcceleratorTable(HWND hwnd, HACCEL hAccel);
    HRESULT GetAcceleratorTable(HWND* phwnd, HACCEL* phAccel);
    HRESULT KeepPixelAspectRatio(int KeepAspect);
    HRESULT IsKeepPixelAspectRatio(int* pKeepAspect);
}

interface IBaseVideoMixer : IUnknown
{
    HRESULT SetLeadPin(int iPin);
    HRESULT GetLeadPin(int* piPin);
    HRESULT GetInputPinCount(int* piPinCount);
    HRESULT IsUsingClock(int* pbValue);
    HRESULT SetUsingClock(int bValue);
    HRESULT GetClockPeriod(int* pbValue);
    HRESULT SetClockPeriod(int bValue);
}

@GUID("52D6F586-9F0F-4824-8FC8-E32CA04930C2")
interface IDMOWrapperFilter : IUnknown
{
    HRESULT Init(const(GUID)* clsidDMO, const(GUID)* catDMO);
}

@GUID("28F54685-06FD-11D2-B27A-00A0C9223196")
interface IKsControl : IUnknown
{
    HRESULT KsProperty(char* Property, uint PropertyLength, char* PropertyData, uint DataLength, 
                       uint* BytesReturned);
    HRESULT KsMethod(char* Method, uint MethodLength, char* MethodData, uint DataLength, uint* BytesReturned);
    HRESULT KsEvent(char* Event, uint EventLength, char* EventData, uint DataLength, uint* BytesReturned);
}

@GUID("7F40EAC0-3947-11D2-874E-00A0C9223196")
interface IKsAggregateControl : IUnknown
{
    HRESULT KsAddAggregate(const(GUID)* AggregateClass);
    HRESULT KsRemoveAggregate(const(GUID)* AggregateClass);
}

@GUID("28F54683-06FD-11D2-B27A-00A0C9223196")
interface IKsTopology : IUnknown
{
    HRESULT CreateNodeInstance(uint NodeId, uint Flags, uint DesiredAccess, IUnknown UnkOuter, 
                               const(GUID)* InterfaceId, void** Interface);
}

@GUID("81A3BD31-DEE1-11D1-8508-00A0C91F9CA0")
interface IMixerOCXNotify : IUnknown
{
    HRESULT OnInvalidateRect(RECT* lpcRect);
    HRESULT OnStatusChange(uint ulStatusFlags);
    HRESULT OnDataChange(uint ulDataFlags);
}

@GUID("81A3BD32-DEE1-11D1-8508-00A0C91F9CA0")
interface IMixerOCX : IUnknown
{
    HRESULT OnDisplayChange(uint ulBitsPerPixel, uint ulScreenWidth, uint ulScreenHeight);
    HRESULT GetAspectRatio(uint* pdwPictAspectRatioX, uint* pdwPictAspectRatioY);
    HRESULT GetVideoSize(uint* pdwVideoWidth, uint* pdwVideoHeight);
    HRESULT GetStatus(uint** pdwStatus);
    HRESULT OnDraw(HDC hdcDraw, RECT* prcDraw);
    HRESULT SetDrawRegion(POINT* lpptTopLeftSC, RECT* prcDrawCC, RECT* lprcClip);
    HRESULT Advise(IMixerOCXNotify pmdns);
    HRESULT UnAdvise();
}

interface IMixerPinConfig : IUnknown
{
    HRESULT SetRelativePosition(uint dwLeft, uint dwTop, uint dwRight, uint dwBottom);
    HRESULT GetRelativePosition(uint* pdwLeft, uint* pdwTop, uint* pdwRight, uint* pdwBottom);
    HRESULT SetZOrder(uint dwZOrder);
    HRESULT GetZOrder(uint* pdwZOrder);
    HRESULT SetColorKey(COLORKEY* pColorKey);
    HRESULT GetColorKey(COLORKEY* pColorKey, uint* pColor);
    HRESULT SetBlendingParameter(uint dwBlendingParameter);
    HRESULT GetBlendingParameter(uint* pdwBlendingParameter);
    HRESULT SetAspectRatioMode(AM_ASPECT_RATIO_MODE amAspectRatioMode);
    HRESULT GetAspectRatioMode(AM_ASPECT_RATIO_MODE* pamAspectRatioMode);
    HRESULT SetStreamTransparent(BOOL bStreamTransparent);
    HRESULT GetStreamTransparent(int* pbStreamTransparent);
}

interface IMixerPinConfig2 : IMixerPinConfig
{
    HRESULT SetOverlaySurfaceColorControls(DDCOLORCONTROL* pColorControl);
    HRESULT GetOverlaySurfaceColorControls(DDCOLORCONTROL* pColorControl);
}

interface IMpegAudioDecoder : IUnknown
{
    HRESULT get_FrequencyDivider(uint* pDivider);
    HRESULT put_FrequencyDivider(uint Divider);
    HRESULT get_DecoderAccuracy(uint* pAccuracy);
    HRESULT put_DecoderAccuracy(uint Accuracy);
    HRESULT get_Stereo(uint* pStereo);
    HRESULT put_Stereo(uint Stereo);
    HRESULT get_DecoderWordSize(uint* pWordSize);
    HRESULT put_DecoderWordSize(uint WordSize);
    HRESULT get_IntegerDecode(uint* pIntDecode);
    HRESULT put_IntegerDecode(uint IntDecode);
    HRESULT get_DualMode(uint* pIntDecode);
    HRESULT put_DualMode(uint IntDecode);
    HRESULT get_AudioFormat(MPEG1WAVEFORMAT* lpFmt);
}

@GUID("69188C61-12A3-40F0-8FFC-342E7B433FD7")
interface IVMRImagePresenter9 : IUnknown
{
    HRESULT StartPresenting(size_t dwUserID);
    HRESULT StopPresenting(size_t dwUserID);
    HRESULT PresentImage(size_t dwUserID, VMR9PresentationInfo* lpPresInfo);
}

@GUID("8D5148EA-3F5D-46CF-9DF1-D1B896EEDB1F")
interface IVMRSurfaceAllocator9 : IUnknown
{
    HRESULT InitializeDevice(size_t dwUserID, VMR9AllocationInfo* lpAllocInfo, uint* lpNumBuffers);
    HRESULT TerminateDevice(size_t dwID);
    HRESULT GetSurface(size_t dwUserID, uint SurfaceIndex, uint SurfaceFlags, IDirect3DSurface9* lplpSurface);
    HRESULT AdviseNotify(IVMRSurfaceAllocatorNotify9 lpIVMRSurfAllocNotify);
}

@GUID("6DE9A68A-A928-4522-BF57-655AE3866456")
interface IVMRSurfaceAllocatorEx9 : IVMRSurfaceAllocator9
{
    HRESULT GetSurfaceEx(size_t dwUserID, uint SurfaceIndex, uint SurfaceFlags, IDirect3DSurface9* lplpSurface, 
                         RECT* lprcDst);
}

@GUID("DCA3F5DF-BB3A-4D03-BD81-84614BFBFA0C")
interface IVMRSurfaceAllocatorNotify9 : IUnknown
{
    HRESULT AdviseSurfaceAllocator(size_t dwUserID, IVMRSurfaceAllocator9 lpIVRMSurfaceAllocator);
    HRESULT SetD3DDevice(IDirect3DDevice9 lpD3DDevice, ptrdiff_t hMonitor);
    HRESULT ChangeD3DDevice(IDirect3DDevice9 lpD3DDevice, ptrdiff_t hMonitor);
    HRESULT AllocateSurfaceHelper(VMR9AllocationInfo* lpAllocInfo, uint* lpNumBuffers, 
                                  IDirect3DSurface9* lplpSurface);
    HRESULT NotifyEvent(int EventCode, ptrdiff_t Param1, ptrdiff_t Param2);
}

@GUID("8F537D09-F85E-4414-B23B-502E54C79927")
interface IVMRWindowlessControl9 : IUnknown
{
    HRESULT GetNativeVideoSize(int* lpWidth, int* lpHeight, int* lpARWidth, int* lpARHeight);
    HRESULT GetMinIdealVideoSize(int* lpWidth, int* lpHeight);
    HRESULT GetMaxIdealVideoSize(int* lpWidth, int* lpHeight);
    HRESULT SetVideoPosition(const(RECT)* lpSRCRect, const(RECT)* lpDSTRect);
    HRESULT GetVideoPosition(RECT* lpSRCRect, RECT* lpDSTRect);
    HRESULT GetAspectRatioMode(uint* lpAspectRatioMode);
    HRESULT SetAspectRatioMode(uint AspectRatioMode);
    HRESULT SetVideoClippingWindow(HWND hwnd);
    HRESULT RepaintVideo(HWND hwnd, HDC hdc);
    HRESULT DisplayModeChanged();
    HRESULT GetCurrentImage(ubyte** lpDib);
    HRESULT SetBorderColor(uint Clr);
    HRESULT GetBorderColor(uint* lpClr);
}

@GUID("1A777EAA-47C8-4930-B2C9-8FEE1C1B0F3B")
interface IVMRMixerControl9 : IUnknown
{
    HRESULT SetAlpha(uint dwStreamID, float Alpha);
    HRESULT GetAlpha(uint dwStreamID, float* pAlpha);
    HRESULT SetZOrder(uint dwStreamID, uint dwZ);
    HRESULT GetZOrder(uint dwStreamID, uint* pZ);
    HRESULT SetOutputRect(uint dwStreamID, const(VMR9NormalizedRect)* pRect);
    HRESULT GetOutputRect(uint dwStreamID, VMR9NormalizedRect* pRect);
    HRESULT SetBackgroundClr(uint ClrBkg);
    HRESULT GetBackgroundClr(uint* lpClrBkg);
    HRESULT SetMixingPrefs(uint dwMixerPrefs);
    HRESULT GetMixingPrefs(uint* pdwMixerPrefs);
    HRESULT SetProcAmpControl(uint dwStreamID, VMR9ProcAmpControl* lpClrControl);
    HRESULT GetProcAmpControl(uint dwStreamID, VMR9ProcAmpControl* lpClrControl);
    HRESULT GetProcAmpControlRange(uint dwStreamID, VMR9ProcAmpControlRange* lpClrControl);
}

@GUID("CED175E5-1935-4820-81BD-FF6AD00C9108")
interface IVMRMixerBitmap9 : IUnknown
{
    HRESULT SetAlphaBitmap(const(VMR9AlphaBitmap)* pBmpParms);
    HRESULT UpdateAlphaBitmapParameters(const(VMR9AlphaBitmap)* pBmpParms);
    HRESULT GetAlphaBitmapParameters(VMR9AlphaBitmap* pBmpParms);
}

@GUID("DFC581A1-6E1F-4C3A-8D0A-5E9792EA2AFC")
interface IVMRSurface9 : IUnknown
{
    HRESULT IsSurfaceLocked();
    HRESULT LockSurface(ubyte** lpSurface);
    HRESULT UnlockSurface();
    HRESULT GetSurface(IDirect3DSurface9* lplpSurface);
}

@GUID("45C15CAB-6E22-420A-8043-AE1F0AC02C7D")
interface IVMRImagePresenterConfig9 : IUnknown
{
    HRESULT SetRenderingPrefs(uint dwRenderFlags);
    HRESULT GetRenderingPrefs(uint* dwRenderFlags);
}

@GUID("D0CFE38B-93E7-4772-8957-0400C49A4485")
interface IVMRVideoStreamControl9 : IUnknown
{
    HRESULT SetStreamActiveState(BOOL fActive);
    HRESULT GetStreamActiveState(int* lpfActive);
}

@GUID("5A804648-4F66-4867-9C43-4F5C822CF1B8")
interface IVMRFilterConfig9 : IUnknown
{
    HRESULT SetImageCompositor(IVMRImageCompositor9 lpVMRImgCompositor);
    HRESULT SetNumberOfStreams(uint dwMaxStreams);
    HRESULT GetNumberOfStreams(uint* pdwMaxStreams);
    HRESULT SetRenderingPrefs(uint dwRenderFlags);
    HRESULT GetRenderingPrefs(uint* pdwRenderFlags);
    HRESULT SetRenderingMode(uint Mode);
    HRESULT GetRenderingMode(uint* pMode);
}

@GUID("00D96C29-BBDE-4EFC-9901-BB5036392146")
interface IVMRAspectRatioControl9 : IUnknown
{
    HRESULT GetAspectRatioMode(uint* lpdwARMode);
    HRESULT SetAspectRatioMode(uint dwARMode);
}

@GUID("46C2E457-8BA0-4EEF-B80B-0680F0978749")
interface IVMRMonitorConfig9 : IUnknown
{
    HRESULT SetMonitor(uint uDev);
    HRESULT GetMonitor(uint* puDev);
    HRESULT SetDefaultMonitor(uint uDev);
    HRESULT GetDefaultMonitor(uint* puDev);
    HRESULT GetAvailableMonitors(VMR9MonitorInfo* pInfo, uint dwMaxInfoArraySize, uint* pdwNumDevices);
}

@GUID("A215FB8D-13C2-4F7F-993C-003D6271A459")
interface IVMRDeinterlaceControl9 : IUnknown
{
    HRESULT GetNumberOfDeinterlaceModes(VMR9VideoDesc* lpVideoDescription, uint* lpdwNumDeinterlaceModes, 
                                        GUID* lpDeinterlaceModes);
    HRESULT GetDeinterlaceModeCaps(GUID* lpDeinterlaceMode, VMR9VideoDesc* lpVideoDescription, 
                                   VMR9DeinterlaceCaps* lpDeinterlaceCaps);
    HRESULT GetDeinterlaceMode(uint dwStreamID, GUID* lpDeinterlaceMode);
    HRESULT SetDeinterlaceMode(uint dwStreamID, GUID* lpDeinterlaceMode);
    HRESULT GetDeinterlacePrefs(uint* lpdwDeinterlacePrefs);
    HRESULT SetDeinterlacePrefs(uint dwDeinterlacePrefs);
    HRESULT GetActualDeinterlaceMode(uint dwStreamID, GUID* lpDeinterlaceMode);
}

@GUID("4A5C89EB-DF51-4654-AC2A-E48E02BBABF6")
interface IVMRImageCompositor9 : IUnknown
{
    HRESULT InitCompositionDevice(IUnknown pD3DDevice);
    HRESULT TermCompositionDevice(IUnknown pD3DDevice);
    HRESULT SetStreamMediaType(uint dwStrmID, AM_MEDIA_TYPE* pmt, BOOL fTexture);
    HRESULT CompositeImage(IUnknown pD3DDevice, IDirect3DSurface9 pddsRenderTarget, AM_MEDIA_TYPE* pmtRenderTarget, 
                           long rtStart, long rtEnd, uint dwClrBkGnd, VMR9VideoStreamInfo* pVideoStreamInfo, 
                           uint cStreams);
}

interface IVPBaseConfig : IUnknown
{
    HRESULT GetConnectInfo(uint* pdwNumConnectInfo, char* pddVPConnectInfo);
    HRESULT SetConnectInfo(uint dwChosenEntry);
    HRESULT GetVPDataInfo(AMVPDATAINFO* pamvpDataInfo);
    HRESULT GetMaxPixelRate(AMVPSIZE* pamvpSize, uint* pdwMaxPixelsPerSecond);
    HRESULT InformVPInputFormats(uint dwNumFormats, DDPIXELFORMAT* pDDPixelFormats);
    HRESULT GetVideoFormats(uint* pdwNumFormats, char* pddPixelFormats);
    HRESULT SetVideoFormat(uint dwChosenEntry);
    HRESULT SetInvertPolarity();
    HRESULT GetOverlaySurface(IDirectDrawSurface* ppddOverlaySurface);
    HRESULT SetDirectDrawKernelHandle(size_t dwDDKernelHandle);
    HRESULT SetVideoPortID(uint dwVideoPortID);
    HRESULT SetDDSurfaceKernelHandles(uint cHandles, size_t* rgDDKernelHandles);
    HRESULT SetSurfaceParameters(uint dwPitch, uint dwXOrigin, uint dwYOrigin);
}

interface IVPConfig : IVPBaseConfig
{
    HRESULT IsVPDecimationAllowed(int* pbIsDecimationAllowed);
    HRESULT SetScalingFactors(AMVPSIZE* pamvpSize);
}

interface IVPVBIConfig : IVPBaseConfig
{
}

interface IVPBaseNotify : IUnknown
{
    HRESULT RenegotiateVPParameters();
}

interface IVPNotify : IVPBaseNotify
{
    HRESULT SetDeinterlaceMode(AMVP_MODE mode);
    HRESULT GetDeinterlaceMode(AMVP_MODE* pMode);
}

interface IVPNotify2 : IVPNotify
{
    HRESULT SetVPSyncMaster(BOOL bVPSyncMaster);
    HRESULT GetVPSyncMaster(int* pbVPSyncMaster);
}

interface IVPVBINotify : IVPBaseNotify
{
}

interface IXMLGraphBuilder : IUnknown
{
    HRESULT BuildFromXML(IGraphBuilder pGraph, IXMLElement pxml);
    HRESULT SaveToXML(IGraphBuilder pGraph, BSTR* pbstrxml);
    HRESULT BuildFromXMLFile(IGraphBuilder pGraph, const(wchar)* wszFileName, const(wchar)* wszBaseURL);
}

@GUID("6D6CBB60-A223-44AA-842F-A2F06750BE6D")
interface IMediaParamInfo : IUnknown
{
    HRESULT GetParamCount(uint* pdwParams);
    HRESULT GetParamInfo(uint dwParamIndex, MP_PARAMINFO* pInfo);
    HRESULT GetParamText(uint dwParamIndex, ushort** ppwchText);
    HRESULT GetNumTimeFormats(uint* pdwNumTimeFormats);
    HRESULT GetSupportedTimeFormat(uint dwFormatIndex, GUID* pguidTimeFormat);
    HRESULT GetCurrentTimeFormat(GUID* pguidTimeFormat, uint* pTimeData);
}

@GUID("6D6CBB61-A223-44AA-842F-A2F06750BE6E")
interface IMediaParams : IUnknown
{
    HRESULT GetParam(uint dwParamIndex, float* pValue);
    HRESULT SetParam(uint dwParamIndex, float value);
    HRESULT AddEnvelope(uint dwParamIndex, uint cSegments, MP_ENVELOPE_SEGMENT* pEnvelopeSegments);
    HRESULT FlushEnvelope(uint dwParamIndex, long refTimeStart, long refTimeEnd);
    HRESULT SetTimeFormat(GUID guidTimeFormat, uint mpTimeData);
}

@GUID("8A674B48-1F63-11D3-B64C-00C04F79498E")
interface ICreatePropBagOnRegKey : IUnknown
{
    HRESULT Create(HKEY hkey, ushort* subkey, uint ulOptions, uint samDesired, const(GUID)* iid, void** ppBag);
}

@GUID("901284E4-33FE-4B69-8D63-634A596F3756")
interface ITuningSpaces : IDispatch
{
    HRESULT get_Count(int* Count);
    HRESULT get__NewEnum(IEnumVARIANT* NewEnum);
    HRESULT get_Item(VARIANT varIndex, ITuningSpace* TuningSpace);
    HRESULT get_EnumTuningSpaces(IEnumTuningSpaces* NewEnum);
}

@GUID("5B692E84-E2F1-11D2-9493-00C04F72D980")
interface ITuningSpaceContainer : IDispatch
{
    HRESULT get_Count(int* Count);
    HRESULT get__NewEnum(IEnumVARIANT* NewEnum);
    HRESULT get_Item(VARIANT varIndex, ITuningSpace* TuningSpace);
    HRESULT put_Item(VARIANT varIndex, ITuningSpace TuningSpace);
    HRESULT TuningSpacesForCLSID(BSTR SpaceCLSID, ITuningSpaces* NewColl);
    HRESULT _TuningSpacesForCLSID2(const(GUID)* SpaceCLSID, ITuningSpaces* NewColl);
    HRESULT TuningSpacesForName(BSTR Name, ITuningSpaces* NewColl);
    HRESULT FindID(ITuningSpace TuningSpace, int* ID);
    HRESULT Add(ITuningSpace TuningSpace, VARIANT* NewIndex);
    HRESULT get_EnumTuningSpaces(IEnumTuningSpaces* ppEnum);
    HRESULT Remove(VARIANT Index);
    HRESULT get_MaxCount(int* MaxCount);
    HRESULT put_MaxCount(int MaxCount);
}

@GUID("061C6E30-E622-11D2-9493-00C04F72D980")
interface ITuningSpace : IDispatch
{
    HRESULT get_UniqueName(BSTR* Name);
    HRESULT put_UniqueName(BSTR Name);
    HRESULT get_FriendlyName(BSTR* Name);
    HRESULT put_FriendlyName(BSTR Name);
    HRESULT get_CLSID(BSTR* SpaceCLSID);
    HRESULT get_NetworkType(BSTR* NetworkTypeGuid);
    HRESULT put_NetworkType(BSTR NetworkTypeGuid);
    HRESULT get__NetworkType(GUID* NetworkTypeGuid);
    HRESULT put__NetworkType(const(GUID)* NetworkTypeGuid);
    HRESULT CreateTuneRequest(ITuneRequest* TuneRequest);
    HRESULT EnumCategoryGUIDs(IEnumGUID* ppEnum);
    HRESULT EnumDeviceMonikers(IEnumMoniker* ppEnum);
    HRESULT get_DefaultPreferredComponentTypes(IComponentTypes* ComponentTypes);
    HRESULT put_DefaultPreferredComponentTypes(IComponentTypes NewComponentTypes);
    HRESULT get_FrequencyMapping(BSTR* pMapping);
    HRESULT put_FrequencyMapping(BSTR Mapping);
    HRESULT get_DefaultLocator(ILocator* LocatorVal);
    HRESULT put_DefaultLocator(ILocator LocatorVal);
    HRESULT Clone(ITuningSpace* NewTS);
}

@GUID("8B8EB248-FC2B-11D2-9D8C-00C04F72D980")
interface IEnumTuningSpaces : IUnknown
{
    HRESULT Next(uint celt, char* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumTuningSpaces* ppEnum);
}

@GUID("ADA0B268-3B19-4E5B-ACC4-49F852BE13BA")
interface IDVBTuningSpace : ITuningSpace
{
    HRESULT get_SystemType(DVBSystemType* SysType);
    HRESULT put_SystemType(DVBSystemType SysType);
}

@GUID("843188B4-CE62-43DB-966B-8145A094E040")
interface IDVBTuningSpace2 : IDVBTuningSpace
{
    HRESULT get_NetworkID(int* NetworkID);
    HRESULT put_NetworkID(int NetworkID);
}

@GUID("CDF7BE60-D954-42FD-A972-78971958E470")
interface IDVBSTuningSpace : IDVBTuningSpace2
{
    HRESULT get_LowOscillator(int* LowOscillator);
    HRESULT put_LowOscillator(int LowOscillator);
    HRESULT get_HighOscillator(int* HighOscillator);
    HRESULT put_HighOscillator(int HighOscillator);
    HRESULT get_LNBSwitch(int* LNBSwitch);
    HRESULT put_LNBSwitch(int LNBSwitch);
    HRESULT get_InputRange(BSTR* InputRange);
    HRESULT put_InputRange(BSTR InputRange);
    HRESULT get_SpectralInversion(SpectralInversion* SpectralInversionVal);
    HRESULT put_SpectralInversion(SpectralInversion SpectralInversionVal);
}

@GUID("E48244B8-7E17-4F76-A763-5090FF1E2F30")
interface IAuxInTuningSpace : ITuningSpace
{
}

@GUID("B10931ED-8BFE-4AB0-9DCE-E469C29A9729")
interface IAuxInTuningSpace2 : IAuxInTuningSpace
{
    HRESULT get_CountryCode(int* CountryCodeVal);
    HRESULT put_CountryCode(int NewCountryCodeVal);
}

@GUID("2A6E293C-2595-11D3-B64C-00C04F79498E")
interface IAnalogTVTuningSpace : ITuningSpace
{
    HRESULT get_MinChannel(int* MinChannelVal);
    HRESULT put_MinChannel(int NewMinChannelVal);
    HRESULT get_MaxChannel(int* MaxChannelVal);
    HRESULT put_MaxChannel(int NewMaxChannelVal);
    HRESULT get_InputType(TunerInputType* InputTypeVal);
    HRESULT put_InputType(TunerInputType NewInputTypeVal);
    HRESULT get_CountryCode(int* CountryCodeVal);
    HRESULT put_CountryCode(int NewCountryCodeVal);
}

@GUID("0369B4E2-45B6-11D3-B650-00C04F79498E")
interface IATSCTuningSpace : IAnalogTVTuningSpace
{
    HRESULT get_MinMinorChannel(int* MinMinorChannelVal);
    HRESULT put_MinMinorChannel(int NewMinMinorChannelVal);
    HRESULT get_MaxMinorChannel(int* MaxMinorChannelVal);
    HRESULT put_MaxMinorChannel(int NewMaxMinorChannelVal);
    HRESULT get_MinPhysicalChannel(int* MinPhysicalChannelVal);
    HRESULT put_MinPhysicalChannel(int NewMinPhysicalChannelVal);
    HRESULT get_MaxPhysicalChannel(int* MaxPhysicalChannelVal);
    HRESULT put_MaxPhysicalChannel(int NewMaxPhysicalChannelVal);
}

@GUID("013F9F9C-B449-4EC7-A6D2-9D4F2FC70AE5")
interface IDigitalCableTuningSpace : IATSCTuningSpace
{
    HRESULT get_MinMajorChannel(int* MinMajorChannelVal);
    HRESULT put_MinMajorChannel(int NewMinMajorChannelVal);
    HRESULT get_MaxMajorChannel(int* MaxMajorChannelVal);
    HRESULT put_MaxMajorChannel(int NewMaxMajorChannelVal);
    HRESULT get_MinSourceID(int* MinSourceIDVal);
    HRESULT put_MinSourceID(int NewMinSourceIDVal);
    HRESULT get_MaxSourceID(int* MaxSourceIDVal);
    HRESULT put_MaxSourceID(int NewMaxSourceIDVal);
}

@GUID("2A6E293B-2595-11D3-B64C-00C04F79498E")
interface IAnalogRadioTuningSpace : ITuningSpace
{
    HRESULT get_MinFrequency(int* MinFrequencyVal);
    HRESULT put_MinFrequency(int NewMinFrequencyVal);
    HRESULT get_MaxFrequency(int* MaxFrequencyVal);
    HRESULT put_MaxFrequency(int NewMaxFrequencyVal);
    HRESULT get_Step(int* StepVal);
    HRESULT put_Step(int NewStepVal);
}

@GUID("39DD45DA-2DA8-46BA-8A8A-87E2B73D983A")
interface IAnalogRadioTuningSpace2 : IAnalogRadioTuningSpace
{
    HRESULT get_CountryCode(int* CountryCodeVal);
    HRESULT put_CountryCode(int NewCountryCodeVal);
}

@GUID("07DDC146-FC3D-11D2-9D8C-00C04F72D980")
interface ITuneRequest : IDispatch
{
    HRESULT get_TuningSpace(ITuningSpace* TuningSpace);
    HRESULT get_Components(IComponents* Components);
    HRESULT Clone(ITuneRequest* NewTuneRequest);
    HRESULT get_Locator(ILocator* Locator);
    HRESULT put_Locator(ILocator Locator);
}

@GUID("156EFF60-86F4-4E28-89FC-109799FD57EE")
interface IChannelIDTuneRequest : ITuneRequest
{
    HRESULT get_ChannelID(BSTR* ChannelID);
    HRESULT put_ChannelID(BSTR ChannelID);
}

@GUID("0369B4E0-45B6-11D3-B650-00C04F79498E")
interface IChannelTuneRequest : ITuneRequest
{
    HRESULT get_Channel(int* Channel);
    HRESULT put_Channel(int Channel);
}

@GUID("0369B4E1-45B6-11D3-B650-00C04F79498E")
interface IATSCChannelTuneRequest : IChannelTuneRequest
{
    HRESULT get_MinorChannel(int* MinorChannel);
    HRESULT put_MinorChannel(int MinorChannel);
}

@GUID("BAD7753B-6B37-4810-AE57-3CE0C4A9E6CB")
interface IDigitalCableTuneRequest : IATSCChannelTuneRequest
{
    HRESULT get_MajorChannel(int* pMajorChannel);
    HRESULT put_MajorChannel(int MajorChannel);
    HRESULT get_SourceID(int* pSourceID);
    HRESULT put_SourceID(int SourceID);
}

@GUID("0D6F567E-A636-42BB-83BA-CE4C1704AFA2")
interface IDVBTuneRequest : ITuneRequest
{
    HRESULT get_ONID(int* ONID);
    HRESULT put_ONID(int ONID);
    HRESULT get_TSID(int* TSID);
    HRESULT put_TSID(int TSID);
    HRESULT get_SID(int* SID);
    HRESULT put_SID(int SID);
}

@GUID("EB7D987F-8A01-42AD-B8AE-574DEEE44D1A")
interface IMPEG2TuneRequest : ITuneRequest
{
    HRESULT get_TSID(int* TSID);
    HRESULT put_TSID(int TSID);
    HRESULT get_ProgNo(int* ProgNo);
    HRESULT put_ProgNo(int ProgNo);
}

@GUID("14E11ABD-EE37-4893-9EA1-6964DE933E39")
interface IMPEG2TuneRequestFactory : IDispatch
{
    HRESULT CreateTuneRequest(ITuningSpace TuningSpace, IMPEG2TuneRequest* TuneRequest);
}

@GUID("1B9D5FC3-5BBC-4B6C-BB18-B9D10E3EEEBF")
interface IMPEG2TuneRequestSupport : IUnknown
{
}

@GUID("E60DFA45-8D56-4E65-A8AB-D6BE9412C249")
interface ITunerCap : IUnknown
{
    HRESULT get_SupportedNetworkTypes(uint ulcNetworkTypesMax, uint* pulcNetworkTypes, GUID* pguidNetworkTypes);
    HRESULT get_SupportedVideoFormats(uint* pulAMTunerModeType, uint* pulAnalogVideoStandard);
    HRESULT get_AuxInputCount(uint* pulCompositeCount, uint* pulSvideoCount);
}

@GUID("ED3E0C66-18C8-4EA6-9300-F6841FDD35DC")
interface ITunerCapEx : IUnknown
{
    HRESULT get_Has608_708Caption(short* pbHasCaption);
}

@GUID("28C52640-018A-11D3-9D8E-00C04F72D980")
interface ITuner : IUnknown
{
    HRESULT get_TuningSpace(ITuningSpace* TuningSpace);
    HRESULT put_TuningSpace(ITuningSpace TuningSpace);
    HRESULT EnumTuningSpaces(IEnumTuningSpaces* ppEnum);
    HRESULT get_TuneRequest(ITuneRequest* TuneRequest);
    HRESULT put_TuneRequest(ITuneRequest TuneRequest);
    HRESULT Validate(ITuneRequest TuneRequest);
    HRESULT get_PreferredComponentTypes(IComponentTypes* ComponentTypes);
    HRESULT put_PreferredComponentTypes(IComponentTypes ComponentTypes);
    HRESULT get_SignalStrength(int* Strength);
    HRESULT TriggerSignalEvents(int Interval);
}

@GUID("1DFD0A5C-0284-11D3-9D8E-00C04F72D980")
interface IScanningTuner : ITuner
{
    HRESULT SeekUp();
    HRESULT SeekDown();
    HRESULT ScanUp(int MillisecondsPause);
    HRESULT ScanDown(int MillisecondsPause);
    HRESULT AutoProgram();
}

@GUID("04BBD195-0E2D-4593-9BD5-4F908BC33CF5")
interface IScanningTunerEx : IScanningTuner
{
    HRESULT GetCurrentLocator(ILocator* pILocator);
    HRESULT PerformExhaustiveScan(int dwLowerFreq, int dwHigherFreq, short bFineTune, size_t hEvent);
    HRESULT TerminateCurrentScan(int* pcurrentFreq);
    HRESULT ResumeCurrentScan(size_t hEvent);
    HRESULT GetTunerScanningCapability(int* HardwareAssistedScanning, int* NumStandardsSupported, 
                                       GUID* BroadcastStandards);
    HRESULT GetTunerStatus(int* SecondsLeft, int* CurrentLockType, int* AutoDetect, int* CurrentFreq);
    HRESULT GetCurrentTunerStandardCapability(GUID CurrentBroadcastStandard, int* SettlingTime, 
                                              int* TvStandardsSupported);
    HRESULT SetScanSignalTypeFilter(int ScanModulationTypes, int AnalogVideoStandard);
}

@GUID("6A340DC0-0311-11D3-9D8E-00C04F72D980")
interface IComponentType : IDispatch
{
    HRESULT get_Category(ComponentCategory* Category);
    HRESULT put_Category(ComponentCategory Category);
    HRESULT get_MediaMajorType(BSTR* MediaMajorType);
    HRESULT put_MediaMajorType(BSTR MediaMajorType);
    HRESULT get__MediaMajorType(GUID* MediaMajorTypeGuid);
    HRESULT put__MediaMajorType(const(GUID)* MediaMajorTypeGuid);
    HRESULT get_MediaSubType(BSTR* MediaSubType);
    HRESULT put_MediaSubType(BSTR MediaSubType);
    HRESULT get__MediaSubType(GUID* MediaSubTypeGuid);
    HRESULT put__MediaSubType(const(GUID)* MediaSubTypeGuid);
    HRESULT get_MediaFormatType(BSTR* MediaFormatType);
    HRESULT put_MediaFormatType(BSTR MediaFormatType);
    HRESULT get__MediaFormatType(GUID* MediaFormatTypeGuid);
    HRESULT put__MediaFormatType(const(GUID)* MediaFormatTypeGuid);
    HRESULT get_MediaType(AM_MEDIA_TYPE* MediaType);
    HRESULT put_MediaType(AM_MEDIA_TYPE* MediaType);
    HRESULT Clone(IComponentType* NewCT);
}

@GUID("B874C8BA-0FA2-11D3-9D8E-00C04F72D980")
interface ILanguageComponentType : IComponentType
{
    HRESULT get_LangID(int* LangID);
    HRESULT put_LangID(int LangID);
}

@GUID("2C073D84-B51C-48C9-AA9F-68971E1F6E38")
interface IMPEG2ComponentType : ILanguageComponentType
{
    HRESULT get_StreamType(MPEG2StreamType* MP2StreamType);
    HRESULT put_StreamType(MPEG2StreamType MP2StreamType);
}

@GUID("FC189E4D-7BD4-4125-B3B3-3A76A332CC96")
interface IATSCComponentType : IMPEG2ComponentType
{
    HRESULT get_Flags(int* Flags);
    HRESULT put_Flags(int flags);
}

@GUID("8A674B4A-1F63-11D3-B64C-00C04F79498E")
interface IEnumComponentTypes : IUnknown
{
    HRESULT Next(uint celt, char* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumComponentTypes* ppEnum);
}

@GUID("0DC13D4A-0313-11D3-9D8E-00C04F72D980")
interface IComponentTypes : IDispatch
{
    HRESULT get_Count(int* Count);
    HRESULT get__NewEnum(IEnumVARIANT* ppNewEnum);
    HRESULT EnumComponentTypes(IEnumComponentTypes* ppNewEnum);
    HRESULT get_Item(VARIANT Index, IComponentType* ComponentType);
    HRESULT put_Item(VARIANT Index, IComponentType ComponentType);
    HRESULT Add(IComponentType ComponentType, VARIANT* NewIndex);
    HRESULT Remove(VARIANT Index);
    HRESULT Clone(IComponentTypes* NewList);
}

@GUID("1A5576FC-0E19-11D3-9D8E-00C04F72D980")
interface IComponent : IDispatch
{
    HRESULT get_Type(IComponentType* CT);
    HRESULT put_Type(IComponentType CT);
    HRESULT get_DescLangID(int* LangID);
    HRESULT put_DescLangID(int LangID);
    HRESULT get_Status(ComponentStatus* Status);
    HRESULT put_Status(ComponentStatus Status);
    HRESULT get_Description(BSTR* Description);
    HRESULT put_Description(BSTR Description);
    HRESULT Clone(IComponent* NewComponent);
}

@GUID("2CFEB2A8-1787-4A24-A941-C6EAEC39C842")
interface IAnalogAudioComponentType : IComponentType
{
    HRESULT get_AnalogAudioMode(TVAudioMode* Mode);
    HRESULT put_AnalogAudioMode(TVAudioMode Mode);
}

@GUID("1493E353-1EB6-473C-802D-8E6B8EC9D2A9")
interface IMPEG2Component : IComponent
{
    HRESULT put_DescLangID(int LangID);
    HRESULT get_Status(ComponentStatus* Status);
    HRESULT put_Status(ComponentStatus Status);
    HRESULT get_Description(BSTR* Description);
    HRESULT put_Description(BSTR Description);
    HRESULT Clone(IComponent* NewComponent);
    HRESULT get_PID(int* PID);
    HRESULT put_PID(int PID);
    HRESULT get_PCRPID(int* PCRPID);
    HRESULT put_PCRPID(int PCRPID);
    HRESULT get_ProgramNumber(int* ProgramNumber);
    HRESULT put_ProgramNumber(int ProgramNumber);
}

@GUID("2A6E2939-2595-11D3-B64C-00C04F79498E")
interface IEnumComponents : IUnknown
{
    HRESULT Next(uint celt, char* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumComponents* ppEnum);
}

@GUID("39A48091-FFFE-4182-A161-3FF802640E26")
interface IComponents : IDispatch
{
    HRESULT get_Count(int* Count);
    HRESULT get__NewEnum(IEnumVARIANT* ppNewEnum);
    HRESULT EnumComponents(IEnumComponents* ppNewEnum);
    HRESULT get_Item(VARIANT Index, IComponent* ppComponent);
    HRESULT Add(IComponent Component, VARIANT* NewIndex);
    HRESULT Remove(VARIANT Index);
    HRESULT Clone(IComponents* NewList);
    HRESULT put_Item(VARIANT Index, IComponent ppComponent);
}

@GUID("FCD01846-0E19-11D3-9D8E-00C04F72D980")
interface IComponentsOld : IDispatch
{
    HRESULT get_Count(int* Count);
    HRESULT get__NewEnum(IEnumVARIANT* ppNewEnum);
    HRESULT EnumComponents(IEnumComponents* ppNewEnum);
    HRESULT get_Item(VARIANT Index, IComponent* ppComponent);
    HRESULT Add(IComponent Component, VARIANT* NewIndex);
    HRESULT Remove(VARIANT Index);
    HRESULT Clone(IComponents* NewList);
}

@GUID("286D7F89-760C-4F89-80C4-66841D2507AA")
interface ILocator : IDispatch
{
    HRESULT get_CarrierFrequency(int* Frequency);
    HRESULT put_CarrierFrequency(int Frequency);
    HRESULT get_InnerFEC(FECMethod* FEC);
    HRESULT put_InnerFEC(FECMethod FEC);
    HRESULT get_InnerFECRate(BinaryConvolutionCodeRate* FEC);
    HRESULT put_InnerFECRate(BinaryConvolutionCodeRate FEC);
    HRESULT get_OuterFEC(FECMethod* FEC);
    HRESULT put_OuterFEC(FECMethod FEC);
    HRESULT get_OuterFECRate(BinaryConvolutionCodeRate* FEC);
    HRESULT put_OuterFECRate(BinaryConvolutionCodeRate FEC);
    HRESULT get_Modulation(ModulationType* Modulation);
    HRESULT put_Modulation(ModulationType Modulation);
    HRESULT get_SymbolRate(int* Rate);
    HRESULT put_SymbolRate(int Rate);
    HRESULT Clone(ILocator* NewLocator);
}

@GUID("34D1F26B-E339-430D-ABCE-738CB48984DC")
interface IAnalogLocator : ILocator
{
    HRESULT get_VideoStandard(AnalogVideoStandard* AVS);
    HRESULT put_VideoStandard(AnalogVideoStandard AVS);
}

@GUID("19B595D8-839A-47F0-96DF-4F194F3C768C")
interface IDigitalLocator : ILocator
{
}

@GUID("BF8D986F-8C2B-4131-94D7-4D3D9FCC21EF")
interface IATSCLocator : IDigitalLocator
{
    HRESULT get_PhysicalChannel(int* PhysicalChannel);
    HRESULT put_PhysicalChannel(int PhysicalChannel);
    HRESULT get_TSID(int* TSID);
    HRESULT put_TSID(int TSID);
}

@GUID("612AA885-66CF-4090-BA0A-566F5312E4CA")
interface IATSCLocator2 : IATSCLocator
{
    HRESULT get_ProgramNumber(int* ProgramNumber);
    HRESULT put_ProgramNumber(int ProgramNumber);
}

@GUID("48F66A11-171A-419A-9525-BEEECD51584C")
interface IDigitalCableLocator : IATSCLocator2
{
}

@GUID("8664DA16-DDA2-42AC-926A-C18F9127C302")
interface IDVBTLocator : IDigitalLocator
{
    HRESULT get_Bandwidth(int* BandWidthVal);
    HRESULT put_Bandwidth(int BandwidthVal);
    HRESULT get_LPInnerFEC(FECMethod* FEC);
    HRESULT put_LPInnerFEC(FECMethod FEC);
    HRESULT get_LPInnerFECRate(BinaryConvolutionCodeRate* FEC);
    HRESULT put_LPInnerFECRate(BinaryConvolutionCodeRate FEC);
    HRESULT get_HAlpha(HierarchyAlpha* Alpha);
    HRESULT put_HAlpha(HierarchyAlpha Alpha);
    HRESULT get_Guard(GuardInterval* GI);
    HRESULT put_Guard(GuardInterval GI);
    HRESULT get_Mode(TransmissionMode* mode);
    HRESULT put_Mode(TransmissionMode mode);
    HRESULT get_OtherFrequencyInUse(short* OtherFrequencyInUseVal);
    HRESULT put_OtherFrequencyInUse(short OtherFrequencyInUseVal);
}

@GUID("448A2EDF-AE95-4B43-A3CC-747843C453D4")
interface IDVBTLocator2 : IDVBTLocator
{
    HRESULT get_PhysicalLayerPipeId(int* PhysicalLayerPipeIdVal);
    HRESULT put_PhysicalLayerPipeId(int PhysicalLayerPipeIdVal);
}

@GUID("3D7C353C-0D04-45F1-A742-F97CC1188DC8")
interface IDVBSLocator : IDigitalLocator
{
    HRESULT get_SignalPolarisation(Polarisation* PolarisationVal);
    HRESULT put_SignalPolarisation(Polarisation PolarisationVal);
    HRESULT get_WestPosition(short* WestLongitude);
    HRESULT put_WestPosition(short WestLongitude);
    HRESULT get_OrbitalPosition(int* longitude);
    HRESULT put_OrbitalPosition(int longitude);
    HRESULT get_Azimuth(int* Azimuth);
    HRESULT put_Azimuth(int Azimuth);
    HRESULT get_Elevation(int* Elevation);
    HRESULT put_Elevation(int Elevation);
}

@GUID("6044634A-1733-4F99-B982-5FB12AFCE4F0")
interface IDVBSLocator2 : IDVBSLocator
{
    HRESULT get_DiseqLNBSource(LNB_Source* DiseqLNBSourceVal);
    HRESULT put_DiseqLNBSource(LNB_Source DiseqLNBSourceVal);
    HRESULT get_LocalOscillatorOverrideLow(int* LocalOscillatorOverrideLowVal);
    HRESULT put_LocalOscillatorOverrideLow(int LocalOscillatorOverrideLowVal);
    HRESULT get_LocalOscillatorOverrideHigh(int* LocalOscillatorOverrideHighVal);
    HRESULT put_LocalOscillatorOverrideHigh(int LocalOscillatorOverrideHighVal);
    HRESULT get_LocalLNBSwitchOverride(int* LocalLNBSwitchOverrideVal);
    HRESULT put_LocalLNBSwitchOverride(int LocalLNBSwitchOverrideVal);
    HRESULT get_LocalSpectralInversionOverride(SpectralInversion* LocalSpectralInversionOverrideVal);
    HRESULT put_LocalSpectralInversionOverride(SpectralInversion LocalSpectralInversionOverrideVal);
    HRESULT get_SignalRollOff(RollOff* RollOffVal);
    HRESULT put_SignalRollOff(RollOff RollOffVal);
    HRESULT get_SignalPilot(Pilot* PilotVal);
    HRESULT put_SignalPilot(Pilot PilotVal);
}

@GUID("6E42F36E-1DD2-43C4-9F78-69D25AE39034")
interface IDVBCLocator : IDigitalLocator
{
}

@GUID("C9897087-E29C-473F-9E4B-7072123DEA14")
interface IISDBSLocator : IDVBSLocator
{
}

@GUID("BA4B6526-1A35-4635-8B56-3EC612746A8C")
interface IESOpenMmiEvent : IESEvent
{
    HRESULT GetDialogNumber(uint* pDialogRequest, uint* pDialogNumber);
    HRESULT GetDialogType(GUID* guidDialogType);
    HRESULT GetDialogData(SAFEARRAY** pbData);
    HRESULT GetDialogStringData(BSTR* pbstrBaseUrl, BSTR* pbstrData);
}

@GUID("6B80E96F-55E2-45AA-B754-0C23C8E7D5C1")
interface IESCloseMmiEvent : IESEvent
{
    HRESULT GetDialogNumber(uint* pDialogNumber);
}

@GUID("8A24C46E-BB63-4664-8602-5D9C718C146D")
interface IESValueUpdatedEvent : IESEvent
{
    HRESULT GetValueNames(SAFEARRAY** pbstrNames);
}

@GUID("54C7A5E8-C3BB-4F51-AF14-E0E2C0E34C6D")
interface IESRequestTunerEvent : IESEvent
{
    HRESULT GetPriority(ubyte* pbyPriority);
    HRESULT GetReason(ubyte* pbyReason);
    HRESULT GetConsequences(ubyte* pbyConsequences);
    HRESULT GetEstimatedTime(uint* pdwEstimatedTime);
}

@GUID("2017CB03-DC0F-4C24-83CA-36307B2CD19F")
interface IESIsdbCasResponseEvent : IESEvent
{
    HRESULT GetRequestId(uint* pRequestId);
    HRESULT GetStatus(uint* pStatus);
    HRESULT GetDataLength(uint* pRequestLength);
    HRESULT GetResponseData(SAFEARRAY** pbData);
}

@GUID("907E0B5C-E42D-4F04-91F0-26F401F36907")
interface IGpnvsCommonBase : IUnknown
{
    HRESULT GetValueUpdateName(BSTR* pbstrName);
}

@GUID("506A09B8-7F86-4E04-AC05-3303BFE8FC49")
interface IESEventFactory : IUnknown
{
    HRESULT CreateESEvent(IUnknown pServiceProvider, uint dwEventId, GUID guidEventType, uint dwEventDataLength, 
                          char* pEventData, BSTR bstrBaseUrl, IUnknown pInitContext, IESEvent* ppESEvent);
}

@GUID("D5A48EF5-A81B-4DF0-ACAA-5E35E7EA45D4")
interface IESLicenseRenewalResultEvent : IESEvent
{
    HRESULT GetCallersId(uint* pdwCallersId);
    HRESULT GetFileName(BSTR* pbstrFilename);
    HRESULT IsRenewalSuccessful(int* pfRenewalSuccessful);
    HRESULT IsCheckEntitlementCallRequired(int* pfCheckEntTokenCallNeeded);
    HRESULT GetDescrambledStatus(uint* pDescrambledStatus);
    HRESULT GetRenewalResultCode(uint* pdwRenewalResultCode);
    HRESULT GetCASFailureCode(uint* pdwCASFailureCode);
    HRESULT GetRenewalHResult(int* phr);
    HRESULT GetEntitlementTokenLength(uint* pdwLength);
    HRESULT GetEntitlementToken(SAFEARRAY** pbData);
    HRESULT GetExpiryDate(ulong* pqwExpiryDate);
}

@GUID("BA9EDCB6-4D36-4CFE-8C56-87A6B0CA48E1")
interface IESFileExpiryDateEvent : IESEvent
{
    HRESULT GetTunerId(GUID* pguidTunerId);
    HRESULT GetExpiryDate(ulong* pqwExpiryDate);
    HRESULT GetFinalExpiryDate(ulong* pqwExpiryDate);
    HRESULT GetMaxRenewalCount(uint* dwMaxRenewalCount);
    HRESULT IsEntitlementTokenPresent(int* pfEntTokenPresent);
    HRESULT DoesExpireAfterFirstUse(int* pfExpireAfterFirstUse);
}

@GUID("ED89A619-4C06-4B2F-99EB-C7669B13047C")
interface IESEventService : IUnknown
{
    HRESULT FireESEvent(IESEvent pESEvent);
}

@GUID("33B9DAAE-9309-491D-A051-BCAD2A70CD66")
interface IESEventServiceConfiguration : IUnknown
{
    HRESULT SetParent(IESEventService pEventService);
    HRESULT RemoveParent();
    HRESULT SetOwner(IESEvents pESEvents);
    HRESULT RemoveOwner();
    HRESULT SetGraph(IFilterGraph pGraph);
    HRESULT RemoveGraph(IFilterGraph pGraph);
}

@GUID("359B3901-572C-4854-BB49-CDEF66606A25")
interface IRegisterTuner : IUnknown
{
    HRESULT Register(ITuner pTuner, IGraphBuilder pGraph);
    HRESULT Unregister();
}

@GUID("B34505E0-2F0E-497B-80BC-D43F3B24ED7F")
interface IBDAComparable : IUnknown
{
    HRESULT CompareExact(IDispatch CompareTo, int* Result);
    HRESULT CompareEquivalent(IDispatch CompareTo, uint dwFlags, int* Result);
    HRESULT HashExact(long* Result);
    HRESULT HashExactIncremental(long PartialResult, long* Result);
    HRESULT HashEquivalent(uint dwFlags, long* Result);
    HRESULT HashEquivalentIncremental(long PartialResult, uint dwFlags, long* Result);
}

@GUID("0754CD31-8D15-47A9-8215-D20064157244")
interface IPersistTuneXml : IPersist
{
    HRESULT InitNew();
    HRESULT Load(VARIANT varValue);
    HRESULT Save(VARIANT* pvarFragment);
}

@GUID("990237AE-AC11-4614-BE8F-DD217A4CB4CB")
interface IPersistTuneXmlUtility : IUnknown
{
    HRESULT Deserialize(VARIANT varValue, IUnknown* ppObject);
}

@GUID("992E165F-EA24-4B2F-9A1D-009D92120451")
interface IPersistTuneXmlUtility2 : IPersistTuneXmlUtility
{
    HRESULT Serialize(ITuneRequest piTuneRequest, BSTR* pString);
}

@GUID("C0A4A1D4-2B3C-491A-BA22-499FBADD4D12")
interface IBDACreateTuneRequestEx : IUnknown
{
    HRESULT CreateTuneRequestEx(const(GUID)* TuneRequestIID, ITuneRequest* TuneRequest);
}

@GUID("C4C4C4D1-0049-4E2B-98FB-9537F6CE516D")
interface IETFilterConfig : IUnknown
{
    HRESULT InitLicense(int LicenseId);
    HRESULT GetSecureChannelObject(IUnknown* ppUnkDRMSecureChannel);
}

@GUID("C4C4C4D2-0049-4E2B-98FB-9537F6CE516D")
interface IDTFilterConfig : IUnknown
{
    HRESULT GetSecureChannelObject(IUnknown* ppUnkDRMSecureChannel);
}

@GUID("C4C4C4D3-0049-4E2B-98FB-9537F6CE516D")
interface IXDSCodecConfig : IUnknown
{
    HRESULT GetSecureChannelObject(IUnknown* ppUnkDRMSecureChannel);
    HRESULT SetPauseBufferTime(uint dwPauseBufferTime);
}

@GUID("8A78B317-E405-4A43-994A-620D8F5CE25E")
interface IDTFilterLicenseRenewal : IUnknown
{
    HRESULT GetLicenseRenewalData(ushort** ppwszFileName, ushort** ppwszExpiredKid, ushort** ppwszTunerId);
}

@GUID("26D836A5-0C15-44C7-AC59-B0DA8728F240")
interface IPTFilterLicenseRenewal : IUnknown
{
    HRESULT RenewLicenses(ushort* wszFileName, ushort* wszExpiredKid, uint dwCallersId, BOOL bHighPriority);
    HRESULT CancelLicenseRenewal();
}

@GUID("5A86B91A-E71E-46C1-88A9-9BB338710552")
interface IMceBurnerControl : IUnknown
{
    HRESULT GetBurnerNoDecryption();
}

@GUID("C4C4C4B1-0049-4E2B-98FB-9537F6CE516D")
interface IETFilter : IUnknown
{
    HRESULT get_EvalRatObjOK(int* pHrCoCreateRetVal);
    HRESULT GetCurrRating(EnTvRat_System* pEnSystem, EnTvRat_GenericLevel* pEnRating, int* plbfEnAttr);
    HRESULT GetCurrLicenseExpDate(ProtType* protType, int* lpDateTime);
    HRESULT GetLastErrorCode();
    HRESULT SetRecordingOn(BOOL fRecState);
}

@GUID("C4C4C4C1-0049-4E2B-98FB-9537F6CE516D")
interface IETFilterEvents : IDispatch
{
}

@GUID("C4C4C4B2-0049-4E2B-98FB-9537F6CE516D")
interface IDTFilter : IUnknown
{
    HRESULT get_EvalRatObjOK(int* pHrCoCreateRetVal);
    HRESULT GetCurrRating(EnTvRat_System* pEnSystem, EnTvRat_GenericLevel* pEnRating, int* plbfEnAttr);
    HRESULT get_BlockedRatingAttributes(EnTvRat_System enSystem, EnTvRat_GenericLevel enLevel, int* plbfEnAttr);
    HRESULT put_BlockedRatingAttributes(EnTvRat_System enSystem, EnTvRat_GenericLevel enLevel, int lbfAttrs);
    HRESULT get_BlockUnRated(int* pfBlockUnRatedShows);
    HRESULT put_BlockUnRated(BOOL fBlockUnRatedShows);
    HRESULT get_BlockUnRatedDelay(int* pmsecsDelayBeforeBlock);
    HRESULT put_BlockUnRatedDelay(int msecsDelayBeforeBlock);
}

@GUID("C4C4C4B4-0049-4E2B-98FB-9537F6CE516D")
interface IDTFilter2 : IDTFilter
{
    HRESULT get_ChallengeUrl(BSTR* pbstrChallengeUrl);
    HRESULT GetCurrLicenseExpDate(ProtType* protType, int* lpDateTime);
    HRESULT GetLastErrorCode();
}

@GUID("513998CC-E929-4CDF-9FBD-BAD1E0314866")
interface IDTFilter3 : IDTFilter2
{
    HRESULT GetProtectionType(ProtType* pProtectionType);
    HRESULT LicenseHasExpirationDate(int* pfLicenseHasExpirationDate);
    HRESULT SetRights(BSTR bstrRights);
}

@GUID("C4C4C4C2-0049-4E2B-98FB-9537F6CE516D")
interface IDTFilterEvents : IDispatch
{
}

@GUID("C4C4C4B3-0049-4E2B-98FB-9537F6CE516D")
interface IXDSCodec : IUnknown
{
    HRESULT get_XDSToRatObjOK(int* pHrCoCreateRetVal);
    HRESULT put_CCSubstreamService(int SubstreamMask);
    HRESULT get_CCSubstreamService(int* pSubstreamMask);
    HRESULT GetContentAdvisoryRating(int* pRat, int* pPktSeqID, int* pCallSeqID, long* pTimeStart, long* pTimeEnd);
    HRESULT GetXDSPacket(int* pXDSClassPkt, int* pXDSTypePkt, BSTR* pBstrXDSPkt, int* pPktSeqID, int* pCallSeqID, 
                         long* pTimeStart, long* pTimeEnd);
    HRESULT GetCurrLicenseExpDate(ProtType* protType, int* lpDateTime);
    HRESULT GetLastErrorCode();
}

@GUID("C4C4C4C3-0049-4E2B-98FB-9537F6CE516D")
interface IXDSCodecEvents : IDispatch
{
}

@GUID("C5C5C5B0-3ABC-11D6-B25B-00C04FA0C026")
interface IXDSToRat : IDispatch
{
    HRESULT Init();
    HRESULT ParseXDSBytePair(ubyte byte1, ubyte byte2, EnTvRat_System* pEnSystem, EnTvRat_GenericLevel* pEnLevel, 
                             int* plBfEnAttributes);
}

@GUID("C5C5C5B1-3ABC-11D6-B25B-00C04FA0C026")
interface IEvalRat : IDispatch
{
    HRESULT get_BlockedRatingAttributes(EnTvRat_System enSystem, EnTvRat_GenericLevel enLevel, int* plbfAttrs);
    HRESULT put_BlockedRatingAttributes(EnTvRat_System enSystem, EnTvRat_GenericLevel enLevel, int lbfAttrs);
    HRESULT get_BlockUnRated(int* pfBlockUnRatedShows);
    HRESULT put_BlockUnRated(BOOL fBlockUnRatedShows);
    HRESULT MostRestrictiveRating(EnTvRat_System enSystem1, EnTvRat_GenericLevel enEnLevel1, int lbfEnAttr1, 
                                  EnTvRat_System enSystem2, EnTvRat_GenericLevel enEnLevel2, int lbfEnAttr2, 
                                  EnTvRat_System* penSystem, EnTvRat_GenericLevel* penEnLevel, int* plbfEnAttr);
    HRESULT TestRating(EnTvRat_System enShowSystem, EnTvRat_GenericLevel enShowLevel, int lbfEnShowAttributes);
}

@GUID("7F5000A6-A440-47CA-8ACC-C0E75531A2C2")
interface IMSVidRect : IDispatch
{
    HRESULT get_Top(int* TopVal);
    HRESULT put_Top(int TopVal);
    HRESULT get_Left(int* LeftVal);
    HRESULT put_Left(int LeftVal);
    HRESULT get_Width(int* WidthVal);
    HRESULT put_Width(int WidthVal);
    HRESULT get_Height(int* HeightVal);
    HRESULT put_Height(int HeightVal);
    HRESULT get_HWnd(HWND* HWndVal);
    HRESULT put_HWnd(HWND HWndVal);
    HRESULT put_Rect(IMSVidRect RectVal);
}

@GUID("3DD2903D-E0AA-11D2-B63A-00C04F79498E")
interface IMSVidGraphSegmentContainer : IUnknown
{
    HRESULT get_Graph(IGraphBuilder* ppGraph);
    HRESULT get_Input(IMSVidGraphSegment* ppInput);
    HRESULT get_Outputs(IEnumMSVidGraphSegment* ppOutputs);
    HRESULT get_VideoRenderer(IMSVidGraphSegment* ppVR);
    HRESULT get_AudioRenderer(IMSVidGraphSegment* ppAR);
    HRESULT get_Features(IEnumMSVidGraphSegment* ppFeatures);
    HRESULT get_Composites(IEnumMSVidGraphSegment* ppComposites);
    HRESULT get_ParentContainer(IUnknown* ppContainer);
    HRESULT Decompose(IMSVidGraphSegment pSegment);
    HRESULT IsWindowless();
    HRESULT GetFocus();
}

@GUID("238DEC54-ADEB-4005-A349-F772B9AFEBC4")
interface IMSVidGraphSegment : IPersist
{
    HRESULT get_Init(IUnknown* pInit);
    HRESULT put_Init(IUnknown pInit);
    HRESULT EnumFilters(IEnumFilters* pNewEnum);
    HRESULT get_Container(IMSVidGraphSegmentContainer* ppCtl);
    HRESULT put_Container(IMSVidGraphSegmentContainer pCtl);
    HRESULT get_Type(MSVidSegmentType* pType);
    HRESULT get_Category(GUID* pGuid);
    HRESULT Build();
    HRESULT PostBuild();
    HRESULT PreRun();
    HRESULT PostRun();
    HRESULT PreStop();
    HRESULT PostStop();
    HRESULT OnEventNotify(int lEventCode, ptrdiff_t lEventParm1, ptrdiff_t lEventParm2);
    HRESULT Decompose();
}

@GUID("301C060E-20D9-4587-9B03-F82ED9A9943C")
interface IMSVidGraphSegmentUserInput : IUnknown
{
    HRESULT Click();
    HRESULT DblClick();
    HRESULT KeyDown(short* KeyCode, short ShiftState);
    HRESULT KeyPress(short* KeyAscii);
    HRESULT KeyUp(short* KeyCode, short ShiftState);
    HRESULT MouseDown(short ButtonState, short ShiftState, int x, int y);
    HRESULT MouseMove(short ButtonState, short ShiftState, int x, int y);
    HRESULT MouseUp(short ButtonState, short ShiftState, int x, int y);
}

@GUID("1C15D483-911D-11D2-B632-00C04F79498E")
interface IMSVidCompositionSegment : IMSVidGraphSegment
{
    HRESULT Compose(IMSVidGraphSegment upstream, IMSVidGraphSegment downstream);
    HRESULT get_Up(IMSVidGraphSegment* upstream);
    HRESULT get_Down(IMSVidGraphSegment* downstream);
}

@GUID("3DD2903E-E0AA-11D2-B63A-00C04F79498E")
interface IEnumMSVidGraphSegment : IUnknown
{
    HRESULT Next(uint celt, IMSVidGraphSegment* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumMSVidGraphSegment* ppenum);
}

@GUID("DD47DE3F-9874-4F7B-8B22-7CB2688461E7")
interface IMSVidVRGraphSegment : IMSVidGraphSegment
{
    HRESULT put__VMRendererMode(int dwMode);
    HRESULT put_Owner(HWND Window);
    HRESULT get_Owner(HWND* Window);
    HRESULT get_UseOverlay(short* UseOverlayVal);
    HRESULT put_UseOverlay(short UseOverlayVal);
    HRESULT get_Visible(short* Visible);
    HRESULT put_Visible(short Visible);
    HRESULT get_ColorKey(uint* ColorKey);
    HRESULT put_ColorKey(uint ColorKey);
    HRESULT get_Source(RECT* r);
    HRESULT put_Source(RECT r);
    HRESULT get_Destination(RECT* r);
    HRESULT put_Destination(RECT r);
    HRESULT get_NativeSize(SIZE* sizeval, SIZE* aspectratio);
    HRESULT get_BorderColor(uint* color);
    HRESULT put_BorderColor(uint color);
    HRESULT get_MaintainAspectRatio(short* fMaintain);
    HRESULT put_MaintainAspectRatio(short fMaintain);
    HRESULT Refresh();
    HRESULT DisplayChange();
    HRESULT RePaint(HDC hdc);
}

@GUID("1C15D47C-911D-11D2-B632-00C04F79498E")
interface IMSVidDevice : IDispatch
{
    HRESULT get_Name(BSTR* Name);
    HRESULT get_Status(int* Status);
    HRESULT put_Power(short Power);
    HRESULT get_Power(short* Power);
    HRESULT get_Category(BSTR* Guid);
    HRESULT get_ClassID(BSTR* Clsid);
    HRESULT get__Category(GUID* Guid);
    HRESULT get__ClassID(GUID* Clsid);
    HRESULT IsEqualDevice(IMSVidDevice Device, short* IsEqual);
}

@GUID("87BD2783-EBC0-478C-B4A0-E8E7F43AB78E")
interface IMSVidDevice2 : IUnknown
{
    HRESULT get_DevicePath(BSTR* DevPath);
}

@GUID("37B0353D-A4C8-11D2-B634-00C04F79498E")
interface IMSVidInputDevice : IMSVidDevice
{
    HRESULT IsViewable(VARIANT* v, short* pfViewable);
    HRESULT View(VARIANT* v);
}

@GUID("1C15D480-911D-11D2-B632-00C04F79498E")
interface IMSVidDeviceEvent : IDispatch
{
    HRESULT StateChange(IMSVidDevice lpd, int oldState, int newState);
}

@GUID("37B0353E-A4C8-11D2-B634-00C04F79498E")
interface IMSVidInputDeviceEvent : IDispatch
{
}

@GUID("1C15D47F-911D-11D2-B632-00C04F79498E")
interface IMSVidVideoInputDevice : IMSVidInputDevice
{
}

@GUID("37B03538-A4C8-11D2-B634-00C04F79498E")
interface IMSVidPlayback : IMSVidInputDevice
{
    HRESULT get_EnableResetOnStop(short* pVal);
    HRESULT put_EnableResetOnStop(short newVal);
    HRESULT Run();
    HRESULT Pause();
    HRESULT Stop();
    HRESULT get_CanStep(short fBackwards, short* pfCan);
    HRESULT Step(int lStep);
    HRESULT put_Rate(double plRate);
    HRESULT get_Rate(double* plRate);
    HRESULT put_CurrentPosition(int lPosition);
    HRESULT get_CurrentPosition(int* lPosition);
    HRESULT put_PositionMode(PositionModeList lPositionMode);
    HRESULT get_PositionMode(PositionModeList* lPositionMode);
    HRESULT get_Length(int* lLength);
}

@GUID("37B0353B-A4C8-11D2-B634-00C04F79498E")
interface IMSVidPlaybackEvent : IMSVidInputDeviceEvent
{
    HRESULT EndOfMedia(IMSVidPlayback lpd);
}

@GUID("1C15D47D-911D-11D2-B632-00C04F79498E")
interface IMSVidTuner : IMSVidVideoInputDevice
{
    HRESULT get_Tune(ITuneRequest* ppTR);
    HRESULT put_Tune(ITuneRequest pTR);
    HRESULT get_TuningSpace(ITuningSpace* plTS);
    HRESULT put_TuningSpace(ITuningSpace plTS);
}

@GUID("1C15D485-911D-11D2-B632-00C04F79498E")
interface IMSVidTunerEvent : IMSVidInputDeviceEvent
{
    HRESULT TuneChanged(IMSVidTuner lpd);
}

@GUID("1C15D47E-911D-11D2-B632-00C04F79498E")
interface IMSVidAnalogTuner : IMSVidTuner
{
    HRESULT get_Channel(int* Channel);
    HRESULT put_Channel(int Channel);
    HRESULT get_VideoFrequency(int* lcc);
    HRESULT get_AudioFrequency(int* lcc);
    HRESULT get_CountryCode(int* lcc);
    HRESULT put_CountryCode(int lcc);
    HRESULT get_SAP(short* pfSapOn);
    HRESULT put_SAP(short fSapOn);
    HRESULT ChannelAvailable(int nChannel, int* SignalStrength, short* fSignalPresent);
}

@GUID("37647BF7-3DDE-4CC8-A4DC-0D534D3D0037")
interface IMSVidAnalogTuner2 : IMSVidAnalogTuner
{
    HRESULT get_TVFormats(int* Formats);
    HRESULT get_TunerModes(int* Modes);
    HRESULT get_NumAuxInputs(int* Inputs);
}

@GUID("1C15D486-911D-11D2-B632-00C04F79498E")
interface IMSVidAnalogTunerEvent : IMSVidTunerEvent
{
}

@GUID("37B03539-A4C8-11D2-B634-00C04F79498E")
interface IMSVidFilePlayback : IMSVidPlayback
{
    HRESULT get_FileName(BSTR* FileName);
    HRESULT put_FileName(BSTR FileName);
}

@GUID("2F7E44AF-6E52-4660-BC08-D8D542587D72")
interface IMSVidFilePlayback2 : IMSVidFilePlayback
{
    HRESULT put__SourceFilter(BSTR FileName);
    HRESULT put___SourceFilter(GUID FileName);
}

@GUID("37B0353A-A4C8-11D2-B634-00C04F79498E")
interface IMSVidFilePlaybackEvent : IMSVidPlaybackEvent
{
}

@GUID("CF45F88B-AC56-4EE2-A73A-ED04E2885D3C")
interface IMSVidWebDVD : IMSVidPlayback
{
    HRESULT OnDVDEvent(int lEvent, ptrdiff_t lParam1, ptrdiff_t lParam2);
    HRESULT PlayTitle(int lTitle);
    HRESULT PlayChapterInTitle(int lTitle, int lChapter);
    HRESULT PlayChapter(int lChapter);
    HRESULT PlayChaptersAutoStop(int lTitle, int lstrChapter, int lChapterCount);
    HRESULT PlayAtTime(BSTR strTime);
    HRESULT PlayAtTimeInTitle(int lTitle, BSTR strTime);
    HRESULT PlayPeriodInTitleAutoStop(int lTitle, BSTR strStartTime, BSTR strEndTime);
    HRESULT ReplayChapter();
    HRESULT PlayPrevChapter();
    HRESULT PlayNextChapter();
    HRESULT StillOff();
    HRESULT get_AudioLanguage(int lStream, short fFormat, BSTR* strAudioLang);
    HRESULT ShowMenu(DVDMenuIDConstants MenuID);
    HRESULT Resume();
    HRESULT ReturnFromSubmenu();
    HRESULT get_ButtonsAvailable(int* pVal);
    HRESULT get_CurrentButton(int* pVal);
    HRESULT SelectAndActivateButton(int lButton);
    HRESULT ActivateButton();
    HRESULT SelectRightButton();
    HRESULT SelectLeftButton();
    HRESULT SelectLowerButton();
    HRESULT SelectUpperButton();
    HRESULT ActivateAtPosition(int xPos, int yPos);
    HRESULT SelectAtPosition(int xPos, int yPos);
    HRESULT get_ButtonAtPosition(int xPos, int yPos, int* plButton);
    HRESULT get_NumberOfChapters(int lTitle, int* pVal);
    HRESULT get_TotalTitleTime(BSTR* pVal);
    HRESULT get_TitlesAvailable(int* pVal);
    HRESULT get_VolumesAvailable(int* pVal);
    HRESULT get_CurrentVolume(int* pVal);
    HRESULT get_CurrentDiscSide(int* pVal);
    HRESULT get_CurrentDomain(int* pVal);
    HRESULT get_CurrentChapter(int* pVal);
    HRESULT get_CurrentTitle(int* pVal);
    HRESULT get_CurrentTime(BSTR* pVal);
    HRESULT DVDTimeCode2bstr(int timeCode, BSTR* pTimeStr);
    HRESULT get_DVDDirectory(BSTR* pVal);
    HRESULT put_DVDDirectory(BSTR newVal);
    HRESULT IsSubpictureStreamEnabled(int lstream, short* fEnabled);
    HRESULT IsAudioStreamEnabled(int lstream, short* fEnabled);
    HRESULT get_CurrentSubpictureStream(int* pVal);
    HRESULT put_CurrentSubpictureStream(int newVal);
    HRESULT get_SubpictureLanguage(int lStream, BSTR* strLanguage);
    HRESULT get_CurrentAudioStream(int* pVal);
    HRESULT put_CurrentAudioStream(int newVal);
    HRESULT get_AudioStreamsAvailable(int* pVal);
    HRESULT get_AnglesAvailable(int* pVal);
    HRESULT get_CurrentAngle(int* pVal);
    HRESULT put_CurrentAngle(int newVal);
    HRESULT get_SubpictureStreamsAvailable(int* pVal);
    HRESULT get_SubpictureOn(short* pVal);
    HRESULT put_SubpictureOn(short newVal);
    HRESULT get_DVDUniqueID(BSTR* pVal);
    HRESULT AcceptParentalLevelChange(short fAccept, BSTR strUserName, BSTR strPassword);
    HRESULT NotifyParentalLevelChange(short newVal);
    HRESULT SelectParentalCountry(int lCountry, BSTR strUserName, BSTR strPassword);
    HRESULT SelectParentalLevel(int lParentalLevel, BSTR strUserName, BSTR strPassword);
    HRESULT get_TitleParentalLevels(int lTitle, int* plParentalLevels);
    HRESULT get_PlayerParentalCountry(int* plCountryCode);
    HRESULT get_PlayerParentalLevel(int* plParentalLevel);
    HRESULT Eject();
    HRESULT UOPValid(int lUOP, short* pfValid);
    HRESULT get_SPRM(int lIndex, short* psSPRM);
    HRESULT get_GPRM(int lIndex, short* psSPRM);
    HRESULT put_GPRM(int lIndex, short sValue);
    HRESULT get_DVDTextStringType(int lLangIndex, int lStringIndex, DVDTextStringType* pType);
    HRESULT get_DVDTextString(int lLangIndex, int lStringIndex, BSTR* pstrText);
    HRESULT get_DVDTextNumberOfStrings(int lLangIndex, int* plNumOfStrings);
    HRESULT get_DVDTextNumberOfLanguages(int* plNumOfLangs);
    HRESULT get_DVDTextLanguageLCID(int lLangIndex, int* lcid);
    HRESULT RegionChange();
    HRESULT get_DVDAdm(IDispatch* pVal);
    HRESULT DeleteBookmark();
    HRESULT RestoreBookmark();
    HRESULT SaveBookmark();
    HRESULT SelectDefaultAudioLanguage(int lang, int ext);
    HRESULT SelectDefaultSubpictureLanguage(int lang, DVDSPExt ext);
    HRESULT get_PreferredSubpictureStream(int* pVal);
    HRESULT get_DefaultMenuLanguage(int* lang);
    HRESULT put_DefaultMenuLanguage(int lang);
    HRESULT get_DefaultSubpictureLanguage(int* lang);
    HRESULT get_DefaultAudioLanguage(int* lang);
    HRESULT get_DefaultSubpictureLanguageExt(DVDSPExt* ext);
    HRESULT get_DefaultAudioLanguageExt(int* ext);
    HRESULT get_LanguageFromLCID(int lcid, BSTR* lang);
    HRESULT get_KaraokeAudioPresentationMode(int* pVal);
    HRESULT put_KaraokeAudioPresentationMode(int newVal);
    HRESULT get_KaraokeChannelContent(int lStream, int lChan, int* lContent);
    HRESULT get_KaraokeChannelAssignment(int lStream, int* lChannelAssignment);
    HRESULT RestorePreferredSettings();
    HRESULT get_ButtonRect(int lButton, IMSVidRect* pRect);
    HRESULT get_DVDScreenInMouseCoordinates(IMSVidRect* ppRect);
    HRESULT put_DVDScreenInMouseCoordinates(IMSVidRect pRect);
}

@GUID("7027212F-EE9A-4A7C-8B67-F023714CDAFF")
interface IMSVidWebDVD2 : IMSVidWebDVD
{
    HRESULT get_Bookmark(char* ppData, uint* pDataLength);
    HRESULT put_Bookmark(ubyte* pData, uint dwDataLength);
}

@GUID("B4F7A674-9B83-49CB-A357-C63B871BE958")
interface IMSVidWebDVDEvent : IMSVidPlaybackEvent
{
    HRESULT DVDNotify(int lEventCode, VARIANT lParam1, VARIANT lParam2);
    HRESULT PlayForwards(short bEnabled);
    HRESULT PlayBackwards(short bEnabled);
    HRESULT ShowMenu(DVDMenuIDConstants MenuID, short bEnabled);
    HRESULT Resume(short bEnabled);
    HRESULT SelectOrActivateButton(short bEnabled);
    HRESULT StillOff(short bEnabled);
    HRESULT PauseOn(short bEnabled);
    HRESULT ChangeCurrentAudioStream(short bEnabled);
    HRESULT ChangeCurrentSubpictureStream(short bEnabled);
    HRESULT ChangeCurrentAngle(short bEnabled);
    HRESULT PlayAtTimeInTitle(short bEnabled);
    HRESULT PlayAtTime(short bEnabled);
    HRESULT PlayChapterInTitle(short bEnabled);
    HRESULT PlayChapter(short bEnabled);
    HRESULT ReplayChapter(short bEnabled);
    HRESULT PlayNextChapter(short bEnabled);
    HRESULT Stop(short bEnabled);
    HRESULT ReturnFromSubmenu(short bEnabled);
    HRESULT PlayTitle(short bEnabled);
    HRESULT PlayPrevChapter(short bEnabled);
    HRESULT ChangeKaraokePresMode(short bEnabled);
    HRESULT ChangeVideoPresMode(short bEnabled);
}

@GUID("B8BE681A-EB2C-47F0-B415-94D5452F0E05")
interface IMSVidWebDVDAdm : IDispatch
{
    HRESULT ChangePassword(BSTR strUserName, BSTR strOld, BSTR strNew);
    HRESULT SaveParentalLevel(int level, BSTR strUserName, BSTR strPassword);
    HRESULT SaveParentalCountry(int country, BSTR strUserName, BSTR strPassword);
    HRESULT ConfirmPassword(BSTR strUserName, BSTR strPassword, short* pVal);
    HRESULT GetParentalLevel(int* lLevel);
    HRESULT GetParentalCountry(int* lCountry);
    HRESULT get_DefaultAudioLCID(int* pVal);
    HRESULT put_DefaultAudioLCID(int newVal);
    HRESULT get_DefaultSubpictureLCID(int* pVal);
    HRESULT put_DefaultSubpictureLCID(int newVal);
    HRESULT get_DefaultMenuLCID(int* pVal);
    HRESULT put_DefaultMenuLCID(int newVal);
    HRESULT get_BookmarkOnStop(short* pVal);
    HRESULT put_BookmarkOnStop(short newVal);
}

@GUID("37B03546-A4C8-11D2-B634-00C04F79498E")
interface IMSVidOutputDevice : IMSVidDevice
{
}

@GUID("2E6A14E2-571C-11D3-B652-00C04F79498E")
interface IMSVidOutputDeviceEvent : IMSVidDeviceEvent
{
}

@GUID("37B03547-A4C8-11D2-B634-00C04F79498E")
interface IMSVidFeature : IMSVidDevice
{
}

@GUID("3DD2903C-E0AA-11D2-B63A-00C04F79498E")
interface IMSVidFeatureEvent : IMSVidDeviceEvent
{
}

@GUID("C0020FD4-BEE7-43D9-A495-9F213117103D")
interface IMSVidEncoder : IMSVidFeature
{
    HRESULT get_VideoEncoderInterface(IUnknown* ppEncInt);
    HRESULT get_AudioEncoderInterface(IUnknown* ppEncInt);
}

@GUID("99652EA1-C1F7-414F-BB7B-1C967DE75983")
interface IMSVidClosedCaptioning : IMSVidFeature
{
    HRESULT get_Enable(short* On);
    HRESULT put_Enable(short On);
}

@GUID("E00CB864-A029-4310-9987-A873F5887D97")
interface IMSVidClosedCaptioning2 : IMSVidClosedCaptioning
{
    HRESULT get_Service(MSVidCCService* On);
    HRESULT put_Service(MSVidCCService On);
}

@GUID("C8638E8A-7625-4C51-9366-2F40A9831FC0")
interface IMSVidClosedCaptioning3 : IMSVidClosedCaptioning2
{
    HRESULT get_TeleTextFilter(IUnknown* punkTTFilter);
}

@GUID("11EBC158-E712-4D1F-8BB3-01ED5274C4CE")
interface IMSVidXDS : IMSVidFeature
{
    HRESULT get_ChannelChangeInterface(IUnknown* punkCC);
}

@GUID("6DB2317D-3B23-41EC-BA4B-701F407EAF3A")
interface IMSVidXDSEvent : IMSVidFeatureEvent
{
    HRESULT RatingChange(EnTvRat_System PrevRatingSystem, EnTvRat_GenericLevel PrevLevel, 
                         BfEnTvRat_GenericAttributes PrevAttributes, EnTvRat_System NewRatingSystem, 
                         EnTvRat_GenericLevel NewLevel, BfEnTvRat_GenericAttributes NewAttributes);
}

@GUID("334125C1-77E5-11D3-B653-00C04F79498E")
interface IMSVidDataServices : IMSVidFeature
{
}

@GUID("334125C2-77E5-11D3-B653-00C04F79498E")
interface IMSVidDataServicesEvent : IMSVidDeviceEvent
{
}

@GUID("37B03540-A4C8-11D2-B634-00C04F79498E")
interface IMSVidVideoRenderer : IMSVidOutputDevice
{
    HRESULT get_CustomCompositorClass(BSTR* CompositorCLSID);
    HRESULT put_CustomCompositorClass(BSTR CompositorCLSID);
    HRESULT get__CustomCompositorClass(GUID* CompositorCLSID);
    HRESULT put__CustomCompositorClass(const(GUID)* CompositorCLSID);
    HRESULT get__CustomCompositor(IVMRImageCompositor* Compositor);
    HRESULT put__CustomCompositor(IVMRImageCompositor Compositor);
    HRESULT get_MixerBitmap(IPictureDisp* MixerPictureDisp);
    HRESULT get__MixerBitmap(IVMRMixerBitmap* MixerPicture);
    HRESULT put_MixerBitmap(IPictureDisp MixerPictureDisp);
    HRESULT put__MixerBitmap(VMRALPHABITMAP* MixerPicture);
    HRESULT get_MixerBitmapPositionRect(IMSVidRect* rDest);
    HRESULT put_MixerBitmapPositionRect(IMSVidRect rDest);
    HRESULT get_MixerBitmapOpacity(int* opacity);
    HRESULT put_MixerBitmapOpacity(int opacity);
    HRESULT SetupMixerBitmap(IPictureDisp MixerPictureDisp, int Opacity, IMSVidRect rDest);
    HRESULT get_SourceSize(SourceSizeList* CurrentSize);
    HRESULT put_SourceSize(SourceSizeList NewSize);
    HRESULT get_OverScan(int* plPercent);
    HRESULT put_OverScan(int lPercent);
    HRESULT get_AvailableSourceRect(IMSVidRect* pRect);
    HRESULT get_MaxVidRect(IMSVidRect* ppVidRect);
    HRESULT get_MinVidRect(IMSVidRect* ppVidRect);
    HRESULT get_ClippedSourceRect(IMSVidRect* pRect);
    HRESULT put_ClippedSourceRect(IMSVidRect pRect);
    HRESULT get_UsingOverlay(short* UseOverlayVal);
    HRESULT put_UsingOverlay(short UseOverlayVal);
    HRESULT Capture(IPictureDisp* currentImage);
    HRESULT get_FramesPerSecond(int* pVal);
    HRESULT get_DecimateInput(short* pDeci);
    HRESULT put_DecimateInput(short pDeci);
}

@GUID("37B03545-A4C8-11D2-B634-00C04F79498E")
interface IMSVidVideoRendererEvent : IMSVidOutputDeviceEvent
{
    HRESULT OverlayUnavailable();
}

@GUID("6C29B41D-455B-4C33-963A-0D28E5E555EA")
interface IMSVidGenericSink : IMSVidOutputDevice
{
    HRESULT SetSinkFilter(BSTR bstrName);
    HRESULT get_SinkStreams(MSVidSinkStreams* pStreams);
    HRESULT put_SinkStreams(MSVidSinkStreams Streams);
}

@GUID("6B5A28F3-47F1-4092-B168-60CABEC08F1C")
interface IMSVidGenericSink2 : IMSVidGenericSink
{
    HRESULT AddFilter(BSTR bstrName);
    HRESULT ResetFilterList();
}

@GUID("160621AA-BBBC-4326-A824-C395AEBC6E74")
interface IMSVidStreamBufferRecordingControl : IDispatch
{
    HRESULT get_StartTime(int* rtStart);
    HRESULT put_StartTime(int rtStart);
    HRESULT get_StopTime(int* rtStop);
    HRESULT put_StopTime(int rtStop);
    HRESULT get_RecordingStopped(short* phResult);
    HRESULT get_RecordingStarted(short* phResult);
    HRESULT get_RecordingType(RecordingType* dwType);
    HRESULT get_RecordingAttribute(IUnknown* pRecordingAttribute);
}

@GUID("159DBB45-CD1B-4DAB-83EA-5CB1F4F21D07")
interface IMSVidStreamBufferSink : IMSVidOutputDevice
{
    HRESULT get_ContentRecorder(BSTR pszFilename, IMSVidStreamBufferRecordingControl* pRecordingIUnknown);
    HRESULT get_ReferenceRecorder(BSTR pszFilename, IMSVidStreamBufferRecordingControl* pRecordingIUnknown);
    HRESULT get_SinkName(BSTR* pName);
    HRESULT put_SinkName(BSTR Name);
    HRESULT NameSetLock();
    HRESULT get_SBESink(IUnknown* sbeConfig);
}

@GUID("2CA9FC63-C131-4E5A-955A-544A47C67146")
interface IMSVidStreamBufferSink2 : IMSVidStreamBufferSink
{
    HRESULT UnlockProfile();
}

@GUID("4F8721D7-7D59-4D8B-99F5-A77775586BD5")
interface IMSVidStreamBufferSink3 : IMSVidStreamBufferSink2
{
    HRESULT SetMinSeek(int* pdwMin);
    HRESULT get_AudioCounter(IUnknown* ppUnk);
    HRESULT get_VideoCounter(IUnknown* ppUnk);
    HRESULT get_CCCounter(IUnknown* ppUnk);
    HRESULT get_WSTCounter(IUnknown* ppUnk);
    HRESULT put_AudioAnalysisFilter(BSTR szCLSID);
    HRESULT get_AudioAnalysisFilter(BSTR* pszCLSID);
    HRESULT put__AudioAnalysisFilter(GUID guid);
    HRESULT get__AudioAnalysisFilter(GUID* pGuid);
    HRESULT put_VideoAnalysisFilter(BSTR szCLSID);
    HRESULT get_VideoAnalysisFilter(BSTR* pszCLSID);
    HRESULT put__VideoAnalysisFilter(GUID guid);
    HRESULT get__VideoAnalysisFilter(GUID* pGuid);
    HRESULT put_DataAnalysisFilter(BSTR szCLSID);
    HRESULT get_DataAnalysisFilter(BSTR* pszCLSID);
    HRESULT put__DataAnalysisFilter(GUID guid);
    HRESULT get__DataAnalysisFilter(GUID* pGuid);
    HRESULT get_LicenseErrorCode(int* hres);
}

@GUID("F798A36B-B05B-4BBE-9703-EAEA7D61CD51")
interface IMSVidStreamBufferSinkEvent : IMSVidOutputDeviceEvent
{
    HRESULT CertificateFailure();
    HRESULT CertificateSuccess();
    HRESULT WriteFailure();
}

@GUID("3D7A5166-72D7-484B-A06F-286187B80CA1")
interface IMSVidStreamBufferSinkEvent2 : IMSVidStreamBufferSinkEvent
{
    HRESULT EncryptionOn();
    HRESULT EncryptionOff();
}

@GUID("735AD8D5-C259-48E9-81E7-D27953665B23")
interface IMSVidStreamBufferSinkEvent3 : IMSVidStreamBufferSinkEvent2
{
    HRESULT LicenseChange(int dwProt);
}

@GUID("1B01DCB0-DAF0-412C-A5D1-590C7F62E2B8")
interface IMSVidStreamBufferSinkEvent4 : IMSVidStreamBufferSinkEvent3
{
    HRESULT WriteFailureClear();
}

@GUID("EB0C8CF9-6950-4772-87B1-47D11CF3A02F")
interface IMSVidStreamBufferSource : IMSVidFilePlayback
{
    HRESULT get_Start(int* lStart);
    HRESULT get_RecordingAttribute(IUnknown* pRecordingAttribute);
    HRESULT CurrentRatings(EnTvRat_System* pEnSystem, EnTvRat_GenericLevel* pEnRating, int* pBfEnAttr);
    HRESULT MaxRatingsLevel(EnTvRat_System enSystem, EnTvRat_GenericLevel enRating, int lbfEnAttr);
    HRESULT put_BlockUnrated(short bBlock);
    HRESULT put_UnratedDelay(int dwDelay);
    HRESULT get_SBESource(IUnknown* sbeFilter);
}

@GUID("E4BA9059-B1CE-40D8-B9A0-D4EA4A9989D3")
interface IMSVidStreamBufferSource2 : IMSVidStreamBufferSource
{
    HRESULT put_RateEx(double dwRate, uint dwFramesPerSecond);
    HRESULT get_AudioCounter(IUnknown* ppUnk);
    HRESULT get_VideoCounter(IUnknown* ppUnk);
    HRESULT get_CCCounter(IUnknown* ppUnk);
    HRESULT get_WSTCounter(IUnknown* ppUnk);
}

@GUID("50CE8A7D-9C28-4DA8-9042-CDFA7116F979")
interface IMSVidStreamBufferSourceEvent : IMSVidFilePlaybackEvent
{
    HRESULT CertificateFailure();
    HRESULT CertificateSuccess();
    HRESULT RatingsBlocked();
    HRESULT RatingsUnblocked();
    HRESULT RatingsChanged();
    HRESULT TimeHole(int StreamOffsetMS, int SizeMS);
    HRESULT StaleDataRead();
    HRESULT ContentBecomingStale();
    HRESULT StaleFileDeleted();
}

@GUID("7AEF50CE-8E22-4BA8-BC06-A92A458B4EF2")
interface IMSVidStreamBufferSourceEvent2 : IMSVidStreamBufferSourceEvent
{
    HRESULT RateChange(double qwNewRate, double qwOldRate);
}

@GUID("CEABD6AB-9B90-4570-ADF1-3CE76E00A763")
interface IMSVidStreamBufferSourceEvent3 : IMSVidStreamBufferSourceEvent2
{
    HRESULT BroadcastEvent(BSTR Guid);
    HRESULT BroadcastEventEx(BSTR Guid, uint Param1, uint Param2, uint Param3, uint Param4);
    HRESULT COPPBlocked();
    HRESULT COPPUnblocked();
    HRESULT ContentPrimarilyAudio();
}

@GUID("49C771F9-41B2-4CF7-9F9A-A313A8F6027E")
interface IMSVidStreamBufferV2SourceEvent : IMSVidFilePlaybackEvent
{
    HRESULT RatingsChanged();
    HRESULT TimeHole(int StreamOffsetMS, int SizeMS);
    HRESULT StaleDataRead();
    HRESULT ContentBecomingStale();
    HRESULT StaleFileDeleted();
    HRESULT RateChange(double qwNewRate, double qwOldRate);
    HRESULT BroadcastEvent(BSTR Guid);
    HRESULT BroadcastEventEx(BSTR Guid, uint Param1, uint Param2, uint Param3, uint Param4);
    HRESULT ContentPrimarilyAudio();
}

@GUID("6BDD5C1E-2810-4159-94BC-05511AE8549B")
interface IMSVidVideoRenderer2 : IMSVidVideoRenderer
{
    HRESULT get_Allocator(IUnknown* AllocPresent);
    HRESULT get__Allocator(IVMRSurfaceAllocator* AllocPresent);
    HRESULT get_Allocator_ID(int* ID);
    HRESULT SetAllocator(IUnknown AllocPresent, int ID);
    HRESULT _SetAllocator2(IVMRSurfaceAllocator AllocPresent, int ID);
    HRESULT put_SuppressEffects(short bSuppress);
    HRESULT get_SuppressEffects(short* bSuppress);
}

@GUID("7145ED66-4730-4FDB-8A53-FDE7508D3E5E")
interface IMSVidVideoRendererEvent2 : IMSVidOutputDeviceEvent
{
    HRESULT OverlayUnavailable();
}

@GUID("D58B0015-EBEF-44BB-BBDD-3F3699D76EA1")
interface IMSVidVMR9 : IMSVidVideoRenderer
{
    HRESULT get_Allocator_ID(int* ID);
    HRESULT SetAllocator(IUnknown AllocPresent, int ID);
    HRESULT put_SuppressEffects(short bSuppress);
    HRESULT get_SuppressEffects(short* bSuppress);
    HRESULT get_Allocator(IUnknown* AllocPresent);
}

@GUID("15E496AE-82A8-4CF9-A6B6-C561DC60398F")
interface IMSVidEVR : IMSVidVideoRenderer
{
    HRESULT get_Presenter(IMFVideoPresenter* ppAllocPresent);
    HRESULT put_Presenter(IMFVideoPresenter pAllocPresent);
    HRESULT put_SuppressEffects(short bSuppress);
    HRESULT get_SuppressEffects(short* bSuppress);
}

@GUID("349ABB10-883C-4F22-8714-CECAEEE45D62")
interface IMSVidEVREvent : IMSVidOutputDeviceEvent
{
    HRESULT OnUserEvent(int lEventCode);
}

@GUID("37B0353F-A4C8-11D2-B634-00C04F79498E")
interface IMSVidAudioRenderer : IMSVidOutputDevice
{
    HRESULT put_Volume(int lVol);
    HRESULT get_Volume(int* lVol);
    HRESULT put_Balance(int lBal);
    HRESULT get_Balance(int* lBal);
}

@GUID("37B03541-A4C8-11D2-B634-00C04F79498E")
interface IMSVidAudioRendererEvent : IMSVidOutputDeviceEvent
{
}

@GUID("E3F55729-353B-4C43-A028-50F79AA9A907")
interface IMSVidAudioRendererEvent2 : IMSVidAudioRendererEvent
{
    HRESULT AVDecAudioDualMono();
    HRESULT AVAudioSampleRate();
    HRESULT AVAudioChannelConfig();
    HRESULT AVAudioChannelCount();
    HRESULT AVDecCommonMeanBitRate();
    HRESULT AVDDSurroundMode();
    HRESULT AVDecCommonInputFormat();
    HRESULT AVDecCommonOutputFormat();
}

@GUID("C5702CD1-9B79-11D3-B654-00C04F79498E")
interface IMSVidInputDevices : IDispatch
{
    HRESULT get_Count(int* lCount);
    HRESULT get__NewEnum(IEnumVARIANT* pD);
    HRESULT get_Item(VARIANT v, IMSVidInputDevice* pDB);
    HRESULT Add(IMSVidInputDevice pDB);
    HRESULT Remove(VARIANT v);
}

@GUID("C5702CD2-9B79-11D3-B654-00C04F79498E")
interface IMSVidOutputDevices : IDispatch
{
    HRESULT get_Count(int* lCount);
    HRESULT get__NewEnum(IEnumVARIANT* pD);
    HRESULT get_Item(VARIANT v, IMSVidOutputDevice* pDB);
    HRESULT Add(IMSVidOutputDevice pDB);
    HRESULT Remove(VARIANT v);
}

@GUID("C5702CD3-9B79-11D3-B654-00C04F79498E")
interface IMSVidVideoRendererDevices : IDispatch
{
    HRESULT get_Count(int* lCount);
    HRESULT get__NewEnum(IEnumVARIANT* pD);
    HRESULT get_Item(VARIANT v, IMSVidVideoRenderer* pDB);
    HRESULT Add(IMSVidVideoRenderer pDB);
    HRESULT Remove(VARIANT v);
}

@GUID("C5702CD4-9B79-11D3-B654-00C04F79498E")
interface IMSVidAudioRendererDevices : IDispatch
{
    HRESULT get_Count(int* lCount);
    HRESULT get__NewEnum(IEnumVARIANT* pD);
    HRESULT get_Item(VARIANT v, IMSVidAudioRenderer* pDB);
    HRESULT Add(IMSVidAudioRenderer pDB);
    HRESULT Remove(VARIANT v);
}

@GUID("C5702CD5-9B79-11D3-B654-00C04F79498E")
interface IMSVidFeatures : IDispatch
{
    HRESULT get_Count(int* lCount);
    HRESULT get__NewEnum(IEnumVARIANT* pD);
    HRESULT get_Item(VARIANT v, IMSVidFeature* pDB);
    HRESULT Add(IMSVidFeature pDB);
    HRESULT Remove(VARIANT v);
}

@GUID("B0EDF162-910A-11D2-B632-00C04F79498E")
interface IMSVidCtl : IDispatch
{
    HRESULT get_AutoSize(short* pbool);
    HRESULT put_AutoSize(short vbool);
    HRESULT get_BackColor(uint* backcolor);
    HRESULT put_BackColor(uint backcolor);
    HRESULT get_Enabled(short* pbool);
    HRESULT put_Enabled(short vbool);
    HRESULT get_TabStop(short* pbool);
    HRESULT put_TabStop(short vbool);
    HRESULT get_Window(HWND* phwnd);
    HRESULT Refresh();
    HRESULT get_DisplaySize(DisplaySizeList* CurrentValue);
    HRESULT put_DisplaySize(DisplaySizeList NewValue);
    HRESULT get_MaintainAspectRatio(short* CurrentValue);
    HRESULT put_MaintainAspectRatio(short NewValue);
    HRESULT get_ColorKey(uint* CurrentValue);
    HRESULT put_ColorKey(uint NewValue);
    HRESULT get_InputsAvailable(BSTR CategoryGuid, IMSVidInputDevices* pVal);
    HRESULT get_OutputsAvailable(BSTR CategoryGuid, IMSVidOutputDevices* pVal);
    HRESULT get__InputsAvailable(GUID* CategoryGuid, IMSVidInputDevices* pVal);
    HRESULT get__OutputsAvailable(GUID* CategoryGuid, IMSVidOutputDevices* pVal);
    HRESULT get_VideoRenderersAvailable(IMSVidVideoRendererDevices* pVal);
    HRESULT get_AudioRenderersAvailable(IMSVidAudioRendererDevices* pVal);
    HRESULT get_FeaturesAvailable(IMSVidFeatures* pVal);
    HRESULT get_InputActive(IMSVidInputDevice* pVal);
    HRESULT put_InputActive(IMSVidInputDevice pVal);
    HRESULT get_OutputsActive(IMSVidOutputDevices* pVal);
    HRESULT put_OutputsActive(IMSVidOutputDevices pVal);
    HRESULT get_VideoRendererActive(IMSVidVideoRenderer* pVal);
    HRESULT put_VideoRendererActive(IMSVidVideoRenderer pVal);
    HRESULT get_AudioRendererActive(IMSVidAudioRenderer* pVal);
    HRESULT put_AudioRendererActive(IMSVidAudioRenderer pVal);
    HRESULT get_FeaturesActive(IMSVidFeatures* pVal);
    HRESULT put_FeaturesActive(IMSVidFeatures pVal);
    HRESULT get_State(MSVidCtlStateList* lState);
    HRESULT View(VARIANT* v);
    HRESULT Build();
    HRESULT Pause();
    HRESULT Run();
    HRESULT Stop();
    HRESULT Decompose();
    HRESULT DisableVideo();
    HRESULT DisableAudio();
    HRESULT ViewNext(VARIANT* v);
}

@GUID("C3A9F406-2222-436D-86D5-BA3229279EFB")
interface IMSEventBinder : IDispatch
{
    HRESULT Bind(IDispatch pEventObject, BSTR EventName, BSTR EventHandler, int* CancelID);
    HRESULT Unbind(uint CancelCookie);
}

@GUID("B0EDF164-910A-11D2-B632-00C04F79498E")
interface _IMSVidCtlEvents : IDispatch
{
}

@GUID("9CE50F2D-6BA7-40FB-A034-50B1A674EC78")
interface IStreamBufferInitialize : IUnknown
{
    HRESULT SetHKEY(HKEY hkeyRoot);
    HRESULT SetSIDs(uint cSIDs, void** ppSID);
}

@GUID("AFD1F242-7EFD-45EE-BA4E-407A25C9A77A")
interface IStreamBufferSink : IUnknown
{
    HRESULT LockProfile(const(wchar)* pszStreamBufferFilename);
    HRESULT CreateRecorder(const(wchar)* pszFilename, uint dwRecordType, IUnknown* pRecordingIUnknown);
    HRESULT IsProfileLocked();
}

@GUID("DB94A660-F4FB-4BFA-BCC6-FE159A4EEA93")
interface IStreamBufferSink2 : IStreamBufferSink
{
    HRESULT UnlockProfile();
}

@GUID("974723F2-887A-4452-9366-2CFF3057BC8F")
interface IStreamBufferSink3 : IStreamBufferSink2
{
    HRESULT SetAvailableFilter(long* prtMin);
}

@GUID("1C5BD776-6CED-4F44-8164-5EAB0E98DB12")
interface IStreamBufferSource : IUnknown
{
    HRESULT SetStreamSink(IStreamBufferSink pIStreamBufferSink);
}

@GUID("BA9B6C99-F3C7-4FF2-92DB-CFDD4851BF31")
interface IStreamBufferRecordControl : IUnknown
{
    HRESULT Start(long* prtStart);
    HRESULT Stop(long rtStop);
    HRESULT GetRecordingStatus(int* phResult, int* pbStarted, int* pbStopped);
}

@GUID("9E259A9B-8815-42AE-B09F-221970B154FD")
interface IStreamBufferRecComp : IUnknown
{
    HRESULT Initialize(const(wchar)* pszTargetFilename, const(wchar)* pszSBRecProfileRef);
    HRESULT Append(const(wchar)* pszSBRecording);
    HRESULT AppendEx(const(wchar)* pszSBRecording, long rtStart, long rtStop);
    HRESULT GetCurrentLength(uint* pcSeconds);
    HRESULT Close();
    HRESULT Cancel();
}

@GUID("16CA4E03-FE69-4705-BD41-5B7DFC0C95F3")
interface IStreamBufferRecordingAttribute : IUnknown
{
    HRESULT SetAttribute(uint ulReserved, const(wchar)* pszAttributeName, 
                         STREAMBUFFER_ATTR_DATATYPE StreamBufferAttributeType, char* pbAttribute, 
                         ushort cbAttributeLength);
    HRESULT GetAttributeCount(uint ulReserved, ushort* pcAttributes);
    HRESULT GetAttributeByName(const(wchar)* pszAttributeName, uint* pulReserved, 
                               STREAMBUFFER_ATTR_DATATYPE* pStreamBufferAttributeType, char* pbAttribute, 
                               ushort* pcbLength);
    HRESULT GetAttributeByIndex(ushort wIndex, uint* pulReserved, ushort* pszAttributeName, ushort* pcchNameLength, 
                                STREAMBUFFER_ATTR_DATATYPE* pStreamBufferAttributeType, char* pbAttribute, 
                                ushort* pcbLength);
    HRESULT EnumAttributes(IEnumStreamBufferRecordingAttrib* ppIEnumStreamBufferAttrib);
}

@GUID("C18A9162-1E82-4142-8C73-5690FA62FE33")
interface IEnumStreamBufferRecordingAttrib : IUnknown
{
    HRESULT Next(uint cRequest, char* pStreamBufferAttribute, uint* pcReceived);
    HRESULT Skip(uint cRecords);
    HRESULT Reset();
    HRESULT Clone(IEnumStreamBufferRecordingAttrib* ppIEnumStreamBufferAttrib);
}

@GUID("CE14DFAE-4098-4AF7-BBF7-D6511F835414")
interface IStreamBufferConfigure : IUnknown
{
    HRESULT SetDirectory(const(wchar)* pszDirectoryName);
    HRESULT GetDirectory(ushort** ppszDirectoryName);
    HRESULT SetBackingFileCount(uint dwMin, uint dwMax);
    HRESULT GetBackingFileCount(uint* pdwMin, uint* pdwMax);
    HRESULT SetBackingFileDuration(uint dwSeconds);
    HRESULT GetBackingFileDuration(uint* pdwSeconds);
}

@GUID("53E037BF-3992-4282-AE34-2487B4DAE06B")
interface IStreamBufferConfigure2 : IStreamBufferConfigure
{
    HRESULT SetMultiplexedPacketSize(uint cbBytesPerPacket);
    HRESULT GetMultiplexedPacketSize(uint* pcbBytesPerPacket);
    HRESULT SetFFTransitionRates(uint dwMaxFullFrameRate, uint dwMaxNonSkippingRate);
    HRESULT GetFFTransitionRates(uint* pdwMaxFullFrameRate, uint* pdwMaxNonSkippingRate);
}

@GUID("7E2D2A1E-7192-4BD7-80C1-061FD1D10402")
interface IStreamBufferConfigure3 : IStreamBufferConfigure2
{
    HRESULT SetStartRecConfig(BOOL fStartStopsCur);
    HRESULT GetStartRecConfig(int* pfStartStopsCur);
    HRESULT SetNamespace(const(wchar)* pszNamespace);
    HRESULT GetNamespace(ushort** ppszNamespace);
}

@GUID("F61F5C26-863D-4AFA-B0BA-2F81DC978596")
interface IStreamBufferMediaSeeking : IMediaSeeking
{
}

@GUID("3A439AB0-155F-470A-86A6-9EA54AFD6EAF")
interface IStreamBufferMediaSeeking2 : IStreamBufferMediaSeeking
{
    HRESULT SetRateEx(double dRate, uint dwFramesPerSec);
}

@GUID("9D2A2563-31AB-402E-9A6B-ADB903489440")
interface IStreamBufferDataCounters : IUnknown
{
    HRESULT GetData(SBE_PIN_DATA* pPinData);
    HRESULT ResetData();
}

@GUID("CAEDE759-B6B1-11DB-A578-0018F3FA24C6")
interface ISBE2GlobalEvent : IUnknown
{
    HRESULT GetEvent(const(GUID)* idEvt, uint param1, uint param2, uint param3, uint param4, int* pSpanning, 
                     uint* pcb, char* pb);
}

@GUID("6D8309BF-00FE-4506-8B03-F8C65B5C9B39")
interface ISBE2GlobalEvent2 : ISBE2GlobalEvent
{
    HRESULT GetEventEx(const(GUID)* idEvt, uint param1, uint param2, uint param3, uint param4, int* pSpanning, 
                       uint* pcb, char* pb, long* pStreamTime);
}

@GUID("CAEDE760-B6B1-11DB-A578-0018F3FA24C6")
interface ISBE2SpanningEvent : IUnknown
{
    HRESULT GetEvent(const(GUID)* idEvt, uint streamId, uint* pcb, char* pb);
}

@GUID("547B6D26-3226-487E-8253-8AA168749434")
interface ISBE2Crossbar : IUnknown
{
    HRESULT EnableDefaultMode(uint DefaultFlags);
    HRESULT GetInitialProfile(ISBE2MediaTypeProfile* ppProfile);
    HRESULT SetOutputProfile(ISBE2MediaTypeProfile pProfile, uint* pcOutputPins, IPin* ppOutputPins);
    HRESULT EnumStreams(ISBE2EnumStream* ppStreams);
}

@GUID("667C7745-85B1-4C55-AE55-4E25056159FC")
interface ISBE2StreamMap : IUnknown
{
    HRESULT MapStream(uint Stream);
    HRESULT UnmapStream(uint Stream);
    HRESULT EnumMappedStreams(ISBE2EnumStream* ppStreams);
}

@GUID("F7611092-9FBC-46EC-A7C7-548EA78B71A4")
interface ISBE2EnumStream : IUnknown
{
    HRESULT Next(uint cRequest, char* pStreamDesc, uint* pcReceived);
    HRESULT Skip(uint cRecords);
    HRESULT Reset();
    HRESULT Clone(ISBE2EnumStream* ppIEnumStream);
}

@GUID("F238267D-4671-40D7-997E-25DC32CFED2A")
interface ISBE2MediaTypeProfile : IUnknown
{
    HRESULT GetStreamCount(uint* pCount);
    HRESULT GetStream(uint Index, AM_MEDIA_TYPE** ppMediaType);
    HRESULT AddStream(AM_MEDIA_TYPE* pMediaType);
    HRESULT DeleteStream(uint Index);
}

@GUID("3E2BF5A5-4F96-4899-A1A3-75E8BE9A5AC0")
interface ISBE2FileScan : IUnknown
{
    HRESULT RepairFile(const(wchar)* filename);
}

@GUID("BDCDD913-9ECD-4FB2-81AE-ADF747EA75A5")
interface IMpeg2TableFilter : IUnknown
{
    HRESULT AddPID(ushort p);
    HRESULT AddTable(ushort p, ubyte t);
    HRESULT AddExtension(ushort p, ubyte t, ushort e);
    HRESULT RemovePID(ushort p);
    HRESULT RemoveTable(ushort p, ubyte t);
    HRESULT RemoveExtension(ushort p, ubyte t, ushort e);
}

@GUID("9B396D40-F380-4E3C-A514-1A82BF6EBFE6")
interface IMpeg2Data : IUnknown
{
    HRESULT GetSection(ushort pid, ubyte tid, MPEG2_FILTER* pFilter, uint dwTimeout, ISectionList* ppSectionList);
    HRESULT GetTable(ushort pid, ubyte tid, MPEG2_FILTER* pFilter, uint dwTimeout, ISectionList* ppSectionList);
    HRESULT GetStreamOfSections(ushort pid, ubyte tid, MPEG2_FILTER* pFilter, HANDLE hDataReadyEvent, 
                                IMpeg2Stream* ppMpegStream);
}

@GUID("AFEC1EB5-2A64-46C6-BF4B-AE3CCB6AFDB0")
interface ISectionList : IUnknown
{
    HRESULT Initialize(MPEG_REQUEST_TYPE requestType, IMpeg2Data pMpeg2Data, MPEG_CONTEXT* pContext, ushort pid, 
                       ubyte tid, MPEG2_FILTER* pFilter, uint timeout, HANDLE hDoneEvent);
    HRESULT InitializeWithRawSections(MPEG_PACKET_LIST* pmplSections);
    HRESULT CancelPendingRequest();
    HRESULT GetNumberOfSections(ushort* pCount);
    HRESULT GetSectionData(ushort sectionNumber, uint* pdwRawPacketLength, SECTION** ppSection);
    HRESULT GetProgramIdentifier(ushort* pPid);
    HRESULT GetTableIdentifier(ubyte* pTableId);
}

@GUID("400CC286-32A0-4CE4-9041-39571125A635")
interface IMpeg2Stream : IUnknown
{
    HRESULT Initialize(MPEG_REQUEST_TYPE requestType, IMpeg2Data pMpeg2Data, MPEG_CONTEXT* pContext, ushort pid, 
                       ubyte tid, MPEG2_FILTER* pFilter, HANDLE hDataReadyEvent);
    HRESULT SupplyDataBuffer(MPEG_STREAM_BUFFER* pStreamBuffer);
}

@GUID("6A5918F8-A77A-4F61-AED0-5702BDCDA3E6")
interface IGenericDescriptor : IUnknown
{
    HRESULT Initialize(ubyte* pbDesc, int bCount);
    HRESULT GetTag(ubyte* pbVal);
    HRESULT GetLength(ubyte* pbVal);
    HRESULT GetBody(ubyte** ppbVal);
}

@GUID("BF02FB7E-9792-4E10-A68D-033A2CC246A5")
interface IGenericDescriptor2 : IGenericDescriptor
{
    HRESULT Initialize(ubyte* pbDesc, ushort wCount);
    HRESULT GetLength(ushort* pwVal);
}

@GUID("6623B511-4B5F-43C3-9A01-E8FF84188060")
interface IPAT : IUnknown
{
    HRESULT Initialize(ISectionList pSectionList, IMpeg2Data pMPEGData);
    HRESULT GetTransportStreamId(ushort* pwVal);
    HRESULT GetVersionNumber(ubyte* pbVal);
    HRESULT GetCountOfRecords(uint* pdwVal);
    HRESULT GetRecordProgramNumber(uint dwIndex, ushort* pwVal);
    HRESULT GetRecordProgramMapPid(uint dwIndex, ushort* pwVal);
    HRESULT FindRecordProgramMapPid(ushort wProgramNumber, ushort* pwVal);
    HRESULT RegisterForNextTable(HANDLE hNextTableAvailable);
    HRESULT GetNextTable(IPAT* ppPAT);
    HRESULT RegisterForWhenCurrent(HANDLE hNextTableIsCurrent);
    HRESULT ConvertNextToCurrent();
}

@GUID("7C6995FB-2A31-4BD7-953E-B1AD7FB7D31C")
interface ICAT : IUnknown
{
    HRESULT Initialize(ISectionList pSectionList, IMpeg2Data pMPEGData);
    HRESULT GetVersionNumber(ubyte* pbVal);
    HRESULT GetCountOfTableDescriptors(uint* pdwVal);
    HRESULT GetTableDescriptorByIndex(uint dwIndex, IGenericDescriptor* ppDescriptor);
    HRESULT GetTableDescriptorByTag(ubyte bTag, uint* pdwCookie, IGenericDescriptor* ppDescriptor);
    HRESULT RegisterForNextTable(HANDLE hNextTableAvailable);
    HRESULT GetNextTable(uint dwTimeout, ICAT* ppCAT);
    HRESULT RegisterForWhenCurrent(HANDLE hNextTableIsCurrent);
    HRESULT ConvertNextToCurrent();
}

@GUID("01F3B398-9527-4736-94DB-5195878E97A8")
interface IPMT : IUnknown
{
    HRESULT Initialize(ISectionList pSectionList, IMpeg2Data pMPEGData);
    HRESULT GetProgramNumber(ushort* pwVal);
    HRESULT GetVersionNumber(ubyte* pbVal);
    HRESULT GetPcrPid(ushort* pPidVal);
    HRESULT GetCountOfTableDescriptors(uint* pdwVal);
    HRESULT GetTableDescriptorByIndex(uint dwIndex, IGenericDescriptor* ppDescriptor);
    HRESULT GetTableDescriptorByTag(ubyte bTag, uint* pdwCookie, IGenericDescriptor* ppDescriptor);
    HRESULT GetCountOfRecords(ushort* pwVal);
    HRESULT GetRecordStreamType(uint dwRecordIndex, ubyte* pbVal);
    HRESULT GetRecordElementaryPid(uint dwRecordIndex, ushort* pPidVal);
    HRESULT GetRecordCountOfDescriptors(uint dwRecordIndex, uint* pdwVal);
    HRESULT GetRecordDescriptorByIndex(uint dwRecordIndex, uint dwDescIndex, IGenericDescriptor* ppDescriptor);
    HRESULT GetRecordDescriptorByTag(uint dwRecordIndex, ubyte bTag, uint* pdwCookie, 
                                     IGenericDescriptor* ppDescriptor);
    HRESULT QueryServiceGatewayInfo(DSMCC_ELEMENT** ppDSMCCList, uint* puiCount);
    HRESULT QueryMPEInfo(MPE_ELEMENT** ppMPEList, uint* puiCount);
    HRESULT RegisterForNextTable(HANDLE hNextTableAvailable);
    HRESULT GetNextTable(IPMT* ppPMT);
    HRESULT RegisterForWhenCurrent(HANDLE hNextTableIsCurrent);
    HRESULT ConvertNextToCurrent();
}

@GUID("D19BDB43-405B-4A7C-A791-C89110C33165")
interface ITSDT : IUnknown
{
    HRESULT Initialize(ISectionList pSectionList, IMpeg2Data pMPEGData);
    HRESULT GetVersionNumber(ubyte* pbVal);
    HRESULT GetCountOfTableDescriptors(uint* pdwVal);
    HRESULT GetTableDescriptorByIndex(uint dwIndex, IGenericDescriptor* ppDescriptor);
    HRESULT GetTableDescriptorByTag(ubyte bTag, uint* pdwCookie, IGenericDescriptor* ppDescriptor);
    HRESULT RegisterForNextTable(HANDLE hNextTableAvailable);
    HRESULT GetNextTable(ITSDT* ppTSDT);
    HRESULT RegisterForWhenCurrent(HANDLE hNextTableIsCurrent);
    HRESULT ConvertNextToCurrent();
}

@GUID("919F24C5-7B14-42AC-A4B0-2AE08DAF00AC")
interface IPSITables : IUnknown
{
    HRESULT GetTable(uint dwTSID, uint dwTID_PID, uint dwHashedVer, uint dwPara4, IUnknown* ppIUnknown);
}

@GUID("B2C98995-5EB2-4FB1-B406-F3E8E2026A9A")
interface IAtscPsipParser : IUnknown
{
    HRESULT Initialize(IUnknown punkMpeg2Data);
    HRESULT GetPAT(IPAT* ppPAT);
    HRESULT GetCAT(uint dwTimeout, ICAT* ppCAT);
    HRESULT GetPMT(ushort pid, ushort* pwProgramNumber, IPMT* ppPMT);
    HRESULT GetTSDT(ITSDT* ppTSDT);
    HRESULT GetMGT(IATSC_MGT* ppMGT);
    HRESULT GetVCT(ubyte tableId, BOOL fGetNextTable, IATSC_VCT* ppVCT);
    HRESULT GetEIT(ushort pid, ushort* pwSourceId, uint dwTimeout, IATSC_EIT* ppEIT);
    HRESULT GetETT(ushort pid, ushort* wSourceId, ushort* pwEventId, IATSC_ETT* ppETT);
    HRESULT GetSTT(IATSC_STT* ppSTT);
    HRESULT GetEAS(ushort pid, ISCTE_EAS* ppEAS);
}

@GUID("8877DABD-C137-4073-97E3-779407A5D87A")
interface IATSC_MGT : IUnknown
{
    HRESULT Initialize(ISectionList pSectionList, IMpeg2Data pMPEGData);
    HRESULT GetVersionNumber(ubyte* pbVal);
    HRESULT GetProtocolVersion(ubyte* pbVal);
    HRESULT GetCountOfRecords(uint* pdwVal);
    HRESULT GetRecordType(uint dwRecordIndex, ushort* pwVal);
    HRESULT GetRecordTypePid(uint dwRecordIndex, ushort* ppidVal);
    HRESULT GetRecordVersionNumber(uint dwRecordIndex, ubyte* pbVal);
    HRESULT GetRecordCountOfDescriptors(uint dwRecordIndex, uint* pdwVal);
    HRESULT GetRecordDescriptorByIndex(uint dwRecordIndex, uint dwIndex, IGenericDescriptor* ppDescriptor);
    HRESULT GetRecordDescriptorByTag(uint dwRecordIndex, ubyte bTag, uint* pdwCookie, 
                                     IGenericDescriptor* ppDescriptor);
    HRESULT GetCountOfTableDescriptors(uint* pdwVal);
    HRESULT GetTableDescriptorByIndex(uint dwIndex, IGenericDescriptor* ppDescriptor);
    HRESULT GetTableDescriptorByTag(ubyte bTag, uint* pdwCookie, IGenericDescriptor* ppDescriptor);
}

@GUID("26879A18-32F9-46C6-91F0-FB6479270E8C")
interface IATSC_VCT : IUnknown
{
    HRESULT Initialize(ISectionList pSectionList, IMpeg2Data pMPEGData);
    HRESULT GetVersionNumber(ubyte* pbVal);
    HRESULT GetTransportStreamId(ushort* pwVal);
    HRESULT GetProtocolVersion(ubyte* pbVal);
    HRESULT GetCountOfRecords(uint* pdwVal);
    HRESULT GetRecordName(uint dwRecordIndex, ushort** pwsName);
    HRESULT GetRecordMajorChannelNumber(uint dwRecordIndex, ushort* pwVal);
    HRESULT GetRecordMinorChannelNumber(uint dwRecordIndex, ushort* pwVal);
    HRESULT GetRecordModulationMode(uint dwRecordIndex, ubyte* pbVal);
    HRESULT GetRecordCarrierFrequency(uint dwRecordIndex, uint* pdwVal);
    HRESULT GetRecordTransportStreamId(uint dwRecordIndex, ushort* pwVal);
    HRESULT GetRecordProgramNumber(uint dwRecordIndex, ushort* pwVal);
    HRESULT GetRecordEtmLocation(uint dwRecordIndex, ubyte* pbVal);
    HRESULT GetRecordIsAccessControlledBitSet(uint dwRecordIndex, int* pfVal);
    HRESULT GetRecordIsHiddenBitSet(uint dwRecordIndex, int* pfVal);
    HRESULT GetRecordIsPathSelectBitSet(uint dwRecordIndex, int* pfVal);
    HRESULT GetRecordIsOutOfBandBitSet(uint dwRecordIndex, int* pfVal);
    HRESULT GetRecordIsHideGuideBitSet(uint dwRecordIndex, int* pfVal);
    HRESULT GetRecordServiceType(uint dwRecordIndex, ubyte* pbVal);
    HRESULT GetRecordSourceId(uint dwRecordIndex, ushort* pwVal);
    HRESULT GetRecordCountOfDescriptors(uint dwRecordIndex, uint* pdwVal);
    HRESULT GetRecordDescriptorByIndex(uint dwRecordIndex, uint dwIndex, IGenericDescriptor* ppDescriptor);
    HRESULT GetRecordDescriptorByTag(uint dwRecordIndex, ubyte bTag, uint* pdwCookie, 
                                     IGenericDescriptor* ppDescriptor);
    HRESULT GetCountOfTableDescriptors(uint* pdwVal);
    HRESULT GetTableDescriptorByIndex(uint dwIndex, IGenericDescriptor* ppDescriptor);
    HRESULT GetTableDescriptorByTag(ubyte bTag, uint* pdwCookie, IGenericDescriptor* ppDescriptor);
}

@GUID("D7C212D7-76A2-4B4B-AA56-846879A80096")
interface IATSC_EIT : IUnknown
{
    HRESULT Initialize(ISectionList pSectionList, IMpeg2Data pMPEGData);
    HRESULT GetVersionNumber(ubyte* pbVal);
    HRESULT GetSourceId(ushort* pwVal);
    HRESULT GetProtocolVersion(ubyte* pbVal);
    HRESULT GetCountOfRecords(uint* pdwVal);
    HRESULT GetRecordEventId(uint dwRecordIndex, ushort* pwVal);
    HRESULT GetRecordStartTime(uint dwRecordIndex, MPEG_DATE_AND_TIME* pmdtVal);
    HRESULT GetRecordEtmLocation(uint dwRecordIndex, ubyte* pbVal);
    HRESULT GetRecordDuration(uint dwRecordIndex, MPEG_TIME* pmdVal);
    HRESULT GetRecordTitleText(uint dwRecordIndex, uint* pdwLength, ubyte** ppText);
    HRESULT GetRecordCountOfDescriptors(uint dwRecordIndex, uint* pdwVal);
    HRESULT GetRecordDescriptorByIndex(uint dwRecordIndex, uint dwIndex, IGenericDescriptor* ppDescriptor);
    HRESULT GetRecordDescriptorByTag(uint dwRecordIndex, ubyte bTag, uint* pdwCookie, 
                                     IGenericDescriptor* ppDescriptor);
}

@GUID("5A142CC9-B8CF-4A86-A040-E9CADF3EF3E7")
interface IATSC_ETT : IUnknown
{
    HRESULT Initialize(ISectionList pSectionList, IMpeg2Data pMPEGData);
    HRESULT GetVersionNumber(ubyte* pbVal);
    HRESULT GetProtocolVersion(ubyte* pbVal);
    HRESULT GetEtmId(uint* pdwVal);
    HRESULT GetExtendedMessageText(uint* pdwLength, ubyte** ppText);
}

@GUID("6BF42423-217D-4D6F-81E1-3A7B360EC896")
interface IATSC_STT : IUnknown
{
    HRESULT Initialize(ISectionList pSectionList, IMpeg2Data pMPEGData);
    HRESULT GetProtocolVersion(ubyte* pbVal);
    HRESULT GetSystemTime(MPEG_DATE_AND_TIME* pmdtSystemTime);
    HRESULT GetGpsUtcOffset(ubyte* pbVal);
    HRESULT GetDaylightSavings(ushort* pwVal);
    HRESULT GetCountOfTableDescriptors(uint* pdwVal);
    HRESULT GetTableDescriptorByIndex(uint dwIndex, IGenericDescriptor* ppDescriptor);
    HRESULT GetTableDescriptorByTag(ubyte bTag, uint* pdwCookie, IGenericDescriptor* ppDescriptor);
}

@GUID("1FF544D6-161D-4FAE-9FAA-4F9F492AE999")
interface ISCTE_EAS : IUnknown
{
    HRESULT Initialize(ISectionList pSectionList, IMpeg2Data pMPEGData);
    HRESULT GetVersionNumber(ubyte* pbVal);
    HRESULT GetSequencyNumber(ubyte* pbVal);
    HRESULT GetProtocolVersion(ubyte* pbVal);
    HRESULT GetEASEventID(ushort* pwVal);
    HRESULT GetOriginatorCode(ubyte* pbVal);
    HRESULT GetEASEventCodeLen(ubyte* pbVal);
    HRESULT GetEASEventCode(ubyte* pbVal);
    HRESULT GetRawNatureOfActivationTextLen(ubyte* pbVal);
    HRESULT GetRawNatureOfActivationText(ubyte* pbVal);
    HRESULT GetNatureOfActivationText(BSTR bstrIS0639code, BSTR* pbstrString);
    HRESULT GetTimeRemaining(ubyte* pbVal);
    HRESULT GetStartTime(uint* pdwVal);
    HRESULT GetDuration(ushort* pwVal);
    HRESULT GetAlertPriority(ubyte* pbVal);
    HRESULT GetDetailsOOBSourceID(ushort* pwVal);
    HRESULT GetDetailsMajor(ushort* pwVal);
    HRESULT GetDetailsMinor(ushort* pwVal);
    HRESULT GetDetailsAudioOOBSourceID(ushort* pwVal);
    HRESULT GetAlertText(BSTR bstrIS0639code, BSTR* pbstrString);
    HRESULT GetRawAlertTextLen(ushort* pwVal);
    HRESULT GetRawAlertText(ubyte* pbVal);
    HRESULT GetLocationCount(ubyte* pbVal);
    HRESULT GetLocationCodes(ubyte bIndex, ubyte* pbState, ubyte* pbCountySubdivision, ushort* pwCounty);
    HRESULT GetExceptionCount(ubyte* pbVal);
    HRESULT GetExceptionService(ubyte bIndex, ubyte* pbIBRef, ushort* pwFirst, ushort* pwSecond);
    HRESULT GetCountOfTableDescriptors(uint* pdwVal);
    HRESULT GetTableDescriptorByIndex(uint dwIndex, IGenericDescriptor* ppDescriptor);
    HRESULT GetTableDescriptorByTag(ubyte bTag, uint* pdwCookie, IGenericDescriptor* ppDescriptor);
}

@GUID("FF76E60C-0283-43EA-BA32-B422238547EE")
interface IAtscContentAdvisoryDescriptor : IUnknown
{
    HRESULT GetTag(ubyte* pbVal);
    HRESULT GetLength(ubyte* pbVal);
    HRESULT GetRatingRegionCount(ubyte* pbVal);
    HRESULT GetRecordRatingRegion(ubyte bIndex, ubyte* pbVal);
    HRESULT GetRecordRatedDimensions(ubyte bIndex, ubyte* pbVal);
    HRESULT GetRecordRatingDimension(ubyte bIndexOuter, ubyte bIndexInner, ubyte* pbVal);
    HRESULT GetRecordRatingValue(ubyte bIndexOuter, ubyte bIndexInner, ubyte* pbVal);
    HRESULT GetRecordRatingDescriptionText(ubyte bIndex, ubyte* pbLength, ubyte** ppText);
}

@GUID("40834007-6834-46F0-BD45-D5F6A6BE258C")
interface ICaptionServiceDescriptor : IUnknown
{
    HRESULT GetNumberOfServices(ubyte* pbVal);
    HRESULT GetLanguageCode(ubyte bIndex, char* LangCode);
    HRESULT GetCaptionServiceNumber(ubyte bIndex, ubyte* pbVal);
    HRESULT GetCCType(ubyte bIndex, ubyte* pbVal);
    HRESULT GetEasyReader(ubyte bIndex, ubyte* pbVal);
    HRESULT GetWideAspectRatio(ubyte bIndex, ubyte* pbVal);
}

@GUID("58C3C827-9D91-4215-BFF3-820A49F0904C")
interface IServiceLocationDescriptor : IUnknown
{
    HRESULT GetPCR_PID(ushort* pwVal);
    HRESULT GetNumberOfElements(ubyte* pbVal);
    HRESULT GetElementStreamType(ubyte bIndex, ubyte* pbVal);
    HRESULT GetElementPID(ubyte bIndex, ushort* pwVal);
    HRESULT GetElementLanguageCode(ubyte bIndex, char* LangCode);
}

@GUID("583EC3CC-4960-4857-982B-41A33EA0A006")
interface IAttributeSet : IUnknown
{
    HRESULT SetAttrib(GUID guidAttribute, ubyte* pbAttribute, uint dwAttributeLength);
}

@GUID("52DBD1EC-E48F-4528-9232-F442A68F0AE1")
interface IAttributeGet : IUnknown
{
    HRESULT GetCount(int* plCount);
    HRESULT GetAttribIndexed(int lIndex, GUID* pguidAttribute, ubyte* pbAttribute, uint* pdwAttributeLength);
    HRESULT GetAttrib(GUID guidAttribute, ubyte* pbAttribute, uint* pdwAttributeLength);
}

@GUID("B758A7BD-14DC-449D-B828-35909ACB3B1E")
interface IDvbSiParser : IUnknown
{
    HRESULT Initialize(IUnknown punkMpeg2Data);
    HRESULT GetPAT(IPAT* ppPAT);
    HRESULT GetCAT(uint dwTimeout, ICAT* ppCAT);
    HRESULT GetPMT(ushort pid, ushort* pwProgramNumber, IPMT* ppPMT);
    HRESULT GetTSDT(ITSDT* ppTSDT);
    HRESULT GetNIT(ubyte tableId, ushort* pwNetworkId, IDVB_NIT* ppNIT);
    HRESULT GetSDT(ubyte tableId, ushort* pwTransportStreamId, IDVB_SDT* ppSDT);
    HRESULT GetEIT(ubyte tableId, ushort* pwServiceId, IDVB_EIT* ppEIT);
    HRESULT GetBAT(ushort* pwBouquetId, IDVB_BAT* ppBAT);
    HRESULT GetRST(uint dwTimeout, IDVB_RST* ppRST);
    HRESULT GetST(ushort pid, uint dwTimeout, IDVB_ST* ppST);
    HRESULT GetTDT(IDVB_TDT* ppTDT);
    HRESULT GetTOT(IDVB_TOT* ppTOT);
    HRESULT GetDIT(uint dwTimeout, IDVB_DIT* ppDIT);
    HRESULT GetSIT(uint dwTimeout, IDVB_SIT* ppSIT);
}

@GUID("0AC5525F-F816-42F4-93BA-4C0F32F46E54")
interface IDvbSiParser2 : IDvbSiParser
{
    HRESULT GetEIT2(ubyte tableId, ushort* pwServiceId, ubyte* pbSegment, IDVB_EIT2* ppEIT);
}

@GUID("900E4BB7-18CD-453F-98BE-3BE6AA211772")
interface IIsdbSiParser2 : IDvbSiParser2
{
    HRESULT GetSDT(ubyte tableId, ushort* pwTransportStreamId, IISDB_SDT* ppSDT);
    HRESULT GetBIT(ubyte tableId, ushort* pwOriginalNetworkId, IISDB_BIT* ppBIT);
    HRESULT GetNBIT(ubyte tableId, ushort* pwOriginalNetworkId, IISDB_NBIT* ppNBIT);
    HRESULT GetLDT(ubyte tableId, ushort* pwOriginalServiceId, IISDB_LDT* ppLDT);
    HRESULT GetSDTT(ubyte tableId, ushort* pwTableIdExt, IISDB_SDTT* ppSDTT);
    HRESULT GetCDT(ubyte tableId, ubyte bSectionNumber, ushort* pwDownloadDataId, IISDB_CDT* ppCDT);
    HRESULT GetEMM(ushort pid, ushort wTableIdExt, IISDB_EMM* ppEMM);
}

@GUID("C64935F4-29E4-4E22-911A-63F7F55CB097")
interface IDVB_NIT : IUnknown
{
    HRESULT Initialize(ISectionList pSectionList, IMpeg2Data pMPEGData);
    HRESULT GetVersionNumber(ubyte* pbVal);
    HRESULT GetNetworkId(ushort* pwVal);
    HRESULT GetCountOfTableDescriptors(uint* pdwVal);
    HRESULT GetTableDescriptorByIndex(uint dwIndex, IGenericDescriptor* ppDescriptor);
    HRESULT GetTableDescriptorByTag(ubyte bTag, uint* pdwCookie, IGenericDescriptor* ppDescriptor);
    HRESULT GetCountOfRecords(uint* pdwVal);
    HRESULT GetRecordTransportStreamId(uint dwRecordIndex, ushort* pwVal);
    HRESULT GetRecordOriginalNetworkId(uint dwRecordIndex, ushort* pwVal);
    HRESULT GetRecordCountOfDescriptors(uint dwRecordIndex, uint* pdwVal);
    HRESULT GetRecordDescriptorByIndex(uint dwRecordIndex, uint dwIndex, IGenericDescriptor* ppDescriptor);
    HRESULT GetRecordDescriptorByTag(uint dwRecordIndex, ubyte bTag, uint* pdwCookie, 
                                     IGenericDescriptor* ppDescriptor);
    HRESULT RegisterForNextTable(HANDLE hNextTableAvailable);
    HRESULT GetNextTable(IDVB_NIT* ppNIT);
    HRESULT RegisterForWhenCurrent(HANDLE hNextTableIsCurrent);
    HRESULT ConvertNextToCurrent();
    HRESULT GetVersionHash(uint* pdwVersionHash);
}

@GUID("02CAD8D3-FE43-48E2-90BD-450ED9A8A5FD")
interface IDVB_SDT : IUnknown
{
    HRESULT Initialize(ISectionList pSectionList, IMpeg2Data pMPEGData);
    HRESULT GetVersionNumber(ubyte* pbVal);
    HRESULT GetTransportStreamId(ushort* pwVal);
    HRESULT GetOriginalNetworkId(ushort* pwVal);
    HRESULT GetCountOfRecords(uint* pdwVal);
    HRESULT GetRecordServiceId(uint dwRecordIndex, ushort* pwVal);
    HRESULT GetRecordEITScheduleFlag(uint dwRecordIndex, int* pfVal);
    HRESULT GetRecordEITPresentFollowingFlag(uint dwRecordIndex, int* pfVal);
    HRESULT GetRecordRunningStatus(uint dwRecordIndex, ubyte* pbVal);
    HRESULT GetRecordFreeCAMode(uint dwRecordIndex, int* pfVal);
    HRESULT GetRecordCountOfDescriptors(uint dwRecordIndex, uint* pdwVal);
    HRESULT GetRecordDescriptorByIndex(uint dwRecordIndex, uint dwIndex, IGenericDescriptor* ppDescriptor);
    HRESULT GetRecordDescriptorByTag(uint dwRecordIndex, ubyte bTag, uint* pdwCookie, 
                                     IGenericDescriptor* ppDescriptor);
    HRESULT RegisterForNextTable(HANDLE hNextTableAvailable);
    HRESULT GetNextTable(IDVB_SDT* ppSDT);
    HRESULT RegisterForWhenCurrent(HANDLE hNextTableIsCurrent);
    HRESULT ConvertNextToCurrent();
    HRESULT GetVersionHash(uint* pdwVersionHash);
}

@GUID("3F3DC9A2-BB32-4FB9-AE9E-D856848927A3")
interface IISDB_SDT : IDVB_SDT
{
    HRESULT GetRecordEITUserDefinedFlags(uint dwRecordIndex, ubyte* pbVal);
}

@GUID("442DB029-02CB-4495-8B92-1C13375BCE99")
interface IDVB_EIT : IUnknown
{
    HRESULT Initialize(ISectionList pSectionList, IMpeg2Data pMPEGData);
    HRESULT GetVersionNumber(ubyte* pbVal);
    HRESULT GetServiceId(ushort* pwVal);
    HRESULT GetTransportStreamId(ushort* pwVal);
    HRESULT GetOriginalNetworkId(ushort* pwVal);
    HRESULT GetSegmentLastSectionNumber(ubyte* pbVal);
    HRESULT GetLastTableId(ubyte* pbVal);
    HRESULT GetCountOfRecords(uint* pdwVal);
    HRESULT GetRecordEventId(uint dwRecordIndex, ushort* pwVal);
    HRESULT GetRecordStartTime(uint dwRecordIndex, MPEG_DATE_AND_TIME* pmdtVal);
    HRESULT GetRecordDuration(uint dwRecordIndex, MPEG_TIME* pmdVal);
    HRESULT GetRecordRunningStatus(uint dwRecordIndex, ubyte* pbVal);
    HRESULT GetRecordFreeCAMode(uint dwRecordIndex, int* pfVal);
    HRESULT GetRecordCountOfDescriptors(uint dwRecordIndex, uint* pdwVal);
    HRESULT GetRecordDescriptorByIndex(uint dwRecordIndex, uint dwIndex, IGenericDescriptor* ppDescriptor);
    HRESULT GetRecordDescriptorByTag(uint dwRecordIndex, ubyte bTag, uint* pdwCookie, 
                                     IGenericDescriptor* ppDescriptor);
    HRESULT RegisterForNextTable(HANDLE hNextTableAvailable);
    HRESULT GetNextTable(IDVB_EIT* ppEIT);
    HRESULT RegisterForWhenCurrent(HANDLE hNextTableIsCurrent);
    HRESULT ConvertNextToCurrent();
    HRESULT GetVersionHash(uint* pdwVersionHash);
}

@GUID("61A389E0-9B9E-4BA0-AEEA-5DDD159820EA")
interface IDVB_EIT2 : IDVB_EIT
{
    HRESULT GetSegmentInfo(ubyte* pbTid, ubyte* pbSegment);
    HRESULT GetRecordSection(uint dwRecordIndex, ubyte* pbVal);
}

@GUID("ECE9BB0C-43B6-4558-A0EC-1812C34CD6CA")
interface IDVB_BAT : IUnknown
{
    HRESULT Initialize(ISectionList pSectionList, IMpeg2Data pMPEGData);
    HRESULT GetVersionNumber(ubyte* pbVal);
    HRESULT GetBouquetId(ushort* pwVal);
    HRESULT GetCountOfTableDescriptors(uint* pdwVal);
    HRESULT GetTableDescriptorByIndex(uint dwIndex, IGenericDescriptor* ppDescriptor);
    HRESULT GetTableDescriptorByTag(ubyte bTag, uint* pdwCookie, IGenericDescriptor* ppDescriptor);
    HRESULT GetCountOfRecords(uint* pdwVal);
    HRESULT GetRecordTransportStreamId(uint dwRecordIndex, ushort* pwVal);
    HRESULT GetRecordOriginalNetworkId(uint dwRecordIndex, ushort* pwVal);
    HRESULT GetRecordCountOfDescriptors(uint dwRecordIndex, uint* pdwVal);
    HRESULT GetRecordDescriptorByIndex(uint dwRecordIndex, uint dwIndex, IGenericDescriptor* ppDescriptor);
    HRESULT GetRecordDescriptorByTag(uint dwRecordIndex, ubyte bTag, uint* pdwCookie, 
                                     IGenericDescriptor* ppDescriptor);
    HRESULT RegisterForNextTable(HANDLE hNextTableAvailable);
    HRESULT GetNextTable(IDVB_BAT* ppBAT);
    HRESULT RegisterForWhenCurrent(HANDLE hNextTableIsCurrent);
    HRESULT ConvertNextToCurrent();
}

@GUID("F47DCD04-1E23-4FB7-9F96-B40EEAD10B2B")
interface IDVB_RST : IUnknown
{
    HRESULT Initialize(ISectionList pSectionList);
    HRESULT GetCountOfRecords(uint* pdwVal);
    HRESULT GetRecordTransportStreamId(uint dwRecordIndex, ushort* pwVal);
    HRESULT GetRecordOriginalNetworkId(uint dwRecordIndex, ushort* pwVal);
    HRESULT GetRecordServiceId(uint dwRecordIndex, ushort* pwVal);
    HRESULT GetRecordEventId(uint dwRecordIndex, ushort* pwVal);
    HRESULT GetRecordRunningStatus(uint dwRecordIndex, ubyte* pbVal);
}

@GUID("4D5B9F23-2A02-45DE-BCDA-5D5DBFBFBE62")
interface IDVB_ST : IUnknown
{
    HRESULT Initialize(ISectionList pSectionList);
    HRESULT GetDataLength(ushort* pwVal);
    HRESULT GetData(ubyte** ppData);
}

@GUID("0780DC7D-D55C-4AEF-97E6-6B75906E2796")
interface IDVB_TDT : IUnknown
{
    HRESULT Initialize(ISectionList pSectionList);
    HRESULT GetUTCTime(MPEG_DATE_AND_TIME* pmdtVal);
}

@GUID("83295D6A-FABA-4EE1-9B15-8067696910AE")
interface IDVB_TOT : IUnknown
{
    HRESULT Initialize(ISectionList pSectionList);
    HRESULT GetUTCTime(MPEG_DATE_AND_TIME* pmdtVal);
    HRESULT GetCountOfTableDescriptors(uint* pdwVal);
    HRESULT GetTableDescriptorByIndex(uint dwIndex, IGenericDescriptor* ppDescriptor);
    HRESULT GetTableDescriptorByTag(ubyte bTag, uint* pdwCookie, IGenericDescriptor* ppDescriptor);
}

@GUID("91BFFDF9-9432-410F-86EF-1C228ED0AD70")
interface IDVB_DIT : IUnknown
{
    HRESULT Initialize(ISectionList pSectionList);
    HRESULT GetTransitionFlag(int* pfVal);
}

@GUID("68CDCE53-8BEA-45C2-9D9D-ACF575A089B5")
interface IDVB_SIT : IUnknown
{
    HRESULT Initialize(ISectionList pSectionList, IMpeg2Data pMPEGData);
    HRESULT GetVersionNumber(ubyte* pbVal);
    HRESULT GetCountOfTableDescriptors(uint* pdwVal);
    HRESULT GetTableDescriptorByIndex(uint dwIndex, IGenericDescriptor* ppDescriptor);
    HRESULT GetTableDescriptorByTag(ubyte bTag, uint* pdwCookie, IGenericDescriptor* ppDescriptor);
    HRESULT GetCountOfRecords(uint* pdwVal);
    HRESULT GetRecordServiceId(uint dwRecordIndex, ushort* pwVal);
    HRESULT GetRecordRunningStatus(uint dwRecordIndex, ubyte* pbVal);
    HRESULT GetRecordCountOfDescriptors(uint dwRecordIndex, uint* pdwVal);
    HRESULT GetRecordDescriptorByIndex(uint dwRecordIndex, uint dwIndex, IGenericDescriptor* ppDescriptor);
    HRESULT GetRecordDescriptorByTag(uint dwRecordIndex, ubyte bTag, uint* pdwCookie, 
                                     IGenericDescriptor* ppDescriptor);
    HRESULT RegisterForNextTable(HANDLE hNextTableAvailable);
    HRESULT GetNextTable(uint dwTimeout, IDVB_SIT* ppSIT);
    HRESULT RegisterForWhenCurrent(HANDLE hNextTableIsCurrent);
    HRESULT ConvertNextToCurrent();
}

@GUID("537CD71E-0E46-4173-9001-BA043F3E49E2")
interface IISDB_BIT : IUnknown
{
    HRESULT Initialize(ISectionList pSectionList, IMpeg2Data pMPEGData);
    HRESULT GetVersionNumber(ubyte* pbVal);
    HRESULT GetOriginalNetworkId(ushort* pwVal);
    HRESULT GetBroadcastViewPropriety(ubyte* pbVal);
    HRESULT GetCountOfTableDescriptors(uint* pdwVal);
    HRESULT GetTableDescriptorByIndex(uint dwIndex, IGenericDescriptor* ppDescriptor);
    HRESULT GetTableDescriptorByTag(ubyte bTag, uint* pdwCookie, IGenericDescriptor* ppDescriptor);
    HRESULT GetCountOfRecords(uint* pdwVal);
    HRESULT GetRecordBroadcasterId(uint dwRecordIndex, ubyte* pbVal);
    HRESULT GetRecordCountOfDescriptors(uint dwRecordIndex, uint* pdwVal);
    HRESULT GetRecordDescriptorByIndex(uint dwRecordIndex, uint dwIndex, IGenericDescriptor* ppDescriptor);
    HRESULT GetRecordDescriptorByTag(uint dwRecordIndex, ubyte bTag, uint* pdwCookie, 
                                     IGenericDescriptor* ppDescriptor);
    HRESULT GetVersionHash(uint* pdwVersionHash);
}

@GUID("1B1863EF-08F1-40B7-A559-3B1EFF8CAFA6")
interface IISDB_NBIT : IUnknown
{
    HRESULT Initialize(ISectionList pSectionList, IMpeg2Data pMPEGData);
    HRESULT GetVersionNumber(ubyte* pbVal);
    HRESULT GetOriginalNetworkId(ushort* pwVal);
    HRESULT GetCountOfRecords(uint* pdwVal);
    HRESULT GetRecordInformationId(uint dwRecordIndex, ushort* pwVal);
    HRESULT GetRecordInformationType(uint dwRecordIndex, ubyte* pbVal);
    HRESULT GetRecordDescriptionBodyLocation(uint dwRecordIndex, ubyte* pbVal);
    HRESULT GetRecordMessageSectionNumber(uint dwRecordIndex, ubyte* pbVal);
    HRESULT GetRecordUserDefined(uint dwRecordIndex, ubyte* pbVal);
    HRESULT GetRecordNumberOfKeys(uint dwRecordIndex, ubyte* pbVal);
    HRESULT GetRecordKeys(uint dwRecordIndex, ubyte** pbKeys);
    HRESULT GetRecordCountOfDescriptors(uint dwRecordIndex, uint* pdwVal);
    HRESULT GetRecordDescriptorByIndex(uint dwRecordIndex, uint dwIndex, IGenericDescriptor* ppDescriptor);
    HRESULT GetRecordDescriptorByTag(uint dwRecordIndex, ubyte bTag, uint* pdwCookie, 
                                     IGenericDescriptor* ppDescriptor);
    HRESULT GetVersionHash(uint* pdwVersionHash);
}

@GUID("141A546B-02FF-4FB9-A3A3-2F074B74A9A9")
interface IISDB_LDT : IUnknown
{
    HRESULT Initialize(ISectionList pSectionList, IMpeg2Data pMPEGData);
    HRESULT GetVersionNumber(ubyte* pbVal);
    HRESULT GetOriginalServiceId(ushort* pwVal);
    HRESULT GetTransportStreamId(ushort* pwVal);
    HRESULT GetOriginalNetworkId(ushort* pwVal);
    HRESULT GetCountOfRecords(uint* pdwVal);
    HRESULT GetRecordDescriptionId(uint dwRecordIndex, ushort* pwVal);
    HRESULT GetRecordCountOfDescriptors(uint dwRecordIndex, uint* pdwVal);
    HRESULT GetRecordDescriptorByIndex(uint dwRecordIndex, uint dwIndex, IGenericDescriptor* ppDescriptor);
    HRESULT GetRecordDescriptorByTag(uint dwRecordIndex, ubyte bTag, uint* pdwCookie, 
                                     IGenericDescriptor* ppDescriptor);
    HRESULT GetVersionHash(uint* pdwVersionHash);
}

@GUID("EE60EF2D-813A-4DC7-BF92-EA13DAC85313")
interface IISDB_SDTT : IUnknown
{
    HRESULT Initialize(ISectionList pSectionList, IMpeg2Data pMPEGData);
    HRESULT GetVersionNumber(ubyte* pbVal);
    HRESULT GetTableIdExt(ushort* pwVal);
    HRESULT GetTransportStreamId(ushort* pwVal);
    HRESULT GetOriginalNetworkId(ushort* pwVal);
    HRESULT GetServiceId(ushort* pwVal);
    HRESULT GetCountOfRecords(uint* pdwVal);
    HRESULT GetRecordGroup(uint dwRecordIndex, ubyte* pbVal);
    HRESULT GetRecordTargetVersion(uint dwRecordIndex, ushort* pwVal);
    HRESULT GetRecordNewVersion(uint dwRecordIndex, ushort* pwVal);
    HRESULT GetRecordDownloadLevel(uint dwRecordIndex, ubyte* pbVal);
    HRESULT GetRecordVersionIndicator(uint dwRecordIndex, ubyte* pbVal);
    HRESULT GetRecordScheduleTimeShiftInformation(uint dwRecordIndex, ubyte* pbVal);
    HRESULT GetRecordCountOfSchedules(uint dwRecordIndex, uint* pdwVal);
    HRESULT GetRecordStartTimeByIndex(uint dwRecordIndex, uint dwIndex, MPEG_DATE_AND_TIME* pmdtVal);
    HRESULT GetRecordDurationByIndex(uint dwRecordIndex, uint dwIndex, MPEG_TIME* pmdVal);
    HRESULT GetRecordCountOfDescriptors(uint dwRecordIndex, uint* pdwVal);
    HRESULT GetRecordDescriptorByIndex(uint dwRecordIndex, uint dwIndex, IGenericDescriptor* ppDescriptor);
    HRESULT GetRecordDescriptorByTag(uint dwRecordIndex, ubyte bTag, uint* pdwCookie, 
                                     IGenericDescriptor* ppDescriptor);
    HRESULT GetVersionHash(uint* pdwVersionHash);
}

@GUID("25FA92C2-8B80-4787-A841-3A0E8F17984B")
interface IISDB_CDT : IUnknown
{
    HRESULT Initialize(ISectionList pSectionList, IMpeg2Data pMPEGData, ubyte bSectionNumber);
    HRESULT GetVersionNumber(ubyte* pbVal);
    HRESULT GetDownloadDataId(ushort* pwVal);
    HRESULT GetSectionNumber(ubyte* pbVal);
    HRESULT GetOriginalNetworkId(ushort* pwVal);
    HRESULT GetDataType(ubyte* pbVal);
    HRESULT GetCountOfTableDescriptors(uint* pdwVal);
    HRESULT GetTableDescriptorByIndex(uint dwIndex, IGenericDescriptor* ppDescriptor);
    HRESULT GetTableDescriptorByTag(ubyte bTag, uint* pdwCookie, IGenericDescriptor* ppDescriptor);
    HRESULT GetSizeOfDataModule(uint* pdwVal);
    HRESULT GetDataModule(ubyte** pbData);
    HRESULT GetVersionHash(uint* pdwVersionHash);
}

@GUID("0EDB556D-43AD-4938-9668-321B2FFECFD3")
interface IISDB_EMM : IUnknown
{
    HRESULT Initialize(ISectionList pSectionList, IMpeg2Data pMPEGData);
    HRESULT GetVersionNumber(ubyte* pbVal);
    HRESULT GetTableIdExtension(ushort* pwVal);
    HRESULT GetDataBytes(ushort* pwBufferLength, ubyte* pbBuffer);
    HRESULT GetSharedEmmMessage(ushort* pwLength, ubyte** ppbMessage);
    HRESULT GetIndividualEmmMessage(IUnknown pUnknown, ushort* pwLength, ubyte** ppbMessage);
    HRESULT GetVersionHash(uint* pdwVersionHash);
}

@GUID("0F37BD92-D6A1-4854-B950-3A969D27F30E")
interface IDvbServiceAttributeDescriptor : IUnknown
{
    HRESULT GetTag(ubyte* pbVal);
    HRESULT GetLength(ubyte* pbVal);
    HRESULT GetCountOfRecords(ubyte* pbVal);
    HRESULT GetRecordServiceId(ubyte bRecordIndex, ushort* pwVal);
    HRESULT GetRecordNumericSelectionFlag(ubyte bRecordIndex, int* pfVal);
    HRESULT GetRecordVisibleServiceFlag(ubyte bRecordIndex, int* pfVal);
}

@GUID("05E0C1EA-F661-4053-9FBF-D93B28359838")
interface IDvbContentIdentifierDescriptor : IUnknown
{
    HRESULT GetTag(ubyte* pbVal);
    HRESULT GetLength(ubyte* pbVal);
    HRESULT GetCountOfRecords(ubyte* pbVal);
    HRESULT GetRecordCrid(ubyte bRecordIndex, ubyte* pbType, ubyte* pbLocation, ubyte* pbLength, ubyte** ppbBytes);
}

@GUID("05EC24D1-3A31-44E7-B408-67C60A352276")
interface IDvbDefaultAuthorityDescriptor : IUnknown
{
    HRESULT GetTag(ubyte* pbVal);
    HRESULT GetLength(ubyte* pbVal);
    HRESULT GetDefaultAuthority(ubyte* pbLength, ubyte** ppbBytes);
}

@GUID("02F2225A-805B-4EC5-A9A6-F9B5913CD470")
interface IDvbSatelliteDeliverySystemDescriptor : IUnknown
{
    HRESULT GetTag(ubyte* pbVal);
    HRESULT GetLength(ubyte* pbVal);
    HRESULT GetFrequency(uint* pdwVal);
    HRESULT GetOrbitalPosition(ushort* pwVal);
    HRESULT GetWestEastFlag(ubyte* pbVal);
    HRESULT GetPolarization(ubyte* pbVal);
    HRESULT GetModulation(ubyte* pbVal);
    HRESULT GetSymbolRate(uint* pdwVal);
    HRESULT GetFECInner(ubyte* pbVal);
}

@GUID("DFB98E36-9E1A-4862-9946-993A4E59017B")
interface IDvbCableDeliverySystemDescriptor : IUnknown
{
    HRESULT GetTag(ubyte* pbVal);
    HRESULT GetLength(ubyte* pbVal);
    HRESULT GetFrequency(uint* pdwVal);
    HRESULT GetFECOuter(ubyte* pbVal);
    HRESULT GetModulation(ubyte* pbVal);
    HRESULT GetSymbolRate(uint* pdwVal);
    HRESULT GetFECInner(ubyte* pbVal);
}

@GUID("ED7E1B91-D12E-420C-B41D-A49D84FE1823")
interface IDvbTerrestrialDeliverySystemDescriptor : IUnknown
{
    HRESULT GetTag(ubyte* pbVal);
    HRESULT GetLength(ubyte* pbVal);
    HRESULT GetCentreFrequency(uint* pdwVal);
    HRESULT GetBandwidth(ubyte* pbVal);
    HRESULT GetConstellation(ubyte* pbVal);
    HRESULT GetHierarchyInformation(ubyte* pbVal);
    HRESULT GetCodeRateHPStream(ubyte* pbVal);
    HRESULT GetCodeRateLPStream(ubyte* pbVal);
    HRESULT GetGuardInterval(ubyte* pbVal);
    HRESULT GetTransmissionMode(ubyte* pbVal);
    HRESULT GetOtherFrequencyFlag(ubyte* pbVal);
}

@GUID("20EE9BE9-CD57-49AB-8F6E-1D07AEB8E482")
interface IDvbTerrestrial2DeliverySystemDescriptor : IUnknown
{
    HRESULT GetTag(ubyte* pbVal);
    HRESULT GetLength(ubyte* pbVal);
    HRESULT GetTagExtension(ubyte* pbVal);
    HRESULT GetCentreFrequency(uint* pdwVal);
    HRESULT GetPLPId(ubyte* pbVal);
    HRESULT GetT2SystemId(ushort* pwVal);
    HRESULT GetMultipleInputMode(ubyte* pbVal);
    HRESULT GetBandwidth(ubyte* pbVal);
    HRESULT GetGuardInterval(ubyte* pbVal);
    HRESULT GetTransmissionMode(ubyte* pbVal);
    HRESULT GetCellId(ushort* pwVal);
    HRESULT GetOtherFrequencyFlag(ubyte* pbVal);
    HRESULT GetTFSFlag(ubyte* pbVal);
}

@GUID("1CADB613-E1DD-4512-AFA8-BB7A007EF8B1")
interface IDvbFrequencyListDescriptor : IUnknown
{
    HRESULT GetTag(ubyte* pbVal);
    HRESULT GetLength(ubyte* pbVal);
    HRESULT GetCodingType(ubyte* pbVal);
    HRESULT GetCountOfRecords(ubyte* pbVal);
    HRESULT GetRecordCentreFrequency(ubyte bRecordIndex, uint* pdwVal);
}

@GUID("5660A019-E75A-4B82-9B4C-ED2256D165A2")
interface IDvbPrivateDataSpecifierDescriptor : IUnknown
{
    HRESULT GetTag(ubyte* pbVal);
    HRESULT GetLength(ubyte* pbVal);
    HRESULT GetPrivateDataSpecifier(uint* pdwVal);
}

@GUID("CF1EDAFF-3FFD-4CF7-8201-35756ACBF85F")
interface IDvbLogicalChannelDescriptor : IUnknown
{
    HRESULT GetTag(ubyte* pbVal);
    HRESULT GetLength(ubyte* pbVal);
    HRESULT GetCountOfRecords(ubyte* pbVal);
    HRESULT GetRecordServiceId(ubyte bRecordIndex, ushort* pwVal);
    HRESULT GetRecordLogicalChannelNumber(ubyte bRecordIndex, ushort* pwVal);
}

@GUID("43ACA974-4BE8-4B98-BC17-9EAFD788B1D7")
interface IDvbLogicalChannelDescriptor2 : IDvbLogicalChannelDescriptor
{
    HRESULT GetRecordLogicalChannelAndVisibility(ubyte bRecordIndex, ushort* pwVal);
}

@GUID("F69C3747-8A30-4980-998C-01FE7F0BA35A")
interface IDvbLogicalChannel2Descriptor : IDvbLogicalChannelDescriptor2
{
    HRESULT GetCountOfLists(ubyte* pbVal);
    HRESULT GetListId(ubyte bListIndex, ubyte* pbVal);
    HRESULT GetListNameW(ubyte bListIndex, __MIDL___MIDL_itf_dvbsiparser_0000_0000_0001 convMode, BSTR* pbstrName);
    HRESULT GetListCountryCode(ubyte bListIndex, char* pszCode);
    HRESULT GetListCountOfRecords(ubyte bChannelListIndex, ubyte* pbVal);
    HRESULT GetListRecordServiceId(ubyte bListIndex, ubyte bRecordIndex, ushort* pwVal);
    HRESULT GetListRecordLogicalChannelNumber(ubyte bListIndex, ubyte bRecordIndex, ushort* pwVal);
    HRESULT GetListRecordLogicalChannelAndVisibility(ubyte bListIndex, ubyte bRecordIndex, ushort* pwVal);
}

@GUID("1EA8B738-A307-4680-9E26-D0A908C824F4")
interface IDvbHDSimulcastLogicalChannelDescriptor : IDvbLogicalChannelDescriptor2
{
}

@GUID("5F26F518-65C8-4048-91F2-9290F59F7B90")
interface IDvbDataBroadcastIDDescriptor : IUnknown
{
    HRESULT GetTag(ubyte* pbVal);
    HRESULT GetLength(ubyte* pbVal);
    HRESULT GetDataBroadcastID(ushort* pwVal);
    HRESULT GetIDSelectorBytes(ubyte* pbLen, ubyte* pbVal);
}

@GUID("D1EBC1D6-8B60-4C20-9CAF-E59382E7C400")
interface IDvbDataBroadcastDescriptor : IUnknown
{
    HRESULT GetTag(ubyte* pbVal);
    HRESULT GetLength(ubyte* pbVal);
    HRESULT GetDataBroadcastID(ushort* pwVal);
    HRESULT GetComponentTag(ubyte* pbVal);
    HRESULT GetSelectorLength(ubyte* pbVal);
    HRESULT GetSelectorBytes(ubyte* pbLen, ubyte* pbVal);
    HRESULT GetLangID(uint* pulVal);
    HRESULT GetTextLength(ubyte* pbVal);
    HRESULT GetText(ubyte* pbLen, ubyte* pbVal);
}

@GUID("1CDF8B31-994A-46FC-ACFD-6A6BE8934DD5")
interface IDvbLinkageDescriptor : IUnknown
{
    HRESULT GetTag(ubyte* pbVal);
    HRESULT GetLength(ubyte* pbVal);
    HRESULT GetTSId(ushort* pwVal);
    HRESULT GetONId(ushort* pwVal);
    HRESULT GetServiceId(ushort* pwVal);
    HRESULT GetLinkageType(ubyte* pbVal);
    HRESULT GetPrivateDataLength(ubyte* pbVal);
    HRESULT GetPrivateData(ubyte* pbLen, ubyte* pbData);
}

@GUID("9CD29D47-69C6-4F92-98A9-210AF1B7303A")
interface IDvbTeletextDescriptor : IUnknown
{
    HRESULT GetTag(ubyte* pbVal);
    HRESULT GetLength(ubyte* pbVal);
    HRESULT GetCountOfRecords(ubyte* pbVal);
    HRESULT GetRecordLangId(ubyte bRecordIndex, uint* pulVal);
    HRESULT GetRecordTeletextType(ubyte bRecordIndex, ubyte* pbVal);
    HRESULT GetRecordMagazineNumber(ubyte bRecordIndex, ubyte* pbVal);
    HRESULT GetRecordPageNumber(ubyte bRecordIndex, ubyte* pbVal);
}

@GUID("9B25FE1D-FA23-4E50-9784-6DF8B26F8A49")
interface IDvbSubtitlingDescriptor : IUnknown
{
    HRESULT GetTag(ubyte* pbVal);
    HRESULT GetLength(ubyte* pbVal);
    HRESULT GetCountOfRecords(ubyte* pbVal);
    HRESULT GetRecordLangId(ubyte bRecordIndex, uint* pulVal);
    HRESULT GetRecordSubtitlingType(ubyte bRecordIndex, ubyte* pbVal);
    HRESULT GetRecordCompositionPageID(ubyte bRecordIndex, ushort* pwVal);
    HRESULT GetRecordAncillaryPageID(ubyte bRecordIndex, ushort* pwVal);
}

@GUID("F9C7FBCF-E2D6-464D-B32D-2EF526E49290")
interface IDvbServiceDescriptor : IUnknown
{
    HRESULT GetTag(ubyte* pbVal);
    HRESULT GetLength(ubyte* pbVal);
    HRESULT GetServiceType(ubyte* pbVal);
    HRESULT GetServiceProviderName(byte** pszName);
    HRESULT GetServiceProviderNameW(BSTR* pbstrName);
    HRESULT GetServiceName(byte** pszName);
    HRESULT GetProcessedServiceName(BSTR* pbstrName);
    HRESULT GetServiceNameEmphasized(BSTR* pbstrName);
}

@GUID("D6C76506-85AB-487C-9B2B-36416511E4A2")
interface IDvbServiceDescriptor2 : IDvbServiceDescriptor
{
    HRESULT GetServiceProviderNameW(__MIDL___MIDL_itf_dvbsiparser_0000_0000_0001 convMode, BSTR* pbstrName);
    HRESULT GetServiceNameW(__MIDL___MIDL_itf_dvbsiparser_0000_0000_0001 convMode, BSTR* pbstrName);
}

@GUID("05DB0D8F-6008-491A-ACD3-7090952707D0")
interface IDvbServiceListDescriptor : IUnknown
{
    HRESULT GetTag(ubyte* pbVal);
    HRESULT GetLength(ubyte* pbVal);
    HRESULT GetCountOfRecords(ubyte* pbVal);
    HRESULT GetRecordServiceId(ubyte bRecordIndex, ushort* pwVal);
    HRESULT GetRecordServiceType(ubyte bRecordIndex, ubyte* pbVal);
}

@GUID("2D80433B-B32C-47EF-987F-E78EBB773E34")
interface IDvbMultilingualServiceNameDescriptor : IUnknown
{
    HRESULT GetTag(ubyte* pbVal);
    HRESULT GetLength(ubyte* pbVal);
    HRESULT GetCountOfRecords(ubyte* pbVal);
    HRESULT GetRecordLangId(ubyte bRecordIndex, uint* ulVal);
    HRESULT GetRecordServiceProviderNameW(ubyte bRecordIndex, 
                                          __MIDL___MIDL_itf_dvbsiparser_0000_0000_0001 convMode, BSTR* pbstrName);
    HRESULT GetRecordServiceNameW(ubyte bRecordIndex, __MIDL___MIDL_itf_dvbsiparser_0000_0000_0001 convMode, 
                                  BSTR* pbstrName);
}

@GUID("5B2A80CF-35B9-446C-B3E4-048B761DBC51")
interface IDvbNetworkNameDescriptor : IUnknown
{
    HRESULT GetTag(ubyte* pbVal);
    HRESULT GetLength(ubyte* pbVal);
    HRESULT GetNetworkName(byte** pszName);
    HRESULT GetNetworkNameW(__MIDL___MIDL_itf_dvbsiparser_0000_0000_0001 convMode, BSTR* pbstrName);
}

@GUID("B170BE92-5B75-458E-9C6E-B0008231491A")
interface IDvbShortEventDescriptor : IUnknown
{
    HRESULT GetTag(ubyte* pbVal);
    HRESULT GetLength(ubyte* pbVal);
    HRESULT GetLanguageCode(char* pszCode);
    HRESULT GetEventNameW(__MIDL___MIDL_itf_dvbsiparser_0000_0000_0001 convMode, BSTR* pbstrName);
    HRESULT GetTextW(__MIDL___MIDL_itf_dvbsiparser_0000_0000_0001 convMode, BSTR* pbstrText);
}

@GUID("C9B22ECA-85F4-499F-B1DB-EFA93A91EE57")
interface IDvbExtendedEventDescriptor : IUnknown
{
    HRESULT GetTag(ubyte* pbVal);
    HRESULT GetLength(ubyte* pbVal);
    HRESULT GetDescriptorNumber(ubyte* pbVal);
    HRESULT GetLastDescriptorNumber(ubyte* pbVal);
    HRESULT GetLanguageCode(char* pszCode);
    HRESULT GetCountOfRecords(ubyte* pbVal);
    HRESULT GetRecordItemW(ubyte bRecordIndex, __MIDL___MIDL_itf_dvbsiparser_0000_0000_0001 convMode, 
                           BSTR* pbstrDesc, BSTR* pbstrItem);
    HRESULT GetConcatenatedItemW(IDvbExtendedEventDescriptor pFollowingDescriptor, 
                                 __MIDL___MIDL_itf_dvbsiparser_0000_0000_0001 convMode, BSTR* pbstrDesc, 
                                 BSTR* pbstrItem);
    HRESULT GetTextW(__MIDL___MIDL_itf_dvbsiparser_0000_0000_0001 convMode, BSTR* pbstrText);
    HRESULT GetConcatenatedTextW(IDvbExtendedEventDescriptor FollowingDescriptor, 
                                 __MIDL___MIDL_itf_dvbsiparser_0000_0000_0001 convMode, BSTR* pbstrText);
    HRESULT GetRecordItemRawBytes(ubyte bRecordIndex, ubyte** ppbRawItem, ubyte* pbItemLength);
}

@GUID("91E405CF-80E7-457F-9096-1B9D1CE32141")
interface IDvbComponentDescriptor : IUnknown
{
    HRESULT GetTag(ubyte* pbVal);
    HRESULT GetLength(ubyte* pbVal);
    HRESULT GetStreamContent(ubyte* pbVal);
    HRESULT GetComponentType(ubyte* pbVal);
    HRESULT GetComponentTag(ubyte* pbVal);
    HRESULT GetLanguageCode(char* pszCode);
    HRESULT GetTextW(__MIDL___MIDL_itf_dvbsiparser_0000_0000_0001 convMode, BSTR* pbstrText);
}

@GUID("2E883881-A467-412A-9D63-6F2B6DA05BF0")
interface IDvbContentDescriptor : IUnknown
{
    HRESULT GetTag(ubyte* pbVal);
    HRESULT GetLength(ubyte* pbVal);
    HRESULT GetCountOfRecords(ubyte* pbVal);
    HRESULT GetRecordContentNibbles(ubyte bRecordIndex, ubyte* pbValLevel1, ubyte* pbValLevel2);
    HRESULT GetRecordUserNibbles(ubyte bRecordIndex, ubyte* pbVal1, ubyte* pbVal2);
}

@GUID("3AD9DDE1-FB1B-4186-937F-22E6B5A72A10")
interface IDvbParentalRatingDescriptor : IUnknown
{
    HRESULT GetTag(ubyte* pbVal);
    HRESULT GetLength(ubyte* pbVal);
    HRESULT GetCountOfRecords(ubyte* pbVal);
    HRESULT GetRecordRating(ubyte bRecordIndex, char* pszCountryCode, ubyte* pbVal);
}

@GUID("39FAE0A6-D151-44DD-A28A-765DE5991670")
interface IIsdbTerrestrialDeliverySystemDescriptor : IUnknown
{
    HRESULT GetTag(ubyte* pbVal);
    HRESULT GetLength(ubyte* pbVal);
    HRESULT GetAreaCode(ushort* pwVal);
    HRESULT GetGuardInterval(ubyte* pbVal);
    HRESULT GetTransmissionMode(ubyte* pbVal);
    HRESULT GetCountOfRecords(ubyte* pbVal);
    HRESULT GetRecordFrequency(ubyte bRecordIndex, uint* pdwVal);
}

@GUID("D7AD183E-38F5-4210-B55F-EC8D601BBD47")
interface IIsdbTSInformationDescriptor : IUnknown
{
    HRESULT GetTag(ubyte* pbVal);
    HRESULT GetLength(ubyte* pbVal);
    HRESULT GetRemoteControlKeyId(ubyte* pbVal);
    HRESULT GetTSNameW(__MIDL___MIDL_itf_dvbsiparser_0000_0000_0001 convMode, BSTR* pbstrName);
    HRESULT GetCountOfRecords(ubyte* pbVal);
    HRESULT GetRecordTransmissionTypeInfo(ubyte bRecordIndex, ubyte* pbVal);
    HRESULT GetRecordNumberOfServices(ubyte bRecordIndex, ubyte* pbVal);
    HRESULT GetRecordServiceIdByIndex(ubyte bRecordIndex, ubyte bServiceIndex, ushort* pdwVal);
}

@GUID("1A28417E-266A-4BB8-A4BD-D782BCFB8161")
interface IIsdbDigitalCopyControlDescriptor : IUnknown
{
    HRESULT GetTag(ubyte* pbVal);
    HRESULT GetLength(ubyte* pbVal);
    HRESULT GetCopyControl(ubyte* pbDigitalRecordingControlData, ubyte* pbCopyControlType, ubyte* pbAPSControlData, 
                           ubyte* pbMaximumBitrate);
    HRESULT GetCountOfRecords(ubyte* pbVal);
    HRESULT GetRecordCopyControl(ubyte bRecordIndex, ubyte* pbComponentTag, ubyte* pbDigitalRecordingControlData, 
                                 ubyte* pbCopyControlType, ubyte* pbAPSControlData, ubyte* pbMaximumBitrate);
}

@GUID("679D2002-2425-4BE4-A4C7-D6632A574F4D")
interface IIsdbAudioComponentDescriptor : IUnknown
{
    HRESULT GetTag(ubyte* pbVal);
    HRESULT GetLength(ubyte* pbVal);
    HRESULT GetStreamContent(ubyte* pbVal);
    HRESULT GetComponentType(ubyte* pbVal);
    HRESULT GetComponentTag(ubyte* pbVal);
    HRESULT GetStreamType(ubyte* pbVal);
    HRESULT GetSimulcastGroupTag(ubyte* pbVal);
    HRESULT GetESMultiLingualFlag(int* pfVal);
    HRESULT GetMainComponentFlag(int* pfVal);
    HRESULT GetQualityIndicator(ubyte* pbVal);
    HRESULT GetSamplingRate(ubyte* pbVal);
    HRESULT GetLanguageCode(char* pszCode);
    HRESULT GetLanguageCode2(char* pszCode);
    HRESULT GetTextW(__MIDL___MIDL_itf_dvbsiparser_0000_0000_0001 convMode, BSTR* pbstrText);
}

@GUID("A428100A-E646-4BD6-AA14-6087BDC08CD5")
interface IIsdbDataContentDescriptor : IUnknown
{
    HRESULT GetTag(ubyte* pbVal);
    HRESULT GetLength(ubyte* pbVal);
    HRESULT GetDataComponentId(ushort* pwVal);
    HRESULT GetEntryComponent(ubyte* pbVal);
    HRESULT GetSelectorLength(ubyte* pbVal);
    HRESULT GetSelectorBytes(ubyte bBufLength, ubyte* pbBuf);
    HRESULT GetCountOfRecords(ubyte* pbVal);
    HRESULT GetRecordComponentRef(ubyte bRecordIndex, ubyte* pbVal);
    HRESULT GetLanguageCode(char* pszCode);
    HRESULT GetTextW(__MIDL___MIDL_itf_dvbsiparser_0000_0000_0001 convMode, BSTR* pbstrText);
}

@GUID("08E18B25-A28F-4E92-821E-4FCED5CC2291")
interface IIsdbCAContractInformationDescriptor : IUnknown
{
    HRESULT GetTag(ubyte* pbVal);
    HRESULT GetLength(ubyte* pbVal);
    HRESULT GetCASystemId(ushort* pwVal);
    HRESULT GetCAUnitId(ubyte* pbVal);
    HRESULT GetCountOfRecords(ubyte* pbVal);
    HRESULT GetRecordComponentTag(ubyte bRecordIndex, ubyte* pbVal);
    HRESULT GetContractVerificationInfoLength(ubyte* pbVal);
    HRESULT GetContractVerificationInfo(ubyte bBufLength, ubyte* pbBuf);
    HRESULT GetFeeNameW(__MIDL___MIDL_itf_dvbsiparser_0000_0000_0001 convMode, BSTR* pbstrName);
}

@GUID("94B06780-2E2A-44DC-A966-CC56FDABC6C2")
interface IIsdbEventGroupDescriptor : IUnknown
{
    HRESULT GetTag(ubyte* pbVal);
    HRESULT GetLength(ubyte* pbVal);
    HRESULT GetGroupType(ubyte* pbVal);
    HRESULT GetCountOfRecords(ubyte* pbVal);
    HRESULT GetRecordEvent(ubyte bRecordIndex, ushort* pwServiceId, ushort* pwEventId);
    HRESULT GetCountOfRefRecords(ubyte* pbVal);
    HRESULT GetRefRecordEvent(ubyte bRecordIndex, ushort* pwOriginalNetworkId, ushort* pwTransportStreamId, 
                              ushort* pwServiceId, ushort* pwEventId);
}

@GUID("A494F17F-C592-47D8-8943-64C9A34BE7B9")
interface IIsdbComponentGroupDescriptor : IUnknown
{
    HRESULT GetTag(ubyte* pbVal);
    HRESULT GetLength(ubyte* pbVal);
    HRESULT GetComponentGroupType(ubyte* pbVal);
    HRESULT GetCountOfRecords(ubyte* pbVal);
    HRESULT GetRecordGroupId(ubyte bRecordIndex, ubyte* pbVal);
    HRESULT GetRecordNumberOfCAUnit(ubyte bRecordIndex, ubyte* pbVal);
    HRESULT GetRecordCAUnitCAUnitId(ubyte bRecordIndex, ubyte bCAUnitIndex, ubyte* pbVal);
    HRESULT GetRecordCAUnitNumberOfComponents(ubyte bRecordIndex, ubyte bCAUnitIndex, ubyte* pbVal);
    HRESULT GetRecordCAUnitComponentTag(ubyte bRecordIndex, ubyte bCAUnitIndex, ubyte bComponentIndex, 
                                        ubyte* pbVal);
    HRESULT GetRecordTotalBitRate(ubyte bRecordIndex, ubyte* pbVal);
    HRESULT GetRecordTextW(ubyte bRecordIndex, __MIDL___MIDL_itf_dvbsiparser_0000_0000_0001 convMode, 
                           BSTR* pbstrText);
}

@GUID("07EF6370-1660-4F26-87FC-614ADAB24B11")
interface IIsdbSeriesDescriptor : IUnknown
{
    HRESULT GetTag(ubyte* pbVal);
    HRESULT GetLength(ubyte* pbVal);
    HRESULT GetSeriesId(ushort* pwVal);
    HRESULT GetRepeatLabel(ubyte* pbVal);
    HRESULT GetProgramPattern(ubyte* pbVal);
    HRESULT GetExpireDate(int* pfValid, MPEG_DATE_AND_TIME* pmdtVal);
    HRESULT GetEpisodeNumber(ushort* pwVal);
    HRESULT GetLastEpisodeNumber(ushort* pwVal);
    HRESULT GetSeriesNameW(__MIDL___MIDL_itf_dvbsiparser_0000_0000_0001 convMode, BSTR* pbstrName);
}

@GUID("5298661E-CB88-4F5F-A1DE-5F440C185B92")
interface IIsdbDownloadContentDescriptor : IUnknown
{
    HRESULT GetTag(ubyte* pbVal);
    HRESULT GetLength(ubyte* pbVal);
    HRESULT GetFlags(int* pfReboot, int* pfAddOn, int* pfCompatibility, int* pfModuleInfo, int* pfTextInfo);
    HRESULT GetComponentSize(uint* pdwVal);
    HRESULT GetDownloadId(uint* pdwVal);
    HRESULT GetTimeOutValueDII(uint* pdwVal);
    HRESULT GetLeakRate(uint* pdwVal);
    HRESULT GetComponentTag(ubyte* pbVal);
    HRESULT GetCompatiblityDescriptorLength(ushort* pwLength);
    HRESULT GetCompatiblityDescriptor(ubyte** ppbData);
    HRESULT GetCountOfRecords(ushort* pwVal);
    HRESULT GetRecordModuleId(ushort wRecordIndex, ushort* pwVal);
    HRESULT GetRecordModuleSize(ushort wRecordIndex, uint* pdwVal);
    HRESULT GetRecordModuleInfoLength(ushort wRecordIndex, ubyte* pbVal);
    HRESULT GetRecordModuleInfo(ushort wRecordIndex, ubyte** ppbData);
    HRESULT GetTextLanguageCode(char* szCode);
    HRESULT GetTextW(__MIDL___MIDL_itf_dvbsiparser_0000_0000_0001 convMode, BSTR* pbstrName);
}

@GUID("E0103F49-4AE1-4F07-9098-756DB1FA88CD")
interface IIsdbLogoTransmissionDescriptor : IUnknown
{
    HRESULT GetTag(ubyte* pbVal);
    HRESULT GetLength(ubyte* pbVal);
    HRESULT GetLogoTransmissionType(ubyte* pbVal);
    HRESULT GetLogoId(ushort* pwVal);
    HRESULT GetLogoVersion(ushort* pwVal);
    HRESULT GetDownloadDataId(ushort* pwVal);
    HRESULT GetLogoCharW(__MIDL___MIDL_itf_dvbsiparser_0000_0000_0001 convMode, BSTR* pbstrChar);
}

@GUID("F837DC36-867C-426A-9111-F62093951A45")
interface IIsdbSIParameterDescriptor : IUnknown
{
    HRESULT GetTag(ubyte* pbVal);
    HRESULT GetLength(ubyte* pbVal);
    HRESULT GetParameterVersion(ubyte* pbVal);
    HRESULT GetUpdateTime(MPEG_DATE* pVal);
    HRESULT GetRecordNumberOfTable(ubyte* pbVal);
    HRESULT GetTableId(ubyte bRecordIndex, ubyte* pbVal);
    HRESULT GetTableDescriptionLength(ubyte bRecordIndex, ubyte* pbVal);
    HRESULT GetTableDescriptionBytes(ubyte bRecordIndex, ubyte* pbBufferLength, ubyte* pbBuffer);
}

@GUID("BA6FA681-B973-4DA1-9207-AC3E7F0341EB")
interface IIsdbEmergencyInformationDescriptor : IUnknown
{
    HRESULT GetTag(ubyte* pbVal);
    HRESULT GetLength(ubyte* pbVal);
    HRESULT GetCountOfRecords(ubyte* pbVal);
    HRESULT GetServiceId(ubyte bRecordIndex, ushort* pwVal);
    HRESULT GetStartEndFlag(ubyte bRecordIndex, ubyte* pVal);
    HRESULT GetSignalLevel(ubyte bRecordIndex, ubyte* pbVal);
    HRESULT GetAreaCode(ubyte bRecordIndex, ushort** ppwVal, ubyte* pbNumAreaCodes);
}

@GUID("0570AA47-52BC-42AE-8CA5-969F41E81AEA")
interface IIsdbCADescriptor : IUnknown
{
    HRESULT GetTag(ubyte* pbVal);
    HRESULT GetLength(ubyte* pbVal);
    HRESULT GetCASystemId(ushort* pwVal);
    HRESULT GetReservedBits(ubyte* pbVal);
    HRESULT GetCAPID(ushort* pwVal);
    HRESULT GetPrivateDataBytes(ubyte* pbBufferLength, ubyte* pbBuffer);
}

@GUID("39CBEB97-FF0B-42A7-9AB9-7B9CFE70A77A")
interface IIsdbCAServiceDescriptor : IUnknown
{
    HRESULT GetTag(ubyte* pbVal);
    HRESULT GetLength(ubyte* pbVal);
    HRESULT GetCASystemId(ushort* pwVal);
    HRESULT GetCABroadcasterGroupId(ubyte* pbVal);
    HRESULT GetMessageControl(ubyte* pbVal);
    HRESULT GetServiceIds(ubyte* pbNumServiceIds, ushort* pwServiceIds);
}

@GUID("B7B3AE90-EE0B-446D-8769-F7E2AA266AA6")
interface IIsdbHierarchicalTransmissionDescriptor : IUnknown
{
    HRESULT GetTag(ubyte* pbVal);
    HRESULT GetLength(ubyte* pbVal);
    HRESULT GetFutureUse1(ubyte* pbVal);
    HRESULT GetQualityLevel(ubyte* pbVal);
    HRESULT GetFutureUse2(ubyte* pbVal);
    HRESULT GetReferencePid(ushort* pwVal);
}

@GUID("9DE49A74-ABA2-4A18-93E1-21F17F95C3C3")
interface IPBDASiParser : IUnknown
{
    HRESULT Initialize(IUnknown punk);
    HRESULT GetEIT(uint dwSize, ubyte* pBuffer, IPBDA_EIT* ppEIT);
    HRESULT GetServices(uint dwSize, const(ubyte)* pBuffer, IPBDA_Services* ppServices);
}

@GUID("A35F2DEA-098F-4EBD-984C-2BD4C3C8CE0A")
interface IPBDA_EIT : IUnknown
{
    HRESULT Initialize(uint size, const(ubyte)* pBuffer);
    HRESULT GetTableId(ubyte* pbVal);
    HRESULT GetVersionNumber(ushort* pwVal);
    HRESULT GetServiceIdx(ulong* plwVal);
    HRESULT GetCountOfRecords(uint* pdwVal);
    HRESULT GetRecordEventId(uint dwRecordIndex, ulong* plwVal);
    HRESULT GetRecordStartTime(uint dwRecordIndex, MPEG_DATE_AND_TIME* pmdtVal);
    HRESULT GetRecordDuration(uint dwRecordIndex, MPEG_TIME* pmdVal);
    HRESULT GetRecordCountOfDescriptors(uint dwRecordIndex, uint* pdwVal);
    HRESULT GetRecordDescriptorByIndex(uint dwRecordIndex, uint dwIndex, IGenericDescriptor* ppDescriptor);
    HRESULT GetRecordDescriptorByTag(uint dwRecordIndex, ubyte bTag, uint* pdwCookie, 
                                     IGenericDescriptor* ppDescriptor);
}

@GUID("944EAB37-EED4-4850-AFD2-77E7EFEB4427")
interface IPBDA_Services : IUnknown
{
    HRESULT Initialize(uint size, ubyte* pBuffer);
    HRESULT GetCountOfRecords(uint* pdwVal);
    HRESULT GetRecordByIndex(uint dwRecordIndex, ulong* pul64ServiceIdx);
}

@GUID("22632497-0DE3-4587-AADC-D8D99017E760")
interface IPBDAEntitlementDescriptor : IUnknown
{
    HRESULT GetTag(ubyte* pbVal);
    HRESULT GetLength(ushort* pwVal);
    HRESULT GetToken(ubyte** ppbTokenBuffer, uint* pdwTokenLength);
}

@GUID("313B3620-3263-45A6-9533-968BEFBEAC03")
interface IPBDAAttributesDescriptor : IUnknown
{
    HRESULT GetTag(ubyte* pbVal);
    HRESULT GetLength(ushort* pwVal);
    HRESULT GetAttributePayload(ubyte** ppbAttributeBuffer, uint* pdwAttributeLength);
}

@GUID("DFEF4A68-EE61-415F-9CCB-CD95F2F98A3A")
interface IBDA_TIF_REGISTRATION : IUnknown
{
    HRESULT RegisterTIFEx(IPin pTIFInputPin, uint* ppvRegistrationContext, IUnknown* ppMpeg2DataControl);
    HRESULT UnregisterTIF(uint pvRegistrationContext);
}

@GUID("F9BAC2F9-4149-4916-B2EF-FAA202326862")
interface IMPEG2_TIF_CONTROL : IUnknown
{
    HRESULT RegisterTIF(IUnknown pUnkTIF, uint* ppvRegistrationContext);
    HRESULT UnregisterTIF(uint pvRegistrationContext);
    HRESULT AddPIDs(uint ulcPIDs, uint* pulPIDs);
    HRESULT DeletePIDs(uint ulcPIDs, uint* pulPIDs);
    HRESULT GetPIDCount(uint* pulcPIDs);
    HRESULT GetPIDs(uint* pulcPIDs, uint* pulPIDs);
}

@GUID("A3B152DF-7A90-4218-AC54-9830BEE8C0B6")
interface ITuneRequestInfo : IUnknown
{
    HRESULT GetLocatorData(ITuneRequest Request);
    HRESULT GetComponentData(ITuneRequest CurrentRequest);
    HRESULT CreateComponentList(ITuneRequest CurrentRequest);
    HRESULT GetNextProgram(ITuneRequest CurrentRequest, ITuneRequest* TuneRequest);
    HRESULT GetPreviousProgram(ITuneRequest CurrentRequest, ITuneRequest* TuneRequest);
    HRESULT GetNextLocator(ITuneRequest CurrentRequest, ITuneRequest* TuneRequest);
    HRESULT GetPreviousLocator(ITuneRequest CurrentRequest, ITuneRequest* TuneRequest);
}

@GUID("EE957C52-B0D0-4E78-8DD1-B87A08BFD893")
interface ITuneRequestInfoEx : ITuneRequestInfo
{
    HRESULT CreateComponentListEx(ITuneRequest CurrentRequest, IUnknown* ppCurPMT);
}

@GUID("7E47913A-5A89-423D-9A2B-E15168858934")
interface ISIInbandEPGEvent : IUnknown
{
    HRESULT SIObjectEvent(IDVB_EIT2 pIDVB_EIT, uint dwTable_ID, uint dwService_ID);
}

@GUID("F90AD9D0-B854-4B68-9CC1-B2CC96119D85")
interface ISIInbandEPG : IUnknown
{
    HRESULT StartSIEPGScan();
    HRESULT StopSIEPGScan();
    HRESULT IsSIEPGScanRunning(int* bRunning);
}

@GUID("EFDA0C80-F395-42C3-9B3C-56B37DEC7BB7")
interface IGuideDataEvent : IUnknown
{
    HRESULT GuideDataAcquired();
    HRESULT ProgramChanged(VARIANT varProgramDescriptionID);
    HRESULT ServiceChanged(VARIANT varServiceDescriptionID);
    HRESULT ScheduleEntryChanged(VARIANT varScheduleEntryDescriptionID);
    HRESULT ProgramDeleted(VARIANT varProgramDescriptionID);
    HRESULT ServiceDeleted(VARIANT varServiceDescriptionID);
    HRESULT ScheduleDeleted(VARIANT varScheduleEntryDescriptionID);
}

@GUID("88EC5E58-BB73-41D6-99CE-66C524B8B591")
interface IGuideDataProperty : IUnknown
{
    HRESULT get_Name(BSTR* pbstrName);
    HRESULT get_Language(int* idLang);
    HRESULT get_Value(VARIANT* pvar);
}

@GUID("AE44423B-4571-475C-AD2C-F40A771D80EF")
interface IEnumGuideDataProperties : IUnknown
{
    HRESULT Next(uint celt, IGuideDataProperty* ppprop, uint* pcelt);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumGuideDataProperties* ppenum);
}

@GUID("1993299C-CED6-4788-87A3-420067DCE0C7")
interface IEnumTuneRequests : IUnknown
{
    HRESULT Next(uint celt, ITuneRequest* ppprop, uint* pcelt);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumTuneRequests* ppenum);
}

@GUID("61571138-5B01-43CD-AEAF-60B784A0BF93")
interface IGuideData : IUnknown
{
    HRESULT GetServices(IEnumTuneRequests* ppEnumTuneRequests);
    HRESULT GetServiceProperties(ITuneRequest pTuneRequest, IEnumGuideDataProperties* ppEnumProperties);
    HRESULT GetGuideProgramIDs(IEnumVARIANT* pEnumPrograms);
    HRESULT GetProgramProperties(VARIANT varProgramDescriptionID, IEnumGuideDataProperties* ppEnumProperties);
    HRESULT GetScheduleEntryIDs(IEnumVARIANT* pEnumScheduleEntries);
    HRESULT GetScheduleEntryProperties(VARIANT varScheduleEntryDescriptionID, 
                                       IEnumGuideDataProperties* ppEnumProperties);
}

@GUID("4764FF7C-FA95-4525-AF4D-D32236DB9E38")
interface IGuideDataLoader : IUnknown
{
    HRESULT Init(IGuideData pGuideStore);
    HRESULT Terminate();
}

@GUID("59EFF8B9-938C-4A26-82F2-95CB84CDC837")
interface IMediaBuffer : IUnknown
{
    HRESULT SetLength(uint cbLength);
    HRESULT GetMaxLength(uint* pcbMaxLength);
    HRESULT GetBufferAndLength(ubyte** ppBuffer, uint* pcbLength);
}

@GUID("D8AD0F58-5494-4102-97C5-EC798E59BCF4")
interface IMediaObject : IUnknown
{
    HRESULT GetStreamCount(uint* pcInputStreams, uint* pcOutputStreams);
    HRESULT GetInputStreamInfo(uint dwInputStreamIndex, uint* pdwFlags);
    HRESULT GetOutputStreamInfo(uint dwOutputStreamIndex, uint* pdwFlags);
    HRESULT GetInputType(uint dwInputStreamIndex, uint dwTypeIndex, DMO_MEDIA_TYPE* pmt);
    HRESULT GetOutputType(uint dwOutputStreamIndex, uint dwTypeIndex, DMO_MEDIA_TYPE* pmt);
    HRESULT SetInputType(uint dwInputStreamIndex, const(DMO_MEDIA_TYPE)* pmt, uint dwFlags);
    HRESULT SetOutputType(uint dwOutputStreamIndex, const(DMO_MEDIA_TYPE)* pmt, uint dwFlags);
    HRESULT GetInputCurrentType(uint dwInputStreamIndex, DMO_MEDIA_TYPE* pmt);
    HRESULT GetOutputCurrentType(uint dwOutputStreamIndex, DMO_MEDIA_TYPE* pmt);
    HRESULT GetInputSizeInfo(uint dwInputStreamIndex, uint* pcbSize, uint* pcbMaxLookahead, uint* pcbAlignment);
    HRESULT GetOutputSizeInfo(uint dwOutputStreamIndex, uint* pcbSize, uint* pcbAlignment);
    HRESULT GetInputMaxLatency(uint dwInputStreamIndex, long* prtMaxLatency);
    HRESULT SetInputMaxLatency(uint dwInputStreamIndex, long rtMaxLatency);
    HRESULT Flush();
    HRESULT Discontinuity(uint dwInputStreamIndex);
    HRESULT AllocateStreamingResources();
    HRESULT FreeStreamingResources();
    HRESULT GetInputStatus(uint dwInputStreamIndex, uint* dwFlags);
    HRESULT ProcessInput(uint dwInputStreamIndex, IMediaBuffer pBuffer, uint dwFlags, long rtTimestamp, 
                         long rtTimelength);
    HRESULT ProcessOutput(uint dwFlags, uint cOutputBufferCount, char* pOutputBuffers, uint* pdwStatus);
    HRESULT Lock(int bLock);
}

@GUID("2C3CD98A-2BFA-4A53-9C27-5249BA64BA0F")
interface IEnumDMO : IUnknown
{
    HRESULT Next(uint cItemsToFetch, char* pCLSID, char* Names, uint* pcItemsFetched);
    HRESULT Skip(uint cItemsToSkip);
    HRESULT Reset();
    HRESULT Clone(IEnumDMO* ppEnum);
}

@GUID("651B9AD0-0FC7-4AA9-9538-D89931010741")
interface IMediaObjectInPlace : IUnknown
{
    HRESULT Process(uint ulSize, char* pData, long refTimeStart, uint dwFlags);
    HRESULT Clone(IMediaObjectInPlace* ppMediaObject);
    HRESULT GetLatency(long* pLatencyTime);
}

@GUID("65ABEA96-CF36-453F-AF8A-705E98F16260")
interface IDMOQualityControl : IUnknown
{
    HRESULT SetNow(long rtNow);
    HRESULT SetStatus(uint dwFlags);
    HRESULT GetStatus(uint* pdwFlags);
}

@GUID("BE8F4F4E-5B16-4D29-B350-7F6B5D9298AC")
interface IDMOVideoOutputOptimizations : IUnknown
{
    HRESULT QueryOperationModePreferences(uint ulOutputStreamIndex, uint* pdwRequestedCapabilities);
    HRESULT SetOperationMode(uint ulOutputStreamIndex, uint dwEnabledFeatures);
    HRESULT GetCurrentOperationMode(uint ulOutputStreamIndex, uint* pdwEnabledFeatures);
    HRESULT GetCurrentSampleRequirements(uint ulOutputStreamIndex, uint* pdwRequestedFeatures);
}


// GUIDs

const GUID CLSID_ANALOG_AUXIN_NETWORK_TYPE                   = GUIDOF!ANALOG_AUXIN_NETWORK_TYPE;
const GUID CLSID_ANALOG_FM_NETWORK_TYPE                      = GUIDOF!ANALOG_FM_NETWORK_TYPE;
const GUID CLSID_ANALOG_TV_NETWORK_TYPE                      = GUIDOF!ANALOG_TV_NETWORK_TYPE;
const GUID CLSID_ATSCChannelTuneRequest                      = GUIDOF!ATSCChannelTuneRequest;
const GUID CLSID_ATSCComponentType                           = GUIDOF!ATSCComponentType;
const GUID CLSID_ATSCLocator                                 = GUIDOF!ATSCLocator;
const GUID CLSID_ATSCTuningSpace                             = GUIDOF!ATSCTuningSpace;
const GUID CLSID_ATSC_TERRESTRIAL_TV_NETWORK_TYPE            = GUIDOF!ATSC_TERRESTRIAL_TV_NETWORK_TYPE;
const GUID CLSID_AnalogAudioComponentType                    = GUIDOF!AnalogAudioComponentType;
const GUID CLSID_AnalogLocator                               = GUIDOF!AnalogLocator;
const GUID CLSID_AnalogRadioTuningSpace                      = GUIDOF!AnalogRadioTuningSpace;
const GUID CLSID_AnalogTVTuningSpace                         = GUIDOF!AnalogTVTuningSpace;
const GUID CLSID_AuxInTuningSpace                            = GUIDOF!AuxInTuningSpace;
const GUID CLSID_BDA_DEBUG_DATA_AVAILABLE                    = GUIDOF!BDA_DEBUG_DATA_AVAILABLE;
const GUID CLSID_BDA_DEBUG_DATA_TYPE_STRING                  = GUIDOF!BDA_DEBUG_DATA_TYPE_STRING;
const GUID CLSID_BSKYB_TERRESTRIAL_TV_NETWORK_TYPE           = GUIDOF!BSKYB_TERRESTRIAL_TV_NETWORK_TYPE;
const GUID CLSID_BroadcastEventService                       = GUIDOF!BroadcastEventService;
const GUID CLSID_CLSID_Proxy                                 = GUIDOF!CLSID_Proxy;
const GUID CLSID_CXDSData                                    = GUIDOF!CXDSData;
const GUID CLSID_ChannelIDTuneRequest                        = GUIDOF!ChannelIDTuneRequest;
const GUID CLSID_ChannelIDTuningSpace                        = GUIDOF!ChannelIDTuningSpace;
const GUID CLSID_ChannelTuneRequest                          = GUIDOF!ChannelTuneRequest;
const GUID CLSID_Component                                   = GUIDOF!Component;
const GUID CLSID_ComponentType                               = GUIDOF!ComponentType;
const GUID CLSID_ComponentTypes                              = GUIDOF!ComponentTypes;
const GUID CLSID_Components                                  = GUIDOF!Components;
const GUID CLSID_CreatePropBagOnRegKey                       = GUIDOF!CreatePropBagOnRegKey;
const GUID CLSID_DIGITAL_CABLE_NETWORK_TYPE                  = GUIDOF!DIGITAL_CABLE_NETWORK_TYPE;
const GUID CLSID_DIRECT_TV_SATELLITE_TV_NETWORK_TYPE         = GUIDOF!DIRECT_TV_SATELLITE_TV_NETWORK_TYPE;
const GUID CLSID_DTFilter                                    = GUIDOF!DTFilter;
const GUID CLSID_DVBCLocator                                 = GUIDOF!DVBCLocator;
const GUID CLSID_DVBSLocator                                 = GUIDOF!DVBSLocator;
const GUID CLSID_DVBSTuningSpace                             = GUIDOF!DVBSTuningSpace;
const GUID CLSID_DVBTLocator                                 = GUIDOF!DVBTLocator;
const GUID CLSID_DVBTLocator2                                = GUIDOF!DVBTLocator2;
const GUID CLSID_DVBTuneRequest                              = GUIDOF!DVBTuneRequest;
const GUID CLSID_DVBTuningSpace                              = GUIDOF!DVBTuningSpace;
const GUID CLSID_DVB_CABLE_TV_NETWORK_TYPE                   = GUIDOF!DVB_CABLE_TV_NETWORK_TYPE;
const GUID CLSID_DVB_SATELLITE_TV_NETWORK_TYPE               = GUIDOF!DVB_SATELLITE_TV_NETWORK_TYPE;
const GUID CLSID_DVB_TERRESTRIAL_TV_NETWORK_TYPE             = GUIDOF!DVB_TERRESTRIAL_TV_NETWORK_TYPE;
const GUID CLSID_DigitalCableLocator                         = GUIDOF!DigitalCableLocator;
const GUID CLSID_DigitalCableTuneRequest                     = GUIDOF!DigitalCableTuneRequest;
const GUID CLSID_DigitalCableTuningSpace                     = GUIDOF!DigitalCableTuningSpace;
const GUID CLSID_DigitalLocator                              = GUIDOF!DigitalLocator;
const GUID CLSID_ECHOSTAR_SATELLITE_TV_NETWORK_TYPE          = GUIDOF!ECHOSTAR_SATELLITE_TV_NETWORK_TYPE;
const GUID CLSID_ESEventFactory                              = GUIDOF!ESEventFactory;
const GUID CLSID_ESEventService                              = GUIDOF!ESEventService;
const GUID CLSID_ETFilter                                    = GUIDOF!ETFilter;
const GUID CLSID_EVENTID_ARIBcontentSpanningEvent            = GUIDOF!EVENTID_ARIBcontentSpanningEvent;
const GUID CLSID_EVENTID_AudioDescriptorSpanningEvent        = GUIDOF!EVENTID_AudioDescriptorSpanningEvent;
const GUID CLSID_EVENTID_AudioTypeSpanningEvent              = GUIDOF!EVENTID_AudioTypeSpanningEvent;
const GUID CLSID_EVENTID_BDAConditionalAccessTAG             = GUIDOF!EVENTID_BDAConditionalAccessTAG;
const GUID CLSID_EVENTID_BDAEventingServicePendingEvent      = GUIDOF!EVENTID_BDAEventingServicePendingEvent;
const GUID CLSID_EVENTID_BDA_CASBroadcastMMI                 = GUIDOF!EVENTID_BDA_CASBroadcastMMI;
const GUID CLSID_EVENTID_BDA_CASCloseMMI                     = GUIDOF!EVENTID_BDA_CASCloseMMI;
const GUID CLSID_EVENTID_BDA_CASOpenMMI                      = GUIDOF!EVENTID_BDA_CASOpenMMI;
const GUID CLSID_EVENTID_BDA_CASReleaseTuner                 = GUIDOF!EVENTID_BDA_CASReleaseTuner;
const GUID CLSID_EVENTID_BDA_CASRequestTuner                 = GUIDOF!EVENTID_BDA_CASRequestTuner;
const GUID CLSID_EVENTID_BDA_DiseqCResponseAvailable         = GUIDOF!EVENTID_BDA_DiseqCResponseAvailable;
const GUID CLSID_EVENTID_BDA_EncoderSignalLock               = GUIDOF!EVENTID_BDA_EncoderSignalLock;
const GUID CLSID_EVENTID_BDA_FdcStatus                       = GUIDOF!EVENTID_BDA_FdcStatus;
const GUID CLSID_EVENTID_BDA_FdcTableSection                 = GUIDOF!EVENTID_BDA_FdcTableSection;
const GUID CLSID_EVENTID_BDA_GPNVValueUpdate                 = GUIDOF!EVENTID_BDA_GPNVValueUpdate;
const GUID CLSID_EVENTID_BDA_GuideDataAvailable              = GUIDOF!EVENTID_BDA_GuideDataAvailable;
const GUID CLSID_EVENTID_BDA_GuideDataError                  = GUIDOF!EVENTID_BDA_GuideDataError;
const GUID CLSID_EVENTID_BDA_GuideServiceInformationUpdated  = GUIDOF!EVENTID_BDA_GuideServiceInformationUpdated;
const GUID CLSID_EVENTID_BDA_IsdbCASResponse                 = GUIDOF!EVENTID_BDA_IsdbCASResponse;
const GUID CLSID_EVENTID_BDA_LbigsCloseConnectionHandle      = GUIDOF!EVENTID_BDA_LbigsCloseConnectionHandle;
const GUID CLSID_EVENTID_BDA_LbigsOpenConnection             = GUIDOF!EVENTID_BDA_LbigsOpenConnection;
const GUID CLSID_EVENTID_BDA_LbigsSendData                   = GUIDOF!EVENTID_BDA_LbigsSendData;
const GUID CLSID_EVENTID_BDA_RatingPinReset                  = GUIDOF!EVENTID_BDA_RatingPinReset;
const GUID CLSID_EVENTID_BDA_TransprtStreamSelectorInfo      = GUIDOF!EVENTID_BDA_TransprtStreamSelectorInfo;
const GUID CLSID_EVENTID_BDA_TunerNoSignal                   = GUIDOF!EVENTID_BDA_TunerNoSignal;
const GUID CLSID_EVENTID_BDA_TunerSignalLock                 = GUIDOF!EVENTID_BDA_TunerSignalLock;
const GUID CLSID_EVENTID_BDA_UpdateDrmStatus                 = GUIDOF!EVENTID_BDA_UpdateDrmStatus;
const GUID CLSID_EVENTID_BDA_UpdateScanState                 = GUIDOF!EVENTID_BDA_UpdateScanState;
const GUID CLSID_EVENTID_CADenialCountChanged                = GUIDOF!EVENTID_CADenialCountChanged;
const GUID CLSID_EVENTID_CASFailureSpanningEvent             = GUIDOF!EVENTID_CASFailureSpanningEvent;
const GUID CLSID_EVENTID_CSDescriptorSpanningEvent           = GUIDOF!EVENTID_CSDescriptorSpanningEvent;
const GUID CLSID_EVENTID_CandidatePostTuneData               = GUIDOF!EVENTID_CandidatePostTuneData;
const GUID CLSID_EVENTID_CardStatusChanged                   = GUIDOF!EVENTID_CardStatusChanged;
const GUID CLSID_EVENTID_ChannelChangeSpanningEvent          = GUIDOF!EVENTID_ChannelChangeSpanningEvent;
const GUID CLSID_EVENTID_ChannelInfoSpanningEvent            = GUIDOF!EVENTID_ChannelInfoSpanningEvent;
const GUID CLSID_EVENTID_ChannelTypeSpanningEvent            = GUIDOF!EVENTID_ChannelTypeSpanningEvent;
const GUID CLSID_EVENTID_CtxADescriptorSpanningEvent         = GUIDOF!EVENTID_CtxADescriptorSpanningEvent;
const GUID CLSID_EVENTID_DFNWithNoActualAVData               = GUIDOF!EVENTID_DFNWithNoActualAVData;
const GUID CLSID_EVENTID_DRMParingStatusChanged              = GUIDOF!EVENTID_DRMParingStatusChanged;
const GUID CLSID_EVENTID_DRMParingStepComplete               = GUIDOF!EVENTID_DRMParingStepComplete;
const GUID CLSID_EVENTID_DVBScramblingControlSpanningEvent   = GUIDOF!EVENTID_DVBScramblingControlSpanningEvent;
const GUID CLSID_EVENTID_DualMonoSpanningEvent               = GUIDOF!EVENTID_DualMonoSpanningEvent;
const GUID CLSID_EVENTID_DvbParentalRatingDescriptor         = GUIDOF!EVENTID_DvbParentalRatingDescriptor;
const GUID CLSID_EVENTID_EASMessageReceived                  = GUIDOF!EVENTID_EASMessageReceived;
const GUID CLSID_EVENTID_EmmMessageSpanningEvent             = GUIDOF!EVENTID_EmmMessageSpanningEvent;
const GUID CLSID_EVENTID_EntitlementChanged                  = GUIDOF!EVENTID_EntitlementChanged;
const GUID CLSID_EVENTID_LanguageSpanningEvent               = GUIDOF!EVENTID_LanguageSpanningEvent;
const GUID CLSID_EVENTID_MMIMessage                          = GUIDOF!EVENTID_MMIMessage;
const GUID CLSID_EVENTID_NewSignalAcquired                   = GUIDOF!EVENTID_NewSignalAcquired;
const GUID CLSID_EVENTID_PBDAParentalControlEvent            = GUIDOF!EVENTID_PBDAParentalControlEvent;
const GUID CLSID_EVENTID_PIDListSpanningEvent                = GUIDOF!EVENTID_PIDListSpanningEvent;
const GUID CLSID_EVENTID_PSITable                            = GUIDOF!EVENTID_PSITable;
const GUID CLSID_EVENTID_RRTSpanningEvent                    = GUIDOF!EVENTID_RRTSpanningEvent;
const GUID CLSID_EVENTID_STBChannelNumber                    = GUIDOF!EVENTID_STBChannelNumber;
const GUID CLSID_EVENTID_ServiceTerminated                   = GUIDOF!EVENTID_ServiceTerminated;
const GUID CLSID_EVENTID_SignalAndServiceStatusSpanningEvent = GUIDOF!EVENTID_SignalAndServiceStatusSpanningEvent;
const GUID CLSID_EVENTID_SignalStatusChanged                 = GUIDOF!EVENTID_SignalStatusChanged;
const GUID CLSID_EVENTID_StreamIDSpanningEvent               = GUIDOF!EVENTID_StreamIDSpanningEvent;
const GUID CLSID_EVENTID_StreamTypeSpanningEvent             = GUIDOF!EVENTID_StreamTypeSpanningEvent;
const GUID CLSID_EVENTID_SubtitleSpanningEvent               = GUIDOF!EVENTID_SubtitleSpanningEvent;
const GUID CLSID_EVENTID_TeletextSpanningEvent               = GUIDOF!EVENTID_TeletextSpanningEvent;
const GUID CLSID_EVENTID_TuneFailureEvent                    = GUIDOF!EVENTID_TuneFailureEvent;
const GUID CLSID_EVENTID_TuneFailureSpanningEvent            = GUIDOF!EVENTID_TuneFailureSpanningEvent;
const GUID CLSID_EVENTID_TuningChanged                       = GUIDOF!EVENTID_TuningChanged;
const GUID CLSID_EVENTID_TuningChanging                      = GUIDOF!EVENTID_TuningChanging;
const GUID CLSID_EVENTTYPE_CASDescrambleFailureEvent         = GUIDOF!EVENTTYPE_CASDescrambleFailureEvent;
const GUID CLSID_EvalRat                                     = GUIDOF!EvalRat;
const GUID CLSID_FilgraphManager                             = GUIDOF!FilgraphManager;
const GUID CLSID_ISDBSLocator                                = GUIDOF!ISDBSLocator;
const GUID CLSID_ISDB_CABLE_TV_NETWORK_TYPE                  = GUIDOF!ISDB_CABLE_TV_NETWORK_TYPE;
const GUID CLSID_ISDB_SATELLITE_TV_NETWORK_TYPE              = GUIDOF!ISDB_SATELLITE_TV_NETWORK_TYPE;
const GUID CLSID_ISDB_S_NETWORK_TYPE                         = GUIDOF!ISDB_S_NETWORK_TYPE;
const GUID CLSID_ISDB_TERRESTRIAL_TV_NETWORK_TYPE            = GUIDOF!ISDB_TERRESTRIAL_TV_NETWORK_TYPE;
const GUID CLSID_ISDB_T_NETWORK_TYPE                         = GUIDOF!ISDB_T_NETWORK_TYPE;
const GUID CLSID_KSCATEGORY_BDA_IP_SINK                      = GUIDOF!KSCATEGORY_BDA_IP_SINK;
const GUID CLSID_KSCATEGORY_BDA_NETWORK_EPG                  = GUIDOF!KSCATEGORY_BDA_NETWORK_EPG;
const GUID CLSID_KSCATEGORY_BDA_NETWORK_PROVIDER             = GUIDOF!KSCATEGORY_BDA_NETWORK_PROVIDER;
const GUID CLSID_KSCATEGORY_BDA_NETWORK_TUNER                = GUIDOF!KSCATEGORY_BDA_NETWORK_TUNER;
const GUID CLSID_KSCATEGORY_BDA_RECEIVER_COMPONENT           = GUIDOF!KSCATEGORY_BDA_RECEIVER_COMPONENT;
const GUID CLSID_KSCATEGORY_BDA_TRANSPORT_INFORMATION        = GUIDOF!KSCATEGORY_BDA_TRANSPORT_INFORMATION;
const GUID CLSID_KSDATAFORMAT_SPECIFIER_BDA_IP               = GUIDOF!KSDATAFORMAT_SPECIFIER_BDA_IP;
const GUID CLSID_KSDATAFORMAT_SPECIFIER_BDA_TRANSPORT        = GUIDOF!KSDATAFORMAT_SPECIFIER_BDA_TRANSPORT;
const GUID CLSID_KSDATAFORMAT_SUBTYPE_ATSC_SI                = GUIDOF!KSDATAFORMAT_SUBTYPE_ATSC_SI;
const GUID CLSID_KSDATAFORMAT_SUBTYPE_BDA_IP                 = GUIDOF!KSDATAFORMAT_SUBTYPE_BDA_IP;
const GUID CLSID_KSDATAFORMAT_SUBTYPE_BDA_IP_CONTROL         = GUIDOF!KSDATAFORMAT_SUBTYPE_BDA_IP_CONTROL;
const GUID CLSID_KSDATAFORMAT_SUBTYPE_BDA_MPEG2_TRANSPORT    = GUIDOF!KSDATAFORMAT_SUBTYPE_BDA_MPEG2_TRANSPORT;
const GUID CLSID_KSDATAFORMAT_SUBTYPE_BDA_OPENCABLE_OOB_PSIP = GUIDOF!KSDATAFORMAT_SUBTYPE_BDA_OPENCABLE_OOB_PSIP;
const GUID CLSID_KSDATAFORMAT_SUBTYPE_BDA_OPENCABLE_PSIP     = GUIDOF!KSDATAFORMAT_SUBTYPE_BDA_OPENCABLE_PSIP;
const GUID CLSID_KSDATAFORMAT_SUBTYPE_DVB_SI                 = GUIDOF!KSDATAFORMAT_SUBTYPE_DVB_SI;
const GUID CLSID_KSDATAFORMAT_SUBTYPE_ISDB_SI                = GUIDOF!KSDATAFORMAT_SUBTYPE_ISDB_SI;
const GUID CLSID_KSDATAFORMAT_SUBTYPE_PBDA_TRANSPORT_RAW     = GUIDOF!KSDATAFORMAT_SUBTYPE_PBDA_TRANSPORT_RAW;
const GUID CLSID_KSDATAFORMAT_TYPE_BDA_ANTENNA               = GUIDOF!KSDATAFORMAT_TYPE_BDA_ANTENNA;
const GUID CLSID_KSDATAFORMAT_TYPE_BDA_IF_SIGNAL             = GUIDOF!KSDATAFORMAT_TYPE_BDA_IF_SIGNAL;
const GUID CLSID_KSDATAFORMAT_TYPE_BDA_IP                    = GUIDOF!KSDATAFORMAT_TYPE_BDA_IP;
const GUID CLSID_KSDATAFORMAT_TYPE_BDA_IP_CONTROL            = GUIDOF!KSDATAFORMAT_TYPE_BDA_IP_CONTROL;
const GUID CLSID_KSDATAFORMAT_TYPE_MPE                       = GUIDOF!KSDATAFORMAT_TYPE_MPE;
const GUID CLSID_KSDATAFORMAT_TYPE_MPEG2_SECTIONS            = GUIDOF!KSDATAFORMAT_TYPE_MPEG2_SECTIONS;
const GUID CLSID_KSEVENTSETID_BdaCAEvent                     = GUIDOF!KSEVENTSETID_BdaCAEvent;
const GUID CLSID_KSEVENTSETID_BdaDiseqCEvent                 = GUIDOF!KSEVENTSETID_BdaDiseqCEvent;
const GUID CLSID_KSEVENTSETID_BdaEvent                       = GUIDOF!KSEVENTSETID_BdaEvent;
const GUID CLSID_KSEVENTSETID_BdaPinEvent                    = GUIDOF!KSEVENTSETID_BdaPinEvent;
const GUID CLSID_KSEVENTSETID_BdaTunerEvent                  = GUIDOF!KSEVENTSETID_BdaTunerEvent;
const GUID CLSID_KSMETHODSETID_BdaChangeSync                 = GUIDOF!KSMETHODSETID_BdaChangeSync;
const GUID CLSID_KSMETHODSETID_BdaConditionalAccessService   = GUIDOF!KSMETHODSETID_BdaConditionalAccessService;
const GUID CLSID_KSMETHODSETID_BdaDebug                      = GUIDOF!KSMETHODSETID_BdaDebug;
const GUID CLSID_KSMETHODSETID_BdaDeviceConfiguration        = GUIDOF!KSMETHODSETID_BdaDeviceConfiguration;
const GUID CLSID_KSMETHODSETID_BdaDrmService                 = GUIDOF!KSMETHODSETID_BdaDrmService;
const GUID CLSID_KSMETHODSETID_BdaEventing                   = GUIDOF!KSMETHODSETID_BdaEventing;
const GUID CLSID_KSMETHODSETID_BdaGuideDataDeliveryService   = GUIDOF!KSMETHODSETID_BdaGuideDataDeliveryService;
const GUID CLSID_KSMETHODSETID_BdaIsdbConditionalAccess      = GUIDOF!KSMETHODSETID_BdaIsdbConditionalAccess;
const GUID CLSID_KSMETHODSETID_BdaMux                        = GUIDOF!KSMETHODSETID_BdaMux;
const GUID CLSID_KSMETHODSETID_BdaNameValue                  = GUIDOF!KSMETHODSETID_BdaNameValue;
const GUID CLSID_KSMETHODSETID_BdaNameValueA                 = GUIDOF!KSMETHODSETID_BdaNameValueA;
const GUID CLSID_KSMETHODSETID_BdaScanning                   = GUIDOF!KSMETHODSETID_BdaScanning;
const GUID CLSID_KSMETHODSETID_BdaTSSelector                 = GUIDOF!KSMETHODSETID_BdaTSSelector;
const GUID CLSID_KSMETHODSETID_BdaTuner                      = GUIDOF!KSMETHODSETID_BdaTuner;
const GUID CLSID_KSMETHODSETID_BdaUserActivity               = GUIDOF!KSMETHODSETID_BdaUserActivity;
const GUID CLSID_KSMETHODSETID_BdaWmdrmSession               = GUIDOF!KSMETHODSETID_BdaWmdrmSession;
const GUID CLSID_KSMETHODSETID_BdaWmdrmTuner                 = GUIDOF!KSMETHODSETID_BdaWmdrmTuner;
const GUID CLSID_KSNODE_BDA_8PSK_DEMODULATOR                 = GUIDOF!KSNODE_BDA_8PSK_DEMODULATOR;
const GUID CLSID_KSNODE_BDA_8VSB_DEMODULATOR                 = GUIDOF!KSNODE_BDA_8VSB_DEMODULATOR;
const GUID CLSID_KSNODE_BDA_ANALOG_DEMODULATOR               = GUIDOF!KSNODE_BDA_ANALOG_DEMODULATOR;
const GUID CLSID_KSNODE_BDA_COFDM_DEMODULATOR                = GUIDOF!KSNODE_BDA_COFDM_DEMODULATOR;
const GUID CLSID_KSNODE_BDA_COMMON_CA_POD                    = GUIDOF!KSNODE_BDA_COMMON_CA_POD;
const GUID CLSID_KSNODE_BDA_DRI_DRM                          = GUIDOF!KSNODE_BDA_DRI_DRM;
const GUID CLSID_KSNODE_BDA_IP_SINK                          = GUIDOF!KSNODE_BDA_IP_SINK;
const GUID CLSID_KSNODE_BDA_ISDB_S_DEMODULATOR               = GUIDOF!KSNODE_BDA_ISDB_S_DEMODULATOR;
const GUID CLSID_KSNODE_BDA_ISDB_T_DEMODULATOR               = GUIDOF!KSNODE_BDA_ISDB_T_DEMODULATOR;
const GUID CLSID_KSNODE_BDA_OPENCABLE_POD                    = GUIDOF!KSNODE_BDA_OPENCABLE_POD;
const GUID CLSID_KSNODE_BDA_PBDA_CAS                         = GUIDOF!KSNODE_BDA_PBDA_CAS;
const GUID CLSID_KSNODE_BDA_PBDA_DRM                         = GUIDOF!KSNODE_BDA_PBDA_DRM;
const GUID CLSID_KSNODE_BDA_PBDA_ISDBCAS                     = GUIDOF!KSNODE_BDA_PBDA_ISDBCAS;
const GUID CLSID_KSNODE_BDA_PBDA_MUX                         = GUIDOF!KSNODE_BDA_PBDA_MUX;
const GUID CLSID_KSNODE_BDA_PBDA_TUNER                       = GUIDOF!KSNODE_BDA_PBDA_TUNER;
const GUID CLSID_KSNODE_BDA_PID_FILTER                       = GUIDOF!KSNODE_BDA_PID_FILTER;
const GUID CLSID_KSNODE_BDA_QAM_DEMODULATOR                  = GUIDOF!KSNODE_BDA_QAM_DEMODULATOR;
const GUID CLSID_KSNODE_BDA_QPSK_DEMODULATOR                 = GUIDOF!KSNODE_BDA_QPSK_DEMODULATOR;
const GUID CLSID_KSNODE_BDA_RF_TUNER                         = GUIDOF!KSNODE_BDA_RF_TUNER;
const GUID CLSID_KSNODE_BDA_TS_SELECTOR                      = GUIDOF!KSNODE_BDA_TS_SELECTOR;
const GUID CLSID_KSNODE_BDA_VIDEO_ENCODER                    = GUIDOF!KSNODE_BDA_VIDEO_ENCODER;
const GUID CLSID_KSPROPSETID_BdaAutodemodulate               = GUIDOF!KSPROPSETID_BdaAutodemodulate;
const GUID CLSID_KSPROPSETID_BdaCA                           = GUIDOF!KSPROPSETID_BdaCA;
const GUID CLSID_KSPROPSETID_BdaDigitalDemodulator           = GUIDOF!KSPROPSETID_BdaDigitalDemodulator;
const GUID CLSID_KSPROPSETID_BdaDiseqCommand                 = GUIDOF!KSPROPSETID_BdaDiseqCommand;
const GUID CLSID_KSPROPSETID_BdaEthernetFilter               = GUIDOF!KSPROPSETID_BdaEthernetFilter;
const GUID CLSID_KSPROPSETID_BdaFrequencyFilter              = GUIDOF!KSPROPSETID_BdaFrequencyFilter;
const GUID CLSID_KSPROPSETID_BdaIPv4Filter                   = GUIDOF!KSPROPSETID_BdaIPv4Filter;
const GUID CLSID_KSPROPSETID_BdaIPv6Filter                   = GUIDOF!KSPROPSETID_BdaIPv6Filter;
const GUID CLSID_KSPROPSETID_BdaLNBInfo                      = GUIDOF!KSPROPSETID_BdaLNBInfo;
const GUID CLSID_KSPROPSETID_BdaNullTransform                = GUIDOF!KSPROPSETID_BdaNullTransform;
const GUID CLSID_KSPROPSETID_BdaPIDFilter                    = GUIDOF!KSPROPSETID_BdaPIDFilter;
const GUID CLSID_KSPROPSETID_BdaPinControl                   = GUIDOF!KSPROPSETID_BdaPinControl;
const GUID CLSID_KSPROPSETID_BdaSignalStats                  = GUIDOF!KSPROPSETID_BdaSignalStats;
const GUID CLSID_KSPROPSETID_BdaTableSection                 = GUIDOF!KSPROPSETID_BdaTableSection;
const GUID CLSID_KSPROPSETID_BdaTopology                     = GUIDOF!KSPROPSETID_BdaTopology;
const GUID CLSID_KSPROPSETID_BdaVoidTransform                = GUIDOF!KSPROPSETID_BdaVoidTransform;
const GUID CLSID_LanguageComponentType                       = GUIDOF!LanguageComponentType;
const GUID CLSID_Locator                                     = GUIDOF!Locator;
const GUID CLSID_MPEG2Component                              = GUIDOF!MPEG2Component;
const GUID CLSID_MPEG2ComponentType                          = GUIDOF!MPEG2ComponentType;
const GUID CLSID_MPEG2TuneRequest                            = GUIDOF!MPEG2TuneRequest;
const GUID CLSID_MPEG2TuneRequestFactory                     = GUIDOF!MPEG2TuneRequestFactory;
const GUID CLSID_MSEventBinder                               = GUIDOF!MSEventBinder;
const GUID CLSID_MSVidAnalogCaptureToCCA                     = GUIDOF!MSVidAnalogCaptureToCCA;
const GUID CLSID_MSVidAnalogCaptureToDataServices            = GUIDOF!MSVidAnalogCaptureToDataServices;
const GUID CLSID_MSVidAnalogCaptureToOverlayMixer            = GUIDOF!MSVidAnalogCaptureToOverlayMixer;
const GUID CLSID_MSVidAnalogCaptureToStreamBufferSink        = GUIDOF!MSVidAnalogCaptureToStreamBufferSink;
const GUID CLSID_MSVidAnalogCaptureToXDS                     = GUIDOF!MSVidAnalogCaptureToXDS;
const GUID CLSID_MSVidAnalogTVToEncoder                      = GUIDOF!MSVidAnalogTVToEncoder;
const GUID CLSID_MSVidAnalogTunerDevice                      = GUIDOF!MSVidAnalogTunerDevice;
const GUID CLSID_MSVidAudioRenderer                          = GUIDOF!MSVidAudioRenderer;
const GUID CLSID_MSVidAudioRendererDevices                   = GUIDOF!MSVidAudioRendererDevices;
const GUID CLSID_MSVidBDATunerDevice                         = GUIDOF!MSVidBDATunerDevice;
const GUID CLSID_MSVidCCA                                    = GUIDOF!MSVidCCA;
const GUID CLSID_MSVidCCAToStreamBufferSink                  = GUIDOF!MSVidCCAToStreamBufferSink;
const GUID CLSID_MSVidCCToAR                                 = GUIDOF!MSVidCCToAR;
const GUID CLSID_MSVidCCToVMR                                = GUIDOF!MSVidCCToVMR;
const GUID CLSID_MSVidClosedCaptioning                       = GUIDOF!MSVidClosedCaptioning;
const GUID CLSID_MSVidClosedCaptioningSI                     = GUIDOF!MSVidClosedCaptioningSI;
const GUID CLSID_MSVidCtl                                    = GUIDOF!MSVidCtl;
const GUID CLSID_MSVidDataServices                           = GUIDOF!MSVidDataServices;
const GUID CLSID_MSVidDataServicesToStreamBufferSink         = GUIDOF!MSVidDataServicesToStreamBufferSink;
const GUID CLSID_MSVidDataServicesToXDS                      = GUIDOF!MSVidDataServicesToXDS;
const GUID CLSID_MSVidDevice                                 = GUIDOF!MSVidDevice;
const GUID CLSID_MSVidDevice2                                = GUIDOF!MSVidDevice2;
const GUID CLSID_MSVidDigitalCaptureToCCA                    = GUIDOF!MSVidDigitalCaptureToCCA;
const GUID CLSID_MSVidDigitalCaptureToITV                    = GUIDOF!MSVidDigitalCaptureToITV;
const GUID CLSID_MSVidDigitalCaptureToStreamBufferSink       = GUIDOF!MSVidDigitalCaptureToStreamBufferSink;
const GUID CLSID_MSVidEVR                                    = GUIDOF!MSVidEVR;
const GUID CLSID_MSVidEncoder                                = GUIDOF!MSVidEncoder;
const GUID CLSID_MSVidEncoderToStreamBufferSink              = GUIDOF!MSVidEncoderToStreamBufferSink;
const GUID CLSID_MSVidFeature                                = GUIDOF!MSVidFeature;
const GUID CLSID_MSVidFeatures                               = GUIDOF!MSVidFeatures;
const GUID CLSID_MSVidFilePlaybackDevice                     = GUIDOF!MSVidFilePlaybackDevice;
const GUID CLSID_MSVidFilePlaybackToAudioRenderer            = GUIDOF!MSVidFilePlaybackToAudioRenderer;
const GUID CLSID_MSVidFilePlaybackToVideoRenderer            = GUIDOF!MSVidFilePlaybackToVideoRenderer;
const GUID CLSID_MSVidGenericComposite                       = GUIDOF!MSVidGenericComposite;
const GUID CLSID_MSVidGenericSink                            = GUIDOF!MSVidGenericSink;
const GUID CLSID_MSVidITVCapture                             = GUIDOF!MSVidITVCapture;
const GUID CLSID_MSVidITVPlayback                            = GUIDOF!MSVidITVPlayback;
const GUID CLSID_MSVidITVToStreamBufferSink                  = GUIDOF!MSVidITVToStreamBufferSink;
const GUID CLSID_MSVidInputDevice                            = GUIDOF!MSVidInputDevice;
const GUID CLSID_MSVidInputDevices                           = GUIDOF!MSVidInputDevices;
const GUID CLSID_MSVidMPEG2DecoderToClosedCaptioning         = GUIDOF!MSVidMPEG2DecoderToClosedCaptioning;
const GUID CLSID_MSVidOutput                                 = GUIDOF!MSVidOutput;
const GUID CLSID_MSVidOutputDevices                          = GUIDOF!MSVidOutputDevices;
const GUID CLSID_MSVidRect                                   = GUIDOF!MSVidRect;
const GUID CLSID_MSVidSBESourceToCC                          = GUIDOF!MSVidSBESourceToCC;
const GUID CLSID_MSVidSBESourceToGenericSink                 = GUIDOF!MSVidSBESourceToGenericSink;
const GUID CLSID_MSVidSBESourceToITV                         = GUIDOF!MSVidSBESourceToITV;
const GUID CLSID_MSVidStreamBufferRecordingControl           = GUIDOF!MSVidStreamBufferRecordingControl;
const GUID CLSID_MSVidStreamBufferSink                       = GUIDOF!MSVidStreamBufferSink;
const GUID CLSID_MSVidStreamBufferSource                     = GUIDOF!MSVidStreamBufferSource;
const GUID CLSID_MSVidStreamBufferSourceToVideoRenderer      = GUIDOF!MSVidStreamBufferSourceToVideoRenderer;
const GUID CLSID_MSVidStreamBufferV2Source                   = GUIDOF!MSVidStreamBufferV2Source;
const GUID CLSID_MSVidVMR9                                   = GUIDOF!MSVidVMR9;
const GUID CLSID_MSVidVideoInputDevice                       = GUIDOF!MSVidVideoInputDevice;
const GUID CLSID_MSVidVideoPlaybackDevice                    = GUIDOF!MSVidVideoPlaybackDevice;
const GUID CLSID_MSVidVideoRenderer                          = GUIDOF!MSVidVideoRenderer;
const GUID CLSID_MSVidVideoRendererDevices                   = GUIDOF!MSVidVideoRendererDevices;
const GUID CLSID_MSVidWebDVD                                 = GUIDOF!MSVidWebDVD;
const GUID CLSID_MSVidWebDVDAdm                              = GUIDOF!MSVidWebDVDAdm;
const GUID CLSID_MSVidWebDVDToAudioRenderer                  = GUIDOF!MSVidWebDVDToAudioRenderer;
const GUID CLSID_MSVidWebDVDToVideoRenderer                  = GUIDOF!MSVidWebDVDToVideoRenderer;
const GUID CLSID_MSVidXDS                                    = GUIDOF!MSVidXDS;
const GUID CLSID_Mpeg2Data                                   = GUIDOF!Mpeg2Data;
const GUID CLSID_Mpeg2DataLib                                = GUIDOF!Mpeg2DataLib;
const GUID CLSID_Mpeg2Stream                                 = GUIDOF!Mpeg2Stream;
const GUID CLSID_PBDA_ALWAYS_TUNE_IN_MUX                     = GUIDOF!PBDA_ALWAYS_TUNE_IN_MUX;
const GUID CLSID_PINNAME_BDA_ANALOG_AUDIO                    = GUIDOF!PINNAME_BDA_ANALOG_AUDIO;
const GUID CLSID_PINNAME_BDA_ANALOG_VIDEO                    = GUIDOF!PINNAME_BDA_ANALOG_VIDEO;
const GUID CLSID_PINNAME_BDA_FM_RADIO                        = GUIDOF!PINNAME_BDA_FM_RADIO;
const GUID CLSID_PINNAME_BDA_IF_PIN                          = GUIDOF!PINNAME_BDA_IF_PIN;
const GUID CLSID_PINNAME_BDA_OPENCABLE_PSIP_PIN              = GUIDOF!PINNAME_BDA_OPENCABLE_PSIP_PIN;
const GUID CLSID_PINNAME_BDA_TRANSPORT                       = GUIDOF!PINNAME_BDA_TRANSPORT;
const GUID CLSID_PINNAME_IPSINK_INPUT                        = GUIDOF!PINNAME_IPSINK_INPUT;
const GUID CLSID_PINNAME_MPE                                 = GUIDOF!PINNAME_MPE;
const GUID CLSID_PersistTuneXmlUtility                       = GUIDOF!PersistTuneXmlUtility;
const GUID CLSID_SectionList                                 = GUIDOF!SectionList;
const GUID CLSID_SystemTuningSpaces                          = GUIDOF!SystemTuningSpaces;
const GUID CLSID_TIFLoad                                     = GUIDOF!TIFLoad;
const GUID CLSID_TuneRequest                                 = GUIDOF!TuneRequest;
const GUID CLSID_TunerMarshaler                              = GUIDOF!TunerMarshaler;
const GUID CLSID_TuningSpace                                 = GUIDOF!TuningSpace;
const GUID CLSID_XDSCodec                                    = GUIDOF!XDSCodec;
const GUID CLSID_XDSToRat                                    = GUIDOF!XDSToRat;

const GUID IID_IAMAnalogVideoDecoder                    = GUIDOF!IAMAnalogVideoDecoder;
const GUID IID_IAMAnalogVideoEncoder                    = GUIDOF!IAMAnalogVideoEncoder;
const GUID IID_IAMAsyncReaderTimestampScaling           = GUIDOF!IAMAsyncReaderTimestampScaling;
const GUID IID_IAMAudioInputMixer                       = GUIDOF!IAMAudioInputMixer;
const GUID IID_IAMAudioRendererStats                    = GUIDOF!IAMAudioRendererStats;
const GUID IID_IAMBufferNegotiation                     = GUIDOF!IAMBufferNegotiation;
const GUID IID_IAMCameraControl                         = GUIDOF!IAMCameraControl;
const GUID IID_IAMCertifiedOutputProtection             = GUIDOF!IAMCertifiedOutputProtection;
const GUID IID_IAMClockAdjust                           = GUIDOF!IAMClockAdjust;
const GUID IID_IAMClockSlave                            = GUIDOF!IAMClockSlave;
const GUID IID_IAMCollection                            = GUIDOF!IAMCollection;
const GUID IID_IAMCopyCaptureFileProgress               = GUIDOF!IAMCopyCaptureFileProgress;
const GUID IID_IAMCrossbar                              = GUIDOF!IAMCrossbar;
const GUID IID_IAMDecoderCaps                           = GUIDOF!IAMDecoderCaps;
const GUID IID_IAMDevMemoryAllocator                    = GUIDOF!IAMDevMemoryAllocator;
const GUID IID_IAMDevMemoryControl                      = GUIDOF!IAMDevMemoryControl;
const GUID IID_IAMDeviceRemoval                         = GUIDOF!IAMDeviceRemoval;
const GUID IID_IAMDroppedFrames                         = GUIDOF!IAMDroppedFrames;
const GUID IID_IAMExtDevice                             = GUIDOF!IAMExtDevice;
const GUID IID_IAMExtTransport                          = GUIDOF!IAMExtTransport;
const GUID IID_IAMFilterMiscFlags                       = GUIDOF!IAMFilterMiscFlags;
const GUID IID_IAMGraphBuilderCallback                  = GUIDOF!IAMGraphBuilderCallback;
const GUID IID_IAMGraphStreams                          = GUIDOF!IAMGraphStreams;
const GUID IID_IAMLatency                               = GUIDOF!IAMLatency;
const GUID IID_IAMMediaStream                           = GUIDOF!IAMMediaStream;
const GUID IID_IAMMediaTypeSample                       = GUIDOF!IAMMediaTypeSample;
const GUID IID_IAMMediaTypeStream                       = GUIDOF!IAMMediaTypeStream;
const GUID IID_IAMMultiMediaStream                      = GUIDOF!IAMMultiMediaStream;
const GUID IID_IAMOpenProgress                          = GUIDOF!IAMOpenProgress;
const GUID IID_IAMOverlayFX                             = GUIDOF!IAMOverlayFX;
const GUID IID_IAMPhysicalPinInfo                       = GUIDOF!IAMPhysicalPinInfo;
const GUID IID_IAMPluginControl                         = GUIDOF!IAMPluginControl;
const GUID IID_IAMPushSource                            = GUIDOF!IAMPushSource;
const GUID IID_IAMResourceControl                       = GUIDOF!IAMResourceControl;
const GUID IID_IAMStats                                 = GUIDOF!IAMStats;
const GUID IID_IAMStreamConfig                          = GUIDOF!IAMStreamConfig;
const GUID IID_IAMStreamControl                         = GUIDOF!IAMStreamControl;
const GUID IID_IAMStreamSelect                          = GUIDOF!IAMStreamSelect;
const GUID IID_IAMTVAudio                               = GUIDOF!IAMTVAudio;
const GUID IID_IAMTVAudioNotification                   = GUIDOF!IAMTVAudioNotification;
const GUID IID_IAMTVTuner                               = GUIDOF!IAMTVTuner;
const GUID IID_IAMTimecodeDisplay                       = GUIDOF!IAMTimecodeDisplay;
const GUID IID_IAMTimecodeGenerator                     = GUIDOF!IAMTimecodeGenerator;
const GUID IID_IAMTimecodeReader                        = GUIDOF!IAMTimecodeReader;
const GUID IID_IAMTuner                                 = GUIDOF!IAMTuner;
const GUID IID_IAMTunerNotification                     = GUIDOF!IAMTunerNotification;
const GUID IID_IAMVfwCaptureDialogs                     = GUIDOF!IAMVfwCaptureDialogs;
const GUID IID_IAMVfwCompressDialogs                    = GUIDOF!IAMVfwCompressDialogs;
const GUID IID_IAMVideoAccelerator                      = GUIDOF!IAMVideoAccelerator;
const GUID IID_IAMVideoAcceleratorNotify                = GUIDOF!IAMVideoAcceleratorNotify;
const GUID IID_IAMVideoCompression                      = GUIDOF!IAMVideoCompression;
const GUID IID_IAMVideoControl                          = GUIDOF!IAMVideoControl;
const GUID IID_IAMVideoDecimationProperties             = GUIDOF!IAMVideoDecimationProperties;
const GUID IID_IAMVideoProcAmp                          = GUIDOF!IAMVideoProcAmp;
const GUID IID_IAMovieSetup                             = GUIDOF!IAMovieSetup;
const GUID IID_IATSCChannelTuneRequest                  = GUIDOF!IATSCChannelTuneRequest;
const GUID IID_IATSCComponentType                       = GUIDOF!IATSCComponentType;
const GUID IID_IATSCLocator                             = GUIDOF!IATSCLocator;
const GUID IID_IATSCLocator2                            = GUIDOF!IATSCLocator2;
const GUID IID_IATSCTuningSpace                         = GUIDOF!IATSCTuningSpace;
const GUID IID_IATSC_EIT                                = GUIDOF!IATSC_EIT;
const GUID IID_IATSC_ETT                                = GUIDOF!IATSC_ETT;
const GUID IID_IATSC_MGT                                = GUIDOF!IATSC_MGT;
const GUID IID_IATSC_STT                                = GUIDOF!IATSC_STT;
const GUID IID_IATSC_VCT                                = GUIDOF!IATSC_VCT;
const GUID IID_IAnalogAudioComponentType                = GUIDOF!IAnalogAudioComponentType;
const GUID IID_IAnalogLocator                           = GUIDOF!IAnalogLocator;
const GUID IID_IAnalogRadioTuningSpace                  = GUIDOF!IAnalogRadioTuningSpace;
const GUID IID_IAnalogRadioTuningSpace2                 = GUIDOF!IAnalogRadioTuningSpace2;
const GUID IID_IAnalogTVTuningSpace                     = GUIDOF!IAnalogTVTuningSpace;
const GUID IID_IAsyncReader                             = GUIDOF!IAsyncReader;
const GUID IID_IAtscContentAdvisoryDescriptor           = GUIDOF!IAtscContentAdvisoryDescriptor;
const GUID IID_IAtscPsipParser                          = GUIDOF!IAtscPsipParser;
const GUID IID_IAttributeGet                            = GUIDOF!IAttributeGet;
const GUID IID_IAttributeSet                            = GUIDOF!IAttributeSet;
const GUID IID_IAudioData                               = GUIDOF!IAudioData;
const GUID IID_IAudioMediaStream                        = GUIDOF!IAudioMediaStream;
const GUID IID_IAudioStreamSample                       = GUIDOF!IAudioStreamSample;
const GUID IID_IAuxInTuningSpace                        = GUIDOF!IAuxInTuningSpace;
const GUID IID_IAuxInTuningSpace2                       = GUIDOF!IAuxInTuningSpace2;
const GUID IID_IBDAComparable                           = GUIDOF!IBDAComparable;
const GUID IID_IBDACreateTuneRequestEx                  = GUIDOF!IBDACreateTuneRequestEx;
const GUID IID_IBDA_AUX                                 = GUIDOF!IBDA_AUX;
const GUID IID_IBDA_AutoDemodulate                      = GUIDOF!IBDA_AutoDemodulate;
const GUID IID_IBDA_AutoDemodulateEx                    = GUIDOF!IBDA_AutoDemodulateEx;
const GUID IID_IBDA_ConditionalAccess                   = GUIDOF!IBDA_ConditionalAccess;
const GUID IID_IBDA_ConditionalAccessEx                 = GUIDOF!IBDA_ConditionalAccessEx;
const GUID IID_IBDA_DRIDRMService                       = GUIDOF!IBDA_DRIDRMService;
const GUID IID_IBDA_DRIWMDRMSession                     = GUIDOF!IBDA_DRIWMDRMSession;
const GUID IID_IBDA_DRM                                 = GUIDOF!IBDA_DRM;
const GUID IID_IBDA_DRMService                          = GUIDOF!IBDA_DRMService;
const GUID IID_IBDA_DeviceControl                       = GUIDOF!IBDA_DeviceControl;
const GUID IID_IBDA_DiagnosticProperties                = GUIDOF!IBDA_DiagnosticProperties;
const GUID IID_IBDA_DigitalDemodulator                  = GUIDOF!IBDA_DigitalDemodulator;
const GUID IID_IBDA_DigitalDemodulator2                 = GUIDOF!IBDA_DigitalDemodulator2;
const GUID IID_IBDA_DigitalDemodulator3                 = GUIDOF!IBDA_DigitalDemodulator3;
const GUID IID_IBDA_DiseqCommand                        = GUIDOF!IBDA_DiseqCommand;
const GUID IID_IBDA_EasMessage                          = GUIDOF!IBDA_EasMessage;
const GUID IID_IBDA_Encoder                             = GUIDOF!IBDA_Encoder;
const GUID IID_IBDA_EthernetFilter                      = GUIDOF!IBDA_EthernetFilter;
const GUID IID_IBDA_EventingService                     = GUIDOF!IBDA_EventingService;
const GUID IID_IBDA_FDC                                 = GUIDOF!IBDA_FDC;
const GUID IID_IBDA_FrequencyFilter                     = GUIDOF!IBDA_FrequencyFilter;
const GUID IID_IBDA_GuideDataDeliveryService            = GUIDOF!IBDA_GuideDataDeliveryService;
const GUID IID_IBDA_IPSinkControl                       = GUIDOF!IBDA_IPSinkControl;
const GUID IID_IBDA_IPSinkInfo                          = GUIDOF!IBDA_IPSinkInfo;
const GUID IID_IBDA_IPV4Filter                          = GUIDOF!IBDA_IPV4Filter;
const GUID IID_IBDA_IPV6Filter                          = GUIDOF!IBDA_IPV6Filter;
const GUID IID_IBDA_ISDBConditionalAccess               = GUIDOF!IBDA_ISDBConditionalAccess;
const GUID IID_IBDA_LNBInfo                             = GUIDOF!IBDA_LNBInfo;
const GUID IID_IBDA_MUX                                 = GUIDOF!IBDA_MUX;
const GUID IID_IBDA_NameValueService                    = GUIDOF!IBDA_NameValueService;
const GUID IID_IBDA_NetworkProvider                     = GUIDOF!IBDA_NetworkProvider;
const GUID IID_IBDA_NullTransform                       = GUIDOF!IBDA_NullTransform;
const GUID IID_IBDA_PinControl                          = GUIDOF!IBDA_PinControl;
const GUID IID_IBDA_SignalProperties                    = GUIDOF!IBDA_SignalProperties;
const GUID IID_IBDA_SignalStatistics                    = GUIDOF!IBDA_SignalStatistics;
const GUID IID_IBDA_TIF_REGISTRATION                    = GUIDOF!IBDA_TIF_REGISTRATION;
const GUID IID_IBDA_Topology                            = GUIDOF!IBDA_Topology;
const GUID IID_IBDA_TransportStreamInfo                 = GUIDOF!IBDA_TransportStreamInfo;
const GUID IID_IBDA_TransportStreamSelector             = GUIDOF!IBDA_TransportStreamSelector;
const GUID IID_IBDA_UserActivityService                 = GUIDOF!IBDA_UserActivityService;
const GUID IID_IBDA_VoidTransform                       = GUIDOF!IBDA_VoidTransform;
const GUID IID_IBDA_WMDRMSession                        = GUIDOF!IBDA_WMDRMSession;
const GUID IID_IBDA_WMDRMTuner                          = GUIDOF!IBDA_WMDRMTuner;
const GUID IID_IBPCSatelliteTuner                       = GUIDOF!IBPCSatelliteTuner;
const GUID IID_IBaseFilter                              = GUIDOF!IBaseFilter;
const GUID IID_IBasicAudio                              = GUIDOF!IBasicAudio;
const GUID IID_IBasicVideo                              = GUIDOF!IBasicVideo;
const GUID IID_IBasicVideo2                             = GUIDOF!IBasicVideo2;
const GUID IID_IBroadcastEvent                          = GUIDOF!IBroadcastEvent;
const GUID IID_IBroadcastEventEx                        = GUIDOF!IBroadcastEventEx;
const GUID IID_ICAT                                     = GUIDOF!ICAT;
const GUID IID_ICCSubStreamFiltering                    = GUIDOF!ICCSubStreamFiltering;
const GUID IID_ICameraControl                           = GUIDOF!ICameraControl;
const GUID IID_ICaptionServiceDescriptor                = GUIDOF!ICaptionServiceDescriptor;
const GUID IID_ICaptureGraphBuilder                     = GUIDOF!ICaptureGraphBuilder;
const GUID IID_ICaptureGraphBuilder2                    = GUIDOF!ICaptureGraphBuilder2;
const GUID IID_IChannelIDTuneRequest                    = GUIDOF!IChannelIDTuneRequest;
const GUID IID_IChannelTuneRequest                      = GUIDOF!IChannelTuneRequest;
const GUID IID_IComponent                               = GUIDOF!IComponent;
const GUID IID_IComponentType                           = GUIDOF!IComponentType;
const GUID IID_IComponentTypes                          = GUIDOF!IComponentTypes;
const GUID IID_IComponents                              = GUIDOF!IComponents;
const GUID IID_IComponentsOld                           = GUIDOF!IComponentsOld;
const GUID IID_IConfigAsfWriter                         = GUIDOF!IConfigAsfWriter;
const GUID IID_IConfigAsfWriter2                        = GUIDOF!IConfigAsfWriter2;
const GUID IID_IConfigAviMux                            = GUIDOF!IConfigAviMux;
const GUID IID_IConfigInterleaving                      = GUIDOF!IConfigInterleaving;
const GUID IID_ICreateDevEnum                           = GUIDOF!ICreateDevEnum;
const GUID IID_ICreatePropBagOnRegKey                   = GUIDOF!ICreatePropBagOnRegKey;
const GUID IID_IDDrawExclModeVideo                      = GUIDOF!IDDrawExclModeVideo;
const GUID IID_IDDrawExclModeVideoCallback              = GUIDOF!IDDrawExclModeVideoCallback;
const GUID IID_IDMOQualityControl                       = GUIDOF!IDMOQualityControl;
const GUID IID_IDMOVideoOutputOptimizations             = GUIDOF!IDMOVideoOutputOptimizations;
const GUID IID_IDMOWrapperFilter                        = GUIDOF!IDMOWrapperFilter;
const GUID IID_IDTFilter                                = GUIDOF!IDTFilter;
const GUID IID_IDTFilter2                               = GUIDOF!IDTFilter2;
const GUID IID_IDTFilter3                               = GUIDOF!IDTFilter3;
const GUID IID_IDTFilterConfig                          = GUIDOF!IDTFilterConfig;
const GUID IID_IDTFilterEvents                          = GUIDOF!IDTFilterEvents;
const GUID IID_IDTFilterLicenseRenewal                  = GUIDOF!IDTFilterLicenseRenewal;
const GUID IID_IDVBCLocator                             = GUIDOF!IDVBCLocator;
const GUID IID_IDVBSLocator                             = GUIDOF!IDVBSLocator;
const GUID IID_IDVBSLocator2                            = GUIDOF!IDVBSLocator2;
const GUID IID_IDVBSTuningSpace                         = GUIDOF!IDVBSTuningSpace;
const GUID IID_IDVBTLocator                             = GUIDOF!IDVBTLocator;
const GUID IID_IDVBTLocator2                            = GUIDOF!IDVBTLocator2;
const GUID IID_IDVBTuneRequest                          = GUIDOF!IDVBTuneRequest;
const GUID IID_IDVBTuningSpace                          = GUIDOF!IDVBTuningSpace;
const GUID IID_IDVBTuningSpace2                         = GUIDOF!IDVBTuningSpace2;
const GUID IID_IDVB_BAT                                 = GUIDOF!IDVB_BAT;
const GUID IID_IDVB_DIT                                 = GUIDOF!IDVB_DIT;
const GUID IID_IDVB_EIT                                 = GUIDOF!IDVB_EIT;
const GUID IID_IDVB_EIT2                                = GUIDOF!IDVB_EIT2;
const GUID IID_IDVB_NIT                                 = GUIDOF!IDVB_NIT;
const GUID IID_IDVB_RST                                 = GUIDOF!IDVB_RST;
const GUID IID_IDVB_SDT                                 = GUIDOF!IDVB_SDT;
const GUID IID_IDVB_SIT                                 = GUIDOF!IDVB_SIT;
const GUID IID_IDVB_ST                                  = GUIDOF!IDVB_ST;
const GUID IID_IDVB_TDT                                 = GUIDOF!IDVB_TDT;
const GUID IID_IDVB_TOT                                 = GUIDOF!IDVB_TOT;
const GUID IID_IDVEnc                                   = GUIDOF!IDVEnc;
const GUID IID_IDVRGB219                                = GUIDOF!IDVRGB219;
const GUID IID_IDVSplitter                              = GUIDOF!IDVSplitter;
const GUID IID_IDecimateVideoImage                      = GUIDOF!IDecimateVideoImage;
const GUID IID_IDeferredCommand                         = GUIDOF!IDeferredCommand;
const GUID IID_IDigitalCableLocator                     = GUIDOF!IDigitalCableLocator;
const GUID IID_IDigitalCableTuneRequest                 = GUIDOF!IDigitalCableTuneRequest;
const GUID IID_IDigitalCableTuningSpace                 = GUIDOF!IDigitalCableTuningSpace;
const GUID IID_IDigitalLocator                          = GUIDOF!IDigitalLocator;
const GUID IID_IDirectDrawMediaSample                   = GUIDOF!IDirectDrawMediaSample;
const GUID IID_IDirectDrawMediaSampleAllocator          = GUIDOF!IDirectDrawMediaSampleAllocator;
const GUID IID_IDirectDrawMediaStream                   = GUIDOF!IDirectDrawMediaStream;
const GUID IID_IDirectDrawStreamSample                  = GUIDOF!IDirectDrawStreamSample;
const GUID IID_IDistributorNotify                       = GUIDOF!IDistributorNotify;
const GUID IID_IDrawVideoImage                          = GUIDOF!IDrawVideoImage;
const GUID IID_IDvbCableDeliverySystemDescriptor        = GUIDOF!IDvbCableDeliverySystemDescriptor;
const GUID IID_IDvbComponentDescriptor                  = GUIDOF!IDvbComponentDescriptor;
const GUID IID_IDvbContentDescriptor                    = GUIDOF!IDvbContentDescriptor;
const GUID IID_IDvbContentIdentifierDescriptor          = GUIDOF!IDvbContentIdentifierDescriptor;
const GUID IID_IDvbDataBroadcastDescriptor              = GUIDOF!IDvbDataBroadcastDescriptor;
const GUID IID_IDvbDataBroadcastIDDescriptor            = GUIDOF!IDvbDataBroadcastIDDescriptor;
const GUID IID_IDvbDefaultAuthorityDescriptor           = GUIDOF!IDvbDefaultAuthorityDescriptor;
const GUID IID_IDvbExtendedEventDescriptor              = GUIDOF!IDvbExtendedEventDescriptor;
const GUID IID_IDvbFrequencyListDescriptor              = GUIDOF!IDvbFrequencyListDescriptor;
const GUID IID_IDvbHDSimulcastLogicalChannelDescriptor  = GUIDOF!IDvbHDSimulcastLogicalChannelDescriptor;
const GUID IID_IDvbLinkageDescriptor                    = GUIDOF!IDvbLinkageDescriptor;
const GUID IID_IDvbLogicalChannel2Descriptor            = GUIDOF!IDvbLogicalChannel2Descriptor;
const GUID IID_IDvbLogicalChannelDescriptor             = GUIDOF!IDvbLogicalChannelDescriptor;
const GUID IID_IDvbLogicalChannelDescriptor2            = GUIDOF!IDvbLogicalChannelDescriptor2;
const GUID IID_IDvbMultilingualServiceNameDescriptor    = GUIDOF!IDvbMultilingualServiceNameDescriptor;
const GUID IID_IDvbNetworkNameDescriptor                = GUIDOF!IDvbNetworkNameDescriptor;
const GUID IID_IDvbParentalRatingDescriptor             = GUIDOF!IDvbParentalRatingDescriptor;
const GUID IID_IDvbPrivateDataSpecifierDescriptor       = GUIDOF!IDvbPrivateDataSpecifierDescriptor;
const GUID IID_IDvbSatelliteDeliverySystemDescriptor    = GUIDOF!IDvbSatelliteDeliverySystemDescriptor;
const GUID IID_IDvbServiceAttributeDescriptor           = GUIDOF!IDvbServiceAttributeDescriptor;
const GUID IID_IDvbServiceDescriptor                    = GUIDOF!IDvbServiceDescriptor;
const GUID IID_IDvbServiceDescriptor2                   = GUIDOF!IDvbServiceDescriptor2;
const GUID IID_IDvbServiceListDescriptor                = GUIDOF!IDvbServiceListDescriptor;
const GUID IID_IDvbShortEventDescriptor                 = GUIDOF!IDvbShortEventDescriptor;
const GUID IID_IDvbSiParser                             = GUIDOF!IDvbSiParser;
const GUID IID_IDvbSiParser2                            = GUIDOF!IDvbSiParser2;
const GUID IID_IDvbSubtitlingDescriptor                 = GUIDOF!IDvbSubtitlingDescriptor;
const GUID IID_IDvbTeletextDescriptor                   = GUIDOF!IDvbTeletextDescriptor;
const GUID IID_IDvbTerrestrial2DeliverySystemDescriptor = GUIDOF!IDvbTerrestrial2DeliverySystemDescriptor;
const GUID IID_IDvbTerrestrialDeliverySystemDescriptor  = GUIDOF!IDvbTerrestrialDeliverySystemDescriptor;
const GUID IID_IDvdCmd                                  = GUIDOF!IDvdCmd;
const GUID IID_IDvdControl                              = GUIDOF!IDvdControl;
const GUID IID_IDvdControl2                             = GUIDOF!IDvdControl2;
const GUID IID_IDvdGraphBuilder                         = GUIDOF!IDvdGraphBuilder;
const GUID IID_IDvdInfo                                 = GUIDOF!IDvdInfo;
const GUID IID_IDvdInfo2                                = GUIDOF!IDvdInfo2;
const GUID IID_IDvdState                                = GUIDOF!IDvdState;
const GUID IID_IESCloseMmiEvent                         = GUIDOF!IESCloseMmiEvent;
const GUID IID_IESEvent                                 = GUIDOF!IESEvent;
const GUID IID_IESEventFactory                          = GUIDOF!IESEventFactory;
const GUID IID_IESEventService                          = GUIDOF!IESEventService;
const GUID IID_IESEventServiceConfiguration             = GUIDOF!IESEventServiceConfiguration;
const GUID IID_IESEvents                                = GUIDOF!IESEvents;
const GUID IID_IESFileExpiryDateEvent                   = GUIDOF!IESFileExpiryDateEvent;
const GUID IID_IESIsdbCasResponseEvent                  = GUIDOF!IESIsdbCasResponseEvent;
const GUID IID_IESLicenseRenewalResultEvent             = GUIDOF!IESLicenseRenewalResultEvent;
const GUID IID_IESOpenMmiEvent                          = GUIDOF!IESOpenMmiEvent;
const GUID IID_IESRequestTunerEvent                     = GUIDOF!IESRequestTunerEvent;
const GUID IID_IESValueUpdatedEvent                     = GUIDOF!IESValueUpdatedEvent;
const GUID IID_IETFilter                                = GUIDOF!IETFilter;
const GUID IID_IETFilterConfig                          = GUIDOF!IETFilterConfig;
const GUID IID_IETFilterEvents                          = GUIDOF!IETFilterEvents;
const GUID IID_IEncoderAPI                              = GUIDOF!IEncoderAPI;
const GUID IID_IEnumComponentTypes                      = GUIDOF!IEnumComponentTypes;
const GUID IID_IEnumComponents                          = GUIDOF!IEnumComponents;
const GUID IID_IEnumDMO                                 = GUIDOF!IEnumDMO;
const GUID IID_IEnumFilters                             = GUIDOF!IEnumFilters;
const GUID IID_IEnumGuideDataProperties                 = GUIDOF!IEnumGuideDataProperties;
const GUID IID_IEnumMSVidGraphSegment                   = GUIDOF!IEnumMSVidGraphSegment;
const GUID IID_IEnumMediaTypes                          = GUIDOF!IEnumMediaTypes;
const GUID IID_IEnumPIDMap                              = GUIDOF!IEnumPIDMap;
const GUID IID_IEnumPins                                = GUIDOF!IEnumPins;
const GUID IID_IEnumRegFilters                          = GUIDOF!IEnumRegFilters;
const GUID IID_IEnumStreamBufferRecordingAttrib         = GUIDOF!IEnumStreamBufferRecordingAttrib;
const GUID IID_IEnumStreamIdMap                         = GUIDOF!IEnumStreamIdMap;
const GUID IID_IEnumTuneRequests                        = GUIDOF!IEnumTuneRequests;
const GUID IID_IEnumTuningSpaces                        = GUIDOF!IEnumTuningSpaces;
const GUID IID_IEvalRat                                 = GUIDOF!IEvalRat;
const GUID IID_IFileSinkFilter                          = GUIDOF!IFileSinkFilter;
const GUID IID_IFileSinkFilter2                         = GUIDOF!IFileSinkFilter2;
const GUID IID_IFileSourceFilter                        = GUIDOF!IFileSourceFilter;
const GUID IID_IFilterChain                             = GUIDOF!IFilterChain;
const GUID IID_IFilterGraph                             = GUIDOF!IFilterGraph;
const GUID IID_IFilterGraph2                            = GUIDOF!IFilterGraph2;
const GUID IID_IFilterGraph3                            = GUIDOF!IFilterGraph3;
const GUID IID_IFilterInfo                              = GUIDOF!IFilterInfo;
const GUID IID_IFilterMapper                            = GUIDOF!IFilterMapper;
const GUID IID_IFilterMapper2                           = GUIDOF!IFilterMapper2;
const GUID IID_IFilterMapper3                           = GUIDOF!IFilterMapper3;
const GUID IID_IFrequencyMap                            = GUIDOF!IFrequencyMap;
const GUID IID_IGenericDescriptor                       = GUIDOF!IGenericDescriptor;
const GUID IID_IGenericDescriptor2                      = GUIDOF!IGenericDescriptor2;
const GUID IID_IGetCapabilitiesKey                      = GUIDOF!IGetCapabilitiesKey;
const GUID IID_IGpnvsCommonBase                         = GUIDOF!IGpnvsCommonBase;
const GUID IID_IGraphBuilder                            = GUIDOF!IGraphBuilder;
const GUID IID_IGraphConfig                             = GUIDOF!IGraphConfig;
const GUID IID_IGraphConfigCallback                     = GUIDOF!IGraphConfigCallback;
const GUID IID_IGraphVersion                            = GUIDOF!IGraphVersion;
const GUID IID_IGuideData                               = GUIDOF!IGuideData;
const GUID IID_IGuideDataEvent                          = GUIDOF!IGuideDataEvent;
const GUID IID_IGuideDataLoader                         = GUIDOF!IGuideDataLoader;
const GUID IID_IGuideDataProperty                       = GUIDOF!IGuideDataProperty;
const GUID IID_IIPDVDec                                 = GUIDOF!IIPDVDec;
const GUID IID_IISDBSLocator                            = GUIDOF!IISDBSLocator;
const GUID IID_IISDB_BIT                                = GUIDOF!IISDB_BIT;
const GUID IID_IISDB_CDT                                = GUIDOF!IISDB_CDT;
const GUID IID_IISDB_EMM                                = GUIDOF!IISDB_EMM;
const GUID IID_IISDB_LDT                                = GUIDOF!IISDB_LDT;
const GUID IID_IISDB_NBIT                               = GUIDOF!IISDB_NBIT;
const GUID IID_IISDB_SDT                                = GUIDOF!IISDB_SDT;
const GUID IID_IISDB_SDTT                               = GUIDOF!IISDB_SDTT;
const GUID IID_IIsdbAudioComponentDescriptor            = GUIDOF!IIsdbAudioComponentDescriptor;
const GUID IID_IIsdbCAContractInformationDescriptor     = GUIDOF!IIsdbCAContractInformationDescriptor;
const GUID IID_IIsdbCADescriptor                        = GUIDOF!IIsdbCADescriptor;
const GUID IID_IIsdbCAServiceDescriptor                 = GUIDOF!IIsdbCAServiceDescriptor;
const GUID IID_IIsdbComponentGroupDescriptor            = GUIDOF!IIsdbComponentGroupDescriptor;
const GUID IID_IIsdbDataContentDescriptor               = GUIDOF!IIsdbDataContentDescriptor;
const GUID IID_IIsdbDigitalCopyControlDescriptor        = GUIDOF!IIsdbDigitalCopyControlDescriptor;
const GUID IID_IIsdbDownloadContentDescriptor           = GUIDOF!IIsdbDownloadContentDescriptor;
const GUID IID_IIsdbEmergencyInformationDescriptor      = GUIDOF!IIsdbEmergencyInformationDescriptor;
const GUID IID_IIsdbEventGroupDescriptor                = GUIDOF!IIsdbEventGroupDescriptor;
const GUID IID_IIsdbHierarchicalTransmissionDescriptor  = GUIDOF!IIsdbHierarchicalTransmissionDescriptor;
const GUID IID_IIsdbLogoTransmissionDescriptor          = GUIDOF!IIsdbLogoTransmissionDescriptor;
const GUID IID_IIsdbSIParameterDescriptor               = GUIDOF!IIsdbSIParameterDescriptor;
const GUID IID_IIsdbSeriesDescriptor                    = GUIDOF!IIsdbSeriesDescriptor;
const GUID IID_IIsdbSiParser2                           = GUIDOF!IIsdbSiParser2;
const GUID IID_IIsdbTSInformationDescriptor             = GUIDOF!IIsdbTSInformationDescriptor;
const GUID IID_IIsdbTerrestrialDeliverySystemDescriptor = GUIDOF!IIsdbTerrestrialDeliverySystemDescriptor;
const GUID IID_IKsAggregateControl                      = GUIDOF!IKsAggregateControl;
const GUID IID_IKsControl                               = GUIDOF!IKsControl;
const GUID IID_IKsNodeControl                           = GUIDOF!IKsNodeControl;
const GUID IID_IKsPropertySet                           = GUIDOF!IKsPropertySet;
const GUID IID_IKsTopology                              = GUIDOF!IKsTopology;
const GUID IID_IKsTopologyInfo                          = GUIDOF!IKsTopologyInfo;
const GUID IID_ILanguageComponentType                   = GUIDOF!ILanguageComponentType;
const GUID IID_ILocator                                 = GUIDOF!ILocator;
const GUID IID_IMPEG2Component                          = GUIDOF!IMPEG2Component;
const GUID IID_IMPEG2ComponentType                      = GUIDOF!IMPEG2ComponentType;
const GUID IID_IMPEG2PIDMap                             = GUIDOF!IMPEG2PIDMap;
const GUID IID_IMPEG2StreamIdMap                        = GUIDOF!IMPEG2StreamIdMap;
const GUID IID_IMPEG2TuneRequest                        = GUIDOF!IMPEG2TuneRequest;
const GUID IID_IMPEG2TuneRequestFactory                 = GUIDOF!IMPEG2TuneRequestFactory;
const GUID IID_IMPEG2TuneRequestSupport                 = GUIDOF!IMPEG2TuneRequestSupport;
const GUID IID_IMPEG2_TIF_CONTROL                       = GUIDOF!IMPEG2_TIF_CONTROL;
const GUID IID_IMSEventBinder                           = GUIDOF!IMSEventBinder;
const GUID IID_IMSVidAnalogTuner                        = GUIDOF!IMSVidAnalogTuner;
const GUID IID_IMSVidAnalogTuner2                       = GUIDOF!IMSVidAnalogTuner2;
const GUID IID_IMSVidAnalogTunerEvent                   = GUIDOF!IMSVidAnalogTunerEvent;
const GUID IID_IMSVidAudioRenderer                      = GUIDOF!IMSVidAudioRenderer;
const GUID IID_IMSVidAudioRendererDevices               = GUIDOF!IMSVidAudioRendererDevices;
const GUID IID_IMSVidAudioRendererEvent                 = GUIDOF!IMSVidAudioRendererEvent;
const GUID IID_IMSVidAudioRendererEvent2                = GUIDOF!IMSVidAudioRendererEvent2;
const GUID IID_IMSVidClosedCaptioning                   = GUIDOF!IMSVidClosedCaptioning;
const GUID IID_IMSVidClosedCaptioning2                  = GUIDOF!IMSVidClosedCaptioning2;
const GUID IID_IMSVidClosedCaptioning3                  = GUIDOF!IMSVidClosedCaptioning3;
const GUID IID_IMSVidCompositionSegment                 = GUIDOF!IMSVidCompositionSegment;
const GUID IID_IMSVidCtl                                = GUIDOF!IMSVidCtl;
const GUID IID_IMSVidDataServices                       = GUIDOF!IMSVidDataServices;
const GUID IID_IMSVidDataServicesEvent                  = GUIDOF!IMSVidDataServicesEvent;
const GUID IID_IMSVidDevice                             = GUIDOF!IMSVidDevice;
const GUID IID_IMSVidDevice2                            = GUIDOF!IMSVidDevice2;
const GUID IID_IMSVidDeviceEvent                        = GUIDOF!IMSVidDeviceEvent;
const GUID IID_IMSVidEVR                                = GUIDOF!IMSVidEVR;
const GUID IID_IMSVidEVREvent                           = GUIDOF!IMSVidEVREvent;
const GUID IID_IMSVidEncoder                            = GUIDOF!IMSVidEncoder;
const GUID IID_IMSVidFeature                            = GUIDOF!IMSVidFeature;
const GUID IID_IMSVidFeatureEvent                       = GUIDOF!IMSVidFeatureEvent;
const GUID IID_IMSVidFeatures                           = GUIDOF!IMSVidFeatures;
const GUID IID_IMSVidFilePlayback                       = GUIDOF!IMSVidFilePlayback;
const GUID IID_IMSVidFilePlayback2                      = GUIDOF!IMSVidFilePlayback2;
const GUID IID_IMSVidFilePlaybackEvent                  = GUIDOF!IMSVidFilePlaybackEvent;
const GUID IID_IMSVidGenericSink                        = GUIDOF!IMSVidGenericSink;
const GUID IID_IMSVidGenericSink2                       = GUIDOF!IMSVidGenericSink2;
const GUID IID_IMSVidGraphSegment                       = GUIDOF!IMSVidGraphSegment;
const GUID IID_IMSVidGraphSegmentContainer              = GUIDOF!IMSVidGraphSegmentContainer;
const GUID IID_IMSVidGraphSegmentUserInput              = GUIDOF!IMSVidGraphSegmentUserInput;
const GUID IID_IMSVidInputDevice                        = GUIDOF!IMSVidInputDevice;
const GUID IID_IMSVidInputDeviceEvent                   = GUIDOF!IMSVidInputDeviceEvent;
const GUID IID_IMSVidInputDevices                       = GUIDOF!IMSVidInputDevices;
const GUID IID_IMSVidOutputDevice                       = GUIDOF!IMSVidOutputDevice;
const GUID IID_IMSVidOutputDeviceEvent                  = GUIDOF!IMSVidOutputDeviceEvent;
const GUID IID_IMSVidOutputDevices                      = GUIDOF!IMSVidOutputDevices;
const GUID IID_IMSVidPlayback                           = GUIDOF!IMSVidPlayback;
const GUID IID_IMSVidPlaybackEvent                      = GUIDOF!IMSVidPlaybackEvent;
const GUID IID_IMSVidRect                               = GUIDOF!IMSVidRect;
const GUID IID_IMSVidStreamBufferRecordingControl       = GUIDOF!IMSVidStreamBufferRecordingControl;
const GUID IID_IMSVidStreamBufferSink                   = GUIDOF!IMSVidStreamBufferSink;
const GUID IID_IMSVidStreamBufferSink2                  = GUIDOF!IMSVidStreamBufferSink2;
const GUID IID_IMSVidStreamBufferSink3                  = GUIDOF!IMSVidStreamBufferSink3;
const GUID IID_IMSVidStreamBufferSinkEvent              = GUIDOF!IMSVidStreamBufferSinkEvent;
const GUID IID_IMSVidStreamBufferSinkEvent2             = GUIDOF!IMSVidStreamBufferSinkEvent2;
const GUID IID_IMSVidStreamBufferSinkEvent3             = GUIDOF!IMSVidStreamBufferSinkEvent3;
const GUID IID_IMSVidStreamBufferSinkEvent4             = GUIDOF!IMSVidStreamBufferSinkEvent4;
const GUID IID_IMSVidStreamBufferSource                 = GUIDOF!IMSVidStreamBufferSource;
const GUID IID_IMSVidStreamBufferSource2                = GUIDOF!IMSVidStreamBufferSource2;
const GUID IID_IMSVidStreamBufferSourceEvent            = GUIDOF!IMSVidStreamBufferSourceEvent;
const GUID IID_IMSVidStreamBufferSourceEvent2           = GUIDOF!IMSVidStreamBufferSourceEvent2;
const GUID IID_IMSVidStreamBufferSourceEvent3           = GUIDOF!IMSVidStreamBufferSourceEvent3;
const GUID IID_IMSVidStreamBufferV2SourceEvent          = GUIDOF!IMSVidStreamBufferV2SourceEvent;
const GUID IID_IMSVidTuner                              = GUIDOF!IMSVidTuner;
const GUID IID_IMSVidTunerEvent                         = GUIDOF!IMSVidTunerEvent;
const GUID IID_IMSVidVMR9                               = GUIDOF!IMSVidVMR9;
const GUID IID_IMSVidVRGraphSegment                     = GUIDOF!IMSVidVRGraphSegment;
const GUID IID_IMSVidVideoInputDevice                   = GUIDOF!IMSVidVideoInputDevice;
const GUID IID_IMSVidVideoRenderer                      = GUIDOF!IMSVidVideoRenderer;
const GUID IID_IMSVidVideoRenderer2                     = GUIDOF!IMSVidVideoRenderer2;
const GUID IID_IMSVidVideoRendererDevices               = GUIDOF!IMSVidVideoRendererDevices;
const GUID IID_IMSVidVideoRendererEvent                 = GUIDOF!IMSVidVideoRendererEvent;
const GUID IID_IMSVidVideoRendererEvent2                = GUIDOF!IMSVidVideoRendererEvent2;
const GUID IID_IMSVidWebDVD                             = GUIDOF!IMSVidWebDVD;
const GUID IID_IMSVidWebDVD2                            = GUIDOF!IMSVidWebDVD2;
const GUID IID_IMSVidWebDVDAdm                          = GUIDOF!IMSVidWebDVDAdm;
const GUID IID_IMSVidWebDVDEvent                        = GUIDOF!IMSVidWebDVDEvent;
const GUID IID_IMSVidXDS                                = GUIDOF!IMSVidXDS;
const GUID IID_IMSVidXDSEvent                           = GUIDOF!IMSVidXDSEvent;
const GUID IID_IMceBurnerControl                        = GUIDOF!IMceBurnerControl;
const GUID IID_IMediaBuffer                             = GUIDOF!IMediaBuffer;
const GUID IID_IMediaControl                            = GUIDOF!IMediaControl;
const GUID IID_IMediaEvent                              = GUIDOF!IMediaEvent;
const GUID IID_IMediaEventEx                            = GUIDOF!IMediaEventEx;
const GUID IID_IMediaEventSink                          = GUIDOF!IMediaEventSink;
const GUID IID_IMediaFilter                             = GUIDOF!IMediaFilter;
const GUID IID_IMediaObject                             = GUIDOF!IMediaObject;
const GUID IID_IMediaObjectInPlace                      = GUIDOF!IMediaObjectInPlace;
const GUID IID_IMediaParamInfo                          = GUIDOF!IMediaParamInfo;
const GUID IID_IMediaParams                             = GUIDOF!IMediaParams;
const GUID IID_IMediaPosition                           = GUIDOF!IMediaPosition;
const GUID IID_IMediaPropertyBag                        = GUIDOF!IMediaPropertyBag;
const GUID IID_IMediaSample                             = GUIDOF!IMediaSample;
const GUID IID_IMediaSample2                            = GUIDOF!IMediaSample2;
const GUID IID_IMediaSample2Config                      = GUIDOF!IMediaSample2Config;
const GUID IID_IMediaSeeking                            = GUIDOF!IMediaSeeking;
const GUID IID_IMediaStream                             = GUIDOF!IMediaStream;
const GUID IID_IMediaStreamFilter                       = GUIDOF!IMediaStreamFilter;
const GUID IID_IMediaTypeInfo                           = GUIDOF!IMediaTypeInfo;
const GUID IID_IMemAllocator                            = GUIDOF!IMemAllocator;
const GUID IID_IMemAllocatorCallbackTemp                = GUIDOF!IMemAllocatorCallbackTemp;
const GUID IID_IMemAllocatorNotifyCallbackTemp          = GUIDOF!IMemAllocatorNotifyCallbackTemp;
const GUID IID_IMemInputPin                             = GUIDOF!IMemInputPin;
const GUID IID_IMemoryData                              = GUIDOF!IMemoryData;
const GUID IID_IMixerOCX                                = GUIDOF!IMixerOCX;
const GUID IID_IMixerOCXNotify                          = GUIDOF!IMixerOCXNotify;
const GUID IID_IMpeg2Data                               = GUIDOF!IMpeg2Data;
const GUID IID_IMpeg2Demultiplexer                      = GUIDOF!IMpeg2Demultiplexer;
const GUID IID_IMpeg2Stream                             = GUIDOF!IMpeg2Stream;
const GUID IID_IMpeg2TableFilter                        = GUIDOF!IMpeg2TableFilter;
const GUID IID_IMultiMediaStream                        = GUIDOF!IMultiMediaStream;
const GUID IID_IOverlay                                 = GUIDOF!IOverlay;
const GUID IID_IOverlayNotify                           = GUIDOF!IOverlayNotify;
const GUID IID_IOverlayNotify2                          = GUIDOF!IOverlayNotify2;
const GUID IID_IPAT                                     = GUIDOF!IPAT;
const GUID IID_IPBDAAttributesDescriptor                = GUIDOF!IPBDAAttributesDescriptor;
const GUID IID_IPBDAEntitlementDescriptor               = GUIDOF!IPBDAEntitlementDescriptor;
const GUID IID_IPBDASiParser                            = GUIDOF!IPBDASiParser;
const GUID IID_IPBDA_EIT                                = GUIDOF!IPBDA_EIT;
const GUID IID_IPBDA_Services                           = GUIDOF!IPBDA_Services;
const GUID IID_IPMT                                     = GUIDOF!IPMT;
const GUID IID_IPSITables                               = GUIDOF!IPSITables;
const GUID IID_IPTFilterLicenseRenewal                  = GUIDOF!IPTFilterLicenseRenewal;
const GUID IID_IPersistMediaPropertyBag                 = GUIDOF!IPersistMediaPropertyBag;
const GUID IID_IPersistTuneXml                          = GUIDOF!IPersistTuneXml;
const GUID IID_IPersistTuneXmlUtility                   = GUIDOF!IPersistTuneXmlUtility;
const GUID IID_IPersistTuneXmlUtility2                  = GUIDOF!IPersistTuneXmlUtility2;
const GUID IID_IPin                                     = GUIDOF!IPin;
const GUID IID_IPinConnection                           = GUIDOF!IPinConnection;
const GUID IID_IPinFlowControl                          = GUIDOF!IPinFlowControl;
const GUID IID_IPinInfo                                 = GUIDOF!IPinInfo;
const GUID IID_IQualityControl                          = GUIDOF!IQualityControl;
const GUID IID_IQueueCommand                            = GUIDOF!IQueueCommand;
const GUID IID_IReferenceClock                          = GUIDOF!IReferenceClock;
const GUID IID_IReferenceClock2                         = GUIDOF!IReferenceClock2;
const GUID IID_IReferenceClockTimerControl              = GUIDOF!IReferenceClockTimerControl;
const GUID IID_IRegFilterInfo                           = GUIDOF!IRegFilterInfo;
const GUID IID_IRegisterServiceProvider                 = GUIDOF!IRegisterServiceProvider;
const GUID IID_IRegisterTuner                           = GUIDOF!IRegisterTuner;
const GUID IID_IResourceConsumer                        = GUIDOF!IResourceConsumer;
const GUID IID_IResourceManager                         = GUIDOF!IResourceManager;
const GUID IID_ISBE2Crossbar                            = GUIDOF!ISBE2Crossbar;
const GUID IID_ISBE2EnumStream                          = GUIDOF!ISBE2EnumStream;
const GUID IID_ISBE2FileScan                            = GUIDOF!ISBE2FileScan;
const GUID IID_ISBE2GlobalEvent                         = GUIDOF!ISBE2GlobalEvent;
const GUID IID_ISBE2GlobalEvent2                        = GUIDOF!ISBE2GlobalEvent2;
const GUID IID_ISBE2MediaTypeProfile                    = GUIDOF!ISBE2MediaTypeProfile;
const GUID IID_ISBE2SpanningEvent                       = GUIDOF!ISBE2SpanningEvent;
const GUID IID_ISBE2StreamMap                           = GUIDOF!ISBE2StreamMap;
const GUID IID_ISCTE_EAS                                = GUIDOF!ISCTE_EAS;
const GUID IID_ISIInbandEPG                             = GUIDOF!ISIInbandEPG;
const GUID IID_ISIInbandEPGEvent                        = GUIDOF!ISIInbandEPGEvent;
const GUID IID_IScanningTuner                           = GUIDOF!IScanningTuner;
const GUID IID_IScanningTunerEx                         = GUIDOF!IScanningTunerEx;
const GUID IID_ISectionList                             = GUIDOF!ISectionList;
const GUID IID_ISeekingPassThru                         = GUIDOF!ISeekingPassThru;
const GUID IID_ISelector                                = GUIDOF!ISelector;
const GUID IID_IServiceLocationDescriptor               = GUIDOF!IServiceLocationDescriptor;
const GUID IID_IStreamBufferConfigure                   = GUIDOF!IStreamBufferConfigure;
const GUID IID_IStreamBufferConfigure2                  = GUIDOF!IStreamBufferConfigure2;
const GUID IID_IStreamBufferConfigure3                  = GUIDOF!IStreamBufferConfigure3;
const GUID IID_IStreamBufferDataCounters                = GUIDOF!IStreamBufferDataCounters;
const GUID IID_IStreamBufferInitialize                  = GUIDOF!IStreamBufferInitialize;
const GUID IID_IStreamBufferMediaSeeking                = GUIDOF!IStreamBufferMediaSeeking;
const GUID IID_IStreamBufferMediaSeeking2               = GUIDOF!IStreamBufferMediaSeeking2;
const GUID IID_IStreamBufferRecComp                     = GUIDOF!IStreamBufferRecComp;
const GUID IID_IStreamBufferRecordControl               = GUIDOF!IStreamBufferRecordControl;
const GUID IID_IStreamBufferRecordingAttribute          = GUIDOF!IStreamBufferRecordingAttribute;
const GUID IID_IStreamBufferSink                        = GUIDOF!IStreamBufferSink;
const GUID IID_IStreamBufferSink2                       = GUIDOF!IStreamBufferSink2;
const GUID IID_IStreamBufferSink3                       = GUIDOF!IStreamBufferSink3;
const GUID IID_IStreamBufferSource                      = GUIDOF!IStreamBufferSource;
const GUID IID_IStreamBuilder                           = GUIDOF!IStreamBuilder;
const GUID IID_IStreamSample                            = GUIDOF!IStreamSample;
const GUID IID_ITSDT                                    = GUIDOF!ITSDT;
const GUID IID_ITuneRequest                             = GUIDOF!ITuneRequest;
const GUID IID_ITuneRequestInfo                         = GUIDOF!ITuneRequestInfo;
const GUID IID_ITuneRequestInfoEx                       = GUIDOF!ITuneRequestInfoEx;
const GUID IID_ITuner                                   = GUIDOF!ITuner;
const GUID IID_ITunerCap                                = GUIDOF!ITunerCap;
const GUID IID_ITunerCapEx                              = GUIDOF!ITunerCapEx;
const GUID IID_ITuningSpace                             = GUIDOF!ITuningSpace;
const GUID IID_ITuningSpaceContainer                    = GUIDOF!ITuningSpaceContainer;
const GUID IID_ITuningSpaces                            = GUIDOF!ITuningSpaces;
const GUID IID_IVMRAspectRatioControl                   = GUIDOF!IVMRAspectRatioControl;
const GUID IID_IVMRAspectRatioControl9                  = GUIDOF!IVMRAspectRatioControl9;
const GUID IID_IVMRDeinterlaceControl                   = GUIDOF!IVMRDeinterlaceControl;
const GUID IID_IVMRDeinterlaceControl9                  = GUIDOF!IVMRDeinterlaceControl9;
const GUID IID_IVMRFilterConfig                         = GUIDOF!IVMRFilterConfig;
const GUID IID_IVMRFilterConfig9                        = GUIDOF!IVMRFilterConfig9;
const GUID IID_IVMRImageCompositor                      = GUIDOF!IVMRImageCompositor;
const GUID IID_IVMRImageCompositor9                     = GUIDOF!IVMRImageCompositor9;
const GUID IID_IVMRImagePresenter                       = GUIDOF!IVMRImagePresenter;
const GUID IID_IVMRImagePresenter9                      = GUIDOF!IVMRImagePresenter9;
const GUID IID_IVMRImagePresenterConfig                 = GUIDOF!IVMRImagePresenterConfig;
const GUID IID_IVMRImagePresenterConfig9                = GUIDOF!IVMRImagePresenterConfig9;
const GUID IID_IVMRImagePresenterExclModeConfig         = GUIDOF!IVMRImagePresenterExclModeConfig;
const GUID IID_IVMRMixerBitmap                          = GUIDOF!IVMRMixerBitmap;
const GUID IID_IVMRMixerBitmap9                         = GUIDOF!IVMRMixerBitmap9;
const GUID IID_IVMRMixerControl                         = GUIDOF!IVMRMixerControl;
const GUID IID_IVMRMixerControl9                        = GUIDOF!IVMRMixerControl9;
const GUID IID_IVMRMonitorConfig                        = GUIDOF!IVMRMonitorConfig;
const GUID IID_IVMRMonitorConfig9                       = GUIDOF!IVMRMonitorConfig9;
const GUID IID_IVMRSurface                              = GUIDOF!IVMRSurface;
const GUID IID_IVMRSurface9                             = GUIDOF!IVMRSurface9;
const GUID IID_IVMRSurfaceAllocator                     = GUIDOF!IVMRSurfaceAllocator;
const GUID IID_IVMRSurfaceAllocator9                    = GUIDOF!IVMRSurfaceAllocator9;
const GUID IID_IVMRSurfaceAllocatorEx9                  = GUIDOF!IVMRSurfaceAllocatorEx9;
const GUID IID_IVMRSurfaceAllocatorNotify               = GUIDOF!IVMRSurfaceAllocatorNotify;
const GUID IID_IVMRSurfaceAllocatorNotify9              = GUIDOF!IVMRSurfaceAllocatorNotify9;
const GUID IID_IVMRVideoStreamControl                   = GUIDOF!IVMRVideoStreamControl;
const GUID IID_IVMRVideoStreamControl9                  = GUIDOF!IVMRVideoStreamControl9;
const GUID IID_IVMRWindowlessControl                    = GUIDOF!IVMRWindowlessControl;
const GUID IID_IVMRWindowlessControl9                   = GUIDOF!IVMRWindowlessControl9;
const GUID IID_IVPManager                               = GUIDOF!IVPManager;
const GUID IID_IVideoEncoder                            = GUIDOF!IVideoEncoder;
const GUID IID_IVideoFrameStep                          = GUIDOF!IVideoFrameStep;
const GUID IID_IVideoProcAmp                            = GUIDOF!IVideoProcAmp;
const GUID IID_IVideoWindow                             = GUIDOF!IVideoWindow;
const GUID IID_IXDSCodec                                = GUIDOF!IXDSCodec;
const GUID IID_IXDSCodecConfig                          = GUIDOF!IXDSCodecConfig;
const GUID IID_IXDSCodecEvents                          = GUIDOF!IXDSCodecEvents;
const GUID IID_IXDSToRat                                = GUIDOF!IXDSToRat;
const GUID IID__IMSVidCtlEvents                         = GUIDOF!_IMSVidCtlEvents;
