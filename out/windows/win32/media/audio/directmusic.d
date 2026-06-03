// Written in the D programming language.

module windows.win32.media.audio.directmusic;

public import windows.core;
public import windows.win32.foundation : BOOL, CHAR, HANDLE, HRESULT, HWND, PSTR,
                                         PWSTR;
public import windows.win32.media.audio.directsound : IDirectSound, IDirectSoundBuffer;
public import windows.win32.media.audio : HMIDI, WAVEFORMATEX;
public import windows.win32.media : IReferenceClock;
public import windows.win32.media.multimedia : MIDIOPENSTRMID;
public import windows.win32.system.com : IUnknown;
public import windows.win32.system.io : OVERLAPPED;

extern(Windows) @nogc nothrow:


// Enums


alias DMUS_CLOCKTYPE = int;
enum : int
{
    DMUS_CLOCK_SYSTEM = 0x00000000,
    DMUS_CLOCK_WAVE   = 0x00000001,
}

alias DSPROPERTY_DIRECTSOUNDDEVICE = int;
enum : int
{
    DSPROPERTY_DIRECTSOUNDDEVICE_WAVEDEVICEMAPPING_A = 0x00000001,
    DSPROPERTY_DIRECTSOUNDDEVICE_DESCRIPTION_1       = 0x00000002,
    DSPROPERTY_DIRECTSOUNDDEVICE_ENUMERATE_1         = 0x00000003,
    DSPROPERTY_DIRECTSOUNDDEVICE_WAVEDEVICEMAPPING_W = 0x00000004,
    DSPROPERTY_DIRECTSOUNDDEVICE_DESCRIPTION_A       = 0x00000005,
    DSPROPERTY_DIRECTSOUNDDEVICE_DESCRIPTION_W       = 0x00000006,
    DSPROPERTY_DIRECTSOUNDDEVICE_ENUMERATE_A         = 0x00000007,
    DSPROPERTY_DIRECTSOUNDDEVICE_ENUMERATE_W         = 0x00000008,
}

alias DIRECTSOUNDDEVICE_TYPE = int;
enum : int
{
    DIRECTSOUNDDEVICE_TYPE_EMULATED = 0x00000000,
    DIRECTSOUNDDEVICE_TYPE_VXD      = 0x00000001,
    DIRECTSOUNDDEVICE_TYPE_WDM      = 0x00000002,
}

alias DIRECTSOUNDDEVICE_DATAFLOW = int;
enum : int
{
    DIRECTSOUNDDEVICE_DATAFLOW_RENDER  = 0x00000000,
    DIRECTSOUNDDEVICE_DATAFLOW_CAPTURE = 0x00000001,
}

// Constants


enum : uint
{
    DMUS_MAX_DESCRIPTION = 0x00000080U,
    DMUS_MAX_DRIVER      = 0x00000080U,
}

enum : uint
{
    DMUS_EFFECT_NONE   = 0x00000000U,
    DMUS_EFFECT_REVERB = 0x00000001U,
    DMUS_EFFECT_CHORUS = 0x00000002U,
    DMUS_EFFECT_DELAY  = 0x00000004U,
}

enum : uint
{
    DMUS_PC_INPUTCLASS    = 0x00000000U,
    DMUS_PC_OUTPUTCLASS   = 0x00000001U,
    DMUS_PC_DLS           = 0x00000001U,
    DMUS_PC_EXTERNAL      = 0x00000002U,
    DMUS_PC_SOFTWARESYNTH = 0x00000004U,
}

enum uint DMUS_PC_MEMORYSIZEFIXED = 0x00000008U;

enum : uint
{
    DMUS_PC_GMINHARDWARE = 0x00000010U,
    DMUS_PC_GSINHARDWARE = 0x00000020U,
}

enum uint DMUS_PC_XGINHARDWARE = 0x00000040U;

enum : uint
{
    DMUS_PC_DIRECTSOUND  = 0x00000080U,
    DMUS_PC_SHAREABLE    = 0x00000100U,
    DMUS_PC_DLS2         = 0x00000200U,
    DMUS_PC_AUDIOPATH    = 0x00000400U,
    DMUS_PC_WAVE         = 0x00000800U,
    DMUS_PC_SYSTEMMEMORY = 0x7fffffffU,
}

enum : uint
{
    DMUS_PORT_WINMM_DRIVER    = 0x00000000U,
    DMUS_PORT_USER_MODE_SYNTH = 0x00000001U,
}

enum : uint
{
    DMUS_PORT_KERNEL_MODE         = 0x00000002U,
    DMUS_PORTPARAMS_VOICES        = 0x00000001U,
    DMUS_PORTPARAMS_CHANNELGROUPS = 0x00000002U,
    DMUS_PORTPARAMS_AUDIOCHANNELS = 0x00000004U,
    DMUS_PORTPARAMS_SAMPLERATE    = 0x00000008U,
    DMUS_PORTPARAMS_EFFECTS       = 0x00000020U,
    DMUS_PORTPARAMS_SHARE         = 0x00000040U,
    DMUS_PORTPARAMS_FEATURES      = 0x00000080U,
}

enum : uint
{
    DMUS_PORT_FEATURE_AUDIOPATH = 0x00000001U,
    DMUS_PORT_FEATURE_STREAMING = 0x00000002U,
}

enum : uint
{
    DMUS_SYNTHSTATS_VOICES        = 0x00000001U,
    DMUS_SYNTHSTATS_TOTAL_CPU     = 0x00000002U,
    DMUS_SYNTHSTATS_CPU_PER_VOICE = 0x00000004U,
    DMUS_SYNTHSTATS_LOST_NOTES    = 0x00000008U,
    DMUS_SYNTHSTATS_PEAK_VOLUME   = 0x00000010U,
    DMUS_SYNTHSTATS_FREE_MEMORY   = 0x00000020U,
    DMUS_SYNTHSTATS_SYSTEMMEMORY  = 0x7fffffffU,
}

