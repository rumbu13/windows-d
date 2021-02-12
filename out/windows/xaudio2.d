module windows.xaudio2;

public import system;
public import windows.com;
public import windows.coreaudio;
public import windows.multimedia;
public import windows.systemservices;

extern(Windows):

struct XAPO_REGISTRATION_PROPERTIES
{
    Guid clsid;
    ushort FriendlyName;
    ushort CopyrightInfo;
    uint MajorVersion;
    uint MinorVersion;
    uint Flags;
    uint MinInputBufferCount;
    uint MaxInputBufferCount;
    uint MinOutputBufferCount;
    uint MaxOutputBufferCount;
}

struct XAPO_LOCKFORPROCESS_PARAMETERS
{
    const(WAVEFORMATEX)* pFormat;
    uint MaxFrameCount;
}

enum XAPO_BUFFER_FLAGS
{
    XAPO_BUFFER_SILENT = 0,
    XAPO_BUFFER_VALID = 1,
}

struct XAPO_PROCESS_BUFFER_PARAMETERS
{
    void* pBuffer;
    XAPO_BUFFER_FLAGS BufferFlags;
    uint ValidFrameCount;
}

const GUID IID_IXAPO = {0xA410B984, 0x9839, 0x4819, [0xA0, 0xBE, 0x28, 0x56, 0xAE, 0x6B, 0x3A, 0xDB]};
@GUID(0xA410B984, 0x9839, 0x4819, [0xA0, 0xBE, 0x28, 0x56, 0xAE, 0x6B, 0x3A, 0xDB]);
interface IXAPO : IUnknown
{
    HRESULT GetRegistrationProperties(XAPO_REGISTRATION_PROPERTIES** ppRegistrationProperties);
    HRESULT IsInputFormatSupported(const(WAVEFORMATEX)* pOutputFormat, const(WAVEFORMATEX)* pRequestedInputFormat, WAVEFORMATEX** ppSupportedInputFormat);
    HRESULT IsOutputFormatSupported(const(WAVEFORMATEX)* pInputFormat, const(WAVEFORMATEX)* pRequestedOutputFormat, WAVEFORMATEX** ppSupportedOutputFormat);
    HRESULT Initialize(char* pData, uint DataByteSize);
    void Reset();
    HRESULT LockForProcess(uint InputLockedParameterCount, char* pInputLockedParameters, uint OutputLockedParameterCount, char* pOutputLockedParameters);
    void UnlockForProcess();
    void Process(uint InputProcessParameterCount, char* pInputProcessParameters, uint OutputProcessParameterCount, char* pOutputProcessParameters, BOOL IsEnabled);
    uint CalcInputFrames(uint OutputFrameCount);
    uint CalcOutputFrames(uint InputFrameCount);
}

const GUID IID_IXAPOParameters = {0x26D95C66, 0x80F2, 0x499A, [0xAD, 0x54, 0x5A, 0xE7, 0xF0, 0x1C, 0x6D, 0x98]};
@GUID(0x26D95C66, 0x80F2, 0x499A, [0xAD, 0x54, 0x5A, 0xE7, 0xF0, 0x1C, 0x6D, 0x98]);
interface IXAPOParameters : IUnknown
{
    void SetParameters(char* pParameters, uint ParameterByteSize);
    void GetParameters(char* pParameters, uint ParameterByteSize);
}

const GUID CLSID_FXEQ = {0xF5E01117, 0xD6C4, 0x485A, [0xA3, 0xF5, 0x69, 0x51, 0x96, 0xF3, 0xDB, 0xFA]};
@GUID(0xF5E01117, 0xD6C4, 0x485A, [0xA3, 0xF5, 0x69, 0x51, 0x96, 0xF3, 0xDB, 0xFA]);
struct FXEQ;

const GUID CLSID_FXMasteringLimiter = {0xC4137916, 0x2BE1, 0x46FD, [0x85, 0x99, 0x44, 0x15, 0x36, 0xF4, 0x98, 0x56]};
@GUID(0xC4137916, 0x2BE1, 0x46FD, [0x85, 0x99, 0x44, 0x15, 0x36, 0xF4, 0x98, 0x56]);
struct FXMasteringLimiter;

