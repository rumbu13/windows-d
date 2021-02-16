module windows.audio;

public import windows.core;
public import windows.com : HRESULT, IUnknown;
public import windows.coreaudio : IMMDeviceCollection, KSP_PIN;
public import windows.directshow : IReferenceClock;
public import windows.multimedia : WAVEFORMATEX, midiopenstrmid_tag;
public import windows.remotedesktopservices : APO_CONNECTION_PROPERTY;
public import windows.structuredstorage : PROPVARIANT;
public import windows.systemservices : BOOL, D3DVECTOR, HANDLE, OVERLAPPED;
public import windows.windowsandmessaging : HWND, LPARAM;
public import windows.windowspropertiessystem : PROPERTYKEY;

extern(Windows):


// Enums


enum : int
{
    APO_CONNECTION_BUFFER_TYPE_ALLOCATED = 0x00000000,
    APO_CONNECTION_BUFFER_TYPE_EXTERNAL  = 0x00000001,
    APO_CONNECTION_BUFFER_TYPE_DEPENDANT = 0x00000002,
}
alias APO_CONNECTION_BUFFER_TYPE = int;

enum : int
{
    APO_FLAG_NONE                       = 0x00000000,
    APO_FLAG_INPLACE                    = 0x00000001,
    APO_FLAG_SAMPLESPERFRAME_MUST_MATCH = 0x00000002,
    APO_FLAG_FRAMESPERSECOND_MUST_MATCH = 0x00000004,
    APO_FLAG_BITSPERSAMPLE_MUST_MATCH   = 0x00000008,
    APO_FLAG_MIXER                      = 0x00000010,
    APO_FLAG_DEFAULT                    = 0x0000000e,
}
alias APO_FLAG = int;

enum : int
{
    AUDIO_FLOW_PULL = 0x00000000,
    AUDIO_FLOW_PUSH = 0x00000001,
}
alias AUDIO_FLOW_TYPE = int;

enum EAudioConstriction : int
{
    eAudioConstrictionOff   = 0x00000000,
    eAudioConstriction48_16 = 0x00000001,
    eAudioConstriction44_16 = 0x00000002,
    eAudioConstriction14_14 = 0x00000003,
    eAudioConstrictionMute  = 0x00000004,
}

enum : int
{
    DMUS_CLOCK_SYSTEM = 0x00000000,
    DMUS_CLOCK_WAVE   = 0x00000001,
}
alias DMUS_CLOCKTYPE = int;

enum : int
{
    KSPROPERTY_AUDIOEFFECTSDISCOVERY_EFFECTSLIST = 0x00000001,
}
alias KSPROPERTY_AUDIOEFFECTSDISCOVERY = int;

// Constants


enum : int
{
    DSFXR_PRESENT     = 0x00000000,
    DSFXR_LOCHARDWARE = 0x00000001,
    DSFXR_LOCSOFTWARE = 0x00000002,
}

enum : int
{
    DSFXR_FAILED   = 0x00000004,
    DSFXR_UNKNOWN  = 0x00000005,
    DSFXR_SENDLOOP = 0x00000006,
}

enum : int
{
    DSFX_I3DL2_MATERIAL_PRESET_DOUBLEWINDOW = 0x00000001,
    DSFX_I3DL2_MATERIAL_PRESET_THINDOOR     = 0x00000002,
    DSFX_I3DL2_MATERIAL_PRESET_THICKDOOR    = 0x00000003,
    DSFX_I3DL2_MATERIAL_PRESET_WOODWALL     = 0x00000004,
    DSFX_I3DL2_MATERIAL_PRESET_BRICKWALL    = 0x00000005,
    DSFX_I3DL2_MATERIAL_PRESET_STONEWALL    = 0x00000006,
    DSFX_I3DL2_MATERIAL_PRESET_CURTAIN      = 0x00000007,
}