enum uint DMUS_CLOCKF_GLOBAL = 0x00000001U;

enum : uint
{
    DSBUSID_FIRST_SPKR_LOC = 0x00000000U,
    DSBUSID_FRONT_LEFT     = 0x00000000U,
    DSBUSID_LEFT           = 0x00000000U,
    DSBUSID_FRONT_RIGHT    = 0x00000001U,
    DSBUSID_RIGHT          = 0x00000001U,
    DSBUSID_FRONT_CENTER   = 0x00000002U,
}

enum uint DSBUSID_LOW_FREQUENCY = 0x00000003U;

enum : uint
{
    DSBUSID_BACK_LEFT             = 0x00000004U,
    DSBUSID_BACK_RIGHT            = 0x00000005U,
    DSBUSID_FRONT_LEFT_OF_CENTER  = 0x00000006U,
    DSBUSID_FRONT_RIGHT_OF_CENTER = 0x00000007U,
}

enum : uint
{
    DSBUSID_BACK_CENTER      = 0x00000008U,
    DSBUSID_SIDE_LEFT        = 0x00000009U,
    DSBUSID_SIDE_RIGHT       = 0x0000000aU,
    DSBUSID_TOP_CENTER       = 0x0000000bU,
    DSBUSID_TOP_FRONT_LEFT   = 0x0000000cU,
    DSBUSID_TOP_FRONT_CENTER = 0x0000000dU,
    DSBUSID_TOP_FRONT_RIGHT  = 0x0000000eU,
    DSBUSID_TOP_BACK_LEFT    = 0x0000000fU,
    DSBUSID_TOP_BACK_CENTER  = 0x00000010U,
    DSBUSID_TOP_BACK_RIGHT   = 0x00000011U,
}

enum uint DSBUSID_LAST_SPKR_LOC = 0x00000011U;

enum : uint
{
    DSBUSID_REVERB_SEND = 0x00000040U,
    DSBUSID_CHORUS_SEND = 0x00000041U,
    DSBUSID_DYNAMIC_0   = 0x00000200U,
    DSBUSID_NULL        = 0xffffffffU,
}

enum uint DAUD_CRITICAL_VOICE_PRIORITY = 0xf0000000U;
enum uint DAUD_HIGH_VOICE_PRIORITY = 0xc0000000U;
enum uint DAUD_STANDARD_VOICE_PRIORITY = 0x80000000U;
enum uint DAUD_LOW_VOICE_PRIORITY = 0x40000000U;
enum uint DAUD_PERSIST_VOICE_PRIORITY = 0x10000000U;
enum uint DAUD_CHAN1_VOICE_PRIORITY_OFFSET = 0x0000000eU;
enum uint DAUD_CHAN2_VOICE_PRIORITY_OFFSET = 0x0000000dU;
enum uint DAUD_CHAN3_VOICE_PRIORITY_OFFSET = 0x0000000cU;
enum uint DAUD_CHAN4_VOICE_PRIORITY_OFFSET = 0x0000000bU;
enum uint DAUD_CHAN5_VOICE_PRIORITY_OFFSET = 0x0000000aU;
enum uint DAUD_CHAN6_VOICE_PRIORITY_OFFSET = 0x00000009U;
enum uint DAUD_CHAN7_VOICE_PRIORITY_OFFSET = 0x00000008U;
enum uint DAUD_CHAN8_VOICE_PRIORITY_OFFSET = 0x00000007U;
enum uint DAUD_CHAN9_VOICE_PRIORITY_OFFSET = 0x00000006U;
enum uint DAUD_CHAN10_VOICE_PRIORITY_OFFSET = 0x0000000fU;
enum uint DAUD_CHAN11_VOICE_PRIORITY_OFFSET = 0x00000005U;
enum uint DAUD_CHAN12_VOICE_PRIORITY_OFFSET = 0x00000004U;
enum uint DAUD_CHAN13_VOICE_PRIORITY_OFFSET = 0x00000003U;
enum uint DAUD_CHAN14_VOICE_PRIORITY_OFFSET = 0x00000002U;
enum uint DAUD_CHAN15_VOICE_PRIORITY_OFFSET = 0x00000001U;
enum uint DAUD_CHAN16_VOICE_PRIORITY_OFFSET = 0x00000000U;

enum : GUID
{
    CLSID_DirectMusic           = GUID("636b9f10-0c7d-11d1-95b2-0020afdc7421"),
    CLSID_DirectMusicCollection = GUID("480ff4b0-28b2-11d1-bef7-00c04fbf8fef"),
    CLSID_DirectMusicSynth      = GUID("58c2b4d0-46e7-11d1-89ac-00a0c9054129"),
}

enum : GUID
{
    GUID_DMUS_PROP_GM_Hardware        = GUID("178f2f24-c364-11d1-a760-0000f875ac12"),
    GUID_DMUS_PROP_GS_Hardware        = GUID("178f2f25-c364-11d1-a760-0000f875ac12"),
    GUID_DMUS_PROP_XG_Hardware        = GUID("178f2f26-c364-11d1-a760-0000f875ac12"),
    GUID_DMUS_PROP_XG_Capable         = GUID("6496aba1-61b0-11d2-afa6-00aa0024d8b6"),
    GUID_DMUS_PROP_GS_Capable         = GUID("6496aba2-61b0-11d2-afa6-00aa0024d8b6"),
    GUID_DMUS_PROP_DLS1               = GUID("178f2f27-c364-11d1-a760-0000f875ac12"),
    GUID_DMUS_PROP_DLS2               = GUID("f14599e5-4689-11d2-afa6-00aa0024d8b6"),
    GUID_DMUS_PROP_INSTRUMENT2        = GUID("865fd372-9f67-11d2-872a-00600893b1bd"),
    GUID_DMUS_PROP_SynthSink_DSOUND   = GUID("0aa97844-c877-11d1-870c-00600893b1bd"),
    GUID_DMUS_PROP_SynthSink_WAVE     = GUID("0aa97845-c877-11d1-870c-00600893b1bd"),
    GUID_DMUS_PROP_SampleMemorySize   = GUID("178f2f28-c364-11d1-a760-0000f875ac12"),
    GUID_DMUS_PROP_SamplePlaybackRate = GUID("2a91f713-a4bf-11d2-bbdf-00600833dbd8"),
    GUID_DMUS_PROP_WriteLatency       = GUID("268a0fa0-60f2-11d2-afa6-00aa0024d8b6"),
    GUID_DMUS_PROP_WritePeriod        = GUID("268a0fa1-60f2-11d2-afa6-00aa0024d8b6"),
    GUID_DMUS_PROP_MemorySize         = GUID("178f2f28-c364-11d1-a760-0000f875ac12"),
    GUID_DMUS_PROP_WavesReverb        = GUID("04cb5622-32e5-11d2-afa6-00aa0024d8b6"),
    GUID_DMUS_PROP_Effects            = GUID("cda8d611-684a-11d2-871e-00600893b1bd"),
    GUID_DMUS_PROP_LegacyCaps         = GUID("cfa7cdc2-00a1-11d2-aad5-0000f875ac12"),
    GUID_DMUS_PROP_Volume             = GUID("fedfae25-e46e-11d1-aace-0000f875ac12"),
}