const GUID CLSID_FXReverb = {0x7D9ACA56, 0xCB68, 0x4807, [0xB6, 0x32, 0xB1, 0x37, 0x35, 0x2E, 0x85, 0x96]};
@GUID(0x7D9ACA56, 0xCB68, 0x4807, [0xB6, 0x32, 0xB1, 0x37, 0x35, 0x2E, 0x85, 0x96]);
struct FXReverb;

const GUID CLSID_FXEcho = {0x5039D740, 0xF736, 0x449A, [0x84, 0xD3, 0xA5, 0x62, 0x02, 0x55, 0x7B, 0x87]};
@GUID(0x5039D740, 0xF736, 0x449A, [0x84, 0xD3, 0xA5, 0x62, 0x02, 0x55, 0x7B, 0x87]);
struct FXEcho;

struct FXEQ_PARAMETERS
{
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
    uint Release;
    uint Loudness;
}

struct FXREVERB_PARAMETERS
{
    float Diffusion;
    float RoomSize;
}

struct FXECHO_INITDATA
{
    float MaxDelay;
}

struct FXECHO_PARAMETERS
{
    float WetDryMix;
    float Feedback;
    float Delay;
}

struct XAUDIO2_VOICE_DETAILS
{
    uint CreationFlags;
    uint ActiveFlags;
    uint InputChannels;
    uint InputSampleRate;
}

struct XAUDIO2_SEND_DESCRIPTOR
{
    uint Flags;
    IXAudio2Voice pOutputVoice;
}

struct XAUDIO2_VOICE_SENDS
{
    uint SendCount;
    XAUDIO2_SEND_DESCRIPTOR* pSends;
}

struct XAUDIO2_EFFECT_DESCRIPTOR
{
    IUnknown pEffect;
    BOOL InitialState;
    uint OutputChannels;
}

struct XAUDIO2_EFFECT_CHAIN
{
    uint EffectCount;
    XAUDIO2_EFFECT_DESCRIPTOR* pEffectDescriptors;
}

enum XAUDIO2_FILTER_TYPE
{
    LowPassFilter = 0,
    BandPassFilter = 1,
    HighPassFilter = 2,
    NotchFilter = 3,
    LowPassOnePoleFilter = 4,
    HighPassOnePoleFilter = 5,
}

struct XAUDIO2_FILTER_PARAMETERS
{
    XAUDIO2_FILTER_TYPE Type;
    float Frequency;
    float OneOverQ;
}

struct XAUDIO2_BUFFER
{
    uint Flags;
    uint AudioBytes;
    const(ubyte)* pAudioData;
    uint PlayBegin;
    uint PlayLength;
    uint LoopBegin;
    uint LoopLength;
    uint LoopCount;
    void* pContext;
}

struct XAUDIO2_BUFFER_WMA
{
    const(uint)* pDecodedPacketCumulativeBytes;
    uint PacketCount;
}

struct XAUDIO2_VOICE_STATE
{
    void* pCurrentBufferContext;
    uint BuffersQueued;
    ulong SamplesPlayed;
}

struct XAUDIO2_PERFORMANCE_DATA
{
    ulong AudioCyclesSinceLastQuery;
    ulong TotalCyclesSinceLastQuery;
    uint MinimumCyclesPerQuantum;
    uint MaximumCyclesPerQuantum;
    uint MemoryUsageInBytes;
    uint CurrentLatencyInSamples;
    uint GlitchesSinceEngineStarted;
    uint ActiveSourceVoiceCount;
    uint TotalSourceVoiceCount;
    uint ActiveSubmixVoiceCount;
    uint ActiveResamplerCount;
    uint ActiveMatrixMixCount;
    uint ActiveXmaSourceVoices;
    uint ActiveXmaStreams;
}

struct XAUDIO2_DEBUG_CONFIGURATION
{
    uint TraceMask;
    uint BreakMask;
    BOOL LogThreadID;
    BOOL LogFileline;
    BOOL LogFunctionName;
    BOOL LogTiming;
}