enum : int
{
    DSFX_I3DL2_ENVIRONMENT_PRESET_GENERIC         = 0x00000001,
    DSFX_I3DL2_ENVIRONMENT_PRESET_PADDEDCELL      = 0x00000002,
    DSFX_I3DL2_ENVIRONMENT_PRESET_ROOM            = 0x00000003,
    DSFX_I3DL2_ENVIRONMENT_PRESET_BATHROOM        = 0x00000004,
    DSFX_I3DL2_ENVIRONMENT_PRESET_LIVINGROOM      = 0x00000005,
    DSFX_I3DL2_ENVIRONMENT_PRESET_STONEROOM       = 0x00000006,
    DSFX_I3DL2_ENVIRONMENT_PRESET_AUDITORIUM      = 0x00000007,
    DSFX_I3DL2_ENVIRONMENT_PRESET_CONCERTHALL     = 0x00000008,
    DSFX_I3DL2_ENVIRONMENT_PRESET_CAVE            = 0x00000009,
    DSFX_I3DL2_ENVIRONMENT_PRESET_ARENA           = 0x0000000a,
    DSFX_I3DL2_ENVIRONMENT_PRESET_HANGAR          = 0x0000000b,
    DSFX_I3DL2_ENVIRONMENT_PRESET_CARPETEDHALLWAY = 0x0000000c,
    DSFX_I3DL2_ENVIRONMENT_PRESET_HALLWAY         = 0x0000000d,
    DSFX_I3DL2_ENVIRONMENT_PRESET_STONECORRIDOR   = 0x0000000e,
    DSFX_I3DL2_ENVIRONMENT_PRESET_ALLEY           = 0x0000000f,
    DSFX_I3DL2_ENVIRONMENT_PRESET_FOREST          = 0x00000010,
    DSFX_I3DL2_ENVIRONMENT_PRESET_CITY            = 0x00000011,
    DSFX_I3DL2_ENVIRONMENT_PRESET_MOUNTAINS       = 0x00000012,
    DSFX_I3DL2_ENVIRONMENT_PRESET_QUARRY          = 0x00000013,
    DSFX_I3DL2_ENVIRONMENT_PRESET_PLAIN           = 0x00000014,
    DSFX_I3DL2_ENVIRONMENT_PRESET_PARKINGLOT      = 0x00000015,
    DSFX_I3DL2_ENVIRONMENT_PRESET_SEWERPIPE       = 0x00000016,
    DSFX_I3DL2_ENVIRONMENT_PRESET_UNDERWATER      = 0x00000017,
    DSFX_I3DL2_ENVIRONMENT_PRESET_SMALLROOM       = 0x00000018,
    DSFX_I3DL2_ENVIRONMENT_PRESET_MEDIUMROOM      = 0x00000019,
    DSFX_I3DL2_ENVIRONMENT_PRESET_LARGEROOM       = 0x0000001a,
    DSFX_I3DL2_ENVIRONMENT_PRESET_MEDIUMHALL      = 0x0000001b,
    DSFX_I3DL2_ENVIRONMENT_PRESET_LARGEHALL       = 0x0000001c,
    DSFX_I3DL2_ENVIRONMENT_PRESET_PLATE           = 0x0000001d,
}

// Callbacks

alias FNAPONOTIFICATIONCALLBACK = HRESULT function(APO_REG_PROPERTIES* pProperties, void* pvRefData);
alias LPDSENUMCALLBACKA = BOOL function(GUID* param0, const(char)* param1, const(char)* param2, void* param3);
alias LPDSENUMCALLBACKW = BOOL function(GUID* param0, const(wchar)* param1, const(wchar)* param2, void* param3);

// Structs


struct UNCOMPRESSEDAUDIOFORMAT
{
    GUID  guidFormatType;
    uint  dwSamplesPerFrame;
    uint  dwBytesPerSampleContainer;
    uint  dwValidBitsPerSample;
    float fFramesPerSecond;
    uint  dwChannelMask;
}

struct APO_CONNECTION_DESCRIPTOR
{
    APO_CONNECTION_BUFFER_TYPE Type;
    size_t          pBuffer;
    uint            u32MaxFrameCount;
    IAudioMediaType pFormat;
    uint            u32Signature;
}

struct APO_REG_PROPERTIES
{
    GUID        clsid;
    APO_FLAG    Flags;
    ushort[256] szFriendlyName;
    ushort[256] szCopyrightInfo;
    uint        u32MajorVersion;
    uint        u32MinorVersion;
    uint        u32MinInputConnections;
    uint        u32MaxInputConnections;
    uint        u32MinOutputConnections;
    uint        u32MaxOutputConnections;
    uint        u32MaxInstances;
    uint        u32NumAPOInterfaces;
    GUID[1]     iidAPOInterfaceList;
}

struct APOInitBaseStruct
{
    uint cbSize;
    GUID clsid;
}

struct APOInitSystemEffects
{
    APOInitBaseStruct   APOInit;
    IPropertyStore      pAPOEndpointProperties;
    IPropertyStore      pAPOSystemEffectsProperties;
    void*               pReserved;
    IMMDeviceCollection pDeviceCollection;
}

struct APOInitSystemEffects2
{
    APOInitBaseStruct   APOInit;
    IPropertyStore      pAPOEndpointProperties;
    IPropertyStore      pAPOSystemEffectsProperties;
    void*               pReserved;
    IMMDeviceCollection pDeviceCollection;
    uint                nSoftwareIoDeviceInCollection;
    uint                nSoftwareIoConnectorIndex;
    GUID                AudioProcessingMode;
    BOOL                InitializeForDiscoveryOnly;
}

struct AudioFXExtensionParams
{
    LPARAM         AddPageParam;
    const(wchar)*  pwstrEndpointID;
    IPropertyStore pFxProperties;
}

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

struct POOLTABLE
{
    uint cbSize;
    uint cCues;
}

struct _rwsmp
{
    uint   cbSize;
    ushort usUnityNote;
    short  sFineTune;
    int    lAttenuation;
    uint   fulOptions;
    uint   cSampleLoops;
}

struct _rloop
{
    uint cbSize;
    uint ulType;
    uint ulStart;
    uint ulLength;
}

struct DMUS_DOWNLOADINFO
{
    uint dwDLType;
    uint dwDLId;
    uint dwNumOffsetTableEntries;
    uint cbSize;
}