enum uint DMUS_VOLUME_MAX = 0x000007d0U;
enum int DMUS_VOLUME_MIN = 0xffffb1e0;
enum uint DMUS_EVENT_STRUCTURED = 0x00000001U;

enum : uint
{
    DMUS_DOWNLOADINFO_INSTRUMENT       = 0x00000001U,
    DMUS_DOWNLOADINFO_WAVE             = 0x00000002U,
    DMUS_DOWNLOADINFO_INSTRUMENT2      = 0x00000003U,
    DMUS_DOWNLOADINFO_WAVEARTICULATION = 0x00000004U,
    DMUS_DOWNLOADINFO_STREAMINGWAVE    = 0x00000005U,
    DMUS_DOWNLOADINFO_ONESHOTWAVE      = 0x00000006U,
}

enum uint DMUS_DEFAULT_SIZE_OFFSETTABLE = 0x00000001U;
enum uint DMUS_INSTRUMENT_GM_INSTRUMENT = 0x00000001U;
enum uint DMUS_MIN_DATA_SIZE = 0x00000004U;

enum : uint
{
    CONN_SRC_NONE          = 0x00000000U,
    CONN_SRC_LFO           = 0x00000001U,
    CONN_SRC_KEYONVELOCITY = 0x00000002U,
    CONN_SRC_KEYNUMBER     = 0x00000003U,
    CONN_SRC_EG1           = 0x00000004U,
    CONN_SRC_EG2           = 0x00000005U,
    CONN_SRC_PITCHWHEEL    = 0x00000006U,
    CONN_SRC_CC1           = 0x00000081U,
    CONN_SRC_CC7           = 0x00000087U,
    CONN_SRC_CC10          = 0x0000008aU,
    CONN_SRC_CC11          = 0x0000008bU,
}

enum : uint
{
    CONN_DST_NONE           = 0x00000000U,
    CONN_DST_ATTENUATION    = 0x00000001U,
    CONN_DST_PITCH          = 0x00000003U,
    CONN_DST_PAN            = 0x00000004U,
    CONN_DST_LFO_FREQUENCY  = 0x00000104U,
    CONN_DST_LFO_STARTDELAY = 0x00000105U,
}

enum : uint
{
    CONN_DST_EG1_ATTACKTIME   = 0x00000206U,
    CONN_DST_EG1_DECAYTIME    = 0x00000207U,
    CONN_DST_EG1_RELEASETIME  = 0x00000209U,
    CONN_DST_EG1_SUSTAINLEVEL = 0x0000020aU,
    CONN_DST_EG2_ATTACKTIME   = 0x0000030aU,
    CONN_DST_EG2_DECAYTIME    = 0x0000030bU,
    CONN_DST_EG2_RELEASETIME  = 0x0000030dU,
    CONN_DST_EG2_SUSTAINLEVEL = 0x0000030eU,
}

enum : uint
{
    CONN_TRN_NONE    = 0x00000000U,
    CONN_TRN_CONCAVE = 0x00000001U,
}

enum uint F_INSTRUMENT_DRUMS = 0x80000000U;
enum uint F_RGN_OPTION_SELFNONEXCLUSIVE = 0x00000001U;

enum : int
{
    WAVELINK_CHANNEL_LEFT  = 0x00000001,
    WAVELINK_CHANNEL_RIGHT = 0x00000002,
}

enum uint F_WAVELINK_PHASE_MASTER = 0x00000001U;
enum int POOL_CUE_NULL = 0xffffffff;

enum : int
{
    F_WSMP_NO_TRUNCATION  = 0x00000001,
    F_WSMP_NO_COMPRESSION = 0x00000002,
}

enum uint WLOOP_TYPE_FORWARD = 0x00000000U;

enum : uint
{
    CONN_SRC_POLYPRESSURE    = 0x00000007U,
    CONN_SRC_CHANNELPRESSURE = 0x00000008U,
}

enum : uint
{
    CONN_SRC_VIBRATO      = 0x00000009U,
    CONN_SRC_MONOPRESSURE = 0x0000000aU,
    CONN_SRC_CC91         = 0x000000dbU,
    CONN_SRC_CC93         = 0x000000ddU,
}

enum : uint
{
    CONN_DST_GAIN           = 0x00000001U,
    CONN_DST_KEYNUMBER      = 0x00000005U,
    CONN_DST_LEFT           = 0x00000010U,
    CONN_DST_RIGHT          = 0x00000011U,
    CONN_DST_CENTER         = 0x00000012U,
    CONN_DST_LEFTREAR       = 0x00000013U,
    CONN_DST_RIGHTREAR      = 0x00000014U,
    CONN_DST_LFE_CHANNEL    = 0x00000015U,
    CONN_DST_CHORUS         = 0x00000080U,
    CONN_DST_REVERB         = 0x00000081U,
    CONN_DST_VIB_FREQUENCY  = 0x00000114U,
    CONN_DST_VIB_STARTDELAY = 0x00000115U,
}