const GUID IID_IXAudio2 = {0x2B02E3CF, 0x2E0B, 0x4EC3, [0xBE, 0x45, 0x1B, 0x2A, 0x3F, 0xE7, 0x21, 0x0D]};
@GUID(0x2B02E3CF, 0x2E0B, 0x4EC3, [0xBE, 0x45, 0x1B, 0x2A, 0x3F, 0xE7, 0x21, 0x0D]);
interface IXAudio2 : IUnknown
{
    HRESULT RegisterForCallbacks(IXAudio2EngineCallback pCallback);
    void UnregisterForCallbacks(IXAudio2EngineCallback pCallback);
    HRESULT CreateSourceVoice(IXAudio2SourceVoice* ppSourceVoice, const(WAVEFORMATEX)* pSourceFormat, uint Flags, float MaxFrequencyRatio, IXAudio2VoiceCallback pCallback, const(XAUDIO2_VOICE_SENDS)* pSendList, const(XAUDIO2_EFFECT_CHAIN)* pEffectChain);
    HRESULT CreateSubmixVoice(IXAudio2SubmixVoice* ppSubmixVoice, uint InputChannels, uint InputSampleRate, uint Flags, uint ProcessingStage, const(XAUDIO2_VOICE_SENDS)* pSendList, const(XAUDIO2_EFFECT_CHAIN)* pEffectChain);
    HRESULT CreateMasteringVoice(IXAudio2MasteringVoice* ppMasteringVoice, uint InputChannels, uint InputSampleRate, uint Flags, const(wchar)* szDeviceId, const(XAUDIO2_EFFECT_CHAIN)* pEffectChain, AUDIO_STREAM_CATEGORY StreamCategory);
    HRESULT StartEngine();
    void StopEngine();
    HRESULT CommitChanges(uint OperationSet);
    void GetPerformanceData(XAUDIO2_PERFORMANCE_DATA* pPerfData);
    void SetDebugConfiguration(const(XAUDIO2_DEBUG_CONFIGURATION)* pDebugConfiguration, void* pReserved);
}

const GUID IID_IXAudio2Extension = {0x84AC29BB, 0xD619, 0x44D2, [0xB1, 0x97, 0xE4, 0xAC, 0xF7, 0xDF, 0x3E, 0xD6]};
@GUID(0x84AC29BB, 0xD619, 0x44D2, [0xB1, 0x97, 0xE4, 0xAC, 0xF7, 0xDF, 0x3E, 0xD6]);
interface IXAudio2Extension : IUnknown
{
    void GetProcessingQuantum(uint* quantumNumerator, uint* quantumDenominator);
    void GetProcessor(uint* processor);
}

interface IXAudio2Voice
{
    void GetVoiceDetails(XAUDIO2_VOICE_DETAILS* pVoiceDetails);
    HRESULT SetOutputVoices(const(XAUDIO2_VOICE_SENDS)* pSendList);
    HRESULT SetEffectChain(const(XAUDIO2_EFFECT_CHAIN)* pEffectChain);
    HRESULT EnableEffect(uint EffectIndex, uint OperationSet);
    HRESULT DisableEffect(uint EffectIndex, uint OperationSet);
    void GetEffectState(uint EffectIndex, int* pEnabled);
    HRESULT SetEffectParameters(uint EffectIndex, char* pParameters, uint ParametersByteSize, uint OperationSet);
    HRESULT GetEffectParameters(uint EffectIndex, char* pParameters, uint ParametersByteSize);
    HRESULT SetFilterParameters(const(XAUDIO2_FILTER_PARAMETERS)* pParameters, uint OperationSet);
    void GetFilterParameters(XAUDIO2_FILTER_PARAMETERS* pParameters);
    HRESULT SetOutputFilterParameters(IXAudio2Voice pDestinationVoice, const(XAUDIO2_FILTER_PARAMETERS)* pParameters, uint OperationSet);
    void GetOutputFilterParameters(IXAudio2Voice pDestinationVoice, XAUDIO2_FILTER_PARAMETERS* pParameters);
    HRESULT SetVolume(float Volume, uint OperationSet);
    void GetVolume(float* pVolume);
    HRESULT SetChannelVolumes(uint Channels, char* pVolumes, uint OperationSet);
    void GetChannelVolumes(uint Channels, char* pVolumes);
    HRESULT SetOutputMatrix(IXAudio2Voice pDestinationVoice, uint SourceChannels, uint DestinationChannels, char* pLevelMatrix, uint OperationSet);
    void GetOutputMatrix(IXAudio2Voice pDestinationVoice, uint SourceChannels, uint DestinationChannels, char* pLevelMatrix);
    void DestroyVoice();
}

