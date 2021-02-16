module windows.xaudio2;

public import windows.core;
public import windows.com : HRESULT, IUnknown;
public import windows.coreaudio : AUDIO_STREAM_CATEGORY;
public import windows.multimedia : WAVEFORMATEX;
public import windows.systemservices : BOOL;

extern(Windows):


// Enums


enum : int
{
    XAPO_BUFFER_SILENT = 0x00000000,
    XAPO_BUFFER_VALID  = 0x00000001,
}
alias XAPO_BUFFER_FLAGS = int;

enum : int
{
    LowPassFilter         = 0x00000000,
    BandPassFilter        = 0x00000001,
    HighPassFilter        = 0x00000002,
    NotchFilter           = 0x00000003,
    LowPassOnePoleFilter  = 0x00000004,
    HighPassOnePoleFilter = 0x00000005,
}
alias XAUDIO2_FILTER_TYPE = int;

enum HrtfDirectivityType : int
{
    OmniDirectional = 0x00000000,
    Cardioid        = 0x00000001,
    Cone            = 0x00000002,
}

enum HrtfEnvironment : int
{
    Small    = 0x00000000,
    Medium   = 0x00000001,
    Large    = 0x00000002,
    Outdoors = 0x00000003,
}

enum HrtfDistanceDecayType : int
{
    NaturalDecay = 0x00000000,
    CustomDecay  = 0x00000001,
}

// Structs


struct XAPO_REGISTRATION_PROPERTIES
{
align (1):
    GUID        clsid;
    ushort[256] FriendlyName;
    ushort[256] CopyrightInfo;
    uint        MajorVersion;
    uint        MinorVersion;
    uint        Flags;
    uint        MinInputBufferCount;
    uint        MaxInputBufferCount;
    uint        MinOutputBufferCount;
    uint        MaxOutputBufferCount;
}

struct XAPO_LOCKFORPROCESS_PARAMETERS
{
align (1):
    const(WAVEFORMATEX)* pFormat;
    uint                 MaxFrameCount;
}

struct XAPO_PROCESS_BUFFER_PARAMETERS
{
align (1):
    void*             pBuffer;
    XAPO_BUFFER_FLAGS BufferFlags;
    uint              ValidFrameCount;
}

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

struct FXMASTERINGLIMITER_PARAMETERS
{
align (1):
    uint Release;
    uint Loudness;
}

struct FXREVERB_PARAMETERS
{
align (1):
    float Diffusion;
    float RoomSize;
}

struct FXECHO_INITDATA
{
align (1):
    float MaxDelay;
}

struct FXECHO_PARAMETERS
{
align (1):
    float WetDryMix;
    float Feedback;
    float Delay;
}

struct XAUDIO2_VOICE_DETAILS
{
align (1):
    uint CreationFlags;
    uint ActiveFlags;
    uint InputChannels;
    uint InputSampleRate;
}

struct XAUDIO2_SEND_DESCRIPTOR
{
align (1):
    uint          Flags;
    IXAudio2Voice pOutputVoice;
}

struct XAUDIO2_VOICE_SENDS
{
align (1):
    uint SendCount;
    XAUDIO2_SEND_DESCRIPTOR* pSends;
}

struct XAUDIO2_EFFECT_DESCRIPTOR
{
align (1):
    IUnknown pEffect;
    BOOL     InitialState;
    uint     OutputChannels;
}

struct XAUDIO2_EFFECT_CHAIN
{
align (1):
    uint EffectCount;
    XAUDIO2_EFFECT_DESCRIPTOR* pEffectDescriptors;
}

struct XAUDIO2_FILTER_PARAMETERS
{
align (1):
    XAUDIO2_FILTER_TYPE Type;
    float               Frequency;
    float               OneOverQ;
}

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

struct XAUDIO2_BUFFER_WMA
{
align (1):
    const(uint)* pDecodedPacketCumulativeBytes;
    uint         PacketCount;
}

struct XAUDIO2_VOICE_STATE
{
align (1):
    void* pCurrentBufferContext;
    uint  BuffersQueued;
    ulong SamplesPlayed;
}

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

struct XAUDIO2FX_VOLUMEMETER_LEVELS
{
align (1):
    float* pPeakLevels;
    float* pRMSLevels;
    uint   ChannelCount;
}

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

struct HrtfPosition
{
    float x;
    float y;
    float z;
}

struct HrtfOrientation
{
    float[9] element;
}

struct HrtfDirectivity
{
    HrtfDirectivityType type;
    float               scaling;
}

struct HrtfDirectivityCardioid
{
    HrtfDirectivity directivity;
    float           order;
}

struct HrtfDirectivityCone
{
    HrtfDirectivity directivity;
    float           innerAngle;
    float           outerAngle;
}