enum : uint
{
    CONN_DST_EG1_DELAYTIME    = 0x0000020bU,
    CONN_DST_EG1_HOLDTIME     = 0x0000020cU,
    CONN_DST_EG1_SHUTDOWNTIME = 0x0000020dU,
    CONN_DST_EG2_DELAYTIME    = 0x0000030fU,
    CONN_DST_EG2_HOLDTIME     = 0x00000310U,
    CONN_DST_FILTER_CUTOFF    = 0x00000500U,
    CONN_DST_FILTER_Q         = 0x00000501U,
}

enum : uint
{
    CONN_TRN_CONVEX = 0x00000002U,
    CONN_TRN_SWITCH = 0x00000003U,
}

enum : uint
{
    DLS_CDL_AND            = 0x00000001U,
    DLS_CDL_OR             = 0x00000002U,
    DLS_CDL_XOR            = 0x00000003U,
    DLS_CDL_ADD            = 0x00000004U,
    DLS_CDL_SUBTRACT       = 0x00000005U,
    DLS_CDL_MULTIPLY       = 0x00000006U,
    DLS_CDL_DIVIDE         = 0x00000007U,
    DLS_CDL_LOGICAL_AND    = 0x00000008U,
    DLS_CDL_LOGICAL_OR     = 0x00000009U,
    DLS_CDL_LT             = 0x0000000aU,
    DLS_CDL_LE             = 0x0000000bU,
    DLS_CDL_GT             = 0x0000000cU,
    DLS_CDL_GE             = 0x0000000dU,
    DLS_CDL_EQ             = 0x0000000eU,
    DLS_CDL_NOT            = 0x0000000fU,
    DLS_CDL_CONST          = 0x00000010U,
    DLS_CDL_QUERY          = 0x00000011U,
    DLS_CDL_QUERYSUPPORTED = 0x00000012U,
}

enum uint WLOOP_TYPE_RELEASE = 0x00000002U;
enum uint F_WAVELINK_MULTICHANNEL = 0x00000002U;
enum GUID DLSID_GMInHardware = GUID("178f2f24-c364-11d1-a760-0000f875ac12");
enum GUID DLSID_GSInHardware = GUID("178f2f25-c364-11d1-a760-0000f875ac12");
enum GUID DLSID_XGInHardware = GUID("178f2f26-c364-11d1-a760-0000f875ac12");

enum : GUID
{
    DLSID_SupportsDLS1 = GUID("178f2f27-c364-11d1-a760-0000f875ac12"),
    DLSID_SupportsDLS2 = GUID("f14599e5-4689-11d2-afa6-00aa0024d8b6"),
}

enum GUID DLSID_SampleMemorySize = GUID("178f2f28-c364-11d1-a760-0000f875ac12");
enum GUID DLSID_ManufacturersID = GUID("b03e1181-8095-11d2-a1ef-00600833dbd8");
enum GUID DLSID_ProductID = GUID("b03e1182-8095-11d2-a1ef-00600833dbd8");
enum GUID DLSID_SamplePlaybackRate = GUID("2a91f713-a4bf-11d2-bbdf-00600833dbd8");
// Native encoding: ansi
enum const(wchar)* REGSTR_PATH_SOFTWARESYNTHS = "Software\\Microsoft\\DirectMusic\\SoftwareSynths";
enum uint REFRESH_F_LASTBUFFER = 0x00000001U;
enum GUID CLSID_DirectMusicSynthSink = GUID("aec17ce3-a514-11d1-afa6-00aa0024d8b6");

enum : GUID
{
    GUID_DMUS_PROP_SetSynthSink   = GUID("0a3a5ba5-37b6-11d2-b9f9-0000f875ac12"),
    GUID_DMUS_PROP_SinkUsesDSound = GUID("be208857-8952-11d2-ba1c-0000f875ac12"),
}

enum GUID CLSID_DirectSoundPrivate = GUID("11ab3ec0-25ec-11d1-a4d8-00c04fc28aca");
enum GUID DSPROPSETID_DirectSoundDevice = GUID("84624f82-25ec-11d1-a4d8-00c04fc28aca");
enum int DV_DVSD_NTSC_FRAMESIZE = 0x0001d4c0;
enum int DV_DVSD_PAL_FRAMESIZE = 0x00023280;
enum uint DV_SMCHN = 0x0000e000U;

enum : uint
{
    DV_AUDIOMODE = 0x00000f00U,
    DV_AUDIOSMP  = 0x38000000U,
    DV_AUDIOQU   = 0x07000000U,
}

enum uint DV_NTSCPAL = 0x00200000U;
enum uint DV_STYPE = 0x001f0000U;

enum : uint
{
    DV_NTSC          = 0x00000000U,
    DV_PAL           = 0x00000001U,
    DV_SD            = 0x00000000U,
    DV_HD            = 0x00000001U,
    DV_SL            = 0x00000002U,
    DV_CAP_AUD16Bits = 0x00000000U,
    DV_CAP_AUD12Bits = 0x00000001U,
}

enum uint SIZE_DVINFO = 0x00000020U;

// Callbacks

alias LPFNDIRECTSOUNDDEVICEENUMERATECALLBACK1 = BOOL function(DSPROPERTY_DIRECTSOUNDDEVICE_DESCRIPTION_1_DATA* param0, 
                                                              void* param1);
alias LPFNDIRECTSOUNDDEVICEENUMERATECALLBACKA = BOOL function(DSPROPERTY_DIRECTSOUNDDEVICE_DESCRIPTION_A_DATA* param0, 
                                                              void* param1);
alias LPFNDIRECTSOUNDDEVICEENUMERATECALLBACKW = BOOL function(DSPROPERTY_DIRECTSOUNDDEVICE_DESCRIPTION_W_DATA* param0, 
                                                              void* param1);

