// Written in the D programming language.

module windows.win32.media.audio.xaudio2;

public import windows.core;
public import windows.win32.foundation : BOOL, HRESULT, PWSTR;
public import windows.win32.media.audio : AUDIO_STREAM_CATEGORY, WAVEFORMATEX;
public import windows.win32.system.com : IUnknown;

extern(Windows) @nogc nothrow:


// Enums


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xapo/ne-xapo-xapo_buffer_flags
alias XAPO_BUFFER_FLAGS = int;
enum : int
{
    XAPO_BUFFER_SILENT = 0x00000000,
    XAPO_BUFFER_VALID  = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2/ne-xaudio2-xaudio2_filter_type
alias XAUDIO2_FILTER_TYPE = int;
enum : int
{
    LowPassFilter         = 0x00000000,
    BandPassFilter        = 0x00000001,
    HighPassFilter        = 0x00000002,
    NotchFilter           = 0x00000003,
    LowPassOnePoleFilter  = 0x00000004,
    HighPassOnePoleFilter = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/hrtfapoapi/ne-hrtfapoapi-hrtfdirectivitytype
enum HrtfDirectivityType : int
{
    OmniDirectional = 0x00000000,
    Cardioid        = 0x00000001,
    Cone            = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/hrtfapoapi/ne-hrtfapoapi-hrtfenvironment
enum HrtfEnvironment : int
{
    Small    = 0x00000000,
    Medium   = 0x00000001,
    Large    = 0x00000002,
    Outdoors = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/hrtfapoapi/ne-hrtfapoapi-hrtfdistancedecaytype
enum HrtfDistanceDecayType : int
{
    NaturalDecay = 0x00000000,
    CustomDecay  = 0x00000001,
}

// Constants


enum uint FXEQ_MIN_FRAMERATE = 0x000055f0U;
enum uint FXEQ_MAX_FRAMERATE = 0x0000bb80U;
enum float FXEQ_MIN_FREQUENCY_CENTER = 0x1.4p+4;
enum float FXEQ_MAX_FREQUENCY_CENTER = 0x1.388p+14;

enum : float
{
    FXEQ_DEFAULT_FREQUENCY_CENTER_0 = 0x1.9p+6,
    FXEQ_DEFAULT_FREQUENCY_CENTER_1 = 0x1.9p+9,
    FXEQ_DEFAULT_FREQUENCY_CENTER_2 = 0x1.f4p+10,
    FXEQ_DEFAULT_FREQUENCY_CENTER_3 = 0x1.388p+13,
}

enum : float
{
    FXEQ_MIN_GAIN = 0x1.020c4ap-3,
    FXEQ_MAX_GAIN = 0x1.fc28f6p+2,
}

enum float FXEQ_DEFAULT_GAIN = 0x1p+0;
enum float FXEQ_MIN_BANDWIDTH = 0x1.99999ap-4;
enum float FXEQ_MAX_BANDWIDTH = 0x1p+1;
enum float FXEQ_DEFAULT_BANDWIDTH = 0x1p+0;

enum : uint
{
    FXMASTERINGLIMITER_MIN_RELEASE      = 0x00000001U,
    FXMASTERINGLIMITER_MAX_RELEASE      = 0x00000014U,
    FXMASTERINGLIMITER_DEFAULT_RELEASE  = 0x00000006U,
    FXMASTERINGLIMITER_MIN_LOUDNESS     = 0x00000001U,
    FXMASTERINGLIMITER_MAX_LOUDNESS     = 0x00000708U,
    FXMASTERINGLIMITER_DEFAULT_LOUDNESS = 0x000003e8U,
}

enum : float
{
    FXREVERB_MIN_DIFFUSION     = 0x0p+0,
    FXREVERB_MAX_DIFFUSION     = 0x1p+0,
    FXREVERB_DEFAULT_DIFFUSION = 0x1.ccccccp-1,
}

enum : float
{
    FXREVERB_MIN_ROOMSIZE     = 0x1.a36e2ep-14,
    FXREVERB_MAX_ROOMSIZE     = 0x1p+0,
    FXREVERB_DEFAULT_ROOMSIZE = 0x1.333334p-1,
}

enum : uint
{
    FXLOUDNESS_DEFAULT_MOMENTARY_MS = 0x00000190U,
    FXLOUDNESS_DEFAULT_SHORTTERM_MS = 0x00000bb8U,
}

enum float FXECHO_MIN_WETDRYMIX = 0x0p+0;
enum float FXECHO_MAX_WETDRYMIX = 0x1p+0;
enum float FXECHO_DEFAULT_WETDRYMIX = 0x1p-1;

enum : float
{
    FXECHO_MIN_FEEDBACK = 0x0p+0,
    FXECHO_MAX_FEEDBACK = 0x1p+0,
}

enum float FXECHO_DEFAULT_FEEDBACK = 0x1p-1;

enum : float
{
    FXECHO_MIN_DELAY     = 0x1p+0,
    FXECHO_MAX_DELAY     = 0x1.f4p+10,
    FXECHO_DEFAULT_DELAY = 0x1.f4p+8,
}

enum : const(wchar)*
{
    // Native encoding: ansi
    XAUDIO2_DLL_A  = "xaudio2_9.dll",
    XAUDIO2_DLL_W  = "xaudio2_9.dll",
    // Native encoding: ansi
    XAUDIO2D_DLL_A = "xaudio2_9d.dll",
    XAUDIO2D_DLL_W = "xaudio2_9d.dll",
    XAUDIO2_DLL    = "xaudio2_9.dll",
    XAUDIO2D_DLL   = "xaudio2_9d.dll",
}

enum : uint
{
    XAUDIO2_MAX_BUFFER_BYTES   = 0x80000000U,
    XAUDIO2_MAX_QUEUED_BUFFERS = 0x00000040U,
    XAUDIO2_MAX_BUFFERS_SYSTEM = 0x00000002U,
    XAUDIO2_MAX_AUDIO_CHANNELS = 0x00000040U,
}

enum uint XAUDIO2_MIN_SAMPLE_RATE = 0x000003e8U;
enum uint XAUDIO2_MAX_SAMPLE_RATE = 0x00030d40U;

enum : float
{
    XAUDIO2_MAX_VOLUME_LEVEL = 0x1p+24,
    XAUDIO2_MAX_FREQ_RATIO   = 0x1p+10,
}

enum float XAUDIO2_DEFAULT_FREQ_RATIO = 0x1p+1;

enum : float
{
    XAUDIO2_MAX_FILTER_ONEOVERQ  = 0x1.8p+0,
    XAUDIO2_MAX_FILTER_FREQUENCY = 0x1p+0,
}

enum : uint
{
    XAUDIO2_MAX_LOOP_COUNT                        = 0x000000feU,
    XAUDIO2_MAX_INSTANCES                         = 0x00000008U,
    XAUDIO2_MAX_RATIO_TIMES_RATE_XMA_MONO         = 0x000927c0U,
    XAUDIO2_MAX_RATIO_TIMES_RATE_XMA_MULTICHANNEL = 0x000493e0U,
}

enum : uint
{
    XAUDIO2_COMMIT_NOW     = 0x00000000U,
    XAUDIO2_COMMIT_ALL     = 0x00000000U,
    XAUDIO2_NO_LOOP_REGION = 0x00000000U,
}

enum uint XAUDIO2_LOOP_INFINITE = 0x000000ffU;

enum : uint
{
    XAUDIO2_DEFAULT_CHANNELS   = 0x00000000U,
    XAUDIO2_DEFAULT_SAMPLERATE = 0x00000000U,
}

enum uint XAUDIO2_DEBUG_ENGINE = 0x00000001U;

enum : uint
{
    XAUDIO2_VOICE_NOPITCH   = 0x00000002U,
    XAUDIO2_VOICE_NOSRC     = 0x00000004U,
    XAUDIO2_VOICE_USEFILTER = 0x00000008U,
}

enum : uint
{
    XAUDIO2_PLAY_TAILS    = 0x00000020U,
    XAUDIO2_END_OF_STREAM = 0x00000040U,
}

enum uint XAUDIO2_SEND_USEFILTER = 0x00000080U;
enum uint XAUDIO2_VOICE_NOSAMPLESPLAYED = 0x00000100U;
enum uint XAUDIO2_STOP_ENGINE_WHEN_IDLE = 0x00002000U;
enum uint XAUDIO2_1024_QUANTUM = 0x00008000U;
enum uint XAUDIO2_NO_VIRTUAL_AUDIO_CLIENT = 0x00010000U;

enum : float
{
    XAUDIO2_DEFAULT_FILTER_FREQUENCY = 0x1p+0,
    XAUDIO2_DEFAULT_FILTER_ONEOVERQ  = 0x1p+0,
}

enum : uint
{
    XAUDIO2_QUANTUM_NUMERATOR   = 0x00000001U,
    XAUDIO2_QUANTUM_DENOMINATOR = 0x00000064U,
}

enum uint FACILITY_XAUDIO2 = 0x00000896U;

enum : HRESULT
{
    XAUDIO2_E_INVALID_CALL         = HRESULT(0x88960001),
    XAUDIO2_E_XMA_DECODER_ERROR    = HRESULT(0x88960002),
    XAUDIO2_E_XAPO_CREATION_FAILED = HRESULT(0x88960003),
}

enum HRESULT XAUDIO2_E_DEVICE_INVALIDATED = HRESULT(0x88960004);

enum : uint
{
    Processor1  = 0x00000001U,
    Processor2  = 0x00000002U,
    Processor3  = 0x00000004U,
    Processor4  = 0x00000008U,
    Processor5  = 0x00000010U,
    Processor6  = 0x00000020U,
    Processor7  = 0x00000040U,
    Processor8  = 0x00000080U,
    Processor9  = 0x00000100U,
    Processor10 = 0x00000200U,
    Processor11 = 0x00000400U,
    Processor12 = 0x00000800U,
    Processor13 = 0x00001000U,
    Processor14 = 0x00002000U,
    Processor15 = 0x00004000U,
    Processor16 = 0x00008000U,
    Processor17 = 0x00010000U,
    Processor18 = 0x00020000U,
    Processor19 = 0x00040000U,
    Processor20 = 0x00080000U,
    Processor21 = 0x00100000U,
    Processor22 = 0x00200000U,
    Processor23 = 0x00400000U,
    Processor24 = 0x00800000U,
    Processor25 = 0x01000000U,
    Processor26 = 0x02000000U,
    Processor27 = 0x04000000U,
    Processor28 = 0x08000000U,
    Processor29 = 0x10000000U,
    Processor30 = 0x20000000U,
    Processor31 = 0x40000000U,
    Processor32 = 0x80000000U,
}

enum uint XAUDIO2_ANY_PROCESSOR = 0xffffffffU;
enum uint XAUDIO2_USE_DEFAULT_PROCESSOR = 0x00000000U;
enum uint XAUDIO2_DEFAULT_PROCESSOR = 0x00000001U;

enum : uint
{
    XAUDIO2_LOG_ERRORS     = 0x00000001U,
    XAUDIO2_LOG_WARNINGS   = 0x00000002U,
    XAUDIO2_LOG_INFO       = 0x00000004U,
    XAUDIO2_LOG_DETAIL     = 0x00000008U,
    XAUDIO2_LOG_API_CALLS  = 0x00000010U,
    XAUDIO2_LOG_FUNC_CALLS = 0x00000020U,
    XAUDIO2_LOG_TIMING     = 0x00000040U,
    XAUDIO2_LOG_LOCKS      = 0x00000080U,
    XAUDIO2_LOG_MEMORY     = 0x00000100U,
    XAUDIO2_LOG_STREAMING  = 0x00001000U,
}

enum : uint
{
    XAUDIO2FX_REVERB_MIN_FRAMERATE = 0x00004e20U,
    XAUDIO2FX_REVERB_MAX_FRAMERATE = 0x0000bb80U,
}

enum float XAUDIO2FX_REVERB_MIN_WET_DRY_MIX = 0x0p+0;

enum : uint
{
    XAUDIO2FX_REVERB_MIN_REFLECTIONS_DELAY  = 0x00000000U,
    XAUDIO2FX_REVERB_MIN_REVERB_DELAY       = 0x00000000U,
    XAUDIO2FX_REVERB_MIN_REAR_DELAY         = 0x00000000U,
    XAUDIO2FX_REVERB_MIN_7POINT1_SIDE_DELAY = 0x00000000U,
    XAUDIO2FX_REVERB_MIN_7POINT1_REAR_DELAY = 0x00000000U,
    XAUDIO2FX_REVERB_MIN_POSITION           = 0x00000000U,
    XAUDIO2FX_REVERB_MIN_DIFFUSION          = 0x00000000U,
    XAUDIO2FX_REVERB_MIN_LOW_EQ_GAIN        = 0x00000000U,
    XAUDIO2FX_REVERB_MIN_LOW_EQ_CUTOFF      = 0x00000000U,
    XAUDIO2FX_REVERB_MIN_HIGH_EQ_GAIN       = 0x00000000U,
    XAUDIO2FX_REVERB_MIN_HIGH_EQ_CUTOFF     = 0x00000000U,
}

enum : float
{
    XAUDIO2FX_REVERB_MIN_ROOM_FILTER_FREQ = 0x1.4p+4,
    XAUDIO2FX_REVERB_MIN_ROOM_FILTER_MAIN = -0x1.9p+6,
    XAUDIO2FX_REVERB_MIN_ROOM_FILTER_HF   = -0x1.9p+6,
    XAUDIO2FX_REVERB_MIN_REFLECTIONS_GAIN = -0x1.9p+6,
    XAUDIO2FX_REVERB_MIN_REVERB_GAIN      = -0x1.9p+6,
    XAUDIO2FX_REVERB_MIN_DECAY_TIME       = 0x1.99999ap-4,
    XAUDIO2FX_REVERB_MIN_DENSITY          = 0x0p+0,
    XAUDIO2FX_REVERB_MIN_ROOM_SIZE        = 0x0p+0,
    XAUDIO2FX_REVERB_MAX_WET_DRY_MIX      = 0x1.9p+6,
}

enum : uint
{
    XAUDIO2FX_REVERB_MAX_REFLECTIONS_DELAY  = 0x0000012cU,
    XAUDIO2FX_REVERB_MAX_REVERB_DELAY       = 0x00000055U,
    XAUDIO2FX_REVERB_MAX_REAR_DELAY         = 0x00000005U,
    XAUDIO2FX_REVERB_MAX_7POINT1_SIDE_DELAY = 0x00000005U,
    XAUDIO2FX_REVERB_MAX_7POINT1_REAR_DELAY = 0x00000014U,
    XAUDIO2FX_REVERB_MAX_POSITION           = 0x0000001eU,
    XAUDIO2FX_REVERB_MAX_DIFFUSION          = 0x0000000fU,
    XAUDIO2FX_REVERB_MAX_LOW_EQ_GAIN        = 0x0000000cU,
    XAUDIO2FX_REVERB_MAX_LOW_EQ_CUTOFF      = 0x00000009U,
    XAUDIO2FX_REVERB_MAX_HIGH_EQ_GAIN       = 0x00000008U,
    XAUDIO2FX_REVERB_MAX_HIGH_EQ_CUTOFF     = 0x0000000eU,
}

enum : float
{
    XAUDIO2FX_REVERB_MAX_ROOM_FILTER_FREQ = 0x1.388p+14,
    XAUDIO2FX_REVERB_MAX_ROOM_FILTER_MAIN = 0x0p+0,
    XAUDIO2FX_REVERB_MAX_ROOM_FILTER_HF   = 0x0p+0,
    XAUDIO2FX_REVERB_MAX_REFLECTIONS_GAIN = 0x1.4p+4,
    XAUDIO2FX_REVERB_MAX_REVERB_GAIN      = 0x1.4p+4,
    XAUDIO2FX_REVERB_MAX_DENSITY          = 0x1.9p+6,
    XAUDIO2FX_REVERB_MAX_ROOM_SIZE        = 0x1.9p+6,
    XAUDIO2FX_REVERB_DEFAULT_WET_DRY_MIX  = 0x1.9p+6,
}

enum : uint
{
    XAUDIO2FX_REVERB_DEFAULT_REFLECTIONS_DELAY  = 0x00000005U,
    XAUDIO2FX_REVERB_DEFAULT_REVERB_DELAY       = 0x00000005U,
    XAUDIO2FX_REVERB_DEFAULT_REAR_DELAY         = 0x00000005U,
    XAUDIO2FX_REVERB_DEFAULT_7POINT1_SIDE_DELAY = 0x00000005U,
    XAUDIO2FX_REVERB_DEFAULT_7POINT1_REAR_DELAY = 0x00000014U,
    XAUDIO2FX_REVERB_DEFAULT_POSITION           = 0x00000006U,
    XAUDIO2FX_REVERB_DEFAULT_POSITION_MATRIX    = 0x0000001bU,
    XAUDIO2FX_REVERB_DEFAULT_EARLY_DIFFUSION    = 0x00000008U,
    XAUDIO2FX_REVERB_DEFAULT_LATE_DIFFUSION     = 0x00000008U,
    XAUDIO2FX_REVERB_DEFAULT_LOW_EQ_GAIN        = 0x00000008U,
    XAUDIO2FX_REVERB_DEFAULT_LOW_EQ_CUTOFF      = 0x00000004U,
    XAUDIO2FX_REVERB_DEFAULT_HIGH_EQ_GAIN       = 0x00000008U,
    XAUDIO2FX_REVERB_DEFAULT_HIGH_EQ_CUTOFF     = 0x00000004U,
}

enum : float
{
    XAUDIO2FX_REVERB_DEFAULT_ROOM_FILTER_FREQ = 0x1.388p+12,
    XAUDIO2FX_REVERB_DEFAULT_ROOM_FILTER_MAIN = 0x0p+0,
    XAUDIO2FX_REVERB_DEFAULT_ROOM_FILTER_HF   = 0x0p+0,
    XAUDIO2FX_REVERB_DEFAULT_REFLECTIONS_GAIN = 0x0p+0,
    XAUDIO2FX_REVERB_DEFAULT_REVERB_GAIN      = 0x0p+0,
    XAUDIO2FX_REVERB_DEFAULT_DECAY_TIME       = 0x1p+0,
    XAUDIO2FX_REVERB_DEFAULT_DENSITY          = 0x1.9p+6,
    XAUDIO2FX_REVERB_DEFAULT_ROOM_SIZE        = 0x1.9p+6,
}

enum uint XAUDIO2FX_REVERB_DEFAULT_DISABLE_LATE_FIELD = 0x00000000U;
enum float HRTF_MAX_GAIN_LIMIT = 0x1.8p+3;

enum : float
{
    HRTF_MIN_GAIN_LIMIT          = -0x1.8p+6,
    HRTF_MIN_UNITY_GAIN_DISTANCE = 0x1.99999ap-5,
}

enum float HRTF_DEFAULT_UNITY_GAIN_DISTANCE = 0x1p+0;
enum uint FACILITY_XAPO = 0x00000897U;
enum HRESULT XAPO_E_FORMAT_UNSUPPORTED = HRESULT(0x88970001);
enum uint XAPO_MIN_CHANNELS = 0x00000001U;
enum uint XAPO_MAX_CHANNELS = 0x00000040U;
enum uint XAPO_MIN_FRAMERATE = 0x000003e8U;
enum uint XAPO_MAX_FRAMERATE = 0x00030d40U;
enum uint XAPO_REGISTRATION_STRING_LENGTH = 0x00000100U;
enum uint XAPO_FLAG_CHANNELS_MUST_MATCH = 0x00000001U;
enum uint XAPO_FLAG_FRAMERATE_MUST_MATCH = 0x00000002U;
enum uint XAPO_FLAG_BITSPERSAMPLE_MUST_MATCH = 0x00000004U;
enum uint XAPO_FLAG_BUFFERCOUNT_MUST_MATCH = 0x00000008U;

enum : uint
{
    XAPO_FLAG_INPLACE_REQUIRED  = 0x00000020U,
    XAPO_FLAG_INPLACE_SUPPORTED = 0x00000010U,
}

enum uint SPEAKER_MONO = 0x00000004U;
enum uint X3DAUDIO_HANDLE_BYTESIZE = 0x00000014U;

enum : float
{
    X3DAUDIO_PI             = 0x1.921fb6p+1,
    X3DAUDIO_2PI            = 0x1.921fb6p+2,
    X3DAUDIO_SPEED_OF_SOUND = 0x1.578p+8,
}

enum : uint
{
    X3DAUDIO_CALCULATE_MATRIX          = 0x00000001U,
    X3DAUDIO_CALCULATE_DELAY           = 0x00000002U,
    X3DAUDIO_CALCULATE_LPF_DIRECT      = 0x00000004U,
    X3DAUDIO_CALCULATE_LPF_REVERB      = 0x00000008U,
    X3DAUDIO_CALCULATE_REVERB          = 0x00000010U,
    X3DAUDIO_CALCULATE_DOPPLER         = 0x00000020U,
    X3DAUDIO_CALCULATE_EMITTER_ANGLE   = 0x00000040U,
    X3DAUDIO_CALCULATE_ZEROCENTER      = 0x00010000U,
    X3DAUDIO_CALCULATE_REDIRECT_TO_LFE = 0x00020000U,
}

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xapo/ns-xapo-xapo_registration_properties
struct XAPO_REGISTRATION_PROPERTIES
{
align (1):
    GUID       clsid;
    wchar[256] FriendlyName;
    wchar[256] CopyrightInfo;
    uint       MajorVersion;
    uint       MinorVersion;
    uint       Flags;
    uint       MinInputBufferCount;
    uint       MaxInputBufferCount;
    uint       MinOutputBufferCount;
    uint       MaxOutputBufferCount;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xapo/ns-xapo-xapo_lockforprocess_parameters
struct XAPO_LOCKFORPROCESS_PARAMETERS
{
align (1):
    const(WAVEFORMATEX)* pFormat;
    uint                 MaxFrameCount;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xapo/ns-xapo-xapo_process_buffer_parameters
struct XAPO_PROCESS_BUFFER_PARAMETERS
{
align (1):
    void*             pBuffer;
    XAPO_BUFFER_FLAGS BufferFlags;
    uint              ValidFrameCount;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xapofx/ns-xapofx-fxeq_parameters
struct FXEQ_PARAMETERS
{
align (1):
    float FrequencyCenter0;
    float Gain0;
    float Bandwidth0;
    float FrequencyCenter1;
    float Gain1;
    float Bandwidth1;
    float FrequencyCenter2;
    float Gain2;
    float Bandwidth2;
    float FrequencyCenter3;
    float Gain3;
    float Bandwidth3;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xapofx/ns-xapofx-fxmasteringlimiter_parameters
struct FXMASTERINGLIMITER_PARAMETERS
{
align (1):
    uint Release;
    uint Loudness;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xapofx/ns-xapofx-fxreverb_parameters
struct FXREVERB_PARAMETERS
{
align (1):
    float Diffusion;
    float RoomSize;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xapofx/ns-xapofx-fxecho_initdata
struct FXECHO_INITDATA
{
align (1):
    float MaxDelay;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xapofx/ns-xapofx-fxecho_parameters
struct FXECHO_PARAMETERS
{
align (1):
    float WetDryMix;
    float Feedback;
    float Delay;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2/ns-xaudio2-xaudio2_voice_details
struct XAUDIO2_VOICE_DETAILS
{
align (1):
    uint CreationFlags;
    uint ActiveFlags;
    uint InputChannels;
    uint InputSampleRate;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2/ns-xaudio2-xaudio2_send_descriptor
struct XAUDIO2_SEND_DESCRIPTOR
{
align (1):
    uint          Flags;
    IXAudio2Voice pOutputVoice;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2/ns-xaudio2-xaudio2_voice_sends
struct XAUDIO2_VOICE_SENDS
{
align (1):
    uint SendCount;
    XAUDIO2_SEND_DESCRIPTOR* pSends;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2/ns-xaudio2-xaudio2_effect_descriptor
struct XAUDIO2_EFFECT_DESCRIPTOR
{
align (1):
    IUnknown pEffect;
    BOOL     InitialState;
    uint     OutputChannels;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2/ns-xaudio2-xaudio2_effect_chain
struct XAUDIO2_EFFECT_CHAIN
{
align (1):
    uint EffectCount;
    XAUDIO2_EFFECT_DESCRIPTOR* pEffectDescriptors;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2/ns-xaudio2-xaudio2_filter_parameters
struct XAUDIO2_FILTER_PARAMETERS
{
align (1):
    XAUDIO2_FILTER_TYPE Type;
    float               Frequency;
    float               OneOverQ;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2/ns-xaudio2-xaudio2_buffer
struct XAUDIO2_BUFFER
{
align (1):
    uint          Flags;
    uint          AudioBytes;
    const(ubyte)* pAudioData;
    uint          PlayBegin;
    uint          PlayLength;
    uint          LoopBegin;
    uint          LoopLength;
    uint          LoopCount;
    void*         pContext;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2/ns-xaudio2-xaudio2_buffer_wma
struct XAUDIO2_BUFFER_WMA
{
align (1):
    const(uint)* pDecodedPacketCumulativeBytes;
    uint         PacketCount;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2/ns-xaudio2-xaudio2_voice_state
struct XAUDIO2_VOICE_STATE
{
align (1):
    void* pCurrentBufferContext;
    uint  BuffersQueued;
    ulong SamplesPlayed;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2/ns-xaudio2-xaudio2_performance_data
struct XAUDIO2_PERFORMANCE_DATA
{
align (1):
    ulong AudioCyclesSinceLastQuery;
    ulong TotalCyclesSinceLastQuery;
    uint  MinimumCyclesPerQuantum;
    uint  MaximumCyclesPerQuantum;
    uint  MemoryUsageInBytes;
    uint  CurrentLatencyInSamples;
    uint  GlitchesSinceEngineStarted;
    uint  ActiveSourceVoiceCount;
    uint  TotalSourceVoiceCount;
    uint  ActiveSubmixVoiceCount;
    uint  ActiveResamplerCount;
    uint  ActiveMatrixMixCount;
    uint  ActiveXmaSourceVoices;
    uint  ActiveXmaStreams;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2/ns-xaudio2-xaudio2_debug_configuration
struct XAUDIO2_DEBUG_CONFIGURATION
{
align (1):
    uint TraceMask;
    uint BreakMask;
    BOOL LogThreadID;
    BOOL LogFileline;
    BOOL LogFunctionName;
    BOOL LogTiming;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2fx/ns-xaudio2fx-xaudio2fx_volumemeter_levels
struct XAUDIO2FX_VOLUMEMETER_LEVELS
{
align (1):
    float* pPeakLevels;
    float* pRMSLevels;
    uint   ChannelCount;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2fx/ns-xaudio2fx-xaudio2fx_reverb_parameters
struct XAUDIO2FX_REVERB_PARAMETERS
{
align (1):
    float WetDryMix;
    uint  ReflectionsDelay;
    ubyte ReverbDelay;
    ubyte RearDelay;
    ubyte SideDelay;
    ubyte PositionLeft;
    ubyte PositionRight;
    ubyte PositionMatrixLeft;
    ubyte PositionMatrixRight;
    ubyte EarlyDiffusion;
    ubyte LateDiffusion;
    ubyte LowEQGain;
    ubyte LowEQCutoff;
    ubyte HighEQGain;
    ubyte HighEQCutoff;
    float RoomFilterFreq;
    float RoomFilterMain;
    float RoomFilterHF;
    float ReflectionsGain;
    float ReverbGain;
    float DecayTime;
    float Density;
    float RoomSize;
    BOOL  DisableLateField;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2fx/ns-xaudio2fx-xaudio2fx_reverb_i3dl2_parameters
struct XAUDIO2FX_REVERB_I3DL2_PARAMETERS
{
align (1):
    float WetDryMix;
    int   Room;
    int   RoomHF;
    float RoomRolloffFactor;
    float DecayTime;
    float DecayHFRatio;
    int   Reflections;
    float ReflectionsDelay;
    int   Reverb;
    float ReverbDelay;
    float Diffusion;
    float Density;
    float HFReference;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/hrtfapoapi/ns-hrtfapoapi-hrtfposition
struct HrtfPosition
{
    float x;
    float y;
    float z;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/hrtfapoapi/ns-hrtfapoapi-hrtforientation
struct HrtfOrientation
{
    float[9] element;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/hrtfapoapi/ns-hrtfapoapi-hrtfdirectivity
struct HrtfDirectivity
{
    HrtfDirectivityType type;
    float               scaling;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/hrtfapoapi/ns-hrtfapoapi-hrtfdirectivitycardioid
struct HrtfDirectivityCardioid
{
    HrtfDirectivity directivity;
    float           order;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/hrtfapoapi/ns-hrtfapoapi-hrtfdirectivitycone
struct HrtfDirectivityCone
{
    HrtfDirectivity directivity;
    float           innerAngle;
    float           outerAngle;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/hrtfapoapi/ns-hrtfapoapi-hrtfdistancedecay
struct HrtfDistanceDecay
{
    HrtfDistanceDecayType type;
    float maxGain;
    float minGain;
    float unityGainDistance;
    float cutoffDistance;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/hrtfapoapi/ns-hrtfapoapi-hrtfapoinit
struct HrtfApoInit
{
    HrtfDistanceDecay* distanceDecay;
    HrtfDirectivity*   directivity;
}

// Functions

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xapofx/nf-xapofx-createfx
@DllImport("XAudio2_8.dll")
HRESULT CreateFX(const(GUID)* clsid, IUnknown* pEffect, 
                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/const(void)* pInitDat, 
                 uint InitDataByteSize);

@DllImport("XAudio2_8.dll")
HRESULT XAudio2CreateWithVersionInfo(IXAudio2* ppXAudio2, uint Flags, uint XAudio2Processor, uint ntddiVersion);

@DllImport("XAudio2_8.dll")
HRESULT CreateAudioVolumeMeter(IUnknown* ppApo);

@DllImport("XAudio2_8.dll")
HRESULT CreateAudioReverb(IUnknown* ppApo);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/hrtfapoapi/nf-hrtfapoapi-createhrtfapo
@DllImport("HrtfApo.dll")
HRESULT CreateHrtfApo(const(HrtfApoInit)* init, IXAPO* xApo);


// Interfaces

// Microsoft documentation: https://learn.microsoft.com/windows/win32/xaudio2/fxeq-constants
@GUID("f5e01117-d6c4-485a-a3f5-695196f3dbfa")
struct FXEQ;

@GUID("c4137916-2be1-46fd-8599-441536f49856")
struct FXMasteringLimiter;

@GUID("7d9aca56-cb68-4807-b632-b137352e8596")
struct FXReverb;

@GUID("5039d740-f736-449a-84d3-a56202557b87")
struct FXEcho;

@GUID("4fc3b166-972a-40cf-bc37-7db03db2fba3")
struct AudioVolumeMeter;

@GUID("c2633b16-471b-4498-b8c5-4f0959e2ec09")
struct AudioReverb;

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xapo/nn-xapo-ixapo
@GUID("a410b984-9839-4819-a0be-2856ae6b3adb")
interface IXAPO : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xapo/nf-xapo-ixapo-getregistrationproperties
    HRESULT GetRegistrationProperties(XAPO_REGISTRATION_PROPERTIES** ppRegistrationProperties);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xapo/nf-xapo-ixapo-isinputformatsupported
    HRESULT IsInputFormatSupported(const(WAVEFORMATEX)* pOutputFormat, const(WAVEFORMATEX)* pRequestedInputFormat, 
                                   WAVEFORMATEX** ppSupportedInputFormat);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xapo/nf-xapo-ixapo-isoutputformatsupported
    HRESULT IsOutputFormatSupported(const(WAVEFORMATEX)* pInputFormat, const(WAVEFORMATEX)* pRequestedOutputFormat, 
                                    WAVEFORMATEX** ppSupportedOutputFormat);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xapo/nf-xapo-ixapo-initialize
    HRESULT Initialize(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pData, 
                       uint DataByteSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xapo/nf-xapo-ixapo-reset
    void    Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xapo/nf-xapo-ixapo-lockforprocess
    HRESULT LockForProcess(uint InputLockedParameterCount, 
                           const(XAPO_LOCKFORPROCESS_PARAMETERS)* pInputLockedParameters, 
                           uint OutputLockedParameterCount, 
                           const(XAPO_LOCKFORPROCESS_PARAMETERS)* pOutputLockedParameters);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xapo/nf-xapo-ixapo-unlockforprocess
    void    UnlockForProcess();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xapo/nf-xapo-ixapo-process
    void    Process(uint InputProcessParameterCount, 
                    const(XAPO_PROCESS_BUFFER_PARAMETERS)* pInputProcessParameters, uint OutputProcessParameterCount, 
                    XAPO_PROCESS_BUFFER_PARAMETERS* pOutputProcessParameters, BOOL IsEnabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xapo/nf-xapo-ixapo-calcinputframes
    uint    CalcInputFrames(uint OutputFrameCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xapo/nf-xapo-ixapo-calcoutputframes
    uint    CalcOutputFrames(uint InputFrameCount);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xapo/nn-xapo-ixapoparameters
@GUID("26d95c66-80f2-499a-ad54-5ae7f01c6d98")
interface IXAPOParameters : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xapo/nf-xapo-ixapoparameters-setparameters
    void SetParameters(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* pParameters, 
                       uint ParameterByteSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xapo/nf-xapo-ixapoparameters-getparameters
    void GetParameters(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* pParameters, 
                       uint ParameterByteSize);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2/nn-xaudio2-ixaudio2
@GUID("2b02e3cf-2e0b-4ec3-be45-1b2a3fe7210d")
interface IXAudio2 : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2/nf-xaudio2-ixaudio2-registerforcallbacks
    HRESULT RegisterForCallbacks(IXAudio2EngineCallback pCallback);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2/nf-xaudio2-ixaudio2-unregisterforcallbacks
    void    UnregisterForCallbacks(IXAudio2EngineCallback pCallback);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2/nf-xaudio2-ixaudio2-createsourcevoice
    HRESULT CreateSourceVoice(IXAudio2SourceVoice* ppSourceVoice, const(WAVEFORMATEX)* pSourceFormat, uint Flags, 
                              float MaxFrequencyRatio, IXAudio2VoiceCallback pCallback, 
                              const(XAUDIO2_VOICE_SENDS)* pSendList, const(XAUDIO2_EFFECT_CHAIN)* pEffectChain);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2/nf-xaudio2-ixaudio2-createsubmixvoice
    HRESULT CreateSubmixVoice(IXAudio2SubmixVoice* ppSubmixVoice, uint InputChannels, uint InputSampleRate, 
                              uint Flags, uint ProcessingStage, const(XAUDIO2_VOICE_SENDS)* pSendList, 
                              const(XAUDIO2_EFFECT_CHAIN)* pEffectChain);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2/nf-xaudio2-ixaudio2-createmasteringvoice
    HRESULT CreateMasteringVoice(IXAudio2MasteringVoice* ppMasteringVoice, uint InputChannels, 
                                 uint InputSampleRate, uint Flags, const(PWSTR) szDeviceId, 
                                 const(XAUDIO2_EFFECT_CHAIN)* pEffectChain, AUDIO_STREAM_CATEGORY StreamCategory);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2/nf-xaudio2-ixaudio2-startengine
    HRESULT StartEngine();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2/nf-xaudio2-ixaudio2-stopengine
    void    StopEngine();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2/nf-xaudio2-ixaudio2-commitchanges
    HRESULT CommitChanges(uint OperationSet);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2/nf-xaudio2-ixaudio2-getperformancedata
    void    GetPerformanceData(XAUDIO2_PERFORMANCE_DATA* pPerfData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2/nf-xaudio2-ixaudio2-setdebugconfiguration
    void    SetDebugConfiguration(const(XAUDIO2_DEBUG_CONFIGURATION)* pDebugConfiguration, 
                                  /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pReserved);
}

@GUID("84ac29bb-d619-44d2-b197-e4acf7df3ed6")
interface IXAudio2Extension : IUnknown
{
    void GetProcessingQuantum(uint* quantumNumerator, uint* quantumDenominator);
    void GetProcessor(uint* processor);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2/nn-xaudio2-ixaudio2voice
interface IXAudio2Voice
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2/nf-xaudio2-ixaudio2voice-getvoicedetails
    void    GetVoiceDetails(XAUDIO2_VOICE_DETAILS* pVoiceDetails);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2/nf-xaudio2-ixaudio2voice-setoutputvoices
    HRESULT SetOutputVoices(const(XAUDIO2_VOICE_SENDS)* pSendList);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2/nf-xaudio2-ixaudio2voice-seteffectchain
    HRESULT SetEffectChain(const(XAUDIO2_EFFECT_CHAIN)* pEffectChain);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2/nf-xaudio2-ixaudio2voice-enableeffect
    HRESULT EnableEffect(uint EffectIndex, uint OperationSet);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2/nf-xaudio2-ixaudio2voice-disableeffect
    HRESULT DisableEffect(uint EffectIndex, uint OperationSet);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2/nf-xaudio2-ixaudio2voice-geteffectstate
    void    GetEffectState(uint EffectIndex, BOOL* pEnabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2/nf-xaudio2-ixaudio2voice-seteffectparameters
    HRESULT SetEffectParameters(uint EffectIndex, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(void)* pParameters, 
                                uint ParametersByteSize, uint OperationSet);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2/nf-xaudio2-ixaudio2voice-geteffectparameters
    HRESULT GetEffectParameters(uint EffectIndex, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* pParameters, 
                                uint ParametersByteSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2/nf-xaudio2-ixaudio2voice-setfilterparameters
    HRESULT SetFilterParameters(const(XAUDIO2_FILTER_PARAMETERS)* pParameters, uint OperationSet);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2/nf-xaudio2-ixaudio2voice-getfilterparameters
    void    GetFilterParameters(XAUDIO2_FILTER_PARAMETERS* pParameters);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2/nf-xaudio2-ixaudio2voice-setoutputfilterparameters
    HRESULT SetOutputFilterParameters(IXAudio2Voice pDestinationVoice, 
                                      const(XAUDIO2_FILTER_PARAMETERS)* pParameters, uint OperationSet);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2/nf-xaudio2-ixaudio2voice-getoutputfilterparameters
    void    GetOutputFilterParameters(IXAudio2Voice pDestinationVoice, XAUDIO2_FILTER_PARAMETERS* pParameters);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2/nf-xaudio2-ixaudio2voice-setvolume
    HRESULT SetVolume(float Volume, uint OperationSet);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2/nf-xaudio2-ixaudio2voice-getvolume
    void    GetVolume(float* pVolume);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2/nf-xaudio2-ixaudio2voice-setchannelvolumes
    HRESULT SetChannelVolumes(uint Channels, const(float)* pVolumes, uint OperationSet);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2/nf-xaudio2-ixaudio2voice-getchannelvolumes
    void    GetChannelVolumes(uint Channels, float* pVolumes);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2/nf-xaudio2-ixaudio2voice-setoutputmatrix
    HRESULT SetOutputMatrix(IXAudio2Voice pDestinationVoice, uint SourceChannels, uint DestinationChannels, 
                            const(float)* pLevelMatrix, uint OperationSet);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2/nf-xaudio2-ixaudio2voice-getoutputmatrix
    void    GetOutputMatrix(IXAudio2Voice pDestinationVoice, uint SourceChannels, uint DestinationChannels, 
                            float* pLevelMatrix);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2/nf-xaudio2-ixaudio2voice-destroyvoice
    void    DestroyVoice();
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2/nn-xaudio2-ixaudio2sourcevoice
interface IXAudio2SourceVoice : IXAudio2Voice
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2/nf-xaudio2-ixaudio2sourcevoice-start
    HRESULT Start(uint Flags, uint OperationSet);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2/nf-xaudio2-ixaudio2sourcevoice-stop
    HRESULT Stop(uint Flags, uint OperationSet);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2/nf-xaudio2-ixaudio2sourcevoice-submitsourcebuffer
    HRESULT SubmitSourceBuffer(const(XAUDIO2_BUFFER)* pBuffer, const(XAUDIO2_BUFFER_WMA)* pBufferWMA);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2/nf-xaudio2-ixaudio2sourcevoice-flushsourcebuffers
    HRESULT FlushSourceBuffers();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2/nf-xaudio2-ixaudio2sourcevoice-discontinuity
    HRESULT Discontinuity();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2/nf-xaudio2-ixaudio2sourcevoice-exitloop
    HRESULT ExitLoop(uint OperationSet);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2/nf-xaudio2-ixaudio2sourcevoice-getstate
    void    GetState(XAUDIO2_VOICE_STATE* pVoiceState, uint Flags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2/nf-xaudio2-ixaudio2sourcevoice-setfrequencyratio
    HRESULT SetFrequencyRatio(float Ratio, uint OperationSet);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2/nf-xaudio2-ixaudio2sourcevoice-getfrequencyratio
    void    GetFrequencyRatio(float* pRatio);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2/nf-xaudio2-ixaudio2sourcevoice-setsourcesamplerate
    HRESULT SetSourceSampleRate(uint NewSourceSampleRate);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2/nn-xaudio2-ixaudio2submixvoice
interface IXAudio2SubmixVoice : IXAudio2Voice
{
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2/nn-xaudio2-ixaudio2masteringvoice
interface IXAudio2MasteringVoice : IXAudio2Voice
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2/nf-xaudio2-ixaudio2masteringvoice-getchannelmask
    HRESULT GetChannelMask(uint* pChannelmask);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2/nn-xaudio2-ixaudio2enginecallback
interface IXAudio2EngineCallback
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2/nf-xaudio2-ixaudio2enginecallback-onprocessingpassstart
    void OnProcessingPassStart();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2/nf-xaudio2-ixaudio2enginecallback-onprocessingpassend
    void OnProcessingPassEnd();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2/nf-xaudio2-ixaudio2enginecallback-oncriticalerror
    void OnCriticalError(HRESULT Error);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2/nn-xaudio2-ixaudio2voicecallback
interface IXAudio2VoiceCallback
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2/nf-xaudio2-ixaudio2voicecallback-onvoiceprocessingpassstart
    void OnVoiceProcessingPassStart(uint BytesRequired);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2/nf-xaudio2-ixaudio2voicecallback-onvoiceprocessingpassend
    void OnVoiceProcessingPassEnd();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2/nf-xaudio2-ixaudio2voicecallback-onstreamend
    void OnStreamEnd();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2/nf-xaudio2-ixaudio2voicecallback-onbufferstart
    void OnBufferStart(void* pBufferContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2/nf-xaudio2-ixaudio2voicecallback-onbufferend
    void OnBufferEnd(void* pBufferContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2/nf-xaudio2-ixaudio2voicecallback-onloopend
    void OnLoopEnd(void* pBufferContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/xaudio2/nf-xaudio2-ixaudio2voicecallback-onvoiceerror
    void OnVoiceError(void* pBufferContext, HRESULT Error);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/hrtfapoapi/nn-hrtfapoapi-ixapohrtfparameters
@GUID("15b3cd66-e9de-4464-b6e6-2bc3cf63d455")
interface IXAPOHrtfParameters : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/hrtfapoapi/nf-hrtfapoapi-ixapohrtfparameters-setsourceposition
    HRESULT SetSourcePosition(const(HrtfPosition)* position);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/hrtfapoapi/nf-hrtfapoapi-ixapohrtfparameters-setsourceorientation
    HRESULT SetSourceOrientation(const(HrtfOrientation)* orientation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/hrtfapoapi/nf-hrtfapoapi-ixapohrtfparameters-setsourcegain
    HRESULT SetSourceGain(float gain);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/hrtfapoapi/nf-hrtfapoapi-ixapohrtfparameters-setenvironment
    HRESULT SetEnvironment(HrtfEnvironment environment);
}


// GUIDs

const GUID CLSID_AudioReverb        = GUIDOF!AudioReverb;
const GUID CLSID_AudioVolumeMeter   = GUIDOF!AudioVolumeMeter;
const GUID CLSID_FXEQ               = GUIDOF!FXEQ;
const GUID CLSID_FXEcho             = GUIDOF!FXEcho;
const GUID CLSID_FXMasteringLimiter = GUIDOF!FXMasteringLimiter;
const GUID CLSID_FXReverb           = GUIDOF!FXReverb;

const GUID IID_IXAPO               = GUIDOF!IXAPO;
const GUID IID_IXAPOHrtfParameters = GUIDOF!IXAPOHrtfParameters;
const GUID IID_IXAPOParameters     = GUIDOF!IXAPOParameters;
const GUID IID_IXAudio2            = GUIDOF!IXAudio2;
const GUID IID_IXAudio2Extension   = GUIDOF!IXAudio2Extension;