struct DMUS_OFFSETTABLE
{
    uint[1] ulOffsetTable;
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
    RGNRANGE  RangeKey;
    RGNRANGE  RangeVelocity;
    ushort    fusOptions;
    ushort    usKeyGroup;
    uint      ulRegionArtIdx;
    uint      ulNextRegionIdx;
    uint      ulFirstExtCkIdx;
    WAVELINK  WaveLink;
    _rwsmp    WSMP;
    _rloop[1] WLOOP;
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

struct DMUS_EXTENSIONCHUNK
{
    uint     cbSize;
    uint     ulNextExtCkIdx;
    uint     ExtCkID;
    ubyte[4] byExtCk;
}

struct DMUS_COPYRIGHT
{
    uint     cbSize;
    ubyte[4] byCopyright;
}

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

struct DSCAPS
{
    uint dwSize;
    uint dwFlags;
    uint dwMinSecondarySampleRate;
    uint dwMaxSecondarySampleRate;
    uint dwPrimaryBuffers;
    uint dwMaxHwMixingAllBuffers;
    uint dwMaxHwMixingStaticBuffers;
    uint dwMaxHwMixingStreamingBuffers;
    uint dwFreeHwMixingAllBuffers;
    uint dwFreeHwMixingStaticBuffers;
    uint dwFreeHwMixingStreamingBuffers;
    uint dwMaxHw3DAllBuffers;
    uint dwMaxHw3DStaticBuffers;
    uint dwMaxHw3DStreamingBuffers;
    uint dwFreeHw3DAllBuffers;
    uint dwFreeHw3DStaticBuffers;
    uint dwFreeHw3DStreamingBuffers;
    uint dwTotalHwMemBytes;
    uint dwFreeHwMemBytes;
    uint dwMaxContigFreeHwMemBytes;
    uint dwUnlockTransferRateHwBuffers;
    uint dwPlayCpuOverheadSwBuffers;
    uint dwReserved1;
    uint dwReserved2;
}

struct DSBCAPS
{
    uint dwSize;
    uint dwFlags;
    uint dwBufferBytes;
    uint dwUnlockTransferRate;
    uint dwPlayCpuOverhead;
}

struct DSEFFECTDESC
{
    uint   dwSize;
    uint   dwFlags;
    GUID   guidDSFXClass;
    size_t dwReserved1;
    size_t dwReserved2;
}

struct DSCEFFECTDESC
{
    uint dwSize;
    uint dwFlags;
    GUID guidDSCFXClass;
    GUID guidDSCFXInstance;
    uint dwReserved1;
    uint dwReserved2;
}

struct DSBUFFERDESC
{
    uint          dwSize;
    uint          dwFlags;
    uint          dwBufferBytes;
    uint          dwReserved;
    WAVEFORMATEX* lpwfxFormat;
    GUID          guid3DAlgorithm;
}

struct DSBUFFERDESC1
{
    uint          dwSize;
    uint          dwFlags;
    uint          dwBufferBytes;
    uint          dwReserved;
    WAVEFORMATEX* lpwfxFormat;
}

struct DS3DBUFFER
{
    uint      dwSize;
    D3DVECTOR vPosition;
    D3DVECTOR vVelocity;
    uint      dwInsideConeAngle;
    uint      dwOutsideConeAngle;
    D3DVECTOR vConeOrientation;
    int       lConeOutsideVolume;
    float     flMinDistance;
    float     flMaxDistance;
    uint      dwMode;
}

struct DS3DLISTENER
{
    uint      dwSize;
    D3DVECTOR vPosition;
    D3DVECTOR vVelocity;
    D3DVECTOR vOrientFront;
    D3DVECTOR vOrientTop;
    float     flDistanceFactor;
    float     flRolloffFactor;
    float     flDopplerFactor;
}

struct DSCCAPS
{
    uint dwSize;
    uint dwFlags;
    uint dwFormats;
    uint dwChannels;
}

struct DSCBUFFERDESC1
{
    uint          dwSize;
    uint          dwFlags;
    uint          dwBufferBytes;
    uint          dwReserved;
    WAVEFORMATEX* lpwfxFormat;
}

struct DSCBUFFERDESC
{
    uint           dwSize;
    uint           dwFlags;
    uint           dwBufferBytes;
    uint           dwReserved;
    WAVEFORMATEX*  lpwfxFormat;
    uint           dwFXCount;
    DSCEFFECTDESC* lpDSCFXDesc;
}

struct DSCBCAPS
{
    uint dwSize;
    uint dwFlags;
    uint dwBufferBytes;
    uint dwReserved;
}

struct DSBPOSITIONNOTIFY
{
    uint   dwOffset;
    HANDLE hEventNotify;
}

struct DSFXGargle
{
    uint dwRateHz;
    uint dwWaveShape;
}

struct DSFXChorus
{
    float fWetDryMix;
    float fDepth;
    float fFeedback;
    float fFrequency;
    int   lWaveform;
    float fDelay;
    int   lPhase;
}

struct DSFXFlanger
{
    float fWetDryMix;
    float fDepth;
    float fFeedback;
    float fFrequency;
    int   lWaveform;
    float fDelay;
    int   lPhase;
}

struct DSFXEcho
{
    float fWetDryMix;
    float fFeedback;
    float fLeftDelay;
    float fRightDelay;
    int   lPanDelay;
}

struct DSFXDistortion
{
    float fGain;
    float fEdge;
    float fPostEQCenterFrequency;
    float fPostEQBandwidth;
    float fPreLowpassCutoff;
}

struct DSFXCompressor
{
    float fGain;
    float fAttack;
    float fRelease;
    float fThreshold;
    float fRatio;
    float fPredelay;
}

struct DSFXParamEq
{
    float fCenter;
    float fBandwidth;
    float fGain;
}

struct DSFXI3DL2Reverb
{
    int   lRoom;
    int   lRoomHF;
    float flRoomRolloffFactor;
    float flDecayTime;
    float flDecayHFRatio;
    int   lReflections;
    float flReflectionsDelay;
    int   lReverb;
    float flReverbDelay;
    float flDiffusion;
    float flDensity;
    float flHFReference;
}

struct DSFXWavesReverb
{
    float fInGain;
    float fReverbMix;
    float fReverbTime;
    float fHighFreqRTRatio;
}

struct DSCFXAec
{
    BOOL fEnable;
    BOOL fNoiseFill;
    uint dwMode;
}

struct DSCFXNoiseSuppress
{
    BOOL fEnable;
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
    uint        dwSize;
    uint        dwFlags;
    GUID        guidPort;
    uint        dwClass;
    uint        dwType;
    uint        dwMemorySize;
    uint        dwMaxChannelGroups;
    uint        dwMaxVoices;
    uint        dwMaxAudioChannels;
    uint        dwEffectFlags;
    ushort[128] wszDescription;
}

struct _DMUS_PORTPARAMS
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
    ushort[128]    wszDescription;
}

