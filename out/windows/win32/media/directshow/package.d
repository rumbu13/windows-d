// Written in the D programming language.

module windows.win32.media.directshow;

public import windows.core;
public import windows.win32.foundation : BOOL, BOOLEAN, BSTR, COLORREF, HANDLE,
                                         HRESULT, HWND, PAPCFUNC, POINT, PSTR,
                                         PWSTR, RECT, SIZE, VARIANT_BOOL;
public import windows.win32.graphics.direct3d9 : D3DFORMAT, D3DPOOL, IDirect3DDevice9,
                                                 IDirect3DSurface9;
public import windows.win32.graphics.directdraw : DDCAPS_DX7, DDCOLORCONTROL, DDCOLORKEY,
                                                  DDPIXELFORMAT, DDSCAPS2, DDSURFACEDESC,
                                                  DDVIDEOPORTCONNECT, IDirectDraw,
                                                  IDirectDraw7, IDirectDrawPalette,
                                                  IDirectDrawSurface, IDirectDrawSurface7;
public import windows.win32.graphics.gdi : BITMAPINFO, BITMAPINFOHEADER, HDC, HMONITOR,
                                           PALETTEENTRY, RGBQUAD, RGNDATA;
public import windows.win32.media.audio.directsound : IDirectSound, IDirectSoundBuffer;
public import windows.win32.media.audio : WAVEFORMATEX;
public import windows.win32.media : IReferenceClock;
public import windows.win32.media.mediafoundation : AM_MEDIA_TYPE, DXVA2_AYUVSample16,
                                                    DXVA2_AYUVSample8, DXVA2_ExtendedFormat,
                                                    DXVA2_FilterValues, DXVA2_Fixed32,
                                                    DXVA2_ProcAmpValues, DXVA2_ValueRange,
                                                    DXVA2_VideoDesc, DXVA2_VideoProcessorCaps;
public import windows.win32.media : TIMECODE, TIMECODE_SAMPLE;
public import windows.win32.media.windowsmediaformat : INSSBuffer3, IWMPlayerTimestampHook,
                                                       IWMProfile;
public import windows.win32.system.com : IBindCtx, IDispatch, IEnumMoniker, IErrorLog,
                                         IMoniker, IPersist, IUnknown, SAFEARRAY;
public import windows.win32.system.com.structuredstorage : IPropertyBag;
public import windows.win32.system.diagnostics.etw : EVENT_TRACE_HEADER;
public import windows.win32.system.ole : CAUUID;
public import windows.win32.system.registry : HKEY;
public import windows.win32.system.variant : VARIANT;
public import windows.win32.ui.windowsandmessaging : HACCEL, SHOW_WINDOW_CMD;

extern(Windows) @nogc nothrow:


// Enums


alias OA_BOOL = int;
enum : int
{
    OATRUE  = 0xffffffff,
    OAFALSE = 0x00000000,
}

alias MPEGLAYER3WAVEFORMAT_FLAGS = uint;
enum : uint
{
    MPEGLAYER3_FLAG_PADDING_ISO = 0x00000000U,
    MPEGLAYER3_FLAG_PADDING_ON  = 0x00000001U,
    MPEGLAYER3_FLAG_PADDING_OFF = 0x00000002U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vptype/ne-vptype-amvp_select_format_by
alias AMVP_SELECT_FORMAT_BY = int;
enum : int
{
    AMVP_DO_NOT_CARE          = 0x00000000,
    AMVP_BEST_BANDWIDTH       = 0x00000001,
    AMVP_INPUT_SAME_AS_OUTPUT = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vptype/ne-vptype-amvp_mode
alias AMVP_MODE = int;
enum : int
{
    AMVP_MODE_WEAVE             = 0x00000000,
    AMVP_MODE_BOBINTERLEAVED    = 0x00000001,
    AMVP_MODE_BOBNONINTERLEAVED = 0x00000002,
    AMVP_MODE_SKIPEVEN          = 0x00000003,
    AMVP_MODE_SKIPODD           = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ne-strmif-pin_direction
alias PIN_DIRECTION = int;
enum : int
{
    PINDIR_INPUT  = 0x00000000,
    PINDIR_OUTPUT = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ne-strmif-filter_state
alias FILTER_STATE = int;
enum : int
{
    State_Stopped = 0x00000000,
    State_Paused  = 0x00000001,
    State_Running = 0x00000002,
}

alias AM_SAMPLE_PROPERTY_FLAGS = int;
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

alias AM_SEEKING_SEEKING_FLAGS = int;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ne-strmif-am_seeking_seeking_capabilities
alias AM_SEEKING_SEEKING_CAPABILITIES = int;
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

alias AM_MEDIAEVENT_FLAGS = int;
enum : int
{
    AM_MEDIAEVENT_NONOTIFY = 0x00000001,
}

alias IFILTERMAPPER_MERIT = int;
enum : int
{
    MERIT_PREFERRED     = 0x00800000,
    MERIT_NORMAL        = 0x00600000,
    MERIT_UNLIKELY      = 0x00400000,
    MERIT_DO_NOT_USE    = 0x00200000,
    MERIT_SW_COMPRESSOR = 0x00100000,
    MERIT_HW_COMPRESSOR = 0x00100050,
}

alias REG_PINFLAG = int;
enum : int
{
    REG_PINFLAG_B_ZERO     = 0x00000001,
    REG_PINFLAG_B_RENDERER = 0x00000002,
    REG_PINFLAG_B_MANY     = 0x00000004,
    REG_PINFLAG_B_OUTPUT   = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ne-strmif-qualitymessagetype
enum QualityMessageType : int
{
    Famine  = 0x00000000,
    Flood   = 0x00000001,
}

alias COLORKEY_TYPE = int;
enum : int
{
    CK_NOCOLORKEY = 0x00000000,
    CK_INDEX      = 0x00000001,
    CK_RGB        = 0x00000002,
}

alias ADVISE_TYPE = int;
enum : int
{
    ADVISE_NONE           = 0x00000000,
    ADVISE_CLIPPING       = 0x00000001,
    ADVISE_PALETTE        = 0x00000002,
    ADVISE_COLORKEY       = 0x00000004,
    ADVISE_POSITION       = 0x00000008,
    ADVISE_DISPLAY_CHANGE = 0x00000010,
}

alias AM_FILESINK_FLAGS = int;
enum : int
{
    AM_FILE_OVERWRITE = 0x00000001,
}

alias _AM_RENSDEREXFLAGS = int;
enum : int
{
    AM_RENDEREX_RENDERTOEXISTINGRENDERERS = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ne-strmif-am_stream_info_flags
alias AM_STREAM_INFO_FLAGS = int;
enum : int
{
    AM_STREAM_INFO_START_DEFINED   = 0x00000001,
    AM_STREAM_INFO_STOP_DEFINED    = 0x00000002,
    AM_STREAM_INFO_DISCARDING      = 0x00000004,
    AM_STREAM_INFO_STOP_SEND_EXTRA = 0x00000010,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ne-strmif-interleavingmode
enum InterleavingMode : int
{
    INTERLEAVE_NONE          = 0x00000000,
    INTERLEAVE_CAPTURE       = 0x00000001,
    INTERLEAVE_FULL          = 0x00000002,
    INTERLEAVE_NONE_BUFFERED = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ne-strmif-compressioncaps
enum CompressionCaps : int
{
    CompressionCaps_CanQuality  = 0x00000001,
    CompressionCaps_CanCrunch   = 0x00000002,
    CompressionCaps_CanKeyFrame = 0x00000004,
    CompressionCaps_CanBFrame   = 0x00000008,
    CompressionCaps_CanWindow   = 0x00000010,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ne-strmif-vfwcapturedialogs
enum VfwCaptureDialogs : int
{
    VfwCaptureDialog_Source  = 0x00000001,
    VfwCaptureDialog_Format  = 0x00000002,
    VfwCaptureDialog_Display = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ne-strmif-vfwcompressdialogs
enum VfwCompressDialogs : int
{
    VfwCompressDialog_Config      = 0x00000001,
    VfwCompressDialog_About       = 0x00000002,
    VfwCompressDialog_QueryConfig = 0x00000004,
    VfwCompressDialog_QueryAbout  = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ne-strmif-analogvideostandard
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ne-strmif-tunerinputtype
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ne-strmif-physicalconnectortype
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ne-strmif-videoprocampproperty
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ne-strmif-videoprocampflags
enum VideoProcAmpFlags : int
{
    VideoProcAmp_Flags_Auto   = 0x00000001,
    VideoProcAmp_Flags_Manual = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ne-strmif-cameracontrolproperty
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ne-strmif-cameracontrolflags
enum CameraControlFlags : int
{
    CameraControl_Flags_Auto   = 0x00000001,
    CameraControl_Flags_Manual = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ne-strmif-videocontrolflags
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ne-strmif-amtunermodetype
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ne-strmif-tvaudiomode
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

alias AMPROPERTY_PIN = int;
enum : int
{
    AMPROPERTY_PIN_CATEGORY = 0x00000000,
    AMPROPERTY_PIN_MEDIUM   = 0x00000001,
}

alias _AMSTREAMSELECTINFOFLAGS = int;
enum : int
{
    AMSTREAMSELECTINFO_ENABLED   = 0x00000001,
    AMSTREAMSELECTINFO_EXCLUSIVE = 0x00000002,
}

alias _AMSTREAMSELECTENABLEFLAGS = int;
enum : int
{
    AMSTREAMSELECTENABLE_ENABLE    = 0x00000001,
    AMSTREAMSELECTENABLE_ENABLEALL = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ne-strmif-_amresctl_reserveflags
alias _AMRESCTL_RESERVEFLAGS = int;
enum : int
{
    AMRESCTL_RESERVEFLAGS_RESERVE   = 0x00000000,
    AMRESCTL_RESERVEFLAGS_UNRESERVE = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ne-strmif-_am_filter_misc_flags
alias _AM_FILTER_MISC_FLAGS = int;
enum : int
{
    AM_FILTER_MISC_FLAGS_IS_RENDERER = 0x00000001,
    AM_FILTER_MISC_FLAGS_IS_SOURCE   = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ne-strmif-decimation_usage
alias DECIMATION_USAGE = int;
enum : int
{
    DECIMATION_LEGACY             = 0x00000000,
    DECIMATION_USE_DECODER_ONLY   = 0x00000001,
    DECIMATION_USE_VIDEOPORT_ONLY = 0x00000002,
    DECIMATION_USE_OVERLAY_ONLY   = 0x00000003,
    DECIMATION_DEFAULT            = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ne-strmif-_am_pushsource_flags
alias _AM_PUSHSOURCE_FLAGS = int;
enum : int
{
    AM_PUSHSOURCECAPS_INTERNAL_RM      = 0x00000001,
    AM_PUSHSOURCECAPS_NOT_LIVE         = 0x00000002,
    AM_PUSHSOURCECAPS_PRIVATE_CLOCK    = 0x00000004,
    AM_PUSHSOURCEREQS_USE_STREAM_CLOCK = 0x00010000,
    AM_PUSHSOURCEREQS_USE_CLOCK_CHAIN  = 0x00020000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ne-strmif-_dvencoderresolution
alias _DVENCODERRESOLUTION = int;
enum : int
{
    DVENCODERRESOLUTION_720x480 = 0x000007dc,
    DVENCODERRESOLUTION_360x240 = 0x000007dd,
    DVENCODERRESOLUTION_180x120 = 0x000007de,
    DVENCODERRESOLUTION_88x60   = 0x000007df,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ne-strmif-_dvencodervideoformat
alias _DVENCODERVIDEOFORMAT = int;
enum : int
{
    DVENCODERVIDEOFORMAT_NTSC = 0x000007d0,
    DVENCODERVIDEOFORMAT_PAL  = 0x000007d1,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ne-strmif-_dvencoderformat
alias _DVENCODERFORMAT = int;
enum : int
{
    DVENCODERFORMAT_DVSD = 0x000007d7,
    DVENCODERFORMAT_DVHD = 0x000007d8,
    DVENCODERFORMAT_DVSL = 0x000007d9,
}

alias _DVDECODERRESOLUTION = int;
enum : int
{
    DVDECODERRESOLUTION_720x480 = 0x000003e8,
    DVDECODERRESOLUTION_360x240 = 0x000003e9,
    DVDECODERRESOLUTION_180x120 = 0x000003ea,
    DVDECODERRESOLUTION_88x60   = 0x000003eb,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ne-strmif-_dvresolution
alias _DVRESOLUTION = int;
enum : int
{
    DVRESOLUTION_FULL    = 0x000003e8,
    DVRESOLUTION_HALF    = 0x000003e9,
    DVRESOLUTION_QUARTER = 0x000003ea,
    DVRESOLUTION_DC      = 0x000003eb,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ne-strmif-_am_audio_renderer_stat_param
alias _AM_AUDIO_RENDERER_STAT_PARAM = int;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ne-strmif-_am_intf_search_flags
alias _AM_INTF_SEARCH_FLAGS = int;
enum : int
{
    AM_INTF_SEARCH_INPUT_PIN  = 0x00000001,
    AM_INTF_SEARCH_OUTPUT_PIN = 0x00000002,
    AM_INTF_SEARCH_FILTER     = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ne-strmif-amoverlayfx
alias AMOVERLAYFX = int;
enum : int
{
    AMOVERFX_NOFX            = 0x00000000,
    AMOVERFX_MIRRORLEFTRIGHT = 0x00000002,
    AMOVERFX_MIRRORUPDOWN    = 0x00000004,
    AMOVERFX_DEINTERLACE     = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ne-strmif-_am_pin_flow_control_block_flags
alias _AM_PIN_FLOW_CONTROL_BLOCK_FLAGS = int;
enum : int
{
    AM_PIN_FLOW_CONTROL_BLOCK = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ne-strmif-am_graph_config_reconnect_flags
alias AM_GRAPH_CONFIG_RECONNECT_FLAGS = int;
enum : int
{
    AM_GRAPH_CONFIG_RECONNECT_DIRECTCONNECT           = 0x00000001,
    AM_GRAPH_CONFIG_RECONNECT_CACHE_REMOVED_FILTERS   = 0x00000002,
    AM_GRAPH_CONFIG_RECONNECT_USE_ONLY_CACHED_FILTERS = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ne-strmif-_rem_filter_flags
alias _REM_FILTER_FLAGS = int;
enum : int
{
    REMFILTERF_LEAVECONNECTED = 0x00000001,
}

alias AM_FILTER_FLAGS = int;
enum : int
{
    AM_FILTER_FLAGS_REMOVABLE = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ne-strmif-vmrpresentationflags
enum VMRPresentationFlags : int
{
    VMRSample_SyncPoint        = 0x00000001,
    VMRSample_Preroll          = 0x00000002,
    VMRSample_Discontinuity    = 0x00000004,
    VMRSample_TimeValid        = 0x00000008,
    VMRSample_SrcDstRectsValid = 0x00000010,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ne-strmif-vmrsurfaceallocationflags
enum VMRSurfaceAllocationFlags : int
{
    AMAP_PIXELFORMAT_VALID = 0x00000001,
    AMAP_3D_TARGET         = 0x00000002,
    AMAP_ALLOW_SYSMEM      = 0x00000004,
    AMAP_FORCE_SYSMEM      = 0x00000008,
    AMAP_DIRECTED_FLIP     = 0x00000010,
    AMAP_DXVA_TARGET       = 0x00000020,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ne-strmif-vmr_aspect_ratio_mode
alias VMR_ASPECT_RATIO_MODE = int;
enum : int
{
    VMR_ARMODE_NONE       = 0x00000000,
    VMR_ARMODE_LETTER_BOX = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ne-strmif-vmrmixerprefs
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ne-strmif-vmrrenderprefs
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ne-strmif-vmrmode
alias VMRMode = int;
enum : int
{
    VMRMode_Windowed   = 0x00000001,
    VMRMode_Windowless = 0x00000002,
    VMRMode_Renderless = 0x00000004,
    VMRMode_Mask       = 0x00000007,
}

alias STREAMIF_CONSTANTS = int;
enum : int
{
    MAX_NUMBER_OF_STREAMS = 0x00000010,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ne-strmif-vmrdeinterlaceprefs
enum VMRDeinterlacePrefs : int
{
    DeinterlacePref_NextBest = 0x00000001,
    DeinterlacePref_BOB      = 0x00000002,
    DeinterlacePref_Weave    = 0x00000004,
    DeinterlacePref_Mask     = 0x00000007,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ne-strmif-vmrdeinterlacetech
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ne-strmif-dvd_domain
alias DVD_DOMAIN = int;
enum : int
{
    DVD_DOMAIN_FirstPlay         = 0x00000001,
    DVD_DOMAIN_VideoManagerMenu  = 0x00000002,
    DVD_DOMAIN_VideoTitleSetMenu = 0x00000003,
    DVD_DOMAIN_Title             = 0x00000004,
    DVD_DOMAIN_Stop              = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ne-strmif-dvd_menu_id
alias DVD_MENU_ID = int;
enum : int
{
    DVD_MENU_Title      = 0x00000002,
    DVD_MENU_Root       = 0x00000003,
    DVD_MENU_Subpicture = 0x00000004,
    DVD_MENU_Audio      = 0x00000005,
    DVD_MENU_Angle      = 0x00000006,
    DVD_MENU_Chapter    = 0x00000007,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ne-strmif-dvd_disc_side
alias DVD_DISC_SIDE = int;
enum : int
{
    DVD_SIDE_A = 0x00000001,
    DVD_SIDE_B = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ne-strmif-dvd_preferred_display_mode
alias DVD_PREFERRED_DISPLAY_MODE = int;
enum : int
{
    DISPLAY_CONTENT_DEFAULT         = 0x00000000,
    DISPLAY_16x9                    = 0x00000001,
    DISPLAY_4x3_PANSCAN_PREFERRED   = 0x00000002,
    DISPLAY_4x3_LETTERBOX_PREFERRED = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ne-strmif-dvd_framerate
alias DVD_FRAMERATE = int;
enum : int
{
    DVD_FPS_25        = 0x00000001,
    DVD_FPS_30NonDrop = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ne-strmif-dvd_navcmdtype
alias DVD_NavCmdType = int;
enum : int
{
    DVD_NavCmdType_Pre    = 0x00000001,
    DVD_NavCmdType_Post   = 0x00000002,
    DVD_NavCmdType_Cell   = 0x00000003,
    DVD_NavCmdType_Button = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ne-strmif-dvd_timecode_flags
alias DVD_TIMECODE_FLAGS = int;
enum : int
{
    DVD_TC_FLAG_25fps        = 0x00000001,
    DVD_TC_FLAG_30fps        = 0x00000002,
    DVD_TC_FLAG_DropFrame    = 0x00000004,
    DVD_TC_FLAG_Interpolated = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ne-strmif-valid_uop_flag
alias VALID_UOP_FLAG = int;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ne-strmif-dvd_cmd_flags
alias DVD_CMD_FLAGS = int;
enum : int
{
    DVD_CMD_FLAG_None              = 0x00000000,
    DVD_CMD_FLAG_Flush             = 0x00000001,
    DVD_CMD_FLAG_SendEvents        = 0x00000002,
    DVD_CMD_FLAG_Block             = 0x00000004,
    DVD_CMD_FLAG_StartWhenRendered = 0x00000008,
    DVD_CMD_FLAG_EndAfterRendered  = 0x00000010,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ne-strmif-dvd_option_flag
alias DVD_OPTION_FLAG = int;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ne-strmif-dvd_relative_button
alias DVD_RELATIVE_BUTTON = int;
enum : int
{
    DVD_Relative_Upper = 0x00000001,
    DVD_Relative_Lower = 0x00000002,
    DVD_Relative_Left  = 0x00000003,
    DVD_Relative_Right = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ne-strmif-dvd_parental_level
alias DVD_PARENTAL_LEVEL = int;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ne-strmif-dvd_audio_lang_ext
alias DVD_AUDIO_LANG_EXT = int;
enum : int
{
    DVD_AUD_EXT_NotSpecified      = 0x00000000,
    DVD_AUD_EXT_Captions          = 0x00000001,
    DVD_AUD_EXT_VisuallyImpaired  = 0x00000002,
    DVD_AUD_EXT_DirectorComments1 = 0x00000003,
    DVD_AUD_EXT_DirectorComments2 = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ne-strmif-dvd_subpicture_lang_ext
alias DVD_SUBPICTURE_LANG_EXT = int;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ne-strmif-dvd_audio_appmode
alias DVD_AUDIO_APPMODE = int;
enum : int
{
    DVD_AudioMode_None     = 0x00000000,
    DVD_AudioMode_Karaoke  = 0x00000001,
    DVD_AudioMode_Surround = 0x00000002,
    DVD_AudioMode_Other    = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ne-strmif-dvd_audio_format
alias DVD_AUDIO_FORMAT = int;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ne-strmif-dvd_karaoke_downmix
alias DVD_KARAOKE_DOWNMIX = int;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ne-strmif-dvd_karaoke_contents
alias DVD_KARAOKE_CONTENTS = int;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ne-strmif-dvd_karaoke_assignment
alias DVD_KARAOKE_ASSIGNMENT = int;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ne-strmif-dvd_video_compression
alias DVD_VIDEO_COMPRESSION = int;
enum : int
{
    DVD_VideoCompression_Other = 0x00000000,
    DVD_VideoCompression_MPEG1 = 0x00000001,
    DVD_VideoCompression_MPEG2 = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ne-strmif-dvd_subpicture_type
alias DVD_SUBPICTURE_TYPE = int;
enum : int
{
    DVD_SPType_NotSpecified = 0x00000000,
    DVD_SPType_Language     = 0x00000001,
    DVD_SPType_Other        = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ne-strmif-dvd_subpicture_coding
alias DVD_SUBPICTURE_CODING = int;
enum : int
{
    DVD_SPCoding_RunLength = 0x00000000,
    DVD_SPCoding_Extended  = 0x00000001,
    DVD_SPCoding_Other     = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ne-strmif-dvd_title_appmode
alias DVD_TITLE_APPMODE = int;
enum : int
{
    DVD_AppMode_Not_Specified = 0x00000000,
    DVD_AppMode_Karaoke       = 0x00000001,
    DVD_AppMode_Other         = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ne-strmif-dvd_textstringtype
alias DVD_TextStringType = int;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ne-strmif-dvd_textcharset
alias DVD_TextCharSet = int;
enum : int
{
    DVD_CharSet_Unicode                       = 0x00000000,
    DVD_CharSet_ISO646                        = 0x00000001,
    DVD_CharSet_JIS_Roman_Kanji               = 0x00000002,
    DVD_CharSet_ISO8859_1                     = 0x00000003,
    DVD_CharSet_ShiftJIS_Kanji_Roman_Katakana = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ne-strmif-am_dvd_graph_flags
alias AM_DVD_GRAPH_FLAGS = int;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ne-strmif-am_dvd_stream_flags
alias AM_DVD_STREAM_FLAGS = int;
enum : int
{
    AM_DVD_STREAM_VIDEO  = 0x00000001,
    AM_DVD_STREAM_AUDIO  = 0x00000002,
    AM_DVD_STREAM_SUBPIC = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ne-strmif-_am_overlay_notify_flags
alias _AM_OVERLAY_NOTIFY_FLAGS = int;
enum : int
{
    AM_OVERLAY_NOTIFY_VISIBLE_CHANGE = 0x00000001,
    AM_OVERLAY_NOTIFY_SOURCE_CHANGE  = 0x00000002,
    AM_OVERLAY_NOTIFY_DEST_CHANGE    = 0x00000004,
}

alias BDA_EVENT_ID = int;
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

alias BDA_MULTICAST_MODE = int;
enum : int
{
    BDA_PROMISCUOUS_MULTICAST = 0x00000000,
    BDA_FILTERED_MULTICAST    = 0x00000001,
    BDA_NO_MULTICAST          = 0x00000002,
}

alias BDA_SIGNAL_STATE = int;
enum : int
{
    BDA_SIGNAL_UNAVAILABLE = 0x00000000,
    BDA_SIGNAL_INACTIVE    = 0x00000001,
    BDA_SIGNAL_ACTIVE      = 0x00000002,
}

alias BDA_CHANGE_STATE = int;
enum : int
{
    BDA_CHANGES_COMPLETE = 0x00000000,
    BDA_CHANGES_PENDING  = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/media-sample-content
alias MEDIA_SAMPLE_CONTENT = int;
enum : int
{
    MEDIA_TRANSPORT_PACKET  = 0x00000000,
    MEDIA_ELEMENTARY_STREAM = 0x00000001,
    MEDIA_MPEG2_PSI         = 0x00000002,
    MEDIA_TRANSPORT_PAYLOAD = 0x00000003,
}

alias ISDBCAS_REQUEST_ID = int;
enum : int
{
    ISDBCAS_REQUEST_ID_EMG = 0x00000038,
    ISDBCAS_REQUEST_ID_EMD = 0x0000003a,
}

alias MUX_PID_TYPE = int;
enum : int
{
    PID_OTHER                = 0xffffffff,
    PID_ELEMENTARY_STREAM    = 0x00000000,
    PID_MPEG2_SECTION_PSI_SI = 0x00000001,
}

enum DVBSystemType : int
{
    DVB_Cable        = 0x00000000,
    DVB_Terrestrial  = 0x00000001,
    DVB_Satellite    = 0x00000002,
    ISDB_Terrestrial = 0x00000003,
    ISDB_Satellite   = 0x00000004,
}

alias BDA_Channel = int;
enum : int
{
    BDA_UNDEFINED_CHANNEL = 0xffffffff,
}

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
    MPEG_H_AUDIO                    = 0x0000002d,
    MPEG_H_AUDIO_MS                 = 0x0000002e,
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

alias LNB_Source = int;
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

alias BDA_Frequency = int;
enum : int
{
    BDA_FREQUENCY_NOT_SET     = 0xffffffff,
    BDA_FREQUENCY_NOT_DEFINED = 0x00000000,
}

alias BDA_Range = int;
enum : int
{
    BDA_RANGE_NOT_SET     = 0xffffffff,
    BDA_RANGE_NOT_DEFINED = 0x00000000,
}

alias BDA_Channel_Bandwidth = int;
enum : int
{
    BDA_CHAN_BANDWITH_NOT_SET     = 0xffffffff,
    BDA_CHAN_BANDWITH_NOT_DEFINED = 0x00000000,
}

alias BDA_Frequency_Multiplier = int;
enum : int
{
    BDA_FREQUENCY_MULTIPLIER_NOT_SET     = 0xffffffff,
    BDA_FREQUENCY_MULTIPLIER_NOT_DEFINED = 0x00000000,
}

alias BDA_Comp_Flags = int;
enum : int
{
    BDACOMP_NOT_DEFINED              = 0x00000000,
    BDACOMP_EXCLUDE_TS_FROM_TR       = 0x00000001,
    BDACOMP_INCLUDE_LOCATOR_IN_TR    = 0x00000002,
    BDACOMP_INCLUDE_COMPONENTS_IN_TR = 0x00000004,
}

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

alias BDA_CONDITIONALACCESS_REQUESTTYPE = int;
enum : int
{
    CONDITIONALACCESS_ACCESS_UNSPECIFIED                      = 0x00000000,
    CONDITIONALACCESS_ACCESS_NOT_POSSIBLE                     = 0x00000001,
    CONDITIONALACCESS_ACCESS_POSSIBLE                         = 0x00000002,
    CONDITIONALACCESS_ACCESS_POSSIBLE_NO_STREAMING_DISRUPTION = 0x00000003,
}

alias BDA_CONDITIONALACCESS_MMICLOSEREASON = int;
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

alias BDA_CONDITIONALACCESS_SESSION_RESULT = int;
enum : int
{
    CONDITIONALACCESS_SUCCESSFULL    = 0x00000000,
    CONDITIONALACCESS_ENDED_NOCHANGE = 0x00000001,
    CONDITIONALACCESS_ABORTED        = 0x00000002,
}

alias BDA_DISCOVERY_STATE = int;
enum : int
{
    BDA_DISCOVERY_UNSPECIFIED = 0x00000000,
    BDA_DISCOVERY_REQUIRED    = 0x00000001,
    BDA_DISCOVERY_COMPLETE    = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/ne-bdaiface-smartcardstatustype
enum SmartCardStatusType : int
{
    CardInserted        = 0x00000000,
    CardRemoved         = 0x00000001,
    CardError           = 0x00000002,
    CardDataChanged     = 0x00000003,
    CardFirmwareUpgrade = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/ne-bdaiface-smartcardassociationtype
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/ne-bdaiface-uiclosereasontype
enum UICloseReasonType : int
{
    NotReady     = 0x00000000,
    UserClosed   = 0x00000001,
    SystemClosed = 0x00000002,
    DeviceClosed = 0x00000003,
    ErrorClosed  = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/ne-bdaiface-bda_drmpairingerror
alias BDA_DrmPairingError = int;
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

alias KSPROPERTY_IPSINK = int;
enum : int
{
    KSPROPERTY_IPSINK_MULTICASTLIST       = 0x00000000,
    KSPROPERTY_IPSINK_ADAPTER_DESCRIPTION = 0x00000001,
    KSPROPERTY_IPSINK_ADAPTER_ADDRESS     = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/ne-qnetwork-amextendedseekingcapabilities
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/il21dec/ne-il21dec-am_line21_cclevel
alias AM_LINE21_CCLEVEL = int;
enum : int
{
    AM_L21_CCLEVEL_TC2 = 0x00000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/il21dec/ne-il21dec-am_line21_ccservice
alias AM_LINE21_CCSERVICE = int;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/il21dec/ne-il21dec-am_line21_ccstate
alias AM_LINE21_CCSTATE = int;
enum : int
{
    AM_L21_CCSTATE_Off = 0x00000000,
    AM_L21_CCSTATE_On  = 0x00000001,
}

alias AM_LINE21_CCSTYLE = int;
enum : int
{
    AM_L21_CCSTYLE_None    = 0x00000000,
    AM_L21_CCSTYLE_PopOn   = 0x00000001,
    AM_L21_CCSTYLE_PaintOn = 0x00000002,
    AM_L21_CCSTYLE_RollUp  = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/il21dec/ne-il21dec-am_line21_drawbgmode
alias AM_LINE21_DRAWBGMODE = int;
enum : int
{
    AM_L21_DRAWBGMODE_Opaque      = 0x00000000,
    AM_L21_DRAWBGMODE_Transparent = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iwstdec/ne-iwstdec-am_wst_level
alias AM_WST_LEVEL = int;
enum : int
{
    AM_WST_LEVEL_1_5 = 0x00000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iwstdec/ne-iwstdec-am_wst_service
alias AM_WST_SERVICE = int;
enum : int
{
    AM_WST_SERVICE_None    = 0x00000000,
    AM_WST_SERVICE_Text    = 0x00000001,
    AM_WST_SERVICE_IDS     = 0x00000002,
    AM_WST_SERVICE_Invalid = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iwstdec/ne-iwstdec-am_wst_state
alias AM_WST_STATE = int;
enum : int
{
    AM_WST_STATE_Off = 0x00000000,
    AM_WST_STATE_On  = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iwstdec/ne-iwstdec-am_wst_style
alias AM_WST_STYLE = int;
enum : int
{
    AM_WST_STYLE_None   = 0x00000000,
    AM_WST_STYLE_Invers = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iwstdec/ne-iwstdec-am_wst_drawbgmode
alias AM_WST_DRAWBGMODE = int;
enum : int
{
    AM_WST_DRAWBGMODE_Opaque      = 0x00000000,
    AM_WST_DRAWBGMODE_Transparent = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmstream/ne-mmstream-stream_type
alias STREAM_TYPE = int;
enum : int
{
    STREAMTYPE_READ      = 0x00000000,
    STREAMTYPE_WRITE     = 0x00000001,
    STREAMTYPE_TRANSFORM = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmstream/ne-mmstream-stream_state
alias STREAM_STATE = int;
enum : int
{
    STREAMSTATE_STOP = 0x00000000,
    STREAMSTATE_RUN  = 0x00000001,
}

alias COMPLETION_STATUS_FLAGS = int;
enum : int
{
    COMPSTAT_NOUPDATEOK = 0x00000001,
    COMPSTAT_WAIT       = 0x00000002,
    COMPSTAT_ABORT      = 0x00000004,
}

alias MMSSF_GET_INFORMATION_FLAGS = int;
enum : int
{
    MMSSF_HASCLOCK     = 0x00000001,
    MMSSF_SUPPORTSEEK  = 0x00000002,
    MMSSF_ASYNCHRONOUS = 0x00000004,
}

alias SSUPDATE_TYPE = int;
enum : int
{
    SSUPDATE_ASYNC      = 0x00000001,
    SSUPDATE_CONTINUOUS = 0x00000002,
}

alias DDSFF_FLAGS = int;
enum : int
{
    DDSFF_PROGRESSIVERENDER = 0x00000001,
}

alias AMMSF_MMS_INIT_FLAGS = int;
enum : int
{
    AMMSF_NOGRAPHTHREAD = 0x00000001,
}

alias AMMSF_MS_FLAGS = int;
enum : int
{
    AMMSF_ADDDEFAULTRENDERER = 0x00000001,
    AMMSF_CREATEPEER         = 0x00000002,
    AMMSF_STOPIFNOSAMPLES    = 0x00000004,
    AMMSF_NOSTALL            = 0x00000008,
}

alias AMMSF_RENDER_FLAGS = int;
enum : int
{
    AMMSF_RENDERTYPEMASK   = 0x00000003,
    AMMSF_RENDERTOEXISTING = 0x00000000,
    AMMSF_RENDERALLSTREAMS = 0x00000001,
    AMMSF_NORENDER         = 0x00000002,
    AMMSF_NOCLOCK          = 0x00000004,
    AMMSF_RUN              = 0x00000008,
}

alias OUTPUT_STATE = int;
enum : int
{
    Disabled   = 0x00000000,
    ReadData   = 0x00000001,
    RenderData = 0x00000002,
}

alias AM_PROPERTY_FRAMESTEP = int;
enum : int
{
    AM_PROPERTY_FRAMESTEP_STEP            = 0x00000001,
    AM_PROPERTY_FRAMESTEP_CANCEL          = 0x00000002,
    AM_PROPERTY_FRAMESTEP_CANSTEP         = 0x00000003,
    AM_PROPERTY_FRAMESTEP_CANSTEPMULTIPLE = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpconfig/ne-mpconfig-am_aspect_ratio_mode
alias AM_ASPECT_RATIO_MODE = int;
enum : int
{
    AM_ARMODE_STRETCHED            = 0x00000000,
    AM_ARMODE_LETTER_BOX           = 0x00000001,
    AM_ARMODE_CROP                 = 0x00000002,
    AM_ARMODE_STRETCHED_AS_PRIMARY = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/ne-vmr9-vmr9presentationflags
enum VMR9PresentationFlags : int
{
    VMR9Sample_SyncPoint        = 0x00000001,
    VMR9Sample_Preroll          = 0x00000002,
    VMR9Sample_Discontinuity    = 0x00000004,
    VMR9Sample_TimeValid        = 0x00000008,
    VMR9Sample_SrcDstRectsValid = 0x00000010,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/ne-vmr9-vmr9surfaceallocationflags
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/ne-vmr9-vmr9aspectratiomode
enum VMR9AspectRatioMode : int
{
    VMR9ARMode_None      = 0x00000000,
    VMR9ARMode_LetterBox = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/ne-vmr9-vmr9mixerprefs
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/ne-vmr9-vmr9procampcontrolflags
enum VMR9ProcAmpControlFlags : int
{
    ProcAmpControl9_Brightness = 0x00000001,
    ProcAmpControl9_Contrast   = 0x00000002,
    ProcAmpControl9_Hue        = 0x00000004,
    ProcAmpControl9_Saturation = 0x00000008,
    ProcAmpControl9_Mask       = 0x0000000f,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/ne-vmr9-vmr9alphabitmapflags
enum VMR9AlphaBitmapFlags : int
{
    VMR9AlphaBitmap_Disable     = 0x00000001,
    VMR9AlphaBitmap_hDC         = 0x00000002,
    VMR9AlphaBitmap_EntireDDS   = 0x00000004,
    VMR9AlphaBitmap_SrcColorKey = 0x00000008,
    VMR9AlphaBitmap_SrcRect     = 0x00000010,
    VMR9AlphaBitmap_FilterMode  = 0x00000020,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/ne-vmr9-vmr9renderprefs
enum VMR9RenderPrefs : int
{
    RenderPrefs9_DoNotRenderBorder = 0x00000001,
    RenderPrefs9_Mask              = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/ne-vmr9-vmr9mode
alias VMR9Mode = int;
enum : int
{
    VMR9Mode_Windowed   = 0x00000001,
    VMR9Mode_Windowless = 0x00000002,
    VMR9Mode_Renderless = 0x00000004,
    VMR9Mode_Mask       = 0x00000007,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/ne-vmr9-vmr9deinterlaceprefs
enum VMR9DeinterlacePrefs : int
{
    DeinterlacePref9_NextBest = 0x00000001,
    DeinterlacePref9_BOB      = 0x00000002,
    DeinterlacePref9_Weave    = 0x00000004,
    DeinterlacePref9_Mask     = 0x00000007,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/ne-vmr9-vmr9deinterlacetech
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/ne-vmr9-vmr9_sampleformat
alias VMR9_SampleFormat = int;
enum : int
{
    VMR9_SampleReserved                  = 0x00000001,
    VMR9_SampleProgressiveFrame          = 0x00000002,
    VMR9_SampleFieldInterleavedEvenFirst = 0x00000003,
    VMR9_SampleFieldInterleavedOddFirst  = 0x00000004,
    VMR9_SampleFieldSingleEven           = 0x00000005,
    VMR9_SampleFieldSingleOdd            = 0x00000006,
}

alias AM_PROPERTY_AC3 = int;
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

alias AM_PROPERTY_DVDSUBPIC = int;
enum : int
{
    AM_PROPERTY_DVDSUBPIC_PALETTE     = 0x00000000,
    AM_PROPERTY_DVDSUBPIC_HLI         = 0x00000001,
    AM_PROPERTY_DVDSUBPIC_COMPOSIT_ON = 0x00000002,
}

alias AM_PROPERTY_DVDCOPYPROT = int;
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

alias AM_DIGITAL_CP = int;
enum : int
{
    AM_DIGITAL_CP_OFF           = 0x00000000,
    AM_DIGITAL_CP_ON            = 0x00000001,
    AM_DIGITAL_CP_DVD_COMPLIANT = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvdmedia/ne-dvdmedia-am_dvdcopystate
alias AM_DVDCOPYSTATE = int;
enum : int
{
    AM_DVDCOPYSTATE_INITIALIZE                  = 0x00000000,
    AM_DVDCOPYSTATE_INITIALIZE_TITLE            = 0x00000001,
    AM_DVDCOPYSTATE_AUTHENTICATION_NOT_REQUIRED = 0x00000002,
    AM_DVDCOPYSTATE_AUTHENTICATION_REQUIRED     = 0x00000003,
    AM_DVDCOPYSTATE_DONE                        = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvdmedia/ne-dvdmedia-am_copy_macrovision_level
alias AM_COPY_MACROVISION_LEVEL = int;
enum : int
{
    AM_MACROVISION_DISABLED = 0x00000000,
    AM_MACROVISION_LEVEL1   = 0x00000001,
    AM_MACROVISION_LEVEL2   = 0x00000002,
    AM_MACROVISION_LEVEL3   = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvdmedia/ne-dvdmedia-am_mpeg2level
alias AM_MPEG2Level = int;
enum : int
{
    AM_MPEG2Level_Low      = 0x00000001,
    AM_MPEG2Level_Main     = 0x00000002,
    AM_MPEG2Level_High1440 = 0x00000003,
    AM_MPEG2Level_High     = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvdmedia/ne-dvdmedia-am_mpeg2profile
alias AM_MPEG2Profile = int;
enum : int
{
    AM_MPEG2Profile_Simple            = 0x00000001,
    AM_MPEG2Profile_Main              = 0x00000002,
    AM_MPEG2Profile_SNRScalable       = 0x00000003,
    AM_MPEG2Profile_SpatiallyScalable = 0x00000004,
    AM_MPEG2Profile_High              = 0x00000005,
}

alias AM_PROPERTY_DVDKARAOKE = int;
enum : int
{
    AM_PROPERTY_DVDKARAOKE_ENABLE = 0x00000000,
    AM_PROPERTY_DVDKARAOKE_DATA   = 0x00000001,
}

alias AM_PROPERTY_TS_RATE_CHANGE = int;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvdmedia/ne-dvdmedia-am_property_dvd_rate_change
alias AM_PROPERTY_DVD_RATE_CHANGE = int;
enum : int
{
    AM_RATE_ChangeRate      = 0x00000001,
    AM_RATE_FullDataRateMax = 0x00000002,
    AM_RATE_ReverseDecode   = 0x00000003,
    AM_RATE_DecoderPosition = 0x00000004,
    AM_RATE_DecoderVersion  = 0x00000005,
}

alias DVD_PLAY_DIRECTION = int;
enum : int
{
    DVD_DIR_FORWARD  = 0x00000000,
    DVD_DIR_BACKWARD = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvdevcod/ne-dvdevcod-dvd_error
alias DVD_ERROR = int;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvdevcod/ne-dvdevcod-dvd_warning
alias DVD_WARNING = int;
enum : int
{
    DVD_WARNING_InvalidDVD1_0Disc  = 0x00000001,
    DVD_WARNING_FormatNotSupported = 0x00000002,
    DVD_WARNING_IllegalNavCommand  = 0x00000003,
    DVD_WARNING_Open               = 0x00000004,
    DVD_WARNING_Seek               = 0x00000005,
    DVD_WARNING_Read               = 0x00000006,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvdevcod/ne-dvdevcod-dvd_pb_stopped
alias DVD_PB_STOPPED = int;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/audevcod/ne-audevcod-snddev_err
alias SNDDEV_ERR = int;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/medparam/ne-medparam-mp_type
alias MP_TYPE = int;
enum : int
{
    MPT_INT   = 0x00000000,
    MPT_FLOAT = 0x00000001,
    MPT_BOOL  = 0x00000002,
    MPT_ENUM  = 0x00000003,
    MPT_MAX   = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/medparam/ne-medparam-mp_curve_type
alias MP_CURVE_TYPE = int;
enum : int
{
    MP_CURVE_JUMP      = 0x00000001,
    MP_CURVE_LINEAR    = 0x00000002,
    MP_CURVE_SQUARE    = 0x00000004,
    MP_CURVE_INVSQUARE = 0x00000008,
    MP_CURVE_SINE      = 0x00000010,
}

alias DXVA2_SampleFlags = int;
enum : int
{
    DXVA2_SampleFlag_Palette_Changed     = 0x00000001,
    DXVA2_SampleFlag_SrcRect_Changed     = 0x00000002,
    DXVA2_SampleFlag_DstRect_Changed     = 0x00000004,
    DXVA2_SampleFlag_ColorData_Changed   = 0x00000008,
    DXVA2_SampleFlag_PlanarAlpha_Changed = 0x00000010,
    DXVA2_SampleFlag_RFF                 = 0x00010000,
    DXVA2_SampleFlag_TFF                 = 0x00020000,
    DXVA2_SampleFlag_RFF_TFF_Present     = 0x00040000,
    DXVA2_SampleFlagsMask                = 0xffff001f,
}

alias DXVA2_DestinationFlags = int;
enum : int
{
    DXVA2_DestinationFlag_Background_Changed = 0x00000001,
    DXVA2_DestinationFlag_TargetRect_Changed = 0x00000002,
    DXVA2_DestinationFlag_ColorData_Changed  = 0x00000004,
    DXVA2_DestinationFlag_Alpha_Changed      = 0x00000008,
    DXVA2_DestinationFlag_RFF                = 0x00010000,
    DXVA2_DestinationFlag_TFF                = 0x00020000,
    DXVA2_DestinationFlag_RFF_TFF_Present    = 0x00040000,
    DXVA2_DestinationFlagMask                = 0xffff000f,
}

enum AMPlayListItemFlags : int
{
    AMPLAYLISTITEM_CANSKIP = 0x00000001,
    AMPLAYLISTITEM_CANBIND = 0x00000002,
}

enum AMPlayListFlags : int
{
    AMPLAYLIST_STARTINSCANMODE = 0x00000001,
    AMPLAYLIST_FORCEBANNER     = 0x00000002,
}

enum AMPlayListEventFlags : int
{
    AMPLAYLISTEVENT_RESUME  = 0x00000000,
    AMPLAYLISTEVENT_BREAK   = 0x00000001,
    AMPLAYLISTEVENT_NEXT    = 0x00000002,
    AMPLAYLISTEVENT_MASK    = 0x0000000f,
    AMPLAYLISTEVENT_REFRESH = 0x00000010,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ne-strmif-videoencoder_bitrate_mode
alias VIDEOENCODER_BITRATE_MODE = int;
enum : int
{
    ConstantBitRate        = 0x00000000,
    VariableBitRateAverage = 0x00000001,
    VariableBitRatePeak    = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dxva9typ/ne-dxva9typ-copp_hdcp_protection_level
alias COPP_HDCP_Protection_Level = int;
enum : int
{
    COPP_HDCP_Level0     = 0x00000000,
    COPP_HDCP_LevelMin   = 0x00000000,
    COPP_HDCP_Level1     = 0x00000001,
    COPP_HDCP_LevelMax   = 0x00000001,
    COPP_HDCP_ForceDWORD = 0x7fffffff,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dxva9typ/ne-dxva9typ-copp_cgmsa_protection_level
alias COPP_CGMSA_Protection_Level = int;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dxva9typ/ne-dxva9typ-copp_acp_protection_level
alias COPP_ACP_Protection_Level = int;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dxva9typ/ne-dxva9typ-copp_tvprotectionstandard
alias COPP_TVProtectionStandard = int;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dxva9typ/ne-dxva9typ-copp_imageaspectratio_en300294
alias COPP_ImageAspectRatio_EN300294 = int;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dxva9typ/ne-dxva9typ-copp_statusflags
alias COPP_StatusFlags = int;
enum : int
{
    COPP_StatusNormal          = 0x00000000,
    COPP_LinkLost              = 0x00000001,
    COPP_RenegotiationRequired = 0x00000002,
    COPP_StatusFlagsReserved   = 0xfffffffc,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dxva9typ/ne-dxva9typ-copp_statushdcpflags
alias COPP_StatusHDCPFlags = int;
enum : int
{
    COPP_HDCPRepeater      = 0x00000001,
    COPP_HDCPFlagsReserved = 0xfffffffe,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dxva9typ/ne-dxva9typ-copp_connectortype
alias COPP_ConnectorType = int;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dxva9typ/ne-dxva9typ-copp_bustype
alias COPP_BusType = int;
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

// Constants


enum uint EC_SND_DEVICE_ERROR_BASE = 0x00000200U;

enum : uint
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-snddev-in-error
    EC_SNDDEV_IN_ERROR  = 0x00000200U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-snddev-out-error
    EC_SNDDEV_OUT_ERROR = 0x00000201U,
}

enum uint EC_SYSTEMBASE = 0x00000000U;

enum : uint
{
    EC_USER     = 0x00008000U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-complete
    EC_COMPLETE = 0x00000001U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-userabort
enum uint EC_USERABORT = 0x00000002U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-errorabort
enum uint EC_ERRORABORT = 0x00000003U;

enum : uint
{
    EC_TIME    = 0x00000004U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-repaint
    EC_REPAINT = 0x00000005U,
}

enum : uint
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-stream-error-stopped
    EC_STREAM_ERROR_STOPPED      = 0x00000006U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-stream-error-stillplaying
    EC_STREAM_ERROR_STILLPLAYING = 0x00000007U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-error-stillplaying
enum uint EC_ERROR_STILLPLAYING = 0x00000008U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-palette-changed
enum uint EC_PALETTE_CHANGED = 0x00000009U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-video-size-changed
enum uint EC_VIDEO_SIZE_CHANGED = 0x0000000aU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-quality-change
enum uint EC_QUALITY_CHANGE = 0x0000000bU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-shutting-down
enum uint EC_SHUTTING_DOWN = 0x0000000cU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-clock-changed
enum uint EC_CLOCK_CHANGED = 0x0000000dU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-paused
enum uint EC_PAUSED = 0x0000000eU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-opening-file
enum uint EC_OPENING_FILE = 0x00000010U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-buffering-data
enum uint EC_BUFFERING_DATA = 0x00000011U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-fullscreen-lost
enum uint EC_FULLSCREEN_LOST = 0x00000012U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-activate
enum uint EC_ACTIVATE = 0x00000013U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-need-restart
enum uint EC_NEED_RESTART = 0x00000014U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-window-destroyed
enum uint EC_WINDOW_DESTROYED = 0x00000015U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-display-changed
enum uint EC_DISPLAY_CHANGED = 0x00000016U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-starvation
enum uint EC_STARVATION = 0x00000017U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-ole-event
enum uint EC_OLE_EVENT = 0x00000018U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-notify-window
enum uint EC_NOTIFY_WINDOW = 0x00000019U;

enum : uint
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-stream-control-stopped
    EC_STREAM_CONTROL_STOPPED = 0x0000001aU,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-stream-control-started
    EC_STREAM_CONTROL_STARTED = 0x0000001bU,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-end-of-segment
enum uint EC_END_OF_SEGMENT = 0x0000001cU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-segment-started
enum uint EC_SEGMENT_STARTED = 0x0000001dU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-length-changed
enum uint EC_LENGTH_CHANGED = 0x0000001eU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-device-lost
enum uint EC_DEVICE_LOST = 0x0000001fU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-sample-needed
enum uint EC_SAMPLE_NEEDED = 0x00000020U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-processing-latency
enum uint EC_PROCESSING_LATENCY = 0x00000021U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-sample-latency
enum uint EC_SAMPLE_LATENCY = 0x00000022U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-scrub-time
enum uint EC_SCRUB_TIME = 0x00000023U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-step-complete
enum uint EC_STEP_COMPLETE = 0x00000024U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-timecode-available
enum uint EC_TIMECODE_AVAILABLE = 0x00000030U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-extdevice-mode-change
enum uint EC_EXTDEVICE_MODE_CHANGE = 0x00000031U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-state-change
enum uint EC_STATE_CHANGE = 0x00000032U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-graph-changed
enum uint EC_GRAPH_CHANGED = 0x00000050U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-clock-unset
enum uint EC_CLOCK_UNSET = 0x00000051U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-vmr-renderdevice-set
enum uint EC_VMR_RENDERDEVICE_SET = 0x00000053U;

enum : uint
{
    VMR_RENDER_DEVICE_OVERLAY = 0x00000001U,
    VMR_RENDER_DEVICE_VIDMEM  = 0x00000002U,
    VMR_RENDER_DEVICE_SYSMEM  = 0x00000004U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-vmr-surface-flipped
enum uint EC_VMR_SURFACE_FLIPPED = 0x00000054U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-vmr-reconnection-failed
enum uint EC_VMR_RECONNECTION_FAILED = 0x00000055U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-preprocess-complete
enum uint EC_PREPROCESS_COMPLETE = 0x00000056U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-codecapi-event
enum uint EC_CODECAPI_EVENT = 0x00000057U;

enum : uint
{
    EC_WMT_EVENT_BASE  = 0x00000251U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-wmt-index-event
    EC_WMT_INDEX_EVENT = 0x00000251U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-wmt-event
enum uint EC_WMT_EVENT = 0x00000252U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-built
enum uint EC_BUILT = 0x00000300U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-unbuilt
enum uint EC_UNBUILT = 0x00000301U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-skip-frames
enum uint EC_SKIP_FRAMES = 0x00000025U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-please-reopen
enum uint EC_PLEASE_REOPEN = 0x00000040U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-status
enum uint EC_STATUS = 0x00000041U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-marker-hit
enum uint EC_MARKER_HIT = 0x00000042U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-loadstatus
enum uint EC_LOADSTATUS = 0x00000043U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-file-closed
enum uint EC_FILE_CLOSED = 0x00000044U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-errorabortex
enum uint EC_ERRORABORTEX = 0x00000045U;

enum : uint
{
    AM_LOADSTATUS_CLOSED       = 0x00000000U,
    AM_LOADSTATUS_LOADINGDESCR = 0x00000001U,
    AM_LOADSTATUS_LOADINGMCAST = 0x00000002U,
    AM_LOADSTATUS_LOCATING     = 0x00000003U,
    AM_LOADSTATUS_CONNECTING   = 0x00000004U,
    AM_LOADSTATUS_OPENING      = 0x00000005U,
    AM_LOADSTATUS_OPEN         = 0x00000006U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-new-pin
enum uint EC_NEW_PIN = 0x00000020U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-render-finished
enum uint EC_RENDER_FINISHED = 0x00000021U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-eos-soon
enum uint EC_EOS_SOON = 0x00000046U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-contentproperty-changed
enum uint EC_CONTENTPROPERTY_CHANGED = 0x00000047U;

enum : uint
{
    AM_CONTENTPROPERTY_TITLE       = 0x00000001U,
    AM_CONTENTPROPERTY_AUTHOR      = 0x00000002U,
    AM_CONTENTPROPERTY_COPYRIGHT   = 0x00000004U,
    AM_CONTENTPROPERTY_DESCRIPTION = 0x00000008U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-bandwidthchange
enum uint EC_BANDWIDTHCHANGE = 0x00000048U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-videoframeready
enum uint EC_VIDEOFRAMEREADY = 0x00000049U;

enum : uint
{
    EC_DVDBASE           = 0x00000100U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-dvd-domain-change
    EC_DVD_DOMAIN_CHANGE = 0x00000101U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-dvd-title-change
enum uint EC_DVD_TITLE_CHANGE = 0x00000102U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-dvd-chapter-start
enum uint EC_DVD_CHAPTER_START = 0x00000103U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-dvd-audio-stream-change
enum uint EC_DVD_AUDIO_STREAM_CHANGE = 0x00000104U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-dvd-subpicture-stream-change
enum uint EC_DVD_SUBPICTURE_STREAM_CHANGE = 0x00000105U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-dvd-angle-change
enum uint EC_DVD_ANGLE_CHANGE = 0x00000106U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-dvd-button-change
enum uint EC_DVD_BUTTON_CHANGE = 0x00000107U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-dvd-valid-uops-change
enum uint EC_DVD_VALID_UOPS_CHANGE = 0x00000108U;

enum : uint
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-dvd-still-on
    EC_DVD_STILL_ON     = 0x00000109U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-dvd-still-off
    EC_DVD_STILL_OFF    = 0x0000010aU,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-dvd-current-time
    EC_DVD_CURRENT_TIME = 0x0000010bU,
}

enum : uint
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-dvd-error
    EC_DVD_ERROR            = 0x0000010cU,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-dvd-warning
    EC_DVD_WARNING          = 0x0000010dU,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-dvd-chapter-autostop
    EC_DVD_CHAPTER_AUTOSTOP = 0x0000010eU,
}

enum : uint
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-dvd-no-fp-pgc
    EC_DVD_NO_FP_PGC            = 0x0000010fU,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-dvd-playback-rate-change
    EC_DVD_PLAYBACK_RATE_CHANGE = 0x00000110U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-dvd-parental-level-change
enum uint EC_DVD_PARENTAL_LEVEL_CHANGE = 0x00000111U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-dvd-playback-stopped
enum uint EC_DVD_PLAYBACK_STOPPED = 0x00000112U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-dvd-angles-available
enum uint EC_DVD_ANGLES_AVAILABLE = 0x00000113U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-dvd-playperiod-autostop
enum uint EC_DVD_PLAYPERIOD_AUTOSTOP = 0x00000114U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-dvd-button-auto-activated
enum uint EC_DVD_BUTTON_AUTO_ACTIVATED = 0x00000115U;

enum : uint
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-dvd-cmd-start
    EC_DVD_CMD_START     = 0x00000116U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-dvd-cmd-end
    EC_DVD_CMD_END       = 0x00000117U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-dvd-disc-ejected
    EC_DVD_DISC_EJECTED  = 0x00000118U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-dvd-disc-inserted
    EC_DVD_DISC_INSERTED = 0x00000119U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-dvd-current-hmsf-time
enum uint EC_DVD_CURRENT_HMSF_TIME = 0x0000011aU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-dvd-karaoke-mode
enum uint EC_DVD_KARAOKE_MODE = 0x0000011bU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-dvd-program-cell-change
enum uint EC_DVD_PROGRAM_CELL_CHANGE = 0x0000011cU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-dvd-title-set-change
enum uint EC_DVD_TITLE_SET_CHANGE = 0x0000011dU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-dvd-program-chain-change
enum uint EC_DVD_PROGRAM_CHAIN_CHANGE = 0x0000011eU;

enum : uint
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-dvd-vobu-offset
    EC_DVD_VOBU_Offset    = 0x0000011fU,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-dvd-vobu-timestamp
    EC_DVD_VOBU_Timestamp = 0x00000120U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-dvd-gprm-change
enum uint EC_DVD_GPRM_Change = 0x00000121U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-dvd-sprm-change
enum uint EC_DVD_SPRM_Change = 0x00000122U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-dvd-beginnavigationcommands
enum uint EC_DVD_BeginNavigationCommands = 0x00000123U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/ec-dvd-navigationcommand
enum uint EC_DVD_NavigationCommand = 0x00000124U;

enum : uint
{
    AM_AC3_ALTERNATE_AUDIO_1    = 0x00000001U,
    AM_AC3_ALTERNATE_AUDIO_2    = 0x00000002U,
    AM_AC3_ALTERNATE_AUDIO_BOTH = 0x00000003U,
}

enum : uint
{
    AM_AC3_SERVICE_MAIN_AUDIO        = 0x00000000U,
    AM_AC3_SERVICE_NO_DIALOG         = 0x00000001U,
    AM_AC3_SERVICE_VISUALLY_IMPAIRED = 0x00000002U,
    AM_AC3_SERVICE_HEARING_IMPAIRED  = 0x00000003U,
    AM_AC3_SERVICE_DIALOG_ONLY       = 0x00000004U,
    AM_AC3_SERVICE_COMMENTARY        = 0x00000005U,
    AM_AC3_SERVICE_EMERGENCY_FLASH   = 0x00000006U,
    AM_AC3_SERVICE_VOICE_OVER        = 0x00000007U,
}

enum uint AM_UseNewCSSKey = 0x00000001U;

enum : uint
{
    AM_ReverseBlockStart = 0x00000002U,
    AM_ReverseBlockEnd   = 0x00000004U,
}

enum : uint
{
    AM_DVD_CGMS_RESERVED_MASK     = 0x00000078U,
    AM_DVD_CGMS_COPY_PROTECT_MASK = 0x00000018U,
    AM_DVD_CGMS_COPY_PERMITTED    = 0x00000000U,
    AM_DVD_CGMS_COPY_ONCE         = 0x00000010U,
    AM_DVD_CGMS_NO_COPY           = 0x00000018U,
    AM_DVD_COPYRIGHT_MASK         = 0x00000040U,
}

enum uint AM_DVD_NOT_COPYRIGHTED = 0x00000000U;
enum uint AM_DVD_COPYRIGHTED = 0x00000040U;

enum : uint
{
    AM_DVD_SECTOR_PROTECT_MASK  = 0x00000020U,
    AM_DVD_SECTOR_NOT_PROTECTED = 0x00000000U,
    AM_DVD_SECTOR_PROTECTED     = 0x00000020U,
}

enum : uint
{
    AMINTERLACE_IsInterlaced          = 0x00000001U,
    AMINTERLACE_1FieldPerSample       = 0x00000002U,
    AMINTERLACE_Field1First           = 0x00000004U,
    AMINTERLACE_UNUSED                = 0x00000008U,
    AMINTERLACE_FieldPatternMask      = 0x00000030U,
    AMINTERLACE_FieldPatField1Only    = 0x00000000U,
    AMINTERLACE_FieldPatField2Only    = 0x00000010U,
    AMINTERLACE_FieldPatBothRegular   = 0x00000020U,
    AMINTERLACE_FieldPatBothIrregular = 0x00000030U,
}

enum : uint
{
    AMINTERLACE_DisplayModeMask       = 0x000000c0U,
    AMINTERLACE_DisplayModeBobOnly    = 0x00000000U,
    AMINTERLACE_DisplayModeWeaveOnly  = 0x00000040U,
    AMINTERLACE_DisplayModeBobOrWeave = 0x00000080U,
}

enum uint AMCOPYPROTECT_RestrictDuplication = 0x00000001U;

enum : uint
{
    AMCONTROL_USED              = 0x00000001U,
    AMCONTROL_PAD_TO_4x3        = 0x00000002U,
    AMCONTROL_PAD_TO_16x9       = 0x00000004U,
    AMCONTROL_COLORINFO_PRESENT = 0x00000080U,
}

enum : int
{
    AM_VIDEO_FLAG_FIELD_MASK        = 0x00000003,
    AM_VIDEO_FLAG_INTERLEAVED_FRAME = 0x00000000,
    AM_VIDEO_FLAG_FIELD1            = 0x00000001,
    AM_VIDEO_FLAG_FIELD2            = 0x00000002,
    AM_VIDEO_FLAG_FIELD1FIRST       = 0x00000004,
    AM_VIDEO_FLAG_WEAVE             = 0x00000008,
    AM_VIDEO_FLAG_IPB_MASK          = 0x00000030,
    AM_VIDEO_FLAG_I_SAMPLE          = 0x00000000,
    AM_VIDEO_FLAG_P_SAMPLE          = 0x00000010,
    AM_VIDEO_FLAG_B_SAMPLE          = 0x00000020,
    AM_VIDEO_FLAG_REPEAT_FIELD      = 0x00000040,
}

enum uint AVIF_HASINDEX = 0x00000010U;
enum uint AVIF_MUSTUSEINDEX = 0x00000020U;
enum uint AVIF_ISINTERLEAVED = 0x00000100U;
enum uint AVIF_TRUSTCKTYPE = 0x00000800U;
enum uint AVIF_WASCAPTUREFILE = 0x00010000U;
enum uint AVIF_COPYRIGHTED = 0x00020000U;
enum uint AVI_HEADERSIZE = 0x00000800U;

enum : uint
{
    AVISF_DISABLED         = 0x00000001U,
    AVISF_VIDEO_PALCHANGES = 0x00010000U,
}

enum : int
{
    AVIIF_LIST      = 0x00000001,
    AVIIF_KEYFRAME  = 0x00000010,
    AVIIF_FIRSTPART = 0x00000020,
}

enum : int
{
    AVIIF_LASTPART = 0x00000040,
    AVIIF_NOTIME   = 0x00000100,
    AVIIF_COMPUSE  = 0x0fff0000,
}

enum : uint
{
    AVIIF_NO_TIME    = 0x00000100U,
    AVIIF_COMPRESSOR = 0x0fff0000U,
}

enum : uint
{
    TIMECODE_RATE_30DROP        = 0x00000000U,
    TIMECODE_SMPTE_BINARY_GROUP = 0x00000007U,
    TIMECODE_SMPTE_COLOR_FRAME  = 0x00000008U,
}

enum : uint
{
    AVI_INDEX_OF_INDEXES      = 0x00000000U,
    AVI_INDEX_OF_CHUNKS       = 0x00000001U,
    AVI_INDEX_OF_TIMED_CHUNKS = 0x00000002U,
    AVI_INDEX_OF_SUB_2FIELD   = 0x00000003U,
    AVI_INDEX_IS_DATA         = 0x00000080U,
    AVI_INDEX_SUB_DEFAULT     = 0x00000000U,
    AVI_INDEX_SUB_2FIELD      = 0x00000001U,
}

enum uint STDINDEXSIZE = 0x00004000U;
enum uint AVISTDINDEX_DELTAFRAME = 0x80000000U;
enum uint AMVA_TYPEINDEX_OUTPUTFRAME = 0xffffffffU;
enum uint AMVA_QUERYRENDERSTATUSF_READ = 0x00000001U;
enum uint MIN_DIMENSION = 0x00000001U;
enum int BDA_PLP_ID_NOT_SET = 0xffffffff;
enum uint CDEF_CLASS_DEFAULT = 0x00000001U;
enum uint CDEF_BYPASS_CLASS_MANAGER = 0x00000002U;
enum uint CDEF_MERIT_ABOVE_DO_NOT_USE = 0x00000008U;

enum : uint
{
    CDEF_DEVMON_CMGR_DEVICE    = 0x00000010U,
    CDEF_DEVMON_DMO            = 0x00000020U,
    CDEF_DEVMON_PNP_DEVICE     = 0x00000040U,
    CDEF_DEVMON_FILTER         = 0x00000080U,
    CDEF_DEVMON_SELECTIVE_MASK = 0x000000f0U,
}

enum uint CHARS_IN_GUID = 0x00000027U;
enum uint MAX_PIN_NAME = 0x00000080U;
enum uint MAX_FILTER_NAME = 0x00000080U;
enum uint AM_GBF_PREVFRAMESKIPPED = 0x00000001U;

enum : uint
{
    AM_GBF_NOTASYNCPOINT   = 0x00000002U,
    AM_GBF_NOWAIT          = 0x00000004U,
    AM_GBF_NODDSURFACELOCK = 0x00000008U,
}

enum double AMF_AUTOMATICGAIN = -0x1p+0;

enum : uint
{
    AnalogVideo_NTSC_Mask  = 0x00000007U,
    AnalogVideo_PAL_Mask   = 0x00100ff0U,
    AnalogVideo_SECAM_Mask = 0x000ff000U,
}

enum : uint
{
    MPEG2_PROGRAM_STREAM_MAP           = 0x00000000U,
    MPEG2_PROGRAM_ELEMENTARY_STREAM    = 0x00000001U,
    MPEG2_PROGRAM_DIRECTORY_PES_PACKET = 0x00000002U,
    MPEG2_PROGRAM_PACK_HEADER          = 0x00000003U,
    MPEG2_PROGRAM_PES_STREAM           = 0x00000004U,
    MPEG2_PROGRAM_SYSTEM_HEADER        = 0x00000005U,
}

enum uint SUBSTREAM_FILTER_VAL_NONE = 0x10000000U;
enum uint AM_GETDECODERCAP_QUERY_VMR_SUPPORT = 0x00000001U;
enum uint VMR_NOTSUPPORTED = 0x00000000U;
enum uint VMR_SUPPORTED = 0x00000001U;

enum : uint
{
    AM_QUERY_DECODER_VMR_SUPPORT     = 0x00000001U,
    AM_QUERY_DECODER_DXVA_1_SUPPORT  = 0x00000002U,
    AM_QUERY_DECODER_DVD_SUPPORT     = 0x00000003U,
    AM_QUERY_DECODER_ATSC_SD_SUPPORT = 0x00000004U,
    AM_QUERY_DECODER_ATSC_HD_SUPPORT = 0x00000005U,
}

enum : uint
{
    AM_GETDECODERCAP_QUERY_VMR9_SUPPORT = 0x00000006U,
    AM_GETDECODERCAP_QUERY_EVR_SUPPORT  = 0x00000007U,
}

enum : uint
{
    DECODER_CAP_NOTSUPPORTED = 0x00000000U,
    DECODER_CAP_SUPPORTED    = 0x00000001U,
}

enum : uint
{
    VMRBITMAP_DISABLE     = 0x00000001U,
    VMRBITMAP_HDC         = 0x00000002U,
    VMRBITMAP_ENTIREDDS   = 0x00000004U,
    VMRBITMAP_SRCCOLORKEY = 0x00000008U,
    VMRBITMAP_SRCRECT     = 0x00000010U,
}

enum uint DVD_TITLE_MENU = 0x00000000U;

enum : uint
{
    DVD_STREAM_DATA_CURRENT = 0x00000800U,
    DVD_STREAM_DATA_VMGM    = 0x00000400U,
    DVD_STREAM_DATA_VTSM    = 0x00000401U,
}

enum uint DVD_DEFAULT_AUDIO_STREAM = 0x0000000fU;

enum : uint
{
    DVD_AUDIO_CAPS_AC3   = 0x00000001U,
    DVD_AUDIO_CAPS_MPEG2 = 0x00000002U,
    DVD_AUDIO_CAPS_LPCM  = 0x00000004U,
    DVD_AUDIO_CAPS_DTS   = 0x00000008U,
    DVD_AUDIO_CAPS_SDDS  = 0x00000010U,
}

enum : GUID
{
    MEDIATYPE_MPEG2_PACK     = GUID("36523b13-8ee5-11d1-8ca3-0060b057664a"),
    MEDIATYPE_MPEG2_PES      = GUID("e06d8020-db46-11cf-b4d1-00805f6cbbea"),
    MEDIATYPE_CONTROL        = GUID("e06d8021-db46-11cf-b4d1-00805f6cbbea"),
    MEDIATYPE_MPEG2_SECTIONS = GUID("455f176c-4b06-47ce-9aef-8caef73df7b5"),
}

enum GUID MEDIASUBTYPE_MPEG2_VERSIONED_TABLES = GUID("1ed988b0-3ffc-4523-8725-347beec1a8a0");

enum : GUID
{
    MEDIASUBTYPE_ATSC_SI               = GUID("b3c7397c-d303-414d-b33c-4ed2c9d29733"),
    MEDIASUBTYPE_DVB_SI                = GUID("e9dd31a3-221d-4adb-8532-9af309c1a408"),
    MEDIASUBTYPE_ISDB_SI               = GUID("e89ad298-3601-4b06-aaec-9ddeedcc5bd0"),
    MEDIASUBTYPE_TIF_SI                = GUID("ec232eb2-cb96-4191-b226-0ea129f38250"),
    MEDIASUBTYPE_MPEG2DATA             = GUID("c892e55b-252d-42b5-a316-d997e7a5d995"),
    MEDIASUBTYPE_MPEG2_WMDRM_TRANSPORT = GUID("18bec4ea-4676-450e-b478-0cd84c54b327"),
    MEDIASUBTYPE_MPEG2_VIDEO           = GUID("e06d8026-db46-11cf-b4d1-00805f6cbbea"),
}

enum GUID FORMAT_MPEG2_VIDEO = GUID("e06d80e3-db46-11cf-b4d1-00805f6cbbea");

enum : GUID
{
    MEDIASUBTYPE_MPEG2_PROGRAM                  = GUID("e06d8022-db46-11cf-b4d1-00805f6cbbea"),
    MEDIASUBTYPE_MPEG2_TRANSPORT                = GUID("e06d8023-db46-11cf-b4d1-00805f6cbbea"),
    MEDIASUBTYPE_MPEG2_TRANSPORT_STRIDE         = GUID("138aa9a4-1ee2-4c5b-988e-19abfdbc8a11"),
    MEDIASUBTYPE_MPEG2_UDCR_TRANSPORT           = GUID("18bec4ea-4676-450e-b478-0cd84c54b327"),
    MEDIASUBTYPE_MPEG2_PBDA_TRANSPORT_RAW       = GUID("0d7aed42-cb9a-11db-9705-005056c00008"),
    MEDIASUBTYPE_MPEG2_PBDA_TRANSPORT_PROCESSED = GUID("af748dd4-0d80-11db-9705-005056c00008"),
    MEDIASUBTYPE_MPEG2_AUDIO                    = GUID("e06d802b-db46-11cf-b4d1-00805f6cbbea"),
    MEDIASUBTYPE_DOLBY_AC3                      = GUID("e06d802c-db46-11cf-b4d1-00805f6cbbea"),
    MEDIASUBTYPE_DVD_SUBPICTURE                 = GUID("e06d802d-db46-11cf-b4d1-00805f6cbbea"),
    MEDIASUBTYPE_DVD_LPCM_AUDIO                 = GUID("e06d8032-db46-11cf-b4d1-00805f6cbbea"),
    MEDIASUBTYPE_DTS                            = GUID("e06d8033-db46-11cf-b4d1-00805f6cbbea"),
    MEDIASUBTYPE_SDDS                           = GUID("e06d8034-db46-11cf-b4d1-00805f6cbbea"),
}

enum : GUID
{
    MEDIATYPE_DVD_ENCRYPTED_PACK = GUID("ed0b916a-044d-11d1-aa78-00c04fc31d60"),
    MEDIATYPE_DVD_NAVIGATION     = GUID("e06d802e-db46-11cf-b4d1-00805f6cbbea"),
}

enum : GUID
{
    MEDIASUBTYPE_DVD_NAVIGATION_PCI      = GUID("e06d802f-db46-11cf-b4d1-00805f6cbbea"),
    MEDIASUBTYPE_DVD_NAVIGATION_DSI      = GUID("e06d8030-db46-11cf-b4d1-00805f6cbbea"),
    MEDIASUBTYPE_DVD_NAVIGATION_PROVIDER = GUID("e06d8031-db46-11cf-b4d1-00805f6cbbea"),
}

enum : GUID
{
    FORMAT_MPEG2Video    = GUID("e06d80e3-db46-11cf-b4d1-00805f6cbbea"),
    FORMAT_DolbyAC3      = GUID("e06d80e4-db46-11cf-b4d1-00805f6cbbea"),
    FORMAT_MPEG2Audio    = GUID("e06d80e5-db46-11cf-b4d1-00805f6cbbea"),
    FORMAT_DVD_LPCMAudio = GUID("e06d80e6-db46-11cf-b4d1-00805f6cbbea"),
}

enum GUID FORMAT_UVCH264Video = GUID("2017be05-6629-4248-aaed-7e1a47bc9b9c");

enum : GUID
{
    FORMAT_JPEGImage = GUID("692fa379-d3e8-4651-b5b4-0b94b013eeaf"),
    FORMAT_Image     = GUID("692fa379-d3e8-4651-b5b4-0b94b013eeaf"),
}

enum : GUID
{
    AM_KSPROPSETID_AC3                        = GUID("bfabe720-6e1f-11d0-bcf2-444553540000"),
    AM_KSPROPSETID_DvdSubPic                  = GUID("ac390460-43af-11d0-bd6a-003505c103a9"),
    AM_KSPROPSETID_CopyProt                   = GUID("0e8a0a40-6aef-11d0-9ed0-00a024ca19b3"),
    AM_KSPROPSETID_TSRateChange               = GUID("a503c5c0-1d1d-11d1-ad80-444553540000"),
    AM_KSPROPSETID_DVD_RateChange             = GUID("3577eb09-9582-477f-b29c-b0c452a4ff9a"),
    AM_KSPROPSETID_DvdKaraoke                 = GUID("ae4720ae-aa71-42d8-b82a-fffdf58b76fd"),
    AM_KSPROPSETID_FrameStep                  = GUID("c830acbd-ab07-492f-8852-45b6987c2979"),
    AM_KSPROPSETID_MPEG4_MediaType_Attributes = GUID("ff6c4bfa-07a9-4c7b-a237-672f9d68065f"),
}

enum : GUID
{
    AM_KSCATEGORY_CAPTURE        = GUID("65e8773d-8f56-11d0-a3b9-00a0c9223196"),
    AM_KSCATEGORY_RENDER         = GUID("65e8773e-8f56-11d0-a3b9-00a0c9223196"),
    AM_KSCATEGORY_DATACOMPRESSOR = GUID("1e84c900-7e70-11d0-a5d6-28db04c10000"),
    AM_KSCATEGORY_AUDIO          = GUID("6994ad04-93ef-11d0-a3cc-00a0c9223196"),
    AM_KSCATEGORY_VIDEO          = GUID("6994ad05-93ef-11d0-a3cc-00a0c9223196"),
    AM_KSCATEGORY_TVTUNER        = GUID("a799a800-a46d-11d0-a18c-00a02401dcd4"),
    AM_KSCATEGORY_CROSSBAR       = GUID("a799a801-a46d-11d0-a18c-00a02401dcd4"),
    AM_KSCATEGORY_TVAUDIO        = GUID("a799a802-a46d-11d0-a18c-00a02401dcd4"),
    AM_KSCATEGORY_VBICODEC       = GUID("07dad660-22f1-11d1-a9f4-00c04fbbde8f"),
    AM_KSCATEGORY_VBICODEC_MI    = GUID("9c24a977-0951-451a-8006-0e49bd28cd5f"),
    AM_KSCATEGORY_SPLITTER       = GUID("0a4252a0-7e70-11d0-a5d6-28db04c10000"),
}

enum GUID AM_INTERFACESETID_Standard = GUID("1a8766a0-62ce-11cf-a5d6-28db04c10000");

enum : GUID
{
    PBDA_AUX_CONNECTOR_TYPE_SVideo    = GUID("a0e905f4-24c9-4a54-b761-213355efc13a"),
    PBDA_AUX_CONNECTOR_TYPE_Composite = GUID("f6298b4c-c725-4d42-849b-410bbb14ea62"),
}

enum : GUID
{
    CLSID_PBDA_AUX_DATA_TYPE     = GUID("fd456373-3323-4090-adca-8ed45f55cf10"),
    CLSID_PBDA_Encoder_DATA_TYPE = GUID("728fd6bc-5546-4716-b103-f899f5a1fa68"),
}

enum : uint
{
    PBDA_Encoder_Audio_AlgorithmType_MPEG1LayerII = 0x00000000U,
    PBDA_Encoder_Audio_AlgorithmType_AC3          = 0x00000001U,
}

enum : uint
{
    PBDA_Encoder_Video_MPEG2PartII    = 0x00000000U,
    PBDA_Encoder_Video_MPEG4Part10    = 0x00000001U,
    PBDA_Encoder_Video_AVC            = 0x00000001U,
    PBDA_Encoder_Video_H264           = 0x00000001U,
    PBDA_Encoder_BitrateMode_Constant = 0x00000001U,
    PBDA_Encoder_BitrateMode_Variable = 0x00000002U,
    PBDA_Encoder_BitrateMode_Average  = 0x00000003U,
}

enum : GUID
{
    CLSID_PBDA_FDC_DATA_TYPE  = GUID("e7dbf9a0-22ab-4047-8e67-ef9ad504e729"),
    CLSID_PBDA_GDDS_DATA_TYPE = GUID("c80c0df3-6052-4c16-9f56-c44c21f73c45"),
}

enum : GUID
{
    LIBID_QuartzNetTypeLib = GUID("56a868b1-0ad4-11ce-b03a-0020af0ba770"),
    LIBID_QuartzTypeLib    = GUID("56a868b0-0ad4-11ce-b03a-0020af0ba770"),
}

enum GUID CLSID_AMMultiMediaStream = GUID("49c47ce5-9ba4-11d0-8212-00c04fc32c45");
enum GUID CLSID_AMDirectDrawStream = GUID("49c47ce4-9ba4-11d0-8212-00c04fc32c45");

enum : GUID
{
    CLSID_AMAudioStream     = GUID("8496e040-af4c-11d0-8212-00c04fc32c45"),
    CLSID_AMAudioData       = GUID("f2468580-af8a-11d0-8212-00c04fc32c45"),
    CLSID_AMMediaTypeStream = GUID("cf0f2f7c-f7bf-11d0-900d-00c04fd9189d"),
}

enum : uint
{
    AMDDS_NONE    = 0x00000000U,
    AMDDS_DCIPS   = 0x00000001U,
    AMDDS_PS      = 0x00000002U,
    AMDDS_RGBOVR  = 0x00000004U,
    AMDDS_YUVOVR  = 0x00000008U,
    AMDDS_RGBOFF  = 0x00000010U,
    AMDDS_YUVOFF  = 0x00000020U,
    AMDDS_RGBFLP  = 0x00000040U,
    AMDDS_YUVFLP  = 0x00000080U,
    AMDDS_ALL     = 0x000000ffU,
    AMDDS_DEFAULT = 0x000000ffU,
}

enum uint iPALETTE_COLORS = 0x00000100U;
enum uint iEGA_COLORS = 0x00000010U;
enum uint iMASK_COLORS = 0x00000003U;
enum uint iTRUECOLOR = 0x00000010U;
enum uint iRED = 0x00000000U;
enum uint iGREEN = 0x00000001U;
enum uint iBLUE = 0x00000002U;
enum uint iPALETTE = 0x00000008U;
enum uint iMAXBITS = 0x00000008U;
enum uint MAX_SIZE_MPEG1_SEQUENCE_INFO = 0x0000008cU;

enum : GUID
{
    CLSID_DMOWrapperFilter  = GUID("94297043-bd82-4dfd-b0de-8177739c6d20"),
    CLSID_DMOFilterCategory = GUID("bcd5796c-bd52-4d30-ab76-70f975b89199"),
}

enum : uint
{
    AM_MPEG_AUDIO_DUAL_MERGE = 0x00000000U,
    AM_MPEG_AUDIO_DUAL_LEFT  = 0x00000001U,
    AM_MPEG_AUDIO_DUAL_RIGHT = 0x00000002U,
}

enum uint VFW_FIRST_CODE = 0x00000200U;
enum uint MAX_ERROR_TEXT_LEN = 0x000000a0U;

enum : uint
{
    MPBOOL_TRUE  = 0x00000001U,
    MPBOOL_FALSE = 0x00000000U,
}

enum int DWORD_ALLPARAMS = 0xffffffff;

enum : GUID
{
    GUID_TIME_REFERENCE = GUID("93ad712b-daa0-4ffe-bc81-b0ce500fcdd9"),
    GUID_TIME_MUSIC     = GUID("0574c49d-5b04-4b15-a542-ae282030117b"),
    GUID_TIME_SAMPLES   = GUID("a8593d05-0c43-4984-9a63-97af9e02c4c0"),
}

enum : uint
{
    MPF_ENVLP_STANDARD         = 0x00000000U,
    MPF_ENVLP_BEGIN_CURRENTVAL = 0x00000001U,
    MPF_ENVLP_BEGIN_NEUTRALVAL = 0x00000002U,
}

enum : uint
{
    MPF_PUNCHIN_REFTIME = 0x00000000U,
    MPF_PUNCHIN_NOW     = 0x00000001U,
    MPF_PUNCHIN_STOPPED = 0x00000002U,
}

enum : GUID
{
    MSPID_PrimaryVideo = GUID("a35ff56a-9fda-11d0-8fdf-00c04fd9189d"),
    MSPID_PrimaryAudio = GUID("a35ff56b-9fda-11d0-8fdf-00c04fd9189d"),
}

enum : HRESULT
{
    VFW_E_INVALIDMEDIATYPE = HRESULT(0x80040200),
    VFW_E_INVALIDSUBTYPE   = HRESULT(0x80040201),
}

enum HRESULT VFW_E_NEED_OWNER = HRESULT(0x80040202);
enum HRESULT VFW_E_ENUM_OUT_OF_SYNC = HRESULT(0x80040203);
enum HRESULT VFW_E_ALREADY_CONNECTED = HRESULT(0x80040204);
enum HRESULT VFW_E_FILTER_ACTIVE = HRESULT(0x80040205);

enum : HRESULT
{
    VFW_E_NO_TYPES            = HRESULT(0x80040206),
    VFW_E_NO_ACCEPTABLE_TYPES = HRESULT(0x80040207),
}

enum HRESULT VFW_E_INVALID_DIRECTION = HRESULT(0x80040208);

enum : HRESULT
{
    VFW_E_NOT_CONNECTED = HRESULT(0x80040209),
    VFW_E_NO_ALLOCATOR  = HRESULT(0x8004020a),
}

enum HRESULT VFW_E_RUNTIME_ERROR = HRESULT(0x8004020b);

enum : HRESULT
{
    VFW_E_BUFFER_NOTSET   = HRESULT(0x8004020c),
    VFW_E_BUFFER_OVERFLOW = HRESULT(0x8004020d),
}

enum : HRESULT
{
    VFW_E_BADALIGN          = HRESULT(0x8004020e),
    VFW_E_ALREADY_COMMITTED = HRESULT(0x8004020f),
}

enum HRESULT VFW_E_BUFFERS_OUTSTANDING = HRESULT(0x80040210);
enum HRESULT VFW_E_NOT_COMMITTED = HRESULT(0x80040211);
enum HRESULT VFW_E_SIZENOTSET = HRESULT(0x80040212);

enum : HRESULT
{
    VFW_E_NO_CLOCK     = HRESULT(0x80040213),
    VFW_E_NO_SINK      = HRESULT(0x80040214),
    VFW_E_NO_INTERFACE = HRESULT(0x80040215),
    VFW_E_NOT_FOUND    = HRESULT(0x80040216),
}

enum : HRESULT
{
    VFW_E_CANNOT_CONNECT = HRESULT(0x80040217),
    VFW_E_CANNOT_RENDER  = HRESULT(0x80040218),
}

enum HRESULT VFW_E_CHANGING_FORMAT = HRESULT(0x80040219);
enum HRESULT VFW_E_NO_COLOR_KEY_SET = HRESULT(0x8004021a);
enum HRESULT VFW_E_NOT_OVERLAY_CONNECTION = HRESULT(0x8004021b);
enum HRESULT VFW_E_NOT_SAMPLE_CONNECTION = HRESULT(0x8004021c);
enum HRESULT VFW_E_PALETTE_SET = HRESULT(0x8004021d);
enum HRESULT VFW_E_COLOR_KEY_SET = HRESULT(0x8004021e);
enum HRESULT VFW_E_NO_COLOR_KEY_FOUND = HRESULT(0x8004021f);
enum HRESULT VFW_E_NO_PALETTE_AVAILABLE = HRESULT(0x80040220);
enum HRESULT VFW_E_NO_DISPLAY_PALETTE = HRESULT(0x80040221);
enum HRESULT VFW_E_TOO_MANY_COLORS = HRESULT(0x80040222);
enum HRESULT VFW_E_STATE_CHANGED = HRESULT(0x80040223);

enum : HRESULT
{
    VFW_E_NOT_STOPPED = HRESULT(0x80040224),
    VFW_E_NOT_PAUSED  = HRESULT(0x80040225),
    VFW_E_NOT_RUNNING = HRESULT(0x80040226),
}

enum HRESULT VFW_E_WRONG_STATE = HRESULT(0x80040227);
enum HRESULT VFW_E_START_TIME_AFTER_END = HRESULT(0x80040228);
enum HRESULT VFW_E_INVALID_RECT = HRESULT(0x80040229);
enum HRESULT VFW_E_TYPE_NOT_ACCEPTED = HRESULT(0x8004022a);

enum : HRESULT
{
    VFW_E_SAMPLE_REJECTED     = HRESULT(0x8004022b),
    VFW_E_SAMPLE_REJECTED_EOS = HRESULT(0x8004022c),
}

enum HRESULT VFW_E_DUPLICATE_NAME = HRESULT(0x8004022d);
enum HRESULT VFW_S_DUPLICATE_NAME = HRESULT(0x0004022d);

enum : HRESULT
{
    VFW_E_TIMEOUT             = HRESULT(0x8004022e),
    VFW_E_INVALID_FILE_FORMAT = HRESULT(0x8004022f),
}

enum HRESULT VFW_E_ENUM_OUT_OF_RANGE = HRESULT(0x80040230);
enum HRESULT VFW_E_CIRCULAR_GRAPH = HRESULT(0x80040231);
enum HRESULT VFW_E_NOT_ALLOWED_TO_SAVE = HRESULT(0x80040232);
enum HRESULT VFW_E_TIME_ALREADY_PASSED = HRESULT(0x80040233);
enum HRESULT VFW_E_ALREADY_CANCELLED = HRESULT(0x80040234);
enum HRESULT VFW_E_CORRUPT_GRAPH_FILE = HRESULT(0x80040235);
enum HRESULT VFW_E_ADVISE_ALREADY_SET = HRESULT(0x80040236);
enum HRESULT VFW_S_STATE_INTERMEDIATE = HRESULT(0x00040237);
enum HRESULT VFW_E_NO_MODEX_AVAILABLE = HRESULT(0x80040238);

enum : HRESULT
{
    VFW_E_NO_ADVISE_SET = HRESULT(0x80040239),
    VFW_E_NO_FULLSCREEN = HRESULT(0x8004023a),
}

enum HRESULT VFW_E_IN_FULLSCREEN_MODE = HRESULT(0x8004023b);
enum HRESULT VFW_E_UNKNOWN_FILE_TYPE = HRESULT(0x80040240);
enum HRESULT VFW_E_CANNOT_LOAD_SOURCE_FILTER = HRESULT(0x80040241);
enum HRESULT VFW_S_PARTIAL_RENDER = HRESULT(0x00040242);
enum HRESULT VFW_E_FILE_TOO_SHORT = HRESULT(0x80040243);
enum HRESULT VFW_E_INVALID_FILE_VERSION = HRESULT(0x80040244);
enum HRESULT VFW_S_SOME_DATA_IGNORED = HRESULT(0x00040245);
enum HRESULT VFW_S_CONNECTIONS_DEFERRED = HRESULT(0x00040246);

enum : HRESULT
{
    VFW_E_INVALID_CLSID      = HRESULT(0x80040247),
    VFW_E_INVALID_MEDIA_TYPE = HRESULT(0x80040248),
}

enum HRESULT VFW_E_BAD_KEY = HRESULT(0x800403f2);
enum HRESULT VFW_S_NO_MORE_ITEMS = HRESULT(0x00040103);
enum HRESULT VFW_E_SAMPLE_TIME_NOT_SET = HRESULT(0x80040249);
enum HRESULT VFW_S_RESOURCE_NOT_NEEDED = HRESULT(0x00040250);
enum HRESULT VFW_E_MEDIA_TIME_NOT_SET = HRESULT(0x80040251);
enum HRESULT VFW_E_NO_TIME_FORMAT_SET = HRESULT(0x80040252);
enum HRESULT VFW_E_MONO_AUDIO_HW = HRESULT(0x80040253);
enum HRESULT VFW_S_MEDIA_TYPE_IGNORED = HRESULT(0x00040254);

enum : HRESULT
{
    VFW_E_NO_DECOMPRESSOR   = HRESULT(0x80040255),
    VFW_E_NO_AUDIO_HARDWARE = HRESULT(0x80040256),
}

enum HRESULT VFW_S_VIDEO_NOT_RENDERED = HRESULT(0x00040257);
enum HRESULT VFW_S_AUDIO_NOT_RENDERED = HRESULT(0x00040258);
enum HRESULT VFW_E_RPZA = HRESULT(0x80040259);
enum HRESULT VFW_S_RPZA = HRESULT(0x0004025a);
enum HRESULT VFW_E_PROCESSOR_NOT_SUITABLE = HRESULT(0x8004025b);

enum : HRESULT
{
    VFW_E_UNSUPPORTED_AUDIO = HRESULT(0x8004025c),
    VFW_E_UNSUPPORTED_VIDEO = HRESULT(0x8004025d),
}

enum HRESULT VFW_E_MPEG_NOT_CONSTRAINED = HRESULT(0x8004025e);
enum HRESULT VFW_E_NOT_IN_GRAPH = HRESULT(0x8004025f);
enum HRESULT VFW_S_ESTIMATED = HRESULT(0x00040260);
enum HRESULT VFW_E_NO_TIME_FORMAT = HRESULT(0x80040261);
enum HRESULT VFW_E_READ_ONLY = HRESULT(0x80040262);
enum HRESULT VFW_S_RESERVED = HRESULT(0x00040263);
enum HRESULT VFW_E_BUFFER_UNDERFLOW = HRESULT(0x80040264);
enum HRESULT VFW_E_UNSUPPORTED_STREAM = HRESULT(0x80040265);
enum HRESULT VFW_E_NO_TRANSPORT = HRESULT(0x80040266);
enum HRESULT VFW_S_STREAM_OFF = HRESULT(0x00040267);
enum HRESULT VFW_S_CANT_CUE = HRESULT(0x00040268);
enum HRESULT VFW_E_BAD_VIDEOCD = HRESULT(0x80040269);
enum HRESULT VFW_S_NO_STOP_TIME = HRESULT(0x00040270);
enum HRESULT VFW_E_OUT_OF_VIDEO_MEMORY = HRESULT(0x80040271);
enum HRESULT VFW_E_VP_NEGOTIATION_FAILED = HRESULT(0x80040272);
enum HRESULT VFW_E_DDRAW_CAPS_NOT_SUITABLE = HRESULT(0x80040273);

enum : HRESULT
{
    VFW_E_NO_VP_HARDWARE      = HRESULT(0x80040274),
    VFW_E_NO_CAPTURE_HARDWARE = HRESULT(0x80040275),
}

enum HRESULT VFW_E_DVD_OPERATION_INHIBITED = HRESULT(0x80040276);

enum : HRESULT
{
    VFW_E_DVD_INVALIDDOMAIN = HRESULT(0x80040277),
    VFW_E_DVD_NO_BUTTON     = HRESULT(0x80040278),
    VFW_E_DVD_GRAPHNOTREADY = HRESULT(0x80040279),
    VFW_E_DVD_RENDERFAIL    = HRESULT(0x8004027a),
    VFW_E_DVD_DECNOTENOUGH  = HRESULT(0x8004027b),
}

enum HRESULT VFW_E_DDRAW_VERSION_NOT_SUITABLE = HRESULT(0x8004027c);
enum HRESULT VFW_E_COPYPROT_FAILED = HRESULT(0x8004027d);
enum HRESULT VFW_S_NOPREVIEWPIN = HRESULT(0x0004027e);
enum HRESULT VFW_E_TIME_EXPIRED = HRESULT(0x8004027f);
enum HRESULT VFW_S_DVD_NON_ONE_SEQUENTIAL = HRESULT(0x00040280);

enum : HRESULT
{
    VFW_E_DVD_WRONG_SPEED         = HRESULT(0x80040281),
    VFW_E_DVD_MENU_DOES_NOT_EXIST = HRESULT(0x80040282),
}

enum : HRESULT
{
    VFW_E_DVD_CMD_CANCELLED       = HRESULT(0x80040283),
    VFW_E_DVD_STATE_WRONG_VERSION = HRESULT(0x80040284),
    VFW_E_DVD_STATE_CORRUPT       = HRESULT(0x80040285),
    VFW_E_DVD_STATE_WRONG_DISC    = HRESULT(0x80040286),
}

enum HRESULT VFW_E_DVD_INCOMPATIBLE_REGION = HRESULT(0x80040287);

enum : HRESULT
{
    VFW_E_DVD_NO_ATTRIBUTES      = HRESULT(0x80040288),
    VFW_E_DVD_NO_GOUP_PGC        = HRESULT(0x80040289),
    VFW_E_DVD_LOW_PARENTAL_LEVEL = HRESULT(0x8004028a),
}

enum HRESULT VFW_E_DVD_NOT_IN_KARAOKE_MODE = HRESULT(0x8004028b);
enum HRESULT VFW_S_DVD_CHANNEL_CONTENTS_NOT_AVAILABLE = HRESULT(0x0004028c);
enum HRESULT VFW_S_DVD_NOT_ACCURATE = HRESULT(0x0004028d);
enum HRESULT VFW_E_FRAME_STEP_UNSUPPORTED = HRESULT(0x8004028e);
enum HRESULT VFW_E_DVD_STREAM_DISABLED = HRESULT(0x8004028f);

enum : HRESULT
{
    VFW_E_DVD_TITLE_UNKNOWN         = HRESULT(0x80040290),
    VFW_E_DVD_INVALID_DISC          = HRESULT(0x80040291),
    VFW_E_DVD_NO_RESUME_INFORMATION = HRESULT(0x80040292),
}

enum : HRESULT
{
    VFW_E_PIN_ALREADY_BLOCKED_ON_THIS_THREAD = HRESULT(0x80040293),
    VFW_E_PIN_ALREADY_BLOCKED                = HRESULT(0x80040294),
}

enum HRESULT VFW_E_CERTIFICATION_FAILURE = HRESULT(0x80040295);

enum : HRESULT
{
    VFW_E_VMR_NOT_IN_MIXER_MODE = HRESULT(0x80040296),
    VFW_E_VMR_NO_AP_SUPPLIED    = HRESULT(0x80040297),
    VFW_E_VMR_NO_DEINTERLACE_HW = HRESULT(0x80040298),
    VFW_E_VMR_NO_PROCAMP_HW     = HRESULT(0x80040299),
}

enum HRESULT VFW_E_DVD_VMR9_INCOMPATIBLEDEC = HRESULT(0x8004029a);
enum HRESULT VFW_E_NO_COPP_HW = HRESULT(0x8004029b);

enum : HRESULT
{
    VFW_E_DVD_NONBLOCKING                        = HRESULT(0x8004029c),
    VFW_E_DVD_TOO_MANY_RENDERERS_IN_FILTER_GRAPH = HRESULT(0x8004029d),
}

enum HRESULT VFW_E_DVD_NON_EVR_RENDERER_IN_FILTER_GRAPH = HRESULT(0x8004029e);
enum HRESULT VFW_E_DVD_RESOLUTION_ERROR = HRESULT(0x8004029f);
enum HRESULT E_PROP_SET_UNSUPPORTED = HRESULT(0x80070492);
enum HRESULT E_PROP_ID_UNSUPPORTED = HRESULT(0x80070490);

enum : HRESULT
{
    VFW_E_CODECAPI_LINEAR_RANGE     = HRESULT(0x80040310),
    VFW_E_CODECAPI_ENUMERATED       = HRESULT(0x80040311),
    VFW_E_CODECAPI_NO_DEFAULT       = HRESULT(0x80040313),
    VFW_E_CODECAPI_NO_CURRENT_VALUE = HRESULT(0x80040314),
}

enum HRESULT VFW_E_DVD_CHAPTER_DOES_NOT_EXIST = HRESULT(0x80040315);
enum HRESULT VFW_S_DVD_RENDER_STATUS = HRESULT(0x00040320);
// Native encoding: ansi
enum const(wchar)* CFSTR_VFW_FILTERLIST = "Video for Windows 4 Filters";

enum : GUID
{
    DXVA_ModeNone                              = GUID("1b81be00-a0c7-11d3-b984-00c04f2e73c5"),
    DXVA_ModeH261_A                            = GUID("1b81be01-a0c7-11d3-b984-00c04f2e73c5"),
    DXVA_ModeH261_B                            = GUID("1b81be02-a0c7-11d3-b984-00c04f2e73c5"),
    DXVA_ModeH263_A                            = GUID("1b81be03-a0c7-11d3-b984-00c04f2e73c5"),
    DXVA_ModeH263_B                            = GUID("1b81be04-a0c7-11d3-b984-00c04f2e73c5"),
    DXVA_ModeH263_C                            = GUID("1b81be05-a0c7-11d3-b984-00c04f2e73c5"),
    DXVA_ModeH263_D                            = GUID("1b81be06-a0c7-11d3-b984-00c04f2e73c5"),
    DXVA_ModeH263_E                            = GUID("1b81be07-a0c7-11d3-b984-00c04f2e73c5"),
    DXVA_ModeH263_F                            = GUID("1b81be08-a0c7-11d3-b984-00c04f2e73c5"),
    DXVA_ModeMPEG1_A                           = GUID("1b81be09-a0c7-11d3-b984-00c04f2e73c5"),
    DXVA_ModeMPEG1_VLD                         = GUID("6f3ec719-3735-42cc-8063-65cc3cb36616"),
    DXVA_ModeMPEG2_A                           = GUID("1b81be0a-a0c7-11d3-b984-00c04f2e73c5"),
    DXVA_ModeMPEG2_B                           = GUID("1b81be0b-a0c7-11d3-b984-00c04f2e73c5"),
    DXVA_ModeMPEG2_C                           = GUID("1b81be0c-a0c7-11d3-b984-00c04f2e73c5"),
    DXVA_ModeMPEG2_D                           = GUID("1b81be0d-a0c7-11d3-b984-00c04f2e73c5"),
    DXVA_ModeMPEG2and1_VLD                     = GUID("86695f12-340e-4f04-9fd3-9253dd327460"),
    DXVA_ModeH264_A                            = GUID("1b81be64-a0c7-11d3-b984-00c04f2e73c5"),
    DXVA_ModeH264_B                            = GUID("1b81be65-a0c7-11d3-b984-00c04f2e73c5"),
    DXVA_ModeH264_C                            = GUID("1b81be66-a0c7-11d3-b984-00c04f2e73c5"),
    DXVA_ModeH264_D                            = GUID("1b81be67-a0c7-11d3-b984-00c04f2e73c5"),
    DXVA_ModeH264_E                            = GUID("1b81be68-a0c7-11d3-b984-00c04f2e73c5"),
    DXVA_ModeH264_F                            = GUID("1b81be69-a0c7-11d3-b984-00c04f2e73c5"),
    DXVA_ModeH264_VLD_WithFMOASO_NoFGT         = GUID("d5f04ff9-3418-45d8-9561-32a76aae2ddd"),
    DXVA_ModeH264_VLD_Stereo_Progressive_NoFGT = GUID("d79be8da-0cf1-4c81-b82a-69a4e236f43d"),
    DXVA_ModeH264_VLD_Stereo_NoFGT             = GUID("f9aaccbb-c2b6-4cfc-8779-5707b1760552"),
    DXVA_ModeH264_VLD_Multiview_NoFGT          = GUID("705b9d82-76cf-49d6-b7e6-ac8872db013c"),
}

enum : GUID
{
    DXVA_ModeWMV8_A                       = GUID("1b81be80-a0c7-11d3-b984-00c04f2e73c5"),
    DXVA_ModeWMV8_B                       = GUID("1b81be81-a0c7-11d3-b984-00c04f2e73c5"),
    DXVA_ModeWMV9_A                       = GUID("1b81be90-a0c7-11d3-b984-00c04f2e73c5"),
    DXVA_ModeWMV9_B                       = GUID("1b81be91-a0c7-11d3-b984-00c04f2e73c5"),
    DXVA_ModeWMV9_C                       = GUID("1b81be94-a0c7-11d3-b984-00c04f2e73c5"),
    DXVA_ModeVC1_A                        = GUID("1b81bea0-a0c7-11d3-b984-00c04f2e73c5"),
    DXVA_ModeVC1_B                        = GUID("1b81bea1-a0c7-11d3-b984-00c04f2e73c5"),
    DXVA_ModeVC1_C                        = GUID("1b81bea2-a0c7-11d3-b984-00c04f2e73c5"),
    DXVA_ModeVC1_D                        = GUID("1b81bea3-a0c7-11d3-b984-00c04f2e73c5"),
    DXVA_ModeVC1_D2010                    = GUID("1b81bea4-a0c7-11d3-b984-00c04f2e73c5"),
    DXVA_ModeMPEG4pt2_VLD_Simple          = GUID("efd64d74-c9e8-41d7-a5e9-e9b0e39fa319"),
    DXVA_ModeMPEG4pt2_VLD_AdvSimple_NoGMC = GUID("ed418a9f-010d-4eda-9ae3-9a65358d8d2e"),
    DXVA_ModeMPEG4pt2_VLD_AdvSimple_GMC   = GUID("ab998b5b-4258-44a9-9feb-94e597a6baae"),
}

enum : GUID
{
    DXVA_ModeHEVC_VLD_Main         = GUID("5b11d51b-2f4c-4452-bcc3-09f2a1160cc0"),
    DXVA_ModeHEVC_VLD_Main10       = GUID("107af0e0-ef1a-4d19-aba8-67a163073d13"),
    DXVA_ModeHEVC_VLD_Monochrome   = GUID("0685b993-3d8c-43a0-8b28-d74c2d6899a4"),
    DXVA_ModeHEVC_VLD_Monochrome10 = GUID("142a1d0f-69dd-4ec9-8591-b12ffcb91a29"),
    DXVA_ModeHEVC_VLD_Main12       = GUID("1a72925f-0c2c-4f15-96fb-b17d1473603f"),
    DXVA_ModeHEVC_VLD_Main10_422   = GUID("0bac4fe5-1532-4429-a854-f84de04953db"),
    DXVA_ModeHEVC_VLD_Main12_422   = GUID("55bcac81-f311-4093-a7d0-1cbc0b849bee"),
    DXVA_ModeHEVC_VLD_Main_444     = GUID("4008018f-f537-4b36-98cf-61af8a2c1a33"),
    DXVA_ModeHEVC_VLD_Main10_Ext   = GUID("9cc55490-e37c-4932-8684-4920f9f6409c"),
    DXVA_ModeHEVC_VLD_Main10_444   = GUID("0dabeffa-4458-4602-bc03-0795659d617c"),
    DXVA_ModeHEVC_VLD_Main12_444   = GUID("9798634d-fe9d-48e5-b4da-dbec45b3df01"),
    DXVA_ModeHEVC_VLD_Main16       = GUID("a4fbdbb0-a113-482b-a232-635cc0697f6d"),
}

enum : GUID
{
    DXVA_ModeVP9_VLD_Profile0       = GUID("463707f8-a1d0-4585-876d-83aa6d60b89e"),
    DXVA_ModeVP9_VLD_10bit_Profile2 = GUID("a4c749ef-6ecf-48aa-8448-50a7a1165ff7"),
}

enum : GUID
{
    DXVA_ModeVP8_VLD                    = GUID("90b899ea-3a62-4705-88b3-8df04b2744e7"),
    DXVA_ModeAV1_VLD_Profile0           = GUID("b8be4ccb-cf53-46ba-8d59-d6b8a6da5d2a"),
    DXVA_ModeAV1_VLD_Profile1           = GUID("6936ff0f-45b1-4163-9cc1-646ef6946108"),
    DXVA_ModeAV1_VLD_Profile2           = GUID("0c5f2aa1-e541-4089-bb7b-98110a19d7c8"),
    DXVA_ModeAV1_VLD_12bit_Profile2     = GUID("17127009-a00f-4ce1-994e-bf4081f6f3f0"),
    DXVA_ModeAV1_VLD_12bit_Profile2_420 = GUID("2d80bed6-9cac-4835-9e91-327bbc4f9ee8"),
}

enum : GUID
{
    DXVA_ModeMJPEG_VLD_420  = GUID("725cb506-0c29-43c4-9440-8e9397903a04"),
    DXVA_ModeMJPEG_VLD_422  = GUID("5b77b9cd-1a35-4c30-9fd8-ef4b60c035dd"),
    DXVA_ModeMJPEG_VLD_444  = GUID("d95161f9-0d44-47e6-bcf5-1bfbfb268f97"),
    DXVA_ModeMJPEG_VLD_4444 = GUID("c91748d5-fd18-4aca-9db3-3a6634ab547d"),
}

enum : GUID
{
    DXVA_ModeJPEG_VLD_420 = GUID("cf782c83-bef5-4a2c-87cb-6019e7b175ac"),
    DXVA_ModeJPEG_VLD_422 = GUID("f04df417-eee2-4067-a778-f35c15ab9721"),
    DXVA_ModeJPEG_VLD_444 = GUID("4cd00e17-89ba-48ef-b9f9-edcb82713f65"),
}

enum GUID DXVA_NoEncrypt = GUID("1b81bed0-a0c7-11d3-b984-00c04f2e73c5");

enum : uint
{
    DXVA_RESTRICTED_MODE_UNRESTRICTED                      = 0x0000ffffU,
    DXVA_RESTRICTED_MODE_H261_A                            = 0x00000001U,
    DXVA_RESTRICTED_MODE_H261_B                            = 0x00000002U,
    DXVA_RESTRICTED_MODE_H263_A                            = 0x00000003U,
    DXVA_RESTRICTED_MODE_H263_B                            = 0x00000004U,
    DXVA_RESTRICTED_MODE_H263_C                            = 0x00000005U,
    DXVA_RESTRICTED_MODE_H263_D                            = 0x00000006U,
    DXVA_RESTRICTED_MODE_H263_E                            = 0x00000007U,
    DXVA_RESTRICTED_MODE_H263_F                            = 0x00000008U,
    DXVA_RESTRICTED_MODE_MPEG1_A                           = 0x00000009U,
    DXVA_RESTRICTED_MODE_MPEG2_A                           = 0x0000000aU,
    DXVA_RESTRICTED_MODE_MPEG2_B                           = 0x0000000bU,
    DXVA_RESTRICTED_MODE_MPEG2_C                           = 0x0000000cU,
    DXVA_RESTRICTED_MODE_MPEG2_D                           = 0x0000000dU,
    DXVA_RESTRICTED_MODE_MPEG1_VLD                         = 0x00000010U,
    DXVA_RESTRICTED_MODE_MPEG2and1_VLD                     = 0x00000011U,
    DXVA_RESTRICTED_MODE_H264_A                            = 0x00000064U,
    DXVA_RESTRICTED_MODE_H264_B                            = 0x00000065U,
    DXVA_RESTRICTED_MODE_H264_C                            = 0x00000066U,
    DXVA_RESTRICTED_MODE_H264_D                            = 0x00000067U,
    DXVA_RESTRICTED_MODE_H264_E                            = 0x00000068U,
    DXVA_RESTRICTED_MODE_H264_F                            = 0x00000069U,
    DXVA_RESTRICTED_MODE_H264_VLD_WITHFMOASO_NOFGT         = 0x00000070U,
    DXVA_RESTRICTED_MODE_H264_VLD_STEREO_PROGRESSIVE_NOFGT = 0x00000071U,
    DXVA_RESTRICTED_MODE_H264_VLD_STEREO_NOFGT             = 0x00000072U,
    DXVA_RESTRICTED_MODE_H264_VLD_MULTIVIEW_NOFGT          = 0x00000073U,
    DXVA_RESTRICTED_MODE_WMV8_A                            = 0x00000080U,
    DXVA_RESTRICTED_MODE_WMV8_B                            = 0x00000081U,
    DXVA_RESTRICTED_MODE_WMV9_A                            = 0x00000090U,
    DXVA_RESTRICTED_MODE_WMV9_B                            = 0x00000091U,
    DXVA_RESTRICTED_MODE_WMV9_C                            = 0x00000094U,
    DXVA_RESTRICTED_MODE_VC1_A                             = 0x000000a0U,
    DXVA_RESTRICTED_MODE_VC1_B                             = 0x000000a1U,
    DXVA_RESTRICTED_MODE_VC1_C                             = 0x000000a2U,
    DXVA_RESTRICTED_MODE_VC1_D                             = 0x000000a3U,
    DXVA_RESTRICTED_MODE_VC1_D2010                         = 0x000000a4U,
    DXVA_RESTRICTED_MODE_MPEG4PT2_VLD_SIMPLE               = 0x000000b0U,
    DXVA_RESTRICTED_MODE_MPEG4PT2_VLD_ADV_SIMPLE_NOGMC     = 0x000000b1U,
    DXVA_RESTRICTED_MODE_MPEG4PT2_VLD_ADV_SIMPLE_GMC       = 0x000000b2U,
    DXVA_RESTRICTED_MODE_WMV8_POSTPROC                     = 0x00000080U,
    DXVA_RESTRICTED_MODE_WMV8_MOCOMP                       = 0x00000081U,
    DXVA_RESTRICTED_MODE_WMV9_POSTPROC                     = 0x00000090U,
    DXVA_RESTRICTED_MODE_WMV9_MOCOMP                       = 0x00000091U,
    DXVA_RESTRICTED_MODE_WMV9_IDCT                         = 0x00000094U,
    DXVA_RESTRICTED_MODE_VC1_POSTPROC                      = 0x000000a0U,
    DXVA_RESTRICTED_MODE_VC1_MOCOMP                        = 0x000000a1U,
    DXVA_RESTRICTED_MODE_VC1_IDCT                          = 0x000000a2U,
    DXVA_RESTRICTED_MODE_VC1_VLD                           = 0x000000a3U,
    DXVA_RESTRICTED_MODE_H264_MOCOMP_NOFGT                 = 0x00000064U,
    DXVA_RESTRICTED_MODE_H264_MOCOMP_FGT                   = 0x00000065U,
    DXVA_RESTRICTED_MODE_H264_IDCT_NOFGT                   = 0x00000066U,
    DXVA_RESTRICTED_MODE_H264_IDCT_FGT                     = 0x00000067U,
    DXVA_RESTRICTED_MODE_H264_VLD_NOFGT                    = 0x00000068U,
    DXVA_RESTRICTED_MODE_H264_VLD_FGT                      = 0x00000069U,
}

enum uint DXVA_COMPBUFFER_TYPE_THAT_IS_NOT_USED = 0x00000000U;
enum uint DXVA_PICTURE_DECODE_BUFFER = 0x00000001U;
enum uint DXVA_MACROBLOCK_CONTROL_BUFFER = 0x00000002U;
enum uint DXVA_RESIDUAL_DIFFERENCE_BUFFER = 0x00000003U;
enum uint DXVA_DEBLOCKING_CONTROL_BUFFER = 0x00000004U;
enum uint DXVA_INVERSE_QUANTIZATION_MATRIX_BUFFER = 0x00000005U;
enum uint DXVA_SLICE_CONTROL_BUFFER = 0x00000006U;
enum uint DXVA_BITSTREAM_DATA_BUFFER = 0x00000007U;
enum uint DXVA_AYUV_BUFFER = 0x00000008U;
enum uint DXVA_IA44_SURFACE_BUFFER = 0x00000009U;
enum uint DXVA_DPXD_SURFACE_BUFFER = 0x0000000aU;
enum uint DXVA_HIGHLIGHT_BUFFER = 0x0000000bU;
enum uint DXVA_DCCMD_SURFACE_BUFFER = 0x0000000cU;
enum uint DXVA_ALPHA_BLEND_COMBINATION_BUFFER = 0x0000000dU;
enum uint DXVA_PICTURE_RESAMPLE_BUFFER = 0x0000000eU;
enum uint DXVA_READ_BACK_BUFFER = 0x0000000fU;
enum uint DXVA_MOTION_VECTOR_BUFFER = 0x00000010U;
enum uint DXVA_FILM_GRAIN_BUFFER = 0x00000011U;
enum uint DXVA_NUM_TYPES_COMP_BUFFERS = 0x00000012U;
enum uint DXVA_PICTURE_DECODING_FUNCTION = 0x00000001U;

enum : uint
{
    DXVA_ALPHA_BLEND_DATA_LOAD_FUNCTION   = 0x00000002U,
    DXVA_ALPHA_BLEND_COMBINATION_FUNCTION = 0x00000003U,
}

enum uint DXVA_PICTURE_RESAMPLE_FUNCTION = 0x00000004U;
enum uint DXVA_DEBLOCKING_FILTER_FUNCTION = 0x00000005U;
enum uint DXVA_FILM_GRAIN_SYNTHESIS_FUNCTION = 0x00000006U;
enum uint DXVA_STATUS_REPORTING_FUNCTION = 0x00000007U;

enum : uint
{
    DXVA_EXECUTE_RETURN_OK                 = 0x00000000U,
    DXVA_EXECUTE_RETURN_DATA_ERROR_MINOR   = 0x00000001U,
    DXVA_EXECUTE_RETURN_DATA_ERROR_SIGNIF  = 0x00000002U,
    DXVA_EXECUTE_RETURN_DATA_ERROR_SEVERE  = 0x00000003U,
    DXVA_EXECUTE_RETURN_OTHER_ERROR_SEVERE = 0x00000004U,
}

enum : uint
{
    DXVA_QUERYORREPLYFUNCFLAG_DECODER_PROBE_QUERY    = 0x00fffff1U,
    DXVA_QUERYORREPLYFUNCFLAG_DECODER_LOCK_QUERY     = 0x00fffff5U,
    DXVA_QUERYORREPLYFUNCFLAG_ACCEL_PROBE_OK_COPY    = 0x00fffff8U,
    DXVA_QUERYORREPLYFUNCFLAG_ACCEL_PROBE_OK_PLUS    = 0x00fffff9U,
    DXVA_QUERYORREPLYFUNCFLAG_ACCEL_LOCK_OK_COPY     = 0x00fffffcU,
    DXVA_QUERYORREPLYFUNCFLAG_ACCEL_PROBE_FALSE_PLUS = 0x00fffffbU,
    DXVA_QUERYORREPLYFUNCFLAG_ACCEL_LOCK_FALSE_PLUS  = 0x00ffffffU,
}

enum : uint
{
    DXVA_ENCRYPTPROTOCOLFUNCFLAG_HOST  = 0x00ffff00U,
    DXVA_ENCRYPTPROTOCOLFUNCFLAG_ACCEL = 0x00ffff08U,
}

enum : uint
{
    DXVA_CHROMA_FORMAT_420 = 0x00000001U,
    DXVA_CHROMA_FORMAT_422 = 0x00000002U,
    DXVA_CHROMA_FORMAT_444 = 0x00000003U,
}

enum : uint
{
    DXVA_PICTURE_STRUCTURE_TOP_FIELD    = 0x00000001U,
    DXVA_PICTURE_STRUCTURE_BOTTOM_FIELD = 0x00000002U,
    DXVA_PICTURE_STRUCTURE_FRAME        = 0x00000003U,
}

enum : uint
{
    DXVA_BIDIRECTIONAL_AVERAGING_MPEG2_ROUND = 0x00000000U,
    DXVA_BIDIRECTIONAL_AVERAGING_H263_TRUNC  = 0x00000001U,
}

enum : uint
{
    DXVA_MV_PRECISION_AND_CHROMA_RELATION_MPEG2 = 0x00000000U,
    DXVA_MV_PRECISION_AND_CHROMA_RELATION_H263  = 0x00000001U,
    DXVA_MV_PRECISION_AND_CHROMA_RELATION_H261  = 0x00000002U,
}

enum : uint
{
    DXVA_SCAN_METHOD_ZIG_ZAG              = 0x00000000U,
    DXVA_SCAN_METHOD_ALTERNATE_VERTICAL   = 0x00000001U,
    DXVA_SCAN_METHOD_ALTERNATE_HORIZONTAL = 0x00000002U,
    DXVA_SCAN_METHOD_ARBITRARY            = 0x00000003U,
}

enum : uint
{
    DXVA_BITSTREAM_CONCEALMENT_NEED_UNLIKELY      = 0x00000000U,
    DXVA_BITSTREAM_CONCEALMENT_NEED_MILD          = 0x00000001U,
    DXVA_BITSTREAM_CONCEALMENT_NEED_LIKELY        = 0x00000002U,
    DXVA_BITSTREAM_CONCEALMENT_NEED_SEVERE        = 0x00000003U,
    DXVA_BITSTREAM_CONCEALMENT_METHOD_UNSPECIFIED = 0x00000000U,
    DXVA_BITSTREAM_CONCEALMENT_METHOD_INTRA       = 0x00000001U,
    DXVA_BITSTREAM_CONCEALMENT_METHOD_FORWARD     = 0x00000002U,
    DXVA_BITSTREAM_CONCEALMENT_METHOD_BACKWARD    = 0x00000003U,
}

enum : uint
{
    DXVA_USUAL_BLOCK_WIDTH  = 0x00000008U,
    DXVA_USUAL_BLOCK_HEIGHT = 0x00000008U,
}

enum : uint
{
    DXVA_NumMV_OBMC_off_BinPBwith4MV_off = 0x00000004U,
    DXVA_NumMV_OBMC_off_BinPBwith4MV_on  = 0x00000005U,
    DXVA_NumMV_OBMC_on__BinPB_off        = 0x0000000aU,
    DXVA_NumMV_OBMC_on__BinPB_on         = 0x0000000bU,
}

enum : uint
{
    DXVA_CONFIG_DATA_TYPE_IA44           = 0x00000000U,
    DXVA_CONFIG_DATA_TYPE_AI44           = 0x00000001U,
    DXVA_CONFIG_DATA_TYPE_DPXD           = 0x00000002U,
    DXVA_CONFIG_DATA_TYPE_AYUV           = 0x00000003U,
    DXVA_CONFIG_BLEND_TYPE_FRONT_BUFFER  = 0x00000000U,
    DXVA_CONFIG_BLEND_TYPE_BACK_HARDWARE = 0x00000001U,
}

enum uint DXVA_ExtColorData_ShiftBase = 0x00000008U;

enum : GUID
{
    DXVA_DeinterlaceBobDevice       = GUID("335aa36e-7884-43a4-9c91-7f87faf3e37e"),
    DXVA_DeinterlaceContainerDevice = GUID("0e85cb93-3046-4ff0-aecc-d58cb5f035fd"),
}

enum uint MAX_DEINTERLACE_SURFACES = 0x00000020U;

enum : uint
{
    DXVA_DeinterlaceBltFnCode   = 0x00000001U,
    DXVA_DeinterlaceBltExFnCode = 0x00000002U,
}

enum uint MAX_DEINTERLACE_DEVICE_GUIDS = 0x00000020U;

enum : uint
{
    DXVA_DeinterlaceQueryAvailableModesFnCode = 0x00000001U,
    DXVA_DeinterlaceQueryModeCapsFnCode       = 0x00000002U,
}

enum GUID DXVA_ProcAmpControlDevice = GUID("9f200913-2ffd-4056-9f1e-e1b508f22dcf");

enum : uint
{
    DXVA_ProcAmpControlQueryCapsFnCode  = 0x00000003U,
    DXVA_ProcAmpControlQueryRangeFnCode = 0x00000004U,
    DXVA_ProcAmpControlBltFnCode        = 0x00000001U,
}

enum GUID DXVA_COPPDevice = GUID("d2457add-8999-45ed-8a8a-d1aa047ba4d5");
enum uint DXVA_COPPGetCertificateLengthFnCode = 0x00000001U;
enum uint DXVA_COPPKeyExchangeFnCode = 0x00000002U;
enum uint DXVA_COPPSequenceStartFnCode = 0x00000003U;
enum uint DXVA_COPPCommandFnCode = 0x00000004U;
enum GUID DXVA_COPPSetProtectionLevel = GUID("9bb9327c-4eb5-4727-9f00-b42b0919c0da");
enum int COPP_NoProtectionLevelAvailable = 0xffffffff;
enum uint COPP_DefaultProtectionLevel = 0x00000000U;
enum GUID DXVA_COPPSetSignaling = GUID("09a631a5-d684-4c60-8e4d-d3bb0f0be3ee");
enum uint COPP_ImageAspectRatio_EN300294_Mask = 0x00000007U;
enum uint DXVA_COPPQueryStatusFnCode = 0x00000005U;

enum : GUID
{
    DXVA_COPPQueryConnectorType         = GUID("81d0bfd5-6afe-48c2-99c0-95a08f97c5da"),
    DXVA_COPPQueryProtectionType        = GUID("38f2a801-9a6c-48bb-9107-b6696e6f1797"),
    DXVA_COPPQueryLocalProtectionLevel  = GUID("b2075857-3eda-4d5d-88db-748f8c1a0549"),
    DXVA_COPPQueryGlobalProtectionLevel = GUID("1957210a-7766-452a-b99a-d27aed54f03a"),
}

enum : GUID
{
    DXVA_COPPQueryDisplayData = GUID("d7bf1ba3-ad13-4f8e-af98-0dcb3ca204cc"),
    DXVA_COPPQueryHDCPKeyData = GUID("0db59d74-a992-492e-a0bd-c23fda564e00"),
    DXVA_COPPQueryBusData     = GUID("c6f4d673-6174-4184-8e35-f6db5200bcba"),
    DXVA_COPPQuerySignaling   = GUID("6629a591-3b79-4cf3-924a-11e8e7811671"),
}

enum : GUID
{
    DXVA2Trace_Control             = GUID("a0386e75-f70c-464c-a9ce-33c44e091623"),
    DXVA2Trace_DecodeDevCreated    = GUID("b4de17a1-c5b2-44fe-86d5-d97a648114ff"),
    DXVA2Trace_DecodeDevDestroyed  = GUID("853ebdf2-4160-421d-8893-63dcea4f18bb"),
    DXVA2Trace_DecodeDevBeginFrame = GUID("9fd1acf6-44cb-4637-bc62-2c11a9608f90"),
    DXVA2Trace_DecodeDevExecute    = GUID("850aeb4c-d19a-4609-b3b4-bcbf0e22121e"),
    DXVA2Trace_DecodeDevGetBuffer  = GUID("57b128fb-72cb-4137-a575-d91fa3160897"),
    DXVA2Trace_DecodeDevEndFrame   = GUID("9fb3cb33-47dc-4899-98c8-c0c6cd7cd3cb"),
}

enum : GUID
{
    DXVA2Trace_VideoProcessDevCreated   = GUID("895508c6-540d-4c87-98f8-8dcbf2dabb2a"),
    DXVA2Trace_VideoProcessDevDestroyed = GUID("f97f30b1-fb49-42c7-8ee8-88bdfa92d4e2"),
    DXVA2Trace_VideoProcessBlt          = GUID("69089cc0-71ab-42d0-953a-2887bf05a8af"),
}

enum GUID MSTapeDeviceGUID = GUID("8c0f6af2-0edb-44c1-8aeb-59040bd830ed");
enum const(wchar)* g_wszExcludeScriptStreamDeliverySynchronization = "ExcludeScriptStreamDeliverySynchronization";
enum uint MPEG2_BASE = 0x00000200U;
enum HRESULT MPEG2_S_MORE_DATA_AVAILABLE = HRESULT(0x00040200);
enum HRESULT MPEG2_S_NO_MORE_DATA_AVAILABLE = HRESULT(0x00040201);

enum : HRESULT
{
    MPEG2_S_SG_INFO_FOUND     = HRESULT(0x00040202),
    MPEG2_S_SG_INFO_NOT_FOUND = HRESULT(0x00040203),
}

enum : HRESULT
{
    MPEG2_S_MPE_INFO_FOUND     = HRESULT(0x00040204),
    MPEG2_S_MPE_INFO_NOT_FOUND = HRESULT(0x00040205),
}

enum HRESULT MPEG2_S_NEW_MODULE_VERSION = HRESULT(0x00040206);
enum HRESULT MPEG2_E_UNINITIALIZED = HRESULT(0x80040200);
enum HRESULT MPEG2_E_ALREADY_INITIALIZED = HRESULT(0x80040201);
enum HRESULT MPEG2_E_OUT_OF_BOUNDS = HRESULT(0x80040202);
enum HRESULT MPEG2_E_MALFORMED_TABLE = HRESULT(0x80040203);

enum : HRESULT
{
    MPEG2_E_UNDEFINED         = HRESULT(0x80040204),
    MPEG2_E_NOT_PRESENT       = HRESULT(0x80040205),
    MPEG2_E_SECTION_NOT_FOUND = HRESULT(0x80040206),
}

enum HRESULT MPEG2_E_TX_STREAM_UNAVAILABLE = HRESULT(0x80040207);

enum : HRESULT
{
    MPEG2_E_SERVICE_ID_NOT_FOUND  = HRESULT(0x80040208),
    MPEG2_E_SERVICE_PMT_NOT_FOUND = HRESULT(0x80040209),
}

enum HRESULT MPEG2_E_DSI_NOT_FOUND = HRESULT(0x8004020a);
enum HRESULT MPEG2_E_SERVER_UNAVAILABLE = HRESULT(0x8004020b);
enum HRESULT MPEG2_E_INVALID_CAROUSEL_ID = HRESULT(0x8004020c);
enum HRESULT MPEG2_E_MALFORMED_DSMCC_MESSAGE = HRESULT(0x8004020d);
enum HRESULT MPEG2_E_INVALID_SG_OBJECT_KIND = HRESULT(0x8004020e);

enum : HRESULT
{
    MPEG2_E_OBJECT_NOT_FOUND            = HRESULT(0x8004020f),
    MPEG2_E_OBJECT_KIND_NOT_A_DIRECTORY = HRESULT(0x80040210),
    MPEG2_E_OBJECT_KIND_NOT_A_FILE      = HRESULT(0x80040211),
}

enum HRESULT MPEG2_E_FILE_OFFSET_TOO_BIG = HRESULT(0x80040212);
enum HRESULT MPEG2_E_STREAM_STOPPED = HRESULT(0x80040213);
enum HRESULT MPEG2_E_REGISTRY_ACCESS_FAILED = HRESULT(0x80040214);
enum HRESULT MPEG2_E_INVALID_UDP_PORT = HRESULT(0x80040215);
enum HRESULT MPEG2_E_DATA_SOURCE_FAILED = HRESULT(0x80040216);

enum : HRESULT
{
    MPEG2_E_DII_NOT_FOUND       = HRESULT(0x80040217),
    MPEG2_E_DSHOW_PIN_NOT_FOUND = HRESULT(0x80040218),
}

enum HRESULT MPEG2_E_BUFFER_TOO_SMALL = HRESULT(0x80040219);
enum HRESULT MPEG2_E_MISSING_SECTIONS = HRESULT(0x8004021a);
enum HRESULT MPEG2_E_TOO_MANY_SECTIONS = HRESULT(0x8004021b);
enum HRESULT MPEG2_E_NEXT_TABLE_OPS_NOT_AVAILABLE = HRESULT(0x8004021c);
enum HRESULT MPEG2_E_INCORRECT_DESCRIPTOR_TAG = HRESULT(0x8004021d);

enum : HRESULT
{
    MSDRI_S_MMI_PENDING = HRESULT(0x00000002),
    MSDRI_S_PENDING     = HRESULT(0x00000001),
}

enum : HRESULT
{
    BDA_E_FAILURE         = HRESULT(0xc0040001),
    BDA_E_NOT_IMPLEMENTED = HRESULT(0xc0040002),
}

enum HRESULT BDA_E_NO_SUCH_COMMAND = HRESULT(0xc0040003);
enum HRESULT BDA_E_OUT_OF_BOUNDS = HRESULT(0xc0040004);

enum : HRESULT
{
    BDA_E_INVALID_SCHEMA = HRESULT(0xc0040005),
    BDA_E_INVALID_HANDLE = HRESULT(0xc0040006),
    BDA_E_INVALID_TYPE   = HRESULT(0xc0040007),
}

enum HRESULT BDA_E_READ_ONLY = HRESULT(0xc0040008);
enum HRESULT BDA_E_ACCESS_DENIED = HRESULT(0xc0040009);
enum HRESULT BDA_E_NOT_FOUND = HRESULT(0xc004000a);
enum HRESULT BDA_E_BUFFER_TOO_SMALL = HRESULT(0xc004000b);

enum : HRESULT
{
    BDA_E_OUT_OF_RESOURCES = HRESULT(0xc004000c),
    BDA_E_OUT_OF_MEMORY    = HRESULT(0xc004000d),
}

enum : HRESULT
{
    BDA_E_DISABLED   = HRESULT(0xc004000e),
    BDA_E_NO_HANDLER = HRESULT(0xc004000f),
}

enum HRESULT BDA_E_INVALID_LANGUAGE = HRESULT(0xc0040010);
enum HRESULT BDA_E_TIMEOUT_ELAPSED = HRESULT(0xc0040011);

enum : HRESULT
{
    BDA_E_NO_MORE_EVENTS = HRESULT(0xc0041001),
    BDA_E_NO_MORE_DATA   = HRESULT(0xc0041002),
}

enum : HRESULT
{
    BDA_E_TUNER_INITIALIZING = HRESULT(0xc0043001),
    BDA_E_TUNER_REQUIRED     = HRESULT(0xc0043002),
    BDA_E_TUNER_CONFLICT     = HRESULT(0xc0043003),
}

enum : HRESULT
{
    BDA_E_INVALID_TUNE_REQUEST      = HRESULT(0xc0043004),
    BDA_E_INVALID_ENTITLEMENT_TOKEN = HRESULT(0xc0044001),
    BDA_E_INVALID_CAPTURE_TOKEN     = HRESULT(0xc0044002),
}

enum HRESULT BDA_E_WOULD_DISRUPT_STREAMING = HRESULT(0xc0044003);
enum HRESULT BDA_E_INVALID_PURCHASE_TOKEN = HRESULT(0xc0044004);

enum : HRESULT
{
    BDA_E_IPNETWORK_ERROR             = HRESULT(0xc0045001),
    BDA_E_IPNETWORK_ADDRESS_NOT_FOUND = HRESULT(0xc0045002),
    BDA_E_IPNETWORK_TIMEOUT           = HRESULT(0xc0045003),
    BDA_E_IPNETWORK_UNAVAILABLE       = HRESULT(0xc0045004),
}

enum : HRESULT
{
    BDA_E_TUNE_FAILED_SDV01 = HRESULT(0xc0046001),
    BDA_E_TUNE_FAILED_SDV02 = HRESULT(0xc0046002),
    BDA_E_TUNE_FAILED_SDV03 = HRESULT(0xc0046003),
    BDA_E_TUNE_FAILED_SDV04 = HRESULT(0xc0046004),
    BDA_E_TUNE_FAILED_SDV05 = HRESULT(0xc0046005),
    BDA_E_TUNE_FAILED_SDV06 = HRESULT(0xc0046006),
    BDA_E_TUNE_FAILED_SDV07 = HRESULT(0xc0046007),
    BDA_E_TUNE_FAILED_SDV08 = HRESULT(0xc0046008),
    BDA_E_TUNE_FAILED_SDVFF = HRESULT(0xc00460ff),
}

enum : HRESULT
{
    BDA_E_WMDRM_INVALID_SIGNATURE   = HRESULT(0xc004f001),
    BDA_E_WMDRM_INVALID_CERTIFICATE = HRESULT(0xc004f002),
    BDA_E_WMDRM_INVALID_VERSION     = HRESULT(0xc004f004),
    BDA_E_WMDRM_INVALID_DATE        = HRESULT(0xc004f005),
    BDA_E_WMDRM_INVALID_PROXIMITY   = HRESULT(0xc004f006),
    BDA_E_WMDRM_KEY_ID_NOT_FOUND    = HRESULT(0xc004f008),
}

enum GUID SPECIFYPAGES_STATISTICS = GUID("4c437b92-6e9e-11d1-a704-006097c4e476");

// Callbacks

alias AMGETERRORTEXTPROCA = BOOL function(HRESULT param0, PSTR param1, uint param2);
alias AMGETERRORTEXTPROCW = BOOL function(HRESULT param0, PWSTR param1, uint param2);
alias PDXVA2SW_GETVIDEOPROCESSORRENDERTARGETCOUNT = HRESULT function(const(DXVA2_VideoDesc)* pVideoDesc, 
                                                                     uint* pCount);
alias PDXVA2SW_GETVIDEOPROCESSORRENDERTARGETS = HRESULT function(const(DXVA2_VideoDesc)* pVideoDesc, uint Count, 
                                                                 D3DFORMAT* pFormats);
alias PDXVA2SW_GETVIDEOPROCESSORCAPS = HRESULT function(const(DXVA2_VideoDesc)* pVideoDesc, 
                                                        D3DFORMAT RenderTargetFormat, 
                                                        DXVA2_VideoProcessorCaps* pCaps);
alias PDXVA2SW_GETVIDEOPROCESSORSUBSTREAMFORMATCOUNT = HRESULT function(const(DXVA2_VideoDesc)* pVideoDesc, 
                                                                        D3DFORMAT RenderTargetFormat, uint* pCount);
alias PDXVA2SW_GETVIDEOPROCESSORSUBSTREAMFORMATS = HRESULT function(const(DXVA2_VideoDesc)* pVideoDesc, 
                                                                    D3DFORMAT RenderTargetFormat, uint Count, 
                                                                    D3DFORMAT* pFormats);
alias PDXVA2SW_GETPROCAMPRANGE = HRESULT function(const(DXVA2_VideoDesc)* pVideoDesc, D3DFORMAT RenderTargetFormat, 
                                                  uint ProcAmpCap, DXVA2_ValueRange* pRange);
alias PDXVA2SW_GETFILTERPROPERTYRANGE = HRESULT function(const(DXVA2_VideoDesc)* pVideoDesc, 
                                                         D3DFORMAT RenderTargetFormat, uint FilterSetting, 
                                                         DXVA2_ValueRange* pRange);
alias PDXVA2SW_CREATEVIDEOPROCESSDEVICE = HRESULT function(IDirect3DDevice9 pD3DD9, 
                                                           const(DXVA2_VideoDesc)* pVideoDesc, 
                                                           D3DFORMAT RenderTargetFormat, uint MaxSubStreams, 
                                                           HANDLE* phDevice);
alias PDXVA2SW_DESTROYVIDEOPROCESSDEVICE = HRESULT function(HANDLE hDevice);
alias PDXVA2SW_VIDEOPROCESSBEGINFRAME = HRESULT function(HANDLE hDevice);
alias PDXVA2SW_VIDEOPROCESSENDFRAME = HRESULT function(HANDLE hDevice, HANDLE* pHandleComplete);
alias PDXVA2SW_VIDEOPROCESSSETRENDERTARGET = HRESULT function(HANDLE hDevice, IDirect3DSurface9 pRenderTarget);
alias PDXVA2SW_VIDEOPROCESSBLT = HRESULT function(HANDLE hDevice, const(DXVA2_VIDEOPROCESSBLT)* pBlt);

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vptype/ns-vptype-amvpsize
struct AMVPSIZE
{
    uint dwWidth;
    uint dwHeight;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vptype/ns-vptype-amvpdiminfo
struct AMVPDIMINFO
{
    uint dwFieldWidth;
    uint dwFieldHeight;
    uint dwVBIWidth;
    uint dwVBIHeight;
    RECT rcValidRegion;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vptype/ns-vptype-amvpdatainfo
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ns-strmif-allocator_properties
struct ALLOCATOR_PROPERTIES
{
    int cBuffers;
    int cbBuffer;
    int cbAlign;
    int cbPrefix;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ns-strmif-pin_info
struct PIN_INFO
{
    IBaseFilter   pFilter;
    PIN_DIRECTION dir;
    wchar[128]    achName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ns-strmif-filter_info
struct FILTER_INFO
{
    wchar[128]   achName;
    IFilterGraph pGraph;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ns-strmif-am_sample2_properties
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
    GUID  Clsid;
    PWSTR Name;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ns-strmif-regpintypes
struct REGPINTYPES
{
    const(GUID)* clsMajorType;
    const(GUID)* clsMinorType;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ns-strmif-regfilterpins
struct REGFILTERPINS
{
    PWSTR               strName;
    BOOL                bRendered;
    BOOL                bOutput;
    BOOL                bZero;
    BOOL                bMany;
    const(GUID)*        clsConnectsToFilter;
    const(PWSTR)        strConnectsToPin;
    uint                nMediaTypes;
    const(REGPINTYPES)* lpMediaType;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ns-strmif-regpinmedium
struct REGPINMEDIUM
{
    GUID clsMedium;
    uint dw1;
    uint dw2;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ns-strmif-regfilterpins2
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ns-strmif-regfilter2
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ns-strmif-quality
struct Quality
{
    QualityMessageType Type;
    int                Proportion;
    long               Late;
    long               TimeStamp;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ns-strmif-colorkey
struct COLORKEY
{
    uint     KeyType;
    uint     PaletteIndex;
    COLORREF LowColorValue;
    COLORREF HighColorValue;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ns-strmif-am_stream_info
struct AM_STREAM_INFO
{
    long tStart;
    long tStop;
    uint dwStartCookie;
    uint dwStopCookie;
    uint dwFlags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ns-strmif-video_stream_config_caps
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ns-strmif-audio_stream_config_caps
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ns-strmif-dvinfo
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ns-strmif-stream_id_map
struct STREAM_ID_MAP
{
    uint stream_id;
    uint dwMediaSampleContent;
    uint ulSubstreamFilterValue;
    int  iDataOffset;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ns-strmif-amcoppsignature
struct AMCOPPSignature
{
    ubyte[256] Signature;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ns-strmif-amcoppcommand
struct AMCOPPCommand
{
    GUID        macKDI;
    GUID        guidCommandID;
    uint        dwSequence;
    uint        cbSizeData;
    ubyte[4056] CommandData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ns-strmif-amcoppstatusinput
struct AMCOPPStatusInput
{
    GUID        rApp;
    GUID        guidStatusRequestID;
    uint        dwSequence;
    uint        cbSizeData;
    ubyte[4056] StatusData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ns-strmif-amcoppstatusoutput
struct AMCOPPStatusOutput
{
    GUID        macKDI;
    uint        cbSizeData;
    ubyte[4076] COPPStatus;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ns-strmif-vmrpresentationinfo
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ns-strmif-vmrallocationinfo
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ns-strmif-normalizedrect
struct NORMALIZEDRECT
{
    float left;
    float top;
    float right;
    float bottom;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ns-strmif-vmrguid
struct VMRGUID
{
    GUID* pGUID;
    GUID  Guid;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ns-strmif-vmrmonitorinfo
struct VMRMONITORINFO
{
    VMRGUID    guid;
    RECT       rcMonitor;
    HMONITOR   hMon;
    uint       dwFlags;
    wchar[32]  szDevice;
    wchar[256] szDescription;
    long       liDriverVersion;
    uint       dwVendorId;
    uint       dwDeviceId;
    uint       dwSubSysId;
    uint       dwRevision;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ns-strmif-vmrfrequency
struct VMRFrequency
{
    uint dwNumerator;
    uint dwDenominator;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ns-strmif-vmrvideodesc
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ns-strmif-vmrdeinterlacecaps
struct VMRDeinterlaceCaps
{
    uint               dwSize;
    uint               dwNumPreviousOutputFrames;
    uint               dwNumForwardRefSamples;
    uint               dwNumBackwardRefSamples;
    VMRDeinterlaceTech DeinterlaceTechnology;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ns-strmif-vmralphabitmap
struct VMRALPHABITMAP
{
    uint                dwFlags;
    HDC                 hdc;
    IDirectDrawSurface7 pDDS;
    RECT                rSrc;
    NORMALIZEDRECT      rDest;
    float               fAlpha;
    COLORREF            clrSrcKey;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ns-strmif-vmrvideostreaminfo
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ns-strmif-dvd_timecode
struct DVD_TIMECODE
{
    // Native bit field: Hours1: [0-3], Hours10: [4-7], Minutes1: [8-11], Minutes10: [12-15], Seconds1: [16-19], Seconds10: [20-23], Frames1: [24-27], Frames10: [28-29], FrameRateCode: [30-31]
    uint _bitfield0;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ns-strmif-dvd_hmsf_timecode
struct DVD_HMSF_TIMECODE
{
    ubyte bHours;
    ubyte bMinutes;
    ubyte bSeconds;
    ubyte bFrames;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ns-strmif-dvd_playback_location2
struct DVD_PLAYBACK_LOCATION2
{
    uint              TitleNum;
    uint              ChapterNum;
    DVD_HMSF_TIMECODE TimeCode;
    uint              TimeCodeFlags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ns-strmif-dvd_playback_location
struct DVD_PLAYBACK_LOCATION
{
    uint TitleNum;
    uint ChapterNum;
    uint TimeCode;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ns-strmif-dvd_audioattributes
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ns-strmif-dvd_mua_mixinginfo
struct DVD_MUA_MixingInfo
{
    BOOL fMixTo0;
    BOOL fMixTo1;
    BOOL fMix0InPhase;
    BOOL fMix1InPhase;
    uint dwSpeakerPosition;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ns-strmif-dvd_mua_coeff
struct DVD_MUA_Coeff
{
    double log2_alpha;
    double log2_beta;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ns-strmif-dvd_multichannelaudioattributes
struct DVD_MultichannelAudioAttributes
{
    DVD_MUA_MixingInfo[8] Info;
    DVD_MUA_Coeff[8] Coeff;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ns-strmif-dvd_karaokeattributes
struct DVD_KaraokeAttributes
{
    ubyte     bVersion;
    BOOL      fMasterOfCeremoniesInGuideVocal1;
    BOOL      fDuet;
    DVD_KARAOKE_ASSIGNMENT ChannelAssignment;
    ushort[8] wChannelContents;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ns-strmif-dvd_videoattributes
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ns-strmif-dvd_subpictureattributes
struct DVD_SubpictureAttributes
{
    DVD_SUBPICTURE_TYPE Type;
    DVD_SUBPICTURE_CODING CodingMode;
    uint                Language;
    DVD_SUBPICTURE_LANG_EXT LanguageExtension;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ns-strmif-dvd_titleattributes
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ns-strmif-dvd_menuattributes
struct DVD_MenuAttributes
{
    BOOL[8]             fCompatibleRegion;
    DVD_VideoAttributes VideoAttributes;
    BOOL                fAudioPresent;
    DVD_AudioAttributes AudioAttributes;
    BOOL                fSubpicturePresent;
    DVD_SubpictureAttributes SubpictureAttributes;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ns-strmif-dvd_decoder_caps
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/ns-strmif-am_dvd_renderstatus
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
    BDA_ETHERNET_ADDRESS[1] rgAddressl; // Flexible array
}

struct BDA_IPv4_ADDRESS
{
    ubyte[4] rgbAddress;
}

struct BDA_IPv4_ADDRESS_LIST
{
    uint                ulcAddresses;
    BDA_IPv4_ADDRESS[1] rgAddressl; // Flexible array
}

struct BDA_IPv6_ADDRESS
{
    ubyte[6] rgbAddress;
}

struct BDA_IPv6_ADDRESS_LIST
{
    uint                ulcAddresses;
    BDA_IPv6_ADDRESS[1] rgAddressl; // Flexible array
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
    uint[1] argbSectionData; // Flexible array
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/pid-map
struct PID_MAP
{
    uint                 ulPID;
    MEDIA_SAMPLE_CONTENT MediaSampleContent;
}

struct BDA_PID_MAP
{
    MEDIA_SAMPLE_CONTENT MediaSampleContent;
    uint                 ulcPIDs;
    uint[1]              aulPIDs; // Flexible array
}

struct BDA_PID_UNMAP
{
    uint    ulcPIDs;
    uint[1] aulPIDs; // Flexible array
}

struct BDA_CA_MODULE_UI
{
    uint    ulFormat;
    uint    ulbcDesc;
    uint[1] ulDesc; // Flexible array
}

struct BDA_PROGRAM_PID_LIST
{
    uint    ulProgramNumber;
    uint    ulcPIDs;
    uint[1] ulPID; // Flexible array
}

struct BDA_DRM_DRMSTATUS
{
    int     lResult;
    GUID    DRMuuid;
    uint    ulDrmUuidListStringSize;
    GUID[1] argbDrmUuidListString; // Flexible array
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
    GUID[1] argKeyuuidBuffer; // Flexible array
}

struct BDA_BUFFER
{
    int      lResult;
    uint     ulBufferSize;
    ubyte[1] argbBuffer; // Flexible array
}

struct BDA_WMDRM_RENEWLICENSE
{
    int      lResult;
    uint     ulDescrambleStatus;
    uint     ulXmrLicenseOutputLength;
    ubyte[1] argbXmrLicenceOutputBuffer; // Flexible array
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
    ubyte[1] argbCaptureTokenBuffer; // Flexible array
}

struct BDA_TUNER_TUNERSTATE
{
    int      lResult;
    uint     ulTuneLength;
    ubyte[1] argbTuneData; // Flexible array
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
    ubyte[1] argbString; // Flexible array
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
    ubyte[1] argbData; // Flexible array
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
    ubyte[1] argbDialogData; // Flexible array
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
    ubyte[1] argbIsdbCommand; // Flexible array
}

struct BDA_ISDBCAS_RESPONSEDATA
{
align (1):
    int      lResult;
    uint     ulRequestID;
    uint     ulIsdbStatus;
    uint     ulIsdbDataSize;
    ubyte[1] argbIsdbCommandData; // Flexible array
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
    ubyte[1] bMessageCode; // Flexible array
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
    ushort[1] usTSID; // Flexible array
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
    ubyte[1] L1PostData; // Flexible array
}

struct BDA_RATING_PINRESET
{
    ubyte    bPinLength;
    ubyte[1] argbNewPin; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/DirectShow/mpeg2-transport-stride
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface_enums/ns-bdaiface_enums-ealocationcodetype
struct EALocationCodeType
{
    LocationCodeSchemeType LocationCodeScheme;
    ubyte  state_code;
    ubyte  county_subdivision;
    ushort county_code;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface_enums/ns-bdaiface_enums-smartcardapplication
struct SmartCardApplication
{
    ApplicationTypeType ApplicationType;
    ushort              ApplicationVersion;
    BSTR                pbstrApplicationName;
    BSTR                pbstrApplicationURL;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amva/ns-amva-amvauncompbufferinfo
struct AMVAUncompBufferInfo
{
    uint          dwMinNumSurfaces;
    uint          dwMaxNumSurfaces;
    DDPIXELFORMAT ddUncompPixelFormat;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amva/ns-amva-amvauncompdatainfo
struct AMVAUncompDataInfo
{
    uint          dwUncompWidth;
    uint          dwUncompHeight;
    DDPIXELFORMAT ddUncompPixelFormat;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amva/ns-amva-amvainternalmeminfo
struct AMVAInternalMemInfo
{
    uint dwScratchMemAlloc;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amva/ns-amva-amvacompbufferinfo
struct AMVACompBufferInfo
{
    uint          dwNumCompBuffers;
    uint          dwWidthToCreate;
    uint          dwHeightToCreate;
    uint          dwBytesToAllocate;
    DDSCAPS2      ddCompCaps;
    DDPIXELFORMAT ddPixelFormat;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amva/ns-amva-amvabeginframeinfo
struct AMVABeginFrameInfo
{
    uint  dwDestSurfaceIndex;
    void* pInputData;
    uint  dwSizeInputData;
    void* pOutputData;
    uint  dwSizeOutputData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amva/ns-amva-amvaendframeinfo
struct AMVAEndFrameInfo
{
    uint  dwSizeMiscData;
    void* pMiscData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amva/ns-amva-amvabufferinfo
struct AMVABUFFERINFO
{
    uint dwTypeIndex;
    uint dwBufferIndex;
    uint dwDataOffset;
    uint dwDataSize;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iwstdec/ns-iwstdec-am_wst_page
struct AM_WST_PAGE
{
    uint   dwPageNr;
    uint   dwSubPageNr;
    ubyte* pucPageData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amvideo/ns-amvideo-truecolorinfo
struct TRUECOLORINFO
{
    uint[3]      dwBitMasks;
    RGBQUAD[256] bmiColors;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amvideo/ns-amvideo-videoinfo
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amvideo/ns-amvideo-analogvideoinfo
struct ANALOGVIDEOINFO
{
    RECT rcSource;
    RECT rcTarget;
    uint dwActiveWidth;
    uint dwActiveHeight;
    long AvgTimePerFrame;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amvideo/ns-amvideo-am_framestep_step
struct AM_FRAMESTEP_STEP
{
    uint dwFramesToStep;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpegtype/ns-mpegtype-am_mpegstreamtype
struct AM_MPEGSTREAMTYPE
{
    uint          dwStreamId;
    uint          dwReserved;
    AM_MEDIA_TYPE mt;
    ubyte[1]      bFormat; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpegtype/ns-mpegtype-am_mpegsystemtype
struct AM_MPEGSYSTEMTYPE
{
    uint                 dwBitRate;
    uint                 cStreams;
    AM_MPEGSTREAMTYPE[1] Streams; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/ns-vmr9-vmr9presentationinfo
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/ns-vmr9-vmr9allocationinfo
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/ns-vmr9-vmr9normalizedrect
struct VMR9NormalizedRect
{
    float left;
    float top;
    float right;
    float bottom;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/ns-vmr9-vmr9procampcontrol
struct VMR9ProcAmpControl
{
    uint  dwSize;
    uint  dwFlags;
    float Brightness;
    float Contrast;
    float Hue;
    float Saturation;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/ns-vmr9-vmr9procampcontrolrange
struct VMR9ProcAmpControlRange
{
    uint  dwSize;
    VMR9ProcAmpControlFlags dwProperty;
    float MinValue;
    float MaxValue;
    float DefaultValue;
    float StepSize;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/ns-vmr9-vmr9alphabitmap
struct VMR9AlphaBitmap
{
    uint               dwFlags;
    HDC                hdc;
    IDirect3DSurface9  pDDS;
    RECT               rSrc;
    VMR9NormalizedRect rDest;
    float              fAlpha;
    COLORREF           clrSrcKey;
    uint               dwFilterMode;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/ns-vmr9-vmr9monitorinfo
struct VMR9MonitorInfo
{
    uint       uDevID;
    RECT       rcMonitor;
    HMONITOR   hMon;
    uint       dwFlags;
    wchar[32]  szDevice;
    wchar[512] szDescription;
    long       liDriverVersion;
    uint       dwVendorId;
    uint       dwDeviceId;
    uint       dwSubSysId;
    uint       dwRevision;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/ns-vmr9-vmr9frequency
struct VMR9Frequency
{
    uint dwNumerator;
    uint dwDenominator;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/ns-vmr9-vmr9videodesc
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/ns-vmr9-vmr9deinterlacecaps
struct VMR9DeinterlaceCaps
{
    uint                dwSize;
    uint                dwNumPreviousOutputFrames;
    uint                dwNumForwardRefSamples;
    uint                dwNumBackwardRefSamples;
    VMR9DeinterlaceTech DeinterlaceTechnology;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/ns-vmr9-vmr9videostreaminfo
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

struct RIFFCHUNK
{
align (2):
    uint fcc;
    uint cb;
}

struct RIFFLIST
{
align (2):
    uint fcc;
    uint cb;
    uint fccListType;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/aviriff/ns-aviriff-avimainheader
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

struct AVIEXTHEADER
{
align (2):
    uint     fcc;
    uint     cb;
    uint     dwGrandFrames;
    uint[61] dwFuture;
}

// Microsoft documentation: https://learn.microsoft.com/previous-versions/windows/desktop/api/aviriff/ns-aviriff-avistreamheader
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/aviriff/ns-aviriff-avioldindex
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

struct TIMECODEDATA
{
align (2):
    TIMECODE time;
    uint     dwSMPTEflags;
    uint     dwUser;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/aviriff/ns-aviriff-avimetaindex
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
    uint[1] adwIndex;
}

// Microsoft documentation: https://learn.microsoft.com/previous-versions/windows/desktop/api/aviriff/ns-aviriff-avisuperindex
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/aviriff/ns-aviriff-avistdindex_entry
struct AVISTDINDEX_ENTRY
{
align (2):
    uint dwOffset;
    uint dwSize;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/aviriff/ns-aviriff-avistdindex
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

struct AVITIMEDINDEX_ENTRY
{
align (2):
    uint dwOffset;
    uint dwSize;
    uint dwDuration;
}

struct AVITIMEDINDEX
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
    AVITIMEDINDEX_ENTRY[1362] aIndex;
    uint[2734] adwTrailingFill;
}

struct AVITIMECODEINDEX
{
align (2):
    uint               fcc;
    uint               cb;
    ushort             wLongsPerEntry;
    ubyte              bIndexSubType;
    ubyte              bIndexType;
    uint               nEntriesInUse;
    uint               dwChunkId;
    uint[3]            dwReserved;
    TIMECODEDATA[1022] aIndex;
}

struct AVITCDLINDEX_ENTRY
{
align (2):
    uint     dwTick;
    TIMECODE time;
    uint     dwSMPTEflags;
    uint     dwUser;
    byte[12] szReelId;
}

struct AVITCDLINDEX
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
    AVITCDLINDEX_ENTRY[584] aIndex;
    uint[3512] adwTrailingFill;
}

struct AVIFIELDINDEX
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

// Microsoft documentation: https://learn.microsoft.com/previous-versions/windows/desktop/api/avifmt/ns-avifmt-avistreamheader
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/avifmt/ns-avifmt-avipalchange
struct AVIPALCHANGE
{
    ubyte           bFirstEntry;
    ubyte           bNumEntries;
    ushort          wFlags;
    PALETTEENTRY[1] peNew;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvdmedia/ns-dvdmedia-am_dvd_yuv
struct AM_DVD_YUV
{
    ubyte Reserved;
    ubyte Y;
    ubyte U;
    ubyte V;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvdmedia/ns-dvdmedia-am_property_sppal
struct AM_PROPERTY_SPPAL
{
    AM_DVD_YUV[16] sppal;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvdmedia/ns-dvdmedia-am_colcon
struct AM_COLCON
{
    // Native bit field: emph1col: [0-3], emph2col: [4-7]
    ubyte _bitfield1;
    // Native bit field: backcol: [0-3], patcol: [4-7]
    ubyte _bitfield2;
    // Native bit field: emph1con: [0-3], emph2con: [4-7]
    ubyte _bitfield3;
    // Native bit field: backcon: [0-3], patcon: [4-7]
    ubyte _bitfield4;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvdmedia/ns-dvdmedia-am_property_sphli
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvdmedia/ns-dvdmedia-am_dvdcopy_chlgkey
struct AM_DVDCOPY_CHLGKEY
{
    ubyte[10] ChlgKey;
    ubyte[2]  Reserved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvdmedia/ns-dvdmedia-am_dvdcopy_buskey
struct AM_DVDCOPY_BUSKEY
{
    ubyte[5] BusKey;
    ubyte[1] Reserved; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvdmedia/ns-dvdmedia-am_dvdcopy_disckey
struct AM_DVDCOPY_DISCKEY
{
    ubyte[2048] DiscKey;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvdmedia/ns-dvdmedia-am_dvdcopy_titlekey
struct AM_DVDCOPY_TITLEKEY
{
    uint     KeyFlags;
    uint[2]  Reserved1;
    ubyte[6] TitleKey;
    ubyte[2] Reserved2;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvdmedia/ns-dvdmedia-am_copy_macrovision
struct AM_COPY_MACROVISION
{
    uint MACROVISIONLevel;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvdmedia/ns-dvdmedia-am_dvdcopy_set_copy_state
struct AM_DVDCOPY_SET_COPY_STATE
{
    uint DVDCopyState;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvdmedia/ns-dvdmedia-am_dvdkaraokedata
struct AM_DvdKaraokeData
{
    uint dwDownmix;
    uint dwSpeakerAssignment;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvdmedia/ns-dvdmedia-am_simpleratechange
struct AM_SimpleRateChange
{
    long StartTime;
    int  Rate;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvdmedia/ns-dvdmedia-am_queryrate
struct AM_QueryRate
{
    int lMaxForwardFullFrame;
    int lMaxReverseFullFrame;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvdmedia/ns-dvdmedia-am_exactratechange
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/medparam/ns-medparam-mp_paraminfo
struct MP_PARAMINFO
{
    MP_TYPE   mpType;
    uint      mopCaps;
    float     mpdMinValue;
    float     mpdMaxValue;
    float     mpdNeutralValue;
    wchar[32] szUnitText;
    wchar[32] szLabel;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/medparam/ns-medparam-mp_envelope_segment
struct MP_ENVELOPE_SEGMENT
{
    long          rtStart;
    long          rtEnd;
    float         valStart;
    float         valEnd;
    MP_CURVE_TYPE iCurve;
    uint          flags;
}

struct VFW_FILTERLIST
{
    uint    cFilters;
    GUID[1] aClsId; // Flexible array
}

struct DXVA2_VIDEOSAMPLE
{
    long                 Start;
    long                 End;
    DXVA2_ExtendedFormat SampleFormat;
    uint                 SampleFlags;
    void*                SrcResource;
    RECT                 SrcRect;
    RECT                 DstRect;
    DXVA2_AYUVSample8[16] Pal;
    DXVA2_Fixed32        PlanarAlpha;
}

struct DXVA2_VIDEOPROCESSBLT
{
    long                 TargetFrame;
    RECT                 TargetRect;
    SIZE                 ConstrictionSize;
    uint                 StreamingFlags;
    DXVA2_AYUVSample16   BackgroundColor;
    DXVA2_ExtendedFormat DestFormat;
    uint                 DestFlags;
    DXVA2_ProcAmpValues  ProcAmpValues;
    DXVA2_Fixed32        Alpha;
    DXVA2_FilterValues   NoiseFilterLuma;
    DXVA2_FilterValues   NoiseFilterChroma;
    DXVA2_FilterValues   DetailFilterLuma;
    DXVA2_FilterValues   DetailFilterChroma;
    DXVA2_VIDEOSAMPLE*   pSrcSurfaces;
    uint                 NumSrcSurfaces;
}

struct DXVA2SW_CALLBACKS
{
    uint Size;
    PDXVA2SW_GETVIDEOPROCESSORRENDERTARGETCOUNT GetVideoProcessorRenderTargetCount;
    PDXVA2SW_GETVIDEOPROCESSORRENDERTARGETS GetVideoProcessorRenderTargets;
    PDXVA2SW_GETVIDEOPROCESSORCAPS GetVideoProcessorCaps;
    PDXVA2SW_GETVIDEOPROCESSORSUBSTREAMFORMATCOUNT GetVideoProcessorSubStreamFormatCount;
    PDXVA2SW_GETVIDEOPROCESSORSUBSTREAMFORMATS GetVideoProcessorSubStreamFormats;
    PDXVA2SW_GETPROCAMPRANGE GetProcAmpRange;
    PDXVA2SW_GETFILTERPROPERTYRANGE GetFilterPropertyRange;
    PDXVA2SW_CREATEVIDEOPROCESSDEVICE CreateVideoProcessDevice;
    PDXVA2SW_DESTROYVIDEOPROCESSDEVICE DestroyVideoProcessDevice;
    PDXVA2SW_VIDEOPROCESSBEGINFRAME VideoProcessBeginFrame;
    PDXVA2SW_VIDEOPROCESSENDFRAME VideoProcessEndFrame;
    PDXVA2SW_VIDEOPROCESSSETRENDERTARGET VideoProcessSetRenderTarget;
    PDXVA2SW_VIDEOPROCESSBLT VideoProcessBlt;
}

struct DXVA2Trace_DecodeDevCreatedData
{
    EVENT_TRACE_HEADER wmiHeader;
    ulong              pObject;
    ulong              pD3DDevice;
    GUID               DeviceGuid;
    uint               Width;
    uint               Height;
    BOOL               Enter;
}

struct DXVA2Trace_DecodeDeviceData
{
    EVENT_TRACE_HEADER wmiHeader;
    ulong              pObject;
    BOOL               Enter;
}

struct DXVA2Trace_DecodeDevBeginFrameData
{
    EVENT_TRACE_HEADER wmiHeader;
    ulong              pObject;
    ulong              pRenderTarget;
    BOOL               Enter;
}

struct DXVA2Trace_DecodeDevGetBufferData
{
    EVENT_TRACE_HEADER wmiHeader;
    ulong              pObject;
    uint               BufferType;
    BOOL               Enter;
}

struct DXVA2Trace_VideoProcessDevCreatedData
{
    EVENT_TRACE_HEADER wmiHeader;
    ulong              pObject;
    ulong              pD3DDevice;
    GUID               DeviceGuid;
    uint               RTFourCC;
    uint               Width;
    uint               Height;
    BOOL               Enter;
}

struct DXVA2Trace_VideoProcessDeviceData
{
    EVENT_TRACE_HEADER wmiHeader;
    ulong              pObject;
    BOOL               Enter;
}

struct DXVA2TraceVideoProcessBltData
{
    EVENT_TRACE_HEADER wmiHeader;
    ulong              pObject;
    ulong              pRenderTarget;
    ulong              TargetFrameTime;
    RECT               TargetRect;
    BOOL               Enter;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmreg/ns-mmreg-mpeg1waveformat
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmreg/ns-mmreg-mpeglayer3waveformat
struct MPEGLAYER3WAVEFORMAT
{
align (1):
    WAVEFORMATEX wfx;
    ushort       wID;
    MPEGLAYER3WAVEFORMAT_FLAGS fdwFlags;
    ushort       nBlockSize;
    ushort       nFramesPerBlock;
    ushort       nCodecDelay;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmreg/ns-mmreg-heaacwaveinfo
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmreg/ns-mmreg-heaacwaveformat
struct HEAACWAVEFORMAT
{
    HEAACWAVEINFO wfInfo;
    ubyte[1]      pbAudioSpecificConfig; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dxva9typ/ns-dxva9typ-dxva_coppsetprotectionlevelcmddata
struct DXVA_COPPSetProtectionLevelCmdData
{
    uint ProtType;
    uint ProtLevel;
    uint ExtendedInfoChangeMask;
    uint ExtendedInfoData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dxva9typ/ns-dxva9typ-dxva_coppsetsignalingcmddata
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dxva9typ/ns-dxva9typ-dxva_coppstatusdata
struct DXVA_COPPStatusData
{
    GUID rApp;
    uint dwFlags;
    uint dwData;
    uint ExtendedInfoValidMask;
    uint ExtendedInfoData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dxva9typ/ns-dxva9typ-dxva_coppstatusdisplaydata
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dxva9typ/ns-dxva9typ-dxva_coppstatushdcpkeydata
struct DXVA_COPPStatusHDCPKeyData
{
    GUID rApp;
    uint dwFlags;
    uint dwHDCPFlags;
    GUID BKey;
    GUID Reserved1;
    GUID Reserved2;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dxva9typ/ns-dxva9typ-dxva_coppstatussignalingcmddata
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

// Functions

@DllImport("QUARTZ.dll")
uint AMGetErrorTextA(HRESULT hr, PSTR pbuffer, uint MaxLen);

@DllImport("QUARTZ.dll")
uint AMGetErrorTextW(HRESULT hr, PWSTR pbuffer, uint MaxLen);


// Interfaces

@GUID("e436ebb3-524f-11ce-9f53-0020af0ba770")
struct FilgraphManager;

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-icreatedevenum
@GUID("29840822-5b84-11d0-bd3b-00a0c911ce86")
interface ICreateDevEnum : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-icreatedevenum-createclassenumerator
    HRESULT CreateClassEnumerator(const(GUID)* clsidDeviceClass, IEnumMoniker* ppEnumMoniker, uint dwFlags);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-ipin
@GUID("56a86891-0ad4-11ce-b03a-0020af0ba770")
interface IPin : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ipin-connect
    HRESULT Connect(IPin pReceivePin, const(AM_MEDIA_TYPE)* pmt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ipin-receiveconnection
    HRESULT ReceiveConnection(IPin pConnector, const(AM_MEDIA_TYPE)* pmt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ipin-disconnect
    HRESULT Disconnect();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ipin-connectedto
    HRESULT ConnectedTo(IPin* pPin);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ipin-connectionmediatype
    HRESULT ConnectionMediaType(AM_MEDIA_TYPE* pmt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ipin-querypininfo
    HRESULT QueryPinInfo(PIN_INFO* pInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ipin-querydirection
    HRESULT QueryDirection(PIN_DIRECTION* pPinDir);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ipin-queryid
    HRESULT QueryId(PWSTR* Id);
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
    HRESULT QueryAccept(const(AM_MEDIA_TYPE)* pmt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ipin-enummediatypes
    HRESULT EnumMediaTypes(IEnumMediaTypes* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ipin-queryinternalconnections
    HRESULT QueryInternalConnections(IPin* apPin, uint* nPin);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ipin-endofstream
    HRESULT EndOfStream();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ipin-beginflush
    HRESULT BeginFlush();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ipin-endflush
    HRESULT EndFlush();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ipin-newsegment
    HRESULT NewSegment(long tStart, long tStop, double dRate);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-ienumpins
@GUID("56a86892-0ad4-11ce-b03a-0020af0ba770")
interface IEnumPins : IUnknown
{
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
    HRESULT Next(uint cPins, IPin* ppPins, uint* pcFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ienumpins-skip
    HRESULT Skip(uint cPins);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ienumpins-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ienumpins-clone
    HRESULT Clone(IEnumPins* ppEnum);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-ienummediatypes
@GUID("89c31040-846b-11ce-97d3-00aa0055595a")
interface IEnumMediaTypes : IUnknown
{
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
    HRESULT Next(uint cMediaTypes, AM_MEDIA_TYPE** ppMediaTypes, uint* pcFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ienummediatypes-skip
    HRESULT Skip(uint cMediaTypes);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ienummediatypes-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ienummediatypes-clone
    HRESULT Clone(IEnumMediaTypes* ppEnum);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-ifiltergraph
@GUID("56a8689f-0ad4-11ce-b03a-0020af0ba770")
interface IFilterGraph : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ifiltergraph-addfilter
    HRESULT AddFilter(IBaseFilter pFilter, const(PWSTR) pName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ifiltergraph-removefilter
    HRESULT RemoveFilter(IBaseFilter pFilter);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ifiltergraph-enumfilters
    HRESULT EnumFilters(IEnumFilters* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ifiltergraph-findfilterbyname
    HRESULT FindFilterByName(const(PWSTR) pName, IBaseFilter* ppFilter);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ifiltergraph-connectdirect
    HRESULT ConnectDirect(IPin ppinOut, IPin ppinIn, const(AM_MEDIA_TYPE)* pmt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ifiltergraph-reconnect
    HRESULT Reconnect(IPin ppin);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ifiltergraph-disconnect
    HRESULT Disconnect(IPin ppin);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ifiltergraph-setdefaultsyncsource
    HRESULT SetDefaultSyncSource();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-ienumfilters
@GUID("56a86893-0ad4-11ce-b03a-0020af0ba770")
interface IEnumFilters : IUnknown
{
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
    HRESULT Next(uint cFilters, IBaseFilter* ppFilter, uint* pcFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ienumfilters-skip
    HRESULT Skip(uint cFilters);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ienumfilters-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ienumfilters-clone
    HRESULT Clone(IEnumFilters* ppEnum);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-imediafilter
@GUID("56a86899-0ad4-11ce-b03a-0020af0ba770")
interface IMediaFilter : IPersist
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-imediafilter-stop
    HRESULT Stop();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-imediafilter-pause
    HRESULT Pause();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-imediafilter-run
    HRESULT Run(long tStart);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-imediafilter-getstate
    HRESULT GetState(uint dwMilliSecsTimeout, FILTER_STATE* State);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-imediafilter-setsyncsource
    HRESULT SetSyncSource(IReferenceClock pClock);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-imediafilter-getsyncsource
    HRESULT GetSyncSource(IReferenceClock* pClock);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-ibasefilter
@GUID("56a86895-0ad4-11ce-b03a-0020af0ba770")
interface IBaseFilter : IMediaFilter
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ibasefilter-enumpins
    HRESULT EnumPins(IEnumPins* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ibasefilter-findpin
    HRESULT FindPin(const(PWSTR) Id, IPin* ppPin);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ibasefilter-queryfilterinfo
    HRESULT QueryFilterInfo(FILTER_INFO* pInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ibasefilter-joinfiltergraph
    HRESULT JoinFilterGraph(IFilterGraph pGraph, const(PWSTR) pName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ibasefilter-queryvendorinfo
    HRESULT QueryVendorInfo(PWSTR* pVendorInfo);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-imediasample
@GUID("56a8689a-0ad4-11ce-b03a-0020af0ba770")
interface IMediaSample : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-imediasample-getpointer
    HRESULT GetPointer(ubyte** ppBuffer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-imediasample-getsize
    int     GetSize();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-imediasample-gettime
    HRESULT GetTime(long* pTimeStart, long* pTimeEnd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-imediasample-settime
    HRESULT SetTime(long* pTimeStart, long* pTimeEnd);
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
    HRESULT IsSyncPoint();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-imediasample-setsyncpoint
    HRESULT SetSyncPoint(BOOL bIsSyncPoint);
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
    HRESULT IsPreroll();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-imediasample-setpreroll
    HRESULT SetPreroll(BOOL bIsPreroll);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-imediasample-getactualdatalength
    int     GetActualDataLength();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-imediasample-setactualdatalength
    HRESULT SetActualDataLength(int __MIDL__IMediaSample0000);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-imediasample-getmediatype
    HRESULT GetMediaType(AM_MEDIA_TYPE** ppMediaType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-imediasample-setmediatype
    HRESULT SetMediaType(AM_MEDIA_TYPE* pMediaType);
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
    HRESULT IsDiscontinuity();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-imediasample-setdiscontinuity
    HRESULT SetDiscontinuity(BOOL bDiscontinuity);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-imediasample-getmediatime
    HRESULT GetMediaTime(long* pTimeStart, long* pTimeEnd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-imediasample-setmediatime
    HRESULT SetMediaTime(long* pTimeStart, long* pTimeEnd);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-imediasample2
@GUID("36b73884-c2c8-11cf-8b46-00805f6cef60")
interface IMediaSample2 : IMediaSample
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-imediasample2-getproperties
    HRESULT GetProperties(uint cbProperties, 
                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(0)))])*/ubyte* pbProperties);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-imediasample2-setproperties
    HRESULT SetProperties(uint cbProperties, 
                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(0)))])*/const(ubyte)* pbProperties);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-imediasample2config
@GUID("68961e68-832b-41ea-bc91-63593f3e70e3")
interface IMediaSample2Config : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-imediasample2config-getsurface
    HRESULT GetSurface(IUnknown* ppDirect3DSurface9);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-imemallocator
@GUID("56a8689c-0ad4-11ce-b03a-0020af0ba770")
interface IMemAllocator : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-imemallocator-setproperties
    HRESULT SetProperties(ALLOCATOR_PROPERTIES* pRequest, ALLOCATOR_PROPERTIES* pActual);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-imemallocator-getproperties
    HRESULT GetProperties(ALLOCATOR_PROPERTIES* pProps);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-imemallocator-commit
    HRESULT Commit();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-imemallocator-decommit
    HRESULT Decommit();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-imemallocator-getbuffer
    HRESULT GetBuffer(IMediaSample* ppBuffer, long* pStartTime, long* pEndTime, uint dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-imemallocator-releasebuffer
    HRESULT ReleaseBuffer(IMediaSample pBuffer);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-imemallocatorcallbacktemp
@GUID("379a0cf0-c1de-11d2-abf5-00a0c905f375")
interface IMemAllocatorCallbackTemp : IMemAllocator
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-imemallocatorcallbacktemp-setnotify
    HRESULT SetNotify(IMemAllocatorNotifyCallbackTemp pNotify);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-imemallocatorcallbacktemp-getfreecount
    HRESULT GetFreeCount(int* plBuffersFree);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-imemallocatornotifycallbacktemp
@GUID("92980b30-c1de-11d2-abf5-00a0c905f375")
interface IMemAllocatorNotifyCallbackTemp : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-imemallocatornotifycallbacktemp-notifyrelease
    HRESULT NotifyRelease();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-imeminputpin
@GUID("56a8689d-0ad4-11ce-b03a-0020af0ba770")
interface IMemInputPin : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-imeminputpin-getallocator
    HRESULT GetAllocator(IMemAllocator* ppAllocator);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-imeminputpin-notifyallocator
    HRESULT NotifyAllocator(IMemAllocator pAllocator, BOOL bReadOnly);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-imeminputpin-getallocatorrequirements
    HRESULT GetAllocatorRequirements(ALLOCATOR_PROPERTIES* pProps);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-imeminputpin-receive
    HRESULT Receive(IMediaSample pSample);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-imeminputpin-receivemultiple
    HRESULT ReceiveMultiple(IMediaSample* pSamples, int nSamples, int* nSamplesProcessed);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-imeminputpin-receivecanblock
    HRESULT ReceiveCanBlock();
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-iamoviesetup
@GUID("a3d8cec0-7e5a-11cf-bbc5-00805f6cef20")
interface IAMovieSetup : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamoviesetup-register
    HRESULT Register();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamoviesetup-unregister
    HRESULT Unregister();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-imediaseeking
@GUID("36b73880-c2c8-11cf-8b46-00805f6cef60")
interface IMediaSeeking : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-imediaseeking-getcapabilities
    HRESULT GetCapabilities(uint* pCapabilities);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-imediaseeking-checkcapabilities
    HRESULT CheckCapabilities(uint* pCapabilities);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-imediaseeking-isformatsupported
    HRESULT IsFormatSupported(const(GUID)* pFormat);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-imediaseeking-querypreferredformat
    HRESULT QueryPreferredFormat(GUID* pFormat);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-imediaseeking-gettimeformat
    HRESULT GetTimeFormat(GUID* pFormat);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-imediaseeking-isusingtimeformat
    HRESULT IsUsingTimeFormat(const(GUID)* pFormat);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-imediaseeking-settimeformat
    HRESULT SetTimeFormat(const(GUID)* pFormat);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-imediaseeking-getduration
    HRESULT GetDuration(long* pDuration);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-imediaseeking-getstopposition
    HRESULT GetStopPosition(long* pStop);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-imediaseeking-getcurrentposition
    HRESULT GetCurrentPosition(long* pCurrent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-imediaseeking-converttimeformat
    HRESULT ConvertTimeFormat(long* pTarget, const(GUID)* pTargetFormat, long Source, const(GUID)* pSourceFormat);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-imediaseeking-setpositions
    HRESULT SetPositions(long* pCurrent, uint dwCurrentFlags, long* pStop, uint dwStopFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-imediaseeking-getpositions
    HRESULT GetPositions(long* pCurrent, long* pStop);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-imediaseeking-getavailable
    HRESULT GetAvailable(long* pEarliest, long* pLatest);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-imediaseeking-setrate
    HRESULT SetRate(double dRate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-imediaseeking-getrate
    HRESULT GetRate(double* pdRate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-imediaseeking-getpreroll
    HRESULT GetPreroll(long* pllPreroll);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-ienumregfilters
@GUID("56a868a4-0ad4-11ce-b03a-0020af0ba770")
interface IEnumRegFilters : IUnknown
{
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
    HRESULT Next(uint cFilters, REGFILTER** apRegFilter, uint* pcFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ienumregfilters-skip
    HRESULT Skip(uint cFilters);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ienumregfilters-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ienumregfilters-clone
    HRESULT Clone(IEnumRegFilters* ppEnum);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-ifiltermapper
@GUID("56a868a3-0ad4-11ce-b03a-0020af0ba770")
interface IFilterMapper : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ifiltermapper-registerfilter
    HRESULT RegisterFilter(GUID clsid, const(PWSTR) Name, uint dwMerit);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ifiltermapper-registerfilterinstance
    HRESULT RegisterFilterInstance(GUID clsid, const(PWSTR) Name, GUID* MRId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ifiltermapper-registerpin
    HRESULT RegisterPin(GUID Filter, const(PWSTR) Name, BOOL bRendered, BOOL bOutput, BOOL bZero, BOOL bMany, 
                        GUID ConnectsToFilter, const(PWSTR) ConnectsToPin);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ifiltermapper-registerpintype
    HRESULT RegisterPinType(GUID clsFilter, const(PWSTR) strName, GUID clsMajorType, GUID clsSubType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ifiltermapper-unregisterfilter
    HRESULT UnregisterFilter(GUID Filter);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ifiltermapper-unregisterfilterinstance
    HRESULT UnregisterFilterInstance(GUID MRId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ifiltermapper-unregisterpin
    HRESULT UnregisterPin(GUID Filter, const(PWSTR) Name);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ifiltermapper-enummatchingfilters
    HRESULT EnumMatchingFilters(IEnumRegFilters* ppEnum, uint dwMerit, BOOL bInputNeeded, GUID clsInMaj, 
                                GUID clsInSub, BOOL bRender, BOOL bOututNeeded, GUID clsOutMaj, GUID clsOutSub);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-ifiltermapper2
@GUID("b79bb0b0-33c1-11d1-abe1-00a0c905f375")
interface IFilterMapper2 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ifiltermapper2-createcategory
    HRESULT CreateCategory(const(GUID)* clsidCategory, uint dwCategoryMerit, const(PWSTR) Description);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ifiltermapper2-unregisterfilter
    HRESULT UnregisterFilter(const(GUID)* pclsidCategory, const(PWSTR) szInstance, const(GUID)* Filter);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ifiltermapper2-registerfilter
    HRESULT RegisterFilter(const(GUID)* clsidFilter, const(PWSTR) Name, IMoniker* ppMoniker, 
                           const(GUID)* pclsidCategory, const(PWSTR) szInstance, const(REGFILTER2)* prf2);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ifiltermapper2-enummatchingfilters
    HRESULT EnumMatchingFilters(IEnumMoniker* ppEnum, uint dwFlags, BOOL bExactMatch, uint dwMerit, 
                                BOOL bInputNeeded, uint cInputTypes, const(GUID)* pInputTypes, 
                                const(REGPINMEDIUM)* pMedIn, const(GUID)* pPinCategoryIn, BOOL bRender, 
                                BOOL bOutputNeeded, uint cOutputTypes, const(GUID)* pOutputTypes, 
                                const(REGPINMEDIUM)* pMedOut, const(GUID)* pPinCategoryOut);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-ifiltermapper3
@GUID("b79bb0b1-33c1-11d1-abe1-00a0c905f375")
interface IFilterMapper3 : IFilterMapper2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ifiltermapper3-geticreatedevenum
    HRESULT GetICreateDevEnum(ICreateDevEnum* ppEnum);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-iqualitycontrol
@GUID("56a868a5-0ad4-11ce-b03a-0020af0ba770")
interface IQualityControl : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iqualitycontrol-notify
    HRESULT Notify(IBaseFilter pSelf, Quality q);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iqualitycontrol-setsink
    HRESULT SetSink(IQualityControl piqc);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-ioverlaynotify
@GUID("56a868a0-0ad4-11ce-b03a-0020af0ba770")
interface IOverlayNotify : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ioverlaynotify-onpalettechange
    HRESULT OnPaletteChange(uint dwColors, const(PALETTEENTRY)* pPalette);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ioverlaynotify-onclipchange
    HRESULT OnClipChange(const(RECT)* pSourceRect, const(RECT)* pDestinationRect, const(RGNDATA)* pRgnData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ioverlaynotify-oncolorkeychange
    HRESULT OnColorKeyChange(const(COLORKEY)* pColorKey);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ioverlaynotify-onpositionchange
    HRESULT OnPositionChange(const(RECT)* pSourceRect, const(RECT)* pDestinationRect);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-ioverlaynotify2
@GUID("680efa10-d535-11d1-87c8-00a0c9223196")
interface IOverlayNotify2 : IOverlayNotify
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ioverlaynotify2-ondisplaychange
    HRESULT OnDisplayChange(HMONITOR hMonitor);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-ioverlay
@GUID("56a868a1-0ad4-11ce-b03a-0020af0ba770")
interface IOverlay : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ioverlay-getpalette
    HRESULT GetPalette(uint* pdwColors, PALETTEENTRY** ppPalette);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ioverlay-setpalette
    HRESULT SetPalette(uint dwColors, PALETTEENTRY* pPalette);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ioverlay-getdefaultcolorkey
    HRESULT GetDefaultColorKey(COLORKEY* pColorKey);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ioverlay-getcolorkey
    HRESULT GetColorKey(COLORKEY* pColorKey);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ioverlay-setcolorkey
    HRESULT SetColorKey(COLORKEY* pColorKey);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ioverlay-getwindowhandle
    HRESULT GetWindowHandle(HWND* pHwnd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ioverlay-getcliplist
    HRESULT GetClipList(RECT* pSourceRect, RECT* pDestinationRect, RGNDATA** ppRgnData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ioverlay-getvideoposition
    HRESULT GetVideoPosition(RECT* pSourceRect, RECT* pDestinationRect);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ioverlay-advise
    HRESULT Advise(IOverlayNotify pOverlayNotify, uint dwInterests);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ioverlay-unadvise
    HRESULT Unadvise();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-imediaeventsink
@GUID("56a868a2-0ad4-11ce-b03a-0020af0ba770")
interface IMediaEventSink : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-imediaeventsink-notify
    HRESULT Notify(int EventCode, ptrdiff_t EventParam1, ptrdiff_t EventParam2);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-ifilesourcefilter
@GUID("56a868a6-0ad4-11ce-b03a-0020af0ba770")
interface IFileSourceFilter : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ifilesourcefilter-load
    HRESULT Load(const(PWSTR) pszFileName, const(AM_MEDIA_TYPE)* pmt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ifilesourcefilter-getcurfile
    HRESULT GetCurFile(PWSTR* ppszFileName, AM_MEDIA_TYPE* pmt);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-ifilesinkfilter
@GUID("a2104830-7c70-11cf-8bce-00aa00a3f1a6")
interface IFileSinkFilter : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ifilesinkfilter-setfilename
    HRESULT SetFileName(const(PWSTR) pszFileName, const(AM_MEDIA_TYPE)* pmt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ifilesinkfilter-getcurfile
    HRESULT GetCurFile(PWSTR* ppszFileName, AM_MEDIA_TYPE* pmt);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-ifilesinkfilter2
@GUID("00855b90-ce1b-11d0-bd4f-00a0c911ce86")
interface IFileSinkFilter2 : IFileSinkFilter
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ifilesinkfilter2-setmode
    HRESULT SetMode(uint dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ifilesinkfilter2-getmode
    HRESULT GetMode(uint* pdwFlags);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-igraphbuilder
@GUID("56a868a9-0ad4-11ce-b03a-0020af0ba770")
interface IGraphBuilder : IFilterGraph
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-igraphbuilder-connect
    HRESULT Connect(IPin ppinOut, IPin ppinIn);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-igraphbuilder-render
    HRESULT Render(IPin ppinOut);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-igraphbuilder-renderfile
    HRESULT RenderFile(const(PWSTR) lpcwstrFile, const(PWSTR) lpcwstrPlayList);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-igraphbuilder-addsourcefilter
    HRESULT AddSourceFilter(const(PWSTR) lpcwstrFileName, const(PWSTR) lpcwstrFilterName, IBaseFilter* ppFilter);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-igraphbuilder-setlogfile
    HRESULT SetLogFile(size_t hFile);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-igraphbuilder-abort
    HRESULT Abort();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-igraphbuilder-shouldoperationcontinue
    HRESULT ShouldOperationContinue();
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-icapturegraphbuilder
@GUID("bf87b6e0-8c27-11d0-b3f0-00aa003761c5")
interface ICaptureGraphBuilder : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-icapturegraphbuilder-setfiltergraph
    HRESULT SetFiltergraph(IGraphBuilder pfg);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-icapturegraphbuilder-getfiltergraph
    HRESULT GetFiltergraph(IGraphBuilder* ppfg);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-icapturegraphbuilder-setoutputfilename
    HRESULT SetOutputFileName(const(GUID)* pType, const(PWSTR) lpstrFile, IBaseFilter* ppf, 
                              IFileSinkFilter* ppSink);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-icapturegraphbuilder-findinterface
    HRESULT FindInterface(const(GUID)* pCategory, IBaseFilter pf, const(GUID)* riid, void** ppint);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-icapturegraphbuilder-renderstream
    HRESULT RenderStream(const(GUID)* pCategory, IUnknown pSource, IBaseFilter pfCompressor, 
                         IBaseFilter pfRenderer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-icapturegraphbuilder-controlstream
    HRESULT ControlStream(const(GUID)* pCategory, IBaseFilter pFilter, long* pstart, long* pstop, 
                          ushort wStartCookie, ushort wStopCookie);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-icapturegraphbuilder-alloccapfile
    HRESULT AllocCapFile(const(PWSTR) lpstr, ulong dwlSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-icapturegraphbuilder-copycapturefile
    HRESULT CopyCaptureFile(PWSTR lpwstrOld, PWSTR lpwstrNew, int fAllowEscAbort, 
                            IAMCopyCaptureFileProgress pCallback);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-iamcopycapturefileprogress
@GUID("670d1d20-a068-11d0-b3f0-00aa003761c5")
interface IAMCopyCaptureFileProgress : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamcopycapturefileprogress-progress
    HRESULT Progress(int iProgress);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-icapturegraphbuilder2
@GUID("93e5a4e0-2d50-11d2-abfa-00a0c9c6e38d")
interface ICaptureGraphBuilder2 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-icapturegraphbuilder2-setfiltergraph
    HRESULT SetFiltergraph(IGraphBuilder pfg);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-icapturegraphbuilder2-getfiltergraph
    HRESULT GetFiltergraph(IGraphBuilder* ppfg);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-icapturegraphbuilder2-setoutputfilename
    HRESULT SetOutputFileName(const(GUID)* pType, const(PWSTR) lpstrFile, IBaseFilter* ppf, 
                              IFileSinkFilter* ppSink);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-icapturegraphbuilder2-findinterface
    HRESULT FindInterface(const(GUID)* pCategory, const(GUID)* pType, IBaseFilter pf, const(GUID)* riid, 
                          void** ppint);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-icapturegraphbuilder2-renderstream
    HRESULT RenderStream(const(GUID)* pCategory, const(GUID)* pType, IUnknown pSource, IBaseFilter pfCompressor, 
                         IBaseFilter pfRenderer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-icapturegraphbuilder2-controlstream
    HRESULT ControlStream(const(GUID)* pCategory, const(GUID)* pType, IBaseFilter pFilter, long* pstart, 
                          long* pstop, ushort wStartCookie, ushort wStopCookie);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-icapturegraphbuilder2-alloccapfile
    HRESULT AllocCapFile(const(PWSTR) lpstr, ulong dwlSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-icapturegraphbuilder2-copycapturefile
    HRESULT CopyCaptureFile(PWSTR lpwstrOld, PWSTR lpwstrNew, int fAllowEscAbort, 
                            IAMCopyCaptureFileProgress pCallback);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-icapturegraphbuilder2-findpin
    HRESULT FindPin(IUnknown pSource, PIN_DIRECTION pindir, const(GUID)* pCategory, const(GUID)* pType, 
                    BOOL fUnconnected, int num, IPin* ppPin);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-ifiltergraph2
@GUID("36b73882-c2c8-11cf-8b46-00805f6cef60")
interface IFilterGraph2 : IGraphBuilder
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ifiltergraph2-addsourcefilterformoniker
    HRESULT AddSourceFilterForMoniker(IMoniker pMoniker, IBindCtx pCtx, const(PWSTR) lpcwstrFilterName, 
                                      IBaseFilter* ppFilter);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ifiltergraph2-reconnectex
    HRESULT ReconnectEx(IPin ppin, const(AM_MEDIA_TYPE)* pmt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ifiltergraph2-renderex
    HRESULT RenderEx(IPin pPinOut, uint dwFlags, 
                     /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint* pvContext);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-ifiltergraph3
@GUID("aaf38154-b80b-422f-91e6-b66467509a07")
interface IFilterGraph3 : IFilterGraph2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ifiltergraph3-setsyncsourceex
    HRESULT SetSyncSourceEx(IReferenceClock pClockForMostOfFilterGraph, IReferenceClock pClockForFilter, 
                            IBaseFilter pFilter);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-istreambuilder
@GUID("56a868bf-0ad4-11ce-b03a-0020af0ba770")
interface IStreamBuilder : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-istreambuilder-render
    HRESULT Render(IPin ppinOut, IGraphBuilder pGraph);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-istreambuilder-backout
    HRESULT Backout(IPin ppinOut, IGraphBuilder pGraph);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-iasyncreader
@GUID("56a868aa-0ad4-11ce-b03a-0020af0ba770")
interface IAsyncReader : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iasyncreader-requestallocator
    HRESULT RequestAllocator(IMemAllocator pPreferred, ALLOCATOR_PROPERTIES* pProps, IMemAllocator* ppActual);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iasyncreader-request
    HRESULT Request(IMediaSample pSample, size_t dwUser);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iasyncreader-waitfornext
    HRESULT WaitForNext(uint dwTimeout, IMediaSample* ppSample, size_t* pdwUser);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iasyncreader-syncreadaligned
    HRESULT SyncReadAligned(IMediaSample pSample);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iasyncreader-syncread
    HRESULT SyncRead(long llPosition, int lLength, 
                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/ubyte* pBuffer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iasyncreader-length
    HRESULT Length(long* pTotal, long* pAvailable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iasyncreader-beginflush
    HRESULT BeginFlush();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iasyncreader-endflush
    HRESULT EndFlush();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-igraphversion
@GUID("56a868ab-0ad4-11ce-b03a-0020af0ba770")
interface IGraphVersion : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-igraphversion-queryversion
    HRESULT QueryVersion(int* pVersion);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-iresourceconsumer
@GUID("56a868ad-0ad4-11ce-b03a-0020af0ba770")
interface IResourceConsumer : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iresourceconsumer-acquireresource
    HRESULT AcquireResource(int idResource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iresourceconsumer-releaseresource
    HRESULT ReleaseResource(int idResource);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-iresourcemanager
@GUID("56a868ac-0ad4-11ce-b03a-0020af0ba770")
interface IResourceManager : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iresourcemanager-register
    HRESULT Register(const(PWSTR) pName, int cResource, int* plToken);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iresourcemanager-registergroup
    HRESULT RegisterGroup(const(PWSTR) pName, int cResource, int* palTokens, int* plToken);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iresourcemanager-requestresource
    HRESULT RequestResource(int idResource, IUnknown pFocusObject, IResourceConsumer pConsumer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iresourcemanager-notifyacquire
    HRESULT NotifyAcquire(int idResource, IResourceConsumer pConsumer, HRESULT hr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iresourcemanager-notifyrelease
    HRESULT NotifyRelease(int idResource, IResourceConsumer pConsumer, BOOL bStillWant);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iresourcemanager-cancelrequest
    HRESULT CancelRequest(int idResource, IResourceConsumer pConsumer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iresourcemanager-setfocus
    HRESULT SetFocus(IUnknown pFocusObject);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iresourcemanager-releasefocus
    HRESULT ReleaseFocus(IUnknown pFocusObject);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-idistributornotify
@GUID("56a868af-0ad4-11ce-b03a-0020af0ba770")
interface IDistributorNotify : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idistributornotify-stop
    HRESULT Stop();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idistributornotify-pause
    HRESULT Pause();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idistributornotify-run
    HRESULT Run(long tStart);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idistributornotify-setsyncsource
    HRESULT SetSyncSource(IReferenceClock pClock);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idistributornotify-notifygraphchange
    HRESULT NotifyGraphChange();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-iamstreamcontrol
@GUID("36b73881-c2c8-11cf-8b46-00805f6cef60")
interface IAMStreamControl : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamstreamcontrol-startat
    HRESULT StartAt(const(long)* ptStart, uint dwCookie);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamstreamcontrol-stopat
    HRESULT StopAt(const(long)* ptStop, BOOL bSendExtra, uint dwCookie);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamstreamcontrol-getinfo
    HRESULT GetInfo(AM_STREAM_INFO* pInfo);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-iseekingpassthru
@GUID("36b73883-c2c8-11cf-8b46-00805f6cef60")
interface ISeekingPassThru : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iseekingpassthru-init
    HRESULT Init(BOOL bSupportRendering, IPin pPin);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-iamstreamconfig
@GUID("c6e13340-30ac-11d0-a18c-00a0c9118956")
interface IAMStreamConfig : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamstreamconfig-setformat
    HRESULT SetFormat(AM_MEDIA_TYPE* pmt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamstreamconfig-getformat
    HRESULT GetFormat(AM_MEDIA_TYPE** ppmt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamstreamconfig-getnumberofcapabilities
    HRESULT GetNumberOfCapabilities(int* piCount, int* piSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamstreamconfig-getstreamcaps
    HRESULT GetStreamCaps(int iIndex, AM_MEDIA_TYPE** ppmt, ubyte* pSCC);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-iconfiginterleaving
@GUID("bee3d220-157b-11d0-bd23-00a0c911ce86")
interface IConfigInterleaving : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iconfiginterleaving-put_mode
    HRESULT put_Mode(InterleavingMode mode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iconfiginterleaving-get_mode
    HRESULT get_Mode(InterleavingMode* pMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iconfiginterleaving-put_interleaving
    HRESULT put_Interleaving(const(long)* prtInterleave, const(long)* prtPreroll);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iconfiginterleaving-get_interleaving
    HRESULT get_Interleaving(long* prtInterleave, long* prtPreroll);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-iconfigavimux
@GUID("5acd6aa0-f482-11ce-8b67-00aa00a3f1a6")
interface IConfigAviMux : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iconfigavimux-setmasterstream
    HRESULT SetMasterStream(int iStream);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iconfigavimux-getmasterstream
    HRESULT GetMasterStream(int* pStream);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iconfigavimux-setoutputcompatibilityindex
    HRESULT SetOutputCompatibilityIndex(BOOL fOldIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iconfigavimux-getoutputcompatibilityindex
    HRESULT GetOutputCompatibilityIndex(BOOL* pfOldIndex);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-iamvideocompression
@GUID("c6e13343-30ac-11d0-a18c-00a0c9118956")
interface IAMVideoCompression : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamvideocompression-put_keyframerate
    HRESULT put_KeyFrameRate(int KeyFrameRate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamvideocompression-get_keyframerate
    HRESULT get_KeyFrameRate(int* pKeyFrameRate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamvideocompression-put_pframesperkeyframe
    HRESULT put_PFramesPerKeyFrame(int PFramesPerKeyFrame);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamvideocompression-get_pframesperkeyframe
    HRESULT get_PFramesPerKeyFrame(int* pPFramesPerKeyFrame);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamvideocompression-put_quality
    HRESULT put_Quality(double Quality);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamvideocompression-get_quality
    HRESULT get_Quality(double* pQuality);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamvideocompression-put_windowsize
    HRESULT put_WindowSize(ulong WindowSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamvideocompression-get_windowsize
    HRESULT get_WindowSize(ulong* pWindowSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamvideocompression-getinfo
    HRESULT GetInfo(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/PWSTR pszVersion, 
                    int* pcbVersion, 
                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/PWSTR pszDescription, 
                    int* pcbDescription, int* pDefaultKeyFrameRate, int* pDefaultPFramesPerKey, 
                    double* pDefaultQuality, int* pCapabilities);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamvideocompression-overridekeyframe
    HRESULT OverrideKeyFrame(int FrameNumber);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamvideocompression-overrideframesize
    HRESULT OverrideFrameSize(int FrameNumber, int Size);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-iamvfwcapturedialogs
@GUID("d8d715a0-6e5e-11d0-b3f0-00aa003761c5")
interface IAMVfwCaptureDialogs : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamvfwcapturedialogs-hasdialog
    HRESULT HasDialog(int iDialog);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamvfwcapturedialogs-showdialog
    HRESULT ShowDialog(int iDialog, HWND hwnd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamvfwcapturedialogs-senddrivermessage
    HRESULT SendDriverMessage(int iDialog, int uMsg, int dw1, int dw2);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-iamvfwcompressdialogs
@GUID("d8d715a3-6e5e-11d0-b3f0-00aa003761c5")
interface IAMVfwCompressDialogs : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamvfwcompressdialogs-showdialog
    HRESULT ShowDialog(int iDialog, HWND hwnd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamvfwcompressdialogs-getstate
    HRESULT GetState(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* pState, 
                     int* pcbState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamvfwcompressdialogs-setstate
    HRESULT SetState(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* pState, 
                     int cbState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamvfwcompressdialogs-senddrivermessage
    HRESULT SendDriverMessage(int uMsg, int dw1, int dw2);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-iamdroppedframes
@GUID("c6e13344-30ac-11d0-a18c-00a0c9118956")
interface IAMDroppedFrames : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamdroppedframes-getnumdropped
    HRESULT GetNumDropped(int* plDropped);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamdroppedframes-getnumnotdropped
    HRESULT GetNumNotDropped(int* plNotDropped);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamdroppedframes-getdroppedinfo
    HRESULT GetDroppedInfo(int lSize, int* plArray, int* plNumCopied);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamdroppedframes-getaverageframesize
    HRESULT GetAverageFrameSize(int* plAverageSize);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-iamaudioinputmixer
@GUID("54c39221-8380-11d0-b3f0-00aa003761c5")
interface IAMAudioInputMixer : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamaudioinputmixer-put_enable
    HRESULT put_Enable(BOOL fEnable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamaudioinputmixer-get_enable
    HRESULT get_Enable(BOOL* pfEnable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamaudioinputmixer-put_mono
    HRESULT put_Mono(BOOL fMono);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamaudioinputmixer-get_mono
    HRESULT get_Mono(BOOL* pfMono);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamaudioinputmixer-put_mixlevel
    HRESULT put_MixLevel(double Level);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamaudioinputmixer-get_mixlevel
    HRESULT get_MixLevel(double* pLevel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamaudioinputmixer-put_pan
    HRESULT put_Pan(double Pan);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamaudioinputmixer-get_pan
    HRESULT get_Pan(double* pPan);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamaudioinputmixer-put_loudness
    HRESULT put_Loudness(BOOL fLoudness);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamaudioinputmixer-get_loudness
    HRESULT get_Loudness(BOOL* pfLoudness);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamaudioinputmixer-put_treble
    HRESULT put_Treble(double Treble);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamaudioinputmixer-get_treble
    HRESULT get_Treble(double* pTreble);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamaudioinputmixer-get_treblerange
    HRESULT get_TrebleRange(double* pRange);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamaudioinputmixer-put_bass
    HRESULT put_Bass(double Bass);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamaudioinputmixer-get_bass
    HRESULT get_Bass(double* pBass);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamaudioinputmixer-get_bassrange
    HRESULT get_BassRange(double* pRange);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-iambuffernegotiation
@GUID("56ed71a0-af5f-11d0-b3f0-00aa003761c5")
interface IAMBufferNegotiation : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iambuffernegotiation-suggestallocatorproperties
    HRESULT SuggestAllocatorProperties(const(ALLOCATOR_PROPERTIES)* pprop);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iambuffernegotiation-getallocatorproperties
    HRESULT GetAllocatorProperties(ALLOCATOR_PROPERTIES* pprop);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-iamanalogvideodecoder
@GUID("c6e13350-30ac-11d0-a18c-00a0c9118956")
interface IAMAnalogVideoDecoder : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamanalogvideodecoder-get_availabletvformats
    HRESULT get_AvailableTVFormats(int* lAnalogVideoStandard);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamanalogvideodecoder-put_tvformat
    HRESULT put_TVFormat(int lAnalogVideoStandard);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamanalogvideodecoder-get_tvformat
    HRESULT get_TVFormat(int* plAnalogVideoStandard);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamanalogvideodecoder-get_horizontallocked
    HRESULT get_HorizontalLocked(int* plLocked);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamanalogvideodecoder-put_vcrhorizontallocking
    HRESULT put_VCRHorizontalLocking(int lVCRHorizontalLocking);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamanalogvideodecoder-get_vcrhorizontallocking
    HRESULT get_VCRHorizontalLocking(int* plVCRHorizontalLocking);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamanalogvideodecoder-get_numberoflines
    HRESULT get_NumberOfLines(int* plNumberOfLines);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamanalogvideodecoder-put_outputenable
    HRESULT put_OutputEnable(int lOutputEnable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamanalogvideodecoder-get_outputenable
    HRESULT get_OutputEnable(int* plOutputEnable);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-iamvideoprocamp
@GUID("c6e13360-30ac-11d0-a18c-00a0c9118956")
interface IAMVideoProcAmp : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamvideoprocamp-getrange
    HRESULT GetRange(int Property, int* pMin, int* pMax, int* pSteppingDelta, int* pDefault, int* pCapsFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamvideoprocamp-set
    HRESULT Set(int Property, int lValue, int Flags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamvideoprocamp-get
    HRESULT Get(int Property, int* lValue, int* Flags);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-iamcameracontrol
@GUID("c6e13370-30ac-11d0-a18c-00a0c9118956")
interface IAMCameraControl : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamcameracontrol-getrange
    HRESULT GetRange(int Property, int* pMin, int* pMax, int* pSteppingDelta, int* pDefault, int* pCapsFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamcameracontrol-set
    HRESULT Set(int Property, int lValue, int Flags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamcameracontrol-get
    HRESULT Get(int Property, int* lValue, int* Flags);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-iamvideocontrol
@GUID("6a2e0670-28e4-11d0-a18c-00a0c9118956")
interface IAMVideoControl : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamvideocontrol-getcaps
    HRESULT GetCaps(IPin pPin, int* pCapsFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamvideocontrol-setmode
    HRESULT SetMode(IPin pPin, int Mode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamvideocontrol-getmode
    HRESULT GetMode(IPin pPin, int* Mode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamvideocontrol-getcurrentactualframerate
    HRESULT GetCurrentActualFrameRate(IPin pPin, long* ActualFrameRate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamvideocontrol-getmaxavailableframerate
    HRESULT GetMaxAvailableFrameRate(IPin pPin, int iIndex, SIZE Dimensions, long* MaxAvailableFrameRate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamvideocontrol-getframeratelist
    HRESULT GetFrameRateList(IPin pPin, int iIndex, SIZE Dimensions, int* ListSize, long** FrameRates);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-iamcrossbar
@GUID("c6e13380-30ac-11d0-a18c-00a0c9118956")
interface IAMCrossbar : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamcrossbar-get_pincounts
    HRESULT get_PinCounts(int* OutputPinCount, int* InputPinCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamcrossbar-canroute
    HRESULT CanRoute(int OutputPinIndex, int InputPinIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamcrossbar-route
    HRESULT Route(int OutputPinIndex, int InputPinIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamcrossbar-get_isroutedto
    HRESULT get_IsRoutedTo(int OutputPinIndex, int* InputPinIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamcrossbar-get_crossbarpininfo
    HRESULT get_CrossbarPinInfo(BOOL IsInputPin, int PinIndex, int* PinIndexRelated, int* PhysicalType);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-iamtuner
@GUID("211a8761-03ac-11d1-8d13-00aa00bd8339")
interface IAMTuner : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamtuner-put_channel
    HRESULT put_Channel(int lChannel, int lVideoSubChannel, int lAudioSubChannel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamtuner-get_channel
    HRESULT get_Channel(int* plChannel, int* plVideoSubChannel, int* plAudioSubChannel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamtuner-channelminmax
    HRESULT ChannelMinMax(int* lChannelMin, int* lChannelMax);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamtuner-put_countrycode
    HRESULT put_CountryCode(int lCountryCode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamtuner-get_countrycode
    HRESULT get_CountryCode(int* plCountryCode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamtuner-put_tuningspace
    HRESULT put_TuningSpace(int lTuningSpace);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamtuner-get_tuningspace
    HRESULT get_TuningSpace(int* plTuningSpace);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamtuner-logon
    HRESULT Logon(HANDLE hCurrentUser);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamtuner-logout
    HRESULT Logout();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamtuner-signalpresent
    HRESULT SignalPresent(int* plSignalStrength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamtuner-put_mode
    HRESULT put_Mode(AMTunerModeType lMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamtuner-get_mode
    HRESULT get_Mode(AMTunerModeType* plMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamtuner-getavailablemodes
    HRESULT GetAvailableModes(int* plModes);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamtuner-registernotificationcallback
    HRESULT RegisterNotificationCallBack(IAMTunerNotification pNotify, int lEvents);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamtuner-unregisternotificationcallback
    HRESULT UnRegisterNotificationCallBack(IAMTunerNotification pNotify);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-iamtunernotification
@GUID("211a8760-03ac-11d1-8d13-00aa00bd8339")
interface IAMTunerNotification : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamtunernotification-onevent
    HRESULT OnEvent(AMTunerEventType Event);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-iamtvtuner
@GUID("211a8766-03ac-11d1-8d13-00aa00bd8339")
interface IAMTVTuner : IAMTuner
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamtvtuner-get_availabletvformats
    HRESULT get_AvailableTVFormats(int* lAnalogVideoStandard);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamtvtuner-get_tvformat
    HRESULT get_TVFormat(int* plAnalogVideoStandard);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamtvtuner-autotune
    HRESULT AutoTune(int lChannel, int* plFoundSignal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamtvtuner-storeautotune
    HRESULT StoreAutoTune();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamtvtuner-get_numinputconnections
    HRESULT get_NumInputConnections(int* plNumInputConnections);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamtvtuner-put_inputtype
    HRESULT put_InputType(int lIndex, TunerInputType InputType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamtvtuner-get_inputtype
    HRESULT get_InputType(int lIndex, TunerInputType* pInputType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamtvtuner-put_connectinput
    HRESULT put_ConnectInput(int lIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamtvtuner-get_connectinput
    HRESULT get_ConnectInput(int* plIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamtvtuner-get_videofrequency
    HRESULT get_VideoFrequency(int* lFreq);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamtvtuner-get_audiofrequency
    HRESULT get_AudioFrequency(int* lFreq);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-ibpcsatellitetuner
@GUID("211a8765-03ac-11d1-8d13-00aa00bd8339")
interface IBPCSatelliteTuner : IAMTuner
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ibpcsatellitetuner-get_defaultsubchanneltypes
    HRESULT get_DefaultSubChannelTypes(int* plDefaultVideoType, int* plDefaultAudioType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ibpcsatellitetuner-put_defaultsubchanneltypes
    HRESULT put_DefaultSubChannelTypes(int lDefaultVideoType, int lDefaultAudioType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ibpcsatellitetuner-istapingpermitted
    HRESULT IsTapingPermitted();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-iamtvaudio
@GUID("83ec1c30-23d1-11d1-99e6-00a0c9560266")
interface IAMTVAudio : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamtvaudio-gethardwaresupportedtvaudiomodes
    HRESULT GetHardwareSupportedTVAudioModes(int* plModes);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamtvaudio-getavailabletvaudiomodes
    HRESULT GetAvailableTVAudioModes(int* plModes);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamtvaudio-get_tvaudiomode
    HRESULT get_TVAudioMode(int* plMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamtvaudio-put_tvaudiomode
    HRESULT put_TVAudioMode(int lMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamtvaudio-registernotificationcallback
    HRESULT RegisterNotificationCallBack(IAMTunerNotification pNotify, int lEvents);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamtvaudio-unregisternotificationcallback
    HRESULT UnRegisterNotificationCallBack(IAMTunerNotification pNotify);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-iamtvaudionotification
@GUID("83ec1c33-23d1-11d1-99e6-00a0c9560266")
interface IAMTVAudioNotification : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamtvaudionotification-onevent
    HRESULT OnEvent(AMTVAudioEventType Event);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-iamanalogvideoencoder
@GUID("c6e133b0-30ac-11d0-a18c-00a0c9118956")
interface IAMAnalogVideoEncoder : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamanalogvideoencoder-get_availabletvformats
    HRESULT get_AvailableTVFormats(int* lAnalogVideoStandard);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamanalogvideoencoder-put_tvformat
    HRESULT put_TVFormat(int lAnalogVideoStandard);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamanalogvideoencoder-get_tvformat
    HRESULT get_TVFormat(int* plAnalogVideoStandard);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamanalogvideoencoder-put_copyprotection
    HRESULT put_CopyProtection(int lVideoCopyProtection);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamanalogvideoencoder-get_copyprotection
    HRESULT get_CopyProtection(int* lVideoCopyProtection);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamanalogvideoencoder-put_ccenable
    HRESULT put_CCEnable(int lCCEnable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamanalogvideoencoder-get_ccenable
    HRESULT get_CCEnable(int* lCCEnable);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-imediapropertybag
@GUID("6025a880-c0d5-11d0-bd4e-00a0c911ce86")
interface IMediaPropertyBag : IPropertyBag
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-imediapropertybag-enumproperty
    HRESULT EnumProperty(uint iProperty, VARIANT* pvarPropertyName, VARIANT* pvarPropertyValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-ipersistmediapropertybag
@GUID("5738e040-b67f-11d0-bd4d-00a0c911ce86")
interface IPersistMediaPropertyBag : IPersist
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ipersistmediapropertybag-initnew
    HRESULT InitNew();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ipersistmediapropertybag-load
    HRESULT Load(IMediaPropertyBag pPropBag, IErrorLog pErrorLog);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ipersistmediapropertybag-save
    HRESULT Save(IMediaPropertyBag pPropBag, BOOL fClearDirty, BOOL fSaveAllProperties);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-iamphysicalpininfo
@GUID("f938c991-3029-11cf-8c44-00aa006b6814")
interface IAMPhysicalPinInfo : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamphysicalpininfo-getphysicaltype
    HRESULT GetPhysicalType(int* pType, PWSTR* ppszType);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-iamextdevice
@GUID("b5730a90-1a2c-11cf-8c23-00aa006b6814")
interface IAMExtDevice : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamextdevice-getcapability
    HRESULT GetCapability(int Capability, int* pValue, double* pdblValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamextdevice-get_externaldeviceid
    HRESULT get_ExternalDeviceID(PWSTR* ppszData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamextdevice-get_externaldeviceversion
    HRESULT get_ExternalDeviceVersion(PWSTR* ppszData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamextdevice-put_devicepower
    HRESULT put_DevicePower(int PowerMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamextdevice-get_devicepower
    HRESULT get_DevicePower(int* pPowerMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamextdevice-calibrate
    HRESULT Calibrate(size_t hEvent, int Mode, int* pStatus);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamextdevice-put_deviceport
    HRESULT put_DevicePort(int DevicePort);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamextdevice-get_deviceport
    HRESULT get_DevicePort(int* pDevicePort);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-iamexttransport
@GUID("a03cd5f0-3045-11cf-8c44-00aa006b6814")
interface IAMExtTransport : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamexttransport-getcapability
    HRESULT GetCapability(int Capability, int* pValue, double* pdblValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamexttransport-put_mediastate
    HRESULT put_MediaState(int State);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamexttransport-get_mediastate
    HRESULT get_MediaState(int* pState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamexttransport-put_localcontrol
    HRESULT put_LocalControl(int State);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamexttransport-get_localcontrol
    HRESULT get_LocalControl(int* pState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamexttransport-getstatus
    HRESULT GetStatus(int StatusItem, int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamexttransport-gettransportbasicparameters
    HRESULT GetTransportBasicParameters(int Param, int* pValue, PWSTR* ppszData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamexttransport-settransportbasicparameters
    HRESULT SetTransportBasicParameters(int Param, int Value, const(PWSTR) pszData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamexttransport-gettransportvideoparameters
    HRESULT GetTransportVideoParameters(int Param, int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamexttransport-settransportvideoparameters
    HRESULT SetTransportVideoParameters(int Param, int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamexttransport-gettransportaudioparameters
    HRESULT GetTransportAudioParameters(int Param, int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamexttransport-settransportaudioparameters
    HRESULT SetTransportAudioParameters(int Param, int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamexttransport-put_mode
    HRESULT put_Mode(int Mode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamexttransport-get_mode
    HRESULT get_Mode(int* pMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamexttransport-put_rate
    HRESULT put_Rate(double dblRate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamexttransport-get_rate
    HRESULT get_Rate(double* pdblRate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamexttransport-getchase
    HRESULT GetChase(int* pEnabled, int* pOffset, size_t* phEvent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamexttransport-setchase
    HRESULT SetChase(int Enable, int Offset, size_t hEvent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamexttransport-getbump
    HRESULT GetBump(int* pSpeed, int* pDuration);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamexttransport-setbump
    HRESULT SetBump(int Speed, int Duration);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamexttransport-get_anticlogcontrol
    HRESULT get_AntiClogControl(int* pEnabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamexttransport-put_anticlogcontrol
    HRESULT put_AntiClogControl(int Enable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamexttransport-geteditpropertyset
    HRESULT GetEditPropertySet(int EditID, int* pState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamexttransport-seteditpropertyset
    HRESULT SetEditPropertySet(int* pEditID, int State);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamexttransport-geteditproperty
    HRESULT GetEditProperty(int EditID, int Param, int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamexttransport-seteditproperty
    HRESULT SetEditProperty(int EditID, int Param, int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamexttransport-get_editstart
    HRESULT get_EditStart(int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamexttransport-put_editstart
    HRESULT put_EditStart(int Value);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-iamtimecodereader
@GUID("9b496ce1-811b-11cf-8c77-00aa006b6814")
interface IAMTimecodeReader : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamtimecodereader-gettcrmode
    HRESULT GetTCRMode(int Param, int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamtimecodereader-settcrmode
    HRESULT SetTCRMode(int Param, int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamtimecodereader-put_vitcline
    HRESULT put_VITCLine(int Line);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamtimecodereader-get_vitcline
    HRESULT get_VITCLine(int* pLine);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamtimecodereader-gettimecode
    HRESULT GetTimecode(TIMECODE_SAMPLE* pTimecodeSample);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-iamtimecodegenerator
@GUID("9b496ce0-811b-11cf-8c77-00aa006b6814")
interface IAMTimecodeGenerator : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamtimecodegenerator-gettcgmode
    HRESULT GetTCGMode(int Param, int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamtimecodegenerator-settcgmode
    HRESULT SetTCGMode(int Param, int Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamtimecodegenerator-put_vitcline
    HRESULT put_VITCLine(int Line);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamtimecodegenerator-get_vitcline
    HRESULT get_VITCLine(int* pLine);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamtimecodegenerator-settimecode
    HRESULT SetTimecode(TIMECODE_SAMPLE* pTimecodeSample);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamtimecodegenerator-gettimecode
    HRESULT GetTimecode(TIMECODE_SAMPLE* pTimecodeSample);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-iamtimecodedisplay
@GUID("9b496ce2-811b-11cf-8c77-00aa006b6814")
interface IAMTimecodeDisplay : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamtimecodedisplay-gettcdisplayenable
    HRESULT GetTCDisplayEnable(int* pState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamtimecodedisplay-settcdisplayenable
    HRESULT SetTCDisplayEnable(int State);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamtimecodedisplay-gettcdisplay
    HRESULT GetTCDisplay(int Param, int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamtimecodedisplay-settcdisplay
    HRESULT SetTCDisplay(int Param, int Value);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-iamdevmemoryallocator
@GUID("c6545bf0-e76b-11d0-bd52-00a0c911ce86")
interface IAMDevMemoryAllocator : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamdevmemoryallocator-getinfo
    HRESULT GetInfo(uint* pdwcbTotalFree, uint* pdwcbLargestFree, uint* pdwcbTotalMemory, uint* pdwcbMinimumChunk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamdevmemoryallocator-checkmemory
    HRESULT CheckMemory(const(ubyte)* pBuffer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamdevmemoryallocator-alloc
    HRESULT Alloc(ubyte** ppBuffer, uint* pdwcbBuffer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamdevmemoryallocator-free
    HRESULT Free(ubyte* pBuffer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamdevmemoryallocator-getdevmemoryobject
    HRESULT GetDevMemoryObject(IUnknown* ppUnkInnner, IUnknown pUnkOuter);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-iamdevmemorycontrol
@GUID("c6545bf1-e76b-11d0-bd52-00a0c911ce86")
interface IAMDevMemoryControl : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamdevmemorycontrol-querywritesync
    HRESULT QueryWriteSync();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamdevmemorycontrol-writesync
    HRESULT WriteSync();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamdevmemorycontrol-getdevid
    HRESULT GetDevId(uint* pdwDevId);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-iamstreamselect
@GUID("c1960960-17f5-11d1-abe1-00a0c905f375")
interface IAMStreamSelect : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamstreamselect-count
    HRESULT Count(uint* pcStreams);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamstreamselect-info
    HRESULT Info(int lIndex, AM_MEDIA_TYPE** ppmt, uint* pdwFlags, uint* plcid, uint* pdwGroup, PWSTR* ppszName, 
                 IUnknown* ppObject, IUnknown* ppUnk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamstreamselect-enable
    HRESULT Enable(int lIndex, uint dwFlags);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-iamresourcecontrol
@GUID("8389d2d0-77d7-11d1-abe6-00a0c905f375")
interface IAMResourceControl : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamresourcecontrol-reserve
    HRESULT Reserve(uint dwFlags, /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pvReserved);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-iamclockadjust
@GUID("4d5466b0-a49c-11d1-abe8-00a0c905f375")
interface IAMClockAdjust : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamclockadjust-setclockdelta
    HRESULT SetClockDelta(long rtDelta);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-iamfiltermiscflags
@GUID("2dd74950-a890-11d1-abe8-00a0c905f375")
interface IAMFilterMiscFlags : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamfiltermiscflags-getmiscflags
    uint GetMiscFlags();
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-idrawvideoimage
@GUID("48efb120-ab49-11d2-aed2-00a0c995e8d5")
interface IDrawVideoImage : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idrawvideoimage-drawvideoimagebegin
    HRESULT DrawVideoImageBegin();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idrawvideoimage-drawvideoimageend
    HRESULT DrawVideoImageEnd();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idrawvideoimage-drawvideoimagedraw
    HRESULT DrawVideoImageDraw(HDC hdc, RECT* lprcSrc, RECT* lprcDst);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-idecimatevideoimage
@GUID("2e5ea3e0-e924-11d2-b6da-00a0c995e8df")
interface IDecimateVideoImage : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idecimatevideoimage-setdecimationimagesize
    HRESULT SetDecimationImageSize(int lWidth, int lHeight);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idecimatevideoimage-resetdecimationimagesize
    HRESULT ResetDecimationImageSize();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-iamvideodecimationproperties
@GUID("60d32930-13da-11d3-9ec6-c4fcaef5c7be")
interface IAMVideoDecimationProperties : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamvideodecimationproperties-querydecimationusage
    HRESULT QueryDecimationUsage(DECIMATION_USAGE* lpUsage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamvideodecimationproperties-setdecimationusage
    HRESULT SetDecimationUsage(DECIMATION_USAGE Usage);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-ivideoframestep
@GUID("e46a9787-2b71-444d-a4b5-1fab7b708d6a")
interface IVideoFrameStep : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivideoframestep-step
    HRESULT Step(uint dwFrames, IUnknown pStepObject);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivideoframestep-canstep
    HRESULT CanStep(int bMultiple, IUnknown pStepObject);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivideoframestep-cancelstep
    HRESULT CancelStep();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-iamlatency
@GUID("62ea93ba-ec62-11d2-b770-00c04fb6bd3d")
interface IAMLatency : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamlatency-getlatency
    HRESULT GetLatency(long* prtLatency);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-iampushsource
@GUID("f185fe76-e64e-11d2-b76e-00c04fb6bd3d")
interface IAMPushSource : IAMLatency
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iampushsource-getpushsourceflags
    HRESULT GetPushSourceFlags(uint* pFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iampushsource-setpushsourceflags
    HRESULT SetPushSourceFlags(uint Flags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iampushsource-setstreamoffset
    HRESULT SetStreamOffset(long rtOffset);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iampushsource-getstreamoffset
    HRESULT GetStreamOffset(long* prtOffset);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iampushsource-getmaxstreamoffset
    HRESULT GetMaxStreamOffset(long* prtMaxOffset);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iampushsource-setmaxstreamoffset
    HRESULT SetMaxStreamOffset(long rtMaxOffset);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-iamdeviceremoval
@GUID("f90a6130-b658-11d2-ae49-0000f8754b99")
interface IAMDeviceRemoval : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamdeviceremoval-deviceinfo
    HRESULT DeviceInfo(GUID* pclsidInterfaceClass, PWSTR* pwszSymbolicLink);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamdeviceremoval-reassociate
    HRESULT Reassociate();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamdeviceremoval-disassociate
    HRESULT Disassociate();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-idvenc
@GUID("d18e17a0-aacb-11d0-afb0-00aa00b67a42")
interface IDVEnc : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvenc-get_iformatresolution
    HRESULT get_IFormatResolution(int* VideoFormat, int* DVFormat, int* Resolution, ubyte fDVInfo, DVINFO* sDVInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvenc-put_iformatresolution
    HRESULT put_IFormatResolution(int VideoFormat, int DVFormat, int Resolution, ubyte fDVInfo, DVINFO* sDVInfo);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-iipdvdec
@GUID("b8e8bd60-0bfe-11d0-af91-00aa00b67a42")
interface IIPDVDec : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iipdvdec-get_ipdisplay
    HRESULT get_IPDisplay(int* displayPix);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iipdvdec-put_ipdisplay
    HRESULT put_IPDisplay(int displayPix);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-idvrgb219
@GUID("58473a19-2bc8-4663-8012-25f81babddd1")
interface IDVRGB219 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvrgb219-setrgb219
    HRESULT SetRGB219(BOOL bState);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-idvsplitter
@GUID("92a3a302-da7c-4a1f-ba7e-1802bb5d2d02")
interface IDVSplitter : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvsplitter-discardalternatevideoframes
    HRESULT DiscardAlternateVideoFrames(int nDiscard);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-iamaudiorendererstats
@GUID("22320cb2-d41a-11d2-bf7c-d7cb9df0bf93")
interface IAMAudioRendererStats : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamaudiorendererstats-getstatparam
    HRESULT GetStatParam(uint dwParam, uint* pdwParam1, uint* pdwParam2);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-iamgraphstreams
@GUID("632105fa-072e-11d3-8af9-00c04fb6bd3d")
interface IAMGraphStreams : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamgraphstreams-findupstreaminterface
    HRESULT FindUpstreamInterface(IPin pPin, const(GUID)* riid, void** ppvInterface, uint dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamgraphstreams-syncusingstreamoffset
    HRESULT SyncUsingStreamOffset(BOOL bUseStreamOffset);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamgraphstreams-setmaxgraphlatency
    HRESULT SetMaxGraphLatency(long rtMaxGraphLatency);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-iamoverlayfx
@GUID("62fae250-7e65-4460-bfc9-6398b322073c")
interface IAMOverlayFX : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamoverlayfx-queryoverlayfxcaps
    HRESULT QueryOverlayFXCaps(uint* lpdwOverlayFXCaps);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamoverlayfx-setoverlayfx
    HRESULT SetOverlayFX(uint dwOverlayFX);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamoverlayfx-getoverlayfx
    HRESULT GetOverlayFX(uint* lpdwOverlayFX);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-iamopenprogress
@GUID("8e1c39a1-de53-11cf-aa63-0080c744528d")
interface IAMOpenProgress : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamopenprogress-queryprogress
    HRESULT QueryProgress(long* pllTotal, long* pllCurrent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamopenprogress-abortoperation
    HRESULT AbortOperation();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-impeg2demultiplexer
@GUID("436eee9c-264f-4242-90e1-4e330c107512")
interface IMpeg2Demultiplexer : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-impeg2demultiplexer-createoutputpin
    HRESULT CreateOutputPin(AM_MEDIA_TYPE* pMediaType, PWSTR pszPinName, IPin* ppIPin);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-impeg2demultiplexer-setoutputpinmediatype
    HRESULT SetOutputPinMediaType(PWSTR pszPinName, AM_MEDIA_TYPE* pMediaType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-impeg2demultiplexer-deleteoutputpin
    HRESULT DeleteOutputPin(PWSTR pszPinName);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-ienumstreamidmap
@GUID("945c1566-6202-46fc-96c7-d87f289c6534")
interface IEnumStreamIdMap : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ienumstreamidmap-next
    HRESULT Next(uint cRequest, STREAM_ID_MAP* pStreamIdMap, uint* pcReceived);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ienumstreamidmap-skip
    HRESULT Skip(uint cRecords);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ienumstreamidmap-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ienumstreamidmap-clone
    HRESULT Clone(IEnumStreamIdMap* ppIEnumStreamIdMap);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-impeg2streamidmap
@GUID("d0e04c47-25b8-4369-925a-362a01d95444")
interface IMPEG2StreamIdMap : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-impeg2streamidmap-mapstreamid
    HRESULT MapStreamId(uint ulStreamId, uint MediaSampleContent, uint ulSubstreamFilterValue, int iDataOffset);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-impeg2streamidmap-unmapstreamid
    HRESULT UnmapStreamId(uint culStreamId, uint* pulStreamId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-impeg2streamidmap-enumstreamidmap
    HRESULT EnumStreamIdMap(IEnumStreamIdMap* ppIEnumStreamIdMap);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-iregisterserviceprovider
@GUID("7b3a2f01-0751-48dd-b556-004785171c54")
interface IRegisterServiceProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iregisterserviceprovider-registerservice
    HRESULT RegisterService(const(GUID)* guidService, IUnknown pUnkObject);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-iamclockslave
@GUID("9fd52741-176d-4b36-8f51-ca8f933223be")
interface IAMClockSlave : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamclockslave-seterrortolerance
    HRESULT SetErrorTolerance(uint dwTolerance);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamclockslave-geterrortolerance
    HRESULT GetErrorTolerance(uint* pdwTolerance);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-iamgraphbuildercallback
@GUID("4995f511-9ddb-4f12-bd3b-f04611807b79")
interface IAMGraphBuilderCallback : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamgraphbuildercallback-selectedfilter
    HRESULT SelectedFilter(IMoniker pMon);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamgraphbuildercallback-createdfilter
    HRESULT CreatedFilter(IBaseFilter pFil);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-iamfiltergraphcallback
@GUID("56a868fd-0ad4-11ce-b0a3-0020af0ba770")
interface IAMFilterGraphCallback : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamfiltergraphcallback-unabletorender
    HRESULT UnableToRender(IPin pPin);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-igetcapabilitieskey
@GUID("a8809222-07bb-48ea-951c-33158100625b")
interface IGetCapabilitiesKey : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-igetcapabilitieskey-getcapabilitieskey
    HRESULT GetCapabilitiesKey(HKEY* pHKey);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-iencoderapi
@GUID("70423839-6acc-4b23-b079-21dbf08156a5")
interface IEncoderAPI : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iencoderapi-issupported
    HRESULT IsSupported(const(GUID)* Api);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iencoderapi-isavailable
    HRESULT IsAvailable(const(GUID)* Api);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iencoderapi-getparameterrange
    HRESULT GetParameterRange(const(GUID)* Api, VARIANT* ValueMin, VARIANT* ValueMax, VARIANT* SteppingDelta);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iencoderapi-getparametervalues
    HRESULT GetParameterValues(const(GUID)* Api, VARIANT** Values, uint* ValuesCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iencoderapi-getdefaultvalue
    HRESULT GetDefaultValue(const(GUID)* Api, VARIANT* Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iencoderapi-getvalue
    HRESULT GetValue(const(GUID)* Api, VARIANT* Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iencoderapi-setvalue
    HRESULT SetValue(const(GUID)* Api, VARIANT* Value);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-ivideoencoder
@GUID("02997c3b-8e1b-460e-9270-545e0de9563e")
interface IVideoEncoder : IEncoderAPI
{
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-iamdecodercaps
@GUID("c0dff467-d499-4986-972b-e1d9090fa941")
interface IAMDecoderCaps : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamdecodercaps-getdecodercaps
    HRESULT GetDecoderCaps(uint dwCapIndex, uint* lpdwCap);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-iamcertifiedoutputprotection
@GUID("6feded3e-0ff1-4901-a2f1-43f7012c8515")
interface IAMCertifiedOutputProtection : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamcertifiedoutputprotection-keyexchange
    HRESULT KeyExchange(GUID* pRandom, ubyte** VarLenCertGH, uint* pdwLengthCertGH);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamcertifiedoutputprotection-sessionsequencestart
    HRESULT SessionSequenceStart(AMCOPPSignature* pSig);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamcertifiedoutputprotection-protectioncommand
    HRESULT ProtectionCommand(const(AMCOPPCommand)* cmd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamcertifiedoutputprotection-protectionstatus
    HRESULT ProtectionStatus(const(AMCOPPStatusInput)* pStatusInput, AMCOPPStatusOutput* pStatusOutput);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-iamasyncreadertimestampscaling
@GUID("cf7b26fc-9a00-485b-8147-3e789d5e8f67")
interface IAMAsyncReaderTimestampScaling : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamasyncreadertimestampscaling-gettimestampmode
    HRESULT GetTimestampMode(BOOL* pfRaw);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamasyncreadertimestampscaling-settimestampmode
    HRESULT SetTimestampMode(BOOL fRaw);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-iamplugincontrol
@GUID("0e26a181-f40c-4635-8786-976284b52981")
interface IAMPluginControl : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamplugincontrol-getpreferredclsid
    HRESULT GetPreferredClsid(const(GUID)* subType, GUID* clsid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamplugincontrol-getpreferredclsidbyindex
    HRESULT GetPreferredClsidByIndex(uint index, GUID* subType, GUID* clsid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamplugincontrol-setpreferredclsid
    HRESULT SetPreferredClsid(const(GUID)* subType, const(GUID)* clsid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamplugincontrol-isdisabled
    HRESULT IsDisabled(const(GUID)* clsid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamplugincontrol-getdisabledbyindex
    HRESULT GetDisabledByIndex(uint index, GUID* clsid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamplugincontrol-setdisabled
    HRESULT SetDisabled(const(GUID)* clsid, BOOL disabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iamplugincontrol-islegacydisabled
    HRESULT IsLegacyDisabled(const(PWSTR) dllName);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-ipinconnection
@GUID("4a9a62d3-27d4-403d-91e9-89f540e55534")
interface IPinConnection : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ipinconnection-dynamicqueryaccept
    HRESULT DynamicQueryAccept(const(AM_MEDIA_TYPE)* pmt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ipinconnection-notifyendofstream
    HRESULT NotifyEndOfStream(HANDLE hNotifyEvent);
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
    HRESULT IsEndPin();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ipinconnection-dynamicdisconnect
    HRESULT DynamicDisconnect();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-ipinflowcontrol
@GUID("c56e9858-dbf3-4f6b-8119-384af2060deb")
interface IPinFlowControl : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ipinflowcontrol-block
    HRESULT Block(uint dwBlockFlags, HANDLE hEvent);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-igraphconfig
@GUID("03a1eb8e-32bf-4245-8502-114d08a9cb88")
interface IGraphConfig : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-igraphconfig-reconnect
    HRESULT Reconnect(IPin pOutputPin, IPin pInputPin, const(AM_MEDIA_TYPE)* pmtFirstConnection, 
                      IBaseFilter pUsingFilter, HANDLE hAbortEvent, uint dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-igraphconfig-reconfigure
    HRESULT Reconfigure(IGraphConfigCallback pCallback, void* pvContext, uint dwFlags, HANDLE hAbortEvent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-igraphconfig-addfiltertocache
    HRESULT AddFilterToCache(IBaseFilter pFilter);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-igraphconfig-enumcachefilter
    HRESULT EnumCacheFilter(IEnumFilters* pEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-igraphconfig-removefilterfromcache
    HRESULT RemoveFilterFromCache(IBaseFilter pFilter);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-igraphconfig-getstarttime
    HRESULT GetStartTime(long* prtStart);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-igraphconfig-pushthroughdata
    HRESULT PushThroughData(IPin pOutputPin, IPinConnection pConnection, HANDLE hEventAbort);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-igraphconfig-setfilterflags
    HRESULT SetFilterFlags(IBaseFilter pFilter, uint dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-igraphconfig-getfilterflags
    HRESULT GetFilterFlags(IBaseFilter pFilter, uint* pdwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-igraphconfig-removefilterex
    HRESULT RemoveFilterEx(IBaseFilter pFilter, uint Flags);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-igraphconfigcallback
@GUID("ade0fd60-d19d-11d2-abf6-00a0c905f375")
interface IGraphConfigCallback : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-igraphconfigcallback-reconfigure
    HRESULT Reconfigure(void* pvContext, uint dwFlags);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-ifilterchain
@GUID("dcfbdcf6-0dc2-45f5-9ab2-7c330ea09c29")
interface IFilterChain : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ifilterchain-startchain
    HRESULT StartChain(IBaseFilter pStartFilter, IBaseFilter pEndFilter);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ifilterchain-pausechain
    HRESULT PauseChain(IBaseFilter pStartFilter, IBaseFilter pEndFilter);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ifilterchain-stopchain
    HRESULT StopChain(IBaseFilter pStartFilter, IBaseFilter pEndFilter);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ifilterchain-removechain
    HRESULT RemoveChain(IBaseFilter pStartFilter, IBaseFilter pEndFilter);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-ivmrimagepresenter
@GUID("ce704fe7-e71e-41fb-baa2-c4403e1182f5")
interface IVMRImagePresenter : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrimagepresenter-startpresenting
    HRESULT StartPresenting(size_t dwUserID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrimagepresenter-stoppresenting
    HRESULT StopPresenting(size_t dwUserID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrimagepresenter-presentimage
    HRESULT PresentImage(size_t dwUserID, VMRPRESENTATIONINFO* lpPresInfo);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-ivmrsurfaceallocator
@GUID("31ce832e-4484-458b-8cca-f4d7e3db0b52")
interface IVMRSurfaceAllocator : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrsurfaceallocator-allocatesurface
    HRESULT AllocateSurface(size_t dwUserID, VMRALLOCATIONINFO* lpAllocInfo, uint* lpdwActualBuffers, 
                            IDirectDrawSurface7* lplpSurface);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrsurfaceallocator-freesurface
    HRESULT FreeSurface(size_t dwID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrsurfaceallocator-preparesurface
    HRESULT PrepareSurface(size_t dwUserID, IDirectDrawSurface7 lpSurface, uint dwSurfaceFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrsurfaceallocator-advisenotify
    HRESULT AdviseNotify(IVMRSurfaceAllocatorNotify lpIVMRSurfAllocNotify);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-ivmrsurfaceallocatornotify
@GUID("aada05a8-5a4e-4729-af0b-cea27aed51e2")
interface IVMRSurfaceAllocatorNotify : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrsurfaceallocatornotify-advisesurfaceallocator
    HRESULT AdviseSurfaceAllocator(size_t dwUserID, IVMRSurfaceAllocator lpIVRMSurfaceAllocator);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrsurfaceallocatornotify-setddrawdevice
    HRESULT SetDDrawDevice(IDirectDraw7 lpDDrawDevice, HMONITOR hMonitor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrsurfaceallocatornotify-changeddrawdevice
    HRESULT ChangeDDrawDevice(IDirectDraw7 lpDDrawDevice, HMONITOR hMonitor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrsurfaceallocatornotify-restoreddrawsurfaces
    HRESULT RestoreDDrawSurfaces();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrsurfaceallocatornotify-notifyevent
    HRESULT NotifyEvent(int EventCode, ptrdiff_t Param1, ptrdiff_t Param2);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrsurfaceallocatornotify-setbordercolor
    HRESULT SetBorderColor(COLORREF clrBorder);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-ivmrwindowlesscontrol
@GUID("0eb1088c-4dcd-46f0-878f-39dae86a51b7")
interface IVMRWindowlessControl : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrwindowlesscontrol-getnativevideosize
    HRESULT GetNativeVideoSize(int* lpWidth, int* lpHeight, int* lpARWidth, int* lpARHeight);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrwindowlesscontrol-getminidealvideosize
    HRESULT GetMinIdealVideoSize(int* lpWidth, int* lpHeight);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrwindowlesscontrol-getmaxidealvideosize
    HRESULT GetMaxIdealVideoSize(int* lpWidth, int* lpHeight);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrwindowlesscontrol-setvideoposition
    HRESULT SetVideoPosition(const(RECT)* lpSRCRect, const(RECT)* lpDSTRect);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrwindowlesscontrol-getvideoposition
    HRESULT GetVideoPosition(RECT* lpSRCRect, RECT* lpDSTRect);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrwindowlesscontrol-getaspectratiomode
    HRESULT GetAspectRatioMode(uint* lpAspectRatioMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrwindowlesscontrol-setaspectratiomode
    HRESULT SetAspectRatioMode(uint AspectRatioMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrwindowlesscontrol-setvideoclippingwindow
    HRESULT SetVideoClippingWindow(HWND hwnd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrwindowlesscontrol-repaintvideo
    HRESULT RepaintVideo(HWND hwnd, HDC hdc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrwindowlesscontrol-displaymodechanged
    HRESULT DisplayModeChanged();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrwindowlesscontrol-getcurrentimage
    HRESULT GetCurrentImage(ubyte** lpDib);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrwindowlesscontrol-setbordercolor
    HRESULT SetBorderColor(COLORREF Clr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrwindowlesscontrol-getbordercolor
    HRESULT GetBorderColor(COLORREF* lpClr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrwindowlesscontrol-setcolorkey
    HRESULT SetColorKey(COLORREF Clr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrwindowlesscontrol-getcolorkey
    HRESULT GetColorKey(COLORREF* lpClr);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-ivmrmixercontrol
@GUID("1c1a17b0-bed0-415d-974b-dc6696131599")
interface IVMRMixerControl : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrmixercontrol-setalpha
    HRESULT SetAlpha(uint dwStreamID, float Alpha);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrmixercontrol-getalpha
    HRESULT GetAlpha(uint dwStreamID, float* pAlpha);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrmixercontrol-setzorder
    HRESULT SetZOrder(uint dwStreamID, uint dwZ);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrmixercontrol-getzorder
    HRESULT GetZOrder(uint dwStreamID, uint* pZ);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrmixercontrol-setoutputrect
    HRESULT SetOutputRect(uint dwStreamID, const(NORMALIZEDRECT)* pRect);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrmixercontrol-getoutputrect
    HRESULT GetOutputRect(uint dwStreamID, NORMALIZEDRECT* pRect);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrmixercontrol-setbackgroundclr
    HRESULT SetBackgroundClr(COLORREF ClrBkg);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrmixercontrol-getbackgroundclr
    HRESULT GetBackgroundClr(COLORREF* lpClrBkg);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrmixercontrol-setmixingprefs
    HRESULT SetMixingPrefs(uint dwMixerPrefs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrmixercontrol-getmixingprefs
    HRESULT GetMixingPrefs(uint* pdwMixerPrefs);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-ivmrmonitorconfig
@GUID("9cf0b1b6-fbaa-4b7f-88cf-cf1f130a0dce")
interface IVMRMonitorConfig : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrmonitorconfig-setmonitor
    HRESULT SetMonitor(const(VMRGUID)* pGUID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrmonitorconfig-getmonitor
    HRESULT GetMonitor(VMRGUID* pGUID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrmonitorconfig-setdefaultmonitor
    HRESULT SetDefaultMonitor(const(VMRGUID)* pGUID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrmonitorconfig-getdefaultmonitor
    HRESULT GetDefaultMonitor(VMRGUID* pGUID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrmonitorconfig-getavailablemonitors
    HRESULT GetAvailableMonitors(VMRMONITORINFO* pInfo, uint dwMaxInfoArraySize, uint* pdwNumDevices);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-ivmrfilterconfig
@GUID("9e5530c5-7034-48b4-bb46-0b8a6efc8e36")
interface IVMRFilterConfig : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrfilterconfig-setimagecompositor
    HRESULT SetImageCompositor(IVMRImageCompositor lpVMRImgCompositor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrfilterconfig-setnumberofstreams
    HRESULT SetNumberOfStreams(uint dwMaxStreams);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrfilterconfig-getnumberofstreams
    HRESULT GetNumberOfStreams(uint* pdwMaxStreams);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrfilterconfig-setrenderingprefs
    HRESULT SetRenderingPrefs(uint dwRenderFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrfilterconfig-getrenderingprefs
    HRESULT GetRenderingPrefs(uint* pdwRenderFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrfilterconfig-setrenderingmode
    HRESULT SetRenderingMode(uint Mode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrfilterconfig-getrenderingmode
    HRESULT GetRenderingMode(uint* pMode);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-ivmraspectratiocontrol
@GUID("ede80b5c-bad6-4623-b537-65586c9f8dfd")
interface IVMRAspectRatioControl : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmraspectratiocontrol-getaspectratiomode
    HRESULT GetAspectRatioMode(uint* lpdwARMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmraspectratiocontrol-setaspectratiomode
    HRESULT SetAspectRatioMode(uint dwARMode);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-ivmrdeinterlacecontrol
@GUID("bb057577-0db8-4e6a-87a7-1a8c9a505a0f")
interface IVMRDeinterlaceControl : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrdeinterlacecontrol-getnumberofdeinterlacemodes
    HRESULT GetNumberOfDeinterlaceModes(VMRVideoDesc* lpVideoDescription, uint* lpdwNumDeinterlaceModes, 
                                        GUID* lpDeinterlaceModes);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrdeinterlacecontrol-getdeinterlacemodecaps
    HRESULT GetDeinterlaceModeCaps(GUID* lpDeinterlaceMode, VMRVideoDesc* lpVideoDescription, 
                                   VMRDeinterlaceCaps* lpDeinterlaceCaps);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrdeinterlacecontrol-getdeinterlacemode
    HRESULT GetDeinterlaceMode(uint dwStreamID, GUID* lpDeinterlaceMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrdeinterlacecontrol-setdeinterlacemode
    HRESULT SetDeinterlaceMode(uint dwStreamID, GUID* lpDeinterlaceMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrdeinterlacecontrol-getdeinterlaceprefs
    HRESULT GetDeinterlacePrefs(uint* lpdwDeinterlacePrefs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrdeinterlacecontrol-setdeinterlaceprefs
    HRESULT SetDeinterlacePrefs(uint dwDeinterlacePrefs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrdeinterlacecontrol-getactualdeinterlacemode
    HRESULT GetActualDeinterlaceMode(uint dwStreamID, GUID* lpDeinterlaceMode);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-ivmrmixerbitmap
@GUID("1e673275-0257-40aa-af20-7c608d4a0428")
interface IVMRMixerBitmap : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrmixerbitmap-setalphabitmap
    HRESULT SetAlphaBitmap(const(VMRALPHABITMAP)* pBmpParms);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrmixerbitmap-updatealphabitmapparameters
    HRESULT UpdateAlphaBitmapParameters(VMRALPHABITMAP* pBmpParms);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrmixerbitmap-getalphabitmapparameters
    HRESULT GetAlphaBitmapParameters(VMRALPHABITMAP* pBmpParms);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-ivmrimagecompositor
@GUID("7a4fb5af-479f-4074-bb40-ce6722e43c82")
interface IVMRImageCompositor : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrimagecompositor-initcompositiontarget
    HRESULT InitCompositionTarget(IUnknown pD3DDevice, IDirectDrawSurface7 pddsRenderTarget);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrimagecompositor-termcompositiontarget
    HRESULT TermCompositionTarget(IUnknown pD3DDevice, IDirectDrawSurface7 pddsRenderTarget);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrimagecompositor-setstreammediatype
    HRESULT SetStreamMediaType(uint dwStrmID, AM_MEDIA_TYPE* pmt, BOOL fTexture);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrimagecompositor-compositeimage
    HRESULT CompositeImage(IUnknown pD3DDevice, IDirectDrawSurface7 pddsRenderTarget, 
                           AM_MEDIA_TYPE* pmtRenderTarget, long rtStart, long rtEnd, uint dwClrBkGnd, 
                           VMRVIDEOSTREAMINFO* pVideoStreamInfo, uint cStreams);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-ivmrvideostreamcontrol
@GUID("058d1f11-2a54-4bef-bd54-df706626b727")
interface IVMRVideoStreamControl : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrvideostreamcontrol-setcolorkey
    HRESULT SetColorKey(DDCOLORKEY* lpClrKey);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrvideostreamcontrol-getcolorkey
    HRESULT GetColorKey(DDCOLORKEY* lpClrKey);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrvideostreamcontrol-setstreamactivestate
    HRESULT SetStreamActiveState(BOOL fActive);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrvideostreamcontrol-getstreamactivestate
    HRESULT GetStreamActiveState(BOOL* lpfActive);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-ivmrsurface
@GUID("a9849bbe-9ec8-4263-b764-62730f0d15d0")
interface IVMRSurface : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrsurface-issurfacelocked
    HRESULT IsSurfaceLocked();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrsurface-locksurface
    HRESULT LockSurface(ubyte** lpSurface);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrsurface-unlocksurface
    HRESULT UnlockSurface();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrsurface-getsurface
    HRESULT GetSurface(IDirectDrawSurface7* lplpSurface);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-ivmrimagepresenterconfig
@GUID("9f3a1c85-8555-49ba-935f-be5b5b29d178")
interface IVMRImagePresenterConfig : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrimagepresenterconfig-setrenderingprefs
    HRESULT SetRenderingPrefs(uint dwRenderFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrimagepresenterconfig-getrenderingprefs
    HRESULT GetRenderingPrefs(uint* dwRenderFlags);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-ivmrimagepresenterexclmodeconfig
@GUID("e6f7ce40-4673-44f1-8f77-5499d68cb4ea")
interface IVMRImagePresenterExclModeConfig : IVMRImagePresenterConfig
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrimagepresenterexclmodeconfig-setxlcmodeddobjandprimarysurface
    HRESULT SetXlcModeDDObjAndPrimarySurface(IDirectDraw7 lpDDObj, IDirectDrawSurface7 lpPrimarySurf);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivmrimagepresenterexclmodeconfig-getxlcmodeddobjandprimarysurface
    HRESULT GetXlcModeDDObjAndPrimarySurface(IDirectDraw7* lpDDObj, IDirectDrawSurface7* lpPrimarySurf);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-ivpmanager
@GUID("aac18c18-e186-46d2-825d-a1f8dc8e395a")
interface IVPManager : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivpmanager-setvideoportindex
    HRESULT SetVideoPortIndex(uint dwVideoPortIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-ivpmanager-getvideoportindex
    HRESULT GetVideoPortIndex(uint* pdwVideoPortIndex);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-idvdcontrol
@GUID("a70efe61-e2a3-11d0-a9be-00aa0061be93")
interface IDvdControl : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol-titleplay
    HRESULT TitlePlay(uint ulTitle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol-chapterplay
    HRESULT ChapterPlay(uint ulTitle, uint ulChapter);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol-timeplay
    HRESULT TimePlay(uint ulTitle, uint bcdTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol-stopforresume
    HRESULT StopForResume();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol-goup
    HRESULT GoUp();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol-timesearch
    HRESULT TimeSearch(uint bcdTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol-chaptersearch
    HRESULT ChapterSearch(uint ulChapter);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol-prevpgsearch
    HRESULT PrevPGSearch();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol-toppgsearch
    HRESULT TopPGSearch();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol-nextpgsearch
    HRESULT NextPGSearch();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol-forwardscan
    HRESULT ForwardScan(double dwSpeed);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol-backwardscan
    HRESULT BackwardScan(double dwSpeed);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol-menucall
    HRESULT MenuCall(DVD_MENU_ID MenuID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol-resume
    HRESULT Resume();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol-upperbuttonselect
    HRESULT UpperButtonSelect();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol-lowerbuttonselect
    HRESULT LowerButtonSelect();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol-leftbuttonselect
    HRESULT LeftButtonSelect();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol-rightbuttonselect
    HRESULT RightButtonSelect();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol-buttonactivate
    HRESULT ButtonActivate();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol-buttonselectandactivate
    HRESULT ButtonSelectAndActivate(uint ulButton);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol-stilloff
    HRESULT StillOff();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol-pauseon
    HRESULT PauseOn();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol-pauseoff
    HRESULT PauseOff();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol-menulanguageselect
    HRESULT MenuLanguageSelect(uint Language);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol-audiostreamchange
    HRESULT AudioStreamChange(uint ulAudio);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol-subpicturestreamchange
    HRESULT SubpictureStreamChange(uint ulSubPicture, BOOL bDisplay);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol-anglechange
    HRESULT AngleChange(uint ulAngle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol-parentallevelselect
    HRESULT ParentalLevelSelect(uint ulParentalLevel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol-parentalcountryselect
    HRESULT ParentalCountrySelect(ushort wCountry);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol-karaokeaudiopresentationmodechange
    HRESULT KaraokeAudioPresentationModeChange(uint ulMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol-videomodepreferrence
    HRESULT VideoModePreferrence(uint ulPreferredDisplayMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol-setroot
    HRESULT SetRoot(const(PWSTR) pszPath);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol-mouseactivate
    HRESULT MouseActivate(POINT point);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol-mouseselect
    HRESULT MouseSelect(POINT point);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol-chapterplayautostop
    HRESULT ChapterPlayAutoStop(uint ulTitle, uint ulChapter, uint ulChaptersToPlay);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-idvdinfo
@GUID("a70efe60-e2a3-11d0-a9be-00aa0061be93")
interface IDvdInfo : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdinfo-getcurrentdomain
    HRESULT GetCurrentDomain(DVD_DOMAIN* pDomain);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdinfo-getcurrentlocation
    HRESULT GetCurrentLocation(DVD_PLAYBACK_LOCATION* pLocation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdinfo-gettotaltitletime
    HRESULT GetTotalTitleTime(uint* pulTotalTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdinfo-getcurrentbutton
    HRESULT GetCurrentButton(uint* pulButtonsAvailable, uint* pulCurrentButton);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdinfo-getcurrentangle
    HRESULT GetCurrentAngle(uint* pulAnglesAvailable, uint* pulCurrentAngle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdinfo-getcurrentaudio
    HRESULT GetCurrentAudio(uint* pulStreamsAvailable, uint* pulCurrentStream);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdinfo-getcurrentsubpicture
    HRESULT GetCurrentSubpicture(uint* pulStreamsAvailable, uint* pulCurrentStream, BOOL* pIsDisabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdinfo-getcurrentuops
    HRESULT GetCurrentUOPS(uint* pUOP);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdinfo-getallsprms
    HRESULT GetAllSPRMs(ushort** pRegisterArray);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdinfo-getallgprms
    HRESULT GetAllGPRMs(ushort** pRegisterArray);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdinfo-getaudiolanguage
    HRESULT GetAudioLanguage(uint ulStream, uint* pLanguage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdinfo-getsubpicturelanguage
    HRESULT GetSubpictureLanguage(uint ulStream, uint* pLanguage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdinfo-gettitleattributes
    HRESULT GetTitleAttributes(uint ulTitle, DVD_ATR* pATR);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdinfo-getvmgattributes
    HRESULT GetVMGAttributes(DVD_ATR* pATR);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdinfo-getcurrentvideoattributes
    HRESULT GetCurrentVideoAttributes(ubyte** pATR);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdinfo-getcurrentaudioattributes
    HRESULT GetCurrentAudioAttributes(ubyte** pATR);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdinfo-getcurrentsubpictureattributes
    HRESULT GetCurrentSubpictureAttributes(ubyte** pATR);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdinfo-getcurrentvolumeinfo
    HRESULT GetCurrentVolumeInfo(uint* pulNumOfVol, uint* pulThisVolNum, DVD_DISC_SIDE* pSide, 
                                 uint* pulNumOfTitles);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdinfo-getdvdtextinfo
    HRESULT GetDVDTextInfo(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/ubyte* pTextManager, 
                           uint ulBufSize, uint* pulActualSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdinfo-getplayerparentallevel
    HRESULT GetPlayerParentalLevel(uint* pulParentalLevel, uint* pulCountryCode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdinfo-getnumberofchapters
    HRESULT GetNumberOfChapters(uint ulTitle, uint* pulNumberOfChapters);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdinfo-gettitleparentallevels
    HRESULT GetTitleParentalLevels(uint ulTitle, uint* pulParentalLevels);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdinfo-getroot
    HRESULT GetRoot(PSTR pRoot, uint ulBufSize, uint* pulActualSize);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-idvdcmd
@GUID("5a4a97e4-94ee-4a55-9751-74b5643aa27d")
interface IDvdCmd : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcmd-waitforstart
    HRESULT WaitForStart();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcmd-waitforend
    HRESULT WaitForEnd();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-idvdstate
@GUID("86303d6d-1c4a-4087-ab42-f711167048ef")
interface IDvdState : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdstate-getdiscid
    HRESULT GetDiscID(ulong* pullUniqueID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdstate-getparentallevel
    HRESULT GetParentalLevel(uint* pulParentalLevel);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-idvdcontrol2
@GUID("33bc7430-eec0-11d2-8201-00a0c9d74842")
interface IDvdControl2 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol2-playtitle
    HRESULT PlayTitle(uint ulTitle, uint dwFlags, IDvdCmd* ppCmd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol2-playchapterintitle
    HRESULT PlayChapterInTitle(uint ulTitle, uint ulChapter, uint dwFlags, IDvdCmd* ppCmd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol2-playattimeintitle
    HRESULT PlayAtTimeInTitle(uint ulTitle, DVD_HMSF_TIMECODE* pStartTime, uint dwFlags, IDvdCmd* ppCmd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol2-stop
    HRESULT Stop();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol2-returnfromsubmenu
    HRESULT ReturnFromSubmenu(uint dwFlags, IDvdCmd* ppCmd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol2-playattime
    HRESULT PlayAtTime(DVD_HMSF_TIMECODE* pTime, uint dwFlags, IDvdCmd* ppCmd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol2-playchapter
    HRESULT PlayChapter(uint ulChapter, uint dwFlags, IDvdCmd* ppCmd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol2-playprevchapter
    HRESULT PlayPrevChapter(uint dwFlags, IDvdCmd* ppCmd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol2-replaychapter
    HRESULT ReplayChapter(uint dwFlags, IDvdCmd* ppCmd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol2-playnextchapter
    HRESULT PlayNextChapter(uint dwFlags, IDvdCmd* ppCmd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol2-playforwards
    HRESULT PlayForwards(double dSpeed, uint dwFlags, IDvdCmd* ppCmd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol2-playbackwards
    HRESULT PlayBackwards(double dSpeed, uint dwFlags, IDvdCmd* ppCmd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol2-showmenu
    HRESULT ShowMenu(DVD_MENU_ID MenuID, uint dwFlags, IDvdCmd* ppCmd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol2-resume
    HRESULT Resume(uint dwFlags, IDvdCmd* ppCmd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol2-selectrelativebutton
    HRESULT SelectRelativeButton(DVD_RELATIVE_BUTTON buttonDir);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol2-activatebutton
    HRESULT ActivateButton();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol2-selectbutton
    HRESULT SelectButton(uint ulButton);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol2-selectandactivatebutton
    HRESULT SelectAndActivateButton(uint ulButton);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol2-stilloff
    HRESULT StillOff();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol2-pause
    HRESULT Pause(BOOL bState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol2-selectaudiostream
    HRESULT SelectAudioStream(uint ulAudio, uint dwFlags, IDvdCmd* ppCmd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol2-selectsubpicturestream
    HRESULT SelectSubpictureStream(uint ulSubPicture, uint dwFlags, IDvdCmd* ppCmd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol2-setsubpicturestate
    HRESULT SetSubpictureState(BOOL bState, uint dwFlags, IDvdCmd* ppCmd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol2-selectangle
    HRESULT SelectAngle(uint ulAngle, uint dwFlags, IDvdCmd* ppCmd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol2-selectparentallevel
    HRESULT SelectParentalLevel(uint ulParentalLevel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol2-selectparentalcountry
    HRESULT SelectParentalCountry(ubyte* bCountry);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol2-selectkaraokeaudiopresentationmode
    HRESULT SelectKaraokeAudioPresentationMode(uint ulMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol2-selectvideomodepreference
    HRESULT SelectVideoModePreference(uint ulPreferredDisplayMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol2-setdvddirectory
    HRESULT SetDVDDirectory(const(PWSTR) pszwPath);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol2-activateatposition
    HRESULT ActivateAtPosition(POINT point);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol2-selectatposition
    HRESULT SelectAtPosition(POINT point);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol2-playchaptersautostop
    HRESULT PlayChaptersAutoStop(uint ulTitle, uint ulChapter, uint ulChaptersToPlay, uint dwFlags, IDvdCmd* ppCmd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol2-acceptparentallevelchange
    HRESULT AcceptParentalLevelChange(BOOL bAccept);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol2-setoption
    HRESULT SetOption(DVD_OPTION_FLAG flag, BOOL fState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol2-setstate
    HRESULT SetState(IDvdState pState, uint dwFlags, IDvdCmd* ppCmd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol2-playperiodintitleautostop
    HRESULT PlayPeriodInTitleAutoStop(uint ulTitle, DVD_HMSF_TIMECODE* pStartTime, DVD_HMSF_TIMECODE* pEndTime, 
                                      uint dwFlags, IDvdCmd* ppCmd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol2-setgprm
    HRESULT SetGPRM(uint ulIndex, ushort wValue, uint dwFlags, IDvdCmd* ppCmd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol2-selectdefaultmenulanguage
    HRESULT SelectDefaultMenuLanguage(uint Language);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol2-selectdefaultaudiolanguage
    HRESULT SelectDefaultAudioLanguage(uint Language, DVD_AUDIO_LANG_EXT audioExtension);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdcontrol2-selectdefaultsubpicturelanguage
    HRESULT SelectDefaultSubpictureLanguage(uint Language, DVD_SUBPICTURE_LANG_EXT subpictureExtension);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-idvdinfo2
@GUID("34151510-eec0-11d2-8201-00a0c9d74842")
interface IDvdInfo2 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdinfo2-getcurrentdomain
    HRESULT GetCurrentDomain(DVD_DOMAIN* pDomain);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdinfo2-getcurrentlocation
    HRESULT GetCurrentLocation(DVD_PLAYBACK_LOCATION2* pLocation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdinfo2-gettotaltitletime
    HRESULT GetTotalTitleTime(DVD_HMSF_TIMECODE* pTotalTime, uint* ulTimeCodeFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdinfo2-getcurrentbutton
    HRESULT GetCurrentButton(uint* pulButtonsAvailable, uint* pulCurrentButton);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdinfo2-getcurrentangle
    HRESULT GetCurrentAngle(uint* pulAnglesAvailable, uint* pulCurrentAngle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdinfo2-getcurrentaudio
    HRESULT GetCurrentAudio(uint* pulStreamsAvailable, uint* pulCurrentStream);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdinfo2-getcurrentsubpicture
    HRESULT GetCurrentSubpicture(uint* pulStreamsAvailable, uint* pulCurrentStream, BOOL* pbIsDisabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdinfo2-getcurrentuops
    HRESULT GetCurrentUOPS(uint* pulUOPs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdinfo2-getallsprms
    HRESULT GetAllSPRMs(ushort** pRegisterArray);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdinfo2-getallgprms
    HRESULT GetAllGPRMs(ushort** pRegisterArray);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdinfo2-getaudiolanguage
    HRESULT GetAudioLanguage(uint ulStream, uint* pLanguage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdinfo2-getsubpicturelanguage
    HRESULT GetSubpictureLanguage(uint ulStream, uint* pLanguage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdinfo2-gettitleattributes
    HRESULT GetTitleAttributes(uint ulTitle, DVD_MenuAttributes* pMenu, DVD_TitleAttributes* pTitle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdinfo2-getvmgattributes
    HRESULT GetVMGAttributes(DVD_MenuAttributes* pATR);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdinfo2-getcurrentvideoattributes
    HRESULT GetCurrentVideoAttributes(DVD_VideoAttributes* pATR);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdinfo2-getaudioattributes
    HRESULT GetAudioAttributes(uint ulStream, DVD_AudioAttributes* pATR);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdinfo2-getkaraokeattributes
    HRESULT GetKaraokeAttributes(uint ulStream, DVD_KaraokeAttributes* pAttributes);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdinfo2-getsubpictureattributes
    HRESULT GetSubpictureAttributes(uint ulStream, DVD_SubpictureAttributes* pATR);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdinfo2-getdvdvolumeinfo
    HRESULT GetDVDVolumeInfo(uint* pulNumOfVolumes, uint* pulVolume, DVD_DISC_SIDE* pSide, uint* pulNumOfTitles);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdinfo2-getdvdtextnumberoflanguages
    HRESULT GetDVDTextNumberOfLanguages(uint* pulNumOfLangs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdinfo2-getdvdtextlanguageinfo
    HRESULT GetDVDTextLanguageInfo(uint ulLangIndex, uint* pulNumOfStrings, uint* pLangCode, 
                                   DVD_TextCharSet* pbCharacterSet);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdinfo2-getdvdtextstringasnative
    HRESULT GetDVDTextStringAsNative(uint ulLangIndex, uint ulStringIndex, ubyte* pbBuffer, uint ulMaxBufferSize, 
                                     uint* pulActualSize, DVD_TextStringType* pType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdinfo2-getdvdtextstringasunicode
    HRESULT GetDVDTextStringAsUnicode(uint ulLangIndex, uint ulStringIndex, PWSTR pchwBuffer, uint ulMaxBufferSize, 
                                      uint* pulActualSize, DVD_TextStringType* pType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdinfo2-getplayerparentallevel
    HRESULT GetPlayerParentalLevel(uint* pulParentalLevel, ubyte* pbCountryCode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdinfo2-getnumberofchapters
    HRESULT GetNumberOfChapters(uint ulTitle, uint* pulNumOfChapters);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdinfo2-gettitleparentallevels
    HRESULT GetTitleParentalLevels(uint ulTitle, uint* pulParentalLevels);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdinfo2-getdvddirectory
    HRESULT GetDVDDirectory(PWSTR pszwPath, uint ulMaxSize, uint* pulActualSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdinfo2-isaudiostreamenabled
    HRESULT IsAudioStreamEnabled(uint ulStreamNum, BOOL* pbEnabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdinfo2-getdiscid
    HRESULT GetDiscID(const(PWSTR) pszwPath, ulong* pullDiscID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdinfo2-getstate
    HRESULT GetState(IDvdState* pStateData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdinfo2-getmenulanguages
    HRESULT GetMenuLanguages(uint* pLanguages, uint ulMaxLanguages, uint* pulActualLanguages);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdinfo2-getbuttonatposition
    HRESULT GetButtonAtPosition(POINT point, uint* pulButtonIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdinfo2-getcmdfromevent
    HRESULT GetCmdFromEvent(ptrdiff_t lParam1, IDvdCmd* pCmdObj);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdinfo2-getdefaultmenulanguage
    HRESULT GetDefaultMenuLanguage(uint* pLanguage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdinfo2-getdefaultaudiolanguage
    HRESULT GetDefaultAudioLanguage(uint* pLanguage, DVD_AUDIO_LANG_EXT* pAudioExtension);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdinfo2-getdefaultsubpicturelanguage
    HRESULT GetDefaultSubpictureLanguage(uint* pLanguage, DVD_SUBPICTURE_LANG_EXT* pSubpictureExtension);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdinfo2-getdecodercaps
    HRESULT GetDecoderCaps(DVD_DECODER_CAPS* pCaps);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdinfo2-getbuttonrect
    HRESULT GetButtonRect(uint ulButton, RECT* pRect);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdinfo2-issubpicturestreamenabled
    HRESULT IsSubpictureStreamEnabled(uint ulStreamNum, BOOL* pbEnabled);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-idvdgraphbuilder
@GUID("fcc152b6-f372-11d0-8e00-00c04fd7c08b")
interface IDvdGraphBuilder : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdgraphbuilder-getfiltergraph
    HRESULT GetFiltergraph(IGraphBuilder* ppGB);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdgraphbuilder-getdvdinterface
    HRESULT GetDvdInterface(const(GUID)* riid, void** ppvIF);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-idvdgraphbuilder-renderdvdvideovolume
    HRESULT RenderDvdVideoVolume(const(PWSTR) lpcwszPathName, uint dwFlags, AM_DVD_RENDERSTATUS* pStatus);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-iddrawexclmodevideo
@GUID("153acc21-d83b-11d1-82bf-00a0c9696c8f")
interface IDDrawExclModeVideo : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iddrawexclmodevideo-setddrawobject
    HRESULT SetDDrawObject(IDirectDraw pDDrawObject);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iddrawexclmodevideo-getddrawobject
    HRESULT GetDDrawObject(IDirectDraw* ppDDrawObject, BOOL* pbUsingExternal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iddrawexclmodevideo-setddrawsurface
    HRESULT SetDDrawSurface(IDirectDrawSurface pDDrawSurface);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iddrawexclmodevideo-getddrawsurface
    HRESULT GetDDrawSurface(IDirectDrawSurface* ppDDrawSurface, BOOL* pbUsingExternal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iddrawexclmodevideo-setdrawparameters
    HRESULT SetDrawParameters(const(RECT)* prcSource, const(RECT)* prcTarget);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iddrawexclmodevideo-getnativevideoprops
    HRESULT GetNativeVideoProps(uint* pdwVideoWidth, uint* pdwVideoHeight, uint* pdwPictAspectRatioX, 
                                uint* pdwPictAspectRatioY);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iddrawexclmodevideo-setcallbackinterface
    HRESULT SetCallbackInterface(IDDrawExclModeVideoCallback pCallback, uint dwFlags);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nn-strmif-iddrawexclmodevideocallback
@GUID("913c24a0-20ab-11d2-9038-00a0c9697298")
interface IDDrawExclModeVideoCallback : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iddrawexclmodevideocallback-onupdateoverlay
    HRESULT OnUpdateOverlay(BOOL bBefore, uint dwFlags, BOOL bOldVisible, const(RECT)* prcOldSrc, 
                            const(RECT)* prcOldDest, BOOL bNewVisible, const(RECT)* prcNewSrc, 
                            const(RECT)* prcNewDest);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iddrawexclmodevideocallback-onupdatecolorkey
    HRESULT OnUpdateColorKey(const(COLORKEY)* pKey, uint dwColor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/strmif/nf-strmif-iddrawexclmodevideocallback-onupdatesize
    HRESULT OnUpdateSize(uint dwWidth, uint dwHeight, uint dwARWidth, uint dwARHeight);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nn-bdaiface-ibda_networkprovider
@GUID("fd501041-8ebe-11ce-8183-00aa00577da2")
interface IBDA_NetworkProvider : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_networkprovider-putsignalsource
    HRESULT PutSignalSource(uint ulSignalSource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_networkprovider-getsignalsource
    HRESULT GetSignalSource(uint* pulSignalSource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_networkprovider-getnetworktype
    HRESULT GetNetworkType(GUID* pguidNetworkType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_networkprovider-puttuningspace
    HRESULT PutTuningSpace(const(GUID)* guidTuningSpace);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_networkprovider-gettuningspace
    HRESULT GetTuningSpace(GUID* pguidTuingSpace);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_networkprovider-registerdevicefilter
    HRESULT RegisterDeviceFilter(IUnknown pUnkFilterControl, uint* ppvRegisitrationContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_networkprovider-unregisterdevicefilter
    HRESULT UnRegisterDeviceFilter(uint pvRegistrationContext);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nn-bdaiface-ibda_ethernetfilter
@GUID("71985f43-1ca1-11d3-9cc8-00c04f7971e0")
interface IBDA_EthernetFilter : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_ethernetfilter-getmulticastlistsize
    HRESULT GetMulticastListSize(uint* pulcbAddresses);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_ethernetfilter-putmulticastlist
    HRESULT PutMulticastList(uint ulcbAddresses, ubyte* pAddressList);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_ethernetfilter-getmulticastlist
    HRESULT GetMulticastList(uint* pulcbAddresses, ubyte* pAddressList);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_ethernetfilter-putmulticastmode
    HRESULT PutMulticastMode(uint ulModeMask);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_ethernetfilter-getmulticastmode
    HRESULT GetMulticastMode(uint* pulModeMask);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nn-bdaiface-ibda_ipv4filter
@GUID("71985f44-1ca1-11d3-9cc8-00c04f7971e0")
interface IBDA_IPV4Filter : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_ipv4filter-getmulticastlistsize
    HRESULT GetMulticastListSize(uint* pulcbAddresses);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_ipv4filter-putmulticastlist
    HRESULT PutMulticastList(uint ulcbAddresses, ubyte* pAddressList);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_ipv4filter-getmulticastlist
    HRESULT GetMulticastList(uint* pulcbAddresses, ubyte* pAddressList);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_ipv4filter-putmulticastmode
    HRESULT PutMulticastMode(uint ulModeMask);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_ipv4filter-getmulticastmode
    HRESULT GetMulticastMode(uint* pulModeMask);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nn-bdaiface-ibda_ipv6filter
@GUID("e1785a74-2a23-4fb3-9245-a8f88017ef33")
interface IBDA_IPV6Filter : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_ipv6filter-getmulticastlistsize
    HRESULT GetMulticastListSize(uint* pulcbAddresses);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_ipv6filter-putmulticastlist
    HRESULT PutMulticastList(uint ulcbAddresses, ubyte* pAddressList);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_ipv6filter-getmulticastlist
    HRESULT GetMulticastList(uint* pulcbAddresses, ubyte* pAddressList);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_ipv6filter-putmulticastmode
    HRESULT PutMulticastMode(uint ulModeMask);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_ipv6filter-getmulticastmode
    HRESULT GetMulticastMode(uint* pulModeMask);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nn-bdaiface-ibda_devicecontrol
@GUID("fd0a5af3-b41d-11d2-9c95-00c04f7971e0")
interface IBDA_DeviceControl : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_devicecontrol-startchanges
    HRESULT StartChanges();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_devicecontrol-checkchanges
    HRESULT CheckChanges();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_devicecontrol-commitchanges
    HRESULT CommitChanges();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_devicecontrol-getchangestate
    HRESULT GetChangeState(uint* pState);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nn-bdaiface-ibda_pincontrol
@GUID("0ded49d5-a8b7-4d5d-97a1-12b0c195874d")
interface IBDA_PinControl : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_pincontrol-getpinid
    HRESULT GetPinID(uint* pulPinID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_pincontrol-getpintype
    HRESULT GetPinType(uint* pulPinType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_pincontrol-registrationcontext
    HRESULT RegistrationContext(uint* pulRegistrationCtx);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nn-bdaiface-ibda_signalproperties
@GUID("d2f1644b-b409-11d2-bc69-00a0c9ee9e16")
interface IBDA_SignalProperties : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_signalproperties-putnetworktype
    HRESULT PutNetworkType(const(GUID)* guidNetworkType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_signalproperties-getnetworktype
    HRESULT GetNetworkType(GUID* pguidNetworkType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_signalproperties-putsignalsource
    HRESULT PutSignalSource(uint ulSignalSource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_signalproperties-getsignalsource
    HRESULT GetSignalSource(uint* pulSignalSource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_signalproperties-puttuningspace
    HRESULT PutTuningSpace(const(GUID)* guidTuningSpace);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_signalproperties-gettuningspace
    HRESULT GetTuningSpace(GUID* pguidTuingSpace);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nn-bdaiface-ibda_signalstatistics
@GUID("1347d106-cf3a-428a-a5cb-ac0d9a2a4338")
interface IBDA_SignalStatistics : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_signalstatistics-put_signalstrength
    HRESULT put_SignalStrength(int lDbStrength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_signalstatistics-get_signalstrength
    HRESULT get_SignalStrength(int* plDbStrength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_signalstatistics-put_signalquality
    HRESULT put_SignalQuality(int lPercentQuality);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_signalstatistics-get_signalquality
    HRESULT get_SignalQuality(int* plPercentQuality);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_signalstatistics-put_signalpresent
    HRESULT put_SignalPresent(BOOLEAN fPresent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_signalstatistics-get_signalpresent
    HRESULT get_SignalPresent(ubyte* pfPresent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_signalstatistics-put_signallocked
    HRESULT put_SignalLocked(BOOLEAN fLocked);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_signalstatistics-get_signallocked
    HRESULT get_SignalLocked(ubyte* pfLocked);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_signalstatistics-put_sampletime
    HRESULT put_SampleTime(int lmsSampleTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_signalstatistics-get_sampletime
    HRESULT get_SampleTime(int* plmsSampleTime);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nn-bdaiface-ibda_topology
@GUID("79b56888-7fea-4690-b45d-38fd3c7849be")
interface IBDA_Topology : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_topology-getnodetypes
    HRESULT GetNodeTypes(uint* pulcNodeTypes, uint ulcNodeTypesMax, uint* rgulNodeTypes);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_topology-getnodedescriptors
    HRESULT GetNodeDescriptors(uint* ulcNodeDescriptors, uint ulcNodeDescriptorsMax, 
                               BDANODE_DESCRIPTOR* rgNodeDescriptors);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_topology-getnodeinterfaces
    HRESULT GetNodeInterfaces(uint ulNodeType, uint* pulcInterfaces, uint ulcInterfacesMax, GUID* rgguidInterfaces);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_topology-getpintypes
    HRESULT GetPinTypes(uint* pulcPinTypes, uint ulcPinTypesMax, uint* rgulPinTypes);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_topology-gettemplateconnections
    HRESULT GetTemplateConnections(uint* pulcConnections, uint ulcConnectionsMax, 
                                   BDA_TEMPLATE_CONNECTION* rgConnections);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_topology-createpin
    HRESULT CreatePin(uint ulPinType, uint* pulPinId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_topology-deletepin
    HRESULT DeletePin(uint ulPinId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_topology-setmediatype
    HRESULT SetMediaType(uint ulPinId, AM_MEDIA_TYPE* pMediaType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_topology-setmedium
    HRESULT SetMedium(uint ulPinId, REGPINMEDIUM* pMedium);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_topology-createtopology
    HRESULT CreateTopology(uint ulInputPinId, uint ulOutputPinId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_topology-getcontrolnode
    HRESULT GetControlNode(uint ulInputPinId, uint ulOutputPinId, uint ulNodeType, IUnknown* ppControlNode);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nn-bdaiface-ibda_voidtransform
@GUID("71985f46-1ca1-11d3-9cc8-00c04f7971e0")
interface IBDA_VoidTransform : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_voidtransform-start
    HRESULT Start();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_voidtransform-stop
    HRESULT Stop();
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nn-bdaiface-ibda_nulltransform
@GUID("ddf15b0d-bd25-11d2-9ca0-00c04f7971e0")
interface IBDA_NullTransform : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_nulltransform-start
    HRESULT Start();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_nulltransform-stop
    HRESULT Stop();
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nn-bdaiface-ibda_frequencyfilter
@GUID("71985f47-1ca1-11d3-9cc8-00c04f7971e0")
interface IBDA_FrequencyFilter : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_frequencyfilter-put_autotune
    HRESULT put_Autotune(uint ulTransponder);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_frequencyfilter-get_autotune
    HRESULT get_Autotune(uint* pulTransponder);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_frequencyfilter-put_frequency
    HRESULT put_Frequency(uint ulFrequency);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_frequencyfilter-get_frequency
    HRESULT get_Frequency(uint* pulFrequency);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_frequencyfilter-put_polarity
    HRESULT put_Polarity(Polarisation Polarity);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_frequencyfilter-get_polarity
    HRESULT get_Polarity(Polarisation* pPolarity);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_frequencyfilter-put_range
    HRESULT put_Range(uint ulRange);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_frequencyfilter-get_range
    HRESULT get_Range(uint* pulRange);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_frequencyfilter-put_bandwidth
    HRESULT put_Bandwidth(uint ulBandwidth);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_frequencyfilter-get_bandwidth
    HRESULT get_Bandwidth(uint* pulBandwidth);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_frequencyfilter-put_frequencymultiplier
    HRESULT put_FrequencyMultiplier(uint ulMultiplier);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_frequencyfilter-get_frequencymultiplier
    HRESULT get_FrequencyMultiplier(uint* pulMultiplier);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nn-bdaiface-ibda_lnbinfo
@GUID("992cf102-49f9-4719-a664-c4f23e2408f4")
interface IBDA_LNBInfo : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_lnbinfo-put_localoscilatorfrequencylowband
    HRESULT put_LocalOscilatorFrequencyLowBand(uint ulLOFLow);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_lnbinfo-get_localoscilatorfrequencylowband
    HRESULT get_LocalOscilatorFrequencyLowBand(uint* pulLOFLow);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_lnbinfo-put_localoscilatorfrequencyhighband
    HRESULT put_LocalOscilatorFrequencyHighBand(uint ulLOFHigh);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_lnbinfo-get_localoscilatorfrequencyhighband
    HRESULT get_LocalOscilatorFrequencyHighBand(uint* pulLOFHigh);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_lnbinfo-put_highlowswitchfrequency
    HRESULT put_HighLowSwitchFrequency(uint ulSwitchFrequency);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_lnbinfo-get_highlowswitchfrequency
    HRESULT get_HighLowSwitchFrequency(uint* pulSwitchFrequency);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nn-bdaiface-ibda_diseqcommand
@GUID("f84e2ab0-3c6b-45e3-a0fc-8669d4b81f11")
interface IBDA_DiseqCommand : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_diseqcommand-put_enablediseqcommands
    HRESULT put_EnableDiseqCommands(BOOLEAN bEnable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_diseqcommand-put_diseqlnbsource
    HRESULT put_DiseqLNBSource(uint ulLNBSource);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_diseqcommand-put_disequsetoneburst
    HRESULT put_DiseqUseToneBurst(BOOLEAN bUseToneBurst);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_diseqcommand-put_diseqrepeats
    HRESULT put_DiseqRepeats(uint ulRepeats);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_diseqcommand-put_diseqsendcommand
    HRESULT put_DiseqSendCommand(uint ulRequestId, uint ulcbCommandLen, ubyte* pbCommand);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_diseqcommand-get_diseqresponse
    HRESULT get_DiseqResponse(uint ulRequestId, uint* pulcbResponseLen, ubyte* pbResponse);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nn-bdaiface-ibda_autodemodulate
@GUID("ddf15b12-bd25-11d2-9ca0-00c04f7971e0")
interface IBDA_AutoDemodulate : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_autodemodulate-put_autodemodulate
    HRESULT put_AutoDemodulate();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nn-bdaiface-ibda_autodemodulateex
@GUID("34518d13-1182-48e6-b28f-b24987787326")
interface IBDA_AutoDemodulateEx : IBDA_AutoDemodulate
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_autodemodulateex-get_supporteddevicenodetypes
    HRESULT get_SupportedDeviceNodeTypes(uint ulcDeviceNodeTypesMax, uint* pulcDeviceNodeTypes, 
                                         GUID* pguidDeviceNodeTypes);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_autodemodulateex-get_supportedvideoformats
    HRESULT get_SupportedVideoFormats(uint* pulAMTunerModeType, uint* pulAnalogVideoStandard);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_autodemodulateex-get_auxinputcount
    HRESULT get_AuxInputCount(uint* pulCompositeCount, uint* pulSvideoCount);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nn-bdaiface-ibda_digitaldemodulator
@GUID("ef30f379-985b-4d10-b640-a79d5e04e1e0")
interface IBDA_DigitalDemodulator : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_digitaldemodulator-put_modulationtype
    HRESULT put_ModulationType(ModulationType* pModulationType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_digitaldemodulator-get_modulationtype
    HRESULT get_ModulationType(ModulationType* pModulationType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_digitaldemodulator-put_innerfecmethod
    HRESULT put_InnerFECMethod(FECMethod* pFECMethod);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_digitaldemodulator-get_innerfecmethod
    HRESULT get_InnerFECMethod(FECMethod* pFECMethod);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_digitaldemodulator-put_innerfecrate
    HRESULT put_InnerFECRate(BinaryConvolutionCodeRate* pFECRate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_digitaldemodulator-get_innerfecrate
    HRESULT get_InnerFECRate(BinaryConvolutionCodeRate* pFECRate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_digitaldemodulator-put_outerfecmethod
    HRESULT put_OuterFECMethod(FECMethod* pFECMethod);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_digitaldemodulator-get_outerfecmethod
    HRESULT get_OuterFECMethod(FECMethod* pFECMethod);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_digitaldemodulator-put_outerfecrate
    HRESULT put_OuterFECRate(BinaryConvolutionCodeRate* pFECRate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_digitaldemodulator-get_outerfecrate
    HRESULT get_OuterFECRate(BinaryConvolutionCodeRate* pFECRate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_digitaldemodulator-put_symbolrate
    HRESULT put_SymbolRate(uint* pSymbolRate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_digitaldemodulator-get_symbolrate
    HRESULT get_SymbolRate(uint* pSymbolRate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_digitaldemodulator-put_spectralinversion
    HRESULT put_SpectralInversion(SpectralInversion* pSpectralInversion);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_digitaldemodulator-get_spectralinversion
    HRESULT get_SpectralInversion(SpectralInversion* pSpectralInversion);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nn-bdaiface-ibda_digitaldemodulator2
@GUID("525ed3ee-5cf3-4e1e-9a06-5368a84f9a6e")
interface IBDA_DigitalDemodulator2 : IBDA_DigitalDemodulator
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_digitaldemodulator2-put_guardinterval
    HRESULT put_GuardInterval(GuardInterval* pGuardInterval);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_digitaldemodulator2-get_guardinterval
    HRESULT get_GuardInterval(GuardInterval* pGuardInterval);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_digitaldemodulator2-put_transmissionmode
    HRESULT put_TransmissionMode(TransmissionMode* pTransmissionMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_digitaldemodulator2-get_transmissionmode
    HRESULT get_TransmissionMode(TransmissionMode* pTransmissionMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_digitaldemodulator2-put_rolloff
    HRESULT put_RollOff(RollOff* pRollOff);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_digitaldemodulator2-get_rolloff
    HRESULT get_RollOff(RollOff* pRollOff);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_digitaldemodulator2-put_pilot
    HRESULT put_Pilot(Pilot* pPilot);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_digitaldemodulator2-get_pilot
    HRESULT get_Pilot(Pilot* pPilot);
}

@GUID("13f19604-7d32-4359-93a2-a05205d90ac9")
interface IBDA_DigitalDemodulator3 : IBDA_DigitalDemodulator2
{
    HRESULT put_SignalTimeouts(BDA_SIGNAL_TIMEOUTS* pSignalTimeouts);
    HRESULT get_SignalTimeouts(BDA_SIGNAL_TIMEOUTS* pSignalTimeouts);
    HRESULT put_PLPNumber(uint* pPLPNumber);
    HRESULT get_PLPNumber(uint* pPLPNumber);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nn-bdaiface-iccsubstreamfiltering
@GUID("4b2bd7ea-8347-467b-8dbf-62f784929cc3")
interface ICCSubStreamFiltering : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-iccsubstreamfiltering-get_substreamtypes
    HRESULT get_SubstreamTypes(int* pTypes);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-iccsubstreamfiltering-put_substreamtypes
    HRESULT put_SubstreamTypes(int Types);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nn-bdaiface-ibda_ipsinkcontrol
@GUID("3f4dc8e2-4050-11d3-8f4b-00c04f7971e2")
interface IBDA_IPSinkControl : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_ipsinkcontrol-getmulticastlist
    HRESULT GetMulticastList(uint* pulcbSize, ubyte** pbBuffer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_ipsinkcontrol-getadapteripaddress
    HRESULT GetAdapterIPAddress(uint* pulcbSize, ubyte** pbBuffer);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nn-bdaiface-ibda_ipsinkinfo
@GUID("a750108f-492e-4d51-95f7-649b23ff7ad7")
interface IBDA_IPSinkInfo : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_ipsinkinfo-get_multicastlist
    HRESULT get_MulticastList(uint* pulcbAddresses, ubyte** ppbAddressList);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_ipsinkinfo-get_adapteripaddress
    HRESULT get_AdapterIPAddress(BSTR* pbstrBuffer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_ipsinkinfo-get_adapterdescription
    HRESULT get_AdapterDescription(BSTR* pbstrBuffer);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nn-bdaiface-ienumpidmap
@GUID("afb6c2a2-2c41-11d3-8a60-0000f81e0e4a")
interface IEnumPIDMap : IUnknown
{
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
    HRESULT Next(uint cRequest, PID_MAP* pPIDMap, uint* pcReceived);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ienumpidmap-skip
    HRESULT Skip(uint cRecords);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ienumpidmap-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ienumpidmap-clone
    HRESULT Clone(IEnumPIDMap* ppIEnumPIDMap);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nn-bdaiface-impeg2pidmap
@GUID("afb6c2a1-2c41-11d3-8a60-0000f81e0e4a")
interface IMPEG2PIDMap : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-impeg2pidmap-mappid
    HRESULT MapPID(uint culPID, uint* pulPID, MEDIA_SAMPLE_CONTENT MediaSampleContent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-impeg2pidmap-unmappid
    HRESULT UnmapPID(uint culPID, uint* pulPID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-impeg2pidmap-enumpidmap
    HRESULT EnumPIDMap(IEnumPIDMap* pIEnumPIDMap);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nn-bdaiface-ifrequencymap
@GUID("06fb45c1-693c-4ea7-b79f-7a6a54d8def2")
interface IFrequencyMap : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ifrequencymap-get_frequencymapping
    HRESULT get_FrequencyMapping(uint* ulCount, uint** ppulList);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ifrequencymap-put_frequencymapping
    HRESULT put_FrequencyMapping(uint ulCount, uint* pList);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ifrequencymap-get_countrycode
    HRESULT get_CountryCode(uint* pulCountryCode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ifrequencymap-put_countrycode
    HRESULT put_CountryCode(uint ulCountryCode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ifrequencymap-get_defaultfrequencymapping
    HRESULT get_DefaultFrequencyMapping(uint ulCountryCode, uint* pulCount, uint** ppulList);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ifrequencymap-get_countrycodelist
    HRESULT get_CountryCodeList(uint* pulCount, uint** ppulList);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nn-bdaiface-ibda_easmessage
@GUID("d806973d-3ebe-46de-8fbb-6358fe784208")
interface IBDA_EasMessage : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_easmessage-get_easmessage
    HRESULT get_EasMessage(uint ulEventID, IUnknown* ppEASObject);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nn-bdaiface-ibda_transportstreaminfo
@GUID("8e882535-5f86-47ab-86cf-c281a72a0549")
interface IBDA_TransportStreamInfo : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_transportstreaminfo-get_pattabletickcount
    HRESULT get_PatTableTickCount(uint* pPatTickCount);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nn-bdaiface-ibda_conditionalaccess
@GUID("cd51f1e0-7be9-4123-8482-a2a796c0a6b0")
interface IBDA_ConditionalAccess : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_conditionalaccess-get_smartcardstatus
    HRESULT get_SmartCardStatus(SmartCardStatusType* pCardStatus, SmartCardAssociationType* pCardAssociation, 
                                BSTR* pbstrCardError, VARIANT_BOOL* pfOOBLocked);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_conditionalaccess-get_smartcardinfo
    HRESULT get_SmartCardInfo(BSTR* pbstrCardName, BSTR* pbstrCardManufacturer, VARIANT_BOOL* pfDaylightSavings, 
                              ubyte* pbyRatingRegion, int* plTimeZoneOffsetMinutes, BSTR* pbstrLanguage, 
                              EALocationCodeType* pEALocationCode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_conditionalaccess-get_smartcardapplications
    HRESULT get_SmartCardApplications(uint* pulcApplications, uint ulcApplicationsMax, 
                                      SmartCardApplication* rgApplications);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_conditionalaccess-get_entitlement
    HRESULT get_Entitlement(ushort usVirtualChannel, EntitlementType* pEntitlement);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_conditionalaccess-tunebychannel
    HRESULT TuneByChannel(ushort usVirtualChannel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_conditionalaccess-setprogram
    HRESULT SetProgram(ushort usProgramNumber);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_conditionalaccess-addprogram
    HRESULT AddProgram(ushort usProgramNumber);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_conditionalaccess-removeprogram
    HRESULT RemoveProgram(ushort usProgramNumber);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_conditionalaccess-getmoduleui
    HRESULT GetModuleUI(ubyte byDialogNumber, BSTR* pbstrURL);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_conditionalaccess-informuiclosed
    HRESULT InformUIClosed(ubyte byDialogNumber, UICloseReasonType CloseReason);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nn-bdaiface-ibda_diagnosticproperties
@GUID("20e80cb5-c543-4c1b-8eb3-49e719eee7d4")
interface IBDA_DiagnosticProperties : IPropertyBag
{
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nn-bdaiface-ibda_drm
@GUID("f98d88b0-1992-4cd6-a6d9-b9afab99330d")
interface IBDA_DRM : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_drm-getdrmpairingstatus
    HRESULT GetDRMPairingStatus(uint* pdwStatus, HRESULT* phError);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_drm-performdrmpairing
    HRESULT PerformDRMPairing(BOOL fSync);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nn-bdaiface-ibda_namevalueservice
@GUID("7f0b3150-7b81-4ad4-98e3-7e9097094301")
interface IBDA_NameValueService : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_namevalueservice-getvaluenamebyindex
    HRESULT GetValueNameByIndex(uint ulIndex, BSTR* pbstrName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_namevalueservice-getvalue
    HRESULT GetValue(BSTR bstrName, BSTR bstrLanguage, BSTR* pbstrValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_namevalueservice-setvalue
    HRESULT SetValue(uint ulDialogRequest, BSTR bstrLanguage, BSTR bstrName, BSTR bstrValue, uint ulReserved);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nn-bdaiface-ibda_conditionalaccessex
@GUID("497c3418-23cb-44ba-bb62-769f506fcea7")
interface IBDA_ConditionalAccessEx : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_conditionalaccessex-checkentitlementtoken
    HRESULT CheckEntitlementToken(uint ulDialogRequest, BSTR bstrLanguage, 
                                  BDA_CONDITIONALACCESS_REQUESTTYPE RequestType, uint ulcbEntitlementTokenLen, 
                                  ubyte* pbEntitlementToken, uint* pulDescrambleStatus);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_conditionalaccessex-setcapturetoken
    HRESULT SetCaptureToken(uint ulcbCaptureTokenLen, ubyte* pbCaptureToken);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_conditionalaccessex-openbroadcastmmi
    HRESULT OpenBroadcastMmi(uint ulDialogRequest, BSTR bstrLanguage, uint EventId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_conditionalaccessex-closemmidialog
    HRESULT CloseMmiDialog(uint ulDialogRequest, BSTR bstrLanguage, uint ulDialogNumber, 
                           BDA_CONDITIONALACCESS_MMICLOSEREASON ReasonCode, uint* pulSessionResult);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_conditionalaccessex-createdialogrequestnumber
    HRESULT CreateDialogRequestNumber(uint* pulDialogRequestNumber);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nn-bdaiface-ibda_isdbconditionalaccess
@GUID("5e68c627-16c2-4e6c-b1e2-d00170cdaa0f")
interface IBDA_ISDBConditionalAccess : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_isdbconditionalaccess-setisdbcasrequest
    HRESULT SetIsdbCasRequest(uint ulRequestId, uint ulcbRequestBufferLen, ubyte* pbRequestBuffer);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nn-bdaiface-ibda_eventingservice
@GUID("207c413f-00dc-4c61-bad6-6fee1ff07064")
interface IBDA_EventingService : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_eventingservice-completeevent
    HRESULT CompleteEvent(uint ulEventID, uint ulEventResult);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nn-bdaiface-ibda_aux
@GUID("7def4c09-6e66-4567-a819-f0e17f4a81ab")
interface IBDA_AUX : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_aux-querycapabilities
    HRESULT QueryCapabilities(uint* pdwNumAuxInputsBSTR);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_aux-enumcapability
    HRESULT EnumCapability(uint dwIndex, uint* dwInputID, GUID* pConnectorType, uint* ConnTypeNum, 
                           uint* NumVideoStds, ulong* AnalogStds);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nn-bdaiface-ibda_encoder
@GUID("3a8bad59-59fe-4559-a0ba-396cfaa98ae3")
interface IBDA_Encoder : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_encoder-querycapabilities
    HRESULT QueryCapabilities(uint* NumAudioFmts, uint* NumVideoFmts);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_encoder-enumaudiocapability
    HRESULT EnumAudioCapability(uint FmtIndex, uint* MethodID, uint* AlgorithmType, uint* SamplingRate, 
                                uint* BitDepth, uint* NumChannels);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_encoder-enumvideocapability
    HRESULT EnumVideoCapability(uint FmtIndex, uint* MethodID, uint* AlgorithmType, uint* VerticalSize, 
                                uint* HorizontalSize, uint* AspectRatio, uint* FrameRateCode, 
                                uint* ProgressiveSequence);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_encoder-setparameters
    HRESULT SetParameters(uint AudioBitrateMode, uint AudioBitrate, uint AudioMethodID, uint AudioProgram, 
                          uint VideoBitrateMode, uint VideoBitrate, uint VideoMethodID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_encoder-getstate
    HRESULT GetState(uint* AudioBitrateMax, uint* AudioBitrateMin, uint* AudioBitrateMode, 
                     uint* AudioBitrateStepping, uint* AudioBitrate, uint* AudioMethodID, 
                     uint* AvailableAudioPrograms, uint* AudioProgram, uint* VideoBitrateMax, uint* VideoBitrateMin, 
                     uint* VideoBitrateMode, uint* VideoBitrate, uint* VideoBitrateStepping, uint* VideoMethodID, 
                     uint* SignalSourceID, ulong* SignalFormat, BOOL* SignalLock, int* SignalLevel, 
                     uint* SignalToNoiseRatio);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nn-bdaiface-ibda_fdc
@GUID("138adc7e-58ae-437f-b0b4-c9fe19d5b4ac")
interface IBDA_FDC : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_fdc-getstatus
    HRESULT GetStatus(uint* CurrentBitrate, BOOL* CarrierLock, uint* CurrentFrequency, 
                      BOOL* CurrentSpectrumInversion, BSTR* CurrentPIDList, BSTR* CurrentTIDList, BOOL* Overflow);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_fdc-requesttables
    HRESULT RequestTables(BSTR TableIDs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_fdc-addpid
    HRESULT AddPid(BSTR PidsToAdd, uint* RemainingFilterEntries);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_fdc-removepid
    HRESULT RemovePid(BSTR PidsToRemove);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_fdc-addtid
    HRESULT AddTid(BSTR TidsToAdd, BSTR* CurrentTidList);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_fdc-removetid
    HRESULT RemoveTid(BSTR TidsToRemove);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_fdc-gettablesection
    HRESULT GetTableSection(uint* Pid, uint MaxBufferSize, uint* ActualSize, ubyte* SecBuffer);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nn-bdaiface-ibda_guidedatadeliveryservice
@GUID("c0afcb73-23e7-4bc6-bafa-fdc167b4719f")
interface IBDA_GuideDataDeliveryService : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_guidedatadeliveryservice-getguidedatatype
    HRESULT GetGuideDataType(GUID* pguidDataType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_guidedatadeliveryservice-getguidedata
    HRESULT GetGuideData(uint* pulcbBufferLen, ubyte* pbBuffer, uint* pulGuideDataPercentageProgress);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_guidedatadeliveryservice-requestguidedataupdate
    HRESULT RequestGuideDataUpdate();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_guidedatadeliveryservice-gettunexmlfromserviceidx
    HRESULT GetTuneXmlFromServiceIdx(ulong ul64ServiceIdx, BSTR* pbstrTuneXml);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_guidedatadeliveryservice-getservices
    HRESULT GetServices(uint* pulcbBufferLen, ubyte* pbBuffer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_guidedatadeliveryservice-getserviceinfofromtunexml
    HRESULT GetServiceInfoFromTuneXml(BSTR bstrTuneXml, BSTR* pbstrServiceDescription);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nn-bdaiface-ibda_drmservice
@GUID("bff6b5bb-b0ae-484c-9dca-73528fb0b46e")
interface IBDA_DRMService : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_drmservice-setdrm
    HRESULT SetDRM(GUID* puuidNewDrm);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_drmservice-getdrmstatus
    HRESULT GetDRMStatus(BSTR* pbstrDrmUuidList, GUID* DrmUuid);
}

@GUID("4be6fa3d-07cd-4139-8b80-8c18ba3aec88")
interface IBDA_WMDRMSession : IUnknown
{
    HRESULT GetStatus(uint* MaxCaptureToken, uint* MaxStreamingPid, uint* MaxLicense, uint* MinSecurityLevel, 
                      uint* RevInfoSequenceNumber, ulong* RevInfoIssuedTime, uint* RevInfoTTL, uint* RevListVersion, 
                      uint* ulState);
    HRESULT SetRevInfo(uint ulRevInfoLen, ubyte* pbRevInfo);
    HRESULT SetCrl(uint ulCrlLen, ubyte* pbCrlLen);
    HRESULT TransactMessage(uint ulcbRequest, ubyte* pbRequest, uint* pulcbResponse, ubyte* pbResponse);
    HRESULT GetLicense(GUID* uuidKey, uint* pulPackageLen, ubyte* pbPackage);
    HRESULT ReissueLicense(GUID* uuidKey);
    HRESULT RenewLicense(uint ulInXmrLicenseLen, ubyte* pbInXmrLicense, uint ulEntitlementTokenLen, 
                         ubyte* pbEntitlementToken, uint* pulDescrambleStatus, uint* pulOutXmrLicenseLen, 
                         ubyte* pbOutXmrLicense);
    HRESULT GetKeyInfo(uint* pulKeyInfoLen, ubyte* pbKeyInfo);
}

@GUID("86d979cf-a8a7-4f94-b5fb-14c0aca68fe6")
interface IBDA_WMDRMTuner : IUnknown
{
    HRESULT PurchaseEntitlement(uint ulDialogRequest, BSTR bstrLanguage, uint ulPurchaseTokenLen, 
                                ubyte* pbPurchaseToken, uint* pulDescrambleStatus, uint* pulCaptureTokenLen, 
                                ubyte* pbCaptureToken);
    HRESULT CancelCaptureToken(uint ulCaptureTokenLen, ubyte* pbCaptureToken);
    HRESULT SetPidProtection(uint ulPid, GUID* uuidKey);
    HRESULT GetPidProtection(uint pulPid, GUID* uuidKey);
    HRESULT SetSyncValue(uint ulSyncValue);
    HRESULT GetStartCodeProfile(uint* pulStartCodeProfileLen, ubyte* pbStartCodeProfile);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nn-bdaiface-ibda_dridrmservice
@GUID("1f9bc2a5-44a3-4c52-aab1-0bbce5a1381d")
interface IBDA_DRIDRMService : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_dridrmservice-setdrm
    HRESULT SetDRM(BSTR bstrNewDrm);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_dridrmservice-getdrmstatus
    HRESULT GetDRMStatus(BSTR* pbstrDrmUuidList, GUID* DrmUuid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_dridrmservice-getpairingstatus
    HRESULT GetPairingStatus(BDA_DrmPairingError* penumPairingStatus);
}

@GUID("05c690f8-56db-4bb2-b053-79c12098bb26")
interface IBDA_DRIWMDRMSession : IUnknown
{
    HRESULT AcknowledgeLicense(HRESULT hrLicenseAck);
    HRESULT ProcessLicenseChallenge(uint dwcbLicenseMessage, ubyte* pbLicenseMessage, uint* pdwcbLicenseResponse, 
                                    ubyte** ppbLicenseResponse);
    HRESULT ProcessRegistrationChallenge(uint dwcbRegistrationMessage, ubyte* pbRegistrationMessage, 
                                         uint* pdwcbRegistrationResponse, ubyte** ppbRegistrationResponse);
    HRESULT SetRevInfo(uint dwRevInfoLen, ubyte* pbRevInfo, uint* pdwResponse);
    HRESULT SetCrl(uint dwCrlLen, ubyte* pbCrlLen, uint* pdwResponse);
    HRESULT GetHMSAssociationData();
    HRESULT GetLastCardeaError(uint* pdwError);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nn-bdaiface-ibda_mux
@GUID("942aafec-4c05-4c74-b8eb-8706c2a4943f")
interface IBDA_MUX : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_mux-setpidlist
    HRESULT SetPidList(uint ulPidListCount, BDA_MUX_PIDLISTITEM* pbPidListBuffer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_mux-getpidlist
    HRESULT GetPidList(uint* pulPidListCount, BDA_MUX_PIDLISTITEM* pbPidListBuffer);
}

@GUID("1dcfafe9-b45e-41b3-bb2a-561eb129ae98")
interface IBDA_TransportStreamSelector : IUnknown
{
    HRESULT SetTSID(ushort usTSID);
    HRESULT GetTSInformation(uint* pulTSInformationBufferLen, ubyte* pbTSInformationBuffer);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nn-bdaiface-ibda_useractivityservice
@GUID("53b14189-e478-4b7a-a1ff-506db4b99dfe")
interface IBDA_UserActivityService : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_useractivityservice-setcurrenttunerusereason
    HRESULT SetCurrentTunerUseReason(uint dwUseReason);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_useractivityservice-getuseractivityinterval
    HRESULT GetUserActivityInterval(uint* pdwActivityInterval);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdaiface/nf-bdaiface-ibda_useractivityservice-useractivitydetected
    HRESULT UserActivityDetected();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nn-tuner-iesevent
@GUID("1f0e5357-af43-44e6-8547-654c645145d2")
interface IESEvent : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-iesevent-geteventid
    HRESULT GetEventId(uint* pdwEventId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-iesevent-geteventtype
    HRESULT GetEventType(GUID* pguidEventType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-iesevent-setcompletionstatus
    HRESULT SetCompletionStatus(uint dwResult);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-iesevent-getdata
    HRESULT GetData(SAFEARRAY** pbData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-iesevent-getstringdata
    HRESULT GetStringData(BSTR* pbstrData);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nn-tuner-iesevents
@GUID("abd414bf-cfe5-4e5e-af5b-4b4e49c5bfeb")
interface IESEvents : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-iesevents-oneseventreceived
    HRESULT OnESEventReceived(GUID guidEventType, IESEvent pESEvent);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nn-tuner-ibroadcastevent
@GUID("3b21263f-26e8-489d-aac4-924f7efd9511")
interface IBroadcastEvent : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ibroadcastevent-fire
    HRESULT Fire(GUID EventID);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nn-tuner-ibroadcasteventex
@GUID("3d9e3887-1929-423f-8021-43682de95448")
interface IBroadcastEventEx : IBroadcastEvent
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ibroadcasteventex-fireex
    HRESULT FireEx(GUID EventID, uint Param1, uint Param2, uint Param3, uint Param4);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nn-qnetwork-iamnetshowconfig
@GUID("fa2aa8f1-8b62-11d0-a520-000000000000")
interface IAMNetShowConfig : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iamnetshowconfig-get_bufferingtime
    HRESULT get_BufferingTime(double* pBufferingTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iamnetshowconfig-put_bufferingtime
    HRESULT put_BufferingTime(double BufferingTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iamnetshowconfig-get_usefixedudpport
    HRESULT get_UseFixedUDPPort(VARIANT_BOOL* pUseFixedUDPPort);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iamnetshowconfig-put_usefixedudpport
    HRESULT put_UseFixedUDPPort(VARIANT_BOOL UseFixedUDPPort);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iamnetshowconfig-get_fixedudpport
    HRESULT get_FixedUDPPort(int* pFixedUDPPort);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iamnetshowconfig-put_fixedudpport
    HRESULT put_FixedUDPPort(int FixedUDPPort);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iamnetshowconfig-get_usehttpproxy
    HRESULT get_UseHTTPProxy(VARIANT_BOOL* pUseHTTPProxy);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iamnetshowconfig-put_usehttpproxy
    HRESULT put_UseHTTPProxy(VARIANT_BOOL UseHTTPProxy);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iamnetshowconfig-get_enableautoproxy
    HRESULT get_EnableAutoProxy(VARIANT_BOOL* pEnableAutoProxy);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iamnetshowconfig-put_enableautoproxy
    HRESULT put_EnableAutoProxy(VARIANT_BOOL EnableAutoProxy);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iamnetshowconfig-get_httpproxyhost
    HRESULT get_HTTPProxyHost(BSTR* pbstrHTTPProxyHost);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iamnetshowconfig-put_httpproxyhost
    HRESULT put_HTTPProxyHost(BSTR bstrHTTPProxyHost);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iamnetshowconfig-get_httpproxyport
    HRESULT get_HTTPProxyPort(int* pHTTPProxyPort);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iamnetshowconfig-put_httpproxyport
    HRESULT put_HTTPProxyPort(int HTTPProxyPort);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iamnetshowconfig-get_enablemulticast
    HRESULT get_EnableMulticast(VARIANT_BOOL* pEnableMulticast);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iamnetshowconfig-put_enablemulticast
    HRESULT put_EnableMulticast(VARIANT_BOOL EnableMulticast);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iamnetshowconfig-get_enableudp
    HRESULT get_EnableUDP(VARIANT_BOOL* pEnableUDP);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iamnetshowconfig-put_enableudp
    HRESULT put_EnableUDP(VARIANT_BOOL EnableUDP);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iamnetshowconfig-get_enabletcp
    HRESULT get_EnableTCP(VARIANT_BOOL* pEnableTCP);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iamnetshowconfig-put_enabletcp
    HRESULT put_EnableTCP(VARIANT_BOOL EnableTCP);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iamnetshowconfig-get_enablehttp
    HRESULT get_EnableHTTP(VARIANT_BOOL* pEnableHTTP);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iamnetshowconfig-put_enablehttp
    HRESULT put_EnableHTTP(VARIANT_BOOL EnableHTTP);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nn-qnetwork-iamchannelinfo
@GUID("fa2aa8f2-8b62-11d0-a520-000000000000")
interface IAMChannelInfo : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iamchannelinfo-get_channelname
    HRESULT get_ChannelName(BSTR* pbstrChannelName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iamchannelinfo-get_channeldescription
    HRESULT get_ChannelDescription(BSTR* pbstrChannelDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iamchannelinfo-get_channelurl
    HRESULT get_ChannelURL(BSTR* pbstrChannelURL);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iamchannelinfo-get_contactaddress
    HRESULT get_ContactAddress(BSTR* pbstrContactAddress);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iamchannelinfo-get_contactphone
    HRESULT get_ContactPhone(BSTR* pbstrContactPhone);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iamchannelinfo-get_contactemail
    HRESULT get_ContactEmail(BSTR* pbstrContactEmail);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nn-qnetwork-iamnetworkstatus
@GUID("fa2aa8f3-8b62-11d0-a520-000000000000")
interface IAMNetworkStatus : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iamnetworkstatus-get_receivedpackets
    HRESULT get_ReceivedPackets(int* pReceivedPackets);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iamnetworkstatus-get_recoveredpackets
    HRESULT get_RecoveredPackets(int* pRecoveredPackets);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iamnetworkstatus-get_lostpackets
    HRESULT get_LostPackets(int* pLostPackets);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iamnetworkstatus-get_receptionquality
    HRESULT get_ReceptionQuality(int* pReceptionQuality);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iamnetworkstatus-get_bufferingcount
    HRESULT get_BufferingCount(int* pBufferingCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iamnetworkstatus-get_isbroadcast
    HRESULT get_IsBroadcast(VARIANT_BOOL* pIsBroadcast);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iamnetworkstatus-get_bufferingprogress
    HRESULT get_BufferingProgress(int* pBufferingProgress);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nn-qnetwork-iamextendedseeking
@GUID("fa2aa8f9-8b62-11d0-a520-000000000000")
interface IAMExtendedSeeking : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iamextendedseeking-get_exseekcapabilities
    HRESULT get_ExSeekCapabilities(int* pExCapabilities);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iamextendedseeking-get_markercount
    HRESULT get_MarkerCount(int* pMarkerCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iamextendedseeking-get_currentmarker
    HRESULT get_CurrentMarker(int* pCurrentMarker);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iamextendedseeking-getmarkertime
    HRESULT GetMarkerTime(int MarkerNum, double* pMarkerTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iamextendedseeking-getmarkername
    HRESULT GetMarkerName(int MarkerNum, BSTR* pbstrMarkerName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iamextendedseeking-put_playbackspeed
    HRESULT put_PlaybackSpeed(double Speed);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iamextendedseeking-get_playbackspeed
    HRESULT get_PlaybackSpeed(double* pSpeed);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nn-qnetwork-iamnetshowexprops
@GUID("fa2aa8f5-8b62-11d0-a520-000000000000")
interface IAMNetShowExProps : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iamnetshowexprops-get_sourceprotocol
    HRESULT get_SourceProtocol(int* pSourceProtocol);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iamnetshowexprops-get_bandwidth
    HRESULT get_Bandwidth(int* pBandwidth);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iamnetshowexprops-get_errorcorrection
    HRESULT get_ErrorCorrection(BSTR* pbstrErrorCorrection);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iamnetshowexprops-get_codeccount
    HRESULT get_CodecCount(int* pCodecCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iamnetshowexprops-getcodecinstalled
    HRESULT GetCodecInstalled(int CodecNum, VARIANT_BOOL* pCodecInstalled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iamnetshowexprops-getcodecdescription
    HRESULT GetCodecDescription(int CodecNum, BSTR* pbstrCodecDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iamnetshowexprops-getcodecurl
    HRESULT GetCodecURL(int CodecNum, BSTR* pbstrCodecURL);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iamnetshowexprops-get_creationdate
    HRESULT get_CreationDate(double* pCreationDate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iamnetshowexprops-get_sourcelink
    HRESULT get_SourceLink(BSTR* pbstrSourceLink);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nn-qnetwork-iamextendederrorinfo
@GUID("fa2aa8f6-8b62-11d0-a520-000000000000")
interface IAMExtendedErrorInfo : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iamextendederrorinfo-get_haserror
    HRESULT get_HasError(VARIANT_BOOL* pHasError);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iamextendederrorinfo-get_errordescription
    HRESULT get_ErrorDescription(BSTR* pbstrErrorDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iamextendederrorinfo-get_errorcode
    HRESULT get_ErrorCode(int* pErrorCode);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nn-qnetwork-iammediacontent
@GUID("fa2aa8f4-8b62-11d0-a520-000000000000")
interface IAMMediaContent : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iammediacontent-get_authorname
    HRESULT get_AuthorName(BSTR* pbstrAuthorName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iammediacontent-get_title
    HRESULT get_Title(BSTR* pbstrTitle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iammediacontent-get_rating
    HRESULT get_Rating(BSTR* pbstrRating);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iammediacontent-get_description
    HRESULT get_Description(BSTR* pbstrDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iammediacontent-get_copyright
    HRESULT get_Copyright(BSTR* pbstrCopyright);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iammediacontent-get_baseurl
    HRESULT get_BaseURL(BSTR* pbstrBaseURL);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iammediacontent-get_logourl
    HRESULT get_LogoURL(BSTR* pbstrLogoURL);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iammediacontent-get_logoiconurl
    HRESULT get_LogoIconURL(BSTR* pbstrLogoURL);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iammediacontent-get_watermarkurl
    HRESULT get_WatermarkURL(BSTR* pbstrWatermarkURL);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iammediacontent-get_moreinfourl
    HRESULT get_MoreInfoURL(BSTR* pbstrMoreInfoURL);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iammediacontent-get_moreinfobannerimage
    HRESULT get_MoreInfoBannerImage(BSTR* pbstrMoreInfoBannerImage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iammediacontent-get_moreinfobannerurl
    HRESULT get_MoreInfoBannerURL(BSTR* pbstrMoreInfoBannerURL);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iammediacontent-get_moreinfotext
    HRESULT get_MoreInfoText(BSTR* pbstrMoreInfoText);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nn-qnetwork-iammediacontent2
@GUID("ce8f78c1-74d9-11d2-b09d-00a0c9a81117")
interface IAMMediaContent2 : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iammediacontent2-get_mediaparameter
    HRESULT get_MediaParameter(int EntryNum, BSTR bstrName, BSTR* pbstrValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iammediacontent2-get_mediaparametername
    HRESULT get_MediaParameterName(int EntryNum, int Index, BSTR* pbstrName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iammediacontent2-get_playlistcount
    HRESULT get_PlaylistCount(int* pNumberEntries);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nn-qnetwork-iamnetshowpreroll
@GUID("aae7e4e2-6388-11d1-8d93-006097c9a2b2")
interface IAMNetShowPreroll : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iamnetshowpreroll-put_preroll
    HRESULT put_Preroll(VARIANT_BOOL fPreroll);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-iamnetshowpreroll-get_preroll
    HRESULT get_Preroll(VARIANT_BOOL* pfPreroll);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nn-qnetwork-idshowplugin
@GUID("4746b7c8-700e-11d1-becc-00c04fb6e937")
interface IDShowPlugin : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-idshowplugin-get_url
    HRESULT get_URL(BSTR* pURL);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qnetwork/nf-qnetwork-idshowplugin-get_useragent
    HRESULT get_UserAgent(BSTR* pUserAgent);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amaudio/nn-amaudio-iamdirectsound
@GUID("546f4260-d53e-11cf-b3f0-00aa003761c5")
interface IAMDirectSound : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amaudio/nf-amaudio-iamdirectsound-getdirectsoundinterface
    HRESULT GetDirectSoundInterface(IDirectSound* lplpds);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amaudio/nf-amaudio-iamdirectsound-getprimarybufferinterface
    HRESULT GetPrimaryBufferInterface(IDirectSoundBuffer* lplpdsb);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amaudio/nf-amaudio-iamdirectsound-getsecondarybufferinterface
    HRESULT GetSecondaryBufferInterface(IDirectSoundBuffer* lplpdsb);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amaudio/nf-amaudio-iamdirectsound-releasedirectsoundinterface
    HRESULT ReleaseDirectSoundInterface(IDirectSound lpds);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amaudio/nf-amaudio-iamdirectsound-releaseprimarybufferinterface
    HRESULT ReleasePrimaryBufferInterface(IDirectSoundBuffer lpdsb);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amaudio/nf-amaudio-iamdirectsound-releasesecondarybufferinterface
    HRESULT ReleaseSecondaryBufferInterface(IDirectSoundBuffer lpdsb);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amaudio/nf-amaudio-iamdirectsound-setfocuswindow
    HRESULT SetFocusWindow(HWND param0, BOOL param1);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amaudio/nf-amaudio-iamdirectsound-getfocuswindow
    HRESULT GetFocusWindow(HWND* param0, BOOL* param1);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/il21dec/nn-il21dec-iamline21decoder
@GUID("6e8d4a21-310c-11d0-b79a-00aa003767a7")
interface IAMLine21Decoder : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/il21dec/nf-il21dec-iamline21decoder-getdecoderlevel
    HRESULT GetDecoderLevel(AM_LINE21_CCLEVEL* lpLevel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/il21dec/nf-il21dec-iamline21decoder-getcurrentservice
    HRESULT GetCurrentService(AM_LINE21_CCSERVICE* lpService);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/il21dec/nf-il21dec-iamline21decoder-setcurrentservice
    HRESULT SetCurrentService(AM_LINE21_CCSERVICE Service);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/il21dec/nf-il21dec-iamline21decoder-getservicestate
    HRESULT GetServiceState(AM_LINE21_CCSTATE* lpState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/il21dec/nf-il21dec-iamline21decoder-setservicestate
    HRESULT SetServiceState(AM_LINE21_CCSTATE State);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/il21dec/nf-il21dec-iamline21decoder-getoutputformat
    HRESULT GetOutputFormat(BITMAPINFOHEADER* lpbmih);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/il21dec/nf-il21dec-iamline21decoder-setoutputformat
    HRESULT SetOutputFormat(BITMAPINFO* lpbmi);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/il21dec/nf-il21dec-iamline21decoder-getbackgroundcolor
    HRESULT GetBackgroundColor(uint* pdwPhysColor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/il21dec/nf-il21dec-iamline21decoder-setbackgroundcolor
    HRESULT SetBackgroundColor(uint dwPhysColor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/il21dec/nf-il21dec-iamline21decoder-getredrawalways
    HRESULT GetRedrawAlways(BOOL* lpbOption);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/il21dec/nf-il21dec-iamline21decoder-setredrawalways
    HRESULT SetRedrawAlways(BOOL bOption);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/il21dec/nf-il21dec-iamline21decoder-getdrawbackgroundmode
    HRESULT GetDrawBackgroundMode(AM_LINE21_DRAWBGMODE* lpMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/il21dec/nf-il21dec-iamline21decoder-setdrawbackgroundmode
    HRESULT SetDrawBackgroundMode(AM_LINE21_DRAWBGMODE Mode);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amparse/nn-amparse-iamparse
@GUID("c47a3420-005c-11d2-9038-00a0c9697298")
interface IAMParse : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amparse/nf-amparse-iamparse-getparsetime
    HRESULT GetParseTime(long* prtCurrent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amparse/nf-amparse-iamparse-setparsetime
    HRESULT SetParseTime(long rtCurrent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amparse/nf-amparse-iamparse-flush
    HRESULT Flush();
}

@GUID("56a868b9-0ad4-11ce-b03a-0020af0ba770")
interface IAMCollection : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT Item(int lItem, IUnknown* ppUnk);
    HRESULT get__NewEnum(IUnknown* ppUnk);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nn-control-imediacontrol
@GUID("56a868b1-0ad4-11ce-b03a-0020af0ba770")
interface IMediaControl : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-imediacontrol-run
    HRESULT Run();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-imediacontrol-pause
    HRESULT Pause();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-imediacontrol-stop
    HRESULT Stop();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-imediacontrol-getstate
    HRESULT GetState(int msTimeout, int* pfs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-imediacontrol-renderfile
    HRESULT RenderFile(BSTR strFilename);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-imediacontrol-addsourcefilter
    HRESULT AddSourceFilter(BSTR strFilename, IDispatch* ppUnk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-imediacontrol-get_filtercollection
    HRESULT get_FilterCollection(IDispatch* ppUnk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-imediacontrol-get_regfiltercollection
    HRESULT get_RegFilterCollection(IDispatch* ppUnk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-imediacontrol-stopwhenready
    HRESULT StopWhenReady();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nn-control-imediaevent
@GUID("56a868b6-0ad4-11ce-b03a-0020af0ba770")
interface IMediaEvent : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-imediaevent-geteventhandle
    HRESULT GetEventHandle(ptrdiff_t* hEvent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-imediaevent-getevent
    HRESULT GetEvent(int* lEventCode, ptrdiff_t* lParam1, ptrdiff_t* lParam2, int msTimeout);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-imediaevent-waitforcompletion
    HRESULT WaitForCompletion(int msTimeout, int* pEvCode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-imediaevent-canceldefaulthandling
    HRESULT CancelDefaultHandling(int lEvCode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-imediaevent-restoredefaulthandling
    HRESULT RestoreDefaultHandling(int lEvCode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-imediaevent-freeeventparams
    HRESULT FreeEventParams(int lEvCode, ptrdiff_t lParam1, ptrdiff_t lParam2);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nn-control-imediaeventex
@GUID("56a868c0-0ad4-11ce-b03a-0020af0ba770")
interface IMediaEventEx : IMediaEvent
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-imediaeventex-setnotifywindow
    HRESULT SetNotifyWindow(ptrdiff_t hwnd, int lMsg, ptrdiff_t lInstanceData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-imediaeventex-setnotifyflags
    HRESULT SetNotifyFlags(int lNoNotifyFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-imediaeventex-getnotifyflags
    HRESULT GetNotifyFlags(int* lplNoNotifyFlags);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nn-control-imediaposition
@GUID("56a868b2-0ad4-11ce-b03a-0020af0ba770")
interface IMediaPosition : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-imediaposition-get_duration
    HRESULT get_Duration(double* plength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-imediaposition-put_currentposition
    HRESULT put_CurrentPosition(double llTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-imediaposition-get_currentposition
    HRESULT get_CurrentPosition(double* pllTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-imediaposition-get_stoptime
    HRESULT get_StopTime(double* pllTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-imediaposition-put_stoptime
    HRESULT put_StopTime(double llTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-imediaposition-get_prerolltime
    HRESULT get_PrerollTime(double* pllTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-imediaposition-put_prerolltime
    HRESULT put_PrerollTime(double llTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-imediaposition-put_rate
    HRESULT put_Rate(double dRate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-imediaposition-get_rate
    HRESULT get_Rate(double* pdRate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-imediaposition-canseekforward
    HRESULT CanSeekForward(int* pCanSeekForward);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-imediaposition-canseekbackward
    HRESULT CanSeekBackward(int* pCanSeekBackward);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nn-control-ibasicaudio
@GUID("56a868b3-0ad4-11ce-b03a-0020af0ba770")
interface IBasicAudio : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ibasicaudio-put_volume
    HRESULT put_Volume(int lVolume);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ibasicaudio-get_volume
    HRESULT get_Volume(int* plVolume);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ibasicaudio-put_balance
    HRESULT put_Balance(int lBalance);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ibasicaudio-get_balance
    HRESULT get_Balance(int* plBalance);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nn-control-ivideowindow
@GUID("56a868b4-0ad4-11ce-b03a-0020af0ba770")
interface IVideoWindow : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ivideowindow-put_caption
    HRESULT put_Caption(BSTR strCaption);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ivideowindow-get_caption
    HRESULT get_Caption(BSTR* strCaption);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ivideowindow-put_windowstyle
    HRESULT put_WindowStyle(int WindowStyle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ivideowindow-get_windowstyle
    HRESULT get_WindowStyle(int* WindowStyle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ivideowindow-put_windowstyleex
    HRESULT put_WindowStyleEx(int WindowStyleEx);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ivideowindow-get_windowstyleex
    HRESULT get_WindowStyleEx(int* WindowStyleEx);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ivideowindow-put_autoshow
    HRESULT put_AutoShow(int AutoShow);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ivideowindow-get_autoshow
    HRESULT get_AutoShow(int* AutoShow);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ivideowindow-put_windowstate
    HRESULT put_WindowState(int WindowState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ivideowindow-get_windowstate
    HRESULT get_WindowState(SHOW_WINDOW_CMD* WindowState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ivideowindow-put_backgroundpalette
    HRESULT put_BackgroundPalette(int BackgroundPalette);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ivideowindow-get_backgroundpalette
    HRESULT get_BackgroundPalette(int* pBackgroundPalette);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ivideowindow-put_visible
    HRESULT put_Visible(int Visible);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ivideowindow-get_visible
    HRESULT get_Visible(int* pVisible);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ivideowindow-put_left
    HRESULT put_Left(int Left);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ivideowindow-get_left
    HRESULT get_Left(int* pLeft);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ivideowindow-put_width
    HRESULT put_Width(int Width);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ivideowindow-get_width
    HRESULT get_Width(int* pWidth);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ivideowindow-put_top
    HRESULT put_Top(int Top);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ivideowindow-get_top
    HRESULT get_Top(int* pTop);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ivideowindow-put_height
    HRESULT put_Height(int Height);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ivideowindow-get_height
    HRESULT get_Height(int* pHeight);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ivideowindow-put_owner
    HRESULT put_Owner(ptrdiff_t Owner);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ivideowindow-get_owner
    HRESULT get_Owner(ptrdiff_t* Owner);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ivideowindow-put_messagedrain
    HRESULT put_MessageDrain(ptrdiff_t Drain);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ivideowindow-get_messagedrain
    HRESULT get_MessageDrain(ptrdiff_t* Drain);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ivideowindow-get_bordercolor
    HRESULT get_BorderColor(int* Color);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ivideowindow-put_bordercolor
    HRESULT put_BorderColor(int Color);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ivideowindow-get_fullscreenmode
    HRESULT get_FullScreenMode(int* FullScreenMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ivideowindow-put_fullscreenmode
    HRESULT put_FullScreenMode(int FullScreenMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ivideowindow-setwindowforeground
    HRESULT SetWindowForeground(int Focus);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ivideowindow-notifyownermessage
    HRESULT NotifyOwnerMessage(ptrdiff_t hwnd, int uMsg, ptrdiff_t wParam, ptrdiff_t lParam);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ivideowindow-setwindowposition
    HRESULT SetWindowPosition(int Left, int Top, int Width, int Height);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ivideowindow-getwindowposition
    HRESULT GetWindowPosition(int* pLeft, int* pTop, int* pWidth, int* pHeight);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ivideowindow-getminidealimagesize
    HRESULT GetMinIdealImageSize(int* pWidth, int* pHeight);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ivideowindow-getmaxidealimagesize
    HRESULT GetMaxIdealImageSize(int* pWidth, int* pHeight);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ivideowindow-getrestoreposition
    HRESULT GetRestorePosition(int* pLeft, int* pTop, int* pWidth, int* pHeight);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ivideowindow-hidecursor
    HRESULT HideCursor(OA_BOOL HideCursor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ivideowindow-iscursorhidden
    HRESULT IsCursorHidden(int* CursorHidden);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nn-control-ibasicvideo
@GUID("56a868b5-0ad4-11ce-b03a-0020af0ba770")
interface IBasicVideo : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ibasicvideo-get_avgtimeperframe
    HRESULT get_AvgTimePerFrame(double* pAvgTimePerFrame);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ibasicvideo-get_bitrate
    HRESULT get_BitRate(int* pBitRate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ibasicvideo-get_biterrorrate
    HRESULT get_BitErrorRate(int* pBitErrorRate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ibasicvideo-get_videowidth
    HRESULT get_VideoWidth(int* pVideoWidth);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ibasicvideo-get_videoheight
    HRESULT get_VideoHeight(int* pVideoHeight);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ibasicvideo-put_sourceleft
    HRESULT put_SourceLeft(int SourceLeft);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ibasicvideo-get_sourceleft
    HRESULT get_SourceLeft(int* pSourceLeft);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ibasicvideo-put_sourcewidth
    HRESULT put_SourceWidth(int SourceWidth);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ibasicvideo-get_sourcewidth
    HRESULT get_SourceWidth(int* pSourceWidth);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ibasicvideo-put_sourcetop
    HRESULT put_SourceTop(int SourceTop);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ibasicvideo-get_sourcetop
    HRESULT get_SourceTop(int* pSourceTop);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ibasicvideo-put_sourceheight
    HRESULT put_SourceHeight(int SourceHeight);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ibasicvideo-get_sourceheight
    HRESULT get_SourceHeight(int* pSourceHeight);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ibasicvideo-put_destinationleft
    HRESULT put_DestinationLeft(int DestinationLeft);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ibasicvideo-get_destinationleft
    HRESULT get_DestinationLeft(int* pDestinationLeft);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ibasicvideo-put_destinationwidth
    HRESULT put_DestinationWidth(int DestinationWidth);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ibasicvideo-get_destinationwidth
    HRESULT get_DestinationWidth(int* pDestinationWidth);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ibasicvideo-put_destinationtop
    HRESULT put_DestinationTop(int DestinationTop);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ibasicvideo-get_destinationtop
    HRESULT get_DestinationTop(int* pDestinationTop);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ibasicvideo-put_destinationheight
    HRESULT put_DestinationHeight(int DestinationHeight);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ibasicvideo-get_destinationheight
    HRESULT get_DestinationHeight(int* pDestinationHeight);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ibasicvideo-setsourceposition
    HRESULT SetSourcePosition(int Left, int Top, int Width, int Height);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ibasicvideo-getsourceposition
    HRESULT GetSourcePosition(int* pLeft, int* pTop, int* pWidth, int* pHeight);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ibasicvideo-setdefaultsourceposition
    HRESULT SetDefaultSourcePosition();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ibasicvideo-setdestinationposition
    HRESULT SetDestinationPosition(int Left, int Top, int Width, int Height);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ibasicvideo-getdestinationposition
    HRESULT GetDestinationPosition(int* pLeft, int* pTop, int* pWidth, int* pHeight);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ibasicvideo-setdefaultdestinationposition
    HRESULT SetDefaultDestinationPosition();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ibasicvideo-getvideosize
    HRESULT GetVideoSize(int* pWidth, int* pHeight);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ibasicvideo-getvideopaletteentries
    HRESULT GetVideoPaletteEntries(int StartIndex, int Entries, int* pRetrieved, int* pPalette);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ibasicvideo-getcurrentimage
    HRESULT GetCurrentImage(int* pBufferSize, int* pDIBImage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ibasicvideo-isusingdefaultsource
    HRESULT IsUsingDefaultSource();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ibasicvideo-isusingdefaultdestination
    HRESULT IsUsingDefaultDestination();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nn-control-ibasicvideo2
@GUID("329bb360-f6ea-11d1-9038-00a0c9697298")
interface IBasicVideo2 : IBasicVideo
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ibasicvideo2-getpreferredaspectratio
    HRESULT GetPreferredAspectRatio(int* plAspectX, int* plAspectY);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nn-control-ideferredcommand
@GUID("56a868b8-0ad4-11ce-b03a-0020af0ba770")
interface IDeferredCommand : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ideferredcommand-cancel
    HRESULT Cancel();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ideferredcommand-confidence
    HRESULT Confidence(int* pConfidence);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ideferredcommand-postpone
    HRESULT Postpone(double newtime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-ideferredcommand-gethresult
    HRESULT GetHResult(HRESULT* phrResult);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nn-control-iqueuecommand
@GUID("56a868b7-0ad4-11ce-b03a-0020af0ba770")
interface IQueueCommand : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-iqueuecommand-invokeatstreamtime
    HRESULT InvokeAtStreamTime(IDeferredCommand* pCmd, double time, GUID* iid, int dispidMethod, short wFlags, 
                               int cArgs, VARIANT* pDispParams, VARIANT* pvarResult, short* puArgErr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-iqueuecommand-invokeatpresentationtime
    HRESULT InvokeAtPresentationTime(IDeferredCommand* pCmd, double time, GUID* iid, int dispidMethod, 
                                     short wFlags, int cArgs, VARIANT* pDispParams, VARIANT* pvarResult, 
                                     short* puArgErr);
}

@GUID("56a868ba-0ad4-11ce-b03a-0020af0ba770")
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

@GUID("56a868bb-0ad4-11ce-b03a-0020af0ba770")
interface IRegFilterInfo : IDispatch
{
    HRESULT get_Name(BSTR* strName);
    HRESULT Filter(IDispatch* ppUnk);
}

@GUID("56a868bc-0ad4-11ce-b03a-0020af0ba770")
interface IMediaTypeInfo : IDispatch
{
    HRESULT get_Type(BSTR* strType);
    HRESULT get_Subtype(BSTR* strType);
}

@GUID("56a868bd-0ad4-11ce-b03a-0020af0ba770")
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

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nn-control-iamstats
@GUID("bc9bcf80-dcd2-11d2-abf6-00a0c905f375")
interface IAMStats : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-iamstats-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-iamstats-get_count
    HRESULT get_Count(int* plCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-iamstats-getvaluebyindex
    HRESULT GetValueByIndex(int lIndex, BSTR* szName, int* lCount, double* dLast, double* dAverage, 
                            double* dStdDev, double* dMin, double* dMax);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-iamstats-getvaluebyname
    HRESULT GetValueByName(BSTR szName, int* lIndex, int* lCount, double* dLast, double* dAverage, double* dStdDev, 
                           double* dMin, double* dMax);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-iamstats-getindex
    HRESULT GetIndex(BSTR szName, int lCreate, int* plIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/control/nf-control-iamstats-addvalue
    HRESULT AddValue(int lIndex, double dValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/videoacc/nn-videoacc-iamvideoacceleratornotify
@GUID("256a6a21-fbad-11d1-82bf-00a0c9696c8f")
interface IAMVideoAcceleratorNotify : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/videoacc/nf-videoacc-iamvideoacceleratornotify-getuncompsurfacesinfo
    HRESULT GetUncompSurfacesInfo(const(GUID)* pGuid, AMVAUncompBufferInfo* pUncompBufferInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/videoacc/nf-videoacc-iamvideoacceleratornotify-setuncompsurfacesinfo
    HRESULT SetUncompSurfacesInfo(uint dwActualUncompSurfacesAllocated);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/videoacc/nf-videoacc-iamvideoacceleratornotify-getcreatevideoacceleratordata
    HRESULT GetCreateVideoAcceleratorData(const(GUID)* pGuid, uint* pdwSizeMiscData, void** ppMiscData);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/videoacc/nn-videoacc-iamvideoaccelerator
@GUID("256a6a22-fbad-11d1-82bf-00a0c9696c8f")
interface IAMVideoAccelerator : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/videoacc/nf-videoacc-iamvideoaccelerator-getvideoacceleratorguids
    HRESULT GetVideoAcceleratorGUIDs(uint* pdwNumGuidsSupported, GUID* pGuidsSupported);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/videoacc/nf-videoacc-iamvideoaccelerator-getuncompformatssupported
    HRESULT GetUncompFormatsSupported(const(GUID)* pGuid, uint* pdwNumFormatsSupported, 
                                      DDPIXELFORMAT* pFormatsSupported);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/videoacc/nf-videoacc-iamvideoaccelerator-getinternalmeminfo
    HRESULT GetInternalMemInfo(const(GUID)* pGuid, const(AMVAUncompDataInfo)* pamvaUncompDataInfo, 
                               AMVAInternalMemInfo* pamvaInternalMemInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/videoacc/nf-videoacc-iamvideoaccelerator-getcompbufferinfo
    HRESULT GetCompBufferInfo(const(GUID)* pGuid, const(AMVAUncompDataInfo)* pamvaUncompDataInfo, 
                              uint* pdwNumTypesCompBuffers, AMVACompBufferInfo* pamvaCompBufferInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/videoacc/nf-videoacc-iamvideoaccelerator-getinternalcompbufferinfo
    HRESULT GetInternalCompBufferInfo(uint* pdwNumTypesCompBuffers, AMVACompBufferInfo* pamvaCompBufferInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/videoacc/nf-videoacc-iamvideoaccelerator-beginframe
    HRESULT BeginFrame(const(AMVABeginFrameInfo)* amvaBeginFrameInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/videoacc/nf-videoacc-iamvideoaccelerator-endframe
    HRESULT EndFrame(const(AMVAEndFrameInfo)* pEndFrameInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/videoacc/nf-videoacc-iamvideoaccelerator-getbuffer
    HRESULT GetBuffer(uint dwTypeIndex, uint dwBufferIndex, BOOL bReadOnly, void** ppBuffer, int* lpStride);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/videoacc/nf-videoacc-iamvideoaccelerator-releasebuffer
    HRESULT ReleaseBuffer(uint dwTypeIndex, uint dwBufferIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/videoacc/nf-videoacc-iamvideoaccelerator-execute
    HRESULT Execute(uint dwFunction, void* lpPrivateInputData, uint cbPrivateInputData, void* lpPrivateOutputDat, 
                    uint cbPrivateOutputData, uint dwNumBuffers, const(AMVABUFFERINFO)* pamvaBufferInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/videoacc/nf-videoacc-iamvideoaccelerator-queryrenderstatus
    HRESULT QueryRenderStatus(uint dwTypeIndex, uint dwBufferIndex, uint dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/videoacc/nf-videoacc-iamvideoaccelerator-displayframe
    HRESULT DisplayFrame(uint dwFlipToIndex, IMediaSample pMediaSample);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iwstdec/nn-iwstdec-iamwstdecoder
@GUID("c056de21-75c2-11d3-a184-00105aef9f33")
interface IAMWstDecoder : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iwstdec/nf-iwstdec-iamwstdecoder-getdecoderlevel
    HRESULT GetDecoderLevel(AM_WST_LEVEL* lpLevel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iwstdec/nf-iwstdec-iamwstdecoder-getcurrentservice
    HRESULT GetCurrentService(AM_WST_SERVICE* lpService);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iwstdec/nf-iwstdec-iamwstdecoder-getservicestate
    HRESULT GetServiceState(AM_WST_STATE* lpState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iwstdec/nf-iwstdec-iamwstdecoder-setservicestate
    HRESULT SetServiceState(AM_WST_STATE State);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iwstdec/nf-iwstdec-iamwstdecoder-getoutputformat
    HRESULT GetOutputFormat(BITMAPINFOHEADER* lpbmih);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iwstdec/nf-iwstdec-iamwstdecoder-setoutputformat
    HRESULT SetOutputFormat(BITMAPINFO* lpbmi);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iwstdec/nf-iwstdec-iamwstdecoder-getbackgroundcolor
    HRESULT GetBackgroundColor(uint* pdwPhysColor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iwstdec/nf-iwstdec-iamwstdecoder-setbackgroundcolor
    HRESULT SetBackgroundColor(uint dwPhysColor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iwstdec/nf-iwstdec-iamwstdecoder-getredrawalways
    HRESULT GetRedrawAlways(BOOL* lpbOption);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iwstdec/nf-iwstdec-iamwstdecoder-setredrawalways
    HRESULT SetRedrawAlways(BOOL bOption);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iwstdec/nf-iwstdec-iamwstdecoder-getdrawbackgroundmode
    HRESULT GetDrawBackgroundMode(AM_WST_DRAWBGMODE* lpMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iwstdec/nf-iwstdec-iamwstdecoder-setdrawbackgroundmode
    HRESULT SetDrawBackgroundMode(AM_WST_DRAWBGMODE Mode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iwstdec/nf-iwstdec-iamwstdecoder-setanswermode
    HRESULT SetAnswerMode(BOOL bAnswer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iwstdec/nf-iwstdec-iamwstdecoder-getanswermode
    HRESULT GetAnswerMode(BOOL* pbAnswer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iwstdec/nf-iwstdec-iamwstdecoder-setholdpage
    HRESULT SetHoldPage(BOOL bHoldPage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iwstdec/nf-iwstdec-iamwstdecoder-getholdpage
    HRESULT GetHoldPage(BOOL* pbHoldPage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iwstdec/nf-iwstdec-iamwstdecoder-getcurrentpage
    HRESULT GetCurrentPage(AM_WST_PAGE* pWstPage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iwstdec/nf-iwstdec-iamwstdecoder-setcurrentpage
    HRESULT SetCurrentPage(AM_WST_PAGE WstPage);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nn-vidcap-iselector
@GUID("1abdaeca-68b6-4f83-9371-b413907c7b9f")
interface ISelector : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-iselector-get_numsources
    HRESULT get_NumSources(uint* pdwNumSources);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-iselector-get_sourcenodeid
    HRESULT get_SourceNodeId(uint* pdwPinId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-iselector-put_sourcenodeid
    HRESULT put_SourceNodeId(uint dwPinId);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nn-vidcap-icameracontrol
@GUID("2ba1785d-4d1b-44ef-85e8-c7f1d3f20184")
interface ICameraControl : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-icameracontrol-get_exposure
    HRESULT get_Exposure(int* pValue, int* pFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-icameracontrol-put_exposure
    HRESULT put_Exposure(int Value, int Flags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-icameracontrol-getrange_exposure
    HRESULT getRange_Exposure(int* pMin, int* pMax, int* pSteppingDelta, int* pDefault, int* pCapsFlag);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-icameracontrol-get_focus
    HRESULT get_Focus(int* pValue, int* pFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-icameracontrol-put_focus
    HRESULT put_Focus(int Value, int Flags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-icameracontrol-getrange_focus
    HRESULT getRange_Focus(int* pMin, int* pMax, int* pSteppingDelta, int* pDefault, int* pCapsFlag);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-icameracontrol-get_iris
    HRESULT get_Iris(int* pValue, int* pFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-icameracontrol-put_iris
    HRESULT put_Iris(int Value, int Flags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-icameracontrol-getrange_iris
    HRESULT getRange_Iris(int* pMin, int* pMax, int* pSteppingDelta, int* pDefault, int* pCapsFlag);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-icameracontrol-get_zoom
    HRESULT get_Zoom(int* pValue, int* pFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-icameracontrol-put_zoom
    HRESULT put_Zoom(int Value, int Flags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-icameracontrol-getrange_zoom
    HRESULT getRange_Zoom(int* pMin, int* pMax, int* pSteppingDelta, int* pDefault, int* pCapsFlag);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-icameracontrol-get_focallengths
    HRESULT get_FocalLengths(int* plOcularFocalLength, int* plObjectiveFocalLengthMin, 
                             int* plObjectiveFocalLengthMax);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-icameracontrol-get_pan
    HRESULT get_Pan(int* pValue, int* pFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-icameracontrol-put_pan
    HRESULT put_Pan(int Value, int Flags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-icameracontrol-getrange_pan
    HRESULT getRange_Pan(int* pMin, int* pMax, int* pSteppingDelta, int* pDefault, int* pCapsFlag);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-icameracontrol-get_tilt
    HRESULT get_Tilt(int* pValue, int* pFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-icameracontrol-put_tilt
    HRESULT put_Tilt(int Value, int Flags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-icameracontrol-getrange_tilt
    HRESULT getRange_Tilt(int* pMin, int* pMax, int* pSteppingDelta, int* pDefault, int* pCapsFlag);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-icameracontrol-get_pantilt
    HRESULT get_PanTilt(int* pPanValue, int* pTiltValue, int* pFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-icameracontrol-put_pantilt
    HRESULT put_PanTilt(int PanValue, int TiltValue, int Flags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-icameracontrol-get_roll
    HRESULT get_Roll(int* pValue, int* pFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-icameracontrol-put_roll
    HRESULT put_Roll(int Value, int Flags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-icameracontrol-getrange_roll
    HRESULT getRange_Roll(int* pMin, int* pMax, int* pSteppingDelta, int* pDefault, int* pCapsFlag);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-icameracontrol-get_exposurerelative
    HRESULT get_ExposureRelative(int* pValue, int* pFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-icameracontrol-put_exposurerelative
    HRESULT put_ExposureRelative(int Value, int Flags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-icameracontrol-getrange_exposurerelative
    HRESULT getRange_ExposureRelative(int* pMin, int* pMax, int* pSteppingDelta, int* pDefault, int* pCapsFlag);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-icameracontrol-get_focusrelative
    HRESULT get_FocusRelative(int* pValue, int* pFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-icameracontrol-put_focusrelative
    HRESULT put_FocusRelative(int Value, int Flags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-icameracontrol-getrange_focusrelative
    HRESULT getRange_FocusRelative(int* pMin, int* pMax, int* pSteppingDelta, int* pDefault, int* pCapsFlag);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-icameracontrol-get_irisrelative
    HRESULT get_IrisRelative(int* pValue, int* pFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-icameracontrol-put_irisrelative
    HRESULT put_IrisRelative(int Value, int Flags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-icameracontrol-getrange_irisrelative
    HRESULT getRange_IrisRelative(int* pMin, int* pMax, int* pSteppingDelta, int* pDefault, int* pCapsFlag);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-icameracontrol-get_zoomrelative
    HRESULT get_ZoomRelative(int* pValue, int* pFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-icameracontrol-put_zoomrelative
    HRESULT put_ZoomRelative(int Value, int Flags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-icameracontrol-getrange_zoomrelative
    HRESULT getRange_ZoomRelative(int* pMin, int* pMax, int* pSteppingDelta, int* pDefault, int* pCapsFlag);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-icameracontrol-get_panrelative
    HRESULT get_PanRelative(int* pValue, int* pFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-icameracontrol-put_panrelative
    HRESULT put_PanRelative(int Value, int Flags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-icameracontrol-get_tiltrelative
    HRESULT get_TiltRelative(int* pValue, int* pFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-icameracontrol-put_tiltrelative
    HRESULT put_TiltRelative(int Value, int Flags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-icameracontrol-getrange_tiltrelative
    HRESULT getRange_TiltRelative(int* pMin, int* pMax, int* pSteppingDelta, int* pDefault, int* pCapsFlag);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-icameracontrol-get_pantiltrelative
    HRESULT get_PanTiltRelative(int* pPanValue, int* pTiltValue, int* pFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-icameracontrol-put_pantiltrelative
    HRESULT put_PanTiltRelative(int PanValue, int TiltValue, int Flags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-icameracontrol-getrange_panrelative
    HRESULT getRange_PanRelative(int* pMin, int* pMax, int* pSteppingDelta, int* pDefault, int* pCapsFlag);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-icameracontrol-get_rollrelative
    HRESULT get_RollRelative(int* pValue, int* pFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-icameracontrol-put_rollrelative
    HRESULT put_RollRelative(int Value, int Flags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-icameracontrol-getrange_rollrelative
    HRESULT getRange_RollRelative(int* pMin, int* pMax, int* pSteppingDelta, int* pDefault, int* pCapsFlag);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-icameracontrol-get_scanmode
    HRESULT get_ScanMode(int* pValue, int* pFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-icameracontrol-put_scanmode
    HRESULT put_ScanMode(int Value, int Flags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-icameracontrol-get_privacymode
    HRESULT get_PrivacyMode(int* pValue, int* pFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-icameracontrol-put_privacymode
    HRESULT put_PrivacyMode(int Value, int Flags);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nn-vidcap-ivideoprocamp
@GUID("4050560e-42a7-413a-85c2-09269a2d0f44")
interface IVideoProcAmp : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-ivideoprocamp-get_backlightcompensation
    HRESULT get_BacklightCompensation(int* pValue, int* pFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-ivideoprocamp-put_backlightcompensation
    HRESULT put_BacklightCompensation(int Value, int Flags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-ivideoprocamp-getrange_backlightcompensation
    HRESULT getRange_BacklightCompensation(int* pMin, int* pMax, int* pSteppingDelta, int* pDefault, 
                                           int* pCapsFlag);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-ivideoprocamp-get_brightness
    HRESULT get_Brightness(int* pValue, int* pFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-ivideoprocamp-put_brightness
    HRESULT put_Brightness(int Value, int Flags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-ivideoprocamp-getrange_brightness
    HRESULT getRange_Brightness(int* pMin, int* pMax, int* pSteppingDelta, int* pDefault, int* pCapsFlag);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-ivideoprocamp-get_colorenable
    HRESULT get_ColorEnable(int* pValue, int* pFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-ivideoprocamp-put_colorenable
    HRESULT put_ColorEnable(int Value, int Flags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-ivideoprocamp-getrange_colorenable
    HRESULT getRange_ColorEnable(int* pMin, int* pMax, int* pSteppingDelta, int* pDefault, int* pCapsFlag);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-ivideoprocamp-get_contrast
    HRESULT get_Contrast(int* pValue, int* pFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-ivideoprocamp-put_contrast
    HRESULT put_Contrast(int Value, int Flags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-ivideoprocamp-getrange_contrast
    HRESULT getRange_Contrast(int* pMin, int* pMax, int* pSteppingDelta, int* pDefault, int* pCapsFlag);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-ivideoprocamp-get_gamma
    HRESULT get_Gamma(int* pValue, int* pFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-ivideoprocamp-put_gamma
    HRESULT put_Gamma(int Value, int Flags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-ivideoprocamp-getrange_gamma
    HRESULT getRange_Gamma(int* pMin, int* pMax, int* pSteppingDelta, int* pDefault, int* pCapsFlag);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-ivideoprocamp-get_saturation
    HRESULT get_Saturation(int* pValue, int* pFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-ivideoprocamp-put_saturation
    HRESULT put_Saturation(int Value, int Flags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-ivideoprocamp-getrange_saturation
    HRESULT getRange_Saturation(int* pMin, int* pMax, int* pSteppingDelta, int* pDefault, int* pCapsFlag);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-ivideoprocamp-get_sharpness
    HRESULT get_Sharpness(int* pValue, int* pFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-ivideoprocamp-put_sharpness
    HRESULT put_Sharpness(int Value, int Flags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-ivideoprocamp-getrange_sharpness
    HRESULT getRange_Sharpness(int* pMin, int* pMax, int* pSteppingDelta, int* pDefault, int* pCapsFlag);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-ivideoprocamp-get_whitebalance
    HRESULT get_WhiteBalance(int* pValue, int* pFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-ivideoprocamp-put_whitebalance
    HRESULT put_WhiteBalance(int Value, int Flags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-ivideoprocamp-getrange_whitebalance
    HRESULT getRange_WhiteBalance(int* pMin, int* pMax, int* pSteppingDelta, int* pDefault, int* pCapsFlag);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-ivideoprocamp-get_gain
    HRESULT get_Gain(int* pValue, int* pFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-ivideoprocamp-put_gain
    HRESULT put_Gain(int Value, int Flags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-ivideoprocamp-getrange_gain
    HRESULT getRange_Gain(int* pMin, int* pMax, int* pSteppingDelta, int* pDefault, int* pCapsFlag);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-ivideoprocamp-get_hue
    HRESULT get_Hue(int* pValue, int* pFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-ivideoprocamp-put_hue
    HRESULT put_Hue(int Value, int Flags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-ivideoprocamp-getrange_hue
    HRESULT getRange_Hue(int* pMin, int* pMax, int* pSteppingDelta, int* pDefault, int* pCapsFlag);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-ivideoprocamp-get_digitalmultiplier
    HRESULT get_DigitalMultiplier(int* pValue, int* pFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-ivideoprocamp-put_digitalmultiplier
    HRESULT put_DigitalMultiplier(int Value, int Flags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-ivideoprocamp-getrange_digitalmultiplier
    HRESULT getRange_DigitalMultiplier(int* pMin, int* pMax, int* pSteppingDelta, int* pDefault, int* pCapsFlag);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-ivideoprocamp-get_powerlinefrequency
    HRESULT get_PowerlineFrequency(int* pValue, int* pFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-ivideoprocamp-put_powerlinefrequency
    HRESULT put_PowerlineFrequency(int Value, int Flags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-ivideoprocamp-getrange_powerlinefrequency
    HRESULT getRange_PowerlineFrequency(int* pMin, int* pMax, int* pSteppingDelta, int* pDefault, int* pCapsFlag);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-ivideoprocamp-get_whitebalancecomponent
    HRESULT get_WhiteBalanceComponent(int* pValue1, int* pValue2, int* pFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-ivideoprocamp-put_whitebalancecomponent
    HRESULT put_WhiteBalanceComponent(int Value1, int Value2, int Flags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vidcap/nf-vidcap-ivideoprocamp-getrange_whitebalancecomponent
    HRESULT getRange_WhiteBalanceComponent(int* pMin, int* pMax, int* pSteppingDelta, int* pDefault, 
                                           int* pCapsFlag);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dshowasf/nn-dshowasf-iamwmbufferpass
@GUID("6dd816d7-e740-4123-9e24-2444412644d8")
interface IAMWMBufferPass : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dshowasf/nf-dshowasf-iamwmbufferpass-setnotify
    HRESULT SetNotify(IAMWMBufferPassCallback pCallback);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dshowasf/nn-dshowasf-iamwmbufferpasscallback
@GUID("b25b8372-d2d2-44b2-8653-1b8dae332489")
interface IAMWMBufferPassCallback : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dshowasf/nf-dshowasf-iamwmbufferpasscallback-notify
    HRESULT Notify(INSSBuffer3 pNSSBuffer3, IPin pPin, long* prtStart, long* prtEnd);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dshowasf/nn-dshowasf-iconfigasfwriter
@GUID("45086030-f7e4-486a-b504-826bb5792a3b")
interface IConfigAsfWriter : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dshowasf/nf-dshowasf-iconfigasfwriter-configurefilterusingprofileid
    HRESULT ConfigureFilterUsingProfileId(uint dwProfileId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dshowasf/nf-dshowasf-iconfigasfwriter-getcurrentprofileid
    HRESULT GetCurrentProfileId(uint* pdwProfileId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dshowasf/nf-dshowasf-iconfigasfwriter-configurefilterusingprofileguid
    HRESULT ConfigureFilterUsingProfileGuid(const(GUID)* guidProfile);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dshowasf/nf-dshowasf-iconfigasfwriter-getcurrentprofileguid
    HRESULT GetCurrentProfileGuid(GUID* pProfileGuid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dshowasf/nf-dshowasf-iconfigasfwriter-configurefilterusingprofile
    HRESULT ConfigureFilterUsingProfile(IWMProfile pProfile);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dshowasf/nf-dshowasf-iconfigasfwriter-getcurrentprofile
    HRESULT GetCurrentProfile(IWMProfile* ppProfile);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dshowasf/nf-dshowasf-iconfigasfwriter-setindexmode
    HRESULT SetIndexMode(BOOL bIndexFile);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dshowasf/nf-dshowasf-iconfigasfwriter-getindexmode
    HRESULT GetIndexMode(BOOL* pbIndexFile);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dshowasf/nn-dshowasf-iconfigasfwriter2
@GUID("7989ccaa-53f0-44f0-884a-f3b03f6ae066")
interface IConfigAsfWriter2 : IConfigAsfWriter
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dshowasf/nf-dshowasf-iconfigasfwriter2-streamnumfrompin
    HRESULT StreamNumFromPin(IPin pPin, ushort* pwStreamNum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dshowasf/nf-dshowasf-iconfigasfwriter2-setparam
    HRESULT SetParam(uint dwParam, uint dwParam1, uint dwParam2);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dshowasf/nf-dshowasf-iconfigasfwriter2-getparam
    HRESULT GetParam(uint dwParam, uint* pdwParam1, uint* pdwParam2);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dshowasf/nf-dshowasf-iconfigasfwriter2-resetmultipassstate
    HRESULT ResetMultiPassState();
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmstream/nn-mmstream-imultimediastream
@GUID("b502d1bc-9a57-11d0-8fde-00c04fd9189d")
interface IMultiMediaStream : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmstream/nf-mmstream-imultimediastream-getinformation
    HRESULT GetInformation(MMSSF_GET_INFORMATION_FLAGS* pdwFlags, STREAM_TYPE* pStreamType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmstream/nf-mmstream-imultimediastream-getmediastream
    HRESULT GetMediaStream(GUID* idPurpose, IMediaStream* ppMediaStream);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmstream/nf-mmstream-imultimediastream-enummediastreams
    HRESULT EnumMediaStreams(int Index, IMediaStream* ppMediaStream);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmstream/nf-mmstream-imultimediastream-getstate
    HRESULT GetState(STREAM_STATE* pCurrentState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmstream/nf-mmstream-imultimediastream-setstate
    HRESULT SetState(STREAM_STATE NewState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmstream/nf-mmstream-imultimediastream-gettime
    HRESULT GetTime(long* pCurrentTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmstream/nf-mmstream-imultimediastream-getduration
    HRESULT GetDuration(long* pDuration);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmstream/nf-mmstream-imultimediastream-seek
    HRESULT Seek(long SeekTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmstream/nf-mmstream-imultimediastream-getendofstreameventhandle
    HRESULT GetEndOfStreamEventHandle(HANDLE* phEOS);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmstream/nn-mmstream-imediastream
@GUID("b502d1bd-9a57-11d0-8fde-00c04fd9189d")
interface IMediaStream : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmstream/nf-mmstream-imediastream-getmultimediastream
    HRESULT GetMultiMediaStream(IMultiMediaStream* ppMultiMediaStream);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmstream/nf-mmstream-imediastream-getinformation
    HRESULT GetInformation(GUID* pPurposeId, STREAM_TYPE* pType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmstream/nf-mmstream-imediastream-setsameformat
    HRESULT SetSameFormat(IMediaStream pStreamThatHasDesiredFormat, uint dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmstream/nf-mmstream-imediastream-allocatesample
    HRESULT AllocateSample(uint dwFlags, IStreamSample* ppSample);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmstream/nf-mmstream-imediastream-createsharedsample
    HRESULT CreateSharedSample(IStreamSample pExistingSample, uint dwFlags, IStreamSample* ppNewSample);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmstream/nf-mmstream-imediastream-sendendofstream
    HRESULT SendEndOfStream(uint dwFlags);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmstream/nn-mmstream-istreamsample
@GUID("b502d1be-9a57-11d0-8fde-00c04fd9189d")
interface IStreamSample : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmstream/nf-mmstream-istreamsample-getmediastream
    HRESULT GetMediaStream(IMediaStream* ppMediaStream);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmstream/nf-mmstream-istreamsample-getsampletimes
    HRESULT GetSampleTimes(long* pStartTime, long* pEndTime, long* pCurrentTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmstream/nf-mmstream-istreamsample-setsampletimes
    HRESULT SetSampleTimes(const(long)* pStartTime, const(long)* pEndTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmstream/nf-mmstream-istreamsample-update
    HRESULT Update(uint dwFlags, HANDLE hEvent, PAPCFUNC pfnAPC, size_t dwAPCData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmstream/nf-mmstream-istreamsample-completionstatus
    HRESULT CompletionStatus(uint dwFlags, uint dwMilliseconds);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ddstream/nn-ddstream-idirectdrawmediastream
@GUID("f4104fce-9a70-11d0-8fde-00c04fd9189d")
interface IDirectDrawMediaStream : IMediaStream
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ddstream/nf-ddstream-idirectdrawmediastream-getformat
    HRESULT GetFormat(DDSURFACEDESC* pDDSDCurrent, IDirectDrawPalette* ppDirectDrawPalette, 
                      DDSURFACEDESC* pDDSDDesired, uint* pdwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ddstream/nf-ddstream-idirectdrawmediastream-setformat
    HRESULT SetFormat(const(DDSURFACEDESC)* pDDSurfaceDesc, IDirectDrawPalette pDirectDrawPalette);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ddstream/nf-ddstream-idirectdrawmediastream-getdirectdraw
    HRESULT GetDirectDraw(IDirectDraw* ppDirectDraw);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ddstream/nf-ddstream-idirectdrawmediastream-setdirectdraw
    HRESULT SetDirectDraw(IDirectDraw pDirectDraw);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ddstream/nf-ddstream-idirectdrawmediastream-createsample
    HRESULT CreateSample(IDirectDrawSurface pSurface, const(RECT)* pRect, uint dwFlags, 
                         IDirectDrawStreamSample* ppSample);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ddstream/nf-ddstream-idirectdrawmediastream-gettimeperframe
    HRESULT GetTimePerFrame(long* pFrameTime);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ddstream/nn-ddstream-idirectdrawstreamsample
@GUID("f4104fcf-9a70-11d0-8fde-00c04fd9189d")
interface IDirectDrawStreamSample : IStreamSample
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ddstream/nf-ddstream-idirectdrawstreamsample-getsurface
    HRESULT GetSurface(IDirectDrawSurface* ppDirectDrawSurface, RECT* pRect);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ddstream/nf-ddstream-idirectdrawstreamsample-setrect
    HRESULT SetRect(const(RECT)* pRect);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/austream/nn-austream-iaudiomediastream
@GUID("f7537560-a3be-11d0-8212-00c04fc32c45")
interface IAudioMediaStream : IMediaStream
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/austream/nf-austream-iaudiomediastream-getformat
    HRESULT GetFormat(WAVEFORMATEX* pWaveFormatCurrent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/austream/nf-austream-iaudiomediastream-setformat
    HRESULT SetFormat(const(WAVEFORMATEX)* lpWaveFormat);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/austream/nf-austream-iaudiomediastream-createsample
    HRESULT CreateSample(IAudioData pAudioData, uint dwFlags, IAudioStreamSample* ppSample);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/austream/nn-austream-iaudiostreamsample
@GUID("345fee00-aba5-11d0-8212-00c04fc32c45")
interface IAudioStreamSample : IStreamSample
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/austream/nf-austream-iaudiostreamsample-getaudiodata
    HRESULT GetAudioData(IAudioData* ppAudio);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/austream/nn-austream-imemorydata
@GUID("327fc560-af60-11d0-8212-00c04fc32c45")
interface IMemoryData : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/austream/nf-austream-imemorydata-setbuffer
    HRESULT SetBuffer(uint cbSize, ubyte* pbData, uint dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/austream/nf-austream-imemorydata-getinfo
    HRESULT GetInfo(uint* pdwLength, ubyte** ppbData, uint* pcbActualData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/austream/nf-austream-imemorydata-setactual
    HRESULT SetActual(uint cbDataValid);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/austream/nn-austream-iaudiodata
@GUID("54c719c0-af60-11d0-8212-00c04fc32c45")
interface IAudioData : IMemoryData
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/austream/nf-austream-iaudiodata-getformat
    HRESULT GetFormat(WAVEFORMATEX* pWaveFormatCurrent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/austream/nf-austream-iaudiodata-setformat
    HRESULT SetFormat(const(WAVEFORMATEX)* lpWaveFormat);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amstream/nn-amstream-iammultimediastream
@GUID("bebe595c-9a6f-11d0-8fde-00c04fd9189d")
interface IAMMultiMediaStream : IMultiMediaStream
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amstream/nf-amstream-iammultimediastream-initialize
    HRESULT Initialize(STREAM_TYPE StreamType, 
                       /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(AMMSF_MMS_INIT_FLAGS))], [])*/uint dwFlags, 
                       IGraphBuilder pFilterGraph);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amstream/nf-amstream-iammultimediastream-getfiltergraph
    HRESULT GetFilterGraph(IGraphBuilder* ppGraphBuilder);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amstream/nf-amstream-iammultimediastream-getfilter
    HRESULT GetFilter(IMediaStreamFilter* ppFilter);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amstream/nf-amstream-iammultimediastream-addmediastream
    HRESULT AddMediaStream(IUnknown pStreamObject, const(GUID)* PurposeId, 
                           /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(AMMSF_MS_FLAGS))], [])*/uint dwFlags, 
                           IMediaStream* ppNewStream);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amstream/nf-amstream-iammultimediastream-openfile
    HRESULT OpenFile(const(PWSTR) pszFileName, uint dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amstream/nf-amstream-iammultimediastream-openmoniker
    HRESULT OpenMoniker(IBindCtx pCtx, IMoniker pMoniker, uint dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amstream/nf-amstream-iammultimediastream-render
    HRESULT Render(uint dwFlags);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amstream/nn-amstream-iammediastream
@GUID("bebe595d-9a6f-11d0-8fde-00c04fd9189d")
interface IAMMediaStream : IMediaStream
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amstream/nf-amstream-iammediastream-initialize
    HRESULT Initialize(IUnknown pSourceObject, uint dwFlags, GUID* PurposeId, const(STREAM_TYPE) StreamType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amstream/nf-amstream-iammediastream-setstate
    HRESULT SetState(FILTER_STATE State);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amstream/nf-amstream-iammediastream-joinammultimediastream
    HRESULT JoinAMMultiMediaStream(IAMMultiMediaStream pAMMultiMediaStream);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amstream/nf-amstream-iammediastream-joinfilter
    HRESULT JoinFilter(IMediaStreamFilter pMediaStreamFilter);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amstream/nf-amstream-iammediastream-joinfiltergraph
    HRESULT JoinFilterGraph(IFilterGraph pFilterGraph);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amstream/nn-amstream-imediastreamfilter
@GUID("bebe595e-9a6f-11d0-8fde-00c04fd9189d")
interface IMediaStreamFilter : IBaseFilter
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amstream/nf-amstream-imediastreamfilter-addmediastream
    HRESULT AddMediaStream(IAMMediaStream pAMMediaStream);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amstream/nf-amstream-imediastreamfilter-getmediastream
    HRESULT GetMediaStream(GUID* idPurpose, IMediaStream* ppMediaStream);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amstream/nf-amstream-imediastreamfilter-enummediastreams
    HRESULT EnumMediaStreams(int Index, IMediaStream* ppMediaStream);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amstream/nf-amstream-imediastreamfilter-supportseeking
    HRESULT SupportSeeking(BOOL bRenderer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amstream/nf-amstream-imediastreamfilter-referencetimetostreamtime
    HRESULT ReferenceTimeToStreamTime(long* pTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amstream/nf-amstream-imediastreamfilter-getcurrentstreamtime
    HRESULT GetCurrentStreamTime(long* pCurrentStreamTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amstream/nf-amstream-imediastreamfilter-waituntil
    HRESULT WaitUntil(long WaitStreamTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amstream/nf-amstream-imediastreamfilter-flush
    HRESULT Flush(BOOL bCancelEOS);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amstream/nf-amstream-imediastreamfilter-endofstream
    HRESULT EndOfStream();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amstream/nn-amstream-idirectdrawmediasampleallocator
@GUID("ab6b4afc-f6e4-11d0-900d-00c04fd9189d")
interface IDirectDrawMediaSampleAllocator : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amstream/nf-amstream-idirectdrawmediasampleallocator-getdirectdraw
    HRESULT GetDirectDraw(IDirectDraw* ppDirectDraw);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amstream/nn-amstream-idirectdrawmediasample
@GUID("ab6b4afe-f6e4-11d0-900d-00c04fd9189d")
interface IDirectDrawMediaSample : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amstream/nf-amstream-idirectdrawmediasample-getsurfaceandreleaselock
    HRESULT GetSurfaceAndReleaseLock(IDirectDrawSurface* ppDirectDrawSurface, RECT* pRect);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amstream/nf-amstream-idirectdrawmediasample-lockmediasamplepointer
    HRESULT LockMediaSamplePointer();
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amstream/nn-amstream-iammediatypestream
@GUID("ab6b4afa-f6e4-11d0-900d-00c04fd9189d")
interface IAMMediaTypeStream : IMediaStream
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amstream/nf-amstream-iammediatypestream-getformat
    HRESULT GetFormat(AM_MEDIA_TYPE* pMediaType, uint dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amstream/nf-amstream-iammediatypestream-setformat
    HRESULT SetFormat(AM_MEDIA_TYPE* pMediaType, uint dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amstream/nf-amstream-iammediatypestream-createsample
    HRESULT CreateSample(int lSampleSize, ubyte* pbBuffer, uint dwFlags, IUnknown pUnkOuter, 
                         IAMMediaTypeSample* ppAMMediaTypeSample);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amstream/nf-amstream-iammediatypestream-getstreamallocatorrequirements
    HRESULT GetStreamAllocatorRequirements(ALLOCATOR_PROPERTIES* pProps);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amstream/nf-amstream-iammediatypestream-setstreamallocatorrequirements
    HRESULT SetStreamAllocatorRequirements(ALLOCATOR_PROPERTIES* pProps);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amstream/nn-amstream-iammediatypesample
@GUID("ab6b4afb-f6e4-11d0-900d-00c04fd9189d")
interface IAMMediaTypeSample : IStreamSample
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amstream/nf-amstream-iammediatypesample-setpointer
    HRESULT SetPointer(ubyte* pBuffer, int lSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amstream/nf-amstream-iammediatypesample-getpointer
    HRESULT GetPointer(ubyte** ppBuffer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amstream/nf-amstream-iammediatypesample-getsize
    int     GetSize();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amstream/nf-amstream-iammediatypesample-gettime
    HRESULT GetTime(long* pTimeStart, long* pTimeEnd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amstream/nf-amstream-iammediatypesample-settime
    HRESULT SetTime(long* pTimeStart, long* pTimeEnd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amstream/nf-amstream-iammediatypesample-issyncpoint
    HRESULT IsSyncPoint();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amstream/nf-amstream-iammediatypesample-setsyncpoint
    HRESULT SetSyncPoint(BOOL bIsSyncPoint);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amstream/nf-amstream-iammediatypesample-ispreroll
    HRESULT IsPreroll();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amstream/nf-amstream-iammediatypesample-setpreroll
    HRESULT SetPreroll(BOOL bIsPreroll);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amstream/nf-amstream-iammediatypesample-getactualdatalength
    int     GetActualDataLength();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amstream/nf-amstream-iammediatypesample-setactualdatalength
    HRESULT SetActualDataLength(int __MIDL__IAMMediaTypeSample0000);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amstream/nf-amstream-iammediatypesample-getmediatype
    HRESULT GetMediaType(AM_MEDIA_TYPE** ppMediaType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amstream/nf-amstream-iammediatypesample-setmediatype
    HRESULT SetMediaType(AM_MEDIA_TYPE* pMediaType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amstream/nf-amstream-iammediatypesample-isdiscontinuity
    HRESULT IsDiscontinuity();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amstream/nf-amstream-iammediatypesample-setdiscontinuity
    HRESULT SetDiscontinuity(BOOL bDiscontinuity);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amstream/nf-amstream-iammediatypesample-getmediatime
    HRESULT GetMediaTime(long* pTimeStart, long* pTimeEnd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amstream/nf-amstream-iammediatypesample-setmediatime
    HRESULT SetMediaTime(long* pTimeStart, long* pTimeEnd);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amvideo/nn-amvideo-idirectdrawvideo
@GUID("36d39eb0-dd75-11ce-bf0e-00aa0055595a")
interface IDirectDrawVideo : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amvideo/nf-amvideo-idirectdrawvideo-getswitches
    HRESULT GetSwitches(uint* pSwitches);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amvideo/nf-amvideo-idirectdrawvideo-setswitches
    HRESULT SetSwitches(uint Switches);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amvideo/nf-amvideo-idirectdrawvideo-getcaps
    HRESULT GetCaps(DDCAPS_DX7* pCaps);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amvideo/nf-amvideo-idirectdrawvideo-getemulatedcaps
    HRESULT GetEmulatedCaps(DDCAPS_DX7* pCaps);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amvideo/nf-amvideo-idirectdrawvideo-getsurfacedesc
    HRESULT GetSurfaceDesc(DDSURFACEDESC* pSurfaceDesc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amvideo/nf-amvideo-idirectdrawvideo-getfourcccodes
    HRESULT GetFourCCCodes(uint* pCount, uint* pCodes);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amvideo/nf-amvideo-idirectdrawvideo-setdirectdraw
    HRESULT SetDirectDraw(IDirectDraw pDirectDraw);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amvideo/nf-amvideo-idirectdrawvideo-getdirectdraw
    HRESULT GetDirectDraw(IDirectDraw* ppDirectDraw);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amvideo/nf-amvideo-idirectdrawvideo-getsurfacetype
    HRESULT GetSurfaceType(uint* pSurfaceType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amvideo/nf-amvideo-idirectdrawvideo-setdefault
    HRESULT SetDefault();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amvideo/nf-amvideo-idirectdrawvideo-usescanline
    HRESULT UseScanLine(int UseScanLine);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amvideo/nf-amvideo-idirectdrawvideo-canusescanline
    HRESULT CanUseScanLine(int* UseScanLine);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amvideo/nf-amvideo-idirectdrawvideo-useoverlaystretch
    HRESULT UseOverlayStretch(int UseOverlayStretch);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amvideo/nf-amvideo-idirectdrawvideo-canuseoverlaystretch
    HRESULT CanUseOverlayStretch(int* UseOverlayStretch);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amvideo/nf-amvideo-idirectdrawvideo-usewhenfullscreen
    HRESULT UseWhenFullScreen(int UseWhenFullScreen);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amvideo/nf-amvideo-idirectdrawvideo-willusefullscreen
    HRESULT WillUseFullScreen(int* UseWhenFullScreen);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amvideo/nn-amvideo-iqualprop
@GUID("1bd0ecb0-f8e2-11ce-aac6-0020af0b99a3")
interface IQualProp : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amvideo/nf-amvideo-iqualprop-get_framesdroppedinrenderer
    HRESULT get_FramesDroppedInRenderer(int* pcFrames);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amvideo/nf-amvideo-iqualprop-get_framesdrawn
    HRESULT get_FramesDrawn(int* pcFramesDrawn);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amvideo/nf-amvideo-iqualprop-get_avgframerate
    HRESULT get_AvgFrameRate(int* piAvgFrameRate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amvideo/nf-amvideo-iqualprop-get_jitter
    HRESULT get_Jitter(int* iJitter);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amvideo/nf-amvideo-iqualprop-get_avgsyncoffset
    HRESULT get_AvgSyncOffset(int* piAvg);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amvideo/nf-amvideo-iqualprop-get_devsyncoffset
    HRESULT get_DevSyncOffset(int* piDev);
}

@GUID("dd1d7110-7836-11cf-bf47-00aa0055595a")
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

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amvideo/nn-amvideo-ifullscreenvideoex
@GUID("53479470-f1dd-11cf-bc42-00aa00ac74f6")
interface IFullScreenVideoEx : IFullScreenVideo
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amvideo/nf-amvideo-ifullscreenvideoex-setacceleratortable
    HRESULT SetAcceleratorTable(HWND hwnd, HACCEL hAccel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amvideo/nf-amvideo-ifullscreenvideoex-getacceleratortable
    HRESULT GetAcceleratorTable(HWND* phwnd, HACCEL* phAccel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amvideo/nf-amvideo-ifullscreenvideoex-keeppixelaspectratio
    HRESULT KeepPixelAspectRatio(int KeepAspect);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/amvideo/nf-amvideo-ifullscreenvideoex-iskeeppixelaspectratio
    HRESULT IsKeepPixelAspectRatio(int* pKeepAspect);
}

@GUID("61ded640-e912-11ce-a099-00aa00479a58")
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

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dmodshow/nn-dmodshow-idmowrapperfilter
@GUID("52d6f586-9f0f-4824-8fc8-e32ca04930c2")
interface IDMOWrapperFilter : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dmodshow/nf-dmodshow-idmowrapperfilter-init
    HRESULT Init(const(GUID)* clsidDMO, const(GUID)* catDMO);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mixerocx/nn-mixerocx-imixerocxnotify
@GUID("81a3bd31-dee1-11d1-8508-00a0c91f9ca0")
interface IMixerOCXNotify : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mixerocx/nf-mixerocx-imixerocxnotify-oninvalidaterect
    HRESULT OnInvalidateRect(RECT* lpcRect);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mixerocx/nf-mixerocx-imixerocxnotify-onstatuschange
    HRESULT OnStatusChange(uint ulStatusFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mixerocx/nf-mixerocx-imixerocxnotify-ondatachange
    HRESULT OnDataChange(uint ulDataFlags);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mixerocx/nn-mixerocx-imixerocx
@GUID("81a3bd32-dee1-11d1-8508-00a0c91f9ca0")
interface IMixerOCX : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mixerocx/nf-mixerocx-imixerocx-ondisplaychange
    HRESULT OnDisplayChange(uint ulBitsPerPixel, uint ulScreenWidth, uint ulScreenHeight);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mixerocx/nf-mixerocx-imixerocx-getaspectratio
    HRESULT GetAspectRatio(uint* pdwPictAspectRatioX, uint* pdwPictAspectRatioY);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mixerocx/nf-mixerocx-imixerocx-getvideosize
    HRESULT GetVideoSize(uint* pdwVideoWidth, uint* pdwVideoHeight);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mixerocx/nf-mixerocx-imixerocx-getstatus
    HRESULT GetStatus(uint** pdwStatus);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mixerocx/nf-mixerocx-imixerocx-ondraw
    HRESULT OnDraw(HDC hdcDraw, RECT* prcDraw);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mixerocx/nf-mixerocx-imixerocx-setdrawregion
    HRESULT SetDrawRegion(POINT* lpptTopLeftSC, RECT* prcDrawCC, RECT* lprcClip);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mixerocx/nf-mixerocx-imixerocx-advise
    HRESULT Advise(IMixerOCXNotify pmdns);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mixerocx/nf-mixerocx-imixerocx-unadvise
    HRESULT UnAdvise();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpconfig/nn-mpconfig-imixerpinconfig
@GUID("593cdde1-0759-11d1-9e69-00c04fd7c15b")
interface IMixerPinConfig : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpconfig/nf-mpconfig-imixerpinconfig-setrelativeposition
    HRESULT SetRelativePosition(uint dwLeft, uint dwTop, uint dwRight, uint dwBottom);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpconfig/nf-mpconfig-imixerpinconfig-getrelativeposition
    HRESULT GetRelativePosition(uint* pdwLeft, uint* pdwTop, uint* pdwRight, uint* pdwBottom);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpconfig/nf-mpconfig-imixerpinconfig-setzorder
    HRESULT SetZOrder(uint dwZOrder);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpconfig/nf-mpconfig-imixerpinconfig-getzorder
    HRESULT GetZOrder(uint* pdwZOrder);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpconfig/nf-mpconfig-imixerpinconfig-setcolorkey
    HRESULT SetColorKey(COLORKEY* pColorKey);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpconfig/nf-mpconfig-imixerpinconfig-getcolorkey
    HRESULT GetColorKey(COLORKEY* pColorKey, uint* pColor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpconfig/nf-mpconfig-imixerpinconfig-setblendingparameter
    HRESULT SetBlendingParameter(uint dwBlendingParameter);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpconfig/nf-mpconfig-imixerpinconfig-getblendingparameter
    HRESULT GetBlendingParameter(uint* pdwBlendingParameter);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpconfig/nf-mpconfig-imixerpinconfig-setaspectratiomode
    HRESULT SetAspectRatioMode(AM_ASPECT_RATIO_MODE amAspectRatioMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpconfig/nf-mpconfig-imixerpinconfig-getaspectratiomode
    HRESULT GetAspectRatioMode(AM_ASPECT_RATIO_MODE* pamAspectRatioMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpconfig/nf-mpconfig-imixerpinconfig-setstreamtransparent
    HRESULT SetStreamTransparent(BOOL bStreamTransparent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpconfig/nf-mpconfig-imixerpinconfig-getstreamtransparent
    HRESULT GetStreamTransparent(BOOL* pbStreamTransparent);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpconfig/nn-mpconfig-imixerpinconfig2
@GUID("ebf47182-8764-11d1-9e69-00c04fd7c15b")
interface IMixerPinConfig2 : IMixerPinConfig
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpconfig/nf-mpconfig-imixerpinconfig2-setoverlaysurfacecolorcontrols
    HRESULT SetOverlaySurfaceColorControls(DDCOLORCONTROL* pColorControl);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpconfig/nf-mpconfig-imixerpinconfig2-getoverlaysurfacecolorcontrols
    HRESULT GetOverlaySurfaceColorControls(DDCOLORCONTROL* pColorControl);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpegtype/nn-mpegtype-impegaudiodecoder
@GUID("b45dd570-3c77-11d1-abe1-00a0c905f375")
interface IMpegAudioDecoder : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpegtype/nf-mpegtype-impegaudiodecoder-get_frequencydivider
    HRESULT get_FrequencyDivider(uint* pDivider);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpegtype/nf-mpegtype-impegaudiodecoder-put_frequencydivider
    HRESULT put_FrequencyDivider(uint Divider);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpegtype/nf-mpegtype-impegaudiodecoder-get_decoderaccuracy
    HRESULT get_DecoderAccuracy(uint* pAccuracy);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpegtype/nf-mpegtype-impegaudiodecoder-put_decoderaccuracy
    HRESULT put_DecoderAccuracy(uint Accuracy);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpegtype/nf-mpegtype-impegaudiodecoder-get_stereo
    HRESULT get_Stereo(uint* pStereo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpegtype/nf-mpegtype-impegaudiodecoder-put_stereo
    HRESULT put_Stereo(uint Stereo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpegtype/nf-mpegtype-impegaudiodecoder-get_decoderwordsize
    HRESULT get_DecoderWordSize(uint* pWordSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpegtype/nf-mpegtype-impegaudiodecoder-put_decoderwordsize
    HRESULT put_DecoderWordSize(uint WordSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpegtype/nf-mpegtype-impegaudiodecoder-get_integerdecode
    HRESULT get_IntegerDecode(uint* pIntDecode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpegtype/nf-mpegtype-impegaudiodecoder-put_integerdecode
    HRESULT put_IntegerDecode(uint IntDecode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpegtype/nf-mpegtype-impegaudiodecoder-get_dualmode
    HRESULT get_DualMode(uint* pIntDecode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpegtype/nf-mpegtype-impegaudiodecoder-put_dualmode
    HRESULT put_DualMode(uint IntDecode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpegtype/nf-mpegtype-impegaudiodecoder-get_audioformat
    HRESULT get_AudioFormat(MPEG1WAVEFORMAT* lpFmt);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nn-vmr9-ivmrimagepresenter9
@GUID("69188c61-12a3-40f0-8ffc-342e7b433fd7")
interface IVMRImagePresenter9 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrimagepresenter9-startpresenting
    HRESULT StartPresenting(size_t dwUserID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrimagepresenter9-stoppresenting
    HRESULT StopPresenting(size_t dwUserID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrimagepresenter9-presentimage
    HRESULT PresentImage(size_t dwUserID, VMR9PresentationInfo* lpPresInfo);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nn-vmr9-ivmrsurfaceallocator9
@GUID("8d5148ea-3f5d-46cf-9df1-d1b896eedb1f")
interface IVMRSurfaceAllocator9 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrsurfaceallocator9-initializedevice
    HRESULT InitializeDevice(size_t dwUserID, VMR9AllocationInfo* lpAllocInfo, uint* lpNumBuffers);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrsurfaceallocator9-terminatedevice
    HRESULT TerminateDevice(size_t dwID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrsurfaceallocator9-getsurface
    HRESULT GetSurface(size_t dwUserID, uint SurfaceIndex, uint SurfaceFlags, IDirect3DSurface9* lplpSurface);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrsurfaceallocator9-advisenotify
    HRESULT AdviseNotify(IVMRSurfaceAllocatorNotify9 lpIVMRSurfAllocNotify);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nn-vmr9-ivmrsurfaceallocatorex9
@GUID("6de9a68a-a928-4522-bf57-655ae3866456")
interface IVMRSurfaceAllocatorEx9 : IVMRSurfaceAllocator9
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrsurfaceallocatorex9-getsurfaceex
    HRESULT GetSurfaceEx(size_t dwUserID, uint SurfaceIndex, uint SurfaceFlags, IDirect3DSurface9* lplpSurface, 
                         RECT* lprcDst);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nn-vmr9-ivmrsurfaceallocatornotify9
@GUID("dca3f5df-bb3a-4d03-bd81-84614bfbfa0c")
interface IVMRSurfaceAllocatorNotify9 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrsurfaceallocatornotify9-advisesurfaceallocator
    HRESULT AdviseSurfaceAllocator(size_t dwUserID, IVMRSurfaceAllocator9 lpIVRMSurfaceAllocator);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrsurfaceallocatornotify9-setd3ddevice
    HRESULT SetD3DDevice(IDirect3DDevice9 lpD3DDevice, HMONITOR hMonitor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrsurfaceallocatornotify9-changed3ddevice
    HRESULT ChangeD3DDevice(IDirect3DDevice9 lpD3DDevice, HMONITOR hMonitor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrsurfaceallocatornotify9-allocatesurfacehelper
    HRESULT AllocateSurfaceHelper(VMR9AllocationInfo* lpAllocInfo, uint* lpNumBuffers, 
                                  IDirect3DSurface9* lplpSurface);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrsurfaceallocatornotify9-notifyevent
    HRESULT NotifyEvent(int EventCode, ptrdiff_t Param1, ptrdiff_t Param2);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nn-vmr9-ivmrwindowlesscontrol9
@GUID("8f537d09-f85e-4414-b23b-502e54c79927")
interface IVMRWindowlessControl9 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrwindowlesscontrol9-getnativevideosize
    HRESULT GetNativeVideoSize(int* lpWidth, int* lpHeight, int* lpARWidth, int* lpARHeight);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrwindowlesscontrol9-getminidealvideosize
    HRESULT GetMinIdealVideoSize(int* lpWidth, int* lpHeight);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrwindowlesscontrol9-getmaxidealvideosize
    HRESULT GetMaxIdealVideoSize(int* lpWidth, int* lpHeight);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrwindowlesscontrol9-setvideoposition
    HRESULT SetVideoPosition(const(RECT)* lpSRCRect, const(RECT)* lpDSTRect);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrwindowlesscontrol9-getvideoposition
    HRESULT GetVideoPosition(RECT* lpSRCRect, RECT* lpDSTRect);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrwindowlesscontrol9-getaspectratiomode
    HRESULT GetAspectRatioMode(uint* lpAspectRatioMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrwindowlesscontrol9-setaspectratiomode
    HRESULT SetAspectRatioMode(uint AspectRatioMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrwindowlesscontrol9-setvideoclippingwindow
    HRESULT SetVideoClippingWindow(HWND hwnd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrwindowlesscontrol9-repaintvideo
    HRESULT RepaintVideo(HWND hwnd, HDC hdc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrwindowlesscontrol9-displaymodechanged
    HRESULT DisplayModeChanged();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrwindowlesscontrol9-getcurrentimage
    HRESULT GetCurrentImage(ubyte** lpDib);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrwindowlesscontrol9-setbordercolor
    HRESULT SetBorderColor(COLORREF Clr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrwindowlesscontrol9-getbordercolor
    HRESULT GetBorderColor(COLORREF* lpClr);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nn-vmr9-ivmrmixercontrol9
@GUID("1a777eaa-47c8-4930-b2c9-8fee1c1b0f3b")
interface IVMRMixerControl9 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrmixercontrol9-setalpha
    HRESULT SetAlpha(uint dwStreamID, float Alpha);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrmixercontrol9-getalpha
    HRESULT GetAlpha(uint dwStreamID, float* pAlpha);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrmixercontrol9-setzorder
    HRESULT SetZOrder(uint dwStreamID, uint dwZ);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrmixercontrol9-getzorder
    HRESULT GetZOrder(uint dwStreamID, uint* pZ);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrmixercontrol9-setoutputrect
    HRESULT SetOutputRect(uint dwStreamID, const(VMR9NormalizedRect)* pRect);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrmixercontrol9-getoutputrect
    HRESULT GetOutputRect(uint dwStreamID, VMR9NormalizedRect* pRect);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrmixercontrol9-setbackgroundclr
    HRESULT SetBackgroundClr(COLORREF ClrBkg);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrmixercontrol9-getbackgroundclr
    HRESULT GetBackgroundClr(COLORREF* lpClrBkg);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrmixercontrol9-setmixingprefs
    HRESULT SetMixingPrefs(uint dwMixerPrefs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrmixercontrol9-getmixingprefs
    HRESULT GetMixingPrefs(uint* pdwMixerPrefs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrmixercontrol9-setprocampcontrol
    HRESULT SetProcAmpControl(uint dwStreamID, VMR9ProcAmpControl* lpClrControl);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrmixercontrol9-getprocampcontrol
    HRESULT GetProcAmpControl(uint dwStreamID, VMR9ProcAmpControl* lpClrControl);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrmixercontrol9-getprocampcontrolrange
    HRESULT GetProcAmpControlRange(uint dwStreamID, VMR9ProcAmpControlRange* lpClrControl);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nn-vmr9-ivmrmixerbitmap9
@GUID("ced175e5-1935-4820-81bd-ff6ad00c9108")
interface IVMRMixerBitmap9 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrmixerbitmap9-setalphabitmap
    HRESULT SetAlphaBitmap(const(VMR9AlphaBitmap)* pBmpParms);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrmixerbitmap9-updatealphabitmapparameters
    HRESULT UpdateAlphaBitmapParameters(const(VMR9AlphaBitmap)* pBmpParms);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrmixerbitmap9-getalphabitmapparameters
    HRESULT GetAlphaBitmapParameters(VMR9AlphaBitmap* pBmpParms);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nn-vmr9-ivmrsurface9
@GUID("dfc581a1-6e1f-4c3a-8d0a-5e9792ea2afc")
interface IVMRSurface9 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrsurface9-issurfacelocked
    HRESULT IsSurfaceLocked();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrsurface9-locksurface
    HRESULT LockSurface(ubyte** lpSurface);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrsurface9-unlocksurface
    HRESULT UnlockSurface();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrsurface9-getsurface
    HRESULT GetSurface(IDirect3DSurface9* lplpSurface);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nn-vmr9-ivmrimagepresenterconfig9
@GUID("45c15cab-6e22-420a-8043-ae1f0ac02c7d")
interface IVMRImagePresenterConfig9 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrimagepresenterconfig9-setrenderingprefs
    HRESULT SetRenderingPrefs(uint dwRenderFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrimagepresenterconfig9-getrenderingprefs
    HRESULT GetRenderingPrefs(uint* dwRenderFlags);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nn-vmr9-ivmrvideostreamcontrol9
@GUID("d0cfe38b-93e7-4772-8957-0400c49a4485")
interface IVMRVideoStreamControl9 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrvideostreamcontrol9-setstreamactivestate
    HRESULT SetStreamActiveState(BOOL fActive);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrvideostreamcontrol9-getstreamactivestate
    HRESULT GetStreamActiveState(BOOL* lpfActive);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nn-vmr9-ivmrfilterconfig9
@GUID("5a804648-4f66-4867-9c43-4f5c822cf1b8")
interface IVMRFilterConfig9 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrfilterconfig9-setimagecompositor
    HRESULT SetImageCompositor(IVMRImageCompositor9 lpVMRImgCompositor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrfilterconfig9-setnumberofstreams
    HRESULT SetNumberOfStreams(uint dwMaxStreams);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrfilterconfig9-getnumberofstreams
    HRESULT GetNumberOfStreams(uint* pdwMaxStreams);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrfilterconfig9-setrenderingprefs
    HRESULT SetRenderingPrefs(uint dwRenderFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrfilterconfig9-getrenderingprefs
    HRESULT GetRenderingPrefs(uint* pdwRenderFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrfilterconfig9-setrenderingmode
    HRESULT SetRenderingMode(uint Mode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrfilterconfig9-getrenderingmode
    HRESULT GetRenderingMode(uint* pMode);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nn-vmr9-ivmraspectratiocontrol9
@GUID("00d96c29-bbde-4efc-9901-bb5036392146")
interface IVMRAspectRatioControl9 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmraspectratiocontrol9-getaspectratiomode
    HRESULT GetAspectRatioMode(uint* lpdwARMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmraspectratiocontrol9-setaspectratiomode
    HRESULT SetAspectRatioMode(uint dwARMode);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nn-vmr9-ivmrmonitorconfig9
@GUID("46c2e457-8ba0-4eef-b80b-0680f0978749")
interface IVMRMonitorConfig9 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrmonitorconfig9-setmonitor
    HRESULT SetMonitor(uint uDev);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrmonitorconfig9-getmonitor
    HRESULT GetMonitor(uint* puDev);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrmonitorconfig9-setdefaultmonitor
    HRESULT SetDefaultMonitor(uint uDev);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrmonitorconfig9-getdefaultmonitor
    HRESULT GetDefaultMonitor(uint* puDev);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrmonitorconfig9-getavailablemonitors
    HRESULT GetAvailableMonitors(VMR9MonitorInfo* pInfo, uint dwMaxInfoArraySize, uint* pdwNumDevices);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nn-vmr9-ivmrdeinterlacecontrol9
@GUID("a215fb8d-13c2-4f7f-993c-003d6271a459")
interface IVMRDeinterlaceControl9 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrdeinterlacecontrol9-getnumberofdeinterlacemodes
    HRESULT GetNumberOfDeinterlaceModes(VMR9VideoDesc* lpVideoDescription, uint* lpdwNumDeinterlaceModes, 
                                        GUID* lpDeinterlaceModes);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrdeinterlacecontrol9-getdeinterlacemodecaps
    HRESULT GetDeinterlaceModeCaps(GUID* lpDeinterlaceMode, VMR9VideoDesc* lpVideoDescription, 
                                   VMR9DeinterlaceCaps* lpDeinterlaceCaps);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrdeinterlacecontrol9-getdeinterlacemode
    HRESULT GetDeinterlaceMode(uint dwStreamID, GUID* lpDeinterlaceMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrdeinterlacecontrol9-setdeinterlacemode
    HRESULT SetDeinterlaceMode(uint dwStreamID, GUID* lpDeinterlaceMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrdeinterlacecontrol9-getdeinterlaceprefs
    HRESULT GetDeinterlacePrefs(uint* lpdwDeinterlacePrefs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrdeinterlacecontrol9-setdeinterlaceprefs
    HRESULT SetDeinterlacePrefs(uint dwDeinterlacePrefs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrdeinterlacecontrol9-getactualdeinterlacemode
    HRESULT GetActualDeinterlaceMode(uint dwStreamID, GUID* lpDeinterlaceMode);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nn-vmr9-ivmrimagecompositor9
@GUID("4a5c89eb-df51-4654-ac2a-e48e02bbabf6")
interface IVMRImageCompositor9 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrimagecompositor9-initcompositiondevice
    HRESULT InitCompositionDevice(IUnknown pD3DDevice);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrimagecompositor9-termcompositiondevice
    HRESULT TermCompositionDevice(IUnknown pD3DDevice);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrimagecompositor9-setstreammediatype
    HRESULT SetStreamMediaType(uint dwStrmID, AM_MEDIA_TYPE* pmt, BOOL fTexture);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmr9/nf-vmr9-ivmrimagecompositor9-compositeimage
    HRESULT CompositeImage(IUnknown pD3DDevice, IDirect3DSurface9 pddsRenderTarget, AM_MEDIA_TYPE* pmtRenderTarget, 
                           long rtStart, long rtEnd, uint dwClrBkGnd, VMR9VideoStreamInfo* pVideoStreamInfo, 
                           uint cStreams);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vpconfig/nn-vpconfig-ivpbaseconfig
interface IVPBaseConfig : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vpconfig/nf-vpconfig-ivpbaseconfig-getconnectinfo
    HRESULT GetConnectInfo(uint* pdwNumConnectInfo, DDVIDEOPORTCONNECT* pddVPConnectInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vpconfig/nf-vpconfig-ivpbaseconfig-setconnectinfo
    HRESULT SetConnectInfo(uint dwChosenEntry);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vpconfig/nf-vpconfig-ivpbaseconfig-getvpdatainfo
    HRESULT GetVPDataInfo(AMVPDATAINFO* pamvpDataInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vpconfig/nf-vpconfig-ivpbaseconfig-getmaxpixelrate
    HRESULT GetMaxPixelRate(AMVPSIZE* pamvpSize, uint* pdwMaxPixelsPerSecond);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vpconfig/nf-vpconfig-ivpbaseconfig-informvpinputformats
    HRESULT InformVPInputFormats(uint dwNumFormats, DDPIXELFORMAT* pDDPixelFormats);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vpconfig/nf-vpconfig-ivpbaseconfig-getvideoformats
    HRESULT GetVideoFormats(uint* pdwNumFormats, DDPIXELFORMAT* pddPixelFormats);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vpconfig/nf-vpconfig-ivpbaseconfig-setvideoformat
    HRESULT SetVideoFormat(uint dwChosenEntry);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vpconfig/nf-vpconfig-ivpbaseconfig-setinvertpolarity
    HRESULT SetInvertPolarity();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vpconfig/nf-vpconfig-ivpbaseconfig-getoverlaysurface
    HRESULT GetOverlaySurface(IDirectDrawSurface* ppddOverlaySurface);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vpconfig/nf-vpconfig-ivpbaseconfig-setdirectdrawkernelhandle
    HRESULT SetDirectDrawKernelHandle(size_t dwDDKernelHandle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vpconfig/nf-vpconfig-ivpbaseconfig-setvideoportid
    HRESULT SetVideoPortID(uint dwVideoPortID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vpconfig/nf-vpconfig-ivpbaseconfig-setddsurfacekernelhandles
    HRESULT SetDDSurfaceKernelHandles(uint cHandles, size_t* rgDDKernelHandles);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vpconfig/nf-vpconfig-ivpbaseconfig-setsurfaceparameters
    HRESULT SetSurfaceParameters(uint dwPitch, uint dwXOrigin, uint dwYOrigin);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vpconfig/nn-vpconfig-ivpconfig
@GUID("bc29a660-30e3-11d0-9e69-00c04fd7c15b")
interface IVPConfig : IVPBaseConfig
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vpconfig/nf-vpconfig-ivpconfig-isvpdecimationallowed
    HRESULT IsVPDecimationAllowed(BOOL* pbIsDecimationAllowed);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vpconfig/nf-vpconfig-ivpconfig-setscalingfactors
    HRESULT SetScalingFactors(AMVPSIZE* pamvpSize);
}

@GUID("ec529b00-1a1f-11d1-bad9-00609744111a")
interface IVPVBIConfig : IVPBaseConfig
{
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vpnotify/nn-vpnotify-ivpbasenotify
interface IVPBaseNotify : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vpnotify/nf-vpnotify-ivpbasenotify-renegotiatevpparameters
    HRESULT RenegotiateVPParameters();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vpnotify/nn-vpnotify-ivpnotify
@GUID("c76794a1-d6c5-11d0-9e69-00c04fd7c15b")
interface IVPNotify : IVPBaseNotify
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vpnotify/nf-vpnotify-ivpnotify-setdeinterlacemode
    HRESULT SetDeinterlaceMode(AMVP_MODE mode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vpnotify/nf-vpnotify-ivpnotify-getdeinterlacemode
    HRESULT GetDeinterlaceMode(AMVP_MODE* pMode);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vpnotify/nn-vpnotify-ivpnotify2
@GUID("ebf47183-8764-11d1-9e69-00c04fd7c15b")
interface IVPNotify2 : IVPNotify
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vpnotify/nf-vpnotify-ivpnotify2-setvpsyncmaster
    HRESULT SetVPSyncMaster(BOOL bVPSyncMaster);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vpnotify/nf-vpnotify-ivpnotify2-getvpsyncmaster
    HRESULT GetVPSyncMaster(BOOL* pbVPSyncMaster);
}

@GUID("ec529b01-1a1f-11d1-bad9-00609744111a")
interface IVPVBINotify : IVPBaseNotify
{
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/medparam/nn-medparam-imediaparaminfo
@GUID("6d6cbb60-a223-44aa-842f-a2f06750be6d")
interface IMediaParamInfo : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/medparam/nf-medparam-imediaparaminfo-getparamcount
    HRESULT GetParamCount(uint* pdwParams);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/medparam/nf-medparam-imediaparaminfo-getparaminfo
    HRESULT GetParamInfo(uint dwParamIndex, MP_PARAMINFO* pInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/medparam/nf-medparam-imediaparaminfo-getparamtext
    HRESULT GetParamText(uint dwParamIndex, ushort** ppwchText);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/medparam/nf-medparam-imediaparaminfo-getnumtimeformats
    HRESULT GetNumTimeFormats(uint* pdwNumTimeFormats);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/medparam/nf-medparam-imediaparaminfo-getsupportedtimeformat
    HRESULT GetSupportedTimeFormat(uint dwFormatIndex, GUID* pguidTimeFormat);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/medparam/nf-medparam-imediaparaminfo-getcurrenttimeformat
    HRESULT GetCurrentTimeFormat(GUID* pguidTimeFormat, uint* pTimeData);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/medparam/nn-medparam-imediaparams
@GUID("6d6cbb61-a223-44aa-842f-a2f06750be6e")
interface IMediaParams : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/medparam/nf-medparam-imediaparams-getparam
    HRESULT GetParam(uint dwParamIndex, float* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/medparam/nf-medparam-imediaparams-setparam
    HRESULT SetParam(uint dwParamIndex, float value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/medparam/nf-medparam-imediaparams-addenvelope
    HRESULT AddEnvelope(uint dwParamIndex, uint cSegments, MP_ENVELOPE_SEGMENT* pEnvelopeSegments);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/medparam/nf-medparam-imediaparams-flushenvelope
    HRESULT FlushEnvelope(uint dwParamIndex, long refTimeStart, long refTimeEnd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/medparam/nf-medparam-imediaparams-settimeformat
    HRESULT SetTimeFormat(GUID guidTimeFormat, uint mpTimeData);
}

@GUID("56a868ff-0ad4-11ce-b03a-0020af0ba770")
interface IAMPlayListItem : IUnknown
{
    HRESULT GetFlags(uint* pdwFlags);
    HRESULT GetSourceCount(uint* pdwSources);
    HRESULT GetSourceURL(uint dwSourceIndex, BSTR* pbstrURL);
    HRESULT GetSourceStart(uint dwSourceIndex, long* prtStart);
    HRESULT GetSourceDuration(uint dwSourceIndex, long* prtDuration);
    HRESULT GetSourceStartMarker(uint dwSourceIndex, uint* pdwMarker);
    HRESULT GetSourceEndMarker(uint dwSourceIndex, uint* pdwMarker);
    HRESULT GetSourceStartMarkerName(uint dwSourceIndex, BSTR* pbstrStartMarker);
    HRESULT GetSourceEndMarkerName(uint dwSourceIndex, BSTR* pbstrEndMarker);
    HRESULT GetLinkURL(BSTR* pbstrURL);
    HRESULT GetScanDuration(uint dwSourceIndex, long* prtScanDuration);
}

@GUID("56a868fe-0ad4-11ce-b03a-0020af0ba770")
interface IAMPlayList : IUnknown
{
    HRESULT GetFlags(uint* pdwFlags);
    HRESULT GetItemCount(uint* pdwItems);
    HRESULT GetItem(uint dwItemIndex, IAMPlayListItem* ppItem);
    HRESULT GetNamedEvent(PWSTR pwszEventName, uint dwItemIndex, IAMPlayListItem* ppItem, uint* pdwFlags);
    HRESULT GetRepeatInfo(uint* pdwRepeatCount, uint* pdwRepeatStart, uint* pdwRepeatEnd);
}

@GUID("4c437b91-6e9e-11d1-a704-006097c4e476")
interface ISpecifyParticularPages : IUnknown
{
    HRESULT GetPages(const(GUID)* guidWhatPages, CAUUID* pPages);
}

@GUID("02ef04dd-7580-11d1-bece-00c04fb6e937")
interface IAMRebuild : IUnknown
{
    HRESULT RebuildNow();
}

@GUID("1e00486a-78dd-11d2-8dd3-006097c9a2b2")
interface IBufferingTime : IUnknown
{
    HRESULT GetBufferingTime(uint* pdwMilliseconds);
    HRESULT SetBufferingTime(uint dwMilliseconds);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmdxva/nn-wmdxva-iwmcodecamvideoaccelerator
@GUID("d98ee251-34e0-4a2d-9312-9b4c788d9fa1")
interface IWMCodecAMVideoAccelerator : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmdxva/nf-wmdxva-iwmcodecamvideoaccelerator-setacceleratorinterface
    HRESULT SetAcceleratorInterface(IAMVideoAccelerator pIAMVA);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmdxva/nf-wmdxva-iwmcodecamvideoaccelerator-negotiateconnection
    HRESULT NegotiateConnection(AM_MEDIA_TYPE* pMediaType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wmdxva/nf-wmdxva-iwmcodecamvideoaccelerator-setplayernotify
    HRESULT SetPlayerNotify(IWMPlayerTimestampHook pHook);
}

@GUID("990641b0-739f-4e94-a808-9888da8f75af")
interface IWMCodecVideoAccelerator : IUnknown
{
    HRESULT NegotiateConnection(IAMVideoAccelerator pIAMVA, AM_MEDIA_TYPE* pMediaType);
    HRESULT SetPlayerNotify(IWMPlayerTimestampHook pHook);
}


// GUIDs

const GUID CLSID_FilgraphManager = GUIDOF!FilgraphManager;

const GUID IID_IAMAnalogVideoDecoder            = GUIDOF!IAMAnalogVideoDecoder;
const GUID IID_IAMAnalogVideoEncoder            = GUIDOF!IAMAnalogVideoEncoder;
const GUID IID_IAMAsyncReaderTimestampScaling   = GUIDOF!IAMAsyncReaderTimestampScaling;
const GUID IID_IAMAudioInputMixer               = GUIDOF!IAMAudioInputMixer;
const GUID IID_IAMAudioRendererStats            = GUIDOF!IAMAudioRendererStats;
const GUID IID_IAMBufferNegotiation             = GUIDOF!IAMBufferNegotiation;
const GUID IID_IAMCameraControl                 = GUIDOF!IAMCameraControl;
const GUID IID_IAMCertifiedOutputProtection     = GUIDOF!IAMCertifiedOutputProtection;
const GUID IID_IAMChannelInfo                   = GUIDOF!IAMChannelInfo;
const GUID IID_IAMClockAdjust                   = GUIDOF!IAMClockAdjust;
const GUID IID_IAMClockSlave                    = GUIDOF!IAMClockSlave;
const GUID IID_IAMCollection                    = GUIDOF!IAMCollection;
const GUID IID_IAMCopyCaptureFileProgress       = GUIDOF!IAMCopyCaptureFileProgress;
const GUID IID_IAMCrossbar                      = GUIDOF!IAMCrossbar;
const GUID IID_IAMDecoderCaps                   = GUIDOF!IAMDecoderCaps;
const GUID IID_IAMDevMemoryAllocator            = GUIDOF!IAMDevMemoryAllocator;
const GUID IID_IAMDevMemoryControl              = GUIDOF!IAMDevMemoryControl;
const GUID IID_IAMDeviceRemoval                 = GUIDOF!IAMDeviceRemoval;
const GUID IID_IAMDirectSound                   = GUIDOF!IAMDirectSound;
const GUID IID_IAMDroppedFrames                 = GUIDOF!IAMDroppedFrames;
const GUID IID_IAMExtDevice                     = GUIDOF!IAMExtDevice;
const GUID IID_IAMExtTransport                  = GUIDOF!IAMExtTransport;
const GUID IID_IAMExtendedErrorInfo             = GUIDOF!IAMExtendedErrorInfo;
const GUID IID_IAMExtendedSeeking               = GUIDOF!IAMExtendedSeeking;
const GUID IID_IAMFilterGraphCallback           = GUIDOF!IAMFilterGraphCallback;
const GUID IID_IAMFilterMiscFlags               = GUIDOF!IAMFilterMiscFlags;
const GUID IID_IAMGraphBuilderCallback          = GUIDOF!IAMGraphBuilderCallback;
const GUID IID_IAMGraphStreams                  = GUIDOF!IAMGraphStreams;
const GUID IID_IAMLatency                       = GUIDOF!IAMLatency;
const GUID IID_IAMLine21Decoder                 = GUIDOF!IAMLine21Decoder;
const GUID IID_IAMMediaContent                  = GUIDOF!IAMMediaContent;
const GUID IID_IAMMediaContent2                 = GUIDOF!IAMMediaContent2;
const GUID IID_IAMMediaStream                   = GUIDOF!IAMMediaStream;
const GUID IID_IAMMediaTypeSample               = GUIDOF!IAMMediaTypeSample;
const GUID IID_IAMMediaTypeStream               = GUIDOF!IAMMediaTypeStream;
const GUID IID_IAMMultiMediaStream              = GUIDOF!IAMMultiMediaStream;
const GUID IID_IAMNetShowConfig                 = GUIDOF!IAMNetShowConfig;
const GUID IID_IAMNetShowExProps                = GUIDOF!IAMNetShowExProps;
const GUID IID_IAMNetShowPreroll                = GUIDOF!IAMNetShowPreroll;
const GUID IID_IAMNetworkStatus                 = GUIDOF!IAMNetworkStatus;
const GUID IID_IAMOpenProgress                  = GUIDOF!IAMOpenProgress;
const GUID IID_IAMOverlayFX                     = GUIDOF!IAMOverlayFX;
const GUID IID_IAMParse                         = GUIDOF!IAMParse;
const GUID IID_IAMPhysicalPinInfo               = GUIDOF!IAMPhysicalPinInfo;
const GUID IID_IAMPlayList                      = GUIDOF!IAMPlayList;
const GUID IID_IAMPlayListItem                  = GUIDOF!IAMPlayListItem;
const GUID IID_IAMPluginControl                 = GUIDOF!IAMPluginControl;
const GUID IID_IAMPushSource                    = GUIDOF!IAMPushSource;
const GUID IID_IAMRebuild                       = GUIDOF!IAMRebuild;
const GUID IID_IAMResourceControl               = GUIDOF!IAMResourceControl;
const GUID IID_IAMStats                         = GUIDOF!IAMStats;
const GUID IID_IAMStreamConfig                  = GUIDOF!IAMStreamConfig;
const GUID IID_IAMStreamControl                 = GUIDOF!IAMStreamControl;
const GUID IID_IAMStreamSelect                  = GUIDOF!IAMStreamSelect;
const GUID IID_IAMTVAudio                       = GUIDOF!IAMTVAudio;
const GUID IID_IAMTVAudioNotification           = GUIDOF!IAMTVAudioNotification;
const GUID IID_IAMTVTuner                       = GUIDOF!IAMTVTuner;
const GUID IID_IAMTimecodeDisplay               = GUIDOF!IAMTimecodeDisplay;
const GUID IID_IAMTimecodeGenerator             = GUIDOF!IAMTimecodeGenerator;
const GUID IID_IAMTimecodeReader                = GUIDOF!IAMTimecodeReader;
const GUID IID_IAMTuner                         = GUIDOF!IAMTuner;
const GUID IID_IAMTunerNotification             = GUIDOF!IAMTunerNotification;
const GUID IID_IAMVfwCaptureDialogs             = GUIDOF!IAMVfwCaptureDialogs;
const GUID IID_IAMVfwCompressDialogs            = GUIDOF!IAMVfwCompressDialogs;
const GUID IID_IAMVideoAccelerator              = GUIDOF!IAMVideoAccelerator;
const GUID IID_IAMVideoAcceleratorNotify        = GUIDOF!IAMVideoAcceleratorNotify;
const GUID IID_IAMVideoCompression              = GUIDOF!IAMVideoCompression;
const GUID IID_IAMVideoControl                  = GUIDOF!IAMVideoControl;
const GUID IID_IAMVideoDecimationProperties     = GUIDOF!IAMVideoDecimationProperties;
const GUID IID_IAMVideoProcAmp                  = GUIDOF!IAMVideoProcAmp;
const GUID IID_IAMWMBufferPass                  = GUIDOF!IAMWMBufferPass;
const GUID IID_IAMWMBufferPassCallback          = GUIDOF!IAMWMBufferPassCallback;
const GUID IID_IAMWstDecoder                    = GUIDOF!IAMWstDecoder;
const GUID IID_IAMovieSetup                     = GUIDOF!IAMovieSetup;
const GUID IID_IAsyncReader                     = GUIDOF!IAsyncReader;
const GUID IID_IAudioData                       = GUIDOF!IAudioData;
const GUID IID_IAudioMediaStream                = GUIDOF!IAudioMediaStream;
const GUID IID_IAudioStreamSample               = GUIDOF!IAudioStreamSample;
const GUID IID_IBDA_AUX                         = GUIDOF!IBDA_AUX;
const GUID IID_IBDA_AutoDemodulate              = GUIDOF!IBDA_AutoDemodulate;
const GUID IID_IBDA_AutoDemodulateEx            = GUIDOF!IBDA_AutoDemodulateEx;
const GUID IID_IBDA_ConditionalAccess           = GUIDOF!IBDA_ConditionalAccess;
const GUID IID_IBDA_ConditionalAccessEx         = GUIDOF!IBDA_ConditionalAccessEx;
const GUID IID_IBDA_DRIDRMService               = GUIDOF!IBDA_DRIDRMService;
const GUID IID_IBDA_DRIWMDRMSession             = GUIDOF!IBDA_DRIWMDRMSession;
const GUID IID_IBDA_DRM                         = GUIDOF!IBDA_DRM;
const GUID IID_IBDA_DRMService                  = GUIDOF!IBDA_DRMService;
const GUID IID_IBDA_DeviceControl               = GUIDOF!IBDA_DeviceControl;
const GUID IID_IBDA_DiagnosticProperties        = GUIDOF!IBDA_DiagnosticProperties;
const GUID IID_IBDA_DigitalDemodulator          = GUIDOF!IBDA_DigitalDemodulator;
const GUID IID_IBDA_DigitalDemodulator2         = GUIDOF!IBDA_DigitalDemodulator2;
const GUID IID_IBDA_DigitalDemodulator3         = GUIDOF!IBDA_DigitalDemodulator3;
const GUID IID_IBDA_DiseqCommand                = GUIDOF!IBDA_DiseqCommand;
const GUID IID_IBDA_EasMessage                  = GUIDOF!IBDA_EasMessage;
const GUID IID_IBDA_Encoder                     = GUIDOF!IBDA_Encoder;
const GUID IID_IBDA_EthernetFilter              = GUIDOF!IBDA_EthernetFilter;
const GUID IID_IBDA_EventingService             = GUIDOF!IBDA_EventingService;
const GUID IID_IBDA_FDC                         = GUIDOF!IBDA_FDC;
const GUID IID_IBDA_FrequencyFilter             = GUIDOF!IBDA_FrequencyFilter;
const GUID IID_IBDA_GuideDataDeliveryService    = GUIDOF!IBDA_GuideDataDeliveryService;
const GUID IID_IBDA_IPSinkControl               = GUIDOF!IBDA_IPSinkControl;
const GUID IID_IBDA_IPSinkInfo                  = GUIDOF!IBDA_IPSinkInfo;
const GUID IID_IBDA_IPV4Filter                  = GUIDOF!IBDA_IPV4Filter;
const GUID IID_IBDA_IPV6Filter                  = GUIDOF!IBDA_IPV6Filter;
const GUID IID_IBDA_ISDBConditionalAccess       = GUIDOF!IBDA_ISDBConditionalAccess;
const GUID IID_IBDA_LNBInfo                     = GUIDOF!IBDA_LNBInfo;
const GUID IID_IBDA_MUX                         = GUIDOF!IBDA_MUX;
const GUID IID_IBDA_NameValueService            = GUIDOF!IBDA_NameValueService;
const GUID IID_IBDA_NetworkProvider             = GUIDOF!IBDA_NetworkProvider;
const GUID IID_IBDA_NullTransform               = GUIDOF!IBDA_NullTransform;
const GUID IID_IBDA_PinControl                  = GUIDOF!IBDA_PinControl;
const GUID IID_IBDA_SignalProperties            = GUIDOF!IBDA_SignalProperties;
const GUID IID_IBDA_SignalStatistics            = GUIDOF!IBDA_SignalStatistics;
const GUID IID_IBDA_Topology                    = GUIDOF!IBDA_Topology;
const GUID IID_IBDA_TransportStreamInfo         = GUIDOF!IBDA_TransportStreamInfo;
const GUID IID_IBDA_TransportStreamSelector     = GUIDOF!IBDA_TransportStreamSelector;
const GUID IID_IBDA_UserActivityService         = GUIDOF!IBDA_UserActivityService;
const GUID IID_IBDA_VoidTransform               = GUIDOF!IBDA_VoidTransform;
const GUID IID_IBDA_WMDRMSession                = GUIDOF!IBDA_WMDRMSession;
const GUID IID_IBDA_WMDRMTuner                  = GUIDOF!IBDA_WMDRMTuner;
const GUID IID_IBPCSatelliteTuner               = GUIDOF!IBPCSatelliteTuner;
const GUID IID_IBaseFilter                      = GUIDOF!IBaseFilter;
const GUID IID_IBaseVideoMixer                  = GUIDOF!IBaseVideoMixer;
const GUID IID_IBasicAudio                      = GUIDOF!IBasicAudio;
const GUID IID_IBasicVideo                      = GUIDOF!IBasicVideo;
const GUID IID_IBasicVideo2                     = GUIDOF!IBasicVideo2;
const GUID IID_IBroadcastEvent                  = GUIDOF!IBroadcastEvent;
const GUID IID_IBroadcastEventEx                = GUIDOF!IBroadcastEventEx;
const GUID IID_IBufferingTime                   = GUIDOF!IBufferingTime;
const GUID IID_ICCSubStreamFiltering            = GUIDOF!ICCSubStreamFiltering;
const GUID IID_ICameraControl                   = GUIDOF!ICameraControl;
const GUID IID_ICaptureGraphBuilder             = GUIDOF!ICaptureGraphBuilder;
const GUID IID_ICaptureGraphBuilder2            = GUIDOF!ICaptureGraphBuilder2;
const GUID IID_IConfigAsfWriter                 = GUIDOF!IConfigAsfWriter;
const GUID IID_IConfigAsfWriter2                = GUIDOF!IConfigAsfWriter2;
const GUID IID_IConfigAviMux                    = GUIDOF!IConfigAviMux;
const GUID IID_IConfigInterleaving              = GUIDOF!IConfigInterleaving;
const GUID IID_ICreateDevEnum                   = GUIDOF!ICreateDevEnum;
const GUID IID_IDDrawExclModeVideo              = GUIDOF!IDDrawExclModeVideo;
const GUID IID_IDDrawExclModeVideoCallback      = GUIDOF!IDDrawExclModeVideoCallback;
const GUID IID_IDMOWrapperFilter                = GUIDOF!IDMOWrapperFilter;
const GUID IID_IDShowPlugin                     = GUIDOF!IDShowPlugin;
const GUID IID_IDVEnc                           = GUIDOF!IDVEnc;
const GUID IID_IDVRGB219                        = GUIDOF!IDVRGB219;
const GUID IID_IDVSplitter                      = GUIDOF!IDVSplitter;
const GUID IID_IDecimateVideoImage              = GUIDOF!IDecimateVideoImage;
const GUID IID_IDeferredCommand                 = GUIDOF!IDeferredCommand;
const GUID IID_IDirectDrawMediaSample           = GUIDOF!IDirectDrawMediaSample;
const GUID IID_IDirectDrawMediaSampleAllocator  = GUIDOF!IDirectDrawMediaSampleAllocator;
const GUID IID_IDirectDrawMediaStream           = GUIDOF!IDirectDrawMediaStream;
const GUID IID_IDirectDrawStreamSample          = GUIDOF!IDirectDrawStreamSample;
const GUID IID_IDirectDrawVideo                 = GUIDOF!IDirectDrawVideo;
const GUID IID_IDistributorNotify               = GUIDOF!IDistributorNotify;
const GUID IID_IDrawVideoImage                  = GUIDOF!IDrawVideoImage;
const GUID IID_IDvdCmd                          = GUIDOF!IDvdCmd;
const GUID IID_IDvdControl                      = GUIDOF!IDvdControl;
const GUID IID_IDvdControl2                     = GUIDOF!IDvdControl2;
const GUID IID_IDvdGraphBuilder                 = GUIDOF!IDvdGraphBuilder;
const GUID IID_IDvdInfo                         = GUIDOF!IDvdInfo;
const GUID IID_IDvdInfo2                        = GUIDOF!IDvdInfo2;
const GUID IID_IDvdState                        = GUIDOF!IDvdState;
const GUID IID_IESEvent                         = GUIDOF!IESEvent;
const GUID IID_IESEvents                        = GUIDOF!IESEvents;
const GUID IID_IEncoderAPI                      = GUIDOF!IEncoderAPI;
const GUID IID_IEnumFilters                     = GUIDOF!IEnumFilters;
const GUID IID_IEnumMediaTypes                  = GUIDOF!IEnumMediaTypes;
const GUID IID_IEnumPIDMap                      = GUIDOF!IEnumPIDMap;
const GUID IID_IEnumPins                        = GUIDOF!IEnumPins;
const GUID IID_IEnumRegFilters                  = GUIDOF!IEnumRegFilters;
const GUID IID_IEnumStreamIdMap                 = GUIDOF!IEnumStreamIdMap;
const GUID IID_IFileSinkFilter                  = GUIDOF!IFileSinkFilter;
const GUID IID_IFileSinkFilter2                 = GUIDOF!IFileSinkFilter2;
const GUID IID_IFileSourceFilter                = GUIDOF!IFileSourceFilter;
const GUID IID_IFilterChain                     = GUIDOF!IFilterChain;
const GUID IID_IFilterGraph                     = GUIDOF!IFilterGraph;
const GUID IID_IFilterGraph2                    = GUIDOF!IFilterGraph2;
const GUID IID_IFilterGraph3                    = GUIDOF!IFilterGraph3;
const GUID IID_IFilterInfo                      = GUIDOF!IFilterInfo;
const GUID IID_IFilterMapper                    = GUIDOF!IFilterMapper;
const GUID IID_IFilterMapper2                   = GUIDOF!IFilterMapper2;
const GUID IID_IFilterMapper3                   = GUIDOF!IFilterMapper3;
const GUID IID_IFrequencyMap                    = GUIDOF!IFrequencyMap;
const GUID IID_IFullScreenVideo                 = GUIDOF!IFullScreenVideo;
const GUID IID_IFullScreenVideoEx               = GUIDOF!IFullScreenVideoEx;
const GUID IID_IGetCapabilitiesKey              = GUIDOF!IGetCapabilitiesKey;
const GUID IID_IGraphBuilder                    = GUIDOF!IGraphBuilder;
const GUID IID_IGraphConfig                     = GUIDOF!IGraphConfig;
const GUID IID_IGraphConfigCallback             = GUIDOF!IGraphConfigCallback;
const GUID IID_IGraphVersion                    = GUIDOF!IGraphVersion;
const GUID IID_IIPDVDec                         = GUIDOF!IIPDVDec;
const GUID IID_IMPEG2PIDMap                     = GUIDOF!IMPEG2PIDMap;
const GUID IID_IMPEG2StreamIdMap                = GUIDOF!IMPEG2StreamIdMap;
const GUID IID_IMediaControl                    = GUIDOF!IMediaControl;
const GUID IID_IMediaEvent                      = GUIDOF!IMediaEvent;
const GUID IID_IMediaEventEx                    = GUIDOF!IMediaEventEx;
const GUID IID_IMediaEventSink                  = GUIDOF!IMediaEventSink;
const GUID IID_IMediaFilter                     = GUIDOF!IMediaFilter;
const GUID IID_IMediaParamInfo                  = GUIDOF!IMediaParamInfo;
const GUID IID_IMediaParams                     = GUIDOF!IMediaParams;
const GUID IID_IMediaPosition                   = GUIDOF!IMediaPosition;
const GUID IID_IMediaPropertyBag                = GUIDOF!IMediaPropertyBag;
const GUID IID_IMediaSample                     = GUIDOF!IMediaSample;
const GUID IID_IMediaSample2                    = GUIDOF!IMediaSample2;
const GUID IID_IMediaSample2Config              = GUIDOF!IMediaSample2Config;
const GUID IID_IMediaSeeking                    = GUIDOF!IMediaSeeking;
const GUID IID_IMediaStream                     = GUIDOF!IMediaStream;
const GUID IID_IMediaStreamFilter               = GUIDOF!IMediaStreamFilter;
const GUID IID_IMediaTypeInfo                   = GUIDOF!IMediaTypeInfo;
const GUID IID_IMemAllocator                    = GUIDOF!IMemAllocator;
const GUID IID_IMemAllocatorCallbackTemp        = GUIDOF!IMemAllocatorCallbackTemp;
const GUID IID_IMemAllocatorNotifyCallbackTemp  = GUIDOF!IMemAllocatorNotifyCallbackTemp;
const GUID IID_IMemInputPin                     = GUIDOF!IMemInputPin;
const GUID IID_IMemoryData                      = GUIDOF!IMemoryData;
const GUID IID_IMixerOCX                        = GUIDOF!IMixerOCX;
const GUID IID_IMixerOCXNotify                  = GUIDOF!IMixerOCXNotify;
const GUID IID_IMixerPinConfig                  = GUIDOF!IMixerPinConfig;
const GUID IID_IMixerPinConfig2                 = GUIDOF!IMixerPinConfig2;
const GUID IID_IMpeg2Demultiplexer              = GUIDOF!IMpeg2Demultiplexer;
const GUID IID_IMpegAudioDecoder                = GUIDOF!IMpegAudioDecoder;
const GUID IID_IMultiMediaStream                = GUIDOF!IMultiMediaStream;
const GUID IID_IOverlay                         = GUIDOF!IOverlay;
const GUID IID_IOverlayNotify                   = GUIDOF!IOverlayNotify;
const GUID IID_IOverlayNotify2                  = GUIDOF!IOverlayNotify2;
const GUID IID_IPersistMediaPropertyBag         = GUIDOF!IPersistMediaPropertyBag;
const GUID IID_IPin                             = GUIDOF!IPin;
const GUID IID_IPinConnection                   = GUIDOF!IPinConnection;
const GUID IID_IPinFlowControl                  = GUIDOF!IPinFlowControl;
const GUID IID_IPinInfo                         = GUIDOF!IPinInfo;
const GUID IID_IQualProp                        = GUIDOF!IQualProp;
const GUID IID_IQualityControl                  = GUIDOF!IQualityControl;
const GUID IID_IQueueCommand                    = GUIDOF!IQueueCommand;
const GUID IID_IRegFilterInfo                   = GUIDOF!IRegFilterInfo;
const GUID IID_IRegisterServiceProvider         = GUIDOF!IRegisterServiceProvider;
const GUID IID_IResourceConsumer                = GUIDOF!IResourceConsumer;
const GUID IID_IResourceManager                 = GUIDOF!IResourceManager;
const GUID IID_ISeekingPassThru                 = GUIDOF!ISeekingPassThru;
const GUID IID_ISelector                        = GUIDOF!ISelector;
const GUID IID_ISpecifyParticularPages          = GUIDOF!ISpecifyParticularPages;
const GUID IID_IStreamBuilder                   = GUIDOF!IStreamBuilder;
const GUID IID_IStreamSample                    = GUIDOF!IStreamSample;
const GUID IID_IVMRAspectRatioControl           = GUIDOF!IVMRAspectRatioControl;
const GUID IID_IVMRAspectRatioControl9          = GUIDOF!IVMRAspectRatioControl9;
const GUID IID_IVMRDeinterlaceControl           = GUIDOF!IVMRDeinterlaceControl;
const GUID IID_IVMRDeinterlaceControl9          = GUIDOF!IVMRDeinterlaceControl9;
const GUID IID_IVMRFilterConfig                 = GUIDOF!IVMRFilterConfig;
const GUID IID_IVMRFilterConfig9                = GUIDOF!IVMRFilterConfig9;
const GUID IID_IVMRImageCompositor              = GUIDOF!IVMRImageCompositor;
const GUID IID_IVMRImageCompositor9             = GUIDOF!IVMRImageCompositor9;
const GUID IID_IVMRImagePresenter               = GUIDOF!IVMRImagePresenter;
const GUID IID_IVMRImagePresenter9              = GUIDOF!IVMRImagePresenter9;
const GUID IID_IVMRImagePresenterConfig         = GUIDOF!IVMRImagePresenterConfig;
const GUID IID_IVMRImagePresenterConfig9        = GUIDOF!IVMRImagePresenterConfig9;
const GUID IID_IVMRImagePresenterExclModeConfig = GUIDOF!IVMRImagePresenterExclModeConfig;
const GUID IID_IVMRMixerBitmap                  = GUIDOF!IVMRMixerBitmap;
const GUID IID_IVMRMixerBitmap9                 = GUIDOF!IVMRMixerBitmap9;
const GUID IID_IVMRMixerControl                 = GUIDOF!IVMRMixerControl;
const GUID IID_IVMRMixerControl9                = GUIDOF!IVMRMixerControl9;
const GUID IID_IVMRMonitorConfig                = GUIDOF!IVMRMonitorConfig;
const GUID IID_IVMRMonitorConfig9               = GUIDOF!IVMRMonitorConfig9;
const GUID IID_IVMRSurface                      = GUIDOF!IVMRSurface;
const GUID IID_IVMRSurface9                     = GUIDOF!IVMRSurface9;
const GUID IID_IVMRSurfaceAllocator             = GUIDOF!IVMRSurfaceAllocator;
const GUID IID_IVMRSurfaceAllocator9            = GUIDOF!IVMRSurfaceAllocator9;
const GUID IID_IVMRSurfaceAllocatorEx9          = GUIDOF!IVMRSurfaceAllocatorEx9;
const GUID IID_IVMRSurfaceAllocatorNotify       = GUIDOF!IVMRSurfaceAllocatorNotify;
const GUID IID_IVMRSurfaceAllocatorNotify9      = GUIDOF!IVMRSurfaceAllocatorNotify9;
const GUID IID_IVMRVideoStreamControl           = GUIDOF!IVMRVideoStreamControl;
const GUID IID_IVMRVideoStreamControl9          = GUIDOF!IVMRVideoStreamControl9;
const GUID IID_IVMRWindowlessControl            = GUIDOF!IVMRWindowlessControl;
const GUID IID_IVMRWindowlessControl9           = GUIDOF!IVMRWindowlessControl9;
const GUID IID_IVPConfig                        = GUIDOF!IVPConfig;
const GUID IID_IVPManager                       = GUIDOF!IVPManager;
const GUID IID_IVPNotify                        = GUIDOF!IVPNotify;
const GUID IID_IVPNotify2                       = GUIDOF!IVPNotify2;
const GUID IID_IVPVBIConfig                     = GUIDOF!IVPVBIConfig;
const GUID IID_IVPVBINotify                     = GUIDOF!IVPVBINotify;
const GUID IID_IVideoEncoder                    = GUIDOF!IVideoEncoder;
const GUID IID_IVideoFrameStep                  = GUIDOF!IVideoFrameStep;
const GUID IID_IVideoProcAmp                    = GUIDOF!IVideoProcAmp;
const GUID IID_IVideoWindow                     = GUIDOF!IVideoWindow;
const GUID IID_IWMCodecAMVideoAccelerator       = GUIDOF!IWMCodecAMVideoAccelerator;
const GUID IID_IWMCodecVideoAccelerator         = GUIDOF!IWMCodecVideoAccelerator;