// Structs


struct DLSID
{
    uint     ulData1;
    ushort   usData2;
    ushort   usData3;
    ubyte[8] abData4;
}

struct DLSVERSION
{
    uint dwVersionMS;
    uint dwVersionLS;
}

struct CONNECTION
{
    ushort usSource;
    ushort usControl;
    ushort usDestination;
    ushort usTransform;
    int    lScale;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct CONNECTIONLIST
{
    uint cbSize;
    uint cConnections;
}

struct RGNRANGE
{
    ushort usLow;
    ushort usHigh;
}

struct MIDILOCALE
{
    uint ulBank;
    uint ulInstrument;
}

struct RGNHEADER
{
    RGNRANGE RangeKey;
    RGNRANGE RangeVelocity;
    ushort   fusOptions;
    ushort   usKeyGroup;
}

struct INSTHEADER
{
    uint       cRegions;
    MIDILOCALE Locale;
}

struct DLSHEADER
{
    uint cInstruments;
}

struct WAVELINK
{
    ushort fusOptions;
    ushort usPhaseGroup;
    uint   ulChannel;
    uint   ulTableIndex;
}

struct POOLCUE
{
    uint ulOffset;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct POOLTABLE
{
    uint cbSize;
    uint cCues;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct WSMPL
{
    uint   cbSize;
    ushort usUnityNote;
    short  sFineTune;
    int    lAttenuation;
    uint   fulOptions;
    uint   cSampleLoops;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct WLOOP
{
    uint cbSize;
    uint ulType;
    uint ulStart;
    uint ulLength;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct DMUS_DOWNLOADINFO
{
    uint dwDLType;
    uint dwDLId;
    uint dwNumOffsetTableEntries;
    uint cbSize;
}

struct DMUS_OFFSETTABLE
{
    uint[1] ulOffsetTable; // Flexible array
}

struct DMUS_INSTRUMENT
{
    uint ulPatch;
    uint ulFirstRegionIdx;
    uint ulGlobalArtIdx;
    uint ulFirstExtCkIdx;
    uint ulCopyrightIdx;
    uint ulFlags;
}

struct DMUS_REGION
{
    RGNRANGE RangeKey;
    RGNRANGE RangeVelocity;
    ushort   fusOptions;
    ushort   usKeyGroup;
    uint     ulRegionArtIdx;
    uint     ulNextRegionIdx;
    uint     ulFirstExtCkIdx;
    WAVELINK WaveLink;
    WSMPL    WSMP;
    WLOOP[1] WLOOP_; // Flexible array
}

struct DMUS_LFOPARAMS
{
    int pcFrequency;
    int tcDelay;
    int gcVolumeScale;
    int pcPitchScale;
    int gcMWToVolume;
    int pcMWToPitch;
}

struct DMUS_VEGPARAMS
{
    int tcAttack;
    int tcDecay;
    int ptSustain;
    int tcRelease;
    int tcVel2Attack;
    int tcKey2Decay;
}

struct DMUS_PEGPARAMS
{
    int tcAttack;
    int tcDecay;
    int ptSustain;
    int tcRelease;
    int tcVel2Attack;
    int tcKey2Decay;
    int pcRange;
}

struct DMUS_MSCPARAMS
{
    int ptDefaultPan;
}

struct DMUS_ARTICPARAMS
{
    DMUS_LFOPARAMS LFO;
    DMUS_VEGPARAMS VolEG;
    DMUS_PEGPARAMS PitchEG;
    DMUS_MSCPARAMS Misc;
}

struct DMUS_ARTICULATION
{
    uint ulArt1Idx;
    uint ulFirstExtCkIdx;
}

struct DMUS_ARTICULATION2
{
    uint ulArtIdx;
    uint ulFirstExtCkIdx;
    uint ulNextArtIdx;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct DMUS_EXTENSIONCHUNK
{
    uint     cbSize;
    uint     ulNextExtCkIdx;
    uint     ExtCkID;
    ubyte[4] byExtCk;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct DMUS_COPYRIGHT
{
    uint     cbSize;
    ubyte[4] byCopyright;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct DMUS_WAVEDATA
{
    uint     cbSize;
    ubyte[4] byData;
}

struct DMUS_WAVE
{
    uint         ulFirstExtCkIdx;
    uint         ulCopyrightIdx;
    uint         ulWaveDataIdx;
    WAVEFORMATEX WaveformatEx;
}

struct DMUS_NOTERANGE
{
    uint dwLowNote;
    uint dwHighNote;
}

struct DMUS_WAVEARTDL
{
    uint   ulDownloadIdIdx;
    uint   ulBus;
    uint   ulBuffers;
    uint   ulMasterDLId;
    ushort usOptions;
}

struct DMUS_WAVEDL
{
    uint cbWaveData;
}

struct DMUS_EVENTHEADER
{
align (4):
    uint cbEvent;
    uint dwChannelGroup;
    long rtDelta;
    uint dwFlags;
}

struct DMUS_BUFFERDESC
{
    uint dwSize;
    uint dwFlags;
    GUID guidBufferFormat;
    uint cbBuffer;
}

struct DMUS_PORTCAPS
{
    uint       dwSize;
    uint       dwFlags;
    GUID       guidPort;
    uint       dwClass;
    uint       dwType;
    uint       dwMemorySize;
    uint       dwMaxChannelGroups;
    uint       dwMaxVoices;
    uint       dwMaxAudioChannels;
    uint       dwEffectFlags;
    wchar[128] wszDescription;
}

struct DMUS_PORTPARAMS7
{
    uint dwSize;
    uint dwValidParams;
    uint dwVoices;
    uint dwChannelGroups;
    uint dwAudioChannels;
    uint dwSampleRate;
    uint dwEffectFlags;
    BOOL fShare;
}

struct DMUS_PORTPARAMS8
{
    uint dwSize;
    uint dwValidParams;
    uint dwVoices;
    uint dwChannelGroups;
    uint dwAudioChannels;
    uint dwSampleRate;
    uint dwEffectFlags;
    BOOL fShare;
    uint dwFeatures;
}

struct DMUS_SYNTHSTATS
{
    uint dwSize;
    uint dwValidStats;
    uint dwVoices;
    uint dwTotalCPU;
    uint dwCPUPerVoice;
    uint dwLostNotes;
    uint dwFreeMemory;
    int  lPeakVolume;
}

struct DMUS_SYNTHSTATS8
{
    uint dwSize;
    uint dwValidStats;
    uint dwVoices;
    uint dwTotalCPU;
    uint dwCPUPerVoice;
    uint dwLostNotes;
    uint dwFreeMemory;
    int  lPeakVolume;
    uint dwSynthMemUse;
}

struct DMUS_WAVES_REVERB_PARAMS
{
    float fInGain;
    float fReverbMix;
    float fReverbTime;
    float fHighFreqRTRatio;
}

struct DMUS_CLOCKINFO7
{
    uint           dwSize;
    DMUS_CLOCKTYPE ctType;
    GUID           guidClock;
    wchar[128]     wszDescription;
}

struct DMUS_CLOCKINFO8
{
    uint           dwSize;
    DMUS_CLOCKTYPE ctType;
    GUID           guidClock;
    wchar[128]     wszDescription;
    uint           dwFlags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dmusics/ns-dmusics-dmus_voice_state
struct DMUS_VOICE_STATE
{
    BOOL  bExists;
    ulong spPosition;
}

struct DSPROPERTY_DIRECTSOUNDDEVICE_WAVEDEVICEMAPPING_A_DATA
{
    PSTR DeviceName;
    DIRECTSOUNDDEVICE_DATAFLOW DataFlow;
    GUID DeviceId;
}

struct DSPROPERTY_DIRECTSOUNDDEVICE_WAVEDEVICEMAPPING_W_DATA
{
    PWSTR DeviceName;
    DIRECTSOUNDDEVICE_DATAFLOW DataFlow;
    GUID  DeviceId;
}

struct DSPROPERTY_DIRECTSOUNDDEVICE_DESCRIPTION_1_DATA
{
    GUID       DeviceId;
    CHAR[256]  DescriptionA;
    wchar[256] DescriptionW;
    CHAR[260]  ModuleA;
    wchar[260] ModuleW;
    DIRECTSOUNDDEVICE_TYPE Type;
    DIRECTSOUNDDEVICE_DATAFLOW DataFlow;
    uint       WaveDeviceId;
    uint       Devnode;
}

struct DSPROPERTY_DIRECTSOUNDDEVICE_DESCRIPTION_A_DATA
{
    DIRECTSOUNDDEVICE_TYPE Type;
    DIRECTSOUNDDEVICE_DATAFLOW DataFlow;
    GUID DeviceId;
    PSTR Description;
    PSTR Module;
    PSTR Interface;
    uint WaveDeviceId;
}

struct DSPROPERTY_DIRECTSOUNDDEVICE_DESCRIPTION_W_DATA
{
    DIRECTSOUNDDEVICE_TYPE Type;
    DIRECTSOUNDDEVICE_DATAFLOW DataFlow;
    GUID  DeviceId;
    PWSTR Description;
    PWSTR Module;
    PWSTR Interface;
    uint  WaveDeviceId;
}

struct DSPROPERTY_DIRECTSOUNDDEVICE_ENUMERATE_1_DATA
{
    LPFNDIRECTSOUNDDEVICEENUMERATECALLBACK1 Callback;
    void* Context;
}

struct DSPROPERTY_DIRECTSOUNDDEVICE_ENUMERATE_A_DATA
{
    LPFNDIRECTSOUNDDEVICEENUMERATECALLBACKA Callback;
    void* Context;
}

struct DSPROPERTY_DIRECTSOUNDDEVICE_ENUMERATE_W_DATA
{
    LPFNDIRECTSOUNDDEVICEENUMERATECALLBACKW Callback;
    void* Context;
}

struct DVAudInfo
{
    ubyte[2]  bAudStyle;
    ubyte[2]  bAudQu;
    ubyte     bNumAudPin;
    ushort[2] wAvgSamplesPerPinPerFrm;
    ushort    wBlkMode;
    ushort    wDIFMode;
    ushort    wBlkDiv;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmddk/ns-mmddk-mdevicecapsex
struct MDEVICECAPSEX
{
align (1):
    uint  cbSize;
    void* pCaps;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mmddk/ns-mmddk-midiopendesc
struct MIDIOPENDESC
{
align (1):
    HMIDI             hMidi;
    size_t            dwCallback;
    size_t            dwInstance;
    size_t            dnDevNode;
    uint              cIds;
    MIDIOPENSTRMID[1] rgIds; // Flexible array
}

// Interfaces

@GUID("6536115a-7b2d-11d2-ba18-0000f875ac12")
interface IDirectMusic : IUnknown
{
    HRESULT EnumPort(uint dwIndex, DMUS_PORTCAPS* pPortCaps);
    HRESULT CreateMusicBuffer(DMUS_BUFFERDESC* pBufferDesc, IDirectMusicBuffer* ppBuffer, IUnknown pUnkOuter);
    HRESULT CreatePort(const(GUID)* rclsidPort, DMUS_PORTPARAMS8* pPortParams, IDirectMusicPort* ppPort, 
                       IUnknown pUnkOuter);
    HRESULT EnumMasterClock(uint dwIndex, DMUS_CLOCKINFO8* lpClockInfo);
    HRESULT GetMasterClock(GUID* pguidClock, IReferenceClock* ppReferenceClock);
    HRESULT SetMasterClock(const(GUID)* rguidClock);
    HRESULT Activate(BOOL fEnable);
    HRESULT GetDefaultPort(GUID* pguidPort);
    HRESULT SetDirectSound(IDirectSound pDirectSound, HWND hWnd);
}

@GUID("2d3629f7-813d-4939-8508-f05c6b75fd97")
interface IDirectMusic8 : IDirectMusic
{
    HRESULT SetExternalMasterClock(IReferenceClock pClock);
}

@GUID("d2ac2878-b39b-11d1-8704-00600893b1bd")
interface IDirectMusicBuffer : IUnknown
{
    HRESULT Flush();
    HRESULT TotalTime(long* prtTime);
    HRESULT PackStructured(long rt, uint dwChannelGroup, uint dwChannelMessage);
    HRESULT PackUnstructured(long rt, uint dwChannelGroup, uint cb, ubyte* lpb);
    HRESULT ResetReadPtr();
    HRESULT GetNextEvent(long* prt, uint* pdwChannelGroup, uint* pdwLength, ubyte** ppData);
    HRESULT GetRawBufferPtr(ubyte** ppData);
    HRESULT GetStartTime(long* prt);
    HRESULT GetUsedBytes(uint* pcb);
    HRESULT GetMaxBytes(uint* pcb);
    HRESULT GetBufferFormat(GUID* pGuidFormat);
    HRESULT SetStartTime(long rt);
    HRESULT SetUsedBytes(uint cb);
}

@GUID("d2ac287d-b39b-11d1-8704-00600893b1bd")
interface IDirectMusicInstrument : IUnknown
{
    HRESULT GetPatch(uint* pdwPatch);
    HRESULT SetPatch(uint dwPatch);
}

@GUID("d2ac287e-b39b-11d1-8704-00600893b1bd")
interface IDirectMusicDownloadedInstrument : IUnknown
{
}

@GUID("d2ac287c-b39b-11d1-8704-00600893b1bd")
interface IDirectMusicCollection : IUnknown
{
    HRESULT GetInstrument(uint dwPatch, IDirectMusicInstrument* ppInstrument);
    HRESULT EnumInstrument(uint dwIndex, uint* pdwPatch, PWSTR pwszName, uint dwNameLen);
}

@GUID("d2ac287b-b39b-11d1-8704-00600893b1bd")
interface IDirectMusicDownload : IUnknown
{
    HRESULT GetBuffer(void** ppvBuffer, uint* pdwSize);
}

@GUID("d2ac287a-b39b-11d1-8704-00600893b1bd")
interface IDirectMusicPortDownload : IUnknown
{
    HRESULT GetBuffer(uint dwDLId, IDirectMusicDownload* ppIDMDownload);
    HRESULT AllocateBuffer(uint dwSize, IDirectMusicDownload* ppIDMDownload);
    HRESULT GetDLId(uint* pdwStartDLId, uint dwCount);
    HRESULT GetAppend(uint* pdwAppend);
    HRESULT Download(IDirectMusicDownload pIDMDownload);
    HRESULT Unload(IDirectMusicDownload pIDMDownload);
}

@GUID("08f2d8c9-37c2-11d2-b9f9-0000f875ac12")
interface IDirectMusicPort : IUnknown
{
    HRESULT PlayBuffer(IDirectMusicBuffer pBuffer);
    HRESULT SetReadNotificationHandle(HANDLE hEvent);
    HRESULT Read(IDirectMusicBuffer pBuffer);
    HRESULT DownloadInstrument(IDirectMusicInstrument pInstrument, 
                               IDirectMusicDownloadedInstrument* ppDownloadedInstrument, DMUS_NOTERANGE* pNoteRanges, 
                               uint dwNumNoteRanges);
    HRESULT UnloadInstrument(IDirectMusicDownloadedInstrument pDownloadedInstrument);
    HRESULT GetLatencyClock(IReferenceClock* ppClock);
    HRESULT GetRunningStats(DMUS_SYNTHSTATS* pStats);
    HRESULT Compact();
    HRESULT GetCaps(DMUS_PORTCAPS* pPortCaps);
    HRESULT DeviceIoControl(uint dwIoControlCode, void* lpInBuffer, uint nInBufferSize, void* lpOutBuffer, 
                            uint nOutBufferSize, uint* lpBytesReturned, OVERLAPPED* lpOverlapped);
    HRESULT SetNumChannelGroups(uint dwChannelGroups);
    HRESULT GetNumChannelGroups(uint* pdwChannelGroups);
    HRESULT Activate(BOOL fActive);
    HRESULT SetChannelPriority(uint dwChannelGroup, uint dwChannel, uint dwPriority);
    HRESULT GetChannelPriority(uint dwChannelGroup, uint dwChannel, uint* pdwPriority);
    HRESULT SetDirectSound(IDirectSound pDirectSound, IDirectSoundBuffer pDirectSoundBuffer);
    HRESULT GetFormat(WAVEFORMATEX* pWaveFormatEx, uint* pdwWaveFormatExSize, uint* pdwBufferSize);
}

@GUID("ced153e7-3606-11d2-b9f9-0000f875ac12")
interface IDirectMusicThru : IUnknown
{
    HRESULT ThruChannel(uint dwSourceChannelGroup, uint dwSourceChannel, uint dwDestinationChannelGroup, 
                        uint dwDestinationChannel, IDirectMusicPort pDestinationPort);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dmusics/nn-dmusics-idirectmusicsynth
@GUID("09823661-5c85-11d2-afa6-00aa0024d8b6")
interface IDirectMusicSynth : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dmusics/nf-dmusics-idirectmusicsynth-open
    HRESULT Open(DMUS_PORTPARAMS8* pPortParams);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dmusics/nf-dmusics-idirectmusicsynth-close
    HRESULT Close();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dmusics/nf-dmusics-idirectmusicsynth-setnumchannelgroups
    HRESULT SetNumChannelGroups(uint dwGroups);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dmusics/nf-dmusics-idirectmusicsynth-download
    HRESULT Download(HANDLE* phDownload, void* pvData, BOOL* pbFree);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dmusics/nf-dmusics-idirectmusicsynth-unload
    HRESULT Unload(HANDLE hDownload, ptrdiff_t lpFreeHandle, HANDLE hUserData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dmusics/nf-dmusics-idirectmusicsynth-playbuffer
    HRESULT PlayBuffer(long rt, ubyte* pbBuffer, uint cbBuffer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dmusics/nf-dmusics-idirectmusicsynth-getrunningstats
    HRESULT GetRunningStats(DMUS_SYNTHSTATS* pStats);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dmusics/nf-dmusics-idirectmusicsynth-getportcaps
    HRESULT GetPortCaps(DMUS_PORTCAPS* pCaps);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dmusics/nf-dmusics-idirectmusicsynth-setmasterclock
    HRESULT SetMasterClock(IReferenceClock pClock);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dmusics/nf-dmusics-idirectmusicsynth-getlatencyclock
    HRESULT GetLatencyClock(IReferenceClock* ppClock);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dmusics/nf-dmusics-idirectmusicsynth-activate
    HRESULT Activate(BOOL fEnable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dmusics/nf-dmusics-idirectmusicsynth-setsynthsink
    HRESULT SetSynthSink(IDirectMusicSynthSink pSynthSink);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dmusics/nf-dmusics-idirectmusicsynth-render
    HRESULT Render(short* pBuffer, uint dwLength, long llPosition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dmusics/nf-dmusics-idirectmusicsynth-setchannelpriority
    HRESULT SetChannelPriority(uint dwChannelGroup, uint dwChannel, uint dwPriority);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dmusics/nf-dmusics-idirectmusicsynth-getchannelpriority
    HRESULT GetChannelPriority(uint dwChannelGroup, uint dwChannel, uint* pdwPriority);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dmusics/nf-dmusics-idirectmusicsynth-getformat
    HRESULT GetFormat(WAVEFORMATEX* pWaveFormatEx, uint* pdwWaveFormatExSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dmusics/nf-dmusics-idirectmusicsynth-getappend
    HRESULT GetAppend(uint* pdwAppend);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dmusics/nn-dmusics-idirectmusicsynth8
@GUID("53cab625-2711-4c9f-9de7-1b7f925f6fc8")
interface IDirectMusicSynth8 : IDirectMusicSynth
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dmusics/nf-dmusics-idirectmusicsynth8-playvoice
    HRESULT PlayVoice(long rt, uint dwVoiceId, uint dwChannelGroup, uint dwChannel, uint dwDLId, int prPitch, 
                      int vrVolume, ulong stVoiceStart, ulong stLoopStart, ulong stLoopEnd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dmusics/nf-dmusics-idirectmusicsynth8-stopvoice
    HRESULT StopVoice(long rt, uint dwVoiceId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dmusics/nf-dmusics-idirectmusicsynth8-getvoicestate
    HRESULT GetVoiceState(uint* dwVoice, uint cbVoice, DMUS_VOICE_STATE* dwVoiceState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dmusics/nf-dmusics-idirectmusicsynth8-refresh
    HRESULT Refresh(uint dwDownloadID, uint dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dmusics/nf-dmusics-idirectmusicsynth8-assignchanneltobuses
    HRESULT AssignChannelToBuses(uint dwChannelGroup, uint dwChannel, uint* pdwBuses, uint cBuses);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dmusics/nn-dmusics-idirectmusicsynthsink
@GUID("09823663-5c85-11d2-afa6-00aa0024d8b6")
interface IDirectMusicSynthSink : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dmusics/nf-dmusics-idirectmusicsynthsink-init
    HRESULT Init(IDirectMusicSynth pSynth);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dmusics/nf-dmusics-idirectmusicsynthsink-setmasterclock
    HRESULT SetMasterClock(IReferenceClock pClock);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dmusics/nf-dmusics-idirectmusicsynthsink-getlatencyclock
    HRESULT GetLatencyClock(IReferenceClock* ppClock);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dmusics/nf-dmusics-idirectmusicsynthsink-activate
    HRESULT Activate(BOOL fEnable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dmusics/nf-dmusics-idirectmusicsynthsink-sampletoreftime
    HRESULT SampleToRefTime(long llSampleTime, long* prfTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dmusics/nf-dmusics-idirectmusicsynthsink-reftimetosample
    HRESULT RefTimeToSample(long rfTime, long* pllSampleTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dmusics/nf-dmusics-idirectmusicsynthsink-setdirectsound
    HRESULT SetDirectSound(IDirectSound pDirectSound, IDirectSoundBuffer pDirectSoundBuffer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dmusics/nf-dmusics-idirectmusicsynthsink-getdesiredbuffersize
    HRESULT GetDesiredBufferSize(uint* pdwBufferSizeInSamples);
}


// GUIDs


const GUID IID_IDirectMusic                     = GUIDOF!IDirectMusic;
const GUID IID_IDirectMusic8                    = GUIDOF!IDirectMusic8;
const GUID IID_IDirectMusicBuffer               = GUIDOF!IDirectMusicBuffer;
const GUID IID_IDirectMusicCollection           = GUIDOF!IDirectMusicCollection;
const GUID IID_IDirectMusicDownload             = GUIDOF!IDirectMusicDownload;
const GUID IID_IDirectMusicDownloadedInstrument = GUIDOF!IDirectMusicDownloadedInstrument;
const GUID IID_IDirectMusicInstrument           = GUIDOF!IDirectMusicInstrument;
const GUID IID_IDirectMusicPort                 = GUIDOF!IDirectMusicPort;
const GUID IID_IDirectMusicPortDownload         = GUIDOF!IDirectMusicPortDownload;
const GUID IID_IDirectMusicSynth                = GUIDOF!IDirectMusicSynth;
const GUID IID_IDirectMusicSynth8               = GUIDOF!IDirectMusicSynth8;
const GUID IID_IDirectMusicSynthSink            = GUIDOF!IDirectMusicSynthSink;
const GUID IID_IDirectMusicThru                 = GUIDOF!IDirectMusicThru;