struct DMUS_CLOCKINFO8
{
    uint           dwSize;
    DMUS_CLOCKTYPE ctType;
    GUID           guidClock;
    ushort[128]    wszDescription;
    uint           dwFlags;
}

struct DMUS_VOICE_STATE
{
    BOOL  bExists;
    ulong spPosition;
}

struct KSP_PINMODE
{
    KSP_PIN PinProperty;
    GUID    AudioProcessingMode;
}

struct MDEVICECAPSEX
{
align (1):
    uint  cbSize;
    void* pCaps;
}

struct MIDIOPENDESC
{
align (1):
    ptrdiff_t hMidi;
    size_t    dwCallback;
    size_t    dwInstance;
    size_t    dnDevNode;
    uint      cIds;
    midiopenstrmid_tag[1] rgIds;
}

// Functions

@DllImport("DSOUND")
HRESULT DirectSoundCreate(GUID* pcGuidDevice, IDirectSound* ppDS, IUnknown pUnkOuter);

@DllImport("DSOUND")
HRESULT DirectSoundEnumerateA(LPDSENUMCALLBACKA pDSEnumCallback, void* pContext);

@DllImport("DSOUND")
HRESULT DirectSoundEnumerateW(LPDSENUMCALLBACKW pDSEnumCallback, void* pContext);

@DllImport("DSOUND")
HRESULT DirectSoundCaptureCreate(GUID* pcGuidDevice, IDirectSoundCapture* ppDSC, IUnknown pUnkOuter);

@DllImport("DSOUND")
HRESULT DirectSoundCaptureEnumerateA(LPDSENUMCALLBACKA pDSEnumCallback, void* pContext);

@DllImport("DSOUND")
HRESULT DirectSoundCaptureEnumerateW(LPDSENUMCALLBACKW pDSEnumCallback, void* pContext);

@DllImport("DSOUND")
HRESULT DirectSoundCreate8(GUID* pcGuidDevice, IDirectSound8* ppDS8, IUnknown pUnkOuter);

@DllImport("DSOUND")
HRESULT DirectSoundCaptureCreate8(GUID* pcGuidDevice, IDirectSoundCapture* ppDSC8, IUnknown pUnkOuter);

@DllImport("DSOUND")
HRESULT DirectSoundFullDuplexCreate(GUID* pcGuidCaptureDevice, GUID* pcGuidRenderDevice, 
                                    DSCBUFFERDESC* pcDSCBufferDesc, DSBUFFERDESC* pcDSBufferDesc, HWND hWnd, 
                                    uint dwLevel, IDirectSoundFullDuplex* ppDSFD, 
                                    IDirectSoundCaptureBuffer8* ppDSCBuffer8, IDirectSoundBuffer8* ppDSBuffer8, 
                                    IUnknown pUnkOuter);


// Interfaces

@GUID("0B217A72-16B8-4A4D-BDED-F9D6BBEDCD8F")
struct KSPROPSETID_AudioEffectsDiscovery;

@GUID("4E997F73-B71F-4798-873B-ED7DFCF15B4D")
interface IAudioMediaType : IUnknown
{
    HRESULT IsCompressedFormat(int* pfCompressed);
    HRESULT IsEqual(IAudioMediaType pIAudioType, uint* pdwFlags);
    WAVEFORMATEX* GetAudioFormat();
    HRESULT GetUncompressedAudioFormat(UNCOMPRESSEDAUDIOFORMAT* pUncompressedAudioFormat);
}