interface IXAudio2SourceVoice : IXAudio2Voice
{
    HRESULT Start(uint Flags, uint OperationSet);
    HRESULT Stop(uint Flags, uint OperationSet);
    HRESULT SubmitSourceBuffer(const(XAUDIO2_BUFFER)* pBuffer, const(XAUDIO2_BUFFER_WMA)* pBufferWMA);
    HRESULT FlushSourceBuffers();
    HRESULT Discontinuity();
    HRESULT ExitLoop(uint OperationSet);
    void GetState(XAUDIO2_VOICE_STATE* pVoiceState, uint Flags);
    HRESULT SetFrequencyRatio(float Ratio, uint OperationSet);
    void GetFrequencyRatio(float* pRatio);
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

const GUID CLSID_AudioVolumeMeter = {0x4FC3B166, 0x972A, 0x40CF, [0xBC, 0x37, 0x7D, 0xB0, 0x3D, 0xB2, 0xFB, 0xA3]};
@GUID(0x4FC3B166, 0x972A, 0x40CF, [0xBC, 0x37, 0x7D, 0xB0, 0x3D, 0xB2, 0xFB, 0xA3]);
struct AudioVolumeMeter;

const GUID CLSID_AudioReverb = {0xC2633B16, 0x471B, 0x4498, [0xB8, 0xC5, 0x4F, 0x09, 0x59, 0xE2, 0xEC, 0x09]};
@GUID(0xC2633B16, 0x471B, 0x4498, [0xB8, 0xC5, 0x4F, 0x09, 0x59, 0xE2, 0xEC, 0x09]);
struct AudioReverb;

struct XAUDIO2FX_VOLUMEMETER_LEVELS
{
    float* pPeakLevels;
    float* pRMSLevels;
    uint ChannelCount;
}

struct XAUDIO2FX_REVERB_PARAMETERS
{
    float WetDryMix;
    uint ReflectionsDelay;
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
    BOOL DisableLateField;
}

struct XAUDIO2FX_REVERB_I3DL2_PARAMETERS
{
    float WetDryMix;
    int Room;
    int RoomHF;
    float RoomRolloffFactor;
    float DecayTime;
    float DecayHFRatio;
    int Reflections;
    float ReflectionsDelay;
    int Reverb;
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
    float element;
}

enum HrtfDirectivityType
{
    OmniDirectional = 0,
    Cardioid = 1,
    Cone = 2,
}

enum HrtfEnvironment
{
    Small = 0,
    Medium = 1,
    Large = 2,
    Outdoors = 3,
}

struct HrtfDirectivity
{
    HrtfDirectivityType type;
    float scaling;
}

struct HrtfDirectivityCardioid
{
    HrtfDirectivity directivity;
    float order;
}

struct HrtfDirectivityCone
{
    HrtfDirectivity directivity;
    float innerAngle;
    float outerAngle;
}

enum HrtfDistanceDecayType
{
    NaturalDecay = 0,
    CustomDecay = 1,
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
    HrtfDirectivity* directivity;
}

const GUID IID_IXAPOHrtfParameters = {0x15B3CD66, 0xE9DE, 0x4464, [0xB6, 0xE6, 0x2B, 0xC3, 0xCF, 0x63, 0xD4, 0x55]};
@GUID(0x15B3CD66, 0xE9DE, 0x4464, [0xB6, 0xE6, 0x2B, 0xC3, 0xCF, 0x63, 0xD4, 0x55]);
interface IXAPOHrtfParameters : IUnknown
{
    HRESULT SetSourcePosition(const(HrtfPosition)* position);
    HRESULT SetSourceOrientation(const(HrtfOrientation)* orientation);
    HRESULT SetSourceGain(float gain);
    HRESULT SetEnvironment(HrtfEnvironment environment);
}

@DllImport("XAudio2_9.dll")
HRESULT CreateFX(const(Guid)* clsid, IUnknown* pEffect, char* pInitDat, uint InitDataByteSize);

@DllImport("XAudio2_9.dll")
HRESULT XAudio2CreateWithVersionInfo(IXAudio2* ppXAudio2, uint Flags, uint XAudio2Processor, uint ntddiVersion);

@DllImport("XAudio2_9.dll")
HRESULT CreateAudioVolumeMeter(IUnknown* ppApo);

@DllImport("XAudio2_9.dll")
HRESULT CreateAudioReverb(IUnknown* ppApo);

@DllImport("HrtfApo.dll")
HRESULT CreateHrtfApo(const(HrtfApoInit)* init, IXAPO* xApo);