struct HrtfDistanceDecay
{
    HrtfDistanceDecayType type;
    float maxGain;
    float minGain;
    float unityGainDistance;
    float cutoffDistance;
}

struct HrtfApoInit
{
    HrtfDistanceDecay* distanceDecay;
    HrtfDirectivity*   directivity;
}

// Functions

@DllImport("XAudio2_9")
HRESULT CreateFX(const(GUID)* clsid, IUnknown* pEffect, char* pInitDat, uint InitDataByteSize);

@DllImport("XAudio2_9")
HRESULT XAudio2CreateWithVersionInfo(IXAudio2* ppXAudio2, uint Flags, uint XAudio2Processor, uint ntddiVersion);

@DllImport("XAudio2_9")
HRESULT CreateAudioVolumeMeter(IUnknown* ppApo);

@DllImport("XAudio2_9")
HRESULT CreateAudioReverb(IUnknown* ppApo);

@DllImport("HrtfApo")
HRESULT CreateHrtfApo(const(HrtfApoInit)* init, IXAPO* xApo);


// Interfaces

@GUID("F5E01117-D6C4-485A-A3F5-695196F3DBFA")
struct FXEQ;

@GUID("C4137916-2BE1-46FD-8599-441536F49856")
struct FXMasteringLimiter;

@GUID("7D9ACA56-CB68-4807-B632-B137352E8596")
struct FXReverb;

@GUID("5039D740-F736-449A-84D3-A56202557B87")
struct FXEcho;

@GUID("4FC3B166-972A-40CF-BC37-7DB03DB2FBA3")
struct AudioVolumeMeter;

@GUID("C2633B16-471B-4498-B8C5-4F0959E2EC09")
struct AudioReverb;

@GUID("A410B984-9839-4819-A0BE-2856AE6B3ADB")
interface IXAPO : IUnknown
{
    HRESULT GetRegistrationProperties(XAPO_REGISTRATION_PROPERTIES** ppRegistrationProperties);
    HRESULT IsInputFormatSupported(const(WAVEFORMATEX)* pOutputFormat, const(WAVEFORMATEX)* pRequestedInputFormat, 
                                   WAVEFORMATEX** ppSupportedInputFormat);
    HRESULT IsOutputFormatSupported(const(WAVEFORMATEX)* pInputFormat, const(WAVEFORMATEX)* pRequestedOutputFormat, 
                                    WAVEFORMATEX** ppSupportedOutputFormat);
    HRESULT Initialize(char* pData, uint DataByteSize);
    void    Reset();
    HRESULT LockForProcess(uint InputLockedParameterCount, char* pInputLockedParameters, 
                           uint OutputLockedParameterCount, char* pOutputLockedParameters);
    void    UnlockForProcess();
    void    Process(uint InputProcessParameterCount, char* pInputProcessParameters, 
                    uint OutputProcessParameterCount, char* pOutputProcessParameters, BOOL IsEnabled);
    uint    CalcInputFrames(uint OutputFrameCount);
    uint    CalcOutputFrames(uint InputFrameCount);
}

@GUID("26D95C66-80F2-499A-AD54-5AE7F01C6D98")
interface IXAPOParameters : IUnknown
{
    void SetParameters(char* pParameters, uint ParameterByteSize);
    void GetParameters(char* pParameters, uint ParameterByteSize);
}

@GUID("2B02E3CF-2E0B-4EC3-BE45-1B2A3FE7210D")
interface IXAudio2 : IUnknown
{
    HRESULT RegisterForCallbacks(IXAudio2EngineCallback pCallback);
    void    UnregisterForCallbacks(IXAudio2EngineCallback pCallback);
    HRESULT CreateSourceVoice(IXAudio2SourceVoice* ppSourceVoice, const(WAVEFORMATEX)* pSourceFormat, uint Flags, 
                              float MaxFrequencyRatio, IXAudio2VoiceCallback pCallback, 
                              const(XAUDIO2_VOICE_SENDS)* pSendList, const(XAUDIO2_EFFECT_CHAIN)* pEffectChain);
    HRESULT CreateSubmixVoice(IXAudio2SubmixVoice* ppSubmixVoice, uint InputChannels, uint InputSampleRate, 
                              uint Flags, uint ProcessingStage, const(XAUDIO2_VOICE_SENDS)* pSendList, 
                              const(XAUDIO2_EFFECT_CHAIN)* pEffectChain);
    HRESULT CreateMasteringVoice(IXAudio2MasteringVoice* ppMasteringVoice, uint InputChannels, 
                                 uint InputSampleRate, uint Flags, const(wchar)* szDeviceId, 
                                 const(XAUDIO2_EFFECT_CHAIN)* pEffectChain, AUDIO_STREAM_CATEGORY StreamCategory);
    HRESULT StartEngine();
    void    StopEngine();
    HRESULT CommitChanges(uint OperationSet);
    void    GetPerformanceData(XAUDIO2_PERFORMANCE_DATA* pPerfData);
    void    SetDebugConfiguration(const(XAUDIO2_DEBUG_CONFIGURATION)* pDebugConfiguration, void* pReserved);
}