@GUID("9E1D6A6D-DDBC-4E95-A4C7-AD64BA37846C")
interface IAudioProcessingObjectRT : IUnknown
{
    void APOProcess(uint u32NumInputConnections, APO_CONNECTION_PROPERTY** ppInputConnections, 
                    uint u32NumOutputConnections, APO_CONNECTION_PROPERTY** ppOutputConnections);
    uint CalcInputFrames(uint u32OutputFrameCount);
    uint CalcOutputFrames(uint u32InputFrameCount);
}

@GUID("7BA1DB8F-78AD-49CD-9591-F79D80A17C81")
interface IAudioProcessingObjectVBR : IUnknown
{
    HRESULT CalcMaxInputFrames(uint u32MaxOutputFrameCount, uint* pu32InputFrameCount);
    HRESULT CalcMaxOutputFrames(uint u32MaxInputFrameCount, uint* pu32OutputFrameCount);
}

@GUID("0E5ED805-ABA6-49C3-8F9A-2B8C889C4FA8")
interface IAudioProcessingObjectConfiguration : IUnknown
{
    HRESULT LockForProcess(uint u32NumInputConnections, APO_CONNECTION_DESCRIPTOR** ppInputConnections, 
                           uint u32NumOutputConnections, APO_CONNECTION_DESCRIPTOR** ppOutputConnections);
    HRESULT UnlockForProcess();
}

@GUID("FD7F2B29-24D0-4B5C-B177-592C39F9CA10")
interface IAudioProcessingObject : IUnknown
{
    HRESULT Reset();
    HRESULT GetLatency(long* pTime);
    HRESULT GetRegistrationProperties(APO_REG_PROPERTIES** ppRegProps);
    HRESULT Initialize(uint cbDataSize, char* pbyData);
    HRESULT IsInputFormatSupported(IAudioMediaType pOppositeFormat, IAudioMediaType pRequestedInputFormat, 
                                   IAudioMediaType* ppSupportedInputFormat);
    HRESULT IsOutputFormatSupported(IAudioMediaType pOppositeFormat, IAudioMediaType pRequestedOutputFormat, 
                                    IAudioMediaType* ppSupportedOutputFormat);
    HRESULT GetInputChannelCount(uint* pu32ChannelCount);
}

@GUID("98F37DAC-D0B6-49F5-896A-AA4D169A4C48")
interface IAudioDeviceModulesClient : IUnknown
{
    HRESULT SetAudioDeviceModulesManager(IUnknown pAudioDeviceModulesManager);
}

@GUID("5FA00F27-ADD6-499A-8A9D-6B98521FA75B")
interface IAudioSystemEffects : IUnknown
{
}

@GUID("BAFE99D2-7436-44CE-9E0E-4D89AFBFFF56")
interface IAudioSystemEffects2 : IAudioSystemEffects
{
    HRESULT GetEffectsList(GUID** ppEffectsIds, uint* pcEffects, HANDLE Event);
}

@GUID("B1176E34-BB7F-4F05-BEBD-1B18A534E097")
interface IAudioSystemEffectsCustomFormats : IUnknown
{
    HRESULT GetFormatCount(uint* pcFormats);
    HRESULT GetFormat(uint nFormat, IAudioMediaType* ppFormat);
    HRESULT GetFormatRepresentation(uint nFormat, ushort** ppwstrFormatRep);
}

interface IDirectSound : IUnknown
{
    HRESULT CreateSoundBuffer(DSBUFFERDESC* pcDSBufferDesc, IDirectSoundBuffer* ppDSBuffer, IUnknown pUnkOuter);
    HRESULT GetCaps(DSCAPS* pDSCaps);
    HRESULT DuplicateSoundBuffer(IDirectSoundBuffer pDSBufferOriginal, IDirectSoundBuffer* ppDSBufferDuplicate);
    HRESULT SetCooperativeLevel(HWND hwnd, uint dwLevel);
    HRESULT Compact();
    HRESULT GetSpeakerConfig(uint* pdwSpeakerConfig);
    HRESULT SetSpeakerConfig(uint dwSpeakerConfig);
    HRESULT Initialize(GUID* pcGuidDevice);
}

interface IDirectSound8 : IDirectSound
{
    HRESULT VerifyCertification(uint* pdwCertified);
}

interface IDirectSoundBuffer : IUnknown
{
    HRESULT GetCaps(DSBCAPS* pDSBufferCaps);
    HRESULT GetCurrentPosition(uint* pdwCurrentPlayCursor, uint* pdwCurrentWriteCursor);
    HRESULT GetFormat(char* pwfxFormat, uint dwSizeAllocated, uint* pdwSizeWritten);
    HRESULT GetVolume(int* plVolume);
    HRESULT GetPan(int* plPan);
    HRESULT GetFrequency(uint* pdwFrequency);
    HRESULT GetStatus(uint* pdwStatus);
    HRESULT Initialize(IDirectSound pDirectSound, DSBUFFERDESC* pcDSBufferDesc);
    HRESULT Lock(uint dwOffset, uint dwBytes, void** ppvAudioPtr1, uint* pdwAudioBytes1, void** ppvAudioPtr2, 
                 uint* pdwAudioBytes2, uint dwFlags);
    HRESULT Play(uint dwReserved1, uint dwPriority, uint dwFlags);
    HRESULT SetCurrentPosition(uint dwNewPosition);
    HRESULT SetFormat(WAVEFORMATEX* pcfxFormat);
    HRESULT SetVolume(int lVolume);
    HRESULT SetPan(int lPan);
    HRESULT SetFrequency(uint dwFrequency);
    HRESULT Stop();
    HRESULT Unlock(char* pvAudioPtr1, uint dwAudioBytes1, char* pvAudioPtr2, uint dwAudioBytes2);
    HRESULT Restore();
}

