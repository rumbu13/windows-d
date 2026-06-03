// Written in the D programming language.

module windows.win32.media.directshow.tv;

public import windows.core;
public import windows.win32.foundation : BOOL, BSTR, CHAR, HANDLE, HRESULT, HWND,
                                         PWSTR, RECT, SIZE, VARIANT_BOOL;
public import windows.win32.graphics.gdi : HDC;
public import windows.win32.media.directshow : AnalogVideoStandard, BinaryConvolutionCodeRate,
                                               ComponentCategory, ComponentStatus,
                                               DVBSystemType, FECMethod, GuardInterval,
                                               HierarchyAlpha, IESEvent, IESEvents,
                                               IEnumFilters, IFilterGraph, IGraphBuilder,
                                               IMediaSeeking, IPin, IVMRImageCompositor,
                                               IVMRMixerBitmap, IVMRSurfaceAllocator,
                                               LNB_Source, MPEG2StreamType,
                                               ModulationType, Pilot, Polarisation,
                                               RollOff, SpectralInversion, TVAudioMode,
                                               TransmissionMode, TunerInputType,
                                               VMRALPHABITMAP;
public import windows.win32.media.kernelstreaming : KSDATAFORMAT, KSEVENTDATA, KSIDENTIFIER,
                                                    KSM_NODE, KSP_NODE;
public import windows.win32.media.mediafoundation : AM_MEDIA_TYPE, IMFVideoPresenter;
public import windows.win32.security : PSID;
public import windows.win32.system.com : IDispatch, IEnumGUID, IEnumMoniker, IPersist,
                                         IUnknown, SAFEARRAY;
public import windows.win32.system.ole : IEnumVARIANT, IPictureDisp;
public import windows.win32.system.registry : HKEY;
public import windows.win32.system.variant : VARIANT;

extern(Windows) @nogc nothrow:


// Enums


alias DISPID_TUNER = int;
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

alias EnTvRat_System = int;
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

alias EnTvRat_GenericLevel = int;
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

alias EnTvRat_MPAA = int;
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

alias EnTvRat_US_TV = int;
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

alias EnTvRat_CAE_TV = int;
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

alias EnTvRat_CAF_TV = int;
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

alias BfEnTvRat_GenericAttributes = int;
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

alias BfEnTvRat_Attributes_US_TV = int;
enum : int
{
    US_TV_IsBlocked                  = 0x00000001,
    US_TV_IsViolent                  = 0x00000002,
    US_TV_IsSexualSituation          = 0x00000004,
    US_TV_IsAdultLanguage            = 0x00000008,
    US_TV_IsSexuallySuggestiveDialog = 0x00000010,
    US_TV_ValidAttrSubmask           = 0x0000001f,
}

alias BfEnTvRat_Attributes_MPAA = int;
enum : int
{
    MPAA_IsBlocked        = 0x00000001,
    MPAA_ValidAttrSubmask = 0x00000001,
}

alias BfEnTvRat_Attributes_CAE_TV = int;
enum : int
{
    CAE_IsBlocked        = 0x00000001,
    CAE_ValidAttrSubmask = 0x00000001,
}

alias BfEnTvRat_Attributes_CAF_TV = int;
enum : int
{
    CAF_IsBlocked        = 0x00000001,
    CAF_ValidAttrSubmask = 0x00000001,
}

enum FormatNotSupportedEvents : int
{
    FORMATNOTSUPPORTED_CLEAR        = 0x00000000,
    FORMATNOTSUPPORTED_NOTSUPPORTED = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/encdec/ne-encdec-prottype
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/encdec/ne-encdec-cpevents
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

alias EnTag_Mode = int;
enum : int
{
    EnTag_Remove = 0x00000000,
    EnTag_Once   = 0x00000001,
    EnTag_Repeat = 0x00000002,
}

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

//ENUM ATTR: ScopedEnumAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/ne-segment-msvidccservice
enum MSVidCCService : int
{
    None     = 0x00000000,
    Caption1 = 0x00000001,
    Caption2 = 0x00000002,
    Text1    = 0x00000003,
    Text2    = 0x00000004,
    XDS      = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/ne-segment-msvidsinkstreams
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/ne-segment-dvdmenuidconstants
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/ne-segment-dvdtextstringtype
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/ne-segment-dvdspext
alias DVDSPExt = int;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/ne-segment-sourcesizelist
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msvidctl/ne-msvidctl-displaysizelist
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msvidctl/ne-msvidctl-msvidctlstatelist
enum MSVidCtlStateList : int
{
    STATE_UNBUILT = 0xffffffff,
    STATE_STOP    = 0x00000000,
    STATE_PAUSE   = 0x00000001,
    STATE_PLAY    = 0x00000002,
}

alias RECORDING_TYPE = int;
enum : int
{
    RECORDING_TYPE_CONTENT   = 0x00000000,
    RECORDING_TYPE_REFERENCE = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/ne-sbe-streambuffer_attr_datatype
alias STREAMBUFFER_ATTR_DATATYPE = int;
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

alias CROSSBAR_DEFAULT_FLAGS = int;
enum : int
{
    DEF_MODE_PROFILE = 0x00000001,
    DEF_MODE_STREAMS = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2structs/ne-mpeg2structs-mpeg_current_next_bit
alias MPEG_CURRENT_NEXT_BIT = int;
enum : int
{
    MPEG_SECTION_IS_NEXT    = 0x00000000,
    MPEG_SECTION_IS_CURRENT = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2structs/ne-mpeg2structs-mpeg_context_type
alias MPEG_CONTEXT_TYPE = int;
enum : int
{
    MPEG_CONTEXT_BCS_DEMUX = 0x00000000,
    MPEG_CONTEXT_WINSOCK   = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2structs/ne-mpeg2structs-mpeg_request_type
alias MPEG_REQUEST_TYPE = int;
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

alias VA_VIDEO_FORMAT = int;
enum : int
{
    VA_VIDEO_COMPONENT   = 0x00000000,
    VA_VIDEO_PAL         = 0x00000001,
    VA_VIDEO_NTSC        = 0x00000002,
    VA_VIDEO_SECAM       = 0x00000003,
    VA_VIDEO_MAC         = 0x00000004,
    VA_VIDEO_UNSPECIFIED = 0x00000005,
}

alias VA_COLOR_PRIMARIES = int;
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

alias VA_TRANSFER_CHARACTERISTICS = int;
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

alias VA_MATRIX_COEFFICIENTS = int;
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

alias DVB_STRCONV_MODE = int;
enum : int
{
    STRCONV_MODE_DVB                  = 0x00000000,
    STRCONV_MODE_DVB_EMPHASIS         = 0x00000001,
    STRCONV_MODE_DVB_WITHOUT_EMPHASIS = 0x00000002,
    STRCONV_MODE_ISDB                 = 0x00000003,
}

alias CRID_LOCATION = int;
enum : int
{
    CRID_LOCATION_IN_DESCRIPTOR = 0x00000000,
    CRID_LOCATION_IN_CIT        = 0x00000001,
    CRID_LOCATION_DVB_RESERVED1 = 0x00000002,
    CRID_LOCATION_DVB_RESERVED2 = 0x00000003,
}

alias DESC_LINKAGE_TYPE = int;
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

alias ChannelChangeSpanningEvent_State = int;
enum : int
{
    ChannelChangeSpanningEvent_Start = 0x00000000,
    ChannelChangeSpanningEvent_End   = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/WES/eventmanifestschema-channeltype-complextype
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

alias SignalAndServiceStatusSpanningEvent_State = int;
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

alias KSPROPERTY_BDA_ETHERNET_FILTER = int;
enum : int
{
    KSPROPERTY_BDA_ETHERNET_FILTER_MULTICAST_LIST_SIZE = 0x00000000,
    KSPROPERTY_BDA_ETHERNET_FILTER_MULTICAST_LIST      = 0x00000001,
    KSPROPERTY_BDA_ETHERNET_FILTER_MULTICAST_MODE      = 0x00000002,
}

alias KSPROPERTY_BDA_IPv4_FILTER = int;
enum : int
{
    KSPROPERTY_BDA_IPv4_FILTER_MULTICAST_LIST_SIZE = 0x00000000,
    KSPROPERTY_BDA_IPv4_FILTER_MULTICAST_LIST      = 0x00000001,
    KSPROPERTY_BDA_IPv4_FILTER_MULTICAST_MODE      = 0x00000002,
}

alias KSPROPERTY_BDA_IPv6_FILTER = int;
enum : int
{
    KSPROPERTY_BDA_IPv6_FILTER_MULTICAST_LIST_SIZE = 0x00000000,
    KSPROPERTY_BDA_IPv6_FILTER_MULTICAST_LIST      = 0x00000001,
    KSPROPERTY_BDA_IPv6_FILTER_MULTICAST_MODE      = 0x00000002,
}

alias KSPROPERTY_BDA_SIGNAL_STATS = int;
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

alias BDA_LockType = int;
enum : int
{
    Bda_LockType_None         = 0x00000000,
    Bda_LockType_PLL          = 0x00000001,
    Bda_LockType_DecoderDemod = 0x00000002,
    Bda_LockType_Complete     = 0x00000080,
}

alias KSMETHOD_BDA_CHANGE_SYNC = int;
enum : int
{
    KSMETHOD_BDA_START_CHANGES    = 0x00000000,
    KSMETHOD_BDA_CHECK_CHANGES    = 0x00000001,
    KSMETHOD_BDA_COMMIT_CHANGES   = 0x00000002,
    KSMETHOD_BDA_GET_CHANGE_STATE = 0x00000003,
}

alias KSMETHOD_BDA_DEVICE_CONFIGURATION = int;
enum : int
{
    KSMETHOD_BDA_CREATE_PIN_FACTORY = 0x00000000,
    KSMETHOD_BDA_DELETE_PIN_FACTORY = 0x00000001,
    KSMETHOD_BDA_CREATE_TOPOLOGY    = 0x00000002,
}

alias KSPROPERTY_BDA_TOPOLOGY = int;
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

alias KSPROPERTY_BDA_PIN_CONTROL = int;
enum : int
{
    KSPROPERTY_BDA_PIN_ID   = 0x00000000,
    KSPROPERTY_BDA_PIN_TYPE = 0x00000001,
}

alias KSPROPERTY_BDA_PIN_EVENT = int;
enum : int
{
    KSEVENT_BDA_PIN_CONNECTED    = 0x00000000,
    KSEVENT_BDA_PIN_DISCONNECTED = 0x00000001,
}

alias KSPROPERTY_BDA_VOID_TRANSFORM = int;
enum : int
{
    KSPROPERTY_BDA_VOID_TRANSFORM_START = 0x00000000,
    KSPROPERTY_BDA_VOID_TRANSFORM_STOP  = 0x00000001,
}

alias KSPROPERTY_BDA_NULL_TRANSFORM = int;
enum : int
{
    KSPROPERTY_BDA_NULL_TRANSFORM_START = 0x00000000,
    KSPROPERTY_BDA_NULL_TRANSFORM_STOP  = 0x00000001,
}

alias KSPROPERTY_BDA_FREQUENCY_FILTER = int;
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

alias BDA_SignalType = int;
enum : int
{
    Bda_SignalType_Unknown = 0x00000000,
    Bda_SignalType_Analog  = 0x00000001,
    Bda_SignalType_Digital = 0x00000002,
}

alias BDA_DigitalSignalStandard = int;
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

alias KSEVENT_BDA_TUNER = int;
enum : int
{
    KSEVENT_BDA_TUNER_SCAN = 0x00000000,
}

alias KSPROPERTY_BDA_LNB_INFO = int;
enum : int
{
    KSPROPERTY_BDA_LNB_LOF_LOW_BAND     = 0x00000000,
    KSPROPERTY_BDA_LNB_LOF_HIGH_BAND    = 0x00000001,
    KSPROPERTY_BDA_LNB_SWITCH_FREQUENCY = 0x00000002,
}

alias KSPROPERTY_BDA_DISEQC_COMMAND = int;
enum : int
{
    KSPROPERTY_BDA_DISEQC_ENABLE       = 0x00000000,
    KSPROPERTY_BDA_DISEQC_LNB_SOURCE   = 0x00000001,
    KSPROPERTY_BDA_DISEQC_USETONEBURST = 0x00000002,
    KSPROPERTY_BDA_DISEQC_REPEATS      = 0x00000003,
    KSPROPERTY_BDA_DISEQC_SEND         = 0x00000004,
    KSPROPERTY_BDA_DISEQC_RESPONSE     = 0x00000005,
}

alias KSPROPERTY_BDA_DISEQC_EVENT = int;
enum : int
{
    KSEVENT_BDA_DISEQC_DATA_RECEIVED = 0x00000000,
}

alias KSPROPERTY_BDA_DIGITAL_DEMODULATOR = int;
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

alias KSPROPERTY_BDA_AUTODEMODULATE = int;
enum : int
{
    KSPROPERTY_BDA_AUTODEMODULATE_START = 0x00000000,
    KSPROPERTY_BDA_AUTODEMODULATE_STOP  = 0x00000001,
}

alias KSPROPERTY_IDS_BDA_TABLE = int;
enum : int
{
    KSPROPERTY_BDA_TABLE_SECTION = 0x00000000,
}

alias KSPROPERTY_BDA_PIDFILTER = int;
enum : int
{
    KSPROPERTY_BDA_PIDFILTER_MAP_PIDS   = 0x00000000,
    KSPROPERTY_BDA_PIDFILTER_UNMAP_PIDS = 0x00000001,
    KSPROPERTY_BDA_PIDFILTER_LIST_PIDS  = 0x00000002,
}

alias KSPROPERTY_BDA_CA = int;
enum : int
{
    KSPROPERTY_BDA_ECM_MAP_STATUS       = 0x00000000,
    KSPROPERTY_BDA_CA_MODULE_STATUS     = 0x00000001,
    KSPROPERTY_BDA_CA_SMART_CARD_STATUS = 0x00000002,
    KSPROPERTY_BDA_CA_MODULE_UI         = 0x00000003,
    KSPROPERTY_BDA_CA_SET_PROGRAM_PIDS  = 0x00000004,
    KSPROPERTY_BDA_CA_REMOVE_PROGRAM    = 0x00000005,
}

alias KSPROPERTY_BDA_CA_EVENT = int;
enum : int
{
    KSEVENT_BDA_PROGRAM_FLOW_STATUS_CHANGED  = 0x00000000,
    KSEVENT_BDA_CA_MODULE_STATUS_CHANGED     = 0x00000001,
    KSEVENT_BDA_CA_SMART_CARD_STATUS_CHANGED = 0x00000002,
    KSEVENT_BDA_CA_MODULE_UI_REQUESTED       = 0x00000003,
}

alias KSMETHOD_BDA_DRM = int;
enum : int
{
    KSMETHOD_BDA_DRM_CURRENT   = 0x00000000,
    KSMETHOD_BDA_DRM_DRMSTATUS = 0x00000001,
}

alias KSMETHOD_BDA_WMDRM = int;
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

alias KSMETHOD_BDA_WMDRM_TUNER = int;
enum : int
{
    KSMETHOD_BDA_WMDRMTUNER_CANCELCAPTURETOKEN   = 0x00000000,
    KSMETHOD_BDA_WMDRMTUNER_SETPIDPROTECTION     = 0x00000001,
    KSMETHOD_BDA_WMDRMTUNER_GETPIDPROTECTION     = 0x00000002,
    KSMETHOD_BDA_WMDRMTUNER_SETSYNCVALUE         = 0x00000003,
    KSMETHOD_BDA_WMDRMTUNER_STARTCODEPROFILE     = 0x00000004,
    KSMETHOD_BDA_WMDRMTUNER_PURCHASE_ENTITLEMENT = 0x00000005,
}

alias KSMETHOD_BDA_EVENTING_SERVICE = int;
enum : int
{
    KSMETHOD_BDA_EVENT_DATA     = 0x00000000,
    KSMETHOD_BDA_EVENT_COMPLETE = 0x00000001,
}

alias KSEVENT_BDA_EVENT_TYPE = int;
enum : int
{
    KSEVENT_BDA_EVENT_PENDINGEVENT = 0x00000000,
}

alias KSMETHOD_BDA_DEBUG_SERVICE = int;
enum : int
{
    KSMETHOD_BDA_DEBUG_LEVEL = 0x00000000,
    KSMETHOD_BDA_DEBUG_DATA  = 0x00000001,
}

alias KSMETHOD_BDA_TUNER_SERVICE = int;
enum : int
{
    KSMETHOD_BDA_TUNER_SETTUNER         = 0x00000000,
    KSMETHOD_BDA_TUNER_GETTUNERSTATE    = 0x00000001,
    KSMETHOD_BDA_TUNER_SIGNALNOISERATIO = 0x00000002,
}

alias KSMETHOD_BDA_GPNV_SERVICE = int;
enum : int
{
    KSMETHOD_BDA_GPNV_GETVALUE           = 0x00000000,
    KSMETHOD_BDA_GPNV_SETVALUE           = 0x00000001,
    KSMETHOD_BDA_GPNV_NAMEFROMINDEX      = 0x00000002,
    KSMETHOD_BDA_GPNV_GETVALUEUPDATENAME = 0x00000003,
}

alias KSMETHOD_BDA_MUX_SERVICE = int;
enum : int
{
    KSMETHOD_BDA_MUX_GETPIDLIST = 0x00000000,
    KSMETHOD_BDA_MUX_SETPIDLIST = 0x00000001,
}

alias KSMETHOD_BDA_SCAN_SERVICE = int;
enum : int
{
    KSMETHOD_BDA_SCAN_CAPABILTIES = 0x00000000,
    KSMETHOD_BDA_SCANNING_STATE   = 0x00000001,
    KSMETHOD_BDA_SCAN_FILTER      = 0x00000002,
    KSMETHOD_BDA_SCAN_START       = 0x00000003,
    KSMETHOD_BDA_SCAN_RESUME      = 0x00000004,
    KSMETHOD_BDA_SCAN_STOP        = 0x00000005,
}

alias KSMETHOD_BDA_GDDS_SERVICE = int;
enum : int
{
    KSMETHOD_BDA_GDDS_DATATYPE           = 0x00000000,
    KSMETHOD_BDA_GDDS_DATA               = 0x00000001,
    KSMETHOD_BDA_GDDS_TUNEXMLFROMIDX     = 0x00000002,
    KSMETHOD_BDA_GDDS_GETSERVICES        = 0x00000003,
    KSMETHOD_BDA_GDDS_SERVICEFROMTUNEXML = 0x00000004,
    KSMETHOD_BDA_GDDS_DATAUPDATE         = 0x00000005,
}

alias KSMETHOD_BDA_CAS_SERVICE = int;
enum : int
{
    KSMETHOD_BDA_CAS_CHECKENTITLEMENTTOKEN = 0x00000000,
    KSMETHOD_BDA_CAS_SETCAPTURETOKEN       = 0x00000001,
    KSMETHOD_BDA_CAS_OPENBROADCASTMMI      = 0x00000002,
    KSMETHOD_BDA_CAS_CLOSEMMIDIALOG        = 0x00000003,
}

alias KSMETHOD_BDA_ISDB_CAS = int;
enum : int
{
    KSMETHOD_BDA_ISDBCAS_SETREQUEST   = 0x00000000,
    KSMETHOD_BDA_ISDBCAS_RESPONSEDATA = 0x00000001,
}

alias KSMETHOD_BDA_TS_SELECTOR = int;
enum : int
{
    KSMETHOD_BDA_TS_SELECTOR_SETTSID          = 0x00000000,
    KSMETHOD_BDA_TS_SELECTOR_GETTSINFORMATION = 0x00000001,
}

alias KSMETHOD_BDA_USERACTIVITY_SERVICE = int;
enum : int
{
    KSMETHOD_BDA_USERACTIVITY_USEREASON = 0x00000000,
    KSMETHOD_BDA_USERACTIVITY_INTERVAL  = 0x00000001,
    KSMETHOD_BDA_USERACTIVITY_DETECTED  = 0x00000002,
}

// Constants


enum : uint
{
    DTV_CardStatus_Inserted         = 0x00000000U,
    DTV_CardStatus_Removed          = 0x00000001U,
    DTV_CardStatus_Error            = 0x00000002U,
    DTV_CardStatus_FirmwareDownload = 0x00000003U,
}

enum uint OCUR_PAIRING_PROTOCOL_VERSION = 0x00000002U;
enum uint PBDA_PAIRING_PROTOCOL_VERSION = 0x00000003U;

enum : uint
{
    DTV_MMIMessage_Open  = 0x00000000U,
    DTV_MMIMessage_Close = 0x00000001U,
}

enum : uint
{
    DTV_Entitlement_CanDecrypt       = 0x00000000U,
    DTV_Entitlement_NotEntitled      = 0x00000001U,
    DTV_Entitlement_TechnicalFailure = 0x00000002U,
}

enum : uint
{
    AudioType_Standard          = 0x00000000U,
    AudioType_Music_And_Effects = 0x00000001U,
}

enum uint AudioType_Visually_Impaired = 0x00000002U;
enum uint AudioType_Hearing_Impaired = 0x00000003U;

enum : uint
{
    AudioType_Dialogue   = 0x00000004U,
    AudioType_Commentary = 0x00000005U,
    AudioType_Emergency  = 0x00000006U,
    AudioType_Voiceover  = 0x00000007U,
}

enum int AudioType_Reserved = 0xffffffff;
enum uint MAX_COUNTRY_CODE_STRING = 0x00000003U;
enum uint PARENTAL_CONTROL_TIME_RANGE = 0x00000001U;
enum uint REQUIRED_PARENTAL_CONTROL_TIME_RANGE = 0x00000002U;

enum : uint
{
    PARENTAL_CONTROL_CONTENT_RATING  = 0x00000100U,
    PARENTAL_CONTROL_ATTRIB_VIOLENCE = 0x00000200U,
    PARENTAL_CONTROL_ATTRIB_LANGUAGE = 0x00000201U,
    PARENTAL_CONTROL_ATTRIB_SEXUAL   = 0x00000202U,
    PARENTAL_CONTROL_ATTRIB_DIALOGUE = 0x00000203U,
    PARENTAL_CONTROL_ATTRIB_FANTASY  = 0x00000204U,
    PARENTAL_CONTROL_VALUE_UNDEFINED = 0x00000000U,
}

enum : uint
{
    MPEG2_FILTER_VERSION_1_SIZE = 0x0000007cU,
    MPEG2_FILTER_VERSION_2_SIZE = 0x00000085U,
}

enum GUID SID_MSVidCtl_CurrentAudioEndpoint = GUID("cf9a88f4-abcf-4ed8-9b74-7db33445459e");
enum uint STREAMBUFFER_EC_BASE = 0x00000326U;

enum : GUID
{
    EVENTID_SBE2RecControlStarted = GUID("8966a89e-f83e-4c0e-bc3b-bfa7649e04cb"),
    EVENTID_SBE2RecControlStopped = GUID("454b1ec8-0c9b-4caa-b1a1-1e7a2666f6c3"),
}

enum GUID SBE2_STREAM_DESC_EVENT = GUID("2313a4ed-bf2d-454f-ad8a-d95ba7f91fee");
enum GUID SBE2_V1_STREAMS_CREATION_EVENT = GUID("000fcf09-97f5-46ac-9769-7a83b35384fb");
enum GUID SBE2_V2_STREAMS_CREATION_EVENT = GUID("a72530a3-0344-4cab-a2d0-fe937dbdcab3");
enum uint SBE2_STREAM_DESC_VERSION = 0x00000001U;
enum GUID SID_DRMSecureServiceChannel = GUID("c4c4c4c4-0049-4e2b-98fb-9537f6ce516d");

enum : GUID
{
    CLSID_ETFilterEncProperties = GUID("c4c4c481-0049-4e2b-98fb-9537f6ce516d"),
    CLSID_ETFilterTagProperties = GUID("c4c4c491-0049-4e2b-98fb-9537f6ce516d"),
}

enum : GUID
{
    CLSID_PTFilter              = GUID("9cd31617-b303-4f96-8330-2eb173ea4dc6"),
    CLSID_DTFilterEncProperties = GUID("c4c4c482-0049-4e2b-98fb-9537f6ce516d"),
    CLSID_DTFilterTagProperties = GUID("c4c4c492-0049-4e2b-98fb-9537f6ce516d"),
}

enum : GUID
{
    CLSID_XDSCodecProperties    = GUID("c4c4c483-0049-4e2b-98fb-9537f6ce516d"),
    CLSID_XDSCodecTagProperties = GUID("c4c4c493-0049-4e2b-98fb-9537f6ce516d"),
}

enum GUID CLSID_CPCAFiltersCategory = GUID("c4c4c4fc-0049-4e2b-98fb-9537f6ce516d");

enum : GUID
{
    EVENTID_XDSCodecNewXDSRating       = GUID("c4c4c4e0-0049-4e2b-98fb-9537f6ce516d"),
    EVENTID_XDSCodecDuplicateXDSRating = GUID("c4c4c4df-0049-4e2b-98fb-9537f6ce516d"),
    EVENTID_XDSCodecNewXDSPacket       = GUID("c4c4c4e1-0049-4e2b-98fb-9537f6ce516d"),
}

enum : GUID
{
    EVENTID_DTFilterRatingChange   = GUID("c4c4c4e2-0049-4e2b-98fb-9537f6ce516d"),
    EVENTID_DTFilterRatingsBlock   = GUID("c4c4c4e3-0049-4e2b-98fb-9537f6ce516d"),
    EVENTID_DTFilterRatingsUnblock = GUID("c4c4c4e4-0049-4e2b-98fb-9537f6ce516d"),
    EVENTID_DTFilterXDSPacket      = GUID("c4c4c4e5-0049-4e2b-98fb-9537f6ce516d"),
}

enum : GUID
{
    EVENTID_ETFilterEncryptionOn  = GUID("c4c4c4e6-0049-4e2b-98fb-9537f6ce516d"),
    EVENTID_ETFilterEncryptionOff = GUID("c4c4c4e7-0049-4e2b-98fb-9537f6ce516d"),
}

enum GUID EVENTID_DTFilterCOPPUnblock = GUID("c4c4c4e8-0049-4e2b-98fb-9537f6ce516d");
enum GUID EVENTID_EncDecFilterError = GUID("c4c4c4e9-0049-4e2b-98fb-9537f6ce516d");
enum GUID EVENTID_DTFilterCOPPBlock = GUID("c4c4c4ea-0049-4e2b-98fb-9537f6ce516d");

enum : GUID
{
    EVENTID_ETFilterCopyOnce  = GUID("c4c4c4eb-0049-4e2b-98fb-9537f6ce516d"),
    EVENTID_ETFilterCopyNever = GUID("c4c4c4f0-0049-4e2b-98fb-9537f6ce516d"),
}

enum : GUID
{
    EVENTID_DTFilterDataFormatOK      = GUID("c4c4c4ec-0049-4e2b-98fb-9537f6ce516d"),
    EVENTID_DTFilterDataFormatFailure = GUID("c4c4c4ed-0049-4e2b-98fb-9537f6ce516d"),
}

enum : GUID
{
    EVENTID_ETDTFilterLicenseOK      = GUID("c4c4c4ee-0049-4e2b-98fb-9537f6ce516d"),
    EVENTID_ETDTFilterLicenseFailure = GUID("c4c4c4ef-0049-4e2b-98fb-9537f6ce516d"),
}

enum GUID MEDIASUBTYPE_ETDTFilter_Tagged = GUID("c4c4c4d0-0049-4e2b-98fb-9537f6ce516d");
enum GUID FORMATTYPE_ETDTFilter_Tagged = GUID("c4c4c4d1-0049-4e2b-98fb-9537f6ce516d");
enum GUID MEDIASUBTYPE_CPFilters_Processed = GUID("46adbd28-6fd0-4796-93b2-155c51dc048d");
enum GUID FORMATTYPE_CPFilters_Processed = GUID("6739b36f-1d5f-4ac2-8192-28bb0e73d16a");
enum GUID EVENTID_EncDecFilterEvent = GUID("4a1b465b-0fb9-4159-afbd-e33006a0f9f4");
enum GUID EVENTID_FormatNotSupportedEvent = GUID("24b2280a-b2aa-4777-bf65-63f35e7b024a");
enum GUID EVENTID_DemultiplexerFilterDiscontinuity = GUID("16155770-aed5-475c-bb98-95a33070df0c");
enum GUID DSATTRIB_WMDRMProtectionInfo = GUID("40749583-6b9d-4eec-b43c-67a1801e1a9b");
enum GUID DSATTRIB_BadSampleInfo = GUID("e4846dda-5838-42b4-b897-6f7e5faa2f2f");

enum : uint
{
    MPEG_PAT_PID  = 0x00000000U,
    MPEG_PAT_TID  = 0x00000000U,
    MPEG_CAT_PID  = 0x00000001U,
    MPEG_CAT_TID  = 0x00000001U,
    MPEG_PMT_TID  = 0x00000002U,
    MPEG_TSDT_PID = 0x00000002U,
    MPEG_TSDT_TID = 0x00000003U,
}

enum : uint
{
    ATSC_MGT_PID      = 0x00001ffbU,
    ATSC_MGT_TID      = 0x000000c7U,
    ATSC_VCT_PID      = 0x00001ffbU,
    ATSC_VCT_TERR_TID = 0x000000c8U,
    ATSC_VCT_CABL_TID = 0x000000c9U,
}

enum : uint
{
    ATSC_EIT_TID = 0x000000cbU,
    ATSC_ETT_TID = 0x000000ccU,
    ATSC_RRT_TID = 0x000000caU,
    ATSC_RRT_PID = 0x00001ffbU,
    ATSC_STT_PID = 0x00001ffbU,
    ATSC_STT_TID = 0x000000cdU,
    ATSC_PIT_TID = 0x000000d0U,
}

enum : uint
{
    DVB_NIT_PID        = 0x00000010U,
    DVB_NIT_ACTUAL_TID = 0x00000040U,
    DVB_NIT_OTHER_TID  = 0x00000041U,
}

enum : uint
{
    DVB_SDT_PID        = 0x00000011U,
    DVB_SDT_ACTUAL_TID = 0x00000042U,
    DVB_SDT_OTHER_TID  = 0x00000046U,
}

enum : uint
{
    DVB_BAT_PID = 0x00000011U,
    DVB_BAT_TID = 0x0000004aU,
}

enum : uint
{
    DVB_EIT_PID        = 0x00000012U,
    DVB_EIT_ACTUAL_TID = 0x0000004eU,
    DVB_EIT_OTHER_TID  = 0x0000004fU,
}

enum : uint
{
    DVB_RST_PID = 0x00000013U,
    DVB_RST_TID = 0x00000071U,
}

enum : uint
{
    DVB_TDT_PID = 0x00000014U,
    DVB_TDT_TID = 0x00000070U,
}

enum : uint
{
    DVB_ST_PID_16 = 0x00000010U,
    DVB_ST_PID_17 = 0x00000011U,
    DVB_ST_PID_18 = 0x00000012U,
    DVB_ST_PID_19 = 0x00000013U,
    DVB_ST_PID_20 = 0x00000014U,
    DVB_ST_TID    = 0x00000072U,
}

enum uint ISDB_ST_TID = 0x00000072U;

enum : uint
{
    DVB_TOT_PID = 0x00000014U,
    DVB_TOT_TID = 0x00000073U,
}

enum : uint
{
    DVB_DIT_PID = 0x0000001eU,
    DVB_DIT_TID = 0x0000007eU,
}

enum : uint
{
    DVB_SIT_PID = 0x0000001fU,
    DVB_SIT_TID = 0x0000007fU,
}

enum : uint
{
    ISDB_EMM_TID      = 0x00000085U,
    ISDB_BIT_PID      = 0x00000024U,
    ISDB_BIT_TID      = 0x000000c4U,
    ISDB_NBIT_PID     = 0x00000025U,
    ISDB_NBIT_MSG_TID = 0x000000c5U,
    ISDB_NBIT_REF_TID = 0x000000c6U,
}

enum : uint
{
    ISDB_LDT_PID      = 0x00000025U,
    ISDB_LDT_TID      = 0x000000c7U,
    ISDB_SDTT_PID     = 0x00000023U,
    ISDB_SDTT_ALT_PID = 0x00000028U,
    ISDB_SDTT_TID     = 0x000000c3U,
}

enum : uint
{
    ISDB_CDT_PID = 0x00000029U,
    ISDB_CDT_TID = 0x000000c8U,
}

enum : uint
{
    SCTE_EAS_TID     = 0x000000d8U,
    SCTE_EAS_IB_PID  = 0x00001ffbU,
    SCTE_EAS_OOB_PID = 0x00001ffcU,
}

enum GUID CLSID_Mpeg2TableFilter = GUID("752845f1-758f-4c83-a043-4270c593308e");

enum : uint
{
    ATSC_ETM_LOCATION_NOT_PRESENT      = 0x00000000U,
    ATSC_ETM_LOCATION_IN_PTC_FOR_PSIP  = 0x00000001U,
    ATSC_ETM_LOCATION_IN_PTC_FOR_EVENT = 0x00000002U,
    ATSC_ETM_LOCATION_RESERVED         = 0x00000003U,
}

enum : uint
{
    SAMPLE_SEQ_SEQUENCE_HEADER          = 0x00000001U,
    SAMPLE_SEQ_GOP_HEADER               = 0x00000002U,
    SAMPLE_SEQ_PICTURE_HEADER           = 0x00000003U,
    SAMPLE_SEQ_SEQUENCE_START           = 0x00000001U,
    SAMPLE_SEQ_SEEK_POINT               = 0x00000002U,
    SAMPLE_SEQ_FRAME_START              = 0x00000003U,
    SAMPLE_SEQ_CONTENT_UNKNOWN          = 0x00000000U,
    SAMPLE_SEQ_CONTENT_I_FRAME          = 0x00000001U,
    SAMPLE_SEQ_CONTENT_P_FRAME          = 0x00000002U,
    SAMPLE_SEQ_CONTENT_B_FRAME          = 0x00000003U,
    SAMPLE_SEQ_CONTENT_STANDALONE_FRAME = 0x00000001U,
    SAMPLE_SEQ_CONTENT_REF_FRAME        = 0x00000002U,
    SAMPLE_SEQ_CONTENT_NONREF_FRAME     = 0x00000003U,
}

enum : uint
{
    COMPONENT_TAG_CAPTION_MIN     = 0x00000030U,
    COMPONENT_TAG_CAPTION_MAX     = 0x00000037U,
    COMPONENT_TAG_SUPERIMPOSE_MIN = 0x00000038U,
    COMPONENT_TAG_SUPERIMPOSE_MAX = 0x0000003fU,
}

enum uint DVBS_SCAN_TABLE_MAX_SIZE = 0x00000190U;

enum : const(wchar)*
{
    g_wszStreamBufferRecordingDuration               = "Duration",
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
    STREAMBUFFER_EC_TIMEHOLE                       = 0x00000326,
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

enum int STREAMBUFFER_EC_SETPOSITIONS_EVENTS_DONE = 0x00000330;

// Structs


struct WMDRMProtectionInfo
{
align (1):
    ushort[25] wszKID;
    ulong      qwCounter;
    ulong      qwIndex;
    ubyte      bOffset;
}

struct BadSampleInfo
{
align (1):
    HRESULT hrReason;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/ns-sbe-streambuffer_attribute
struct STREAMBUFFER_ATTRIBUTE
{
    PWSTR  pszName;
    STREAMBUFFER_ATTR_DATATYPE StreamBufferAttributeType;
    ubyte* pbAttribute;
    ushort cbLength;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/ns-sbe-sbe_pin_data
struct SBE_PIN_DATA
{
    ulong cDataBytes;
    ulong cSamplesProcessed;
    ulong cDiscontinuities;
    ulong cSyncPoints;
    ulong cTimestamps;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/ns-sbe-sbe2_stream_desc
struct SBE2_STREAM_DESC
{
    uint Version;
    uint StreamId;
    uint Default;
    uint Reserved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/ns-sbe-dvr_stream_desc
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

struct PID_BITS_MIDL
{
align (1):
    ushort Bits;
}

struct MPEG_HEADER_BITS_MIDL
{
align (1):
    ushort Bits;
}

struct MPEG_HEADER_VERSION_BITS_MIDL
{
    ubyte Bits;
}

struct TID_EXTENSION
{
align (1):
    ushort wTidExt;
    ushort wCount;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2structs/ns-mpeg2structs-section
struct SECTION
{
align (1):
    ubyte    TableId;
    union Header
    {
    align (1):
        MPEG_HEADER_BITS_MIDL S;
        ushort W;
    }
    ubyte[1] SectionData; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2structs/ns-mpeg2structs-long_section
struct LONG_SECTION
{
align (1):
    ubyte    TableId;
    union Header
    {
    align (1):
        MPEG_HEADER_BITS_MIDL S;
        ushort W;
    }
    ushort   TableIdExtension;
    union Version
    {
        MPEG_HEADER_VERSION_BITS_MIDL S;
        ubyte B;
    }
    ubyte    SectionNumber;
    ubyte    LastSectionNumber;
    ubyte[1] RemainingData; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2structs/ns-mpeg2structs-dsmcc_section
struct DSMCC_SECTION
{
align (1):
    ubyte    TableId;
    union Header
    {
    align (1):
        MPEG_HEADER_BITS_MIDL S;
        ushort W;
    }
    ushort   TableIdExtension;
    union Version
    {
        MPEG_HEADER_VERSION_BITS_MIDL S;
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
    ubyte[1] RemainingData; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2structs/ns-mpeg2structs-mpeg_rqst_packet
struct MPEG_RQST_PACKET
{
align (1):
    uint     dwLength;
    SECTION* pSection;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2structs/ns-mpeg2structs-mpeg_packet_list
struct MPEG_PACKET_LIST
{
align (1):
    ushort               wPacketCount;
    MPEG_RQST_PACKET[1]* PacketList; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2structs/ns-mpeg2structs-dsmcc_filter_options
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2structs/ns-mpeg2structs-atsc_filter_options
struct ATSC_FILTER_OPTIONS
{
align (1):
    BOOL fSpecifyEtmId;
    uint EtmId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2structs/ns-mpeg2structs-dvb_eit_filter_options
struct DVB_EIT_FILTER_OPTIONS
{
align (1):
    BOOL  fSpecifySegment;
    ubyte bSegment;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2structs/ns-mpeg2structs-mpeg2_filter
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2structs/ns-mpeg2structs-mpeg2_filter2
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2structs/ns-mpeg2structs-mpeg_stream_buffer
struct MPEG_STREAM_BUFFER
{
align (1):
    HRESULT hr;
    uint    dwDataBufferSize;
    uint    dwSizeOfDataRead;
    ubyte*  pDataBuffer;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2structs/ns-mpeg2structs-mpeg_time
struct MPEG_TIME
{
align (1):
    ubyte Hours;
    ubyte Minutes;
    ubyte Seconds;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2structs/ns-mpeg2structs-mpeg_date
struct MPEG_DATE
{
align (1):
    ubyte  Date;
    ubyte  Month;
    ushort Year;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2structs/ns-mpeg2structs-mpeg_date_and_time
struct MPEG_DATE_AND_TIME
{
align (1):
    MPEG_DATE D;
    MPEG_TIME T;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2structs/ns-mpeg2structs-mpeg_bcs_demux
struct MPEG_BCS_DEMUX
{
align (1):
    uint AVMGraphId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2structs/ns-mpeg2structs-mpeg_winsock
struct MPEG_WINSOCK
{
align (1):
    uint AVMGraphId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2structs/ns-mpeg2structs-mpeg_context
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

struct MPEG_SERVICE_REQUEST
{
align (1):
    MPEG_REQUEST_TYPE Type;
    MPEG_CONTEXT      Context;
    ushort            Pid;
    ubyte             TableId;
    MPEG2_FILTER      Filter;
    uint              Flags;
}

struct MPEG_SERVICE_RESPONSE
{
align (1):
    uint   IPAddress;
    ushort Port;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2structs/ns-mpeg2structs-dsmcc_element
struct DSMCC_ELEMENT
{
align (1):
    ushort         pid;
    ubyte          bComponentTag;
    uint           dwCarouselId;
    uint           dwTransactionId;
    DSMCC_ELEMENT* pNext;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2structs/ns-mpeg2structs-mpe_element
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
    int[1]   SectionOffsets; // Flexible array
}

struct ProgramElement
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
    // Native bit field: Content: [0-2], Start: [3], FrameRate: [4-7], InvalidVA: [8], Reserved: [9-27], Version: [28-31]
    uint _bitfield0;
}

struct SAMPLE_SEQ_OFFSET
{
    // Native bit field: Type: [0-3], Offset: [4-23], Reserved: [24-31]
    uint _bitfield0;
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
            // Native bit field: TransportScramblingControl: [0-7], Reserved: [8-63]
            long _bitfield0;
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
    ubyte[1] TableData; // Flexible array
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
    ubyte[1]     argbDebugString; // Flexible array
}

struct BDA_DEBUG_DATA
{
    int      lResult;
    GUID     uuidDebugDataType;
    uint     ulDataSize;
    ubyte[1] argbDebugData; // Flexible array
}

struct BDA_EVENT_DATA
{
    int      lResult;
    uint     ulEventID;
    GUID     uuidEventType;
    uint     ulEventDataLength;
    ubyte[1] argbEventData; // Flexible array
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
    ubyte[1] argbBuffer; // Flexible array
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
    ubyte[1] argbDataBuffer; // Flexible array
}

struct KSM_BDA_WMDRMTUNER_PURCHASEENTITLEMENT
{
    KSM_NODE NodeMethod;
    uint     ulDialogRequest;
    CHAR[12] cLanguage;
    uint     ulPurchaseTokenLength;
    ubyte[1] argbDataBuffer; // Flexible array
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
    ubyte[1]     argbTuneData; // Flexible array
}

struct KSM_BDA_GPNV_GETVALUE
{
    KSIDENTIFIER Method;
    uint         ulNameLength;
    CHAR[12]     cLanguage;
    ubyte[1]     argbData; // Flexible array
}

struct KSM_BDA_GPNV_SETVALUE
{
    KSIDENTIFIER Method;
    uint         ulDialogRequest;
    CHAR[12]     cLanguage;
    uint         ulNameLength;
    uint         ulValueLength;
    ubyte[1]     argbName; // Flexible array
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
    ubyte[1]     argbScanModulationTypes; // Flexible array
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
    ubyte[1]     argbTuneXml; // Flexible array
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
    CHAR[12] cLanguage;
    uint     ulRequestType;
    uint     ulEntitlementTokenLen;
    ubyte[1] argbEntitlementToken; // Flexible array
}

struct KSM_BDA_CAS_CAPTURETOKEN
{
    KSM_NODE NodeMethod;
    uint     ulTokenLength;
    ubyte[1] argbToken; // Flexible array
}

struct KSM_BDA_CAS_OPENBROADCASTMMI
{
    KSM_NODE NodeMethod;
    uint     ulDialogRequest;
    CHAR[12] cLanguage;
    uint     ulEventId;
}

struct KSM_BDA_CAS_CLOSEMMIDIALOG
{
    KSM_NODE NodeMethod;
    uint     ulDialogRequest;
    CHAR[12] cLanguage;
    uint     ulDialogNumber;
    uint     ulReason;
}

struct KSM_BDA_ISDBCAS_REQUEST
{
    KSM_NODE NodeMethod;
    uint     ulRequestID;
    uint     ulIsdbCommandSize;
    ubyte[1] argbIsdbCommandData; // Flexible array
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
    ubyte[1] bDescriptor; // Flexible array
}

struct DVBScramblingControlSpanningEvent
{
    uint ulPID;
    BOOL fScrambled;
}

struct SpanningEventEmmMessage
{
    ubyte    bCAbroadcasterGroupId;
    ubyte    bMessageControl;
    ushort   wServiceId;
    ushort   wTableIdExtension;
    ubyte    bDeletionStatus;
    ubyte    bDisplayingDuration1;
    ubyte    bDisplayingDuration2;
    ubyte    bDisplayingDuration3;
    ubyte    bDisplayingCycle;
    ubyte    bFormatVersion;
    ubyte    bDisplayPosition;
    ushort   wMessageLength;
    wchar[1] szMessageArea; // Flexible array
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
    uint[1] pulPIDs; // Flexible array
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
    // Native bit field: rating_system_is_age_type: [0], reserved: [1-7]
    ubyte             _bitfield0;
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
    CHAR[4] szCountryCode;
    ubyte   bRating;
}

struct DvbParentalRatingDescriptor
{
    uint ulNumParams;
    DvbParentalRatingParam[1] pParams; // Flexible array
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
    BDA_SignalType SignalType;
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
    BDA_LockType LockRequested;
}

struct PID_BITS
{
align (1):
    // Native bit field: Reserved: [0-2], ProgramId: [3-15]
    ushort _bitfield0;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2bits/ns-mpeg2bits-mpeg_header_bits
struct MPEG_HEADER_BITS
{
align (1):
    // Native bit field: SectionLength: [0-11], Reserved: [12-13], PrivateIndicator: [14], SectionSyntaxIndicator: [15]
    ushort _bitfield0;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2bits/ns-mpeg2bits-mpeg_header_version_bits
struct MPEG_HEADER_VERSION_BITS
{
    // Native bit field: CurrentNextIndicator: [0], VersionNumber: [1-5], Reserved: [6-7]
    ubyte _bitfield0;
}

// Interfaces

@GUID("d02aac50-027e-11d3-9d8e-00c04f72d980")
struct SystemTuningSpaces;

@GUID("5ffdc5e6-b83a-4b55-b6e8-c69e765fe9db")
struct TuningSpace;

@GUID("cc829a2f-3365-463f-af13-81dbb6f3a555")
struct ChannelIDTuningSpace;

@GUID("a2e30750-6c3d-11d3-b653-00c04f79498e")
struct ATSCTuningSpace;

@GUID("d9bb4cee-b87a-47f1-ac92-b08d9c7813fc")
struct DigitalCableTuningSpace;

@GUID("8a674b4c-1f63-11d3-b64c-00c04f79498e")
struct AnalogRadioTuningSpace;

@GUID("f9769a06-7aca-4e39-9cfb-97bb35f0e77e")
struct AuxInTuningSpace;

@GUID("8a674b4d-1f63-11d3-b64c-00c04f79498e")
struct AnalogTVTuningSpace;

@GUID("c6b14b32-76aa-4a86-a7ac-5c79aaf58da7")
struct DVBTuningSpace;

@GUID("b64016f3-c9a2-4066-96f0-bd9563314726")
struct DVBSTuningSpace;

@GUID("a1a2b1c4-0e3a-11d3-9d8e-00c04f72d980")
struct ComponentTypes;

@GUID("823535a0-0318-11d3-9d8e-00c04f72d980")
struct ComponentType;

@GUID("1be49f30-0e1b-11d3-9d8e-00c04f72d980")
struct LanguageComponentType;

@GUID("418008f3-cf67-4668-9628-10dc52be1d08")
struct MPEG2ComponentType;

@GUID("a8dcf3d5-0780-4ef4-8a83-2cffaacb8ace")
struct ATSCComponentType;

// Microsoft documentation: https://learn.microsoft.com/windows/win32/cossdk/components
@GUID("809b6661-94c4-49e6-b6ec-3f0f862215aa")
struct Components;

// Microsoft documentation: https://learn.microsoft.com/windows/win32/Msi/components
@GUID("59dc47a8-116c-11d3-9d8e-00c04f72d980")
struct Component;

@GUID("055cb2d7-2969-45cd-914b-76890722f112")
struct MPEG2Component;

@GUID("28ab0005-e845-4ffa-aa9b-f4665236141c")
struct AnalogAudioComponentType;

@GUID("b46e0d38-ab35-4a06-a137-70576b01b39f")
struct TuneRequest;

@GUID("3a9428a7-31a4-45e9-9efb-e055bf7bb3db")
struct ChannelIDTuneRequest;

@GUID("0369b4e5-45b6-11d3-b650-00c04f79498e")
struct ChannelTuneRequest;

@GUID("0369b4e6-45b6-11d3-b650-00c04f79498e")
struct ATSCChannelTuneRequest;

@GUID("26ec0b63-aa90-458a-8df4-5659f2c8a18a")
struct DigitalCableTuneRequest;

@GUID("0955ac62-bf2e-4cba-a2b9-a63f772d46cf")
struct MPEG2TuneRequest;

@GUID("2c63e4eb-4cea-41b8-919c-e947ea19a77c")
struct MPEG2TuneRequestFactory;

@GUID("0888c883-ac4f-4943-b516-2c38d9b34562")
struct Locator;

@GUID("6e50cc0d-c19b-4bf6-810b-5bd60761f5cc")
struct DigitalLocator;

@GUID("49638b91-48ab-48b7-a47a-7d0e75a08ede")
struct AnalogLocator;

@GUID("8872ff1b-98fa-4d7a-8d93-c9f1055f85bb")
struct ATSCLocator;

@GUID("03c06416-d127-407a-ab4c-fdd279abbe5d")
struct DigitalCableLocator;

@GUID("9cd64701-bdf3-4d14-8e03-f12983d86664")
struct DVBTLocator;

@GUID("efe3fa02-45d7-4920-be96-53fa7f35b0e6")
struct DVBTLocator2;

@GUID("1df7d126-4050-47f0-a7cf-4c4ca9241333")
struct DVBSLocator;

@GUID("c531d9fd-9685-4028-8b68-6e1232079f1e")
struct DVBCLocator;

@GUID("6504afed-a629-455c-a7f1-04964dea5cc4")
struct ISDBSLocator;

@GUID("15d6504a-5494-499c-886c-973c9e53b9f1")
struct DVBTuneRequest;

@GUID("8a674b49-1f63-11d3-b64c-00c04f79498e")
struct CreatePropBagOnRegKey;

@GUID("0b3ffb92-0919-4934-9d5b-619c719d0202")
struct BroadcastEventService;

@GUID("6438570b-0c08-4a25-9504-8012bb4d50cf")
struct TunerMarshaler;

@GUID("e77026b0-b97f-4cbb-b7fb-f4f03ad69f11")
struct PersistTuneXmlUtility;

@GUID("c20447fc-ec60-475e-813f-d2b0a6decefe")
struct ESEventService;

@GUID("8e8a07da-71f8-40c1-a929-5e3a868ac2c6")
struct ESEventFactory;

@GUID("c4c4c4f1-0049-4e2b-98fb-9537f6ce516d")
struct ETFilter;

@GUID("c4c4c4f2-0049-4e2b-98fb-9537f6ce516d")
struct DTFilter;

@GUID("c4c4c4f3-0049-4e2b-98fb-9537f6ce516d")
struct XDSCodec;

@GUID("c4c4c4f4-0049-4e2b-98fb-9537f6ce516d")
struct CXDSData;

@GUID("c5c5c5f0-3abc-11d6-b25b-00c04fa0c026")
struct XDSToRat;

@GUID("c5c5c5f1-3abc-11d6-b25b-00c04fa0c026")
struct EvalRat;

@GUID("1c15d484-911d-11d2-b632-00c04f79498e")
struct MSVidAnalogTunerDevice;

@GUID("a2e3074e-6c3d-11d3-b653-00c04f79498e")
struct MSVidBDATunerDevice;

@GUID("37b0353c-a4c8-11d2-b634-00c04f79498e")
struct MSVidFilePlaybackDevice;

@GUID("011b3619-fe63-4814-8a84-15a194ce9ce3")
struct MSVidWebDVD;

@GUID("fa7c375b-66a7-4280-879d-fd459c84bb02")
struct MSVidWebDVDAdm;

@GUID("37b03543-a4c8-11d2-b634-00c04f79498e")
struct MSVidVideoRenderer;

@GUID("24dc3975-09bf-4231-8655-3ee71f43837d")
struct MSVidVMR9;

@GUID("c45268a2-fa81-4e19-b1e3-72edbd60aeda")
struct MSVidEVR;

@GUID("37b03544-a4c8-11d2-b634-00c04f79498e")
struct MSVidAudioRenderer;

@GUID("4a5869cf-929d-4040-ae03-fcafc5b9cd42")
struct MSVidGenericSink;

@GUID("9e77aac4-35e5-42a1-bdc2-8f3ff399847c")
struct MSVidStreamBufferSink;

@GUID("ad8e510d-217f-409b-8076-29c5e73b98e8")
struct MSVidStreamBufferSource;

@GUID("fd351ea1-4173-4af4-821d-80d4ae979048")
struct MSVidStreamBufferV2Source;

@GUID("bb530c63-d9df-4b49-9439-63453962e598")
struct MSVidEncoder;

@GUID("5740a302-ef0b-45ce-bf3b-4470a14a8980")
struct MSVidITVCapture;

@GUID("9e797ed0-5253-4243-a9b7-bd06c58f8ef3")
struct MSVidITVPlayback;

@GUID("86151827-e47b-45ee-8421-d10e6e690979")
struct MSVidCCA;

@GUID("7f9cb14d-48e4-43b6-9346-1aebc39c64d3")
struct MSVidClosedCaptioning;

@GUID("92ed88bf-879e-448f-b6b6-a385bceb846d")
struct MSVidClosedCaptioningSI;

@GUID("334125c0-77e5-11d3-b653-00c04f79498e")
struct MSVidDataServices;

@GUID("0149eedf-d08f-4142-8d73-d23903d21e90")
struct MSVidXDS;

@GUID("c5702cd6-9b79-11d3-b654-00c04f79498e")
struct MSVidAnalogCaptureToDataServices;

@GUID("38f03426-e83b-4e68-b65b-dcae73304838")
struct MSVidDataServicesToStreamBufferSink;

@GUID("0429ec6e-1144-4bed-b88b-2fb9899a4a3d")
struct MSVidDataServicesToXDS;

@GUID("3540d440-5b1d-49cb-821a-e84b8cf065a7")
struct MSVidAnalogCaptureToXDS;

@GUID("b0edf163-910a-11d2-b632-00c04f79498e")
struct MSVidCtl;

@GUID("c5702ccc-9b79-11d3-b654-00c04f79498e")
struct MSVidInputDevices;

@GUID("c5702ccd-9b79-11d3-b654-00c04f79498e")
struct MSVidOutputDevices;

@GUID("c5702cce-9b79-11d3-b654-00c04f79498e")
struct MSVidVideoRendererDevices;

@GUID("c5702ccf-9b79-11d3-b654-00c04f79498e")
struct MSVidAudioRendererDevices;

@GUID("c5702cd0-9b79-11d3-b654-00c04f79498e")
struct MSVidFeatures;

@GUID("2764bce5-cc39-11d2-b639-00c04f79498e")
struct MSVidGenericComposite;

@GUID("e18af75a-08af-11d3-b64a-00c04f79498e")
struct MSVidAnalogCaptureToOverlayMixer;

@GUID("267db0b3-55e3-4902-949b-df8f5cec0191")
struct MSVidWebDVDToVideoRenderer;

@GUID("8d04238e-9fd1-41c6-8de3-9e1ee309e935")
struct MSVidWebDVDToAudioRenderer;

@GUID("6ad28ee1-5002-4e71-aaf7-bd077907b1a4")
struct MSVidMPEG2DecoderToClosedCaptioning;

@GUID("9f50e8b1-9530-4ddc-825e-1af81d47aed6")
struct MSVidAnalogCaptureToStreamBufferSink;

@GUID("abe40035-27c3-4a2f-8153-6624471608af")
struct MSVidDigitalCaptureToStreamBufferSink;

@GUID("92b94828-1af7-4e6e-9ebf-770657f77af5")
struct MSVidITVToStreamBufferSink;

@GUID("3ef76d68-8661-4843-8b8f-c37163d8c9ce")
struct MSVidCCAToStreamBufferSink;

@GUID("a0b9b497-afbc-45ad-a8a6-9b077c40d4f2")
struct MSVidEncoderToStreamBufferSink;

@GUID("b401c5eb-8457-427f-84ea-a4d2363364b0")
struct MSVidFilePlaybackToVideoRenderer;

@GUID("cc23f537-18d4-4ece-93bd-207a84726979")
struct MSVidFilePlaybackToAudioRenderer;

@GUID("28953661-0231-41db-8986-21ff4388ee9b")
struct MSVidAnalogTVToEncoder;

@GUID("3c4708dc-b181-46a8-8da8-4ab0371758cd")
struct MSVidStreamBufferSourceToVideoRenderer;

@GUID("942b7909-a28e-49a1-a207-34ebcbcb4b3b")
struct MSVidAnalogCaptureToCCA;

@GUID("73d14237-b9db-4efa-a6dd-84350421fb2f")
struct MSVidDigitalCaptureToCCA;

@GUID("5d8e73f7-4989-4ac8-8a98-39ba0d325302")
struct MSVidDigitalCaptureToITV;

@GUID("2291478c-5ee3-4bef-ab5d-b5ff2cf58352")
struct MSVidSBESourceToITV;

@GUID("9193a8f9-0cba-400e-aa97-eb4709164576")
struct MSVidSBESourceToCC;

@GUID("991da7e5-953f-435b-be5e-b92a05edfc42")
struct MSVidSBESourceToGenericSink;

@GUID("c4bf2784-ae00-41ba-9828-9c953bd3c54a")
struct MSVidCCToVMR;

@GUID("d76334ca-d89e-4baf-86ab-ddb59372afc2")
struct MSVidCCToAR;

@GUID("577faa18-4518-445e-8f70-1473f8cf4ba4")
struct MSEventBinder;

@GUID("caafdd83-cefc-4e3d-ba03-175f17a24f91")
struct MSVidStreamBufferRecordingControl;

@GUID("cb4276e6-7d5f-4cf1-9727-629c5e6db6ae")
struct MSVidRect;

@GUID("6e40476f-9c49-4c3e-8bb9-8587958eff74")
struct MSVidDevice;

@GUID("30997f7d-b3b5-4a1c-983a-1fe8098cb77d")
struct MSVidDevice2;

@GUID("ac1972f2-138a-4ca3-90da-ae51112eda28")
struct MSVidInputDevice;

@GUID("95f4820b-bb3a-4e2d-bc64-5b817bc2c30e")
struct MSVidVideoInputDevice;

@GUID("1990d634-1a5e-4071-a34a-53aaffce9f36")
struct MSVidVideoPlaybackDevice;

@GUID("7748530b-c08a-47ea-b24c-be8695ff405f")
struct MSVidFeature;

@GUID("87eb890d-03ad-4e9d-9866-376e5ec572ed")
struct MSVidOutput;

@GUID("dbaf6c1b-b6a4-4898-ae65-204f0d9509a1")
struct Mpeg2DataLib;

@GUID("73da5d04-4347-45d3-a9dc-fae9ddbe558d")
struct SectionList;

@GUID("f91d96c7-8509-4d0b-ab26-a0dd10904bb7")
struct Mpeg2Stream;

@GUID("c666e115-bb62-4027-a113-82d643fe2d99")
struct Mpeg2Data;

@GUID("14eb8748-1753-4393-95ae-4f7e7a87aad6")
struct TIFLoad;

@GUID("83183c03-c09e-45c4-a719-807a94952bf9")
struct EVENTID_TuningChanging;

@GUID("9d7e6235-4b7d-425d-a6d1-d717c33b9c4c")
struct EVENTID_TuningChanged;

@GUID("9f02d3d0-9f06-4369-9f1e-3ad6ca19807e")
struct EVENTID_CandidatePostTuneData;

@GUID("2a65c528-2249-4070-ac16-00390cdfb2dd")
struct EVENTID_CADenialCountChanged;

@GUID("6d9cfaf2-702d-4b01-8dff-6892ad20d191")
struct EVENTID_SignalStatusChanged;

@GUID("c87ec52d-cd18-404a-a076-c02a273d3de7")
struct EVENTID_NewSignalAcquired;

@GUID("d10df9d5-c261-4b85-9e8a-517b3299cab2")
struct EVENTID_EASMessageReceived;

@GUID("1b9c3703-d447-4e16-97bb-01799fc031ed")
struct EVENTID_PSITable;

@GUID("0a1d591c-e0d2-4f8e-8960-2335bef45ccb")
struct EVENTID_ServiceTerminated;

@GUID("a265faea-f874-4b38-9ff7-c53d02969996")
struct EVENTID_CardStatusChanged;

@GUID("000906f5-f0d1-41d6-a7df-4028697669f6")
struct EVENTID_DRMParingStatusChanged;

@GUID("5b2ebf78-b752-4420-b41e-a472dc95828e")
struct EVENTID_DRMParingStepComplete;

@GUID("052c29af-09a4-4b93-890f-bd6a348968a4")
struct EVENTID_MMIMessage;

@GUID("9071ad5d-2359-4c95-8694-afa81d70bfd5")
struct EVENTID_EntitlementChanged;

@GUID("17c4d730-d0f0-413a-8c99-500469de35ad")
struct EVENTID_STBChannelNumber;

@GUID("5ca51711-5ddc-41a6-9430-e41b8b3bbc5b")
struct EVENTID_BDAEventingServicePendingEvent;

@GUID("efc3a459-ae8b-4b4a-8fe9-79a0d097f3ea")
struct EVENTID_BDAConditionalAccessTAG;

@GUID("b2127d42-7be5-4f4b-9130-6679899f4f4b")
struct EVENTTYPE_CASDescrambleFailureEvent;

@GUID("ead831ae-5529-4d1f-afce-0d8cd1257d30")
struct EVENTID_CASFailureSpanningEvent;

@GUID("9067c5e5-4c5c-4205-86c8-7afe20fe1efa")
struct EVENTID_ChannelChangeSpanningEvent;

@GUID("72ab1d51-87d2-489b-ba11-0e08dc210243")
struct EVENTID_ChannelTypeSpanningEvent;

@GUID("41f36d80-4132-4cc2-b121-01a43219d81b")
struct EVENTID_ChannelInfoSpanningEvent;

@GUID("f6cfc8f4-da93-4f2f-bff8-ba1ee6fca3a2")
struct EVENTID_RRTSpanningEvent;

@GUID("efe779d9-97f0-4786-800d-95cf505ddc66")
struct EVENTID_CSDescriptorSpanningEvent;

@GUID("3ab4a2e6-4247-4b34-896c-30afa5d21c24")
struct EVENTID_CtxADescriptorSpanningEvent;

@GUID("4bd4e1c4-90a1-4109-8236-27f00e7dcc5b")
struct EVENTID_DVBScramblingControlSpanningEvent;

@GUID("8068c5cb-3c04-492b-b47d-0308820dce51")
struct EVENTID_SignalAndServiceStatusSpanningEvent;

@GUID("6bf00268-4f7e-4294-aa87-e9e953e43f14")
struct EVENTID_EmmMessageSpanningEvent;

@GUID("501cbfbe-b849-42ce-9be9-3db869fb82b3")
struct EVENTID_AudioTypeSpanningEvent;

@GUID("82af2ebc-30a6-4264-a80b-ad2e1372ac60")
struct EVENTID_StreamTypeSpanningEvent;

@GUID("3a954083-93d0-463e-90b2-0742c496edf0")
struct EVENTID_ARIBcontentSpanningEvent;

@GUID("e292666d-9c02-448d-aa8d-781a93fdc395")
struct EVENTID_LanguageSpanningEvent;

@GUID("a9a29b56-a84b-488c-89d5-0d4e7657c8ce")
struct EVENTID_DualMonoSpanningEvent;

@GUID("47fc8f65-e2bb-4634-9cef-fdbfe6261d5c")
struct EVENTID_PIDListSpanningEvent;

@GUID("107bd41c-a6da-4691-8369-11b2cdaa288e")
struct EVENTID_AudioDescriptorSpanningEvent;

@GUID("5dcec048-d0b9-4163-872c-4f32223be88a")
struct EVENTID_SubtitleSpanningEvent;

@GUID("9599d950-5f33-4617-af7c-1e54b510daa3")
struct EVENTID_TeletextSpanningEvent;

@GUID("caf1ab68-e153-4d41-a6b3-a7c998db75ee")
struct EVENTID_StreamIDSpanningEvent;

@GUID("f947aa85-fb52-48e8-b9c5-e1e1f411a51a")
struct EVENTID_PBDAParentalControlEvent;

@GUID("d97287b2-2dfd-436a-9485-99d7d4ab5a69")
struct EVENTID_TuneFailureEvent;

@GUID("6f8aa455-5ee1-48ab-a27c-4c8d70b9aeba")
struct EVENTID_TuneFailureSpanningEvent;

@GUID("2a67a58d-eca5-4eac-abcb-e734d3776d0a")
struct EVENTID_DvbParentalRatingDescriptor;

@GUID("f5689ffe-55f9-4bb3-96be-ae971c63bae0")
struct EVENTID_DFNWithNoActualAVData;

@GUID("71985f41-1ca1-11d3-9cc8-00c04f7971e0")
struct KSDATAFORMAT_TYPE_BDA_ANTENNA;

@GUID("f4aeb342-0329-4fdd-a8fd-4aff4926c978")
struct KSDATAFORMAT_SUBTYPE_BDA_MPEG2_TRANSPORT;

@GUID("8deda6fd-ac5f-4334-8ecf-a4ba8fa7d0f0")
struct KSDATAFORMAT_SPECIFIER_BDA_TRANSPORT;

@GUID("61be0b47-a5eb-499b-9a85-5b16c07f1258")
struct KSDATAFORMAT_TYPE_BDA_IF_SIGNAL;

@GUID("455f176c-4b06-47ce-9aef-8caef73df7b5")
struct KSDATAFORMAT_TYPE_MPEG2_SECTIONS;

@GUID("b3c7397c-d303-414d-b33c-4ed2c9d29733")
struct KSDATAFORMAT_SUBTYPE_ATSC_SI;

@GUID("e9dd31a3-221d-4adb-8532-9af309c1a408")
struct KSDATAFORMAT_SUBTYPE_DVB_SI;

@GUID("762e3f66-336f-48d1-bf83-2b00352c11f0")
struct KSDATAFORMAT_SUBTYPE_BDA_OPENCABLE_PSIP;

@GUID("951727db-d2ce-4528-96f6-3301fabb2de0")
struct KSDATAFORMAT_SUBTYPE_BDA_OPENCABLE_OOB_PSIP;

@GUID("4a2eeb99-6458-4538-b187-04017c41413f")
struct KSDATAFORMAT_SUBTYPE_ISDB_SI;

@GUID("0d7aed42-cb9a-11db-9705-005056c00008")
struct KSDATAFORMAT_SUBTYPE_PBDA_TRANSPORT_RAW;

@GUID("78216a81-cfa8-493e-9711-36a61c08bd9d")
struct PINNAME_BDA_TRANSPORT;

@GUID("5c0c8281-5667-486c-8482-63e31f01a6e9")
struct PINNAME_BDA_ANALOG_VIDEO;

@GUID("d28a580a-9b1f-4b0c-9c33-9bf0a8ea636b")
struct PINNAME_BDA_ANALOG_AUDIO;

@GUID("d2855fed-b2d3-4eeb-9bd0-193436a2f890")
struct PINNAME_BDA_FM_RADIO;

@GUID("1a9d4a42-f3cd-48a1-9aea-71de133cbe14")
struct PINNAME_BDA_IF_PIN;

@GUID("297bb104-e5c9-4ace-b123-95c3cbb24d4f")
struct PINNAME_BDA_OPENCABLE_PSIP_PIN;

@GUID("71985f43-1ca1-11d3-9cc8-00c04f7971e0")
struct KSPROPSETID_BdaEthernetFilter;

@GUID("71985f44-1ca1-11d3-9cc8-00c04f7971e0")
struct KSPROPSETID_BdaIPv4Filter;

@GUID("e1785a74-2a23-4fb3-9245-a8f88017ef33")
struct KSPROPSETID_BdaIPv6Filter;

@GUID("1347d106-cf3a-428a-a5cb-ac0d9a2a4338")
struct KSPROPSETID_BdaSignalStats;

@GUID("fd0a5af3-b41d-11d2-9c95-00c04f7971e0")
struct KSMETHODSETID_BdaChangeSync;

@GUID("71985f45-1ca1-11d3-9cc8-00c04f7971e0")
struct KSMETHODSETID_BdaDeviceConfiguration;

@GUID("a14ee835-0a23-11d3-9cc7-00c04f7971e0")
struct KSPROPSETID_BdaTopology;

@GUID("0ded49d5-a8b7-4d5d-97a1-12b0c195874d")
struct KSPROPSETID_BdaPinControl;

@GUID("104781cd-50bd-40d5-95fb-087e0e86a591")
struct KSEVENTSETID_BdaPinEvent;

@GUID("71985f46-1ca1-11d3-9cc8-00c04f7971e0")
struct KSPROPSETID_BdaVoidTransform;

@GUID("ddf15b0d-bd25-11d2-9ca0-00c04f7971e0")
struct KSPROPSETID_BdaNullTransform;

@GUID("71985f47-1ca1-11d3-9cc8-00c04f7971e0")
struct KSPROPSETID_BdaFrequencyFilter;

@GUID("aab59e17-01c9-4ebf-93f2-fc3b79b46f91")
struct KSEVENTSETID_BdaTunerEvent;

@GUID("992cf102-49f9-4719-a664-c4f23e2408f4")
struct KSPROPSETID_BdaLNBInfo;

@GUID("f84e2ab0-3c6b-45e3-a0fc-8669d4b81f11")
struct KSPROPSETID_BdaDiseqCommand;

@GUID("8b19bbf0-4184-43ac-ad3c-0c889be4c212")
struct KSEVENTSETID_BdaDiseqCEvent;

@GUID("ef30f379-985b-4d10-b640-a79d5e04e1e0")
struct KSPROPSETID_BdaDigitalDemodulator;

@GUID("ddf15b12-bd25-11d2-9ca0-00c04f7971e0")
struct KSPROPSETID_BdaAutodemodulate;

@GUID("516b99c5-971c-4aaf-b3f3-d9fda8a15e16")
struct KSPROPSETID_BdaTableSection;

@GUID("d0a67d65-08df-4fec-8533-e5b550410b85")
struct KSPROPSETID_BdaPIDFilter;

@GUID("b0693766-5278-4ec6-b9e1-3ce40560ef5a")
struct KSPROPSETID_BdaCA;

@GUID("488c4ccc-b768-4129-8eb1-b00a071f9068")
struct KSEVENTSETID_BdaCAEvent;

@GUID("bff6b5bb-b0ae-484c-9dca-73528fb0b46e")
struct KSMETHODSETID_BdaDrmService;

@GUID("4be6fa3d-07cd-4139-8b80-8c18ba3aec88")
struct KSMETHODSETID_BdaWmdrmSession;

@GUID("86d979cf-a8a7-4f94-b5fb-14c0aca68fe6")
struct KSMETHODSETID_BdaWmdrmTuner;

@GUID("f99492da-6193-4eb0-8690-6686cbff713e")
struct KSMETHODSETID_BdaEventing;

@GUID("ae7e55b2-96d7-4e29-908f-62f95b2a1679")
struct KSEVENTSETID_BdaEvent;

@GUID("0d4a90ec-c69d-4ee2-8c5a-fb1f63a50da1")
struct KSMETHODSETID_BdaDebug;

@GUID("b774102f-ac07-478a-8228-2742d961fa7e")
struct KSMETHODSETID_BdaTuner;

@GUID("0c24096d-5ff5-47de-a856-062e587e3727")
struct KSMETHODSETID_BdaNameValueA;

@GUID("36e07304-9f0d-4e88-9118-ac0ba317b7f2")
struct KSMETHODSETID_BdaNameValue;

@GUID("942aafec-4c05-4c74-b8eb-8706c2a4943f")
struct KSMETHODSETID_BdaMux;

@GUID("12eb49df-6249-47f3-b190-e21e6e2f8a9c")
struct KSMETHODSETID_BdaScanning;

@GUID("8d9d5562-1589-417d-99ce-ac531dda19f9")
struct KSMETHODSETID_BdaGuideDataDeliveryService;

@GUID("10ced3b4-320b-41bf-9824-1b2e68e71eb9")
struct KSMETHODSETID_BdaConditionalAccessService;

@GUID("5e68c627-16c2-4e6c-b1e2-d00170cdaa0f")
struct KSMETHODSETID_BdaIsdbConditionalAccess;

@GUID("1dcfafe9-b45e-41b3-bb2a-561eb129ae98")
struct KSMETHODSETID_BdaTSSelector;

@GUID("eda5c834-4531-483c-be0a-94e6c96ff396")
struct KSMETHODSETID_BdaUserActivity;

@GUID("fd0a5af4-b41d-11d2-9c95-00c04f7971e0")
struct KSCATEGORY_BDA_RECEIVER_COMPONENT;

@GUID("71985f48-1ca1-11d3-9cc8-00c04f7971e0")
struct KSCATEGORY_BDA_NETWORK_TUNER;

@GUID("71985f49-1ca1-11d3-9cc8-00c04f7971e0")
struct KSCATEGORY_BDA_NETWORK_EPG;

@GUID("71985f4a-1ca1-11d3-9cc8-00c04f7971e0")
struct KSCATEGORY_BDA_IP_SINK;

@GUID("71985f4b-1ca1-11d3-9cc8-00c04f7971e0")
struct KSCATEGORY_BDA_NETWORK_PROVIDER;

@GUID("a2e3074f-6c3d-11d3-b653-00c04f79498e")
struct KSCATEGORY_BDA_TRANSPORT_INFORMATION;

@GUID("71985f4c-1ca1-11d3-9cc8-00c04f7971e0")
struct KSNODE_BDA_RF_TUNER;

@GUID("634db199-27dd-46b8-acfb-ecc98e61a2ad")
struct KSNODE_BDA_ANALOG_DEMODULATOR;

@GUID("71985f4d-1ca1-11d3-9cc8-00c04f7971e0")
struct KSNODE_BDA_QAM_DEMODULATOR;

@GUID("6390c905-27c1-4d67-bdb7-77c50d079300")
struct KSNODE_BDA_QPSK_DEMODULATOR;

@GUID("71985f4f-1ca1-11d3-9cc8-00c04f7971e0")
struct KSNODE_BDA_8VSB_DEMODULATOR;

@GUID("2dac6e05-edbe-4b9c-b387-1b6fad7d6495")
struct KSNODE_BDA_COFDM_DEMODULATOR;

@GUID("e957a0e7-dd98-4a3c-810b-3525157ab62e")
struct KSNODE_BDA_8PSK_DEMODULATOR;

@GUID("fcea3ae3-2cb2-464d-8f5d-305c0bb778a2")
struct KSNODE_BDA_ISDB_T_DEMODULATOR;

@GUID("edde230a-9086-432d-b8a5-6670263807e9")
struct KSNODE_BDA_ISDB_S_DEMODULATOR;

@GUID("345812a0-fb7c-4790-aa7e-b1db88ac19c9")
struct KSNODE_BDA_OPENCABLE_POD;

@GUID("d83ef8fc-f3b8-45ab-8b71-ecf7c339deb4")
struct KSNODE_BDA_COMMON_CA_POD;

@GUID("f5412789-b0a0-44e1-ae4f-ee999b1b7fbe")
struct KSNODE_BDA_PID_FILTER;

@GUID("71985f4e-1ca1-11d3-9cc8-00c04f7971e0")
struct KSNODE_BDA_IP_SINK;

@GUID("d98429e3-65c9-4ac4-93aa-766782833b7a")
struct KSNODE_BDA_VIDEO_ENCODER;

@GUID("c026869f-7129-4e71-8696-ec8f75299b77")
struct KSNODE_BDA_PBDA_CAS;

@GUID("f2cf2ab3-5b9d-40ae-ab7c-4e7ad0bd1c52")
struct KSNODE_BDA_PBDA_ISDBCAS;

@GUID("aa5e8286-593c-4979-9494-46a2a9dfe076")
struct KSNODE_BDA_PBDA_TUNER;

@GUID("f88c7787-6678-4f4b-a13e-da09861d682b")
struct KSNODE_BDA_PBDA_MUX;

@GUID("9eeebd03-eea1-450f-96ae-633e6de63cce")
struct KSNODE_BDA_PBDA_DRM;

@GUID("4f95ad74-cefb-42d2-94a9-68c5b2c1aabe")
struct KSNODE_BDA_DRI_DRM;

@GUID("5eddf185-fed1-4f45-9685-bbb73c323cfc")
struct KSNODE_BDA_TS_SELECTOR;

@GUID("3fdffa70-ac9a-11d2-8f17-00c04f7971e2")
struct PINNAME_IPSINK_INPUT;

@GUID("e25f7b8e-cccc-11d2-8f25-00c04f7971e2")
struct KSDATAFORMAT_TYPE_BDA_IP;

@GUID("5a9a213c-db08-11d2-8f32-00c04f7971e2")
struct KSDATAFORMAT_SUBTYPE_BDA_IP;

@GUID("6b891420-db09-11d2-8f32-00c04f7971e2")
struct KSDATAFORMAT_SPECIFIER_BDA_IP;

@GUID("dadd5799-7d5b-4b63-80fb-d1442f26b621")
struct KSDATAFORMAT_TYPE_BDA_IP_CONTROL;

@GUID("499856e8-e85b-48ed-9bea-410d0dd4ef81")
struct KSDATAFORMAT_SUBTYPE_BDA_IP_CONTROL;

@GUID("c1b06d73-1dbb-11d3-8f46-00c04f7971e2")
struct PINNAME_MPE;

@GUID("455f176c-4b06-47ce-9aef-8caef73df7b5")
struct KSDATAFORMAT_TYPE_MPE;

@GUID("143827ab-f77b-498d-81ca-5a007aec28bf")
struct DIGITAL_CABLE_NETWORK_TYPE;

@GUID("b820d87e-e0e3-478f-8a38-4e13f7b3df42")
struct ANALOG_TV_NETWORK_TYPE;

@GUID("742ef867-09e1-40a3-82d3-9669ba35325f")
struct ANALOG_AUXIN_NETWORK_TYPE;

@GUID("7728087b-2bb9-4e30-8078-449476e59dbb")
struct ANALOG_FM_NETWORK_TYPE;

@GUID("95037f6f-3ac7-4452-b6c4-45a9ce9292a2")
struct ISDB_TERRESTRIAL_TV_NETWORK_TYPE;

@GUID("fc3855a6-c901-4f2e-aba8-90815afc6c83")
struct ISDB_T_NETWORK_TYPE;

@GUID("b0a4e6a0-6a1a-4b83-bb5b-903e1d90e6b6")
struct ISDB_SATELLITE_TV_NETWORK_TYPE;

@GUID("a1e78202-1459-41b1-9ca9-2a92587a42cc")
struct ISDB_S_NETWORK_TYPE;

@GUID("c974ddb5-41fe-4b25-9741-92f049f1d5d1")
struct ISDB_CABLE_TV_NETWORK_TYPE;

@GUID("93b66fb5-93d4-4323-921c-c1f52df61d3f")
struct DIRECT_TV_SATELLITE_TV_NETWORK_TYPE;

@GUID("c4f6b31b-c6bf-4759-886f-a7386dca27a0")
struct ECHOSTAR_SATELLITE_TV_NETWORK_TYPE;

@GUID("0dad2fdd-5fd7-11d3-8f50-00c04f7971e2")
struct ATSC_TERRESTRIAL_TV_NETWORK_TYPE;

@GUID("216c62df-6d7f-4e9a-8571-05f14edb766a")
struct DVB_TERRESTRIAL_TV_NETWORK_TYPE;

@GUID("9e9e46c6-3aba-4f08-ad0e-cc5ac8148c2b")
struct BSKYB_TERRESTRIAL_TV_NETWORK_TYPE;

@GUID("fa4b375a-45b4-4d45-8440-263957b11623")
struct DVB_SATELLITE_TV_NETWORK_TYPE;

@GUID("dc0c0fe7-0485-4266-b93f-68fbf80ed834")
struct DVB_CABLE_TV_NETWORK_TYPE;

@GUID("69c24f54-9983-497e-b415-282be4c555fb")
struct BDA_DEBUG_DATA_AVAILABLE;

@GUID("a806e767-de5c-430c-80bf-a21ebe06c748")
struct BDA_DEBUG_DATA_TYPE_STRING;

@GUID("d4cb1966-41bc-4ced-9a20-fdceac78f70d")
struct EVENTID_BDA_IsdbCASResponse;

@GUID("cf39a9d8-f5d3-4685-be57-ed81dba46b27")
struct EVENTID_BDA_CASRequestTuner;

@GUID("20c1a16b-441f-49a5-bb5c-e9a04495c6c1")
struct EVENTID_BDA_CASReleaseTuner;

@GUID("85dac915-e593-410d-8471-d6812105f28e")
struct EVENTID_BDA_CASOpenMMI;

@GUID("5d0f550f-de2e-479d-8345-ec0e9557e8a2")
struct EVENTID_BDA_CASCloseMMI;

@GUID("676876f0-1132-404c-a7ca-e72069a9d54f")
struct EVENTID_BDA_CASBroadcastMMI;

@GUID("1872e740-f573-429b-a00e-d9c1e408af09")
struct EVENTID_BDA_TunerSignalLock;

@GUID("e29b382b-1edd-4930-bc46-682fd72d2dfb")
struct EVENTID_BDA_TunerNoSignal;

@GUID("ff75c68c-f416-4e7e-bf17-6d55c5df1575")
struct EVENTID_BDA_GPNVValueUpdate;

@GUID("65a6f681-1462-473b-88ce-cb731427bdb5")
struct EVENTID_BDA_UpdateDrmStatus;

@GUID("55702b50-7b49-42b8-a82f-4afb691b0628")
struct EVENTID_BDA_UpdateScanState;

@GUID("98db717a-478a-4cd4-92d0-95f66b89e5b1")
struct EVENTID_BDA_GuideDataAvailable;

@GUID("a1c3ea2b-175f-4458-b735-507d22db23a6")
struct EVENTID_BDA_GuideServiceInformationUpdated;

@GUID("ac33c448-6f73-4fd7-b341-594c360d8d74")
struct EVENTID_BDA_GuideDataError;

@GUID("efa628f8-1f2c-4b67-9ea5-acf6fa9a1f36")
struct EVENTID_BDA_DiseqCResponseAvailable;

@GUID("356207b2-6f31-4eb0-a271-b3fa6bb7680f")
struct EVENTID_BDA_LbigsOpenConnection;

@GUID("1123277b-f1c6-4154-8b0d-48e6157059aa")
struct EVENTID_BDA_LbigsSendData;

@GUID("c2f08b99-65ef-4314-9671-e99d4cce0bae")
struct EVENTID_BDA_LbigsCloseConnectionHandle;

@GUID("5ec90eb9-39fa-4cfc-b93f-00bb11077f5e")
struct EVENTID_BDA_EncoderSignalLock;

@GUID("05f25366-d0eb-43d2-bc3c-682b863df142")
struct EVENTID_BDA_FdcStatus;

@GUID("6a0cd757-4ce3-4e5b-9444-7187b87152c5")
struct EVENTID_BDA_FdcTableSection;

@GUID("c40f9f85-09d0-489c-9e9c-0abbb56951b0")
struct EVENTID_BDA_TransprtStreamSelectorInfo;

@GUID("c6e048c0-c574-4c26-bcda-2f4d35eb5e85")
struct EVENTID_BDA_RatingPinReset;

@GUID("1e1d7141-583f-4ac2-b019-1f430eda0f4c")
struct PBDA_ALWAYS_TUNE_IN_MUX;

@GUID("71985f51-1ca1-11d3-9cc8-00c04f7971e0")
struct BDANETWORKTYPE_ATSC;

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/regbag/nn-regbag-icreatepropbagonregkey
@GUID("8a674b48-1f63-11d3-b64c-00c04f79498e")
interface ICreatePropBagOnRegKey : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/regbag/nf-regbag-icreatepropbagonregkey-create
    HRESULT Create(HKEY hkey, const(PWSTR) subkey, uint ulOptions, uint samDesired, const(GUID)* iid, void** ppBag);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nn-tuner-ituningspaces
@GUID("901284e4-33fe-4b69-8d63-634a596f3756")
interface ITuningSpaces : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ituningspaces-get_count
    HRESULT get_Count(int* Count);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ituningspaces-get__newenum
    HRESULT get__NewEnum(IEnumVARIANT* NewEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ituningspaces-get_item
    HRESULT get_Item(VARIANT varIndex, ITuningSpace* TuningSpace);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ituningspaces-get_enumtuningspaces
    HRESULT get_EnumTuningSpaces(IEnumTuningSpaces* NewEnum);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nn-tuner-ituningspacecontainer
@GUID("5b692e84-e2f1-11d2-9493-00c04f72d980")
interface ITuningSpaceContainer : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ituningspacecontainer-get_count
    HRESULT get_Count(int* Count);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ituningspacecontainer-get__newenum
    HRESULT get__NewEnum(IEnumVARIANT* NewEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ituningspacecontainer-get_item
    HRESULT get_Item(VARIANT varIndex, ITuningSpace* TuningSpace);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ituningspacecontainer-put_item
    HRESULT put_Item(VARIANT varIndex, ITuningSpace TuningSpace);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ituningspacecontainer-tuningspacesforclsid
    HRESULT TuningSpacesForCLSID(BSTR SpaceCLSID, ITuningSpaces* NewColl);
    HRESULT _TuningSpacesForCLSID2(const(GUID)* SpaceCLSID, ITuningSpaces* NewColl);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ituningspacecontainer-tuningspacesforname
    HRESULT TuningSpacesForName(BSTR Name, ITuningSpaces* NewColl);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ituningspacecontainer-findid
    HRESULT FindID(ITuningSpace TuningSpace, int* ID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ituningspacecontainer-add
    HRESULT Add(ITuningSpace TuningSpace, VARIANT* NewIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ituningspacecontainer-get_enumtuningspaces
    HRESULT get_EnumTuningSpaces(IEnumTuningSpaces* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ituningspacecontainer-remove
    HRESULT Remove(VARIANT Index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ituningspacecontainer-get_maxcount
    HRESULT get_MaxCount(int* MaxCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ituningspacecontainer-put_maxcount
    HRESULT put_MaxCount(int MaxCount);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nn-tuner-ituningspace
@GUID("061c6e30-e622-11d2-9493-00c04f72d980")
interface ITuningSpace : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ituningspace-get_uniquename
    HRESULT get_UniqueName(BSTR* Name);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ituningspace-put_uniquename
    HRESULT put_UniqueName(BSTR Name);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ituningspace-get_friendlyname
    HRESULT get_FriendlyName(BSTR* Name);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ituningspace-put_friendlyname
    HRESULT put_FriendlyName(BSTR Name);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ituningspace-get_clsid
    HRESULT get_CLSID(BSTR* SpaceCLSID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ituningspace-get_networktype
    HRESULT get_NetworkType(BSTR* NetworkTypeGuid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ituningspace-put_networktype
    HRESULT put_NetworkType(BSTR NetworkTypeGuid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ituningspace-get__networktype
    HRESULT get__NetworkType(GUID* NetworkTypeGuid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ituningspace-put__networktype
    HRESULT put__NetworkType(const(GUID)* NetworkTypeGuid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ituningspace-createtunerequest
    HRESULT CreateTuneRequest(ITuneRequest* TuneRequest);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ituningspace-enumcategoryguids
    HRESULT EnumCategoryGUIDs(IEnumGUID* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ituningspace-enumdevicemonikers
    HRESULT EnumDeviceMonikers(IEnumMoniker* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ituningspace-get_defaultpreferredcomponenttypes
    HRESULT get_DefaultPreferredComponentTypes(IComponentTypes* ComponentTypes);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ituningspace-put_defaultpreferredcomponenttypes
    HRESULT put_DefaultPreferredComponentTypes(IComponentTypes NewComponentTypes);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ituningspace-get_frequencymapping
    HRESULT get_FrequencyMapping(BSTR* pMapping);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ituningspace-put_frequencymapping
    HRESULT put_FrequencyMapping(BSTR Mapping);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ituningspace-get_defaultlocator
    HRESULT get_DefaultLocator(ILocator* LocatorVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ituningspace-put_defaultlocator
    HRESULT put_DefaultLocator(ILocator LocatorVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ituningspace-clone
    HRESULT Clone(ITuningSpace* NewTS);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nn-tuner-ienumtuningspaces
@GUID("8b8eb248-fc2b-11d2-9d8c-00c04f72d980")
interface IEnumTuningSpaces : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ienumtuningspaces-next
    HRESULT Next(uint celt, ITuningSpace* rgelt, uint* pceltFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ienumtuningspaces-skip
    HRESULT Skip(uint celt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ienumtuningspaces-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ienumtuningspaces-clone
    HRESULT Clone(IEnumTuningSpaces* ppEnum);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nn-tuner-idvbtuningspace
@GUID("ada0b268-3b19-4e5b-acc4-49f852be13ba")
interface IDVBTuningSpace : ITuningSpace
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idvbtuningspace-get_systemtype
    HRESULT get_SystemType(DVBSystemType* SysType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idvbtuningspace-put_systemtype
    HRESULT put_SystemType(DVBSystemType SysType);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nn-tuner-idvbtuningspace2
@GUID("843188b4-ce62-43db-966b-8145a094e040")
interface IDVBTuningSpace2 : IDVBTuningSpace
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idvbtuningspace2-get_networkid
    HRESULT get_NetworkID(int* NetworkID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idvbtuningspace2-put_networkid
    HRESULT put_NetworkID(int NetworkID);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nn-tuner-idvbstuningspace
@GUID("cdf7be60-d954-42fd-a972-78971958e470")
interface IDVBSTuningSpace : IDVBTuningSpace2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idvbstuningspace-get_lowoscillator
    HRESULT get_LowOscillator(int* LowOscillator);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idvbstuningspace-put_lowoscillator
    HRESULT put_LowOscillator(int LowOscillator);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idvbstuningspace-get_highoscillator
    HRESULT get_HighOscillator(int* HighOscillator);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idvbstuningspace-put_highoscillator
    HRESULT put_HighOscillator(int HighOscillator);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idvbstuningspace-get_lnbswitch
    HRESULT get_LNBSwitch(int* LNBSwitch);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idvbstuningspace-put_lnbswitch
    HRESULT put_LNBSwitch(int LNBSwitch);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idvbstuningspace-get_inputrange
    HRESULT get_InputRange(BSTR* InputRange);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idvbstuningspace-put_inputrange
    HRESULT put_InputRange(BSTR InputRange);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idvbstuningspace-get_spectralinversion
    HRESULT get_SpectralInversion(SpectralInversion* SpectralInversionVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idvbstuningspace-put_spectralinversion
    HRESULT put_SpectralInversion(SpectralInversion SpectralInversionVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nn-tuner-iauxintuningspace
@GUID("e48244b8-7e17-4f76-a763-5090ff1e2f30")
interface IAuxInTuningSpace : ITuningSpace
{
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nn-tuner-iauxintuningspace2
@GUID("b10931ed-8bfe-4ab0-9dce-e469c29a9729")
interface IAuxInTuningSpace2 : IAuxInTuningSpace
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-iauxintuningspace2-get_countrycode
    HRESULT get_CountryCode(int* CountryCodeVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-iauxintuningspace2-put_countrycode
    HRESULT put_CountryCode(int NewCountryCodeVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nn-tuner-ianalogtvtuningspace
@GUID("2a6e293c-2595-11d3-b64c-00c04f79498e")
interface IAnalogTVTuningSpace : ITuningSpace
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ianalogtvtuningspace-get_minchannel
    HRESULT get_MinChannel(int* MinChannelVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ianalogtvtuningspace-put_minchannel
    HRESULT put_MinChannel(int NewMinChannelVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ianalogtvtuningspace-get_maxchannel
    HRESULT get_MaxChannel(int* MaxChannelVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ianalogtvtuningspace-put_maxchannel
    HRESULT put_MaxChannel(int NewMaxChannelVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ianalogtvtuningspace-get_inputtype
    HRESULT get_InputType(TunerInputType* InputTypeVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ianalogtvtuningspace-put_inputtype
    HRESULT put_InputType(TunerInputType NewInputTypeVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ianalogtvtuningspace-get_countrycode
    HRESULT get_CountryCode(int* CountryCodeVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ianalogtvtuningspace-put_countrycode
    HRESULT put_CountryCode(int NewCountryCodeVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nn-tuner-iatsctuningspace
@GUID("0369b4e2-45b6-11d3-b650-00c04f79498e")
interface IATSCTuningSpace : IAnalogTVTuningSpace
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-iatsctuningspace-get_minminorchannel
    HRESULT get_MinMinorChannel(int* MinMinorChannelVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-iatsctuningspace-put_minminorchannel
    HRESULT put_MinMinorChannel(int NewMinMinorChannelVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-iatsctuningspace-get_maxminorchannel
    HRESULT get_MaxMinorChannel(int* MaxMinorChannelVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-iatsctuningspace-put_maxminorchannel
    HRESULT put_MaxMinorChannel(int NewMaxMinorChannelVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-iatsctuningspace-get_minphysicalchannel
    HRESULT get_MinPhysicalChannel(int* MinPhysicalChannelVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-iatsctuningspace-put_minphysicalchannel
    HRESULT put_MinPhysicalChannel(int NewMinPhysicalChannelVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-iatsctuningspace-get_maxphysicalchannel
    HRESULT get_MaxPhysicalChannel(int* MaxPhysicalChannelVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-iatsctuningspace-put_maxphysicalchannel
    HRESULT put_MaxPhysicalChannel(int NewMaxPhysicalChannelVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nn-tuner-idigitalcabletuningspace
@GUID("013f9f9c-b449-4ec7-a6d2-9d4f2fc70ae5")
interface IDigitalCableTuningSpace : IATSCTuningSpace
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idigitalcabletuningspace-get_minmajorchannel
    HRESULT get_MinMajorChannel(int* MinMajorChannelVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idigitalcabletuningspace-put_minmajorchannel
    HRESULT put_MinMajorChannel(int NewMinMajorChannelVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idigitalcabletuningspace-get_maxmajorchannel
    HRESULT get_MaxMajorChannel(int* MaxMajorChannelVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idigitalcabletuningspace-put_maxmajorchannel
    HRESULT put_MaxMajorChannel(int NewMaxMajorChannelVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idigitalcabletuningspace-get_minsourceid
    HRESULT get_MinSourceID(int* MinSourceIDVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idigitalcabletuningspace-put_minsourceid
    HRESULT put_MinSourceID(int NewMinSourceIDVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idigitalcabletuningspace-get_maxsourceid
    HRESULT get_MaxSourceID(int* MaxSourceIDVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idigitalcabletuningspace-put_maxsourceid
    HRESULT put_MaxSourceID(int NewMaxSourceIDVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nn-tuner-ianalogradiotuningspace
@GUID("2a6e293b-2595-11d3-b64c-00c04f79498e")
interface IAnalogRadioTuningSpace : ITuningSpace
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ianalogradiotuningspace-get_minfrequency
    HRESULT get_MinFrequency(int* MinFrequencyVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ianalogradiotuningspace-put_minfrequency
    HRESULT put_MinFrequency(int NewMinFrequencyVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ianalogradiotuningspace-get_maxfrequency
    HRESULT get_MaxFrequency(int* MaxFrequencyVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ianalogradiotuningspace-put_maxfrequency
    HRESULT put_MaxFrequency(int NewMaxFrequencyVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ianalogradiotuningspace-get_step
    HRESULT get_Step(int* StepVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ianalogradiotuningspace-put_step
    HRESULT put_Step(int NewStepVal);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nn-tuner-ianalogradiotuningspace2
@GUID("39dd45da-2da8-46ba-8a8a-87e2b73d983a")
interface IAnalogRadioTuningSpace2 : IAnalogRadioTuningSpace
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ianalogradiotuningspace2-get_countrycode
    HRESULT get_CountryCode(int* CountryCodeVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ianalogradiotuningspace2-put_countrycode
    HRESULT put_CountryCode(int NewCountryCodeVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nn-tuner-itunerequest
@GUID("07ddc146-fc3d-11d2-9d8c-00c04f72d980")
interface ITuneRequest : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-itunerequest-get_tuningspace
    HRESULT get_TuningSpace(ITuningSpace* TuningSpace);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-itunerequest-get_components
    HRESULT get_Components(IComponents* Components);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-itunerequest-clone
    HRESULT Clone(ITuneRequest* NewTuneRequest);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-itunerequest-get_locator
    HRESULT get_Locator(ILocator* Locator);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-itunerequest-put_locator
    HRESULT put_Locator(ILocator Locator);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nn-tuner-ichannelidtunerequest
@GUID("156eff60-86f4-4e28-89fc-109799fd57ee")
interface IChannelIDTuneRequest : ITuneRequest
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ichannelidtunerequest-get_channelid
    HRESULT get_ChannelID(BSTR* ChannelID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ichannelidtunerequest-put_channelid
    HRESULT put_ChannelID(BSTR ChannelID);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nn-tuner-ichanneltunerequest
@GUID("0369b4e0-45b6-11d3-b650-00c04f79498e")
interface IChannelTuneRequest : ITuneRequest
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ichanneltunerequest-get_channel
    HRESULT get_Channel(int* Channel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ichanneltunerequest-put_channel
    HRESULT put_Channel(int Channel);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nn-tuner-iatscchanneltunerequest
@GUID("0369b4e1-45b6-11d3-b650-00c04f79498e")
interface IATSCChannelTuneRequest : IChannelTuneRequest
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-iatscchanneltunerequest-get_minorchannel
    HRESULT get_MinorChannel(int* MinorChannel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-iatscchanneltunerequest-put_minorchannel
    HRESULT put_MinorChannel(int MinorChannel);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nn-tuner-idigitalcabletunerequest
@GUID("bad7753b-6b37-4810-ae57-3ce0c4a9e6cb")
interface IDigitalCableTuneRequest : IATSCChannelTuneRequest
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idigitalcabletunerequest-get_majorchannel
    HRESULT get_MajorChannel(int* pMajorChannel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idigitalcabletunerequest-put_majorchannel
    HRESULT put_MajorChannel(int MajorChannel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idigitalcabletunerequest-get_sourceid
    HRESULT get_SourceID(int* pSourceID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idigitalcabletunerequest-put_sourceid
    HRESULT put_SourceID(int SourceID);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nn-tuner-idvbtunerequest
@GUID("0d6f567e-a636-42bb-83ba-ce4c1704afa2")
interface IDVBTuneRequest : ITuneRequest
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idvbtunerequest-get_onid
    HRESULT get_ONID(int* ONID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idvbtunerequest-put_onid
    HRESULT put_ONID(int ONID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idvbtunerequest-get_tsid
    HRESULT get_TSID(int* TSID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idvbtunerequest-put_tsid
    HRESULT put_TSID(int TSID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idvbtunerequest-get_sid
    HRESULT get_SID(int* SID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idvbtunerequest-put_sid
    HRESULT put_SID(int SID);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nn-tuner-impeg2tunerequest
@GUID("eb7d987f-8a01-42ad-b8ae-574deee44d1a")
interface IMPEG2TuneRequest : ITuneRequest
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-impeg2tunerequest-get_tsid
    HRESULT get_TSID(int* TSID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-impeg2tunerequest-put_tsid
    HRESULT put_TSID(int TSID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-impeg2tunerequest-get_progno
    HRESULT get_ProgNo(int* ProgNo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-impeg2tunerequest-put_progno
    HRESULT put_ProgNo(int ProgNo);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nn-tuner-impeg2tunerequestfactory
@GUID("14e11abd-ee37-4893-9ea1-6964de933e39")
interface IMPEG2TuneRequestFactory : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-impeg2tunerequestfactory-createtunerequest
    HRESULT CreateTuneRequest(ITuningSpace TuningSpace, IMPEG2TuneRequest* TuneRequest);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nn-tuner-impeg2tunerequestsupport
@GUID("1b9d5fc3-5bbc-4b6c-bb18-b9d10e3eeebf")
interface IMPEG2TuneRequestSupport : IUnknown
{
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nn-tuner-itunercap
@GUID("e60dfa45-8d56-4e65-a8ab-d6be9412c249")
interface ITunerCap : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-itunercap-get_supportednetworktypes
    HRESULT get_SupportedNetworkTypes(uint ulcNetworkTypesMax, uint* pulcNetworkTypes, GUID* pguidNetworkTypes);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-itunercap-get_supportedvideoformats
    HRESULT get_SupportedVideoFormats(uint* pulAMTunerModeType, uint* pulAnalogVideoStandard);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-itunercap-get_auxinputcount
    HRESULT get_AuxInputCount(uint* pulCompositeCount, uint* pulSvideoCount);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nn-tuner-itunercapex
@GUID("ed3e0c66-18c8-4ea6-9300-f6841fdd35dc")
interface ITunerCapEx : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-itunercapex-get_has608_708caption
    HRESULT get_Has608_708Caption(VARIANT_BOOL* pbHasCaption);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nn-tuner-ituner
@GUID("28c52640-018a-11d3-9d8e-00c04f72d980")
interface ITuner : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ituner-get_tuningspace
    HRESULT get_TuningSpace(ITuningSpace* TuningSpace);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ituner-put_tuningspace
    HRESULT put_TuningSpace(ITuningSpace TuningSpace);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ituner-enumtuningspaces
    HRESULT EnumTuningSpaces(IEnumTuningSpaces* ppEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ituner-get_tunerequest
    HRESULT get_TuneRequest(ITuneRequest* TuneRequest);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ituner-put_tunerequest
    HRESULT put_TuneRequest(ITuneRequest TuneRequest);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ituner-validate
    HRESULT Validate(ITuneRequest TuneRequest);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ituner-get_preferredcomponenttypes
    HRESULT get_PreferredComponentTypes(IComponentTypes* ComponentTypes);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ituner-put_preferredcomponenttypes
    HRESULT put_PreferredComponentTypes(IComponentTypes ComponentTypes);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ituner-get_signalstrength
    HRESULT get_SignalStrength(int* Strength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ituner-triggersignalevents
    HRESULT TriggerSignalEvents(int Interval);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nn-tuner-iscanningtuner
@GUID("1dfd0a5c-0284-11d3-9d8e-00c04f72d980")
interface IScanningTuner : ITuner
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-iscanningtuner-seekup
    HRESULT SeekUp();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-iscanningtuner-seekdown
    HRESULT SeekDown();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-iscanningtuner-scanup
    HRESULT ScanUp(int MillisecondsPause);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-iscanningtuner-scandown
    HRESULT ScanDown(int MillisecondsPause);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-iscanningtuner-autoprogram
    HRESULT AutoProgram();
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nn-tuner-iscanningtunerex
@GUID("04bbd195-0e2d-4593-9bd5-4f908bc33cf5")
interface IScanningTunerEx : IScanningTuner
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-iscanningtunerex-getcurrentlocator
    HRESULT GetCurrentLocator(ILocator* pILocator);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-iscanningtunerex-performexhaustivescan
    HRESULT PerformExhaustiveScan(int dwLowerFreq, int dwHigherFreq, VARIANT_BOOL bFineTune, size_t hEvent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-iscanningtunerex-terminatecurrentscan
    HRESULT TerminateCurrentScan(int* pcurrentFreq);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-iscanningtunerex-resumecurrentscan
    HRESULT ResumeCurrentScan(size_t hEvent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-iscanningtunerex-gettunerscanningcapability
    HRESULT GetTunerScanningCapability(int* HardwareAssistedScanning, int* NumStandardsSupported, 
                                       GUID* BroadcastStandards);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-iscanningtunerex-gettunerstatus
    HRESULT GetTunerStatus(int* SecondsLeft, int* CurrentLockType, int* AutoDetect, int* CurrentFreq);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-iscanningtunerex-getcurrenttunerstandardcapability
    HRESULT GetCurrentTunerStandardCapability(GUID CurrentBroadcastStandard, int* SettlingTime, 
                                              int* TvStandardsSupported);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-iscanningtunerex-setscansignaltypefilter
    HRESULT SetScanSignalTypeFilter(int ScanModulationTypes, int AnalogVideoStandard);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nn-tuner-icomponenttype
@GUID("6a340dc0-0311-11d3-9d8e-00c04f72d980")
interface IComponentType : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-icomponenttype-get_category
    HRESULT get_Category(ComponentCategory* Category);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-icomponenttype-put_category
    HRESULT put_Category(ComponentCategory Category);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-icomponenttype-get_mediamajortype
    HRESULT get_MediaMajorType(BSTR* MediaMajorType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-icomponenttype-put_mediamajortype
    HRESULT put_MediaMajorType(BSTR MediaMajorType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-icomponenttype-get__mediamajortype
    HRESULT get__MediaMajorType(GUID* MediaMajorTypeGuid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-icomponenttype-put__mediamajortype
    HRESULT put__MediaMajorType(const(GUID)* MediaMajorTypeGuid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-icomponenttype-get_mediasubtype
    HRESULT get_MediaSubType(BSTR* MediaSubType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-icomponenttype-put_mediasubtype
    HRESULT put_MediaSubType(BSTR MediaSubType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-icomponenttype-get__mediasubtype
    HRESULT get__MediaSubType(GUID* MediaSubTypeGuid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-icomponenttype-put__mediasubtype
    HRESULT put__MediaSubType(const(GUID)* MediaSubTypeGuid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-icomponenttype-get_mediaformattype
    HRESULT get_MediaFormatType(BSTR* MediaFormatType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-icomponenttype-put_mediaformattype
    HRESULT put_MediaFormatType(BSTR MediaFormatType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-icomponenttype-get__mediaformattype
    HRESULT get__MediaFormatType(GUID* MediaFormatTypeGuid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-icomponenttype-put__mediaformattype
    HRESULT put__MediaFormatType(const(GUID)* MediaFormatTypeGuid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-icomponenttype-get_mediatype
    HRESULT get_MediaType(AM_MEDIA_TYPE* MediaType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-icomponenttype-put_mediatype
    HRESULT put_MediaType(AM_MEDIA_TYPE* MediaType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-icomponenttype-clone
    HRESULT Clone(IComponentType* NewCT);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nn-tuner-ilanguagecomponenttype
@GUID("b874c8ba-0fa2-11d3-9d8e-00c04f72d980")
interface ILanguageComponentType : IComponentType
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ilanguagecomponenttype-get_langid
    HRESULT get_LangID(int* LangID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ilanguagecomponenttype-put_langid
    HRESULT put_LangID(int LangID);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nn-tuner-impeg2componenttype
@GUID("2c073d84-b51c-48c9-aa9f-68971e1f6e38")
interface IMPEG2ComponentType : ILanguageComponentType
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-impeg2componenttype-get_streamtype
    HRESULT get_StreamType(MPEG2StreamType* MP2StreamType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-impeg2componenttype-put_streamtype
    HRESULT put_StreamType(MPEG2StreamType MP2StreamType);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nn-tuner-iatsccomponenttype
@GUID("fc189e4d-7bd4-4125-b3b3-3a76a332cc96")
interface IATSCComponentType : IMPEG2ComponentType
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-iatsccomponenttype-get_flags
    HRESULT get_Flags(int* Flags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-iatsccomponenttype-put_flags
    HRESULT put_Flags(int flags);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nn-tuner-ienumcomponenttypes
@GUID("8a674b4a-1f63-11d3-b64c-00c04f79498e")
interface IEnumComponentTypes : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ienumcomponenttypes-next
    HRESULT Next(uint celt, IComponentType* rgelt, uint* pceltFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ienumcomponenttypes-skip
    HRESULT Skip(uint celt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ienumcomponenttypes-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ienumcomponenttypes-clone
    HRESULT Clone(IEnumComponentTypes* ppEnum);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nn-tuner-icomponenttypes
@GUID("0dc13d4a-0313-11d3-9d8e-00c04f72d980")
interface IComponentTypes : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-icomponenttypes-get_count
    HRESULT get_Count(int* Count);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-icomponenttypes-get__newenum
    HRESULT get__NewEnum(IEnumVARIANT* ppNewEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-icomponenttypes-enumcomponenttypes
    HRESULT EnumComponentTypes(IEnumComponentTypes* ppNewEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-icomponenttypes-get_item
    HRESULT get_Item(VARIANT Index, IComponentType* ComponentType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-icomponenttypes-put_item
    HRESULT put_Item(VARIANT Index, IComponentType ComponentType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-icomponenttypes-add
    HRESULT Add(IComponentType ComponentType, VARIANT* NewIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-icomponenttypes-remove
    HRESULT Remove(VARIANT Index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-icomponenttypes-clone
    HRESULT Clone(IComponentTypes* NewList);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nn-tuner-icomponent
@GUID("1a5576fc-0e19-11d3-9d8e-00c04f72d980")
interface IComponent : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-icomponent-get_type
    HRESULT get_Type(IComponentType* CT);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-icomponent-put_type
    HRESULT put_Type(IComponentType CT);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-icomponent-get_desclangid
    HRESULT get_DescLangID(int* LangID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-icomponent-put_desclangid
    HRESULT put_DescLangID(int LangID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-icomponent-get_status
    HRESULT get_Status(ComponentStatus* Status);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-icomponent-put_status
    HRESULT put_Status(ComponentStatus Status);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-icomponent-get_description
    HRESULT get_Description(BSTR* Description);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-icomponent-put_description
    HRESULT put_Description(BSTR Description);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-icomponent-clone
    HRESULT Clone(IComponent* NewComponent);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nn-tuner-ianalogaudiocomponenttype
@GUID("2cfeb2a8-1787-4a24-a941-c6eaec39c842")
interface IAnalogAudioComponentType : IComponentType
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ianalogaudiocomponenttype-get_analogaudiomode
    HRESULT get_AnalogAudioMode(TVAudioMode* Mode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ianalogaudiocomponenttype-put_analogaudiomode
    HRESULT put_AnalogAudioMode(TVAudioMode Mode);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nn-tuner-impeg2component
@GUID("1493e353-1eb6-473c-802d-8e6b8ec9d2a9")
interface IMPEG2Component : IComponent
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-impeg2component-get_pid
    HRESULT get_PID(int* PID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-impeg2component-put_pid
    HRESULT put_PID(int PID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-impeg2component-get_pcrpid
    HRESULT get_PCRPID(int* PCRPID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-impeg2component-put_pcrpid
    HRESULT put_PCRPID(int PCRPID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-impeg2component-get_programnumber
    HRESULT get_ProgramNumber(int* ProgramNumber);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-impeg2component-put_programnumber
    HRESULT put_ProgramNumber(int ProgramNumber);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nn-tuner-ienumcomponents
@GUID("2a6e2939-2595-11d3-b64c-00c04f79498e")
interface IEnumComponents : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ienumcomponents-next
    HRESULT Next(uint celt, IComponent* rgelt, uint* pceltFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ienumcomponents-skip
    HRESULT Skip(uint celt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ienumcomponents-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ienumcomponents-clone
    HRESULT Clone(IEnumComponents* ppEnum);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nn-tuner-icomponents
@GUID("39a48091-fffe-4182-a161-3ff802640e26")
interface IComponents : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-icomponents-get_count
    HRESULT get_Count(int* Count);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-icomponents-get__newenum
    HRESULT get__NewEnum(IEnumVARIANT* ppNewEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-icomponents-enumcomponents
    HRESULT EnumComponents(IEnumComponents* ppNewEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-icomponents-get_item
    HRESULT get_Item(VARIANT Index, IComponent* ppComponent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-icomponents-add
    HRESULT Add(IComponent Component, VARIANT* NewIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-icomponents-remove
    HRESULT Remove(VARIANT Index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-icomponents-clone
    HRESULT Clone(IComponents* NewList);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-icomponents-put_item
    HRESULT put_Item(VARIANT Index, IComponent ppComponent);
}

@GUID("fcd01846-0e19-11d3-9d8e-00c04f72d980")
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

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nn-tuner-ilocator
@GUID("286d7f89-760c-4f89-80c4-66841d2507aa")
interface ILocator : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ilocator-get_carrierfrequency
    HRESULT get_CarrierFrequency(int* Frequency);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ilocator-put_carrierfrequency
    HRESULT put_CarrierFrequency(int Frequency);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ilocator-get_innerfec
    HRESULT get_InnerFEC(FECMethod* FEC);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ilocator-put_innerfec
    HRESULT put_InnerFEC(FECMethod FEC);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ilocator-get_innerfecrate
    HRESULT get_InnerFECRate(BinaryConvolutionCodeRate* FEC);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ilocator-put_innerfecrate
    HRESULT put_InnerFECRate(BinaryConvolutionCodeRate FEC);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ilocator-get_outerfec
    HRESULT get_OuterFEC(FECMethod* FEC);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ilocator-put_outerfec
    HRESULT put_OuterFEC(FECMethod FEC);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ilocator-get_outerfecrate
    HRESULT get_OuterFECRate(BinaryConvolutionCodeRate* FEC);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ilocator-put_outerfecrate
    HRESULT put_OuterFECRate(BinaryConvolutionCodeRate FEC);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ilocator-get_modulation
    HRESULT get_Modulation(ModulationType* Modulation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ilocator-put_modulation
    HRESULT put_Modulation(ModulationType Modulation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ilocator-get_symbolrate
    HRESULT get_SymbolRate(int* Rate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ilocator-put_symbolrate
    HRESULT put_SymbolRate(int Rate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ilocator-clone
    HRESULT Clone(ILocator* NewLocator);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nn-tuner-ianaloglocator
@GUID("34d1f26b-e339-430d-abce-738cb48984dc")
interface IAnalogLocator : ILocator
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ianaloglocator-get_videostandard
    HRESULT get_VideoStandard(AnalogVideoStandard* AVS);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ianaloglocator-put_videostandard
    HRESULT put_VideoStandard(AnalogVideoStandard AVS);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nn-tuner-idigitallocator
@GUID("19b595d8-839a-47f0-96df-4f194f3c768c")
interface IDigitalLocator : ILocator
{
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nn-tuner-iatsclocator
@GUID("bf8d986f-8c2b-4131-94d7-4d3d9fcc21ef")
interface IATSCLocator : IDigitalLocator
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-iatsclocator-get_physicalchannel
    HRESULT get_PhysicalChannel(int* PhysicalChannel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-iatsclocator-put_physicalchannel
    HRESULT put_PhysicalChannel(int PhysicalChannel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-iatsclocator-get_tsid
    HRESULT get_TSID(int* TSID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-iatsclocator-put_tsid
    HRESULT put_TSID(int TSID);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nn-tuner-iatsclocator2
@GUID("612aa885-66cf-4090-ba0a-566f5312e4ca")
interface IATSCLocator2 : IATSCLocator
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-iatsclocator2-get_programnumber
    HRESULT get_ProgramNumber(int* ProgramNumber);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-iatsclocator2-put_programnumber
    HRESULT put_ProgramNumber(int ProgramNumber);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nn-tuner-idigitalcablelocator
@GUID("48f66a11-171a-419a-9525-beeecd51584c")
interface IDigitalCableLocator : IATSCLocator2
{
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nn-tuner-idvbtlocator
@GUID("8664da16-dda2-42ac-926a-c18f9127c302")
interface IDVBTLocator : IDigitalLocator
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idvbtlocator-get_bandwidth
    HRESULT get_Bandwidth(int* BandWidthVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idvbtlocator-put_bandwidth
    HRESULT put_Bandwidth(int BandwidthVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idvbtlocator-get_lpinnerfec
    HRESULT get_LPInnerFEC(FECMethod* FEC);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idvbtlocator-put_lpinnerfec
    HRESULT put_LPInnerFEC(FECMethod FEC);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idvbtlocator-get_lpinnerfecrate
    HRESULT get_LPInnerFECRate(BinaryConvolutionCodeRate* FEC);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idvbtlocator-put_lpinnerfecrate
    HRESULT put_LPInnerFECRate(BinaryConvolutionCodeRate FEC);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idvbtlocator-get_halpha
    HRESULT get_HAlpha(HierarchyAlpha* Alpha);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idvbtlocator-put_halpha
    HRESULT put_HAlpha(HierarchyAlpha Alpha);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idvbtlocator-get_guard
    HRESULT get_Guard(GuardInterval* GI);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idvbtlocator-put_guard
    HRESULT put_Guard(GuardInterval GI);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idvbtlocator-get_mode
    HRESULT get_Mode(TransmissionMode* mode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idvbtlocator-put_mode
    HRESULT put_Mode(TransmissionMode mode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idvbtlocator-get_otherfrequencyinuse
    HRESULT get_OtherFrequencyInUse(VARIANT_BOOL* OtherFrequencyInUseVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idvbtlocator-put_otherfrequencyinuse
    HRESULT put_OtherFrequencyInUse(VARIANT_BOOL OtherFrequencyInUseVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nn-tuner-idvbtlocator2
@GUID("448a2edf-ae95-4b43-a3cc-747843c453d4")
interface IDVBTLocator2 : IDVBTLocator
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idvbtlocator2-get_physicallayerpipeid
    HRESULT get_PhysicalLayerPipeId(int* PhysicalLayerPipeIdVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idvbtlocator2-put_physicallayerpipeid
    HRESULT put_PhysicalLayerPipeId(int PhysicalLayerPipeIdVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nn-tuner-idvbslocator
@GUID("3d7c353c-0d04-45f1-a742-f97cc1188dc8")
interface IDVBSLocator : IDigitalLocator
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idvbslocator-get_signalpolarisation
    HRESULT get_SignalPolarisation(Polarisation* PolarisationVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idvbslocator-put_signalpolarisation
    HRESULT put_SignalPolarisation(Polarisation PolarisationVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idvbslocator-get_westposition
    HRESULT get_WestPosition(VARIANT_BOOL* WestLongitude);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idvbslocator-put_westposition
    HRESULT put_WestPosition(VARIANT_BOOL WestLongitude);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idvbslocator-get_orbitalposition
    HRESULT get_OrbitalPosition(int* longitude);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idvbslocator-put_orbitalposition
    HRESULT put_OrbitalPosition(int longitude);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idvbslocator-get_azimuth
    HRESULT get_Azimuth(int* Azimuth);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idvbslocator-put_azimuth
    HRESULT put_Azimuth(int Azimuth);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idvbslocator-get_elevation
    HRESULT get_Elevation(int* Elevation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idvbslocator-put_elevation
    HRESULT put_Elevation(int Elevation);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nn-tuner-idvbslocator2
@GUID("6044634a-1733-4f99-b982-5fb12afce4f0")
interface IDVBSLocator2 : IDVBSLocator
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idvbslocator2-get_diseqlnbsource
    HRESULT get_DiseqLNBSource(LNB_Source* DiseqLNBSourceVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idvbslocator2-put_diseqlnbsource
    HRESULT put_DiseqLNBSource(LNB_Source DiseqLNBSourceVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idvbslocator2-get_localoscillatoroverridelow
    HRESULT get_LocalOscillatorOverrideLow(int* LocalOscillatorOverrideLowVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idvbslocator2-put_localoscillatoroverridelow
    HRESULT put_LocalOscillatorOverrideLow(int LocalOscillatorOverrideLowVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idvbslocator2-get_localoscillatoroverridehigh
    HRESULT get_LocalOscillatorOverrideHigh(int* LocalOscillatorOverrideHighVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idvbslocator2-put_localoscillatoroverridehigh
    HRESULT put_LocalOscillatorOverrideHigh(int LocalOscillatorOverrideHighVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idvbslocator2-get_locallnbswitchoverride
    HRESULT get_LocalLNBSwitchOverride(int* LocalLNBSwitchOverrideVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idvbslocator2-put_locallnbswitchoverride
    HRESULT put_LocalLNBSwitchOverride(int LocalLNBSwitchOverrideVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idvbslocator2-get_localspectralinversionoverride
    HRESULT get_LocalSpectralInversionOverride(SpectralInversion* LocalSpectralInversionOverrideVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idvbslocator2-put_localspectralinversionoverride
    HRESULT put_LocalSpectralInversionOverride(SpectralInversion LocalSpectralInversionOverrideVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idvbslocator2-get_signalrolloff
    HRESULT get_SignalRollOff(RollOff* RollOffVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idvbslocator2-put_signalrolloff
    HRESULT put_SignalRollOff(RollOff RollOffVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idvbslocator2-get_signalpilot
    HRESULT get_SignalPilot(Pilot* PilotVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-idvbslocator2-put_signalpilot
    HRESULT put_SignalPilot(Pilot PilotVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nn-tuner-idvbclocator
@GUID("6e42f36e-1dd2-43c4-9f78-69d25ae39034")
interface IDVBCLocator : IDigitalLocator
{
}

@GUID("c9897087-e29c-473f-9e4b-7072123dea14")
interface IISDBSLocator : IDVBSLocator
{
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nn-tuner-iesopenmmievent
@GUID("ba4b6526-1a35-4635-8b56-3ec612746a8c")
interface IESOpenMmiEvent : IESEvent
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-iesopenmmievent-getdialognumber
    HRESULT GetDialogNumber(uint* pDialogRequest, uint* pDialogNumber);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-iesopenmmievent-getdialogtype
    HRESULT GetDialogType(GUID* guidDialogType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-iesopenmmievent-getdialogdata
    HRESULT GetDialogData(SAFEARRAY** pbData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-iesopenmmievent-getdialogstringdata
    HRESULT GetDialogStringData(BSTR* pbstrBaseUrl, BSTR* pbstrData);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nn-tuner-iesclosemmievent
@GUID("6b80e96f-55e2-45aa-b754-0c23c8e7d5c1")
interface IESCloseMmiEvent : IESEvent
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-iesclosemmievent-getdialognumber
    HRESULT GetDialogNumber(uint* pDialogNumber);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nn-tuner-iesvalueupdatedevent
@GUID("8a24c46e-bb63-4664-8602-5d9c718c146d")
interface IESValueUpdatedEvent : IESEvent
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-iesvalueupdatedevent-getvaluenames
    HRESULT GetValueNames(SAFEARRAY** pbstrNames);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nn-tuner-iesrequesttunerevent
@GUID("54c7a5e8-c3bb-4f51-af14-e0e2c0e34c6d")
interface IESRequestTunerEvent : IESEvent
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-iesrequesttunerevent-getpriority
    HRESULT GetPriority(ubyte* pbyPriority);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-iesrequesttunerevent-getreason
    HRESULT GetReason(ubyte* pbyReason);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-iesrequesttunerevent-getconsequences
    HRESULT GetConsequences(ubyte* pbyConsequences);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-iesrequesttunerevent-getestimatedtime
    HRESULT GetEstimatedTime(uint* pdwEstimatedTime);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nn-tuner-iesisdbcasresponseevent
@GUID("2017cb03-dc0f-4c24-83ca-36307b2cd19f")
interface IESIsdbCasResponseEvent : IESEvent
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-iesisdbcasresponseevent-getrequestid
    HRESULT GetRequestId(uint* pRequestId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-iesisdbcasresponseevent-getstatus
    HRESULT GetStatus(uint* pStatus);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-iesisdbcasresponseevent-getdatalength
    HRESULT GetDataLength(uint* pRequestLength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-iesisdbcasresponseevent-getresponsedata
    HRESULT GetResponseData(SAFEARRAY** pbData);
}

@GUID("907e0b5c-e42d-4f04-91f0-26f401f36907")
interface IGpnvsCommonBase : IUnknown
{
    HRESULT GetValueUpdateName(BSTR* pbstrName);
}

@GUID("506a09b8-7f86-4e04-ac05-3303bfe8fc49")
interface IESEventFactory : IUnknown
{
    HRESULT CreateESEvent(IUnknown pServiceProvider, uint dwEventId, GUID guidEventType, uint dwEventDataLength, 
                          ubyte* pEventData, BSTR bstrBaseUrl, IUnknown pInitContext, IESEvent* ppESEvent);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nn-tuner-ieslicenserenewalresultevent
@GUID("d5a48ef5-a81b-4df0-acaa-5e35e7ea45d4")
interface IESLicenseRenewalResultEvent : IESEvent
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ieslicenserenewalresultevent-getcallersid
    HRESULT GetCallersId(uint* pdwCallersId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ieslicenserenewalresultevent-getfilename
    HRESULT GetFileName(BSTR* pbstrFilename);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ieslicenserenewalresultevent-isrenewalsuccessful
    HRESULT IsRenewalSuccessful(BOOL* pfRenewalSuccessful);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ieslicenserenewalresultevent-ischeckentitlementcallrequired
    HRESULT IsCheckEntitlementCallRequired(BOOL* pfCheckEntTokenCallNeeded);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ieslicenserenewalresultevent-getdescrambledstatus
    HRESULT GetDescrambledStatus(uint* pDescrambledStatus);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ieslicenserenewalresultevent-getrenewalresultcode
    HRESULT GetRenewalResultCode(uint* pdwRenewalResultCode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ieslicenserenewalresultevent-getcasfailurecode
    HRESULT GetCASFailureCode(uint* pdwCASFailureCode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ieslicenserenewalresultevent-getrenewalhresult
    HRESULT GetRenewalHResult(HRESULT* phr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ieslicenserenewalresultevent-getentitlementtokenlength
    HRESULT GetEntitlementTokenLength(uint* pdwLength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ieslicenserenewalresultevent-getentitlementtoken
    HRESULT GetEntitlementToken(SAFEARRAY** pbData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ieslicenserenewalresultevent-getexpirydate
    HRESULT GetExpiryDate(ulong* pqwExpiryDate);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nn-tuner-iesfileexpirydateevent
@GUID("ba9edcb6-4d36-4cfe-8c56-87a6b0ca48e1")
interface IESFileExpiryDateEvent : IESEvent
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-iesfileexpirydateevent-gettunerid
    HRESULT GetTunerId(GUID* pguidTunerId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-iesfileexpirydateevent-getexpirydate
    HRESULT GetExpiryDate(ulong* pqwExpiryDate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-iesfileexpirydateevent-getfinalexpirydate
    HRESULT GetFinalExpiryDate(ulong* pqwExpiryDate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-iesfileexpirydateevent-getmaxrenewalcount
    HRESULT GetMaxRenewalCount(uint* dwMaxRenewalCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-iesfileexpirydateevent-isentitlementtokenpresent
    HRESULT IsEntitlementTokenPresent(BOOL* pfEntTokenPresent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-iesfileexpirydateevent-doesexpireafterfirstuse
    HRESULT DoesExpireAfterFirstUse(BOOL* pfExpireAfterFirstUse);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nn-tuner-ieseventservice
@GUID("ed89a619-4c06-4b2f-99eb-c7669b13047c")
interface IESEventService : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ieseventservice-fireesevent
    HRESULT FireESEvent(IESEvent pESEvent);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nn-tuner-ieseventserviceconfiguration
@GUID("33b9daae-9309-491d-a051-bcad2a70cd66")
interface IESEventServiceConfiguration : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ieseventserviceconfiguration-setparent
    HRESULT SetParent(IESEventService pEventService);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ieseventserviceconfiguration-removeparent
    HRESULT RemoveParent();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ieseventserviceconfiguration-setowner
    HRESULT SetOwner(IESEvents pESEvents);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ieseventserviceconfiguration-removeowner
    HRESULT RemoveOwner();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ieseventserviceconfiguration-setgraph
    HRESULT SetGraph(IFilterGraph pGraph);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ieseventserviceconfiguration-removegraph
    HRESULT RemoveGraph(IFilterGraph pGraph);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nn-tuner-iregistertuner
@GUID("359b3901-572c-4854-bb49-cdef66606a25")
interface IRegisterTuner : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-iregistertuner-register
    HRESULT Register(ITuner pTuner, IGraphBuilder pGraph);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-iregistertuner-unregister
    HRESULT Unregister();
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nn-tuner-ibdacomparable
@GUID("b34505e0-2f0e-497b-80bc-d43f3b24ed7f")
interface IBDAComparable : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ibdacomparable-compareexact
    HRESULT CompareExact(IDispatch CompareTo, int* Result);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ibdacomparable-compareequivalent
    HRESULT CompareEquivalent(IDispatch CompareTo, uint dwFlags, int* Result);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ibdacomparable-hashexact
    HRESULT HashExact(long* Result);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ibdacomparable-hashexactincremental
    HRESULT HashExactIncremental(long PartialResult, long* Result);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ibdacomparable-hashequivalent
    HRESULT HashEquivalent(uint dwFlags, long* Result);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ibdacomparable-hashequivalentincremental
    HRESULT HashEquivalentIncremental(long PartialResult, uint dwFlags, long* Result);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nn-tuner-ipersisttunexml
@GUID("0754cd31-8d15-47a9-8215-d20064157244")
interface IPersistTuneXml : IPersist
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ipersisttunexml-initnew
    HRESULT InitNew();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ipersisttunexml-load
    HRESULT Load(VARIANT varValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ipersisttunexml-save
    HRESULT Save(VARIANT* pvarFragment);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nn-tuner-ipersisttunexmlutility
@GUID("990237ae-ac11-4614-be8f-dd217a4cb4cb")
interface IPersistTuneXmlUtility : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ipersisttunexmlutility-deserialize
    HRESULT Deserialize(VARIANT varValue, IUnknown* ppObject);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nn-tuner-ipersisttunexmlutility2
@GUID("992e165f-ea24-4b2f-9a1d-009d92120451")
interface IPersistTuneXmlUtility2 : IPersistTuneXmlUtility
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ipersisttunexmlutility2-serialize
    HRESULT Serialize(ITuneRequest piTuneRequest, BSTR* pString);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nn-tuner-ibdacreatetunerequestex
@GUID("c0a4a1d4-2b3c-491a-ba22-499fbadd4d12")
interface IBDACreateTuneRequestEx : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tuner/nf-tuner-ibdacreatetunerequestex-createtunerequestex
    HRESULT CreateTuneRequestEx(const(GUID)* TuneRequestIID, ITuneRequest* TuneRequest);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/encdec/nn-encdec-ietfilterconfig
@GUID("c4c4c4d1-0049-4e2b-98fb-9537f6ce516d")
interface IETFilterConfig : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/encdec/nf-encdec-ietfilterconfig-initlicense
    HRESULT InitLicense(int LicenseId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/encdec/nf-encdec-ietfilterconfig-getsecurechannelobject
    HRESULT GetSecureChannelObject(IUnknown* ppUnkDRMSecureChannel);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/encdec/nn-encdec-idtfilterconfig
@GUID("c4c4c4d2-0049-4e2b-98fb-9537f6ce516d")
interface IDTFilterConfig : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/encdec/nf-encdec-idtfilterconfig-getsecurechannelobject
    HRESULT GetSecureChannelObject(IUnknown* ppUnkDRMSecureChannel);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/encdec/nn-encdec-ixdscodecconfig
@GUID("c4c4c4d3-0049-4e2b-98fb-9537f6ce516d")
interface IXDSCodecConfig : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/encdec/nf-encdec-ixdscodecconfig-getsecurechannelobject
    HRESULT GetSecureChannelObject(IUnknown* ppUnkDRMSecureChannel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/encdec/nf-encdec-ixdscodecconfig-setpausebuffertime
    HRESULT SetPauseBufferTime(uint dwPauseBufferTime);
}

@GUID("8a78b317-e405-4a43-994a-620d8f5ce25e")
interface IDTFilterLicenseRenewal : IUnknown
{
    HRESULT GetLicenseRenewalData(PWSTR* ppwszFileName, PWSTR* ppwszExpiredKid, PWSTR* ppwszTunerId);
}

@GUID("26d836a5-0c15-44c7-ac59-b0da8728f240")
interface IPTFilterLicenseRenewal : IUnknown
{
    HRESULT RenewLicenses(PWSTR wszFileName, PWSTR wszExpiredKid, uint dwCallersId, BOOL bHighPriority);
    HRESULT CancelLicenseRenewal();
}

@GUID("5a86b91a-e71e-46c1-88a9-9bb338710552")
interface IMceBurnerControl : IUnknown
{
    HRESULT GetBurnerNoDecryption();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/encdec/nn-encdec-ietfilter
@GUID("c4c4c4b1-0049-4e2b-98fb-9537f6ce516d")
interface IETFilter : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/encdec/nf-encdec-ietfilter-get_evalratobjok
    HRESULT get_EvalRatObjOK(HRESULT* pHrCoCreateRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/encdec/nf-encdec-ietfilter-getcurrrating
    HRESULT GetCurrRating(EnTvRat_System* pEnSystem, EnTvRat_GenericLevel* pEnRating, int* plbfEnAttr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/encdec/nf-encdec-ietfilter-getcurrlicenseexpdate
    HRESULT GetCurrLicenseExpDate(ProtType* protType, int* lpDateTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/encdec/nf-encdec-ietfilter-getlasterrorcode
    HRESULT GetLastErrorCode();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/encdec/nf-encdec-ietfilter-setrecordingon
    HRESULT SetRecordingOn(BOOL fRecState);
}

@GUID("c4c4c4c1-0049-4e2b-98fb-9537f6ce516d")
interface IETFilterEvents : IDispatch
{
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/encdec/nn-encdec-idtfilter
@GUID("c4c4c4b2-0049-4e2b-98fb-9537f6ce516d")
interface IDTFilter : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/encdec/nf-encdec-idtfilter-get_evalratobjok
    HRESULT get_EvalRatObjOK(HRESULT* pHrCoCreateRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/encdec/nf-encdec-idtfilter-getcurrrating
    HRESULT GetCurrRating(EnTvRat_System* pEnSystem, EnTvRat_GenericLevel* pEnRating, int* plbfEnAttr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/encdec/nf-encdec-idtfilter-get_blockedratingattributes
    HRESULT get_BlockedRatingAttributes(EnTvRat_System enSystem, EnTvRat_GenericLevel enLevel, int* plbfEnAttr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/encdec/nf-encdec-idtfilter-put_blockedratingattributes
    HRESULT put_BlockedRatingAttributes(EnTvRat_System enSystem, EnTvRat_GenericLevel enLevel, int lbfAttrs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/encdec/nf-encdec-idtfilter-get_blockunrated
    HRESULT get_BlockUnRated(BOOL* pfBlockUnRatedShows);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/encdec/nf-encdec-idtfilter-put_blockunrated
    HRESULT put_BlockUnRated(BOOL fBlockUnRatedShows);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/encdec/nf-encdec-idtfilter-get_blockunrateddelay
    HRESULT get_BlockUnRatedDelay(int* pmsecsDelayBeforeBlock);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/encdec/nf-encdec-idtfilter-put_blockunrateddelay
    HRESULT put_BlockUnRatedDelay(int msecsDelayBeforeBlock);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/encdec/nn-encdec-idtfilter2
@GUID("c4c4c4b4-0049-4e2b-98fb-9537f6ce516d")
interface IDTFilter2 : IDTFilter
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/encdec/nf-encdec-idtfilter2-get_challengeurl
    HRESULT get_ChallengeUrl(BSTR* pbstrChallengeUrl);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/encdec/nf-encdec-idtfilter2-getcurrlicenseexpdate
    HRESULT GetCurrLicenseExpDate(ProtType* protType, int* lpDateTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/encdec/nf-encdec-idtfilter2-getlasterrorcode
    HRESULT GetLastErrorCode();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/encdec/nn-encdec-idtfilter3
@GUID("513998cc-e929-4cdf-9fbd-bad1e0314866")
interface IDTFilter3 : IDTFilter2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/encdec/nf-encdec-idtfilter3-getprotectiontype
    HRESULT GetProtectionType(ProtType* pProtectionType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/encdec/nf-encdec-idtfilter3-licensehasexpirationdate
    HRESULT LicenseHasExpirationDate(BOOL* pfLicenseHasExpirationDate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/encdec/nf-encdec-idtfilter3-setrights
    HRESULT SetRights(BSTR bstrRights);
}

@GUID("c4c4c4c2-0049-4e2b-98fb-9537f6ce516d")
interface IDTFilterEvents : IDispatch
{
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/encdec/nn-encdec-ixdscodec
@GUID("c4c4c4b3-0049-4e2b-98fb-9537f6ce516d")
interface IXDSCodec : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/encdec/nf-encdec-ixdscodec-get_xdstoratobjok
    HRESULT get_XDSToRatObjOK(HRESULT* pHrCoCreateRetVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/encdec/nf-encdec-ixdscodec-put_ccsubstreamservice
    HRESULT put_CCSubstreamService(int SubstreamMask);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/encdec/nf-encdec-ixdscodec-get_ccsubstreamservice
    HRESULT get_CCSubstreamService(int* pSubstreamMask);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/encdec/nf-encdec-ixdscodec-getcontentadvisoryrating
    HRESULT GetContentAdvisoryRating(int* pRat, int* pPktSeqID, int* pCallSeqID, long* pTimeStart, long* pTimeEnd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/encdec/nf-encdec-ixdscodec-getxdspacket
    HRESULT GetXDSPacket(int* pXDSClassPkt, int* pXDSTypePkt, BSTR* pBstrXDSPkt, int* pPktSeqID, int* pCallSeqID, 
                         long* pTimeStart, long* pTimeEnd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/encdec/nf-encdec-ixdscodec-getcurrlicenseexpdate
    HRESULT GetCurrLicenseExpDate(ProtType* protType, int* lpDateTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/encdec/nf-encdec-ixdscodec-getlasterrorcode
    HRESULT GetLastErrorCode();
}

@GUID("c4c4c4c3-0049-4e2b-98fb-9537f6ce516d")
interface IXDSCodecEvents : IDispatch
{
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tvratings/nn-tvratings-ixdstorat
@GUID("c5c5c5b0-3abc-11d6-b25b-00c04fa0c026")
interface IXDSToRat : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tvratings/nf-tvratings-ixdstorat-init
    HRESULT Init();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tvratings/nf-tvratings-ixdstorat-parsexdsbytepair
    HRESULT ParseXDSBytePair(ubyte byte1, ubyte byte2, EnTvRat_System* pEnSystem, EnTvRat_GenericLevel* pEnLevel, 
                             int* plBfEnAttributes);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tvratings/nn-tvratings-ievalrat
@GUID("c5c5c5b1-3abc-11d6-b25b-00c04fa0c026")
interface IEvalRat : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tvratings/nf-tvratings-ievalrat-get_blockedratingattributes
    HRESULT get_BlockedRatingAttributes(EnTvRat_System enSystem, EnTvRat_GenericLevel enLevel, int* plbfAttrs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tvratings/nf-tvratings-ievalrat-put_blockedratingattributes
    HRESULT put_BlockedRatingAttributes(EnTvRat_System enSystem, EnTvRat_GenericLevel enLevel, int lbfAttrs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tvratings/nf-tvratings-ievalrat-get_blockunrated
    HRESULT get_BlockUnRated(BOOL* pfBlockUnRatedShows);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tvratings/nf-tvratings-ievalrat-put_blockunrated
    HRESULT put_BlockUnRated(BOOL fBlockUnRatedShows);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tvratings/nf-tvratings-ievalrat-mostrestrictiverating
    HRESULT MostRestrictiveRating(EnTvRat_System enSystem1, EnTvRat_GenericLevel enEnLevel1, int lbfEnAttr1, 
                                  EnTvRat_System enSystem2, EnTvRat_GenericLevel enEnLevel2, int lbfEnAttr2, 
                                  EnTvRat_System* penSystem, EnTvRat_GenericLevel* penEnLevel, int* plbfEnAttr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tvratings/nf-tvratings-ievalrat-testrating
    HRESULT TestRating(EnTvRat_System enShowSystem, EnTvRat_GenericLevel enShowLevel, int lbfEnShowAttributes);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nn-segment-imsvidrect
@GUID("7f5000a6-a440-47ca-8acc-c0e75531a2c2")
interface IMSVidRect : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidrect-get_top
    HRESULT get_Top(int* TopVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidrect-put_top
    HRESULT put_Top(int TopVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidrect-get_left
    HRESULT get_Left(int* LeftVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidrect-put_left
    HRESULT put_Left(int LeftVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidrect-get_width
    HRESULT get_Width(int* WidthVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidrect-put_width
    HRESULT put_Width(int WidthVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidrect-get_height
    HRESULT get_Height(int* HeightVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidrect-put_height
    HRESULT put_Height(int HeightVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidrect-get_hwnd
    HRESULT get_HWnd(HWND* HWndVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidrect-put_hwnd
    HRESULT put_HWnd(HWND HWndVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidrect-put_rect
    HRESULT put_Rect(IMSVidRect RectVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nn-segment-imsvidgraphsegmentcontainer
@GUID("3dd2903d-e0aa-11d2-b63a-00c04f79498e")
interface IMSVidGraphSegmentContainer : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidgraphsegmentcontainer-get_graph
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

@GUID("238dec54-adeb-4005-a349-f772b9afebc4")
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

@GUID("301c060e-20d9-4587-9b03-f82ed9a9943c")
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

@GUID("1c15d483-911d-11d2-b632-00c04f79498e")
interface IMSVidCompositionSegment : IMSVidGraphSegment
{
    HRESULT Compose(IMSVidGraphSegment upstream, IMSVidGraphSegment downstream);
    HRESULT get_Up(IMSVidGraphSegment* upstream);
    HRESULT get_Down(IMSVidGraphSegment* downstream);
}

@GUID("3dd2903e-e0aa-11d2-b63a-00c04f79498e")
interface IEnumMSVidGraphSegment : IUnknown
{
    HRESULT Next(uint celt, IMSVidGraphSegment* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumMSVidGraphSegment* ppenum);
}

@GUID("dd47de3f-9874-4f7b-8b22-7cb2688461e7")
interface IMSVidVRGraphSegment : IMSVidGraphSegment
{
    HRESULT put__VMRendererMode(int dwMode);
    HRESULT put_Owner(HWND Window);
    HRESULT get_Owner(HWND* Window);
    HRESULT get_UseOverlay(VARIANT_BOOL* UseOverlayVal);
    HRESULT put_UseOverlay(VARIANT_BOOL UseOverlayVal);
    HRESULT get_Visible(VARIANT_BOOL* Visible);
    HRESULT put_Visible(VARIANT_BOOL Visible);
    HRESULT get_ColorKey(uint* ColorKey);
    HRESULT put_ColorKey(uint ColorKey);
    HRESULT get_Source(RECT* r);
    HRESULT put_Source(RECT r);
    HRESULT get_Destination(RECT* r);
    HRESULT put_Destination(RECT r);
    HRESULT get_NativeSize(SIZE* sizeval, SIZE* aspectratio);
    HRESULT get_BorderColor(uint* color);
    HRESULT put_BorderColor(uint color);
    HRESULT get_MaintainAspectRatio(VARIANT_BOOL* fMaintain);
    HRESULT put_MaintainAspectRatio(VARIANT_BOOL fMaintain);
    HRESULT Refresh();
    HRESULT DisplayChange();
    HRESULT RePaint(HDC hdc);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nn-segment-imsviddevice
@GUID("1c15d47c-911d-11d2-b632-00c04f79498e")
interface IMSVidDevice : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsviddevice-get_name
    HRESULT get_Name(BSTR* Name);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsviddevice-get_status
    HRESULT get_Status(int* Status);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsviddevice-put_power
    HRESULT put_Power(VARIANT_BOOL Power);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsviddevice-get_power
    HRESULT get_Power(VARIANT_BOOL* Power);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsviddevice-get_category
    HRESULT get_Category(BSTR* Guid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsviddevice-get_classid
    HRESULT get_ClassID(BSTR* Clsid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsviddevice-get__category
    HRESULT get__Category(GUID* Guid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsviddevice-get__classid
    HRESULT get__ClassID(GUID* Clsid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsviddevice-isequaldevice
    HRESULT IsEqualDevice(IMSVidDevice Device, VARIANT_BOOL* IsEqual);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nn-segment-imsviddevice2
@GUID("87bd2783-ebc0-478c-b4a0-e8e7f43ab78e")
interface IMSVidDevice2 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsviddevice2-get_devicepath
    HRESULT get_DevicePath(BSTR* DevPath);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nn-segment-imsvidinputdevice
@GUID("37b0353d-a4c8-11d2-b634-00c04f79498e")
interface IMSVidInputDevice : IMSVidDevice
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidinputdevice-isviewable
    HRESULT IsViewable(VARIANT* v, VARIANT_BOOL* pfViewable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidinputdevice-view
    HRESULT View(VARIANT* v);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nn-segment-imsviddeviceevent
@GUID("1c15d480-911d-11d2-b632-00c04f79498e")
interface IMSVidDeviceEvent : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsviddeviceevent-statechange
    HRESULT StateChange(IMSVidDevice lpd, int oldState, int newState);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nn-segment-imsvidinputdeviceevent
@GUID("37b0353e-a4c8-11d2-b634-00c04f79498e")
interface IMSVidInputDeviceEvent : IDispatch
{
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nn-segment-imsvidvideoinputdevice
@GUID("1c15d47f-911d-11d2-b632-00c04f79498e")
interface IMSVidVideoInputDevice : IMSVidInputDevice
{
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nn-segment-imsvidplayback
@GUID("37b03538-a4c8-11d2-b634-00c04f79498e")
interface IMSVidPlayback : IMSVidInputDevice
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidplayback-get_enableresetonstop
    HRESULT get_EnableResetOnStop(VARIANT_BOOL* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidplayback-put_enableresetonstop
    HRESULT put_EnableResetOnStop(VARIANT_BOOL newVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidplayback-run
    HRESULT Run();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidplayback-pause
    HRESULT Pause();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidplayback-stop
    HRESULT Stop();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidplayback-get_canstep
    HRESULT get_CanStep(VARIANT_BOOL fBackwards, VARIANT_BOOL* pfCan);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidplayback-step
    HRESULT Step(int lStep);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidplayback-put_rate
    HRESULT put_Rate(double plRate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidplayback-get_rate
    HRESULT get_Rate(double* plRate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidplayback-put_currentposition
    HRESULT put_CurrentPosition(int lPosition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidplayback-get_currentposition
    HRESULT get_CurrentPosition(int* lPosition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidplayback-put_positionmode
    HRESULT put_PositionMode(PositionModeList lPositionMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidplayback-get_positionmode
    HRESULT get_PositionMode(PositionModeList* lPositionMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidplayback-get_length
    HRESULT get_Length(int* lLength);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nn-segment-imsvidplaybackevent
@GUID("37b0353b-a4c8-11d2-b634-00c04f79498e")
interface IMSVidPlaybackEvent : IMSVidInputDeviceEvent
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidplaybackevent-endofmedia
    HRESULT EndOfMedia(IMSVidPlayback lpd);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nn-segment-imsvidtuner
@GUID("1c15d47d-911d-11d2-b632-00c04f79498e")
interface IMSVidTuner : IMSVidVideoInputDevice
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidtuner-get_tune
    HRESULT get_Tune(ITuneRequest* ppTR);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidtuner-put_tune
    HRESULT put_Tune(ITuneRequest pTR);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidtuner-get_tuningspace
    HRESULT get_TuningSpace(ITuningSpace* plTS);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidtuner-put_tuningspace
    HRESULT put_TuningSpace(ITuningSpace plTS);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nn-segment-imsvidtunerevent
@GUID("1c15d485-911d-11d2-b632-00c04f79498e")
interface IMSVidTunerEvent : IMSVidInputDeviceEvent
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidtunerevent-tunechanged
    HRESULT TuneChanged(IMSVidTuner lpd);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nn-segment-imsvidanalogtuner
@GUID("1c15d47e-911d-11d2-b632-00c04f79498e")
interface IMSVidAnalogTuner : IMSVidTuner
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidanalogtuner-get_channel
    HRESULT get_Channel(int* Channel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidanalogtuner-put_channel
    HRESULT put_Channel(int Channel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidanalogtuner-get_videofrequency
    HRESULT get_VideoFrequency(int* lcc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidanalogtuner-get_audiofrequency
    HRESULT get_AudioFrequency(int* lcc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidanalogtuner-get_countrycode
    HRESULT get_CountryCode(int* lcc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidanalogtuner-put_countrycode
    HRESULT put_CountryCode(int lcc);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidanalogtuner-get_sap
    HRESULT get_SAP(VARIANT_BOOL* pfSapOn);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidanalogtuner-put_sap
    HRESULT put_SAP(VARIANT_BOOL fSapOn);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidanalogtuner-channelavailable
    HRESULT ChannelAvailable(int nChannel, int* SignalStrength, VARIANT_BOOL* fSignalPresent);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nn-segment-imsvidanalogtuner2
@GUID("37647bf7-3dde-4cc8-a4dc-0d534d3d0037")
interface IMSVidAnalogTuner2 : IMSVidAnalogTuner
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidanalogtuner2-get_tvformats
    HRESULT get_TVFormats(int* Formats);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidanalogtuner2-get_tunermodes
    HRESULT get_TunerModes(int* Modes);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidanalogtuner2-get_numauxinputs
    HRESULT get_NumAuxInputs(int* Inputs);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nn-segment-imsvidanalogtunerevent
@GUID("1c15d486-911d-11d2-b632-00c04f79498e")
interface IMSVidAnalogTunerEvent : IMSVidTunerEvent
{
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nn-segment-imsvidfileplayback
@GUID("37b03539-a4c8-11d2-b634-00c04f79498e")
interface IMSVidFilePlayback : IMSVidPlayback
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidfileplayback-get_filename
    HRESULT get_FileName(BSTR* FileName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidfileplayback-put_filename
    HRESULT put_FileName(BSTR FileName);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nn-segment-imsvidfileplayback2
@GUID("2f7e44af-6e52-4660-bc08-d8d542587d72")
interface IMSVidFilePlayback2 : IMSVidFilePlayback
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidfileplayback2-put__sourcefilter
    HRESULT put__SourceFilter(BSTR FileName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidfileplayback2-put___sourcefilter
    HRESULT put___SourceFilter(GUID FileName);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nn-segment-imsvidfileplaybackevent
@GUID("37b0353a-a4c8-11d2-b634-00c04f79498e")
interface IMSVidFilePlaybackEvent : IMSVidPlaybackEvent
{
}

@GUID("cf45f88b-ac56-4ee2-a73a-ed04e2885d3c")
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
    HRESULT get_AudioLanguage(int lStream, VARIANT_BOOL fFormat, BSTR* strAudioLang);
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
    HRESULT IsSubpictureStreamEnabled(int lstream, VARIANT_BOOL* fEnabled);
    HRESULT IsAudioStreamEnabled(int lstream, VARIANT_BOOL* fEnabled);
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
    HRESULT get_SubpictureOn(VARIANT_BOOL* pVal);
    HRESULT put_SubpictureOn(VARIANT_BOOL newVal);
    HRESULT get_DVDUniqueID(BSTR* pVal);
    HRESULT AcceptParentalLevelChange(VARIANT_BOOL fAccept, BSTR strUserName, BSTR strPassword);
    HRESULT NotifyParentalLevelChange(VARIANT_BOOL newVal);
    HRESULT SelectParentalCountry(int lCountry, BSTR strUserName, BSTR strPassword);
    HRESULT SelectParentalLevel(int lParentalLevel, BSTR strUserName, BSTR strPassword);
    HRESULT get_TitleParentalLevels(int lTitle, int* plParentalLevels);
    HRESULT get_PlayerParentalCountry(int* plCountryCode);
    HRESULT get_PlayerParentalLevel(int* plParentalLevel);
    HRESULT Eject();
    HRESULT UOPValid(int lUOP, VARIANT_BOOL* pfValid);
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

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nn-segment-imsvidwebdvd2
@GUID("7027212f-ee9a-4a7c-8b67-f023714cdaff")
interface IMSVidWebDVD2 : IMSVidWebDVD
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidwebdvd2-get_bookmark
    HRESULT get_Bookmark(ubyte** ppData, uint* pDataLength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidwebdvd2-put_bookmark
    HRESULT put_Bookmark(ubyte* pData, uint dwDataLength);
}

@GUID("b4f7a674-9b83-49cb-a357-c63b871be958")
interface IMSVidWebDVDEvent : IMSVidPlaybackEvent
{
    HRESULT DVDNotify(int lEventCode, VARIANT lParam1, VARIANT lParam2);
    HRESULT PlayForwards(VARIANT_BOOL bEnabled);
    HRESULT PlayBackwards(VARIANT_BOOL bEnabled);
    HRESULT ShowMenu(DVDMenuIDConstants MenuID, VARIANT_BOOL bEnabled);
    HRESULT Resume(VARIANT_BOOL bEnabled);
    HRESULT SelectOrActivateButton(VARIANT_BOOL bEnabled);
    HRESULT StillOff(VARIANT_BOOL bEnabled);
    HRESULT PauseOn(VARIANT_BOOL bEnabled);
    HRESULT ChangeCurrentAudioStream(VARIANT_BOOL bEnabled);
    HRESULT ChangeCurrentSubpictureStream(VARIANT_BOOL bEnabled);
    HRESULT ChangeCurrentAngle(VARIANT_BOOL bEnabled);
    HRESULT PlayAtTimeInTitle(VARIANT_BOOL bEnabled);
    HRESULT PlayAtTime(VARIANT_BOOL bEnabled);
    HRESULT PlayChapterInTitle(VARIANT_BOOL bEnabled);
    HRESULT PlayChapter(VARIANT_BOOL bEnabled);
    HRESULT ReplayChapter(VARIANT_BOOL bEnabled);
    HRESULT PlayNextChapter(VARIANT_BOOL bEnabled);
    HRESULT Stop(VARIANT_BOOL bEnabled);
    HRESULT ReturnFromSubmenu(VARIANT_BOOL bEnabled);
    HRESULT PlayTitle(VARIANT_BOOL bEnabled);
    HRESULT PlayPrevChapter(VARIANT_BOOL bEnabled);
    HRESULT ChangeKaraokePresMode(VARIANT_BOOL bEnabled);
    HRESULT ChangeVideoPresMode(VARIANT_BOOL bEnabled);
}

@GUID("b8be681a-eb2c-47f0-b415-94d5452f0e05")
interface IMSVidWebDVDAdm : IDispatch
{
    HRESULT ChangePassword(BSTR strUserName, BSTR strOld, BSTR strNew);
    HRESULT SaveParentalLevel(int level, BSTR strUserName, BSTR strPassword);
    HRESULT SaveParentalCountry(int country, BSTR strUserName, BSTR strPassword);
    HRESULT ConfirmPassword(BSTR strUserName, BSTR strPassword, VARIANT_BOOL* pVal);
    HRESULT GetParentalLevel(int* lLevel);
    HRESULT GetParentalCountry(int* lCountry);
    HRESULT get_DefaultAudioLCID(int* pVal);
    HRESULT put_DefaultAudioLCID(int newVal);
    HRESULT get_DefaultSubpictureLCID(int* pVal);
    HRESULT put_DefaultSubpictureLCID(int newVal);
    HRESULT get_DefaultMenuLCID(int* pVal);
    HRESULT put_DefaultMenuLCID(int newVal);
    HRESULT get_BookmarkOnStop(VARIANT_BOOL* pVal);
    HRESULT put_BookmarkOnStop(VARIANT_BOOL newVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nn-segment-imsvidoutputdevice
@GUID("37b03546-a4c8-11d2-b634-00c04f79498e")
interface IMSVidOutputDevice : IMSVidDevice
{
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nn-segment-imsvidoutputdeviceevent
@GUID("2e6a14e2-571c-11d3-b652-00c04f79498e")
interface IMSVidOutputDeviceEvent : IMSVidDeviceEvent
{
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nn-segment-imsvidfeature
@GUID("37b03547-a4c8-11d2-b634-00c04f79498e")
interface IMSVidFeature : IMSVidDevice
{
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nn-segment-imsvidfeatureevent
@GUID("3dd2903c-e0aa-11d2-b63a-00c04f79498e")
interface IMSVidFeatureEvent : IMSVidDeviceEvent
{
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nn-segment-imsvidencoder
@GUID("c0020fd4-bee7-43d9-a495-9f213117103d")
interface IMSVidEncoder : IMSVidFeature
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidencoder-get_videoencoderinterface
    HRESULT get_VideoEncoderInterface(IUnknown* ppEncInt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidencoder-get_audioencoderinterface
    HRESULT get_AudioEncoderInterface(IUnknown* ppEncInt);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nn-segment-imsvidclosedcaptioning
@GUID("99652ea1-c1f7-414f-bb7b-1c967de75983")
interface IMSVidClosedCaptioning : IMSVidFeature
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidclosedcaptioning-get_enable
    HRESULT get_Enable(VARIANT_BOOL* On);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidclosedcaptioning-put_enable
    HRESULT put_Enable(VARIANT_BOOL On);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nn-segment-imsvidclosedcaptioning2
@GUID("e00cb864-a029-4310-9987-a873f5887d97")
interface IMSVidClosedCaptioning2 : IMSVidClosedCaptioning
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidclosedcaptioning2-get_service
    HRESULT get_Service(MSVidCCService* On);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidclosedcaptioning2-put_service
    HRESULT put_Service(MSVidCCService On);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nn-segment-imsvidclosedcaptioning3
@GUID("c8638e8a-7625-4c51-9366-2f40a9831fc0")
interface IMSVidClosedCaptioning3 : IMSVidClosedCaptioning2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidclosedcaptioning3-get_teletextfilter
    HRESULT get_TeleTextFilter(IUnknown* punkTTFilter);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nn-segment-imsvidxds
@GUID("11ebc158-e712-4d1f-8bb3-01ed5274c4ce")
interface IMSVidXDS : IMSVidFeature
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidxds-get_channelchangeinterface
    HRESULT get_ChannelChangeInterface(IUnknown* punkCC);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nn-segment-imsvidxdsevent
@GUID("6db2317d-3b23-41ec-ba4b-701f407eaf3a")
interface IMSVidXDSEvent : IMSVidFeatureEvent
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidxdsevent-ratingchange
    HRESULT RatingChange(EnTvRat_System PrevRatingSystem, EnTvRat_GenericLevel PrevLevel, 
                         BfEnTvRat_GenericAttributes PrevAttributes, EnTvRat_System NewRatingSystem, 
                         EnTvRat_GenericLevel NewLevel, BfEnTvRat_GenericAttributes NewAttributes);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nn-segment-imsviddataservices
@GUID("334125c1-77e5-11d3-b653-00c04f79498e")
interface IMSVidDataServices : IMSVidFeature
{
}

@GUID("334125c2-77e5-11d3-b653-00c04f79498e")
interface IMSVidDataServicesEvent : IMSVidDeviceEvent
{
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nn-segment-imsvidvideorenderer
@GUID("37b03540-a4c8-11d2-b634-00c04f79498e")
interface IMSVidVideoRenderer : IMSVidOutputDevice
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidvideorenderer-get_customcompositorclass
    HRESULT get_CustomCompositorClass(BSTR* CompositorCLSID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidvideorenderer-put_customcompositorclass
    HRESULT put_CustomCompositorClass(BSTR CompositorCLSID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidvideorenderer-get__customcompositorclass
    HRESULT get__CustomCompositorClass(GUID* CompositorCLSID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidvideorenderer-put__customcompositorclass
    HRESULT put__CustomCompositorClass(const(GUID)* CompositorCLSID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidvideorenderer-get__customcompositor
    HRESULT get__CustomCompositor(IVMRImageCompositor* Compositor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidvideorenderer-put__customcompositor
    HRESULT put__CustomCompositor(IVMRImageCompositor Compositor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidvideorenderer-get_mixerbitmap
    HRESULT get_MixerBitmap(IPictureDisp* MixerPictureDisp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidvideorenderer-get__mixerbitmap
    HRESULT get__MixerBitmap(IVMRMixerBitmap* MixerPicture);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidvideorenderer-put_mixerbitmap
    HRESULT put_MixerBitmap(IPictureDisp MixerPictureDisp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidvideorenderer-put__mixerbitmap
    HRESULT put__MixerBitmap(VMRALPHABITMAP* MixerPicture);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidvideorenderer-get_mixerbitmappositionrect
    HRESULT get_MixerBitmapPositionRect(IMSVidRect* rDest);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidvideorenderer-put_mixerbitmappositionrect
    HRESULT put_MixerBitmapPositionRect(IMSVidRect rDest);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidvideorenderer-get_mixerbitmapopacity
    HRESULT get_MixerBitmapOpacity(int* opacity);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidvideorenderer-put_mixerbitmapopacity
    HRESULT put_MixerBitmapOpacity(int opacity);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidvideorenderer-setupmixerbitmap
    HRESULT SetupMixerBitmap(IPictureDisp MixerPictureDisp, int Opacity, IMSVidRect rDest);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidvideorenderer-get_sourcesize
    HRESULT get_SourceSize(SourceSizeList* CurrentSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidvideorenderer-put_sourcesize
    HRESULT put_SourceSize(SourceSizeList NewSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidvideorenderer-get_overscan
    HRESULT get_OverScan(int* plPercent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidvideorenderer-put_overscan
    HRESULT put_OverScan(int lPercent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidvideorenderer-get_availablesourcerect
    HRESULT get_AvailableSourceRect(IMSVidRect* pRect);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidvideorenderer-get_maxvidrect
    HRESULT get_MaxVidRect(IMSVidRect* ppVidRect);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidvideorenderer-get_minvidrect
    HRESULT get_MinVidRect(IMSVidRect* ppVidRect);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidvideorenderer-get_clippedsourcerect
    HRESULT get_ClippedSourceRect(IMSVidRect* pRect);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidvideorenderer-put_clippedsourcerect
    HRESULT put_ClippedSourceRect(IMSVidRect pRect);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidvideorenderer-get_usingoverlay
    HRESULT get_UsingOverlay(VARIANT_BOOL* UseOverlayVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidvideorenderer-put_usingoverlay
    HRESULT put_UsingOverlay(VARIANT_BOOL UseOverlayVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidvideorenderer-capture
    HRESULT Capture(IPictureDisp* currentImage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidvideorenderer-get_framespersecond
    HRESULT get_FramesPerSecond(int* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidvideorenderer-get_decimateinput
    HRESULT get_DecimateInput(VARIANT_BOOL* pDeci);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidvideorenderer-put_decimateinput
    HRESULT put_DecimateInput(VARIANT_BOOL pDeci);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nn-segment-imsvidvideorendererevent
@GUID("37b03545-a4c8-11d2-b634-00c04f79498e")
interface IMSVidVideoRendererEvent : IMSVidOutputDeviceEvent
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidvideorendererevent-overlayunavailable
    HRESULT OverlayUnavailable();
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nn-segment-imsvidgenericsink
@GUID("6c29b41d-455b-4c33-963a-0d28e5e555ea")
interface IMSVidGenericSink : IMSVidOutputDevice
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidgenericsink-setsinkfilter
    HRESULT SetSinkFilter(BSTR bstrName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidgenericsink-get_sinkstreams
    HRESULT get_SinkStreams(MSVidSinkStreams* pStreams);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidgenericsink-put_sinkstreams
    HRESULT put_SinkStreams(MSVidSinkStreams Streams);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nn-segment-imsvidgenericsink2
@GUID("6b5a28f3-47f1-4092-b168-60cabec08f1c")
interface IMSVidGenericSink2 : IMSVidGenericSink
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidgenericsink2-addfilter
    HRESULT AddFilter(BSTR bstrName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidgenericsink2-resetfilterlist
    HRESULT ResetFilterList();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nn-segment-imsvidstreambufferrecordingcontrol
@GUID("160621aa-bbbc-4326-a824-c395aebc6e74")
interface IMSVidStreamBufferRecordingControl : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambufferrecordingcontrol-get_starttime
    HRESULT get_StartTime(int* rtStart);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambufferrecordingcontrol-put_starttime
    HRESULT put_StartTime(int rtStart);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambufferrecordingcontrol-get_stoptime
    HRESULT get_StopTime(int* rtStop);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambufferrecordingcontrol-put_stoptime
    HRESULT put_StopTime(int rtStop);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambufferrecordingcontrol-get_recordingstopped
    HRESULT get_RecordingStopped(VARIANT_BOOL* phResult);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambufferrecordingcontrol-get_recordingstarted
    HRESULT get_RecordingStarted(VARIANT_BOOL* phResult);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambufferrecordingcontrol-get_recordingtype
    HRESULT get_RecordingType(RecordingType* dwType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambufferrecordingcontrol-get_recordingattribute
    HRESULT get_RecordingAttribute(IUnknown* pRecordingAttribute);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nn-segment-imsvidstreambuffersink
@GUID("159dbb45-cd1b-4dab-83ea-5cb1f4f21d07")
interface IMSVidStreamBufferSink : IMSVidOutputDevice
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambuffersink-get_contentrecorder
    HRESULT get_ContentRecorder(BSTR pszFilename, IMSVidStreamBufferRecordingControl* pRecordingIUnknown);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambuffersink-get_referencerecorder
    HRESULT get_ReferenceRecorder(BSTR pszFilename, IMSVidStreamBufferRecordingControl* pRecordingIUnknown);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambuffersink-get_sinkname
    HRESULT get_SinkName(BSTR* pName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambuffersink-put_sinkname
    HRESULT put_SinkName(BSTR Name);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambuffersink-namesetlock
    HRESULT NameSetLock();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambuffersink-get_sbesink
    HRESULT get_SBESink(IUnknown* sbeConfig);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nn-segment-imsvidstreambuffersink2
@GUID("2ca9fc63-c131-4e5a-955a-544a47c67146")
interface IMSVidStreamBufferSink2 : IMSVidStreamBufferSink
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambuffersink2-unlockprofile
    HRESULT UnlockProfile();
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nn-segment-imsvidstreambuffersink3
@GUID("4f8721d7-7d59-4d8b-99f5-a77775586bd5")
interface IMSVidStreamBufferSink3 : IMSVidStreamBufferSink2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambuffersink3-setminseek
    HRESULT SetMinSeek(int* pdwMin);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambuffersink3-get_audiocounter
    HRESULT get_AudioCounter(IUnknown* ppUnk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambuffersink3-get_videocounter
    HRESULT get_VideoCounter(IUnknown* ppUnk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambuffersink3-get_cccounter
    HRESULT get_CCCounter(IUnknown* ppUnk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambuffersink3-get_wstcounter
    HRESULT get_WSTCounter(IUnknown* ppUnk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambuffersink3-put_audioanalysisfilter
    HRESULT put_AudioAnalysisFilter(BSTR szCLSID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambuffersink3-get_audioanalysisfilter
    HRESULT get_AudioAnalysisFilter(BSTR* pszCLSID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambuffersink3-put__audioanalysisfilter
    HRESULT put__AudioAnalysisFilter(GUID guid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambuffersink3-get__audioanalysisfilter
    HRESULT get__AudioAnalysisFilter(GUID* pGuid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambuffersink3-put_videoanalysisfilter
    HRESULT put_VideoAnalysisFilter(BSTR szCLSID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambuffersink3-get_videoanalysisfilter
    HRESULT get_VideoAnalysisFilter(BSTR* pszCLSID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambuffersink3-put__videoanalysisfilter
    HRESULT put__VideoAnalysisFilter(GUID guid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambuffersink3-get__videoanalysisfilter
    HRESULT get__VideoAnalysisFilter(GUID* pGuid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambuffersink3-put_dataanalysisfilter
    HRESULT put_DataAnalysisFilter(BSTR szCLSID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambuffersink3-get_dataanalysisfilter
    HRESULT get_DataAnalysisFilter(BSTR* pszCLSID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambuffersink3-put__dataanalysisfilter
    HRESULT put__DataAnalysisFilter(GUID guid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambuffersink3-get__dataanalysisfilter
    HRESULT get__DataAnalysisFilter(GUID* pGuid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambuffersink3-get_licenseerrorcode
    HRESULT get_LicenseErrorCode(HRESULT* hres);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nn-segment-imsvidstreambuffersinkevent
@GUID("f798a36b-b05b-4bbe-9703-eaea7d61cd51")
interface IMSVidStreamBufferSinkEvent : IMSVidOutputDeviceEvent
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambuffersinkevent-certificatefailure
    HRESULT CertificateFailure();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambuffersinkevent-certificatesuccess
    HRESULT CertificateSuccess();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambuffersinkevent-writefailure
    HRESULT WriteFailure();
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nn-segment-imsvidstreambuffersinkevent2
@GUID("3d7a5166-72d7-484b-a06f-286187b80ca1")
interface IMSVidStreamBufferSinkEvent2 : IMSVidStreamBufferSinkEvent
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambuffersinkevent2-encryptionon
    HRESULT EncryptionOn();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambuffersinkevent2-encryptionoff
    HRESULT EncryptionOff();
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nn-segment-imsvidstreambuffersinkevent3
@GUID("735ad8d5-c259-48e9-81e7-d27953665b23")
interface IMSVidStreamBufferSinkEvent3 : IMSVidStreamBufferSinkEvent2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambuffersinkevent3-licensechange
    HRESULT LicenseChange(int dwProt);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nn-segment-imsvidstreambuffersinkevent4
@GUID("1b01dcb0-daf0-412c-a5d1-590c7f62e2b8")
interface IMSVidStreamBufferSinkEvent4 : IMSVidStreamBufferSinkEvent3
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambuffersinkevent4-writefailureclear
    HRESULT WriteFailureClear();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nn-segment-imsvidstreambuffersource
@GUID("eb0c8cf9-6950-4772-87b1-47d11cf3a02f")
interface IMSVidStreamBufferSource : IMSVidFilePlayback
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambuffersource-get_start
    HRESULT get_Start(int* lStart);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambuffersource-get_recordingattribute
    HRESULT get_RecordingAttribute(IUnknown* pRecordingAttribute);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambuffersource-currentratings
    HRESULT CurrentRatings(EnTvRat_System* pEnSystem, EnTvRat_GenericLevel* pEnRating, int* pBfEnAttr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambuffersource-maxratingslevel
    HRESULT MaxRatingsLevel(EnTvRat_System enSystem, EnTvRat_GenericLevel enRating, int lbfEnAttr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambuffersource-put_blockunrated
    HRESULT put_BlockUnrated(VARIANT_BOOL bBlock);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambuffersource-put_unrateddelay
    HRESULT put_UnratedDelay(int dwDelay);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambuffersource-get_sbesource
    HRESULT get_SBESource(IUnknown* sbeFilter);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nn-segment-imsvidstreambuffersource2
@GUID("e4ba9059-b1ce-40d8-b9a0-d4ea4a9989d3")
interface IMSVidStreamBufferSource2 : IMSVidStreamBufferSource
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambuffersource2-put_rateex
    HRESULT put_RateEx(double dwRate, uint dwFramesPerSecond);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambuffersource2-get_audiocounter
    HRESULT get_AudioCounter(IUnknown* ppUnk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambuffersource2-get_videocounter
    HRESULT get_VideoCounter(IUnknown* ppUnk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambuffersource2-get_cccounter
    HRESULT get_CCCounter(IUnknown* ppUnk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambuffersource2-get_wstcounter
    HRESULT get_WSTCounter(IUnknown* ppUnk);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nn-segment-imsvidstreambuffersourceevent
@GUID("50ce8a7d-9c28-4da8-9042-cdfa7116f979")
interface IMSVidStreamBufferSourceEvent : IMSVidFilePlaybackEvent
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambuffersourceevent-certificatefailure
    HRESULT CertificateFailure();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambuffersourceevent-certificatesuccess
    HRESULT CertificateSuccess();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambuffersourceevent-ratingsblocked
    HRESULT RatingsBlocked();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambuffersourceevent-ratingsunblocked
    HRESULT RatingsUnblocked();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambuffersourceevent-ratingschanged
    HRESULT RatingsChanged();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambuffersourceevent-timehole
    HRESULT TimeHole(int StreamOffsetMS, int SizeMS);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambuffersourceevent-staledataread
    HRESULT StaleDataRead();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambuffersourceevent-contentbecomingstale
    HRESULT ContentBecomingStale();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambuffersourceevent-stalefiledeleted
    HRESULT StaleFileDeleted();
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nn-segment-imsvidstreambuffersourceevent2
@GUID("7aef50ce-8e22-4ba8-bc06-a92a458b4ef2")
interface IMSVidStreamBufferSourceEvent2 : IMSVidStreamBufferSourceEvent
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambuffersourceevent2-ratechange
    HRESULT RateChange(double qwNewRate, double qwOldRate);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nn-segment-imsvidstreambuffersourceevent3
@GUID("ceabd6ab-9b90-4570-adf1-3ce76e00a763")
interface IMSVidStreamBufferSourceEvent3 : IMSVidStreamBufferSourceEvent2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambuffersourceevent3-broadcastevent
    HRESULT BroadcastEvent(BSTR Guid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambuffersourceevent3-broadcasteventex
    HRESULT BroadcastEventEx(BSTR Guid, uint Param1, uint Param2, uint Param3, uint Param4);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambuffersourceevent3-coppblocked
    HRESULT COPPBlocked();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambuffersourceevent3-coppunblocked
    HRESULT COPPUnblocked();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambuffersourceevent3-contentprimarilyaudio
    HRESULT ContentPrimarilyAudio();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nn-segment-imsvidstreambufferv2sourceevent
@GUID("49c771f9-41b2-4cf7-9f9a-a313a8f6027e")
interface IMSVidStreamBufferV2SourceEvent : IMSVidFilePlaybackEvent
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambufferv2sourceevent-ratingschanged
    HRESULT RatingsChanged();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambufferv2sourceevent-timehole
    HRESULT TimeHole(int StreamOffsetMS, int SizeMS);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambufferv2sourceevent-staledataread
    HRESULT StaleDataRead();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambufferv2sourceevent-contentbecomingstale
    HRESULT ContentBecomingStale();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambufferv2sourceevent-stalefiledeleted
    HRESULT StaleFileDeleted();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambufferv2sourceevent-ratechange
    HRESULT RateChange(double qwNewRate, double qwOldRate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambufferv2sourceevent-broadcastevent
    HRESULT BroadcastEvent(BSTR Guid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambufferv2sourceevent-broadcasteventex
    HRESULT BroadcastEventEx(BSTR Guid, uint Param1, uint Param2, uint Param3, uint Param4);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidstreambufferv2sourceevent-contentprimarilyaudio
    HRESULT ContentPrimarilyAudio();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nn-segment-imsvidvideorenderer2
@GUID("6bdd5c1e-2810-4159-94bc-05511ae8549b")
interface IMSVidVideoRenderer2 : IMSVidVideoRenderer
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidvideorenderer2-get_allocator
    HRESULT get_Allocator(IUnknown* AllocPresent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidvideorenderer2-get__allocator
    HRESULT get__Allocator(IVMRSurfaceAllocator* AllocPresent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidvideorenderer2-get_allocator_id
    HRESULT get_Allocator_ID(int* ID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidvideorenderer2-setallocator
    HRESULT SetAllocator(IUnknown AllocPresent, int ID);
    HRESULT _SetAllocator2(IVMRSurfaceAllocator AllocPresent, int ID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidvideorenderer2-put_suppresseffects
    HRESULT put_SuppressEffects(VARIANT_BOOL bSuppress);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidvideorenderer2-get_suppresseffects
    HRESULT get_SuppressEffects(VARIANT_BOOL* bSuppress);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nn-segment-imsvidvideorendererevent2
@GUID("7145ed66-4730-4fdb-8a53-fde7508d3e5e")
interface IMSVidVideoRendererEvent2 : IMSVidOutputDeviceEvent
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidvideorendererevent2-overlayunavailable
    HRESULT OverlayUnavailable();
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nn-segment-imsvidvmr9
@GUID("d58b0015-ebef-44bb-bbdd-3f3699d76ea1")
interface IMSVidVMR9 : IMSVidVideoRenderer
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidvmr9-get_allocator_id
    HRESULT get_Allocator_ID(int* ID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidvmr9-setallocator
    HRESULT SetAllocator(IUnknown AllocPresent, int ID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidvmr9-put_suppresseffects
    HRESULT put_SuppressEffects(VARIANT_BOOL bSuppress);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidvmr9-get_suppresseffects
    HRESULT get_SuppressEffects(VARIANT_BOOL* bSuppress);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidvmr9-get_allocator
    HRESULT get_Allocator(IUnknown* AllocPresent);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nn-segment-imsvidevr
@GUID("15e496ae-82a8-4cf9-a6b6-c561dc60398f")
interface IMSVidEVR : IMSVidVideoRenderer
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidevr-get_presenter
    HRESULT get_Presenter(IMFVideoPresenter* ppAllocPresent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidevr-put_presenter
    HRESULT put_Presenter(IMFVideoPresenter pAllocPresent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidevr-put_suppresseffects
    HRESULT put_SuppressEffects(VARIANT_BOOL bSuppress);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidevr-get_suppresseffects
    HRESULT get_SuppressEffects(VARIANT_BOOL* bSuppress);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nn-segment-imsvidevrevent
@GUID("349abb10-883c-4f22-8714-cecaeee45d62")
interface IMSVidEVREvent : IMSVidOutputDeviceEvent
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidevrevent-onuserevent
    HRESULT OnUserEvent(int lEventCode);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nn-segment-imsvidaudiorenderer
@GUID("37b0353f-a4c8-11d2-b634-00c04f79498e")
interface IMSVidAudioRenderer : IMSVidOutputDevice
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidaudiorenderer-put_volume
    HRESULT put_Volume(int lVol);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidaudiorenderer-get_volume
    HRESULT get_Volume(int* lVol);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidaudiorenderer-put_balance
    HRESULT put_Balance(int lBal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidaudiorenderer-get_balance
    HRESULT get_Balance(int* lBal);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nn-segment-imsvidaudiorendererevent
@GUID("37b03541-a4c8-11d2-b634-00c04f79498e")
interface IMSVidAudioRendererEvent : IMSVidOutputDeviceEvent
{
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nn-segment-imsvidaudiorendererevent2
@GUID("e3f55729-353b-4c43-a028-50f79aa9a907")
interface IMSVidAudioRendererEvent2 : IMSVidAudioRendererEvent
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidaudiorendererevent2-avdecaudiodualmono
    HRESULT AVDecAudioDualMono();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidaudiorendererevent2-avaudiosamplerate
    HRESULT AVAudioSampleRate();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidaudiorendererevent2-avaudiochannelconfig
    HRESULT AVAudioChannelConfig();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidaudiorendererevent2-avaudiochannelcount
    HRESULT AVAudioChannelCount();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidaudiorendererevent2-avdeccommonmeanbitrate
    HRESULT AVDecCommonMeanBitRate();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidaudiorendererevent2-avddsurroundmode
    HRESULT AVDDSurroundMode();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidaudiorendererevent2-avdeccommoninputformat
    HRESULT AVDecCommonInputFormat();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidaudiorendererevent2-avdeccommonoutputformat
    HRESULT AVDecCommonOutputFormat();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nn-segment-imsvidinputdevices
@GUID("c5702cd1-9b79-11d3-b654-00c04f79498e")
interface IMSVidInputDevices : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidinputdevices-get_count
    HRESULT get_Count(int* lCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidinputdevices-get__newenum
    HRESULT get__NewEnum(IEnumVARIANT* pD);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidinputdevices-get_item
    HRESULT get_Item(VARIANT v, IMSVidInputDevice* pDB);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidinputdevices-add
    HRESULT Add(IMSVidInputDevice pDB);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidinputdevices-remove
    HRESULT Remove(VARIANT v);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nn-segment-imsvidoutputdevices
@GUID("c5702cd2-9b79-11d3-b654-00c04f79498e")
interface IMSVidOutputDevices : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidoutputdevices-get_count
    HRESULT get_Count(int* lCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidoutputdevices-get__newenum
    HRESULT get__NewEnum(IEnumVARIANT* pD);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidoutputdevices-get_item
    HRESULT get_Item(VARIANT v, IMSVidOutputDevice* pDB);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidoutputdevices-add
    HRESULT Add(IMSVidOutputDevice pDB);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidoutputdevices-remove
    HRESULT Remove(VARIANT v);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nn-segment-imsvidvideorendererdevices
@GUID("c5702cd3-9b79-11d3-b654-00c04f79498e")
interface IMSVidVideoRendererDevices : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidvideorendererdevices-get_count
    HRESULT get_Count(int* lCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidvideorendererdevices-get__newenum
    HRESULT get__NewEnum(IEnumVARIANT* pD);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidvideorendererdevices-get_item
    HRESULT get_Item(VARIANT v, IMSVidVideoRenderer* pDB);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidvideorendererdevices-add
    HRESULT Add(IMSVidVideoRenderer pDB);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidvideorendererdevices-remove
    HRESULT Remove(VARIANT v);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nn-segment-imsvidaudiorendererdevices
@GUID("c5702cd4-9b79-11d3-b654-00c04f79498e")
interface IMSVidAudioRendererDevices : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidaudiorendererdevices-get_count
    HRESULT get_Count(int* lCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidaudiorendererdevices-get__newenum
    HRESULT get__NewEnum(IEnumVARIANT* pD);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidaudiorendererdevices-get_item
    HRESULT get_Item(VARIANT v, IMSVidAudioRenderer* pDB);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidaudiorendererdevices-add
    HRESULT Add(IMSVidAudioRenderer pDB);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidaudiorendererdevices-remove
    HRESULT Remove(VARIANT v);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nn-segment-imsvidfeatures
@GUID("c5702cd5-9b79-11d3-b654-00c04f79498e")
interface IMSVidFeatures : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidfeatures-get_count
    HRESULT get_Count(int* lCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidfeatures-get__newenum
    HRESULT get__NewEnum(IEnumVARIANT* pD);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidfeatures-get_item
    HRESULT get_Item(VARIANT v, IMSVidFeature* pDB);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidfeatures-add
    HRESULT Add(IMSVidFeature pDB);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/segment/nf-segment-imsvidfeatures-remove
    HRESULT Remove(VARIANT v);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msvidctl/nn-msvidctl-imsvidctl
@GUID("b0edf162-910a-11d2-b632-00c04f79498e")
interface IMSVidCtl : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msvidctl/nf-msvidctl-imsvidctl-get_autosize
    HRESULT get_AutoSize(VARIANT_BOOL* pbool);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msvidctl/nf-msvidctl-imsvidctl-put_autosize
    HRESULT put_AutoSize(VARIANT_BOOL vbool);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msvidctl/nf-msvidctl-imsvidctl-get_backcolor
    HRESULT get_BackColor(uint* backcolor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msvidctl/nf-msvidctl-imsvidctl-put_backcolor
    HRESULT put_BackColor(uint backcolor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msvidctl/nf-msvidctl-imsvidctl-get_enabled
    HRESULT get_Enabled(VARIANT_BOOL* pbool);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msvidctl/nf-msvidctl-imsvidctl-put_enabled
    HRESULT put_Enabled(VARIANT_BOOL vbool);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msvidctl/nf-msvidctl-imsvidctl-get_tabstop
    HRESULT get_TabStop(VARIANT_BOOL* pbool);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msvidctl/nf-msvidctl-imsvidctl-put_tabstop
    HRESULT put_TabStop(VARIANT_BOOL vbool);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msvidctl/nf-msvidctl-imsvidctl-get_window
    HRESULT get_Window(HWND* phwnd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msvidctl/nf-msvidctl-imsvidctl-refresh
    HRESULT Refresh();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msvidctl/nf-msvidctl-imsvidctl-get_displaysize
    HRESULT get_DisplaySize(DisplaySizeList* CurrentValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msvidctl/nf-msvidctl-imsvidctl-put_displaysize
    HRESULT put_DisplaySize(DisplaySizeList NewValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msvidctl/nf-msvidctl-imsvidctl-get_maintainaspectratio
    HRESULT get_MaintainAspectRatio(VARIANT_BOOL* CurrentValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msvidctl/nf-msvidctl-imsvidctl-put_maintainaspectratio
    HRESULT put_MaintainAspectRatio(VARIANT_BOOL NewValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msvidctl/nf-msvidctl-imsvidctl-get_colorkey
    HRESULT get_ColorKey(uint* CurrentValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msvidctl/nf-msvidctl-imsvidctl-put_colorkey
    HRESULT put_ColorKey(uint NewValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msvidctl/nf-msvidctl-imsvidctl-get_inputsavailable
    HRESULT get_InputsAvailable(BSTR CategoryGuid, IMSVidInputDevices* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msvidctl/nf-msvidctl-imsvidctl-get_outputsavailable
    HRESULT get_OutputsAvailable(BSTR CategoryGuid, IMSVidOutputDevices* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msvidctl/nf-msvidctl-imsvidctl-get__inputsavailable
    HRESULT get__InputsAvailable(const(GUID)* CategoryGuid, IMSVidInputDevices* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msvidctl/nf-msvidctl-imsvidctl-get__outputsavailable
    HRESULT get__OutputsAvailable(const(GUID)* CategoryGuid, IMSVidOutputDevices* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msvidctl/nf-msvidctl-imsvidctl-get_videorenderersavailable
    HRESULT get_VideoRenderersAvailable(IMSVidVideoRendererDevices* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msvidctl/nf-msvidctl-imsvidctl-get_audiorenderersavailable
    HRESULT get_AudioRenderersAvailable(IMSVidAudioRendererDevices* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msvidctl/nf-msvidctl-imsvidctl-get_featuresavailable
    HRESULT get_FeaturesAvailable(IMSVidFeatures* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msvidctl/nf-msvidctl-imsvidctl-get_inputactive
    HRESULT get_InputActive(IMSVidInputDevice* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msvidctl/nf-msvidctl-imsvidctl-put_inputactive
    HRESULT put_InputActive(IMSVidInputDevice pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msvidctl/nf-msvidctl-imsvidctl-get_outputsactive
    HRESULT get_OutputsActive(IMSVidOutputDevices* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msvidctl/nf-msvidctl-imsvidctl-put_outputsactive
    HRESULT put_OutputsActive(IMSVidOutputDevices pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msvidctl/nf-msvidctl-imsvidctl-get_videorendereractive
    HRESULT get_VideoRendererActive(IMSVidVideoRenderer* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msvidctl/nf-msvidctl-imsvidctl-put_videorendereractive
    HRESULT put_VideoRendererActive(IMSVidVideoRenderer pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msvidctl/nf-msvidctl-imsvidctl-get_audiorendereractive
    HRESULT get_AudioRendererActive(IMSVidAudioRenderer* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msvidctl/nf-msvidctl-imsvidctl-put_audiorendereractive
    HRESULT put_AudioRendererActive(IMSVidAudioRenderer pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msvidctl/nf-msvidctl-imsvidctl-get_featuresactive
    HRESULT get_FeaturesActive(IMSVidFeatures* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msvidctl/nf-msvidctl-imsvidctl-put_featuresactive
    HRESULT put_FeaturesActive(IMSVidFeatures pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msvidctl/nf-msvidctl-imsvidctl-get_state
    HRESULT get_State(MSVidCtlStateList* lState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msvidctl/nf-msvidctl-imsvidctl-view
    HRESULT View(VARIANT* v);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msvidctl/nf-msvidctl-imsvidctl-build
    HRESULT Build();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msvidctl/nf-msvidctl-imsvidctl-pause
    HRESULT Pause();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msvidctl/nf-msvidctl-imsvidctl-run
    HRESULT Run();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msvidctl/nf-msvidctl-imsvidctl-stop
    HRESULT Stop();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msvidctl/nf-msvidctl-imsvidctl-decompose
    HRESULT Decompose();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msvidctl/nf-msvidctl-imsvidctl-disablevideo
    HRESULT DisableVideo();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msvidctl/nf-msvidctl-imsvidctl-disableaudio
    HRESULT DisableAudio();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msvidctl/nf-msvidctl-imsvidctl-viewnext
    HRESULT ViewNext(VARIANT* v);
}

@GUID("c3a9f406-2222-436d-86d5-ba3229279efb")
interface IMSEventBinder : IDispatch
{
    HRESULT Bind(IDispatch pEventObject, BSTR EventName, BSTR EventHandler, int* CancelID);
    HRESULT Unbind(uint CancelCookie);
}

@GUID("b0edf164-910a-11d2-b632-00c04f79498e")
interface _IMSVidCtlEvents : IDispatch
{
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nn-sbe-istreambufferinitialize
@GUID("9ce50f2d-6ba7-40fb-a034-50b1a674ec78")
interface IStreamBufferInitialize : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nf-sbe-istreambufferinitialize-sethkey
    HRESULT SetHKEY(HKEY hkeyRoot);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nf-sbe-istreambufferinitialize-setsids
    HRESULT SetSIDs(uint cSIDs, PSID* ppSID);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nn-sbe-istreambuffersink
@GUID("afd1f242-7efd-45ee-ba4e-407a25c9a77a")
interface IStreamBufferSink : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nf-sbe-istreambuffersink-lockprofile
    HRESULT LockProfile(const(PWSTR) pszStreamBufferFilename);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nf-sbe-istreambuffersink-createrecorder
    HRESULT CreateRecorder(const(PWSTR) pszFilename, uint dwRecordType, IUnknown* pRecordingIUnknown);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nf-sbe-istreambuffersink-isprofilelocked
    HRESULT IsProfileLocked();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nn-sbe-istreambuffersink2
@GUID("db94a660-f4fb-4bfa-bcc6-fe159a4eea93")
interface IStreamBufferSink2 : IStreamBufferSink
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nf-sbe-istreambuffersink2-unlockprofile
    HRESULT UnlockProfile();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nn-sbe-istreambuffersink3
@GUID("974723f2-887a-4452-9366-2cff3057bc8f")
interface IStreamBufferSink3 : IStreamBufferSink2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nf-sbe-istreambuffersink3-setavailablefilter
    HRESULT SetAvailableFilter(long* prtMin);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nn-sbe-istreambuffersource
@GUID("1c5bd776-6ced-4f44-8164-5eab0e98db12")
interface IStreamBufferSource : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nf-sbe-istreambuffersource-setstreamsink
    HRESULT SetStreamSink(IStreamBufferSink pIStreamBufferSink);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nn-sbe-istreambufferrecordcontrol
@GUID("ba9b6c99-f3c7-4ff2-92db-cfdd4851bf31")
interface IStreamBufferRecordControl : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nf-sbe-istreambufferrecordcontrol-start
    HRESULT Start(long* prtStart);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nf-sbe-istreambufferrecordcontrol-stop
    HRESULT Stop(long rtStop);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nf-sbe-istreambufferrecordcontrol-getrecordingstatus
    HRESULT GetRecordingStatus(HRESULT* phResult, BOOL* pbStarted, BOOL* pbStopped);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nn-sbe-istreambufferreccomp
@GUID("9e259a9b-8815-42ae-b09f-221970b154fd")
interface IStreamBufferRecComp : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nf-sbe-istreambufferreccomp-initialize
    HRESULT Initialize(const(PWSTR) pszTargetFilename, const(PWSTR) pszSBRecProfileRef);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nf-sbe-istreambufferreccomp-append
    HRESULT Append(const(PWSTR) pszSBRecording);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nf-sbe-istreambufferreccomp-appendex
    HRESULT AppendEx(const(PWSTR) pszSBRecording, long rtStart, long rtStop);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nf-sbe-istreambufferreccomp-getcurrentlength
    HRESULT GetCurrentLength(uint* pcSeconds);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nf-sbe-istreambufferreccomp-close
    HRESULT Close();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nf-sbe-istreambufferreccomp-cancel
    HRESULT Cancel();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nn-sbe-istreambufferrecordingattribute
@GUID("16ca4e03-fe69-4705-bd41-5b7dfc0c95f3")
interface IStreamBufferRecordingAttribute : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nf-sbe-istreambufferrecordingattribute-setattribute
    HRESULT SetAttribute(uint ulReserved, const(PWSTR) pszAttributeName, 
                         STREAMBUFFER_ATTR_DATATYPE StreamBufferAttributeType, ubyte* pbAttribute, 
                         ushort cbAttributeLength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nf-sbe-istreambufferrecordingattribute-getattributecount
    HRESULT GetAttributeCount(uint ulReserved, ushort* pcAttributes);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nf-sbe-istreambufferrecordingattribute-getattributebyname
    HRESULT GetAttributeByName(const(PWSTR) pszAttributeName, uint* pulReserved, 
                               STREAMBUFFER_ATTR_DATATYPE* pStreamBufferAttributeType, ubyte* pbAttribute, 
                               ushort* pcbLength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nf-sbe-istreambufferrecordingattribute-getattributebyindex
    HRESULT GetAttributeByIndex(ushort wIndex, uint* pulReserved, PWSTR pszAttributeName, ushort* pcchNameLength, 
                                STREAMBUFFER_ATTR_DATATYPE* pStreamBufferAttributeType, ubyte* pbAttribute, 
                                ushort* pcbLength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nf-sbe-istreambufferrecordingattribute-enumattributes
    HRESULT EnumAttributes(IEnumStreamBufferRecordingAttrib* ppIEnumStreamBufferAttrib);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nn-sbe-ienumstreambufferrecordingattrib
@GUID("c18a9162-1e82-4142-8c73-5690fa62fe33")
interface IEnumStreamBufferRecordingAttrib : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nf-sbe-ienumstreambufferrecordingattrib-next
    HRESULT Next(uint cRequest, STREAMBUFFER_ATTRIBUTE* pStreamBufferAttribute, uint* pcReceived);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nf-sbe-ienumstreambufferrecordingattrib-skip
    HRESULT Skip(uint cRecords);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nf-sbe-ienumstreambufferrecordingattrib-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nf-sbe-ienumstreambufferrecordingattrib-clone
    HRESULT Clone(IEnumStreamBufferRecordingAttrib* ppIEnumStreamBufferAttrib);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nn-sbe-istreambufferconfigure
@GUID("ce14dfae-4098-4af7-bbf7-d6511f835414")
interface IStreamBufferConfigure : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nf-sbe-istreambufferconfigure-setdirectory
    HRESULT SetDirectory(const(PWSTR) pszDirectoryName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nf-sbe-istreambufferconfigure-getdirectory
    HRESULT GetDirectory(PWSTR* ppszDirectoryName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nf-sbe-istreambufferconfigure-setbackingfilecount
    HRESULT SetBackingFileCount(uint dwMin, uint dwMax);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nf-sbe-istreambufferconfigure-getbackingfilecount
    HRESULT GetBackingFileCount(uint* pdwMin, uint* pdwMax);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nf-sbe-istreambufferconfigure-setbackingfileduration
    HRESULT SetBackingFileDuration(uint dwSeconds);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nf-sbe-istreambufferconfigure-getbackingfileduration
    HRESULT GetBackingFileDuration(uint* pdwSeconds);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nn-sbe-istreambufferconfigure2
@GUID("53e037bf-3992-4282-ae34-2487b4dae06b")
interface IStreamBufferConfigure2 : IStreamBufferConfigure
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nf-sbe-istreambufferconfigure2-setmultiplexedpacketsize
    HRESULT SetMultiplexedPacketSize(uint cbBytesPerPacket);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nf-sbe-istreambufferconfigure2-getmultiplexedpacketsize
    HRESULT GetMultiplexedPacketSize(uint* pcbBytesPerPacket);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nf-sbe-istreambufferconfigure2-setfftransitionrates
    HRESULT SetFFTransitionRates(uint dwMaxFullFrameRate, uint dwMaxNonSkippingRate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nf-sbe-istreambufferconfigure2-getfftransitionrates
    HRESULT GetFFTransitionRates(uint* pdwMaxFullFrameRate, uint* pdwMaxNonSkippingRate);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nn-sbe-istreambufferconfigure3
@GUID("7e2d2a1e-7192-4bd7-80c1-061fd1d10402")
interface IStreamBufferConfigure3 : IStreamBufferConfigure2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nf-sbe-istreambufferconfigure3-setstartrecconfig
    HRESULT SetStartRecConfig(BOOL fStartStopsCur);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nf-sbe-istreambufferconfigure3-getstartrecconfig
    HRESULT GetStartRecConfig(BOOL* pfStartStopsCur);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nf-sbe-istreambufferconfigure3-setnamespace
    HRESULT SetNamespace(PWSTR pszNamespace);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nf-sbe-istreambufferconfigure3-getnamespace
    HRESULT GetNamespace(PWSTR* ppszNamespace);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nn-sbe-istreambuffermediaseeking
@GUID("f61f5c26-863d-4afa-b0ba-2f81dc978596")
interface IStreamBufferMediaSeeking : IMediaSeeking
{
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nn-sbe-istreambuffermediaseeking2
@GUID("3a439ab0-155f-470a-86a6-9ea54afd6eaf")
interface IStreamBufferMediaSeeking2 : IStreamBufferMediaSeeking
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nf-sbe-istreambuffermediaseeking2-setrateex
    HRESULT SetRateEx(double dRate, uint dwFramesPerSec);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nn-sbe-istreambufferdatacounters
@GUID("9d2a2563-31ab-402e-9a6b-adb903489440")
interface IStreamBufferDataCounters : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nf-sbe-istreambufferdatacounters-getdata
    HRESULT GetData(SBE_PIN_DATA* pPinData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nf-sbe-istreambufferdatacounters-resetdata
    HRESULT ResetData();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nn-sbe-isbe2globalevent
@GUID("caede759-b6b1-11db-a578-0018f3fa24c6")
interface ISBE2GlobalEvent : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nf-sbe-isbe2globalevent-getevent
    HRESULT GetEvent(const(GUID)* idEvt, uint param1, uint param2, uint param3, uint param4, BOOL* pSpanning, 
                     uint* pcb, ubyte* pb);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nn-sbe-isbe2globalevent2
@GUID("6d8309bf-00fe-4506-8b03-f8c65b5c9b39")
interface ISBE2GlobalEvent2 : ISBE2GlobalEvent
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nf-sbe-isbe2globalevent2-geteventex
    HRESULT GetEventEx(const(GUID)* idEvt, uint param1, uint param2, uint param3, uint param4, BOOL* pSpanning, 
                       uint* pcb, ubyte* pb, long* pStreamTime);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nn-sbe-isbe2spanningevent
@GUID("caede760-b6b1-11db-a578-0018f3fa24c6")
interface ISBE2SpanningEvent : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nf-sbe-isbe2spanningevent-getevent
    HRESULT GetEvent(const(GUID)* idEvt, uint streamId, uint* pcb, ubyte* pb);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nn-sbe-isbe2crossbar
@GUID("547b6d26-3226-487e-8253-8aa168749434")
interface ISBE2Crossbar : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nf-sbe-isbe2crossbar-enabledefaultmode
    HRESULT EnableDefaultMode(uint DefaultFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nf-sbe-isbe2crossbar-getinitialprofile
    HRESULT GetInitialProfile(ISBE2MediaTypeProfile* ppProfile);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nf-sbe-isbe2crossbar-setoutputprofile
    HRESULT SetOutputProfile(ISBE2MediaTypeProfile pProfile, uint* pcOutputPins, IPin* ppOutputPins);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nf-sbe-isbe2crossbar-enumstreams
    HRESULT EnumStreams(ISBE2EnumStream* ppStreams);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nn-sbe-isbe2streammap
@GUID("667c7745-85b1-4c55-ae55-4e25056159fc")
interface ISBE2StreamMap : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nf-sbe-isbe2streammap-mapstream
    HRESULT MapStream(uint Stream);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nf-sbe-isbe2streammap-unmapstream
    HRESULT UnmapStream(uint Stream);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nf-sbe-isbe2streammap-enummappedstreams
    HRESULT EnumMappedStreams(ISBE2EnumStream* ppStreams);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nn-sbe-isbe2enumstream
@GUID("f7611092-9fbc-46ec-a7c7-548ea78b71a4")
interface ISBE2EnumStream : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nf-sbe-isbe2enumstream-next
    HRESULT Next(uint cRequest, SBE2_STREAM_DESC* pStreamDesc, uint* pcReceived);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nf-sbe-isbe2enumstream-skip
    HRESULT Skip(uint cRecords);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nf-sbe-isbe2enumstream-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nf-sbe-isbe2enumstream-clone
    HRESULT Clone(ISBE2EnumStream* ppIEnumStream);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nn-sbe-isbe2mediatypeprofile
@GUID("f238267d-4671-40d7-997e-25dc32cfed2a")
interface ISBE2MediaTypeProfile : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nf-sbe-isbe2mediatypeprofile-getstreamcount
    HRESULT GetStreamCount(uint* pCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nf-sbe-isbe2mediatypeprofile-getstream
    HRESULT GetStream(uint Index, AM_MEDIA_TYPE** ppMediaType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nf-sbe-isbe2mediatypeprofile-addstream
    HRESULT AddStream(AM_MEDIA_TYPE* pMediaType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nf-sbe-isbe2mediatypeprofile-deletestream
    HRESULT DeleteStream(uint Index);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nn-sbe-isbe2filescan
@GUID("3e2bf5a5-4f96-4899-a1a3-75e8be9a5ac0")
interface ISBE2FileScan : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sbe/nf-sbe-isbe2filescan-repairfile
    HRESULT RepairFile(const(PWSTR) filename);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2data/nn-mpeg2data-impeg2tablefilter
@GUID("bdcdd913-9ecd-4fb2-81ae-adf747ea75a5")
interface IMpeg2TableFilter : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2data/nf-mpeg2data-impeg2tablefilter-addpid
    HRESULT AddPID(ushort p);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2data/nf-mpeg2data-impeg2tablefilter-addtable
    HRESULT AddTable(ushort p, ubyte t);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2data/nf-mpeg2data-impeg2tablefilter-addextension
    HRESULT AddExtension(ushort p, ubyte t, ushort e);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2data/nf-mpeg2data-impeg2tablefilter-removepid
    HRESULT RemovePID(ushort p);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2data/nf-mpeg2data-impeg2tablefilter-removetable
    HRESULT RemoveTable(ushort p, ubyte t);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2data/nf-mpeg2data-impeg2tablefilter-removeextension
    HRESULT RemoveExtension(ushort p, ubyte t, ushort e);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2data/nn-mpeg2data-impeg2data
@GUID("9b396d40-f380-4e3c-a514-1a82bf6ebfe6")
interface IMpeg2Data : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2data/nf-mpeg2data-impeg2data-getsection
    HRESULT GetSection(ushort pid, ubyte tid, MPEG2_FILTER* pFilter, uint dwTimeout, ISectionList* ppSectionList);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2data/nf-mpeg2data-impeg2data-gettable
    HRESULT GetTable(ushort pid, ubyte tid, MPEG2_FILTER* pFilter, uint dwTimeout, ISectionList* ppSectionList);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2data/nf-mpeg2data-impeg2data-getstreamofsections
    HRESULT GetStreamOfSections(ushort pid, ubyte tid, MPEG2_FILTER* pFilter, HANDLE hDataReadyEvent, 
                                IMpeg2Stream* ppMpegStream);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2data/nn-mpeg2data-isectionlist
@GUID("afec1eb5-2a64-46c6-bf4b-ae3ccb6afdb0")
interface ISectionList : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2data/nf-mpeg2data-isectionlist-initialize
    HRESULT Initialize(MPEG_REQUEST_TYPE requestType, IMpeg2Data pMpeg2Data, MPEG_CONTEXT* pContext, ushort pid, 
                       ubyte tid, MPEG2_FILTER* pFilter, uint timeout, HANDLE hDoneEvent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2data/nf-mpeg2data-isectionlist-initializewithrawsections
    HRESULT InitializeWithRawSections(MPEG_PACKET_LIST* pmplSections);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2data/nf-mpeg2data-isectionlist-cancelpendingrequest
    HRESULT CancelPendingRequest();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2data/nf-mpeg2data-isectionlist-getnumberofsections
    HRESULT GetNumberOfSections(ushort* pCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2data/nf-mpeg2data-isectionlist-getsectiondata
    HRESULT GetSectionData(ushort sectionNumber, uint* pdwRawPacketLength, SECTION** ppSection);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2data/nf-mpeg2data-isectionlist-getprogramidentifier
    HRESULT GetProgramIdentifier(ushort* pPid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2data/nf-mpeg2data-isectionlist-gettableidentifier
    HRESULT GetTableIdentifier(ubyte* pTableId);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2data/nn-mpeg2data-impeg2stream
@GUID("400cc286-32a0-4ce4-9041-39571125a635")
interface IMpeg2Stream : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2data/nf-mpeg2data-impeg2stream-initialize
    HRESULT Initialize(MPEG_REQUEST_TYPE requestType, IMpeg2Data pMpeg2Data, MPEG_CONTEXT* pContext, ushort pid, 
                       ubyte tid, MPEG2_FILTER* pFilter, HANDLE hDataReadyEvent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2data/nf-mpeg2data-impeg2stream-supplydatabuffer
    HRESULT SupplyDataBuffer(MPEG_STREAM_BUFFER* pStreamBuffer);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2psiparser/nn-mpeg2psiparser-igenericdescriptor
@GUID("6a5918f8-a77a-4f61-aed0-5702bdcda3e6")
interface IGenericDescriptor : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2psiparser/nf-mpeg2psiparser-igenericdescriptor-initialize
    HRESULT Initialize(ubyte* pbDesc, int bCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2psiparser/nf-mpeg2psiparser-igenericdescriptor-gettag
    HRESULT GetTag(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2psiparser/nf-mpeg2psiparser-igenericdescriptor-getlength
    HRESULT GetLength(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2psiparser/nf-mpeg2psiparser-igenericdescriptor-getbody
    HRESULT GetBody(ubyte** ppbVal);
}

@GUID("bf02fb7e-9792-4e10-a68d-033a2cc246a5")
interface IGenericDescriptor2 : IGenericDescriptor
{
    HRESULT Initialize(ubyte* pbDesc, ushort wCount);
    HRESULT GetLength(ushort* pwVal);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2psiparser/nn-mpeg2psiparser-ipat
@GUID("6623b511-4b5f-43c3-9a01-e8ff84188060")
interface IPAT : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2psiparser/nf-mpeg2psiparser-ipat-initialize
    HRESULT Initialize(ISectionList pSectionList, IMpeg2Data pMPEGData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2psiparser/nf-mpeg2psiparser-ipat-gettransportstreamid
    HRESULT GetTransportStreamId(ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2psiparser/nf-mpeg2psiparser-ipat-getversionnumber
    HRESULT GetVersionNumber(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2psiparser/nf-mpeg2psiparser-ipat-getcountofrecords
    HRESULT GetCountOfRecords(uint* pdwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2psiparser/nf-mpeg2psiparser-ipat-getrecordprogramnumber
    HRESULT GetRecordProgramNumber(uint dwIndex, ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2psiparser/nf-mpeg2psiparser-ipat-getrecordprogrammappid
    HRESULT GetRecordProgramMapPid(uint dwIndex, ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2psiparser/nf-mpeg2psiparser-ipat-findrecordprogrammappid
    HRESULT FindRecordProgramMapPid(ushort wProgramNumber, ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2psiparser/nf-mpeg2psiparser-ipat-registerfornexttable
    HRESULT RegisterForNextTable(HANDLE hNextTableAvailable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2psiparser/nf-mpeg2psiparser-ipat-getnexttable
    HRESULT GetNextTable(IPAT* ppPAT);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2psiparser/nf-mpeg2psiparser-ipat-registerforwhencurrent
    HRESULT RegisterForWhenCurrent(HANDLE hNextTableIsCurrent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2psiparser/nf-mpeg2psiparser-ipat-convertnexttocurrent
    HRESULT ConvertNextToCurrent();
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2psiparser/nn-mpeg2psiparser-icat
@GUID("7c6995fb-2a31-4bd7-953e-b1ad7fb7d31c")
interface ICAT : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2psiparser/nf-mpeg2psiparser-icat-initialize
    HRESULT Initialize(ISectionList pSectionList, IMpeg2Data pMPEGData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2psiparser/nf-mpeg2psiparser-icat-getversionnumber
    HRESULT GetVersionNumber(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2psiparser/nf-mpeg2psiparser-icat-getcountoftabledescriptors
    HRESULT GetCountOfTableDescriptors(uint* pdwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2psiparser/nf-mpeg2psiparser-icat-gettabledescriptorbyindex
    HRESULT GetTableDescriptorByIndex(uint dwIndex, IGenericDescriptor* ppDescriptor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2psiparser/nf-mpeg2psiparser-icat-gettabledescriptorbytag
    HRESULT GetTableDescriptorByTag(ubyte bTag, uint* pdwCookie, IGenericDescriptor* ppDescriptor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2psiparser/nf-mpeg2psiparser-icat-registerfornexttable
    HRESULT RegisterForNextTable(HANDLE hNextTableAvailable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2psiparser/nf-mpeg2psiparser-icat-getnexttable
    HRESULT GetNextTable(uint dwTimeout, ICAT* ppCAT);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2psiparser/nf-mpeg2psiparser-icat-registerforwhencurrent
    HRESULT RegisterForWhenCurrent(HANDLE hNextTableIsCurrent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2psiparser/nf-mpeg2psiparser-icat-convertnexttocurrent
    HRESULT ConvertNextToCurrent();
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2psiparser/nn-mpeg2psiparser-ipmt
@GUID("01f3b398-9527-4736-94db-5195878e97a8")
interface IPMT : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2psiparser/nf-mpeg2psiparser-ipmt-initialize
    HRESULT Initialize(ISectionList pSectionList, IMpeg2Data pMPEGData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2psiparser/nf-mpeg2psiparser-ipmt-getprogramnumber
    HRESULT GetProgramNumber(ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2psiparser/nf-mpeg2psiparser-ipmt-getversionnumber
    HRESULT GetVersionNumber(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2psiparser/nf-mpeg2psiparser-ipmt-getpcrpid
    HRESULT GetPcrPid(ushort* pPidVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2psiparser/nf-mpeg2psiparser-ipmt-getcountoftabledescriptors
    HRESULT GetCountOfTableDescriptors(uint* pdwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2psiparser/nf-mpeg2psiparser-ipmt-gettabledescriptorbyindex
    HRESULT GetTableDescriptorByIndex(uint dwIndex, IGenericDescriptor* ppDescriptor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2psiparser/nf-mpeg2psiparser-ipmt-gettabledescriptorbytag
    HRESULT GetTableDescriptorByTag(ubyte bTag, uint* pdwCookie, IGenericDescriptor* ppDescriptor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2psiparser/nf-mpeg2psiparser-ipmt-getcountofrecords
    HRESULT GetCountOfRecords(ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2psiparser/nf-mpeg2psiparser-ipmt-getrecordstreamtype
    HRESULT GetRecordStreamType(uint dwRecordIndex, ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2psiparser/nf-mpeg2psiparser-ipmt-getrecordelementarypid
    HRESULT GetRecordElementaryPid(uint dwRecordIndex, ushort* pPidVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2psiparser/nf-mpeg2psiparser-ipmt-getrecordcountofdescriptors
    HRESULT GetRecordCountOfDescriptors(uint dwRecordIndex, uint* pdwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2psiparser/nf-mpeg2psiparser-ipmt-getrecorddescriptorbyindex
    HRESULT GetRecordDescriptorByIndex(uint dwRecordIndex, uint dwDescIndex, IGenericDescriptor* ppDescriptor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2psiparser/nf-mpeg2psiparser-ipmt-getrecorddescriptorbytag
    HRESULT GetRecordDescriptorByTag(uint dwRecordIndex, ubyte bTag, uint* pdwCookie, 
                                     IGenericDescriptor* ppDescriptor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2psiparser/nf-mpeg2psiparser-ipmt-queryservicegatewayinfo
    HRESULT QueryServiceGatewayInfo(DSMCC_ELEMENT** ppDSMCCList, uint* puiCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2psiparser/nf-mpeg2psiparser-ipmt-querympeinfo
    HRESULT QueryMPEInfo(MPE_ELEMENT** ppMPEList, uint* puiCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2psiparser/nf-mpeg2psiparser-ipmt-registerfornexttable
    HRESULT RegisterForNextTable(HANDLE hNextTableAvailable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2psiparser/nf-mpeg2psiparser-ipmt-getnexttable
    HRESULT GetNextTable(IPMT* ppPMT);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2psiparser/nf-mpeg2psiparser-ipmt-registerforwhencurrent
    HRESULT RegisterForWhenCurrent(HANDLE hNextTableIsCurrent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2psiparser/nf-mpeg2psiparser-ipmt-convertnexttocurrent
    HRESULT ConvertNextToCurrent();
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2psiparser/nn-mpeg2psiparser-itsdt
@GUID("d19bdb43-405b-4a7c-a791-c89110c33165")
interface ITSDT : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2psiparser/nf-mpeg2psiparser-itsdt-initialize
    HRESULT Initialize(ISectionList pSectionList, IMpeg2Data pMPEGData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2psiparser/nf-mpeg2psiparser-itsdt-getversionnumber
    HRESULT GetVersionNumber(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2psiparser/nf-mpeg2psiparser-itsdt-getcountoftabledescriptors
    HRESULT GetCountOfTableDescriptors(uint* pdwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2psiparser/nf-mpeg2psiparser-itsdt-gettabledescriptorbyindex
    HRESULT GetTableDescriptorByIndex(uint dwIndex, IGenericDescriptor* ppDescriptor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2psiparser/nf-mpeg2psiparser-itsdt-gettabledescriptorbytag
    HRESULT GetTableDescriptorByTag(ubyte bTag, uint* pdwCookie, IGenericDescriptor* ppDescriptor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2psiparser/nf-mpeg2psiparser-itsdt-registerfornexttable
    HRESULT RegisterForNextTable(HANDLE hNextTableAvailable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2psiparser/nf-mpeg2psiparser-itsdt-getnexttable
    HRESULT GetNextTable(ITSDT* ppTSDT);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2psiparser/nf-mpeg2psiparser-itsdt-registerforwhencurrent
    HRESULT RegisterForWhenCurrent(HANDLE hNextTableIsCurrent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2psiparser/nf-mpeg2psiparser-itsdt-convertnexttocurrent
    HRESULT ConvertNextToCurrent();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2psiparser/nn-mpeg2psiparser-ipsitables
@GUID("919f24c5-7b14-42ac-a4b0-2ae08daf00ac")
interface IPSITables : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mpeg2psiparser/nf-mpeg2psiparser-ipsitables-gettable
    HRESULT GetTable(uint dwTSID, uint dwTID_PID, uint dwHashedVer, uint dwPara4, IUnknown* ppIUnknown);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nn-atscpsipparser-iatscpsipparser
@GUID("b2c98995-5eb2-4fb1-b406-f3e8e2026a9a")
interface IAtscPsipParser : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatscpsipparser-initialize
    HRESULT Initialize(IUnknown punkMpeg2Data);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatscpsipparser-getpat
    HRESULT GetPAT(IPAT* ppPAT);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatscpsipparser-getcat
    HRESULT GetCAT(uint dwTimeout, ICAT* ppCAT);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatscpsipparser-getpmt
    HRESULT GetPMT(ushort pid, ushort* pwProgramNumber, IPMT* ppPMT);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatscpsipparser-gettsdt
    HRESULT GetTSDT(ITSDT* ppTSDT);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatscpsipparser-getmgt
    HRESULT GetMGT(IATSC_MGT* ppMGT);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatscpsipparser-getvct
    HRESULT GetVCT(ubyte tableId, BOOL fGetNextTable, IATSC_VCT* ppVCT);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatscpsipparser-geteit
    HRESULT GetEIT(ushort pid, ushort* pwSourceId, uint dwTimeout, IATSC_EIT* ppEIT);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatscpsipparser-getett
    HRESULT GetETT(ushort pid, ushort* wSourceId, ushort* pwEventId, IATSC_ETT* ppETT);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatscpsipparser-getstt
    HRESULT GetSTT(IATSC_STT* ppSTT);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatscpsipparser-geteas
    HRESULT GetEAS(ushort pid, ISCTE_EAS* ppEAS);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nn-atscpsipparser-iatsc_mgt
@GUID("8877dabd-c137-4073-97e3-779407a5d87a")
interface IATSC_MGT : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsc_mgt-initialize
    HRESULT Initialize(ISectionList pSectionList, IMpeg2Data pMPEGData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsc_mgt-getversionnumber
    HRESULT GetVersionNumber(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsc_mgt-getprotocolversion
    HRESULT GetProtocolVersion(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsc_mgt-getcountofrecords
    HRESULT GetCountOfRecords(uint* pdwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsc_mgt-getrecordtype
    HRESULT GetRecordType(uint dwRecordIndex, ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsc_mgt-getrecordtypepid
    HRESULT GetRecordTypePid(uint dwRecordIndex, ushort* ppidVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsc_mgt-getrecordversionnumber
    HRESULT GetRecordVersionNumber(uint dwRecordIndex, ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsc_mgt-getrecordcountofdescriptors
    HRESULT GetRecordCountOfDescriptors(uint dwRecordIndex, uint* pdwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsc_mgt-getrecorddescriptorbyindex
    HRESULT GetRecordDescriptorByIndex(uint dwRecordIndex, uint dwIndex, IGenericDescriptor* ppDescriptor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsc_mgt-getrecorddescriptorbytag
    HRESULT GetRecordDescriptorByTag(uint dwRecordIndex, ubyte bTag, uint* pdwCookie, 
                                     IGenericDescriptor* ppDescriptor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsc_mgt-getcountoftabledescriptors
    HRESULT GetCountOfTableDescriptors(uint* pdwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsc_mgt-gettabledescriptorbyindex
    HRESULT GetTableDescriptorByIndex(uint dwIndex, IGenericDescriptor* ppDescriptor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsc_mgt-gettabledescriptorbytag
    HRESULT GetTableDescriptorByTag(ubyte bTag, uint* pdwCookie, IGenericDescriptor* ppDescriptor);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nn-atscpsipparser-iatsc_vct
@GUID("26879a18-32f9-46c6-91f0-fb6479270e8c")
interface IATSC_VCT : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsc_vct-initialize
    HRESULT Initialize(ISectionList pSectionList, IMpeg2Data pMPEGData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsc_vct-getversionnumber
    HRESULT GetVersionNumber(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsc_vct-gettransportstreamid
    HRESULT GetTransportStreamId(ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsc_vct-getprotocolversion
    HRESULT GetProtocolVersion(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsc_vct-getcountofrecords
    HRESULT GetCountOfRecords(uint* pdwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsc_vct-getrecordname
    HRESULT GetRecordName(uint dwRecordIndex, PWSTR* pwsName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsc_vct-getrecordmajorchannelnumber
    HRESULT GetRecordMajorChannelNumber(uint dwRecordIndex, ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsc_vct-getrecordminorchannelnumber
    HRESULT GetRecordMinorChannelNumber(uint dwRecordIndex, ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsc_vct-getrecordmodulationmode
    HRESULT GetRecordModulationMode(uint dwRecordIndex, ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsc_vct-getrecordcarrierfrequency
    HRESULT GetRecordCarrierFrequency(uint dwRecordIndex, uint* pdwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsc_vct-getrecordtransportstreamid
    HRESULT GetRecordTransportStreamId(uint dwRecordIndex, ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsc_vct-getrecordprogramnumber
    HRESULT GetRecordProgramNumber(uint dwRecordIndex, ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsc_vct-getrecordetmlocation
    HRESULT GetRecordEtmLocation(uint dwRecordIndex, ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsc_vct-getrecordisaccesscontrolledbitset
    HRESULT GetRecordIsAccessControlledBitSet(uint dwRecordIndex, BOOL* pfVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsc_vct-getrecordishiddenbitset
    HRESULT GetRecordIsHiddenBitSet(uint dwRecordIndex, BOOL* pfVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsc_vct-getrecordispathselectbitset
    HRESULT GetRecordIsPathSelectBitSet(uint dwRecordIndex, BOOL* pfVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsc_vct-getrecordisoutofbandbitset
    HRESULT GetRecordIsOutOfBandBitSet(uint dwRecordIndex, BOOL* pfVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsc_vct-getrecordishideguidebitset
    HRESULT GetRecordIsHideGuideBitSet(uint dwRecordIndex, BOOL* pfVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsc_vct-getrecordservicetype
    HRESULT GetRecordServiceType(uint dwRecordIndex, ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsc_vct-getrecordsourceid
    HRESULT GetRecordSourceId(uint dwRecordIndex, ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsc_vct-getrecordcountofdescriptors
    HRESULT GetRecordCountOfDescriptors(uint dwRecordIndex, uint* pdwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsc_vct-getrecorddescriptorbyindex
    HRESULT GetRecordDescriptorByIndex(uint dwRecordIndex, uint dwIndex, IGenericDescriptor* ppDescriptor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsc_vct-getrecorddescriptorbytag
    HRESULT GetRecordDescriptorByTag(uint dwRecordIndex, ubyte bTag, uint* pdwCookie, 
                                     IGenericDescriptor* ppDescriptor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsc_vct-getcountoftabledescriptors
    HRESULT GetCountOfTableDescriptors(uint* pdwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsc_vct-gettabledescriptorbyindex
    HRESULT GetTableDescriptorByIndex(uint dwIndex, IGenericDescriptor* ppDescriptor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsc_vct-gettabledescriptorbytag
    HRESULT GetTableDescriptorByTag(ubyte bTag, uint* pdwCookie, IGenericDescriptor* ppDescriptor);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nn-atscpsipparser-iatsc_eit
@GUID("d7c212d7-76a2-4b4b-aa56-846879a80096")
interface IATSC_EIT : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsc_eit-initialize
    HRESULT Initialize(ISectionList pSectionList, IMpeg2Data pMPEGData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsc_eit-getversionnumber
    HRESULT GetVersionNumber(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsc_eit-getsourceid
    HRESULT GetSourceId(ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsc_eit-getprotocolversion
    HRESULT GetProtocolVersion(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsc_eit-getcountofrecords
    HRESULT GetCountOfRecords(uint* pdwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsc_eit-getrecordeventid
    HRESULT GetRecordEventId(uint dwRecordIndex, ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsc_eit-getrecordstarttime
    HRESULT GetRecordStartTime(uint dwRecordIndex, MPEG_DATE_AND_TIME* pmdtVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsc_eit-getrecordetmlocation
    HRESULT GetRecordEtmLocation(uint dwRecordIndex, ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsc_eit-getrecordduration
    HRESULT GetRecordDuration(uint dwRecordIndex, MPEG_TIME* pmdVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsc_eit-getrecordtitletext
    HRESULT GetRecordTitleText(uint dwRecordIndex, uint* pdwLength, ubyte** ppText);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsc_eit-getrecordcountofdescriptors
    HRESULT GetRecordCountOfDescriptors(uint dwRecordIndex, uint* pdwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsc_eit-getrecorddescriptorbyindex
    HRESULT GetRecordDescriptorByIndex(uint dwRecordIndex, uint dwIndex, IGenericDescriptor* ppDescriptor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsc_eit-getrecorddescriptorbytag
    HRESULT GetRecordDescriptorByTag(uint dwRecordIndex, ubyte bTag, uint* pdwCookie, 
                                     IGenericDescriptor* ppDescriptor);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nn-atscpsipparser-iatsc_ett
@GUID("5a142cc9-b8cf-4a86-a040-e9cadf3ef3e7")
interface IATSC_ETT : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsc_ett-initialize
    HRESULT Initialize(ISectionList pSectionList, IMpeg2Data pMPEGData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsc_ett-getversionnumber
    HRESULT GetVersionNumber(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsc_ett-getprotocolversion
    HRESULT GetProtocolVersion(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsc_ett-getetmid
    HRESULT GetEtmId(uint* pdwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsc_ett-getextendedmessagetext
    HRESULT GetExtendedMessageText(uint* pdwLength, ubyte** ppText);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nn-atscpsipparser-iatsc_stt
@GUID("6bf42423-217d-4d6f-81e1-3a7b360ec896")
interface IATSC_STT : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsc_stt-initialize
    HRESULT Initialize(ISectionList pSectionList, IMpeg2Data pMPEGData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsc_stt-getprotocolversion
    HRESULT GetProtocolVersion(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsc_stt-getsystemtime
    HRESULT GetSystemTime(MPEG_DATE_AND_TIME* pmdtSystemTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsc_stt-getgpsutcoffset
    HRESULT GetGpsUtcOffset(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsc_stt-getdaylightsavings
    HRESULT GetDaylightSavings(ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsc_stt-getcountoftabledescriptors
    HRESULT GetCountOfTableDescriptors(uint* pdwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsc_stt-gettabledescriptorbyindex
    HRESULT GetTableDescriptorByIndex(uint dwIndex, IGenericDescriptor* ppDescriptor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsc_stt-gettabledescriptorbytag
    HRESULT GetTableDescriptorByTag(ubyte bTag, uint* pdwCookie, IGenericDescriptor* ppDescriptor);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nn-atscpsipparser-iscte_eas
@GUID("1ff544d6-161d-4fae-9faa-4f9f492ae999")
interface ISCTE_EAS : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iscte_eas-initialize
    HRESULT Initialize(ISectionList pSectionList, IMpeg2Data pMPEGData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iscte_eas-getversionnumber
    HRESULT GetVersionNumber(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iscte_eas-getsequencynumber
    HRESULT GetSequencyNumber(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iscte_eas-getprotocolversion
    HRESULT GetProtocolVersion(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iscte_eas-geteaseventid
    HRESULT GetEASEventID(ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iscte_eas-getoriginatorcode
    HRESULT GetOriginatorCode(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iscte_eas-geteaseventcodelen
    HRESULT GetEASEventCodeLen(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iscte_eas-geteaseventcode
    HRESULT GetEASEventCode(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iscte_eas-getrawnatureofactivationtextlen
    HRESULT GetRawNatureOfActivationTextLen(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iscte_eas-getrawnatureofactivationtext
    HRESULT GetRawNatureOfActivationText(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iscte_eas-getnatureofactivationtext
    HRESULT GetNatureOfActivationText(BSTR bstrIS0639code, BSTR* pbstrString);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iscte_eas-gettimeremaining
    HRESULT GetTimeRemaining(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iscte_eas-getstarttime
    HRESULT GetStartTime(uint* pdwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iscte_eas-getduration
    HRESULT GetDuration(ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iscte_eas-getalertpriority
    HRESULT GetAlertPriority(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iscte_eas-getdetailsoobsourceid
    HRESULT GetDetailsOOBSourceID(ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iscte_eas-getdetailsmajor
    HRESULT GetDetailsMajor(ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iscte_eas-getdetailsminor
    HRESULT GetDetailsMinor(ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iscte_eas-getdetailsaudiooobsourceid
    HRESULT GetDetailsAudioOOBSourceID(ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iscte_eas-getalerttext
    HRESULT GetAlertText(BSTR bstrIS0639code, BSTR* pbstrString);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iscte_eas-getrawalerttextlen
    HRESULT GetRawAlertTextLen(ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iscte_eas-getrawalerttext
    HRESULT GetRawAlertText(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iscte_eas-getlocationcount
    HRESULT GetLocationCount(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iscte_eas-getlocationcodes
    HRESULT GetLocationCodes(ubyte bIndex, ubyte* pbState, ubyte* pbCountySubdivision, ushort* pwCounty);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iscte_eas-getexceptioncount
    HRESULT GetExceptionCount(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iscte_eas-getexceptionservice
    HRESULT GetExceptionService(ubyte bIndex, ubyte* pbIBRef, ushort* pwFirst, ushort* pwSecond);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iscte_eas-getcountoftabledescriptors
    HRESULT GetCountOfTableDescriptors(uint* pdwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iscte_eas-gettabledescriptorbyindex
    HRESULT GetTableDescriptorByIndex(uint dwIndex, IGenericDescriptor* ppDescriptor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iscte_eas-gettabledescriptorbytag
    HRESULT GetTableDescriptorByTag(ubyte bTag, uint* pdwCookie, IGenericDescriptor* ppDescriptor);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nn-atscpsipparser-iatsccontentadvisorydescriptor
@GUID("ff76e60c-0283-43ea-ba32-b422238547ee")
interface IAtscContentAdvisoryDescriptor : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsccontentadvisorydescriptor-gettag
    HRESULT GetTag(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsccontentadvisorydescriptor-getlength
    HRESULT GetLength(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsccontentadvisorydescriptor-getratingregioncount
    HRESULT GetRatingRegionCount(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsccontentadvisorydescriptor-getrecordratingregion
    HRESULT GetRecordRatingRegion(ubyte bIndex, ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsccontentadvisorydescriptor-getrecordrateddimensions
    HRESULT GetRecordRatedDimensions(ubyte bIndex, ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsccontentadvisorydescriptor-getrecordratingdimension
    HRESULT GetRecordRatingDimension(ubyte bIndexOuter, ubyte bIndexInner, ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsccontentadvisorydescriptor-getrecordratingvalue
    HRESULT GetRecordRatingValue(ubyte bIndexOuter, ubyte bIndexInner, ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iatsccontentadvisorydescriptor-getrecordratingdescriptiontext
    HRESULT GetRecordRatingDescriptionText(ubyte bIndex, ubyte* pbLength, ubyte** ppText);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nn-atscpsipparser-icaptionservicedescriptor
@GUID("40834007-6834-46f0-bd45-d5f6a6be258c")
interface ICaptionServiceDescriptor : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-icaptionservicedescriptor-getnumberofservices
    HRESULT GetNumberOfServices(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-icaptionservicedescriptor-getlanguagecode
    HRESULT GetLanguageCode(ubyte bIndex, ubyte* LangCode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-icaptionservicedescriptor-getcaptionservicenumber
    HRESULT GetCaptionServiceNumber(ubyte bIndex, ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-icaptionservicedescriptor-getcctype
    HRESULT GetCCType(ubyte bIndex, ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-icaptionservicedescriptor-geteasyreader
    HRESULT GetEasyReader(ubyte bIndex, ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-icaptionservicedescriptor-getwideaspectratio
    HRESULT GetWideAspectRatio(ubyte bIndex, ubyte* pbVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nn-atscpsipparser-iservicelocationdescriptor
@GUID("58c3c827-9d91-4215-bff3-820a49f0904c")
interface IServiceLocationDescriptor : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iservicelocationdescriptor-getpcr_pid
    HRESULT GetPCR_PID(ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iservicelocationdescriptor-getnumberofelements
    HRESULT GetNumberOfElements(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iservicelocationdescriptor-getelementstreamtype
    HRESULT GetElementStreamType(ubyte bIndex, ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iservicelocationdescriptor-getelementpid
    HRESULT GetElementPID(ubyte bIndex, ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/atscpsipparser/nf-atscpsipparser-iservicelocationdescriptor-getelementlanguagecode
    HRESULT GetElementLanguageCode(ubyte bIndex, ubyte* LangCode);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsattrib/nn-dsattrib-iattributeset
@GUID("583ec3cc-4960-4857-982b-41a33ea0a006")
interface IAttributeSet : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsattrib/nf-dsattrib-iattributeset-setattrib
    HRESULT SetAttrib(GUID guidAttribute, ubyte* pbAttribute, uint dwAttributeLength);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsattrib/nn-dsattrib-iattributeget
@GUID("52dbd1ec-e48f-4528-9232-f442a68f0ae1")
interface IAttributeGet : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsattrib/nf-dsattrib-iattributeget-getcount
    HRESULT GetCount(int* plCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsattrib/nf-dsattrib-iattributeget-getattribindexed
    HRESULT GetAttribIndexed(int lIndex, GUID* pguidAttribute, ubyte* pbAttribute, uint* pdwAttributeLength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsattrib/nf-dsattrib-iattributeget-getattrib
    HRESULT GetAttrib(GUID guidAttribute, ubyte* pbAttribute, uint* pdwAttributeLength);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nn-dvbsiparser-idvbsiparser
@GUID("b758a7bd-14dc-449d-b828-35909acb3b1e")
interface IDvbSiParser : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbsiparser-initialize
    HRESULT Initialize(IUnknown punkMpeg2Data);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbsiparser-getpat
    HRESULT GetPAT(IPAT* ppPAT);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbsiparser-getcat
    HRESULT GetCAT(uint dwTimeout, ICAT* ppCAT);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbsiparser-getpmt
    HRESULT GetPMT(ushort pid, ushort* pwProgramNumber, IPMT* ppPMT);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbsiparser-gettsdt
    HRESULT GetTSDT(ITSDT* ppTSDT);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbsiparser-getnit
    HRESULT GetNIT(ubyte tableId, ushort* pwNetworkId, IDVB_NIT* ppNIT);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbsiparser-getsdt
    HRESULT GetSDT(ubyte tableId, ushort* pwTransportStreamId, IDVB_SDT* ppSDT);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbsiparser-geteit
    HRESULT GetEIT(ubyte tableId, ushort* pwServiceId, IDVB_EIT* ppEIT);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbsiparser-getbat
    HRESULT GetBAT(ushort* pwBouquetId, IDVB_BAT* ppBAT);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbsiparser-getrst
    HRESULT GetRST(uint dwTimeout, IDVB_RST* ppRST);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbsiparser-getst
    HRESULT GetST(ushort pid, uint dwTimeout, IDVB_ST* ppST);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbsiparser-gettdt
    HRESULT GetTDT(IDVB_TDT* ppTDT);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbsiparser-gettot
    HRESULT GetTOT(IDVB_TOT* ppTOT);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbsiparser-getdit
    HRESULT GetDIT(uint dwTimeout, IDVB_DIT* ppDIT);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbsiparser-getsit
    HRESULT GetSIT(uint dwTimeout, IDVB_SIT* ppSIT);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nn-dvbsiparser-idvbsiparser2
@GUID("0ac5525f-f816-42f4-93ba-4c0f32f46e54")
interface IDvbSiParser2 : IDvbSiParser
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbsiparser2-geteit2
    HRESULT GetEIT2(ubyte tableId, ushort* pwServiceId, ubyte* pbSegment, IDVB_EIT2* ppEIT);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nn-dvbsiparser-iisdbsiparser2
@GUID("900e4bb7-18cd-453f-98be-3be6aa211772")
interface IIsdbSiParser2 : IDvbSiParser2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbsiparser2-getsdt
    HRESULT GetSDT(ubyte tableId, ushort* pwTransportStreamId, IISDB_SDT* ppSDT);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbsiparser2-getbit
    HRESULT GetBIT(ubyte tableId, ushort* pwOriginalNetworkId, IISDB_BIT* ppBIT);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbsiparser2-getnbit
    HRESULT GetNBIT(ubyte tableId, ushort* pwOriginalNetworkId, IISDB_NBIT* ppNBIT);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbsiparser2-getldt
    HRESULT GetLDT(ubyte tableId, ushort* pwOriginalServiceId, IISDB_LDT* ppLDT);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbsiparser2-getsdtt
    HRESULT GetSDTT(ubyte tableId, ushort* pwTableIdExt, IISDB_SDTT* ppSDTT);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbsiparser2-getcdt
    HRESULT GetCDT(ubyte tableId, ubyte bSectionNumber, ushort* pwDownloadDataId, IISDB_CDT* ppCDT);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbsiparser2-getemm
    HRESULT GetEMM(ushort pid, ushort wTableIdExt, IISDB_EMM* ppEMM);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nn-dvbsiparser-idvb_nit
@GUID("c64935f4-29e4-4e22-911a-63f7f55cb097")
interface IDVB_NIT : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_nit-initialize
    HRESULT Initialize(ISectionList pSectionList, IMpeg2Data pMPEGData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_nit-getversionnumber
    HRESULT GetVersionNumber(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_nit-getnetworkid
    HRESULT GetNetworkId(ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_nit-getcountoftabledescriptors
    HRESULT GetCountOfTableDescriptors(uint* pdwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_nit-gettabledescriptorbyindex
    HRESULT GetTableDescriptorByIndex(uint dwIndex, IGenericDescriptor* ppDescriptor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_nit-gettabledescriptorbytag
    HRESULT GetTableDescriptorByTag(ubyte bTag, uint* pdwCookie, IGenericDescriptor* ppDescriptor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_nit-getcountofrecords
    HRESULT GetCountOfRecords(uint* pdwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_nit-getrecordtransportstreamid
    HRESULT GetRecordTransportStreamId(uint dwRecordIndex, ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_nit-getrecordoriginalnetworkid
    HRESULT GetRecordOriginalNetworkId(uint dwRecordIndex, ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_nit-getrecordcountofdescriptors
    HRESULT GetRecordCountOfDescriptors(uint dwRecordIndex, uint* pdwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_nit-getrecorddescriptorbyindex
    HRESULT GetRecordDescriptorByIndex(uint dwRecordIndex, uint dwIndex, IGenericDescriptor* ppDescriptor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_nit-getrecorddescriptorbytag
    HRESULT GetRecordDescriptorByTag(uint dwRecordIndex, ubyte bTag, uint* pdwCookie, 
                                     IGenericDescriptor* ppDescriptor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_nit-registerfornexttable
    HRESULT RegisterForNextTable(HANDLE hNextTableAvailable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_nit-getnexttable
    HRESULT GetNextTable(IDVB_NIT* ppNIT);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_nit-registerforwhencurrent
    HRESULT RegisterForWhenCurrent(HANDLE hNextTableIsCurrent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_nit-convertnexttocurrent
    HRESULT ConvertNextToCurrent();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_nit-getversionhash
    HRESULT GetVersionHash(uint* pdwVersionHash);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nn-dvbsiparser-idvb_sdt
@GUID("02cad8d3-fe43-48e2-90bd-450ed9a8a5fd")
interface IDVB_SDT : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_sdt-initialize
    HRESULT Initialize(ISectionList pSectionList, IMpeg2Data pMPEGData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_sdt-getversionnumber
    HRESULT GetVersionNumber(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_sdt-gettransportstreamid
    HRESULT GetTransportStreamId(ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_sdt-getoriginalnetworkid
    HRESULT GetOriginalNetworkId(ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_sdt-getcountofrecords
    HRESULT GetCountOfRecords(uint* pdwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_sdt-getrecordserviceid
    HRESULT GetRecordServiceId(uint dwRecordIndex, ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_sdt-getrecordeitscheduleflag
    HRESULT GetRecordEITScheduleFlag(uint dwRecordIndex, BOOL* pfVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_sdt-getrecordeitpresentfollowingflag
    HRESULT GetRecordEITPresentFollowingFlag(uint dwRecordIndex, BOOL* pfVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_sdt-getrecordrunningstatus
    HRESULT GetRecordRunningStatus(uint dwRecordIndex, ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_sdt-getrecordfreecamode
    HRESULT GetRecordFreeCAMode(uint dwRecordIndex, BOOL* pfVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_sdt-getrecordcountofdescriptors
    HRESULT GetRecordCountOfDescriptors(uint dwRecordIndex, uint* pdwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_sdt-getrecorddescriptorbyindex
    HRESULT GetRecordDescriptorByIndex(uint dwRecordIndex, uint dwIndex, IGenericDescriptor* ppDescriptor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_sdt-getrecorddescriptorbytag
    HRESULT GetRecordDescriptorByTag(uint dwRecordIndex, ubyte bTag, uint* pdwCookie, 
                                     IGenericDescriptor* ppDescriptor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_sdt-registerfornexttable
    HRESULT RegisterForNextTable(HANDLE hNextTableAvailable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_sdt-getnexttable
    HRESULT GetNextTable(IDVB_SDT* ppSDT);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_sdt-registerforwhencurrent
    HRESULT RegisterForWhenCurrent(HANDLE hNextTableIsCurrent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_sdt-convertnexttocurrent
    HRESULT ConvertNextToCurrent();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_sdt-getversionhash
    HRESULT GetVersionHash(uint* pdwVersionHash);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nn-dvbsiparser-iisdb_sdt
@GUID("3f3dc9a2-bb32-4fb9-ae9e-d856848927a3")
interface IISDB_SDT : IDVB_SDT
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_sdt-getrecordeituserdefinedflags
    HRESULT GetRecordEITUserDefinedFlags(uint dwRecordIndex, ubyte* pbVal);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nn-dvbsiparser-idvb_eit
@GUID("442db029-02cb-4495-8b92-1c13375bce99")
interface IDVB_EIT : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_eit-initialize
    HRESULT Initialize(ISectionList pSectionList, IMpeg2Data pMPEGData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_eit-getversionnumber
    HRESULT GetVersionNumber(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_eit-getserviceid
    HRESULT GetServiceId(ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_eit-gettransportstreamid
    HRESULT GetTransportStreamId(ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_eit-getoriginalnetworkid
    HRESULT GetOriginalNetworkId(ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_eit-getsegmentlastsectionnumber
    HRESULT GetSegmentLastSectionNumber(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_eit-getlasttableid
    HRESULT GetLastTableId(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_eit-getcountofrecords
    HRESULT GetCountOfRecords(uint* pdwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_eit-getrecordeventid
    HRESULT GetRecordEventId(uint dwRecordIndex, ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_eit-getrecordstarttime
    HRESULT GetRecordStartTime(uint dwRecordIndex, MPEG_DATE_AND_TIME* pmdtVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_eit-getrecordduration
    HRESULT GetRecordDuration(uint dwRecordIndex, MPEG_TIME* pmdVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_eit-getrecordrunningstatus
    HRESULT GetRecordRunningStatus(uint dwRecordIndex, ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_eit-getrecordfreecamode
    HRESULT GetRecordFreeCAMode(uint dwRecordIndex, BOOL* pfVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_eit-getrecordcountofdescriptors
    HRESULT GetRecordCountOfDescriptors(uint dwRecordIndex, uint* pdwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_eit-getrecorddescriptorbyindex
    HRESULT GetRecordDescriptorByIndex(uint dwRecordIndex, uint dwIndex, IGenericDescriptor* ppDescriptor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_eit-getrecorddescriptorbytag
    HRESULT GetRecordDescriptorByTag(uint dwRecordIndex, ubyte bTag, uint* pdwCookie, 
                                     IGenericDescriptor* ppDescriptor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_eit-registerfornexttable
    HRESULT RegisterForNextTable(HANDLE hNextTableAvailable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_eit-getnexttable
    HRESULT GetNextTable(IDVB_EIT* ppEIT);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_eit-registerforwhencurrent
    HRESULT RegisterForWhenCurrent(HANDLE hNextTableIsCurrent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_eit-convertnexttocurrent
    HRESULT ConvertNextToCurrent();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_eit-getversionhash
    HRESULT GetVersionHash(uint* pdwVersionHash);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nn-dvbsiparser-idvb_eit2
@GUID("61a389e0-9b9e-4ba0-aeea-5ddd159820ea")
interface IDVB_EIT2 : IDVB_EIT
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_eit2-getsegmentinfo
    HRESULT GetSegmentInfo(ubyte* pbTid, ubyte* pbSegment);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_eit2-getrecordsection
    HRESULT GetRecordSection(uint dwRecordIndex, ubyte* pbVal);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nn-dvbsiparser-idvb_bat
@GUID("ece9bb0c-43b6-4558-a0ec-1812c34cd6ca")
interface IDVB_BAT : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_bat-initialize
    HRESULT Initialize(ISectionList pSectionList, IMpeg2Data pMPEGData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_bat-getversionnumber
    HRESULT GetVersionNumber(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_bat-getbouquetid
    HRESULT GetBouquetId(ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_bat-getcountoftabledescriptors
    HRESULT GetCountOfTableDescriptors(uint* pdwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_bat-gettabledescriptorbyindex
    HRESULT GetTableDescriptorByIndex(uint dwIndex, IGenericDescriptor* ppDescriptor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_bat-gettabledescriptorbytag
    HRESULT GetTableDescriptorByTag(ubyte bTag, uint* pdwCookie, IGenericDescriptor* ppDescriptor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_bat-getcountofrecords
    HRESULT GetCountOfRecords(uint* pdwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_bat-getrecordtransportstreamid
    HRESULT GetRecordTransportStreamId(uint dwRecordIndex, ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_bat-getrecordoriginalnetworkid
    HRESULT GetRecordOriginalNetworkId(uint dwRecordIndex, ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_bat-getrecordcountofdescriptors
    HRESULT GetRecordCountOfDescriptors(uint dwRecordIndex, uint* pdwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_bat-getrecorddescriptorbyindex
    HRESULT GetRecordDescriptorByIndex(uint dwRecordIndex, uint dwIndex, IGenericDescriptor* ppDescriptor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_bat-getrecorddescriptorbytag
    HRESULT GetRecordDescriptorByTag(uint dwRecordIndex, ubyte bTag, uint* pdwCookie, 
                                     IGenericDescriptor* ppDescriptor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_bat-registerfornexttable
    HRESULT RegisterForNextTable(HANDLE hNextTableAvailable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_bat-getnexttable
    HRESULT GetNextTable(IDVB_BAT* ppBAT);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_bat-registerforwhencurrent
    HRESULT RegisterForWhenCurrent(HANDLE hNextTableIsCurrent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_bat-convertnexttocurrent
    HRESULT ConvertNextToCurrent();
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nn-dvbsiparser-idvb_rst
@GUID("f47dcd04-1e23-4fb7-9f96-b40eead10b2b")
interface IDVB_RST : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_rst-initialize
    HRESULT Initialize(ISectionList pSectionList);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_rst-getcountofrecords
    HRESULT GetCountOfRecords(uint* pdwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_rst-getrecordtransportstreamid
    HRESULT GetRecordTransportStreamId(uint dwRecordIndex, ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_rst-getrecordoriginalnetworkid
    HRESULT GetRecordOriginalNetworkId(uint dwRecordIndex, ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_rst-getrecordserviceid
    HRESULT GetRecordServiceId(uint dwRecordIndex, ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_rst-getrecordeventid
    HRESULT GetRecordEventId(uint dwRecordIndex, ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_rst-getrecordrunningstatus
    HRESULT GetRecordRunningStatus(uint dwRecordIndex, ubyte* pbVal);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nn-dvbsiparser-idvb_st
@GUID("4d5b9f23-2a02-45de-bcda-5d5dbfbfbe62")
interface IDVB_ST : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_st-initialize
    HRESULT Initialize(ISectionList pSectionList);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_st-getdatalength
    HRESULT GetDataLength(ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_st-getdata
    HRESULT GetData(ubyte** ppData);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nn-dvbsiparser-idvb_tdt
@GUID("0780dc7d-d55c-4aef-97e6-6b75906e2796")
interface IDVB_TDT : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_tdt-initialize
    HRESULT Initialize(ISectionList pSectionList);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_tdt-getutctime
    HRESULT GetUTCTime(MPEG_DATE_AND_TIME* pmdtVal);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nn-dvbsiparser-idvb_tot
@GUID("83295d6a-faba-4ee1-9b15-8067696910ae")
interface IDVB_TOT : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_tot-initialize
    HRESULT Initialize(ISectionList pSectionList);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_tot-getutctime
    HRESULT GetUTCTime(MPEG_DATE_AND_TIME* pmdtVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_tot-getcountoftabledescriptors
    HRESULT GetCountOfTableDescriptors(uint* pdwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_tot-gettabledescriptorbyindex
    HRESULT GetTableDescriptorByIndex(uint dwIndex, IGenericDescriptor* ppDescriptor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_tot-gettabledescriptorbytag
    HRESULT GetTableDescriptorByTag(ubyte bTag, uint* pdwCookie, IGenericDescriptor* ppDescriptor);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nn-dvbsiparser-idvb_dit
@GUID("91bffdf9-9432-410f-86ef-1c228ed0ad70")
interface IDVB_DIT : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_dit-initialize
    HRESULT Initialize(ISectionList pSectionList);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_dit-gettransitionflag
    HRESULT GetTransitionFlag(BOOL* pfVal);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nn-dvbsiparser-idvb_sit
@GUID("68cdce53-8bea-45c2-9d9d-acf575a089b5")
interface IDVB_SIT : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_sit-initialize
    HRESULT Initialize(ISectionList pSectionList, IMpeg2Data pMPEGData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_sit-getversionnumber
    HRESULT GetVersionNumber(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_sit-getcountoftabledescriptors
    HRESULT GetCountOfTableDescriptors(uint* pdwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_sit-gettabledescriptorbyindex
    HRESULT GetTableDescriptorByIndex(uint dwIndex, IGenericDescriptor* ppDescriptor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_sit-gettabledescriptorbytag
    HRESULT GetTableDescriptorByTag(ubyte bTag, uint* pdwCookie, IGenericDescriptor* ppDescriptor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_sit-getcountofrecords
    HRESULT GetCountOfRecords(uint* pdwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_sit-getrecordserviceid
    HRESULT GetRecordServiceId(uint dwRecordIndex, ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_sit-getrecordrunningstatus
    HRESULT GetRecordRunningStatus(uint dwRecordIndex, ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_sit-getrecordcountofdescriptors
    HRESULT GetRecordCountOfDescriptors(uint dwRecordIndex, uint* pdwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_sit-getrecorddescriptorbyindex
    HRESULT GetRecordDescriptorByIndex(uint dwRecordIndex, uint dwIndex, IGenericDescriptor* ppDescriptor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_sit-getrecorddescriptorbytag
    HRESULT GetRecordDescriptorByTag(uint dwRecordIndex, ubyte bTag, uint* pdwCookie, 
                                     IGenericDescriptor* ppDescriptor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_sit-registerfornexttable
    HRESULT RegisterForNextTable(HANDLE hNextTableAvailable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_sit-getnexttable
    HRESULT GetNextTable(uint dwTimeout, IDVB_SIT* ppSIT);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_sit-registerforwhencurrent
    HRESULT RegisterForWhenCurrent(HANDLE hNextTableIsCurrent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvb_sit-convertnexttocurrent
    HRESULT ConvertNextToCurrent();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nn-dvbsiparser-iisdb_bit
@GUID("537cd71e-0e46-4173-9001-ba043f3e49e2")
interface IISDB_BIT : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_bit-initialize
    HRESULT Initialize(ISectionList pSectionList, IMpeg2Data pMPEGData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_bit-getversionnumber
    HRESULT GetVersionNumber(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_bit-getoriginalnetworkid
    HRESULT GetOriginalNetworkId(ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_bit-getbroadcastviewpropriety
    HRESULT GetBroadcastViewPropriety(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_bit-getcountoftabledescriptors
    HRESULT GetCountOfTableDescriptors(uint* pdwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_bit-gettabledescriptorbyindex
    HRESULT GetTableDescriptorByIndex(uint dwIndex, IGenericDescriptor* ppDescriptor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_bit-gettabledescriptorbytag
    HRESULT GetTableDescriptorByTag(ubyte bTag, uint* pdwCookie, IGenericDescriptor* ppDescriptor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_bit-getcountofrecords
    HRESULT GetCountOfRecords(uint* pdwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_bit-getrecordbroadcasterid
    HRESULT GetRecordBroadcasterId(uint dwRecordIndex, ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_bit-getrecordcountofdescriptors
    HRESULT GetRecordCountOfDescriptors(uint dwRecordIndex, uint* pdwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_bit-getrecorddescriptorbyindex
    HRESULT GetRecordDescriptorByIndex(uint dwRecordIndex, uint dwIndex, IGenericDescriptor* ppDescriptor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_bit-getrecorddescriptorbytag
    HRESULT GetRecordDescriptorByTag(uint dwRecordIndex, ubyte bTag, uint* pdwCookie, 
                                     IGenericDescriptor* ppDescriptor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_bit-getversionhash
    HRESULT GetVersionHash(uint* pdwVersionHash);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nn-dvbsiparser-iisdb_nbit
@GUID("1b1863ef-08f1-40b7-a559-3b1eff8cafa6")
interface IISDB_NBIT : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_nbit-initialize
    HRESULT Initialize(ISectionList pSectionList, IMpeg2Data pMPEGData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_nbit-getversionnumber
    HRESULT GetVersionNumber(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_nbit-getoriginalnetworkid
    HRESULT GetOriginalNetworkId(ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_nbit-getcountofrecords
    HRESULT GetCountOfRecords(uint* pdwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_nbit-getrecordinformationid
    HRESULT GetRecordInformationId(uint dwRecordIndex, ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_nbit-getrecordinformationtype
    HRESULT GetRecordInformationType(uint dwRecordIndex, ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_nbit-getrecorddescriptionbodylocation
    HRESULT GetRecordDescriptionBodyLocation(uint dwRecordIndex, ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_nbit-getrecordmessagesectionnumber
    HRESULT GetRecordMessageSectionNumber(uint dwRecordIndex, ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_nbit-getrecorduserdefined
    HRESULT GetRecordUserDefined(uint dwRecordIndex, ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_nbit-getrecordnumberofkeys
    HRESULT GetRecordNumberOfKeys(uint dwRecordIndex, ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_nbit-getrecordkeys
    HRESULT GetRecordKeys(uint dwRecordIndex, ubyte** pbKeys);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_nbit-getrecordcountofdescriptors
    HRESULT GetRecordCountOfDescriptors(uint dwRecordIndex, uint* pdwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_nbit-getrecorddescriptorbyindex
    HRESULT GetRecordDescriptorByIndex(uint dwRecordIndex, uint dwIndex, IGenericDescriptor* ppDescriptor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_nbit-getrecorddescriptorbytag
    HRESULT GetRecordDescriptorByTag(uint dwRecordIndex, ubyte bTag, uint* pdwCookie, 
                                     IGenericDescriptor* ppDescriptor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_nbit-getversionhash
    HRESULT GetVersionHash(uint* pdwVersionHash);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nn-dvbsiparser-iisdb_ldt
@GUID("141a546b-02ff-4fb9-a3a3-2f074b74a9a9")
interface IISDB_LDT : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_ldt-initialize
    HRESULT Initialize(ISectionList pSectionList, IMpeg2Data pMPEGData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_ldt-getversionnumber
    HRESULT GetVersionNumber(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_ldt-getoriginalserviceid
    HRESULT GetOriginalServiceId(ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_ldt-gettransportstreamid
    HRESULT GetTransportStreamId(ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_ldt-getoriginalnetworkid
    HRESULT GetOriginalNetworkId(ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_ldt-getcountofrecords
    HRESULT GetCountOfRecords(uint* pdwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_ldt-getrecorddescriptionid
    HRESULT GetRecordDescriptionId(uint dwRecordIndex, ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_ldt-getrecordcountofdescriptors
    HRESULT GetRecordCountOfDescriptors(uint dwRecordIndex, uint* pdwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_ldt-getrecorddescriptorbyindex
    HRESULT GetRecordDescriptorByIndex(uint dwRecordIndex, uint dwIndex, IGenericDescriptor* ppDescriptor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_ldt-getrecorddescriptorbytag
    HRESULT GetRecordDescriptorByTag(uint dwRecordIndex, ubyte bTag, uint* pdwCookie, 
                                     IGenericDescriptor* ppDescriptor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_ldt-getversionhash
    HRESULT GetVersionHash(uint* pdwVersionHash);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nn-dvbsiparser-iisdb_sdtt
@GUID("ee60ef2d-813a-4dc7-bf92-ea13dac85313")
interface IISDB_SDTT : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_sdtt-initialize
    HRESULT Initialize(ISectionList pSectionList, IMpeg2Data pMPEGData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_sdtt-getversionnumber
    HRESULT GetVersionNumber(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_sdtt-gettableidext
    HRESULT GetTableIdExt(ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_sdtt-gettransportstreamid
    HRESULT GetTransportStreamId(ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_sdtt-getoriginalnetworkid
    HRESULT GetOriginalNetworkId(ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_sdtt-getserviceid
    HRESULT GetServiceId(ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_sdtt-getcountofrecords
    HRESULT GetCountOfRecords(uint* pdwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_sdtt-getrecordgroup
    HRESULT GetRecordGroup(uint dwRecordIndex, ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_sdtt-getrecordtargetversion
    HRESULT GetRecordTargetVersion(uint dwRecordIndex, ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_sdtt-getrecordnewversion
    HRESULT GetRecordNewVersion(uint dwRecordIndex, ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_sdtt-getrecorddownloadlevel
    HRESULT GetRecordDownloadLevel(uint dwRecordIndex, ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_sdtt-getrecordversionindicator
    HRESULT GetRecordVersionIndicator(uint dwRecordIndex, ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_sdtt-getrecordscheduletimeshiftinformation
    HRESULT GetRecordScheduleTimeShiftInformation(uint dwRecordIndex, ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_sdtt-getrecordcountofschedules
    HRESULT GetRecordCountOfSchedules(uint dwRecordIndex, uint* pdwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_sdtt-getrecordstarttimebyindex
    HRESULT GetRecordStartTimeByIndex(uint dwRecordIndex, uint dwIndex, MPEG_DATE_AND_TIME* pmdtVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_sdtt-getrecorddurationbyindex
    HRESULT GetRecordDurationByIndex(uint dwRecordIndex, uint dwIndex, MPEG_TIME* pmdVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_sdtt-getrecordcountofdescriptors
    HRESULT GetRecordCountOfDescriptors(uint dwRecordIndex, uint* pdwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_sdtt-getrecorddescriptorbyindex
    HRESULT GetRecordDescriptorByIndex(uint dwRecordIndex, uint dwIndex, IGenericDescriptor* ppDescriptor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_sdtt-getrecorddescriptorbytag
    HRESULT GetRecordDescriptorByTag(uint dwRecordIndex, ubyte bTag, uint* pdwCookie, 
                                     IGenericDescriptor* ppDescriptor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_sdtt-getversionhash
    HRESULT GetVersionHash(uint* pdwVersionHash);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nn-dvbsiparser-iisdb_cdt
@GUID("25fa92c2-8b80-4787-a841-3a0e8f17984b")
interface IISDB_CDT : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_cdt-initialize
    HRESULT Initialize(ISectionList pSectionList, IMpeg2Data pMPEGData, ubyte bSectionNumber);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_cdt-getversionnumber
    HRESULT GetVersionNumber(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_cdt-getdownloaddataid
    HRESULT GetDownloadDataId(ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_cdt-getsectionnumber
    HRESULT GetSectionNumber(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_cdt-getoriginalnetworkid
    HRESULT GetOriginalNetworkId(ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_cdt-getdatatype
    HRESULT GetDataType(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_cdt-getcountoftabledescriptors
    HRESULT GetCountOfTableDescriptors(uint* pdwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_cdt-gettabledescriptorbyindex
    HRESULT GetTableDescriptorByIndex(uint dwIndex, IGenericDescriptor* ppDescriptor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_cdt-gettabledescriptorbytag
    HRESULT GetTableDescriptorByTag(ubyte bTag, uint* pdwCookie, IGenericDescriptor* ppDescriptor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_cdt-getsizeofdatamodule
    HRESULT GetSizeOfDataModule(uint* pdwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_cdt-getdatamodule
    HRESULT GetDataModule(ubyte** pbData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_cdt-getversionhash
    HRESULT GetVersionHash(uint* pdwVersionHash);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nn-dvbsiparser-iisdb_emm
@GUID("0edb556d-43ad-4938-9668-321b2ffecfd3")
interface IISDB_EMM : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_emm-initialize
    HRESULT Initialize(ISectionList pSectionList, IMpeg2Data pMPEGData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_emm-getversionnumber
    HRESULT GetVersionNumber(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_emm-gettableidextension
    HRESULT GetTableIdExtension(ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_emm-getdatabytes
    HRESULT GetDataBytes(ushort* pwBufferLength, ubyte* pbBuffer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_emm-getsharedemmmessage
    HRESULT GetSharedEmmMessage(ushort* pwLength, ubyte** ppbMessage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_emm-getindividualemmmessage
    HRESULT GetIndividualEmmMessage(IUnknown pUnknown, ushort* pwLength, ubyte** ppbMessage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdb_emm-getversionhash
    HRESULT GetVersionHash(uint* pdwVersionHash);
}

@GUID("0f37bd92-d6a1-4854-b950-3a969d27f30e")
interface IDvbServiceAttributeDescriptor : IUnknown
{
    HRESULT GetTag(ubyte* pbVal);
    HRESULT GetLength(ubyte* pbVal);
    HRESULT GetCountOfRecords(ubyte* pbVal);
    HRESULT GetRecordServiceId(ubyte bRecordIndex, ushort* pwVal);
    HRESULT GetRecordNumericSelectionFlag(ubyte bRecordIndex, BOOL* pfVal);
    HRESULT GetRecordVisibleServiceFlag(ubyte bRecordIndex, BOOL* pfVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nn-dvbsiparser-idvbcontentidentifierdescriptor
@GUID("05e0c1ea-f661-4053-9fbf-d93b28359838")
interface IDvbContentIdentifierDescriptor : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbcontentidentifierdescriptor-gettag
    HRESULT GetTag(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbcontentidentifierdescriptor-getlength
    HRESULT GetLength(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbcontentidentifierdescriptor-getcountofrecords
    HRESULT GetCountOfRecords(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbcontentidentifierdescriptor-getrecordcrid
    HRESULT GetRecordCrid(ubyte bRecordIndex, ubyte* pbType, ubyte* pbLocation, ubyte* pbLength, ubyte** ppbBytes);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nn-dvbsiparser-idvbdefaultauthoritydescriptor
@GUID("05ec24d1-3a31-44e7-b408-67c60a352276")
interface IDvbDefaultAuthorityDescriptor : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbdefaultauthoritydescriptor-gettag
    HRESULT GetTag(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbdefaultauthoritydescriptor-getlength
    HRESULT GetLength(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbdefaultauthoritydescriptor-getdefaultauthority
    HRESULT GetDefaultAuthority(ubyte* pbLength, ubyte** ppbBytes);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nn-dvbsiparser-idvbsatellitedeliverysystemdescriptor
@GUID("02f2225a-805b-4ec5-a9a6-f9b5913cd470")
interface IDvbSatelliteDeliverySystemDescriptor : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbsatellitedeliverysystemdescriptor-gettag
    HRESULT GetTag(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbsatellitedeliverysystemdescriptor-getlength
    HRESULT GetLength(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbsatellitedeliverysystemdescriptor-getfrequency
    HRESULT GetFrequency(uint* pdwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbsatellitedeliverysystemdescriptor-getorbitalposition
    HRESULT GetOrbitalPosition(ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbsatellitedeliverysystemdescriptor-getwesteastflag
    HRESULT GetWestEastFlag(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbsatellitedeliverysystemdescriptor-getpolarization
    HRESULT GetPolarization(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbsatellitedeliverysystemdescriptor-getmodulation
    HRESULT GetModulation(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbsatellitedeliverysystemdescriptor-getsymbolrate
    HRESULT GetSymbolRate(uint* pdwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbsatellitedeliverysystemdescriptor-getfecinner
    HRESULT GetFECInner(ubyte* pbVal);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nn-dvbsiparser-idvbcabledeliverysystemdescriptor
@GUID("dfb98e36-9e1a-4862-9946-993a4e59017b")
interface IDvbCableDeliverySystemDescriptor : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbcabledeliverysystemdescriptor-gettag
    HRESULT GetTag(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbcabledeliverysystemdescriptor-getlength
    HRESULT GetLength(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbcabledeliverysystemdescriptor-getfrequency
    HRESULT GetFrequency(uint* pdwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbcabledeliverysystemdescriptor-getfecouter
    HRESULT GetFECOuter(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbcabledeliverysystemdescriptor-getmodulation
    HRESULT GetModulation(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbcabledeliverysystemdescriptor-getsymbolrate
    HRESULT GetSymbolRate(uint* pdwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbcabledeliverysystemdescriptor-getfecinner
    HRESULT GetFECInner(ubyte* pbVal);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nn-dvbsiparser-idvbterrestrialdeliverysystemdescriptor
@GUID("ed7e1b91-d12e-420c-b41d-a49d84fe1823")
interface IDvbTerrestrialDeliverySystemDescriptor : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbterrestrialdeliverysystemdescriptor-gettag
    HRESULT GetTag(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbterrestrialdeliverysystemdescriptor-getlength
    HRESULT GetLength(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbterrestrialdeliverysystemdescriptor-getcentrefrequency
    HRESULT GetCentreFrequency(uint* pdwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbterrestrialdeliverysystemdescriptor-getbandwidth
    HRESULT GetBandwidth(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbterrestrialdeliverysystemdescriptor-getconstellation
    HRESULT GetConstellation(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbterrestrialdeliverysystemdescriptor-gethierarchyinformation
    HRESULT GetHierarchyInformation(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbterrestrialdeliverysystemdescriptor-getcoderatehpstream
    HRESULT GetCodeRateHPStream(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbterrestrialdeliverysystemdescriptor-getcoderatelpstream
    HRESULT GetCodeRateLPStream(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbterrestrialdeliverysystemdescriptor-getguardinterval
    HRESULT GetGuardInterval(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbterrestrialdeliverysystemdescriptor-gettransmissionmode
    HRESULT GetTransmissionMode(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbterrestrialdeliverysystemdescriptor-getotherfrequencyflag
    HRESULT GetOtherFrequencyFlag(ubyte* pbVal);
}

@GUID("20ee9be9-cd57-49ab-8f6e-1d07aeb8e482")
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nn-dvbsiparser-idvbfrequencylistdescriptor
@GUID("1cadb613-e1dd-4512-afa8-bb7a007ef8b1")
interface IDvbFrequencyListDescriptor : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbfrequencylistdescriptor-gettag
    HRESULT GetTag(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbfrequencylistdescriptor-getlength
    HRESULT GetLength(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbfrequencylistdescriptor-getcodingtype
    HRESULT GetCodingType(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbfrequencylistdescriptor-getcountofrecords
    HRESULT GetCountOfRecords(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbfrequencylistdescriptor-getrecordcentrefrequency
    HRESULT GetRecordCentreFrequency(ubyte bRecordIndex, uint* pdwVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nn-dvbsiparser-idvbprivatedataspecifierdescriptor
@GUID("5660a019-e75a-4b82-9b4c-ed2256d165a2")
interface IDvbPrivateDataSpecifierDescriptor : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbprivatedataspecifierdescriptor-gettag
    HRESULT GetTag(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbprivatedataspecifierdescriptor-getlength
    HRESULT GetLength(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbprivatedataspecifierdescriptor-getprivatedataspecifier
    HRESULT GetPrivateDataSpecifier(uint* pdwVal);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nn-dvbsiparser-idvblogicalchanneldescriptor
@GUID("cf1edaff-3ffd-4cf7-8201-35756acbf85f")
interface IDvbLogicalChannelDescriptor : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvblogicalchanneldescriptor-gettag
    HRESULT GetTag(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvblogicalchanneldescriptor-getlength
    HRESULT GetLength(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvblogicalchanneldescriptor-getcountofrecords
    HRESULT GetCountOfRecords(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvblogicalchanneldescriptor-getrecordserviceid
    HRESULT GetRecordServiceId(ubyte bRecordIndex, ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvblogicalchanneldescriptor-getrecordlogicalchannelnumber
    HRESULT GetRecordLogicalChannelNumber(ubyte bRecordIndex, ushort* pwVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nn-dvbsiparser-idvblogicalchanneldescriptor2
@GUID("43aca974-4be8-4b98-bc17-9eafd788b1d7")
interface IDvbLogicalChannelDescriptor2 : IDvbLogicalChannelDescriptor
{
    HRESULT GetRecordLogicalChannelAndVisibility(ubyte bRecordIndex, ushort* pwVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nn-dvbsiparser-idvblogicalchannel2descriptor
@GUID("f69c3747-8a30-4980-998c-01fe7f0ba35a")
interface IDvbLogicalChannel2Descriptor : IDvbLogicalChannelDescriptor2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvblogicalchannel2descriptor-getcountoflists
    HRESULT GetCountOfLists(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvblogicalchannel2descriptor-getlistid
    HRESULT GetListId(ubyte bListIndex, ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvblogicalchannel2descriptor-getlistnamew
    HRESULT GetListNameW(ubyte bListIndex, DVB_STRCONV_MODE convMode, BSTR* pbstrName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvblogicalchannel2descriptor-getlistcountrycode
    HRESULT GetListCountryCode(ubyte bListIndex, ubyte* pszCode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvblogicalchannel2descriptor-getlistcountofrecords
    HRESULT GetListCountOfRecords(ubyte bChannelListIndex, ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvblogicalchannel2descriptor-getlistrecordserviceid
    HRESULT GetListRecordServiceId(ubyte bListIndex, ubyte bRecordIndex, ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvblogicalchannel2descriptor-getlistrecordlogicalchannelnumber
    HRESULT GetListRecordLogicalChannelNumber(ubyte bListIndex, ubyte bRecordIndex, ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvblogicalchannel2descriptor-getlistrecordlogicalchannelandvisibility
    HRESULT GetListRecordLogicalChannelAndVisibility(ubyte bListIndex, ubyte bRecordIndex, ushort* pwVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nn-dvbsiparser-idvbhdsimulcastlogicalchanneldescriptor
@GUID("1ea8b738-a307-4680-9e26-d0a908c824f4")
interface IDvbHDSimulcastLogicalChannelDescriptor : IDvbLogicalChannelDescriptor2
{
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nn-dvbsiparser-idvbdatabroadcastiddescriptor
@GUID("5f26f518-65c8-4048-91f2-9290f59f7b90")
interface IDvbDataBroadcastIDDescriptor : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbdatabroadcastiddescriptor-gettag
    HRESULT GetTag(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbdatabroadcastiddescriptor-getlength
    HRESULT GetLength(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbdatabroadcastiddescriptor-getdatabroadcastid
    HRESULT GetDataBroadcastID(ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbdatabroadcastiddescriptor-getidselectorbytes
    HRESULT GetIDSelectorBytes(ubyte* pbLen, ubyte* pbVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nn-dvbsiparser-idvbdatabroadcastdescriptor
@GUID("d1ebc1d6-8b60-4c20-9caf-e59382e7c400")
interface IDvbDataBroadcastDescriptor : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbdatabroadcastdescriptor-gettag
    HRESULT GetTag(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbdatabroadcastdescriptor-getlength
    HRESULT GetLength(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbdatabroadcastdescriptor-getdatabroadcastid
    HRESULT GetDataBroadcastID(ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbdatabroadcastdescriptor-getcomponenttag
    HRESULT GetComponentTag(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbdatabroadcastdescriptor-getselectorlength
    HRESULT GetSelectorLength(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbdatabroadcastdescriptor-getselectorbytes
    HRESULT GetSelectorBytes(ubyte* pbLen, ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbdatabroadcastdescriptor-getlangid
    HRESULT GetLangID(uint* pulVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbdatabroadcastdescriptor-gettextlength
    HRESULT GetTextLength(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbdatabroadcastdescriptor-gettext
    HRESULT GetText(ubyte* pbLen, ubyte* pbVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nn-dvbsiparser-idvblinkagedescriptor
@GUID("1cdf8b31-994a-46fc-acfd-6a6be8934dd5")
interface IDvbLinkageDescriptor : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvblinkagedescriptor-gettag
    HRESULT GetTag(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvblinkagedescriptor-getlength
    HRESULT GetLength(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvblinkagedescriptor-gettsid
    HRESULT GetTSId(ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvblinkagedescriptor-getonid
    HRESULT GetONId(ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvblinkagedescriptor-getserviceid
    HRESULT GetServiceId(ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvblinkagedescriptor-getlinkagetype
    HRESULT GetLinkageType(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvblinkagedescriptor-getprivatedatalength
    HRESULT GetPrivateDataLength(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvblinkagedescriptor-getprivatedata
    HRESULT GetPrivateData(ubyte* pbLen, ubyte* pbData);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nn-dvbsiparser-idvbteletextdescriptor
@GUID("9cd29d47-69c6-4f92-98a9-210af1b7303a")
interface IDvbTeletextDescriptor : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbteletextdescriptor-gettag
    HRESULT GetTag(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbteletextdescriptor-getlength
    HRESULT GetLength(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbteletextdescriptor-getcountofrecords
    HRESULT GetCountOfRecords(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbteletextdescriptor-getrecordlangid
    HRESULT GetRecordLangId(ubyte bRecordIndex, uint* pulVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbteletextdescriptor-getrecordteletexttype
    HRESULT GetRecordTeletextType(ubyte bRecordIndex, ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbteletextdescriptor-getrecordmagazinenumber
    HRESULT GetRecordMagazineNumber(ubyte bRecordIndex, ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbteletextdescriptor-getrecordpagenumber
    HRESULT GetRecordPageNumber(ubyte bRecordIndex, ubyte* pbVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nn-dvbsiparser-idvbsubtitlingdescriptor
@GUID("9b25fe1d-fa23-4e50-9784-6df8b26f8a49")
interface IDvbSubtitlingDescriptor : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbsubtitlingdescriptor-gettag
    HRESULT GetTag(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbsubtitlingdescriptor-getlength
    HRESULT GetLength(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbsubtitlingdescriptor-getcountofrecords
    HRESULT GetCountOfRecords(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbsubtitlingdescriptor-getrecordlangid
    HRESULT GetRecordLangId(ubyte bRecordIndex, uint* pulVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbsubtitlingdescriptor-getrecordsubtitlingtype
    HRESULT GetRecordSubtitlingType(ubyte bRecordIndex, ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbsubtitlingdescriptor-getrecordcompositionpageid
    HRESULT GetRecordCompositionPageID(ubyte bRecordIndex, ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbsubtitlingdescriptor-getrecordancillarypageid
    HRESULT GetRecordAncillaryPageID(ubyte bRecordIndex, ushort* pwVal);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nn-dvbsiparser-idvbservicedescriptor
@GUID("f9c7fbcf-e2d6-464d-b32d-2ef526e49290")
interface IDvbServiceDescriptor : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbservicedescriptor-gettag
    HRESULT GetTag(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbservicedescriptor-getlength
    HRESULT GetLength(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbservicedescriptor-getservicetype
    HRESULT GetServiceType(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbservicedescriptor-getserviceprovidername
    HRESULT GetServiceProviderName(ubyte** pszName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbservicedescriptor-getserviceprovidernamew
    HRESULT GetServiceProviderNameW(BSTR* pbstrName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbservicedescriptor-getservicename
    HRESULT GetServiceName(ubyte** pszName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbservicedescriptor-getprocessedservicename
    HRESULT GetProcessedServiceName(BSTR* pbstrName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbservicedescriptor-getservicenameemphasized
    HRESULT GetServiceNameEmphasized(BSTR* pbstrName);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nn-dvbsiparser-idvbservicedescriptor2
@GUID("d6c76506-85ab-487c-9b2b-36416511e4a2")
interface IDvbServiceDescriptor2 : IDvbServiceDescriptor
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbservicedescriptor2-getserviceprovidernamew
    HRESULT GetServiceProviderNameW(DVB_STRCONV_MODE convMode, BSTR* pbstrName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbservicedescriptor2-getservicenamew
    HRESULT GetServiceNameW(DVB_STRCONV_MODE convMode, BSTR* pbstrName);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nn-dvbsiparser-idvbservicelistdescriptor
@GUID("05db0d8f-6008-491a-acd3-7090952707d0")
interface IDvbServiceListDescriptor : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbservicelistdescriptor-gettag
    HRESULT GetTag(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbservicelistdescriptor-getlength
    HRESULT GetLength(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbservicelistdescriptor-getcountofrecords
    HRESULT GetCountOfRecords(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbservicelistdescriptor-getrecordserviceid
    HRESULT GetRecordServiceId(ubyte bRecordIndex, ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbservicelistdescriptor-getrecordservicetype
    HRESULT GetRecordServiceType(ubyte bRecordIndex, ubyte* pbVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nn-dvbsiparser-idvbmultilingualservicenamedescriptor
@GUID("2d80433b-b32c-47ef-987f-e78ebb773e34")
interface IDvbMultilingualServiceNameDescriptor : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbmultilingualservicenamedescriptor-gettag
    HRESULT GetTag(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbmultilingualservicenamedescriptor-getlength
    HRESULT GetLength(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbmultilingualservicenamedescriptor-getcountofrecords
    HRESULT GetCountOfRecords(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbmultilingualservicenamedescriptor-getrecordlangid
    HRESULT GetRecordLangId(ubyte bRecordIndex, uint* ulVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbmultilingualservicenamedescriptor-getrecordserviceprovidernamew
    HRESULT GetRecordServiceProviderNameW(ubyte bRecordIndex, DVB_STRCONV_MODE convMode, BSTR* pbstrName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbmultilingualservicenamedescriptor-getrecordservicenamew
    HRESULT GetRecordServiceNameW(ubyte bRecordIndex, DVB_STRCONV_MODE convMode, BSTR* pbstrName);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nn-dvbsiparser-idvbnetworknamedescriptor
@GUID("5b2a80cf-35b9-446c-b3e4-048b761dbc51")
interface IDvbNetworkNameDescriptor : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbnetworknamedescriptor-gettag
    HRESULT GetTag(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbnetworknamedescriptor-getlength
    HRESULT GetLength(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbnetworknamedescriptor-getnetworkname
    HRESULT GetNetworkName(ubyte** pszName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbnetworknamedescriptor-getnetworknamew
    HRESULT GetNetworkNameW(DVB_STRCONV_MODE convMode, BSTR* pbstrName);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nn-dvbsiparser-idvbshorteventdescriptor
@GUID("b170be92-5b75-458e-9c6e-b0008231491a")
interface IDvbShortEventDescriptor : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbshorteventdescriptor-gettag
    HRESULT GetTag(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbshorteventdescriptor-getlength
    HRESULT GetLength(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbshorteventdescriptor-getlanguagecode
    HRESULT GetLanguageCode(ubyte* pszCode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbshorteventdescriptor-geteventnamew
    HRESULT GetEventNameW(DVB_STRCONV_MODE convMode, BSTR* pbstrName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbshorteventdescriptor-gettextw
    HRESULT GetTextW(DVB_STRCONV_MODE convMode, BSTR* pbstrText);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nn-dvbsiparser-idvbextendedeventdescriptor
@GUID("c9b22eca-85f4-499f-b1db-efa93a91ee57")
interface IDvbExtendedEventDescriptor : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbextendedeventdescriptor-gettag
    HRESULT GetTag(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbextendedeventdescriptor-getlength
    HRESULT GetLength(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbextendedeventdescriptor-getdescriptornumber
    HRESULT GetDescriptorNumber(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbextendedeventdescriptor-getlastdescriptornumber
    HRESULT GetLastDescriptorNumber(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbextendedeventdescriptor-getlanguagecode
    HRESULT GetLanguageCode(ubyte* pszCode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbextendedeventdescriptor-getcountofrecords
    HRESULT GetCountOfRecords(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbextendedeventdescriptor-getrecorditemw
    HRESULT GetRecordItemW(ubyte bRecordIndex, DVB_STRCONV_MODE convMode, BSTR* pbstrDesc, BSTR* pbstrItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbextendedeventdescriptor-getconcatenateditemw
    HRESULT GetConcatenatedItemW(IDvbExtendedEventDescriptor pFollowingDescriptor, DVB_STRCONV_MODE convMode, 
                                 BSTR* pbstrDesc, BSTR* pbstrItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbextendedeventdescriptor-gettextw
    HRESULT GetTextW(DVB_STRCONV_MODE convMode, BSTR* pbstrText);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbextendedeventdescriptor-getconcatenatedtextw
    HRESULT GetConcatenatedTextW(IDvbExtendedEventDescriptor FollowingDescriptor, DVB_STRCONV_MODE convMode, 
                                 BSTR* pbstrText);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbextendedeventdescriptor-getrecorditemrawbytes
    HRESULT GetRecordItemRawBytes(ubyte bRecordIndex, ubyte** ppbRawItem, ubyte* pbItemLength);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nn-dvbsiparser-idvbcomponentdescriptor
@GUID("91e405cf-80e7-457f-9096-1b9d1ce32141")
interface IDvbComponentDescriptor : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbcomponentdescriptor-gettag
    HRESULT GetTag(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbcomponentdescriptor-getlength
    HRESULT GetLength(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbcomponentdescriptor-getstreamcontent
    HRESULT GetStreamContent(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbcomponentdescriptor-getcomponenttype
    HRESULT GetComponentType(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbcomponentdescriptor-getcomponenttag
    HRESULT GetComponentTag(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbcomponentdescriptor-getlanguagecode
    HRESULT GetLanguageCode(ubyte* pszCode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbcomponentdescriptor-gettextw
    HRESULT GetTextW(DVB_STRCONV_MODE convMode, BSTR* pbstrText);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nn-dvbsiparser-idvbcontentdescriptor
@GUID("2e883881-a467-412a-9d63-6f2b6da05bf0")
interface IDvbContentDescriptor : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbcontentdescriptor-gettag
    HRESULT GetTag(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbcontentdescriptor-getlength
    HRESULT GetLength(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbcontentdescriptor-getcountofrecords
    HRESULT GetCountOfRecords(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbcontentdescriptor-getrecordcontentnibbles
    HRESULT GetRecordContentNibbles(ubyte bRecordIndex, ubyte* pbValLevel1, ubyte* pbValLevel2);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbcontentdescriptor-getrecordusernibbles
    HRESULT GetRecordUserNibbles(ubyte bRecordIndex, ubyte* pbVal1, ubyte* pbVal2);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nn-dvbsiparser-idvbparentalratingdescriptor
@GUID("3ad9dde1-fb1b-4186-937f-22e6b5a72a10")
interface IDvbParentalRatingDescriptor : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbparentalratingdescriptor-gettag
    HRESULT GetTag(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbparentalratingdescriptor-getlength
    HRESULT GetLength(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbparentalratingdescriptor-getcountofrecords
    HRESULT GetCountOfRecords(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-idvbparentalratingdescriptor-getrecordrating
    HRESULT GetRecordRating(ubyte bRecordIndex, ubyte* pszCountryCode, ubyte* pbVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nn-dvbsiparser-iisdbterrestrialdeliverysystemdescriptor
@GUID("39fae0a6-d151-44dd-a28a-765de5991670")
interface IIsdbTerrestrialDeliverySystemDescriptor : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbterrestrialdeliverysystemdescriptor-gettag
    HRESULT GetTag(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbterrestrialdeliverysystemdescriptor-getlength
    HRESULT GetLength(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbterrestrialdeliverysystemdescriptor-getareacode
    HRESULT GetAreaCode(ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbterrestrialdeliverysystemdescriptor-getguardinterval
    HRESULT GetGuardInterval(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbterrestrialdeliverysystemdescriptor-gettransmissionmode
    HRESULT GetTransmissionMode(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbterrestrialdeliverysystemdescriptor-getcountofrecords
    HRESULT GetCountOfRecords(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbterrestrialdeliverysystemdescriptor-getrecordfrequency
    HRESULT GetRecordFrequency(ubyte bRecordIndex, uint* pdwVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nn-dvbsiparser-iisdbtsinformationdescriptor
@GUID("d7ad183e-38f5-4210-b55f-ec8d601bbd47")
interface IIsdbTSInformationDescriptor : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbtsinformationdescriptor-gettag
    HRESULT GetTag(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbtsinformationdescriptor-getlength
    HRESULT GetLength(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbtsinformationdescriptor-getremotecontrolkeyid
    HRESULT GetRemoteControlKeyId(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbtsinformationdescriptor-gettsnamew
    HRESULT GetTSNameW(DVB_STRCONV_MODE convMode, BSTR* pbstrName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbtsinformationdescriptor-getcountofrecords
    HRESULT GetCountOfRecords(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbtsinformationdescriptor-getrecordtransmissiontypeinfo
    HRESULT GetRecordTransmissionTypeInfo(ubyte bRecordIndex, ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbtsinformationdescriptor-getrecordnumberofservices
    HRESULT GetRecordNumberOfServices(ubyte bRecordIndex, ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbtsinformationdescriptor-getrecordserviceidbyindex
    HRESULT GetRecordServiceIdByIndex(ubyte bRecordIndex, ubyte bServiceIndex, ushort* pdwVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nn-dvbsiparser-iisdbdigitalcopycontroldescriptor
@GUID("1a28417e-266a-4bb8-a4bd-d782bcfb8161")
interface IIsdbDigitalCopyControlDescriptor : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbdigitalcopycontroldescriptor-gettag
    HRESULT GetTag(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbdigitalcopycontroldescriptor-getlength
    HRESULT GetLength(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbdigitalcopycontroldescriptor-getcopycontrol
    HRESULT GetCopyControl(ubyte* pbDigitalRecordingControlData, ubyte* pbCopyControlType, ubyte* pbAPSControlData, 
                           ubyte* pbMaximumBitrate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbdigitalcopycontroldescriptor-getcountofrecords
    HRESULT GetCountOfRecords(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbdigitalcopycontroldescriptor-getrecordcopycontrol
    HRESULT GetRecordCopyControl(ubyte bRecordIndex, ubyte* pbComponentTag, ubyte* pbDigitalRecordingControlData, 
                                 ubyte* pbCopyControlType, ubyte* pbAPSControlData, ubyte* pbMaximumBitrate);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nn-dvbsiparser-iisdbaudiocomponentdescriptor
@GUID("679d2002-2425-4be4-a4c7-d6632a574f4d")
interface IIsdbAudioComponentDescriptor : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbaudiocomponentdescriptor-gettag
    HRESULT GetTag(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbaudiocomponentdescriptor-getlength
    HRESULT GetLength(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbaudiocomponentdescriptor-getstreamcontent
    HRESULT GetStreamContent(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbaudiocomponentdescriptor-getcomponenttype
    HRESULT GetComponentType(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbaudiocomponentdescriptor-getcomponenttag
    HRESULT GetComponentTag(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbaudiocomponentdescriptor-getstreamtype
    HRESULT GetStreamType(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbaudiocomponentdescriptor-getsimulcastgrouptag
    HRESULT GetSimulcastGroupTag(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbaudiocomponentdescriptor-getesmultilingualflag
    HRESULT GetESMultiLingualFlag(BOOL* pfVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbaudiocomponentdescriptor-getmaincomponentflag
    HRESULT GetMainComponentFlag(BOOL* pfVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbaudiocomponentdescriptor-getqualityindicator
    HRESULT GetQualityIndicator(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbaudiocomponentdescriptor-getsamplingrate
    HRESULT GetSamplingRate(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbaudiocomponentdescriptor-getlanguagecode
    HRESULT GetLanguageCode(ubyte* pszCode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbaudiocomponentdescriptor-getlanguagecode2
    HRESULT GetLanguageCode2(ubyte* pszCode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbaudiocomponentdescriptor-gettextw
    HRESULT GetTextW(DVB_STRCONV_MODE convMode, BSTR* pbstrText);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nn-dvbsiparser-iisdbdatacontentdescriptor
@GUID("a428100a-e646-4bd6-aa14-6087bdc08cd5")
interface IIsdbDataContentDescriptor : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbdatacontentdescriptor-gettag
    HRESULT GetTag(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbdatacontentdescriptor-getlength
    HRESULT GetLength(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbdatacontentdescriptor-getdatacomponentid
    HRESULT GetDataComponentId(ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbdatacontentdescriptor-getentrycomponent
    HRESULT GetEntryComponent(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbdatacontentdescriptor-getselectorlength
    HRESULT GetSelectorLength(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbdatacontentdescriptor-getselectorbytes
    HRESULT GetSelectorBytes(ubyte bBufLength, ubyte* pbBuf);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbdatacontentdescriptor-getcountofrecords
    HRESULT GetCountOfRecords(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbdatacontentdescriptor-getrecordcomponentref
    HRESULT GetRecordComponentRef(ubyte bRecordIndex, ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbdatacontentdescriptor-getlanguagecode
    HRESULT GetLanguageCode(ubyte* pszCode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbdatacontentdescriptor-gettextw
    HRESULT GetTextW(DVB_STRCONV_MODE convMode, BSTR* pbstrText);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nn-dvbsiparser-iisdbcacontractinformationdescriptor
@GUID("08e18b25-a28f-4e92-821e-4fced5cc2291")
interface IIsdbCAContractInformationDescriptor : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbcacontractinformationdescriptor-gettag
    HRESULT GetTag(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbcacontractinformationdescriptor-getlength
    HRESULT GetLength(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbcacontractinformationdescriptor-getcasystemid
    HRESULT GetCASystemId(ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbcacontractinformationdescriptor-getcaunitid
    HRESULT GetCAUnitId(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbcacontractinformationdescriptor-getcountofrecords
    HRESULT GetCountOfRecords(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbcacontractinformationdescriptor-getrecordcomponenttag
    HRESULT GetRecordComponentTag(ubyte bRecordIndex, ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbcacontractinformationdescriptor-getcontractverificationinfolength
    HRESULT GetContractVerificationInfoLength(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbcacontractinformationdescriptor-getcontractverificationinfo
    HRESULT GetContractVerificationInfo(ubyte bBufLength, ubyte* pbBuf);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbcacontractinformationdescriptor-getfeenamew
    HRESULT GetFeeNameW(DVB_STRCONV_MODE convMode, BSTR* pbstrName);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nn-dvbsiparser-iisdbeventgroupdescriptor
@GUID("94b06780-2e2a-44dc-a966-cc56fdabc6c2")
interface IIsdbEventGroupDescriptor : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbeventgroupdescriptor-gettag
    HRESULT GetTag(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbeventgroupdescriptor-getlength
    HRESULT GetLength(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbeventgroupdescriptor-getgrouptype
    HRESULT GetGroupType(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbeventgroupdescriptor-getcountofrecords
    HRESULT GetCountOfRecords(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbeventgroupdescriptor-getrecordevent
    HRESULT GetRecordEvent(ubyte bRecordIndex, ushort* pwServiceId, ushort* pwEventId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbeventgroupdescriptor-getcountofrefrecords
    HRESULT GetCountOfRefRecords(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbeventgroupdescriptor-getrefrecordevent
    HRESULT GetRefRecordEvent(ubyte bRecordIndex, ushort* pwOriginalNetworkId, ushort* pwTransportStreamId, 
                              ushort* pwServiceId, ushort* pwEventId);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nn-dvbsiparser-iisdbcomponentgroupdescriptor
@GUID("a494f17f-c592-47d8-8943-64c9a34be7b9")
interface IIsdbComponentGroupDescriptor : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbcomponentgroupdescriptor-gettag
    HRESULT GetTag(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbcomponentgroupdescriptor-getlength
    HRESULT GetLength(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbcomponentgroupdescriptor-getcomponentgrouptype
    HRESULT GetComponentGroupType(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbcomponentgroupdescriptor-getcountofrecords
    HRESULT GetCountOfRecords(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbcomponentgroupdescriptor-getrecordgroupid
    HRESULT GetRecordGroupId(ubyte bRecordIndex, ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbcomponentgroupdescriptor-getrecordnumberofcaunit
    HRESULT GetRecordNumberOfCAUnit(ubyte bRecordIndex, ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbcomponentgroupdescriptor-getrecordcaunitcaunitid
    HRESULT GetRecordCAUnitCAUnitId(ubyte bRecordIndex, ubyte bCAUnitIndex, ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbcomponentgroupdescriptor-getrecordcaunitnumberofcomponents
    HRESULT GetRecordCAUnitNumberOfComponents(ubyte bRecordIndex, ubyte bCAUnitIndex, ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbcomponentgroupdescriptor-getrecordcaunitcomponenttag
    HRESULT GetRecordCAUnitComponentTag(ubyte bRecordIndex, ubyte bCAUnitIndex, ubyte bComponentIndex, 
                                        ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbcomponentgroupdescriptor-getrecordtotalbitrate
    HRESULT GetRecordTotalBitRate(ubyte bRecordIndex, ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbcomponentgroupdescriptor-getrecordtextw
    HRESULT GetRecordTextW(ubyte bRecordIndex, DVB_STRCONV_MODE convMode, BSTR* pbstrText);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nn-dvbsiparser-iisdbseriesdescriptor
@GUID("07ef6370-1660-4f26-87fc-614adab24b11")
interface IIsdbSeriesDescriptor : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbseriesdescriptor-gettag
    HRESULT GetTag(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbseriesdescriptor-getlength
    HRESULT GetLength(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbseriesdescriptor-getseriesid
    HRESULT GetSeriesId(ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbseriesdescriptor-getrepeatlabel
    HRESULT GetRepeatLabel(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbseriesdescriptor-getprogrampattern
    HRESULT GetProgramPattern(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbseriesdescriptor-getexpiredate
    HRESULT GetExpireDate(BOOL* pfValid, MPEG_DATE_AND_TIME* pmdtVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbseriesdescriptor-getepisodenumber
    HRESULT GetEpisodeNumber(ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbseriesdescriptor-getlastepisodenumber
    HRESULT GetLastEpisodeNumber(ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbseriesdescriptor-getseriesnamew
    HRESULT GetSeriesNameW(DVB_STRCONV_MODE convMode, BSTR* pbstrName);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nn-dvbsiparser-iisdbdownloadcontentdescriptor
@GUID("5298661e-cb88-4f5f-a1de-5f440c185b92")
interface IIsdbDownloadContentDescriptor : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbdownloadcontentdescriptor-gettag
    HRESULT GetTag(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbdownloadcontentdescriptor-getlength
    HRESULT GetLength(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbdownloadcontentdescriptor-getflags
    HRESULT GetFlags(BOOL* pfReboot, BOOL* pfAddOn, BOOL* pfCompatibility, BOOL* pfModuleInfo, BOOL* pfTextInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbdownloadcontentdescriptor-getcomponentsize
    HRESULT GetComponentSize(uint* pdwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbdownloadcontentdescriptor-getdownloadid
    HRESULT GetDownloadId(uint* pdwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbdownloadcontentdescriptor-gettimeoutvaluedii
    HRESULT GetTimeOutValueDII(uint* pdwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbdownloadcontentdescriptor-getleakrate
    HRESULT GetLeakRate(uint* pdwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbdownloadcontentdescriptor-getcomponenttag
    HRESULT GetComponentTag(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbdownloadcontentdescriptor-getcompatiblitydescriptorlength
    HRESULT GetCompatiblityDescriptorLength(ushort* pwLength);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbdownloadcontentdescriptor-getcompatiblitydescriptor
    HRESULT GetCompatiblityDescriptor(ubyte** ppbData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbdownloadcontentdescriptor-getcountofrecords
    HRESULT GetCountOfRecords(ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbdownloadcontentdescriptor-getrecordmoduleid
    HRESULT GetRecordModuleId(ushort wRecordIndex, ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbdownloadcontentdescriptor-getrecordmodulesize
    HRESULT GetRecordModuleSize(ushort wRecordIndex, uint* pdwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbdownloadcontentdescriptor-getrecordmoduleinfolength
    HRESULT GetRecordModuleInfoLength(ushort wRecordIndex, ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbdownloadcontentdescriptor-getrecordmoduleinfo
    HRESULT GetRecordModuleInfo(ushort wRecordIndex, ubyte** ppbData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbdownloadcontentdescriptor-gettextlanguagecode
    HRESULT GetTextLanguageCode(ubyte* szCode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbdownloadcontentdescriptor-gettextw
    HRESULT GetTextW(DVB_STRCONV_MODE convMode, BSTR* pbstrName);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nn-dvbsiparser-iisdblogotransmissiondescriptor
@GUID("e0103f49-4ae1-4f07-9098-756db1fa88cd")
interface IIsdbLogoTransmissionDescriptor : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdblogotransmissiondescriptor-gettag
    HRESULT GetTag(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdblogotransmissiondescriptor-getlength
    HRESULT GetLength(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdblogotransmissiondescriptor-getlogotransmissiontype
    HRESULT GetLogoTransmissionType(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdblogotransmissiondescriptor-getlogoid
    HRESULT GetLogoId(ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdblogotransmissiondescriptor-getlogoversion
    HRESULT GetLogoVersion(ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdblogotransmissiondescriptor-getdownloaddataid
    HRESULT GetDownloadDataId(ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdblogotransmissiondescriptor-getlogocharw
    HRESULT GetLogoCharW(DVB_STRCONV_MODE convMode, BSTR* pbstrChar);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nn-dvbsiparser-iisdbsiparameterdescriptor
@GUID("f837dc36-867c-426a-9111-f62093951a45")
interface IIsdbSIParameterDescriptor : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbsiparameterdescriptor-gettag
    HRESULT GetTag(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbsiparameterdescriptor-getlength
    HRESULT GetLength(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbsiparameterdescriptor-getparameterversion
    HRESULT GetParameterVersion(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbsiparameterdescriptor-getupdatetime
    HRESULT GetUpdateTime(MPEG_DATE* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbsiparameterdescriptor-getrecordnumberoftable
    HRESULT GetRecordNumberOfTable(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbsiparameterdescriptor-gettableid
    HRESULT GetTableId(ubyte bRecordIndex, ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbsiparameterdescriptor-gettabledescriptionlength
    HRESULT GetTableDescriptionLength(ubyte bRecordIndex, ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbsiparameterdescriptor-gettabledescriptionbytes
    HRESULT GetTableDescriptionBytes(ubyte bRecordIndex, ubyte* pbBufferLength, ubyte* pbBuffer);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nn-dvbsiparser-iisdbemergencyinformationdescriptor
@GUID("ba6fa681-b973-4da1-9207-ac3e7f0341eb")
interface IIsdbEmergencyInformationDescriptor : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbemergencyinformationdescriptor-gettag
    HRESULT GetTag(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbemergencyinformationdescriptor-getlength
    HRESULT GetLength(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbemergencyinformationdescriptor-getcountofrecords
    HRESULT GetCountOfRecords(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbemergencyinformationdescriptor-getserviceid
    HRESULT GetServiceId(ubyte bRecordIndex, ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbemergencyinformationdescriptor-getstartendflag
    HRESULT GetStartEndFlag(ubyte bRecordIndex, ubyte* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbemergencyinformationdescriptor-getsignallevel
    HRESULT GetSignalLevel(ubyte bRecordIndex, ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbemergencyinformationdescriptor-getareacode
    HRESULT GetAreaCode(ubyte bRecordIndex, ushort** ppwVal, ubyte* pbNumAreaCodes);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nn-dvbsiparser-iisdbcadescriptor
@GUID("0570aa47-52bc-42ae-8ca5-969f41e81aea")
interface IIsdbCADescriptor : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbcadescriptor-gettag
    HRESULT GetTag(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbcadescriptor-getlength
    HRESULT GetLength(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbcadescriptor-getcasystemid
    HRESULT GetCASystemId(ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbcadescriptor-getreservedbits
    HRESULT GetReservedBits(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbcadescriptor-getcapid
    HRESULT GetCAPID(ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbcadescriptor-getprivatedatabytes
    HRESULT GetPrivateDataBytes(ubyte* pbBufferLength, ubyte* pbBuffer);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nn-dvbsiparser-iisdbcaservicedescriptor
@GUID("39cbeb97-ff0b-42a7-9ab9-7b9cfe70a77a")
interface IIsdbCAServiceDescriptor : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbcaservicedescriptor-gettag
    HRESULT GetTag(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbcaservicedescriptor-getlength
    HRESULT GetLength(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbcaservicedescriptor-getcasystemid
    HRESULT GetCASystemId(ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbcaservicedescriptor-getcabroadcastergroupid
    HRESULT GetCABroadcasterGroupId(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbcaservicedescriptor-getmessagecontrol
    HRESULT GetMessageControl(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbcaservicedescriptor-getserviceids
    HRESULT GetServiceIds(ubyte* pbNumServiceIds, ushort* pwServiceIds);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nn-dvbsiparser-iisdbhierarchicaltransmissiondescriptor
@GUID("b7b3ae90-ee0b-446d-8769-f7e2aa266aa6")
interface IIsdbHierarchicalTransmissionDescriptor : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbhierarchicaltransmissiondescriptor-gettag
    HRESULT GetTag(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbhierarchicaltransmissiondescriptor-getlength
    HRESULT GetLength(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbhierarchicaltransmissiondescriptor-getfutureuse1
    HRESULT GetFutureUse1(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbhierarchicaltransmissiondescriptor-getqualitylevel
    HRESULT GetQualityLevel(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbhierarchicaltransmissiondescriptor-getfutureuse2
    HRESULT GetFutureUse2(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-iisdbhierarchicaltransmissiondescriptor-getreferencepid
    HRESULT GetReferencePid(ushort* pwVal);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nn-dvbsiparser-ipbdasiparser
@GUID("9de49a74-aba2-4a18-93e1-21f17f95c3c3")
interface IPBDASiParser : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-ipbdasiparser-initialize
    HRESULT Initialize(IUnknown punk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-ipbdasiparser-geteit
    HRESULT GetEIT(uint dwSize, ubyte* pBuffer, IPBDA_EIT* ppEIT);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-ipbdasiparser-getservices
    HRESULT GetServices(uint dwSize, const(ubyte)* pBuffer, IPBDA_Services* ppServices);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nn-dvbsiparser-ipbda_eit
@GUID("a35f2dea-098f-4ebd-984c-2bd4c3c8ce0a")
interface IPBDA_EIT : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-ipbda_eit-initialize
    HRESULT Initialize(uint size, const(ubyte)* pBuffer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-ipbda_eit-gettableid
    HRESULT GetTableId(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-ipbda_eit-getversionnumber
    HRESULT GetVersionNumber(ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-ipbda_eit-getserviceidx
    HRESULT GetServiceIdx(ulong* plwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-ipbda_eit-getcountofrecords
    HRESULT GetCountOfRecords(uint* pdwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-ipbda_eit-getrecordeventid
    HRESULT GetRecordEventId(uint dwRecordIndex, ulong* plwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-ipbda_eit-getrecordstarttime
    HRESULT GetRecordStartTime(uint dwRecordIndex, MPEG_DATE_AND_TIME* pmdtVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-ipbda_eit-getrecordduration
    HRESULT GetRecordDuration(uint dwRecordIndex, MPEG_TIME* pmdVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-ipbda_eit-getrecordcountofdescriptors
    HRESULT GetRecordCountOfDescriptors(uint dwRecordIndex, uint* pdwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-ipbda_eit-getrecorddescriptorbyindex
    HRESULT GetRecordDescriptorByIndex(uint dwRecordIndex, uint dwIndex, IGenericDescriptor* ppDescriptor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-ipbda_eit-getrecorddescriptorbytag
    HRESULT GetRecordDescriptorByTag(uint dwRecordIndex, ubyte bTag, uint* pdwCookie, 
                                     IGenericDescriptor* ppDescriptor);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nn-dvbsiparser-ipbda_services
@GUID("944eab37-eed4-4850-afd2-77e7efeb4427")
interface IPBDA_Services : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-ipbda_services-initialize
    HRESULT Initialize(uint size, ubyte* pBuffer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-ipbda_services-getcountofrecords
    HRESULT GetCountOfRecords(uint* pdwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-ipbda_services-getrecordbyindex
    HRESULT GetRecordByIndex(uint dwRecordIndex, ulong* pul64ServiceIdx);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nn-dvbsiparser-ipbdaentitlementdescriptor
@GUID("22632497-0de3-4587-aadc-d8d99017e760")
interface IPBDAEntitlementDescriptor : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-ipbdaentitlementdescriptor-gettag
    HRESULT GetTag(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-ipbdaentitlementdescriptor-getlength
    HRESULT GetLength(ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-ipbdaentitlementdescriptor-gettoken
    HRESULT GetToken(ubyte** ppbTokenBuffer, uint* pdwTokenLength);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nn-dvbsiparser-ipbdaattributesdescriptor
@GUID("313b3620-3263-45a6-9533-968befbeac03")
interface IPBDAAttributesDescriptor : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-ipbdaattributesdescriptor-gettag
    HRESULT GetTag(ubyte* pbVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-ipbdaattributesdescriptor-getlength
    HRESULT GetLength(ushort* pwVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dvbsiparser/nf-dvbsiparser-ipbdaattributesdescriptor-getattributepayload
    HRESULT GetAttributePayload(ubyte** ppbAttributeBuffer, uint* pdwAttributeLength);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdatif/nn-bdatif-ibda_tif_registration
@GUID("dfef4a68-ee61-415f-9ccb-cd95f2f98a3a")
interface IBDA_TIF_REGISTRATION : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdatif/nf-bdatif-ibda_tif_registration-registertifex
    HRESULT RegisterTIFEx(IPin pTIFInputPin, uint* ppvRegistrationContext, IUnknown* ppMpeg2DataControl);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdatif/nf-bdatif-ibda_tif_registration-unregistertif
    HRESULT UnregisterTIF(uint pvRegistrationContext);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdatif/nn-bdatif-impeg2_tif_control
@GUID("f9bac2f9-4149-4916-b2ef-faa202326862")
interface IMPEG2_TIF_CONTROL : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdatif/nf-bdatif-impeg2_tif_control-registertif
    HRESULT RegisterTIF(IUnknown pUnkTIF, uint* ppvRegistrationContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdatif/nf-bdatif-impeg2_tif_control-unregistertif
    HRESULT UnregisterTIF(uint pvRegistrationContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdatif/nf-bdatif-impeg2_tif_control-addpids
    HRESULT AddPIDs(uint ulcPIDs, uint* pulPIDs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdatif/nf-bdatif-impeg2_tif_control-deletepids
    HRESULT DeletePIDs(uint ulcPIDs, uint* pulPIDs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdatif/nf-bdatif-impeg2_tif_control-getpidcount
    HRESULT GetPIDCount(uint* pulcPIDs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdatif/nf-bdatif-impeg2_tif_control-getpids
    HRESULT GetPIDs(uint* pulcPIDs, uint* pulPIDs);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdatif/nn-bdatif-itunerequestinfo
@GUID("a3b152df-7a90-4218-ac54-9830bee8c0b6")
interface ITuneRequestInfo : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdatif/nf-bdatif-itunerequestinfo-getlocatordata
    HRESULT GetLocatorData(ITuneRequest Request);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdatif/nf-bdatif-itunerequestinfo-getcomponentdata
    HRESULT GetComponentData(ITuneRequest CurrentRequest);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdatif/nf-bdatif-itunerequestinfo-createcomponentlist
    HRESULT CreateComponentList(ITuneRequest CurrentRequest);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdatif/nf-bdatif-itunerequestinfo-getnextprogram
    HRESULT GetNextProgram(ITuneRequest CurrentRequest, ITuneRequest* TuneRequest);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdatif/nf-bdatif-itunerequestinfo-getpreviousprogram
    HRESULT GetPreviousProgram(ITuneRequest CurrentRequest, ITuneRequest* TuneRequest);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdatif/nf-bdatif-itunerequestinfo-getnextlocator
    HRESULT GetNextLocator(ITuneRequest CurrentRequest, ITuneRequest* TuneRequest);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdatif/nf-bdatif-itunerequestinfo-getpreviouslocator
    HRESULT GetPreviousLocator(ITuneRequest CurrentRequest, ITuneRequest* TuneRequest);
}

@GUID("ee957c52-b0d0-4e78-8dd1-b87a08bfd893")
interface ITuneRequestInfoEx : ITuneRequestInfo
{
    HRESULT CreateComponentListEx(ITuneRequest CurrentRequest, IUnknown* ppCurPMT);
}

@GUID("7e47913a-5a89-423d-9a2b-e15168858934")
interface ISIInbandEPGEvent : IUnknown
{
    HRESULT SIObjectEvent(IDVB_EIT2 pIDVB_EIT, uint dwTable_ID, uint dwService_ID);
}

@GUID("f90ad9d0-b854-4b68-9cc1-b2cc96119d85")
interface ISIInbandEPG : IUnknown
{
    HRESULT StartSIEPGScan();
    HRESULT StopSIEPGScan();
    HRESULT IsSIEPGScanRunning(BOOL* bRunning);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdatif/nn-bdatif-iguidedataevent
@GUID("efda0c80-f395-42c3-9b3c-56b37dec7bb7")
interface IGuideDataEvent : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdatif/nf-bdatif-iguidedataevent-guidedataacquired
    HRESULT GuideDataAcquired();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdatif/nf-bdatif-iguidedataevent-programchanged
    HRESULT ProgramChanged(VARIANT varProgramDescriptionID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdatif/nf-bdatif-iguidedataevent-servicechanged
    HRESULT ServiceChanged(VARIANT varServiceDescriptionID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdatif/nf-bdatif-iguidedataevent-scheduleentrychanged
    HRESULT ScheduleEntryChanged(VARIANT varScheduleEntryDescriptionID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdatif/nf-bdatif-iguidedataevent-programdeleted
    HRESULT ProgramDeleted(VARIANT varProgramDescriptionID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdatif/nf-bdatif-iguidedataevent-servicedeleted
    HRESULT ServiceDeleted(VARIANT varServiceDescriptionID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdatif/nf-bdatif-iguidedataevent-scheduledeleted
    HRESULT ScheduleDeleted(VARIANT varScheduleEntryDescriptionID);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdatif/nn-bdatif-iguidedataproperty
@GUID("88ec5e58-bb73-41d6-99ce-66c524b8b591")
interface IGuideDataProperty : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdatif/nf-bdatif-iguidedataproperty-get_name
    HRESULT get_Name(BSTR* pbstrName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdatif/nf-bdatif-iguidedataproperty-get_language
    HRESULT get_Language(int* idLang);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdatif/nf-bdatif-iguidedataproperty-get_value
    HRESULT get_Value(VARIANT* pvar);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdatif/nn-bdatif-ienumguidedataproperties
@GUID("ae44423b-4571-475c-ad2c-f40a771d80ef")
interface IEnumGuideDataProperties : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdatif/nf-bdatif-ienumguidedataproperties-next
    HRESULT Next(uint celt, IGuideDataProperty* ppprop, uint* pcelt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdatif/nf-bdatif-ienumguidedataproperties-skip
    HRESULT Skip(uint celt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdatif/nf-bdatif-ienumguidedataproperties-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdatif/nf-bdatif-ienumguidedataproperties-clone
    HRESULT Clone(IEnumGuideDataProperties* ppenum);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdatif/nn-bdatif-ienumtunerequests
@GUID("1993299c-ced6-4788-87a3-420067dce0c7")
interface IEnumTuneRequests : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdatif/nf-bdatif-ienumtunerequests-next
    HRESULT Next(uint celt, ITuneRequest* ppprop, uint* pcelt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdatif/nf-bdatif-ienumtunerequests-skip
    HRESULT Skip(uint celt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdatif/nf-bdatif-ienumtunerequests-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdatif/nf-bdatif-ienumtunerequests-clone
    HRESULT Clone(IEnumTuneRequests* ppenum);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdatif/nn-bdatif-iguidedata
@GUID("61571138-5b01-43cd-aeaf-60b784a0bf93")
interface IGuideData : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdatif/nf-bdatif-iguidedata-getservices
    HRESULT GetServices(IEnumTuneRequests* ppEnumTuneRequests);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdatif/nf-bdatif-iguidedata-getserviceproperties
    HRESULT GetServiceProperties(ITuneRequest pTuneRequest, IEnumGuideDataProperties* ppEnumProperties);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdatif/nf-bdatif-iguidedata-getguideprogramids
    HRESULT GetGuideProgramIDs(IEnumVARIANT* pEnumPrograms);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdatif/nf-bdatif-iguidedata-getprogramproperties
    HRESULT GetProgramProperties(VARIANT varProgramDescriptionID, IEnumGuideDataProperties* ppEnumProperties);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdatif/nf-bdatif-iguidedata-getscheduleentryids
    HRESULT GetScheduleEntryIDs(IEnumVARIANT* pEnumScheduleEntries);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/bdatif/nf-bdatif-iguidedata-getscheduleentryproperties
    HRESULT GetScheduleEntryProperties(VARIANT varScheduleEntryDescriptionID, 
                                       IEnumGuideDataProperties* ppEnumProperties);
}

@GUID("4764ff7c-fa95-4525-af4d-d32236db9e38")
interface IGuideDataLoader : IUnknown
{
    HRESULT Init(IGuideData pGuideStore);
    HRESULT Terminate();
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
const GUID CLSID_BDANETWORKTYPE_ATSC                         = GUIDOF!BDANETWORKTYPE_ATSC;
const GUID CLSID_BDA_DEBUG_DATA_AVAILABLE                    = GUIDOF!BDA_DEBUG_DATA_AVAILABLE;
const GUID CLSID_BDA_DEBUG_DATA_TYPE_STRING                  = GUIDOF!BDA_DEBUG_DATA_TYPE_STRING;
const GUID CLSID_BSKYB_TERRESTRIAL_TV_NETWORK_TYPE           = GUIDOF!BSKYB_TERRESTRIAL_TV_NETWORK_TYPE;
const GUID CLSID_BroadcastEventService                       = GUIDOF!BroadcastEventService;
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
const GUID IID_IAtscContentAdvisoryDescriptor           = GUIDOF!IAtscContentAdvisoryDescriptor;
const GUID IID_IAtscPsipParser                          = GUIDOF!IAtscPsipParser;
const GUID IID_IAttributeGet                            = GUIDOF!IAttributeGet;
const GUID IID_IAttributeSet                            = GUIDOF!IAttributeSet;
const GUID IID_IAuxInTuningSpace                        = GUIDOF!IAuxInTuningSpace;
const GUID IID_IAuxInTuningSpace2                       = GUIDOF!IAuxInTuningSpace2;
const GUID IID_IBDAComparable                           = GUIDOF!IBDAComparable;
const GUID IID_IBDACreateTuneRequestEx                  = GUIDOF!IBDACreateTuneRequestEx;
const GUID IID_IBDA_TIF_REGISTRATION                    = GUIDOF!IBDA_TIF_REGISTRATION;
const GUID IID_ICAT                                     = GUIDOF!ICAT;
const GUID IID_ICaptionServiceDescriptor                = GUIDOF!ICaptionServiceDescriptor;
const GUID IID_IChannelIDTuneRequest                    = GUIDOF!IChannelIDTuneRequest;
const GUID IID_IChannelTuneRequest                      = GUIDOF!IChannelTuneRequest;
const GUID IID_IComponent                               = GUIDOF!IComponent;
const GUID IID_IComponentType                           = GUIDOF!IComponentType;
const GUID IID_IComponentTypes                          = GUIDOF!IComponentTypes;
const GUID IID_IComponents                              = GUIDOF!IComponents;
const GUID IID_IComponentsOld                           = GUIDOF!IComponentsOld;
const GUID IID_ICreatePropBagOnRegKey                   = GUIDOF!ICreatePropBagOnRegKey;
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
const GUID IID_IDigitalCableLocator                     = GUIDOF!IDigitalCableLocator;
const GUID IID_IDigitalCableTuneRequest                 = GUIDOF!IDigitalCableTuneRequest;
const GUID IID_IDigitalCableTuningSpace                 = GUIDOF!IDigitalCableTuningSpace;
const GUID IID_IDigitalLocator                          = GUIDOF!IDigitalLocator;
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
const GUID IID_IESCloseMmiEvent                         = GUIDOF!IESCloseMmiEvent;
const GUID IID_IESEventFactory                          = GUIDOF!IESEventFactory;
const GUID IID_IESEventService                          = GUIDOF!IESEventService;
const GUID IID_IESEventServiceConfiguration             = GUIDOF!IESEventServiceConfiguration;
const GUID IID_IESFileExpiryDateEvent                   = GUIDOF!IESFileExpiryDateEvent;
const GUID IID_IESIsdbCasResponseEvent                  = GUIDOF!IESIsdbCasResponseEvent;
const GUID IID_IESLicenseRenewalResultEvent             = GUIDOF!IESLicenseRenewalResultEvent;
const GUID IID_IESOpenMmiEvent                          = GUIDOF!IESOpenMmiEvent;
const GUID IID_IESRequestTunerEvent                     = GUIDOF!IESRequestTunerEvent;
const GUID IID_IESValueUpdatedEvent                     = GUIDOF!IESValueUpdatedEvent;
const GUID IID_IETFilter                                = GUIDOF!IETFilter;
const GUID IID_IETFilterConfig                          = GUIDOF!IETFilterConfig;
const GUID IID_IETFilterEvents                          = GUIDOF!IETFilterEvents;
const GUID IID_IEnumComponentTypes                      = GUIDOF!IEnumComponentTypes;
const GUID IID_IEnumComponents                          = GUIDOF!IEnumComponents;
const GUID IID_IEnumGuideDataProperties                 = GUIDOF!IEnumGuideDataProperties;
const GUID IID_IEnumMSVidGraphSegment                   = GUIDOF!IEnumMSVidGraphSegment;
const GUID IID_IEnumStreamBufferRecordingAttrib         = GUIDOF!IEnumStreamBufferRecordingAttrib;
const GUID IID_IEnumTuneRequests                        = GUIDOF!IEnumTuneRequests;
const GUID IID_IEnumTuningSpaces                        = GUIDOF!IEnumTuningSpaces;
const GUID IID_IEvalRat                                 = GUIDOF!IEvalRat;
const GUID IID_IGenericDescriptor                       = GUIDOF!IGenericDescriptor;
const GUID IID_IGenericDescriptor2                      = GUIDOF!IGenericDescriptor2;
const GUID IID_IGpnvsCommonBase                         = GUIDOF!IGpnvsCommonBase;
const GUID IID_IGuideData                               = GUIDOF!IGuideData;
const GUID IID_IGuideDataEvent                          = GUIDOF!IGuideDataEvent;
const GUID IID_IGuideDataLoader                         = GUIDOF!IGuideDataLoader;
const GUID IID_IGuideDataProperty                       = GUIDOF!IGuideDataProperty;
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
const GUID IID_ILanguageComponentType                   = GUIDOF!ILanguageComponentType;
const GUID IID_ILocator                                 = GUIDOF!ILocator;
const GUID IID_IMPEG2Component                          = GUIDOF!IMPEG2Component;
const GUID IID_IMPEG2ComponentType                      = GUIDOF!IMPEG2ComponentType;
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
const GUID IID_IMpeg2Data                               = GUIDOF!IMpeg2Data;
const GUID IID_IMpeg2Stream                             = GUIDOF!IMpeg2Stream;
const GUID IID_IMpeg2TableFilter                        = GUIDOF!IMpeg2TableFilter;
const GUID IID_IPAT                                     = GUIDOF!IPAT;
const GUID IID_IPBDAAttributesDescriptor                = GUIDOF!IPBDAAttributesDescriptor;
const GUID IID_IPBDAEntitlementDescriptor               = GUIDOF!IPBDAEntitlementDescriptor;
const GUID IID_IPBDASiParser                            = GUIDOF!IPBDASiParser;
const GUID IID_IPBDA_EIT                                = GUIDOF!IPBDA_EIT;
const GUID IID_IPBDA_Services                           = GUIDOF!IPBDA_Services;
const GUID IID_IPMT                                     = GUIDOF!IPMT;
const GUID IID_IPSITables                               = GUIDOF!IPSITables;
const GUID IID_IPTFilterLicenseRenewal                  = GUIDOF!IPTFilterLicenseRenewal;
const GUID IID_IPersistTuneXml                          = GUIDOF!IPersistTuneXml;
const GUID IID_IPersistTuneXmlUtility                   = GUIDOF!IPersistTuneXmlUtility;
const GUID IID_IPersistTuneXmlUtility2                  = GUIDOF!IPersistTuneXmlUtility2;
const GUID IID_IRegisterTuner                           = GUIDOF!IRegisterTuner;
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
const GUID IID_IXDSCodec                                = GUIDOF!IXDSCodec;
const GUID IID_IXDSCodecConfig                          = GUIDOF!IXDSCodecConfig;
const GUID IID_IXDSCodecEvents                          = GUIDOF!IXDSCodecEvents;
const GUID IID_IXDSToRat                                = GUIDOF!IXDSToRat;
const GUID IID__IMSVidCtlEvents                         = GUIDOF!_IMSVidCtlEvents;