@GUID("84AC29BB-D619-44D2-B197-E4ACF7DF3ED6")
interface IXAudio2Extension : IUnknown
{
    void GetProcessingQuantum(uint* quantumNumerator, uint* quantumDenominator);
    void GetProcessor(uint* processor);
}

interface IXAudio2Voice
{
    void    GetVoiceDetails(XAUDIO2_VOICE_DETAILS* pVoiceDetails);
    HRESULT SetOutputVoices(const(XAUDIO2_VOICE_SENDS)* pSendList);
    HRESULT SetEffectChain(const(XAUDIO2_EFFECT_CHAIN)* pEffectChain);
    HRESULT EnableEffect(uint EffectIndex, uint OperationSet);
    HRESULT DisableEffect(uint EffectIndex, uint OperationSet);
    void    GetEffectState(uint EffectIndex, int* pEnabled);
    HRESULT SetEffectParameters(uint EffectIndex, char* pParameters, uint ParametersByteSize, uint OperationSet);
    HRESULT GetEffectParameters(uint EffectIndex, char* pParameters, uint ParametersByteSize);
    HRESULT SetFilterParameters(const(XAUDIO2_FILTER_PARAMETERS)* pParameters, uint OperationSet);
    void    GetFilterParameters(XAUDIO2_FILTER_PARAMETERS* pParameters);
    HRESULT SetOutputFilterParameters(IXAudio2Voice pDestinationVoice, 
                                      const(XAUDIO2_FILTER_PARAMETERS)* pParameters, uint OperationSet);
    void    GetOutputFilterParameters(IXAudio2Voice pDestinationVoice, XAUDIO2_FILTER_PARAMETERS* pParameters);
    HRESULT SetVolume(float Volume, uint OperationSet);
    void    GetVolume(float* pVolume);
    HRESULT SetChannelVolumes(uint Channels, char* pVolumes, uint OperationSet);
    void    GetChannelVolumes(uint Channels, char* pVolumes);
    HRESULT SetOutputMatrix(IXAudio2Voice pDestinationVoice, uint SourceChannels, uint DestinationChannels, 
                            char* pLevelMatrix, uint OperationSet);
    void    GetOutputMatrix(IXAudio2Voice pDestinationVoice, uint SourceChannels, uint DestinationChannels, 
                            char* pLevelMatrix);
    void    DestroyVoice();
}

interface IXAudio2SourceVoice : IXAudio2Voice
{
    HRESULT Start(uint Flags, uint OperationSet);
    HRESULT Stop(uint Flags, uint OperationSet);
    HRESULT SubmitSourceBuffer(const(XAUDIO2_BUFFER)* pBuffer, const(XAUDIO2_BUFFER_WMA)* pBufferWMA);
    HRESULT FlushSourceBuffers();
    HRESULT Discontinuity();
    HRESULT ExitLoop(uint OperationSet);
    void    GetState(XAUDIO2_VOICE_STATE* pVoiceState, uint Flags);
    HRESULT SetFrequencyRatio(float Ratio, uint OperationSet);
    void    GetFrequencyRatio(float* pRatio);
    HRESULT SetSourceSampleRate(uint NewSourceSampleRate);
}

interface IXAudio2SubmixVoice : IXAudio2Voice
{
}

interface IXAudio2MasteringVoice : IXAudio2Voice
{
    HRESULT GetChannelMask(uint* pChannelmask);
}

interface IXAudio2EngineCallback
{
    void OnProcessingPassStart();
    void OnProcessingPassEnd();
    void OnCriticalError(HRESULT Error);
}

interface IXAudio2VoiceCallback
{
    void OnVoiceProcessingPassStart(uint BytesRequired);
    void OnVoiceProcessingPassEnd();
    void OnStreamEnd();
    void OnBufferStart(void* pBufferContext);
    void OnBufferEnd(void* pBufferContext);
    void OnLoopEnd(void* pBufferContext);
    void OnVoiceError(void* pBufferContext, HRESULT Error);
}

@GUID("15B3CD66-E9DE-4464-B6E6-2BC3CF63D455")
interface IXAPOHrtfParameters : IUnknown
{
    HRESULT SetSourcePosition(const(HrtfPosition)* position);
    HRESULT SetSourceOrientation(const(HrtfOrientation)* orientation);
    HRESULT SetSourceGain(float gain);
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