interface IDirectSoundBuffer8 : IDirectSoundBuffer
{
    HRESULT SetFX(uint dwEffectsCount, char* pDSFXDesc, char* pdwResultCodes);
    HRESULT AcquireResources(uint dwFlags, uint dwEffectsCount, char* pdwResultCodes);
    HRESULT GetObjectInPath(const(GUID)* rguidObject, uint dwIndex, const(GUID)* rguidInterface, void** ppObject);
}

interface IDirectSound3DListener : IUnknown
{
    HRESULT GetAllParameters(DS3DLISTENER* pListener);
    HRESULT GetDistanceFactor(float* pflDistanceFactor);
    HRESULT GetDopplerFactor(float* pflDopplerFactor);
    HRESULT GetOrientation(D3DVECTOR* pvOrientFront, D3DVECTOR* pvOrientTop);
    HRESULT GetPosition(D3DVECTOR* pvPosition);
    HRESULT GetRolloffFactor(float* pflRolloffFactor);
    HRESULT GetVelocity(D3DVECTOR* pvVelocity);
    HRESULT SetAllParameters(DS3DLISTENER* pcListener, uint dwApply);
    HRESULT SetDistanceFactor(float flDistanceFactor, uint dwApply);
    HRESULT SetDopplerFactor(float flDopplerFactor, uint dwApply);
    HRESULT SetOrientation(float xFront, float yFront, float zFront, float xTop, float yTop, float zTop, 
                           uint dwApply);
    HRESULT SetPosition(float x, float y, float z, uint dwApply);
    HRESULT SetRolloffFactor(float flRolloffFactor, uint dwApply);
    HRESULT SetVelocity(float x, float y, float z, uint dwApply);
    HRESULT CommitDeferredSettings();
}

interface IDirectSound3DBuffer : IUnknown
{
    HRESULT GetAllParameters(DS3DBUFFER* pDs3dBuffer);
    HRESULT GetConeAngles(uint* pdwInsideConeAngle, uint* pdwOutsideConeAngle);
    HRESULT GetConeOrientation(D3DVECTOR* pvOrientation);
    HRESULT GetConeOutsideVolume(int* plConeOutsideVolume);
    HRESULT GetMaxDistance(float* pflMaxDistance);
    HRESULT GetMinDistance(float* pflMinDistance);
    HRESULT GetMode(uint* pdwMode);
    HRESULT GetPosition(D3DVECTOR* pvPosition);
    HRESULT GetVelocity(D3DVECTOR* pvVelocity);
    HRESULT SetAllParameters(DS3DBUFFER* pcDs3dBuffer, uint dwApply);
    HRESULT SetConeAngles(uint dwInsideConeAngle, uint dwOutsideConeAngle, uint dwApply);
    HRESULT SetConeOrientation(float x, float y, float z, uint dwApply);
    HRESULT SetConeOutsideVolume(int lConeOutsideVolume, uint dwApply);
    HRESULT SetMaxDistance(float flMaxDistance, uint dwApply);
    HRESULT SetMinDistance(float flMinDistance, uint dwApply);
    HRESULT SetMode(uint dwMode, uint dwApply);
    HRESULT SetPosition(float x, float y, float z, uint dwApply);
    HRESULT SetVelocity(float x, float y, float z, uint dwApply);
}

interface IDirectSoundCapture : IUnknown
{
    HRESULT CreateCaptureBuffer(DSCBUFFERDESC* pcDSCBufferDesc, IDirectSoundCaptureBuffer* ppDSCBuffer, 
                                IUnknown pUnkOuter);
    HRESULT GetCaps(DSCCAPS* pDSCCaps);
    HRESULT Initialize(GUID* pcGuidDevice);
}

interface IDirectSoundCaptureBuffer : IUnknown
{
    HRESULT GetCaps(DSCBCAPS* pDSCBCaps);
    HRESULT GetCurrentPosition(uint* pdwCapturePosition, uint* pdwReadPosition);
    HRESULT GetFormat(char* pwfxFormat, uint dwSizeAllocated, uint* pdwSizeWritten);
    HRESULT GetStatus(uint* pdwStatus);
    HRESULT Initialize(IDirectSoundCapture pDirectSoundCapture, DSCBUFFERDESC* pcDSCBufferDesc);
    HRESULT Lock(uint dwOffset, uint dwBytes, void** ppvAudioPtr1, uint* pdwAudioBytes1, void** ppvAudioPtr2, 
                 uint* pdwAudioBytes2, uint dwFlags);
    HRESULT Start(uint dwFlags);
    HRESULT Stop();
    HRESULT Unlock(char* pvAudioPtr1, uint dwAudioBytes1, char* pvAudioPtr2, uint dwAudioBytes2);
}

interface IDirectSoundCaptureBuffer8 : IDirectSoundCaptureBuffer
{
    HRESULT GetObjectInPath(const(GUID)* rguidObject, uint dwIndex, const(GUID)* rguidInterface, void** ppObject);
    HRESULT GetFXStatus(uint dwEffectsCount, char* pdwFXStatus);
}

interface IDirectSoundNotify : IUnknown
{
    HRESULT SetNotificationPositions(uint dwPositionNotifies, char* pcPositionNotifies);
}

interface IDirectSoundFXGargle : IUnknown
{
    HRESULT SetAllParameters(DSFXGargle* pcDsFxGargle);
    HRESULT GetAllParameters(DSFXGargle* pDsFxGargle);
}

interface IDirectSoundFXChorus : IUnknown
{
    HRESULT SetAllParameters(DSFXChorus* pcDsFxChorus);
    HRESULT GetAllParameters(DSFXChorus* pDsFxChorus);
}

interface IDirectSoundFXFlanger : IUnknown
{
    HRESULT SetAllParameters(DSFXFlanger* pcDsFxFlanger);
    HRESULT GetAllParameters(DSFXFlanger* pDsFxFlanger);
}

interface IDirectSoundFXEcho : IUnknown
{
    HRESULT SetAllParameters(DSFXEcho* pcDsFxEcho);
    HRESULT GetAllParameters(DSFXEcho* pDsFxEcho);
}

interface IDirectSoundFXDistortion : IUnknown
{
    HRESULT SetAllParameters(DSFXDistortion* pcDsFxDistortion);
    HRESULT GetAllParameters(DSFXDistortion* pDsFxDistortion);
}

interface IDirectSoundFXCompressor : IUnknown
{
    HRESULT SetAllParameters(DSFXCompressor* pcDsFxCompressor);
    HRESULT GetAllParameters(DSFXCompressor* pDsFxCompressor);
}

interface IDirectSoundFXParamEq : IUnknown
{
    HRESULT SetAllParameters(DSFXParamEq* pcDsFxParamEq);
    HRESULT GetAllParameters(DSFXParamEq* pDsFxParamEq);
}

interface IDirectSoundFXI3DL2Reverb : IUnknown
{
    HRESULT SetAllParameters(DSFXI3DL2Reverb* pcDsFxI3DL2Reverb);
    HRESULT GetAllParameters(DSFXI3DL2Reverb* pDsFxI3DL2Reverb);
    HRESULT SetPreset(uint dwPreset);
    HRESULT GetPreset(uint* pdwPreset);
    HRESULT SetQuality(int lQuality);
    HRESULT GetQuality(int* plQuality);
}

interface IDirectSoundFXWavesReverb : IUnknown
{
    HRESULT SetAllParameters(DSFXWavesReverb* pcDsFxWavesReverb);
    HRESULT GetAllParameters(DSFXWavesReverb* pDsFxWavesReverb);
}

interface IDirectSoundCaptureFXAec : IUnknown
{
    HRESULT SetAllParameters(DSCFXAec* pDscFxAec);
    HRESULT GetAllParameters(DSCFXAec* pDscFxAec);
    HRESULT GetStatus(uint* pdwStatus);
    HRESULT Reset();
}

interface IDirectSoundCaptureFXNoiseSuppress : IUnknown
{
    HRESULT SetAllParameters(DSCFXNoiseSuppress* pcDscFxNoiseSuppress);
    HRESULT GetAllParameters(DSCFXNoiseSuppress* pDscFxNoiseSuppress);
    HRESULT Reset();
}

interface IDirectSoundFullDuplex : IUnknown
{
    HRESULT Initialize(GUID* pCaptureGuid, GUID* pRenderGuid, DSCBUFFERDESC* lpDscBufferDesc, 
                       DSBUFFERDESC* lpDsBufferDesc, HWND hWnd, uint dwLevel, 
                       IDirectSoundCaptureBuffer8* lplpDirectSoundCaptureBuffer8, 
                       IDirectSoundBuffer8* lplpDirectSoundBuffer8);
}

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

interface IDirectMusic8 : IDirectMusic
{
    HRESULT SetExternalMasterClock(IReferenceClock pClock);
}

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

interface IDirectMusicInstrument : IUnknown
{
    HRESULT GetPatch(uint* pdwPatch);
    HRESULT SetPatch(uint dwPatch);
}

interface IDirectMusicDownloadedInstrument : IUnknown
{
}

interface IDirectMusicCollection : IUnknown
{
    HRESULT GetInstrument(uint dwPatch, IDirectMusicInstrument* ppInstrument);
    HRESULT EnumInstrument(uint dwIndex, uint* pdwPatch, const(wchar)* pwszName, uint dwNameLen);
}

interface IDirectMusicDownload : IUnknown
{
    HRESULT GetBuffer(void** ppvBuffer, uint* pdwSize);
}

interface IDirectMusicPortDownload : IUnknown
{
    HRESULT GetBuffer(uint dwDLId, IDirectMusicDownload* ppIDMDownload);
    HRESULT AllocateBuffer(uint dwSize, IDirectMusicDownload* ppIDMDownload);
    HRESULT GetDLId(uint* pdwStartDLId, uint dwCount);
    HRESULT GetAppend(uint* pdwAppend);
    HRESULT Download(IDirectMusicDownload pIDMDownload);
    HRESULT Unload(IDirectMusicDownload pIDMDownload);
}

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

interface IDirectMusicThru : IUnknown
{
    HRESULT ThruChannel(uint dwSourceChannelGroup, uint dwSourceChannel, uint dwDestinationChannelGroup, 
                        uint dwDestinationChannel, IDirectMusicPort pDestinationPort);
}

interface IDirectMusicSynth : IUnknown
{
    HRESULT Open(DMUS_PORTPARAMS8* pPortParams);
    HRESULT Close();
    HRESULT SetNumChannelGroups(uint dwGroups);
    HRESULT Download(ptrdiff_t* phDownload, void* pvData, int* pbFree);
    HRESULT Unload(HANDLE hDownload, HRESULT*********** lpFreeHandle, HANDLE hUserData);
    HRESULT PlayBuffer(long rt, ubyte* pbBuffer, uint cbBuffer);
    HRESULT GetRunningStats(DMUS_SYNTHSTATS* pStats);
    HRESULT GetPortCaps(DMUS_PORTCAPS* pCaps);
    HRESULT SetMasterClock(IReferenceClock pClock);
    HRESULT GetLatencyClock(IReferenceClock* ppClock);
    HRESULT Activate(BOOL fEnable);
    HRESULT SetSynthSink(IDirectMusicSynthSink pSynthSink);
    HRESULT Render(short* pBuffer, uint dwLength, long llPosition);
    HRESULT SetChannelPriority(uint dwChannelGroup, uint dwChannel, uint dwPriority);
    HRESULT GetChannelPriority(uint dwChannelGroup, uint dwChannel, uint* pdwPriority);
    HRESULT GetFormat(WAVEFORMATEX* pWaveFormatEx, uint* pdwWaveFormatExSize);
    HRESULT GetAppend(uint* pdwAppend);
}

interface IDirectMusicSynth8 : IDirectMusicSynth
{
    HRESULT PlayVoice(long rt, uint dwVoiceId, uint dwChannelGroup, uint dwChannel, uint dwDLId, int prPitch, 
                      int vrVolume, ulong stVoiceStart, ulong stLoopStart, ulong stLoopEnd);
    HRESULT StopVoice(long rt, uint dwVoiceId);
    HRESULT GetVoiceState(uint* dwVoice, uint cbVoice, DMUS_VOICE_STATE* dwVoiceState);
    HRESULT Refresh(uint dwDownloadID, uint dwFlags);
    HRESULT AssignChannelToBuses(uint dwChannelGroup, uint dwChannel, uint* pdwBuses, uint cBuses);
}

interface IDirectMusicSynthSink : IUnknown
{
    HRESULT Init(IDirectMusicSynth pSynth);
    HRESULT SetMasterClock(IReferenceClock pClock);
    HRESULT GetLatencyClock(IReferenceClock* ppClock);
    HRESULT Activate(BOOL fEnable);
    HRESULT SampleToRefTime(long llSampleTime, long* prfTime);
    HRESULT RefTimeToSample(long rfTime, long* pllSampleTime);
    HRESULT SetDirectSound(IDirectSound pDirectSound, IDirectSoundBuffer pDirectSoundBuffer);
    HRESULT GetDesiredBufferSize(uint* pdwBufferSizeInSamples);
}

@GUID("886D8EEB-8CF2-4446-8D02-CDBA1DBDCF99")
interface IPropertyStore : IUnknown
{
    HRESULT GetCount(uint* cProps);
    HRESULT GetAt(uint iProp, PROPERTYKEY* pkey);
    HRESULT GetValue(const(PROPERTYKEY)* key, PROPVARIANT* pv);
    HRESULT SetValue(const(PROPERTYKEY)* key, const(PROPVARIANT)* propvar);
    HRESULT Commit();
}


// GUIDs

const GUID CLSID_KSPROPSETID_AudioEffectsDiscovery = GUIDOF!KSPROPSETID_AudioEffectsDiscovery;

const GUID IID_IAudioDeviceModulesClient           = GUIDOF!IAudioDeviceModulesClient;
const GUID IID_IAudioMediaType                     = GUIDOF!IAudioMediaType;
const GUID IID_IAudioProcessingObject              = GUIDOF!IAudioProcessingObject;
const GUID IID_IAudioProcessingObjectConfiguration = GUIDOF!IAudioProcessingObjectConfiguration;
const GUID IID_IAudioProcessingObjectRT            = GUIDOF!IAudioProcessingObjectRT;
const GUID IID_IAudioProcessingObjectVBR           = GUIDOF!IAudioProcessingObjectVBR;
const GUID IID_IAudioSystemEffects                 = GUIDOF!IAudioSystemEffects;
const GUID IID_IAudioSystemEffects2                = GUIDOF!IAudioSystemEffects2;
const GUID IID_IAudioSystemEffectsCustomFormats    = GUIDOF!IAudioSystemEffectsCustomFormats;
const GUID IID_IPropertyStore                      = GUIDOF!IPropertyStore;
